Return-Path: <linux-kselftest+bounces-35711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6FBAE6FDE
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 21:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18B51896046
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 19:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9522D2E7F03;
	Tue, 24 Jun 2025 19:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DfQy3sbI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EA726AAB2
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 19:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750794087; cv=none; b=rX/9eeBlxktv4kK/nfvMygmPRpFDtYP5+0n0uSweAQUJMWYlycTkxa5oV+zGlO6+G5YZMf0Nz4Po0ibPu46TaMdZHV8tINDMUWFcDRrgcezfT39WIXKig95M8DA0EowoDgaSPyDVarcOcyngDNAPsw/fl9jZtiBacVuWpbceUYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750794087; c=relaxed/simple;
	bh=vQBizulpamY6aAnwr2Udqj2t0ugWwP7/x4nvzsw17Cw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sDOGbKd8/GXa/UEpIbTkSVwDr9OGevgF3eXCNmZfVc8Z5sDTN0e1pqX2bG5DTEwcNb+bPJHyocjdMDSunvJXZI7tDwwQVgRBg2acl1elxNMdtuAgIZCzn/2pTeAcy229cEPx/PYas0mpVaJBExzLP4a7y+c/WkUtc2w6EVaMRko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DfQy3sbI; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-747ddba7c90so4681466b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 12:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750794085; x=1751398885; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FUFFiUTwDIQTjkS/XGuKJUupkz/Ptibx0+U0nupMqZk=;
        b=DfQy3sbI6surt6H1SiPASeAhF6wBz+7Yz5Vh0wvIT3fRHtNYQa4rfMCbGj36KjszqO
         vPQjaFFCWPnzFAEq4rhYe8rrDechfSxv15JJyjU2JcxS0Tl+CCqv2IL58yAdL9p9rKyl
         /ZN5PATkU85eE2Zz1zAf7/EhVVFq1fHSRL6WpDwxaK8Jz5VZZIn3l2YxqTLhbD8E51oZ
         UQmitQgleaang4jLvJ46swu5+90fi6/n9ZqvOTjQ+fg0FS7p7heTz2k+SO4syv7eI47K
         0iD5e3jZLfcNFCvt2XFEiBY/1+8q0fyTBQG6An3H3Cfifu8bIjaGnZZhbzBYE/dz9etO
         YUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750794085; x=1751398885;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUFFiUTwDIQTjkS/XGuKJUupkz/Ptibx0+U0nupMqZk=;
        b=CVx9Jn9pYN8lTfZ682hL6XagK59w2bOfJnGZeK8s+s2hroX7UCNjDMfK6VAZ4YCLC/
         KnYfpFWcl7UvnLy2YFuMxjExDVWNgXfx4CVLxWXHfYbDdOO/SdjaSlq4ua/vPltsJ5PZ
         G0EJBENuvkDlU3qyiiQPqxR6SjaGaFi4AQhexmInyph0bZ1ke97Dx/sQGg7aUf4JWd1Z
         PqPm73lWfxYSvB5G/prQeOT+wLSXIz1VFbqLAH0KR6XIeLffSVIMrFzC9fI9vCUHbzJ8
         NTkOzmftxyEuiS7pJUPhXHaP9/Hk8jtyEXhFOr3EQshWr+PmNI+k+MuqExSuK55OZPT1
         QhMg==
X-Forwarded-Encrypted: i=1; AJvYcCV8UaNno488deBQZBgP3k6y6emQugz0SltO3rNZF2W/A/a92SEMa8HbSUnq0DhUMjgVsz920T/sbghNTnDWlsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlXWC1n/+jm9EueyS057P31twOexJAo88BPizYui1sOKmUIYso
	h17+VfR4UpeimM9J+1DSl8tqmILf/TgzSILuahAPsp/unh3YfaSfQUFUnfytXfj2EQnH0SQOgig
	jPECfag==
X-Google-Smtp-Source: AGHT+IHYexPIgCTXbHegrNWRwV9PAsICfBY+CW50dlQj/EuWE5JzEYSKqjcY5P3xX5xOKDb9+UElHwxg8eM=
X-Received: from pfrb8.prod.google.com ([2002:aa7:8ec8:0:b0:746:32ae:99d5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:170d:b0:748:1bac:ad5f
 with SMTP id d2e1a72fcca58-74ad455d619mr461113b3a.12.1750794085384; Tue, 24
 Jun 2025 12:41:25 -0700 (PDT)
Date: Tue, 24 Jun 2025 12:38:26 -0700
In-Reply-To: <20250522235223.3178519-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250522235223.3178519-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <175079267460.517177.7949210108988821172.b4-ty@google.com>
Subject: Re: [PATCH v3 00/13] KVM: Make irqfd registration globally unique
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, K Prateek Nayak <kprateek.nayak@amd.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 22 May 2025 16:52:10 -0700, Sean Christopherson wrote:
> Non-KVM folks,
> 
> I am hoping to route this through the KVM tree (6.17 or later), as the non-KVM
> changes should be glorified nops.  Please holler if you object to that idea.
> 
> Hyper-V folks in particular, let me know if you want a stable topic branch/tag,
> e.g. on the off chance you want to make similar changes to the Hyper-V code,
> and I'll make sure that happens.
> 
> [...]

Applied to kvm-x86 irqs, thanks!

[01/13] KVM: Use a local struct to do the initial vfs_poll() on an irqfd
        https://github.com/kvm-x86/linux/commit/283ed5001d68
[02/13] KVM: Acquire SCRU lock outside of irqfds.lock during assignment
        https://github.com/kvm-x86/linux/commit/140768a7bf03
[03/13] KVM: Initialize irqfd waitqueue callback when adding to the queue
        https://github.com/kvm-x86/linux/commit/b5c543518ae9
[04/13] KVM: Add irqfd to KVM's list via the vfs_poll() callback
        https://github.com/kvm-x86/linux/commit/5f8ca05ea991
[05/13] KVM: Add irqfd to eventfd's waitqueue while holding irqfds.lock
        https://github.com/kvm-x86/linux/commit/86e00cd162a7
[06/13] sched/wait: Drop WQ_FLAG_EXCLUSIVE from add_wait_queue_priority()
        https://github.com/kvm-x86/linux/commit/867347bb21e1
[07/13] xen: privcmd: Don't mark eventfd waiter as EXCLUSIVE
        https://github.com/kvm-x86/linux/commit/a52664134a24
[08/13] sched/wait: Add a waitqueue helper for fully exclusive priority waiters
        https://github.com/kvm-x86/linux/commit/0d09582b3a60
[09/13] KVM: Disallow binding multiple irqfds to an eventfd with a priority waiter
        https://github.com/kvm-x86/linux/commit/2cdd64cbf990
[10/13] KVM: Drop sanity check that per-VM list of irqfds is unique
        https://github.com/kvm-x86/linux/commit/b599d44a71f1
[11/13] KVM: selftests: Assert that eventfd() succeeds in Xen shinfo test
        https://github.com/kvm-x86/linux/commit/033b76bc7f06
[12/13] KVM: selftests: Add utilities to create eventfds and do KVM_IRQFD
        https://github.com/kvm-x86/linux/commit/74e5e3fb0dd7
[13/13] KVM: selftests: Add a KVM_IRQFD test to verify uniqueness requirements
        https://github.com/kvm-x86/linux/commit/7e9b231c402a

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next

