Return-Path: <linux-kselftest+bounces-7336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCD189AC89
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 19:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E19D282BD4
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 17:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A87F40BF0;
	Sat,  6 Apr 2024 17:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2hLTGVe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154D42E852;
	Sat,  6 Apr 2024 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712425312; cv=none; b=eQ6r77QMfmtYbliFHTStaPQr3SEQwlCcuNaro3ZIMuGb/vH24upiLiusNdMgvJg2icHDfIiqMgA+BnDxoqI7ZAZwyhQtG0nv5kFGvNGhijV+tTbBVbLTPuN+KQAE5JrB7wvQ+y7Xsprisneaz6j+yBfWEStrrCFDqGjYKVthUW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712425312; c=relaxed/simple;
	bh=SLzIboo2KhRStT2OLMQJvLiVLaQuB8pH12eVMx5y8II=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEEb7l2KhIiV+iieBkQ4ipGChHq6Udw/G06FHkoUXrM1/xds5LU7WLmTqKxHq+BI4kZ+U2Z5dypt2WZCKfCAX2QII8jDE5dL0OQ2wfCwIVLsvi0vSon6CLlVefbe2dfHDrDwji1Z1XlBPdI8YDPCw8Qs0Z+RPamjDMvEnlPvOoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2hLTGVe; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2a21af18037so1996687a91.3;
        Sat, 06 Apr 2024 10:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712425310; x=1713030110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIK4Jfc3DO+mAM+uQtVXbu3bSPa8V+IPmURh+M/aWtc=;
        b=S2hLTGVeZ8eh0Kp3+Jsqrj1ZsYgnuRq0HC4uwS19cvOi11TKKYhQmy0Is02axxLzKF
         3SR+6cIfgkxMPaXdSz71yfT+J319kaPSAph6+DbRNNzXxG9wXux+HVH7SIafl3hfZksn
         5EKSP45UspETAiClz4+CWuHT1BcoMscL9JCtSANW+49RDuwlgBRBgitqz7riZaUne+lK
         4ZQt45UTePIh/oiSf6GQCg6dsmMFWSAsQgqtgguF5MwDW6sa7t36ywnNWqyKNPhoDJNP
         g6GM6q/QMcU+rR7htWFutigVHiI1bPlu5GkMuhiFXb6i0jDJcJeqbcwOkgfssHXY/lqH
         dNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712425310; x=1713030110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIK4Jfc3DO+mAM+uQtVXbu3bSPa8V+IPmURh+M/aWtc=;
        b=L4E6F3dpIdYkeZ4JA5OmRM/9lFXyx/x/Otc02aMLr+S3MHQERbiw6I8a6LIWWFt2lu
         WQcQI6z4GH6rubsbC0tHHySOJJGHZJuU2cGqs/cOahr6J0mWMrOkXZV+VKqTGRBR2H2P
         Y3to7eIJtoVH3Gh/jIFr7VBKuowNm3MoD3sTHdTvXKqrQKrnPPbAv5ry70ll1m5VqWti
         ZDUbnXVuSuZhehzGR3MAr4i9w1jSTzSj3CNfhV7LhFMgXtPh+eCBVs3Hgw5MCoFoA+ej
         IVltlRzwuJpueJIoVI15h1p868y4E0Xec0uCrmivQkjr/2mMufNO92wxZFEJ9mAFeqdN
         qXaw==
X-Forwarded-Encrypted: i=1; AJvYcCUpj42bXuKlTjV16UMNBed/460WbBTNfxNnD+N3r1CoiBzqOkxO9OOOJK+LzwBQfaL8TVUcItM4+S+OtSY3DeTVLTkEs3cYDEm9kQg5GSViaQh7QC94WxeI0X+IBpuiwx9qISpTZviY62MNoNVnzveevUqQ81FQXD1G2XLE7TgJzpXY
X-Gm-Message-State: AOJu0YydcAhqvM758AbQ5NHJBp7XEy9V5m3qjmUMzCRrwJKnL3yTasga
	eGSTvwgGRva25+9+gfAmB2ht6jq8FxbY9jk17BF5yuRB0NHdLcwHGg59Evy8eklIafR04cl7p/o
	cWWrEoPTy99TBtCEtD+Ueqk3dxu8=
X-Google-Smtp-Source: AGHT+IEymrMxb07XCPRkKV9+Z07q/icgIFqFHm/TwguC0bK3ClsUeR+N1aTcppxY7twoo6sE1e03F4kpQPoGat1U9g0=
X-Received: by 2002:a17:90b:fd5:b0:29b:ed0d:60fa with SMTP id
 gd21-20020a17090b0fd500b0029bed0d60famr4055629pjb.19.1712425310275; Sat, 06
 Apr 2024 10:41:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406092005.92399-1-andrea.righi@canonical.com> <20240406092005.92399-3-andrea.righi@canonical.com>
In-Reply-To: <20240406092005.92399-3-andrea.righi@canonical.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sat, 6 Apr 2024 10:41:38 -0700
Message-ID: <CAEf4BzbL62juojprq3kxJ2pB=7VPuv_5eybCUSHvV2xAqYPU2g@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] libbpf: ringbuf: allow to consume up to a certain
 amount of items
To: Andrea Righi <andrea.righi@canonical.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 2:20=E2=80=AFAM Andrea Righi <andrea.righi@canonical=
.com> wrote:
>
> In some cases, instead of always consuming all items from ring buffers
> in a greedy way, we may want to consume up to a certain amount of items,
> for example when we need to copy items from the BPF ring buffer to a
> limited user buffer.
>
> This change allows to set an upper limit to the amount of items consumed
> from one or more ring buffers.
>
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
>  tools/lib/bpf/ringbuf.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index aacb64278a01..2c4031168413 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -231,7 +231,7 @@ static inline int roundup_len(__u32 len)
>         return (len + 7) / 8 * 8;
>  }
>
> -static int64_t ringbuf_process_ring(struct ring *r)
> +static int64_t ringbuf_process_ring(struct ring *r, size_t n)
>  {
>         int *len_ptr, len, err;
>         /* 64-bit to avoid overflow in case of extreme application behavi=
or */
> @@ -268,6 +268,9 @@ static int64_t ringbuf_process_ring(struct ring *r)
>                         }
>
>                         smp_store_release(r->consumer_pos, cons_pos);
> +
> +                       if (cnt >=3D n)
> +                               goto done;
>                 }
>         } while (got_new_data);
>  done:
> @@ -287,13 +290,15 @@ int ring_buffer__consume(struct ring_buffer *rb)
>         for (i =3D 0; i < rb->ring_cnt; i++) {
>                 struct ring *ring =3D rb->rings[i];
>
> -               err =3D ringbuf_process_ring(ring);
> +               err =3D ringbuf_process_ring(ring, INT_MAX);
>                 if (err < 0)
>                         return libbpf_err(err);
>                 res +=3D err;
> +               if (res > INT_MAX) {
> +                       res =3D INT_MAX;
> +                       break;
> +               }
>         }
> -       if (res > INT_MAX)
> -               return INT_MAX;

the idea here was to avoid returning overflown int, not really to stop
at INT_MAX samples. So I kept this part intact (res is int64_t, so no
overflow inside the loop can happen)


>         return res;
>  }
>
> @@ -314,13 +319,15 @@ int ring_buffer__poll(struct ring_buffer *rb, int t=
imeout_ms)
>                 __u32 ring_id =3D rb->events[i].data.fd;
>                 struct ring *ring =3D rb->rings[ring_id];
>
> -               err =3D ringbuf_process_ring(ring);
> +               err =3D ringbuf_process_ring(ring, INT_MAX);
>                 if (err < 0)
>                         return libbpf_err(err);
>                 res +=3D err;
> +               if (res > INT_MAX) {
> +                       res =3D INT_MAX;
> +                       break;
> +               }
>         }
> -       if (res > INT_MAX)
> -               return INT_MAX;
>         return res;
>  }
>
> @@ -375,7 +382,7 @@ int ring__consume(struct ring *r)
>  {
>         int64_t res;
>
> -       res =3D ringbuf_process_ring(r);
> +       res =3D ringbuf_process_ring(r, INT_MAX);
>         if (res < 0)
>                 return libbpf_err(res);
>
> --
> 2.43.0
>

