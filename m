Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A05D713CB3
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2019 03:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfEEBvI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 4 May 2019 21:51:08 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:43600 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfEEBvI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 4 May 2019 21:51:08 -0400
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x451odLI015095;
        Sun, 5 May 2019 10:50:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x451odLI015095
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557021040;
        bh=HxqhNXUccAGwVFV55EiI+BIgzu6GPW9Pcu4RFLUIwGU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jVKKTnN7gGX/4LSR3iRCFynUZdWVlCDnHoTLXzAMIIAih28B7Dk4CYmbP1QjZNjwK
         FlZA+eGMERiBUNMpJIadPgl78bHf3XZFHAzM6+EDEZGlk2kJ+g0XGE00kLszfPch3O
         qe2PwWhG7tf6MGfKGRf3hBJTG9nvqQidLwCpB/YhgYQd71k0366+OpztwVoM2mmIIh
         l2vT55WKslfF2TvAWTbFnQEe6M4pGfwYKOUWlcRcS6CDfcDMpPrfrl+W4aluo5pi2J
         K4hhvjcXil40UG0fThPCXIF/qu9adtILlOHALWjbWjirGnYmiSZseBt51DOKcvRDeN
         vGnA0LBBJQ3AQ==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id n23so3409518uap.13;
        Sat, 04 May 2019 18:50:39 -0700 (PDT)
X-Gm-Message-State: APjAAAWrbyAobuHjl7nfNgbgLM6rOD76Sv2vOO372wb4zDjKQ6AnU7ww
        0Vwehnsu6oDqw/ptwkPGLpV7iqFCYWBSqDro+jQ=
X-Google-Smtp-Source: APXvYqyto4ywW4Iezc4YOr2mUelBO4Me/wMnxNfrtcwB3XD3vHe4ZMaidSA58I9jVgOGsG83g8VowvGi+NCqMERjTtU=
X-Received: by 2002:ab0:2bd8:: with SMTP id s24mr9344582uar.121.1557021038230;
 Sat, 04 May 2019 18:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190504121213.183203-1-joel@joelfernandes.org>
In-Reply-To: <20190504121213.183203-1-joel@joelfernandes.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 5 May 2019 10:50:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNASkvm0t02DykwOxB0R6h0-j83sU01c1+ERZHp-A23R23w@mail.gmail.com>
Message-ID: <CAK7LNASkvm0t02DykwOxB0R6h0-j83sU01c1+ERZHp-A23R23w@mail.gmail.com>
Subject: Re: [PATCH v2] kheaders: Move from proc to sysfs
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

On Sat, May 4, 2019 at 9:26 PM Joel Fernandes (Google)
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
> v1->v2: Fixed some kconfig nits (Masami).


My name is Masahiro, just in case.


>
>  init/Kconfig                                | 16 ++++-----
>  kernel/Makefile                             |  4 +--
>  kernel/{gen_ikh_data.sh => gen_kheaders.sh} |  2 +-
>  kernel/kheaders.c                           | 40 +++++++++------------
>  4 files changed, 26 insertions(+), 36 deletions(-)
>  rename kernel/{gen_ikh_data.sh => gen_kheaders.sh} (98%)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 26a364a95b57..c3661991b089 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -579,15 +579,13 @@ config IKCONFIG_PROC
>           This option enables access to the kernel configuration file
>           through /proc/config.gz.
>
> -config IKHEADERS_PROC
> -       tristate "Enable kernel header artifacts through /proc/kheaders.tar.xz"
> -       depends on PROC_FS
> -       help
> -         This option enables access to the kernel header and other artifacts that
> -         are generated during the build process. These can be used to build eBPF
> -         tracing programs, or similar programs.  If you build the headers as a
> -         module, a module called kheaders.ko is built which can be loaded on-demand
> -         to get access to the headers.
> +config IKHEADERS
> +       tristate "Enable kernel headers through /sys/kernel/kheaders.tar.xz"


In v1, I suggested to change "depends on PROC_FS"
to "depends on SYSFS".

fs/sysfs/ must be compiled to make this feature work.




> +       help
> +         This option enables access to the in-kernel headers that are generated during
> +         the build process. These can be used to build eBPF tracing programs,
> +         or similar programs.  If you build the headers as a module, a module called


While you are touching the help,
could you make the number of spaces
between sentences consistent?


Thanks.



> +         kheaders.ko is built which can be loaded on-demand to get access to headers.
>
>  config LOG_BUF_SHIFT
>         int "Kernel log buffer size (16 => 64KB, 17 => 128KB)"
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 12399614c350..b32a558fae2f 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -70,7 +70,7 @@ obj-$(CONFIG_UTS_NS) += utsname.o
>  obj-$(CONFIG_USER_NS) += user_namespace.o
>  obj-$(CONFIG_PID_NS) += pid_namespace.o
>  obj-$(CONFIG_IKCONFIG) += configs.o
> -obj-$(CONFIG_IKHEADERS_PROC) += kheaders.o
> +obj-$(CONFIG_IKHEADERS) += kheaders.o
>  obj-$(CONFIG_SMP) += stop_machine.o
>  obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
>  obj-$(CONFIG_AUDIT) += audit.o auditfilter.o
> @@ -126,7 +126,7 @@ $(obj)/config_data.gz: $(KCONFIG_CONFIG) FORCE
>  $(obj)/kheaders.o: $(obj)/kheaders_data.tar.xz
>
>  quiet_cmd_genikh = CHK     $(obj)/kheaders_data.tar.xz
> -cmd_genikh = $(srctree)/kernel/gen_ikh_data.sh $@
> +cmd_genikh = $(srctree)/kernel/gen_kheaders.sh $@
>  $(obj)/kheaders_data.tar.xz: FORCE
>         $(call cmd,genikh)
>
> diff --git a/kernel/gen_ikh_data.sh b/kernel/gen_kheaders.sh
> similarity index 98%
> rename from kernel/gen_ikh_data.sh
> rename to kernel/gen_kheaders.sh
> index 591a94f7b387..581b83534587 100755
> --- a/kernel/gen_ikh_data.sh
> +++ b/kernel/gen_kheaders.sh
> @@ -2,7 +2,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  # This script generates an archive consisting of kernel headers
> -# for CONFIG_IKHEADERS_PROC.
> +# for CONFIG_IKHEADERS.
>  set -e
>  spath="$(dirname "$(readlink -f "$0")")"
>  kroot="$spath/.."
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
