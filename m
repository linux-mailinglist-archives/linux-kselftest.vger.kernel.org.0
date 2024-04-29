Return-Path: <linux-kselftest+bounces-9091-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD378B64EB
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 23:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11571F22184
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 21:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFBF190683;
	Mon, 29 Apr 2024 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDr9VtuG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CED839FD;
	Mon, 29 Apr 2024 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714427793; cv=none; b=XAk0jp9vHp/wet/MXQpu2Z7cxQvBEjBAJQfKHkCepvDKev84IKjaEV2yaxOcF18xP3hz5hTkAmN9q+cxfw5z0Tjqe8AdNiuV6MJCJ/SwmKmyV+DeGDPLKgi3VuWfkidbdQSCWSXmsbkEacNBEFGaA695ezvtH0Ttao5DR1pbICM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714427793; c=relaxed/simple;
	bh=am4+itAOCsFWmLVUS820IjilpCRE0cvu94HIBmVO/MQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gjxo3b+KLPN1LhrLgAHGlDjVaHn8AqvKr8UqI4vdzoAsPmYssm9VEpmKdrVZQXMDqzaqrpQna4rSt8s0ojGSfcwydh628OsPBYtnq7yEQq9g4Zwsa3nfBs8Kc6DQeiNZ/vyc9sjnREOc373cqd3R0D54M+X/a82gexrmf0dxMEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDr9VtuG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1eac92f7c74so39101855ad.3;
        Mon, 29 Apr 2024 14:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714427792; x=1715032592; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i7bXCe/YvCxFvkBBJ8m97pmDQILaMFM/X+inNUSset8=;
        b=NDr9VtuGFOSMdCJ001PP7fIWiC8EUHh1f2FS+azzUm1Jraxn1DWRbaOLnyUtW2P65g
         hL3j02w/Oe+heYfpCsON90OKDOyZmtQTGlJE86/jjZH3Sv+X6HXhDQlJH6Q2LXX1O1my
         Ki39APJytyJc2bRlFo2KB6KSNWP4LymrmZm8z9/w8M/csKWV+xfjKlEM8/Kwbt+L+N1w
         jng2jIsIVyfpE/yW6L2PDhexM3BownHceBJLFlgpQzTp8RttpQrF8Rfn8skXS5cpLt6N
         f0nYzQNNV58qhlBa6A03RwiE7l/sxe2V0gHt43G/vuHnBlidMXCC93YT0Ad1BsVc97qf
         +nBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714427792; x=1715032592;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i7bXCe/YvCxFvkBBJ8m97pmDQILaMFM/X+inNUSset8=;
        b=FO1hwkLWxo7l5DgCRMIpmunvfqTZQetGWHtp946o9MEJgDb7HYgorGNosEBsmQOJOu
         lx+S/xRq2RHHTSI+g8OqODA3i7d7uxKF9E6lQd1ba9u5WW9OIub/Sc9m2tKreNt5f0Rw
         LnL2t6S+PBFzqq/GVLGqRwwJgm5ukW44NYkFpPDBdgPTcSZ0a031Q1Cur8Jh7/NcpX5+
         c4UKUnHzt/DvCQf45C3gVSnADdeT1mOY3oBufJovSvM1k9gmWM2FdqMnjSnuAi9kKWYK
         AlbeXSQdemvRBgWbrx2jbM33GiSBVIDBzh/0xo1O9DTlls1ou1+Ux8rdAIHVc23adh94
         DYXA==
X-Forwarded-Encrypted: i=1; AJvYcCWh01MSSuChHjxBeEvqRqt6SXMcG3/iYJwurUQJ3y2A08v6yQsU4Mjp7PFnZfPTR7UUQt5E1c7jpGHyihNMWPKMcz33h5aKulaVwREsId2gD6OtN3Crf4Pv4hKchWbzIsiKn0f5wG7Irz+gcB2HXYQ52VIEkOGDN9xuioPu2HrnYAmqS87K+zVP1tXZNxy3GXPmTvYjtyoXnr7o1gD/ySTw6NMo
X-Gm-Message-State: AOJu0Yzu0CklIei7jNGUe7/uiIlU6DzzcG47t9N298cxjhWRA5OJMpae
	l30AFNQHxP8SyE/LMxLZTQgCUYvye70h5F+OidQjPvmnzR2T1ALO
X-Google-Smtp-Source: AGHT+IHtggBkBzSjyuDn31+gpM33RSYq80DiZmUcGs/2XB9HLD/7CgQU5Kyef1r9KxBY5X22he9HJQ==
X-Received: by 2002:a17:903:32d2:b0:1ea:9585:a1d7 with SMTP id i18-20020a17090332d200b001ea9585a1d7mr1166964plr.37.1714427791634;
        Mon, 29 Apr 2024 14:56:31 -0700 (PDT)
Received: from ?IPv6:2604:3d08:9880:5900:a18e:a67:fdb6:1a18? ([2604:3d08:9880:5900:a18e:a67:fdb6:1a18])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902a70800b001dd82855d47sm20823504plq.265.2024.04.29.14.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 14:56:30 -0700 (PDT)
Message-ID: <864981e25f0cab42df65f9fedcb06be23badc85b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 07/11] bpf: Fix a false rejection caused by
 AND operation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, Andrii Nakryiko
	 <andrii.nakryiko@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
 netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Matt Bobrowski
 <mattbobrowski@google.com>, Brendan Jackman <jackmanb@chromium.org>, Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E .
 Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>,
 Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek
 <omosnace@redhat.com>, Kees Cook <keescook@chromium.org>, John Johansen
 <john.johansen@canonical.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Roberto Sassu <roberto.sassu@huawei.com>, Shung-Hsi Yu
 <shung-hsi.yu@suse.com>
Date: Mon, 29 Apr 2024 14:56:29 -0700
In-Reply-To: <4fbce978-9687-48a9-be2a-1c4d76790f7d@huaweicloud.com>
References: <20240411122752.2873562-1-xukuohai@huaweicloud.com>
	 <20240411122752.2873562-8-xukuohai@huaweicloud.com>
	 <e62e2971301ca7f2e9eb74fc500c520285cad8f5.camel@gmail.com>
	 <f80991aa-3a49-451a-9a82-ac57982dcb28@huaweicloud.com>
	 <bdc84c6c-7415-4b84-a883-1988cb5f77d1@linux.dev>
	 <576c7c44-d1b4-42c8-8b6e-2e6b93d7547a@huaweicloud.com>
	 <CAEf4BzZTzftrOCFsfBd81sHDBpmNK+4Jefqa3SSS6NiuncO0tQ@mail.gmail.com>
	 <4fbce978-9687-48a9-be2a-1c4d76790f7d@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-04-28 at 23:15 +0800, Xu Kuohai wrote:

[...]

> diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
> index 9dbc31b25e3d..9d4480a683ca 100644
> --- a/kernel/bpf/tnum.c
> +++ b/kernel/bpf/tnum.c
> @@ -150,6 +150,29 @@ struct tnum tnum_intersect(struct tnum a, struct tnu=
m b)
>          return TNUM(v & ~mu, mu);
>   }
>=20
> +/*
> + * Each bit has 3 states: unkown, known 0, known 1. If using x to repres=
ent
> + * unknown state, the result of the union of two bits is as follows:
> + *
> + *         | x    0    1
> + *    -----+------------
> + *     x   | x    x    x
> + *     0   | x    0    x
> + *     1   | x    x    1
> + *
> + * For tnum a and b, only the bits that are both known 0 or known 1 in a
> + * and b are known in the result of union a and b.
> + */
> +struct tnum tnum_union(struct tnum a, struct tnum b)
> +{
> +       u64 v0, v1, mu;
> +
> +       mu =3D a.mask | b.mask; // unkown bits either in a or b
> +       v1 =3D (a.value & b.value) & ~mu; // "known 1" bits in both a and=
 b
> +       v0 =3D (~a.value & ~b.value) & ~mu; // "known 0" bits in both a a=
nd b
> +       return TNUM(v1, mu | ~(v0 | v1));
> +}
> +

Zero would be represented as {.value=3D0,.mask=3D0}, suppose 'b' is zero:

1. mu =3D a.mask | 0;                     2. mu =3D a.mask;
   v1 =3D (a.value & 0) & ~mu;               v1 =3D 0;
   v0 =3D (~a.value & ~0) & ~mu;             v0 =3D ~a.value & ~mu;
   return TNUM(v1, mu | ~(v0 | v1));       return TNUM(v1, mu | ~(v0 | v1))=
;

3. v1 =3D 0;                              4. v1 =3D 0;
   v0 =3D ~a.value & ~a.mask;                v0 =3D ~a.value & ~a.mask;
   return TNUM(v1, a.mask | ~(v0 | v1));   return TNUM(0, a.mask | ~(~a.val=
ue & ~a.mask));

5. return TNUM(0, a.mask | a.value)

So ultimately this says that for 1's that we knew
we no longer know if those are 1's.
Which seems to make sense.

