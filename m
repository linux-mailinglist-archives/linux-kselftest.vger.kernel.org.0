Return-Path: <linux-kselftest+bounces-48585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1FAD07171
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 05:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E7EF300FEFA
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 04:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391AE2D7DC1;
	Fri,  9 Jan 2026 04:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K14U5eVW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PLjGaz7n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9C82C11F7
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Jan 2026 04:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767932080; cv=none; b=YjP/npuXcsdDpXGqbbICM4fof+8IDiuk/skEE9r/3yODBKtTa1ycE8UFz9fWTdOmai900PuyFWdeV+Z6r/dcbTX0g/j6EweE06IoGRwNHLHUhNyYwY8t+TzWTeZCocsOxjREpa50/RtdJvYMaTLgZqXZV3uSQkZG51XldRV4/AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767932080; c=relaxed/simple;
	bh=i1fLrSbyd81f0S0PiHsOLrXgKUHshwekbk4YumK+lKk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ApgAtnVCCB1VB0ZaDoLwEJeM57jqs4QD82VX+24Gt/SBoUgtRdghnnTPtGy9LD/PTSHeNsKG11YLEDCPTRk5P33It+7nyMjewbSR4Ef19BINXgOMo/EnX3snkIuGkv4QN/7d0O6puhVjJ0EJyzKlxT/brTYgRONEKs7dDDvKHW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K14U5eVW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PLjGaz7n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767932075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nghXJ/jMMYOZQxSCZgT2jI2VxzkfVAzdpBsOhl57SOs=;
	b=K14U5eVWVGnXpdj7HZSVjdvqKhay2PRfOQkKtnElPHsp7Qu1GEdXG1y1clQ+SbGhVt+7AE
	AJLHzTjZrRTUwd/TWzgCqidRc9Wr8OcmMVrac0czVrFAZVfpBZUXfnZ32NiiwxHqNcHki4
	X2QfTTbrcXFn1fHh2m8vnSrleMqrNX0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-d-kEcpa3MsiBlDhDsxo4Nw-1; Thu, 08 Jan 2026 23:14:32 -0500
X-MC-Unique: d-kEcpa3MsiBlDhDsxo4Nw-1
X-Mimecast-MFC-AGG-ID: d-kEcpa3MsiBlDhDsxo4Nw_1767932072
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b9ff555d2dso1057160885a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 20:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767932072; x=1768536872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nghXJ/jMMYOZQxSCZgT2jI2VxzkfVAzdpBsOhl57SOs=;
        b=PLjGaz7nWTId2VHn6Uav8QWh9xGVRMUtP04PZuZlRnyHeUtp5anTHLN5E90RcU79qe
         BYfkLmqgFbvQAWz/qncfzKPjzX5EWzYtQcDxhOVB5fSjzm7n1y+zpCib1xCPb1LuEeTf
         r71GHWejbPtBl5+QcelfIsCeyLpgXYeDnjgXDQXnQpFkyan5x4oh6LuQvUgmVnpRs35o
         7TjUEy+5pMPAioHYp2CnBRK4xXJiMIRAnlmHMfKuPFFaiW0qwAe+ctXi3xHWQ5ez3q0q
         JNkitT8obJ80z0VCkSr+OARIgjLseVmfC6H6PD5S8mX4IKj9EVPW4k7mSrJZ51cezj0r
         3iHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767932072; x=1768536872;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nghXJ/jMMYOZQxSCZgT2jI2VxzkfVAzdpBsOhl57SOs=;
        b=iKEFo0tKxgLF9ccMh2o3suR+BPn9yhxd2Ys7hFAdESNhKcx9SiyjgQ+EcOlplZH4ul
         FEoI78QlOWNorKEXIPfntNG8hOTEM8bpOkcLyxVVc1ADpZ0aW4B1p9nuL282AGxYjKj4
         veVSltKnXxVLFdFAaBP5GUVbeeTAjugjy1FvAbbpPybxGc/arU7vsIWCSXIzMFcNoSTQ
         cXNdUXBCo3+n5JoketmebT1Sc+l920wUdz//oKsTiNOR5FacJqj+coXd2+Wo5QhVZFrX
         +3akASCwiNHol0qzzuyxNRBaRSgrt9ZEY0d2r5B8xP4/wyx9MLeDD0AtprR5NR1HAiTF
         G7vg==
X-Forwarded-Encrypted: i=1; AJvYcCWEJjDXrqaKzuPHFYSMqoacOA3CM0qfO6o8D1lz/tuuE7uvCeQ6xsKNTw45R7GxIgPXIYvp8f0nc0a4YRJ4h1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1wH8hD2+wuacROfkVAGEBMLH1XMuuKmTRe9MYvRblwz/Z7J5o
	3jGe/dH0Br7KkF0Y82PiGTXtEUhUSVef4DEMZUQ45eD4qwa3zlviDGM44JWQeoav4izZG3BmK/E
	E86kPhNEdTppPZypCVkJDuRCAtOEZ1O2y8lQMIDKduxmT2I3xuoIHN0ig5JZdqgnpQe/TqQ==
X-Gm-Gg: AY/fxX7Q79XAgb5o4lHWIvvdsJO+KUsK/JnygN2lM/e5lAVkPPLjx8oAIscKVaLlqbM
	53aS7j30tof7XRXN3Iq+WXJMHS/pElTpaUlSl5O1I0FZoqBK7m5GE982WoC7YBTTIaU5HG4QUWG
	hGoXSDraud3Gacj/af7eObbw0Xku8cdz/ZZjQR3avR/AJ2JNq+4HcBFoJBBzRw+vJJ8BY2CufS5
	8+CqB7+7m91BJPyytEXysOlX5S5iRx0JPVPtl+LDK+DdILSxNKv3/4oqDCK996WtdaewBHFstwF
	N3BSCcOgM1C0SWWJGy6KNEHnefaKAS6JDnx3QomNMGKG3rWzkOIJ7dUClJPCIw9hqEi5woOl4jG
	9m00K9MhVptXkzPiGD4r/MbQBOWOciIEz4iBFddm8jZKvbBu/FvBavF4x
X-Received: by 2002:a05:620a:4804:b0:8b2:e0ad:eb97 with SMTP id af79cd13be357-8c3894172cbmr1167824285a.83.1767932071816;
        Thu, 08 Jan 2026 20:14:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfApg85dIzy0/UVGbmmnaqdWN/LcvlttlnRbWN6UZZYR6Gg703S6psJlUfwcLoLX8mA87/aw==
X-Received: by 2002:a05:620a:4804:b0:8b2:e0ad:eb97 with SMTP id af79cd13be357-8c3894172cbmr1167822485a.83.1767932071381;
        Thu, 08 Jan 2026 20:14:31 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a6145sm730500485a.5.2026.01.08.20.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 20:14:30 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <828377cf-4a64-48b4-887e-8f71ebed502c@redhat.com>
Date: Thu, 8 Jan 2026 23:14:28 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.20 PATCH v2 3/4] cgroup/cpuset: Don't fail
 cpuset.cpus change in v2
To: Chen Ridong <chenridong@huaweicloud.com>, Waiman Long <llong@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 Sun Shaojie <sunshaojie@kylinos.cn>
References: <20260101191558.434446-1-longman@redhat.com>
 <20260101191558.434446-4-longman@redhat.com>
 <efdcd90c-95ed-4cfc-af9a-3dc0e8f0a488@huaweicloud.com>
 <6eedf67b-3538-4fd1-903b-b7d8db4ff43d@redhat.com>
 <7a3ec392-2e86-4693-aa9f-1e668a668b9c@huaweicloud.com>
 <85f4bca2-e355-49ce-81e9-3b8080082545@redhat.com>
 <38ab0503-3176-43a0-b6b5-09de0fd9eb75@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <38ab0503-3176-43a0-b6b5-09de0fd9eb75@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/5/26 2:00 AM, Chen Ridong wrote:
>
> On 2026/1/5 11:59, Waiman Long wrote:
>> On 1/4/26 8:35 PM, Chen Ridong wrote:
>>> On 2026/1/5 5:48, Waiman Long wrote:
>>>> On 1/4/26 2:09 AM, Chen Ridong wrote:
>>>>> On 2026/1/2 3:15, Waiman Long wrote:
>>>>>> Commit fe8cd2736e75 ("cgroup/cpuset: Delay setting of CS_CPU_EXCLUSIVE
>>>>>> until valid partition") introduced a new check to disallow the setting
>>>>>> of a new cpuset.cpus.exclusive value that is a superset of a sibling's
>>>>>> cpuset.cpus value so that there will at least be one CPU left in the
>>>>>> sibling in case the cpuset becomes a valid partition root. This new
>>>>>> check does have the side effect of failing a cpuset.cpus change that
>>>>>> make it a subset of a sibling's cpuset.cpus.exclusive value.
>>>>>>
>>>>>> With v2, users are supposed to be allowed to set whatever value they
>>>>>> want in cpuset.cpus without failure. To maintain this rule, the check
>>>>>> is now restricted to only when cpuset.cpus.exclusive is being changed
>>>>>> not when cpuset.cpus is changed.
>>>>>>
>>>>> Hi, Longman,
>>>>>
>>>>> You've emphasized that modifying cpuset.cpus should never fail. While I haven't found this
>>>>> explicitly documented. Should we add it?
>>>>>
>>>>> More importantly, does this mean the "never fail" rule has higher priority than the exclusive CPU
>>>>> constraints? This seems to be the underlying assumption in this patch.
>>>> Before the introduction of cpuset partition, writing to cpuset.cpus will only fail if the cpu list
>>>> is invalid like containing CPUs outside of the valid cpu range. What I mean by "never-fail" is that
>>>> if the cpu list is valid, the write action should not fail. The rule is not explicitly stated in the
>>>> documentation, but it is a pre-existing behavior which we should try to keep to avoid breaking
>>>> existing applications.
>>>>
>>> There are two conditions that can cause a cpuset.cpus write operation to fail: ENOSPC (No space left
>>> on device) and EBUSY.
>>>
>>> I just want to ensure the behavior aligns with our design intent.
>>>
>>> Consider this example:
>>>
>>> # cd /sys/fs/cgroup/
>>> # mkdir test
>>> # echo 1 > test/cpuset.cpus
>>> # echo $$ > test/cgroup.procs
>>> # echo 0 > /sys/devices/system/cpu/cpu1/online
>>> # echo > test/cpuset.cpus
>>> -bash: echo: write error: No space left on device
>>>
>>> In cgroups v2, if the test cgroup becomes empty, it could inherit the parent's effective CPUs. My
>>> question is: Should we still fail to clear cpuset.cpus (returning an error) when the cgroup is
>>> populated?
>> Good catch. This error is for v1. It shouldn't apply for v2. Yes, I think we should fix that for v2.
>>
> The EBUSY check (through cpuset_cpumask_can_shrink) is necessary, correct?

Yes, it is a check needed by the deadline scheduler irrespective of if 
v1 or v2 is used.


>
> Since the subsequent patch modifies exclusive checking for v1, should we consolidate all v1-related
> code into a separate function like cpuset1_validate_change() (maybe come duplicate code)?, it would
> allow us to isolate v1 logic and avoid having to account for v1 implementation details in future
> features.
>
> In other words:
>
> validate_change(...)
> {
>      if (!is_in_v2_mode())
>          return cpuset1_validate_change(cur, trial);
>      ...
>      // only v2 code here
> }
>
Yes, we could move the code to cpuset1_validate_change().

Cheers,
Longman

cpuset1_validate_change


