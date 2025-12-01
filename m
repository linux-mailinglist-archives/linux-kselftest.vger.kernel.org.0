Return-Path: <linux-kselftest+bounces-46811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B085C981A6
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 16:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 440C24E1A5D
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 15:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8546B33291F;
	Mon,  1 Dec 2025 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pbCZG1NE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBEB332EAD
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Dec 2025 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764604211; cv=none; b=SXIlNSQ46nC3N0gdE4ScMgQeKINn2WL3qftcgO2JrGGXid7gkpueJ5wYDHvEBH60/jmRjM5Ho3WwRfrU7OFk6sCl/kUkvXnWGmnCzT4LhIJEISzIwUAkT1TCjOelE1EMowyesmrgmO5BwPdydIgpvzJQQpjFFvJ2zbaA/kKKuVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764604211; c=relaxed/simple;
	bh=v01Qvgga6OXteBWDw+kls9otNx1pMqsvpx7DRGBLwMQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lEqqSRKoL6q2C47+so/0eLO9yqPrHghtAO4wZyhYksreuMn7Idlup8Inq7+7W9nQawibYcK05OHugbHYSuOza2W69sQyy4gLypzAlY1Hg1fbuNKQc7lb7ERUqFyxa1I1JBa9wg22zMIBx8IAcaga3W81SeFkOshF6GBNwzl8PC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pbCZG1NE; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <46bbdad1-486d-4cb1-915f-577b00de827f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764604196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iNdyhBHo3D4OnRy1wZmBFCIJGMu0S5cEULbP0D0MVr8=;
	b=pbCZG1NEEjsbYbkE1CbqudioNGhnvbma1ChEsab4zS+H8FQlOiStnLQb39eH1bDpbZYxiV
	17+7DEo2zCD+nD0KNs/ENeveVXuZyguJPfXwSacm/3fSmBi6WgwAVQ9QKAvG/gCPslQ3cU
	4XcEqh+dxAdNWPXFjLavbNjrgkONm2E=
Date: Mon, 1 Dec 2025 07:49:44 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 00/21] vfio/pci: Base support to preserve a VFIO device
 file across Live Update
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>,
 Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
 David Rientjes <rientjes@google.com>,
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>,
 Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
 Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>,
 Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Philipp Stanner <pstanner@redhat.com>, Pratyush Yadav <pratyush@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>,
 Shuah Khan <shuah@kernel.org>, Tomita Moeko <tomitamoeko@gmail.com>,
 Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>
References: <20251126193608.2678510-1-dmatlack@google.com>
 <dadaeeb9-4008-4450-8b61-e147a2af38b2@linux.dev>
In-Reply-To: <dadaeeb9-4008-4450-8b61-e147a2af38b2@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2025/11/27 20:56, Zhu Yanjun 写道:
> 
> 在 2025/11/26 11:35, David Matlack 写道:
>> This series adds the base support to preserve a VFIO device file across
>> a Live Update. "Base support" means that this allows userspace to
>> safetly preserve a VFIO device file with LIVEUPDATE_SESSION_PRESERVE_FD
>> and retrieve a preserved VFIO device file with
>> LIVEUPDATE_SESSION_RETRIEVE_FD, but the device itself is not preserved
>> in a fully running state across Live Update.
>>
>> This series unblocks 2 parallel but related streams of work:
>>
>>   - iommufd preservation across Live Update. This work spans iommufd,
>>     the IOMMU subsystem, and IOMMU drivers [1]
>>
>>   - Preservation of VFIO device state across Live Update (config space,
>>     BAR addresses, power state, SR-IOV state, etc.). This work spans both
>>     VFIO and the core PCI subsystem.
>>
>> While we need all of the above to fully preserve a VFIO device across a
>> Live Update without disrupting the workload on the device, this series
>> aims to be functional and safe enough to merge as the first incremental
>> step toward that goal.
>>
>> Areas for Discussion
>> --------------------
>>
>> BDF Stability across Live Update
>>
>>    The PCI support for tracking preserved devices across a Live Update to
>>    prevent auto-probing relies on PCI segment numbers and BDFs remaining
>>    stable. For now I have disallowed VFs, as the BDFs assigned to VFs can
>>    vary depending on how the kernel chooses to allocate bus numbers. For
>>    non-VFs I am wondering if there is any more needed to ensure BDF
>>    stability across Live Update.
>>
>>    While we would like to support many different systems and
>>    configurations in due time (including preserving VFs), I'd like to
>>    keep this first serses constrained to simple use-cases.
>>
>> FLB Locking
>>
>>    I don't see a way to properly synchronize pci_flb_finish() with
>>    pci_liveupdate_incoming_is_preserved() since the incoming FLB mutex is
>>    dropped by liveupdate_flb_get_incoming() when it returns the pointer
>>    to the object, and taking pci_flb_incoming_lock in pci_flb_finish()
>>    could result in a deadlock due to reversing the lock ordering.
>>
>> FLB Retrieving
>>
>>    The first patch of this series includes a fix to prevent an FLB from
>>    being retrieved again it is finished. I am wondering if this is the
>>    right approach or if subsystems are expected to stop calling
>>    liveupdate_flb_get_incoming() after an FLB is finished.
>>
>> Testing
>> -------
>>
>> The patches at the end of this series provide comprehensive selftests
>> for the new code added by this series. The selftests have been validated
>> in both a VM environment using a virtio-net PCIe device, and in a
>> baremetal environment on an Intel EMR server with an Intel DSA device.
>>
>> Here is an example of how to run the new selftests:
> 
> Hi, David
> 
> ERROR: modpost: "liveupdate_register_file_handler" [drivers/vfio/pci/ 
> vfio-pci-core.ko] undefined!
> 
> ERROR: modpost: "vfio_pci_ops" [drivers/vfio/pci/vfio-pci-core.ko] 
> undefined!
> ERROR: modpost: "liveupdate_enabled" [drivers/vfio/pci/vfio-pci-core.ko] 
> undefined!
> ERROR: modpost: "liveupdate_unregister_file_handler" [drivers/vfio/pci/ 
> vfio-pci-core.ko] undefined!
> ERROR: modpost: "vfio_device_fops" [drivers/vfio/pci/vfio-pci-core.ko] 
> undefined!
> ERROR: modpost: "vfio_pci_is_intel_display" [drivers/vfio/pci/vfio-pci- 
> core.ko] undefined!
> ERROR: modpost: "vfio_pci_liveupdate_init" [drivers/vfio/pci/vfio- 
> pci.ko] undefined!
> ERROR: modpost: "vfio_pci_liveupdate_cleanup" [drivers/vfio/pci/vfio- 
> pci.ko] undefined!
> make[4]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
> make[3]: *** [Makefile:1960: modpost] Error 2
> 
> After I git clone the source code from the link https://github.com/ 
> dmatlack/linux/tree/liveupdate/vfio/cdev/v1,
> 
> I found the above errors when I built the source code.
> 
> Perhaps the above errors can be solved by EXPORT_SYMBOL.
> 
> But I am not sure if a better solution can solve the above problems or not.

I reviewed this patch series in detail. If I’m understanding it 
correctly, there appears to be a cyclic dependency issue. Specifically, 
some functions in kernel module A depend on kernel module B, while at 
the same time certain functions in module B depend on module A.

I’m not entirely sure whether this constitutes a real problem or if it’s 
intentional design.

Yanjun.Zhu

> 
> Thanks,
> 
> Yanjun.Zhu
> 
>>
>> vfio_pci_liveupdate_uapi_test:
>>
>>    $ tools/testing/selftests/vfio/scripts/setup.sh 0000:00:04.0
>>    $ tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test 
>> 0000:00:04.0
>>    $ tools/testing/selftests/vfio/scripts/cleanup.sh
>>
>> vfio_pci_liveupdate_kexec_test:
>>
>>    $ tools/testing/selftests/vfio/scripts/setup.sh 0000:00:04.0
>>    $ tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test -- 
>> stage 1 0000:00:04.0
>>    $ kexec [...]  # NOTE: distro-dependent
>>
>>    $ tools/testing/selftests/vfio/scripts/setup.sh 0000:00:04.0
>>    $ tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test -- 
>> stage 2 0000:00:04.0
>>    $ tools/testing/selftests/vfio/scripts/cleanup.sh
>>
>> Dependencies
>> ------------
>>
>> This series was constructed on top of several in-flight series and on
>> top of mm-nonmm-unstable [2].
>>
>>    +-- This series
>>    |
>>    +-- [PATCH v2 00/18] vfio: selftests: Support for multi-device tests
>>    |    https://lore.kernel.org/kvm/20251112192232.442761-1- 
>> dmatlack@google.com/
>>    |
>>    +-- [PATCH v3 0/4] vfio: selftests: update DMA mapping tests to use 
>> queried IOVA ranges
>>    |   https://lore.kernel.org/kvm/20251111-iova-ranges- 
>> v3-0-7960244642c5@fb.com/
>>    |
>>    +-- [PATCH v8 0/2] Live Update: File-Lifecycle-Bound (FLB) State
>>    |   https://lore.kernel.org/linux-mm/20251125225006.3722394-1- 
>> pasha.tatashin@soleen.com/
>>    |
>>    +-- [PATCH v8 00/18] Live Update Orchestrator
>>    |   https://lore.kernel.org/linux-mm/20251125165850.3389713-1- 
>> pasha.tatashin@soleen.com/
>>    |
>>
>> To simplify checking out the code, this series can be found on GitHub:
>>
>>    https://github.com/dmatlack/linux/tree/liveupdate/vfio/cdev/v1
>>
>> Changelog
>> ---------
>>
>> v1:
>>   - Rebase series on top of LUOv8 and VFIO selftests improvements
>>   - Drop commits to preserve config space fields across Live Update.
>>     These changes require changes to the PCI layer. For exmaple,
>>     preserving rbars could lead to an inconsistent device state until
>>     device BARs addresses are preserved across Live Update.
>>   - Drop commits to preserve Bus Master Enable on the device. There's no
>>     reason to preserve this until iommufd preservation is fully working.
>>     Furthermore, preserving Bus Master Enable could lead to memory
>>     corruption when the device if the device is bound to the default
>>     identity-map domain after Live Update.
>>   - Drop commits to preserve saved PCI state. This work is not needed
>>     until we are ready to preserve the device's config space, and
>>     requires more thought to make the PCI state data layout ABI-friendly.
>>   - Add support to skip auto-probing devices that are preserved by VFIO
>>     to avoid them getting bound to a different driver by the next kernel.
>>   - Restrict device preservation further (no VFs, no intel-graphics).
>>   - Various refactoring and small edits to improve readability and
>>     eliminate code duplication.
>>
>> rfc: https://lore.kernel.org/kvm/20251018000713.677779-1- 
>> vipinsh@google.com/
>>
>> Cc: Saeed Mahameed <saeedm@nvidia.com>
>> Cc: Adithya Jayachandran <ajayachandra@nvidia.com>
>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>> Cc: Parav Pandit <parav@nvidia.com>
>> Cc: Leon Romanovsky <leonro@nvidia.com>
>> Cc: William Tu <witu@nvidia.com>
>> Cc: Jacob Pan <jacob.pan@linux.microsoft.com>
>> Cc: Lukas Wunner <lukas@wunner.de>
>> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
>> Cc: Mike Rapoport <rppt@kernel.org>
>> Cc: Pratyush Yadav <pratyush@kernel.org>
>> Cc: Samiullah Khawaja <skhawaja@google.com>
>> Cc: Chris Li <chrisl@kernel.org>
>> Cc: Josh Hilke <jrhilke@google.com>
>> Cc: David Rientjes <rientjes@google.com>
>>
>> [1] https://lore.kernel.org/linux-iommu/20250928190624.3735830-1- 
>> skhawaja@google.com/
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/? 
>> h=mm-nonmm-unstable
>>
>> David Matlack (12):
>>    liveupdate: luo_flb: Prevent retrieve() after finish()
>>    PCI: Add API to track PCI devices preserved across Live Update
>>    PCI: Require driver_override for incoming Live Update preserved
>>      devices
>>    vfio/pci: Notify PCI subsystem about devices preserved across Live
>>      Update
>>    vfio: Enforce preserved devices are retrieved via
>>      LIVEUPDATE_SESSION_RETRIEVE_FD
>>    vfio/pci: Store Live Update state in struct vfio_pci_core_device
>>    vfio: selftests: Add Makefile support for TEST_GEN_PROGS_EXTENDED
>>    vfio: selftests: Add vfio_pci_liveupdate_uapi_test
>>    vfio: selftests: Expose iommu_modes to tests
>>    vfio: selftests: Expose low-level helper routines for setting up
>>      struct vfio_pci_device
>>    vfio: selftests: Verify that opening VFIO device fails during Live
>>      Update
>>    vfio: selftests: Add continuous DMA to vfio_pci_liveupdate_kexec_test
>>
>> Vipin Sharma (9):
>>    vfio/pci: Register a file handler with Live Update Orchestrator
>>    vfio/pci: Preserve vfio-pci device files across Live Update
>>    vfio/pci: Retrieve preserved device files after Live Update
>>    vfio/pci: Skip reset of preserved device after Live Update
>>    selftests/liveupdate: Move luo_test_utils.* into a reusable library
>>    selftests/liveupdate: Add helpers to preserve/retrieve FDs
>>    vfio: selftests: Build liveupdate library in VFIO selftests
>>    vfio: selftests: Initialize vfio_pci_device using a VFIO cdev FD
>>    vfio: selftests: Add vfio_pci_liveupdate_kexec_test
>>
>>   MAINTAINERS                                   |   1 +
>>   drivers/pci/Makefile                          |   1 +
>>   drivers/pci/liveupdate.c                      | 248 ++++++++++++++++
>>   drivers/pci/pci-driver.c                      |  12 +-
>>   drivers/vfio/device_cdev.c                    |  25 +-
>>   drivers/vfio/group.c                          |   9 +
>>   drivers/vfio/pci/Makefile                     |   1 +
>>   drivers/vfio/pci/vfio_pci.c                   |  11 +-
>>   drivers/vfio/pci/vfio_pci_core.c              |  23 +-
>>   drivers/vfio/pci/vfio_pci_liveupdate.c        | 278 ++++++++++++++++++
>>   drivers/vfio/pci/vfio_pci_priv.h              |  16 +
>>   drivers/vfio/vfio.h                           |  13 -
>>   drivers/vfio/vfio_main.c                      |  22 +-
>>   include/linux/kho/abi/pci.h                   |  53 ++++
>>   include/linux/kho/abi/vfio_pci.h              |  45 +++
>>   include/linux/liveupdate.h                    |   3 +
>>   include/linux/pci.h                           |  38 +++
>>   include/linux/vfio.h                          |  51 ++++
>>   include/linux/vfio_pci_core.h                 |   7 +
>>   kernel/liveupdate/luo_flb.c                   |   4 +
>>   tools/testing/selftests/liveupdate/.gitignore |   1 +
>>   tools/testing/selftests/liveupdate/Makefile   |  14 +-
>>   .../include/libliveupdate.h}                  |  11 +-
>>   .../selftests/liveupdate/lib/libliveupdate.mk |  20 ++
>>   .../{luo_test_utils.c => lib/liveupdate.c}    |  43 ++-
>>   .../selftests/liveupdate/luo_kexec_simple.c   |   2 +-
>>   .../selftests/liveupdate/luo_multi_session.c  |   2 +-
>>   tools/testing/selftests/vfio/Makefile         |  23 +-
>>   .../vfio/lib/include/libvfio/iommu.h          |   2 +
>>   .../lib/include/libvfio/vfio_pci_device.h     |   8 +
>>   tools/testing/selftests/vfio/lib/iommu.c      |   4 +-
>>   .../selftests/vfio/lib/vfio_pci_device.c      |  60 +++-
>>   .../vfio/vfio_pci_liveupdate_kexec_test.c     | 255 ++++++++++++++++
>>   .../vfio/vfio_pci_liveupdate_uapi_test.c      |  93 ++++++
>>   34 files changed, 1313 insertions(+), 86 deletions(-)
>>   create mode 100644 drivers/pci/liveupdate.c
>>   create mode 100644 drivers/vfio/pci/vfio_pci_liveupdate.c
>>   create mode 100644 include/linux/kho/abi/pci.h
>>   create mode 100644 include/linux/kho/abi/vfio_pci.h
>>   rename tools/testing/selftests/liveupdate/{luo_test_utils.h => lib/ 
>> include/libliveupdate.h} (80%)
>>   create mode 100644 tools/testing/selftests/liveupdate/lib/ 
>> libliveupdate.mk
>>   rename tools/testing/selftests/liveupdate/{luo_test_utils.c => lib/ 
>> liveupdate.c} (89%)
>>   create mode 100644 tools/testing/selftests/vfio/ 
>> vfio_pci_liveupdate_kexec_test.c
>>   create mode 100644 tools/testing/selftests/vfio/ 
>> vfio_pci_liveupdate_uapi_test.c
>>

-- 
Best Regards,
Yanjun.Zhu


