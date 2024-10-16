Return-Path: <linux-kselftest+bounces-19881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 322EF9A1494
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 23:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B38F7B22796
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 21:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAC11C4A28;
	Wed, 16 Oct 2024 21:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VNxerzC6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D8A1B6CF4
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729112757; cv=none; b=HaQHdiMjZPmZwizDQ8vmrzLz9mnsz6HzWxcv+XMAluh8rbiXsaWN5mDBdAiEsZMJ1Gm+uu7+A44AeognHteYsoD6VealrbMWOBxHY3/tYlWrJ2a1LakGB06zex6wOoT1TRmvlWrhR3ULRe5V7T3iSEEgURuBc70yf11mC9iffos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729112757; c=relaxed/simple;
	bh=WZW00TKTaoemSd6JPBFYlmG2IMjRqCAXZEuW81RfWK8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d2fbpuQicQfDyA4QTcDTBnzKn+jSkiPuDsG6SBsfzMWVAS/TDJIhmQ+R0TczPmUkLY79j8PryOOEk1bQNZGqRBUG2FuZ8ayQ2KTTVBWUzEse5//f6yKKQoOeDcC9A0fLWUiIshdMn5VTekzdyiNbTKjJOmfgG6BR1tAckPSlTRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VNxerzC6; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e35d1d8c82so5925987b3.3
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 14:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729112755; x=1729717555; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mc2AnrLM2UF0S090yPZTAZNfP2OSi9FUUhZDFa9DYsQ=;
        b=VNxerzC6t86Yym04K1aLDj6fmY8rvympoix6EPXdefK7Kk8UuWLz85DhDdQwBigCC6
         BziXr/ASvqBnecGBfYUhwOuiMsGGH6oWN9bnRp8354Dz/BbneCVB0HN2I0e1SZgBFr06
         WyILTpfQeX7z4t0NgKadFfyAu2dWQFNmDAo41XpBCg4PX7xsaBMpWj5p8POgSlAXMC5b
         25yGOmc7sZjyNdk8P5sr/Tjs7lcgAjjksfQDc/chg/TxvVHtoiTHeDH1uT0GMmx22gl8
         JFFrrcL5aM4auvQ4X8OpSfXzTw4vY6vX572Zg2LH+d2Pn7e9xgHUYaar2h5nOtpgQhQM
         uKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729112755; x=1729717555;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mc2AnrLM2UF0S090yPZTAZNfP2OSi9FUUhZDFa9DYsQ=;
        b=VIvII3utXNwpHER4zHeDUyeiv0M2YVxwuQx5FvH2m63PbxJsbe+C7OSTDyDh1yvs2H
         roTDBejGtgBOZRJ7eEWCQfpcIfbzaPT0JUW+ky/7vmEzYiolIQeUaFiSL41y5KNp5X20
         y7pxo/F1CM7sxwmjSXS/tkhdpy5vS0WURvTp56Mq4xg4481U3CAgLXTMrgiJnNVdE5iZ
         Rt3w1UnqTXzAj6lFRAAo7eBgu3wQBY7VN9tGDtR4st+SmyX6MxnMeZBJvsnEyYN5NUrj
         1+7R0Y7wiGwSBgupkDuL3yz6WLoTHciujJX5EtnYFkWBB+L/X5hBzyEfuwtoDpYFXYKu
         rgmA==
X-Forwarded-Encrypted: i=1; AJvYcCUhBEV1bs9BFbowXI46C5EpnoaY8tvANR1lkEE4MXp6nubf8fsIFHMQPFmBFnjIz9n4dW4BUo/20tkxJgvxRU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV5XVrHspChaHTQh/xcQtcUyJVZkk2UBj5ql4oR/Z7Rpi7PgdR
	rIcBz+9ysqxuBoSMZEoj6euoczTcI8yNjAJ2BYYpy7RmiyzVuE853caW92CRgLeYp/X0ferunVf
	oMw==
X-Google-Smtp-Source: AGHT+IGkf38vmY/wJdMjW1LCURxYE7Ec+J9yr0i/d8iGrua/q+lp0G6QiUUZJgyY0LEomNIZeY0ALfUpKv0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:f407:0:b0:e1a:6bf9:aa83 with SMTP id
 3f1490d57ef6-e29782d5fa6mr5916276.3.1729112755243; Wed, 16 Oct 2024 14:05:55
 -0700 (PDT)
Date: Wed, 16 Oct 2024 14:05:53 -0700
In-Reply-To: <20241015195227.GA18617@dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240927161657.68110-1-iorlov@amazon.com> <20240927161657.68110-2-iorlov@amazon.com>
 <Zwmyzg5WiKKvySS1@google.com> <20241015195227.GA18617@dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com>
Message-ID: <ZxAqscbrROD1_szG@google.com>
Subject: Re: [PATCH 1/3] KVM: x86, vmx: Add function for event delivery error generation
From: Sean Christopherson <seanjc@google.com>
To: Ivan Orlov <iorlov@amazon.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com, 
	pbonzini@redhat.com, shuah@kernel.org, tglx@linutronix.de, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org, jalliste@amazon.com, 
	nh-open-source@amazon.com, pdurrant@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 15, 2024, Ivan Orlov wrote:
> > > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > > index c67e448c6ebd..afd785e7f3a3 100644
> > > --- a/arch/x86/kvm/vmx/vmx.c
> > > +++ b/arch/x86/kvm/vmx/vmx.c
> > > @@ -6550,19 +6550,10 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
> > >  	     exit_reason.basic != EXIT_REASON_APIC_ACCESS &&
> > >  	     exit_reason.basic != EXIT_REASON_TASK_SWITCH &&
> > >  	     exit_reason.basic != EXIT_REASON_NOTIFY)) {
> > > -		int ndata = 3;
> > > +		gpa_t gpa = vmcs_read64(GUEST_PHYSICAL_ADDRESS);
> > > +		bool is_mmio = exit_reason.basic == EXIT_REASON_EPT_MISCONFIG;
> > 
> > There's no need for is_mmio, just pass INVALID_GPA when the GPA isn't known.
> 
> Ah alright, then we definitely don't need an is_mmio field. I assume we
> can't do MMIO at GPA=0, right?

Wrong :-)

From an architectural perspective, GPA=0 is not special in any way.  E.g. prior
to L1TF, Linux would happily use the page with PFN=0.

