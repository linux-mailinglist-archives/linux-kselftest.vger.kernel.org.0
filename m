Return-Path: <linux-kselftest+bounces-19475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C858999263
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 21:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03F2BB23714
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 19:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE861CB528;
	Thu, 10 Oct 2024 19:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Rt9yiVke"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AFE199FA2;
	Thu, 10 Oct 2024 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728588436; cv=none; b=dOdlnEAVl65Sf3ajTLMXnNkAOD7kUu7QCSqjVa4ooaN8FR8qw5KGXRR+8zpjFedLSS1ihEvJAuY1Ijiitl6WG0mes+KhwIjhsod2zpWzM34UEQM+5ACI9GJFjmn2Cb501nM1jFRRaaBaQW9R1F+PVLJasxlU1pClhIjFEiITG2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728588436; c=relaxed/simple;
	bh=OEH00vqI9ntRyA4QhbqwFD2+B7TmPgXstqQdwdzNaqg=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=QWP9VkPvLxhbNtfNIhumbEZPt94wk2iRCgp9hW3dIvMFDiHWVEQ8ZZ0wuGyXNfiJbbCJY7u7xKBRtB241bSS0dKljlah2cPGM0k2tv0PgWVcgF8flAE3N2cvM+Y/jt5DlJXFTADQOTDyMi62SZY44GBWkVRXuM4iEmD7otBLpCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Rt9yiVke; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728588434; x=1760124434;
  h=message-id:date:mime-version:to:cc:references:subject:
   from:in-reply-to:content-transfer-encoding;
  bh=OEH00vqI9ntRyA4QhbqwFD2+B7TmPgXstqQdwdzNaqg=;
  b=Rt9yiVkedjhe9I8qUO1Ug5fu4aUxlJ07mCwLapCqDEQg1szsHJAmkJ7s
   VdlfGeDvIerxR7pHljqDAo/Olferm8+iiakfFE3hzoeVB/qXs+VBo3I02
   sxC88pbitrxUBRDkdEtzwPfR77WsHwNTAZ1nKbYhh9YtAHFqmxe9lWxk2
   0=;
X-IronPort-AV: E=Sophos;i="6.11,193,1725321600"; 
   d="scan'208";a="137549306"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 19:27:14 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:4948]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.26:2525] with esmtp (Farcaster)
 id f363ef87-207c-439a-bf2e-f001afa02b30; Thu, 10 Oct 2024 19:27:13 +0000 (UTC)
X-Farcaster-Flow-ID: f363ef87-207c-439a-bf2e-f001afa02b30
Received: from EX19D003UWC002.ant.amazon.com (10.13.138.169) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 10 Oct 2024 19:27:13 +0000
Received: from [192.168.208.61] (10.106.101.38) by
 EX19D003UWC002.ant.amazon.com (10.13.138.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 10 Oct 2024 19:27:10 +0000
Message-ID: <7aca068b-5332-41b4-a06d-fd21b4a715f9@amazon.com>
Date: Thu, 10 Oct 2024 12:27:09 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <roypat@amazon.co.uk>
CC: <ackerleytng@google.com>, <ajones@ventanamicro.com>,
	<anup@brainfault.org>, <bfoster@redhat.com>, <brauner@kernel.org>,
	<david@redhat.com>, <derekmn@amazon.com>, <erdemaktas@google.com>,
	<fan.du@intel.com>, <fvdl@google.com>, <haibo1.xu@intel.com>,
	<isaku.yamahata@intel.com>, <jgg@nvidia.com>, <jgowans@amazon.com>,
	<jhubbard@nvidia.com>, <jthoughton@google.com>, <jun.miao@intel.com>,
	<kalyazin@amazon.co.uk>, <kent.overstreet@linux.dev>, <kvm@vger.kernel.org>,
	<linux-fsdevel@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>,
	<maciej.wieczor-retman@intel.com>, <mike.kravetz@oracle.com>,
	<muchun.song@linux.dev>, <oliver.upton@linux.dev>, <pbonzini@redhat.com>,
	<peterx@redhat.com>, <pgonda@google.com>, <pvorel@suse.cz>,
	<qperret@google.com>, <quic_eberman@quicinc.com>,
	<richard.weiyang@gmail.com>, <rientjes@google.com>, <rppt@kernel.org>,
	<seanjc@google.com>, <shuah@kernel.org>, <tabba@google.com>,
	<vannapurve@google.com>, <vkuznets@redhat.com>, <willy@infradead.org>,
	<zhiquan1.li@intel.com>, <mlipp@amazon.at>, <canellac@amazon.at>,
	<dave.hansen@linux.intel.com>, <andrew.cooper3@citrix.com>
References: <6bca3ad4-3eca-4a75-a775-5f8b0467d7a3@amazon.co.uk>
Subject: Re: [RFC PATCH 30/39] KVM: guest_memfd: Handle folio preparation for
 guest_memfd mmap
Content-Language: en-US
From: "Manwaring, Derek" <derekmn@amazon.com>
In-Reply-To: <6bca3ad4-3eca-4a75-a775-5f8b0467d7a3@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D037UWC003.ant.amazon.com (10.13.139.231) To
 EX19D003UWC002.ant.amazon.com (10.13.138.169)

On 2024-10-10 at 16:21+0000 Patrick Roy wrote:
> On Tue, 2024-10-08 at 20:56 +0100, Sean Christopherson wrote:
> > Another (slightly crazy) approach would be use protection keys to provide the
> > security properties that you want, while giving KVM (and userspace) a quick-and-easy
> > override to access guest memory.
> >
> >  1. mmap() guest_memfd into userpace with RW protections
> >  2. Configure PKRU to make guest_memfd memory inaccessible by default
> >  3. Swizzle PKRU on-demand when intentionally accessing guest memory
> >
> > It's essentially the same idea as SMAP+STAC/CLAC, just applied to guest memory
> > instead of to usersepace memory.
> >
> > The benefit of the PKRU approach is that there are no PTE modifications, and thus
> > no TLB flushes, and only the CPU that is access guest memory gains temporary
> > access.  The big downside is that it would be limited to modern hardware, but
> > that might be acceptable, especially if it simplifies KVM's implementation.
>
> Mh, but we only have 16 protection keys, so we cannot give each VM a
> unique one. And if all guest memory shares the same protection key, then
> during the on-demand swizzling the CPU would get access to _all_ guest
> memory on the host, which "feels" scary. What do you think, @Derek?

Yes I am concerned about this. I don't see a way to use protection keys
that would ensure the host kernel cannot be tricked by one guest into
speculatively accessing another guest's memory (unless we do a key per
vm, which like you say severely limits how many guests you can host).

> Does ARM have something equivalent, btw?

Yes - Permission Overlay Extension [1]. Although even the most recent
parts don't offer it. I don't see it in Neoverse V3 or Cortex-X4.

Derek


[1] https://lore.kernel.org/all/20240822151113.1479789-1-joey.gouly@arm.com/

