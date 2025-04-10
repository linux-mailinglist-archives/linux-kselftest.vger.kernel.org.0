Return-Path: <linux-kselftest+bounces-30475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F30A8416A
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 13:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148AC466714
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 11:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261CD28152B;
	Thu, 10 Apr 2025 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="pVFHYrgW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B45E1DF991
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Apr 2025 11:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744283084; cv=none; b=onhZYy2xGVsHYgz/nAcmhHQ2phT+YzS1BhToTRPivduyh+x/ihO3KaIWw3oIQgxDXlVUSKQdSDEbm09FJDZqL5QQvehseZQ3RZ3WeRr/rH/guvSJ6n+z/7iQM/d5Ih21ouBR9bt5Ctu8C+cFxQ9bFCdxX9g4Czm2PChEoMbVZ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744283084; c=relaxed/simple;
	bh=kOlPkOa9RAWaHmxwXq9vXkGSssRFc7sUC8EQNbcnfPY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=tKW3atufKIRoFTJP7/u21PoMEDDoNGy9t2PN8k2UAxqD7StxZTJXDXOjsc6MzQFPEgvbgI6FpmgA+Fv+PS5LsVSwKOIY2+0ro++w1VCGU84i+alieos0Cu+YJdcCgdeZEwZrnt5lDHWZY4JMk4LBr6VLJbQ9pOsT/ay9xiMTBg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=pVFHYrgW; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c2688e2bbso26010f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Apr 2025 04:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1744283080; x=1744887880; darn=vger.kernel.org;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwTqTcXuZVwmB1gK8gAQzMNft2dcqvTwt7yn+4sQNuo=;
        b=pVFHYrgW6CsPBVfhDp8H0SHh07ORi0+k92JSM7WHod+l6GpALDm6Af/8R4cZodTjSI
         tJhmQC0ISSnfE51tew20VXscex2ugzAatyW+gaNQVdqFVsPCNEtL0hzsectLv90gFFtt
         oVuwwysWrn9jEcSsg7T6KkbCebzr4gntAQJheGXE5uqMjbzNUT2JWYiPhRLq9y69avjt
         blLUmxwM5ibExPlEoUUbX0wnvPL/rJd7iUzELewMF/309FFzjGxOdZqxZeMaqwE83MP6
         zgXi1m4nmEywod9fgORmfD+WzNDeuueMfkonfaKqfm00t7VTa2R1DFvAman71MpISxGx
         m5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744283080; x=1744887880;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FwTqTcXuZVwmB1gK8gAQzMNft2dcqvTwt7yn+4sQNuo=;
        b=snHCsYuwOdFDB841CRn9ijFPoHZVh09neRW/YDgYSWnXj5KZ0kr5JeAcZjJJtbMnw5
         kwyezpgrp1PhIpHb2Fm/5Mecw0sAYp7TBeI/6b4VaHEPVozkiLus7M3ZaOAt+L0OUiwc
         B8FRyWw1CO80YlS/hzqSf2s642eSingw7uyIpOOjGudATgD5ZJ86i71WogZUmafkaFP7
         FYLHv7U3yOOflOpMCW+H/ElY4CzvVQZ+Ip8CbKsMwf45RWD8RC0gj6jeXhpPenhGAGus
         iY2rJxOf3n+Hbqx3nKx/m0dM3OM0l+cDkf8ZfcP13EirfJ66y+PnROzvnOoYBwBMn9Fm
         +5iQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9pPL0gVoUoOoPI86RWWKOV1X6+H4XleTGANrCwnqdwygGIEb1pFeBEQlqPJqmucuFDCC4kbFyuTT+oaEZR0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXN00bQ5SNTeMI/d+Bwwm+lhmllAAOi4YM5X3BcEozS18hyd07
	QefkwOdZIE9EMYnd6rZDyYcNnH+hDENdaUtG6GSvmAlA4SUK57ZgPZO6YNJ2NUk=
X-Gm-Gg: ASbGnctJixoLseO3smjDZGjUbEPwGBWqNY8b47GWeM7JvEsCLzR6C/W0zgahPgArO7U
	OhgQuDmdSMVDrqkbnJR/66x0tmgLTxa0RGSG7vuLNYKDfbrqc0zV76+K8OIDSVzv0dAaUvCac9s
	KX5YKaBEidsm1IKF+u1HBTkiBfgrLdVIY5phPW3UKLHpO1Ogs1pmPinlGpclreWixMPjH3FDg/v
	U237PvwwahcpIaXYWoSGTALojuC41Yp74z9FKjBxUkNOhXyz7DcAQ99VLJ69fTpS8HzljZravLp
	r8+XFhSnXXaSGzh3sZJ15Cf7I1FRxraXL3y4fu2kNxkaBT4c
X-Google-Smtp-Source: AGHT+IFTHVjvMm7SI9zG+YTo6xP+VuwjrIfNbL14H9cY5sGUQSewGH6hwjaZZsvjM4ZfhfO2SM4RNA==
X-Received: by 2002:a05:6000:18ac:b0:39c:13fa:3e0 with SMTP id ffacd0b85a97d-39d87adcd02mr1983393f8f.9.1744283080239;
        Thu, 10 Apr 2025 04:04:40 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:7d22:13bb:e539:15ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d89361186sm4476526f8f.14.2025.04.10.04.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 04:04:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Apr 2025 13:04:39 +0200
Message-Id: <D92WQWAUQYY4.2ED8JAFBDHGRN@ventanamicro.com>
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
Subject: Re: [PATCH v12 05/28] riscv: usercfi state for task and
 save/restore of CSR_SSP on trap entry/exit
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-5-e51202b53138@rivosinc.com>
In-Reply-To: <20250314-v5_user_cfi_series-v12-5-e51202b53138@rivosinc.com>

2025-03-14T14:39:24-07:00, Deepak Gupta <debug@rivosinc.com>:
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/as=
m/thread_info.h
> @@ -62,6 +62,9 @@ struct thread_info {
>  	long			user_sp;	/* User stack pointer */
>  	int			cpu;
>  	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
> +#ifdef CONFIG_RISCV_USER_CFI
> +	struct cfi_status	user_cfi_state;
> +#endif

I don't think it makes sense to put all the data in thread_info.
kernel_ssp and user_ssp is more than enough and the rest can comfortably
live elsewhere in task_struct.

thread_info is supposed to be as small as possible -- just spanning
multiple cache-lines could be noticeable.

> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> @@ -147,6 +147,20 @@ SYM_CODE_START(handle_exception)
> =20
>  	REG_L s0, TASK_TI_USER_SP(tp)
>  	csrrc s1, CSR_STATUS, t0
> +	/*
> +	 * If previous mode was U, capture shadow stack pointer and save it awa=
y
> +	 * Zero CSR_SSP at the same time for sanitization.
> +	 */
> +	ALTERNATIVE("nop; nop; nop; nop",
> +				__stringify(			\
> +				andi s2, s1, SR_SPP;	\
> +				bnez s2, skip_ssp_save;	\
> +				csrrw s2, CSR_SSP, x0;	\
> +				REG_S s2, TASK_TI_USER_SSP(tp); \
> +				skip_ssp_save:),
> +				0,
> +				RISCV_ISA_EXT_ZICFISS,
> +				CONFIG_RISCV_USER_CFI)

(I'd prefer this closer to the user_sp and kernel_sp swap, it's breaking
 the flow here.  We also already know if we've returned from userspace
 or not even without SR_SPP, but reusing the information might tangle
 the logic.)

>  	csrr s2, CSR_EPC
>  	csrr s3, CSR_TVAL
>  	csrr s4, CSR_CAUSE
> @@ -236,6 +250,18 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
>  	csrw CSR_SCRATCH, tp
> +
> +	/*
> +	 * Going back to U mode, restore shadow stack pointer
> +	 */

Are we?  I think we can be just as well returning back to kernel-space.
Similar to how we can enter the exception handler from kernel-space.

> +	ALTERNATIVE("nop; nop",
> +				__stringify(					\
> +				REG_L s3, TASK_TI_USER_SSP(tp); \
> +				csrw CSR_SSP, s3),
> +				0,
> +				RISCV_ISA_EXT_ZICFISS,
> +				CONFIG_RISCV_USER_CFI)
> +

Thanks.

