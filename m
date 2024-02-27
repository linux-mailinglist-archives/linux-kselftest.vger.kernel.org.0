Return-Path: <linux-kselftest+bounces-5466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E028686DF
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 03:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2812A2900B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 02:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6E654BDF;
	Tue, 27 Feb 2024 02:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IzwC5LgQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CE454900
	for <linux-kselftest@vger.kernel.org>; Tue, 27 Feb 2024 02:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000518; cv=none; b=uhyS7qmC+Y+jWo3N1Qn4y9PgVaZOBpaHCIpOvBVAG+2DL7+/5KqA4130pCBtxV08lKUvQNbYe9d8ht3qliEyF4l6dDP3faEUCBMHItlp9qPWScSrj1qZfzOX8yHjGONN5fR43kD6q/XXGOkGTUT5xmUYul7IIEqw0dGQD6LPP8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000518; c=relaxed/simple;
	bh=SP3wECQuNsGizvBDLcQeElF0hhZLPHhC3anTjy4uCjs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rSkR7Qu8KP9jWB1dKgHVt80HerAwh3WO4qzv4K9iTIuOf69ZLsVdsLBLSgzwNeDztnYG6IYqnC6wPyqog+mpPkTm8+qqiT8mnsw8UIJsjLoEdy27/i4cQDfSHnSIMyCyO3BpyS9R4ZIiYeIyq0TqvX62o7rcYQHL2vyB3vJuJ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IzwC5LgQ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60770007e52so60144597b3.1
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Feb 2024 18:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709000515; x=1709605315; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gD/GJ68X0cVQGr5FjGXj7WBsDK+In0culAJ288XBYzk=;
        b=IzwC5LgQTEaLnY8mA9DN+WrSuS9nT+RJnDbNcQ7JeVTwIKnzzQG3xthKYAWQv85AZr
         wsvElYD70g09r9mszAQ3aD7QlggVoBvwZEUcDInU2HFPjFneCBZqwdNCyPgWM0v3/3Vl
         ESs484eOh4pfSBsvpN90oE0eth8LHDVs//fp9LFXsrI+EVqFhN8ptaJfGYYgZlwdBk4M
         8FMoYF8gmprX93JkSgCufwHKxI252tfqZinv7TDE4IRs3hgldEnzYV78Ikeiwy4sRXXQ
         zkMbZbCc/Tzm85/uwSdPlTqv9QQLqCyptaf9Q6ZaiiXtSbe18q3DmV/d6qUCelx89/iK
         Uo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709000515; x=1709605315;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gD/GJ68X0cVQGr5FjGXj7WBsDK+In0culAJ288XBYzk=;
        b=AnxJpDEyWt2BawARurFKA0++WrGRfVHuMJXPNoZKK+mKRLJ43Qnh0boKvl88BRylOM
         WTPr6smpMxGXWV+0qckUrYGLiJeZVZ7ZKMetTWftvgvaz4icNF32oLSXgXyTX4PgmyOG
         dEuh6WHiLXUJowxF1P7Jg/srr3ePGZiPyn9LmsEAF0GMU9/Ha7krplIGM+DpwMLwA+Nn
         120+z47sHHdspSslm5L3syPDvH7xhM7qBO8apM1qydql3HtCIYSg6HamuwMYXOW/4zha
         vRa94JFp9BZlnk8RRC24wkmmhjfrLa/Iou0YkXJ3wDt8nllK89ybbqLn5jdPyMmxbhN2
         ytEA==
X-Gm-Message-State: AOJu0YzOON3bu7yRvST8S0WaE55avX+V8VXCE8GSWzOU9ImJZ0CaNeG0
	29CQjGKhN1BMuAjOVVUtbShIIRNuyBPbEkpytuHWCBukbrYSC76InAdOnl5uh21g+nQkGD0Fqf3
	NzQ==
X-Google-Smtp-Source: AGHT+IGySX71rsoZHQXEKCFWAzA8N1hjTbbEs4eGPFYiN/yqiIDehY1AvBVxznlEWhqTc915C808bTjpV/Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:84:b0:609:1fd9:f76 with SMTP id
 be4-20020a05690c008400b006091fd90f76mr201794ywb.0.1709000515502; Mon, 26 Feb
 2024 18:21:55 -0800 (PST)
Date: Mon, 26 Feb 2024 18:21:12 -0800
In-Reply-To: <20240208204844.119326-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208204844.119326-1-thuth@redhat.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <170900036555.3692027.1057525433723685864.b4-ty@google.com>
Subject: Re: [PATCH v3 0/8] Use TAP in some more x86 KVM selftests
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 08 Feb 2024 21:48:36 +0100, Thomas Huth wrote:
> Basic idea of this series is now to use the kselftest_harness.h
> framework to get TAP output in the tests, so that it is easier
> for the user to see what is going on, and e.g. to be able to
> detect whether a certain test is part of the test binary or not
> (which is useful when tests get extended in the course of time).
> 
> Since most tests also need a vcpu, we introduce our own macros
> to define such tests, so we don't have to repeat this code all
> over the place.
> 
> [...]

OMG, you didn't tell me this allows sub-tests to run after a failed test!
That alone is worth the conversion :-)

There's definitely a few enhancements we'll want to make, but this is more than
good enough as a starting point.

Applied to kvm-x86 selftests, thanks!

[1/8] KVM: selftests: x86: sync_regs_test: Use vcpu_run() where appropriate
      https://github.com/kvm-x86/linux/commit/e10086285659
[2/8] KVM: selftests: x86: sync_regs_test: Get regs structure before modifying it
      https://github.com/kvm-x86/linux/commit/221d65449453
[3/8] KVM: selftests: Move setting a vCPU's entry point to a dedicated API
      https://github.com/kvm-x86/linux/commit/8ef192609f14
[4/8] KVM: selftests: Add a macro to define a test with one vcpu
      https://github.com/kvm-x86/linux/commit/992178c7219c
[5/8] KVM: selftests: x86: Use TAP interface in the sync_regs test
      https://github.com/kvm-x86/linux/commit/04941eb15439
[6/8] KVM: selftests: x86: Use TAP interface in the fix_hypercall test
      https://github.com/kvm-x86/linux/commit/69fb12492005
[7/8] KVM: selftests: x86: Use TAP interface in the vmx_pmu_caps test
      https://github.com/kvm-x86/linux/commit/200f604dfd07
[8/8] KVM: selftests: x86: Use TAP interface in the userspace_msr_exit test
      https://github.com/kvm-x86/linux/commit/8fd14fc541c7

--
https://github.com/kvm-x86/linux/tree/next

