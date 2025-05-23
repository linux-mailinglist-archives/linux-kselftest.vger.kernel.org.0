Return-Path: <linux-kselftest+bounces-33659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0507AC27A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 18:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B1227B34BD
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 16:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F44298253;
	Fri, 23 May 2025 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="YWVho5t0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A837B29712F
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748017633; cv=none; b=DXZfmxU75FmyQHZqwRsWgdh6d7xkq5xqnTu0fSACIN0Iu9SxFBkrbUehtZoWBBqIE61A8Hs2B8ndCEdi78sFYszQzVoWWBqnWLKv/snRXW3dTkh1PlNC7c25XZlHIzWY+JF8XXPCA1YZxY6a2caCvRtwN+1AQFBQJt+WD3Qrc+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748017633; c=relaxed/simple;
	bh=xoy2iHNo1joT7Vza5E4ulrB5ALTkKGuwFJzZh05QFXY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=j1xgKUkhJbIsNOu/Vhjqahabm2CFsAluRlQ3POOku1KUoTLIWnJdoG6oRWa3bTTH2iF8S3bMkwDq5ET60ITAyMETgfapiz17+xeF15WUB/KR/dR3SrF192vF7M3z8vbTd6JfCLs7qTHOMpxEPiK74P0J7VW/4q0RRpkH+bRjf9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=YWVho5t0; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a374754e03so15185f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 09:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1748017628; x=1748622428; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ia6puvfZPG5fMJM1ZRtmeD9phh8ksFStnHEcrbqR9QM=;
        b=YWVho5t00wvenZuAzoFsjd+SDYyEJKBKLddYH1sizwOm6UT4z3PLA+rgnyNaTcoNWY
         ivS2MCzrHRq9yzMIG4GiOV5tfNJrpVcRRNU3uFKdvwid2zy0LRznIFvCMYlMXSsya+r+
         G2H1sQ+6JiML5gGBxo6avtIDrJc+xO0KuS5aJaJ52FslLlHm2YGRZftDYhgDOzvERsEB
         FlI5XrWoq0+HDRHs7wvgWSt8geb5p0uUl/ntjExeO5ZUwG/JB+T/zPVsjf5VsDde1z7i
         AbnfTu8soC+Eb2DMd18QwSUKo8DbVYnIdhiugDfbf9O6Qg9NEUAW4F1FhHsHRPvgil8U
         IWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748017628; x=1748622428;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ia6puvfZPG5fMJM1ZRtmeD9phh8ksFStnHEcrbqR9QM=;
        b=fNPdiT1IsBac59UCcZX2n0rkGLAXgcq10CP8t7d6lSLXHKjkISzfHxIjFuRNvqYQrU
         n6YNSW5JJ1cKs4MD8GKgHiLoeAoMPa/i4nXenSuRLpxAxq3zuHb8XWxiemyzI8F3IWFD
         6Zr/4pGsE1BSULjZE0708AUsTPbzk+Ug22+RlnwVs2Q015oZzPjWnDXbtWZd7lOXupRK
         c/LNGCJt4xEmjXWZ1IQu1r9iUyMutQXT2MCZclO2AILL98T03JCyVoU2vgwr8qpi9Zp7
         YCIV+hZgJSxyR+fk8rDg0IVrgZ9QqhaNEyCxlVrNJfsa+XJPdoyUK/K31NYxNFRnhEZL
         geTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhqMlIxuLchcUwBW5stXnsmTSin4e8gRQGsOPzTu0cB9nilnBaqH88wbE1gooh0CgYZjyVTpIC0lxJt+2cVDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOh/NnUuiFMkDJf20K+vTpGZu55ILFqiB4zDkVjpeLC6kD40bY
	q0Rb0gZRuVNmFlNo7bbI57qz4pu3O43fU/zV5lZFZsSlYdMaRQJJ8k0fg4ebBBcU00I=
X-Gm-Gg: ASbGncvYv0HBwve42HKxzuvl37CxGSPkGWherXWD+PLIQCtB4iDPa6Fk9aqjXX8tdtu
	ICPAdQvRXVZfikeTgYF/IjavN0naaR89pJlKrN9+vEtEZBpNgQsxlaI3dBTXl0JuP9CZ8znOclb
	HeNKGkbhBnlo0ohkdzpICdebRhG+cQFDVaDMP9sUm97uamBOpgI7Emb5gh5k6SVqfnfeD3GyPb0
	ipZHcHa++psN1He0+o3tL5l2OCamICq7UW9MwKFY6hvc786U5DYVvCMc707gSMzBSmZe+PKM4EN
	KczCS56DBTGWpNM5yeJ+B00vr3SPs+3TcsYJL1DYD19CYt7iz0k3tgoKr7wSNIKCPcG8Ig==
X-Google-Smtp-Source: AGHT+IGu5SqOXXJDnZhsvGxzP9Q90JnNNFmT1bVPxtvjIRaUq9pqy0zhm7LZZhwBJv3AkH7nFc+56w==
X-Received: by 2002:a05:6000:230e:b0:3a4:bafb:adaa with SMTP id ffacd0b85a97d-3a4c2b3b3d4mr1273822f8f.3.1748017627898;
        Fri, 23 May 2025 09:27:07 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:be84:d9ad:e5e6:f60b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a368250dbbsm22377027f8f.47.2025.05.23.09.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 09:27:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 May 2025 18:27:07 +0200
Message-Id: <DA3OJ7WWUGLT.35AVP0QQDJRZV@ventanamicro.com>
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
 <DA3K95ZYJ52S.1K6O3LN6WEI0N@ventanamicro.com>
 <9f9e2869-725d-4590-887a-9b0ef091472e@rivosinc.com>
In-Reply-To: <9f9e2869-725d-4590-887a-9b0ef091472e@rivosinc.com>

2025-05-23T17:29:49+02:00, Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>:
> On 23/05/2025 15:05, Radim Kr=C4=8Dm=C3=A1=C5=99 wrote:
>> 2025-05-23T12:19:30+02:00, Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>=
:
>>> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
>>> +static const enum sbi_fwft_feature_t kvm_fwft_defined_features[] =3D {
>>> +	SBI_FWFT_MISALIGNED_EXC_DELEG,
>>> +	SBI_FWFT_LANDING_PAD,
>>> +	SBI_FWFT_SHADOW_STACK,
>>> +	SBI_FWFT_DOUBLE_TRAP,
>>> +	SBI_FWFT_PTE_AD_HW_UPDATING,
>>> +	SBI_FWFT_POINTER_MASKING_PMLEN,
>>> +};
>>=20
>> How will userspace control which subset of these features is allowed in
>> the guest?
>>=20
>> (We can reuse the KVM SBI extension interface if we don't want to add a
>>  FWFT specific ONE_REG.)
>
> Hi Radim,
>
> I didn't looked at that part. But most likely using the kvm one reg
> interface seems ok like what is done for STA ? We could have per feature
> override with one reg per feature.

Sounds fine.

> Is this something blocking though ? We'd like to merge FWFT once SBI 3.0
> is ratified so that would be nice not delaying it too much. I'll take a
> look at it to see if it isn't too long to implement.

Not blocking, but I would at least default FWFT to disabled, because
current userspace cannot handle [14/14].  (Well... save/restore was
probably broken even before, but let's try to not make it worse. :])

Thanks.

