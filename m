Return-Path: <linux-kselftest+bounces-1956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 456E28138DD
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 18:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18C0282AC4
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 17:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BA1675D4;
	Thu, 14 Dec 2023 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="HtpH4jdQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AF410E
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 09:40:45 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6cea0fd9b53so5409806b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 09:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1702575645; x=1703180445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H40nK5IpwIy9PQlp7QwxJH6+lSaRPIO031fd0w6k2mM=;
        b=HtpH4jdQ2kUP5QG5waUErTB6IWLsGrKrx4CbmWQVa43lgHvZxjD/UVJ/rpr3K2BCOb
         +3cuMjQzv9Dc/4jMMOZP02NcDKFMu9koKgzs7SzzGlLzt5kFuH/XyUI9nXGN1Zm2HjOq
         uYdoa6+E89rfKFTbOvyJzOnoPAAoR/3tOtfnyJWl24dw9G69nMUsE1xo+VVSKq8UtfOC
         JT0WM2F7WewNqAdBcpMExKgn0A4YQmBiSNoc1z7nQsaYdKfNYL39m9Pnvr2xiGZNIUJX
         ZNcuMdtDOffzl9Ca/ISyL30vRIdBD8YAKiR8PNTS/yXZelJWypowKiwqzKLzOXmDj3JP
         Iv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702575645; x=1703180445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H40nK5IpwIy9PQlp7QwxJH6+lSaRPIO031fd0w6k2mM=;
        b=hqow7+Vd39kCI5MRHyTCTYvF/SaklWvPC/ht7mag22eSBrpg89iUTOS4yKdw8NpL9G
         HiHTJybcREwrbKYzMmFHT09cBsLM3zbzi3OfpN04PKWVrZmeMwjl05RjHVpGXFy92etx
         sKLKXPsGvO+ZV9Ug67Uox1bWsWkkgYXtm8eJVaoJX0x2O9qwSYfFd8x0Oy458JoembRm
         Im+SgGup2h+374u1B2Ip7SdWTwODRSu0NoDq33AH2UNragX4QnzvuFzCn7D5RqEaCAQ6
         zjchSOzX35Lm+ThA5+UG0K7Is2N1ov7ZU9DQC8IG8/L+OYpB+ovNeogv8ZQgotXmRy5S
         oxpg==
X-Gm-Message-State: AOJu0YyFP3yB86oh+4p5lqSD+Is0GLkFBiltXITM6T/5Vpn70HLodTkC
	qdYITeshCYUWCx/aBTqGyqYb8Q==
X-Google-Smtp-Source: AGHT+IG7BgMGBuhTiCRVz5+mmRVftl5nKnTPsJ0urkZwVBwUIyjnJt5RfXGtkUUTbsy+ZMQJSeGPrg==
X-Received: by 2002:a05:6a00:1381:b0:6ce:fa6e:5781 with SMTP id t1-20020a056a00138100b006cefa6e5781mr6017348pfg.45.1702575645311;
        Thu, 14 Dec 2023 09:40:45 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id x26-20020a62fb1a000000b006ce48a0b7c6sm12066018pfm.109.2023.12.14.09.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 09:40:45 -0800 (PST)
Date: Thu, 14 Dec 2023 09:40:42 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Jason Wang <jasowang@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, John
 Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>, Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew
 Melnychenko <andrew@daynix.com>, Benjamin Tissoires <bentiss@kernel.org>,
 bpf <bpf@vger.kernel.org>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, kvm@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>
Subject: Re: Should I add BPF kfuncs for userspace apps? And how?
Message-ID: <20231214094042.75f704f6@hermes.local>
In-Reply-To: <0d68722c-9e29-407b-9ef0-331683c995d2@daynix.com>
References: <2f33be45-fe11-4b69-8e89-4d2824a0bf01@daynix.com>
	<CAO-hwJJhzHtKrUEw0zrjgub3+eapgJG-zsG0HRB=PaPi6BxG+w@mail.gmail.com>
	<e256c6df-0a66-4f86-ae96-bff17920c2fb@daynix.com>
	<CAO-hwJKMrWYRNpuprDj9=k87V0yHtLPEJuQ94bpOF3O81=v0kA@mail.gmail.com>
	<0d68722c-9e29-407b-9ef0-331683c995d2@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Dec 2023 14:51:12 +0900
Akihiko Odaki <akihiko.odaki@daynix.com> wrote:

> On 2023/12/13 19:22, Benjamin Tissoires wrote:
> > On Tue, Dec 12, 2023 at 1:41=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote: =20
> >>
> >> On 2023/12/12 19:39, Benjamin Tissoires wrote: =20
> >>> Hi,
> >>>
> >>> On Tue, Dec 12, 2023 at 9:11=E2=80=AFAM Akihiko Odaki <akihiko.odaki@=
daynix.com> wrote: =20
> >>>>
> >>>> Hi, =20
> >>
> >> Hi,
> >>
> >> Thanks for reply.
> >> =20
> >>>>
> >>>> It is said eBPF is a safe way to extend kernels and that is very
> >>>> attarctive, but we need to use kfuncs to add new usage of eBPF and
> >>>> kfuncs are said as unstable as EXPORT_SYMBOL_GPL. So now I'd like to=
 ask
> >>>> some questions:
> >>>>
> >>>> 1) Which should I choose, BPF kfuncs or ioctl, when adding a new fea=
ture
> >>>> for userspace apps?
> >>>> 2) How should I use BPF kfuncs from userspace apps if I add them?
> >>>>
> >>>> Here, a "userspace app" means something not like a system-wide daemon
> >>>> like systemd (particularly, I have QEMU in mind). I'll describe the
> >>>> context more below: =20
> >>>
> >>> I'm probably not the best person in the world to answer your
> >>> questions, Alexei and others from the BPF core group are, but given
> >>> that you pointed at a thread I was involved in, I feel I can give you
> >>> a few pointers.
> >>>
> >>> But first and foremost, I encourage you to schedule an agenda item in
> >>> the BPF office hour[4]. Being able to talk with the core people
> >>> directly was tremendously helpful to me to understand their point. =20
> >>
> >> I prefer emails because I'm not very fluent when speaking in English a=
nd
> >> may have a difficultly to listen to other people, but I may try it in
> >> future.
> >> =20
> >>>
> >>> =20
> >>>>
> >>>> ---
> >>>>
> >>>> I'm working on a new feature that aids virtio-net implementations us=
ing
> >>>> tuntap virtual network device. You can see [1] for details, but
> >>>> basically it's to extend BPF_PROG_TYPE_SOCKET_FILTER to report four =
more
> >>>> bytes.
> >>>>
> >>>> However, with long discussions we have confirmed extending
> >>>> BPF_PROG_TYPE_SOCKET_FILTER is not going to happen, and adding kfunc=
s is
> >>>> the way forward. So I decided how to add kfuncs to the kernel and ho=
w to
> >>>> use it. There are rich documentations for the kernel side, but I fou=
nd
> >>>> little about the userspace. The best I could find is a systemd change
> >>>> proposal that is based on WIP kernel changes[2]. =20
> >>>
> >>> Yes, as Alexei already replied, BPF is not adding new stable APIs,
> >>> only kfuncs. The reason being that once it's marked as stable, you
> >>> can't really remove it, even if you think it's badly designed and
> >>> useless.
> >>>
> >>> Kfuncs, OTOH are "unstable" by default meaning that the constraints
> >>> around it are more relaxed.
> >>>
> >>> However, "unstable" doesn't mean "unusable". It just means that the
> >>> kernel might or might not have the function when you load your program
> >>> in userspace. So you have to take that fact into account from day one,
> >>> both from the kernel side and the userspace side. The kernel docs have
> >>> a nice paragraph explaining that situation and makes the distinction
> >>> between relatively unused kfuncs, and well known established ones.
> >>>
> >>> Regarding the systemd discussion you are mentioning ([2]), this is
> >>> something that I have on my plate for a long time. I think I even
> >>> mentioned it to Alexei at Kernel Recipes this year, and he frowned his
> >>> eyebrows when I mentioned it. And looking at the systemd code and the
> >>> benefits over a plain ioctl, it is clearer that in that case, a plain
> >>> ioctl is better, mostly because we already know the API and the
> >>> semantic.
> >>>
> >>> A kfunc would be interesting in cases where you are not sure about the
> >>> overall design, and so you can give a shot at various API solutions
> >>> without having to keep your bad v1 design forever.
> >>> =20
> >>>>
> >>>> So now I'm wondering how I should use BPF kfuncs from userspace apps=
 if
> >>>> I add them. In the systemd discussion, it is told that Linus said it=
's
> >>>> fine to use BPF kfuncs in a private infrastructure big companies own=
, or
> >>>> in systemd as those users know well about the system[3]. Indeed, tho=
se
> >>>> users should be able to make more assumptions on the kernel than
> >>>> "normal" userspace applications can.
> >>>>
> >>>> Returning to my proposal, I'm proposing a new feature to be used by =
QEMU
> >>>> or other VMM applications. QEMU is more like a normal userspace
> >>>> application, and usually does not make much assumptions on the kerne=
l it
> >>>> runs on. For example, it's generally safe to run a Debian container
> >>>> including QEMU installed with apt on Fedora. BPF kfuncs may work eve=
n in
> >>>> such a situation thanks to CO-RE, but it sounds like *accidentally*
> >>>> creating UAPIs.
> >>>>
> >>>> Considering all above, how can I integrate BPF kfuncs to the applica=
tion? =20
> >>>
> >>> FWIW, I'm not sure you can rely on BPF calls from a container. There
> >>> is a high chance the syscall gets disabled by the runtime. =20
> >>
> >> Right. Container runtimes will not pass CAP_BPF by default, but that
> >> restriction can be lifted and I think that's a valid scenario.
> >> =20
> >>> =20
> >>>>
> >>>> If BPF kfuncs are like EXPORT_SYMBOL_GPL, the natural way to handle =
them
> >>>> is to think of BPF programs as some sort of kernel modules and
> >>>> incorporate logic that behaves like modprobe. More concretely, I can=
 put
> >>>> eBPF binaries to a directory like:
> >>>> /usr/local/share/qemu/ebpf/$KERNEL_RELEASE =20
> >>>
> >>> I would advise against that (one program per kernel release). Simply
> >>> because your kfunc may or may not have been backported to kernel
> >>> release v6.X.Y+1 while it was not there when v6.X.Y was out. So
> >>> relying on the kernel number is just going to be a headache.
> >>>
> >>> As I understand it, the way forward is to rely on the kernel, libbpf
> >>> and CO-RE: if the function is not available, the program will simply
> >>> not load, and you'll know that this version of the code is not
> >>> available (or has changed API).
> >>>
> >>> So what I would do if some kfunc API is becoming deprecated, is
> >>> embedding both code paths in the same BPF unit, but marking them as
> >>> not loaded by libppf. Then I can load the compilation unit, try v2 of
> >>> the API, and if it's not available, try v1, and if not, then mention
> >>> that I can not rely on BPF. Of course, this can also be done with
> >>> separate compilation units. =20
> >>
> >> Doesn't it mean that the kernel is free to break old versions of QEMU
> >> including BPF programs? That's something I'd like to avoid. =20
> >=20
> > Couple of points here:
> > - when you say "the kernel", it feels like you are talking about an
> > external actor tampering with your code. But if you submit a kernel
> > patch with a specific use case and get yourself involved in the
> > community, why would anybody change your kfunc API without you knowing
> > it? =20
>=20
> You are right in the practical aspect.  I can pay efforts to keep kfunc=20
> APIs alive and I'm also sure other developers would also try not to=20
> break them for good.
>=20
> Nevertheless I'm being careful to evaluate APIs from both of the kernel=20
> and userspace (QEMU) viewpoints. If I fail to keep kfuncs stable because=
=20
> I die in an accident, for example, it's a poor excuse for other QEMU=20
> developers that I intended to keep them stable with my personal effort.
>=20
> > - the whole warning about "unstable" policy means that the user space
> > component should not take for granted the capability. So if the kfunc
> > changes/disappears for good reasons (because it was marked as well
> > used and deprecated for quite some time), qemu should not *break*, it
> > should not provide the functionality, or have a secondary plan.
> >=20
> > But even if you are encountering such issues, in case of a change in
> > the ABI of your kfunc, it should be easy enough to backport the bpf
> > changes to your old QEMUs and ask users to upgrade the user space if
> > they upgrade their kernel.
> >=20
> > AFAIU, it is as unstable as you want it to be. It's just that we are
> > not in the "we don't break user space" contract, because we are
> > talking about adding a kernel functionality from userspace, which
> > requires knowing the kernel intrinsics. =20
>=20
> I must admit I'm still not convinced the proposed BPF program=20
> functionality needs to know internals of the kernel.
>=20
> The eBPF program QEMU carries is just to calculate hashes from packets.=20
> It doesn't need to know the details of how the kernel handles packets.=20
> It only needs to have an access to the packet content.
>=20
> It is exactly what BPF_PROG_TYPE_SOCKET_FILTER does, but it lacks a=20
> mechanism to report hash values so I need to extend it or invent a new=20
> method. Extending BPF_PROG_TYPE_SOCKET_FILTER is not a way forward since=
=20
> CO-RE is superior to the context rewrite it relies on. But apparently=20
> adopting kfuncs and CO-RE also means to lose the "we don't break user=20
> space" contract although I have no intention to expose kernel internals=20
> to the eBPF program.

An example is how one part of DPDK recomputes RSS over TAP.

https://git.dpdk.org/dpdk/tree/drivers/net/tap/bpf/tap_bpf_program.c

This feature is likely to be removed, because it is not actively used
and the changes in BPF program loading broke it on current kernel
releases.  Which brings up the point that since the kernel does
not have stable API/ABI for BPF program infrastructure, I would
avoid it for projects that don't want to deal with that.

