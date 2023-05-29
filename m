Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FA8714889
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 13:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjE2Lcg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 07:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjE2Lcf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 07:32:35 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C73F7BE;
        Mon, 29 May 2023 04:32:30 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 34TBVhxm002783;
        Mon, 29 May 2023 13:31:43 +0200
Date:   Mon, 29 May 2023 13:31:43 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: Re: [PATCH 00/13] tools/nolibc: riscv: Add full rv32 support
Message-ID: <20230529113143.GB2762@1wt.eu>
References: <b25f79f0-a8fb-428a-ad54-fc4afe0df6ff@t-8ch.de>
 <20230528183906.22547-1-falcon@tinylab.org>
 <f7332511-bb3f-4067-a0af-b6880294eded@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7332511-bb3f-4067-a0af-b6880294eded@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Thomas,

On Mon, May 29, 2023 at 10:45:40AM +0200, Thomas Weißschuh wrote:
> <lots of implementation>
> 
> > usage:
> > 
> >     $ gcc -o nolibc-test tools/testing/selftests/nolibc/nolibc-test.c
> >     $ ./nolibc-test
> >     ...
> >     35 gettimeofday_tz = 0                                           [OK]
> >     36 gettimeofday_tv_tz = 0                                        [OK]
> >     37 gettimeofday_bad1 = -1                                       [FAIL] (continued by sigaction/siglongjmp/sigsetjmp)
> >     38 gettimeofday_bad2 = -1                                       [FAIL] (continued by sigaction/siglongjmp/sigsetjmp)
> >     39 getpagesize = 0                                               [OK]
> >     40 ioctl_tiocinq = 0                                             [OK]
> >     41 ioctl_tiocinq = 0                                             [OK]
> >     ...
> > 
> > It did work as expected, but for nolibc, we still need to add sigaction/siglongjump/sigsetjmp support.
> > 
> > Will send a patch based on Willy's latest branch, perhaps this may help us to
> > verify the future sigaction/siglongjump/sigsetjmp for nolibc.
> > 
> > ref: https://www.ibm.com/docs/en/i/7.1?topic=ssw_ibm_i_71/apis/sigsetj.html
> >      https://www.ibm.com/docs/en/zos/2.1.0?topic=functions-siglongjmp-restore-stack-environment-signal-mask
> 
> This seems very complicated for fairly limited gain to be honest.

I agree as well. I'm not denying the fact that one day we may want to
support signal, longjmp and friends but I'm not convinced we want to
go through that just to make a few uncertain tests succeed.

> If we really want to keep the current testcase we could also ensure that
> the pointer does not fall into the first page, as the first page is not
> mapped under Linux:
> 
> 0 <= addr < PAGE_SIZE
> 
> Or instead of PAGE_SIZE just hardcode 4096, as that should be the
> minimum size and and does not require a lookup.

I would not even do that. It brings nothing to the application layer and
inflates the code. I'd rather just get rid of the EFAULT test cases that
rely on an unreliable syscall (i.e. one that may either be a real syscall
or an emulated one). The value brought by these tests is extremely low
and they were implemented only because they were easy to do. If they're
causing pain, let's just drop them.

Willy
