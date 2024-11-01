Return-Path: <linux-kselftest+bounces-21306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9C69B95F2
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 17:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C651C20958
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 16:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900611C9DE5;
	Fri,  1 Nov 2024 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PCk7D6/X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B681CA81;
	Fri,  1 Nov 2024 16:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730480185; cv=none; b=Iq/AZrugbDcDrZScwSAd/j2quUAj+xi9SQZHf2ZfvMajiO13pl921lb7wuqNRwKEjzP82Q3SWh6BVN4dIc/yNeSNyPX8tjKBI5yI9jtRjTdWW7mPjDiXLGbQ0njKopxPDIvQu3j9r6mmeqURMQZ7nM/guSWSAhEimi8qeL4sdko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730480185; c=relaxed/simple;
	bh=KmcSGZZTBepw/haBxjfNfgGPXnl3daZOBZVZzzq5xe4=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=Fk0ljucdrdtRL3rhaYIE/c4hLceyFDWYfzvcXPWK//4f6fJus2LK9I6XyDBZBYZ3BrozDnprQ/tZB8nymIARIK9EFgS9PmnHo5CzVAYfGEDSxCQUuLH0pJzWUH9Hd7vGcZ4kKGgKUJs1hkfiSmoTC/wq8s/HxlWunPUUyCpseXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=PCk7D6/X; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730480183; x=1762016183;
  h=message-id:date:mime-version:to:cc:references:subject:
   from:in-reply-to:content-transfer-encoding;
  bh=KmcSGZZTBepw/haBxjfNfgGPXnl3daZOBZVZzzq5xe4=;
  b=PCk7D6/Xsej0yYJGNbxAPA+qHiAKeCt3/rm3MZKcin/UJ4i9Xlw8usDF
   74YFiJIFV5pNWSgyXDidK4xnYBMdbXIg7Bbaex4VP8vHcUtep44nGDNTK
   hbuSj1UrFzhta5y4XhmMB438agIqZasDU0cgObqoRmZjBjNpEUpR6dMam
   A=;
X-IronPort-AV: E=Sophos;i="6.11,250,1725321600"; 
   d="scan'208";a="381765496"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 16:56:22 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:55997]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.72:2525] with esmtp (Farcaster)
 id 6a9142ea-5ddd-46d3-9d40-2688c563fdd9; Fri, 1 Nov 2024 16:56:21 +0000 (UTC)
X-Farcaster-Flow-ID: 6a9142ea-5ddd-46d3-9d40-2688c563fdd9
Received: from EX19D003UWC002.ant.amazon.com (10.13.138.169) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 1 Nov 2024 16:56:20 +0000
Received: from [192.168.208.156] (10.106.101.42) by
 EX19D003UWC002.ant.amazon.com (10.13.138.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 1 Nov 2024 16:56:17 +0000
Message-ID: <7bd627df-0303-4ded-b8c8-ceb84fb20f0d@amazon.com>
Date: Fri, 1 Nov 2024 09:56:12 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <dave.hansen@intel.com>
CC: <ackerleytng@google.com>, <agordeev@linux.ibm.com>,
	<aou@eecs.berkeley.edu>, <borntraeger@linux.ibm.com>, <bp@alien8.de>,
	<catalin.marinas@arm.com>, <chenhuacai@kernel.org>, <corbet@lwn.net>,
	<dave.hansen@linux.intel.com>, <david@redhat.com>, <derekmn@amazon.com>,
	<gerald.schaefer@linux.ibm.com>, <gor@linux.ibm.com>, <graf@amazon.com>,
	<hca@linux.ibm.com>, <hpa@zytor.com>, <jgowans@amazon.com>,
	<jthoughton@google.com>, <kalyazin@amazon.com>, <kernel@xen0n.name>,
	<kvm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<luto@kernel.org>, <mathieu.desnoyers@efficios.com>, <mhiramat@kernel.org>,
	<mingo@redhat.com>, <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
	<pbonzini@redhat.com>, <peterz@infradead.org>, <quic_eberman@quicinc.com>,
	<rostedt@goodmis.org>, <roypat@amazon.co.uk>, <rppt@kernel.org>,
	<seanjc@google.com>, <shuah@kernel.org>, <svens@linux.ibm.com>,
	<tabba@google.com>, <tglx@linutronix.de>, <vannapurve@google.com>,
	<will@kernel.org>, <x86@kernel.org>, <xmarcalx@amazon.com>,
	<mlipp@amazon.at>, <canellac@amazon.at>, <elena.reshetova@intel.com>
References: <784d1522-0451-4844-a334-8b7d49019437@intel.com>
Subject: Re: [RFC PATCH v3 0/6] Direct Map Removal for guest_memfd
Content-Language: en-US
From: "Manwaring, Derek" <derekmn@amazon.com>
In-Reply-To: <784d1522-0451-4844-a334-8b7d49019437@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D003UWC002.ant.amazon.com (10.13.138.169)

+Elena

On 2024-11-01 at 16:06+0000, Dave Hansen wrote:
> On 10/31/24 17:10, Manwaring, Derek wrote:
> > TDX and SEV encryption happens between the core and main memory, so
> > cached guest data we're most concerned about for transient execution
> > attacks isn't necessarily inaccessible.
> >
> > I'd be interested what Intel, AMD, and other folks think on this, but I
> > think direct map removal is worthwhile for CoCo cases as well.
>
> I'm not sure specifically which attacks you have in mind.  [...]
>
> I _think_ you might be thinking of attacks like MDS where some random
> microarchitectural buffer contains guest data after a VM exit and then
> an attacker extracts it.  Direct map removal doesn't affect these
> buffers and doesn't mitigate an attacker getting the data out.

Right, the only attacks we can thwart with direct map removal are
transient execution attacks on the host kernel whose leak origin is
"Mapped memory" in Table 1 of the Quarantine paper [2]. Maybe the
simplest hypothetical to consider here is a new spectre v1 gadget in the
host kernel.

> The main thing I think you want to keep in mind is mentioned in the "TDX
> Module v1.5 Base Architecture Specification"[1]:
>
> > Any software except guest TD or TDX module must not be able to
> > speculatively or non-speculatively access TD private memory,
>
> That's a pretty broad claim and it involves mitigations in hardware and
> the TDX module.
>
> 1. https://cdrdv2.intel.com/v1/dl/getContent/733575

Thank you, I hadn't seen that. That is a very strong claim as far as
preventing speculative access; I didn't realize Intel claimed that about
TDX. The comma followed by "to detect if a prior corruption attempt was
successful" makes me wonder a bit if the statement is not quite as broad
as it sounds, but maybe that's just meant to relate it to the integrity
section?

> If the attack is mitigated when the > data is _mapped_, then it's
> certainly not possible _unmapped_.
>
> So why bother with direct map removal for TDX?  A VMM write to TD
> private data causes machine checks.  So any kernel bug that even
> accidentally writes to kernel memory can bring the whole system down.
> Not nice.

Fair enough. It hasn't been clear to me if there is a machine check when
the host kernel accesses guest memory only transiently. I was assuming
there is not. But if other mitigations completely prevent even
speculative access of TD private memory like you're saying, then agree
nothing to gain from direct map removal in the TDX case.

Derek


[2] https://download.vusec.net/papers/quarantine_raid23.pdf

