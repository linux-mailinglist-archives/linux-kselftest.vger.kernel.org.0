Return-Path: <linux-kselftest+bounces-21319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDF79B989C
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 20:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727781F24BA8
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 19:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171A11D5AB6;
	Fri,  1 Nov 2024 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qUlMG2rG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC8C1D3624;
	Fri,  1 Nov 2024 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489375; cv=none; b=IDDo+HRGl4voe4nJRjXLiK2n+zmwLS2XMm5kcqUKPwhn7C79TGzuURhLda8s43rOY82bF73/rRnEiawfbgZz5X+eBS35q0KHefnKPrLfWGNx6odRzcada0+QIJo9oIg7SU98Wckqpp5NQQr5LGBH1kpvszwWjJQrip31eFM4zwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489375; c=relaxed/simple;
	bh=NjClUgMgjMVgsWcpgKIDByy4IpAOZ+8mqyCzWaNAYPY=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=qZzb5G9q73nawQ46Dmc72lbr+eF83bczc8GAozsoCeXBBuVB4HcZTbBoO5HdWLQZUXJk6em6heA+7/nm4K+TGrdAY4/Jg6nBm03WQm2HF+zZ94pHoSynJdrXABbPYX4GTYUMptbqvLwurnDnYey/aGmSam0iGLodPvw+gcjpjaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qUlMG2rG; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730489373; x=1762025373;
  h=message-id:date:mime-version:to:cc:references:subject:
   from:in-reply-to:content-transfer-encoding;
  bh=NjClUgMgjMVgsWcpgKIDByy4IpAOZ+8mqyCzWaNAYPY=;
  b=qUlMG2rGHtevMsFv/QioebdbXtzs0FYMASu8+bXlBC8zWGtD5VO5KPOG
   +gCncqin707RV0fImbtfJ/uF8/+XdalaoeH5R+phCexXly63NwjuRj60Y
   gxJyeXAXYRNgCMmU5HjMpW/zQ/3THPekndQJiZcVcZ3Pto8gLO348FsGM
   0=;
X-IronPort-AV: E=Sophos;i="6.11,250,1725321600"; 
   d="scan'208";a="1341371"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 19:29:33 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:29829]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.158:2525] with esmtp (Farcaster)
 id 9b6a62cb-9bef-4c52-ac7f-cb4c542891d8; Fri, 1 Nov 2024 19:29:32 +0000 (UTC)
X-Farcaster-Flow-ID: 9b6a62cb-9bef-4c52-ac7f-cb4c542891d8
Received: from EX19D003UWC002.ant.amazon.com (10.13.138.169) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 1 Nov 2024 19:29:32 +0000
Received: from [192.168.8.242] (10.106.101.33) by
 EX19D003UWC002.ant.amazon.com (10.13.138.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 1 Nov 2024 19:29:28 +0000
Message-ID: <71e9b2c8-0cc4-4646-88f0-7780e108e610@amazon.com>
Date: Fri, 1 Nov 2024 12:29:23 -0700
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
	<canellac@amazon.at>, <catalin.marinas@arm.com>, <chenhuacai@kernel.org>,
	<corbet@lwn.net>, <dave.hansen@linux.intel.com>, <david@redhat.com>,
	<derekmn@amazon.com>, <elena.reshetova@intel.com>,
	<gerald.schaefer@linux.ibm.com>, <gor@linux.ibm.com>, <graf@amazon.com>,
	<hca@linux.ibm.com>, <hpa@zytor.com>, <jgowans@amazon.com>,
	<jthoughton@google.com>, <kalyazin@amazon.com>, <kernel@xen0n.name>,
	<kvm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<luto@kernel.org>, <mathieu.desnoyers@efficios.com>, <mhiramat@kernel.org>,
	<mingo@redhat.com>, <mlipp@amazon.at>, <palmer@dabbelt.com>,
	<paul.walmsley@sifive.com>, <pbonzini@redhat.com>, <peterz@infradead.org>,
	<quic_eberman@quicinc.com>, <rostedt@goodmis.org>, <roypat@amazon.co.uk>,
	<rppt@kernel.org>, <seanjc@google.com>, <shuah@kernel.org>,
	<svens@linux.ibm.com>, <tabba@google.com>, <tglx@linutronix.de>,
	<vannapurve@google.com>, <will@kernel.org>, <x86@kernel.org>,
	<xmarcalx@amazon.com>
References: <d467e6bd-c673-415f-8bb0-91603f06498a@intel.com>
Subject: Re: [RFC PATCH v3 0/6] Direct Map Removal for guest_memfd
Content-Language: en-US
From: "Manwaring, Derek" <derekmn@amazon.com>
In-Reply-To: <d467e6bd-c673-415f-8bb0-91603f06498a@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D042UWB003.ant.amazon.com (10.13.139.135) To
 EX19D003UWC002.ant.amazon.com (10.13.138.169)

On 2024-11-01 at 18:43+0000, Dave Hansen wrote:
> On 11/1/24 11:31, Manwaring, Derek wrote:
> > From that standpoint I'm still tempted to turn the question around a bit
> > for the host kernel's perspective. Like if the host kernel should not
> > (and indeed cannot with TDX controls in place) access guest private
> > memory, why not remove it from the direct map?
>
> Pretend that the machine check warts aren't there.
>
> It costs performance and complexity, for an only theoretical gain.  This
> is especially true for a VMM that's not doing a just doing confidential
> guests.  You fracture the direct map to pieces forever (for now).

I'm hopeful we'll navigate the complexity in a worthwhile way for the
non-CoCo case. Assuming we get there and have the option to remove from
direct map, users with CoCo hardware could choose if they want to do
both on their host. For me that's a sensible choice, but maybe that's
just me.

As far as performance, are you talking about just the fracturing or
something beyond that? The data Mike brought to LSFMMBPF 2023 showed the
perf impact from direct map fragmentation for memfd_secret isn't "that
bad" [1].

Derek


[1] https://lwn.net/Articles/931406/

