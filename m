Return-Path: <linux-kselftest+bounces-7682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123B28A0A5C
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 09:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 300FDB2617A
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 07:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5833513E882;
	Thu, 11 Apr 2024 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Ltrvv65P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FEE13E051
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 07:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821524; cv=none; b=T+HPYhf9G/3ptezw3RhiIywRDc447PfZAU1oIN96EoHkP5ZTRMOQLLLWhf8yx4bJ9l+S3IAFWqN/lgAwmfud+nr4hiiuN5CygFgzeEtHhDUr76/oTlDwcwKz98GDu1du+LWKxKPLcPdHYxyVghLYOhxwrH9H5HhATl/WEJjvR94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821524; c=relaxed/simple;
	bh=jVTgERzLmYSTnbK6BX20guTVY29hU1wrqk54ruOXXcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ckc2BVKRsB7bW6Dxf6+Q+UAsdWdkbquOdQMfx/GWCoJbvc01pzQjoN9ll9o7/7IcNyAEy7LoqCD4rWDh9LopGkWUZq/hsddEByQdycGFKvDYsmKkzOSGrR4z9YFf0nY2aFmcUq6TyFrgwPpze3Yphdxhntz+hn8i3d5SGl8WPxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Ltrvv65P; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a46a7208eedso1073652666b.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 00:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712821521; x=1713426321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aH2Dc8j8I8xIvPcUDdCDU7Xxp8EkAEDRyp5XNqYeoic=;
        b=Ltrvv65PpWlreic5/ZGu96a9YFf803gM64mfipxIxqbsqaBcqHPsw59oj7IrTOxC2P
         MBbwy3rp9VSBFGtHuOMRm2ulccc46MP6D0ukFfDtG9+YFbED/TxAlxzXhPEXCAp1uNyT
         thqvgrZ+yWomkCjjMMokBYXTgROGaSgZ61H2Pl7V97Cynt2M5m6p5lI425GOuD86kvGf
         P0cU9rZRoGJe8bnfHjrEtn7R/PL9MMA2VSL3Iw3dMZGcmGjWnfg4/CVXyAsj9XNGPdIp
         J8ltA99myoEvGfzqAqFgjs5mohuerzIlor1+3mAFl8DO7EPW0H6x5Hoks0vgaQSCH0cw
         Hn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712821521; x=1713426321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aH2Dc8j8I8xIvPcUDdCDU7Xxp8EkAEDRyp5XNqYeoic=;
        b=FrXlSfN+x6ZThBcQnzYCFmNsWqRyddDLzb9tEYZCU/VHarLWjFmmmQD1UYpnedNU+u
         hg37rmspkd5h96CcS282wR+UH2jZbtmjvy+RoaP5aRQCem/WYQ8X4T2yyHIENER4OcKq
         7TNznbK+0j4vEYhk2dMObi/FxxucgwDmTdbKGhS+us2o6vnU8DSltTW2BNeq3JDxEGQj
         +Ctl2p0X8NpUaDcrFRFhNe5O65NRARXxrSrj0PhikEYKOHTGr4iIzDncMO75tcDSOF3w
         VYvU6AH92cVzq+sX5hdFrD6igO+/RVBpj6vH6e6V/C4s2r3XsCxOqgY2VwQAkK3+Zubx
         fN1w==
X-Forwarded-Encrypted: i=1; AJvYcCXmRcgo62od7oXBglaCPBUZ17inruEWHZqh5i7r4IFWr1zIM1zqbxAQ/HkfDJHJRBpytEQ9UO6vqep8aKXwycLkyhZlVV1Htzc0631JUFfn
X-Gm-Message-State: AOJu0YzmcryWYnQVliymqNRSiLCHuQYBpS+gGML+F69HwZ/Dbw2CEsOd
	qHAD7LnahQSOxXTtnqRO06fVmwPbu9eI37ayOG7fB64AXArs2059OMfmNBRcQao=
X-Google-Smtp-Source: AGHT+IGXjQgcemnZ/eu1Pazqcv6W8xDCpaPihHKrZ7vRNQjLlX8nqWL204fGLinJDjejI9EZkPgjUg==
X-Received: by 2002:a17:907:7f87:b0:a4e:6b81:49db with SMTP id qk7-20020a1709077f8700b00a4e6b8149dbmr3626235ejc.8.1712821520961;
        Thu, 11 Apr 2024 00:45:20 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id f25-20020a170906561900b00a5223233b4asm278978ejq.117.2024.04.11.00.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 00:45:20 -0700 (PDT)
Date: Thu, 11 Apr 2024 09:45:19 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
	Anup Patel <anup@brainfault.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Ajay Kaher <akaher@vmware.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Alexey Makhalov <amakhalov@vmware.com>, Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v5 06/22] drivers/perf: riscv: Implement SBI PMU snapshot
 function
Message-ID: <20240411-688dc97b08bb3b63511dcf6e@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-7-atishp@rivosinc.com>
 <20240404-4303d1805800fad18b6d9768@orel>
 <170cc87a-5b55-45be-a0de-213aabd852dc@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170cc87a-5b55-45be-a0de-213aabd852dc@rivosinc.com>

On Wed, Apr 10, 2024 at 03:29:21PM -0700, Atish Patra wrote:
> On 4/4/24 04:52, Andrew Jones wrote:
> > On Wed, Apr 03, 2024 at 01:04:35AM -0700, Atish Patra wrote:
...
> > > +static int pmu_sbi_snapshot_disable(void)
> > > +{
> > > +	struct sbiret ret;
> > > +
> > > +	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_SNAPSHOT_SET_SHMEM, -1,
> > > +			-1, 0, 0, 0, 0);
> > > +	if (ret.error) {
> > > +		pr_warn("failed to disable snapshot shared memory\n");
> > > +		return sbi_err_map_linux_errno(ret.error);
> > > +	}
> > 
> > Also need to set snapshot_set_done to false, but I'm not yet convinced
> 
> Done.
> 
> > that we need snapshot_set_done, especially if we don't allow
> > snapshot_addr_phys to be zero, since zero can then mean set-not-done,
> > but ~0UL is probably a better invalid physical address choice than zero.
> > 
> 
> Agreed. But I don't see any benefit either way. snapshot_set_done is just
> more explicit way of doing the same thing without interpreting what zero
> means.
> 
> If you think there is a benefit or you feel storngly about it, I can change
> it you suggested approach.
>

I don't have a strong opinion on it. I'm just reluctant to add redundant
state, not only because it increases size, but also because we have to
keep track of it, like in the example above, where we needed to remember
to reset the extra state to false.

Of course, giving invalid addresses additional meanings also comes with
its own code maintenance trade-offs, so either way...

Thanks,
drew

