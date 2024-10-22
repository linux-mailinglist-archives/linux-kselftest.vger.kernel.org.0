Return-Path: <linux-kselftest+bounces-20400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D459AB1B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 17:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD4222866E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 15:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1DB1A2562;
	Tue, 22 Oct 2024 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XpPwQtiI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64331A00D6
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Oct 2024 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729609718; cv=none; b=IZnMYeqzWdcp36V9FPszcNHxpvrxUA7RCajmCIApMxlt7C/MhGkkt1HKs93XurYkDRLGQwiOknYalAs1XXmsndKdxlO2f2XEi+sOWRnTz47Oz2ZwQXPIyjo70KJn/gikZF3KwueTG4ve/Bv02zWgBebHEWvg0Nzhpe/kwz7bHBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729609718; c=relaxed/simple;
	bh=IVPoKTT/PdKGGjUbgzY5M6CpI8HSyHJLQWK7ISZxKI4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pPTHkNPdIZq1rwH2npzkJdHkyEsthpsBp3no5s7rZeN5+vE+H0sz+DnMW9z56mrZwkfujCFKqgxtnJPoAH8ylmlYA6OiXVX7wNDxoZvo1kn24lLcm5Hr1DGeYeuG77hBIyTMqD2WM+xcMMmzGJgACYO+UEgOKUD5TAhQqL1azTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XpPwQtiI; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7163489149fso5514439a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Oct 2024 08:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729609716; x=1730214516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfLZJa9MIUtHXHwJqxHcWn5oL7MLhSurbcLYJY1Gqig=;
        b=XpPwQtiIE9rfWzV9MZ3wMXaiZDo/l8lpDWV6g0OAlPJ9hru5B1AJwUjrPF8NXiKL4H
         ObLM7J5SBINz0K6x6DBu31zE4YV5LpZTJ2B8zSsp1jDZEjF1Ljw8JO0D6p2Aw+IR8xkX
         VkIwMauVA/e+I+VL83IPBr/LIapoCAPSM//ShIy9S8A+SRFstrXn2Zf/grjjQnQa9fIN
         rmxZ5C8DYTRGS8GOSLEv51Np0FsJjYWejBWoOIeUMB6dcx+SZXIQhrDj8rRyfepYWPPn
         o+239U0YznHg4pZ2YIVZncbLUIzUaLuQPGOdNHgryEopt84ay9hcABcsxORndPLOb3Gt
         oz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729609716; x=1730214516;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SfLZJa9MIUtHXHwJqxHcWn5oL7MLhSurbcLYJY1Gqig=;
        b=NMioyJ6ZPlWuL7uyP2BbetnE6+mXTinZMGuNI+1Bbl+vnqYY0IgF8kvUDWfFntIn9n
         /GaUax82r8qnq4j5/JkdFwlVntuyt8D1iF0yvyBhRrDgjIcbNE0jynsNij5Xe69dR3kH
         ThIMjQfjUZ9rHCCZJ3aKqro3VfQ5/k4Fim6cvkt2YBWP8pTCZSZ/WTBxADp8IyIfnKkr
         +0bqTFy1naXuRdpGYP81U4Fe1fhLKush1JDn6MOmIbonEG200VFqo2er8DAPunVxve2Z
         SfqEc9mOp6xiBZ6gDYXPK7Y6BAd20OaZeiS88xa2lZSGbZJf/inuRM96+4hS7+wCrxMk
         t4hw==
X-Forwarded-Encrypted: i=1; AJvYcCUHaY9CKZnZPguB0CuqxqBYASUur0eboJHK2eq6qSMhmSB28M+2VdN1rAUyAnczBYYsLVnPK7CUgWNllDlr2vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuBTmhb+v34AV+G9QuL0ewKQKIFGvCdP/PyI29uUABgovyYs6D
	U26kne34HsLkqN0V82kUhfGKEHbiag3jj7e4w5U2zw75FKOzP+0QH9kNXThEsIJnHep6+jg2v5s
	QxQ==
X-Google-Smtp-Source: AGHT+IFWMPUjcgioCdVgKaSR3yYj7Z65E9xYGDW9uxj82uAg7VT0m8AW8MLuOVrKTVrqo3KoopcOf0PONGc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:90a:984:b0:2e3:8136:3e78 with SMTP id
 98e67ed59e1d1-2e5615dec74mr58548a91.2.1729609715986; Tue, 22 Oct 2024
 08:08:35 -0700 (PDT)
Date: Tue, 22 Oct 2024 08:08:34 -0700
In-Reply-To: <20241022093236.GAZxdxNCTki88ttFmy@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022054810.23369-1-manali.shukla@amd.com> <20241022054810.23369-2-manali.shukla@amd.com>
 <20241022093236.GAZxdxNCTki88ttFmy@fat_crate.local>
Message-ID: <Zxe-lhHmVUz-8lYw@google.com>
Subject: Re: [PATCH v4 1/4] x86/cpufeatures: Add CPUID feature bit for Idle
 HLT intercept
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Manali Shukla <manali.shukla@amd.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org, 
	nikunj@amd.com, thomas.lendacky@amd.com, vkuznets@redhat.com, 
	babu.moger@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024, Borislav Petkov wrote:
> On Tue, Oct 22, 2024 at 05:48:07AM +0000, Manali Shukla wrote:
> > From: Manali Shukla <Manali.Shukla@amd.com>
> >=20
> > The Idle HLT Intercept feature allows for the HLT instruction
> > execution by a vCPU to be intercepted by the hypervisor only if there
> > are no pending events (V_INTR and V_NMI) for the vCPU. When the vCPU
> > is expected to service the pending events (V_INTR and V_NMI), the Idle
> > HLT intercept won=E2=80=99t trigger. The feature allows the hypervisor =
to
> > determine if the vCPU is idle and reduces wasteful VMEXITs.
> >=20
> > In addition to the aforementioned use case, the Idle HLT intercept
> > feature is also used for enlightened guests who aim to securely manage
> > events without the hypervisor=E2=80=99s awareness. If a HLT occurs whil=
e
> > a virtual event is pending and the hypervisor is unaware of this
> > pending event (as could be the case with enlightened guests), the
> > absence of the Idle HLT intercept feature could result in a vCPU being
> > suspended indefinitely.
> >=20
> > Presence of Idle HLT intercept feature for guests is indicated via CPUI=
D
> > function 0x8000000A_EDX[30].
> >=20
> > Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
> > Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
> > ---
> >  arch/x86/include/asm/cpufeatures.h | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/=
cpufeatures.h
> > index dd4682857c12..7461a49e1045 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -382,6 +382,7 @@
> >  #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* "v_spec_ctrl" Virtual S=
PEC_CTRL */
> >  #define X86_FEATURE_VNMI		(15*32+25) /* "vnmi" Virtual NMI */
> >  #define X86_FEATURE_SVME_ADDR_CHK	(15*32+28) /* SVME addr check */
> > +#define X86_FEATURE_IDLE_HLT		(15*32+30) /* "" IDLE HLT intercept */
>=20
> Whoever commits this, you can remove the "" in the comment now as they're=
 not
> needed anymore.

Ya, will do.

