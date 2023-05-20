Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F60970A870
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 May 2023 16:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjETOKJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 May 2023 10:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjETOKI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 May 2023 10:10:08 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26CE8102;
        Sat, 20 May 2023 07:10:05 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 34KE9n6D027634;
        Sat, 20 May 2023 16:09:49 +0200
Date:   Sat, 20 May 2023 16:09:49 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Zhangjin Wu <falcon@tinylab.org>, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, shuah@kernel.org
Subject: Re: [PATCH] selftests/nolibc: Fix up compile error for rv32
Message-ID: <20230520140949.GA27611@1wt.eu>
References: <20230520-nolibc-stackprotector-riscv-v1-1-d8912012a034@weissschuh.net>
 <20230520120254.66315-1-falcon@tinylab.org>
 <958f09b4-8cd7-46b3-aa54-4d981fd8f1bc@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <958f09b4-8cd7-46b3-aa54-4d981fd8f1bc@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, May 20, 2023 at 04:00:54PM +0200, Thomas Weißschuh wrote:
> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > index 063f9959ac44..d8b59c8f6c03 100644
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > @@ -596,7 +596,7 @@ int run_syscall(int min, int max)
> >  		CASE_TEST(write_badf);        EXPECT_SYSER(1, write(-1, &tmp, 1), -1, EBADF); break;
> >  		CASE_TEST(write_zero);        EXPECT_SYSZR(1, write(1, &tmp, 0)); break;
> >  		CASE_TEST(syscall_noargs);    EXPECT_SYSEQ(1, syscall(__NR_getpid), getpid()); break;
> > -		CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_fstat, 0, NULL), -1, EFAULT); break;
> > +		CASE_TEST(syscall_args);      EXPECT_SYSER(1, syscall(__NR_read, -1, &tmp, 1), -1, EBADF); break;
> 
> The goal of this second test was to make sure that arguments are passed
> in the correct order. For this I tried to have a syscall were the
> checked error is generated from a non-first argument.
> (The NULL generating the EFAULT).
> So the new check does not fullfil this goal anymore.

Ah OK good to know.

> Maybe we can find a new syscall to test with?

Maybe it would be worth considering pselect() or equivalent which
involve many arguments. I don't know if rv32 has fstatat() or
lstat() for example, that could be used as alternatives ?

> The code should have had a comment I guess.

Indeed ;-)

With that said, if rv32 is missing some essential syscalls, my question
regarding its relevance here still holds!

Willy
