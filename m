Return-Path: <linux-kselftest+bounces-46263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EE3C7B412
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 19:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83EF3A2B8E
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 18:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408C233E341;
	Fri, 21 Nov 2025 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YDy8a3YN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7066A2D6624
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748881; cv=none; b=OMwmZIoZJ2IS2yv/mTECd5wEGtcYriWeQojgxgfBXz2h5OuM4tlrtGElv52jq0sJ0ZjQ8ApIuQ2RYrByINGiPqMuPe39GbuTaIWwSXeKdks/bK10FVqaqhWySRm+FHhFt3PIdQ+n/6QnnhTIjMywTE0u5b+NYESfc/tRhez1q98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748881; c=relaxed/simple;
	bh=Itj0wALigLttdXVurI38dIRgSbQPqSQZBf8dIpDzGww=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=X05eoGqVNi7jUzVvNnJBXtMZ2BrSQI78tGETkGb4XP8KqmtnDxB/lKlMqS8uNZIKVhn80BiQTeW/wMziLMfOr1bwkSDUZ5e/qhMZ2j1ykyQDyh/BZ3x10Kd6p9GbRfg8r4ywRRf6ZA2S7kbF3jNdTb850+MMFYS62HmyqamogMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YDy8a3YN; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7a998ab7f87so4268391b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 10:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763748878; x=1764353678; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3OiJR63Hnpv1xw4Pl/ObEOw14HTTU+CVAQSCu0CZ3a8=;
        b=YDy8a3YNodHLd8NcN6XNHvBdaTIIRwO16Dx5Qm0UgfDhRlKkIVBEgQhPAJs/u7f6Dr
         IACpVCdIw94ViahNJYe5qX2vrRvIsrPJNEvEBk6BtFBKpKdinre4uhsoRDd4I5Paei40
         TuPfPcTKCZUKHoE9WbFQPruzVEZvzd2ZVYvfXiv+j+iJkSTLleWycKXvuqW2UPvsq6Qx
         6JGbUuAi+naxRg0uKwc9Megdg7LMfMsQzjnyO1BwMOlUs2zwGzFDIkZPvn0CS9wkK4Gl
         O/SeIvfS3qhqHvZ4ii1JdhIb9B2KEOSM8iayDLlRkXNr8CnyC9WFK+g1KTlyGMDN7IaC
         M0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763748878; x=1764353678;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3OiJR63Hnpv1xw4Pl/ObEOw14HTTU+CVAQSCu0CZ3a8=;
        b=BPGbsUNk3SRaqk5MGNEwReYPe5R9MFPFVJ7kZtr4OpyuNA05GXcLLy8d3FR2M3v137
         q3s+nKRgXFuYaq3atbwSKTAxjRFau9/XsyeMdURokb/3fmQqCBhbGQTuNBzS9YVxtcJT
         gREStHFCG5uA3hoMoulDRVCV/H7tgRRbWApAtcTYFSdsXEp4OCMSdpUdbQ7sdf1vINAM
         UsZQXaY/iEz6LplBUMDWnkOR6Mx5AwF/qqAPu/1FfvGJe3R7N28SxJUyeLauisL4gN26
         bef4PoRm38ERn1lwctWO0OLUpK6eSH6mHhE9GWcjwfgW2bCy9dAkhCTU2RnAzTS9ZkM3
         wIHA==
X-Forwarded-Encrypted: i=1; AJvYcCXwQr0r7010eN0YVWW0PWfI7pOB/N1ftFNX2OhUxNzv1ER3NptYB3QR9oiyt+aCS6xNQ1NJ9wqZTkoPYju2dz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKG0aNqOxRV8vdd9grkQh19RCeShYADeO/sJ++fH3Y03MxzjzD
	XYAvTothead7YKf6GWyHSLiaKgumUdlm0gDjpNmGx3FoFCPB1IN4rJ5HVPHuUkFr43/lohXbE2l
	qU1li7xE5i63eWg==
X-Google-Smtp-Source: AGHT+IFQcELTKtGRXXe0Xp2Vj5kh3UvDCDdGbXoIoSI5e/dZwC1XpXvLDqHWFz7J761kdj6oga1N3KDF4vBpLg==
X-Received: from pfbdf10.prod.google.com ([2002:a05:6a00:470a:b0:7bf:838:e52e])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2293:b0:7ad:1e4:bef0 with SMTP id d2e1a72fcca58-7c58c2ab11fmr3362709b3a.4.1763748878524;
 Fri, 21 Nov 2025 10:14:38 -0800 (PST)
Date: Fri, 21 Nov 2025 18:14:11 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251121181429.1421717-1-dmatlack@google.com>
Subject: [PATCH v3 00/18] vfio: selftests: Support for multi-device tests
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Alex Mastro <amastro@fb.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

This series adds support for tests that use multiple devices, and adds
one new test, vfio_pci_device_init_perf_test, which measures parallel
device initialization time to demonstrate the improvement from commit
e908f58b6beb ("vfio/pci: Separate SR-IOV VF dev_set").

This series also breaks apart the monolithic vfio_util.h and
vfio_pci_device.c into separate files, to account for all the new code.
This required quite a bit of code motion so the diffstat looks large.
The final layout is more granular and provides a better separation of
the IOMMU code from the device code.

Final layout:

  C files:
    - tools/testing/selftests/vfio/lib/libvfio.c
    - tools/testing/selftests/vfio/lib/iommu.c
    - tools/testing/selftests/vfio/lib/iova_allocator.c
    - tools/testing/selftests/vfio/lib/vfio_pci_device.c
    - tools/testing/selftests/vfio/lib/vfio_pci_driver.c

  H files:
   - tools/testing/selftests/vfio/lib/include/libvfio.h
   - tools/testing/selftests/vfio/lib/include/libvfio/assert.h
   - tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
   - tools/testing/selftests/vfio/lib/include/libvfio/iova_allocator.h
   - tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
   - tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h

Notably, vfio_util.h is now gone and replaced with libvfio.h.

This series is based on vfio/next plus Alex Mastro's series to add the
IOVA allocator [1]. It should apply cleanly to vfio/next once Alex's
series is merged by Linus into the next 6.18 rc and then merged into
vfio/next.

This series can be found on GitHub:

  https://github.com/dmatlack/linux/tree/vfio/selftests/init_perf_test/v3

[1] https://lore.kernel.org/kvm/20251111-iova-ranges-v3-0-7960244642c5@fb.com/

Cc: Alex Mastro <amastro@fb.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Josh Hilke <jrhilke@google.com>
Cc: Raghavendra Rao Ananta <rananta@google.com>
Cc: Vipin Sharma <vipinsh@google.com>

v3:
 - Replace literal with NSEC_PER_SEC (Alex Mastro)
 - Fix Makefile accumulate vs. assignment (Alex Mastro)

v2: https://lore.kernel.org/kvm/20251112192232.442761-1-dmatlack@google.com/

v1: https://lore.kernel.org/kvm/20251008232531.1152035-1-dmatlack@google.com/

David Matlack (18):
  vfio: selftests: Move run.sh into scripts directory
  vfio: selftests: Split run.sh into separate scripts
  vfio: selftests: Allow passing multiple BDFs on the command line
  vfio: selftests: Rename struct vfio_iommu_mode to iommu_mode
  vfio: selftests: Introduce struct iommu
  vfio: selftests: Support multiple devices in the same
    container/iommufd
  vfio: selftests: Eliminate overly chatty logging
  vfio: selftests: Prefix logs with device BDF where relevant
  vfio: selftests: Upgrade driver logging to dev_err()
  vfio: selftests: Rename struct vfio_dma_region to dma_region
  vfio: selftests: Move IOMMU library code into iommu.c
  vfio: selftests: Move IOVA allocator into iova_allocator.c
  vfio: selftests: Stop passing device for IOMMU operations
  vfio: selftests: Rename vfio_util.h to libvfio.h
  vfio: selftests: Move vfio_selftests_*() helpers into libvfio.c
  vfio: selftests: Split libvfio.h into separate header files
  vfio: selftests: Eliminate INVALID_IOVA
  vfio: selftests: Add vfio_pci_device_init_perf_test

 tools/testing/selftests/vfio/Makefile         |  10 +-
 .../selftests/vfio/lib/drivers/dsa/dsa.c      |  36 +-
 .../selftests/vfio/lib/drivers/ioat/ioat.c    |  18 +-
 .../selftests/vfio/lib/include/libvfio.h      |  26 +
 .../vfio/lib/include/libvfio/assert.h         |  54 ++
 .../vfio/lib/include/libvfio/iommu.h          |  76 +++
 .../vfio/lib/include/libvfio/iova_allocator.h |  23 +
 .../lib/include/libvfio/vfio_pci_device.h     | 125 ++++
 .../lib/include/libvfio/vfio_pci_driver.h     |  97 +++
 .../selftests/vfio/lib/include/vfio_util.h    | 331 -----------
 tools/testing/selftests/vfio/lib/iommu.c      | 465 +++++++++++++++
 .../selftests/vfio/lib/iova_allocator.c       |  94 +++
 tools/testing/selftests/vfio/lib/libvfio.c    |  78 +++
 tools/testing/selftests/vfio/lib/libvfio.mk   |   5 +-
 .../selftests/vfio/lib/vfio_pci_device.c      | 555 +-----------------
 .../selftests/vfio/lib/vfio_pci_driver.c      |  16 +-
 tools/testing/selftests/vfio/run.sh           | 109 ----
 .../testing/selftests/vfio/scripts/cleanup.sh |  41 ++
 tools/testing/selftests/vfio/scripts/lib.sh   |  42 ++
 tools/testing/selftests/vfio/scripts/run.sh   |  16 +
 tools/testing/selftests/vfio/scripts/setup.sh |  48 ++
 .../selftests/vfio/vfio_dma_mapping_test.c    |  46 +-
 .../selftests/vfio/vfio_iommufd_setup_test.c  |   2 +-
 .../vfio/vfio_pci_device_init_perf_test.c     | 168 ++++++
 .../selftests/vfio/vfio_pci_device_test.c     |  12 +-
 .../selftests/vfio/vfio_pci_driver_test.c     |  51 +-
 26 files changed, 1481 insertions(+), 1063 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/lib/include/libvfio.h
 create mode 100644 tools/testing/selftests/vfio/lib/include/libvfio/assert.h
 create mode 100644 tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
 create mode 100644 tools/testing/selftests/vfio/lib/include/libvfio/iova_allocator.h
 create mode 100644 tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
 create mode 100644 tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h
 delete mode 100644 tools/testing/selftests/vfio/lib/include/vfio_util.h
 create mode 100644 tools/testing/selftests/vfio/lib/iommu.c
 create mode 100644 tools/testing/selftests/vfio/lib/iova_allocator.c
 create mode 100644 tools/testing/selftests/vfio/lib/libvfio.c
 delete mode 100755 tools/testing/selftests/vfio/run.sh
 create mode 100755 tools/testing/selftests/vfio/scripts/cleanup.sh
 create mode 100755 tools/testing/selftests/vfio/scripts/lib.sh
 create mode 100755 tools/testing/selftests/vfio/scripts/run.sh
 create mode 100755 tools/testing/selftests/vfio/scripts/setup.sh
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_device_init_perf_test.c


base-commit: fa804aa4ac1b091ef2ec2981f08a1c28aaeba8e7
prerequisite-patch-id: dcf23dcc1198960bda3102eefaa21df60b2e4c54
prerequisite-patch-id: e32e56d5bf7b6c7dd40d737aa3521560407e00f5
prerequisite-patch-id: 4f79a41bf10a4c025ba5f433551b46035aa15878
prerequisite-patch-id: f903a45f0c32319138cd93a007646ab89132b18c
-- 
2.52.0.rc2.455.g230fcf2819-goog


