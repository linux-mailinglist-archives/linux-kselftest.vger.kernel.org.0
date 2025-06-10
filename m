Return-Path: <linux-kselftest+bounces-34550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B52A9AD30D9
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 10:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8A63B5A2D
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 08:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9569E280CD0;
	Tue, 10 Jun 2025 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gj4hCYGn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E3927FD5D;
	Tue, 10 Jun 2025 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749545398; cv=none; b=FDleM0prT9sOY1cXM7up/SjYFXYDROOOv+tK51e+x58vmgINkXrRkp5JZ1GBSaFEe7tNDaqozUNwWLs3Cy5E+LqWHPT8iEhGAbg30BXEaK0zBgRrB3fQS3J6wGtAMXly5RLqxI5AGMBuiZombWNQr0ux4FdY9hi/YirynZvVrYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749545398; c=relaxed/simple;
	bh=05nKBPmhSDln95LoleZcXPT1DhzBlqzSDGZFX9Cc3iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NI3hCfKgwLcn6cwf+yvNAKarrvTrvFy8mh+FblACuKeQV54pKrTQXzm163iehIjv/J3EvCeAx5ItYHPJES+abdRxzecFPxPMiowd1IlZSfUKfUhAOfRxJNNxDobtV7/KWOGz2dd2kQXf6CLI+SNdHgXSyoyOGQdUzN6YxOLhr6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gj4hCYGn; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749545396; x=1781081396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=05nKBPmhSDln95LoleZcXPT1DhzBlqzSDGZFX9Cc3iY=;
  b=gj4hCYGnd9AQPql3+E/rKIkQomPNRMc7dqmjMZyKrMcvKAR18agLXpX3
   9DtDghIAWgfyj0K4m9BUWMDQFH51yx7DQsueBPVIqWfyeHcE4G+833/od
   wRQrwPRxggCOa0Z/LQtGxorxDZoo9mqXje3xvXKVIoA8gvb5qxfUI1oOO
   iAfBQKR70Z9y9tDgwF6L5waf2+ADaS8JeghmyfMBIpV8KC7TqKkvX0Z0F
   UNf0P/4VsJ2ZHRcXSh8gNLRDKTiSQDvizfC6wx3dd0JskNMzYehTzT9Rl
   Y5Wmsq8iSL8g7ayfOS4gGe4ajE45kPkxBo7WRCSO2MYZMSaZeahhi5TFF
   w==;
X-CSE-ConnectionGUID: 5fss6OrcR5quWzzASVuSeA==
X-CSE-MsgGUID: 3dZ4IXZ2RmWJLt/ejCbe6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="74179046"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="74179046"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 01:49:55 -0700
X-CSE-ConnectionGUID: bNY5RX6WTIKGt2dW7mgFMg==
X-CSE-MsgGUID: 31Efn+kFQHqN/6fQtRQq2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="147135255"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 10 Jun 2025 01:49:47 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uOufx-0007zx-1l;
	Tue, 10 Jun 2025 08:49:45 +0000
Date: Tue, 10 Jun 2025 16:49:18 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, Kishon Vijay Abraham I <kishon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Niklas Cassel <cassel@kernel.org>,
	dlemoal@kernel.org, jdmason@kudzu.us, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v19 02/10] PCI: endpoint: Add RC-to-EP doorbell support
 using platform MSI controller
Message-ID: <202506101649.UpwblcVd-lkp@intel.com>
References: <20250609-ep-msi-v19-2-77362eaa48fa@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609-ep-msi-v19-2-77362eaa48fa@nxp.com>

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 19272b37aa4f83ca52bdf9c16d5d81bdd1354494]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/PCI-endpoint-Set-ID-and-of_node-for-function-driver/20250610-003848
base:   19272b37aa4f83ca52bdf9c16d5d81bdd1354494
patch link:    https://lore.kernel.org/r/20250609-ep-msi-v19-2-77362eaa48fa%40nxp.com
patch subject: [PATCH v19 02/10] PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20250610/202506101649.UpwblcVd-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250610/202506101649.UpwblcVd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506101649.UpwblcVd-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/wireless/st/cw1200/main.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/net/wireless/st/cw1200/pm.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/net/wireless/ti/wl1251/main.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/net/wireless/ti/wlcore/acx.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/net/wireless/ti/wlcore/cmd.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/net/wireless/ti/wlcore/debugfs.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/net/wireless/ti/wlcore/event.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/net/wireless/ti/wlcore/io.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/net/wireless/ti/wlcore/main.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/net/wireless/ti/wlcore/scan.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/net/wireless/ti/wlcore/tx.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/net/wwan/wwan_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nfc/fdp/fdp.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nfc/mei_phy.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nfc/microread/microread.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nfc/nfcmrvl/main.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nfc/nxp-nci/core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nfc/nxp-nci/firmware.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nfc/pn533/pn533.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nfc/pn544/pn544.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nfc/s3fwrn5/core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nfc/s3fwrn5/phy_common.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nfc/st-nci/core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nfc/st-nci/ndlc.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nfc/st-nci/se.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nfc/st-nci/vendor_cmds.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nfc/st21nfca/core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nfc/st21nfca/dep.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nfc/st21nfca/se.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nfc/st21nfca/vendor_cmds.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nfc/st95hf/spi.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/ntb/core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/ntb/msi.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nubus/bus.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nubus/nubus.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nvdimm/btt.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nvdimm/btt_devs.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nvdimm/bus.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nvdimm/claim.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nvdimm/dax_devs.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nvdimm/dimm_devs.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nvdimm/namespace_devs.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nvdimm/nd_perf.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nvdimm/nd_virtio.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nvdimm/pfn_devs.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nvdimm/region_devs.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nvme/common/auth.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nvme/common/keyring.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nvme/host/auth.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nvme/host/constants.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nvme/host/core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nvme/host/fabrics.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nvme/host/fault_inject.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nvme/host/fc.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nvme/host/multipath.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nvme/host/sysfs.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nvme/target/core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nvme/target/fc.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/nvmem/layouts.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/of/address.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/of/base.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/of/cpu.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/of/device.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/of/dynamic.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/of/fdt.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/of/irq.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/of/module.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/of/of_kunit_helpers.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/of/of_reserved_mem.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/of/overlay.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/of/platform.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/of/property.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/of/resolver.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/parisc/eisa.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/parisc/gsc.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/parisc/iosapic.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/parisc/sba_iommu.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/parport/ieee1284.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/parport/ieee1284_ops.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/parport/parport_pc.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/parport/share.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/access.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/bus.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/controller/cadence/pcie-cadence-ep.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/controller/cadence/pcie-cadence-host.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/controller/cadence/pcie-cadence.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/controller/dwc/pcie-designware-ep.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/controller/dwc/pcie-designware-host.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/controller/dwc/pcie-designware.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/controller/dwc/pcie-qcom-common.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/controller/pci-host-common.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/controller/pci-hyperv-intf.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/controller/pcie-iproc-msi.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/controller/pcie-iproc.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/controller/pcie-rockchip.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/controller/plda/pcie-plda-host.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/devres.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/doe.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/ecam.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/endpoint/pci-ep-cfs.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
>> drivers/pci/endpoint/pci-ep-msi.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/endpoint/pci-epc-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/endpoint/pci-epc-mem.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/endpoint/pci-epf-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/host-bridge.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/hotplug/acpi_pcihp.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/hotplug/acpiphp_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/hotplug/cpci_hotplug_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/hotplug/pci_hotplug_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/hotplug/pnv_php.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/hotplug/rpaphp_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/hotplug/rpaphp_slot.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/msi/irqdomain.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/of.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/p2pdma.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/pci-acpi.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/pci-bridge-emul.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/pci-driver.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/pci.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/pcie/aer.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/pcie/aspm.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/pcie/portdrv.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/pcie/ptm.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/probe.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/remove.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/search.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/setup-bus.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/slot.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/switch/switchtec.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/tph.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pci/vgaarb.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pcmcia/cistpl.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pcmcia/cs.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pcmcia/ds.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pcmcia/max1600.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pcmcia/pcmcia_cis.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pcmcia/pcmcia_resource.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pcmcia/pxa2xx_base.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pcmcia/rsrc_iodyn.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pcmcia/rsrc_mgr.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pcmcia/rsrc_nonstatic.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pcmcia/sa11xx_base.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pcmcia/soc_common.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/peci/cpu.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/peci/device.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/perf/arm_cspmu/arm_cspmu.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/perf/hisilicon/hisi_uncore_pmu.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/perf/riscv_pmu_sbi.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/phy/allwinner/phy-sun4i-usb.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/phy/tegra/xusb-tegra124.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/phy/tegra/xusb-tegra186.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/phy/tegra/xusb-tegra210.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/phy/tegra/xusb.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/phy/ti/phy-omap-control.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/phy/ti/phy-omap-usb2.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pinctrl/devicetree.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pinctrl/freescale/pinctrl-imx.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pinctrl/freescale/pinctrl-scu.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pinctrl/intel/pinctrl-intel.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pinctrl/mediatek/mtk-eint.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pinctrl/mediatek/pinctrl-paris.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pinctrl/meson/pinctrl-meson.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pinctrl/meson/pinctrl-meson8-pmx.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pinctrl/pinconf-generic.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pinctrl/pinmux.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pinctrl/pxa/pinctrl-pxa2xx.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pinctrl/qcom/pinctrl-lpass-lpi.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pinctrl/qcom/pinctrl-msm.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pinctrl/realtek/pinctrl-rtd.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pinctrl/sprd/pinctrl-sprd.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/pinctrl/tegra/pinctrl-tegra-xusb.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/platform/arm64/huawei-gaokun-ec.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/platform/arm64/lenovo-yoga-c630.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/platform/chrome/cros_ec.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/platform/chrome/cros_ec_lpc_mec.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/platform/chrome/cros_ec_proto.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/platform/chrome/cros_ec_sensorhub_ring.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/platform/chrome/cros_usbpd_notify.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/platform/chrome/wilco_ec/mailbox.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/platform/cznic/turris-omnia-mcu-base.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/platform/cznic/turris-signing-key.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/platform/olpc/olpc-ec.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/platform/surface/aggregator/bus.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/platform/surface/aggregator/controller.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/platform/surface/aggregator/core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/platform/surface/aggregator/ssh_packet_layer.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/platform/surface/surface_acpi_notify.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/platform/x86/amd/hsmp/hsmp.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/platform/x86/amd/hsmp/hwmon.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/platform/x86/amd/wbrf.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/platform/x86/asus-wmi.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/platform/x86/dell/dcdbas.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/platform/x86/dell/dell-rbtn.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/platform/x86/dell/dell-smbios-base.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/platform/x86/dell/dell-wmi-descriptor.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/platform/x86/dell/dell-wmi-privacy.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/platform/x86/firmware_attributes_class.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/platform/x86/ideapad-laptop.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

