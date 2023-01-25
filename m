Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C4467A948
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 04:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjAYDhS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 22:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbjAYDhR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 22:37:17 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8BD31E2B;
        Tue, 24 Jan 2023 19:37:17 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id CF63282EFE;
        Wed, 25 Jan 2023 03:37:10 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674617836;
        bh=4fq9DmFaXtKDehBFjDF2+vfw+sPt14e6TWO5Y2AkUUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ERECnSrRf25CBbQi5TOc/alA9xkntqR407yhBlthYg3VyRAj0Kuf0bwJM4T5ybiY3
         4S1Lrd/GIuvLm4qzw1b9krNdVdcf0VLvM04MimYvjow2cqOYz5KIHZGT844qtZdM4H
         dOMaxWMaIiIWfRNOSYk5kC6myiFiw0Kh/JdX9czNNra4qN8gjUwIlYSliabfWWbV4b
         GWtNLhsKm+Fm3iN9vxXMPIZpvOhntWqEhaz1snC2EI0nbMfU8zmcownVVQEN4DJEXy
         53tHrCA35pRb5p1h7FeAzT4qJPPBr8FY7RVkQg3kvBN91/MvWB9m2PZPm4gkSFq5a0
         mq9MJSue0NlOw==
Date:   Wed, 25 Jan 2023 10:37:06 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     "H. Peter Anvin" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
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
Subject: Re: [RFC PATCH v4 1/2] selftests/x86: sysret_rip: Handle syscall in
 a FRED system
Message-ID: <Y9Cj4ta/DpiVGFeo@biznet-home.integral.gnuweeb.org>
References: <6cd0db14-c9e2-3598-fd10-4b473d78c373@citrix.com>
 <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com>
 <20230124022729.596997-1-ammarfaizi2@gnuweeb.org>
 <20230124022729.596997-3-ammarfaizi2@gnuweeb.org>
 <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com>
 <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org>
 <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com>
 <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org>
 <20230125032240.728463-1-ammarfaizi2@gnuweeb.org>
 <20230125032240.728463-2-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125032240.728463-2-ammarfaizi2@gnuweeb.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 25, 2023 at 10:22:39AM +0700, Ammar Faizi wrote:
> +	/*
> +	 * Test that we don't get a mix of REGS_SAVED and REGS_SYSRET.
> +	 * It needs at least calling do_syscall() twice to assert.
> +	 */
> +	if (regs_ok_state == REGS_UNDEFINED) {
> +		/*
> +		 * First time calling do_syscall().
> +		 */
> +		regs_ok_state = ret;
> +		return ret;
> +	} else {

Oops, this should not be returning ret here. Ignore this version.
I'll send v5.

-- 
Ammar Faizi

