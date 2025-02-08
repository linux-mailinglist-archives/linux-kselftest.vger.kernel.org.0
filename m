Return-Path: <linux-kselftest+bounces-26104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2366A2D692
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 15:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66BA41662D7
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 14:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F5524634C;
	Sat,  8 Feb 2025 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbUq05oo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549FA20328;
	Sat,  8 Feb 2025 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739024293; cv=none; b=Z8RdPYz3cbqheYE+NnVz62gi4CbtEUE9CG//yYtnyZysXlQzZlt8rtFth3VdJ+vD4mbgtWy7qGI8iqqNyw2TOSPXj3nwjkWnhFcmB/QMWg42liUXtgMSrgRVXMRzLpdaPrAI2Ko5maTobCjODJ8Cnf/tHyyQ25Ls+kw1nUiAMAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739024293; c=relaxed/simple;
	bh=VPpd2YYWjZluEJs9Qvp1Y2nnNlnf0rQUcWOQWnGi/4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i03lqfHqxa2U5v3DTwrs3wNY4J8bOynkIVdsm3iuJ18vNUgpZNz4aEaZkO/sKJPscsbKjHVmghsf88pe+ftq4QEXfoNM9TfXQnQ+CEwFPGjJ8UXZl6t/mnH7VHLLGcVEmaPXxJvd9z98Wd2CAjN7gWPHwX7ca8Q6lTORX6Y99C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nbUq05oo; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739024290; x=1770560290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VPpd2YYWjZluEJs9Qvp1Y2nnNlnf0rQUcWOQWnGi/4E=;
  b=nbUq05oojgR1cH6uSddvh9ZyyMCKHie15sZ2GCfGEI2YVksj3CQGGbhu
   7ZDBThtyfUoXmYYzfAFF9ZO0Wz7ZdvFCyu7eOfwsS5WwwkSirATBWqAAN
   ABTC0rshmo89U/owjU9pnfT7qvDb7SNU4qm+TJQ+ix4kC2Lhqixaw5Ckn
   cEOPXOAIiGnSusTeZw4yFlZOvpzfb86woGCBPSmNvn6fQ7YP1DceIUqQQ
   kEXtJ+S4JYYVflUi5mJmDWapudmBvDogP8ZaPMXOUNeqPE2iQ+s7GQeqN
   K27yV70aoEOWbtbmt8xBzgCBFKSAGbF9+XQLo1UhKLoc9GfGfEfHmkXmb
   Q==;
X-CSE-ConnectionGUID: a6VuQ+ByRuuuJDqOZiBVkA==
X-CSE-MsgGUID: J7dVg1nETcKi0ErbuifjJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11339"; a="51044191"
X-IronPort-AV: E=Sophos;i="6.13,270,1732608000"; 
   d="scan'208";a="51044191"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2025 06:18:10 -0800
X-CSE-ConnectionGUID: 5SCY/wYtTf2L5TycPuB0vA==
X-CSE-MsgGUID: 0P956+EpRVirLOVEYoefGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,270,1732608000"; 
   d="scan'208";a="116788686"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 08 Feb 2025 06:18:03 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tglei-00103D-12;
	Sat, 08 Feb 2025 14:18:00 +0000
Date: Sat, 8 Feb 2025 22:17:50 +0800
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
Subject: Re: [PATCH v14 06/15] PCI: endpoint: Add RC-to-EP doorbell support
 using platform MSI controller
Message-ID: <202502082204.6PRR3cfG-lkp@intel.com>
References: <20250207-ep-msi-v14-6-9671b136f2b8@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-ep-msi-v14-6-9671b136f2b8@nxp.com>

Hi Frank,

kernel test robot noticed the following build errors:

[auto build test ERROR on 00f3246adeeacbda0bd0b303604e46eb59c32e6e]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/platform-msi-Add-msi_remove_device_irq_domain-in-platform_device_msi_free_irqs_all/20250208-034445
base:   00f3246adeeacbda0bd0b303604e46eb59c32e6e
patch link:    https://lore.kernel.org/r/20250207-ep-msi-v14-6-9671b136f2b8%40nxp.com
patch subject: [PATCH v14 06/15] PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller
config: i386-buildonly-randconfig-003-20250208 (https://download.01.org/0day-ci/archive/20250208/202502082204.6PRR3cfG-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250208/202502082204.6PRR3cfG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502082204.6PRR3cfG-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/endpoint/pci-ep-msi.c: In function 'pci_epf_alloc_doorbell':
>> drivers/pci/endpoint/pci-ep-msi.c:53:15: error: implicit declaration of function 'platform_device_msi_init_and_alloc_irqs' [-Werror=implicit-function-declaration]
      53 |         ret = platform_device_msi_init_and_alloc_irqs(&epf->dev, num_db, pci_epf_write_msi_msg);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/endpoint/pci-ep-msi.c: In function 'pci_epf_free_doorbell':
>> drivers/pci/endpoint/pci-ep-msi.c:75:9: error: implicit declaration of function 'platform_device_msi_free_irqs_all' [-Werror=implicit-function-declaration]
      75 |         platform_device_msi_free_irqs_all(&epf->dev);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/platform_device_msi_init_and_alloc_irqs +53 drivers/pci/endpoint/pci-ep-msi.c

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
    46		msg = kcalloc(num_db, sizeof(struct pci_epf_doorbell_msg), GFP_KERNEL);
    47		if (!msg)
    48			return -ENOMEM;
    49	
    50		epf->num_db = num_db;
    51		epf->db_msg = msg;
    52	
  > 53		ret = platform_device_msi_init_and_alloc_irqs(&epf->dev, num_db, pci_epf_write_msi_msg);
    54		if (ret) {
    55			/*
    56			 * The pcie_ep DT node has to specify 'msi-parent' for EP
    57			 * doorbell support to work. Right now only GIC ITS is
    58			 * supported. If you have GIC ITS and reached this print,
    59			 * perhaps you are missing 'msi-map' in DT.
    60			 */
    61			dev_err(dev, "Failed to allocate MSI\n");
    62			kfree(msg);
    63			return -ENOMEM;
    64		}
    65	
    66		for (i = 0; i < num_db; i++)
    67			epf->db_msg[i].virq = msi_get_virq(dev, i);
    68	
    69		return ret;
    70	}
    71	EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
    72	
    73	void pci_epf_free_doorbell(struct pci_epf *epf)
    74	{
  > 75		platform_device_msi_free_irqs_all(&epf->dev);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

