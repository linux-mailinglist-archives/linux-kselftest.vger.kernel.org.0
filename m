Return-Path: <linux-kselftest+bounces-26068-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9288A2D281
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 02:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D86216C675
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 01:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1716426ACB;
	Sat,  8 Feb 2025 01:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="Jb6j2BoJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151636FBF;
	Sat,  8 Feb 2025 01:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738977264; cv=none; b=LuGDuSOryRrYr6KYWuIMVrEuGo+PCyWzQUU/R5pca97in6q9usBmVVBas9hoXHiGXqD1orwv6YGClyEazJ8UtqAkl9cBt7J1Dwa9wMY2SukXmy3fgeAMVlbtL0BQZUg5dW7EtNyDfXsgz6TxzCyvJ8X2STvnGbS4Wwm+l9aeAFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738977264; c=relaxed/simple;
	bh=jNCpAzIcqev4f9UQb2eDkAlzLe9BucpDS3pd8CHTFXA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nB2aDpSpzPpVuBtam3MoDv+AfACp6weDAyHSZxQckr/CLPGeR4shG4Yo18hcOPL3trpHLJ/QPhLlZgCPxz+Fur4+lgKClRz0sLTpF1MFWtBDVk+3NGfQeDrCRbFH3bs+Un3WvX7BBqjaLF0mLBfMCI+eEp0TSDFC2DSPQ5cFd04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=Jb6j2BoJ; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51812QQU029920;
	Sat, 8 Feb 2025 01:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-id:content-transfer-encoding:content-type:date
	:from:in-reply-to:message-id:mime-version:references:subject:to;
	 s=default; bh=jNCpAzIcqev4f9UQb2eDkAlzLe9BucpDS3pd8CHTFXA=; b=J
	b6j2BoJIHWQURpER6VKDgj7NIRM+EeSn+ax0SlXkdDN6ka2MA3FXZVX7GV6HJHLn
	fcbIH3TI63FK9SJOi8BNybEVOE4RgUkbU+ay4yfM/vmVuIC6+YG7aPHOqnarulNX
	h2rZ5N2mBt6xor7XnQkC6ROL5XtTOZGUzBKoOWjyGEVhF4/4fxZ5phSZfohUFCJm
	wS/PPaSwgoWvFbaxdKfBYLCkGsktzMOW/P4furA6EvI1o3N7OCxztckxk6qcGl8n
	c2th3puMdfC9GHxjZfm3ythyOSodMGynGE9VQOKjd9yFRTcjK7b9a9s0u80PNrAH
	TcwAu1ggnG1Qh4K3xzbjQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 44nw8nr0m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Feb 2025 01:13:41 +0000 (GMT)
Received: from 04WPEXCH006.crowdstrike.sys (10.100.11.70) by
 04WPEXCH010.crowdstrike.sys (10.100.11.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 8 Feb 2025 01:13:40 +0000
Received: from 04WPEXCH006.crowdstrike.sys ([fe80::a97d:6ad:c239:d138]) by
 04WPEXCH006.crowdstrike.sys ([fe80::a97d:6ad:c239:d138%11]) with mapi id
 15.02.1544.009; Sat, 8 Feb 2025 01:13:40 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC: "mykolal@fb.com" <mykolal@fb.com>, "shuah@kernel.org" <shuah@kernel.org>,
        "eddyz87@gmail.com" <eddyz87@gmail.com>,
        "song@kernel.org" <song@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>,
        "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>,
        Mark Fontana <mark.fontana@crowdstrike.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>,
        "sdf@fomichev.me" <sdf@fomichev.me>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Slava
 Imameev" <slava.imameev@crowdstrike.com>,
        "jolsa@kernel.org"
	<jolsa@kernel.org>,
        "haoluo@google.com" <haoluo@google.com>
Subject: Re: Re: Re: [PATCH 2/2] libbpf: BPF programs dynamic loading and
 attaching
Thread-Topic: Re: Re: [PATCH 2/2] libbpf: BPF programs dynamic loading and
 attaching
Thread-Index: AQHbecav9nRBOq2DfUeSAbcgaw09bA==
Date: Sat, 8 Feb 2025 01:13:40 +0000
Message-ID: <e55a1441252079e73b2abdf3635efcebda6b47c1.camel@crowdstrike.com>
References: <20250122215206.59859-1-slava.imameev@crowdstrike.com>
	 <20250122215206.59859-2-slava.imameev@crowdstrike.com>
	 <CAEf4Bzajxh4xvg-aCaBhLQdNOZdhwceYUD2UsCcWku4ZBca_Hw@mail.gmail.com>
	 <8831ed8fa183f76fefd71244360fa0ca35b11910.camel@crowdstrike.com>
	 <CAEf4BzYWe0KCzA4-qwAGp5n_ydJ0_zyLSO=Crr_vewFHzZ0t6Q@mail.gmail.com>
In-Reply-To: <CAEf4BzYWe0KCzA4-qwAGp5n_ydJ0_zyLSO=Crr_vewFHzZ0t6Q@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-disclaimer: USA
Content-Type: text/plain; charset="utf-8"
Content-ID: <90FF9234E64F0B49B5C32B384A37DD60@crowdstrike.sys>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Authority-Analysis: v=2.4 cv=RKRJH5i+ c=1 sm=1 tr=0 ts=67a6afc5 cx=c_pps a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17 a=xqWC_Br6kY4A:10 a=EjBHVkixTFsA:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=2lv7Y3VLJWSzW0Zh9XgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vFE_OMtF5u_BGEUe2um5qLCyLQAkJugg
X-Proofpoint-ORIG-GUID: vFE_OMtF5u_BGEUe2um5qLCyLQAkJugg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_11,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 spamscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502080006

T24gV2VkLCAyMDI1LTAyLTA1IGF0IDE0OjMzIC0wODAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQo+ID4gPiA+IA0KPiA+ID4gPiBJIHNlZSB0d28gd2F5cyBmb3J3YXJkIGZvciB5b3UuIEVpdGhl
ciB5b3UgY2FuIGJyZWFrIGFwYXJ0IHlvdXINCj4gPiA+ID4gQlBGDQo+ID4gPiA+IG9iamVjdCBv
ZiB+MTAwIEJQRiBwcm9ncmFtcyBpbnRvIG1vcmUgaW5kZXBlbmRlbnQgQlBGIG9iamVjdHMgPg0K
PiA+ID4gPiA+IChzZWVpbmcNCj4gPiA+ID4gdGhhdCBwcm9ncmFtcyBjYW4gYmUgaW5kZXBlbmRl
bnRseSBsb2FkZWQvdW5sb2FkZWQgZGVwZW5kaW5nIG9uDQo+ID4gPiA+IGNvbmZpZ3VyYXRpb24s
IHNlZW1zIGxpa2UgeW91IGRvIGhhdmUgYSBidW5jaCBvZiBsb2dpYyA+ID4NCj4gPiA+ID4gaW5k
ZXBlbmRlbmNlLA0KPiA+ID4gPiByaWdodD8pLiBJIGFzc3VtZSBzaGFyZWQgQlBGIG1hcHMgYXJl
IHRoZSBiaWdnZXN0IHJlYXNvbiB0bw0KPiA+ID4gPiBrZWVwID4gPiBhbGwNCj4gPiA+ID4gdGhv
c2UgcHJvZ3JhbXMgdG9nZXRoZXIgaW4gb25lIEJQRiBvYmplY3QuIFRvIHNoYXJlIEJQRiBtYXBz
ID4NCj4gPiA+ID4gPiBiZXR3ZWVuDQo+ID4gPiA+IG11bHRpcGxlIEJQRiBvYmplY3RzIGxpYmJw
ZiBwcm92aWRlcyB0d28gY29tcGxlbWVudGFyeQ0KPiA+ID4gPiBpbnRlcmZhY2VzOg0KPiA+ID4g
PiANCj4gPiA+ID4gwqAgLSBicGZfbWFwX19yZXVzZV9mZCgpIGZvciBtYW51YWwgY29udHJvbA0K
PiA+ID4gPiDCoCAtIEJQRiBtYXAgcGlubmluZyAoY291bGQgYmUgZGVjbGFyYXRpdmUgb3IgbWFu
dWFsKQ0KPiA+ID4gPiANCj4gPiA+ID4gVGhpcyB3YXkgeW91IGNhbiBlbnN1cmUgdGhhdCBhbGwg
QlBGIG9iamVjdHMgd291bGQgdXNlIHRoZSBzYW1lDQo+ID4gPiA+IEJQRg0KPiA+ID4gPiBtYXAs
IHdoZXJlIG5lY2Vzc2FyeS4NCj4gPiA+ID4gDQoNCkkgdGhpbmsgdGhpcyBhcHByb2FjaCAqY291
bGQqIHdvcmsgYnV0IGNvdWxkIGVhc2lseSBiZWNvbWUgY29tcGxleCBmb3INCnVzIGJlY2F1c2Ug
d2UnZCBuZWVkIHRvIHRyYWNrIGFsbCB0aGUgZGVwZW5kZW5jaWVzIGJldHdlZW4gcHJvZ3JhbXMg
YW5kDQptYXBzLCBhbmQgYW55dGhpbmcgbWlzc2VkIGNvdWxkIGxlYWQgdG8gZGlmZmljdWx0IHJl
ZmNvdW50IGJ1Z3MuDQoNCkZ1cnRoZXIsIHNwbGl0dGluZyBpbnRvIG9iamVjdHMgaW5jdXJzIHNv
bWUgcGVyZm9ybWFuY2UgYW5kIG1lbW9yeSBjb3N0DQpiZWNhdXNlIGJwZl9vYmplY3RfX2xvYWRf
dm1saW51eF9idGYgd2lsbCBiZSBjYWxsZWQgZm9yIGVhY2ggb2JqZWN0LA0KYW5kIHRoZXJlJ3Mg
Y3VycmVudGx5IG5vIHdheSB0byBzaGFyZSBCVEYgZGF0YSBhY3Jvc3MgdGhlIG9iamVjdHMuDQpI
YXZpbmcgYSBzaW5nbGUgQlBGIG9iamVjdCBhdm9pZHMgdGhpcyBpc3N1ZS4gUG90ZW50aWFsbHks
IGxpYmJwZiBjb3VsZA0KY2FjaGUgc29tZSBCVEYgZGF0YSB0byBtYWtlIGxlc3NlbiB0aGUgaW1w
YWN0Lg0KDQo+ID4gPiA+IEFsdGVybmF0aXZlbHksIHdlIGNhbiBsb29rIGF0IHRoaXMgcHJvYmxl
bSBhcyBuZWVkaW5nIGxpYmJwZiB0bw0KPiA+ID4gPiA+ID4gb25seQ0KPiA+ID4gPiBwcmVwYXJl
IEJQRiBwcm9ncmFtIGNvZGUgKGRvaW5nIGFsbCB0aGUgcmVsb2NhdGlvbnMgYW5kIHN0dWZmDQo+
ID4gPiA+IGxpa2UNCj4gPiA+ID4gdGhhdCksIGJ1dCB0aGVuIGFwcGxpY2F0aW9uIGFjdHVhbGx5
IHRha2luZyBjYXJlIG9mID4gPg0KPiA+ID4gPiBsb2FkaW5nL3VubG9hZGluZw0KPiA+ID4gPiBC
UEYgcHJvZ3JhbSB3aXRoIGJwZl9wcm9nX2xvYWQoKSBvdXRzaWRlIG9mIGJwZl9vYmplY3QNCj4g
PiA+ID4gYWJzdHJhY3Rpb24uDQo+ID4gPiA+IEkndmUgaGFkIGFuIGFsbW9zdCByZWFkeSBwYXRj
aGVzIHNwbGl0dGluZyBicGZfb2JqZWN0X19sb2FkKCkNCj4gPiA+ID4gaW50byA+ID4gPiB0d28N
Cj4gPiA+ID4gc3RlcHM6IGJwZl9vYmplY3RfX3ByZXBhcmUoKSBhbmQgYnBmX29iamVjdF9fbG9h
ZCgpIGFmdGVyIHRoYXQuDQo+ID4gPiA+ICJwcmVwYXJlIiBzdGVwIHdvdWxkIGNyZWF0ZSBCUEYg
bWFwcywgbG9hZCBCVEYgaW5mb3JtYXRpb24sDQo+ID4gPiA+IHBlcmZvcm0NCj4gPiA+ID4gbmVj
ZXNzYXJ5IHJlbG9jYXRpb25zIGFuZCBhcnJpdmUgYXQgZmluYWwgc3RhdGUgb2YgQlBGIHByb2dy
YW0NCj4gPiA+ID4gY29kZQ0KPiA+ID4gPiAod2hpY2ggeW91IGNhbiBnZXQgd2l0aCBicGZfcHJv
Z3JhbV9faW5zbnMoKSBBUEkpLCBidXQgc3RvcHBpbmcNCj4gPiA+ID4gPiA+IGp1c3QNCj4gPiA+
ID4gc2hvcnQgb2YgYWN0dWFsbHkgZG9pbmcgYnBmX3Byb2dfbG9hZCgpIHN0ZXAuDQo+ID4gPiA+
IA0KPiA+ID4gPiBUaGlzIHNlZW1zIGxpa2UgaXQgd291bGQgc29sdmUgeW91ciBwcm9ibGVtIGFz
IHdlbGwuIFlvdSdkIHVzZQ0KPiA+ID4gPiA+ID4gbGliYnBmDQo+ID4gPiA+IHRvIGRvIGFsbCB0
aGUgbG93LWxldmVsIEVMRiBwcm9jZXNzaW5nIGFuZCByZWxvY2F0aW9uLCBidXQgdGhlbg0KPiA+
ID4gPiA+ID4gdGFrZQ0KPiA+ID4gPiBvdmVyIG1hbmFnaW5nIEJQRiBwcm9ncmFtIGxpZmV0aW1l
LiBMb2FkaW5nL3VubG9hZGluZyBhcyB5b3UNCj4gPiA+ID4gc2VlID4gPiBmaXQsDQo+ID4gPiA+
IGluY2x1ZGluZyBpbiBwYXJhbGxlbC4NCj4gPiA+ID4gDQo+ID4gPiA+IElzIHRoaXMgc29tZXRo
aW5nIHRoYXQgd291bGQgd29yayBmb3IgeW91Pw0KPiA+ID4gPiANCg0KSSB0aGluayB0aGlzIEFQ
SSBjb3VsZCB3b3JrLCB0aG91Z2ggSSB0aGluayB3ZSB3b3VsZCBuZWVkIGEgZmV3IG90aGVyDQpt
b2RpZmljYXRpb25zIGFzIHdlbGwgaW4gb3JkZXIgdG8gY29ycmVjdGx5IGhhbmRsZSBwcm9ncmFt
L21hcA0KZGVwZW5kZW5jaWVzIGFuZCBhY2NvdW50IGZvciByZWxvY2F0aW9ucy4gQXQgYSBoaWdo
IGxldmVsLCBJIHRoaW5rIHdlJ2QNCm5lZWQgc29tZXRoaW5nIHRoYXQgaW5jbHVkZXM6DQoNCjEp
IEEgd2F5IHRvIGFzc29jaWF0ZSBlYWNoIEJQRiBwcm9ncmFtIHdpdGggYWxsIHRoZSBtYXBzIGl0
IHdpbGwgdXNlDQooYXNzb2NpYXRpb24gb2Ygc3RydWN0IGJwZl9wcm9ncmFtICogLS0+IGxpc3Qg
b2Ygc3RydWN0IGJwZl9tYXAgKiBpbg0Kc29tZSBmb3JtKS4gVGhpcyBpcyBzbyB0aGF0IHdlIGNh
biBsb2FkL3VubG9hZCBhc3NvY2lhdGVkIG1hcHMgd2hlbiB3ZQ0KbG9hZC91bmxvYWQgYSBwcm9n
cmFtLg0KDQoyKSBBbiBBUEkgdG8gY3JlYXRlIGEgQlBGIG1hcCwgaW4gY2FzZSBhIG5ldyBtYXAg
bmVlZHMgdG8gYmUgbG9hZGVkDQphZnRlciBpbml0aWFsIHN0YXJ0dXAuDQoNCjMpIEFuIEFQSSB0
byBhbGxvdyB1bmxvYWRpbmcgYSBtYXAgd2hpbGUga2VlcGluZyBtYXAtPmZkIHJlc2VydmVkLiBU
aGlzDQppcyBpbXBvcnRhbnQgYmVjYXVzZSB0aGUgZmQgdmFsdWUgaXMgdXNlZCBieSBCUEYgcHJv
Z3JhbSBpbnN0cnVjdGlvbnMsDQpzbyB3aXRob3V0IHNvbWV0aGluZyBsaWtlIHRoaXMsIHdlJ2Qg
aGF2ZSB0byByZWRvIHRoZSByZWxvY2F0aW9uDQpwcm9jZXNzIGZvciBhbnkgb3RoZXIgQlBGIHBy
b2dyYW1zIHRoYXQgYWNjZXNzIHRoaXMgbWFwIChhbmQgdGh1cw0KcmVsb2FkIHRob3NlIHByb2dy
YW1zIHRvbykuIFRoaXMgQVBJIGNvdWxkIGJlIGltcGxlbWVudGVkIGJ5IGR1cCdpbmcgYQ0KcGxh
Y2Vob2xkZXIgZmQuDQoNCkFsdGVybmF0aXZlbHksIGlmIGxpYmJwZiBjb3VsZCBhdXRvbWF0aWNh
bGx5IHJlZmNvdW50IG1hcHMgYWNyb3NzDQptdWx0aXBsZSBCUEYgb2JqZWN0cyB0byBsb2FkL3Vu
bG9hZCB0aGVtIG9uIGRlbWFuZCwgdGhlbiBhbGwgb2YgdGhlDQphYm92ZSB3b3JrIGNvdWxkIGhh
cHBlbiBiZWhpbmQgdGhlIHNjZW5lcy4gVGhpcyB3b3VsZCBiZSBzaW1pbGFyIHRvIHRoZQ0Kb3Ro
ZXIgYXBwcm9hY2ggeW91IG1lbnRpb25lZCwgYnV0IHdpdGggbGliYnBmIGRvaW5nIHRoZSByZWZj
b3VudGluZw0KaGVhdnkgbGlmdGluZyBpbnN0ZWFkIG9mIGxlYXZpbmcgdGhhdCB0byBlYWNoIGFw
cGxpY2F0aW9uLCB0aHVzIG1vcmUNCnJvYnVzdCBhbmQgZWxlZ2FudC4gVGhpcyB3b3VsZCBtZWFu
IGNoYW5naW5nIGxpYmJwZiB0byAoYSkgc3luY2hyb25pemUNCmFjY2VzcyB0byBzb21lIG1hcCBm
dW5jdGlvbnMgYW5kIChiKSBhbGxvd2luZyBzdHJ1Y3QgYnBmX21hcCAqIHRvIGJlDQpzaGFyZWQg
YWNyb3NzIEJQRiBvYmplY3RzLiBQZXJoYXBzIGEgY29uY2VwdCBvZiBhICJjb2xsZWN0aW9uIG9m
IEJQRg0Kb2JqZWN0cyIgbWlnaHQgYWxsb3cgZm9yIHRoaXMuDQoNCj4gPiA+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+ID4gPiBUaGlzIHBhdGNoIHNldCBhbHNvIHBlcm1pdHMgbG9hZGluZyBCUEYg
cHJvZ3JhbXMgaW4NCj4gPiA+ID4gPiA+ID4gPiBwYXJhbGxlbCBpZiA+ID4gPiA+IHRoZQ0KPiA+
ID4gPiA+ID4gPiA+IGFwcGxpY2F0aW9uIHdpc2hlcy4gV2UgdGVzdGVkIHBhcmFsbGVsIGxvYWRp
bmcgd2l0aA0KPiA+ID4gPiA+ID4gPiA+IDIwMCsgQlBGID4gPiA+ID4gPiA+IHByb2dyYW1zDQo+
ID4gPiA+ID4gPiA+ID4gYW5kIGZvdW5kIHRoZSBsb2FkIHRpbWUgZHJvcHBlZCBmcm9tIDE4IHNl
Y29uZHMgdG8gNQ0KPiA+ID4gPiA+ID4gPiA+IHNlY29uZHMgPiA+ID4gPiB3aGVuID4gPiBkb25l
DQo+ID4gPiA+ID4gPiA+ID4gaW4gcGFyYWxsZWwgb24gYSA2Ljgga2VybmVsLg0KPiA+ID4gPiAN
Cj4gPiA+ID4gYnBmX29iamVjdCBpcyBpbnRlbnRpb25hbGx5IHNpbmdsZS10aHJlYWRlZCwgc28g
SSBkb24ndCB0aGluaw0KPiA+ID4gPiB3ZSdsbCA+ID4gPiBiZQ0KPiA+ID4gPiBzdXBwb3J0aW5n
IHBhcmFsbGVsIEJQRiBwcm9ncmFtIGxvYWRpbmcgaW4gdGhlIHBhcmFkaWdtIG9mID4gPg0KPiA+
ID4gPiBicGZfb2JqZWN0DQo+ID4gPiA+IChidXQgc2VlIHRoZSBicGZfb2JqZWN0X19wcmVwYXJl
KCkgcHJvcG9zYWwpLiBFdmVuIGZyb20gQVBJID4gPg0KPiA+ID4gPiA+IHN0YW5kcG9pbnQNCj4g
PiA+ID4gdGhpcyBpcyBwcm9ibGVtYXRpYyB3aXRoIGxvZ2dpbmcgYW5kIGxvZyBidWZmZXJzIGJh
c2ljYWxseQ0KPiA+ID4gPiBhc3N1bWluZw0KPiA+ID4gPiBzaW5nbGUtdGhyZWFkZWQgZXhlY3V0
aW9uIG9mIEJQRiBwcm9ncmFtIGxvYWRpbmcuDQo+ID4gPiA+IA0KPiA+ID4gPiBBbGwgdGhhdCBj
b3VsZCBiZSBjaGFuZ2VkIG9yIHdvcmtlZCBhcm91bmQsIGJ1dCB5b3VyIHVzZSBjYXNlDQo+ID4g
PiA+IGlzID4gPiBub3QNCj4gPiA+ID4gcmVhbGx5IGEgdHlwaWNhbCBjYXNlLCBzbyBJJ20gYSBi
aXQgaGVzaXRhbnQgYXQgdGhpcyBwb2ludC4NCj4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gDQoN
CkkgY2FuIHVuZGVyc3RhbmQgd2hlcmUgeW91J3JlIGNvbWluZyBmcm9tIGlmIG5vIG9uZSBlbHNl
IGhhcyBtZW50aW9uZWQNCmEgdXNlIGNhc2UgbGlrZSB0aGlzLiBXZSBjYW4gZG8gcGFyYWxsZWwg
bG9hZGluZyBieSBzcGxpdHRpbmcgb3VyDQpwcm9ncmFtcyBpbnRvIEJQRiBvYmplY3RzLCBidXQg
dW5sZXNzIHRoZSBvYmplY3RzIGFyZSBzcGxpdCB2ZXJ5DQpldmVubHksIHRoaXMgcmVzdWx0cyBp
biBsZXNzIG9wdGltYWwgbG9hZCB0aW1lLiBGb3IgZXhhbXBsZSwgaWYgMTAwDQpwcm9ncmFtcyBh
cmUgc3BsaXQgaW50byAyIG9iamVjdHMgYW5kIG9uZSBvYmplY3QgaGFzIDgwIHByb2dyYW1zIHdo
aWxlDQp0aGUgb3RoZXIgaGFzIDIwLCB0aGVuIHRoZSBvbmUgd2l0aCA4MCBwcm9ncmFtcyBjcmVh
dGVzIGEgYm90dGxlbmVjay4NCj4gDQo=

