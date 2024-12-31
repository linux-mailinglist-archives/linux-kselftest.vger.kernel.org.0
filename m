Return-Path: <linux-kselftest+bounces-23798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4435D9FF0D9
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Dec 2024 18:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0062161B43
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Dec 2024 17:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF9719DF99;
	Tue, 31 Dec 2024 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4PFGsty"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EBD44C6C;
	Tue, 31 Dec 2024 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735665430; cv=none; b=CQZACvEevmgTGlQNMdBRpSXInTjW4URlnx+Dd3ydvd8tc9KwMm3+7CsPPYWQcaipc00YcveH/fugz4aSfx7PoD9U2CBrWpelwXyznpE7MPrZDPeaFIIuMKGdkBKJLQw9G11ClHSE6GSHh425suVSt9TWNrl/pmDeVUjf/hCRK4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735665430; c=relaxed/simple;
	bh=vkpKAcxOiJ5wL8myQ4d3MaD0UWtuPNoLYPTDsYaPUBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyDsk/vCT95/3betdLBWfFsclunc+IfD5V9uIhJCqbRRv7ZTFF8R+sYqtpLRc0xSxSpPDMMwhVLzpZnVq1jXymhTvQ2xEQEPm+tu1ljQbZFwH/8EMwe8720gSd0oGZQHa5ba4/kTZ3SLXrlgSg2Py5YkOvzMTfoW4aJme8UvP48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4PFGsty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E54C4CED2;
	Tue, 31 Dec 2024 17:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735665430;
	bh=vkpKAcxOiJ5wL8myQ4d3MaD0UWtuPNoLYPTDsYaPUBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d4PFGstyfJu8jetz5HDQRJUozDBJlbGMvmTEjXVuDrOUt5ursGjKJ0hMak8O9wU6n
	 W9q1WzAzJvoumMwtiD8DvWbcAt2M6IolN8XWUr3pm6is1IDDOwQHYLIkp2Qo2RJeTR
	 Q9WkHev4OkxC3fi4n3f2Uk2DB84o7jXA/vK8cEcXGQnH85bajTngsm98Oxc7gAPkEl
	 VXLjGNsz1gEZ76t38nqIDz+spn6ClQTXFE2KL0PfQn4fYSawZNwqEJB8UTVhMw1zCf
	 PCE0MS9StQIsO2InqC9KCVo2MClwncC8421lqMnGbYmrz6FYZPiYs/ezNvLa27Tjih
	 l/HJ7iOj12bGg==
Date: Tue, 31 Dec 2024 18:17:05 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de,
	lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 2/3] selftests: Move PCI Endpoint tests from tools/pci
 to Kselftests
Message-ID: <Z3QnESese3Le9FP0@ryzen>
References: <20241231131341.39292-1-manivannan.sadhasivam@linaro.org>
 <20241231131341.39292-3-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241231131341.39292-3-manivannan.sadhasivam@linaro.org>

On Tue, Dec 31, 2024 at 06:43:40PM +0530, Manivannan Sadhasivam wrote:
> This just moves the existing tests under tools/pci to
> tools/testing/selftests/pci_endpoint and adjusts the paths in Makefile
> accordingly. Migration to Kselftest framework will be done in subsequent
> commits.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Why not squash this patch with the subsequent patch that actually
converts the tests to kselftests?

If you just apply this patch, then we have moved the code to
testing/selftests/ but the tests are not actually kselftests,
which doesn't really make sense IMO.


Kind regards,
Niklas


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
> index 1e930c7a58b1..0e611b845d50 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18003,7 +18003,7 @@ F:	Documentation/PCI/endpoint/*
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

