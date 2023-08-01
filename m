Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608D076B4A4
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 14:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjHAMXQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 08:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbjHAMXP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 08:23:15 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC17710C7;
        Tue,  1 Aug 2023 05:23:12 -0700 (PDT)
X-QQ-mid: bizesmtp70t1690892583t5qcjea9
Received: from [172.18.158.193] ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 01 Aug 2023 20:23:01 +0800 (CST)
X-QQ-SSF: 01200000000000705000000A0000000
X-QQ-FEAT: /HVSeQejYqeukwY+5U51CoTHCtxI/FujKVlUNhoey4l+spnmPw0fyQVwrZIRa
        UDsvCxmM76dNz8Wi3KydRfNZkPDenTZjRjS+uDnN7FkoVkJoL0WN8ASn/4XEOyBRXEmX10j
        Z2xUDXT9doFuQTv16SXmcZ8b7aBNYRywRyDKC7QROkUnBDdEI7s7WP25/gxGuY+Pqeksivn
        MpBzMN4/woTic5kQZxbMBR1rY/gCXYr3HehHSBY5BvlcbS7JqMSBeRcLyISOlxkNk7CZIJc
        n0PS3nTR/sVoET2GXfOFpy/6u5yLRxXOiYF+54l1nsc5X0l9JHrK3jZ8uePSgzDmCDANYer
        +dp0G/7UDGeqO+GBoxFsShXhGogSBb4S35NCBkBhSnuf5AGgAuWdXzmSsTZIg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11186999854354669786
Message-ID: <CEF9B5A6B5C43FBB+a5f21a530c1baf5229614c8186043e223b9d111f.camel@tinylab.org>
Subject: Re: [PATCH v2 2/2] selftests/nolibc: add testcase for pipe
From:   Yuan Tan <tanyuan@tinylab.org>
To:     Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     w@1wt.eu, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org
Date:   Tue, 01 Aug 2023 20:23:02 +0800
In-Reply-To: <413f70e4-245e-474a-9293-05068fd2eeb5@t-8ch.de>
References: <cover.1690733545.git.tanyuan@tinylab.org>
         <9221753abe0509ef5cbb474a31873012e0e40706.1690733545.git.tanyuan@tinylab.org>
         <a4899657-7d7b-4786-8903-8f51e438535d@t-8ch.de>
         <C3AF612281F87D1A+733ce5c0d1efe1f81423e6885203d92cdb4eaee7.camel@tinylab.org>
         <2ba88bae-2986-4e70-9828-824d7b140277@t-8ch.de>
         <D55D0905148FA2ED+f06092bae15b312ff1b29ad170fb656b89722b30.camel@tinylab.org>
         <51b39ee9-7645-4759-9cc0-3cfe721a2757@t-8ch.de>
         <2ADAE3198D1A85E3+c1c957d4706ee51d90e0b2a425a633eafcca8810.camel@tinylab.org>
         <413f70e4-245e-474a-9293-05068fd2eeb5@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Thomas,

On Tue, 2023-08-01 at 09:20 +0200, Thomas Weißschuh wrote:
> On 2023-08-01 14:51:40+0800, Yuan Tan wrote:
> > Hi Thomas,
> > 
> > On Mon, 2023-07-31 at 20:28 +0200, Thomas Weißschuh wrote:
> > > On 2023-08-01 02:01:36+0800, Yuan Tan wrote:
> > > > Hi Thomas,
> > > > On Mon, 2023-07-31 at 17:41 +0200, Thomas Weißschuh wrote:
> > > > > On 2023-07-31 20:35:28+0800, Yuan Tan wrote:
> > > > > > On Mon, 2023-07-31 at 08:10 +0200, Thomas Weißschuh wrote:
> > > > > > > On 2023-07-31 13:51:00+0800, Yuan Tan wrote:
> > > > > > > > Add a testcase of pipe that child process sends message
> > > > > > > > to
> > > > > > > > parent
> > > > > > > > process.
> > > > > > > 
> > > > > > > Thinking about it some more:
> > > > > > > 
> > > > > > > What's the advantage of going via a child process?
> > > > > > > The pipe should work the same within the same process.
> > > > > > > 
> > > > > > 
> > > > > > The pipe is commonly used for process communication, and I
> > > > > > think as
> > > > > > a
> > > > > > test case it is supposed to cover the most common
> > > > > > scenarios.
> > > > > 
> > > > > The testcase is supposed to cover the code of nolibc.
> > > > > It should be the *minimal* amount of code to be reasonable
> > > > > sure
> > > > > that
> > > > > the
> > > > > code in nolibc does the correct thing.
> > > > > If pipe() returns a value that behaves like a pipe I see no
> > > > > reason to
> > > > > doubt it will also survive fork().
> > > > > 
> > > > > Validating that would mean testing the kernel and not nolibc.
> > > > > For the kernel there are different testsuites.
> > > > > 
> > > > > Less code means less work for everyone involved, now and in
> > > > > the
> > > > > future.
> > > > > 
> > > > 
> > > > It's a good point and I never thought about this aspect.
> > > > 
> > > > I wonder whether the code below is enough?
> > > > 
> > > > static int test_pipe(void)
> > > > {
> > > >         int pipefd[2];
> > > > 
> > > >         if (pipe(pipefd) == -1)
> > > >                 return 1;
> > > > 
> > > >         close(pipefd[0]);
> > > >         close(pipefd[1]);
> > > > 
> > > >         return 0;
> > > > }
> > > 
> > > That is very barebones.
> > > 
> > > If accidentally a wrong syscall number was used and the used
> > > syscall
> > > would not take any arguments this test would still succeed.
> > > 
> > > Keeping the write-read-cycle from the previous revision would
> > > test
> > > that
> > > nicely. Essentially the same code as before but without the
> > > fork().
> > > 
> > > > 
> > > > And I forgot to add this line:
> > > > 
> > > >         CASE_TEST(pipe); EXPECT_SYSZR(1, test_pipe()); break;
> > > > 
> > > > I will add it in next patch.
> > > > 
> > > 
> > 
> > In the situation you described, that is indeed the case.
> > 
> > Would this be fine?
> > 
> > static int test_pipe(void)
> > {
> >         const char *const msg = "hello, nolibc";
> >         int pipefd[2];
> >         char buf[32];
> >         ssize_t len;
> > 
> >         if (pipe(pipefd) == -1)
> >                 return 1;
> > 
> >         write(pipefd[1], msg, strlen(msg));
> >         close(pipefd[1]);
> >         len = read(pipefd[0], buf, sizeof(buf));
> >         close(pipefd[0]);
> > 
> >         if (len != strlen(msg))
> >                 return 1;
> > 
> >         return !!memcmp(buf, msg, len);
> > }
> 
> Looks good!
> 
> The return value of write() could also be validated but given we
> validate the return value from read() it shouldn't make a difference.
> 
> (Also the manual manipulation of "buf" is gone that necessitated the
> check in v1 of the series)
> 

I am sorry that I didn't catch your last sentence.

Did you mean this piece of code does not need any further modifications
right?

