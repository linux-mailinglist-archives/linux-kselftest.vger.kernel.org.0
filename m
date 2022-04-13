Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EDD4FFCFC
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Apr 2022 19:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbiDMRls (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Apr 2022 13:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbiDMRlr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Apr 2022 13:41:47 -0400
X-Greylist: delayed 4319 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Apr 2022 10:39:23 PDT
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244FB2DED;
        Wed, 13 Apr 2022 10:39:21 -0700 (PDT)
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23D6T8N7007811;
        Wed, 13 Apr 2022 16:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=IxangmeW8PQl7IjaPrGYp1RUmJ7UdMDsm20gX4qStmk=;
 b=C5dNkkt1azEgnB597xOkSxJZGQ4lrdGBHd626NodAb6M81Lbb7shNMrJC9SP48WlSWyp
 ylViBo13DxxpWZdB0nj9oSwLWQI4PyzpfrQB9oN/f3AdMpbJ7fPDCQSbMinCz18kRz06
 pvxU1n8l60Vmu12cz7jQlvbaPCOAxNPrdUyTnhTVpZRXbRDDiLV0TxPZemYR44VsBIQs
 nkIb7gZ8pl3Okq/bD9V0vQfrooz8tWrMCqAyX2FkYCX5iUq3fFlJ7gPVLPHMJIs91bA4
 3nhDbk+i8CTkWHds+HeMZee84px/0ZBE4K7XTAqWE+kTBkDjlEWTDNb4h7fOAQuE7UsO 0g== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3fb2hqm98j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 16:27:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqfswK+MpTRAS66hRQgnvEEmCrbkJaXI7PqXZsGkaW9ajfripzR184EdRRiXFoCY1b4z5tQRZmBS3MRVNN5/HkzKGYXluS9CmcAaGLbWKkDNr9wyqHdmtlsWiDbsML8GbFiHvp+K/LUYue0d9wfhFwVyRMdANWNB7sgIEG2yCH4dbSGjZfCrF6Pf6fzF8LvgNrnQOvraeMDfaC4ZD0OEdjxesZRY4Y7IluQyxLHzv/F7i2Rnuzp5I9P3fIZR9IK2VEAKX0hAfGltw9nulELGIl16vhIlHMfNZTNaw/jRgkOXpVJkKB/SGXJdXUug+26Q14P6jxjJ2X796o0ASAIqww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxangmeW8PQl7IjaPrGYp1RUmJ7UdMDsm20gX4qStmk=;
 b=U33xd1LdM4vUllDCPrGDrZWkj9nx87P6QgYkuCB+PH3fZtUKQoNscGq3wFUcYm0HDEx7qVzScUVvXfzWuPzbauLZF91dE0JuRswi9X/Lvikkbq5q1HAFJzKQEwdV4Xy+07vk/1DKCcr7npBXJoByKr9M6NnZwKWWAAngJe6m9wC0cObcIeINWNoBtE5qPFPGSbnEDRrPWK66YhaPMy/jku1nrAAkNeSFxjSd9l2agEr0TdxxpJBEKYsSse3DsoXXBWjsbcVnSF4GZbhb/OoVcWVzb99178ipXFyprOaKG5R3yLl69i6rApm3YmzeHlh1lj1uAjVvY4KM2jsQcsQ6hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2503.namprd13.prod.outlook.com (2603:10b6:a02:cd::33)
 by MN2PR13MB2960.namprd13.prod.outlook.com (2603:10b6:208:13a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Wed, 13 Apr
 2022 16:27:04 +0000
Received: from BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::3ca0:f38b:cb3:54e7]) by BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::3ca0:f38b:cb3:54e7%5]) with mapi id 15.20.5186.006; Wed, 13 Apr 2022
 16:27:04 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     "lkft@linaro.org" <lkft@linaro.org>
CC:     "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>
Subject: RE: lkft kselftest for next-20220412
Thread-Topic: lkft kselftest for next-20220412
Thread-Index: AQHYT1HPLW6Dz0U7r02NjAgvty8dRqzuB2vg
Date:   Wed, 13 Apr 2022 16:27:04 +0000
Message-ID: <BYAPR13MB2503C2E191D0C6B09586EDDCFDEC9@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <0100018023b5f4e3-3d559057-2590-42aa-9dd8-300e64c9f6dc-000000@email.amazonses.com>
In-Reply-To: <0100018023b5f4e3-3d559057-2590-42aa-9dd8-300e64c9f6dc-000000@email.amazonses.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f568be73-0d6b-4516-5500-08da1d6a71f5
x-ms-traffictypediagnostic: MN2PR13MB2960:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <MN2PR13MB2960014BEAEB0FD868321C74FDEC9@MN2PR13MB2960.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7oi6cwmYMQzkKaMDZZggvrsz6aPc4bcVSGX2kuRERFtpCPPVcwRad4gXNB5pDOW2ug5X1VxpZqq6d5fOvLZxO6gquUBhwyAP/H2oI4FvA46azo5pjoL8/CPFqHFpJ9bUwE4Xket+SE0DGv8f6nqwwxDau8OBdd+Rzh8jDDC/TsnFlwtI++rZpVW6Nyo2tpkVt6FaOz3oRDKlapMOEmFWWxD4CmKDm4QWjgals0PKeEI3MUJ9d7pgU8H6LA6P4/usJpjjpLYLtkIBUVobRaCvwPaiuz0Hus9Xwidru/6sPh2KWmgxd59lI2JV/gDGwuyOMhvLJ4eNFpf+t+JqfD9fxG7B1QDvZyjMQPhyzqQpzDA2AsFxxKvUJyjrid6EQ26v5hy/zk3y//V43BDAEgjdwuUxoHsJx6h0DTT7Pj0TyHhr94DoSjWd2j8kJN159LG6SuGBx0w+7xJ2etDMnYgaI5tFpYjcn2COljUu0teKp0XeS3W7qyncD1Yww6QxIRHx1KlvI/Bx9hcS30GFZ7kIQ5zDw+Uu1P0N7QqNcdES2FUKAaoDMp8TzTzvsSXWQWwqaylRZzZN3QGVtjEnWNxExt0CXNOzJfi7CCfP6vaTalHgnKY8sRtcw/si5GODYcKdmeMdCszxVC6p1s3o/uEsbSGq2+u7rwrEwmTplUcj14ImAMHZEdKMfvzW8wZ7V5ky7uCCYGIQRe3JYZZ/tnEHXoe1j6KFAvk9WT41uf55CtEIgXmxooO7K9RXTTJoBksxfA6RWOSusnHDZ0MxWUQwAa5Kw7K2pgUTa2Lk99ay1ai43MR+nPf/SFk7FDjSLaMzzryHF5detL4Tn/g10N0YkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2503.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(38070700005)(76116006)(186003)(54906003)(86362001)(66476007)(82960400001)(52536014)(38100700002)(316002)(66446008)(66556008)(66946007)(122000001)(8676002)(8936002)(64756008)(5660300002)(4326008)(83380400001)(2906002)(6506007)(6916009)(7696005)(71200400001)(966005)(55016003)(33656002)(508600001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1VQejNaRUZ0N3RBQ1dmRE1TRGpqWndkUzM0YklTanI2aDFRMVd2QWpDdzRt?=
 =?utf-8?B?aEZyRXVaN05vQ1dCNGlnSEpTb0ltY0pmalZ6RnJVMUF4RnRjekhPbmhrSk9i?=
 =?utf-8?B?amtTamNUaXh3Y0cyQVZ1VU1TUjl4Q2Y2bm5iZ0xQN09RYnBUb0JCSGJ1R0VB?=
 =?utf-8?B?eFJ5YUxLc0sraGI3cTRKbDZNcmdLcHdreVpkQi9pdzViNXVpV1RRbUdwM25L?=
 =?utf-8?B?UWk5TGlqbStjdmkvZXg5cTR3MWhDTmQzNTNPbHJaSkhDWVBwYUpzRkxSQ0J4?=
 =?utf-8?B?Tm1BL0VSNFIrM0JtYW5Sak1odnBhamd6UzU1Qi9TN2lRL3hUK3J0dkJYZ0Y1?=
 =?utf-8?B?S2kzMHRWZ3drckNvRXhLVTZqMzc2bEZKMFZnMDUvMTBiVmV6UWhtOEtxTlp2?=
 =?utf-8?B?aXY2RXVZem1VdkZ4b1krNWo0L1IzSFFhaFlTZHJhRlYxWWpzc0kxNEN1R1FP?=
 =?utf-8?B?WVBybElCTVBYajRLcEI2YkhtVTJzOXdyNUkrYzdaU2Mya2hxZnZFOVlOa3hI?=
 =?utf-8?B?OXc0UnQrR2NWMHp6QmczenA4b1kzRDhuSkdZNnJiOHQ2YXU4YjJuOXEwTDVZ?=
 =?utf-8?B?M1pGNmlWWDV4NXpzZzdocnhucUw4WXJJZVV0T3NQQTZIR0gvMTNQMVk5dCtT?=
 =?utf-8?B?R3J0UWZQS1NPL093Q2dCSVU3K0JmRXMwei9wd1RrYkxiZHhmbFdmQVdrVEFv?=
 =?utf-8?B?R3NadDkwMCt3L2JXdTRLZkhtV2h0WlFtZWUvdWhmYlE2M3FkWnJUZ0xSaENj?=
 =?utf-8?B?bHpMN2tqUkUwZUdQTTAvem1TUlJ6cll1a2NobWV1a1czSDBiajBveHJpVmky?=
 =?utf-8?B?Y3dXcmJJdlBGQXFqbmJUcnNJM0E0UURWSTBVV1d1UDNqelBCZTc1RVpCYWFQ?=
 =?utf-8?B?S3ZheEZ6WitWelFoTjZCa0FSWHJGSjdYVVh6YVFwV0diamFoaGpsYU9YYnBD?=
 =?utf-8?B?UGtDS2ZMQ0xXZHl0QjlyakhKa04rWDgzdWJKQnJhMDJPRDlrQXh6NmVwWVdU?=
 =?utf-8?B?YWl2NU1NWTduNjM1WmRaOWttb0xCdUJ3cjhhcTIyRE9UL3Y3YVhhVHFSakdn?=
 =?utf-8?B?TW1SNlh5NXM5c0tJak1tbE5OQVZiUWs2cHZ4YmVzN09oQVFuY3ZRWXhWeGlq?=
 =?utf-8?B?Q0FQSHo4cjIwQkw5Sy9HY2Z1b2s2ZFpFRlNlcUVuck80a2VUTHJGUXVqTHlX?=
 =?utf-8?B?N2VaSW1OMUQ2bFQyazRodFlSR0UzWkZIaytxWFBKQlRWUzgwcmhyZjhHMjEv?=
 =?utf-8?B?U2c5U21BcU9ZcnlOeEJlV0hqRUp2U1hWWEx5UXNhVHlabHRUdGc5RWMyU3lE?=
 =?utf-8?B?VDVSUVBIcVJMYVZ1V2xJMWl0OU9hNFBBNkdVSU1NZW1TMVQ2Q3ZSVi9QZFY1?=
 =?utf-8?B?eFFoRHJIR2x0TFVkYjNWSnJKMmlrQktzTm1Rb3FFc0FkUWxzc1h1ZEZqbXFE?=
 =?utf-8?B?VmNkUSszeDM0Sy85UGsyUnIvWmhGUGdndm5OOFJrTzNMTGFreGlhOFZPWTd3?=
 =?utf-8?B?QXJwclR2RC9IVGtESE16bE5uZWJMbWlvT1dPOHJyMGhUdGRrTzZmS3M2QURt?=
 =?utf-8?B?TllzZk1zcWJqbDAzVGRlazFIdUU0aXhpZG9NM3hyYVFkS0tNeEI4MTI0MXFP?=
 =?utf-8?B?QkpIeTMzSWloK1REOXFnY2pUYldnd1F2VTdjZXhUbEtjdlhhMkY3VHNucC91?=
 =?utf-8?B?OVdCSFk0RmE2RytTQWxGVm53N09XQ29PRG9aZ0p3WjlkV1JGVGpkWFR3elRn?=
 =?utf-8?B?YW15dm0vYTY3UlpJWnFjVXQ2YituQ0lUT09mOUdnUDB3TXZ0bGMxeVlDTTc4?=
 =?utf-8?B?QmpGVFhyMit6cUJlZlYzaENpZGRnOVU2WDJlMkU3ek9ST0VsUkwyc2drNnc5?=
 =?utf-8?B?TVkvWmJPVmg5NGZHMTNOcldvZEFaOU00QmlweFZVRnVuSEFjeVI1dkd2UjEx?=
 =?utf-8?B?UXNDVFYyYzRweEZxZENGN1lPWm40M3Ivd1JYc3lydzBxVDY1aDVFVnVJUVZS?=
 =?utf-8?B?by82eW5oZzhWcFowUGlUa2VjUG5JVTgrbTkrR0xUdkIxeTlOMUkySEhDNHRk?=
 =?utf-8?B?SlBxaWRZdWpKYTlHUXA1WG9QQ0o3cFFLMG9MVEpybThGS0ZKM1oyeENCbWx2?=
 =?utf-8?B?NXI2K2dwcTQ3VFpPZTBFS0dnYXAvc2ZvdWNMZGw1S2d5aW5INkRKcDN0SkZE?=
 =?utf-8?B?NUlJRUF0bHpkWDgyQ1d3OGw4YjNObThnT3g0eW9hYzhCZnNiTHAvSDR6dy84?=
 =?utf-8?B?SkJrUmJrd3hYRmd0dmovR3dYRW00STQvSXdoMCtHNGZLRWYwQWtUMVN4Zmdw?=
 =?utf-8?B?M3ZqODYrMFAwc052L05vbkkxRklldktaRVkwUVRQcEpaR3RNYzlCZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2503.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f568be73-0d6b-4516-5500-08da1d6a71f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 16:27:04.1676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qBtBZrep5iPbplgHhCqEEzX+uLu5oLcrfmbxIQsrcPRF2aEhBDg2bg/Xm0mofbwHm3S1JDtVSDBNs9smGFd+EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB2960
X-Proofpoint-GUID: 0vubsSXyudj6wfiVkHgbbP-a2vwaf6gc
X-Proofpoint-ORIG-GUID: 0vubsSXyudj6wfiVkHgbbP-a2vwaf6gc
X-Sony-Outbound-GUID: 0vubsSXyudj6wfiVkHgbbP-a2vwaf6gc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-13_03,2022-04-13_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsa2Z0QGxpbmFyby5vcmcgPGxr
ZnRAbGluYXJvLm9yZz4NCj4gDQo+ICMjIEJ1aWxkDQo+ICoga2VybmVsOiA1LjE4LjAtcmMyDQo+
ICogZ2l0OiBodHRwczovL2dpdGxhYi5jb20vTGluYXJvL2xrZnQvbWlycm9ycy9uZXh0L2xpbnV4
LW5leHQNCj4gKiBnaXQgYnJhbmNoOiBtYXN0ZXINCj4gKiBnaXQgY29tbWl0OiBkMGM3NDVlN2Iy
ZDZjZThiY2M3NjhiMzIzNjFhYjhlZjUyMDgyMWVlDQo+ICogZ2l0IGRlc2NyaWJlOiBuZXh0LTIw
MjIwNDEyDQo+ICogdGVzdCBkZXRhaWxzOiBodHRwczovL3FhLXJlcG9ydHMubGluYXJvLm9yZy9s
a2Z0L2xpbnV4LW5leHQtbWFzdGVyL2J1aWxkL25leHQtMjAyMjA0MTINCj4gDQo+ICMjIFRlc3Qg
UmVncmVzc2lvbnMgKGNvbXBhcmVkIHRvIG5leHQtMjAyMjA0MDgpDQo+IE5vIHRlc3QgcmVncmVz
c2lvbnMgZm91bmQuDQo+IA0KPiAjIyBNZXRyaWMgUmVncmVzc2lvbnMgKGNvbXBhcmVkIHRvIG5l
eHQtMjAyMjA0MDgpDQo+IE5vIG1ldHJpYyByZWdyZXNzaW9ucyBmb3VuZC4NCj4gDQo+IFRlc3Rl
ZC1ieTogTGludXggS2VybmVsIEZ1bmN0aW9uYWwgVGVzdGluZyA8bGtmdEBsaW5hcm8ub3JnPg0K
PiANCj4gDQo+ICMjIFRlc3QgRml4ZXMgKGNvbXBhcmVkIHRvIG5leHQtMjAyMjA0MDgpDQo+IE5v
IHRlc3QgZml4ZXMgZm91bmQuDQo+IA0KPiAjIyBNZXRyaWMgRml4ZXMgKGNvbXBhcmVkIHRvIG5l
eHQtMjAyMjA0MDgpDQo+IE5vIG1ldHJpYyBmaXhlcyBmb3VuZC4NCj4gDQo+ICMjIFRlc3QgcmVz
dWx0IHN1bW1hcnkNCj4gdG90YWw6IDAsIHBhc3M6IDAsIGZhaWw6IDAsIHNraXA6IDAsIHhmYWls
OiAwDQoNCk1heWJlIEknbSBtaXNzaW5nIHNvbWV0aGluZywgYnV0IHRoaXMgcmVwb3J0IHNlZW1z
IGxpa2Ugbm9pc2UNCnJhdGhlciB0aGFuIHZhbHVhYmxlIGRhdGEsIGJhc2VkIG9uIHRoZSBhYm92
ZSBudW1iZXJzLg0KDQpDYW4geW91IHBsZWFzZSBhdm9pZCBzZW5kaW5nIGVtcHR5IHRlc3QgcmVw
b3J0cyBpbiB0aGUgZnV0dXJlPw0KDQo+IA0KPiAjIyBCdWlsZCBTdW1tYXJ5DQo+IA0KPiAjIyBU
ZXN0IHN1aXRlcyBzdW1tYXJ5DQo+IA0KPiAtLQ0KPiBMaW5hcm8gTEtGVA0KPiBodHRwczovL2xr
ZnQubGluYXJvLm9yZw0K
