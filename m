Return-Path: <linux-kselftest+bounces-33539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6EBAC183E
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 01:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD2B1C00F4C
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 23:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB8B2D1929;
	Thu, 22 May 2025 23:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ULz4GHsY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB2C2517A4
	for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 23:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747957957; cv=none; b=JT87s/4yKEL1f9rZEQcYdDRnyGzRTMlXA1etA7i+/R7/hzqbYdgcJ6mHUS8YNWpue2fauFLIUqoK7XOzJ/FxM7TR2+RnL4RkemQu7fe5Jqu+XVgbjuZW66tmY48yWU1G5ChOTlVvzyG9qlDX3Xn15xAberUZzJMfh9wUR+/74As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747957957; c=relaxed/simple;
	bh=zSgoAnQejqHLW8WQDINPRPjIjmA3d28SSrIQu0zseIM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eCUEV1y1meX87UJ9ckajKPXsoLx079HWIL7BDjs/FHLeFTVZD4B6kWccOJ+IxqRQM72z+g9gmbD51RoUrsxbZbNbo5LfnfqeDG12/h20u38hMdUXcFoqcrtr/QBD5khGrJy0y2biYMuwnNYsAogrR1wQ6hJxL04GVb92aruPJQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ULz4GHsY; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2c00e965d0so1147812a12.2
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 16:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747957954; x=1748562754; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tip5ipIFHbSR2IYZnXAE5GbVsPWdm0Tjm7OJATFbViQ=;
        b=ULz4GHsYOvh2Ael9HI/x/F31hudaA9TeW5lNbjoUwDz07MEKj/eObudf4pcFkxpdIp
         pzGWquGWbWaolyT0yJaRf38cuYTiKV7H99KU4IqdYInDUOykiEUtY3dvIW1wZmxoVmy6
         hxPaOdVZ3Yuf+UP4JWsk7aTwqaLfGUW+4q454NUjXgMdYgTVxm0mZ15IvMbllQYPn1Md
         5f2j56ddfUfYycDBZHhz5skPykoNBt9av4ozJ2MAYSim9jYo2Kuw1PnwVTLcZkMYQlwe
         V1UgezwL3IMHXijaQWN6vqt09pX3MjM2Bk/DVKVm3NhuvXivpjMBO+dJCrSyXUhrRt0c
         rFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747957954; x=1748562754;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tip5ipIFHbSR2IYZnXAE5GbVsPWdm0Tjm7OJATFbViQ=;
        b=JXLPzPvulaQUFFPBRbYQPw/eaAvIt0hJy0a5lg/N/8LtDxFNDadZHgzBC2EcFiD7nS
         FqGG6v2k55u425sXhCnVNMXyX+eaRz5bS4jwB9SMfkqpsnqJbDE6tLgfqcqVAbe89dhC
         gvCkQe/3ECrohsiAY+w/PIDZv0ynlLBuorVat2JAVCovVfsQGlddE5NvjGKoL+ji+cAG
         ewbnXimCjtSOAMbdrhULpzCllmNTamK9KHVmWF+WIMmgPpTWbUsyvJf7GxVthoqPTUts
         92J/PpwQR1QuNq7LjBKSltgjB3NNJXmZk6lYWKop++IBRCoo6TShku2ixcgcRf2U+5aO
         exNg==
X-Forwarded-Encrypted: i=1; AJvYcCVe1RL3Fjv0nA4al7ipfY8K26A75mEC1SAvOmCS5aMLwYrAlrNZlBdORqa+473tE69ftsjJDHJXj/ufarmz+qM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdUTF4jlu1X14y2SLKJlXzyuYIvh1Qxmlm9GFfRaycRMhDv06h
	HZbYUk4PF9zfBKUUlCpxTPEsA8JDgeqvRQByE6dmTSngngAABAVRgXDreCkAME+wSdfbDx8iIW2
	89YMQXQ==
X-Google-Smtp-Source: AGHT+IFoFNCkbt8aJJ0xnDKCzmCnIh6gGll4rd5AbALinv7jGcAxGvJdpWgEmk1cX+UlvCwIOcTYID0HpNU=
X-Received: from pjtu15.prod.google.com ([2002:a17:90a:c88f:b0:30a:2020:e2bd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d604:b0:303:75a7:26a4
 with SMTP id 98e67ed59e1d1-30e7d4fea75mr43035958a91.7.1747957954327; Thu, 22
 May 2025 16:52:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 16:52:10 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250522235223.3178519-1-seanjc@google.com>
Subject: [PATCH v3 00/13] KVM: Make irqfd registration globally unique
From: Sean Christopherson <seanjc@google.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Shuah Khan <shuah@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, K Prateek Nayak <kprateek.nayak@amd.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Non-KVM folks,

I am hoping to route this through the KVM tree (6.17 or later), as the non-KVM
changes should be glorified nops.  Please holler if you object to that idea.

Hyper-V folks in particular, let me know if you want a stable topic branch/tag,
e.g. on the off chance you want to make similar changes to the Hyper-V code,
and I'll make sure that happens.


As for what this series actually does...

Rework KVM's irqfd registration to require that an eventfd is bound to at
most one irqfd throughout the entire system.  KVM currently disallows
binding an eventfd to multiple irqfds for a single VM, but doesn't reject
attempts to bind an eventfd to multiple VMs.

This is obviously an ABI change, but I'm fairly confident that it won't
break userspace, because binding an eventfd to multiple irqfds hasn't
truly worked since commit e8dbf19508a1 ("kvm/eventfd: Use priority waitqueue
to catch events before userspace").  A somewhat undocumented, and perhaps
even unintentional, side effect of suppressing eventfd notifications for
userspace is that the priority+exclusive behavior also suppresses eventfd
notifications for any subsequent waiters, even if they are priority waiters.
I.e. only the first VM with an irqfd+eventfd binding will get notifications.

And for IRQ bypass, a.k.a. device posted interrupts, globally unique
bindings are a hard requirement (at least on x86; I assume other archs are
the same).  KVM and the IRQ bypass manager kinda sorta handle this, but in
the absolute worst way possible (IMO).  Instead of surfacing an error to
userspace, KVM silently ignores IRQ bypass registration errors.

The motivation for this series is to harden against userspace goofs.  AFAIK,
we (Google) have never actually had a bug where userspace tries to assign
an eventfd to multiple VMs, but the possibility has come up in more than one
bug investigation (our intra-host, a.k.a. copyless, migration scheme
transfers eventfds from the old to the new VM when updating the host VMM).

v3:
 - Retain WQ_FLAG_EXCLUSIVE in mshv_eventfd.c, which snuck in between v1
   and v2. [Peter]
 - Use EXPORT_SYMBOL_GPL. [Peter]
 - Move WQ_FLAG_EXCLUSIVE out of add_wait_queue_priority() in a prep patch
   so that the affected subsystems are more explicitly documented (and then
   immediately drop the flag from drivers/xen/privcmd.c, which amusingly
   hides that file from the diff stats).

v2:
 - https://lore.kernel.org/all/20250519185514.2678456-1-seanjc@google.com
 - Use guard(spinlock_irqsave). [Prateek]

v1: https://lore.kernel.org/all/20250401204425.904001-1-seanjc@google.com


Sean Christopherson (13):
  KVM: Use a local struct to do the initial vfs_poll() on an irqfd
  KVM: Acquire SCRU lock outside of irqfds.lock during assignment
  KVM: Initialize irqfd waitqueue callback when adding to the queue
  KVM: Add irqfd to KVM's list via the vfs_poll() callback
  KVM: Add irqfd to eventfd's waitqueue while holding irqfds.lock
  sched/wait: Drop WQ_FLAG_EXCLUSIVE from add_wait_queue_priority()
  xen: privcmd: Don't mark eventfd waiter as EXCLUSIVE
  sched/wait: Add a waitqueue helper for fully exclusive priority
    waiters
  KVM: Disallow binding multiple irqfds to an eventfd with a priority
    waiter
  KVM: Drop sanity check that per-VM list of irqfds is unique
  KVM: selftests: Assert that eventfd() succeeds in Xen shinfo test
  KVM: selftests: Add utilities to create eventfds and do KVM_IRQFD
  KVM: selftests: Add a KVM_IRQFD test to verify uniqueness requirements

 drivers/hv/mshv_eventfd.c                     |   8 ++
 include/linux/kvm_irqfd.h                     |   1 -
 include/linux/wait.h                          |   2 +
 kernel/sched/wait.c                           |  22 ++-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 tools/testing/selftests/kvm/arm64/vgic_irq.c  |  12 +-
 .../testing/selftests/kvm/include/kvm_util.h  |  40 ++++++
 tools/testing/selftests/kvm/irqfd_test.c      | 130 ++++++++++++++++++
 .../selftests/kvm/x86/xen_shinfo_test.c       |  21 +--
 virt/kvm/eventfd.c                            | 130 +++++++++++++-----
 10 files changed, 302 insertions(+), 65 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/irqfd_test.c


base-commit: 45eb29140e68ffe8e93a5471006858a018480a45
-- 
2.49.0.1151.ga128411c76-goog


