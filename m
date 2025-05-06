Return-Path: <linux-kselftest+bounces-32511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 537B2AAC6D8
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 15:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579743B7C3A
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 13:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A45281341;
	Tue,  6 May 2025 13:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I5R7RpsL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB561A08DB
	for <linux-kselftest@vger.kernel.org>; Tue,  6 May 2025 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539213; cv=none; b=uLNIkP33dtz/pSelf1PqrM1wlgvZajcYLbSrlNL1BVp5EkjJeRXTIQW/qioKUeJd/TZ1o3B+OkG9+hX7qi+3SwzKtsxitmLcgNIZoiNAHYWx3WzVmZZf1bQJB3w2ixRizr4YrxL1UaLHztnxoqoZUGRd1nZxaXLQ+WTdbaDvyqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539213; c=relaxed/simple;
	bh=ZLyUWVGxg9mrrO7r5vzX+fzEqwROgV3Odq3dd0jP07g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h8vLqezarrXI1VIu+cUs+CxFWQtXPbzCzINejnFg20XFJZ1T19UmrqCLkS3NbRIn4JB52vm0Tih4yhxCweE897y6PGabqVFxd133Ldw9Q9GOqhT4Yjk7RURFnCiK7kvQQvApFprmbNaGxhw/2jdF1KLvj6kiUOXqIr8TGWJykhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I5R7RpsL; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-225505d1ca5so51522565ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 06 May 2025 06:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746539210; x=1747144010; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LQUJg1xdsag4lcsUrEd4LaUAGtstgHq/VhuMBGkni7o=;
        b=I5R7RpsLsgCyODVY7TJDKwLtrD6KpoDhmKsxc0q/3HVpcUqT9MQjueUFAvjE9lA8ks
         oMiMe08x2Uw0YXa41wtx76eTlaIhBplhAlrpbQ0ig/lEp4teXHvqjlkSDkg1IKo8qDHQ
         4x/JM12SyAAku1FBNvGowuyxXgjsiLjsoJPgaeXDqw6/2zKnH2lIyvfkeGbKMu2lm8ST
         87NXeMXhPf2ObDnDchdTAl8BxU1x+dNYNhnL6zbHXVwfs+hJGfBgblykgnYu7wbijZj4
         D9nCGBeL5zUyXgIdDH291ILIrLhnfb1gmrshTG+z/xNMQWrrcWjHCtwmERDbY9I4+g6a
         OqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746539210; x=1747144010;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQUJg1xdsag4lcsUrEd4LaUAGtstgHq/VhuMBGkni7o=;
        b=kMP7eSLvp7l7kwOpPul41jWekeoz9kPgwQapwXEYgym2L5sFRaThBTVq9I5g8Um/5j
         sHWid8771+D95kO3ysJxyd4pXp0heMjIT2ujs31PS0MIwU7TCOArNlNswX4QjmnXfUnE
         0PRAb6QPy8okXqJ2LJMunTw9bmTIMhHGPfwA54DyyqKSxy71UuR8SgcDulHiro9FR+tF
         mFhIEVEZXI8y4gxPBPCndQbxO35UfvxlRnb3NEJIUdaRScIL9q31sXh34u0rfH6rgtFA
         L7nwhLb3lOcoYi19S6tp5lmjI9Tvs6xwPtNeQ0UDu10JjhaxnlMu0nMoDrfripnkAJVT
         iCYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmxG2caAiSw8UoTDxYnz1nUIs6cN+VE0E8MSmqQON2DZlJBD6+E56fKHx40+VcICKv1TxtYrzv/IMY58vbbq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGS54q//g5+KKqKNUynGY+6H5d0AuktEuU6DO3dTXwedkhB3xV
	u6PWY8f5g0sGy/DZjC0F+r60tHcBIkJ7D1Pps8/+L6gIkDytVeGDRBoktN05H6lSzWiWw4FdPOK
	Vyg==
X-Google-Smtp-Source: AGHT+IHsYV+dxxS1ThICcQGbnerUzrCgNQIzKxNK/VWU507udswWRGzpamo7g53Ivg5sJVmAE8gcPACNnXg=
X-Received: from pljs14.prod.google.com ([2002:a17:903:3bae:b0:223:225b:3d83])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:240d:b0:223:66bb:8995
 with SMTP id d9443c01a7336-22e102f3417mr229950135ad.20.1746539210171; Tue, 06
 May 2025 06:46:50 -0700 (PDT)
Date: Tue, 6 May 2025 06:46:47 -0700
In-Reply-To: <09ee8a01-9938-4ae7-bdbc-4754b7314e73@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250305230000.231025-1-prsampat@amd.com> <174622216534.881262.8086472919667553138.b4-ty@google.com>
 <b1cc7366-bd30-46ee-ac6e-35c2b08ffdb5@amd.com> <aBlGp8i_zzGgKeIl@google.com> <09ee8a01-9938-4ae7-bdbc-4754b7314e73@amd.com>
Message-ID: <aBoSx-rAmajPZq07@google.com>
Subject: Re: [PATCH v8 00/10] Basic SEV-SNP Selftests
From: Sean Christopherson <seanjc@google.com>
To: "Pratik R. Sampat" <prsampat@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com, thomas.lendacky@amd.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, shuah@kernel.org, pgonda@google.com, 
	ashish.kalra@amd.com, nikunj@amd.com, pankaj.gupta@amd.com, 
	michael.roth@amd.com, sraithal@amd.com
Content-Type: text/plain; charset="us-ascii"

On Mon, May 05, 2025, Pratik R. Sampat wrote:
> On 5/5/2025 6:15 PM, Sean Christopherson wrote:
> > On Mon, May 05, 2025, Pratik R. Sampat wrote:
> > Argh, now I remember the issue.  But _sev_platform_init_locked() returns '0' if
> > psp_init_on_probe is true, and I don't see how deferring __sev_snp_init_locked()
> > will magically make it succeed the second time around.
> > 
> > So shouldn't the KVM code be this?
> > 
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index e0f446922a6e..dd04f979357d 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -3038,6 +3038,14 @@ void __init sev_hardware_setup(void)
> >         sev_snp_supported = sev_snp_enabled && cc_platform_has(CC_ATTR_HOST_SEV_SNP);
> >  
> >  out:
> > +       if (sev_enabled) {
> > +               init_args.probe = true;
> > +               if (sev_platform_init(&init_args))
> > +                       sev_supported = sev_es_supported = sev_snp_supported = false;
> > +               else
> > +                       sev_snp_supported &= sev_is_snp_initialized();
> > +       }
> > +
> >         if (boot_cpu_has(X86_FEATURE_SEV))
> >                 pr_info("SEV %s (ASIDs %u - %u)\n",
> >                         sev_supported ? min_sev_asid <= max_sev_asid ? "enabled" :
> > @@ -3067,12 +3075,6 @@ void __init sev_hardware_setup(void)
> >  
> >         if (!sev_enabled)
> >                 return;
> > -
> > -       /*
> > -        * Do both SNP and SEV initialization at KVM module load.
> > -        */
> > -       init_args.probe = true;
> > -       sev_platform_init(&init_args);
> >  }
> >  
> >  void sev_hardware_unsetup(void)
> > --
> > 
> 
> I agree with this approach. One thing maybe to consider further is to also call
> into SEV_platform_status() to check for init so that SEV/SEV-ES is not
> penalized and disabled for SNP's failures. Another approach could be to break
> up the SEV and SNP init setup so that we can spare a couple of platform calls
> in the process?

Nah, SNP initialization failure should be a rare occurence, I don't want to make
the "normal" flow more complex just to handle something that should never happen
in practice.

