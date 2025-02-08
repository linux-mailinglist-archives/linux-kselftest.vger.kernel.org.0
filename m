Return-Path: <linux-kselftest+bounces-26105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46055A2D6CA
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 16:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F0A3A3336
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 15:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE242500BC;
	Sat,  8 Feb 2025 15:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TOvrOR9C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287CD2500A4;
	Sat,  8 Feb 2025 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739026878; cv=none; b=GO7Nv2YbVBBBWA3tEAwjCrjXyTb/zrOPlcRvBNLhnwe04CrZN77gmYMV31b8ox/2ut6Drwx4prZTY8x/n4TRMGSpMpPJH8E0qMbNqt1PwIl1oXU1Ll13jJ4Vkm21/DxE8nM5FnzQ94x7fF0/mY7UW98w5AuT2LTvVneXbSzOVZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739026878; c=relaxed/simple;
	bh=oE+gp+Gkz95T/V3xgiAIKokUUM1ToOZwtq4ssSOD7/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hW6k/F5IVbnwr2X6I/c7UBFYgCHDbYvXj0hf8IWPtbxTZ48QWVgkbg50s2JPV76l4E8WQ31jNxMQ693+Txnb3JbGbgVtlEMJuhFMRrol+MpzeI+ICczob8j6Gl3imMUIWtk8HaN7kitJXaeAxrL/WfqWY8Solw4h7hZYMjS1okc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TOvrOR9C; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739026878; x=1770562878;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oE+gp+Gkz95T/V3xgiAIKokUUM1ToOZwtq4ssSOD7/I=;
  b=TOvrOR9C+X/7Miz3A/chE382dD9UGSeHWPwLLHnLD8EEYHWZgXR+LZXt
   ZZK48FEVpmj0zg9MwdxRjm7tMfd3Y2q+h5hHrmwYCp92zbHMeKwU37G7K
   Ax9CpxQSvLCbTdAcdc78RsVcKospNPEWi2HvJYZQOXhHYcxZyer9Sc4nl
   obHnrU4S+MW7Zu8+6I89eLga98RFtHhyfYwl23vbp80FODWvYoiL9EsOn
   4Ny2XbYZumuE7McKsL4OJYq1nEv92uljMz4Dtd5jIck8aAY6pnSs4jhAV
   kebeWimLKV5eZOvmPD466MwKKPK+du8eBQyVXxSWmdHxQe+BjU1wn8h3u
   Q==;
X-CSE-ConnectionGUID: KFdI8aKYQ0ij2FapwZCThQ==
X-CSE-MsgGUID: 9oouo3dsT0uYX96shcGbwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11339"; a="43420848"
X-IronPort-AV: E=Sophos;i="6.13,270,1732608000"; 
   d="scan'208";a="43420848"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2025 07:01:17 -0800
X-CSE-ConnectionGUID: ygCPJfQNTd2FTQwdEqLvbw==
X-CSE-MsgGUID: htZzMBuzSS+sXX7/Kz/DBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="116726461"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 08 Feb 2025 07:01:09 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tgmKQ-001099-1a;
	Sat, 08 Feb 2025 15:01:06 +0000
Date: Sat, 8 Feb 2025 23:00:56 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, Kishon Vijay Abraham I <kishon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
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
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Niklas Cassel <cassel@kernel.org>,
	dlemoal@kernel.org, jdmason@kudzu.us, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v14 07/15] PCI: endpoint: pci-ep-msi: Add MSI
 address/data pair mutable check
Message-ID: <202502082242.pOq1hB1d-lkp@intel.com>
References: <20250207-ep-msi-v14-7-9671b136f2b8@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-ep-msi-v14-7-9671b136f2b8@nxp.com>

Hi Frank,

kernel test robot noticed the following build errors:

[auto build test ERROR on 00f3246adeeacbda0bd0b303604e46eb59c32e6e]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/platform-msi-Add-msi_remove_device_irq_domain-in-platform_device_msi_free_irqs_all/20250208-034445
base:   00f3246adeeacbda0bd0b303604e46eb59c32e6e
patch link:    https://lore.kernel.org/r/20250207-ep-msi-v14-7-9671b136f2b8%40nxp.com
patch subject: [PATCH v14 07/15] PCI: endpoint: pci-ep-msi: Add MSI address/data pair mutable check
config: i386-buildonly-randconfig-003-20250208 (https://download.01.org/0day-ci/archive/20250208/202502082242.pOq1hB1d-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250208/202502082242.pOq1hB1d-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502082242.pOq1hB1d-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/endpoint/pci-ep-msi.c: In function 'pci_epf_alloc_doorbell':
>> drivers/pci/endpoint/pci-ep-msi.c:49:14: error: implicit declaration of function 'irq_domain_is_msi_immutable'; did you mean 'irq_domain_is_msi_device'? [-Werror=implicit-function-declaration]
      49 |         if (!irq_domain_is_msi_immutable(dom)) {
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |              irq_domain_is_msi_device
   drivers/pci/endpoint/pci-ep-msi.c:61:15: error: implicit declaration of function 'platform_device_msi_init_and_alloc_irqs' [-Werror=implicit-function-declaration]
      61 |         ret = platform_device_msi_init_and_alloc_irqs(&epf->dev, num_db, pci_epf_write_msi_msg);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/endpoint/pci-ep-msi.c: In function 'pci_epf_free_doorbell':
   drivers/pci/endpoint/pci-ep-msi.c:83:9: error: implicit declaration of function 'platform_device_msi_free_irqs_all' [-Werror=implicit-function-declaration]
      83 |         platform_device_msi_free_irqs_all(&epf->dev);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +49 drivers/pci/endpoint/pci-ep-msi.c

    26	
    27	int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
    28	{
    29		struct pci_epc *epc = epf->epc;
    30		struct device *dev = &epf->dev;
    31		struct irq_domain *dom;
    32		void *msg;
    33		u32 rid;
    34		int ret;
    35		int i;
    36	
    37		rid = PCI_EPF_DEVID(epf->func_no, epf->vfunc_no);
    38		dom = of_msi_map_get_device_domain(epc->dev.parent, rid, DOMAIN_BUS_PLATFORM_MSI);
    39		if (!dom) {
    40			dev_err(dev, "Can't find msi domain\n");
    41			return -EINVAL;
    42		}
    43	
    44		dev_set_msi_domain(dev, dom);
    45	
    46		if (!irq_domain_is_msi_parent(dom))
    47			return -EINVAL;
    48	
  > 49		if (!irq_domain_is_msi_immutable(dom)) {
    50			dev_err(dev, "Can't support mutable address/data pair MSI controller\n");
    51			return -EINVAL;
    52		}
    53	
    54		msg = kcalloc(num_db, sizeof(struct pci_epf_doorbell_msg), GFP_KERNEL);
    55		if (!msg)
    56			return -ENOMEM;
    57	
    58		epf->num_db = num_db;
    59		epf->db_msg = msg;
    60	
    61		ret = platform_device_msi_init_and_alloc_irqs(&epf->dev, num_db, pci_epf_write_msi_msg);
    62		if (ret) {
    63			/*
    64			 * The pcie_ep DT node has to specify 'msi-parent' for EP
    65			 * doorbell support to work. Right now only GIC ITS is
    66			 * supported. If you have GIC ITS and reached this print,
    67			 * perhaps you are missing 'msi-map' in DT.
    68			 */
    69			dev_err(dev, "Failed to allocate MSI\n");
    70			kfree(msg);
    71			return -ENOMEM;
    72		}
    73	
    74		for (i = 0; i < num_db; i++)
    75			epf->db_msg[i].virq = msi_get_virq(dev, i);
    76	
    77		return ret;
    78	}
    79	EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
    80	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

