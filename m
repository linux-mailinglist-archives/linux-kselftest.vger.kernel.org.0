Return-Path: <linux-kselftest+bounces-29911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F4CA7555C
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Mar 2025 10:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347A316DB81
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Mar 2025 09:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832281A5B97;
	Sat, 29 Mar 2025 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="rTsAtyJy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E79A935
	for <linux-kselftest@vger.kernel.org>; Sat, 29 Mar 2025 09:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743239738; cv=none; b=rgIuj/puUOf5UxLqB74GRgdnIkuKry0b0w53TrqKk55uAylGy7h08uiO0UZpoc2ZqySH7MQ5qN/9G8lJ17nAcy6lMRGBMRUdghXnyVAajdfCipD3ERNL95pQmBI2YKs4cEQ19Kdvxs1X/Wsjibda7X+Hd5rNfGB4dB5UVBqvtPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743239738; c=relaxed/simple;
	bh=ECZLgLwDyUncs8GyS4Y8iYRQBK/loQxvG5iV8eFBLiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QL7NMR+BZZThjl7uksV4C3b4YlGG6S/eJCQJBiODiGTqeRZtTgEJPCpmKvTAtcDdobgYRX+dM/E4/E74dkuqM+tYB6JxW5gMiiE+08xsPMK8AK4lfsFooo4zWxdn0qExCuBw+6aXLjnqsegDiLRfFQLM+c8cE41i8wEBjt0rlmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=rTsAtyJy; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22435603572so59253985ad.1
        for <linux-kselftest@vger.kernel.org>; Sat, 29 Mar 2025 02:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1743239735; x=1743844535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yqX8HaX0LEHHLesjNOix0OxV5omjWrnbfeWvEANrTK8=;
        b=rTsAtyJyTuyW5R3qQADHts3s4KdUNbNoEip7z2FHXbZXoQ2LS3KSpBrGPrXSD6S3Do
         Xw8tiAHGopudSOUZu5O0XWLvuvkHITsIgN6JiXA8VgwCwLPUAvW0sO2M15/mtnVjQAMw
         Mg3AEDJ7ZVDgOWDDyD0ZD5om8DtVrK1TuSp4ngKKLkrj6g33UhUuZjeaiDJ1YyJKM/tv
         NnmiOrg7MWTlEvdDiPiq/jJpzxwsn7ITpsMfkEhNvCsjoSEFAOpJvuPmwVToCsTyXVTF
         oqrjoUcCWT+YP2MTOpK6V9xkGV0IkRM+cudvU8apJvHYya53vnuc0lbu0U5RREXoXAUK
         j1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743239735; x=1743844535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yqX8HaX0LEHHLesjNOix0OxV5omjWrnbfeWvEANrTK8=;
        b=P9skXDmc2DegScQbRmHtcfiSP/mb3q+x5aI6EGiA0WVJCw7RalrOV0EGQ/K96uzOTt
         qcvGpN9OePTYWKOApMXzT71+iP6WPpf0ltzrVLmqGOdowEKujXG75X02cseCiw9uuLVv
         Z1n89tBu0en7gmLvIuCI7HIYLTifjgBe88xMmj/L4OFUpVWxrHYMNhz55DJqbLKyoW9D
         rJGfWkMDR1xwCnd/bFrTKETdCtgXdIg23Y4kjNUJrX09njmDGJhtCtkyNKSutSgwgwFl
         rRybct2NbUWHg9bSQ46Ttk4K++bmoDLhkTI3nIHOi+qiwivFFh2gIPFZU2jn517Fzzx7
         8t5A==
X-Forwarded-Encrypted: i=1; AJvYcCUT07YD9NgVh3x+hCTxcLAHcXWf6Cy1WdFx1/HIgq5B5YlK+6KXEcUkmO6gqIM+ZmEpadTzicy7x3ud+N2IPSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuwvm3533EKOZVrhAJkgREonulr98AYNNTf88lJbc3qjYgwXV/
	XtSxSFcTXPGrm0GE2/NVt4TcNwD3f3OycE79NJaeGS7uVy+VTvWfPfmr7oGvtek=
X-Gm-Gg: ASbGnctt7TKpxQwMWYF1LoLpArA1B0F1By7n6e+xo+rZ8VNx5cnhFjcpdliWXnvGIWj
	APScsVeQtCxm7bCdkA6dVJxcwqmYnE5aKFen/WIMS7d5OaPZIq1cvvCFZWH2Z/iAdoHzYi7XKSO
	zHQxK13vQJNToqM8q4mkqZT8C5bO0f0eGGZ5JF4BFZo5aRYhcStT6oxfgI6z4m5AADq5QuJh+fl
	juYqYXMALHlC2FY/hMPw7FQOHj4i/gMyNxA27siUIh8oMnE+EtedhvT4qDsgnjJi3KSH2p1lf3S
	OF9aLOX2THfbyVO0/VPyqHaci1Y+tg+tADiDIc1C1/eE2AgIVe3Yd8h5vQ==
X-Google-Smtp-Source: AGHT+IE3+psf91XCOHro+PC1a/SI5MDC/2OPlfM2/fjacndwnb/8g3KEaW7U/xEaO9qBj1xCtCZQCw==
X-Received: by 2002:a05:6a00:4606:b0:732:5611:cbb5 with SMTP id d2e1a72fcca58-7398037e23fmr3284822b3a.11.1743239734882;
        Sat, 29 Mar 2025 02:15:34 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739710ad63bsm3261156b3a.147.2025.03.29.02.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Mar 2025 02:15:34 -0700 (PDT)
Message-ID: <0138f37d-ea59-4ee2-9337-a63335a511a3@daynix.com>
Date: Sat, 29 Mar 2025 18:15:28 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 3/6] tun: Introduce virtio-net hash feature
To: Jason Wang <jasowang@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
References: <20250307-rss-v9-0-df76624025eb@daynix.com>
 <CACGkMEsR4_RreDbYQSEk5Cr29_26WNUYheWCQBjyMNUn=1eS2Q@mail.gmail.com>
 <edf41317-2191-458f-a315-87d5af42a264@daynix.com>
 <CACGkMEta3k_JOhKv44XiBXZb=WuS=KbSeJNpYxCdeiAgRY2azg@mail.gmail.com>
 <ff7916cf-8a9c-4c27-baaf-ca408817c063@daynix.com>
 <CACGkMEsVgbJPhz2d2ATm5fr3M2uSEoSXWW7tXZ_FrkQtmmu1wA@mail.gmail.com>
 <73250942-9ab9-4ee4-9bbe-e0a155a61f51@daynix.com>
 <CACGkMEud0Ki8p=z299Q7b4qEDONpYDzbVqhHxCNVk_vo-KdP9A@mail.gmail.com>
 <1f06b4b6-267a-4091-a3ba-e7b9dafae918@daynix.com>
 <CACGkMEsACb5S4rv-bWeBadDmnCcwFfnNp4MN7_4RQGB0MUWrzQ@mail.gmail.com>
 <20c34c80-7549-43e1-8bec-f7210a90f94e@daynix.com>
 <CACGkMEs8DyrusOsLPXSwhBvr3mKerzfNBQD3mLNfzLXhbCpR5A@mail.gmail.com>
 <ed72ad97-4ca7-40ba-ac47-9e776a07df64@daynix.com>
 <CACGkMEt-Y5E11qhE=vJP95fV+JAtLA+BW9P1jFUoocxysQ=W_g@mail.gmail.com>
 <a0f2676c-742e-4ba5-a233-9fc1f955d3df@daynix.com>
 <CACGkMEu_Qe6X1DyVt2qbpc1-iYDz874OX9wn=-uNsAkajY_ypg@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEu_Qe6X1DyVt2qbpc1-iYDz874OX9wn=-uNsAkajY_ypg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/03/24 13:40, Jason Wang wrote:
> On Fri, Mar 21, 2025 at 1:57 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/03/21 10:13, Jason Wang wrote:
>>> On Thu, Mar 20, 2025 at 1:33 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2025/03/20 10:31, Jason Wang wrote:
>>>>> On Wed, Mar 19, 2025 at 1:29 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> On 2025/03/19 9:58, Jason Wang wrote:
>>>>>>> On Tue, Mar 18, 2025 at 6:10 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>
>>>>>>>> On 2025/03/18 9:15, Jason Wang wrote:
>>>>>>>>> On Mon, Mar 17, 2025 at 3:07 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On 2025/03/17 10:12, Jason Wang wrote:
>>>>>>>>>>> On Wed, Mar 12, 2025 at 1:03 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> On 2025/03/12 11:35, Jason Wang wrote:
>>>>>>>>>>>>> On Tue, Mar 11, 2025 at 2:11 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On 2025/03/11 9:38, Jason Wang wrote:
>>>>>>>>>>>>>>> On Mon, Mar 10, 2025 at 3:45 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> On 2025/03/10 12:55, Jason Wang wrote:
>>>>>>>>>>>>>>>>> On Fri, Mar 7, 2025 at 7:01 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Hash reporting
>>>>>>>>>>>>>>>>>> ==============
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Allow the guest to reuse the hash value to make receive steering
>>>>>>>>>>>>>>>>>> consistent between the host and guest, and to save hash computation.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> RSS
>>>>>>>>>>>>>>>>>> ===
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> RSS is a receive steering algorithm that can be negotiated to use with
>>>>>>>>>>>>>>>>>> virtio_net. Conventionally the hash calculation was done by the VMM.
>>>>>>>>>>>>>>>>>> However, computing the hash after the queue was chosen defeats the
>>>>>>>>>>>>>>>>>> purpose of RSS.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Another approach is to use eBPF steering program. This approach has
>>>>>>>>>>>>>>>>>> another downside: it cannot report the calculated hash due to the
>>>>>>>>>>>>>>>>>> restrictive nature of eBPF steering program.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Introduce the code to perform RSS to the kernel in order to overcome
>>>>>>>>>>>>>>>>>> thse challenges. An alternative solution is to extend the eBPF steering
>>>>>>>>>>>>>>>>>> program so that it will be able to report to the userspace, but I didn't
>>>>>>>>>>>>>>>>>> opt for it because extending the current mechanism of eBPF steering
>>>>>>>>>>>>>>>>>> program as is because it relies on legacy context rewriting, and
>>>>>>>>>>>>>>>>>> introducing kfunc-based eBPF will result in non-UAPI dependency while
>>>>>>>>>>>>>>>>>> the other relevant virtualization APIs such as KVM and vhost_net are
>>>>>>>>>>>>>>>>>> UAPIs.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>>>>>>>>>>>>> Tested-by: Lei Yang <leiyang@redhat.com>
>>>>>>>>>>>>>>>>>> ---
> 
> [...]
> 
>>>
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> What's more, we've already had virito-net uAPI. Why not simply reusing them?
>>>>>>>>>>
>>>>>>>>>> See the above.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>> RSS and hash reporting must share
>>>>>>>>>>>>>> this parameter when both are enabled at the same time; otherwise RSS may
>>>>>>>>>>>>>> compute hash values that are not suited for hash reporting.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Is this mandated by the spec? If yes, we can add a check. If not,
>>>>>>>>>>>>> userspace risk themselves as a mis-configuration which we don't need
>>>>>>>>>>>>> to bother.
>>>>>>>>>>>>
>>>>>>>>>>>> Yes, it is mandated. 5.1.6.4.3 Hash calculation for incoming packets says:
>>>>>>>>>>>>        > A device attempts to calculate a per-packet hash in the following
>>>>>>>>>>>>        > cases:
>>>>>>>>>>>>        >
>>>>>>>>>>>>        >   - The feature VIRTIO_NET_F_RSS was negotiated. The device uses the
>>>>>>>>>>>>        >     hash to determine the receive virtqueue to place incoming packets.
>>>>>>>>>>>>        >   - The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The device
>>>>>>>>>>>>        >     reports the hash value and the hash type with the packet.
>>>>>>>>>>>>        >
>>>>>>>>>>>>        > If the feature VIRTIO_NET_F_RSS was negotiated:
>>>>>>>>>>>>        >
>>>>>>>>>>>>        >   - The device uses hash_types of the virtio_net_rss_config structure
>>>>>>>>>>>>        >     as ’Enabled hash types’ bitmask.
>>>>>>>>>>>>        >   - The device uses a key as defined in hash_key_data and
>>>>>>>>>>>>              hash_key_length of the virtio_net_rss_config structure (see
>>>>>>>>>>>>        >      5.1.6.5.7.1).
>>>>>>>>>>>>        >
>>>>>>>>>>>>        > If the feature VIRTIO_NET_F_RSS was not negotiated:
>>>>>>>>>>>>        >
>>>>>>>>>>>>        >   - The device uses hash_types of the virtio_net_hash_config structure
>>>>>>>>>>>>        >     as ’Enabled hash types’ bitmask.
>>>>>>>>>>>>        >   - The device uses a key as defined in hash_key_data and
>>>>>>>>>>>>        >     hash_key_length of the virtio_net_hash_config structure (see
>>>>>>>>>>>>        >      .1.6.5.6.4).
>>>>>>>>>>>>
>>>>>>>>>>>> So when both VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT are
>>>>>>>>>>>> negotiated, virtio_net_rss_config not only controls RSS but also the
>>>>>>>>>>>> reported hash values and types. They cannot be divergent.
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Note that spec use different commands for hash_report and rss.
>>>>>>>>>>>>
>>>>>>>>>>>> TUNSETVNETHASH is different from these commands in terms that it also
>>>>>>>>>>>> negotiates VIRTIO_NET_F_HASH_REPORT and VIRTIO_NET_F_RSS.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> There Are different "issues" here:
>>>>>>>>>>>
>>>>>>>>>>> 1) Whether or not we need to use a unified API for negotiating RSS and
>>>>>>>>>>> HASH_REPORT features
>>>>>>>>>>> 2) Whether or not we need to sue a unified API for setting RSS and
>>>>>>>>>>> HASH_REPORT configuration
>>>>>>>>>>>
>>>>>>>>>>> What I want to say is point 2. But what you raise is point 1.
>>>>>>>>>>>
>>>>>>>>>>> For simplicity, it looks to me like it's a call for having separated
>>>>>>>>>>> ioctls for feature negotiation (for example via TUNSETIFF). You may
>>>>>>>>>>> argue that either RSS or HASH_REPORT requires configurations, we can
>>>>>>>>>>> just follow what spec defines or not (e.g what happens if
>>>>>>>>>>> RSS/HASH_REPORT were negotiated but no configurations were set).
>>>>>>>>>>
>>>>>>>>>> Unfortunately TUNSETIFF does not fit in this use case. The flags set
>>>>>>>>>> with TUNSETIFF are fixed, but the guest can request a different feature
>>>>>>>>>> set anytime by resetting the device.
>>>>>>>>>
>>>>>>>>> TUNSETIFF, enables the device to be able to handle RSS/HASREPORT.
>>>>>>>>> TUNSETHASH/RSS. dealing with RSS/HASH command from userspace.
>>>>>>>>
>>>>>>>> We also needs to be able to disable them at runtime so that we can
>>>>>>>> handle resets.
>>>>>>>
>>>>>>> Via TUNSETHASH/RSS? I think it should have a way to accept parameters
>>>>>>> that disable RSS or hash report.
>>>>>>
>>>>>> That's what this patch implements. TUNSETVNETHASH accepts parameters to
>>>>>> choose what features to be enabled.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> This is the way we used to do for multi queue and vnet header.
>>>>>>>>> TUNSETIFF requires CAP_NET_ADMIN, this could be an extra safe guard
>>>>>>>>> for unprivileged userspace.
>>>>>>>>
>>>>>>>> I intend to allow using this feature without privilege. A VMM is usually
>>>>>>>> unprivileged and requiring a privilege to configure tuntap is too
>>>>>>>> prohibitive.
>>>>>>>
>>>>>>> For safety, tun is not allowed to be created by unprivileged users.
>>>>>>> And it's not to configure the tuntap dynamically, it's about telling
>>>>>>> the function that tuntap can have (not necessarily enabled though) .
>>>>>>
>>>>>> I don't think we need another barrier for the new functions. Once an
>>>>>> unprivileged user get a file descriptor of tuntap from a privileged
>>>>>> user, they are free to enable RSS and/or hash reporting.
>>>>>
>>>>> Only if such a feature is allowed by the privileged user.
>>>>
>>>> I don't see a reason not to allow the feature to unprivileged users. It
>>>> only complicates the setup.
>>>
>>> For safety, e.g reduce the chance for unprivileged user to explore
>>> part of the kernel codes.
>>
>> It indeed reduces the attack surface, but it's fine without the
>> reduction I guess? It's not a feature so complicated;
> 
> I don't know how to define complicated things here but simplicity
> doesn't necessarily mean safety.
> 
>> I saw there were
>> complicated changes like namespaces and io_uring that caused controversy
>> when exposing them to unprivilged users, but this feature is not like
>> them, I suppose.
> 
> We limit feature setting through tun_set_iff in the past. Instead of
> trying to argue if RSS is safe to be enabled without TUNSETIFF,
> following what has been used in the past is always simpler and easier.
> 
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>       > >> In the virtio-net specification, it is not defined what would
>>>>>>>>>> happen if
>>>>>>>>>>>> these features are negotiated but the VIRTIO_NET_CTRL_MQ_RSS_CONFIG or
>>>>>>>>>>>> VIRTIO_NET_CTRL_MQ_HASH_CONFIG commands are not sent. There is no such
>>>>>>>>>>>> ambiguity with TUNSETVNETHASH.
>>>>>>>>>>>
>>>>>>>>>>> So I don't see advantages of unifying hash reports and rss into a
>>>>>>>>>>> single ioctl. Let's just follow what has been done in the spec that
>>>>>>>>>>> uses separated commands. Tuntap is not a good place to debate whether
>>>>>>>>>>> those commands could be unified or not. We need to move it to the spec
>>>>>>>>>>> but assuming spec has been done, it might be too late or too few
>>>>>>>>>>> advantages for having another design.
>>>>>>>>>>
>>>>>>>>>> It makes sense for the spec to reuse the generic feature negotiation
>>>>>>>>>> mechanism, but the situation is different for tuntap; we cannot use
>>>>>>>>>> TUNSETIFF and need to define another. Then why don't we exploit this
>>>>>>>>>> opportunity to have an interface with well-defined semantics?
>>>>>>>>>
>>>>>>>>> That's perfectly fine, but it needs to be done in virtio-net's uAPI
>>>>>>>>> not tun's. What's more, if you think two commands are not
>>>>>>>>> well-defined, let's fix that in the virtio spec first.
>>>>>>>>>
>>>>>>>>>> The virtio
>>>>>>>>>> spec does its best as an interface between the host and guest and tuntap
>>>>>>>>>> does its best as an UAPI.
>>>>>>>>>
>>>>>>>>> See above, let's fix the uAPI first. We don't want DPDK to use tun's
>>>>>>>>> uAPI for RSS
>>>>>>>>
>>>>>>>> virtio-net's UAPI is for the virtio spec which has a capable generic
>>>>>>>> feature negotiation mechanism. tuntap needs its own feature negotiation
>>>>>>>> and it's nothing to do with virtio-net's UAPI.
>>>>>>>
>>>>>>> Well, I don't mean the part of the feature negotiation. I mean the
>>>>>>> part for rss and hash report configuration.
>>>>>>
>>>>>> The feature negotiation still matters when deciding the granularity of
>>>>>> ioctls. We need one ioctl for a feature negotiation, and to avoid having
>>>>>> an intermediate state,
>>>>>
>>>>> I don't understand this. For example, driver can choose to
>>>>>
>>>>> 1) negotiate RSS
>>>>> 2) do something else.
>>>>> 3) configure RSS
>>>>>
>>>>> Spec doesn't require those two to be configured at the same time, so
>>>>> "intermediate state" is allowed.
>>>>
>>>> The spec doesn't define what should happen in the intermediate state either.
>>>
>>> Yes but my point is that in the uAPI layer we don't need to care about
>>> the intermediate state. It can just work as other features, e.g having
>>> a default state after feature negotiation is more than enough. This is
>>> the way we deal with other features like vnet header etc.
>>   > >>
>>>> For a hardware implementation I think it's fine whatever the
>>>> implementation defines as the intermediate state. But for the UAPI, it's
>>>> better avoiding having such a definition to keep the interface minimal
>>>> and maximize the UAPI stability.
>>>
>>> Well, even if you think there's an issue:
>>>
>>> 1) I don't see how we can avoid the intermediate state consider guest
>>> have such state
>>> 2) We need to "fix" virtio spec and virito-net first, tuntap is not
>>> the right place to workaround virtio specific issues
>>
>> Let me summarize my points that support having one ioctl to negotiate
>> features and configuration:
>>
>> The virtio spec has a generic feature negotiation mechanism and reusing
>> it resulted in having an intermediate state between the feature
>> negotiation and configuration. There is nothing wrong about that so we
>> don't need to "fix" the virtio spec.
> 
> Good to know that.
> 
>>
>> tuntap can also perform feature negotitaion with TUNSETIFF, but
>> TUNSETIFF have a few problems:
> 
> TUNSETIFF is not feature negotiation, it's about device or queue
> provisioning as well as the features. From the view of the virtio, it
> is used to provision the device_features. For example, qemu only calls
> TUNSETIFF when it tries to open the tap fd.
 > >>
>> 1. It requires a privilege. One can argue that it reduces the attack
>> surface and it indeed does, but it's fine without the reduction I guess?
>> It's not a feature so complicated; I saw there were complicated changes
>> like namespaces and io_uring that caused controversy when exposing them
>> to unprivilged users, but this feature is not like them.
> 
> I'm not asking to invent something new, but just reuse the security
> stuff that has been already used for more than a decade. It would be
> always easier to relax the check instead of enforce the check which
> may break uAPI. I can imagine it would not take a lot of codes to
> achieve this.
> 
>>
>> 2. It cannot change the enabled feature set at runtime. The virtio spec
>> allows changing it by resetting.
> 
> RSS is not the first feature of those requirements. TUN has
> implemented various virtio specific features in the past.
> 
>>
>> So we need to design a set of new ioctls for both feature negotiation
>> and configuration. When doing so, eliminating the intermediate state is
>> a good principle to determine the optimal size of ioctls.
> 
> As discussed, having a default state after TUNSETIFF is more than
> enough. That is how a multi queue/vnet header works:
> 
> 1) for multiqueue, when IFF_MULTIQUEUE is set, starting with 1 queue
> 2) for vnet header, vnet header will be zero unless TUNSETVETHDR is called
> 
> I don't see how RSS makes anything different.
> 
> For intermediate states, with your proposal, it still requires the
> userspace to assume a default state when doing TUNSETVETRSS etc.

> >>
>> In theory, it is possible to have small ioctls that set only one scalar
>> value or even one bit, but that doesn't make sense. This principle helps
>> determine the optimal size of ioctls; it minimizes the complexity of
>> both the userspace and the kernel.
> 
> Well the complexity is not measured by the number of ioctls or
> structures. I basically meant:
> 
> 1) IF_RSS to provision the device with the RSS features, this could be
> fetched from TUNGETIFF

It requires changes for libvirt, qemu-bridge-helper, and potentially 
other VMMs and DPDK. I would like to avoid such chores if the only 
reason to do so is the presence of prior examples.

The features available via TUNSETIFF is fetched with TUNGETFEATURES, not 
TUNGETIFF.

> 2) Having a default state implemented in TUN that complies with the spec

If TUNSETIFF is only for device_feature, a natural choice will be to 
initialize driver_feature with VIRTIO_NET_F_HASH_REPORT and 
VIRTIO_NET_F_RSS unset.

> 3) TUNSETVET/GETHASH to send and receive RSS configuration

If TUNSETIFF is only for device_feature, we need two other ioctls:
- one to set driver_feature and the RSS/hash reporting configuration
- one that tells supported hash types

The former is implemented with TUNSETVNETHASH. The latter is implemented 
with TUNGETVNETHASHCAP.

> 
>>
>>>
>>>>
>>>>>
>>>>>> the ioctl should also do the configuration. Hence
>>>>>> that one ioctl should do all of the feature negotiation and configuration.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> The structures for two commands have unused or redundant fields and a
>>>>>>>> flexible array in the middle of the structure, but they are ABIs so we
>>>>>>>> can't change it.
>>>>>>>>
>>>>>>>> DPDK is another reason to define tuntap's own UAPIs. They don't care
>>>>>>>> unused or redundant fields and a flexible array in middle that are
>>>>>>>> present in the virtio spec. It will also not want to deal with the
>>>>>>>> requirement of little endian. Constructing struct virtio_net_rss_config
>>>>>>>> is an extra burden for DPDK.
>>>>>>>
>>>>>>> I meant for vhost-user implementation in DPDK, it needs to use
>>>>>>> virtio-net uAPI not tuntap's for example.
>>>>>>
>>>>>> The vhost-user implementation will use tuntap's UAPIs for its ethernet
>>>>>> device backend.
>>>>>
>>>>> That sounds pretty weird, vhost-user has nothing related to tuntap.
>>>>
>>>> My expression in the last email was weird. More precisely, the ethernet
>>>> backend of tuntap will use the UAPIs, and the vhost-user will use the
>>>> ethernet backend in turn.
>>>
>>> I don't understand what "ethernet backend" means here.
>>
>> It is a driver that serves the Ethernet Device API, which is agnostic on
>> application and driver. The Ethernet Device API, including RSS
>> configuration is documented at:
>> https://doc.dpdk.org/api/rte__ethdev_8h.html
>>
>> The Ethernet API are not bound to the virtio spec since they are not
>> specific to the vhost application or the tuntap driver. Hence they
>> operate in native endian and do not have extra fields, and tuntap's
>> structures are more suited to the ethernet backend than the virtio ones.
> 
> vhost-user is the device implementation not an ethernet driver. Why
> did it use tuntap's uAPI and do the useless endian conversion twice?

Here the ethernet backend refers to the code that interacts with tuntap 
instead of vhost-user. Please note that I wrote "the vhost-user will use 
the ethernet backend" earlier.

> 
>>
>>>
>>>>
>>>>>
>>>>>> It uses the generic interface of ethernet device so for
>>>>>> RSS it will use functions like rte_eth_dev_rss_hash_update() for
>>>>>> example. tuntap's UAPIs are more suited to implement these interfaces as
>>>>>> they operate in native endian and don't have extra fields.
>>>>>
>>>>> Nope, for example it needs to use le for virtio_net_hdr if a modern
>>>>> device is used. But it needs a "native" endian according to the guest
>>>>> endian via TUNSETVNETLE/BE. We don't have a choice as virtio-net hdr
>>>>> support in tuntap is much earlier than modern devices.
>>>>>
>>>>> Let's don't do the same thing (native endian) for tuntap as RSS
>>>>> depends on modern, so we know it must be le.
>>>>
>>>> virtio_net_hdr is the data path while the current discussion is about
>>>> the control path. All configuration knobs of tuntap operates in the
>>>> native endian.
>>>
>>> Because they are not directly related to virtio specification.  We
>>> don't want to duplicate virtio-net with our own version every time E.g
>>> once RSSv2 or aRFS were implemented. Or I would even introduce a
>>> single uAPI to transport possible cvq commands then we can avoid
>>> inventing new ioctls that just transport cvq commands.
>>>
>>>>
>>>> So I think we should stick to the little endian for the data path while
>>>> we should stick to the native endian for the control path to maximize
>>>> the consistency.
>>>
>>> I don't see a reason to differ datapath from control path. Virtio-net
>>> uAPI has been reused by tuntap for more than a decade.
>>
>> tuntap's control path all operate in the native endian.
> 
> It's just a description of the current status, people can easily say
> tuntap's data path all operate in the native endian before the support
> of version 1.0.
> 
>> They never used
>> the endian of the data path in the control path.
> 
> Once virtio uAPI can be reused, we need to do that.

It discourages the usage of virtio UAPI; when the userspace wants native 
endian, why will we want to force using virtio UAPI, which requires 
little endian?

> 
>>
>>>
>>>>
>>>>>
>>>>>
>>>>>>
>>>>>> DPDk applications other than vhost-user also matter; they do not care
>>>>>> what virtio does at all.
>>>>>>
>>>>>>     > >>
>>>>>>>> On the other hand, Constructing tuntap-specific structures is not that
>>>>>>>> complicated for VMMs.
>>>>>>>
>>>>>>> Not complicated but redundant.
>>>>>>>
>>>>>>>> A VMM will need to inspect struct
>>>>>>>> virtio_net_rss_config anyway to handle migration and check its size so
>>>>>>>> it can store the values it inspected to struct tun_vnet_hash and struct
>>>>>>>> tun_vnet_hash_rss and pass them to the kernel.
>>>>>>>
>>>>>>> I don't see how rss and hash reports differ from what we have now.
>>>>>>> Those inspections must be done anyhow for compatibility for example
>>>>>>> the check of offloading features. Such steps could not be eliminated
>>>>>>> no matter how we design the uAPI.
>>>>>>
>>>>>> I explained the difference between the virtio and tuntap UAPIs, not
>>>>>> between RSS and hash reporting.
>>>>>
>>>>> See above.
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> The overall userspace implementation will be simpler by having
>>>>>>>> structures specifically tailored for the communication between the
>>>>>>>> userspace and kernel.
>>>>>>>
>>>>>>> This is exactly how a good uAPI should behave. If uAPI in virtio-net
>>>>>>> can't do this, I don't understand why uAPI in tuntap can solve it.
>>>>>>
>>>>>> The UAPI in virtio-net cannot do it because it's already fixed and it
>>>>>> also needs to perform endian conversion for the VM use case. tuntap
>>>>>> doesn't have these restrictions.
>>>>>
>>>>> Same here.
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I don't think there is an advantage to split ioctls to follow the spec
>>>>>>>>>> after all. It makes sense if we can pass-through virtio commands to
>>>>>>>>>> tuntap, but it is not possible as ioctl operation codes are different
>>>>>>>>>> from virtio commands.
>>>>>>>>>
>>>>>>>>> I don't see a connection with the operation code. For example, we can
>>>>>>>>> add new uAPIs in virtio-net which could be something like:
>>>>>>>>>
>>>>>>>>>       struct virtio_net_rss_config_header {
>>>>>>>>>            __le32 hash_types;
>>>>>>>>>            __le16 indirection_table_mask;
>>>>>>>>>            __le16 unclassified_queue;
>>>>>>>>>            __le16 indirection_table[];
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> struct virtio_net_rss_config_tailer {
>>>>>>>>>            __le16 max_tx_vq;
>>>>>>>>>            u8 hash_key_length;
>>>>>>>>>            u8 hash_key_data[];
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> These two are used by TUNSETVNETRSS. And simply reuse the
>>>>>>>>> virtio_net_hash_config for TUNSETVETHASH.
>>>>>>>>      > > With this, we can tweak the virtio-net driver with this new uAPI. Then
>>>>>>>>> tap* can reuse this.
>>>>>>>>
>>>>>>>> I implemented a UAPI and driver change accordingly:
>>>>>>>> https://lore.kernel.org/r/20250318-virtio-v1-0-344caf336ddd@daynix.com
>>>>>>>>
>>>>>>>> This is a nice improvement for the driver, but I still don't think it is
>>>>>>>> suited for the UAPI of tuntap.
>>>>>>>
>>>>>>> Any reason for this? It should work like virtio_net_hdr.
>>>>>>>
>>>>>>>> The requirements of extra fields and
>>>>>>>> little endian cannot be removed from the virtio spec but they are
>>>>>>>> irrelevant for tuntap.
>>>>>>>
>>>>>>> I don't understand this part. What fields are "extra" and need to be
>>>>>>> removed from the spec?
>>>>>>
>>>>>> All fields not included in struct tun_vnet_hash and struct
>>>>>> tun_vnet_hash_rss. Namely, for struct virtio_net_hash_config:
>>>>>> - reserved
>>>>>> - hash_key_length
>>>>>> - hash_key_data
>>>>>>
>>>>>> For struct virtio_net_rss_config:
>>>>>> - max_tx_vq
>>>>>> - hash_key_length
>>>>>
>>>>> See my above reply, and I basically meant
>>>>>
>>>>> TUNSETVETHASH accept struct virtio_net_hash_config;
>>>>> TUNSETVETRSS accept struct virtio_net_rss_config_hdr + struct
>>>>> virtio_net_rss_config_trailer;
>>>>
>>>> That still bring the extra fields I noted in the last email.
>>>
>>> I don't know how to define "extra" here. Let's summarize here:
>>>
>>> Method A:
>>>
>>> 1) virtio specification use separate commands for has_report and rss
>>> 2) hash_port ans rss doesn't depend on each other
>>> 3) reuse virtio-net uAPI
>>>
>>> Method B:
>>>
>>> 1) trying to define and remove the "extra" fields in tuntap, and
>>> redefine it in TUNTAP
>>>
>>> It would always be much easier to start from simply reusing the
>>> virtio-net uAPI. Method B makes both the implementation and reviewing
>>> harder, as we need to
>>>
>>> 1) revisit the design of the virtio spec, this needs to be done in the
>>> virtio community not here
>>> 2) audit the difference between virtio spec and TUN/TAP, that's why we
>>> have a very long discussion here
>>>
>>> For example, the root cause of why you think the max_tx_vq is "extra" is:
>>>
>>> 1) The spec defines VIRTIO_NET_F_RSS and VIRTIO_NET_F_MQ as independent features
>>> 2) Your code tries to re-use IFF_MULTI_QUEUE for both VIRTIO_NET_F_RSS
>>> and VIRTIO_NET_F_MQ, this would have a lot of implications, e.g
>>> automatic steering might be applied when only RSS is negotiated etc
>>>
>>> The correct way to implement this is:
>>>
>>> 1) Introduce IFF_RSS and only set it during TUNSETIFF when device only
>>> offers RSS
>>
>> Please see the summary of "my points that support having one ioctl to
>> negotiate features and configuration" I wrote the above.
>>
>>> 2) reuse virtio-net uAPI and accept max_tx_vq and use that to change
>>> the queue(or queue paris) if necessary
>>
>> I don't think it's possible; we need file descriptors associated with
>> queues, which is something you cannot express with the virtio-net
>> structures.
> 
> So:
> 
> 1) Provisioning queues were still done via TUNSETIFF
> 2) We just need to hook max_tx_vq (the helpers were already there) to
> the helpers to enable and disable a queue instead of depending on the
> TUNSETQUEUE

1) is sufficient and 2) is redundant. We cannot provision queues 
according to max_tx_vq so the only way to remove this redundancy is not 
to have the field in tuntap's UAPI in the first place.

Regards,
Akihiko Odaki

> 
>>
>> Regards,
>> Akihiko Odaki
> 
> Thanks
> 


