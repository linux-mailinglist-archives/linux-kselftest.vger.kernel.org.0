Return-Path: <linux-kselftest+bounces-2971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 779FC82D793
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 11:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254031F21D3F
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 10:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FC963AD;
	Mon, 15 Jan 2024 10:42:02 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B9D1A27E
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Jan 2024 10:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 40FAfUqO038155;
	Mon, 15 Jan 2024 18:41:30 +0800 (GMT-8)
	(envelope-from hu.yadi@h3c.com)
Received: from DAG6EX13-BJD.srv.huawei-3com.com (unknown [10.153.34.15])
	by mail.maildlp.com (Postfix) with ESMTP id 88C4C2004DB6;
	Mon, 15 Jan 2024 18:45:58 +0800 (CST)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) by
 DAG6EX13-BJD.srv.huawei-3com.com (10.153.34.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Mon, 15 Jan 2024 18:41:32 +0800
Received: from DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4])
 by DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4%16]) with
 mapi id 15.02.1258.027; Mon, 15 Jan 2024 18:41:32 +0800
From: Huyadi <hu.yadi@h3c.com>
To: "'kernel test robot'" <lkp@intel.com>,
        "jmorris@namei.org"
	<jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>,
        "mic@digikod.net" <mic@digikod.net>
CC: "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        "514118380@qq.com" <514118380@qq.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIHYzXSBzZWxmdGVzdHMvbGFuZGxvY2s6Rml4IHR3byBi?=
 =?gb2312?Q?uild_issues?=
Thread-Topic: [PATCH v3] selftests/landlock:Fix two build issues
Thread-Index: AQHaRScQ690ykYEnskymgvTI87URSbDZuk8AgAD5tWA=
Date: Mon, 15 Jan 2024 10:41:32 +0000
Message-ID: <44bf55ff3e3649c88c5b1daf843a86b5@h3c.com>
References: <20240112071245.669-1-hu.yadi@h3c.com>
 <202401151147.T1s11iHJ-lkp@intel.com>
In-Reply-To: <202401151147.T1s11iHJ-lkp@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-sender-location: DAG2
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 40FAfUqO038155

DQo+SGkgSHUsDQo+DQo+a2VybmVsIHRlc3Qgcm9ib3Qgbm90aWNlZCB0aGUgZm9sbG93aW5nIGJ1
aWxkIGVycm9yczoNCj4NCj4gW2F1dG8gYnVpbGQgdGVzdCBFUlJPUiBvbiBzaHVhaC1rc2VsZnRl
c3QvbmV4dF0gW2Fsc28gYnVpbGQgdGVzdCBFUlJPUiBvbiBzaHVhaC1rc2VsZnRlc3QvZml4ZXMg
bGludXMvbWFzdGVyIHY2LjcgbmV4dC0yMDI0MDExMl0gW0lmIHlvdXIgcGF0Y2ggaXMgYXBwbGll
ZCB0byB0aGUgd3JvbmcgZ2l0IHRyZWUsIGtpbmRseSBkcm9wIHVzIGEgbm90ZS4NCj5BbmQgd2hl
biBzdWJtaXR0aW5nIHBhdGNoLCB3ZSBzdWdnZXN0IHRvIHVzZSAnLS1iYXNlJyBhcyBkb2N1bWVu
dGVkIGluIGh0dHBzOi8vZ2l0LXNjbS5jb20vZG9jcy9naXQtZm9ybWF0LXBhdGNoI19iYXNlX3Ry
ZWVfaW5mb3JtYXRpb25dDQoNCj51cmw6ICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC1sYWIt
bGtwL2xpbnV4L2NvbW1pdHMvSHUtWWFkaS9zZWxmdGVzdHMtbGFuZGxvY2stRml4LXR3by1idWls
ZC1pc3N1ZXMvMjAyNDAxMTItMTUxODA1DQo+YmFzZTogICBodHRwczovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zaHVhaC9saW51eC1rc2VsZnRlc3QuZ2l0IG5leHQN
Cj5wYXRjaCBsaW5rOiAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjQwMTEyMDcxMjQ1
LjY2OS0xLWh1LnlhZGklNDBoM2MuY29tDQo+cGF0Y2ggc3ViamVjdDogW1BBVENIIHYzXSBzZWxm
dGVzdHMvbGFuZGxvY2s6Rml4IHR3byBidWlsZCBpc3N1ZXMNCj5jb21waWxlcjogZ2NjLTEyIChE
ZWJpYW4gMTIuMi4wLTE0KSAxMi4yLjAgcmVwcm9kdWNlICh0aGlzIGlzIGEgVz0xIGJ1aWxkKTog
KGh0dHBzOi8vZG93bmxvYWQuMDEub3JnLzBkYXktY2kvYXJjaGl2ZS8yMDI0MDExNS8yMDI0MDEx
NTExNDcuVDFzMTFpSEotbGtwQGludGVsLmNvbS9yZXByb2R1Y2UpDQo+DQo+SWYgeW91IGZpeCB0
aGUgaXNzdWUgaW4gYSBzZXBhcmF0ZSBwYXRjaC9jb21taXQgKGkuZS4gbm90IGp1c3QgYSBuZXcg
dmVyc2lvbiBvZiB0aGUgc2FtZSBwYXRjaC9jb21taXQpLCBraW5kbHkgYWRkIGZvbGxvd2luZyB0
YWdzDQo+fCBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+
fCBDbG9zZXM6IA0KPnwgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvb2Uta2J1aWxkLWFsbC8yMDI0
MDExNTExNDcuVDFzMTFpSEotbGtwQGludGVsLg0KPnwgY29tLw0KPg0KPkFsbCBlcnJvcnMgKG5l
dyBvbmVzIHByZWZpeGVkIGJ5ID4+KToNCj4NCg0KRml4IGl0LCBhbmQgc2VuZCBwYXRjaCBWNCBz
b29uLg0KDQo+Pj4gbmV0X3Rlc3QuYzoyNToxNDogZXJyb3I6IHN0YXRpYyBkZWNsYXJhdGlvbiBv
ZiAnZ2V0dGlkJyBmb2xsb3dzIA0KPj4+IG5vbi1zdGF0aWMgZGVjbGFyYXRpb24NCj4gICAgICAy
NSB8IHN0YXRpYyBwaWRfdCBnZXR0aWQodm9pZCkNCj4gICAgICAgICB8ICAgICAgICAgICAgICBe
fn5+fn4NCj4gICBJbiBmaWxlIGluY2x1ZGVkIGZyb20gL3Vzci9pbmNsdWRlL3VuaXN0ZC5oOjEy
MTgsDQo+ICAgICAgICAgICAgICAgICAgICBmcm9tIC91c3IvaW5jbHVkZS94ODZfNjQtbGludXgt
Z251L2JpdHMvc2lnc3Rrc3ouaDoyNCwNCj4gICAgICAgICAgICAgICAgICAgIGZyb20gL3Vzci9p
bmNsdWRlL3NpZ25hbC5oOjMyOCwNCj4gICAgICAgICAgICAgICAgICAgIGZyb20gL3Vzci9pbmNs
dWRlL3g4Nl82NC1saW51eC1nbnUvc3lzL3dhaXQuaDozNiwNCj4gICAgICAgICAgICAgICAgICAg
IGZyb20gY29tbW9uLmg6MTYsDQo+ICAgICAgICAgICAgICAgICAgICBmcm9tIG5ldF90ZXN0LmM6
MjI6DQo+ICAgL3Vzci9pbmNsdWRlL3g4Nl82NC1saW51eC1nbnUvYml0cy91bmlzdGRfZXh0Lmg6
MzQ6MTY6IG5vdGU6IHByZXZpb3VzIGRlY2xhcmF0aW9uIG9mICdnZXR0aWQnIHdpdGggdHlwZSAn
X19waWRfdCh2b2lkKScge2FrYSAnaW50KHZvaWQpJ30NCj4gICAgICAzNCB8IGV4dGVybiBfX3Bp
ZF90IGdldHRpZCAodm9pZCkgX19USFJPVzsNCj4gICAgICAgICB8ICAgICAgICAgICAgICAgIF5+
fn5+fg0KPg0KPi0tDQo+MC1EQVkgQ0kgS2VybmVsIFRlc3QgU2VydmljZQ0KaHR0cHM6Ly9naXRo
dWIuY29tL2ludGVsL2xrcC10ZXN0cy93aWtpDQo=

