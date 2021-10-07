Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE284259BA
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Oct 2021 19:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242912AbhJGRtA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Oct 2021 13:49:00 -0400
Received: from smtprelay0057.hostedemail.com ([216.40.44.57]:50724 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241071AbhJGRs7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Oct 2021 13:48:59 -0400
Received: from omf13.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id AF308181D5AA8;
        Thu,  7 Oct 2021 17:47:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id 3E9C91124F8;
        Thu,  7 Oct 2021 17:47:00 +0000 (UTC)
Message-ID: <50e81a87af1f832ae8e135b15aa41a87c08400e0.camel@perches.com>
Subject: Re: [PATCH v4 6/7] plist: Replace kernel.h with the necessary
 inclusions
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-media@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        jic23@kernel.org, linux@rasmusvillemoes.dk,
        Thorsten Leemhuis <regressions@leemhuis.info>
Date:   Thu, 07 Oct 2021 10:46:59 -0700
In-Reply-To: <YV8vHZg0Xcs0DbPV@smile.fi.intel.com>
References: <20211007154407.29746-1-andriy.shevchenko@linux.intel.com>
         <20211007154407.29746-7-andriy.shevchenko@linux.intel.com>
         <1ec405c5a8fd24de9066277ce855d7e39f93e691.camel@perches.com>
         <YV8sPjLn1jqLOm2H@smile.fi.intel.com>
         <04ebb29ccb707bc37df2d3ddd684781114a1a62e.camel@perches.com>
         <YV8vHZg0Xcs0DbPV@smile.fi.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 3E9C91124F8
X-Spam-Status: No, score=-1.40
X-Stat-Signature: js9xg1nie7rcba17bhx9wntqbj17r6mz
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19aRUm/4rtwwqaN+mIxySG7FIoWsloqmj0=
X-HE-Tag: 1633628820-910685
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2021-10-07 at 20:32 +0300, Andy Shevchenko wrote:
> On Thu, Oct 07, 2021 at 10:26:05AM -0700, Joe Perches wrote:
> > On Thu, 2021-10-07 at 20:19 +0300, Andy Shevchenko wrote:
> > > On Thu, Oct 07, 2021 at 10:12:56AM -0700, Joe Perches wrote:
> > > > On Thu, 2021-10-07 at 18:44 +0300, Andy Shevchenko wrote:
> > > > > When kernel.h is used in the headers it adds a lot into dependency hell,
> > > > > especially when there are circular dependencies are involved.
> > > > > 
> > > > > Replace kernel.h inclusion with the list of what is really being used.
> > > > []
> > > > > diff --git a/include/linux/plist.h b/include/linux/plist.h
> > > > []
> > > > > @@ -73,8 +73,11 @@
> > > > []
> > > > > +#include <asm/bug.h>
> > > > 
> > > > why asm/bug.h and not linux/bug.h ?
> > > 
> > > The direct inclusion is from that one. Why linux/bug?
> > 
> > A general guideline is to avoid asm includes.
> 
> It's fine when it has any useful background. Doing cargo cult is not always
> a good idea. I plead for common sense.

Common sense isn't particularly common.
Someone is going to run checkpatch on it and submit a patch one day.
Maybe add a comment for the less common.

cheers, Joe


