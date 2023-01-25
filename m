Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3AD67C08D
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jan 2023 00:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjAYXCG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 18:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjAYXCF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 18:02:05 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ECB13DE5;
        Wed, 25 Jan 2023 15:02:05 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id B872A824E0;
        Wed, 25 Jan 2023 23:01:58 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674687724;
        bh=x5AYmRElL+4dBkzxPR6kljXUPNwqjo4EvId1VXCV9do=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S6aBm+V5zjIxCtha3GMMnSCT1U5nhGqCJ5RYp7H/04hMdU2AMnSxiXx1Hl0Y2bzC8
         YmGq+28EU5vwmWqJxXWDqzdpokWJYsfU5Xu5SMCzqpCInUuU+fAtjomsQCdtxuJNsw
         7VrIbzy1PDQA2mntxzNN6+Vo8YeJJwlNGPjSsL7FYnRhdA2Z6aUdmRJq7i8k+GKjXz
         AeY4sUm4Zqt4bkJp8nvyiPKay6MKK3ABIqTwC7GAjNqdsRUnDr3AaD4tmrlvidoKrU
         k3Bgbmin2yS7ccP4XC9cjIUUPa+BzDRhLa5FqP/ssDenJv26vXVETz1wK1dOX4SINf
         V5/tV1et0INQw==
Date:   Thu, 26 Jan 2023 06:01:54 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     "H. Peter Anvin" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Shuah Khan <shuah@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        x86 Mailing List <x86@kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v6 1/3] selftests/x86: sysret_rip: Handle syscall in
 a FRED system
Message-ID: <Y9G04vGaa77Jb0EB@biznet-home.integral.gnuweeb.org>
References: <6cd0db14-c9e2-3598-fd10-4b473d78c373@citrix.com>
 <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com>
 <20230124022729.596997-1-ammarfaizi2@gnuweeb.org>
 <20230124022729.596997-3-ammarfaizi2@gnuweeb.org>
 <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com>
 <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org>
 <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com>
 <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org>
 <20230125211714.838216-1-ammarfaizi2@gnuweeb.org>
 <20230125211714.838216-2-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125211714.838216-2-ammarfaizi2@gnuweeb.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 26, 2023 at 04:17:12AM +0700, Ammar Faizi wrote:
> +/*
> + * REGS_SAVED  = %rcx and %r11 preserved.
> + * REGS_SYSRET = %rcx and %r11 set to %rflags and %rip.
> + * REGS_ERROR  = %rcx and/or %r11 set to any other values.

Since we moved the assertion into check_regs_result(), we no longer
need REGS_ERROR. check_regs_result() is now a void function.

Will remove that comment...

-- 
Ammar Faizi

