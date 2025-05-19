Return-Path: <linux-kselftest+bounces-33339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855A1ABC5AB
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 19:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24D8A4A3702
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 17:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7840A288C2A;
	Mon, 19 May 2025 17:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="arcfNm9d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F175227C144
	for <linux-kselftest@vger.kernel.org>; Mon, 19 May 2025 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747675906; cv=none; b=SGRDQ9x0GovLsiVCJb6jMBmE84hDGZAy77mH8Y2/91ywSstYmxi85yhWvQ9Xt2ONrg5Qno6yNFXO4fOnTSZ5P9/Dm2q7H+9NNE2wgfB6y4/rzkmne5OMtJyIVL2/8abE7uudPW48atpKLGS/coLPSXs+QimDFlcl1CNCesA8BA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747675906; c=relaxed/simple;
	bh=jLy2szwDWHqqJviMtbGQnTN3ULw2S8OhfWEULUU5naU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IRU3KKedWznKHtmXg1wrgyFWMZ/hDMqbAuzIO0EqEoPWR+72EgqqDlaKsm3Aqrw5KwqyyQzOmOVy1yZoyJxhBuJki0gaKfUVQhB+trgI5asv7MXIaWR4yQsRgYWddQbfeq/sTxHYa82wqzYRrgpnqDAbf6N4qSAdzCsrMTKzlyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=arcfNm9d; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-231f37e114eso477425ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 19 May 2025 10:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747675904; x=1748280704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmvWuYAzDFR95No8NLEp3J02kOMT0LgXSZkJsXShgyI=;
        b=arcfNm9dzdfLscpmlpVDEvs2TKM5Mi2Z0WnjOxp7rGYONICbU89yYSsQmFGLqcVAII
         Nxg6tY2KSq/Q9ktudvd4ARVthPepxN31bytwyFggTJqYRomqziiueimd+urSo0E+7yod
         4ugEKIMR+E5zSuniz//0HzZoBkiValRZwD7JgDOh5lwmx/ihw3uBG85IV6NyeD7yhdSw
         CYnWmYU6niokcl0IWDXz6/mrL/0avUIhemJ2eo4M3FvCuDS+ru/sfGI0b2N3wlhgUo7y
         7wiqts48lRx44UlZfrYuq0cPl9WN2vdQ3GPT7B7oRq4o1SNEGb0dQmw4BOK4VjzWwAyB
         154A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747675904; x=1748280704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmvWuYAzDFR95No8NLEp3J02kOMT0LgXSZkJsXShgyI=;
        b=VbbDNflpEPBXq4AigfzYpxSO42gIbvI8g0nOmToZXpaDSzJBodJYH0zbtUE4g72EHT
         Xg6NQfiZKLvyNVzPgx4biZ3Y8MxUHpD9m0ASYzThxjNPZDO4HC1uB5kVzuCc9z2TEoA/
         dsyQoJpgtukiHmtaJP06a9g3AM9L4ZYkQk5o7F/wag+j2U4sN1beG98gw3yILmAE6prn
         +klEfGVAbKqYlryZY+jJcRvTxOoE4LxmeiGM2yGP1P+a3AHlrBk7pEqTJVCcJibgMITz
         SECXKZp3YZTxrzWhIWozVL5SkFhEnTSkE/V0d7FJ/Ja8pivZDCFRB85psbr02GO4g17j
         MH3A==
X-Forwarded-Encrypted: i=1; AJvYcCUj8PSlhDX7CU9MZDZztGb9RQr0/Pz2P78XaZ5ykpbwCw1shSQT/7T09EY71GXQfK0rbBNviALMvMX3f+pHgS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR1hUpMn61/iEBKKNbt7nWlstt9PjO17UHzsuuQct1nUS7H3uq
	vk4tkMvDj1c5PihxqRrncZQdNB/EmI/WczBA4hoQlONPvX73zb8YOZ3UBSk41H2IxlgEc/X3Fpz
	C/OHGLL4/0D8TvzuiBcpSDJtTyd2ZTOUcSYUXNZdz
X-Gm-Gg: ASbGnctGow+spgMECXduXA4uoHZBGGgRpNzsm5EIT1VSceP6FjWBDmsHdG3s0BvVNTq
	/Z2SHAIizzS77FIheP+vRTQqCoJyzUm0h6rdu/Fq4mw6a+BnYGEWMd+oQKnbhgkDsKabWtE4H3d
	eAsR1pR8tGJ5FNfPUDiCHlm0jenk0+63y7qfev9UE2AYyQ
X-Google-Smtp-Source: AGHT+IG+ExyKgE3ruV/gl5M9ZTWtLqmpbXPFt1mRf9GKepoZU4AoYFfOGioK8r7ghizA4noQkXhiVCYtew70Mv8tqF8=
X-Received: by 2002:a17:903:290:b0:215:f0c6:4dbf with SMTP id
 d9443c01a7336-231ffd3192fmr4993165ad.14.1747675903859; Mon, 19 May 2025
 10:31:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519023517.4062941-1-almasrymina@google.com>
 <20250519023517.4062941-6-almasrymina@google.com> <aCtPEBmBFvM-bA_i@mini-arch>
In-Reply-To: <aCtPEBmBFvM-bA_i@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 19 May 2025 10:31:30 -0700
X-Gm-Features: AX0GCFs-Ut1FZDyYbbaHFHUXedO7i5T9SEf7r_1r-9FnEhuG-l96h6IGYWAaNwo
Message-ID: <CAHS8izMjCX=PkU0bE6s46uXxrnHjP71G6LN0v6oQumNa2Mouzg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 5/9] net: devmem: ksft: add ipv4 support
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	ap420073@gmail.com, praan@google.com, shivajikant@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 8:32=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 05/19, Mina Almasry wrote:
> > ncdevmem supports both ipv4 and ipv6, but the ksft is currently
> > ipv6-only. Propagate the ipv4 support to the ksft, so that folks that
> > are limited to these networks can also test.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >  .../selftests/drivers/net/hw/devmem.py        | 33 ++++++++++++-------
> >  1 file changed, 22 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/t=
esting/selftests/drivers/net/hw/devmem.py
> > index f5d7809400ea..850381e14d9e 100755
> > --- a/tools/testing/selftests/drivers/net/hw/devmem.py
> > +++ b/tools/testing/selftests/drivers/net/hw/devmem.py
> > @@ -18,30 +18,36 @@ def require_devmem(cfg):
> >          raise KsftSkipEx("Test requires devmem support")
> >
> >
> > -def check_rx(cfg) -> None:
> > -    cfg.require_ipver("6")
> > +def check_rx(cfg, ipver) -> None:
> >      require_devmem(cfg)
> >
> > +    addr =3D cfg.addr_v[ipver]
> > +    if ipver =3D=3D "6":
> > +        addr =3D "[" + addr + "]"
>
> I think you can add [] unconditionally, no need to special case v6.
>

I'll double check, but IIRC the [] were v6-only.

> > +
> > +    socat =3D f"socat -u - TCP{ipver}:{addr}:{port}"
> > +
> >      port =3D rand_port()
> >      listen_cmd =3D f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr_v=
['6']} -p {port}"
> >
> > -    with bkg(listen_cmd) as socat:
> > +    with bkg(listen_cmd) as ncdevmem:
> >          wait_port_listen(port)
> > -        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP6:[{cfg.addr_v[=
'6']}]:{port}", host=3Dcfg.remote, shell=3DTrue)
> > +        cmd(f"echo -e \"hello\\nworld\"| {socat}", host=3Dcfg.remote, =
shell=3DTrue)
> >
> > -    ksft_eq(socat.stdout.strip(), "hello\nworld")
> > +    ksft_eq(ncdevmem.stdout.strip(), "hello\nworld")
> >
> >
> > -def check_tx(cfg) -> None:
> > -    cfg.require_ipver("6")
> > +def check_tx(cfg, ipver) -> None:
> >      require_devmem(cfg)
> >
> >      port =3D rand_port()
> > -    listen_cmd =3D f"socat -U - TCP6-LISTEN:{port}"
> > +    listen_cmd =3D f"socat -U - TCP{ipver}-LISTEN:{port}"
> >
> > -    with bkg(listen_cmd, exit_wait=3DTrue) as socat:
> > +    addr =3D cfg.addr_v[ipver]
> > +
> > +    with bkg(listen_cmd) as socat:
> >          wait_port_listen(port)
> > -        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_remote} -f {cfg.ifna=
me} -s {cfg.addr_v['6']} -p {port}", host=3Dcfg.remote, shell=3DTrue)
> > +        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_remote} -f {cfg.ifna=
me} -s {addr} -p {port}", host=3Dcfg.remote, shell=3DTrue)
> >
> >      ksft_eq(socat.stdout.strip(), "hello\nworld")
> >
> > @@ -51,8 +57,13 @@ def main() -> None:
> >          cfg.bin_local =3D path.abspath(path.dirname(__file__) + "/ncde=
vmem")
> >          cfg.bin_remote =3D cfg.remote.deploy(cfg.bin_local)
> >
> > +        if "4" in cfg.addr_v:
> > +            ipver =3D "4"
> > +        else:
> > +            ipver =3D "6"
>
> If we have both, we prefer v4, can we do the opposite?

Sure, but why? Just curious.

--=20
Thanks,
Mina

