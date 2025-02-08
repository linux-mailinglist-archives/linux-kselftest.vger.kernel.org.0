Return-Path: <linux-kselftest+bounces-26069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F657A2D2C8
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 03:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7E0C1692DE
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 02:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12C314D2A0;
	Sat,  8 Feb 2025 02:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c1rhVlNl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815A320DF4
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Feb 2025 02:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738980085; cv=none; b=YfVgU/m9EqvXXMoUAhQQRKx+RJbi5XruGvvn5RSddXuJIlPfkolVgR0j0ZjLQsxOp+zIE+TrPZaietKTqfgJS556geyKu3YkUaXM4rT2GPHW0xSovjn76UUyDUsRdjOlZ9z3dJvux0PRmHUDvpKzrKP54492QxG17RQprD7qDdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738980085; c=relaxed/simple;
	bh=bktEbC11ltHTmoTnljhEe9hWX6Banqk9ZcBh6U+q9gg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Jx/CTTMcS/Wj9lJLz2iyD9iJAONktnZlcZvF7S5eEpCLnelPz0TlYha7IYAQ0hgHVSuVlgJjYGNb86kmQWvoTmuFto0eG7MFGWcPQJH2NsK/IEJ0gvwxcAYGWrK6bTDi8KuDvyHSh9qNqB9mx21/3/SCvKAL2xqAtcIwSKnuFQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c1rhVlNl; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-71e24087e47so947982a34.3
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Feb 2025 18:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738980082; x=1739584882; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h057a6wBvbw/h7/thrY5CNdcIWE5bhRIXwUHBVJJdVc=;
        b=c1rhVlNlymaLSr1XLRaN75MUBjp/RgAMFd3JTJHV3xpBuCABr6k9aD8aR/kN18bPLo
         OesCk1RaEHMFJBXLvGOyLeGyymbIXKD/Ukpqa2IbIeYmuqCdOaqCguBy2NOP6l1JqkC/
         HJw3AptAdjgtdluQKDEc/uQZxKLLZbZ7lzY6GSiE9NC583BuWQ56cojQGml86/ny2dyd
         M/Lfa6qZBI+VmFdnP22svs807Pjlac0mQ0O0PweflANVNFaxJ/AFi9lVCGKGBTdEUQSN
         OO5ohlg25Dgg5FnDDVs4/P7CH7t2QlmEObYtY1PiX/5t1ZDJO19x37s4rI50J3kTzRW0
         UlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738980082; x=1739584882;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h057a6wBvbw/h7/thrY5CNdcIWE5bhRIXwUHBVJJdVc=;
        b=sfVYcAlJ235nezhALu44jQuqrqV+YYRjFikji6yz+JlhYArKbuXIRDGFkNL40qsDrC
         kHV2Ut6TacHl99ReN3H1q+WWAQztBxqQ0Ee1J7V1KnpXHjZDQLPRtxhF6tdVEmhpAyny
         dMaxlspv9J+QxLR0ylKjfu/0W1PFB4O1IvtL6tx5M+sKxDeoEFKhJFj4kDl3D4v7bfe1
         9sWsRt+SnbGbrQqa8v45nKpxc/yPVW4w2528QQNKkxDHVhlR/Y3oqNT9Zu8FGt2eGtAK
         Ha02CP5cf8I5JN9+nRa27Yyz0nrgB4/k9AStQe9efKl309PIBxO0o1xDFgBFI3CxYG36
         7iNw==
X-Forwarded-Encrypted: i=1; AJvYcCXhEF22i7oM9beabJN3Vf0Vj9ER9XboGkgV+yY2S19bdwvD63NNogDC4uG2j3bU5Ofd6AuZg880doxIYw6qads=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyq/l5OKPWrYpVMrZI9UGq+K03IDi2zk/2rVLO8SKfntxkhZ3T
	77o4aEUKy+oNxOHk+0s1NlsJhUA+4aOtwBhqhUN4VDpeVaZa56nW4Z41ohLKd9sGoSlZbPCBMQk
	WGx84ImH2GZiOlmgfs7uVuw==
X-Google-Smtp-Source: AGHT+IEeIQl7ICG4+Tc/ss00exHzkJsS1m2K/kNfEhqSBG/Hd5ytT4t77wwZci5K7lAYgGA5tByy2i89yzSGB3II1A==
X-Received: from otbel32.prod.google.com ([2002:a05:6830:71a0:b0:71d:e05c:915b])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6830:4989:b0:71d:62bc:85ec with SMTP id 46e09a7af769-726b87f4aecmr3709624a34.13.1738980082581;
 Fri, 07 Feb 2025 18:01:22 -0800 (PST)
Date: Sat,  8 Feb 2025 02:01:07 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250208020111.2068239-1-coltonlewis@google.com>
Subject: [RFC PATCH v2 0/4] PMU partitioning driver support
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

This series introduces support in the ARM PMUv3 driver for
partitioning PMU counters into two separate ranges by taking advantage
of the MDCR_EL2.HPMN register field.

The advantage of a partitioned PMU would be to allow KVM guests direct
access to a subset of PMU functionality, greatly reducing the overhead
of performance monitoring in guests.

While this feature could be accepted on its own merits, practically
there is a lot more to be done before it will be fully useful, so I'm
sending as an RFC for now.

v2:
* Rebase to v6.14-rc1, and take into account Oliver's debug cleanup
  changing some KVM handling of MDCR_EL2.

* Reorder patches to put related things closer together for easier
  reading.

* Ensure driver compiles for 32-bit ARM by defining 32-bit access to
  MDCR_EL2 correctly, which is called HDCR there. These will not be
  called due to the below requirement for VHE mode but a functionally
  correct definition seemed preferable to making it a no op.

* Rename parameter to reserved_host_counters to better reflect
  underlying hardware semantics and ensure host counters are easier to
  preserve.

* Document parameter with MODULE_PARM_DESC

* Restrict partitioning to VHE mode only. Using HPMN restricts the
  host counters to EL2 access only. Trying to make this work for the
  driver running at EL1 would require hypercalls for every access of
  those registers and a lot of additional handling at the KVM level.
  This would defeat the whole purpose of having the feature at
  all. Define has_vhe() on 32-bit arm to always return false.

* While Rob asked about making the parameter configurable at run time
  rather than boot time through sysfs, that is potentially very tricky
  because it is only safe to reprogram HPMN when we are certain no
  one, host or guest, is using any counters that might change
  ownership. If this is determined to be worthwhile, it should come
  after getting the core infrastructure right.

* While Marc asked about reusing the sysreg masks instead of
  redefining them for MDCR_EL2, that doesn't work because sysreg masks
  are only defined for arm64. I'm not sure how to avoid the
  duplication.

* Wrap code for determining if a counter index belongs to the host or
  guest partition in functions

* Typo fixes and additional testing

v1:
https://lore.kernel.org/kvm/20250127222031.3078945-1-coltonlewis@google.com/

Colton Lewis (4):
  perf: arm_pmuv3: Generalize counter bitmasks
  perf: arm_pmuv3: Introduce module param to partition the PMU
  perf: arm_pmuv3: Keep out of guest counter partition
  KVM: arm64: Make guests see only counters they can access

 arch/arm/include/asm/arm_pmuv3.h              |  13 ++
 arch/arm64/include/asm/arm_pmuv3.h            |  10 ++
 arch/arm64/kvm/debug.c                        |   3 +-
 arch/arm64/kvm/pmu-emul.c                     |   8 +-
 drivers/perf/arm_pmuv3.c                      | 117 ++++++++++++++++--
 include/linux/perf/arm_pmu.h                  |   2 +
 include/linux/perf/arm_pmuv3.h                |  34 ++++-
 .../selftests/kvm/arm64/vpmu_counter_access.c |   2 +-
 8 files changed, 168 insertions(+), 21 deletions(-)


base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
--
2.48.1.502.g6dc24dfdaf-goog

