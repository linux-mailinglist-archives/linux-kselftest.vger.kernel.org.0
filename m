Return-Path: <linux-kselftest+bounces-2605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE59822827
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 07:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87AE61F2398B
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 06:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3B11798A;
	Wed,  3 Jan 2024 06:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyIC+AF1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92CC17988;
	Wed,  3 Jan 2024 06:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-dbdd61d80a3so100888276.0;
        Tue, 02 Jan 2024 22:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704261794; x=1704866594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQ5IlZ0V3FHaUxfy2Z13jv10QMbc9LLMikTDxO1h8tE=;
        b=DyIC+AF171WqM4aLiGMC76IYMmccZPtTVWw39TUWmWbz2fLUqDHyztCnPtXQOk7gDV
         bbXmcLBe4T1EONz3N7vd9s9NON5O40hsP5C63v+lgAFnJmHD06Ur24BrzCuAMOiilHCh
         GRyPI11P8A8HeR6OgRVEnAeUYRu5V6eYRTFOaCaLcGBYA9wRZTJFSrfsiIrt57zDDzTy
         ZYkWxV44ffJHyJreUbK6b4zMUJ14i89BNauWryNTP/1NfpBUqzcj2FUSp2B7sU1PSgh0
         +JX98EI+JnQq7p84enY4bsNSCM8mIYW03Q9fuI50oKFZKGGv4lqSOAqjWmuPaLAlVyaA
         nrpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704261794; x=1704866594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQ5IlZ0V3FHaUxfy2Z13jv10QMbc9LLMikTDxO1h8tE=;
        b=djbNB166j2YkAClvDRVE7ozhsGAMtKviYdPWhe5SITt9izNw1L0K+tsAknGS2OztVa
         fXjTEJ73+TQdq05JFQ+knQjtJ3w6sjoAawt63yGOWVLOOD9GoSdGRXElj1g/2x1y73qJ
         e1J2MNgGVH8AzoHXeNf2eD+g1pFV8Rnir3ngaSl2JLdCJIgvTp2e+qG7ioXNdjsc4MNb
         uOB3S0+ecqYdmyy7+AfjlwBmf9zuas5PXxEppzf4imTZGTYNthE4W8bXdwf2J4PYQIXt
         UkLqf3Tj14KvqcjjnMiSDVCPKP4kAyKckS9OqRfVeOmuQFBzze0BrBNoetRz7bHXepKs
         LH9w==
X-Gm-Message-State: AOJu0YzlEwSiT1YqP4QIpFQ4E3pmiS5E56OwozbB+dxtHGThjl528r3z
	9zfzL8VR6FHXCwccquZomSplIHgKUMrD7DsIJzU=
X-Google-Smtp-Source: AGHT+IEin4aLwzgRDR4YF1/z/b9ItG0hiLXmGxsk6KOXZ+HGU75LTH+uJ4VHAoPVHhGqhsVSBupooXSyuU5C53pXdVg=
X-Received: by 2002:a05:6902:10d:b0:dbc:da55:b397 with SMTP id
 o13-20020a056902010d00b00dbcda55b397mr321129ybh.65.1704261793832; Tue, 02 Jan
 2024 22:03:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229081409.1276386-1-menglong8.dong@gmail.com>
 <ZZRR1q1JrJMD1lAy@google.com> <c628c362-b2e8-4ad6-a34f-50c2822bccd6@linux.dev>
 <CADxym3bPjdErhZ_wgQNK3BqbeUgvGMtLJRA_rD3pRa+BVcA95A@mail.gmail.com> <4fa8ae9d-11fd-4728-83bd-848cb22952e7@linux.dev>
In-Reply-To: <4fa8ae9d-11fd-4728-83bd-848cb22952e7@linux.dev>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 3 Jan 2024 14:03:02 +0800
Message-ID: <CADxym3aYT6ftPMFiuMSiTpNEYpvPz1p3rEtK6bX2_N=BreXOzQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] bpf: add csum/ip_summed fields to __sk_buff
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, song@kernel.org, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, mykolal@fb.com, shuah@kernel.org, horms@kernel.org, 
	dhowells@redhat.com, linyunsheng@huawei.com, aleksander.lobakin@intel.com, 
	joannelkoong@gmail.com, laoar.shao@gmail.com, kuifeng@meta.com, 
	bjorn@rivosinc.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 11:55=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 1/2/24 6:54 PM, Menglong Dong wrote:
> > On Wed, Jan 3, 2024 at 8:52=E2=80=AFAM Martin KaFai Lau <martin.lau@lin=
ux.dev> wrote:
> >> On 1/2/24 10:11 AM, Stanislav Fomichev wrote:
> >>> On 12/29, Menglong Dong wrote:
> >>>> For now, we have to call some helpers when we need to update the csu=
m,
> >>>> such as bpf_l4_csum_replace, bpf_l3_csum_replace, etc. These helpers=
 are
> >>>> not inlined, which causes poor performance.
> >>>>
> >>>> In fact, we can define our own csum update functions in BPF program
> >>>> instead of bpf_l3_csum_replace, which is totally inlined and efficie=
nt.
> >>>> However, we can't do this for bpf_l4_csum_replace for now, as we can=
't
> >>>> update skb->csum, which can cause skb->csum invalid in the rx path w=
ith
> >>>> CHECKSUM_COMPLETE mode.
> >>>>
> >>>> What's more, we can't use the direct data access and have to use
> >>>> skb_store_bytes() with the BPF_F_RECOMPUTE_CSUM flag in some case, s=
uch
> >>>> as modifing the vni in the vxlan header and the underlay udp header =
has
> >>>> no checksum.
> >> There is bpf_csum_update(), does it work?
> >> A helper call should be acceptable comparing with the csum calculation=
 itself.
> > Yeah, this helper works in this case! Now we miss the last
> > piece for the tx path: ip_summed. We need to know if it is
> > CHECKSUM_PARTIAL to decide if we should update the
> > csum in the packet. In the tx path, the csum in the L4 is the
> > pseudo header only if skb->ip_summed is CHECKSUM_PARTIAL.
> >
> > Maybe we can introduce a lightweight kfunc to get its
> > value? Such as bpf_skb_csum_mode(). As we need only call
> > it once, there shouldn't be overhead on it.
>
> You don't need kfunc, you can do checking like
>    struct sk_buff *kskb =3D bpf_cast_to_kern_ctx(skb);
>    if (kskb->ip_summed =3D=3D CHECKSUM_PARTIAL) ...
>    ...
>

Great, this is exactly what I need! Thanks~

