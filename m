Return-Path: <linux-kselftest+bounces-39918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C93B354C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 08:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91AA81B61F1D
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 06:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05ED2F60A5;
	Tue, 26 Aug 2025 06:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mik7rsuI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159DB286D75;
	Tue, 26 Aug 2025 06:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756191162; cv=none; b=CM45DfdfuN/xPvUpoPyfwj24Fh6KksPf8xnh/ZPzArCBTpjhAC+C46v6l1UKa358Ov2aAFVgtwGyG/Gpgx52io5A8cl17nBwscbe4ZRDFUu5P0cuc8WODHsnXImsOvYEAQg2khsyyW3CTljEXWiMV/PRqKl8G26tzdQVjKF30RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756191162; c=relaxed/simple;
	bh=NZ3k1YFiXOLs+AVDlXX2D6tuby9ZGXWoy5E+XvSozb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rF8wgK7ZRP0r5yZu2jiZwBXDB6UUnJShb5fLb14w2tRjAt/Qk4tR4W024IuWmFYPLMlDAhmBDWSVAc+t6/PBcvMNhpYS98k50Vv7yPr4di/Vo/2Amx+S4FChVBuYrnkez3mvC6RLpWTcGBBcdMxv7WTKTU02xzMHFKv5rINlnOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mik7rsuI; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756191157; x=1787727157;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NZ3k1YFiXOLs+AVDlXX2D6tuby9ZGXWoy5E+XvSozb0=;
  b=Mik7rsuIhp364VAYefEnOXjGnEcLNi84N0NW8mNeIRJ5uNiG3DU2gO7E
   im5NETR7CdlMmJXQnfva6aGgRocypMXrV41xCviBHbHmDobg/Wv2Oc81i
   nI5rAKlQhzWn9awrO5EOrPPwmikjDIUgHJ1AaLosHBjUi49uUGXDVy8wZ
   Noni1JY2McQ5pGcunh8rcliFzNKyEp5jUyWfQm9GW3HkUyPQBLw9oO5L+
   QV+U68bBRiRon9XPhWDeZWRGTi/c31l6YcvXagp7lHlqTPI10lsJBAcIc
   MFxP5BCqNlINhlA84qnUNbO8hguEYvFJonvL9bApnU03iv5sE/Cwd9RjV
   A==;
X-CSE-ConnectionGUID: irMkHSFBTNmkxs6KDx5Gfg==
X-CSE-MsgGUID: 0kT302gXSLO3eAWPKUIobA==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="62232303"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62232303"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 23:52:36 -0700
X-CSE-ConnectionGUID: OF8I5LewQM+yGKS5SNItCg==
X-CSE-MsgGUID: d5QQK/++SIO6B1NrB+5JkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169883550"
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 23:52:31 -0700
Message-ID: <d780a249-ecb2-40e7-9520-19de8728c703@linux.intel.com>
Date: Tue, 26 Aug 2025 14:52:29 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 08/19] KVM: selftests: Define structs to pass
 parameters to TDX boot code
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
References: <20250821042915.3712925-1-sagis@google.com>
 <20250821042915.3712925-9-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20250821042915.3712925-9-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/21/2025 12:29 PM, Sagi Shahar wrote:
[...]
> +
> +/*
> + * Allows each vCPU to be initialized with different eip and esp.
> + *
> + * __packed is used since the offsets are hardcoded in td_boot.S
> + *
> + * TODO: Replace hardcoded offsets with OFFSET(). This requires getting the
> + * neccesry Kbuild scripts working in KVM selftests.
neccesry -> necessary

Also, are the comments about "__packed" and "TODO" out dated?

> + */
> +struct td_per_vcpu_parameters {
> +	uint32_t esp_gva;
> +	uint64_t guest_code;
> +};
> +
> +/*
> + * Boot parameters for the TD.
> + *
> + * Unlike a regular VM, KVM cannot set registers such as esp, eip, etc
> + * before boot, so to run selftests, these registers' values have to be
> + * initialized by the TD.
> + *
> + * This struct is loaded in TD private memory at TD_BOOT_PARAMETERS_GPA.
> + *
> + * The TD boot code will read off parameters from this struct and set up the
> + * vCPU for executing selftests.
> + *
> + * __packed is used since the offsets are hardcoded in td_boot.S
Same as above for "__packed".

> + */
>
[...]

