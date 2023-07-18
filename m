Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEFA758347
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 19:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjGRROi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 13:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjGRROh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 13:14:37 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6F3C1710;
        Tue, 18 Jul 2023 10:14:31 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 36IHENeq014396;
        Tue, 18 Jul 2023 19:14:23 +0200
Date:   Tue, 18 Jul 2023 19:14:23 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: nolibc: KTAP output and test reports
Message-ID: <ZLbIb9wmixqy9RIw@1wt.eu>
References: <cc03380f-594f-431b-941d-aea879a0c084@t-8ch.de>
 <c6d3cabb-84f9-4f00-bfdd-de6810ed4c99@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6d3cabb-84f9-4f00-bfdd-de6810ed4c99@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Thomas,

On Tue, Jul 18, 2023 at 09:31:06AM +0200, Thomas Weißschuh wrote:
> Hi Willy,
> 
> On 2023-06-08 00:15:27+0200, Thomas Weißschuh wrote:
> > after your recent discussions about the test output and report I
> > wondered if it would make sense to switch nolibc-test to KTAP output
> > format [0].
> > 
> > With this it would be possible to have a wrapper script run each
> > architecture test as its own test subcomponent.
> > A (K)TAP parser/runner could then directly recognize and report failing
> > testcases, making it easier to validate.
> > 
> > Also maybe we can hook it up into the regular kselftests setup and have
> > the bots run it as part of that.
> > 
> > The kernel even includes a header-only library to implement the format [1].
> > It also should be fairly easy to emit the format without a library.
> 
> Did you have a chance to look at this?
>
> If you are not categorically opposed I would create a proof of concept
> for further discussion.

I remember I had a quick look but had no opinion about it: it's not very
clear to me how this will be consumed because I don't know the tools
around and cannot invest time learning them. If you think it can bring
some value without complicating the usage, maintenance and contribution
of what we currently have, maybe let's give it a try. But I would like
to be sure we are careful about preserving the current ease of use, as
I'd hate to have to go through the makefile to figure how to get back
the simple output format that we can trivially read or grep without any
extra tools. That might for example mean that we'd need an option to
change the output format (and I think it's possible because most of the
outputs are done inside wrappers).

But in any case, feel free to explore, experiment and share your findings.
Hoping this helps,
Willy
