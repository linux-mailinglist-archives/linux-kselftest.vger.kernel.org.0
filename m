Return-Path: <linux-kselftest+bounces-16520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 227EB9623ED
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 11:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47CE61C23CEA
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 09:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8081667C7;
	Wed, 28 Aug 2024 09:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Bm7FCWRZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1968E156F4A;
	Wed, 28 Aug 2024 09:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724838619; cv=none; b=HSgrVwqEjDDEH3GynewqJkquC1JWe0uzhFX0CNBoaBde1d6ZoRP6kXCKqNEK8PgTzHzprCBIY9VthfRqQ06fXIW5ltMwZL+aV0gSavqc71Vw2zFgNaNerfJv8nc3bZ42VSbJHpuAD/H1FZl6ab4fsijhwz5jMifLISW2WODI2ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724838619; c=relaxed/simple;
	bh=2Q3jsDxS0W1bQLBmum7GleYuOyVX9tirrUuc/kx3/4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E4BdYzWsgGOxzWPvyWmE9gCBt+GLvKQN8zLYXGtceSiM48ig2nLX0p1db1228jYeAqMczTryclcFHY7t2zWRDD1umAsvmy4ZdrqxI0tqmwZu80HsuZPyfG90dlQEozyRufwu9hLBx6bj+Ee5pFIfQ7f+tdW0y20bWmtHS2zsP/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Bm7FCWRZ; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1724838618; x=1756374618;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2Q3jsDxS0W1bQLBmum7GleYuOyVX9tirrUuc/kx3/4M=;
  b=Bm7FCWRZ2DQrITUNqNdc8JTOIayzUmA6tUqrJPhn/UHDrkTV0zyEILeE
   Mq3nxkSs+R37EeUelavFEWzXyS6MTa1C6/QBtz6bJKC3pKtRDPsH/vlee
   JbZMQjFdXrjBS3Das8nbGr3wksK80oWz58XW2mzPrsHPsgK1O1ZoVuG0d
   w=;
X-IronPort-AV: E=Sophos;i="6.10,182,1719878400"; 
   d="scan'208";a="655304012"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 09:50:15 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:55612]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.160:2525] with esmtp (Farcaster)
 id ef5615f8-0011-4bb1-a4e7-b7ec4ba4ddd0; Wed, 28 Aug 2024 09:50:13 +0000 (UTC)
X-Farcaster-Flow-ID: ef5615f8-0011-4bb1-a4e7-b7ec4ba4ddd0
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 28 Aug 2024 09:50:13 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Wed, 28 Aug 2024
 09:50:10 +0000
Message-ID: <f2d6e44c-585f-460c-9d68-0be4d5fbe9fd@amazon.com>
Date: Wed, 28 Aug 2024 11:50:08 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] add support for mm-local memory allocations
To: Roman Kagan <rkagan@amazon.de>, <linux-kernel@vger.kernel.org>
CC: Shuah Khan <shuah@kernel.org>, Dragan Cvetic <dragan.cvetic@amd.com>,
	Fares Mehanna <faresx@amazon.de>, Alexander Graf <graf@amazon.de>, "Derek
 Kiernan" <derek.kiernan@amd.com>, <linux-kselftest@vger.kernel.org>,
	<nh-open-source@amazon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-mm@kvack.org>, David Woodhouse <dwmw@amazon.co.uk>, Andrew Morton
	<akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>
References: <20240621201501.1059948-1-rkagan@amazon.de>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20240621201501.1059948-1-rkagan@amazon.de>
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

SGV5IFJvbWFuLAoKT24gMjEuMDYuMjQgMjI6MTQsIFJvbWFuIEthZ2FuIHdyb3RlOgo+IEluIGEg
c2VyaWVzIHBvc3RlZCBhIGZldyB5ZWFycyBhZ28gWzFdLCBhIHByb3Bvc2FsIHdhcyBwdXQgZm9y
d2FyZCB0byBhbGxvdyB0aGUKPiBrZXJuZWwgdG8gYWxsb2NhdGUgbWVtb3J5IGxvY2FsIHRvIGEg
bW0gYW5kIHRodXMgcHVzaCBpdCBvdXQgb2YgcmVhY2ggZm9yCj4gY3VycmVudCBhbmQgZnV0dXJl
IHNwZWN1bGF0aW9uLWJhc2VkIGNyb3NzLXByb2Nlc3MgYXR0YWNrcy4gIFdlIHN0aWxsIGJlbGll
dmUKPiB0aGlzIGlzIGEgbmljZSB0aGluZyB0byBoYXZlLgo+Cj4gSG93ZXZlciwgaW4gdGhlIHRp
bWUgcGFzc2VkIHNpbmNlIHRoYXQgcG9zdCBMaW51eCBtbSBoYXMgZ3Jvd24gcXVpdGUgYSBmZXcg
bmV3Cj4gZ29vZGllcywgc28gd2UnZCBsaWtlIHRvIGV4cGxvcmUgcG9zc2liaWxpdGllcyB0byBp
bXBsZW1lbnQgdGhpcyBmdW5jdGlvbmFsaXR5Cj4gd2l0aCBsZXNzIGVmZm9ydCBhbmQgY2h1cm4g
bGV2ZXJhZ2luZyB0aGUgbm93IGF2YWlsYWJsZSBmYWNpbGl0aWVzLgo+Cj4gU3BlY2lmaWNhbGx5
LCB0aGlzIGlzIGEgcHJvb2Ytb2YtY29uY2VwdCBhdHRlbXB0IHRvIGltcGxlbWVudCBtbS1sb2Nh
bAo+IGFsbG9jYXRpb25zIHBpZ2d5LWJhY2tpbmcgb24gbWVtZmRfc2VjcmV0KCksIHVzaW5nIHJl
Z3VsYXIgdXNlciBhZGRyZXNzZXNzIGJ1dAo+IHBpbm5pbmcgdGhlIHBhZ2VzIGFuZCBmbGlwcGlu
ZyB0aGUgdXNlci9zdXBlcnZpc29yIGZsYWcgb24gdGhlIHJlc3BlY3RpdmUgUFRFcwo+IHRvIG1h
a2UgdGhlbSBkaXJlY3RseSBhY2Nlc3NpYmxlIGZyb20ga2VybmVsLCBhbmQgc2VhbGluZyB0aGUg
Vk1BIHRvIHByZXZlbnQKPiB1c2VybGFuZCBmcm9tIHRha2luZyBvdmVyIHRoZSBhZGRyZXNzIHJh
bmdlLiAgVGhlIGFwcHJvYWNoIGFsbG93ZWQgdG8gZGVsZWdhdGUKPiBhbGwgdGhlIGhlYXZ5IGxp
ZnRpbmcgLS0gYWRkcmVzcyBtYW5hZ2VtZW50LCBpbnRlcmFjdGlvbnMgd2l0aCB0aGUgZGlyZWN0
IG1hcCwKPiBjbGVhbnVwIG9uIG1tIHRlYXJkb3duIC0tIHRvIHRoZSBleGlzdGluZyBpbmZyYXN0
cnVjdHVyZSwgYW5kIHJlcXVpcmVkIHplcm8KPiBhcmNoaXRlY3R1cmUtc3BlY2lmaWMgY29kZS4K
Pgo+IENvbXBhcmVkIHRvIHRoZSBhcHByb2FjaCB1c2VkIGluIHRoZSBvcmlnbmFsIHNlcmllcywg
d2hlcmUgYSBkZWRpY2F0ZWQga2VybmVsCj4gYWRkcmVzcyByYW5nZSBhbmQgdGh1cyBhIGRlZGlj
YXRlZCBQR0Qgd2FzIHVzZWQgZm9yIG1tLWxvY2FsIGFsbG9jYXRpb25zLCB0aGUKPiBvbmUgcHJv
cG9zZWQgaGVyZSBtYXkgaGF2ZSBjZXJ0YWluIGRyYXdiYWNrcywgaW4gcGFydGljdWxhcgo+Cj4g
LSB1c2luZyB1c2VyIGFkZHJlc3NlcyBmb3Iga2VybmVsIG1lbW9yeSBtYXkgdmlvbGF0ZSBhc3N1
bXB0aW9ucyBpbiB2YXJpb3VzCj4gICAgcGFydHMgb2Yga2VybmVsIGNvZGUgd2hpY2ggd2UgbWF5
IG5vdCBoYXZlIGlkZW50aWZpZWQgd2l0aCBzbW9rZSB0ZXN0cyB3ZSBkaWQKPgo+IC0gdGhlIGFs
bG9jYXRlZCBhZGRyZXNzZXMgYXJlIGd1ZXNzYWJsZSBieSB0aGUgdXNlcmxhbmQgKEFUTSB0aGV5
IGFyZSBldmVuCj4gICAgdmlzaWJsZSBpbiAvcHJvYy9QSUQvbWFwcyBidXQgdGhhdCdzIGZpeGFi
bGUpIHdoaWNoIG1heSB3ZWFrZW4gdGhlIHNlY3VyaXR5Cj4gICAgcG9zdHVyZQo+Cj4gQWxzbyBp
bmNsdWRlZCBpcyBhIHNpbXBsZSB0ZXN0IGRyaXZlciBhbmQgc2VsZnRlc3QgdG8gc21va2UgdGVz
dCBhbmQgc2hvd2Nhc2UKPiB0aGUgZmVhdHVyZS4KPgo+IFRoZSBjb2RlIGlzIFBvQyBSRkMgYW5k
IGxhY2tzIGEgbG90IG9mIGNoZWNrcyBhbmQgc3BlY2lhbCBjYXNlIGhhbmRsaW5nLCBidXQKPiBk
ZW1vbnN0cmF0ZXMgdGhlIGlkZWEuICBXZSdkIGFwcHJlY2lhdGUgYW55IGZlZWRiYWNrIG9uIHdo
ZXRoZXIgaXQncyBhIHZpYWJsZQo+IGFwcHJvYWNoIG9yIGl0IHNob3VsZCBiZXR0ZXIgYmUgYWJh
bmRvbmVkIGluIGZhdm9yIG9mIHRoZSBvbmUgd2l0aCBkZWRpY2F0ZWQKPiBQR0QgLyBrZXJuZWwg
YWRkcmVzcyByYW5nZSBvciB5ZXQgc29tZXRoaW5nIGVsc2UuCj4KPiBbMV0gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGttbC8yMDE5MDYxMjE3MDgzNC4xNDg1NS0xLW1oaWxsZW5iQGFtYXpvbi5k
ZS8KCgpJIGhhdmVuJ3Qgc2VlbiBhbnkgbmVnYXRpdmUgZmVlZGJhY2sgb24gdGhlIFJGQywgc28g
d2hlbiBjYW4gSSBleHBlY3QgYSAKdjEgb2YgdGhpcyBwYXRjaCBzZXQgdGhhdCBhZGRyZXNzZXMg
dGhlIG5vbi1wcm9kdWN0aW9uLXJlYWR5bmVzcyBvZiBpdCAKdGhhdCB5b3UgY2FsbCBvdXQgYWJv
dmU/IDopCgoKQWxleAoKCgoKQW1hem9uIFdlYiBTZXJ2aWNlcyBEZXZlbG9wbWVudCBDZW50ZXIg
R2VybWFueSBHbWJICktyYXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1
bmc6IENocmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVpbmdldHJhZ2VuIGFtIEFt
dHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAyNTc3NjQgQgpTaXR6OiBCZXJsaW4K
VXN0LUlEOiBERSAzNjUgNTM4IDU5Nwo=


