Return-Path: <linux-kselftest+bounces-46577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 23416C8C4F6
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 00:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8A47F35034E
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 23:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3096331BCB7;
	Wed, 26 Nov 2025 23:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I1+ajg7g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D332EE60B
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 23:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764199067; cv=none; b=IgcVfbtM87TEndq/JVk9CkTYhls/ISgO6ESx3QVk0WSI0zpEA3oW6H2biZBqN8v6b0WqI/6Cftn99UBFX6MN3MrmSXeu/b9TXXbhcCcf2ydBuHFielzFjQQ7vE/oLI8sdPn/it/CuVbdTiVWuUkBPMSGU6CZWPK/jt33x1QG4oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764199067; c=relaxed/simple;
	bh=fAal4CbC565T8AukEvsx1Y6yN5vA0dvGqZqu9gFQxDs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jj9Z2RsCfLXWweEqXheFgQ8seIYqWGP0nvZQ9PhAtH9vAb4bObP5qUW6VXs9YZmBMW4Jj2LcxrQGqQnoHg3o7Dl087Yn5j5K8eRnYi3Gi/TIfY0DpBiZ4i1Y7NQM+jU7gI0q5DPceozE9qORGAMWbAjLhbHYzwCXDNAn4DIRSxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I1+ajg7g; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-bcecfea0e8aso749774a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 15:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764199062; x=1764803862; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rewarsz5lHkyJG1w0S/5e9AJ4dOqmqfJKq6P5FJmAK8=;
        b=I1+ajg7gLu0C1JXsCc+MEYUEfw+D96YOi9fi0syPMTkydsI9LQP7SHJ9eFIau40I9k
         8Bx1rkfUydkydIor6toNBmDY5nhnvsb9ctRQXMifl5dD+OFIoyZxNWVX3IcEOwvQ3+Wp
         rvbqDJanoIuEMu1vkeJW9PeLGR8KrpiPjZ/egOrb9EUQMwCkndiSqxMoI1XzHdJqee8/
         UaWqhVy13UBZsIfRTFcqzKsEKmGvHmbCU/GYNujBsQJM35PX/SpP7fB9A4Sx3c+CIKk1
         a7fHTCqv3KMDlYjMbCrLqVtfCOnT0AJJ6j2uV0T8n+bmQLi1eN/X2RFOUhm5WF08p1pf
         IwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764199062; x=1764803862;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rewarsz5lHkyJG1w0S/5e9AJ4dOqmqfJKq6P5FJmAK8=;
        b=ZPooT2CJhCgiAKp9BsHvVNM9BgOdccN3ShRCtT2DxFI3iI3kP0XJI6xt5BG5RoNdA2
         WwIWcn/+Mx56jttAyO4SMBKJ/5A+n+PAwHcE69Kcy8ycqBd4FoCvO0x+VJogwVKIT8mp
         ng/N3H0VACaIYel3Mb91LHTd+jqQ6FzlBh8ny6cdctwiGA5fquAEcwnWkKd4yj6jd2HN
         PjKkUdJm+MQXeFntmGWDjZUOAFso6oheG+uhohK81j+gP5/YdTMYkPYzVHss4k6ZYHu+
         eQIYsgjetlPiA/UVA0qSrlFLst/NuJ/gkTaxYPS6+QmUT4mTH8ltWJmJnfJ7JJBpvf/i
         l32Q==
X-Forwarded-Encrypted: i=1; AJvYcCVeO7C1cnqTbmsO3ATPP4Hey85JhMnk77OYJPhj++ppdn4k0AJ3H59IJZWtiNfUGvdPvxn3ss6NTDsxt4VPvhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJfK8upTztbsV/VRe6er5+6VZ0VZWAMJ+Q4AFQzMXckcnBGj80
	cmUgW/ePKBmHlsgUqq1lcJGFaPNgW0MghzuKNAhD+WeOv/tbj0UtKVPiYTJu4mIz/bm6GsbZhUT
	e5OltERAFDQdPNA==
X-Google-Smtp-Source: AGHT+IGl4ix+WUhNbfT6GuNED+PoTbz7h6VtC9pC+cMM5HkCe/+8ngbNnsgCrJsl2QHM7TWeuuvo+gqpPhueqw==
X-Received: from pjvl19.prod.google.com ([2002:a17:90a:dd93:b0:340:b503:505f])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4f8a:b0:343:78ed:8d19 with SMTP id 98e67ed59e1d1-3472985089cmr27137255a91.7.1764199062081;
 Wed, 26 Nov 2025 15:17:42 -0800 (PST)
Date: Wed, 26 Nov 2025 23:17:15 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126231733.3302983-1-dmatlack@google.com>
Subject: [PATCH v4 00/18] vfio: selftests: Support for multi-device tests
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
series makes its way to vfio/next via Linus' tree.

This series can be found on GitHub:

  https://github.com/dmatlack/linux/tree/vfio/selftests/init_perf_test/v4

[1] https://lore.kernel.org/kvm/20251111-iova-ranges-v3-0-7960244642c5@fb.com/

Cc: Alex Mastro <amastro@fb.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Josh Hilke <jrhilke@google.com>
Cc: Raghavendra Rao Ananta <rananta@google.com>
Cc: Vipin Sharma <vipinsh@google.com>

v4:
 - Collect Reviewed-bys from Raghavendra
 - Check iommu is not null in vfio_pci_device_init() (Raghavendra)
 - Do not include any fixes for the kernel-test-robot errors on riscv.
   These issues also exist when building the VFIO selftests without this
   series using kernel-test-robot's cross compiler. The issue appears to
   be that the cross compiler used by ktr does not have libc, which the
   selftests depend on.

v3: https://lore.kernel.org/kvm/20251121181429.1421717-1-dmatlack@google.com/
 - Replace literal with NSEC_PER_SEC (Alex Mastro)
 - Fix Makefile accumulate vs. assignment (Alex Mastro)

v2: https://lore.kernel.org/kvm/20251112192232.442761-1-dmatlack@google.com/
 - Require tests to call iommu_init() and manage struct iommu objects
   rather than implicitly doing it in vfio_pci_device_init().
 - Drop all the device wrappers for IOMMU methods and require tests to
   interact with the iommu_*() helper functions directly.
 - Add a commit to eliminate INVALID_IOVA. This is a simple cleanup I've
   been meaning to make.
 - Upgrade some driver logging to error (Raghavendra)
 - Remove plurality from helper function that fetches BDF from
   environment variable (Raghavendra)
 - Fix cleanup.sh to only delete the device directory when cleaning up
   all devices (Raghavendra)

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
 .../selftests/vfio/lib/vfio_pci_device.c      | 556 +-----------------
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
 26 files changed, 1482 insertions(+), 1063 deletions(-)
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
2.52.0.487.g5c8c507ade-goog


