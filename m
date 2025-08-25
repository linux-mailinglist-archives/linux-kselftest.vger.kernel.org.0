Return-Path: <linux-kselftest+bounces-39883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D73B34B24
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 21:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB9320502E
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 19:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E46B2874FA;
	Mon, 25 Aug 2025 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nSmyo81L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1714C23A58E
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 19:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756151547; cv=none; b=gKubezRKnwi8TkxLkmtwtXAwZDSfHFYVEHiiEjq7OGT0zFCvxegJTN5A6avLORtx1pPk++ZkhNIHGdfNWh8o5mmkHmX/fAQJ0uOlga19N2OiBnsko2kCXbJKDNObWfNWSu+oBKUPDV5fzO6Q7M/saOlNbliT2xqGbO5ZCkRQd6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756151547; c=relaxed/simple;
	bh=27LVi33Piq79b4c8wVCJq9OIcPzQn7EWMYuMP0qjd6g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XeaBF+hsN+MuyEm+7LmAP33oSY1GIWMaGohvjP41GhpSsLz8FtpT3opjmhl/XXC1SHpJGgQuwIq0JOZ4zAJEQgL6dGDBHrw3ilp3eWCFK8WXfxlKNu4AxTVZMvC1REkd+N37jmdMaK+GNTup8J3zXWQCxgS/AYzxOsZ1MdCPsdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nSmyo81L; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32505dbe23fso3193017a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 12:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756151543; x=1756756343; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CCEDB6kqaMG14n95AC3dXml5C4i7TOO+4ulWOjXNjDA=;
        b=nSmyo81LcBHQzTh8icoumB6cImX5Z6mMTTM41NVK7r/CDuhs3+xSrJfFLA/Icx4675
         yHoVaIU3TA/2Irl3IEGdgw58nTdrdbqvkRYNpNnSIm8LCMFUR95J/H29YoUaWgdGnFk4
         kdUHCtbt1zbMnu/VINs+Ew/OLD9LPjI7gNytYT6v+4KPZM5l9CERWnFs2e4tEzi3Z09p
         h4W4AgGpNDmWDVrNLcuLjuMzu0SyVpKPWUHTkP5aqEo4STGIT6ISkBVZ70oVM4GAzOz4
         iFX80/sX82zLyVyKPPnpQw0L/iOLI4gm48eARTqunoY1APNpr8qSVHa03kWj+2AFqgSQ
         WlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756151543; x=1756756343;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCEDB6kqaMG14n95AC3dXml5C4i7TOO+4ulWOjXNjDA=;
        b=nmlQwnwocmJ0RILVEmSeX/7BElIUrYDoZ3TeT+NqH3AM1hUe5Z1HFS4ZujKXlYHxAE
         SfAFvH53dqEeN/DZiSUW/9kyyUk2gDgso6OCXWMLP79dQ63Ywqpl+70xhspyxa2rH0vY
         41voAqxFyZ9p4IVAc3gl+CwrhZYeSzzw9RmjUyyRdvnWRPhZN06QmbOlS6cz8SejfN6w
         jAGQSZ0Yk7lz5uvopeX7LWvut7qDxuGwoDn6HFZSsq3Y/clPF95QmaJUyWi912xqQvcC
         pM2xBY7Fw/DeJXtBKNrRShQdfj/YdMqxxDyIJxE6ruU9ObI3J+S1AHJWsL11bCz6SRSV
         kmWg==
X-Forwarded-Encrypted: i=1; AJvYcCV30cs9OyxOhQXnNIZtiarS57EO8UnP4wt4/BmE+VwlYlEpB389dQjJC6slE917P1Z6A5w/YUKQWD8GrYP2Bjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD34erkk3R6nTeSOfrXZ8rQv7XzlYra5WxZfNuQ6vz5nesJUPP
	GNil3p2s4YO7L4bB/rWuZ8tvsA2vR1mFIlQhxN+Au3PNtpMfI6dO7RC6BQUykVpFgh4cDnS9Kf3
	/vaQv/g==
X-Google-Smtp-Source: AGHT+IGdV6Crel2hSBLJu5xj69LCA8mKZyILIoBXiyFz0c96jNGA0JlOa+svdw4ALPEpBZ5tb9n+dMFk9lc=
X-Received: from pjbsg1.prod.google.com ([2002:a17:90b:5201:b0:321:c1e3:6b16])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:dfcb:b0:31e:c62b:477b
 with SMTP id 98e67ed59e1d1-32515ec9f34mr13649374a91.11.1756151543426; Mon, 25
 Aug 2025 12:52:23 -0700 (PDT)
Date: Mon, 25 Aug 2025 12:52:21 -0700
In-Reply-To: <20250825155203.71989-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250825155203.71989-1-sebott@redhat.com>
Message-ID: <aKy-9eby1OS38uqM@google.com>
Subject: Re: [PATCH] KVM: selftests: fix irqfd_test on arm64
From: Sean Christopherson <seanjc@google.com>
To: Sebastian Ott <sebott@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 25, 2025, Sebastian Ott wrote:
> irqfd_test on arm triggers the following assertion:
> ==== Test Assertion Failure ====
>   include/kvm_util.h:527: !ret
>   pid=3643 tid=3643 errno=11 - Resource temporarily unavailable
>      1  0x00000000004026d7: kvm_irqfd at kvm_util.h:527
>      2  0x0000000000402083: main at irqfd_test.c:100
>      3  0x0000ffffa5aab587: ?? ??:0
>      4  0x0000ffffa5aab65f: ?? ??:0
>      5  0x000000000040236f: _start at ??:?
>   KVM_IRQFD failed, rc: -1 errno: 11 (Resource temporarily unavailable)
> 
> Fix this by setting up a vgic for the vm.
> 
> Signed-off-by: Sebastian Ott <sebott@redhat.com>
> ---
> @@ -86,14 +90,30 @@ static void juggle_eventfd_primary(struct kvm_vm *vm, int eventfd)
>  	kvm_irqfd(vm, GSI_BASE_PRIMARY + 1, eventfd, KVM_IRQFD_FLAG_DEASSIGN);
>  }
>  
> +static struct kvm_vm *test_vm_create(void)
> +{
> +#ifdef __aarch64__
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +	int gic_fd;
> +
> +	vm = vm_create_with_one_vcpu(&vcpu, NULL);
> +	gic_fd = vgic_v3_setup(vm, 1, 64);
> +	__TEST_REQUIRE(gic_fd >= 0, "Failed to create vgic-v3");

I don't think this test requires v3+, any GIC will do.

Is there a sane way to handle vGIC creation in kvm_arch_vm_post_create()?  E.g.
could we create a v3 GIC when possible, and fall back to v2?  And then provide a
way for tests to express a hard v3 GIC dependency?

Having to worry about things like this in fairly generic code is quite burdensome.

> +
> +	return vm;
> +#endif
> +	return vm_create(1);
> +}

