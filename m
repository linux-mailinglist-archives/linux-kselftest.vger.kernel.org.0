Return-Path: <linux-kselftest+bounces-23226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4889ED957
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 23:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9CB8188191F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 22:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7471F03E4;
	Wed, 11 Dec 2024 22:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Auj4CTDk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BB11D88D3
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 22:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954776; cv=none; b=ne6uwxmXhUwrDTWtMZ17AurWGM6hAFAX+Ge0hN6v+P/JltzavaFQ4cbWgwcpuxdoxkKct3CChqq3LKv8g2TyAVZyH0eZPLMdNJE+LtfvtAH7YsNYiFP407/wU7/aLYbvCebxxukQ/vsY+DJwr6vfNPr7GPkwKZvsYXNZ6VUxJnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954776; c=relaxed/simple;
	bh=dc04m6m7A0zBx/3GsGuHlwEymHutsumTTMAD3LQrhZQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dac8iXWEmwInW7lS2wf6H/5hDEY8WdKF6na2q7SJDRxsgRNI6xMqO8beaYTWEc+d/7DOvJ37/+C1L1IJwZmcp4Qt7LWC3aV7kq+jkGywiAR5RmK/howkOBUoJPwUYtL2CllI2otQ4DRJEPJLFWtvKQqUHctlihVOU87L0NA2iuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Auj4CTDk; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21681a2c0d5so16172035ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 14:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733954774; x=1734559574; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uTDUEy5ndzyMUOmAANu+2Q5dKv5CytQeXy0bYdZM4AE=;
        b=Auj4CTDkhS7LzhaNcAPn5mYq6OF8PgwSK7WQQhbEOpT7tWIDubpIezmPMNuoe9GMHz
         7CdRufWp+F4w+gfK1zolvBvlL8W8bwpE7sC80wV044hKSeuT+mVVpKuc3SkhUkBYUlb8
         9xt6kN3ge476OS9hpEPCVj5ADX4iduN+WRYgWRaQ4e67e0QxTeWp3iOhe14oPwTIS0Dc
         bOkRSsk2649RXCsMZ/8F2scbDivSabuOgqLPoQDtiCTd1271HrBHvvNJ2cdVPPoPDD5n
         18lLyYrZhbOztthodbfPp40xsTKktCeJQiQIOTunZCXbWnOOvhLiaIRQGLjUZZngUh26
         ztvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733954774; x=1734559574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTDUEy5ndzyMUOmAANu+2Q5dKv5CytQeXy0bYdZM4AE=;
        b=QhsrPtugAy9zJesAXFyMTAxCk6itYctOcWUz6cqJd5XHRWsV6FyBSTk4ZNMvLqn5Bq
         epncfwzNtEeh/1xlVEywY6M5liwn+mrYV9jU09Le0mn/buwWKg8HxbSb3JMGtUz02drM
         pri6Z/hyjeJ2QLDAlrr23mYZ2SNR4yqXplFoOnGIVLaIjvHqrY6ye/AMvf7gTve5lnGX
         SX9x+0z0xPAF7yOLCDJnsZa987c+kYt/scwJx6GS7Q+V5LmE8VHrydORkEht746pWcM9
         HWZ9aZXhqm4D1Vr6zaNVM9Tov4GdISgmsEON3kAWu6P/71zsCHRSnx7+2vF8rVRDmatd
         FUXw==
X-Forwarded-Encrypted: i=1; AJvYcCVkjET0a4lbkK6wuLkJztHw5UAhGfnC6szXK7RLdnTuEZUaqeqxOZUyRRRKBipKsKTqzl+z+B8Atr/R7k4p0Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2LJnnC4IlNfu03ZEZ5FaNLnnh27tV3d2JnSCucC5o1XPasHfq
	dD8QWerW4fchNJ7SLC/cOE6sYBvqEmW/3U3Wdi3OZrKxvoa2HsVTaQXa2kv6t7h9pPA/8QohKo6
	flQ==
X-Google-Smtp-Source: AGHT+IHFSnyjPEDTcWJnAvaiGma2JfY/srzHSvKplMJ9OueXQOEiKTtjMmaF+b36NOyPghd7X0ZdCPZjbkA=
X-Received: from plgn1.prod.google.com ([2002:a17:902:f601:b0:216:499e:dadb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db04:b0:215:44fe:163e
 with SMTP id d9443c01a7336-21778397514mr77377935ad.1.1733954774653; Wed, 11
 Dec 2024 14:06:14 -0800 (PST)
Date: Wed, 11 Dec 2024 14:06:12 -0800
In-Reply-To: <20240910152207.38974-15-nikwip@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240910152207.38974-1-nikwip@amazon.de> <20240910152207.38974-15-nikwip@amazon.de>
Message-ID: <Z1oM1HQqXrIr1tij@google.com>
Subject: Re: [PATCH 14/15] KVM: x86: Implement KVM_TRANSLATE2
From: Sean Christopherson <seanjc@google.com>
To: Nikolas Wipper <nikwip@amazon.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Nicolas Saenz Julienne <nsaenz@amazon.com>, Alexander Graf <graf@amazon.de>, James Gowans <jgowans@amazon.com>, 
	nh-open-source@amazon.com, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kvmarm@lists.linux.dev, 
	kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 10, 2024, Nikolas Wipper wrote:
> +int kvm_arch_vcpu_ioctl_translate2(struct kvm_vcpu *vcpu,
> +				    struct kvm_translation2 *tr)
> +{
> +	int idx, set_bit_mode = 0, access = 0;
> +	struct x86_exception exception = { };
> +	gva_t vaddr = tr->linear_address;
> +	u16 status = 0;
> +	gpa_t gpa;
> +
> +	if (tr->flags & KVM_TRANSLATE_FLAGS_SET_ACCESSED)
> +		set_bit_mode |= PWALK_SET_ACCESSED;
> +	if (tr->flags & KVM_TRANSLATE_FLAGS_SET_DIRTY)
> +		set_bit_mode |= PWALK_SET_DIRTY;
> +	if (tr->flags & KVM_TRANSLATE_FLAGS_FORCE_SET_ACCESSED)
> +		set_bit_mode |= PWALK_FORCE_SET_ACCESSED;
> +
> +	if (tr->access & KVM_TRANSLATE_ACCESS_WRITE)
> +		access |= PFERR_WRITE_MASK;
> +	if (tr->access & KVM_TRANSLATE_ACCESS_USER)
> +		access |= PFERR_USER_MASK;
> +	if (tr->access & KVM_TRANSLATE_ACCESS_EXEC)
> +		access |= PFERR_FETCH_MASK;

WRITE and FETCH accesses need to be mutually exclusive.

