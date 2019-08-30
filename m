Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5320A2EAD
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2019 06:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbfH3E4u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 00:56:50 -0400
Received: from smtprelay0133.hostedemail.com ([216.40.44.133]:53171 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725648AbfH3E4t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 00:56:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 3FC70909B;
        Fri, 30 Aug 2019 04:56:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3871:4321:5007:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12679:12740:12760:12895:13069:13095:13311:13357:13439:14659:14721:21080:21324:21433:21451:21627:30029:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: rake28_deb57dfa01b
X-Filterd-Recvd-Size: 2134
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Fri, 30 Aug 2019 04:56:45 +0000 (UTC)
Message-ID: <b9b83ce738fc0abde04ad82d0fa6786a1370fbab.camel@perches.com>
Subject: Re: [PATCH v2] kunit: fix failure to build without printk
From:   Joe Perches <joe@perches.com>
To:     shuah <shuah@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, frowand.list@gmail.com,
        sboyd@kernel.org, pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Thu, 29 Aug 2019 21:56:44 -0700
In-Reply-To: <f2d5b474411b2940d62198490f06e77890fbdb32.camel@perches.com>
References: <20190828093143.163302-1-brendanhiggins@google.com>
         <20190828094929.GA14038@jagdpanzerIV>
         <8b2d63bf-56cd-e8f5-e8ee-2891c2c1be8f@kernel.org>
         <f2d5b474411b2940d62198490f06e77890fbdb32.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2019-08-29 at 21:44 -0700, Joe Perches wrote:
> On Thu, 2019-08-29 at 11:01 -0600, shuah wrote:
[]
> > WARNING: Prefer [subsystem eg: netdev]_level([subsystem]dev, ... then 
> > dev_level(dev, ... then pr_level(...  to printk(KERN_LEVEL ...
> > #105: FILE: include/kunit/test.h:343:
> > +	printk(KERN_LEVEL "\t# %s: " fmt, (test)->name, ##__VA_ARGS__)
> > 
> > 
> > Is there supposed to be pr_level() - I can find dev_level()

btw: the checkpatch message is meant to be interpreted as

Prefer [subsystem eg: netdev]_<level>([subsystem]dev, ...) then dev_<level>(dev, ...) then pr_<level>(...), to printk(KERN_<LEVEL> ...)

btw2:

dev_level is actually not a function, but a convenience macro argument
which indirects to an actual specific logging function.

So no, there is not supposed to be a pr_level.


