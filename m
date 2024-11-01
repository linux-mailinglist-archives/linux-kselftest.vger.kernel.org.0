Return-Path: <linux-kselftest+bounces-21305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4579B94EF
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 17:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7A3B1F22468
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 16:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859471C830B;
	Fri,  1 Nov 2024 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E6ip0iLY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D281B4F2D;
	Fri,  1 Nov 2024 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730477244; cv=none; b=BNPpNX455tXkCaxCXt4PKdGVKMj+F42bGnRl00/+cWlt1Glo1LOtSeNekNtX1bZugU0YOAOnZbYs0neGNJnE5MKR34fdHvAinLqJGOsReqzoLQvRnFAPxLjhJiXHWCgWwi/t+67q1zqHq6tjcvdP2AQRFbrAPs0uDI2cM/ixO1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730477244; c=relaxed/simple;
	bh=RahQfZ/XUlkIuOR+dTOjhXIg4K5uTPhllesohsmYC0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hEcNbdeXFjAokGXeLXy3lIHvh+cTupHCSIfSD/XdLRGHpAPELhXcC9fjs1YAeLhTPxDIWUzQtI/eopeaZms9T2+gRpYabG8vcyQM/mNw7NiAXl3Jg3IYHyFaM6C/+tGiPFG3ax6aWVApYIYEXVSskj5t76RkUv8gNQk/ACTDA50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E6ip0iLY; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730477242; x=1762013242;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RahQfZ/XUlkIuOR+dTOjhXIg4K5uTPhllesohsmYC0M=;
  b=E6ip0iLYlwYwkAuW3I6l1TU7n4UOGQaZdbVVHkpLoZGq6iabFQ1yDuMW
   UJ4gnP30EF9tl9L+/pH2UX0Tx72kLy9yNOgvFIYT9ZoTj5F3jm+JA5cja
   7e/B59/Xc0HPLeVu/8FjmHRH0BXzmGG74A5hAywLSpam2C9r4h4dE9XNp
   rw6XQqkZs0tJlXGCtx1dFw8DutIRNKhqZEUDPo0hh+p3ypSD+Wd0dAiMS
   R/EDuBhm51Y9YjwdSY2hqx/Ji3Nh6LrfwvwX1MOEut8eSF+TE20g6tgpQ
   /8IRXgU/8pBfHInl3RmHLUAsjBgOV+AbQ5Q2LtRrPbaCOhUwYhRPSon9x
   g==;
X-CSE-ConnectionGUID: PV2JVaixRr+kq5c53ZLYrg==
X-CSE-MsgGUID: MyTPk73VTRWYKkMaaSSILA==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="30459858"
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="30459858"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 09:07:21 -0700
X-CSE-ConnectionGUID: 4dc8HIY5RT6JkqpGnUzUUg==
X-CSE-MsgGUID: fkeBRFMzSu6jXbNStoM6pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="83107022"
Received: from ccbilbre-mobl3.amr.corp.intel.com (HELO [10.124.220.146]) ([10.124.220.146])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 09:06:51 -0700
Message-ID: <784d1522-0451-4844-a334-8b7d49019437@intel.com>
Date: Fri, 1 Nov 2024 09:06:50 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/6] Direct Map Removal for guest_memfd
To: "Manwaring, Derek" <derekmn@amazon.com>, roypat@amazon.co.uk
Cc: ackerleytng@google.com, agordeev@linux.ibm.com, aou@eecs.berkeley.edu,
 borntraeger@linux.ibm.com, bp@alien8.de, catalin.marinas@arm.com,
 chenhuacai@kernel.org, corbet@lwn.net, dave.hansen@linux.intel.com,
 david@redhat.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
 graf@amazon.com, hca@linux.ibm.com, hpa@zytor.com, jgowans@amazon.com,
 jthoughton@google.com, kalyazin@amazon.com, kernel@xen0n.name,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 luto@kernel.org, mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
 mingo@redhat.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
 pbonzini@redhat.com, peterz@infradead.org, quic_eberman@quicinc.com,
 rostedt@goodmis.org, rppt@kernel.org, seanjc@google.com, shuah@kernel.org,
 svens@linux.ibm.com, tabba@google.com, tglx@linutronix.de,
 vannapurve@google.com, will@kernel.org, x86@kernel.org, xmarcalx@amazon.com
References: <27646c08-f724-49f7-9f45-d03bad500219@amazon.co.uk>
 <2233397c-f423-40e3-8546-728b50ce0489@amazon.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <2233397c-f423-40e3-8546-728b50ce0489@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/24 17:10, Manwaring, Derek wrote:
> TDX and SEV encryption happens between the core and main memory, so
> cached guest data we're most concerned about for transient execution
> attacks isn't necessarily inaccessible.
> 
> I'd be interested what Intel, AMD, and other folks think on this, but I
> think direct map removal is worthwhile for CoCo cases as well.

I'm not sure specifically which attacks you have in mind.  Also, don't
forget that TDX doesn't get any intra-system security from encryption
itself.  All that the encryption does is prevent some physical attacks.

The main thing I think you want to keep in mind is mentioned in the "TDX
Module v1.5 Base Architecture Specification"[1]:

> Any software except guest TD or TDX module must not be able to
> speculatively or non-speculatively access TD private memory,

That's a pretty broad claim and it involves mitigations in hardware and
the TDX module.

I _think_ you might be thinking of attacks like MDS where some random
microarchitectural buffer contains guest data after a VM exit and then
an attacker extracts it.  Direct map removal doesn't affect these
buffers and doesn't mitigate an attacker getting the data out.  TDX
relies on other defenses.

As for the CPU caches, direct map removal doesn't help or hurt anything.
 A malicious VMM would just map the guest data if it could and try to
extract it if that were possible.  If the attack is mitigated when the
data is _mapped_, then it's certainly not possible _unmapped_.

So why bother with direct map removal for TDX?  A VMM write to TD
private data causes machine checks.  So any kernel bug that even
accidentally writes to kernel memory can bring the whole system down.
Not nice.

1. https://cdrdv2.intel.com/v1/dl/getContent/733575

