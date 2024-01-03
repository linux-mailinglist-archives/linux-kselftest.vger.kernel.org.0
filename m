Return-Path: <linux-kselftest+bounces-2602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE1A82273D
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 03:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6908B2257E
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 02:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9F5468C;
	Wed,  3 Jan 2024 02:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISKlTak9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F2A179B0;
	Wed,  3 Jan 2024 02:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-5edbcdc323dso55011087b3.3;
        Tue, 02 Jan 2024 18:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704250491; x=1704855291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFJJwB7vRn3ykciGztneLAe3sG+u07iBBRPMPmW2amM=;
        b=ISKlTak9RvSMHlP+1E0xrkyp4Q7n0z397MhxlvgKdARh1PVmby0qbLJgnd3bcn3nNq
         iJhOBt7zbci2PljNvm5TDBMEn733Rpf+DWJizRXT6xPTmmpM7W+Od5P0YE9b3/VafiJA
         63P9ltV8iKStbkAVmip0nPXi/vc7vnapopXUKnzY1K1g0qcwfQOBJq2HM6fRNFXRnikp
         YZiSpsQCf2LN876JDASbtqcCNVpMNJ/acsiFKRRYX1WO0nQVjHZMzj6tp5Fb/RzR4/dT
         OhK92rgvq3Vb/TITvMafkwHL7QEvRu3qevB30W4fQEjeThZpVYLv6oK5zCqRZwDqdN/j
         BFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704250491; x=1704855291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFJJwB7vRn3ykciGztneLAe3sG+u07iBBRPMPmW2amM=;
        b=X/1Lr7gEdfUHOwQlCxiH9KaEpnoJc0JGFf0UmgRh/F9x0BvEyvxLYjpI80fE+wa7g1
         WLClV6VJzkRcAwOI/X1xjLomX+Jtk+xKPCxNzS6EFPuTZw9Lopvjr+OzZBqMHeLIpfyu
         1NKK81NUTVKSL/MLQnup3W+WFjC1Xb7eqBI0ehtKZQkdct/xflyXvdY9C+KEdfCmW5bx
         XipC8m8TwdLdxStmOv/NnvWEg5vJbS3xkeEgExwu12eOdDl1/5jBvRBBoH6V4fipOTIW
         JcfTJH2HwzrSBiW0usG0aJ9T1kmWDlGcgJI5eUMCrw8UBczvpE7Wq2dM9q/jyfKe8CIA
         xl2g==
X-Gm-Message-State: AOJu0Yx7EomhZy4JrfIaEbYCwzjcFGBChqdR02aC5dU+zSFdZSXx/rig
	6dAWJfvwRChGBjT5Sgr9lrRboLvidbaMgcQfuqU=
X-Google-Smtp-Source: AGHT+IFKUKxHmnTj8Bq25WmcufkuhTAl7Rat8W3F7rkMsB8GqPRnI6yPcMchvR16a1I6cqZ4qc+dLufvoD+tLg6hVMI=
X-Received: by 2002:a05:6902:248a:b0:dbd:bf80:4942 with SMTP id
 ds10-20020a056902248a00b00dbdbf804942mr10015296ybb.77.1704250490953; Tue, 02
 Jan 2024 18:54:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229081409.1276386-1-menglong8.dong@gmail.com>
 <ZZRR1q1JrJMD1lAy@google.com> <c628c362-b2e8-4ad6-a34f-50c2822bccd6@linux.dev>
In-Reply-To: <c628c362-b2e8-4ad6-a34f-50c2822bccd6@linux.dev>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 3 Jan 2024 10:54:39 +0800
Message-ID: <CADxym3bPjdErhZ_wgQNK3BqbeUgvGMtLJRA_rD3pRa+BVcA95A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] bpf: add csum/ip_summed fields to __sk_buff
To: Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com, shuah@kernel.org, 
	horms@kernel.org, dhowells@redhat.com, linyunsheng@huawei.com, 
	aleksander.lobakin@intel.com, joannelkoong@gmail.com, laoar.shao@gmail.com, 
	kuifeng@meta.com, bjorn@rivosinc.com, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 8:52=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 1/2/24 10:11 AM, Stanislav Fomichev wrote:
> > On 12/29, Menglong Dong wrote:
> >> For now, we have to call some helpers when we need to update the csum,
> >> such as bpf_l4_csum_replace, bpf_l3_csum_replace, etc. These helpers a=
re
> >> not inlined, which causes poor performance.
> >>
> >> In fact, we can define our own csum update functions in BPF program
> >> instead of bpf_l3_csum_replace, which is totally inlined and efficient=
.
> >> However, we can't do this for bpf_l4_csum_replace for now, as we can't
> >> update skb->csum, which can cause skb->csum invalid in the rx path wit=
h
> >> CHECKSUM_COMPLETE mode.
> >>
> >> What's more, we can't use the direct data access and have to use
> >> skb_store_bytes() with the BPF_F_RECOMPUTE_CSUM flag in some case, suc=
h
> >> as modifing the vni in the vxlan header and the underlay udp header ha=
s
> >> no checksum.
>
> There is bpf_csum_update(), does it work?
> A helper call should be acceptable comparing with the csum calculation it=
self.

Yeah, this helper works in this case! Now we miss the last
piece for the tx path: ip_summed. We need to know if it is
CHECKSUM_PARTIAL to decide if we should update the
csum in the packet. In the tx path, the csum in the L4 is the
pseudo header only if skb->ip_summed is CHECKSUM_PARTIAL.

Maybe we can introduce a lightweight kfunc to get its
value? Such as bpf_skb_csum_mode(). As we need only call
it once, there shouldn't be overhead on it.

Thanks!
Menglong Dong

>
> >>
> >> In the first patch, we make skb->csum readable and writable, and we ma=
ke
> >> skb->ip_summed readable. For now, for tc only. With these 2 fields, we
> >> don't need to call bpf helpers for csum update any more.
> >>
> >> In the second patch, we add some testcases for the read/write testing =
for
> >> skb->csum and skb->ip_summed.
> >>
> >> If this series is acceptable, we can define the inlined functions for =
csum
> >> update in libbpf in the next step.
> >
> > One downside of exposing those as __sk_buff fields is that all this
> > skb internal csum stuff now becomes a UAPI. And I'm not sure we want
>
> +1. Please no new __sk_buff extension and no new conversion in
> bpf_convert_ctx_access().
>
> > that :-) Should we add a lightweight kfunc to reset the fields instead?
> > Or will it still have an unacceptable overhead?
>

