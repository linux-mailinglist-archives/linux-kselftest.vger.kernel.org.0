Return-Path: <linux-kselftest+bounces-40022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA23B37674
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 03:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75E862A4BDD
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 01:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D20919DF6A;
	Wed, 27 Aug 2025 01:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AXv+iyu6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3603595C;
	Wed, 27 Aug 2025 01:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756256840; cv=none; b=Fw/jVQAhaweKmceHgF8qr+PNROa27xIoCM4Jb3ERI2ZBG1V4VRmfq8oeRSLuWRLbx97ndIXEMqRwzL9aMfPepo5Br0HdvjrCw0tAqwvYQAj+wAuEZm1a+nhXBJ/OP125kZrL2dBEEnJRkmA1z34p0FNMeaKmvc0NIMiljRWEJvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756256840; c=relaxed/simple;
	bh=ptg3hadmfo2fwJ+oQGUqKSF+CCbCyayELJdhHf7zfgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GP4R6FtuRtD8pYCn3K2COS27JF3+SYqhQ0rTxAF30XuptsRG4rz0yrL81vUY9C+6Zebxoh2lrcMDo02YgQo0uFLrOlNS+8SueXhovh2KfAwGnIm+gN0Hd1BSvqYRPQ51+u1tXQDZVk0v3hEg1ug5MvMBVEy8PNy86JqNIsVxQ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AXv+iyu6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=VO1laDguuSxP27SypRdymEziv/15eUANmc0X6Tkn9F4=; b=AXv+iyu6tzbuHM9ea1KZ6XKL5r
	aJ45hCoGWurLgHLegyj3pNzyBcFYRcD+m+PnzQtng0ky3TYyIJ/S/M+K5COyk/+sBzpMxJRN/vEaD
	X9kXBSFcM0P1DQrBMVtqKh0YLLTDIFDsuCUGp8Awb32Wu/QPTjpxcsXO2Osrr1+dalzStftvw4Y6n
	3Z4SMHvBEcQq8BZHI1lThW2Zq9bFXDnxaQB6nRP4RxBaGeh1mqadoKN57oQIuyf+xWk/q2dWH0tBk
	mivcdcSOPezwUuivthLT5pknKEV8HAViFguj1T59vzXzDewBT6QK9ERx67tE/Ix3HoNwBsjlAvFh2
	jcSEq9wA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ur4dA-0000000DUey-3IVq;
	Wed, 27 Aug 2025 01:07:16 +0000
Message-ID: <48f34379-f0aa-40fd-8578-3cf562880731@infradead.org>
Date: Tue, 26 Aug 2025 18:07:15 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/15] genpt: Add Documentation/ files
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Justin Stitt <justinstitt@google.com>, Kevin Tian <kevin.tian@intel.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 llvm@lists.linux.dev, Bill Wendling <morbo@google.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 James Gowans <jgowans@amazon.com>, Michael Roth <michael.roth@amd.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
References: <2-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <2-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/26/25 10:18 AM, Jason Gunthorpe wrote:
> Add some general description and pull in the kdoc comments from the source
> file to index most of the useful functions.
> 
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  Documentation/driver-api/generic_pt.rst | 140 ++++++++++++++++++++++++
>  Documentation/driver-api/index.rst      |   1 +
>  2 files changed, 141 insertions(+)
>  create mode 100644 Documentation/driver-api/generic_pt.rst
> 
> diff --git a/Documentation/driver-api/generic_pt.rst b/Documentation/driver-api/generic_pt.rst
> new file mode 100644
> index 00000000000000..45b05dafece814
> --- /dev/null
> +++ b/Documentation/driver-api/generic_pt.rst
> @@ -0,0 +1,140 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +========================
> +Generic Radix Page Table
> +========================
> +
> +.. kernel-doc:: include/linux/generic_pt/common.h
> +	:doc: Generic Radix Page Table
> +
> +.. kernel-doc:: drivers/iommu/generic_pt/pt_defs.h
> +	:doc: Generic Page Table Language
> +
> +-----
> +Usage
> +-----
> +
> +Generic PT is structured as a multi-compilation system. Since each format
> +provides an API using a common set of names there can be only one format active
> +within a compilation unit. This design avoids function pointers around the low
> +level API.
> +
> +Instead the function pointers can end up at the higher level API (ie map/unmap,

                                                                    (i.e.,

> +etc) and the per-format code can be directly inlined into the per-format

   etc.)

> +compilation unit. For something like iommu each format will be compiled into a
> +per-format iommu operations kernel module.
> +

I would s/iommu/IOMMU/g when it's used in a sentence as an acronym (i.e., not
functions names, struct names, struct fields, file names, etc.).

> +For this to work the .c file for each compilation unit will include both the
> +format headers and the generic code for the implementation. For instance in an
> +implementation compilation unit the headers would normally be included as
> +follows::
> +
> +	#include <linux/generic_pt/common.h>
> +	#include "fmt/defs_amdv1.h"
> +	#include "pt_defs.h"
> +	#include "fmt/amdv1.h"
> +	#include "pt_common.h"
> +	#include "pt_iter.h"
> +	#include "iommut_pt.h"  /* The iommu implementation */
> +
> +iommu_pt.h includes definitions that will generate the operations functions for
> +map/unmap/etc using the definitions provided by AMDv1. The resulting module
             etc.

> +will have exported symbols named like pt_iommu_amdv1_init().
> +
> +Refer to drivers/iommu/generic-pt/fmt/iommu_template.h for an example of how the
> +iommu implementation uses multi-compilation to generate per-format ops structs
> +pointers.
> +
> +The format code is written so that the common names arise from #defines to
> +distinct format specific names. This is intended to aid debuggability by
> +avoiding symbol clashes across all the different formats.
> +
> +Exported symbols and other global names are mangled using a per-format string
> +via the NS() helper macro.
> +
> +The format uses struct pt_common as the top level struct for the table,

                                           top-level

> +and each format will have its own struct pt_xxx which embeds it to store
> +format-specific information.
> +
> +The implementation will further wrapper this in its own top level struct, such

                                           this???         top-level
oh, maybe                          wrap this               top-level



> +as struct pt_iommu_amdv1.
> +
> +----------------------------------------------
> +Format functions at the struct pt_common level
> +----------------------------------------------
> +
> +.. kernel-doc:: include/linux/generic_pt/common.h
> +	:identifiers:
> +.. kernel-doc:: drivers/iommu/generic_pt/pt_common.h
> +
> +-----------------
> +Iteration Helpers
> +-----------------
> +
> +.. kernel-doc:: drivers/iommu/generic_pt/pt_iter.h
> +
> +----------------
> +Writing a Format
> +----------------
> +
> +It is best to start from a simple format that is similar to the target. x86_64
> +is usually a good reference for something simple, and AMDv1 is something fairly
> +complete.
> +
> +The required inline functions need to be implemented in the format header.
> +These should all follow the standard pattern of::
> +
> + static inline pt_oaddr_t amdv1pt_entry_oa(const struct pt_state *pts)
> + {
> +	[..]
> + }
> + #define pt_entry_oa amdv1pt_entry_oa
> +
> +Where a uniquely named per-format inline function provides the implementation

   where

> +and a define maps it to the generic name. This is intended to make debug symbols
> +work better. inline functions should always be used as the prototypes in
> +pt_common.h will cause the compiler to validate the function signature to
> +prevent errors.
> +
> +Review pt_fmt_defaults.h to understand some of the optional inlines.
> +
> +Once the format compiles then it should be run through the generic page table
> +kunit test in kunit_generic_pt.h using kunit. For example::
> +
> +   $ tools/testing/kunit/kunit.py run --build_dir build_kunit_x86_64 --arch x86_64 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig amdv1_fmt_test.*
> +   [...]
> +   [11:15:08] Testing complete. Ran 9 tests: passed: 9
> +   [11:15:09] Elapsed time: 3.137s total, 0.001s configuring, 2.368s building, 0.311s running
> +
> +The generic tests are intended to prove out the format functions and give
> +clearer failures to speed up finding the problems. Once those pass then the
> +entire kunit suite should be run.
> +
> +---------------------------
> +IOMMU Invalidation Features
> +---------------------------
> +
> +Invalidation is how the page table algorithms synchronize with a HW cache of the
> +pagetable memory, typically called the TLB (or IOTLB for IOMMU cases).

   page table
to match the rest of this document.

> +
> +The TLB can store present PTEs, non-present PTEs and table pointers, depending
> +on its design. Every HW has its own approach on how to describe what has changed
> +to get changed items removed from the TLB.

   to have changed items removed

> +
> +PT_FEAT_FLUSH_RANGE
> +-------------------
> +
> +PT_FEAT_FLUSH_RANGE is the easiest scheme to understand. It tries to generate a
> +single range invalidation for each operation, over invalidating if there are

                                                 over-invalidating

> +gaps of VA that don't need invalidation. This trades off impacted VA for number
> +of invalidation operations. It does not keep track of what is being invalidated,

                                                                       invalidated;

> +however if pages have to be freed then page table pointers have to be cleaned

   however,

> +from the walk cache. The range can start/end at any page boundary.
> +
> +PT_FEAT_FLUSH_RANGE_NO_GAPS
> +---------------------------
> +
> +PT_FEAT_FLUSH_RANGE_NO_GAPS is similar to PT_FEAT_FLUSH_RANGE however it tries

                                             PT_FEAT_FLUSH_RANGE; however, it tries

> +to minimize the amount of impacted VA by issuing extra flush operations. This is
> +useful if the cost of processing VA is very high, for instance because a
> +hypervisor is processing the page table with a shadowing algorithm.
-- 
~Randy


