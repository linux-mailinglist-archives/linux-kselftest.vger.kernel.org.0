Return-Path: <linux-kselftest+bounces-41754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF45B816C4
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 21:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5961C26C1E
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 19:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4744285C98;
	Wed, 17 Sep 2025 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AK+ltmqT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519AC26657B
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 19:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758135954; cv=none; b=c0rY/1VpNllL2OYhIZ4X66KZ3zjum9m3Ug/v3i4g/E20zT/1+7pcTRYPaiagMll1uyl2pa2g6xsqevfcPn3kY35dryb5UZCN/47P9olAryBDafD2x8iPHeFUSvegZuTXODaZrcGk+h3TiZDOTGeSt/NWXuWOMzI5EkWC1MW+SzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758135954; c=relaxed/simple;
	bh=4r3OnglhmQv5f95g1m3EPAqqkjghukFweMHUd+HyG0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QpU7eKYUnSmLVyMgArC91V2Zx83558xPsVpIk6p4W4c+geY0FIXs224DCQCRUFqIsMaNoOuuxl6y56lLGCmRl2cTQGbGMIt7RyJmJCVDwNPZdD8RMEYkojK3HNxPuDR0pmaR13g9NV1EQOjSAr7mmdmya3QCGkdb3XbA6F3g6f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AK+ltmqT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758135952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iYdTqhfdz9F3OSmNWg0L2Bcl9ZF1XfZz244Dszls6io=;
	b=AK+ltmqT3Hk+/L+nmYJgWgiv7ClP/xZf4t0vdq8WBOnvWODYgcOiJ0C8pvobkeRxCtCWhx
	D270Pz/azonePcc+Az06yPz5b5l5UL1tMXD3HyTF0w0592jz88Zw1mu+SxvmNjQU48Oo4h
	SG/g/0m2yWXEBswbVE2GvCjH+DfyT3E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-kOszPNPjP-G2V7p9-3_tCA-1; Wed, 17 Sep 2025 15:05:51 -0400
X-MC-Unique: kOszPNPjP-G2V7p9-3_tCA-1
X-Mimecast-MFC-AGG-ID: kOszPNPjP-G2V7p9-3_tCA_1758135949
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ece0cb7c9cso35609f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 12:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758135949; x=1758740749;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYdTqhfdz9F3OSmNWg0L2Bcl9ZF1XfZz244Dszls6io=;
        b=VQ9rDGL6Hjki9X6A7iTUAYhVfKz1eyFdHeOApEdZhbVKenesQlr0sa24Eyhe85ZtnZ
         Cl1XpCZhX3uZWC8GtUFkmsiHuBfusmgF7xLzbkvM4tTSz3Rh4YWCfh3W1GIk9Uj2ZOdw
         VDCxF7jiRmKzU9sNnY3P1+xlJCShLIhiEstnSjkSzS9TL8DehFPrMnLHynJfEdyFa1lF
         eK0MhMZ7vTzc/a3j/xH5aAQowCV9oH587S0kn7KXuDsXDREJHDk/LEB0srZFu40CJXtB
         uL/7c4X0zz0UqGfSuypEKYyBZAgPT0meaS4JN5Hg6zAIciOa5Ug4yMlyVlcx//kRZIfH
         VSRw==
X-Forwarded-Encrypted: i=1; AJvYcCUMXxDUcvay0sXH8RZPPFc50bO/2wySQIMwKNo+h7JcSmQh6pGdJ907Uy3gdZ7KJocnqZNACofhlpQY05di5iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUSq9RnYrTSDI8B3Wv3U2O9TQV3DhDISvIGc57FNPNYebQsmjo
	+8jj/daeg3rNTI36gQ6/xQyDmVWOw+PyJmFWXuNMKnl1/xVPq8sm/gMSjc5H6eNa4TgZVXINVEw
	XnCy3ly9csFWFGHSOcJU7/GPcEO9ueSnHG9YPRW0G4y/DOCHYNfL9emoMMvDlgYNKzkX4Zg==
X-Gm-Gg: ASbGncuSrwdhBK60rE/1dB0OLAqAAviLFBw/W+hR14yGOBux60kaXsXyMQzww3g2Qea
	vlFIv5Abtp/ZMG6P3rCINrtjvoBHY1VSLO7DVO/POospVAmhrxrsamMN1UU+JKL6savPcPaI/KP
	VyGibJTR8gtEBCNapdlI0a4azVdIIC5CmxYwaTYrwtU6DFIksfxKcaeqGuxBPMrXPipNwxnjDdt
	s2cnWDT47EwvIOL0Iv8aiPcm809gtFYI3iK6VrrGnDoKIOY3n2Tur92tnMx10Dpk20xX/TrvBYV
	7LRbRg9emRzR5bXYRTTmTiVG1CLsavHSHidqiyzA3E2+7+8cWiLJ4+dpkSmF2K3O7JF1FujcgY0
	9BGzNqO5ZhqVNpZ5ugA+nJOzFx1QkF+d9TNQnLVtT8pWOGdlxMeQ/nIBuSsjwAOeP
X-Received: by 2002:a5d:64c8:0:b0:3ea:e0fd:290b with SMTP id ffacd0b85a97d-3ecdfa0d2f1mr3067863f8f.40.1758135948709;
        Wed, 17 Sep 2025 12:05:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkB9K5+m3ks5tDl26fGtwUBcSZFKAuJY0U4QfQl4kZMxsZJ5NivU//n+3kzLJsG+tBhuQWwg==
X-Received: by 2002:a5d:64c8:0:b0:3ea:e0fd:290b with SMTP id ffacd0b85a97d-3ecdfa0d2f1mr3067845f8f.40.1758135948270;
        Wed, 17 Sep 2025 12:05:48 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f27:6d00:7b96:afc9:83d0:5bd? (p200300d82f276d007b96afc983d005bd.dip0.t-ipconnect.de. [2003:d8:2f27:6d00:7b96:afc9:83d0:5bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07412111sm453030f8f.28.2025.09.17.12.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 12:05:47 -0700 (PDT)
Message-ID: <cd71fac2-bb9d-4e84-a074-2b695654e655@redhat.com>
Date: Wed, 17 Sep 2025 21:05:44 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/memory-failure: Support disabling soft offline for
 HugeTLB pages
To: Kyle Meyer <kyle.meyer@hpe.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, akpm@linux-foundation.org,
 corbet@lwn.net, linmiaohe@huawei.com, shuah@kernel.org, tony.luck@intel.com,
 jane.chu@oracle.com, jiaqiyan@google.com, Liam.Howlett@oracle.com,
 bp@alien8.de, hannes@cmpxchg.org, jack@suse.cz, joel.granados@kernel.org,
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aMsDJ3EU1zVJ00cX@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.09.25 20:51, Kyle Meyer wrote:
> On Wed, Sep 17, 2025 at 09:02:55AM +0200, David Hildenbrand wrote:
>>
>>>> +
>>>> +	0 - Enable soft offline
>>>> +	1 - Disable soft offline for HugeTLB pages
>>>> +
>>>> +Supported values::
>>>> +
>>>> +	0 - Soft offline is disabled
>>>> +	1 - Soft offline is enabled
>>>> +	3 - Soft offline is enabled (disabled for HugeTLB pages)
>>>
>>> This looks very adhoc even though existing behavior is preserved.
>>>
>>> - Are HugeTLB pages the only page types to be considered ?
>>> - How the remaining bits here are going to be used later ?
>>>
>>
>> What I proposed (that could be better documented here) is that all other
>> bits except the first one will be a disable mask when bit 0 is set.
>>
>> 2 - ... but yet disabled for hugetlb
>> 4 - ... but yet disabled for $WHATEVER
>> 8 - ... but yet disabled for $WHATEVERELSE
>>
>>> Also without a bit-wise usage roadmap, is not changing a procfs
>>> interface (ABI) bit problematic ?
>>
>> For now we failed setting it to values that are neither 0 or 1, IIUC
>> set_enable_soft_offline() correctly?
> 
> Yes, -EINVAL will be returned.
> 
>> So there should not be any problem, or which scenario do you have in mind?
> 
> Here's an alternative approach.
> 
> Do not modify the existing sysctl parameter:
> 
> /proc/sys/vm/enable_soft_offline
> 
> 0 - Soft offline is disabled
> 1 - Soft offline is enabled
> 
> Instead, introduce a new sysctl parameter:
> 
> /proc/sys/vm/enable_soft_offline_hugetlb
> 
> 0 - Soft offline is disabled for HugeTLB pages
> 1 - Soft offline is enabled for HugeTLB pages
> 
> and note in documentation that this setting only takes effect if
> enable_soft_offline is enabled.
> 
> Anshuman (and David), would you prefer this?

Hmm, at least I don't particularly like that. For each new exception we 
would create a new file, and the file has weird semantics such that it 
has no meaning when enable_soft_offline=0.

-- 
Cheers

David / dhildenb


