Return-Path: <linux-kselftest+bounces-1485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6EC80B980
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Dec 2023 08:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B404A1C20889
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Dec 2023 07:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E89523F;
	Sun, 10 Dec 2023 07:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="t6U+Wo49"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581BD114
	for <linux-kselftest@vger.kernel.org>; Sat,  9 Dec 2023 23:03:13 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1faf56466baso2425681fac.3
        for <linux-kselftest@vger.kernel.org>; Sat, 09 Dec 2023 23:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702191792; x=1702796592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZjIsRqTNDf1ZUfBCKqHqKSty0Nok+i7FEmnwcARKdLI=;
        b=t6U+Wo49Vqxkj6UA5DRh1ODobhsKSy94+fcyU192lu4tAGk7PSP9WR+g6VZknpmnlr
         8PZIruZZKSxBGqi2hoqTt9kZNndxnfSmaJOYMUoFHS2Aj9ek8DYw/s3/mM3cnvnkEUdy
         iVW3ilu8GwkzmMNDCI1qUPKIaMU/8YPKH9sv859xYNqog4WMGquc8hmckQGUd2xWTOQA
         MWDtUp+1OZ0MWhfxyRtQkh7jqFKCXJRBW4HKAD7VDUsteUSDkTAPxybDKQt5wH8oLKHJ
         YMx9WGYxHSKJee8HmTlvRVFNkH4cCF8hxassXItIUu4/qxl28VSMveVma20pwhUQSJ4t
         zXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702191792; x=1702796592;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjIsRqTNDf1ZUfBCKqHqKSty0Nok+i7FEmnwcARKdLI=;
        b=Qb5SJFLE9qpRTM15HVCQ8RkOMDmmTTLzS+fxfpVemNwUHTBW/5f+nyNBYKzQGqTvQv
         JNlBshFB7Sbr96kZ9I+XvG8IRsSG9popfnWIyEraQ/d98lQd1lKgQxju4bqdFup5eC7y
         bVnqUF3I5g6YznW6Q22/D6LwL+N7Ah6PLAVLF1q/Rq43EAxfhtW+daZPnuAm0RqQuSeu
         4K5xghejV0EBC2LaZeUiJbyeyoC5V/dCeVB3snsJtOzLXBT5fgNoi4KuwW+L0qAi5gMs
         PihFtHADNPMC04O9v+g8ZoEskhRofLsCbw1zRPiNH6NF4KxfjW1cwSZDu8FAb0VNlXKN
         ge6A==
X-Gm-Message-State: AOJu0YyiPFCOepsZn0ASK2b/rltpPXERtJIJMyzs9LbF6MfEfPkduxXU
	ExYMdnedDLGkb2/7tVIEq87rrQ==
X-Google-Smtp-Source: AGHT+IF7dbPeSGNYzf+4zTjIef4l3Kxy13SD9t8mjadsfNI4Blcv83g93Y/1lOsphUYUl/vxKi2YvA==
X-Received: by 2002:a05:6871:521f:b0:1fb:75b:2fdf with SMTP id ht31-20020a056871521f00b001fb075b2fdfmr3174064oac.118.1702191792580;
        Sat, 09 Dec 2023 23:03:12 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
        by smtp.gmail.com with ESMTPSA id r9-20020a63ec49000000b005b9083b81f0sm4261259pgj.36.2023.12.09.23.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 23:03:12 -0800 (PST)
Message-ID: <d30a038b-d10f-468d-8879-478a6c5b814b@daynix.com>
Date: Sun, 10 Dec 2023 16:03:05 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/7] bpf: Introduce BPF_PROG_TYPE_VNET_HASH
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: Song Liu <song@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>
References: <20231015141644.260646-1-akihiko.odaki@daynix.com>
 <20231015141644.260646-2-akihiko.odaki@daynix.com>
 <CAADnVQLfUDmgYng8Cw1hiZOMfWNWLjbn7ZGc4yOEz-XmeFEz5Q@mail.gmail.com>
 <2594bb24-74dc-4785-b46d-e1bffcc3e7ed@daynix.com>
 <CAADnVQ+J+bOtvEfdvgUse_Rr07rM5KOZ5DtAmHDgRmi70W68+g@mail.gmail.com>
 <CACGkMEs22078F7rSLEz6eQabkZZ=kujSONUNMThZz5Gp=YiidQ@mail.gmail.com>
 <CAADnVQLt8NWvP8qGWMPx=12PwWWE69P7aS2dbm=khAJkCnJEoQ@mail.gmail.com>
 <9a4853ad-5ef4-4b15-a49e-9edb5ae4468e@daynix.com>
 <6253fb6b-9a53-484a-9be5-8facd46c051e@daynix.com>
 <CAPhsuW5JYoM-Mkehdy=FQsG1nvjbYGzwRZx8BkpG1P7cHdD=eQ@mail.gmail.com>
 <dba89d4b-84aa-4c9f-b016-56fd3ade04b2@daynix.com>
 <CAPhsuW5KLgt_gsih7zi+T99iYVbt7hk7=OCwYzin-H3=OhF54Q@mail.gmail.com>
 <a1f09866-a443-4f74-8025-6cdb32eb1d2c@daynix.com>
 <CAPhsuW4o5o41a+jVjgGP+Ck3eUD8w6coLXMTYewXKJYmciLLnQ@mail.gmail.com>
 <664003d3-aadb-4938-80f6-67fab1c9dcdd@daynix.com>
In-Reply-To: <664003d3-aadb-4938-80f6-67fab1c9dcdd@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/11/22 14:36, Akihiko Odaki wrote:
> On 2023/11/22 14:25, Song Liu wrote:
>> On Mon, Nov 20, 2023 at 12:05 AM Akihiko Odaki 
>> <akihiko.odaki@daynix.com> wrote:
>>>
>>> On 2023/11/20 6:02, Song Liu wrote:
>> [...]
>>>>> In contrast, our intended use case is more like a normal application.
>>>>> So, for example, a user may download a container and run QEMU 
>>>>> (including
>>>>> the BPF program) installed in the container. As such, it is nice if 
>>>>> the
>>>>> ABI is stable across kernel releases, but it is not guaranteed for
>>>>> kfuncs. Such a use case is already covered with the eBPF steering
>>>>> program so I want to maintain it if possible.
>>>>
>>>> TBH, I don't think stability should be a concern for kfuncs used by 
>>>> QEMU.
>>>> Many core BPF APIs are now implemented as kfuncs: bpf_dynptr_*,
>>>> bpf_rcu_*, etc. As long as there are valid use cases,these kfuncs will
>>>> be supported.
>>>
>>> Documentation/bpf/kfuncs.rst still says:
>>>   > kfuncs provide a kernel <-> kernel API, and thus are not bound by 
>>> any
>>>   > of the strict stability restrictions associated with kernel <-> user
>>>   > UAPIs.
>>>
>>> Is it possible to change the statement like as follows:
>>> "Most kfuncs provide a kernel <-> kernel API, and thus are not bound by
>>> any of the strict stability restrictions associated with kernel <-> user
>>> UAPIs. kfuncs that have same stability restrictions associated with
>>> UAPIs are exceptional, and must be carefully reviewed by subsystem (and
>>> BPF?) maintainers as any other UAPIs are."
>>
>> I am afraid this is against the intention to not guarantee UAPI-level 
>> stability
>> for kfuncs.
> 
> Is it possible to ensure that a QEMU binary with the eBPF program 
> included works on different kernel versions without UAPI-level stability 
> then? Otherwise, I think we need to think of the minimal UAPI addition 
> that exposes the feature I propose, and the two options I presented 
> first are the candidates of such: the stable BPF change or tuntap 
> interface change.
> 
> Regards,
> Akihiko Odaki

Now the discussion is stale again so let me summarize the discussion:

A tuntap device can have an eBPF steering program to let the userspace 
decide which tuntap queue should be used for each packet. QEMU uses this 
feature to implement the RSS algorithm for virtio-net emulation. Now, 
the virtio specification has a new feature to report hash values 
calculated with the RSS algorithm. The goal of this RFC is to report 
such hash values from the eBPF steering program to the userspace.

There are currently three ideas to implement the proposal:

1. Abandon eBPF steering program and implement RSS in the kernel.

It is possible to implement the RSS algorithm in the kernel as it's 
strictly defined in the specification. However, there are proposals for 
relevant virtio specification changes, and abandoning eBPF steering 
program will loose the ability to implement those changes in the 
userspace. There are concerns that this lead to more UAPI changes in the 
end.

2. Add BPF kfuncs.

Adding BPF kfuncs is *the* standard way to add BPF interfaces. hid-bpf 
is a good reference for this.

The problem with BPF kfuncs is that kfuncs are not considered as stable 
as UAPI. In my understanding, it is not problematic for things like 
hid-bpf because programs using those kfuncs affect the entire system 
state and expected to be centrally managed. Such BPF programs can be 
updated along with the kernel in a manner similar to kernel modules.

The use case of tuntap steering/hash reporting is somewhat different 
though; the eBPF program is more like a part of application (QEMU or 
potentially other VMM) and thus needs to be portable. For example, a 
user may expect a Debian container with QEMU installed to work on Fedora.

BPF kfuncs do still provide some level of stability, but there is no 
documentation that tell how stable they are. The worst case scenario I 
can imagine is that a future legitimate BPF change breaks QEMU, letting 
the "no regressions" rule force the change to be reverted. Some 
assurance that kind scenario will not happen is necessary in my opinion.

3. Add BPF program type derived from the conventional steering program type

In principle, it's just to add a feature to report four more bytes to 
the conventional steering program. However, BPF program types are frozen 
for feature additions and the proposed change will break the feature freeze.

So what's next? I'm inclined to option 3 due to its minimal ABI/API 
change, but I'm also fine with option 2 if it is possible to guarantee 
the ABI/API stability necessary to run pre-built QEMUs on future kernel 
versions by e.g., explicitly stating the stability of kfuncs. If no 
objection arises, I'll resend this series with the RFC prefix dropped 
for upstream inclusion. If it's decided to go for option 1 or 2, I'll 
post a new version of the series implementing the idea.

Regards,
Akihiko Odaki

