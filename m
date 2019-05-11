Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 495D21A5F3
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2019 02:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfEKAxL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 May 2019 20:53:11 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:31960 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfEKAxL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 May 2019 20:53:11 -0400
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x4B0qe6p032760;
        Sat, 11 May 2019 09:52:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x4B0qe6p032760
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557535961;
        bh=iUxXS+30vplKGahUoVQhsc/083rdodKyu7vjq55D8xg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=umIRC7/3lNRLSfK+GHljh9R3w0EjQ+AonhIXa9BSr4osEJ1qBhMgzY50aI+8ebY8u
         L9oNE/JlHyZaHMcd4m+0yEm/5oI6h4wmSJrCCbPCcO6F9NuHKAdyqzbvVIY2k5Zfna
         ca9coS/3yMGwaZA736aNpG0ktBbgblls2W8ptdUMGkfOK9RM3DESUXB6IPNXsx8FcL
         6cLIBKpJx7B2GacYkS186Z1oQ7b2X3Kyns+i1GE9ZBw8huUIgJvfsFJxpyQD6mWtwX
         8rv9pykSnmYRazTLtdNBM/Z8HlK0+Kr7FWfwHPrYo4ncv0T60fUsm0CodN3bh5sY9g
         MN3rUi7l+Az+g==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id j184so4668136vsd.11;
        Fri, 10 May 2019 17:52:41 -0700 (PDT)
X-Gm-Message-State: APjAAAULBF5NbSY/oTiCb/RjkNEBAhB22SJO/v3+qos7RudpzuklxxXC
        Lhu7f7D8vgA6EXESGRF3FFMdGYNbrcSYB9DiltI=
X-Google-Smtp-Source: APXvYqyUc+v7TtnlTZkAvl+FZ1vVEt3lE7J6HYJX7L39IUWk68P03S3ownrv/zhg9Wxx1qmb65a+wPCgt1rx7T1DAls=
X-Received: by 2002:a67:fd89:: with SMTP id k9mr7848953vsq.54.1557535960078;
 Fri, 10 May 2019 17:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190510210243.152808-1-joel@joelfernandes.org> <20190510210243.152808-4-joel@joelfernandes.org>
In-Reply-To: <20190510210243.152808-4-joel@joelfernandes.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 11 May 2019 09:52:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNATeJqmE29M=Y1Vexg8nnRdr3qUDkq1BejN7t2_106PgVg@mail.gmail.com>
Message-ID: <CAK7LNATeJqmE29M=Y1Vexg8nnRdr3qUDkq1BejN7t2_106PgVg@mail.gmail.com>
Subject: Re: [PATCH 3/3] kheaders: Make it depend on sysfs
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Tamir Carmeli <carmeli.tamir@gmail.com>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, May 11, 2019 at 6:05 AM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> The kheaders archive is exposed through SYSFS in /sys/kernel/. Make it
> depend on SYSFS as it makes no sense to enable this feature without it.


And, it also makes no sense to break the feature by 1/3,
then fix it by 3/3.


Why don't you squash this?



>
> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  init/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index ce08adf0f637..f27138a8cf28 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -581,6 +581,7 @@ config IKCONFIG_PROC
>
>  config IKHEADERS
>         tristate "Enable kernel headers through /sys/kernel/kheaders.tar.xz"
> +       depends on SYSFS
>         help
>           This option enables access to the in-kernel headers that are generated during
>           the build process. These can be used to build eBPF tracing programs,
> --
> 2.21.0.1020.gf2820cf01a-goog
>


-- 
Best Regards
Masahiro Yamada
