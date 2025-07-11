Return-Path: <linux-kselftest+bounces-37093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AF3B01AE3
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 13:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2388C1CA79E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 11:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B8128C035;
	Fri, 11 Jul 2025 11:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgCM8+gL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6111146585;
	Fri, 11 Jul 2025 11:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234138; cv=none; b=czGh7bn8avO2OPkfB1VjYhAF3hd7usKF11DzBmOJD5HhPu2sTCTuxBzco4iRabU4MqbJrZxYBCiGjuVfsE1emKcul8zJAI/e9Dtx6qW7DBpU2+PN4105k6LPdt+03ttZeKb8zVmz8Cn8HpoglJBrdo4KzDuSLebddzm/PVATLhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234138; c=relaxed/simple;
	bh=6SZreWucgLG5AdBZcpBS07qgDu47uQvtBMF3P6lkWqA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=muSndPdFM3986BAeH+5Zs7PbdJGcPe2ilKMYElpKMHz+KrFi41sU2HsJtNMNNRgTXM9PAaG2tyopl5U5zAodjae235DqN/K9dotz8265C+xir0xgZY71GXBOIGJzTY2AgaEBabqKteT/1Zj9j9MP1SXpLtoUFXaR9MpQIqYo4u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgCM8+gL; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-237311f5a54so17792625ad.2;
        Fri, 11 Jul 2025 04:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752234136; x=1752838936; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6SZreWucgLG5AdBZcpBS07qgDu47uQvtBMF3P6lkWqA=;
        b=bgCM8+gL5WdKXnVUKtGaiKMSJtZEdQqCqGL7JMNYEGNWqE7myuOIWwPNd5Mx1nv94F
         RUjFeEbId86+5xG2ROj4I6aEQZxLvwKhQ609YRY9Poek+pVf5de4lu/eXTPatDkgVLkm
         1eovu9oZhNXp7LwnauiY+YeQYkJeH0w5/tkj/0wsJsspDEBATNRphfmVKp5TDNuumvXR
         jE4aVyJ3/Gwn854iCdqacIF8iUESKKJsLNJ8AdOsePEVEchzPFtl7U+BRgt7YoPEX+r9
         dV7VnsfPgHU6pGaro7pdOmU3e/IqcZxYCd+uOzXJPJbctocd2K7iuJx0FQLF1ao/00U+
         5PIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752234136; x=1752838936;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6SZreWucgLG5AdBZcpBS07qgDu47uQvtBMF3P6lkWqA=;
        b=kuRX3F4srXPvZQrhbFQHbiFzoMmTXr5N6QmSISImt0u0ZL5VubThL4DIYLEclU7VHz
         WvR0CeeHSMOpdnTEtWjSZH4FbyB7XofCmMeZahq6seFaEB2aLVh9tWYnZj2UuPyTUFxU
         u6+Rl12LSX8+bKhzHSuiQM4mzXKmMX/WYeDoVeZK90bj3fHIzJYQP4boC18RDPTATTsN
         HLeVidymA5FbJ62ajUCOhIlERuFNpu5LpunE7folcka+OWyHct8XdGKAb92BHDW/T+1k
         +F5BLr4LIzD3Hm6+PD1rKHRiS3KpFu2ZeLVQQ+v+GbShwmWZDORXJmKbTtAq3bMfJXp9
         Y7KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCP4Qvm8y9AaVKOY125Qw/CoIDyVrOPhp5zGcRfEFHn9dfF1hCwDXFznFPGnT/1UHm2RG1GV5qUb0TZ1eh@vger.kernel.org, AJvYcCWKKEz/sp4LzSLgAzseMDfoxE3wEIKfk8UN8SvxCEmAIoV3OefpZNRlMagKTYDeEgvdqTk=@vger.kernel.org, AJvYcCXqhLO7rxiI99s4ot46zupeBOT1mtY3hLB8RhFtV2bhDaO7RuR64S8j9w2GglwxUdDKUYXkT08E+BZdq41GSxw+@vger.kernel.org
X-Gm-Message-State: AOJu0YzBVRSF0oh5xPzqlski639KvHW+w9gQH0cwuApLgjh6XnLbq2/Y
	2iB/y4XFqnxuF+dh/F8Ujgf0br4B3jcfbrBStGP3muJhN2pjjR0DuGuj
X-Gm-Gg: ASbGncsXO/PGGi3Whfyavao+yrzncENJL4p9tOpl6VRI1rk+NHGPrUp4NGnXSrkjg4z
	3RmSG3sLYWbC8UI1i0OKSf8ZUrCHMSSlCdwW9izPkNbpUacoxfAYB4rtjyvsMqVezPt9cwgPYdv
	lcFgEy2QfpKEirpkRgzNEGneve5VVC4oXvWjFoxsH/Ds9ALSRMLUtVosgj3RmwTFB4TY8ja71r2
	8UbktbtY7/AXLP/F+zJVrf+6oabI7sMBcd88tJJNvPsU3guKeE2zpfc4e0aEjzGCqM2bqOne903
	DRobyQ/ltMs5Y5H2bYaZeauuilp08V56puKOr1c7N6KwV5XjLO2/kd4wPg7HTu4XE/Trm/f8KNW
	UK+/J/4UoARE/GXXi05Uoyg==
X-Google-Smtp-Source: AGHT+IEkde7KjAzbJlgznBKOn+MUWvTrM5P+KMMIK9fLaXz00KMUZpyweRR2USQoiKgiLry7sqoH5Q==
X-Received: by 2002:a17:902:ebc1:b0:234:ef42:5d69 with SMTP id d9443c01a7336-23dee1a991emr29867215ad.13.1752234135997;
        Fri, 11 Jul 2025 04:42:15 -0700 (PDT)
Received: from [127.0.0.1] ([62.192.175.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4365ef7sm44608985ad.249.2025.07.11.04.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 04:42:14 -0700 (PDT)
Message-ID: <c8a1f651ebb6e0f0f1c0459c9dadc4d01dfa2662.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Show precise rejected function when
 attaching to __btf_id functions
From: KaFai Wan <mannkafai@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,  Shuah Khan
 <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, bpf
 <bpf@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>
Date: Fri, 11 Jul 2025 19:42:05 +0800
In-Reply-To: <CALOAHbCMCnYe=d04Ong5GzdMjK553CooF5XrBi0kQUwoh0oDrA@mail.gmail.com>
References: <20250710162717.3808020-1-mannkafai@gmail.com>
	 <20250710162717.3808020-3-mannkafai@gmail.com>
	 <CAADnVQ+Ca43c757zaT80B+4RJesRozx39mLoz3hOdKXEaXLBLg@mail.gmail.com>
	 <CALOAHbCMCnYe=d04Ong5GzdMjK553CooF5XrBi0kQUwoh0oDrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-07-11 at 17:57 +0800, Yafang Shao wrote:
> On Fri, Jul 11, 2025 at 1:19=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >=20
> > On Thu, Jul 10, 2025 at 9:27=E2=80=AFAM KaFai Wan <mannkafai@gmail.com>
> > wrote:
> > >=20
> > > Show the precise rejected function name when attaching tracing to
> > > __btf_id functions.
> > >=20
> > > $ ./fentry
> > > libbpf: prog 'migrate_disable': BPF program load failed: -EINVAL
> > > libbpf: prog 'migrate_disable': -- BEGIN PROG LOAD LOG --
> > > Attaching tracing to __btf_id function 'migrate_disable' is
> > > rejected.
> > >=20
> > > Signed-off-by: KaFai Wan <mannkafai@gmail.com>
> > > ---
> > > =C2=A0kernel/bpf/verifier.c | 2 ++
> > > =C2=A01 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 275d82fb1a1a..2779d63e1f8b 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -23938,6 +23938,8 @@ static int check_attach_btf_id(struct
> > > bpf_verifier_env *env)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n ret;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (prog->type =3D=
=3D BPF_PROG_TYPE_TRACING &&
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btf_id_set_contains(&btf_id_deny, b=
tf_id)) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 verbose(env, "Attaching tracing to __btf_id
> > > function '%s' is rejected.\n",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tgt_info=
.tgt_name);
> >=20
> > "Attaching tracing to __btf_id" ?! What does it mean?
>=20
> The term "tracing" refers to BPF_PROG_TYPE_TRACING. I believe it is
> useful because it helps identify which functions cannot be attached
> by
> a given BPF program type.

Thanks, this is what I want to express.

> Perhaps we should replace "tracing" with "a tracing prog" for
> clarity?

Looks good, may be 'tracing programs' could be fine.

>=20
> > Drop "__btf_id" and "tracing" bits.
>=20

--=20
Thanks,
KaFai

