Return-Path: <linux-kselftest+bounces-33471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB177ABFC22
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 19:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14CAA20ECD
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 17:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDA228981A;
	Wed, 21 May 2025 17:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ovoLN7NW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AAE1E2307
	for <linux-kselftest@vger.kernel.org>; Wed, 21 May 2025 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747847822; cv=none; b=h09KOzGoLN9b4XKJbR6PbzATy9DOA8e9Saz3NhgkClhHxk5NgF9unPqoJJej9T7rlcJWoARPIMa+kiaeawNSKOgLGbv+i0eiSHblKeV2/BCgPA6QzmgcgPUjeBXDwYQXKEDd0uZw992aBMWs8psb3jD3KFPOWRvdyq7LUVBSaLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747847822; c=relaxed/simple;
	bh=D4ISe/FLvyr4CVhVYBHD6n3L5UFpgvuWP7bM5t7YOuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NUqwPXR5nKgE1DxL6RxpqBjmg1OugYWyp4qChRaG8qYd9HYbb/YQdvWtUtn83tD0cRP7+BqCIFb8gn0fgpNd3upmbOFz8ybKUR0phY5NzWNwMzCZNigtbsfft4dsPIccuMyHABDNmkFrJZuHqps5v0FEdmaI2ZS/CLJRlRd2myo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ovoLN7NW; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-231f61dc510so1096245ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 21 May 2025 10:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747847819; x=1748452619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjNF/EshajwntpVrmxofKLtSpmDRMldtvHl1a1kJfXU=;
        b=ovoLN7NWm/fAj3Rryts6klo6HLNyz5amt6nL27kcFGNCcTWKd5S01e83iMN3oZRh+b
         fk/snncw+3smXPaTeWDV4SxfTTONGXnTlynasmSZDzbTEiiog5Jsb/aMWWqbhS0/fxCj
         pgHjz60x5BLfUdU4vsn63T2pufMquOH6ct0uW2ht7L6kN68h2B1oyO6rVu8tLH3dpdgZ
         wMsfLAMAz0wBob6chtRzrSQjWLvptqjOhJ84Ar3d3kE8+lFxC9a110TN3O1TBFZwHLye
         DF8CkQXNVypf0XsnGX3JCZrG/fiCm/IGCHtT+GBqojNFuWIR2oqsFerklQ3Cklld5nhk
         ltkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747847819; x=1748452619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjNF/EshajwntpVrmxofKLtSpmDRMldtvHl1a1kJfXU=;
        b=sd5j1myJMEUNZ5bqqpAeMYqqHY1r10KSmg0T7M4y0PmL+gk0+z4axtquEbL7smodG+
         oBQR0a5/o4voz4x2wxMXYyO8XOZOtiQQUhBHKitHgUOQ9QT7deJHvtE1HAVuge3GPqT0
         b4DJMG8Gto/JLb3h9O8sxw80YzNcLjvNFO65ga8a4eMU1j2o4JddyzA6C/lNtE5PK6DN
         zW+U6T2j2hlATUSs2Q4GFP2AToPEHExG7LV8K6urwHZ4pndwViKBHueDPkpmc+t7v9D4
         tnEYJdnki+PLe8j1mHmxJnyGa2No9SO0RLGvtHzrGSUW1/N1lZmY3tEl/lbXHzW2Kzo6
         tBzA==
X-Forwarded-Encrypted: i=1; AJvYcCWGR0K8DBmHGNjWbV88Tq4RwP99lAKba62Lwcpvam86wzbP9coac/IzQ+w58/ZHifPyDMXG3NlpRGqkelG3opU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKTuFgQMVm9Mf586BToElKSyPA0zwcWt3iVXSNyk3gIg/HEUEv
	Zt0MfiP6cEi6fWsA+pJzbxd3wj7jgbVGX4a1Pu5jH5PlYZnNYzlS3pip9uvdHAilrN1fVOG4n3p
	ziP5tchVEDGmfJZi81VlAE6+K6KT0UGsEHs85TNX5
X-Gm-Gg: ASbGncsTi7Z799P3R79yOk5DYP93Ir4sI3zqHu2OtFZxNJ+FZMjMiA0x05GbqHyxEYf
	1uIWO6adoPAqoM2jLDOh9kA0oslN4tVFXMps4ARnnwuzdcGlSUeDcOOyj6PUHbunHMh4rfR/oX4
	U5gTvxLi+XQV3WZR2WOEr4cwK2RhlrmvVhv2/D+ps1Afj/8m7rhy1VJS/SsxRLtwJdD4YA1lX0
X-Google-Smtp-Source: AGHT+IEcLaieaT6i2N8bO/10/CNvd74NMT4xZt9ijO05OydHwziDOCVx023CgKji5TDdxf9zVv/qUvK6mdJYoPHbsrA=
X-Received: by 2002:a17:902:e80b:b0:21f:3c4a:136f with SMTP id
 d9443c01a7336-231ffdc5dd7mr11782905ad.28.1747847819084; Wed, 21 May 2025
 10:16:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520203044.2689904-1-stfomichev@gmail.com>
In-Reply-To: <20250520203044.2689904-1-stfomichev@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 21 May 2025 10:16:46 -0700
X-Gm-Features: AX0GCFs1YWRcByoee8OrB1N_JWqtKzwROSm78yacol8kNV9a-DsAubo73LOdPp4
Message-ID: <CAHS8izOTWF9PO9N6ZamJ0xSCTOojXV+LfYm+5B5b8Ad1MA0QpA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: devmem: support single IOV with sendmsg
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, viro@zeniv.linux.org.uk, horms@kernel.org, 
	andrew+netdev@lunn.ch, shuah@kernel.org, sagi@grimberg.me, willemb@google.com, 
	asml.silence@gmail.com, jdamato@fastly.com, kaiyuanz@google.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 1:30=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> sendmsg() with a single iov becomes ITER_UBUF, sendmsg() with multiple
> iovs becomes ITER_IOVEC. iter_iov_len does not return correct
> value for UBUF, so teach to treat UBUF differently.
>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Pavel Begunkov <asml.silence@gmail.com>
> Cc: Mina Almasry <almasrymina@google.com>
> Fixes: bd61848900bf ("net: devmem: Implement TX path")
> Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
> ---
>  include/linux/uio.h | 8 +++++++-
>  net/core/datagram.c | 3 ++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index 49ece9e1888f..393d0622cc28 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -99,7 +99,13 @@ static inline const struct iovec *iter_iov(const struc=
t iov_iter *iter)
>  }
>
>  #define iter_iov_addr(iter)    (iter_iov(iter)->iov_base + (iter)->iov_o=
ffset)
> -#define iter_iov_len(iter)     (iter_iov(iter)->iov_len - (iter)->iov_of=
fset)
> +
> +static inline size_t iter_iov_len(const struct iov_iter *i)
> +{
> +       if (i->iter_type =3D=3D ITER_UBUF)
> +               return i->count;
> +       return iter_iov(i)->iov_len - i->iov_offset;
> +}
>

This change looks good to me from devmem perspective, but aren't you
potentially breaking all these existing callers to iter_iov_len?

ackc -i iter_iov_len
fs/read_write.c
846:                                            iter_iov_len(iter), ppos);
849:                                            iter_iov_len(iter), ppos);
858:            if (nr !=3D iter_iov_len(iter))

mm/madvise.c
1808:           size_t len_in =3D iter_iov_len(iter);
1838:           iov_iter_advance(iter, iter_iov_len(iter));

io_uring/rw.c
710:                    len =3D iter_iov_len(iter);

Or are you confident this change is compatible with these callers for
some reason?

Maybe better to handle this locally in zerocopy_fill_skb_from_devmem,
and then follow up with a more ambitious change that streamlines how
all the iters behave.


--=20
Thanks,
Mina

