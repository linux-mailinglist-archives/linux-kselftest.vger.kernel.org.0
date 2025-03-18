Return-Path: <linux-kselftest+bounces-29342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA23A670CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 11:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1E8420204
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 10:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D885F207E1B;
	Tue, 18 Mar 2025 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="CDO2TqiA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA86220767E
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 10:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742292650; cv=none; b=Fz4JLtDFpmZBkSLeWNN7jRsS5ka4IIe3hMFIX93lvGiMzC851z+oMz81vbumDEOrkgk+g+Di72qEpBdzRw773o/zELdx8po4MmO2Pax4pRjtPnFxiF72r6bv5J4NP542zp35GcLhm2WG7oB584637jo/iEuFqIv0LRj4N1Ulvdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742292650; c=relaxed/simple;
	bh=zsUt/6+/NiELd/evscDDzEUV/Qq10W6BjTIDnq51oUE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VheOs7AQWdKkr7h2gzGQSTPjB4I9VJUk76K90iun5CWfcEYpfXXHbG0uKlraEcPhvxjw32YeoUnAw2QrYqKbU09z2obDYpaWHjcyt3c4ryi79N2rXZsRX61mUqzGQQf05X22i4TVnsl35UI6zidCgUt2fEvjkBs80E9j9+9yj5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=CDO2TqiA; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22403cbb47fso98674145ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 03:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742292644; x=1742897444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JgaT3gSKYbUiCtfNlnX3gts56lywAE1JWXDcJCOHB9U=;
        b=CDO2TqiAOf467NOz1aitqimdk3kawR6ymLNnZ0TBRHz9B86gLPmvLna0LcRezA2b2o
         UT2x1efzIkFyegvvhajRqp0jLk34auq+XHrbOSeuxpcGohzoVGBZM5rBwyCXR3mQHgmY
         hZ07aRTv932GzSIQNMTd2gmVjDHX19sSkJ7eh5y+70lfUZ1+Dpi6WVTVu8LDwO7Bp1li
         AzlI7IX66nJntAJohLk+dqZXYCxLjJn4AZ15sOVsTKGEb45HhpjRemfCYrguCUJMoXNx
         QwOITTdXcXLp6Nwtv/OWuEUpAmy24C75dJd0IlMp8AXc5czEn4YeS5skRGNBYzTNzVa7
         TpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742292644; x=1742897444;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JgaT3gSKYbUiCtfNlnX3gts56lywAE1JWXDcJCOHB9U=;
        b=hvNW6lUDxhDKSbI6iCtO5NVtyJVcda3hq4ssMRcDrKOmxHgWEhubwRhqs8M7Ou6F5i
         OznxYXHAKrCKwFdsyfVWnFuP3b8jfMFuplp+6ajO3D2I1a6eRTvcBw69EvVfi4ltUJV6
         +oCTrZnVIixjkwlmIRdVVpRAeO6BZKuxk5a2xCHh9mUh18jcBAzT1jZqXH2cMTcyzFF6
         i8KvLGD/Xs0T6CbyKTXa4/CS6mNY9IfVcIRPywVwfYT0tvkP/5miY94Soee5J0F0stpV
         VHlwIa2lTBner2VbcaqxROaph56MmGNNljMSk5Yexvd0VxtepzCpDWZ9QmXNiBiUcQk8
         h8RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfR4GLPo8WxC61TC/6mVkumKmm7BnaxUAINN4Jlc5SbtasSR4pr9BdlstaeKV9NFa6bFA6eE0LQ4Bw3KCG+5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgHx+mXSQOcqqm3jXPBUM8DySmxnRgOe+Xn+EsTOgfhna75ufd
	8dxtbzCCnCDYvnvfCohyo8VWaoPRLGBgSDxHj8NGmXwcSLYC9GmJ8LCEjybuMc4=
X-Gm-Gg: ASbGncus1Pu27gjdKyWlEiqGmMOEj/sqBvcv2pHr7rFhbW4JWUpFH81/nmw/9meuF1e
	vU0AhSjizo33ZFfCmeNiLH/4HvW5uopu5+adJsX9nfrs0v4cJm8E+NDib8F4eANGn7cGSY1rXeq
	2wiKI5d5n1BATq3kWzWomAYoAKBMEhLYVAoLdp/RkXTMXUyhyosXVLg3SEeGjcxHtijagkLHaFh
	ocxC+LKXIXpAkNmBXl5kZmar0LpDPA4p5h25krBMrpCTP+h2OWyuxEdnh3iR1IVgTXE55nd3EPV
	BooWySnaXbcvfe9PBQB905cd67+E57Yv+x7OFYGQdjQulLLAPuGaYaKbaVhP0kIPoxoB
X-Google-Smtp-Source: AGHT+IEtvnXs2si+CcC1N0JCC4xDOL5gPL4FfihuQG9T37TTuqyv08T55P5FWaAXRq4isGFqb4dENA==
X-Received: by 2002:a17:902:d48e:b0:223:3bf6:7e64 with SMTP id d9443c01a7336-225e0a8f4b2mr207918415ad.24.1742292643674;
        Tue, 18 Mar 2025 03:10:43 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711550fe1sm9431942b3a.53.2025.03.18.03.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 03:10:43 -0700 (PDT)
Message-ID: <1f06b4b6-267a-4091-a3ba-e7b9dafae918@daynix.com>
Date: Tue, 18 Mar 2025 19:10:38 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akihiko Odaki <akihiko.odaki@daynix.com>
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
 <73250942-9ab9-4ee4-9bbe-e0a155a61f51@daynix.com>
 <CACGkMEud0Ki8p=z299Q7b4qEDONpYDzbVqhHxCNVk_vo-KdP9A@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CACGkMEud0Ki8p=z299Q7b4qEDONpYDzbVqhHxCNVk_vo-KdP9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/03/18 9:15, Jason Wang wrote:
> On Mon, Mar 17, 2025 at 3:07 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/03/17 10:12, Jason Wang wrote:
>>> On Wed, Mar 12, 2025 at 1:03 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2025/03/12 11:35, Jason Wang wrote:
>>>>> On Tue, Mar 11, 2025 at 2:11 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> On 2025/03/11 9:38, Jason Wang wrote:
>>>>>>> On Mon, Mar 10, 2025 at 3:45 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>
>>>>>>>> On 2025/03/10 12:55, Jason Wang wrote:
>>>>>>>>> On Fri, Mar 7, 2025 at 7:01 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>>>
>>>>>>>>>> Hash reporting
>>>>>>>>>> ==============
>>>>>>>>>>
>>>>>>>>>> Allow the guest to reuse the hash value to make receive steering
>>>>>>>>>> consistent between the host and guest, and to save hash computation.
>>>>>>>>>>
>>>>>>>>>> RSS
>>>>>>>>>> ===
>>>>>>>>>>
>>>>>>>>>> RSS is a receive steering algorithm that can be negotiated to use with
>>>>>>>>>> virtio_net. Conventionally the hash calculation was done by the VMM.
>>>>>>>>>> However, computing the hash after the queue was chosen defeats the
>>>>>>>>>> purpose of RSS.
>>>>>>>>>>
>>>>>>>>>> Another approach is to use eBPF steering program. This approach has
>>>>>>>>>> another downside: it cannot report the calculated hash due to the
>>>>>>>>>> restrictive nature of eBPF steering program.
>>>>>>>>>>
>>>>>>>>>> Introduce the code to perform RSS to the kernel in order to overcome
>>>>>>>>>> thse challenges. An alternative solution is to extend the eBPF steering
>>>>>>>>>> program so that it will be able to report to the userspace, but I didn't
>>>>>>>>>> opt for it because extending the current mechanism of eBPF steering
>>>>>>>>>> program as is because it relies on legacy context rewriting, and
>>>>>>>>>> introducing kfunc-based eBPF will result in non-UAPI dependency while
>>>>>>>>>> the other relevant virtualization APIs such as KVM and vhost_net are
>>>>>>>>>> UAPIs.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>>>>> Tested-by: Lei Yang <leiyang@redhat.com>
>>>>>>>>>> ---
>>>>>>>>>>       Documentation/networking/tuntap.rst |   7 ++
>>>>>>>>>>       drivers/net/Kconfig                 |   1 +
>>>>>>>>>>       drivers/net/tap.c                   |  68 ++++++++++++++-
>>>>>>>>>>       drivers/net/tun.c                   |  98 +++++++++++++++++-----
>>>>>>>>>>       drivers/net/tun_vnet.h              | 159 ++++++++++++++++++++++++++++++++++--
>>>>>>>>>>       include/linux/if_tap.h              |   2 +
>>>>>>>>>>       include/linux/skbuff.h              |   3 +
>>>>>>>>>>       include/uapi/linux/if_tun.h         |  75 +++++++++++++++++
>>>>>>>>>>       net/core/skbuff.c                   |   4 +
>>>>>>>>>>       9 files changed, 386 insertions(+), 31 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/Documentation/networking/tuntap.rst b/Documentation/networking/tuntap.rst
>>>>>>>>>> index 4d7087f727be5e37dfbf5066a9e9c872cc98898d..86b4ae8caa8ad062c1e558920be42ce0d4217465 100644
>>>>>>>>>> --- a/Documentation/networking/tuntap.rst
>>>>>>>>>> +++ b/Documentation/networking/tuntap.rst
>>>>>>>>>> @@ -206,6 +206,13 @@ enable is true we enable it, otherwise we disable it::
>>>>>>>>>>             return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
>>>>>>>>>>         }
>>>>>>>>>>
>>>>>
>>>>> [...]
>>>>>
>>>>>>>>>> +static inline long tun_vnet_ioctl_sethash(struct tun_vnet_hash_container __rcu **hashp,
>>>>>>>>>> +                                         bool can_rss, void __user *argp)
>>>>>>>>>
>>>>>>>>> So again, can_rss seems to be tricky. Looking at its caller, it tires
>>>>>>>>> to make eBPF and RSS mutually exclusive. I still don't understand why
>>>>>>>>> we need this. Allow eBPF program to override some of the path seems to
>>>>>>>>> be common practice.
>>>>>>>>>
>>>>>>>>> What's more, we didn't try (or even can't) to make automq and eBPF to
>>>>>>>>> be mutually exclusive. So I still didn't see what we gain from this
>>>>>>>>> and it complicates the codes and may lead to ambiguous uAPI/behaviour.
>>>>>>>>
>>>>>>>> automq and eBPF are mutually exclusive; automq is disabled when an eBPF
>>>>>>>> steering program is set so I followed the example here.
>>>>>>>
>>>>>>> I meant from the view of uAPI, the kernel doesn't or can't reject eBPF
>>>>>>> while using automq.
>>>>>>     > >>
>>>>>>>> We don't even have an interface for eBPF to let it fall back to another
>>>>>>>> alogirhtm.
>>>>>>>
>>>>>>> It doesn't even need this, e.g XDP overrides the default receiving path.
>>>>>>>
>>>>>>>> I could make it fall back to RSS if the eBPF steeering
>>>>>>>> program is designed to fall back to automq when it returns e.g., -1. But
>>>>>>>> such an interface is currently not defined and defining one is out of
>>>>>>>> scope of this patch series.
>>>>>>>
>>>>>>> Just to make sure we are on the same page, I meant we just need to
>>>>>>> make the behaviour consistent: allow eBPF to override the behaviour of
>>>>>>> both automq and rss.
>>>>>>
>>>>>> That assumes eBPF takes precedence over RSS, which is not obvious to me.
>>>>>
>>>>> Well, it's kind of obvious. Not speaking the eBPF selector, we have
>>>>> other eBPF stuffs like skbedit etc.
>>>>>
>>>>>>
>>>>>> Let's add an interface for the eBPF steering program to fall back to
>>>>>> another steering algorithm. I said it is out of scope before, but it
>>>>>> makes clear that the eBPF steering program takes precedence over other
>>>>>> algorithms and allows us to delete the code for the configuration
>>>>>> validation in this patch.
>>>>>
>>>>> Fallback is out of scope but it's not what I meant.
>>>>>
>>>>> I meant in the current uAPI take eBPF precedence over automq. It's
>>>>> much more simpler to stick this precedence unless we see obvious
>>>>> advanatge.
>>>>
>>>> We still have three different design options that preserve the current
>>>> precedence:
>>>>
>>>> 1) Precedence order: eBPF -> RSS -> automq
>>>> 2) Precedence order: RSS -> eBPF -> automq
>>>> 3) Precedence order: eBPF OR RSS -> automq where eBPF and RSS are
>>>> mutually exclusive
>>>>
>>>> I think this is a unique situation for this steering program and I could
>>>> not find another example in other eBPF stuffs.
>>>
>>> As described above, queue mapping could be overridden by tc-ebpf. So
>>> there's no way to guarantee the RSS will work:
>>>
>>> https://github.com/DPDK/dpdk/blob/main/drivers/net/tap/bpf/tap_rss.c#L262
>>>
>>> Making eBPF first leaves a chance for the management layer to override
>>> the choice of Qemu.
>>
>> I referred to the eBPF steering program instead of tc-ebpf. tc-ebpf is
>> nothing to do with the TUNSETSTEERINGEBPF ioctl, which this patch changes.
> 
> I meant you can't do "full control" in any case, the point below
> doesn't stand. Queue mapping could be restored even if RSS is set.

What matters here is how we handle the control when tc didn't take it.
eBPF, RSS, or automq make take all of it; I referred that as "full control".

> 
>>
>>>
>>>>
>>>> The current version implements 3) because it is not obvious whether we
>>>> should choose either 1) or 2).
>>>
>>> But you didn't explain why you choose 3), and it leads to tricky code
>>> (e.g the can_rss stuff etc).
>>
>> I wrote: "because it is not obvious whether we should choose either 1)
>> or 2)", but I think I can explain it better:
>>
>> When an eBPF steering program cannot implement a fallback, it means the
>> eBPF steering program requests the full control over the steering. On
>> the other hand, RSS also requests the same control. So these two will
>> conflict and the entity controlling the steering will be undefined when
>> both are enabled.
> 
> Well, the fallback is orthogonal to the proposal here. We haven't had
> that since the introduction of the eBPF steering program. This means
> automq has been in "conflict" with eBPF for years. Again, another
> advantage, allowing the eBPF program to be the first to allow the
> management layer to override Qemu's steering.

What if a VMM uses eBPF steering program and the management layer 
decides to override it with RSS?

eBPF is obviously predecedent to automq as eBPF is an opt-in feature and 
automq is the implicit default. But this logic cannot be applied to 
decide the order of eBPF and RSS because they are both opt-in features.

> 
>>
>> 3) eliminates the undefined semantics by rejecting to enable both.
> 
> This would lead a usersapce noticeable change of the behaviour? And
> what do you mean by "rejecting to enable both"?

Existing userspace code should see no change as it only cares the case 
where RSS is enabled.

Here, rejecting to enable both means to deny setting an eBPF steering 
program when RSS is enabled, and visa-versa.

> 
>> An
>> alternative approach is to allow eBPF steering programs to fall back.
>> When both the eBPF program and RSS are enabled, RSS will gain the
>> control of steering under the well-defined situation where the eBPF
>> steering program decides to fall back.
> 
> How about just stick the eBPF precedence in this proposal and
> introduce the fallback on top? This helps to speed up the iteration
> (as the version has been iterated to 11).

I don't think that helps much since we have another ongoing discussion 
below and it is not the sole roadblock.

> 
>>
>>>
>>>> But 1) will be the most capable option if
>>>> eBPF has a fall-back feature.
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>
>>>>> [...]
>>>>>
>>>>>>>>> Is there a chance that we can reach here without TUN_VNET_HASH_REPORT?
>>>>>>>>> If yes, it should be a bug.
>>>>>>>>
>>>>>>>> It is possible to use RSS without TUN_VNET_HASH_REPORT.
>>>>>>>
>>>>>>> Another call to separate the ioctls then.
>>>>>>
>>>>>> RSS and hash reporting are not completely independent though.
>>>>>
>>>>> Spec said:
>>>>>
>>>>> """
>>>>> VIRTIO_NET_F_RSSRequires VIRTIO_NET_F_CTRL_VQ.
>>>>> """
>>>>
>>>> I meant the features can be enabled independently, but they will share
>>>> the hash type set when they are enabled at the same time.
>>>
>>> Looking at the spec:
>>>
>>> Hash repot uses:
>>>
>>> """
>>> struct virtio_net_hash_config {
>>>       le32 hash_types;
>>>       le16 reserved[4];
>>>       u8 hash_key_length;
>>>       u8 hash_key_data[hash_key_length];
>>> };
>>> """
>>>
>>> RSS uses
>>>
>>> """
>>> struct rss_rq_id {
>>>      le16 vq_index_1_16: 15; /* Bits 1 to 16 of the virtqueue index */
>>>      le16 reserved: 1; /* Set to zero */
>>> };
>>>
>>> struct virtio_net_rss_config {
>>>       le32 hash_types;
>>>       le16 indirection_table_mask;
>>>       struct rss_rq_id unclassified_queue;
>>>       struct rss_rq_id indirection_table[indirection_table_length];
>>>       le16 max_tx_vq;
>>>       u8 hash_key_length;
>>>       u8 hash_key_data[hash_key_length];
>>> };
>>> """
>>>
>>> Instead of trying to figure out whether we can share some data
>>> structures, why not simply start from what has been done in the spec?
>>> This would ease the usersapce as well where it can simply do 1:1
>>> mapping between ctrl vq command and tun uAPI.
>>
>> The spec also defines struct virtio_net_hash_config (which will be used
>> when RSS is disabled) and struct virtio_net_rss_config to match the
>> layout to share some fields. However, the UAPI does not follow the
>> interface design of virtio due to some problems with these structures.
> 
> Copy-paste error. The above is copied from the virtio spec, but I
> meant the existing uAPI in virtio_net.h:
> 
> /*
>   * The command VIRTIO_NET_CTRL_MQ_RSS_CONFIG has the same effect as
>   * VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET does and additionally configures
>   * the receive steering to use a hash calculated for incoming packet
>   * to decide on receive virtqueue to place the packet. The command
>   * also provides parameters to calculate a hash and receive virtqueue.
>   */
> struct virtio_net_rss_config {
>          __le32 hash_types;
>          __le16 indirection_table_mask;
>          __le16 unclassified_queue;
>          __le16 indirection_table[1/* + indirection_table_mask */];
>          __le16 max_tx_vq;
>          __u8 hash_key_length;
>          __u8 hash_key_data[/* hash_key_length */];
> };
> >   #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
> 
> /*
>   * The command VIRTIO_NET_CTRL_MQ_HASH_CONFIG requests the device
>   * to include in the virtio header of the packet the value of the
>   * calculated hash and the report type of hash. It also provides
>   * parameters for hash calculation. The command requires feature
>   * VIRTIO_NET_F_HASH_REPORT to be negotiated to extend the
>   * layout of virtio header as defined in virtio_net_hdr_v1_hash.
>   */
> struct virtio_net_hash_config {
>          __le32 hash_types;
>          /* for compatibility with virtio_net_rss_config */
>          __le16 reserved[4];
>          __u8 hash_key_length;
>          __u8 hash_key_data[/* hash_key_length */];
> };
> 
> This has been used by Qemu but I see a virtio-net version of:
> 
> struct virtio_net_ctrl_rss {
>          u32 hash_types;
>          u16 indirection_table_mask;
>          u16 unclassified_queue;
>          u16 hash_cfg_reserved; /* for HASH_CONFIG (see
> virtio_net_hash_config for details) */
>          u16 max_tx_vq;
>          u8 hash_key_length;
>          u8 key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> 
>          u16 *indirection_table;
> };
> 
> This is ugly and results in a tricky code when trying to submit
> RSS/HASH commands to the device:
> 
>          if (vi->has_rss) {
>                  sg_buf_size = sizeof(uint16_t) * vi->rss_indir_table_size;
>                  sg_set_buf(&sgs[1], vi->rss.indirection_table, sg_buf_size);
>          } else {
>                  sg_set_buf(&sgs[1], &vi->rss.hash_cfg_reserved,
> sizeof(uint16_t));
>          }

The only reference to struct virtio_net_rss_config in QEMU is to derive 
the offset of indirection_table. This is because the definition in 
virtio_net.h also includes indirection_table in the middle and the 
offsets of later part are unusable.

QEMU internally has a structure named VirtioNetRssData which just looks 
like struct virtio_net_ctrl_rss.

> 
>>
>> Below is the definition of struct virtio_net_hash_config:
>>
>> struct virtio_net_hash_config {
>>       le32 hash_types;
>>       le16 reserved[4];
>>       u8 hash_key_length;
>>       u8 hash_key_data[hash_key_length];
>> };
>>
>> Here, hash_types, hash_key_length, and hash_key_data are shared with
>> struct virtio_net_rss_config.
>>
>> One problem is that struct virtio_net_rss_config has a flexible array
>> (indirection_table) between hash_types and hash_key_length. This is
>> something we cannot express with C.
> 
> We can split the virtio_net_rss_config to ease the dealing with
> arrays, more below.
> 
>>
>> Another problem is that the semantics of the key in struct
>> virtio_net_hash_config is not defined in the spec.
> 
> If this is the case. Let's fix that in the spec first to make sure our
> uAPI aligns with spec without ambiguity. It would be a nightmare to
> deal with the in-consistency between virtio spec and Linux uAPIs.

The userspace doesn't need to do anything to deal with inconsistency 
since these fields are unused.

> 
>>
>> To solve these problems, I defined the UAPI structures that do not
>> include indiretion_table.
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>> A plot twist is the "types" parameter; it is a parameter that is
>>>>>> "common" for RSS and hash reporting.
>>>>>
>>>>> So we can share part of the structure through the uAPI.
>>>>
>>>> Isn't that what this patch does?
>>>
>>> I didn't see, basically I see only one TUNSETVNETHASH that is used to
>>> set both hash report and rss:
>>
>> The UAPI shares struct tun_vnet_hash for both hash report and rss.
> 
> I meant sharing structure in two ioctls instead of reusing a specific
> structure for two semantics in one ioctl if possible. Though I don't
> think we need any sharing.

The UAPI implemented in this patch already shares struct tun_vnet_hash 
and having two ioctls doesn't change that.

> 
>>
>>>
>>> """
>>> +/**
>>> + * define TUNSETVNETHASH - ioctl to configure virtio_net hashing
>>> + *
>>> + * The argument is a pointer to &struct tun_vnet_hash.
>>> + *
>>> + * The argument is a pointer to the compound of the following in order if
>>> + * %TUN_VNET_HASH_RSS is set:
>>> + *
>>> + * 1. &struct tun_vnet_hash
>>> + * 2. &struct tun_vnet_hash_rss
>>> + * 3. Indirection table
>>> + * 4. Key
>>> + *
>>> """
>>>
>>> And it seems to lack parameters like max_tx_vq.
>>
>> max_tx_vq is not relevant with hashing.
> 
> It is needed for RSS and we don't have that, no?

No. RSS is Receive Side Scaling but it's not about receiving.

> 
>>
>>>
>>> What's more, we've already had virito-net uAPI. Why not simply reusing them?
>>
>> See the above.
>>
>>>
>>>>
>>>>>
>>>>>> RSS and hash reporting must share
>>>>>> this parameter when both are enabled at the same time; otherwise RSS may
>>>>>> compute hash values that are not suited for hash reporting.
>>>>>
>>>>> Is this mandated by the spec? If yes, we can add a check. If not,
>>>>> userspace risk themselves as a mis-configuration which we don't need
>>>>> to bother.
>>>>
>>>> Yes, it is mandated. 5.1.6.4.3 Hash calculation for incoming packets says:
>>>>    > A device attempts to calculate a per-packet hash in the following
>>>>    > cases:
>>>>    >
>>>>    >   - The feature VIRTIO_NET_F_RSS was negotiated. The device uses the
>>>>    >     hash to determine the receive virtqueue to place incoming packets.
>>>>    >   - The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The device
>>>>    >     reports the hash value and the hash type with the packet.
>>>>    >
>>>>    > If the feature VIRTIO_NET_F_RSS was negotiated:
>>>>    >
>>>>    >   - The device uses hash_types of the virtio_net_rss_config structure
>>>>    >     as ’Enabled hash types’ bitmask.
>>>>    >   - The device uses a key as defined in hash_key_data and
>>>>          hash_key_length of the virtio_net_rss_config structure (see
>>>>    >      5.1.6.5.7.1).
>>>>    >
>>>>    > If the feature VIRTIO_NET_F_RSS was not negotiated:
>>>>    >
>>>>    >   - The device uses hash_types of the virtio_net_hash_config structure
>>>>    >     as ’Enabled hash types’ bitmask.
>>>>    >   - The device uses a key as defined in hash_key_data and
>>>>    >     hash_key_length of the virtio_net_hash_config structure (see
>>>>    >      .1.6.5.6.4).
>>>>
>>>> So when both VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT are
>>>> negotiated, virtio_net_rss_config not only controls RSS but also the
>>>> reported hash values and types. They cannot be divergent.
>>>>
>>>>>
>>>>> Note that spec use different commands for hash_report and rss.
>>>>
>>>> TUNSETVNETHASH is different from these commands in terms that it also
>>>> negotiates VIRTIO_NET_F_HASH_REPORT and VIRTIO_NET_F_RSS.
>>>>
>>>
>>> There Are different "issues" here:
>>>
>>> 1) Whether or not we need to use a unified API for negotiating RSS and
>>> HASH_REPORT features
>>> 2) Whether or not we need to sue a unified API for setting RSS and
>>> HASH_REPORT configuration
>>>
>>> What I want to say is point 2. But what you raise is point 1.
>>>
>>> For simplicity, it looks to me like it's a call for having separated
>>> ioctls for feature negotiation (for example via TUNSETIFF). You may
>>> argue that either RSS or HASH_REPORT requires configurations, we can
>>> just follow what spec defines or not (e.g what happens if
>>> RSS/HASH_REPORT were negotiated but no configurations were set).
>>
>> Unfortunately TUNSETIFF does not fit in this use case. The flags set
>> with TUNSETIFF are fixed, but the guest can request a different feature
>> set anytime by resetting the device.
> 
> TUNSETIFF, enables the device to be able to handle RSS/HASREPORT.
> TUNSETHASH/RSS. dealing with RSS/HASH command from userspace.

We also needs to be able to disable them at runtime so that we can 
handle resets.

> 
> This is the way we used to do for multi queue and vnet header.
> TUNSETIFF requires CAP_NET_ADMIN, this could be an extra safe guard
> for unprivileged userspace.

I intend to allow using this feature without privilege. A VMM is usually 
unprivileged and requiring a privilege to configure tuntap is too 
prohibitive.

> 
>>
>>   > >> In the virtio-net specification, it is not defined what would
>> happen if
>>>> these features are negotiated but the VIRTIO_NET_CTRL_MQ_RSS_CONFIG or
>>>> VIRTIO_NET_CTRL_MQ_HASH_CONFIG commands are not sent. There is no such
>>>> ambiguity with TUNSETVNETHASH.
>>>
>>> So I don't see advantages of unifying hash reports and rss into a
>>> single ioctl. Let's just follow what has been done in the spec that
>>> uses separated commands. Tuntap is not a good place to debate whether
>>> those commands could be unified or not. We need to move it to the spec
>>> but assuming spec has been done, it might be too late or too few
>>> advantages for having another design.
>>
>> It makes sense for the spec to reuse the generic feature negotiation
>> mechanism, but the situation is different for tuntap; we cannot use
>> TUNSETIFF and need to define another. Then why don't we exploit this
>> opportunity to have an interface with well-defined semantics?
> 
> That's perfectly fine, but it needs to be done in virtio-net's uAPI
> not tun's. What's more, if you think two commands are not
> well-defined, let's fix that in the virtio spec first.
> 
>> The virtio
>> spec does its best as an interface between the host and guest and tuntap
>> does its best as an UAPI.
> 
> See above, let's fix the uAPI first. We don't want DPDK to use tun's
> uAPI for RSS

virtio-net's UAPI is for the virtio spec which has a capable generic 
feature negotiation mechanism. tuntap needs its own feature negotiation 
and it's nothing to do with virtio-net's UAPI.

The structures for two commands have unused or redundant fields and a 
flexible array in the middle of the structure, but they are ABIs so we 
can't change it.

DPDK is another reason to define tuntap's own UAPIs. They don't care 
unused or redundant fields and a flexible array in middle that are 
present in the virtio spec. It will also not want to deal with the 
requirement of little endian. Constructing struct virtio_net_rss_config 
is an extra burden for DPDK.

On the other hand, Constructing tuntap-specific structures is not that 
complicated for VMMs. A VMM will need to inspect struct 
virtio_net_rss_config anyway to handle migration and check its size so 
it can store the values it inspected to struct tun_vnet_hash and struct 
tun_vnet_hash_rss and pass them to the kernel.

The overall userspace implementation will be simpler by having 
structures specifically tailored for the communication between the 
userspace and kernel.

> 
>>
>> I don't think there is an advantage to split ioctls to follow the spec
>> after all. It makes sense if we can pass-through virtio commands to
>> tuntap, but it is not possible as ioctl operation codes are different
>> from virtio commands.
> 
> I don't see a connection with the operation code. For example, we can
> add new uAPIs in virtio-net which could be something like:
> 
>   struct virtio_net_rss_config_header {
>        __le32 hash_types;
>        __le16 indirection_table_mask;
>        __le16 unclassified_queue;
>        __le16 indirection_table[];
> }
> 
> struct virtio_net_rss_config_tailer {
>        __le16 max_tx_vq;
>        u8 hash_key_length;
>        u8 hash_key_data[];
> }
> 
> These two are used by TUNSETVNETRSS. And simply reuse the
> virtio_net_hash_config for TUNSETVETHASH.
 > > With this, we can tweak the virtio-net driver with this new uAPI. Then
> tap* can reuse this.

I implemented a UAPI and driver change accordingly:
https://lore.kernel.org/r/20250318-virtio-v1-0-344caf336ddd@daynix.com

This is a nice improvement for the driver, but I still don't think it is 
suited for the UAPI of tuntap. The requirements of extra fields and 
little endian cannot be removed from the virtio spec but they are 
irrelevant for tuntap.

> 
>> The best possibility is to share structures, not
>> commands, and I don't think even sharing structures makes sense here
>> because of the reasons described above.
> 
> I don't want to share structures, I meant starting from something that
> is simple and has been sorted in the virtio spec. Optimization could
> be done on top.

I meant to reuse the structures in virtio_net.h.

Regards,
Akihiko Odaki

> 
> Thanks
> 
> 
>>
>> Regards,
>> Akihiko Odaki
>>
>>>
>>> Thanks
>>>
>>>>
>>>> Regards,
>>>> Akihiko Odaki
>>>>
>>>>>
>>>>>>
>>>>>> The paramter will be duplicated if we have separate ioctls for RSS and
>>>>>> hash reporting, and the kernel will have a chiken-egg problem when
>>>>>> ensuring they are synchronized; when the ioctl for RSS is issued, should
>>>>>> the kernel ensure the "types" parameter is identical with one specified
>>>>>> for hash reporting? It will not work if the userspace may decide to
>>>>>> configure hash reporting after RSS.
>>>>>>
>>>>>
>>>>> See my reply above.
>>>>>
>>>>> Thanks
>>>>>
>>>>
>>>
>>
> 


