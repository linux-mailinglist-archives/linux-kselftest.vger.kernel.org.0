Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39DE425968
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Oct 2021 19:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241842AbhJGR22 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Oct 2021 13:28:28 -0400
Received: from smtprelay0019.hostedemail.com ([216.40.44.19]:46366 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241958AbhJGR2G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Oct 2021 13:28:06 -0400
Received: from omf11.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 67D42182CED28;
        Thu,  7 Oct 2021 17:26:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id EF9D420A295;
        Thu,  7 Oct 2021 17:26:06 +0000 (UTC)
Message-ID: <04ebb29ccb707bc37df2d3ddd684781114a1a62e.camel@perches.com>
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
Date:   Thu, 07 Oct 2021 10:26:05 -0700
In-Reply-To: <YV8sPjLn1jqLOm2H@smile.fi.intel.com>
References: <20211007154407.29746-1-andriy.shevchenko@linux.intel.com>
         <20211007154407.29746-7-andriy.shevchenko@linux.intel.com>
         <1ec405c5a8fd24de9066277ce855d7e39f93e691.camel@perches.com>
         <YV8sPjLn1jqLOm2H@smile.fi.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.37
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: EF9D420A295
X-Stat-Signature: snzj1zzhbiakgpkpo4a971pk3iwuoeqf
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/s3XrKz8zDDq1N3d6CFOIaxwNFOxHwArU=
X-HE-Tag: 1633627566-897448
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2021-10-07 at 20:19 +0300, Andy Shevchenko wrote:
> On Thu, Oct 07, 2021 at 10:12:56AM -0700, Joe Perches wrote:
> > On Thu, 2021-10-07 at 18:44 +0300, Andy Shevchenko wrote:
> > > When kernel.h is used in the headers it adds a lot into dependency hell,
> > > especially when there are circular dependencies are involved.
> > > 
> > > Replace kernel.h inclusion with the list of what is really being used.
> > []
> > > diff --git a/include/linux/plist.h b/include/linux/plist.h
> > []
> > > @@ -73,8 +73,11 @@
> > []
> > > +#include <asm/bug.h>
> > 
> > why asm/bug.h and not linux/bug.h ?
> 
> The direct inclusion is from that one. Why linux/bug?

A general guideline is to avoid asm includes.


