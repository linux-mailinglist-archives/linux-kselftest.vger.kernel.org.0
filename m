Return-Path: <linux-kselftest+bounces-9224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222D38B8ED1
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 19:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C58D5281778
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 17:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A195F182DF;
	Wed,  1 May 2024 17:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="uHTrGo5J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E22F17C9B
	for <linux-kselftest@vger.kernel.org>; Wed,  1 May 2024 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714583463; cv=none; b=XbziYxlW6aCgHhXfKov3S/ofnwV/PNjylYZIgX0dn6+ehXvswxWr1d1XqVleoVk6zneuQJdqknfTuXWOM92SwFCZKvd8pwnn4P4vP6Sb7PoxkrKgJADS+HFrKda3jkO30yBCFi/VS1ctvyYrzG4FDZtlqnMuQjp9WQhGE3NIZi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714583463; c=relaxed/simple;
	bh=pZAOS/T1u3WYFJhsFU1zktGFGi+9KYNTImhhH3xfeKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NS72PwdCqqXqKRsza7s4ner4dvtRNt3ruDhMonZSiRfYIxXHkqNyriFA1TJxcIy1CST1+nC3H9eOyoxErhyqNQcyLXIsw4Ev/XxuRSVuwSVvceQ+Yx6bw2J8zUFJRXQqTE5LVPHQtuPh5gP80IOD7t5yG7p1eZ4sJ1Otsht4jYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=uHTrGo5J; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1eca195a7c8so5750315ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 01 May 2024 10:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714583461; x=1715188261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7VEcP2FdbTuUC3sLwg55sFZlBNkkI24Wn6q64j9hZkM=;
        b=uHTrGo5JLLGnMbH5QgPkVY/+HGVN/EW9HmjfcHJfWdHNiMD9EfsmVt92BilMOItN7l
         TIunE56JqNtp1LTYsTS2+euIEbOUa3FC2LZsL68xg7l0KN5xV14wRyiAITWf9kDTiYEj
         nm/69ibSGjrGNWevERGDxpyD89Lu6/AWfDnzM52bEDhaTzumf2+BnWVguziPTtSgre+X
         oDU47Zb746h5dkiobEzZ1Pq8SCE3e8dZHi1QriNiDToQ3TKbD4zyPSt477ZpTSXuqrj7
         XaMjv1mT8A9LHzcZJDUo3ptTmJPwafhH5iqTMUZvzFksNfUqxWdffrDyUcMMzdjbczVe
         aJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714583461; x=1715188261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VEcP2FdbTuUC3sLwg55sFZlBNkkI24Wn6q64j9hZkM=;
        b=CIP/D7vbLQgEwfITOr3DRn5awuU9oJJWnFqIkrnq29aRQltKotT1EJJh1ilo4M6h3F
         toFi+ckEPoEkUPhVqxsoFuCCFHq+ptdT1BF1y9l+kVEl0/NDUNoz2SSTTksrgx2PYDdw
         qdZKHIRhSQOpNUNETrcwrb1+PNz2Uj2dg30wTZzJuacKZPr7qVZvP/lx+HdppbUfvOXs
         3eahoqL2ib90uiGc91S/2yygBUIeh3pMyv5uWoa9K4bGWC44cjjab/lLR7+qkq/FEBqd
         wBT0g4KXDRDulC+ZQnz+4A9hACZJxGJGgYaxuvT/mRfgjFbVYjSMn59aWyyTJdIAKep/
         G8CA==
X-Forwarded-Encrypted: i=1; AJvYcCXDdX2rTc895E1h7sYr8Iv/dVOHVKOsZsKjqYbdbiKQ/odUBnh4Mt9wfHs+p01NP3Iz5iOh3GPU6s7JhOH22TE4O3dd1SRVKzRJIrm68evk
X-Gm-Message-State: AOJu0Yyqfgdc5fOv2iDpfgLKWjnpsEPN+1BAawZCyqTko73dPK4daoRw
	/9Nzi/oaQYLY3KtiYR/v229Z2NV55QvSOwblmtEBmPBz3QzZzFcba5rOO1lj6f8=
X-Google-Smtp-Source: AGHT+IHpxFS6GEORaahugjisle6m4KLF0ZtLQCz0Flxl/HiPXR710X9hyJZCr2QqZFZg/RK2FxmvGg==
X-Received: by 2002:a17:902:6bca:b0:1e4:df0c:a570 with SMTP id m10-20020a1709026bca00b001e4df0ca570mr3014699plt.8.1714583461518;
        Wed, 01 May 2024 10:11:01 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:1dcc:e03e:dc61:895d])
        by smtp.gmail.com with ESMTPSA id mq8-20020a170902fd4800b001e23fcdebe9sm24447681plb.98.2024.05.01.10.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 10:11:01 -0700 (PDT)
Date: Wed, 1 May 2024 10:10:57 -0700
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
Subject: Re: [PATCH v4 05/16] riscv: Extend cpufeature.c to detect vendor
 extensions
Message-ID: <ZjJ3oaFWhbLc39sz@ghost>
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
 <20240426-dev-charlie-support_thead_vector_6_9-v4-5-b692f3c516ec@rivosinc.com>
 <20240501-drivable-deviation-0a493511770c@spud>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501-drivable-deviation-0a493511770c@spud>

On Wed, May 01, 2024 at 12:40:38PM +0100, Conor Dooley wrote:
> On Fri, Apr 26, 2024 at 02:29:19PM -0700, Charlie Jenkins wrote:
> > Separate vendor extensions out into one struct per vendor
> > instead of adding vendor extensions onto riscv_isa_ext.
> > 
> > Add a hidden config RISCV_ISA_VENDOR_EXT to conditionally include this
> > code.
> > 
> > The xtheadvector vendor extension is added using these changes.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/Kconfig                               |  2 +
> >  arch/riscv/Kconfig.vendor                        | 19 ++++++
> >  arch/riscv/include/asm/cpufeature.h              | 18 ++++++
> >  arch/riscv/include/asm/vendor_extensions.h       | 26 ++++++++
> >  arch/riscv/include/asm/vendor_extensions/thead.h | 19 ++++++
> >  arch/riscv/kernel/Makefile                       |  2 +
> >  arch/riscv/kernel/cpufeature.c                   | 77 ++++++++++++++++++------
> >  arch/riscv/kernel/vendor_extensions.c            | 18 ++++++
> >  arch/riscv/kernel/vendor_extensions/Makefile     |  3 +
> >  arch/riscv/kernel/vendor_extensions/thead.c      | 36 +++++++++++
> 
> I see no modifications to cpu.c here, is it intentional that vendor
> stuff isn't gonna show up in /proc/cpuinfo?

I wasn't sure if that's something we were wanting to support since
hwprobe is the prefered api, but I can add that if it is desired.

- Charlie



