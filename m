Return-Path: <linux-kselftest+bounces-39336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3211BB2CF15
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 00:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CCD73B675C
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 22:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25FA3FE7;
	Tue, 19 Aug 2025 22:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3poO1Tx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57668353349;
	Tue, 19 Aug 2025 22:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755641261; cv=none; b=ftqZftJFLIwa+M30TH6WeRKX7pzdgVcMd9T1KCz/D/IAffyymTcluaB/aWK+CqAwWTpUlxhIyWTiHwOTBKjFowhcfC8JdnREDGB326BWVpOLSEJNZobzxc2F8f4pUo8pxIrxBxvhyWciALulSrfdfMvQZFjiU6EHNoLRrzd/om8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755641261; c=relaxed/simple;
	bh=hn0J4AVXSnuSKw9QPvSMNYUYoIS6ariEeDzLQyXCx64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rifiFhTF6EpgaiqL6lBP4LxDVrPqjhspc3EtqlyWZs96K2U4moPTEektxv0k4fTDvSsRNXKbe+as2kODWbgMcMHjTjIh3oFo7hPw5eWaOCk5KS8fDIfseSrmbyGELjw/EGdrxWBLdTuF5+zqL1VGebz9v8d1Jm1hSXnXN6E5vbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3poO1Tx; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755641260; x=1787177260;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hn0J4AVXSnuSKw9QPvSMNYUYoIS6ariEeDzLQyXCx64=;
  b=h3poO1TxR5AQ9Zf4IMkhhHQV4gCt8X6S3n/hJl3ud0A5J121vKfS5JEi
   goamHoqun5GXU0tXmdqGzWYiOHrkJ6OzuoC7WHb50a8fHEPSY89fBIjaR
   l10JyIQaO4ILquBgYW6lcMsBGDI5xaribUS1RyGSLKqkRA3pdV/NTiFAQ
   +qHf//uLkYZ3R482iSuc8JIkZG2UqJV9fIEOEDYNzFAnK3lCXKYqLHalD
   fYdZbN9mLH3PKreu5VOnxdLtcDbdmDaqf5qcbPAZvzk8I5N1s2KHQqM81
   LJ2IIbq7aq9ik8sO6o/ayt/HLmPGBpy1HQnj/kaagTf3gAhu85tt4clp9
   g==;
X-CSE-ConnectionGUID: vDx+F47EQMKZw/fMzK6rGg==
X-CSE-MsgGUID: YQN5t9FyQIe3MzCw6cPqDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57610779"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57610779"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 15:07:38 -0700
X-CSE-ConnectionGUID: H3WSprwTQdWW3Mmw5QbUxA==
X-CSE-MsgGUID: r3pte3xRRDWGciiROsD48Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="205121859"
Received: from unknown (HELO [10.247.119.200]) ([10.247.119.200])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 15:07:23 -0700
Message-ID: <74516dcc-40fa-4a94-909f-4c3ed02e6d6b@intel.com>
Date: Tue, 19 Aug 2025 15:07:22 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/33] dmaengine: ioat: Move system_has_dca_enabled() to
 dma.h
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
 <20250620232031.2705638-20-dmatlack@google.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250620232031.2705638-20-dmatlack@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/20/25 4:20 PM, David Matlack wrote:
> Move the function prototype for system_has_dca_enabled() from hw.h to
> dma.h. This allows hw.h to be included from tools/, which will be used
> in a subsysequent commit to implement a userspace driver for Intel CBDMA
> devices in tools/testing/selftests/vfio.
> 
> No functional change intended.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/ioat/dma.h | 2 ++
>  drivers/dma/ioat/hw.h  | 3 ---
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
> index a180171087a8..12a4a4860a74 100644
> --- a/drivers/dma/ioat/dma.h
> +++ b/drivers/dma/ioat/dma.h
> @@ -19,6 +19,8 @@
>  
>  #define IOAT_DMA_DCA_ANY_CPU		~0
>  
> +int system_has_dca_enabled(struct pci_dev *pdev);
> +
>  #define to_ioatdma_device(dev) container_of(dev, struct ioatdma_device, dma_dev)
>  #define to_dev(ioat_chan) (&(ioat_chan)->ioat_dma->pdev->dev)
>  #define to_pdev(ioat_chan) ((ioat_chan)->ioat_dma->pdev)
> diff --git a/drivers/dma/ioat/hw.h b/drivers/dma/ioat/hw.h
> index 79e4e4c09c18..0373c48520c9 100644
> --- a/drivers/dma/ioat/hw.h
> +++ b/drivers/dma/ioat/hw.h
> @@ -63,9 +63,6 @@
>  #define IOAT_VER_3_3            0x33    /* Version 3.3 */
>  #define IOAT_VER_3_4		0x34	/* Version 3.4 */
>  
> -
> -int system_has_dca_enabled(struct pci_dev *pdev);
> -
>  #define IOAT_DESC_SZ	64
>  
>  struct ioat_dma_descriptor {


