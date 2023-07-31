Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D77D769FEB
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 20:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjGaSBt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 14:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjGaSBs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 14:01:48 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E4210FE;
        Mon, 31 Jul 2023 11:01:44 -0700 (PDT)
X-QQ-mid: bizesmtp86t1690826498tm73udf9
Received: from [172.18.158.193] ( [61.141.77.223])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 01 Aug 2023 02:01:36 +0800 (CST)
X-QQ-SSF: 01200000008000705000B00A0000000
X-QQ-FEAT: sU1umfd9FQwYD3Dnzw6dLjCk+0qWC5bpBuoTMzOkmwfLu1z3lH6c1+3snZrEG
        h4o627+yNar7kT3cxgCjGYHI0/THGjk/8XQ/mx+fQoCa2zbTug92RCCv3WV4GfZtIefcAS2
        KhmlvQFGtG9ebYQ2klhkbjp53HOWKlpgecR90BqTSK74631gGG9BvhDe4jD9Og7pDQ4GWAh
        mCcKWiypiIQym9z53gfwWYQ1+h1DSLFv74dr11Xz6Jw73BeD+wiMdjeAhSH7GLhBmHyN/xA
        YAoM8Njp8NYCoZsGsxhEG358YFjaI314x5ZFw+uaw0GTsB6ijj0sEHzZgEOH7fmwrAXcmmE
        vLJd4x5e+f2auguc6VTeD03KUSvig==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7389391330833672125
Message-ID: <D55D0905148FA2ED+f06092bae15b312ff1b29ad170fb656b89722b30.camel@tinylab.org>
Subject: Re: [PATCH v2 2/2] selftests/nolibc: add testcase for pipe
From:   Yuan Tan <tanyuan@tinylab.org>
To:     Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     w@1wt.eu, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org
Date:   Tue, 01 Aug 2023 02:01:36 +0800
In-Reply-To: <2ba88bae-2986-4e70-9828-824d7b140277@t-8ch.de>
References: <cover.1690733545.git.tanyuan@tinylab.org>
         <9221753abe0509ef5cbb474a31873012e0e40706.1690733545.git.tanyuan@tinylab.org>
         <a4899657-7d7b-4786-8903-8f51e438535d@t-8ch.de>
         <C3AF612281F87D1A+733ce5c0d1efe1f81423e6885203d92cdb4eaee7.camel@tinylab.org>
         <2ba88bae-2986-4e70-9828-824d7b140277@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu1 
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
On Mon, 2023-07-31 at 17:41 +0200, Thomas Weißschuh wrote:
> On 2023-07-31 20:35:28+0800, Yuan Tan wrote:
> > On Mon, 2023-07-31 at 08:10 +0200, Thomas Weißschuh wrote:
> > > On 2023-07-31 13:51:00+0800, Yuan Tan wrote:
> > > > Add a testcase of pipe that child process sends message to
> > > > parent
> > > > process.
> > > 
> > > Thinking about it some more:
> > > 
> > > What's the advantage of going via a child process?
> > > The pipe should work the same within the same process.
> > > 
> > 
> > The pipe is commonly used for process communication, and I think as
> > a
> > test case it is supposed to cover the most common scenarios.
> 
> The testcase is supposed to cover the code of nolibc.
> It should be the *minimal* amount of code to be reasonable sure that
> the
> code in nolibc does the correct thing.
> If pipe() returns a value that behaves like a pipe I see no reason to
> doubt it will also survive fork().
> 
> Validating that would mean testing the kernel and not nolibc.
> For the kernel there are different testsuites.
> 
> Less code means less work for everyone involved, now and in the
> future.
> 

It's a good point and I never thought about this aspect.

I wonder whether the code below is enough?

static int test_pipe(void)
{
	int pipefd[2];

	if (pipe(pipefd) == -1)
		return 1;

	close(pipefd[0]);
	close(pipefd[1]);

	return 0;
}

And I forgot to add this line:

	CASE_TEST(pipe); EXPECT_SYSZR(1, test_pipe()); break;

I will add it in next patch.

