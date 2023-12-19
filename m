Return-Path: <linux-kselftest+bounces-2219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FB3818C81
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 17:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C030B23126
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 16:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB4720B2A;
	Tue, 19 Dec 2023 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b="hsZMXagx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEF932C7E;
	Tue, 19 Dec 2023 16:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
	s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:To:From; bh=57goH/6cxWcfb2OLWV035vnGe0L7dKUP3rllvb9LgIs=; b=hsZMXagxd
	cneDEkY2R/4JhDHQzttdGTXVeDlha3N1T0dvRckqsk7l8a5nyGGcgpO9J0HCWXnFxbRkaFsDAsAfq
	3kQCy//4muUSBMnUXYg7O6X45vJezwtjk3Tv3sTKBbBDmOIzqBMPh0AP0DMAv/mSUWKPNx4dD77u7
	8aSccXfU=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1rFcjo-0005Le-46; Tue, 19 Dec 2023 16:14:32 +0000
Received: from 54-240-197-226.amazon.com ([54.240.197.226] helo=REM-PW02S00X.ant.amazon.com)
	by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1rFcjn-0005h9-NZ; Tue, 19 Dec 2023 16:14:31 +0000
From: Paul Durrant <paul@xen.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Paul Durrant <paul@xen.org>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v11 00/19] KVM: xen: update shared_info and vcpu_info handling
Date: Tue, 19 Dec 2023 16:10:50 +0000
Message-Id: <20231219161109.1318-1-paul@xen.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Durrant <pdurrant@amazon.com>

This series has some small fixes from what was in version 10 [1]:

* KVM: pfncache: allow a cache to be activated with a fixed (userspace) HVA

This required a small fix to kvm_gpc_check() for an error that was
introduced in version 8.

* KVM: xen: separate initialization of shared_info cache and content

This accidentally regressed a fix in commit 5d6d6a7d7e66a ("KVM: x86:
Refine calculation of guest wall clock to use a single TSC read").

* KVM: xen: re-initialize shared_info if guest (32/64-bit) mode is set

This mistakenly removed the initialization of shared_info from the code
setting the KVM_XEN_ATTR_TYPE_SHARED_INFO attribute, which broke the self-
tests.

* KVM: xen: split up kvm_xen_set_evtchn_fast()

This had a /32 and a /64 swapped in set_vcpu_info_evtchn_pending().

[1] https://lore.kernel.org/kvm/20231204144334.910-1-paul@xen.org/

Paul Durrant (19):
  KVM: pfncache: Add a map helper function
  KVM: pfncache: remove unnecessary exports
  KVM: xen: mark guest pages dirty with the pfncache lock held
  KVM: pfncache: add a mark-dirty helper
  KVM: pfncache: remove KVM_GUEST_USES_PFN usage
  KVM: pfncache: stop open-coding offset_in_page()
  KVM: pfncache: include page offset in uhva and use it consistently
  KVM: pfncache: allow a cache to be activated with a fixed (userspace)
    HVA
  KVM: xen: separate initialization of shared_info cache and content
  KVM: xen: re-initialize shared_info if guest (32/64-bit) mode is set
  KVM: xen: allow shared_info to be mapped by fixed HVA
  KVM: xen: allow vcpu_info to be mapped by fixed HVA
  KVM: selftests / xen: map shared_info using HVA rather than GFN
  KVM: selftests / xen: re-map vcpu_info using HVA rather than GPA
  KVM: xen: advertize the KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA capability
  KVM: xen: split up kvm_xen_set_evtchn_fast()
  KVM: xen: don't block on pfncache locks in kvm_xen_set_evtchn_fast()
  KVM: pfncache: check the need for invalidation under read lock first
  KVM: xen: allow vcpu_info content to be 'safely' copied

 Documentation/virt/kvm/api.rst                |  53 ++-
 arch/x86/kvm/x86.c                            |   7 +-
 arch/x86/kvm/xen.c                            | 360 +++++++++++-------
 include/linux/kvm_host.h                      |  40 +-
 include/linux/kvm_types.h                     |   8 -
 include/uapi/linux/kvm.h                      |   9 +-
 .../selftests/kvm/x86_64/xen_shinfo_test.c    |  59 ++-
 virt/kvm/pfncache.c                           | 188 ++++-----
 8 files changed, 466 insertions(+), 258 deletions(-)


base-commit: f2a3fb7234e52f72ff4a38364dbf639cf4c7d6c6
-- 
2.39.2


