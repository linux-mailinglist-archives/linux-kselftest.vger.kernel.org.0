Return-Path: <linux-kselftest+bounces-7347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8150289AD03
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 23:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204E21F21813
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 21:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0254E1CC;
	Sat,  6 Apr 2024 21:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OdHJ1KQD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D2C33CF5;
	Sat,  6 Apr 2024 21:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712438569; cv=none; b=ii7YgWLhNOw0bAveqFNkWogC04S/XHL3UE4JrFY7eyCGCG5U94Vzpke2dNG8HpxoBW25kNV/hA7BKhbLLo52xcGjEsu4nlZj/fY13UYUDczmcE73KDVOHDJMZyx7W/dVkP7+gAOWwk2CqIk8D/0eOasrtaSh49NTe//6YKVCgXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712438569; c=relaxed/simple;
	bh=TQlfmYY4MpPDkMAXoXy/i8d+S8nnRs6w6iVpbVBt4E4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GG2TJRsuYK9F5sX5Uz9EYQW8KVEVOGB1l4T+uyM1ImaUr7p9xns8R1uz6LAR6ih/iSmUwrtE++4weIAEhUd4CjQrZcB2SAvlaQ+gMw/1I/hxFBN/K2JSRDT0ZArfX+z/1D9oWgTiS+CTSUF89zDSwFLMHDRogG8549axEz4eIZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OdHJ1KQD; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712438566;
	bh=TQlfmYY4MpPDkMAXoXy/i8d+S8nnRs6w6iVpbVBt4E4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=OdHJ1KQDJnLQk230EzXDEe7MXdssOWg+GCzBRZrYDj424HHkWF14A5Fcl6MJWf17h
	 Kox+CvtmbWZJ9bxU0ZC851lfe8bMNJui9DB978hEPnfXzwrwdZ16bUHtRhUENi399t
	 YLZkFUwxrXu/FRI9L5t7mdqgH928HgVo+pxeVcwFl8aJcaJtFqFNfSH/ncFj8aFr/m
	 QZKZ7qinF+3PXxkw+v/1xD6IkjUhvI4WyQVVV7KHPSZY2OpG2RP9dNUESX993RvWfb
	 nUQUG3BrzZWFRM/DupFvOhnjkMkQtK6w2LMoHty0Wj0xxzIJ+yPs1BWI3lDGeT7Jx0
	 ke9SwZ5BzYz4A==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 14A9637809CE;
	Sat,  6 Apr 2024 21:22:40 +0000 (UTC)
Message-ID: <ac9b16a7-f294-44d4-8243-488db97a009e@collabora.com>
Date: Sun, 7 Apr 2024 02:23:13 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Anshuman.Khandual@arm.com, suzuki.poulose@arm.com, ryan.roberts@arm.com,
 rob.herring@arm.com, Catalin.Marinas@arm.com, broonie@kernel.org,
 will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH 1/4] selftests/arm: Add mm test
To: Dev Jain <dev.jain@arm.com>, shuah@kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240405084410.256788-1-dev.jain@arm.com>
 <20240405084410.256788-2-dev.jain@arm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240405084410.256788-2-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/5/24 1:44 PM, Dev Jain wrote:
> This patch tests the 4GB VA restriction for 32-bit processes; it is required
> to test the compat layer, whether the kernel knows that it is running a 32-bit
> process or not. Chunks are allocated until the VA gets exhausted; mmap must
> fail beyond 4GB. This is asserted against the VA mappings found
> in /proc/self/maps.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  tools/testing/selftests/arm/mm/compat_va.c | 94 ++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 tools/testing/selftests/arm/mm/compat_va.c
> 
> diff --git a/tools/testing/selftests/arm/mm/compat_va.c b/tools/testing/selftests/arm/mm/compat_va.c
> new file mode 100644
> index 000000000000..3a78f240bc87
> --- /dev/null
> +++ b/tools/testing/selftests/arm/mm/compat_va.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 ARM Limited
> + *
> + * Author : Dev Jain <dev.jain@arm.com>
> + *
> + * Tests 4GB VA restriction for 32 bit process
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <sys/mman.h>
> +
> +#include <linux/sizes.h>
> +#include <kselftest.h>
> +
> +#define MAP_CHUNK_SIZE	SZ_1M
> +#define NR_CHUNKS_4G	(SZ_1G / MAP_CHUNK_SIZE) * 4	/* prevent overflow */
> +
> +static int validate_address_hint(void)
> +{
> +	char *ptr;
> +
> +	ptr = mmap((void *) (1UL << 29), MAP_CHUNK_SIZE, PROT_READ |
> +		   PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +
> +	if (ptr == MAP_FAILED)
> +		return 0;
> +
> +	return 1;
Usually we return negative value instead of positive one which indicates
error situation.

> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	char *ptr[NR_CHUNKS_4G + 3];
> +	char line[1000];
> +	const char *file_name;
> +	int chunks;
> +	FILE *file;
> +	int i;
> +
> +	ksft_print_header();
> +	ksft_set_plan(1);
There are multiple test cases. Instead of saying there is only 1 test.
There should be multiple ksft_test_result{_pass,_fail} statements for each
sub-tests.

> +
> +	/* try allocation beyond 4 GB */
> +	for (i = 0; i < NR_CHUNKS_4G + 3; ++i) {
> +		ptr[i] = mmap(NULL, MAP_CHUNK_SIZE, PROT_READ | PROT_WRITE,
> +			      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +
> +		if (ptr[i] == MAP_FAILED) {
> +			if (validate_address_hint())
> +				ksft_exit_fail_msg("VA exhaustion failed\n");
> +			break;
> +		}
> +	}
> +
> +	chunks = i;
> +	if (chunks >= NR_CHUNKS_4G) {
> +		ksft_test_result_fail("mmapped chunks beyond 4GB\n");
> +		ksft_finished();
> +	}
> +
> +	/* parse /proc/self/maps, confirm 32 bit VA mappings */
> +	file_name = "/proc/self/maps";
> +	file = fopen(file_name, "r");
> +	if (file == NULL)
> +		ksft_exit_fail_msg("/proc/self/maps cannot be opened\n");
> +
> +	while (fgets(line, sizeof(line), file)) {
> +		const char *whitespace_loc, *hyphen_loc;
> +
> +		hyphen_loc = strchr(line, '-');
> +		whitespace_loc = strchr(line, ' ');
> +
> +		if (!(hyphen_loc && whitespace_loc)) {
> +			ksft_test_result_skip("Unexpected format");
> +			ksft_finished();
I'm unable to follow as there are too many return statements. If you divide
the test into multiple sub-tests, you can skip/pass/fail each sub-test easily.

> +		}
> +
> +		if ((hyphen_loc - line > 8) ||
> +		    (whitespace_loc - hyphen_loc) > 9) {
> +			ksft_test_result_fail("Memory map more than 32 bits\n");
> +			ksft_finished();
> +		}
> +	}
> +
> +	for (int i = 0; i < chunks; ++i)
> +		munmap(ptr[i], MAP_CHUNK_SIZE);
> +
> +	ksft_test_result_pass("Test\n");
> +	ksft_finished();
> +}

-- 
BR,
Muhammad Usama Anjum

