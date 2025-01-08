Return-Path: <linux-kselftest+bounces-24061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 732F7A05CCA
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 14:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6156016702F
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 13:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAB31FC0FE;
	Wed,  8 Jan 2025 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MqCNJ7OS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295DF1917D6
	for <linux-kselftest@vger.kernel.org>; Wed,  8 Jan 2025 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736343031; cv=none; b=aL2gSVIB0eyjGuyvI9SXBLK/BTYi/HGJ6F3iN7pjupfSKZ7Vay0xhqTlga2D1BB3EIDqMz4+ycE15fwH/SOYWHpGYMG+I909IsqaA2HTcWel8Dw57IL0I6vP59QBkUJB29B+xSktIj4ZYaGRe46VdTa4JawNm51Q7qFGy74LpT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736343031; c=relaxed/simple;
	bh=9wm9/2bc4CaLbJ96gp52m0rxFdK7uFEi2Tc3EtkoZyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ql1Ko55FozpTHJhsOJluZvB4vF5AXQ9ikeYhA6k3VCLWFwM2g3rBe02MzcfUIMWk8tyL9XdnGvlumHKx+OGatztM7ponWfDinJ4t/2r1z4Xlsv3wZSf1MPWIWDbUSMeYjgePaXJ+kfIvWNr5eY6ST1kwReyXoDV7x6qNAo4LP88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MqCNJ7OS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736343029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Xm5QqGkMZ1TZAuorlc012W7N6Xo0szgU26qviS0Ja9Q=;
	b=MqCNJ7OSJp7IEM6RQ4rDQMrv+lRPnVylW9aEMfc5e0r6R1Ksk6x3dNl9NEd0w2BTAMMXH/
	c94Gr95qjFtYCi7j7MAVE3PN8UAE1vokhQ+/aGOQdx9SL6DEp8ulWGS3c877sjJRU04VYd
	GJINmdrIsbrCbeZjjeZoo+4VLyZ6Ks8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-lNit-fuoPvWEigr7Qt_o6A-1; Wed, 08 Jan 2025 08:30:27 -0500
X-MC-Unique: lNit-fuoPvWEigr7Qt_o6A-1
X-Mimecast-MFC-AGG-ID: lNit-fuoPvWEigr7Qt_o6A
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385e27c5949so10312667f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Jan 2025 05:30:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736343027; x=1736947827;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xm5QqGkMZ1TZAuorlc012W7N6Xo0szgU26qviS0Ja9Q=;
        b=tofs4+66lkIYGXRGzIbNzE2p0LA20VIVCpOIv9IThLTgxEAULAlMt+rq8Cjj0K0BSo
         y52B2yd+bAxgwrw4G6OhzXCj/2NzyW6ZiJuvjmIgU76OS1deTTdrWXQjHMf3pvGTA1xF
         KRT5um4TNpUTvWaYYORErTAip5AdWfoxclNQbboEpYtqUmfAveiaOixighJN1vwc6OJM
         KXjhaJ9Ve1TXva2rqlhBt5KYshuqPx4r5ce+zWxgMP4k1jWU1PN+k09tmxzhdNFsGBzQ
         DOa6Dy7PabQgRvES4Ma+5tVdMpqSy4GFrJBrAIcnxckRK4oyGpHfuCL4hZ82A2/dKJz3
         mODg==
X-Forwarded-Encrypted: i=1; AJvYcCUINQSmQrMujhhyXarkbaIoLoZ7Jaar5+xhdtsr1KlsJAq4FAZB5T6iHYVYbTEu8iJvU87Aa7qLYKd+WNv1el4=@vger.kernel.org
X-Gm-Message-State: AOJu0YycBcZXfE3uYTyyFte6zmXeiLyZpvNy2ACeasDMX3UbSRzfUzIr
	u0pXYyPbv4o6z4LuPMza9bjVDQNMW12fs1b66A6kJ3Bp7tTxRfq2HJXDgMIOUE2enhV0Hg3tBpq
	wI6ZLuWc46PUWFlNSMcsq5fBfJf2x1onNmbjlJs2M6U8XysdZ/BhLH9tzoieslRBwdA==
X-Gm-Gg: ASbGnct2WNDJGozndrh3cnrLsKH5eLRJcMu32VKnV7At5hPM1ygib78pwR/+4JFTHHN
	sEa2oNm8oPDzG2m0Sf5iFqjurIE+lqagk7nRln3t3HSYt5Upzym6HlY2q4l7lhWU/x/40zDj7zk
	DLD3wo6Ll506BD1uzIGpd6xHpgegj0AACq++qDgOds1bYyf10G69Ik9HeQ0MYWxa4PFliINlQDY
	PZCHO+5mtJ3KtE0DLq05khKXXlIrDqzYcdL/PRWTWB3+k8mlkJst7a0hXRz8U5ZBOVE+TWT8fLU
	QLZx0QAhsEdJ902C4qajsrTGPgVF0EHwDBhen9PTUNZYp7ua2L4Egq5KNxBjPObxQuLxett4O8V
	WvtQGjw==
X-Received: by 2002:a5d:5f44:0:b0:386:3e3c:efd with SMTP id ffacd0b85a97d-38a8730fa79mr2263812f8f.44.1736343026631;
        Wed, 08 Jan 2025 05:30:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpKD2IZfZIbcwaLCk3XNbI7djRJXsloJfDmvj7kjgwF76HCzj7aPJFB7xbPGBAxKmz03fCTw==
X-Received: by 2002:a5d:5f44:0:b0:386:3e3c:efd with SMTP id ffacd0b85a97d-38a8730fa79mr2263785f8f.44.1736343026167;
        Wed, 08 Jan 2025 05:30:26 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:3a00:d73c:6a8:ca9f:1df7? (p200300cbc70d3a00d73c06a8ca9f1df7.dip0.t-ipconnect.de. [2003:cb:c70d:3a00:d73c:6a8:ca9f:1df7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e2dfsm53584503f8f.74.2025.01.08.05.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 05:30:25 -0800 (PST)
Message-ID: <63481999-0665-4f40-a1bd-377a6ae69f90@redhat.com>
Date: Wed, 8 Jan 2025 14:30:23 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] selftests/mm: virtual_address_range: Dump to
 /dev/null
To: Dev Jain <dev.jain@arm.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ryan Roberts <ryan.roberts@arm.com>
References: <20250107-virtual_address_range-tests-v1-0-3834a2fb47fe@linutronix.de>
 <20250107-virtual_address_range-tests-v1-3-3834a2fb47fe@linutronix.de>
 <2c5ab3af-2e58-449a-94f2-5cbcaa8b66f2@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2c5ab3af-2e58-449a-94f2-5cbcaa8b66f2@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.01.25 07:09, Dev Jain wrote:
> 
> On 07/01/25 8:44 pm, Thomas Weißschuh wrote:
>> During the execution of validate_complete_va_space() a lot of memory is
>> on the VM subsystem. When running on a low memory subsystem an OOM may
>> be triggered, when writing to the dump file as the filesystem may also
>> require memory.
>>
>> On my test system with 1100MiB physical memory:
>>
>> 	Tasks state (memory values in pages):
>> 	[  pid  ]   uid  tgid total_vm      rss rss_anon rss_file rss_shmem pgtables_bytes swapents oom_score_adj name
>> 	[     57]     0    57 34359215953      695      256        0       439 1064390656        0             0 virtual_address
>>
>> 	Out of memory: Killed process 57 (virtual_address) total-vm:137436863812kB, anon-rss:1024kB, file-rss:0kB, shmem-rss:1756kB, UID:0 pgtables:1039444kB oom_score_adj:0
>> 	<snip>
>> 	fault_in_iov_iter_readable+0x4a/0xd0
>> 	generic_perform_write+0x9c/0x280
>> 	shmem_file_write_iter+0x86/0x90
>> 	vfs_write+0x29c/0x480
>> 	ksys_write+0x6c/0xe0
>> 	do_syscall_64+0x9e/0x1a0
>> 	entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>> Write the dumped data into /dev/null instead which does not require
>> additional memory during write(), making the code simpler as a
>> side-effect.
>>
>> Signed-off-by: Thomas Weißschuh<thomas.weissschuh@linutronix.de>
>> ---
>>   tools/testing/selftests/mm/virtual_address_range.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
>> index 484f82c7b7c871f82a7d9ec6d6c649f2ab1eb0cd..4042fd878acd702d23da2c3293292de33bd48143 100644
>> --- a/tools/testing/selftests/mm/virtual_address_range.c
>> +++ b/tools/testing/selftests/mm/virtual_address_range.c
>> @@ -103,10 +103,9 @@ static int validate_complete_va_space(void)
>>   	FILE *file;
>>   	int fd;
>>   
>> -	fd = open("va_dump", O_CREAT | O_WRONLY, 0600);
>> -	unlink("va_dump");
>> +	fd = open("/dev/null", O_WRONLY);
>>   	if (fd < 0) {
>> -		ksft_test_result_skip("cannot create or open dump file\n");
>> +		ksft_test_result_skip("cannot create or open /dev/null\n");
>>   		ksft_finished();
>>   	}
 >>   >> @@ -152,7 +151,6 @@ static int validate_complete_va_space(void)
>>   		while (start_addr + hop < end_addr) {
>>   			if (write(fd, (void *)(start_addr + hop), 1) != 1)
>>   				return 1;
>> -			lseek(fd, 0, SEEK_SET);
>>   
>>   			hop += MAP_CHUNK_SIZE;
>>   		}
>>
> 
> The reason I had not used /dev/null was that write() was succeeding to /dev/null
> even from an address not in my VA space. I was puzzled about this behaviour of
> /dev/null and I chose to ignore it and just use a real file.
> 
> To test this behaviour, run the following program:
> 
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <sys/mman.h>
> intmain()
> {
> intfd;
> fd = open("va_dump", O_CREAT| O_WRONLY, 0600);
> unlink("va_dump");
> // fd = open("/dev/null", O_WRONLY);
> intret = munmap((void*)(1UL<< 30), 100);
> if(!ret)
> printf("munmap succeeded\n");
> intres = write(fd, (void*)(1UL<< 30), 1);
> if(res == 1)
> printf("write succeeded\n");
> return0;
> }
> The write will fail as expected, but if you comment out the va_dump
> lines and use /dev/null, the write will succeed.

What exactly do we want to achieve with the write? Verify that the 
output of /proc/self/map is reasonable and we can actually resolve a 
fault / map a page?

Why not access the memory directly+signal handler or using 
/proc/self/mem, so you can avoid the temp file completely?

-- 
Cheers,

David / dhildenb


