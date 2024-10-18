Return-Path: <linux-kselftest+bounces-20110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9499A36DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 09:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FEB41F20CD5
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 07:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0433918452C;
	Fri, 18 Oct 2024 07:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="YHwcHtWz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD3A17BB3D;
	Fri, 18 Oct 2024 07:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729235773; cv=none; b=tIIZsuLvcLEZfutydq4quwiM/LH5YB9QiqIIiGLYPPlEWF3o7VrVZ+6D1jVD2ClgI1MzxrtUD2OXWttD2ifneMbUG62cmmFIlr08+yzP9cRnHOoBO1TLnE4exGNvkNpsn9jT1639pBrjZh6JalhnP5Plqxl+reYqqhhUry15Rss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729235773; c=relaxed/simple;
	bh=/I2jPd9nSduN8OHMli2B/yA3LPpODA5B0rjgKrJzVCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZCg8QoNzDv59/jvSMIwDkPRJ2w83RSL1yFpHU2Mb3oTIrsO6XZxZfgoNRTDCCs2siDiV1Nv7bE9AfayKrYcYrdwqq39RnZQyUDr1QHibXoPPXZVEojc/UZjNnUsngvojNrs0s5Q6LdeFKs8kj/jVEvNarE2x2HA/tgAXKoNSyEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=YHwcHtWz; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1729235772; x=1760771772;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EKGqZ8hrRKP72OEOZhPQA++anSV7QH7ySNTRlQSCfpg=;
  b=YHwcHtWz6d7mFPsvV2B3/sBXVavy0mbU+qrJq668sGqzxtsPriCkppFE
   8Kl910JOOI0rMnnyTIbmgFEVCRatKuDaAqhm2AZoNN5Fkd7MSpuQfR3uu
   8HIwxywUSDXwq+uYWv0VhJopsYD2Al38MsXeW9lq9O+usjjf50XR1AMJO
   k=;
X-IronPort-AV: E=Sophos;i="6.11,213,1725321600"; 
   d="scan'208";a="344116877"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 07:16:06 +0000
Received: from EX19MTAUEC002.ant.amazon.com [10.0.29.78:36478]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.30.212:2525] with esmtp (Farcaster)
 id 8c358cbd-25f6-43e2-adc9-681e56bfb8f4; Fri, 18 Oct 2024 07:16:05 +0000 (UTC)
X-Farcaster-Flow-ID: 8c358cbd-25f6-43e2-adc9-681e56bfb8f4
Received: from EX19MTAUEB002.ant.amazon.com (10.252.135.47) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 18 Oct 2024 07:16:01 +0000
Received: from email-imr-corp-prod-pdx-all-2b-5ec155c2.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.135.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Fri, 18 Oct 2024 07:16:01 +0000
Received: from [127.0.0.1] (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-pdx-all-2b-5ec155c2.us-west-2.amazon.com (Postfix) with ESMTPS id ACFA640263;
	Fri, 18 Oct 2024 07:15:52 +0000 (UTC)
Message-ID: <2686a5ae-e1e5-48d6-ae4b-31face5284ca@amazon.co.uk>
Date: Fri, 18 Oct 2024 08:15:50 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 26/39] KVM: guest_memfd: Track faultability within a
 struct kvm_gmem_private
To: Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>
CC: David Hildenbrand <david@redhat.com>, Ackerley Tng
	<ackerleytng@google.com>, <tabba@google.com>, <quic_eberman@quicinc.com>,
	<rientjes@google.com>, <fvdl@google.com>, <jthoughton@google.com>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <zhiquan1.li@intel.com>,
	<fan.du@intel.com>, <jun.miao@intel.com>, <isaku.yamahata@intel.com>,
	<muchun.song@linux.dev>, <erdemaktas@google.com>, <vannapurve@google.com>,
	<qperret@google.com>, <jhubbard@nvidia.com>, <willy@infradead.org>,
	<shuah@kernel.org>, <brauner@kernel.org>, <bfoster@redhat.com>,
	<kent.overstreet@linux.dev>, <pvorel@suse.cz>, <rppt@kernel.org>,
	<richard.weiyang@gmail.com>, <anup@brainfault.org>, <haibo1.xu@intel.com>,
	<ajones@ventanamicro.com>, <vkuznets@redhat.com>,
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
In-Reply-To: <20241017191829.GA3559746@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit



On Thu, 2024-10-17 at 20:18 +0100, Jason Gunthorpe wrote:
> On Thu, Oct 17, 2024 at 03:11:10PM -0400, Peter Xu wrote:
>> On Thu, Oct 17, 2024 at 02:10:10PM -0300, Jason Gunthorpe wrote:
>>>> If so, maybe that's a non-issue for non-CoCo, where the VM object /
>>>> gmemfd object (when created) can have a flag marking that it's
>>>> always shared and can never be converted to private for any page
>>>> within.
>>>
>>> What is non-CoCo? Does it include the private/shared concept?
>>
>> I used that to represent the possible gmemfd use cases outside confidential
>> computing.
>>
>> So the private/shared things should still be around as fundamental property
>> of gmemfd, but it should be always shared and no convertion needed for the
>> whole lifecycle of the gmemfd when marked !CoCo.
> 
> But what does private mean in this context?
> 
> Is it just like a bit of additional hypervisor security that the page
> is not mapped anyplace except the KVM stage 2 and the hypervisor can
> cause it to become mapped/shared at any time? But the guest has no
> idea about this?
> 
> Jason

Yes, this is pretty much exactly what I'm after when I say "non-CoCo".
No direct map entries to provide defense-in-depth for guests against
various speculative execution issues, but not a full confidential
computing setup (e.g. the guest should be completely oblivious to this,
and not require any modifications).

