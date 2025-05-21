Return-Path: <linux-kselftest+bounces-33458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 249ACABF47D
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 14:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0FFF17DF44
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 12:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B93265CB6;
	Wed, 21 May 2025 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gV52cut4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D56925D8FC
	for <linux-kselftest@vger.kernel.org>; Wed, 21 May 2025 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747831227; cv=none; b=GAUZIE4aXs8Rvci+gC3/MeHR5YeBeeTVMH35DQ7nnAHz5VITXb+Gm82D8h3e0HEbNMuUR1V4knLepzLMUjzLRY1b8X2Om3PUgVdR1mnhx3f02KF+j/RARLxPZLetBRWJoxTJiNjBuT5IPoHAo0iiiNGdeaINMpzk0/vGl58PYBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747831227; c=relaxed/simple;
	bh=tTqNFmY7Fo+W9DQPNJ04izuxXClK18UgfLsPJ1r3CfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RvxuzP2bhp409eki7BE21ths/OYw7HM6WP13gPVui9G5ctWPCG1ydEhiUSuqZ2ZEOMZ/uhzAtN2aXMoB9ojMUuZRIPgCtZc7YGg9iksJxC4N1p7E2TOOjE54GBmiWORi0JDAbb3fZQYchnZCW7JRC82AAv8uavuTiS0DGDkWjqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gV52cut4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747831224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=47i7ScqL4Dt1l5IDcflwbZQ28MiUnTzedB2xEZMgKIc=;
	b=gV52cut4fjupoytGTRhZefyioyjWkDR36BsYgKD4V05h9jka+coXw0//DYKB/K0+PL5law
	m2g04/ulzbEWPN6+dtM7scDvHSAWdHXyAqxCzCBWX3+DJpDKn7v+j1cGTVHZptrGklbu7U
	rwYe+G/z3GJkgj/BuZXEIJmdcd8FZ5Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-AteyjrksNja6_T4UfqhLlA-1; Wed, 21 May 2025 08:40:22 -0400
X-MC-Unique: AteyjrksNja6_T4UfqhLlA-1
X-Mimecast-MFC-AGG-ID: AteyjrksNja6_T4UfqhLlA_1747831221
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a370309dcbso1599590f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 May 2025 05:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747831221; x=1748436021;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=47i7ScqL4Dt1l5IDcflwbZQ28MiUnTzedB2xEZMgKIc=;
        b=v/mt/4v+w3kH/D8SRgsFDdv/j2JwT/DFbdyJgvO90d7KtGzRHPQzkhKbsht6OxnKKv
         cy/yksoM4znglf9GekaUQm94zZVSF9LACi1hR+U8Ufgk6pjreyqK5poxmrfgC0pAj0T6
         uZLOPRKu9kpgDguMdj1nk/95efQDZ6En2IM7yCc2/uC1g8KuoOA6sRUeM53oJLYgsRvb
         JzcwIWBd8yDDAYUeN9SMgNpE2HVERRnWZmVFf7StjZuA7B0GngvUOQ0afH4mK6MgSAs+
         +/g/5N40j7n8RhARsEhEXoft9BXTRCinjlr5o2BVnJwgLm4bssw06q5JWrpUFcek0fkS
         9xmA==
X-Forwarded-Encrypted: i=1; AJvYcCU+8BiaQBQd08oLBTev4BOCIAq5rkgbUutn1sKkEAO28YnqZjYedq2mvNMwGtMcSSYu8soRgkE97IYgGTuuiiE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqa/HvARR1HM0ElYDQbOkV75aQ2Kfv7SH/8+ugMVYVzWMtnHmJ
	ABhVdN5uWmFk7nSvI+YtdAlXaQfzPph45rZ+KFiJFC2x4sTobBWL0mSR2ZNrViGuycIsKQghkx4
	B8ME67QXl7TiDlOJIbGdbGjvWgwSZS/Xa11/A335m4cAB9LKeAuF4pDf6fm/ylcBRsmRJIQ==
X-Gm-Gg: ASbGncsSTMJkxS0jG5DI2hKxikYZ0dbEYZDIfnFDWN0RNiZk6wT5xskRbKan/7wS9fo
	mzPNuqvTiXNjhODrnVwnM9/AyI//d71nVrBiqQWloOqhPI/M4MXcBkPadH8BxKwnWCGCCK+MGXn
	JgBSFjJcY2X/8QrwJddBRsgNvyxGfgMxTGfYJNYMSqAxP+6BWJaBg3IBjbVXzfY7CcDwDMgpKPC
	HizmzJkS2LWT+CicrXyOmuN/b7RtG5TQyCVFaPtu09N+Yj5Cau4x+FpKKY/hb/rYv4YNwgY+cG1
	NZnCENS+Y7RlhpeVMv49ovx4mGVSiJgY0BCuDZ7U+PXM+TCO2w1hERrERyv4B6CAs3cPyMK09r0
	rvuSj3mB303cda1WMzSjFzPKd/U8N3B4M26925mo=
X-Received: by 2002:a05:6000:2085:b0:3a3:ec58:ea81 with SMTP id ffacd0b85a97d-3a3ec58ef6bmr2132403f8f.42.1747831221429;
        Wed, 21 May 2025 05:40:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELT/ajcBAx5hniEy9ixvTLJkxiRoZyN5z9+vEaPoPoysqIknJuVEHsl42ksznPlxQM6GRRuw==
X-Received: by 2002:a05:6000:2085:b0:3a3:ec58:ea81 with SMTP id ffacd0b85a97d-3a3ec58ef6bmr2132360f8f.42.1747831220972;
        Wed, 21 May 2025 05:40:20 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:9c00:e2c7:6eb5:8a51:1c60? (p200300d82f259c00e2c76eb58a511c60.dip0.t-ipconnect.de. [2003:d8:2f25:9c00:e2c7:6eb5:8a51:1c60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca888afsm19964905f8f.64.2025.05.21.05.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 05:40:20 -0700 (PDT)
Message-ID: <53fb879b-dde8-43f2-9324-c367570a9c60@redhat.com>
Date: Wed, 21 May 2025 14:40:18 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] mm: introduce THP deferred setting
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, rientjes@google.com, hannes@cmpxchg.org,
 rdunlap@infradead.org, mhocko@suse.com, Liam.Howlett@oracle.com,
 zokeefe@google.com, surenb@google.com, jglisse@google.com, cl@gentwo.org,
 jack@suse.cz, dave.hansen@linux.intel.com, will@kernel.org, tiwai@suse.de,
 catalin.marinas@arm.com, anshuman.khandual@arm.com, dev.jain@arm.com,
 raquini@redhat.com, aarcange@redhat.com, kirill.shutemov@linux.intel.com,
 yang@os.amperecomputing.com, thomas.hellstrom@linux.intel.com,
 vishal.moola@gmail.com, sunnanyong@huawei.com, usamaarif642@gmail.com,
 wangkefeng.wang@huawei.com, ziy@nvidia.com, shuah@kernel.org,
 peterx@redhat.com, willy@infradead.org, ryan.roberts@arm.com,
 baolin.wang@linux.alibaba.com, baohua@kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org,
 corbet@lwn.net, akpm@linux-foundation.org
References: <20250515033857.132535-1-npache@redhat.com>
 <a8bc6012-578b-412a-8dc9-fa9349feaa8b@lucifer.local>
 <CAA1CXcD8FCdCsBkyW=Ppbr-ZRD8PNmPu-3khipX0fVK3mxs-EQ@mail.gmail.com>
 <c027a3db-eb6d-4a3c-98b0-635f3f842ee6@lucifer.local>
 <43d6aa16-3e52-45df-9366-e072c0cb3065@redhat.com>
 <a41ea49b-2bac-44c8-9a4a-dd55dfd0d171@lucifer.local>
 <db190425-9959-4d0c-b928-c537c69bc5a7@redhat.com>
 <085de112-7238-4bbe-822c-198a7291ea89@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <085de112-7238-4bbe-822c-198a7291ea89@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.05.25 14:33, Lorenzo Stoakes wrote:
> Fundamentally I trust you to make sure this all goes correctly so let's not
> belabour the point or delay things here :)
> 
> So in that vein, Nico - I would sugesst for future respins adding a really
> clear bit to the header as David suggested :) also update the cover letter
> tests so it isn't reliant on a possibly ephemeral web link.
> 
> But otherwise let's proceed as was.

Right, and maybe only post this series if there was a major change, 
otherwise wait until the other thing is on it's way upstream.

> 
> On Wed, May 21, 2025 at 02:24:45PM +0200, David Hildenbrand wrote:
>>>>
>>>> Anyhow, to me the dependency is obvious, but I've followed the MM meeting
>>>> discussions, development etc.
>>>
>>> Right but is it clear to Andrew? I mean the cover letter was super unclear
>>> to me.
>>
>> I mean, assuming that it would not be clear to Andrew (and I think it is
>> clear to Andrew), I we would get CCed on these emails and could immediately
>> scream STOOOOOP :)
>>
>> And until this would hit mm-stable, a bit more time would pass.
>>
>>>
>>> What's to prevent things getting merged out of order?
>>
>> Fortunately, there are still people working here and not machines (at least,
>> that's what I hope).
> 
> Obligatory link to this :P
> 

It's scary how relevant that has become lately :D

> https://www.youtube.com/watch?v=5lsExRvJTAI

... fortunately, whenever I tell the chatbots that they are wrong (IOW, 
everytime I use them) they reply with "Oh yes, you are right." ... so 
far ...

-- 
Cheers,

David / dhildenb


