Return-Path: <linux-kselftest+bounces-22236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C679D20CC
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 08:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43FD7281D5A
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 07:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D6413D8B4;
	Tue, 19 Nov 2024 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="TTdseIW0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E821482E7;
	Tue, 19 Nov 2024 07:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732001624; cv=pass; b=n6GW/gRsHgiL83GU7LO6HAMWuZzqSP76T7b+ViCzBULAm6SO/S4R17qsv081P46siyyNJWILOF3zgL9Npf1OujDzBe7uKqabeWY9pqoKnDET/bfwG/dQoLA/rJKpObetV6mf7/cis0v78ICdMjxoRY6sUbrIeKIRVa/O8UKRqA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732001624; c=relaxed/simple;
	bh=gyMKy7B8XnHJT09tLz+un48n1fpuwrmZ+zvt7xYFBCA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nOGzKFtd0JIj9dBLscTmjIq9aXhiFjflUKYRTjKI7+dJ32/9Ri2gtQ9NSIZAr7zzCll/SsLyLnP3AuXwmwZ7jryX3OkYz29GOGsGLpgMb/wVCJn9L8FdgP2tmmvu/2nqRqRmy2fRYbzBt0q+GSJsQd2r4pqmh8sgAZx+Qq0FeSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=TTdseIW0; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732001613; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FqSMj7HjTsSlcvciFavxg1iw3DHGa2Wbe86aBZwjF/PbhXOYnJ5dimepJWna7NSrPAyz6ZbRMt99kd+syyt1AsL+bDsASAJOFLkN4GHkfKMZkJE9dO777vqw1/7HuhWs3/Lk45ofwucSHKzCCfuDmEVNM1YrPFw1y9+6I+ks4vk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732001613; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=V0VhltE9D84zoEQReeG3UtZh0sIaLOoAlUJ1PgycXtk=; 
	b=MC0FW1X4t1QijWk98SxRKHnQjvVLkov+hXqMEoinJT2IEsWlJEaZt7t5FuhrlCSolldsKI2mQ20MEZn7VCXNgbUyC/TsnCzKVB1B/4/Xlivn71rUVn/cU2NcGytnbwWdiZGNuzTnw78/qxL93M0Knczgbt1JzKSHX7qlfTj1HEM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732001613;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=V0VhltE9D84zoEQReeG3UtZh0sIaLOoAlUJ1PgycXtk=;
	b=TTdseIW0XugnX3fqnKRtxDP0KX4KjqMB4GILswxXkQO0Azqg9mgTRrQkcYWa+7Pv
	MgpQzL7sCe7tx8yBc7tBe9JEqKfKbXeCDBlPo8mcLy/WaXBcYNKZIc3hcHNPRbKcDgZ
	e/aQ2xBqRwA7f4gbLki3ngSyyYmwBvYlwKs+f4dg=
Received: by mx.zohomail.com with SMTPS id 1732001610855805.8789534804719;
	Mon, 18 Nov 2024 23:33:30 -0800 (PST)
Message-ID: <a2b65507-90dd-4586-9881-4ce5b310c2a8@collabora.com>
Date: Tue, 19 Nov 2024 12:33:28 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] selftests: mm: Fix conversion specifiers in
 transact_test()
To: guanjing <guanjing@cmss.chinamobile.com>, akpm@linux-foundation.org,
 shuah@kernel.org
References: <20241117071231.177864-1-guanjing@cmss.chinamobile.com>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241117071231.177864-1-guanjing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Thanks for the patch.


On 11/17/24 12:12 PM, guanjing wrote:
> Lots of incorrect conversion specifiers. Fix them.
Not sure why I'd not got warnings. Just curious, how were you able
to notice these warnings?

> 
> Fixes: 46fd75d4a3c9 ("selftests: mm: add pagemap ioctl tests")
> Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/mm/pagemap_ioctl.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
> index bcc73b4e805c..fdafce0654e9 100644
> --- a/tools/testing/selftests/mm/pagemap_ioctl.c
> +++ b/tools/testing/selftests/mm/pagemap_ioctl.c
> @@ -1405,9 +1405,9 @@ static void transact_test(int page_size)
>  	memset(mem, 0, 0x1000 * nthreads * pages_per_thread);
>  
>  	count = get_dirty_pages_reset(mem, nthreads * pages_per_thread, 1, page_size);
> -	ksft_test_result(count > 0, "%s count %d\n", __func__, count);
> +	ksft_test_result(count > 0, "%s count %u\n", __func__, count);
>  	count = get_dirty_pages_reset(mem, nthreads * pages_per_thread, 1, page_size);
> -	ksft_test_result(count == 0, "%s count %d\n", __func__, count);
> +	ksft_test_result(count == 0, "%s count %u\n", __func__, count);
>  
>  	finish = 0;
>  	for (i = 0; i < nthreads; ++i)
> @@ -1429,7 +1429,7 @@ static void transact_test(int page_size)
>  			ksft_exit_fail_msg("pthread_barrier_wait\n");
>  
>  		if (count > nthreads * access_per_thread)
> -			ksft_exit_fail_msg("Too big count %d expected %d, iter %d\n",
> +			ksft_exit_fail_msg("Too big count %u expected %u, iter %u\n",
>  					   count, nthreads * access_per_thread, i);
>  
>  		c = get_dirty_pages_reset(mem, nthreads * pages_per_thread, 1, page_size);
> @@ -1454,7 +1454,7 @@ static void transact_test(int page_size)
>  			 * access and application gets page fault again for the same write.
>  			 */
>  			if (count < nthreads * access_per_thread) {
> -				ksft_test_result_fail("Lost update, iter %d, %d vs %d.\n", i, count,
> +				ksft_test_result_fail("Lost update, iter %u, %u vs %u.\n", i, count,
>  						      nthreads * access_per_thread);
>  				return;
>  			}
> @@ -1467,7 +1467,7 @@ static void transact_test(int page_size)
>  	finish = 1;
>  	pthread_barrier_wait(&end_barrier);
>  
> -	ksft_test_result_pass("%s Extra pages %u (%.1lf%%), extra thread faults %d.\n", __func__,
> +	ksft_test_result_pass("%s Extra pages %u (%.1lf%%), extra thread faults %u.\n", __func__,
>  			      extra_pages,
>  			      100.0 * extra_pages / (iter_count * nthreads * access_per_thread),
>  			      extra_thread_faults);

-- 
BR,
Muhammad Usama Anjum


