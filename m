Return-Path: <linux-kselftest+bounces-19012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB84990185
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 12:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6079528292A
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 10:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC18B155C8A;
	Fri,  4 Oct 2024 10:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="oR3Of1Wf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469B01553AF;
	Fri,  4 Oct 2024 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728038694; cv=none; b=VTC1qoZVdqikqieLCW9evSw9D+A3mMBVJAMoYqmYk6XPEniGeJAALueCmfJEu6BVKYS/Br9LaOWAdK4SNnRflaInxw89umRUy1LcJMWfzJTQ11Mc4vCUorUmfc/G7Zt+d9MS7UM325IwNnrFXUyT7d66TEbmzxBE772d4NUA3p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728038694; c=relaxed/simple;
	bh=pPE4/I601JrMIy+XM5295Vjl31RBUgIJ/rXqcSjo5c4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nlK6slzXIppXnp3zt4ZxM0EL3EXGaRtu2UADOLpoF4kyIQUIMMmnImmsNzhsEP0hM0DWtgUlMB5wutdzqD/fhfepEPL8IXH7ni+tGC4sN+rU5jm8XNe0nsv11n6Kj74OK/ENAQYcXSldnGNvjHbH6+T1IDJQRibRlZzvJfjKQE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=oR3Of1Wf; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1728038694; x=1759574694;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pPE4/I601JrMIy+XM5295Vjl31RBUgIJ/rXqcSjo5c4=;
  b=oR3Of1Wf3HEo0dnwjdj9QbOoKLlal8JmUjY1VqjmajiWOso5ovkldN2a
   nW3HSKi2u16NPX0mCuCfjeOhqn2MYK1icoyhHtZwgINDo1LHvqJKtIGZM
   dJkftOs02UjrtQ1EUALedb+9lnWyUkHF1IzVWw2JMVw2OxvCyZwR/u/Me
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,177,1725321600"; 
   d="scan'208";a="372905230"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 10:44:44 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:37237]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.45.76:2525] with esmtp (Farcaster)
 id 1351fef0-1ef8-4c2c-b61d-a56b05783d23; Fri, 4 Oct 2024 10:44:42 +0000 (UTC)
X-Farcaster-Flow-ID: 1351fef0-1ef8-4c2c-b61d-a56b05783d23
Received: from EX19D041EUB003.ant.amazon.com (10.252.61.118) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 10:44:41 +0000
Received: from [10.95.86.80] (10.95.86.80) by EX19D041EUB003.ant.amazon.com
 (10.252.61.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Fri, 4 Oct 2024
 10:44:35 +0000
Message-ID: <3208be2b-7e9f-413b-a9dc-c36ef4e3d177@amazon.de>
Date: Fri, 4 Oct 2024 12:44:30 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] KVM: x86: Introduce new ioctl KVM_TRANSLATE2
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
CC: Nicolas Saenz Julienne <nsaenz@amazon.com>, Alexander Graf
	<graf@amazon.de>, James Gowans <jgowans@amazon.com>,
	<nh-open-source@amazon.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <kvmarm@lists.linux.dev>,
	<kvm-riscv@lists.infradead.org>, Nikolas Wipper <nik.wipper@gmx.de>
References: <20240910152207.38974-1-nikwip@amazon.de>
From: Nikolas Wipper <nikwip@amazon.de>
Content-Language: en-US
In-Reply-To: <20240910152207.38974-1-nikwip@amazon.de>
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D041EUB003.ant.amazon.com (10.252.61.118)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SSBzYXcgdGhpcyBvbiBhbm90aGVyIHNlcmllc1sqXToKCj4gaWYgS1ZNX1RSQU5TTEFURTIgbGFu
ZHMgKHRob3VnaCBJJ20gc29tZXdoYXQgY3VyaW91cyBhcyB0byB3aHkgUUVNVSBkb2Vzbid0IGRv
Cj4gdGhlIHBhZ2Ugd2Fsa3MgaXRzZWxmKS4KClRoZSBzaW1wbGUgcmVhc29uIGZvciBrZWVwaW5n
IHRoaXMgZnVuY3Rpb25hbGl0eSBpbiBLVk0sIGlzIHRoYXQgaXQgYWxyZWFkeQpoYXMgYSBtYXR1
cmUsIHByb2R1Y3Rpb24tbGV2ZWwgcGFnZSB3YWxrZXIgKHdoaWNoIGlzIGFscmVhZHkgZXhwb3Nl
ZCkgYW5kCmNyZWF0aW5nIHNvbWV0aGluZyBzaW1pbGFyIFFFTVUgd291bGQgdGFrZSBhIGxvdCBs
b25nZXIgYW5kIHdvdWxkIGJlIG11Y2gKaGFyZGVyIHRvIG1haW50YWluIHRoYW4ganVzdCBjcmVh
dGluZyBhbiBBUEkgdGhhdCBsZXZlcmFnZXMgdGhlIGV4aXN0aW5nCndhbGtlci4KClsqXSBodHRw
czovL2xvcmUua2VybmVsLm9yZy9sa21sL1p2SnNlVm9UN2dOX0dCRzNAZ29vZ2xlLmNvbS9ULyNt
YjBiMjNhMWY1MDIzMTkyYTQ0MmRiNGExNjYyOWQ5Y2E3NGViNmI1ZQoKcHM6IHRoaXMgaXMgYWxz
byBhIGdlbnRsZSBwaW5nIGZvciByZXZpZXcsIGlmIHRoaXMgZ290IGxvc3QgaW4gYmV0d2Vlbgpj
b25mZXJlbmNlcwoKCgpBbWF6b24gV2ViIFNlcnZpY2VzIERldmVsb3BtZW50IENlbnRlciBHZXJt
YW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzog
Q2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dl
cmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDI1Nzc2NCBCClNpdHo6IEJlcmxpbgpVc3Qt
SUQ6IERFIDM2NSA1MzggNTk3Cg==


