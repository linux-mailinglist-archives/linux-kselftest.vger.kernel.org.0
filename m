Return-Path: <linux-kselftest+bounces-11586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55946902804
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 19:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF6C3286A26
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 17:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B44149DFC;
	Mon, 10 Jun 2024 17:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yE0KIRH9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD4715CE
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718041889; cv=none; b=VzWJSHKaFHjTovotaM2plw3VDiIN1dotddRQvkzFW8zO40ohnLMe/0yFu41h2RVaBRYLBM/C/eB1IZsUBEyrle3KWsw1D54UkWke1FWNOCaS+lenoQP1gDOkJ0TPm9EOU/sE6uN4tXRj74l9E+reTB5wqX0BZYWfHQ6SRPtxEWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718041889; c=relaxed/simple;
	bh=FneSkAV3jCsGNrND9Mj7IMRiPZCTqIkhyvxDpV4xx9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clw+62PXF6n93AjoyTFS//heIqaK+vpFD2uJ9IBC6xkSV4CoQey3PuE7ytIfHIGi3+K2rZ1nxSg0e0EKQ1fNj5x4Ju+WgPRTgM673y5MiQZDHQxXcw8v0+QGgzxPrHpcVUIDt1cyKHebDfbmDypa2xuUx6h8hULmmpZUKwvoBd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yE0KIRH9; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f44b45d6abso38859005ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 10:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718041886; x=1718646686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XqAidOJkzifwbi0aDp05YiJHEtIMzMs4UmIa/z6sCUY=;
        b=yE0KIRH9+P2WH31mEKxGqMl6YrJ2kM3lDc2H7CjK/4nFbG5zIHxnzLypiGDiDe/EAb
         l3Z/OxaYHvAH2OT6OlwkH78xLTO70SVgHxRXOafcvewJa/zCXSig0+QQc2oxsHw1S0dw
         6ZjN5wl3WbVAzNk9ng8ceDT5j7zAz/5es2/MNLWZea2MhWYhg0M/XrzmjtYKIyjaE8Ws
         M8l26/4sWYlgJbrY0binfq0UVC3bseNp1YnissWeCwLV8uskDnPxd325dW5/Hj2qOtsv
         pA2YbEZgSQbumZZiNtXJ4x/m/1kJY8QXwjII1o+rBNnxLD2mMHanz73u1tCDsVqYSdkC
         NZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718041886; x=1718646686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqAidOJkzifwbi0aDp05YiJHEtIMzMs4UmIa/z6sCUY=;
        b=iA/OcRe3hZ5CFVwyi1pyLOqNwMv0lxSYPMOk8rwvYrwXnUabORuRi9sCmKC/mZgrjO
         mvBawtMiOCNWufcrfkvlv8w1o8Z63lrOJE/wGdipF6zgXYgjxtP4mV5HB9woU9utzSkW
         0Edu9oHOLcPuicQGvOUh57w+04R2NYLZByDmVJlzNw108HveqZZfTKaDa5zAG/3g2B1k
         iV3DPS6WwmNhdkfiWikmT47ntT4U3itvkg5Q5xZji5Gorf7XrXOf2pR+SHQ38cbmJy3f
         u6/BhNYHM1M4yg8dGnSyDp4vC+khuwmdHN2PL7onKDNWQto8vmG1bNzpzMQckjofkTfi
         TddA==
X-Forwarded-Encrypted: i=1; AJvYcCVxH8pbUuDCUGdTTDhKG5psuw/NhSdSHhLWR2DrO28ZYZQeRiTk5QoKqwarOkgldU9d8MOqx+rbce0ThAlwuWktEMrN2Q1uAzEzN4h0qKJW
X-Gm-Message-State: AOJu0YwFDNmKwm2IQGNmozjkSlXk7ZVsDs1+EQtkgoyLp0gwtugNGlJD
	jINehdfF/9X7H/Ia3qePwbq8G3idMmTIQfLBS96QL+m67b4qrRsO5Sg0sFj0RcY=
X-Google-Smtp-Source: AGHT+IGI7ZtC5yMFeVhgobcpC4ELjQ0rXq8graZvm2aNnJqlgdJJt9Tf50Z+1bVL5t64KhWiB1DChw==
X-Received: by 2002:a17:902:cf04:b0:1f6:f5bc:51c5 with SMTP id d9443c01a7336-1f6f5bc5391mr72332595ad.47.1718041886043;
        Mon, 10 Jun 2024 10:51:26 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:129d:83bc:830b:8292])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f70eeaedf7sm27441255ad.84.2024.06.10.10.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 10:51:25 -0700 (PDT)
Date: Mon, 10 Jun 2024 10:51:23 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Jessica Clarke <jrtc27@jrtc27.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	linux-riscv <linux-riscv@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 03/13] riscv: dts: allwinner: Add xtheadvector to the
 D1/D1s devicetree
Message-ID: <Zmc9G2syeLF2rBZM@ghost>
References: <20240609-xtheadvector-v1-0-3fe591d7f109@rivosinc.com>
 <20240609-xtheadvector-v1-3-3fe591d7f109@rivosinc.com>
 <FD6771F5-5739-469A-9C0B-952AAC62AB68@jrtc27.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FD6771F5-5739-469A-9C0B-952AAC62AB68@jrtc27.com>

On Mon, Jun 10, 2024 at 06:49:30PM +0100, Jessica Clarke wrote:
> On 10 Jun 2024, at 05:45, Charlie Jenkins <charlie@rivosinc.com> wrote:
> > 
> > The D1/D1s SoCs support xtheadvector so it can be included in the
> > devicetree. Also include vlenb for the cpu.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> > arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> > index 64c3c2e6cbe0..50c9f4ec8a7f 100644
> > --- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> > +++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> > @@ -27,7 +27,8 @@ cpu0: cpu@0 {
> > riscv,isa = "rv64imafdc";
> > riscv,isa-base = "rv64i";
> > riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
> > -       "zifencei", "zihpm";
> > +       "zifencei", "zihpm", "xtheadvector";
> > + riscv,vlenb = <128>;
> 
> thread,vlenb

Oh right, thank you!

- Charlie

> 
> Jess
> 
> > #cooling-cells = <2>;
> > 
> > cpu0_intc: interrupt-controller {
> > 
> > -- 
> > 2.44.0
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

