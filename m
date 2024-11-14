Return-Path: <linux-kselftest+bounces-21998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 868659C8147
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 04:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 459ED283328
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 03:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B7D1E6DDE;
	Thu, 14 Nov 2024 03:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="0gNyjYm7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A061E47A5
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 03:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731553353; cv=none; b=I/lRETM9+/d/dpnBVzn/lFa0xCW1d6Y8dRQzNcxqAdaAWM2ycX8EXFSvreJ4e+Ds3vEztdPDs/2K2EiYHwjqN+hfjrq5Tmx6KJM9MUjex9n+TDwsJuZoBAhXgPu5El3UyLcKbFOd/IJ5JSp1WuchXGOV44afxirGLanOJsxe420=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731553353; c=relaxed/simple;
	bh=eC/Je7lf4cTIs+XfRclfsG7Gw/l6OPSkqZyilcBiabw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6issysgrTxeX/k+Ac+1436o5NbYSLCQ2E47WwWNu/6HjAGmIt+3/OzsCgzYuNDFUoBaha4SRfUFZDUROrLbM8JJ5Q1NhzKbjEytzd76gt8raybMh/IvZPPivTz4fFeNl3HNy7hvsQ9hQukaQ+wQGV4e3U/W09mHPnYfe8xfdFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=0gNyjYm7; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20ce65c8e13so1046605ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Nov 2024 19:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731553350; x=1732158150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V3slBWyvgUqyrNTtRBU44b5VuzePQ2w/b3OOC87VCWo=;
        b=0gNyjYm7ze8YVCSeiSmsx2TUiwt+Ci2kpBNn9I460Sk1UbN3K95uDXp//R7/1FEJgX
         ALCpP2c/rtUnucAqJkzn3QzDpEOqvvqEfv0eVmq85zgS/JGSS5kUNeVs1p2GCR3DDjlz
         FjeojBkB+2hrWvSUzL1MJrsnFf28Y9yvSOrvyLKySZe+7zpDEaNgfiZVBOKuEcs+H0ME
         v8On3Gl9MHWWLHKyZkBKSOrl9X21zj70KCkx8iBOLSFFVLKNEuGY5dKMwTyfDQ0Wqcsc
         JV84y+Dev3BQkyYHOaHGTG3D16G9apEjGUInjAS1PhgdnaMrzGi/bH6wpUxfaA/2lZCV
         i2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731553350; x=1732158150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3slBWyvgUqyrNTtRBU44b5VuzePQ2w/b3OOC87VCWo=;
        b=N09LAdDB5z+5/IjGrzQjqRFqesDvzXHC70UHGgzjtP9eLYQbjdRusJhTtq1rG5L4Qj
         yVJu7ExpCgV01lpfcQ8j4mEuwdAdI9IkGclqbRSFtRS0T72MAnR4JiDfvmZDIMlHE8RS
         7038jLUl9Ig2he/tmuvCEgVnPh34yhIYpLTpEIaWGZPGedunyzk10lddaMkr6wcMM6uh
         q5hvU/6EnkPMp/n2hDoC6R8XXjAsKb96uUekm4g3RLUz2+8cfcWCQKzZy1J27rvS5Xnm
         1OJpXg6lsuzSfmFBYglyAjqKaqdZ14ONnGZAouDJRDjDciRw76C1LExHaBZTSYfbLBDg
         cvaA==
X-Forwarded-Encrypted: i=1; AJvYcCVxnMWjIqm9rw7fu7z3gO+eHvkKN6S3RP5yJy1zFsD5HGijv/DAUvirXAR4wgiCMaW4IT2E+1kNQP6Onshdz3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPLtKqJTKXUTJTRQaiY3TaXHwbWAMbxrYIbis4bBnoyBkNOCto
	Pqm+U5X8JQO3vsDrI695u8Tfxq/HQQvVuUGUBv6Sj3YJG2rOm+7MZ9PdOyqF4bo=
X-Google-Smtp-Source: AGHT+IGfSosQZpd7ro/3P8ybXqRalEFqAIaugehdNVkBtjrErQ0ikNqH6xSPtSFBIgViM11iMSZkOg==
X-Received: by 2002:a17:903:2351:b0:20c:da66:387b with SMTP id d9443c01a7336-211b661df27mr59390095ad.20.1731553350082;
        Wed, 13 Nov 2024 19:02:30 -0800 (PST)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d06940sm706985ad.199.2024.11.13.19.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 19:02:29 -0800 (PST)
Date: Wed, 13 Nov 2024 19:02:26 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Yangyu Chen <cyy@cyyself.name>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Chiu <andybnac@gmail.com>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v11 10/14] riscv: hwprobe: Add thead vendor extension
 probing
Message-ID: <ZzVoQi6D0U30p9sg@ghost>
References: <20241113-xtheadvector-v11-0-236c22791ef9@rivosinc.com>
 <20241113-xtheadvector-v11-10-236c22791ef9@rivosinc.com>
 <tencent_5B500856E30E1FB920B6B68D6315EE70CC06@qq.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_5B500856E30E1FB920B6B68D6315EE70CC06@qq.com>

On Thu, Nov 14, 2024 at 10:44:37AM +0800, Yangyu Chen wrote:
> 
> 
> On 11/14/24 10:21, Charlie Jenkins wrote:
> > Add a new hwprobe key "RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0" which
> > allows userspace to probe for the new RISCV_ISA_VENDOR_EXT_XTHEADVECTOR
> > vendor extension.
> > 
> 
> Hi Charlie,
> 
> How about changing the name of the key from
> "RISCV_ISA_VENDOR_EXT_XTHEADVECTOR" to "RISCV_HWPROBE_KEY_VENDOR_EXT_0" and
> use marchid to identify what the vendor is, each vendor will have its own
> bit definition in this value. So we can avoid adding so many hwprobe keys
> for each vendor in the future.
> 
> I proposed a commit here: https://github.com/cyyself/linux/commit/36390645d85d1ac75dd71172f167719df4297f59

I actually originally had this in one of my first versions of this
series but was convinced by Conor to change it. The problem with it was
that tying vendor extensions to mvendorid means that it is enforced by
the kernel that vendors cannot share vendor extensions. It is possible
for vendor A to purchase IP that contains a vendor extension from vendor
B. This vendor extension should work on platforms created by vendor A
and vendor B. However, vendor A and vendor B have different mvendorids,
so the kernel can't support this if it is tied to mvendorid.  It could
be solved by duplicating every extension that vendors have, but then
userspace software would have to keep in mind the mvendorid they are
running on and check the different extensions for the different vendors
even though the implementation of the extension is the same.

The original conversation where Conor and I agreed that it was better to
have vendor extensions not rely on mvendorid:

https://lore.kernel.org/linux-riscv/20240416-husband-flavored-96c1dad58b6e@wendy/

> 
> > This new key will allow userspace code to probe for which thead vendor
> > extensions are supported. This API is modeled to be consistent with
> > RISCV_HWPROBE_KEY_IMA_EXT_0. The bitmask returned will have each bit
> > corresponding to a supported thead vendor extension of the cpumask set.
> > Just like RISCV_HWPROBE_KEY_IMA_EXT_0, this allows a userspace program
> > to determine all of the supported thead vendor extensions in one call.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > Reviewed-by: Evan Green <evan@rivosinc.com>
> > ---
> >   arch/riscv/include/asm/hwprobe.h                   |  3 +-
> >   .../include/asm/vendor_extensions/thead_hwprobe.h  | 19 +++++++++++
> >   .../include/asm/vendor_extensions/vendor_hwprobe.h | 37 ++++++++++++++++++++++
> >   arch/riscv/include/uapi/asm/hwprobe.h              |  3 +-
> >   arch/riscv/include/uapi/asm/vendor/thead.h         |  3 ++
> >   arch/riscv/kernel/sys_hwprobe.c                    |  5 +++
> >   arch/riscv/kernel/vendor_extensions/Makefile       |  1 +
> >   .../riscv/kernel/vendor_extensions/thead_hwprobe.c | 19 +++++++++++
> >   8 files changed, 88 insertions(+), 2 deletions(-)
> > 
> 

