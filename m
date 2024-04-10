Return-Path: <linux-kselftest+bounces-7518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C280089E8B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 06:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628041F22020
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 04:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670F98472;
	Wed, 10 Apr 2024 04:11:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0474C127;
	Wed, 10 Apr 2024 04:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712722271; cv=none; b=aE4qk7+IZLhjoP1bnPSoPTtg/TAte+6pdaKx3L9Nz2cxMvU954B0U868PSflQZoO/uLGRZ4/0FXFqyfYMq675/qzRuK4D3zJaOR6Jb5wAYQ8lCknpXDjQKt8K2behYFA0ctM5FkIxsfVdOtSOED6yUBCMoMl6rq935ebXCHHR1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712722271; c=relaxed/simple;
	bh=0m0M4CKHOltghRB0qj2gqbMWbmEB2TWk1Qvso1asGZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SRl/bGz5y95UKd5YeSmEDkMVzke9o1G+N/inexXY25SHNirN3gqEPqHUCdY5YGd3pU3w/0rPivgF6ucXYEh2KsSy3u6yhIPRTX8LHT5jSCIngSoRwknS0g8cu/5ifSQgA25FFzNDuJnOj6C5aDeqyM6AMtLL9FUfd+Mac8ZGYUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD018139F;
	Tue,  9 Apr 2024 21:11:37 -0700 (PDT)
Received: from [10.162.40.22] (e116581.arm.com [10.162.40.22])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A61BC3F6C4;
	Tue,  9 Apr 2024 21:11:03 -0700 (PDT)
Message-ID: <15a24a03-6e83-4a25-803a-5c5efcd393fd@arm.com>
Date: Wed, 10 Apr 2024 09:41:00 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] selftests/arm: Add elf test
To: Muhammad Usama Anjum <usama.anjum@collabora.com>, shuah@kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Anshuman.Khandual@arm.com, suzuki.poulose@arm.com, ryan.roberts@arm.com,
 rob.herring@arm.com, Catalin.Marinas@arm.com, broonie@kernel.org,
 will@kernel.org, mark.rutland@arm.com
References: <20240405084410.256788-1-dev.jain@arm.com>
 <20240405084410.256788-4-dev.jain@arm.com>
 <1913ab65-b3d2-40b9-9f81-c9ee9c769d91@collabora.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <1913ab65-b3d2-40b9-9f81-c9ee9c769d91@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/7/24 03:00, Muhammad Usama Anjum wrote:
> On 4/5/24 1:44 PM, Dev Jain wrote:
>> This patch introduces an ELF parsing test; the 5th byte of the ELF header
>> must be 0x01 for a 32-bit process. A basic sanity check is required to ensure
>> that we are actually testing a 32-bit build.
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>>   tools/testing/selftests/arm/elf/parse_elf.c | 75 +++++++++++++++++++++
>>   1 file changed, 75 insertions(+)
>>   create mode 100644 tools/testing/selftests/arm/elf/parse_elf.c
>>
>> diff --git a/tools/testing/selftests/arm/elf/parse_elf.c b/tools/testing/selftests/arm/elf/parse_elf.c
>> new file mode 100644
>> index 000000000000..decd65699858
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm/elf/parse_elf.c
>> @@ -0,0 +1,75 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2024 ARM Limited
>> + *
>> + * Author : Dev Jain <dev.jain@arm.com>
>> + *
>> + * Parse elf header to confirm 32-bit process
>> + */
>> +
>> +#define _GNU_SOURCE
>> +#include <stdio.h>
>> +#include <unistd.h>
>> +#include <stdlib.h>
>> +#include <elf.h>
>> +#include <stdint.h>
>> +
>> +#include <kselftest.h>
>> +
>> +/* The ELF file header.  This appears at the start of every ELF file. */
>> +
>> +struct elf_header {
>> +	unsigned char	e_ident[16];	/* Magic number and other info */
>> +	uint16_t	e_type;		/* Object file type */
>> +	uint16_t	e_machine;	/* Architecture */
>> +	uint32_t	e_version;	/* Object file version */
>> +	uint64_t	e_entry;	/* Entry point virtual address */
>> +	uint64_t	e_phoff;	/* Program header table file offset */
>> +	uint64_t	e_shoff;	/* Section header table file offset */
>> +	uint32_t	e_flags;	/* Processor-specific flags */
>> +	uint16_t	e_ehsize;	/* ELF header size in bytes */
>> +	uint16_t	e_phentsize;	/* Program header table entry size */
>> +	uint16_t	e_phnum;	/* Program header table entry count */
>> +	uint16_t	e_shentsize;	/* Section header table entry size */
>> +	uint16_t	e_shnum;	/* Section header table entry count */
>> +	uint16_t	e_shstrndx;	/* Section header string table index */
>> +};
>> +
>> +static int read_elf_header(const char  *elfFile)
>> +{
>> +	struct elf_header header;
>> +	FILE *file;
>> +
>> +	file = fopen(elfFile, "r");
>> +	if (file) {
>> +
>> +		/* store header in struct */
>> +		fread(&header, 1, sizeof(header), file);
>> +		fclose(file);
>> +
>> +		/* sanity check: does it really follow ELF format */
>> +		if (header.e_ident[0] == 0x7f &&
>> +		    header.e_ident[1] == 'E' &&
>> +		    header.e_ident[2] == 'L' &&
>> +		    header.e_ident[3] == 'F') {
>> +			if (header.e_ident[4] == 0x01)
>> +				return 0;
>> +			return 1;
>> +		}
>> +		ksft_exit_fail_msg("Cannot parse /proc/self/exe\n");
>> +	}
>> +	ksft_exit_fail_msg("Cannot open /proc/self/exe\n");
>> +	exit(EXIT_FAILURE);
> Instead of failing and exiting multiple times here, use ksft_print_msg,
> return error or -1 from here and fail the test case in ksft_test_result().
Thanks for the suggestion.
>
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	const char *file_name;
>> +
>> +	ksft_print_header();
>> +	ksft_set_plan(1);
>> +
>> +	file_name = "/proc/self/exe";
>> +	ksft_test_result(read_elf_header(file_name) == 0, "ELF is 32 bit\n");
>> +	ksft_finished();
>> +}

