Return-Path: <linux-kselftest+bounces-39304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EBEB2C0D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 13:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9F93BC087
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 11:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B48132BF49;
	Tue, 19 Aug 2025 11:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="hDhu1/au"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E79922A4D5
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603790; cv=none; b=af75JD9CYxlO7KfXH6ofcERBS0FJ3sPC0Zj0TKniziPP7NnAsx2hW5E9iiQC2GxCWrsS+vEwDxvT9x+8VdnV6iQ+AENtIH030zE00fyYzRzD39SBXuaWd631BkqMK24ItVRWCvIvQ8Q5+7Cm3ETMPE6d/5+sYGRbkueenGUFTZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603790; c=relaxed/simple;
	bh=BEkXZbKZI8TKL4ijyPDPqNlemvC4CN/UmF+QlhyIGA8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=on+ueIJmKG01VJngf2F8pm+jv9pe4rCFBPoZB/pjl3Z12290kkCdIyVZClCC/N+7lVBCotjGPZ7jfLZ4s3nzja0CtxlsFtPK2r79jtoWd/Bs2z6g91aUV0uIN9QlOsIZLL8PtFkB98l/rH9Ip0PYYR6cszfSofVLGKotrOFzARA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=hDhu1/au; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b9e410dbe2so536609f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 04:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755603787; x=1756208587; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/0raNw155Q0fcr5A7DH7DOXoru7hdxKmPbmEOTm5zY=;
        b=hDhu1/auM9LL++8WDau9ZMs3myAyYC0n7Ijf3nCG4Dw25+iRmsLsICFLGNeaYnvd+6
         tjeLJrfkzmrrHfuIgfKqzGlMPKIudgo/WWCvr/cAMtbE0WUMGT7Aoa3kF0XADBuPv7DM
         i8+hxV6aLDZpr/hEJiTpyktWafEqYInWqNSV9PXMPkjLv8WSk3mj55W/jewaSPRzf69U
         omnZNTwe/vQlk2uBcNU2CQ2TyblVJ4UqABcSra9qIlj/SKaM1+K/uVgOw1MsDhjJhTrX
         T5XUwt3TM4RWiLOx7jbGaMD3TFseL+YTMFxqgFNbRN1M1woDdrlgyZO7tF1ImaVJXD4d
         2H0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755603787; x=1756208587;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J/0raNw155Q0fcr5A7DH7DOXoru7hdxKmPbmEOTm5zY=;
        b=mRFOSPmC/dOUkw/JGe7+k+bTDZFP7l2wQh5MHwXePnaqQFkHMocQw5TKedATFvk44n
         by1+ZobseHJdcHokicqGgftMa/BnAHjfSr6F/TlzgopbifdlFOeZkJyg3kXMwW1aXax9
         KrJjZJJf/H9Ck3dQjMXw0xC9zqnkxay74goltFoaRs58eb9KriQrCsm1iKo8O1scBfbm
         pI0MZcIIFHc/VBAPpUKTqpqBjZehr0St3xeV0ZwP3rhWB6/bbXRr8gJLtnjnsTb6vNjC
         gqh8IGDMlyMrTJT8WfSgQx7KmEi3aWjYeCoktG6T/JmU1B+AmrH1Hk+los8jFQ1Pc9Er
         VjwA==
X-Forwarded-Encrypted: i=1; AJvYcCUdAoUCXtDooYUPMCaq5mXd9KwX6+3YXWxb5ou48Gg6qu6vdA2A3ApHHDhFuiu+w7Z+IbOlHRDSCvvfmNcy5Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGEcACJbWL9S4ZJAwh4PT+6fWCABoAfk+5vyOxwIBrXm69/Lur
	nxC00KgqQND4Dh8RFomP0FRV8N4fpd/U2NerZLIZtIbjzjoSWvtJuvxKO4OYjwUud3w=
X-Gm-Gg: ASbGnctQ/aYR/4taPsNubsaJl73ajIj++Zu+kx2LnZUGJiWwv86uh30N04bbDctLfWi
	FR5UVwteD+6JEqT0q/tXaFobjv9jEcUZiG6SiomxV41EGz1IFNg1lawwKriRlLUVIbmz2XdNSdy
	3cGBGA2e3tn70G3zacbdOOlRiM3TLJdmUAn5AbCMSABKzxeDv1TKj91wdb+xjPC3ECn1bnjD/3l
	yMUrbe4V3fiBgxIfMJqVTD3PBwdoEgExnlMejmxG1nvimOfZ3AoDh/QGCygznD2X/OIYhYxD7BS
	nUrUBDmx0XBLNCeGzLxIjSELdaYG43WB8dUBd+mdVj238i8lHs8/YBTxDy5ZClCSzDb9F7Es4Va
	OlSXdvu2Kao4+qlqfsRcmJRpfBhpEig==
X-Google-Smtp-Source: AGHT+IE0FoFnrqv/364y0JxojzjSjgxBxkWPcaMoaWDVaVYQ/OrVds62/XTIFpn7j8AxOXLMQWkHNw==
X-Received: by 2002:a05:600c:c169:b0:459:d7c4:9e14 with SMTP id 5b1f17b1804b1-45b43e85f3bmr9440455e9.0.1755603786493;
        Tue, 19 Aug 2025 04:43:06 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:e7d6:daad:8c97:a08e])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a1cda0021sm207509385e9.13.2025.08.19.04.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 04:43:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Aug 2025 13:43:05 +0200
Message-Id: <DC6DLP13J0LA.XW9J3XFBCM1Y@ventanamicro.com>
Subject: Re: [PATCH 0/6] ONE_REG interface for SBI FWFT extension
Cc: "Atish Patra" <atish.patra@linux.dev>, "Palmer Dabbelt"
 <palmer@dabbelt.com>, "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Alexandre Ghiti" <alex@ghiti.fr>, "Andrew Jones"
 <ajones@ventanamicro.com>, "Anup Patel" <anup@brainfault.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, "Shuah Khan" <shuah@kernel.org>,
 <kvm@vger.kernel.org>, <kvm-riscv@lists.infradead.org>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
To: "Anup Patel" <apatel@ventanamicro.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20250814155548.457172-1-apatel@ventanamicro.com>
 <DC5HEJRMZ84K.34OPU922A7XBE@ventanamicro.com>
 <CAK9=C2X8-DBi7qQ87kMA0AiVdiFH0_4L4mzzZzbeCg2eiNm8Qg@mail.gmail.com>
In-Reply-To: <CAK9=C2X8-DBi7qQ87kMA0AiVdiFH0_4L4mzzZzbeCg2eiNm8Qg@mail.gmail.com>

2025-08-19T12:00:43+05:30, Anup Patel <apatel@ventanamicro.com>:
> On Mon, Aug 18, 2025 at 3:59=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrc=
mar@ventanamicro.com> wrote:
>>
>> 2025-08-14T21:25:42+05:30, Anup Patel <apatel@ventanamicro.com>:
>> > This series adds ONE_REG interface for SBI FWFT extension implemented
>> > by KVM RISC-V.
>>
>> I think it would be better to ONE_REG the CSRs (medeleg/menvcfg), or at
>> least expose their CSR fields (each sensible medeleg bit, PMM, ...)
>> through kvm_riscv_config, than to couple this with SBI/FWFT.
>>
>> The controlled behavior is defined by the ISA, and userspace might want
>> to configure the S-mode execution environment even when SBI/FWFT is not
>> present, which is not possible with the current design.
>>
>> Is there a benefit in expressing the ISA model through SBI/FWFT?
>>
>
> Exposing medeleg/menvcfg is not the right approach because a
> Guest/VM does not have M-mode hence it is not appropriate to
> expose m<xyz> CSRs via ONE_REG interface. This also aligns
> with H-extension architecture which does not virtualize M-mode.

We already have mvendorid, marchid, and mipid in kvm_riscv_config.

The virtualized M-mode is userspace+KVM.  (KVM doesn't allow userspace
to configure most things now, but I think we'll have to change that when
getting ready for production.)

> We already had discussions about this in the past.
>
> As such, we have two options. One option is to expose
> hedeleg/henvcfg via kvm_riscv_config and another option
> is to have a separate ONE_REG for each FWFT feature.
>
> Separate ONE_REG registers for each FWFT feature is better
> than directly exposing hedeleg/henvcfg via ONE_REG because:
>
> 1) Once nested virtualization lands, we will be having separate
> hedeleg/henvcfg as part of nested virtualization state of Guest
> which is trap-n-emulated by KVM. The existence of hedeleg/henvcfg
> in kvm_riscv_config and nested virtualization state will only create
> more confusion.

Right, the userspace registers for this can't be called h*.

> 2) Not all bits in hedeleg/henvcfg are used for FWFT since quite
> a few bits are programmed with fixed value based on KVM
> implementation choices (which may change in future).

Yes, we'll want to expose some to userspace.

>                                                      Also,
> things like set_debug_ioctl() change hedeleg at runtime
> which allow KVM user space to decide who takes breakpoint
> traps from Guest/VM.

This is still doable.  The clear hedeleg bit does not have to change the
virtualized behavior -- if the guest is expecting to see breakpoint
traps, then even if userspace+KVM configure the architecture to direct
the traps to the hypervisor, they must then forward the breakpoints that
were supposed to be delivered to the guest.

>                      This means value saved/restored
> through hedeleg/henvcfg in kvm_riscv_config becomes
> specific to the kernel version and specific to host ISA features.

Hedeleg/henvcfg bits do not have to be the same as userspace interface
bits -- KVM always has to distinguish what the userspace wants to
virtualize, and what the KVM changed for its own reasons.

> 3) We anyway need to provide ONE_REG interface to
> save/restore FWFT feature flags so it's better to keep the
> FWFT feature value as part of the same ONE_REG interface.

I think we want to have SBI in userspace (especially for single-shot
ecalls like FWFT).  The userspace implementation will want an interface
to set the ISA bits, and it's very awkward with the proposed design.

Flags can to stay, in case the userpace wants to accelerate FWFT.

> 4) The availability of quite a few FWFT features is dependent
> on corresponding ISA extensions so having separate ONE_REG
> registers of each FWFT feature allows get_reg_list_ioctl() to
> provide KVM user-space only available FWFT feature registers.

Yes, but similarly the userspace would be forbidden from setting bits
that cannot be expressed in henvcfg/hededeg.

There are also behaviors we want to configure that do not have a FWFT
toggle.  e.g. the recent patches for delegation of illegal-instruction
exceptions that changed the guest behavior -- someone might want to
keep incrementing the SBI PMU counter, and someone will want to forward
them to be implemented in userspace (when developing a new extension,
because most of the existing ISA can still be accelerated by KVM).

For general virtualization, we want to be able to configure the
following behavior for each exception that would go to the virtualized
M-mode:
  0) delegated to the guest
  1) implemented by userspace
  2-N) implementations by KVM (ideally zero or one)

We can have medeleg, and another method to decide how to handle trapped
exceptions, but it probably makes more sense to have a per-exception
ONE_REG that sets how each exception behaves.

The FWFT value could be a part of a more general interface.

Thanks.

