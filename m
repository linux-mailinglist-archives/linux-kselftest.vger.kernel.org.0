Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A875867A944
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 04:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjAYDag (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 22:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjAYDaf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 22:30:35 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C46241F0;
        Tue, 24 Jan 2023 19:30:07 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id 1458482EFE;
        Wed, 25 Jan 2023 03:29:28 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674617375;
        bh=3VsbzSjeA/75L5IFPte1m42201Qyxjao5nDLCNapEOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eHOaM9wHDAQgUUlqpdaaLVA9eDAjJTjX78vKug7we1zKS5a+AgCp+lHhUiGldQa+x
         YgiglNdhGMWVeJEmlSdF27P4zsJBxg0Qe+nwSnye6WePBgFuRPoYuKcIG+/LyHLbOR
         SVCANtjeciv1rXalNKZzWGMg/Ponhu1v9AAUGREtKfn4YHiImGwh3rRdTQ4QQT20xx
         WZAxHsSyhsCLRZ/c4Y8k4BNdraPnIDBXjOHTuvdVFHz83Uiim0c055+4Irz/ZfPNSF
         IdDR2cNKnFC2YLc5GcCJdzFn+Yg9REApVw8Ik4KicsKsfAZY+IZ1fiW1f0uBxUozpU
         Xf24BOniXvDFA==
Date:   Wed, 25 Jan 2023 10:29:24 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86 Mailing List <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xin Li <xin3.li@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v3 2/2] selftests/x86: sysret_rip: Add more syscall
 tests with respect to `%rcx` and `%r11`
Message-ID: <Y9CiFEoiLislQZCx@biznet-home.integral.gnuweeb.org>
References: <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com>
 <20230124022729.596997-1-ammarfaizi2@gnuweeb.org>
 <20230124022729.596997-3-ammarfaizi2@gnuweeb.org>
 <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com>
 <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org>
 <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com>
 <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org>
 <20230124100926.637335-1-ammarfaizi2@gnuweeb.org>
 <20230124100926.637335-3-ammarfaizi2@gnuweeb.org>
 <48072ce2-e28d-9267-1f8e-3c76682fb782@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48072ce2-e28d-9267-1f8e-3c76682fb782@zytor.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 24, 2023 at 12:59:23PM -0800, H. Peter Anvin wrote:
> 
> 
> On 1/24/23 02:09, Ammar Faizi wrote:
> > From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> > 
> > Test that:
> > 
> >   - "syscall" in a FRED system doesn't clobber %rcx and %r11.
> >   - "syscall" in a non-FRED system sets %rcx=%rip and %r11=%rflags.
> > 
> > Test them out with a trivial system call like __NR_getppid and friends
> > which are extremely likely to return with SYSRET on an IDT system.
> > 
> > Link: https://lore.kernel.org/lkml/25b96960-a07e-a952-5c23-786b55054126@zytor.com
> > Co-developed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> > Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> > Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> > Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> 
> Add to the description that the purpose of this is to ensure that various
> system calls are *consistent*, as per the comment immediately below your
> code.

Added in v4.

-- 
Ammar Faizi

