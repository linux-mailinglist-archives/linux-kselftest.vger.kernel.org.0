Return-Path: <linux-kselftest+bounces-22390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D1B9D49B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 10:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2B9281059
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 09:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D141CB31C;
	Thu, 21 Nov 2024 09:14:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056E44206E;
	Thu, 21 Nov 2024 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180499; cv=none; b=oGPrxh8eBAN7A2pDCkOKqeSKldVbrBeFPD3IhFrepSn2ucAbm4gDPOtf9uunKDDxPWfeP9d8EHseqrp6Xuk4sOW6klpRwQbdXZoI3yvIGu+P79kMIZCetkTTa0z+L4OBdRJ7x9PPK6Aa4Sh4BYxDBoLGjaNLZiz9vmoTyiiB4WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180499; c=relaxed/simple;
	bh=HC+FClx8+FFEcf2S1sO5cNwBgI+xwZmAbAIZHTFgOfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=exK/mlrHQLgsYiMTsw89eyLFslWwBzQhOINdDTfDmQjQuoDHDiN4HfgVSh5FeO+aF62QpzsK298pmvHlE1TfDyymwtZlrDSzgaVAvQoVVLwkiFl7lchoejtETzEnynmrq6BcZ7WGErw4kM4J8JseQFGpGZpgRCHibZQtofsg9v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee3673efa0ed88-2c5b0;
	Thu, 21 Nov 2024 17:14:54 +0800 (CST)
X-RM-TRANSID:2ee3673efa0ed88-2c5b0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [172.20.230.59] (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee6673efa0d35c-d5849;
	Thu, 21 Nov 2024 17:14:54 +0800 (CST)
X-RM-TRANSID:2ee6673efa0d35c-d5849
Message-ID: <291c5d58-9681-49bc-b5c4-3ee4555d68bd@cmss.chinamobile.com>
Date: Thu, 21 Nov 2024 17:14:53 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests: mm: Fix conversion specifiers
 intransact_test()
To: Muhammad Usama Anjum <Usama.Anjum@collabora.com>,
 akpm@linux-foundation.org, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241117071231.177864-1-guanjing@cmss.chinamobile.com>
 <a2b65507-90dd-4586-9881-4ce5b310c2a8@collabora.com>
From: guanjing <guanjing@cmss.chinamobile.com>
In-Reply-To: <a2b65507-90dd-4586-9881-4ce5b310c2a8@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I found it when reading the code. So far, I haven't found any tools that 
can be used for scanning yet. :)

Thank you for your review.


On 2024/11/19 15:33, Muhammad Usama Anjum wrote:
> Thanks for the patch.
>
>
> On 11/17/24 12:12 PM, guanjing wrote:
>> Lots of incorrect conversion specifiers. Fix them.
> Not sure why I'd not got warnings. Just curious, how were you able
> to notice these warnings?
>
>> Fixes: 46fd75d4a3c9 ("selftests: mm: add pagemap ioctl tests")
>> Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>
>> ---
>>   tools/testing/selftests/mm/pagemap_ioctl.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
>> index bcc73b4e805c..fdafce0654e9 100644
>> --- a/tools/testing/selftests/mm/pagemap_ioctl.c
>> +++ b/tools/testing/selftests/mm/pagemap_ioctl.c
>> @@ -1405,9 +1405,9 @@ static void transact_test(int page_size)
>>   	memset(mem, 0, 0x1000 * nthreads * pages_per_thread);
>>   
>>   	count = get_dirty_pages_reset(mem, nthreads * pages_per_thread, 1, page_size);
>> -	ksft_test_result(count > 0, "%s count %d\n", __func__, count);
>> +	ksft_test_result(count > 0, "%s count %u\n", __func__, count);
>>   	count = get_dirty_pages_reset(mem, nthreads * pages_per_thread, 1, page_size);
>> -	ksft_test_result(count == 0, "%s count %d\n", __func__, count);
>> +	ksft_test_result(count == 0, "%s count %u\n", __func__, count);
>>   
>>   	finish = 0;
>>   	for (i = 0; i < nthreads; ++i)
>> @@ -1429,7 +1429,7 @@ static void transact_test(int page_size)
>>   			ksft_exit_fail_msg("pthread_barrier_wait\n");
>>   
>>   		if (count > nthreads * access_per_thread)
>> -			ksft_exit_fail_msg("Too big count %d expected %d, iter %d\n",
>> +			ksft_exit_fail_msg("Too big count %u expected %u, iter %u\n",
>>   					   count, nthreads * access_per_thread, i);
>>   
>>   		c = get_dirty_pages_reset(mem, nthreads * pages_per_thread, 1, page_size);
>> @@ -1454,7 +1454,7 @@ static void transact_test(int page_size)
>>   			 * access and application gets page fault again for the same write.
>>   			 */
>>   			if (count < nthreads * access_per_thread) {
>> -				ksft_test_result_fail("Lost update, iter %d, %d vs %d.\n", i, count,
>> +				ksft_test_result_fail("Lost update, iter %u, %u vs %u.\n", i, count,
>>   						      nthreads * access_per_thread);
>>   				return;
>>   			}
>> @@ -1467,7 +1467,7 @@ static void transact_test(int page_size)
>>   	finish = 1;
>>   	pthread_barrier_wait(&end_barrier);
>>   
>> -	ksft_test_result_pass("%s Extra pages %u (%.1lf%%), extra thread faults %d.\n", __func__,
>> +	ksft_test_result_pass("%s Extra pages %u (%.1lf%%), extra thread faults %u.\n", __func__,
>>   			      extra_pages,
>>   			      100.0 * extra_pages / (iter_count * nthreads * access_per_thread),
>>   			      extra_thread_faults);



