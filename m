Return-Path: <linux-kselftest+bounces-42017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9D0B8D9FC
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 13:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C759A7A8E96
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 11:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E662259C94;
	Sun, 21 Sep 2025 11:25:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F73C34BA36;
	Sun, 21 Sep 2025 11:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758453929; cv=none; b=XgP4smUo2Mqzo3F+lM78hc3V8F9+euFfYFC+HYFBsdVu9bu6qjKRjYAfsmwdZdHZqvCEbzckfrqDQUYoojOjjzGi1vrxt+k3WuMnzT53AtKE79t9ouL5q8j+NCVjBvp8uS5Yz+FdNlYL/w4+MAP9g4itkMUldM7l/pWKnUGQ4gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758453929; c=relaxed/simple;
	bh=YlrmXyjeO7GcRsXhqWeRYbpRf9DLv5IX+7MRr6Xm76s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cd+8/eHPHlgvTtORZ5xf2O6QkQDVqt4EFHy5dyZP+BgZpZotXjPFYmFQYTlp/pk3y9FIajCNeYc/7vDPoRqKH87R3GknWM13t1QzAU8RjDGBmapyWyWym6Ak18SPGiV7VqjdhUmiF9o3B+PAUe6/Peqc0xHoCt2H5qxn396eIYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 311F21516;
	Sun, 21 Sep 2025 04:25:18 -0700 (PDT)
Received: from [10.163.39.139] (unknown [10.163.39.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5DF23F673;
	Sun, 21 Sep 2025 04:25:17 -0700 (PDT)
Message-ID: <49731a4e-d00f-4f84-aaac-87405d6eadbf@arm.com>
Date: Sun, 21 Sep 2025 16:55:14 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/memory-failure: Support disabling soft offline for
 HugeTLB pages
To: David Hildenbrand <david@redhat.com>, Kyle Meyer <kyle.meyer@hpe.com>
Cc: akpm@linux-foundation.org, corbet@lwn.net, linmiaohe@huawei.com,
 shuah@kernel.org, tony.luck@intel.com, jane.chu@oracle.com,
 jiaqiyan@google.com, Liam.Howlett@oracle.com, bp@alien8.de,
 hannes@cmpxchg.org, jack@suse.cz, joel.granados@kernel.org,
 laoar.shao@gmail.com, lorenzo.stoakes@oracle.com, mclapinski@google.com,
 mhocko@suse.com, nao.horiguchi@gmail.com, osalvador@suse.de,
 rafael.j.wysocki@intel.com, rppt@kernel.org, russ.anderson@hpe.com,
 shawn.fan@intel.com, surenb@google.com, vbabka@suse.cz,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org
References: <aMiu_Uku6Y5ZbuhM@hpe.com>
 <a99eb11f-a7ac-48a3-a671-c5f0f6b5b491@arm.com>
 <8c3188da-7078-4099-973a-1d0d74db2720@redhat.com> <aMsDJ3EU1zVJ00cX@hpe.com>
 <cd71fac2-bb9d-4e84-a074-2b695654e655@redhat.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <cd71fac2-bb9d-4e84-a074-2b695654e655@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 18/09/25 12:35 AM, David Hildenbrand wrote:
> On 17.09.25 20:51, Kyle Meyer wrote:
>> On Wed, Sep 17, 2025 at 09:02:55AM +0200, David Hildenbrand wrote:
>>>
>>>>> +
>>>>> +    0 - Enable soft offline
>>>>> +    1 - Disable soft offline for HugeTLB pages
>>>>> +
>>>>> +Supported values::
>>>>> +
>>>>> +    0 - Soft offline is disabled
>>>>> +    1 - Soft offline is enabled
>>>>> +    3 - Soft offline is enabled (disabled for HugeTLB pages)
>>>>
>>>> This looks very adhoc even though existing behavior is preserved.
>>>>
>>>> - Are HugeTLB pages the only page types to be considered ?
>>>> - How the remaining bits here are going to be used later ?
>>>>
>>>
>>> What I proposed (that could be better documented here) is that all other
>>> bits except the first one will be a disable mask when bit 0 is set.
>>>
>>> 2 - ... but yet disabled for hugetlb
>>> 4 - ... but yet disabled for $WHATEVER
>>> 8 - ... but yet disabled for $WHATEVERELSE
>>>
>>>> Also without a bit-wise usage roadmap, is not changing a procfs
>>>> interface (ABI) bit problematic ?
>>>
>>> For now we failed setting it to values that are neither 0 or 1, IIUC
>>> set_enable_soft_offline() correctly?
>>
>> Yes, -EINVAL will be returned.
>>
>>> So there should not be any problem, or which scenario do you have in mind?
>>
>> Here's an alternative approach.
>>
>> Do not modify the existing sysctl parameter:
>>
>> /proc/sys/vm/enable_soft_offline
>>
>> 0 - Soft offline is disabled
>> 1 - Soft offline is enabled
>>
>> Instead, introduce a new sysctl parameter:
>>
>> /proc/sys/vm/enable_soft_offline_hugetlb
>>
>> 0 - Soft offline is disabled for HugeTLB pages
>> 1 - Soft offline is enabled for HugeTLB pages
>>
>> and note in documentation that this setting only takes effect if
>> enable_soft_offline is enabled.
>>
>> Anshuman (and David), would you prefer this?
> 
> Hmm, at least I don't particularly like that. For each new exception we would create a new file, and the file has weird semantics such that it has no meaning when enable_soft_offline=0.

Agree with David here. Adding a new procfs file for a particular page
type's soft offline disable scenario does not really make sense. This
will extend the ABI unnecessarily without adding much benefit.

