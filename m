Return-Path: <linux-kselftest+bounces-45535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB86DC5740B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 12:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C53FA3497CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 11:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592C9337BB5;
	Thu, 13 Nov 2025 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VU146KzH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5AD3112BB;
	Thu, 13 Nov 2025 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034134; cv=none; b=Q0U9IquTV1/MNtkhppuKRAPrOUP+oy3mB997zsgCKJTeXygxXiidEnxvMgTy2kL8LrGXZOywn+GpMNihGTDnh+GMUpJfePJHUCDa5nU5Csyk1KML4/J2HY135mQJ3Fb+g5+tV1wz1IedjUBZHSgtwARDw+xfJaGEwbBtg7U2uqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034134; c=relaxed/simple;
	bh=STrLN9TaMedzhy/AV3DPEXhd1qFmA8sZ1GjlOFXHjO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YemcIK6+B+IodXejH4+Qnq4Y7QC8Xpesx0iZzpyDVIyg1vdu/GF4sDX6gLOfB/ytsEBdsDOxT5NORJ4Fe7dqc1PAtjMLQ3DdOEln5EFtDLI5rN0U+zcATutZWqfvz697+/Fh5rkgacQOERLxBHTbWNwPIo3+VnUYY9jwIf1jk4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VU146KzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC98CC4AF09;
	Thu, 13 Nov 2025 11:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763034134;
	bh=STrLN9TaMedzhy/AV3DPEXhd1qFmA8sZ1GjlOFXHjO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VU146KzHCHjuBsPUsgTIzQH0cXL+9V8Z6BJqbMtO79x84t7yUlDckcL2h7qf9bRFg
	 obF3uDlCXmobGcjhbUpr3Wa7VgZ6PIAjSBYOzjxqEbNq9uGJvWb8yDvfj08/PQ/g6a
	 D13+Zzxmn8YrUz2QFj168p5x6HYuAqYEW1zTQ3zSxxfbU4fE2KkhZKF5gYoWk1cLlw
	 MTsxXNGTVAzosrfZAxLZ83pNPnN8uj3mBnqlX8pye1ZjQHW1YlAcQHdvIY6394FQSB
	 1aQEUiLoVhEL9j6cYVFgedr30vAUY4djX/mqiBY0rzyeqOfTiityRADnFo5V5M65hg
	 pEb7zGtClVyQA==
Date: Thu, 13 Nov 2025 13:42:04 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	Brendan Jackman <jackmanb@google.com>, kernel-team@android.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	"open list:MEMORY MANAGEMENT - USERFAULTFD" <linux-mm@kvack.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests/mm: fix division-by-zero in uffd-unit-tests
Message-ID: <aRXEDLQQtwVPz7va@kernel.org>
References: <20251113034623.3127012-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113034623.3127012-1-cmllamas@google.com>

On Thu, Nov 13, 2025 at 03:46:22AM +0000, Carlos Llamas wrote:
> Commit 4dfd4bba8578 ("selftests/mm/uffd: refactor non-composite global
> vars into struct") moved some of the operations previously implemented
> in uffd_setup_environment() earlier in the main test loop.
> 
> The calculation of nr_pages, which involves a division by page_size, now
> occurs before checking that default_huge_page_size() returns a non-zero
> This leads to a division-by-zero error on systems with !CONFIG_HUGETLB.
> 
> Fix this by relocating the non-zero page_size check before the nr_pages
> calculation, as it was originally implemented.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4dfd4bba8578 ("selftests/mm/uffd: refactor non-composite global vars into struct")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Agree with what David and Lorenzo said about cc:stable.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  tools/testing/selftests/mm/uffd-unit-tests.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
> index 9e3be2ee7f1b..f917b4c4c943 100644
> --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> @@ -1758,10 +1758,15 @@ int main(int argc, char *argv[])
>  			uffd_test_ops = mem_type->mem_ops;
>  			uffd_test_case_ops = test->test_case_ops;
>  
> -			if (mem_type->mem_flag & (MEM_HUGETLB_PRIVATE | MEM_HUGETLB))
> +			if (mem_type->mem_flag & (MEM_HUGETLB_PRIVATE | MEM_HUGETLB)) {
>  				gopts.page_size = default_huge_page_size();
> -			else
> +				if (gopts.page_size == 0) {
> +					uffd_test_skip("huge page size is 0, feature missing?");
> +					continue;
> +				}
> +			} else {
>  				gopts.page_size = psize();
> +			}
>  
>  			/* Ensure we have at least 2 pages */
>  			gopts.nr_pages = MAX(UFFD_TEST_MEM_SIZE, gopts.page_size * 2)
> @@ -1776,12 +1781,6 @@ int main(int argc, char *argv[])
>  				continue;
>  
>  			uffd_test_start("%s on %s", test->name, mem_type->name);
> -			if ((mem_type->mem_flag == MEM_HUGETLB ||
> -			    mem_type->mem_flag == MEM_HUGETLB_PRIVATE) &&
> -			    (default_huge_page_size() == 0)) {
> -				uffd_test_skip("huge page size is 0, feature missing?");
> -				continue;
> -			}
>  			if (!uffd_feature_supported(test)) {
>  				uffd_test_skip("feature missing");
>  				continue;
> -- 
> 2.51.2.1041.gc1ab5b90ca-goog
> 

-- 
Sincerely yours,
Mike.

