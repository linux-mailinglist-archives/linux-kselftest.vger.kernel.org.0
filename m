Return-Path: <linux-kselftest+bounces-7181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3129689865C
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 13:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8561F2165D
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 11:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4463784A31;
	Thu,  4 Apr 2024 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EMxuqA/C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F0982876;
	Thu,  4 Apr 2024 11:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231298; cv=none; b=u+wOFECmwBcpR468dEmMVoOhBPGDGZPLgSvU1nCCXO8280k78OhyDcibUY8n0e5b6YLbgGc6D19btO3mWkxnF/tCFhM3Kn5jphjzdDLSxDWx8fjY2iRUEOLq72CaeoJbRPnmnCrGjdrpcsqfqAxUvqmiomcSbiVQOViaRFo16is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231298; c=relaxed/simple;
	bh=X+2uugPuVrXC1l1UkYxfOwgJq2ar4xrcrs39UDAIhSQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AtlOYboXCeT7c+fogq9RCA7SBYnMypDvZiLO+8Ro47oHikhEdTGNBcQitA+gQZIOnrCWwq3ftwwQ3wO2x7fqsaKvtQjlNHPmGPKlAYpVpfxJJyn9QDvQsNyqGEI3JLbdNTjmSE1IL38FQsvvThZ1rzFHOy2X0rEYNiV5rd6PVNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EMxuqA/C; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712231293;
	bh=X+2uugPuVrXC1l1UkYxfOwgJq2ar4xrcrs39UDAIhSQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=EMxuqA/CkRRKiGL1H3kwhSO7t636rfKNJSFagYNeGkQi30BSxSuudOK9sLwgDMZp0
	 Fia08ny7dQml2JGL7l9z9aS/DIGbLZjzTEWFiv1phdhXd+AAx2TloQ+TuDEpGRbzvy
	 mlxddAgHGqHi+Xy3YxPIYgPlE6Ujn25yvx9W5yzdYFRAaJ6f6frVKii5ugs+padpNk
	 Jb2PKX1LccI2BIKtoOalTPb03IfZBJQVMXTbZ3XrgjDXv5STV72e7/0AvVZ3jlU7pK
	 qhsbWWC3Ddy/368QXMnwwDOK634Le/UlmFEeOU2omFPnEWB8+6xteo81rmnmAkKq0P
	 z6D62BJUak7RQ==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 82AAC378200D;
	Thu,  4 Apr 2024 11:48:11 +0000 (UTC)
Message-ID: <18b3976e-49a5-43d2-8d1b-bb87f2a312eb@collabora.com>
Date: Thu, 4 Apr 2024 16:48:43 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Nicolin Chen <nicolinc@nvidia.com>, kernel@collabora.com,
 iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
 Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests: iommu: add config needed for iommufd_fail_nth
To: Jason Gunthorpe <jgg@ziepe.ca>, Joao Martins <joao.m.martins@oracle.com>
References: <20240325090048.1423908-1-usama.anjum@collabora.com>
 <31fcc276-acd6-4277-bd6c-4a871c7fb28a@collabora.com>
 <20240326150340.GE8419@ziepe.ca>
 <56cc8b9e-c1cf-4520-ba45-b1237e8b7b64@collabora.com>
 <20240327114958.GG8419@ziepe.ca>
 <51f493a9-08e7-44d8-ae4a-58b2994ea276@oracle.com>
 <f78b685d-a147-4b59-beb2-cde9d34ce22a@collabora.com>
 <e9cb60bf-5035-4fed-9b36-ca2edf048fe8@oracle.com>
 <20240327182050.GA1363414@ziepe.ca>
 <ccab9229-c0de-4c38-bb5c-7f32cbd7fa2b@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ccab9229-c0de-4c38-bb5c-7f32cbd7fa2b@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/28/24 1:13 AM, Muhammad Usama Anjum wrote:
> On 3/27/24 11:20 PM, Jason Gunthorpe wrote:
>> On Wed, Mar 27, 2024 at 06:09:37PM +0000, Joao Martins wrote:
>>> On 27/03/2024 17:49, Muhammad Usama Anjum wrote:
>>>> On 3/27/24 7:59 PM, Joao Martins wrote:
>>>>> On 27/03/2024 11:49, Jason Gunthorpe wrote:
>>>>>> On Wed, Mar 27, 2024 at 03:14:25PM +0500, Muhammad Usama Anjum wrote:
>>>>>>> On 3/26/24 8:03 PM, Jason Gunthorpe wrote:
>>>>>>>> On Tue, Mar 26, 2024 at 06:09:34PM +0500, Muhammad Usama Anjum wrote:
>>>>>>>>> Even after applying this config patch and following snippet (which doesn't
>>>>>>>>> terminate the program if mmap doesn't allocate exactly as the hint), I'm
>>>>>>>>> finding failed tests.
>>>>>>>>>
>>>>>>>>> @@ -1746,7 +1748,7 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
>>>>>>>>>         assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
>>>>>>>>>         vrc = mmap(self->buffer, variant->buffer_size, PROT_READ | PROT_WRITE,
>>>>>>>>>                    mmap_flags, -1, 0);
>>>>>>>>> -       assert(vrc == self->buffer);
>>>>>>>>> +       assert(vrc == self->buffer);// ???
>>>>>>>>>
>>>>>>>>> On x86:
>>>>>>>>> # Totals: pass:176 fail:4 xfail:0 xpass:0 skip:0 error:0
>>>>>>>>> On ARM64:
>>>>>>>>> # Totals: pass:166 fail:14 xfail:0 xpass:0 skip:0 error:0
>>>>>>>>>
>>>>>>>>> The log files are attached.
>>>>>>>>
>>>>>>>> You probably don't have enough transparent huge pages available to the process
>>>>>>>>
>>>>>>>>       echo 1024 > /proc/sys/vm/nr_hugepages
>>>>>>> After making huge pages available, the iommufd test always passed on x86.
>>>>>>> But there are still failures on arm64. I'm looking into the failures.
>>>>>>
>>>>>> Oh that is really strange. Joao? Nicolin?
>>>>>>
>>>>> Definitely strange, I'll have a look.
>>>>>
>>>>> So it set the expected number of dirty bits as that assert doesn't fail, but it
>>>>> is failing when we check that even bits are set but not odd ones. Like it's
>>>>> hasn't set those bits.
>>>>>
>>>>> For mock tests there should be no difference between x86 and ARM assuming the
>>>>> typical 4K page-size. Maybe this is 64k base pages in ARM? That's the only thing
>>>>> that I can think of that affected mock domain.
>>>> The config is attached. The defaults are being used i.e., 4k page.
>>>
>>> Looks like CONFIG_IOMMUFD_DRIVER is not defined :(
>>>
>>> Thus no bits are being set.
>>
>> Oh! 
>>
>> --- a/drivers/iommu/iommufd/Kconfig
>> +++ b/drivers/iommu/iommufd/Kconfig
>> @@ -37,6 +37,7 @@ config IOMMUFD_TEST
>>         depends on DEBUG_KERNEL
>>         depends on FAULT_INJECTION
>>         depends on RUNTIME_TESTING_MENU
>> +       select IOMMUFD_DRIVER
>>         default n
>>         help
>>           This is dangerous, do not enable unless running
>>
> Tested this patch on my system and it fixes all issues for ARM64. Please
> add tag for this Kconfig patch:
> Tested by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> 
> Also please accept the patch in this current series.
Please let me know if you need me to send the config patch. Please accept
the config patch as well.

>>
>> ???
>>
>> Jason
> 

-- 
BR,
Muhammad Usama Anjum

