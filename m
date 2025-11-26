Return-Path: <linux-kselftest+bounces-46542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B42C8B97D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 20:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37183B03DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 19:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA58433E354;
	Wed, 26 Nov 2025 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S8ur7mVI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B562D27A907
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 19:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185773; cv=none; b=ZoMDzLeG6nhiTgPjYph7dwhEjiwGhu8tO+4TzCdI+7QIn/88dFWPI2DApUqgNFScvr+Ck1bgIAAfF4WutGDbHSBYaT0VTSUK7yMKdmAhrHvDIsQ0vRdCjluIUHHseQLXGLBxN3WKKoeQxOFmmZAOFqfIPgFfHjPMRGt6zvo0WS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185773; c=relaxed/simple;
	bh=wdiTzfoiWi8flXhWTee2uq/9lBs376X8MQrM5Xh2PIE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZHJ2ayS+7fGKsi9g235BD87PIQJApGNzqj35ilwF7aEKIl9rYRuuXpVQrTEshG7ePLt555GmTmGgUSnlF6cvjQDN8ed9oKBqVkRZOHv65YjXTTBW+3Ymt3EGg+amCe5gMlM9KNOJP7zPO/8hm/xfup6cwvhj3VxQE+L7zZg2REc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S8ur7mVI; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7a4c4eeeef2so175061b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 11:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764185771; x=1764790571; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e4TlWrAe/4n7yxCRwObEG+IsI5t1kC6kq4+FowfY9Ic=;
        b=S8ur7mVITy2gcoG+j4MgxqZlyIle9uj/LKpZCBMskhN1QOyWcT4E17uoqATwvtK46g
         ZIGPkN7q7c4HCxmSvzPjEn37Iy8Gz4MwCwZzaZgWzHIPlll66nuSHu6vAkdGVvy337lt
         s0V9YXWAmeKdpHIGbIx2K+nDkevGo7LNaAnCZIBfk1B02LVMJulFObJ4Z4qA5Y802YFt
         9h8l6miobIB78DtD8id+zFHcQrQ4wtx7fjwCzy3cJbrEkmVnED16Tr7tW+F4mMZQw7UV
         /lt+xSwp2TleDbQt5UAO2YMDI8vtjW1TwUCUZzT7Yt9hEiVgD1VB9U+B42j7F2Fjs3TY
         zf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764185771; x=1764790571;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e4TlWrAe/4n7yxCRwObEG+IsI5t1kC6kq4+FowfY9Ic=;
        b=Ve+Ma8GIlu/JauGKxpLLn8oibJ1MuEBVIKbtByDi9quJKtEKVZXN0CuQs0NJVDpA57
         qloNVbWsAg6t+oe0Y+GmI3tsqmYw1AQLGX5YaHgGqj37w9soUzNNtgoyG4i7LE3onHt6
         tJG6QxAFGnh/XvOcIZvxMWvk4imiP1pEFRLfjOMjgpCIGXK6Xp2ninEJ3OmkRtAfRxAP
         ybehstzWTRDXHO6AyIFZK1mYiIqjLYDtCUNNVl1GLzdv9kvObJrEi3VDA0E2CMKtWPDe
         YC7iv5L1AKI0hZVXqMksqVU7F5arz93bhvzb+Yn5/XZ3YTWp4uln9/AKJY21MAHLzSQM
         EsMA==
X-Forwarded-Encrypted: i=1; AJvYcCVfQeUmihZGmUQ0eu6hNcAnpDgTAgN+tW8Ar0tdFyJfGSvxgG+SKULFWW8wXhuJuGiMuzkXfxfSdoxJVNGzp1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZZ1h6EkjnrFT8wQvvP/TfjFKtTZe+/3QTx4mUPDIBxY4dPtLQ
	Dt2N0HWs+Ke6IRwZbnjT7vNrd3LcO4MWBd/Pr6LSjElzN63ebiC1FisrZS/fkxaxR9jm2JznaAd
	v0wJS6trM7nv9jw==
X-Google-Smtp-Source: AGHT+IEHbsigKIplHHxqv3Y5oFPoEosqidqUdTdsObyZw4vOpd3yAV5ZgTmjD2o7uDOT9sLmmm0JWWf8SQqwug==
X-Received: from pfbly20.prod.google.com ([2002:a05:6a00:7594:b0:7b9:55bc:4970])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2d9a:b0:7b6:363b:c678 with SMTP id d2e1a72fcca58-7ca8760d166mr9728241b3a.6.1764185770882;
 Wed, 26 Nov 2025 11:36:10 -0800 (PST)
Date: Wed, 26 Nov 2025 19:35:47 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126193608.2678510-1-dmatlack@google.com>
Subject: [PATCH 00/21] vfio/pci: Base support to preserve a VFIO device file
 across Live Update
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Philipp Stanner <pstanner@redhat.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

This series adds the base support to preserve a VFIO device file across
a Live Update. "Base support" means that this allows userspace to
safetly preserve a VFIO device file with LIVEUPDATE_SESSION_PRESERVE_FD
and retrieve a preserved VFIO device file with
LIVEUPDATE_SESSION_RETRIEVE_FD, but the device itself is not preserved
in a fully running state across Live Update.

This series unblocks 2 parallel but related streams of work:

 - iommufd preservation across Live Update. This work spans iommufd,
   the IOMMU subsystem, and IOMMU drivers [1]

 - Preservation of VFIO device state across Live Update (config space,
   BAR addresses, power state, SR-IOV state, etc.). This work spans both
   VFIO and the core PCI subsystem.

While we need all of the above to fully preserve a VFIO device across a
Live Update without disrupting the workload on the device, this series
aims to be functional and safe enough to merge as the first incremental
step toward that goal.

Areas for Discussion
--------------------

BDF Stability across Live Update

  The PCI support for tracking preserved devices across a Live Update to
  prevent auto-probing relies on PCI segment numbers and BDFs remaining
  stable. For now I have disallowed VFs, as the BDFs assigned to VFs can
  vary depending on how the kernel chooses to allocate bus numbers. For
  non-VFs I am wondering if there is any more needed to ensure BDF
  stability across Live Update.

  While we would like to support many different systems and
  configurations in due time (including preserving VFs), I'd like to
  keep this first serses constrained to simple use-cases.

FLB Locking

  I don't see a way to properly synchronize pci_flb_finish() with
  pci_liveupdate_incoming_is_preserved() since the incoming FLB mutex is
  dropped by liveupdate_flb_get_incoming() when it returns the pointer
  to the object, and taking pci_flb_incoming_lock in pci_flb_finish()
  could result in a deadlock due to reversing the lock ordering.

FLB Retrieving

  The first patch of this series includes a fix to prevent an FLB from
  being retrieved again it is finished. I am wondering if this is the
  right approach or if subsystems are expected to stop calling
  liveupdate_flb_get_incoming() after an FLB is finished.

Testing
-------

The patches at the end of this series provide comprehensive selftests
for the new code added by this series. The selftests have been validated
in both a VM environment using a virtio-net PCIe device, and in a
baremetal environment on an Intel EMR server with an Intel DSA device.

Here is an example of how to run the new selftests:

vfio_pci_liveupdate_uapi_test:

  $ tools/testing/selftests/vfio/scripts/setup.sh 0000:00:04.0
  $ tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test 0000:00:04.0
  $ tools/testing/selftests/vfio/scripts/cleanup.sh

vfio_pci_liveupdate_kexec_test:

  $ tools/testing/selftests/vfio/scripts/setup.sh 0000:00:04.0
  $ tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test --stage 1 0000:00:04.0
  $ kexec [...]  # NOTE: distro-dependent

  $ tools/testing/selftests/vfio/scripts/setup.sh 0000:00:04.0
  $ tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test --stage 2 0000:00:04.0
  $ tools/testing/selftests/vfio/scripts/cleanup.sh

Dependencies
------------

This series was constructed on top of several in-flight series and on
top of mm-nonmm-unstable [2].

  +-- This series
  |
  +-- [PATCH v2 00/18] vfio: selftests: Support for multi-device tests
  |    https://lore.kernel.org/kvm/20251112192232.442761-1-dmatlack@google.com/
  |
  +-- [PATCH v3 0/4] vfio: selftests: update DMA mapping tests to use queried IOVA ranges
  |   https://lore.kernel.org/kvm/20251111-iova-ranges-v3-0-7960244642c5@fb.com/
  |
  +-- [PATCH v8 0/2] Live Update: File-Lifecycle-Bound (FLB) State
  |   https://lore.kernel.org/linux-mm/20251125225006.3722394-1-pasha.tatashin@soleen.com/
  |
  +-- [PATCH v8 00/18] Live Update Orchestrator
  |   https://lore.kernel.org/linux-mm/20251125165850.3389713-1-pasha.tatashin@soleen.com/
  |

To simplify checking out the code, this series can be found on GitHub:

  https://github.com/dmatlack/linux/tree/liveupdate/vfio/cdev/v1

Changelog
---------

v1:
 - Rebase series on top of LUOv8 and VFIO selftests improvements
 - Drop commits to preserve config space fields across Live Update.
   These changes require changes to the PCI layer. For exmaple,
   preserving rbars could lead to an inconsistent device state until
   device BARs addresses are preserved across Live Update.
 - Drop commits to preserve Bus Master Enable on the device. There's no
   reason to preserve this until iommufd preservation is fully working.
   Furthermore, preserving Bus Master Enable could lead to memory
   corruption when the device if the device is bound to the default
   identity-map domain after Live Update.
 - Drop commits to preserve saved PCI state. This work is not needed
   until we are ready to preserve the device's config space, and
   requires more thought to make the PCI state data layout ABI-friendly.
 - Add support to skip auto-probing devices that are preserved by VFIO
   to avoid them getting bound to a different driver by the next kernel.
 - Restrict device preservation further (no VFs, no intel-graphics).
 - Various refactoring and small edits to improve readability and
   eliminate code duplication.

rfc: https://lore.kernel.org/kvm/20251018000713.677779-1-vipinsh@google.com/

Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: William Tu <witu@nvidia.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Samiullah Khawaja <skhawaja@google.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Josh Hilke <jrhilke@google.com>
Cc: David Rientjes <rientjes@google.com>

[1] https://lore.kernel.org/linux-iommu/20250928190624.3735830-1-skhawaja@google.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/?h=mm-nonmm-unstable

David Matlack (12):
  liveupdate: luo_flb: Prevent retrieve() after finish()
  PCI: Add API to track PCI devices preserved across Live Update
  PCI: Require driver_override for incoming Live Update preserved
    devices
  vfio/pci: Notify PCI subsystem about devices preserved across Live
    Update
  vfio: Enforce preserved devices are retrieved via
    LIVEUPDATE_SESSION_RETRIEVE_FD
  vfio/pci: Store Live Update state in struct vfio_pci_core_device
  vfio: selftests: Add Makefile support for TEST_GEN_PROGS_EXTENDED
  vfio: selftests: Add vfio_pci_liveupdate_uapi_test
  vfio: selftests: Expose iommu_modes to tests
  vfio: selftests: Expose low-level helper routines for setting up
    struct vfio_pci_device
  vfio: selftests: Verify that opening VFIO device fails during Live
    Update
  vfio: selftests: Add continuous DMA to vfio_pci_liveupdate_kexec_test

Vipin Sharma (9):
  vfio/pci: Register a file handler with Live Update Orchestrator
  vfio/pci: Preserve vfio-pci device files across Live Update
  vfio/pci: Retrieve preserved device files after Live Update
  vfio/pci: Skip reset of preserved device after Live Update
  selftests/liveupdate: Move luo_test_utils.* into a reusable library
  selftests/liveupdate: Add helpers to preserve/retrieve FDs
  vfio: selftests: Build liveupdate library in VFIO selftests
  vfio: selftests: Initialize vfio_pci_device using a VFIO cdev FD
  vfio: selftests: Add vfio_pci_liveupdate_kexec_test

 MAINTAINERS                                   |   1 +
 drivers/pci/Makefile                          |   1 +
 drivers/pci/liveupdate.c                      | 248 ++++++++++++++++
 drivers/pci/pci-driver.c                      |  12 +-
 drivers/vfio/device_cdev.c                    |  25 +-
 drivers/vfio/group.c                          |   9 +
 drivers/vfio/pci/Makefile                     |   1 +
 drivers/vfio/pci/vfio_pci.c                   |  11 +-
 drivers/vfio/pci/vfio_pci_core.c              |  23 +-
 drivers/vfio/pci/vfio_pci_liveupdate.c        | 278 ++++++++++++++++++
 drivers/vfio/pci/vfio_pci_priv.h              |  16 +
 drivers/vfio/vfio.h                           |  13 -
 drivers/vfio/vfio_main.c                      |  22 +-
 include/linux/kho/abi/pci.h                   |  53 ++++
 include/linux/kho/abi/vfio_pci.h              |  45 +++
 include/linux/liveupdate.h                    |   3 +
 include/linux/pci.h                           |  38 +++
 include/linux/vfio.h                          |  51 ++++
 include/linux/vfio_pci_core.h                 |   7 +
 kernel/liveupdate/luo_flb.c                   |   4 +
 tools/testing/selftests/liveupdate/.gitignore |   1 +
 tools/testing/selftests/liveupdate/Makefile   |  14 +-
 .../include/libliveupdate.h}                  |  11 +-
 .../selftests/liveupdate/lib/libliveupdate.mk |  20 ++
 .../{luo_test_utils.c => lib/liveupdate.c}    |  43 ++-
 .../selftests/liveupdate/luo_kexec_simple.c   |   2 +-
 .../selftests/liveupdate/luo_multi_session.c  |   2 +-
 tools/testing/selftests/vfio/Makefile         |  23 +-
 .../vfio/lib/include/libvfio/iommu.h          |   2 +
 .../lib/include/libvfio/vfio_pci_device.h     |   8 +
 tools/testing/selftests/vfio/lib/iommu.c      |   4 +-
 .../selftests/vfio/lib/vfio_pci_device.c      |  60 +++-
 .../vfio/vfio_pci_liveupdate_kexec_test.c     | 255 ++++++++++++++++
 .../vfio/vfio_pci_liveupdate_uapi_test.c      |  93 ++++++
 34 files changed, 1313 insertions(+), 86 deletions(-)
 create mode 100644 drivers/pci/liveupdate.c
 create mode 100644 drivers/vfio/pci/vfio_pci_liveupdate.c
 create mode 100644 include/linux/kho/abi/pci.h
 create mode 100644 include/linux/kho/abi/vfio_pci.h
 rename tools/testing/selftests/liveupdate/{luo_test_utils.h => lib/include/libliveupdate.h} (80%)
 create mode 100644 tools/testing/selftests/liveupdate/lib/libliveupdate.mk
 rename tools/testing/selftests/liveupdate/{luo_test_utils.c => lib/liveupdate.c} (89%)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c

-- 
2.52.0.487.g5c8c507ade-goog


