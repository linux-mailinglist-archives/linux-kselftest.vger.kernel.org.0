Return-Path: <linux-kselftest+bounces-39206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD2BB29BB6
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 10:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450AF18A75A1
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 08:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A71C2FC871;
	Mon, 18 Aug 2025 08:10:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D3D2FC869;
	Mon, 18 Aug 2025 08:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755504646; cv=none; b=a1eh/eu/8VlpXtGE+YxykVcrNQXORv1SHgmMEqaADsv33qPsHTwWq2q4EnUIgBdQG2kQp/Zsval0gZJmQ3MErszBFuf7oHStVsua8ae35rL7flCUOp9AFSZa8/G3NkLqSbTn3r3zIOrtCcQ2u+wQfb6VD4T6ICWgTFmMZkIew7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755504646; c=relaxed/simple;
	bh=rTPslaTDUAs47CsYS6djkjgqvnvRgbpSeyDSRLp0Tjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rqn0lL9RVpJDSptIEE23wA7BTpEl2fSPmnjc+jFH8UzUgi2ApEIf1mUgpeACXj/th/HoMyJnoK4N+11Ckly8JftYB1iEr0oj6Nh/R+9EwB+SME4B2WB/OubX+arJVhirAH88LMK8H5GKGF5ee8gJzZ4gfl2LhIhLqKCEZRGuUiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A5491596;
	Mon, 18 Aug 2025 01:10:36 -0700 (PDT)
Received: from [10.57.58.12] (unknown [10.57.58.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2E943F63F;
	Mon, 18 Aug 2025 01:10:38 -0700 (PDT)
Message-ID: <c09a2a13-8571-44e5-b780-c704598df764@arm.com>
Date: Mon, 18 Aug 2025 10:10:36 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] selftests/mm: Add -Wunreachable-code and fix
 warnings
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
 <20250731160132.1795351-2-usama.anjum@collabora.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20250731160132.1795351-2-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/07/2025 18:01, Muhammad Usama Anjum wrote:
> [...]
>
> diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testing/selftests/mm/pkey_sighandler_tests.c
> index b5e076a564c95..302fef54049c8 100644
> --- a/tools/testing/selftests/mm/pkey_sighandler_tests.c
> +++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
> @@ -41,7 +41,7 @@ static siginfo_t siginfo = {0};
>   * syscall will attempt to access the PLT in order to call a library function
>   * which is protected by MPK 0 which we don't have access to.
>   */
> -static inline __always_inline
> +static __always_inline

Thanks for this, I had this fix locally but never got to post it!

>  long syscall_raw(long n, long a1, long a2, long a3, long a4, long a5, long a6)
>  {
>  	unsigned long ret;
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index 05de1fc0005b7..a85b2e393e4e8 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -296,10 +296,8 @@ void split_file_backed_thp(int order)
>  		ksft_exit_fail_msg("Unable to create a tmpfs for testing\n");
>  
>  	status = snprintf(testfile, INPUT_MAX, "%s/thp_file", tmpfs_loc);
> -	if (status >= INPUT_MAX) {
> +	if (status >= INPUT_MAX)
>  		ksft_exit_fail_msg("Fail to create file-backed THP split testing file\n");
> -		goto cleanup;

At that point the mount() call has succeeded so I think we do want to
keep the goto and just print the error message instead of calling
replace ksft_exit_fail_msg().

- Kevin

> -	}
>  
>  	fd = open(testfile, O_CREAT|O_RDWR, 0664);
>  	if (fd == -1) {

