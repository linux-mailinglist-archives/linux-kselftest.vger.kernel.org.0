Return-Path: <linux-kselftest+bounces-20532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723B59AE25A
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 12:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECB60B21A58
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 10:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5D61C07D9;
	Thu, 24 Oct 2024 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Y+rwlMVZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E318C1B6D02;
	Thu, 24 Oct 2024 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765171; cv=none; b=hU2jwIpyBzmS6AzXJ0lkUcLPwZH80yDf0je55jbrhJtmP48wHvhHuoxbwzQ7gL5dqKUwgzsDgOfbCNM7egQGhSRHrreMSotpbo7yrp0E9fQH0y6oRnM856lQiePKHZ2B9gRUwyfbDqhV/oLgpXW+w77s+4OIDqN1X854uxe7inI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765171; c=relaxed/simple;
	bh=UHPnd/RmwWjsz87iqUWh3lvKcTiUAtDVmPgtNadMkMs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rkQrIZ7PSuIxYQjzkkpZI3pM4/jE8jeZYg/sGWj1N41mKWbTChQ5aRmIYZWWh7d0piCmzuKZ1IMnKDkNVQw12Iazrrrx0UEZi6oPw28x1O1GPRqL86ruSbCC6FC0I/z9yWT/Je8AtT/eaCylArRCp7VPtKOfPlGpVWeutUHVqgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Y+rwlMVZ; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729765169; x=1761301169;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UHPnd/RmwWjsz87iqUWh3lvKcTiUAtDVmPgtNadMkMs=;
  b=Y+rwlMVZdjDOswsb5x+RDdbTJu09KpBuoRGfCUcODwf5nopyH0KPsPb+
   cpaCAj+0ZgAxXDlQaGVZqiQitLBKmWcmQ7YxZvh5Pn2Mrtb1tRnX8OrKm
   onL2USoOdidJ9Rp5stkgwAQAhau1So0mDf+ydgB3LM0sadZGLy/IToM2L
   I=;
X-IronPort-AV: E=Sophos;i="6.11,228,1725321600"; 
   d="scan'208";a="36013059"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 10:19:24 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:63417]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.44.110:2525] with esmtp (Farcaster)
 id b9aa5347-db27-4b20-bf53-5bf1446bd54e; Thu, 24 Oct 2024 10:19:23 +0000 (UTC)
X-Farcaster-Flow-ID: b9aa5347-db27-4b20-bf53-5bf1446bd54e
Received: from EX19D015EUB004.ant.amazon.com (10.252.51.13) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 24 Oct 2024 10:19:23 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D015EUB004.ant.amazon.com (10.252.51.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 24 Oct 2024 10:19:22 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1258.034; Thu, 24 Oct 2024 10:19:22 +0000
From: "Gowans, James" <jgowans@amazon.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Roy, Patrick"
	<roypat@amazon.co.uk>
CC: "ackerleytng@google.com" <ackerleytng@google.com>, "Graf (AWS), Alexander"
	<graf@amazon.de>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>
Subject: Re: [PATCH] kvm: selftest: fix noop test in guest_memfd_test.c
Thread-Topic: [PATCH] kvm: selftest: fix noop test in guest_memfd_test.c
Thread-Index: AQHbJfutSS0K4laRpUevt9XxbaVMKbKVsGYA
Date: Thu, 24 Oct 2024 10:19:22 +0000
Message-ID: <97a527916663b2f87c5ed2046637c2a8b27eb629.camel@amazon.com>
References: <20241024095956.3668818-1-roypat@amazon.co.uk>
In-Reply-To: <20241024095956.3668818-1-roypat@amazon.co.uk>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <137BD64EF82DB74CAC60C77CF5DEDF88@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDI0LTEwLTI0IGF0IDEwOjU5ICswMTAwLCBQYXRyaWNrIFJveSB3cm90ZToNCj4g
VGhlIGxvb3AgaW4gdGVzdF9jcmVhdGVfZ3Vlc3RfbWVtZmRfaW52YWxpZCB0aGF0IGlzIHN1cHBv
c2VkIHRvIHRlc3QNCj4gdGhhdCBub3RoaW5nIGlzIGFjY2VwdGVkIGFzIGEgdmFsaWQgZmxhZyB0
byBLVk1fQ1JFQVRFX0dVRVNUX01FTUZEIHdhcw0KPiBpbml0aWFsaXppbmcgYGZsYWdgIGFzIDAg
aW5zdGVhZCBvZiBCSVQoMCkuIFRoaXMgY2F1c2VkIHRoZSBsb29wIHRvDQo+IGltbWVkaWF0ZWx5
IGV4aXQgaW5zdGVhZCBvZiBpdGVyYXRpbmcgb3ZlciBCSVQoMCksIEJJVCgxKSwgLi4uIC4NCj4g
DQo+IEZpeGVzOiA4YTg5ZWZkNDM0MjMgKCJLVk06IHNlbGZ0ZXN0czogQWRkIGJhc2ljIHNlbGZ0
ZXN0IGZvciBndWVzdF9tZW1mZCgpIikNCj4gU2lnbmVkLW9mZi1ieTogUGF0cmljayBSb3kgPHJv
eXBhdEBhbWF6b24uY28udWs+DQo+IC0tLQ0KPiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3Zt
L2d1ZXN0X21lbWZkX3Rlc3QuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2t2bS9ndWVzdF9tZW1mZF90ZXN0LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9r
dm0vZ3Vlc3RfbWVtZmRfdGVzdC5jDQo+IGluZGV4IGJhMGM4ZTk5NjAzNTguLmNlNjg3ZjhkMjQ4
ZmMgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS9ndWVzdF9tZW1m
ZF90ZXN0LmMNCj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL2d1ZXN0X21lbWZk
X3Rlc3QuYw0KPiBAQCAtMTM0LDcgKzEzNCw3IEBAIHN0YXRpYyB2b2lkIHRlc3RfY3JlYXRlX2d1
ZXN0X21lbWZkX2ludmFsaWQoc3RydWN0IGt2bV92bSAqdm0pDQo+ICAJCQkgICAgc2l6ZSk7DQo+
ICAJfQ0KPiAgDQo+IC0JZm9yIChmbGFnID0gMDsgZmxhZzsgZmxhZyA8PD0gMSkgew0KPiArCWZv
ciAoZmxhZyA9IEJJVCgwKTsgZmxhZzsgZmxhZyA8PD0gMSkgew0KPiAgCQlmZCA9IF9fdm1fY3Jl
YXRlX2d1ZXN0X21lbWZkKHZtLCBwYWdlX3NpemUsIGZsYWcpOw0KPiAgCQlURVNUX0FTU0VSVChm
ZCA9PSAtMSAmJiBlcnJubyA9PSBFSU5WQUwsDQo+ICAJCQkgICAgImd1ZXN0X21lbWZkKCkgd2l0
aCBmbGFnICcweCVseCcgc2hvdWxkIGZhaWwgd2l0aCBFSU5WQUwiLA0KDQpSZXZpZXdlZC1ieTog
SmFtZXMgR293YW5zIDxqZ293YW5zQGFtYXpvbi5jb20+DQo=

