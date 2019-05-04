Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F177B139BC
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2019 14:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfEDMWC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 4 May 2019 08:22:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfEDMWC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 4 May 2019 08:22:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BA9E206DF;
        Sat,  4 May 2019 12:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556972520;
        bh=IBw2N45cvp/ZEURHb5T5bLAIDO89kyXiqinCT+QEbA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dU6xgIdhNWsDQovAswdbLFWQFqFKcnsBBOhY/6ua6z0UTLwYOd9XRCvnCE397+pBM
         /YIu02/rirMU0z0HZQeg44mZZAklSt6H7lcMbSEM7CIT79MQnhX47WAM2MRNT3pnpP
         FYOhSjPKQP8Cm+ekHDmQ46TsCIuPo+E4XNQZTGSM=
Date:   Sat, 4 May 2019 14:21:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
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
Message-ID: <20190504122158.GA23535@kroah.com>
References: <20190504121213.183203-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190504121213.183203-1-joel@joelfernandes.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, May 04, 2019 at 08:12:13AM -0400, Joel Fernandes (Google) wrote:
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
>  	  This option enables access to the kernel configuration file
>  	  through /proc/config.gz.
>  
> -config IKHEADERS_PROC
> -	tristate "Enable kernel header artifacts through /proc/kheaders.tar.xz"
> -	depends on PROC_FS
> -	help
> -	  This option enables access to the kernel header and other artifacts that
> -	  are generated during the build process. These can be used to build eBPF
> -	  tracing programs, or similar programs.  If you build the headers as a
> -	  module, a module called kheaders.ko is built which can be loaded on-demand
> -	  to get access to the headers.
> +config IKHEADERS
> +	tristate "Enable kernel headers through /sys/kernel/kheaders.tar.xz"
> +	help
> +	  This option enables access to the in-kernel headers that are generated during
> +	  the build process. These can be used to build eBPF tracing programs,
> +	  or similar programs.  If you build the headers as a module, a module called
> +	  kheaders.ko is built which can be loaded on-demand to get access to headers.
>  
>  config LOG_BUF_SHIFT
>  	int "Kernel log buffer size (16 => 64KB, 17 => 128KB)"
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

Good in changing the config name, I hadn't thought of that.

> diff --git a/kernel/gen_ikh_data.sh b/kernel/gen_kheaders.sh
> similarity index 98%
> rename from kernel/gen_ikh_data.sh
> rename to kernel/gen_kheaders.sh

Same here, nice.

> -static const struct file_operations ikheaders_file_ops = {
> -	.read = ikheaders_read_current,
> -	.llseek = default_llseek,
> +static struct bin_attribute kheaders_attr __ro_after_init = {

Minor nit, are you sure about __ro_after_init for an attribute
structure?  Is it even needed?

> +	.attr = {
> +		.name = "kheaders.tar.xz",
> +		.mode = S_IRUGO,
> +	},
> +	.read = &ikheaders_read,
>  };

BIN_ATTR_RO?  Ah, no, that will not work with the name of the file,
nevermind.

But, you should change S_IRUGO to the correct octal number, checkpatch
should have barfed on this change.

thanks,

greg k-h
