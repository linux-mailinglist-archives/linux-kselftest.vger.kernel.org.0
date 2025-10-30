Return-Path: <linux-kselftest+bounces-44373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19087C1E226
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 03:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62E5B4E6182
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 02:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC5232A3C8;
	Thu, 30 Oct 2025 02:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P4FS+I0l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0237E32571E;
	Thu, 30 Oct 2025 02:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761791539; cv=none; b=tJqafaGgRaL34+DjDTswhDpirzEiR2ODbDpoVbktx5JOm3tOyslbs41idwJ82Eqb2QHr5NckmzHX1TZBaloBngGpEXQtkqKhqjQwWjf/A2a6VsQ/gulYrFmSSr+wOwBDcKP8Ofj0OB50aR3G9by+mBAIjZgnspTc0nAThmi2pdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761791539; c=relaxed/simple;
	bh=AsRZmcnko9an9X3hiGxxbz4TEtlRNH7py8FQbHxj0Rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hpEMiFrjFw6AMyPo81O2aQQWCXSA+kLcG8cCfc8B9fHz98xLFDe1uRmkjYiG+D5X+mgvKVb5iEHgLxV4p5Y9x8GGb9bYcWLHRS8d8f3GudFpUtKiJ/l4L8VFqkQ6hK5twXgA7RFg9u4hTSvNvHY/d9PeWWDIZSFjeDtxS9b+eto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P4FS+I0l; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761791537; x=1793327537;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AsRZmcnko9an9X3hiGxxbz4TEtlRNH7py8FQbHxj0Rk=;
  b=P4FS+I0lAk5glX/U7dCTbB0R8Vzk5RayvWxkRnwDeyZhRwr7kxHzjYjX
   NRK7hN34nninzrXQFerd5UqqqXNG70apNgyrJrx9OUrhBisig7MNyQCZT
   verzb2CwD5KsMPtW4bo9/VprbPBBEi6vRuv0QZh1e9wgLlbUlkZQYw3Aw
   LjO0WggU5GMt12f5aTsVHbwo6m2Fo3fSObgZva1zUI0MJQLXwr51Oogr8
   zhOTzXrsQzGnmcJXVXi2fYdms8CKIKCkK8bKUsniDQ35O3p/BTZm274eK
   /z7Do0AEFEdQxX+E9XTLf0bv5V2wH1fl+0bxrTJeNHlX8mVU97dfPg6AU
   A==;
X-CSE-ConnectionGUID: 5sbU5hrAQFKVmX96sN5+cg==
X-CSE-MsgGUID: SS/E2X7kSOOG+Gd2O6A1Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63625336"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="63625336"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 19:32:16 -0700
X-CSE-ConnectionGUID: fcnTKSNTS6S55PqSrqkHNw==
X-CSE-MsgGUID: jgGGiN5cR8ujUDjVfRd3Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="185083471"
Received: from yinghaoj-desk.ccr.corp.intel.com (HELO [10.238.1.225]) ([10.238.1.225])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 19:32:11 -0700
Message-ID: <c31cf2dc-b081-4adc-b227-a512f5d5a5bd@linux.intel.com>
Date: Thu, 30 Oct 2025 10:32:09 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 14/23] KVM: selftests: Add helpers to init TDX memory
 and finalize VM
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
 <20251028212052.200523-15-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20251028212052.200523-15-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/29/2025 5:20 AM, Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
>
> TDX protected memory needs to be measured and encrypted before it can be
> used by the guest. Traverse the VM's memory regions and initialize all
> the protected ranges by calling KVM_TDX_INIT_MEM_REGION.
>
> Once all the memory is initialized, the VM can be finalized by calling
> KVM_TDX_FINALIZE_VM.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Erdem Aktas <erdemaktas@google.com>
> Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> Co-developed-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>



