Return-Path: <linux-kselftest+bounces-8367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA2D8AA2FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 21:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BD561F22E22
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 19:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F6117F368;
	Thu, 18 Apr 2024 19:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dgwIbviy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5786E17BB31;
	Thu, 18 Apr 2024 19:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713469275; cv=none; b=TrJb9w+356SlD4H1nDFeujE0QTtFtNyy42G/530oQXeyFI1DxKcNyF+Etiyx7OhYBoW0OGf2OvX6MQnS8NM/UJ604rmc6TU1L8ErT1RnpiIWwVdrbISjWEAjLEHy4wgxc0HtAdg34IWcfvp4uUtaaPL6h+0UNS8r0hPFBops5dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713469275; c=relaxed/simple;
	bh=FP9qrJPYp1HjBijjSu6k6ITYFAbO25mcYst7S5HnTqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iW6Ce+BMrQXRZVSX8+S6QP5A46BNq0Snnip51K8/9RjWtam24/BVZ7TvKlZ3b9MaVNKNI3AoS/Mpd6qpDIv5rRxj6C97lkHSK3azdpKXtm/41mTxxXsK4ZkP4n7Y5HIWmYucMcF5vN5hhl98adCRcZW1NcHp8hgc+bwVHowoSYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dgwIbviy; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=MaM1aE1ekoANLCptx7QvYKRY+khHGXAhwswsLC/S9fw=; b=dgwIbviyHaFZnJDDwR8rnjRvuS
	6bEgL+qp+BzrT5qskZD2t5Pu58d3Lcj7tUmLCisvAzqFS3v72sAgbSnR+4dkFE0iGFvRT666KCSkA
	IBeJMTt37V9uz1kVnpw5F7F7Wt7Kl8VV5vxAoTiaE4Kx81/PNtGKVA14M5mR1VF1RKXKYa0HlYwmf
	88FlSuQKbGz/XI2aWfncQHlyK3ynhBIr8pYJgV0amFEmUL0izd4POIM02l54Ke1NsmYAE7yU5JK+3
	iAcNqe+Iqme2Iou8ttbrgbIU6rkwxoYqdLSRdKy80ENdYpLLEDEkPqM5Q1iMod9XPebi596GmFW4a
	0/C0JQFg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxXXf-0000000C8MK-2tH7;
	Thu, 18 Apr 2024 19:35:31 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxXXe-00000000AsH-1rjf;
	Thu, 18 Apr 2024 20:35:30 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paul Durrant <paul@xen.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	jalliste@amazon.co.uk,
	sveith@amazon.de
Subject: [RFC PATCH 0/10] Cleaning up the KVM clock mess
Date: Thu, 18 Apr 2024 20:34:39 +0100
Message-ID: <20240418193528.41780-1-dwmw2@infradead.org>
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

I lied, there aren't three different definitions of the KVM clock. The
fourth is on i386, where it's still based on CLOCK_MONOTONIC (well,
boot time which might as well be the same sine we offset it anyway).

If we fix *that* to be based on CLOCK_MONOTONIC_RAW then we can rip out
a whole bunch of mechanisms which were added to cope with NTP frequency
skew.

This cleans up the mess and gets us back down to the two unavoidable
definitions of the KVM clock: when the host and guest TSCs are well
behaved and in sync, it's in "master clock" mode where it's defined as
a simple arithmetic function of the guest TSC, otherwise it's clamped
to the host's CLOCK_MONOTONIC_RAW.

It includes Jack's KVM_[GS]ET_CLOCK_GUEST patch to allow accurate
migration. Also my KVM_VCPU_TSC_SCALE which exposes the precise TSC
scaling factors. This is needed to get accurate migration of the guest
TSC, and can *also* be used by userspace to have vDSO-style access to
the KVM clock. Thus allowing hypercalls and other emulated clock devices
(e.g. PIT, HPET, ACPI timer) to be based on the KVM clock too, giving
*consistency* across a live migration.

I do still need to fix KVM_REQ_MASTERCLOCK_UPDATE so that it doesn't
clamp the clock back to CLOCK_MONOTONIC_RAW; we should *update* the
ka->kvmclock_offset when we've been running in use_master_clock mode.
Should probably do that in kvm_arch_hardware_disable() for timekeeping
across hibernation too, but I haven't finished working that one out.

I think there are still some places left where KVM reads the time twice 
in close(ish) succession and then assumes they were at the *same* time, 
which I'll audit and fix too.

I also need to flesh out the test cases and do some real testing from
VMMs, but I think it's ready for some heckling at least.

https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/clocks

David Woodhouse (8):
      KVM: x86/xen: Do not corrupt KVM clock in kvm_xen_shared_info_init()
      KVM: x86: Improve accuracy of KVM clock when TSC scaling is in force
      KVM: x86: Explicitly disable TSC scaling without CONSTANT_TSC
      KVM: x86: Add KVM_VCPU_TSC_SCALE and fix the documentation on TSC migration
      KVM: x86: Avoid NTP frequency skew for KVM clock on 32-bit host
      KVM: x86: Remove periodic global clock updates
      KVM: x86: Kill KVM_REQ_GLOBAL_CLOCK_UPDATE
      KVM: x86: Fix KVM clock precision in __get_kvmclock()

Jack Allister (2):
      KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for accurate KVM clock migration
      KVM: selftests: Add KVM/PV clock selftest to prove timer correction

 Documentation/virt/kvm/api.rst                    |  37 ++
 Documentation/virt/kvm/devices/vcpu.rst           | 115 ++++--
 arch/x86/include/asm/kvm_host.h                   |   8 +-
 arch/x86/include/uapi/asm/kvm.h                   |   6 +
 arch/x86/kvm/svm/svm.c                            |   3 +-
 arch/x86/kvm/vmx/vmx.c                            |   2 +-
 arch/x86/kvm/x86.c                                | 438 +++++++++++++---------
 arch/x86/kvm/xen.c                                |   4 +-
 include/uapi/linux/kvm.h                          |   3 +
 tools/testing/selftests/kvm/Makefile              |   1 +
 tools/testing/selftests/kvm/x86_64/pvclock_test.c | 192 ++++++++++
 11 files changed, 600 insertions(+), 209 deletions(-)



