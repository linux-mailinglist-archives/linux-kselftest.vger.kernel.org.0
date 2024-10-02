Return-Path: <linux-kselftest+bounces-18862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2962598CC58
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 07:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2701C20EAF
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 05:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAD679DC7;
	Wed,  2 Oct 2024 05:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="vNjJEbg6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D01478C6D
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Oct 2024 05:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727846826; cv=none; b=D0lAcjOPB4CdcWV6VBRPujSo8EZVBF92gu69XaOC8/Ir5rVpLEWKS/GwPoYaGwrG5GggMEsaFaitiVvE82hqa9mIn2kc1KEzklv4qaAqxpUTJVPG2iEaSgaC8SxYG1BZhzN0MMWMLqZUgZ46bV/1/xVU8HJEFn2l4N4k+5/Dw18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727846826; c=relaxed/simple;
	bh=9fxwXFLn5GhRqZDoUHaTplseUCYkdcTYDVZR4cW105g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYSn/dBNZsGAECAJVWMme5xZUQEpGLoCrEGPx+YPlCctjw+GkvX45zcolG0WrFzqkM/H8bH63evZFtfHvC+oapOpFUXwn5eW6ddU7O99WTlHGUtddtqa5HKQN7vJeGtIJQxIkwbFKScvfkXuWhRV3rF6uM4Lvh6jzofnP3SEHzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=vNjJEbg6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b6c311f62so32920515ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Oct 2024 22:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1727846824; x=1728451624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nVKUJa0N9Bv7FRPSWL41/VbRzViB8OY98BcxK2GdZLk=;
        b=vNjJEbg6cGIrcVfEY0hNpNwNwz08QKm/oe13qeajcjSsrp25PM8NjQOYrLn8/D/zCH
         KAN3pzByEfggRi8x2boLYg+jw+9A2wvTPSM2/q3WKd2j+7OnZ4qXzPWDOyV9le5WXyUF
         DccaEXoLWKQBXzRxJB9AuEKe7IQ02vCAvLykPigb9IL/EF1S4R/FYvsH6fj0Xc8eN9WE
         EpT/l+ccAE4nZzD953lngJTCaSF3G2GHZObz+84g9EeEqhiykrxsMRnRJrEgipqvABPC
         HFbIxlG4GYrUWKXbgPdvMZgTOzmTXykt5Jh2+XyAXl2GeX33wzmb5SSDXrsqerDM45GB
         7vHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727846824; x=1728451624;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nVKUJa0N9Bv7FRPSWL41/VbRzViB8OY98BcxK2GdZLk=;
        b=T94B+ZkmEPZOc4x7thVfCnNT7u/a31j0Y3E1Pau9Ck1+ZQGSBH3V7gqdCsIZ1JwGCv
         OMaouTHPS7l6bbc87PaN3tucvOcxN0jmH359EV+MXRP/JYbeBY2L+zdBwT6myS8GfSqa
         ZagdhA1qyq90Z0Lit2qBBDziCgcLzWXTjnEvCV6Mjag4fu477Y2pmPTNyhy1/zTXAL2E
         OCgDRv4GRjuTii+a4psOaADp2QoE/cGBrNALLZ+7Vhq7JlFa3asn9BsfK4qNOybUTRs1
         ++m1Sc4LlQ1SlKpa2K9YrKDAdO7Nu9pqfrqfkNl5Y1ihF0CmX2U7XorWER01g9yN8buA
         cgvg==
X-Forwarded-Encrypted: i=1; AJvYcCX2Fz0M89plTGIB44/oAzVlIOvE9nCp9vNplIW/79Rffa0Ph8h4niCF6kZJdPVCxCVt7AWQplQDAKlbEZ2Jh2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgTkUR7dOT5AjAr2sCNZbtGtULdJKBsKc+IdIA/EWmZLxp46at
	JEL2FrR4P60M0a0NGEJL3kQB35uauw6HVADbLNM9aQvYfqpXRCnHLY0aLRyVdpE=
X-Google-Smtp-Source: AGHT+IGRvF+0dzA6+8tjn7CaXbw8Jq4zdHPAfGu0aIngCPiMB0nvWY2fY2CjWXjr6Jtlt0AZyPw/Jg==
X-Received: by 2002:a17:902:f14b:b0:205:83a3:b08 with SMTP id d9443c01a7336-20bc5a13e3fmr21525075ad.32.1727846823680;
        Tue, 01 Oct 2024 22:27:03 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e4ee7bsm77740535ad.234.2024.10.01.22.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 22:27:03 -0700 (PDT)
Message-ID: <202d7486-7fbb-43bd-9002-2cc0013483ff@daynix.com>
Date: Wed, 2 Oct 2024 14:26:57 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 0/9] tun: Introduce virtio-net hashing feature
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Jason Wang <jasowang@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>, gur.stavi@huawei.com
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
 <CACGkMEvMuBe5=wQxZMns4R-oJtVOWGhKM3sXy8U6wSQX7c=iWQ@mail.gmail.com>
 <c3bc8d58-1f0e-4633-bb01-d646fcd03f54@daynix.com>
 <CACGkMEu3u=_=PWW-=XavJRduiHJuZwv11OrMZbnBNVn1fptRUw@mail.gmail.com>
 <6c101c08-4364-4211-a883-cb206d57303d@daynix.com>
 <CACGkMEtscr17UOufUtyPp1OvALL8LcycpbRp6CyVMF=jYzAjAA@mail.gmail.com>
 <447dca19-58c5-4c01-b60e-cfe5e601961a@daynix.com>
 <20240929083314.02d47d69@hermes.local>
 <f437d2d6-e4a2-4539-bd30-f312bbf0eac8@daynix.com>
 <20241001093105.126dacd6@hermes.local>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241001093105.126dacd6@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/10/02 1:31, Stephen Hemminger wrote:
> On Tue, 1 Oct 2024 14:54:29 +0900
> Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> 
>> On 2024/09/30 0:33, Stephen Hemminger wrote:
>>> On Sun, 29 Sep 2024 16:10:47 +0900
>>> Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>    
>>>> On 2024/09/29 11:07, Jason Wang wrote:
>>>>> On Fri, Sep 27, 2024 at 3:51 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> On 2024/09/27 13:31, Jason Wang wrote:
>>>>>>> On Fri, Sep 27, 2024 at 10:11 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>
>>>>>>>> On 2024/09/25 12:30, Jason Wang wrote:
>>>>>>>>> On Tue, Sep 24, 2024 at 5:01 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>>>
>>>>>>>>>> virtio-net have two usage of hashes: one is RSS and another is hash
>>>>>>>>>> reporting. Conventionally the hash calculation was done by the VMM.
>>>>>>>>>> However, computing the hash after the queue was chosen defeats the
>>>>>>>>>> purpose of RSS.
>>>>>>>>>>
>>>>>>>>>> Another approach is to use eBPF steering program. This approach has
>>>>>>>>>> another downside: it cannot report the calculated hash due to the
>>>>>>>>>> restrictive nature of eBPF.
>>>>>>>>>>
>>>>>>>>>> Introduce the code to compute hashes to the kernel in order to overcome
>>>>>>>>>> thse challenges.
>>>>>>>>>>
>>>>>>>>>> An alternative solution is to extend the eBPF steering program so that it
>>>>>>>>>> will be able to report to the userspace, but it is based on context
>>>>>>>>>> rewrites, which is in feature freeze. We can adopt kfuncs, but they will
>>>>>>>>>> not be UAPIs. We opt to ioctl to align with other relevant UAPIs (KVM
>>>>>>>>>> and vhost_net).
>>>>>>>>>>      
>>>>>>>>>
>>>>>>>>> I wonder if we could clone the skb and reuse some to store the hash,
>>>>>>>>> then the steering eBPF program can access these fields without
>>>>>>>>> introducing full RSS in the kernel?
>>>>>>>>
>>>>>>>> I don't get how cloning the skb can solve the issue.
>>>>>>>>
>>>>>>>> We can certainly implement Toeplitz function in the kernel or even with
>>>>>>>> tc-bpf to store a hash value that can be used for eBPF steering program
>>>>>>>> and virtio hash reporting. However we don't have a means of storing a
>>>>>>>> hash type, which is specific to virtio hash reporting and lacks a
>>>>>>>> corresponding skb field.
>>>>>>>
>>>>>>> I may miss something but looking at sk_filter_is_valid_access(). It
>>>>>>> looks to me we can make use of skb->cb[0..4]?
>>>>>>
>>>>>> I didn't opt to using cb. Below is the rationale:
>>>>>>
>>>>>> cb is for tail call so it means we reuse the field for a different
>>>>>> purpose. The context rewrite allows adding a field without increasing
>>>>>> the size of the underlying storage (the real sk_buff) so we should add a
>>>>>> new field instead of reusing an existing field to avoid confusion.
>>>>>>
>>>>>> We are however no longer allowed to add a new field. In my
>>>>>> understanding, this is because it is an UAPI, and eBPF maintainers found
>>>>>> it is difficult to maintain its stability.
>>>>>>
>>>>>> Reusing cb for hash reporting is a workaround to avoid having a new
>>>>>> field, but it does not solve the underlying problem (i.e., keeping eBPF
>>>>>> as stable as UAPI is unreasonably hard). In my opinion, adding an ioctl
>>>>>> is a reasonable option to keep the API as stable as other virtualization
>>>>>> UAPIs while respecting the underlying intention of the context rewrite
>>>>>> feature freeze.
>>>>>
>>>>> Fair enough.
>>>>>
>>>>> Btw, I remember DPDK implements tuntap RSS via eBPF as well (probably
>>>>> via cls or other). It might worth to see if anything we miss here.
>>>>
>>>> Thanks for the information. I wonder why they used cls instead of
>>>> steering program. Perhaps it may be due to compatibility with macvtap
>>>> and ipvtap, which don't steering program.
>>>>
>>>> Their RSS implementation looks cleaner so I will improve my RSS
>>>> implementation accordingly.
>>>>   
>>>
>>> DPDK needs to support flow rules. The specific case is where packets
>>> are classified by a flow, then RSS is done across a subset of the queues.
>>> The support for flow in TUN driver is more academic than useful,
>>> I fixed it for current BPF, but doubt anyone is using it really.
>>>
>>> A full steering program would be good, but would require much more
>>> complexity to take a general set of flow rules then communicate that
>>> to the steering program.
>>>    
>>
>> It reminded me of RSS context and flow filter. Some physical NICs
>> support to use a dedicated RSS context for packets matched with flow
>> filter, and virtio is also gaining corresponding features.
>>
>> RSS context: https://github.com/oasis-tcs/virtio-spec/issues/178
>> Flow filter: https://github.com/oasis-tcs/virtio-spec/issues/179
>>
>> I considered about the possibility of supporting these features with tc
>> instead of adding ioctls to tuntap, but it seems not appropriate for
>> virtualization use case.
>>
>> In a virtualization use case, tuntap is configured according to requests
>> of guests, and the code processing these requests need to have minimal
>> permissions for security. This goal is achieved by passing a file
>> descriptor that represents a tuntap from a privileged process (e.g.,
>> libvirt) to the process handling guest requests (e.g., QEMU).
>>
>> However, tc is configured with rtnetlink, which does not seem to have an
>> interface to delegate a permission for one particular device to another
>> process.
>>
>> For now I'll continue working on the current approach that is based on
>> ioctl and lacks RSS context and flow filter features. Eventually they
>> are also likely to require new ioctls if they are to be supported with
>> vhost_net.
> 
> The DPDK flow handling (rte_flow) was started by Mellanox and many of
> the features are to support what that NIC can do. Would be good to have
> a tc way to configure that (or devlink).

Yes, but I would rather only implement the ioctl without flow handling 
for now. My purpose of implementing RSS in the kernel is to report hash 
values to the guest that has its own network stack in the virtualization 
context. tc-bpf would be suffice for DPDK, which does not have such a 
requirement.

Having an access to the in-kernel RSS implementation also saves the 
trouble of implementing an eBPF program for RSS, but DPDK already does 
have such a program so it makes little difference. There may be also 
performance improvement because I'm optimizing the in-kernel RSS 
implementation with ffs(), which is currently not available to eBPF, but 
there is also a proposal to expose ffs() to eBPF*.

For now, I will keep the patch series small by having only the ioctl 
interface. Anyone who finds the feature useful for tc can take it and 
add a tc interface in the future.

Regards,
Akihiko Odaki

* https://lore.kernel.org/bpf/20240131155607.51157-1-hffilwlqm@gmail.com/#t

