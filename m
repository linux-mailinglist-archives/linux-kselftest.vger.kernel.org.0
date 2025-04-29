Return-Path: <linux-kselftest+bounces-31861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D347AA0698
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 11:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB7218830A4
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 09:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D9529AB11;
	Tue, 29 Apr 2025 09:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="M15X/Gvq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3587B27F74D
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745917564; cv=none; b=bfplUAgYtiX0TXoQew7KdmjnZdtYq0LoSpker1q1LHGMu7i39aZclWX+gRp8tWnqrAjmVC2RAW3fPdJn8+jYZT2AvTznKqc3gD1fh1HJcNLW46FwyKW7Ey8AjngFTWY8e1ZI7kkrGME14oQWoaYt7rkWRU8hirwam50H1lJ9cuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745917564; c=relaxed/simple;
	bh=M2PUNSlDRsRs/DFNkJvrrRwh6F5RSdQsCwiq8JtjP0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjoOEAhSobQomNooCdCbBKv9m1SasQVa2krZhOhIld8+k/Y1BKAE+xeMes0RnANbPldsE8TwlyclVQbIobgIZzghRlEbJFib1PMRaoJWcBTPdFU+k2UeLC8BBJd4OJI/eMHeGwn63Tf5Ogbc3iBTv7LWmNWMXYiIVc5i2gFUFWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=M15X/Gvq; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39c1efc457bso4083151f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 02:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1745917560; x=1746522360; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KatqGhsrZH+ZioIyyPM0GHZkF6RidX+RSSACu/Ebkcw=;
        b=M15X/GvqMo0dU6v3IhyX/0PWlPXLLI/oAcaQBj/gmuyvwjs5e+OEjVGcNwFkYvmyLG
         d2tbAh1q/V7sM8bWnjyEI114pK8SpSDXRNjAtmZ9O7lNWXYs3A9n1kJ73j/sM3Fk+kyr
         HE6eEDFfsOFY35PS+1SRPneogoR067UXTHjxeQGgqtKvAcJcdq9DLRbQxUyKgrxZrBRP
         SXLGAfXyCVoLD/ZFutUfFULB0jW+MRjqriLM9/J80A1pkpE1vhLAB6faQuZSRa7+s6qH
         ixCfTsyeJC6iif90PcmKRjGcZnrv+8Haov/MsjyqiN2qCIyGpRRnSdpmTORsLvngLjDj
         zduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745917560; x=1746522360;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KatqGhsrZH+ZioIyyPM0GHZkF6RidX+RSSACu/Ebkcw=;
        b=SFWXgXfR4nDVq1IFQAETfKCKiSZFjQyDhwxCSCGuzfe3Y+ouhWvcvBpdjPq0rcgzHg
         e44a0Hmh7t4Ka948lrfaP6A/1+ztcZffKJGnJH3HjOOT3HyOlbiwa6WuQ9ked+QqvwTc
         0E5Bjt7vtGengZFd+MmJk8sjogZup6mIsPqpoZ4xm4TdGTGb77k4aHH73tVyT//rB6gI
         aMbEbhQGrDNHe9o3RClWPdOd62aE7KxjleyZboxbGSbDwbhLeRIGgJVAWGHrQz8nrwsA
         zrlC2OwV7RV8OD5r/35ZBAJGj//AVUMnjiYk+Xji+HiQ3lXBhB4aQY4F/0WwwKT2gTD6
         ChQg==
X-Forwarded-Encrypted: i=1; AJvYcCUPJnDdtDzk9ApQECC2qDXUVqXGBu3w5pXc9cMEa0A8WSf4Ia48mivjB7IsXtt+d7EXYEtGpwSLOkSU5G7iLdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw84WCCxyexNrhhExoV+EtegH+UCHg24mNO2gAF9TtyOJY7S+c6
	4sLYgFNFOzupCbkcqBiu+hKIobeSnQjsdSUJT83t6VdNYWHIIuivhYGhS8UP1Sk=
X-Gm-Gg: ASbGncubwZ9Cdt3j436Gc8olBVrhYbGFYp+gDBs0/t6VHUXYhnoS6YyKPkoraz2ni1g
	+7ltV5KeVokxCWgZ0ESETIEvigSaFnGoO+17FevhXXJUUDxsuOI5PrrUyKksEPn3JXi694Biz0y
	cP7Lu5d1V0CtYVIs8jdiiaZA6Yy/DAWIvCpnZx67/Ph1Ar2kzgdj/HO1b3fDuPtHalTrVLbeOuH
	Tzbyh6vOsdGnIzJ5RdAAaXhg9WanYGESdQLhWgZB2XMBJABBBn5urcKcE3+S2F/8qCTNZ3Ukg6p
	7vXz/WLOGeYYw6sJP4ZcfAZjxuAh
X-Google-Smtp-Source: AGHT+IGkl5qjiabpogb2jkKx++DcNwNz6kC3SVaUoXxULD2fuawYRLha0X61n1NZ+hz8YxEyViubjg==
X-Received: by 2002:a5d:6903:0:b0:390:eacd:7009 with SMTP id ffacd0b85a97d-3a07ab9be44mr6194393f8f.42.1745917560430;
        Tue, 29 Apr 2025 02:06:00 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::f716])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e5da02sm13462185f8f.93.2025.04.29.02.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 02:06:00 -0700 (PDT)
Date: Tue, 29 Apr 2025 11:05:59 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atish.patra@linux.dev>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] KVM: riscv: selftests: Add stval to exception
 handling
Message-ID: <20250429-683f10a791d9ec41b060ec4a@orel>
References: <20250324-kvm_selftest_improve-v1-0-583620219d4f@rivosinc.com>
 <20250324-kvm_selftest_improve-v1-1-583620219d4f@rivosinc.com>
 <20250425-dc44cb547ab5e2f994c94e80@orel>
 <3b05d1a0-c873-4e61-b98c-b725d0dbb350@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b05d1a0-c873-4e61-b98c-b725d0dbb350@linux.dev>

On Mon, Apr 28, 2025 at 03:47:47PM -0700, Atish Patra wrote:
> 
> On 4/25/25 6:50 AM, Andrew Jones wrote:
> > On Mon, Mar 24, 2025 at 05:40:29PM -0700, Atish Patra wrote:
> > > Save stval during exception handling so that it can be decoded to
> > > figure out the details of exception type.
> > > 
> > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > > ---
> > >   tools/testing/selftests/kvm/include/riscv/processor.h | 1 +
> > >   tools/testing/selftests/kvm/lib/riscv/handlers.S      | 2 ++
> > >   2 files changed, 3 insertions(+)
> > > 
> > > diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
> > > index 5f389166338c..f4a7d64fbe9a 100644
> > > --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> > > +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> > > @@ -95,6 +95,7 @@ struct ex_regs {
> > >   	unsigned long epc;
> > >   	unsigned long status;
> > >   	unsigned long cause;
> > > +	unsigned long stval;
> > >   };
> > >   #define NR_VECTORS  2
> > > diff --git a/tools/testing/selftests/kvm/lib/riscv/handlers.S b/tools/testing/selftests/kvm/lib/riscv/handlers.S
> > > index aa0abd3f35bb..2884c1e8939b 100644
> > > --- a/tools/testing/selftests/kvm/lib/riscv/handlers.S
> > > +++ b/tools/testing/selftests/kvm/lib/riscv/handlers.S
> > > @@ -45,9 +45,11 @@
> > >   	csrr  s0, CSR_SEPC
> > >   	csrr  s1, CSR_SSTATUS
> > >   	csrr  s2, CSR_SCAUSE
> > > +	csrr  s3, CSR_STVAL
> > >   	sd    s0, 248(sp)
> > >   	sd    s1, 256(sp)
> > >   	sd    s2, 264(sp)
> > > +	sd    s3, 272(sp)
> > We can't add stval without also changing how much stack we allocate at the
> > top of this macro, but since we need to keep sp 16-byte aligned in order
> > to call C code (route_exception()) we'll need to decrement -8*36, not
> 
> Yes. Thanks for catching that.
> 
> > -8*35. Or, we could just switch struct ex_regs to be the kernel's struct
> > pt_regs which has 36 unsigned longs. The 'badaddr' member is for stval and
> > the additional long is orig_a0.
> 
> I think switching to pt_regs is better in terms of maintainability in the
> future.
> I will do that.
> 
> > >   .endm
> > >   .macro restore_context
> > I guess we should restore stval too.
> 
> Do we ?  stval is written by hardware and doesn't contain any state of the
> interrupted program.
> Once, the trap handler processes the trap using stval information, there is
> no need to restore it.

True. It just felt unbalanced.

Thanks,
drew

> 
> Am I missing something ?
> 
> > Thanks,
> > drew
> > 
> > > -- 
> > > 2.43.0
> > > 
> > > 
> > > -- 
> > > kvm-riscv mailing list
> > > kvm-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/kvm-riscv

