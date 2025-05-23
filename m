Return-Path: <linux-kselftest+bounces-33696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6AAAC2C26
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8B59E629A
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1034A20E018;
	Fri, 23 May 2025 23:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jWdcSki9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EED71A2632
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748043033; cv=none; b=YN7edN0g/XBKPEUX6d+9/+v6qozsoB2WJBkujdLzvnVeRDdGXgnXEzNv7sW+RBrEd1PGHPQasFZ52Wz9RqP2fZPpWdugw7WjcDlKe6Pwg731BdvlwswHDEm09u5UoSb4fSCpNIqinN8WTjeK2797GALP/UKRuZPKntib4qJGmCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748043033; c=relaxed/simple;
	bh=Z4ViRGA3sApZIWexaAZQyjD33x4WBjVcv2mwMW95buE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YGR6XLqI3XG5FLgu0zVsLVLJdkYVBOU9EolE+oAVLkQeyMxhGOd/q63hB957NbvCEjU87NfiDYPD3t5SonN3b6ZcUmSiQVTeITEhtrFGhhLDrgu3KLPZI3LQsf+tM9UI59L6cp1Du8VHj9gF4MF4ogpHe9TzNyNoLjjDUp9OVvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jWdcSki9; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30e9659a391so350702a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748043030; x=1748647830; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wpY9IHPQ8jTi+8C1K5DYzZlCQ1FZWna/S7kqvI4+y9k=;
        b=jWdcSki9u0nLZg7b5fOHQ3h57yRJQbApyRloCuBg6Pcjv4xPgah8Id1IejT80hCLC+
         HRLrwsG2kcmT7i6cfQDuWhcEwDbZXy0GCofuzTnIqGHBz0uC/6hHQ2AK/eLrVLXL1zC3
         Obf2t6iDkpNSJjwb6Dl6Sw8MTR6o6XPKHQOqpTHdT8dQfZgWJV5n7caqgq3IUG6nm5jw
         T2PFYDj07GKjkHk7e2XWVG29SbKvBqQrrVnwTBYLuXzqx4IzK3Oxs0a26c2zcbl2AZ5S
         LWz+eY1WZMDFcDm20WB+jJ/joKxFswvabC+D4j7sX8GfO1AHvTFnOgt5qsvI9wFCkMZh
         w8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748043030; x=1748647830;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wpY9IHPQ8jTi+8C1K5DYzZlCQ1FZWna/S7kqvI4+y9k=;
        b=XraKhdvEKQi+payjB5cNTYzz3lsd5XTGSEOL+QIJ2JEV/MUbVBYivTSajSwpZ2pssg
         Aqba3IxiKlVqHib7qm2nOWnrogv4aQhm0vd2rf5vCwc9p1ai19D1NUvI4oSOCg7aGagn
         nbTfgyTGmRHQYu/Lx3P79FerA3IbNZvIq4CLtwwsi02YO0+jMPTUn3u6gFgzOYnozw1O
         x3YwXat03g2vMGBOzY2/frajOAnggzjdirOXsRk9WF1KrqvZQpTXOJ+Glzrvynz8HvAK
         ydNwRkSG8nn154ad4B8pPIUms4oVgLkm3rN318qJO9RVntrIvYZmtFdctP9H902wFU8J
         AgKg==
X-Forwarded-Encrypted: i=1; AJvYcCXBl3KLd0bXDUuoFZN8fW6mJPRrXrMCfXdcNbnOTahnvAILxI5PtN7c2VcGiMXsCkhvCCP5gUYSDEiSFl10/ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNieq+rFb3fByZsW9wL3/lK5f8HZysvHWYZbgZwrLAxZFb1LWC
	ersjUMYuoovxscleWIQRceybU+SMxJKnT1J45lqiyFUZx02poYolgo5UYqGZtCSCBdSY/YYX1Uy
	HKWF72oiMFLIlVw==
X-Google-Smtp-Source: AGHT+IGGVRwZZ71ejwz9t0AXrzI4kh+FfHAknDkLKnMe03PkZavsLJ0gpj7RalIfJUh2f1xYL6bzSrpVEkiuHw==
X-Received: from pjbdy5.prod.google.com ([2002:a17:90b:6c5:b0:2fc:1356:bcc3])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3891:b0:2ee:f677:aa14 with SMTP id 98e67ed59e1d1-3110f30dfe4mr1448997a91.13.1748043030222;
 Fri, 23 May 2025 16:30:30 -0700 (PDT)
Date: Fri, 23 May 2025 23:29:45 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523233018.1702151-1-dmatlack@google.com>
Subject: [RFC PATCH 00/33] vfio: Introduce selftests for VFIO
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Matlack <dmatlack@google.com>, Vinod Koul <vkoul@kernel.org>, 
	Fenghua Yu <fenghua.yu@intel.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, WangYuli <wangyuli@uniontech.com>, 
	Sean Christopherson <seanjc@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>, 
	Josh Hilke <jrhilke@google.com>, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
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

We chose selftests to host these tests primarily to enable integration
with the existing KVM selftests. As explained in the next section,
enabling KVM developers to test the interaction between VFIO and KVM is
one of the motivators of this series.

Motivation
-----------------------------------------------------------------------

The main motivation for this series is upcoming development in the
kernel to support Hypervisor Live Updates [1][2]. Live Update is a
specialized reboot process where selected devices are kept operational
and their kernel state is preserved and recreated across a kexec. For
devices, DMA and interrupts may continue during the reboot. VFIO-bound
devices are the main target, since the first usecase of Live Updates is
to enable host kernel upgrades in a Cloud Computing environment without
disrupting running customer VMs.

To prepare for upcoming support for Live Updates in VFIO, IOMMUFD, IOMMU
drivers, the PCI layer, etc., we'd like to first lay the ground work for
exercising and testing VFIO from kernel selftests. This way when we
eventually upstream support for Live Updates, we can also upstream tests
for those changes, rather than purely relying on Live Update integration
tests which would be hard to share and reproduce upstream.

But even without Live Updates, VFIO and IOMMUFD are becoming an
increasingly critical component of running KVM-based VMs in cloud
environments. Virtualized networking and storage are increasingly being
offloaded to smart NICs/cards, and demand for high performance
networking, storage, and AI are also leading to NICs, SSDs, and GPUs
being directly attached to VMs via VFIO.

VFIO selftests increases our ability to test in several ways.

 - It enables developers sending VFIO, IOMMUFD, etc. commits upstream to
   test their changes against all existing VFIO selftests, reducing the
   probability of regressions.

 - It enables developers sending VFIO, IOMMUFD, etc. commits upstream to
   include tests alongside their changes, increasing the quality of the
   code that is merged.

 - It enables testing the interaction between VFIO and KVM. There are
   some paths in KVM that are only exercised through VFIO, such as IRQ
   bypass. VFIO selftests provides a helper library to enable KVM
   developers to write KVM selftests to test those interactions [3].

Design
-----------------------------------------------------------------------

VFIO selftests are designed around interacting with with VFIO-managed PCI
devices. As such, the core data struture is struct vfio_pci_device, which
represents a single PCI device.

  struct vfio_pci_device *device;

  device = vfio_pci_device_init("0000:6a:01.0", iommu_mode);

  ...

  vfio_pci_device_cleanup(device);

vfio_pci_device_init() sets up a container or iommufd, depending on the
iommu_mode argument, to manage DMA mappings, fetches information about
the device and what interrupts it supports from VFIO and caches it, and
mmap()s all mappable BARs for the test to use.

There are helper methods that operate on struct vfio_pci_device to do
things like read and write to PCI config space, enable/disable IRQs, and
map memory for DMA,

struct vfio_pci_device and its methods do not care about what device
they are actually interacting with. It can be a GPU, a NIC, an SSD, etc.

To keep things simple initially, VFIO selftests only support a single
device per group and per container/iommufd. But it should be possible to
relax those restrictions in the future, e.g. to enable testing with
multiple devices in the same container/iommufd.

Driver Framework
-----------------------------------------------------------------------

In order to support VFIO selftests where a device is generating DMA and
interrupts on command, the VFIO selftests supports a driver framework.

This framework abstracts away device-specific details allowing VFIO
selftests to be written in a generic way, and then run against different
devices depending on what hardware developers have access to.

The framework also aims to support carrying drivers out-of-tree, e.g.
so that companies can run VFIO selftests with custom/test hardware.

Drivers must implement the following methods:

 - probe():        Check if the driver supports a given device.
 - init():         Initialize the driver.
 - remove():       Deinitialize the driver and reset the device.
 - memcpy_start(): Kick off a series of repeated memcpys (DMA reads and
                   DMA writes).
 - memcpy_wait():  Wait for a memcpy operation to complete.
 - send_msi():     Make the device send an MSI interrupt.

memcpy_start/wait() are for generating DMA. We separate the operation
into 2 steps so that tests can trigger a long-running DMA operation. We
expect to use this to stress test Live Updates by kicking off a
long-running mempcy operation and then performing a Live Update. These
methods are required to not generate any interrupts.

send_msi() is used for testing MSI and MSI-x interrupts. The driver
tells the test which MSI it will be using via device->driver.msi.

It's the responsibility of the test to set up a region of memory
and map it into the device for use by the driver, e.g. for in-memory
descriptors, before calling init().

A demo of the driver framework can be found in
tools/testing/selftests/vfio/vfio_pci_driver_test.c.

In addition, this series introduces a new KVM selftest to demonstrate
delivering a device MSI directly into a guest, which can be found in
tools/testing/selftests/kvm/vfio_pci_device_irq_test.c.

Tests
-----------------------------------------------------------------------

There are 5 tests in this series, mostly to demonstrate as a
proof-of-concept:

 - tools/testing/selftests/vfio/vfio_pci_device_test.c
 - tools/testing/selftests/vfio/vfio_pci_driver_test.c
 - tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
 - tools/testing/selftests/vfio/vfio_dma_mapping_test.c
 - tools/testing/selftests/kvm/vfio_pci_device_irq_test.c

Integrating with KVM selftests
-----------------------------------------------------------------------

To support testing the interactions between VFIO and KVM, the VFIO
selftests support sharing its library with the KVM selftest. The patches
at the end of this series demonstrate how that works.

Essentially, we allow the KVM selftests to build their own copy of
tools/testing/selftests/vfio/lib/ and link it into KVM selftests
binaries. This requires minimal changes to the KVM selftests Makefile.

Future Areas of Development
-----------------------------------------------------------------------

Library:

 - Driver support for devices that can be used on AMD, ARM, and other
   platforms.
 - Driver support for a device available in QEMU VMs.
 - Support for tests that use multiple devices.
 - Support for IOMMU groups with multiple devices.
 - Support for multiple devices sharing the same container/iommufd.
 - Sharing TEST_ASSERT() macros and other common code between KVM
   and VFIO selftests.

Tests:

 - DMA mapping performance tests for BARs/HugeTLB/etc.
 - Live Update selftests.
 - Porting Sean's KVM selftest for posted interrupts to use the VFIO
   selftests library [3]

This series can also be found on GitHub:

  https://github.com/dmatlack/linux/tree/vfio/selftests/rfc

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Vipin Sharma <vipinsh@google.com>
Cc: Josh Hilke <jrhilke@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>

[1] https://lore.kernel.org/all/f35359d5-63e1-8390-619f-67961443bfe1@google.com/
[2] https://lore.kernel.org/all/20250515182322.117840-1-pasha.tatashin@soleen.com/
[3] https://lore.kernel.org/kvm/20250404193923.1413163-68-seanjc@google.com/

David Matlack (28):
  selftests: Create tools/testing/selftests/vfio
  vfio: selftests: Add a helper library for VFIO selftests
  vfio: selftests: Introduce vfio_pci_device_test
  tools headers: Add stub definition for __iomem
  tools headers: Import asm-generic MMIO helpers
  tools headers: Import x86 MMIO helper overrides
  tools headers: Import iosubmit_cmds512()
  tools headers: Import drivers/dma/ioat/{hw.h,registers.h}
  tools headers: Import drivers/dma/idxd/registers.h
  tools headers: Import linux/pci_ids.h
  vfio: selftests: Keep track of DMA regions mapped into the device
  vfio: selftests: Enable asserting MSI eventfds not firing
  vfio: selftests: Add a helper for matching vendor+device IDs
  vfio: selftests: Add driver framework
  vfio: sefltests: Add vfio_pci_driver_test
  vfio: selftests: Add driver for Intel CBDMA
  vfio: selftests: Add driver for Intel DSA
  vfio: selftests: Move helper to get cdev path to libvfio
  vfio: selftests: Encapsulate IOMMU mode
  vfio: selftests: Add [-i iommu_mode] option to all tests
  vfio: selftests: Add vfio_type1v2_mode
  vfio: selftests: Add iommufd_compat_type1{,v2} modes
  vfio: selftests: Add iommufd mode
  vfio: selftests: Make iommufd the default iommu_mode
  vfio: selftests: Add a script to help with running VFIO selftests
  KVM: selftests: Build and link sefltests/vfio/lib into KVM selftests
  KVM: selftests: Test sending a vfio-pci device IRQ to a VM
  KVM: selftests: Use real device MSIs in vfio_pci_device_irq_test

Josh Hilke (5):
  vfio: selftests: Test basic VFIO and IOMMUFD integration
  vfio: selftests: Move vfio dma mapping test to their own file
  vfio: selftests: Add test to reset vfio device.
  vfio: selftests: Use command line to set hugepage size for DMA mapping
    test
  vfio: selftests: Validate 2M/1G HugeTLB are mapped as 2M/1G in IOMMU

 MAINTAINERS                                   |    7 +
 tools/arch/x86/include/asm/io.h               |  101 +
 tools/arch/x86/include/asm/special_insns.h    |   27 +
 tools/include/asm-generic/io.h                |  482 +++
 tools/include/asm/io.h                        |   11 +
 tools/include/drivers/dma/idxd/registers.h    |  601 +++
 tools/include/drivers/dma/ioat/hw.h           |  270 ++
 tools/include/drivers/dma/ioat/registers.h    |  251 ++
 tools/include/linux/compiler.h                |    4 +
 tools/include/linux/io.h                      |    4 +-
 tools/include/linux/pci_ids.h                 | 3212 +++++++++++++++++
 tools/testing/selftests/Makefile              |    1 +
 tools/testing/selftests/kvm/Makefile.kvm      |    6 +-
 .../testing/selftests/kvm/include/kvm_util.h  |    4 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |   21 +
 .../selftests/kvm/vfio_pci_device_irq_test.c  |  173 +
 tools/testing/selftests/vfio/.gitignore       |    7 +
 tools/testing/selftests/vfio/Makefile         |   20 +
 .../testing/selftests/vfio/lib/drivers/dsa.c  |  416 +++
 .../testing/selftests/vfio/lib/drivers/ioat.c |  235 ++
 .../selftests/vfio/lib/include/vfio_util.h    |  271 ++
 tools/testing/selftests/vfio/lib/libvfio.mk   |   26 +
 .../selftests/vfio/lib/vfio_pci_device.c      |  573 +++
 .../selftests/vfio/lib/vfio_pci_driver.c      |  126 +
 tools/testing/selftests/vfio/run.sh           |  110 +
 .../selftests/vfio/vfio_dma_mapping_test.c    |  239 ++
 .../selftests/vfio/vfio_iommufd_setup_test.c  |  133 +
 .../selftests/vfio/vfio_pci_device_test.c     |  195 +
 .../selftests/vfio/vfio_pci_driver_test.c     |  256 ++
 29 files changed, 7780 insertions(+), 2 deletions(-)
 create mode 100644 tools/arch/x86/include/asm/io.h
 create mode 100644 tools/arch/x86/include/asm/special_insns.h
 create mode 100644 tools/include/asm-generic/io.h
 create mode 100644 tools/include/asm/io.h
 create mode 100644 tools/include/drivers/dma/idxd/registers.h
 create mode 100644 tools/include/drivers/dma/ioat/hw.h
 create mode 100644 tools/include/drivers/dma/ioat/registers.h
 create mode 100644 tools/include/linux/pci_ids.h
 create mode 100644 tools/testing/selftests/kvm/vfio_pci_device_irq_test.c
 create mode 100644 tools/testing/selftests/vfio/.gitignore
 create mode 100644 tools/testing/selftests/vfio/Makefile
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/dsa.c
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/ioat.c
 create mode 100644 tools/testing/selftests/vfio/lib/include/vfio_util.h
 create mode 100644 tools/testing/selftests/vfio/lib/libvfio.mk
 create mode 100644 tools/testing/selftests/vfio/lib/vfio_pci_device.c
 create mode 100644 tools/testing/selftests/vfio/lib/vfio_pci_driver.c
 create mode 100755 tools/testing/selftests/vfio/run.sh
 create mode 100644 tools/testing/selftests/vfio/vfio_dma_mapping_test.c
 create mode 100644 tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_device_test.c
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_driver_test.c


base-commit: a11a72229881d8ac1d52ea727101bc9c744189c1
prerequisite-patch-id: 3bae97c9e1093148763235f47a84fa040b512d04
-- 
2.49.0.1151.ga128411c76-goog


