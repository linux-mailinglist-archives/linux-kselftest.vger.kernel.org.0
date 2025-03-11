Return-Path: <linux-kselftest+bounces-28692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F34D0A5B81C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 05:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94AA3B015F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 04:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0291EB5C9;
	Tue, 11 Mar 2025 04:53:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF6E1DFE22;
	Tue, 11 Mar 2025 04:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741668828; cv=none; b=Kw769KH1mWKLbdozIQ3oRMAF94cuqvV1wISKzXLPHTv6UqE2W3P6/vRRv1wQgLJae5zbox9q6igapQwTDMHTu6DVaM0r+sQlbZO838uivi2JssvTt8zpOM1FozLjt0jDbAXk1qPSBwLnYuh8IqdDUARZIharDVcAv9YyqDFjoNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741668828; c=relaxed/simple;
	bh=oR7WyXSXrXzDskpI6SIUSj6ACdxCa+8Rzj5ezUgeZDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gXBEcocwL6pQS0Bdapa5HXF6PFDq0URmIaxov3UyFtVWfZgQkSHALdt2bfbDR69dqFBpW0pSaZr2bAMCmSIJ04PNMdMHCrJlg08dMQDTqmEFjg2kDyPQ1jTyAxMDD3uEQRf6hFlNiAa9CS5B1kHvh032wkXqSIDHesXsdXDUF7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F5861516;
	Mon, 10 Mar 2025 21:53:51 -0700 (PDT)
Received: from [10.174.36.193] (unknown [10.174.36.193])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C0813F694;
	Mon, 10 Mar 2025 21:53:37 -0700 (PDT)
Message-ID: <f3c0e925-4f71-4051-9f13-57169f1be960@arm.com>
Date: Tue, 11 Mar 2025 10:23:34 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm/cow: Fix the incorrect error handling
To: Cyan Yang <cyan.yang@sifive.com>, akpm@linux-foundation.org,
 shuah@kernel.org, david@redhat.com
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250311023730.56658-1-cyan.yang@sifive.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250311023730.56658-1-cyan.yang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/03/25 8:07 am, Cyan Yang wrote:
> There are two error handlings did not check the correct return value.
> This patch will fix them.
> 
> Fixes: f4b5fd6946e244cdedc3bbb9a1f24c8133b2077a ("selftests/vm: anon_cow: THP tests")
> Signed-off-by: Cyan Yang <cyan.yang@sifive.com>
> ---
>   tools/testing/selftests/mm/cow.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
> index 9446673645eb..16fcadc090a4 100644
> --- a/tools/testing/selftests/mm/cow.c
> +++ b/tools/testing/selftests/mm/cow.c
> @@ -876,13 +876,13 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
>   		mremap_size = thpsize / 2;
>   		mremap_mem = mmap(NULL, mremap_size, PROT_NONE,
>   				  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> -		if (mem == MAP_FAILED) {
> +		if (mremap_mem == MAP_FAILED) {
>   			ksft_test_result_fail("mmap() failed\n");
>   			goto munmap;
>   		}
>   		tmp = mremap(mem + mremap_size, mremap_size, mremap_size,
>   			     MREMAP_MAYMOVE | MREMAP_FIXED, mremap_mem);
> -		if (tmp != mremap_mem) {

This is fine. We are checking whether we were able to mremap tmp to 
mremap_mem.

> +		if (tmp == MAP_FAILED) {
>   			ksft_test_result_fail("mremap() failed\n");
>   			goto munmap;
>   		}


