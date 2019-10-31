Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5488EAD0F
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2019 11:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfJaKHY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Oct 2019 06:07:24 -0400
Received: from smtprelay0006.hostedemail.com ([216.40.44.6]:41733 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726193AbfJaKHY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Oct 2019 06:07:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 66010180A5AFF;
        Thu, 31 Oct 2019 10:07:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2692:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:9012:10004:10226:10400:10848:11026:11232:11658:11914:12043:12109:12297:12438:12740:12760:12895:13069:13255:13311:13357:13439:14096:14097:14659:14721:21080:21433:21451:21627:21740:30054:30060:30090:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: kite22_402863056ff25
X-Filterd-Recvd-Size: 2589
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Thu, 31 Oct 2019 10:07:20 +0000 (UTC)
Message-ID: <bd76d5c22f389f3e6ecc2575e32c906f79647765.camel@perches.com>
Subject: Re: [PATCH linux-kselftest/test v6] lib/list-test: add a test for
 the 'list' doubly linked list
From:   Joe Perches <joe@perches.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     shuah <shuah@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 31 Oct 2019 03:07:12 -0700
In-Reply-To: <20191031085129.GA217570@google.com>
References: <20191024224631.118656-1-davidgow@google.com>
         <0cb1d948-0da3-eb0f-c58f-ae3a785dd0dd@kernel.org>
         <CABVgOSmCHbGjZBjeWSbPEZbJw22SaBQnoO77xxNzN_ugAwzNiQ@mail.gmail.com>
         <20191030104217.GA18421@kadam>
         <42a8270d-ed6f-d29f-5e71-7b76a074b63e@kernel.org>
         <CAFd5g47OZ8x9=etJUj4Sgsw38VQb0j=omOUsubc7+pb2rJi0bQ@mail.gmail.com>
         <fad58e4f48237894de0d511adf1d663a42a2eee7.camel@perches.com>
         <20191031085129.GA217570@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2019-10-31 at 01:51 -0700, Brendan Higgins wrote:
> On Wed, Oct 30, 2019 at 10:18:44AM -0700, Joe Perches wrote:
> > On Wed, 2019-10-30 at 09:35 -0700, Brendan Higgins wrote:
> > > Agreed. I can see the point of not wanting to write an exception into
> > > checkpatch for every exception of it's general rules; however, it
> > > would be nice if there was a way to maybe have a special comment or
> > > something that could turn off a checkpatch error. That way, a
> > > checkpatch error/warning always means some action should be taken, and
> > > if a rule is being ignored, there is always documentation as to why.
> > 
> > That couldn't work when a comment which may exist
> > in a file is out of scope of the patch context.
> 
> Sorry, I don't understand exactly what you mean. Can you elaborate?

checkpatch works on patch contexts.
If the comment is not within the patch context,
checkpatch cannot ignore various test.

> static void list_test_list_for_each_prev(struct kunit *test) /* checkpatch: disable=for-each-format */

Long line, now what?


