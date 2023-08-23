Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B136A78582C
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Aug 2023 14:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbjHWMzP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Aug 2023 08:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbjHWMzO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Aug 2023 08:55:14 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2114.outbound.protection.outlook.com [40.107.8.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B68EE54;
        Wed, 23 Aug 2023 05:55:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACG9hChxsgFdDFA+rFyy3jWgrXl5uwvMP11KlHdyudAa94GdRTHDUM158Ui1keTNqnFNXXnhLvv2CBGi9AUmjkEqsTPGNLfUQKpRe1I9obzVtrD5ACDeoGydtwie8P7rRsJrnEArsDVFS7Xtp+VhYXWtNsEryoAwg3PA3Z9WK6k8Go7sUomEH9UDvixUvMzol4zBX+n24xRiucfHviZBT9RBJo4tiew0yzQNC5oNQ72Xp/yCDRNWlBl4Ng0+9Wgc0J7om3rbMfPeU+Qmx8plFFr9yBJhheA5tnAZeNxr0Z9HW1A2bXkD9XSdmONxM1sN5eS16QvqQcETBv3VKacGmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1j/s+I4A3lVqGnIESEXwTcux4Mt0qssQm4od4BFGIU=;
 b=iTyv3adiKqTVeVAoAr396uAsTcIQkZyZtwtrN6Hm787G4an1cW4lvRmyyN9nawhG9K11JUKOR1DL80ZWh31Tfspb5ZnVPYUbLJosFrqDkrPHegTRs45Uq5eyMb8o6Vq0kKvA0fbt3SXnzVwvYHR8aMt8QRDQrkarPLj999nNZZot0HR/4ZkeJeWlfvWLfihyXIFcEzni6rknTSgipjFtFqNKdjb7gh/jHtb6yoQQpayFDsUJOAqeoGQZcVn8FkfKmT9Ba6jxv976hhrNIOHqh44HgWjqdFsm3+GclNwkMVlmJ+vKUEcuuYkGQRhXRGIV1lOuYqp1tlyNKsQRLo9jVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1j/s+I4A3lVqGnIESEXwTcux4Mt0qssQm4od4BFGIU=;
 b=LQ3k2J7ETr72qsuP87bYLEl1YPoNiBB5vbrJgWf5tU2J+yYuaPUl4jG7LvjlOuuvcv0tJmdJHpTt4er7Hs1OyW174yLItvC72AvfRAiUxt0/mwEPf7uZUA1giO8dkPgbWdtpaH7P4XTgIDQsJ2RHvcf3wp1iGdsQYoLp3vVkJzo=
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by GVXP189MB2030.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:6c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Wed, 23 Aug
 2023 12:55:04 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670%6]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 12:55:04 +0000
From:   Sriram Yagnaraman <sriram.yagnaraman@est.tech>
To:     Ido Schimmel <idosch@idosch.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>
Subject: RE: [PATCH 3/3] selftests: forwarding: Add test for load-balancing
 between multiple servers
Thread-Topic: [PATCH 3/3] selftests: forwarding: Add test for load-balancing
 between multiple servers
Thread-Index: AQHZ0pMUlNN+cgUkKUqzv/5j/AbJm6/0ocqAgACCNMCAAYvVAIABLJYQ
Date:   Wed, 23 Aug 2023 12:55:03 +0000
Message-ID: <DBBP189MB1433662D9678A16702308CE5951CA@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
References: <20230819114825.30867-1-sriram.yagnaraman@est.tech>
 <20230819114825.30867-4-sriram.yagnaraman@est.tech>
 <ZONLz5IyaG+XnUSJ@shredder>
 <DBBP189MB1433714989BBE41321848336951EA@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
 <ZOUFFOIQeGazn2Dr@shredder>
In-Reply-To: <ZOUFFOIQeGazn2Dr@shredder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBP189MB1433:EE_|GVXP189MB2030:EE_
x-ms-office365-filtering-correlation-id: 9107fb39-ae90-40ac-7e58-08dba3d82b78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VdIXMRbiXtCFOMNXzNqlo7o9adNyc+uzzqi99FE52mqF2htVX7e7KhsiVavaiu8sapWRvZOzVtqI4/5O9sNCK/492aBQHib4o9BnnoeMb15RXWj/xr59Y0wT2WJ4V1Ct96OZYfjC1XJDFNB5rpDD11WVJOGFcuxUyloeq4M7bFcUFKU7dJBy4zW1xnZxIijPb7bdPgvyXFBZ2dkkU4P4tQOyJGr+3EMWJL9v54Ul4/bPntguJ2oFRUZbqGyo4XFY4Ym1THXJ/L0qYDPTnD4TyUpZgaCnnPZEJUFpx9jgUtpODx9Bk/V4IPfeybt1YC7WIKSASzf855WcqOLJytkmipXysSmniG7DtZ3U5d/WFryjavAa7U4E2ioxp3kjlPMUdOhNthy5OAVZRPm/PteF8tZjdversbMCbdR21MhbPbtRZHGaFah0JkzxWtOEA+0BcWCiXaNp2gST/lQmO0C1vd9haThnFoAlsRb1j6WDH688u68JPulRqI0UYedHuFkLjcVb5hFsuaEfuR+q4ur7Z1yOMEqE0O+WevsFIdrlQBvvFv7O8VdYxm2eX/yY8ygfe6F/lKhU6svanDA//iRJ1ZEyOfuEm8VRjxOdgrorx9l8nOv/dmss9XJhmdlcgAqN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(39840400004)(396003)(186009)(1800799009)(451199024)(26005)(9686003)(55016003)(38070700005)(122000001)(38100700002)(86362001)(33656002)(83380400001)(8936002)(316002)(8676002)(41300700001)(66556008)(6916009)(478600001)(66946007)(54906003)(7416002)(66476007)(2906002)(52536014)(76116006)(66446008)(4326008)(64756008)(71200400001)(7696005)(44832011)(6506007)(53546011)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjNQSjQ0Mnk1YmtNc1luWUYzcWhLejZtMFBJWmJ2Q0Jld3Rka1FXTWxPOWlz?=
 =?utf-8?B?NW4rd2xiMGd6YWhQYnZ6QlpTYWpwT2NYOHFQWU4rV1FxbU5pclBDREt0WjJB?=
 =?utf-8?B?Qk1jUHpUbk1aWlhPSEV1aHJhV2lQYkh2Zm5YZk13MG5TaHJNSEl0c1lReVJK?=
 =?utf-8?B?U1REQmw2cTBIU1RTS21wc2lHWHdEWE9PRGt0QWtQS3pWd3ZYN2xoUDQzR013?=
 =?utf-8?B?b00zZ0hHUTlaVHRZQmowL2FwRklHcmYxaVMwL3QyaHErMDkyVUdONFIwTnVa?=
 =?utf-8?B?M2NCcXRzb2QwY0FMSk5BY1oxTUlDU2RFM2hlMnFQMlhLWXphTWVTSlpvSG9p?=
 =?utf-8?B?VGdvQU03OGZYUDdtZHJVSkJleGYrOFVmZDdaS215WXZueUtwMkxiRnp1cFRQ?=
 =?utf-8?B?OHVVeXZaVFVzZHlydEhDelpuKzRFSWFZZWJwV2pjdHo1YWFGZERXTmF0UEVi?=
 =?utf-8?B?NDFYZ1FHTVhOenkxSXI0Zi9hbGJYTk5jMldCRFlZZ1RuRE9KS1F1NkpucEVV?=
 =?utf-8?B?cUE3bjREZk8ybk8vNW9CcDFqdUhCMU5nU0N2WVN0NWtzNGl6WlJYd0FFS3Vh?=
 =?utf-8?B?MTYxK0NqdS8vcDJBU2VhVEhXWjh0T2kydUZ6NGowdkJKT1lSanE2SVl6a2Jz?=
 =?utf-8?B?eEpmcE5Ccmh0U0JjNTErb2pOa215VjJHRHErOVI3eUpXZ3E1MTdNcXMzNzNT?=
 =?utf-8?B?TU8rMnpXZk8rQTQ1ZVI4c0lhT2tHM3R3eW9paHVTNnVCd0VwbFRqWjZETzJF?=
 =?utf-8?B?cmd3b0tYOGE2SjB1clpMWWlZS05GMW9keWtxREFHZHdoTW92S0NWYVhzN0RH?=
 =?utf-8?B?bys0SUFCSVpkWGpSTUk5ZlJVVE8wUjVMYVRvUHlRbjhKZVpMaTA2aStFb2Ja?=
 =?utf-8?B?YmRlMU5pVlpmSVU4T2I0UncvbVJrcFRIQ1Zrdks2K3hFN0ZQUEJHNTFQUEc5?=
 =?utf-8?B?UDZEbmVrMWhkT09JSm04akRqK0tIUk0rL0xSWXdidGtZQnlZYU9NMFJTd2hB?=
 =?utf-8?B?QlpSaHNaNW45V2ZPcE1lSXlWaWFsVTUzQUJHbldjZTdoYU53eFpUVG8xaFQ5?=
 =?utf-8?B?VE1Ra0o4K1lKc1VaUEZvLzRSa1VyUGhINWJVakJPUXRSd00weHlhSHh2TFhy?=
 =?utf-8?B?RDRHU1FPOEN0UTJ5YkpraWlRQWF5ZXFidkpnMmd2dE1INWlDdk02YkJBYStM?=
 =?utf-8?B?dGUwOGI1MjdDZzhSSGxySU40dlU4allUNndXMHVxRnRLbUxjcXVualZ1Lzhm?=
 =?utf-8?B?azQyem8zU2lBL2FGMGJmMU5WVlFlNDhETlF6djYvT25WRDVZdE1vR0tVcXNP?=
 =?utf-8?B?WjNwSFJ3VXR1UmMvUXFPR1lwTEhKOEs2bHJQTEkrelFWNEVGM3VvRDdkaUZ5?=
 =?utf-8?B?LzNhN1ZlUTRLT2h4bVNnZHB4MmhFN3pVckNkRFdzVXJiQmQ5NEFDdUFJbmxx?=
 =?utf-8?B?Mkh1TUZ1eUFQM3dPMzhMNS9uU29MNkFYbnlqN3NSZEJ4eWdrR3lYMXdjcWVD?=
 =?utf-8?B?cTVXZWJYOHpOemVrbTRhZDR1NmtMcVlmNzRkdURtT1N6bkxVQy9YZmxPUDNo?=
 =?utf-8?B?SEl3MjFwaG1xdGc2Mlk0OHVQWWpZLzZqMU4wY2MwYU1MV1I3ZUFhUTdzUUdU?=
 =?utf-8?B?VVFramMwWURmc05hMnFrWWlkYlNEQWtGTUlhd2VEMVVldXhBMkVNRHM1ZU82?=
 =?utf-8?B?bmpDY1ZYQzVTZ0VHZFNPTnR3OUlFT2tkRjNmd2VoTlpoeDVuVSs4c1VSSEh0?=
 =?utf-8?B?WVR2SjJVdXlhSER6d1NDZVZKcW9KcEwyNndYcWVWWGVDTGZ1d3ViSlFLMTY0?=
 =?utf-8?B?aVBIdWljUmk4ZzUxUkExWm5JWmd1QkZDUWFmZGtkWjlQTWFKQjNybFNzdGFk?=
 =?utf-8?B?MzdPY3dER3dCOE9qOTJwUXVSOTdFd2V3Q0Q3NXp0eDN2Vm0vQ01OWmF4Sjl5?=
 =?utf-8?B?enUzdU0zUmF5L2QwZ2hMM3BuSGpVNVYvUTFNb2xjYlZmQlJGYVFuRTlGUXZZ?=
 =?utf-8?B?QnE0UW5UOU81THR6Rk5UTFI0Vyt5cHBRYWhVTW0vRlZ3NVFSYzNkSnZHYzln?=
 =?utf-8?B?cHVwZDhUb2hmMWFKNzBpdG5XaTBGM2cyQ0toSHJxaTdtZ01peWM5MUJBM2t5?=
 =?utf-8?Q?JdC63m+6gs0K48cHZ5pTtkaGg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9107fb39-ae90-40ac-7e58-08dba3d82b78
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 12:55:04.0297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 43RsDblWQH12o4xbNkds/VqHdv0Zj1ir3lQ5oUtDLQ+zsCotxu12RR2bmLWV+F51cxNKv7GDQU/fsHYhe8iBdAFxRy4y0YNabTFdCi9bEOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP189MB2030
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWRvIFNjaGltbWVsIDxp
ZG9zY2hAaWRvc2NoLm9yZz4NCj4gU2VudDogVHVlc2RheSwgMjIgQXVndXN0IDIwMjMgMjA6NTcN
Cj4gVG86IFNyaXJhbSBZYWduYXJhbWFuIDxzcmlyYW0ueWFnbmFyYW1hbkBlc3QudGVjaD4NCj4g
Q2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5v
cmc7IERhdmlkIFMgLiBNaWxsZXINCj4gPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6
ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1Yg0KPiBLaWNpbnNraSA8a3ViYUBrZXJuZWwu
b3JnPjsgUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgRGF2aWQgQWhlcm4NCj4gPGRz
YWhlcm5Aa2VybmVsLm9yZz47IElkbyBTY2hpbW1lbCA8aWRvc2NoQG52aWRpYS5jb20+OyBTaHVh
aCBLaGFuDQo+IDxzaHVhaEBrZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDMvM10g
c2VsZnRlc3RzOiBmb3J3YXJkaW5nOiBBZGQgdGVzdCBmb3IgbG9hZC1iYWxhbmNpbmcNCj4gYmV0
d2VlbiBtdWx0aXBsZSBzZXJ2ZXJzDQo+IA0KPiBPbiBNb24sIEF1ZyAyMSwgMjAyMyBhdCAwNzoz
Njo0N1BNICswMDAwLCBTcmlyYW0gWWFnbmFyYW1hbiB3cm90ZToNCj4gPiBEbyB5b3UgdGhpbmsg
aXQgd291bGQgYmUgT0sgdG8gZHJvcCB0aGlzIHBhdGNoIGZyb20gdGhlIHNlcmllcyBmb3Igbm93
PyBJIGNhbg0KPiBjb21lIGJhY2sgd2l0aCB0aGUgc2VsZnRlc3Qgd2hlbiBJIGhhdmUgc29tZXRo
aW5nIHdvcmtpbmcgY29ycmVjdGx5Pw0KPiANCj4gVGhlcmUncyBhIG1vcmUgZGlyZWN0IHdheSBv
ZiB0ZXN0aW5nIGl0IGFuZCB0aGF0J3MgYnkgY291bnRpbmcgdGhlIG51bWJlciBvZg0KPiB0aW1l
cyB0aGUgcmVsZXZhbnQgRklCIHRyYWNlIHBvaW50IHdhcyB0cmlnZ2VyZWQuIFRoaXMgc2NyaXB0
IFsxXSBkb2VzIGl0IGZvciBJUHY0Lg0KPiBGb3IgSVB2NiB0aGUgZXF1aXZhbGVudCB0cmFjZSBw
b2ludCBpcyBjYWxsZWQgZmliNjpmaWI2X3RhYmxlX2xvb2t1cC4gVGhlIHNjcmlwdA0KPiBjYW4g
b2J2aW91c2x5IGJlIG1hZGUgbmljZXIuDQo+IA0KPiBCZWZvcmUgdGhlIHBhdGNoZXM6DQo+IA0K
PiAjIC4vbXBfcmVwby5zaA0KPiAxMDAyMA0KPiANCj4gQWZ0ZXIgdGhlIHBhdGNoZXM6DQo+IA0K
PiAjIC4vbXBfcmVwby5zaA0KPiA2NTUzNQ0KPiANCj4gWW91IGNhbiBzZWUgdGhhdCBhZnRlciB0
aGUgcGF0Y2hlcyB0aGUgdHJhY2UgcG9pbnQgaXMgdHJpZ2dlcmVkIGZvciBldmVyeSBwYWNrZXQu
DQo+IFNvbWV0aW1lcyBpdCdzIGEgYml0IGxlc3MuIEkgYXNzdW1lIGJlY2F1c2Ugc29tZSBldmVu
dHMgYXJlIGxvc3QuDQo+IA0KPiBBbm90aGVyIGFwcHJvYWNoIHdvdWxkIGJlIHRvIHR3ZWFrIHRo
ZSBjdXJyZW50IHRlc3Qgc28gdGhhdCAkaDEgYW5kICRycDEgYXJlDQo+IGNvbmZpZ3VyZWQgaW4g
YSBzaW1pbGFyIGZhc2hpb24gdG8gdmV0aDAgYW5kIHZldGgxLg0KPiANCg0KTmljZS4gVGhhbmtz
IGEgbG90LCBJIHdpbGwgc2VuZCB2MiB3aXRoIHRoaXMgYXBwcm9hY2guDQo=
