Return-Path: <linux-kselftest+bounces-44253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AF9C18BD1
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 08:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494801AA65AB
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 07:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE8530EF75;
	Wed, 29 Oct 2025 07:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jZgEHj9r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B44819E82A;
	Wed, 29 Oct 2025 07:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723836; cv=none; b=AyYFT4eOA4APD8oJzv/v4J9VtMWo5m3SnGAO7w+kuiXbq/v09sL/hKDUq9aeA0OGPjANrJBmT10dSJhGX/UUoUZQNUIcvTrY7WioCDSNkEUTI8E5cHV8m9ejWCIeNqy1U0mw5o4hRhymvky43yiJruCdgiCpZq3q+fnLnkYxNgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723836; c=relaxed/simple;
	bh=sTpZ09xOIKuyu7EF0yjjz0CspP8pKuAhf+0WKJX54ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6Y9shHuwvwb4aTJSHt3UCwNbyijZHb3eSz1+/NgmFXqzzaJep9yKhVoIwQOphenj4IwNuGs3g5crf7Pmj28uWcTg8Ix6QRSDqxWtNn0mwtii/nEt+BWLSMd0SfSFMKgX3jv04LnkmHYywEFFrkQ0CRxDTiyBxmsMW5wdzRhk/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jZgEHj9r; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761723834; x=1793259834;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sTpZ09xOIKuyu7EF0yjjz0CspP8pKuAhf+0WKJX54ok=;
  b=jZgEHj9r3ICs38VaAHjBN/qI6FJNvadMDUYrpt5/p/JA2bVr6HQT8UnX
   GKE0AtpPAw7Ndw9LIUp7yXggbFvtSdDiJVDmOOfUWEXVL1LqXQfYsht6Z
   M5vV7SQuxCWmmT+kXrIgi2ycNlSIWajIfXkBi01GotGH4fIPS+wCl8TK3
   cTIlezzvpS2igVmXroeO3uaAIowqx9PkT0yXpcuVR8j/iu9sVMG7I5GAK
   gJFI/BB6cPwz6pzlE7DH60wjhSr3Mn7oEFYaXWpzPD0EabRLtpXmLUGLi
   AOmZGlPjJLxF+h7nT7uXZ636OcfIV24tnjPuenM75pWx8I6bsr/1hSw1u
   w==;
X-CSE-ConnectionGUID: bm+HaResQU2g/2n/hvzRdQ==
X-CSE-MsgGUID: n33UqjX/Rk+36QCrxsdzUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63877668"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="63877668"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 00:43:54 -0700
X-CSE-ConnectionGUID: MOOesLzBQS2mZvLZEi3LMA==
X-CSE-MsgGUID: 2OJBIwZaQR+54NOfGgrlMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="190714282"
Received: from yinghaoj-desk.ccr.corp.intel.com (HELO [10.238.1.225]) ([10.238.1.225])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 00:43:48 -0700
Message-ID: <4a8c783a-e930-44ca-9222-ce6d8ce26463@linux.intel.com>
Date: Wed, 29 Oct 2025 15:43:46 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 07/23] KVM: selftests: Add kbuild definitons
To: Sagi Shahar <sagis@google.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>,
 Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 Erdem Aktas <erdemaktas@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roger Wang <runanwang@google.com>, Oliver Upton <oliver.upton@linux.dev>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Ira Weiny
 <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-8-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20251028212052.200523-8-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/29/2025 5:20 AM, Sagi Shahar wrote:
> Add kbuild.h that can be used by files under tools/
>
> Definitions are taken from the original definitions at
> include/linux/kbuild.h
>
> This is needed to expose values from c code to assembly code.
>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>   tools/include/linux/kbuild.h | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>   create mode 100644 tools/include/linux/kbuild.h
>
> diff --git a/tools/include/linux/kbuild.h b/tools/include/linux/kbuild.h
> new file mode 100644
> index 000000000000..62e20ba9380e
> --- /dev/null
> +++ b/tools/include/linux/kbuild.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __TOOLS_LINUX_KBUILD_H
> +#define __TOOLS_LINUX_KBUILD_H
> +
> +#include <stddef.h>

This is not in kernel's version.
Instead, consumers of kbuild.h include the necessary header.

Maybe it can follow kernel's style?

> +
> +#define DEFINE(sym, val) \
> +	asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
> +
> +#define BLANK() asm volatile("\n.ascii \"->\"" : : )
> +
> +#define OFFSET(sym, str, mem) \
> +	DEFINE(sym, offsetof(struct str, mem))
> +
> +#define COMMENT(x) \
> +	asm volatile("\n.ascii \"->#" x "\"")
> +
> +#endif /* __TOOLS_LINUX_KBUILD_H */


