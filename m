Return-Path: <linux-kselftest+bounces-17617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0FB973BE6
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 17:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BE991F288E7
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 15:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C525A1A0716;
	Tue, 10 Sep 2024 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="TJV73I0G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54E919ABB6;
	Tue, 10 Sep 2024 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725982022; cv=none; b=R3wbnWUL81BwAY3jvGgAeamhSHYmjR2HIyM8LgBmt32zOl0YOAyjURN2YKv0oNg9Eus7AH6OXLM19pQVjOx8gP6M6oBAo1SCLyethY3fXEz9vJf987I8UiOd/FFeM6DNtAlwKtFHGFgd56KK3KwhPAELbxw/owL7kDr9aAu/W9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725982022; c=relaxed/simple;
	bh=9cKjl9ygprSgUGbTu9ou8VxGIYHVdp/M2hZ72Ih7JLQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hH0tXPNdOeB85+ywSiEdjWVOvAyL2eqSLPkBu8yAJM8AYqMfn3uFBhoogQ0JC6fxlnT+qNkJKlKPurXHP64HSG3aWUd2YxU8gXaHdt3rdVCZp2+rFAkcyH7/BmUcoEREkQqWopfLtUSASABrwiEaf/TLSRJ/EcdzCIf8EVszeqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=TJV73I0G; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1725982021; x=1757518021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9cKjl9ygprSgUGbTu9ou8VxGIYHVdp/M2hZ72Ih7JLQ=;
  b=TJV73I0GBfGkLuPTE4hHaboHrbBDasOLYNmBzZEqMMC86wJF0RZ9+Q/N
   rNYY23kAbr57xHORC4RsIBNwQsmydXYVNfMgKSr7Xd6c3OMekvas8ZDt5
   5KVR0JmDt013iL/GMN3fYy3S7+upHHRa24GM7X0sr57D9ZRFcbmiO2p3n
   U=;
X-IronPort-AV: E=Sophos;i="6.10,217,1719878400"; 
   d="scan'208";a="422886989"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 15:26:50 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:61190]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.84:2525] with esmtp (Farcaster)
 id dd07028c-4466-4584-b915-58f08c541f19; Tue, 10 Sep 2024 15:26:49 +0000 (UTC)
X-Farcaster-Flow-ID: dd07028c-4466-4584-b915-58f08c541f19
Received: from EX19D020UWA002.ant.amazon.com (10.13.138.222) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:26:41 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D020UWA002.ant.amazon.com (10.13.138.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:26:41 +0000
Received: from dev-dsk-nikwip-1b-bc9ec026.eu-west-1.amazon.com (10.253.74.52)
 by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34
 via Frontend Transport; Tue, 10 Sep 2024 15:26:39 +0000
From: Nikolas Wipper <nikwip@amazon.de>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
CC: Nicolas Saenz Julienne <nsaenz@amazon.com>, Alexander Graf
	<graf@amazon.de>, James Gowans <jgowans@amazon.com>,
	<nh-open-source@amazon.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <kvmarm@lists.linux.dev>,
	<kvm-riscv@lists.infradead.org>, Nikolas Wipper <nikwip@amazon.de>
Subject: [PATCH 15/15] KVM: selftests: Add test for KVM_TRANSLATE2
Date: Tue, 10 Sep 2024 15:22:07 +0000
Message-ID: <20240910152207.38974-16-nikwip@amazon.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240910152207.38974-1-nikwip@amazon.de>
References: <20240910152207.38974-1-nikwip@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

QWRkIHNlbGZ0ZXN0IGZvciBLVk1fVFJBTlNMQVRFMi4gVGhlcmUgYXJlIGZvdXIgZGlmZmVyZW50
IHN1YnRlc3RzLgoKQSBiYXNpYyB0cmFuc2xhdGUgdGVzdCB0aGF0IGNoZWNrcyB3aGV0aGVyIGFj
Y2VzcyBwZXJtaXNzaW9ucyBhcmUgaGFuZGxlZApjb3JyZWN0bHkuIEEgc2V0IGJpdHMgdGVzdCwg
dGhhdCBjaGVja3Mgd2hldGhlciB0aGUgYWNjZXNzZWQgYW5kIGRpcnR5CmJpdHMgYXJlIHNldCBj
b3JyZWN0bHkuIEFuIGVycm9ycyB0ZXN0LCB0aGF0IGNoZWNrcyBuZWdhdGl2ZSBjYXNlcyBvZiB0
aGUKZmxhZ3MuIEFuZCBhIGZ1enp5IHRlc3Qgb24gcmFuZG9tIGd1ZXN0IHBhZ2UgdGFibGVzLgoK
VGhlIHRlc3RzIGN1cnJlbnRseSB1c2UgeDg2IHNwZWNpZmljIHBhZ2luZyBjb2RlLCBzbyBnZW5l
cmFsaXNpbmcgdGhlbSBmb3IKbW9yZSBwbGF0Zm9ybXMgaXMgaGFyZC4gT25jZSBvdGhlciBhcmNo
aXRlY3R1cmVzIGltcGxlbWVudCBLVk1fVFJBTlNMQVRFMgp0aGV5IG5lZWQgdG8gYmUgc3BsaXQg
aW50byBhcmNoIHNwZWNpZmljIGFuZCBhZ25vc3RpYyBwYXJ0cy4KClNpZ25lZC1vZmYtYnk6IE5p
a29sYXMgV2lwcGVyIDxuaWt3aXBAYW1hem9uLmRlPgotLS0KIHRvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2t2bS9NYWtlZmlsZSAgICAgICAgICB8ICAgMSArCiAuLi4vc2VsZnRlc3RzL2t2bS94ODZf
NjQva3ZtX3RyYW5zbGF0ZTIuYyAgICAgfCAzMTAgKysrKysrKysrKysrKysrKysrCiAyIGZpbGVz
IGNoYW5nZWQsIDMxMSBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMva3ZtL3g4Nl82NC9rdm1fdHJhbnNsYXRlMi5jCgpkaWZmIC0tZ2l0IGEv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL01ha2VmaWxlIGIvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMva3ZtL01ha2VmaWxlCmluZGV4IDQ1Y2I3MGMwNDhiYi4uNWJiMmRiNjc5NjU4IDEwMDY0
NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0vTWFrZWZpbGUKKysrIGIvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMva3ZtL01ha2VmaWxlCkBAIC04MSw2ICs4MSw3IEBAIFRFU1RfR0VO
X1BST0dTX3g4Nl82NCArPSB4ODZfNjQvaHlwZXJ2X3N2bV90ZXN0CiBURVNUX0dFTl9QUk9HU194
ODZfNjQgKz0geDg2XzY0L2h5cGVydl90bGJfZmx1c2gKIFRFU1RfR0VOX1BST0dTX3g4Nl82NCAr
PSB4ODZfNjQva3ZtX2Nsb2NrX3Rlc3QKIFRFU1RfR0VOX1BST0dTX3g4Nl82NCArPSB4ODZfNjQv
a3ZtX3B2X3Rlc3QKK1RFU1RfR0VOX1BST0dTX3g4Nl82NCArPSB4ODZfNjQva3ZtX3RyYW5zbGF0
ZTIKIFRFU1RfR0VOX1BST0dTX3g4Nl82NCArPSB4ODZfNjQvbW9uaXRvcl9td2FpdF90ZXN0CiBU
RVNUX0dFTl9QUk9HU194ODZfNjQgKz0geDg2XzY0L25lc3RlZF9leGNlcHRpb25zX3Rlc3QKIFRF
U1RfR0VOX1BST0dTX3g4Nl82NCArPSB4ODZfNjQvcGxhdGZvcm1faW5mb190ZXN0CmRpZmYgLS1n
aXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0veDg2XzY0L2t2bV90cmFuc2xhdGUyLmMg
Yi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0veDg2XzY0L2t2bV90cmFuc2xhdGUyLmMKbmV3
IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAwLi42MDdhZjYzNzYyNDMKLS0tIC9k
ZXYvbnVsbAorKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0veDg2XzY0L2t2bV90cmFu
c2xhdGUyLmMKQEAgLTAsMCArMSwzMTAgQEAKKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wCisvKgorICogVGVzdCBmb3IgeDg2IEtWTV9UUkFOU0xBVEUyCisgKgorICogQ29weXJp
Z2h0IMKpIDIwMjQgQW1hem9uLmNvbSwgSW5jLiBvciBpdHMgYWZmaWxpYXRlcy4gQWxsIFJpZ2h0
cyBSZXNlcnZlZC4KKyAqCisgKiBUaGlzIHdvcmsgaXMgbGljZW5zZWQgdW5kZXIgdGhlIHRlcm1z
IG9mIHRoZSBHTlUgR1BMLCB2ZXJzaW9uIDIuCisgKgorICovCisjaW5jbHVkZSA8c3RkaW8uaD4K
KyNpbmNsdWRlIDxzdGRsaWIuaD4KKyNpbmNsdWRlIDxzdHJpbmcuaD4KKyNpbmNsdWRlIDxzeXMv
aW9jdGwuaD4KKyNpbmNsdWRlIDxsaW51eC9iaXRtYXAuaD4KKworI2luY2x1ZGUgInRlc3RfdXRp
bC5oIgorI2luY2x1ZGUgImt2bV91dGlsLmgiCisjaW5jbHVkZSAicHJvY2Vzc29yLmgiCisKKyNk
ZWZpbmUgQ0hFQ0tfQUNDRVNTRURfQklUKHB0ZSwgc2V0LCBzdGFydCkgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXAorCSh7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKKwkJZm9yIChpbnQgX2kg
PSBzdGFydDsgX2kgPD0gUEdfTEVWRUxfNTEyRzsgX2krKykgeyAgICAgICAgICAgICAgIFwKKwkJ
CWlmIChzZXQpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
XAorCQkJCVRFU1RfQVNTRVJUKCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwK
KwkJCQkJKCpwdGVbX2ldICYgUFRFX0FDQ0VTU0VEX01BU0spICE9IDAsICAgIFwKKwkJCQkJIlBh
Z2Ugbm90IG1hcmtlZCBhY2Nlc3NlZCBvbiBsZXZlbCAlaSIsIFwKKwkJCQkJX2kpOyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKKwkJCWVsc2UgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAorCQkJCVRFU1RfQVNTRVJUKCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKKwkJCQkJKCpwdGVbX2ldICYgUFRFX0FD
Q0VTU0VEX01BU0spID09IDAsICAgIFwKKwkJCQkJIlBhZ2UgbWFya2VkIGFjY2Vzc2VkIG9uIGxl
dmVsICVpIiwgICAgIFwKKwkJCQkJX2kpOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFwKKwkJfSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFwKKwl9KQorCisjZGVmaW5lIENIRUNLX0RJUlRZX0JJVChwdGUsIHNl
dCkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAorCSh7ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXAorCQlpZiAoc2V0KSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBcCisJCQlURVNUX0FTU0VSVCgoKnB0ZVtQR19MRVZFTF80S10g
JiBQVEVfRElSVFlfTUFTSykgIT0gMCwgXAorCQkJCSAgICAiUGFnZSBub3QgbWFya2VkIGRpcnR5
Iik7ICAgICAgICAgICAgICAgICAgXAorCQllbHNlICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCisJCQlURVNUX0FTU0VSVCgoKnB0ZVtQ
R19MRVZFTF80S10gJiBQVEVfRElSVFlfTUFTSykgPT0gMCwgXAorCQkJCSAgICAiUGFnZSBtYXJr
ZWQgZGlydHkiKTsgICAgICAgICAgICAgICAgICAgICAgXAorCX0pCisKK2VudW0gcG9pbnRfb2Zf
ZmFpbHVyZSB7CisJcG9mX25vbmUsCisJcG9mX2lvY3RsLAorCXBvZl9wYWdlX3dhbGssCisJcG9m
X25vX2ZhaWx1cmUsCit9OworCitzdHJ1Y3Qga3ZtX3RyYW5zbGF0aW9uMiBrdm1fdHJhbnNsYXRl
MihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHVpbnQ2NF90IHZhZGRyLAorCQkJCSAgICAgICBpbnQg
ZmxhZ3MsIGludCBhY2Nlc3MsCisJCQkJICAgICAgIGVudW0gcG9pbnRfb2ZfZmFpbHVyZSBwb2Yp
Cit7CisJc3RydWN0IGt2bV90cmFuc2xhdGlvbjIgdHIgPSB7IC5saW5lYXJfYWRkcmVzcyA9IHZh
ZGRyLAorCQkJCSAgICAgICAuZmxhZ3MgPSBmbGFncywKKwkJCQkgICAgICAgLmFjY2VzcyA9IGFj
Y2VzcyB9OworCisJaW50IHJlcyA9IGlvY3RsKHZjcHUtPmZkLCBLVk1fVFJBTlNMQVRFMiwgJnRy
KTsKKworCWlmIChwb2YgPT0gcG9mX25vbmUpCisJCXJldHVybiB0cjsKKworCWlmIChwb2YgPT0g
cG9mX2lvY3RsKSB7CisJCVRFU1RfQVNTRVJUKHJlcyA9PSAtMSwgImlvY3RsIGRpZG4ndCBmYWls
Iik7CisJCXJldHVybiB0cjsKKwl9CisKKwlURVNUX0FTU0VSVChyZXMgIT0gLTEsICJpb2N0bCBm
YWlsZWQiKTsKKwlURVNUX0FTU0VSVCgocG9mICE9IHBvZl9wYWdlX3dhbGspID09IHRyLnZhbGlk
LAorCQkgICAgIlBhZ2Ugd2FsayBmYWlsIHdpdGggY29kZSAldSIsIHRyLmVycm9yX2NvZGUpOwor
CisJcmV0dXJuIHRyOworfQorCit2b2lkIHRlc3RfdHJhbnNsYXRlKHN0cnVjdCBrdm1fdm0gKnZt
LCBzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGludCBpbmRleCwKKwkJICAgIHVpbnQ2NF90ICpwdGVb
UEdfTEVWRUxfTlVNXSwgdm1fdmFkZHJfdCB2YWRkcikKK3sKKwlzdHJ1Y3Qga3ZtX3RyYW5zbGF0
aW9uMiB0cmFuc2xhdGlvbjsKKwlpbnQgYWNjZXNzID0gaW5kZXg7CisKKwlwcmludGYoIiVzIC0g
d3JpdGU6ICV1LCB1c2VyOiAldSwgZXhlYzogJXUgLi4uXHQiLAorCSAgICAgICBfX2Z1bmNfXywK
KwkgICAgICAgKGFjY2VzcyAmIEtWTV9UUkFOU0xBVEVfQUNDRVNTX1dSSVRFKSA+PiAwLAorCSAg
ICAgICAoYWNjZXNzICYgS1ZNX1RSQU5TTEFURV9BQ0NFU1NfVVNFUikgPj4gMSwKKwkgICAgICAg
KGFjY2VzcyAmIEtWTV9UUkFOU0xBVEVfQUNDRVNTX0VYRUMpID4+IDIpOworCisJdWludDY0X3Qg
bWFzayA9IFBURV9XUklUQUJMRV9NQVNLIHwgUFRFX1VTRVJfTUFTSyB8IFBURV9OWF9NQVNLOwor
CXVpbnQ2NF90IG5ld192YWx1ZSA9IDA7CisKKwlpZiAoYWNjZXNzICYgS1ZNX1RSQU5TTEFURV9B
Q0NFU1NfV1JJVEUpCisJCW5ld192YWx1ZSB8PSBQVEVfV1JJVEFCTEVfTUFTSzsKKwlpZiAoYWNj
ZXNzICYgS1ZNX1RSQU5TTEFURV9BQ0NFU1NfVVNFUikKKwkJbmV3X3ZhbHVlIHw9IFBURV9VU0VS
X01BU0s7CisJaWYgKCEoYWNjZXNzICYgS1ZNX1RSQU5TTEFURV9BQ0NFU1NfRVhFQykpCisJCW5l
d192YWx1ZSB8PSBQVEVfTlhfTUFTSzsKKworCWZvciAoaW50IGkgPSBQR19MRVZFTF80SzsgaSA8
PSBQR19MRVZFTF81MTJHOyBpKyspCisJCSpwdGVbaV0gPSAoKnB0ZVtpXSAmIH5tYXNrKSB8IG5l
d192YWx1ZTsKKworCXRyYW5zbGF0aW9uID0ga3ZtX3RyYW5zbGF0ZTIodmNwdSwgdmFkZHIsIDAs
IGFjY2VzcywgcG9mX25vX2ZhaWx1cmUpOworCisJVEVTVF9BU1NFUlRfRVEoKnB0ZVtQR19MRVZF
TF80S10gJiBHRU5NQVNLKDUxLCAxMiksCisJCSAgICAgICB0cmFuc2xhdGlvbi5waHlzaWNhbF9h
ZGRyZXNzKTsKKworCS8qIENoZWNrIGNvbmZpZ3VyYXRpb25zIHRoYXQgaGF2ZSBleHRyYSBhY2Nl
c3MgcmVxdWlyZW1lbnRzICovCisJZm9yIChpbnQgaSA9IDA7IGkgPCA4OyBpKyspIHsKKwkJaW50
IGNhc2VfYWNjZXNzID0gaTsKKworCQlpZiAoKGNhc2VfYWNjZXNzIHwgYWNjZXNzKSA8PSBhY2Nl
c3MpCisJCQljb250aW51ZTsKKworCQl0cmFuc2xhdGlvbiA9IGt2bV90cmFuc2xhdGUyKHZjcHUs
IHZhZGRyLCAwLCBjYXNlX2FjY2VzcywKKwkJCQkJICAgICBwb2ZfcGFnZV93YWxrKTsKKwkJVEVT
VF9BU1NFUlRfRVEodHJhbnNsYXRpb24uZXJyb3JfY29kZSwKKwkJCSAgICAgICBLVk1fVFJBTlNM
QVRFX0ZBVUxUX1BSSVZJTEVHRV9WSU9MQVRJT04pOworCX0KKworCS8qIENsZWFyIGFjY2Vzc2Vk
IGJpdHMgKi8KKwlmb3IgKGludCBpID0gUEdfTEVWRUxfNEs7IGkgPD0gUEdfTEVWRUxfNTEyRzsg
aSsrKQorCQkqcHRlW2ldICY9IH5QVEVfQUNDRVNTRURfTUFTSzsKKworCXByaW50ZigiW29rXVxu
Iik7Cit9CisKK3ZvaWQgdGVzdF9zZXRfYml0cyhzdHJ1Y3Qga3ZtX3ZtICp2bSwgc3RydWN0IGt2
bV92Y3B1ICp2Y3B1LAorCQkgICB1aW50NjRfdCAqcHRlW1BHX0xFVkVMX05VTV0sIHZtX3ZhZGRy
X3QgdmFkZHIpCit7CisJcHJpbnRmKCIlcyAuLi5cdCIsIF9fZnVuY19fKTsKKworCS8qIFNhbml0
eSBjaGVja3MgKi8KKwlDSEVDS19BQ0NFU1NFRF9CSVQocHRlLCBmYWxzZSwgUEdfTEVWRUxfNEsp
OworCUNIRUNLX0RJUlRZX0JJVChwdGUsIGZhbHNlKTsKKworCWt2bV90cmFuc2xhdGUyKHZjcHUs
IHZhZGRyLCAwLCAwLCBwb2Zfbm9fZmFpbHVyZSk7CisKKwlDSEVDS19BQ0NFU1NFRF9CSVQocHRl
LCBmYWxzZSwgUEdfTEVWRUxfNEspOworCUNIRUNLX0RJUlRZX0JJVChwdGUsIGZhbHNlKTsKKwor
CWt2bV90cmFuc2xhdGUyKHZjcHUsIHZhZGRyLCBLVk1fVFJBTlNMQVRFX0ZMQUdTX1NFVF9BQ0NF
U1NFRCwgMCwKKwkJICAgICAgIHBvZl9ub19mYWlsdXJlKTsKKworCUNIRUNLX0FDQ0VTU0VEX0JJ
VChwdGUsIHRydWUsIFBHX0xFVkVMXzRLKTsKKwlDSEVDS19ESVJUWV9CSVQocHRlLCBmYWxzZSk7
CisKKwlrdm1fdHJhbnNsYXRlMih2Y3B1LCB2YWRkciwKKwkJICAgICAgIEtWTV9UUkFOU0xBVEVf
RkxBR1NfU0VUX0FDQ0VTU0VEIHwgS1ZNX1RSQU5TTEFURV9GTEFHU19TRVRfRElSVFksCisJCSAg
ICAgICBLVk1fVFJBTlNMQVRFX0FDQ0VTU19XUklURSwgcG9mX25vX2ZhaWx1cmUpOworCisJQ0hF
Q0tfQUNDRVNTRURfQklUKHB0ZSwgdHJ1ZSwgUEdfTEVWRUxfNEspOworCUNIRUNLX0RJUlRZX0JJ
VChwdGUsIHRydWUpOworCisJcHJpbnRmKCJbb2tdXG4iKTsKK30KKwordm9pZCB0ZXN0X2Vycm9y
cyhzdHJ1Y3Qga3ZtX3ZtICp2bSwgc3RydWN0IGt2bV92Y3B1ICp2Y3B1LAorCQkgdWludDY0X3Qg
KnB0ZVtQR19MRVZFTF9OVU1dLCB2bV92YWRkcl90IHZhZGRyKQoreworCXN0cnVjdCBrdm1fdHJh
bnNsYXRpb24yIHRyOworCisJcHJpbnRmKCIlcyAuLi5cdCIsIF9fZnVuY19fKTsKKworCS8qIFNl
dCBhbiB1bnN1cHBvcnRlZCBhY2Nlc3MgYml0ICovCisJa3ZtX3RyYW5zbGF0ZTIodmNwdSwgdmFk
ZHIsIDAsICgxIDw8IDMpLCBwb2ZfaW9jdGwpOworCWt2bV90cmFuc2xhdGUyKHZjcHUsIHZhZGRy
LCBLVk1fVFJBTlNMQVRFX0ZMQUdTX1NFVF9ESVJUWSwgMCwgcG9mX2lvY3RsKTsKKwlrdm1fdHJh
bnNsYXRlMih2Y3B1LCB2YWRkciwgS1ZNX1RSQU5TTEFURV9GTEFHU19GT1JDRV9TRVRfQUNDRVNT
RUQsIDAsCisJCSAgICAgICBwb2ZfaW9jdGwpOworCisJLyogVHJ5IHRvIHRyYW5zbGF0ZSBhIG5v
bi1jYW5vbmljYWwgYWRkcmVzcyAqLworCXRyID0ga3ZtX3RyYW5zbGF0ZTIodmNwdSwgMGIxMDF1
bGwgPDwgNjAsIDAsIDAsIHBvZl9wYWdlX3dhbGspOworCVRFU1RfQVNTRVJUX0VRKHRyLmVycm9y
X2NvZGUsIEtWTV9UUkFOU0xBVEVfRkFVTFRfSU5WQUxJRF9HVkEpOworCisJdWludDY0X3Qgb2xk
X3B0ZSA9ICpwdGVbUEdfTEVWRUxfMk1dOworCisJKnB0ZVtQR19MRVZFTF8yTV0gfD0gKDF1bGwg
PDwgNTEpOyAvKiBTZXQgYSByZXNlcnZlZCBiaXQgKi8KKworCXRyID0ga3ZtX3RyYW5zbGF0ZTIo
dmNwdSwgdmFkZHIsIDAsIDAsIHBvZl9wYWdlX3dhbGspOworCVRFU1RfQVNTRVJUX0VRKHRyLmVy
cm9yX2NvZGUsIEtWTV9UUkFOU0xBVEVfRkFVTFRfUkVTRVJWRURfQklUUyk7CisKKwkqcHRlW1BH
X0xFVkVMXzJNXSAmPSB+KDF1bGwgPDwgNTEpOworCisJLyogQ3JlYXRlIGEgR1BBIHRoYXQncyBk
ZWZpbml0ZWx5IG5vdCBtYXBwZWQgKi8KKwkqcHRlW1BHX0xFVkVMXzJNXSB8PSBHRU5NQVNLKDM1
LCAxMyk7CisKKwl0ciA9IGt2bV90cmFuc2xhdGUyKHZjcHUsIHZhZGRyLCAwLCAwLCBwb2ZfcGFn
ZV93YWxrKTsKKwlURVNUX0FTU0VSVF9FUSh0ci5lcnJvcl9jb2RlLCBLVk1fVFJBTlNMQVRFX0ZB
VUxUX0lOVkFMSURfR1BBKTsKKworCSpwdGVbUEdfTEVWRUxfMk1dID0gb2xkX3B0ZTsKKworCS8q
IENsZWFyIGFjY2Vzc2VkIGJpdHMgKi8KKwlmb3IgKGludCBpID0gUEdfTEVWRUxfNEs7IGkgPD0g
UEdfTEVWRUxfNTEyRzsgaSsrKQorCQkqcHRlW2ldICY9IH5QVEVfQUNDRVNTRURfTUFTSzsKKwor
CS8qIFRyeSB0cmFuc2xhdGluZyBhIG5vbi1wcmVzZW50IHBhZ2UgKi8KKwkqcHRlW1BHX0xFVkVM
XzRLXSAmPSB+UFRFX1BSRVNFTlRfTUFTSzsKKworCXRyID0ga3ZtX3RyYW5zbGF0ZTIoCisJCXZj
cHUsIHZhZGRyLAorCQlLVk1fVFJBTlNMQVRFX0ZMQUdTX1NFVF9BQ0NFU1NFRCB8CisJCQlLVk1f
VFJBTlNMQVRFX0ZMQUdTX0ZPUkNFX1NFVF9BQ0NFU1NFRCwgMCwKKwkJcG9mX3BhZ2Vfd2Fsayk7
CisJVEVTVF9BU1NFUlRfRVEodHIuZXJyb3JfY29kZSwgS1ZNX1RSQU5TTEFURV9GQVVMVF9OT1Rf
UFJFU0VOVCk7CisJQ0hFQ0tfQUNDRVNTRURfQklUKHB0ZSwgdHJ1ZSwgUEdfTEVWRUxfMk0pOwor
CisJKnB0ZVtQR19MRVZFTF80S10gfD0gUFRFX1BSRVNFTlRfTUFTSzsKKworCS8qCisJICogVHJ5
IHNldHRpbmcgYWNjZXNzZWQvZGlydHkgYml0cyBvbiBhIFBURSB0aGF0IGlzIGluIHJlYWQtb25s
eSBtZW1vcnkKKwkgKi8KKwl2bV91c2Vyc3BhY2VfbWVtX3JlZ2lvbl9hZGQodm0sIFZNX01FTV9T
UkNfQU5PTllNT1VTLCAweDgwMDAwMDAwLCAxLCA0LAorCQkJCSAgICBLVk1fTUVNX1JFQURPTkxZ
KTsKKworCXVpbnQ2NF90ICphZGRyID0gYWRkcl9ncGEyaHZhKHZtLCAweDgwMDAwMDAwKTsKKwl1
aW50NjRfdCAqYmFzZSA9IGFkZHJfZ3BhMmh2YSh2bSwgKnB0ZVtQR19MRVZFTF8yTV0gJiBHRU5N
QVNLKDUxLCAxMikpOworCisJLyogQ29weSB0aGUgZW50aXJlIHBhZ2UgdGFibGUgKi8KKwlmb3Ig
KGludCBpID0gMDsgaSA8IDB4MjAwOyBpICs9IDEpCisJCWFkZHJbaV0gPSAoYmFzZVtpXSAmIH5Q
VEVfQUNDRVNTRURfTUFTSykgfCBQVEVfUFJFU0VOVF9NQVNLOworCisJdWludDY0X3Qgb2xkXzJt
ID0gKnB0ZVtQR19MRVZFTF8yTV07CisJKnB0ZVtQR19MRVZFTF8yTV0gJj0gfkdFTk1BU0soNTEs
IDEyKTsKKwkqcHRlW1BHX0xFVkVMXzJNXSB8PSAweDgwMDAwMDAwOworCisJdHIgPSBrdm1fdHJh
bnNsYXRlMih2Y3B1LCB2YWRkciwKKwkJCSAgICBLVk1fVFJBTlNMQVRFX0ZMQUdTX1NFVF9BQ0NF
U1NFRCB8CisJCQkJICAgIEtWTV9UUkFOU0xBVEVfRkxBR1NfU0VUX0RJUlRZIHwKKwkJCQkgICAg
S1ZNX1RSQU5TTEFURV9GTEFHU19GT1JDRV9TRVRfQUNDRVNTRUQsCisJCQkgICAgS1ZNX1RSQU5T
TEFURV9BQ0NFU1NfV1JJVEUsIHBvZl9ub19mYWlsdXJlKTsKKworCVRFU1RfQVNTRVJUKCF0ci5z
ZXRfYml0c19zdWNjZWVkZWQsICJQYWdlIG5vdCByZWFkLW9ubHkiKTsKKworCSpwdGVbUEdfTEVW
RUxfMk1dID0gb2xkXzJtOworCisJcHJpbnRmKCJbb2tdXG4iKTsKK30KKworLyogVGVzdCBwYWdl
IHdhbGtlciBzdGFiaWxpdHksIGJ5IHRyeWluZyB0byB0cmFuc2xhdGUgd2l0aCBnYXJiYWdlIFBU
RXMgKi8KK3ZvaWQgdGVzdF9mdXp6KHN0cnVjdCBrdm1fdm0gKnZtLCBzdHJ1Y3Qga3ZtX3ZjcHUg
KnZjcHUsCisJICAgICAgIHVpbnQ2NF90ICpwdGVbUEdfTEVWRUxfTlVNXSwgdm1fdmFkZHJfdCB2
YWRkcikKK3sKKwlwcmludGYoIiVzIC4uLlx0IiwgX19mdW5jX18pOworCisJLyogVGVzdCBnUFRF
cyB0aGF0IHBvaW50IHRvIHJhbmRvbSBhZGRyZXNzZXMgKi8KKwlmb3IgKGludCBsZXZlbCA9IFBH
X0xFVkVMXzRLOyBsZXZlbCA8IFBHX0xFVkVMX05VTTsgbGV2ZWwrKykgeworCQlmb3IgKGludCBp
ID0gMDsgaSA8IDEwMDAwOyBpKyspIHsKKwkJCXVpbnQ2NF90IHJhbmRvbV9hZGRyZXNzID0gcmFu
ZG9tKCkgJSBHRU5NQVNLKDI5LCAwKSA8PCAxMjsKKwkJCSpwdGVbbGV2ZWxdID0gKCpwdGVbbGV2
ZWxdICYgfkdFTk1BU0soNTEsIDEyKSkgfCByYW5kb21fYWRkcmVzczsKKworCQkJa3ZtX3RyYW5z
bGF0ZTIodmNwdSwgdmFkZHIsCisJCQkJICAgICAgIEtWTV9UUkFOU0xBVEVfRkxBR1NfU0VUX0FD
Q0VTU0VEIHwKKwkJCQkJICAgICAgIEtWTV9UUkFOU0xBVEVfRkxBR1NfU0VUX0RJUlRZIHwKKwkJ
CQkJICAgICAgIEtWTV9UUkFOU0xBVEVfRkxBR1NfRk9SQ0VfU0VUX0FDQ0VTU0VELAorCQkJCSAg
ICAgICAwLCBwb2Zfbm9uZSk7CisJCX0KKwl9CisKKwkvKiBUZXN0IGdQVEVzIHdpdGggY29tcGxl
dGVseSByYW5kb20gdmFsdWVzICovCisJZm9yIChpbnQgbGV2ZWwgPSBQR19MRVZFTF80SzsgbGV2
ZWwgPCBQR19MRVZFTF9OVU07IGxldmVsKyspIHsKKwkJZm9yIChpbnQgaSA9IDA7IGkgPCAxMDAw
MDsgaSsrKSB7CisJCQkqcHRlW2xldmVsXSA9IHJhbmRvbSgpOworCisJCQlrdm1fdHJhbnNsYXRl
Mih2Y3B1LCB2YWRkciwKKwkJCQkgICAgICAgS1ZNX1RSQU5TTEFURV9GTEFHU19TRVRfQUNDRVNT
RUQgfAorCQkJCQkgICAgICAgS1ZNX1RSQU5TTEFURV9GTEFHU19TRVRfRElSVFkgfAorCQkJCQkg
ICAgICAgS1ZNX1RSQU5TTEFURV9GTEFHU19GT1JDRV9TRVRfQUNDRVNTRUQsCisJCQkJICAgICAg
IDAsIHBvZl9ub25lKTsKKwkJfQorCX0KKworCXByaW50ZigiW29rXVxuIik7Cit9CisKK2ludCBt
YWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCit7CisJdWludDY0X3QgKnB0ZVtQR19MRVZFTF9O
VU1dOworCXN0cnVjdCBrdm1fdmNwdSAqdmNwdTsKKwlzdHJ1Y3Qga3ZtX3NyZWdzIHJlZ3M7CisJ
c3RydWN0IGt2bV92bSAqdm07CisJdm1fdmFkZHJfdCB2YWRkcjsKKwlpbnQgcGFnZV9sZXZlbDsK
KworCVRFU1RfUkVRVUlSRShrdm1faGFzX2NhcChLVk1fQ0FQX1RSQU5TTEFURTIpKTsKKworCXZt
ID0gdm1fY3JlYXRlX3dpdGhfb25lX3ZjcHUoJnZjcHUsIE5VTEwpOworCisJdmFkZHIgPSBfX3Zt
X3ZhZGRyX2FsbG9jX3BhZ2Uodm0sIE1FTV9SRUdJT05fVEVTVF9EQVRBKTsKKworCWZvciAocGFn
ZV9sZXZlbCA9IFBHX0xFVkVMXzUxMkc7IHBhZ2VfbGV2ZWwgPiBQR19MRVZFTF9OT05FOworCSAg
ICAgcGFnZV9sZXZlbC0tKSB7CisJCXB0ZVtwYWdlX2xldmVsXSA9IF9fdm1fZ2V0X3BhZ2VfdGFi
bGVfZW50cnkodm0sIHZhZGRyLCAmcGFnZV9sZXZlbCk7CisJfQorCisJLyogRW5hYmxlIFdQIGJp
dCBpbiBjcjAsIHNvIGtlcm5lbCBhY2Nlc3NlcyB1cGhvbGQgd3JpdGUgcHJvdGVjdGlvbiAqLwor
CXZjcHVfaW9jdGwodmNwdSwgS1ZNX0dFVF9TUkVHUywgJnJlZ3MpOworCXJlZ3MuY3IwIHw9IDEg
PDwgMTY7CisJdmNwdV9pb2N0bCh2Y3B1LCBLVk1fU0VUX1NSRUdTLCAmcmVncyk7CisKKwlmb3Ig
KGludCBpbmRleCA9IDA7IGluZGV4IDwgODsgaW5kZXgrKykKKwkJdGVzdF90cmFuc2xhdGUodm0s
IHZjcHUsIGluZGV4LCBwdGUsIHZhZGRyKTsKKworCXRlc3Rfc2V0X2JpdHModm0sIHZjcHUsIHB0
ZSwgdmFkZHIpOworCXRlc3RfZXJyb3JzKHZtLCB2Y3B1LCBwdGUsIHZhZGRyKTsKKwl0ZXN0X2Z1
enoodm0sIHZjcHUsIHB0ZSwgdmFkZHIpOworCisJa3ZtX3ZtX2ZyZWUodm0pOworCisJcmV0dXJu
IDA7Cit9Ci0tIAoyLjQwLjEKCgoKCkFtYXpvbiBXZWIgU2VydmljZXMgRGV2ZWxvcG1lbnQgQ2Vu
dGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1
ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBh
bSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMjU3NzY0IEIKU2l0ejogQmVy
bGluClVzdC1JRDogREUgMzY1IDUzOCA1OTcK


