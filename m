Return-Path: <linux-kselftest+bounces-34145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA73ACBA13
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 19:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790E21894FE3
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 17:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC85223323;
	Mon,  2 Jun 2025 17:12:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3B4EAF9;
	Mon,  2 Jun 2025 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748884361; cv=none; b=bYp4LWAMULoJ4Jdk1oV2dooicDM0q6zKelQBcle3pvRuAuXRySagwQiGs2v0zh+MK3MtHx3N7tmbsuTpNn4tY6P9kqf/GRU1fYwx8I1xpHtIoPx6PnikA+w1CRLUSvEaW8ZNrPjv4XHwARdEpZYv5RgV5MWoBbFoORwX6RMg2Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748884361; c=relaxed/simple;
	bh=T9SQYe2aG7VolQgy4LmKtAMXgMG4Ni5yLcTkD8QqPxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rrgarc14IU96+tvbO8m0W6IxhCubfJgXN0Hxfi5lTCGk5KsI2gHoRP38eKszBaFFNkVLahX1J+HkoiigFYt1yh0evzXHBvmvEu2Teq8R6yzPsBaaV8CRk3jqfgDnNolj4GXGwNZtm8SluFVQRxyJ1L3Jq8bNQiruH7GYCU00VkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org; spf=pass smtp.mailfrom=ozlabs.org; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	by gandalf.ozlabs.org (Postfix) with ESMTP id 4bB0lQ2SJ3z4xG0;
	Tue,  3 Jun 2025 03:12:34 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4bB0l8233rz4wvg;
	Tue,  3 Jun 2025 03:12:19 +1000 (AEST)
Message-ID: <75539071-1ac2-4160-ae13-54786ad8448e@kaod.org>
Date: Mon, 2 Jun 2025 19:12:16 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/33] vfio: Introduce selftests for VFIO
To: David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Vinod Koul <vkoul@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Wei Yang <richard.weiyang@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 WangYuli <wangyuli@uniontech.com>, Sean Christopherson <seanjc@google.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Eric Auger
 <eric.auger@redhat.com>, Josh Hilke <jrhilke@google.com>,
 linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Vipin Sharma <vipinsh@google.com>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Adithya Jayachandran <ajayachandra@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
References: <20250523233018.1702151-1-dmatlack@google.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250523233018.1702151-1-dmatlack@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/24/25 01:29, David Matlack wrote:
> This series introduces VFIO selftests, located in
> tools/testing/selftests/vfio/.
> 
> VFIO selftests aim to enable kernel developers to write and run tests
> that take the form of userspace programs that interact with VFIO and
> IOMMUFD uAPIs. VFIO selftests can be used to write functional tests for
> new features, regression tests for bugs, and performance tests for
> optimizations.
> 
> These tests are designed to interact with real PCI devices, i.e. they do
> not rely on mocking out or faking any behavior in the kernel. This
> allows the tests to exercise not only VFIO but also IOMMUFD, the IOMMU
> driver, interrupt remapping, IRQ handling, etc.
> 
> We chose selftests to host these tests primarily to enable integration
> with the existing KVM selftests. As explained in the next section,
> enabling KVM developers to test the interaction between VFIO and KVM is
> one of the motivators of this series.
> 
> Motivation
> -----------------------------------------------------------------------
> 
> The main motivation for this series is upcoming development in the
> kernel to support Hypervisor Live Updates [1][2]. Live Update is a
> specialized reboot process where selected devices are kept operational
> and their kernel state is preserved and recreated across a kexec. For
> devices, DMA and interrupts may continue during the reboot. VFIO-bound
> devices are the main target, since the first usecase of Live Updates is
> to enable host kernel upgrades in a Cloud Computing environment without
> disrupting running customer VMs.
> 
> To prepare for upcoming support for Live Updates in VFIO, IOMMUFD, IOMMU
> drivers, the PCI layer, etc., we'd like to first lay the ground work for
> exercising and testing VFIO from kernel selftests. This way when we
> eventually upstream support for Live Updates, we can also upstream tests
> for those changes, rather than purely relying on Live Update integration
> tests which would be hard to share and reproduce upstream.
> 
> But even without Live Updates, VFIO and IOMMUFD are becoming an
> increasingly critical component of running KVM-based VMs in cloud
> environments. Virtualized networking and storage are increasingly being
> offloaded to smart NICs/cards, and demand for high performance
> networking, storage, and AI are also leading to NICs, SSDs, and GPUs
> being directly attached to VMs via VFIO.
> 
> VFIO selftests increases our ability to test in several ways.
> 
>   - It enables developers sending VFIO, IOMMUFD, etc. commits upstream to
>     test their changes against all existing VFIO selftests, reducing the
>     probability of regressions.
> 
>   - It enables developers sending VFIO, IOMMUFD, etc. commits upstream to
>     include tests alongside their changes, increasing the quality of the
>     code that is merged.
> 
>   - It enables testing the interaction between VFIO and KVM. There are
>     some paths in KVM that are only exercised through VFIO, such as IRQ
>     bypass. VFIO selftests provides a helper library to enable KVM
>     developers to write KVM selftests to test those interactions [3].
> 
> Design
> -----------------------------------------------------------------------
> 
> VFIO selftests are designed around interacting with with VFIO-managed PCI
> devices. As such, the core data struture is struct vfio_pci_device, which
> represents a single PCI device.
> 
>    struct vfio_pci_device *device;
> 
>    device = vfio_pci_device_init("0000:6a:01.0", iommu_mode);
> 
>    ...
> 
>    vfio_pci_device_cleanup(device);
> 
> vfio_pci_device_init() sets up a container or iommufd, depending on the
> iommu_mode argument, to manage DMA mappings, fetches information about
> the device and what interrupts it supports from VFIO and caches it, and
> mmap()s all mappable BARs for the test to use.
> 
> There are helper methods that operate on struct vfio_pci_device to do
> things like read and write to PCI config space, enable/disable IRQs, and
> map memory for DMA,
> 
> struct vfio_pci_device and its methods do not care about what device
> they are actually interacting with. It can be a GPU, a NIC, an SSD, etc.
> 
> To keep things simple initially, VFIO selftests only support a single
> device per group and per container/iommufd. But it should be possible to
> relax those restrictions in the future, e.g. to enable testing with
> multiple devices in the same container/iommufd.
> 
> Driver Framework
> -----------------------------------------------------------------------
> 
> In order to support VFIO selftests where a device is generating DMA and
> interrupts on command, the VFIO selftests supports a driver framework.
> 
> This framework abstracts away device-specific details allowing VFIO
> selftests to be written in a generic way, and then run against different
> devices depending on what hardware developers have access to.
> 
> The framework also aims to support carrying drivers out-of-tree, e.g.
> so that companies can run VFIO selftests with custom/test hardware.
> > Drivers must implement the following methods:
> 
>   - probe():        Check if the driver supports a given device.
>   - init():         Initialize the driver.
>   - remove():       Deinitialize the driver and reset the device.
>   - memcpy_start(): Kick off a series of repeated memcpys (DMA reads and
>                     DMA writes).
>   - memcpy_wait():  Wait for a memcpy operation to complete.
>   - send_msi():     Make the device send an MSI interrupt.
> 
> memcpy_start/wait() are for generating DMA. We separate the operation
> into 2 steps so that tests can trigger a long-running DMA operation. We
> expect to use this to stress test Live Updates by kicking off a
> long-running mempcy operation and then performing a Live Update. These
> methods are required to not generate any interrupts.
> 
> send_msi() is used for testing MSI and MSI-x interrupts. The driver
> tells the test which MSI it will be using via device->driver.msi.
> 
> It's the responsibility of the test to set up a region of memory
> and map it into the device for use by the driver, e.g. for in-memory
> descriptors, before calling init().
> 
> A demo of the driver framework can be found in
> tools/testing/selftests/vfio/vfio_pci_driver_test.c.
> 
> In addition, this series introduces a new KVM selftest to demonstrate
> delivering a device MSI directly into a guest, which can be found in
> tools/testing/selftests/kvm/vfio_pci_device_irq_test.c.
> 
> Tests
> -----------------------------------------------------------------------
> 
> There are 5 tests in this series, mostly to demonstrate as a
> proof-of-concept:
> 
>   - tools/testing/selftests/vfio/vfio_pci_device_test.c
>   - tools/testing/selftests/vfio/vfio_pci_driver_test.c
>   - tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
>   - tools/testing/selftests/vfio/vfio_dma_mapping_test.c
>   - tools/testing/selftests/kvm/vfio_pci_device_irq_test.c
> 
> Integrating with KVM selftests
> -----------------------------------------------------------------------
> 
> To support testing the interactions between VFIO and KVM, the VFIO
> selftests support sharing its library with the KVM selftest. The patches
> at the end of this series demonstrate how that works.
> 
> Essentially, we allow the KVM selftests to build their own copy of
> tools/testing/selftests/vfio/lib/ and link it into KVM selftests
> binaries. This requires minimal changes to the KVM selftests Makefile.
> 
> Future Areas of Development
> -----------------------------------------------------------------------
> 
> Library:
> 
>   - Driver support for devices that can be used on AMD, ARM, and other
>     platforms.
>   - Driver support for a device available in QEMU VMs.

The QEMU igb and igbvf devices are good candidates.

I have been using these in QEMU VMs to test a few scenarios, IOMMUFD
and also VFIO migration with a custom VFIO PCI igbvf variant driver,
with dummy get/set handlers.

We also have the mdev mtty device driver but I think it is less useful.
Having a PCI device is more interesting for test coverage.

Anyhow, this is an excellent proposal. I plan to give it a try as soon
as possible, once the recent QEMU proposals for VFIO have made progress.

>   - Support for tests that use multiple devices.
>   - Support for IOMMU groups with multiple devices.
>   - Support for multiple devices sharing the same container/iommufd.
>   - Sharing TEST_ASSERT() macros and other common code between KVM
>     and VFIO selftests.
> 
> Tests:
> 
>   - DMA mapping performance tests for BARs/HugeTLB/etc.


Thanks,

C.




>   - Live Update selftests.
>   - Porting Sean's KVM selftest for posted interrupts to use the VFIO
>     selftests library [3]
> 
> This series can also be found on GitHub:
> 
>    https://github.com/dmatlack/linux/tree/vfio/selftests/rfc
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Vipin Sharma <vipinsh@google.com>
> Cc: Josh Hilke <jrhilke@google.com>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Saeed Mahameed <saeedm@nvidia.com>
> Cc: Saeed Mahameed <saeedm@nvidia.com>
> Cc: Adithya Jayachandran <ajayachandra@nvidia.com>
> Cc: Parav Pandit <parav@nvidia.com>
> Cc: Leon Romanovsky <leonro@nvidia.com>
> Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> 
> [1] https://lore.kernel.org/all/f35359d5-63e1-8390-619f-67961443bfe1@google.com/
> [2] https://lore.kernel.org/all/20250515182322.117840-1-pasha.tatashin@soleen.com/
> [3] https://lore.kernel.org/kvm/20250404193923.1413163-68-seanjc@google.com/
> 
> David Matlack (28):
>    selftests: Create tools/testing/selftests/vfio
>    vfio: selftests: Add a helper library for VFIO selftests
>    vfio: selftests: Introduce vfio_pci_device_test
>    tools headers: Add stub definition for __iomem
>    tools headers: Import asm-generic MMIO helpers
>    tools headers: Import x86 MMIO helper overrides
>    tools headers: Import iosubmit_cmds512()
>    tools headers: Import drivers/dma/ioat/{hw.h,registers.h}
>    tools headers: Import drivers/dma/idxd/registers.h
>    tools headers: Import linux/pci_ids.h
>    vfio: selftests: Keep track of DMA regions mapped into the device
>    vfio: selftests: Enable asserting MSI eventfds not firing
>    vfio: selftests: Add a helper for matching vendor+device IDs
>    vfio: selftests: Add driver framework
>    vfio: sefltests: Add vfio_pci_driver_test
>    vfio: selftests: Add driver for Intel CBDMA
>    vfio: selftests: Add driver for Intel DSA
>    vfio: selftests: Move helper to get cdev path to libvfio
>    vfio: selftests: Encapsulate IOMMU mode
>    vfio: selftests: Add [-i iommu_mode] option to all tests
>    vfio: selftests: Add vfio_type1v2_mode
>    vfio: selftests: Add iommufd_compat_type1{,v2} modes
>    vfio: selftests: Add iommufd mode
>    vfio: selftests: Make iommufd the default iommu_mode
>    vfio: selftests: Add a script to help with running VFIO selftests
>    KVM: selftests: Build and link sefltests/vfio/lib into KVM selftests
>    KVM: selftests: Test sending a vfio-pci device IRQ to a VM
>    KVM: selftests: Use real device MSIs in vfio_pci_device_irq_test
> 
> Josh Hilke (5):
>    vfio: selftests: Test basic VFIO and IOMMUFD integration
>    vfio: selftests: Move vfio dma mapping test to their own file
>    vfio: selftests: Add test to reset vfio device.
>    vfio: selftests: Use command line to set hugepage size for DMA mapping
>      test
>    vfio: selftests: Validate 2M/1G HugeTLB are mapped as 2M/1G in IOMMU
> 
>   MAINTAINERS                                   |    7 +
>   tools/arch/x86/include/asm/io.h               |  101 +
>   tools/arch/x86/include/asm/special_insns.h    |   27 +
>   tools/include/asm-generic/io.h                |  482 +++
>   tools/include/asm/io.h                        |   11 +
>   tools/include/drivers/dma/idxd/registers.h    |  601 +++
>   tools/include/drivers/dma/ioat/hw.h           |  270 ++
>   tools/include/drivers/dma/ioat/registers.h    |  251 ++
>   tools/include/linux/compiler.h                |    4 +
>   tools/include/linux/io.h                      |    4 +-
>   tools/include/linux/pci_ids.h                 | 3212 +++++++++++++++++
>   tools/testing/selftests/Makefile              |    1 +
>   tools/testing/selftests/kvm/Makefile.kvm      |    6 +-
>   .../testing/selftests/kvm/include/kvm_util.h  |    4 +
>   tools/testing/selftests/kvm/lib/kvm_util.c    |   21 +
>   .../selftests/kvm/vfio_pci_device_irq_test.c  |  173 +
>   tools/testing/selftests/vfio/.gitignore       |    7 +
>   tools/testing/selftests/vfio/Makefile         |   20 +
>   .../testing/selftests/vfio/lib/drivers/dsa.c  |  416 +++
>   .../testing/selftests/vfio/lib/drivers/ioat.c |  235 ++
>   .../selftests/vfio/lib/include/vfio_util.h    |  271 ++
>   tools/testing/selftests/vfio/lib/libvfio.mk   |   26 +
>   .../selftests/vfio/lib/vfio_pci_device.c      |  573 +++
>   .../selftests/vfio/lib/vfio_pci_driver.c      |  126 +
>   tools/testing/selftests/vfio/run.sh           |  110 +
>   .../selftests/vfio/vfio_dma_mapping_test.c    |  239 ++
>   .../selftests/vfio/vfio_iommufd_setup_test.c  |  133 +
>   .../selftests/vfio/vfio_pci_device_test.c     |  195 +
>   .../selftests/vfio/vfio_pci_driver_test.c     |  256 ++
>   29 files changed, 7780 insertions(+), 2 deletions(-)
>   create mode 100644 tools/arch/x86/include/asm/io.h
>   create mode 100644 tools/arch/x86/include/asm/special_insns.h
>   create mode 100644 tools/include/asm-generic/io.h
>   create mode 100644 tools/include/asm/io.h
>   create mode 100644 tools/include/drivers/dma/idxd/registers.h
>   create mode 100644 tools/include/drivers/dma/ioat/hw.h
>   create mode 100644 tools/include/drivers/dma/ioat/registers.h
>   create mode 100644 tools/include/linux/pci_ids.h
>   create mode 100644 tools/testing/selftests/kvm/vfio_pci_device_irq_test.c
>   create mode 100644 tools/testing/selftests/vfio/.gitignore
>   create mode 100644 tools/testing/selftests/vfio/Makefile
>   create mode 100644 tools/testing/selftests/vfio/lib/drivers/dsa.c
>   create mode 100644 tools/testing/selftests/vfio/lib/drivers/ioat.c
>   create mode 100644 tools/testing/selftests/vfio/lib/include/vfio_util.h
>   create mode 100644 tools/testing/selftests/vfio/lib/libvfio.mk
>   create mode 100644 tools/testing/selftests/vfio/lib/vfio_pci_device.c
>   create mode 100644 tools/testing/selftests/vfio/lib/vfio_pci_driver.c
>   create mode 100755 tools/testing/selftests/vfio/run.sh
>   create mode 100644 tools/testing/selftests/vfio/vfio_dma_mapping_test.c
>   create mode 100644 tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
>   create mode 100644 tools/testing/selftests/vfio/vfio_pci_device_test.c
>   create mode 100644 tools/testing/selftests/vfio/vfio_pci_driver_test.c
> 
> 
> base-commit: a11a72229881d8ac1d52ea727101bc9c744189c1
> prerequisite-patch-id: 3bae97c9e1093148763235f47a84fa040b512d04


