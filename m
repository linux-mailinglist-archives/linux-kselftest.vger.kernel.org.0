Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC8AD043E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2019 01:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfJHXkC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Oct 2019 19:40:02 -0400
Received: from mail-eopbgr810132.outbound.protection.outlook.com ([40.107.81.132]:45184
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726822AbfJHXkC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Oct 2019 19:40:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNog7rajBj0AMyXTpMOaX6Eae6Fbeh9a9gNGu0Z/iD1Pe6C3D6Ir7vHaCkugBK4uwuenxfRCuQsgGPllLxt1VWccI5udHzSjp6dUZQGDs+PlersvypBvy5RUkb5UaNEuM8cf30kWjtxMNF5UZBaFEnYhuDH/gewFw6sMoYQwBXOteBJ8+wLIFGQjWZE7YZzAhuOMhgVfAQB9h3b40789wVGlFrlLajK1Vz793fwA+UPh+H1WeYVSdT9/Y5XohN4GDMb2Jjy6yXhAVoe704CVpBTGEhzqRSV083lW60OECm4ZpsgX6Br2T7UHDUT0Zl2TS/EsBHZQLF9Vh5xY4gVWKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3M3/ThAE8/QquyNYGTLxXjM+jR60N6eesMcrEq9b4fw=;
 b=lZkmlfMRwFI0xfMqN23O1BsVn2aW9ML50aFWX2Qx7F/x9EqJ2neL8oU3yoR4IVu8T1JebmfNYM4uw/vJrMGPdv4dWRx+Ulm0ijnKFXMbeh5J2LdZgu2oe8qP1BxVJ67UPvrxJ1QcJm9BeZ2CxNKQBZuhN2AIJScFicRLGnzkDpJvOds1dMCV0F5LCxcK16wXZerT4wCTvhXz4gWBsPhxhPQUPQh/qOB40IN3K4V1Kve2eHAhzeUo75LFzCTU6jkVkJdQ8AJ5ooqa0XrQpJQlf0yvdsJTlhVefrjPIDTRD9GlHM+No9tuUmNnDdlX6Rpn0e21OGEciXpyCw6mVLMf0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 160.33.194.231) smtp.rcpttodomain=kernel.org smtp.mailfrom=sony.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3M3/ThAE8/QquyNYGTLxXjM+jR60N6eesMcrEq9b4fw=;
 b=u/nwY4sFLJ2b3IuYS9++R4klu6rO0QocnA/8piVFMeTRrKqeYPBl+Bz4Vb6QkmY93Oq3j7A1FnR9kojDkX5x/Mvu25MAsQyUMT3z88afBR5DdWWZ3V2TS80Y/VWofVDbgpvzqbFREOzrfyjqT55N+Hp3jIFAqM73Wcds578x2tU=
Received: from BY5PR13CA0014.namprd13.prod.outlook.com (2603:10b6:a03:180::27)
 by DM5PR13MB1370.namprd13.prod.outlook.com (2603:10b6:3:32::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.13; Tue, 8 Oct 2019 23:39:59 +0000
Received: from BL2NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by BY5PR13CA0014.outlook.office365.com
 (2603:10b6:a03:180::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.13 via Frontend
 Transport; Tue, 8 Oct 2019 23:39:59 +0000
Authentication-Results: spf=pass (sender IP is 160.33.194.231)
 smtp.mailfrom=sony.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 160.33.194.231 as permitted sender) receiver=protection.outlook.com;
 client-ip=160.33.194.231; helo=usculsndmail04v.am.sony.com;
Received: from usculsndmail04v.am.sony.com (160.33.194.231) by
 BL2NAM02FT003.mail.protection.outlook.com (10.152.76.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.21 via Frontend Transport; Tue, 8 Oct 2019 23:39:58 +0000
Received: from usculsndmail14v.am.sony.com (usculsndmail14v.am.sony.com [146.215.230.105])
        by usculsndmail04v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x98Ndv4V030804;
        Tue, 8 Oct 2019 23:39:57 GMT
Received: from USCULXHUB06V.am.sony.com (hub.bc.in.sel.sony.com [146.215.231.44])
        by usculsndmail14v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x98Ndv2Y031845;
        Tue, 8 Oct 2019 23:39:57 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB06V.am.sony.com ([146.215.231.44]) with mapi id 14.03.0439.000; Tue,
 8 Oct 2019 19:39:56 -0400
From:   <Tim.Bird@sony.com>
To:     <mhiramat@kernel.org>, <shuah@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jaswinder.singh@linaro.org>
Subject: RE: [BUGFIX PATCH] selftests: Use real temporary working directory
 for archiving
Thread-Topic: [BUGFIX PATCH] selftests: Use real temporary working directory
 for archiving
Thread-Index: AQHVenJ/OodmVHlzH0a4MJwQpqE3j6dRbbzg
Date:   Tue, 8 Oct 2019 23:39:40 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF977C0D28@USCULXMSG01.am.sony.com>
References: <157016600217.8022.346317009413291058.stgit@devnote2>
In-Reply-To: <157016600217.8022.346317009413291058.stgit@devnote2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [146.215.231.6]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:160.33.194.231;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(346002)(376002)(174864002)(13464003)(199004)(189003)(6116002)(305945005)(316002)(3846002)(7736002)(86362001)(478600001)(8676002)(8936002)(246002)(33656002)(14444005)(2906002)(106002)(2876002)(54906003)(110136005)(55846006)(476003)(486006)(23676004)(446003)(426003)(126002)(4326008)(102836004)(436003)(70206006)(26005)(6666004)(70586007)(76176011)(356004)(5660300002)(6246003)(11346002)(336012)(50466002)(66066001)(229853002)(7696005)(47776003)(55016002)(2486003)(186003)(37786003)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1370;H:usculsndmail04v.am.sony.com;FPR:;SPF:Pass;LANG:en;PTR:mail04.sonyusa.com,mail.sonyusa.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a474d62-f1c0-4a6f-524c-08d74c48d4d3
X-MS-TrafficTypeDiagnostic: DM5PR13MB1370:
X-Microsoft-Antispam-PRVS: <DM5PR13MB13709D05B5B8D993CAF47C44FD9A0@DM5PR13MB1370.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 01842C458A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oYjcC1YZbGu4FNTIn5Zq83U+ucVdZTvJviC8BLYuJr2Pu93khSQ9+4DP704iBInhJ/f0ffNNI59RbsOsy4U0HtUp8x3AktueiC1DLcsE46GDs7l6Qjm5dAxnCfLUolB7164sjEuKEWQapfDPIDnqkS4I6vSqM6Usz/tOE9nWBH/AC7zEuJF26DYTDB9QDETH4rprQTRFZBl+RE4AZZMebYdV+atwAMqW/nTscghvg8QkuAskVtnVp4ThoggcHY8XwAJpndBKNPX3TFtavbuaQGdFWk58fWn7BXYVjD4P58Ttv4eg/8ezq/vxCCLUB6T9QuubVqWetAfPetdjpB/9MChYpm1tYyId9M08x6Sn3U9GP8ew5dsD2gFZJxnfYFEmGrVY9gVKeZak6pWsM17bMYdS9/8Y28mLIo2vD5DDjds=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2019 23:39:58.7989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a474d62-f1c0-4a6f-524c-08d74c48d4d3
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.231];Helo=[usculsndmail04v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1370
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFzYW1pIEhpcmFtYXRz
dSBvbiBUaHVyc2RheSwgT2N0b2JlciAwMywgMjAxOSA3OjEzIFBNDQo+IA0KPiBVc2UgcmVhbCB0
ZW1wb3Jhcnkgd29ya2luZyBkaXJlY3RvcnkgZm9yIGdlbmVyYXRpbmcga3NlbGZ0ZXN0DQo+IGFy
Y2hpdmUuDQo+IA0KPiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rc2VsZnRlc3QgZGlyZWN0b3J5
IGhhcyBiZWVuIHVzZWQgZm9yDQo+IHRoZSB0ZW1wb3Jhcnkgd29ya2luZyBkaXJlY3RvcnkgZm9y
IG1ha2luZyBhIHRhciBhcmNoaXZlIGZyb20NCj4gZ2VuX2tzZWxmdGVzdF90YXIuc2gsIGFuZCBp
dCByZW1vdmVzIHRoZSBkaXJlY3RvcnkgZm9yIGNsZWFudXAuDQo+IA0KPiBIb3dldmVyLCBzaW5j
ZSB0aGUga3NlbGZ0ZXN0IGRpcmVjdG9yeSBiZWNhbWUgYSBwYXJ0IG9mIHRoZQ0KPiByZXBvc2l0
b3J5LCBpdCBtdXN0IG5vdCBiZSB1c2VkIGFzIGEgd29ya2luZyBkaXIuDQoNCkknbSBub3Qgb2Jq
ZWN0aW5nIHRvIHRoZSB0ZXN0LCBidXQgSSB3b3VsZCBsaWtlIHRvIHVuZGVyc3RhbmQgdGhpcw0K
cG9pbnQgYmV0dGVyLiAgVW5kZXIgbm9ybWFsIGNpcmN1bXN0YW5jZXMgKGkuZS4gd2hlbiBub3Qg
dXNpbmcgTz0gb3IgS0JVSUxEX09VVFBVVCkNCnRoZSByZXN0IG9mIHRoZSBrZXJuZWwgZGlyZWN0
b3J5IHN0cnVjdHVyZSBob2xkcyBnZW5lcmF0ZWQgZmlsZXMuDQpXaGF0IGlzIHRoZSBpc3N1ZSB3
aXRoIHVzaW5nIGtzZWxmdGVzdCB0byBob2xkIGdlbmVyYXRlZCBmaWxlcz8NCiAtLSBUaW0NCg0K
PiANCj4gSW50cm9kdWNlIG1rdGVtcCB0byBwcmVwYXJlIGEgdGVtcG9yYXJ5IHdvcmtpbmcgZGly
ZWN0b3J5DQo+IGZvciBhcmNoaXZpbmcga3NlbGZ0ZXN0cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IE1hc2FtaSBIaXJhbWF0c3UgPG1oaXJhbWF0QGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiAgdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvZ2VuX2tzZWxmdGVzdF90YXIuc2ggfCAgICA4ICsrKystLS0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2dlbl9rc2VsZnRlc3RfdGFyLnNo
DQo+IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZ2VuX2tzZWxmdGVzdF90YXIuc2gNCj4gaW5k
ZXggYTI3ZTJlZWMzNTg2Li5lYmExZTk5ODdmZmMgMTAwNzU1DQo+IC0tLSBhL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL2dlbl9rc2VsZnRlc3RfdGFyLnNoDQo+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2dlbl9rc2VsZnRlc3RfdGFyLnNoDQo+IEBAIC0zOCwxNiArMzgsMTYgQEAgbWFp
bigpDQo+ICAJZXNhYw0KPiAgCWZpDQo+IA0KPiAtCWluc3RhbGxfZGlyPS4va3NlbGZ0ZXN0DQo+
ICsJdG1wZGlyPWBta3RlbXAgLWQgLi9pbnN0YWxsLVhYWFhYWGAgfHwgZXhpdCAxDQo+IA0KPiAg
IyBSdW4gaW5zdGFsbCB1c2luZyBJTlNUQUxMX0tTRlRfUEFUSCBvdmVycmlkZSB0byBnZW5lcmF0
ZSBpbnN0YWxsDQo+ICAjIGRpcmVjdG9yeQ0KPiAtLi9rc2VsZnRlc3RfaW5zdGFsbC5zaA0KPiAt
dGFyICRjb3B0cyBrc2VsZnRlc3Qke2V4dH0gJGluc3RhbGxfZGlyDQo+ICsuL2tzZWxmdGVzdF9p
bnN0YWxsLnNoICR0bXBkaXINCj4gK3RhciAkY29wdHMga3NlbGZ0ZXN0JHtleHR9IC1DICR0bXBk
aXIga3NlbGZ0ZXN0DQo+ICBlY2hvICJLc2VsZnRlc3QgYXJjaGl2ZSBrc2VsZnRlc3Qke2V4dH0g
Y3JlYXRlZCEiDQo+IA0KPiAgIyBjbGVhbiB1cCBpbnN0YWxsIGRpcmVjdG9yeQ0KPiAtcm0gLXJm
IGtzZWxmdGVzdA0KPiArcm0gLXJmICR0bXBkaXINCj4gIH0NCj4gDQo+ICBtYWluICIkQCINCg0K
