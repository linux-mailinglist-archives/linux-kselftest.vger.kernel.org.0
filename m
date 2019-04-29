Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99F3BE4A6
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2019 16:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfD2OYa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Apr 2019 10:24:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728258AbfD2OY3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Apr 2019 10:24:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D3962084B;
        Mon, 29 Apr 2019 14:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556547868;
        bh=RejwehwhGZYqzoVPldNSlaeCeEJFuknqsYBZb9PmVz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SLCv1r9qCp0aqCSmeaTcuzKEQQZoG602EmWDRuix+bPkvIaUDOIaESGq+JARXKlvu
         73BvKIpGPSCoObXaSq/goD9j9OtPdUiJIz6J+QxjK/1yr+zOTuKSKP8cK51kL6vpFy
         SMR80uTgTRB094tY7KlAH3ULgmfBjuttw4wQqvBU=
Date:   Mon, 29 Apr 2019 16:24:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
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
Subject: Re: [PATCH v7 resend 1/2] Provide in-kernel headers to make
 extending kernel easier
Message-ID: <20190429142425.GB29007@kroah.com>
References: <20190426190430.172543-1-joel@joelfernandes.org>
 <20190427133844.GA29366@kroah.com>
 <20190429132602.GA165075@google.com>
 <20190429135455.GA2412@kroah.com>
 <CAK7LNARkGLQ_P4LSuC69QN8XPN47W5ujkDE3EauLrwnBgygsSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARkGLQ_P4LSuC69QN8XPN47W5ujkDE3EauLrwnBgygsSA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 29, 2019 at 11:14:30PM +0900, Masahiro Yamada wrote:
> On Mon, Apr 29, 2019 at 10:57 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Apr 29, 2019 at 09:26:02AM -0400, Joel Fernandes wrote:
> > > On Sat, Apr 27, 2019 at 03:38:44PM +0200, Greg KH wrote:
> > > > On Fri, Apr 26, 2019 at 03:04:29PM -0400, Joel Fernandes (Google) wrote:
> > > > > Introduce in-kernel headers which are made available as an archive
> > > > > through proc (/proc/kheaders.tar.xz file). This archive makes it
> > > > > possible to run eBPF and other tracing programs that need to extend the
> > > > > kernel for tracing purposes without any dependency on the file system
> > > > > having headers.
> > > > >
> > > > > A github PR is sent for the corresponding BCC patch at:
> > > > > https://github.com/iovisor/bcc/pull/2312
> > > > >
> > > > > On Android and embedded systems, it is common to switch kernels but not
> > > > > have kernel headers available on the file system. Further once a
> > > > > different kernel is booted, any headers stored on the file system will
> > > > > no longer be useful. This is an issue even well known to distros.
> > > > > By storing the headers as a compressed archive within the kernel, we can
> > > > > avoid these issues that have been a hindrance for a long time.
> > > > >
> > > > > The best way to use this feature is by building it in. Several users
> > > > > have a need for this, when they switch debug kernels, they do not want to
> > > > > update the filesystem or worry about it where to store the headers on
> > > > > it. However, the feature is also buildable as a module in case the user
> > > > > desires it not being part of the kernel image. This makes it possible to
> > > > > load and unload the headers from memory on demand. A tracing program can
> > > > > load the module, do its operations, and then unload the module to save
> > > > > kernel memory. The total memory needed is 3.3MB.
> > > > >
> > > > > By having the archive available at a fixed location independent of
> > > > > filesystem dependencies and conventions, all debugging tools can
> > > > > directly refer to the fixed location for the archive, without concerning
> > > > > with where the headers on a typical filesystem which significantly
> > > > > simplifies tooling that needs kernel headers.
> > > > >
> > > > > The code to read the headers is based on /proc/config.gz code and uses
> > > > > the same technique to embed the headers.
> > > > >
> > > > > Other approaches were discussed such as having an in-memory mountable
> > > > > filesystem, but that has drawbacks such as requiring an in-kernel xz
> > > > > decompressor which we don't have today, and requiring usage of 42 MB of
> > > > > kernel memory to host the decompressed headers at anytime. Also this
> > > > > approach is simpler than such approaches.
> > > > >
> > > > > Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > >
> > > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >
> > > Thanks for the Reviewed-by tag. I believe there are still 2 logistical things
> > > to merge this.
> > > 1. Location of the header archive:
> > > Olof and Steve did not like it to be in /proc and instead /sys seemed a better
> > > choice they are Ok with. Me and Greg were Ok with it being in /sys/kernel/.
> > > Alexei, Greg and me are Ok with either proc or Sys.
> >
> > As you say, either is fine with me.
> >
> > > 2. Who is going to pull this patch: This seems a matter of where the header
> > > archive resides. If it is in /sys/kernel/ then I am assuming Greg will pull
> > > it.  Masahiro has given his Reviewed-by tag, is he the one to pull it?
> >
> > I can take it, but it probably should just go through the kbuild tree,
> > as that makes more sense to me.
> 
> 
> I do not want to take responsibility for this.

Hah, ok, I'll be glad to queue this up in my tree.  I'll take it now,
and if people who really object to this being in /proc/ and want it in
/sys/, we can add a follow-on patch before 5.2-final is out to move the
file to that location.

thanks,

greg k-h
