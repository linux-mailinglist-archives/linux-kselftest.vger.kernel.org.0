Return-Path: <linux-kselftest+bounces-39731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 719E3B3242F
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 23:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 280011D287A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 21:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EE93375CF;
	Fri, 22 Aug 2025 21:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v67D3q0u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB773375BD
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 21:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897970; cv=none; b=KifopENvakzUgQWvbhr1ApGrCDDOBh+JvZgHlZkUoSiiePlQ0foEx/fIFZhxu1xC0gWYtmIzk6IpLhYAgLSOMWyJ2EHxkywgn/1NyhwPreLv/FdQDNCC42TeiK2AQOJs811szJRVF6m6Fv9PwxGXbY37rahk7ftfGYW19m9OAhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897970; c=relaxed/simple;
	bh=NIr+mNcpCMIuu7uvOSGlQY9AMG2uG9ZgQZxqd7Lnwpc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=irHYFiMK+7XqZTypmUDuEWF6L3nwOhNKgq/uk7NKZIG8b4ErovDTpWD5U1D9emC/1+vUCrh0VPeExS7R/klABlEfYQiwcCEyL5/YhGJhVWIuT9O4gWJ7LtmMLnaEzj2rzlq0MeW0xx2pAAID6dYVQnlf36A0Gag/EJuhRIOKCg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v67D3q0u; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32505dbe21cso1536051a91.1
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 14:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755897968; x=1756502768; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w55t2f8OkCToOOWvDm3MMK2IaaLMEXkOJjxkIlVpt4M=;
        b=v67D3q0uXo8BwW4ebrQMfbcI3ERoTqudqQ8/4VGWRJ4zIArIxU69RIpLifLCqkf/5v
         ANNXmVPjbWK52o002XY81GAT6ZAys0skb/GJxRrWDRzgC16AkkvuN6gBNgCCC0CeIph7
         lOfZLjaNfj9xGUI39E2OBm+RPeLuyG5kD7Ef/OmaCMrTt1vGUX5lik60yp/yDvRTbgt3
         OmYBFjnXD0+Qm/PL0zPEaKY1bX62aS3yFpLWnL8tsolh0NZVyItAgQhMiEeQDUQztu+V
         4DesqxNdruqRiZEIy4eNHKUSy7fQ8kyHoJVH/TF096MKROiTHAOJ8vHGDC9F7Mmho0fc
         4zRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755897968; x=1756502768;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w55t2f8OkCToOOWvDm3MMK2IaaLMEXkOJjxkIlVpt4M=;
        b=Al5bZUUmLvRnIiJj5ahz9hTYYL6CTLgEueXpwXZ7iC4A2aRth3eoFgbpsytDc0h6gj
         72wOUQprp4bqc7iE3zeSD0LufXQEjXNxlhto6KtCiSOCnH9BZmBxEcYWrNMIOMhTqcyQ
         Fsutz8k5dY6DFetOF8SdaCdoyUtZN02W5VOXCVbovPgDNAjUiggXswARXHsBK27cYRnt
         Lb7cA550hCP+71aekAjM7YKzW0UW09J5leJAk/ouBJp9G9SH6waR7hruVB+ly79sd+w4
         QjC78mhjtTkLRlck0hc7aswoX9j2fJsHomZqBsNTIOFfvKwVTYZig7RJC0vkvVSVmwnY
         rgJA==
X-Forwarded-Encrypted: i=1; AJvYcCV5lud0m74eUNTUa2kijgIWa676cM9kbiEiGNzq2nIVkass1X6NYkSNTPguVw7pfP7aPIK+1Ft455A7PpsyJUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoa19W+5thGOUllJI6zzgOsI0TYYdBnMbOMxNheUPhZGGOdRav
	e9z+OG5gLF1tAVUR1phlzcUxShhvPNGl5l5oaBo7eD9zsyig3La+JXaEOtaSTGxQGWk4HD5ZYxe
	zY8vQXGIJBfkWAw==
X-Google-Smtp-Source: AGHT+IESiVJ4F27qaG1qx4KG05uGQ22GW+J7GyyaFrYLKyPol1no1GNnvdAOSplBE3j4tZFMp3BN606+S6tWsA==
X-Received: from pjbqo15.prod.google.com ([2002:a17:90b:3dcf:b0:321:76a2:947c])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:390f:b0:325:326b:c5b1 with SMTP id 98e67ed59e1d1-325326bc6bcmr4643851a91.17.1755897968144;
 Fri, 22 Aug 2025 14:26:08 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:24:47 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-1-dmatlack@google.com>
Subject: [PATCH v2 00/30] vfio: Introduce selftests for VFIO
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	David Matlack <dmatlack@google.com>, dmaengine@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	"Yury Norov [NVIDIA]" <yury.norov@gmail.com>
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

  https://github.com/dmatlack/linux/tree/vfio/selftests/v2

Changelog
-----------------------------------------------------------------------

v1: https://lore.kernel.org/kvm/20250620232031.2705638-1-dmatlack@google.com/

 - Collect various Acks
 - Switch myself from Reviewer to Maintainer of VFIO selftests
 - Re-order the new MAINTAINERS entry to be alphabetical
 - Drop the KVM selftests patches from the series
 - Reorder the tools header commits to be closer to the commits that
   use them (Vinicius)
 - Use host virtual addresses instead of magic numbers for IOVAs in
   vfio_pci_driver_test and vfio_dma_mapping_test

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

There are 4 tests in this series, mostly to demonstrate as a
proof-of-concept:

 - tools/testing/selftests/vfio/vfio_pci_device_test.c
 - tools/testing/selftests/vfio/vfio_pci_driver_test.c
 - tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
 - tools/testing/selftests/vfio/vfio_dma_mapping_test.c

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
 - Resend Sean's KVM selftest for posted interrupts using the VFIO
   selftests library [2][3]

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
[3] https://lore.kernel.org/kvm/20250620232031.2705638-32-dmatlack@google.com/

David Matlack (25):
  selftests: Create tools/testing/selftests/vfio
  vfio: selftests: Add a helper library for VFIO selftests
  vfio: selftests: Introduce vfio_pci_device_test
  vfio: selftests: Keep track of DMA regions mapped into the device
  vfio: selftests: Enable asserting MSI eventfds not firing
  vfio: selftests: Add a helper for matching vendor+device IDs
  vfio: selftests: Add driver framework
  vfio: sefltests: Add vfio_pci_driver_test
  tools headers: Add stub definition for __iomem
  tools headers: Import asm-generic MMIO helpers
  tools headers: Import x86 MMIO helper overrides
  tools headers: Add symlink to linux/pci_ids.h
  dmaengine: ioat: Move system_has_dca_enabled() to dma.h
  vfio: selftests: Add driver for Intel CBDMA
  tools headers: Import iosubmit_cmds512()
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
 .../selftests/vfio/vfio_pci_driver_test.c     | 244 +++++++
 28 files changed, 3219 insertions(+), 4 deletions(-)
 create mode 100644 tools/arch/x86/include/asm/io.h
 create mode 100644 tools/arch/x86/include/asm/special_insns.h
 create mode 100644 tools/include/asm-generic/io.h
 create mode 100644 tools/include/asm/io.h
 create mode 120000 tools/include/linux/pci_ids.h
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


base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


