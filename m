Return-Path: <linux-kselftest+bounces-24891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6986A182E0
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 18:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C7A2188B3AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 17:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D411EE02F;
	Tue, 21 Jan 2025 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YePZzvfP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6427F187FE4;
	Tue, 21 Jan 2025 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737480595; cv=none; b=NvO97LXhSA+j5UUxl1BZoHTnl2XyPjpN08ol4Fn9nQF0Mphqk8B4+7RhXvCMK+/lr7yhpR5SZTaSbODNRlwuyfcPvTtiQIiwcfMh4wHDYy9U32bXf87zJIJvtCPmYIcyZQnPyB4v0NmOmsLgFHMGrsf5snT5WM9/C/Fd7t1t7X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737480595; c=relaxed/simple;
	bh=ZNQDrxrgWnzAEj1xBjQLCMfPlE421PdpUxtDRAkLv64=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FSrP1qYpvsuw+gdY5HI+GJnSH+IwN8/xUfyaqiAPVove0acuo00AuWIXy+livolLIfh03UnuWVQjl5uYst54hCOEenKFQ2Z8J58+B5dtR3MbYzXUqfWg2K5EmWkaEDxOFTp3J4xw8nvIn1ELdbZvZHPMGreGL06Gx+7C0rrT2eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YePZzvfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B584CC4CEDF;
	Tue, 21 Jan 2025 17:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737480594;
	bh=ZNQDrxrgWnzAEj1xBjQLCMfPlE421PdpUxtDRAkLv64=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YePZzvfPzaQyWhC8fKBd5tjQ8FsqWlQMCipEheA9mQj/P3CmZHHv3bc9G/IkTBKHG
	 h7wcxKpoYFov/3fNOwRSInDkGCguSKRyxI7htVTs6aDf9ouxs/xl/wNz/WRN4iCHVP
	 DQwuFKGEoY72OMOUGPoC93PiSpff3CeRZu8xWdMDnBmKNQdpIX5WXHP92CMHd/sq6l
	 /vISDXl8aJLLF09OYSbjjg+SKyaShW5pZ8Makv9FS36ag4tuK0L6Qj0NJWrdvsvnq9
	 wpGJ7xzmjQ9pa39SzFeOSQl7hdl8gaqgKCNaJYBc7N94aDkXJKPdSTGdMJXAPQdbIw
	 /0enXIe9HDPBw==
Date: Tue, 21 Jan 2025 11:29:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de,
	lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org, cassel@kernel.org
Subject: Re: [PATCH v6 0/4] Migrate PCI Endpoint Subsystem tests to Kselftest
Message-ID: <20250121172953.GA968517@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116171650.33585-1-manivannan.sadhasivam@linaro.org>

On Thu, Jan 16, 2025 at 10:46:46PM +0530, Manivannan Sadhasivam wrote:
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
> Changes in v6:
> 
> * Fixed the documentation to pass max MSI and MSI-X count to configfs
> * Collected tags
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
>  Documentation/PCI/endpoint/pci-test-howto.rst | 174 +++++-------
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
>  13 files changed, 437 insertions(+), 629 deletions(-)
>  delete mode 100644 tools/pci/Build
>  delete mode 100644 tools/pci/Makefile
>  delete mode 100644 tools/pci/pcitest.c
>  delete mode 100644 tools/pci/pcitest.sh
>  create mode 100644 tools/testing/selftests/pci_endpoint/.gitignore
>  create mode 100644 tools/testing/selftests/pci_endpoint/Makefile
>  create mode 100644 tools/testing/selftests/pci_endpoint/config
>  create mode 100644 tools/testing/selftests/pci_endpoint/pci_endpoint_test.c

I collected the other endpoint test patches on pci/endpoint-test and
applied this series on top for v6.14, thanks!

