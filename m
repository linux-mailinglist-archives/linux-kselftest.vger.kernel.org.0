Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5768667AF84
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 11:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbjAYKUY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 05:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbjAYKUV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 05:20:21 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08C237F0A;
        Wed, 25 Jan 2023 02:20:20 -0800 (PST)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 30PAHgFr3073106
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 25 Jan 2023 02:17:42 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 30PAHgFr3073106
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023010601; t=1674641863;
        bh=fgf0O//Iw/voqvEUpEUdG2dcondsK9mqYxF3Vys4i7U=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=baJF93gAtdLK96f3IaSa5ZFBoo00AUsymj332aKjUMi5V74ufdqhVJViR1NOCbQY5
         XxQeu48s2haA57Z8EzxC1M8KvRdfiTAlfpH3hVYyJv0ueDiJ6RglPPBYAxN/DDFTFH
         9MWEeg2LuHE/4rPaqK5Gl3MMpjgTnF2kEVmCBDgMZpT2vw7+qXf35HWXO2Jwhjyyiw
         1GQ9cdnsBXijCzj1hl4t2UXyfx5pfARrAZ0LWR49rNGxcdPImqzy/vLmOeIKtkPkIs
         vI9rCm2LUSafcVJbq+b8LREOVTBPmoHets1aLr8p3jaOH1y1TQowEEbCOLp7xtpq36
         fxK4cg2+LDHaA==
Date:   Wed, 25 Jan 2023 02:17:41 -0800
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
In-Reply-To: <Y9D8++DxphJS1oc4@biznet-home.integral.gnuweeb.org>
References: <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com> <20230124022729.596997-1-ammarfaizi2@gnuweeb.org> <20230124022729.596997-3-ammarfaizi2@gnuweeb.org> <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com> <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org> <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com> <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org> <20230125034958.734527-1-ammarfaizi2@gnuweeb.org> <20230125034958.734527-2-ammarfaizi2@gnuweeb.org> <8770815f-0f23-d0c5-e56a-d401827842c9@zytor.com> <Y9D8++DxphJS1oc4@biznet-home.integral.gnuweeb.org>
Message-ID: <A7DAB159-7C02-412D-9CFB-5C3C3760DECB@zytor.com>
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

On January 25, 2023 1:57:15 AM PST, Ammar Faizi <ammarfaizi2@gnuweeb=2Eorg>=
 wrote:
>On Wed, Jan 25, 2023 at 12:39:26AM -0800, H=2E Peter Anvin wrote:
>> >   	/* Set IP and CX to match so that SYSRET can happen=2E */
>> >   	ctx->uc_mcontext=2Egregs[REG_RIP] =3D rip;
>> >   	ctx->uc_mcontext=2Egregs[REG_RCX] =3D rip;
>>=20
>> It would be interesting to have the syscall handler try both with and
>> without this (so it would end up doing both IRET and SYSCALL on legacy=
=2E)
>> Perhaps SIGUSR1 versus SIGUSR2=2E=2E=2E
>
>Just to clarify this more so I am sure I understand it correctly=2E
>
>Did you mean to have the same signal handler without modifiying
>'REG_RCX' but still change 'REG_RIP'?
>
>IOW, we want to only *remove*:
>
>   ctx->uc_mcontext=2Egregs[REG_RCX] =3D rip;
>
>and *keep*:
>
>   ctx->uc_mcontext=2Egregs[REG_RIP] =3D rip;
>
>for the SIGUSR2 handler=2E Thus, inside the entry64 we will jump to the
>iret path because %rcx !=3D %r11 upon rt_sigreturn()?
>

I guess it would depend on what they "normally" are=2E My #1 impulse would=
 be to leave them both unchanged=2E
