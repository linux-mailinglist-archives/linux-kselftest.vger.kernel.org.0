Return-Path: <linux-kselftest+bounces-28794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53948A5D540
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 06:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A6B07A8A8C
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 05:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9FF1DE4CD;
	Wed, 12 Mar 2025 05:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="yEe1kYWN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBB21DC9B5
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 05:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741755823; cv=none; b=fGd4+OqrV8qyaUg22UqVnvooREklv/i3MIFxuyUQ4CeBoygauTMSaZ9DdDF1RHlCJNIF9JWY+DoIWPI7JsoGywJAzNXsmbZXVFXcLXRVzQp9Q6lTWXdDBJmb/1bNk+fBJT9T9xFcDwkKS9sIqOxpM4znuxyMK7+evoSzCcT8Ias=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741755823; c=relaxed/simple;
	bh=JvJ/7O10ZNpWh7VduRBNGBUH6gCm5z8D1KTrvXZNrO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zo5/ixabK8ldS2XIAa4HOE2Lze6qJHiO6sTMSAaRY62E9G8meMSfyXy68QLWxv/XV9/59PXMwRDcgjcT51JigTHNZdvcW0SJ7rGSHCDl6iL8BPEEcJXzPEYfJovmWl63Thsxia90vAT3i3mjjX6wRKDsRhW7tLh06Aa74Xa/hOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=yEe1kYWN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2240b4de12bso28514685ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 22:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741755820; x=1742360620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6QiFc6SJG2kyM7Br5fhaU7GX9dr8/OrkWYxYdeRvaF4=;
        b=yEe1kYWNNAbeLgMPhtZhvA4rEBkpdx8WDzyiuFnQ/VZoTWk4pgY47Soq4MlUtta6iV
         aDSoc5/tL4s+jNub93icHO6gtBQIfNVgaL54wmFPy+tVNTcUB+2NT99TszW/vqHEckfx
         0wp78JpOfmZnFPlb0REJeBeUHofu3q2yzOppdbBiecwdjE5JFasOcvoezjDv6NJJjTYj
         GSjKu8q6yFJIUd+BMMA/yoJoM75aE5osuhbNvU4zO9YYfzD3n2+9jn8CpXDobRA9JjHy
         kqUqM4CDjl0hkJa9HwvBeOCI2aZqUmCbAGOw31ut2y4Ijy9GEaDU4OFWUD9T3cof27k+
         60cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741755820; x=1742360620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6QiFc6SJG2kyM7Br5fhaU7GX9dr8/OrkWYxYdeRvaF4=;
        b=HED1lXKvpa/3ZCcxgh7xwhL2HmOzL+0xzhBCPies5OW3HAHPg59X53IfO21k2ydBND
         s0AsybrSEwPAD900FAz+WkidDIYfnIfpK2SmZLkoPPH6qZFlsJSjljTu8x0s8YqMSjJ4
         1kxzKQURmEPI0ratorWqeqsUXcelTzsPq5wDk/4MfsGZm8zZRqMZ4m8tMDnrT32D8eLr
         6Ozb1NQaBhRVTieZegersMd9jFl6bIYYeGt6qyRi0f/BUJQOGEFEt6KUrqM4+47KO3k8
         Y9A0xyFdqOdLZ6CYvQG9wDI+2vD2skylPxJ3CFgfWu2l5sRWjpA+wiXMsXKrexZrWZXM
         bNHg==
X-Forwarded-Encrypted: i=1; AJvYcCVasQOHjsh88GV46I5yysz20QeCbRK22vit8jctRAUfyZsrnVsWWNPLiBG0QIpCPe83ak5kNJ7al7fXUetIPgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzel7seHwILWuzrTFc9Z+vKWiM+q8/k7BN5SYye/NrMjh8iz2VK
	2Mfen96SyPOiOD+EwhTCjyl5LtRoZdCPk0xN5cUgn/AEcpigGSNh8Jza8bafm/c=
X-Gm-Gg: ASbGnctNQQIbWVifP9JSxohODzxBdBEtlKveXI6uEecqr8W4BRwwjehCe5mcMOA+i0m
	vCzseNqMHTEro3PM8gOSvNwRVcn0glAAPI2ivKEqmLqUEuACCnxAvontJfJC+iXy2TBjbbmhBVy
	kmvHjY1vcumk2qIps4QiFX42qJzt5dKU1KEaA1MO/xXW2QU/lLGLO8CQ81iidAhs4i+oCOV9fmx
	cHtl7lMh3nHVXlzfBUg5mJPGsJWcgMvKJavH9xkuUiU5CnfeuRJ2VqdxIawA/ayJ1Igr2X5AAB7
	Shy0Y2Gr5rUPAMLS7sgOMwvnuwDcME/dxFBCrlBDAoZlMf/QB7aoehnMbw==
X-Google-Smtp-Source: AGHT+IENgVGmOQ2e2sjFoBtOxZ+KC1QlBkq4WVH7vBx21DbhpzjmB/6EMIeKK8qnTk6hoj/TMUiufQ==
X-Received: by 2002:a17:902:e80a:b0:224:de2:7fd6 with SMTP id d9443c01a7336-2242889f527mr316528595ad.25.1741755819696;
        Tue, 11 Mar 2025 22:03:39 -0700 (PDT)
Received: from [157.82.205.237] ([157.82.205.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f7d6sm106724155ad.107.2025.03.11.22.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 22:03:39 -0700 (PDT)
Message-ID: <ff7916cf-8a9c-4c27-baaf-ca408817c063@daynix.com>
Date: Wed, 12 Mar 2025 14:03:34 +0900
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
 <20250307-rss-v9-3-df76624025eb@daynix.com>
 <CACGkMEsNHba=PY5UQoH1zdGQRiHC8FugMG1nkXqOj1TBdOQrww@mail.gmail.com>
 <7978dfd5-8499-44f3-9c30-e53a01449281@daynix.com>
 <CACGkMEsR4_RreDbYQSEk5Cr29_26WNUYheWCQBjyMNUn=1eS2Q@mail.gmail.com>
 <edf41317-2191-458f-a315-87d5af42a264@daynix.com>
 <CACGkMEta3k_JOhKv44XiBXZb=WuS=KbSeJNpYxCdeiAgRY2azg@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEta3k_JOhKv44XiBXZb=WuS=KbSeJNpYxCdeiAgRY2azg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/03/12 11:35, Jason Wang wrote:
> On Tue, Mar 11, 2025 at 2:11 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/03/11 9:38, Jason Wang wrote:
>>> On Mon, Mar 10, 2025 at 3:45 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2025/03/10 12:55, Jason Wang wrote:
>>>>> On Fri, Mar 7, 2025 at 7:01 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> Hash reporting
>>>>>> ==============
>>>>>>
>>>>>> Allow the guest to reuse the hash value to make receive steering
>>>>>> consistent between the host and guest, and to save hash computation.
>>>>>>
>>>>>> RSS
>>>>>> ===
>>>>>>
>>>>>> RSS is a receive steering algorithm that can be negotiated to use with
>>>>>> virtio_net. Conventionally the hash calculation was done by the VMM.
>>>>>> However, computing the hash after the queue was chosen defeats the
>>>>>> purpose of RSS.
>>>>>>
>>>>>> Another approach is to use eBPF steering program. This approach has
>>>>>> another downside: it cannot report the calculated hash due to the
>>>>>> restrictive nature of eBPF steering program.
>>>>>>
>>>>>> Introduce the code to perform RSS to the kernel in order to overcome
>>>>>> thse challenges. An alternative solution is to extend the eBPF steering
>>>>>> program so that it will be able to report to the userspace, but I didn't
>>>>>> opt for it because extending the current mechanism of eBPF steering
>>>>>> program as is because it relies on legacy context rewriting, and
>>>>>> introducing kfunc-based eBPF will result in non-UAPI dependency while
>>>>>> the other relevant virtualization APIs such as KVM and vhost_net are
>>>>>> UAPIs.
>>>>>>
>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>> Tested-by: Lei Yang <leiyang@redhat.com>
>>>>>> ---
>>>>>>     Documentation/networking/tuntap.rst |   7 ++
>>>>>>     drivers/net/Kconfig                 |   1 +
>>>>>>     drivers/net/tap.c                   |  68 ++++++++++++++-
>>>>>>     drivers/net/tun.c                   |  98 +++++++++++++++++-----
>>>>>>     drivers/net/tun_vnet.h              | 159 ++++++++++++++++++++++++++++++++++--
>>>>>>     include/linux/if_tap.h              |   2 +
>>>>>>     include/linux/skbuff.h              |   3 +
>>>>>>     include/uapi/linux/if_tun.h         |  75 +++++++++++++++++
>>>>>>     net/core/skbuff.c                   |   4 +
>>>>>>     9 files changed, 386 insertions(+), 31 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/networking/tuntap.rst b/Documentation/networking/tuntap.rst
>>>>>> index 4d7087f727be5e37dfbf5066a9e9c872cc98898d..86b4ae8caa8ad062c1e558920be42ce0d4217465 100644
>>>>>> --- a/Documentation/networking/tuntap.rst
>>>>>> +++ b/Documentation/networking/tuntap.rst
>>>>>> @@ -206,6 +206,13 @@ enable is true we enable it, otherwise we disable it::
>>>>>>           return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
>>>>>>       }
>>>>>>
> 
> [...]
> 
>>>>>> +static inline long tun_vnet_ioctl_sethash(struct tun_vnet_hash_container __rcu **hashp,
>>>>>> +                                         bool can_rss, void __user *argp)
>>>>>
>>>>> So again, can_rss seems to be tricky. Looking at its caller, it tires
>>>>> to make eBPF and RSS mutually exclusive. I still don't understand why
>>>>> we need this. Allow eBPF program to override some of the path seems to
>>>>> be common practice.
>>>>>
>>>>> What's more, we didn't try (or even can't) to make automq and eBPF to
>>>>> be mutually exclusive. So I still didn't see what we gain from this
>>>>> and it complicates the codes and may lead to ambiguous uAPI/behaviour.
>>>>
>>>> automq and eBPF are mutually exclusive; automq is disabled when an eBPF
>>>> steering program is set so I followed the example here.
>>>
>>> I meant from the view of uAPI, the kernel doesn't or can't reject eBPF
>>> while using automq.
>>   > >>
>>>> We don't even have an interface for eBPF to let it fall back to another
>>>> alogirhtm.
>>>
>>> It doesn't even need this, e.g XDP overrides the default receiving path.
>>>
>>>> I could make it fall back to RSS if the eBPF steeering
>>>> program is designed to fall back to automq when it returns e.g., -1. But
>>>> such an interface is currently not defined and defining one is out of
>>>> scope of this patch series.
>>>
>>> Just to make sure we are on the same page, I meant we just need to
>>> make the behaviour consistent: allow eBPF to override the behaviour of
>>> both automq and rss.
>>
>> That assumes eBPF takes precedence over RSS, which is not obvious to me.
> 
> Well, it's kind of obvious. Not speaking the eBPF selector, we have
> other eBPF stuffs like skbedit etc.
> 
>>
>> Let's add an interface for the eBPF steering program to fall back to
>> another steering algorithm. I said it is out of scope before, but it
>> makes clear that the eBPF steering program takes precedence over other
>> algorithms and allows us to delete the code for the configuration
>> validation in this patch.
> 
> Fallback is out of scope but it's not what I meant.
> 
> I meant in the current uAPI take eBPF precedence over automq. It's
> much more simpler to stick this precedence unless we see obvious
> advanatge.

We still have three different design options that preserve the current 
precedence:

1) Precedence order: eBPF -> RSS -> automq
2) Precedence order: RSS -> eBPF -> automq
3) Precedence order: eBPF OR RSS -> automq where eBPF and RSS are 
mutually exclusive

I think this is a unique situation for this steering program and I could 
not find another example in other eBPF stuffs.

The current version implements 3) because it is not obvious whether we 
should choose either 1) or 2). But 1) will be the most capable option if 
eBPF has a fall-back feature.

> 
>>
>>>
>>>>
>>>>>
> 
> [...]
> 
>>>>> Is there a chance that we can reach here without TUN_VNET_HASH_REPORT?
>>>>> If yes, it should be a bug.
>>>>
>>>> It is possible to use RSS without TUN_VNET_HASH_REPORT.
>>>
>>> Another call to separate the ioctls then.
>>
>> RSS and hash reporting are not completely independent though.
> 
> Spec said:
> 
> """
> VIRTIO_NET_F_RSSRequires VIRTIO_NET_F_CTRL_VQ.
> """

I meant the features can be enabled independently, but they will share 
the hash type set when they are enabled at the same time.

> 
>>
>> A plot twist is the "types" parameter; it is a parameter that is
>> "common" for RSS and hash reporting.
> 
> So we can share part of the structure through the uAPI.

Isn't that what this patch does?

> 
>> RSS and hash reporting must share
>> this parameter when both are enabled at the same time; otherwise RSS may
>> compute hash values that are not suited for hash reporting.
> 
> Is this mandated by the spec? If yes, we can add a check. If not,
> userspace risk themselves as a mis-configuration which we don't need
> to bother.

Yes, it is mandated. 5.1.6.4.3 Hash calculation for incoming packets says:
 > A device attempts to calculate a per-packet hash in the following
 > cases:
 >
 >   - The feature VIRTIO_NET_F_RSS was negotiated. The device uses the
 >     hash to determine the receive virtqueue to place incoming packets.
 >   - The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The device
 >     reports the hash value and the hash type with the packet.
 >
 > If the feature VIRTIO_NET_F_RSS was negotiated:
 >
 >   - The device uses hash_types of the virtio_net_rss_config structure
 >     as ’Enabled hash types’ bitmask.
 >   - The device uses a key as defined in hash_key_data and
       hash_key_length of the virtio_net_rss_config structure (see
 >      5.1.6.5.7.1).
 >
 > If the feature VIRTIO_NET_F_RSS was not negotiated:
 >
 >   - The device uses hash_types of the virtio_net_hash_config structure
 >     as ’Enabled hash types’ bitmask.
 >   - The device uses a key as defined in hash_key_data and
 >     hash_key_length of the virtio_net_hash_config structure (see
 >      .1.6.5.6.4).

So when both VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT are 
negotiated, virtio_net_rss_config not only controls RSS but also the 
reported hash values and types. They cannot be divergent.

> 
> Note that spec use different commands for hash_report and rss.

TUNSETVNETHASH is different from these commands in terms that it also 
negotiates VIRTIO_NET_F_HASH_REPORT and VIRTIO_NET_F_RSS.

In the virtio-net specification, it is not defined what would happen if 
these features are negotiated but the VIRTIO_NET_CTRL_MQ_RSS_CONFIG or 
VIRTIO_NET_CTRL_MQ_HASH_CONFIG commands are not sent. There is no such 
ambiguity with TUNSETVNETHASH.

Regards,
Akihiko Odaki

> 
>>
>> The paramter will be duplicated if we have separate ioctls for RSS and
>> hash reporting, and the kernel will have a chiken-egg problem when
>> ensuring they are synchronized; when the ioctl for RSS is issued, should
>> the kernel ensure the "types" parameter is identical with one specified
>> for hash reporting? It will not work if the userspace may decide to
>> configure hash reporting after RSS.
>>
> 
> See my reply above.
> 
> Thanks
> 


