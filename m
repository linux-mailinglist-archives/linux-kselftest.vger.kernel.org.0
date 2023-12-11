Return-Path: <linux-kselftest+bounces-1589-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4075A80D437
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 18:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE46E282020
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 17:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0AC4E630;
	Mon, 11 Dec 2023 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILT7ZiPQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A21D4E601;
	Mon, 11 Dec 2023 17:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A99C433C8;
	Mon, 11 Dec 2023 17:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702316424;
	bh=hOU4jYl2zjD7dm4WiF388gDlJNEcYLRmL4FrrPgk5yA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ILT7ZiPQGYhBDRi5b3lf2uIdYB4fRbuh2WtUGL5lqBhOSH9SQvJlRI4vIBz2v17S+
	 blGaty3kzjUowjXu+vwC+cpgSyt00WKM35hBVSFNoLhiDqRYp1qNOKsm9iz9+8yiST
	 Q7K6KPtg6FMORGKJpZx3r5qFsWADIKZ7z27AI70Za4hAoGh4qLSigaBPpfhbzDtG4B
	 WegId6wDnidKSJcRZAEmY6Gsyb2qXOjKSyhqb3S+T2soCbbL8ZCGJnTGo/vdm3VtFH
	 5din7ZlxT5L0DDzybGDn3dJwXQ4AqFpESE3FPPogtTM2eGc+sDPJnDgua4TycmkKSN
	 p4xYROwwpkw+g==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50bef9b7a67so5378236e87.1;
        Mon, 11 Dec 2023 09:40:24 -0800 (PST)
X-Gm-Message-State: AOJu0YzJcd3YEJQ+ACZdrqlHk0GTTyqjPJZRsUdvkqqPNe2zlYKaxz51
	2qxhxzSHuFpFiIVtjJjx7ryxgkkPkIYrvW+S2VY=
X-Google-Smtp-Source: AGHT+IFTGNQtSpFmM7O8UeOW1n7sWiGpQ/OA3GeoRRIZNv3WRNPCLATv59ZjIlJ2ZFi1fcYwSJZuwHeltryOcI6rOhc=
X-Received: by 2002:a2e:b046:0:b0:2ca:34cd:77e4 with SMTP id
 d6-20020a2eb046000000b002ca34cd77e4mr1895908ljl.103.1702316422374; Mon, 11
 Dec 2023 09:40:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231015141644.260646-1-akihiko.odaki@daynix.com>
 <CAADnVQLfUDmgYng8Cw1hiZOMfWNWLjbn7ZGc4yOEz-XmeFEz5Q@mail.gmail.com>
 <2594bb24-74dc-4785-b46d-e1bffcc3e7ed@daynix.com> <CAADnVQ+J+bOtvEfdvgUse_Rr07rM5KOZ5DtAmHDgRmi70W68+g@mail.gmail.com>
 <CACGkMEs22078F7rSLEz6eQabkZZ=kujSONUNMThZz5Gp=YiidQ@mail.gmail.com>
 <CAADnVQLt8NWvP8qGWMPx=12PwWWE69P7aS2dbm=khAJkCnJEoQ@mail.gmail.com>
 <9a4853ad-5ef4-4b15-a49e-9edb5ae4468e@daynix.com> <6253fb6b-9a53-484a-9be5-8facd46c051e@daynix.com>
 <CAPhsuW5JYoM-Mkehdy=FQsG1nvjbYGzwRZx8BkpG1P7cHdD=eQ@mail.gmail.com>
 <dba89d4b-84aa-4c9f-b016-56fd3ade04b2@daynix.com> <CAPhsuW5KLgt_gsih7zi+T99iYVbt7hk7=OCwYzin-H3=OhF54Q@mail.gmail.com>
 <a1f09866-a443-4f74-8025-6cdb32eb1d2c@daynix.com> <CAPhsuW4o5o41a+jVjgGP+Ck3eUD8w6coLXMTYewXKJYmciLLnQ@mail.gmail.com>
 <664003d3-aadb-4938-80f6-67fab1c9dcdd@daynix.com> <d30a038b-d10f-468d-8879-478a6c5b814b@daynix.com>
 <CAPhsuW5CMYiOMUDCgfQyo=K31igZZ+BgXyL6yfq1OG3r2CzQ4g@mail.gmail.com> <49a5b971-ae97-4118-ae20-f651ad14bed7@daynix.com>
In-Reply-To: <49a5b971-ae97-4118-ae20-f651ad14bed7@daynix.com>
From: Song Liu <song@kernel.org>
Date: Mon, 11 Dec 2023 09:40:10 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7E6Dyp8VTiuwbreB18Lt93n9Fa2hdd2sEschUDzgQiSg@mail.gmail.com>
Message-ID: <CAPhsuW7E6Dyp8VTiuwbreB18Lt93n9Fa2hdd2sEschUDzgQiSg@mail.gmail.com>
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

On Sun, Dec 10, 2023 at 9:04=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
[...]
> >
> > I don't think we can provide stability guarantees before seeing somethi=
ng
> > being used in the field. How do we know it will be useful forever? If a
> > couple years later, there is only one person using it somewhere in the
> > world, why should we keep supporting it? If there are millions of virtu=
al
> > machines using it, why would you worry about it being removed?
>
> I have a different opinion about providing stability guarantees; I
> believe it is safe to provide such a guarantee without actual use in a
> field. We develop features expecting there are real uses, and if it
> turns out otherwise, we can break the stated guarantee since there is no
> real use cases anyway. It is fine even breaking UAPIs in such a case,
> which is stated in Documentation/admin-guide/reporting-regressions.rst.
>
> So I rather feel easy about guaranteeing UAPI stability; we can just
> guarantee the UAPI-level stability for a particular kfunc and use it
> from QEMU expecting the stability. If the feature is found not useful,
> QEMU and the kernel can just remove it.

It appears that we more or less agree that this feature may not be
something we will support forever.

> I'm more concerned about the other case, which means that there will be
> wide uses of this feature. A kernel developer may assume the stability
> of the interface is like one of kernel internal APIs
> (Documentation/bpf/kfuncs.rst says kfuncs are like EXPORT_SYMBOL_GPL)
> and decide to change it, breaking old QEMU binaries and that's something
> I would like to avoid.
>
> Regarding the breakage scenario, I think we can avoid the kfuncs removal
> just by saying "we won't remove them". I'm more worried the case that a
> change in the BPF kfunc infrastucture requires to recompile the binary.
>
> So, in short, I don't think we can say "kfuncs are like
> EXPORT_SYMBOL_GPL" and "you can freely use kfuncs in a normal userspace
> application like QEMU" at the same time.
>
> >
[...]
>
> >
> > I would recommend you give option 2 a try and share the code. This is
> > probably the best way to move the discussion forward.
>
> I'd like to add a documentation change to say the added kfuncs are
> exceptional cases that are not like EXPORT_SYMBOL_GPL in that case. Will
> it work?

It will not.

The BPF community had a lot of discussions about the stability of BPF APIs,=
 for
example in [1]. Therefore, this is not a light decision.

AFAICT, what is being proposed in this RFC is way less stable than many kfu=
ncs
we added recently. We are not changing the stability guarantee for this. Le=
t's
invest our time wisely and work on more meaningful things, for example, a
prototype that may actually get accepted.

Thanks,
Song

[1] https://lore.kernel.org/bpf/20221207205537.860248-1-joannelkoong@gmail.=
com/

