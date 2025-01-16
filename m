Return-Path: <linux-kselftest+bounces-24622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBB6A13296
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 06:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C664167D14
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 05:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A271114B087;
	Thu, 16 Jan 2025 05:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="Ct3biXum"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCD286355
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 05:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737005425; cv=none; b=P489cl1A34syY/U+khEBVBWgQMBCRyN97SQ9lv5uz0ZTjw2AoaPgBlVpOBDngoXqbWH5r+/SYrDC/SqL/bRRe2tpZSzn+eFccxkV2oJC8VB4NPQfe2pivK5xa4UXYBEXzCdQ+EVX1CVF/vhTpNx3wQo5Nw04mwqVp+AbdZykfM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737005425; c=relaxed/simple;
	bh=5xQA7+rcyNu9tK/Yw0+0NEwKQ5hjxrD+NiJB5k0WJ3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hIYwwEmtMCUz/y7ZnzEul/hXEBpqsah4KyoqQNadL2Rpwkx3xsLH4Kj5wE8hGxnFpsP6rFiJB0RHUkW0GerD+gfgjgzsPJTG2UCKmJyptROwwmpvi81zBoSTy+zjBaEG+WdJxojG8/OcdkI1Ub0xWkQmkRBcH15q5rkkW0mpn8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=Ct3biXum; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2166022c5caso7269475ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 21:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737005423; x=1737610223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t85mZgz2Rs3YU6wJKJ13zARpOEqd4Q3PLwsjti7bxDQ=;
        b=Ct3biXumbZ8x4r0PTptGSo33l1ZLQq70j+BXPuYlXDxxLJXQ4YcrYRh6tfR4fqabOO
         7IeiK5xCteU9Vy+4qe450Pnfr2Euqbt18+XnTorYKyKIYMkFT7SDvS8ncvLI+1eAQ3r5
         P+YXsb0U7hsQoWS+y+X+e7seAJulj40sCCXhTt1v04y6vy8MFGUGjBinqOnS2ZFZQ8oW
         6lcENAShZx40W+kYt2UJ/uHkL5krmNWY8/ycNeJJS8gIhXKrOrv95+U7o+hVCwTkMwOI
         prMxEBejHxG52OIxExbzNjDyU1H3jqMeCvhi4I94A35lsy2evEJ96aXm0KBcp1OfWQe1
         s6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737005423; x=1737610223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t85mZgz2Rs3YU6wJKJ13zARpOEqd4Q3PLwsjti7bxDQ=;
        b=JBgOuHAFK7877w0na/m04fGwa6Ajx7Dxr23Ux+SwZwGwZH5Aj2Pg8gZa7lfIFchFyN
         /gCHxno4UVPzzMnqqrtNQI2NS291y7ibsKmi2YGkLuxQPItip12G3xQrYX6QL8nJMYcN
         Rt9eVizDkxxXYRZmdGijJi/BUYEpM5vo12+s9VKTfYBMO7z5ifRQH3EIgeBsFM97ADyh
         yF5A2EUKJ9iSOD0f7gn1Ncy+IxVlWjeODgBeEGJ1i5wtDLdjIPF61Hf5QNhHavDeLtqS
         htoeErQ6tsQwgihJh1acc/wqNIUcfSztesz72BiIMvLccvG0pfb7Yot9vl0xx9CocBqO
         tUYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmCD9PsxxZ3C2lbeTfvtS9uPsIqrQlE313BgREx2GL1jOsLIIw4Wg4q0KTrH3YsAY6DENJIDo9O7k2Ek2xdVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW0HZvbiFR9I3Qh2wUfGB+ulqZ7E70tAXLEeQoni39Ue0cF6Cv
	yGZjFrkVXbH6JcCkFVraedYyKDL74FK0TSKIRtfv1JTsKvKL5mFvm6xMi/hUGQI=
X-Gm-Gg: ASbGncuYXbt8sVqqkUwauRvdHWT7QDlqEVThU4t5taqX0vF/8iRucoEtf7QnSYbI0nx
	ylPmMzhUb1It4Vfthz6tj53Lbmh9ccAHD3XcyM66+Anf7SRfHV5F+HsYE4FoJHhQ4q+IrLITEsf
	80hGOjdjcRxZPIQmcmn8XsY/IwO+7F2OgPViIaLUYqFCUrAUcikSx/w0EQDGhqDyxUybjLmx9wN
	sWD+lzxnFPPK1nmQ79JMuZ62r6InjPJJ5elBCUbP40f4YUFWUge+b2Z5PRRrJircLY=
X-Google-Smtp-Source: AGHT+IEwP5ZyOaLIZ2+ZynbDYG6rMIezxsEt9Oeopwo0vGbe1vdYSLm0vMdAkgahtQxltszD6eVILA==
X-Received: by 2002:a17:902:ea0a:b0:216:682f:175 with SMTP id d9443c01a7336-21a840029a0mr517608085ad.49.1737005423363;
        Wed, 15 Jan 2025 21:30:23 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f217565sm90290735ad.125.2025.01.15.21.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 21:30:22 -0800 (PST)
Message-ID: <cc79bef1-c24e-448d-bc20-f8302e341b2c@daynix.com>
Date: Thu, 16 Jan 2025 14:30:16 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tun: Set num_buffers for virtio 1.0
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-3-388d7d5a287a@daynix.com>
 <CACGkMEsm5DCb+n3NYeRjmq3rAANztZz5QmV8rbPNo+cH-=VzDQ@mail.gmail.com>
 <20250110052246-mutt-send-email-mst@kernel.org>
 <2e015ee6-8a3b-43fb-b119-e1921139c74b@daynix.com>
 <CACGkMEuiyfH-QitiiKJ__-8NiTjoOfc8Nx5BwLM-GOfPpVEitA@mail.gmail.com>
 <fcb301e8-c808-4e20-92dd-2e3b83998d18@daynix.com>
 <CACGkMEvBU3mLbW+-nOscriR-SeDvPSm1mtwwgznYFOocuao5MQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEvBU3mLbW+-nOscriR-SeDvPSm1mtwwgznYFOocuao5MQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/01/16 10:06, Jason Wang wrote:
> On Wed, Jan 15, 2025 at 1:07 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/01/13 12:04, Jason Wang wrote:
>>> On Fri, Jan 10, 2025 at 7:12 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2025/01/10 19:23, Michael S. Tsirkin wrote:
>>>>> On Fri, Jan 10, 2025 at 11:27:13AM +0800, Jason Wang wrote:
>>>>>> On Thu, Jan 9, 2025 at 2:59 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>
>>>>>>> The specification says the device MUST set num_buffers to 1 if
>>>>>>> VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
>>>>>>
>>>>>> Have we agreed on how to fix the spec or not?
>>>>>>
>>>>>> As I replied in the spec patch, if we just remove this "MUST", it
>>>>>> looks like we are all fine?
>>>>>>
>>>>>> Thanks
>>>>>
>>>>> We should replace MUST with SHOULD but it is not all fine,
>>>>> ignoring SHOULD is a quality of implementation issue.
>>>>>
>>>
>>> So is this something that the driver should notice?
>>>
>>>>
>>>> Should we really replace it? It would mean that a driver conformant with
>>>> the current specification may not be compatible with a device conformant
>>>> with the future specification.
>>>
>>> I don't get this. We are talking about devices and we want to relax so
>>> it should compatibile.
>>
>>
>> The problem is:
>> 1) On the device side, the num_buffers can be left uninitialized due to bugs
>> 2) On the driver side, the specification allows assuming the num_buffers
>> is set to one.
>>
>> Relaxing the device requirement will replace "due to bugs" with
>> "according to the specification" in 1). It still contradicts with 2) so
>> does not fix compatibility.
> 
> Just to clarify I meant we can simply remove the following:
> 
> """
> The device MUST use only a single descriptor if VIRTIO_NET_F_MRG_RXBUF
> was not negotiated. Note: This means that num_buffers will always be 1
> if VIRTIO_NET_F_MRG_RXBUF is not negotiated.
> """
> 
> And
> 
> """
> If VIRTIO_NET_F_MRG_RXBUF has not been negotiated, the device MUST set
> num_buffers to 1.
> """
> 
> This seems easier as it reflects the fact where some devices don't set
> it. And it eases the transitional device as it doesn't need to have
> any special care.

That can potentially break existing drivers that are compliant with the 
current and assumes the num_buffers is set to 1.

Regards,
Akihiko Odaki

> 
> Then we don't need any driver normative so I don't see any conflict.
> 
> Michael suggests we use "SHOULD", but if this is something that the
> driver needs to be aware of I don't know how "SHOULD" can help a lot
> or not.
> 
>>
>> Instead, we should make the driver requirement stricter to change 2).
>> That is what "[PATCH v3] virtio-net: Ignore num_buffers when unused" does:
>> https://lore.kernel.org/r/20250110-reserved-v3-1-2ade0a5d2090@daynix.com
>>
>>>
>>>>
>>>> We are going to fix all implementations known to buggy (QEMU and Linux)
>>>> anyway so I think it's just fine to leave that part of specification as is.
>>>
>>> I don't think we can fix it all.
>>
>> It essentially only requires storing 16 bits. There are details we need
>> to work out, but it should be possible to fix.
> 
> I meant it's not realistic to fix all the hypervisors. Note that
> modern devices have been implemented for about a decade so we may have
> too many versions of various hypervisors. (E.g DPDK seems to stick
> with the same behaviour of the current kernel).
 > >>
>> Regards,
>> Akihiko Odaki
>>
> 
> Thanks
> 


