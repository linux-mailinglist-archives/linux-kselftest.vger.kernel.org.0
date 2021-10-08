Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C210426F46
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Oct 2021 18:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhJHQry (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Oct 2021 12:47:54 -0400
Received: from mail-vi1eur05on2041.outbound.protection.outlook.com ([40.107.21.41]:30146
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229525AbhJHQrw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Oct 2021 12:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ny4C4JsC5RBI4+M1NgoG15UbMRt5tlxpcILoySjwIzU=;
 b=vKu1O+8MFFPnJaQK31HAwlk0dekked0F1MK1enfZ5fqTKB3pVP6R0PxeDw5LTcJn91lhzLkPAC0ZpJmi9CzPqLEtrzcImxY3rBRro+a/fIa8ywERjJ8UI70SCDZyvhoU77nvcHniqN40lbgjLlq2949oxHkU7BYs/UuC1vkCBUc=
Received: from DB9PR05CA0026.eurprd05.prod.outlook.com (2603:10a6:10:1da::31)
 by AM5PR0802MB2386.eurprd08.prod.outlook.com (2603:10a6:203:9b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Fri, 8 Oct
 2021 16:45:55 +0000
Received: from DB5EUR03FT018.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:1da:cafe::3c) by DB9PR05CA0026.outlook.office365.com
 (2603:10a6:10:1da::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.21 via Frontend
 Transport; Fri, 8 Oct 2021 16:45:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT018.mail.protection.outlook.com (10.152.20.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 16:45:54 +0000
Received: ("Tessian outbound 2e7020cc8961:v103"); Fri, 08 Oct 2021 16:45:54 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3b47b850724384e8
X-CR-MTA-TID: 64aa7808
Received: from 15bf14c522c0.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C2A2D0DC-BC95-4E36-BB6F-61E37F2A7A35.1;
        Fri, 08 Oct 2021 16:45:46 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 15bf14c522c0.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 08 Oct 2021 16:45:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNQC9aFtYng+dbboF3DOblhN2mOjY6/pPScMa4B+BtrMGcOqlRk2w9/gh4tGLkGN1wtqRcYe8Cu1f6/5cwSZ4/UE4e5ejFpNH9pQwlU4tcjBaFiQraSxSVrvhefxUiIuKyDLs5E+cfnTj/dNVmY+mDvcvfYWUfhZ3ZnzIXXcncOfFbsztatyBL+SHDGwfUVUC721lNdO48ivF/oSDYau2XkplY3QXuBvsxrEnXC4Tct+golSnGEs9pT7RZpjY2c7RDTOdd1JhkVD4cbOGey1vgZUXo7D2AxgXo98IMCMbSZxaMX6mV/TCsZ7eqOXVXEISTCe9KoFjdkIHMgb7ZWlng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ny4C4JsC5RBI4+M1NgoG15UbMRt5tlxpcILoySjwIzU=;
 b=E28dOGirntTq1H/X+OoM1JDicsXIH8yEjiDJxfThgMwd+s4xTqi8DSNsogWji7plziLmQU3bH3JrZjaJWJGFjYr2X08WeQiH5bzYYVmV+F5iQgzUbJ/fztKNPYpMTh3+PqWZSCvWM5wmhilGOxJw1ATRA1G86QdNGj257L5ZF8FT+0BvtgRSee1nwAalune8LvgmniIxlUf+z5n+L1R7LluZ7Hq0xan6ORW79G+SZ5yTy5Ur1tzDqNYcPHOHjXIl4KF/aZ5JWuEp1lU4/osgWFgbKFBJ/3t0Dcy8lwF+QGxdFm7kPJ+z4ob2FUC+5Yc10Pt+GphGcqUpokKHkL6NCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ny4C4JsC5RBI4+M1NgoG15UbMRt5tlxpcILoySjwIzU=;
 b=vKu1O+8MFFPnJaQK31HAwlk0dekked0F1MK1enfZ5fqTKB3pVP6R0PxeDw5LTcJn91lhzLkPAC0ZpJmi9CzPqLEtrzcImxY3rBRro+a/fIa8ywERjJ8UI70SCDZyvhoU77nvcHniqN40lbgjLlq2949oxHkU7BYs/UuC1vkCBUc=
Received: from AM6PR08MB3957.eurprd08.prod.outlook.com (2603:10a6:20b:a2::14)
 by AM6PR08MB4405.eurprd08.prod.outlook.com (2603:10a6:20b:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Fri, 8 Oct
 2021 16:45:44 +0000
Received: from AM6PR08MB3957.eurprd08.prod.outlook.com
 ([fe80::5d0c:6e21:5ba3:ff8e]) by AM6PR08MB3957.eurprd08.prod.outlook.com
 ([fe80::5d0c:6e21:5ba3:ff8e%6]) with mapi id 15.20.4566.022; Fri, 8 Oct 2021
 16:45:44 +0000
From:   Alan Hayward <Alan.Hayward@arm.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Luis Machado <Luis.Machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant KumarDwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH v1 12/38] arm64/sme: Provide ABI documentation for SME
Thread-Topic: [PATCH v1 12/38] arm64/sme: Provide ABI documentation for SME
Thread-Index: AQHXtidOZO4UAjfSg0qeXzNUy0IvB6vJMIuAgAAVfICAABWIgA==
Date:   Fri, 8 Oct 2021 16:45:44 +0000
Message-ID: <0749CCC0-CCEF-4869-9F55-FD9AC97CBA67@arm.com>
References: <20210930181144.10029-1-broonie@kernel.org>
 <20210930181144.10029-13-broonie@kernel.org>
 <59675B79-E426-4177-8A4E-43026E42B9E3@arm.com>
 <YWBjp8UnkMaHsZRA@sirena.org.uk>
In-Reply-To: <YWBjp8UnkMaHsZRA@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: fe83af33-a434-4044-3aa6-08d98a7b18b6
x-ms-traffictypediagnostic: AM6PR08MB4405:|AM5PR0802MB2386:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2386950FFC20B379AC30C0C997B29@AM5PR0802MB2386.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 7BPJFqKLYQnlLR+I70QPAVV+wDrKnQp7PzHcWoIhhLDj0iv4C9WJdM4cMYo/wJZxCLMLt8bxTHRXZLuO6/Y9JLEkf6Rnrawvm4TiDALYgJPbPJkhqgqnwdiE2vXlQc72vg8TyZFVTiHH8NUfVjHlpD17e1X8TNaOVxjM/f6uGbrXC4we7pvfvCyVmxlyHjAshgPqYBksByBMa90B1/Fd2ufKeVUq+qcnPIg4TNPxzQV3dYWzzHK6Y7iZO/dvlKf4nZCPLZutnfPxMAYhaNcNOydyTlC+JUgIo0jLQu6+Eu0eMiRbiCS58OSgf1RtXvechef/gh9iaiVZyG2wGtYpg6bk2bAhYl+paXCo5nfRig6/DbCcM51hxiclsEhZQfrV9D8wbS6mMRJzxTYhxUN8gxHwGKhTSfcaCcti7mTzxeLp4itgohvTM2/hWnTtURccPt5qBT+hQrnkspfNs6RPvu5r0Suh2x7MVcookwlxXOTAhnFKS+/mdGJq7xk9F0yd1/tk9FtesqFgbwtTWtwBd0NKF+oLvU3KZKkNi/L/xzsZIWx1aBiQGabyY8qcflaN6UvgAGGudsDdjKuDJFOuPDM8eKnTSxemanN++m0mgXmkX+AAl9Xe9yD9P9pDIXGDKtc3t71+L2GtD/3yHSots7AkhoSNc/F6hmJG9PQmd+qjN+YQGEK5qGJyTW0jgTK0ZeaA8zWGikUTBl7EJq19pEhS67lXLB384rg26Lp9rkb0hrqUvLL6oY6czixcfQZ7
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3957.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(2616005)(83380400001)(122000001)(66476007)(6486002)(86362001)(64756008)(6916009)(66556008)(38100700002)(36756003)(4326008)(508600001)(316002)(6512007)(54906003)(66446008)(186003)(71200400001)(8936002)(33656002)(38070700005)(6506007)(53546011)(66946007)(91956017)(8676002)(26005)(76116006)(5660300002)(45980500001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA7781806264FE44AD87CD755CA9C09A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4405
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT018.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2853d69b-d84b-4956-d9ec-08d98a7b1264
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6cKZWO5kCDu6AHhZziwyV49rCyvUhdCclyobgF+YcsSi5hTiUxidnJkaZdXG+631txbyWDI/HkHESkf0tF1cnLLPKgLJRYQkqE8h8n98CpUqqNreYx3k/5SydPDEhZcLLfLCb6w5D/e9k0msmjW1vckUA96as4zXlMRgOcT0+gk9quWEDDodsOUMH2KXaVaB8Ygj3b1KCMnzBKvf8/Vz6RL64u7SYwucyDPFAk7l+rlPylKnitfJaAfCRjqnvTFWHi/j6dwcc4bTWxI0ASG6zViDEK3FDj4sDMygilZH93+/cPAniRqq6HjfFSKYxwa0C03yGu7Lq4nehLW9Cbv6CazmSvS1c1RaS9wtLg3ZfU4wZQNCKklhEPqpa5jGA38FrZbMMOo//Tigmw9uZTCtxyHD4M/VZYkyb1W5WfFtWT1yUis1WTS/OwdFiXSsOVF5JA/Eaq7pvt6iWblccCZvO4CailCC2wsn59YIES8PMmLBnPzc0h3b+JVKs45AxpcKKwCGAk/EHXgQf8kfx+XSisNQ9uXQJa4XTxNKEkmdGjvBUe2N4VpJxN7LPtNOFzGXeZJtHrc0gj+cA7LYgOM9t031OGNLa6KkHjYLJU+HQjqBfVXV5+Udf0qe/BlaXvYNJHKZrufkFw4OBiNDKgM40tOVlKrQ/b4lT8Ujgr4MVSyKoFZpeve+LdSLXEqRbkXyiSy+6QP5FxT2Zgoa91wtQQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(186003)(83380400001)(6506007)(53546011)(2616005)(336012)(70206006)(82310400003)(70586007)(26005)(47076005)(4326008)(33656002)(8936002)(2906002)(316002)(508600001)(8676002)(86362001)(54906003)(81166007)(6862004)(6486002)(356005)(5660300002)(6512007)(36860700001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 16:45:54.9775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe83af33-a434-4044-3aa6-08d98a7b18b6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT018.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2386
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gT24gOCBPY3QgMjAyMSwgYXQgMTY6MjgsIE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVs
Lm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIE9jdCAwOCwgMjAyMSBhdCAwMjoxMTo0NlBNICsw
MDAwLCBBbGFuIEhheXdhcmQgd3JvdGU6DQo+IA0KPj4gcmVhZCBsb29rcyBmaW5lLCBnaXZlbiB0
aGlzIGJ1aWxkcyBvbiB0aGUgZXhpc3RpbmcgU1ZFIGltcGxlbWVudGF0aW9uLiBBbHRob3VnaA0K
Pj4gSSB0aGluayBlZmZlY3RpdmVseSBtYW5hZ2luZyB0aGUgZGlmZmVyZW50IG1vZGVzIGluIHRo
ZSBkZWJ1Z2dlciBtYXkgYmUgdHJpY2t5Lg0KPiANCj4gU2FkbHkgSSBkb24ndCBzZWUgYW55IHdh
eSBvZiBoYW5kbGluZyB0aGUgaGFyZHdhcmUgaW4gYSB3YXkgdGhhdA0KPiBkb2Vzbid0IHByZXNl
bnQgc29tZSBraW5kIG9mIGhhc3NsZS4NCg0KQWdyZWVkIC0gY29tcGxleGl0eSBoZXJlIGlzIGZy
b20gdGhlIGhhcmR3YXJlLCBzbyBuZWVkcyBoYW5kbGluZyBieSB0aGUgZGVidWdnZXIgcmVnYXJk
bGVzcy4NCg0KPiANCj4+IFRoZSAucnN0IGZpbGVzIGFyZSBhIGh1Z2UgaGVscCB0b28uDQo+IA0K
PiBHbGFkIHRvIGhlYXIgaXQuDQo+IA0KPj4gV2hhdCBpcyByZXR1cm5lZCBpZiBTTUUgaXMgaW4g
c3RyZWFtaW5nIG1vZGUgYW5kIEkgY2FsbCBHRVRSRUdTRVQgd2l0aCBOVF9BUk1fU1ZFID8NCj4+
IFdoYXQgaXMgcmV0dXJuZWQgaWYgU01FIGlzIG5vdCBpbiBzdHJlYW1pbmcgbW9kZSBhbmQgSSBj
YWxsIEdFVFJFR1NFVCB3aXRoIE5UX0FSTV9TU1ZFID8NCj4gDQo+IEluIGJvdGggY2FzZXMgeW91
J2xsIGdldCB0aGUgdXNlcl9zdmVfaGVhZGVyIHdpdGggbm8gcmVnaXN0ZXINCj4gcGF5bG9hZCBh
bmQgbmVpdGhlciBvZiB0aGUgcmVnaXN0ZXIgdHlwZXMgZmxhZ2dlZC4gIEknbGwgbWFrZQ0KPiB0
aGlzIGEgYml0IG1vcmUgZXhwbGljaXQgaW4gdGhlIGRvY3VtZW50YXRpb24sIGluIHRoZSBTVkUN
Cj4gZG9jdW1lbnRhdGlvbiBpdCBjdXJyZW50bHkganVzdCB0YWxrcyBhYm91dCBubyByZWdpc3Rl
ciBkYXRhDQo+IGJlaW5nIGF2YWlsYWJsZSBidXQgZG9lc24ndCBldmVyIGFjdHVhbGx5IGV4cGxp
Y2l0bHkgc2F5IHdoeSB0aGF0DQo+IHdvdWxkIGhhcHBlbiBsaWtlIHdlIGRvIGZvciBaQSwgaXQn
cyBjdXJyZW50bHkgbm90IHN1cGVyIGhlbHBmdWwuDQoNCk9rLCB0aGF0IHdvcmtzIGZvciBtZS4N
Cg0KPiANCj4+IENhbiBOVF9BUk1fU1NWRSByZXR1cm4gYSBmcHNpbWQ/DQo+IA0KPiBJdCdzIGRv
Y3VtZW50ZWQgdGhhdCB3YXkgZm9yIHNpbXBsaWNpdHkgYnV0IGluIHRoZSBjdXJyZW50DQo+IGlt
cGxlbWVudGF0aW9uIGl0IHdvbid0IGV2ZXIgYWN0dWFsbHkgZG8gc28gaW4gcHJhY3RpY2UuICBU
aGUNCj4gb25seSBjYXNlIHdoZXJlIEkgY291bGQgc2VlIHRoYXQgaXQgbWlnaHQgaGFwcGVuIHdv
dWxkIGJlIGlmIHdlDQo+IGNoYW5nZSB0aGUgc3lzY2FsbHMgdG8gc3RheSBpbiBzdHJlYW1pbmcg
bW9kZSBvdmVyIHN5c2NhbGwsIGluDQo+IHRoYXQgY2FzZSB3ZSBjb3VsZCBkbyBhcyB3ZSBkbyBm
b3IgU1ZFIGFuZCBwcmVzZXJ2ZSBGUFNJTUQNCj4gcmVnaXN0ZXJzIG9ubHkuICBBdCBwcmVzZW50
IHdlIGRyb3Agb3V0IG9mIHN0cmVhbWluZyBtb2RlIGlmIHdlDQo+IGdldCBhIHN5c2NhbGwgd2l0
aCBpdCBlbmFibGVkIHNvIGl0J3MgYSBub24taXNzdWUsIGlmIHBlb3BsZQ0KPiBhZ3JlZSB0aGF0
IHRoYXQncyB0aGUgcmlnaHQgdGhpbmcgZm9yIHRoZSBzeXNjYWxscyB0aGVuIHdlIHNob3VsZA0K
PiB1cGRhdGUgdGhlIGRvY3VtZW50YXRpb24gdG8gc3BlY2lmeSB0aGlzIHNpbmNlIG90aGVyd2lz
ZSB3ZSdsbA0KPiBkb3VidGxlc3MgY2F0Y2ggc29tZW9uZSBieSBzdXJwcmlzZSBpZiB3ZSBldmVy
IG1hbmFnZSB0byBzdGFydA0KPiBkb2luZyBpdCBpbiB0aGUgZnV0dXJlLg0KDQrigKYub3IgaXTi
gJlsbCBlbmQgdXAgZXhlY3V0aW5nIHNvbWUgY29kZSB0aGF0IHdhcyB3cml0dGVuIHRvIGNvcGUg
d2l0aCBmcHNpbWQsIGJ1dCBoYXMgbmV2ZXIgYmVlbg0KcnVuLiBNaWdodCBiZSB3b3J0aCBtYWtp
bmcgaXQgZXhwbGljaXQgaW4gdGhlIGRvY3VtZW50YXRpb24uDQoNCg0KPiANCj4+PiArKiBUaGUg
cHJlc2VuY2Ugb2YgU1ZFIGlzIHJlcG9ydGVkIHRvIHVzZXJzcGFjZSB2aWEgSFdDQVAyX1NNRSBp
biB0aGUgYXV4IHZlY3Rvcg0KPj4gDQo+PiBTTUUgbm90IFNWRT8NCj4gDQo+IEFjaywgeWVzLiAg
V2VsbCwgSSBndWVzcyBnaXZlbiB0aGF0IFNNRSBzaG91bGQgbmV2ZXIgYXBwZWFyIGluIGENCj4g
c3lzdGVtIHdpdGhvdXQgU1ZFIHRoZSBzdGF0ZW1lbnQgaXMgdHJ1ZSBidXQuLi4NCg0K
