Return-Path: <linux-kselftest+bounces-19314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352EB995E57
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 05:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670E51C2182E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 03:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB19076048;
	Wed,  9 Oct 2024 03:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Kcw6IMDh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54B910FF;
	Wed,  9 Oct 2024 03:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728445884; cv=none; b=Ux4wh6UJOMOGtSgI/Loh1cZffxxry0AH0UHQCtuY/zMN4jtX3cPJcLCHx6ijjl/LraRQNpzAXy3UvFtvXiN4EEHewBQbNH9sc3il4SnRuyaoVjFr1M4hdTe1nq8BMKgwQDrX2vsTnk05lVE1an1hVoBCWicr8nKrfnE5z9890/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728445884; c=relaxed/simple;
	bh=Fz6m3s5wR0Xe7bKylBUoyAUXiZbhWI4E69+DbXptgGU=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=GajoB/BzpYM91vzjiwUbzcv4LnUlOAh2SUzT2qHcBnEOHEn1Y6iaGjHDu1FCOTXfsPtmJQbDo/XjYMqQZnBIQNlaIrxqS1vb8jHzcm/6m3PAPUzKEFwaQAy2b1UnsPTHALY+bzVU7fw6jDC4Mnhdap4mMeD3K+TGWz7LfFN+7lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Kcw6IMDh; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728445883; x=1759981883;
  h=message-id:date:mime-version:to:cc:references:subject:
   from:in-reply-to:content-transfer-encoding;
  bh=Fz6m3s5wR0Xe7bKylBUoyAUXiZbhWI4E69+DbXptgGU=;
  b=Kcw6IMDh+CAWZNPpmwpzpu0AgleuTw6KPrzkTeBh+BcC4ICy6nq0JXQl
   1EzaMHcxVYrGdCQSVVTwxbEvwkPn5hSWTh1SSkwcsTXLuH5dcJ8Jsh0dB
   3+sg+PovgioDKfHosHKNOzOPeycMbmpMoASjEuctTVjbXYUOywnSD2oZ1
   A=;
X-IronPort-AV: E=Sophos;i="6.11,188,1725321600"; 
   d="scan'208";a="433642865"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 03:51:19 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:59909]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.199:2525] with esmtp (Farcaster)
 id acf9dcc9-ae36-4c0e-a2a8-553270007ea0; Wed, 9 Oct 2024 03:51:18 +0000 (UTC)
X-Farcaster-Flow-ID: acf9dcc9-ae36-4c0e-a2a8-553270007ea0
Received: from EX19D003UWC002.ant.amazon.com (10.13.138.169) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 9 Oct 2024 03:51:18 +0000
Received: from [192.168.205.151] (10.106.100.42) by
 EX19D003UWC002.ant.amazon.com (10.13.138.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 9 Oct 2024 03:51:14 +0000
Message-ID: <ac337485-f8ab-45a4-b223-eb846e21c762@amazon.com>
Date: Tue, 8 Oct 2024 20:51:13 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <seanjc@google.com>, <andrew.cooper3@citrix.com>,
	<dave.hansen@linux.intel.com>
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
	<richard.weiyang@gmail.com>, <rientjes@google.com>, <roypat@amazon.co.uk>,
	<rppt@kernel.org>, <shuah@kernel.org>, <tabba@google.com>,
	<vannapurve@google.com>, <vkuznets@redhat.com>, <willy@infradead.org>,
	<zhiquan1.li@intel.com>, <graf@amazon.de>, <mlipp@amazon.at>,
	<canellac@amazon.at>
References: <ZwWOfXd9becAm4lH@google.com>
Subject: Re: [RFC PATCH 30/39] KVM: guest_memfd: Handle folio preparation for
 guest_memfd mmap
Content-Language: en-US
From: "Manwaring, Derek" <derekmn@amazon.com>
In-Reply-To: <ZwWOfXd9becAm4lH@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
 EX19D003UWC002.ant.amazon.com (10.13.138.169)

On 2024-10-08 at 19:56+0000 Sean Christopherson wrote:
> Another (slightly crazy) approach would be use protection keys to provide the
> security properties that you want, while giving KVM (and userspace) a quick-and-easy
> override to access guest memory.
>
>  1. mmap() guest_memfd into userpace with RW protections
>  2. Configure PKRU to make guest_memfd memory inaccessible by default
>  3. Swizzle PKRU on-demand when intentionally accessing guest memory
>
> It's essentially the same idea as SMAP+STAC/CLAC, just applied to guest memory
> instead of to usersepace memory.
>
> The benefit of the PKRU approach is that there are no PTE modifications, and thus
> no TLB flushes, and only the CPU that is access guest memory gains temporary
> access.  The big downside is that it would be limited to modern hardware, but
> that might be acceptable, especially if it simplifies KVM's implementation.

Yeah this might be worth it if it simplifies significantly. Jenkins et
al. showed MPK worked for stopping in-process Spectre V1 [1]. While
future hardware bugs are always possible, the host kernel would still
offer better protection overall since discovery of additional Spectre
approaches and gadgets in the kernel is more likely (I think it's a
bigger surface area than hardware-specific MPK transient execution
issues).

Patrick, we talked about this a couple weeks ago and ended up focusing
on within-userspace protection, but I see keys can also be used to stop
kernel access like Andrew's project he mentioned during Dave's MPK
session at LPC [2]. Andrew, could you share that here?

It's not clear to me how reliably the kernel prevents its own access to
such pages. I see a few papers that warrant more investigation:

"we found multiple interfaces that Linux, by design, provides for
accessing process memory that ignore PKU domains on a page." [3]

"Though Connor et al. demonstrate that existing MPK protections can be
bypassed by using the kernel as a confused deputy, compelling recent
work indicates that MPK operations can be made secure." [4]

Dave and others, if you're aware of resources clarifying how strong the
boundaries are, that would be helpful.

Derek


[1] https://www.cs.dartmouth.edu/~sws/pubs/jas2020.pdf
[2] https://www.youtube.com/watch?v=gEUeMfrNH94&t=1028s
[3] https://www.usenix.org/system/files/sec20-connor.pdf
[4] https://ics.uci.edu/~dabrowsa/kirth-eurosys22-pkru.pdf

