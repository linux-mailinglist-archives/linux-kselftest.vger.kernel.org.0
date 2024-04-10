Return-Path: <linux-kselftest+bounces-7529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCE389EBB9
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 09:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFC721C20D35
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 07:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754AB13C9C2;
	Wed, 10 Apr 2024 07:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="E+7HpyAs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B6728376
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 07:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733648; cv=none; b=N5O+6RvTcDI77AwFdTdB5qCwZ0+A7LIH7nnyOOUjVYHQRqBIo7W8ggqPyZtFCVGHDcn840Rir6PTA9amu/HqLzqO8yFiPuJaa2xR1gM7fuWKvZIb7cL1gCQnLR4dQjmqSpQYwNttKp82sCmfPmXgJdS5OpRBR3qW6sBcm4G6RO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733648; c=relaxed/simple;
	bh=rx19adIEtRfFuy8+v22L05S/+p5rIRJ/JcnvLnEFh7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAsTKnmBsTJ+2lqgSQCnp1bOd0E/Dx6pxpc3I2TbkyZKDqWbL45SHY8IZe74sA6u30vrWD/vbonJLV6O3DNSjfA4F8MvEHsmPR4Eb9zZdOnHwFoASnRfV4JkPuPWJO2SThmuBMKvXQdxVTzHWAhwVFnbC5NicjQgT3d9kvave6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=E+7HpyAs; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a520410b7c0so93543266b.0
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 00:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712733645; x=1713338445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uLhNuIrSaoYe/9NO2TgswlnfBaBCyzfaiiheEplZdqE=;
        b=E+7HpyAscsvxzlxlbX2LdRHPXl2tyDpBbOoYQdqJqRB1lt/ibuAQaxU69TFWBkz+Ek
         oUFYbBWYjSFLkh6agnL1JbQD5tdToy83+q5LwEMYxCpA3J2axwWWiC2GD5oEobqa/Oo5
         9EK8GHhn/U15sXVJcqnHlDG+22FQFYCRm4ETn6nkyQOrXNA5VpRit4mTKw7+YoXUvyk2
         ZSgcj4RXPUbkV5Ug6B9t2KAUirmQNUJDePxb7MZw+vIxEJChx2UJZlAiww9iEenSxobX
         ronns2mXYGlYWCBo/8s13bmENjrC0aMtZslS0SCX9wJP/mgy6Ak4k70Svorjv2QkI3Zu
         WkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712733645; x=1713338445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLhNuIrSaoYe/9NO2TgswlnfBaBCyzfaiiheEplZdqE=;
        b=T0KAhl6WguFPIsSdhR0S5A5bm9GsThs4rgNEUfRVSKlZtO6oOubhCefBjClMtkfGcS
         C7Fj1YErcPfm4Sfg29ndHPXylAHdNV+8ITFZzC/1Lb/r1HtV1o1eKfWphupudKpgyJoT
         LUs9lN5SQYIiiRQdpq+ka2jB52rKlsGbm4owmOnG3l+Rep1TgNXgXUwBKirLlZPUL0sh
         lK8FFDuvhihbevIjEh2/NhwUdS2Hx7VUsYjL2C88V3dDDbohZxY071meAAw1udL+QWCO
         hLkdUlkMBKcoK0mpNE5qkSY21G3dRv27QFFm4+wXBIR0siSaYeotuh0pGwGsLCKhZpcb
         M1Vw==
X-Forwarded-Encrypted: i=1; AJvYcCXObQq0E3zhSdcabxnpgSuzmk1ZgU6gMeuU6/d1pnaZRTCx64PJMwLNCMZDz22ecfUR+/vHxdyfJH+HrnE8Pqy6Q/ccYPqKpinTsoZKmNpx
X-Gm-Message-State: AOJu0Yw7duUbymnLb397Ptc3ED5495YPZW0EeeQlax/hkTe/78DYvDaO
	EEYbiM/2JJsZQOp+RkzaXmDXUq6H6Lq+e2mk480n6CvEqg6e/X3YbbD0i6a2D/I=
X-Google-Smtp-Source: AGHT+IFblqSFRNSt8LD4P6llFistdn4FvvuYpArYI85OkCLQGw80eVNjwPfQ65XS4eljatieTXAaFA==
X-Received: by 2002:a17:906:c215:b0:a51:d7f3:324b with SMTP id d21-20020a170906c21500b00a51d7f3324bmr969037ejz.66.1712733644958;
        Wed, 10 Apr 2024 00:20:44 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id jz8-20020a17090775e800b00a4672fb2a03sm6720040ejc.10.2024.04.10.00.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 00:20:44 -0700 (PDT)
Date: Wed, 10 Apr 2024 09:20:43 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Atish Patra <atishp@atishpatra.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 09/15] RISC-V: KVM: Add perf sampling support for
 guests
Message-ID: <20240410-f1a4303dc73789aa6adbe730@orel>
References: <20240229010130.1380926-1-atishp@rivosinc.com>
 <20240229010130.1380926-10-atishp@rivosinc.com>
 <20240302-f9732d962e5f7c7760059f2e@orel>
 <c46c57c2-95bc-4289-ac99-efd5bad093b5@rivosinc.com>
 <20240405-de92b25fdc1ecf53770c49d9@orel>
 <388ef032-7030-47b5-bba5-852b00de7382@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <388ef032-7030-47b5-bba5-852b00de7382@rivosinc.com>

On Tue, Apr 09, 2024 at 05:11:31PM -0700, Atish Patra wrote:
> On 4/5/24 05:05, Andrew Jones wrote:
> > On Tue, Apr 02, 2024 at 01:33:10AM -0700, Atish Patra wrote:
> > ...
> > > > but it should be possible for the VMM to disable this extension in the
> > > > guest. We just need to change all the checks in KVM of the host's ISA
> > > > for RISCV_ISA_EXT_SSCOFPMF to checking the guest's ISA instead. Maybe
> > > > it's not worth it, though, if the guest PMU isn't useful without overflow.
> > > > But, sometimes it's nice to be able to disable stuff for debug and
> > > > workarounds.
> > > > 
> > > 
> > > As per my understanding, kvm_riscv_vcpu_isa_disable_allowed only returns
> > > true for those extensions which can be disabled architecturally.
> > 
> > I think kvm_riscv_vcpu_isa_disable_allowed can return true for any
> > extensions that KVM can guarantee won't be exposed in any way to the
> > guest. Extensions that cannot be disabled architecturally must return
> > false, since their instructions will still be present in the guest, even
> > if KVM doesn't want to expose them, but extensions which KVM emulates
> > can return true because KVM can choose not to emulate them. IIUC, sscofpmf
> > falls in this latter category.
> > 
> 
> hmm. The Sscofpmf is dependent on interrupt filtering via hvien and SBI PMU.
> So you are suggesting to toggle off the CSR_HVIEN bit for overflow interrupt

Yeah, this is what I was thinking.

> or do more granular disabling for privilege mode filtering in SBI PMU as
> well.
> 
> Beyond that we can't disable SBI PMU. Is that okay ? A guest can still cause
> counter overflow and interrupt the host. However, the guest won't get any
> interrupt as hvien is not set.
> 
> It can also still filter the events as that is tied with SBI PMU.
> 
> We can put more granular checks in SBI pmu but I am just wondering if it
> provides anything additional beyond just disabling the sscofpmf in device
> tree.

If it's too much of a code burden for something we're unlikely going to
want to do for anything other than debug (where removing the extension
from the device tree is likely sufficient), then that's another reason to
not allow disabling. Maybe we should write a comment above
kvm_riscv_vcpu_isa_disable_allowed which points how extensions end up
there, i.e. either KVM is powerless to completely hide it or we don't
want to maintain KVM code to completely hide it.

Thanks,
drew

