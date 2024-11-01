Return-Path: <linux-kselftest+bounces-21314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E089B978B
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 19:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CCFB283A8E
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 18:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC5D1A76C7;
	Fri,  1 Nov 2024 18:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="eCAhZMbj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF61A146592;
	Fri,  1 Nov 2024 18:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730485880; cv=none; b=pIYomHORwYEI9SiEnfS6jdUwwmIBP3xZeK71ocDAY3Un/zLv6YOSmzROwq+tN12uQFluB4GxjlLI756HNXuGuS+FLpY3RGkd/FetX2t9aJopXb7AZzx6LiRGpomyU0vIreLotMyNNj60MMuUMJoDFSG7l05Mnxoea55Rz7SafUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730485880; c=relaxed/simple;
	bh=VBXbIFvMdAI0b5axWwLGdBXRoBbolCT6d2ZfYFcgkm4=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=eoZwB+eV71tk5QqFs6PCGXJCgsKWn3L1T0vnoxMDjbA76LJOrckRAy0tbzq1whHgioXBSWwxLWuUDKtGiTsAASZUnjntd5u+V+0jcCyZlI4xPcEAh9xBoxnu1d5pSWKzvu7FcBsMXh74mMbH/fS4/87mxNOgNM2kYXPsvN8Ok/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=eCAhZMbj; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730485878; x=1762021878;
  h=message-id:date:mime-version:to:cc:references:subject:
   from:in-reply-to:content-transfer-encoding;
  bh=VBXbIFvMdAI0b5axWwLGdBXRoBbolCT6d2ZfYFcgkm4=;
  b=eCAhZMbjCsb1Ubg5PIF0neLVul3DHRNBD4YRpV/5j/xrdj+lEIZiS04b
   DhYuyza5iscJnNXF103HVVzmUFPjzwETJuL4RiFO8nRdj0Xlan2TeqLmt
   ZTNjpjkM/yKJFh2Zi84tkjV2yLQVOQkLoYFN9OOxiH5sVoeot3iWUMVfh
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,250,1725321600"; 
   d="scan'208";a="142665536"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 18:31:18 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:58862]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.72:2525] with esmtp (Farcaster)
 id dae0559c-5720-41e8-8da6-e0592ac6ae3b; Fri, 1 Nov 2024 18:31:17 +0000 (UTC)
X-Farcaster-Flow-ID: dae0559c-5720-41e8-8da6-e0592ac6ae3b
Received: from EX19D003UWC002.ant.amazon.com (10.13.138.169) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 1 Nov 2024 18:31:17 +0000
Received: from [10.142.234.83] (10.142.234.83) by
 EX19D003UWC002.ant.amazon.com (10.13.138.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 1 Nov 2024 18:31:14 +0000
Message-ID: <37fbfc65-b145-4a22-a48c-1921204d5635@amazon.com>
Date: Fri, 1 Nov 2024 11:31:09 -0700
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
References: <51fe5ad1-7057-4d43-b92c-580d187d2aeb@intel.com>
Subject: Re: [RFC PATCH v3 0/6] Direct Map Removal for guest_memfd
Content-Language: en-US
From: "Manwaring, Derek" <derekmn@amazon.com>
In-Reply-To: <51fe5ad1-7057-4d43-b92c-580d187d2aeb@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D003UWC002.ant.amazon.com (10.13.138.169)

On 2024-11-01 at 17:20+0000, Dave Hansen wrote:
> On 11/1/24 09:56, Manwaring, Derek wrote:
> > But if other mitigations completely prevent even speculative access
> > of TD private memory like you're saying, then agree nothing to gain
> > from direct map removal in the TDX case.
> Remember, guest unmapping is done in the VMM.  The VMM is not trusted in
> the TDX (or SEV-SNP) model.  If any VMM can harm the protections on
> guest memory, then we have a big problem.
>
> That isn't to say big problem can't happen.  Say some crazy attack comes
> to light where the VMM can attack TDX if the VMM has mapping for a guest
> (or TDX module) memory.  Crazier things have happened, and guest
> unmapping _would_ help there, if you trusted the VMM.
>
> Basically, I think guest unmapping only helps system security as a whole
> if you must _already_ trust the VMM.

Yeah that makes a lot of sense. I just view the ideal outcome as a
composition of strong, independent defenses. So as a guest you have the
confidentiality and integrity guarantees of the hardware, *and* you have
an up-to-date, good-hygiene (albeit not attested) host kernel just in
case some crazy attack/gap comes up.

From that standpoint I'm still tempted to turn the question around a bit
for the host kernel's perspective. Like if the host kernel should not
(and indeed cannot with TDX controls in place) access guest private
memory, why not remove it from the direct map?

Derek

