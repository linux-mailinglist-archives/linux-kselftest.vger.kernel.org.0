Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F71427560
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Oct 2021 03:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbhJIBXf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Oct 2021 21:23:35 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:34020 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbhJIBXf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Oct 2021 21:23:35 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0DB8B8C4;
        Sat,  9 Oct 2021 03:21:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1633742497;
        bh=Kj1tkNvZVt6lDT4dzXil0klr2TSUKdwaLvIsSAQg7JU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V2+lXNcUqHiXF86Aj1ZZtrhNmvqxrzV/gzXjfDaAMmipiCOyBNe32Wk83kM1yk/EX
         RiTy0EloHWX/ybYFygn8alYc6Min6s8Wn2amGcSyR9z1hwU0jEfzuUqSHah3/D+UFr
         KmKxFcy1jG+60ry6oouYjh8ZCxYdWlS5bG2kZt5w=
Date:   Sat, 9 Oct 2021 04:21:26 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Joe Perches <joe@perches.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Subject: Re: [PATCH v4 4/7] list.h: Replace kernel.h with the necessary
 inclusions
Message-ID: <YWDuln7HkzioQ7Zh@pendragon.ideasonboard.com>
References: <20211007154407.29746-1-andriy.shevchenko@linux.intel.com>
 <20211007154407.29746-5-andriy.shevchenko@linux.intel.com>
 <20211007171635.2f161739@jic23-huawei>
 <YV8ucQJD1ccucQTy@pendragon.ideasonboard.com>
 <5b6dc5760b42af6c07c8ffc789466be7d7da358e.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b6dc5760b42af6c07c8ffc789466be7d7da358e.camel@perches.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 08, 2021 at 05:59:18PM -0700, Joe Perches wrote:
> On Thu, 2021-10-07 at 20:29 +0300, Laurent Pinchart wrote:
> > On Thu, Oct 07, 2021 at 05:16:35PM +0100, Jonathan Cameron wrote:
> > > On Thu,  7 Oct 2021 18:44:04 +0300 Andy Shevchenko wrote:
> > > > When kernel.h is used in the headers it adds a lot into dependency hell,
> > > > especially when there are circular dependencies are involved.
> > > > 
> > > > Replace kernel.h inclusion with the list of what is really being used.
> []
> > > > diff --git a/include/linux/list.h b/include/linux/list.h
> []
> > > > @@ -2,11 +2,13 @@
> > > >  #ifndef _LINUX_LIST_H
> > > >  #define _LINUX_LIST_H
> > > > 
> > > > +#include <linux/container_of.h>
> > > > +#include <linux/const.h>
> > > >  #include <linux/types.h>
> > > >  #include <linux/stddef.h>
> > > >  #include <linux/poison.h>
> > > 
> > > Is there a reason you didn't quite sort this into alphabetical order?
> > 
> > On a side note, if someone with perle knowledge could add a checkpatch
> > warning for this, I think it would be very nice. I'm a bit tired of
> > asking for alphabetical order in reviews :-)
> 
> As are people that want reverse christmas tree.
> Neither of which I will do as I think both are poor form at best.

Reverse xmas tree order is just a matter of style, while alphabetical
ordering of headers helps catching duplicate, including when merging
branches that both add the same header in different locations. I thus
think there's a technical value to it.

> If you want, this was a checkpatch reverse christmas tree attempt,
> as that was more common to some.
> 
> https://lore.kernel.org/lkml/1478242438.1924.31.camel@perches.com/

-- 
Regards,

Laurent Pinchart
