Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB3BDA40FB
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2019 01:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfH3XXE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 19:23:04 -0400
Received: from mail-eopbgr820134.outbound.protection.outlook.com ([40.107.82.134]:37093
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728122AbfH3XXD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 19:23:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9EFpWljsoS0I60NPC9z02wlvDxfV8vrQIyuEWhfI1kv8PeQ/BR/DJ3DH2JhKOYooTQEv/NIs/8KjTaYv0Zi3BdeaVarbdBKtblhF3O9Bfi489OteObI+wxQnmhLAkTJdwGJYpxOP/7QaIPQtSR83grNBeRj0U3sIzM+azklvS2NtVHi2waN6QYh37z5yNkLQt1PETfnE0N9EHs2L0mB4EDy0qHb9sjSQx2r9KW1CkSm7RmxpsfOd+UHfnceNFs+VY+N9fCvXpSuxvd0oFDJoH8HhQ6PG/cwDK9g/Xx3FX0tSNwGgSl3/Go04R5s2huw6xXwLJDc7BslYJXp2b6fOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8Fu3u+qEIZ+r0p2rboBbLUphQGTsPs2OQ8XZw2gdyQ=;
 b=h4oDGtyPEx4Znfy13Ar2k6ZpUpHBVJODdiYQrbiJwY+2dAbdK0q61ZeUDhbZo1+AC80X6ZFDRQrFFXYS8CIJF3GwP+y+v6eRFW6Y5I9sLRP5bXVyC3Lo90UR0mLD4SPdiVY2P4x76yUKiiewd6a4dfW4euQBRtw6zMD1yLO+zU4yJngwJnJxKMiT8SbuUAmwxNbPt5Vj0/z18Zq3qqs0Mc9jY4bFJ+fWeQx1EJMjfjEiLMEmy9siuvAC3OA2Y9qvOE/6J/EU2FCHOVGgsgs0UPzY1jFVC0bYMSMw6dOnHdvqK7yqYmlHA6PVWKjj+eOQcMD1K8j6lZCzJA9N9/Us4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 160.33.194.231) smtp.rcpttodomain=google.com smtp.mailfrom=sony.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8Fu3u+qEIZ+r0p2rboBbLUphQGTsPs2OQ8XZw2gdyQ=;
 b=ASxDscvUcRLwCyT/LGD1PY1qw9hIPt5C+kVWTp1h2snMISr8rI+Ar1+pVsedQxrDvFE4jfyrUnGXy1KXuYAEOkH7gUT5vtCbbSzd6bu0H/nCUF2W+PJjpFXvb/qSCxgvXcUz8RG9JmN5WepUUE50WxlcmWa1ArVBV+rtVjxHOb8=
Received: from BN4PR13CA0003.namprd13.prod.outlook.com (2603:10b6:403:3::13)
 by MWHPR1301MB1968.namprd13.prod.outlook.com (2603:10b6:301:32::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.6; Fri, 30 Aug
 2019 23:23:00 +0000
Received: from SN1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by BN4PR13CA0003.outlook.office365.com
 (2603:10b6:403:3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2241.5 via Frontend
 Transport; Fri, 30 Aug 2019 23:23:00 +0000
Authentication-Results: spf=pass (sender IP is 160.33.194.231)
 smtp.mailfrom=sony.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 160.33.194.231 as permitted sender) receiver=protection.outlook.com;
 client-ip=160.33.194.231; helo=usculsndmail04v.am.sony.com;
Received: from usculsndmail04v.am.sony.com (160.33.194.231) by
 SN1NAM02FT048.mail.protection.outlook.com (10.152.72.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Fri, 30 Aug 2019 23:22:59 +0000
Received: from usculsndmail14v.am.sony.com (usculsndmail14v.am.sony.com [146.215.230.105])
        by usculsndmail04v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x7UNMwcT002201;
        Fri, 30 Aug 2019 23:22:58 GMT
Received: from USCULXHUB05V.am.sony.com (usculxhub05v.am.sony.com [146.215.231.43])
        by usculsndmail14v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x7UNMuZM010809;
        Fri, 30 Aug 2019 23:22:57 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB05V.am.sony.com ([146.215.231.43]) with mapi id 14.03.0439.000; Fri,
 30 Aug 2019 19:22:57 -0400
From:   <Tim.Bird@sony.com>
To:     <brendanhiggins@google.com>, <joe@perches.com>
CC:     <shuah@kernel.org>, <sergey.senozhatsky.work@gmail.com>,
        <kunit-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <frowand.list@gmail.com>,
        <sboyd@kernel.org>, <pmladek@suse.com>,
        <sergey.senozhatsky@gmail.com>, <rostedt@goodmis.org>,
        <rdunlap@infradead.org>, <sfr@canb.auug.org.au>
Subject: RE: [PATCH v2] kunit: fix failure to build without printk
Thread-Topic: [PATCH v2] kunit: fix failure to build without printk
Thread-Index: AQHVXYOHSzY8I+qIqESnE7HuJlTJpKcQk8yAgAIK7gCAAMSnAIAA6NiAgAAj6AD//87t0IAAUmyAgAAEeID//8ADsA==
Date:   Fri, 30 Aug 2019 23:22:43 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF977A8416@USCULXMSG01.am.sony.com>
References: <20190828093143.163302-1-brendanhiggins@google.com>
 <20190828094929.GA14038@jagdpanzerIV>
 <8b2d63bf-56cd-e8f5-e8ee-2891c2c1be8f@kernel.org>
 <f2d5b474411b2940d62198490f06e77890fbdb32.camel@perches.com>
 <20190830183821.GA30306@google.com>
 <bc688b00b2995e4b11229c3d4d90f532e00792c7.camel@perches.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF977A8392@USCULXMSG01.am.sony.com>
 <ca01d8c4823c63db52fc0f18d62334aeb5634a50.camel@perches.com>
 <CAFd5g45X8bOiTWn5TMe3iEFwASafr6dWo6c4bG32uRKbQ+r5oA@mail.gmail.com>
In-Reply-To: <CAFd5g45X8bOiTWn5TMe3iEFwASafr6dWo6c4bG32uRKbQ+r5oA@mail.gmail.com>
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
X-Forefront-Antispam-Report: CIP:160.33.194.231;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(376002)(396003)(2980300002)(199004)(189003)(13464003)(54906003)(55846006)(2906002)(229853002)(55016002)(2486003)(6246003)(70586007)(8936002)(6116002)(5660300002)(70206006)(3846002)(8676002)(23676004)(246002)(305945005)(2876002)(86362001)(7736002)(37786003)(7416002)(336012)(486006)(47776003)(7696005)(426003)(11346002)(446003)(33656002)(4326008)(6666004)(53546011)(66066001)(186003)(102836004)(356004)(436003)(476003)(126002)(76176011)(14444005)(478600001)(26005)(110136005)(50466002)(106002)(316002)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR1301MB1968;H:usculsndmail04v.am.sony.com;FPR:;SPF:Pass;LANG:en;PTR:mail.sonyusa.com,mail04.sonyusa.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c726c06e-9f7c-44a7-65f4-08d72da0ffa2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);SRVR:MWHPR1301MB1968;
X-MS-TrafficTypeDiagnostic: MWHPR1301MB1968:
X-Microsoft-Antispam-PRVS: <MWHPR1301MB19683449622542160106DE4EFDBD0@MWHPR1301MB1968.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0145758B1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: KdNBihewc4drTkG0hUbGOnDJJK01Kwmt05nF5krmDZM5dSYgEp05CAX96dDHSe+M7sCdio8ZON31NxtQ9KbAD2Nf+xu65rRR6qesEz42KxEoT1G32TszfrwNNppeT9EBbO1Q1ZGz6+hx6Wq9s/lmYSWUJwmuF7TMofZB8JyqD5TJkpV/ZCjBFc10qyNn7m1RDBS1A5JrlpHDkNJoGLpQRWW6CjaPQ8olytm4HKkKZdIC46ixk5ZWazuyfagXw/tgpsdE8P9Ix6h0TlE/yv9RmpR6PDjKYmdHngRIOKzHskYa2d0rDIiugrk1sKXD/75BQ95GYR3Elfos5wD10C5RJjEREH/B7qk+ssPDKKLbWvlLgco7V05WThy87m9fLq+aZQi2p7/1eayzojLt2xN3Mi8rTz+YSDCHz+rFYIKOL0A=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2019 23:22:59.7108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c726c06e-9f7c-44a7-65f4-08d72da0ffa2
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.231];Helo=[usculsndmail04v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1301MB1968
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCcmVuZGFuIEhpZ2dpbnMgDQo+
IA0KPiBPbiBGcmksIEF1ZyAzMCwgMjAxOSBhdCAzOjQ2IFBNIEpvZSBQZXJjaGVzIDxqb2VAcGVy
Y2hlcy5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gRnJpLCAyMDE5LTA4LTMwIGF0IDIxOjU4ICsw
MDAwLCBUaW0uQmlyZEBzb255LmNvbSB3cm90ZToNCj4gPiA+ID4gRnJvbTogSm9lIFBlcmNoZXMN
Cj4gPiBbXQ0KPiA+ID4gSU1ITyAlcFYgc2hvdWxkIGJlIGF2b2lkZWQgaWYgcG9zc2libGUuICBK
dXN0IGJlY2F1c2UgcGVvcGxlIGFyZQ0KPiA+ID4gZG9pbmcgaXQgZG9lc24ndCBtZWFuIGl0IHNo
b3VsZCBiZSB1c2VkIHdoZW4gaXQgaXMgbm90IG5lY2Vzc2FyeS4NCj4gPg0KPiA+IFdlbGwsIGFz
IHRoZSBndXkgdGhhdCBjcmVhdGVkICVwViwgSSBvZiBjb3Vyc2UNCj4gPiBoYXZlIGEgZGlmZmVy
ZW50IG9waW5pb24uDQo+ID4NCj4gPiA+ID4gIHRoZW4gd291bGRuJ3QgaXQgYmUgZWFzaWVyIHRv
IHBhc3MgaW4gdGhlDQo+ID4gPiA+ID4ga2VybmVsIGxldmVsIGFzIGEgc2VwYXJhdGUgcGFyYW1l
dGVyIGFuZCB0aGVuIHN0cmlwIG9mZiBhbGwgcHJpbnRrDQo+ID4gPiA+ID4gaGVhZGVycyBsaWtl
IHRoaXM6DQo+ID4gPiA+DQo+ID4gPiA+IERlcGVuZHMgb24gd2hldGhlciBvciBub3QgeW91IGNh
cmUgZm9yIG92ZXJhbGwNCj4gPiA+ID4gb2JqZWN0IHNpemUuICBDb25zb2xpZGF0ZWQgZm9ybWF0
cyB3aXRoIHRoZQ0KPiA+ID4gPiBlbWJlZGRlZCBLRVJOXzxMRVZFTD4gbGlrZSBzdWdnZXN0ZWQg
YXJlIHNtYWxsZXINCj4gPiA+ID4gb3ZlcmFsbCBvYmplY3Qgc2l6ZS4NCj4gPiA+DQo+ID4gPiBU
aGlzIGlzIGFuIGFyZ3VtZW50IEkgY2FuIGFncmVlIHdpdGguICBJJ20gZ2VuZXJhbGx5IGluIGZh
dm9yIG9mDQo+ID4gPiB0aGluZ3MgdGhhdCBsZXNzZW4ga2VybmVsIHNpemUgY3JlZXAuIDotKQ0K
PiA+DQo+ID4gQXMgYW0gSS4NCj4gDQo+IFNvcnJ5LCB0byBiZSBjbGVhciwgd2UgYXJlIHRhbGtp
bmcgYWJvdXQgdGhlIG9iamVjdCBzaXplIHBlbmFsdHkgZHVlDQo+IHRvIGFkZGluZyBhIHNpbmds
ZSBwYXJhbWV0ZXIgdG8gYSBmdW5jdGlvbi4gSXMgdGhhdCByaWdodD8NCg0KTm90IGV4YWN0bHku
ICBUaGUgYXJndW1lbnQgaXMgdGhhdCBwcmUtcGVuZGluZyB0aGUgZGlmZmVyZW50IEtFUk5fTEVW
RUwNCnN0cmluZ3Mgb250byBmb3JtYXQgc3RyaW5ncyBjYW4gcmVzdWx0IGluIHNldmVyYWwgdmVy
c2lvbnMgb2YgbmVhcmx5IGlkZW50aWNhbCBzdHJpbmdzDQpiZWluZyBjb21waWxlZCBpbnRvIHRo
ZSBvYmplY3QgZmlsZS4gIEJ5IHBhcmFtZXRlcml6aW5nIHRoaXMgKHRoYXQgaXMsIGFkZGluZw0K
JyVzJyBpbnRvIHRoZSBmb3JtYXQgc3RyaW5nLCBhbmQgcHV0dGluZyB0aGUgbGV2ZWwgaW50byB0
aGUgc3RyaW5nIGFzIGFuIGFyZ3VtZW50KSwNCml0IHByZXZlbnRzIHRoaXMgZHVwbGljYXRpb24g
b2YgZm9ybWF0IHN0cmluZ3MuDQoNCkkgaGF2ZW4ndCBzZWVuIHRoZSBkYXRhIG9uIGR1cGxpY2F0
aW9uIG9mIGZvcm1hdCBzdHJpbmdzLCBhbmQgaG93IG11Y2ggdGhpcw0KYWZmZWN0cyBpdCwgYnV0
IGxpdHRsZSB0aGluZ3MgY2FuIGFkZCB1cC4gIFdoZXRoZXIgaXQgbWF0dGVycyBpbiB0aGlzIGNh
c2UgZGVwZW5kcw0Kb24gd2hldGhlciB0aGUgZm9ybWF0IHN0cmluZ3MgdGhhdCBrdW5pdCB1c2Vz
IGFyZSBhbHNvIHVzZWQgZWxzZXdoZXJlIGluIHRoZSBrZXJuZWwsDQphbmQgd2hldGhlciB0aGVz
ZSBzYW1lIGZvcm1hdCBzdHJpbmdzIGFyZSB1c2VkIHdpdGggbXVsdGlwbGUga2VybmVsIG1lc3Nh
Z2UgbGV2ZWxzLg0KIC0tIFRpbQ0KDQo=
