Return-Path: <linux-kselftest+bounces-44371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1473EC1E044
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 02:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72A03BA341
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 01:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C128F271441;
	Thu, 30 Oct 2025 01:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Acx1vqk9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16963191F84;
	Thu, 30 Oct 2025 01:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761787550; cv=none; b=Q9LAteYUscLv3h1j4YdrcwwBnTH3ndGKBB8TrfHlwCxUqhGGYHMJVujs1vdY8O0NPHeRIgR3IZmBaOubVAy2Y+rMkz/lMejr87b7YlZW14dXGjfghb0kiVJKQ4sly10tdPf1RV/KsGf98sPIALLYYwTunygzzgPsAsfrhbg8tjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761787550; c=relaxed/simple;
	bh=N1XMjIY9XiIMspK3xF3I+zcw+mnUFCha7e56GhA53Hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZf12paByIyHdi5vOZGO0UdSC4s8ZU6gSkJ8Y00TC7ZK+eaXavZRUegcQa3ydyuWc47fJWAN58hOr7TZaz3IY1DrFYztRwOILdkDgeflYOi4kVzq3yahGrTIZnOJ9+EH3jE6qoI03E/mR8C+DPmqXjr5ZuoW1chIBfNaCBmimqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Acx1vqk9; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761787548; x=1793323548;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N1XMjIY9XiIMspK3xF3I+zcw+mnUFCha7e56GhA53Hg=;
  b=Acx1vqk9c5UTZd+arWCUJNDfPNkGJ369XCGlyLQ6Fy4V63DLXUAoH/fb
   aH3F+1GnsyTsq3q087DG23gQGIwq5dYru8Zi26i1BMRT4bhAsukOzvkkl
   y9n6lBepZe7HVwCpDtNuPVEFyaAC9ThGM6IV6M0ecAicmwtqHe7CsQug7
   lVR8sLgTecLJWTIwC3f0Gh3XhYwlipoInM88qpkP6ZFk0pPzMWXinyaej
   ruVtEtAx+kZ5EdsscWEUAYruv8f0qjMYT+7qJqK7xWXiSvdD7QX7NITOl
   BB7VF42CAF1D57ZU0cv5qnCw9ha1UAs145FJTqXJzfXHlmQ/s2QUIM5ja
   Q==;
X-CSE-ConnectionGUID: rr7kGRaBTTeoEMEC2apsaQ==
X-CSE-MsgGUID: N7YGb5ELQuqot28qGq/hVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="51495012"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="51495012"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 18:25:46 -0700
X-CSE-ConnectionGUID: iRxmnvCLQEyAbS4E5lKMjw==
X-CSE-MsgGUID: XuLgyv3RSBKyCP7EZOxIeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="185073620"
Received: from yinghaoj-desk.ccr.corp.intel.com (HELO [10.238.1.225]) ([10.238.1.225])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 18:25:41 -0700
Message-ID: <fc4360cd-ac5a-476e-8561-f6e3e990bd09@linux.intel.com>
Date: Thu, 30 Oct 2025 09:25:39 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 12/23] KVM: selftests: Add helper to initialize TDX VM
To: Sagi Shahar <sagis@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
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
 Chenyi Qiang <chenyi.qiang@intel.com>
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-13-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20251028212052.200523-13-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/29/2025 5:20 AM, Sagi Shahar wrote:
> KVM_TDX_INIT_VM needs to be called after KVM_CREATE_VM and before
> creating any VCPUs, thus before KVM_SET_CPUID2. KVM_TDX_INIT_VM accepts
> the CPUID values directly.
This sentence seems not accurate.
KVM_TDX_INIT_VM, i.e. the seamcall TDH.MNG.INIT, allows only directly
configurable CPUID bits to be 1.

>
> Since KVM_GET_CPUID2 can't be used at this point,

I don't think this is relevant.

As mentioned above, only directly configurable CPUID bits can be 1, so the
CPUIDs input for KVM_TDX_INIT_VM should be filtered against the supported
directly configurable CPUID bits.

>   calculate the CPUID
> values manually by using kvm_get_supported_cpuid() and filter the
> returned CPUIDs against the supported CPUID values read from the TDX

supported CPUID -> supported configurable CPUID

> module.
>
>
[...]

