Return-Path: <linux-kselftest+bounces-5554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDB786B9E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 22:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2E87B25784
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 21:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5898B5E090;
	Wed, 28 Feb 2024 21:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XZB1hZ3U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2DE86255
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 21:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709155955; cv=none; b=U/4EmIjcgGNWrjiFmZgVbD9wWcU32DIPO1AFg8Z9VY8kY7GZmJrEvn+R8+lxSrRbZlHMgZklTxuTnDGfeqQNRdUQnXBLTpZI0dEe85zDmQiCQSIKcTADoGjElNucomdh8HsRVbU24Hhc61j797nlN2s+z95X4nVPnVCDhtK026k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709155955; c=relaxed/simple;
	bh=vurzQAkj+Uzk8AykBkc/bg1M650EYGHX9phKK+ngi0w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D2oS7SaXaa3plLowmtUB3PiFDu0eBjbQ/DGoxC8S2y8GGxTeAlr+k0sb+ErgWQCm8dq5AwpHbEoDcP/+BJw9LHwH1mQjQ1/xfCIByxd0gjma/CMYK/hEBxLmDuhwp/NKjsk8TMEmD2NOPJttRoOI5U6U/kW2enoQIZYumT9znVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XZB1hZ3U; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-29a5f3804fbso107382a91.1
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 13:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709155953; x=1709760753; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yIIQ0MmR6ymPVVYqXu0m83pfog7nJNUxZwJFPucVFi0=;
        b=XZB1hZ3UMvXWJLjaQaeYPxOHV2M5jI+gqknzS7dMrWdXBTHYMXtFzOkr8uQ+L7b44v
         uHTA5U4uB8lAXmIJPbtCKLUIJDkkiOJCj5suajWjuDxo7VfYl3Mb83eUn9c9jmt1m5Vd
         +Rk0ASaFGvBh1h6pUTiC+21sCznyK6gQsj2yTqftisDy2GSWFEMF1FyfCnDceDvXK4lQ
         yBxCuNCepiv0ChdrX4MzS+e9viPGa8do49szM5bDHIJqDVJbQMHwlSCcroTQ2hzfYkqB
         /+RW8ZmfMGmFtLkwYHBZBEO6Ytw7+D1oKVdjC9RiV1jGYzjbBDDCVKRZ13+CT7lbl2Xg
         bpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709155953; x=1709760753;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yIIQ0MmR6ymPVVYqXu0m83pfog7nJNUxZwJFPucVFi0=;
        b=Khd7bZJcDhcSEfJYDzroq0J90IzVFy0ncVvaetzUkeeHfUPCHEi/TqeqSx2Z5ESBOh
         2xfOdF3yKNDXSme6H8SbTLq1CUWlQJeOevyhBeRUB7zZswiw/GYGJYclfdWEw/e8txou
         GYOITA51eNEllkpyePK1YkVYkPrS0vq1iCmQp1UxJlVNn7vcX1qcWOravLEr6LaD0JBc
         kxyNwJuBJU72FOVDkW6KR+swanFM/nlvGsTI7oyr9vfEaIy9rbLN/gDJFFxf6SP3QCRs
         jeQYT1pqX/kD427hpr2PZGOhZ1OER75BlJTEdQ7DQuZGQhgiGrVG8SFRzlldt/VwSaO5
         WC7w==
X-Gm-Message-State: AOJu0YywV33rg7/ySU6aXMAzvV5moA8iuZ6a4HnJfgSGdAMlfGWc7ej/
	PxMt5KnHfxFjVqYc0UzGJ+kss5jJUtkGiKLaqkncIjRwOD9Ny7nVcVsbSPeUwuSPzI9S8GMqT0q
	oyg==
X-Google-Smtp-Source: AGHT+IGubsT96u1o3j+RmR8kfG5FWlObG7Q+IXPU/pt+XH6aKFJjnUg2nj9BZEmVlfZA8HUeJOMt5JH+YUc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:23d4:b0:29a:a842:6eff with SMTP id
 md20-20020a17090b23d400b0029aa8426effmr1162pjb.1.1709155952903; Wed, 28 Feb
 2024 13:32:32 -0800 (PST)
Date: Wed, 28 Feb 2024 13:32:31 -0800
In-Reply-To: <170900036555.3692027.1057525433723685864.b4-ty@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208204844.119326-1-thuth@redhat.com> <170900036555.3692027.1057525433723685864.b4-ty@google.com>
Message-ID: <Zd-mbxzD--SkEBjP@google.com>
Subject: Re: [PATCH v3 0/8] Use TAP in some more x86 KVM selftests
From: Sean Christopherson <seanjc@google.com>
To: kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 26, 2024, Sean Christopherson wrote:
> On Thu, 08 Feb 2024 21:48:36 +0100, Thomas Huth wrote:
> > Basic idea of this series is now to use the kselftest_harness.h
> > framework to get TAP output in the tests, so that it is easier
> > for the user to see what is going on, and e.g. to be able to
> > detect whether a certain test is part of the test binary or not
> > (which is useful when tests get extended in the course of time).
> > 
> > Since most tests also need a vcpu, we introduce our own macros
> > to define such tests, so we don't have to repeat this code all
> > over the place.
> > 
> > [...]
> 
> OMG, you didn't tell me this allows sub-tests to run after a failed test!
> That alone is worth the conversion :-)
> 
> There's definitely a few enhancements we'll want to make, but this is more than
> good enough as a starting point.
> 
> Applied to kvm-x86 selftests, thanks!
> 
> [1/8] KVM: selftests: x86: sync_regs_test: Use vcpu_run() where appropriate
>       https://github.com/kvm-x86/linux/commit/e10086285659
> [2/8] KVM: selftests: x86: sync_regs_test: Get regs structure before modifying it
>       https://github.com/kvm-x86/linux/commit/221d65449453
> [3/8] KVM: selftests: Move setting a vCPU's entry point to a dedicated API
>       https://github.com/kvm-x86/linux/commit/8ef192609f14
> [4/8] KVM: selftests: Add a macro to define a test with one vcpu
>       https://github.com/kvm-x86/linux/commit/992178c7219c
> [5/8] KVM: selftests: x86: Use TAP interface in the sync_regs test
>       https://github.com/kvm-x86/linux/commit/04941eb15439
> [6/8] KVM: selftests: x86: Use TAP interface in the fix_hypercall test
>       https://github.com/kvm-x86/linux/commit/69fb12492005
> [7/8] KVM: selftests: x86: Use TAP interface in the vmx_pmu_caps test
>       https://github.com/kvm-x86/linux/commit/200f604dfd07
> [8/8] KVM: selftests: x86: Use TAP interface in the userspace_msr_exit test
>       https://github.com/kvm-x86/linux/commit/8fd14fc541c7

FYI, the hashes have changed for patches 3-8, as I forced pushed to fix an ARM
goof in patch 3.

[1/8] KVM: selftests: x86: sync_regs_test: Use vcpu_run() where appropriate
      https://github.com/kvm-x86/linux/commit/e10086285659
[2/8] KVM: selftests: x86: sync_regs_test: Get regs structure before modifying it
      https://github.com/kvm-x86/linux/commit/221d65449453
[3/8] KVM: selftests: Move setting a vCPU's entry point to a dedicated API
      https://github.com/kvm-x86/linux/commit/53a43dd48f8e
[4/8] KVM: selftests: Add a macro to define a test with one vcpu
      https://github.com/kvm-x86/linux/commit/55f2cf88486c
[5/8] KVM: selftests: x86: Use TAP interface in the sync_regs test
      https://github.com/kvm-x86/linux/commit/ba97ed0af6fe
[6/8] KVM: selftests: x86: Use TAP interface in the fix_hypercall test
      https://github.com/kvm-x86/linux/commit/a6983e8f5fab
[7/8] KVM: selftests: x86: Use TAP interface in the vmx_pmu_caps test
      https://github.com/kvm-x86/linux/commit/de1b03f25f3b
[8/8] KVM: selftests: x86: Use TAP interface in the userspace_msr_exit test
      https://github.com/kvm-x86/linux/commit/8d251856d425

