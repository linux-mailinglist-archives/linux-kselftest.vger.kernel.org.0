Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 641D113681
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2019 02:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfEDASv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 May 2019 20:18:51 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:30240 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfEDASu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 May 2019 20:18:50 -0400
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x440IgwS017039;
        Sat, 4 May 2019 09:18:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x440IgwS017039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556929123;
        bh=c8nPhv768vX2rH2LIPU5db7QC5zJM6dP8fcOJeANzIo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NUD8K65gHLvJKZ6CorxTZ2gHXAsg4jk31iY2vxXdYRz129hRPJllcYEW45xFD+WkC
         JfGn1+BvsJ3Dr6QoAN8FAnb5uQDnPUovVasiik2vtABKc7Hx/2O8+huNpWg7VFLr2J
         7R5j8dsEaNe4rcYaHqcNybv3IVtCPxOImiQY3ZyMTNTccNrk0FBCoF/EZwh8lJxIfz
         eqpulLbKEJyojKS7T5dKpaYp1Zl8UqhAAaSUldsTkRJaJehtQ3vW5CS9Dcy5xYbD8H
         S4tv+ektpQ2De3kFBmcIVFfQDMTFywWiPytRB/kJ1/zZyPng1H3AUtUPtGjwzUbth7
         ObNsKAU/9NhUQ==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id s30so2634161uas.8;
        Fri, 03 May 2019 17:18:42 -0700 (PDT)
X-Gm-Message-State: APjAAAX9SBTA0dcVs+af1LtlHRI8kRBvcvKBfkTkjDnnD9nId6E0PcOp
        wRarXF3CUpDznq1AgWEjWjVyalmPsIgWNyTTGg8=
X-Google-Smtp-Source: APXvYqzaIfuRwLQ1jVGvVN1riluv4VWuN/A9RqHOltcZzkIHvIML4BRzScARIh9ssE09iflt+rGQei9iEEC96FPpInc=
X-Received: by 2002:ab0:2bd8:: with SMTP id s24mr6910953uar.121.1556929121882;
 Fri, 03 May 2019 17:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190503182459.159121-1-joel@joelfernandes.org>
In-Reply-To: <20190503182459.159121-1-joel@joelfernandes.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 4 May 2019 09:18:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNATRTqh_OJcQaWfcYYYqyZ-c0u1prD17LDYwDh18z2V31Q@mail.gmail.com>
Message-ID: <CAK7LNATRTqh_OJcQaWfcYYYqyZ-c0u1prD17LDYwDh18z2V31Q@mail.gmail.com>
Subject: Re: [PATCH] kheaders: Move from proc to sysfs
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        atish patra <atishp04@gmail.com>, bpf@vger.kernel.org,
        Brendan Gregg <bgregg@netflix.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        duyuchao <yuchao.du@unisoc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org,
        Manjo Raja Rao <linux@manojrajarao.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        =?UTF-8?Q?Micha=C5=82_Gregorczyk?= <michalgr@fb.com>,
        Michal Gregorczyk <michalgr@live.com>,
        Mohammad Husain <russoue@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        Qais Yousef <qais.yousef@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Tamir Carmeli <carmeli.tamir@gmail.com>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, May 4, 2019 at 3:27 AM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> The kheaders archive consisting of the kernel headers used for compiling
> bpf programs is in /proc. However there is concern that moving it here
> will make it permanent. Let us move it to /sys/kernel as discussed [1].
>
> [1] https://lore.kernel.org/patchwork/patch/1067310/#1265969
>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> This patch applies on top of the previous patch that was applied to the
> driver tree:
> https://lore.kernel.org/patchwork/patch/1067310/
>
>  kernel/kheaders.c | 40 ++++++++++++++++------------------------


Please rename CONFIG_IKHEADERS_PROC.

Thanks.




>  1 file changed, 16 insertions(+), 24 deletions(-)
>
> diff --git a/kernel/kheaders.c b/kernel/kheaders.c
> index 70ae6052920d..6a16f8f6898d 100644
> --- a/kernel/kheaders.c
> +++ b/kernel/kheaders.c
> @@ -8,9 +8,8 @@
>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/proc_fs.h>
> +#include <linux/kobject.h>
>  #include <linux/init.h>
> -#include <linux/uaccess.h>
>
>  /*
>   * Define kernel_headers_data and kernel_headers_data_end, within which the
> @@ -31,39 +30,32 @@ extern char kernel_headers_data;
>  extern char kernel_headers_data_end;
>
>  static ssize_t
> -ikheaders_read_current(struct file *file, char __user *buf,
> -                     size_t len, loff_t *offset)
> +ikheaders_read(struct file *file,  struct kobject *kobj,
> +              struct bin_attribute *bin_attr,
> +              char *buf, loff_t off, size_t len)
>  {
> -       return simple_read_from_buffer(buf, len, offset,
> -                                      &kernel_headers_data,
> -                                      &kernel_headers_data_end -
> -                                      &kernel_headers_data);
> +       memcpy(buf, &kernel_headers_data + off, len);
> +       return len;
>  }
>
> -static const struct file_operations ikheaders_file_ops = {
> -       .read = ikheaders_read_current,
> -       .llseek = default_llseek,
> +static struct bin_attribute kheaders_attr __ro_after_init = {
> +       .attr = {
> +               .name = "kheaders.tar.xz",
> +               .mode = S_IRUGO,
> +       },
> +       .read = &ikheaders_read,
>  };
>
>  static int __init ikheaders_init(void)
>  {
> -       struct proc_dir_entry *entry;
> -
> -       /* create the current headers file */
> -       entry = proc_create("kheaders.tar.xz", S_IRUGO, NULL,
> -                           &ikheaders_file_ops);
> -       if (!entry)
> -               return -ENOMEM;
> -
> -       proc_set_size(entry,
> -                     &kernel_headers_data_end -
> -                     &kernel_headers_data);
> -       return 0;
> +       kheaders_attr.size = (&kernel_headers_data_end -
> +                             &kernel_headers_data);
> +       return sysfs_create_bin_file(kernel_kobj, &kheaders_attr);
>  }
>
>  static void __exit ikheaders_cleanup(void)
>  {
> -       remove_proc_entry("kheaders.tar.xz", NULL);
> +       sysfs_remove_bin_file(kernel_kobj, &kheaders_attr);
>  }
>
>  module_init(ikheaders_init);
> --
> 2.21.0.1020.gf2820cf01a-goog



-- 
Best Regards
Masahiro Yamada
