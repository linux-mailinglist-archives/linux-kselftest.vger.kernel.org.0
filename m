Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B046E427547
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Oct 2021 02:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243967AbhJIBBV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Oct 2021 21:01:21 -0400
Received: from smtprelay0081.hostedemail.com ([216.40.44.81]:55618 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231996AbhJIBBU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Oct 2021 21:01:20 -0400
Received: from omf07.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 9A08C182CED28;
        Sat,  9 Oct 2021 00:59:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 5105C315D75;
        Sat,  9 Oct 2021 00:59:19 +0000 (UTC)
Message-ID: <5b6dc5760b42af6c07c8ffc789466be7d7da358e.camel@perches.com>
Subject: Re: [PATCH v4 4/7] list.h: Replace kernel.h with the necessary
 inclusions
From:   Joe Perches <joe@perches.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-media@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux@rasmusvillemoes.dk,
        Thorsten Leemhuis <regressions@leemhuis.info>
Date:   Fri, 08 Oct 2021 17:59:18 -0700
In-Reply-To: <YV8ucQJD1ccucQTy@pendragon.ideasonboard.com>
References: <20211007154407.29746-1-andriy.shevchenko@linux.intel.com>
         <20211007154407.29746-5-andriy.shevchenko@linux.intel.com>
         <20211007171635.2f161739@jic23-huawei>
         <YV8ucQJD1ccucQTy@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 5105C315D75
X-Spam-Status: No, score=-1.40
X-Stat-Signature: zd745zhjiud6c1zmjfw9r5nwy89k5iif
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX184NsuyxE4r3AJbQ/TLzn6fTZhsBYBNplw=
X-HE-Tag: 1633741159-16292
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2021-10-07 at 20:29 +0300, Laurent Pinchart wrote:
> On Thu, Oct 07, 2021 at 05:16:35PM +0100, Jonathan Cameron wrote:
> > On Thu,  7 Oct 2021 18:44:04 +0300 Andy Shevchenko wrote:
> > > When kernel.h is used in the headers it adds a lot into dependency hell,
> > > especially when there are circular dependencies are involved.
> > > 
> > > Replace kernel.h inclusion with the list of what is really being used.
[]
> > > diff --git a/include/linux/list.h b/include/linux/list.h
[]
> > > @@ -2,11 +2,13 @@
> > >  #ifndef _LINUX_LIST_H
> > >  #define _LINUX_LIST_H
> > > 
> > > +#include <linux/container_of.h>
> > > +#include <linux/const.h>
> > >  #include <linux/types.h>
> > >  #include <linux/stddef.h>
> > >  #include <linux/poison.h>
> > 
> > Is there a reason you didn't quite sort this into alphabetical order?
> 
> On a side note, if someone with perle knowledge could add a checkpatch
> warning for this, I think it would be very nice. I'm a bit tired of
> asking for alphabetical order in reviews :-)

As are people that want reverse christmas tree.
Neither of which I will do as I think both are poor form at best.

If you want, this was a checkpatch reverse christmas tree attempt,
as that was more common to some.

https://lore.kernel.org/lkml/1478242438.1924.31.camel@perches.com/


