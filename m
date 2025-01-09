Return-Path: <linux-kselftest+bounces-24156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DB0A07F16
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 18:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15E4F188D836
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 17:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E4419ABDE;
	Thu,  9 Jan 2025 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOtnMP/o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE0318EFD4;
	Thu,  9 Jan 2025 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444536; cv=none; b=JdKwpDdp8jRjHMhSNynob/eDXtQzLRD6ONBOtMzAH+xqh2b2aRy4hnPL4M/X4KlEKz1g6WhfknzGGx4EzrsINM18NpQRpA6Rhe+rYZH0M7RX+n20xWaI0GGYY3EIB05nM9JmxouqKLapNl1rN6Y4ZbJc/PLY14i7a24XuBSFWBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444536; c=relaxed/simple;
	bh=Us90W3iK3EMl2dQQtMx3D2gQ07vdM1nJz7lej6pS6zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejC320jbTgUEMePXs6M7ETu7IA+KqPX5u5nh2t3MUAq6dhgIE0HKwXXlaO0Rvd2UlnI14ROi7EwIu/W/r2kz/uameKw7je+J5kfHn5ffn2CugzZs13BUAqjG4qSHEVGWBek5PVf75I70Z2Ti3KPCiejaaKezT0Ybt+tuyAcYOuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOtnMP/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4C7C4CED2;
	Thu,  9 Jan 2025 17:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736444535;
	bh=Us90W3iK3EMl2dQQtMx3D2gQ07vdM1nJz7lej6pS6zQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZOtnMP/oO3McloFa5SLz+G9ZVljZBA0nqYnJaei5CtAsRQhUdXICmBBb/nCFIIgov
	 Inkg4DhWFNFEgtWp5hQ3yBG+MHE4r8a0tD2weniDe8QvaLDeQ2LYPoAGL0X1/ei+to
	 6caOnkcawbG8Ps6CmvKVNkRbDMNiDJV7F9Hg/5P5T58hWAdlJ4otKcGr979EjvLxar
	 pW2sAFYQwV8ZasIygrNkuafNhH2NA6dIHdCLMjW3CnxjWZngK9fQhenpvVUCEdwXS/
	 6SRMru53hhYFyN924zPkl/leMURMaRI+eP6ZQ2Ki++wT+ojM9RYQteepsOvOzf6Rjk
	 PZipONnIClKGw==
Date: Thu, 9 Jan 2025 09:42:12 -0800
From: Kees Cook <kees@kernel.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel@collabora.com
Subject: Re: [PATCH 01/16] selftests/mm: remove argc and argv unused
 parameters
Message-ID: <202501090941.5289E7444B@keescook>
References: <20250109173842.1142376-1-usama.anjum@collabora.com>
 <20250109173842.1142376-2-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250109173842.1142376-2-usama.anjum@collabora.com>

On Thu, Jan 09, 2025 at 10:38:27PM +0500, Muhammad Usama Anjum wrote:
> Remove the following warnings by removing unused argc and argv
> parameters:
> In function ‘main’:
>   warning: unused parameter ‘argc’ [-Wunused-parameter]
>     158 | int main(int argc, char *argv[])
>         |          ~~~~^~~~
>   warning: unused parameter ‘argv’ [-Wunused-parameter]
>     158 | int main(int argc, char *argv[])
>         |                    ~~~~~~^~~~~~
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/mm/compaction_test.c       | 2 +-
>  tools/testing/selftests/mm/cow.c                   | 2 +-
>  tools/testing/selftests/mm/droppable.c             | 2 +-
>  tools/testing/selftests/mm/gup_longterm.c          | 2 +-
>  tools/testing/selftests/mm/hugepage-vmemmap.c      | 2 +-
>  tools/testing/selftests/mm/hugetlb-madvise.c       | 2 +-
>  tools/testing/selftests/mm/hugetlb-soft-offline.c  | 2 +-
>  tools/testing/selftests/mm/madv_populate.c         | 2 +-
>  tools/testing/selftests/mm/map_populate.c          | 2 +-
>  tools/testing/selftests/mm/memfd_secret.c          | 2 +-
>  tools/testing/selftests/mm/mlock-random-test.c     | 2 +-
>  tools/testing/selftests/mm/mlock2-tests.c          | 2 +-
>  tools/testing/selftests/mm/on-fault-limit.c        | 2 +-
>  tools/testing/selftests/mm/pkey_sighandler_tests.c | 2 +-
>  tools/testing/selftests/mm/soft-dirty.c            | 2 +-
>  tools/testing/selftests/mm/uffd-wp-mremap.c        | 2 +-
>  tools/testing/selftests/mm/virtual_address_range.c | 2 +-
>  17 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
> index 2c3a0eb6b22d3..8d23b698ce9db 100644
> --- a/tools/testing/selftests/mm/compaction_test.c
> +++ b/tools/testing/selftests/mm/compaction_test.c
> @@ -194,7 +194,7 @@ int set_zero_hugepages(unsigned long *initial_nr_hugepages)
>  	return ret;
>  }
>  
> -int main(int argc, char **argv)
> +int main(void)
>  {
>  	struct rlimit lim;
>  	struct map_list *list = NULL, *entry;
> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
> index 1238e1c5aae15..ea00c85c76caa 100644
> --- a/tools/testing/selftests/mm/cow.c
> +++ b/tools/testing/selftests/mm/cow.c
> @@ -1769,7 +1769,7 @@ static int tests_per_non_anon_test_case(void)
>  	return tests;
>  }
>  
> -int main(int argc, char **argv)
> +int main(void)
>  {
>  	int err;
>  	struct thp_settings default_settings;
> diff --git a/tools/testing/selftests/mm/droppable.c b/tools/testing/selftests/mm/droppable.c
> index f3d9ecf96890a..90ea6377810c5 100644
> --- a/tools/testing/selftests/mm/droppable.c
> +++ b/tools/testing/selftests/mm/droppable.c
> @@ -15,7 +15,7 @@
>  
>  #include "../kselftest.h"
>  
> -int main(int argc, char *argv[])
> +int main(void)
>  {
>  	size_t alloc_size = 134217728;
>  	size_t page_size = getpagesize();
> diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
> index 9423ad439a614..03a31dcb57577 100644
> --- a/tools/testing/selftests/mm/gup_longterm.c
> +++ b/tools/testing/selftests/mm/gup_longterm.c
> @@ -444,7 +444,7 @@ static int tests_per_test_case(void)
>  	return 3 + nr_hugetlbsizes;
>  }
>  
> -int main(int argc, char **argv)
> +int main(void)
>  {
>  	int i, err;
>  
> diff --git a/tools/testing/selftests/mm/hugepage-vmemmap.c b/tools/testing/selftests/mm/hugepage-vmemmap.c
> index df366a4d1b92d..23e97e552057d 100644
> --- a/tools/testing/selftests/mm/hugepage-vmemmap.c
> +++ b/tools/testing/selftests/mm/hugepage-vmemmap.c
> @@ -87,7 +87,7 @@ static int check_page_flags(unsigned long pfn)
>  	return 0;
>  }
>  
> -int main(int argc, char **argv)
> +int main(void)
>  {
>  	void *addr;
>  	unsigned long pfn;
> diff --git a/tools/testing/selftests/mm/hugetlb-madvise.c b/tools/testing/selftests/mm/hugetlb-madvise.c
> index e74107185324f..43f16c12c8e9a 100644
> --- a/tools/testing/selftests/mm/hugetlb-madvise.c
> +++ b/tools/testing/selftests/mm/hugetlb-madvise.c
> @@ -58,7 +58,7 @@ void read_fault_pages(void *addr, unsigned long nr_pages)
>  	}
>  }
>  
> -int main(int argc, char **argv)
> +int main(int __attribute__((unused)) argc, char **argv)

Can we add a macro in kselftest.h for "__unused" like the kernel already
does? Then instead of removing args, we can just mark them, like you're
doing here.

-- 
Kees Cook

