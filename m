Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01EBFA40A6
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2019 00:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfH3WqS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 18:46:18 -0400
Received: from smtprelay0153.hostedemail.com ([216.40.44.153]:60114 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728143AbfH3WqS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 18:46:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 30292837F24A;
        Fri, 30 Aug 2019 22:46:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::,RULES_HIT:41:305:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:6742:7576:7807:8603:10004:10400:10848:11232:11658:11914:12297:12663:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21094:21627:21796:30036:30054:30091,0,RBL:47.151.137.30:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: cream33_197a4f8aa505a
X-Filterd-Recvd-Size: 2154
Received: from XPS-9350.home (unknown [47.151.137.30])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Fri, 30 Aug 2019 22:46:14 +0000 (UTC)
Message-ID: <ca01d8c4823c63db52fc0f18d62334aeb5634a50.camel@perches.com>
Subject: Re: [PATCH v2] kunit: fix failure to build without printk
From:   Joe Perches <joe@perches.com>
To:     Tim.Bird@sony.com, brendanhiggins@google.com
Cc:     shuah@kernel.org, sergey.senozhatsky.work@gmail.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, frowand.list@gmail.com,
        sboyd@kernel.org, pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, rdunlap@infradead.org, sfr@canb.auug.org.au
Date:   Fri, 30 Aug 2019 15:46:13 -0700
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF977A8392@USCULXMSG01.am.sony.com>
References: <20190828093143.163302-1-brendanhiggins@google.com>
         <20190828094929.GA14038@jagdpanzerIV>
         <8b2d63bf-56cd-e8f5-e8ee-2891c2c1be8f@kernel.org>
         <f2d5b474411b2940d62198490f06e77890fbdb32.camel@perches.com>
         <20190830183821.GA30306@google.com>
         <bc688b00b2995e4b11229c3d4d90f532e00792c7.camel@perches.com>
         <ECADFF3FD767C149AD96A924E7EA6EAF977A8392@USCULXMSG01.am.sony.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2019-08-30 at 21:58 +0000, Tim.Bird@sony.com wrote:
> > From: Joe Perches
[]
> IMHO %pV should be avoided if possible.  Just because people are
> doing it doesn't mean it should be used when it is not necessary.

Well, as the guy that created %pV, I of course
have a different opinion.

> >  then wouldn't it be easier to pass in the
> > > kernel level as a separate parameter and then strip off all printk
> > > headers like this:
> > 
> > Depends on whether or not you care for overall
> > object size.  Consolidated formats with the
> > embedded KERN_<LEVEL> like suggested are smaller
> > overall object size.
> 
> This is an argument I can agree with.  I'm generally in favor of
> things that lessen kernel size creep. :-)

As am I.

