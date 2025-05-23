Return-Path: <linux-kselftest+bounces-33644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FD7AC236A
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 15:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41586543A81
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 13:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C2D140E30;
	Fri, 23 May 2025 13:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="mOZoM7C6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D22D18641
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748005559; cv=none; b=kl1C4cp+UOVUzhyNz03uW1Zq0qqihaz4Db2a2daXmun6TbezqkSAdGL6oWV0IQBi1S0YwBhz3oVZgYB9ozU7/FD+d3nv97JjCS/FmxCkh5qxA5ayTjoNtFJ0aAsYPbtOozlumTMiPF0ONayS6+ZhIF0VS+nL+yBcufYESJ+qFX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748005559; c=relaxed/simple;
	bh=xcdAazkrufWuzaju7No3ced2/sH583+qifVFJh+ynvw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Z2vzQ1wdJvQxvfiW1+GzdfoD4rgC/a40J/twUZd+CVWktnSJoGZU3S5ctbdI5yYBr6OzosVecKGyj6V08DvdzoS0uviK1x8cbpT3G0E0Zw6mpviu4sHf7JVGOw9tbrEGmA6Cvuc7lMSNV7NITuz1O+DsdfvnJBiarTeLDloI71A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=mOZoM7C6; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a365bc0af8so729380f8f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 06:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1748005556; x=1748610356; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFewfZjNIOlnKjbSqghMjET5KPXnaKP3RNtWcft+NNM=;
        b=mOZoM7C6z57lpCL4aUH3bkfyDirbWMGziUkqBUGZNEmBdfhrSVnKTutiuzGlefah5u
         1FACWiwN6mjq5orq25WvIFHmes4LOUGwBVQXhe+Ri+e7BG+ToZIbYg862ajC4xo7vFsG
         67TUV2ek5whv0r4Ul28LxmFXXJIgmwW+pSJu+RbeRGtCUI/TnJ+TZ41DGyEv8f6avqOW
         kiw5AhtyVDHhQtfXVhzvc6zEP9kEum2GPVLICFXNq9+dpWXwQMMFBamMa14qEL3Nck2g
         +B6oneJmhRji4i1WWSRzX8o6P9HimpoHC8xTzTjOHzTbv3RdTagJ5SAZUB1aO8uogpaa
         YaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748005556; x=1748610356;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gFewfZjNIOlnKjbSqghMjET5KPXnaKP3RNtWcft+NNM=;
        b=RVHG9wqStvO3XPdeiIgKfbmZkHHPQHmAGmjTmumht1561a9LOkAPiX0me4Tbji9pjp
         yDoyWQAetDNQ7kigli2lAmfLu6Kv5C0+rK4OSJnS1AK5FzevCUZ8ar3Jqd5WYA6+7edT
         hUB0au2kzoukhHv0/IuxNRQoo5+2YGBXBIjPwbRI7uxyInYGT8k1BW8W6/VwdzslffCf
         EdLgrcnxxw3bgmJr6fwFl12VJph2K53cwmVZAR4O956cS2UpHDJZFSVuMNI+YY6sBJ3S
         pSuup5IXhxetgdoSeCXpvQ3KEiR6U4S4bgcpbz26XBw9QrCtw9RfZ/9O3bZJ9wegPuBj
         TeKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8r/kugyZFVbgoEqVYS53opW60BNfiwekjmGofcnBqdIrm/VallG5JHXef6zuVmhncALSH0BrJjzqC3Dejsrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+EZYsNDq6dt4DaTcV5W99fnpbNb1EnScpL4397/EaZJpFj5F0
	5ib/UdabKWWxlh392vzfNchtJZiDdUVUBHyKs05J29ttKT35PeWMpBfg0sVeq5OVG1c=
X-Gm-Gg: ASbGncsUV1b9qvMsRtkDI1vCcB1MZrmFT51Sb3micOOvMgcBSXrBWE7owyXbsLz6NQD
	r3Cz6luUaffb0LgQVqrRYm7ZvP24J3oCGEtLsexLAUSXEAvYiJU/gV3PBgCjmybXypa8/3KPdz0
	bI0ZpsFmwGqAPcEL2jZ6doNYbSrL+1OLg7PdgZq3rRmvNImmVeoxdDpKHqcVXrHX6FrUzJ8xX4T
	s2xdapkQINkpRhr5pTC+YYrvizb9+fT7n68qPUYvlcVGMRg1WbXHpzfKaKrlVm8yqc3OMgz7CLb
	1qR09EBrmiF5+quYwJEWuJTBFdYl8m6PC/RuF5vh3r5JWT/5ky7TCWwbjEk=
X-Google-Smtp-Source: AGHT+IEYIo39joB/0uuiMCLZj0X9kGxap7PQ8MzBUGOeMKLVyBYJHZJSgGJhoZMNlP15r1mU9RPZpQ==
X-Received: by 2002:a05:6000:4285:b0:3a3:5c97:70c with SMTP id ffacd0b85a97d-3a4c2e5707cmr874240f8f.14.1748005555660;
        Fri, 23 May 2025 06:05:55 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:be84:d9ad:e5e6:f60b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca8899bsm26390515f8f.62.2025.05.23.06.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:05:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 May 2025 15:05:54 +0200
Message-Id: <DA3K95ZYJ52S.1K6O3LN6WEI0N@ventanamicro.com>
Subject: Re: [PATCH v8 13/14] RISC-V: KVM: add support for FWFT SBI
 extension
Cc: "Samuel Holland" <samuel.holland@sifive.com>, "Andrew Jones"
 <ajones@ventanamicro.com>, "Deepak Gupta" <debug@rivosinc.com>, "Charlie
 Jenkins" <charlie@rivosinc.com>, "Atish Patra" <atishp@rivosinc.com>,
 "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
To: =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, "Paul
 Walmsley" <paul.walmsley@sifive.com>, "Palmer Dabbelt"
 <palmer@dabbelt.com>, "Anup Patel" <anup@brainfault.org>, "Atish Patra"
 <atishp@atishpatra.org>, "Shuah Khan" <shuah@kernel.org>, "Jonathan Corbet"
 <corbet@lwn.net>, <linux-riscv@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <kvm@vger.kernel.org>, <kvm-riscv@lists.infradead.org>,
 <linux-kselftest@vger.kernel.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20250523101932.1594077-1-cleger@rivosinc.com>
 <20250523101932.1594077-14-cleger@rivosinc.com>
In-Reply-To: <20250523101932.1594077-14-cleger@rivosinc.com>

2025-05-23T12:19:30+02:00, Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>:
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
> +static const enum sbi_fwft_feature_t kvm_fwft_defined_features[] =3D {
> +	SBI_FWFT_MISALIGNED_EXC_DELEG,
> +	SBI_FWFT_LANDING_PAD,
> +	SBI_FWFT_SHADOW_STACK,
> +	SBI_FWFT_DOUBLE_TRAP,
> +	SBI_FWFT_PTE_AD_HW_UPDATING,
> +	SBI_FWFT_POINTER_MASKING_PMLEN,
> +};

How will userspace control which subset of these features is allowed in
the guest?

(We can reuse the KVM SBI extension interface if we don't want to add a
 FWFT specific ONE_REG.)

Thanks.

