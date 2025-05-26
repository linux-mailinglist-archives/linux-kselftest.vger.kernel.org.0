Return-Path: <linux-kselftest+bounces-33770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7A9AC3C2E
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 10:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2019E7A2289
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 08:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6D31EA7EB;
	Mon, 26 May 2025 08:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="nBfqjNff"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903141E47A8
	for <linux-kselftest@vger.kernel.org>; Mon, 26 May 2025 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748249931; cv=none; b=PJrsBFopkImoVs8CYLWoV6pa42UKBfEgxjbVwnaD/XmkbybHUTExesR7LaLd7sg1njq6KsI1OahYwFE/zFwqahyEMmwbz3m7DD+F8b72/HSfk0bw4ZKm1vuAh+J2/fAeyPKYJBslTSe8Q5IFKo36pkbt7iOsFvhYnTVkwlPSY0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748249931; c=relaxed/simple;
	bh=A07uMUlAiHODBnye6U6+ZYgmI+z5BqjupTHEKb1apD0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=WN6TlWrBi2cB2mLW2ptcaoxxeBHfUUxW4wyvMu0C2skmD3hJWf7wuhf6IcyDfkASJtFAIw14MJ288rWUDxEoh3k763qfwYfoV2txVkfjb0KG2mbAjdWicN+poDtP9VULOm0Zp5KyTo+mUTREMQhGzqzXwvRUxHS4QVll9OfW6f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=nBfqjNff; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-442ea0b3a9fso388615e9.3
        for <linux-kselftest@vger.kernel.org>; Mon, 26 May 2025 01:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1748249928; x=1748854728; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XUa5QDzySuu6U8WB9K8OF+ZIZj9kEnHYCZp+dCaCR0=;
        b=nBfqjNffw48hNkVyyQHtfWhCWLtfYgFnYlWzQxkgwUg1QVgDUfH9XpKxk+cOUvnn3g
         IO4NuFbH15/FllezFedzKyq6v4jZkTFrzMIVGMorT1c/7reVH0HMY8Nz0YuVR5bcVmbb
         2cYsdaUWh1i8uj+KivWANTASq1cxKAOyKd9hA6RY0Yh0COw9BO2AN9tbP4tIXopmWdOr
         vd8Md2mx+PAJyt+XKTBrUa4maEOyVzugxAHU1ZQ8PjDSXzn4RTmGYVmL2OPWbec3tK7s
         dOhESPB4+SQSYcav2M8frCWMcUsa5so2Kxplu5y0B8Tw/fsgpHC44Bnf6Ce9Gec8edEn
         UqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748249928; x=1748854728;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7XUa5QDzySuu6U8WB9K8OF+ZIZj9kEnHYCZp+dCaCR0=;
        b=VULHUTdLhSlxtRThUku8hzDuM1p6fDLfQPZs4tc4cYtmeqtim7tX6fOM3WkiwE81gv
         syKnN546hO/1HTGu58E5iaSmDF15tUeksxAEucuQXjt02CJ5Wl3jrZ5aq3zlZ+O8lX4p
         xhgah67uJgzKblAh9BE1i2aliHKtzefvRhipX2I48J5Sj4gA32RZn1kVhPZ52PT5Qqr1
         doYCAQfFIzOU2LIhLAbtlLFmV2FnETn9eSwckIgAYO7fSWE9uHxEbRqdttsx+wexcHcD
         oLjbAJt2QCsH891bcczwYaizG1g6qErlWra2Od3+8vOCgH2drMgToyDHU0ZX+mqJlccm
         NfrA==
X-Forwarded-Encrypted: i=1; AJvYcCU6a9wIZr4vsx5gC4OYmUtqa9kHRGiRGj+lOJQ2JltkVtBrgf61SkfnY+uhOoVOhgkp2m4c5NobEDcGenNa2/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY/qcCbsma/c2sM6Lrg5JURvCnYrByaNvKjIx9+e0cN6GW6qdK
	FEE7A8zib8tDy0lLYFgjuC3nay6MRkyH8oSAConmA+1iJhdFi/y1cw5wN0SMiVc5frQ=
X-Gm-Gg: ASbGncs2UurUaYFLGwlUsfcElL1pZ1uNnJBz/qwwHijje+fXLorHXv4fuJA8TU0xNxB
	KChHqYYmEEbmv1LmSEckXemYsfmgcnOB7AMWX7g2Yc4TKr5ww21r/9oDl7j2Tz0W7rTXN+mO2D9
	/al5NgnSWqdy0EQ8ZVs/C92bCYK0bQnH5GTphr7frQPr/lH7br90JF59fcNIDv3CirHjtY9PP6p
	EPC6MXG0G848w2WlB6wZYRSeutzCb8JaKtSelxPwJV3VJD13u9ipz0uU+XgmuYeJhpVAJPM6XlD
	2IO026XX/k6UgeSi5EvL22N2uppSrZXRT/3oeqZTvr2cowGBtMpNMWHWtU0=
X-Google-Smtp-Source: AGHT+IEdx9Lxmxr6Jj4a/VtrbY6n55+AjozaESSFCcKKfyGvvRTO9hEvIbHH5Dnsj/C495VBfSOibw==
X-Received: by 2002:a05:600c:1c24:b0:439:9ec5:dfa with SMTP id 5b1f17b1804b1-44c938cb1e6mr27073595e9.7.1748249927727;
        Mon, 26 May 2025 01:58:47 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:b85a:a7d4:fa4e:bb11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d007bbccsm5654781f8f.89.2025.05.26.01.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 01:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 May 2025 10:58:46 +0200
Message-Id: <DA5YVKW682V3.2DODRY4EDL3IW@ventanamicro.com>
Subject: Re: [PATCH v8 13/14] RISC-V: KVM: add support for FWFT SBI
 extension
Cc: "Samuel Holland" <samuel.holland@sifive.com>, "Andrew Jones"
 <ajones@ventanamicro.com>, "Deepak Gupta" <debug@rivosinc.com>, "Charlie
 Jenkins" <charlie@rivosinc.com>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
To: "Atish Patra" <atish.patra@linux.dev>,
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Anup
 Patel" <anup@brainfault.org>, "Atish Patra" <atishp@atishpatra.org>, "Shuah
 Khan" <shuah@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <kvm@vger.kernel.org>,
 <kvm-riscv@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20250523101932.1594077-1-cleger@rivosinc.com>
 <20250523101932.1594077-14-cleger@rivosinc.com>
 <DA3K95ZYJ52S.1K6O3LN6WEI0N@ventanamicro.com>
 <9f9e2869-725d-4590-887a-9b0ef091472e@rivosinc.com>
 <DA3OJ7WWUGLT.35AVP0QQDJRZV@ventanamicro.com>
 <5dd587b3-8c04-41d1-b677-5b07266cfec5@linux.dev>
In-Reply-To: <5dd587b3-8c04-41d1-b677-5b07266cfec5@linux.dev>

2025-05-23T11:02:11-07:00, Atish Patra <atish.patra@linux.dev>:
> On 5/23/25 9:27 AM, Radim Kr=C3=84m=C3=83=C2=A1=C3=85 wrote:
>> 2025-05-23T17:29:49+02:00, Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>=
:
>>> Is this something blocking though ? We'd like to merge FWFT once SBI 3.=
0
>>> is ratified so that would be nice not delaying it too much. I'll take a
>>> look at it to see if it isn't too long to implement.
>>=20
>> Not blocking, but I would at least default FWFT to disabled, because
>> current userspace cannot handle [14/14].  (Well... save/restore was
>> probably broken even before, but let's try to not make it worse. :])
>>=20
>
> User space can not enable or disable misaligned access delegation as=20
> there is no interface for now rightly pointed by you.

I mean setting default_disabled=3Dtrue and just disabling FWFT for the
guest unless userspace explicitly enables the incomplete extension.
We would blame the user for wanting mutually exclusive features.

>                                                       I guess supporting=
=20
> that would be quicker than fixing the broader guest save/restore=20
> anyways. Isn't it ?

Yes.  The save/restore for FWFT is simple (if we disregard the
discussions), but definitely more than a single line.

