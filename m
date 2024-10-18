Return-Path: <linux-kselftest+bounces-20125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC629A3A16
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 11:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D0A28134E
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 09:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D12B1F472C;
	Fri, 18 Oct 2024 09:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="gBB1KtDd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEED9192B95;
	Fri, 18 Oct 2024 09:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729244100; cv=none; b=kCSgzI69FnesA7a4f0hw/buvPAZVOTa2Hy69hU02fN3k3TwDwkAERxJTUGUpssL25Un9d65aXpyOkHp5hzvZYi3iv16HBXZJcP+6OCsSiuogIlSrh9smi9c+bB+XFqXEW5jV1f/OqnJfdFp4PdFRAMYZP/n1fzvnugZRdk51sJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729244100; c=relaxed/simple;
	bh=+xQ5pEBdbDVjjALPMWPySdyGzngXUy9divuJUeAZ/Uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P6s8Ib5YMhmk5mO1gmgP3EgR0wKn/eMXRBpaNnxhkE1LtTQXJeNFq9i7wOZZwPefJU7TsBcHT4pBP9vLKgrpJ99Dn+VCjZRwW1bn35GCGGfHEmlldAw9HAqJXkPRl+hXaangK970aSiagmXGudu2bwyDV7UEXZrQVv1ZyP4YjkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=gBB1KtDd; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1729244098; x=1760780098;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BpK3TfvA/aJJBGezkvWLQTG+09sgEOAIsRn2y8OahHU=;
  b=gBB1KtDdp0CrY3wHcx3OJEEkStzz1tkf+voyw4q3aaCBRhlPCCcVMk8j
   ydL4mryV8TbAVICmS3UEVVFQ1zkbxdDODkKPEGRjK4LAPzfYuUeISEj3U
   LYG8U5w3Z22Up0udrvqFwaUbS7vt7OuO8htLexx1ReirDUkxcs+VcRpSA
   Q=;
X-IronPort-AV: E=Sophos;i="6.11,213,1725321600"; 
   d="scan'208";a="139152822"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 09:34:56 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:55009]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.23:2525] with esmtp (Farcaster)
 id e4886bcc-8a61-48fc-987b-7c7278cb980c; Fri, 18 Oct 2024 09:34:55 +0000 (UTC)
X-Farcaster-Flow-ID: e4886bcc-8a61-48fc-987b-7c7278cb980c
Received: from EX19EXOUWB001.ant.amazon.com (10.250.64.229) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 18 Oct 2024 09:34:51 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19EXOUWB001.ant.amazon.com (10.250.64.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 18 Oct 2024 09:34:49 +0000
Received: from email-imr-corp-prod-iad-all-1a-059220b4.us-east-1.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Fri, 18 Oct 2024 09:34:48 +0000
Received: from [127.0.0.1] (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-iad-all-1a-059220b4.us-east-1.amazon.com (Postfix) with ESMTPS id 688E44050D;
	Fri, 18 Oct 2024 09:34:44 +0000 (UTC)
Message-ID: <799e5861-c91c-4756-982c-033ebef476b4@amazon.co.uk>
Date: Fri, 18 Oct 2024 10:34:41 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 26/39] KVM: guest_memfd: Track faultability within a
 struct kvm_gmem_private
To: David Hildenbrand <david@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Peter Xu <peterx@redhat.com>
CC: Ackerley Tng <ackerleytng@google.com>, <tabba@google.com>,
	<quic_eberman@quicinc.com>, <rientjes@google.com>, <fvdl@google.com>,
	<jthoughton@google.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<zhiquan1.li@intel.com>, <fan.du@intel.com>, <jun.miao@intel.com>,
	<isaku.yamahata@intel.com>, <muchun.song@linux.dev>, <erdemaktas@google.com>,
	<vannapurve@google.com>, <qperret@google.com>, <jhubbard@nvidia.com>,
	<willy@infradead.org>, <shuah@kernel.org>, <brauner@kernel.org>,
	<bfoster@redhat.com>, <kent.overstreet@linux.dev>, <pvorel@suse.cz>,
	<rppt@kernel.org>, <richard.weiyang@gmail.com>, <anup@brainfault.org>,
	<haibo1.xu@intel.com>, <ajones@ventanamicro.com>, <vkuznets@redhat.com>,
	<maciej.wieczor-retman@intel.com>, <pgonda@google.com>,
	<oliver.upton@linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <1d243dde-2ddf-4875-890d-e6bb47931e40@redhat.com>
 <ZxAfET87vwVwuUfJ@x1n> <20241016225157.GQ3559746@nvidia.com>
 <ZxBRC-v9w7xS0xgk@x1n> <20241016235424.GU3559746@nvidia.com>
 <ZxEmFY1FcrRtylJW@x1n> <20241017164713.GF3559746@nvidia.com>
 <ZxFD3kYfKY0b-qFz@x1n> <20241017171010.GK3559746@nvidia.com>
 <ZxFhTtEs2Mz7Dj-O@x1n> <20241017191829.GA3559746@nvidia.com>
 <2686a5ae-e1e5-48d6-ae4b-31face5284ca@amazon.co.uk>
 <257d5578-f256-49cf-affe-6255ff224ed0@redhat.com>
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
In-Reply-To: <257d5578-f256-49cf-affe-6255ff224ed0@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit



On Fri, 2024-10-18 at 08:50 +0100, David Hildenbrand wrote:
> On 18.10.24 09:15, Patrick Roy wrote:
>>
>>
>> On Thu, 2024-10-17 at 20:18 +0100, Jason Gunthorpe wrote:
>>> On Thu, Oct 17, 2024 at 03:11:10PM -0400, Peter Xu wrote:
>>>> On Thu, Oct 17, 2024 at 02:10:10PM -0300, Jason Gunthorpe wrote:
>>>>>> If so, maybe that's a non-issue for non-CoCo, where the VM object /
>>>>>> gmemfd object (when created) can have a flag marking that it's
>>>>>> always shared and can never be converted to private for any page
>>>>>> within.
>>>>>
>>>>> What is non-CoCo? Does it include the private/shared concept?
>>>>
>>>> I used that to represent the possible gmemfd use cases outside confidential
>>>> computing.
>>>>
>>>> So the private/shared things should still be around as fundamental property
>>>> of gmemfd, but it should be always shared and no convertion needed for the
>>>> whole lifecycle of the gmemfd when marked !CoCo.
>>>
>>> But what does private mean in this context?
>>>
>>> Is it just like a bit of additional hypervisor security that the page
>>> is not mapped anyplace except the KVM stage 2 and the hypervisor can
>>> cause it to become mapped/shared at any time? But the guest has no
>>> idea about this?
>>>
>>> Jason
>>
>> Yes, this is pretty much exactly what I'm after when I say "non-CoCo".
> 
> It's likely not what Peter meant, though.
> 
> I think there are three scenarios:
> 
> (a) Secure CoCo VMs: private is protected by HW
> (b) Semi-secured non-CoCo VMs: private is removed from the directmap
> (c) Non-CoCo VMs: only shared memory
> 
> Does that match what you have in mind? Are there other cases?

Yeah, I'm after your case (b). I suppose I will not call it just
"non-CoCo" anymore then :)

> -- 
> Cheers,
> 
> David / dhildenb
> 

