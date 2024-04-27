Return-Path: <linux-kselftest+bounces-8978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 244F28B45E1
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 13:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9326282F97
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 11:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE054EB5F;
	Sat, 27 Apr 2024 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vS/M7D5S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BD738DD3;
	Sat, 27 Apr 2024 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714216787; cv=none; b=uAdDtT52Ht6eCNwrLddas4MC/kRgAOH979T3iYKApfg4gB0RptXDvOfTwzd04PAVF04sv5+X/QsHbJMmXwRKBNkZPqeLjlLIewrgD9MeJf6aAfdMfuSL/uF+qDlXQf81OqyaPAXLk4R5z4E5sAdSNnOlz+qegSmr+a5bqOvtMXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714216787; c=relaxed/simple;
	bh=Dne5fBR1iIOYX/rPcjbOE3SYHMPYwk167rrQ55hOsLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qrSPeXl7rrYSWIL/P8qGYMXq4JIQEWJZPtoQEZxuLJn7emWFORdMjj9qVLwgh+hKu8WaYaggUZ6EbzyxziZt/1Y/xmn/EQBp2VWiEkq6zgCBzSGOIbfyw8f6zXxYAXLtH9Hc5CbzEPE9vlHhP3EooI7dcOAac6wMrf5VSLFBfBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vS/M7D5S; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Z6fBy03Etm/CSR189UL7iYBAbnioWxrHrZek/W4lxZw=; b=vS/M7D5Sl4CQpsJxN9B544ayJl
	NsbwfjA7eg/2ImNuB3vQ+FyO6KnYWChQhE9UEVfFRJmRllbf7DUhFzenLUO53LEAv2KInFk8Oyopb
	9MjFoaiEhjWZejm4EGeYBo+qxV2Fdp1y9QNgkAKlrTFAoVmM8xKunZBtnnuKVSezJCdlERi2FB7//
	jujUFNSHVAnwubObnsL7ygyYBQ0dIwi7XclXO4znpOewBlKzimiAe6eGE3mQuF7Wwdi4ZQImLLgC8
	1juHV3lRqr0WEdRDyDptHnhZDzA9XiKwBEPic5gfoaMvn32X6ZBc3pRiqUA3XLJWQ41asQjYvd0XE
	2ar5/N2A==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0g5g-00000007Jwg-1Y9q;
	Sat, 27 Apr 2024 11:19:36 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0g5f-000000002b0-2wnU;
	Sat, 27 Apr 2024 12:19:35 +0100
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
	sveith@amazon.de,
	zide.chen@intel.com,
	Dongli Zhang <dongli.zhang@oracle.com>
Subject: [RFC PATCH v2] Cleaning up the KVM clock mess
Date: Sat, 27 Apr 2024 12:04:57 +0100
Message-ID: <20240427111929.9600-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

Clean up the KVM clock mess somewhat so that it is either based on the guest
TSC ("master clock" mode), or on the host CLOCK_MONOTONIC_RAW in cases where
the TSC isn't usable.

Eliminate the third variant where it was based directly on the *host* TSC,
due to bugs in e.g. __get_kvmclock().

Kill off the last vestiges of the KVM clock being based on CLOCK_MONOTONIC
instead of CLOCK_MONOTONIC_RAW and thus being subject to NTP skew.

Fix up migration support to allow the KVM clock to be saved/restored as an
arithmetic function of the guest TSC, since that's what it actually is in
the *common* case so it can be migrated precisely. Or at least to within
±1 ns which is good enough, as discussed in
https://lore.kernel.org/kvm/c8dca08bf848e663f192de6705bf04aa3966e856.camel@infradead.org

In v2 of this series, TSC synchronization is improved and simplified a bit
too, and we allow masterclock mode to be used even when the guest TSCs are
out of sync, as long as they're running at the same *rate*. The different
*offset* shouldn't matter.

And the kvm_get_time_scale() function annoyed me by being entirely opaque,
so I studied it until my brain hurt and then added some comments.

In v2 I also dropped the commits which were removing the periodic clock
syncs. Those are going to be needed still but *only* for non-masterclock
mode, which I'll do next. Along with ensuring that a masterclock update
while already in masterclock mode doesn't jump the clock, and just does
the same as KVM_SET_CLOCK_GUEST does to preserve it.

Needs a *lot* more testing. I think I'm almost done refactoring the code,
so should focus on building up the tests next.

(I do still hate that we're abusing KVM_GET_CLOCK just to get the tuple
of {host_tsc, CLOCK_REALTIME} without even *caring* about the eponymous
KVM clock. Especially as this information is (a) fundamentally what the
vDSO gettimeofday() exposes to us anyway, (b) using CLOCK_REALTIME not
TAI, (c) not available on other platforms, for example for migrating
the Arm arch counter.)

David Woodhouse (13):
      KVM: x86/xen: Do not corrupt KVM clock in kvm_xen_shared_info_init()
      KVM: x86: Improve accuracy of KVM clock when TSC scaling is in force
      KVM: x86: Explicitly disable TSC scaling without CONSTANT_TSC
      KVM: x86: Add KVM_VCPU_TSC_SCALE and fix the documentation on TSC migration
      KVM: x86: Avoid NTP frequency skew for KVM clock on 32-bit host
      KVM: x86: Fix KVM clock precision in __get_kvmclock()
      KVM: x86: Fix software TSC upscaling in kvm_update_guest_time()
      KVM: x86: Simplify and comment kvm_get_time_scale()
      KVM: x86: Remove implicit rdtsc() from kvm_compute_l1_tsc_offset()
      KVM: x86: Improve synchronization in kvm_synchronize_tsc()
      KVM: x86: Kill cur_tsc_{nsec,offset,write} fields
      KVM: x86: Allow KVM master clock mode when TSCs are offset from each other
      KVM: x86: Factor out kvm_use_master_clock()

Jack Allister (2):
      KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for accurate KVM clock migration
      KVM: selftests: Add KVM/PV clock selftest to prove timer correction

 Documentation/virt/kvm/api.rst                    |  37 ++
 Documentation/virt/kvm/devices/vcpu.rst           | 115 +++-
 arch/x86/include/asm/kvm_host.h                   |  15 +-
 arch/x86/include/uapi/asm/kvm.h                   |   6 +
 arch/x86/kvm/svm/svm.c                            |   3 +-
 arch/x86/kvm/vmx/vmx.c                            |   2 +-
 arch/x86/kvm/x86.c                                | 687 +++++++++++++++-------
 arch/x86/kvm/xen.c                                |   4 +-
 include/uapi/linux/kvm.h                          |   3 +
 tools/testing/selftests/kvm/Makefile              |   1 +
 tools/testing/selftests/kvm/x86_64/pvclock_test.c | 192 ++++++
 11 files changed, 822 insertions(+), 243 deletions(-)


