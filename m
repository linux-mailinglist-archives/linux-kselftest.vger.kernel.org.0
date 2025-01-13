Return-Path: <linux-kselftest+bounces-24359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829EBA0B722
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 13:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D709F7A3FB2
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 12:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F8A22F156;
	Mon, 13 Jan 2025 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="cww5AIgv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F7422AE74
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736772084; cv=none; b=VHXt9s3CKX7UN8F+dH8kEeyLadvszLDF+eJSRvNWQqcoqXUbo62VTtDgDYv3cg3ZqAd/CMzj8GSaTc0+95VYsuqPNX7rhkgp58ejmYK6kcn0y5YOOFN7+0e7hzVdupPG3iRInbOw/HD0tNsVFNSQ2Qf/baQAWLJ3iFfIUhnCc+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736772084; c=relaxed/simple;
	bh=1SmsyTH1IuVPTsBVIsHoHeNSWqXgZE34TiZDhielAWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5a2L9n8DVUxKquCKj0RHsHnJwugU/payjg1Y/OGuPC5VWBXcyhbcSh2AUdwEh2InIU5UVq3HzZEgPHpe3ZPhFmKSsDixusYzW3tZs+/nzAOak73ruylNgrN3Yg2O7MKsReCdSzIKQKULWPrLFX3ZOMPpYMKpgHGAVL5BGGy9b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=cww5AIgv; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d88c355e0dso7433151a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 04:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1736772081; x=1737376881; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=huUeYxgEHQ+QkCankWz8xkLpv2eADhRNrifi/EU0k50=;
        b=cww5AIgvCmFzD6r1coQ+CPGHu7YbdkwdpVFm8Wfyg+4ruKBviLXzOGMBPEDvXa8iXc
         8WAZitKg9jLB9l9iwRXu9onHZ/2BOXhCdHETxZZibcIjyvXkoQB8kK+ea9GlJYL1Gp5q
         NgWDM/NYGa8/+G4lwrNOA8/5S+a1AdQBwlfm3MyMNacIzjCpDD9zRwlGpW3m2jxIMvG7
         9l7niNG0p8zaW2RSnnWtWi3p+Dc09qPSYOKUeWcAdlhISliBdfI8aCBr4VHhzX7uGJST
         V+TjsoltJfWvV6ZZVObFBOCMDqgKAcKxO0iuzzj+AzCxq6Exhig4Ssw7iCkPIkW8o2GH
         yB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736772081; x=1737376881;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=huUeYxgEHQ+QkCankWz8xkLpv2eADhRNrifi/EU0k50=;
        b=kXnnJnEfm6BNzIWHmOAmbboL/cWv8Uen4Y2311P5r4CO/sDbpo46c4VjFkVKUZ5zzS
         ScI13DSb3jnLtZXjTINS+BOqLKUBnACIA7JFqe5HBYzGqXCofOX0EkIFs4GT9j9Wg6kr
         bol2suuTozeDFcg/kQyEPgNa+t51yOj3Zd61E4YqFbSjR29Vzc2TsxZPMfs+g2nJhwX4
         iOWhPtRi0FUzADRvc9M3IGk+xJulZqttYCsl3rzFhKT/weOKMyc4Uiwh3z/SfGqNVwmI
         cdGqiOH+dBjIrXXh9TLFFzDDSFpg4L8PJ4Re1SBfq2gSRK3NiyJTgOEgY3sldk1xLYJa
         WeCg==
X-Forwarded-Encrypted: i=1; AJvYcCXtwaLab6GFJqrwKw+bP3esa8dlAkf62oCnLs0vDgaW4dhLbWjJLdmHu9TZ/LcMe5jG0D8PW5LbCLbtRsXXfk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyPdnbOi7+uVIzOKkTxBaMgiRhTDYoouWbcsm7EISx4WzHpGQB
	iXcLSyJ0Tt2UvWMr2d9RBiTUGZe8WcBk7W2hWShLQuf1bAXMORGft8lM6tyoEuY=
X-Gm-Gg: ASbGncsRSXwVU+45RLB3XM8tCyMtIqH/oQxcsjngKm0PHA/CPw+FrhFX9uXtlsO9wHV
	cmTRvc+oARrYhMediE6m8HRX5IdAPggKT7fKqJ+UVR6fT8PzpkYLws1YnYfNjR/YPgQXJSDGMSQ
	3QKQ8K1ELaK9sGE4d0XoOIG/dGl4uPC1KklfZw89ZOWGRGeq0b57qbGQOTiJW8GIwKcuzpZlgHM
	iOMWdJgnQ2+SrtsxQ2A2vK3aQIVUsbRhs9se/vNVukd/p/6RC97IwLdTar1USLqsI4bg9x/Stz4
	laDhuTPU0BoFxUqlbTL8s75eubf979jQ/V9tgGoGsQ==
X-Google-Smtp-Source: AGHT+IH/2QV8V4ediKclPA9gLPWZd3mIbosx/ICvvUfzixLKWMRsrnwfp0jkVU/aUAETM94untErKQ==
X-Received: by 2002:a17:907:3f92:b0:aac:439:10ce with SMTP id a640c23a62f3a-ab2ab73e812mr1850195066b.27.1736772080946;
        Mon, 13 Jan 2025 04:41:20 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9564848sm490993366b.125.2025.01.13.04.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 04:41:20 -0800 (PST)
Date: Mon, 13 Jan 2025 13:41:19 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: alexghiti@rivosinc.com, andybnac@gmail.com, aou@eecs.berkeley.edu, 
	charlie@rivosinc.com, cleger@rivosinc.com, conor.dooley@microchip.com, 
	conor@kernel.org, corbet@lwn.net, evan@rivosinc.com, jesse@rivosinc.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	samuel.holland@sifive.com, shuah@kernel.org
Subject: Re: [External] Re: [PATCH v3 2/3] RISC-V: hwprobe: Expose Zicbom
 extension and its block size
Message-ID: <20250113-da3ae77c9eb1342ac19ec59c@orel>
References: <20250113083635.73826-1-cuiyunhui@bytedance.com>
 <20250113083635.73826-2-cuiyunhui@bytedance.com>
 <20250113-65f27ad723c0f6585f86ae7f@orel>
 <CAEEQ3w=fgb7Jxg6SP_hp0Z+T0Tfb-_Pa4-CzU8PpGUKA+dHxyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3w=fgb7Jxg6SP_hp0Z+T0Tfb-_Pa4-CzU8PpGUKA+dHxyA@mail.gmail.com>

On Mon, Jan 13, 2025 at 07:29:39PM +0800, yunhui cui wrote:
> Hi drew,
> 
> On Mon, Jan 13, 2025 at 5:07 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Mon, Jan 13, 2025 at 04:36:34PM +0800, Yunhui Cui wrote:
> > > Expose Zicbom through hwprobe and also provide a key to extract its
> > > respective block size.
> > >
> > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > ---
> > >  Documentation/arch/riscv/hwprobe.rst  | 6 ++++++
> > >  arch/riscv/include/asm/hwprobe.h      | 2 +-
> > >  arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
> > >  arch/riscv/kernel/sys_hwprobe.c       | 6 ++++++
> > >  4 files changed, 15 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
> > > index 955fbcd19ce9..7a47cbdbcf8e 100644
> > > --- a/Documentation/arch/riscv/hwprobe.rst
> > > +++ b/Documentation/arch/riscv/hwprobe.rst
> > > @@ -94,6 +94,9 @@ The following keys are defined:
> > >    * :c:macro:`RISCV_HWPROBE_EXT_ZICBOZ`: The Zicboz extension is supported, as
> > >         ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
> > >
> > > +  * :c:macro:`RISCV_HWPROBE_EXT_ZICBOM`: The Zicbom extension is supported, as
> > > +       ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
> > > +
> >
> > This should come after RISCV_HWPROBE_EXT_SUPM since this document has the
> > defines sorted in the order in which they are introduced (although I
> > personally wouldn't mind if we ordered them alphabetically instead)
> OK
> 
> >
> > >    * :c:macro:`RISCV_HWPROBE_EXT_ZBC` The Zbc extension is supported, as defined
> > >         in version 1.0 of the Bit-Manipulation ISA extensions.
> > >
> > > @@ -273,6 +276,9 @@ The following keys are defined:
> > >  * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
> > >    represents the size of the Zicboz block in bytes.
> > >
> > > +* :c:macro:`RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE`: An unsigned int which
> > > +  represents the size of the Zicbom block in bytes.
> > > +
> >
> > Should be moved below RISCV_HWPROBE_KEY_TIME_CSR_FREQ
> 
> Why should it be moved below RISCV_HWPROBE_KEY_TIME_CSR_FREQ?

Oh, right. It should be below RISCV_HWPROBE_KEY_MISALIGNED_VECTOR_PERF for
the same reason as above (order of introduction).

Thanks,
drew

