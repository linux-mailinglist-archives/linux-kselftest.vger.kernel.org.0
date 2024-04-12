Return-Path: <linux-kselftest+bounces-7762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0198A2543
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 06:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 080E8B22012
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 04:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DC1C13C;
	Fri, 12 Apr 2024 04:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KAdRL7AB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60025199B4
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 04:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712896948; cv=none; b=oHJP0UKX50eJy2EqjPJFmXAtLKccMiCncFmR6KtCuq/bboqaBoVJPZbZkeiPNQurc/tfnO5t/V1yDuJ1ToKrxVPH7mbq1j9nnelyDcybYo33hPp/8GqHGwJ1DBa7NCdhOqoFjh9cNj/ZMRMaIHoWMRRtLN2lrCrgJyf/aVgKmA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712896948; c=relaxed/simple;
	bh=vkCzVpCRRUioCGR8LPETsGHbP0mD8/yLkEzCZ2O+Jhc=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=QhL+rEzjhxu2Ibhv1vBem0t3u1uZTqQfczZKYE3SPXbMpQWXmJ2Hk3X3ce/SmiHSVuqNe2wdJaurvjPYCpMgkxPlcWsBpDB2EJIUCiEmkLIu80vLZbAyocluW1wbl9M1QD5+dob2mV4NYq2EBBgZ4usNPzuAq3rtEwZ+UsWB4XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KAdRL7AB; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dce775fa8adso993279276.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 21:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712896945; x=1713501745; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CNKCkNsot/Do8CE0Y5PRYhfWnEd0oPU98R4yomeMOBg=;
        b=KAdRL7ABeQBDR68zGR4r3gd3yBnOHSANTuyY/BAJQisQ5OA/7GHCdz5ujAcmyAp1cZ
         +UKf3PbgVyhlLLD39mB4miLmkBbzVetqWPZ4rMJV8+eKDitGC1DMDYQgvZBYiho3X3K7
         xoMC846oSq1AnAsPUmTEjih3ty+t+A0h4YHrTv6Z4nneosTusWfyQQwOZYvPOKOsmUlf
         CA3uAdT+JnZSPDwKZRKD3YlWXYB5nCzqUfcMQHuE+mX9VwKlniqbaoTyk+7gT8G1FM1l
         X/bSz5pQJQ/ky5iGlbnZuWEUdUEWZiMj3SuGHnVEe4t+BJltG+eoMfdVOGO0xbJd4Y1/
         2zKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712896945; x=1713501745;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CNKCkNsot/Do8CE0Y5PRYhfWnEd0oPU98R4yomeMOBg=;
        b=g6GKr8V2I3T4knZLwW2oE9kwjkIJ9w5K0Vo4IGJpQEvIoEk8xS61GwlDU1xEyHhxwY
         NyYP9BXsC6+HPhyUMsnYTeOKPgpLYofnWD0+GJfhty/eu78s8bXgU7EfiH0lzaAY67tu
         vegAKs5weX3v14PV1gYxIkmkDtrNKCVCEMo2SBKJvJw+ivMxJcwd9D29r9PYkqBmmfnR
         EHiKDaco+j6x9kJAD7GvUbeef1GXaGvq/I8iSGUNDQeVewytzIKTmzDzVW1CGJZ6ZNPQ
         k+AMBppR10MkxtZ7bc6bCdY0RST84nqnJ4w8NbV9Y163JZGyTIn7FDUiXF1pwjRCHuAZ
         xS4A==
X-Forwarded-Encrypted: i=1; AJvYcCXlXzw9RA+ihzlPHM75gaNSuMmImn/J68Zm+Jpnw60BtF0RaweUQvp1/TgPuzgFqAIMxqKO3N8LytvGrCJhMsmaJ6ClczwoD68jYLX733e9
X-Gm-Message-State: AOJu0YyHisgEf7N2VHMOLsfjn3tlwdITYV0ZJKojdRgiv4bRQBKxP3Pz
	R69uyok1f8dV9CRc5fnkVWHrQCZYOXVFxUPWmwNhq4SyP2Ph8F5/6vs+k9VoOc2Of/wAfQJhfYl
	bwb+7OFk++oNQj4eUh83S6A==
X-Google-Smtp-Source: AGHT+IEsfuiZZhvEJhEk4hpJZ3tcDHr2XUVgWTfEcekqoXuE6gxc30NQGBAMRLukncKNx2Memz3jUMFF4Ph6YCHTNA==
X-Received: from ctop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:1223])
 (user=ackerleytng job=sendgmr) by 2002:a05:6902:150d:b0:dc6:cafd:dce5 with
 SMTP id q13-20020a056902150d00b00dc6cafddce5mr477459ybu.12.1712896945446;
 Thu, 11 Apr 2024 21:42:25 -0700 (PDT)
Date: Fri, 12 Apr 2024 04:42:21 +0000
In-Reply-To: <75fde3c3-17a1-466f-a920-30769730808c@intel.com> (dongsheng.x.zhang@intel.com)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <diqzzftzjioi.fsf@ctop-sg.c.googlers.com>
Subject: Re: [RFC PATCH v5 08/29] KVM: selftests: TDX: Add TDX lifecycle test
From: Ackerley Tng <ackerleytng@google.com>
To: dongsheng.x.zhang@intel.com
Cc: sagis@google.com, linux-kselftest@vger.kernel.org, afranji@google.com, 
	erdemaktas@google.com, isaku.yamahata@intel.com, seanjc@google.com, 
	pbonzini@redhat.com, shuah@kernel.org, pgonda@google.com, haibo1.xu@intel.com, 
	chao.p.peng@linux.intel.com, vannapurve@google.com, runanwang@google.com, 
	vipinsh@google.com, jmattson@google.com, dmatlack@google.com, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

"Zhang, Dongsheng X" <dongsheng.x.zhang@intel.com> writes:

> On 12/12/2023 12:46 PM, Sagi Shahar wrote:
>> From: Erdem Aktas <erdemaktas@google.com>
>> 
>> Adding a test to verify TDX lifecycle by creating a TD and running a
>> dummy TDG.VP.VMCALL <Instruction.IO> inside it.
>> 
>> Signed-off-by: Erdem Aktas <erdemaktas@google.com>
>> Signed-off-by: Ryan Afranji <afranji@google.com>
>> Signed-off-by: Sagi Shahar <sagis@google.com>
>> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> ---
>>  tools/testing/selftests/kvm/Makefile          |  4 +
>>  .../selftests/kvm/include/x86_64/tdx/tdcall.h | 35 ++++++++
>>  .../selftests/kvm/include/x86_64/tdx/tdx.h    | 12 +++
>>  .../kvm/include/x86_64/tdx/test_util.h        | 52 +++++++++++
>>  .../selftests/kvm/lib/x86_64/tdx/tdcall.S     | 90 +++++++++++++++++++
>>  .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 27 ++++++
>>  .../selftests/kvm/lib/x86_64/tdx/tdx_util.c   |  1 +
>>  .../selftests/kvm/lib/x86_64/tdx/test_util.c  | 34 +++++++
>>  .../selftests/kvm/x86_64/tdx_vm_tests.c       | 45 ++++++++++
>>  9 files changed, 300 insertions(+)
>>  create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
>>  create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
>>  create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
>>  create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx/tdcall.S
>>  create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
>>  create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
>>  create mode 100644 tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
>> 
>> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
>> index a35150ab855f..80d4a50eeb9f 100644
>> --- a/tools/testing/selftests/kvm/Makefile
>> +++ b/tools/testing/selftests/kvm/Makefile
>> @@ -52,6 +52,9 @@ LIBKVM_x86_64 += lib/x86_64/vmx.c
>>  LIBKVM_x86_64 += lib/x86_64/sev.c
>>  LIBKVM_x86_64 += lib/x86_64/tdx/tdx_util.c
>>  LIBKVM_x86_64 += lib/x86_64/tdx/td_boot.S
>> +LIBKVM_x86_64 += lib/x86_64/tdx/tdcall.S
>> +LIBKVM_x86_64 += lib/x86_64/tdx/tdx.c
>> +LIBKVM_x86_64 += lib/x86_64/tdx/test_util.c
>>  
>>  LIBKVM_aarch64 += lib/aarch64/gic.c
>>  LIBKVM_aarch64 += lib/aarch64/gic_v3.c
>> @@ -152,6 +155,7 @@ TEST_GEN_PROGS_x86_64 += set_memory_region_test
>>  TEST_GEN_PROGS_x86_64 += steal_time
>>  TEST_GEN_PROGS_x86_64 += kvm_binary_stats_test
>>  TEST_GEN_PROGS_x86_64 += system_counter_offset_test
>> +TEST_GEN_PROGS_x86_64 += x86_64/tdx_vm_tests
>>  
>>  # Compiled outputs used by test targets
>>  TEST_GEN_PROGS_EXTENDED_x86_64 += x86_64/nx_huge_pages_test
>> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
>> new file mode 100644
>> index 000000000000..78001bfec9c8
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
>> @@ -0,0 +1,35 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/* Adapted from arch/x86/include/asm/shared/tdx.h */
>> +
>> +#ifndef SELFTESTS_TDX_TDCALL_H
>> +#define SELFTESTS_TDX_TDCALL_H
>> +
>> +#include <linux/bits.h>
>> +#include <linux/types.h>
>> +
>> +#define TDG_VP_VMCALL_INSTRUCTION_IO_READ 0
>> +#define TDG_VP_VMCALL_INSTRUCTION_IO_WRITE 1
>
> Nit:
> Probably we can define the following instead in test_util.c?
> /* Port I/O direction */
> #define PORT_READ	0
> #define PORT_WRITE	1
>
> Then use them in place of TDG_VP_VMCALL_INSTRUCTION_IO_READ/TDG_VP_VMCALL_INSTRUCTION_IO_WRITE?
> which are too long
>

I was actually thinking to align all the macro definitions with the
definitions in the Intel GHCI Spec, so

3.9 TDG.VP.VMCALL<Instruction.IO>

becomes TDG_VP_VMCALL_INSTRUCTION_IO and then add suffixes READ and
WRITE for the directions.

PORT_READ and PORT_WRITE seem a little too unspecific, but I agree that
TDG_VP_VMCALL_INSTRUCTION_IO_READ/TDG_VP_VMCALL_INSTRUCTION_IO_WRITE are
long.

>> +
>> +#define TDX_HCALL_HAS_OUTPUT BIT(0)
>> +
>> +#define TDX_HYPERCALL_STANDARD 0
>> +
>> +/*
>> + * Used in __tdx_hypercall() to pass down and get back registers' values of
>> + * the TDCALL instruction when requesting services from the VMM.
>> + *
>> + * This is a software only structure and not part of the TDX module/VMM ABI.
>> + */
>> +struct tdx_hypercall_args {
>> +	u64 r10;
>> +	u64 r11;
>> +	u64 r12;
>> +	u64 r13;
>> +	u64 r14;
>> +	u64 r15;
>> +};
>> +
>> +/* Used to request services from the VMM */
>> +u64 __tdx_hypercall(struct tdx_hypercall_args *args, unsigned long flags);
>> +
>> +#endif // SELFTESTS_TDX_TDCALL_H
>> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
>> new file mode 100644
>> index 000000000000..a7161efe4ee2
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
>> @@ -0,0 +1,12 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +#ifndef SELFTEST_TDX_TDX_H
>> +#define SELFTEST_TDX_TDX_H
>> +
>> +#include <stdint.h>
>> +
>> +#define TDG_VP_VMCALL_INSTRUCTION_IO 30
>
> Nit:
> arch/x86/include/uapi/asm/vmx.h already exports the following define:
> #define EXIT_REASON_IO_INSTRUCTION      30
>
> Linux kernel example (arch/x86/coco/tdx/tdx.c):
> static bool handle_in(struct pt_regs *regs, int size, int port)
> {
> 	struct tdx_module_args args = {
> 		.r10 = TDX_HYPERCALL_STANDARD,
> 		.r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
> 		.r12 = size,
> 		.r13 = PORT_READ,
> 		.r14 = port,
> 	};
>
> So just like the kernel, here we can also use EXIT_REASON_IO_INSTRUCTION in place of TDG_VP_VMCALL_INSTRUCTION_IO,
> just need to do a '#include "vmx.h"' or '#include <asm/vmx.h>' to bring in the define
>

I think aligning macro definitions with the spec is better in this case.

It seems odd to be calling an EXIT_REASON_* when making a hypercall.

Later on in this patch series this macro is added

#define TDG_VP_VMCALL_VE_REQUEST_MMIO 48

which matches

3.7 TDG.VP.VMCALL<#VE.RequestMMIO>

in the Intel GHCI Spec.

The equivalent EXIT_REASON is EXIT_REASON_EPT_VIOLATION, which I feel
doesn't carry the same meaning as an explicit request for MMIO, as in
TDG_VP_VMCALL_VE_REQUEST_MMIO.

So I think even though the numbers are the same, they don't carry the
same meaning and it's probably better to have different macro
definitions.

Or we could define one in terms of the other?

Later on in this patch series other macros are also added, specific to TDX

#define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
#define TDG_VP_VMCALL_MAP_GPA 0x10001
#define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003

which matches

3.1 TDG.VP.VMCALL<GetTdVmCallInfo>
3.2 TDG.VP.VMCALL<MapGPA>
3.4 TDG.VP.VMCALL<ReportFatalError>

in the Intel GHCI Spec.

It's nice to have the naming convention for all the VMCALLs line up. :)

>> +
>> +uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
>> +				      uint64_t write, uint64_t *data);
>> +

>> <snip>

>> +void verify_td_lifecycle(void)
>> +{
>> +	struct kvm_vm *vm;
>> +	struct kvm_vcpu *vcpu;
>> +
>> +	vm = td_create();
>> +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
>> +	vcpu = td_vcpu_add(vm, 0, guest_code_lifecycle);
>> +	td_finalize(vm);
>> +
>> +	printf("Verifying TD lifecycle:\n");
>> +
>> +	vcpu_run(vcpu);
>> +	TDX_TEST_ASSERT_SUCCESS(vcpu);
>> +
>> +	kvm_vm_free(vm);
>> +	printf("\t ... PASSED\n");
>> +}
>
> Nit:
> All the functions used locally inside tdx_vm_tests.c can be declared static:
> static void guest_code_lifecycle(void)
> static void verify_td_lifecycle(void)
>

Will fix this, thanks!

>> +
>> +int main(int argc, char **argv)
>> +{
>> +	setbuf(stdout, NULL);
>> +
>> +	if (!is_tdx_enabled()) {
>> +		print_skip("TDX is not supported by the KVM");
>> +		exit(KSFT_SKIP);
>> +	}
>> +
>> +	run_in_new_process(&verify_td_lifecycle);
>> +
>> +	return 0;
>> +}

