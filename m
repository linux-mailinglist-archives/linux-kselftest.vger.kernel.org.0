Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1699ADBA55
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 01:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438461AbfJQXyo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 19:54:44 -0400
Received: from mail-eopbgr760128.outbound.protection.outlook.com ([40.107.76.128]:58951
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729190AbfJQXyo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 19:54:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6cnxaR1OUBVv65J3YbG/1naO0LLq7stpfgaLsQiQFcad4dAATFw9VEPPVLdheSOdeEhFqlkse7tHJjWbVsAyVHcwUrqa+U22UAwdOTcR5/F0cdXh5PAU+qnp00sNmRHAKM16G5oqAApkGKYkiHglUwGbDLjZ4MVHJ+Q3B+Ipqq+3mBLFbhfz7rNKiHnXEEbVaSiFu9jp2ZAP7x07t7wEnLszK240YtZ1Jz9yFfMwsKBV+TikjLOeKgmDRuWzidgdFM98qi/L3HDq7Ti/39qVFGs5hWrJ3XCCyNyi7yRcLVQVbfCxBFBg7R9zb4m1jvvyvSVzVqGbkD6LFqUrxhAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yioWki2+mIeh4kggCvK6xd3tek8S2vibyMy/ZfItdH0=;
 b=k3JarCk5N0M0yKHF/8/bLHh7ghTYgJ4YEDV3a2+mGS6xgiikMPZQfNsnZwEma6mQDTxF1nj+0diR8eYrkCp043sZ3d7utoygeU32ySj+ho1HeIP/MXzzw05jlGSbQiyYvRtX8S+jIa2HKukKVyo+Y5yGmLyADfSHJuvtvYeibHEzkKT+mbSndCic0hd3U5g5IbGGQkUKe1IyMl0QGydDK6ldPcglFLd57H/GkJKorgXqqSn/cUuGKgWU6PF+jjMMaY8irSypM3hCjUbgLJ/JV/4+9o61vMqhnJaxgEidAnigQVE1W7G3buqn92NYDZMuRz/zD1pde8jNtAvYks0YPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 160.33.194.230) smtp.rcpttodomain=google.com smtp.mailfrom=sony.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yioWki2+mIeh4kggCvK6xd3tek8S2vibyMy/ZfItdH0=;
 b=f8DPgh0i2f8WAvr2lsB86Xgur2mNkvwtcDO+BIKaAV/fPqc2eG88inpVUbo/Ft0YUbHum5u0QAc+nu79PEXVG/FGure7il1DOWVyraqENdiZf0c5a/xB21Ga9X/ZE85XSqgSDc3Xt8fz4rm7Fwc2Wl7Cfp+XNREZHZ0O08GXY2c=
Received: from MWHPR13CA0005.namprd13.prod.outlook.com (2603:10b6:300:16::15)
 by BY5PR13MB3285.namprd13.prod.outlook.com (2603:10b6:a03:190::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.16; Thu, 17 Oct
 2019 23:54:33 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by MWHPR13CA0005.outlook.office365.com
 (2603:10b6:300:16::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.6 via Frontend
 Transport; Thu, 17 Oct 2019 23:54:33 +0000
Authentication-Results: spf=pass (sender IP is 160.33.194.230)
 smtp.mailfrom=sony.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 160.33.194.230 as permitted sender) receiver=protection.outlook.com;
 client-ip=160.33.194.230; helo=usculsndmail03v.am.sony.com;
Received: from usculsndmail03v.am.sony.com (160.33.194.230) by
 SN1NAM02FT057.mail.protection.outlook.com (10.152.73.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.14 via Frontend Transport; Thu, 17 Oct 2019 23:54:33 +0000
Received: from usculsndmail14v.am.sony.com (usculsndmail14v.am.sony.com [146.215.230.105])
        by usculsndmail03v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x9HNsW5t019295;
        Thu, 17 Oct 2019 23:54:32 GMT
Received: from USCULXHUB08V.am.sony.com (hub.bc.in.sel.sony.com [146.215.231.169])
        by usculsndmail14v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x9HNsVxP015408;
        Thu, 17 Oct 2019 23:54:31 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB08V.am.sony.com ([146.215.231.169]) with mapi id 14.03.0439.000;
 Thu, 17 Oct 2019 19:54:31 -0400
From:   <Tim.Bird@sony.com>
To:     <yzaikin@google.com>, <skhan@linuxfoundation.org>
CC:     <tytso@mit.edu>, <brendanhiggins@google.com>,
        <linux-kselftest@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <adilger.kernel@dilger.ca>, <kunit-dev@googlegroups.com>
Subject: RE: [PATCH linux-kselftest/test v2] ext4: add kunit test for
 decoding extended timestamps
Thread-Topic: [PATCH linux-kselftest/test v2] ext4: add kunit test for
 decoding extended timestamps
Thread-Index: AQHVfxQJt5KYyUfdIUCqjuPcGwlYBqdUYHYAgABUYYCAAMbxgIAANgMAgAhyYYCAABMAgIAA1OuAgACzMICAAATzAIAAAWUAgAAEDID//8H28A==
Date:   Thu, 17 Oct 2019 23:54:28 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF977D00C3@USCULXMSG01.am.sony.com>
References: <20191010023931.230475-1-yzaikin@google.com>
 <2f2ea7b0-f683-1cdd-f3f2-ecdf44cb4a97@linuxfoundation.org>
 <CAAXuY3qtSHENgy3S168_03ju_JwAucOAt5WEJGQ+pi5PfurP6g@mail.gmail.com>
 <CAFd5g46RcFV0FACuoF=jCSLzf7UFmEYn4gddaijUZ+zR_CFZBQ@mail.gmail.com>
 <20191011131902.GC16225@mit.edu>
 <CAFd5g45s1-=Z4JwJn4A1VDGu4oEGBisQ_0RFp4otUU3rKf1XpQ@mail.gmail.com>
 <1e6611e6-2fa6-6f7d-bc7f-0bc2243d9342@linuxfoundation.org>
 <20191017120833.GA25548@mit.edu>
 <957434b6-32cc-487f-f48e-f9c4416b3f60@linuxfoundation.org>
 <CAAXuY3r7Eu+o-td8MRvexGYmONPgd8FvHr+7mF84Q4ni1G3URg@mail.gmail.com>
 <40073fc9-1de1-9253-e2f9-9cf9ee4308d4@linuxfoundation.org>
 <CAAXuY3r7QKSuwVYDQhF8-zC75ZRVHr+4pzpGXeNbPaEdbM3h4Q@mail.gmail.com>
In-Reply-To: <CAAXuY3r7QKSuwVYDQhF8-zC75ZRVHr+4pzpGXeNbPaEdbM3h4Q@mail.gmail.com>
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
X-Forefront-Antispam-Report: CIP:160.33.194.230;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(346002)(136003)(189003)(199004)(13464003)(37786003)(2876002)(316002)(486006)(70586007)(6666004)(54906003)(106002)(305945005)(446003)(4326008)(70206006)(110136005)(126002)(356004)(2906002)(436003)(6246003)(426003)(50466002)(336012)(7736002)(3846002)(6116002)(4744005)(102836004)(55846006)(186003)(23676004)(2486003)(478600001)(86362001)(47776003)(7696005)(26005)(5660300002)(33656002)(55016002)(11346002)(476003)(246002)(66066001)(8936002)(8676002)(76176011)(229853002)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR13MB3285;H:usculsndmail03v.am.sony.com;FPR:;SPF:Pass;LANG:en;PTR:mail.sonyusa.com,mail03.sonyusa.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf139295-f983-46ae-da6b-08d7535d5bd8
X-MS-TrafficTypeDiagnostic: BY5PR13MB3285:
X-Microsoft-Antispam-PRVS: <BY5PR13MB3285B4A1F0BBA2FFE9CBAC3DFD6D0@BY5PR13MB3285.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 01930B2BA8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3yf1STJ0DUKHrCyanPl4og5Vs9MEIssYJVIY/kXTpZ/Wavmeyt5v+XKCURu3C8j6Jn/Vu5aUj5v2yvu0jULelUARBDSIBSYx9lKSmVAupht0BXQn2g78xy/h4u7os1xFV+nKq2XSMU5aXZ2xpxfYEYoiMbZAgl+KZ/NkaM2wjdhm+ZvuISrTVMmTwOr1FnQi6oFnLmJFV7DpU/1hSFWmYRzd3wrIYdVdk/1/G3ise68u4aFNzlw2ZffGzR3u6w1ckr+zJtXnWCKJhyAHo3GuPNZ6q6RUzm2hSwBdyd5YobOZzunYSoPegG1q31+c6a33lmozLS0XF+Zm+zu+GJp3RGAL55k/ijtKcnqv5Lti9IewXGI2CHS+t767RHCn/5pcvo7O6wyqLEKjwuwunNc3G656JNSf2ErWfQ5E3C+R5rw=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2019 23:54:33.2835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf139295-f983-46ae-da6b-08d7535d5bd8
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.230];Helo=[usculsndmail03v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3285
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSXVyaWkgWmFpa2luDQo+
IA0KPiA+IFlvdSBjYW4gZG8gYWxsIG9mIHRoaXMgYW5kIGFsbG93IHVzZXJzIHRvIHN1cHBseSBh
bm90aGVyIHNldCBvZiBkYXRhLg0KPiA+IEl0IGRvZXNuJ3QgZ2F2ZSB0byBiZSBvbmUgb3IgdGhl
IG90aGVyLg0KPiA+DQo+IFdoYXQgaXMgdGhlIHVzZSBjYXNlIGZvciBydW5uaW5nIGEgdW5pdCB0
ZXN0IG9uIGEgZGlmZmVyZW50IGRhdGEgc2V0IHRoYW4NCj4gd2hhdCBpdCBjb21lcyB3aXRoPw0K
DQpJIGp1c3QgZ2F2ZSBzb21lIGlkZWFzIGluIGFub3RoZXIgbWVzc2FnZSAob3VyIGVtYWlscyBj
cm9zc2VkKSwNCmJ1dCBvbmUgdXNlIGNhc2UgaXMgdG8gYWxsb3cgc29tZW9uZSBiZXNpZGVzIHRo
ZSB0ZXN0IGF1dGhvcg0KdG8gaW5qZWN0IGFkZGl0aW9uYWwgZGF0YSBwb2ludHMsIGFuZCB0byBk
byBzbyB3aXRob3V0IGhhdmluZyB0byByZS1jb21waWxlDQp0aGUgY29kZS4NCg0KVGhleSBtaWdo
dCBkbyB0aGlzIGZvciBtdWx0aXBsZSByZWFzb25zOg0KIC0gdG8gZXhwZXJpbWVudCB3aXRoIGFk
ZGl0aW9uYWwgZGF0YSBwb2ludHMNCiAtIHRvIHRyeSB0byBkaWFnbm9zZSBhIHByb2JsZW0gdGhl
eSBhcmUgc2VlaW5nDQogLSB0byBmaWxsIGdhcHMgdGhleSBzZWUgaW4gZXhpc3RpbmcgZGF0YSBw
b2ludHMNCg0KV2hldGhlciB0aGlzIG1ha2VzIHNlbnNlIGRlcGVuZHMgb24gYSBsb3Qgb2YgZmFj
dG9ycy4gIEkgc3VzcGVjdA0KdGhlIHRpbWVzdGFtcCB0ZXN0IGNvZGUgaXMgbm90IGEgZ29vZCBj
YW5kaWRhdGUgZm9yIHRoaXMsIGFzIHRoZSBjb2RlDQppcyBzaW1wbGUgZW5vdWdoIHRoYXQgYWRk
aW5nIGEgbmV3IHRlc3QgY2FzZSBpcyBwcmV0dHkgdHJpdmlhbC4gIEZvciBzb21lDQpvdGhlciB0
eXBlcyBvZiB0ZXN0cywgYWRkaW5nIHRoZSBkYXRhIHZpYSBhbiBleHRlcm5hbCBmaWxlIGNvdWxk
IGJlIGVhc2llcg0KdGhhbiBjaGFuZ2luZyB0aGUgY29kZSBvZiB0aGUgdGVzdC4NCiAtLSBUaW0N
Cg==
