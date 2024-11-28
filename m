Return-Path: <linux-kselftest+bounces-22596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9449DB30E
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 08:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C2B166716
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 07:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C90D146A60;
	Thu, 28 Nov 2024 07:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="h2tCvLvv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ACF1465BB;
	Thu, 28 Nov 2024 07:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732778078; cv=pass; b=Irzwhkpdv2N0vgRTQn1sZsj0jSTm+mQwkNYWbQ4ZmTfX55FiBWzywC3rQWRGhJ7ta42KTUSTN54zMVuS4pNBVm1kARur8SKVwwb8oa5RJCdwC8aFFiNC6AzQF+Ljm4PHXypdKgvEMJ8qM1qf8qyKio8fIpedHTYp5RF6MToBBIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732778078; c=relaxed/simple;
	bh=tmL/BbDrXII/jiOGN6m1fqalqJu2FmoPKTninfp85CY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IW+KDB+KQ2cKRXP8TgZqlx2P5tbyvz3Tll95KkF7xg7KYgxvTcwmnCfCj/eDd7bfEv6+km1KvtxAh/JUUONXGgl9WAofbzaHO7hJWEisXlHhJji86g/be9pyKaj1llQP0Fu9/paRkX9+84rHBmoDvWlCUQ80sokxIwSPWhZmZUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=h2tCvLvv; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732778064; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZdCZMsy0tphLYcOFhAnywRwl8maHptzuVv7YqX7lZswAeQD1ZE3dSfOFeaFX7F44dn4524W/uQ4yCjziQjqUqDVXodaLZc2F1DU11MWI4ahvPlT2KSWgbgTiJ2QXqN/vxf6b9gz3hggua7leuvH1qpm9nFELjzNtBO+9/sWMxtc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732778064; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TPFccF9v6m/sBu17V4GdTfoK4Rdz5Lz6IOiEO6hyXnk=; 
	b=Egn1nxgtae8jwHanulcCPaWS4NVBmGZI3QoSchaJ8c4BxsW5aZ8vIqWxAa2DI1UMD3Xa2C+3LL3gXdSME4T3yWWVyVi9LLhZ8JDGBwKGyiR2cKonLhdEZS6m8EWGa4ls6LX/vY6m5hAqcSDqKGg5kv70mZSn1vAvpOrZ37PQCGI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732778064;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=TPFccF9v6m/sBu17V4GdTfoK4Rdz5Lz6IOiEO6hyXnk=;
	b=h2tCvLvv12Us8V/VkyXdFQPoa4XlDhFUYcXq1dvqOCZv8krA4UdiZewCFQ9sdrPV
	vLHRAjzXQ3PRtmtfBQ9L8Y9mwE6yYrrmSKz+YrIFTUJHLMFcJWR/bqLAQ3K8rRGZfBS
	RIQDgJCTEnSTBEDa54MuLgvNYnirOyA436m55C7A=
Received: by mx.zohomail.com with SMTPS id 173277806331396.08722934617299;
	Wed, 27 Nov 2024 23:14:23 -0800 (PST)
Message-ID: <af74c8db-31d0-4d19-ac8b-3cd255620d78@collabora.com>
Date: Thu, 28 Nov 2024 12:14:23 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, "Ritesh Harjani (IBM)"
 <ritesh.list@gmail.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest: hugetlb_dio: Fix test naming
To: Mark Brown <broonie@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Donet Tom <donettom@linux.ibm.com>
References: <20241127-kselftest-mm-hugetlb-dio-names-v1-1-22aab01bf550@kernel.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241127-kselftest-mm-hugetlb-dio-names-v1-1-22aab01bf550@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 11/27/24 9:14 PM, Mark Brown wrote:
> The string logged when a test passes or fails is used by the selftest
> framework to identify which test is being reported. The hugetlb_dio test
> not only uses the same strings for every test that is run but it also uses
> different strings for test passes and failures which means that test
> automation is unable to follow what the test is doing at all.
> 
> Pull the existing duplicated logging of the number of free huge pages
> before and after the test out of the conditional and replace that and the
> logging of the result with a single ksft_print_result() which incorporates
> the parameters passed into the test into the output.
> 
> Fixes: fae1980347bf ("selftests: hugetlb_dio: fixup check for initial conditions to skip in the start")
> Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/mm/hugetlb_dio.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/hugetlb_dio.c b/tools/testing/selftests/mm/hugetlb_dio.c
> index 432d5af15e66b7d6cac0273fb244d6696d7c9ddc..db63abe5ee5e85ff7795d3ea176c3ac47184bf4f 100644
> --- a/tools/testing/selftests/mm/hugetlb_dio.c
> +++ b/tools/testing/selftests/mm/hugetlb_dio.c
> @@ -76,19 +76,15 @@ void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
>  	/* Get the free huge pages after unmap*/
>  	free_hpage_a = get_free_hugepages();
>  
> +	ksft_print_msg("No. Free pages before allocation : %d\n", free_hpage_b);
> +	ksft_print_msg("No. Free pages after munmap : %d\n", free_hpage_a);
> +
>  	/*
>  	 * If the no. of free hugepages before allocation and after unmap does
>  	 * not match - that means there could still be a page which is pinned.
>  	 */
> -	if (free_hpage_a != free_hpage_b) {
> -		ksft_print_msg("No. Free pages before allocation : %d\n", free_hpage_b);
> -		ksft_print_msg("No. Free pages after munmap : %d\n", free_hpage_a);
> -		ksft_test_result_fail(": Huge pages not freed!\n");
> -	} else {
> -		ksft_print_msg("No. Free pages before allocation : %d\n", free_hpage_b);
> -		ksft_print_msg("No. Free pages after munmap : %d\n", free_hpage_a);
> -		ksft_test_result_pass(": Huge pages freed successfully !\n");
> -	}
> +	ksft_test_result(free_hpage_a == free_hpage_b,
> +			 "free huge pages from %u-%u\n", start_off, end_off);
>  }
>  
>  int main(void)
> 
> ---
> base-commit: 6f3d2b5299b0a8bcb8a9405a8d3fceb24f79c4f0
> change-id: 20241127-kselftest-mm-hugetlb-dio-names-1ebccbe8183d
> 
> Best regards,


-- 
BR,
Muhammad Usama Anjum

