Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B663C6793AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 10:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbjAXJKW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 04:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbjAXJKV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 04:10:21 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF493E088;
        Tue, 24 Jan 2023 01:10:19 -0800 (PST)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 30O97e102683301
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 24 Jan 2023 01:07:41 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 30O97e102683301
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023010601; t=1674551265;
        bh=74BQ8ksrCo+09gllPxnskrV9G8BOIfUPqT5FAphg2Bc=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=UUvlTs0NtPGnACn/SEEcs5pdcNEGXqEJd8C37k9tCJpYZIqyjK2lDQE0Iyyv1jY3J
         hCCm+5VXKqz73Ihnlrk7DnaVIlEKj3u6zrCcUPM619qMM36Y0HiErVnXsrtTNv8TWy
         d0ibOB4jpummRHkU3kCi7izQwyEsOlllKSYJ/q953lrUw8yVeZRoRL/saa+e2X2lFt
         pUb71nPdNaSdYqmD5GJtcBtrMBeEtsrx8F5BB3LaxnKV1G3AWmqkbXq/IkPthwPhU6
         uArC5wYDJNPP9lDhfTm30/v+Fa0WuIfgdTq9PL3TqkQOC37zaKQBgr+dDspGAS8oLA
         U1RocMbsEaLLw==
Date:   Tue, 24 Jan 2023 01:07:38 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
CC:     x86 Mailing List <x86@kernel.org>,
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
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_v2_2/2=5D_sel?= =?US-ASCII?Q?ftests/x86=3A_sysret=5Frip=3A_Add?= =?US-ASCII?Q?_more_syscall_tests_with_r?= =?US-ASCII?Q?espect_to_=60=25rcx=60_and_=60=25r11=60?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org>
References: <18B5DB6D-AEBD-4A67-A7B3-CE64940819B7@zytor.com> <SA1PR11MB673498933098295BFC7C2900A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com> <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com> <25b96960-a07e-a952-5c23-786b55054126@zytor.com> <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org> <6cd0db14-c9e2-3598-fd10-4b473d78c373@citrix.com> <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com> <20230124022729.596997-1-ammarfaizi2@gnuweeb.org> <20230124022729.596997-3-ammarfaizi2@gnuweeb.org> <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com> <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org>
Message-ID: <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com>
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

On January 23, 2023 10:41:20 PM PST, Ammar Faizi <ammarfaizi2@gnuweeb=2Eorg=
> wrote:
>On Mon, Jan 23, 2023 at 10:16:01PM -0800, H=2E Peter Anvin wrote:
>> On 1/23/23 18:27, Ammar Faizi wrote:
>> > Test that:
>> >=20
>> >   - "syscall" in a FRED system doesn't clobber %rcx and %r11=2E
>> >   - "syscall" in a non-FRED system sets %rcx=3D%rip and %r11=3D%rflag=
s=2E
>> >=20
>> > Test them out with a trivial system call like __NR_getppid and friend=
s
>> > which are extremely likely to return with SYSRET on an IDT system; ch=
eck
>> > that it returns a nonnegative value and then save the result=2E
>> >=20
>>=20
>> "Nonnegative" here should be "valid"; it is an implementation detail th=
at
>> the error value is -1=2E
>
>Copy-paste error, will fix that!
>
>> However, you are not checking that you don't get a mix of REGS_SAVED an=
d
>> REGS_SYSRET, which is a major part of the point=2E
>
>Good point!
>
>What do you think of adding this on top of patch #1?
>
>diff --git a/tools/testing/selftests/x86/sysret_rip=2Ec b/tools/testing/s=
elftests/x86/sysret_rip=2Ec
>index 75c72d34dbc5840c=2E=2E3da827713831acbc 100644
>--- a/tools/testing/selftests/x86/sysret_rip=2Ec
>+++ b/tools/testing/selftests/x86/sysret_rip=2Ec
>@@ -47,11 +47,14 @@ static const unsigned long rcx_sentinel =3D 0x5ca1ab1=
e0b57ac1e;
> static const unsigned long rflags_sentinel =3D 0x200a93;
>=20
> enum regs_ok {
>-	REGS_ERROR  =3D -1,	/* Invalid register contents */
>-	REGS_SAVED  =3D  0,	/* Registers properly preserved */
>-	REGS_SYSRET =3D  1	/* Registers match syscall/sysret */
>+	REGS_INIT_VAL	=3D -2,	/* For init value checker, never returned */
>+	REGS_ERROR 	=3D -1,	/* Invalid register contents */
>+	REGS_SAVED 	=3D  0,	/* Registers properly preserved */
>+	REGS_SYSRET	=3D  1	/* Registers match syscall/sysret */
> };
>=20
>+static enum regs_ok regs_ok_state =3D REGS_INIT_VAL;
>+
> /*
>  * Returns:
>  *  0 =3D %rcx and %r11 preserved=2E
>@@ -86,6 +89,7 @@ static long do_syscall(long nr_syscall, unsigned long a=
rg1, unsigned long arg2,
> 	register unsigned long r9 asm("%r9");
> 	register void *rsp asm("%rsp");
> 	unsigned long rcx, rbx;
>+	enum regs_ok ret;
>=20
> 	r11 =3D r11_sentinel;
> 	rcx =3D rcx_sentinel;
>@@ -124,7 +128,14 @@ static long do_syscall(long nr_syscall, unsigned lon=
g arg1, unsigned long arg2,
> 	 * - "syscall" in a non-FRED system sets %rcx=3D%rip and %r11=3D%rflags=
=2E
> 	 *
> 	 */
>-	assert(check_regs_result(r11, rcx, rbx) !=3D REGS_ERROR);
>+	ret =3D check_regs_result(r11, rcx, rbx);
>+	assert(ret !=3D REGS_ERROR);
>+
>+	if (regs_ok_state =3D=3D REGS_INIT_VAL)
>+		regs_ok_state =3D ret;
>+	else
>+		assert(ret =3D=3D regs_ok_state);
>+
> 	return nr_syscall;
> }
>=20

Works for me, although I would call it REGS_UNDEFINED myself=2E
