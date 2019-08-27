Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4F09F646
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2019 00:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfH0WiQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Aug 2019 18:38:16 -0400
Received: from mail-eopbgr740097.outbound.protection.outlook.com ([40.107.74.97]:30464
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725989AbfH0WiQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Aug 2019 18:38:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buK9i5ktMk5ZH+Ac3194wzpXtqSV7gk8H+Qyts7fIgL2TuG5O91ZW4JbXTVuRxEzus+nmDgEgu+48xK+2Ni9bJX0a+OHfsbNv2viKZfN9eN+1fFuVz4pZ/HQD35QGhiJhPluSXI4lIHvGwHlQIM0yRuOy0UHk8/ytPt7uRreX7dWGNc1FLSVvM8x4znrc24Z5vgXILAGSdUTbVH4OGoVF0WibXEBvw14YCZnvKnpGOy7w+lDb+Suq5pfDumzSO2csFhZSoPiF4V8cjOzlOGs+cLHGkSIEv9AlHEvmKMs+SnHIslXRE8Pkd1YQQvplzTjHECwLRf8QcEYpNerbzWx6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSLlRioKOYqvn5onMgLH6bH6tkeDXuHcuxx8SrMdomU=;
 b=aRKApRrnJzDC81ffJZdg2GVbhLFPCCsv2tRHN3qiJfivi/UYmwGmGY+YCgVetqBlGyQKo//lNvcRVoga+9caaX6vImqCRNY4cG2vdsGZL5VtLyMQUjTBAPDDBuAk0todzm+idSiRXgWx2EkhBTp7TjsnKVuXvyvGS8tUn1Imjax6ElmiQ1MXBUQQqxHxf4aexn5UMC2Duz3iUOfZT5a1EYy0HAkaYK84qiLZ48scE2zfVAVYZeFRex87zmRyhREoXY7xjbACIBylNhfjhGK270DVP8C6ILkf+Xy2aGLpoy6iQqzxrCjLs4d8ZzgrMFvkXqDclUfjVBAYOqkGxoDBZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 160.33.194.230) smtp.rcpttodomain=google.com smtp.mailfrom=sony.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSLlRioKOYqvn5onMgLH6bH6tkeDXuHcuxx8SrMdomU=;
 b=IvSlQa3boyKEYZ1r1rri/p8VOSXeHmQtpRFI4M2obOx0TpgYrq7w61cautMLy3AyFwOAvzJ6YeCdfPgbvmF3AQf4CljVb5yO9oXe6p0Zf0HHw9j3gq42+OLOxeTVMv+0rGLyydc6flOOoD5YVKmuVkpouhA6lafgYetJlo6UGF4=
Received: from CY4PR13CA0090.namprd13.prod.outlook.com (2603:10b6:903:152::28)
 by CY4PR13MB1429.namprd13.prod.outlook.com (2603:10b6:903:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.12; Tue, 27 Aug
 2019 22:38:07 +0000
Received: from SN1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by CY4PR13CA0090.outlook.office365.com
 (2603:10b6:903:152::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2220.7 via Frontend
 Transport; Tue, 27 Aug 2019 22:38:07 +0000
Authentication-Results: spf=pass (sender IP is 160.33.194.230)
 smtp.mailfrom=sony.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 160.33.194.230 as permitted sender) receiver=protection.outlook.com;
 client-ip=160.33.194.230; helo=usculsndmail03v.am.sony.com;
Received: from usculsndmail03v.am.sony.com (160.33.194.230) by
 SN1NAM02FT007.mail.protection.outlook.com (10.152.72.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2199.13 via Frontend Transport; Tue, 27 Aug 2019 22:38:03 +0000
Received: from usculsndmail12v.am.sony.com (usculsndmail12v.am.sony.com [146.215.230.103])
        by usculsndmail03v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x7RMc2If013237;
        Tue, 27 Aug 2019 22:38:02 GMT
Received: from USCULXHUB03V.am.sony.com (hub.cul.am.sony.com [146.215.231.17])
        by usculsndmail12v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x7RMc1o7002448;
        Tue, 27 Aug 2019 22:38:01 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB03V.am.sony.com ([146.215.231.17]) with mapi id 14.03.0439.000; Tue,
 27 Aug 2019 18:38:01 -0400
From:   <Tim.Bird@sony.com>
To:     <brendanhiggins@google.com>, <shuah@kernel.org>
CC:     <kunit-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <frowand.list@gmail.com>,
        <sboyd@kernel.org>, <rdunlap@infradead.org>, <sfr@canb.auug.org.au>
Subject: RE: [PATCH v1] kunit: fix failure to build without printk
Thread-Topic: [PATCH v1] kunit: fix failure to build without printk
Thread-Index: AQHVXP/W3H7cZS389EyVdEZJUUfHZ6cPsx6AgAALroCAAAHPgIAAB4SAgAAGu4CAAAR6AP//v4TA
Date:   Tue, 27 Aug 2019 22:37:49 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF977A5D82@USCULXMSG01.am.sony.com>
References: <20190827174932.44177-1-brendanhiggins@google.com>
 <ae9b9102-187c-eefe-d377-6efa63de2d28@kernel.org>
 <CAFd5g473nZAfM4D=Vkr54O_+nn=MSt3dzuDcXzNMZGRDWg1nxA@mail.gmail.com>
 <CAFd5g47rSBJS8QVH6d5HqoJW5PJXdNnkoP6WcvQCFUqHUEmDzw@mail.gmail.com>
 <CAFd5g44A5vtgxBYErP4mCGwDgOHEMYUXCDSF=d9bYB3ktpW5jA@mail.gmail.com>
 <10b44374-829d-0daa-8fb0-4450582cb40c@kernel.org>
 <CAFd5g474EYEj1BmqCv=xe6M9JW4L389xL2SU1Ak-evjmpGOvJg@mail.gmail.com>
In-Reply-To: <CAFd5g474EYEj1BmqCv=xe6M9JW4L389xL2SU1Ak-evjmpGOvJg@mail.gmail.com>
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
X-Forefront-Antispam-Report: CIP:160.33.194.230;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(346002)(136003)(39860400002)(376002)(396003)(2980300002)(13464003)(199004)(189003)(8676002)(55846006)(336012)(76176011)(305945005)(14444005)(23676004)(2486003)(6246003)(26005)(47776003)(966005)(86362001)(106002)(229853002)(356004)(53546011)(6306002)(246002)(66066001)(55016002)(6666004)(2906002)(2876002)(70586007)(316002)(5660300002)(37786003)(186003)(7696005)(478600001)(33656002)(126002)(11346002)(70206006)(476003)(4326008)(8936002)(446003)(110136005)(50466002)(3846002)(6116002)(7736002)(54906003)(426003)(102836004)(436003)(486006)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR13MB1429;H:usculsndmail03v.am.sony.com;FPR:;SPF:Pass;LANG:en;PTR:mail03.sonyusa.com,mail.sonyusa.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5725a517-b161-44fb-363d-08d72b3f3b1d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);SRVR:CY4PR13MB1429;
X-MS-TrafficTypeDiagnostic: CY4PR13MB1429:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Antispam-PRVS: <CY4PR13MB1429A0834C436E1E2F8FD90DFDA00@CY4PR13MB1429.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0142F22657
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: y8riNhNb0rbks3naq4tGEp0AYhzrkJ/Jodch2RRJBGNMEZkJM2mY3Hd06hygKZqB1C9Nl/aEh7hM5H7bFb3zQPscoNzcdyHhzbGPiMMZJSIroSFMnlaedYovJUUaTaG2c+GS6H8cBVtJoRxKCV14M1weIz0Q2jzQNnNW7L+qK0gfZ4QIeOioacuSuA4DZTYRrJSW9L926+OzC2P78Rtu6Rl6FdXd5VPvEEeroITvw8mBdXCY50ETbjq/869VzxyeeMp8enP8xpuyWBXMSazYw3LHeUz2GJqpl7angvSA39nyqSgx5BEmQ++WI64UcRY3NH10tARTHpvWXlLdwf8VjjBLvFhpzOT9rWScugPCc9bT7wFtw6F3gshMLLIZpAN050OmAGYHoE5/RrMGsSvhCcyzsYRnHQDnqWed9KNyuNs=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2019 22:38:03.7262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5725a517-b161-44fb-363d-08d72b3f3b1d
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.230];Helo=[usculsndmail03v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR13MB1429
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQnJlbmRhbiBIaWdnaW5z
DQo+IA0KPiBPbiBUdWUsIEF1ZyAyNywgMjAxOSBhdCAzOjAwIFBNIHNodWFoIDxzaHVhaEBrZXJu
ZWwub3JnPiB3cm90ZToNCj4gPg0KPiA+IE9uIDgvMjcvMTkgMzozNiBQTSwgQnJlbmRhbiBIaWdn
aW5zIHdyb3RlOg0KPiA+ID4gT24gVHVlLCBBdWcgMjcsIDIwMTkgYXQgMjowOSBQTSBCcmVuZGFu
IEhpZ2dpbnMNCj4gPiA+IDxicmVuZGFuaGlnZ2luc0Bnb29nbGUuY29tPiB3cm90ZToNCj4gPiA+
Pg0KPiA+ID4+IE9uIFR1ZSwgQXVnIDI3LCAyMDE5IGF0IDI6MDMgUE0gQnJlbmRhbiBIaWdnaW5z
DQo+ID4gPj4gPGJyZW5kYW5oaWdnaW5zQGdvb2dsZS5jb20+IHdyb3RlOg0KPiA+ID4+Pg0KPiA+
ID4+PiBPbiBUdWUsIEF1ZyAyNywgMjAxOSBhdCAxOjIxIFBNIHNodWFoIDxzaHVhaEBrZXJuZWwu
b3JnPiB3cm90ZToNCj4gPiA+Pj4+DQo+ID4gPj4+PiBPbiA4LzI3LzE5IDExOjQ5IEFNLCBCcmVu
ZGFuIEhpZ2dpbnMgd3JvdGU6DQo+ID4gPj4+Pj4gUHJldmlvdXNseSBLVW5pdCBhc3N1bWVkIHRo
YXQgcHJpbnRrIHdvdWxkIGFsd2F5cyBiZSBwcmVzZW50LA0KPiB3aGljaCBpcw0KPiA+ID4+Pj4+
IG5vdCBhIHZhbGlkIGFzc3VtcHRpb24gdG8gbWFrZS4gRml4IHRoYXQgYnkgaWZkZWZpbmcgb3V0
IGZ1bmN0aW9ucw0KPiB3aGljaA0KPiA+ID4+Pj4+IGRpcmVjdGx5IGRlcGVuZCBvbiBwcmludGsg
Y29yZSBmdW5jdGlvbnMgc2ltaWxhciB0byB3aGF0IGRldl9wcmludGsNCj4gPiA+Pj4+PiBkb2Vz
Lg0KPiA+ID4+Pj4+DQo+ID4gPj4+Pj4gUmVwb3J0ZWQtYnk6IFJhbmR5IER1bmxhcCA8cmR1bmxh
cEBpbmZyYWRlYWQub3JnPg0KPiA+ID4+Pj4+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LWtzZWxmdGVzdC8wMzUyZmFlOS01NjRmLTRhOTctDQo+IDcxNWEtZmFiZTAxNjI1OWRm
QGtlcm5lbC5vcmcvVC8jdA0KPiA+ID4+Pj4+IENjOiBTdGVwaGVuIFJvdGh3ZWxsIDxzZnJAY2Fu
Yi5hdXVnLm9yZy5hdT4NCj4gPiA+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBCcmVuZGFuIEhpZ2dpbnMg
PGJyZW5kYW5oaWdnaW5zQGdvb2dsZS5jb20+DQo+ID4gPj4+Pj4gLS0tDQo+ID4gPj4+Pj4gICAg
aW5jbHVkZS9rdW5pdC90ZXN0LmggfCAgNyArKysrKysrDQo+ID4gPj4+Pj4gICAga3VuaXQvdGVz
dC5jICAgICAgICAgfCA0MSArKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LQ0KPiA+ID4+Pj4+ICAgIDIgZmlsZXMgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgMTcgZGVs
ZXRpb25zKC0pDQo+ID4gPj4+Pj4NCj4gPiA+Pj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9rdW5p
dC90ZXN0LmggYi9pbmNsdWRlL2t1bml0L3Rlc3QuaA0KPiA+ID4+Pj4+IGluZGV4IDhiN2ViMDNk
NDk3MS4uMzM5YWY1Zjk1YzRhIDEwMDY0NA0KPiA+ID4+Pj4+IC0tLSBhL2luY2x1ZGUva3VuaXQv
dGVzdC5oDQo+ID4gPj4+Pj4gKysrIGIvaW5jbHVkZS9rdW5pdC90ZXN0LmgNCj4gPiA+Pj4+PiBA
QCAtMzM5LDkgKzMzOSwxNiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgKmt1bml0X2t6YWxsb2Moc3Ry
dWN0IGt1bml0DQo+ICp0ZXN0LCBzaXplX3Qgc2l6ZSwgZ2ZwX3QgZ2ZwKQ0KPiA+ID4+PiBbLi4u
XQ0KPiA+ID4+Pj4gT2theSBhZnRlciByZXZpZXdpbmcgdGhpcywgSSBhbSBub3Qgc3VyZSB3aHkg
eW91IG5lZWQgdG8gZG8gYWxsDQo+ID4gPj4+PiB0aGlzLg0KPiA+ID4+Pj4NCj4gPiA+Pj4+IFdo
eSBjYW4ndCB5b3UganVzdCBjaGFuZ2UgdGhlIHJvb3QgZnVuY3Rpb24gdGhhdCB0aHJvd3MgdGhl
IHdhcm46DQo+ID4gPj4+Pg0KPiA+ID4+Pj4gICAgc3RhdGljIGludCBrdW5pdF92cHJpbnRrX2Vt
aXQoaW50IGxldmVsLCBjb25zdCBjaGFyICpmbXQsIHZhX2xpc3QgYXJncykNCj4gPiA+Pj4+IHsN
Cj4gPiA+Pj4+ICAgICAgICAgICByZXR1cm4gdnByaW50a19lbWl0KDAsIGxldmVsLCBOVUxMLCAw
LCBmbXQsIGFyZ3MpOw0KPiA+ID4+Pj4gfQ0KPiA+ID4+Pj4NCj4gPiA+Pj4+IFlvdSBhcmVuJ3Ig
cmVhbGx5IGRvaW5nIGFueXRoaW5nIGV4dHJhIGhlcmUsIG90aGVyIHRoYW4gY2FsbGluZw0KPiA+
ID4+Pj4gdnByaW50a19lbWl0KCkNCj4gPiA+Pj4NCj4gPiA+Pj4gWWVhaCwgSSBkaWQgdGhhdCBh
IHdoaWxlIGFnby4gSSB0aGluayBpdCB3YXMgYSBjb21iaW5hdGlvbiBvZiB0cnlpbmcNCj4gPiA+
Pj4gdG8gYXZvaWQgYW4gZXh0cmEgbGF5ZXIgb2YgYWRkaW5nIGFuZCB0aGVuIHJlbW92aW5nIHRo
ZSBsb2cgbGV2ZWwsIGFuZA0KPiA+ID4+PiB0aGF0J3Mgd2hhdCBkZXZfcHJpbnRrIGFuZCBmcmll
bmRzIGRpZC4NCj4gPiA+Pj4NCj4gPiA+Pj4gQnV0IEkgdGhpbmsgeW91IGFyZSBwcm9iYWJseSBy
aWdodC4gSXQncyBhIGxvdCBvZiBtYWludGVuYW5jZSBvdmVyaGVhZA0KPiA+ID4+PiB0byBnZXQg
cmlkIG9mIHRoYXQuIFByb2JhYmx5IGJlc3QgdG8ganVzdCB1c2Ugd2hhdCB0aGUgcHJpbnRrIHBl
b3BsZQ0KPiA+ID4+PiBoYXZlLg0KPiA+ID4+Pg0KPiA+ID4+Pj4gVW5sZXNzIEkgYW0gbWlzc2lu
ZyBzb21ldGhpbmcsIGNhbid0IHlvdSBzb2x2ZSB0aGlzIHByb2JsZW0gYnkNCj4gaW5jbHVkaW5n
DQo+ID4gPj4+PiBwcmludGsuaCBhbmQgbGV0IGl0IGhhbmRsZSB0aGUgIUNPTkZJR19QUklOVEsg
Y2FzZT8NCj4gPiA+Pj4NCj4gPiA+Pj4gUmFuZHksIEkgaG9wZSB5b3UgZG9uJ3QgbWluZCwgYnV0
IEkgYW0gZ29pbmcgdG8gYXNrIHlvdSB0byByZS1hY2sgbXkNCj4gPiA+Pj4gbmV4dCByZXZpc2lv
biBzaW5jZSBpdCBiYXNpY2FsbHkgYWRkcmVzc2VzIHRoZSBwcm9ibGVtIGluIGEgdG90YWxseQ0K
PiA+ID4+PiBkaWZmZXJlbnQgd2F5Lg0KPiA+ID4+DQo+ID4gPj4gQWN0dWFsbHksIHNjcmF0Y2gg
dGhhdC4gQ2hlY2twYXRjaCBkb2Vzbid0IGxpa2UgbWUgY2FsbGluZyBwcmludGsNCj4gPiA+PiB3
aXRob3V0IHVzaW5nIGEgS0VSTl88TEVWRUw+Lg0KPiA+ID4+DQo+ID4gPj4gTm93IHRoYXQgSSBh
bSB0aGlua2luZyBiYWNrIHRvIHdoZW4gSSB3cm90ZSB0aGlzLiBJIHRoaW5rIGl0IGFsc28NCj4g
PiA+PiBtaWdodCBub3QgbGlrZSB1c2luZyBhIGR5bmFtaWMgS0VSTl88TEVWRUw+IGVpdGhlciAo
cHJpbnRrKCIlcyBteQ0KPiA+ID4+IG1lc3NhZ2UiLCBLRVJOX0lORk8pKS4NCj4gPiA+Pg0KPiA+
ID4+IEkgYW0gZ29pbmcgdG8gaGF2ZSB0byBkbyBzb21lIG1vcmUgaW52ZXN0aWdhdGlvbi4NCj4g
PiA+DQo+ID4gPiBBbHJpZ2h0LCBJIGFtIHByZXR0eSBzdXJlIGl0IGlzIHNhZmUgdG8gZG8gcHJp
bnRrKCIlc21lc3NhZ2UiLA0KPiBLRVJOXzxMRVZFTD4pOw0KPiA+ID4NCj4gPiA+IExvb2tpbmcg
YXQgdGhlIHByaW50ayBpbXBsZW1lbnRhdGlvbiwgaXQgYXBwZWFycyB0byBkbyB0aGUgZm9ybWF0
DQo+ID4gPiBiZWZvcmUgaXQgY2hlY2tzIHRoZSBsb2cgbGV2ZWw6DQo+ID4gPg0KPiA+ID4NCj4g
aHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjUuMi4xMC9zb3VyY2Uva2VybmVsL3By
aW50ay9wcmludGsuYyNMMTkwNw0KPiA+ID4NCj4gPiA+IFNvIEkgYW0gcHJldHR5IHN1cmUgd2Ug
Y2FuIGRvIGl0IGVpdGhlciB3aXRoIHRoZSB2cHJpbnRrX2VtaXQgb3Igd2l0aA0KPiBwcmludGsu
DQo+ID4NCj4gPiBMZXQgbWUgc2VlIGlmIHdlIGFyZSBvbiB0aGUgc2FtZSBwYWdlIGZpcnN0LiBJ
IGFtIGFza2luZyBpZiB5b3UgY2FuDQo+ID4ganVzdCBpbmNsdWRlIHByaW50ay5oIGZvciB2cHJp
bnRrX2VtaXQoKSBkZWZpbmUgZm9yIGJvdGggQ09ORklHX1BSSU5USw0KPiA+IGFuZCAhQ09ORklH
X1BSSU5USyBjYXNlcy4NCj4gDQo+IEFoIHNvcnJ5LCBJIG1pc3VuZGVyc3Rvb2QgeW91Lg0KPiAN
Cj4gTm8sIHRoYXQgZG9lc24ndCB3b3JrLiBJIHRyaWVkIGluY2x1ZGluZyBsaW51eC9wcmludGsu
aCwgYW5kIEkgZ2V0IHRoZQ0KPiBzYW1lIGVycm9yLg0KPiANCj4gVGhlIHJlYXNvbiBmb3IgdGhp
cyBpcyB0aGF0IHZwcmludGtfZW1pdCgpIGlzIG9ubHkgZGVmaW5lZCB3aGVuDQo+IENPTkZJR19Q
UklOVEs9eToNCj4gDQo+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L2xhdGVzdC9p
ZGVudC92cHJpbnRrX2VtaXQNCg0KVWdoLiAgVGhhdCdzIGp1c3QgYSBidWcgaW4gaW5jbHVkZS9s
aW51eC9wcmludGsuaA0KDQpUaGVyZSBzaG91bGQgYmUgYSBzdHViIGRlZmluaXRpb24gZm9yIHZw
cmludGtfZW1pdCgpIGluIHRoZSAjZWxzZSBwYXJ0IA0Kb2YgI2lmZGVmIENPTkZJR19QUklOVEsu
DQoNCllvdSBzaG91bGRuJ3QgYmUgZGVhbGluZyB3aXRoIHdoZXRoZXIgcHJpbnRrIGlzIHByZXNl
bnQgb3Igbm90DQppbiB0aGUga3VuaXQgY29kZS4gIEFsbCB0aGUgcHJpbnRrLXJlbGF0ZWQgcm91
dGluZXMgYXJlIHN1cHBvc2VkDQp0byBldmFwb3JhdGUgdGhlbXNlbHZlcywgYmFzZWQgb24gdGhl
IGNvbmRpdGlvbmFsIGluDQppbmNsdWRlL2xpbnV4L3ByaW50ay5oDQoNClRoYXQgc2hvdWxkIGJl
IGZpeGVkIHRoZXJlIGluc3RlYWQgb2YgaW4geW91ciBjb2RlLg0KDQpMZXQgbWUga25vdyBpZiB5
b3UnZCBsaWtlIG1lIHRvIHN1Ym1pdCBhIHBhdGNoIGZvciB0aGF0LiAgSSBvbmx5IGhlc2l0YXRl
DQpiZWNhdXNlIHlvdXIgcGF0Y2ggZGVwZW5kcyBvbiBpdCwgYW5kIElNSE8gaXQgbWFrZXMgbW9y
ZSBzZW5zZSB0bw0KaW5jbHVkZSBpdCBpbiB5b3VyIGJhdGNoIHRoYW4gc2VwYXJhdGVseS4gT3Ro
ZXJ3aXNlIHRoZXJlJ3MgYSBwYXRjaCByYWNlDQpjb25kaXRpb24uDQogLS0gVGltDQoNCg==
