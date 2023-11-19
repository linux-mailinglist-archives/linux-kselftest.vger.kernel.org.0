Return-Path: <linux-kselftest+bounces-279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2378B7F090B
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Nov 2023 22:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4899280D34
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Nov 2023 21:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4325012E46;
	Sun, 19 Nov 2023 21:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZpuU0td"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EC912B7C;
	Sun, 19 Nov 2023 21:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57949C433C9;
	Sun, 19 Nov 2023 21:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700427767;
	bh=LdCcDCVibEq9XtMPBRAazcWyb1lUm4YRH93xkKpOHbM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FZpuU0tdRMVqNc17EPw2Yx+O61k7X2a1HFa5dIdI0JeSJbPg+OayhEf8qOUGAqiy3
	 t65XUeKw8Z935Y5auUU0WejjqnKGgNlEp1OxFv3e2uEtZJlCjgkEV4oIU6FCpC7Ovs
	 QRuW5N2zde8PrWeKWO39XMJLMQysUEvMBI4N3XDwn/odf4AVo7ewp/Cj5zp56782Vv
	 uXEpEyQ8f4mV+dC1VwB33IAfg95hhwshydjYwfaxW2yJAJlvzXqSkLtHWFHq0EA08i
	 vATgFTBKZotJ6LQY5zo+mmwR81AvAOd4c8JUF5epck+DjCpD4r8DMoNr8uQmKeXBP9
	 R07melvoUfkSw==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2c509d5ab43so51544441fa.0;
        Sun, 19 Nov 2023 13:02:47 -0800 (PST)
X-Gm-Message-State: AOJu0YwGj2mEpQ+m6A257C8NBKjue25jd2UZAbsg8QKSN2rN22yUTpG2
	j67ehwwO4XcsCuSfDiuSEysnjYvWqgn36Y8IvOQ=
X-Google-Smtp-Source: AGHT+IFyYOQHQnx0Par61ni3D+IsRVTlNd6D9SKI0apNaeY6hc8EhMaBYVtDLvZWr7jIRh/7uxjcLeqDv60Mo+HqTn0=
X-Received: by 2002:a2e:9656:0:b0:2be:54b4:ff90 with SMTP id
 z22-20020a2e9656000000b002be54b4ff90mr2814616ljh.53.1700427765530; Sun, 19
 Nov 2023 13:02:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231015141644.260646-1-akihiko.odaki@daynix.com>
 <20231015141644.260646-2-akihiko.odaki@daynix.com> <CAADnVQLfUDmgYng8Cw1hiZOMfWNWLjbn7ZGc4yOEz-XmeFEz5Q@mail.gmail.com>
 <2594bb24-74dc-4785-b46d-e1bffcc3e7ed@daynix.com> <CAADnVQ+J+bOtvEfdvgUse_Rr07rM5KOZ5DtAmHDgRmi70W68+g@mail.gmail.com>
 <CACGkMEs22078F7rSLEz6eQabkZZ=kujSONUNMThZz5Gp=YiidQ@mail.gmail.com>
 <CAADnVQLt8NWvP8qGWMPx=12PwWWE69P7aS2dbm=khAJkCnJEoQ@mail.gmail.com>
 <9a4853ad-5ef4-4b15-a49e-9edb5ae4468e@daynix.com> <6253fb6b-9a53-484a-9be5-8facd46c051e@daynix.com>
 <CAPhsuW5JYoM-Mkehdy=FQsG1nvjbYGzwRZx8BkpG1P7cHdD=eQ@mail.gmail.com> <dba89d4b-84aa-4c9f-b016-56fd3ade04b2@daynix.com>
In-Reply-To: <dba89d4b-84aa-4c9f-b016-56fd3ade04b2@daynix.com>
From: Song Liu <song@kernel.org>
Date: Sun, 19 Nov 2023 13:02:33 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5KLgt_gsih7zi+T99iYVbt7hk7=OCwYzin-H3=OhF54Q@mail.gmail.com>
Message-ID: <CAPhsuW5KLgt_gsih7zi+T99iYVbt7hk7=OCwYzin-H3=OhF54Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/7] bpf: Introduce BPF_PROG_TYPE_VNET_HASH
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jason Wang <jasowang@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2023 at 12:03=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
[...]
>
> Unfortunately no. The communication with the userspace can be done with
> two different means:
> - usual socket read/write
> - vhost for direct interaction with a KVM guest
>
> The BPF map may be a valid option for socket read/write, but it is not
> for vhost. In-kernel vhost may fetch hash from the BPF map, but I guess
> it's not a standard way to have an interaction between the kernel code
> and a BPF program.

I am very new to areas like vhost and KVM. So I don't really follow.
Does this mean we have the guest kernel reading data from host eBPF
programs (loaded by Qemu)?

> >
> >>
> >> Unfortunately, however, it is not acceptable for the BPF subsystem
> >> because the "stable" BPF is completely fixed these days. The
> >> "unstable/kfunc" BPF is an alternative, but the eBPF program will be
> >> shipped with a portable userspace program (QEMU)[1] so the lack of
> >> interface stability is not tolerable.
> >
> > bpf kfuncs are as stable as exported symbols. Is exported symbols
> > like stability enough for the use case? (I would assume yes.)
> >
> >>
> >> Another option is to hardcode the algorithm that was conventionally
> >> implemented with eBPF steering program in the kernel[2]. It is possibl=
e
> >> because the algorithm strictly follows the virtio-net specification[3]=
.
> >> However, there are proposals to add different algorithms to the
> >> specification[4], and hardcoding the algorithm to the kernel will
> >> require to add more UAPIs and code each time such a specification chan=
ge
> >> happens, which is not good for tuntap.
> >
> > The requirement looks similar to hid-bpf. Could you explain why that
> > model is not enough? HID also requires some stability AFAICT.
>
> I have little knowledge with hid-bpf, but I assume it is more like a
> "safe" kernel module; in my understanding, it affects the system state
> and is intended to be loaded with some kind of a system daemon. It is
> fine to have the same lifecycle with the kernel for such a BPF program;
> whenever the kernel is updated, the distributor can recompile the BPF
> program with the new kernel headers and ship it along with the kernel
> just as like a kernel module.
>
> In contrast, our intended use case is more like a normal application.
> So, for example, a user may download a container and run QEMU (including
> the BPF program) installed in the container. As such, it is nice if the
> ABI is stable across kernel releases, but it is not guaranteed for
> kfuncs. Such a use case is already covered with the eBPF steering
> program so I want to maintain it if possible.

TBH, I don't think stability should be a concern for kfuncs used by QEMU.
Many core BPF APIs are now implemented as kfuncs: bpf_dynptr_*,
bpf_rcu_*, etc. As long as there are valid use cases,these kfuncs will
be supported.

Thanks,
Song

