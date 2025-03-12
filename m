Return-Path: <linux-kselftest+bounces-28796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEB4A5D5C2
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 06:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B513B7720
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 05:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226071E3DC8;
	Wed, 12 Mar 2025 05:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="eXPobSs1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513A81DF277
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 05:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741758945; cv=none; b=oJFMafjZf52v3ByrW2tYPI8LCcB5n8uZH9fsJYztu0oTZWhmfw40GAzoLivzISEqa5FWoJB15erStaWVKzEd1nSMIdzMRP/Kmohem8vjZF2bbwhFzzWJAztW1EHV0lTdHOKcBnXZXBpr8wR02eDVmg4lhg+yO4qh+GS2JoyLcRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741758945; c=relaxed/simple;
	bh=alhU20ihOlc5cJCMuHBajEc7EUqehBtkqo5iRv29oVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/ErbSbBUGcb1RL+LytvP72LPmL8Z5DrCtQgL8bL1P/SNCZoUpKMtLlG2totMXuvK/eMmUk1ln6iVaxrgwo1IV22rOWndDi6Ag0CKUWG6U6CBGjTb2KZhJldb+OY2LvF7Up8+RP7K6BgvGocHuMMH9AbhHzO03AofxiyuZxugu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=eXPobSs1; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ff797f8f1bso8750970a91.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 22:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741758941; x=1742363741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oSOfwAcbQA4fo8Ww+ZUfjP/u2KZyMzcNTNHmT2zLzAs=;
        b=eXPobSs1pPcY2kkGUDTkUJAz6sPvL59IHQKGYSwAdKIup4QyjLYMD3b9smPrN4YSR5
         +cejTYlr6XtbunhdGIME9KwDFaa0VKAwgMBHAWmmy3E6TLNrssg7dat/SBWkmS+qU2uI
         pv3St3becRp49oIv7FgZT2IPvvnTX8HvaKjBc+6ZT7vXI1Ggc1Cdw9JzOtj1PATClKmf
         zResMG/HZlIdbikSUHgeDPD7ASoiv6FZjEuBOi158kA966Gaa+s4JyA0lnkzsTrVRxlo
         s0GmGfBgIkmQ3qn8wW4bDdr2VyJn4pmqRb2zTENBVrXdmLcxct4AaY2dkChoruyUkhDQ
         TWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741758941; x=1742363741;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oSOfwAcbQA4fo8Ww+ZUfjP/u2KZyMzcNTNHmT2zLzAs=;
        b=ELXSd1FkJLQAMKRDX7r/FdGkelXUjU1eMhloDZzN4BPqF1esjZ5FRSVd1v8fHRt7VX
         jf9G2xGl35gVrxmEd+PgIJ/nnJ2Xbdj8RyJiWMOl0TDHL4Ugnx999mEJuQPrN6MmUmGN
         1IKrigDqdE6Wro7fQFaJUr4oEmw2yLv+6taUjnS/BzW9jEHdX3+RIbukQ+2/8ePct2pD
         JVq83c2asfedNPm77eEQ/F635nxLePW669VKEwUbWrzynNL6Ee86sojqV+MfojpYx3Hv
         UyxvZbFUK7FBTJArV0nSiRPHKi03pxrVkLjfhCvYd0rAGi2QV1SN2Cw+R5dqHRqdfltY
         59Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVbQ3KMrBpGoW/1D2IZNYIMBn5+e1zdclxEoikvI4r5Z9Gk53/9eCvVBjuhn5Z9mxVhnB83RQAe+iUxE4Tm3pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqjlIepAefxSfNG5w1I7nNI0HOfeNOL2MT3PTB2zh4EFAUCHHh
	u4CEQYnP2vAt0rJM/PfpaQtdMBNyU8XsrUjbBqzM7dtiPhVQmwAHAmoHtoTlPZo=
X-Gm-Gg: ASbGncvTeJxRtKn9kGn1plDwSjsWJMvtdbr9S5FdbjDrI7Puf5YAMZdNYKQ13KCAHu2
	oN6gL48tT1900vueHPqLn8g+EUw2FgvEBmrldJRow5buKbAzww4/wDwTnE7YAiRw7Nijm2MBeQC
	nbgwQSP2ej+YeRrbUir0bvT7xq2461eF36Dnrb9uTz2q237W6IULHQGM9uoVVG3Few0QwRlw6YK
	Xud4cOVN7uoobczedkvrKUf4wMOQFlYypIlodOmXKpIXhSeQlSuVE0oKkVyljIats4sxMrJAcMS
	C6pvgzp3RpuHiql5XBHqOfszMwkX6uGgBgm0hQXwl/5lWYxjbEy2ZY+xuA==
X-Google-Smtp-Source: AGHT+IEnYwIq0Gmg9aXj/gdoHcpx7iSAd8arSmzyKfzCe7K3tIJUhpfLuzs4l56U190AWHzReGvYOg==
X-Received: by 2002:a17:90b:48cc:b0:2ee:d371:3227 with SMTP id 98e67ed59e1d1-300ff104f1emr9530678a91.17.1741758941650;
        Tue, 11 Mar 2025 22:55:41 -0700 (PDT)
Received: from [157.82.205.237] ([157.82.205.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301190bbd78sm748839a91.39.2025.03.11.22.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 22:55:41 -0700 (PDT)
Message-ID: <39c059c9-fe67-46e4-8c81-854a3de8d726@daynix.com>
Date: Wed, 12 Mar 2025 14:55:36 +0900
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
 <5e67a0a6-f613-4b0a-b64e-67f649e45c3e@daynix.com>
 <CACGkMEv83iR0vU00XGOGonL1fkd=K1b-shCcNb1K8yJ9O+0BDQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEv83iR0vU00XGOGonL1fkd=K1b-shCcNb1K8yJ9O+0BDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/03/12 11:59, Jason Wang wrote:
> On Tue, Mar 11, 2025 at 2:17 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
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
> 
> [...]
> 
>>>>> Let's has a consistent name for this and the uapi to be consistent
>>>>> with TUNSETIFF/TUNGETIFF. Probably TUNSETVNETHASH and
>>>>> tun_vnet_ioctl_gethash().
>>>>
>>>> They have different semantics so they should have different names.
>>>> TUNGETIFF reports the value currently set while TUNGETVNETHASHCAP
>>>> reports the value that can be set later.
>>>
>>> I'm not sure I will get here. I meant a symmetric name
>>>
>>> TUNSETVNETHASH and TUNVETVNETHASH.
>>
>> TUNGETVNETHASHCAP does not correspond to TUNGETIFF. The correspondence
>> of ioctl names is as follows:
>> TUNGETFEATURES - TUNGETVNETHASHCAP
> 
> TUNGETFEATURES returns the value set from TUNSETIFF. This differs from
> TUNGETVNETHASHCAP semantic which just return the capabilities.
> 
> +static inline long tun_vnet_ioctl_gethashcap(void __user *argp)
> +{
> +       static const struct tun_vnet_hash cap = {
> +               .flags = TUN_VNET_HASH_REPORT | TUN_VNET_HASH_RSS,
> +               .types = VIRTIO_NET_SUPPORTED_HASH_TYPES
> +       };
> +
> +       return copy_to_user(argp, &cap, sizeof(cap)) ? -EFAULT : 0;
> +}
> 
> TUNGETFEATURES doesn't' help too much for non-persist TAP as userspace
> knows what value it set before.
> 
>> TUNSETIFF - TUNSETVNETHASH
>> TUNGETIFF - no corresponding ioctl for the virtio-net hash features
> 
> And this sounds odd and a hint for a incomplete uAPI as userspace
> needs to know knowing what can set before doing TUNSETVNETHASH.

You are confused with TUNGETFEATURES and TUNGETIFF. Below is the code 
that implements TUNGETFEATURES:
if (cmd == TUNGETFEATURES) {
	/* Currently this just means: "what IFF flags are valid?".
	 * This is needed because we never checked for invalid flags on
	 * TUNSETIFF.
	 */
	return put_user(IFF_TUN | IFF_TAP | IFF_NO_CARRIER |
			TUN_FEATURES, (unsigned int __user*)argp);
} else if (cmd == TUNSETQUEUE) {

Regards,
Akihiko Odaki

> 
>>
>> Regards,
>> Akihiko Odaki
>>
> 
> Thanks
> 


