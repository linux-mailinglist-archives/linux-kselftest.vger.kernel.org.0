Return-Path: <linux-kselftest+bounces-4767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7835985681E
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 16:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E0D28747D
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 15:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3C91339A5;
	Thu, 15 Feb 2024 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b="Hu3vy5io"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C7C133988;
	Thu, 15 Feb 2024 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.215.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011676; cv=none; b=ADzyb7LylTiGlYzIpAuPP9H558EkV0R9WqPQOtm3rR9jsyS4XnrVi5CjQWMZbJS6q2YQBOJwdUjDhlRP0/bsc+bRG32mpX+pyYYSz6ZLABsJK+E5evohjOTwauFmRC13VOzhVerrq1Vmh9BTbdMZcXcwNrgm3LFW5NLEVnRzgt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011676; c=relaxed/simple;
	bh=BPxOajaOUpZ8zqhwZLHWGPlmk25NyFlciVy4aXnDiuE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Y/RsTmFK1y8mA59h+UrO3NpWUkucGJJJXDk3XNL+ZvSCr4Rl5IzXuleofiiOmpQRhPJxtZ94x7Y7ikE9BLrSc0PSVPvvmKL+knjGySkCGzQH2dDAIXJwqCsDQ/+OB7aMRgBAEeF2E4utSQVrCmPkpHTeK+Dolan1ALVqxf1LZYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org; spf=pass smtp.mailfrom=xen.org; dkim=pass (1024-bit key) header.d=xen.org header.i=@xen.org header.b=Hu3vy5io; arc=none smtp.client-ip=104.130.215.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
	s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:To:From; bh=TEpTKi5UZCiDihe14d8Icy5BIjVsO8aW29qRo71K668=; b=Hu3vy5ioZ
	A2o4SB5Ah6zJp7nMx/Qnx/ooYOEoOrdDLeqBIr//u6kyvxrovmIZ/lxMajKOKn+4Pt8/buEe73GBb
	pqrpMAjM5hYBKdZ+NZI01N1vFsy5vT0M98ud51iJV6Kw0k37LsUfGJd++yOKfOCj1FBdi1fZMtZ8P
	efGMNk7I=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1radgB-0001B5-T7; Thu, 15 Feb 2024 15:29:39 +0000
Received: from 54-240-197-226.amazon.com ([54.240.197.226] helo=REM-PW02S00X.ant.amazon.com)
	by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <paul@xen.org>)
	id 1radgB-00089r-DW; Thu, 15 Feb 2024 15:29:39 +0000
From: Paul Durrant <paul@xen.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
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
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v13 00/21] KVM: xen: update shared_info and vcpu_info handling
Date: Thu, 15 Feb 2024 15:28:55 +0000
Message-Id: <20240215152916.1158-1-paul@xen.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Durrant <pdurrant@amazon.com>

This series contains a new patch from Sean added since v12 [1]:

* KVM: s390: Refactor kvm_is_error_gpa() into kvm_is_gpa_in_memslot()

This frees up the function name kvm_is_error_gpa() such that it can then be
re-defined in:

* KVM: pfncache: allow a cache to be activated with a fixed (userspace) HVA

to be used for a simple GPA validation helper function. The patch also now
contains an either/or address check for GPA versus HVA in
__kvm_gpc_refresh().

In:

* KVM: pfncache: add a mark-dirty helper

The function name has been changed from kvm_gpc_mark_dirty() to
kvm_gpc_mark_dirty_in_slot().

In:

* KVM: x86/xen: allow shared_info to be mapped by fixed HVA

missing HVA validation checks have been added and the 'hva == 0' test
has been changed to '!hva'. The KVM_XEN_ATTR_TYPE_SHARED_INFO and
KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA cases are still largely handled as one
though as separation leads to duplicate calls to
kvm_xen_shared_info_init() which looks messy.

Also, patches with a 'xen' prefix have now been modified to have a
'x86/xen' prefix and patches with a 'selftests / xen' prefix have been
modified to have simply a 'selftests' prefix.

[1] https://lore.kernel.org/kvm/20240115125707.1183-1-paul@xen.org/

David Woodhouse (1):
  KVM: pfncache: rework __kvm_gpc_refresh() to fix locking issues

Paul Durrant (19):
  KVM: pfncache: Add a map helper function
  KVM: pfncache: remove unnecessary exports
  KVM: x86/xen: mark guest pages dirty with the pfncache lock held
  KVM: pfncache: add a mark-dirty helper
  KVM: pfncache: remove KVM_GUEST_USES_PFN usage
  KVM: pfncache: stop open-coding offset_in_page()
  KVM: pfncache: include page offset in uhva and use it consistently
  KVM: pfncache: allow a cache to be activated with a fixed (userspace)
    HVA
  KVM: x86/xen: separate initialization of shared_info cache and content
  KVM: x86/xen: re-initialize shared_info if guest (32/64-bit) mode is
    set
  KVM: x86/xen: allow shared_info to be mapped by fixed HVA
  KVM: x86/xen: allow vcpu_info to be mapped by fixed HVA
  KVM: selftests: map Xen's shared_info page using HVA rather than GFN
  KVM: selftests: re-map Xen's vcpu_info using HVA rather than GPA
  KVM: x86/xen: advertize the KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA
    capability
  KVM: x86/xen: split up kvm_xen_set_evtchn_fast()
  KVM: x86/xen: don't block on pfncache locks in
    kvm_xen_set_evtchn_fast()
  KVM: pfncache: check the need for invalidation under read lock first
  KVM: x86/xen: allow vcpu_info content to be 'safely' copied

Sean Christopherson (1):
  KVM: s390: Refactor kvm_is_error_gpa() into kvm_is_gpa_in_memslot()

 Documentation/virt/kvm/api.rst                |  53 ++-
 arch/s390/kvm/diag.c                          |   2 +-
 arch/s390/kvm/gaccess.c                       |  14 +-
 arch/s390/kvm/kvm-s390.c                      |   4 +-
 arch/s390/kvm/priv.c                          |   4 +-
 arch/s390/kvm/sigp.c                          |   2 +-
 arch/x86/kvm/x86.c                            |   7 +-
 arch/x86/kvm/xen.c                            | 361 +++++++++++------
 include/linux/kvm_host.h                      |  49 ++-
 include/linux/kvm_types.h                     |   8 -
 include/uapi/linux/kvm.h                      |   9 +-
 .../selftests/kvm/x86_64/xen_shinfo_test.c    |  59 ++-
 virt/kvm/pfncache.c                           | 382 ++++++++++--------
 13 files changed, 591 insertions(+), 363 deletions(-)


base-commit: 7455665a3521aa7b56245c0a2810f748adc5fdd4
-- 
2.39.2


