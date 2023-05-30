Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4039715B10
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 12:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjE3KHS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 06:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjE3KHB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 06:07:01 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCFF11B;
        Tue, 30 May 2023 03:06:35 -0700 (PDT)
X-QQ-mid: bizesmtp74t1685441190tx4kv20c
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 18:06:29 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: TD6ADCIf0ML9HinHlDnN+wla+kJWeZiGgZXr7K2zL1s+nKaOjUA+mLu8YWevX
        oW+nIp2Or4iBsUmPqG7UbsXqjnN59kMfBy/O/soeeQv8ZdG6d7AWZlXI4U9MstgaW6RmWTj
        HHEJ8Nmu//iopS7nsTw1beCT2vKbo+UexM7RlCEJZXqwvD1pkkOc0etvW1d4cp5CcHuhOPo
        Xif25nTUaIoO3vQ4jkxPDd333CKNmvkc0nDnMYi0bCqRccmWO8JBJsesQFQm/x/zXpUrGLB
        AIEpyZg5TvS41A649x+/rQqimoGrJRW1Kpvcq0miBukKflxOoJ+EmNz31uPMoHtz66KEDKR
        ZlOCHkQTOgk+c772gubkRsWJFdCT5BYY9Efob4TV/Btb5oQc0SW4ldnw3NHQYbn6zbMTQ+M
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7193763827501342085
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: Re: [PATCH 00/13] tools/nolibc: riscv: Add full rv32 support
Date:   Tue, 30 May 2023 18:06:29 +0800
Message-Id: <20230530100629.383892-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230529113143.GB2762@1wt.eu>
References: <20230529113143.GB2762@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Thomas, Willy

> Hi Thomas,
> 
> On Mon, May 29, 2023 at 10:45:40AM +0200, Thomas Weißschuh wrote:
> > <lots of implementation>
> > 
> > > usage:
> > > 
> > >     $ gcc -o nolibc-test tools/testing/selftests/nolibc/nolibc-test.c
> > >     $ ./nolibc-test
> > >     ...
> > >     35 gettimeofday_tz = 0                                           [OK]
> > >     36 gettimeofday_tv_tz = 0                                        [OK]
> > >     37 gettimeofday_bad1 = -1                                       [FAIL] (continued by sigaction/siglongjmp/sigsetjmp)
> > >     38 gettimeofday_bad2 = -1                                       [FAIL] (continued by sigaction/siglongjmp/sigsetjmp)
> > >     39 getpagesize = 0                                               [OK]
> > >     40 ioctl_tiocinq = 0                                             [OK]
> > >     41 ioctl_tiocinq = 0                                             [OK]
> > >     ...
> > > 
> > > It did work as expected, but for nolibc, we still need to add sigaction/siglongjump/sigsetjmp support.
> > > 
> > > Will send a patch based on Willy's latest branch, perhaps this may help us to
> > > verify the future sigaction/siglongjump/sigsetjmp for nolibc.
> > > 
> > > ref: https://www.ibm.com/docs/en/i/7.1?topic=ssw_ibm_i_71/apis/sigsetj.html
> > >      https://www.ibm.com/docs/en/zos/2.1.0?topic=functions-siglongjmp-restore-stack-environment-signal-mask
> > 
> > This seems very complicated for fairly limited gain to be honest.
> 
> I agree as well. I'm not denying the fact that one day we may want to
> support signal, longjmp and friends but I'm not convinced we want to
> go through that just to make a few uncertain tests succeed.
>

I agree too, I'm just interested in whether it is able to restore the
whole test after a user-space invalid memory access ;-) 

> > If we really want to keep the current testcase we could also ensure that
> > the pointer does not fall into the first page, as the first page is not
> > mapped under Linux:
> > 
> > 0 <= addr < PAGE_SIZE
> > 
> > Or instead of PAGE_SIZE just hardcode 4096, as that should be the
> > minimum size and and does not require a lookup.
> 
> I would not even do that. It brings nothing to the application layer and
> inflates the code. I'd rather just get rid of the EFAULT test cases that
> rely on an unreliable syscall (i.e. one that may either be a real syscall
> or an emulated one). The value brought by these tests is extremely low
> and they were implemented only because they were easy to do. If they're
> causing pain, let's just drop them.

Thanks, one of the sent v2 patches has dropped both of them.

yesterday, based on the demo code pasted in this email thread, I went
further to implement a cleaner user-space 'efault' handler, with this
handler, it is able to continue next test, and without this handler,
just skip the test, so, it can be used to add future test cases for
sigaction/sigsetjmp/siglongjmp.

besides, a multiple 'run' support is added too, will share the new code
as a new standalone patchset later but I'm not expecting it is
mergeable.

Thanks,
Zhangjin

> 
> Willy
