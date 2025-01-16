Return-Path: <linux-kselftest+bounces-24656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 042DEA13DC8
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 16:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB5023A4C2F
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 15:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505CE22B8CA;
	Thu, 16 Jan 2025 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odykmPMC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2271DDC12;
	Thu, 16 Jan 2025 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041773; cv=none; b=JWHhK3d+R1pA9IJi8y4jaLCwcYiRiGxU1NutX81W0hZ0BFvpf25SR4jTw045+M/0+xy+dIfYlSdLakNLTv/pir/8lTBILnJJMAg1Bx50U5IjlUFdDHWB/fewr28o7Am9Rj+TJVP98WJd6eyiLfr7rkF8y0wDXnGRX42WvHHsaOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041773; c=relaxed/simple;
	bh=7N79UBDvgcTC7QrrMOnIOEMv6qZdPgkb9CZA0bY1kpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0cWk8wzUyGJx/YkTYJKDObI6HXXlJQd5cbGkkJR75DVDYefXVsOOXksJM5LDMzuDcMIQTTrkmFiM1Dd3KKSIDr0i+LqgBdqY2HBra2czEtWkEMf0nSmSuCcSEH4i4sNmAMAIbpEpU8G3Zw7xesLB5tdgdTSlz+oUyvP1hI6vUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odykmPMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00DEC4CEE1;
	Thu, 16 Jan 2025 15:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737041772;
	bh=7N79UBDvgcTC7QrrMOnIOEMv6qZdPgkb9CZA0bY1kpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=odykmPMCVEDiTbV8Lfu84acuDiIWCEa41eaDl24kDvuwtDSp/Vz8/UEXi/9nlDXtC
	 vjR1ZjJiEHL0+KZSisRJYjuyPAFrDrWh9Vm5BhjXL62eNUJArsy50oWcBwEr/tk2cv
	 s/KcBshIcUaJNayDJLhO6mq8afYy5qY0G8KaWTkRSs9jLdufNDYyoC8ec9+toIiiSe
	 AgBhhfGqqunlcEWd5ON2Z2oysd4npZv1Q/3MedGZluYchlrTcX8DA04XwOc6NUCfzb
	 +d0pJ+V9dHsIF9N754al5tuFu/2N4cOJdbfAET3nLFs6KsyGFn9oFhTkISGTtBMUVl
	 Yj2gMCJ/LPrvg==
Date: Thu, 16 Jan 2025 16:36:07 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de,
	lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 0/4] Migrate PCI Endpoint Subsystem tests to Kselftest
Message-ID: <Z4knZyKrEvVNopeX@ryzen>
References: <20250116135106.19143-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116135106.19143-1-manivannan.sadhasivam@linaro.org>

On Thu, Jan 16, 2025 at 07:21:02PM +0530, Manivannan Sadhasivam wrote:
> Hi,
> 
> This series carries forward the effort to add Kselftest for PCI Endpoint
> Subsystem started by Aman Gupta [1] a while ago. I reworked the initial version
> based on another patch that fixes the return values of IOCTLs in
> pci_endpoint_test driver and did many cleanups. Since the resulting work
> modified the initial version substantially, I took over the authorship.
> 
> This series also incorporates the review comment by Shuah Khan [2] to move the
> existing tests from 'tools/pci' to 'tools/testing/kselftest/pci_endpoint' before
> migrating to Kselftest framework. I made sure that the tests are executable in
> each commit and updated documentation accordingly.
> 
> - Mani
> 
> [1] https://lore.kernel.org/linux-pci/20221007053934.5188-1-aman1.gupta@samsung.com
> [2] https://lore.kernel.org/linux-pci/b2a5db97-dc59-33ab-71cd-f591e0b1b34d@linuxfoundation.org
> 
> Changes in v5:
> 
> * Incorporated comments from Niklas
> * Added a patch to fix the DMA MEMCPY check in pci-epf-test driver
> * Collected tags
> * Rebased on top of pci/next 0333f56dbbf7ef6bb46d2906766c3e1b2a04a94d
> 
> Changes in v4:
> 
> * Dropped the BAR fix patches and submitted them separately:
>   https://lore.kernel.org/linux-pci/20241231130224.38206-1-manivannan.sadhasivam@linaro.org/
> * Rebased on top of pci/next 9e1b45d7a5bc0ad20f6b5267992da422884b916e
> 
> Changes in v3:
> 
> * Collected tags.
> * Added a note about failing testcase 10 and command to skip it in
>   documentation.
> * Removed Aman Gupta and Padmanabhan Rajanbabu from CC as their addresses are
>   bouncing.
> 
> Changes in v2:
> 
> * Added a patch that fixes return values of IOCTL in pci_endpoint_test driver
> * Moved the existing tests to new location before migrating
> * Added a fix for BARs on Qcom devices
> * Updated documentation and also added fixture variants for memcpy & DMA modes
> 
> 
> Manivannan Sadhasivam (4):
>   PCI: endpoint: pci-epf-test: Fix the check for DMA MEMCPY test
>   misc: pci_endpoint_test: Fix the return value of IOCTL
>   selftests: Move PCI Endpoint tests from tools/pci to Kselftests
>   selftests: pci_endpoint: Migrate to Kselftest framework
> 
>  Documentation/PCI/endpoint/pci-test-howto.rst | 170 +++++------
>  MAINTAINERS                                   |   2 +-
>  drivers/misc/pci_endpoint_test.c              | 255 +++++++++--------
>  drivers/pci/endpoint/functions/pci-epf-test.c |   4 +-
>  tools/pci/Build                               |   1 -
>  tools/pci/Makefile                            |  58 ----
>  tools/pci/pcitest.c                           | 264 ------------------
>  tools/pci/pcitest.sh                          |  73 -----
>  tools/testing/selftests/Makefile              |   1 +
>  .../testing/selftests/pci_endpoint/.gitignore |   2 +
>  tools/testing/selftests/pci_endpoint/Makefile |   7 +
>  tools/testing/selftests/pci_endpoint/config   |   4 +
>  .../pci_endpoint/pci_endpoint_test.c          | 221 +++++++++++++++
>  13 files changed, 435 insertions(+), 627 deletions(-)
>  delete mode 100644 tools/pci/Build
>  delete mode 100644 tools/pci/Makefile
>  delete mode 100644 tools/pci/pcitest.c
>  delete mode 100644 tools/pci/pcitest.sh
>  create mode 100644 tools/testing/selftests/pci_endpoint/.gitignore
>  create mode 100644 tools/testing/selftests/pci_endpoint/Makefile
>  create mode 100644 tools/testing/selftests/pci_endpoint/config
>  create mode 100644 tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> 
> -- 
> 2.25.1
> 

I ran the test using simply:

$ ./pci_endpoint_test

and got:

#  RUN           pci_ep_basic.MSIX_TEST ...
# pci_endpoint_test.c:129:MSIX_TEST:Expected 0 (0) == ret (-110)
# pci_endpoint_test.c:129:MSIX_TEST:Test failed for MSI-X33
# pci_endpoint_test.c:129:MSIX_TEST:Expected 0 (0) == ret (-110)
# pci_endpoint_test.c:129:MSIX_TEST:Test failed for MSI-X34
# pci_endpoint_test.c:129:MSIX_TEST:Expected 0 (0) == ret (-110)
# pci_endpoint_test.c:129:MSIX_TEST:Test failed for MSI-X35
# pci_endpoint_test.c:129:MSIX_TEST:Expected 0 (0) == ret (-110)
# pci_endpoint_test.c:129:MSIX_TEST:Test failed for MSI-X36
# pci_endpoint_test.c:129:MSIX_TEST:Expected 0 (0) == ret (-110)
# pci_endpoint_test.c:129:MSIX_TEST:Test failed for MSI-X37
# pci_endpoint_test.c:129:MSIX_TEST:Expected 0 (0) == ret (-110)
# pci_endpoint_test.c:129:MSIX_TEST:Test failed for MSI-X38
# pci_endpoint_test.c:129:MSIX_TEST:Expected 0 (0) == ret (-110)
# pci_endpoint_test.c:129:MSIX_TEST:Test failed for MSI-X39


I think that you should also do:

diff --git a/Documentation/PCI/endpoint/pci-test-howto.rst b/Documentation/PCI/endpoint/pci-test-howto.rst
index 7d0dbad61456..7d5049c884dd 100644
--- a/Documentation/PCI/endpoint/pci-test-howto.rst
+++ b/Documentation/PCI/endpoint/pci-test-howto.rst
@@ -81,8 +81,8 @@ device, the following commands can be used::
 
        # echo 0x104c > functions/pci_epf_test/func1/vendorid
        # echo 0xb500 > functions/pci_epf_test/func1/deviceid
-       # echo 16 > functions/pci_epf_test/func1/msi_interrupts
-       # echo 8 > functions/pci_epf_test/func1/msix_interrupts
+       # echo 32 > functions/pci_epf_test/func1/msi_interrupts
+       # echo 2048 > functions/pci_epf_test/func1/msix_interrupts
 

Such that the documentation suggests values that will actually make the
pci_endpoint_test pass without any special parameters set.


Other than that small nit, for the series:
Tested-by: Niklas Cassel <cassel@kernel.org>

