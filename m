Return-Path: <linux-kselftest+bounces-2606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB774822A00
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 10:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77341C2316F
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 09:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C9818628;
	Wed,  3 Jan 2024 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RgmJcQaY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB0F182AF;
	Wed,  3 Jan 2024 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704273168; x=1735809168;
  h=from:to:cc:subject:date:message-id;
  bh=gPf7rfKmzwzlXV8d5iHJVEkj1nA/mwcPl3PJ7L7K2SY=;
  b=RgmJcQaYTdhtkAMWmVasSkGa3nwp9fdwGMzftKwiXfqQFi4oCdQotMp/
   990xE/ePj+O2oY0hST05KlA+j6sRrzXS+hUNloz9YrdRFxCF2y/fbj3kr
   cCvfBGRv79raVpmfNNcvo0u3EJ67tCJ5E8MD+42iU11/yEDhrTEw6fE7B
   35zjStJQgtwxjY00MRPDVVzyx8sEy5rc4wQ13aln8YDhUl/4/yaVKw1Nj
   NW6uafhp/pmwjK51rDMpMzayaSnGdfjNxRcpjf/yp/UCruEQth7BseTJX
   OkZuIQf5cwhV42Hlx0TIANcBG2vD3/GY1KHocJF/cd4HqCbvb7rKK7K11
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="463386609"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="463386609"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 01:12:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="783445220"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="783445220"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 01:12:45 -0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	shuah@kernel.org,
	stevensd@chromium.org,
	Yan Zhao <yan.y.zhao@intel.com>
Subject: [RFC PATCH v2 0/3] KVM: allow mapping of compound tail pages for IO or PFNMAP mapping
Date: Wed,  3 Jan 2024 16:43:27 +0800
Message-Id: <20240103084327.19955-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

This is a v2 for previous series [1] to allow mapping for compound tail
pages for IO or PFNMAP mapping.

Compared to v1, this version provides selftest to check functionality in
KVM to map memslots for MMIO BARs (VMAs with flag VM_IO | VM_PFNMAP), as
requested by Sean in [1].

The selftest can also be used to test series "allow mapping non-refcounted
pages" [2].

Tag RFC is added because a test driver is introduced in patch 2, which is
new to KVM selftest, and test "set_memory_region_io" in patch 3 depends on
that the test driver is compiled and loaded in kernel.
Besides, patch 3 calls vm_set_user_memory_region() directly without
modifying vm_mem_add().
So, this series is sent to ensure the main direction is right.

Thanks
Yan

[1] https://lore.kernel.org/all/20230719083332.4584-1-yan.y.zhao@intel.com/
[2] https://lore.kernel.org/all/20230911021637.1941096-1-stevensd@google.com/

v2:
added patch 2 and 3 to do selftest for patch 1 (Sean).

Yan Zhao (3):
  KVM: allow mapping of compound tail pages for IO or PFNMAP mapping
  KVM: selftests: add selftest driver for KVM to test memory slots for
    MMIO BARs
  KVM: selftests: Add set_memory_region_io to test memslots for MMIO
    BARs

 lib/Kconfig.debug                             |  14 +
 lib/Makefile                                  |   1 +
 lib/test_kvm_mock_device.c                    | 281 ++++++++++++++++++
 lib/test_kvm_mock_device_uapi.h               |  16 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/set_memory_region_io.c      | 188 ++++++++++++
 virt/kvm/kvm_main.c                           |   2 +-
 7 files changed, 502 insertions(+), 1 deletion(-)
 create mode 100644 lib/test_kvm_mock_device.c
 create mode 100644 lib/test_kvm_mock_device_uapi.h
 create mode 100644 tools/testing/selftests/kvm/set_memory_region_io.c


base-commit: 8ed26ab8d59111c2f7b86d200d1eb97d2a458fd1
-- 
2.17.1


