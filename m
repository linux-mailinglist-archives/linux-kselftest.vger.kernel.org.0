Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4544B82E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2019 22:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbfISUsC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Sep 2019 16:48:02 -0400
Received: from mail-eopbgr750093.outbound.protection.outlook.com ([40.107.75.93]:10823
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727273AbfISUsB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Sep 2019 16:48:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFIs/jeflh0+y6VN2TNLeAhJa2JI2MVyffSJhDae4F/8eA+T3gCwfUudZJ84NUeTfHSdO6r0jOE/PnTH42HlDjRR35oOtAANv3Owl1U7MvkdpzYU1+f5hMta54+7rwDPpLkWduRf+2/p7y8rVCZGAbKsfSoXCOOVJADmlppikj8LdZT77l4OKRzFX+kKnsQD9onFkS31QZxBJOa5tK50fcRIBxSeFKl7jiiANr5DyPkqtJkEhAjt2AnOyp4TOhCWvYLITs9geXQp9yLuP7kWcddoD+lIYYNfWYuJW2WsAeNZ6rKXb4A/tk17mgNIpkosNmGeiFjHr6S5xuKyItjI1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5BeZiQqZOcTKvkJztZwrg+K8SeoOsxnGq6hhFzqkDQ=;
 b=fWZjBlzlKMO5ERyztXE2PauZIZffKJNMH032PnnUFKPqmBhHLnMN8/SLDMQHQcYiEtANpEuTzatJM1CUqSY/RgyUPSETSByxudV3mPcdwyD+Rhm1wP0oI0TWPp4zhX+Vy8c6bfpmxe/4PJZEZ/FSEcfXoVSCnnK+knDZ9V1K+oP+y9yUe6SRkQdO0TamEO/0tkGEM1rKz7pRybuA+lj5tz8me0M/9VdQlP2ktsBK7vkaMlijgknDvGON6r2JloDCZxcwXx1+pfgKRFzmt6Mq4GhQDfgvjEwnVRWLye9B4RAHXWVzYZyLn6cgNbbaFt2bKtd/Q7Tr0SATNQGExCWEgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 160.33.194.228) smtp.rcpttodomain=kernel.org smtp.mailfrom=sony.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5BeZiQqZOcTKvkJztZwrg+K8SeoOsxnGq6hhFzqkDQ=;
 b=CqS3rsjcqwDlASrXoAMFIqf9Qx0pjtAVtK6LiPvu8Qm0oY++0989yaePkEvElzvF/ZqaMK9LfQY+GvPyivzqAXs8E7fsVaJet6dEBu29DRXrA0brOzlHhUds6KfnKIp6qB2d31wE4hyN4ADBgwwmPp7MlXjX1NMwJn9WSMIhrUo=
Received: from CY4PR13CA0006.namprd13.prod.outlook.com (2603:10b6:903:32::16)
 by CY4PR13MB1173.namprd13.prod.outlook.com (2603:10b6:903:3c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.17; Thu, 19 Sep
 2019 20:47:57 +0000
Received: from SN1NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by CY4PR13CA0006.outlook.office365.com
 (2603:10b6:903:32::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.14 via Frontend
 Transport; Thu, 19 Sep 2019 20:47:57 +0000
Authentication-Results: spf=pass (sender IP is 160.33.194.228)
 smtp.mailfrom=sony.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 160.33.194.228 as permitted sender) receiver=protection.outlook.com;
 client-ip=160.33.194.228; helo=usculsndmail01v.am.sony.com;
Received: from usculsndmail01v.am.sony.com (160.33.194.228) by
 SN1NAM02FT013.mail.protection.outlook.com (10.152.72.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20 via Frontend Transport; Thu, 19 Sep 2019 20:47:56 +0000
Received: from usculsndmail12v.am.sony.com (usculsndmail12v.am.sony.com [146.215.230.103])
        by usculsndmail01v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x8JKlt0A026764;
        Thu, 19 Sep 2019 20:47:55 GMT
Received: from USCULXHUB01V.am.sony.com (usculxhub01v.am.sony.com [146.215.231.15])
        by usculsndmail12v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x8JKlsIh001670;
        Thu, 19 Sep 2019 20:47:55 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB01V.am.sony.com ([146.215.231.15]) with mapi id 14.03.0439.000; Thu,
 19 Sep 2019 16:47:54 -0400
From:   <Tim.Bird@sony.com>
To:     <shuah@kernel.org>, <alexandre.belloni@bootlin.com>,
        <keescook@chromium.org>
CC:     <anders.roxell@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH] selftests/kselftest/runner.sh: Add 45 second timeout
 per test
Thread-Topic: [PATCH] selftests/kselftest/runner.sh: Add 45 second timeout
 per test
Thread-Index: AQHVbxUXsNEjsnpJkUeVTYYfiT5hwacznHuAgAAUu4D//8Y04A==
Date:   Thu, 19 Sep 2019 20:47:51 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF977BA651@USCULXMSG01.am.sony.com>
References: <201909191102.97FA56072@keescook>
 <20190919185525.GD21254@piout.net>
 <4844c68f-603d-14f2-f976-5bd255268c0d@kernel.org>
In-Reply-To: <4844c68f-603d-14f2-f976-5bd255268c0d@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [146.215.228.6]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:160.33.194.228;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39860400002)(396003)(189003)(199004)(13464003)(11346002)(53546011)(6246003)(102836004)(316002)(305945005)(55016002)(478600001)(7736002)(8676002)(33656002)(2486003)(8936002)(55846006)(23676004)(126002)(476003)(486006)(246002)(7696005)(76176011)(2201001)(86362001)(54906003)(106002)(110136005)(6666004)(356004)(5660300002)(26005)(336012)(446003)(50466002)(2876002)(2906002)(47776003)(66066001)(186003)(4326008)(3846002)(14444005)(426003)(229853002)(70586007)(70206006)(436003)(37786003)(6116002)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR13MB1173;H:usculsndmail01v.am.sony.com;FPR:;SPF:Pass;LANG:en;PTR:mail.sonyusa.com,mail01.sonyusa.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9e52dc1-d220-4934-213d-08d73d42a69e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);SRVR:CY4PR13MB1173;
X-MS-TrafficTypeDiagnostic: CY4PR13MB1173:
X-Microsoft-Antispam-PRVS: <CY4PR13MB117316449C43C7BEEFE2A381FD890@CY4PR13MB1173.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 016572D96D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: rlY2AkK/rwRQgm3kLbmxpiWNVESFqlGjWIAVfvdb8yMtJkNUhyJZvj4WhWyMJWfVIjirhOGfGMgXLfgNlZ+MxRIawknwiCRIH1EB79rh1L+L8hkNvj3vg0ZLC2Gu0lhtaPic3YXE+FDqOW751LJF31xacC1JsE6G/mnYeT1hfQox1ZEqR9P2k4hlvUBF1m02v3yDyESQL5VoFNJjASotydKHnH5oELAi3breoLETJb3rY9RN56LP+LP7D4ILZUjyOTJAmgocKC1tnykUhVQM0A42cG2+KerokQh1hyEjwXoFSg77njaxMlWpJ92ntZTN9EKn8knMzSj7WRZ3LYgAMvhTsaRCHx5lEbvPei1xQ/NfjL93HpS3lQvLF1R1igeaH+CSPfJSbm5cy1FHh/3waYYUGJBMFGHK/16+CBzLAIc=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2019 20:47:56.7820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e52dc1-d220-4934-213d-08d73d42a69e
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.228];Helo=[usculsndmail01v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR13MB1173
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBzaHVhaA0KPiANCj4gT24gOS8x
OS8xOSAxMjo1NSBQTSwgQWxleGFuZHJlIEJlbGxvbmkgd3JvdGU6DQo+ID4gT24gMTkvMDkvMjAx
OSAxMTowNjo0NC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+ID4+IENvbW1pdCBhNzQ1ZjdhZjNj
YmQgKCJzZWxmdGVzdHMvaGFybmVzczogQWRkIDMwIHNlY29uZCB0aW1lb3V0IHBlcg0KPiA+PiB0
ZXN0Iikgc29sdmVzIHRoZSBwcm9ibGVtIG9mIGtzZWxmdGVzdF9oYXJuZXNzLmgtdXNpbmcgYmlu
YXJ5IHRlc3RzDQo+ID4+IHBvc3NpYmx5IGhhbmdpbmcgZm9yZXZlci4gSG93ZXZlciwgc2NyaXB0
cyBhbmQgb3RoZXIgYmluYXJpZXMgY2FuIHN0aWxsDQo+ID4+IGhhbmcgZm9yZXZlci4gVGhpcyBh
ZGRzIGEgZ2xvYmFsIHRpbWVvdXQgdG8gZWFjaCB0ZXN0IHNjcmlwdCBydW4uDQo+ID4+DQo+IA0K
PiBUaW1lb3V0IGlzIGdvb2QsIGJ1dCByZWFsbHkgdGVzdHMgc2hvdWxkIG5vdCBoYW5nLiBTbyB3
ZSBoYXZlIHRvIHNvbWVob3cNCj4gaW5kaWNhdGUgdGhhdCB0aGUgdGVzdCBuZWVkcyB0byBiZSBm
aXhlZC4NCg0KV2VsbCwgYSB0ZXN0IGhhbmdpbmcgaXMgc29tZXRoaW5nIHRoYXQgbWlnaHQgaW5k
aWNhdGUgZWl0aGVyIGEgZmFpbGluZyANCmluIHRoZSB0ZXN0LCBvciB0aGUgZGV0ZWN0aW9uIG9m
IGFuIGFjdHVhbCBwcm9ibGVtLg0KDQo+IA0KPiBUaGlzIHRpbWVvdXQgaXMgYSBiYW5kLWFpZCBh
bmQgbm90IHJlYWwgc29sdXRpb24gZm9yIHRoZSBwcm9ibGVtLiBUaGlzDQo+IGFyYml0cmFyeSB2
YWx1ZSBkb2Vzbid0IHRha2UgaW50byBhY2NvdW50IHRoYXQgdGhlIHRlc3QocykgaW4gdGhhdA0K
PiBwYXJ0aWN1bGFyIGRpcmVjdG9yeSAoVEFSR0VUKSBjb3VsZCBiZSBydW5uaW5nIG5vcm1hbGx5
IGFuZCB3b3JraW5nDQo+IHRocm91Z2ggYWxsIHRoZSB0ZXN0cy4NClllcy4gIEFsc28sIGhhdmlu
ZyBhIHNpbmdsZSB0aW1lb3V0IHZhbHVlIGRvZXNuJ3QgcmVmbGVjdCB0aGUgbmVlZA0KdG8gdGVz
dCBvbiBkaWZmZXJlbnQgaGFyZHdhcmUgd2l0aCBwb3RlbnRpYWxseSBodWdlIGRpZmZlcmVuY2Vz
IGluDQpDUFUgc3BlZWQgKG9yIG90aGVyIHJlc291cmNlIHBlcmZvcm1hbmNlIGRpZmZlcmVuY2Vz
KS4NCg0KU2luY2Uga3NlbGZ0ZXN0IGhhcyBhIHBvbGljeSBvZiBoYXZpbmcgZWFjaCB0ZXN0IHJ1
biBxdWlja2x5LCB0aGlzIGlzIHNvbWV3aGF0DQptaXRpZ2F0ZWQuICBCdXQgc3RpbGwsIHNvbWUg
ZW1iZWRkZWQgYm9hcmRzIGFyZSBydW5uaW5nIG1hZ25pdHVkZXMNCnNsb3dlciB0aGFuIHlvdXIg
ImF2ZXJhZ2UiIGVudGVycHJpc2UgTGludXggbWFjaGluZS4gIEZpbmRpbmcgYSB0aW1lb3V0DQp0
aGF0IGNhbiBoYW5kbGUgYWxsIGhhcmR3YXJlIGNhc2VzIGlzIGRpZmZpY3VsdC4NCiAtLSBUaW0N
Cg0KPiANCj4gV2UgbmVlZCBzb21lIHdheSB0byBkaWZmZXJlbnRpYXRlIHRoZSB0d28gY2FzZXMu
DQpBZ3JlZWQuDQo+IA0KPiA+PiBUbyBtYWtlIHRoaXMgY29uZmlndXJhYmxlIChlLmcuIGFzIG5l
ZWRlZCBpbiB0aGUgInJ0YyIgdGVzdCBjYXNlKSwNCj4gPj4gaW5jbHVkZSBhIG5ldyBwZXItdGVz
dC1kaXJlY3RvcnkgInNldHRpbmdzIiBmaWxlIChzaW1pbGFyIHRvICJjb25maWciKQ0KPiA+PiB0
aGF0IGNhbiBjb250YWluIGtzZWxmdGVzdC1zcGVjaWZpYyBzZXR0aW5ncy4gVGhlIGZpcnN0IHJl
Y29nbml6ZWQgZmllbGQNCj4gPj4gaXMgInRpbWVvdXQiLg0KPiA+Pg0KPiA+DQo+ID4gU2VlbXMg
Z29vZCB0byBtZS4gSSB3YXMgYWxzbyB3b25kZXJpbmcgd2hldGhlciB0aGlzIGlzIGFjdHVhbGx5
DQo+ID4gcmVhc29uYWJsZSB0byBoYXZlIHRlc3RzIHJ1bm5pbmcgZm9yIHNvIGxvbmcuIEkgd2Fu
dGVkIHRvIGRpc2N1c3MgdGhhdA0KPiA+IGF0IExQQyBidXQgSSBtaXNzZWQgdGhlIHNlc3Npb24u
DQo+ID4NCj4gDQo+IFRoZXJlIGlzIHRoZSBpbmRpdmlkdWFsIHRlc3QgdGltZXMgYW5kIG92ZXJh
bGwga3NlbGZ0ZXN0IHJ1biB0aW1lLiBXZQ0KPiBoYXZlIGxvdHMgb2YgdGVzdHMgbm93IGFuZCBp
dCBkb2VzIHRha2UgbG9uZy4NCj4gDQo+ID4+IEFkZGl0aW9uYWxseSwgdGhpcyBzcGxpdHMgdGhl
IHJlcG9ydGluZyBmb3IgdGltZW91dHMgaW50byBhIHNwZWNpZmljDQo+ID4+ICJUSU1FT1VUIiBu
b3Qtb2sgKGFuZCBhZGRzIGV4aXQgY29kZSByZXBvcnRpbmcgaW4gdGhlIHJlbWFpbmluZyBjYXNl
KS4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1
bS5vcmc+DQo+ID4+IC0tLQ0KPiA+PiAgIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2tzZWxmdGVz
dC9ydW5uZXIuc2ggfCAzNg0KPiArKysrKysrKysrKysrKysrKysrLS0NCj4gPj4gICB0b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9ydGMvc2V0dGluZ3MgICAgICAgIHwgIDEgKw0KPiA+PiAgIDIgZmls
ZXMgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPj4gICBjcmVh
dGUgbW9kZSAxMDA2NDQgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcnRjL3NldHRpbmdzDQo+ID4+
DQo+ID4+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rc2VsZnRlc3QvcnVu
bmVyLnNoDQo+IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3NlbGZ0ZXN0L3J1bm5lci5zaA0K
PiA+PiBpbmRleCAwMGM5MDIwYmRkYTguLjg0ZGU3YmM3NGYyYyAxMDA2NDQNCj4gPj4gLS0tIGEv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3NlbGZ0ZXN0L3J1bm5lci5zaA0KPiA+PiArKysgYi90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rc2VsZnRlc3QvcnVubmVyLnNoDQo+ID4+IEBAIC0zLDkg
KzMsMTQgQEANCj4gPj4gICAjDQo+ID4+ICAgIyBSdW5zIGEgc2V0IG9mIHRlc3RzIGluIGEgZ2l2
ZW4gc3ViZGlyZWN0b3J5Lg0KPiA+PiAgIGV4cG9ydCBza2lwX3JjPTQNCj4gPj4gK2V4cG9ydCB0
aW1lb3V0X3JjPTEyNA0KPiA+PiAgIGV4cG9ydCBsb2dmaWxlPS9kZXYvc3Rkb3V0DQo+ID4+ICAg
ZXhwb3J0IHBlcl90ZXN0X2xvZ2dpbmc9DQo+ID4+DQo+ID4+ICsjIERlZmF1bHRzIGZvciAic2V0
dGluZ3MiIGZpbGUgZmllbGRzOg0KPiA+PiArIyAidGltZW91dCIgaG93IG1hbnkgc2Vjb25kcyB0
byBsZXQgZWFjaCB0ZXN0IHJ1biBiZWZvcmUgZmFpbGluZy4NCj4gPj4gK2V4cG9ydCBrc2VsZnRl
c3RfZGVmYXVsdF90aW1lb3V0PTQ1DQo+ID4+ICsNCj4gPj4gICAjIFRoZXJlIGlzbid0IGEgc2hl
bGwtYWdub3N0aWMgd2F5IHRvIGZpbmQgdGhlIHBhdGggb2YgYSBzb3VyY2VkIGZpbGUsDQo+ID4+
ICAgIyBzbyB3ZSBtdXN0IHJlbHkgb24gQkFTRV9ESVIgYmVpbmcgc2V0IHRvIGZpbmQgb3RoZXIg
dG9vbHMuDQo+ID4+ICAgaWYgWyAteiAiJEJBU0VfRElSIiBdOyB0aGVuDQo+ID4+IEBAIC0yNCw2
ICsyOSwxNiBAQCB0YXBfcHJlZml4KCkNCj4gPj4gICAJZmkNCj4gPj4gICB9DQo+ID4+DQo+ID4+
ICt0YXBfdGltZW91dCgpDQo+ID4+ICt7DQo+ID4+ICsJIyBNYWtlIHN1cmUgdGVzdHMgd2lsbCB0
aW1lIG91dCBpZiB1dGlsaXR5IGlzIGF2YWlsYWJsZS4NCj4gPj4gKwlpZiBbIC14IC91c3IvYmlu
L3RpbWVvdXQgXSA7IHRoZW4NCj4gPj4gKwkJL3Vzci9iaW4vdGltZW91dCAiJGtzZWxmdGVzdF90
aW1lb3V0IiAiJDEiDQo+ID4+ICsJZWxzZQ0KPiA+PiArCQkiJDEiDQo+ID4+ICsJZmkNCj4gPj4g
K30NCj4gPj4gKw0KPiA+PiAgIHJ1bl9vbmUoKQ0KPiA+PiAgIHsNCj4gPj4gICAJRElSPSIkMSIN
Cj4gPj4gQEAgLTMyLDYgKzQ3LDE4IEBAIHJ1bl9vbmUoKQ0KPiA+Pg0KPiA+PiAgIAlCQVNFTkFN
RV9URVNUPSQoYmFzZW5hbWUgJFRFU1QpDQo+ID4+DQo+ID4+ICsJIyBSZXNldCBhbnkgInNldHRp
bmdzIi1maWxlIHZhcmlhYmxlcy4NCj4gPj4gKwlleHBvcnQga3NlbGZ0ZXN0X3RpbWVvdXQ9IiRr
c2VsZnRlc3RfZGVmYXVsdF90aW1lb3V0Ig0KPiA+PiArCSMgTG9hZCBwZXItdGVzdC1kaXJlY3Rv
cnkga3NlbGZ0ZXN0ICJzZXR0aW5ncyIgZmlsZS4NCj4gPj4gKwlzZXR0aW5ncz0iJEJBU0VfRElS
LyRESVIvc2V0dGluZ3MiDQo+ID4+ICsJaWYgWyAtciAiJHNldHRpbmdzIiBdIDsgdGhlbg0KPiA+
PiArCQl3aGlsZSByZWFkIGxpbmUgOyBkbw0KPiA+PiArCQkJZmllbGQ9JChlY2hvICIkbGluZSIg
fCBjdXQgLWQ9IC1mMSkNCj4gPj4gKwkJCXZhbHVlPSQoZWNobyAiJGxpbmUiIHwgY3V0IC1kPSAt
ZjItKQ0KPiA+PiArCQkJZXZhbCAia3NlbGZ0ZXN0XyRmaWVsZCI9IiR2YWx1ZSINCj4gPj4gKwkJ
ZG9uZSA8ICIkc2V0dGluZ3MiDQo+ID4+ICsJZmkNCj4gPj4gKw0KPiA+PiAgIAlURVNUX0hEUl9N
U0c9InNlbGZ0ZXN0czogJERJUjogJEJBU0VOQU1FX1RFU1QiDQo+ID4+ICAgCWVjaG8gIiMgJFRF
U1RfSERSX01TRyINCj4gPj4gICAJaWYgWyAhIC14ICIkVEVTVCIgXTsgdGhlbg0KPiA+PiBAQCAt
NDQsMTQgKzcxLDE3IEBAIHJ1bl9vbmUoKQ0KPiA+PiAgIAkJZWNobyAibm90IG9rICR0ZXN0X251
bSAkVEVTVF9IRFJfTVNHIg0KPiA+PiAgIAllbHNlDQo+ID4+ICAgCQljZCBgZGlybmFtZSAkVEVT
VGAgPiAvZGV2L251bGwNCj4gPj4gLQkJKCgoKCguLyRCQVNFTkFNRV9URVNUIDI+JjE7IGVjaG8g
JD8gPiYzKSB8DQo+ID4+ICsJCSgoKCgoIHRhcF90aW1lb3V0IC4vJEJBU0VOQU1FX1RFU1QgMj4m
MTsgZWNobyAkPyA+JjMpIHwNCj4gPj4gICAJCQl0YXBfcHJlZml4ID4mNCkgMz4mMSkgfA0KPiA+
PiAgIAkJCShyZWFkIHhzOyBleGl0ICR4cykpIDQ+PiIkbG9nZmlsZSIgJiYNCj4gPj4gICAJCWVj
aG8gIm9rICR0ZXN0X251bSAkVEVTVF9IRFJfTVNHIikgfHwNCj4gPj4gLQkJKGlmIFsgJD8gLWVx
ICRza2lwX3JjIF07IHRoZW4JXA0KPiA+PiArCQkocmM9JD87CVwNCj4gPj4gKwkJaWYgWyAkcmMg
LWVxICRza2lwX3JjIF07IHRoZW4JXA0KPiA+PiAgIAkJCWVjaG8gIm5vdCBvayAkdGVzdF9udW0g
JFRFU1RfSERSX01TRyAjIFNLSVAiDQo+ID4+ICsJCWVsaWYgWyAkcmMgLWVxICR0aW1lb3V0X3Jj
IF07IHRoZW4gXA0KPiA+PiArCQkJZWNobyAibm90IG9rICR0ZXN0X251bSAkVEVTVF9IRFJfTVNH
ICMNCj4gVElNRU9VVCINCj4gPj4gICAJCWVsc2UNCj4gPj4gLQkJCWVjaG8gIm5vdCBvayAkdGVz
dF9udW0gJFRFU1RfSERSX01TRyINCj4gPj4gKwkJCWVjaG8gIm5vdCBvayAkdGVzdF9udW0gJFRF
U1RfSERSX01TRyAjDQo+IGV4aXQ9JHJjIg0KPiA+PiAgIAkJZmkpDQo+ID4+ICAgCQljZCAtID4v
ZGV2L251bGwNCj4gPj4gICAJZmkNCj4gPj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL3J0Yy9zZXR0aW5ncw0KPiBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3J0Yy9zZXR0
aW5ncw0KPiA+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+PiBpbmRleCAwMDAwMDAwMDAwMDAu
LmJhNGQ4NWY3NGNkNg0KPiA+PiAtLS0gL2Rldi9udWxsDQo+ID4+ICsrKyBiL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL3J0Yy9zZXR0aW5ncw0KPiA+PiBAQCAtMCwwICsxIEBADQo+ID4+ICt0aW1l
b3V0PTkwDQo+ID4+IC0tDQo+ID4+IDIuMTcuMQ0KPiA+Pg0KPiA+Pg0KPiA+PiAtLQ0KPiA+PiBL
ZWVzIENvb2sNCj4gPg0KPiANCj4gdGhhbmtzLA0KPiAtLSBTaHVhaA0K
