Return-Path: <linux-kselftest+bounces-39259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD32B2B49B
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 01:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F5C4E502A
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 23:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612DF1E8329;
	Mon, 18 Aug 2025 23:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QRBnqUEn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF18A17C21E;
	Mon, 18 Aug 2025 23:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755559590; cv=none; b=eVkWouegcCLZFBsflJDnfPcc1bI5JK12XYm8snDnVdfxlVDaqOPET1a94vPUWST/DBJM0+sfac9TtydY6GA4V6BHYaiyFVTvQo2HaMK+voiU0SOfwLNPeLigjtQNfJTWmTEkkSLrp+jRr1FkQOLyvJnN+qsiP52ygMUI7nEXYoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755559590; c=relaxed/simple;
	bh=SyQVULfU64/s8ngMZr/7VHFJPA1woo/Mj04PdBCv4vo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pbhBvJoDwEko8NpCYr5dEQx7L5b5nNbUo5u/7EVtMH6uV2jIuCLbe0uuZfOnCXkn6/DAVwLPVR3Ee2HMZ9EVkCFd6DoQps0MlrufbEt5XYgB9vDUAi0FaxdZBgjJRd/npiBML8PQDb7JjNXqj+7WOLRDk18E5Vdd5oIpVN1uJkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QRBnqUEn; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755559589; x=1787095589;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=SyQVULfU64/s8ngMZr/7VHFJPA1woo/Mj04PdBCv4vo=;
  b=QRBnqUEn6LiMPlEoqA3Qhgb/a+VH94yrzytwSMKSVcL+eK7QelDmXiHA
   MudtFG/RleA3uQIJsNkIOU1/r6aoMYmDcXM3L1cxF4rRMt6wziOs+iLvc
   uD9U/QtlBK3KOeZKk5XEUcHXdFsZ5P+v1kIGE5yKsiccX5lWLMk4W6wqi
   03XESDAwDYOmVvtIbQfGvNcfXt7+PAtEkEjKWQFfjfWV4t56zeznR8Zi0
   sarnKGDGmK9W7OgStvImjvuAg3PI2APzAF2Qz++lwokeNwwjdxCFkB1hR
   n2SpfG2VhSY0MqxzOapVJZ/+gfxGGVDnS5Q+iFrrnupqVJhCoGYby/UsG
   g==;
X-CSE-ConnectionGUID: owcOjLrLQnKOsIbaAPON/g==
X-CSE-MsgGUID: wQ2R5QhwRX+vVWoHNWVrLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="57650497"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="57650497"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 16:26:28 -0700
X-CSE-ConnectionGUID: yI17w3lwS2K9iSy07ZAHWg==
X-CSE-MsgGUID: 7Jj4KvZ3Si6T2hEOaBQcZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="172127349"
Received: from vcostago-mobl3.jf.intel.com (HELO vcostago-mobl3) ([10.98.24.140])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 16:26:28 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson
 <alex.williamson@redhat.com>
Cc: Aaron Lewis <aaronlewis@google.com>, Adhemerval Zanella
 <adhemerval.zanella@linaro.org>, Adithya Jayachandran
 <ajayachandra@nvidia.com>, Andrew Jones <ajones@ventanamicro.com>, Ard
 Biesheuvel <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Dan Williams <dan.j.williams@intel.com>, Dave Jiang
 <dave.jiang@intel.com>, David Matlack <dmatlack@google.com>,
 dmaengine@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>, James
 Houghton <jthoughton@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Joel
 Granados <joel.granados@kernel.org>, Josh Hilke <jrhilke@google.com>,
 Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "Mike Rapoport (Microsoft)"
 <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, "Pratik R. Sampat" <prsampat@amd.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Sean Christopherson <seanjc@google.com>,
 Shuah Khan <shuah@kernel.org>, Vipin Sharma <vipinsh@google.com>, Wei Yang
 <richard.weiyang@gmail.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Subject: Re: [PATCH 21/33] dmaengine: idxd: Allow registers.h to be included
 from tools/
In-Reply-To: <20250620232031.2705638-22-dmatlack@google.com>
References: <20250620232031.2705638-1-dmatlack@google.com>
 <20250620232031.2705638-22-dmatlack@google.com>
Date: Mon, 18 Aug 2025 16:26:27 -0700
Message-ID: <87frdo2ov0.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Matlack <dmatlack@google.com> writes:

> Allow drivers/dma/idxd/registers.h to be included from userspace in
> tools/ by adjusting the include path to uapi/linux/idxd.h if __KERNEL__
> is not defined.
>
> A subsequent commit will use registers.h to implement a userspace driver
> for Intel DSA devices in tools/testing/selftests/vfio.
>
> Signed-off-by: David Matlack <dmatlack@google.com>

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

> ---
>  drivers/dma/idxd/registers.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
> index 006ba206ab1b..bf79bc39a5f3 100644
> --- a/drivers/dma/idxd/registers.h
> +++ b/drivers/dma/idxd/registers.h
> @@ -3,7 +3,11 @@
>  #ifndef _IDXD_REGISTERS_H_
>  #define _IDXD_REGISTERS_H_
>  
> +#ifdef __KERNEL__
>  #include <uapi/linux/idxd.h>
> +#else
> +#include <linux/idxd.h>
> +#endif
>  
>  /* PCI Config */
>  #define PCI_DEVICE_ID_INTEL_DSA_GNRD	0x11fb
> -- 
> 2.50.0.rc2.701.gf1e915cc24-goog
>

-- 
Vinicius

