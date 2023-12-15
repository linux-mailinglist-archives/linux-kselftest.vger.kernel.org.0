Return-Path: <linux-kselftest+bounces-2001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C128814185
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 06:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9DD1F20FE2
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 05:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17969CA7C;
	Fri, 15 Dec 2023 05:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="lRG3mKWA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0887D6AD9
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Dec 2023 05:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3b9f8c9307dso329550b6e.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 21:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702619404; x=1703224204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xFKDorqrFC5bosM2lt/mDyJdprik2aA7TxjdYt0y1e4=;
        b=lRG3mKWA3hLhxbJ++HHf2NQEw8lqXc4lAMsww+H2XM0tm7saisSRA+cLHbbE8/UDme
         I+pd4IgdOJS51g9TaOsFo9DSUB1r1GPlU01PsitywapE+hKrxLQQL+q3VLcvpdAkp/we
         v1jCBTl22HwIyhlBAvTLS5nfoCRqbCawuHUwNsOCeTT70UGUS1dl1pzIbeLUbo9iWDeW
         U+lsTWy8I4z+1tfJYsac0MfM6wVmihVEHvFb6eNNfgqX3V8LymQ86PNGJjQV6KLRHvJS
         +stmpcKGsrnM7ow/47GQHGZnjCEKU50wCskwqDxRPUIIq96wxE00q46nWVzTl/Nf6jMs
         eBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702619404; x=1703224204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xFKDorqrFC5bosM2lt/mDyJdprik2aA7TxjdYt0y1e4=;
        b=f6qF30dkAwdHjcUq0Fcr6QI+5YSAn6yZskQbx5aEF2fw0tFcbXwG9YHEJ/oCBT7N5w
         AHL2Yt2qzvaLQq41NXoLU4pjNwEdTyoEDTmeFKQLY4C/Z8J+gE9lQaiQHmRV2clAjxvu
         RvLmDC+AoXr5eYFPUtV4Bn/y6HYNoYB3Yl87UbyRk7HE/SEfQ28gNZkBtaN7/qN8N3I3
         04uST7Ej7SBatzfrN6qdg5p4XE7wabZJ4z4OJVvojZUUEFUcKUhdIB0ia4AfM6jnTNNr
         C88SyGRPiuRdJkVj/qisoAvBgvk/QEyWbP4ocG5Ww8IOmRdnHNJhmlJ2/uUr5OFWKfdd
         8wHg==
X-Gm-Message-State: AOJu0Yw9EQRwQDL/ylkGnZZPRur7nQumJ99/QbhevVK8CnCB7Syi+0wU
	zqSZMWbYLuDM/0T4+/VSA8I/6g==
X-Google-Smtp-Source: AGHT+IGx2R7EsZiNCgpjAWLFVnSbXZ01T55zLVZoewTO79uTMzNCSJGSk/7hhmSoBW352drVsZLTPg==
X-Received: by 2002:a05:6808:16a3:b0:3b9:e7e2:f30 with SMTP id bb35-20020a05680816a300b003b9e7e20f30mr13382782oib.7.1702619403985;
        Thu, 14 Dec 2023 21:50:03 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902bd8500b001c9d011581dsm13310686pls.164.2023.12.14.21.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 21:50:03 -0800 (PST)
Message-ID: <72b8e198-7058-469a-a1e0-17f48330deca@daynix.com>
Date: Fri, 15 Dec 2023 14:49:56 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should I add BPF kfuncs for userspace apps? And how?
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231214094042.75f704f6@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/12/15 2:40, Stephen Hemminger wrote:
> On Thu, 14 Dec 2023 14:51:12 +0900
> Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> 
>> On 2023/12/13 19:22, Benjamin Tissoires wrote:
>>> On Tue, Dec 12, 2023 at 1:41 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2023/12/12 19:39, Benjamin Tissoires wrote:
>>>>> Hi,
>>>>>
>>>>> On Tue, Dec 12, 2023 at 9:11 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> Hi,
>>>>
>>>> Hi,
>>>>
>>>> Thanks for reply.
>>>>   
>>>>>>
>>>>>> It is said eBPF is a safe way to extend kernels and that is very
>>>>>> attarctive, but we need to use kfuncs to add new usage of eBPF and
>>>>>> kfuncs are said as unstable as EXPORT_SYMBOL_GPL. So now I'd like to ask
>>>>>> some questions:
>>>>>>
>>>>>> 1) Which should I choose, BPF kfuncs or ioctl, when adding a new feature
>>>>>> for userspace apps?
>>>>>> 2) How should I use BPF kfuncs from userspace apps if I add them?
>>>>>>
>>>>>> Here, a "userspace app" means something not like a system-wide daemon
>>>>>> like systemd (particularly, I have QEMU in mind). I'll describe the
>>>>>> context more below:
>>>>>
>>>>> I'm probably not the best person in the world to answer your
>>>>> questions, Alexei and others from the BPF core group are, but given
>>>>> that you pointed at a thread I was involved in, I feel I can give you
>>>>> a few pointers.
>>>>>
>>>>> But first and foremost, I encourage you to schedule an agenda item in
>>>>> the BPF office hour[4]. Being able to talk with the core people
>>>>> directly was tremendously helpful to me to understand their point.
>>>>
>>>> I prefer emails because I'm not very fluent when speaking in English and
>>>> may have a difficultly to listen to other people, but I may try it in
>>>> future.
>>>>   
>>>>>
>>>>>   
>>>>>>
>>>>>> ---
>>>>>>
>>>>>> I'm working on a new feature that aids virtio-net implementations using
>>>>>> tuntap virtual network device. You can see [1] for details, but
>>>>>> basically it's to extend BPF_PROG_TYPE_SOCKET_FILTER to report four more
>>>>>> bytes.
>>>>>>
>>>>>> However, with long discussions we have confirmed extending
>>>>>> BPF_PROG_TYPE_SOCKET_FILTER is not going to happen, and adding kfuncs is
>>>>>> the way forward. So I decided how to add kfuncs to the kernel and how to
>>>>>> use it. There are rich documentations for the kernel side, but I found
>>>>>> little about the userspace. The best I could find is a systemd change
>>>>>> proposal that is based on WIP kernel changes[2].
>>>>>
>>>>> Yes, as Alexei already replied, BPF is not adding new stable APIs,
>>>>> only kfuncs. The reason being that once it's marked as stable, you
>>>>> can't really remove it, even if you think it's badly designed and
>>>>> useless.
>>>>>
>>>>> Kfuncs, OTOH are "unstable" by default meaning that the constraints
>>>>> around it are more relaxed.
>>>>>
>>>>> However, "unstable" doesn't mean "unusable". It just means that the
>>>>> kernel might or might not have the function when you load your program
>>>>> in userspace. So you have to take that fact into account from day one,
>>>>> both from the kernel side and the userspace side. The kernel docs have
>>>>> a nice paragraph explaining that situation and makes the distinction
>>>>> between relatively unused kfuncs, and well known established ones.
>>>>>
>>>>> Regarding the systemd discussion you are mentioning ([2]), this is
>>>>> something that I have on my plate for a long time. I think I even
>>>>> mentioned it to Alexei at Kernel Recipes this year, and he frowned his
>>>>> eyebrows when I mentioned it. And looking at the systemd code and the
>>>>> benefits over a plain ioctl, it is clearer that in that case, a plain
>>>>> ioctl is better, mostly because we already know the API and the
>>>>> semantic.
>>>>>
>>>>> A kfunc would be interesting in cases where you are not sure about the
>>>>> overall design, and so you can give a shot at various API solutions
>>>>> without having to keep your bad v1 design forever.
>>>>>   
>>>>>>
>>>>>> So now I'm wondering how I should use BPF kfuncs from userspace apps if
>>>>>> I add them. In the systemd discussion, it is told that Linus said it's
>>>>>> fine to use BPF kfuncs in a private infrastructure big companies own, or
>>>>>> in systemd as those users know well about the system[3]. Indeed, those
>>>>>> users should be able to make more assumptions on the kernel than
>>>>>> "normal" userspace applications can.
>>>>>>
>>>>>> Returning to my proposal, I'm proposing a new feature to be used by QEMU
>>>>>> or other VMM applications. QEMU is more like a normal userspace
>>>>>> application, and usually does not make much assumptions on the kernel it
>>>>>> runs on. For example, it's generally safe to run a Debian container
>>>>>> including QEMU installed with apt on Fedora. BPF kfuncs may work even in
>>>>>> such a situation thanks to CO-RE, but it sounds like *accidentally*
>>>>>> creating UAPIs.
>>>>>>
>>>>>> Considering all above, how can I integrate BPF kfuncs to the application?
>>>>>
>>>>> FWIW, I'm not sure you can rely on BPF calls from a container. There
>>>>> is a high chance the syscall gets disabled by the runtime.
>>>>
>>>> Right. Container runtimes will not pass CAP_BPF by default, but that
>>>> restriction can be lifted and I think that's a valid scenario.
>>>>   
>>>>>   
>>>>>>
>>>>>> If BPF kfuncs are like EXPORT_SYMBOL_GPL, the natural way to handle them
>>>>>> is to think of BPF programs as some sort of kernel modules and
>>>>>> incorporate logic that behaves like modprobe. More concretely, I can put
>>>>>> eBPF binaries to a directory like:
>>>>>> /usr/local/share/qemu/ebpf/$KERNEL_RELEASE
>>>>>
>>>>> I would advise against that (one program per kernel release). Simply
>>>>> because your kfunc may or may not have been backported to kernel
>>>>> release v6.X.Y+1 while it was not there when v6.X.Y was out. So
>>>>> relying on the kernel number is just going to be a headache.
>>>>>
>>>>> As I understand it, the way forward is to rely on the kernel, libbpf
>>>>> and CO-RE: if the function is not available, the program will simply
>>>>> not load, and you'll know that this version of the code is not
>>>>> available (or has changed API).
>>>>>
>>>>> So what I would do if some kfunc API is becoming deprecated, is
>>>>> embedding both code paths in the same BPF unit, but marking them as
>>>>> not loaded by libppf. Then I can load the compilation unit, try v2 of
>>>>> the API, and if it's not available, try v1, and if not, then mention
>>>>> that I can not rely on BPF. Of course, this can also be done with
>>>>> separate compilation units.
>>>>
>>>> Doesn't it mean that the kernel is free to break old versions of QEMU
>>>> including BPF programs? That's something I'd like to avoid.
>>>
>>> Couple of points here:
>>> - when you say "the kernel", it feels like you are talking about an
>>> external actor tampering with your code. But if you submit a kernel
>>> patch with a specific use case and get yourself involved in the
>>> community, why would anybody change your kfunc API without you knowing
>>> it?
>>
>> You are right in the practical aspect.  I can pay efforts to keep kfunc
>> APIs alive and I'm also sure other developers would also try not to
>> break them for good.
>>
>> Nevertheless I'm being careful to evaluate APIs from both of the kernel
>> and userspace (QEMU) viewpoints. If I fail to keep kfuncs stable because
>> I die in an accident, for example, it's a poor excuse for other QEMU
>> developers that I intended to keep them stable with my personal effort.
>>
>>> - the whole warning about "unstable" policy means that the user space
>>> component should not take for granted the capability. So if the kfunc
>>> changes/disappears for good reasons (because it was marked as well
>>> used and deprecated for quite some time), qemu should not *break*, it
>>> should not provide the functionality, or have a secondary plan.
>>>
>>> But even if you are encountering such issues, in case of a change in
>>> the ABI of your kfunc, it should be easy enough to backport the bpf
>>> changes to your old QEMUs and ask users to upgrade the user space if
>>> they upgrade their kernel.
>>>
>>> AFAIU, it is as unstable as you want it to be. It's just that we are
>>> not in the "we don't break user space" contract, because we are
>>> talking about adding a kernel functionality from userspace, which
>>> requires knowing the kernel intrinsics.
>>
>> I must admit I'm still not convinced the proposed BPF program
>> functionality needs to know internals of the kernel.
>>
>> The eBPF program QEMU carries is just to calculate hashes from packets.
>> It doesn't need to know the details of how the kernel handles packets.
>> It only needs to have an access to the packet content.
>>
>> It is exactly what BPF_PROG_TYPE_SOCKET_FILTER does, but it lacks a
>> mechanism to report hash values so I need to extend it or invent a new
>> method. Extending BPF_PROG_TYPE_SOCKET_FILTER is not a way forward since
>> CO-RE is superior to the context rewrite it relies on. But apparently
>> adopting kfuncs and CO-RE also means to lose the "we don't break user
>> space" contract although I have no intention to expose kernel internals
>> to the eBPF program.
> 
> An example is how one part of DPDK recomputes RSS over TAP.
> 
> https://git.dpdk.org/dpdk/tree/drivers/net/tap/bpf/tap_bpf_program.c
> 
> This feature is likely to be removed, because it is not actively used
> and the changes in BPF program loading broke it on current kernel
> releases.  Which brings up the point that since the kernel does
> not have stable API/ABI for BPF program infrastructure, I would
> avoid it for projects that don't want to deal with that.

It's unfortunate to hear that, but thanks for the information.
I'll consider more about the option not using BPF (plain ioctl and 
in-kernel implementation).

