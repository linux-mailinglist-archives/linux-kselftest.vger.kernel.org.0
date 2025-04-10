Return-Path: <linux-kselftest+bounces-30470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35001A83D77
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 10:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82BD4658E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 08:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142C120B814;
	Thu, 10 Apr 2025 08:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ArZVnl9J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDDE2040A8
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Apr 2025 08:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744274977; cv=none; b=ZZt8D8FxqawH+H8M3/3679s6IRwNyd84TcHTClRVRPTTZrVkV1SZJ1wDWsrHmoJE3tldXx5U9pQ3m62nAjHzdde7uf9T0ZOHUEkkUEpIInz0Lj/9PrZN6PYGMujrFFekQZWC6D/S0dREbWgc2Xbeq4Lk4IUcDEZAAqWW51NInp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744274977; c=relaxed/simple;
	bh=+btaMpKeeBdGRBlfpT1TSOPhvtORg43su9uQOsAX5Es=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=hJJTeQn6JwDqnil83QrWWUVL23oH+YY+ztvrDfkrPkYepHDaIoDdZkUqlVtkpN4SSqAr6SSaE4//QIK1S5JlRzPYrI0q2ejvICLSEJwUG1USUOM3r/Txi3LRMvYB6DlYhUNO/bv8N+v6lZ0uLL6buBZ6RtoXN15/PYfHwtJqDkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ArZVnl9J; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43e9ccaa1ebso593685e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Apr 2025 01:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1744274973; x=1744879773; darn=vger.kernel.org;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEwPf3cBEf9ZFD3zZhCOLbWBp0B51DbgggktH5J+y1E=;
        b=ArZVnl9J30sx8+yQyFZEjZBH01meAzlOv5Gr9qxWKtevq/gXBjej+DpnfllAfQvwM2
         bVXGaNyAmrgsp18pRPd2LiR+Y4UaZYIbphPpVT19PftYwQYsg6JAlA/uGP/3vmGIbqfB
         FJVw+q+esOAmA225EUTqTT7vKI4hqNULUnjoxnUc/XDdU6tGlTkvCv9jdzLqVMa0sEPE
         M3iTHC0DpI5Hfqwo38fdg5QTR2Fll25bgvcj+wq3hP/OH/EwmNsVFmo9Mmr313/ZoZSZ
         HdDjcS1w//G29nTd7FYXG3tsCrTU5WcQmkyvwj3milGagQLDf6F7u31LWoj2T8Ftj1++
         j5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744274973; x=1744879773;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IEwPf3cBEf9ZFD3zZhCOLbWBp0B51DbgggktH5J+y1E=;
        b=f1y3EN0PrSpBdllvr2xct9Pod9R3BEPeIYggqr1PQ4dd3K54qJS6J/CquPp8vShwNi
         EWCShQRIhJjJISmzNHPVacqkQ1qHfwTuvRClQzl6WGU3j19f6Si3sid3DtUeJqAzS07d
         v46rpXRZaiBxGNSXfRWmS4y2MCCuLBfcvb+B0uHMnEm7vdqwzTJKscP5HtOjK7kZ9r8T
         gfPF01rTXUyvCZ0IlnXJ7e9KTmu/bh5pL/vZ1XXbXG53v7umGbjPx9Jb42v33QDHR6/g
         VQNOGDbihnauZxDB4n5x79owOn0J+sTZT4Y6mZH+V+a/o2+Waf+mAe5kHJkCoEhoyNkI
         4/GA==
X-Forwarded-Encrypted: i=1; AJvYcCWBhbxsA+iRcTRnB7hp/zWPzE3JubOKtgAIvc1bX6+uYOnGjqUT9EjIbLrGDHN3ksckJbin2+f53H/GjfgJNsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTf+USw3kzn+g6CEev2Tm9T4ccAUFYbjPGETbLM6O+gdWcGARV
	n4fQLmzed/hRiTMRiHN/hXzd6jWMXz+9KlJD8zw+zTLGT0/ZrgdkAxuEuwyqlk0=
X-Gm-Gg: ASbGncuTRIYPcRAzwxq6y4uaOZ8X1wtq73xPa17jOWuL0h7VqW9AkQ3LS32KHRN4Tf5
	eYwgQfN+J0E/WXwm7cymw0GGHpA4Voye2m+l6I0hbMEByCzkFyxbMCgHxKdR9z05ZE7CAhx85z9
	sNrl+pJkhst/yELNVfZt4KftbT4NVphI57AM0Loic3ZWhvxWicWCVwvWISOdu/NI352XEaqI3aC
	B2adBvTgmEAOXdXNsvj4pUc5wU1BsEQzIBCrFixkbKmCcSNrfIqjG08bCmJZzeigC9tT2KgtXII
	KhJ+lEU856NijxMFW/wwfDFhwlYAqeBlPW2ZbL25nqE+2ry2rQVd4XkMEM8=
X-Google-Smtp-Source: AGHT+IGXp6uVqxTmSQMdMVt3uEBGD0ZfsrbyUn6XrfTKoToYQ6belt1Wh1Dck02/rxvTlH6EUyAxZw==
X-Received: by 2002:a05:600c:c87:b0:439:94f8:fc7b with SMTP id 5b1f17b1804b1-43f1eae40f4mr19787055e9.0.1744274973504;
        Thu, 10 Apr 2025 01:49:33 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:7d22:13bb:e539:15ee])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d069sm47866185e9.17.2025.04.10.01.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 01:49:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Apr 2025 10:49:32 +0200
Message-Id: <D92TVG7AWGLG.1GO0C83SS7M9G@ventanamicro.com>
To: "Deepak Gupta" <debug@rivosinc.com>, "Thomas Gleixner"
 <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov"
 <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Vlastimil Babka" <vbabka@suse.cz>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Conor Dooley" <conor@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Arnd Bergmann"
 <arnd@arndb.de>, "Christian Brauner" <brauner@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>, "Oleg Nesterov" <oleg@redhat.com>, "Eric Biederman"
 <ebiederm@xmission.com>, "Kees Cook" <kees@kernel.org>, "Jonathan Corbet"
 <corbet@lwn.net>, "Shuah Khan" <shuah@kernel.org>, "Jann Horn"
 <jannh@google.com>, "Conor Dooley" <conor+dt@kernel.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
Subject: Re: [PATCH v12 17/28] riscv/signal: save and restore of shadow
 stack for signal
Cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <alistair.francis@wdc.com>, <richard.henderson@linaro.org>,
 <jim.shu@sifive.com>, <andybnac@gmail.com>, <kito.cheng@sifive.com>,
 <charlie@rivosinc.com>, <atishp@rivosinc.com>, <evan@rivosinc.com>,
 <cleger@rivosinc.com>, <alexghiti@rivosinc.com>, <samitolvanen@google.com>,
 <broonie@kernel.org>, <rick.p.edgecombe@intel.com>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-17-e51202b53138@rivosinc.com>
In-Reply-To: <20250314-v5_user_cfi_series-v12-17-e51202b53138@rivosinc.com>

2025-03-14T14:39:36-07:00, Deepak Gupta <debug@rivosinc.com>:
> diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
> @@ -140,6 +142,62 @@ static long __restore_v_state(struct pt_regs *regs, =
void __user *sc_vec)
>  	return copy_from_user(current->thread.vstate.datap, datap, riscv_v_vsiz=
e);
>  }
> =20
> +static long save_cfiss_state(struct pt_regs *regs, void __user *sc_cfi)
> +{
> +	struct __sc_riscv_cfi_state __user *state =3D sc_cfi;
> +	unsigned long ss_ptr =3D 0;
> +	long err =3D 0;
> +
> +	if (!IS_ENABLED(CONFIG_RISCV_USER_CFI) || !is_shstk_enabled(current))

!is_shstk_enabled() should be enough here.

[The rest looks fine, but I'll need more time to think about it.
 I'll return to this patch in v13.]

