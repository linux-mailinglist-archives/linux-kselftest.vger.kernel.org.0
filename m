Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BFD2531B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Aug 2020 16:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgHZOp3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Aug 2020 10:45:29 -0400
Received: from smtprelay0086.hostedemail.com ([216.40.44.86]:49674 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726700AbgHZOp2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Aug 2020 10:45:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 325391822326E;
        Wed, 26 Aug 2020 14:45:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2689:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4184:4321:5007:7903:7974:10004:10400:10848:11232:11658:11914:12043:12295:12297:12740:12760:12895:13069:13073:13311:13357:13439:14096:14097:14180:14181:14659:14721:21060:21080:21324:21325:21627:21972:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: owl38_5e0175327065
X-Filterd-Recvd-Size: 2293
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 26 Aug 2020 14:45:25 +0000 (UTC)
Message-ID: <7b78e43a01865ec0c296ad9acad0616a6c2c3b86.camel@perches.com>
Subject: Re: [PATCH 29/29] tools: Avoid comma separated statements
From:   Joe Perches <joe@perches.com>
To:     Thomas Renninger <trenn@suse.com>,
        Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Date:   Wed, 26 Aug 2020 07:45:24 -0700
In-Reply-To: <6011591.XMClsHuqKX@c100>
References: <cover.1598331148.git.joe@perches.com>
         <52b68acfeb441b483de188f7e100600291f8c3ec.1598331149.git.joe@perches.com>
         <6011591.XMClsHuqKX@c100>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2020-08-26 at 11:30 +0200, Thomas Renninger wrote:
> Hi,
> 
> getting rid of lines with multiple instructions, separated by comma is
> certainly a good idea.
> One nit pick, though:
> 
> Am Dienstag, 25. August 2020, 06:56:26 CEST schrieb Joe Perches:
> > Use semicolons and braces.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
[]
> I can remember patches being rejected with one line statements in a condition,
> surounded by braces.
> I just read up Documentation/process/coding-style.rst, to be sure this still is up-to-date.
> It's not a must, but line 180 says:
> "Do not unnecessarily use braces where a single statement will do."

Read the block immediately below that too:

"This does not apply if only one branch of a conditional statement is a
single statement; in the latter case use braces in both branches:"

> I haven't reviewed every line, but I expect you only split up comma separated instructions
> into separate lines and added braces?

I do not.

While there was a defect using this style though in another patch,
this is a style only change.

> Afaik there isn't a specific tag, but having:
> cleanup only: No functional change
> 
> in the changelog would be nice for people looking for fixes to backport.

This is not a fix, so it's not for backporting.


