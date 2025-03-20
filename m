Return-Path: <linux-kselftest+bounces-29526-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF4FA6B082
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 23:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5658D4A32ED
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 22:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC9722A819;
	Thu, 20 Mar 2025 22:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="SQyL5yoc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5891722A80A
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Mar 2025 22:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742508615; cv=none; b=tguWuDf/Ti2GH9Av4yNJi/EhuldiNosfZsdWLyOUMlgm67ofshVUCy9GU7P/5EOtpEVgLqt/OTVRj1Up+NmIpy2VbGYPeakHPr6sJMwzlzW8rnD70AuIrmk+n7DFen9tFAPsBFpxyA4s5R5vqVUofOQUUgncGGSJ9DlOokuz/UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742508615; c=relaxed/simple;
	bh=WUircD2gMunYayRFEsupwySC2IZlWNKmBLpSeBOKDuk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=dcY/SNsgUUmMBezH42AXhSThIU77bZHneA3WwLucGW7mybL/khyUzXiaIU3GuiLA8ek780q1qDLdhFhoCZDYtidynOVHg+P6Tw/QyVAS3IyksyRCww7D6EkQ4JMoLbR3CD5mgO4e8uZy3x09VIBtjfIK11+Z4j7ih/CClsk5rlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=SQyL5yoc; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfe99f2a7so733235e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Mar 2025 15:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742508611; x=1743113411; darn=vger.kernel.org;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewXqUeA7RBIygwSLbMlGfEG1GVvVQPFVPFBcsvVuklE=;
        b=SQyL5yoctpMIiYraB/AyPJVy5DTn1JNM7nuDEIwNOlvDwmTGaE9QarnzBNwRDAf9Yr
         S6lWelZYnyG13MGjY2aFEn46naiKYS1xGah6DovppVBMq+DDhC342JRPMjGWevaGDi5D
         P38+EiLB1ojzvFt5wwQFvpnLxSbZuIRTVsaZQMg27u8bgMpy60iVeHb9rDYaq9Ch1DoL
         n7VygtUNpF09YivzwCyYIE5D9NYt11cY5TEpv7Rmqd0MetiT4IISrsvho8/QptOahGnW
         HSodB+AOHO/NZGq3BhnhMnt67qgbmBRCOsz5KNU9y7+Ek/5TWWnpf2wajHBWkLWd3rAk
         KQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742508611; x=1743113411;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ewXqUeA7RBIygwSLbMlGfEG1GVvVQPFVPFBcsvVuklE=;
        b=p8Iog11FLCD5yNKp+j8wY+hBVTkc1FerQihNnas/Y44iFxk0EJYdPs8jmLBGkPFhhN
         lT9sRIiaa+8PMUYqx30a4Dh/jsFOZBtwF2kUGN1qSs0fIGEhV/E8TLskOTpNq+VTDzbW
         UR/hSlQerMI5xrW27Eu9PD5pYxJN5tDyEXSmRWcIW2A2jvJa+jAlF6xuUkSgBPWuo5Z/
         KoVb/i9LaoCFulljHKqL2AcZZ5NZDpiuiVdXTm1ZSSw43EoCyIHJq0/uEFk22ahkUkWk
         sICUsXfp9PsGJIJJDr3X9foYW8epr1vvPqvENXtgckwTJU7SD7hgIYD5lT/WgJ4J6z11
         kH9g==
X-Forwarded-Encrypted: i=1; AJvYcCVVGQcJVZfuh/sdY3AfMhLdYozoCocJxgWMCb3Znrs0aBWMJ2l+d4KhYLSSgpfxxoT3NMAlFAS7URscWGyLEy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0k9OrrCmSZX5KyfIgI2T8Y3LpG+QtHxmz//AwIvCwh0s11alU
	WH1tpkp+SlE29lJfGhhqYyQiX5a+X+E+Bf6/rYQmWSjuOGsgJB4EeXXRQVrpjrk=
X-Gm-Gg: ASbGncsThQj90C1phwMz250cJmMJZ4T+gTTpbfQ5VvzhfYDUbpqtMR70jIWuXCPaScy
	/+b3058NpxZ1CGJMe6jWY7fCU973Ff5pdUdQPSqYCT45vMgoP/XmGpXrlp7xni4nAEOHbIz5YCH
	M5K0pb4/46uhqxuOhE4hGKbYBgRJmj30Xx+js2WqD+QXkqs/aUlsESArOVchYcInoFXGkgh57hN
	/Usgbiqscw+eC69i7/QGfh2TXeBZfLNPpRMiUabtlvhj0Y4Ug8BwPvq4fKg15wVGxmzXVGJY4H6
	pqmwaV56DOWGySpO9ier8wSf22uwpfljhy4p7lNTBfBh5RicmWkCGPMxSBp6EjW7hqjSXFkgzv6
	Ea7RitaQ8QSdu9Jg=
X-Google-Smtp-Source: AGHT+IG3iOdJG0QpOBXcV58Rkg48UtcOBUQNUhvPAa+an4gh1o0G7FLaaJ5j+6uFEW3mo9uctUtXkw==
X-Received: by 2002:a05:600c:5252:b0:439:9909:c785 with SMTP id 5b1f17b1804b1-43d5171da80mr576165e9.7.1742508611223;
        Thu, 20 Mar 2025 15:10:11 -0700 (PDT)
Received: from localhost (ip-89-103-73-235.bb.vodafone.cz. [89.103.73.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9eef37sm655138f8f.85.2025.03.20.15.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 15:10:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Mar 2025 23:10:06 +0100
Message-Id: <D8LFQYX4EHF8.2AJ01XL34WK0W@ventanamicro.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <alistair.francis@wdc.com>, <richard.henderson@linaro.org>,
 <jim.shu@sifive.com>, <andybnac@gmail.com>, <kito.cheng@sifive.com>,
 <charlie@rivosinc.com>, <atishp@rivosinc.com>, <evan@rivosinc.com>,
 <cleger@rivosinc.com>, <alexghiti@rivosinc.com>, <samitolvanen@google.com>,
 <broonie@kernel.org>, <rick.p.edgecombe@intel.com>, "Zong Li"
 <zong.li@sifive.com>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
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
Subject: Re: [PATCH v12 22/28] riscv: enable kernel access to shadow stack
 memory via FWFT sbi call
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-22-e51202b53138@rivosinc.com>
In-Reply-To: <20250314-v5_user_cfi_series-v12-22-e51202b53138@rivosinc.com>

2025-03-14T14:39:41-07:00, Deepak Gupta <debug@rivosinc.com>:
> Kernel will have to perform shadow stack operations on user shadow stack.
> Like during signal delivery and sigreturn, shadow stack token must be
> created and validated respectively. Thus shadow stack access for kernel
> must be enabled.

Why can't kernel access the user shadow stack through an aliased WR
mapping?

> In future when kernel shadow stacks are enabled for linux kernel, it must
> be enabled as early as possible for better coverage and prevent imbalance
> between regular stack and shadow stack. After `relocate_enable_mmu` has
> been done, this is as early as possible it can enabled.
>
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> @@ -320,6 +326,12 @@ SYM_CODE_START(_start_kernel)
>  	la tp, init_task
>  	la sp, init_thread_union + THREAD_SIZE
>  	addi sp, sp, -PT_SIZE_ON_STACK
> +	li a7, SBI_EXT_FWFT
> +	li a6, SBI_EXT_FWFT_SET
> +	li a0, SBI_FWFT_SHADOW_STACK
> +	li a1, 1 /* enable supervisor to access shadow stack access */
> +	li a2, SBI_FWFT_SET_FLAG_LOCK
> +	ecall

I think the ecall can fail even on machines that have Zicfiss, so it
would be good to disable user shadow stack if that happens.

