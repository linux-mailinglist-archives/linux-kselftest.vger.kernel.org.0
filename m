Return-Path: <linux-kselftest+bounces-39208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0244B29BD7
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 10:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A259189AF19
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 08:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573FC2FE048;
	Mon, 18 Aug 2025 08:16:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9B42FD7DF;
	Mon, 18 Aug 2025 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755505005; cv=none; b=h5jv7UsfJYc7fuNuHofRWgggKTBn6eiBLjKav/FMP2NijVw9Q1+hftYsI1clKKEkfNz0Zm+FUZaTbR/vU+v2nu+6WCapNVhFKvhBWevUZ47kftVY917yg3rKEb4whiBhnzgBaCb/zYRbPWzyhRKhNFEtUE2QnLfGE9ioKhcKOfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755505005; c=relaxed/simple;
	bh=ces16Fpyb7Ua0ix+oniaSESNqUAuKOPv+JF6AZ1J6pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=em0yVdNVe9R9e+UzEfdDEW1fgEX5Igf9TXd7pPInZINoEbzUCyAPuFZip9lYs1s7SHAZpfe5Yjpboyi0a8DnYZGIFjMSzy99LtJCW3m34i52kM/YzKiheSoUzJNTS2ZAVI/Bpt2g8uNtdiVOpT6FpgKzEatpcbuWFJ/sNDoVpmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 035E21596;
	Mon, 18 Aug 2025 01:16:35 -0700 (PDT)
Received: from [10.57.58.12] (unknown [10.57.58.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B04543F63F;
	Mon, 18 Aug 2025 01:16:37 -0700 (PDT)
Message-ID: <57c816d6-a9ba-47c9-8f40-3978580b7f67@arm.com>
Date: Mon, 18 Aug 2025 10:16:35 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] selftests/mm: Add -Wunused family of flags
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Leon Romanovsky <leon@kernel.org>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com
References: <20250731160132.1795351-1-usama.anjum@collabora.com>
 <20250731160132.1795351-5-usama.anjum@collabora.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20250731160132.1795351-5-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/07/2025 18:01, Muhammad Usama Anjum wrote:
> [...]
>
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 23d4bf6215465..d75f1effcb791 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -20,7 +20,6 @@ endif
>  # thus tricking Make (and you!) into believing that All Is Well, in subsequent
>  # make invocations:
>  .DELETE_ON_ERROR:
> -
>  # Avoid accidental wrong builds, due to built-in rules working just a little
>  # bit too well--but not quite as well as required for our situation here.
>  #
> @@ -35,6 +34,7 @@ MAKEFLAGS += --no-builtin-rules
>  
>  CFLAGS = -Wall -O2 -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
>  CFLAGS += -Wunreachable-code
> +CFLAGS += -Wunused  -Wunused-parameter -Wunused-function -Wunused-label -Wunused-variable -Wunused-value

-Wall implies all of these except -Wunused-parameter (at least according
to gcc(1)).

As to -Wunused-parameter I am frankly not convinced it's worth the
hassle. We're getting 90 lines changed in patch 6-8 just to mark
parameters as unused, in other words noise to keep the compiler happy.
It is not enabled by default in the kernel proper precisely because it
is so noisy when callbacks are involved.

Patch 5 is clearly an improvement, but I'd rather take it without
actually enabling -Wunused-parameter. The rest of this patch isn't that
useful either IMHO.

- Kevin

