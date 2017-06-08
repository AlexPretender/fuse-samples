using Uno;
using Uno.Compiler.ExportTargetInterop;
using Uno.Time;

using Fuse;
using Fuse.Controls;
using Fuse.Controls.Native;
using Fuse.Scripting;

namespace Native
{
	public partial class DatePicker
	{
		static DatePicker()
		{
			ScriptClass.Register(typeof(DatePicker),
				new ScriptMethod<DatePicker>("setDate", setDate, ExecutionThread.MainThread),
				new ScriptMethod<DatePicker>("setMinDate", setDate, ExecutionThread.MainThread),
				new ScriptMethod<DatePicker>("setMaxDate", setDate, ExecutionThread.MainThread),
				new ScriptMethod<DatePicker>("getDate", getDate, ExecutionThread.JavaScript));
		}

		static void setDate(Context c, DatePicker datePicker, object[] args)
		{
			if (args.Length != 3)
			{
				Fuse.Diagnostics.UserError("DatePicker.setDate requires 3 arguments. (year, month day)", datePicker);
				return;
			}
			var dpv = datePicker.DatePickerView;
			if (dpv != null)
				dpv.SetDate(new LocalDate(Marshal.ToInt(args[0]), Marshal.ToInt(args[1]), Marshal.ToInt(args[2])));
		}

		static void setMinDate(Context c, DatePicker datePicker, object[] args)
		{
			if (args.Length != 3)
			{
				Fuse.Diagnostics.UserError("DatePicker.setMinDate requires 3 arguments. (year, month day)", datePicker);
				return;
			}
			var dpv = datePicker.DatePickerView;
			if (dpv != null)
				dpv.SetMinDate(new LocalDate(Marshal.ToInt(args[0]), Marshal.ToInt(args[1]), Marshal.ToInt(args[2])));
		}

		static void setMaxDate(Context c, DatePicker datePicker, object[] args)
		{
			if (args.Length != 3)
			{
				Fuse.Diagnostics.UserError("DatePicker.setMaxDate requires 3 arguments. (year, month day)", datePicker);
				return;
			}
			var dpv = datePicker.DatePickerView;
			if (dpv != null)
				dpv.SetMaxDate(new LocalDate(Marshal.ToInt(args[0]), Marshal.ToInt(args[1]), Marshal.ToInt(args[2])));
		}

		// TODO: this does not work since a Func cannot be called from JS when
		// mainthread is specified
		static object getDate(Context c, DatePicker datePicker, object[] args)
		{
			var dpv = datePicker.DatePickerView;
			if (dpv != null)
			{
				var d = dpv.CurrentDate;
				return new [] { d.Year, d.Month, d.Day };
			}
			return null;
		}
	}
}