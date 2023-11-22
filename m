Return-Path: <linux-kselftest+bounces-401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E327F3D42
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 06:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D58F3B21731
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 05:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110CE11725;
	Wed, 22 Nov 2023 05:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srHVmV7f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C380311702;
	Wed, 22 Nov 2023 05:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5069AC43391;
	Wed, 22 Nov 2023 05:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700630751;
	bh=wmWxPUOd6qlcwcRUdP9zuOVzyu62ETC1UMPH8fike0s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=srHVmV7fUud/rEPkwYZ3Cf5j0ftTgJLhUI7Bo8HYn9HEAes9nqIimFw0PB86lodKU
	 T1ZNMaIbN3euB6D0xE4fwIy6xpxe4lQ4VhtDNaClDULPbIAEsQ8ElQsUqc/6pczdKo
	 yhUl3o346DRC6NoHNKUFTDvjkq+3ODvzulKTlnJBHirP+OeOAMOvuqrdqc76q1J7QD
	 wo0rO4lvF3kc/l9eEdZtO5TMRctWyVlE49mL1a1a/gY8ba+WSuDcD7jayvwiKDt5ww
	 bxRRkRq/1jfo2UzWDhQZc/U/UdcJEFp4zmS7H7BSQGjqzFXTfOqsdelZCW5/y7mQi8
	 x+sqkgbKWrkLQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-507be298d2aso8333707e87.1;
        Tue, 21 Nov 2023 21:25:51 -0800 (PST)
X-Gm-Message-State: AOJu0YwwWtFd96QHzKD7yRRBIxrUUhq+6i8J0fHpX1UtCkJXzffg6H6o
	2/roU9C3j6XToRjtIag0MYRwq1+PGb4D6gsez4c=
X-Google-Smtp-Source: AGHT+IHCMVEXjnRbdnaoZRHF4v+WDOV92AxJZtPtfrW5rxC0f/SkxPzWTYT9Yga0zajW7oMblajVNdE6RRo1Nyf4qs8=
X-Received: by 2002:a05:6512:4014:b0:503:258f:fd1b with SMTP id
 br20-20020a056512401400b00503258ffd1bmr1128073lfb.18.1700630749453; Tue, 21
 Nov 2023 21:25:49 -0800 (PST)
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
 <a1f09866-a443-4f74-8025-6cdb32eb1d2c@daynix.com>
In-Reply-To: <a1f09866-a443-4f74-8025-6cdb32eb1d2c@daynix.com>
From: Song Liu <song@kernel.org>
Date: Tue, 21 Nov 2023 21:25:37 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4o5o41a+jVjgGP+Ck3eUD8w6coLXMTYewXKJYmciLLnQ@mail.gmail.com>
Message-ID: <CAPhsuW4o5o41a+jVjgGP+Ck3eUD8w6coLXMTYewXKJYmciLLnQ@mail.gmail.com>
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

On Mon, Nov 20, 2023 at 12:05=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> On 2023/11/20 6:02, Song Liu wrote:
[...]
> >> In contrast, our intended use case is more like a normal application.
> >> So, for example, a user may download a container and run QEMU (includi=
ng
> >> the BPF program) installed in the container. As such, it is nice if th=
e
> >> ABI is stable across kernel releases, but it is not guaranteed for
> >> kfuncs. Such a use case is already covered with the eBPF steering
> >> program so I want to maintain it if possible.
> >
> > TBH, I don't think stability should be a concern for kfuncs used by QEM=
U.
> > Many core BPF APIs are now implemented as kfuncs: bpf_dynptr_*,
> > bpf_rcu_*, etc. As long as there are valid use cases,these kfuncs will
> > be supported.
>
> Documentation/bpf/kfuncs.rst still says:
>  > kfuncs provide a kernel <-> kernel API, and thus are not bound by any
>  > of the strict stability restrictions associated with kernel <-> user
>  > UAPIs.
>
> Is it possible to change the statement like as follows:
> "Most kfuncs provide a kernel <-> kernel API, and thus are not bound by
> any of the strict stability restrictions associated with kernel <-> user
> UAPIs. kfuncs that have same stability restrictions associated with
> UAPIs are exceptional, and must be carefully reviewed by subsystem (and
> BPF?) maintainers as any other UAPIs are."

I am afraid this is against the intention to not guarantee UAPI-level stabi=
lity
for kfuncs.

Thanks,
Song

