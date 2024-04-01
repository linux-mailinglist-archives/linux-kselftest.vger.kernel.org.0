Return-Path: <linux-kselftest+bounces-6951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B9089441B
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 19:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F422830EC
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 17:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874D04C60C;
	Mon,  1 Apr 2024 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nRHfIjvw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195C2482DF
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Apr 2024 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711991738; cv=none; b=oOOCiEGUFXXUQSRvXG9m1yCUGbWElyMYPrccgwUYMAyqVENftj1fEAQXBHeAvWWH+TzNC6eo5UEGDLoErq361Pyb/0XAWBwgk1NEhaWJi4Kmu8W1N/pvOc78NAesrSgXZG8AnrdWFIjtmH8x9DBdXnxrw82j2lmi93hkpapnQ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711991738; c=relaxed/simple;
	bh=XDYOzGKNqipsV6o7BIC8dH+C/r5/n4Ywr7gVjgM7abg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W1QGBAi++Kb8MwYrOPT9ynFPKHRdBesBbCEjUa2vxbfjvqv6SBGPjaJXE2AuDIw4LqTeIEj6+tAXL5YIHV+is3GdLDGLhCQBJmdy/iEKCybksTvGAKxd1+dSMgvI3u1gmpNUAkujkloPl+hm0Mq95D1KDBKg6ZluqXgvzuW3mL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nRHfIjvw; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2a240c417d9so749100a91.3
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Apr 2024 10:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711991736; x=1712596536; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QZsR60ocYS9wOtYYUZzmwhHcImqG6QFUhMcydPwaCak=;
        b=nRHfIjvwaNzEPSu5PG6DQtqcsA7nF0+tiViMsRJW58u09ISi9Wk+V6SmH/YEVFN/L4
         vOnLH2bvjyxFsqk4tMXyHKcKf9yNmP1h901Amo2lkwVT6312LzPnsLJN6/RmQBJXY1Zf
         c5xqGEJAEd+WQKEWV0ZWLePmxkbdj+GibZd509rrpvXoC11vdkJEtvZr2TO0AxS8/C4i
         +TIkfq4AT8+L6ydpkynHuqVXa0vl6uRo+5/HtLOukkw88i6BKHgwdYP5UVudEeDHYV0Z
         bW1gBYP2wVpM5ADbe0Ys6L5tFY6Yfc2IiWK61rZEoBZjhrOm9HtXZmSpqn/kD+MZjSYQ
         XU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711991736; x=1712596536;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZsR60ocYS9wOtYYUZzmwhHcImqG6QFUhMcydPwaCak=;
        b=JhIYbiLAKgHJvOzkKT2Sj/lF5mbeYNx/YBwFn28H0na8meWtxWBQ28Akwtpxc4HYUg
         Wbo4xFp3QxGq2Y0Q5K0mSijYuVO2tKInCX9WOZDvhr91e74IjH85wooAApoic05BKbIU
         z9uh8Cy0M/fdR67v9RSChla7YLW7wCGgpe/4tDzyo9fd6H8sJnXT1Cw4OHYq4m8gd+Ea
         GZvpM5bXJLHMTu3dn9LruCPiWhPywU/Jyf4sICt/uka6zNhX//T7jcyE0WX3Tp4jXpFx
         W1GrwXKXruoFtA7jzBUobq+LqDmW6oahuyk1e3xgbZDD2qpGpyI7qbEE5F4MttRXeVtB
         EGLg==
X-Forwarded-Encrypted: i=1; AJvYcCWbSx4cwC4l6iNn6PVZd4Dpx2QbikVvbn+X9GcOF+fyyIxUivZCuJFeQsX0kFQXDyNS7nGmeXQEr8/7ANWThx1pVyxwbq/ljWUoBI5eB7tF
X-Gm-Message-State: AOJu0YyaX/rECKBHG4clqEvZAjerxkwkQGaY6KzAQA/QsQFodG+9cDFT
	nMKGwqfJJ2fqaOmsaMkmBtV7T/ZGJxBHrRmb3INoW/uuQkrFnM2HHP8RL1XHCQOPhaGUUUuR37/
	Atw==
X-Google-Smtp-Source: AGHT+IHH8d2wxNICSYp90HoHGLO5SSq301vPHsLo62t5PQRwl88q2x4sn1B4iKaWeeoelFTBEG4GEcBaGgA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:124d:b0:2a2:205d:7ecd with SMTP id
 gx13-20020a17090b124d00b002a2205d7ecdmr23236pjb.4.1711991736318; Mon, 01 Apr
 2024 10:15:36 -0700 (PDT)
Date: Mon, 1 Apr 2024 10:15:34 -0700
In-Reply-To: <20240401152032.4284-3-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240401152032.4284-1-manali.shukla@amd.com> <20240401152032.4284-3-manali.shukla@amd.com>
Message-ID: <ZgrrtnZCllrt-3TD@google.com>
Subject: Re: [PATCH v2 2/3] KVM: selftests: Extend @shape to allow creation of
 VM without in-kernel APIC
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	shuah@kernel.org, nikunj@amd.com, thomas.lendacky@amd.com, 
	ajones@ventanamicro.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Apr 01, 2024, Manali Shukla wrote:
> Currently, all the VMs are created with in-kernel APIC support in KVM
> selftests because KVM_CREATE_IRQCHIP ioctl is called by default from
> kvm_arch_vm_post_create().
> 
> Carve out space in the @shape passed to the various VM creation helpers to
> allow using the shape to control creation of a VM without in-kernel APIC
> support or with in-kernel APIC support.
> 
> This is a preparatory patch to create a vm without in-kernel APIC support for
> the KVM_X86_DISABLE_EXITS_HLT test.

Ugh, when I suggested creating a VM without an in-kernel APIC as away to easily
test that HLT doesn't exit, I wasn't thinking about the side effects of creating
a runnable VM without an in-kernel APIC.  The other downside is that practically
no one uses a userspace local APIC these days, i.e. the selftest isn't a great
representation of real world setups.

Given that KVM already provides vcpu->stat.halt_exits, using a stats FD for
verifying exiting behavior is probably a better option.  The other check that
could be added would be to verify that mp_state is always RUNNABLE (which is a
bug/gap in KVM as migrating a vCPU that was halted in the guest won't resume in
a halted state on the target).

