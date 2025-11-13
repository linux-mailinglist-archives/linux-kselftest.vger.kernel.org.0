Return-Path: <linux-kselftest+bounces-45534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D26EBC573E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 12:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A70E634BA5A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 11:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29422DAFB9;
	Thu, 13 Nov 2025 11:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIr0rjst"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E38299AA3;
	Thu, 13 Nov 2025 11:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033976; cv=none; b=T2uwgj/DnZiwAMoBGvp7yFa33DuVqWA22ZbkQNf+5lvBR1rclMq+hyUPn02ZzJdNefkiX32wrVvk3XEOH5bpG63ETdLuNqbU5Ja1dC5nDtF0vBjRubemLgGzePpcFv8l3SCVpVhfhJrF5eNQtVZkG93iLMvAASJF1Lq6meYb/uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033976; c=relaxed/simple;
	bh=ENVhoOS7G7gCzCBUGCoR+ITgrpqX7seulif8UfTBp0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onv917+BY/9oO+ZW5f7F/i96sE4s/vF/aL1VyuI7S5ZR7N+4ROn2ZN8g1srckxWNCHhClKFmANbi38L2NpoHdRtDsNg8N/yN+WewcDycwnvOLS+lDwcBF/c7T7AUWUrhc0CReybSx/0xLQR4Fh9vqGC5rxoKuvh/sIpdxkFnKgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIr0rjst; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A995C4CEF5;
	Thu, 13 Nov 2025 11:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763033976;
	bh=ENVhoOS7G7gCzCBUGCoR+ITgrpqX7seulif8UfTBp0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VIr0rjstKJ3saWpOlCPEj9yrlsSRfWVdSQkR1q6I3ZgbEqEbjPhjAwZARfKCLBEHD
	 NGXFco0t56DpoMlRyxC4Dv7YU5Dj77k5L5LEk+YeLgg6BmGF3YD/hglGfiBsfuYSL3
	 WalSNO2wr0gm3B+obfSK4LBPcORjuDCqoqCbXgpv9hONWBGRCQH7Icr1ATqy0Pmb9r
	 ZMVa4ISTLJXD4HD0aPUFJ3/8+8HfJoZY1kBU/TJZKi4MwFDa1g7A0PisLusFC0HKNg
	 wdLEn1kFzdFK2Tk27NHIoXVG5ZbkwxsahhpJX0ykb16FldNGhAL4Y2Sxc+/7dRi/YV
	 dht9+6EHugDgQ==
Date: Thu, 13 Nov 2025 13:39:26 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: akpm@linux-foundation.org, peterx@redhat.com, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	surenb@google.com, mhocko@suse.com, shuah@kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftests/mm/uffd: remove static address usage in
 shmem_allocate_area()
Message-ID: <aRXDbk9ajOhH7ReX@kernel.org>
References: <20251111205739.420009-1-mehdi.benhadjkhelifa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111205739.420009-1-mehdi.benhadjkhelifa@gmail.com>

On Tue, Nov 11, 2025 at 09:54:27PM +0100, Mehdi Ben Hadj Khelifa wrote:
> The current shmem_allocate_area() implementation uses a hardcoded virtual
> base address(BASE_PMD_ADDR) as a hint for mmap() when creating shmem-backed
> test areas. This approach is fragile and may fail on systems with ASLR or
> different virtual memory layouts, where the chosen address is unavailable.
> 
> Replace the static base address with a dynamically reserved address range
> obtained via mmap(NULL, ..., PROT_NONE). The memfd-backed areas and their
> alias are then mapped into that reserved region using MAP_FIXED, preserving
> the original layout and aliasing semantics while avoiding collisions with
> unrelated mappings.
> 
> This change improves robustness and portability of the test suite without
> altering its behavior or coverage.
> 
> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> ---
> Testing:
> A diff between running the mm selftests on 6.18-rc5 from before and after
> the change show no regression on x86_64 architecture with 32GB DDR5 RAM.
>  tools/testing/selftests/mm/uffd-common.c | 25 +++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
> index 994fe8c03923..492b21c960bb 100644
> --- a/tools/testing/selftests/mm/uffd-common.c
> +++ b/tools/testing/selftests/mm/uffd-common.c
> @@ -6,11 +6,11 @@
>   */
>  
>  #include "uffd-common.h"
> +#include "asm-generic/mman-common.h"

Please drop this.
There's already include <sys/mman.h> via uffd-common.h/vm_util.h.

>  
>  uffd_test_ops_t *uffd_test_ops;
>  uffd_test_case_ops_t *uffd_test_case_ops;
>  
> -#define BASE_PMD_ADDR ((void *)(1UL << 30))
>  
>  /* pthread_mutex_t starts at page offset 0 */
>  pthread_mutex_t *area_mutex(char *area, unsigned long nr, uffd_global_test_opts_t *gopts)
> @@ -142,30 +142,37 @@ static int shmem_allocate_area(uffd_global_test_opts_t *gopts, void **alloc_area
>  	unsigned long offset = is_src ? 0 : bytes;
>  	char *p = NULL, *p_alias = NULL;
>  	int mem_fd = uffd_mem_fd_create(bytes * 2, false);
> +	size_t region_size = bytes * 2 + hpage_size;
>  
> -	/* TODO: clean this up.  Use a static addr is ugly */
> -	p = BASE_PMD_ADDR;
> -	if (!is_src)
> -		/* src map + alias + interleaved hpages */
> -		p += 2 * (bytes + hpage_size);
> +	void *reserve = mmap(NULL, region_size, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS,
> +			-1, 0);
> +	if (reserve == MAP_FAILED) {
> +		close(mem_fd);
> +		return -errno;
> +	}
> +
> +	p = (char *)reserve;

No need for casting here.

>  	p_alias = p;
>  	p_alias += bytes;
>  	p_alias += hpage_size;  /* Prevent src/dst VMA merge */
>  
> -	*alloc_area = mmap(p, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
> +	*alloc_area = mmap(p, bytes, PROT_READ | PROT_WRITE, MAP_FIXED | MAP_SHARED,
>  			   mem_fd, offset);
>  	if (*alloc_area == MAP_FAILED) {
> +		munmap(reserve, region_size);

I think it'll be more readable to put munmap() after setting *alloc_area to
NULL.

>  		*alloc_area = NULL;
> +		close(mem_fd);
>  		return -errno;
>  	}
>  	if (*alloc_area != p)
>  		err("mmap of memfd failed at %p", p);
>  
> -	area_alias = mmap(p_alias, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
> +	area_alias = mmap(p_alias, bytes, PROT_READ | PROT_WRITE, MAP_FIXED | MAP_SHARED,
>  			  mem_fd, offset);
>  	if (area_alias == MAP_FAILED) {
> -		munmap(*alloc_area, bytes);
> +		munmap(reserve, region_size);

Here as well.

>  		*alloc_area = NULL;
> +		close(mem_fd);
>  		return -errno;
>  	}
>  	if (area_alias != p_alias)
> -- 
> 2.51.2
> 

-- 
Sincerely yours,
Mike.

