Return-Path: <linux-kselftest+bounces-8102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172DA8A6670
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 10:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7191C209F3
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 08:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C3486244;
	Tue, 16 Apr 2024 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ZTe5AX4x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B5C85C7B
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713257365; cv=none; b=gv6ICw206hIV2yiz/6I1Pc9F2KZK0+QXECMeAweEQ30nJENWQhQjaxSKGrWygJtX8u1Bws7+dsVT1Ccwj5qgfhTS8xACqkwGfwhR/6Kan/kuBHlaCsYgsXJ+pKx4dorb7Hxea62pAIGh9LymmE8/ws+gFuFoW2x2FA0DRtiwcOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713257365; c=relaxed/simple;
	bh=9xIdHRnzV2O632j4RhG1uswWHNVqgDuU4PlluAj30g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsBEIcdFgXxlCydRckA2s+nEIRmL63FGbb2vv8BPqMSc6q5CWPe6XF4vGtnlOXAFqp6e6Q8UM5FJnRfYViUExo8b0Izyl5MbciHHcuR/k6uiw/G3SHNFNDcMOdoBFjL5bqhRp5LmNxlw26JmzP7lhpcerccrdKkzk6BSt+5yOGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ZTe5AX4x; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4185e80adfbso9820615e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 01:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713257362; x=1713862162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mvwae8C2beujv4aHEun0iITe/+EHhljfurmTw9uDoMY=;
        b=ZTe5AX4xwmAR8IG3HCcGKiIqwQqB7rbG7WDYiHrMBLtv+a0L8FGslnmtISDyP2uOQI
         oSlg0k+HcvlOxURWAlKkN78vqGHfgM9d+SRJ+LjOeQ2X2XUkvvDTUT91OBm09TB/La21
         0GZuUX/9HsSKkIMsjUtkEgsVw5nGKWlygd/DiZZj7Ba4k1FQ2WyBw3vXlOqyZMmXM5G+
         OlRZDR4kIHJCA53j06nFShBD1adRN/9TBfUCiAE2wEPROUzphpSceRdgWVvC3ldq3Eu0
         IhD0iX8MjHU1oCZpcJIWQ9zY1irel5pyu0ckVMAjdqlX2Hxi84DHbRu2ZUIKr4YBYhxu
         hLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713257362; x=1713862162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvwae8C2beujv4aHEun0iITe/+EHhljfurmTw9uDoMY=;
        b=taiTGO4YB4thMKKFmEvKSASKCFvGFFxa7OQL3zjdH926sazgKA0Zf5Lj62PPW7NU0o
         L/9ZWESxQCs0dSZS57JCLVxywlTFuywiXuxdqK0x4vNZcSaK99an/Ruh08IMnjNWc5Mq
         0Gf0WtTS3aftyUxuUng6vUWnxEpqinJ9qrHZX/iae40X8zncrsU+Ty7xrhOZE+EfUhBO
         EhW+olaAvTnqySdtSmQ5pZgCXAEvrnFNl/CCi8YJIoHzSmSH0qq98KdDrBdYHJCZcx8l
         GSwPzMSe4lda492dymTumwon8UYGnIWoTrwvZbuS9knq4BB/OU1txZDciHX6XbqoCUM6
         IAVg==
X-Forwarded-Encrypted: i=1; AJvYcCXypm+Vk5Kx9ZiwT9n9R0KfBMRVkcXCboJWzyhXA8/rgq15aaa2mUPEycxcDotgKYwcSNFO4BtnJ/FR+vS2q+lscSbZV3ZEL2wvCHDYuOi/
X-Gm-Message-State: AOJu0YwlEdIzIKvhdmadS0A28K+k81hoCQ23ydveLGuSK/y74n3F6i2V
	TBdm0Ic9GRqShte3M+SVh50ruLJGCMVZWVQ3m0gkdxHFMYQdmDHH+sXBykHCQuk=
X-Google-Smtp-Source: AGHT+IERQO7yDpvVx0Ze29NzNiatXbTnAhDW6vGus8ihCC8tUM3/GY995t+6Bsj2kugS44iI1F1GAA==
X-Received: by 2002:a05:600c:45d0:b0:416:3317:5951 with SMTP id s16-20020a05600c45d000b0041633175951mr8879758wmo.6.1713257362109;
        Tue, 16 Apr 2024 01:49:22 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id l16-20020a05600c4f1000b00418729383a4sm5208029wmq.46.2024.04.16.01.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 01:49:21 -0700 (PDT)
Date: Tue, 16 Apr 2024 10:49:20 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Alexey Makhalov <alexey.amakhalov@broadcom.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, Will Deacon <will@kernel.org>, 
	x86@kernel.org
Subject: Re: [PATCH v6 07/24] RISC-V: Use the minor version mask while
 computing sbi version
Message-ID: <20240416-1a9f7ea9700c4c6c3e52a1b1@orel>
References: <20240411000752.955910-1-atishp@rivosinc.com>
 <20240411000752.955910-8-atishp@rivosinc.com>
 <20240415-e229bb33ad53ce43e3534f5a@orel>
 <2a63d7da-91b6-496d-9966-e6c0a0aa6c6c@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a63d7da-91b6-496d-9966-e6c0a0aa6c6c@rivosinc.com>

On Tue, Apr 16, 2024 at 01:31:27AM -0700, Atish Patra wrote:
> On 4/15/24 06:06, Andrew Jones wrote:
> > On Wed, Apr 10, 2024 at 05:07:35PM -0700, Atish Patra wrote:
> > > As per the SBI specification, minor version is encoded in the
> > > lower 24 bits only. Make sure that the SBI version is computed
> > > with the appropriate mask.
> > > 
> > > Currently, there is no minor version in use. Thus, it doesn't
> > > change anything functionality but it is good to be compliant with
> > > the specification.
> > > 
> > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > > ---
> > >   arch/riscv/include/asm/sbi.h | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> > > index f31650b10899..935b082d6a6c 100644
> > > --- a/arch/riscv/include/asm/sbi.h
> > > +++ b/arch/riscv/include/asm/sbi.h
> > > @@ -367,8 +367,8 @@ static inline unsigned long sbi_minor_version(void)
> > >   static inline unsigned long sbi_mk_version(unsigned long major,
> > >   					    unsigned long minor)
> > >   {
> > > -	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) <<
> > > -		SBI_SPEC_VERSION_MAJOR_SHIFT) | minor;
> > > +	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) << SBI_SPEC_VERSION_MAJOR_SHIFT
> > > +		| (minor & SBI_SPEC_VERSION_MINOR_MASK));
> > 
> > The previous version had ((major & major_mask) << major_shift) | minor
> > (parentheses around all the major bits before the OR). Now we have
> > parentheses around everything, which aren't necessary, and no longer
> 
> We have to use parentheses around | to avoid compiler warnings
> (-Wparentheses)
> 
> Are you only concerned about the outer parentheses ? I have removed it.
> 
> > have them around all the major bits before the OR. We don't need the
> > parentheses around the major bits, since shift has higher precedence
> > than OR, but I'd probably keep them.
> > 
> 
> Is this what you prefer?
> 
> return ((major & SBI_SPEC_VERSION_MAJOR_MASK) <<
> SBI_SPEC_VERSION_MAJOR_SHIFT) | (minor & SBI_SPEC_VERSION_MINOR_MASK);

Yup

Thanks,
drew

> 
> 
> 
> 
> > Otherwise,
> > 
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > 
> > >   }
> > >   int sbi_err_map_linux_errno(int err);
> > > -- 
> > > 2.34.1
> > > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

