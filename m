Return-Path: <linux-kselftest+bounces-7350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E8789AD0C
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 23:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EFCD281DE4
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 21:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3518D4EB41;
	Sat,  6 Apr 2024 21:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GlZYdxso"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5434E1A8;
	Sat,  6 Apr 2024 21:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712438980; cv=none; b=ScXCV1HW9HXOf76OUToqd4ncffbJZfh8JGUtX7wAtUdeDNDc84tR/VScyAtB0l21GuS3YueN325zxdwUC9VbTdOR+eWxHeLWHGa/TsTZPY0yY/jp+BXE/G4JCQXwxknQYz4bGkHt5oF12YrkhT4tvd7c5+A8iJaGJ6b8Id1Hs1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712438980; c=relaxed/simple;
	bh=jtSgZNk3hRgVdNXAxN/QO4zcEXGXqHzRRQIB7hldayU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SxbfAGqx3+ojayVTuGm8AlMPFMJZR1AmdLjOGU9a7YFDutQc5rS6FiiRLq7FNYTyr3AM9w41bEwDY69kJqEivhCA63Q/ATPO7VxoDM4Q7E6lr1/7kMuTw9GpTbGzKj5XmvEZhvkiT3SV1L9q+kQ/GoJAOi0RuglbxSoCTha4LNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GlZYdxso; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712438976;
	bh=jtSgZNk3hRgVdNXAxN/QO4zcEXGXqHzRRQIB7hldayU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=GlZYdxsop3DOYjVwcXWveKt6wlvClTn+wFiMEgZ/vEi8s6kyhtfk3qmIB7988mpka
	 FndZhQGS7XFhScAncYu1rgxMC8gkcVnO7cv2etkgDv9AEei+rapMhQYeGh3ZkFlJxc
	 tJIB/0BzUQy4e1EyFutCTN5NIco/b3mSudoB2x3L0RcGK19XHrC4gsYQVpPr1B86OZ
	 Oim0WRSc/PdOi49uZpeOA9bWulNuiBVaVW2OAgJPLzICCYVq/QD6nWGcxDDAH0hKkm
	 UtkS0iRqKbiGHfDZawCWBb6sWplU9LE+JChY9H8PZPxDuqNTlOeHFkjoDO0squ7s9F
	 kLJxYcuhdlTOA==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5EAE837809CE;
	Sat,  6 Apr 2024 21:29:30 +0000 (UTC)
Message-ID: <1913ab65-b3d2-40b9-9f81-c9ee9c769d91@collabora.com>
Date: Sun, 7 Apr 2024 02:30:03 +0500
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
Subject: Re: [PATCH 3/4] selftests/arm: Add elf test
To: Dev Jain <dev.jain@arm.com>, shuah@kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240405084410.256788-1-dev.jain@arm.com>
 <20240405084410.256788-4-dev.jain@arm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240405084410.256788-4-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/5/24 1:44 PM, Dev Jain wrote:
> This patch introduces an ELF parsing test; the 5th byte of the ELF header
> must be 0x01 for a 32-bit process. A basic sanity check is required to ensure
> that we are actually testing a 32-bit build.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  tools/testing/selftests/arm/elf/parse_elf.c | 75 +++++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 tools/testing/selftests/arm/elf/parse_elf.c
> 
> diff --git a/tools/testing/selftests/arm/elf/parse_elf.c b/tools/testing/selftests/arm/elf/parse_elf.c
> new file mode 100644
> index 000000000000..decd65699858
> --- /dev/null
> +++ b/tools/testing/selftests/arm/elf/parse_elf.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 ARM Limited
> + *
> + * Author : Dev Jain <dev.jain@arm.com>
> + *
> + * Parse elf header to confirm 32-bit process
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <elf.h>
> +#include <stdint.h>
> +
> +#include <kselftest.h>
> +
> +/* The ELF file header.  This appears at the start of every ELF file. */
> +
> +struct elf_header {
> +	unsigned char	e_ident[16];	/* Magic number and other info */
> +	uint16_t	e_type;		/* Object file type */
> +	uint16_t	e_machine;	/* Architecture */
> +	uint32_t	e_version;	/* Object file version */
> +	uint64_t	e_entry;	/* Entry point virtual address */
> +	uint64_t	e_phoff;	/* Program header table file offset */
> +	uint64_t	e_shoff;	/* Section header table file offset */
> +	uint32_t	e_flags;	/* Processor-specific flags */
> +	uint16_t	e_ehsize;	/* ELF header size in bytes */
> +	uint16_t	e_phentsize;	/* Program header table entry size */
> +	uint16_t	e_phnum;	/* Program header table entry count */
> +	uint16_t	e_shentsize;	/* Section header table entry size */
> +	uint16_t	e_shnum;	/* Section header table entry count */
> +	uint16_t	e_shstrndx;	/* Section header string table index */
> +};
> +
> +static int read_elf_header(const char  *elfFile)
> +{
> +	struct elf_header header;
> +	FILE *file;
> +
> +	file = fopen(elfFile, "r");
> +	if (file) {
> +
> +		/* store header in struct */
> +		fread(&header, 1, sizeof(header), file);
> +		fclose(file);
> +
> +		/* sanity check: does it really follow ELF format */
> +		if (header.e_ident[0] == 0x7f &&
> +		    header.e_ident[1] == 'E' &&
> +		    header.e_ident[2] == 'L' &&
> +		    header.e_ident[3] == 'F') {
> +			if (header.e_ident[4] == 0x01)
> +				return 0;
> +			return 1;
> +		}
> +		ksft_exit_fail_msg("Cannot parse /proc/self/exe\n");
> +	}
> +	ksft_exit_fail_msg("Cannot open /proc/self/exe\n");
> +	exit(EXIT_FAILURE);
Instead of failing and exiting multiple times here, use ksft_print_msg,
return error or -1 from here and fail the test case in ksft_test_result().

> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	const char *file_name;
> +
> +	ksft_print_header();
> +	ksft_set_plan(1);
> +
> +	file_name = "/proc/self/exe";
> +	ksft_test_result(read_elf_header(file_name) == 0, "ELF is 32 bit\n");
> +	ksft_finished();
> +}

-- 
BR,
Muhammad Usama Anjum

