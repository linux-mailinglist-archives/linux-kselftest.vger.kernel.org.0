Return-Path: <linux-kselftest+bounces-45571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E83B9C58F80
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 18:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F294A799C
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 16:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967C935CB96;
	Thu, 13 Nov 2025 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANlFB3Kd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAD735CB92;
	Thu, 13 Nov 2025 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052385; cv=none; b=Zz7gTLmeMs2oejnZ9Mw/56XpCALUBwvjNSjDzYviPuU/AN/WRwBVmAjlbSoA7dEStyGDbcS39NW+YyIXbVswLkwg5rW/9YTJhXgExhYvZZ1nJWRIq/R8Npf2tSTI3dHdvnwZMHk0tPlDYh0IwJY8LuVX3/viv1B9N8W25rQ1GwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052385; c=relaxed/simple;
	bh=3xOkFRyx8ajSderbZPHE6EZhwEEq/CfQCCTKeRWj+14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSGUUK0dgW6hIGTkMmv3kDdn55U6XAzaa9Fv3poLCwNlM9FbiMPRO+vsoCciSA8smUO6KfYsymhewh2QeyFusZxDY16GQysJDLhVuUDE7Wumdu//NVdsFOXz0i8P5+ECa+GG2uDvuRfu5XBlOvDTnAnJ8hsiKcwOnSmGD+fqbLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANlFB3Kd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79371C4CEF5;
	Thu, 13 Nov 2025 16:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763052385;
	bh=3xOkFRyx8ajSderbZPHE6EZhwEEq/CfQCCTKeRWj+14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ANlFB3KdmGzi6pRPz/Msov+nrcs+dWmK2IqxUKObhB61zauElfiUr1UU7ct9t6nqV
	 nnGxLC+uyoz35YrNU0U7ucFPGn5WdCgU3dB1+NAPf/KRBwj+BoZSGUZDgRuKbbn2Nk
	 n586FtCTMEYY15fU08udtoAB5JdYmyiiG6bQdi7zhzqq+4QlJBLBG5PFPx+vNmB01Z
	 ndTghWSxlJ/eNyMr4uZGhNvCaD7nfRRgOilnnh4bO8FS6VtKCQTVp4CD5IWbfd7QWP
	 V9uOK3ldMMyng+FvbS4mcsqcq4fYWbnrWBzUCjvfK7j12aaF4way83aTHQYgFRkst7
	 +R/ej7dlhrZwQ==
Date: Thu, 13 Nov 2025 18:46:15 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: akpm@linux-foundation.org, peterx@redhat.com, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	surenb@google.com, mhocko@suse.com, shuah@kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] selftests/mm/uffd: remove static address usage in
 shmem_allocate_area()
Message-ID: <aRYLVyR6l-bGCxui@kernel.org>
References: <20251113142050.108638-1-mehdi.benhadjkhelifa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113142050.108638-1-mehdi.benhadjkhelifa@gmail.com>

On Thu, Nov 13, 2025 at 03:20:33PM +0100, Mehdi Ben Hadj Khelifa wrote:
> The current shmem_allocate_area() implementation uses a hardcoded virtual
> base address (BASE_PMD_ADDR) as a hint for mmap() when creating shmem-backed
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
> Suggested-by: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> Testing(Retested):
> A diff between running the mm selftests on 6.18-rc5 from before and after
> the change show no regression on x86_64 architecture with 32GB DDR5 RAM.
> 
> ChangeLog:
> 
> Changes from v1:
> 
> -Implemented Mike's suggestions to make cleanup code more clear.
> 
> Link:https://lore.kernel.org/all/20251111205739.420009-1-mehdi.benhadjkhelifa@gmail.com/
> 
>  tools/testing/selftests/mm/uffd-common.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
> index 994fe8c03923..edd02328f77b 100644
> --- a/tools/testing/selftests/mm/uffd-common.c
> +++ b/tools/testing/selftests/mm/uffd-common.c
> @@ -10,7 +10,6 @@
>  uffd_test_ops_t *uffd_test_ops;
>  uffd_test_case_ops_t *uffd_test_case_ops;
>  
> -#define BASE_PMD_ADDR ((void *)(1UL << 30))
>  
>  /* pthread_mutex_t starts at page offset 0 */
>  pthread_mutex_t *area_mutex(char *area, unsigned long nr, uffd_global_test_opts_t *gopts)
> @@ -142,30 +141,37 @@ static int shmem_allocate_area(uffd_global_test_opts_t *gopts, void **alloc_area
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
> +	p = reserve;
>  	p_alias = p;
>  	p_alias += bytes;
>  	p_alias += hpage_size;  /* Prevent src/dst VMA merge */
>  
> -	*alloc_area = mmap(p, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
> +	*alloc_area = mmap(p, bytes, PROT_READ | PROT_WRITE, MAP_FIXED | MAP_SHARED,
>  			   mem_fd, offset);
>  	if (*alloc_area == MAP_FAILED) {
>  		*alloc_area = NULL;
> +		munmap(reserve, region_size);
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
>  		*alloc_area = NULL;
> +		munmap(reserve, region_size);
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

