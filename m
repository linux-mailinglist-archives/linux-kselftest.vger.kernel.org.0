Return-Path: <linux-kselftest+bounces-10656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2DD8CE0F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 08:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CBBC1F21EF4
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 06:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09C0127E28;
	Fri, 24 May 2024 06:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezrFfZJb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164C9487BF
	for <linux-kselftest@vger.kernel.org>; Fri, 24 May 2024 06:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716531673; cv=none; b=EXRz0817SMYTl9YnumMo+4JRe67HuY88vpLA2Ew12jlTkIW3N//F3S+LIoTDdrv/Bp4li5Z5MKaRqdwMiLeNf1CPdNXhdoYJ0TE+t68rFx+HOvpbA7tNWN+Hvh/zOXbi8Li052lcyZyMF/klkz+0l/qkuzA9MEQ4JoND2T4GedI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716531673; c=relaxed/simple;
	bh=IMyhEHl1/YKT77LnN0c1Zov242HKa6tgFoM6O9PUORM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWgI7D5XnGC4hAWiB4kij6iJa4bENV7cUFb215cBoGcHuz3jk/BevAR9ziHRm5X7+v8kaUZatCe2B5NN5m4+VfS3MdD6/KdEb9yms5fz3o3X+0qRqS8bw0A1QEqWjIYm4l+IHG56/kJbLSjjpEVAEvKOY8mUZvhSsHDeXyAhUhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ezrFfZJb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716531670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lCyAQmYMge2L+lNPKoVDjc9PNeWU5cJtJ6pBdtPLLeQ=;
	b=ezrFfZJbq3NUGxxfb/44fHPIExYLlnpyMcQWE7xENMrAfOwRpHW/6O4Op097kDiCxlC6fd
	cB1Q0+OiXFuMHFJtZlYmeQKsbrf2QH/hhKNGl9Gb8VS7GYBagP85og4MxlJF7Z7v2wCHYU
	lej5rhOFBJhu8qc7a8bEM4lPUMEIB/8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-arob5WUEOGaCGm9ECQ9QOQ-1; Fri, 24 May 2024 02:21:08 -0400
X-MC-Unique: arob5WUEOGaCGm9ECQ9QOQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-420122cf3eeso72434385e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 23 May 2024 23:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716531667; x=1717136467;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lCyAQmYMge2L+lNPKoVDjc9PNeWU5cJtJ6pBdtPLLeQ=;
        b=qnPIxH0aB1NcMSx9SGleIJ8GNysI2IKbKqVkpSbbdaW+oPQ+J+KhkOWwt3HA/E93er
         cNak+YTV2+kMUCIK/Os8k9+gh2F19c92w2bUKq6l8ysyBRsC+zmH5SCKV9MStxPTrFTx
         PoG/L+agjrogdklsHOyil8+OD1ls07lg8iYDanM3vUOANtgqiwVwTk7c/qLJkhSR8MPX
         HJS1kjUNIeCZWba1oLf8eXjY0cnfq1oVsgRBe7ekGLfg1r1Gs2tgDUOeowfJYFaZzF6S
         MIEyfSLsnB9ZlmecR4+pIT20jIqaPqvOIIoBjxZaU+ehgFU019jYuU6zOsvP3atTK6D5
         OB7w==
X-Forwarded-Encrypted: i=1; AJvYcCXHbXW5jLvPWQpxoXFen7Hf654WrPjWSBngAJV6IB3jZ2E5nfWjNXV9aNW4Vp7+FaS5DTniluNs1TcUWy3wZdv9TJhm/r8jnE0//pprZsvr
X-Gm-Message-State: AOJu0YwY4zHPAiVOjFXhVgbCGcqzLBezF0gcof6pHM6y+QaS3ybE1u1J
	FlHd/52+N3H5/95Z0ORmUJXbrXePJSV9+DnNbzdPrGGZ/rkKyjvKX/evopTU4zLe3PKA2j2wYpg
	5ACOWZO2gX9TcJHXH3bF1teSsDMkVKyqmEdXGGbJqTV64qzSXVxztbKncrTdjBxZB7A==
X-Received: by 2002:a05:600c:5354:b0:41a:7065:430a with SMTP id 5b1f17b1804b1-42108a35a18mr8563485e9.41.1716531667324;
        Thu, 23 May 2024 23:21:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgIbb4OINbM6dRMJB/iGvr+n+Toqlklv1Vox6SynHazskaNZL2GibikSwEJFjZYpozN3vfBQ==
X-Received: by 2002:a05:600c:5354:b0:41a:7065:430a with SMTP id 5b1f17b1804b1-42108a35a18mr8563265e9.41.1716531666778;
        Thu, 23 May 2024 23:21:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c724:bc00:e919:27a8:d431:782a? (p200300cbc724bc00e91927a8d431782a.dip0.t-ipconnect.de. [2003:cb:c724:bc00:e919:27a8:d431:782a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4210145cbb5sm43242005e9.30.2024.05.23.23.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 23:21:06 -0700 (PDT)
Message-ID: <7792c8ba-39e6-47ee-9b43-108270325c15@redhat.com>
Date: Fri, 24 May 2024 08:21:05 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest: mm: Test if hugepage does not get leaked during
 __bio_release_pages()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Donet Tom <donettom@linux.ibm.com>, Shuah Khan <shuah@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Tony Battersby
 <tonyb@cybernetics.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ritesh Harjani <ritesh.list@gmail.com>, Mike Rapoport <rppt@kernel.org>,
 Muchun Song <songmuchun@bytedance.com>, stable@vger.kernel.org
References: <20240523063905.3173-1-donettom@linux.ibm.com>
 <20240523121344.6a67a109e0af2ba70973b34b@linux-foundation.org>
 <d551d1cd-a02f-42aa-9de2-10ff7757224c@redhat.com>
 <20240523195734.bc03a8822a34b1a97880fb65@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240523195734.bc03a8822a34b1a97880fb65@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.05.24 04:57, Andrew Morton wrote:
> On Thu, 23 May 2024 22:40:25 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>>> You have stable@vger.kernel.org in the mail headers, so I assume you're
>>> proposing this for backporting.  When doing this, please include
>>>
>>> Cc: <stable@vger.kernel.org>
>>>
>>> in the changelog footers and also include a Fixes: target.  I'm
>>> assuming the suitable Fixes: target for this patch is 38b43539d64b?
>>
>> This adds a new selfest to make sure what was fixed (and backported to
>> stable) remains fixed.
> 
> Sure.  But we should provide -stable maintainers guidance for "how far
> back to go".  There isn't much point in backporting this into kernels
> where it's known to fail!

I'm probably missing something important.

1) It's a test that does not fall into the common stable kernels 
categories (see Documentation/process/stable-kernel-rules.rst).

2) If it fails in a kernel *it achieved its goal* of highlighting that 
something serious is broken.

> 
> I'm still thinking that we want this in kernels which have 38b43539d64b?

To hide that the other kernels are seriously broken and miss that fix?

Really (1) this shouldn't be backported. I'm not even sure it should be 
a selftest (sounds more like a reproducer that we usually attach to 
commits, but that's too late). And if people care about backporting it, 
(2) you really want this test to succeed everywhere. Especially also to 
find kernels *without* 38b43539d64b

-- 
Cheers,

David / dhildenb


