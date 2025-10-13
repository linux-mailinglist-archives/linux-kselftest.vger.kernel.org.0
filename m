Return-Path: <linux-kselftest+bounces-43061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C804BD6BAB
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 01:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E07424F5238
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 23:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2312D6E44;
	Mon, 13 Oct 2025 23:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXgMOV72"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1B52BEC59
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 23:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760397791; cv=none; b=KlLhpQNNexu3DPdtjyToLFOMw5tD5aK056WV7smcJoL8Bn+8j3AYMtzZw8uWmHgHjTYZqpa3JxM/L9AXkaxTlDIt+nwXmb7YMELtvmsMThK5a+aBHTu5jZByHtrh3A6Vc4VXnBfpbXPUYMR24TGPyZ9Fn1zTNRzuZ+qNB1Ujc10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760397791; c=relaxed/simple;
	bh=oPeYDzMII5GuzB1XCT3DO7FKvsrPvR90MMSRvn0/xNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RlrSZSSUuA0mZfgNEjvEdS1QyZpWS5tu+D6J+ogfUHfHz+0ALR3i6XTqGJZkBaDS2CU6veERpsPSpA7lLk3t+QetCf/aVwpq4lVX7YZzuSySBPUJAkS8PJz9ivAbQSJvXFUKNQPiHzu2VAg2uS39YMjPPTfGhWM7Xr/lQTLChm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXgMOV72; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-339c9bf3492so6092082a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 16:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760397787; x=1761002587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3C6Kka8MtT8n8WYKW/oaDsoWhaozDvDsZdxAv1VmRE8=;
        b=DXgMOV72JAVTXiZ175yzxNlGSLiK5U9MjclLu3PdOsRw1/jrPlS1vyuRbpjsk96Aa+
         Z54kdsnJ+LcSGG04x+m/VdRj7S2t0R1NCQms5hZTLs0E3ZwgqGOGPOh57RxfqAmWiQYj
         0EfVsujKgpI+LZqhF4TgYJYkBocJK48Eb1bRl34pZCFfauw3BmweIkWLnXWCHq4bf1Ld
         V9SFIiMWBTETrKxD9X4Itg2h1tu4h8JDNsMOf1x6qm3Fun2mUZTbkcZhl0GAGkw+iCg8
         x+E6FxTt+ukPAr+55twVoscFEeK2FCq331SxX9TTnU7GdCAGDonmILBG2Z/xDexFk9Wa
         XJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760397787; x=1761002587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3C6Kka8MtT8n8WYKW/oaDsoWhaozDvDsZdxAv1VmRE8=;
        b=QZdS2iCOvUn3K+bj98F9RO/1dsMEA/5xVOPL6MvCQSyHp3Mpe47awGVjU9LJ9y3u25
         XGTLo/wtrnuDWhC+cHuBDh9cxiy2KMjhf4NkCvqEPGoi/er9lrzlrX4nDP4FV5iuSg1N
         gxPIclv4SMJYu72TwKivm9b/Vb2brYQlxjjRp/K89I3lXONzoITEaiX/iVe+GuEwKIRZ
         3F91xdPrDG0k014Razk8G1h0ozrJ6HQlXgLoRMVB6xpMwLa6d+tlLh1ajCS+ya/II0Hj
         31eTqEa3LV55ggDhTTyPNHwqlHStiY78+2N8qv1ku22VdRDA4hwb9Byn17R07qNs3W27
         qgnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNO57EePQY5xGcahzltSsqzqFHmWLNeCzyfxcLxpssJe7FDAECgmGYWg0dKgKhtRSw2WgJQ3NCYM23xp+1ALQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze1u2eRW8CVcDtePUW5S8VtFmea/lkM3vMU+ZSo+/24QsI87nE
	SCXhD5r9GYWOIxUYEpep88DM5vED5/OA7PY38p7i+uBBztWkIoTA/kBKIvcsZUgqxek/WsA6VGa
	vvvmOOxnLDP6P6IvTYI79SYxgppcoaE0=
X-Gm-Gg: ASbGncuezzwJX0GRgcBPlVYC0/+6B/7EyghRvT2gCgx92OClx1dtNQ/YPftNSUT8S5F
	o1IzT09eCXptJVwmTx5vAbE9Osvm9XGPxoM5j/aF5MDv1Zn0sdDpFTNd9VOX1Ytd884YONTtY9v
	R6mPy9oGU5cNsETHTFeagcf1Jg6cHl0moNlaXtMjxFfobk0JrDh9wdbFxbkmyKvYnwmW/0JVTzT
	XwYwg0wb3Waf6d7U619vhG7giO1Ta2663g9Ura9iQ==
X-Google-Smtp-Source: AGHT+IHm6xlcPjoJ13mmstA4oudrZKdWVq5F8xYL5+6rnxMpucNY+W2qIOMwPJaPD/vRc8j6LOxYVUfRLbfRHuEhf0M=
X-Received: by 2002:a17:90b:4b0b:b0:32e:a535:4872 with SMTP id
 98e67ed59e1d1-33b510f8f79mr28925093a91.2.1760397787074; Mon, 13 Oct 2025
 16:23:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905150641.2078838-1-xukuohai@huaweicloud.com>
 <20250905150641.2078838-2-xukuohai@huaweicloud.com> <CAEf4BzaSEjQzF47BZeh0de9pFbKpaB8JqCs629hV9xZDhMyTgw@mail.gmail.com>
 <63272c95-9669-41c1-8e77-575ec37d36c0@huaweicloud.com> <CAEf4BzbYtaPf0jjoiv16iKWRKkv9ZTH_hBiZMUF+PkjVGOC53A@mail.gmail.com>
 <c1829ab5-2c33-4445-911e-9e72bbbfe079@huaweicloud.com>
In-Reply-To: <c1829ab5-2c33-4445-911e-9e72bbbfe079@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 13 Oct 2025 16:22:52 -0700
X-Gm-Features: AS18NWBY3S5--MvUhqOZRWYri3j16Sq2aToNTgNrV9nNMpZsJR66GWVq9uusNP0
Message-ID: <CAEf4BzYAUDFH7z9x-+vkzkHD0pSG6M264yQoMCGkJxg3mFvcYA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Add overwrite mode for bpf ring buffer
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 12:07=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.co=
m> wrote:
>
> On 10/7/2025 6:10 AM, Andrii Nakryiko wrote:
>
> [...]
>
> >>>> +
> >>>> +       over_pos =3D READ_ONCE(rb->overwrite_pos);
> >>>> +       return min(prod_pos - max(cons_pos, over_pos), rb->mask + 1)=
;
> >>>
> >>> I'm trying to understand why you need to min with `rb->mask + 1`, can
> >>> you please elaborate?
> >>
> >>
> >> We need the min because rb->producer_pos and rb->overwrite_pos are rea=
d
> >> at different times. During this gap, a fast producer may wrap once or
> >> more, making over_pos larger than prod_pos.
> >>
> >
> > what if you read overwrite_pos before reading producer_pos? Then it
> > can't be larger than producer_pos and available data would be
> > producer_pos - max(consumer_pos, overwrite_pos)? would that work?
> >
>
> No, it won=E2=80=99t work. Between reading overwrite_pos and producer_pos=
, producer
> on a different CPU may have already moved producer_pos forward by more th=
an
> one ring buffer size, causing prod_pos - max(cons_pos, over_pos) to excee=
d
> the ring buffer size.

True, but that was the case with this function before as well.
ringbuf_avail_data_sz() is giving an estimate, we just need to make
sure to not return a negative value. We didn't artificially cap the
return to ring buf size before, why starting now? All of this
calculation is done outside of the lock anyways, so it can never be
relied upon for exactness.

>
> >
> >>> And also, at least for consistency, use smp_load_acquire() for overwr=
ite_pos?
> >>>
> >>
> >> Using READ_ONCE here is to stay symmetric with __bpf_ringbuf_reserve()=
,
> >> where overwrite_pos is WRITE_ONCE first, followed by smp_store_release=
(producer_pos).
> >> So here we do smp_load_acquire(producer_pos) first, then READ_ONCE(ove=
rwrite_pos)
> >> to ensure a consistent view of the ring buffer.
> >>
> >> For consistency when reading consumer_pos and producer_pos, I=E2=80=99=
m fine with
> >> switching READ_ONCE to smp_load_acquire for overwrite_pos.
> >>
> >
> > I'm not sure it matters much, but this function is called outside of
> > rb->spinlock, while __bpf_ringbuf_reserve() does hold a lock while
> > doing that WRITE_ONCE(). So it might not make any difference, but I
> > have mild preference for smp_load_acquire() here.
> >
>
> OK, I'll switch to smp_load_acquire.
>
> >>>>    }
> >>>>
> >>>>    static u32 ringbuf_total_data_sz(const struct bpf_ringbuf *rb)
> >>>> @@ -402,11 +419,43 @@ bpf_ringbuf_restore_from_rec(struct bpf_ringbu=
f_hdr *hdr)
> >>>>           return (void*)((addr & PAGE_MASK) - off);
> >>>>    }
> >>>>
> >>>> +
> >
> > [...]
> >
> >>>> +       /* In overwrite mode, move overwrite_pos to the next record =
to be
> >>>> +        * overwritten if the ring buffer is full
> >>>> +        */
> >>>
> >>> hm... here I think the important point is that we search for the next
> >>> record boundary until which we need to overwrite data such that it
> >>> fits newly reserved record. "next record to be overwritten" isn't tha=
t
> >>> important (we might never need to overwrite it). Important are those
> >>> aspects of a) staying on record boundary and b) consuming enough
> >>> records to reserve the new one.
> >>>
> >>> Can you please update the comment to mention the above points?
> >>>
> >>
> >> Sure, I'll update the comment to:
> >>
> >> In overwrite mode, advance overwrite_pos when the ring buffer is full.
> >> The key points are to stay on record boundaries and consume enough
> >> records to fit the new one.
> >>
> >
> > ok
> >
> > [...]
> >
> >>
> >>>> +                          unsigned long rec_pos,
> >>>> +                          unsigned long cons_pos,
> >>>> +                          u32 len, u64 flags)
> >>>> +{
> >>>> +       unsigned long rec_end;
> >>>> +
> >>>> +       if (flags & BPF_RB_FORCE_WAKEUP)
> >>>> +               return true;
> >>>> +
> >>>> +       if (flags & BPF_RB_NO_WAKEUP)
> >>>> +               return false;
> >>>> +
> >>>> +       /* for non-overwrite mode, if consumer caught up and is wait=
ing for
> >>>> +        * our record, notify about new data availability
> >>>> +        */
> >>>> +       if (likely(!rb->overwrite_mode))
> >>>> +               return cons_pos =3D=3D rec_pos;
> >>>> +
> >>>> +       /* for overwrite mode, to give the consumer a chance to catc=
h up
> >>>> +        * before being overwritten, wake up consumer every half a r=
ound
> >>>> +        * ahead.
> >>>> +        */
> >>>> +       rec_end =3D rec_pos + ringbuf_round_up_hdr_len(len);
> >>>> +
> >>>> +       cons_pos &=3D (rb->mask >> 1);
> >>>> +       rec_pos &=3D (rb->mask >> 1);
> >>>> +       rec_end &=3D (rb->mask >> 1);
> >>>> +
> >>>> +       if (cons_pos =3D=3D rec_pos)
> >>>> +               return true;
> >>>> +
> >>>> +       if (rec_pos < cons_pos && cons_pos < rec_end)
> >>>> +               return true;
> >>>> +
> >>>> +       if (rec_end < rec_pos && (cons_pos > rec_pos || cons_pos < r=
ec_end))
> >>>> +               return true;
> >>>> +
> >>>
> >>> hm... ok, let's discuss this. Why do we need to do some half-round
> >>> heuristic for overwrite mode? If a consumer is falling behind it
> >>> should be actively trying to catch up and they don't need notificatio=
n
> >>> (that's the non-overwrite mode logic already).
> >>>
> >>> So there is more to this than a brief comment you left, can you pleas=
e
> >>> elaborate?
> >>>
> >>
> >> The half-round wakeup was originally intended to work with libbpf in t=
he
> >> v1 version. In that version, libbpf used a retry loop to safely copy d=
ata
> >> from the ring buffer that hadn=E2=80=99t been overwritten. By waking t=
he consumer
> >> once every half round, there was always a period where the consumer an=
d
> >> producer did not overlap, which helped reduce the number of retries.
> >
> > I can't say I completely grok the logic here, but do you think we
> > should still keep this half-round wakeup? It looks like an arbitrary
> > heuristic, so I'd rather not have it.
> >
>
> Sure, since the related libbpf code is no longer present, I=E2=80=99ll re=
move this
> logic in the next version.
>
> >>
> >>> pw-bot: cr
> >>>
> >>>> +       return false;
> >>>> +}
> >>>> +
> >>>> +static __always_inline
> >>>
> >>> we didn't have always_inline before, any strong reason to add it now?
> >>>
> >>
> >> I just wanted to avoid introducing any performance regression. Before =
this
> >> patch, bpf_ringbuf_commit() was automatically inlined by the compiler,=
 but
> >> after the patch it wasn=E2=80=99t, so I added always_inline explicitly=
 to keep it
> >> inlined.
> >
> > how big of a difference was it in benchmarks? It's generally frowned
> > upon using __always_inline without a good reason.
> >
>
> The difference is not noticeable on my arm64 test machine, but it is on m=
y
> amd machine.
>
> Below is the benchmark data on AMD EPYC 9654, with and without always_inl=
ine
> attribute.
>
> - With always_inline
>
> Ringbuf, multi-producer contention
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> rb-libbpf nr_prod 1  13.070 =C2=B1 0.158M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 2  15.440 =C2=B1 0.017M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 3  7.860 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 4  6.444 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 8  3.788 =C2=B1 0.005M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 12 2.802 =C2=B1 0.007M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 16 2.560 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 20 2.227 =C2=B1 0.006M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 24 2.141 =C2=B1 0.007M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 28 1.960 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 32 1.913 =C2=B1 0.004M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 36 1.854 =C2=B1 0.004M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 40 1.818 =C2=B1 0.004M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 44 1.779 =C2=B1 0.004M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 48 1.758 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 52 1.812 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/s)
>
> - Without always_inline
>
> Ringbuf, multi-producer contention
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> rb-libbpf nr_prod 1  10.550 =C2=B1 0.032M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 2  14.661 =C2=B1 0.024M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 3  7.616 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 4  6.476 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 8  3.806 =C2=B1 0.004M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 12 2.814 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 16 2.608 =C2=B1 0.004M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 20 2.337 =C2=B1 0.005M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 24 2.270 =C2=B1 0.004M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 28 1.977 =C2=B1 0.004M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 32 1.921 =C2=B1 0.004M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 36 1.862 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 40 1.827 =C2=B1 0.004M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 44 1.912 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 48 1.860 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s)
> rb-libbpf nr_prod 52 1.824 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s)
>
> When nr_prod=3D1, the performance regression is significant, dropping fro=
m
> 13.070 =C2=B1 0.158 M/s with always_inline to 10.550 =C2=B1 0.032 M/s wit=
hout it.
>
> However, since the half-round wakeup logic will be removed in the next
> version, the changes to bpf_ringbuf_commit, including always_inline, will
> also be removed.

Ok, thanks for the data! Please send an updated version of the code,
and let's have another round of review, thanks!

>
> > [...]
>

