Return-Path: <linux-kselftest+bounces-34665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6843AD5034
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 11:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0F4B174366
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 09:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786E225F961;
	Wed, 11 Jun 2025 09:40:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220AA25C804;
	Wed, 11 Jun 2025 09:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634816; cv=none; b=PbZRvdx/gdpgE8qsLqKwbFHMGqEP5V1sKoRKErFHoIzbNqruDgZsNyso+qUwzA5GTHWedzpSDxtpsfwAFaCeWnIKIZwpaLDX6xlWkUqWIuvCOpGdpGMr4ABvaLYVEXV8kSCWiOX596vJWI0r4K5hl7wsGBhlwvZbjQrxtO1f+cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634816; c=relaxed/simple;
	bh=8hUlTIQNAj0gqG5vnv85+7JdRXA5z58O80lN1QBl+Q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Edm/UAJdte/bqxYc4wP0+SFY7lKz65/QW6Ff3GYDE4m/enIhL4+FC+gJIDyjKGRUBc+5HjSJxvHAF/6bPKVZKr146ichAjZjpCTRRLyMor1itUJwciv/5RgvPljlOFkg7k1/fxjim1Hzo3iNixM88D3+o1nb5rppT4v5butTZ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bHLHF2V5pzYQvrM;
	Wed, 11 Jun 2025 17:40:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 5526D1A0840;
	Wed, 11 Jun 2025 17:40:08 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP2 (Coremail) with SMTP id Syh0CgC3v2L2TkloS0I6PA--.12284S2;
	Wed, 11 Jun 2025 17:40:08 +0800 (CST)
Message-ID: <097fa60d-cb5c-4f0b-a2b1-db22b26cc49b@huaweicloud.com>
Date: Wed, 11 Jun 2025 17:40:06 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Use generic read_sysfs in thuge-gen test
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 pulehui@huawei.com
References: <20250611084011.1047132-1-pulehui@huaweicloud.com>
 <caad6357-a4a3-469f-a824-4d7a36a0e629@lucifer.local>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <caad6357-a4a3-469f-a824-4d7a36a0e629@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgC3v2L2TkloS0I6PA--.12284S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy8Gw45Xr1Uur1rZrWrKrg_yoW5KryxpF
	s3ta4jkF4IqryUCryUXFs09ryYyr4Dtay8A3yxA345Zr15JF9agrWIk34UJ3WkurZ7Wr4S
	v3y3Grsavr1DXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2025/6/11 17:18, Lorenzo Stoakes wrote:
> On Wed, Jun 11, 2025 at 08:40:11AM +0000, Pu Lehui wrote:
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> As generic read_sysfs is available in vm_utils, let's
>> use is in thuge-gen test.
>>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> 
> It generally looks good, just one point about a warning below to address.
> 
>> ---
>>   tools/testing/selftests/mm/thuge-gen.c | 37 +++++++-------------------
>>   1 file changed, 9 insertions(+), 28 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
>> index 95b6f043a3cb..e11dfbfa661b 100644
>> --- a/tools/testing/selftests/mm/thuge-gen.c
>> +++ b/tools/testing/selftests/mm/thuge-gen.c
>> @@ -77,40 +77,19 @@ void show(unsigned long ps)
>>   	system(buf);
>>   }
>>
>> -unsigned long thuge_read_sysfs(int warn, char *fmt, ...)
>> +unsigned long read_free(unsigned long ps)
>>   {
>> -	char *line = NULL;
>> -	size_t linelen = 0;
>> -	char buf[100];
>> -	FILE *f;
>> -	va_list ap;
>>   	unsigned long val = 0;
>> +	char buf[100];
>>
>> -	va_start(ap, fmt);
>> -	vsnprintf(buf, sizeof buf, fmt, ap);
>> -	va_end(ap);
>> +	snprintf(buf, sizeof(buf),
>> +		 "/sys/kernel/mm/hugepages/hugepages-%lukB/free_hugepages",
>> +		 ps >> 10);
>> +	read_sysfs(buf, &val);
> 
> We're losing all of the 'warn' logic here so if we can't find
> /sys/kernel/mm/hugepages/hugepages-%lukB/free_hugepages when ps != getpagesize()
> we no longer print a message about it.


Hi Lorenzo,

Thanks for review. Right, we should explicit that warning when ps != 
getpagesize(). How about the following modify?

diff --git a/tools/testing/selftests/mm/thuge-gen.c 
b/tools/testing/selftests/mm/thuge-gen.c
index e11dfbfa661b..8e2b08dc5762 100644
--- a/tools/testing/selftests/mm/thuge-gen.c
+++ b/tools/testing/selftests/mm/thuge-gen.c
@@ -85,7 +85,8 @@ unsigned long read_free(unsigned long ps)
         snprintf(buf, sizeof(buf),
                  "/sys/kernel/mm/hugepages/hugepages-%lukB/free_hugepages",
                  ps >> 10);
-       read_sysfs(buf, &val);
+       if (read_sysfs(buf, &val) && ps != getpagesize())
+               ksft_print_msg("missing %s\n", buf);

         return val;
  }

> 
> Should we reinstate that?
> 
> Other than this, we're ignoring errors, which by default means we return 0, but
> this is what we were doing anyway. It's only this case I think that matters.
> 
>>
>> -	f = fopen(buf, "r");
>> -	if (!f) {
>> -		if (warn)
>> -			ksft_print_msg("missing %s\n", buf);
>> -		return 0;
>> -	}
>> -	if (getline(&line, &linelen, f) > 0) {
>> -		sscanf(line, "%lu", &val);
>> -	}
>> -	fclose(f);
>> -	free(line);
>>   	return val;
>>   }
>>
>> -unsigned long read_free(unsigned long ps)
>> -{
>> -	return thuge_read_sysfs(ps != getpagesize(),
>> -			  "/sys/kernel/mm/hugepages/hugepages-%lukB/free_hugepages",
>> -			  ps >> 10);
>> -}
>> -
>>   void test_mmap(unsigned long size, unsigned flags)
>>   {
>>   	char *map;
>> @@ -173,6 +152,7 @@ void test_shmget(unsigned long size, unsigned flags)
>>   void find_pagesizes(void)
>>   {
>>   	unsigned long largest = getpagesize();
>> +	unsigned long shmmax_val = 0;
>>   	int i;
>>   	glob_t g;
>>
>> @@ -195,7 +175,8 @@ void find_pagesizes(void)
>>   	}
>>   	globfree(&g);
>>
>> -	if (thuge_read_sysfs(0, "/proc/sys/kernel/shmmax") < NUM_PAGES * largest)
>> +	read_sysfs("/proc/sys/kernel/shmmax", &shmmax_val);
>> +	if (shmmax_val < NUM_PAGES * largest)
>>   		ksft_exit_fail_msg("Please do echo %lu > /proc/sys/kernel/shmmax",
>>   				   largest * NUM_PAGES);
>>
>> --
>> 2.34.1
>>


