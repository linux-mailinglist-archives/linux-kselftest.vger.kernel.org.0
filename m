Return-Path: <linux-kselftest+bounces-49350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88947D3A686
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 12:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9AC5300FA28
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 11:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531E22DA77E;
	Mon, 19 Jan 2026 11:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ec02xF3m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB852D1916;
	Mon, 19 Jan 2026 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768821389; cv=none; b=SwimAnuIvKP74I4zLl/V77x/aIjVDEbYgSuxwLwmlQJMnAbPGRJVzqvKTDhEp8oJUgMYRDsCqfkiOu6Do3FK/ZMcjqYmQKrgLzdvCYdH+bQxDkusU88umTy9GJHVhP4nQJUjqrE/tiRB2Bub6EYplrG8DN+ZqWdH8FoR4q8pgXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768821389; c=relaxed/simple;
	bh=IUVE3GXM6RFdsSQGwKFqMXdBr5285go1ee4oIqD+IQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHVyCTThhYkND8tc6RcFmrEhThPKVUoaXK3aeobYUlCpGIEePn68YwKeHl20IJOUixW2nljoGRPbbvkx62KmaHuW1yO7K3FgIB3xUdTEp5wdbS/ZgX2J1YCf4wjMd/smmdwCVib2PURt7dInlncR+M1LAf3jP3SpA90MkAJt8K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ec02xF3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47576C19424;
	Mon, 19 Jan 2026 11:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768821388;
	bh=IUVE3GXM6RFdsSQGwKFqMXdBr5285go1ee4oIqD+IQs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ec02xF3muwf5NwLMrYHzJqg/3ypIIf23/u3Y2IW1l/6ndAQJgW0lZbX2aS2L0VK6x
	 Ogk894YZ6RKbCK/mD1aVu/YWHBKnxlnc+GVjFSYOt4w44iX/J2IEkBKi2oxP68pKuv
	 CJbtP4AF9bf7RHjYc4swjy6n44CpUM/WYU23UeFvXbL8Wc+bNaCiUZjXvmiTdmig3h
	 f3deb0V7NrTP2iozv4kQJnGxxBVvwP02h4gksMo63Y71ffljQ8dXaBjy49TfuUbjT8
	 1/cvn5ipx1PPKAFvKIjh4Y1/I9tjxv1ligJ6Jxjrru+w9o4+W9kC4Dj9iv/QXixz5N
	 HzGQtc92tcj3A==
Message-ID: <09c214df-c3aa-48e4-9587-c54c667c6ce9@kernel.org>
Date: Mon, 19 Jan 2026 12:16:24 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] selftests/mm: report SKIP in pfnmap if a check
 fails
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Mark Brown
 <broonie@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Shuah Khan <shuah@kernel.org>
References: <20260107164842.3289559-1-kevin.brodsky@arm.com>
 <20260107164842.3289559-9-kevin.brodsky@arm.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
In-Reply-To: <20260107164842.3289559-9-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/7/26 17:48, Kevin Brodsky wrote:
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
>   tools/testing/selftests/mm/pfnmap.c | 81 ++++++++++++++++++++---------
>   1 file changed, 55 insertions(+), 26 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/pfnmap.c b/tools/testing/selftests/mm/pfnmap.c
> index 35b0e3ed54cd..e41d5464130b 100644
> --- a/tools/testing/selftests/mm/pfnmap.c
> +++ b/tools/testing/selftests/mm/pfnmap.c
> @@ -25,8 +25,11 @@
>   #include "kselftest_harness.h"
>   #include "vm_util.h"
>   
> +#define DEV_MEM_NPAGES	2
> +
>   static sigjmp_buf sigjmp_buf_env;
>   static char *file = "/dev/mem";
> +static off_t file_offset;
>   
>   static void signal_handler(int sig)
>   {
> @@ -88,7 +91,7 @@ static int find_ram_target(off_t *offset,
>   			break;
>   
>   		/* We need two pages. */
> -		if (end > start + 2 * pagesize) {
> +		if (end > start + DEV_MEM_NPAGES * pagesize) {
>   			fclose(file);
>   			*offset = start;
>   			return 0;
> @@ -97,9 +100,49 @@ static int find_ram_target(off_t *offset,
>   	return -ENOENT;
>   }
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

Why not keep the fd open then and supply that to all tests without the 
need for them to open/close?

Then, also the file cannot change etc.

-- 
Cheers

David

