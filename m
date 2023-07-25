Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD04E762142
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 20:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjGYSXr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 14:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjGYSXq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 14:23:46 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9722125;
        Tue, 25 Jul 2023 11:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1690309424;
        bh=zFYIq3Co+qyjUFECaDvYffNEVwgRI5mFYW9PtEP+uK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=eoDm3Ym4Qx5pjUZWAFgCt4ofah1FYk3awUDh+ekYujvpyTGZf52VD+YfR8KyFpVP5
         pz6ZEvUN2uLluU9axncC8/Lf7LbFgzXTSJDf30fnPZyD17cRSCpu4pm/BNEByz1CKQ
         3Cg3pGCC0GMqrxycvOldTcIg9SNM1VK74SKpvqeZTZB/WckOz1Z4LINyPcCxxKTlwb
         zJoyVODPj1+WOfjsJbbSkVTGXNqipDa+TbgC2wfZ+BUvHI0+HnySjqhTcgmOSFgVHz
         8pWxSGZNisokbnTaoLQhZSMsomiQOs7IATZHe/chNRhD54BEJ8ACyAdvwuTNOQCCNN
         65+FXtaNkODkQ==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.126.67])
        by gnuweeb.org (Postfix) with ESMTPSA id C982E24AF9F;
        Wed, 26 Jul 2023 01:23:41 +0700 (WIB)
Date:   Wed, 26 Jul 2023 01:23:37 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Sven Schnelle <svens@linux.ibm.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
        Willy Tarreau <w@1wt.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v1 1/8] tools/nolibc: add support for powerpc
Message-ID: <ZMATKempQBPGCY2v@biznet-home.integral.gnuweeb.org>
References: <ZL/gAORYFijgjfvH@biznet-home.integral.gnuweeb.org>
 <20230725170426.58050-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725170426.58050-1-falcon@tinylab.org>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 26, 2023 at 01:04:26AM +0800, Zhangjin Wu wrote:
> My old 'reply' is not rigorous, since the syscall6() uses stack to pass
> the 6th argument, so, our new syscall.h didn't support it currently,
> the syscalls I have tested about "=r" instead of "=a" were only syscall1-5().

Yeah, it won't fit with the new design.

i386 runs out of GPRs very quickly. Given that, it had a hard time
implementing syscall6() properly in nolibc. The calling convention
itself actually doesn't require stack for executing 'int $0x80'.

The reason of why it uses stack is because the %ebp register cannot be
listed in the clobber list nor in the constraint if -fomit-frame-pointer
is not activated. Thus, we have to carefully preserve the value on the
stack before using %ebp as the 6-th argument to the syscall. It's a hack
to make it work on i386.

> Ok, so, with the new syscalls.h proposed, we'd better keep i386
> syscall6() as-is.
> 
> For the left syscall1-5(), is there any risk when use '=r' instead of 'r'?

Using "=r" instead of "r" doesn't make sense.

Did you mean "=r" instead of "=a"?

If that's what you mean:

So far I don't see the risk of using "=r" instead of "=a" as long as the
variable is properly marked as 'register' + asm("eax").

-- 
Ammar Faizi

