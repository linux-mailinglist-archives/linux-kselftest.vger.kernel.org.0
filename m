Return-Path: <linux-kselftest+bounces-23381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4528D9F1C5B
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Dec 2024 04:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6910E160835
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Dec 2024 03:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B19E18AE2;
	Sat, 14 Dec 2024 03:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlxzEz5y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14E717BA0;
	Sat, 14 Dec 2024 03:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734145989; cv=none; b=HMjNdwC0FrSVH4vrE9x8MRA+iHcg0fMTqN3QKo7CmOCkys51BQS7Pf5E/6+VMu4cXyp7gBiWR08zrxaRco2z7MAbtoLgHSro4HH0rl2VE1XHwB2YUDAct6IC2iUvfr/8+DIsRE7TScSNlfEzfpBbcI5jpsnkKhLdevEVHOwIsWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734145989; c=relaxed/simple;
	bh=bY0Ub7h1mkKBCXqjM3ZJtfLY3vz1fgQunWjz4C3H0LE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vk6SAZQvSs91g77IOcH3TlvQSQXYJSFBJy6h38Xx4kBiGszLvz9TmdoNZ2hdTVxf0TyzXxCsKPLoSyVqSJiGkZ0kGFn3T/vbs2rAwhiNbBf5hb5qiwxFW/8U+weOI7zhr9M6cSduqCzkscKN3Kl4Wfem3OuDFT113udbAthSeWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlxzEz5y; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee989553c1so2005284a91.3;
        Fri, 13 Dec 2024 19:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734145987; x=1734750787; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MGnbmpAa9ZP6/xXH5KW1Ji9h2vWQBr1my9Uh1p7fSgQ=;
        b=WlxzEz5yQWTIz47N3wh7fa+oEhsv+h335ayFBWojedkb/rn+Vvw6BUxe0M62CI0Q3D
         iSLCqMhoBEzD10L3jVI4cmi0NbwLdZG7Igz4K0ei+B+KKR02JUPXq11JKnM3FwYgC8u7
         Qe9s6H683EJmG64Ux9UVRi63oT6UlWxVa7czPlklHtigsxi67VoRKcRGV82MRpKvK8RP
         R8bt/858M187+GqhBdUJUV87dCwPZb52R/XdzNOOyqkFh2ya4rR5eP0TOivzm25qGjFK
         eqAasudc82EvFSaOobjJh9KIuDTKu8FkPJSrb95Eru4MwUPS5lNvQrneaC7b8sFmBFAs
         rPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734145987; x=1734750787;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MGnbmpAa9ZP6/xXH5KW1Ji9h2vWQBr1my9Uh1p7fSgQ=;
        b=aNNf4vOjGBmZ8DsR3avk8i0NI5mC0NcHUL1Y4NbRdjyDBBY4Q4ZK1Yk1E3JNB6yszL
         YGOkhWAWhAQyRnUMJrWMif8DljoTMQ4c9SJnEPI8LCR9m/jhP4G22evtqEhNRCvNhTGE
         nE+6CzgdQw7wTCqo+gXXd+YzP7yvsPdzhHbX1HZX5T6rjOjxIzE6M1tRR/Zh9AXDqIbS
         lTwMDPrXn76oD9um2HqVIYyhlfeoA5rrWKLeFG1hpSyA/Kfwjk1qVwf3QbfPuQPxX8oj
         S+f710cIDhDzupg/jbX4cF7Wuftv5woFm1rsYVq/XShMw7JkKyydve09igdd9oWJe4d2
         h16w==
X-Forwarded-Encrypted: i=1; AJvYcCUVDkBo0yoVi0ZffXA1yRIrNHAu8fSPjJcY1vw17PIbd3PXAxUyI9dmMop4tmOg9ocd+uBxIx5l@vger.kernel.org, AJvYcCUmJ8gQRnNs9T0SkNyrw+PRBaChY9sZZzQMWCHpCePDh8mrc9TlM90BtNl3g4itTl5AmvCdakcnd/oTVN7XNA9l@vger.kernel.org, AJvYcCWHXf3DwMuvioXczbmrehoGmRIDb/e6tldwj6gPMUdG1DZ+9orrXyA9uupbEmetNEFedxmkBCAsYW+otqSx@vger.kernel.org, AJvYcCXA7Uk5VZDaDjNbCvzqP14wlCJE/OT95HHj4dn8QlE/Wln1eE+cpSr8H6e2OvJulxqgwYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEB27qEJTWdA7/lJgiHc2xVhDN/YAOjk2pjTwNWWwO+DIl2s76
	REUVZQrMjr6vrOueyxNLEndPPsMjc4SaC2qa1T3TXhyhUhEbM/q0
X-Gm-Gg: ASbGncshCmlZzHQUxZ27Eu6CPlRX/W4j8/Ol+fD18CZAz7I47lnw1yDKpknjM3XerQx
	LL5vJnxhsC0vNjPwBYuvbno+D7JbbDuEEt6HYahb/uT0Ngl7JG1UTrqaAq3kiCwikxqj8tLNoH0
	dW130u/oL/6PLL9qqMs5QSNdYqQsEXzGVcqY4UWNjLaVL26BL8623+rvTbDdXo+qLXBzHTkpmru
	PKEXf79hz7V5RfWiIFQ5Luv5qAB8svT40i8v1F688FDl+zURk4iFA==
X-Google-Smtp-Source: AGHT+IENh6kaWeXnu8fwwMW2nSzym81aheY0fV7iaR4a2SeUglPwPDD8tP8wKQavEkxBU7g9BGf3Yw==
X-Received: by 2002:a17:90b:3502:b0:2ea:9ccb:d1f4 with SMTP id 98e67ed59e1d1-2f28f863210mr8509251a91.0.1734145986921;
        Fri, 13 Dec 2024 19:13:06 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1db8676sm4573285ad.12.2024.12.13.19.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 19:13:06 -0800 (PST)
Message-ID: <31b0c85dbf85486df116ade20caf8685843899b4.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 4/5] bpf: verifier: Support eliding map
 lookup nullness
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, shuah@kernel.org,
 daniel@iogearbox.net, 	john.fastabend@gmail.com, martin.lau@linux.dev,
 song@kernel.org, 	yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, 	jolsa@kernel.org, mykolal@fb.com,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, 	netdev@vger.kernel.org
Date: Fri, 13 Dec 2024 19:13:00 -0800
In-Reply-To: <zow3q3nhlz6vedbni3upag5yr7zzrhyiqysl5nwyubebmbwojk@th7kbm62x36g>
References: <cover.1734045451.git.dxu@dxuuu.xyz>
	 <92065ca054beccd6d0f35efe9715ef965e8d379f.1734045451.git.dxu@dxuuu.xyz>
	 <CAEf4BzaqCgW9keiT+tJUBQWT6Q+jMwuvn4O2ZghO0c+ZvACNrw@mail.gmail.com>
	 <zow3q3nhlz6vedbni3upag5yr7zzrhyiqysl5nwyubebmbwojk@th7kbm62x36g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-13 at 19:44 -0700, Daniel Xu wrote:

[...]

> > > +       /* First handle precisely tracked STACK_ZERO, up to BPF_REG_S=
IZE */
> > > +       stype =3D state->stack[spi].slot_type;
> > > +       for (i =3D 0; i < BPF_REG_SIZE && stype[i] =3D=3D STACK_ZERO;=
 i++)
> >=20
> > it's Friday and I'm lazy, but please double-check that this works for
> > both big-endian and little-endian :)
>=20
> Any tips? Are the existing tests running thru s390x hosts in CI
> sufficient or should I add some tests writen in C (and not BPF
> assembler)? I can never think about endianness correctly...

I think that if test operates on a key like:

      valid key 15
             v
      0000000f   <-- written to stack as a single u64 value
      ^^^^^^^
    stack zero marks

and is executed (e.g. using __retval annotation),
then CI passing for s390 should be enough.

There is a guide on how to gen a s390 environment locally:
https://docs.kernel.org/bpf/s390.html
I used it recently to build a vmlinux for s390 with no or minimal
issues. Used it to boot long time ago, but don't remember if there
were any surprises.

> > with Eduard's suggestion this also becomes interesting when you have
> > 000mmm mix (as one example), because that gives you a small range, and
> > all values might be valid keys for arrays
>=20
> Can you define what "small range" means? What range is there with 0's?
> Any pointers would be helpful.

I think Andrii means that each 'm' adds 8 bits of range.
E.g. range for 0000_000m is 0-255, range for 0000_00mm is 0-65535, etc.

[...]


