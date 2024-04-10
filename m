Return-Path: <linux-kselftest+bounces-7528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610C089EB79
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 09:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66F27B245FB
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 07:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F6213C910;
	Wed, 10 Apr 2024 07:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="QjBUHcUW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33CA13C90C
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 07:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733019; cv=none; b=WPCvRj1mY2A47DE/lKanMbSt0hF62bGovB1OUePYgBzYKWaYdiUagAezteDL+HxPuR59U0KzCF0MDQa0/fg/7sRK7yGMEEwI822MGvSWDVgfx7hDWDnJB8GCn+J8Fs88Hz52GR04OSo/NiCsieQkz0NmcYAMP+8Y/TqP1eWdJzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733019; c=relaxed/simple;
	bh=jsUeO4aThyaUmwXMlWYckJ8eYmsW8VRj/SiTQghFA3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lY+2PenJ6HyGb0wvBUyM+jz8pYU58uTirXQ108H1kqd9i4TuguQExF52Vato1b5WhuNpvKNGqIzZuoOaqkTTgyXH/gdDg1doEY3AKOdKsjVRu/5n5YMgiV9GIuzgFkAYoGJxjDlT0ffZdljlTayHIplE632JkseI4gnYE6wqH7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=QjBUHcUW; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a51c6e91793so563236566b.0
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 00:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712733016; x=1713337816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SZ18eCyb0XZAICmBnfaeK08LTmFa9T66gJC4R8KSh1g=;
        b=QjBUHcUWsg5aBfO24tD4F8EiCQ3cwjhXz0vrMi5nC4zr4V16fB/f9+3b+KVCHdHBK7
         IofMsxkORXwX2iE7PeMEE514AA+V5XYnyM8/mYJFj9pHRGm1eO//I42XpSLiZGHZgFpj
         tDKaH01ObaxVZqJ6n8Oz2AjxWoMoLWHH2I+KuOxEi3Sj8S+45SejNK8kETCUi7okcmzL
         wjcKqfdAlOR61ORevVzgSqMOQrXvBn7EF13uxcO0yncSMfknArV/ElXVMIXCyPaopdhb
         dlhoJzAvXU7+oyD5GJIm++tIRleYlnqsbVWIl0Dp+ULr/z1cyFZiaTVxrxXJCfLCFur+
         3yEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712733016; x=1713337816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZ18eCyb0XZAICmBnfaeK08LTmFa9T66gJC4R8KSh1g=;
        b=T0P3PvSZKvxmKlFfTHmSR2aEfurm4dRI6REjGwtQpq9bLU38djoiJjFMc9CEEbOkvg
         FnG7GpJOj/c+d81YBrqcuz6N/mFNh7AIaXreVEJhNs3qZwv8I7+08j86C83+LHyN8yHu
         QxfoxoHua5Uzl43QhNtEMxqtCJ0CjgNQXPOih8Av7gSFKEhFPzbdbg5/y6RmvsaNUQqh
         KT3yCTawNtWqkia2/nNHq91Lp5Q4VxR5XoYL21po1eKYuSqrGl+OUR9tu6CIoYYoWwEf
         DNep1YtrKtEZnsmzPyEcNm2C/rSvTADowYTovfjVFq8ddQvyiwuyeTiD4txmGNbd//Be
         LeVA==
X-Forwarded-Encrypted: i=1; AJvYcCXnRHK9NxuTpgjzOg7PU8+HbHi3nwaTN0O9y77j0+8G0iipjpDvfpPZ3xcvraky3UqWoCUyTudS7opbU0Dfdke+bvFcNAsFry09ocqdNyuh
X-Gm-Message-State: AOJu0YyTIpfPShla1+P4W0Bkp35jHBWYh5T7+9mW8C8ynqwrRhQLXxwD
	bsZIkn/UMFoBfv2AeMiCv/9v6j3aSTinB6inT1bTqcKj+Kk/dFQjXqfX6n+gslY=
X-Google-Smtp-Source: AGHT+IFxljZJ08Uz0yhQgpMjKNeXFWA7BWx83bzmmJAW4p2u+kQE1tRwcsho9/acuSekX0UatVujKg==
X-Received: by 2002:a17:906:2844:b0:a52:a25:2077 with SMTP id s4-20020a170906284400b00a520a252077mr982535ejc.14.1712733015975;
        Wed, 10 Apr 2024 00:10:15 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id l15-20020a170906414f00b00a519de61bebsm6612955ejk.137.2024.04.10.00.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 00:10:15 -0700 (PDT)
Date: Wed, 10 Apr 2024 09:10:14 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>, 
	Ajay Kaher <akaher@vmware.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Alexey Makhalov <amakhalov@vmware.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v5 21/22] KVM: riscv: selftests: Add a test for PMU
 snapshot functionality
Message-ID: <20240410-2a41e43624596a442d6a95cd@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-22-atishp@rivosinc.com>
 <20240405-4e840120e8117c286cb593f9@orel>
 <8748dbed-d105-4f26-a808-667c3b56c8ec@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8748dbed-d105-4f26-a808-667c3b56c8ec@rivosinc.com>

On Tue, Apr 09, 2024 at 03:52:40PM -0700, Atish Patra wrote:
> On 4/5/24 06:11, Andrew Jones wrote:
> > On Wed, Apr 03, 2024 at 01:04:50AM -0700, Atish Patra wrote:
...
> > > +	probe = guest_sbi_probe_extension(SBI_EXT_PMU, &out_val);
> > > +	GUEST_ASSERT(probe && out_val == 1);
> > > +
> > > +	if (get_host_sbi_spec_version() < sbi_mk_version(2, 0))
> > > +		__GUEST_ASSERT(0, "SBI implementation version doesn't support PMU Snapshot");
> > > +}
> > 
> > It's a pity we can't check the SBI spec version that KVM is advertising
> > from KVM userspace. Normally we'd want to check something like this at
> > the start of the test with TEST_REQUIRE() before running a VCPU in order
> > to generate a skip exit.
> > 
> 
> Agreed. I will send a separate series for that as it is an ABI change.
> 
> > (We probably should allow reading and even writing the SBI spec version
> > from the VMM in order to better support migration.)
> > 
> 
> How that would work for SBI spec version write use case ? For migraiton, you
> can't go back to older SBI versions in the host. Isn't it ?
> 
> Considering this case your VM is running with PMU snapshot as the host has
> SBI v2.0. It can't be migrated to v1.0 and expecting it work. Correct ?
>

We can start a VM on a host with SBI v2.0, but tell KVM to tell the VM
that it has v1.0. Then, the guest shouldn't use any features from SBI
that appear after v1.0 and it should be safe to migrate to a host with
v1.0.

A more likely scenario might be this though:

 1. KVM userspace checks and captures the SBI version of the host where
    the VM is first being launched, e.g. v2.0
 2. The VM gets migrated to another host which supports something later,
    e.g. v3.0, but to
    - avoid possibly confusing the guest we tell the destination host
      that it should expose v2.0 as the SBI version
    - allow rollback to the source host without concern that the guest
      has already seen v3.0 and started to use something that the
      source can't provide

Thanks,
drew

