Return-Path: <linux-kselftest+bounces-24896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DFDA18648
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 21:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487263A81C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 20:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA351F76B5;
	Tue, 21 Jan 2025 20:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kHPndlNE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF851F63CD
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Jan 2025 20:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737493017; cv=none; b=hlJFP7eY94GaBEkdHjYyJt36G5xn4w97nA4uoQUTC//+/X1TxpYnZP6grqoz1zSJN64Li2h1KYkfJ3edRX2oz0Q9F18JTQQTrjzkm8M+l0VZ6i6uX+JFAzmo3EwUCPpxdBMNSMMtaLTEAlHPBn8q6YGsmqgdWVpnd8AG+JfLC+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737493017; c=relaxed/simple;
	bh=oUeI4xqiwKehrm14csxiidLnNyGQ54ADBOT0ioMFNH0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tq7/84+5tRZ0BXLwD4a5xym9CDeYAWrxO5O+2JhNZ9Aowgc7bPGmbdHGan2Qm/eI2YQs7wv+ZgrVNLue1RDSaHmT44q6hhDiKaQCpYnImucfcMEydzAqsukljB2MKm9W5ZflcFVnSTWUB4kRS9SIVaGJAfdIIGauy4y3AtDHAYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kHPndlNE; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2162f80040aso109947175ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jan 2025 12:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737493015; x=1738097815; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FPmPdXxg4qDDFjuISJwDdAIVLc44OyHMr66SXY5pv74=;
        b=kHPndlNEfWXUCZ0isYHUdZwFTgmeO2TUXOEgt361wZVAwhd5PNyig8m04rzDj9OJgy
         3vmk6tLCYoLfAtKC7cbgBWjb/pP3Boecb6NqIvJoREGT1c/eGzeuHh4vXLey0ACWdMoa
         od2wmbim3Bw+8ziZMH/d1rJlrg4jZljwkz63qBPqyIFodbiIGYho3wkLhP/6BlC1DlQj
         zuGzdsBYGL8pSyD4BCh1tkkWQqODtsVFt7qie7rOjrUE1npcvtSg+SHBEFQNBUMYnhCl
         Xg1NwxFJHB4bCKTl4NVgy53pajIIQIJrmslDISKB3XXDCmVrczGfOahIEtS5w+6qyzo+
         xf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737493015; x=1738097815;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FPmPdXxg4qDDFjuISJwDdAIVLc44OyHMr66SXY5pv74=;
        b=F9vp/7BX3r4/bj5dMCBLfulchhzPdgUbCFWCsnrEHaIXrT0HvLZIG3/NVMUaKcF0HV
         CXYol8HXjXO95l8d4t4XVdCIe1r01fhIHDbhMq6S/KL85CPG42XOf45RhO7LIQFToGcU
         vwSfgEZuSgur+2A/ciE93yEtCcFSHmmPInk/a/hFrYE4o6LP1IKy04KZHLc7iMJmnh1s
         ZfCWwv6sCntueuRfK464Yh5mypHAbmjWBnjgTbXBGqc/qtOQ4PjS9MXUTx4JpMi9I3Z6
         Jmr7UgoB5AZe9z3hWnAFXjOhD4pmy5j4y/1vbCQC/DGNVxeIc8yaA+PFx4GBSfwqcnN5
         gk4A==
X-Forwarded-Encrypted: i=1; AJvYcCUKN3KLRI6V6W1PFyK10MaTxBa0n+cdSC39OFU4VMkBTtv3Gjb6GXWJuXyLktFYOuOI2meHDBmeMZQgn52Jx+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVHJps7IEjRDJS5b1i4n4mGEMv/otZDcGblVNShiqzNmFSrRAh
	2upLZSb74fztBsazZEHUSJ2BDGoRN+sMZRgFzAmimKnQajxWozFgFtFCTJMkTmNlwboB80/oh/p
	HNQ==
X-Google-Smtp-Source: AGHT+IFdrRQcFubciantcwlkp+b6rBGHmd4snduv+064ENHS/VQS3HzU5edUM2r89L0j7KTtpRdHOth+VXE=
X-Received: from pfwo10.prod.google.com ([2002:a05:6a00:1bca:b0:72d:b2a2:bed7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:258e:b0:1e0:d632:b9e0
 with SMTP id adf61e73a8af0-1eb21481d85mr30143462637.13.1737493015514; Tue, 21
 Jan 2025 12:56:55 -0800 (PST)
Date: Tue, 21 Jan 2025 12:56:54 -0800
In-Reply-To: <gsntplkh2wia.fsf@coltonlewis-kvm.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <Z37FYUU4ppiZsa68@google.com> <gsntplkh2wia.fsf@coltonlewis-kvm.c.googlers.com>
Message-ID: <Z5AKFlSJ9wgbX_MS@google.com>
Subject: Re: [PATCH v2 3/6] KVM: x86: selftests: Set up AMD VM in pmu_counters_test
From: Sean Christopherson <seanjc@google.com>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, mizhang@google.com, ljr.kernel@gmail.com, 
	jmattson@google.com, aaronlewis@google.com, pbonzini@redhat.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jan 20, 2025, Colton Lewis wrote:
> > > +static void test_core_counters(void)
> > > +{
> > > +	uint8_t nr_counters = nr_core_counters();
> > > +	bool core_ext = kvm_cpu_has(X86_FEATURE_PERF_CTR_EXT_CORE);
> > > +	bool perfmon_v2 = kvm_cpu_has(X86_FEATURE_PERFMON_V2);
> > > +	struct kvm_vcpu *vcpu;
> > > +	struct kvm_vm *vm;
> > > +
> > > +	for (uint8_t ce = 0; ce <= core_ext; ce++) {
> 
> > Kernel style is to not declared variables inside for-loops.
> 
> I ran it through checkpatch and it didn't complain.

...


> > > +					vcpu_set_cpuid_property(
> 
> > Google3!  (Never, ever wrap immediately after the opening paranethesis).
> 
> Checkpatch didn't complain.

Checkpatch is a perl script, not sentient AI.  It's nothing more than a tool to
help detect common goofs, typos, egregious flaws, etc.  The absense of checkpatch
warnings/errors does not mean a patch has no issues.  Coding style in particular
is quite subjective and prone to "exceptions to the rule", which makes is especially
hard to "enforce" via checkpatch.

As explained in Documentation/process/4.Coding.rst, what matters most is consistency:

  A code base as large as the kernel requires some uniformity of code to make it
  possible for developers to quickly understand any part of it.  So there is no
  longer room for strangely-formatted code.

https://www.kernel.org/doc/html/v5.0/process/4.Coding.html#coding-style

