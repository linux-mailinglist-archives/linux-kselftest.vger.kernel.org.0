Return-Path: <linux-kselftest+bounces-24129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 368B6A0771B
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 14:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292E6168DA9
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 13:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4922185AB;
	Thu,  9 Jan 2025 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q611BghL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F6A1853
	for <linux-kselftest@vger.kernel.org>; Thu,  9 Jan 2025 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736428774; cv=none; b=Vw84492183eGa9bss3w6qiNAU4iC33kYbzLsrzEeMSZRNmdNDpLNEYFBF7jb5qgpiJwJI0vG4ZpjsO+4eNAt8LhH52l5onZhGoNSSpJ0QLS+b16Da6G4Fs+Pca+UI9giIzjez8hvZa91bi48L6HSVEwTn2c+snzYZ1cnG4GSHhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736428774; c=relaxed/simple;
	bh=mFVzdF0pszM/tYeZMs7JC5DwtEb0TK7wbJpk2UEkzXM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tJ7qS3jv1NSTtaAIcPTKTfk0E1/PSfnKIkO3m/lCaMYvHMHzcJjzi/rtxyya8a+WgKv7a3WvQdQdyoDpD0ve0aswfaCp+4snahe7Nql6/bzI+0Que1q2BAp6SONGdOFKVPxggYW5q+HkvrBksBK0Mg/rrhJXXrax/HRhl1hH/BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q611BghL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736428772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PXBNX64TJkMh4OLSnNckA8Ioe5kSCrqL68UfxPxPkjc=;
	b=Q611BghLQa54Lq1cR2ov1hfE6DHUvdCUdIDY4HUU3yGA1MCrMUeZuddKNEjb+CjDUSHvpc
	9u9QKDZrYu8oAgn0JoGg+/zhXEGxrBWNEAVajg+qW3c5TPhlO1bxfwYKI51gxEa+w5ovLB
	ho47AUPIes8q2hXjJDfA4b1UlX3Gqw4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-Fvb5KLVMNkGJ0Z9AHi53bw-1; Thu, 09 Jan 2025 08:19:30 -0500
X-MC-Unique: Fvb5KLVMNkGJ0Z9AHi53bw-1
X-Mimecast-MFC-AGG-ID: Fvb5KLVMNkGJ0Z9AHi53bw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385e2579507so422634f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Jan 2025 05:19:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736428769; x=1737033569;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PXBNX64TJkMh4OLSnNckA8Ioe5kSCrqL68UfxPxPkjc=;
        b=LpE2U2Ovu6GjTl3ZMJvQ+TnbSlcuvZEqUkdRMIfjUcRQGYfDf7e+8fmZZ6CrjQWIWX
         TFzCvy/hQXmgYTjbxY0FlHiVj2IVIYDMeOMkMr8UTbuwoJDZMKx2c8/Ebpqo3lz812fZ
         ZjxqztRChgGCMqcXsFyhIpdFwLK/LsOEbO9ukoqbZwCeaLPVYLdUgqOKcdBcZ8+qqgrn
         cudkY4ZfkK5jLS6a6YXGDD4V93VX3DydcMGWKhXniayGG+glVoBFF+/nQtLDPlYsVSVn
         ZQwFW3KHfi+nJxSFkYy4PXavkbRRy4J27xjOAwB5JMol2ExUlRLk027PwU3NqqmZ1XtR
         Uo6g==
X-Forwarded-Encrypted: i=1; AJvYcCV6nMqfd6Iha0as3Ihx5q11wCOy2A8LrOkSKm+8Wz5eZQl/9oH0f4gu9NXCk83VGTKHizIh0GP6ACUNnLFj7tA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9RMhrtierLSqrNZ5J/TioeBFOLWicQiYh2A1gPQj9gbyqZM0T
	XOQ+H21t6l5jFaRJ5KDR0EvVc2LHZ0zRl/PuzvCbM6WdlUxn3KY7QWYkqh2zbRrMEvweFdChKNN
	ZoB6eCfo+c/+Sg5H5Mcxwj+psKJ7R82IrASTh7oHUjG0/Oem2oAGplg4OVQqbolGG8Q==
X-Gm-Gg: ASbGncvWqskYZNhdTqtpcwCw2eFaLYVkfIJD6uNZ6enFAQIyxHQTO151qAyQtPVyvuz
	lw4+PmMvO5AcSS/a6qF26RUlfEP2Dj1+3bTl/QuaWmdU5N11pRSqKkzdXyqHQYiqZgQAL/rKR8i
	mCWS5EJzjxp2QIchjcawCqDTpmdgHW/8M3mRhJom9buH8i5eEMpphkTLmo4opQG+kHOc9tyKjSN
	vb8k8U4gO1e+AkT42K/wq/CptnTyBaG7M56y/GlOjmCas5flwMIYUrHvueaPocpdsKfa4YuaTJ5
	i6KpLEP5+K79kv3WljUZBqnV3x9pWlksD5qAJZc3ND+3w1pNFTBvRZ3489okBew9Rk3+tqR1ypt
	JdZGVFQ==
X-Received: by 2002:a5d:64e7:0:b0:38a:624b:d55e with SMTP id ffacd0b85a97d-38a8733773cmr5487377f8f.41.1736428769431;
        Thu, 09 Jan 2025 05:19:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXcbZCk3q5LQaFi3ITePlDEDaVeaHB+L2r3D578hx0VS7N4F0kQsVLqMtNS9eey88weDM1HA==
X-Received: by 2002:a5d:64e7:0:b0:38a:624b:d55e with SMTP id ffacd0b85a97d-38a8733773cmr5487355f8f.41.1736428769084;
        Thu, 09 Jan 2025 05:19:29 -0800 (PST)
Received: from ?IPV6:2003:cb:c72e:800:d383:9661:5934:2cfa? (p200300cbc72e0800d383966159342cfa.dip0.t-ipconnect.de. [2003:cb:c72e:800:d383:9661:5934:2cfa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1b44sm1821641f8f.90.2025.01.09.05.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 05:19:27 -0800 (PST)
Message-ID: <eb3b0ebe-97b7-4504-aab0-3a008fd66c37@redhat.com>
Date: Thu, 9 Jan 2025 14:19:26 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] selftests/mm: virtual_address_range: Fix error when
 CommitLimit < 1GiB
From: David Hildenbrand <david@redhat.com>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Dev Jain <dev.jain@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Ryan Roberts <ryan.roberts@arm.com>
References: <20250107-virtual_address_range-tests-v1-0-3834a2fb47fe@linutronix.de>
 <20250107-virtual_address_range-tests-v1-1-3834a2fb47fe@linutronix.de>
 <5811cf74-d333-4653-ab64-0e981eda7745@arm.com>
 <20250108083855-840c688b-003f-423b-8327-2a10a2b27d58@linutronix.de>
 <05edee1e-04f1-4f19-816f-db03c182a201@redhat.com>
 <20250108165052-c03470bd-6ff7-44c9-87b9-9145456bdea8@linutronix.de>
 <618798d5-71b2-43d6-8f5c-78d911c5dd43@redhat.com>
 <20250109083527-e3c77b5f-14f5-467b-9cee-f71c75b2d654@linutronix.de>
 <4e52d67c-e968-4cf6-9c9b-88646f0d3a23@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4e52d67c-e968-4cf6-9c9b-88646f0d3a23@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.01.25 14:05, David Hildenbrand wrote:
>   >
>> That is clear. The issue would be to figure which chunks are valid to
>> unmap. If something critical like the executable file is unmapped,
>> the process crashes. But see below.
> 
> Ah, now I see what you mean. Yes, also the stack etc. will be
> problematic. So IIUC, you want to limit the munmap optimization only to
> the manually mmap()ed parts.
> 
>>
>>>> Is it fine to rely on CONFIG_ANON_VMA_NAME?
>>>> That would make it much easier to implement.
>>>
>>> Can you elaborate how you would do it?
>>
>> First set the VMA name after mmap():

I took a look at the implementation, and VMA merging seems to be able to 
merge such VMAs that share the same name (even when set separately).

So assuming you use the same name for all, that should indeed also work.

-- 
Cheers,

David / dhildenb


