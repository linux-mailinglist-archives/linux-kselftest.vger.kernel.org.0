Return-Path: <linux-kselftest+bounces-11585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6BE9027FD
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 19:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40CA71F23594
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 17:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C5014C581;
	Mon, 10 Jun 2024 17:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="HdZy45Vn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5A314B96C
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 17:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718041786; cv=none; b=FPHTywgGWRWDFFV+yXEBhbCe20/3p9btAcrhdydUdjOlITd2wK0VGyR4su88fbrViHRBH3CDpswDnjq2iozWZOLaA6cMPNEzEtJ7UysgczDVIsE0fVxaoe6cgFCTvgRohxkLlp4MFTEDqumX5CH+zPyscvSIyHPUHtkPfqL30Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718041786; c=relaxed/simple;
	bh=kaN+OH8u0mjuLsUgDZzqsqHcd5qKUZnSBirUfTBy/rs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mIGAkmXApEgkayHTJd7txMfq7TgJfp4J6jsmBVsfS6i5VsYw4pVa36hy2PnJgQXBsmrAG9/vP/y2S5oBf23VZUFmyHzbnPMcRgULH0LHNy31V4ND6HpLom70f5nTtOyXO/1JqtRe09x8P7zk/HBcXAqhb7wfP8wstVCKFxHcecQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com; spf=pass smtp.mailfrom=jrtc27.com; dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b=HdZy45Vn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jrtc27.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-421f4d1c057so8796695e9.3
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 10:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1718041783; x=1718646583; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Zyb+ujtIGgfui3VzqiGKyVsxQvcv7H95kxqnj+CmxU=;
        b=HdZy45VnEKiQ+w8OWBY/zHujgtcZXRFEAEziOdL+tkGektfnFC2af1F3ya7tmHVtNB
         OcJP5t4BzifNIohd4fJWUPM8KGy7At1uQ5MRY+rd19ONb1heKniuRh8X8cZHKSQgmefp
         Xk1d2RstDNSGJdiYOx8nU/j5jD6JPRQBvvU+K1ZdqMSVegOiS3TziZdQ6kkjFATVEsvo
         Tyf93Y19Nz+XuH1LyBQwt5uF2AwnJMxIihwaPD5Lqh8VzCaSHl05eIxlxDTxU5TF3EAe
         ynAnS40CZ68yCZJPr1uhgFIFMOGsgCaIoW0Ear4295v2x+TEOM3ALQFd9j0Xv3QVNcyH
         20Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718041783; x=1718646583;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Zyb+ujtIGgfui3VzqiGKyVsxQvcv7H95kxqnj+CmxU=;
        b=tvvO9Ek2Tsx/sejQe51Bjq2h+jt3DBdxWF5qD0i5IzRHqviLLb23O8ckLKP1JWvKOp
         Ab2thjxaxJ7cUfuAylGTWFVLKLHPI7HU80Qj7J+YfW3KkdVvI0h15zaf4Q5xx+QtC7QJ
         FlixODDm7ZyVu2U+F/DokU6WqaN9YNSpachUKi5ehWWO18e9JvzLIJEvUWVMAj/a+eKx
         AUd3qvdSmGtkkZ/YqPnpRumnSDO1RtmVvMbjsTarb27aL+pCmsu8QKnEyjRYsIBNa1tc
         wZX4KbJuUsT3EIoeodkLnNDxajbnvzo27nEoW/UkZP7eQG51kLbw2wRGjRfaa6Us/trQ
         X+Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVi7SRA1lCc4vKR1ieK3DeuGcUu3M3ZLZY+PIBKgcYBua6YNJq20TRnFLEaNfhWGK/6NdeVdldxkiBHvdYsz4fmUBAnkmzmMVmEIJFWFFom
X-Gm-Message-State: AOJu0YyiE675MNHk9YZUXJspSOuv3GR4saOcwAfFTWu9pkbON6MqOM7f
	WrpwqecUDvrwC8U5B5uHi4HhS5qCaO2v0B376XQd3YkJudoVnI7Yy8WvJwOPJEM=
X-Google-Smtp-Source: AGHT+IGOL4J84jhPB6MOYY7C/yQXa66itQV4TEzYbITX4tGHe/3k2ra5FCnezqsLOntd6VEWEWr5PA==
X-Received: by 2002:a05:600c:1ca3:b0:421:6b79:8900 with SMTP id 5b1f17b1804b1-4216b798c9cmr55824915e9.41.1718041782597;
        Mon, 10 Jun 2024 10:49:42 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c19e97dsm149074925e9.5.2024.06.10.10.49.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2024 10:49:42 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH 03/13] riscv: dts: allwinner: Add xtheadvector to the
 D1/D1s devicetree
From: Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20240609-xtheadvector-v1-3-3fe591d7f109@rivosinc.com>
Date: Mon, 10 Jun 2024 18:49:30 +0100
Cc: Conor Dooley <conor@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Jisheng Zhang <jszhang@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>,
 Guo Ren <guoren@kernel.org>,
 Evan Green <evan@rivosinc.com>,
 Andy Chiu <andy.chiu@sifive.com>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-sunxi@lists.linux.dev,
 linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FD6771F5-5739-469A-9C0B-952AAC62AB68@jrtc27.com>
References: <20240609-xtheadvector-v1-0-3fe591d7f109@rivosinc.com>
 <20240609-xtheadvector-v1-3-3fe591d7f109@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 10 Jun 2024, at 05:45, Charlie Jenkins <charlie@rivosinc.com> wrote:
>=20
> The D1/D1s SoCs support xtheadvector so it can be included in the
> devicetree. Also include vlenb for the cpu.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi =
b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> index 64c3c2e6cbe0..50c9f4ec8a7f 100644
> --- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> @@ -27,7 +27,8 @@ cpu0: cpu@0 {
> riscv,isa =3D "rv64imafdc";
> riscv,isa-base =3D "rv64i";
> riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", =
"zicsr",
> -       "zifencei", "zihpm";
> +       "zifencei", "zihpm", "xtheadvector";
> + riscv,vlenb =3D <128>;

thread,vlenb

Jess

> #cooling-cells =3D <2>;
>=20
> cpu0_intc: interrupt-controller {
>=20
> --=20
> 2.44.0
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


