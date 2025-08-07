Return-Path: <linux-kselftest+bounces-38450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BEFB1D4B0
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 11:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30FD53AABA1
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 09:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696B2221FA0;
	Thu,  7 Aug 2025 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dlGa+2if"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9BE1400C
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754558832; cv=none; b=UPJyO5/CX9YQbRbP0tLfXEgCUbddm2csNWcgEBIniB3vQfbwiZIJt9ACGdT0Nz+otntr4bxFKdt2ETCtfQ5BLx5o8g/vPiS3tmSfn9DQ06LJ3bFoe3l7OodurSA0OpGbuzsXLV8vfcw/AT2/Uc4ebJpvsRifL7VLUPy+VpAWOT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754558832; c=relaxed/simple;
	bh=8CfVOkhAAmGGm6j25CwkzFbvrOq5XlVOCI5MiKmWyHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkuvY8n1gR4XJlQHTzrF/SBB2nPs8ovYtWdgzZ44hxjQT9bgT9pJW+n4fW1NJsMyueNw7FGMxv2/gV0dXrZHdG71vWOBF2Axbp7HSoO1keqhmWplXxia6jdOCCWoJa1Hjq+GXXhJ8g5g1eruFYrl2xHYrcMiK1CeKxOlvVlQhQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dlGa+2if; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754558820; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=nxgz8RoatRrFV2R2BwY+A1zvAnqo3di4K/3GatoR9Eg=;
	b=dlGa+2ifeIa6HEkfBfyF9QEo54wcN+v7VPzRXbPawdjBY8Qd2mzUc9WcvlqHAejcDHT3/4cI85t1u92fLs76Q7SigE83UKWrGYx6gJ2+2YE5Z6jwql2W7Wv1wZdULzTzVdwcU5iPNDsQVL36uJk/OG+Rb7bhdMRfs3rD4dDCV7g=
Received: from 30.74.144.111(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WlDoMn3_1754558819 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Aug 2025 17:26:59 +0800
Message-ID: <face9324-e4c3-45d6-9fa4-a2e8244379df@linux.alibaba.com>
Date: Thu, 7 Aug 2025 17:26:59 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: do check_huge_anon() with a number been
 passed in
To: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
 david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 dev.jain@arm.com
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250807082707.30647-1-richard.weiyang@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250807082707.30647-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/8/7 16:27, Wei Yang wrote:
> Currently it hard coded the number of hugepage to check for
> check_huge_anon(), but we already have the number passed in.
> 
> Do the check based on the number of hugepage passed in is more
> reasonable.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---

Yes. LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

>   tools/testing/selftests/mm/split_huge_page_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index 44a3f8a58806..bf40e6b121ab 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -111,7 +111,7 @@ static void verify_rss_anon_split_huge_page_all_zeroes(char *one_page, int nr_hp
>   	unsigned long rss_anon_before, rss_anon_after;
>   	size_t i;
>   
> -	if (!check_huge_anon(one_page, 4, pmd_pagesize))
> +	if (!check_huge_anon(one_page, nr_hpages, pmd_pagesize))
>   		ksft_exit_fail_msg("No THP is allocated\n");
>   
>   	rss_anon_before = rss_anon();


