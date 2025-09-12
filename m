Return-Path: <linux-kselftest+bounces-41280-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3645BB54435
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 09:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693931BC175E
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 07:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366A62D374D;
	Fri, 12 Sep 2025 07:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMvgFXIU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9575C2D3735
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 07:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757663590; cv=none; b=opVg0CTO5G+SAWlzKmrsH5jGdQK+86muwIT9jw08zg0uftGGKebmoUK3AO50+XTCvBAkkYrHaZS+2s47DexqSNbOnQUbM1FUFmv7U2EWTw5/dBxHJFgbeLH6OieGbI27Sx3CzHdg0wdw05A3u5s1iodSfZgnOnoZ92ZEfQKZcoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757663590; c=relaxed/simple;
	bh=DHF/SpXJs31eHtthTDeMe/efWHqXWnIwvBwhuvFJIug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bki1lczwtcPqOldipSH6mViJHli+ybqrYTTuNVIFpGDSiZZG3c/GM5NVYl9btK4nByLE6bUiRTrnhmO3PAPu7h+lWIdKqUOuCpK7v8BxC5EIzRIZKdQb/JUIFXcLaZ4iPbKsOOyKW+9u2BDXPrBg9ejbLkDLbARNmlBFeBXdIPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EMvgFXIU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757663587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=p22hl1mxPQvYXz93krcBnYpXobl8Fk3Ezh7wV4Ywahc=;
	b=EMvgFXIUIXa306XZljnEvNZRFMsMqgT4/08UBTSWpkKtfK16mGT683nJKPv4pWaHnyBvr3
	1OQR32aKW/U9IEH3GAggED41Oc28j0UQuuKgS1J6pme65rrfzTOyhECD6uWFZ7hJr8Wg/m
	Z6M1iXFui9ITHlcwTfgeYcmpzC6SG4s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-MgROHo-yMbikdj2dPZYbzw-1; Fri, 12 Sep 2025 03:53:06 -0400
X-MC-Unique: MgROHo-yMbikdj2dPZYbzw-1
X-Mimecast-MFC-AGG-ID: MgROHo-yMbikdj2dPZYbzw_1757663585
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3e7696b36d9so185709f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 00:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757663585; x=1758268385;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p22hl1mxPQvYXz93krcBnYpXobl8Fk3Ezh7wV4Ywahc=;
        b=f1rMde3nP+Bwq0J3i2rIpbOtY176NKKbo+ccaI8sXczM/zWQc9yDSSCUGDYlvSko4m
         Q2YpdGq36mxIbaqEU3yMAoQeTYwZ9ITZHBV54Jd1F5cc9Hckw1NNNieJ3wLPKTBOSpOe
         qvqNWnximALYfVMDQv+pL2PEKsZrlAPGQKi+yFc9T9KFxvjCB1wnGJLoyKvzcDwFWEy9
         rpGzQNrefoxjKuM6Es/41UqM4/jxX51YG596bEkeEGHYjk/KaBUv0Cmjd/PY+f+hKGIK
         z/ElWUlxVFnwA3FX934pF69ipE6L/s7hdbVyL58R7paVE0dpyDjSkCht/jmQRKXgUmeg
         PYSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyvJKXjszmJt2nx1keQ9p+bMMvxmFMoGfHDxsS/Kd+I0yDb0GAGbdJwCe7e5zYwnpb1NogfK0lurTasbGgVxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfHEYQ7jKn0HlNooB/dkkp723Pqd2eNfgJaxUWLN2OBu4S8Z6p
	/8y5jQEe5v2X17I4lgqgWNwnApF9eIzfV4cup1Dr2xmXuemwqJXwAKbLDfyHXeaKlmVxj1nZ36z
	6drIHJkdtGjtXECVdImmX4/O57dhITkdOC3jS/swDcTdRU4Kuw3QTmEbsQLTs3IMhwfEqRg==
X-Gm-Gg: ASbGncuevmXbGg1NvL1SMVo7dZvFStfKb1f6TcGFlwVG19NRKY4eupKN5znOVDQQpH+
	M51FSfZNFLKg2Zz8xYPhvEzoNy1QOEiHGIr1IrDECxJxpfZ9v/wUbb7VU8dnri/70F+CA9enlOn
	kVhhwRTuIiD5wTOkKhvrmbC/NSrlpMe83bfunxfpx2xjnB6GPTQW4Xav/vNJTsWBN7MNQg01KIb
	BufUw8wiUh2p+oAEf9Rr9ZLjLUgmig4TyguY3vqlmEyFMAmmEzYJY4uXl77tecxJ6M2OwbT3Op+
	okdnM6mk1e2YGeX3nfJFWsQ+NJsh3fWgCpfWsGOwrXqdCC8iZHqMvkmPAMzF95I6doYwTJPOZ3R
	J/UrNVVnfiLgg+ei+m5Sddge8l+hzeaaHk81EI5umE6mJftDFZbi0YoXxaSNFoxqDcik=
X-Received: by 2002:a05:6000:2003:b0:3de:e787:5d8c with SMTP id ffacd0b85a97d-3e75e1071bdmr5309935f8f.13.1757663584802;
        Fri, 12 Sep 2025 00:53:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq7C4qTXd+XsofeMwanjE1i08XNy6UqslUe+yjaLRudd1Ww9k5jR9x6r0SjXc+XP9zCsAuvg==
X-Received: by 2002:a05:6000:2003:b0:3de:e787:5d8c with SMTP id ffacd0b85a97d-3e75e1071bdmr5309885f8f.13.1757663584264;
        Fri, 12 Sep 2025 00:53:04 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e774a3fb5bsm805305f8f.58.2025.09.12.00.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 00:53:03 -0700 (PDT)
Message-ID: <a0e586dc-dce6-41a2-9607-f2f64b752df1@redhat.com>
Date: Fri, 12 Sep 2025 09:53:02 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory-failure: Disable soft offline for HugeTLB pages
 by default
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Kyle Meyer <kyle.meyer@hpe.com>, akpm@linux-foundation.org,
 corbet@lwn.net, linmiaohe@huawei.com, shuah@kernel.org,
 Liam.Howlett@oracle.com, bp@alien8.de, hannes@cmpxchg.org, jack@suse.cz,
 jane.chu@oracle.com, jiaqiyan@google.com, joel.granados@kernel.org,
 laoar.shao@gmail.com, lorenzo.stoakes@oracle.com, mclapinski@google.com,
 mhocko@suse.com, nao.horiguchi@gmail.com, osalvador@suse.de,
 rafael.j.wysocki@intel.com, rppt@kernel.org, russ.anderson@hpe.com,
 shawn.fan@intel.com, surenb@google.com, vbabka@suse.cz,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org
References: <aMGkAI3zKlVsO0S2@hpe.com>
 <749511a8-7c57-4f97-9e49-8ebe8befe9aa@redhat.com>
 <aMMNVA9EXXHYvmKH@agluck-desk3>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aMMNVA9EXXHYvmKH@agluck-desk3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.09.25 19:56, Luck, Tony wrote:
> On Thu, Sep 11, 2025 at 10:46:10AM +0200, David Hildenbrand wrote:
>> On 10.09.25 18:15, Kyle Meyer wrote:
>>> Soft offlining a HugeTLB page reduces the available HugeTLB page pool.
>>> Since HugeTLB pages are preallocated, reducing the available HugeTLB
>>> page pool can cause allocation failures.
>>>
>>> /proc/sys/vm/enable_soft_offline provides a sysctl interface to
>>> disable/enable soft offline:
>>>
>>> 0 - Soft offline is disabled.
>>> 1 - Soft offline is enabled.
>>>
>>> The current sysctl interface does not distinguish between HugeTLB pages
>>> and other page types.
>>>
>>> Disable soft offline for HugeTLB pages by default (1) and extend the
>>> sysctl interface to preserve existing behavior (2):
>>>
>>> 0 - Soft offline is disabled.
>>> 1 - Soft offline is enabled (excluding HugeTLB pages).
>>> 2 - Soft offline is enabled (including HugeTLB pages).
>>>
>>> Update documentation for the sysctl interface, reference the sysctl
>>> interface in the sysfs ABI documentation, and update HugeTLB soft
>>> offline selftests.
>>
>> I'm sure you spotted that the documentation for
>> "/sys/devices/system/memory/soft_offline_pag" resides under "testing".
> 
> But that is only one of several places in the kernel that
> feed into the page offline code.

Right, I can see one more call to soft_offline_page() from 
arch/parisc/kernel/pdt.c.

And there is memory_failure_work_func() that I missed.

So agreed that this goes beyond testing.

It caught my attention because you ended up modifying documentation 
residing in Documentation/ABI/testing/sysfs-memory-page-offline.

Reading 56374430c5dfc that Kyle pointed out is gets clearer.

So the patch motivation/idea makes sense to me.


I'll note two things:

(1) The interface design is not really extensible. Imagine if we want to 
exclude yet another page type.

Can we maybe add a second interface that defines a filter for types?

Alternatively, you could use all the remaining flags as such a filter.

0 - Soft offline is completely disabled.
1 - Soft offline is enabled except for manually disabled types.

Filter

2 - disable hugetlb.

So value 3 would give you "enable all except hugetlb" etc.

We could add in the future

4 - disable guest_memfd (just some random example)


Then you

2) Changing the semantics of the value "1"

IIUC, you are changing the semantics of value "1". It used to mean 
"SOFT_OFFLINE_ENABLED" now it is "SOFT_OFFLINE_ENABLED_SKIP_HUGETLB", 
which is a change in behavior.

If that is the case, I don't think that's okay.


2) I am not sure about changing the default. That should be an admin/
    distro decision.

-- 
Cheers

David / dhildenb


