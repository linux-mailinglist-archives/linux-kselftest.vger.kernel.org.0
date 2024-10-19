Return-Path: <linux-kselftest+bounces-20202-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5D99A5013
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 19:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B801F27BB1
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 17:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8BD18EFED;
	Sat, 19 Oct 2024 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BnL39VAo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B77C193071;
	Sat, 19 Oct 2024 17:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729358730; cv=none; b=lgbcs0ODTsQpX3MsoQmvvTWQEVR8nh+SYd9IQQx8OhlERIMxHWiveQsbEpuXsDj/h/Zs7XKUxAYk0NGpPxfTzTstn4ji2cShZ7lO8YBp+g3kS///bTFgro8NQ9aUIzDAsupLUD0s2A1W5D92pY6HB1GVcQPhwmJgP96tY9qOLgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729358730; c=relaxed/simple;
	bh=fOHobdQzoSXyBwD3dsB+RBry+eqWCyXtH1gUwcrrAiI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=u9PYCEXbyJtNSSMLOkmcRkXtqgGuoj84TMPL5upxnCUHfeAFV+KVFEHoq5R7uXIYvAFetrZ01Gc4460iaJhBGmp3BVCYMbDnUhFppsZDdEQaXG2Z7QGd485c+MjHk1/mvnOsRlkhHsOSN4Fg9oTKWrKIXLvdiap8oU1hCpfDm/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BnL39VAo; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=5YLutNzESNkxMmo97oZ/EbstfXGBSrHKF7ypmg9VFCI=; b=BnL39VAobe3LZZiasMKWHfLfbV
	zyMhUD3txQILUYDLEVbBB/02u0evfbEIbO+818gzUUDs8Iz0zYpQG+W63gC9fJ+DrJDymD68pWBh1
	sWRCoABQFLB4+QwJTB8WAleNbygxnSsgjMf9v3eDJelskkYguREgwjFzK6bREvzJz0Celhnkhz/AM
	4NTZO4AcuSKA1rPjq/iYEFZ5Mj5mBSNGn9VH7aOlvlJFoDXJcNmLZpN7Hh9j06TgDJ47g2U5aK//z
	07JzNhzlgZPlUuN0lC4oXqW9b0iMwhIeWcnEjxpxw9VXI63DyZIx+54VItxgTfZPXwcsXOuVcKnuB
	ys8uo5kA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t2DCM-00000007ZXe-2yNP;
	Sat, 19 Oct 2024 17:25:07 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1t2DCI-00000009TKV-2teL;
	Sat, 19 Oct 2024 18:25:02 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Francesco Lavra <francescolavra.fl@gmail.com>,
	Miguel Luis <miguel.luis@oracle.com>
Subject: [PATCH v6 0/6] Add PSCI v1.3 SYSTEM_OFF2 support for hibernation
Date: Sat, 19 Oct 2024 18:15:41 +0100
Message-ID: <20241019172459.2241939-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

The PSCI v1.3 spec (https://developer.arm.com/documentation/den0022)
adds support for a SYSTEM_OFF2 function enabling a HIBERNATE_OFF state
which is analogous to ACPI S4. This will allow hosting environments to
determine that a guest is hibernated rather than just powered off, and
ensure that they preserve the virtual environment appropriately to
allow the guest to resume safely (or bump the hardware_signature in the
FACS to trigger a clean reboot instead).

This updates KVM to support advertising PSCI v1.3, and unconditionally
enables the SYSTEM_OFF2 support when PSCI v1.3 is enabled.

For the guest side, add a new SYS_OFF_MODE_POWER_OFF handler with higher
priority than the EFI one, but which *only* triggers when there's a
hibernation in progress. There are other ways to do this (see the commit
message for more details) but this seemed like the simplest.

Version 2 of the patch series splits out the psci.h definitions into a
separate commit (a dependency for both the guest and KVM side), and adds
definitions for the other new functions added in v1.3. It also moves the
pKVM psci-relay support to a separate commit; although in arch/arm64/kvm
that's actually about the *guest* side of SYSTEM_OFF2 (i.e. using it
from the host kernel, relayed through nVHE).

Version 3 dropped the KVM_CAP which allowed userspace to explicitly opt
in to the new feature like with SYSTEM_SUSPEND, and makes it depend only
on PSCI v1.3 being exposed to the guest.

Version 4 is no longer RFC, as the PSCI v1.3 spec is finally published.
Minor fixes from the last round of review, and an added KVM self test.

Version 5 drops some of the changes which didn't make it to the final
v1.3 spec, and cleans up a couple of places which still referred to it
as 'alpha' or 'beta'. It also temporarily drops the guest-side patch to
invoke SYSTEM_OFF2 for hibernation, pending confirmation that the final
PSCI v1.3 spec just has a typo where it changed to saying that 0x1
should be passed to mean HIBERNATE_OFF, even though it's advertised as
bit 0. That can be sent under separate cover, and perhaps should have
been anyway. The change in question doesn't matter for any of the KVM
patches, because we just treat SYSTEM_OFF2 like the existing
SYSTEM_RESET2, setting a flag to indicate that it was a SYSTEM_OFF2
call, but not actually caring about the argument; that's for userspace
to worry about.

Version 6 is updated to revision F.b of the specification, allowing both 
0x0 and 0x1 to indicate HIBERNATE_OFF in the SYSTEM_OFF2 call, as well 
as disallowing anything but zero in the second argument. The test is 
expanded to cover those variants, and to require PSCI v1.3 instead of 
skipping on older kernels. The final guest-side patch in the series is 
reinstated, using zero as the argument for compatibility with existing 
hypervisors in the field as permitted by revision F.b. allows for zero 
as well as 0x1 for HIBERNATE_OFF to accommodate the change in the final 
version of the spec, and expands the test to cover both forms as well as 
checking that a non-zero second argument is correctly rejected.

David Woodhouse (6):
      firmware/psci: Add definitions for PSCI v1.3 specification
      KVM: arm64: Add PSCI v1.3 SYSTEM_OFF2 function for hibernation
      KVM: arm64: Add support for PSCI v1.2 and v1.3
      KVM: selftests: Add test for PSCI SYSTEM_OFF2
      KVM: arm64: nvhe: Pass through PSCI v1.3 SYSTEM_OFF2 call
      arm64: Use SYSTEM_OFF2 PSCI call to power off for hibernate

 Documentation/virt/kvm/api.rst                  | 11 +++
 arch/arm64/include/uapi/asm/kvm.h               |  6 ++
 arch/arm64/kvm/hyp/nvhe/psci-relay.c            |  2 +
 arch/arm64/kvm/hypercalls.c                     |  2 +
 arch/arm64/kvm/psci.c                           | 50 ++++++++++++-
 drivers/firmware/psci/psci.c                    | 42 +++++++++++
 include/kvm/arm_psci.h                          |  4 +-
 include/uapi/linux/psci.h                       |  5 ++
 kernel/power/hibernate.c                        |  5 +-
 tools/testing/selftests/kvm/aarch64/psci_test.c | 93 +++++++++++++++++++++++++
 10 files changed, 217 insertions(+), 3 deletions(-)



