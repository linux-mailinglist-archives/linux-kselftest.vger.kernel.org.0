Return-Path: <linux-kselftest+bounces-7228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FB3898EE4
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 21:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7061A2828FC
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 19:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E821339AB;
	Thu,  4 Apr 2024 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KBQj/lSE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD5D133426
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Apr 2024 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258474; cv=none; b=ZdEUMJeJgeTACIImTbO8ZILviiE5HS7V2Hj4+PelOepGkAhohLUQesh9hQ27NbH9mQyxeZMcVrGtni24PnQ7zDIctdWeelMaiUZgHHtDlEDxQ6+y4zgR8dB7PecCvRKUAnOJUKA2SisgVSGVXM0MqWLtAOM18HSI8priTgACE5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258474; c=relaxed/simple;
	bh=CVr2IxXDHjqtPIjdakFNnsSdpqceotjDCl0kfyrywLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iN3iyYiu5Oh1Fk1CL6hJ8iut91NeVi98ECRp7lovWGuz+DhxOQfyfQcpSWvPuY+rdVadfPYx20tQvRU19acqzHUdiC8eXG4k4EJWqgR8LYU8ai0JYH7um9lpFhAsul+4cLiKKfd2faI/9VlousE8HVPKhztGhN8LPWwdo++uOSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KBQj/lSE; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-61149e50602so10270287b3.0
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 12:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712258472; x=1712863272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dl/FopeODNdULB5NSwrsajN91zng/VnqM090COn1yWc=;
        b=KBQj/lSEZpu6lpVtuj6vzcFweWjT8/rKVwz+ZUh6Lv3d8KOkBbvx5uXejk73IwFE35
         wdKPc+rm0gS14kpdoo06ZOpjSb8GIKeVAh6ZDJdBKJXsIXoB2ZmYJU+yy6gzGJJFmX3P
         rcJe1Uhilps6C5LDxJUWay3FSyt4mwewYB2J5ANZB/0e6H/WDkTSyoZCL4stNx6dkZjM
         j2NvxGCyjfPxVs47V+zWIOO9AZmtUvBT4m0snww90NXGvRpfGyUiyUDiIP77xBYD5pZO
         9Gv2qNFtM1BalkylcoJUt6mXM834x79Rr0oVTr6MaUbOo0F5ZN/Dfr8aNgjNkpR9ePCW
         +DhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712258472; x=1712863272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dl/FopeODNdULB5NSwrsajN91zng/VnqM090COn1yWc=;
        b=upllgi7Ww82ETYM/r2K6ar12pyPKdAKi+OAwQKAMPnG6CM8gHJwhvkGRwnbtQBL55T
         OwZEiQChJ1TjXR0Il3xcC5yTxu+0JZ0AzwoG46alKkSGzUfGT3Xquq6WOfsK/ehLHh+R
         BqO2JESK7AmatZ9+k6ce3XjgQ5UH1Um6FEop/UETjKeFp9fkFDTWyj/i0kChyQ+kHfQF
         qODGxiyIbohpIyW+jrrhC7C6Ni4ywDrTISxEp6ebKLmfO7uQaTiUsgRie4QS6kxAHVyP
         fxFt+GINPOmb7q+xblGEq0wyusWWLui9qHRcJEDHOunaOVXtPv01yNmXTT8jwNEfuj5I
         fjRw==
X-Forwarded-Encrypted: i=1; AJvYcCVcaRG/0DHTdQGtMLHvcH0CLkzw3Qiz05YjtCxN2hAu6xAle8BPMeT5QWvs+OfYkN2W+6n2H4tvedWWiegtrUEVmbT7yM1Q5pCrGVGtdXH+
X-Gm-Message-State: AOJu0YzENtmdC8LO4rQoE/DNUcyhAVwqa6i0mD/dw3zPwBHss2lz3sQz
	U1JjOZd+ykJHhWiaYxbthnR7UhpDI8flX0SVFNGStrPZ3Tqc7ubYYP63BdAcqCjd1WKw2CXdILB
	F6BUqAnidIeOjLH4/4ijfAVwgs+xae+qjYL9ZlA==
X-Google-Smtp-Source: AGHT+IGyZ3JMNrz8F2bkpirKnyuGQawxZoeXVCC/y6GzZBE4nmRVGOFkLbxGUyQaEHSmHXKt9NtfMMywjFKnI39zfuA=
X-Received: by 2002:a0d:dd8c:0:b0:615:e10:691c with SMTP id
 g134-20020a0ddd8c000000b006150e10691cmr414269ywe.1.1712258471733; Thu, 04 Apr
 2024 12:21:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403234054.2020347-1-debug@rivosinc.com> <20240403234054.2020347-9-debug@rivosinc.com>
 <8fb37319-288c-4f77-9cd7-92f17bb567ee@redhat.com> <d3689521-58a7-47df-bd6a-0e2e60464491@sirena.org.uk>
 <604863a6-0387-4f29-9c4e-5ef86a8ca904@redhat.com>
In-Reply-To: <604863a6-0387-4f29-9c4e-5ef86a8ca904@redhat.com>
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 4 Apr 2024 12:21:00 -0700
Message-ID: <CAKC1njRT0GHJEY2NYWuPm7Az7yCj0ZWSevYj1NY6npr136jfsA@mail.gmail.com>
Subject: Re: [PATCH v3 08/29] mm: Define VM_SHADOW_STACK for RISC-V
To: David Hildenbrand <david@redhat.com>
Cc: Mark Brown <broonie@kernel.org>, paul.walmsley@sifive.com, 
	rick.p.edgecombe@intel.com, Szabolcs.Nagy@arm.com, kito.cheng@sifive.com, 
	keescook@chromium.org, ajones@ventanamicro.com, conor.dooley@microchip.com, 
	cleger@rivosinc.com, atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com, 
	alexghiti@rivosinc.com, samuel.holland@sifive.com, conor@kernel.org, 
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, corbet@lwn.net, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, oleg@redhat.com, akpm@linux-foundation.org, 
	arnd@arndb.de, ebiederm@xmission.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	lstoakes@gmail.com, shuah@kernel.org, brauner@kernel.org, 
	andy.chiu@sifive.com, jerry.shih@sifive.com, hankuan.chen@sifive.com, 
	greentime.hu@sifive.com, evan@rivosinc.com, xiao.w.wang@intel.com, 
	charlie@rivosinc.com, apatel@ventanamicro.com, mchitale@ventanamicro.com, 
	dbarboza@ventanamicro.com, sameo@rivosinc.com, shikemeng@huaweicloud.com, 
	willy@infradead.org, vincent.chen@sifive.com, guoren@kernel.org, 
	samitolvanen@google.com, songshuaishuai@tinylab.org, gerg@kernel.org, 
	heiko@sntech.de, bhe@redhat.com, jeeheng.sia@starfivetech.com, 
	cyy@cyyself.name, maskray@google.com, ancientmodern4@gmail.com, 
	mathis.salmen@matsal.de, cuiyunhui@bytedance.com, bgray@linux.ibm.com, 
	mpe@ellerman.id.au, baruch@tkos.co.il, alx@kernel.org, 
	catalin.marinas@arm.com, revest@chromium.org, josh@joshtriplett.org, 
	shr@devkernel.io, deller@gmx.de, omosnace@redhat.com, ojeda@kernel.org, 
	jhubbard@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 12:15=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 04.04.24 21:04, Mark Brown wrote:
> > On Thu, Apr 04, 2024 at 08:58:06PM +0200, David Hildenbrand wrote:
> >
> >> or even introduce some ARCH_HAS_SHADOW_STACK so we can remove these
> >> arch-specific thingies here.
> >
> > It would be convenient if you could pull the ARCH_HAS_USER_SHADOW_STACK
> > patch out of my clone3 series to do that:
> >
> >     https://lore.kernel.org/all/20240203-clone3-shadow-stack-v5-3-322c6=
9598e4b@kernel.org/
>
> Crazy, I completely forgot about that one. Yes!

I missed that. Roger.
Will do that in the next series.
Thanks.

