Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEA167B880
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 18:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjAYR1v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 12:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbjAYR1u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 12:27:50 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE3A35AB;
        Wed, 25 Jan 2023 09:27:48 -0800 (PST)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 30PHPOXR3191416
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 25 Jan 2023 09:25:24 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 30PHPOXR3191416
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023010601; t=1674667525;
        bh=VnoyFUy9dOE00kCz07pDoYxTfplcGaca5G+hnmBxs+s=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=QbTpX7nL7CyyJ6yfVZ8M5fweKYAIjwNmBEApgktVaVlmfH/soztuowedAJ8+WjIiX
         iSpsQMM7fnHKUvAmeTaL6eg6/Nofmklx+0YI1wlZ0fFsF/XrQ7bevAgERPeKdL/1t6
         vaTDilZR2MNcpuqkJFPZNkSTmmbAJwxih+Qocs6A8M7l35tqonA5/NqutwBG/d137l
         jDkL4F/Dw3WrpbQkqbEcrlVj0UY25F79iDf634NXBaufOG0DsdH9Og5BNDV7IZcmRF
         0xUPYQC1M2bqWt+YNGdtObPYqufufCQb7p/bxgIt3OlEgw3oVjrRwdqtrZgHnpoxFm
         xICw+ZEgkjS5w==
Date:   Wed, 25 Jan 2023 09:25:21 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
CC:     Xin Li <xin3.li@intel.com>, Dave Hansen <dave.hansen@intel.com>,
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
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_v5_1/2=5D_selftests/x86=3A_sy?= =?US-ASCII?Q?sret=5Frip=3A_Handle_syscall_in_a_FRED_system?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Y9EUc6SIhN4skrmi@biznet-home.integral.gnuweeb.org>
References: <20230124022729.596997-3-ammarfaizi2@gnuweeb.org> <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com> <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org> <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com> <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org> <20230125034958.734527-1-ammarfaizi2@gnuweeb.org> <20230125034958.734527-2-ammarfaizi2@gnuweeb.org> <8770815f-0f23-d0c5-e56a-d401827842c9@zytor.com> <Y9D8++DxphJS1oc4@biznet-home.integral.gnuweeb.org> <A7DAB159-7C02-412D-9CFB-5C3C3760DECB@zytor.com> <Y9EUc6SIhN4skrmi@biznet-home.integral.gnuweeb.org>
Message-ID: <13EFEDBA-3BC2-4654-BFDD-53E79178107B@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On January 25, 2023 3:37:23 AM PST, Ammar Faizi <ammarfaizi2@gnuweeb=2Eorg>=
 wrote:
>On Wed, Jan 25, 2023 at 02:17:41AM -0800, H=2E Peter Anvin wrote:
>> I guess it would depend on what they "normally" are=2E My #1 impulse wo=
uld be to leave them both unchanged=2E
>
>Ah okay=2E=2E=2E I think I understand now=2E My confusion came from a com=
ment
>in that code=2E
>
>The current SIGUSR1 handler has a comment:
>
>    /* Set IP and CX to match so that SYSRET can happen=2E */
>    ctx->uc_mcontext=2Egregs[REG_RIP] =3D rip;
>    ctx->uc_mcontext=2Egregs[REG_RCX] =3D rip;
>
>So I thought if we leave them both unchanged, then SYSRET can happen
>too, because IP and CX match=2E My initial confusion about that was:
>
>    Where do we actually exercise IRET if the SIGUSR2 handler
>    exercises SYSRET then?
>
>I realized my assumption was wrong=2E The current SIGUSR1 handler
>actually forces the kernel to use IRET, not SYSRET=2E Because the %rip
>is set to a non-canonical address=2E So that's the place where it
>exercises IRET=2E
>
>IOW, my understanding now:
>
>The current SIGUSR1 handler exercises the SYSRET-appropriate condition
>detector in the kernel=2E It doesn't actually go to the SYSRET path
>despite the comment saying "SYSRET can happen"=2E That detector must take
>us to the IRET path or we will #GP in kernel space on Intel CPUs=2E
>
>In short, the SIGUSR1 handler asserts that "SYSRET must *not* happen"=2E
>
>The expected SIGUSR2 handler addition exercises the SYSRET path by
>leaving REG_IP and REG_CX unchanged=2E
>
>Am I correct?
>

That's the idea=2E
