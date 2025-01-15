Return-Path: <linux-kselftest+bounces-24550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F58A118B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 06:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02F23A73E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 05:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B5622F3BC;
	Wed, 15 Jan 2025 05:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="ojNFcQ6q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FA922E407
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 05:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736917663; cv=none; b=HjVhGvROt8JzppisWiORK0Q14eaB0iP5axVFY+bOYLAZyQKrNQE6nGfng9B1k+1NYVqCDVwqBhKDpJASIvYT7CAXZvHNrFuJ7Zy8JquQariqRPUBkfmpP+fa+0wkF1747BsRdbtg18DQ1F06Qru+fAVGdqmbIjUduxxV8El6+PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736917663; c=relaxed/simple;
	bh=t4dXpTZmsRI2k2NZ4xiQUhN5dBPeJttIl5lhtigwHU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ko0ykkN1hkZofWitJid9NxC4EsxQTNzzv5PTeX4hLAjtMTREFhQsNbE5e8OcVFnLnU1xsGZ1yaHg8kl7cvBIkzvqCw6MuUXDeDI+ImYwf/rahi5kowUmBaYGttOYM8dsUEEADQgqDnMqmI8gfg6adhjzqBfnSgjIFOciT/SM040=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=ojNFcQ6q; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21644aca3a0so138439755ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 21:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736917660; x=1737522460; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tJj2ax30G5cYMMuz85Qw6SCJDIZ/bbwOrDlSPLFGRgM=;
        b=ojNFcQ6qbQMsuh63BrZPD2cg5u7/AjaUXt9B7ekVeZhZM8dOXf3eAAuYd+TBljvKwK
         JtNVSsZSxxxJMsHDenuRv66Q+3LiW/CEFkGmFZ15GfcB1tGh258PdjinToYMY6fN5CT9
         yLK/AIBtJTJJwU1XATwHLqPmqX6dv8V9mBOPQ6Rx1Sfri9vVUE/+dgN+cKHNzxg2ivhk
         m7ysgpWjGkfKAPQDfwx20th4mSNaYEPeGZwe/pPtPrlYgMFWu6FprvmzyPayoSWQys1k
         2nGX8N5IF/6m1UIIXjlIlqdAOoj5xaQRHCPESiDfRHfQYqYL7WKNb6iJHI4t1rnWxhjb
         XD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736917660; x=1737522460;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJj2ax30G5cYMMuz85Qw6SCJDIZ/bbwOrDlSPLFGRgM=;
        b=qozucrGIb1oxgbfPJlxn0bAe0HBwUhW71UunwIbkSWMQKTv5g85x0neTzLwkb3ofAP
         Y+Hq+s9obcAxs0tQUywOmuGIEB+F2DC4QeCeYB8PJqUzChIefY8a0dAC3CnLMeJKzVc2
         aTyD+TFpJpwxq2xCilN5ef9EDwNliNEYa+DZyfdkMQABbIErerY25rZw+NLfWwOpcGIC
         uQbLtWhvPS1bdGQw8BBIs2DSUgsCoTI+SoQ/JIDrUPoJLqi9H3e00uR6evMGxMQ5Ihl9
         0qTm1bTyApZfSbcXuFUTM5/c+AZG1gasTJjMjCM3EvgfwwPTrVwJFgGcMqMQnbFN7tnl
         mZ7g==
X-Forwarded-Encrypted: i=1; AJvYcCUIfxop283vB3pR725u7Cjg0lScNCJOHt/Z5iLyqZyaDbUITro91jcnNiqC0IBZwqj2dpw5CIZamQdOGAvT9Vs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo2UrNMuaCWtENjzdM/+ZGUpFn2jHaU1oXUP9TZuNOCNi/JpTn
	ei37kFUJbaCDD1hICxqBBewQZSUTEKC2VvXLzXoIAex0T9bVjWe7Z6sU4Qb1X5JIXPDLmQq8RCp
	rPLo=
X-Gm-Gg: ASbGncvB1qF28y2SWH2Z/QvP0B1Km5VCuiTbuCRgzPNPz0a3u92G/u4mWPGpCfbn7fx
	dV9XF85BZt1rsWS+MtieXsIvHP1GXl8rkarvDq1NvXCqN2QmVNUL7VDNER3+Sh2f1pChaumGB7P
	9EmHijkCH4mW+jXKkq1SGcMoBUaTkfHivFtwf7KgqXLEy9rzFF0EJS/6NyTKQvVqNc2gu0I1Mn5
	5BGS+sUYLocGQfVoUQ82Gv7J1lyDNTOCqAZ8B1b6k/k39MykglC2CEy9WAWOMpajEQ=
X-Google-Smtp-Source: AGHT+IH85/A6RLxL+2rEhiloGI8TMEvrvGtTvROtv7Pjqakmsz8YgZ7ly7fq+kIggy8KHNzrf4rkjg==
X-Received: by 2002:a17:902:ea0a:b0:216:3083:d03d with SMTP id d9443c01a7336-21a83ffc447mr470885135ad.44.1736917659024;
        Tue, 14 Jan 2025 21:07:39 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10e41csm73994625ad.11.2025.01.14.21.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 21:07:38 -0800 (PST)
Message-ID: <fcb301e8-c808-4e20-92dd-2e3b83998d18@daynix.com>
Date: Wed, 15 Jan 2025 14:07:32 +0900
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEuiyfH-QitiiKJ__-8NiTjoOfc8Nx5BwLM-GOfPpVEitA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/01/13 12:04, Jason Wang wrote:
> On Fri, Jan 10, 2025 at 7:12 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/01/10 19:23, Michael S. Tsirkin wrote:
>>> On Fri, Jan 10, 2025 at 11:27:13AM +0800, Jason Wang wrote:
>>>> On Thu, Jan 9, 2025 at 2:59 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>
>>>>> The specification says the device MUST set num_buffers to 1 if
>>>>> VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
>>>>
>>>> Have we agreed on how to fix the spec or not?
>>>>
>>>> As I replied in the spec patch, if we just remove this "MUST", it
>>>> looks like we are all fine?
>>>>
>>>> Thanks
>>>
>>> We should replace MUST with SHOULD but it is not all fine,
>>> ignoring SHOULD is a quality of implementation issue.
>>>
> 
> So is this something that the driver should notice?
> 
>>
>> Should we really replace it? It would mean that a driver conformant with
>> the current specification may not be compatible with a device conformant
>> with the future specification.
> 
> I don't get this. We are talking about devices and we want to relax so
> it should compatibile.


The problem is:
1) On the device side, the num_buffers can be left uninitialized due to bugs
2) On the driver side, the specification allows assuming the num_buffers 
is set to one.

Relaxing the device requirement will replace "due to bugs" with 
"according to the specification" in 1). It still contradicts with 2) so 
does not fix compatibility.

Instead, we should make the driver requirement stricter to change 2). 
That is what "[PATCH v3] virtio-net: Ignore num_buffers when unused" does:
https://lore.kernel.org/r/20250110-reserved-v3-1-2ade0a5d2090@daynix.com

> 
>>
>> We are going to fix all implementations known to buggy (QEMU and Linux)
>> anyway so I think it's just fine to leave that part of specification as is.
> 
> I don't think we can fix it all.

It essentially only requires storing 16 bits. There are details we need 
to work out, but it should be possible to fix.

Regards,
Akihiko Odaki

