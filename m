Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D342A44EB
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Nov 2020 13:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgKCMRT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Nov 2020 07:17:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:38136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728168AbgKCMRR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Nov 2020 07:17:17 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86B1421D40;
        Tue,  3 Nov 2020 12:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604405837;
        bh=Z3eCA/9DRelOW4zpEpE9pkZnNliO73On3+mtonpzA2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RQvNDlxf6/k54kQsc1UBNMUH3N9HWztXRpwqlgq1j51NcKv7ZAC8SSb+xdQgMPAuF
         buO88ps97RtLRONiO1s25SeNnWYnAYaHj75imqUYovJ8+z5qJehBmBoHqRzwK0/tRw
         eh7HARSL4w6HrOdrl8iYCPEZjvuFmyzgs7PLOSkA=
Date:   Tue, 3 Nov 2020 13:18:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>, kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v3] lib: Convert test_printf.c to KUnit
Message-ID: <20201103121810.GA1054984@kroah.com>
References: <20201103111049.51916-1-98.arpi@gmail.com>
 <20201103113353.GC4077@smile.fi.intel.com>
 <20201103115223.GA268796@kroah.com>
 <CAHp75Vcw8Hyaks9ZbRfz7HhBzPM2cJxR4ypye5PwcZqY9rsYhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vcw8Hyaks9ZbRfz7HhBzPM2cJxR4ypye5PwcZqY9rsYhA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 03, 2020 at 02:06:23PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 3, 2020 at 1:54 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Tue, Nov 03, 2020 at 01:33:53PM +0200, Andy Shevchenko wrote:
> > > On Tue, Nov 03, 2020 at 04:40:49PM +0530, Arpitha Raghunandan wrote:
> 
> ...
> 
> > > Better, indeed.
> > >
> > > But can be this improved to have a cumulative statistics, like showing only
> > > number of total, succeeded, failed with details of the latter ones?
> >
> > Is that the proper test output format?  We have a standard...
> 
> I dunno. I'm asking...
> We have few possibilities here: a) let it go like above, b) use the
> cumulative statistics, c) if there is no such available, implement and
> use it, d) ...

We have a standard, please use it.

greg k-h
