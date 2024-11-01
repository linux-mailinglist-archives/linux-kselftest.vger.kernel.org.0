Return-Path: <linux-kselftest+bounces-21265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3347A9B8781
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 01:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58F4282A85
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 00:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7823810F4;
	Fri,  1 Nov 2024 00:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PBjMG6r+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A4B36B;
	Fri,  1 Nov 2024 00:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730419823; cv=none; b=ohBMag/8VrfoIZZpvC7QIXXq/5ThxSIGuYjwulu9W4CMMBICfkrI3BRXjdV+2qhBuENK0NgiUgQW/Fq623M8azVaMBXwQcUO7owdfsyRW7QoBJ9RVLS2Ok+gw1Qo4ndHWmGPyOw8oLuH7ndL7hJAFHjzDwk1elip9n5OEG00UF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730419823; c=relaxed/simple;
	bh=jNxyG945mWZFitSBBl3P/Pi37LkMXgLexJ4MyYO00SI=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=niixt4GDyZOaJhLQPm4WH6TUz/iGLymPsIiqnMMwkr3oEasE63SYBaAD30riYeO5lnyXCttuSITXLioQDk0mnya7nO+KkmegbuIHntXgrul3q502Qu7oyVhhu8s5OI6LujHvZGtJnEO+O3msCZSCsI3gbeS9x5gQvY4dhkdXB4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=PBjMG6r+; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730419818; x=1761955818;
  h=message-id:date:mime-version:to:cc:references:subject:
   from:in-reply-to:content-transfer-encoding;
  bh=jNxyG945mWZFitSBBl3P/Pi37LkMXgLexJ4MyYO00SI=;
  b=PBjMG6r+2XgemzvXNiRS/nOv26MvOljajnGdveYrMBpmA1MwWUkwdHpn
   0LAz0d39k1fVkEsQ+H8ilkocCRFpfEwi+SBZJtFtHrCuccr/i2HbIrzNC
   Vzn1knGOIQtMoIqaIKI4RHXVOWTcnEdhNS/r/bhbu2U1Xe/JRt25G52Hl
   o=;
X-IronPort-AV: E=Sophos;i="6.11,248,1725321600"; 
   d="scan'208";a="381598034"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 00:10:17 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:3117]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.158:2525] with esmtp (Farcaster)
 id 9403627f-3ea8-485f-95a8-ff158371f477; Fri, 1 Nov 2024 00:10:16 +0000 (UTC)
X-Farcaster-Flow-ID: 9403627f-3ea8-485f-95a8-ff158371f477
Received: from EX19D003UWC002.ant.amazon.com (10.13.138.169) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 1 Nov 2024 00:10:15 +0000
Received: from [192.168.20.174] (10.106.101.30) by
 EX19D003UWC002.ant.amazon.com (10.13.138.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 1 Nov 2024 00:10:12 +0000
Message-ID: <2233397c-f423-40e3-8546-728b50ce0489@amazon.com>
Date: Thu, 31 Oct 2024 17:10:11 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <roypat@amazon.co.uk>
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
	<rostedt@goodmis.org>, <rppt@kernel.org>, <seanjc@google.com>,
	<shuah@kernel.org>, <svens@linux.ibm.com>, <tabba@google.com>,
	<tglx@linutronix.de>, <vannapurve@google.com>, <will@kernel.org>,
	<x86@kernel.org>, <xmarcalx@amazon.com>
References: <27646c08-f724-49f7-9f45-d03bad500219@amazon.co.uk>
Subject: Re: [RFC PATCH v3 0/6] Direct Map Removal for guest_memfd
Content-Language: en-US
From: "Manwaring, Derek" <derekmn@amazon.com>
In-Reply-To: <27646c08-f724-49f7-9f45-d03bad500219@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D003UWC002.ant.amazon.com (10.13.138.169)

On 2024-10-31 at 10:42+0000 Patrick Roy wrote:
> On Thu, 2024-10-31 at 09:50 +0000, David Hildenbrand wrote:
> > On 30.10.24 14:49, Patrick Roy wrote:
> >> Most significantly, I've reduced the patch series to focus only on
> >> direct map removal for guest_memfd for now, leaving the whole "how to do
> >> non-CoCo VMs in guest_memfd" for later. If this separation is
> >> acceptable, then I think I can drop the RFC tag in the next revision
> >> (I've mainly kept it here because I'm not entirely sure what to do with
> >> patches 3 and 4).
> >
> > Hi,
> >
> > keeping upcoming "shared and private memory in guest_memfd" in mind, I
> > assume the focus would be to only remove the direct map for private memory?
> >
> > So in the current upstream state, you would only be removing the direct
> > map for private memory, currently translating to "encrypted"/"protected"
> > memory that is inaccessible either way already.
> >
> > Correct?
>
> Yea, with the upcomming "shared and private" stuff, I would expect the
> the shared<->private conversions would call the routines from patch 3 to
> restore direct map entries on private->shared, and zap them on
> shared->private.
>
> But as you said, the current upstream state has no notion of "shared"
> memory in guest_memfd, so everything is private and thus everything is
> direct map removed (although it is indeed already inaccessible anyway
> for TDX and friends. That's what makes this patch series a bit awkward
> :( )

TDX and SEV encryption happens between the core and main memory, so
cached guest data we're most concerned about for transient execution
attacks isn't necessarily inaccessible.

I'd be interested what Intel, AMD, and other folks think on this, but I
think direct map removal is worthwhile for CoCo cases as well.

Derek

