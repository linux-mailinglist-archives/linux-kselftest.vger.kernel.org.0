Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A099A4123
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2019 01:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfH3XnQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 19:43:16 -0400
Received: from smtprelay0040.hostedemail.com ([216.40.44.40]:52317 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728122AbfH3XnP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 19:43:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id F37E6182244EB;
        Fri, 30 Aug 2019 23:43:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2110:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3873:3874:4321:5007:6742:7903:7974:8531:8603:9040:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:14777:21063:21080:21325:21433:21627:30054:30091,0,RBL:47.151.137.30:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: seat34_55d04a6b29a5b
X-Filterd-Recvd-Size: 2303
Received: from XPS-9350.home (unknown [47.151.137.30])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri, 30 Aug 2019 23:43:09 +0000 (UTC)
Message-ID: <91042c66d0e8fd6cb0b3baf0325bc1f8340738a3.camel@perches.com>
Subject: Re: [PATCH v2] kunit: fix failure to build without printk
From:   Joe Perches <joe@perches.com>
To:     Brendan Higgins <brendanhiggins@google.com>, Tim.Bird@sony.com
Cc:     shuah@kernel.org, sergey.senozhatsky.work@gmail.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, frowand.list@gmail.com,
        sboyd@kernel.org, pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, rdunlap@infradead.org, sfr@canb.auug.org.au
Date:   Fri, 30 Aug 2019 16:43:08 -0700
In-Reply-To: <20190830233710.GA101591@google.com>
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
         <20190830233710.GA101591@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2019-08-30 at 16:37 -0700, Brendan Higgins wrote:
> I thought you and Joe were arguing that "Joe's" resulted in a smaller
> object size than "Mine" (not to be confused with the actual patch I
> presented here, which is what Sergey suggested I do on a different
> thread).
> 
> I really don't feel strongly about what Sergey suggested I do (which is
> what this patch originally introduced), versus, what Joe suggested,
> versus what I suggested in response to Joe (or any of the things
> suggested on other threads). I just want to pick one, fix the breakage
> in linux-next, and move on with my life.

Well, if we are voting, I vote for mine! ;)

cheers, Joe

