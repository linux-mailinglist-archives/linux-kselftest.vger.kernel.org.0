Return-Path: <linux-kselftest+bounces-41527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE74EB586CC
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 23:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959284854AA
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 21:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F1E1F30BB;
	Mon, 15 Sep 2025 21:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="geKn2S6P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08434EEBD;
	Mon, 15 Sep 2025 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757971926; cv=none; b=hQzZJ9A/lzKiLUpbPvOSOS6FUZW/iDosQhku8HPoXazplIuR4NRgs3URojnPTLFpJpvjSnKTZM9fvG0fkhFzAvJHKl1VUFa0t0stkbMzlAmLTIWOLeQ7Mn4K5c6IKDV6btkvlkfaq5KS3S/0KNdcHctXRKn2rWCIeDvCqvk8+Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757971926; c=relaxed/simple;
	bh=W7C84yvEfJE6W6gHRa9X5Y9kR/gi2La0o9oC7V8Bg7A=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RYn6D9wlcsN+8TiW+oHMEHxCvoXATFh3pV2i52Y2T/XdE2b9wGXHmopCAg256nBBLNuTJMjAQZYMDKxyYU3bwVAJUvi+1CTagNValDSc4mLHcyOzonBgmEVfckq+QN5agNGKvWpJBJgp/45LocVDgLiHZ9tM49asFrS50hXPD5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=geKn2S6P; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757971911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TjCQVoRcvkNWmv8o166ThVNsGRK8YUNi+qrJMGfB+yU=;
	b=geKn2S6PjU8cjPzCGXTD7pgYIXVvFexC6PL/ne74oYaDfT7ErWwmgUZlTnKEWFLlqwjK4g
	dAdDWU1mliydp+hlSe9nK4kAyAnaF5hOmeW/LTAyCI3zETi+kyivMSOs6f9ZLYJGOnZGQk
	hQyHt8PkQo143xev04YYejRqnoaumWs=
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] PMCR_EL0.N is RAZ/WI. At least a build failes in Ubuntu
 22.04 LTS. Remove the set function.
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
In-Reply-To: <86348rdg5o.wl-maz@kernel.org>
Date: Tue, 16 Sep 2025 06:31:31 +0900
Cc: Oliver Upton <oliver.upton@linux.dev>,
 Joey Gouly <joey.gouly@arm.com>,
 K Poulose Suzuki <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev,
 kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Itaru Kitayama <itaru.kitayama@fujitsu.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0524084A-9E82-408A-9F22-369ED25E42E9@linux.dev>
References: <867by4c4v1.wl-maz@kernel.org>
 <3FEB4D87-EEAF-4A21-BCBC-291A4A7C2230@gmail.com>
 <86348rdg5o.wl-maz@kernel.org>
To: Marc Zyngier <maz@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Sep 12, 2025, at 21:11, Marc Zyngier <maz@kernel.org> wrote:
>=20
> On Fri, 12 Sep 2025 12:33:39 +0100,
> Itaru Kitayama <itaru.kitayama@gmail.com> wrote:
>>=20
>>=20
>>=20
>>> On Sep 12, 2025, at 20:01, Marc Zyngier <maz@kernel.org> wrote:
>>>=20
>>> =EF=BB=BFOn Fri, 12 Sep 2025 09:27:40 +0100,
>>> Itaru Kitayama <itaru.kitayama@linux.dev> wrote:
>>>>=20
>>>> Signed-off-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
>>>=20
>>> This isn't an acceptable commit message.
>>>=20
>>>> ---
>>>> Seen a build failure with old Ubuntu 22.04 LTS, while the latest =
release
>>>> has no build issue, a write to the bit fields is RAZ/WI, remove the
>>>> function.
>>>> ---
>>>> tools/testing/selftests/kvm/arm64/vpmu_counter_access.c | 6 ------
>>>> 1 file changed, 6 deletions(-)
>>>>=20
>>>> diff --git =
a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c =
b/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
>>>> index =
f16b3b27e32ed7ca57481f27d689d47783aa0345..56214a4430be90b3e1d840f2719b22dd=
44f0b49b 100644
>>>> --- a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
>>>> +++ b/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
>>>> @@ -45,11 +45,6 @@ static uint64_t get_pmcr_n(uint64_t pmcr)
>>>>   return FIELD_GET(ARMV8_PMU_PMCR_N, pmcr);
>>>> }
>>>>=20
>>>> -static void set_pmcr_n(uint64_t *pmcr, uint64_t pmcr_n)
>>>> -{
>>>> -    u64p_replace_bits((__u64 *) pmcr, pmcr_n, ARMV8_PMU_PMCR_N);
>>>> -}
>>>> -
>>>> static uint64_t get_counters_mask(uint64_t n)
>>>> {
>>>>   uint64_t mask =3D BIT(ARMV8_PMU_CYCLE_IDX);
>>>> @@ -490,7 +485,6 @@ static void =
test_create_vpmu_vm_with_pmcr_n(uint64_t pmcr_n, bool expect_fail)
>>>>    * Setting a larger value of PMCR.N should not modify the field, =
and
>>>>    * return a success.
>>>>    */
>>>> -    set_pmcr_n(&pmcr, pmcr_n);
>>>>   vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_PMCR_EL0), pmcr);
>>>>   pmcr =3D vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_PMCR_EL0));
>>>>=20
>>>>=20
>>>=20
>>> So what are you fixing here? A build failure? A semantic defect?
>>> Something else? What makes this a valid change?
>>>=20
>>> Frankly, I have no idea.
>>>=20
>>> But KVM definitely allows PMCR_EL0.N to be written from userspace, =
and
>>> that's not going to change.
>>>=20
>>=20
>> Then I=E2=80=99ll drop this patch.
>=20
> I'm not asking you to drop it, I'm asking you to explain. If you found
> a problem, let's discuss it and fix it. But as it stands, you're not
> giving me much to go on.
>=20

You are right, while the bit fields are write ignored, to be consistent =
with the handling of other bit fields of the register, I=E2=80=99m fully =
convinced that checking the write operation in the vpmu_counter_access.c =
file should be kept.

The build error I=E2=80=99ve seen with Ubuntu 22.04 LTS is below:=20

gcc -D_GNU_SOURCE=3D  =
-I/home/itaru/projects/linux/tools/testing/selftests/cgroup/lib/include =
-DDEBUG -Wall -Wstrict-prototypes -Wuninitialized -O0 -g -std=3Dgnu99 =
-Wno-gnu-variable-sized-type-not-at-end -MD -MP -DCONFIG_64BIT =
-fno-builtin-memcmp -fno-builtin-memcpy -fno-builtin-memset =
-fno-builtin-strnlen -fno-stack-protector -fno-PIE -fno-strict-aliasing =
-I/home/itaru/projects/linux/tools/testing/selftests/../../../tools/includ=
e =
-I/home/itaru/projects/linux/tools/testing/selftests/../../../tools/arch/a=
rm64/include =
-I/home/itaru/projects/linux/tools/testing/selftests/../../../usr/include/=
 -Iinclude -Iarm64 -Iinclude/arm64 -I ../rseq -I..  -isystem =
/home/itaru/projects/linux/tools/testing/selftests/../../../usr/include =
-I/home/itaru/projects/linux/tools/testing/selftests/../../../tools/arch/a=
rm64/include/generated/   -c arm64/vpmu_counter_access.c -o =
/home/itaru/projects/linux/tools/testing/selftests/kvm/arm64/vpmu_counter_=
access.o
In file included from =
/home/itaru/projects/linux/tools/testing/selftests/../../../tools/arch/arm=
64/include/asm/sysreg.h:1098,
                 from =
/home/itaru/projects/linux/tools/testing/selftests/../../../tools/arch/arm=
64/include/asm/esr.h:10,
                 from include/arm64/processor.h:16,
                 from arm64/vpmu_counter_access.c:16:
In function =E2=80=98field_multiplier=E2=80=99,
    inlined from =E2=80=98field_mask=E2=80=99 at =
/home/itaru/projects/linux/tools/testing/selftests/../../../tools/include/=
linux/bitfield.h:141:17,
    inlined from =E2=80=98u64_encode_bits=E2=80=99 at =
/home/itaru/projects/linux/tools/testing/selftests/../../../tools/include/=
linux/bitfield.h:172:1,
    inlined from =E2=80=98u64p_replace_bits=E2=80=99 at =
/home/itaru/projects/linux/tools/testing/selftests/../../../tools/include/=
linux/bitfield.h:172:1,
    inlined from =E2=80=98set_pmcr_n=E2=80=99 at =
arm64/vpmu_counter_access.c:50:2:
=
/home/itaru/projects/linux/tools/testing/selftests/../../../tools/include/=
linux/bitfield.h:136:17: error: call to =E2=80=98__bad_mask=E2=80=99 =
declared with attribute error: bad bitfield mask
  136 |                 __bad_mask();
      |                 ^~~~~~~~~~~~
In function =E2=80=98field_multiplier=E2=80=99,
    inlined from =E2=80=98u64_encode_bits=E2=80=99 at =
/home/itaru/projects/linux/tools/testing/selftests/../../../tools/include/=
linux/bitfield.h:172:1,
    inlined from =E2=80=98u64p_replace_bits=E2=80=99 at =
/home/itaru/projects/linux/tools/testing/selftests/../../../tools/include/=
linux/bitfield.h:172:1,
    inlined from =E2=80=98set_pmcr_n=E2=80=99 at =
arm64/vpmu_counter_access.c:50:2:
=
/home/itaru/projects/linux/tools/testing/selftests/../../../tools/include/=
linux/bitfield.h:136:17: error: call to =E2=80=98__bad_mask=E2=80=99 =
declared with attribute error: bad bitfield mask
  136 |                 __bad_mask();
      |                 ^~~~~~~~~~~~
arm64/vpmu_counter_access.c: At top level:
cc1: note: unrecognized command-line option =
=E2=80=98-Wno-gnu-variable-sized-type-not-at-end=E2=80=99 may have been =
intended to silence earlier diagnostics
make: *** [Makefile.kvm:303: =
/home/itaru/projects/linux/tools/testing/selftests/kvm/arm64/vpmu_counter_=
access.o] Error 1

Thanks,
Itaru.

> M.
>=20
> --=20
> Without deviation from the norm, progress is not possible.



