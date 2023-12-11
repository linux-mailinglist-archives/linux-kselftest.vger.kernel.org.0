Return-Path: <linux-kselftest+bounces-1498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA4380C08A
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 06:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECAC61C2082E
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 05:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADDD1C6B1;
	Mon, 11 Dec 2023 05:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="27Kks5wu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA8DF4
	for <linux-kselftest@vger.kernel.org>; Sun, 10 Dec 2023 21:04:35 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-58d1b767b2bso2485013eaf.2
        for <linux-kselftest@vger.kernel.org>; Sun, 10 Dec 2023 21:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702271074; x=1702875874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BalHLDcooMB+t0Ag91tFQwsYCexpEQu0oQz20kE5Mf0=;
        b=27Kks5wuAVKjtTcqWGs6wgrbfjuHo3f5Gx8tvh/WNdJcnYotDNA2sCWbE+lvHdJ085
         Ac2YbK5zU46cLxPujBkF0gAmB9BxuFkbBWXcz3qXF7KMq+Mx96SU9vYYSPM6Io7578NV
         LMJiGVnYFWCaksXbwQcEs3jl1ZJqF6GnHXTzblTUtOH39z5LZuor8+JZSt2cuUbAPlWC
         ymU27E+k/12onMZ62Q+T/f+9WJKj2oBgcDZPSu/6Bqi8X+23ym2brol85Q8AdohyhtK2
         GZmd63U/x3qZJbS21jIT1CdyaZE5xZK+EbtTbzd0kMz6IrsT04TuNGsbsDpzC+9wN5VV
         zM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702271074; x=1702875874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BalHLDcooMB+t0Ag91tFQwsYCexpEQu0oQz20kE5Mf0=;
        b=Ex/jicSoIWl/qWRkNF11+RdvcPHC5W8fywlv3HYsuckT3TnT6y0wr2GWcaONEWLCty
         w8rP8zGf8upbCTaR9hFXoiagoIsJDKch3OuebblI2JiVchK6NDKMrSHC9Df6CvT9IF9O
         PfOqY3Si0uQqvRglO311iZGunK1ijAntA+9ACgPvgVv0QIKfdtLNqIUhCHMjAabhjBdG
         RVo1DTNynxV3hs6YlQmFyZKlFk6hUCXExj3XKGivv5Lo9frVbeDaGv2CiHs6WlOPH7fN
         ILoC7WCEVCreJ0FJWFsJABB4Tf7uwG9YcWzegNAyD56MRm07X2kzej2bNLt5GI6Rnq8L
         LKIw==
X-Gm-Message-State: AOJu0YxeScypvwwNZdiUUVFdvtFT9Fsey3NMRBFBZe5KsmRNAYvolmJZ
	vyLYfZV4KH5tHNPyu40eTR7TWg==
X-Google-Smtp-Source: AGHT+IFbeF3A7DLdDMfJ3IuSv7d/fBWbSg/shs7sqh7U8sgQtsov7aRO9AuKG9LBEd16Y4e//COENw==
X-Received: by 2002:a05:6359:1b05:b0:170:756:90fd with SMTP id up5-20020a0563591b0500b00170075690fdmr2599052rwb.19.1702271074519;
        Sun, 10 Dec 2023 21:04:34 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
        by smtp.gmail.com with ESMTPSA id k189-20020a6324c6000000b005bcea1bf43bsm5314561pgk.12.2023.12.10.21.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Dec 2023 21:04:34 -0800 (PST)
Message-ID: <49a5b971-ae97-4118-ae20-f651ad14bed7@daynix.com>
Date: Mon, 11 Dec 2023 14:04:27 +0900
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
 <d30a038b-d10f-468d-8879-478a6c5b814b@daynix.com>
 <CAPhsuW5CMYiOMUDCgfQyo=K31igZZ+BgXyL6yfq1OG3r2CzQ4g@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAPhsuW5CMYiOMUDCgfQyo=K31igZZ+BgXyL6yfq1OG3r2CzQ4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2023/12/11 10:40, Song Liu wrote:
> On Sat, Dec 9, 2023 at 11:03 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2023/11/22 14:36, Akihiko Odaki wrote:
>>> On 2023/11/22 14:25, Song Liu wrote:
> [...]
>>
>> Now the discussion is stale again so let me summarize the discussion:
>>
>> A tuntap device can have an eBPF steering program to let the userspace
>> decide which tuntap queue should be used for each packet. QEMU uses this
>> feature to implement the RSS algorithm for virtio-net emulation. Now,
>> the virtio specification has a new feature to report hash values
>> calculated with the RSS algorithm. The goal of this RFC is to report
>> such hash values from the eBPF steering program to the userspace.
>>
>> There are currently three ideas to implement the proposal:
>>
>> 1. Abandon eBPF steering program and implement RSS in the kernel.
>>
>> It is possible to implement the RSS algorithm in the kernel as it's
>> strictly defined in the specification. However, there are proposals for
>> relevant virtio specification changes, and abandoning eBPF steering
>> program will loose the ability to implement those changes in the
>> userspace. There are concerns that this lead to more UAPI changes in the
>> end.
>>
>> 2. Add BPF kfuncs.
>>
>> Adding BPF kfuncs is *the* standard way to add BPF interfaces. hid-bpf
>> is a good reference for this.
>>
>> The problem with BPF kfuncs is that kfuncs are not considered as stable
>> as UAPI. In my understanding, it is not problematic for things like
>> hid-bpf because programs using those kfuncs affect the entire system
>> state and expected to be centrally managed. Such BPF programs can be
>> updated along with the kernel in a manner similar to kernel modules.
>>
>> The use case of tuntap steering/hash reporting is somewhat different
>> though; the eBPF program is more like a part of application (QEMU or
>> potentially other VMM) and thus needs to be portable. For example, a
>> user may expect a Debian container with QEMU installed to work on Fedora.
>>
>> BPF kfuncs do still provide some level of stability, but there is no
>> documentation that tell how stable they are. The worst case scenario I
>> can imagine is that a future legitimate BPF change breaks QEMU, letting
>> the "no regressions" rule force the change to be reverted. Some
>> assurance that kind scenario will not happen is necessary in my opinion.
> 
> I don't think we can provide stability guarantees before seeing something
> being used in the field. How do we know it will be useful forever? If a
> couple years later, there is only one person using it somewhere in the
> world, why should we keep supporting it? If there are millions of virtual
> machines using it, why would you worry about it being removed?

I have a different opinion about providing stability guarantees; I 
believe it is safe to provide such a guarantee without actual use in a 
field. We develop features expecting there are real uses, and if it 
turns out otherwise, we can break the stated guarantee since there is no 
real use cases anyway. It is fine even breaking UAPIs in such a case, 
which is stated in Documentation/admin-guide/reporting-regressions.rst.

So I rather feel easy about guaranteeing UAPI stability; we can just 
guarantee the UAPI-level stability for a particular kfunc and use it 
from QEMU expecting the stability. If the feature is found not useful, 
QEMU and the kernel can just remove it.

I'm more concerned about the other case, which means that there will be 
wide uses of this feature. A kernel developer may assume the stability 
of the interface is like one of kernel internal APIs 
(Documentation/bpf/kfuncs.rst says kfuncs are like EXPORT_SYMBOL_GPL) 
and decide to change it, breaking old QEMU binaries and that's something 
I would like to avoid.

Regarding the breakage scenario, I think we can avoid the kfuncs removal 
just by saying "we won't remove them". I'm more worried the case that a 
change in the BPF kfunc infrastucture requires to recompile the binary.

So, in short, I don't think we can say "kfuncs are like 
EXPORT_SYMBOL_GPL" and "you can freely use kfuncs in a normal userspace 
application like QEMU" at the same time.

> 
>>
>> 3. Add BPF program type derived from the conventional steering program type
>>
>> In principle, it's just to add a feature to report four more bytes to
>> the conventional steering program. However, BPF program types are frozen
>> for feature additions and the proposed change will break the feature freeze.
>>
>> So what's next? I'm inclined to option 3 due to its minimal ABI/API
>> change, but I'm also fine with option 2 if it is possible to guarantee
>> the ABI/API stability necessary to run pre-built QEMUs on future kernel
>> versions by e.g., explicitly stating the stability of kfuncs. If no
>> objection arises, I'll resend this series with the RFC prefix dropped
>> for upstream inclusion. If it's decided to go for option 1 or 2, I'll
>> post a new version of the series implementing the idea.
> 
> Probably a dumb question, but does this RFC fall into option 3? If
> that's the case, I seriously don't think it's gonna happen.

Yes, it's option 3.

> 
> I would recommend you give option 2 a try and share the code. This is
> probably the best way to move the discussion forward.

I'd like to add a documentation change to say the added kfuncs are 
exceptional cases that are not like EXPORT_SYMBOL_GPL in that case. Will 
it work?

Regards,
Akihiko Odaki

