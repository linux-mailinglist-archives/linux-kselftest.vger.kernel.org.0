Return-Path: <linux-kselftest+bounces-30471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DB8A83F5A
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 11:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7F39E1167
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 09:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F98026AA92;
	Thu, 10 Apr 2025 09:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="iOKdyDnc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28DB26772E
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Apr 2025 09:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744278365; cv=none; b=gzvQo0wkPYXOK8QYXzedQ23G6ChSHbcaVmcM/LzuOURiGMqC8QTU/hiUq4daSy44PDIf5EEMdRCkE+M8heyvgx3tkNoNfpDuMvuiTGs1CxE7G2ESlkfeii0O+8k5j/Of1e+6OZQOcxFYeHfVX0vrX+AM3RgVF3fcZtIsON3t7Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744278365; c=relaxed/simple;
	bh=cWjCm2K3mXJ4hsQfSC0tAiTyj6UZ6wJSPp2mVTIRSAE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=UnNSbh7ypGHBkGj3YTgp7DNmUzmHC7wiqChNUVOh4CNeym6S56DF4+n8+WsSmTt7PFaloqT6zqXpnCW114EQqbRK+id0fg3ZinfgkShNgUzLiPHdKw4WdrntiBcIMotsD6pYi55RtZ020kynANmHTCW+mVitCtSPB7l9/IOKK/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=iOKdyDnc; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d64e6c83eso630335e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Apr 2025 02:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1744278360; x=1744883160; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8i8GZtfdY75DsuPGV8mdkCHtexeE8J8QTGC238f61s=;
        b=iOKdyDncUDwDoD5psxtgcxvM35zh6Zae+qpWAmKco41uJCREAZCoR7K8S7IA3unsVB
         ZLZJJ7O5A44WBkO0BpX9nDVjl2uYUmcHudz6SqaZBzP+UmPFVDzXhmJzGcaBiulFSx4I
         9M1YJse8NEmCU/uFhyoOzwMFwXj85VGsKg7zIVTE3wbX09wTNTKOnvWi6aGN5fDiyDdw
         yOJZpIPd6CZ/NhXDC5iqJUdzUxngSzfAIcoBCZOOy+ukcP/VHsScp2jtRoXVlaAQ+fU+
         EFkm2l7XqI6tRvYPXxgzLTNwsUOVxZfelavab8LBT3AVBrUbOVUh6tWtQ+T78MQr2/QN
         LEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744278360; x=1744883160;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T8i8GZtfdY75DsuPGV8mdkCHtexeE8J8QTGC238f61s=;
        b=UhxPSxzvUL6m2muIu/6IJ0ZiHcTG6gRHGB/rqVIGXgW9FN6sQJD99leGO/zGw7YdT8
         Bov58wPFeZa+iAdBW3D3qm7LIfJd/+H+CMtVkKnjKmCd/LDLJKnof7pahPPVRzgbY/si
         zLXcygrpaiWNaIrz2BzsL+Zmwdtq37kvlMl50IYD0RpzMuxp8ZWdp0A64HvgX5nvYL0J
         g2iUU2SWxE2FA159Z4o8FQCnXvvZr6FzjND3BQffN8OSIuWyn+Rm5vN9QZYFe/Qxs5VV
         3eoyNV/OLa2hcPtz7kLyfGkbd1b6HZJeBdya5t2ZbvFJAleAuOg3qkpo+a7BH5WLu0N/
         0mSA==
X-Forwarded-Encrypted: i=1; AJvYcCUS1fq9gpW8LnzicC9W1Lnq45VdBR1q1IAoHYxtVYsBoX60ZUqJTIvuCfN7CE8xAwdR8hYOQ3mD0iMLJFSkj4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEXNb/R7nSyg5xAGet5hZs/LC0fQKJrUEpMy/jIhhQaWJpqND3
	3PDQwRtVOrxfXp4xmjrPgQy0+T5lXLK1kyXr4ccFcNtsp6nhr/JBRCaDteX8Ip4=
X-Gm-Gg: ASbGncstuHoTyKUHwxAEr0t07cgJjz61K5WvG48m3Eo9UmQI/DqVk1PiWpicRDZ0SfU
	qMa10qFWjBWNavqs38FxkkiF9Mm6AoJ5bUB+ydYsGymCEr+9QTN9o9FAPb5Dw2wd6U/VwVaQwGy
	Pf0DNAQE+WdD1epwk59hMERGDiAQiUGMJHDPcgn84S/4+urhy2hRTBGwnRT1VyKjakd7058iXsK
	XBZx+FhIKzjaUmMAChMyyUlfhr3FPnO0MKy4WGYgWiic+lH1oFsvndRKXbab/eJRzo4aoG4RCCX
	lcSHSPLKcrgajhSboY40s7UnwxamMTH7OvxVj8nK4d1tuM/X
X-Google-Smtp-Source: AGHT+IGtn4otBiHZ5rhpzGojxm7Tp3rcDjovrmZXPH6P8CvTrnSeGNCclbDgZlnTp+GpEEnuS4B3vQ==
X-Received: by 2002:a05:6000:430d:b0:39c:1258:32d4 with SMTP id ffacd0b85a97d-39d87ce1a29mr1909263f8f.16.1744278359773;
        Thu, 10 Apr 2025 02:45:59 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:7d22:13bb:e539:15ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893611dcsm4217671f8f.9.2025.04.10.02.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 02:45:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Apr 2025 11:45:58 +0200
Message-Id: <D92V2NPNZYV0.136MJ2HOK48HE@ventanamicro.com>
Subject: Re: [PATCH v12 12/28] riscv: Implements arch agnostic shadow stack
 prctls
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
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-12-e51202b53138@rivosinc.com>
In-Reply-To: <20250314-v5_user_cfi_series-v12-12-e51202b53138@rivosinc.com>

2025-03-14T14:39:31-07:00, Deepak Gupta <debug@rivosinc.com>:
> diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/us=
ercfi.h
> @@ -14,7 +15,8 @@ struct kernel_clone_args;
>  struct cfi_status {
>  	unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
> -	unsigned long rsvd : ((sizeof(unsigned long) * 8) - 1);
> +	unsigned long ubcfi_locked : 1;
> +	unsigned long rsvd : ((sizeof(unsigned long) * 8) - 2);

The rsvd field shouldn't be necessary as the container for the bitfield
is 'unsigned long' sized.

Why don't we use bools here, though?
It might produce a better binary and we're not hurting for struct size.

> diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
> @@ -24,6 +24,16 @@ bool is_shstk_enabled(struct task_struct *task)
> +bool is_shstk_allocated(struct task_struct *task)
> +{
> +	return task->thread_info.user_cfi_state.shdw_stk_base ? true : false;

I think that the following is clearer:

  return task->thread_info.user_cfi_state.shdw_stk_base

(Similar for all other implicit conversion ternaries.)

> @@ -42,6 +52,26 @@ void set_active_shstk(struct task_struct *task, unsign=
ed long shstk_addr)
> +void set_shstk_status(struct task_struct *task, bool enable)
> +{
> +	if (!cpu_supports_shadow_stack())
> +		return;
> +
> +	task->thread_info.user_cfi_state.ubcfi_en =3D enable ? 1 : 0;
> +
> +	if (enable)
> +		task->thread.envcfg |=3D ENVCFG_SSE;
> +	else
> +		task->thread.envcfg &=3D ~ENVCFG_SSE;
> +
> +	csr_write(CSR_ENVCFG, task->thread.envcfg);

There is a new helper we could reuse for this:

  envcfg_update_bits(task, ENVCFG_SSE, enable ? ENVCFG_SSE : 0);

> +}
> @@ -262,3 +292,83 @@ void shstk_release(struct task_struct *tsk)
> +int arch_set_shadow_stack_status(struct task_struct *t, unsigned long st=
atus)
> +{
> +	/* Request is to enable shadow stack and shadow stack is not enabled al=
ready */
> +	if (enable_shstk && !is_shstk_enabled(t)) {
> +		/* shadow stack was allocated and enable request again
> +		 * no need to support such usecase and return EINVAL.
> +		 */
> +		if (is_shstk_allocated(t))
> +			return -EINVAL;
> +
> +		size =3D calc_shstk_size(0);
> +		addr =3D allocate_shadow_stack(0, size, 0, false);

Why don't we use the userspace-allocated stack?

I'm completely missing the design idea here...  Userspace has absolute
over the shadow stack pointer CSR, so we don't need to do much in Linux:

1. interface to set up page tables with -W- PTE and
2. interface to control senvcfg.SSE.

Userspace can do the rest.

> +int arch_lock_shadow_stack_status(struct task_struct *task,
> +				  unsigned long arg)
> +{
> +	/* If shtstk not supported or not enabled on task, nothing to lock here=
 */
> +	if (!cpu_supports_shadow_stack() ||
> +	    !is_shstk_enabled(task) || arg !=3D 0)
> +		return -EINVAL;

The task might want to prevent shadow stack from being enabled?

Thanks.

