Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 726D119562
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2019 00:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfEIWrr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 May 2019 18:47:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37243 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfEIWrr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 May 2019 18:47:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so1949056pgc.4
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2019 15:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vZRf/O+AYO1pjasRFrKqOyps3I4eNGFPQS8KhShdX90=;
        b=Ye5VPeIClHIvOa3yb/Txa2nZfvUQR7hyXGf8jlN8r7iBdWzaJtSWZksEgYFQpdW+le
         CqqejGHpFq3qNoZ6SId2I8t2xH38UIuS4VQ0klh21WPl8hWhSZnaIBHQpZQdxggBGLJb
         zkdOrKjnmeaLHbdYu1LbpWW+AHV9M7rizlsQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vZRf/O+AYO1pjasRFrKqOyps3I4eNGFPQS8KhShdX90=;
        b=pwIQnEso8+ftl422TE9NKp5NsupvdtuGI4fLEfH07FMMYJUyRB/tSYDQp4C31d55iM
         TXmjKoBFBHoeJQjru9VFPL0aLhaKIBGEA1NgLJ78byQiLj5Aa7y3321b/dPHPuGkFcEk
         bhb53owS2+2aBN8a73LYx3kSLOv3I2MIKA8lD7NGvAU031D9kuY2t5scjwWM7DvRIVGL
         WuLgefMeq+HZqZOuIJUuDx9f5sRcNwfSc7Axpg7q357BXTR3HnsxQbh5Le4ZJSD97wu3
         IS/9jgpTYbx5adI/dmyyiIkxaBWIScVgUvcx3sjwiA9aZxEFEvU0sReCbpzL34J0gj8L
         sS2g==
X-Gm-Message-State: APjAAAVnsiMSDUMWZw1tBlfQ4dGMqFQ5oPj2GLKos0XJW5CcEt4l2qA5
        E6Ihfx2gCoztdq4K4zt0lbu3GA==
X-Google-Smtp-Source: APXvYqwO0Rpd3ouiehbTSdDrhChC3UhFFIDoCyfVb2yZJbYtD/jBLOeJxKNQDgTgWjLrHtJmKc4WbA==
X-Received: by 2002:a65:43c8:: with SMTP id n8mr8758516pgp.365.1557442066517;
        Thu, 09 May 2019 15:47:46 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h6sm8950991pfk.188.2019.05.09.15.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 15:47:45 -0700 (PDT)
Date:   Thu, 9 May 2019 18:47:43 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
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
        =?utf-8?Q?Micha=C5=82?= Gregorczyk <michalgr@fb.com>,
        Michal Gregorczyk <michalgr@live.com>,
        Mohammad Husain <russoue@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        Qais Yousef <qais.yousef@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Tamir Carmeli <carmeli.tamir@gmail.com>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH v3] kheaders: Move from proc to sysfs
Message-ID: <20190509224743.GA29215@google.com>
References: <20190506013456.86061-1-joel@joelfernandes.org>
 <CAK7LNAQesyT-vspoGKdgRqycZfhtJm5Upx2T6ij-yB5i4Nx5nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQesyT-vspoGKdgRqycZfhtJm5Upx2T6ij-yB5i4Nx5nw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 08, 2019 at 12:43:34PM +0900, Masahiro Yamada wrote:
> On Mon, May 6, 2019 at 10:37 AM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
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
> > v2->v3: Fixed sysfs file mode nit (Greg).
> > v1->v2: Fixed some kconfig nits.
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
> >           This option enables access to the kernel configuration file
> >           through /proc/config.gz.
> >
> > -config IKHEADERS_PROC
> > -       tristate "Enable kernel header artifacts through /proc/kheaders.tar.xz"
> > -       depends on PROC_FS
> > -       help
> > -         This option enables access to the kernel header and other artifacts that
> > -         are generated during the build process. These can be used to build eBPF
> > -         tracing programs, or similar programs.  If you build the headers as a
> > -         module, a module called kheaders.ko is built which can be loaded on-demand
> > -         to get access to the headers.
> > +config IKHEADERS
> > +       tristate "Enable kernel headers through /sys/kernel/kheaders.tar.xz"
> 
> 
> I suggested "depends on SYSFS" twice, both in v1 and v2.
> 
> https://lore.kernel.org/patchwork/patch/1069806/#1266147
> https://lore.kernel.org/patchwork/patch/1070005/#1266279

Sorry about missing that. I have made a note of this, and can address it in a
later patch. There is a more pressing issue with allmodconfig regression
times so I will look into that first. Also a vacation is taking up some of my
time.

Needless to say I will get to it soon and the point has been duly noted!

thanks,

 - Joel
