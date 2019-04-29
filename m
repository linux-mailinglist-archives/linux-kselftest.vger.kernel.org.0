Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE51E471
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2019 16:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbfD2OP0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Apr 2019 10:15:26 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:62325 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfD2OP0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Apr 2019 10:15:26 -0400
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x3TEF7Xo009931;
        Mon, 29 Apr 2019 23:15:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x3TEF7Xo009931
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556547308;
        bh=l3dZW2UIUJmt2aKGNrZq7mHyn/lDaxk1teTwUSyxmG8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=baXvggH1PMJGSExGISfzbwfrxQ8BlpNgPgGOOIn0S6jW9HNAfVsTmUhlQwO43QKJg
         HtyOoGD02YrB6XQ5Env+2sSyVERHIHWZDsMCevgGgkEoJcbuPRtPz08X2JpiMnBAB8
         vTsejq5EFPG41XbhzXUBIu6/8CgrRclBIb/LVteCzLD3knrxULNAT1p++suBhy1KmX
         vr+UaGqco+jNKt+VSpVc7tkEtAtuqvS7zMQEqE1JUp7kM9gZgtX4e5hstZfcuZHgPz
         lix7VLIX+thkzBHQNbVeKMG/gHXuvkBmhSeqvykBIbuhyrJgCnFxDivO+A9dcFCgPO
         3kpcaUjdjp5vg==
X-Nifty-SrcIP: [209.85.222.45]
Received: by mail-ua1-f45.google.com with SMTP id t15so3534441uao.5;
        Mon, 29 Apr 2019 07:15:07 -0700 (PDT)
X-Gm-Message-State: APjAAAXBEWQSu8KIR9hfhEGCwI/G819hSRBcGP25/8qPxVzVC1hF1fSx
        BCSFgNR9XjqZ4r3r/5KzL81SWtW1ZkAcfGaGa20=
X-Google-Smtp-Source: APXvYqyuORXxFnYlSapovC2R789OHwW19P1u/RHj8aGf3kcskdAsSGrH87fld1K6FivP2MOZ/OnJg++4vlgc4y6kAA4=
X-Received: by 2002:a9f:2d99:: with SMTP id v25mr12349688uaj.25.1556547306611;
 Mon, 29 Apr 2019 07:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190426190430.172543-1-joel@joelfernandes.org>
 <20190427133844.GA29366@kroah.com> <20190429132602.GA165075@google.com> <20190429135455.GA2412@kroah.com>
In-Reply-To: <20190429135455.GA2412@kroah.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 29 Apr 2019 23:14:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNARkGLQ_P4LSuC69QN8XPN47W5ujkDE3EauLrwnBgygsSA@mail.gmail.com>
Message-ID: <CAK7LNARkGLQ_P4LSuC69QN8XPN47W5ujkDE3EauLrwnBgygsSA@mail.gmail.com>
Subject: Re: [PATCH v7 resend 1/2] Provide in-kernel headers to make extending
 kernel easier
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        atish patra <atishp04@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org,
        Manoj Rao <linux@manojrajarao.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>, Yonghong Song <yhs@fb.com>,
        Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 29, 2019 at 10:57 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Apr 29, 2019 at 09:26:02AM -0400, Joel Fernandes wrote:
> > On Sat, Apr 27, 2019 at 03:38:44PM +0200, Greg KH wrote:
> > > On Fri, Apr 26, 2019 at 03:04:29PM -0400, Joel Fernandes (Google) wrote:
> > > > Introduce in-kernel headers which are made available as an archive
> > > > through proc (/proc/kheaders.tar.xz file). This archive makes it
> > > > possible to run eBPF and other tracing programs that need to extend the
> > > > kernel for tracing purposes without any dependency on the file system
> > > > having headers.
> > > >
> > > > A github PR is sent for the corresponding BCC patch at:
> > > > https://github.com/iovisor/bcc/pull/2312
> > > >
> > > > On Android and embedded systems, it is common to switch kernels but not
> > > > have kernel headers available on the file system. Further once a
> > > > different kernel is booted, any headers stored on the file system will
> > > > no longer be useful. This is an issue even well known to distros.
> > > > By storing the headers as a compressed archive within the kernel, we can
> > > > avoid these issues that have been a hindrance for a long time.
> > > >
> > > > The best way to use this feature is by building it in. Several users
> > > > have a need for this, when they switch debug kernels, they do not want to
> > > > update the filesystem or worry about it where to store the headers on
> > > > it. However, the feature is also buildable as a module in case the user
> > > > desires it not being part of the kernel image. This makes it possible to
> > > > load and unload the headers from memory on demand. A tracing program can
> > > > load the module, do its operations, and then unload the module to save
> > > > kernel memory. The total memory needed is 3.3MB.
> > > >
> > > > By having the archive available at a fixed location independent of
> > > > filesystem dependencies and conventions, all debugging tools can
> > > > directly refer to the fixed location for the archive, without concerning
> > > > with where the headers on a typical filesystem which significantly
> > > > simplifies tooling that needs kernel headers.
> > > >
> > > > The code to read the headers is based on /proc/config.gz code and uses
> > > > the same technique to embed the headers.
> > > >
> > > > Other approaches were discussed such as having an in-memory mountable
> > > > filesystem, but that has drawbacks such as requiring an in-kernel xz
> > > > decompressor which we don't have today, and requiring usage of 42 MB of
> > > > kernel memory to host the decompressed headers at anytime. Also this
> > > > approach is simpler than such approaches.
> > > >
> > > > Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > >
> > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > Thanks for the Reviewed-by tag. I believe there are still 2 logistical things
> > to merge this.
> > 1. Location of the header archive:
> > Olof and Steve did not like it to be in /proc and instead /sys seemed a better
> > choice they are Ok with. Me and Greg were Ok with it being in /sys/kernel/.
> > Alexei, Greg and me are Ok with either proc or Sys.
>
> As you say, either is fine with me.
>
> > 2. Who is going to pull this patch: This seems a matter of where the header
> > archive resides. If it is in /sys/kernel/ then I am assuming Greg will pull
> > it.  Masahiro has given his Reviewed-by tag, is he the one to pull it?
>
> I can take it, but it probably should just go through the kbuild tree,
> as that makes more sense to me.


I do not want to take responsibility for this.



-- 
Best Regards
Masahiro Yamada
