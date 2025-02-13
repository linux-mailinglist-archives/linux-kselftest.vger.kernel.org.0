Return-Path: <linux-kselftest+bounces-26566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 016FAA34D1B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 19:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9A201884CB8
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 18:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AA3245006;
	Thu, 13 Feb 2025 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EmGFHf8j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18E724167F
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 18:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469917; cv=none; b=AQd3dkhEr6o3oLj3ob62zvTXXWsyb2cvL3QQRGZ9pesLqbNdQLmTo0v9+Uz6psIt76U58CgPSrsWujb3ZX/vnHux7xzT7SjZm1Ft4mmi/dYPohtZP5jfPVQZst2i18v+DLx4qMeLnbjWd+xWxYKNHPQJP47utJdZOCmLoUCJuAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469917; c=relaxed/simple;
	bh=XXMTdbhQZ5qRWr2cYeBk2dfkftdsQbT7KMI+qPc6Who=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QOX+5jN1uKuYlvWcYGNsBFLyEKeLXFRdQYXVdd/Q4SuSlLpdGgDm8QDIW4IuLJ5gycJSybgl6mGOv3TlUc6fTisdr58fRt3b0ZJv7xTDMWCn2CRZLj1WC6McFctmyh40cU/sDZRoWF0gR5d0W4GUL2EBKir0av71NsR+RUd/wPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EmGFHf8j; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-726e6412e1fso998042a34.1
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 10:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739469915; x=1740074715; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wTjCHNALhtJm9kkINHAhPaKfRIpf+UugZZ6g0+G4iFA=;
        b=EmGFHf8jepiFEAaXm5sNdcjafuaoVfLuX55JiA1q8N6pAz0IOi9JZfN0vENo45j+Yd
         SKyIOEmXpKzHRcwRE+NthrfBBdtli3TulWoZT9M+DHN0dyX+V85YjBWZ6xr+xztf8F4p
         3j/9lrjRazLCzR/CE7rhxch2c0s00viAmyaRVweOKF3wFayyqNUTuIiXMDhsU6Nu+ikH
         KuLWWe79aGdWW0RiJ617DhZ35hO9BpLybPLWUB7KhsZC7LmsAFWPx6Wotg3at4gSsBo/
         pYX32BBXTkb3tZafhGczlppzCo0WWWklKC1yE3cWPrPBiFGyg6OXigVXorHAVp8Hgn/h
         uIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739469915; x=1740074715;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wTjCHNALhtJm9kkINHAhPaKfRIpf+UugZZ6g0+G4iFA=;
        b=swD1Qwjtew4g1hUrejjoi/NdiJfVpzKAmsz3EU0e7rLOYUzLWXXkNEDJSTInAQcZ0I
         LuP25ANX5DQ/nTw8E7thR1/qXdfCB20uKSLOian7vnpb9bkCWpXWHWt7J9ykRL39xIEf
         wDlHrT1JDQe25P8IfUc3m6Kn5JraQanTDimjFt5TyC+cdnSpIxm4NyWysYRb/JYPNOJG
         pLnEFAYpwDNqnBVhs8WcmQih1ec26sDIlCRSC2TeJJ5gvUtQNqHnz1ZDks/eFA7vVK8K
         zeYIHbl/fZM//udJaHz4N687bG99Nb0q7Ff0/tb6AsgemSU0gT+04Ph4EXl71Bzpx2+j
         4Fgw==
X-Forwarded-Encrypted: i=1; AJvYcCW6SZoqlQ2Vjm41DIL0w0VUZSIS/3o5LIwnY/RfpEYpBWC/LYxOy/tDd8wp3KLeeIqd5GXp44GVBNnP7bVU53E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlo6UYAXyE8GQneA62YLcPlaf/wAIlI8J3rdU/+04niu/z/TD3
	9an5Fwk18C0co1hIOwnBtGsFB4zbVM5toZtHoDwsny3tJ1Fcf0WbqNrkTTzAmbAXt8bEd1ANnGv
	VHeuSCm5a1TwJsxyWuDAvZw==
X-Google-Smtp-Source: AGHT+IGskVqY6i9bRXfX/e76DJqFlexfmJ+792ViVNAj9Su+9gvc9IWKEbkYdQXuRHWIlqliVBeP0nYN3f0kCSEvKQ==
X-Received: from otbcv2.prod.google.com ([2002:a05:6830:6882:b0:71d:f81f:c595])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6830:410a:b0:71d:415a:5d18 with SMTP id 46e09a7af769-726f302e609mr5209306a34.3.1739469914886;
 Thu, 13 Feb 2025 10:05:14 -0800 (PST)
Date: Thu, 13 Feb 2025 18:03:09 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250213180317.3205285-1-coltonlewis@google.com>
Subject: [RFC PATCH v3 0/8] PMU partitioning driver support
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

This series introduces support in the KVM and ARM PMUv3 driver for
partitioning PMU counters into two separate ranges by taking advantage
of the MDCR_EL2.HPMN register field.

The advantage of a partitioned PMU would be to allow KVM guests direct
access to a subset of PMU functionality, greatly reducing the overhead
of performance monitoring in guests.

While this feature could be accepted on its own merits, practically
there is a lot more to be done before it will be fully useful, so I'm
sending as an RFC for now.

v3:
* Include cpucap definition for FEAT_HPMN0 to allow for setting HPMN
  to 0

* Include PMU header cleanup provided by Marc [1] with some minor
  changes so compilation works

* Pull functions out of pmu-emul.c that aren't specific to the
  emulated PMU. This and the previous item aren't strictly
  needed but they provide a nicer starting point.

* As suggested by Oliver, start a file for partitioned PMU functions
  and move the reserved_host_counters parameter and MDCR handling into
  KVM so the driver does not have to know about it and we need fewer
  hacks to keep the driver working on 32-bit ARM. This was not a
  complete separation because the driver still needs to start and stop
  the host counters all at once and needs to toggle MDCR_EL2.HPME to
  do that. Introduce kvm_pmu_host_counters_{enable,disable}()
  functions to handle this and define them as no ops on 32-bit ARM.

* As suggested by Oliver, don't limit PMCR.N on emulated PMU. This
  value will be read correctly when the right traps are disabled to
  use the partitioned PMU

v2:
https://lore.kernel.org/kvm/20250208020111.2068239-1-coltonlewis@google.com/

v1:
https://lore.kernel.org/kvm/20250127222031.3078945-1-coltonlewis@google.com/

[1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=kvm-arm64/pmu-includes

Colton Lewis (7):
  arm64: cpufeature: Add cap for HPMN0
  arm64: Generate sign macro for sysreg Enums
  KVM: arm64: Reorganize PMU functions
  KVM: arm64: Introduce module param to partition the PMU
  perf: arm_pmuv3: Generalize counter bitmasks
  perf: arm_pmuv3: Keep out of guest counter partition
  KVM: arm64: selftests: Reword selftests error

Marc Zyngier (1):
  KVM: arm64: Cleanup PMU includes

 arch/arm/include/asm/arm_pmuv3.h              |   2 +
 arch/arm64/include/asm/arm_pmuv3.h            |   2 +-
 arch/arm64/include/asm/kvm_host.h             | 199 +++++++-
 arch/arm64/include/asm/kvm_pmu.h              |  47 ++
 arch/arm64/kernel/cpufeature.c                |   8 +
 arch/arm64/kvm/Makefile                       |   2 +-
 arch/arm64/kvm/arm.c                          |   1 -
 arch/arm64/kvm/debug.c                        |  10 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h       |   1 +
 arch/arm64/kvm/pmu-emul.c                     | 464 +-----------------
 arch/arm64/kvm/pmu-part.c                     |  63 +++
 arch/arm64/kvm/pmu.c                          | 454 +++++++++++++++++
 arch/arm64/kvm/sys_regs.c                     |   2 +
 arch/arm64/tools/cpucaps                      |   1 +
 arch/arm64/tools/gen-sysreg.awk               |   1 +
 arch/arm64/tools/sysreg                       |   6 +-
 drivers/perf/arm_pmuv3.c                      |  73 ++-
 include/kvm/arm_pmu.h                         | 204 --------
 include/linux/perf/arm_pmu.h                  |  16 +-
 include/linux/perf/arm_pmuv3.h                |  27 +-
 .../selftests/kvm/arm64/vpmu_counter_access.c |   2 +-
 virt/kvm/kvm_main.c                           |   1 +
 22 files changed, 882 insertions(+), 704 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_pmu.h
 create mode 100644 arch/arm64/kvm/pmu-part.c
 delete mode 100644 include/kvm/arm_pmu.h


base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
--
2.48.1.601.g30ceb7b040-goog

