Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9CFEA1E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2019 17:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfJ3QiM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Oct 2019 12:38:12 -0400
Received: from smtprelay0215.hostedemail.com ([216.40.44.215]:60381 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726579AbfJ3QiL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Oct 2019 12:38:11 -0400
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Oct 2019 12:38:10 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 41ED41801CE35
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2019 16:31:57 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 78742100E7B4A;
        Wed, 30 Oct 2019 16:31:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:41:355:379:599:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3871:3872:3873:3874:4321:5007:9010:9012:10004:10400:11026:11232:11658:11914:12043:12109:12296:12297:12438:12663:12740:12760:12895:13069:13095:13255:13311:13357:13439:14181:14659:14721:21080:21433:21611:21627:30012:30029:30030:30054:30070:30090:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: wound59_10968ccdffb56
X-Filterd-Recvd-Size: 2106
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Wed, 30 Oct 2019 16:31:53 +0000 (UTC)
Message-ID: <af4a5d9d77482fb538b780989235d6d17d1f39cc.camel@perches.com>
Subject: Re: [PATCH linux-kselftest/test v6] lib/list-test: add a test for
 the 'list' doubly linked list
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        David Gow <davidgow@google.com>
Cc:     shuah <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 30 Oct 2019 09:31:45 -0700
In-Reply-To: <20191030104217.GA18421@kadam>
References: <20191024224631.118656-1-davidgow@google.com>
         <0cb1d948-0da3-eb0f-c58f-ae3a785dd0dd@kernel.org>
         <CABVgOSmCHbGjZBjeWSbPEZbJw22SaBQnoO77xxNzN_ugAwzNiQ@mail.gmail.com>
         <20191030104217.GA18421@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2019-10-30 at 13:42 +0300, Dan Carpenter wrote:
> On Wed, Oct 30, 2019 at 01:02:11AM -0700, David Gow wrote:
> > > ERROR: that open brace { should be on the previous line
> > > #869: FILE: lib/list-test.c:680:
> > > +static void list_test_list_for_each_entry_reverse(struct kunit *test)
> > > +{
> > > 
> > > 
> > > I am seeing these error and warns. As per our hallway conversation, the
> > > "for_each*" in the test naming is tripping up checkpatch.pl
> > > 
> > > For now you can change the name a bit to not trip checkpatch and maybe
> > > explore fixing checkpatch to differentiate between function names
> > > with "for_each" in them vs. the actual for_each usages in the code.
[]
> It's better to ignore checkpatch and other scripts when they are wrong.
> (unless the warning message inspires you to make the code more readable
> for humans).

True.


