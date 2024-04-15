Return-Path: <linux-kselftest+bounces-8013-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A238A59F0
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 20:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5A51F214A5
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 18:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCBF154432;
	Mon, 15 Apr 2024 18:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XJAvGcDq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1F6153BF8;
	Mon, 15 Apr 2024 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713205938; cv=none; b=UqbHviE4gaeZRESii6o9CDEo38m/4gd1tIHJzpQDab58l6oR5sVs0s39WJep96vwNf7KRtPiOxjmPWzqNqibQV0OdlEFbBJohExjCVgk3B1pBKH2rWgkbUvsx9M7UtDo0HTBPnG7NL0iiCzW5uqHxPMFdbRCpp/U/dIwigcNVWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713205938; c=relaxed/simple;
	bh=p8eY082JkC3KPLbfUGfr481x8SEdz/YLHgqGEpwKKdg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ixAOZ7jSpCoWPk5LyE3PGkoufqhZEWgpiEgPlVjQEouqMD7QmVaCY42vPRgPW5GyaI5j7WUwseTxZhECnAtUSbRgZ/Y8W43FPOZQcQB1SToXJnwZVBjBAMZhWk1pPAZrV0a82Ye9TImamiSfi1FBQfN1t71ZDmN7boa0VSIYzLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XJAvGcDq; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713205934;
	bh=p8eY082JkC3KPLbfUGfr481x8SEdz/YLHgqGEpwKKdg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=XJAvGcDqP0Vt+/a6ZRFb0h5+g8hgOaGIveEs1cMbQRBl/HGMq09mRCyIdSRVXp2t+
	 ENn77R12rxPJQ/Lb1mz+StEHb9MNSEq/dKH8XjzyPhuTDEGURTxML/th7/UrMJpv5N
	 jX4BXGtF7O9UOaonMufXeo96KpZwpGcA3tOBMX12eh98k/mNS1T+0kPZJX6BZlwUSm
	 xNqyrnvQBvgej7aS79D0qvlyIUIA0umXkTxHgOdPVb0Ml2RJwPYZhQnWt0ubIwFPw4
	 olR+R5Fozy0rTDurjH2xfpAJCea2xY20ILGEmSZJekpk/oLkal5DidGr4FkWHItcMZ
	 R0Mq7SKaJherw==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 73D9937810F1;
	Mon, 15 Apr 2024 18:32:09 +0000 (UTC)
Message-ID: <e1744539-a843-468a-9101-ce7a08669394@collabora.com>
Date: Mon, 15 Apr 2024 23:32:41 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, jeffxu@google.com,
 jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 pedro.falcato@gmail.com, dave.hansen@intel.com,
 linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [PATCH v10 3/5] selftest mm/mseal memory sealing
To: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org,
 jannh@google.com, sroettger@google.com, willy@infradead.org,
 gregkh@linuxfoundation.org, torvalds@linux-foundation.org, corbet@lwn.net,
 Liam.Howlett@oracle.com, surenb@google.com, merimus@google.com,
 rdunlap@infradead.org
References: <20240415163527.626541-1-jeffxu@chromium.org>
 <20240415163527.626541-4-jeffxu@chromium.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240415163527.626541-4-jeffxu@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Please fix following for this and fifth patch as well:

--> checkpatch.pl --codespell tools/testing/selftests/mm/mseal_test.c

WARNING: Macros with flow control statements should be avoided
#42: FILE: tools/testing/selftests/mm/mseal_test.c:42:
+#define FAIL_TEST_IF_FALSE(c) do {\
+               if (!(c)) {\
+                       ksft_test_result_fail("%s, line:%d\n", __func__,
__LINE__);\
+                       goto test_end;\
+               } \
+       } \
+       while (0)

WARNING: Macros with flow control statements should be avoided
#50: FILE: tools/testing/selftests/mm/mseal_test.c:50:
+#define SKIP_TEST_IF_FALSE(c) do {\
+               if (!(c)) {\
+                       ksft_test_result_skip("%s, line:%d\n", __func__,
__LINE__);\
+                       goto test_end;\
+               } \
+       } \
+       while (0)

WARNING: Macros with flow control statements should be avoided
#59: FILE: tools/testing/selftests/mm/mseal_test.c:59:
+#define TEST_END_CHECK() {\
+               ksft_test_result_pass("%s\n", __func__);\
+               return;\
+test_end:\
+               return;\
+}


On 4/15/24 9:35 PM, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> selftest for memory sealing change in mmap() and mseal().
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  tools/testing/selftests/mm/.gitignore   |    1 +
>  tools/testing/selftests/mm/Makefile     |    1 +
>  tools/testing/selftests/mm/mseal_test.c | 1836 +++++++++++++++++++++++
>  3 files changed, 1838 insertions(+)
>  create mode 100644 tools/testing/selftests/mm/mseal_test.c
> 
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index d26e962f2ac4..98eaa4590f11 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -47,3 +47,4 @@ mkdirty
>  va_high_addr_switch
>  hugetlb_fault_after_madv
>  hugetlb_madv_vs_map
> +mseal_test
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index eb5f39a2668b..95d10fe1b3c1 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -59,6 +59,7 @@ TEST_GEN_FILES += mlock2-tests
>  TEST_GEN_FILES += mrelease_test
>  TEST_GEN_FILES += mremap_dontunmap
>  TEST_GEN_FILES += mremap_test
> +TEST_GEN_FILES += mseal_test
>  TEST_GEN_FILES += on-fault-limit
>  TEST_GEN_FILES += pagemap_ioctl
>  TEST_GEN_FILES += thuge-gen
> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
> new file mode 100644
> index 000000000000..06c780d1d8e5
> --- /dev/null
> +++ b/tools/testing/selftests/mm/mseal_test.
> +static void __write_pkey_reg(u64 pkey_reg)
> +{
> +#if defined(__i386__) || defined(__x86_64__) /* arch */
> +	unsigned int eax = pkey_reg;
> +	unsigned int ecx = 0;
> +	unsigned int edx = 0;
> +
> +	asm volatile(".byte 0x0f,0x01,0xef\n\t"
> +			: : "a" (eax), "c" (ecx), "d" (edx));
> +	assert(pkey_reg == __read_pkey_reg());
Use ksft_exit_fail_msg instead of assert to stay inside TAP format if
condition is false and error is generated.

> +int main(int argc, char **argv)
> +{
> +	bool test_seal = seal_support();
> +
> +	ksft_print_header();
> +
> +	if (!test_seal)
> +		ksft_exit_skip("sealing not supported, check CONFIG_64BIT\n");
> +
> +	if (!pkey_supported())
> +		ksft_print_msg("PKEY not supported\n");
> +
> +	ksft_set_plan(80);
> +
> +	test_seal_addseal();
> +	test_seal_unmapped_start();
> +	test_seal_unmapped_middle();
> +	test_seal_unmapped_end();
> +	test_seal_multiple_vmas();
> +	test_seal_split_start();
> +	test_seal_split_end();
> +	test_seal_invalid_input();
> +	test_seal_zero_length();
> +	test_seal_twice();
> +
> +	test_seal_mprotect(false);
> +	test_seal_mprotect(true);
> +
> +	test_seal_start_mprotect(false);
> +	test_seal_start_mprotect(true);
> +
> +	test_seal_end_mprotect(false);
> +	test_seal_end_mprotect(true);
> +
> +	test_seal_mprotect_unalign_len(false);
> +	test_seal_mprotect_unalign_len(true);
> +
> +	test_seal_mprotect_unalign_len_variant_2(false);
> +	test_seal_mprotect_unalign_len_variant_2(true);
> +
> +	test_seal_mprotect_two_vma(false);
> +	test_seal_mprotect_two_vma(true);
> +
> +	test_seal_mprotect_two_vma_with_split(false);
> +	test_seal_mprotect_two_vma_with_split(true);
> +
> +	test_seal_mprotect_partial_mprotect(false);
> +	test_seal_mprotect_partial_mprotect(true);
> +
> +	test_seal_mprotect_two_vma_with_gap(false);
> +	test_seal_mprotect_two_vma_with_gap(true);
> +
> +	test_seal_mprotect_merge(false);
> +	test_seal_mprotect_merge(true);
> +
> +	test_seal_mprotect_split(false);
> +	test_seal_mprotect_split(true);
> +
> +	test_seal_munmap(false);
> +	test_seal_munmap(true);
> +	test_seal_munmap_two_vma(false);
> +	test_seal_munmap_two_vma(true);
> +	test_seal_munmap_vma_with_gap(false);
> +	test_seal_munmap_vma_with_gap(true);
> +
> +	test_munmap_start_freed(false);
> +	test_munmap_start_freed(true);
> +	test_munmap_middle_freed(false);
> +	test_munmap_middle_freed(true);
> +	test_munmap_end_freed(false);
> +	test_munmap_end_freed(true);
> +
> +	test_seal_mremap_shrink(false);
> +	test_seal_mremap_shrink(true);
> +	test_seal_mremap_expand(false);
> +	test_seal_mremap_expand(true);
> +	test_seal_mremap_move(false);
> +	test_seal_mremap_move(true);
> +
> +	test_seal_mremap_shrink_fixed(false);
> +	test_seal_mremap_shrink_fixed(true);
> +	test_seal_mremap_expand_fixed(false);
> +	test_seal_mremap_expand_fixed(true);
> +	test_seal_mremap_move_fixed(false);
> +	test_seal_mremap_move_fixed(true);
> +	test_seal_mremap_move_dontunmap(false);
> +	test_seal_mremap_move_dontunmap(true);
> +	test_seal_mremap_move_fixed_zero(false);
> +	test_seal_mremap_move_fixed_zero(true);
> +	test_seal_mremap_move_dontunmap_anyaddr(false);
> +	test_seal_mremap_move_dontunmap_anyaddr(true);
> +	test_seal_discard_ro_anon(false);
> +	test_seal_discard_ro_anon(true);
> +	test_seal_discard_ro_anon_on_rw(false);
> +	test_seal_discard_ro_anon_on_rw(true);
> +	test_seal_discard_ro_anon_on_shared(false);
> +	test_seal_discard_ro_anon_on_shared(true);
> +	test_seal_discard_ro_anon_on_filebacked(false);
> +	test_seal_discard_ro_anon_on_filebacked(true);
> +	test_seal_mmap_overwrite_prot(false);
> +	test_seal_mmap_overwrite_prot(true);
> +	test_seal_mmap_expand(false);
> +	test_seal_mmap_expand(true);
> +	test_seal_mmap_shrink(false);
> +	test_seal_mmap_shrink(true);
> +
> +	test_seal_merge_and_split();
> +	test_seal_zero_address();
> +
> +	test_seal_discard_ro_anon_on_pkey(false);
> +	test_seal_discard_ro_anon_on_pkey(true);
> +
> +	ksft_finished();
> +	return 0;
The return isn't needed as ksft_finished() calls exit() with right exit code.

> +}

-- 
BR,
Muhammad Usama Anjum

