Return-Path: <linux-kselftest+bounces-21545-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 263DB9BF3DF
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 18:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D22121F23744
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 17:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B852064EF;
	Wed,  6 Nov 2024 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MntEmEzy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01B1205129;
	Wed,  6 Nov 2024 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912679; cv=none; b=iEaIwImkcDkn7WKRZfQOfrrtszIWx0BhRlh1FnMI2GfJhO6LGlxSEANmqtlNgiX5Ggj7Mv836gIPHV1vBnDQWlw3JvIKS1mYP0xycWLuauHEAmkDAwn+MkH0G/BwM/t8D4QNWkNF4WDKOL3KT6TKMLmu0EHW/j8dtnA6BzhIWj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912679; c=relaxed/simple;
	bh=45lm7teIJIgBDhR6WrM3tTb7cS3pi+iWOg5nbyI7j9s=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=P2OEFf0qVj99/zSGe16l3AyuSQa44eD07dZ4inQQMexq5SEUgEqmvYUFjgiafvqgCH7j5X0eKvWf4lhokwtJYRQT4ijrRtMSnikwFqdGjotLlupaFvH6xnWm6wkGbqj5pkNNW87xBEnmpBdvOSdKNa5YJJu5+TdR+fvZU4g7OAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=MntEmEzy; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730912678; x=1762448678;
  h=message-id:date:mime-version:to:cc:references:subject:
   from:in-reply-to:content-transfer-encoding;
  bh=45lm7teIJIgBDhR6WrM3tTb7cS3pi+iWOg5nbyI7j9s=;
  b=MntEmEzy4eKV8WMoKuJyil3cfPrevzWF7DEZpYXiDmtvyRiVc3D0lwNW
   ltL3Lns9qmLFg6rgQLjlCj/B5cFfgGCN9ZF1r7ioMv3dg8jIP3mmlK7KS
   QWFogHx/Gy/w/k1wiJjArCiCCfT24P0eAjEY0ovMHoIJZNO9D0petJvvj
   o=;
X-IronPort-AV: E=Sophos;i="6.11,263,1725321600"; 
   d="scan'208";a="2538545"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 17:04:38 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:42869]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.42:2525] with esmtp (Farcaster)
 id 18efcd76-237c-46fb-afb1-2dbc7d25b1d1; Wed, 6 Nov 2024 17:04:37 +0000 (UTC)
X-Farcaster-Flow-ID: 18efcd76-237c-46fb-afb1-2dbc7d25b1d1
Received: from EX19D003UWC002.ant.amazon.com (10.13.138.169) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 6 Nov 2024 17:04:37 +0000
Received: from [192.168.12.4] (10.187.171.30) by EX19D003UWC002.ant.amazon.com
 (10.13.138.169) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35; Wed, 6 Nov 2024
 17:04:34 +0000
Message-ID: <7ad5d114-3d19-4c33-bb3c-7f8940ad114e@amazon.com>
Date: Wed, 6 Nov 2024 10:04:27 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <elena.reshetova@intel.com>
CC: <ackerleytng@google.com>, <agordeev@linux.ibm.com>,
	<aou@eecs.berkeley.edu>, <borntraeger@linux.ibm.com>, <bp@alien8.de>,
	<canellac@amazon.at>, <catalin.marinas@arm.com>, <chenhuacai@kernel.org>,
	<corbet@lwn.net>, <dave.hansen@intel.com>, <dave.hansen@linux.intel.com>,
	<david@redhat.com>, <derekmn@amazon.com>, <gerald.schaefer@linux.ibm.com>,
	<gor@linux.ibm.com>, <graf@amazon.com>, <hca@linux.ibm.com>, <hpa@zytor.com>,
	<jgowans@amazon.com>, <jthoughton@google.com>, <kalyazin@amazon.com>,
	<kernel@xen0n.name>, <kvm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <luto@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <mhiramat@kernel.org>, <mingo@redhat.com>,
	<mlipp@amazon.at>, <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
	<pbonzini@redhat.com>, <peterz@infradead.org>, <quic_eberman@quicinc.com>,
	<rostedt@goodmis.org>, <roypat@amazon.co.uk>, <rppt@kernel.org>,
	<seanjc@google.com>, <shuah@kernel.org>, <svens@linux.ibm.com>,
	<tabba@google.com>, <tglx@linutronix.de>, <vannapurve@google.com>,
	<will@kernel.org>, <x86@kernel.org>, <xmarcalx@amazon.com>
References: <DM8PR11MB57509ED04CB0730680735AC9E7512@DM8PR11MB5750.namprd11.prod.outlook.com>
Subject: RE: [RFC PATCH v3 0/6] Direct Map Removal for guest_memfd
Content-Language: en-US
From: "Manwaring, Derek" <derekmn@amazon.com>
In-Reply-To: <DM8PR11MB57509ED04CB0730680735AC9E7512@DM8PR11MB5750.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D003UWC002.ant.amazon.com (10.13.138.169)

On 2024-11-04 at 08:33+0000, Elena Reshetova wrote:
> This statement *is* for integrity section. We have a separate TDX guidance
> on side-channels (including speculative) [3] and some speculative attacks
> that affect confidentiality (for example spectre v1) are listed as not covered
> by TDX but remaining SW responsibility (as they are now).

Thanks for the additional info, Elena. Given that clarification, I
definitely see direct map removal and TDX as complementary.

Derek

