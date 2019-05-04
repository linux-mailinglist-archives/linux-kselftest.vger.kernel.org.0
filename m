Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7BD0139CF
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2019 14:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfEDMgy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 4 May 2019 08:36:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35138 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfEDMgy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 4 May 2019 08:36:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id t87so3718661pfa.2
        for <linux-kselftest@vger.kernel.org>; Sat, 04 May 2019 05:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PxUJTLhuZlQHBimNsUfYE4P4yJ5RwUoFbz6XIZj2VZw=;
        b=ivMR+lTIp0RIYya4X5ScTYARRXT2GVNc1GFdWwc/iifUvbjDvrK4zQkiN7CKLQY+16
         N0ECbCEc9LLqCHK3aAO2LZoRRcKacoM67BsD8RncoJuEH+NPBdhNP3ZQe5kmHcUlF2PP
         8c7E/fOaH1/UyNU/fVmgZlgXfUqNsZ1p4q4zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PxUJTLhuZlQHBimNsUfYE4P4yJ5RwUoFbz6XIZj2VZw=;
        b=P2IWKgRdnov1BehhnLYJCxmsEBJl6zpSf5scRWFv4JBLZY6jA4h0InPg4kkAzL1EzM
         +eEoocaIclZny1GrB/8z1K9okFvyRnNdyWcF38BkhiUoTgh/MQEnw4EKeIWghXKHysYm
         RnuNVoe4MOjCOVj5fobZvvEd4fJVL+fmkz/RqhFOLbKY+ssaKg2EQQUMZvJSM4HenKIJ
         fFvXw2JQnZj+I7C3Mn52lutJ7qpCvSR51bfXHpePUPSCwxts+8NP8uh63M5d+hECzsO7
         nvnd+QSSAEvyVKwM6rRz6nu5FuG42ut9nS6noivpFY1NmCuyhG+7yX1oka72RdVt6GuZ
         2CCQ==
X-Gm-Message-State: APjAAAVNbPybp7fMi/w0/Vgt7ihOMElY+k+2FDtHbnYRyICgR6RB5prX
        XX9cq2IPTX548j4EUv4JoDN2SA==
X-Google-Smtp-Source: APXvYqxiCyYBUj8FKZq7Cr2iOIpAgXz+3AbywPnfFFS8nId+wRtznx2EXa8TT/SlGTn/TFjFri+vYA==
X-Received: by 2002:a63:c243:: with SMTP id l3mr18175178pgg.448.1556973413050;
        Sat, 04 May 2019 05:36:53 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h189sm9544928pfc.125.2019.05.04.05.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 May 2019 05:36:51 -0700 (PDT)
Date:   Sat, 4 May 2019 08:36:50 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, atishp04@gmail.com,
        bpf@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>, dancol@google.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dan Williams <dan.j.williams@intel.com>,
        dietmar.eggemann@arm.com, duyuchao <yuchao.du@unisoc.com>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Manjo Raja Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        =?utf-8?Q?Micha=C5=82?= Gregorczyk <michalgr@fb.com>,
        Michal Gregorczyk <michalgr@live.com>,
        Mohammad Husain <russoue@gmail.com>,
        Olof Johansson <olof@lixom.net>, qais.yousef@arm.com,
        rdunlap@infradead.org, Shuah Khan <shuah@kernel.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Tamir Carmeli <carmeli.tamir@gmail.com>, yhs@fb.com
Subject: Re: [PATCH v2] kheaders: Move from proc to sysfs
Message-ID: <20190504123650.GA229151@google.com>
References: <20190504121213.183203-1-joel@joelfernandes.org>
 <20190504122158.GA23535@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190504122158.GA23535@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, May 04, 2019 at 02:21:58PM +0200, Greg KH wrote:
> On Sat, May 04, 2019 at 08:12:13AM -0400, Joel Fernandes (Google) wrote:
> > The kheaders archive consisting of the kernel headers used for compiling
> > bpf programs is in /proc. However there is concern that moving it here
> > will make it permanent. Let us move it to /sys/kernel as discussed [1].
> > 
> > [1] https://lore.kernel.org/patchwork/patch/1067310/#1265969
> > 
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> > This patch applies on top of the previous patch that was applied to the
> > driver tree:
> > https://lore.kernel.org/patchwork/patch/1067310/
> > 
> > v1->v2: Fixed some kconfig nits (Masami).
> > 
> >  init/Kconfig                                | 16 ++++-----
> >  kernel/Makefile                             |  4 +--
> >  kernel/{gen_ikh_data.sh => gen_kheaders.sh} |  2 +-
> >  kernel/kheaders.c                           | 40 +++++++++------------
> >  4 files changed, 26 insertions(+), 36 deletions(-)
> >  rename kernel/{gen_ikh_data.sh => gen_kheaders.sh} (98%)
> > 
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 26a364a95b57..c3661991b089 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -579,15 +579,13 @@ config IKCONFIG_PROC
> >  	  This option enables access to the kernel configuration file
> >  	  through /proc/config.gz.
> >  
> > -config IKHEADERS_PROC
> > -	tristate "Enable kernel header artifacts through /proc/kheaders.tar.xz"
> > -	depends on PROC_FS
> > -	help
> > -	  This option enables access to the kernel header and other artifacts that
> > -	  are generated during the build process. These can be used to build eBPF
> > -	  tracing programs, or similar programs.  If you build the headers as a
> > -	  module, a module called kheaders.ko is built which can be loaded on-demand
> > -	  to get access to the headers.
> > +config IKHEADERS
> > +	tristate "Enable kernel headers through /sys/kernel/kheaders.tar.xz"
> > +	help
> > +	  This option enables access to the in-kernel headers that are generated during
> > +	  the build process. These can be used to build eBPF tracing programs,
> > +	  or similar programs.  If you build the headers as a module, a module called
> > +	  kheaders.ko is built which can be loaded on-demand to get access to headers.
> >  
> >  config LOG_BUF_SHIFT
> >  	int "Kernel log buffer size (16 => 64KB, 17 => 128KB)"
> > diff --git a/kernel/Makefile b/kernel/Makefile
> > index 12399614c350..b32a558fae2f 100644
> > --- a/kernel/Makefile
> > +++ b/kernel/Makefile
> > @@ -70,7 +70,7 @@ obj-$(CONFIG_UTS_NS) += utsname.o
> >  obj-$(CONFIG_USER_NS) += user_namespace.o
> >  obj-$(CONFIG_PID_NS) += pid_namespace.o
> >  obj-$(CONFIG_IKCONFIG) += configs.o
> > -obj-$(CONFIG_IKHEADERS_PROC) += kheaders.o
> > +obj-$(CONFIG_IKHEADERS) += kheaders.o
> 
> Good in changing the config name, I hadn't thought of that.
> 
> > diff --git a/kernel/gen_ikh_data.sh b/kernel/gen_kheaders.sh
> > similarity index 98%
> > rename from kernel/gen_ikh_data.sh
> > rename to kernel/gen_kheaders.sh
> 
> Same here, nice.

Thanks.

> > -static const struct file_operations ikheaders_file_ops = {
> > -	.read = ikheaders_read_current,
> > -	.llseek = default_llseek,
> > +static struct bin_attribute kheaders_attr __ro_after_init = {
> 
> Minor nit, are you sure about __ro_after_init for an attribute
> structure?  Is it even needed?

Yes, because after init, we don't need to change it, so it makes it more
robust to accidental overwrite. We change it on init because we have to
calculate the size of the archive. I was following this from kernel/ksysfs.c
actually.

I have recently encountered this mechanism in the module loader as well while
doing an RCU patch. The module loader post init will mark the page as
read-only and any writes to it will fault. These variables will be placed in
a ".data.ro_after_init" or a similarly named section in the module ELF.

> But, you should change S_IRUGO to the correct octal number, checkpatch
> should have barfed on this change.

fixed, below is the updated patch inline, thanks!

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v3] kheaders: Move from proc to sysfs

The kheaders archive consisting of the kernel headers used for compiling
bpf programs is in /proc. However there is concern that moving it here
will make it permanent. Let us move it to /sys/kernel as discussed [1].

[1] https://lore.kernel.org/patchwork/patch/1067310/#1265969

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
This patch applies on top of the previous patch that was applied to the
driver tree:
https://lore.kernel.org/patchwork/patch/1067310/

v2->v3: Fixed sysfs file mode nit (Greg).
v1->v2: Fixed some kconfig nits (Masami).

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 init/Kconfig                                | 16 ++++-----
 kernel/Makefile                             |  4 +--
 kernel/{gen_ikh_data.sh => gen_kheaders.sh} |  2 +-
 kernel/kheaders.c                           | 40 +++++++++------------
 4 files changed, 26 insertions(+), 36 deletions(-)
 rename kernel/{gen_ikh_data.sh => gen_kheaders.sh} (98%)

diff --git a/init/Kconfig b/init/Kconfig
index 26a364a95b57..c3661991b089 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -579,15 +579,13 @@ config IKCONFIG_PROC
 	  This option enables access to the kernel configuration file
 	  through /proc/config.gz.
 
-config IKHEADERS_PROC
-	tristate "Enable kernel header artifacts through /proc/kheaders.tar.xz"
-	depends on PROC_FS
-	help
-	  This option enables access to the kernel header and other artifacts that
-	  are generated during the build process. These can be used to build eBPF
-	  tracing programs, or similar programs.  If you build the headers as a
-	  module, a module called kheaders.ko is built which can be loaded on-demand
-	  to get access to the headers.
+config IKHEADERS
+	tristate "Enable kernel headers through /sys/kernel/kheaders.tar.xz"
+	help
+	  This option enables access to the in-kernel headers that are generated during
+	  the build process. These can be used to build eBPF tracing programs,
+	  or similar programs.  If you build the headers as a module, a module called
+	  kheaders.ko is built which can be loaded on-demand to get access to headers.
 
 config LOG_BUF_SHIFT
 	int "Kernel log buffer size (16 => 64KB, 17 => 128KB)"
diff --git a/kernel/Makefile b/kernel/Makefile
index 12399614c350..b32a558fae2f 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -70,7 +70,7 @@ obj-$(CONFIG_UTS_NS) += utsname.o
 obj-$(CONFIG_USER_NS) += user_namespace.o
 obj-$(CONFIG_PID_NS) += pid_namespace.o
 obj-$(CONFIG_IKCONFIG) += configs.o
-obj-$(CONFIG_IKHEADERS_PROC) += kheaders.o
+obj-$(CONFIG_IKHEADERS) += kheaders.o
 obj-$(CONFIG_SMP) += stop_machine.o
 obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
 obj-$(CONFIG_AUDIT) += audit.o auditfilter.o
@@ -126,7 +126,7 @@ $(obj)/config_data.gz: $(KCONFIG_CONFIG) FORCE
 $(obj)/kheaders.o: $(obj)/kheaders_data.tar.xz
 
 quiet_cmd_genikh = CHK     $(obj)/kheaders_data.tar.xz
-cmd_genikh = $(srctree)/kernel/gen_ikh_data.sh $@
+cmd_genikh = $(srctree)/kernel/gen_kheaders.sh $@
 $(obj)/kheaders_data.tar.xz: FORCE
 	$(call cmd,genikh)
 
diff --git a/kernel/gen_ikh_data.sh b/kernel/gen_kheaders.sh
similarity index 98%
rename from kernel/gen_ikh_data.sh
rename to kernel/gen_kheaders.sh
index 591a94f7b387..581b83534587 100755
--- a/kernel/gen_ikh_data.sh
+++ b/kernel/gen_kheaders.sh
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 # This script generates an archive consisting of kernel headers
-# for CONFIG_IKHEADERS_PROC.
+# for CONFIG_IKHEADERS.
 set -e
 spath="$(dirname "$(readlink -f "$0")")"
 kroot="$spath/.."
diff --git a/kernel/kheaders.c b/kernel/kheaders.c
index 70ae6052920d..8f69772af77b 100644
--- a/kernel/kheaders.c
+++ b/kernel/kheaders.c
@@ -8,9 +8,8 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/proc_fs.h>
+#include <linux/kobject.h>
 #include <linux/init.h>
-#include <linux/uaccess.h>
 
 /*
  * Define kernel_headers_data and kernel_headers_data_end, within which the
@@ -31,39 +30,32 @@ extern char kernel_headers_data;
 extern char kernel_headers_data_end;
 
 static ssize_t
-ikheaders_read_current(struct file *file, char __user *buf,
-		      size_t len, loff_t *offset)
+ikheaders_read(struct file *file,  struct kobject *kobj,
+	       struct bin_attribute *bin_attr,
+	       char *buf, loff_t off, size_t len)
 {
-	return simple_read_from_buffer(buf, len, offset,
-				       &kernel_headers_data,
-				       &kernel_headers_data_end -
-				       &kernel_headers_data);
+	memcpy(buf, &kernel_headers_data + off, len);
+	return len;
 }
 
-static const struct file_operations ikheaders_file_ops = {
-	.read = ikheaders_read_current,
-	.llseek = default_llseek,
+static struct bin_attribute kheaders_attr __ro_after_init = {
+	.attr = {
+		.name = "kheaders.tar.xz",
+		.mode = 0444,
+	},
+	.read = &ikheaders_read,
 };
 
 static int __init ikheaders_init(void)
 {
-	struct proc_dir_entry *entry;
-
-	/* create the current headers file */
-	entry = proc_create("kheaders.tar.xz", S_IRUGO, NULL,
-			    &ikheaders_file_ops);
-	if (!entry)
-		return -ENOMEM;
-
-	proc_set_size(entry,
-		      &kernel_headers_data_end -
-		      &kernel_headers_data);
-	return 0;
+	kheaders_attr.size = (&kernel_headers_data_end -
+			      &kernel_headers_data);
+	return sysfs_create_bin_file(kernel_kobj, &kheaders_attr);
 }
 
 static void __exit ikheaders_cleanup(void)
 {
-	remove_proc_entry("kheaders.tar.xz", NULL);
+	sysfs_remove_bin_file(kernel_kobj, &kheaders_attr);
 }
 
 module_init(ikheaders_init);
-- 
2.21.0.1020.gf2820cf01a-goog

