Return-Path: <linux-kselftest+bounces-38654-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC645B1FEDC
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 07:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19149189AD19
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 05:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B337626E179;
	Mon, 11 Aug 2025 05:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kvZCkQOL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085C9270545
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 05:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754891896; cv=none; b=oD7Dyirf+ebXYDEmPhamYHamMgKY8yvVOP49Rn4AESmXOrKCg+sURqs0V7xjxXwT2GtjPxUCdGP6W3IatApGF84RorjRJPXHmlvzUT9OEdkY4SgGNkDewkpZyZVgBBt4RsP+c5EimjQvKUHherVrUsNT7L1F6KEU3x+TYFWzX70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754891896; c=relaxed/simple;
	bh=TnS+qxAbGYnyXaQohT5QLTrltIbO6CKtenOY68Rl3dQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dvfBOxEYUYy9/zI4vZzXi+skRdRtYeNZNHXbi9Yukv21+Ip8Q44H7+8Olen8nLplXz5FBjGTRtZXCtqhfDtaeDvVl4CE2VOWZ5lEEXBhukHYydRIa509l0aR6Fh7ueYGQrReRSr81C0ANOcO86UQ1KYJyf2bdIvxCWYMfLW6pQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kvZCkQOL; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754891884; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0C3hCm+JNiGuI6HbOQmG4qjQ3sCeDoELSpNLPNRDQso=;
	b=kvZCkQOL1Cl6L6V0xmn9KsrNieVMoCjDvaOCSuWbNGUSthh7yrAnxfQ/ECLqVFwh5k6K/AIZnSRB1pbzzHCdwdFk9LTJ4kc4ScWxIiO2uOWE+MkEDFh4P00gq83Vwt85U+frfyFMkSkTNec917gIshW2f7xRBVxECNVKrsC6Ne8=
Received: from 30.74.144.118(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WlP-qS3_1754891883 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Aug 2025 13:58:04 +0800
Message-ID: <791ef594-a2e4-4d21-bb9a-970ad32c252f@linux.alibaba.com>
Date: Mon, 11 Aug 2025 13:58:03 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] selftests/mm: do check_huge_anon() with a number been
 passed in
To: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 Donet Tom <donettom@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Dev Jain <dev.jain@arm.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Zi Yan <ziy@nvidia.com>
References: <20250809194209.30484-1-richard.weiyang@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250809194209.30484-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/8/10 03:42, Wei Yang wrote:
> Currently it hard codes the number of hugepage to check for
> check_huge_anon(), but it would be more reasonable to do the check based
> on a number passed in.
> 
> Pass in the hugepage number and do the check based on it.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Donet Tom <donettom@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
> 
> ---
> v2:
>    * use mm-new
>    * add back nr_hpages which is removed by an early commit
>    * adjust the change log a little
>    * drop RB and resend
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

>   tools/testing/selftests/mm/split_huge_page_test.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index 5ab488fab1cd..63ac82f0b9e0 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -105,12 +105,12 @@ static char *allocate_zero_filled_hugepage(size_t len)
>   	return result;
>   }
>   
> -static void verify_rss_anon_split_huge_page_all_zeroes(char *one_page, size_t len)
> +static void verify_rss_anon_split_huge_page_all_zeroes(char *one_page, int nr_hpages, size_t len)
>   {
>   	unsigned long rss_anon_before, rss_anon_after;
>   	size_t i;
>   
> -	if (!check_huge_anon(one_page, 4, pmd_pagesize))
> +	if (!check_huge_anon(one_page, nr_hpages, pmd_pagesize))
>   		ksft_exit_fail_msg("No THP is allocated\n");
>   
>   	rss_anon_before = rss_anon();
> @@ -141,7 +141,7 @@ void split_pmd_zero_pages(void)
>   	size_t len = nr_hpages * pmd_pagesize;
>   
>   	one_page = allocate_zero_filled_hugepage(len);
> -	verify_rss_anon_split_huge_page_all_zeroes(one_page, len);
> +	verify_rss_anon_split_huge_page_all_zeroes(one_page, nr_hpages, len);
>   	ksft_test_result_pass("Split zero filled huge pages successful\n");
>   	free(one_page);
>   }


