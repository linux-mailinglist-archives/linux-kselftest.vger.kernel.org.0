Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF429A4114
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2019 01:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfH3XgK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 19:36:10 -0400
Received: from smtprelay0031.hostedemail.com ([216.40.44.31]:43965 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728138AbfH3XgK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 19:36:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 9C574182CED2A;
        Fri, 30 Aug 2019 23:36:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::,RULES_HIT:41:305:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4605:5007:6119:6742:7576:7807:8603:10004:10400:10848:11026:11232:11658:11914:12296:12297:12663:12740:12760:12895:13095:13161:13229:13439:13868:14181:14659:14721:21080:21094:21433:21451:21627:21796:30036:30054:30063:30090:30091,0,RBL:47.151.137.30:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: boats74_18387a796a501
X-Filterd-Recvd-Size: 4573
Received: from XPS-9350.home (unknown [47.151.137.30])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Fri, 30 Aug 2019 23:36:06 +0000 (UTC)
Message-ID: <f4b4e6047ad7e1e3e37e0bcdff74420ebd2596fa.camel@perches.com>
Subject: Re: [PATCH v2] kunit: fix failure to build without printk
From:   Joe Perches <joe@perches.com>
To:     Tim.Bird@sony.com, brendanhiggins@google.com
Cc:     shuah@kernel.org, sergey.senozhatsky.work@gmail.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, frowand.list@gmail.com,
        sboyd@kernel.org, pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, rdunlap@infradead.org, sfr@canb.auug.org.au
Date:   Fri, 30 Aug 2019 16:36:05 -0700
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF977A8416@USCULXMSG01.am.sony.com>
References: <20190828093143.163302-1-brendanhiggins@google.com>
         <20190828094929.GA14038@jagdpanzerIV>
         <8b2d63bf-56cd-e8f5-e8ee-2891c2c1be8f@kernel.org>
         <f2d5b474411b2940d62198490f06e77890fbdb32.camel@perches.com>
         <20190830183821.GA30306@google.com>
         <bc688b00b2995e4b11229c3d4d90f532e00792c7.camel@perches.com>
         <ECADFF3FD767C149AD96A924E7EA6EAF977A8392@USCULXMSG01.am.sony.com>
         <ca01d8c4823c63db52fc0f18d62334aeb5634a50.camel@perches.com>
         <CAFd5g45X8bOiTWn5TMe3iEFwASafr6dWo6c4bG32uRKbQ+r5oA@mail.gmail.com>
         <ECADFF3FD767C149AD96A924E7EA6EAF977A8416@USCULXMSG01.am.sony.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2019-08-30 at 23:22 +0000, Tim.Bird@sony.com wrote:
> > -----Original Message-----
> > From: Brendan Higgins 
> > 
> > On Fri, Aug 30, 2019 at 3:46 PM Joe Perches <joe@perches.com> wrote:
> > > On Fri, 2019-08-30 at 21:58 +0000, Tim.Bird@sony.com wrote:
> > > > > From: Joe Perches
> > > []
> > > > IMHO %pV should be avoided if possible.  Just because people are
> > > > doing it doesn't mean it should be used when it is not necessary.
> > > 
> > > Well, as the guy that created %pV, I of course
> > > have a different opinion.
> > > 
> > > > >  then wouldn't it be easier to pass in the
> > > > > > kernel level as a separate parameter and then strip off all printk
> > > > > > headers like this:
> > > > > 
> > > > > Depends on whether or not you care for overall
> > > > > object size.  Consolidated formats with the
> > > > > embedded KERN_<LEVEL> like suggested are smaller
> > > > > overall object size.
> > > > 
> > > > This is an argument I can agree with.  I'm generally in favor of
> > > > things that lessen kernel size creep. :-)
> > > 
> > > As am I.
> > 
> > Sorry, to be clear, we are talking about the object size penalty due
> > to adding a single parameter to a function. Is that right?
> 
> Not exactly.  The argument is that pre-pending the different KERN_LEVEL
> strings onto format strings can result in several versions of nearly identical strings
> being compiled into the object file.  By parameterizing this (that is, adding
> '%s' into the format string, and putting the level into the string as an argument),
> it prevents this duplication of format strings.
> 
> I haven't seen the data on duplication of format strings, and how much this
> affects it, but little things can add up.  Whether it matters in this case depends
> on whether the format strings that kunit uses are also used elsewhere in the kernel,
> and whether these same format strings are used with multiple kernel message levels.

deduplication can matter as well, but so far
there is little content with kunit_(err|warn|info(=)

kunit/example-test.c:   kunit_info(test, "initializing\n");
kunit/test.c:           kunit_err(test,
kunit/test.c:                   kunit_err(test, "%s", fragment->fragment);
kunit/test.c:           kunit_err(test, "\n");
kunit/test.c:           kunit_err(test, "%s", buf);
kunit/test.c:                   kunit_err(test, "failed to initialize: %d\n", ret);
kunit/test.c:                   kunit_err(test, "test case timed out\n");
kunit/test.c:                   kunit_err(test, "internal error occurred preventing test case from running: %d\n",
kunit/try-catch.c:              kunit_err(test, "try timed out\n");
kunit/try-catch.c:              kunit_err(test, "wake_up_process() was never called\n");
kunit/try-catch.c:              kunit_err(test, "Unknown error: %d\n", exit_code);

Of these, only two do match other kernel uses.

"initializing\n", "failed to initialize: %d\n"


