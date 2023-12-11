Return-Path: <linux-kselftest+bounces-1489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F34080BEC7
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 02:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90BC3280C1A
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 01:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0986C2D0;
	Mon, 11 Dec 2023 01:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qR17lPs4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC4C612D;
	Mon, 11 Dec 2023 01:41:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14A9C43395;
	Mon, 11 Dec 2023 01:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702258866;
	bh=MBOze/c93zYR/s0Tv/psL8lZsa2zAA8epMJdS8MTA48=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qR17lPs4JMPnH4HZ6ahTIg4TYdw9Z4XEBYFJPU0HqGvQbsEA0QxrteiBI65X0D8wM
	 OnS+34BNKvsvb7nxZvu3bIFA/LezLHP88kiCw7rXdNOBkbjqjORpXBWYYfYSJCt0q9
	 2d3TkFNtGktLG+F+95I8YIUrrIFrV4hwTZwW72HEi/SKVOS1p3IekzaLsbSF2ikZnw
	 q4UCfhQejMRxVHD94ZpJUBrJHFFEQ4e/M/LidZJOEs1GY6tmxMEXinp2TyJHkLSskv
	 luB8LytAXsQ1RptemeRh0Va7+XGeR/CIiqGvs2FQEEeVPQAslDf3xAlhmqNbBDGsst
	 uW9/xpQAU60RA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2c9efa1ab7fso47837391fa.0;
        Sun, 10 Dec 2023 17:41:05 -0800 (PST)
X-Gm-Message-State: AOJu0Yzf2HbO/DTwEGwALmGOL/a6eS7TlzY/75tCyFtE4vopVXpWSqon
	1GzTgWGdsTC+GxU8ePqYW/9pUC01i5WRXgv5Cas=
X-Google-Smtp-Source: AGHT+IHifpFa36iHpb1+GyluGw6IQnLTC075/8t8iOHLtdbD3dWDzZ8fH9kQh4f8GxIkuv9w02XPsx/dXrcydyPkjDw=
X-Received: by 2002:a2e:7e05:0:b0:2ca:1bb4:4426 with SMTP id
 z5-20020a2e7e05000000b002ca1bb44426mr543816ljc.207.1702258864030; Sun, 10 Dec
 2023 17:41:04 -0800 (PST)
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
 <CAPhsuW5JYoM-Mkehdy=FQsG1nvjbYGzwRZx8BkpG1P7cHdD=eQ@mail.gmail.com>
 <dba89d4b-84aa-4c9f-b016-56fd3ade04b2@daynix.com> <CAPhsuW5KLgt_gsih7zi+T99iYVbt7hk7=OCwYzin-H3=OhF54Q@mail.gmail.com>
 <a1f09866-a443-4f74-8025-6cdb32eb1d2c@daynix.com> <CAPhsuW4o5o41a+jVjgGP+Ck3eUD8w6coLXMTYewXKJYmciLLnQ@mail.gmail.com>
 <664003d3-aadb-4938-80f6-67fab1c9dcdd@daynix.com> <d30a038b-d10f-468d-8879-478a6c5b814b@daynix.com>
In-Reply-To: <d30a038b-d10f-468d-8879-478a6c5b814b@daynix.com>
From: Song Liu <song@kernel.org>
Date: Sun, 10 Dec 2023 17:40:52 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5CMYiOMUDCgfQyo=K31igZZ+BgXyL6yfq1OG3r2CzQ4g@mail.gmail.com>
Message-ID: <CAPhsuW5CMYiOMUDCgfQyo=K31igZZ+BgXyL6yfq1OG3r2CzQ4g@mail.gmail.com>
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

On Sat, Dec 9, 2023 at 11:03=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2023/11/22 14:36, Akihiko Odaki wrote:
> > On 2023/11/22 14:25, Song Liu wrote:
[...]
>
> Now the discussion is stale again so let me summarize the discussion:
>
> A tuntap device can have an eBPF steering program to let the userspace
> decide which tuntap queue should be used for each packet. QEMU uses this
> feature to implement the RSS algorithm for virtio-net emulation. Now,
> the virtio specification has a new feature to report hash values
> calculated with the RSS algorithm. The goal of this RFC is to report
> such hash values from the eBPF steering program to the userspace.
>
> There are currently three ideas to implement the proposal:
>
> 1. Abandon eBPF steering program and implement RSS in the kernel.
>
> It is possible to implement the RSS algorithm in the kernel as it's
> strictly defined in the specification. However, there are proposals for
> relevant virtio specification changes, and abandoning eBPF steering
> program will loose the ability to implement those changes in the
> userspace. There are concerns that this lead to more UAPI changes in the
> end.
>
> 2. Add BPF kfuncs.
>
> Adding BPF kfuncs is *the* standard way to add BPF interfaces. hid-bpf
> is a good reference for this.
>
> The problem with BPF kfuncs is that kfuncs are not considered as stable
> as UAPI. In my understanding, it is not problematic for things like
> hid-bpf because programs using those kfuncs affect the entire system
> state and expected to be centrally managed. Such BPF programs can be
> updated along with the kernel in a manner similar to kernel modules.
>
> The use case of tuntap steering/hash reporting is somewhat different
> though; the eBPF program is more like a part of application (QEMU or
> potentially other VMM) and thus needs to be portable. For example, a
> user may expect a Debian container with QEMU installed to work on Fedora.
>
> BPF kfuncs do still provide some level of stability, but there is no
> documentation that tell how stable they are. The worst case scenario I
> can imagine is that a future legitimate BPF change breaks QEMU, letting
> the "no regressions" rule force the change to be reverted. Some
> assurance that kind scenario will not happen is necessary in my opinion.

I don't think we can provide stability guarantees before seeing something
being used in the field. How do we know it will be useful forever? If a
couple years later, there is only one person using it somewhere in the
world, why should we keep supporting it? If there are millions of virtual
machines using it, why would you worry about it being removed?

>
> 3. Add BPF program type derived from the conventional steering program ty=
pe
>
> In principle, it's just to add a feature to report four more bytes to
> the conventional steering program. However, BPF program types are frozen
> for feature additions and the proposed change will break the feature free=
ze.
>
> So what's next? I'm inclined to option 3 due to its minimal ABI/API
> change, but I'm also fine with option 2 if it is possible to guarantee
> the ABI/API stability necessary to run pre-built QEMUs on future kernel
> versions by e.g., explicitly stating the stability of kfuncs. If no
> objection arises, I'll resend this series with the RFC prefix dropped
> for upstream inclusion. If it's decided to go for option 1 or 2, I'll
> post a new version of the series implementing the idea.

Probably a dumb question, but does this RFC fall into option 3? If
that's the case, I seriously don't think it's gonna happen.

I would recommend you give option 2 a try and share the code. This is
probably the best way to move the discussion forward.

Thanks,
Song

