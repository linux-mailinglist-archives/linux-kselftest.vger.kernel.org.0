Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEC647A359
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Dec 2021 02:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbhLTBtU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 19 Dec 2021 20:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbhLTBtU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 19 Dec 2021 20:49:20 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF984C06173E
        for <linux-kselftest@vger.kernel.org>; Sun, 19 Dec 2021 17:49:19 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id x1-20020a17090a2b0100b001b103e48cfaso7758524pjc.0
        for <linux-kselftest@vger.kernel.org>; Sun, 19 Dec 2021 17:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hQFA7Ij855EVoB0UKJms5vbfe/w+xK5vbniMZ6ftKKg=;
        b=iVA9q+uLo0kGTuqQCvRYNVX/GllVBrQ64vNb23YOFjksuCNLAW0xNDtktl7kzlhQVZ
         Wi2UvwZXsU98ZFYxj8qibERksONxgUXittKx5GWK2RAZ5h/mdfS+okgLs2i30QsIoxls
         97ePtq4v8qBEFQ83Ujm9/FPBe7Xg4ldzWWeX7IVE/Sld++krk6GqHz+Id+qpY3Bj/p8B
         xPjwMNSfR6muOK417oV8L8BNqCSwY2iPM72SDAcqIAe/LMVeZY1eTYH8FBUTe08588/9
         0Kongiu66B2orqVyf39FKtZhMYmIWfbR9NXGN3YxZhUaDM9c27wVJz21Ytc/Vwm0Pbpu
         k6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hQFA7Ij855EVoB0UKJms5vbfe/w+xK5vbniMZ6ftKKg=;
        b=c/0KvTqUI1Axs3QNnM6FcE7liKjxhn6dq6eN4CvzC5Wr8jlaY/AWHLx8OQbsDv/LoQ
         dPVotkYN79prNuv3laWcMPqA5HYRKNK31+UERv4P6poKUMuwoCYG9QpWsPucXMrKFTSH
         etvXwgc+42+BDPezfpi6eHBeNRLv4ms2z7Vu2TdHzQlCHF/UKIg9HoGu74WU8VMI/oiV
         4f6L3S1LLuoUg5mYJxHnUK/WUbIt4yIbxS3YvDB+ZJuT1VUVhhK+iAEgS1OiWa61KOzQ
         v65+/6M17t6mzUfrySuDLQr77IoLEdHMVrNbepzdRX4f0nAw/keMS/9t7MPTSpui7O2x
         wPgw==
X-Gm-Message-State: AOAM530ZIzIij4VCg6wyD+501rj6MTFInqGyeoYgbNra0P9lTyLaL1/i
        vl3OuPXnD1+mBW0lXOcuCmtnbA==
X-Google-Smtp-Source: ABdhPJwwK8ZFmksHtJ2tJ6fblsBKSvyuhh5KlxNFHsSlvs8sFJclxhzAFOUkonquJwLZQkKLGb/1bQ==
X-Received: by 2002:a17:902:bd85:b0:148:ba0a:528a with SMTP id q5-20020a170902bd8500b00148ba0a528amr14295168pls.169.1639964959050;
        Sun, 19 Dec 2021 17:49:19 -0800 (PST)
Received: from google.com (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with ESMTPSA id on2sm3248488pjb.19.2021.12.19.17.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 17:49:18 -0800 (PST)
Date:   Mon, 20 Dec 2021 01:49:15 +0000
From:   Mingwei Zhang <mizhang@google.com>
To:     Michael Roth <michael.roth@amd.com>
Cc:     linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Peter Gonda <pgonda@google.com>
Subject: Re: [PATCH v2 08/13] KVM: selftests: add SEV boot tests
Message-ID: <Yb/hGzeiRi0AwfV6@google.com>
References: <20211216171358.61140-1-michael.roth@amd.com>
 <20211216171358.61140-9-michael.roth@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216171358.61140-9-michael.roth@amd.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 16, 2021, Michael Roth wrote:
> A common aspect of booting SEV guests is checking related CPUID/MSR
> bits and accessing shared/private memory. Add a basic test to cover
> this.
>
> This test will be expanded to cover basic boot of SEV-ES and SEV-SNP in
> subsequent patches.
>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  tools/testing/selftests/kvm/.gitignore        |   1 +
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/x86_64/sev_all_boot_test.c  | 255 ++++++++++++++++++
>  3 files changed, 257 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
>
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index 4a801cba9c62..cc73de938a2a 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -43,6 +43,7 @@
>  /x86_64/xen_vmcall_test
>  /x86_64/xss_msr_test
>  /x86_64/vmx_pmu_msrs_test
> +/x86_64/sev_all_boot_test
>  /access_tracking_perf_test
>  /demand_paging_test
>  /dirty_log_test
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index ccc382a827f1..6f250e190fde 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -81,6 +81,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/xen_shinfo_test
>  TEST_GEN_PROGS_x86_64 += x86_64/xen_vmcall_test
>  TEST_GEN_PROGS_x86_64 += x86_64/vmx_pi_mmio_test
>  TEST_GEN_PROGS_x86_64 += x86_64/sev_migrate_tests
> +TEST_GEN_PROGS_x86_64 += x86_64/sev_all_boot_test
>  TEST_GEN_PROGS_x86_64 += demand_paging_test
>  TEST_GEN_PROGS_x86_64 += dirty_log_test
>  TEST_GEN_PROGS_x86_64 += dirty_log_perf_test
> diff --git a/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c b/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
> new file mode 100644
> index 000000000000..329a740a7cb2
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
> @@ -0,0 +1,255 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Basic SEV boot tests.
> + *
> + * Copyright (C) 2021 Advanced Micro Devices
> + */
> +#define _GNU_SOURCE /* for program_invocation_short_name */
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +
> +#include "test_util.h"
> +
> +#include "kvm_util.h"
> +#include "processor.h"
> +#include "svm_util.h"
> +#include "linux/psp-sev.h"
> +#include "sev.h"
> +
> +#define VCPU_ID			2
> +#define PAGE_SIZE		4096
> +#define PAGE_STRIDE		32
> +
> +#define SHARED_PAGES		8192
> +#define SHARED_VADDR_MIN	0x1000000
> +
> +#define PRIVATE_PAGES		2048
> +#define PRIVATE_VADDR_MIN	(SHARED_VADDR_MIN + SHARED_PAGES * PAGE_SIZE)
> +
> +#define TOTAL_PAGES		(512 + SHARED_PAGES + PRIVATE_PAGES)
> +
> +static void fill_buf(uint8_t *buf, size_t pages, size_t stride, uint8_t val)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < pages; i++)
> +		for (j = 0; j < PAGE_SIZE; j += stride)
> +			buf[i * PAGE_SIZE + j] = val;
> +}
> +
> +static bool check_buf(uint8_t *buf, size_t pages, size_t stride, uint8_t val)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < pages; i++)
> +		for (j = 0; j < PAGE_SIZE; j += stride)
> +			if (buf[i * PAGE_SIZE + j] != val)
> +				return false;
> +
> +	return true;
> +}
> +
> +static void guest_test_start(struct ucall *uc)
> +{
> +	/* Initial guest check-in. */
> +	GUEST_SHARED_SYNC(uc, 1);
> +}
> +
> +static void test_start(struct kvm_vm *vm, struct ucall *uc)
> +{
> +	vcpu_run(vm, VCPU_ID);
> +
> +	/* Initial guest check-in. */
> +	CHECK_SHARED_SYNC(vm, VCPU_ID, uc, 1);
> +}
> +
> +static void
> +guest_test_common(struct ucall *uc, uint8_t *shared_buf, uint8_t *private_buf)
> +{
> +	bool success;
> +
> +	/* Initial check-in for common. */
> +	GUEST_SHARED_SYNC(uc, 100);

Probably, you want to use macros to represent those states which should
make it more clear. Otherwise, it is quite cumbersome for readers to
remember the meaning (or state) of 100/101/102.
> +
> +	/* Ensure initial shared pages are intact. */
> +	success = check_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x41);
> +	GUEST_SHARED_ASSERT(uc, success);
> +
> +	/* Ensure initial private pages are intact/encrypted. */
> +	success = check_buf(private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x42);
> +	GUEST_SHARED_ASSERT(uc, success);
> +
> +	/* Ensure host userspace can't read newly-written encrypted data. */
> +	fill_buf(private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x43);
> +
> +	GUEST_SHARED_SYNC(uc, 101);

ditto.
> +
> +	/* Ensure guest can read newly-written shared data from host. */
> +	success = check_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x44);
> +	GUEST_SHARED_ASSERT(uc, success);
> +
> +	/* Ensure host can read newly-written shared data from guest. */
> +	fill_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x45);
> +
> +	GUEST_SHARED_SYNC(uc, 102);

ditto.
> +}
> +
> +static void
> +test_common(struct kvm_vm *vm, struct ucall *uc,
> +		  uint8_t *shared_buf, uint8_t *private_buf)
> +{
> +	bool success;
> +
> +	/* Initial guest check-in. */
> +	vcpu_run(vm, VCPU_ID);
> +	CHECK_SHARED_SYNC(vm, VCPU_ID, uc, 100);
> +
> +	/* Ensure initial private pages are intact/encrypted. */
> +	success = check_buf(private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x42);
> +	TEST_ASSERT(!success, "Initial guest memory not encrypted!");
> +
> +	vcpu_run(vm, VCPU_ID);
> +	CHECK_SHARED_SYNC(vm, VCPU_ID, uc, 101);
> +
> +	/* Ensure host userspace can't read newly-written encrypted data. */
> +	success = check_buf(private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x43);

I am not sure if it is safe here. Since the cache coherency is not there
for neither SEV or SEV-ES. Reading confidential memory from host side
will generate cache lines that is not coherent with the guest. So might
be better to add clfush here?

> +	TEST_ASSERT(!success, "Modified guest memory not encrypted!");
> +
> +	/* Ensure guest can read newly-written shared data from host. */
> +	fill_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x44);
> +
> +	vcpu_run(vm, VCPU_ID);
> +	CHECK_SHARED_SYNC(vm, VCPU_ID, uc, 102);
> +
> +	/* Ensure host can read newly-written shared data from guest. */
> +	success = check_buf(shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x45);
> +	TEST_ASSERT(success, "Host can't read shared guest memory!");
> +}
> +
> +static void
> +guest_test_done(struct ucall *uc)
> +{
> +	GUEST_SHARED_DONE(uc);
> +}
> +
> +static void
> +test_done(struct kvm_vm *vm, struct ucall *uc)
> +{
> +	vcpu_run(vm, VCPU_ID);
> +	CHECK_SHARED_DONE(vm, VCPU_ID, uc);
> +}
> +
> +static void __attribute__((__flatten__))
> +guest_sev_code(struct ucall *uc, uint8_t *shared_buf, uint8_t *private_buf)
> +{
> +	uint32_t eax, ebx, ecx, edx;
> +	uint64_t sev_status;
> +
> +	guest_test_start(uc);
> +
> +	/* Check SEV CPUID bit. */
> +	eax = 0x8000001f;
> +	ecx = 0;
> +	cpuid(&eax, &ebx, &ecx, &edx);
> +	GUEST_SHARED_ASSERT(uc, eax & (1 << 1));
> +
> +	/* Check SEV MSR bit. */
> +	sev_status = rdmsr(MSR_AMD64_SEV);
> +	GUEST_SHARED_ASSERT(uc, (sev_status & 0x1) == 1);
> +
> +	guest_test_common(uc, shared_buf, private_buf);
> +
> +	guest_test_done(uc);
> +}
> +
> +static struct sev_vm *
> +setup_test_common(void *guest_code, uint64_t policy, struct ucall **uc,
> +		  uint8_t **shared_buf, uint8_t **private_buf)
> +{
> +	vm_vaddr_t uc_vaddr, shared_vaddr, private_vaddr;
> +	uint8_t measurement[512];
> +	struct sev_vm *sev;
> +	struct kvm_vm *vm;
> +	int i;
> +
> +	sev = sev_vm_create(policy, TOTAL_PAGES);
> +	if (!sev)
> +		return NULL;
> +	vm = sev_get_vm(sev);
> +
> +	/* Set up VCPU and initial guest kernel. */
> +	vm_vcpu_add_default(vm, VCPU_ID, guest_code);
> +	kvm_vm_elf_load(vm, program_invocation_name);
> +
> +	/* Set up shared ucall buffer. */
> +	uc_vaddr = ucall_shared_alloc(vm, 1);
> +
> +	/* Set up buffer for reserved shared memory. */
> +	shared_vaddr = vm_vaddr_alloc_shared(vm, SHARED_PAGES * PAGE_SIZE,
> +					     SHARED_VADDR_MIN);
> +	*shared_buf = addr_gva2hva(vm, shared_vaddr);
> +	fill_buf(*shared_buf, SHARED_PAGES, PAGE_STRIDE, 0x41);
> +
> +	/* Set up buffer for reserved private memory. */
> +	private_vaddr = vm_vaddr_alloc(vm, PRIVATE_PAGES * PAGE_SIZE,
> +				       PRIVATE_VADDR_MIN);
> +	*private_buf = addr_gva2hva(vm, private_vaddr);
> +	fill_buf(*private_buf, PRIVATE_PAGES, PAGE_STRIDE, 0x42);
> +
> +	/* Set up guest params. */
> +	vcpu_args_set(vm, VCPU_ID, 4, uc_vaddr, shared_vaddr, private_vaddr);
> +
> +	/*
> +	 * Hand these back to test harness, translation is needed now since page
> +	 * table will be encrypted after SEV VM launch.
> +	 */
> +	*uc = addr_gva2hva(vm, uc_vaddr);
> +	*shared_buf = addr_gva2hva(vm, shared_vaddr);
> +	*private_buf = addr_gva2hva(vm, private_vaddr);
> +
> +	/* Allocations/setup done. Encrypt initial guest payload. */
> +	sev_vm_launch(sev);
> +
> +	/* Dump the initial measurement. A test to actually verify it would be nice. */
> +	sev_vm_launch_measure(sev, measurement);
> +	pr_info("guest measurement: ");
> +	for (i = 0; i < 32; ++i)
> +		pr_info("%02x", measurement[i]);
> +	pr_info("\n");
> +
> +	sev_vm_launch_finish(sev);
> +
> +	return sev;
> +}
> +
> +static void test_sev(void *guest_code, uint64_t policy)
> +{
> +	uint8_t *shared_buf, *private_buf;
> +	struct sev_vm *sev;
> +	struct kvm_vm *vm;
> +	struct ucall *uc;
> +
> +	sev = setup_test_common(guest_code, policy, &uc, &shared_buf, &private_buf);
> +	if (!sev)
> +		return;
> +	vm = sev_get_vm(sev);
> +
> +	/* Guest is ready to run. Do the tests. */
> +	test_start(vm, uc);
> +	test_common(vm, uc, shared_buf, private_buf);
> +	test_done(vm, uc);
> +
> +	sev_vm_free(sev);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	/* SEV tests */
> +	test_sev(guest_sev_code, SEV_POLICY_NO_DBG);
> +	test_sev(guest_sev_code, 0);
> +
> +	return 0;
> +}
> --
> 2.25.1
>
