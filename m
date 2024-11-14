Return-Path: <linux-kselftest+bounces-22006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E8D9C83E8
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 08:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E43A7B228CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 07:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15401EBA17;
	Thu, 14 Nov 2024 07:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TF643W9Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FF61E9074
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 07:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731569011; cv=none; b=fUoLxDror2LS9lTJVLo4U/3Tot4PNwYOQSYUTFUSl75ro1srHffdj0g3OeQPzEXXwAjvYWkVL7ikiRRz6wgw+v1mmZlxdL8qZz+Rr7wwmfEyhPcJt1T9zuHVBS+W88E4ANqt/k/3eFuur0hmSMaavM3N42QfHz/0ws7QelSQreQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731569011; c=relaxed/simple;
	bh=FznkquujoVc4AGXvNQNSehVr0GYW7+fmlomCQC7lcDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKnvR55bMzqbW72SbYPTmCL3UnTEfBRtWnoa/0Tls7NyxQ2oQuWDXvJAX/vnF9zmBOabRS/A6ZZp4sBz1MaefCl1lZ7HXFo/fF9F72tbyBJRqfcwffSaanJSlnwhDsex+CHY9v0jnSJcpBi66i+O1GlVx7kU2ATZRXTfN5kJJwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=TF643W9Q; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20caea61132so1912265ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Nov 2024 23:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731569008; x=1732173808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jcVdx/PDcosiuJvg6s7470mt1Sbg0MJ8nbwkpgIFfDI=;
        b=TF643W9QHlE7qhqr5uRfTcxpUsp30RKA4BqyyBwDQVbgmabZpfzeeIRi3R+pMeqyT+
         Z8046g9nfbrjxVzKZ9lGqFlIBah5D9N1xKRN9ZYEIzn/s9HjW1wymT3N3X4wsSdPuQzq
         bZN8r0CwlC7hwnc4pD1AqtPz4Hi1yBl7BuQhLNsEDZqFSnQIWAlG/CF9DjV/20i4ebD6
         Yl30lNpxEHVjE1dIYCbTg0MlIBxeSDsZBM6nxIexYp5FBEkCJmKWh9Dhe/EKSe7aYxnu
         g2uCAbprZdhnLez0WrXtlFamw5dGWnA0FDC53mqAbGGAx7grJ/1VN9kis9yc1t50wvGm
         8kIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731569008; x=1732173808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcVdx/PDcosiuJvg6s7470mt1Sbg0MJ8nbwkpgIFfDI=;
        b=oSmYLtVqIVn9oQM+DJw2rAFcdpznJOL16CNDk2yHQ+P1OebGGs4wNKL1Oh27czK6tg
         FU6fLvynfWOYe2WuHOtE+Ap+qLcI/FuvCdIuPCEostmcIEWEewzQDANqPiFgDjI/6Mxc
         eyCdFNCoi2W/GtrlHQGbxH4OpQo1A9HWz9A/YGFJUqzDm+E5TnfjtaD167BVzZm6tjEl
         lfnWfw0QtTGpTA52fMlh/UDvXlbeNw/LArtzf4Gg/MoIJ0r6RNWsTPYGN7KkGTCy6wtP
         Rm56+kTbR6ykWn4ecFlPUacTnmc6PjuwxxwMn7pFr9JE12FBv5trl5MvXkkMeuLygwNP
         9aig==
X-Forwarded-Encrypted: i=1; AJvYcCWl5BKomBHD4WQYZe180jL7Z5q+x3sRhMcfO9anHbWa5e9+eMo09S7KRHyXwR+NpbLcrn2Cfo4itKFDcdq5A7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw+Zo0C5TTvAtgtH4YqUxMwwUH66wmi/OceXsaFFExeCylXfhG
	QpgCIVAydMRZLh0AT757BFgIQycsiJAv8kP9g90QWWecG5CFnmii/SGpVizoo6w=
X-Google-Smtp-Source: AGHT+IEqIiAMaMvRr6traVqlETDXrksYLlEnbTBwgNuybxklLmBA23F6Bg0v7Zkwsdh3ki0S14Ja2g==
X-Received: by 2002:a17:902:d4d2:b0:20b:5aff:dd50 with SMTP id d9443c01a7336-211c4ffd29emr15882815ad.31.1731569008105;
        Wed, 13 Nov 2024 23:23:28 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:4ece:7c14:cc18:73af])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7c290b1sm4623065ad.10.2024.11.13.23.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 23:23:27 -0800 (PST)
Date: Wed, 13 Nov 2024 23:23:24 -0800
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
Message-ID: <ZzWlbCiRuDKzilms@ghost>
References: <20241113-xtheadvector-v11-0-236c22791ef9@rivosinc.com>
 <20241113-xtheadvector-v11-10-236c22791ef9@rivosinc.com>
 <tencent_5B500856E30E1FB920B6B68D6315EE70CC06@qq.com>
 <ZzVoQi6D0U30p9sg@ghost>
 <tencent_6A95637042401AD5F8BE05C7B4F11CAD7009@qq.com>
 <ZzWAlJm1ShgsZr4m@ghost>
 <tencent_9BB243901B8FF9FC0457B51D1CFF714B6209@qq.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_9BB243901B8FF9FC0457B51D1CFF714B6209@qq.com>

On Thu, Nov 14, 2024 at 02:54:17PM +0800, Yangyu Chen wrote:
> 
> 
> On 11/14/24 12:46, Charlie Jenkins wrote:
> > On Thu, Nov 14, 2024 at 11:26:47AM +0800, Yangyu Chen wrote:
> > > 
> > > 
> > > On 11/14/24 11:02, Charlie Jenkins wrote:
> > > > On Thu, Nov 14, 2024 at 10:44:37AM +0800, Yangyu Chen wrote:
> > > > > 
> > > > > 
> > > > > On 11/14/24 10:21, Charlie Jenkins wrote:
> > > > > > Add a new hwprobe key "RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0" which
> > > > > > allows userspace to probe for the new RISCV_ISA_VENDOR_EXT_XTHEADVECTOR
> > > > > > vendor extension.
> > > > > > 
> > > > > 
> > > > > Hi Charlie,
> > > > > 
> > > > > How about changing the name of the key from
> > > > > "RISCV_ISA_VENDOR_EXT_XTHEADVECTOR" to "RISCV_HWPROBE_KEY_VENDOR_EXT_0" and
> > > > > use marchid to identify what the vendor is, each vendor will have its own
> > > > > bit definition in this value. So we can avoid adding so many hwprobe keys
> > > > > for each vendor in the future.
> > > > > 
> > > > > I proposed a commit here: https://github.com/cyyself/linux/commit/36390645d85d1ac75dd71172f167719df4297f59
> > > > 
> > > > I actually originally had this in one of my first versions of this
> > > > series but was convinced by Conor to change it. The problem with it was
> > > > that tying vendor extensions to mvendorid means that it is enforced by
> > > > the kernel that vendors cannot share vendor extensions. It is possible
> > > > for vendor A to purchase IP that contains a vendor extension from vendor
> > > > B. This vendor extension should work on platforms created by vendor A
> > > > and vendor B. However, vendor A and vendor B have different mvendorids,
> > > > so the kernel can't support this if it is tied to mvendorid.  It could
> > > > be solved by duplicating every extension that vendors have, but then
> > > > userspace software would have to keep in mind the mvendorid they are
> > > > running on and check the different extensions for the different vendors
> > > > even though the implementation of the extension is the same.
> > > > 
> > > > The original conversation where Conor and I agreed that it was better to
> > > > have vendor extensions not rely on mvendorid:
> > > > 
> > > > https://lore.kernel.org/linux-riscv/20240416-husband-flavored-96c1dad58b6e@wendy/
> > > > 
> > > 
> > > Thanks for your explanation. I will strongly agree with Conor's opinion if
> > > the feature bitmask does not exist in RISC-V C-ABI.
> > > 
> > > However, as the feature mask defined in RISC-V C-ABI[1] uses the design
> > > depending on marchid currently, should we reconsider this key for its use
> > > case? The current target_clones and taget_version implemented in GCC[2] and
> > > LLVM[3] also use the bitmask defined in C-ABI. I think if we use this key
> > > depending on marchid, to make a key shared with all vendors will make this
> > > cleaner.
> > 
> > Changing this will break linux userspace API. It is a non-workable
> > solution for the kernel to associate extensions with marchid/mvendorid
> > for the reasons provided. I fail to see why this ABI would require the
> > kernel to behave in this manner. The ABI provides the marchid to be used
> > by function multi-versioning and applications are free to use the
> > marchid to change which function they want to compile. However, if they
> > want to know if an extension is supported, then they need to use
> > hwprobe. If they want to check if xtheadvector is supported, then they> call hwprobe with the xtheadvector key. This is true no matter what the
> > mvendorid of the system is.
> 
> A userspace software can use either c-api defined feature masks or directly
> use hwprobe syscall. If they use c-api defined feature masks as GCC or LLVM
> did for compiler generated IFUNC resolver, the bitmask is guarded by
> mvendorid. So my point at that time was that if the C-API defined way became
> mainstream, why should we keep this key only for T-Head to increase the
> maintenance overhead?

Yes that makes sense. I was thinking that the Andes PMU extension had a
hwprobe key, but I realized that it does not. This patch has been on the
lists for so long I lost track! I was trying to design this to be
forward-thinking, I believe that it makes more sense this way, but I am
interested in the opinion of the c-api maintainers.

> 
> This has been discussed here before in RISC-V C-API: https://github.com/riscv-non-isa/riscv-c-api-doc/pull/74#issuecomment-2128844747
> 
> But now (from the last email), you convinced me. So, I would like to make
> the c-api change: https://github.com/riscv-non-isa/riscv-c-api-doc/issues/96
> 

Thank you for opening that!

> > This does not add any complexity, "clean"
> > code can equally be written following this scheme or following a scheme
> > that relies on mvendorid. Ditching the reliance on mvendorid in the
> > kernel allows the kernel to be as generic as possible, and allow
> > whatever ABIs or hardware that exist to have a resiliant way of
> > communicating with the kernel.
> > 
> 
> OK. I'm just concerned about when these vendors will add the hwprobe key for
> their own extension, which may introduce a potential merge conflict in the
> kernel tree. It can also be a disaster if the hardware vendor ships their
> kernel with these under-review patches for their products with hwprobe key
> conflict with mainline kernel.
> 
> But we can avoid this now by adding each key for each vendor to avoid
> potential conflict in the future. This can be a separate patch for future
> work, so there is nothing to change here.

Yes that is unfortunately the downside of hwprobe that it is a
centralized source of these keys, and that can be exacerbated by this
scheme were vendor keys are not completely isolated from each other.
That would be very unfortunate if a vendor ships a kernel and binaries
that has different keys than the mainline kernel. Hopefully vendors
don't do that, but it should be manageable for vendors to submit their own
keys.

Thank you for bringing this up, it is an important issue! A main goal of
this series was to get vendor extensions in a state that would be able
to grow into a future when there are lots of vendors.

> 
> Thanks,
> Yangyu Chen
> 
> > - CHarlie
> > 
> > > 
> > > [1] https://github.com/riscv-non-isa/riscv-c-api-doc/blob/main/src/c-api.adoc#function-multi-version
> > > [2] https://github.com/gcc-mirror/gcc/blob/8564d0948c72df0a66d7eb47e15c6ab43e9b25ce/gcc/config/riscv/riscv.cc#L13016
> > > [3] https://github.com/llvm/llvm-project/blob/f407dff50cdcbcfee9dd92397d3792627c3ac708/clang/lib/CodeGen/CGBuiltin.cpp#L14627
> > > 
> > > > > 
> > > > > > This new key will allow userspace code to probe for which thead vendor
> > > > > > extensions are supported. This API is modeled to be consistent with
> > > > > > RISCV_HWPROBE_KEY_IMA_EXT_0. The bitmask returned will have each bit
> > > > > > corresponding to a supported thead vendor extension of the cpumask set.
> > > > > > Just like RISCV_HWPROBE_KEY_IMA_EXT_0, this allows a userspace program
> > > > > > to determine all of the supported thead vendor extensions in one call.
> > > > > > 
> > > > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > > > Reviewed-by: Evan Green <evan@rivosinc.com>
> > > > > > ---
> > > > > >     arch/riscv/include/asm/hwprobe.h                   |  3 +-
> > > > > >     .../include/asm/vendor_extensions/thead_hwprobe.h  | 19 +++++++++++
> > > > > >     .../include/asm/vendor_extensions/vendor_hwprobe.h | 37 ++++++++++++++++++++++
> > > > > >     arch/riscv/include/uapi/asm/hwprobe.h              |  3 +-
> > > > > >     arch/riscv/include/uapi/asm/vendor/thead.h         |  3 ++
> > > > > >     arch/riscv/kernel/sys_hwprobe.c                    |  5 +++
> > > > > >     arch/riscv/kernel/vendor_extensions/Makefile       |  1 +
> > > > > >     .../riscv/kernel/vendor_extensions/thead_hwprobe.c | 19 +++++++++++
> > > > > >     8 files changed, 88 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > 
> > > 
> > > 
> 
> 

