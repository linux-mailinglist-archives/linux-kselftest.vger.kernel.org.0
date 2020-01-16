Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF08813E86D
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2020 18:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404551AbgAPRcV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jan 2020 12:32:21 -0500
Received: from mail-bn7nam10on2100.outbound.protection.outlook.com ([40.107.92.100]:19008
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404552AbgAPRcV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jan 2020 12:32:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pr5lG8VtP0Q/oJiuWlEEHJRwT7g+pwoHZoX2eb55tKQ30nwU2QffkRKiiv2PZnE4TTHGO7FU1sxnGrhgPaFTd7/ugynVYVY5btJyNeZ9a7sjznyEwVFTK+GS4j7+dm1O1jFQxYgpBeAu8iy+G4UzoCl+tpCpWJB5kOU4EbkKoGqUBIqwCnJTU3lniN3xTyYpU5gWE73ehgmeF0x8fJ5YugIfFcZTBmDfXzC7L9T2Ag66gmoSaOCd4GEnAD663yMilORWPYZ/M6fJ2zCeVNItZnHEooJB/7S7OgUs/odZtz8SZnfYAIESHuBVqBw8CIyFCjamxrxRTYYWFRvvxXBwCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8o80OMAC0Yoo3luOtczi8USTrcEEtug+H03BsLctnJY=;
 b=fT7BumL8TpQRsOvUmR3MtioTLnLHlfS1vDm5wzMDJoVnctfgIz7a2GMlxVaXIzxmIIjzyu8BOoJvsw42Gl5oKwlE1OTzL45E57slIeqwa2lAwQpw6DObCbgyf8ppeVGBNFmo3PtEIfM7a4ivstgt8seqzdBak9FQA/ZAsxEQJAUvzN+1DxUczsWeUOs67UaAMz9CEcTXEu/Sz4JOuGABPVEwQcCYemlnlJMA5J9AE5zZfVzuIsoZFahQB/PZVgZXpf5yRECtv4YlbJ8L3luiN93dp7LY9Jf36PTccGSMWow73+X06i+uK98EJ5Zv8hGmvUpNc2peAP41EE9rh0CukA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 160.33.194.231) smtp.rcpttodomain=linaro.org smtp.mailfrom=sony.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8o80OMAC0Yoo3luOtczi8USTrcEEtug+H03BsLctnJY=;
 b=FDS+JdHW4JCJ6ywQ8W4YPjoltTCjBpA6bQ4TdzSwvAiXMAM+lRr8xkIO997GqJwe5//cG0c4li6Umljbg3wWebzbM1QxUa/fPy8K//NVI31RYIV+mR/ZwO6SpZJfRnVzkkEfnacOeM06cE/L8O3+2GyaG4XLsc+ZSjN+Qp6HyJY=
Received: from MWHPR13CA0036.namprd13.prod.outlook.com (2603:10b6:300:95::22)
 by DM5PR13MB1452.namprd13.prod.outlook.com (2603:10b6:3:120::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.14; Thu, 16 Jan
 2020 17:32:18 +0000
Received: from BL2NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by MWHPR13CA0036.outlook.office365.com
 (2603:10b6:300:95::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.10 via Frontend
 Transport; Thu, 16 Jan 2020 17:32:18 +0000
Authentication-Results: spf=pass (sender IP is 160.33.194.231)
 smtp.mailfrom=sony.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=pass action=none header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 160.33.194.231 as permitted sender) receiver=protection.outlook.com;
 client-ip=160.33.194.231; helo=usculsndmail04v.am.sony.com;
Received: from usculsndmail04v.am.sony.com (160.33.194.231) by
 BL2NAM02FT021.mail.protection.outlook.com (10.152.77.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 17:32:17 +0000
Received: from usculsndmail13v.am.sony.com (usculsndmail13v.am.sony.com [146.215.230.104])
        by usculsndmail04v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id 00GHWHxH024927;
        Thu, 16 Jan 2020 17:32:17 GMT
Received: from USCULXHUB05V.am.sony.com (hub.bc.in.sel.sony.com [146.215.231.43])
        by usculsndmail13v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id 00GHWGEA017453;
        Thu, 16 Jan 2020 17:32:16 GMT
Received: from USCULXMSG17.am.sony.com ([146.215.231.83]) by
 USCULXHUB05V.am.sony.com ([146.215.231.43]) with mapi id 14.03.0439.000; Thu,
 16 Jan 2020 12:32:16 -0500
From:   <Tim.Bird@sony.com>
To:     <masami.hiramatsu@linaro.org>, <siddhesh@gotplt.org>
CC:     <linux-kselftest@vger.kernel.org>, <shuah@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] kselftest: Minimise dependency of get_size on C library
 interfaces
Thread-Topic: [PATCH] kselftest: Minimise dependency of get_size on C
 library interfaces
Thread-Index: AQHVyjCs4qE38cPZLE+EzJw8ZHLQ46frlWYAgAH6nNA=
Date:   Thu, 16 Jan 2020 17:32:15 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF982C37D2@USCULXMSG17.am.sony.com>
References: <20200113164158.15803-1-siddhesh@gotplt.org>
 <CAA93ih1KXO5oSKAB6PmQc6xOw4fX5T+2+zx91BD18YUxL+nWzQ@mail.gmail.com>
In-Reply-To: <CAA93ih1KXO5oSKAB6PmQc6xOw4fX5T+2+zx91BD18YUxL+nWzQ@mail.gmail.com>
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
X-Forefront-Antispam-Report: CIP:160.33.194.231;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(376002)(136003)(39860400002)(189003)(199004)(336012)(426003)(356004)(53546011)(186003)(54906003)(26005)(110136005)(4326008)(7696005)(966005)(8676002)(8936002)(478600001)(316002)(70206006)(5660300002)(70586007)(956004)(2906002)(2876002)(37786003)(33656002)(246002)(55016002)(55846006)(86362001)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1452;H:usculsndmail04v.am.sony.com;FPR:;SPF:Pass;LANG:en;PTR:mail.sonyusa.com,mail04.sonyusa.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ca18355-4c0a-42d0-8254-08d79aaa08c2
X-MS-TrafficTypeDiagnostic: DM5PR13MB1452:
X-Microsoft-Antispam-PRVS: <DM5PR13MB1452ACB31724C39770416771FD360@DM5PR13MB1452.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YDkQAdav0gFk8Zzj+ONMKCYVmE0plzYhJckyXxdwXJ4/RWYEHpjFjZHwdUNgofYQuw+xiYKt7/BCbRo1iIe9xE+E/xHViDVJ+7JgK2Fp8mC450u822tINqalQeSQLPJpKfNAik1jwaaUdQ+TNcLDLOFWPsU2hxoykxQDqoyViQpoNpFHsgNQi0eLEi+B9/iM30RiHQlDV4rsj0XQtPP1ex5Fpy1JKQFWHkWJ+C9iXiqyGAk19f0sBdJopnJBJXsINpMScmfAhbUBjgS6r19tqHuT344Ifp9u+/Tr+cipMi/tEuXFxs9p6HDR6eljW1Y7uwj5/EmvEJF4cAbNLk77aUbGxQ6W0zy63mz3dZt9TRTTnazRQErzGVfBeRQWR34Aey2j5Yx0XQiZh1p3hNh0LgS4MytvGND5soQhlunZ4bSpgoY2gn/lEflbrGANzMvOtVdLZcQ6JlFqbwBW/QKxa8n0oNmX5VTsRDTpd7zOj6WVMzBRMwRKN4/yhfPF95Erg6ia8/ztsIy+lxcMePTnSEV/lKEaTNFdpy1RpH+Hnka+zZ8keLNThkAt+9XE6l0VjE0lBfT1NrtkHzPqy98RSw==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 17:32:17.8147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca18355-4c0a-42d0-8254-08d79aaa08c2
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.231];Helo=[usculsndmail04v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1452
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFzYW1pIEhpcmFtYXRz
dSA8bWFzYW1pLmhpcmFtYXRzdUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5
IDE0LCAyMDIwIDg6MTQgUE0NCj4gVG86IFNpZGRoZXNoIFBveWFyZWthciA8c2lkZGhlc2hAZ290
cGx0Lm9yZz4NCj4gQ2M6IGxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmc7IFNodWFoIEto
YW4gPHNodWFoQGtlcm5lbC5vcmc+OyBMaW51eCBrZXJuZWwgbWFpbGluZyBsaXN0IDxsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgQmlyZCwgVGltDQo+IDxUaW0uQmlyZEBzb255LmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSF0ga3NlbGZ0ZXN0OiBNaW5pbWlzZSBkZXBlbmRlbmN5IG9m
IGdldF9zaXplIG9uIEMgbGlicmFyeSBpbnRlcmZhY2VzDQo+IA0KPiBIaSwNCj4gDQo+IFtDYzog
VGltIEJpcmRdDQo+IA0KPiAyMDIw5bm0MeaciDE05pelKOeBqykgMTo0MyBTaWRkaGVzaCBQb3lh
cmVrYXIgPHNpZGRoZXNoQGdvdHBsdC5vcmc+Og0KPiANCj4gPg0KPiA+IEl0IHdhcyBvYnNlcnZl
ZFsxXSBvbiBhcm02NCB0aGF0IF9fYnVpbHRpbl9zdHJsZW4gbGVkIHRvIGFuIGluZmluaXRlDQo+
ID4gbG9vcCBpbiB0aGUgZ2V0X3NpemUgc2VsZnRlc3QuICBUaGlzIGlzIGJlY2F1c2UgX19idWls
dGluX3N0cmxlbiAoYW5kDQo+ID4gb3RoZXIgYnVpbHRpbnMpIG1heSBzb21ldGltZXMgcmVzdWx0
IGluIGEgY2FsbCB0byB0aGUgQyBsaWJyYXJ5DQo+ID4gZnVuY3Rpb24uICBUaGUgQyBsaWJyYXJ5
IGltcGxlbWVudGF0aW9uIG9mIHN0cmxlbiB1c2VzIGFuIElGVU5DDQo+ID4gcmVzb2x2ZXIgdG8g
bG9hZCB0aGUgbW9zdCBlZmZpY2llbnQgc3RybGVuIGltcGxlbWVudGF0aW9uIGZvciB0aGUNCj4g
PiB1bmRlcmx5aW5nIG1hY2hpbmUgYW5kIGhlbmNlIGhhcyBhIFBMVCBpbmRpcmVjdGlvbiBldmVu
IGZvciBzdGF0aWMNCj4gPiBiaW5hcmllcy4gIEJlY2F1c2UgdGhpcyBiaW5hcnkgYXZvaWRzIHRo
ZSBDIGxpYnJhcnkgc3RhcnR1cCByb3V0aW5lcywNCj4gPiB0aGUgUExUIGluaXRpYWxpemF0aW9u
IG5ldmVyIGhhcHBlbnMgYW5kIGhlbmNlIHRoZSBwcm9ncmFtIGdldHMgc3R1Y2sNCj4gPiBpbiBh
biBpbmZpbml0ZSBsb29wLg0KPiA+DQo+ID4gT24geDg2XzY0IHRoZSBfX2J1aWx0aW5fc3RybGVu
IGp1c3QgaGFwcGVucyB0byBleHBhbmQgaW5saW5lIGFuZCBhdm9pZA0KPiA+IHRoZSBjYWxsIGJ1
dCB0aGF0IGlzIG5vdCBhbHdheXMgZ3VhcmFudGVlZC4NCj4gPg0KPiA+IEZ1cnRoZXIsIHdoaWxl
IHRlc3Rpbmcgb24geDg2XzY0IChGZWRvcmEgMzEpLCBpdCB3YXMgb2JzZXJ2ZWQgdGhhdCB0aGUN
Cj4gPiB0ZXN0IGFsc28gZmFpbGVkIHdpdGggYSBzZWdmYXVsdCBpbnNpZGUgd3JpdGUoKSBiZWNh
dXNlIHRoZSBnZW5lcmF0ZWQNCj4gPiBjb2RlIGZvciB0aGUgd3JpdGUgZnVuY3Rpb24gaW4gZ2xp
YmMgc2VlbXMgdG8gYWNjZXNzIFRMUyBiZWZvcmUgdGhlDQo+ID4gc3lzY2FsbCAocHJvYmFibHkg
ZHVlIHRvIHRoZSBjYW5jZWxsYXRpb24gcG9pbnQgY2hlY2spIGFuZCBmYWlscw0KPiA+IGJlY2F1
c2UgVExTIGlzIG5vdCBpbml0aWFsaXNlZC4NCj4gPg0KPiA+IFRvIG1pdGlnYXRlIHRoZXNlIHBy
b2JsZW1zLCB0aGlzIHBhdGNoIHJlZHVjZXMgdGhlIGludGVyZmFjZSB3aXRoIHRoZQ0KPiA+IEMg
bGlicmFyeSB0byBqdXN0IHRoZSBzeXNjYWxsIGZ1bmN0aW9uLiAgVGhlIHN5c2NhbGwgZnVuY3Rp
b24gc3RpbGwNCj4gPiBzZXRzIGVycm5vIG9uIGZhaWx1cmUsIHdoaWNoIGlzIHVuZGVzaXJhYmxl
IGJ1dCBmb3Igbm93IGl0IG9ubHkNCj4gPiBhZmZlY3RzIGNhc2VzIHdoZXJlIHN5c2NhbGxzIGZh
aWwuDQo+ID4NCj4gPiBbMV0gaHR0cHM6Ly9idWdzLmxpbmFyby5vcmcvc2hvd19idWcuY2dpP2lk
PTU0NzkNCj4gPg0KPiANCj4gVGhhbmsgeW91IGZvciB0aGUgZml4ISBJIGNvbmZpcm1lZCB0aGlz
IGZpeGVzIHRoZSBpc3N1ZS4NCj4gDQo+IC0tLS0NCj4gcm9vdEBkZXZub3RlMjovb3B0L2tzZWxm
dGVzdC9zaXplIyAuL2dldF9zaXplDQo+IFRBUCB2ZXJzaW9uIDEzDQo+ICMgVGVzdGluZyBzeXN0
ZW0gc2l6ZS4NCj4gb2sgMSBnZXQgcnVudGltZSBtZW1vcnkgdXNlDQo+ICMgU3lzdGVtIHJ1bnRp
bWUgbWVtb3J5IHJlcG9ydCAodW5pdHMgaW4gS2lsb2J5dGVzKToNCj4gIC0tLQ0KPiAgVG90YWw6
ICAxNjA4NTExNg0KPiAgRnJlZTogICAyMDQyODgwDQo+ICBCdWZmZXI6IDgxNDA1Mg0KPiAgSW4g
dXNlOiAxMzIyODE4NA0KPiAgLi4uDQo+IDEuLjENCj4gLS0tLQ0KPiANCj4gVGVzdGVkLWJ5OiBN
YXNhbWkgSGlyYW1hdHN1IDxtYXNhbWkuaGlyYW1hdHN1QGxpbmFyby5vcmc+DQo+IA0KPiANCj4g
PiBTaWduZWQtb2ZmLWJ5OiBTaWRkaGVzaCBQb3lhcmVrYXIgPHNpZGRoZXNoQGdvdHBsdC5vcmc+
DQo+ID4gUmVwb3J0ZWQtYnk6IE1hc2FtaSBIaXJhbWF0c3UgPG1hc2FtaS5oaXJhbWF0c3VAbGlu
YXJvLm9yZz4NCj4gPiAtLS0NCj4gPiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2l6ZS9nZXRf
c2l6ZS5jIHwgMjQgKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAxOCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NpemUvZ2V0X3NpemUuYyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL3NpemUvZ2V0X3NpemUuYw0KPiA+IGluZGV4IGQ0YjU5YWI5NzlhMC4uZjU1OTQz
YjZkMWUyIDEwMDY0NA0KPiA+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NpemUvZ2V0
X3NpemUuYw0KPiA+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NpemUvZ2V0X3NpemUu
Yw0KPiA+IEBAIC0xMiwyMyArMTIsMzUgQEANCj4gPiAgICogb3duIGV4ZWN1dGlvbi4gIEl0IGFs
c28gYXR0ZW1wdHMgdG8gaGF2ZSBhcyBmZXcgZGVwZW5kZW5jaWVzDQo+ID4gICAqIG9uIGtlcm5l
bCBmZWF0dXJlcyBhcyBwb3NzaWJsZS4NCj4gPiAgICoNCj4gPiAtICogSXQgc2hvdWxkIGJlIHN0
YXRpY2FsbHkgbGlua2VkLCB3aXRoIHN0YXJ0dXAgbGlicyBhdm9pZGVkLg0KPiA+IC0gKiBJdCB1
c2VzIG5vIGxpYnJhcnkgY2FsbHMsIGFuZCBvbmx5IHRoZSBmb2xsb3dpbmcgMyBzeXNjYWxsczoN
Cj4gPiArICogSXQgc2hvdWxkIGJlIHN0YXRpY2FsbHkgbGlua2VkLCB3aXRoIHN0YXJ0dXAgbGli
cyBhdm9pZGVkLiAgSXQgdXNlcw0KPiA+ICsgKiBubyBsaWJyYXJ5IGNhbGxzIGV4Y2VwdCB0aGUg
c3lzY2FsbCgpIGZ1bmN0aW9uIGZvciB0aGUgZm9sbG93aW5nIDMNCj4gPiArICogc3lzY2FsbHM6
DQo+ID4gICAqICAgc3lzaW5mbygpLCB3cml0ZSgpLCBhbmQgX2V4aXQoKQ0KPiA+ICAgKg0KPiA+
ICAgKiBGb3Igb3V0cHV0LCBpdCBhdm9pZHMgcHJpbnRmICh3aGljaCBpbiBzb21lIEMgbGlicmFy
aWVzDQo+ID4gICAqIGhhcyBsYXJnZSBleHRlcm5hbCBkZXBlbmRlbmNpZXMpIGJ5ICBpbXBsZW1l
bnRpbmcgaXQncyBvd24NCj4gPiAgICogbnVtYmVyIG91dHB1dCBhbmQgcHJpbnQgcm91dGluZXMs
IGFuZCB1c2luZyBfX2J1aWx0aW5fc3RybGVuKCkNCg0KU2luY2UgdGhlIGNvZGUgbm8gbG9uZ2Vy
IHVzZXMgX19idWlsdGluX3N0cmxlbigpLCB0aGlzIGNvbW1lbnQgc2hvdWxkDQpjaGFuZ2UgYWxz
bywgdG8gc2F5IHNvbWV0aGluZyBsaWtlICJhbmQgc3RyaW5nIGxlbmd0aCBmdW5jdGlvbi4NCg0K
PiA+ICsgKg0KPiA+ICsgKiBUaGUgdGVzdCBtYXkgY3Jhc2ggaWYgYW55IG9mIHRoZSBhYm92ZSBz
eXNjYWxscyBmYWlscyBiZWNhdXNlIGluIHNvbWUNCj4gPiArICogbGliYyBpbXBsZW1lbnRhdGlv
bnMgKGUuZy4gdGhlIEdOVSBDIExpYnJhcnkpIGVycm5vIGlzIHNhdmVkIGluDQo+ID4gKyAqIHRo
cmVhZC1sb2NhbCBzdG9yYWdlLCB3aGljaCBkb2VzIG5vdCBnZXQgaW5pdGlhbGl6ZWQgZHVlIHRv
IGF2b2lkaW5nDQo+ID4gKyAqIHN0YXJ0dXAgbGlicy4NCj4gPiAgICovDQo+ID4NCj4gPiAgI2lu
Y2x1ZGUgPHN5cy9zeXNpbmZvLmg+DQo+ID4gICNpbmNsdWRlIDx1bmlzdGQuaD4NCj4gPiArI2lu
Y2x1ZGUgPHN5cy9zeXNjYWxsLmg+DQo+ID4NCj4gPiAgI2RlZmluZSBTVERPVVRfRklMRU5PIDEN
Cj4gPg0KPiA+ICBzdGF0aWMgaW50IHByaW50KGNvbnN0IGNoYXIgKnMpDQo+ID4gIHsNCj4gPiAt
ICAgICAgIHJldHVybiB3cml0ZShTVERPVVRfRklMRU5PLCBzLCBfX2J1aWx0aW5fc3RybGVuKHMp
KTsNCj4gPiArICAgICAgIHNpemVfdCBsZW4gPSAwOw0KPiA+ICsNCj4gPiArICAgICAgIHdoaWxl
IChzW2xlbl0gIT0gJ1wwJykNCj4gPiArICAgICAgICAgICAgICAgbGVuKys7DQo+ID4gKw0KPiA+
ICsgICAgICAgcmV0dXJuIHN5c2NhbGwoU1lTX3dyaXRlLCBTVERPVVRfRklMRU5PLCBzLCBsZW4p
Ow0KPiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIGlubGluZSBjaGFyICpudW1fdG9fc3RyKHVuc2ln
bmVkIGxvbmcgbnVtLCBjaGFyICpidWYsIGludCBsZW4pDQo+ID4gQEAgLTgwLDEyICs5MiwxMiBA
QCB2b2lkIF9zdGFydCh2b2lkKQ0KPiA+ICAgICAgICAgcHJpbnQoIlRBUCB2ZXJzaW9uIDEzXG4i
KTsNCj4gPiAgICAgICAgIHByaW50KCIjIFRlc3Rpbmcgc3lzdGVtIHNpemUuXG4iKTsNCj4gPg0K
PiA+IC0gICAgICAgY2NvZGUgPSBzeXNpbmZvKCZpbmZvKTsNCj4gPiArICAgICAgIGNjb2RlID0g
c3lzY2FsbChTWVNfc3lzaW5mbywgJmluZm8pOw0KPiA+ICAgICAgICAgaWYgKGNjb2RlIDwgMCkg
ew0KPiA+ICAgICAgICAgICAgICAgICBwcmludCgibm90IG9rIDEiKTsNCj4gPiAgICAgICAgICAg
ICAgICAgcHJpbnQodGVzdF9uYW1lKTsNCj4gPiAgICAgICAgICAgICAgICAgcHJpbnQoIiAtLS1c
biByZWFzb246IFwiY291bGQgbm90IGdldCBzeXNpbmZvXCJcbiAuLi5cbiIpOw0KPiA+IC0gICAg
ICAgICAgICAgICBfZXhpdChjY29kZSk7DQo+ID4gKyAgICAgICAgICAgICAgIHN5c2NhbGwoU1lT
X2V4aXQsIGNjb2RlKTsNCj4gPiAgICAgICAgIH0NCj4gPiAgICAgICAgIHByaW50KCJvayAxIik7
DQo+ID4gICAgICAgICBwcmludCh0ZXN0X25hbWUpOw0KPiA+IEBAIC0xMDEsNSArMTEzLDUgQEAg
dm9pZCBfc3RhcnQodm9pZCkNCj4gPiAgICAgICAgIHByaW50KCIgLi4uXG4iKTsNCj4gPiAgICAg
ICAgIHByaW50KCIxLi4xXG4iKTsNCj4gPg0KPiA+IC0gICAgICAgX2V4aXQoMCk7DQo+ID4gKyAg
ICAgICBzeXNjYWxsKFNZU19leGl0LCAwKTsNCj4gPiAgfQ0KPiA+IC0tDQo+ID4gMi4yNC4xDQoN
ClRoYW5rcyB2ZXJ5IG11Y2ggZm9yIHRoaXMgYnVnIHJlcG9ydCBhbmQgZml4ISENCg0KUmV2aWV3
ZWQtYnk6IFRpbSBCaXJkIDx0aW0uYmlyZEBzb255LmNvbT4NCg0KIC0tIFRpbQ0KDQo=
