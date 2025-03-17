Return-Path: <linux-kselftest+bounces-29179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 814EAA642CF
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 08:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7581892843
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 07:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C325321ADC9;
	Mon, 17 Mar 2025 07:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="TZSLRTKq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DE4219A93
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 07:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742195219; cv=none; b=eVXiokDjuGyf7RXRo7bc1pqHAA36L9ItWNDPPxy5uHOCJXnhSdSY/1qcjCLgsCrDyU+wMUpeiMdaf7uesQ5Nr6YK1MztNKRBWv7XjeBNd3rNOcbORsNVqAd2T+dXlIh0KlFPlx4La73bCYpzyHu6fG5ybpG7TjhB/ogbmZV4B0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742195219; c=relaxed/simple;
	bh=+6wGjtvWAnbFslZIopmwE3OjGQiz2zKkeuZX0rpkM7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XRCW5JE1L8SP1MpVW1rqlqHaxK80K5Z89ifXR3Bc6KrePaHATOneHei7+TkIvr+qov5PCm8Vx4+CRXygk6DbRczOqeUuyXzbGdZLIyI7lzmDNHMcqs7iTk7EJSy3dcqt2/MerqthiZTvLy7dO+NmvYA5nMYSlNjD5bFHZ9TXVlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=TZSLRTKq; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3014ae35534so1951097a91.0
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 00:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742195216; x=1742800016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LlhDYNxQXaljro5xNb8yMyAUj7KHJvqFuDdC/trm+HE=;
        b=TZSLRTKqj/HvyFhrD7/fd7Ey0x+O0Bq161pD5PLTJMuBTh4GJm+TeL0RuECDxRYPXg
         EF/eAh94Mq/KpElKGudX25qVI4rUBa1TsqK3p55Z8crmV/MA+ANytuQJr6YvM2fyTV0s
         81hpXj5KLgrF6XSLhd7dg0WzKI3dM7CZD10wg4BgcrL75Nbu56MfVbgeErIXe5EKOuc1
         WAbpYMzHKDVbjnNq+AaigzUhrCpwBvgie/nCh16KXYf1lZe0X5neQqUm6dOJEt/h9XMh
         BoiORdnH9bVABDJYv5ebbJCtenu/dQPUvYS26lcBzKkuBxDpd4JIGOwPnQeVXyd8VTQm
         nYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742195216; x=1742800016;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LlhDYNxQXaljro5xNb8yMyAUj7KHJvqFuDdC/trm+HE=;
        b=EMJpc6tUzQBNJZeh0e7Jqv/j7MhDpq83PIE5REeYZaYS/Wx6vxK8jpnxnxllhd3/qJ
         FFdi/xCOR//nNjJwj68tWnVP7t1YUnJCasIcl7bwx2t2j0QVtx/JbYxpj1AWfdH2f7OZ
         GVwODaLQT4ToesUsLl09bCpjlkdm5XAtdhWs0oxlzUxvTDo7y8y8x25nupZNqfmVcDWd
         xS90qGbPETdPX7BCVfBTEhicGUtw5pSq9I/AoJopKyRFgpSZYPCk2ONuzSzNXxpyc9N1
         a5A2eXnuVoPP5eQ0cxlCI1+VkiKuypAdnhPf6Nbhy0wLwVwgeADFlLg1BxGL6bS/ngU6
         KLyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7HeX6wg9CWvc95x9k5XFYXIij7cbUzNQLRvzwxDFNP755nka+wRIzlkvA7NgSnOpDm95RhvlZVt02AXeAOxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL2TU60zC3p5ARHArP6bXjhfkL/vsYy+M122kN0SMzx1h3G5IC
	E7C+ds0RD/UzDIIdM6CAApgV7xSHPyitfgxnMgbOH2b61CFG0DIFVlrJ196RtUE=
X-Gm-Gg: ASbGnctg8oqDOONz/88SI11McoG++hhMXWx4ZD4tZNlPJnwSD5xypjr0YDlzGAjzonK
	2sV4KR1d7bFhldYuMA/pXQ/KcHhiI/YPtjBexbphQ/vzVlJ1LhaDvaeJjOKp8IpeCyM+Ih++CbE
	Vggxjgat+FqWXwDT6K+rayU51MrKpbhFJrCNF4eSe+pUqtU+WkBGtp5E55p3U91LgYKw3angbLf
	kbHW+okJeMfCVxdBkQiTbvhNjPmadIknXik9K70EdQ2VmOHdW2xz2rQZrVFvDBNQslik7U5HCek
	xYpUoIauKyOpHXXrkGaUjThbtnx2niDS0dVgvSiY1e+iTp1R6PgQ+rh12A==
X-Google-Smtp-Source: AGHT+IHS6jihoL37OgI78P9zoqUhv0y/gBN3c29U4siSAX49VPXXMvTt2Or4ivkgi37sHpeBgS4rqQ==
X-Received: by 2002:a17:90a:fd11:b0:2ff:702f:7172 with SMTP id 98e67ed59e1d1-30151d8174emr14785882a91.33.1742195216242;
        Mon, 17 Mar 2025 00:06:56 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153bc301esm5273746a91.49.2025.03.17.00.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 00:06:55 -0700 (PDT)
Message-ID: <73250942-9ab9-4ee4-9bbe-e0a155a61f51@daynix.com>
Date: Mon, 17 Mar 2025 16:06:50 +0900
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
 <ff7916cf-8a9c-4c27-baaf-ca408817c063@daynix.com>
 <CACGkMEsVgbJPhz2d2ATm5fr3M2uSEoSXWW7tXZ_FrkQtmmu1wA@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEsVgbJPhz2d2ATm5fr3M2uSEoSXWW7tXZ_FrkQtmmu1wA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/03/17 10:12, Jason Wang wrote:
> On Wed, Mar 12, 2025 at 1:03 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/03/12 11:35, Jason Wang wrote:
>>> On Tue, Mar 11, 2025 at 2:11 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2025/03/11 9:38, Jason Wang wrote:
>>>>> On Mon, Mar 10, 2025 at 3:45 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> On 2025/03/10 12:55, Jason Wang wrote:
>>>>>>> On Fri, Mar 7, 2025 at 7:01 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>
>>>>>>>> Hash reporting
>>>>>>>> ==============
>>>>>>>>
>>>>>>>> Allow the guest to reuse the hash value to make receive steering
>>>>>>>> consistent between the host and guest, and to save hash computation.
>>>>>>>>
>>>>>>>> RSS
>>>>>>>> ===
>>>>>>>>
>>>>>>>> RSS is a receive steering algorithm that can be negotiated to use with
>>>>>>>> virtio_net. Conventionally the hash calculation was done by the VMM.
>>>>>>>> However, computing the hash after the queue was chosen defeats the
>>>>>>>> purpose of RSS.
>>>>>>>>
>>>>>>>> Another approach is to use eBPF steering program. This approach has
>>>>>>>> another downside: it cannot report the calculated hash due to the
>>>>>>>> restrictive nature of eBPF steering program.
>>>>>>>>
>>>>>>>> Introduce the code to perform RSS to the kernel in order to overcome
>>>>>>>> thse challenges. An alternative solution is to extend the eBPF steering
>>>>>>>> program so that it will be able to report to the userspace, but I didn't
>>>>>>>> opt for it because extending the current mechanism of eBPF steering
>>>>>>>> program as is because it relies on legacy context rewriting, and
>>>>>>>> introducing kfunc-based eBPF will result in non-UAPI dependency while
>>>>>>>> the other relevant virtualization APIs such as KVM and vhost_net are
>>>>>>>> UAPIs.
>>>>>>>>
>>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>>> Tested-by: Lei Yang <leiyang@redhat.com>
>>>>>>>> ---
>>>>>>>>      Documentation/networking/tuntap.rst |   7 ++
>>>>>>>>      drivers/net/Kconfig                 |   1 +
>>>>>>>>      drivers/net/tap.c                   |  68 ++++++++++++++-
>>>>>>>>      drivers/net/tun.c                   |  98 +++++++++++++++++-----
>>>>>>>>      drivers/net/tun_vnet.h              | 159 ++++++++++++++++++++++++++++++++++--
>>>>>>>>      include/linux/if_tap.h              |   2 +
>>>>>>>>      include/linux/skbuff.h              |   3 +
>>>>>>>>      include/uapi/linux/if_tun.h         |  75 +++++++++++++++++
>>>>>>>>      net/core/skbuff.c                   |   4 +
>>>>>>>>      9 files changed, 386 insertions(+), 31 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/Documentation/networking/tuntap.rst b/Documentation/networking/tuntap.rst
>>>>>>>> index 4d7087f727be5e37dfbf5066a9e9c872cc98898d..86b4ae8caa8ad062c1e558920be42ce0d4217465 100644
>>>>>>>> --- a/Documentation/networking/tuntap.rst
>>>>>>>> +++ b/Documentation/networking/tuntap.rst
>>>>>>>> @@ -206,6 +206,13 @@ enable is true we enable it, otherwise we disable it::
>>>>>>>>            return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
>>>>>>>>        }
>>>>>>>>
>>>
>>> [...]
>>>
>>>>>>>> +static inline long tun_vnet_ioctl_sethash(struct tun_vnet_hash_container __rcu **hashp,
>>>>>>>> +                                         bool can_rss, void __user *argp)
>>>>>>>
>>>>>>> So again, can_rss seems to be tricky. Looking at its caller, it tires
>>>>>>> to make eBPF and RSS mutually exclusive. I still don't understand why
>>>>>>> we need this. Allow eBPF program to override some of the path seems to
>>>>>>> be common practice.
>>>>>>>
>>>>>>> What's more, we didn't try (or even can't) to make automq and eBPF to
>>>>>>> be mutually exclusive. So I still didn't see what we gain from this
>>>>>>> and it complicates the codes and may lead to ambiguous uAPI/behaviour.
>>>>>>
>>>>>> automq and eBPF are mutually exclusive; automq is disabled when an eBPF
>>>>>> steering program is set so I followed the example here.
>>>>>
>>>>> I meant from the view of uAPI, the kernel doesn't or can't reject eBPF
>>>>> while using automq.
>>>>    > >>
>>>>>> We don't even have an interface for eBPF to let it fall back to another
>>>>>> alogirhtm.
>>>>>
>>>>> It doesn't even need this, e.g XDP overrides the default receiving path.
>>>>>
>>>>>> I could make it fall back to RSS if the eBPF steeering
>>>>>> program is designed to fall back to automq when it returns e.g., -1. But
>>>>>> such an interface is currently not defined and defining one is out of
>>>>>> scope of this patch series.
>>>>>
>>>>> Just to make sure we are on the same page, I meant we just need to
>>>>> make the behaviour consistent: allow eBPF to override the behaviour of
>>>>> both automq and rss.
>>>>
>>>> That assumes eBPF takes precedence over RSS, which is not obvious to me.
>>>
>>> Well, it's kind of obvious. Not speaking the eBPF selector, we have
>>> other eBPF stuffs like skbedit etc.
>>>
>>>>
>>>> Let's add an interface for the eBPF steering program to fall back to
>>>> another steering algorithm. I said it is out of scope before, but it
>>>> makes clear that the eBPF steering program takes precedence over other
>>>> algorithms and allows us to delete the code for the configuration
>>>> validation in this patch.
>>>
>>> Fallback is out of scope but it's not what I meant.
>>>
>>> I meant in the current uAPI take eBPF precedence over automq. It's
>>> much more simpler to stick this precedence unless we see obvious
>>> advanatge.
>>
>> We still have three different design options that preserve the current
>> precedence:
>>
>> 1) Precedence order: eBPF -> RSS -> automq
>> 2) Precedence order: RSS -> eBPF -> automq
>> 3) Precedence order: eBPF OR RSS -> automq where eBPF and RSS are
>> mutually exclusive
>>
>> I think this is a unique situation for this steering program and I could
>> not find another example in other eBPF stuffs.
> 
> As described above, queue mapping could be overridden by tc-ebpf. So
> there's no way to guarantee the RSS will work:
> 
> https://github.com/DPDK/dpdk/blob/main/drivers/net/tap/bpf/tap_rss.c#L262
> 
> Making eBPF first leaves a chance for the management layer to override
> the choice of Qemu.

I referred to the eBPF steering program instead of tc-ebpf. tc-ebpf is 
nothing to do with the TUNSETSTEERINGEBPF ioctl, which this patch changes.

> 
>>
>> The current version implements 3) because it is not obvious whether we
>> should choose either 1) or 2).
> 
> But you didn't explain why you choose 3), and it leads to tricky code
> (e.g the can_rss stuff etc).

I wrote: "because it is not obvious whether we should choose either 1) 
or 2)", but I think I can explain it better:

When an eBPF steering program cannot implement a fallback, it means the 
eBPF steering program requests the full control over the steering. On 
the other hand, RSS also requests the same control. So these two will 
conflict and the entity controlling the steering will be undefined when 
both are enabled.

3) eliminates the undefined semantics by rejecting to enable both. An 
alternative approach is to allow eBPF steering programs to fall back. 
When both the eBPF program and RSS are enabled, RSS will gain the 
control of steering under the well-defined situation where the eBPF 
steering program decides to fall back.

> 
>> But 1) will be the most capable option if
>> eBPF has a fall-back feature.
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>
>>> [...]
>>>
>>>>>>> Is there a chance that we can reach here without TUN_VNET_HASH_REPORT?
>>>>>>> If yes, it should be a bug.
>>>>>>
>>>>>> It is possible to use RSS without TUN_VNET_HASH_REPORT.
>>>>>
>>>>> Another call to separate the ioctls then.
>>>>
>>>> RSS and hash reporting are not completely independent though.
>>>
>>> Spec said:
>>>
>>> """
>>> VIRTIO_NET_F_RSSRequires VIRTIO_NET_F_CTRL_VQ.
>>> """
>>
>> I meant the features can be enabled independently, but they will share
>> the hash type set when they are enabled at the same time.
> 
> Looking at the spec:
> 
> Hash repot uses:
> 
> """
> struct virtio_net_hash_config {
>      le32 hash_types;
>      le16 reserved[4];
>      u8 hash_key_length;
>      u8 hash_key_data[hash_key_length];
> };
> """
> 
> RSS uses
> 
> """
> struct rss_rq_id {
>     le16 vq_index_1_16: 15; /* Bits 1 to 16 of the virtqueue index */
>     le16 reserved: 1; /* Set to zero */
> };
> 
> struct virtio_net_rss_config {
>      le32 hash_types;
>      le16 indirection_table_mask;
>      struct rss_rq_id unclassified_queue;
>      struct rss_rq_id indirection_table[indirection_table_length];
>      le16 max_tx_vq;
>      u8 hash_key_length;
>      u8 hash_key_data[hash_key_length];
> };
> """
> 
> Instead of trying to figure out whether we can share some data
> structures, why not simply start from what has been done in the spec?
> This would ease the usersapce as well where it can simply do 1:1
> mapping between ctrl vq command and tun uAPI.

The spec also defines struct virtio_net_hash_config (which will be used 
when RSS is disabled) and struct virtio_net_rss_config to match the 
layout to share some fields. However, the UAPI does not follow the 
interface design of virtio due to some problems with these structures.

Below is the definition of struct virtio_net_hash_config:

struct virtio_net_hash_config {
     le32 hash_types;
     le16 reserved[4];
     u8 hash_key_length;
     u8 hash_key_data[hash_key_length];
};

Here, hash_types, hash_key_length, and hash_key_data are shared with 
struct virtio_net_rss_config.

One problem is that struct virtio_net_rss_config has a flexible array 
(indirection_table) between hash_types and hash_key_length. This is 
something we cannot express with C.

Another problem is that the semantics of the key in struct 
virtio_net_hash_config is not defined in the spec.

To solve these problems, I defined the UAPI structures that do not 
include indiretion_table.

> 
>>
>>>
>>>>
>>>> A plot twist is the "types" parameter; it is a parameter that is
>>>> "common" for RSS and hash reporting.
>>>
>>> So we can share part of the structure through the uAPI.
>>
>> Isn't that what this patch does?
> 
> I didn't see, basically I see only one TUNSETVNETHASH that is used to
> set both hash report and rss:

The UAPI shares struct tun_vnet_hash for both hash report and rss.

> 
> """
> +/**
> + * define TUNSETVNETHASH - ioctl to configure virtio_net hashing
> + *
> + * The argument is a pointer to &struct tun_vnet_hash.
> + *
> + * The argument is a pointer to the compound of the following in order if
> + * %TUN_VNET_HASH_RSS is set:
> + *
> + * 1. &struct tun_vnet_hash
> + * 2. &struct tun_vnet_hash_rss
> + * 3. Indirection table
> + * 4. Key
> + *
> """
> 
> And it seems to lack parameters like max_tx_vq.

max_tx_vq is not relevant with hashing.

> 
> What's more, we've already had virito-net uAPI. Why not simply reusing them?

See the above.

> 
>>
>>>
>>>> RSS and hash reporting must share
>>>> this parameter when both are enabled at the same time; otherwise RSS may
>>>> compute hash values that are not suited for hash reporting.
>>>
>>> Is this mandated by the spec? If yes, we can add a check. If not,
>>> userspace risk themselves as a mis-configuration which we don't need
>>> to bother.
>>
>> Yes, it is mandated. 5.1.6.4.3 Hash calculation for incoming packets says:
>>   > A device attempts to calculate a per-packet hash in the following
>>   > cases:
>>   >
>>   >   - The feature VIRTIO_NET_F_RSS was negotiated. The device uses the
>>   >     hash to determine the receive virtqueue to place incoming packets.
>>   >   - The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The device
>>   >     reports the hash value and the hash type with the packet.
>>   >
>>   > If the feature VIRTIO_NET_F_RSS was negotiated:
>>   >
>>   >   - The device uses hash_types of the virtio_net_rss_config structure
>>   >     as ’Enabled hash types’ bitmask.
>>   >   - The device uses a key as defined in hash_key_data and
>>         hash_key_length of the virtio_net_rss_config structure (see
>>   >      5.1.6.5.7.1).
>>   >
>>   > If the feature VIRTIO_NET_F_RSS was not negotiated:
>>   >
>>   >   - The device uses hash_types of the virtio_net_hash_config structure
>>   >     as ’Enabled hash types’ bitmask.
>>   >   - The device uses a key as defined in hash_key_data and
>>   >     hash_key_length of the virtio_net_hash_config structure (see
>>   >      .1.6.5.6.4).
>>
>> So when both VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT are
>> negotiated, virtio_net_rss_config not only controls RSS but also the
>> reported hash values and types. They cannot be divergent.
>>
>>>
>>> Note that spec use different commands for hash_report and rss.
>>
>> TUNSETVNETHASH is different from these commands in terms that it also
>> negotiates VIRTIO_NET_F_HASH_REPORT and VIRTIO_NET_F_RSS.
>>
> 
> There Are different "issues" here:
> 
> 1) Whether or not we need to use a unified API for negotiating RSS and
> HASH_REPORT features
> 2) Whether or not we need to sue a unified API for setting RSS and
> HASH_REPORT configuration
> 
> What I want to say is point 2. But what you raise is point 1.
> 
> For simplicity, it looks to me like it's a call for having separated
> ioctls for feature negotiation (for example via TUNSETIFF). You may
> argue that either RSS or HASH_REPORT requires configurations, we can
> just follow what spec defines or not (e.g what happens if
> RSS/HASH_REPORT were negotiated but no configurations were set).

Unfortunately TUNSETIFF does not fit in this use case. The flags set 
with TUNSETIFF are fixed, but the guest can request a different feature 
set anytime by resetting the device.

 > >> In the virtio-net specification, it is not defined what would 
happen if
>> these features are negotiated but the VIRTIO_NET_CTRL_MQ_RSS_CONFIG or
>> VIRTIO_NET_CTRL_MQ_HASH_CONFIG commands are not sent. There is no such
>> ambiguity with TUNSETVNETHASH.
> 
> So I don't see advantages of unifying hash reports and rss into a
> single ioctl. Let's just follow what has been done in the spec that
> uses separated commands. Tuntap is not a good place to debate whether
> those commands could be unified or not. We need to move it to the spec
> but assuming spec has been done, it might be too late or too few
> advantages for having another design.

It makes sense for the spec to reuse the generic feature negotiation 
mechanism, but the situation is different for tuntap; we cannot use 
TUNSETIFF and need to define another. Then why don't we exploit this 
opportunity to have an interface with well-defined semantics? The virtio 
spec does its best as an interface between the host and guest and tuntap 
does its best as an UAPI.

I don't think there is an advantage to split ioctls to follow the spec 
after all. It makes sense if we can pass-through virtio commands to 
tuntap, but it is not possible as ioctl operation codes are different 
from virtio commands. The best possibility is to share structures, not 
commands, and I don't think even sharing structures makes sense here 
because of the reasons described above.

Regards,
Akihiko Odaki

> 
> Thanks
> 
>>
>> Regards,
>> Akihiko Odaki
>>
>>>
>>>>
>>>> The paramter will be duplicated if we have separate ioctls for RSS and
>>>> hash reporting, and the kernel will have a chiken-egg problem when
>>>> ensuring they are synchronized; when the ioctl for RSS is issued, should
>>>> the kernel ensure the "types" parameter is identical with one specified
>>>> for hash reporting? It will not work if the userspace may decide to
>>>> configure hash reporting after RSS.
>>>>
>>>
>>> See my reply above.
>>>
>>> Thanks
>>>
>>
> 


