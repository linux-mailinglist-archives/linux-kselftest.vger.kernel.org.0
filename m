Return-Path: <linux-kselftest+bounces-48165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6013CCF1C49
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 04:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D2963029225
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 03:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C9E31D399;
	Mon,  5 Jan 2026 03:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ERHQUKba";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="r7tg849V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C542EBBB7
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Jan 2026 03:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767585013; cv=none; b=u4MwnUz2n5lEURvMFr2Zfojz4HUvpBsjUtLcszLLevp8XAqGVwzpzI4PDHvDOvrz1LJnLXz/tN/s9cZLMHkbCMS/2GT7bclACgq3Lg7JjeVYNkZbnF2FabISdJJLr7gq6BUX30deRWZ7Ig5jl42ERp+ZE50XntS7a9dyGw7ypms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767585013; c=relaxed/simple;
	bh=nWDhnM5smOejtNjvCY8DuFynO6oN7w520hhjFNQ9W6s=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=C/JFDiviBfQ9GCcQB689xkSGv1tfA7VMJ7ad/2i6eL96LBCabqFvTNh1ru/j1w+Xhq4Hlc9PdAQfVNoxFpndzdYeK+auN5iZD96YShO2Dl+ued9XilkU9cf9+A8cxhUR7oAWMdQ89gDRcP40c9iS1FUlfZ749OXcUKBB3X8l+4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ERHQUKba; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=r7tg849V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767585010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PD0MEl6rVwz2bUrpGYdOAu4vaIcu3nhZz3+NE6MOYH8=;
	b=ERHQUKbaL/jmJqvJd1Uy2ceQkAQU4i/KwpfbLhiV/CZF7FuplbrNaBZihJixfRsKskaad9
	1jvZ8kW01IEToPLoyimN6i86kZ/FH3Z29Ou63ld/V10APcoG/5v3/fECbwgZmmhDGknOzy
	tTz8ZluW1PSGUxnM9QQDI0XSmPiqxf8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-spHmT5qsP-Oxe5AD2sK4HA-1; Sun, 04 Jan 2026 22:50:09 -0500
X-MC-Unique: spHmT5qsP-Oxe5AD2sK4HA-1
X-Mimecast-MFC-AGG-ID: spHmT5qsP-Oxe5AD2sK4HA_1767585009
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4f1d2aa793fso372486191cf.3
        for <linux-kselftest@vger.kernel.org>; Sun, 04 Jan 2026 19:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767585009; x=1768189809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PD0MEl6rVwz2bUrpGYdOAu4vaIcu3nhZz3+NE6MOYH8=;
        b=r7tg849VtxiEz1alUCg8580Mw7c9KcF9LKwB3jRXqrYaTtJVSbeawh+q009wzS8a5b
         r8Fw0e84ke0HPPb+5yefau1R9HHxqNsN2TW2u6uspuTUYuJT8B5RDbfilQy5UUOL1xug
         TVSnvO8r5044GgQybCumZXFoAdWIvi1iivPWjMO1i6MnAGGBc0//ijgicjzK4nWAX5m3
         IcHfe5AmUJfs3YTKro2kgsR7HnWiAbtKl+zPb5va49qmpkG9KAQzOdqdjHQzwM8rN6fR
         Ay6naNcrv6/1wqq0APpbNezJtj2M/ggUVjynh9MGhlICvu4CovVxFx3F0IWiQ+7aMpDh
         77pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767585009; x=1768189809;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PD0MEl6rVwz2bUrpGYdOAu4vaIcu3nhZz3+NE6MOYH8=;
        b=RI3jPLGHDAZVhj57AlVDcsD5J3xBbFLYCgWW5PtZ9MCv5esrC4iypVWb+C7zZX/355
         9UcZRqQn4N5oejmZfHWIPS10aORoFL2JcidA5nF/u1CB9Ep+jEUFInmOrW5a49pkNs46
         WBoiAmS5cUjaRv7hCA/BWiAt7U1kuKRFIeLVuwhEgVnQPefp9Trv2sPh5E6vCtxctOI1
         GYzGP9+MJuZ2Y7ScH44HeN44rIT3dQsG9jKYPNIbgShSU3HkZ+98X3z0/pXOAXqVeOkq
         1F5AlPwSFq/e6ee6prffPFP+u8mopnGjKdsVkQslO3f6kaKpw/8ATi2ud+U2dNoALXmS
         dqqg==
X-Forwarded-Encrypted: i=1; AJvYcCXJuEYD2bIc+fuJfMrZLD6UamPFaSst2VXkLuF7hQLFKf4a1f0g5pO2YaY+DnASvyHXNDeBOLK41nBboaHenxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/3XoufarOu32nkmeN8zD8IpArXLOKBOJndDxQVlfSsO98B4rD
	tGn8TyCXa7mueLc2fO+Qg23g725w+axE5JyeLFU1kicMyAve8hGeZEoGEuwEysTs6TWA869Wg4L
	RWEG1nzIlL0Rtc8hgyagzmXod/Kt9Euv8cymyHM72rDd0acV6nabTMhHzJIoAReCAZqfpbg==
X-Gm-Gg: AY/fxX5IAW09zSYAsEd1pfGRB1ece6xkBJbqbwiQnzCgKRQ7Jqm7G1NUec2fr4k3yQK
	47rDFJmIIvQuZEDqA7ujAiLjnP5+gc0bMHyC+k9aeKr0lROVi8PI7QuwnstXIwpU1k4T8F47WMU
	9H3gKckwyrnO/r6TBbLbMLwnAaptpUlC3d8ZjZv6SGabltD1S2rbssZ6e6UmCTneSiVZQv1Cct1
	aCEKY0/gjiYOgzo6DvNNym20HNKhO7X2DWhFxGiJQF9ztZYt6p89pq5fnHcU+TtsTyZdrV3zq26
	bDI3lJMjJ4MIej4drfPzd1RvizXd/FqPW+O3Wa9hebzxBTB/jioK46/kKml/wBuqSZjEcsO90yb
	vsknMeDIB2OnfUdW373BedUX0a2I/YYMhWIt4fEcxhJcFX+qCFz6tc7xR
X-Received: by 2002:ac8:5714:0:b0:4ed:b06b:d67d with SMTP id d75a77b69052e-4f4abd79a65mr582521771cf.45.1767585008720;
        Sun, 04 Jan 2026 19:50:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkwS8SyehM2DllDrPuVXzQrdiIA0f2H+sYM9WpUbWfA0eRV5XDIe78w7mLls06KQ90bmXcCQ==
X-Received: by 2002:ac8:5714:0:b0:4ed:b06b:d67d with SMTP id d75a77b69052e-4f4abd79a65mr582521611cf.45.1767585008261;
        Sun, 04 Jan 2026 19:50:08 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0973f28b1sm3638887485a.42.2026.01.04.19.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jan 2026 19:50:07 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <ec6e1ee4-b52e-417f-9413-3dfca0ec8eb3@redhat.com>
Date: Sun, 4 Jan 2026 22:50:06 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.20 PATCH v2 2/4] cgroup/cpuset: Consistently
 compute effective_xcpus in update_cpumasks_hier()
To: Chen Ridong <chenridong@huaweicloud.com>, Waiman Long <llong@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 Sun Shaojie <sunshaojie@kylinos.cn>
References: <20260101191558.434446-1-longman@redhat.com>
 <20260101191558.434446-3-longman@redhat.com>
 <758f42df-52c2-4660-8ef7-1cbacb9323d2@huaweicloud.com>
 <f8539426-92b0-42f3-99c4-70962c2db96d@redhat.com>
 <c17051c3-82ac-4ca5-8823-33327cadd073@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <c17051c3-82ac-4ca5-8823-33327cadd073@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/4/26 8:15 PM, Chen Ridong wrote:
>
> On 2026/1/5 5:25, Waiman Long wrote:
>> On 1/3/26 9:48 PM, Chen Ridong wrote:
>>> On 2026/1/2 3:15, Waiman Long wrote:
>>>> Since commit f62a5d39368e ("cgroup/cpuset: Remove remote_partition_check()
>>>> & make update_cpumasks_hier() handle remote partition"), the
>>>> compute_effective_exclusive_cpumask() helper was extended to
>>>> strip exclusive CPUs from siblings when computing effective_xcpus
>>>> (cpuset.cpus.exclusive.effective). This helper was later renamed to
>>>> compute_excpus() in commit 86bbbd1f33ab ("cpuset: Refactor exclusive
>>>> CPU mask computation logic").
>>>>
>>>> This helper is supposed to be used consistently to compute
>>>> effective_xcpus. However, there is an exception within the callback
>>>> critical section in update_cpumasks_hier() when exclusive_cpus of a
>>>> valid partition root is empty. This can cause effective_xcpus value to
>>>> differ depending on where exactly it is last computed. Fix this by using
>>>> compute_excpus() in this case to give a consistent result.
>>>>
>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>> ---
>>>>    kernel/cgroup/cpuset.c | 14 +++++---------
>>>>    1 file changed, 5 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>>> index da2b3b51630e..37d118a9ad4d 100644
>>>> --- a/kernel/cgroup/cpuset.c
>>>> +++ b/kernel/cgroup/cpuset.c
>>>> @@ -2168,17 +2168,13 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
>>>>            spin_lock_irq(&callback_lock);
>>>>            cpumask_copy(cp->effective_cpus, tmp->new_cpus);
>>>>            cp->partition_root_state = new_prs;
>>>> -        if (!cpumask_empty(cp->exclusive_cpus) && (cp != cs))
>>>> -            compute_excpus(cp, cp->effective_xcpus);
>>>> -
>>>>            /*
>>>> -         * Make sure effective_xcpus is properly set for a valid
>>>> -         * partition root.
>>>> +         * Need to compute effective_xcpus if either exclusive_cpus
>>>> +         * is non-empty or it is a valid partition root.
>>>>             */
>>>> -        if ((new_prs > 0) && cpumask_empty(cp->exclusive_cpus))
>>>> -            cpumask_and(cp->effective_xcpus,
>>>> -                    cp->cpus_allowed, parent->effective_xcpus);
>>>> -        else if (new_prs < 0)
>>>> +        if ((new_prs > 0) || !cpumask_empty(cp->exclusive_cpus))
>>>> +            compute_excpus(cp, cp->effective_xcpus);
>>>> +        if (new_prs < 0)
>>>>                reset_partition_data(cp);
>>>>            spin_unlock_irq(&callback_lock);
>>>>    
>>> The code resets partition data only for new_prs < 0. My understanding is that a partition is invalid
>>> when new_prs <= 0. Shouldn't reset_partition_data() also be called when new_prs = 0? Is there a
>>> specific reason to skip the reset in that case?
>> update_cpumasks_hier() is called when changes in a cpuset or hotplug affects other cpusets in the
>> hierarchy. With respect to changes in partition state, it is either from valid to invalid or vice
>> versa. It will not change from a valid partition to member. The only way new_prs = 0 is when old_prs
>> = 0. Even if the affected cpuset is processed again in update_cpumask_hier(), any state change from
>> valid partition to member (update_prstate()), reset_partition_data() should have been called there.
>> That is why we only care about when new_prs != 0.
>>
> Thank you for your patience.
>
>> The code isn't wrong here. However I can change the condition to (new_prs <= 0) if it makes it
>> easier to understand.
>>
> I agree there's nothing wrong with the current logic. However, for clarity, I suggest changing the
> condition to (new_prs <= 0). This allows the function's logic to be fully self-consistent and
> focused on a single responsibility. This approach would allow us to simplify the code to:
>
> 	if (new_prs > 0)
> 		compute_excpus(cp, cp->effective_xcpus);
> 	else
> 		reset_partition_data(cp);
>
> Since reset_partition_data() already handles cases whether cp->exclusive_cpus is empty or not, this
> implementation would be more concise while correctly covering all scenarios.

effective_xcpus should be set when exclusive_cpus is not empty or when 
the cpuset is a valid partition root. So just checking new_prs for 
compute_excpus() is not enough.

Cheers,
Longman

>


