Return-Path: <linux-kselftest+bounces-25349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD85A214E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 00:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 100A57A33B0
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 23:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90461E7C11;
	Tue, 28 Jan 2025 23:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="lXKZqaT3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC8628DA1;
	Tue, 28 Jan 2025 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738105747; cv=none; b=hc0uQSza0D5uqJhMiJbD0tah9dslsnAINoS+y7TO1t+60arTnoB4JQZicCpXEV4Zh3c9c+zU/7NjB1Wy6mM/jUcA15hLq+1qB1y/A5XREA4Xs5ssDp20RjPSXc6gje4OLpcLc2YThh7tAnYxi5WnmTa7IcxVukBPK0SdigVospg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738105747; c=relaxed/simple;
	bh=BHiUSNSPqwWcSVbLVtJGmddwMDGGKJKbnCElURyEjGc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dO0djcD/MxlGcQcsRXXvdI+XF5vPZZhx+t+RQqqr1WpdRSDKKOJSu9p6ykhUyH+m/ckGvypkXEUKqCE6tJjXtO43moFgoT6gviWiWMkk/hbxrinRFNHojRhAmRoVRW0gXUBhJ5V24K5wmPRMNuUFib90tdK/AWi34SbzKesv0fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=lXKZqaT3; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SMlYoZ019147;
	Tue, 28 Jan 2025 23:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-id:content-transfer-encoding:content-type:date
	:from:in-reply-to:message-id:mime-version:references:subject:to;
	 s=default; bh=BHiUSNSPqwWcSVbLVtJGmddwMDGGKJKbnCElURyEjGc=; b=l
	XKZqaT3UySRKgiDBeD0eS945yKoi/LBvmLdC6qAyeiGXqJT4rXOEx22fka/4xyuL
	xmLDtIHg0P4A3ScDXprTc1llGC4uWh6c6Mwl/6BQGdmoWRWXD7TNrEYspTBB3M76
	/W0RCNA629zwCoI5i4KE9pxpW0FmPXHFyUZ+l2OJXpmWyTuf2i/vDpc2K0Ps+1e9
	sHkBi3J0WN7jBXq67LYTATSCrx914RCdj4o+s/R9y9vmIdO4VOLi1hB08ER0VGKP
	919qKlv4zwFtKShzmgQeRLoqM61FKxpx96MYJpclHoyrwEmbfGt4ncEiaJ0q7GGD
	OZHgmDgdUyeVKNUVREr3g==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 44f8bg01hv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 23:08:27 +0000 (GMT)
Received: from 04WPEXCH006.crowdstrike.sys (10.100.11.70) by
 04WPEXCH007.crowdstrike.sys (10.100.11.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 28 Jan 2025 23:08:25 +0000
Received: from 04WPEXCH006.crowdstrike.sys ([fe80::a97d:6ad:c239:d138]) by
 04WPEXCH006.crowdstrike.sys ([fe80::a97d:6ad:c239:d138%11]) with mapi id
 15.02.1544.009; Tue, 28 Jan 2025 23:08:25 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        Slava Imameev
	<slava.imameev@crowdstrike.com>
CC: "mykolal@fb.com" <mykolal@fb.com>, "shuah@kernel.org" <shuah@kernel.org>,
        "eddyz87@gmail.com" <eddyz87@gmail.com>,
        "andrii@kernel.org"
	<andrii@kernel.org>,
        "song@kernel.org" <song@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
        Mark Fontana
	<mark.fontana@crowdstrike.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "sdf@fomichev.me" <sdf@fomichev.me>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "haoluo@google.com" <haoluo@google.com>
Subject: Re: Re: [PATCH 2/2] libbpf: BPF programs dynamic loading and
 attaching
Thread-Topic: Re: [PATCH 2/2] libbpf: BPF programs dynamic loading and
 attaching
Thread-Index: AQHbcdmId/Qde7G43kObXHQ09Ny+zg==
Date: Tue, 28 Jan 2025 23:08:25 +0000
Message-ID: <8831ed8fa183f76fefd71244360fa0ca35b11910.camel@crowdstrike.com>
References: <20250122215206.59859-1-slava.imameev@crowdstrike.com>
	 <20250122215206.59859-2-slava.imameev@crowdstrike.com>
	 <CAEf4Bzajxh4xvg-aCaBhLQdNOZdhwceYUD2UsCcWku4ZBca_Hw@mail.gmail.com>
In-Reply-To: <CAEf4Bzajxh4xvg-aCaBhLQdNOZdhwceYUD2UsCcWku4ZBca_Hw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-disclaimer: USA
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F2355901F00B94284B17BF2AEAF0061@crowdstrike.sys>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: wjToRGh6IBMA3QIIGKfRg7Qv6yhYtBmb
X-Authority-Analysis: v=2.4 cv=W83CVQWk c=1 sm=1 tr=0 ts=6799636b cx=c_pps a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17 a=xqWC_Br6kY4A:10 a=EjBHVkixTFsA:10 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=pl6vuDidAAAA:8 a=jsr11kt-jKzjRDI9iCgA:9
 a=QEXdDO2ut3YA:10 a=t-GJX_8G5HYi9iQoYkGH:22
X-Proofpoint-GUID: wjToRGh6IBMA3QIIGKfRg7Qv6yhYtBmb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=529 mlxscore=0 clxscore=1011
 impostorscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280169

T24gRnJpLCAyMDI1LTAxLTI0IGF0IDEwOjMxIC0wODAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQo+ID4gT24gV2VkLCBKYW4gMjIsIDIwMjUgYXQgMTo1M+KAr1BNIFNsYXZhIEltYW1lZXYNCj4g
PiA8c2xhdmEuaW1hbWVldkBjcm93ZHN0cmlrZS5jb20+IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+
ID4gQlBGIHByb2dyYW1zIGRlc2lnbmF0ZWQgYXMgZHluYW1pY2FsbHkgbG9hZGVkIGNhbiBiZSBs
b2FkZWQgYW5kDQo+ID4gPiA+IGF0dGFjaGVkIGluZGVwZW5kZW50bHkgYWZ0ZXIgdGhlIGluaXRp
YWwgYnBmX29iamVjdCBsb2FkaW5nIGFuZA0KPiA+ID4gPiBhdHRhY2hpbmcuDQo+ID4gPiA+IA0K
PiA+ID4gPiBUaGVzZSBwcm9ncmFtcyBjYW4gYWxzbyBiZSByZWxvYWRlZCBhbmQgcmVhdHRhY2hl
ZCBtdWx0aXBsZQ0KPiA+ID4gPiB0aW1lcywNCj4gPiA+ID4gZW5hYmxpbmcgbW9yZSBmbGV4aWJs
ZSBtYW5hZ2VtZW50IG9mIGEgcmVzaWRlbnQgQlBGIHByb2dyYW0NCj4gPiA+ID4gc2V0Lg0KPiA+
ID4gPiANCj4gPiA+ID4gQSBrZXkgbW90aXZhdGlvbiBmb3IgdGhpcyBmZWF0dXJlIGlzIHRvIHJl
ZHVjZSBsb2FkIHRpbWVzIGZvcg0KPiA+ID4gPiB1dGlsaXRpZXMgdGhhdCBpbmNsdWRlIGh1bmRy
ZWRzIG9mIEJQRiBwcm9ncmFtcy4gV2hlbiB0aGUNCj4gPiA+ID4gc2VsZWN0aW9uDQo+ID4gPiA+
IG9mIGEgcmVzaWRlbnQgQlBGIHByb2dyYW0gc2V0IGNhbm5vdCBiZSBkZXRlcm1pbmVkIGF0IHRo
ZSB0aW1lDQo+ID4gPiA+IG9mDQo+ID4gPiA+IGJwZl9vYmplY3QgbG9hZGluZyBhbmQgYXR0YWNo
aW5nLCBhbGwgQlBGIHByb2dyYW1zIHdvdWxkDQo+ID4gPiA+IG90aGVyd2lzZQ0KPiA+ID4gPiBu
ZWVkIHRvIGJlIG1hcmtlZCBhcyBhdXRvbG9hZCwgbGVhZGluZyB0byB1bm5lY2Vzc2FyeSBvdmVy
aGVhZC4NCj4gPiA+ID4gVGhpcyBwYXRjaCBhZGRyZXNzZXMgdGhhdCBpbmVmZmljaWVuY3kuDQo+
ID4gDQo+ID4gQ2FuIHlvdSBlbGFib3JhdGUgb24gd2h5IGl0J3MgaW1wb3NzaWJsZSB0byBkZXRl
cm1pbmUgd2hpY2ggQlBGDQo+ID4gcHJvZ3JhbXMgc2hvdWxkIGJlIGxvYWRlZCBiZWZvcmUgQlBG
IG9iamVjdCBsb2FkIHN0ZXA/DQo+ID4gDQoNClRoZSBtYWluIHVzZSBjYXNlIGZvciB0aGlzIHBh
dGNoIGlzIGxhcmdlIGFwcGxpY2F0aW9ucyB0aGF0IG5lZWQgdG8NCmR5bmFtaWNhbGx5IGxvYWQv
dW5sb2FkIEJQRiBwcm9ncmFtcy4gT3VyIHNwZWNpZmljIHVzZSBjYXNlIGlzIGENCmNvbnRpbnVv
dXNseS1ydW5uaW5nIHNlY3VyaXR5IGFwcGxpY2F0aW9uIHdpdGggYSBkeW5hbWljYWxseS0NCnJl
Y29uZmlndXJhYmxlIGZlYXR1cmUgc2V0LiBBcyBwYXJ0IG9mIHRoYXQgcmVjb25maWd1cmF0aW9u
LCBCUEYNCnByb2dyYW1zIG1heSBnZXQgbG9hZGVkL3VubG9hZGVkIG9uLXRoZS1mbHkuIFJlc3Rh
cnRpbmcgdGhlIGVudGlyZQ0KYXBwbGljYXRpb24gZHVyaW5nIHJlY29uZmlndXJhdGlvbiBpcyB1
bmRlc2lyYWJsZSwgYXMgY3JpdGljYWwgc3RhdGUNCmRhdGEgY2FuIGJlIGxvc3QgYW5kIGxvYWRp
bmcgaHVuZHJlZHMgb2YgQlBGIHByb2dyYW1zIGlzIHRpbWUtDQpjb25zdW1pbmcuDQoNClRoZSBh
Ym92ZSBwb2ludHMgYXBwbHkgbW9yZSBnZW5lcmljYWxseSB0byAqYW55KiBhcHBsaWNhdGlvbiB0
aGF0DQpyZXF1aXJlcyBkeW5hbWljIGxvYWRpbmcvdW5sb2FkaW5nLiBSZWNvbmZpZ3VyYXRpb24g
Y2FuIGJlIGRvbmUgdmlhIGENCnJlc3RhcnQsIGJ1dCB0aGF0IGhhcyBkcmF3YmFja3M6DQooYSkg
TG9zaW5nIGFueSBub24tcGVyc2lzdGVudCBhcHBsaWNhdGlvbiBzdGF0ZSBvbiByZXN0YXJ0LiBJ
biBvdXINCmNhc2UsIHRoaXMgY3JlYXRlcyBhIGxhcHNlIGluIHNlY3VyaXR5IHRoYXQgY291bGQg
YmUgZXhwbG9pdGVkIGJ5DQphZHZlcnNhcmllcy4NCihiKSBJbiBhcHBsaWNhdGlvbnMgd2l0aCBt
YW55IHByb2dyYW1zLCBsb2FkK2F0dGFjaCBjYW4gdGFrZSBhIGxvbmcNCnRpbWUuIFdlIG1lYXN1
cmVkIGxvYWQrYXR0YWNoIG9mIH4xMDAgQlBGIHByb2dyYW1zIHRha2luZyB+MTAgc2Vjb25kcw0K
d2hlbiBkb25lIHdpdGggY3VycmVudCBsaWJicGYgc2VyaWFsbHkuIER5bmFtaWNhbGx5IGxvYWRp
bmcgb25seSB0aGUNCnByb2dyYW1zIG5lZWRlZCBhdm9pZHMgd2FzdGluZyBtZW1vcnkgYW5kIENQ
VSBjeWNsZXMuDQooYykgVGhlIGFwcGxpY2F0aW9uIGl0c2VsZiBtaWdodCB0YWtlIGEgbG9uZyB0
aW1lIHRvIHJlc3RhcnQsIHNlcGFyYXRlDQpmcm9tIHRoZSBCUEYgbG9hZC9hdHRhY2ggdGltZS4g
QnkgbG9hZGluZyBkeW5hbWljYWxseSwgdGhlIEJQRiBwcm9ncmFtcw0KY2FuIHRha2UgZWZmZWN0
IG11Y2ggc29vbmVyIGFuZCBhdm9pZCB3YXN0ZWQgcmVzdGFydCBjeWNsZXMuDQoNClRoaXMgcGF0
Y2ggc2V0IGFsc28gcGVybWl0cyBsb2FkaW5nIEJQRiBwcm9ncmFtcyBpbiBwYXJhbGxlbCBpZiB0
aGUNCmFwcGxpY2F0aW9uIHdpc2hlcy4gV2UgdGVzdGVkIHBhcmFsbGVsIGxvYWRpbmcgd2l0aCAy
MDArIEJQRiBwcm9ncmFtcw0KYW5kIGZvdW5kIHRoZSBsb2FkIHRpbWUgZHJvcHBlZCBmcm9tIDE4
IHNlY29uZHMgdG8gNSBzZWNvbmRzIHdoZW4gZG9uZQ0KaW4gcGFyYWxsZWwgb24gYSA2Ljgga2Vy
bmVsLg0KDQpJbiB0aGUgZnV0dXJlLCB0aGlzIGFwcHJvYWNoIGNvdWxkIGFsc28gYWxsb3cgbWFw
cyB0byBub3QgYmUNCmF1dG9sb2FkZWQsIGZ1cnRoZXIgc2F2aW5nIG9uIG1lbW9yeSBpZiBubyBw
cm9ncmFtIG5lZWRzIHRoZSB1bmRlcmx5aW5nDQptYXAuDQoNCkluIHN1bW1hcnksIHdlIGJlbGll
dmUgZHluYW1pYyBsb2FkaW5nIG9mIEJQRiBwcm9ncmFtcyBpcyBhbiBpbXBvcnRhbnQNCmNhcGFi
aWxpdHkgdGhhdCB3aWxsIGltcHJvdmUgdGhlIHBlcmZvcm1hbmNlIG9mIENyb3dkU3RyaWtlJ3Mg
c2VjdXJpdHkNCmFwcGxpY2F0aW9ucyBhcyB3ZWxsIGFzIGJlaW5nIHVzZWZ1bCB0byBvdGhlciBh
cHBsaWNhdGlvbnMgdGhhdCB3YW50IHRvDQphdm9pZCByZXN0YXJ0cy4NCj4gDQo=

