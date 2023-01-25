Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EFA67B1D4
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 12:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbjAYLpL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 06:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjAYLpL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 06:45:11 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF85BBA8;
        Wed, 25 Jan 2023 03:45:10 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id 4F0C381845;
        Wed, 25 Jan 2023 11:37:28 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674646654;
        bh=/EctXOG2MvaNtKtikXj94vEve/rQIfCrMsw24dL44Y4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nACC8Fx8Cbe28zU/v8ud+iy7Z7fQJStibaoq9HttVSgyccF2xqH3ljfZPzDf43HRq
         fwnWG54L28s8Bq3jJ9RKoe1tZae4/OTNBIo+8066v0mwWqFSixRLL1zOgYpTUtdtjA
         vIZ6lp5gt/8s/bZiZCNkNI9L8OCE+1G2x0j55VhvSowESJVIb4hNwfx3jCddZkUicx
         qTIkVXhkWUlFuIvpzVCUe0rLYUANMpYf5X9uV0KEleg57jsqSeTWg/HnoHCGLoxwUN
         lcrcLqzDiRwgAYgcSdqh7YRWObLy8osLCWJCi3wf7rAXkG5iCfZPte/8p2A02aSOLY
         7JVF6pL+ZxK0A==
Date:   Wed, 25 Jan 2023 18:37:23 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Xin Li <xin3.li@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        x86 Mailing List <x86@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v5 1/2] selftests/x86: sysret_rip: Handle syscall in
 a FRED system
Message-ID: <Y9EUc6SIhN4skrmi@biznet-home.integral.gnuweeb.org>
References: <20230124022729.596997-3-ammarfaizi2@gnuweeb.org>
 <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com>
 <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org>
 <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com>
 <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org>
 <20230125034958.734527-1-ammarfaizi2@gnuweeb.org>
 <20230125034958.734527-2-ammarfaizi2@gnuweeb.org>
 <8770815f-0f23-d0c5-e56a-d401827842c9@zytor.com>
 <Y9D8++DxphJS1oc4@biznet-home.integral.gnuweeb.org>
 <A7DAB159-7C02-412D-9CFB-5C3C3760DECB@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A7DAB159-7C02-412D-9CFB-5C3C3760DECB@zytor.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 25, 2023 at 02:17:41AM -0800, H. Peter Anvin wrote:
> I guess it would depend on what they "normally" are. My #1 impulse would be to leave them both unchanged.

Ah okay... I think I understand now. My confusion came from a comment
in that code.

The current SIGUSR1 handler has a comment:

    /* Set IP and CX to match so that SYSRET can happen. */
    ctx->uc_mcontext.gregs[REG_RIP] = rip;
    ctx->uc_mcontext.gregs[REG_RCX] = rip;

So I thought if we leave them both unchanged, then SYSRET can happen
too, because IP and CX match. My initial confusion about that was:

    Where do we actually exercise IRET if the SIGUSR2 handler
    exercises SYSRET then?

I realized my assumption was wrong. The current SIGUSR1 handler
actually forces the kernel to use IRET, not SYSRET. Because the %rip
is set to a non-canonical address. So that's the place where it
exercises IRET.

IOW, my understanding now:

The current SIGUSR1 handler exercises the SYSRET-appropriate condition
detector in the kernel. It doesn't actually go to the SYSRET path
despite the comment saying "SYSRET can happen". That detector must take
us to the IRET path or we will #GP in kernel space on Intel CPUs.

In short, the SIGUSR1 handler asserts that "SYSRET must *not* happen".

The expected SIGUSR2 handler addition exercises the SYSRET path by
leaving REG_IP and REG_CX unchanged.

Am I correct?

-- 
Ammar Faizi

