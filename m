Return-Path: <linux-kselftest+bounces-6953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28938894488
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 19:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59EC41C214B6
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 17:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21D84D9E9;
	Mon,  1 Apr 2024 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="La2OO3yl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028894D5A1
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Apr 2024 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711994169; cv=none; b=R5k+6DMRQDvtSf/l6hgDV5k0vp0Xn8HWx1uzTOP0Mqdug0FqJZjoqE+d9iTiw37jrwdWchP0vsyY0cdOTjnuz05ICRJgIjUe7XKjzPbw77FE6iEufWYWy+/icCKBE4Qv+GsX8jU2MEz9hPEFBzIpNy1mHSB95Us+NtBWcHsExyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711994169; c=relaxed/simple;
	bh=fJ3mDYlOFdsxP5e3NSHYMyBrX3fsoPQq5tmWrO4oCpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYCayxVMtjTP3Wg45uWjYuxbUYh0Y49WjRyqq7vlL3QP5iljVpOdv2RxGPZtQSdYHI/JivTknggQENdVKw+TAr71GMdxf/Kq1L+RIh055YGk/9z1YTFRgA98zyzBpxVQdVN3OnplvvtSsbqKVffBTr7VMGqH3F504hvAtjKODiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=La2OO3yl; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6143fd4c182so28966697b3.0
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Apr 2024 10:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711994167; x=1712598967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ayg8yEodnyIkhrNKh0vWxZ555hD22ZpFvhWL8Rikvao=;
        b=La2OO3ylCdYIFPVA3jXXm6oenj1aweY8q87bO0Ib7DBSHhMrxT73tScAvjg9KbUwW0
         518LczmaGyah+E4JgHdbyxSrUF7++zrIMRmAz3vwvAKSPtw2Xyj1XUXZVGCMkv4JHUsD
         YjJdUKFNzF69ThurIJ5lf/FkYzA7dtzXcvQ1g5e/pesIoj6hyrQuRQ048q3QvC09HO3R
         eUWrQIxib3Byc4A00Ravnsuxe+AwBFz8bDbgl5CnoMCMthovkO3h7GIztw2ZenYFjvJr
         ThW8Vd9nQVB5AcrRvzh/ynAwsYoStF5n6zoone9flnGkSMCOasQth32PaBDuBu1OLGzs
         jBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711994167; x=1712598967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ayg8yEodnyIkhrNKh0vWxZ555hD22ZpFvhWL8Rikvao=;
        b=bY9qYAFxPikmjUAeIkMd8sxZN3SBb9eDp3DtoIEF60Mk5xWTi6f5N2Qr2P79U3lkqA
         u4oL+9IWOc1dROiIi1Z/RdAq/Bpt8V7YBIDGA7jnQPO0lNj0mJHtQTnJCxFBrUb/N7qF
         vYFc/gLIiNILa166DDEIdrIE7LqWfazyNibkZvTwzi8sMdX0e4ggEupQSvStNgLc6qKQ
         SCat/bRn4TA8ZN6LtBEAzvoDbUXcxKDhFsvrye/Fb3t+uypnETIf7XWEnM8Q3NwGVhOo
         d8USfwBuRR3OFwouA942ZsNmJkmxkOeWVbe5Si6Zd+nNar4Epob7HGV49r+CBxSOF62G
         TBAA==
X-Forwarded-Encrypted: i=1; AJvYcCVegFg9e4Dos5ZH0IaB5IU2U5STaHHeImP+UeXLb3Ath/sw/b3VvkApc3QS3fGizp4ZO5lreJ6dHlsO3RmX8uP+jToBpHSL7BEBV6Vhjgwy
X-Gm-Message-State: AOJu0YywcirojqDwNJ6oIkeatns8QVYGAqvsaH8D/DYkuJKNrnfsZrqx
	LBFsyr2hCLb41gETFDIFzuCmIZ/pwV2Nd2NgVuoieaeppccIx0bGOOiWH2xcilFVcCVZ523keH1
	aKEe+p5yOcRVI/TvJ0F0v42bQWHMSMZYXXQ5Sag==
X-Google-Smtp-Source: AGHT+IHbNEbSTz8DBCYKR9MqO/caPtbEZWICPniiYQejcusJBa6iSdkbnh9sfMt7GjtTJc/3SigyJ/z+M6qQOU/SrM8=
X-Received: by 2002:a0d:c984:0:b0:611:a5b:337f with SMTP id
 l126-20020a0dc984000000b006110a5b337fmr9528979ywd.10.1711994165573; Mon, 01
 Apr 2024 10:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329044459.3990638-1-debug@rivosinc.com> <20240329044459.3990638-28-debug@rivosinc.com>
 <4b38393a-f69d-4a77-a896-b6cd42c7edcf@collabora.com> <CAKC1njQ_RU=uHhrna=MFVdjAMjjQNqZWnkjPoJvO7CxtPMeNuQ@mail.gmail.com>
 <ef72ae20-6b68-496a-a819-8818ade0d433@collabora.com> <CAKC1njQj7GfkdE1HJD54utkoPqJXyqMeoXOxa6ActqZ-fSDuKQ@mail.gmail.com>
In-Reply-To: <CAKC1njQj7GfkdE1HJD54utkoPqJXyqMeoXOxa6ActqZ-fSDuKQ@mail.gmail.com>
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 1 Apr 2024 10:55:54 -0700
Message-ID: <CAKC1njR3+mxZHEig8iZo+=0k_VFWg9ZYO3pzGi6s=uLZ5hOkKw@mail.gmail.com>
Subject: Re: [PATCH v2 27/27] kselftest/riscv: kselftest for user mode cfi
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: paul.walmsley@sifive.com, rick.p.edgecombe@intel.com, broonie@kernel.org, 
	Szabolcs.Nagy@arm.com, kito.cheng@sifive.com, keescook@chromium.org, 
	ajones@ventanamicro.com, conor.dooley@microchip.com, cleger@rivosinc.com, 
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com, 
	alexghiti@rivosinc.com, samuel.holland@sifive.com, conor@kernel.org, 
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, corbet@lwn.net, 
	tech-j-ext@lists.risc-v.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, oleg@redhat.com, 
	akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, lstoakes@gmail.com, shuah@kernel.org, 
	brauner@kernel.org, andy.chiu@sifive.com, jerry.shih@sifive.com, 
	hankuan.chen@sifive.com, greentime.hu@sifive.com, evan@rivosinc.com, 
	xiao.w.wang@intel.com, charlie@rivosinc.com, apatel@ventanamicro.com, 
	mchitale@ventanamicro.com, dbarboza@ventanamicro.com, sameo@rivosinc.com, 
	shikemeng@huaweicloud.com, willy@infradead.org, vincent.chen@sifive.com, 
	guoren@kernel.org, samitolvanen@google.com, songshuaishuai@tinylab.org, 
	gerg@kernel.org, heiko@sntech.de, bhe@redhat.com, 
	jeeheng.sia@starfivetech.com, cyy@cyyself.name, maskray@google.com, 
	ancientmodern4@gmail.com, mathis.salmen@matsal.de, cuiyunhui@bytedance.com, 
	bgray@linux.ibm.com, mpe@ellerman.id.au, baruch@tkos.co.il, alx@kernel.org, 
	david@redhat.com, catalin.marinas@arm.com, revest@chromium.org, 
	josh@joshtriplett.org, shr@devkernel.io, deller@gmx.de, omosnace@redhat.com, 
	ojeda@kernel.org, jhubbard@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 10:34=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> On Mon, Apr 1, 2024 at 2:48=E2=80=AFAM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
> >
> > >>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> > >>> ---
> > >>>  tools/testing/selftests/riscv/Makefile        |   2 +-
> > >>>  tools/testing/selftests/riscv/cfi/Makefile    |  10 +
> > >>>  .../testing/selftests/riscv/cfi/cfi_rv_test.h |  85 ++++
> > >>>  .../selftests/riscv/cfi/riscv_cfi_test.c      |  91 +++++
> > >>>  .../testing/selftests/riscv/cfi/shadowstack.c | 376 ++++++++++++++=
++++
> > >>>  .../testing/selftests/riscv/cfi/shadowstack.h |  39 ++
> > >> Please add generated binaries in the .gitignore files.
> > >
> > > hmm...
> > > I don't see binary as part of the patch. Which file are you referring
> > > to here being binary?
> > shadowstack would be generated by the build. Create a .gitignore file a=
nd
> > add it there. For example, look at
> > tools/testing/selftests/riscv/vector/.gitignore to understand.
>
> It's `shadowstack.c` (a C source file) and not a binary file.

Nevermind. I think what you want me to do is add a rule in `.gitignore`.
I was thinking otherwise (that somehow you're seeing a binary file in
patch set).

Thanks. Will do that in the next iteration.

