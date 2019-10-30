Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20E6EEA40D
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2019 20:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfJ3TX5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Oct 2019 15:23:57 -0400
Received: from smtprelay0162.hostedemail.com ([216.40.44.162]:39650 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726268AbfJ3TX5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Oct 2019 15:23:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id E1847180A8153;
        Wed, 30 Oct 2019 19:23:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:41:355:379:599:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3353:3622:3865:3867:3868:3870:3871:3872:3873:3874:4321:5007:6691:7903:8700:9012:10004:10400:11232:11658:11914:12109:12297:12740:12760:12895:13069:13095:13255:13311:13357:13439:14096:14097:14659:21080:21433:21627:21740:30012:30054:30090:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: straw99_3f32d4013c734
X-Filterd-Recvd-Size: 2714
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Wed, 30 Oct 2019 19:23:54 +0000 (UTC)
Message-ID: <f665ec7b21527c7095a61dd5c2f48fd00df0d5c9.camel@perches.com>
Subject: Re: [PATCH linux-kselftest/test v6] lib/list-test: add a test for
 the 'list' doubly linked list
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>, shuah <shuah@kernel.org>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 30 Oct 2019 12:23:45 -0700
In-Reply-To: <20191030191255.GD18421@kadam>
References: <20191024224631.118656-1-davidgow@google.com>
         <0cb1d948-0da3-eb0f-c58f-ae3a785dd0dd@kernel.org>
         <CABVgOSmCHbGjZBjeWSbPEZbJw22SaBQnoO77xxNzN_ugAwzNiQ@mail.gmail.com>
         <20191030104217.GA18421@kadam>
         <42a8270d-ed6f-d29f-5e71-7b76a074b63e@kernel.org>
         <20191030191255.GD18421@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2019-10-30 at 22:12 +0300, Dan Carpenter wrote:
> On Wed, Oct 30, 2019 at 10:27:12AM -0600, shuah wrote:
> > > It's better to ignore checkpatch and other scripts when they are wrong.
> > > (unless the warning message inspires you to make the code more readable
> > > for humans).
> > > 
> > 
> > It gets confusing when to ignore and when not to. It takes work to
> > figure out and it is subjective.
> > 
> 
> In this case, it's not subjective because checkpatch is clearly not
> working as intended.

checkpatch _is_ working as intended.
It was never intended to be perfect.

checkpatch _always_ depended on a reviewer deciding
whether its output was appropriate.

> I don't feel like "checkpatch clean" is a useful criteria for applying
> patches.

Nor do I.

> The other things about warnings is that I always encourage people to
> just ignore old warnings.  If you're running Smatch and you see a
> warning in ancient code that means I saw it five years ago and didn't
> fix it so it's a false positive.  Old warnings are always 100% false
> positives.

That'd be not absolute either because it depended on your
historical judgment as to whether an old warning was in fact
a defect or not.

People make mistakes.
Regex based scripts are by design stupid and untrustworthy.

Mistakes will be made.
Just fix the actual defects in code as soon as possible.


