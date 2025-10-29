Return-Path: <linux-kselftest+bounces-44251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF776C188F7
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 07:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0A53834A25B
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 06:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64E130ACEC;
	Wed, 29 Oct 2025 06:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LVi7hKHx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550B91F4606;
	Wed, 29 Oct 2025 06:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761721076; cv=none; b=BmhG5y1if+FYrUeopjtHKX+8KhjaQ9yJWk+nozxTeJ0YfiwUWRtsdHqEMqB9mkJu+6yTZ16fQp2eGKAzwSdoUWrt007QugyH7k2ebxfD/Tlfv0oPA5RIrfjXwsBoZi4w+TX50VmQbmVKoVFkgz43g5/ubgsEy3+4izCLL7CK2l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761721076; c=relaxed/simple;
	bh=GRPJ23z2L3uMq7YCt/UEA/ttP3KePbP/XYQFWN9kbOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VfaLYeCA4aClrUjK8qboFNUmjLUr7WSYdeRUxG+r3Eav3icpZs9S55RXqdtYgejl89yWGnt0N9W7VZ54uYkLVygtigZLSq7LVfYc2Hm6qPv2d4Cu5pkGHQ80mZVrdYu/a6f/8KWe0t1CiQeVHttANuCL0BxuO0RSUVwLeDBC0fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LVi7hKHx; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761721074; x=1793257074;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GRPJ23z2L3uMq7YCt/UEA/ttP3KePbP/XYQFWN9kbOU=;
  b=LVi7hKHxz3qUjAzn+Zz+H6awRY8AFeFXbEoBQkjjkekO9O8CplBjBUva
   tFh29RcNyrv2YLUEf9/BFpcC711kX6H6IvW2c+HjHp0aSHulPyHsSUkzn
   P42Bsj/OGliGwjz4+Inrr+h5cTnQ4/dmk1FtdnQHJCFGzRlq6OBnZzoCO
   DIBgEgboANR+2/GmLSirqqlafg/1qzXu7PZ4d9oZsCnJbbzn5Bo+sFzS8
   tY1/18ZE6kj8pPaVDzgds91L2avp7pe/aFjXM6DNyw4fUArWjSQ8Hona7
   QUiDteUlLbNrNcS/vTdlYFlc6PjmvY33kbyuG1Evbu4Z96fZw6zFz4OXO
   w==;
X-CSE-ConnectionGUID: I+dJraKlQ+OAoxpEsA9ckw==
X-CSE-MsgGUID: oTN/HKKBSFWhGmxMs/A8DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="51405926"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="51405926"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 23:57:53 -0700
X-CSE-ConnectionGUID: RhYMO8kASxy1El5X2eLAvw==
X-CSE-MsgGUID: crDPbSVAQqmlx50EFFQecA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="190705190"
Received: from yinghaoj-desk.ccr.corp.intel.com (HELO [10.238.1.225]) ([10.238.1.225])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 23:57:49 -0700
Message-ID: <43e36e8a-5875-489c-8baa-9a9b589c000a@linux.intel.com>
Date: Wed, 29 Oct 2025 14:57:46 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 01/23] KVM: selftests: Add macros so simplify creating
 VM shapes for non-default types
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
 <20251028212052.200523-2-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20251028212052.200523-2-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/29/2025 5:20 AM, Sagi Shahar wrote:
> From: Sean Christopherson <seanjc@google.com>
>
> Add VM_TYPE() and __VM_TYPE() macros to create a vm_shape structure given
> a type (and mode), and use the macros to define VM_SHAPE_{SEV,SEV_ES,SNP}
> shapes for x86's SEV family of VM shapes.  Providing common infrastructure
> will avoid having to copy+paste vm_sev_create_with_one_vcpu() for TDX.
>
> Use the new SEV+ shapes and drop vm_sev_create_with_one_vcpu().
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>


