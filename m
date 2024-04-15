Return-Path: <linux-kselftest+bounces-8017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10728A5A0C
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 20:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3EBD1C21394
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 18:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7408154C02;
	Mon, 15 Apr 2024 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ucqIFa0t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCEA41C66;
	Mon, 15 Apr 2024 18:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206570; cv=none; b=qaeWVvVDLuY8tnQpeobmj+TDnJvQCeVBmX3bY2jzZnpHY/YskReWqF7LiwI6H3bk9RbcWnGfnyC5umH/a3rC2pM1LBLQ8j/ulWpDFv3Kr37jk8htxUGquS4xKtw40gNvecP0+iukPWfocSJYf2l1u9Cu8cpToI6EVo4erMs0a6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206570; c=relaxed/simple;
	bh=IjnSz6OW1vPT7zQMhXp9CbsJXZWFt6w7U/Qun/1PHrA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NBdv41q1mlw1NMd+0GDGPN9+Pr2sY7DLmYGcklaIE0yhH0mxNzLdpXjHu6+qhCBQhB0TFqu+l/XXRYNLbroWl2B/sF+tW0iLWmg1Wdof+tMHUtiHivi0dEBGoBWQf7K/vR+UeWwVEMA3SO2AEfq1pFqV8pGlEBJHxWVloxfI3jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ucqIFa0t; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713206567;
	bh=IjnSz6OW1vPT7zQMhXp9CbsJXZWFt6w7U/Qun/1PHrA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ucqIFa0tTWBqpw2QRVk9kCxVuozZPdH/sNsVDZDLocTt+JyyRCnKX1rdCfByx5Fpl
	 8xr4dP8NTAvYcp+0bj914Umdo4UbommbkWOy+xaxx0gGUbd53qQoYAbBDsqlycPA2Y
	 Io+GmqztzhQWnlDcH4zA3YIwXjexrG/n6uAj+xOuShc6h4AyfVojuZhbpDPPwtX7qS
	 XPwsZcAGODt78AtmF6pX48sq/b88Z+zo+cNyRiJFUWVXE1jEt5A/gkWAJmBXtnfijr
	 bCS9q3ri1qR9/pubWVEj9WlbzrpkhKmwI1vZLSrXdDc7Sj7A4me0XRr12QVa1QJskW
	 4nDEunYwS2+Zg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 56E6637810F1;
	Mon, 15 Apr 2024 18:42:44 +0000 (UTC)
Message-ID: <bbbdc88a-9cf6-4ded-acbd-7f733794dbfe@collabora.com>
Date: Mon, 15 Apr 2024 23:43:17 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v1] KVM: s390x: selftests: Add shared zeropage test
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
References: <20240412084329.30315-1-david@redhat.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240412084329.30315-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/12/24 1:43 PM, David Hildenbrand wrote:
> Let's test that we can have shared zeropages in our process as long as
> storage keys are not getting used, that shared zeropages are properly
> unshared (replaced by anonymous pages) once storage keys are enabled,
> and that no new shared zeropages are populated after storage keys
> were enabled.
> 
> We require the new pagemap interface to detect the shared zeropage.
> 
> On an old kernel (zeropages always disabled):
> 	# ./s390x/shared_zeropage_test
> 	TAP version 13
> 	1..3
> 	not ok 1 Shared zeropages should be enabled
> 	ok 2 Shared zeropage should be gone
> 	ok 3 Shared zeropages should be disabled
> 	# Totals: pass:2 fail:1 xfail:0 xpass:0 skip:0 error:0
> 
> On a fixed kernel:
> 	# ./s390x/shared_zeropage_test
> 	TAP version 13
> 	1..3
> 	ok 1 Shared zeropages should be enabled
> 	ok 2 Shared zeropage should be gone
> 	ok 3 Shared zeropages should be disabled
> 	# Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Testing of UFFDIO_ZEROPAGE can be added later.
> 
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Janosch Frank <frankja@linux.ibm.com>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
Acked-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
> 
> To get it right this time, test the relevant cases.
> 
> v3 of fixes are at:
>  https://lore.kernel.org/all/20240411161441.910170-1-david@redhat.com/T/#u
> 
> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../kvm/s390x/shared_zeropage_test.c          | 110 ++++++++++++++++++
>  2 files changed, 111 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/s390x/shared_zeropage_test.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 741c7dc16afc..ed4ad591f193 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -180,6 +180,7 @@ TEST_GEN_PROGS_s390x += s390x/sync_regs_test
>  TEST_GEN_PROGS_s390x += s390x/tprot
>  TEST_GEN_PROGS_s390x += s390x/cmma_test
>  TEST_GEN_PROGS_s390x += s390x/debug_test
> +TEST_GEN_PROGS_s390x += s390x/shared_zeropage_test
>  TEST_GEN_PROGS_s390x += demand_paging_test
>  TEST_GEN_PROGS_s390x += dirty_log_test
>  TEST_GEN_PROGS_s390x += guest_print_test
> diff --git a/tools/testing/selftests/kvm/s390x/shared_zeropage_test.c b/tools/testing/selftests/kvm/s390x/shared_zeropage_test.c
> new file mode 100644
> index 000000000000..74e829748fb1
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/s390x/shared_zeropage_test.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Test shared zeropage handling (with/without storage keys)
> + *
> + * Copyright (C) 2024, Red Hat, Inc.
> + */
> +#include <sys/mman.h>
> +
> +#include <linux/fs.h>
> +
> +#include "test_util.h"
> +#include "kvm_util.h"
> +#include "kselftest.h"
> +
> +static void set_storage_key(void *addr, uint8_t skey)
> +{
> +	asm volatile("sske %0,%1" : : "d" (skey), "a" (addr));
> +}
> +
> +static void guest_code(void)
> +{
> +	/* Issue some storage key instruction. */
> +	set_storage_key((void *)0, 0x98);
> +	GUEST_DONE();
> +}
> +
> +/*
> + * Returns 1 if the shared zeropage is mapped, 0 if something else is mapped.
> + * Returns < 0 on error or if nothing is mapped.
> + */
> +static int maps_shared_zeropage(int pagemap_fd, void *addr)
> +{
> +	struct page_region region;
> +	struct pm_scan_arg arg = {
> +		.start = (uintptr_t)addr,
> +		.end = (uintptr_t)addr + 4096,
> +		.vec = (uintptr_t)&region,
> +		.vec_len = 1,
> +		.size = sizeof(struct pm_scan_arg),
> +		.category_mask = PAGE_IS_PFNZERO,
> +		.category_anyof_mask = PAGE_IS_PRESENT,
> +		.return_mask = PAGE_IS_PFNZERO,
> +	};
> +	return ioctl(pagemap_fd, PAGEMAP_SCAN, &arg);Its good to see more users for it.

> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	char *mem, *page0, *page1, *page2, tmp;
> +	const size_t pagesize = getpagesize();
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	struct ucall uc;
> +	int pagemap_fd;
> +
> +	ksft_print_header();
> +	ksft_set_plan(3);
> +
> +	/*
> +	 * We'll use memory that is not mapped into the VM for simplicity.
> +	 * Shared zeropages are enabled/disabled per-process.
> +	 */
> +	mem = mmap(0, 3 * pagesize, PROT_READ, MAP_PRIVATE|MAP_ANON, -1, 0);
> +	TEST_ASSERT(mem != MAP_FAILED, "mmap() failed");
> +
> +	/* Disable THP. Ignore errors on older kernels. */
> +	madvise(mem, 3 * pagesize, MADV_NOHUGEPAGE);
> +
> +	page0 = mem;
> +	page1 = page0 + pagesize;
> +	page2 = page1 + pagesize;
> +
> +	/* Can we even detect shared zeropages? */
> +	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
> +	TEST_REQUIRE(pagemap_fd >= 0);
> +
> +	tmp = *page0;
> +	asm volatile("" : "+r" (tmp));
> +	TEST_REQUIRE(maps_shared_zeropage(pagemap_fd, page0) == 1);
> +
> +	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
> +
> +	/* Verify that we get the shared zeropage after VM creation. */
> +	tmp = *page1;
> +	asm volatile("" : "+r" (tmp));
> +	ksft_test_result(maps_shared_zeropage(pagemap_fd, page1) == 1,
> +			 "Shared zeropages should be enabled\n");
> +
> +	/*
> +	 * Let our VM execute a storage key instruction that should
> +	 * unshare all shared zeropages.
> +	 */
> +	vcpu_run(vcpu);
> +	get_ucall(vcpu, &uc);
> +	TEST_ASSERT_EQ(uc.cmd, UCALL_DONE);
> +
> +	/* Verify that we don't have a shared zeropage anymore. */
> +	ksft_test_result(!maps_shared_zeropage(pagemap_fd, page1),
> +			 "Shared zeropage should be gone\n");
> +
> +	/* Verify that we don't get any new shared zeropages. */
> +	tmp = *page2;
> +	asm volatile("" : "+r" (tmp));
> +	ksft_test_result(!maps_shared_zeropage(pagemap_fd, page2),
> +			 "Shared zeropages should be disabled\n");
> +
> +	kvm_vm_free(vm);
> +
> +	ksft_finished();
> +}

-- 
BR,
Muhammad Usama Anjum

