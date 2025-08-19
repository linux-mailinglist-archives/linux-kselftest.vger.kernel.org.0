Return-Path: <linux-kselftest+bounces-39335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 721ECB2CF11
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 00:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCEDC1899804
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 22:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2FB3FE7;
	Tue, 19 Aug 2025 22:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVzKe/oy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8578E353349;
	Tue, 19 Aug 2025 22:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755641245; cv=none; b=akNESL1K12jkU45p/873PhvTeO/BWO3EG6hEuw9h0x7nmmX+aB1g+dnC9h3VybDKI9S1uvvttmG5d4Rd8Osy0WZ3irPWyrbOAW/uRo7mUG7/zXcG1Ct9gNAeC6QLS7dX/yGGc2PccqCdawhqeSpay3XpPO1z+EJQ08wZBpeFDrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755641245; c=relaxed/simple;
	bh=JQuLWjKxFCVOeoAbJw4Sug+i0kEK+JPaGdGyH+V5Vks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FdojijOidzSbfNnlid6DRDSnAquC7dNAW3DNrp0xuzkKOfmp/4RyS6o2g3lJGgAp08+CbUjwo7lVX1rwBLhxyeoolm3cgScXs5eyrqsLMagU/VpWIZulIqacjxd9k2AVnrDR8Y9lt+fbxXapIxlCK9b+7k//GmG4BhPLIPcErG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WVzKe/oy; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755641243; x=1787177243;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JQuLWjKxFCVOeoAbJw4Sug+i0kEK+JPaGdGyH+V5Vks=;
  b=WVzKe/oy3SipbsSgzeGtlzRfZBQmByLOx6ZUMU3v9dj7nIiDWvC1q/aI
   C7O2ikMcLQEX8GNl0MSet9WOHVJS9mLRwflazVrWi/gaXac9l0vySdZrD
   HKPrsiEODOkjTul8LIiLD/uiFjFqERdqPUeNS5moH8tooI2q09uuojSdZ
   erjY+VHY0CBrsUB6rqrZcEOGQ2s51mjODzMjG9aysDI/rO+b0fROONBuM
   He+DFXhZppXSOFObMmqHAn/PtaQIR6pz0DUvlYF7tYQS9lgwTsp5nOnUT
   yG8QC8TUomZ9EptMapCzEOb+6piKFJVIXJCRfYmW14XAWtJKNm0505SS0
   A==;
X-CSE-ConnectionGUID: EOexQIDBRsqvNec9/5Fvzw==
X-CSE-MsgGUID: LuvtGwLTS9qpljCgAAjlnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57610745"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57610745"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 15:07:22 -0700
X-CSE-ConnectionGUID: pwjsihVrTUWnVg4Yx5K3HA==
X-CSE-MsgGUID: VkfB73g+TCWmrUjwp31NkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="205121805"
Received: from unknown (HELO [10.247.119.200]) ([10.247.119.200])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 15:07:07 -0700
Message-ID: <8ea0c5b5-04ac-44c5-8cf4-2e08fe36a03a@intel.com>
Date: Tue, 19 Aug 2025 15:07:01 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/33] vfio: selftests: Add driver for Intel CBDMA
To: David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Aaron Lewis <aaronlewis@google.com>,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 Adithya Jayachandran <ajayachandra@nvidia.com>,
 Andrew Jones <ajones@ventanamicro.com>, Ard Biesheuvel <ardb@kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
 Huacai Chen <chenhuacai@kernel.org>, James Houghton <jthoughton@google.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>,
 Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 "Pratik R. Sampat" <prsampat@amd.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vipin Sharma <vipinsh@google.com>, Wei Yang <richard.weiyang@gmail.com>,
 "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
References: <20250620232031.2705638-1-dmatlack@google.com>
 <20250620232031.2705638-21-dmatlack@google.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250620232031.2705638-21-dmatlack@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/20/25 4:20 PM, David Matlack wrote:
> Add a driver for the Intel CBDMA device. This driver is based on and
> named after the Linux driver for this device (drivers/dma/ioat/) and
> also based on previous work from Peter Shier <pshier@google.com>.
> 
> The driver aims to be as simple as possible. It uses a single descriptor
> to issue DMA operations, and only supports the copy operation. For "DMA
> storms", the driver kicks off the maximum number of maximum-sized DMA
> operations. On Skylake server parts, this was 2^16-1 copies of size 2M
> and lasts about 15 seconds.
> 
> Create symlinks to drivers/dma/ioat/{hw.h,registers.h} to get access to
> various macros (e.g. IOAT_CHANCMD_RESET) and struct ioat_dma_descriptor.
> 
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  .../selftests/vfio/lib/drivers/ioat/hw.h      |   1 +
>  .../selftests/vfio/lib/drivers/ioat/ioat.c    | 235 ++++++++++++++++++
>  .../vfio/lib/drivers/ioat/registers.h         |   1 +
>  tools/testing/selftests/vfio/lib/libvfio.mk   |   7 +
>  .../selftests/vfio/lib/vfio_pci_driver.c      |  10 +-
>  5 files changed, 253 insertions(+), 1 deletion(-)
>  create mode 120000 tools/testing/selftests/vfio/lib/drivers/ioat/hw.h
>  create mode 100644 tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c
>  create mode 120000 tools/testing/selftests/vfio/lib/drivers/ioat/registers.h
> 
> diff --git a/tools/testing/selftests/vfio/lib/drivers/ioat/hw.h b/tools/testing/selftests/vfio/lib/drivers/ioat/hw.h
> new file mode 120000
> index 000000000000..8ab52ddd4458
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/lib/drivers/ioat/hw.h
> @@ -0,0 +1 @@
> +../../../../../../../drivers/dma/ioat/hw.h
> \ No newline at end of file
> diff --git a/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c b/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c
> new file mode 100644
> index 000000000000..c3b91d9b1f59
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c
> @@ -0,0 +1,235 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <stdint.h>
> +#include <unistd.h>
> +
> +#include <linux/errno.h>
> +#include <linux/io.h>
> +#include <linux/pci_ids.h>
> +#include <linux/sizes.h>
> +
> +#include <vfio_util.h>
> +
> +#include "hw.h"
> +#include "registers.h"
> +
> +#define IOAT_DMACOUNT_MAX UINT16_MAX
> +
> +struct ioat_state {
> +	/* Single descriptor used to issue DMA memcpy operations */
> +	struct ioat_dma_descriptor desc;
> +
> +	/* Copy buffers used by ioat_send_msi() to generate an interrupt. */
> +	u64 send_msi_src;
> +	u64 send_msi_dst;
> +};
> +
> +static inline struct ioat_state *to_ioat_state(struct vfio_pci_device *device)
> +{
> +	return device->driver.region.vaddr;
> +}
> +
> +static inline void *ioat_channel_registers(struct vfio_pci_device *device)
> +{
> +	return device->bars[0].vaddr + IOAT_CHANNEL_MMIO_SIZE;
> +}
> +
> +static int ioat_probe(struct vfio_pci_device *device)
> +{
> +	u8 version;
> +	int r;
> +
> +	if (!vfio_pci_device_match(device, PCI_VENDOR_ID_INTEL,
> +				   PCI_DEVICE_ID_INTEL_IOAT_SKX))
> +		return -EINVAL;
> +
> +	VFIO_ASSERT_NOT_NULL(device->bars[0].vaddr);
> +
> +	version = readb(device->bars[0].vaddr + IOAT_VER_OFFSET);
> +	switch (version) {
> +	case IOAT_VER_3_2:
> +	case IOAT_VER_3_3:
> +		r = 0;
> +		break;
> +	default:
> +		printf("ioat: Unsupported version: 0x%x\n", version);
> +		r = -EINVAL;
> +	}
> +	return r;
> +}
> +
> +static u64 ioat_channel_status(void *bar)
> +{
> +	return readq(bar + IOAT_CHANSTS_OFFSET) & IOAT_CHANSTS_STATUS;
> +}
> +
> +static void ioat_clear_errors(struct vfio_pci_device *device)
> +{
> +	void *registers = ioat_channel_registers(device);
> +	u32 errors;
> +
> +	errors = vfio_pci_config_readl(device, IOAT_PCI_CHANERR_INT_OFFSET);
> +	vfio_pci_config_writel(device, IOAT_PCI_CHANERR_INT_OFFSET, errors);
> +
> +	errors = vfio_pci_config_readl(device, IOAT_PCI_DMAUNCERRSTS_OFFSET);
> +	vfio_pci_config_writel(device, IOAT_PCI_CHANERR_INT_OFFSET, errors);
> +
> +	errors = readl(registers + IOAT_CHANERR_OFFSET);
> +	writel(errors, registers + IOAT_CHANERR_OFFSET);
> +}
> +
> +static void ioat_reset(struct vfio_pci_device *device)
> +{
> +	void *registers = ioat_channel_registers(device);
> +	u32 sleep_ms = 1, attempts = 5000 / sleep_ms;
> +	u8 chancmd;
> +
> +	ioat_clear_errors(device);
> +
> +	writeb(IOAT_CHANCMD_RESET, registers + IOAT2_CHANCMD_OFFSET);
> +
> +	for (;;) {
> +		chancmd = readb(registers + IOAT2_CHANCMD_OFFSET);
> +		if (!(chancmd & IOAT_CHANCMD_RESET))
> +			break;
> +
> +		VFIO_ASSERT_GT(--attempts, 0);
> +		usleep(sleep_ms * 1000);
> +	}
> +
> +	VFIO_ASSERT_EQ(ioat_channel_status(registers), IOAT_CHANSTS_HALTED);
> +}
> +
> +static void ioat_init(struct vfio_pci_device *device)
> +{
> +	struct ioat_state *ioat = to_ioat_state(device);
> +	u8 intrctrl;
> +
> +	VFIO_ASSERT_GE(device->driver.region.size, sizeof(*ioat));
> +
> +	vfio_pci_config_writew(device, PCI_COMMAND,
> +			       PCI_COMMAND_MEMORY |
> +			       PCI_COMMAND_MASTER |
> +			       PCI_COMMAND_INTX_DISABLE);
> +
> +	ioat_reset(device);
> +
> +	/* Enable the use of MXI-x interrupts for channel interrupts. */
> +	intrctrl = IOAT_INTRCTRL_MSIX_VECTOR_CONTROL;
> +	writeb(intrctrl, device->bars[0].vaddr + IOAT_INTRCTRL_OFFSET);
> +
> +	vfio_pci_msix_enable(device, 0, device->msix_info.count);
> +
> +	device->driver.msi = 0;
> +	device->driver.max_memcpy_size =
> +		1UL << readb(device->bars[0].vaddr + IOAT_XFERCAP_OFFSET);
> +	device->driver.max_memcpy_count = IOAT_DMACOUNT_MAX;
> +}
> +
> +static void ioat_remove(struct vfio_pci_device *device)
> +{
> +	ioat_reset(device);
> +	vfio_pci_msix_disable(device);
> +}
> +
> +static void ioat_handle_error(struct vfio_pci_device *device)
> +{
> +	void *registers = ioat_channel_registers(device);
> +
> +	printf("Error detected during memcpy operation!\n"
> +	       "  CHANERR: 0x%x\n"
> +	       "  CHANERR_INT: 0x%x\n"
> +	       "  DMAUNCERRSTS: 0x%x\n",
> +	       readl(registers + IOAT_CHANERR_OFFSET),
> +	       vfio_pci_config_readl(device, IOAT_PCI_CHANERR_INT_OFFSET),
> +	       vfio_pci_config_readl(device, IOAT_PCI_DMAUNCERRSTS_OFFSET));
> +
> +	ioat_reset(device);
> +}
> +
> +static int ioat_memcpy_wait(struct vfio_pci_device *device)
> +{
> +	void *registers = ioat_channel_registers(device);
> +	u64 status;
> +	int r = 0;
> +
> +	/* Wait until all operations complete. */
> +	for (;;) {
> +		status = ioat_channel_status(registers);
> +		if (status == IOAT_CHANSTS_DONE)
> +			break;
> +
> +		if (status == IOAT_CHANSTS_HALTED) {
> +			ioat_handle_error(device);
> +			return -1;
> +		}
> +	}
> +
> +	/* Put the channel into the SUSPENDED state. */
> +	writeb(IOAT_CHANCMD_SUSPEND, registers + IOAT2_CHANCMD_OFFSET);
> +	for (;;) {
> +		status = ioat_channel_status(registers);
> +		if (status == IOAT_CHANSTS_SUSPENDED)
> +			break;
> +	}
> +
> +	return r;
> +}
> +
> +static void __ioat_memcpy_start(struct vfio_pci_device *device,
> +				iova_t src, iova_t dst, u64 size,
> +				u16 count, bool interrupt)
> +{
> +	void *registers = ioat_channel_registers(device);
> +	struct ioat_state *ioat = to_ioat_state(device);
> +	u64 desc_iova;
> +	u16 chanctrl;
> +
> +	desc_iova = to_iova(device, &ioat->desc);
> +	ioat->desc = (struct ioat_dma_descriptor) {
> +		.ctl_f.op = IOAT_OP_COPY,
> +		.ctl_f.int_en = interrupt,
> +		.src_addr = src,
> +		.dst_addr = dst,
> +		.size = size,
> +		.next = desc_iova,
> +	};
> +
> +	/* Tell the device the address of the descriptor. */
> +	writeq(desc_iova, registers + IOAT2_CHAINADDR_OFFSET);
> +
> +	/* (Re)Enable the channel interrupt and abort on any errors */
> +	chanctrl = IOAT_CHANCTRL_INT_REARM | IOAT_CHANCTRL_ANY_ERR_ABORT_EN;
> +	writew(chanctrl, registers + IOAT_CHANCTRL_OFFSET);
> +
> +	/* Kick off @count DMA copy operation(s). */
> +	writew(count, registers + IOAT_CHAN_DMACOUNT_OFFSET);
> +}
> +
> +static void ioat_memcpy_start(struct vfio_pci_device *device,
> +			      iova_t src, iova_t dst, u64 size,
> +			      u64 count)
> +{
> +	__ioat_memcpy_start(device, src, dst, size, count, false);
> +}
> +
> +static void ioat_send_msi(struct vfio_pci_device *device)
> +{
> +	struct ioat_state *ioat = to_ioat_state(device);
> +
> +	__ioat_memcpy_start(device,
> +			    to_iova(device, &ioat->send_msi_src),
> +			    to_iova(device, &ioat->send_msi_dst),
> +			    sizeof(ioat->send_msi_src), 1, true);
> +
> +	VFIO_ASSERT_EQ(ioat_memcpy_wait(device), 0);
> +}
> +
> +const struct vfio_pci_driver_ops ioat_ops = {
> +	.name = "ioat",
> +	.probe = ioat_probe,
> +	.init = ioat_init,
> +	.remove = ioat_remove,
> +	.memcpy_start = ioat_memcpy_start,
> +	.memcpy_wait = ioat_memcpy_wait,
> +	.send_msi = ioat_send_msi,
> +};
> diff --git a/tools/testing/selftests/vfio/lib/drivers/ioat/registers.h b/tools/testing/selftests/vfio/lib/drivers/ioat/registers.h
> new file mode 120000
> index 000000000000..0b809cfd8fe6
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/lib/drivers/ioat/registers.h
> @@ -0,0 +1 @@
> +../../../../../../../drivers/dma/ioat/registers.h
> \ No newline at end of file
> diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testing/selftests/vfio/lib/libvfio.mk
> index a3c3bc9a7c00..624dc267a879 100644
> --- a/tools/testing/selftests/vfio/lib/libvfio.mk
> +++ b/tools/testing/selftests/vfio/lib/libvfio.mk
> @@ -1,8 +1,15 @@
> +include $(top_srcdir)/scripts/subarch.include
> +ARCH ?= $(SUBARCH)
> +
>  VFIO_DIR := $(selfdir)/vfio
>  
>  LIBVFIO_C := lib/vfio_pci_device.c
>  LIBVFIO_C += lib/vfio_pci_driver.c
>  
> +ifeq ($(ARCH:x86_64=x86),x86)
> +LIBVFIO_C += lib/drivers/ioat/ioat.c
> +endif
> +
>  LIBVFIO_O := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBVFIO_C))
>  
>  LIBVFIO_O_DIRS := $(shell dirname $(LIBVFIO_O) | uniq)
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
> index c98bd2d31d8a..aa47360e47a9 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
> @@ -4,7 +4,15 @@
>  #include "../../../kselftest.h"
>  #include <vfio_util.h>
>  
> -static struct vfio_pci_driver_ops *driver_ops[] = {};
> +#ifdef __x86_64__
> +extern struct vfio_pci_driver_ops ioat_ops;
> +#endif
> +
> +static struct vfio_pci_driver_ops *driver_ops[] = {
> +#ifdef __x86_64__
> +	&ioat_ops,
> +#endif
> +};
>  
>  void vfio_pci_driver_probe(struct vfio_pci_device *device)
>  {


