Return-Path: <linux-kselftest+bounces-27396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6E4A4308B
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 00:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82EA1784AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 23:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02149207A18;
	Mon, 24 Feb 2025 23:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="lUII6+B4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0847314A4E9;
	Mon, 24 Feb 2025 23:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740438702; cv=none; b=cEE3tkK1QnDPQlhB2pHHMObjJY6BB2+r6WOm5ckwLsFFUrjWIIZAiXJVem1Vq7b5eZco8fU0jHrY0UIXDCZYDxCFeYLiLsW+PoRlO9osEZ/nJD9Y7kEvDroTW1jEbQoEA/ir9yjcMOQl1fACOz8A8P7kxnXc+5+dXGv6VbplPwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740438702; c=relaxed/simple;
	bh=QB3x1KLY18hKY7BMC1ZYeA7ozRdbCUZbm8o5J+y2roU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nZ7dGDhPtqa1wb3ywlZe9uihS3KJGdCpn9wOegmrqTNTWFLsj4o+ZHse/M0qhVkIpiyzFXV2KpcbmGVNWnTAIJ5otZzWvukahkGj/gmpzi0XWW7JetztxO2PLbBav/QBq6/xp2JMZjvxeyBjPdewBz3ZwxZyy6fFnRjjz0uROgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=lUII6+B4; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OLiSBZ020171;
	Mon, 24 Feb 2025 22:42:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-id:content-transfer-encoding:content-type:date
	:from:message-id:mime-version:subject:to; s=default; bh=QB3x1KLY
	18hKY7BMC1ZYeA7ozRdbCUZbm8o5J+y2roU=; b=lUII6+B4LeTJnToc0cMYgfCL
	9vfRl6gHomx0EB9Vayh6oxE84CEosiXiA6qVumpWk+KsCLhGXUFU2ZvHGMxA1mLs
	HIDVlZ34G7Zvo5U/yZf/10evcRCsqLUxDkUciKtFekc7G7fax0a6avj3AdVNgTfu
	U+HoBACihYuq73751L8pCyeVtyNkq0GSXVVb2Jx/PHkcO9xQ5wUv+C5GKgMdnxvm
	9sGhqf5pFx5464NAs7Nuxft3vu+uEZjebIeOUKlGF/WF38x2bEJMUUF8v5pe8rcT
	IrInZqPLiyHtwMZ+NgmAzXp4Gmpz85w2sDDjHEysgz7uttQ/mN+U9snK+aZCZA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 450uds9gar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 22:42:19 +0000 (GMT)
Received: from 04WPEXCH007.crowdstrike.sys (10.100.11.74) by
 04WPEXCH009.crowdstrike.sys (10.100.11.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 24 Feb 2025 22:42:18 +0000
Received: from 04WPEXCH007.crowdstrike.sys ([fe80::71b0:3fd9:97e2:1b60]) by
 04WPEXCH007.crowdstrike.sys ([fe80::71b0:3fd9:97e2:1b60%17]) with mapi id
 15.02.1544.009; Mon, 24 Feb 2025 22:42:18 +0000
From: Slava Imameev <slava.imameev@crowdstrike.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Martin Kelly
	<martin.kelly@crowdstrike.com>
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
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "haoluo@google.com"
	<haoluo@google.com>
Subject: Re: Re: Re: Re: Re: [PATCH 2/2] libbpf: BPF programs dynamic loading
 and attaching
Thread-Topic: Re: Re: Re: Re: [PATCH 2/2] libbpf: BPF programs dynamic loading
 and attaching
Thread-Index: AQHbhw1bjtPoKV3r702RMPzMHyrqIQ==
Date: Mon, 24 Feb 2025 22:42:18 +0000
Message-ID: <D680CE9F-138C-46AC-AC6A-E39A017F85B5@crowdstrike.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-disclaimer: USA
Content-Type: text/plain; charset="utf-8"
Content-ID: <84615FE15813DB488910B519C8E6E223@crowdstrike.sys>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: edFoCAYu03h1KNlcbw4vZx9DakPsxFqh
X-Proofpoint-GUID: edFoCAYu03h1KNlcbw4vZx9DakPsxFqh
X-Authority-Analysis: v=2.4 cv=MJ2amNZl c=1 sm=1 tr=0 ts=67bcf5cb cx=c_pps a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17 a=xqWC_Br6kY4A:10 a=EjBHVkixTFsA:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=uherdBYGAAAA:8 a=P-IC7800AAAA:8
 a=Sp80ZMMvcLK7cHnEBosA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_11,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502240144

PiA+ID4gT24gTW9uLCAyMDI1LTAyLTEwIGF0IDE2OjA2IC0wODAwLCBBbmRyaWkgTmFrcnlpa28g
d3JvdGU6DQo+ID4gPiA+IFRyYWNraW5nIGFzc29jaWF0ZWQgbWFwcyBmb3IgYSBwcm9ncmFtIGlz
IG5vdCBuZWNlc3NhcnkuIEFzIGxvbmcgYXMNCj4gPiA+ID4gdGhlIGxhc3QgQlBGIHByb2dyYW0g
dXNpbmcgdGhlIEJQRiBtYXAgaXMgdW5sb2FkZWQsIHRoZSBrZXJuZWwgd2lsbA0KPiA+ID4gPiBh
dXRvbWF0aWNhbGx5IGZyZWUgbm90LWFueW1vcmUtcmVmZXJlbmNlZCBCUEYgbWFwLiBOb3RlIHRo
YXQNCj4gPiA+ID4gYnBmX29iamVjdCBpdHNlbGYgd2lsbCBrZWVwIEZEcyBmb3IgQlBGIG1hcHMs
IHNvIHlvdSdkIG5lZWQgdG8gbWFrZQ0KPiA+ID4gPiBzdXJlIHRvIGRvIGJwZl9vYmplY3RfX2Ns
b3NlKCkgdG8gcmVsZWFzZSB0aG9zZSByZWZlcmVuY2VzLg0KPiA+ID4gPg0KPiA+ID4gPiBCdXQg
aWYgeW91IGFyZSBnb2luZyB0byBhc2sgdG8gcmUtY3JlYXRlIEJQRiBtYXBzIG5leHQgdGltZSBC
UEYNCj4gPiA+ID4gcHJvZ3JhbSBpcyBsb2FkZWQuLi4gV2VsbCwgSSdsbCBzYXkgeW91IGFyZSBh
c2tpbmcgZm9yIGEgYml0IHRvbyA+DQo+ID4gPiA+IG11Y2gsDQo+ID4gPiA+IHRiaC4gSWYgeW91
IHdhbnQgdG8gYmUgKnRoYXQqIHNvcGhpc3RpY2F0ZWQsIGl0IHNob3VsZG4ndCBiZSB0b28NCj4g
PiA+ID4gaGFyZA0KPiA+ID4gPiBmb3IgeW91IHRvIGdldCBhbGwgdGhpcyBpbmZvcm1hdGlvbiBm
cm9tIEJQRiBwcm9ncmFtJ3MNCj4gPiA+ID4gaW5zdHJ1Y3Rpb25zLg0KPiA+ID4gPg0KPiA+DQo+
ID4gV2UgcmVhbGx5IGFyZSB0aGF0IHNvcGhpc3RpY2F0ZWQgKHNlZSBiZWxvdyBmb3IgbW9yZSBk
ZXRhaWxzKS4gV2UgY291bGQNCj4gPiBzY2FuIHByb2dyYW0gaW5zdHJ1Y3Rpb25zLCBidXQgd2Un
ZCB0aGVuIHRpZSBvdXIgbG9naWMgdG8gQlBGDQo+ID4gaW1wbGVtZW50YXRpb24gZGV0YWlscyBh
bmQgZHVwbGljYXRlIGxvZ2ljIGFscmVhZHkgcHJlc2VudCBpbiBsaWJicGYNCj4gPiAoaHR0cHM6
Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2
LjEzLjIvc291cmNlL3Rvb2xzL2xpYi9icGYvbGliYnBmLmMgPGh0dHBzOi8vdXJsZGVmZW5zZS5j
b20vdjMvX19odHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni4xMy4yL3NvdXJjZS90
b29scy9saWIvYnBmL2xpYmJwZi5jPipMNjA4N19fO0l3ISFCbWR6UzNfbFY5SGRLRzghMzg0aGlS
Y3BtWU9qTVUza1QtMW00R3hXcDVYeHdIajlJQ3JEdElVS0NtQ2J4TFZBeGVtYzZVTjY0Y0UzTWt0
dV96NGYySmhlb0ttNlJCWVFkYy1NaVBieWV4azYtUm40OEEkDQo+ID4gKS4gT2J2aW91c2x5IHRo
aXMgKmNhbiogYmUgZG9uZSBidXQgaXQncyBub3QgYXQgYWxsIGlkZWFsIGZyb20gYW4NCj4gPiBh
cHBsaWNhdGlvbiBwZXJzcGVjdGl2ZS4NCj4gPg0KPg0KPg0KPiBJIGFncmVlIGl0J3Mgbm90IGlk
ZWFsLCBidXQgaXQncyBhbHNvIG5vdCBzb21lIGNvbXBsaWNhdGVkIGFuZA0KPiBib3VuZC10by1i
ZS1jaGFuZ2VkIGxvZ2ljLiBXaGF0IHlvdSBwb2ludCBvdXQgaW4gbGliYnBmIHNvdXJjZSBjb2Rl
IGlzDQo+IGEgYml0IGRpZmZlcmVudCB0aGluZywgcmVhbGl0eSBpcyBtdWNoIHNpbXBsZXIuIE9u
bHkgc28tY2FsbGVkIGxkaW1tNjQNCj4gaW5zdHJ1Y3Rpb24gKEJQRl9MRCB8IEJQRl9JTU0gfCBC
UEZfRFcgb3Bjb2RlKSBjYW4gYmUgcmVmZXJlbmNpbmcgbWFwDQo+IEZELCBzbyBhbmFseXNpbmcg
dGhpcyBpcyBib3JkZXJsaW5lIHRyaXZpYWwuIEFuZCB0aGlzIGlzIHBhcnQgb2YgQlBGDQo+IElT
QSwgc28gbm90IGdvaW5nIHRvIGNoYW5nZS4NCg0KDQpPdXIgYXBwcm9hY2ggaXMgdG8gYXNzb2Np
YXRlIGFuIGFycmF5IG9mIG1hcHMgYXMgYSBwcm9wZXJ0eSB3aXRoIGVhY2gNCkJQRiBwcm9ncmFt
LCB0aGlzIHByb3BlcnR5IGlzIGluaXRpYWxpc2VkIGF0IHRoZSByZWxvY2F0aW9uIHN0YWdlLg0K
U28sIHdlIGRvIG5vdCBuZWVkIHRvIHBhcnNlIEJQRiBwcm9ncmFtIGluc3RydWN0aW9ucy4gSW5z
dGVhZCwgd2UgcmVseSBvbg0KcmVjb3JkZWQgcmVsb2NhdGlvbnMuIEkgdGhpbmsgdGhpcyBpcyBh
IG1vcmUgcm9idXN0IGFuZCBjbGVhbiBzb2x1dGlvbiB3aXRoDQphZHZhbnRhZ2Ugb2YgYWxsIGNv
ZGUgaW4gdGhlIHNhbWUgcGxhY2UgYW5kIGJlaW5nIGF0IHRoZSBoaWdoZXIgbGV2ZWwgb2YNCmFi
c3RyYWN0aW9uIHdpdGggYSByZWxvY2F0aW9uIHRhYmxlLg0KDQpUaGUgbWFpbmxpbmUgbGliYnBm
IGtlZXBzIGFycmF5IG9mIG1hcHMgZm9yIGEgYnBmX29iamVjdCwgd2UgZXh0ZW5kZWQNCnRoaXMg
YnkgYWRkaW5nIGFuIGFycmF5IG9mIG1hcHMgYXNzb2NpYXRlZCB3aXRoIGVhY2ggYnBmX3Byb2dy
YW0uDQoNCkZvciBleGFtcGxlLCBhIGNvZGUgZXhjZXJwdCwgZnJvbSBvdXIgZGV2ZWxvcG1lbnQg
YnJhbmNoLCB3aGljaCBhc3NvY2lhdGVzDQphIG1hcCB3aXRoIGJwZl9wcm9ncmFtIGF0IHJlbG9j
YXRpb24gcGhhc2U6DQoNCiAgICAgaW5zblswXS5zcmNfcmVnID0gQlBGX1BTRVVET19NQVBfRkQ7
DQogICAgIGluc25bMF0uaW1tID0gbWFwLT5mZDsNCiAgICAgZXJyID0gYnBmX3Byb2dyYW1fX2Fk
ZF9tYXAocHJvZywgbWFwKTsNCg0KDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiBicGZfb2JqZWN0IGlz
IHRoZSB1bml0IG9mIGNvaGVyZW5jZSBpbiBsaWJicGYsIHNvIEkgZG9uJ3Qgc2VlIHVzDQo+ID4g
PiA+IHJlZmNvdW50aW5nIG1hcHMgYmV0d2VlbiBicGZfb2JqZWN0cy4gS2VybmVsIGlzIGRvaW5n
IHJlZmNvdW50aW5nDQo+ID4gPiA+IGJhc2VkIG9uIEZEcywgc28gc2VlIGlmIHlvdSBjYW4gdXNl
IHRoYXQuDQo+ID4gPiA+DQo+ID4NCj4gPiBJIGNhbiB1bmRlcnN0YW5kIHRoYXQuIFRoYXQgc2Fp
ZCwgSSB0aGluayBpZiB0aGVyZSdzIG5vIGxvZ2ljIGFjcm9zcw0KPiA+IG9iamVjdHMsIGFuZCBi
cGZfb2JqZWN0IGFjY2VzcyBpcyBub3QgdGhyZWFkLXNhZmUsIGl0IHB1dHMgdXMgaW50byBhDQo+
ID4gdG91Z2ggc2l0dWF0aW9uOg0KPiA+IC0gQ29tcGxleCByZWZjb3VudGluZywgY29kZSBzY2Fu
bmluZywgZXRjIHRvIGtlZXAgY29uc2lzdGVuY3kgd2hlbg0KPiA+IG1hbmlwdWxhdGluZyBtYXBz
IHVzZWQgYnkgbXVsdGlwbGUgcHJvZ3JhbXMuDQo+ID4gLSBQYXJhbGxlbCBsb2FkaW5nIG5vdCBi
ZWluZyB3ZWxsLWJhbGFuY2VkLCBpZiB3ZSBzcGxpdCBwcm9ncmFtcyBhY3Jvc3MNCj4gPiBvYmpl
Y3RzLg0KPiA+DQo+ID4gV2UgY291bGQgYWx0ZXJuYXRpdmVseSB3cml0ZSBvdXIgb3duIGN1c3Rv
bSBsb2FkZXIsIGJ1dCB0aGVuIHdl4oCZZCBoYXZlDQo+ID4gdG8gZHVwbGljYXRlIG11Y2ggb2Yg
dGhlIHVzZWZ1bCBsb2dpYyB0aGF0IGxpYmJwZiBhbHJlYWR5IGltcGxlbWVudHM6DQo+ID4gc2tl
bGV0b24gZ2VuZXJhdGlvbiwgbWFwL3Byb2dyYW0gYXNzb2NpYXRpb24sIGVtYmVkZGluZyBwcm9n
cmFtcyBpbnRvDQo+ID4gRUxGcywgbG9hZGluZyBsb2dpYyBhbmQga2VybmVsIHByb2JpbmcsIGV0
Yy4gV2XigJlkIGxpa2Ugc29tZSB3YXkgdG8NCj4gPiBoYW5kbGUgZHluYW1pYy9wYXJhbGxlbCBs
b2FkaW5nIHdpdGhvdXQgaGF2aW5nIHRvIHJlcGxpY2F0ZSBhbGwgdGhlDQo+ID4gYWR2YW50YWdl
cyBsaWJicGYgZ3JhbnRzIHVzLg0KPiA+DQo+DQo+DQo+IFllYWgsIEkgY2FuIHVuZGVyc3RhbmQg
dGhhdCBhcyB3ZWxsLCBidXQgYnBmX29iamVjdCdzIHNpbmdsZS10aHJlYWRlZA0KPiBkZXNpZ24g
YW5kIHRoZSBmYWN0IHRoYXQgYnBmX29iamVjdF9fbG9hZCBpcyBraW5kIG9mIHRoZSBmaW5hbCBz
dGVwDQo+IHdoZXJlIHByb2dyYW1zIGFyZSBsb2FkZWQgKG9yIG5vdCkgaXMgcHJldHR5IGJhY2tl
ZCBpbi4gSSBkb24ndCBzZWUNCj4gYnBmX29iamVjdCBiZWNvbWluZyBtdWx0aS10aHJlYWRlZC4N
Cg0KDQpXZSB1bmRlcnN0b29kIHRoaXMsIGJ1dCB0aGUgY3VycmVudCBicGZfb2JqZWN0IGRlc2ln
biBhbGxvd2VkIHVzIHRvIHVzZQ0KaXQgaW4gYSBtdWx0aXRocmVhZGVkIGVudmlyb25tZW50IHdp
dGggbWlub3IgbW9kaWZpY2F0aW9uIGZvciBicGZfcHJvZ3JhbQ0KbG9hZC4NCg0KV2UgdW5kZXJz
dGFuZCB0aGF0IHRoZSBkZXNpZ24gY2hvaWNlIG9mIGxpYmJwZiBiZWluZyBzaW5nbGUgdGhyZWFk
ZWQNCmlzIHVubGlrZWx5IHRvIGJlIHJlY29uc2lkZXJlZC4NCg0KDQo+ID4gPiA+ID4gPg0KPiA+
ID4gPiBicGZfb2JqZWN0IGlzIHRoZSB1bml0IG9mIGNvaGVyZW5jZSBpbiBsaWJicGYsIHNvIEkg
ZG9uJ3Qgc2VlIHVzDQo+ID4gPiA+IHJlZmNvdW50aW5nIG1hcHMgYmV0d2VlbiBicGZfb2JqZWN0
cy4gS2VybmVsIGlzIGRvaW5nIHJlZmNvdW50aW5nDQo+ID4gPiA+IGJhc2VkIG9uIEZEcywgc28g
c2VlIGlmIHlvdSBjYW4gdXNlIHRoYXQuDQo+ID4gPiA+DQo+ID4NCj4gPiBJIGNhbiB1bmRlcnN0
YW5kIHRoYXQuIFRoYXQgc2FpZCwgSSB0aGluayBpZiB0aGVyZSdzIG5vIGxvZ2ljIGFjcm9zcw0K
PiA+IG9iamVjdHMsIGFuZCBicGZfb2JqZWN0IGFjY2VzcyBpcyBub3QgdGhyZWFkLXNhZmUsIGl0
IHB1dHMgdXMgaW50byBhDQo+ID4gdG91Z2ggc2l0dWF0aW9uOg0KPiA+IC0gQ29tcGxleCByZWZj
b3VudGluZywgY29kZSBzY2FubmluZywgZXRjIHRvIGtlZXAgY29uc2lzdGVuY3kgd2hlbg0KPiA+
IG1hbmlwdWxhdGluZyBtYXBzIHVzZWQgYnkgbXVsdGlwbGUgcHJvZ3JhbXMuDQo+ID4gLSBQYXJh
bGxlbCBsb2FkaW5nIG5vdCBiZWluZyB3ZWxsLWJhbGFuY2VkLCBpZiB3ZSBzcGxpdCBwcm9ncmFt
cyBhY3Jvc3MNCj4gPiBvYmplY3RzLg0KPiA+DQo+ID4gV2UgY291bGQgYWx0ZXJuYXRpdmVseSB3
cml0ZSBvdXIgb3duIGN1c3RvbSBsb2FkZXIsIGJ1dCB0aGVuIHdl4oCZZCBoYXZlDQo+ID4gdG8g
ZHVwbGljYXRlIG11Y2ggb2YgdGhlIHVzZWZ1bCBsb2dpYyB0aGF0IGxpYmJwZiBhbHJlYWR5IGlt
cGxlbWVudHM6DQo+ID4gc2tlbGV0b24gZ2VuZXJhdGlvbiwgbWFwL3Byb2dyYW0gYXNzb2NpYXRp
b24sIGVtYmVkZGluZyBwcm9ncmFtcyBpbnRvDQo+ID4gRUxGcywgbG9hZGluZyBsb2dpYyBhbmQg
a2VybmVsIHByb2JpbmcsIGV0Yy4gV2XigJlkIGxpa2Ugc29tZSB3YXkgdG8NCj4gPiBoYW5kbGUg
ZHluYW1pYy9wYXJhbGxlbCBsb2FkaW5nIHdpdGhvdXQgaGF2aW5nIHRvIHJlcGxpY2F0ZSBhbGwg
dGhlDQo+ID4gYWR2YW50YWdlcyBsaWJicGYgZ3JhbnRzIHVzLg0KPiA+DQo+DQo+DQo+IFllYWgs
IEkgY2FuIHVuZGVyc3RhbmQgdGhhdCBhcyB3ZWxsLCBidXQgYnBmX29iamVjdCdzIHNpbmdsZS10
aHJlYWRlZA0KPiBkZXNpZ24gYW5kIHRoZSBmYWN0IHRoYXQgYnBmX29iamVjdF9fbG9hZCBpcyBr
aW5kIG9mIHRoZSBmaW5hbCBzdGVwDQo+IHdoZXJlIHByb2dyYW1zIGFyZSBsb2FkZWQgKG9yIG5v
dCkgaXMgcHJldHR5IGJhY2tlZCBpbi4gSSBkb24ndCBzZWUNCj4gYnBmX29iamVjdCBiZWNvbWlu
ZyBtdWx0aS10aHJlYWRlZC4gVGhlIGR5bmFtaWMgcHJvZ3JhbQ0KPiBsb2FkaW5nL3VubG9hZGlu
Zy9sb2FkaW5nIGFnYWluIGlzIHNvbWV0aGluZyB0aGF0IEkgY2FuJ3QgeWV0IGp1c3RpZnksDQo+
IHRiaC4NCj4NCj4NCj4gU28gdGhlIGJlc3QgSSBjYW4gcHJvcG9zZSB5b3UgaXMgdG8gdXNlIGxp
YmJwZidzIHNrZWxldG9uIGFuZA0KPiBicGZfb2JqZWN0IGNvbmNlcHQgZm9yLCBlZmZlY3RpdmVs
eSwgRUxGIGhhbmRsaW5nLCByZWxvY2F0aW9ucywgYWxsDQo+IHRoZSBwcmVwYXJhdGlvbnMgdXAg
dG8gbG9hZGluZyBCUEYgcHJvZ3JhbXMuIEFuZCBhZnRlciB0aGF0IHlvdSBjYW4NCj4gdGFrZSBv
dmVyIGxvYWRpbmcgYW5kIGhhbmRsaW5nIHByb2dyYW0gbGlmZXRpbWUgb3V0c2lkZSBvZiBicGZf
b2JqZWN0Lg0KPg0KPg0KPiBEeW5hbWljIG1hcCBjcmVhdGlvbiBhZnRlciBicGZfb2JqZWN0X19s
b2FkKCkgSSB0aGluayBpcyBjb21wbGV0ZWx5DQo+IG91dHNpZGUgb2YgdGhlIHNjb3BlIGFuZCB5
b3UnbGwgaGF2ZSB0byBzb2x2ZSB0aGlzIHByb2JsZW0gZm9yDQo+IHlvdXJzZWxmLiBJIHdvdWxk
IHBvaW50IG91dCwgdGhvdWdoLCB0aGF0IGludGVybmFsbHkgbGliYnBmIGFscmVhZHkNCj4gc3dp
dGNoZWQgdG8gc29ydC1vZiBwcmUtY3JlYXRpbmcgc3RhYmxlIEZEcyBmb3IgbWFwcyBiZWZvcmUg
dGhleSBhcmUNCj4gYWN0dWFsbHkgY3JlYXRlZCBpbiB0aGUga2VybmVsLiBTbyBpdCdzIGNvbmNl
aXZhYmxlIHRoYXQgd2UgY2FuIGhhdmUNCj4gbW9yZSBncmFudWxhcml0eSBpbiBicGZfb2JqZWN0
IHByZXBhcmF0aW9uLiBJLmUuLCBmaXJzdCBzdGVwIHdvdWxkIGJlDQo+IHRvIHBhcnNlIEVMRiBh
bmQgaGFuZGxlIHJlbG9jYXRpb25zLCBwcmVwYXJlIGV2ZXJ5dGhpbmcuIEFmdGVyIHRoYXQgd2UN
Cj4gY2FuIGhhdmUgYSBzdGVwIHRvIGNyZWF0ZSBtYXBzLCBhbmQgdGhlbiBhbm90aGVyIG9uZSB0
byBjcmVhdGUNCj4gcHJvZ3JhbXMuIFVzdWFsbHkgcGVvcGxlIHdvdWxkIGRvIGFsbCB0aGF0LCBi
dXQgeW91IGNhbiBzdG9wIHJpZ2h0DQo+IGJlZm9yZSBtYXBzIGNyZWF0aW9uIG9yIGJlZm9yZSBw
cm9ncmFtIGNyZWF0aW9uLCB3aGF0ZXZlciBmaXRzIHlvdXINCj4gdXNlIGNhc2UgYmV0dGVyLg0K
Pg0KPg0KPiBUaGUga2V5IGlzIHRoYXQgcHJvZ3JhbSBpbnN0cnVjdGlvbnMgd2lsbCBiZSBmaW5h
bCBhbmQgd29uJ3QgbmVlZA0KPiBhZGp1c3RtZW50cyByZWdhcmRsZXNzIG9mIG1hcHMgYWN0dWFs
bHkgYmVpbmcgY3JlYXRlZCBvciBub3QuIEZEcywgYXMNCj4gSSBtZW50aW9uZWQsIGFyZSBzdGFi
bGUgcmVnYXJkbGVzcy4NCg0KDQpXZSB1c2VkIHRoaXMgaW4gb3VyIGRlc2lnbiwgc28gd2UgZGlk
IG5vdCBuZWVkIHRvIHNjYW4gQlBGIHByb2dyYW0NCmluc3RydWN0aW9ucyB0byBmaXggbWFwJ3Mg
ZmRzIHJlZmVyZW5jZWQgYnkgaW5zdHJ1Y3Rpb25zIGZyb20gYSBkeW5hbWljYWxseQ0KbG9hZGVk
IGJwZl9wcm9ncmFtIHdpdGggZHluYW1pY2FsbHkgY3JlYXRlZCBtYXBzLg0KDQoNCj4gPg0KPiA+
IFRoZSB1c2UgY2FzZSBoZXJlIGlzIHRoYXQgb3VyIHNlY3VyaXR5IG1vbml0b3JpbmcgYWdlbnQg
bGV2ZXJhZ2VzIGVCUEYNCj4gPiBhcyBpdHMgZm91bmRhdGlvbmFsIHRlY2hub2xvZ3kgdG8gZ2F0
aGVyIHRlbGVtZXRyeSBmcm9tIHRoZSBrZXJuZWwuIEFzDQo+ID4gcGFydCBvZiB0aGF0LCB3ZSBo
b29rIG1hbnkgZGlmZmVyZW50IGtlcm5lbCBzdWJzeXN0ZW1zIChwcm9jZXNzLA0KPiA+IG1lbW9y
eSwgZmlsZXN5c3RlbSwgbmV0d29yaywgZXRjKSwgdHlpbmcgdGhlbSB0b2dldGhlciBhbmQgdHJh
Y2tpbmcNCj4gPiB3aXRoIG1hcHMuIFNvIHdlIGxlZ2l0aW1hdGVseSBoYXZlIGEgdmVyeSBsYXJn
ZSBudW1iZXIgb2YgcHJvZ3JhbXMgYWxsDQo+ID4gZG9pbmcgZGlmZmVyZW50IHdvcmsuIEZvciBw
cm9kdWN0cyBvZiB0aGlzIHNjYWxlLCBpdCBpbmNyZWFzZXMgc2VjdXJpdHkNCj4gPiBhbmQgcGVy
Zm9ybWFuY2UgdG8gbG9hZCB0aGlzIHNldCBvZiBwcm9ncmFtcyBhbmQgdGhlaXIgbWFwcyBpbiBh
bg0KPiA+IG9wdGltaXplZCwgcGFyYWxsZWwgZmFzaGlvbiBhbmQgc3Vic2VxdWVudGx5IGNoYW5n
ZSB0aGUgbG9hZGVkIHNldCBvZg0KPiA+IHByb2dyYW1zIGFuZCBtYXBzIGR5bmFtaWNhbGx5IHdp
dGhvdXQgZGlzdHVyYmluZyB0aGUgcmVzdCBvZiB0aGUNCj4gPiBhcHBsaWNhdGlvbi4NCj4NCj4N
Cj4gWWVzLCBtYWtlcyBzZW5zZS4gWW91J2xsIG5lZWQgdG8gZGVjaWRlIGZvciB5b3Vyc2VsZiBp
ZiBpdCdzIGFjdHVhbGx5DQo+IG1vcmUgbWVhbmluZ2Z1bCB0byBzcGxpdCB0aG9zZSAyMDAgcHJv
Z3JhbXMgaW50byBpbmRlcGVuZGVudA0KPiBicGZfb2JqZWN0cyBieSBmZWF0dXJlcywgYW5kIGJl
IHJpZ29yb3VzIGFib3V0IHNoYXJpbmcgc3RhdGUgKG1hcHMpDQo+IHRocm91Z2ggYnBmX21hcF9f
cmV1c2VfZmQoKSwgd2hpY2ggd291bGQgYWxsb3cgdG8gcGFyYWxsZWxpemUgbG9hZGluZw0KPiB3
aXRoaW4gY29uZmluZXMgb2YgZXhpc3RpbmcgbGliYnBmIEFQSXMuIE9yIHlvdSBjYW4gYmUgYSBi
aXQgbW9yZQ0KPiBsb3ctbGV2ZWwgd2l0aCBwcm9ncmFtIGxvYWRpbmcgb3V0c2lkZSBvZiBicGZf
b2JqZWN0IEFQSSwgYXMgSQ0KPiBkZXNjcmliZWQgYWJvdmUuDQoNClllcywgdGhpcyBjYW4gYmUg
b25lIG9mIHRoZSB3YXlzIHRvIHNoYXJlIGJwZiBtYXBzIGFjcm9zcyBtdWx0aXBsZSBicGZfb2Jq
ZWN0cw0KYW5kIHVzZSBleGlzdGluZyBsaWJicGYgZm9yIHBhcmFsbGVsIGJwcyBwcm9ncmFtcyBs
b2FkaW5nLCBpZiB3ZSB3YW50IHRvIGtlZXANCmEgZnVsbCBsaWJicGYgY29tcGF0aWJpbGl0eSwg
YnV0IGF0IGEgY29zdCBvZiBjb21wbGljYXRpbmcgZGVzaWduLCBhcyB3ZSBuZWVkIHRvDQpjb252
ZXJ0IGEgc2luZ2xlIGJwZl9vYmplY3QgbW9kZWwgdG8gbXVsdGlwbGUgYnBmX29iamVjdHMgd2l0
aCBhIG5ldyBsYXllcg0KdGhhdCBtYW5hZ2VzIHRoZXNlIGJwZl9vYmplY3RzLg0KDQpJbiBvdXIg
Y2FzZSwgYXMgYSBicGZfcHJvZ3JhbSBjYW4gbWFwIHRvIG11bHRpcGxlIGZlYXR1cmVzLCB3aGlj
aCBjYW4gYmUNCm1vZGlmaWVkIGluZGVwZW5kZW50bHksIGFuZCB0byBhY2hpZXZlIGFuIGV2ZW4g
bG9hZCBiYWxhbmNpbmcgYWNyb3NzIG11bHRpcGxlDQp0aHJlYWRzLCBpdCB3b3VsZCBiZSBwcm9i
YWJseSBvbmUgYnBmX3Byb2dyYW0gZm9yIGEgYnBmX29iamVjdC4NCg0KDQoNCg==

