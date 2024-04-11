Return-Path: <linux-kselftest+bounces-7681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5AA8A0A1C
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 09:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7E61C2100F
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 07:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288AF13E888;
	Thu, 11 Apr 2024 07:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="PyXZMQnv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E7213E40C
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 07:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821126; cv=none; b=i0TSUWhzEN7q4o3TfCCXQmyW/cJtvjXMEaBoB6gosJi9N1y1I4q4Jj37Iv6PLaAoK4zM8iRnNFA8SX618y1CeXnwivdmyxzlzvzOMEg6MdPPb00W2J7julDm4jA32p+4NKMDE1kEyY9QBJTRCAaQmBGSfYEKucNaulFu3yySlc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821126; c=relaxed/simple;
	bh=1vkXgr7mU8ODetSlTUd524GtmWxMzUtCT+xXdKXnC+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2lrlw2xcNoVFnx69oJ2GvzSxOLgEydL2mfHP8i6/7C/JgamqYEhGa7nK+6L2YNGqfX/utrPz+HOkDuKKux6hFg2lGJlnRAZil/huBf9WC8NJlNgWHsho2TDYONu+bcTO3TomBJVBVMcp6QQa/iNAnXMkA5gJQv6DDEid24Pi+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=PyXZMQnv; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a5224dfa9adso28263766b.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 00:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712821122; x=1713425922; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qi1RHVmEtAvgNYlK/Z30HZoUwL3LvYqcc/16dHeni2I=;
        b=PyXZMQnv7q/B4067/6mgaOEdkORETeuEB3mvFDQ4A0rKtG2pvW2uRyba18ydAUoWmM
         6AUgOfSAYS1UorUFUhBo88UfWUOA2xPYmi84UgPQMJxKYo/pykINfEuKLiyx4crR14fq
         nUsk5eUgBVGU0QsugfbOyQ/WLxwRXxSQ9R6LbXqY8vRueJpePn4WFi9FK1G/VbwYZ/kC
         VL5z1uE86679A0/BxlJIegJiLKMFt9oiA/SVNS3bdtfbrdfDdzdiKJuwgVPqcp8gdLDY
         6S5qVnuyXtGd5ztBBL+ddfBQJmMQDmN1rYIlemg1I41JRAWPSP33boe+WKqaXHAPp5Xm
         rEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712821122; x=1713425922;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qi1RHVmEtAvgNYlK/Z30HZoUwL3LvYqcc/16dHeni2I=;
        b=GJSCTHow1oIvZxpht8IVUQFavWggc2T40GeXKG0egkWxcDOLe/tJXpghKyR9v9z6H9
         YyjTi6bek0a5JW02Rt0J6DSASKspW+NqSgVyxUkhBWdpYWcGyIQNiV4M4YFS4Z+0Q6DJ
         IPNiUV7cPAfiOmCoopdol8ybFvOKqSoLd5Mas/8jd8BWx9VV6VzL0uVMVpvZbeuHK/7k
         2oKqh55x7fqNpiK96P3asYXMHVEgKSulo+rJQKidGI67PpNvvPEBu9XuimP8GrphU6Mr
         nBopMHGWUY2vtKIwN17KF/rXtoOQBXk9AAMtI4fu22z8NM7QNorK4IjzlyjX26vMHXD6
         /grg==
X-Forwarded-Encrypted: i=1; AJvYcCW/OTX8kF7VWy204xgaBdvhOToNgFbVT5ZqD6l+3Sn7S7qRFmrjzh4Pyp6DQdzCL9jwhbgkvtSC55o+WCDxbh9JjAIOJnKBF/wzgu+Nl6QH
X-Gm-Message-State: AOJu0YysY6O+ehioDMJBQrujgbyUhFWMOZdC/YszdIy8fY2LdbgiTjKG
	0rK5tKBGoYzeZlJ4i8E3/jWFx2MIVsNG/PtLSn7vPngB1igkn7xCiFZ9kZR01RI=
X-Google-Smtp-Source: AGHT+IHndxelT9zzrPtEEf61xurR5ZhY/uXW2mp7zI7XhBJBneHaSOP3oqNpAKZ/ndwpR0RWwH9wFg==
X-Received: by 2002:a17:907:1c2a:b0:a4e:410e:9525 with SMTP id nc42-20020a1709071c2a00b00a4e410e9525mr1764454ejc.30.1712821122486;
        Thu, 11 Apr 2024 00:38:42 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id gv7-20020a170906f10700b00a4e0df9e793sm478233ejb.136.2024.04.11.00.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 00:38:42 -0700 (PDT)
Date: Thu, 11 Apr 2024 09:38:41 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: Atish Patra <atishp@atishpatra.org>, linux-kernel@vger.kernel.org, 
	Anup Patel <anup@brainfault.org>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 07/15] RISC-V: KVM: No need to exit to the user space
 if perf event failed
Message-ID: <20240411-6fe47ccc32d9cb7baa121b4d@orel>
References: <20240229010130.1380926-1-atishp@rivosinc.com>
 <20240229010130.1380926-8-atishp@rivosinc.com>
 <20240302-1a3c0df25f2422e1e6abecf3@orel>
 <CAOnJCUJCQjBfLZFW-3iLUB6ygyRmz1Anu+fhfrT4Lpoj2iNB5Q@mail.gmail.com>
 <20240404-ea40bc0237635d671e64fef6@orel>
 <7d02c86e-8c36-4e78-9fa8-5e30f3431eb3@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d02c86e-8c36-4e78-9fa8-5e30f3431eb3@rivosinc.com>

On Wed, Apr 10, 2024 at 03:44:32PM -0700, Atish Patra wrote:
> On 4/4/24 05:16, Andrew Jones wrote:
> > On Mon, Apr 01, 2024 at 03:37:01PM -0700, Atish Patra wrote:
> > > On Sat, Mar 2, 2024 at 12:16 AM Andrew Jones <ajones@ventanamicro.com> wrote:
> > > > 
> > > > On Wed, Feb 28, 2024 at 05:01:22PM -0800, Atish Patra wrote:
> > > > > Currently, we return a linux error code if creating a perf event failed
> > > > > in kvm. That shouldn't be necessary as guest can continue to operate
> > > > > without perf profiling or profiling with firmware counters.
> > > > > 
> > > > > Return appropriate SBI error code to indicate that PMU configuration
> > > > > failed. An error message in kvm already describes the reason for failure.
> > > > 
> > > > I don't know enough about the perf subsystem to know if there may be
> > > > a concern that resources are temporarily unavailable. If so, then this
> > > 
> > > Do you mean the hardware resources unavailable because the host is using it ?
> > 
> > Yes (I think). The issue I'm thinking of is if kvm_pmu_create_perf_event
> > (perf_event_create_kernel_counter) returns something like EBUSY and then
> > we translate that to SBI_ERR_NOT_SUPPORTED. I'm not sure guests would
> > interpret not-supported as an error which means they can retry. Or if
> > they retry and get something other than not-supported if they'd be
> > confused.
> > 
> 
> At least in Linux driver, treats -ENOTSUPP and it just fails. Other guest OS
> implementation may interpret it differently. But they should fail at that
> point as well. I don't see how can they interpret to be retry.
> 
> The perf user can retry again with assumption that may be enough counters
> are not available at this moment. But that's different from return a retry
> from driver code.
> 
> Even if we support a retry error code, when does the caller retry it ?
> The driver doesn't know how long the user is going to run the perf command
> to keep the hardware resources occupied.
> 
> I feel the perf user is the best entity to know that and should retry if it
> knows the previous run is over which might have released the hardware
> resources.

I agree, but how does the user know that retrying makes sense? I presume
-ENOTSUPP will get propagated all the way to the user in a form that
means "not supported". Or, can the user list all resources and then
when they see "not supported" know that means "not supported at the
moment", as they've already seen that the resources exist?

Anyway, as I said, I don't know enough about the perf subsystem to know
if this is a real concern or not, but it sort of looks like we have
potential to tell users that something isn't supported when in fact it
is supported, but only temporarily unavailable.

Thanks,
drew

