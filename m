Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6424A76A9DE
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 09:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjHAHUT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 03:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjHAHUS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 03:20:18 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF0D127;
        Tue,  1 Aug 2023 00:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1690874416; bh=oPLRJeP7pEbYEAflMX0lbavw4LiKFIz8YKMq9HPm5cU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ANQUw9GHMUHiXpD1ILKnUJwJlq9SVBSDvi1X4pFjCpfwIDWPlpqpOF+WPbt3ZSLv0
         9KDQMNnbwcc7o2DbN0KxBF0c6JpOzNtMsIovyjnO7F0PM1G2KKzoztyv2Ci1XIcqMI
         Ii0/y7ZrEXMUTkN4lkfTK3cBYKsrk6W/N8taRFbs=
Date:   Tue, 1 Aug 2023 09:20:15 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Yuan Tan <tanyuan@tinylab.org>
Cc:     w@1wt.eu, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selftests/nolibc: add testcase for pipe
Message-ID: <413f70e4-245e-474a-9293-05068fd2eeb5@t-8ch.de>
References: <cover.1690733545.git.tanyuan@tinylab.org>
 <9221753abe0509ef5cbb474a31873012e0e40706.1690733545.git.tanyuan@tinylab.org>
 <a4899657-7d7b-4786-8903-8f51e438535d@t-8ch.de>
 <C3AF612281F87D1A+733ce5c0d1efe1f81423e6885203d92cdb4eaee7.camel@tinylab.org>
 <2ba88bae-2986-4e70-9828-824d7b140277@t-8ch.de>
 <D55D0905148FA2ED+f06092bae15b312ff1b29ad170fb656b89722b30.camel@tinylab.org>
 <51b39ee9-7645-4759-9cc0-3cfe721a2757@t-8ch.de>
 <2ADAE3198D1A85E3+c1c957d4706ee51d90e0b2a425a633eafcca8810.camel@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ADAE3198D1A85E3+c1c957d4706ee51d90e0b2a425a633eafcca8810.camel@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-08-01 14:51:40+0800, Yuan Tan wrote:
> Hi Thomas,
> 
> On Mon, 2023-07-31 at 20:28 +0200, Thomas Weißschuh wrote:
> > On 2023-08-01 02:01:36+0800, Yuan Tan wrote:
> > > Hi Thomas,
> > > On Mon, 2023-07-31 at 17:41 +0200, Thomas Weißschuh wrote:
> > > > On 2023-07-31 20:35:28+0800, Yuan Tan wrote:
> > > > > On Mon, 2023-07-31 at 08:10 +0200, Thomas Weißschuh wrote:
> > > > > > On 2023-07-31 13:51:00+0800, Yuan Tan wrote:
> > > > > > > Add a testcase of pipe that child process sends message to
> > > > > > > parent
> > > > > > > process.
> > > > > > 
> > > > > > Thinking about it some more:
> > > > > > 
> > > > > > What's the advantage of going via a child process?
> > > > > > The pipe should work the same within the same process.
> > > > > > 
> > > > > 
> > > > > The pipe is commonly used for process communication, and I
> > > > > think as
> > > > > a
> > > > > test case it is supposed to cover the most common scenarios.
> > > > 
> > > > The testcase is supposed to cover the code of nolibc.
> > > > It should be the *minimal* amount of code to be reasonable sure
> > > > that
> > > > the
> > > > code in nolibc does the correct thing.
> > > > If pipe() returns a value that behaves like a pipe I see no
> > > > reason to
> > > > doubt it will also survive fork().
> > > > 
> > > > Validating that would mean testing the kernel and not nolibc.
> > > > For the kernel there are different testsuites.
> > > > 
> > > > Less code means less work for everyone involved, now and in the
> > > > future.
> > > > 
> > > 
> > > It's a good point and I never thought about this aspect.
> > > 
> > > I wonder whether the code below is enough?
> > > 
> > > static int test_pipe(void)
> > > {
> > >         int pipefd[2];
> > > 
> > >         if (pipe(pipefd) == -1)
> > >                 return 1;
> > > 
> > >         close(pipefd[0]);
> > >         close(pipefd[1]);
> > > 
> > >         return 0;
> > > }
> > 
> > That is very barebones.
> > 
> > If accidentally a wrong syscall number was used and the used syscall
> > would not take any arguments this test would still succeed.
> > 
> > Keeping the write-read-cycle from the previous revision would test
> > that
> > nicely. Essentially the same code as before but without the fork().
> > 
> > > 
> > > And I forgot to add this line:
> > > 
> > >         CASE_TEST(pipe); EXPECT_SYSZR(1, test_pipe()); break;
> > > 
> > > I will add it in next patch.
> > > 
> > 
> 
> In the situation you described, that is indeed the case.
> 
> Would this be fine?
> 
> static int test_pipe(void)
> {
> 	const char *const msg = "hello, nolibc";
> 	int pipefd[2];
> 	char buf[32];
> 	ssize_t len;
> 
> 	if (pipe(pipefd) == -1)
> 		return 1;
> 
> 	write(pipefd[1], msg, strlen(msg));
> 	close(pipefd[1]);
> 	len = read(pipefd[0], buf, sizeof(buf));
> 	close(pipefd[0]);
> 
> 	if (len != strlen(msg))
> 		return 1;
> 
> 	return !!memcmp(buf, msg, len);
> }

Looks good!

The return value of write() could also be validated but given we
validate the return value from read() it shouldn't make a difference.

(Also the manual manipulation of "buf" is gone that necessitated the
check in v1 of the series)
