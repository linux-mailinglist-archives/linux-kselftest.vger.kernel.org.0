Return-Path: <linux-kselftest+bounces-24657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6DFA13DEB
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 16:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3D93A02F4
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 15:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4344422B8CF;
	Thu, 16 Jan 2025 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbKfPrzV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127A01DE881;
	Thu, 16 Jan 2025 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041993; cv=none; b=auLCmbNFoCdt0NzktLcsr2CFSboCfu5XL6F1fa1iWNawdTtf+kZmppGrj/vseKRo1B39MmWidj4mpsicDd/UvE/n3JVYm5CuZDQckxTnMxu0RD+pFo1fRNkT6UKgC+K6k9aLBSBzXeOqps9M/IndsR3ZzOZppUacbda5Lc37WFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041993; c=relaxed/simple;
	bh=3OUphbvzNOcWjim0O99/AcVNZIdVRDC9Ev1jtJSWXgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyuEeCh0dFRfAQog1Sny0+E4f7UmBulP763w3V3FMcnS5pxLHktOsRaxaSkTerX7jl0/aqOX8DvOKlUG98EVNqbiDgxGdrhdGEP2HfkKsDCymJ09YeDt7BI9zEaip4l6VjuvDx2lMj9IdzPtkrnQo4RXcAwdOFFmA6iS+DfkFJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbKfPrzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C892CC4CED6;
	Thu, 16 Jan 2025 15:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737041992;
	bh=3OUphbvzNOcWjim0O99/AcVNZIdVRDC9Ev1jtJSWXgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HbKfPrzVBYx73+TE9zJDeqp4+5++s+BmEV7CbXuiKgTsrihun2VyXv18DmTXhlpZd
	 msJ4L3Q2QyLIRJTOHld0PVakepSlClNHlLTeR4Rp2gOPxVAn7gkdRbqJ65sKHriTiw
	 o9CSRL5iiXTPKblFdBcP5TbFq9zMZJCk04Skewm82/3pKtg3oHKBljkU/UN5ZBRLm6
	 18ixizcOqT904YMPxtorFsWC4Pu8XagEuP71PwDK3Mw+sSxJw4FeuNFp7w94pg2tGS
	 Nh9/LkJnuOg/aTFbpKwOfBp2+PKdVZ0IjHskugLIBvHB5yyChkAxV3gjLLYgGXhanb
	 YQpD1qWa1BRpA==
Date: Thu, 16 Jan 2025 16:39:47 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de,
	lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 3/4] selftests: Move PCI Endpoint tests from tools/pci
 to Kselftests
Message-ID: <Z4koQ7zoePf2_hPu@ryzen>
References: <20250116135106.19143-1-manivannan.sadhasivam@linaro.org>
 <20250116135106.19143-4-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116135106.19143-4-manivannan.sadhasivam@linaro.org>

On Thu, Jan 16, 2025 at 07:21:05PM +0530, Manivannan Sadhasivam wrote:
> This just moves the existing tests under tools/pci to
> tools/testing/selftests/pci_endpoint and adjusts the paths in Makefile
> accordingly. Migration to Kselftest framework will be done in subsequent
> commits.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/PCI/endpoint/pci-test-howto.rst          |  9 +++++----
>  MAINTAINERS                                            |  2 +-
>  tools/testing/selftests/pci_endpoint/.gitignore        |  3 +++
>  tools/{pci => testing/selftests/pci_endpoint}/Build    |  0
>  tools/{pci => testing/selftests/pci_endpoint}/Makefile | 10 +++++-----
>  .../{pci => testing/selftests/pci_endpoint}/pcitest.c  |  0
>  .../{pci => testing/selftests/pci_endpoint}/pcitest.sh |  0
>  7 files changed, 14 insertions(+), 10 deletions(-)
>  create mode 100644 tools/testing/selftests/pci_endpoint/.gitignore
>  rename tools/{pci => testing/selftests/pci_endpoint}/Build (100%)
>  rename tools/{pci => testing/selftests/pci_endpoint}/Makefile (83%)
>  rename tools/{pci => testing/selftests/pci_endpoint}/pcitest.c (100%)
>  rename tools/{pci => testing/selftests/pci_endpoint}/pcitest.sh (100%)
> 
> diff --git a/Documentation/PCI/endpoint/pci-test-howto.rst b/Documentation/PCI/endpoint/pci-test-howto.rst
> index 909f770a07d6..c4ae7af50ede 100644
> --- a/Documentation/PCI/endpoint/pci-test-howto.rst
> +++ b/Documentation/PCI/endpoint/pci-test-howto.rst
> @@ -123,16 +123,17 @@ above::
>  Using Endpoint Test function Device
>  -----------------------------------
>  
> -pcitest.sh added in tools/pci/ can be used to run all the default PCI endpoint
> -tests. To compile this tool the following commands should be used::
> +pcitest.sh added in tools/testing/selftests/pci_endpoint can be used to run all
> +the default PCI endpoint tests. To compile this tool the following commands
> +should be used::
>  
>  	# cd <kernel-dir>
> -	# make -C tools/pci
> +	# make -C tools/testing/selftests/pci_endpoint
>  
>  or if you desire to compile and install in your system::
>  
>  	# cd <kernel-dir>
> -	# make -C tools/pci install
> +	# make -C tools/testing/selftests/pci_endpoint install
>  
>  The tool and script will be located in <rootfs>/usr/bin/
>  
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e0fcdd8b6434..e96e80d8486d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18002,7 +18002,7 @@ F:	Documentation/PCI/endpoint/*
>  F:	Documentation/misc-devices/pci-endpoint-test.rst
>  F:	drivers/misc/pci_endpoint_test.c
>  F:	drivers/pci/endpoint/
> -F:	tools/pci/
> +F:	tools/testing/selftests/pci_endpoint/
>  
>  PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
>  M:	Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> diff --git a/tools/testing/selftests/pci_endpoint/.gitignore b/tools/testing/selftests/pci_endpoint/.gitignore
> new file mode 100644
> index 000000000000..29ab47c48484
> --- /dev/null
> +++ b/tools/testing/selftests/pci_endpoint/.gitignore
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +*.o
> +pcitest
> diff --git a/tools/pci/Build b/tools/testing/selftests/pci_endpoint/Build
> similarity index 100%
> rename from tools/pci/Build
> rename to tools/testing/selftests/pci_endpoint/Build
> diff --git a/tools/pci/Makefile b/tools/testing/selftests/pci_endpoint/Makefile
> similarity index 83%
> rename from tools/pci/Makefile
> rename to tools/testing/selftests/pci_endpoint/Makefile
> index 62d41f1a1e2c..3c6fe18e32cc 100644
> --- a/tools/pci/Makefile
> +++ b/tools/testing/selftests/pci_endpoint/Makefile
> @@ -1,11 +1,10 @@
>  # SPDX-License-Identifier: GPL-2.0
> -include ../scripts/Makefile.include
> +include ../../../scripts/Makefile.include
>  
>  bindir ?= /usr/bin
>  
>  ifeq ($(srctree),)
> -srctree := $(patsubst %/,%,$(dir $(CURDIR)))
> -srctree := $(patsubst %/,%,$(dir $(srctree)))
> +srctree := $(patsubst %/tools/testing/selftests/,%,$(dir $(CURDIR)))
>  endif
>  
>  # Do not use make's built-in rules
> @@ -27,10 +26,11 @@ include $(srctree)/tools/build/Makefile.include
>  #
>  # We need the following to be outside of kernel tree
>  #
> -$(OUTPUT)include/linux/: ../../include/uapi/linux/
> +$(OUTPUT)include/linux/: ../../../../include/uapi/linux/
>  	mkdir -p $(OUTPUT)include/linux/ 2>&1 || true
> -	ln -sf $(CURDIR)/../../include/uapi/linux/pcitest.h $@
> +	ln -sf $(CURDIR)/../../../../include/uapi/linux/pcitest.h $@
>  
> +$(info ${CURDIR})
>  prepare: $(OUTPUT)include/linux/
>  
>  PCITEST_IN := $(OUTPUT)pcitest-in.o
> diff --git a/tools/pci/pcitest.c b/tools/testing/selftests/pci_endpoint/pcitest.c
> similarity index 100%
> rename from tools/pci/pcitest.c
> rename to tools/testing/selftests/pci_endpoint/pcitest.c
> diff --git a/tools/pci/pcitest.sh b/tools/testing/selftests/pci_endpoint/pcitest.sh
> similarity index 100%
> rename from tools/pci/pcitest.sh
> rename to tools/testing/selftests/pci_endpoint/pcitest.sh
> -- 
> 2.25.1
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>

