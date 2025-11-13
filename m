Return-Path: <linux-kselftest+bounces-45509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8BEC55A19
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 05:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 85E49346AE1
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 04:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE81E29DB61;
	Thu, 13 Nov 2025 04:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIG5KhQz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YiRJbblu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E922D94A6
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 04:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763007139; cv=none; b=a9bBg5d+WEdw2jvuK/W4xpQmg0t0fHcVQ1WE8iOi8dreldj0L/YZAjhghxI+Igc2HqpeLtCQpGgbXubLUkOb3EcGzoXB4V77wRS0DXg+c36xzKjiVRGVAyVg+JICqcIFaJv2/v7nqtNBrTirl7UYIYfOvJLQHAm4M9TVqFQPlGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763007139; c=relaxed/simple;
	bh=5KVcUwFam+d3kfWZaKYqsgN5CXXYEyx0nSIK4JVGF1c=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BKgEDxJgXWNSazhLUZIFfGUhArXsCYuw9AUln7Ri/AaMOGqm6y4YcuK/RbaGbawK1WvGuMXJmH6nsnKGOH+YQLbsyeDHELHYN0IX0G/BhHZY6nmjaghVncBM4hT6BNDU4zd8UNUZP8XWBlI2824VZi23yd0qm3xhl0GOr/dFtxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fIG5KhQz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YiRJbblu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763007137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXF2BvFrpcJte5UaMjynGshHJ8MIVF48yxM6S+pDvV4=;
	b=fIG5KhQzasVtoJSdBd9yG6ME2o2Tm8wmTbC6ZJA68bc40Nb707bajzHlJ8ikMyOim6fQcL
	s+XmXiLPI33A91abaDsABNFhdZoMOKMOMw1fMN4cH1FLDJW0uEiM/ZOrTOQyA3EkYgMqwX
	x27OuPZLbfeAGlGeYvgHFsP+cHBjZ9c=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-BoFked_uNgeu7NRKhO0y-A-1; Wed, 12 Nov 2025 23:12:15 -0500
X-MC-Unique: BoFked_uNgeu7NRKhO0y-A-1
X-Mimecast-MFC-AGG-ID: BoFked_uNgeu7NRKhO0y-A_1763007135
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8805054afa1so10662456d6.0
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 20:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763007135; x=1763611935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PXF2BvFrpcJte5UaMjynGshHJ8MIVF48yxM6S+pDvV4=;
        b=YiRJbblusMl0T6AQKNqzBM00P628i/eBpaDgGFXuoFGV1OyHPbO+9QhLPMWNdznaCO
         hwjjsdyasfWYPzvABQDVcAG8XVRS4MG9wWEFGVCaw9NfaJxFf9ZCgrr/29qSuoG4pwKo
         IOSmDWOPDDXFySES9PoFH88/LehNn/nlyo4BTIycZJV+oNBZe6slEcXXOb2nwnsw7mMW
         OEp5ZNyvPFyf/LKklj7i+gXrJ8qjl5nwW+96HROfKgjISpVU8XMXg4wvwurR5lwuFy6S
         /AXNaioXuGeIgnfN305mghZH/XBV0pPiph7AAuIYFBB8xWZG0IcGKzJ05W9rRpyaGUhy
         ixFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763007135; x=1763611935;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PXF2BvFrpcJte5UaMjynGshHJ8MIVF48yxM6S+pDvV4=;
        b=Udq9ayk9qYBdM5IblqZnlYeFjVGNA5xmP4Bed3VWZ2UfHMmpRHjnNa78ErvWPQSDn5
         u6P1NEQko66Mz2jkgg/ptED9BOODnwBUD46bY59GzJ258kr9fh9aBBAZ9X/eTpzVvgD2
         cvmQ6awmWhBxIF3kucXbkchLKDIbaUjxXn6R1w4xlk+ngr9a33Jq4evu58m3OBHYrPhS
         7r6ptDCIksDto5IXJxKsWRFJB21mfPwkYpOwwPen0/FijtxPD5XEXaTm4YoctuGFTKdV
         fliWe+TTSn3o/V1fW1UZE7Q914F7Cg/J2cpL8Y7pemBemYqn+XPINHCc+Dt1FidwT9WY
         8kNA==
X-Forwarded-Encrypted: i=1; AJvYcCULBLUcctgLACT5BqebIGkVP0sfsuDIog3EkQ0OR2LNZhucLHER6Tbl7uc2KAHZz8gkzbpGaLO+Nx4AMUUfuyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp5sq6jfyLe8rwtL1bfN329l80hCyE5Z64KrP0hnbxsMW+Me7H
	H15xOXvpK7CRIcfzs2iHiZl8od21U1Xix+2yRFb6lfGWr+YpxX4WF2aKAa4OMmNk8ND9Geb3qu+
	LPFdbMiJNOEj21sItM6W+4nh3mpQzKvdDjTNBrgRYpOctHUYQ77JkA+rW2uTDB1BCk9hAPw==
X-Gm-Gg: ASbGncsXSy/W7q+Q0VXfd7dR0E+NqsALeYV1Jc6bcSA8OVc2bS9RZ3IefERZvxgTl/Q
	31UwgiP7fDoswU87Rnl8ND3OQgyN12wWoZnkyYYUF5Ej7bEcTcEn0DsrsXQuaSvD3adN8y8Sj9P
	uyt8VHvWQM7Y5Vr2mGUdq8XoQiuWxQgVRMMkrXV0fy4GVEMghMAA7ZLKPHH+uhheMSdHxX7Juyz
	80OM8LwIk8+5rsIB3KGLDZu8gjnOnZgFDnuVOd86dTpqcjDTHngEHtoUbYYW87BgPVxTsJCf09A
	4HjlOqVRD0dYr5iEFdgFP+mY3IqgkqOi7U/X+35Gu08pgZrn9wZF9BYVEpEttNmhVbQOAONxzOV
	2Dt0AYWvaDvqddsx7Fc23biR62S4ZAqTmHfxJ6QbDnBcuJQ==
X-Received: by 2002:a05:6214:1c48:b0:880:4bdd:eb99 with SMTP id 6a1803df08f44-88271a39bf8mr81658486d6.50.1763007135030;
        Wed, 12 Nov 2025 20:12:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRDhCLizq1RLY3ln4mDWmpcPMOmzDiMDvejsHPgswmKFEfCLHM0V9nS2E9rZHYrxzUs/bBHw==
X-Received: by 2002:a05:6214:1c48:b0:880:4bdd:eb99 with SMTP id 6a1803df08f44-88271a39bf8mr81658336d6.50.1763007134668;
        Wed, 12 Nov 2025 20:12:14 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88286318333sm4839906d6.24.2025.11.12.20.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 20:12:14 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <b97e1f53-3b6a-4d2a-82fc-3150565e266a@redhat.com>
Date: Wed, 12 Nov 2025 23:12:13 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpuset: Avoid unnecessary partition invalidation
To: Sun Shaojie <sunshaojie@kylinos.cn>, chenridong@huaweicloud.com
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, shuah@kernel.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <b9dce00a-4728-4ac8-ae38-7f41114c7c81@redhat.com>
 <20251113033322.431859-1-sunshaojie@kylinos.cn>
Content-Language: en-US
In-Reply-To: <20251113033322.431859-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/25 10:33 PM, Sun Shaojie wrote:
> The reviewer mentioned they couldn't see my original patch, so I'm
> re-quoting the key changes below for clarity:
>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 52468d2c178a..e0d27c9a101a 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -586,14 +586,14 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
>>   * Returns: true if CPU exclusivity conflict exists, false otherwise
>>   *
>>   * Conflict detection rules:
>> - * 1. If either cpuset is CPU exclusive, they must be mutually exclusive
>> + * 1. If both cpusets are exclusive, they must be mutually exclusive
>>   * 2. exclusive_cpus masks cannot intersect between cpusets
>>   * 3. The allowed CPUs of one cpuset cannot be a subset of another's exclusive CPUs
>>   */
>> static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
>> {
>> -	/* If either cpuset is exclusive, check if they are mutually exclusive */
>> -	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
>> +	/* If both cpusets are exclusive, check if they are mutually exclusive */
>> +	if (is_cpu_exclusive(cs1) && is_cpu_exclusive(cs2))
>> 		return !cpusets_are_exclusive(cs1, cs2);
>>
>> 	/* Exclusive_cpus cannot intersect */
> Here are the main changes, where the conflict check for step #6 in Table 2
> is performed. And these changes have no effect on cgroup v1.

cpus_excl_conflict() is called by validate_change() which is used for 
both v1 and v2.

Cheers,
Longman


