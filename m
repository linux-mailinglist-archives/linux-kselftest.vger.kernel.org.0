Return-Path: <linux-kselftest+bounces-45441-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B239C5419B
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 20:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C8174E064C
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 19:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E16A3446AB;
	Wed, 12 Nov 2025 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MWme/AGa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996C922A4FC
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 19:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975366; cv=none; b=HYuxvkW9SRANS3GjmQdUwQRAy30BpQd0hTMdKLytsrAeZf2NzcB9iX/9cKLX+FmxIKomY24z9bk8Z1SeyMYlJLejps19ymz9li6ZEKqkt5TbSAUQIxSKSxj53/4E3bWdaONmKydO1YOVWQdQtODap8Vi43upqhiA25n/H22gJVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975366; c=relaxed/simple;
	bh=Ccvj/cRp9n0EA6bkrqI5xtjsqnLnKFQTubzZPPbdasU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hBdUbcEOI/Qqc21MdXAMTg6QOvP756pAM15R/mo9EJgk7obr0zM+HDLMd/0OGTT9+l5MmfXrj52qLBTNT9UgjYJM0LPwlkxidd+rhR+JpWqL5a8i0SrN3G0SI+1B7Y3clQUFWj+DLOIzcfKjWOVIpaleiKaqaSrTuS8RVKhoxNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MWme/AGa; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7a43210187cso1064374b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 11:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762975364; x=1763580164; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=shIl0TIKVpe45THPC9KaAUk5YHo0sJQy7q0J5waB4K0=;
        b=MWme/AGaQuopx2cBIZlR5S09vHyCX7+lVcCP3UpC2OWjztHkQ81SWUF4L7CXVyJs65
         1zjKdbkSMSH967UItVhx8d8bka8zOFq5GRIOwtrMPGcUo6SsWgalLwkJlId2pPuITw4q
         84yMbV4yFG/uNwrQ3rHJ1A9yJltPocTF3Xlqd4vJqZ7EexD9HSCvPm6SKucFIWU/Ra8C
         QjLPO89y7H41+dix6YrbPnOrTUuM8kvEy5abz/5CCuBTYwq5GIk1mrDSLxUrRAPNK3L4
         VIRdsCKWn9NKa4uH1j8uqycpZK1sq/9EyTgc+opI2Vr89ejurz4Gv3HuaDKwXp9Na/f+
         kupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975364; x=1763580164;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=shIl0TIKVpe45THPC9KaAUk5YHo0sJQy7q0J5waB4K0=;
        b=Qp2Z6iW892cbg6SEHECkqJi/Wjo2ljl1viQP/9KYDlRfWuSMMiCtXnKx8ZwYITGZdH
         NFqclq647OtPA3ohEVNyNwDtzuPRIFtcJ20uL7CGTt/RattO+miElIWy5LIj9CxZAH2e
         +0vjNfmucOMpGXWv1tLqRJDaWKCwCUUZiB7CiE4whdLm1vybcbB0kYQ7u40hTaVN8xeA
         TIkidrl6TCncbo7KbfrQJmKOJS2qlKScjbTcK+zX5Ijp1n3+6cp0OZUOqnr9eEWjUj5s
         VFdJkw9P2/PE/6XW/C5fFa8np9W9+uhzBi0BWrKRA00TduvTZUeUq30q5s0Emtq5DBH8
         CV6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWpyFa49/js3I3Z/8tYmGyaBhM9YGhABYEOZL+ir+i0erIcWfiGIsw929rlPfxQ55PPdjVbpDnC0iQUcpcGzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZPA20uF0KIVCCUkgWVOvlGwaI0RBOAp95/WhvOxv0khqrkEiX
	2ddCFsBd1RnRWylnnIhKKlDv4ufvhW7p8HWjKw+bHJuJIWU5oTdwZqNan3uZwK+f4yqH9mY3/ze
	kTmk82+AXO5FAiw==
X-Google-Smtp-Source: AGHT+IGR//a8agPfDAwBFFBJx10c8t4zrHuAwiJ6OeZd6iTS7BUi0a30+mYQXlV8qKbJhI6KF/l9alGEjvpTDA==
X-Received: from pgww11.prod.google.com ([2002:a05:6a02:2c8b:b0:bac:a20:5f17])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:9186:b0:358:dc7d:a2d0 with SMTP id adf61e73a8af0-359090919dcmr5178408637.7.1762975363943;
 Wed, 12 Nov 2025 11:22:43 -0800 (PST)
Date: Wed, 12 Nov 2025 19:22:14 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251112192232.442761-1-dmatlack@google.com>
Subject: [PATCH v2 00/18] vfio: selftests: Support for multi-device tests
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Raghavendra Rao Ananta <rananta@google.com>, 
	Vipin Sharma <vipinsh@google.com>
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
    - tools/testing/selftests/vfio/lib/iommu.c
    - tools/testing/selftests/vfio/lib/iova_allocator.c
    - tools/testing/selftests/vfio/lib/libvfio.c
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
series is merged into 6.18 and then into vfio/next.

This series can be found on GitHub:

  https://github.com/dmatlack/linux/tree/vfio/selftests/init_perf_test/v2

[1] https://lore.kernel.org/kvm/20251111-iova-ranges-v3-0-7960244642c5@fb.com/

Cc: Alex Mastro <amastro@fb.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Josh Hilke <jrhilke@google.com>
Cc: Raghavendra Rao Ananta <rananta@google.com>
Cc: Vipin Sharma <vipinsh@google.com>

v2:
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

 tools/testing/selftests/vfio/Makefile         |   9 +-
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
 .../vfio/vfio_pci_device_init_perf_test.c     | 167 ++++++
 .../selftests/vfio/vfio_pci_device_test.c     |  12 +-
 .../selftests/vfio/vfio_pci_driver_test.c     |  51 +-
 26 files changed, 1479 insertions(+), 1063 deletions(-)
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


base-commit: 0ed3a30fd996cb0cac872432cf25185fda7e5316
prerequisite-patch-id: dcf23dcc1198960bda3102eefaa21df60b2e4c54
prerequisite-patch-id: e32e56d5bf7b6c7dd40d737aa3521560407e00f5
prerequisite-patch-id: 4f79a41bf10a4c025ba5f433551b46035aa15878
prerequisite-patch-id: f903a45f0c32319138cd93a007646ab89132b18c
-- 
2.52.0.rc1.455.g30608eb744-goog


