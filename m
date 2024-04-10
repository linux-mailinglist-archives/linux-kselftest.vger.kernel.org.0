Return-Path: <linux-kselftest+bounces-7563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E7E89EFA7
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 12:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E8828527D
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 10:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7E4158206;
	Wed, 10 Apr 2024 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="i5qBhIEP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2926155737;
	Wed, 10 Apr 2024 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712744137; cv=none; b=X+kHfgKZ9c218yENLF9d+QFe1TdhRQwrkgpi3lFWscsa8G8f0I77lr7ePZu2Fh8b2nFuFGwwcsjCku33Wp6AANcldUqz9bjSnnjmZnKeKC3/wFBmhha807mB6pqlwQgqTFfqiGJrHMryOxKsFmvy8jpca0z+JVd50EDXQiYBUj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712744137; c=relaxed/simple;
	bh=YC5mpI3zmUDjy80vR1JbXqLidS+Mq+LuGjUVGLaf+NY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=pGCRTpXEUt/GPbA6ndenSju7dZjzpNBDhjrtGk2eh3sLRi9SewgQyXHYWAz7LsHmKjpSpeXntw45TBP/3kjQqTadEnyvdZ5YaYl6rpqsVsPfF0jeGubetxPJsXk9Hqa1SV1HXP0YvBFq9snYdfJv758+Sb/Wc/PIdxSgFPtFYz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=i5qBhIEP; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1712744133; x=1744280133;
  h=from:to:cc:subject:date:message-id:in-reply-to:reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=YC5mpI3zmUDjy80vR1JbXqLidS+Mq+LuGjUVGLaf+NY=;
  b=i5qBhIEPOnQe4iL6q2UhWD4hLxpcf6C+3vEA1w8un/WPc0HSNdh4I2/6
   O+1RlZ2Pwextq6kidyrlpdnajEM3Ik0QhMdRtexZIQArccb+EGpLxrQY2
   FwSIEFe/w3pBW+ip1JOSNWxz6qdjwbzMgLtlUqbQNrWDJXr/otPoAnsG0
   M=;
X-IronPort-AV: E=Sophos;i="6.07,190,1708387200"; 
   d="scan'208";a="197624342"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 10:15:31 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:28828]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.25.48:2525] with esmtp (Farcaster)
 id 4757ae82-0365-4d6b-a303-bd85ff575e01; Wed, 10 Apr 2024 10:15:29 +0000 (UTC)
X-Farcaster-Flow-ID: 4757ae82-0365-4d6b-a303-bd85ff575e01
Received: from EX19D033EUC001.ant.amazon.com (10.252.61.132) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 10 Apr 2024 10:15:29 +0000
Received: from EX19D033EUC004.ant.amazon.com (10.252.61.133) by
 EX19D033EUC001.ant.amazon.com (10.252.61.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 10 Apr 2024 10:15:29 +0000
Received: from EX19D033EUC004.ant.amazon.com ([fe80::8359:4d84:fb19:f6e9]) by
 EX19D033EUC004.ant.amazon.com ([fe80::8359:4d84:fb19:f6e9%3]) with mapi id
 15.02.1258.028; Wed, 10 Apr 2024 10:15:29 +0000
From: "Allister, Jack" <jalliste@amazon.co.uk>
To: "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "shuah@kernel.org" <shuah@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "paul@xen.org"
	<paul@xen.org>, "bp@alien8.de" <bp@alien8.de>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"Allister, Jack" <jalliste@amazon.co.uk>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 2/2] KVM: selftests: Add KVM/PV clock selftest to prove
 timer drift correction
Thread-Topic: [PATCH 2/2] KVM: selftests: Add KVM/PV clock selftest to prove
 timer drift correction
Thread-Index: AQHaizADgCaxniBg/kihxnKaQcWS/w==
Date: Wed, 10 Apr 2024 10:15:29 +0000
Message-ID: <4f1ca4e1a8a9a31eae8057f9a813fc13d3172f77.camel@amazon.co.uk>
In-Reply-To: <9377995a-26a4-2523-e421-be1cd92bdc34@oracle.com>
Reply-To: "9377995a-26a4-2523-e421-be1cd92bdc34@oracle.com"
	<9377995a-26a4-2523-e421-be1cd92bdc34@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA4954794EA1A8499DCB60759E1D7EB2@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiBBRkFJUiwgSSBjb3BpZWQgY2hlY2tfY2xvY2tzb3VyY2UoKSBmcm9tIGV4aXN0aW5nIGNvZGUg
ZHVyaW5nIHRoYXQgPg0KdGltZS4NCg0KPiBUaGUgY29tbWl0IGU0NDBjNWYyZSAoIktWTTogc2Vs
ZnRlc3RzOiBHZW5lcmFsaXplIGNoZWNrX2Nsb2Nrc291cmNlKCkNCj4gZnJvbSBrdm1fY2xvY2tf
dGVzdCIpIGhhcyBpbnRyb2R1Y2VkIHN5c19jbG9ja3NvdXJjZV9pc190c2MoKS4gTGF0ZXINCj4g
aXQgaXMgcmVuYW1lZCB0byBzeXNfY2xvY2tzb3VyY2VfaXNfYmFzZWRfb25fdHNjKCkuDQo+IEFu
eSBjaGFuY2UgdG8gcmUtdXNlIHN5c19jbG9ja3NvdXJjZV9pc19iYXNlZF9vbl90c2MoKT8NCg0K
WWVzIEknbSBtb3JlIHRoYW4gaGFwcHkgdG8gY2hhbmdlIGl0IHRvIHRoYXQuIEkgd2FzIHVzaW5n
IHlvdXIgb3JpZ2luYWwNCm1haWwgYXMgYSByZWZlcmVuY2UgYW5kIGRpZCBub3QgcmVhbGlzZSB0
aGVyZSB3YXMgYSB1dGlsaXR5IHByZXNlbnQgZm9yDQp0aGlzLg0KDQo+IElzIGNvbmZpZ3VyZV9z
Y2FsZWRfdHNjKCkgYW5lY2Vzc2FyeT8gT3IgaG93IGFib3V0IHRvIG1ha2UgaXQgYW4gID4NCm9w
dGlvbi9hcmc/DQo+IFRoZW4gSSB3aWxsIGJlIGFibGUgdG8gdGVzdCBpdCBvbiBhIFZNL3NlcnZl
ciB3aXRob3V0IFRTQyBzY2FsaW5nLg0KDQpTbyBpZiBUU0Mgc2NhbGluZyBmcm9tIDNHSHogKGhv
c3QpIC0+IDEuNUdIeiAoZ3Vlc3QpIEkgZG8gc2VlIGEgc2tldyBvZg0KfjM1MDBucyBhZnRlciB0
aGUgdXBkYXRlLiBXaGVyZSBhcyB3aXRob3V0IHNjYWxpbmcgYSBkZWx0YSBjYW4gYmUgc2Vlbg0K
YnV0IGlzIHJvdWdobHkgfjE4MG5zLg0KDQpJbiBWMiBJJ3ZlIGFkanVzdGVkIHRoZSB0ZXN0IHNv
IHRoYXQgbm93IGJ5IGRlZmF1bHQgc2NhbGluZyB3b24ndCB0YWtlDQpwbGFjZSwgaG93ZXZlciBp
ZiBzb21lb25lIHdhbnRzIHRvIHRlc3Qgd2l0aCBpdCBlbmFibGVkIHRoZXkgY2FuIHBhc3MNCiIt
cy8tLXNjYWxlLXRzYyIgdG8gaW5kdWNlIHRoZSBncmVhdGVyIGRlbHRhLg0KDQoNClRoYW5rcyB5
b3UgZm9yIHRoZSBmZWVkYmFjaywNCkphY2sgQWxsaXN0ZXINCg0KDQoNCg==

