Return-Path: <linux-kselftest+bounces-24560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9A0A11EAB
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 10:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E049A188E0EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 09:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5F320C47C;
	Wed, 15 Jan 2025 09:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fGrqq/xO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8D82045A5
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 09:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934996; cv=none; b=gcsMDk9vBVH5ghSaHGvETDsQf9tZ1KU1cT/q1URdZMnotFGKlfu8t72Y/THPNVWEpURoQBCAk93LgaEaFDwG52tnHTMnh1HsBegwbpo2qBTOpypZQOaCOWxYQv+iZK+dZuHsVQBQys1+VmU6rIfcfjLtPQ09prXiaxOxnjLx5OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934996; c=relaxed/simple;
	bh=L870qFo0KOkpZT6XBmlzKlVirLwOYgi92uROEl98Vuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGOQS/znKCxc6ZfmATye8aVw4fUyD0ja2JkK3cAoJFxkpduYraCFIR/jTmdB2nlBPVjhr4TVoRL2gcsWJbQuZnXLhMvJ7jvHouO4u8eY++HnLxPJb2tlSk9+jrKM8xfKC9Gn9KTN0ifE0FQ+siIa8sJ5EVuAkMdnKDivVsMmFaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=fGrqq/xO; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385e0e224cbso3325536f8f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 01:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1736934993; x=1737539793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ke3Xx/wtgubyAhgh9gm7HdjX/OGZn6UodYiywkGpxs=;
        b=fGrqq/xOK23x9G8CxKhPRFtPpqC3LYoMwdQEC10E2OMSjm14W8+suQO+UVQjs1sK9h
         H8/lucJd4TNYPXH8kwrrOh5VUfNhf6GlUQ2b+aNQKR8LJ0KpBsbwFpsILxKBrdqGQ228
         fYuviOqruvx4aPkDableuCf6iBvlg74aV72YER8EvDmUbM6M720tc1pvyuGycSCZmeKv
         ppwpU9x/41uX2DVaKMLWKzRUCRvGOKgOC/m7zU0ulXQcLv1y5lIJVC0FfX0be6CWUTGC
         +GdyjnpKmInvj3apu8PtiB/jdu3E59A2R3m/Gfdrljhufg5qNt+uYGlnTpjaBGuiRUxd
         aEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736934993; x=1737539793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Ke3Xx/wtgubyAhgh9gm7HdjX/OGZn6UodYiywkGpxs=;
        b=d6bB9KSOLdq6Y6sbxQ5Mj2dmXynXJN1EYveDeBptgXXDRcSAR2CxJJaxUF9pkfEm7U
         VoygWcH8xLvXmSd8wBKTR0FjGhGMfOOHqpqfU2t14rBZdSgIhRm8fLpu4Wb+JnyUWwh5
         TXK90aPzJM5zP0drRIstFS41umMajKMJRs7c4n9BDAJsdpmRe4rs4lPSVXFkn2F50yO+
         QtJlXQzcP7L5bgBTgN9SiaoGedFeCOiTialZZ+8+UahYueYnKL/Hx+BjSxRphEPDQP/I
         l2u83QVrnQaslbOX57/FTcpSnVLlDjOpi3rUyT8BrcjXdkePT/nuUcEpDCzomuOJc6Fd
         gvdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU419kOLl/zpfSr+fMluj2r5BHmJgTRD79Dl7ZUYrElskq0O1nzP5TP7We++3xg91cqoIi7JF9UUtfCIzWwJ1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBLzziVVlSnpTmG78nBcI+ryeYFDxW1XuJ5emnTI3kujIdJbMb
	dL1iev7/y7oopnQL/R9LwP9/Q4pYDcLjoUBXb4LyqT5/X80J6Cky+aqvUF6qyWc=
X-Gm-Gg: ASbGnctcWPtKG6ZeOkd0bKdWTnUimKNOl8oPfcAFDLbTsv5fzhvepKbg2OHUrvwALMI
	nxIgHe0mDTCHt/HG2CjapSGrWQH688UaUAVMd27Lv5auc/xDk7gF8rQhXgz55zUXuIoELjnETvR
	/YjsQYH7LYShmgA0gqLExhEanpRl8TlbcA/A7xWYrVA2wny+9R+zJuUFBgEhefQmDYljJxxWZFp
	I1yAiY5AmxOj2vMgaiorqoxEP0umeOxpXL+TSmP2qQdEa39D8mZu+wivyHdqd9d6SuDVYji54EP
	X7N61/nEzPaBZkXMFzXF+JbY6f/U6SlaG1/ugUTebw==
X-Google-Smtp-Source: AGHT+IENVizyrpTDaL6AXD65KcGWw+5Em2NxzXA8Eh98pJFESDPN89Pap+1V8u237LVHxYhDj/sKOA==
X-Received: by 2002:a05:6000:184e:b0:385:f560:7911 with SMTP id ffacd0b85a97d-38a872c93e3mr25276895f8f.10.1736934993168;
        Wed, 15 Jan 2025 01:56:33 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c749989asm17783685e9.2.2025.01.15.01.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 01:56:31 -0800 (PST)
Date: Wed, 15 Jan 2025 10:56:31 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Celeste Liu <uwu@coelacanthus.name>
Cc: Oleg Nesterov <oleg@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	"Dmitry V. Levin" <ldv@strace.io>, Andrea Bolognani <abologna@redhat.com>, 
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ron Economos <re@w6rz.net>, 
	Charlie Jenkins <charlie@rivosinc.com>, Quan Zhou <zhouquan@iscas.ac.cn>, 
	Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>, Guo Ren <guoren@kernel.org>, 
	Yao Zi <ziyao@disroot.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Subject: Re: [PATCH v5 2/2] riscv: selftests: Add a ptrace test to verify a0
 and orig_a0 access
Message-ID: <20250115-9a1a8e824977f49770a5358e@orel>
References: <20250115-riscv-new-regset-v5-0-d0e6ec031a23@coelacanthus.name>
 <20250115-riscv-new-regset-v5-2-d0e6ec031a23@coelacanthus.name>
 <20250115-28c95808502d43f84b3fe0a6@orel>
 <17dfb122-4ae3-477f-93a8-1748b819c59c@coelacanthus.name>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17dfb122-4ae3-477f-93a8-1748b819c59c@coelacanthus.name>

On Wed, Jan 15, 2025 at 05:41:57PM +0800, Celeste Liu wrote:
> On 2025-01-15 17:14, Andrew Jones wrote:
> > On Wed, Jan 15, 2025 at 04:24:59AM +0800, Celeste Liu wrote:
...
> >> +#ifndef sizeof_field
> >> +#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
> >> +#endif
> >> +#ifndef offsetofend
> >> +#define offsetofend(TYPE, MEMBER) \
> >> +	(offsetof(TYPE, MEMBER) + sizeof_field(TYPE, MEMBER))
> >> +#endif
> > 
> > I think this is the sixth test to define these. We should copy
> > include/linux/stddef.h into tools/include. We already have
> > tools/include/uapi/linux/stddef.h with __struct_group and
> > __DECLARE_FLEX_ARRAY, so I think it should just work.
> 
> Agreed. But it may be better to be a separate patchset
> so we can change those definition in different selftests
> one pass.
>

I think a separate "copy stddef.h" patch could be in this series to
avoid having to add the defines here. Then, another series can be
sent with one patch for each conversion. That said, I'm OK with
adding the defines for now and doing the conversion later. I just
hope it will actually happen.

Thanks,
drew

