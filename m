Return-Path: <linux-kselftest+bounces-7854-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C2E8A3591
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 20:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0150D1C232DF
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 18:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAAF14F103;
	Fri, 12 Apr 2024 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="WXFbh+rj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046BF14EC76
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712946283; cv=none; b=CTxnKK8wOtyGHD3sfGshXKoAfNOTgIquYUEMSxvGoOh218bDSamPNLku7ZS/XLMrnHkD015rG76ipselWtPlxDpy7LoS8CYV5oc2f0AMb94ejcppkca3xLLKg4NOWHUhjRoi7nTYvKDOOa41hdHOxBK3gweJOsl/nDTUURp72XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712946283; c=relaxed/simple;
	bh=nY7gbkgkBr+eHZR919YowyRoq31FRxlbVFMFZulxFuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pa4X57dogVHVhcAUXk/Cb4yHRRcCBb7W76y+AOVWDVL9vJGStw8c8c8qtuMAIuCgRrCf5WfpHz+XKfhx2Cc1buH4qvU15gijr1SOoXR3GGV5oadv96U0ei+ZxkLOoZTikZ+c2OPl0rSgYXrwGMPOTNjHE5HpAbw4v8QP8OQjs6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=WXFbh+rj; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ed267f2936so1005432b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 11:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712946280; x=1713551080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VnBuVioN4do9yO5Fp+To5ya+VzBTYCmZkVY34L3QmB0=;
        b=WXFbh+rjZbX/JtdaihjFORYvRF0dx+G+Pqx+XqL7cIhCKY7vsfto1e20iGv8dUdM6P
         xdPJKDUGkY9C2z5/vxT6x7z6z0xWPA6+k8xclCvd5k+xsgTNz2PbGEmHFb8htMzACxaN
         BPwtNHSt4yj/Hg89E+hvoLXqh9b4UhKqOLvqIgEpb/4xHJaz1dOYmpUQZ0bn5TBv4dZP
         EHMCsceq+rt/Kf4v9jGoWstqMXLCpSaHLwZqdjiQjjcAlHq9GnRnv74coySAH8rMeIjr
         Amg2eb3YMSrlbj5Jo8xouUcd3oMt/TRkvUCCNupcT6VQDiDti0gQMYVd1co83qwD8AvY
         vmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712946280; x=1713551080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnBuVioN4do9yO5Fp+To5ya+VzBTYCmZkVY34L3QmB0=;
        b=l0hT5t5rrCpM5ekqJ75WtMLS3s2DbbnZxvt6L8xqCppXmYmKVJbWUs2ab9C13Fiiiz
         Znx8lZi88Ir7V3M2t3ZcUSR2LSk04StA4iPqioD9BIznkmbH2p1kW15MuYa4h6/nx62p
         7QpgED0whJ2RSUXgNa961k/wZBeyk4an0HsEz+3fpwGzDIZHJQK+ZK8fYxCUgoFjyOnv
         43oybl+cpywdLlmk3vOq8o1IcbkJ6V31I5DdOTIlr4cfUxkVyPls2xdVQBBdiEEWlVRo
         l2VYVqamp8k1LdEpOHOLYsr+RgeHD7ANA3SSAfE7LAdw4s+F3dnFhE/tCGgBlaYUZl18
         4iJw==
X-Forwarded-Encrypted: i=1; AJvYcCWk/h8T8jYHniWrSgsnzkLtN/RNDmf+ziQa+Iu78mRzFBD9YR+Fx/sfTPPoq6LgmYu+1IPpaDt9YNtbZu6tZP5XF5AtPFNyK3k/u2JiFvQE
X-Gm-Message-State: AOJu0YzxA6FowLegzuY7PDdvnhQOsyKdbpvFTKFvXOKH/e5xXNupq4eO
	PbsvSkCl3kD5DIJnzGEsc5DIKJOqCXVEFXMLqd7Fix1XHwRPKp+hxQevzZ8qsFs=
X-Google-Smtp-Source: AGHT+IGBSZ+NKU4CickCNnsQ+/kbxESLkfaeQqukqebjAC4cnyf8qidufBP0hWj5qMBvb+MfDt1C/A==
X-Received: by 2002:a05:6a00:3913:b0:6ea:8e89:7faf with SMTP id fh19-20020a056a00391300b006ea8e897fafmr4224014pfb.28.1712946280297;
        Fri, 12 Apr 2024 11:24:40 -0700 (PDT)
Received: from ghost (mobile-166-137-160-039.mycingular.net. [166.137.160.39])
        by smtp.gmail.com with ESMTPSA id q4-20020a656244000000b005dc4fc80b21sm2633420pgv.70.2024.04.12.11.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 11:24:39 -0700 (PDT)
Date: Fri, 12 Apr 2024 11:24:35 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 12/19] riscv: Create xtheadvector file
Message-ID: <Zhl8Y+GzTB/ip7rT@ghost>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-12-4af9815ec746@rivosinc.com>
 <20240412-thirty-sacrament-db052c7fe6fe@wendy>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412-thirty-sacrament-db052c7fe6fe@wendy>

On Fri, Apr 12, 2024 at 12:30:32PM +0100, Conor Dooley wrote:
> On Thu, Apr 11, 2024 at 09:11:18PM -0700, Charlie Jenkins wrote:
> > These definitions didn't fit anywhere nicely, so create a new file to
> > house various xtheadvector instruction encodings.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/xtheadvector.h | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/arch/riscv/include/asm/xtheadvector.h b/arch/riscv/include/asm/xtheadvector.h
> > new file mode 100644
> > index 000000000000..348263ea164c
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/xtheadvector.h
> > @@ -0,0 +1,25 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +/*
> > + * Vector 0.7.1 as used for example on T-Head Xuantie cores, uses an older
> > + * encoding for vsetvli (ta, ma vs. d1), so provide an instruction for
> > + * vsetvli	t4, x0, e8, m8, d1
> > + */
> > +#define THEAD_VSETVLI_T4X0E8M8D1	".long	0x00307ed7\n\t"
> > +#define THEAD_VSETVLI_X0X0E8M8D1	".long	0x00307057\n\t"
> > +
> > +/*
> > + * While in theory, the vector-0.7.1 vsb.v and vlb.v result in the same
> > + * encoding as the standard vse8.v and vle8.v, compilers seem to optimize
> > + * the call resulting in a different encoding and then using a value for
> > + * the "mop" field that is not part of vector-0.7.1
> > + * So encode specific variants for vstate_save and _restore.
> 
> This wording seems oddly familiar to me, did Heiko not write this?

Yeah, I wasn't sure how to attribute him. He wrote almost all of the
lines in this file, but I put it together into this file. What is the
standard way of doing that?

- Charlie

> 
> > + */
> > +#define THEAD_VSB_V_V0T0		".long	0x02028027\n\t"
> > +#define THEAD_VSB_V_V8T0		".long	0x02028427\n\t"
> > +#define THEAD_VSB_V_V16T0		".long	0x02028827\n\t"
> > +#define THEAD_VSB_V_V24T0		".long	0x02028c27\n\t"
> > +#define THEAD_VLB_V_V0T0		".long	0x012028007\n\t"
> > +#define THEAD_VLB_V_V8T0		".long	0x012028407\n\t"
> > +#define THEAD_VLB_V_V16T0		".long	0x012028807\n\t"
> > +#define THEAD_VLB_V_V24T0		".long	0x012028c07\n\t"
> > 
> > -- 
> > 2.44.0
> > 



