Return-Path: <linux-kselftest+bounces-18415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A390987949
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 20:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B1FDB25E63
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 18:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0266217C9AF;
	Thu, 26 Sep 2024 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SE29JUvJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2989415DBB2;
	Thu, 26 Sep 2024 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727376367; cv=none; b=afuXRuUE0+jEZLnvV8oxyv3RKkNddsXsmosn7AYWDbxb7BKOMR/7B5BuUrM9acSsX+pfSUm29pmed6KvuOkgQ6ae4AUNuq15Cy8dg8JpeBPkO15EO1eIBv2VvqIv2OsGo4tDNt9HqK4iB8+0YA+4fuSjyNKgeFRrOD1TKieL3pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727376367; c=relaxed/simple;
	bh=K+bUjFKd41jFcNzn05wYMay17uH5DKFW9c2HEdgts0M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gP4bpPup8EgcPQNYboaQlUXLuqx73N0j/0Py9mOvy1coo87NZcpVS4GKBwipHcvi0oDH6+eiHaquk/G5ZYL4s+SRgRuoXFrhsT8mrDnhKWTJighfIFeEC0oSrDMfQYA5lZnZalqoz63fQHZIHmiT/bMVLp/cQ+HE9RNRPb/c9jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SE29JUvJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=9odw1NEG4SokToSv0eALme++DFz1wAP7aZWxWSDMshE=; b=SE29JUvJ3ULBV+pZtEembIWeN3
	4DrAyjaK4JS5T3PvpvbygaM//MM6xPEAwYW0cYfUhWpKPooJYruSiyj2qBBgA1LDyS5PsTnlbs026
	4zTn0PJISWejctvLHY1VwAqufiwFBnab8l0kpaEmEQ58ubv++yXPbAxlap8j1LINo18Z4dV2GWS6z
	ftq9OgBhTcrrlt/Jt57IdMmUDFYFRSpowVphJYUwOuiF7X0uQRxVEpjlpGthnfRnk8njmthsqzDf5
	z3GqaCWW7OdTrM7/2+LMQddaU5usF4rKyhcUJJ4sYDkKAtIq14hZ/klIN8Qooo8TsK3ExyfbMcmWC
	KdV/Je6g==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sttUq-00000007N9u-1wag;
	Thu, 26 Sep 2024 18:45:49 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sttUq-00000003YbD-35bQ;
	Thu, 26 Sep 2024 19:45:48 +0100
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
Subject: [PATCH v5 0/5] Add PSCI v1.3 SYSTEM_OFF2 support for hibernation
Date: Thu, 26 Sep 2024 19:37:55 +0100
Message-ID: <20240926184546.833516-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

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

David Woodhouse (5):
      firmware/psci: Add definitions for PSCI v1.3 specification
      KVM: arm64: Add PSCI v1.3 SYSTEM_OFF2 function for hibernation
      KVM: arm64: Add support for PSCI v1.2 and v1.3
      KVM: selftests: Add test for PSCI SYSTEM_OFF2
      KVM: arm64: nvhe: Pass through PSCI v1.3 SYSTEM_OFF2 call

 Documentation/virt/kvm/api.rst                  | 11 +++++
 arch/arm64/include/uapi/asm/kvm.h               |  6 +++
 arch/arm64/kvm/hyp/nvhe/psci-relay.c            |  2 +
 arch/arm64/kvm/hypercalls.c                     |  2 +
 arch/arm64/kvm/psci.c                           | 43 ++++++++++++++++-
 include/kvm/arm_psci.h                          |  4 +-
 include/uapi/linux/psci.h                       |  5 ++
 tools/testing/selftests/kvm/aarch64/psci_test.c | 61 +++++++++++++++++++++++++
 8 files changed, 132 insertions(+), 2 deletions(-)


