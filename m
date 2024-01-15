Return-Path: <linux-kselftest+bounces-2991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B138682DA4F
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 14:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 427EDB21E1D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 13:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E1917576;
	Mon, 15 Jan 2024 13:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b="IsBcCu7B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDB717C63;
	Mon, 15 Jan 2024 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
	s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:To:From; bh=NGz8qcxOM7EVgEWKAbNKsPiLOwrCtQw4O+B/FkvZxzw=; b=IsBcCu7B0
	NnP0YAOH73/jBV7BP7Iq9ILAZyrzh1DUpNSxneroBGPmzaZf6KqVAilaM0E3DFTaYvF23+WyGSPcB
	vTreYUWQskhl56HGD202ytYE3YrB/8cr4pkabFWqi9JQZXdgyAskNkj6bUs5OnOYp97waGek1X7sM
	oxoYtbIY=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1rPMX0-0002iu-4U; Mon, 15 Jan 2024 12:57:34 +0000
Received: from 54-240-197-231.amazon.com ([54.240.197.231] helo=REM-PW02S00X.ant.amazon.com)
	by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1rPMWz-0002kM-OK; Mon, 15 Jan 2024 12:57:33 +0000
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
Subject: [PATCH v12 00/20] KVM: xen: update shared_info and vcpu_info handling
Date: Mon, 15 Jan 2024 12:56:47 +0000
Message-Id: <20240115125707.1183-1-paul@xen.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Durrant <pdurrant@amazon.com>

This series has one small fix to what was in v11 [1]:

* KVM: xen: re-initialize shared_info if guest (32/64-bit) mode is set

The v11 patch failed to set the return code of the ioctl if the mode
was not actually changed, leading to a spurious failure.

This version of the series also contains a new bug-fix to the pfncache
code from David Woodhouse.

[1] https://lore.kernel.org/kvm/20231219161109.1318-1-paul@xen.org/

David Woodhouse (1):
  KVM: pfncache: rework __kvm_gpc_refresh() to fix locking issues

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
 arch/x86/kvm/xen.c                            | 356 +++++++++++-------
 include/linux/kvm_host.h                      |  40 +-
 include/linux/kvm_types.h                     |   8 -
 include/uapi/linux/kvm.h                      |   9 +-
 .../selftests/kvm/x86_64/xen_shinfo_test.c    |  59 ++-
 virt/kvm/pfncache.c                           | 340 +++++++++--------
 8 files changed, 535 insertions(+), 337 deletions(-)


base-commit: 1c6d984f523f67ecfad1083bb04c55d91977bb15
-- 
2.39.2


