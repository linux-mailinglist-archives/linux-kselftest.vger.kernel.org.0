Return-Path: <linux-kselftest+bounces-6724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 815B788EE17
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 19:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A8C1F39002
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 18:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C6D14F9F8;
	Wed, 27 Mar 2024 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QUrx88yE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC34214F112;
	Wed, 27 Mar 2024 18:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711563457; cv=none; b=Ks2w1pArU1/cV+SI2S2RxWgiA+QrSP2huqMWbI+SCBd6Eg55SF5J9d7ATcq3ebA1IeVkThqnivqEedv7dg+xFQMj9JRl/9vA/o+ZWSJXeywi0nYPnVIbOMMZm6uRSdfI/gs1JKUREwab3n1fc2UwxSxIdQIDrMuQCqV8RTHLyYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711563457; c=relaxed/simple;
	bh=1xI/k4F3DwHGNvZeAI5LuANOPogXIptxcRHXwYg+HR8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SWEw0NvXaX5Z0g34JmnfVbYhu5Xq5J3zstw47vr9YDAucdrndM9YR+qJ4nMa0SDdDA0k2Dc7/vk0S2HeiQzrbilCs0D6TOqdxryjlwhdnFA5l8XcC3vnlm9YwZlL4HD1HK6JZqgilMlnRGK4/y76Qtytcxd8p7zxM23yCa+JfgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QUrx88yE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711563454;
	bh=1xI/k4F3DwHGNvZeAI5LuANOPogXIptxcRHXwYg+HR8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=QUrx88yE6OlfbSxvc+hdbHwtishdRDuUOjdDlUklHw2zOZCtOQi91Pe85Y0xW27c+
	 kJyHyJQMpwLpdryXlYFYoePwhtoljcEgrl5//OfUK0l+l5eTJSCiWFwFWyxif4qTPC
	 ndVaREuKWsvMEEzOzGn/wHPqgEpw1mAqlNDkFLw7N4yDRlBz2AK2Uew6wAabuw7Jby
	 mSp/rAQLjZx46UBZg0TrZ6HecEnhBWDwqbZnzl7mH+9k7jsNHqI3O0zU3Z6u4abd6f
	 sZ9Q8bUSW7Ikzn6RpFaEy1LWFxcRcQfHNTgs2xgdngtv2uWHl3BAOWPjmL/goqcMao
	 Y+2b5lmivO86Q==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 71AC637820A3;
	Wed, 27 Mar 2024 18:17:29 +0000 (UTC)
Message-ID: <b05610de-f102-46d2-abe2-4e9ecbcd42eb@collabora.com>
Date: Wed, 27 Mar 2024 23:17:58 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
 Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests: iommu: add config needed for iommufd_fail_nth
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20240325090048.1423908-1-usama.anjum@collabora.com>
 <31fcc276-acd6-4277-bd6c-4a871c7fb28a@collabora.com>
 <20240326150340.GE8419@ziepe.ca>
 <56cc8b9e-c1cf-4520-ba45-b1237e8b7b64@collabora.com>
 <20240327114958.GG8419@ziepe.ca>
 <51f493a9-08e7-44d8-ae4a-58b2994ea276@oracle.com>
 <f78b685d-a147-4b59-beb2-cde9d34ce22a@collabora.com>
 <e9cb60bf-5035-4fed-9b36-ca2edf048fe8@oracle.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <e9cb60bf-5035-4fed-9b36-ca2edf048fe8@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/27/24 11:09 PM, Joao Martins wrote:
> On 27/03/2024 17:49, Muhammad Usama Anjum wrote:
>> On 3/27/24 7:59 PM, Joao Martins wrote:
>>> On 27/03/2024 11:49, Jason Gunthorpe wrote:
>>>> On Wed, Mar 27, 2024 at 03:14:25PM +0500, Muhammad Usama Anjum wrote:
>>>>> On 3/26/24 8:03 PM, Jason Gunthorpe wrote:
>>>>>> On Tue, Mar 26, 2024 at 06:09:34PM +0500, Muhammad Usama Anjum wrote:
>>>>>>> Even after applying this config patch and following snippet (which doesn't
>>>>>>> terminate the program if mmap doesn't allocate exactly as the hint), I'm
>>>>>>> finding failed tests.
>>>>>>>
>>>>>>> @@ -1746,7 +1748,7 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
>>>>>>>         assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
>>>>>>>         vrc = mmap(self->buffer, variant->buffer_size, PROT_READ | PROT_WRITE,
>>>>>>>                    mmap_flags, -1, 0);
>>>>>>> -       assert(vrc == self->buffer);
>>>>>>> +       assert(vrc == self->buffer);// ???
>>>>>>>
>>>>>>> On x86:
>>>>>>> # Totals: pass:176 fail:4 xfail:0 xpass:0 skip:0 error:0
>>>>>>> On ARM64:
>>>>>>> # Totals: pass:166 fail:14 xfail:0 xpass:0 skip:0 error:0
>>>>>>>
>>>>>>> The log files are attached.
>>>>>>
>>>>>> You probably don't have enough transparent huge pages available to the process
>>>>>>
>>>>>>       echo 1024 > /proc/sys/vm/nr_hugepages
>>>>> After making huge pages available, the iommufd test always passed on x86.
>>>>> But there are still failures on arm64. I'm looking into the failures.
>>>>
>>>> Oh that is really strange. Joao? Nicolin?
>>>>
>>> Definitely strange, I'll have a look.
>>>
>>> So it set the expected number of dirty bits as that assert doesn't fail, but it
>>> is failing when we check that even bits are set but not odd ones. Like it's
>>> hasn't set those bits.
>>>
>>> For mock tests there should be no difference between x86 and ARM assuming the
>>> typical 4K page-size. Maybe this is 64k base pages in ARM? That's the only thing
>>> that I can think of that affected mock domain.
>> The config is attached. The defaults are being used i.e., 4k page.
> 
> Looks like CONFIG_IOMMUFD_DRIVER is not defined :(
I'll retest with this config and update the patch to include it in the
config fragment needed for this test. Once we add all required config
options in config fragment, the test should never fail. Somehow this gets
included in the x86, but not on ARM.

> 
> Thus no bits are being set.
> 

-- 
BR,
Muhammad Usama Anjum

