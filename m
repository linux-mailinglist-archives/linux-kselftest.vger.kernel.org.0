Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D0B59FDC5
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Aug 2022 17:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237166AbiHXPDa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Aug 2022 11:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239175AbiHXPD2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Aug 2022 11:03:28 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A612D92F67;
        Wed, 24 Aug 2022 08:03:27 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OEmJ1c011758;
        Wed, 24 Aug 2022 08:03:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=M2EUh91rozemOPhtqY26+6mue5OkbQ2QN58P4fa/Cm0=;
 b=dYmBJ1RuIY3O/R1NGav50hvEQ4vsnsBk8VFZhg/tg0vbZ4JF+pE4nhaWV5N/Xvb7KAaT
 mVkzbNOhejAy9+XK0H87CRFk4kBmUsdQveolwrB6acVppUVmIMM0kt2K5fxU+NtxyZdO
 jszC+fj85r7PStNMvxYsvnwH1nuGY7jKOVQ= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j5aay3ugw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 08:03:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYKKOx46BjqHhwolskfjuZ0FK4AnkaKZIJMX4T4AXw+UV/UNef8fElArSWcNne7Z3Fo4Wzm2T9oV8d7rLhj3IthXFTsBVDs+3kgWhX8OFu0EhUoFaZTn7dJUFc8KZNHQK1NGESlXH1V0Cm1hIj0zHwwS7V0KBVkOD+px3I8v/XjgFM8sBe2iA6DjhS4MI86jzX+mNG/kUG7hM8B0R1/RCUD4HAKQ8/W+CetxGHPolizUYZkR2ZbAypH0URsprA4lOjcI3oqwd9fHxF00SjX29w5ijLMYD2yb+oL/ShN5ITBOoC329yDUe3kIJ3uIhx0GMqnQi9X3WUpymdcXZBBZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2EUh91rozemOPhtqY26+6mue5OkbQ2QN58P4fa/Cm0=;
 b=AEZDRtEnAoVk+KQvWzU6Xb8bIIoMBy/T8XugH94gsDEpJgOi9daJcFXksJ7kadImyAHFfwMEZJZSeUql68F4d/dAp7SumLYZDgZ5uCnhg5RRLtE4LIZ0/XP6FVc1biEF/39oDEgOYJYpJc8p/UcZJ38jmxnNvKNuaVw49W2yMLrK6MS+iNgC2fu/kzK5qe0iSUNAnETq9DpLfR8TCP1+hEdTCVFAawYOTL6Kw81iDRgAcTANoi5vyTVXcFgA8c238Sr4Lk5WeYObNorgkGfCHJQxEWkiDpOTnhbEaj+YFAH8oe44YnN/NttlJL+wA/Zpfgl6/2Xz6jBLsqbvGkv7gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from PH0PR15MB5262.namprd15.prod.outlook.com (2603:10b6:510:14d::6)
 by MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 15:03:24 +0000
Received: from PH0PR15MB5262.namprd15.prod.outlook.com
 ([fe80::84f7:68ec:470e:288b]) by PH0PR15MB5262.namprd15.prod.outlook.com
 ([fe80::84f7:68ec:470e:288b%6]) with mapi id 15.20.5546.016; Wed, 24 Aug 2022
 15:03:24 +0000
From:   Mykola Lysenko <mykolal@fb.com>
To:     Qiao Ma <mqaio@linux.alibaba.com>
CC:     Mykola Lysenko <mykolal@fb.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix incorrect fcntl call
Thread-Topic: [PATCH bpf-next] selftests/bpf: fix incorrect fcntl call
Thread-Index: AQHYt8H771WLe1C0EEGJ4DrKpxSKIq2+JciA
Date:   Wed, 24 Aug 2022 15:03:23 +0000
Message-ID: <9BE5800D-DA65-485A-8E5E-5B84F59F70BD@fb.com>
References: <a46dffe36f2570ec91761b1d604ac52fa0a10efb.1661348961.git.mqaio@linux.alibaba.com>
In-Reply-To: <a46dffe36f2570ec91761b1d604ac52fa0a10efb.1661348961.git.mqaio@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 063e9004-bb7c-4827-a057-08da85e1ca9f
x-ms-traffictypediagnostic: MW4PR15MB4475:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eHqkJpZ4P9p0k1rCnX+0kqLr8J2LbY4QBCNHsWdzgAngEYuaZNgATEljJbAVwf4Fkbs5rjIu/IbkkdXWWeF8pM1HQ6R+ObUiBAufkMSrEigwVcmRPim6o8IeLyychhBN/zXTMNeUsdKWCsIR+6I0bjy2WDhB4awO98Wak6XbhpsR7F4IkRdP9oVmpzksK+oo4mT2vLt91/DiBFUojUOhoIidxAXu+kt1bCZB0k4LGPpib8peXSsoQD2iMsOME1NBb+JPiq5ZB7dbtmCJcnTxtv3ZQhBgGp+NGEjT3iHhTlqktwcddMiuOBlWAD6u/5RNcmQwr75OBOU0zKHVDyKTHLi+5OZzmycRStH83UTN6E9GlcgOZPX4qiFZ67p6ZFV3KWj0F0CpEi+ro7fDD/+iidUFLoyYmWptj8XFsh2su6UI+tY+IdQT7s7WHoKb33GGetpupd99TiceqhD4Rq5W4KGIeJHZALemkAIFES/tZyCb+4aqsMy1CF7ki64NuVGMKMi9paN8QxjZBwVOvFzM01uOYTe8N5ZOX/1RGiU2Nu3gvGa4EWzWiNcZh6XLXzzpRA7kUC8CAgfJ9rNYkEfGOE+/d8lw2MBfOQ6pm0blOLf6oyIrZ2PyDKZATsqkel6IhMNXsL4wSqxJWMaTscSu3+PjGOYn75Sy/OhhfmUiID6C7xcRppMbRO5OAJAPGcPvZxLjjVizIbP6hjIglhHoHs0pYm+Z9h3cT4RmIPoX/fndfMHM3mnav+juXJHMyiBgxd6LlmLxLKh6P8NcRHzsvH83QKfbIeAvIVDAaKcokqE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5262.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(478600001)(6486002)(83380400001)(5660300002)(38070700005)(2906002)(86362001)(8936002)(71200400001)(36756003)(66946007)(76116006)(4326008)(122000001)(2616005)(66556008)(8676002)(316002)(66446008)(66476007)(6506007)(64756008)(53546011)(6512007)(38100700002)(33656002)(6916009)(54906003)(41300700001)(186003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0hlMHhBTGgzbVltYUs0YW9qOGdpbGFHdHNHQkRseWxCMUlXQU5UUjJ6WDN4?=
 =?utf-8?B?c0tKbVdPMm4vUFNVYVFNWXhLVG1zQk1UM3FQNHNTRjVsR0hhaHpSMzVMaW5N?=
 =?utf-8?B?Wk9ST0syNlhwS1N4cFM0aStRdGdSeEZFNUp3dGJ1a21JSEhtVUZPdU40bFN1?=
 =?utf-8?B?LytzeTJGVVRXZnUzcU9vZEdPMGV5R2tYRWZRUkpaQUNmWEpoeUVvbGdBcmdw?=
 =?utf-8?B?cXQ0Q3VmZnNZVTcwWTFYRUdQVWErc1VraEtPd2p1ZTZjZThUdUg3Tjl5Y3RD?=
 =?utf-8?B?ZVZ5c043YzV6QW8zZXY0MmlyVlNyNThGMTNBcW5Bdk8rcjA3ekI0Tzlld2VX?=
 =?utf-8?B?d0YyOGxkTnRZNHVmQnRjdUlPQWVWRjgxNzVJdTFqY2lIL2Zld3BwUnF5d1Jq?=
 =?utf-8?B?SEF4RldTSm5DZzJKRCtxai9vaVhCN2VFQ1AvSGhBazYvd0NpUklqZExhMGh2?=
 =?utf-8?B?OWFOTXJuZXFMbVgzclJQbDVFS0Zxc2VhWk5PTm04MUtnU3d5VFNXYUJpWDY3?=
 =?utf-8?B?M3BxaG1lSndOYkh3ZjVGT3lUS042ditMandrQk5sRWtsdHBoSHM4TVl3UkpJ?=
 =?utf-8?B?Sk8wV3RiYlNzYXpWdkwzdVRxT3JLeGE2R0w1U0wvTEFVeEZjZHZBZDRUbTQx?=
 =?utf-8?B?UlArdkNlRlBIL3VzeVNzeTNKMURxbTQvWk53Y0J6WnRENUt3TzFMREFkN1ZU?=
 =?utf-8?B?ZENTRzA0YUhYdVBveFV1dTJmb2VyNVBMWWNRdFB0aFVxT1JxOSs3WFplYjFm?=
 =?utf-8?B?ajJremVQVFVYWFZPaHRobXQ0VU1UeG1OazZrSll3R3hBZktiUkp5WTFOWjI5?=
 =?utf-8?B?RU4rNkZoR2pod0g4WVVqcjBNaUZueVpFbXdqSk9jM2ZETWZvOXJkVS9TdTd6?=
 =?utf-8?B?bGIyS0NLZk5oK1BFOVNKQ1JjQkw2SXNqd005YUR1UCtMYVNPeHVkK1ZkTVdj?=
 =?utf-8?B?NEs0MEg2dlZnN1AvN3Q0eUtXdzhoKzQ1T1pTbjFXeFV4cys3cHVNQVNnYkox?=
 =?utf-8?B?SjlQbjZBazNpdTdScWVvMmYyQ2JrSWtOZEoxYmlBK1pHSU5ZdlllVWRjcUFy?=
 =?utf-8?B?N29XdVZRMzFIQVo3cSt6ci9JaXJCRGJTWDlaaC9HVjRZTm01UlcwT3FPRS94?=
 =?utf-8?B?UTlscFBaYmpTenZqd2VqaDFiY1dzcDNOV3RQbmY1SGVSV3g0UU1uMXVPbTJn?=
 =?utf-8?B?Y0dpMFhMTHRXWVFUMEVRYVhEc3VHUU42MDI4TFJ6aEVQVndtUng5ZDRQYkMw?=
 =?utf-8?B?K3FpNGNBREZ1eXJrUEVvbWZzeGNuRmRZdnFWYzB1TWFyRzk2MEJKNXRnUyt1?=
 =?utf-8?B?ZTRFcG8zeVBrVmlSMHN3YXFDeTgrTnZVSHVERVFCYzN6djdqc1NnU2FxWm1M?=
 =?utf-8?B?bWtrL3cvcHE4U0Mvd05hMTVoM1dOSG5kelRHRjNTcDdKYlNpNC92OHZsQjdB?=
 =?utf-8?B?Wk9tWm5PMEdhTG5tbng2QmIzM3I5UCtPVFNRcS8rRlNNRTJQaFZ6aGhMRFNZ?=
 =?utf-8?B?QnBKeUlvWStUWCtSYmtXeFNaUHlUNjJPeHBUMFdEaTdaNmpaSG9OWklVaU1v?=
 =?utf-8?B?NTF3NTJRdExPZjgwalBUR01vOXNMNzNNQVBmSU5KVHBoOVJrZW44SlFVNmNH?=
 =?utf-8?B?YldEdno0RDBkM080V1hqNldqbjZhNmh0VG5BdlVhaTdDWndUQVpENDZoQW1J?=
 =?utf-8?B?S3F5ZlpTeHIvMHRaU2VTYnJDcnZsTU11eWl0TUxoNE9BNGh3N0N5U1JydDBv?=
 =?utf-8?B?aHBhUFZZb2VwYk1nNjFxTkxNSzY1U2Q5UnJrb0Q5WjF1SnlDem91WEhKUTFL?=
 =?utf-8?B?V3ZzT3RZdU9xQTVoUWlJbmQ3K0M2K1JxODZaQkpkb0szcXVDYm9tYmJoS1Ew?=
 =?utf-8?B?WkFPclgvd05hVkxMeXZyZVpjSnVRK0ZiUFBDa0lyM3J5eWNjdm8rVEMxNEQ3?=
 =?utf-8?B?T1pDajV3ZHRJam5HYnhnakEvZ3BBUVhtLzZUemVwNnFZTjdyMHZqK2RZMUl4?=
 =?utf-8?B?U1dxa0Nlb1d2T0RhdVZUUnpTMGdHSVdPbFc4TkNkelBjNXNXUjNQUjllVFlr?=
 =?utf-8?B?M3p1bWQwSnlLNVFvRC9jRmc0NVhqNSt4clE0YnptSVNYMjM4QURqUmpaVTc4?=
 =?utf-8?B?V0RyKzNvSml2Q2tmSVZXM01aVDd5dVNnVk1nMTQyQ3JsREV4cFVsdTRuRFFx?=
 =?utf-8?B?clE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55FDE1BD12D2754FA45869AFFAF74BA2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5262.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 063e9004-bb7c-4827-a057-08da85e1ca9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 15:03:23.9784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rKePOYsSmkHL+id3/d12iepGUOMyfrGk6S6SSrRZMbk5TlttZTXWdzJAsKMt5EKj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4475
X-Proofpoint-ORIG-GUID: 6gz80IWggQmuyIp8zJM3b8TSumgVfFLD
X-Proofpoint-GUID: 6gz80IWggQmuyIp8zJM3b8TSumgVfFLD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_08,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgUWlhbywNCg0KPiBPbiBBdWcgMjQsIDIwMjIsIGF0IDc6MDEgQU0sIFFpYW8gTWEgPG1xYWlv
QGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToNCj4gDQo+ICEtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfA0KPiAgVGhpcyBN
ZXNzYWdlIElzIEZyb20gYW4gRXh0ZXJuYWwgU2VuZGVyDQo+IA0KPiB8LS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSENCj4g
DQo+IFRvIHNldCBzb2NrZXQgbm9ibG9jaywgd2UgbmVlZCB0byB1c2UNCj4+IGZjbnRsKGZkLCBG
X1NFVEZMLCBPX05PTkJMT0NLKTsNCj4gcmF0aGVyIHRoYW46DQo+PiBmY250bChmZCwgT19OT05C
TE9DSyk7DQoNCkNhbiB5b3UgcGxlYXNlIGFkZCBtb3JlIGRlc2NyaXB0aW9uIG9uIHdoYXQgaXMg
aXQgZml4aW5nPw0KDQpBZGRpdGlvbmFsbHksIGFkZCBmaWxlIG5hbWUgdG8gdGhlIHRpdGxlIHRv
IG1ha2UgaXQgZWFzaWVyIHRvIGlkZW50aWZ5IHRoZSBjb21taXQgZnJvbSBvbmVsaW5lIGdpdCBs
b2cuDQoNClNvbWV0aGluZyBsaWtlIOKAnHNlbGZ0ZXN0cy9icGY6IGZpeCBpbmNvcnJlY3QgZmNu
dGwgY2FsbCAodGVzdF9zb2NrbWFwLmMp4oCdLg0KDQpUaGFuayB5b3UhDQoNCg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogUWlhbyBNYSA8bXFhaW9AbGludXguYWxpYmFiYS5jb20+DQo+IC0tLQ0KPiB0
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdGVzdF9zb2NrbWFwLmMgfCAyICstDQo+IDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi90ZXN0X3NvY2ttYXAuYyBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2JwZi90ZXN0X3NvY2ttYXAuYw0KPiBpbmRleCAwZmJhY2NkYzg4NjEu
LmIxNjNiN2NmZDk1NyAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBm
L3Rlc3Rfc29ja21hcC5jDQo+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi90ZXN0
X3NvY2ttYXAuYw0KPiBAQCAtNTk4LDcgKzU5OCw3IEBAIHN0YXRpYyBpbnQgbXNnX2xvb3AoaW50
IGZkLCBpbnQgaW92X2NvdW50LCBpbnQgaW92X2xlbmd0aCwgaW50IGNudCwNCj4gCQlzdHJ1Y3Qg
dGltZXZhbCB0aW1lb3V0Ow0KPiAJCWZkX3NldCB3Ow0KPiANCj4gLQkJZmNudGwoZmQsIGZkX2Zs
YWdzKTsNCj4gKwkJZmNudGwoZmQsIEZfU0VURkwsIGZkX2ZsYWdzKTsNCj4gCQkvKiBBY2NvdW50
IGZvciBwb3AgYnl0ZXMgbm90aW5nIGVhY2ggaXRlcmF0aW9uIG9mIGFwcGx5IHdpbGwNCj4gCQkg
KiBjYWxsIG1zZ19wb3BfZGF0YSBoZWxwZXIgc28gd2UgbmVlZCB0byBhY2NvdW50IGZvciB0aGlz
DQo+IAkJICogYnkgY2FsY3VsYXRpbmcgdGhlIG51bWJlciBvZiBhcHBseSBpdGVyYXRpb25zLiBO
b3RlIHVzZXINCj4gLS0gDQo+IDEuOC4zLjENCj4gDQoNCg==
