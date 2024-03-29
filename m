Return-Path: <linux-kselftest+bounces-6928-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F812893447
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Mar 2024 19:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D4E2B2539E
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Mar 2024 17:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D29E15B122;
	Sun, 31 Mar 2024 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="L2zt8eif"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5B315B100;
	Sun, 31 Mar 2024 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903331; cv=fail; b=bHercVKB5OUoY99Er2vj78aTwQbco0SJLVBi6rXBm2voYIOEyM5JPIDMCD3cFOfbLypfRvs69N4CeR/1+91ejrCTvWjJv2CH0oo8eAz5v29psBWrB/YwdUybti/QkCyLyeGhcLAqBCYtFI9OWFjgdYz4JUBtc4QojNUuS3EgZAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903331; c=relaxed/simple;
	bh=N095DwSwxYVm9TBVbhXusbPODLB1DxILKD/VVqAoA9I=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=q/CaVntd0Cc0PIKTVgjGwxWWSqWCSSznmmyRsLUCExJtBopwEHqbozO20YkJvJEdNevlMfezzw9xUKRVpVSfY15nVudUBjNFseIFypH1sWsRfHLDagkwcGc/3Vw3J9OQvlSAKz04eiVeYUm+ip10n4NZ287KNnn9s/l/yg2Bp0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=collabora.com; spf=fail smtp.mailfrom=collabora.com; dkim=fail (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=L2zt8eif reason="signature verification failed"; arc=none smtp.client-ip=46.235.227.194; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=collabora.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id AE2BA20897;
	Sun, 31 Mar 2024 18:42:06 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6N1ssIJLtbv0; Sun, 31 Mar 2024 18:42:04 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 87F4020184;
	Sun, 31 Mar 2024 18:42:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 87F4020184
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 7937480005E;
	Sun, 31 Mar 2024 18:42:04 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:42:04 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:14 +0000
X-sender: <kvm+bounces-13104-martin.weber=secunet.com@vger.kernel.org>
X-Receiver: <martin.weber@secunet.com> ORCPT=rfc822;martin.weber@secunet.com
 NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJuYHy0vkvxLoOu7fW2WcxcPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAF4AAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249V2ViZXIgTWFydGluOTU1BQALABcAvgAAALMpUnVJ4+pPsL47FHo+lvtDTj1EQjIsQ049RGF0YWJhc2VzLENOPUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpLENOPUFkbWluaXN0cmF0aXZlIEdyb3VwcyxDTj1zZWN1bmV0LENOPU1pY3Jvc29mdCBFeGNoYW5nZSxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPXNlY3VuZXQsREM9ZGUFAA4AEQBACf3SYEkDT461FZzDv+B7BQAdAA8ADAAAAG1ieC1lc3Nlbi0wMQUAPAACAAAPADYAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0Lk1haWxSZWNpcGllbnQuRGlzcGxheU5hbWUPAA0AAABXZWJlciwgTWFydGluBQAMAAIAAAUAbAACAAAFAFgAFwBGAAAAm5gfLS+S/Eug67t9bZZzF0NOPVdlYmVyIE1hcnRpbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8AL
	wAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAdEWmlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAGAAAAG1hcnRpbi53ZWJlckBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQACAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBiAAoAPAAAAMuKAAAFAGQADwADAAAASHVi
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 31463
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=kvm+bounces-13104-martin.weber=secunet.com@vger.kernel.org; receiver=martin.weber@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 548842087B
X-Original-To: kvm@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711743514; cv=none; b=j2hUMl9NyGzSDJP9D+OX7+sbNQl02uJeOwLiIYfS7ZIoMaBPLsqmW/jyWFUtGqZN4jPEzBxKaNM7IowzhVMslqTg+//xfLymH6hV62MaIaGnIgOuOii5e9xzwtIRkH5HWMjNpof2iW7QWN7Tcw8zkKXKTjtgqP9CWAgXF8imcAQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711743514; c=relaxed/simple;
	bh=M1bVLI2QVrqN4cSmcZhh5HNh6nWGHhPJEonGQgPvO00=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q8XWirNIrCY/iG2sgaBNL9z10ipPNp8KvMULAgzBLiQ3oxYnUsFdhW++cX5jhVlGbpdAUnZG20D2pnBZ2mgswRNCJhh4m1A3AuXfmG60vYtoGDkDdiVVeJcQA7IKbu/UkeUEIi7tV7upwlWyDD7BLzxzw0IOs1hlQVJFBV1BUWw=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=L2zt8eif; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711743510;
	bh=M1bVLI2QVrqN4cSmcZhh5HNh6nWGHhPJEonGQgPvO00=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=L2zt8eif9xbOYilCC0YsH5YJqm0E16o6ScfkTW8PJ/tzy1yVnA9m7MIrFJkygElI4
	 9hCl+N3ah/v40+3Yx+05eCqrFqcX/Awpvn4TAeuhHQOQ+2N0rNKzn/gOCGMxoZr/Gq
	 DF/h2vk8S2rZYUfUNjluciLLrYgJv+amN4UxvGROCmzTJmOZ+DVJJnw3K4pPOUc4TY
	 i/xNMJah3fDLREZOStrAZWyACogXW5CaWGDtRv5u0TLiGFA9n0LpoIpiTsYcr08Jxl
	 b7svNLTCyPu+7BoeuNWz0Bky0Jlr+lhnkzgi3pd6Fh/OFrM5fTlRMzBRvyWIRIa/JA
	 +luzgRZU3AZeg==
Message-ID: <42ca1da5-445b-47ca-a952-444eaa921360@collabora.com>
Date: Sat, 30 Mar 2024 01:18:54 +0500
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, seanjc@google.com,
 pbonzini@redhat.com, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 shuah@kernel.org, vkuznets@redhat.com, peterz@infradead.org,
 ravi.v.shankar@intel.com, xin@zytor.com
Subject: Re: [PATCH v2 25/25] KVM: selftests: Add fred exception tests
To: Xin Li <xin3.li@intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-26-xin3.li@intel.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240207172646.3981-26-xin3.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On 2/7/24 10:26 PM, Xin Li wrote:
> Add tests for FRED event data and VMX nested-exception.
>=20
> FRED is designed to save a complete event context in its stack frame,
> e.g., FRED saves the faulting linear address of a #PF into a 64-bit
> event data field defined in FRED stack frame.  As such, FRED VMX adds
> event data handling during VMX transitions.
>=20
> Besides, FRED introduces event stack levels to dispatch an event handler
> onto a stack baesd on current stack level and stack levels defined in
> IA32_FRED_STKLVLS MSR for each exception vector.  VMX nested-exception
> support ensures a correct event stack level is chosen when a VM entry
> injects a nested exception, which is regarded as occurred in ring 0.
>=20
> To fully test the underlying FRED VMX code, this test should be run one
> more round with EPT disabled to inject page faults as nested exceptions.
>=20
> Originally-by: Shan Kang <shan.kang@intel.com>
> Signed-off-by: Xin Li <xin3.li@intel.com>
Thank you for the new test patch. We have been trying to ensure TAP
conformance for tests which cannot be achieved if new tests aren't using
TAP already. Please make your test TAP compliant.

> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/include/x86_64/processor.h  |  32 ++
>  .../testing/selftests/kvm/x86_64/fred_test.c  | 297 ++++++++++++++++++
Add generated binary object to .gitignore.

>  3 files changed, 330 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/fred_test.c
>=20
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftes=
ts/kvm/Makefile
> index 492e937fab00..eaac13a605f2 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -67,6 +67,7 @@ TEST_GEN_PROGS_x86_64 +=3D x86_64/get_msr_index_feature=
s
>  TEST_GEN_PROGS_x86_64 +=3D x86_64/exit_on_emulation_failure_test
>  TEST_GEN_PROGS_x86_64 +=3D x86_64/fix_hypercall_test
>  TEST_GEN_PROGS_x86_64 +=3D x86_64/hwcr_msr_test
> +TEST_GEN_PROGS_x86_64 +=3D x86_64/fred_test
>  TEST_GEN_PROGS_x86_64 +=3D x86_64/hyperv_clock
>  TEST_GEN_PROGS_x86_64 +=3D x86_64/hyperv_cpuid
>  TEST_GEN_PROGS_x86_64 +=3D x86_64/hyperv_evmcs
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/too=
ls/testing/selftests/kvm/include/x86_64/processor.h
> index bc5cd8628a20..ef7aaab790e0 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -1275,4 +1275,36 @@ void virt_map_level(struct kvm_vm *vm, uint64_t va=
ddr, uint64_t paddr,
>  #define PFERR_GUEST_PAGE_MASK	BIT_ULL(PFERR_GUEST_PAGE_BIT)
>  #define PFERR_IMPLICIT_ACCESS	BIT_ULL(PFERR_IMPLICIT_ACCESS_BIT)
> =20
> +/*
> + * FRED related data structures and functions
> + */
> +
> +#define FRED_SSX_NMI		BIT_ULL(18)
> +
> +struct fred_stack {
> +	u64 r15;
> +	u64 r14;
> +	u64 r13;
> +	u64 r12;
> +	u64 bp;
> +	u64 bx;
> +	u64 r11;
> +	u64 r10;
> +	u64 r9;
> +	u64 r8;
> +	u64 ax;
> +	u64 cx;
> +	u64 dx;
> +	u64 si;
> +	u64 di;
> +	u64 error_code;
> +	u64 ip;
> +	u64 csx;
> +	u64 flags;
> +	u64 sp;
> +	u64 ssx;
> +	u64 event_data;
> +	u64 reserved;
> +};
> +
>  #endif /* SELFTEST_KVM_PROCESSOR_H */
> diff --git a/tools/testing/selftests/kvm/x86_64/fred_test.c b/tools/testi=
ng/selftests/kvm/x86_64/fred_test.c
> new file mode 100644
> index 000000000000..412afa919568
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/fred_test.c
> @@ -0,0 +1,297 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * FRED nested exception tests
> + *
> + * Copyright (C) 2023, Intel, Inc.
> + */
> +#define _GNU_SOURCE /* for program_invocation_short_name */
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +#include <asm/msr-index.h>
> +
> +#include "apic.h"
> +#include "kvm_util.h"
> +#include "test_util.h"
> +#include "guest_modes.h"
> +#include "processor.h"
> +
> +#define IRQ_VECTOR 0xAA
> +
> +#define FRED_STKLVL(v,l)		(_AT(unsigned long, l) << (2 * (v)))
> +#define FRED_CONFIG_ENTRYPOINT(p)	_AT(unsigned long, (p))
> +
> +/* This address is already mapped in guest page table. */
> +#define FRED_VALID_RSP			0x8000
> +
> +/*
> + * The following addresses are not yet mapped in both EPT and guest page
> + * tables at the beginning.  As a result, it causes an EPT violation VM
> + * exit with an original guest #PF to access any of them for the first
> + * time.
> + *
> + * Use these addresses as guest FRED RSP0 to generate nested #PFs to tes=
t
> + * if event data are properly virtualized.
> + */
> +static unsigned long fred_invalid_rsp[4] =3D {
> +	0x0,
> +	0xf0000000,
> +	0xe0000000,
> +	0xd0000000,
> +};
> +
> +extern char asm_user_nop[];
> +extern char asm_user_ud[];
> +extern char asm_done_fault[];
> +
> +extern void asm_test_fault(int test);
> +
> +/*
> + * user level code for triggering faults.
> + */
> +asm(".pushsection .text\n"
> +    ".align 4096\n"
> +
> +    ".type asm_user_nop, @function\n"
> +    "asm_user_nop:\n"
> +    "1: .byte 0x90\n"
> +    "jmp 1b\n"
> +
> +    ".fill asm_user_ud - ., 1, 0xcc\n"
> +
> +    ".type asm_user_ud, @function\n"
> +    ".org asm_user_nop + 16\n"
> +    "asm_user_ud:\n"
> +    /* Trigger a #UD */
> +    "ud2\n"
> +
> +    ".align 4096, 0xcc\n"
> +    ".popsection");
> +
> +/* Send current stack level and #PF address */
> +#define GUEST_SYNC_CSL_FA(__stage, __pf_address)		\
> +	GUEST_SYNC_ARGS(__stage, __pf_address, 0, 0, 0)
> +
> +void fred_entry_from_user(struct fred_stack *stack)
> +{
> +	u32 current_stack_level =3D rdmsr(MSR_IA32_FRED_CONFIG) & 0x3;
> +
> +	GUEST_SYNC_CSL_FA(current_stack_level, stack->event_data);
> +
> +	/* Do NOT go back to user level, continue the next test instead */
> +	stack->ssx =3D 0x18;
> +	stack->csx =3D 0x10;
> +	stack->ip =3D (u64)&asm_done_fault;
> +}
> +
> +void fred_entry_from_kernel(struct fred_stack *stack)
> +{
> +	/*
> +	 * Keep NMI blocked to delay the delivery of the next NMI until
> +	 * returning to user level.
> +	 * */
> +	stack->ssx &=3D ~FRED_SSX_NMI;
> +}
> +
> +#define PUSH_REGS	\
> +	"push %rdi\n"	\
> +	"push %rsi\n"	\
> +	"push %rdx\n"	\
> +	"push %rcx\n"	\
> +	"push %rax\n"	\
> +	"push %r8\n"	\
> +	"push %r9\n"	\
> +	"push %r10\n"	\
> +	"push %r11\n"	\
> +	"push %rbx\n"	\
> +	"push %rbp\n"	\
> +	"push %r12\n"	\
> +	"push %r13\n"	\
> +	"push %r14\n"	\
> +	"push %r15\n"
> +
> +#define POP_REGS	\
> +	"pop %r15\n"	\
> +	"pop %r14\n"	\
> +	"pop %r13\n"	\
> +	"pop %r12\n"	\
> +	"pop %rbp\n"	\
> +	"pop %rbx\n"	\
> +	"pop %r11\n"	\
> +	"pop %r10\n"	\
> +	"pop %r9\n"	\
> +	"pop %r8\n"	\
> +	"pop %rax\n"	\
> +	"pop %rcx\n"	\
> +	"pop %rdx\n"	\
> +	"pop %rsi\n"	\
> +	"pop %rdi\n"
> +
> +/*
> + * FRED entry points.
> + */
> +asm(".pushsection .text\n"
> +    ".type asm_fred_entrypoint_user, @function\n"
> +    ".align 4096\n"
> +    "asm_fred_entrypoint_user:\n"
> +    "endbr64\n"
> +    PUSH_REGS
> +    "movq %rsp, %rdi\n"
> +    "call fred_entry_from_user\n"
> +    POP_REGS
> +    /* Do NOT go back to user level, continue the next test instead */
> +    ".byte 0xf2,0x0f,0x01,0xca\n"	/* ERETS */
> +
> +    ".fill asm_fred_entrypoint_kernel - ., 1, 0xcc\n"
> +
> +    ".type asm_fred_entrypoint_kernel, @function\n"
> +    ".org asm_fred_entrypoint_user + 256\n"
> +    "asm_fred_entrypoint_kernel:\n"
> +    "endbr64\n"
> +    PUSH_REGS
> +    "movq %rsp, %rdi\n"
> +    "call fred_entry_from_kernel\n"
> +    POP_REGS
> +    ".byte 0xf2,0x0f,0x01,0xca\n"	/* ERETS */
> +    ".align 4096, 0xcc\n"
> +    ".popsection");
> +
> +extern char asm_fred_entrypoint_user[];
> +
> +/*
> + * Prepare a FRED stack frame for ERETU to return to user level code,
> + * nop or ud2.
> + *
> + * Because FRED RSP0 is deliberately not mapped in guest page table,
> + * the delivery of interrupt/NMI or #UD from ring 3 causes a nested
> + * #PF, which is then delivered on FRED RSPx (x is 1, 2 or 3,
> + * determinated by MSR FRED_STKLVL[PF_VECTOR]).
> + */
> +asm(".pushsection .text\n"
> +    ".type asm_test_fault, @function\n"
> +    ".align 4096\n"
> +    "asm_test_fault:\n"
> +    "endbr64\n"
> +    "push %rbp\n"
> +    "mov %rsp, %rbp\n"
> +    "and $(~0x3f), %rsp\n"
> +    "push $0\n"
> +    "push $0\n"
> +    "mov $0x2b, %rax\n"
> +    /* Unblock NMI */
> +    "bts $18, %rax\n"
> +    /* Set long mode bit */
> +    "bts $57, %rax\n"
> +    "push %rax\n"
> +    /* No stack required for the FRED user level test code */
> +    "push $0\n"
> +    "pushf\n"
> +    "pop %rax\n"
> +    /* Allow external interrupts */
> +    "bts $9, %rax\n"
> +    "push %rax\n"
> +    "mov $0x33, %rax\n"
> +    "push %rax\n"
> +    "cmp $0, %edi\n"
> +    "jne 1f\n"
> +    "lea asm_user_nop(%rip), %rax\n"
> +    "jmp 2f\n"
> +    "1: lea asm_user_ud(%rip), %rax\n"
> +    "2: push %rax\n"
> +    "push $0\n"
> +    /* ERETU to user level code to allow event delivery immediately */
> +    ".byte 0xf3,0x0f,0x01,0xca\n"
> +    "asm_done_fault:\n"
> +    "mov %rbp, %rsp\n"
> +    "pop %rbp\n"
> +    "ret\n"
> +    ".align 4096, 0xcc\n"
> +    ".popsection");
> +
> +/*
> + * To fully test the underlying FRED VMX code, this test should be run o=
ne
> + * more round with EPT disabled to inject page faults as nested exceptio=
ns.
> + */
> +static void guest_code(void)
> +{
> +	wrmsr(MSR_IA32_FRED_CONFIG,
> +	      FRED_CONFIG_ENTRYPOINT(asm_fred_entrypoint_user));
> +
> +	wrmsr(MSR_IA32_FRED_RSP1, FRED_VALID_RSP);
> +	wrmsr(MSR_IA32_FRED_RSP2, FRED_VALID_RSP);
> +	wrmsr(MSR_IA32_FRED_RSP3, FRED_VALID_RSP);
> +
> +	/* Enable FRED */
> +	set_cr4(get_cr4() | X86_CR4_FRED);
> +
> +	x2apic_enable();
> +
> +	wrmsr(MSR_IA32_FRED_STKLVLS, FRED_STKLVL(PF_VECTOR, 1));
> +	wrmsr(MSR_IA32_FRED_RSP0, fred_invalid_rsp[1]);
> +	/* 1: ud2 to generate #UD */
> +	asm_test_fault(1);
> +
> +	wrmsr(MSR_IA32_FRED_STKLVLS, FRED_STKLVL(PF_VECTOR, 2));
> +	wrmsr(MSR_IA32_FRED_RSP0, fred_invalid_rsp[2]);
> +	asm volatile("cli");
> +	/* Create a pending interrupt on current vCPU */
> +	x2apic_write_reg(APIC_ICR, APIC_DEST_SELF | APIC_INT_ASSERT |
> +			 APIC_DM_FIXED | IRQ_VECTOR);
> +	/* Return to ring 3 */
> +	asm_test_fault(0);
> +	x2apic_write_reg(APIC_EOI, 0);
> +
> +	wrmsr(MSR_IA32_FRED_STKLVLS, FRED_STKLVL(PF_VECTOR, 3));
> +	wrmsr(MSR_IA32_FRED_RSP0, fred_invalid_rsp[3]);
> +	/*
> +	 * The first NMI is just to have NMI blocked in ring 0, because
> +	 * fred_entry_from_kernel() deliberately clears the NMI bit in
> +	 * FRED stack frame.
> +	 */
> +	x2apic_write_reg(APIC_ICR, APIC_DEST_SELF | APIC_INT_ASSERT |
> +			 APIC_DM_NMI | NMI_VECTOR);
> +	/* The second NMI will be delivered after returning to ring 3 */
> +	x2apic_write_reg(APIC_ICR, APIC_DEST_SELF | APIC_INT_ASSERT |
> +			 APIC_DM_NMI | NMI_VECTOR);
> +	/* Return to ring 3 */
> +	asm_test_fault(0);
> +
> +	GUEST_DONE();
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	struct ucall uc;
> +	uint64_t expected_current_stack_level =3D 1;
> +
> +	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_FRED));
> +
> +	vm =3D __vm_create_with_vcpus(VM_SHAPE(VM_MODE_PXXV48_4K_USER), 1, 0,
> +				    guest_code, &vcpu);
> +
> +	while (true) {
> +		uint64_t r;
> +
> +		vcpu_run(vcpu);
> +
> +		r =3D get_ucall(vcpu, &uc);
> +
> +		if (r =3D=3D UCALL_DONE)
> +			break;
> +
> +		if (r =3D=3D UCALL_SYNC) {
> +			TEST_ASSERT((uc.args[1] =3D=3D expected_current_stack_level) &&
> +				    (uc.args[2] =3D=3D fred_invalid_rsp[expected_current_stack_level=
] - 1),
> +				    "Incorrect stack level %lx and #PF address %lx\n",
> +				    uc.args[1], uc.args[2]);
> +			expected_current_stack_level++;
> +		}
> +	}
> +
> +	kvm_vm_free(vm);
> +	return 0;
> +}

--=20
BR,
Muhammad Usama Anjum

X-sender: <linux-kernel+bounces-125382-steffen.klassert=3Dsecunet.com@vger.=
kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Drfc822;steffen.klassert@=
secunet.com NOTIFY=3DNEVER; X-ExtendedProps=3DBQAVABYAAgAAAAUAFAARAPDFCS25B=
AlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURh=
dGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQB=
HAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3=
VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4Y=
wUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5n=
ZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl=
2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ0=
49Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAH=
QAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5z=
cG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAw=
AAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbi=
xPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQ=
XV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1p=
Y3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmV=
yc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=3D
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAdEWmlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2Vj=
dW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwA=
AAAAABQAFAAIAAQUAYgAKAD0AAADLigAABQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 31682
Received: from cas-essen-01.secunet.de (10.53.40.201) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 21:18:58 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Fri, 29 Mar 2024 21:18:58 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id EF002202A6
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 21:18:57 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -5.051
X-Spam-Level:
X-Spam-Status: No, score=3D-5.051 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIM_SIGNED=3D0.1, DKIM_VALID=3D-0.1,
	DKIM_VALID_AU=3D-0.1, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, RCVD_IN_DNSWL_MED=3D-2.3, SPF_HELO_NONE=3D0.001,
	SPF_PASS=3D-0.001] autolearn=3Dham autolearn_force=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (2048-bit key) header.d=3Dcollabora.com
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xr8udnqlhNFw for <steffen.klassert@secunet.com>;
	Fri, 29 Mar 2024 21:18:56 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D139.178.88.99; helo=3Dsv.mirrors.kernel.org; envelope-from=3Dlinux-kerne=
l+bounces-125382-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=
=3Dsteffen.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 89D0720270
Authentication-Results: b.mx.secunet.com;
	dkim=3Dpass (2048-bit key) header.d=3Dcollabora.com header.i=3D@collabora.=
com header.b=3D"L2zt8eif"
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id 89D0720270
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 21:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B09286CE4
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 20:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E6713BC1B;
	Fri, 29 Mar 2024 20:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (2048-bit key) header.d=3Dcollabora.com header.i=3D@collabora.=
com header.b=3D"L2zt8eif"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235=
.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4699D13BAD1;
	Fri, 29 Mar 2024 20:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D46.235.227.194
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711743514; cv=3Dnone; b=3Dj2hUMl9NyGzSDJP9D+OX7+sbNQl02uJeOwLiIYfS7ZI=
oMaBPLsqmW/jyWFUtGqZN4jPEzBxKaNM7IowzhVMslqTg+//xfLymH6hV62MaIaGnIgOuOii5e9=
xzwtIRkH5HWMjNpof2iW7QWN7Tcw8zkKXKTjtgqP9CWAgXF8imcAQ=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711743514; c=3Drelaxed/simple;
	bh=3DM1bVLI2QVrqN4cSmcZhh5HNh6nWGHhPJEonGQgPvO00=3D;
	h=3DMessage-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=3DQ8XWirNIrCY/iG2sgaBNL9z10ipPNp8KvMULAgzBLiQ=
3oxYnUsFdhW++cX5jhVlGbpdAUnZG20D2pnBZ2mgswRNCJhh4m1A3AuXfmG60vYtoGDkDdiVVeJ=
cQA7IKbu/UkeUEIi7tV7upwlWyDD7BLzxzw0IOs1hlQVJFBV1BUWw=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dquarantine dis=3Dnone) header.from=3Dcollabora.com; spf=3Dpass smtp.mai=
lfrom=3Dcollabora.com; dkim=3Dpass (2048-bit key) header.d=3Dcollabora.com =
header.i=3D@collabora.com header.b=3DL2zt8eif; arc=3Dnone smtp.client-ip=3D=
46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dquarant=
ine dis=3Dnone) header.from=3Dcollabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dcollabora.com
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/simple; d=3Dcollabora.co=
m;
	s=3Dmail; t=3D1711743510;
	bh=3DM1bVLI2QVrqN4cSmcZhh5HNh6nWGHhPJEonGQgPvO00=3D;
	h=3DDate:Cc:Subject:To:References:From:In-Reply-To:From;
	b=3DL2zt8eif9xbOYilCC0YsH5YJqm0E16o6ScfkTW8PJ/tzy1yVnA9m7MIrFJkygElI4
	 9hCl+N3ah/v40+3Yx+05eCqrFqcX/Awpvn4TAeuhHQOQ+2N0rNKzn/gOCGMxoZr/Gq
	 DF/h2vk8S2rZYUfUNjluciLLrYgJv+amN4UxvGROCmzTJmOZ+DVJJnw3K4pPOUc4TY
	 i/xNMJah3fDLREZOStrAZWyACogXW5CaWGDtRv5u0TLiGFA9n0LpoIpiTsYcr08Jxl
	 b7svNLTCyPu+7BoeuNWz0Bky0Jlr+lhnkzgi3pd6Fh/OFrM5fTlRMzBRvyWIRIa/JA
	 +luzgRZU3AZeg=3D=3D
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaw=
s.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SH=
A256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9C34B3780C21;
	Fri, 29 Mar 2024 20:18:23 +0000 (UTC)
Message-ID: <42ca1da5-445b-47ca-a952-444eaa921360@collabora.com>
Date: Sat, 30 Mar 2024 01:18:54 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, seanjc@google.com,
 pbonzini@redhat.com, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 shuah@kernel.org, vkuznets@redhat.com, peterz@infradead.org,
 ravi.v.shankar@intel.com, xin@zytor.com
Subject: Re: [PATCH v2 25/25] KVM: selftests: Add fred exception tests
To: Xin Li <xin3.li@intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-26-xin3.li@intel.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240207172646.3981-26-xin3.li@intel.com>
Content-Type: text/plain; charset=3D"UTF-8"
Content-Transfer-Encoding: 7bit
Return-Path: linux-kernel+bounces-125382-steffen.klassert=3Dsecunet.com@vge=
r.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 20:18:58.0490
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 7abcb20b-c178-40ec-af7b-08dc=
502d7707
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-es=
sen-02.secunet.de:TOTAL-HUB=3D0.233|SMR=3D0.133(SMRDE=3D0.003|SMRC=3D0.129(=
SMRCL=3D0.103|X-SMRCR=3D0.128))|CAT=3D0.099(CATRESL=3D0.029
 (CATRESLP2R=3D0.019)|CATORES=3D0.064(CATRS=3D0.064(CATRS-Transport Rule
 Agent=3D0.001(X-ETREX=3D0.001 )|CATRS-Index Routing
 Agent=3D0.060))|CATORT=3D0.003(CATRT=3D0.003(CATRT-Journal Agent=3D0.003
 )));2024-03-29T20:18:58.317Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 19243
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-01.secunet.de:TO=
TAL-FE=3D0.034|SMR=3D0.024(SMRPI=3D0.021(SMRPI-FrontendProxyAgent=3D0.021))=
|SMS=3D0.010
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-essen-02
X-MS-Exchange-Organization-RulesExecuted: mbx-essen-02
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAa8WAAAPAAADH4sIAAAAAAAEAMU6C1fb=
VpoSfvHOm6avmT
 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
 4rRACk5zNYUJ58sFFc5Mc0thiYm4VieZl56AfG3DhupqhdciEDLYx5
 +18mvsqYy159lXGXV2R5Agp3xqrbZ+FeLhplSwx8UwLzZYjs3679gV
 0O6hvBKCQfptmCJPIdvmnJ011HBgeoINfNxOPI71UWEw+NNGn+VYaf
 Tqcxfq+N7MXjIbQon/BEP7dgF8E5hCcR7pBBCXwn5nd6mBvRe1lX3N
 5ksdXJUcr6hi8HyEmmZet+x096fqZaHBNnIeEIH/jTSvp1Rl57hktV
 0KVIDkHw29G6MDPPpV9OAVNUHSjKvv5Q/czRuRnilvXD2T7jh3yGhj
 W/8w+U9sdPucoKN2UYfhZ0aBTXuBJqe/I8iIWuIBb4em2K7Mj3D2CS
 r+h2FFXkG+gGt3Z89TEX3ECiXFnytKUpNbdEfXJeXoROIcEMPyyRsa
 QUhVAhK0rOC5RA4P3zgBMVEqCvLmD+azU0n2aR1Jc0AgQpCLrQr6Mr
 f5H+FvaQfERApRreGnkd3vuF9UDNv3Kf7ZvzUyVPEzOUyUshOtnQ85
 +ixz1kBUofBt/g4fc6Dz4I878GE2nbYUoAAAECpAQ8P3htbCB2ZXJz
 aW9uPSIxLjAiIGVuY29kaW5nPSJ1dGYtMTYiPz4NCjxUYXNrU2V0Pg
 0KICA8VmVyc2lvbj4xNS4wLjAuMDwvVmVyc2lvbj4NCiAgPFRhc2tz
 Pg0KICAgIDxUYXNrIFN0YXJ0SW5kZXg9IjExNDAiPg0KICAgICAgPF
 Rhc2tTdHJpbmc+UGxlYXNlIG1ha2UgeW91ciB0ZXN0IFRBUCBjb21w
 bGlhbnQuPC9UYXNrU3RyaW5nPg0KICAgICAgPEFzc2lnbmVlcz4NCi
 AgICAgICAgPEVtYWlsVXNlciBJZD0ieGluMy5saUBpbnRlbC5jb20i
 PlhpbiBMaTwvRW1haWxVc2VyPg0KICAgICAgICA8RW1haWxVc2VyIE
 lkPSJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiAvPg0KICAg
 ICAgICA8RW1haWxVc2VyIElkPSJrdm1Admdlci5rZXJuZWwub3JnIi
 AvPg0KICAgICAgICA8RW1haWxVc2VyIElkPSJsaW51eC1kb2NAdmdl
 ci5rZXJuZWwub3JnIiAvPg0KICAgICAgICA8RW1haWxVc2VyIElkPS
 JsaW51eC1rc2VsZnRlc3RAdmdlci5rZXJuZWwub3JnIiAvPg0KICAg
 ICAgPC9Bc3NpZ25lZXM+DQogICAgPC9UYXNrPg0KICA8L1Rhc2tzPg
 0KPC9UYXNrU2V0PgEKugI8P3htbCB2ZXJzaW9uPSIxLjAiIGVuY29k
 aW5nPSJ1dGYtMTYiPz4NCjxFbWFpbFNldD4NCiAgPFZlcnNpb24+MT
 UuMC4wLjA8L1ZlcnNpb24+DQogIDxFbWFpbHM+DQogICAgPEVtYWls
 IFN0YXJ0SW5kZXg9IjkxNyI+DQogICAgICA8RW1haWxTdHJpbmc+c2
 hhbi5rYW5nQGludGVsLmNvbTwvRW1haWxTdHJpbmc+DQogICAgPC9F
 bWFpbD4NCiAgICA8RW1haWwgU3RhcnRJbmRleD0iOTY0Ij4NCiAgIC
 AgIDxFbWFpbFN0cmluZz54aW4zLmxpQGludGVsLmNvbTwvRW1haWxT
 dHJpbmc+DQogICAgPC9FbWFpbD4NCiAgPC9FbWFpbHM+DQo8L0VtYW
 lsU2V0PgEMvgY8P3htbCB2ZXJzaW9uPSIxLjAiIGVuY29kaW5nPSJ1
 dGYtMTYiPz4NCjxDb250YWN0U2V0Pg0KICA8VmVyc2lvbj4xNS4wLj
 AuMDwvVmVyc2lvbj4NCiAgPENvbnRhY3RzPg0KICAgIDxDb250YWN0
 IFN0YXJ0SW5kZXg9IjkxMSI+DQogICAgICA8UGVyc29uIFN0YXJ0SW
 5kZXg9IjkxMSI+DQogICAgICAgIDxQZXJzb25TdHJpbmc+S2FuZzwv
 UGVyc29uU3RyaW5nPg0KICAgICAgPC9QZXJzb24+DQogICAgICA8RW
 1haWxzPg0KICAgICAgICA8RW1haWwgU3RhcnRJbmRleD0iOTE3Ij4N
 CiAgICAgICAgICA8RW1haWxTdHJpbmc+c2hhbi5rYW5nQGludGVsLm
 NvbTwvRW1haWxTdHJpbmc+DQogICAgICAgIDwvRW1haWw+DQogICAg
 ICA8L0VtYWlscz4NCiAgICAgIDxDb250YWN0U3RyaW5nPkthbmcgJm
 x0O3NoYW4ua2FuZ0BpbnRlbC5jb208L0NvbnRhY3RTdHJpbmc+DQog
 ICAgPC9Db250YWN0Pg0KICAgIDxDb250YWN0IFN0YXJ0SW5kZXg9Ij
 k1NiI+DQogICAgICA8UGVyc29uIFN0YXJ0SW5kZXg9Ijk1NiI+DQog
 ICAgICAgIDxQZXJzb25TdHJpbmc+WGluIExpPC9QZXJzb25TdHJpbm
 c+DQogICAgICA8L1BlcnNvbj4NCiAgICAgIDxFbWFpbHM+DQogICAg
 ICAgIDxFbWFpbCBTdGFydEluZGV4PSI5NjQiPg0KICAgICAgICAgID
 xFbWFpbFN0cmluZz54aW4zLmxpQGludGVsLmNvbTwvRW1haWxTdHJp
 bmc+DQogICAgICAgIDwvRW1haWw+DQogICAgICA8L0VtYWlscz4NCi
 AgICAgIDxDb250YWN0U3RyaW5nPlhpbiBMaSAmbHQ7eGluMy5saUBp
 bnRlbC5jb208L0NvbnRhY3RTdHJpbmc+DQogICAgPC9Db250YWN0Pg
 0KICA8L0NvbnRhY3RzPg0KPC9Db250YWN0U2V0PgEOzwFSZXRyaWV2
 ZXJPcGVyYXRvciwxMCwwO1JldHJpZXZlck9wZXJhdG9yLDExLDQ7UG
 9zdERvY1BhcnNlck9wZXJhdG9yLDEwLDE7UG9zdERvY1BhcnNlck9w
 ZXJhdG9yLDExLDA7UG9zdFdvcmRCcmVha2VyRGlhZ25vc3RpY09wZX
 JhdG9yLDEwLDg7UG9zdFdvcmRCcmVha2VyRGlhZ25vc3RpY09wZXJh
 dG9yLDExLDA7VHJhbnNwb3J0V3JpdGVyUHJvZHVjZXIsMjAsMjk=3D
X-MS-Exchange-Forest-IndexAgent: 1 7733
X-MS-Exchange-Forest-EmailMessageHash: BCAF8B2D
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

On 2/7/24 10:26 PM, Xin Li wrote:
> Add tests for FRED event data and VMX nested-exception.
>=20
> FRED is designed to save a complete event context in its stack frame,
> e.g., FRED saves the faulting linear address of a #PF into a 64-bit
> event data field defined in FRED stack frame.  As such, FRED VMX adds
> event data handling during VMX transitions.
>=20
> Besides, FRED introduces event stack levels to dispatch an event handler
> onto a stack baesd on current stack level and stack levels defined in
> IA32_FRED_STKLVLS MSR for each exception vector.  VMX nested-exception
> support ensures a correct event stack level is chosen when a VM entry
> injects a nested exception, which is regarded as occurred in ring 0.
>=20
> To fully test the underlying FRED VMX code, this test should be run one
> more round with EPT disabled to inject page faults as nested exceptions.
>=20
> Originally-by: Shan Kang <shan.kang@intel.com>
> Signed-off-by: Xin Li <xin3.li@intel.com>
Thank you for the new test patch. We have been trying to ensure TAP
conformance for tests which cannot be achieved if new tests aren't using
TAP already. Please make your test TAP compliant.

> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/include/x86_64/processor.h  |  32 ++
>  .../testing/selftests/kvm/x86_64/fred_test.c  | 297 ++++++++++++++++++
Add generated binary object to .gitignore.

>  3 files changed, 330 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/fred_test.c
>=20
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftes=
ts/kvm/Makefile
> index 492e937fab00..eaac13a605f2 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -67,6 +67,7 @@ TEST_GEN_PROGS_x86_64 +=3D x86_64/get_msr_index_feature=
s
>  TEST_GEN_PROGS_x86_64 +=3D x86_64/exit_on_emulation_failure_test
>  TEST_GEN_PROGS_x86_64 +=3D x86_64/fix_hypercall_test
>  TEST_GEN_PROGS_x86_64 +=3D x86_64/hwcr_msr_test
> +TEST_GEN_PROGS_x86_64 +=3D x86_64/fred_test
>  TEST_GEN_PROGS_x86_64 +=3D x86_64/hyperv_clock
>  TEST_GEN_PROGS_x86_64 +=3D x86_64/hyperv_cpuid
>  TEST_GEN_PROGS_x86_64 +=3D x86_64/hyperv_evmcs
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/too=
ls/testing/selftests/kvm/include/x86_64/processor.h
> index bc5cd8628a20..ef7aaab790e0 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -1275,4 +1275,36 @@ void virt_map_level(struct kvm_vm *vm, uint64_t va=
ddr, uint64_t paddr,
>  #define PFERR_GUEST_PAGE_MASK	BIT_ULL(PFERR_GUEST_PAGE_BIT)
>  #define PFERR_IMPLICIT_ACCESS	BIT_ULL(PFERR_IMPLICIT_ACCESS_BIT)
> =20
> +/*
> + * FRED related data structures and functions
> + */
> +
> +#define FRED_SSX_NMI		BIT_ULL(18)
> +
> +struct fred_stack {
> +	u64 r15;
> +	u64 r14;
> +	u64 r13;
> +	u64 r12;
> +	u64 bp;
> +	u64 bx;
> +	u64 r11;
> +	u64 r10;
> +	u64 r9;
> +	u64 r8;
> +	u64 ax;
> +	u64 cx;
> +	u64 dx;
> +	u64 si;
> +	u64 di;
> +	u64 error_code;
> +	u64 ip;
> +	u64 csx;
> +	u64 flags;
> +	u64 sp;
> +	u64 ssx;
> +	u64 event_data;
> +	u64 reserved;
> +};
> +
>  #endif /* SELFTEST_KVM_PROCESSOR_H */
> diff --git a/tools/testing/selftests/kvm/x86_64/fred_test.c b/tools/testi=
ng/selftests/kvm/x86_64/fred_test.c
> new file mode 100644
> index 000000000000..412afa919568
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/fred_test.c
> @@ -0,0 +1,297 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * FRED nested exception tests
> + *
> + * Copyright (C) 2023, Intel, Inc.
> + */
> +#define _GNU_SOURCE /* for program_invocation_short_name */
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +#include <asm/msr-index.h>
> +
> +#include "apic.h"
> +#include "kvm_util.h"
> +#include "test_util.h"
> +#include "guest_modes.h"
> +#include "processor.h"
> +
> +#define IRQ_VECTOR 0xAA
> +
> +#define FRED_STKLVL(v,l)		(_AT(unsigned long, l) << (2 * (v)))
> +#define FRED_CONFIG_ENTRYPOINT(p)	_AT(unsigned long, (p))
> +
> +/* This address is already mapped in guest page table. */
> +#define FRED_VALID_RSP			0x8000
> +
> +/*
> + * The following addresses are not yet mapped in both EPT and guest page
> + * tables at the beginning.  As a result, it causes an EPT violation VM
> + * exit with an original guest #PF to access any of them for the first
> + * time.
> + *
> + * Use these addresses as guest FRED RSP0 to generate nested #PFs to tes=
t
> + * if event data are properly virtualized.
> + */
> +static unsigned long fred_invalid_rsp[4] =3D {
> +	0x0,
> +	0xf0000000,
> +	0xe0000000,
> +	0xd0000000,
> +};
> +
> +extern char asm_user_nop[];
> +extern char asm_user_ud[];
> +extern char asm_done_fault[];
> +
> +extern void asm_test_fault(int test);
> +
> +/*
> + * user level code for triggering faults.
> + */
> +asm(".pushsection .text\n"
> +    ".align 4096\n"
> +
> +    ".type asm_user_nop, @function\n"
> +    "asm_user_nop:\n"
> +    "1: .byte 0x90\n"
> +    "jmp 1b\n"
> +
> +    ".fill asm_user_ud - ., 1, 0xcc\n"
> +
> +    ".type asm_user_ud, @function\n"
> +    ".org asm_user_nop + 16\n"
> +    "asm_user_ud:\n"
> +    /* Trigger a #UD */
> +    "ud2\n"
> +
> +    ".align 4096, 0xcc\n"
> +    ".popsection");
> +
> +/* Send current stack level and #PF address */
> +#define GUEST_SYNC_CSL_FA(__stage, __pf_address)		\
> +	GUEST_SYNC_ARGS(__stage, __pf_address, 0, 0, 0)
> +
> +void fred_entry_from_user(struct fred_stack *stack)
> +{
> +	u32 current_stack_level =3D rdmsr(MSR_IA32_FRED_CONFIG) & 0x3;
> +
> +	GUEST_SYNC_CSL_FA(current_stack_level, stack->event_data);
> +
> +	/* Do NOT go back to user level, continue the next test instead */
> +	stack->ssx =3D 0x18;
> +	stack->csx =3D 0x10;
> +	stack->ip =3D (u64)&asm_done_fault;
> +}
> +
> +void fred_entry_from_kernel(struct fred_stack *stack)
> +{
> +	/*
> +	 * Keep NMI blocked to delay the delivery of the next NMI until
> +	 * returning to user level.
> +	 * */
> +	stack->ssx &=3D ~FRED_SSX_NMI;
> +}
> +
> +#define PUSH_REGS	\
> +	"push %rdi\n"	\
> +	"push %rsi\n"	\
> +	"push %rdx\n"	\
> +	"push %rcx\n"	\
> +	"push %rax\n"	\
> +	"push %r8\n"	\
> +	"push %r9\n"	\
> +	"push %r10\n"	\
> +	"push %r11\n"	\
> +	"push %rbx\n"	\
> +	"push %rbp\n"	\
> +	"push %r12\n"	\
> +	"push %r13\n"	\
> +	"push %r14\n"	\
> +	"push %r15\n"
> +
> +#define POP_REGS	\
> +	"pop %r15\n"	\
> +	"pop %r14\n"	\
> +	"pop %r13\n"	\
> +	"pop %r12\n"	\
> +	"pop %rbp\n"	\
> +	"pop %rbx\n"	\
> +	"pop %r11\n"	\
> +	"pop %r10\n"	\
> +	"pop %r9\n"	\
> +	"pop %r8\n"	\
> +	"pop %rax\n"	\
> +	"pop %rcx\n"	\
> +	"pop %rdx\n"	\
> +	"pop %rsi\n"	\
> +	"pop %rdi\n"
> +
> +/*
> + * FRED entry points.
> + */
> +asm(".pushsection .text\n"
> +    ".type asm_fred_entrypoint_user, @function\n"
> +    ".align 4096\n"
> +    "asm_fred_entrypoint_user:\n"
> +    "endbr64\n"
> +    PUSH_REGS
> +    "movq %rsp, %rdi\n"
> +    "call fred_entry_from_user\n"
> +    POP_REGS
> +    /* Do NOT go back to user level, continue the next test instead */
> +    ".byte 0xf2,0x0f,0x01,0xca\n"	/* ERETS */
> +
> +    ".fill asm_fred_entrypoint_kernel - ., 1, 0xcc\n"
> +
> +    ".type asm_fred_entrypoint_kernel, @function\n"
> +    ".org asm_fred_entrypoint_user + 256\n"
> +    "asm_fred_entrypoint_kernel:\n"
> +    "endbr64\n"
> +    PUSH_REGS
> +    "movq %rsp, %rdi\n"
> +    "call fred_entry_from_kernel\n"
> +    POP_REGS
> +    ".byte 0xf2,0x0f,0x01,0xca\n"	/* ERETS */
> +    ".align 4096, 0xcc\n"
> +    ".popsection");
> +
> +extern char asm_fred_entrypoint_user[];
> +
> +/*
> + * Prepare a FRED stack frame for ERETU to return to user level code,
> + * nop or ud2.
> + *
> + * Because FRED RSP0 is deliberately not mapped in guest page table,
> + * the delivery of interrupt/NMI or #UD from ring 3 causes a nested
> + * #PF, which is then delivered on FRED RSPx (x is 1, 2 or 3,
> + * determinated by MSR FRED_STKLVL[PF_VECTOR]).
> + */
> +asm(".pushsection .text\n"
> +    ".type asm_test_fault, @function\n"
> +    ".align 4096\n"
> +    "asm_test_fault:\n"
> +    "endbr64\n"
> +    "push %rbp\n"
> +    "mov %rsp, %rbp\n"
> +    "and $(~0x3f), %rsp\n"
> +    "push $0\n"
> +    "push $0\n"
> +    "mov $0x2b, %rax\n"
> +    /* Unblock NMI */
> +    "bts $18, %rax\n"
> +    /* Set long mode bit */
> +    "bts $57, %rax\n"
> +    "push %rax\n"
> +    /* No stack required for the FRED user level test code */
> +    "push $0\n"
> +    "pushf\n"
> +    "pop %rax\n"
> +    /* Allow external interrupts */
> +    "bts $9, %rax\n"
> +    "push %rax\n"
> +    "mov $0x33, %rax\n"
> +    "push %rax\n"
> +    "cmp $0, %edi\n"
> +    "jne 1f\n"
> +    "lea asm_user_nop(%rip), %rax\n"
> +    "jmp 2f\n"
> +    "1: lea asm_user_ud(%rip), %rax\n"
> +    "2: push %rax\n"
> +    "push $0\n"
> +    /* ERETU to user level code to allow event delivery immediately */
> +    ".byte 0xf3,0x0f,0x01,0xca\n"
> +    "asm_done_fault:\n"
> +    "mov %rbp, %rsp\n"
> +    "pop %rbp\n"
> +    "ret\n"
> +    ".align 4096, 0xcc\n"
> +    ".popsection");
> +
> +/*
> + * To fully test the underlying FRED VMX code, this test should be run o=
ne
> + * more round with EPT disabled to inject page faults as nested exceptio=
ns.
> + */
> +static void guest_code(void)
> +{
> +	wrmsr(MSR_IA32_FRED_CONFIG,
> +	      FRED_CONFIG_ENTRYPOINT(asm_fred_entrypoint_user));
> +
> +	wrmsr(MSR_IA32_FRED_RSP1, FRED_VALID_RSP);
> +	wrmsr(MSR_IA32_FRED_RSP2, FRED_VALID_RSP);
> +	wrmsr(MSR_IA32_FRED_RSP3, FRED_VALID_RSP);
> +
> +	/* Enable FRED */
> +	set_cr4(get_cr4() | X86_CR4_FRED);
> +
> +	x2apic_enable();
> +
> +	wrmsr(MSR_IA32_FRED_STKLVLS, FRED_STKLVL(PF_VECTOR, 1));
> +	wrmsr(MSR_IA32_FRED_RSP0, fred_invalid_rsp[1]);
> +	/* 1: ud2 to generate #UD */
> +	asm_test_fault(1);
> +
> +	wrmsr(MSR_IA32_FRED_STKLVLS, FRED_STKLVL(PF_VECTOR, 2));
> +	wrmsr(MSR_IA32_FRED_RSP0, fred_invalid_rsp[2]);
> +	asm volatile("cli");
> +	/* Create a pending interrupt on current vCPU */
> +	x2apic_write_reg(APIC_ICR, APIC_DEST_SELF | APIC_INT_ASSERT |
> +			 APIC_DM_FIXED | IRQ_VECTOR);
> +	/* Return to ring 3 */
> +	asm_test_fault(0);
> +	x2apic_write_reg(APIC_EOI, 0);
> +
> +	wrmsr(MSR_IA32_FRED_STKLVLS, FRED_STKLVL(PF_VECTOR, 3));
> +	wrmsr(MSR_IA32_FRED_RSP0, fred_invalid_rsp[3]);
> +	/*
> +	 * The first NMI is just to have NMI blocked in ring 0, because
> +	 * fred_entry_from_kernel() deliberately clears the NMI bit in
> +	 * FRED stack frame.
> +	 */
> +	x2apic_write_reg(APIC_ICR, APIC_DEST_SELF | APIC_INT_ASSERT |
> +			 APIC_DM_NMI | NMI_VECTOR);
> +	/* The second NMI will be delivered after returning to ring 3 */
> +	x2apic_write_reg(APIC_ICR, APIC_DEST_SELF | APIC_INT_ASSERT |
> +			 APIC_DM_NMI | NMI_VECTOR);
> +	/* Return to ring 3 */
> +	asm_test_fault(0);
> +
> +	GUEST_DONE();
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	struct ucall uc;
> +	uint64_t expected_current_stack_level =3D 1;
> +
> +	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_FRED));
> +
> +	vm =3D __vm_create_with_vcpus(VM_SHAPE(VM_MODE_PXXV48_4K_USER), 1, 0,
> +				    guest_code, &vcpu);
> +
> +	while (true) {
> +		uint64_t r;
> +
> +		vcpu_run(vcpu);
> +
> +		r =3D get_ucall(vcpu, &uc);
> +
> +		if (r =3D=3D UCALL_DONE)
> +			break;
> +
> +		if (r =3D=3D UCALL_SYNC) {
> +			TEST_ASSERT((uc.args[1] =3D=3D expected_current_stack_level) &&
> +				    (uc.args[2] =3D=3D fred_invalid_rsp[expected_current_stack_level=
] - 1),
> +				    "Incorrect stack level %lx and #PF address %lx\n",
> +				    uc.args[1], uc.args[2]);
> +			expected_current_stack_level++;
> +		}
> +	}
> +
> +	kvm_vm_free(vm);
> +	return 0;
> +}

--=20
BR,
Muhammad Usama Anjum


