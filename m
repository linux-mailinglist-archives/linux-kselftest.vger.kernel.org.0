Return-Path: <linux-kselftest+bounces-264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A807F00D3
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Nov 2023 17:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C4061C2095D
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Nov 2023 16:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9006918E37;
	Sat, 18 Nov 2023 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZbW/M05"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5667F13AC0;
	Sat, 18 Nov 2023 16:08:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBF9C433AB;
	Sat, 18 Nov 2023 16:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700323716;
	bh=Rsnqi1ib4EvnXINLKabP7yw4uoi1oK5ej3itZD7VvwE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TZbW/M05LVwPMqWrhx9TKrKAmJhZWl5oGZokrp6Yk372oMK1SWeer8oqfOmkHhrWR
	 Pb874z3lvuDQZyHxPY2FY1wz7XLr/nN7jQE5/GtXNhXPnEL13OHtq4LroScNw8G5vO
	 bLDR+6HkW8reckqHCtvI3Pn91dQnI265wfRhp9e7lXQbPrAARLBJ4bfAqpckWpPwWO
	 /0VuVGXKvO9UrKAj9FoErIVwTYmCUzjiygrMSQywP4P5omdSn+aGf5jmw+s9Ht631A
	 OBnb7j4QKGmaaRPJyjREAq0DGcs9gkxdmbTyk+3BT0j3jVKMKWUNzJHErY2T7gQTeS
	 fxws+iP0PAm4g==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2c50fbc218bso38535361fa.3;
        Sat, 18 Nov 2023 08:08:36 -0800 (PST)
X-Gm-Message-State: AOJu0YzwUWut7Z59kc5r581WyDwIwVAzMwFTclmRQtvfZGs97orBpdeX
	p022IRuHtrQfDQwOWPV8nEH5uMSrnSs4VkBzZkg=
X-Google-Smtp-Source: AGHT+IG+EcBo0sANe4tTYtYM/fJV1YsiGyWzUxPjCVXnMZoFkdXUA3+0TtwXrE30/Pq6G+Dt5ITe1U4wqTtWliRSTrM=
X-Received: by 2002:a2e:97c8:0:b0:2c8:6f66:27a7 with SMTP id
 m8-20020a2e97c8000000b002c86f6627a7mr2087546ljj.23.1700323714932; Sat, 18 Nov
 2023 08:08:34 -0800 (PST)
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
In-Reply-To: <6253fb6b-9a53-484a-9be5-8facd46c051e@daynix.com>
From: Song Liu <song@kernel.org>
Date: Sat, 18 Nov 2023 08:08:22 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5JYoM-Mkehdy=FQsG1nvjbYGzwRZx8BkpG1P7cHdD=eQ@mail.gmail.com>
Message-ID: <CAPhsuW5JYoM-Mkehdy=FQsG1nvjbYGzwRZx8BkpG1P7cHdD=eQ@mail.gmail.com>
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

Hi,

A few rookie questions below.

On Sat, Nov 18, 2023 at 2:39=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2023/10/18 4:19, Akihiko Odaki wrote:
> > On 2023/10/18 4:03, Alexei Starovoitov wrote:
[...]
> >
> > I would also appreciate if you have some documentation or link to
> > relevant discussions on the mailing list. That will avoid having same
> > discussion you may already have done in the past.
>
> Hi,
>
> The discussion has been stuck for a month, but I'd still like to
> continue figuring out the way best for the whole kernel to implement
> this feature. I summarize the current situation and question that needs
> to be answered before push this forward:
>
> The goal of this RFC is to allow to report hash values calculated with
> eBPF steering program. It's essentially just to report 4 bytes from the
> kernel to the userspace.

AFAICT, the proposed design is to have BPF generate some data
(namely hash, but could be anything afaict) and consume it from
user space. Instead of updating __sk_buff, can we have the user
space to fetch the data/hash from a bpf map? If this is an option,
I guess we can implement the same feature with BPF tracing
programs?

>
> Unfortunately, however, it is not acceptable for the BPF subsystem
> because the "stable" BPF is completely fixed these days. The
> "unstable/kfunc" BPF is an alternative, but the eBPF program will be
> shipped with a portable userspace program (QEMU)[1] so the lack of
> interface stability is not tolerable.

bpf kfuncs are as stable as exported symbols. Is exported symbols
like stability enough for the use case? (I would assume yes.)

>
> Another option is to hardcode the algorithm that was conventionally
> implemented with eBPF steering program in the kernel[2]. It is possible
> because the algorithm strictly follows the virtio-net specification[3].
> However, there are proposals to add different algorithms to the
> specification[4], and hardcoding the algorithm to the kernel will
> require to add more UAPIs and code each time such a specification change
> happens, which is not good for tuntap.

The requirement looks similar to hid-bpf. Could you explain why that
model is not enough? HID also requires some stability AFAICT.

Thanks,
Song

>
> In short, the proposed feature requires to make either of three compromis=
es:
>
> 1. Compromise on the BPF side: Relax the "stable" BPF feature freeze
> once and allow eBPF steering program to report 4 more bytes to the kernel=
.
>
> 2. Compromise on the tuntap side: Implement the algorithm to the kernel,
> and abandon the capability to update the algorithm without changing the
> kernel.
>
> IMHO, I think it's better to make a compromise on the BPF side (option
> 1). We should minimize the total UAPI changes in the whole kernel, and
> option 1 is much superior in that sense.
>
> Yet I have to note that such a compromise on the BPF side can risk the
> "stable" BPF feature freeze fragile and let other people complain like
> "you allowed to change stable BPF for this, why do you reject [some
> other request to change stable BPF]?" It is bad for BPF maintainers. (I
> can imagine that introducing and maintaining widely different BPF
> interfaces is too much burden.) And, of course, this requires an
> approval from BPF maintainers.
>
> So I'd like to ask you that which of these compromises you think worse.
> Please also tell me if you have another idea.
>
> Regards,
> Akihiko Odaki
>
> [1] https://qemu.readthedocs.io/en/v8.1.0/devel/ebpf_rss.html
> [2]
> https://lore.kernel.org/all/20231008052101.144422-1-akihiko.odaki@daynix.=
com/
> [3]
> https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.ht=
ml#x1-2400003
> [4]
> https://lore.kernel.org/all/CACGkMEuBbGKssxNv5AfpaPpWQfk2BHR83rM5AHXN-YVM=
f2NvpQ@mail.gmail.com/

