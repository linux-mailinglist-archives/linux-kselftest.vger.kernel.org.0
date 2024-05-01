Return-Path: <linux-kselftest+bounces-9240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B08E18B9037
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 21:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19901C20C15
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 19:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6049916133C;
	Wed,  1 May 2024 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="iwWN7QxB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03367182DF
	for <linux-kselftest@vger.kernel.org>; Wed,  1 May 2024 19:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714592899; cv=none; b=emX1KgOB7NbJxmGW5Kc9Lb4eagJAhpEWSodKcRiuUbo34ngzZ83QW7rh3gxn6kUS3c+QeFLo+CfqXybb7009nbdM8LjyvXKGEwKUUBnx7LKtO1ZntvN1eOCr2kikYMS+rfTvlvDSkp9Phf6V/w6/zpf0pgPbnDooihZ3nh1xW0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714592899; c=relaxed/simple;
	bh=0xusBx4mvpGkzkWD4XBTeQoGUcYyDndMqcZwmTR7iPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwchsWL1R7We7fXi7GgV1OY4gufJaDEXSZPeAMQjtYebH38XsgpDbu7kBi8L+wJcUi0gQYN5YGJBTB1hms8P0u4IFBJ0O/BeQdF9zq8iUUUjh3T9DrCkbhYfOOc/dzN7d+BuphzSeWd2C/pEHPomEC67iK2hVkOtUcbidJxxQls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=iwWN7QxB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ec4dc64c6cso16548155ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 01 May 2024 12:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714592897; x=1715197697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JtC8dm20imTdKCQqTW5smBrp6Y6uvCPu1xFL49hxPB8=;
        b=iwWN7QxBz4DTHm1qm4OvpmvNaVrshOl+oNlLUJKpgpYips6mizmNWeGngZ7RT2SCYn
         6kyWULXJJiRSqRABB3YLom9mKVl7O1GRH3fO9iv+zXLQZvX8IujkF5/OkVWuuIxYIvHk
         czSTItxHcV3PGWm9icjiVq4AXktjZRr5Kg93KsO6cUnLQ2Jc5ZldYY/TJ7lZNBsay4yN
         104GtD7bPaL5esKEKFEBLc2v7xelq7wUgkZrgAtJs7G50S0j5ehcLdzzk9mP//qrHDox
         kvR0sCoMr2n5O61swCfODCxdsx5HGrewfmkIb63uTPTpCi4pYISkNFaS/0d+8/TuLx3b
         8NGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714592897; x=1715197697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtC8dm20imTdKCQqTW5smBrp6Y6uvCPu1xFL49hxPB8=;
        b=mFlaDzN1ADhGLw6WyasRnhQBk3iMjyFkV4DGx7kPT7FqFbEN60ACX17GxcOiTJwZzM
         raxsxk+7a6sY7Tvxs5wKhTNsqYPCdHj4VMnXR80sw221zhVY6UU8/sn4u6pUmhNF2o9O
         INdNmsmhsFCLXFwJa/DA4LG6Zftyg8iCna7Ee34ZtnpVbD8+o6YTcv067qSUhQmfnbUF
         MqUYZBueHsalb81lqyg8e/kfVYhs8+IrPWH/3+mcdc7MM0SHBUlNRkLbj3E8EO7wqhe2
         TzIBYqI935kXcEYR6aKWdaRh++8Z2Bc+r4snZrtoYjKLzGHughNgcxyYN5gMYQjhZdoH
         yE9A==
X-Forwarded-Encrypted: i=1; AJvYcCVv8qaTL2ub2ec5HLzDccBNaceDo8zjTu5xAMboy+r3In3DeJrlMr5Zr2xzIUN4r3p5DoM5qjEtuO6u7YR+2vxZc1KZpnx7UbLocqIpKHCC
X-Gm-Message-State: AOJu0Ywv1qJlvIWbSfF/uXewaS/wFR/lRqYQKgeahe8VU3IjffkWtSz4
	T7nbeycvlMRXlROQO+Z65ORAZvFC3RUtZEIqtLqVmwU1J+BwXA2xEUAmm3e2Wu8=
X-Google-Smtp-Source: AGHT+IHqE9T7lF1XvjCAtRw9iaYnvm5Bt1x7gAa4owqnGBOgOTMkA2A37jDPqx0fFTLOHQocKAXYtQ==
X-Received: by 2002:a17:902:d506:b0:1eb:2fa0:c56f with SMTP id b6-20020a170902d50600b001eb2fa0c56fmr4034243plg.35.1714592897320;
        Wed, 01 May 2024 12:48:17 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:1dcc:e03e:dc61:895d])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090276ca00b001dd69aca213sm24321702plt.270.2024.05.01.12.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 12:48:16 -0700 (PDT)
Date: Wed, 1 May 2024 12:48:13 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 07/16] riscv: cpufeature: Extract common elements from
 extension checking
Message-ID: <ZjKcfZsWgR1AY3AZ@ghost>
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
 <20240426-dev-charlie-support_thead_vector_6_9-v4-7-b692f3c516ec@rivosinc.com>
 <20240501-probable-unfunded-746ef6ae1853@spud>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501-probable-unfunded-746ef6ae1853@spud>

On Wed, May 01, 2024 at 12:37:14PM +0100, Conor Dooley wrote:
> On Fri, Apr 26, 2024 at 02:29:21PM -0700, Charlie Jenkins wrote:
> > The __riscv_has_extension_likely() and __riscv_has_extension_unlikely()
> > functions from the vendor_extensions.h can be used to simplify the
> > standard extension checking code as well. Migrate those functions to
> > cpufeature.h and reorganize the code in the file to use the functions.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/cpufeature.h        | 78 +++++++++++++++++-------------
> >  arch/riscv/include/asm/vendor_extensions.h | 28 -----------
> >  2 files changed, 44 insertions(+), 62 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> > index fedd479ccfd1..17896ec9ec11 100644
> > --- a/arch/riscv/include/asm/cpufeature.h
> > +++ b/arch/riscv/include/asm/cpufeature.h
> > @@ -98,59 +98,66 @@ extern bool riscv_isa_fallback;
> >  
> >  unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
> >  
> > +#define EXT_ALL_VENDORS		0
> 
> It's not really "all vendors", it's standard. Otherwise, this seems all

This hooks up into the alternatives:

ALTERNATIVE("nop", "j	%l[l_yes]", %[vendor], %[ext], 1)

Where the "vendor" argument is supposed to be 0 if the alternative is
applicable to all vendors. Is there a better way to convey this?

- Charlie

> grand to me,
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Cheers,
> Conor.



