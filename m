Return-Path: <linux-kselftest+bounces-3732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5D68418F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 03:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE1731C2168B
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 02:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBD437163;
	Tue, 30 Jan 2024 02:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wyUCLl4+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1A8376FB
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 02:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706580794; cv=none; b=VWqbx5+F/NXpX0dXf4mYKakuA0+IaVLW7Jx8eVBjfS/Gpk1Xftq0x/uInz9yet7URfNnJvd40qXL/Vr4B+i/HRsQjeE+J6ypvixmkOiw6ey1Xz+HWn7iQNY+GslNa21lI7lEu9xDE6VMogNrFlfPnYK5W/2pAHVRy64oC5l4m7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706580794; c=relaxed/simple;
	bh=yq+b5cQUkB2D3h6YeIpBqFowbagqHVJusAdTbFf8lgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbNEdqzWqFPbq3pIhG8Mt+8pEo/9OBdCLCjlZHNROVhTrxiWm2zq34C/BW9ubihVSewutOxS82BujPqfIm2D5ALx4upDekuMIZFPLmOnhEB8ScgPVHnTIV3s36rwiY5i3pzc2jxGZDQcnc3/Lm6GzhMsj0p9FYV6z9kSMSvkoUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wyUCLl4+; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2906dffd8ddso2640826a91.3
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Jan 2024 18:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706580792; x=1707185592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DQaT8hj9ZpasOuVjPktNO03JfGtp4YjpodrI5ChBkx4=;
        b=wyUCLl4+Vygco1loe4nBvVkDlK6oNXS393SSYEsYEdFZrGk+teDmNn9D/FaCQrd0Nz
         18muO+yqbCoyNkU690WLL8uli3d/cRB53qFgQZ29uG9IKZs+yKtrrGOoITfmIBSgzsrm
         EfN8VLSEkVEfm4LhVYQgZ4KGaGnf9yLAR/Hw+iEpCiqmBdg7LpFEuGwbfjf0+pzw69Bu
         n0rQcABNTOf+CWyOotxWXq6xWlAVNIKBVVjoVYwsNUcsJwjZTeJpIXvBB1ST76nX6vD4
         T8DS9Gouhv6FN0sbOsJqgYb+kGwYCouLGoNm3eWKXSGeDscrUdSPjaREnfgGGuHb5KJa
         3sdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706580792; x=1707185592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQaT8hj9ZpasOuVjPktNO03JfGtp4YjpodrI5ChBkx4=;
        b=PpnKQSFFjk4KIsL9HVBV8P5e5ZJV6JzXnvEWI1KBZi+d87sqmgNmimcRxygIc6h6vr
         ky4Obzs2g7wHgpRZpu09d811LxL1gI56VmMZGe/XrDvbOUFYc67qm+SBWDqgnMKscdjR
         GNG/yDoGQB9fh5O8eT7xSPETN/3J08zGYKj5h+rTxG714qjkZh5NazB1VM17IkAgDslh
         P+pYhf2Pc53BTkdjUEeoumjPaTpuy13cBf6dcYwTO5bMMJAIg4GxnSEnY5eDQA8MxNPl
         nVWGDvDXtAj7/Ue+9vu9hmDWPnqp8LSWuG2Yacmn77RO/LV5ryQbZu7EnnUi/qVNuMZW
         Vq+w==
X-Gm-Message-State: AOJu0YysHByNLv+wak8ODUVRBThpV8kXKJVNktqJ+x15I93QPYOitF4C
	Lj2OOHyfMc9LbqJG7xWC4knM/JwtiQ2siSBwJ1Xq2T5tr50dwJHuPDVaLUKLWZw=
X-Google-Smtp-Source: AGHT+IGKP9RXIyiwUw8upG06pjp1lfxwwS/marEgSfmUDOzH74kmqKn7lMQecZuLvp8FuLFyForibQ==
X-Received: by 2002:a17:90b:400f:b0:295:ae0c:24c3 with SMTP id ie15-20020a17090b400f00b00295ae0c24c3mr417911pjb.44.1706580791833;
        Mon, 29 Jan 2024 18:13:11 -0800 (PST)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id sc13-20020a17090b510d00b0028db6cd0ad6sm7244836pjb.3.2024.01.29.18.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 18:13:11 -0800 (PST)
Date: Mon, 29 Jan 2024 18:13:09 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Stefan O'Rear <sorear@fastmail.com>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Yangyu Chen <cyy@cyyself.name>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/3] riscv: mm: Use hint address in mmap if available
Message-ID: <ZbhbNYLR9kh5dtFU@ghost>
References: <20240129-use_mmap_hint_address-v1-0-4c74da813ba1@rivosinc.com>
 <5fd69812-f07b-4079-a871-7e0ee857aaca@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fd69812-f07b-4079-a871-7e0ee857aaca@app.fastmail.com>

On Mon, Jan 29, 2024 at 09:04:50PM -0500, Stefan O'Rear wrote:
> On Mon, Jan 29, 2024, at 7:36 PM, Charlie Jenkins wrote:
> > On riscv, mmap currently returns an address from the largest address
> > space that can fit entirely inside of the hint address. This makes it
> > such that the hint address is almost never returned. This patch raises
> > the mappable area up to and including the hint address. This allows mmap
> > to often return the hint address, which allows a performance improvement
> > over searching for a valid address as well as making the behavior more
> > similar to other architectures.
> 
> This means that if an application or library opts in to Sv48 support by
> passing a nonzero hint, it will lose the benefits of ASLR.

sv48 is default. However your statement stands for opting into sv57.
If they always pass the same hint address, only the first address will
be deterministic though, correct?

> 
> Allowing applications to opt in to a VA space smaller than the
> architectural minimum seems like an independently useful feature.
> Is there a reason to only add it for riscv64?
> 

If there is interest, it can be added to other architectures as well.

- Charlie

> -s
> 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> > Charlie Jenkins (3):
> >       riscv: mm: Use hint address in mmap if available
> >       selftests: riscv: Generalize mm selftests
> >       docs: riscv: Define behavior of mmap
> >
> >  Documentation/arch/riscv/vm-layout.rst           | 16 ++--
> >  arch/riscv/include/asm/processor.h               | 21 ++----
> >  tools/testing/selftests/riscv/mm/mmap_bottomup.c | 20 +----
> >  tools/testing/selftests/riscv/mm/mmap_default.c  | 20 +----
> >  tools/testing/selftests/riscv/mm/mmap_test.h     | 93 +++++++++++++-----------
> >  5 files changed, 66 insertions(+), 104 deletions(-)
> > ---
> > base-commit: 556e2d17cae620d549c5474b1ece053430cd50bc
> > change-id: 20240119-use_mmap_hint_address-f9f4b1b6f5f1
> > -- 
> > - Charlie
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

