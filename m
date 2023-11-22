Return-Path: <linux-kselftest+bounces-402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DEF7F3D67
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 06:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C3F1B20FB4
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 05:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4B3125A8;
	Wed, 22 Nov 2023 05:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="em2DzhAj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F111318E
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Nov 2023 21:36:39 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso4883362a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Nov 2023 21:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700631399; x=1701236199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OPmH0R/ZGatN6+UwwJY3MEok1l+rZDRi+gW+Psbpgp4=;
        b=em2DzhAjzA6+M6CAZujzfRwbEZCqdGSRYk74aXSfvrwfC9i0A5Oyz+J+5tXb6LB8dK
         pb1g2PGElnuo2VdvsfPqhH/zL4esxIz8rbH83DzmAT67TQcpdWYKKVZUIut7hb1C1Dbk
         SSU7+oZWwp6PD3mXy/vhPNk2gTDZAD15xboH/Ew9BYswQvTRf1/GEiDSNQyn9VaGj5b4
         uApyRPYUw0IJVUcMc8WuX08ZPTfmQ8+6n3cXr8qZCA5fJ6k/UaM5+Ibswq/4Y3EzKHvu
         R9g/W7fzIJjmilMuHgWda6NsgQYaM4/F5jzzQu3bTAx4UkOXhFHVQUVBoyK2tkqx17Ww
         LxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700631399; x=1701236199;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPmH0R/ZGatN6+UwwJY3MEok1l+rZDRi+gW+Psbpgp4=;
        b=Tzq0sK5VB1hEJNtxP6glLVyUUv6u+5lUWNWvq+30Gvjja0jPtDBQO94VfhPmvJoQO3
         03+Jys4yIPL74jWjN/smf3BudjB1hH1OvPBRASx7etWnNmGXXtzUgc3G4SeGpp2vFyH3
         DpdMnqcvSfTQ3Y8YHQE5CausU7qDN4o5EwBZI/VdXVbTiRSX7ZqN5mEW5F+Hudk8up1r
         sUEfNe8RlUxFYoXsjgZfZ18TJZao+hwp1B2asjqlnK6a9BY2V/HAIwBss6ERYoR0KLiG
         w1FJ+Y5WwtfhEFlHd9z8BqG0AXnVYflZNxByC0IJNBn5Jb3iTpDqcyecIOeiXlB7IwUp
         pGmg==
X-Gm-Message-State: AOJu0YwE1OZkpNq5AZ54T/Z6tp4vLsS1d6+skDUVcrjxofmgLqgf6yX/
	5c1IkagfxGG8KdGTRjUfXEeubA==
X-Google-Smtp-Source: AGHT+IE67Eq9oO1uEot/zjxOXNvgyCk21nCZbXVKotApAyu3bet6Avb8lU17DWWWT9joNIuvOnZhJw==
X-Received: by 2002:a05:6a20:8f1d:b0:17a:e941:b0a3 with SMTP id b29-20020a056a208f1d00b0017ae941b0a3mr1395905pzk.39.1700631399364;
        Tue, 21 Nov 2023 21:36:39 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
        by smtp.gmail.com with ESMTPSA id gj13-20020a17090b108d00b002839a4f65c5sm454781pjb.30.2023.11.21.21.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 21:36:39 -0800 (PST)
Message-ID: <664003d3-aadb-4938-80f6-67fab1c9dcdd@daynix.com>
Date: Wed, 22 Nov 2023 14:36:32 +0900
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
 <dba89d4b-84aa-4c9f-b016-56fd3ade04b2@daynix.com>
 <CAPhsuW5KLgt_gsih7zi+T99iYVbt7hk7=OCwYzin-H3=OhF54Q@mail.gmail.com>
 <a1f09866-a443-4f74-8025-6cdb32eb1d2c@daynix.com>
 <CAPhsuW4o5o41a+jVjgGP+Ck3eUD8w6coLXMTYewXKJYmciLLnQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAPhsuW4o5o41a+jVjgGP+Ck3eUD8w6coLXMTYewXKJYmciLLnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/11/22 14:25, Song Liu wrote:
> On Mon, Nov 20, 2023 at 12:05 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2023/11/20 6:02, Song Liu wrote:
> [...]
>>>> In contrast, our intended use case is more like a normal application.
>>>> So, for example, a user may download a container and run QEMU (including
>>>> the BPF program) installed in the container. As such, it is nice if the
>>>> ABI is stable across kernel releases, but it is not guaranteed for
>>>> kfuncs. Such a use case is already covered with the eBPF steering
>>>> program so I want to maintain it if possible.
>>>
>>> TBH, I don't think stability should be a concern for kfuncs used by QEMU.
>>> Many core BPF APIs are now implemented as kfuncs: bpf_dynptr_*,
>>> bpf_rcu_*, etc. As long as there are valid use cases,these kfuncs will
>>> be supported.
>>
>> Documentation/bpf/kfuncs.rst still says:
>>   > kfuncs provide a kernel <-> kernel API, and thus are not bound by any
>>   > of the strict stability restrictions associated with kernel <-> user
>>   > UAPIs.
>>
>> Is it possible to change the statement like as follows:
>> "Most kfuncs provide a kernel <-> kernel API, and thus are not bound by
>> any of the strict stability restrictions associated with kernel <-> user
>> UAPIs. kfuncs that have same stability restrictions associated with
>> UAPIs are exceptional, and must be carefully reviewed by subsystem (and
>> BPF?) maintainers as any other UAPIs are."
> 
> I am afraid this is against the intention to not guarantee UAPI-level stability
> for kfuncs.

Is it possible to ensure that a QEMU binary with the eBPF program 
included works on different kernel versions without UAPI-level stability 
then? Otherwise, I think we need to think of the minimal UAPI addition 
that exposes the feature I propose, and the two options I presented 
first are the candidates of such: the stable BPF change or tuntap 
interface change.

Regards,
Akihiko Odaki

