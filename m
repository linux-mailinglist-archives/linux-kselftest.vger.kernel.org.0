Return-Path: <linux-kselftest+bounces-29032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F04A610B7
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 13:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B79319C27B6
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 12:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A581FCFE3;
	Fri, 14 Mar 2025 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NijUSqYU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A281CBE8C
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 12:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741954632; cv=none; b=PyNv3uyek8p/TQ1T73aKWlotGJxkL+iuvcpo8xtRsCCe973R0Q284qqRf4SGRPHlrqX5VrI7RfhL/dZgrepPTlfytW8oAlEJh1ImHfbGpib9Mf/1/GLu+K4VtQWyDC5VK6Eu09Kk4CwqnG8ThXfbLbIyqjijkxrEIVnjxMT/DwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741954632; c=relaxed/simple;
	bh=MiSPP/QvIcTVTmZ0qIzcXfbATwLB4cCe1NpvHpBe0N8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=W6IGUlp4K6vkujVJ8tfuan+HcQ5pKPfrbjhVd59SVjPXGAhy4XVZ/QkVhk52augTuIsC4ZnjwFvJqD1zeWMSk7dSY63kaFM086wbMUuLcjw0rMU3602cedfcP0JjO78YoVQEuRj3fYxt+pBsjniscfIWrMURv0IMcAH6+DA9xL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NijUSqYU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741954629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Uk+PE6keSszFMK/H4FlxtGAYCBN+w4Mxmc2pqfulugg=;
	b=NijUSqYUqnW/Ba517KFDfeL/tZ2PmTEDATXOjNd06gaItUgv2e4f7KBhFu1ll8yY8p+b5A
	tBY/T7j/z2cClz1XBaDt1ix33h/j1Sf5ayNj5pDRVG5fCIYpBQ5ZfGHGo7GUtYe2ztgqYv
	wT7NxwPCuKH76txpFdsDyHlW3rvfJxc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-oNSInZhCNJqjNK85SYX5FA-1; Fri, 14 Mar 2025 08:17:08 -0400
X-MC-Unique: oNSInZhCNJqjNK85SYX5FA-1
X-Mimecast-MFC-AGG-ID: oNSInZhCNJqjNK85SYX5FA_1741954627
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so12172365e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 05:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741954627; x=1742559427;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Uk+PE6keSszFMK/H4FlxtGAYCBN+w4Mxmc2pqfulugg=;
        b=KU3tb1P4JcpAVegRk1DoBFiMD91H8DEcnF/23nELb9qOsOGpj6Szp6WioKdl4BaE2s
         cBz2RAw1UPnfo1mnT4gYTsjL5uwwG8+f108H0E7YGiivN9gGSs5jGkQ/yiKIhibPoSwF
         EEZGDmmUPgnbtqjndDvya80ddasb5DJjbnMra6g258qH525b3arpoEFdzIus6IxPI+3r
         waeI6FRL2BPlrFjGI4MR50dVfVUpqS/VaC42MTOjZrFpOyW0Q6bSo2G3XOBlJs5SEogz
         QYsQFBu6/yeCW97yNna1YMhDDJH6N9AOjAVCSU5q9a2VO5WmvLYmq0VKp5icaB4qTptk
         lZhw==
X-Forwarded-Encrypted: i=1; AJvYcCWOzW8iBFLtH8oQVXYh81cGgypIq9d096JAahEw/pH8khvdWn8zrtgLXFmCPG2ZFl0Nt8hDZ8MU9sCsJmSbgBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy94RGL49oaCUOxkvcgFloQsB7Gam/ouOlYmeLI24qfLA9sDX55
	RdJMAbJW/sFAjTzUMS3LUTEJReimvkL7cdOSVz287YOkw8aI2FAD16++aU/YhHP/KGMqWqcFnCQ
	1kOQJWucjLjP0MFfycFsnV8XwKmismgiEsuhGN895YJJdWMJ1tEUZUjBD1Gig6/Fvaw==
X-Gm-Gg: ASbGncs5bovEzE5lwpWbMHA40F4TQD32P3cpTnC8hGAQV3Yfid7yxbjMBsI7aj2PQ/I
	T8CWIaR3lNsf1HIDeTKJ06orBmPqw7W1aQc1ClNtvwpicyRMTMahBL+rxIEEYPIy9roL1x4X9uw
	hy7sUql5EyN31Q9uwqTEGmYSugnL1IFDb3ZevDN7Lo9Ut4vlPykHwVt/u7ya6njWObSo7mSRQ9H
	A/QfbtebdZLtaP2URgpxUCLQKj7x1/ox+Zwh9i3QxXVjLGmJQG5U1WMhjFaWSpILZSMtSYpmooq
	btSKIGrHlGDTwzi8yIhLdKG35XtNZF1+YNG7Psj0DBAVPAnrMNgSVmUz2vWuyyEZAing/hPJkp/
	ICyj7UAv5o6DnN/wp6mIjsOF3xVsjuTQsTdWEQiRp1IA=
X-Received: by 2002:a05:600c:19cd:b0:43c:ea40:ae4a with SMTP id 5b1f17b1804b1-43d1ecd932fmr30117645e9.31.1741954626821;
        Fri, 14 Mar 2025 05:17:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDrbvz2tRgrie1qCZ5FL011ovoI1nQAi6sQgjyv7izS0Ueu8VEX/n5R7v+XPE4e+CWYxc4NA==
X-Received: by 2002:a05:600c:19cd:b0:43c:ea40:ae4a with SMTP id 5b1f17b1804b1-43d1ecd932fmr30117275e9.31.1741954626472;
        Fri, 14 Mar 2025 05:17:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c745:2000:5e9f:9789:2c3b:8b3d? (p200300cbc74520005e9f97892c3b8b3d.dip0.t-ipconnect.de. [2003:cb:c745:2000:5e9f:9789:2c3b:8b3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe065b0sm15827845e9.14.2025.03.14.05.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 05:17:06 -0700 (PDT)
Message-ID: <95a15856-5c47-4040-9291-5b972786efeb@redhat.com>
Date: Fri, 14 Mar 2025 13:17:05 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/10] selftests/mm: Skip gup_longerm tests on weird
 filesystems
From: David Hildenbrand <david@redhat.com>
To: Brendan Jackman <jackmanb@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
 <20250228-mm-selftests-v3-8-958e3b6f0203@google.com>
 <08023d47-dcf4-4efb-bf13-5aef3c6dca14@redhat.com>
 <Z8mYG8eQnMsOA4c1@google.com>
 <16023193-6cb4-46d1-91c4-43342e7e6d30@redhat.com>
 <CA+i-1C3srkh44tN8dMQ5aD-jhoksUkdEpa+mMfdDtDrPAUv7gQ@mail.gmail.com>
 <41923b80-55f4-44b6-bc59-60327e5308f4@redhat.com>
 <Z9FHEdZoYbCMoj64@google.com>
 <15cc0c1d-2b02-41de-bf48-3c57cee97c53@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <15cc0c1d-2b02-41de-bf48-3c57cee97c53@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.03.25 13:10, David Hildenbrand wrote:
> On 12.03.25 09:34, Brendan Jackman wrote:
>> On Tue, Mar 11, 2025 at 08:53:02PM +0100, David Hildenbrand wrote:
>>>> 2. 9pfs seems to pass the f_type through from the host. So you can't
>>>> detect it this way anyway.
>>>>
>>>> [3. I guess overlayfs & friends would also be an issue here although
>>>> that doesn't affect my usecase.]
>>>>
>>>> Anyway, I think we would have to scrape /proc/mounts to do this :(
>>>>
>>>
>>> The question I am asking myself: is this a 9pfs design bug or is it a 9pfs
>>> hypervisor bug. Because we shouldn't try too hard to work around hypervisor
>>> bugs.
>>>
>>> Which 9pfs implementation are you using in the hypervisor?
>>
>> I'm using QEMU via virtme-ng. IIUC virtme-ng knows how to use viortfs
>> for the rootfs, but for individually-mounted directories with
>> --rwdir/--rodir it uses 9pfs unconditionally.
> 
> Ah okay, that makes sense.
> 
>>
>> Even if it's a bug in QEMU, I think it is worth working around this
>> one way or another. QEMU by far the most practical way to run these
>> tests, and virtme-ng is probably the most popular/practical way to do
>> that.
> 
> I'm afraid yes. Although allocating temp files form 9pfs is rather ...
> weird. :) One would assume that /tmp is usually backed by tmpfs. But
> well, a disto can do what it wants.
> 
>> I think even if we are confident it's just a bunch of broken
>> code that isn't even in Linux, it's pragmatic to spend a certain
>> amount of energy on having green tests there.
>>
> 
> Yeah, we're trying ...
> 
>> (Also, this f_type thing might be totally intentional specified
>> filesystem behaviour, I don't know).
> 
> I assume it's broken in various ways to mimic that you are a file system
> which you are not.
> 
> Your approach is likely the easiest approach to deal with this 9pfs crap.
> 
> Can you document in the code+description better what we learned, and why
> we cannot even trust f_type with crappy 9pfs?

Staring a bit at that code, it's mostly 9p specific I think.

t14s: ~/git/linux s390x-file-thp2 $ git grep "= NFS_SUPER_MAGIC"
fs/nfs/super.c: buf->f_type = NFS_SUPER_MAGIC;
fs/nfs/super.c: sb->s_magic = NFS_SUPER_MAGIC;

t14s: ~/git/linux s390x-file-thp2 $ git grep "= V9FS_MAGIC"
fs/9p/vfs_super.c:      sb->s_magic = V9FS_MAGIC;
  $ git grep "f_type" | grep 9p
fs/9p/vfs_super.c:                      buf->f_type = rs.type;


-- 
Cheers,

David / dhildenb


