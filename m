Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 069F5DBB52
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 03:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441794AbfJRBay (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 21:30:54 -0400
Received: from mail-eopbgr790119.outbound.protection.outlook.com ([40.107.79.119]:28509
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2441774AbfJRBay (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 21:30:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5XAKdk6hoLh/PXigpny69iHC9wghzvYKAdSl5vcwZbLk7e7UTxX3Hor2tZjJiKIzifeJJYpMKwJSwt71feTzH7VZTH7nn/KZHWllnzLHbaiSseDbNfM3TuIvBQQuvJOIauxLV7Jh4LvfNe7Bz3Pd1DxghkJl9CKarRDYL96cwq+tdW1a8aLL//NBjnYlAcEs1awRK8iuZIR3ePA3evu5264H19bIszamtdAMM/lhLjUz9tXjOJm9+yZu3grLgP1e6qwcOsKhcHm6gvlTm08ycPHUZX//2zKO26IkCnlYI40dQbK6tNqrfzluh2rVRWqgGO/thoOmje6ygARPq+Igg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8lIP36J+1WlLK6oBc5sdcBA17bMEVdECN/ilwyEFoE=;
 b=FimY1hIgGJxJDtmO9sKIBbzMsr6uN5HynGPFcPMHY7CrL8H2yPighv2XhahasTK15j2F6+RkHtWp29Bgpx2Kq6g4m1NCPuJv3noKQYxe1UwuDYn0zxL7HcQu9hfmdfDEOOHwI1gQwvooaRMz7zjP3kXnue3vhhOZnk48OWrrzW66PF2L+R9y/cw5HFgvP3QwQo1Uw1P3Hq8G5wnCuTOQM9+/KoWfK4S4RZrD/Ur+IRTMBcpTe0TSXcDcDahAVut8WSypir6HHWzZ54mXTs2pGkZZHq2RtsuXiklgqws+dKjEgqHb+Nlwv/BvdO00qIA2rUWIc1qKHq5+gHXkvz710g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 160.33.194.228) smtp.rcpttodomain=google.com smtp.mailfrom=sony.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8lIP36J+1WlLK6oBc5sdcBA17bMEVdECN/ilwyEFoE=;
 b=G1O3I4Jxxe5F2ON4rzFoE71mIcTEabPLquhcAEg3dqZwrVZKPOg/Cb0HEfhvbbY8Y2ECTXPkXmSJeZkZOMyXkbCsRUBD4yWSbLosMXLk5AW3DoosxgJlAvDIev8n9QmWoTu5KlyP3mAQKQJzIMrgSjItuHCOCJgA7N+wWRBzhi8=
Received: from BN4PR13CA0016.namprd13.prod.outlook.com (2603:10b6:403:3::26)
 by BY5PR13MB3078.namprd13.prod.outlook.com (2603:10b6:a03:192::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.14; Fri, 18 Oct
 2019 01:30:50 +0000
Received: from CY1NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by BN4PR13CA0016.outlook.office365.com
 (2603:10b6:403:3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.6 via Frontend
 Transport; Fri, 18 Oct 2019 01:30:49 +0000
Authentication-Results: spf=pass (sender IP is 160.33.194.228)
 smtp.mailfrom=sony.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 160.33.194.228 as permitted sender) receiver=protection.outlook.com;
 client-ip=160.33.194.228; helo=usculsndmail01v.am.sony.com;
Received: from usculsndmail01v.am.sony.com (160.33.194.228) by
 CY1NAM02FT012.mail.protection.outlook.com (10.152.75.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.14 via Frontend Transport; Fri, 18 Oct 2019 01:30:47 +0000
Received: from usculsndmail13v.am.sony.com (usculsndmail13v.am.sony.com [146.215.230.104])
        by usculsndmail01v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x9I1Ukgj028216;
        Fri, 18 Oct 2019 01:30:46 GMT
Received: from USCULXHUB05V.am.sony.com (hub.bc.in.sel.sony.com [146.215.231.43])
        by usculsndmail13v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x9I1UkwS003629;
        Fri, 18 Oct 2019 01:30:46 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB05V.am.sony.com ([146.215.231.43]) with mapi id 14.03.0439.000; Thu,
 17 Oct 2019 21:30:45 -0400
From:   <Tim.Bird@sony.com>
To:     <brendanhiggins@google.com>
CC:     <tytso@mit.edu>, <skhan@linuxfoundation.org>, <yzaikin@google.com>,
        <linux-kselftest@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <adilger.kernel@dilger.ca>, <kunit-dev@googlegroups.com>
Subject: RE: [PATCH linux-kselftest/test v2] ext4: add kunit test for
 decoding extended timestamps
Thread-Topic: [PATCH linux-kselftest/test v2] ext4: add kunit test for
 decoding extended timestamps
Thread-Index: AQHVfxQJt5KYyUfdIUCqjuPcGwlYBqdUYHYAgABUYYCAAMbxgIAANgMAgAhyYYCAABMAgIAA1OuAgABbSgCAAH+9gP//wEwA
Date:   Fri, 18 Oct 2019 01:30:42 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF977D01A2@USCULXMSG01.am.sony.com>
References: <20191010023931.230475-1-yzaikin@google.com>
 <2f2ea7b0-f683-1cdd-f3f2-ecdf44cb4a97@linuxfoundation.org>
 <CAAXuY3qtSHENgy3S168_03ju_JwAucOAt5WEJGQ+pi5PfurP6g@mail.gmail.com>
 <CAFd5g46RcFV0FACuoF=jCSLzf7UFmEYn4gddaijUZ+zR_CFZBQ@mail.gmail.com>
 <20191011131902.GC16225@mit.edu>
 <CAFd5g45s1-=Z4JwJn4A1VDGu4oEGBisQ_0RFp4otUU3rKf1XpQ@mail.gmail.com>
 <1e6611e6-2fa6-6f7d-bc7f-0bc2243d9342@linuxfoundation.org>
 <20191017120833.GA25548@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF977D0023@USCULXMSG01.am.sony.com>
 <CAFd5g44txp2j9May1YD9rq6bcNnCx_JKNNmnsrr+JG+cTX0chg@mail.gmail.com>
In-Reply-To: <CAFd5g44txp2j9May1YD9rq6bcNnCx_JKNNmnsrr+JG+cTX0chg@mail.gmail.com>
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
X-Forefront-Antispam-Report: CIP:160.33.194.228;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(136003)(376002)(396003)(39860400002)(346002)(51914003)(13464003)(189003)(199004)(102836004)(6306002)(336012)(11346002)(4326008)(305945005)(486006)(246002)(426003)(436003)(37786003)(3846002)(6116002)(2906002)(50466002)(476003)(55016002)(53546011)(26005)(186003)(6916009)(76176011)(126002)(6246003)(2876002)(446003)(7736002)(6666004)(23676004)(70206006)(7696005)(478600001)(70586007)(106002)(2486003)(66066001)(316002)(8676002)(33656002)(2351001)(966005)(54906003)(229853002)(5660300002)(55846006)(356004)(47776003)(86362001)(8936002)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR13MB3078;H:usculsndmail01v.am.sony.com;FPR:;SPF:Pass;LANG:en;PTR:mail01.sonyusa.com,mail.sonyusa.com;MX:3;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2272938b-a956-477e-9ef8-08d7536acdb0
X-MS-TrafficTypeDiagnostic: BY5PR13MB3078:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <BY5PR13MB3078AE84B6EEC6C625AFB993FD6C0@BY5PR13MB3078.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 01949FE337
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IAEFUBzS5uq6aGZWqLvDkXalBJnCrKa/nQDI9+VnWrkDJoPBohiOQ5tyxwgU0srRMkGAjbcKYyw3VuhQ7/EL9mH05DbTXwLY4LMskoAf/1cjTrBiWf2FTflpIugsi256nSPXjQGSnqklohXLU7vaf9kLQIllUA+BXZ3JjSVhilStzoU/Z12pOmjK5uJhGDrHS6X2pAMVVdYDtnrCbAAiShljeA6hlsg8H7FHqps8xehZaCkFdQ0OsDQ17i8ZSapJYRIa16u63I1kKBQQ+QzcX3Yg544PzgbChLM5G2GYXLYlwVrO9LCVZnARqKyUlICwMlFwsjJXWFbtc7hWVNSxRw2sPNOaSja9ht+nmVEBEZsSy4lj6Ij535LQ9+zdrrMySVeKv+IMx2336zwTCELOS7EKux3r/QWt6t/B8o3kvrdQqOaZ0l9qUGHeb/YvKbkBYO1sZTOuRLqhHZhteB4d+w==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2019 01:30:47.7756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2272938b-a956-477e-9ef8-08d7536acdb0
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.228];Helo=[usculsndmail01v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3078
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQnJlbmRhbiBIaWdnaW5z
IA0KPiANCj4gT24gVGh1LCBPY3QgMTcsIDIwMTkgYXQgMzoyNSBQTSA8VGltLkJpcmRAc29ueS5j
b20+IHdyb3RlOg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4g
RnJvbTogVGhlb2RvcmUgWS4gVHMnbyBvbiBPY3RvYmVyIDE3LCAyMDE5IDI6MDkgQU0NCj4gPiA+
DQo+ID4gPiBPbiBXZWQsIE9jdCAxNiwgMjAxOSBhdCAwNToyNjoyOVBNIC0wNjAwLCBTaHVhaCBL
aGFuIHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBJIGRvbid0IHJlYWxseSBidXkgdGhlIGFyZ3Vt
ZW50IHRoYXQgdW5pdCB0ZXN0cyBzaG91bGQgYmUgZGV0ZXJtaW5pc3RpYw0KPiA+ID4gPiBQb3Nz
aWJseSwgYnV0IEkgd291bGQgb3B0IGZvciBoYXZpbmcgdGhlIGFiaWxpdHkgdG8gZmVlZCB0ZXN0
IGRhdGEuDQo+ID4gPg0KPiA+ID4gSSBzdHJvbmdseSBiZWxpZXZlIHRoYXQgdW5pdCB0ZXN0cyBz
aG91bGQgYmUgZGV0ZXJtaW5pc3RpYy4NCj4gPiA+IE5vbi1kZXRlcm1pbmlzdGljIHRlc3RzIGFy
ZSBlc3NlbnRpYWxseSBmdXp6IHRlc3RzLiAgQW5kIGZ1enogdGVzdHMNCj4gPiA+IHNob3VsZCBi
ZSBkaWZmZXJlbnQgZnJvbSB1bml0IHRlc3RzLg0KPiA+DQo+ID4gSSdtIG5vdCBzdXJlIEkgaGF2
ZSB0aGUgZW50aXJlIGNvbnRleHQgaGVyZSwgYnV0IEkgdGhpbmsgZGV0ZXJtaW5pc3RpYw0KPiA+
IG1pZ2h0IG5vdCBiZSB0aGUgcmlnaHQgd29yZCwgb3IgaXQgbWlnaHQgbm90IGNhcHR1cmUgdGhl
IGV4YWN0IG1lYW5pbmcNCj4gPiBpbnRlbmRlZC4NCj4gPg0KPiA+IEkgdGhpbmsgdGhlcmUgYXJl
IG11bHRpcGxlIGlzc3VlcyBoZXJlOg0KPiA+ICAxLiBEb2VzIHRoZSB0ZXN0IGVuY2xvc2UgYWxs
IGl0cyBkYXRhLCBpbmNsdWRpbmcgd29ya2luZyBkYXRhIGFuZCBleHBlY3RlZA0KPiByZXN1bHRz
Pw0KPiA+IE9yLCBkb2VzIHRoZSB0ZXN0IGFsbG93IHNvbWVvbmUgdG8gcHJvdmlkZSB3b3JraW5n
IGRhdGE/ICBUaGlzIGFsdGVybmF0aXZlDQo+ID4gaW1wbGllcyB0aGF0IGVpdGhlciB0aGUgc29t
ZSBvZiB0ZXN0Y2FzZXMgb3IgdGhlIHJlc3VsdHMgbWlnaHQgYmUgZGlmZmVyZW50DQo+IGRlcGVu
ZGluZyBvbg0KPiA+IHRoZSBkYXRhIHRoYXQgaXMgcHJvdmlkZWQuICBJTUhPIHRoZSB0ZXN0IHdv
dWxkIGJlIGRldGVybWluaXN0aWMgaWYgaXQgYWx3YXlzDQo+IHByb2R1Y2VkDQo+ID4gdGhlIHNh
bWUgcmVzdWx0cyBiYXNlZCBvbiB0aGUgc2FtZSBkYXRhIGlucHV0cy4gIEFuZCBpZiB0aGUgaW5w
dXQgZGF0YSB3YXMNCj4gZGV0ZXJtaW5pc3RpYy4NCj4gPiBJIHdvdWxkIGNhbGwgdGhpcyBhIGRh
dGEtZHJpdmVuIHRlc3QuDQo+ID4NCj4gPiBTaW5jZSB0aGUgcmVzdWx0cyB3b3VsZCBiZSBkZXBl
bmRlbnQgb24gdGhlIGRhdGEgcHJvdmlkZWQsIHRoZSByZXN1bHRzDQo+ID4gZnJvbSB0ZXN0cyB1
c2luZyBkaWZmZXJlbnQgZGF0YSB3b3VsZCBub3QgYmUgY29tcGFyYWJsZS4gIEVzc2VudGlhbGx5
LA0KPiA+IGNoYW5naW5nIHRoZSBpbnB1dCBkYXRhIGNoYW5nZXMgdGhlIHRlc3Qgc28gbWF5YmUg
aXQncyBiZXN0IHRvIGNvbnNpZGVyDQo+ID4gdGhpcyBhIGRpZmZlcmVudCB0ZXN0LiAgTGlrZSAn
dGVzdC13aXRoLWRhdGEtQScgYW5kICd0ZXN0LXdpdGgtZGF0YS1CJy4NCj4gDQo+IFRoYXQga2lu
ZCBvZiBzb3VuZCBsaWtlIHBhcmFtZXRlcml6ZWQgdGVzdHNbMV07IA0KDQouLi4NCg0KPiANCj4g
WzFdIGh0dHBzOi8vZHpvbmUuY29tL2FydGljbGVzL2p1bml0LXBhcmFtZXRlcml6ZWQtdGVzdA0K
DQpCb3RoIEl1cmlpIGFuZCB5b3UgcG9pbnRlZCBtZSBhdCBwYXJhbWV0ZXJpemVkIHRlc3RzLiAg
VGhpcyBzb3VuZHMgbGlrZQ0Kd2hhdCBJIGFtIHRhbGtpbmcgYWJvdXQuICBXZSBoYXZlIGEgbG90
IG9mIGluZnJhc3RydWN0dXJlIGZvciB0aGVzZSBjb25jZXB0cyBpbiBGdWVnbywNCmJ1dCBpdCdz
IGNhbGxlZCBzb21ldGhpbmcgZGlmZmVyZW50Lg0KDQpJJ20gbm90IHN1cmUgaWYgSSBzaG91bGQg
ZmVlbCBzbWFydCBmb3IgaGF2aW5nIGRldmVsb3BlZCBzb21lIG9mIHRoZXNlIGNvbmNlcHRzDQpp
bmRlcGVuZGVudGx5IG9yIGR1bWIgZm9yIG5vdCBoYXZpbmcga25vd24gYWJvdXQgdGhpcyAoYXBw
YXJlbnRseSkgc3RhbmRhcmQNCm5vbWVuY2xhdHVyZS4gOy0pDQoNClRoYW5rcyBmb3IgdGhlIHJl
ZmVyZW5jZSENCiAtLSBUaW0NCg0K
