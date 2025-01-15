Return-Path: <linux-kselftest+bounces-24551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1074A11922
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 06:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 584293A8050
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 05:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCA122F3BD;
	Wed, 15 Jan 2025 05:45:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BBE22F39B;
	Wed, 15 Jan 2025 05:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736919923; cv=none; b=Y/d6cBHHA5wYQ/evb86qiLx3tR1TYNhu4a3+9G2Z2GQ51K98ey0GFeIa6SFw0y4fMl/rlB0UBV3MppvG0nrY6exPgbx5wmIIA3H1V64s/xUV2lHkNdXZJjjv2HFsmqQ6IIBvNM5ZHM2THwJ3nOOdRgzuMBKtbyy2soCLdY+C39A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736919923; c=relaxed/simple;
	bh=r9RCR3yQoxL3S5e3nBUsccAfs/R+Ak90H/RSf8f9mKw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kVCNZYISKMbJNoGO3MSgO8XNNeqlLZhgGuUGJpncHsLVGIRXngFf+ygygIH7uUII/go6OPPvw4zguKpUAC9wTIJQXaWNfeSUzEfmI6yWDXeRpDyxltrcc13GDx3Vrstb0MeAHO2IDdSP5Q0k8ngMWjRSxWmPBgFSXBBPSh1w7Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e3d83ae6d30311efa216b1d71e6e1362-20250115
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:50ce2e0d-38c4-4bfe-a738-2f4d101107c7,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:50ce2e0d-38c4-4bfe-a738-2f4d101107c7,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:0a954f93ffa235c13a8b2963db69e004,BulkI
	D:250114182517ROX5ZG6G,BulkQuantity:1,Recheck:0,SF:17|19|24|38|44|64|66|78
	|80|81|82|83|102|841,TC:nil,Content:0|52,EDM:-3,IP:-2,URL:0,File:nil,RT:ni
	l,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,B
	RR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: e3d83ae6d30311efa216b1d71e6e1362-20250115
X-User: liuye@kylinos.cn
Received: from [192.168.22.248] [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 271529189; Wed, 15 Jan 2025 13:45:13 +0800
Message-ID: <778941db-27fb-48b3-8d98-81d1673deffc@kylinos.cn>
Date: Wed, 15 Jan 2025 13:45:09 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: liuye <liuye@kylinos.cn>
Subject: Re: [PATCH] selftests/mm/cow : Fix memory leak in
 child_vmsplice_memcmp_fn()
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 shuah@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250114022929.46364-1-liuye@kylinos.cn>
 <4fd2fdca-ea98-499f-ba04-0f1140180ba4@redhat.com>
Content-Language: en-US
In-Reply-To: <4fd2fdca-ea98-499f-ba04-0f1140180ba4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/1/14 18:23, David Hildenbrand 写道:
> On 14.01.25 03:29, liuye wrote:
>>      Release memory before exception branch returns to prevent memory 
>> leaks.
>>
>> Signed-off-by: liuye <liuye@kylinos.cn>
>> ---
>>   tools/testing/selftests/mm/cow.c | 21 ++++++++++++++++-----
>>   1 file changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/cow.c 
>> b/tools/testing/selftests/mm/cow.c
>> index 1238e1c5aae1..959327ba6258 100644
>> --- a/tools/testing/selftests/mm/cow.c
>> +++ b/tools/testing/selftests/mm/cow.c
>> @@ -167,19 +167,30 @@ static int child_vmsplice_memcmp_fn(char *mem, 
>> size_t size,
>>       /* Backup the original content. */
>>       memcpy(old, mem, size);
>>   -    if (pipe(fds) < 0)
>> +    if (pipe(fds) < 0) {
>> +        free(old);
>> +        free(new);
>>           return -errno;
>> -
>> +    }
>>       /* Trigger a read-only pin. */
>>       transferred = vmsplice(fds[1], &iov, 1, 0);
>> -    if (transferred < 0)
>> +    if (transferred < 0) {
>> +        free(old);
>> +        free(new);
>>           return -errno;
>> -    if (transferred == 0)
>> +    }
>> +    if (transferred == 0) {
>> +        free(old);
>> +        free(new);
>>           return -EINVAL;
>> +    }
>>         /* Unmap it from our page tables. */
>> -    if (munmap(mem, size) < 0)
>> +    if (munmap(mem, size) < 0) {
>> +        free(old);
>> +        free(new);
>>           return -errno;
>> +    }
>
> We are immediately exiting the test in do_test_cow_in_parent()
>     exit(fn(mem, size, &comm_pipes));
>
> Your changes make the code unnecessarily more complicated to read, so 
> I'm not in favor of this one to make some checker tool happy.
>

It is indeed exiting the process. After the process exits, the memory 
will be reclaimed naturally.

As code in the kernel branch, it will be used by beginners, such as me, 
for learning. Modifications are recommended.

Regarding the readability of the code, is the following modification 
better than before?



diff --git a/tools/testing/selftests/mm/cow.c 
b/tools/testing/selftests/mm/cow.c
index 1238e1c5aae1..db5e71c5bf2f 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -167,19 +167,21 @@ static int child_vmsplice_memcmp_fn(char *mem, 
size_t size,
         /* Backup the original content. */
         memcpy(old, mem, size);

-       if (pipe(fds) < 0)
-               return -errno;
+       if (pipe(fds) < 0)
+               goto free;

         /* Trigger a read-only pin. */
         transferred = vmsplice(fds[1], &iov, 1, 0);
-       if (transferred < 0)
-               return -errno;
-       if (transferred == 0)
-               return -EINVAL;
+       if (transferred < 0)
+               goto free;
+       if (transferred == 0) {
+               error = EINVAL;
+               goto free;
+       }

         /* Unmap it from our page tables. */
         if (munmap(mem, size) < 0)
-               return -errno;
+               goto free;

         /* Wait until the parent modified it. */
         write(comm_pipes->child_ready[1], "0", 1);
@@ -194,6 +196,10 @@ static int child_vmsplice_memcmp_fn(char *mem, 
size_t size,
         }

         return memcmp(old, new, transferred);
+free:
+       free(old);
+       free(new);
+       return -error;
  }




