Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C000425977
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Oct 2021 19:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242331AbhJGRb2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Oct 2021 13:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242307AbhJGRb1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Oct 2021 13:31:27 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E45C061570;
        Thu,  7 Oct 2021 10:29:33 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C3871DDE;
        Thu,  7 Oct 2021 19:29:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1633627771;
        bh=bX70RVpHqIP8+Slj+fBenki+5BKZhXbz2i1z5b0/GWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B0LEwZQzwy4hLNE0zUPdQLPkr/DTU58lDjcHQnHI52JCbs6oqbVyjW1fy61uUtbHf
         BBsBUAisiJNxEqpa/EJGNvIke/rGoyYgIuZMi/NHpSueKJrtPcF/vB+hW0iqT0Er+Q
         w1yu6wNKyqz+9QXqJ1nGr49pQjzqDTHPbgCp/g3o=
Date:   Thu, 7 Oct 2021 20:29:21 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jonathan Cameron <jic23@kernel.org>
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
Subject: Re: [PATCH v4 4/7] list.h: Replace kernel.h with the necessary
 inclusions
Message-ID: <YV8ucQJD1ccucQTy@pendragon.ideasonboard.com>
References: <20211007154407.29746-1-andriy.shevchenko@linux.intel.com>
 <20211007154407.29746-5-andriy.shevchenko@linux.intel.com>
 <20211007171635.2f161739@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211007171635.2f161739@jic23-huawei>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 07, 2021 at 05:16:35PM +0100, Jonathan Cameron wrote:
> On Thu,  7 Oct 2021 18:44:04 +0300 Andy Shevchenko wrote:
> 
> > When kernel.h is used in the headers it adds a lot into dependency hell,
> > especially when there are circular dependencies are involved.
> > 
> > Replace kernel.h inclusion with the list of what is really being used.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  include/linux/list.h | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/list.h b/include/linux/list.h
> > index f2af4b4aa4e9..5dc679b373da 100644
> > --- a/include/linux/list.h
> > +++ b/include/linux/list.h
> > @@ -2,11 +2,13 @@
> >  #ifndef _LINUX_LIST_H
> >  #define _LINUX_LIST_H
> >  
> > +#include <linux/container_of.h>
> > +#include <linux/const.h>
> >  #include <linux/types.h>
> >  #include <linux/stddef.h>
> >  #include <linux/poison.h>
> 
> Is there a reason you didn't quite sort this into alphabetical order?

On a side note, if someone with perle knowledge could add a checkpatch
warning for this, I think it would be very nice. I'm a bit tired of
asking for alphabetical order in reviews :-)

> > -#include <linux/const.h>
> > -#include <linux/kernel.h>
> > +
> > +#include <asm/barrier.h>
> >  
> >  /*
> >   * Circular doubly linked list implementation.

-- 
Regards,

Laurent Pinchart
