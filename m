Return-Path: <linux-kselftest+bounces-19263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4BE99589F
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 22:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F7C1F274AA
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 20:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE2A216A24;
	Tue,  8 Oct 2024 20:38:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB2B215F58;
	Tue,  8 Oct 2024 20:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419891; cv=none; b=M0lIWLUMp2DLHS6fPbMRmai93jJ2aHOc8HE2/6cd8cQWM46WyqZBV2+9zrZOuOyvafgOgOjhbNfhOI0NQMrQWE2P4Fv/WDmQaJQoMSx3V0BLt92tYYzJEjds5tSjVxmc+k3W8ZRrKBjoi/749PG/5qRSH5HxZWxbK8FfvuckOk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419891; c=relaxed/simple;
	bh=UN3Ilr8a5H7ERvhimlB/Q4hI3Y5ih6eglT4M6XFxed8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENC2PX98LFGnoSzpcvF0uNxaxGguGvnSFozgchcfJEVK+e3Sxx7xLT+eSU1T6VQNmTuR44qWzJLBjI++PGTSAqRsAnOzP7cJMh6AbmgQhZvW8T9m2cFrqxPZqZ/smDOuCOiMzN2xsuVHPrO4BPIqhOBpWSP0XW0GSEdn+BapCbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e262e36df27so200289276.0;
        Tue, 08 Oct 2024 13:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728419889; x=1729024689;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLQWcbSeACwcvaqhHPxSN1w4SwChShyv5tLpM/fC9Yk=;
        b=GpjxgtHihiolBiSOWoL4QMPN1ZYWEZZqhVi7mOPL11Ls2AVHcckMELFSxjCfmcp7s8
         ua/S+RlN2qUGHtEqLMVB+Hh15Wi6T8lqYnXW6nXrXrtvSFV/b70fvebR1Y7DUhgB5u5c
         fWh7Y/Nk1LQxKbCOVGI6mNTkPeHOYwV5/6lqxRAmH0mgILWk4Bz0LfmOiFFvfzlp6DtK
         O2xQ6MuID8oUyk+K3i6Xn77rjnVpxcre8ccA8/4/qxgI7/U3HNFvK1jsGV3wKIk6C05G
         eUne5gQJAo0t2zEVVwBtHj+iGS0DPlOdRuZO6wxfmFc3BKZRtrgb5Vbf+t60Tc3aK8qH
         4LyA==
X-Forwarded-Encrypted: i=1; AJvYcCUUBabSlRkH08RORfVPO74d2FMgVsSKoLAqLSwDRYQaQWk7K/JCd/1LmfiX7JA8x0N8Cw4=@vger.kernel.org, AJvYcCVEBZ7TCB0V8c9opC+UBZoXJJUKEnpAFbMwHpCibn1ZCLfqcIN6fOsT/Z/aUKoHg8g1W7jPDGJYBXj4QMwtKFXI@vger.kernel.org, AJvYcCWM1U2bQUMKAU0FXxSb1Q5ohqWBuco/QghAeLtIwWcqAKpef3ayHYIeglqRP+FEeMHFgsw3TRaryCS2AB28@vger.kernel.org
X-Gm-Message-State: AOJu0YxZHY7bRFMk8FWNIS5EJ2hacV07w0A+SS7aB1PLQKT9dzl6VXzl
	c3PQ2MrbJIkkIGtTgvAMk+i4l7Wf17Fb5P44PiURiePoDrhd6dlwR/sGkQ==
X-Google-Smtp-Source: AGHT+IH/wdL65vivp7PfrfQVA0fDIsUhc54pvWm6lDQKZwpUQZzp6PARgfrfCuhPvLMyd4Pc0FL/nQ==
X-Received: by 2002:a05:690c:f90:b0:6dd:ddf6:90aa with SMTP id 00721157ae682-6e3221994f1mr3766917b3.5.1728419888888;
        Tue, 08 Oct 2024 13:38:08 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d927f2ecsm15876017b3.45.2024.10.08.13.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 13:38:08 -0700 (PDT)
Date: Tue, 8 Oct 2024 15:38:05 -0500
From: David Vernet <void@manifault.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH v3] selftests: sched_ext: Add sched_ext as proper
 selftest target
Message-ID: <20241008203805.GA11867@maniforge>
References: <20241008153519.1270862-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FfRfl7W5WtKub8Po"
Content-Disposition: inline
In-Reply-To: <20241008153519.1270862-1-bjorn@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--FfRfl7W5WtKub8Po
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 08, 2024 at 05:35:18PM +0200, Bj=F6rn T=F6pel wrote:
> From: Bj=F6rn T=F6pel <bjorn@rivosinc.com>
>=20
> The sched_ext selftests is missing proper cross-compilation support, a
> proper target entry, and out-of-tree build support.
>=20
> When building the kselftest suite, e.g.:
>=20
>   make ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux-gnu-  \
>     TARGETS=3Dsched_ext SKIP_TARGETS=3D"" O=3D/output/foo \
>     -C tools/testing/selftests install
>=20
> or:
>=20
>   make ARCH=3Darm64 LLVM=3D1 TARGETS=3Dsched_ext SKIP_TARGETS=3D"" \
>     O=3D/output/foo -C tools/testing/selftests install
>=20
> The expectation is that the sched_ext is included, cross-built, the
> correct toolchain is picked up, and placed into /output/foo.
>=20
> In contrast to the BPF selftests, the sched_ext suite does not use
> bpftool at test run-time, so it is sufficient to build bpftool for the
> build host only.
>=20
> Add ARCH, CROSS_COMPILE, OUTPUT, and TARGETS support to the sched_ext
> selftest. Also, remove some variables that were unused by the
> Makefile.
>=20
> Signed-off-by: Bj=F6rn T=F6pel <bjorn@rivosinc.com>

Thanks for the improvements!

Acked-by: David Vernet <void@manifault.com>

--FfRfl7W5WtKub8Po
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZwWYLQAKCRBZ5LhpZcTz
ZDTXAQDSgn0IREF4p0liOsz0dF24wvDTIcPiy6zuQUC34R1nsAD9GP2nfWYYpCdx
qskgLUrRlX6L0gBF46rOzWbDdyOGFgQ=
=gM1q
-----END PGP SIGNATURE-----

--FfRfl7W5WtKub8Po--

