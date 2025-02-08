Return-Path: <linux-kselftest+bounces-26106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAF5A2D6F9
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 16:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBAE31886CA2
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 15:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76AB2594AA;
	Sat,  8 Feb 2025 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KiuCzYsr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12E32594A4;
	Sat,  8 Feb 2025 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739029464; cv=none; b=tXbNDjBdPl9ZwrFnlzbJencDzca/ekFYPxtPD9nRUT5h13B853nUKbooAHcnuMr6+dE4p1PG802nGuc4e65NBnTmM2cd3l43CNBz3BuL6TJFNt98FB2jo+MzrAUK2QaDPTmzfq3SsADFx9+4XURQuPPuQOF7zsvJW+gGuGqzAoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739029464; c=relaxed/simple;
	bh=vedQ/xlv/QU000yE0skGWbHGRgwRxdG2Fa5jS6xm4JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsYpeVL+IyavMxIs0kYb04W/3E0sYgujaJlEYNbkJF/TebK+b8BQ2OcyA3sH57Qq5kXKva+NZVcvDLQSE3ZuM6KB3hcFdXN+Q8IHvB6jGu3yuYOSyrpoZLDKDsGnsLLDrLXtpKFoJi0+kuZoTcOZx8/xifdBhF+id+I73A8HMRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KiuCzYsr; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739029463; x=1770565463;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vedQ/xlv/QU000yE0skGWbHGRgwRxdG2Fa5jS6xm4JQ=;
  b=KiuCzYsrjT09V/wzh8pMNCClGs9cbjCGjaYONdvI6maEgepoJ60TvzzK
   uarrEDLic1xIOUndaCYOkbbFxBjNc2MWr2kzE+MGbiULhccIfW7GAQAIy
   Whp4KKJPUXbfAyJVLHDfwQSkTwTG2c+8H95BLlUhKjF49hNsMd0jbQPlz
   73gAyFRYFch+BH+JqR+N6d9kmfY49nE7H8zzUwXqCvrcs0kQKhHEs58JE
   kogYy8m61CS8Pz/FXFLpOqSc0QBZ3Ng8fGOPbZZqJC3NUDdRm0KEQrm2h
   xM4KJbCjluWeq7PJSFWvx8D9ZugOd1f39GBa666hL+ZQcXS9HqWpTKigt
   w==;
X-CSE-ConnectionGUID: AupWIZUnRJOC8K1Ejqyi7g==
X-CSE-MsgGUID: /TlZXJjRSH6Mv+Eb4qqJGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11339"; a="50285396"
X-IronPort-AV: E=Sophos;i="6.13,270,1732608000"; 
   d="scan'208";a="50285396"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2025 07:44:22 -0800
X-CSE-ConnectionGUID: klnNFTy8QHC7aXzvmp2Vfg==
X-CSE-MsgGUID: NYgnIkmqSGaduiX5X8UORA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112682427"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 08 Feb 2025 07:44:14 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tgn08-0010Dv-20;
	Sat, 08 Feb 2025 15:44:12 +0000
Date: Sat, 8 Feb 2025 23:43:26 +0800
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
Subject: Re: [PATCH v14 09/15] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Message-ID: <202502082311.G1hWGggF-lkp@intel.com>
References: <20250207-ep-msi-v14-9-9671b136f2b8@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-ep-msi-v14-9-9671b136f2b8@nxp.com>

Hi Frank,

kernel test robot noticed the following build errors:

[auto build test ERROR on 00f3246adeeacbda0bd0b303604e46eb59c32e6e]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/platform-msi-Add-msi_remove_device_irq_domain-in-platform_device_msi_free_irqs_all/20250208-034445
base:   00f3246adeeacbda0bd0b303604e46eb59c32e6e
patch link:    https://lore.kernel.org/r/20250207-ep-msi-v14-9-9671b136f2b8%40nxp.com
patch subject: [PATCH v14 09/15] PCI: endpoint: pci-epf-test: Add doorbell test support
config: i386-buildonly-randconfig-003-20250208 (https://download.01.org/0day-ci/archive/20250208/202502082311.G1hWGggF-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250208/202502082311.G1hWGggF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502082311.G1hWGggF-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/endpoint/functions/pci-epf-test.c: In function 'pci_epf_test_enable_doorbell':
>> drivers/pci/endpoint/functions/pci-epf-test.c:726:42: error: passing argument 4 of 'pci_epf_align_inbound_addr' from incompatible pointer type [-Werror=incompatible-pointer-types]
     726 |                                          &epf_test->db_bar.phys_addr, &offset);
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                          |
         |                                          dma_addr_t * {aka unsigned int *}
   In file included from include/linux/pci-epc.h:12,
                    from drivers/pci/endpoint/functions/pci-epf-test.c:19:
   include/linux/pci-epf.h:245:47: note: expected 'u64 *' {aka 'long long unsigned int *'} but argument is of type 'dma_addr_t *' {aka 'unsigned int *'}
     245 |                                u64 addr, u64 *base, size_t *off);
         |                                          ~~~~~^~~~
   cc1: some warnings being treated as errors


vim +/pci_epf_align_inbound_addr +726 drivers/pci/endpoint/functions/pci-epf-test.c

   686	
   687	static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
   688						 struct pci_epf_test_reg *reg)
   689	{
   690		struct pci_epf *epf = epf_test->epf;
   691		struct pci_epc *epc = epf->epc;
   692		struct msi_msg *msg;
   693		enum pci_barno bar;
   694		size_t offset;
   695		int ret;
   696	
   697		ret = pci_epf_alloc_doorbell(epf, 1);
   698		if (ret) {
   699			reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
   700			return;
   701		}
   702	
   703		msg = &epf->db_msg[0].msg;
   704		bar = pci_epc_get_next_free_bar(epf_test->epc_features, epf_test->test_reg_bar + 1);
   705		if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
   706			reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
   707			return;
   708		}
   709	
   710		ret = request_irq(epf->db_msg[0].virq, pci_epf_test_doorbell_handler, 0,
   711				  "pci-test-doorbell", epf_test);
   712		if (ret) {
   713			dev_err(&epf->dev,
   714				"Failed to request irq %d, doorbell feature is not supported\n",
   715				epf->db_msg[0].virq);
   716			reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
   717			pci_epf_test_doorbell_cleanup(epf_test);
   718			return;
   719		}
   720	
   721		reg->doorbell_data = msg->data;
   722		reg->doorbell_bar = bar;
   723	
   724		msg = &epf->db_msg[0].msg;
   725		ret = pci_epf_align_inbound_addr(epf, bar, ((u64)msg->address_hi << 32) | msg->address_lo,
 > 726						 &epf_test->db_bar.phys_addr, &offset);
   727	
   728		if (ret) {
   729			reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
   730			pci_epf_test_doorbell_cleanup(epf_test);
   731			return;
   732		}
   733	
   734		reg->doorbell_offset = offset;
   735	
   736		epf_test->db_bar.barno = bar;
   737		epf_test->db_bar.size = epf->bar[bar].size;
   738		epf_test->db_bar.flags = epf->bar[bar].flags;
   739	
   740		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
   741		if (ret) {
   742			reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
   743			pci_epf_test_doorbell_cleanup(epf_test);
   744		} else {
   745			reg->status |= STATUS_DOORBELL_ENABLE_SUCCESS;
   746		}
   747	}
   748	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

