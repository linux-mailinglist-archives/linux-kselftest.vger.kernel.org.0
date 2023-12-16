Return-Path: <linux-kselftest+bounces-2100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F198815860
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Dec 2023 09:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A324A1C24AF5
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Dec 2023 08:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F303134C0;
	Sat, 16 Dec 2023 08:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="fSQlZQCi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D700B13FF3
	for <linux-kselftest@vger.kernel.org>; Sat, 16 Dec 2023 08:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6cebbf51742so1054875b3a.1
        for <linux-kselftest@vger.kernel.org>; Sat, 16 Dec 2023 00:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702714547; x=1703319347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j34U3DbBJyUmmhCTSIWekoWpOW5ZdWSwa2YWU4yaUK4=;
        b=fSQlZQCinU0xlc/C7XkWiMFc/n4JnuL0J2BMpN1y8kLXwcdhoph+AlxWeMItVAImiE
         jM6ABIHhQDEgvbUyrzd0X86wCICqDW0QvnwDyNVUmlW8ad0NDZMuENaA94eOpf7oizEP
         bDYoM5g04sXrYq6RBCcofqg0ond+33l5i0vzg/PGAo3DUXZcGUqXEDVCqO6Cs2Cgyd+8
         3XZ+Sn2e9+MB3nRsl1LetszqffjwE/g4YMF7OH5tJCqwkugzCAmwj2hA3oZYRVc8jb3y
         hGh6UPJHOvtpum9xUHMXBH80bGdJWsu/fBlT2pXpcPZS2i1YXetEGlN4ZOnLjFpAJrP4
         FKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702714547; x=1703319347;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j34U3DbBJyUmmhCTSIWekoWpOW5ZdWSwa2YWU4yaUK4=;
        b=i9gxlsuFIN6euYweyg6fxt8U5cqttFj+m6RPPldw6lVoln7WymZdeAC987OiYV9Q5W
         iqRTGPgndGmkt/qXJw1JaGRyYi2lI7aqFK2A/xUCWOf98N8BF4MWoM5S/UX7q53fZnPY
         Jlr9enQ6gyoIpCYOONReMYMQv8SUdY95wlqUxFyJknDSc42nVU3Nruk/iSAHB6CSCaGP
         VVvMGt7RSfuPGZft1YtQ2eGCt2at8tOQLXbmyap9zQC2td0PevJAGPHlPyD/MBYRFjgF
         TiOrKsFK2Mj72o7dYTzaF1BFua4zXOL5sl+E3k9wVuVdvNWaBPyWUp0LV2HtA0+eBqxV
         tzoA==
X-Gm-Message-State: AOJu0YzyIUVkTcJxq9pp5VXVeY2Q/YdzwfkXXzHAGisvFpRacFe04oes
	bFjMaznq6A4dcHN0vMJP2o9R+A==
X-Google-Smtp-Source: AGHT+IEeuPfCOabIrvg0uS3E2YqqLjNkgjJjHCcIA2x49ExvIgKwxCgYmGKVjZEUpfIORWU2Bd9Yug==
X-Received: by 2002:a05:6a00:198b:b0:6ce:78c9:5979 with SMTP id d11-20020a056a00198b00b006ce78c95979mr17324911pfl.18.1702714547181;
        Sat, 16 Dec 2023 00:15:47 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
        by smtp.gmail.com with ESMTPSA id p18-20020a056a000b5200b006ce835b77d9sm14707733pfo.20.2023.12.16.00.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 00:15:46 -0800 (PST)
Message-ID: <11507101-ca4f-486d-9fb8-a5d4de0b1b85@daynix.com>
Date: Sat, 16 Dec 2023 17:15:39 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should I add BPF kfuncs for userspace apps? And how?
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
 Shuah Khan <shuah@kernel.org>, Yuri Benditovich
 <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>,
 Benjamin Tissoires <bentiss@kernel.org>, bpf <bpf@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, kvm@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>
References: <2f33be45-fe11-4b69-8e89-4d2824a0bf01@daynix.com>
 <CAO-hwJJhzHtKrUEw0zrjgub3+eapgJG-zsG0HRB=PaPi6BxG+w@mail.gmail.com>
 <e256c6df-0a66-4f86-ae96-bff17920c2fb@daynix.com>
 <CAO-hwJKMrWYRNpuprDj9=k87V0yHtLPEJuQ94bpOF3O81=v0kA@mail.gmail.com>
 <0d68722c-9e29-407b-9ef0-331683c995d2@daynix.com>
 <20231214094042.75f704f6@hermes.local>
 <72b8e198-7058-469a-a1e0-17f48330deca@daynix.com>
 <20231215083644.4dd9a323@hermes.local>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231215083644.4dd9a323@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/12/16 1:36, Stephen Hemminger wrote:
> On Fri, 15 Dec 2023 14:49:56 +0900
> Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> 
>>>> It is exactly what BPF_PROG_TYPE_SOCKET_FILTER does, but it lacks a
>>>> mechanism to report hash values so I need to extend it or invent a new
>>>> method. Extending BPF_PROG_TYPE_SOCKET_FILTER is not a way forward since
>>>> CO-RE is superior to the context rewrite it relies on. But apparently
>>>> adopting kfuncs and CO-RE also means to lose the "we don't break user
>>>> space" contract although I have no intention to expose kernel internals
>>>> to the eBPF program.
>>>
>>> An example is how one part of DPDK recomputes RSS over TAP.
>>>
>>> https://git.dpdk.org/dpdk/tree/drivers/net/tap/bpf/tap_bpf_program.c
>>>
>>> This feature is likely to be removed, because it is not actively used
>>> and the changes in BPF program loading broke it on current kernel
>>> releases.  Which brings up the point that since the kernel does
>>> not have stable API/ABI for BPF program infrastructure, I would
>>> avoid it for projects that don't want to deal with that.
>>
>> It's unfortunate to hear that, but thanks for the information.
>> I'll consider more about the option not using BPF (plain ioctl and
>> in-kernel implementation).
> 
> With libbpf, things are much better. It is just that projects like
> DPDK have to support wide range of kernels including older versions of RHEL.

I have checked DPDK documentation. It says it supports the oldest LTS 
kernel:
https://doc.dpdk.org/guides/linux_gsg/sys_reqs.html#system-software

My use case is QEMU, which has much more relaxed compatibility 
requirement that refers to recent distribution versions instead of LTS 
kernels:
https://qemu.readthedocs.io/en/v8.1.0/about/build-platforms.html

That said, I'm not really concerned about the case running QEMU on older 
kernels. QEMU developers can just pay extra efforts to support those old 
kernels if necessary.

The more concerning scenario is that a newer kernel breaks compatibility 
with older QEMU versions; such a scenario has not been considered before 
AFAIK.

QEMU already uses libbpf to load a BPF_PROG_TYPE_SOCKET_FILTER program.

