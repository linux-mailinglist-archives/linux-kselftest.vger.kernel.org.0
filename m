Return-Path: <linux-kselftest+bounces-274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 884697F04B5
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Nov 2023 09:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A290280E95
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Nov 2023 08:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F17612F;
	Sun, 19 Nov 2023 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="fiiuSA3J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE205182
	for <linux-kselftest@vger.kernel.org>; Sun, 19 Nov 2023 00:03:33 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b20577ef7bso2891747b3a.3
        for <linux-kselftest@vger.kernel.org>; Sun, 19 Nov 2023 00:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700381013; x=1700985813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZG+je2UulHz8p53bRtgSoWGbv+SBJAMHNPOyzsP/38=;
        b=fiiuSA3Jjnvd0j02epWpbnFRhWhFSSulk7lXf6aBpptqee9828ldaSZOc5Xm/w1GpK
         S30HGuP1V+825/EcFNrSwDLG/W2H3xf5JMi9iAnGqDXbSrWEWhDFdf/RMdcFh+dLSfXF
         oCdG5b1JLdPPI58w6jJiNXJAK18lOkrguplHh5P55UGpfdHklcEEjMv3pcv5SSvzkoB0
         r97xDRhnXp24Jxgw4ffzTcRXK1IcuxccUoRy0qyUuGKdZ/Pxe7jtGGL0bA/B4v0tmfi+
         Lu5ydW1svgxZq6esAu0a/aaCcuBj9FyXHgTr2zUMK/NKUuqALrRUI2bfh9QF85WqQnxp
         HeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700381013; x=1700985813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZG+je2UulHz8p53bRtgSoWGbv+SBJAMHNPOyzsP/38=;
        b=fE6XPx0TFntMIl83I86mnDFOWiqkpBsPiIlORbnx/p22KU2Oh+lTPeMeZ5boCekPop
         LRK7FqU37VYBgV7kln+FsCMS+VXo2kZNqmMFgKrj2gy12Wsg//4BXNo8e7VJeji5eJxd
         pVkTPiQyYp1Sp1c39dGCuMfRTcYbAMWFVYj8Se6gSdTkph2QURCTUo7KzoXioeF5YKR3
         YddGng/OzWQfqvpCzJdlrKIbYXVKOiEObz9rkW9Px+KZfHWSyA1aPC7tyelUA6o6YiaB
         p8cexpa2SmNKOxjqA9xnrvjkfeJeAj3XS7oPSGPK7ipnLnD2BTjuPeP5S1FVokN8XLXl
         cvvg==
X-Gm-Message-State: AOJu0YyKkgN1Gkf0ziCFLoOa7+AOJ+wfsL1yjA5B1lkfvJHMrbk39I3O
	O3P34uii0E2lGDLZRaNrjPoSlA==
X-Google-Smtp-Source: AGHT+IGiO0h2fb01+Pn0SevWQNLU1hCSX7eSC/3QhMU52Pv6T69nYb0fcbD/88QBmyRYuwNbBA7/XA==
X-Received: by 2002:a17:902:d503:b0:1cc:b09a:b811 with SMTP id b3-20020a170902d50300b001ccb09ab811mr3233581plg.14.1700381012995;
        Sun, 19 Nov 2023 00:03:32 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902da8400b001cf5c99f031sm234091plx.283.2023.11.19.00.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Nov 2023 00:03:32 -0800 (PST)
Message-ID: <dba89d4b-84aa-4c9f-b016-56fd3ade04b2@daynix.com>
Date: Sun, 19 Nov 2023 17:03:25 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/7] bpf: Introduce BPF_PROG_TYPE_VNET_HASH
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAPhsuW5JYoM-Mkehdy=FQsG1nvjbYGzwRZx8BkpG1P7cHdD=eQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/11/19 1:08, Song Liu wrote:
> Hi,
> 
> A few rookie questions below.

Thanks for questions.

> 
> On Sat, Nov 18, 2023 at 2:39 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2023/10/18 4:19, Akihiko Odaki wrote:
>>> On 2023/10/18 4:03, Alexei Starovoitov wrote:
> [...]
>>>
>>> I would also appreciate if you have some documentation or link to
>>> relevant discussions on the mailing list. That will avoid having same
>>> discussion you may already have done in the past.
>>
>> Hi,
>>
>> The discussion has been stuck for a month, but I'd still like to
>> continue figuring out the way best for the whole kernel to implement
>> this feature. I summarize the current situation and question that needs
>> to be answered before push this forward:
>>
>> The goal of this RFC is to allow to report hash values calculated with
>> eBPF steering program. It's essentially just to report 4 bytes from the
>> kernel to the userspace.
> 
> AFAICT, the proposed design is to have BPF generate some data
> (namely hash, but could be anything afaict) and consume it from
> user space. Instead of updating __sk_buff, can we have the user
> space to fetch the data/hash from a bpf map? If this is an option,
> I guess we can implement the same feature with BPF tracing
> programs?

Unfortunately no. The communication with the userspace can be done with 
two different means:
- usual socket read/write
- vhost for direct interaction with a KVM guest

The BPF map may be a valid option for socket read/write, but it is not 
for vhost. In-kernel vhost may fetch hash from the BPF map, but I guess 
it's not a standard way to have an interaction between the kernel code 
and a BPF program.

> 
>>
>> Unfortunately, however, it is not acceptable for the BPF subsystem
>> because the "stable" BPF is completely fixed these days. The
>> "unstable/kfunc" BPF is an alternative, but the eBPF program will be
>> shipped with a portable userspace program (QEMU)[1] so the lack of
>> interface stability is not tolerable.
> 
> bpf kfuncs are as stable as exported symbols. Is exported symbols
> like stability enough for the use case? (I would assume yes.)
> 
>>
>> Another option is to hardcode the algorithm that was conventionally
>> implemented with eBPF steering program in the kernel[2]. It is possible
>> because the algorithm strictly follows the virtio-net specification[3].
>> However, there are proposals to add different algorithms to the
>> specification[4], and hardcoding the algorithm to the kernel will
>> require to add more UAPIs and code each time such a specification change
>> happens, which is not good for tuntap.
> 
> The requirement looks similar to hid-bpf. Could you explain why that
> model is not enough? HID also requires some stability AFAICT.

I have little knowledge with hid-bpf, but I assume it is more like a 
"safe" kernel module; in my understanding, it affects the system state 
and is intended to be loaded with some kind of a system daemon. It is 
fine to have the same lifecycle with the kernel for such a BPF program; 
whenever the kernel is updated, the distributor can recompile the BPF 
program with the new kernel headers and ship it along with the kernel 
just as like a kernel module.

In contrast, our intended use case is more like a normal application. 
So, for example, a user may download a container and run QEMU (including 
the BPF program) installed in the container. As such, it is nice if the 
ABI is stable across kernel releases, but it is not guaranteed for 
kfuncs. Such a use case is already covered with the eBPF steering 
program so I want to maintain it if possible.

Regards,
Akihiko Odaki

