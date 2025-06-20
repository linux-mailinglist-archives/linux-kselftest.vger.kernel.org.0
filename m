Return-Path: <linux-kselftest+bounces-35494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A82EAE2607
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 01:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A7C17FAEC
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 23:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1644242D6F;
	Fri, 20 Jun 2025 23:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YKzou3BD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4545241676
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 23:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461666; cv=none; b=XiBPe6ByplGRiEOx+AdV0F8w09xrgQvZO1hNBnQCF9kbLIevtHbxNeTI1eCJ2SUgecB1qGDhYGaHsV+Gm1053V7fZdtwbRTaiCqtVQow1TAsjQwZxwEsDaQ54IRyvrHj4Px5eAAr7LBsHqQAG8CYr9drK+FlwLqreOQB0qPTxao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461666; c=relaxed/simple;
	bh=A2GY4f+UkC/FVA+DcPYTr05SxriVk7XglO8D4A46ueY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CcVjWgA+hmtTV15Oqq2YMbdXWzDF91iAovVSVRG3WwQMdO+ABewIetCrXIN6epalthxSFUIcn1j9JW4m5i4KOv46HHE8phmpLY+Xb6pIxFTac+8JIiNQx0j/mS6/UPb+L+FYhq7hYyB258RxXTOqqxf7zK1lHAODo/gfZKLTK3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YKzou3BD; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3132c1942a1so3305786a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 16:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750461663; x=1751066463; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2IwC6GjZGgGp4sPt1gqcutYb/jbF7v05EB8HNO/lb7Y=;
        b=YKzou3BDghhA7GsRCiqJHZYZP+/2nhSccJZ6N4lT0osjUEmHBRueqXADs8T2SU+zvS
         b7dXh6hk8glOMvRyQObLkNUjAgzVW3L/1ueB4XD02dlLKaX7OY2BlBylWwVTt0zGi4c+
         zvI7VnKZCO7+0MY3rhOr+9qTclgudoF9Rh0fg1QpJ1S8o9bpzpv28iTaBOAkT2IEQjd1
         ecT0SBIP8b2frManGKNj00SVxwS0+r5SK5ZEROeV+y33p871yEJw1BWsvLOpxwwhGlFJ
         FjcGOmAji7DG2xfTQCIT8oiecr/NfXdevwRJGxKaTMV8iS2gJoTp38Jl5XghEKkgAFbU
         3+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461663; x=1751066463;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2IwC6GjZGgGp4sPt1gqcutYb/jbF7v05EB8HNO/lb7Y=;
        b=dRzFQIlTo4PgIgvp5J6IVMuUDDGrFwAPbc0HkDGZ/nYOxH055VQClF6ELQ2ufbp7Q4
         qRcxvbjnXS4W2qTU0a/n+W4gPZuWKAkrqNDFkz//yLSYV4xoS9w9YVpCM7acHqlrbMnp
         TEugoXS5mTMRBCg7DgakuokOJiTKHWDNPun1VSzYJi16kT1pp/LgIUXvTxkFIWq7TU3q
         Rv/GTnAqimU7HXFbUnyRs52E4t9j2rp0NI8mkBJlBC+HKg90vEmJY60fg/2jYvk/6cft
         1WGMdF2juaL0c7TwUCvPWWRvTkx1LichIypw+TqTNBiibKeQoJdRtUhpiREt6oLZ0NxN
         ttIw==
X-Forwarded-Encrypted: i=1; AJvYcCXkZhFmgoRyqkukCNQO7xhBPo4LZJrTXvl4vEvPW4aY2iKNgLGcb581ROAAxkAXGTqMCV2o0aN9BjoHAo9ufGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaJMP8gAOu+PxjSks1rnN+FqIW7kU615PdUAdxNZJE0u/R0lsc
	A5ld+d0AUmslnKIwDPhT+MnRwn559+DAPaNA8q9W8J27zU/NTGC+BQOtddaF/nYOYcY9zeHbLiM
	FfxRp90OdINLbWA==
X-Google-Smtp-Source: AGHT+IHYHGVDcroXxJms8lt0fgiklFRsAvYHVXhRXfWxllxbK+j0KU7M4K1oUbCFCdeSN0pU6Czjg6IP9L9/cQ==
X-Received: from pjxx12.prod.google.com ([2002:a17:90b:58cc:b0:312:4b0b:a94])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2889:b0:311:e8cc:4248 with SMTP id 98e67ed59e1d1-3159d8f7f8emr8939680a91.33.1750461663320;
 Fri, 20 Jun 2025 16:21:03 -0700 (PDT)
Date: Fri, 20 Jun 2025 23:19:58 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620232031.2705638-1-dmatlack@google.com>
Subject: [PATCH 00/33] vfio: Introduce selftests for VFIO
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Bibo Mao <maobibo@loongson.cn>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, David Matlack <dmatlack@google.com>, dmaengine@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, James Houghton <jthoughton@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Wei Yang <richard.weiyang@gmail.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"

This series introduces VFIO selftests, located in
tools/testing/selftests/vfio/.

VFIO selftests aim to enable kernel developers to write and run tests
that take the form of userspace programs that interact with VFIO and
IOMMUFD uAPIs. VFIO selftests can be used to write functional tests for
new features, regression tests for bugs, and performance tests for
optimizations.

These tests are designed to interact with real PCI devices, i.e. they do
not rely on mocking out or faking any behavior in the kernel. This
allows the tests to exercise not only VFIO but also IOMMUFD, the IOMMU
driver, interrupt remapping, IRQ handling, etc.

For more background on the motivation and design of this series, please
see the RFC:

  https://lore.kernel.org/kvm/20250523233018.1702151-1-dmatlack@google.com/

This series can also be found on GitHub:

  https://github.com/dmatlack/linux/tree/vfio/selftests/v1

Changelog
-----------------------------------------------------------------------

RFC: https://lore.kernel.org/kvm/20250523233018.1702151-1-dmatlack@google.com/

 - Add symlink to linux/pci_ids.h instead of copying (Jason)
 - Add symlinks to drivers/dma/*/*.h instead of copying (Jason)
 - Automatically replicate vfio_dma_mapping_test across backing
   sources using fixture variants (Jason)
 - Automatically replicate vfio_dma_mapping_test and
   vfio_pci_driver_test across all iommu_modes using fixture
   variants (Jason)
 - Invert access() check in vfio_dma_mapping_test (me)
 - Use driver_override instead of add/remove_id (Alex)
 - Allow tests to get BDF from env var (Alex)
 - Use KSFT_FAIL instead of 1 to exit with failure (Alex)
 - Unconditionally create $(LIBVFIO_O_DIRS) to avoid target
   conflict with ../cgroup/lib/libcgroup.mk when building
   KVM selftests (me)
 - Allow VFIO selftests to run automatically by switching from
   TEST_GEN_PROGS_EXTENDED to TEST_GEN_PROGS. Automatically run
   selftests will use $VFIO_SELFTESTS_BDF environment variable
   to know which device to use (Alex)
 - Replace hardcoded SZ_4K with getpagesize() in vfio_dma_mapping_test
   to support platforms with other page sizes (me)
 - Make all global variables static where possible (me)
 - Pass argc and argv to test_harness_main() so that users can
   pass flags to the kselftest harness (me)

Instructions
-----------------------------------------------------------------------

Running VFIO selftests requires at a PCI device bound to vfio-pci for
the tests to use. The address of this device is passed to the test as
a segment:bus:device.function string, which must match the path to
the device in /sys/bus/pci/devices/ (e.g. 0000:00:04.0).

Once you have chosen a device, there is a helper script provided to
unbind the device from its current driver, bind it to vfio-pci, export
the environment variable $VFIO_SELFTESTS_BDF, and launch a shell:

  $ tools/testing/selftests/vfio/run.sh -d 0000:00:04.0 -s

The -d option tells the script which device to use and the -s option
tells the script to launch a shell.

Additionally, the VFIO selftest vfio_dma_mapping_test has test cases
that rely on HugeTLB pages being available, otherwise they are skipped.
To enable those tests make sure at least 1 2MB and 1 1GB HugeTLB pages
are available.

  $ echo 1 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
  $ echo 1 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages

To run all VFIO selftests using make:

  $ make -C tools/testing/selftests/vfio run_tests

To run individual tests:

  $ tools/testing/selftests/vfio/vfio_dma_mapping_test
  $ tools/testing/selftests/vfio/vfio_dma_mapping_test -v iommufd_anonymous_hugetlb_2mb
  $ tools/testing/selftests/vfio/vfio_dma_mapping_test -r vfio_dma_mapping_test.iommufd_anonymous_hugetlb_2mb.dma_map_unmap

The environment variable $VFIO_SELFTESTS_BDF can be overridden for a
specific test by passing in the BDF on the command line as the last
positional argument.

  $ tools/testing/selftests/vfio/vfio_dma_mapping_test 0000:00:04.0
  $ tools/testing/selftests/vfio/vfio_dma_mapping_test -v iommufd_anonymous_hugetlb_2mb 0000:00:04.0
  $ tools/testing/selftests/vfio/vfio_dma_mapping_test -r vfio_dma_mapping_test.iommufd_anonymous_hugetlb_2mb.dma_map_unmap 0000:00:04.0

When you are done, free the HugeTLB pages and exit the shell started by
run.sh. Exiting the shell will cause the device to be unbound from
vfio-pci and bound back to its original driver.

  $ echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
  $ echo 0 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
  $ exit

It's also possible to use run.sh to run just a single test hermetically,
rather than dropping into a shell:

  $ tools/testing/selftests/vfio/run.sh -d 0000:00:04.0 -- tools/testing/selftests/vfio/vfio_dma_mapping_test -v iommufd_anonymous

Tests
-----------------------------------------------------------------------

There are 5 tests in this series, mostly to demonstrate as a
proof-of-concept:

 - tools/testing/selftests/vfio/vfio_pci_device_test.c
 - tools/testing/selftests/vfio/vfio_pci_driver_test.c
 - tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
 - tools/testing/selftests/vfio/vfio_dma_mapping_test.c
 - tools/testing/selftests/kvm/vfio_pci_device_irq_test.c

Future Areas of Development
-----------------------------------------------------------------------

Library:

 - Driver support for devices that can be used on AMD, ARM, and other
   platforms (e.g. mlx5).
 - Driver support for a device available in QEMU VMs (e.g.
   pcie-ats-testdev [1])
 - Support for tests that use multiple devices.
 - Support for IOMMU groups with multiple devices.
 - Support for multiple devices sharing the same container/iommufd.
 - Sharing TEST_ASSERT() macros and other common code between KVM
   and VFIO selftests.

Tests:

 - DMA mapping performance tests for BARs/HugeTLB/etc.
 - Porting tests from
   https://github.com/awilliam/tests/commits/for-clg/ to selftests.
 - Live Update selftests.
 - Porting Sean's KVM selftest for posted interrupts to use the VFIO
   selftests library [2]

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Vipin Sharma <vipinsh@google.com>
Cc: Josh Hilke <jrhilke@google.com>
Cc: Aaron Lewis <aaronlewis@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>
Cc: Joel Granados <joel.granados@kernel.org>

[1] https://github.com/Joelgranados/qemu/blob/pcie-testdev/hw/misc/pcie-ats-testdev.c
[2] https://lore.kernel.org/kvm/20250404193923.1413163-68-seanjc@google.com/

David Matlack (28):
  selftests: Create tools/testing/selftests/vfio
  vfio: selftests: Add a helper library for VFIO selftests
  vfio: selftests: Introduce vfio_pci_device_test
  tools headers: Add stub definition for __iomem
  tools headers: Import asm-generic MMIO helpers
  tools headers: Import x86 MMIO helper overrides
  tools headers: Import iosubmit_cmds512()
  tools headers: Add symlink to linux/pci_ids.h
  vfio: selftests: Keep track of DMA regions mapped into the device
  vfio: selftests: Enable asserting MSI eventfds not firing
  vfio: selftests: Add a helper for matching vendor+device IDs
  vfio: selftests: Add driver framework
  vfio: sefltests: Add vfio_pci_driver_test
  dmaengine: ioat: Move system_has_dca_enabled() to dma.h
  vfio: selftests: Add driver for Intel CBDMA
  dmaengine: idxd: Allow registers.h to be included from tools/
  vfio: selftests: Add driver for Intel DSA
  vfio: selftests: Move helper to get cdev path to libvfio
  vfio: selftests: Encapsulate IOMMU mode
  vfio: selftests: Replicate tests across all iommu_modes
  vfio: selftests: Add vfio_type1v2_mode
  vfio: selftests: Add iommufd_compat_type1{,v2} modes
  vfio: selftests: Add iommufd mode
  vfio: selftests: Make iommufd the default iommu_mode
  vfio: selftests: Add a script to help with running VFIO selftests
  KVM: selftests: Build and link sefltests/vfio/lib into KVM selftests
  KVM: selftests: Test sending a vfio-pci device IRQ to a VM
  KVM: selftests: Add -d option to vfio_pci_device_irq_test for
    device-sent MSIs

Josh Hilke (5):
  vfio: selftests: Test basic VFIO and IOMMUFD integration
  vfio: selftests: Move vfio dma mapping test to their own file
  vfio: selftests: Add test to reset vfio device.
  vfio: selftests: Add DMA mapping tests for 2M and 1G HugeTLB
  vfio: selftests: Validate 2M/1G HugeTLB are mapped as 2M/1G in IOMMU

 MAINTAINERS                                   |   7 +
 drivers/dma/idxd/registers.h                  |   4 +
 drivers/dma/ioat/dma.h                        |   2 +
 drivers/dma/ioat/hw.h                         |   3 -
 tools/arch/x86/include/asm/io.h               | 101 +++
 tools/arch/x86/include/asm/special_insns.h    |  27 +
 tools/include/asm-generic/io.h                | 482 ++++++++++++++
 tools/include/asm/io.h                        |  11 +
 tools/include/linux/compiler.h                |   4 +
 tools/include/linux/io.h                      |   4 +-
 tools/include/linux/pci_ids.h                 |   1 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/kvm/Makefile.kvm      |   4 +
 .../testing/selftests/kvm/include/kvm_util.h  |   4 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  21 +
 .../selftests/kvm/vfio_pci_device_irq_test.c  | 172 +++++
 tools/testing/selftests/vfio/.gitignore       |   7 +
 tools/testing/selftests/vfio/Makefile         |  21 +
 .../selftests/vfio/lib/drivers/dsa/dsa.c      | 416 ++++++++++++
 .../vfio/lib/drivers/dsa/registers.h          |   1 +
 .../selftests/vfio/lib/drivers/ioat/hw.h      |   1 +
 .../selftests/vfio/lib/drivers/ioat/ioat.c    | 235 +++++++
 .../vfio/lib/drivers/ioat/registers.h         |   1 +
 .../selftests/vfio/lib/include/vfio_util.h    | 295 +++++++++
 tools/testing/selftests/vfio/lib/libvfio.mk   |  24 +
 .../selftests/vfio/lib/vfio_pci_device.c      | 594 ++++++++++++++++++
 .../selftests/vfio/lib/vfio_pci_driver.c      | 126 ++++
 tools/testing/selftests/vfio/run.sh           | 109 ++++
 .../selftests/vfio/vfio_dma_mapping_test.c    | 199 ++++++
 .../selftests/vfio/vfio_iommufd_setup_test.c  | 127 ++++
 .../selftests/vfio/vfio_pci_device_test.c     | 176 ++++++
 .../selftests/vfio/vfio_pci_driver_test.c     | 247 ++++++++
 32 files changed, 3423 insertions(+), 4 deletions(-)
 create mode 100644 tools/arch/x86/include/asm/io.h
 create mode 100644 tools/arch/x86/include/asm/special_insns.h
 create mode 100644 tools/include/asm-generic/io.h
 create mode 100644 tools/include/asm/io.h
 create mode 120000 tools/include/linux/pci_ids.h
 create mode 100644 tools/testing/selftests/kvm/vfio_pci_device_irq_test.c
 create mode 100644 tools/testing/selftests/vfio/.gitignore
 create mode 100644 tools/testing/selftests/vfio/Makefile
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
 create mode 120000 tools/testing/selftests/vfio/lib/drivers/dsa/registers.h
 create mode 120000 tools/testing/selftests/vfio/lib/drivers/ioat/hw.h
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c
 create mode 120000 tools/testing/selftests/vfio/lib/drivers/ioat/registers.h
 create mode 100644 tools/testing/selftests/vfio/lib/include/vfio_util.h
 create mode 100644 tools/testing/selftests/vfio/lib/libvfio.mk
 create mode 100644 tools/testing/selftests/vfio/lib/vfio_pci_device.c
 create mode 100644 tools/testing/selftests/vfio/lib/vfio_pci_driver.c
 create mode 100755 tools/testing/selftests/vfio/run.sh
 create mode 100644 tools/testing/selftests/vfio/vfio_dma_mapping_test.c
 create mode 100644 tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_device_test.c
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_driver_test.c


base-commit: e271ed52b344ac02d4581286961d0c40acc54c03
prerequisite-patch-id: c1decca4653262d3d2451e6fd4422ebff9c0b589
-- 
2.50.0.rc2.701.gf1e915cc24-goog


