Return-Path: <linux-kselftest+bounces-48722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CF8D11857
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 10:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21AD7300453F
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 09:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864BC2673A5;
	Mon, 12 Jan 2026 09:34:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A671617B418;
	Mon, 12 Jan 2026 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210476; cv=none; b=iye5HLWLIWmLqv7v6TUDcNdVI31VBok9JiLHAtbwM5VTRFZ/a5+bOVDCfHz9Yx94zjZtzGZquSrwwHR6u1cK5blQq4DpvPIuTDEP7PuylhLX9wFNWXCxeX6ThZnwfOp88C4RNWYqQqdVnKrXdgoh79HFwMeUaXD8sa6l+CHKcaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210476; c=relaxed/simple;
	bh=TSgLmQf4rntLNZovQ8eRSanEh9kU1TC+CS6f9QbfmKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/JaVYPRz2EPDsZkeV7PTu92CDOaP90jxkOK0ouI/2+DKqf4NOOLugG+L/iB8RoKUN/U7rDGU0O/SnVHm3agIGgdl4OOmsBpb594rwyYCGpCGyF8MvpEeGT1FR3aHGPnbMmD+N1/JKZtaRfJA09q3qDD1e2LGjvY785r66F5Fzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56DE1339;
	Mon, 12 Jan 2026 01:34:27 -0800 (PST)
Received: from [10.57.95.123] (unknown [10.57.95.123])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5C9E3F694;
	Mon, 12 Jan 2026 01:34:32 -0800 (PST)
Message-ID: <315a7239-f5ce-474e-bd0d-f1deca3a7b26@arm.com>
Date: Mon, 12 Jan 2026 09:34:31 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] selftests/mm: report SKIP in pfnmap if a check
 fails
Content-Language: en-GB
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Mark Brown
 <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20260107164842.3289559-1-kevin.brodsky@arm.com>
 <20260107164842.3289559-9-kevin.brodsky@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20260107164842.3289559-9-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/01/2026 16:48, Kevin Brodsky wrote:
> pfnmap currently checks the target file in FIXTURE_SETUP(pfnmap),
> meaning once for every test, and skips the test if any check fails.
> 
> The target file is the same for every test so this is a little
> overkill. More importantly, this approach means that the whole suite
> will report PASS even if all the tests are skipped because kernel
> configuration (e.g. CONFIG_STRICT_DEVMEM=y) prevented /dev/mem from
> being mapped, for instance.
> 
> Let's ensure that KSFT_SKIP is returned as exit code if any check
> fails by performing the checks in pfnmap_init(), run once. That
> function also takes care of finding the offset of the pages to be
> mapped and saves it in a global. The file is still mapped/unmapped
> for every test, as some of them modify the mapping.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  tools/testing/selftests/mm/pfnmap.c | 81 ++++++++++++++++++++---------
>  1 file changed, 55 insertions(+), 26 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/pfnmap.c b/tools/testing/selftests/mm/pfnmap.c
> index 35b0e3ed54cd..e41d5464130b 100644
> --- a/tools/testing/selftests/mm/pfnmap.c
> +++ b/tools/testing/selftests/mm/pfnmap.c
> @@ -25,8 +25,11 @@
>  #include "kselftest_harness.h"
>  #include "vm_util.h"
>  
> +#define DEV_MEM_NPAGES	2
> +
>  static sigjmp_buf sigjmp_buf_env;
>  static char *file = "/dev/mem";
> +static off_t file_offset;
>  
>  static void signal_handler(int sig)
>  {
> @@ -88,7 +91,7 @@ static int find_ram_target(off_t *offset,
>  			break;
>  
>  		/* We need two pages. */
> -		if (end > start + 2 * pagesize) {
> +		if (end > start + DEV_MEM_NPAGES * pagesize) {
>  			fclose(file);
>  			*offset = start;
>  			return 0;
> @@ -97,9 +100,49 @@ static int find_ram_target(off_t *offset,
>  	return -ENOENT;
>  }
>  
> +static void pfnmap_init(void)
> +{
> +	size_t pagesize = getpagesize();
> +	size_t size = DEV_MEM_NPAGES * pagesize;
> +	int fd;
> +	void *addr;
> +
> +	if (strncmp(file, "/dev/mem", strlen("/dev/mem")) == 0) {
> +		int err = find_ram_target(&file_offset, pagesize);
> +
> +		if (err)
> +			ksft_exit_skip("Cannot find ram target in '/proc/iomem': %s\n",
> +				       strerror(-err));
> +	} else {
> +		file_offset = 0;
> +	}
> +
> +	/*
> +	 * Make sure we can open and map the file, and perform some basic
> +	 * checks; skip the whole suite if anything goes wrong.
> +	 * A fresh mapping is then created for every test case by
> +	 * FIXTURE_SETUP(pfnmap).
> +	 */
> +	fd = open(file, O_RDONLY);
> +	if (fd < 0)
> +		ksft_exit_skip("Cannot open '%s': %s\n", file, strerror(errno));
> +
> +	addr = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, file_offset);
> +	if (addr == MAP_FAILED)
> +		ksft_exit_skip("Cannot mmap '%s': %s\n", file, strerror(errno));
> +
> +	if (!check_vmflag_pfnmap(addr))
> +		ksft_exit_skip("Invalid file: '%s'. Not pfnmap'ed\n", file);
> +
> +	if (test_read_access(addr, size))
> +		ksft_exit_skip("Cannot read-access mmap'ed '%s'\n", file);
> +
> +	munmap(addr, size);
> +	close(fd);
> +}
> +
>  FIXTURE(pfnmap)
>  {
> -	off_t offset;
>  	size_t pagesize;
>  	int dev_mem_fd;
>  	char *addr1;
> @@ -112,31 +155,13 @@ FIXTURE_SETUP(pfnmap)
>  {
>  	self->pagesize = getpagesize();
>  
> -	if (strncmp(file, "/dev/mem", strlen("/dev/mem")) == 0) {
> -		/* We'll require two physical pages throughout our tests ... */
> -		if (find_ram_target(&self->offset, self->pagesize))
> -			SKIP(return,
> -				   "Cannot find ram target in '/proc/iomem'\n");
> -	} else {
> -		self->offset = 0;
> -	}
> -
>  	self->dev_mem_fd = open(file, O_RDONLY);
> -	if (self->dev_mem_fd < 0)
> -		SKIP(return, "Cannot open '%s'\n", file);
> +	ASSERT_GE(self->dev_mem_fd, 0);
>  
> -	self->size1 = self->pagesize * 2;
> +	self->size1 = DEV_MEM_NPAGES * self->pagesize;
>  	self->addr1 = mmap(NULL, self->size1, PROT_READ, MAP_SHARED,
> -			   self->dev_mem_fd, self->offset);
> -	if (self->addr1 == MAP_FAILED)
> -		SKIP(return, "Cannot mmap '%s'\n", file);
> -
> -	if (!check_vmflag_pfnmap(self->addr1))
> -		SKIP(return, "Invalid file: '%s'. Not pfnmap'ed\n", file);

I wonder if we still want this check per-fd, but upgraded to a fail?

Either way:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> -
> -	/* ... and want to be able to read from them. */
> -	if (test_read_access(self->addr1, self->size1))
> -		SKIP(return, "Cannot read-access mmap'ed '%s'\n", file);
> +			   self->dev_mem_fd, file_offset);
> +	ASSERT_NE(self->addr1, MAP_FAILED);
>  
>  	self->size2 = 0;
>  	self->addr2 = MAP_FAILED;
> @@ -189,7 +214,7 @@ TEST_F(pfnmap, munmap_split)
>  	 */
>  	self->size2 = self->pagesize;
>  	self->addr2 = mmap(NULL, self->pagesize, PROT_READ, MAP_SHARED,
> -			   self->dev_mem_fd, self->offset);
> +			   self->dev_mem_fd, file_offset);
>  	ASSERT_NE(self->addr2, MAP_FAILED);
>  }
>  
> @@ -258,8 +283,12 @@ int main(int argc, char **argv)
>  		if (strcmp(argv[i], "--") == 0) {
>  			if (i + 1 < argc && strlen(argv[i + 1]) > 0)
>  				file = argv[i + 1];
> -			return test_harness_run(i, argv);
> +			argc = i;
> +			break;
>  		}
>  	}
> +
> +	pfnmap_init();
> +
>  	return test_harness_run(argc, argv);
>  }


