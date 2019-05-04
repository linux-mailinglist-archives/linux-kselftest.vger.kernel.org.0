Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0854813832
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2019 10:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfEDIMA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 4 May 2019 04:12:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfEDIL7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 4 May 2019 04:11:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8819920645;
        Sat,  4 May 2019 08:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556957518;
        bh=SBbvUNLEDR59y1jM6qdHyiKYw3PXx9SL+kY8eY9adTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bCI0mV+q7oTtHAc1tn1nAzj/sTUxo6EII2xFNvacFrex/zzCVejjFj9qxHNazmNxt
         Grfo+FlEjjQBYJ/kK0Oo1eNADT8zgfZjJC++xoDuWHd9J76GesfCdhAJ8eLbfHy/kX
         Uhy0Zad+IsIDTKh4IWZm3bQG2d0ChpRr/XKS+4Bk=
Date:   Sat, 4 May 2019 10:11:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        atish patra <atishp04@gmail.com>, bpf <bpf@vger.kernel.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        duyuchao <yuchao.du@unisoc.com>,
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
Subject: Re: [PATCH] kheaders: Move from proc to sysfs
Message-ID: <20190504081155.GA13298@kroah.com>
References: <20190503182459.159121-1-joel@joelfernandes.org>
 <CAK7LNATRTqh_OJcQaWfcYYYqyZ-c0u1prD17LDYwDh18z2V31Q@mail.gmail.com>
 <CAK7LNASkR7cauvcLprgrTKNv-iY4yjS278FPGJ-UEYTBrANKYw@mail.gmail.com>
 <20190504005920.GA261146@google.com>
 <CAADnVQKh6yVgYR_cZ56MSQ2WxfBjFYaQxbEH=xaeM0FjxAeaZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKh6yVgYR_cZ56MSQ2WxfBjFYaQxbEH=xaeM0FjxAeaZg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, May 04, 2019 at 12:46:21AM -0700, Alexei Starovoitov wrote:
> On Fri, May 3, 2019 at 5:59 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Sat, May 04, 2019 at 09:21:41AM +0900, Masahiro Yamada wrote:
> > > On Sat, May 4, 2019 at 9:18 AM Masahiro Yamada
> > > <yamada.masahiro@socionext.com> wrote:
> > > >
> > > > On Sat, May 4, 2019 at 3:27 AM Joel Fernandes (Google)
> > > > <joel@joelfernandes.org> wrote:
> > > > >
> > > > > The kheaders archive consisting of the kernel headers used for compiling
> > > > > bpf programs is in /proc. However there is concern that moving it here
> > > > > will make it permanent. Let us move it to /sys/kernel as discussed [1].
> > > > >
> > > > > [1] https://lore.kernel.org/patchwork/patch/1067310/#1265969
> > > > >
> > > > > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > ---
> > > > > This patch applies on top of the previous patch that was applied to the
> > > > > driver tree:
> > > > > https://lore.kernel.org/patchwork/patch/1067310/
> 
> I think it would be cleaner to take it out, squash and reapply.

It is in a un-rebasable-tree already, sorry.  A patch on top is fine.

thanks,

greg k-h
