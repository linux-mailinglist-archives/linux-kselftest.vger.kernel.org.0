Return-Path: <linux-kselftest+bounces-35718-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D754AE726B
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 00:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB9BD7AAA60
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 22:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA832185B1;
	Tue, 24 Jun 2025 22:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0wzmRSF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F71307498;
	Tue, 24 Jun 2025 22:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750805148; cv=none; b=svUz6dZeIPL5FQ8E2ow2DbLyiMz4CbOm4sUOQIbItvVx8JI97MguqLlyuCy5prhiGu/yciifKVZNH0GsEQdOzDQAsISMlVTkvK3+x1vMwAb4b0aUnHqzdfKntxYDHnr6REjCxAPjGKG2aPezFjcJgPUmts04XWvYvHuyL7OGQac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750805148; c=relaxed/simple;
	bh=c0rNXYDA0febqT+LdRoqUDwgUBZCsO4Aib/HU0ELOfc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tlrloxXD1Vg5xf/3AW/9WrylchDRzpgHCvYuQ16xpJTDzAvffQTFq2K+Rdw4tjt6HxS+NikWNh0HKDsgT+V5ekcsuIkYcbQZxCHi7sRoBHU/3Kj9Q7RiW4mnr6fTKK+0zwZldxX1NeDpOCM+CoPxJg36USZgB5imgFcxhHGStXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0wzmRSF; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31332cff2d5so1013227a91.1;
        Tue, 24 Jun 2025 15:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750805146; x=1751409946; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9EemXXZZ6BDvxXMOUZ56YC2ql3UmLuMrwN19WVcHw5A=;
        b=I0wzmRSFrqjfwAnQIgfEX6Q9j2RQMpywH7bdKWXQDsSn7RASNhD+5TPoMS/HzH/KP1
         waF3V2p6pWEzGJyTXFE1MBqbGlztgMiS5xaVYcuD7vcTn44kew3xgbBI3B0u+qsmQWXk
         BuRqFbTKRs7GlziYOvnWhKqMFTddXf0dx7HU3N70/AkCa6GOPNM8T06HDPQrZKIXuBCo
         iDtgef89l80LXbcy/xJErmHz1tA1ahGymeDyxqxhwsQcdApG5Zxy8Nteh+h3gmlAtA3P
         fEOo9Yzob35eqBU9RYXnVPNH7ZquFB4Wkc+s5NKOZqu3W3132QM91e2u673lKiqy+PFw
         5f9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750805146; x=1751409946;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9EemXXZZ6BDvxXMOUZ56YC2ql3UmLuMrwN19WVcHw5A=;
        b=N8xxZ+1VxGkxOsvnstdnyDg+fy7LoshrLIU5QpYVxw/porU1rOj8zYQthLgNBYT3x+
         sIxxDRomFDAXrqV3kORbf7lXcRi57ikch93m3NFhLxj/qe9bbW3gLR2BeVuEQeCBc9XA
         rfT5l2dBJ+p47ExvMg6ESy9I8jauwf0v1lxwBY2gWiOf5Yu6k7OTkvHq0coCiFkXryv4
         Om8uD2nNeSXnpcWp0jK64dO+jUX5YQrjkclR2ajgBw21T5MXj50By4LJW8fvodljejac
         I5aRN+xYFcFnhv+LGflIi/vL01yKGb+jwdVd/yZa9G478WqtcWiGBW3cO1X5x3m3MQN5
         rPZA==
X-Forwarded-Encrypted: i=1; AJvYcCUgPC5+VEDLWRwFln9XnYrTqugbCCgVt3vEcXBCqu9xFKP8tt6jnxbf4F3DSFOYC9sT8Ch6bPXr2Vj/fn/jPZpj@vger.kernel.org, AJvYcCUv6wt3WT2C+xep8uwpSA96QFYPoe/ZBLQOsu+8zd0px+Vft7Ol/DGYBrGaiZddLB1lhbA=@vger.kernel.org, AJvYcCW4D/UQ6w0+Tymv7mpUHFoq4q/Txf2fODmYEWh+tAD0SPdWUYKWCqSyIqcyJiRJx7+t6tVpFZLEHLyicVJc@vger.kernel.org
X-Gm-Message-State: AOJu0YwE7czpqZMzMvQryCQ21lOopZEjU4b+YgvotkYQHC/Iapn4a7MM
	r/pxd7WjXZvXqiipQYqIpXElYXGItuSkc3fUSNKfZHw3dsDpmtw5MbEL
X-Gm-Gg: ASbGncvHibRPR4hzj3BPx1aWiNpXNs1mq8wFCxrVBA7Ho7KgtdwrdevWZUaHT09bPIc
	qNS3ZwUh0KS3cDlSC0kWa5WSs39nRRm8kJ6ncyoQ9a314urARAT/Lar65B1agLBPOivjnZmA1bE
	rkM+A8rPNGJa9hM3UFFMEYUf7hEyJ7SwtGUdas12ODxnC+8xVnqssqABgm/bMd8YkXygl6TEQW2
	b5HHPKv1NasOIkARzVBnkW8An2ccbWrrZxQy5v6C9ySpae0gCMVTfXsrPW64Xy15EKJL7BMODza
	CGs8q19KUZhOst9E7daYHJqVOqnVOJRdraeXbYMnP9qgOCmqIeBEZpfTizArwMx1CfRMI6XJaVG
	SXfgtelAGKdDm6uizWp4o
X-Google-Smtp-Source: AGHT+IFhaaX9+UnX/Z7N5jebY36n/Vld/1GOnsO4Hdi9Rdtqnx3ti/lPfQwlOQtTMiOmjIAUJzHEyw==
X-Received: by 2002:a17:90b:5484:b0:311:ad7f:3299 with SMTP id 98e67ed59e1d1-315f268aa55mr700631a91.25.1750805145867;
        Tue, 24 Jun 2025 15:45:45 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9b77:d425:d62:b7ce? ([2620:10d:c090:500::6:f262])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f5386edbsm163109a91.6.2025.06.24.15.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 15:45:45 -0700 (PDT)
Message-ID: <460a82dd188203e9da23cf0606845b593097faaf.camel@gmail.com>
Subject: Re: [PATCH v3 2/2] selftests/bpf: Add testcases for BPF_ADD and
 BPF_SUB
From: Eduard Zingerman <eddyz87@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, 
	ast@kernel.org
Cc: m.shachnai@rutgers.edu, srinivas.narayana@rutgers.edu, 
	santosh.nagarakatte@rutgers.edu, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Mykola Lysenko	
 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Matan Shachnai	
 <m.shachnai@gmail.com>, Henriette Herzog <henriette.herzog@rub.de>, Luis
 Gerhorst <luis.gerhorst@fau.de>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Date: Tue, 24 Jun 2025 15:45:42 -0700
In-Reply-To: <20250623040359.343235-3-harishankar.vishwanathan@gmail.com>
References: <20250623040359.343235-1-harishankar.vishwanathan@gmail.com>
	 <20250623040359.343235-3-harishankar.vishwanathan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-06-23 at 00:03 -0400, Harishankar Vishwanathan wrote:
> The previous commit improves the precision in scalar(32)_min_max_add,
> and scalar(32)_min_max_sub. The improvement in precision occurs in cases
> when all outcomes overflow or underflow, respectively.
>=20
> This commit adds selftests that exercise those cases.
>=20
> This commit also adds selftests for cases where the output register
> state bounds for u(32)_min/u(32)_max are conservatively set to unbounded
> (when there is partial overflow or underflow).
>=20
> Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.c=
om>
> Co-developed-by: Matan Shachnai <m.shachnai@rutgers.edu>
> Signed-off-by: Matan Shachnai <m.shachnai@rutgers.edu>
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

Thank you for adding these tests.  Even with "human readable" numbers
took me 15-20 minutes to verify the numbers :)

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  .../selftests/bpf/progs/verifier_bounds.c     | 161 ++++++++++++++++++
>  1 file changed, 161 insertions(+)
>=20
> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/=
testing/selftests/bpf/progs/verifier_bounds.c
> index 30e16153fdf1..31986f6c609e 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -1371,4 +1371,165 @@ __naked void mult_sign_ovf(void)
>  	  __imm(bpf_skb_store_bytes)
>  	: __clobber_all);
>  }
> +
> +SEC("socket")
> +__description("64-bit addition, all outcomes overflow")
> +__success __log_level(2)
> +__msg("5: (0f) r3 +=3D r3 {{.*}} R3_w=3Dscalar(umin=3D0x4000000000000000=
,umax=3D0xfffffffffffffffe)")
> +__retval(0)
> +__naked void add64_full_overflow(void)
> +{
> +	asm volatile (
> +	"r4 =3D 0;"
> +	"r4 =3D -r4;"

Nit: there is a change in the workings that would make range
     propagation in negation instruction, a better way to get unbound
     scalar here is e.g. call to bpf_get_prandom_u32() or read from a
     constant global map.
     Depending on order in which patches would be accepted this rework
     would be either on you or on the other patch-set author.

> +	"r3 =3D 0xa000000000000000 ll;"
> +	"r3 |=3D r4;"
> +	"r3 +=3D r3;"
> +	"r0 =3D 0;"
> +	"exit"
> +	:
> +	:
> +	: __clobber_all);
> +}

[...]

