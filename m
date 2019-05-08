Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 048E416F97
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2019 05:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfEHDoc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 May 2019 23:44:32 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:55088 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfEHDoc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 May 2019 23:44:32 -0400
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x483iAfQ000467;
        Wed, 8 May 2019 12:44:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x483iAfQ000467
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557287051;
        bh=GtYEji5+EE71+LZjKDY0sxmohdZ0g+Z5/jFvjX0CHzk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1ZESEjZOrbdTa5+bMjMIxX7JKfYmQ/Y+dVySrIFat/BgQw0mbSCMDzXGSvjMWFz/n
         avfYjmfH7jmGaI5QdsMqFVxzcZu8izw/LpK1K5OCkgm8I5KWmyRvu9UHOa8gxKoDZt
         m+aRszBtUwNrViHlN1ejn9NLZd5sBn8LipsbVhKP/EmJklWC8d0SClpntEUdswPbO0
         uxHDUcYmEs99d3dEYaGWHtzJe4sW3DhiZbWvfKF+a3i+oGn774ldgNtYyHqsLu0LUi
         wdmGRah9iOVXGv/gkE0XnKA1+0cx7FHv6uxS86y+Yf+qd+CK0/DwFFePzuMXVm07lT
         NS2Z5t8WpH/UA==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id g127so11777172vsd.6;
        Tue, 07 May 2019 20:44:11 -0700 (PDT)
X-Gm-Message-State: APjAAAUR3AuX3SmgwdBFiodM0SXGkP8nbnBJI942Jhx3gtbPtTPGtQfc
        gQJhKeLMYD4sno69/A9o8/2bWOLvuRdWYJQxHWE=
X-Google-Smtp-Source: APXvYqz4ub6AwdOUIv3IBI3Jv6hdIY2r3aV/UeyA9Lf21f53omFZix/UHdWvee9kuR48UmUZmxkT6DyZqggTTN2/rBA=
X-Received: by 2002:a67:fd89:: with SMTP id k9mr7071343vsq.54.1557287050111;
 Tue, 07 May 2019 20:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190506013456.86061-1-joel@joelfernandes.org>
In-Reply-To: <20190506013456.86061-1-joel@joelfernandes.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 8 May 2019 12:43:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQesyT-vspoGKdgRqycZfhtJm5Upx2T6ij-yB5i4Nx5nw@mail.gmail.com>
Message-ID: <CAK7LNAQesyT-vspoGKdgRqycZfhtJm5Upx2T6ij-yB5i4Nx5nw@mail.gmail.com>
Subject: Re: [PATCH v3] kheaders: Move from proc to sysfs
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

On Mon, May 6, 2019 at 10:37 AM Joel Fernandes (Google)
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
> v2->v3: Fixed sysfs file mode nit (Greg).
> v1->v2: Fixed some kconfig nits.
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


I suggested "depends on SYSFS" twice, both in v1 and v2.

https://lore.kernel.org/patchwork/patch/1069806/#1266147
https://lore.kernel.org/patchwork/patch/1070005/#1266279



> +       help
> +         This option enables access to the in-kernel headers that are generated during
> +         the build process. These can be used to build eBPF tracing programs,
> +         or similar programs.  If you build the headers as a module, a module called
> +         kheaders.ko is built which can be loaded on-demand to get access to headers.
>
>  config LOG_BUF_SHIFT
>         int "Kernel log buffer size (16 => 64KB, 17 => 128KB)"


-- 
Best Regards
Masahiro Yamada
