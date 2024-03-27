Return-Path: <linux-kselftest+bounces-6704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF65888DC78
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 12:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0161C23A5B
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 11:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AD86F50F;
	Wed, 27 Mar 2024 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QCr01ppK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813446E61C;
	Wed, 27 Mar 2024 11:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538701; cv=none; b=BLKEKbbHpAYrGNhwB1kYUo8Mz+ZVIItnDBPewebD+O2zd7eOcHyADIekE/fWXs0LhFoQ/iX/6EaC5LHEdoDTx+K2kW1W6JKxUGBMNEgKvdAhN6u+pziFFnf012k4fLBB0bDrenqcCQruNP2mxEbxiwej9H498B10AUdPXW2J+4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538701; c=relaxed/simple;
	bh=h2u27KTeiE01TCjsx9AXusXC004jGvE5rQthtYa9ijg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O2Aagv56iW1xEgU95wc33FX8zypGP6IfmldRZMQ2GhZ8+UqtV4TFZwwI59E+UBPse6m5F48eq9ItQaqfyq6vDh0w/Yg7iHK5qdurg2NH5VyCsimlk0RyGKyY43L9Ar6slUiHaxaBiUFM38erIrqJT2WgvNpeFhYosiS+NU3fw50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QCr01ppK; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711538697;
	bh=h2u27KTeiE01TCjsx9AXusXC004jGvE5rQthtYa9ijg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=QCr01ppK1SB2QYzDRd2x3fZZTxilfWxtRZPhqdr5KcBzndBclTZjIXBOcMGmggZfb
	 oHpMyWbcrSQnmGL7+8gf+aCGuKoUvgMwWHjIABjmI3bZOFhmt0zggN5lN5GS6OROPJ
	 ApRna3LioVMj2/2aSyolAScvrhAXSWV91d52dD+oiECttaNnfAZA/RGIqJlU90ywax
	 c4M4CJSsoO5PQQjP8ILx04embL7sjHZSmqxT0loyiK2+fmDOuKT/IUn3sT5jer1jU+
	 yXddWqScfwr1hcs89ZVOV5sBT68AxFDN31MdysqfyFJAT5nVAadK2TJBgYie8RTq9P
	 HOQYejj+b4eug==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3BB593780480;
	Wed, 27 Mar 2024 11:24:54 +0000 (UTC)
Message-ID: <59a92e7f-321c-40e1-8e6e-1dcc0035cbed@collabora.com>
Date: Wed, 27 Mar 2024 16:25:25 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] selftests/dmabuf-heap: conform test to TAP format
 output
Content-Language: en-US
To: Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>,
 "T.J. Mercier" <tjmercier@google.com>
References: <20240305060848.2478806-1-usama.anjum@collabora.com>
 <387a04c3-356e-4248-9cd3-7aa1a617c221@linuxfoundation.org>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <387a04c3-356e-4248-9cd3-7aa1a617c221@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Shuah,

Thanks for reviewing.

On 3/27/24 2:05 AM, Shuah Khan wrote:
> On 3/4/24 23:08, Muhammad Usama Anjum wrote:
>> Conform the layout, informational and status messages to TAP. No
>> functional change is intended other than the layout of output messages.
>>
>> Reviewed-by: T.J. Mercier <tjmercier@google.com>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes since v4:
>> - close fds correctly with code changes added in v3
>>
>> Chanages since v3:
>> - abort test-case instead of exiting if heap/mem allocation fails
>> - Correct test_alloc_zeroed() test case in case of failure
>>
>> Changes since v2:
>> - Minor improvements in test_alloc_zeroed() results
>>
>> Changes since v1:
>> - Update some more error handling code
> 
> t would be nice to improve the error messages in addition to
> changing them over to TAP format. Please see below:
I'll update and send the this patch as v6.

> 
>> ---
>>   .../selftests/dmabuf-heaps/dmabuf-heap.c      | 246 +++++++-----------
>>   1 file changed, 101 insertions(+), 145 deletions(-)
>>
>> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
>> b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
>> index 890a8236a8ba7..e7bd03e0af2ea 100644
>> --- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
>> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
>> @@ -15,6 +15,7 @@
>>   #include <linux/dma-buf.h>
>>   #include <linux/dma-heap.h>
>>   #include <drm/drm.h>
>> +#include "../kselftest.h"
>>     #define DEVPATH "/dev/dma_heap"
>>   @@ -90,14 +91,13 @@ static int dmabuf_heap_open(char *name)
>>       char buf[256];
>>         ret = snprintf(buf, 256, "%s/%s", DEVPATH, name);
>> -    if (ret < 0) {
>> -        printf("snprintf failed!\n");
>> -        return ret;
>> -    }
>> +    if (ret < 0)
>> +        ksft_exit_fail_msg("snprintf failed!\n");
> 
> Why not include the return value in the message?
> 
>>         fd = open(buf, O_RDWR);
>>       if (fd < 0)
>> -        printf("open %s failed!\n", buf);
>> +        ksft_exit_fail_msg("open %s failed: %s\n", buf, strerror(errno));
>> +
>>       return fd;
>>   }
>>   @@ -140,7 +140,7 @@ static int dmabuf_sync(int fd, int start_stop)
>>     #define ONE_MEG (1024 * 1024)
>>   -static int test_alloc_and_import(char *heap_name)
>> +static void test_alloc_and_import(char *heap_name)
>>   {
>>       int heap_fd = -1, dmabuf_fd = -1, importer_fd = -1;
>>       uint32_t handle = 0;
>> @@ -148,27 +148,19 @@ static int test_alloc_and_import(char *heap_name)
>>       int ret;
>>         heap_fd = dmabuf_heap_open(heap_name);
>> -    if (heap_fd < 0)
>> -        return -1;
>>   -    printf("  Testing allocation and importing:  ");
>> +    ksft_print_msg("Testing allocation and importing:\n");
>>       ret = dmabuf_heap_alloc(heap_fd, ONE_MEG, 0, &dmabuf_fd);
>>       if (ret) {
>> -        printf("FAIL (Allocation Failed!)\n");
>> -        ret = -1;
>> -        goto out;
>> +        ksft_test_result_fail("FAIL (Allocation Failed!)\n");
> 
> Same here/
> 
>> +        return;
>>       }
>> +
>>       /* mmap and write a simple pattern */
>> -    p = mmap(NULL,
>> -         ONE_MEG,
>> -         PROT_READ | PROT_WRITE,
>> -         MAP_SHARED,
>> -         dmabuf_fd,
>> -         0);
>> +    p = mmap(NULL, ONE_MEG, PROT_READ | PROT_WRITE, MAP_SHARED,
>> dmabuf_fd, 0);
>>       if (p == MAP_FAILED) {
>> -        printf("FAIL (mmap() failed)\n");
>> -        ret = -1;
>> -        goto out;
>> +        ksft_test_result_fail("FAIL (mmap() failed)\n");
> 
> Same here and the rest of the changes in this patch.
> 
> thanks,
> -- Shuah
> 

-- 
BR,
Muhammad Usama Anjum

