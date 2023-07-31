Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876D876A068
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 20:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjGaS3H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 14:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjGaS3A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 14:29:00 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDE51FC6;
        Mon, 31 Jul 2023 11:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1690828125; bh=7NrEnQxXICxhw0/8TiGcDTN7V2/dgz44Rd+KTW46XH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WbV3E8IWxUYOWeDUuQprLuCoGp3MIH2ALt16eJfJgVko1lMHMfHWC1jmiYvSjN0O4
         b1V5XB2JI+/jDUhYUmKEBd3dyrEygjp2OCzKOJp/6sVEIWMGYYquL4W5BivSXmzQas
         alFvO0/zWI/cx29RXEiZDfLEUYGTluJQM/cAzzyY=
Date:   Mon, 31 Jul 2023 20:28:44 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Yuan Tan <tanyuan@tinylab.org>
Cc:     w@1wt.eu, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selftests/nolibc: add testcase for pipe
Message-ID: <51b39ee9-7645-4759-9cc0-3cfe721a2757@t-8ch.de>
References: <cover.1690733545.git.tanyuan@tinylab.org>
 <9221753abe0509ef5cbb474a31873012e0e40706.1690733545.git.tanyuan@tinylab.org>
 <a4899657-7d7b-4786-8903-8f51e438535d@t-8ch.de>
 <C3AF612281F87D1A+733ce5c0d1efe1f81423e6885203d92cdb4eaee7.camel@tinylab.org>
 <2ba88bae-2986-4e70-9828-824d7b140277@t-8ch.de>
 <D55D0905148FA2ED+f06092bae15b312ff1b29ad170fb656b89722b30.camel@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D55D0905148FA2ED+f06092bae15b312ff1b29ad170fb656b89722b30.camel@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-08-01 02:01:36+0800, Yuan Tan wrote:
> Hi Thomas,
> On Mon, 2023-07-31 at 17:41 +0200, Thomas Weißschuh wrote:
> > On 2023-07-31 20:35:28+0800, Yuan Tan wrote:
> > > On Mon, 2023-07-31 at 08:10 +0200, Thomas Weißschuh wrote:
> > > > On 2023-07-31 13:51:00+0800, Yuan Tan wrote:
> > > > > Add a testcase of pipe that child process sends message to
> > > > > parent
> > > > > process.
> > > > 
> > > > Thinking about it some more:
> > > > 
> > > > What's the advantage of going via a child process?
> > > > The pipe should work the same within the same process.
> > > > 
> > > 
> > > The pipe is commonly used for process communication, and I think as
> > > a
> > > test case it is supposed to cover the most common scenarios.
> > 
> > The testcase is supposed to cover the code of nolibc.
> > It should be the *minimal* amount of code to be reasonable sure that
> > the
> > code in nolibc does the correct thing.
> > If pipe() returns a value that behaves like a pipe I see no reason to
> > doubt it will also survive fork().
> > 
> > Validating that would mean testing the kernel and not nolibc.
> > For the kernel there are different testsuites.
> > 
> > Less code means less work for everyone involved, now and in the
> > future.
> > 
> 
> It's a good point and I never thought about this aspect.
> 
> I wonder whether the code below is enough?
> 
> static int test_pipe(void)
> {
> 	int pipefd[2];
> 
> 	if (pipe(pipefd) == -1)
> 		return 1;
> 
> 	close(pipefd[0]);
> 	close(pipefd[1]);
> 
> 	return 0;
> }

That is very barebones.

If accidentally a wrong syscall number was used and the used syscall
would not take any arguments this test would still succeed.

Keeping the write-read-cycle from the previous revision would test that
nicely. Essentially the same code as before but without the fork().

> 
> And I forgot to add this line:
> 
> 	CASE_TEST(pipe); EXPECT_SYSZR(1, test_pipe()); break;
> 
> I will add it in next patch.
> 
