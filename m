Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06706E4C4
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2019 16:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbfD2O3p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Apr 2019 10:29:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38717 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbfD2O3p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Apr 2019 10:29:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so5409250pfo.5
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2019 07:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WcPAUupWuUJ9uw6w4LNzP0iB9AcsAU9AYb/3oXfMvwA=;
        b=Q6PRyhoKPf031uvtAuys2j2z3C8eSrpz0r0Zd2L9MC7r/78hpJEhnsaWELp08SNA72
         kUtOse5O2XKfQR5CIIwBrm7hqqQk3dy1CcptRkegy7AN5DbP7lBBLOlus3qeilUIEtFI
         D1EYYwqPG3XqCm+DDCx1mCHjq/WteGdHagFNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WcPAUupWuUJ9uw6w4LNzP0iB9AcsAU9AYb/3oXfMvwA=;
        b=LigmkRRqnZBxfDZhJ9YtNtdx9UeCoLp74qyo/+0bZlefs2k5YE/Tn+4Z2QxB46fRaa
         fPt2t9w7z6ZmQ1ilke79kAbC2Hau2lgvSg3QSCCPKGeRYFSvoyCuacoZeqqtOIY1DfSO
         Sv/Z6yRBDNeaQNiJR2dtB/WlSnJRnEPuDuoVu3soBnd/mE1SivLdAWMOQmw6Sns3Tdlf
         5A0ztbJwfdp8k7HsS7pJEHzKBHvNzpyIzzqW2jp0ncHHxVlAojl98ewItgG8X3VhdyCP
         RBXpWjBbUzMidUYXPxUVhks7LB866Uote7nW0RmyX9MjR8hgq5zxJVJzbTnn10HWFkR+
         oHyA==
X-Gm-Message-State: APjAAAW4xRSHj9o85QgyGaHEBhlFIpv/5NQ+L5o5LvicLOwGTDoVt44y
        6Vc85qt9VYchPLuF1YAsE2s5kA==
X-Google-Smtp-Source: APXvYqySVnFhsh2wUnXudSTRVDD+qJhT0VRlDBoe2i+ArFb+q8ROGEAPEbXuB77beAGieTDopzewtA==
X-Received: by 2002:a63:8149:: with SMTP id t70mr12045527pgd.134.1556548184065;
        Mon, 29 Apr 2019 07:29:44 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id z16sm653529pfa.42.2019.04.29.07.29.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 07:29:43 -0700 (PDT)
Date:   Mon, 29 Apr 2019 10:29:41 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
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
Subject: Re: [PATCH v7 resend 1/2] Provide in-kernel headers to make
 extending kernel easier
Message-ID: <20190429142941.GA178173@google.com>
References: <20190426190430.172543-1-joel@joelfernandes.org>
 <20190427133844.GA29366@kroah.com>
 <20190429132602.GA165075@google.com>
 <20190429135455.GA2412@kroah.com>
 <CAK7LNARkGLQ_P4LSuC69QN8XPN47W5ujkDE3EauLrwnBgygsSA@mail.gmail.com>
 <20190429142425.GB29007@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429142425.GB29007@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 29, 2019 at 04:24:25PM +0200, Greg KH wrote:
> On Mon, Apr 29, 2019 at 11:14:30PM +0900, Masahiro Yamada wrote:
> > On Mon, Apr 29, 2019 at 10:57 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Apr 29, 2019 at 09:26:02AM -0400, Joel Fernandes wrote:
> > > > On Sat, Apr 27, 2019 at 03:38:44PM +0200, Greg KH wrote:
> > > > > On Fri, Apr 26, 2019 at 03:04:29PM -0400, Joel Fernandes (Google) wrote:
> > > > > > Introduce in-kernel headers which are made available as an archive
> > > > > > through proc (/proc/kheaders.tar.xz file). This archive makes it
> > > > > > possible to run eBPF and other tracing programs that need to extend the
> > > > > > kernel for tracing purposes without any dependency on the file system
> > > > > > having headers.
> > > > > >
> > > > > > A github PR is sent for the corresponding BCC patch at:
> > > > > > https://github.com/iovisor/bcc/pull/2312
> > > > > >
> > > > > > On Android and embedded systems, it is common to switch kernels but not
> > > > > > have kernel headers available on the file system. Further once a
> > > > > > different kernel is booted, any headers stored on the file system will
> > > > > > no longer be useful. This is an issue even well known to distros.
> > > > > > By storing the headers as a compressed archive within the kernel, we can
> > > > > > avoid these issues that have been a hindrance for a long time.
> > > > > >
> > > > > > The best way to use this feature is by building it in. Several users
> > > > > > have a need for this, when they switch debug kernels, they do not want to
> > > > > > update the filesystem or worry about it where to store the headers on
> > > > > > it. However, the feature is also buildable as a module in case the user
> > > > > > desires it not being part of the kernel image. This makes it possible to
> > > > > > load and unload the headers from memory on demand. A tracing program can
> > > > > > load the module, do its operations, and then unload the module to save
> > > > > > kernel memory. The total memory needed is 3.3MB.
> > > > > >
> > > > > > By having the archive available at a fixed location independent of
> > > > > > filesystem dependencies and conventions, all debugging tools can
> > > > > > directly refer to the fixed location for the archive, without concerning
> > > > > > with where the headers on a typical filesystem which significantly
> > > > > > simplifies tooling that needs kernel headers.
> > > > > >
> > > > > > The code to read the headers is based on /proc/config.gz code and uses
> > > > > > the same technique to embed the headers.
> > > > > >
> > > > > > Other approaches were discussed such as having an in-memory mountable
> > > > > > filesystem, but that has drawbacks such as requiring an in-kernel xz
> > > > > > decompressor which we don't have today, and requiring usage of 42 MB of
> > > > > > kernel memory to host the decompressed headers at anytime. Also this
> > > > > > approach is simpler than such approaches.
> > > > > >
> > > > > > Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > >
> > > > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > >
> > > > Thanks for the Reviewed-by tag. I believe there are still 2 logistical things
> > > > to merge this.
> > > > 1. Location of the header archive:
> > > > Olof and Steve did not like it to be in /proc and instead /sys seemed a better
> > > > choice they are Ok with. Me and Greg were Ok with it being in /sys/kernel/.
> > > > Alexei, Greg and me are Ok with either proc or Sys.
> > >
> > > As you say, either is fine with me.
> > >
> > > > 2. Who is going to pull this patch: This seems a matter of where the header
> > > > archive resides. If it is in /sys/kernel/ then I am assuming Greg will pull
> > > > it.  Masahiro has given his Reviewed-by tag, is he the one to pull it?
> > >
> > > I can take it, but it probably should just go through the kbuild tree,
> > > as that makes more sense to me.
> > 
> > 
> > I do not want to take responsibility for this.
> 
> Hah, ok, I'll be glad to queue this up in my tree.  I'll take it now,
> and if people who really object to this being in /proc/ and want it in
> /sys/, we can add a follow-on patch before 5.2-final is out to move the
> file to that location.

Sounds great to me. thanks!

 - Joel

