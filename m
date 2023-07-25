Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7250E762338
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 22:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjGYUXr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 16:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjGYUXq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 16:23:46 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F9B1BE8;
        Tue, 25 Jul 2023 13:23:41 -0700 (PDT)
X-QQ-mid: bizesmtp90t1690316602t15cdd9o
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 26 Jul 2023 04:23:20 +0800 (CST)
X-QQ-SSF: 01200000002000D0X000B00A0000000
X-QQ-FEAT: 7PtB0PwUHLt0JEwWfZ9s2RekkL9+xX+C5BNaQRPO+68X6agazbskihwT8VhD1
        3lR0hOMWgJheOMw7ApdCOw7WHltvspxRXl2asX362ApwxBvsA3SE3pKJIZL8mp2BXp/JPzt
        4s+QoUqacXUyHbpBFguY2kRBkOYK4XTAy1iHWpJOMRIx4I3J6HQxZNhrrftrCh+/MaO5yEA
        U98M0LyUN8/5KdikZz5c7PsFnH+GAm2nCQlKy7xK2/F7UbmMr4m1igjNeCt7ueYSTfR4tMw
        lgRehQr1FZw3QXR5BaEUon8BzHThlEeKZ7D9fh2CYgSnVLm0i9OM1XowPkVLihJIzho1qFa
        GOPb3u6yumDwGseQf5gRatixPLrSB7MW+axCgfXNBDDdWjvRI0aO7rrXQXtFQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14996727253225002302
From:   Zhangjin Wu <falcon@tinylab.org>
To:     ammarfaizi2@gnuweeb.org
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, svens@linux.ibm.com,
        thomas@t-8ch.de, w@1wt.eu
Subject: Re: [PATCH v1 1/8] tools/nolibc: add support for powerpc
Date:   Wed, 26 Jul 2023 04:23:19 +0800
Message-Id: <20230725202319.29590-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZMATKempQBPGCY2v@biznet-home.integral.gnuweeb.org>
References: <ZMATKempQBPGCY2v@biznet-home.integral.gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On Wed, Jul 26, 2023 at 01:04:26AM +0800, Zhangjin Wu wrote:
> > My old 'reply' is not rigorous, since the syscall6() uses stack to pass
> > the 6th argument, so, our new syscall.h didn't support it currently,
> > the syscalls I have tested about "=r" instead of "=a" were only syscall1-5().
> 
> Yeah, it won't fit with the new design.
> 
> i386 runs out of GPRs very quickly. Given that, it had a hard time
> implementing syscall6() properly in nolibc. The calling convention
> itself actually doesn't require stack for executing 'int $0x80'.
> 
> The reason of why it uses stack is because the %ebp register cannot be
> listed in the clobber list nor in the constraint if -fomit-frame-pointer
> is not activated. Thus, we have to carefully preserve the value on the
> stack before using %ebp as the 6-th argument to the syscall. It's a hack
> to make it work on i386.
> 
> > Ok, so, with the new syscalls.h proposed, we'd better keep i386
> > syscall6() as-is.
> > 
> > For the left syscall1-5(), is there any risk when use '=r' instead of 'r'?
> 
> Using "=r" instead of "r" doesn't make sense.
> 
> Did you mean "=r" instead of "=a"?
>

Yeah, sorry.

> If that's what you mean:
> 
> So far I don't see the risk of using "=r" instead of "=a" as long as the
> variable is properly marked as 'register' + asm("eax").
>

Thanks.
Zhangjin

> -- 
> Ammar Faizi
