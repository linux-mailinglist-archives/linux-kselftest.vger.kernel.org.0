Return-Path: <linux-kselftest+bounces-33456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89558ABF44E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 14:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69741BA19BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 12:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB46264A6E;
	Wed, 21 May 2025 12:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfOpjPXZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6617625F7B5
	for <linux-kselftest@vger.kernel.org>; Wed, 21 May 2025 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747830293; cv=none; b=ZNqTF5lY8RDtFyX6jvh58D3G+dlUh4ZxgzyWCIr2GAPJE/YPFeDWiTjXVur/Sm9ru2SqPWfNkS27UvoT+0zKjcPScGNZ/PVid8MY3+aB0Fhxicu0wQR4SVZH0sqBte3iWx7QvtK5Ipns4hNo8jajHZ/eN2BNEcytcIgTN0E36ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747830293; c=relaxed/simple;
	bh=wjLY7AIai8qSlFWdRLQdWDD0L4OkD/Igtz6mbreEDLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ifj+dXIzkDHJyHkazXvhijF2hqKUkNeD3q+Ne/QO++CHaYeQcwnUE3ZINGlBQ3ifTzIdTeZ2qeRXPeKfvIsAoB5hZ7H6mtBfZdSY2nGFl4QVOWvKY/GKHTAoJd+WbzBnj3pw+DdTcDZyzwjurv+CNwr13mIg/R505clozh/qOsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DfOpjPXZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747830291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o3U/NCNCT27I8c/APqD5BdP8Dg6ivclL0fCgxsI3jm8=;
	b=DfOpjPXZm9hcEMoYQZy8lOXF+J+0wiMpqukgzKrTgI14zJ0722Sjj/7P7EM9RXgPh/BXOP
	wK/DqXs9RLECV/tJb9g5Jif2t2OzYK3FGU0p0eYq4f7j0xXOWsSLSoyZABdnAO3y+hAG4N
	xq/TiG6xTBOVmgziBT3X+PuAEcEMVYk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-XaUPdZkCMDyumhDK3sYk-A-1; Wed, 21 May 2025 08:24:49 -0400
X-MC-Unique: XaUPdZkCMDyumhDK3sYk-A-1
X-Mimecast-MFC-AGG-ID: XaUPdZkCMDyumhDK3sYk-A_1747830288
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-44059976a1fso28553285e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 May 2025 05:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747830288; x=1748435088;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o3U/NCNCT27I8c/APqD5BdP8Dg6ivclL0fCgxsI3jm8=;
        b=PXwnjuS2r6t7OYBL09yMFSm0N/4h1LbyP0JBXt+4MLpJJdEOg2g+K47KultDH3rC0D
         IbEWYjDOVgfMTl1SZg33vOqOBbhIyxWy+lvRLwKgNwDQH8Lglqkqfsn/IuwuUuAX5b5d
         27+Xi97FMHJaQtgOmGUA/VWLunN+8/TIn8kxjNcfEdlCewk0wccFvcmgHM1Q21eqEZLf
         2L+HepW6ju1KdceXMj4qedRAbBOyU2WES4Ig0zF6xhjbafi6be7BL4ZhN9LQXwzbWdih
         Lmhr/M5YxDTFolJ6i/zVR9SgdfXkKfdi1edszCohFwDARH60BAhLPuUzWAJRijJD4z/r
         la/g==
X-Forwarded-Encrypted: i=1; AJvYcCVrRKJAkkYf3kypY6OSlsuY/1w0y1N8xpXYSNE0dNYm7Bkz5qwjVpMiKKS51xpeAGVS4IphLG2OC9urDmkxqpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO/Regalb4yTGpln92nb3Q0SXYpIs6XueG5zMExZ/RTdDG1L+I
	vbI/LOjqSI5GQS8l90ohtzPuc47fspdZnQwQTz80EPCyOzibcXeUohHdipBM2RugVPsj4R2/6zD
	SqTm0OxaIMANt06O35WTrcAHp6NuwKTTyMbNzcImYLSYqL60Y1Rj9Jpj0+LhNDPleCGGHaw==
X-Gm-Gg: ASbGncuXKqUoaw8WnXE4RnJLkjNy2l5F3w2uJkAJMH9Myr/9cKj+JVYVFtAIx1NNC2E
	O71qAlyghC0zvO2MX2sTtMHfWsD7l8AsqnI4H/dwl1Ci9rASespDNRztpTVBtNGLvHNEyNJKYu5
	fj+8kJtZPB9fAlb3xYdORzA7hOcyuTPo04Fh7DpIMqzmLi1HewyNyHMF/hdCggiijGKlSp8KrGN
	3sTewO/pELStA8Z3j1HNakzgXkvuo4FVBV32dZK9ofT2icpJ3lSWiAZZrN/Qkd1Mi2buCBZBGIl
	3GzBqxWqQZLxK+DDGm0fqFPYzEGdxgli9WjNTbO6FpYkqJOOa2H/D/AF+KFUwB3YwnlPUeqx+Rl
	r6gioVCBRw8Mh0rvy9dKm58sBW8xSRj5jPF+eEaI=
X-Received: by 2002:a05:6000:184c:b0:3a3:6aa4:bf28 with SMTP id ffacd0b85a97d-3a36aa4bfe0mr12682517f8f.10.1747830288351;
        Wed, 21 May 2025 05:24:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlp35uB+nW8DT5l428dL7oAEzwqU6VVd2srOdXBOOPxCe7UlC6ZTPSsou+1mi29prF4u88tg==
X-Received: by 2002:a05:6000:184c:b0:3a3:6aa4:bf28 with SMTP id ffacd0b85a97d-3a36aa4bfe0mr12682472f8f.10.1747830287846;
        Wed, 21 May 2025 05:24:47 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:9c00:e2c7:6eb5:8a51:1c60? (p200300d82f259c00e2c76eb58a511c60.dip0.t-ipconnect.de. [2003:d8:2f25:9c00:e2c7:6eb5:8a51:1c60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f1825457sm70806135e9.1.2025.05.21.05.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 05:24:47 -0700 (PDT)
Message-ID: <db190425-9959-4d0c-b928-c537c69bc5a7@redhat.com>
Date: Wed, 21 May 2025 14:24:45 +0200
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a41ea49b-2bac-44c8-9a4a-dd55dfd0d171@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> Anyhow, to me the dependency is obvious, but I've followed the MM meeting
>> discussions, development etc.
> 
> Right but is it clear to Andrew? I mean the cover letter was super unclear
> to me.

I mean, assuming that it would not be clear to Andrew (and I think it is 
clear to Andrew), I we would get CCed on these emails and could 
immediately scream STOOOOOP :)

And until this would hit mm-stable, a bit more time would pass.

> 
> What's to prevent things getting merged out of order?

Fortunately, there are still people working here and not machines (at 
least, that's what I hope).

> And do people 'just
> have to remember' to resend?

Yes, in this case Nico wants to get his stuff upstream and must drive it 
once the dependencies are met IMHO.

> 
> If there's a requirement related to the ordering of these series it really
> has to be expressed very clearly.

Jup. I'll note that for now there was no strict rule what to tag as RFC 
and what not that I know of. Of course, if people send broken, 
half-implemented, untested ... crap, it should *clearly* be RFC.

People should be spelling out dependencies in any case (especially for 
non-RFC versions) clearly.

I'll note that even if there would be a rule, I'm afraid we don't have a 
good place to document it (and not sure if people would find it or even 
try finding it ...) :/

A big problem is when some subsystems have their own rules for how to 
handle such things. That causes major pain for contributors ...

-- 
Cheers,

David / dhildenb


