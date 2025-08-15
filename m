Return-Path: <linux-kselftest+bounces-39041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AA0B276A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 05:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757C2A06026
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 03:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7625200113;
	Fri, 15 Aug 2025 03:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kF4AR4Hm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6D418C011;
	Fri, 15 Aug 2025 03:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755227728; cv=none; b=M1AoK895o51J6zdu8P7ftkTll8GkTADis3aEA5erh0m57QlSmjThX2c+cnvHbXRYKPwUpGDdgQvE134BilLrTKVX5D3ig2+cEc2BkD+Q569MWHFAsvZwVM1WsEWP9ckwtF6wyaiiraLxW6yWEcddOZKX+SS/eldRRabjBykzDtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755227728; c=relaxed/simple;
	bh=fC1mrUytUG74MKUNflCkOvX5lW6hkNqnNNZ7FyLjNIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hFqugJSGyaCYwBrg3ZJ8men8CprDvUpqM16idRKwq0ot5i+PBvlRtfu1R+uUqNdY9OkVaOqgMxEW8tu5zzzTAs5p/kKa7rKMn+oA2u+Jl+mlIilRlFRozKn1/C4hd95XmDST7ckdxBRZGi5tAG6WZJTFSDyNAQltxDA6Qw3C3w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kF4AR4Hm; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755227727; x=1786763727;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fC1mrUytUG74MKUNflCkOvX5lW6hkNqnNNZ7FyLjNIk=;
  b=kF4AR4HmpnP0KjgcbW6BuHcyyJ8+CKKyjFT/2a+aSkPEA+Dfg+2DbovR
   w5gebYf1D5mCRhl60Lrocs8MGW45TjVbWkwZAW74fNkY0uLMQ0TU6f4nB
   I7wod7D29H1Vo5TUed1YjbQhTSSNxArka77mPAnmBywA1RkgVHyBiBVfi
   opHhKkvgkQNiocrXn8hYSkzUxfvZV+A/D0IZNk0PyebwVeNZ8Fd6Kyh0k
   FjnE4PPJ3qnR8VXRWXuaj29a1L+204+01Tz9XvgomguMTw+Adsn7Rhklq
   d31q/4yWEAt8PJN2vu4tVbejRbPsWYt6HzXZmf+gnM8wBMiexua77rLSE
   A==;
X-CSE-ConnectionGUID: OjLVpetZRVWiitcFTxvUBg==
X-CSE-MsgGUID: 1xQXv2FtTVOr9WdEqygXNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="80134704"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="80134704"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 20:15:26 -0700
X-CSE-ConnectionGUID: gWE2MD7FSsO1FMn9GpkNvw==
X-CSE-MsgGUID: 7azx2Hb7QE2UY2Q4NI5dPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="166834945"
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 20:15:21 -0700
Message-ID: <8b76b1d7-edc9-4677-8069-a428e1067050@linux.intel.com>
Date: Fri, 15 Aug 2025 11:15:19 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 25/30] KVM: selftests: KVM: selftests: Expose new
 vm_vaddr_alloc_private()
To: Sean Christopherson <seanjc@google.com>, Sagi Shahar <sagis@google.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Ackerley Tng <ackerleytng@google.com>,
 Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 Erdem Aktas <erdemaktas@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roger Wang <runanwang@google.com>, Oliver Upton <oliver.upton@linux.dev>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Ira Weiny
 <ira.weiny@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20250807201628.1185915-1-sagis@google.com>
 <20250807201628.1185915-26-sagis@google.com> <aJpbhBO53ujqkbPT@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <aJpbhBO53ujqkbPT@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/12/2025 5:07 AM, Sean Christopherson wrote:
> On Thu, Aug 07, 2025, Sagi Shahar wrote:
>> From: Ackerley Tng <ackerleytng@google.com>
>>
>> vm_vaddr_alloc_private allow specifying both the virtual and physical
>> addresses for the allocation.
> Why?
>
Yeah, this is not needed.
vm_vaddr_alloc() will handle it as private memory by default if the vm has
protected memory.

