Return-Path: <linux-kselftest+bounces-25253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87DBA2006A
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 23:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2398F16510E
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 22:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136811DC996;
	Mon, 27 Jan 2025 22:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kOLmEr/I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7B71D88DB
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Jan 2025 22:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738016454; cv=none; b=ndCP52stVmMjzWgSiGlFWMXTddHnbOO5W78G7TwIFmYf4zckGUV5vZ0E6UvAYD0R1Eq3wCyxkerKo3ZwT/K1t4YaiC9S/V1mxDmKsd0OF4f/RKwQB8a82CSO0HWwXyxMUur5SJkMVgCeUIVCrmNMUabHU0yKzf3QBjehFg8bYus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738016454; c=relaxed/simple;
	bh=YR+PMK0VyLwKWhT0xbtwEKZ7//CuT8dMl7x5cZfrnYo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XgP0l83XkMiakhxDVTC8lujvVf8BnoqQxZ1k5AReh8w3iC3eFy9YNpJOyiWxyu/APHFqP8sFKXg3805Nqunuk3I+MHcUtMdxM+8SihEr2HVz4ooWNlXrRDOVGlRF1Wg4Nj0pDS6VCnPDCLBVcNQz4k+Hfprv6NPGNn1s0NRwI8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kOLmEr/I; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-5f33de5c286so1413418eaf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jan 2025 14:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738016451; x=1738621251; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VGVx2inDcPb4kyuc5g9Cp41GlSlePFgSKTBuQPtRjD4=;
        b=kOLmEr/I2Z7b+qq6+hyriOttQstMPZOWEPNMk6gAp59FyaoEAo9IauQisSA+g6Gqxk
         8G6tzvxDoHGr1HeY4O/0Ee5eE0wdbzeH6o9kxbgPwXyBmar4jcfbx89IbWVLWpZNMRlo
         Qdusesw7ECaWP3asFScycj9kC/uS8AKKLfMTlinPl+td8/BGK4qx6rWPvv0SzTazxPIN
         IvnaBJ/GLJWgv0ea2lelHayDGdOQ+fSDeqGzIBHizdqSNjzsVr5yjvbVEtp6PKufwQW3
         fTgOcmlIC4hMndIE2f4hQOuDgJ3DnEwU7it3COVo489dcwCCPwQDb3jdMjYtrQLvNlDa
         aoxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738016451; x=1738621251;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VGVx2inDcPb4kyuc5g9Cp41GlSlePFgSKTBuQPtRjD4=;
        b=XFa5FGKQsTafK+6zBtKNeljZpOrZTONCv/EI1/Ywi4QkBkeD/dRA8UtdxJLeA7Occc
         g0/ziZNsDQqs5e4XHChiSSiX+SueUOxTz0GGX1B0LSohofciQnvMQhAf53X26zvt2tCU
         u+Wt6Y+yl2nHLauIZtUa0nLdOb8cVgVr7eIxq28bFCySDb8LnbkwjrNO52Wv9O3h4uqo
         NSeyh9JnSXQ+VzhChRivp7Gbjyuv+JG772+ZdjiP+/rWyQGLDfsPyntDRS+m7V/BPcms
         z/yqq9do4ey4p+8f3vIDkOMq/o1jwmmOKH/AERbcPn6MlByKv3C5WWBhcNu0zPcLG6AR
         2w1w==
X-Forwarded-Encrypted: i=1; AJvYcCWNfHzZuVyG3RceSvr7S+qRgUT3YHDLjfw033uLdtu1F4gjKq/p0I9Fa+dPGPtQU5VO2Ukm3c05zpwmHLIO6w0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtujI++WiiXXgn1VovjmmFUs22DX1YUSgdtjymm8gA8P28u8TC
	plC+v4K/hH4KW5sWjqD8YSYk0h1dFk+WNcMKU3dcIFwLMUS22BgINyHB8tTnuk0xXTvIddf1Bgy
	V/gXE6ftQ+hV2vGP71EPtgA==
X-Google-Smtp-Source: AGHT+IEyp+zn4K8xvMBme9w+olqOdC2WoYBUbvWUqnKRlZMr1gAx+eFOYXOnePYqDL8MpO28ip3SYaynWBZeMCj6Qg==
X-Received: from oabnw13.prod.google.com ([2002:a05:6870:bb0d:b0:2b2:2b44:5abb])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6871:3a88:b0:29e:2422:49f9 with SMTP id 586e51a60fabf-2b1c0aee5efmr22900341fac.25.1738016450898;
 Mon, 27 Jan 2025 14:20:50 -0800 (PST)
Date: Mon, 27 Jan 2025 22:20:26 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250127222031.3078945-1-coltonlewis@google.com>
Subject: [RFC PATCH 0/4] PMU partitioning driver support
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

This series introduces support in the ARM PMUv3 driver for
partitioning PMU counters into two separate ranges by taking advantage
of the MDCR_EL2.HPMN register field.

The advantage of a partitioned PMU would be to allow KVM guests direct
access to a subset of PMU functionality, greatly reducing the overhead
of performance monitoring in guests.

While this series could be accepted on its own merits, practically
there is a lot more to be done before it will be fully useful, so I'm
sending as an RFC for now.

This patch is based on v6.13-rc7. It needs a small additional change
after Oliver's Debug cleanups series going into 6.14, specifically
this patch [1], because it changes kvm_arm_setup_mdcr_el2() to
initialize HPMN from a cached value read early in the boot process
instead of reading from the register. The only sensible way I can see
to deal with this is returning to reading the register.

[1] https://lore.kernel.org/kvmarm/20241219224116.3941496-3-oliver.upton@linux.dev/

Colton Lewis (4):
  perf: arm_pmuv3: Introduce module param to partition the PMU
  KVM: arm64: Make guests see only counters they can access
  perf: arm_pmuv3: Generalize counter bitmasks
  perf: arm_pmuv3: Keep out of guest counter partition

 arch/arm/include/asm/arm_pmuv3.h              |  10 ++
 arch/arm64/include/asm/arm_pmuv3.h            |  10 ++
 arch/arm64/kvm/pmu-emul.c                     |   8 +-
 drivers/perf/arm_pmuv3.c                      | 113 ++++++++++++++++--
 include/linux/perf/arm_pmu.h                  |   2 +
 include/linux/perf/arm_pmuv3.h                |  34 +++++-
 .../kvm/aarch64/vpmu_counter_access.c         |   2 +-
 7 files changed, 160 insertions(+), 19 deletions(-)


base-commit: 5bc55a333a2f7316b58edc7573e8e893f7acb532
--
2.48.1.262.g85cc9f2d1e-goog

