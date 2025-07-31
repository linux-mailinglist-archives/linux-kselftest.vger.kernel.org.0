Return-Path: <linux-kselftest+bounces-38129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE851B177F8
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 23:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 791BA3B1756
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 21:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CAB25F79A;
	Thu, 31 Jul 2025 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1SdQupD7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4712023ABB1
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 21:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753996809; cv=none; b=SAZSdXLt26m1/HuJ7pEZqvxqLzsxFjj4CY3elJb6zcvF0n/p3B5CwkXmqv/5uMKxcD0IMsyZvhyjkU/hTY9BQjF2mVVfp3sAHzZourj7gbVUntl/7eWDx6yhh+d75EUzyyT3r33PeUpnmN//vE2YaTqGEV5OtgF5eNDUUmXX1LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753996809; c=relaxed/simple;
	bh=ap4Iq3A10A/U7xF+iUIaP24oQmDfl5UInmU7sGDN7Y4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ds5MbRI5YiR4n9lyaQbYAQ5kFIeg6a8SGAhYfepjtxM1L0h5YV0nyNfdCemAQPlX2n5dFhSmi6I58B8RCto9d8kyaeW+c0IPI1ye6zl7ULXkz4lYyRBz4wmYXq4F9Zh6dx+fjib0aGt2QlE32CZQn7qvJ3r8aBtOZpG0TN2OTxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1SdQupD7; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76bd2543889so1114126b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 14:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753996808; x=1754601608; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3LhBmNVj47n+/Xo2CBpWpkvNL4bzPFglARthS3E980E=;
        b=1SdQupD7Tg8GEmKfvBdy95SLcSzqhAL6nFHgeI5duLcSTxHo1eqZwywJKOwLXSmVxS
         IVnasdMXQaaohihhLSWyCgeqdAX9qEiTjIhksSEMi89YQcg6E8/mj7qZeS9MSUlMg+58
         5zFlN3StczjqcaoML/iCAxBTf0VOz3DGvZo7G+A8nEYBEBVeHBPQCISF2GyRQs3FgJm0
         iNQmVNhAkaxxC5aQw4sjERnT7AjVYXfFyGpGi7GFc/OgZSNW54oxRPrtHYbrAlE6CS3g
         wAg4lUlcsCpzWf6rUHZiRUgP3Xg0mCfV8Nq7bPI8gfscpEvQn0YqaJIYjF7b8+Qv2syl
         A8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753996808; x=1754601608;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3LhBmNVj47n+/Xo2CBpWpkvNL4bzPFglARthS3E980E=;
        b=aZmWkIi1/8IE1xlW5Uap7ft4ePFGXA8S8U/HSFG7NURKS5yM5VVjqQFPpCrh5PKZ5R
         2cfJGqYxvRbuR2Byl8y5VQGMdDGDn5UzgXxGFeNc80i+dlzjkqbWLCThislGTDFrPeY9
         eOcCg6p04XLqFn/NNYNqSrZ9p/uUOKq/BwLqz9SRsGhGaZKdn8xoZHZt9/FL37bfVfM5
         G/F1Zytnydfk4G772dU/MaRc2jTCk4aHwDN1Lg1iTNMdjCt8JqM3NpeTXUfsGI5EtjgB
         YwpqgWUts067I4px7Kbu+3sUACEKqWvPe18uIGlvxuqCQp5zor42L1sajkaPOYA4leyh
         kirQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpDRNHfB3c8sEJPnEB0fdfCPrB2UYQAfySzlEtAqNNwhauC8Q9WH1zsVqAWpFlEE7B6u7qZPx8IIoAv0lDnwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxODhNM0xpH4cJYTmQp1uuO3YOd3Rbmciw0ysqDTys6BYhj5cPE
	NLHcNKfvckZPp/NNVGLYKqoHnyZ4WUQipFuU3BqbfoyW51vBKmnd2dRFqEPa2qT4TvVM4zTfyM0
	WEyT5I1vhU7usIg==
X-Google-Smtp-Source: AGHT+IHVlDuY+fYNSvzWaCl78j3JqbZZEEmbQtyEYvAT3m66mv+lhaRSlgO6MH1HydCWLvX+Ha9fBEBU/p76uA==
X-Received: from pfhx36.prod.google.com ([2002:a05:6a00:18a4:b0:75f:8367:a75a])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7f93:b0:215:d611:5d9b with SMTP id adf61e73a8af0-23de80e503cmr119146637.12.1753996807524;
 Thu, 31 Jul 2025 14:20:07 -0700 (PDT)
Date: Thu, 31 Jul 2025 21:20:00 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250731212004.1437336-1-jiaqiyan@google.com>
Subject: [PATCH v1 0/4] A couple of improvements for VMM to inject external
 abort to guest
From: Jiaqi Yan <jiaqiyan@google.com>
To: maz@kernel.org, oliver.upton@linux.dev
Cc: joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	shuah@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	rananta@google.com, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

There are several situations where VMM is involved when handling
synchronous external instruction or data aborts, and often VMM
needs to inject external aborts to guest. In addition to manipulating
individual registers with KVM_SET_ONE_REG API, an easier way is to
use the KVM_SET_VCPU_EVENTS API.

This patchset adds two new features to the KVM_SET_VCPU_EVENTS API.
1. Extend KVM_SET_VCPU_EVENTS to support external instruction abort.
2. Allow userspace to emulate ESR_ELx.ISS by supplying ESR_ELx.
   In this way, we can also allow userspace to emulate ESR_ELx.ISS2
   in future.

The UAPI change for #1 is straightforward. However, I would appreciate
some feedback on the ABI change for #2:

  struct kvm_vcpu_events {
    struct {
        __u8 serror_pending;
        __u8 serror_has_esr;
        __u8 ext_dabt_pending;
        __u8 ext_iabt_pending;
        __u8 ext_abt_has_esr;
        __u8 pad[3];
        __u64 serror_esr;
        __u64 ext_abt_esr;  // <= +8 bytes
      } exception;
    __u32 reserved[10];     // <= -8 bytes
  };

The offset to kvm_vcpu_events.reserved changes, and the size of
exception changes. I think we can't say userspace will never access
reserved, or they will never use sizeof(exception). Theoretically this
is an ABI break and I want to call it out and ask if a new ABI is needed
for feature #2. For example, is it worthy to introduce exception_v2
or kvm_vcpu_events_v2.

Based on commit 7b8346bd9fce6 ("KVM: arm64: Don't attempt vLPI mappings
when vPE allocation is disabled")

Jiaqi Yan (3):
  KVM: arm64: Allow userspace to supply ESR when injecting SEA
  KVM: selftests: Test injecting external abort with ISS
  Documentation: kvm: update UAPI for injecting SEA

Raghavendra Rao Ananta (1):
  KVM: arm64: Allow userspace to inject external instruction abort

 Documentation/virt/kvm/api.rst                |  48 +++--
 arch/arm64/include/asm/kvm_emulate.h          |   9 +-
 arch/arm64/include/uapi/asm/kvm.h             |   7 +-
 arch/arm64/kvm/arm.c                          |   1 +
 arch/arm64/kvm/emulate-nested.c               |   6 +-
 arch/arm64/kvm/guest.c                        |  42 ++--
 arch/arm64/kvm/inject_fault.c                 |  16 +-
 include/uapi/linux/kvm.h                      |   1 +
 tools/arch/arm64/include/uapi/asm/kvm.h       |   7 +-
 .../selftests/kvm/arm64/external_aborts.c     | 191 +++++++++++++++---
 .../testing/selftests/kvm/arm64/inject_iabt.c |  98 +++++++++
 11 files changed, 352 insertions(+), 74 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/arm64/inject_iabt.c

-- 
2.50.1.565.gc32cd1483b-goog


