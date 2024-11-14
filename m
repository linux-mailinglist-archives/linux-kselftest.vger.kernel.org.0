Return-Path: <linux-kselftest+bounces-22002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F3D9C8215
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 05:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33102284C9D
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 04:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0646C1E7C34;
	Thu, 14 Nov 2024 04:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JuY82Ulg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDDE198E96
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 04:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731559580; cv=none; b=D2SRvnEzrcag/YwB37upBQ7R143IAGe3Xe0jN3LZQZndPFoUUe+OCCGCCzzsvVyP7uvkHzVal/SXqETg2uh7FEoU4ZCd/7oBP57x1OsxqtECvjR6hQseCVnvEcrUPvXA/cCLhEauQEp4465I+P2BWfo+F4wM5NBsfs3D6OiffxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731559580; c=relaxed/simple;
	bh=Ls63W1NkqHjf52ZrqyGJlw3Lda8aWU1ZVvnWQTTJ3tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVcI/xd8aUlzLN7uSCg1kNt8MCJWDYYAi95I11OJF/4rXdW6CoSYXAHg7aiPZiABoTjxqD5HZv4c8jo/jDMcoeiOdqR1HQ/IaePGFkJs/+hrcNaAAHymjcidAj8lAPhaCNBeguP/O/cwMjPgxy9qMqB60FWvYSPIBmPxpi6B1eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=JuY82Ulg; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2ad9825a7so187026a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Nov 2024 20:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731559577; x=1732164377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ciPpdd8xZxgVXtxncNlZsl62adjxx/9Ixp3cayb9PO8=;
        b=JuY82Ulg/Nw0fTFdudRW9ha863Sbrz/exH9eyccdCEWmuUWMsG4a1vHIdA38SJV7Lv
         FG2ZVg5Od18dsWHz54cDhGstFwMBS4p0tk1DQ/jKBJQdh4ZJoTu+0oiaWh2Zos+LOF/p
         SweFDeTV6JQNQMbJr3oVPaeH5ncKwqvpNqecl5+SaoynDbXyc/Ire5daaYNJUCzIQjPg
         rzMoUnt4FmEQ6FfNBSdnam4JGLN7O97j1RO9JXMfEzFVhpGwcR/K84qP8Faq/ZZ5KW9B
         NlgrR0lkyHhMRYhfsE18nTHZ/mK1HpblbYIOFMaZW8nG3cgRqb/W03sgLpwMOhhHztDQ
         eNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731559577; x=1732164377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciPpdd8xZxgVXtxncNlZsl62adjxx/9Ixp3cayb9PO8=;
        b=w/Uuc8jH55cknfZxwsJ0k5AkY+/SGPRvDnD4Ms6PMQwq7GmIfNkxIsI2gqFRSKkp7G
         2GoL11oCSVI6uLuYPNQ3fR362l3SJBdmEK9ET/TDkWFVP4XYzUsgBFtauErlTwqkIGLJ
         +zUMFxa2uyAsSxs5QvCDLS9Sb/krUY0zCBF6PbXUyypWLK1OV98TCMvivvKVqeKCyd1B
         h3SXGUXpZO0PnRIF/11s34KSd01wybGpXm6HfljI+cgpGjELVG4OhUPLyu4WY+ibzbb/
         XqvjI7N4znEyRLO2+g44rS8JZjNJy361W5xluRd/m4S1N+NJHucG6JTbpu/jgZ03OBwh
         yFwg==
X-Forwarded-Encrypted: i=1; AJvYcCWnFSdod2cVB9n1gz7P344bsJBy6Crqy92lbokMXpVE6PLgP0p8P6ndrxHbRWIrAuRvKfzdSbyQf1och3Q5Tw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzarGVooMDFUziKmEdMyenEqpO3gnEROFxQjy9aBeTqZcs0oUad
	PXrOiW6aE3ngWY4/kPSNnC1ecdhR7ZFqvd5OvPkKllrZaRvJnPT/C2wh5jHuzYo=
X-Google-Smtp-Source: AGHT+IHwmfiSpNRYwoKTDlPVlAYVWz1iKVKE6iuP2huEnhh9oY77ssSAXAPaqGmYjbMQgR+sM8uIAQ==
X-Received: by 2002:a17:90b:37cf:b0:2e5:8392:afe7 with SMTP id 98e67ed59e1d1-2e9b14dc341mr30805661a91.0.1731559576254;
        Wed, 13 Nov 2024 20:46:16 -0800 (PST)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea06f1b17asm264488a91.15.2024.11.13.20.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 20:46:15 -0800 (PST)
Date: Wed, 13 Nov 2024 20:46:12 -0800
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
Message-ID: <ZzWAlJm1ShgsZr4m@ghost>
References: <20241113-xtheadvector-v11-0-236c22791ef9@rivosinc.com>
 <20241113-xtheadvector-v11-10-236c22791ef9@rivosinc.com>
 <tencent_5B500856E30E1FB920B6B68D6315EE70CC06@qq.com>
 <ZzVoQi6D0U30p9sg@ghost>
 <tencent_6A95637042401AD5F8BE05C7B4F11CAD7009@qq.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_6A95637042401AD5F8BE05C7B4F11CAD7009@qq.com>

On Thu, Nov 14, 2024 at 11:26:47AM +0800, Yangyu Chen wrote:
> 
> 
> On 11/14/24 11:02, Charlie Jenkins wrote:
> > On Thu, Nov 14, 2024 at 10:44:37AM +0800, Yangyu Chen wrote:
> > > 
> > > 
> > > On 11/14/24 10:21, Charlie Jenkins wrote:
> > > > Add a new hwprobe key "RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0" which
> > > > allows userspace to probe for the new RISCV_ISA_VENDOR_EXT_XTHEADVECTOR
> > > > vendor extension.
> > > > 
> > > 
> > > Hi Charlie,
> > > 
> > > How about changing the name of the key from
> > > "RISCV_ISA_VENDOR_EXT_XTHEADVECTOR" to "RISCV_HWPROBE_KEY_VENDOR_EXT_0" and
> > > use marchid to identify what the vendor is, each vendor will have its own
> > > bit definition in this value. So we can avoid adding so many hwprobe keys
> > > for each vendor in the future.
> > > 
> > > I proposed a commit here: https://github.com/cyyself/linux/commit/36390645d85d1ac75dd71172f167719df4297f59
> > 
> > I actually originally had this in one of my first versions of this
> > series but was convinced by Conor to change it. The problem with it was
> > that tying vendor extensions to mvendorid means that it is enforced by
> > the kernel that vendors cannot share vendor extensions. It is possible
> > for vendor A to purchase IP that contains a vendor extension from vendor
> > B. This vendor extension should work on platforms created by vendor A
> > and vendor B. However, vendor A and vendor B have different mvendorids,
> > so the kernel can't support this if it is tied to mvendorid.  It could
> > be solved by duplicating every extension that vendors have, but then
> > userspace software would have to keep in mind the mvendorid they are
> > running on and check the different extensions for the different vendors
> > even though the implementation of the extension is the same.
> > 
> > The original conversation where Conor and I agreed that it was better to
> > have vendor extensions not rely on mvendorid:
> > 
> > https://lore.kernel.org/linux-riscv/20240416-husband-flavored-96c1dad58b6e@wendy/
> > 
> 
> Thanks for your explanation. I will strongly agree with Conor's opinion if
> the feature bitmask does not exist in RISC-V C-ABI.
> 
> However, as the feature mask defined in RISC-V C-ABI[1] uses the design
> depending on marchid currently, should we reconsider this key for its use
> case? The current target_clones and taget_version implemented in GCC[2] and
> LLVM[3] also use the bitmask defined in C-ABI. I think if we use this key
> depending on marchid, to make a key shared with all vendors will make this
> cleaner.

Changing this will break linux userspace API. It is a non-workable
solution for the kernel to associate extensions with marchid/mvendorid
for the reasons provided. I fail to see why this ABI would require the
kernel to behave in this manner. The ABI provides the marchid to be used
by function multi-versioning and applications are free to use the
marchid to change which function they want to compile. However, if they
want to know if an extension is supported, then they need to use
hwprobe. If they want to check if xtheadvector is supported, then they
call hwprobe with the xtheadvector key. This is true no matter what the
mvendorid of the system is. This does not add any complexity, "clean"
code can equally be written following this scheme or following a scheme
that relies on mvendorid. Ditching the reliance on mvendorid in the
kernel allows the kernel to be as generic as possible, and allow
whatever ABIs or hardware that exist to have a resiliant way of
communicating with the kernel.

- CHarlie

> 
> [1] https://github.com/riscv-non-isa/riscv-c-api-doc/blob/main/src/c-api.adoc#function-multi-version
> [2] https://github.com/gcc-mirror/gcc/blob/8564d0948c72df0a66d7eb47e15c6ab43e9b25ce/gcc/config/riscv/riscv.cc#L13016
> [3] https://github.com/llvm/llvm-project/blob/f407dff50cdcbcfee9dd92397d3792627c3ac708/clang/lib/CodeGen/CGBuiltin.cpp#L14627
> 
> > > 
> > > > This new key will allow userspace code to probe for which thead vendor
> > > > extensions are supported. This API is modeled to be consistent with
> > > > RISCV_HWPROBE_KEY_IMA_EXT_0. The bitmask returned will have each bit
> > > > corresponding to a supported thead vendor extension of the cpumask set.
> > > > Just like RISCV_HWPROBE_KEY_IMA_EXT_0, this allows a userspace program
> > > > to determine all of the supported thead vendor extensions in one call.
> > > > 
> > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > Reviewed-by: Evan Green <evan@rivosinc.com>
> > > > ---
> > > >    arch/riscv/include/asm/hwprobe.h                   |  3 +-
> > > >    .../include/asm/vendor_extensions/thead_hwprobe.h  | 19 +++++++++++
> > > >    .../include/asm/vendor_extensions/vendor_hwprobe.h | 37 ++++++++++++++++++++++
> > > >    arch/riscv/include/uapi/asm/hwprobe.h              |  3 +-
> > > >    arch/riscv/include/uapi/asm/vendor/thead.h         |  3 ++
> > > >    arch/riscv/kernel/sys_hwprobe.c                    |  5 +++
> > > >    arch/riscv/kernel/vendor_extensions/Makefile       |  1 +
> > > >    .../riscv/kernel/vendor_extensions/thead_hwprobe.c | 19 +++++++++++
> > > >    8 files changed, 88 insertions(+), 2 deletions(-)
> > > > 
> > > 
> 
> 

