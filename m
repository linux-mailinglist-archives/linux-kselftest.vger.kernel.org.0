Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0ED67A521
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 22:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbjAXVkY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 16:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjAXVkX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 16:40:23 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C96F448A;
        Tue, 24 Jan 2023 13:40:22 -0800 (PST)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 30OLbhtZ2875378
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 24 Jan 2023 13:37:44 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 30OLbhtZ2875378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023010601; t=1674596265;
        bh=FYpw+DyQo6/Zeyp/1DrOHhEA63iP6n4iCeDIbepaNsY=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=DHVv04PucDlTaMfDdkOIauIG7IlNyhe12mIe8glApPxXoInLtYGNOaJ9UYs62IHhb
         My/GMi1qGY3BA3uMiDjVZfLI2rwUqiEtwJRxWNTyLvw4cNGKiC15Q0fepnx831610j
         MTqQwSt6f2n21undMG9onhe3/pLD2CRjIK1wAMayBEyGIv43C+0JYWApCIUA300Nc6
         T1agihripZAo4Q5sGozRnsDKXDP7zpg+bAGT2GiN9QI0gz2JRv0qQfbUngeR2rMuGD
         bybK9WfTlvZaaQvQ2Hy7C542sAQ5rZ4I+ntxQhD69BMzcSgHIH6Z/UpM7ySbzViwEV
         ELDRBqFWBbvTQ==
Date:   Tue, 24 Jan 2023 13:37:43 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     "Li, Xin3" <xin3.li@intel.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        x86 Mailing List <x86@kernel.org>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
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
Subject: =?US-ASCII?Q?RE=3A_=5BRFC_PATCH_v3_0/2=5D_selftests/x8?= =?US-ASCII?Q?6=3A_sysret=5Frip_update_for_FRED_system?=
User-Agent: K-9 Mail for Android
In-Reply-To: <SA1PR11MB6734CA3184183E490D18CA72A8C99@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com> <25b96960-a07e-a952-5c23-786b55054126@zytor.com> <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org> <6cd0db14-c9e2-3598-fd10-4b473d78c373@citrix.com> <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com> <20230124022729.596997-1-ammarfaizi2@gnuweeb.org> <20230124022729.596997-3-ammarfaizi2@gnuweeb.org> <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com> <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org> <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com> <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org> <20230124100926.637335-1-ammarfaizi2@gnuweeb.org> <SA1PR11MB6734CA3184183E490D18CA72A8C99@SA1PR11MB6734.namprd11.prod.outlook.com>
Message-ID: <7E935340-B596-4663-80FF-CDC4E31896B4@zytor.com>
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

On January 24, 2023 1:32:14 PM PST, "Li, Xin3" <xin3=2Eli@intel=2Ecom> wrot=
e:
>> From: Ammar Faizi <ammarfaizi2@gnuweeb=2Eorg>
>>=20
>> This is an RFC patchset v3:
>> sysret_rip test update for Intel FRED architecture=2E
>>=20
>> Xin Li reported sysret_rip test fails at:
>>=20
>>         assert(ctx->uc_mcontext=2Egregs[REG_EFL] =3D=3D
>>                ctx->uc_mcontext=2Egregs[REG_R11]);
>
>On FRED systems, flags is 0x200a93 and r11 is 0xfeedfacedeadbeef here=2E
>
>We need to remove or change this assertion, maybe:
>  assert(ctx->uc_mcontext=2Egregs[REG_EFL] =3D=3D ctx->uc_mcontext=2Egreg=
s[REG_R11] ||
>         r11_sentinel =3D=3D ctx->uc_mcontext=2Egregs[REG_R11]);
>
>>=20
>> in a FRED system=2E Let's handle the FRED system scenario too=2E The 's=
yscall'
>> instruction in a FRED system doesn't set %r11=3D%rflags=2E
>>=20
>> There are two patches in this series=2E
>>=20
>> How to test this:
>>=20
>>   $ make -C tools/testing/selftests/x86
>>   $ tools/testing/selftests/x86/sysret_rip_64
>>=20
>> Link: https://lore=2Ekernel=2Eorg/lkml/5d4ad3e3-034f-c7da-d141-
>> 9c001c2343af@intel=2Ecom
>> Fixes: 660602140103 ("selftests/x86: Add a selftest for SYSRET to nonca=
nonical
>> addresses")
>> Link: https://lore=2Ekernel=2Eorg/lkml/25b96960-a07e-a952-5c23-
>> 786b55054126@zytor=2Ecom
>> Reported-by: Xin Li <xin3=2Eli@intel=2Ecom>
>> Co-developed-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>
>> Signed-off-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>
>> Acked-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>
>> Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb=2Eorg>
>> ---
>>=20
>> ## Changelog v3:
>>=20
>>    - Test that we don't get a mix of REGS_SAVED and REGS_SYSRET,
>>      which is a major part of the point (hpa)=2E
>>=20
>> ## Changelog v2:
>>=20
>>    - Use "+r"(rsp) as the right way to avoid redzone problems
>>      per Andrew's comment (hpa)=2E
>>      (Ref: https://lore=2Ekernel=2Eorg/lkml/8f5c24df-514d-5d89-f58f-
>> ec8c3eb1e049@zytor=2Ecom )
>>=20
>> ---
>>=20
>> Ammar Faizi (2):
>>   selftests/x86: sysret_rip: Handle syscall in a FRED system
>>   selftests/x86: sysret_rip: Add more syscall tests with respect to `%r=
cx` and `%r11`
>>=20
>>  tools/testing/selftests/x86/sysret_rip=2Ec | 120 +++++++++++++++++++++=
+-
>>  1 file changed, 119 insertions(+), 1 deletion(-)
>>=20
>>=20
>> base-commit: e12ad468c22065a2826b2fc4c11d2113a7975301
>> --
>> Ammar Faizi
>
>

This should use check_regs_result() =E2=80=93 which is exactly the reason =
I made that a separate function=2E
