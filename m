Return-Path: <linux-kselftest+bounces-3773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5799842F67
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 23:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653121F25EAB
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 22:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35D77D3FE;
	Tue, 30 Jan 2024 22:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BhYM4fuS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33177D401
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 22:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706652612; cv=none; b=Um2ctrA1V33R/tw4NLVLVbBhrETKz7HrhzZ6F/J+fMGOvzJM4tzc11p2EkEUS5LuSzacnwEMn2vhNx+LDcVD18zkVMEHgiF+tsCxoIeyluCgU0hv14pnEOC/D9WBo9rauVm6FyEGlFcdZBQS6xtbbZ5Gj/Vkq4Pz82TTJPPZJdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706652612; c=relaxed/simple;
	bh=BbwoA8VEagIWr1NfNJqugPJ+q3NLA6lFHpUPeLk62RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e58jLPVhqjv0TKT8L1DLjS+e4lPEUuD6Ec1/q/1Q7+hzneGV7hTFBIeAqv69zz3fqOJvlIcZcQNFoB3HxOe0biSsDbcSqjI1Q8RuO/KJsmqJDlt2wkdAHXDWZz1xumzyJgmf8JGIMxEev7LQeps44Adxk7KE4bbPOjFAsRzWte8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BhYM4fuS; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso2555845a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 14:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706652610; x=1707257410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+NalAEpBOXm2rq7TuoQxf0lFmytzH/73qgpQl7PiKxE=;
        b=BhYM4fuSgsiTQssJdeC9+p5gC2AWzbZ2bh6XARddS+Ho1YGqm70I7gGUYA36sAxoro
         48dCZfxS0fon1G9eXQ6PRVVYgbUb9Kkxzq4zoFV8v/X5MRiMSIt9DvOo7Lfd8o2D08ve
         PQ87zjwedtC96DijGFFE6n9zm4VPaaSWcuTTGF6pELFlS1Bt9XKMLrSFtmGOxgoVdR2O
         IzVRESY/5SzO5ahCMbaa9mHrOHfZKNiOyZdxbYjB2oR6uSGdiC940kjIRuPLeuiqlLuO
         nOq55Bvllm7fUKJNvQZby2ak2+Zqs7bT5JpexylDW+jvCY2MT/ipu8npxzGePoahXr8A
         U3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706652610; x=1707257410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NalAEpBOXm2rq7TuoQxf0lFmytzH/73qgpQl7PiKxE=;
        b=W+O/hLtnVmeIqFvP/V9P4cGh4CL/zJcPh5TR6ISV3uxMomfI5boUegYTBEC/gtdPRh
         nziI4TLfKZXTENB66v/+/1O5Xcb9JpBrjnUcVMQvE+QuVn3lnZS8WTpfvUZl8zrpZdo5
         WhdtwdjWWadLwoY4F0+8ISi4ixTmjo2Nf+QZVesXSE/RWP6Dr5SXFhtcIDAC1kmV252C
         Za8yxqRqrfeFHKEDlAwcId6jlFo+TC/oOfpUQ6qCn6Qlqq8VuB+888Qx2mHGzSgdzep+
         rR/Z5RDThmSp3Css2UF2+J0l6TaKUfooB3fYjzqIjUjENAvzzWg4tSOgkapkp1tCIK4e
         gAGQ==
X-Gm-Message-State: AOJu0YxNbNxQHqX3t7+HxCSijVRkg0OO3BH8PX91ZQseRA1TUrowY0OT
	F7efXWZOeAM4yFtswJg63rWRkMErZFn2GXinkfhsGdEdRM9bu/GddN7rw6kzMzM=
X-Google-Smtp-Source: AGHT+IG0TEzaW4Z3tywTe2xwATbdanx5HuSgB7lDcqkiSgyWa4yxiZlDC4+9TLpHCznT/n5rvfzkJQ==
X-Received: by 2002:a05:6a20:d819:b0:19c:a0f0:b167 with SMTP id iv25-20020a056a20d81900b0019ca0f0b167mr6839305pzb.3.1706652610266;
        Tue, 30 Jan 2024 14:10:10 -0800 (PST)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id jw3-20020a056a00928300b006d9b4303f9csm8274107pfb.71.2024.01.30.14.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 14:10:09 -0800 (PST)
Date: Tue, 30 Jan 2024 14:10:07 -0800
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
Message-ID: <Zblzv0KqlIZQ0wbF@ghost>
References: <20240129-use_mmap_hint_address-v1-0-4c74da813ba1@rivosinc.com>
 <5fd69812-f07b-4079-a871-7e0ee857aaca@app.fastmail.com>
 <ZbhbNYLR9kh5dtFU@ghost>
 <6352ff7f-1e69-4f7a-b793-f69d223d4684@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6352ff7f-1e69-4f7a-b793-f69d223d4684@app.fastmail.com>

On Tue, Jan 30, 2024 at 05:04:55PM -0500, Stefan O'Rear wrote:
> On Mon, Jan 29, 2024, at 9:13 PM, Charlie Jenkins wrote:
> > On Mon, Jan 29, 2024 at 09:04:50PM -0500, Stefan O'Rear wrote:
> >> On Mon, Jan 29, 2024, at 7:36 PM, Charlie Jenkins wrote:
> >> > On riscv, mmap currently returns an address from the largest address
> >> > space that can fit entirely inside of the hint address. This makes it
> >> > such that the hint address is almost never returned. This patch raises
> >> > the mappable area up to and including the hint address. This allows mmap
> >> > to often return the hint address, which allows a performance improvement
> >> > over searching for a valid address as well as making the behavior more
> >> > similar to other architectures.
> >> 
> >> This means that if an application or library opts in to Sv48 support by
> >> passing a nonzero hint, it will lose the benefits of ASLR.
> >
> > sv48 is default. However your statement stands for opting into sv57.
> > If they always pass the same hint address, only the first address will
> > be deterministic though, correct?
> 
> I think this is correct.
> 
> >> 
> >> Allowing applications to opt in to a VA space smaller than the
> >> architectural minimum seems like an independently useful feature.
> >> Is there a reason to only add it for riscv64?
> >> 
> >
> > If there is interest, it can be added to other architectures as well.
> 
> I meant as opposed to riscv32.

That is a good point. I can include rv32 as well.

- Charlie

> 
> -s
> 
> > - Charlie
> >
> >> -s
> >> 
> >> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> >> > ---
> >> > Charlie Jenkins (3):
> >> >       riscv: mm: Use hint address in mmap if available
> >> >       selftests: riscv: Generalize mm selftests
> >> >       docs: riscv: Define behavior of mmap
> >> >
> >> >  Documentation/arch/riscv/vm-layout.rst           | 16 ++--
> >> >  arch/riscv/include/asm/processor.h               | 21 ++----
> >> >  tools/testing/selftests/riscv/mm/mmap_bottomup.c | 20 +----
> >> >  tools/testing/selftests/riscv/mm/mmap_default.c  | 20 +----
> >> >  tools/testing/selftests/riscv/mm/mmap_test.h     | 93 +++++++++++++-----------
> >> >  5 files changed, 66 insertions(+), 104 deletions(-)
> >> > ---
> >> > base-commit: 556e2d17cae620d549c5474b1ece053430cd50bc
> >> > change-id: 20240119-use_mmap_hint_address-f9f4b1b6f5f1
> >> > -- 
> >> > - Charlie
> >> >
> >> >
> >> > _______________________________________________
> >> > linux-riscv mailing list
> >> > linux-riscv@lists.infradead.org
> >> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

