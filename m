Return-Path: <linux-kselftest+bounces-42999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FD2BD4CB1
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 18:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D9424FE1C9
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 15:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5922F83D8;
	Mon, 13 Oct 2025 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Igei7WhK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFF326E6F6
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368532; cv=none; b=g1+IxxvrlKXdPM+VwYrBKkFcHHySSfPt3zUPEI1jw32aAjF4IPiNBA8p4d+ljlshPXrHZZAKM+K9oF0IsBMUHq7E8TJjIcb1m3uraZ1EFBGsGtbiB3sEZID3oILg09mpgPYLsOSfQGn84U6Fl/yqXgiEsMoR9UugRnyF/x3e21k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368532; c=relaxed/simple;
	bh=u9a3zosxSdz3WZpPJYTywNjxVaWRBJXzveMfBERek7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EX3P4Ug0OR4ALBCtGFqsEa+vGK0bPXtAygfweqR0INlK90A0YMsTC0uCjQIfLMoIvpEfyarXzxTc2TUIvGQgGERKZ/iJuKhjn23x3aKu+LC32miBWqVNTnIVuIzPWGAYm0UHYkGf1l/OOhCpmX2LjyweKj3ns9ffU3a8EyFKbeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Igei7WhK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e34052bb7so52228525e9.2
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 08:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760368529; x=1760973329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H9v2BaCzqTwwaKihxHneX2NKtRg+AsrUK2wCvz8acXU=;
        b=Igei7WhKP5Kaz1JuzN2EnBPWGVEewypfuD6vJmbwH+Cy3T41RVr8URMXUjWTgRF3PM
         cMz/L8mjH3/Li2MzJp3LKA5yCja0tqM6K0aLswC2VsgG3UXB9OUHE7R6j9lPEZdGC2bc
         942h+8L/L5bhnhpgrEA0DSlR5m9s/jO+a1xWnELlCLsFRPC75S6nwvxHj0/PRwxtGgjI
         6GtnsDzDnEYr2YO7fWy3e1lOeTYqo8RgLvwbTno3K9BHRL+UWbVM9mWCFqppK9b7Oy29
         aj5FxRNjG3XhwwAo1L551Moa2Vm+Dp8LAKgcR7DVWcFkHdiKWb5bb5Fff1iAAwBl2G9V
         888A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760368529; x=1760973329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H9v2BaCzqTwwaKihxHneX2NKtRg+AsrUK2wCvz8acXU=;
        b=BCjQCCbBfmadKLhNUd/d8px7/K50sMqfHGvix6t6PeFjL4SZy+p7I9pJyJu6dt6VYV
         shO5Jdc6CP0IPDemsvE0xbdfW9wihxAMRTBCcJbWLk4rHzTmG8uQXa/GWWvmuWT6atka
         55k+yEEoiSmTBfcOulKPnwUoZHZZNlbCHFhHYYGxAMwZeQuVOObwcHuaiKB6D7tm3FT5
         QxR+CKDgnFhyu0V6QZSEN3MWEFYvv0q8kz2aFlB4mQLc4BzIII+4/fD93plat1aPh1km
         UMDMUxZiZan4OYqXU1X0qHx1LVjIwZeWheYlwz96AdqGtehhbHtOmlUPec8kNq4iDBVw
         tjow==
X-Forwarded-Encrypted: i=1; AJvYcCVUURAMfIgdjkFLFynlHd6ezrmy0Nt9qt/VriG9t4qJXqN7FbklILqTYyBdY8B+2QiCc7VEgPHodpV+5g99w28=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLMZSZJY2qt6Bcr1SHjdAMXEmesblN+bRLWVc7mQX+F+hki5JS
	+xooazV10tq5koZzEavVMnnfiOqtWSk8TtwAqxiNRL1UzsZ9s2tNv65G
X-Gm-Gg: ASbGncs3XbRJybkROu3PHJORYtp6G52fzVJ6ZXQ6Z4Ab69vOVoJGXGYFKQ3TMrGvao9
	9uAcx8SSePf7TN/e9Cjy+gFp/48QDdEbj+gNy9dxkuo1Hw9kMQslgfiHM6p9VFWXgjxd3nWMAlX
	sN+O4hEza+rdP+gok3kobqyM556xKOTh9dGPlZryhNKyCbnfBGQa5X0vfkWm9NEDLrXwnjQLX68
	8gKZaJfOsHJ5aC05HghmXUU+wikPMQXZS4r84h/7W912aUJ4M9Lu9sPqPiaxdQI/VkqNK3E14ro
	8CkhXbUMuG9x2s2bQeTtxe5/D6O9iFW6oQxJmn8azwmJkFV8v3sJeeOAtzklvkol9QqLr2n/gJx
	btNPNF7CYbEv8W3OHuShS4NHpwXDJ9W0HHUAKHDEjMjAUXcARVV4lVzXZfgSZmMiX8bDzLSXGdL
	qJhQA77nKEkBCV9SY=
X-Google-Smtp-Source: AGHT+IFb9QSIj2pT5DqJHOGWLZeoKzR1HcGUwSCz8TPcIH2zmr4COlYJoCPacXO6TFFsZZUZ1uzZWw==
X-Received: by 2002:a05:600c:1c23:b0:46e:32a5:bd8d with SMTP id 5b1f17b1804b1-46fa9a892d7mr154828545e9.3.1760368529113;
        Mon, 13 Oct 2025 08:15:29 -0700 (PDT)
Received: from f4d4888f22f2.ant.amazon.com.com ([15.248.3.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab36a773sm135545825e9.0.2025.10.13.08.15.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Oct 2025 08:15:28 -0700 (PDT)
From: Jack Thomson <jackabt.amazon@gmail.com>
To: maz@kernel.org,
	oliver.upton@linux.dev,
	pbonzini@redhat.com
Cc: joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	isaku.yamahata@intel.com,
	roypat@amazon.co.uk,
	kalyazin@amazon.co.uk,
	jackabt@amazon.com
Subject: [PATCH v2 0/4] KVM ARM64 pre_fault_memory
Date: Mon, 13 Oct 2025 16:14:57 +0100
Message-ID: <20251013151502.6679-1-jackabt.amazon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Thomson <jackabt@amazon.com>

This patch series adds ARM64 support for the KVM_PRE_FAULT_MEMORY
feature, which was previously only available on x86 [1]. This allows us
to reduce the number of stage-2 faults during execution. This is of
benefit in post-copy migration scenarios, particularly in memory
intensive applications, where we are experiencing high latencies due to
the stage-2 faults.

Patch Overview:

 - The first patch adds support for the KVM_PRE_FAULT_MEMORY ioctl
   on arm64.

 - The second patch fixes an issue with unaligned mmap allocations
   in the selftests.

 - The third patch updates the pre_fault_memory_test to support
   arm64.

 - The last patch extends the pre_fault_memory_test to cover
   different vm memory backings.

=== Changes Since v1 [2] ===

Addressing feedback from Oliver:

 - No pre-fault flag is passed to user_mem_abort() or gmem_abort() now
   aborts are synthesized.
 - Remove retry loop from kvm_arch_vcpu_pre_fault_memory()

[1]: https://lore.kernel.org/kvm/20240710174031.312055-1-pbonzini@redhat.com
[2]: https://lore.kernel.org/all/20250911134648.58945-1-jackabt.amazon@gmail.com

Jack Thomson (4):
  KVM: arm64: Add pre_fault_memory implementation
  KVM: selftests: Fix unaligned mmap allocations
  KVM: selftests: Enable pre_fault_memory_test for arm64
  KVM: selftests: Add option for different backing in pre-fault tests

 Documentation/virt/kvm/api.rst                |   3 +-
 arch/arm64/kvm/Kconfig                        |   1 +
 arch/arm64/kvm/arm.c                          |   1 +
 arch/arm64/kvm/mmu.c                          |  73 +++++++++++-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  12 +-
 .../selftests/kvm/pre_fault_memory_test.c     | 110 +++++++++++++-----
 7 files changed, 163 insertions(+), 38 deletions(-)


base-commit: 42188667be387867d2bf763d028654cbad046f7b
-- 
2.43.0


