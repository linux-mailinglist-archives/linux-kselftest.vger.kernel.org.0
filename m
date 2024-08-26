Return-Path: <linux-kselftest+bounces-16310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D532D95F606
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 18:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DFBE1F217F4
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 16:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC02F18660E;
	Mon, 26 Aug 2024 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ixbp9v9f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531648F47
	for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724688407; cv=none; b=p4/8LJyhAvKV9BHsTwoFi1A4kV/u6mUnLIBDJi1C8y2YgMuGVFyqYZYOQlIa4RqeaqjAskcn8Ap4h3CIty32aiOiZtlPrj7R89Eak/K5AcJpk53kgfqp4Vg4U2nTYicZiIOwRxK97yG9TiL94nM/CT8LNNp/nfEQMD24oiM8pcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724688407; c=relaxed/simple;
	bh=OkGoFuz+fDUxddm3p4u97QJ8wx3Ln4XdHW9MaJMQRak=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mEIq372JGGgvwRifr60oml5CM1YTDGkRCYVNTPRk+aHm2aRM1j+E5VmKafM/3L/9fwIBwP+umOrhVe8pRnQkNhctZFjN+Z8Zl+xDfN950HGXILGFck5VwQ6T40S/D9Skwh/HnZyJMal6yBC+cetuMpyRZDL7B/kkSnalqC6Mi+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ixbp9v9f; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7cf603d9ffaso1206757a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 09:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724688405; x=1725293205; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BynQTMQmisTL3nM3s/Ff9E1/xSh6KM8uArokROfN7nM=;
        b=Ixbp9v9fgomxwBqk7cyFof/uMe7f5pPwpSYUCKuQAUe0d573fXlPXxudUm+DNmVyaZ
         HYpjcMH2zFr4eLZLpzqPktSY7w/bJ5KCHv6wZ40TOVqMwgLHVl2DinkOEDnbg/hunKq7
         g7Tx/CDmG7Y4TSBa/mwAww9lVvs4bb0wJNH0a/Z2qtWl6yABbWauCfsyvsXj99BPkOLM
         yEF1ofPsUkcVQo6HoTVb+/a2pjZeySrQ88teNX/qa/n07ospAN0iI6+Gbzq1I30HsGYv
         ji1D0gkeXoTHhLPd4ItGP9jbScGxRmWfEek/A4/KhOx+P+0EbvQN408gL/vxX0yIt0Sh
         9+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724688405; x=1725293205;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BynQTMQmisTL3nM3s/Ff9E1/xSh6KM8uArokROfN7nM=;
        b=vkGZGZ9SgIuq/t4ynkc+//y6stfzHhZduCnXDlF0P6eivfr7Pb70SqCY542NcwE1vQ
         +Q9lE3bPVx/hM07Tw7mQPf+J2XTZTHHwAJC10lkm6+6ln+8oVYPW5ynXUUJWx7r38l/1
         3WIAHoM3RMCLD4jrDJUQOsVql+2u6LuRiUvgIxSG8nCXAShbZeEK5E3jNBXEPLKL670u
         pmKUex8DRcw/qWeQOEMuxDaGiKY0Cy8b/Er7Gk4FOFpOVsCz1tqbjwVeuSI9sMYzRPGL
         4y4UYcad4FcvDUC9sAvYwCWJN7fmXqxvrMhvZc5l5XaYUiBUiaEovbXL1uSmJTgIS30K
         gFrg==
X-Forwarded-Encrypted: i=1; AJvYcCVnQJIygGgCXUCX9nSvIKL8O2rTcXw4Mev0DZm8N3yRK1OjzFRj/P6uWVRZgJHOn7vta7GUSfiSxgk5Dc3Ttvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+hFkGycC5xF/rWGIt/2aINea+zx0NEjtjfJHtau8dN+ia3LtS
	oNHXRbCs4R7cQUU4Y8wNh+M0187/uDV4ZWRvKsS4CCEjbwRfKfgIkqH+FRKpdt40n/e8mfnocQn
	AMg==
X-Google-Smtp-Source: AGHT+IGu5PyL8vTVsTk4Bc9xMIMbu9l/UfTusA5mkGKtrJsB3RZoCmjSzYuFMfzLV1OMDGFxZbOOYBBn3Hc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:a0c:b0:77d:336c:a857 with SMTP id
 41be03b00d2f7-7cf54efae8bmr22574a12.11.1724688405258; Mon, 26 Aug 2024
 09:06:45 -0700 (PDT)
Date: Mon, 26 Aug 2024 09:06:43 -0700
In-Reply-To: <002c7137-427e-4bd8-ae9e-04aab3995087@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240709175145.9986-1-manali.shukla@amd.com> <20240709175145.9986-5-manali.shukla@amd.com>
 <Zr-0vX9rZDY2qSwl@google.com> <002c7137-427e-4bd8-ae9e-04aab3995087@amd.com>
Message-ID: <ZsyoEz9DMq2hZhV4@google.com>
Subject: Re: [RFC PATCH v1 4/4] KVM: selftests: Add bus lock exit test
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	shuah@kernel.org, nikunj@amd.com, thomas.lendacky@amd.com, 
	vkuznets@redhat.com, bp@alien8.de, babu.moger@amd.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 26, 2024, Manali Shukla wrote:
> >> +struct buslock_test {
> >> +	unsigned char pad[126];
> >> +	atomic_long_t val;
> >> +} __packed;
> >> +
> >> +struct buslock_test test __cacheline_aligned;
> >> +
> >> +static __always_inline void buslock_atomic_add(int i, atomic_long_t *v)
> >> +{
> >> +	asm volatile(LOCK_PREFIX "addl %1,%0"
> >> +		     : "+m" (v->counter)
> >> +		     : "ir" (i) : "memory");
> >> +}
> >> +
> >> +static void buslock_add(void)
> >> +{
> >> +	/*
> >> +	 * Increment a cache unaligned variable atomically.
> >> +	 * This should generate a bus lock exit.
> > 
> > So... this test doesn't actually verify that a bus lock exit occurs.  The userspace
> > side will eat an exit if one occurs, but there's literally not a single TEST_ASSERT()
> > in here.
> 
> Agreed, How about doing following?
> 
> +       for (;;) {
> +               struct ucall uc;
> +
> +               vcpu_run(vcpu);
> +
> +               if (run->exit_reason == KVM_EXIT_IO) {
> +                       switch (get_ucall(vcpu, &uc)) {
> +                       case UCALL_ABORT:
> +                               REPORT_GUEST_ASSERT(uc);
> +                               /* NOT REACHED */
> +                       case UCALL_SYNC:
> +                               break;
> +                       case UCALL_DONE:
> +                               goto done;
> +                       default:
> +                               TEST_FAIL("Unknown ucall 0x%lx.", uc.cmd);
> +                       }
> +               }
> +
> +               TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_X86_BUS_LOCK);

I doubt this works, the UCALL_SYNC above will fallthrough to this assert.  I
assume run->exit_reason needs a continue for UCALL_SYNC.

> +               TEST_ASSERT_EQ(run->flags, KVM_RUN_X86_BUS_LOCK);
> +               run->flags &= ~KVM_RUN_X86_BUS_LOCK;

No need, KVM should clear the flag if the exit isn't due to a bus lock.

> +               run->exit_reason = 0;

Again, no need, KVM should take care of resetting exit_reason.

> +       }
> 
> - Manali
> 
> 

