Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8D9428BD2
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Oct 2021 13:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbhJKLRX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Oct 2021 07:17:23 -0400
Received: from mail-eopbgr20048.outbound.protection.outlook.com ([40.107.2.48]:2222
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235970AbhJKLRW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Oct 2021 07:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2d3g7luhCRcd0wGVAH5ynCPcFeMu8ON0KprvA9OmN8=;
 b=b5RfJBIxeJMHH6QJdzEIj4oi4izYr65C2rBgK6tkzPus1ve3MXt8CKRtk3HKOiDHuiBP8OBTjDbQmjPxRMq4Ww4QhT1wNA/Nv7qTFA94lEVxBn+3FbBQ1OjoO0tnlxsr82UlMxq++nTexA8HmDL74PcVCepXvZZbCfD41rCQfm4=
Received: from DB6PR0801CA0066.eurprd08.prod.outlook.com (2603:10a6:4:2b::34)
 by VI1PR08MB3791.eurprd08.prod.outlook.com (2603:10a6:803:c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Mon, 11 Oct
 2021 11:15:18 +0000
Received: from DB5EUR03FT044.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:2b:cafe::b) by DB6PR0801CA0066.outlook.office365.com
 (2603:10a6:4:2b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Mon, 11 Oct 2021 11:15:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT044.mail.protection.outlook.com (10.152.21.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 11:15:18 +0000
Received: ("Tessian outbound 8e26f7114b75:v103"); Mon, 11 Oct 2021 11:15:18 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c29aac52253b5d5f
X-CR-MTA-TID: 64aa7808
Received: from 75a8cd70f0f8.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0AFA66E4-8881-42E7-9C5D-D8CF1AD32D42.1;
        Mon, 11 Oct 2021 11:15:12 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 75a8cd70f0f8.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 11 Oct 2021 11:15:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+gbYNbY3VEde/ClYsNUM5RLDdYUkyscy3eWUkCibdl4ggM5R3s8OQyR/uz7CKA8ItKd+LDpGUtfLnKxdXErjvYnJ/qsTJOCnBR0GxvvIBxgjn/zNjp38LvTa7aIMy6irCNrz+iN+kzyR1QU2SDeVGF7VzC5NpEVveqRD5kIT1so1h0HKZ4uKvTWPUMqferE5YiN0qDu9hvKVTXGGhzDZ1cKyHVIWtTK7jP/TsNcB0v/ta5H1dPFzWN1pzoDOzojuYyHf0P8odls8dWqvaBPqB9awSXksa9j23ZhtGQJ/0lggVTM3iz7S3GTLhwm0vCCdUp1xRfHTEGsZ6XilNyL3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2d3g7luhCRcd0wGVAH5ynCPcFeMu8ON0KprvA9OmN8=;
 b=h+FHM0Y/JiaD8jjFycHJSo8alDpDeq7yYmTI3AZmSo5sU3AqLfDrM5TECVyche6bTtaMXfMg/NEr56N9AFanZuB3/AHKBSUAhXQdWlFvdqBxYOfWlJUdBAkNIHEoPMGsOJh65hdMfPZ3maqavkAYrIlXDxImTldf5DvSabcqhgO5U925cNwPSk3o4EVDSVAgOivP9L8kATNRcBnW41pQcxJcz3boFiV8n+hathHBeWHVcvQC1swpboYNF0O4zAFN2L9az7/q1qGDO1n/QBTbSb8PKICJOp2FjF+p447RprTxRqPn6FQsCu7cbvnscWNsVtyPYtvvIDKeV5/+ok3TfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2d3g7luhCRcd0wGVAH5ynCPcFeMu8ON0KprvA9OmN8=;
 b=b5RfJBIxeJMHH6QJdzEIj4oi4izYr65C2rBgK6tkzPus1ve3MXt8CKRtk3HKOiDHuiBP8OBTjDbQmjPxRMq4Ww4QhT1wNA/Nv7qTFA94lEVxBn+3FbBQ1OjoO0tnlxsr82UlMxq++nTexA8HmDL74PcVCepXvZZbCfD41rCQfm4=
Received: from AM6PR08MB3957.eurprd08.prod.outlook.com (2603:10a6:20b:a2::14)
 by AS8PR08MB6806.eurprd08.prod.outlook.com (2603:10a6:20b:39b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Mon, 11 Oct
 2021 11:15:11 +0000
Received: from AM6PR08MB3957.eurprd08.prod.outlook.com
 ([fe80::5d0c:6e21:5ba3:ff8e]) by AM6PR08MB3957.eurprd08.prod.outlook.com
 ([fe80::5d0c:6e21:5ba3:ff8e%6]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 11:15:10 +0000
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
Thread-Index: AQHXtidOZO4UAjfSg0qeXzNUy0IvB6vJMIuAgAAVfICAABWIgIAABU4AgARVUwA=
Date:   Mon, 11 Oct 2021 11:15:09 +0000
Message-ID: <78C51A1B-DF42-463B-9B1D-AE96756C5854@arm.com>
References: <20210930181144.10029-1-broonie@kernel.org>
 <20210930181144.10029-13-broonie@kernel.org>
 <59675B79-E426-4177-8A4E-43026E42B9E3@arm.com>
 <YWBjp8UnkMaHsZRA@sirena.org.uk>
 <0749CCC0-CCEF-4869-9F55-FD9AC97CBA67@arm.com>
 <YWB6KmvHGfYBBoxK@sirena.org.uk>
In-Reply-To: <YWB6KmvHGfYBBoxK@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 40752450-9e58-4c46-e467-08d98ca8687f
x-ms-traffictypediagnostic: AS8PR08MB6806:|VI1PR08MB3791:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB379189220C4C74BA995B1CA997B59@VI1PR08MB3791.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: zMrjsB4jonUV0QuFmE3Jk38MevNCCoVGoB1riT3vUkKuKH5BLF2UtzlySOUv7w7EZrlC5aHvYu8jp/0gxaBzrc8W+VtsZQP7MEJCX4JFQB5W358IKwvDlhpKObOgT9LsQFm0D0Vpom6ycpthvCVtdkoKRTbEL4PhFKyLjh60pZyy02085xHSWs8gUqKaxwKPVcih3Y01ZTBnPajlA4oCQNpChVZSGi4KIUmGI5vT+icUnAT1ydCvBQnuV0WhOPxKkT6TB2HTRIeQYXoM2j6MIVqdhSM5220FGCilZEr+Q8tA690KCoRZmJfd5e55cMXLQ7XHkpaVVEAWCkYUh1um3XckTkytwgPIkkzAaw1liii/2u2l4YNX89x3I2usnMRnP2c2nzdAQoKrMEl9OO1KqpYUb8AEaAuXS0lVY2/7dqMKbRWCQBAT34p4Ry1JmuP0hLAgUA5vP32JhhiPd6QHLPdsGS26BrCb10h3MYGYgCjOx6H4KJkmJ1RK/jgE3iH7dXQvjii5I1N2uhdc1J91FmSe8WChTrncwHfBwbITQlw34vdZu6razbI5edLcbjPNy8o2UlMjvhGlagY8yX7o3aW0Pw3zCnOzAUHEw/6ubk5xEmYb4neeQHVQg6jldQ9dnLGlel1nSaZH2GcVBlXNG55PNpyWuw7eIsH8cNj4cGNYLm4y9vQjG6B4CZIH2+Vet8F9DMZnZUT5U3zJymBXpgO0kOapz1obLL1Jlds5JdzkBJXGC9GWEUCzq7PSSY/L
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3957.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(64756008)(36756003)(2616005)(66446008)(508600001)(122000001)(33656002)(38100700002)(91956017)(66476007)(76116006)(71200400001)(6512007)(66946007)(186003)(5660300002)(66556008)(4326008)(6486002)(38070700005)(6506007)(53546011)(8936002)(54906003)(2906002)(26005)(83380400001)(8676002)(6916009)(316002)(45980500001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA9D5482A809FA40AAE02643CB365DB2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6806
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT044.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: d885eeac-5587-43d3-04d1-08d98ca863b0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Drb8Yq3DgaewDd/53ydcaGbz8bo2s4MnldWyeeE3ItPsHkzANIumBTpdylPIJ6zUakeT2hty2gvDlCZqZym9KsNegXQEYAQcD94/CU/CSFiwwuA9BOrYeSgaAId6RZIV/JiwrFiRZFWutwMfJYlUF+GyDwTQi5MZ79AHiSX8+OD7zA2A9GC1RsTdnBtCcZIz7ivUf2pMv8qbio+TyfKGMHBhel5tfuy8wZJgB+g+bgOCBWdsCK0582c7nxYlOvWBPp+0EeIFVwbAYmj+FxySy0cIU4hTtjmiWL6PmEB02vLCPgNjIuAspftm8J61Pk3g0I13iHpmGxhGZmcw8J4z60pnoIwN5XVlrgfv4RKpptWJDVF3GeYbyymuOA7uYNYjVN40q6zciIoAvVB48goX6w4ina5vY725pWdyVH5v/z74FCh7N24bT6k8fjzN1g8LGhfPbv7gdEOwQBAzHbpzojvvyXaI5tf8VIePYLw8QqTHCvr9sufFqylT8bmSZm4xfyHEcsN4z9UukZSSnAITu9N73mymLeEwwbv3dUZyilN6yRq43F1PA5lyqeFNZd4gAvmO9ekJmzRdszVrjHBL4NjP1sddJSuH/SyiSWoUlYiZXXZg1njZxpi6dvrYKm5DqTp3uNCD0YHQRsFZK2Cr3VZkpTwaKFXeGKWhZnv1KhzThOQkv6IAQZrWumdeTi+EihljgsZs91s7E8zNaWH8Zw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(54906003)(82310400003)(6486002)(316002)(6512007)(8676002)(70586007)(70206006)(356005)(6862004)(33656002)(4326008)(47076005)(8936002)(26005)(81166007)(2906002)(86362001)(5660300002)(508600001)(83380400001)(36756003)(36860700001)(6506007)(53546011)(336012)(2616005)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 11:15:18.5172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40752450-9e58-4c46-e467-08d98ca8687f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT044.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3791
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gT24gOCBPY3QgMjAyMSwgYXQgMTg6MDQsIE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVs
Lm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIE9jdCAwOCwgMjAyMSBhdCAwNDo0NTo0NFBNICsw
MDAwLCBBbGFuIEhheXdhcmQgd3JvdGU6DQo+Pj4gT24gOCBPY3QgMjAyMSwgYXQgMTY6MjgsIE1h
cmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4gT24gRnJpLCBPY3QgMDgs
IDIwMjEgYXQgMDI6MTE6NDZQTSArMDAwMCwgQWxhbiBIYXl3YXJkIHdyb3RlOg0KPiANCj4+Pj4g
Q2FuIE5UX0FSTV9TU1ZFIHJldHVybiBhIGZwc2ltZD8NCj4gDQo+Pj4gSXQncyBkb2N1bWVudGVk
IHRoYXQgd2F5IGZvciBzaW1wbGljaXR5IGJ1dCBpbiB0aGUgY3VycmVudA0KPj4+IGltcGxlbWVu
dGF0aW9uIGl0IHdvbid0IGV2ZXIgYWN0dWFsbHkgZG8gc28gaW4gcHJhY3RpY2UuICBUaGUNCj4+
PiBvbmx5IGNhc2Ugd2hlcmUgSSBjb3VsZCBzZWUgdGhhdCBpdCBtaWdodCBoYXBwZW4gd291bGQg
YmUgaWYgd2UNCj4+PiBjaGFuZ2UgdGhlIHN5c2NhbGxzIHRvIHN0YXkgaW4gc3RyZWFtaW5nIG1v
ZGUgb3ZlciBzeXNjYWxsLCBpbg0KPj4+IHRoYXQgY2FzZSB3ZSBjb3VsZCBkbyBhcyB3ZSBkbyBm
b3IgU1ZFIGFuZCBwcmVzZXJ2ZSBGUFNJTUQNCj4+PiByZWdpc3RlcnMgb25seS4gIEF0IHByZXNl
bnQgd2UgZHJvcCBvdXQgb2Ygc3RyZWFtaW5nIG1vZGUgaWYgd2UNCj4+PiBnZXQgYSBzeXNjYWxs
IHdpdGggaXQgZW5hYmxlZCBzbyBpdCdzIGEgbm9uLWlzc3VlLCBpZiBwZW9wbGUNCj4+PiBhZ3Jl
ZSB0aGF0IHRoYXQncyB0aGUgcmlnaHQgdGhpbmcgZm9yIHRoZSBzeXNjYWxscyB0aGVuIHdlIHNo
b3VsZA0KPj4+IHVwZGF0ZSB0aGUgZG9jdW1lbnRhdGlvbiB0byBzcGVjaWZ5IHRoaXMgc2luY2Ug
b3RoZXJ3aXNlIHdlJ2xsDQo+Pj4gZG91YnRsZXNzIGNhdGNoIHNvbWVvbmUgYnkgc3VycHJpc2Ug
aWYgd2UgZXZlciBtYW5hZ2UgdG8gc3RhcnQNCj4+PiBkb2luZyBpdCBpbiB0aGUgZnV0dXJlLg0K
PiANCj4+IOKApi5vciBpdOKAmWxsIGVuZCB1cCBleGVjdXRpbmcgc29tZSBjb2RlIHRoYXQgd2Fz
IHdyaXR0ZW4gdG8gY29wZSB3aXRoIGZwc2ltZCwgYnV0IGhhcyBuZXZlciBiZWVuDQo+PiBydW4u
IE1pZ2h0IGJlIHdvcnRoIG1ha2luZyBpdCBleHBsaWNpdCBpbiB0aGUgZG9jdW1lbnRhdGlvbi4N
Cj4gDQo+IEkgd2lsbCBpZi93aGVuIGl0IGdldHMgZml4ZWQgdGhhdCB3YXkuICBBY3R1YWxseSwg
d2hpbGUgbG9va2luZw0KPiBhdCB0aGF0IGNvZGUgSSB3YXMgdGVtcHRlZCB0byByZW1vdmUgdGhl
IHN1cHBvcnQgZm9yIHJldHVybmluZw0KPiBGUFNJTUQgb25seSByZWdpc3RlcnMgdmlhIE5UX0FS
TV9TVkUgZW50aXJlbHkgYW5kIGp1c3QgYWx3YXlzDQo+IGNvbnZlcnQgdG8gU1ZFIGZvcm1hdCAt
IEknbSBub3Qgc3VyZSB3aGF0IHRoZSB1c2UgY2FzZSB3YXMgdGhlcmU/DQo+IEl0J3Mgbm90IGEg
cHJlc3NpbmcgdGhpbmcgYnV0IGl0IHNlZW1lZCBsaWtlIGl0IHdhcyBhIGJpdCBvZiBhbg0KPiBp
bXBsZW1lbnRhdGlvbiBkZXRhaWwgdGhhdCB3ZSB3ZXJlIHJldmVhbGluZy4NCg0KDQpXaGF0IGFi
b3V0IGluIHRoZSB3cml0ZSByZWdpc3RlcnMgY2FzZT8NCg0KV2l0aCB0aGUgZXhpc3RpbmcgY29k
ZToNClJlYWQgU1ZFIHJlZ2lzdGVycyB3aXRoIHB0cmFjZS4gR2V0IEZQU0lNRC4gVXBkYXRlIEZQ
U0lNRCB3aXRoIG5ldyB2YWx1ZXMuIFdyaXRlIGJhY2sgdG8gcHRyYWNlLg0KSW4gdGhhdCBzY2Vu
YXJpbywgdGhlIGludGVybmFsIFNWRSBzdGF0ZXMgc3RheXMg4oCcaW5hY3RpdmXigJ0gaW4gdGhl
IGtlcm5lbC4NCg0KSWYgcHRyYWNlIGFsd2F5cyByZXR1cm5lZCBhbiBTVkUgc3RydWN0dXJlLCB0
aGVuIHdyaXRpbmcgYmFjayB3aXRoIHRoZSBzYW1lIHN0cnVjdHVyZSB3b3VsZCBjYXVzZSB0aGUN
ClNWRSBzdGF0ZSB0byBiZWNvbWUgYWN0aXZlLiBJdOKAmXMgYSBzbWFsbCBkaWZmZXJlbmNlLCBi
dXQgd2UgcmVhbGx5IGRvbuKAmXQgd2FudCB0aGUgZGVidWdnZXIgdG8gZWZmZWN0IHRoaW5ncy4N
Cg0KWW91IGNvdWxkIHNvbHZlIHRoYXQgYnkgYWRkaW5nIGFuIFNWRV9TVEFURV9JTkFDVElWRSB0
byB0aGUgaGVhZGVyIGZsYWdzLiBCdXQsIGVpdGhlciB3YXksIHRoZQ0KZGVidWdnZXIgd291bGQg
dGhlbiBuZWVkIHRvIHN1cHBvcnQgdGhlIGV4aXN0aW5nIG1ldGhvZCBhbmQgdGhlIG5ldyBtZXRo
b2QgKGJlY2F1c2UgdGhlIGRlYnVnZ2VyDQpoYXMgbm8gY29udHJvbCBvbiB3aGF0IE9TIHZlcnNp
b24gaXTigJlzIHJ1bm5pbmcgb24pLg0KDQpJ4oCZZCByZWNvbW1lbmQgbGVhdmluZyBhcyBpcy4N
Cg0KDQpBbGFuLg0KDQo=
