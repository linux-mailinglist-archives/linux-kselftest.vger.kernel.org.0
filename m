Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381BC67A92F
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 04:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjAYD1b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 22:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjAYD1a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 22:27:30 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC154521FA;
        Tue, 24 Jan 2023 19:27:28 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id 5822A82EFE;
        Wed, 25 Jan 2023 03:27:22 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674617248;
        bh=JVyXISFF2VMV3UQ/rzZ1UPCMs0dCqkS9w8Vfx+tSXtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZAsUiD+c/ma92RokjmOePatNT2Zq0sMZVtg2ZhoXDWlbHjSUjYvZmSR7T8qOmu1xF
         uED4jXCVmQ56lBHlEQtnQudp8ZjZS4JjcT0tqEZ+inOlIxloZRH4qdd5MtSjmuKXXw
         8TaR18GrQaKfVGP0isixnknTaSrha+2H3gWZwC/eVpj/XlO7+wQsNkAylzy34Reu7i
         /+ggTXCJUm+2PkPoTzKDsIILNUUSWDX/1G5+qwowYVb+bJxsdLCb5Z0OBUIgcby7g2
         XuCh8l0Bw8l/KOalrN6xj1Kp8sV5AUwaAf9WPlMjJTlpr7S2UoRhrO51cH15oup8dB
         1YqwBIUrSZ8Rg==
Date:   Wed, 25 Jan 2023 10:27:18 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     "Li, Xin3" <xin3.li@intel.com>, x86 Mailing List <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v3 0/2] selftests/x86: sysret_rip update for FRED
 system
Message-ID: <Y9Chlgp/DIZDou8T@biznet-home.integral.gnuweeb.org>
References: <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com>
 <20230124022729.596997-1-ammarfaizi2@gnuweeb.org>
 <20230124022729.596997-3-ammarfaizi2@gnuweeb.org>
 <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com>
 <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org>
 <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com>
 <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org>
 <20230124100926.637335-1-ammarfaizi2@gnuweeb.org>
 <SA1PR11MB6734CA3184183E490D18CA72A8C99@SA1PR11MB6734.namprd11.prod.outlook.com>
 <7E935340-B596-4663-80FF-CDC4E31896B4@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7E935340-B596-4663-80FF-CDC4E31896B4@zytor.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 24, 2023 at 01:37:43PM -0800, H. Peter Anvin wrote:
> On January 24, 2023 1:32:14 PM PST, "Li, Xin3" <xin3.li@intel.com> wrote:
> >> From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> >> 
> >> This is an RFC patchset v3:
> >> sysret_rip test update for Intel FRED architecture.
> >> 
> >> Xin Li reported sysret_rip test fails at:
> >> 
> >>         assert(ctx->uc_mcontext.gregs[REG_EFL] ==
> >>                ctx->uc_mcontext.gregs[REG_R11]);
> >
> >On FRED systems, flags is 0x200a93 and r11 is 0xfeedfacedeadbeef here.
> >
> >We need to remove or change this assertion, maybe:
> >  assert(ctx->uc_mcontext.gregs[REG_EFL] == ctx->uc_mcontext.gregs[REG_R11] ||
> >         r11_sentinel == ctx->uc_mcontext.gregs[REG_R11]);
> >
>
> This should use check_regs_result() – which is exactly the reason I made that a separate function.

Fixed in v4.

-- 
Ammar Faizi

