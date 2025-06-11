Return-Path: <linux-kselftest+bounces-34758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B390AD603C
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 22:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E79C3AAB60
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 20:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935682BD59B;
	Wed, 11 Jun 2025 20:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="XJkWT7MO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAB01B0F19;
	Wed, 11 Jun 2025 20:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749674455; cv=none; b=A+986G2SUpQVP/DbhT04+KLOzrsT3BUCTlEuAUBDaF4TAT7LtbpfEHSphh3BRYMZuT7UPpSmqwJq8LMM2pMG3Arvv9wJyeDHwO6/r9v4Yq3lksJz6RHhszos+nWN8CboxV9RQoBz4anlkzpMnSeNspQHSl+wmDeHDmqEtMtPdYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749674455; c=relaxed/simple;
	bh=KCDA6Zq4eciz2ZLQLHx4SDBnp9mfmlLvEJstbWkDAhU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=MpdgcYGWztWkMfsMCIo09HOdsRSuQuum20xaejSGoujwWkN7I9+lFF3sO1O0FUHnoNspnEBj/vEU/CrNZ5s1GzvSXG5wKiYq5JwcZt5IHiIa30ZADIchSGn53K2xN5LTjTID79BnkuQ92w74n7krXzFcwUh0rQ3OklsNOhRz9H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=XJkWT7MO; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BK1lZA001834;
	Wed, 11 Jun 2025 20:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-id:content-transfer-encoding:content-type:date
	:from:in-reply-to:message-id:mime-version:subject:to; s=default;
	 bh=KCDA6Zq4eciz2ZLQLHx4SDBnp9mfmlLvEJstbWkDAhU=; b=XJkWT7MO7Apv
	0C+8QWuriw6f6IBx2QmCGGZWMn6MIlv8lHgzjSo3/H+op48zJ0baKFESE2bLiwuB
	Kk//QLzHTzNrIVk3oRoxJJBhG2WxEm3LZF0PsgYLT+FrF6zt+e9zSfo72To9JLY7
	rg9TEU9YoAK9RXE0xuzOiNaw6A2wjlAzVYo++hxcTN37IdR50gIsrHAKWI7L5bVt
	YJQq+W52f48TfiRy9NRKJzgGd+tsSZ+TYdc2dUFObaYqyfdiw3vTSB6NlSpYqMf+
	JIJ3hzOIS8HbJdFywM4ralW6pNU81LtToY2ptH3NoXAr1mOUmc4BiPP6OAKNimuS
	VwGALzAFOQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 47602mcqbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 20:40:13 +0000 (GMT)
Received: from 04WPEXCH007.crowdstrike.sys (10.100.11.74) by
 04WPEXCH010.crowdstrike.sys (10.100.11.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 11 Jun 2025 20:40:12 +0000
Received: from 04WPEXCH007.crowdstrike.sys ([fe80::ed14:528a:c622:96df]) by
 04WPEXCH007.crowdstrike.sys ([fe80::ed14:528a:c622:96df%17]) with mapi id
 15.02.1544.009; Wed, 11 Jun 2025 20:40:12 +0000
From: Slava Imameev <slava.imameev@crowdstrike.com>
To: "qmo@kernel.org" <qmo@kernel.org>
CC: "andrii@kernel.org" <andrii@kernel.org>,
        "ast@kernel.org"
	<ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "eddyz87@gmail.com"
	<eddyz87@gmail.com>,
        "haoluo@google.com" <haoluo@google.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "jolsa@kernel.org"
	<jolsa@kernel.org>,
        Justin Deschamp <justin.deschamp@crowdstrike.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        Mark Fontana
	<mark.fontana@crowdstrike.com>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "mykolal@fb.com" <mykolal@fb.com>,
        "sdf@fomichev.me"
	<sdf@fomichev.me>,
        "shuah@kernel.org" <shuah@kernel.org>,
        Slava Imameev
	<slava.imameev@crowdstrike.com>,
        "song@kernel.org" <song@kernel.org>,
        "yonghong.song@linux.dev" <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 1/2] bpftool: Use appropriate permissions for
 map access
Thread-Topic: [PATCH bpf-next v2 1/2] bpftool: Use appropriate permissions for
 map access
Thread-Index: AQHb2xEHLNWmNiS110S7Xob0pzp7lw==
Date: Wed, 11 Jun 2025 20:40:12 +0000
Message-ID: <3B98B12C-05AB-400E-ACB1-11D3CF188CE2@contoso.com>
In-Reply-To: <<c3b403f5-4849-44f3-82cb-b0b506b10138@kernel.org>>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-disclaimer: USA
Content-Type: text/plain; charset="utf-8"
Content-ID: <972AB3C86844BC4285F020E8DFD32A32@crowdstrike.sys>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Authority-Analysis: v=2.4 cv=QdVmvtbv c=1 sm=1 tr=0 ts=6849e9ad cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=xqWC_Br6kY4A:10 a=EjBHVkixTFsA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=pl6vuDidAAAA:8 a=j6b8ci30a58VJQJFYksA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: XElHJLKqTw3-9czRKakvfgh9_tmvEqND
X-Proofpoint-ORIG-GUID: XElHJLKqTw3-9czRKakvfgh9_tmvEqND
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDE3NCBTYWx0ZWRfXxIRpR+2f8Fim
 i5Lr2L62ltc23Ofe5sGt5xYstSZ7PXrlpTQm68e5kWDXl1uUsf9jobwp8myVN8e7Nmtm7UrdHU0
 rrUZpcrFfPe/V5yU7B3nYVGFgzOuMKngSoDpNImrG5uvLC90OBhRSg2QpSgfC/oCbgOklhKPChm
 AOhnQj+5xlMt17mhGn1QXxaDN7YFwjYY16vCuVDjwRd3LRj3A1w9YDZmZIHslzSxDc90SO4tbLR
 u4hZsFtRmbbwVeoECdcaQ6tseYgyuUiT2TyF2hLUunYa2ND0A2F9JNjPZT0ZMRBHqAreWG5XlXe
 Uh466iKANscoC3V05qyIsG2xbC5od6hChC84bXBFPeqBQYRVn96FfC2rnQ+Usx4DyDdzggrmQc6
 cxE/DHjAuDq/jzOGcc8qgrw/wfNhgNVR7HnirILua8lFk1E8TT8ut8CMrgJyjUYOBJ6Nrfmo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_09,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1011 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110174

PiA+IE1vZGlmeSBzZXZlcmFsIGZ1bmN0aW9ucyBpbiB0b29scy9icGYvYnBmdG9vbC9jb21tb24u
YyB0byBhbGxvdw0KPiA+IHNwZWNpZmljYXRpb24gb2YgcmVxdWVzdGVkIGFjY2VzcyBmb3IgZmls
ZSBkZXNjcmlwdG9ycywgc3VjaCBhcw0KPiA+IHJlYWQtb25seSBhY2Nlc3MuDQo+ID4gDQo+ID4g
VXBkYXRlIGJwZnRvb2wgdG8gcmVxdWVzdCBvbmx5IHJlYWQgYWNjZXNzIGZvciBtYXBzIHdoZW4g
d3JpdGUNCj4gPiBhY2Nlc3MgaXMgbm90IHJlcXVpcmVkLiBUaGlzIGZpeGVzIGVycm9ycyB3aGVu
IHJlYWRpbmcgZnJvbSBtYXBzDQo+ID4gdGhhdCBhcmUgcHJvdGVjdGVkIGZyb20gbW9kaWZpY2F0
aW9uIHZpYSBzZWN1cml0eV9icGZfbWFwLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFNsYXZh
IEltYW1lZXYgPHNsYXZhLmltYW1lZXZAY3Jvd2RzdHJpa2UuY29tPg0KPg0KPg0KPiBUaGFua3Mg
Zm9yIHRoaXMhDQo+DQo+IEkgdGhpbmsgdGhlIHRvcGljIG9mIG1hcCBhY2Nlc3MgaW4gYnBmdG9v
bCBoYXMgYmVlbiBkaXNjdXNzZWQgaW4gdGhlDQo+IHBhdGgsIGJ1dCBJIGNhbid0IHJlbWVtYmVy
IHdoYXQgd2Ugc2FpZCBvciBmaW5kIGl0IGFnYWluIC0gbWF5YmUgSSBkb24ndA0KPiByZW1lbWJl
ciBjb3JyZWN0bHkuIExvb2tzIGdvb2QgdG8gbWUgb3ZlcmFsbC4NCj4NCj4gT25lIHF1ZXN0aW9u
OiBIb3cgdGhvcm91Z2hseSBoYXZlIHlvdSB0ZXN0ZWQgdGhhdCB3cml0ZSBwZXJtaXNzaW9ucyBh
cmUNCj4gbmVjZXNzYXJ5IGZvciB0aGUgZGlmZmVyZW50IGNhc2VzPyBJJ20gYXNraW5nIGJlY2F1
c2UgSSdtIHdvbmRlcmluZw0KPiB3aGV0aGVyIHdlIGNvdWxkIHJlc3RyaWN0IHRvIHJlYWQtb25s
eSBpbiBhIGNvdXBsZSBtb3JlIGNhc2VzLCBzZWUNCj4gYmVsb3cuIChBdCB0aGUgZW5kIG9mIHRo
ZSBkYXkgaXQgZG9lc24ndCBtYXR0ZXIgdG9vIG11Y2gsIGl0J3MgZmluZQ0KPiBiZWluZyBjb25z
ZXJ2YXRpdmUgYW5kIGNvbnNlcnZpbmcgd3JpdGUgcGVybWlzc2lvbnMgZm9yIG5vdywgd2UgY2Fu
DQo+IGFsd2F5cyByZWZpbmUgbGF0ZXI7IGl0J3MgYWxyZWFkeSBhbiBpbXByb3ZlbWVudCB0byBk
byByZWFkLW9ubHkgZm9yIHRoZQ0KPiBkdW1wL2xpc3QgY2FzZXMpLg0KDQoNClRoZSBnb2FsIG9m
IHRoaXMgcGF0Y2ggd2FzIHRvIGZpeCBicGZ0b29sIGVycm9ycyB3ZSBleHBlcmllbmNlZCBvbiBv
dXIgc3lzdGVtcy4NClRoZSBlZmZvcnRzIHdlcmUgZm9jdXNlZCBvbmx5IG9uIGNoYW5nZXMgdG8g
dGhlIGFmZmVjdGVkIHN1YnNldCBvZiBtYXAgY29tbWFuZHMuDQoNCg0KPiA+ICsJCS8qIEdldCBh
biBmZCB3aXRoIHRoZSByZXF1ZXN0ZWQgb3B0aW9ucy4gKi8NCj4gPiArCQljbG9zZShmZCk7DQo+
ID4gKwkJZmQgPSBicGZfbWFwX2dldF9mZF9ieV9pZF9vcHRzKGlkLCBvcHRzKTsNCj4gPiArCQlp
ZiAoZmQgPCAwKSB7DQo+ID4gKwkJCXBfZXJyKCJjYW4ndCBnZXQgbWFwIGJ5IGlkICgldSk6ICVz
IiwgaWQsDQo+ID4gKwkJCSAgICAgIHN0cmVycm9yKGVycm5vKSk7DQo+ID4gKwkJCWdvdG8gZXJy
X2Nsb3NlX2ZkczsNCj4gPiArCQl9DQo+DQo+DQo+IFdlIGNvdWxkIG1heWJlIHNraXAgdGhpcyBz
dGVwIGlmIHRoZSByZXF1ZXN0ZWQgb3B0aW9ucyBhcmUgcmVhZC1vbmx5LCBubw0KPiBuZWVkIHRv
IGNsb3NlIGFuZCByZS1vcGVuIGEgZmQgaW4gdGhhdCBjYXNlPw0KDQoNCkkgYWdyZWUuIFRoZSBj
aGFuZ2Ugd2lsbCBiZSBzdWJtaXR0ZWQgd2l0aCB2ZXJzaW9uIDMuDQoNCg0KPiA+IC1pbnQgbWFw
X3BhcnNlX2ZkcyhpbnQgKmFyZ2MsIGNoYXIgKioqYXJndiwgaW50ICoqZmRzKQ0KPiA+ICtpbnQg
bWFwX3BhcnNlX2ZkcyhpbnQgKmFyZ2MsIGNoYXIgKioqYXJndiwgaW50ICoqZmRzLCBfX3UzMiBv
cGVuX2ZsYWdzKQ0KPiA+ICB7DQo+ID4gKwlMSUJCUEZfT1BUUyhicGZfZ2V0X2ZkX2J5X2lkX29w
dHMsIG9wdHMpOw0KPiA+ICsNCj4gPiArCWlmIChvcGVuX2ZsYWdzICYgfkJQRl9GX1JET05MWSkg
ew0KPiA+ICsJCXBfZXJyKCJpbnZhbGlkIG9wZW5fZmxhZ3M6ICV4Iiwgb3Blbl9mbGFncyk7DQo+
ID4gKwkJcmV0dXJuIC0xOw0KPiA+ICsJfQ0KPg0KPg0KPiBJIGRvbid0IHRoaW5rIHdlIG5lZWQg
dGhpcyBjaGVjaywgdGhlIGZsYWcgaXMgbmV2ZXIgcGFzc2VkIGJ5IHVzZXJzLiBJZg0KPiB5b3Ug
d2FudCB0byBjYXRjaCBhIGJ1ZywgdXNlIGFuIGFzc2VydCgpIGluc3RlYWQ/DQoNCg0KSSBhZ3Jl
ZS4gVGhpcyBjaGVjayBpcyByZXBsYWNlZCB3aXRoIGFuIGFzc2VydCBhbmQgd2lsbCBiZSBzdWJt
aXR0ZWQgd2l0aCB2My4NCg0KDQo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL2JwZi9icGZ0b29sL2l0
ZXIuYyBiL3Rvb2xzL2JwZi9icGZ0b29sL2l0ZXIuYw0KPiA+IGluZGV4IDVjMzljMmVkMzZhMi4u
YWQzMThhODY2N2E0IDEwMDY0NA0KPiA+IC0tLSBhL3Rvb2xzL2JwZi9icGZ0b29sL2l0ZXIuYw0K
PiA+ICsrKyBiL3Rvb2xzL2JwZi9icGZ0b29sL2l0ZXIuYw0KPiA+IEBAIC0zNyw3ICszNyw3IEBA
IHN0YXRpYyBpbnQgZG9fcGluKGludCBhcmdjLCBjaGFyICoqYXJndikNCj4gPiAgCQkJCXJldHVy
biAtMTsNCj4gPiAgCQkJfQ0KPiA+ICANCj4gPiAtCQkJbWFwX2ZkID0gbWFwX3BhcnNlX2ZkKCZh
cmdjLCAmYXJndik7DQo+ID4gKwkJCW1hcF9mZCA9IG1hcF9wYXJzZV9mZCgmYXJnYywgJmFyZ3Ys
IDApOw0KPg0KPg0KPiBEbyB5b3UgbmVlZCB3cml0ZSBwZXJtaXNzaW9ucyBoZXJlPyAoSSBkb24n
dCByZW1lbWJlci4pDQoNCg0KSXRlcmF0b3IgcmVxdWlyZXMgb25seSByZWFkIGFjY2Vzcy4gSSBj
aGFuZ2VkIGl0IHRvIEJQRl9GX1JET05MWSBmb3IgdjMuDQpBbiBpdGVyYXRvciB0ZXN0IGlzIGFk
ZGVkIHRvIHYzLg0KDQoNCj4gPiAtCWZkID0gbWFwX3BhcnNlX2ZkX2FuZF9pbmZvKCZhcmdjLCAm
YXJndiwgJmluZm8sICZsZW4pOw0KPiA+ICsJZmQgPSBtYXBfcGFyc2VfZmRfYW5kX2luZm8oJmFy
Z2MsICZhcmd2LCAmaW5mbywgJmxlbiwgQlBGX0ZfUkRPTkxZKTsNCj4NCj4NCj4gVGhpcyBvbmUg
aXMgc3VycHJpc2luZywgZG9uJ3QgeW91IG5lZWQgd3JpdGUgcGVybWlzc2lvbnMgdG8gZGVsZXRl
IGFuDQo+IGVsZW1lbnQgZnJvbSB0aGUgbWFwPyBQbGVhc2UgZG91YmxlLWNoZWNrIGlmIHlvdSBo
YXZlbid0IGFscmVhZHksIEkNCj4gd291bGRuJ3Qgd2FudCB0byBicmVhayAiYnBmdG9vbCBtYXAg
ZGVsZXRlIi4NCj4NCj4gSSBub3RlIHlvdSBkb24ndCB0ZXN0IGl0ZW1zIGRlbGV0aW9uIGluIHlv
dXIgdGVzdHMsIGJ5IHRoZSB3YXkuDQoNCg0KUmlnaHQsIHRoZSBkZWxldGUgY29tbWFuZCByZXF1
aXJlcyB3cml0ZSBhY2Nlc3MuIEkgY2hhbmdlZCBpdCBhbmQgYWRkZWQNCmFuIGl0ZW0gZGVsZXRp
b24gdGVzdCB0byB2My4NCg0KDQo+ID4gIHN0YXRpYyBpbnQgZG9fcGluKGludCBhcmdjLCBjaGFy
ICoqYXJndikNCj4gPiAgew0KPiA+ICAJaW50IGVycjsNCj4gPiAgDQo+ID4gLQllcnIgPSBkb19w
aW5fYW55KGFyZ2MsIGFyZ3YsIG1hcF9wYXJzZV9mZCk7DQo+ID4gKwllcnIgPSBkb19waW5fYW55
KGFyZ2MsIGFyZ3YsIG1hcF9wYXJzZV9yZWFkX29ubHlfZmQpOw0KPiA+ICAJaWYgKCFlcnIgJiYg
anNvbl9vdXRwdXQpDQo+ID4gIAkJanNvbndfbnVsbChqc29uX3d0cik7DQo+ID4gIAlyZXR1cm4g
ZXJyOw0KPiA+IEBAIC0xMzE5LDcgKzEzMjksNyBAQCBzdGF0aWMgaW50IGRvX2NyZWF0ZShpbnQg
YXJnYywgY2hhciAqKmFyZ3YpDQo+ID4gIAkJCWlmICghUkVRX0FSR1MoMikpDQo+ID4gIAkJCQl1
c2FnZSgpOw0KPiA+ICAJCQlpbm5lcl9tYXBfZmQgPSBtYXBfcGFyc2VfZmRfYW5kX2luZm8oJmFy
Z2MsICZhcmd2LA0KPiA+IC0JCQkJCQkJICAgICAmaW5mbywgJmxlbik7DQo+ID4gKwkJCQkJCQkg
ICAgICZpbmZvLCAmbGVuLCAwKTsNCj4NCj4NCj4gRG8geW91IG5lZWQgd3JpdGUgcGVybWlzc2lv
bnMgZm9yIHRoZSBpbm5lciBtYXAncyBmZD8gVGhpcyBpcyBzb21ldGhpbmcNCj4gdGhhdCBjb3Vs
ZCBiZSB3b3J0aCBjaGVja2luZyBpbiB0aGUgdGVzdHMsIGFzIHdlbGwuDQoNClRoZSBpbm5lciBt
YXAgZmQgY2FuIGJlIGNyZWF0ZWQgd2l0aCByZWFkIG9ubHkgYWNjZXNzLiBJIGNoYW5nZWQgaXQg
YW5kIGFkZGVkDQphIHRlc3QgZm9yIG1hcC1vZi1tYXBzIGNyZWF0aW9uIHRvIHYzLg0KDQoNCj4g
PiBAQCAtMTI4LDcgKzEyOCw4IEBAIGludCBkb19ldmVudF9waXBlKGludCBhcmdjLCBjaGFyICoq
YXJndikNCj4gPiAgCWludCBlcnIsIG1hcF9mZDsNCj4gPiAgDQo+ID4gIAltYXBfaW5mb19sZW4g
PSBzaXplb2YobWFwX2luZm8pOw0KPiA+IC0JbWFwX2ZkID0gbWFwX3BhcnNlX2ZkX2FuZF9pbmZv
KCZhcmdjLCAmYXJndiwgJm1hcF9pbmZvLCAmbWFwX2luZm9fbGVuKTsNCj4gPiArCW1hcF9mZCA9
IG1hcF9wYXJzZV9mZF9hbmRfaW5mbygmYXJnYywgJmFyZ3YsICZtYXBfaW5mbywgJm1hcF9pbmZv
X2xlbiwNCj4gPiArCQkJCSAgICAgICAwKTsNCj4NCj4NCj4gVGhpcyBvbmUgbWlnaHQgYmUgd29y
dGggY2hlY2tpbmcsIHRvby4NCg0KDQpBbiBldmVudCBwaXBlIG1hcCBmZCByZXF1aXJlcyB3cml0
ZSBhY2Nlc3MgYXMgdGhlIG1hcCBpcyB1cGRhdGVkIGJ5IGJwZl9tYXBfdXBkYXRlX2VsZW0gDQpp
bnNpZGUgX19wZXJmX2J1ZmZlcl9fbmV3IC4NCg0KDQoNCg==

