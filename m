Return-Path: <linux-kselftest+bounces-26492-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E54A332AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 23:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36498167A67
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 22:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140EC256C81;
	Wed, 12 Feb 2025 22:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="fzhJwN12"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE6221324C;
	Wed, 12 Feb 2025 22:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399523; cv=none; b=XjvShPEeTgb6FMBftZkVJE2bqv8RR/LmNCOgV/oQCIIuWX2Ww7Zt1maiokH9RxxyDpxKQoP3iQlbYO6iBVJc+yJC5NRJNZmvHUbE2KEs8Km/hAm0XbvTQAWRv2hLOLPdCa026Kj1kUdcBizTrVhcx4DpWM45nXmgIfkPm2GMSUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399523; c=relaxed/simple;
	bh=sZ76WPaDy8nPLEmdLdS4bFskJzP4b3MihXK0mHdyZm0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qsfSQtYGbGW48yDelnwqFQ6u2ndaD/zTbQlBAKres0oJwuYq+En5KHxwBQcS/mWIfUgVPLJIWiWcbCgb97xJsYtDGets73GaeXqqHy6rZGLnstpmeQyQMMRydrYJMvbVBV/y2CIQrGAZcr1DO1JNTlouZzqZou2WPqtln3l7KAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=fzhJwN12; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CMFw2c010600;
	Wed, 12 Feb 2025 22:31:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-id:content-transfer-encoding:content-type:date
	:from:in-reply-to:message-id:mime-version:references:subject:to;
	 s=default; bh=sZ76WPaDy8nPLEmdLdS4bFskJzP4b3MihXK0mHdyZm0=; b=f
	zhJwN12YsrfK21DtDVSk5pbmc0lvWmu8KAB9J3QQJLBC+T6xQJp28KiUEhwYyOfY
	2WE5QlNyWsprV1MOJP2MLzTgzROR8bnTWstsq8xJhlkamcOC73LnrdNdQBVrhVI5
	Tl2yBLTyisRjlXmpSQMZehJfHX5ynLxoXKpjVYpM2p/53Mbh/kq/++wbr2YL0NiE
	kRfBJo0AQHysw5+yp9/gHK8FodK2BQtsePIqeHXC9ibKP8klKyQto1q+YH9jUi5Z
	+PrRk8MpdKLBnE4+B82OyxBfvvUhv3LrI+x5GeXPfJcImadOtsqC7xJxN9IJyda9
	mvwd8foTCUruQZ1fSpHrA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 44s49kg6db-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 22:31:23 +0000 (GMT)
Received: from 04WPEXCH006.crowdstrike.sys (10.100.11.70) by
 04WPEXCH007.crowdstrike.sys (10.100.11.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 12 Feb 2025 22:31:21 +0000
Received: from 04WPEXCH006.crowdstrike.sys ([fe80::a97d:6ad:c239:d138]) by
 04WPEXCH006.crowdstrike.sys ([fe80::a97d:6ad:c239:d138%11]) with mapi id
 15.02.1544.009; Wed, 12 Feb 2025 22:31:21 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC: "mykolal@fb.com" <mykolal@fb.com>, "shuah@kernel.org" <shuah@kernel.org>,
        "eddyz87@gmail.com" <eddyz87@gmail.com>,
        "song@kernel.org" <song@kernel.org>,
        Mark Fontana <mark.fontana@crowdstrike.com>,
        "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>,
        "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "ast@kernel.org" <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "sdf@fomichev.me"
	<sdf@fomichev.me>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Slava
 Imameev" <slava.imameev@crowdstrike.com>,
        "jolsa@kernel.org"
	<jolsa@kernel.org>,
        "haoluo@google.com" <haoluo@google.com>
Subject: Re: Re: Re: Re: [PATCH 2/2] libbpf: BPF programs dynamic loading and
 attaching
Thread-Topic: Re: Re: Re: [PATCH 2/2] libbpf: BPF programs dynamic loading and
 attaching
Thread-Index: AQHbfZ3XBT9ZxQOU7kGKxsu7YttsEQ==
Date: Wed, 12 Feb 2025 22:31:21 +0000
Message-ID: <7727e5d4f035c04d03ba274ad8b7fb8bc7da696c.camel@crowdstrike.com>
References: <20250122215206.59859-1-slava.imameev@crowdstrike.com>
	 <20250122215206.59859-2-slava.imameev@crowdstrike.com>
	 <CAEf4Bzajxh4xvg-aCaBhLQdNOZdhwceYUD2UsCcWku4ZBca_Hw@mail.gmail.com>
	 <8831ed8fa183f76fefd71244360fa0ca35b11910.camel@crowdstrike.com>
	 <CAEf4BzYWe0KCzA4-qwAGp5n_ydJ0_zyLSO=Crr_vewFHzZ0t6Q@mail.gmail.com>
	 <e55a1441252079e73b2abdf3635efcebda6b47c1.camel@crowdstrike.com>
	 <CAEf4BzZ8H0nQMEMaDGMfyngb15zMFEduy_R_ajakrdjGGtiOQA@mail.gmail.com>
In-Reply-To: <CAEf4BzZ8H0nQMEMaDGMfyngb15zMFEduy_R_ajakrdjGGtiOQA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-disclaimer: USA
Content-Type: text/plain; charset="utf-8"
Content-ID: <458A786FEBBE5D46BBF6F0C11E1BF9B6@crowdstrike.sys>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Authority-Analysis: v=2.4 cv=ULMnHDfy c=1 sm=1 tr=0 ts=67ad213b cx=c_pps a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17 a=xqWC_Br6kY4A:10 a=EjBHVkixTFsA:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=P-IC7800AAAA:8 a=7-tEzCSxO2EtVtJZZDcA:9
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: ntqav-D13SItNR8cRYkViUiO4pWKFj-C
X-Proofpoint-GUID: ntqav-D13SItNR8cRYkViUiO4pWKFj-C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_07,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502120159

T24gTW9uLCAyMDI1LTAyLTEwIGF0IDE2OjA2IC0wODAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQo+ID4gVHJhY2tpbmcgYXNzb2NpYXRlZCBtYXBzIGZvciBhIHByb2dyYW0gaXMgbm90IG5lY2Vz
c2FyeS4gQXMgbG9uZyBhcw0KPiA+IHRoZSBsYXN0IEJQRiBwcm9ncmFtIHVzaW5nIHRoZSBCUEYg
bWFwIGlzIHVubG9hZGVkLCB0aGUga2VybmVsIHdpbGwNCj4gPiBhdXRvbWF0aWNhbGx5IGZyZWUg
bm90LWFueW1vcmUtcmVmZXJlbmNlZCBCUEYgbWFwLiBOb3RlIHRoYXQNCj4gPiBicGZfb2JqZWN0
IGl0c2VsZiB3aWxsIGtlZXAgRkRzIGZvciBCUEYgbWFwcywgc28geW91J2QgbmVlZCB0byBtYWtl
DQo+ID4gc3VyZSB0byBkbyBicGZfb2JqZWN0X19jbG9zZSgpIHRvIHJlbGVhc2UgdGhvc2UgcmVm
ZXJlbmNlcy4NCj4gPiANCj4gPiBCdXQgaWYgeW91IGFyZSBnb2luZyB0byBhc2sgdG8gcmUtY3Jl
YXRlIEJQRiBtYXBzIG5leHQgdGltZSBCUEYNCj4gPiBwcm9ncmFtIGlzIGxvYWRlZC4uLiBXZWxs
LCBJJ2xsIHNheSB5b3UgYXJlIGFza2luZyBmb3IgYSBiaXQgdG9vID4NCj4gPiBtdWNoLA0KPiA+
IHRiaC4gSWYgeW91IHdhbnQgdG8gYmUgKnRoYXQqIHNvcGhpc3RpY2F0ZWQsIGl0IHNob3VsZG4n
dCBiZSB0b28NCj4gPiBoYXJkDQo+ID4gZm9yIHlvdSB0byBnZXQgYWxsIHRoaXMgaW5mb3JtYXRp
b24gZnJvbSBCUEYgcHJvZ3JhbSdzDQo+ID4gaW5zdHJ1Y3Rpb25zLg0KPiA+IA0KDQpXZSByZWFs
bHkgYXJlIHRoYXQgc29waGlzdGljYXRlZCAoc2VlIGJlbG93IGZvciBtb3JlIGRldGFpbHMpLiBX
ZSBjb3VsZA0Kc2NhbiBwcm9ncmFtIGluc3RydWN0aW9ucywgYnV0IHdlJ2QgdGhlbiB0aWUgb3Vy
IGxvZ2ljIHRvIEJQRg0KaW1wbGVtZW50YXRpb24gZGV0YWlscyBhbmQgZHVwbGljYXRlIGxvZ2lj
IGFscmVhZHkgcHJlc2VudCBpbiBsaWJicGYNCihodHRwczovL2VsaXhpci5ib290bGluLmNvbS9s
aW51eC92Ni4xMy4yL3NvdXJjZS90b29scy9saWIvYnBmL2xpYmJwZi5jI0w2MDg3DQopLiBPYnZp
b3VzbHkgdGhpcyAqY2FuKiBiZSBkb25lIGJ1dCBpdCdzIG5vdCBhdCBhbGwgaWRlYWwgZnJvbSBh
bg0KYXBwbGljYXRpb24gcGVyc3BlY3RpdmUuDQoNCg0KPiA+ID4gPiANCj4gPiBicGZfb2JqZWN0
IGlzIHRoZSB1bml0IG9mIGNvaGVyZW5jZSBpbiBsaWJicGYsIHNvIEkgZG9uJ3Qgc2VlIHVzDQo+
ID4gcmVmY291bnRpbmcgbWFwcyBiZXR3ZWVuIGJwZl9vYmplY3RzLiBLZXJuZWwgaXMgZG9pbmcg
cmVmY291bnRpbmcNCj4gPiBiYXNlZCBvbiBGRHMsIHNvIHNlZSBpZiB5b3UgY2FuIHVzZSB0aGF0
Lg0KPiA+IA0KDQpJIGNhbiB1bmRlcnN0YW5kIHRoYXQuIFRoYXQgc2FpZCwgSSB0aGluayBpZiB0
aGVyZSdzIG5vIGxvZ2ljIGFjcm9zcw0Kb2JqZWN0cywgYW5kIGJwZl9vYmplY3QgYWNjZXNzIGlz
IG5vdCB0aHJlYWQtc2FmZSwgaXQgcHV0cyB1cyBpbnRvIGENCnRvdWdoIHNpdHVhdGlvbjoNCi0g
Q29tcGxleCByZWZjb3VudGluZywgY29kZSBzY2FubmluZywgZXRjIHRvIGtlZXAgY29uc2lzdGVu
Y3kgd2hlbg0KbWFuaXB1bGF0aW5nIG1hcHMgdXNlZCBieSBtdWx0aXBsZSBwcm9ncmFtcy4NCi0g
UGFyYWxsZWwgbG9hZGluZyBub3QgYmVpbmcgd2VsbC1iYWxhbmNlZCwgaWYgd2Ugc3BsaXQgcHJv
Z3JhbXMgYWNyb3NzDQpvYmplY3RzLg0KDQpXZSBjb3VsZCBhbHRlcm5hdGl2ZWx5IHdyaXRlIG91
ciBvd24gY3VzdG9tIGxvYWRlciwgYnV0IHRoZW4gd2XigJlkIGhhdmUNCnRvIGR1cGxpY2F0ZSBt
dWNoIG9mIHRoZSB1c2VmdWwgbG9naWMgdGhhdCBsaWJicGYgYWxyZWFkeSBpbXBsZW1lbnRzOg0K
c2tlbGV0b24gZ2VuZXJhdGlvbiwgbWFwL3Byb2dyYW0gYXNzb2NpYXRpb24sIGVtYmVkZGluZyBw
cm9ncmFtcyBpbnRvDQpFTEZzLCBsb2FkaW5nIGxvZ2ljIGFuZCBrZXJuZWwgcHJvYmluZywgZXRj
LiBXZeKAmWQgbGlrZSBzb21lIHdheSB0bw0KaGFuZGxlIGR5bmFtaWMvcGFyYWxsZWwgbG9hZGlu
ZyB3aXRob3V0IGhhdmluZyB0byByZXBsaWNhdGUgYWxsIHRoZQ0KYWR2YW50YWdlcyBsaWJicGYg
Z3JhbnRzIHVzLg0KDQo+ID4gDQo+ID4gDQo+ID4gSXMgMTAwIGp1c3QgYSBuaWNlbHkgbG9va2lu
ZyByYXRoZXIgbGFyZ2UgbnVtYmVyLCBvciBkbyB5b3UgcmVhbGx5DQo+ID4gaGF2ZSAxMDAgZGlm
ZmVyZW50IEJQRiBwcm9ncmFtcz8gV2h5IHNvIG1hbnkgYW5kIGFyZSB0aGV5IHJlYWxseQ0KPiA+
IGFsbA0KPiA+IHVuaXF1ZT8NCj4gPiANCj4gPiBBc2tpbmcgYmVjYXVzZSBpZiBpdCdzIGp1c3Qg
YSB3YXkgdG8gYXR0YWNoIEJQRiBwcm9ncmFtIGRvaW5nIG1vcmUNCj4gPiBvcg0KPiA+IGxlc3Mg
dW5pZm9ybSBzZXQgb2YgYWN0aW9ucyBmb3IgZGlmZmVyZW50IGhvb2tzLCB0aGVuIHBlcmhhcHMg
dGhlcmUNCj4gPiBhcmUgYmV0dGVyIHdheXMgdG8gZG8gdGhpcyB3aXRob3V0IGhhdmluZyB0byBk
dXBsaWNhdGluZyBCUEYNCj4gPiBwcm9ncmFtcw0KPiA+IHNvIG11Y2ggKGxpa2UgQlBGIGNvb2tp
ZSwgbXVsdGkta3Byb2JlcywgZXRjLCBldGMpDQoNCjEwMCBpcyBub3QgYW4gYXJiaXRyYXJ5IG51
bWJlcjsgd2UgaGF2ZSB0aGF0IGFuZCBoaWdoZXIgKH4yMDAgaXMgYSBnb29kDQpjdXJyZW50IGVz
dGltYXRlLCBhbmQgdGhhdCBncm93cyBhcyBuZXcgcHJvZHVjdCBmZWF0dXJlcyBhcmUgYWRkZWQp
Lg0KVGhlIHByb2dyYW1zIGFyZSByZWFsbHkgZG9pbmcgZGlmZmVyZW50IHRoaW5ncy4gV2UgYWxz
byBoYXZlIHRvIHN1cHBvcnQNCmEgd2lkZSByYW5nZSBvZiBrZXJuZWxzLCBoYW5kbGluZyBjYXNl
cyBsaWtlOiAib24gdGhpcyBrZXJuZWwgcmFuZ2UsDQp0cmFtcG9saW5lcyBhcmVuJ3Qgc3VwcG9y
dGVkLCBzbyB1c2Uga3JldHByb2JlcyB3aXRoIGEgY29udGV4dCBtYXAgZm9yDQpmdW5jdGlvbiBh
cmdzIGluc3RlYWQgb2YgZmV4aXQsIGJ1dCBvbiBuZXdlciBrZXJuZWxzIGp1c3QgdXNlIGFuIGZl
eGl0DQpob29rLiINCg0KVGhlIHVzZSBjYXNlIGhlcmUgaXMgdGhhdCBvdXIgc2VjdXJpdHkgbW9u
aXRvcmluZyBhZ2VudCBsZXZlcmFnZXMgZUJQRg0KYXMgaXRzIGZvdW5kYXRpb25hbCB0ZWNobm9s
b2d5IHRvIGdhdGhlciB0ZWxlbWV0cnkgZnJvbSB0aGUga2VybmVsLiBBcw0KcGFydCBvZiB0aGF0
LCB3ZSBob29rIG1hbnkgZGlmZmVyZW50IGtlcm5lbCBzdWJzeXN0ZW1zIChwcm9jZXNzLA0KbWVt
b3J5LCBmaWxlc3lzdGVtLCBuZXR3b3JrLCBldGMpLCB0eWluZyB0aGVtIHRvZ2V0aGVyIGFuZCB0
cmFja2luZw0Kd2l0aCBtYXBzLiBTbyB3ZSBsZWdpdGltYXRlbHkgaGF2ZSBhIHZlcnkgbGFyZ2Ug
bnVtYmVyIG9mIHByb2dyYW1zIGFsbA0KZG9pbmcgZGlmZmVyZW50IHdvcmsuIEZvciBwcm9kdWN0
cyBvZiB0aGlzIHNjYWxlLCBpdCBpbmNyZWFzZXMgc2VjdXJpdHkNCmFuZCBwZXJmb3JtYW5jZSB0
byBsb2FkIHRoaXMgc2V0IG9mIHByb2dyYW1zIGFuZCB0aGVpciBtYXBzIGluIGFuDQpvcHRpbWl6
ZWQsIHBhcmFsbGVsIGZhc2hpb24gYW5kIHN1YnNlcXVlbnRseSBjaGFuZ2UgdGhlIGxvYWRlZCBz
ZXQgb2YNCnByb2dyYW1zIGFuZCBtYXBzIGR5bmFtaWNhbGx5IHdpdGhvdXQgZGlzdHVyYmluZyB0
aGUgcmVzdCBvZiB0aGUNCmFwcGxpY2F0aW9uLg0K

