Return-Path: <linux-kselftest+bounces-14211-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 514CC93BBAB
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 06:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B6A1F213A2
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 04:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1042E2BAEE;
	Thu, 25 Jul 2024 04:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="eoMYAL0/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1B32B9D7
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jul 2024 04:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721881042; cv=none; b=Rq2Z91i82cfuOQmNVRmDQXzNdZK+fmIEfZAHky/EYUdB+lXRyJHg9vEvhxU+LV6e/3dUuqKbWeMMXCOd5e48yv6cIVTgzrfV/aTdFIkvIDoTGelmnKwrrzU3p9+bBxSeZ5ap4txe/G/qF9H5wu3xalqYrlR9Fz9KVCecq0f7EGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721881042; c=relaxed/simple;
	bh=Kj0U9MTC5AyxWQYTo+VsBcBXCC89clLXpFMQ9HWKWsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEGpkk669WnQPD8lXXtw4uFdX5ICaZUkkGDBUdcclDnIYlfP2/QeMdOA4e1ZomHONxQZ5nviE84l6evJI/nj018ND9eXbRF7LWTKvQUnttrqHXVkDHn5H0D7KmLls8MBMlh+JGJQGLzMyICcf621ojJ3CHzIFgCiq5wn4kAZCWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=eoMYAL0/; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d150e8153so353363b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2024 21:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721881041; x=1722485841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h+VMdQmHWFgj58kNWJtoryibFDwz3t5+vVkcIVzkHLE=;
        b=eoMYAL0/Xr4/cduuK9twqtlGo7/Et7XYVIFE69mshHwfheHhrAM63vcFtaIzLv0l9+
         E9mMHrtbLyHYEHQ7WI6kx5Neg+RkgVSp6vdV8OU86NaIGCCeTvDqkBR9akwLFtTM/n0J
         i2C/mOx2xgK6LdCVXoXeP+7yydy3G5MxeQg4TnnKUHAgKAL03Z8+bniA9+7cQ2GDS8vf
         4j0Qkezgnyx8LBO9NZtqyBkMVAM0SwBE6XrlILiTBsRDEd+gv0JnYW8/f+VlRAqCAOl0
         9f6XYHQH3TUnVJvQDFsGOzyHpiRhvw3XWnXCNqJo5aMG6YFjVdc2BGmthVO0sf+RFEdK
         hNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721881041; x=1722485841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+VMdQmHWFgj58kNWJtoryibFDwz3t5+vVkcIVzkHLE=;
        b=On24Hsg9pC+pIjdiBHAGj8cg1b78EYITGXUh8BPNVmIv7Bg2mdeKlyMnN7AgVgv1dB
         YED5Begs4XwT0q3wU93WGxnQeSmRYi8sVd+2H1qIPWGOb1deybmdf43+ZKRwpifVFe0+
         Wl4syDTlsoZyuU4YPWvN1xf4Zz1mH3n2VWtwYZ7dYFTqFX5oN/t8hsDyRNXJijihwodI
         aAaUkpWAhQTeawzCXxciGtTij/D1f/rKuY4R3qmlxwEykCi37A3GVBaOdVPk3IW8bZwG
         Imae/WFjkogseE5Ejt3uc5kyEgMVm3SeQBMDPBfMAEth+yv+Iqx4ptWeg/sZfwhMIRBu
         I0yw==
X-Forwarded-Encrypted: i=1; AJvYcCUQC2n4idvfQVHHJ6Cj08aAkFfQbWhSGtNogHwCtK+9abxpyYi5U2AcXsMOzTwpkK8dSPbgiKw47xBS6kWkutVfbNXRrvE99iNTp2cL0qa6
X-Gm-Message-State: AOJu0YzHjVw4Z+TZ795OxLnQ1ua/NkYHfge0PX6eMmNH8x/g+NKkpHRW
	vYz76Ai+lEBvwnkcCjHIesthGgBwn4RGd0FFgNoShhdFMC8HVB8JC92nm93imn8=
X-Google-Smtp-Source: AGHT+IG8/lGGFfeqD0yKL6Ukrgul7u0XCxEnqHsWKKVCOGqLNIttHBNHSYlpgXB/YPJd1O/zSdOyZQ==
X-Received: by 2002:a05:6a00:66cd:b0:704:151d:dcce with SMTP id d2e1a72fcca58-70eaa1e2e1emr2589164b3a.5.1721881040621;
        Wed, 24 Jul 2024 21:17:20 -0700 (PDT)
Received: from ghost ([2601:647:6700:2d90:4e8c:b287:20dc:e447])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead874b35sm322537b3a.167.2024.07.24.21.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 21:17:20 -0700 (PDT)
Date: Wed, 24 Jul 2024 21:17:16 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Conor Dooley <conor@kernel.org>, robh@kernel.org, krzk+dt@kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
	jszhang@kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
	samuel@sholland.org, samuel.holland@sifive.com, corbet@lwn.net,
	shuah@kernel.org, guoren@kernel.org, Evan Green <evan@rivosinc.com>,
	andy.chiu@sifive.com, jrtc27@jrtc27.com, ajones@ventanamicro.com,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v7 09/13] riscv: vector: Support xtheadvector save/restore
Message-ID: <ZqHRzAI0O+zsZd3A@ghost>
References: <20240724-xtheadvector-v7-9-b741910ada3e@rivosinc.com>
 <mhng-28424e23-c9b4-407e-97d8-9dbb09101781@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-28424e23-c9b4-407e-97d8-9dbb09101781@palmer-ri-x1c9>

On Wed, Jul 24, 2024 at 08:23:27PM -0700, Palmer Dabbelt wrote:
> On Wed, 24 Jul 2024 12:14:00 PDT (-0700), Charlie Jenkins wrote:
> > Use alternatives to add support for xtheadvector vector save/restore
> > routines.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> b4 isn't applying this, either on top of your last patch set or rc1 -- the
> base commit in the header isn't a hash I have, so I'm not sure where it's
> mean to apply to.
> 
> Also...
> 
> > ---
> >  arch/riscv/include/asm/csr.h           |   6 +
> >  arch/riscv/include/asm/switch_to.h     |   2 +-
> >  arch/riscv/include/asm/vector.h        | 225 +++++++++++++++++++++++++--------
> >  arch/riscv/kernel/cpufeature.c         |   5 +-
> >  arch/riscv/kernel/kernel_mode_vector.c |   8 +-
> >  arch/riscv/kernel/process.c            |   4 +-
> >  arch/riscv/kernel/signal.c             |   6 +-
> >  arch/riscv/kernel/vector.c             |  12 +-
> >  8 files changed, 198 insertions(+), 70 deletions(-)
> 
> [...]
> 
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index bf25215bad24..cb48092fdc5d 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -845,10 +845,7 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
> >  			riscv_isa_set_ext(ext, source_isa);
> >  		}
> > 
> > -<<<<<<< HEAD
> >  		riscv_resolve_isa(source_isa, isainfo->isa, &this_hwcap, isa2hwcap);
> > -=======
> > ->>>>>>> 0f260ac829ca (riscv: Extend cpufeature.c to detect vendor extensions)
> >  		riscv_fill_cpu_vendor_ext(cpu_node, cpu);
> > 
> >  		of_node_put(cpu_node);
> 
> This chunk isn't applying, and it's got a conflict marker in there.  So I
> think that means something's gone off the rails?

I really messed that up... Okay I sent a new version that is based off
of your for-next that should work?

- Charlie


