Return-Path: <linux-kselftest+bounces-22117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D859CF2C3
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 18:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B28B290B2D
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 17:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3924C1D618A;
	Fri, 15 Nov 2024 17:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="v1fzfTTl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696F2166307;
	Fri, 15 Nov 2024 17:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731691449; cv=none; b=KbG9bMmZ0ctPdjzSBJfOwZkF4htW3dVfIi1oos9zgHiXOhUf/5CZEoewVvGYwq+B8U5lQ+xuyInEFdz49CqejtzN/zHVo0n81fyD9jtiXu79hKzcFJJYvE19uqfGLh2q/pstThpf9WyLeb+0PXtfGfH1yVyLcXQzIFJ4x39fjCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731691449; c=relaxed/simple;
	bh=lEyWvGX0JG+Yw319+gafXH1ELjZoKnONXw/B9hTbf6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NaGOdLh6HTV/hxI2GHaeQ/0rMvidvdSwV8IDUAA+fH51YmgZ0LIK7TCjfDsxOHPSMzcsp6WdMwzo3GzMtdrTg4zejFTPn6psLQWSUUUF1ihKbVbHrE+U8IeM4Qle9lZvqxO1cUx2DRJPF+gIy8j4v5qE+ACHz4h7JrWlC57mAMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=v1fzfTTl; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1731691448; x=1763227448;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Bk0JymAs/OEj+UcEvmUanxee/ezdfeE24i85gdC/NwU=;
  b=v1fzfTTlLMnu2X5WPNwFdXUd4FV7OEHW4KP4gun3bkygP8S0+6gcKbdN
   QSD5K95IgXGpA8vvie3KAMk+oAVOQulG0xKJkitMjf2Qv8O+Ka7BoRhdu
   gIOT2ZkR5UMhMOJwYZypYGNcxAY8A9d7nGydqluZu3GrRXKqHBHwmIUs9
   o=;
X-IronPort-AV: E=Sophos;i="6.12,157,1728950400"; 
   d="scan'208";a="470536855"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 17:24:02 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:38135]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.223:2525] with esmtp (Farcaster)
 id 5ff6a4b3-184c-4e50-9e2d-e5baf28ad41c; Fri, 15 Nov 2024 17:24:01 +0000 (UTC)
X-Farcaster-Flow-ID: 5ff6a4b3-184c-4e50-9e2d-e5baf28ad41c
Received: from EX19D003UWB004.ant.amazon.com (10.13.138.24) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 15 Nov 2024 17:23:56 +0000
Received: from EX19MTAUWC002.ant.amazon.com (10.250.64.143) by
 EX19D003UWB004.ant.amazon.com (10.13.138.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 15 Nov 2024 17:23:56 +0000
Received: from email-imr-corp-prod-pdx-all-2b-a57195ef.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Fri, 15 Nov 2024 17:23:56 +0000
Received: from [127.0.0.1] (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-pdx-all-2b-a57195ef.us-west-2.amazon.com (Postfix) with ESMTPS id AE0FAA04A5;
	Fri, 15 Nov 2024 17:23:48 +0000 (UTC)
Message-ID: <81d14448-29eb-4496-b876-ef6de526a840@amazon.co.uk>
Date: Fri, 15 Nov 2024 17:23:47 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/6] Direct Map Removal for guest_memfd
To: David Hildenbrand <david@redhat.com>, <tabba@google.com>,
	<quic_eberman@quicinc.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<jthoughton@google.com>, <ackerleytng@google.com>, <vannapurve@google.com>,
	<rppt@kernel.org>
CC: <graf@amazon.com>, <jgowans@amazon.com>, <derekmn@amazon.com>,
	<kalyazin@amazon.com>, <xmarcalx@amazon.com>, <linux-mm@kvack.org>,
	<corbet@lwn.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <hca@linux.ibm.com>,
	<gor@linux.ibm.com>, <agordeev@linux.ibm.com>, <borntraeger@linux.ibm.com>,
	<svens@linux.ibm.com>, <gerald.schaefer@linux.ibm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <shuah@kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<faresx@amazon.com>
References: <20241030134912.515725-1-roypat@amazon.co.uk>
 <4aa0ccf4-ebbe-4244-bc85-8bc8dcd14e74@redhat.com>
 <27646c08-f724-49f7-9f45-d03bad500219@amazon.co.uk>
 <d1a69eb7-85d5-4ffa-88e2-f4841713c1d7@redhat.com>
 <90c9d8c0-814e-4c86-86ef-439cb5552cb6@amazon.co.uk>
 <10e4d078-3cdb-4d1c-a1a3-80e91b247217@redhat.com>
 <02f77d32-e2a1-431b-bb67-33d36c06acd3@amazon.co.uk>
 <f4c5d0a6-a582-44e3-8949-c199cc0bfba7@redhat.com>
 <f1f34ac0-d505-4982-aad9-86a0db9f4a35@amazon.co.uk>
 <dcdce8e1-51da-42da-a892-59c6ccd9de23@redhat.com>
From: Patrick Roy <roypat@amazon.co.uk>
Content-Language: en-US
Autocrypt: addr=roypat@amazon.co.uk; keydata=
 xjMEY0UgYhYJKwYBBAHaRw8BAQdA7lj+ADr5b96qBcdINFVJSOg8RGtKthL5x77F2ABMh4PN
 NVBhdHJpY2sgUm95IChHaXRodWIga2V5IGFtYXpvbikgPHJveXBhdEBhbWF6b24uY28udWs+
 wpMEExYKADsWIQQ5DAcjaM+IvmZPLohVg4tqeAbEAgUCY0UgYgIbAwULCQgHAgIiAgYVCgkI
 CwIEFgIDAQIeBwIXgAAKCRBVg4tqeAbEAmQKAQC1jMl/KT9pQHEdALF7SA1iJ9tpA5ppl1J9
 AOIP7Nr9SwD/fvIWkq0QDnq69eK7HqW14CA7AToCF6NBqZ8r7ksi+QLOOARjRSBiEgorBgEE
 AZdVAQUBAQdAqoMhGmiXJ3DMGeXrlaDA+v/aF/ah7ARbFV4ukHyz+CkDAQgHwngEGBYKACAW
 IQQ5DAcjaM+IvmZPLohVg4tqeAbEAgUCY0UgYgIbDAAKCRBVg4tqeAbEAtjHAQDkh5jZRIsZ
 7JMNkPMSCd5PuSy0/Gdx8LGgsxxPMZwePgEAn5Tnh4fVbf00esnoK588bYQgJBioXtuXhtom
 8hlxFQM=
In-Reply-To: <dcdce8e1-51da-42da-a892-59c6ccd9de23@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit



On Fri, 2024-11-15 at 17:10 +0000, David Hildenbrand wrote:
>> [...]
>>
>> I've talked to Fares internally, and it seems that generally doing
>> mm-local mappings of guest memory would work for us. We also figured out
>> what the "interrupt problem" is, namely that if we receive an interrupt
>> while executing in a context that has mm-local mappings available, those
>> mappings will continue to be available while the interrupt is being
>> handled.
> 
> Isn't that likely also the case with secretmem where we removed the
> directmap, but have an effective per-mm mapping in the (user-space
> portion) of the page table?

Mh, that's an excellent point, I never thought of that. But with
secretmem, the memory would still be protected by SMAP (admittedly, I
have no idea how much this is worth in the face of all these speculative
issues), right?

>> I'm talking to my security folks to see how much of a concern
>> this is for the speculation hardening we're trying to achieve. Will keep
>> you in the loop there :)
> 
> Thanks!
> 
> -- 
> Cheers,
> 
> David / dhildenb

Best,
Patrick

