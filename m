Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BD7759788
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 15:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjGSN5o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 09:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjGSN5n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 09:57:43 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E68A1FFB;
        Wed, 19 Jul 2023 06:57:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCVrFmt5NKhRTsGhnlgU6ohT9/+6HK9tEwzn4JDeIz805o+ky1WjX4zXEQTKlz2ZPp+J4ComvIq++VggrUUZbVotQktsIHG9PWKbrdqVTbp/30Esx0emdb/LvEZ0iGSl/IrwSM4z+NC1NwLk2oPWoskFlg0MOF2whsDljg8wAo1TXjy9H6R21bpxJWFB1AklDkciYPt/MGq/YIIBhX3MU2mx6FR5vp9gXq8tc2VB3fZmld7oP4Kk4ErAHD0CBbeh5Rbx1+Y1f9n+7JTF4bVbSJh4/CN6Blbg4C2FgaDcePOk4S5EjnbJWD2sZwD58AANX2m6pqI+DCEfYWdSMWtt1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHreOrxHmeQscue0UYzAUvLaEA5x2VQ2tDaoVTf6vR0=;
 b=Y6J7dLe3Bv6QXEFDj2Dv8aqd6p2Q3vWX2094cjd9tdaeMX6vHcq0M/xmdqHRS0gCa8NRgCxb4vzk76n1uiRGLMM23Oc9+dxYsAtxazwqKphKxlWlHIeJmE+u2E30TvDc72k0UrTxkaAor+Nf+H9tQzzxWGGzvpbxnWWdFkah/9+5DRipGs2S7fv023fxSmuMZtzfc45mpM9LvvN+ehc8Bp3n5Ue0kFlBDutcQSyesMvvhyDPWRu5BrmotvPEbMSpf/qcpc1fnngxFR7kFjfaNxbB2ACm+GrcOqqNq+XDIei5ESPsjNqBAEPSS0IIe2Cthvn/lPM+3nABOrkf00VJfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHreOrxHmeQscue0UYzAUvLaEA5x2VQ2tDaoVTf6vR0=;
 b=Pk0fRJ5l0cwtD8YsmKLHbSOJOYWr/ClDW1npDFvUJyo//FBFSEGnvPi+UXz65p56S5KgRjviXRwUCdV//QwQAN7d3004baNUnl+uIe5V/7SLOL3DTHa5A8EMPLRWcuhjn1JH0OXyqE3JRZV2ZP98yrETbwwIJLCQV1Kv3LZFdMrpBipCGUs1kszEJAr4Al5rz7UYKBB7lX3yEBXFWbq+HVRBb+/9O8IqOSX6muNlPn0JSe19K/muhbfUsTiUS4hf27bEH7Q+FwkECbQ5JOVPvLAgsTRFOB5HEAFKzbd4vduPVZgpC+vBdR5no/X40lWYrCOpmx76AvXoQMEy1PqDLQ==
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by SJ0PR12MB6687.namprd12.prod.outlook.com (2603:10b6:a03:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 13:57:27 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::982f:232b:f4af:29ec]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::982f:232b:f4af:29ec%5]) with mapi id 15.20.6609.022; Wed, 19 Jul 2023
 13:57:27 +0000
From:   Benjamin Poirier <bpoirier@nvidia.com>
To:     David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v2 4/4] selftests: net: Add test cases for nexthop
 groups with invalid neighbors
Thread-Topic: [PATCH net-next v2 4/4] selftests: net: Add test cases for
 nexthop groups with invalid neighbors
Thread-Index: Adm6SPOwIKYdSXmxeUyme8WchlbtrA==
Date:   Wed, 19 Jul 2023 13:57:27 +0000
Message-ID: <20230719-nh_select-v2-4-04383e89f868@nvidia.com>
References: <20230719-nh_select-v2-0-04383e89f868@nvidia.com>
In-Reply-To: <20230719-nh_select-v2-0-04383e89f868@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR01CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::41)
 To MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
x-mailer: b4 0.12.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4373:EE_|SJ0PR12MB6687:EE_
x-ms-office365-filtering-correlation-id: b927cd76-6496-43f2-22e8-08db8860162e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YbBlhdjsajkkNGTzG6GYm6OJG5xLZ2wfMUzLsoEohLFkyPJiUHtDdsPdk6Jc929t8qD6j3wzR5scFAlbSpota3L322NKlArs3GNXcuIkbCRzGpqbhTsTtI0yRjjHJAAySRVfrl+6AiA3S+FNZW76hRhQUPZOnnouz0FE1JrZK81sxwlhotYZTrx9yYxoafWZJk/9bl+l58EviyyWfWvoZpDdYNf+jdwh9bN6CsmUY3uUZjB42kxMYKSIBOSgf90tSw7DtLedsbrO/pfvvnjVSBKY9CShFhXoyPpTt97OQ4SCvIVG/NEND/lSbElGSw2EiO7sochBgtQ0/hZYcg5yVhtxbnF3+KZbA03LE5+8Am2Y92EIdFYjL8quw/TzpYzpYd2399VcuEJYuUk6CwD0bpkAUSRMtOKe5RhkaUnvlw6eE0j3obXbJvdG0Cvbq1bPUtwuL1dXcv/mG+HvDPen8xWbOFuuiQy3XEjfLKeoEqvj01v7q1GDCEQLchk2aAfkLUQMiqJUoEC6qw6Rr6WuLK0hZaeqc5/1vbmrBh1T8Odp9Sv3CP5AYUTrFKK7d8wo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199021)(71200400001)(38100700002)(122000001)(2906002)(6512007)(6486002)(2616005)(83380400001)(36756003)(186003)(6506007)(26005)(86362001)(64756008)(478600001)(4326008)(66446008)(41300700001)(8936002)(8676002)(54906003)(110136005)(66556008)(66476007)(316002)(66946007)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nkh6azRhdHFLNGtyV25WMURXd0orTTNucFFaTHIzRm1KWU04QlhTci9jbFkv?=
 =?utf-8?B?NE5QWVl1dE5BbDBWNk9JREl5L0ZHYnBDQzM5UTFYVHltYzU0alVuMlFxd2FT?=
 =?utf-8?B?Slk5c1EwQmRMeWU5UklzRXZ5V21vQXR3akdGNFV4aXZtSEpseSt0ZUZWeXEx?=
 =?utf-8?B?VkhCZFZTTk5vbWM0Y2RRb203dHpYVmlOR2lDdEYyRnVYM0tsLzlacnVSay9w?=
 =?utf-8?B?eVJtdXZqMi9kUk5MV3FDaWgvOTdISGh1L2tKOHlqdDgwb2loQWVjVW4xK1Nm?=
 =?utf-8?B?aklsNDE4R0xjYWZrUG9UdVovYjBaZjR4SHhPUks5aC80MXVXSmw0NmlsRG5H?=
 =?utf-8?B?OHMzQTc0SnFqS2lSbVV2UVhvV2JvRCtxZ1hJVElMTGhjL1VYeXdqVUtnTEg4?=
 =?utf-8?B?Ylg4YThoWmtjYTFYbzVKaHNDM1cvenMrcU1GQ1Z4My9jUWlaLzQ4MUJucXZs?=
 =?utf-8?B?ZkJTWU5Wc0t5SzVxTEphRlRBelh4MTVIWEk5VXgrbWZPVW8rN1c0SE5wc1lq?=
 =?utf-8?B?WG9aQ0s4Q0QxZ29EajdSUWhuVkZOSlFrcFhYbERDbjBGWFYycnpVaE1PT1Bx?=
 =?utf-8?B?VDEzaHhFTlpNeCswa0k2eURkLzk1OE5DVkg1bndLcFd1a1R6SFRYT1JPWWlp?=
 =?utf-8?B?R1JhQ2g0Z2JVWHpQcXhZZGkxMThta2MycW1wVFNGUjdJT2FWZjhRZGV2dXIx?=
 =?utf-8?B?Y2FEWUVOUGRLSHp2VnZTVlNEa1k4WTR6WUpUc2QrNklKZ2tqdTV2cXd6WWJn?=
 =?utf-8?B?YlhibEUxbThHUG91Y1J2MCtHM1FqeU9tcTJaTEU4QkZoMFVWWHpPRk5MWm84?=
 =?utf-8?B?SEtVZHJkYjBMZ0hIT3hEblE3czNTM0dhNTdCWTd5c2JHRVJhaU9VdDZ2dCth?=
 =?utf-8?B?elNLYmUyTEJ4SG8vbFB2azhBTThBUUtVT1JwTEdrajdsS0ZSbVJBRXJreWtB?=
 =?utf-8?B?Sy84Y0FRTm51MVRaeWZTdE8zWnNJWDVHbHluOHVKWXFvbHdsMDQvbHlKdUgw?=
 =?utf-8?B?ZE8wNEJSVmlKU25IcHd5MXF0UWdYTXNEZmN1VVk1by9FQzJ0SXRJQ09UQjdj?=
 =?utf-8?B?TStwNzRibjBMNXVrNTNOZktmcjR6WHFnenFIR3RGMDE1aE4ySzMyeVU2bmpS?=
 =?utf-8?B?UmN4K3pOL1JvZjZXbUNEQTMwYktiNnVxZTExT016MldnZlBBMDJLNjdkSEZO?=
 =?utf-8?B?SGFsdWJQaXdlc1ErVFMxQUl0bTlBZUdHeXZPV3I5L01DSFllSHZocmRiUWZG?=
 =?utf-8?B?emxZa2dnUVl4ZmZGQllzNFBZY0M2Q2x1eVFjOXV3a25HeXVaK0w3UE5EOUpt?=
 =?utf-8?B?cWRhbzJoT1dic3o4TXpWcmxQRlRpd1NmcFBoeUFJb2VFaS8vZytaUXpCWjA5?=
 =?utf-8?B?dzFXZzlkR0Q3dWhXcnVYQkYwdzJXdWtsdTFEZzFXcUFOY3lmZm0wdjJTR0hZ?=
 =?utf-8?B?aGx2bDc3TlI2M21jZDVybHdSTVJ1MmhVOWNraGhxRm92Q0VLVDNPWmFSVDFQ?=
 =?utf-8?B?N0V1cldYQkFZWnRWYnIvR0xRTU8yQnpvVDdUYlRsSy9VMEJJUFIwKzJobitk?=
 =?utf-8?B?UDc1MG51b3B1c1k1Ui9FSGNMVWdYZ1JPOGtMeUlVamNXN2tnYXdUREYrMlF3?=
 =?utf-8?B?aG5RZnZpM28yQ3huSERBUTVGOEE3S0VoSE1mY2Vnb0VmWUI0M2lNc3orK245?=
 =?utf-8?B?SmNPVkY4R1A5YWI4ejFhWUVIS1FOcjZvaHh4MkJrRDVsWW5sNUR6bWdYd1hZ?=
 =?utf-8?B?RGxYUTNkSHFqM3h1amJIVUt1VXFEcDhNbStJZVVHRXNYTG8reEw0aGZZaU4w?=
 =?utf-8?B?VWtFdUQ3eFkyTG1jUEMzeUQ4YTZML1d4QlJpTWc4UWl1UzdyU3A0dml4MjRm?=
 =?utf-8?B?T2NSQk1ac3ZjREpyN0VOSEJ0eGVoMWhGWCtsODdUR0lneW1oVmJLUG5UckVk?=
 =?utf-8?B?UUJoclI0ZmM4MWZzQlpXdG5MWTNzQWhtM1ZXbjZGNlIwTHZzRmNXV3ZtYmFL?=
 =?utf-8?B?ZXg2WGNYY0N4dGFvYW5HbjNyM1M2dHpsYkMxY1I1RmdEdmRKc1FZNTk2eWt5?=
 =?utf-8?B?aFYxL1hhTDY2c0sraDlQd0xNR1dSNnd3Y21raWdydk4rQXpnSzBGM2FwWDBl?=
 =?utf-8?Q?2+I2DGTC8RLfe8vdI6PrDc/+w?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB69AB1491643B428670AFB4EC1E4B1C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b927cd76-6496-43f2-22e8-08db8860162e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 13:57:27.3386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: opR0o+KslADtf3gXgBq+ILajGfBVh4AlIMKsae1jbjrcMtSFeWIXQkNbpXUoZAMX9sfpoZSbej1/0uawRbRptA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6687
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

QWRkIHRlc3QgY2FzZXMgZm9yIGhhc2ggdGhyZXNob2xkIChtdWx0aXBhdGgpIG5leHRob3AgZ3Jv
dXBzIHdpdGggaW52YWxpZA0KbmVpZ2hib3JzLiBDaGVjayB0aGF0IGEgbmV4dGhvcCB3aXRoIGlu
dmFsaWQgbmVpZ2hib3IgaXMgbm90IHNlbGVjdGVkIHdoZW4NCnRoZXJlIGlzIGFub3RoZXIgbmV4
dGhvcCB3aXRoIGEgdmFsaWQgbmVpZ2hib3IuIENoZWNrIHRoYXQgdGhlcmUgaXMgbm8NCmNyYXNo
IHdoZW4gdGhlcmUgaXMgbm8gbmV4dGhvcCB3aXRoIGEgdmFsaWQgbmVpZ2hib3IuDQoNClRoZSBm
aXJzdCB0ZXN0IGZhaWxzIGJlZm9yZSB0aGUgcHJldmlvdXMgY29tbWl0IGluIHRoaXMgc2VyaWVz
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBCZW5qYW1pbiBQb2lyaWVyIDxicG9pcmllckBudmlkaWEuY29t
Pg0KUmV2aWV3ZWQtYnk6IERhdmlkIEFoZXJuIDxkc2FoZXJuQGtlcm5lbC5vcmc+DQotLS0NCiB0
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvZmliX25leHRob3BzLnNoIHwgMTI5ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMTI5IGluc2VydGlvbnMoKykN
Cg0KZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9maWJfbmV4dGhvcHMu
c2ggYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvZmliX25leHRob3BzLnNoDQppbmRleCAw
ZjVlODhjOGY0ZmYuLjU0ZWMyYjdiN2I4YyAxMDA3NTUNCi0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL25ldC9maWJfbmV4dGhvcHMuc2gNCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L25ldC9maWJfbmV4dGhvcHMuc2gNCkBAIC0yOSw2ICsyOSw3IEBAIElQVjRfVEVTVFM9Ig0KIAlp
cHY0X2xhcmdlX3Jlc19ncnANCiAJaXB2NF9jb21wYXRfbW9kZQ0KIAlpcHY0X2ZkYl9ncnBfZmNu
YWwNCisJaXB2NF9tcGF0aF9zZWxlY3QNCiAJaXB2NF90b3J0dXJlDQogCWlwdjRfcmVzX3RvcnR1
cmUNCiAiDQpAQCAtNDIsNiArNDMsNyBAQCBJUFY2X1RFU1RTPSINCiAJaXB2Nl9sYXJnZV9yZXNf
Z3JwDQogCWlwdjZfY29tcGF0X21vZGUNCiAJaXB2Nl9mZGJfZ3JwX2ZjbmFsDQorCWlwdjZfbXBh
dGhfc2VsZWN0DQogCWlwdjZfdG9ydHVyZQ0KIAlpcHY2X3Jlc190b3J0dXJlDQogIg0KQEAgLTM3
MCw2ICszNzIsMjcgQEAgY2hlY2tfbGFyZ2VfcmVzX2dycCgpDQogCWxvZ190ZXN0ICQ/IDAgIkR1
bXAgbGFyZ2UgKHgkYnVja2V0cykgbmV4dGhvcCBidWNrZXRzIg0KIH0NCiANCitnZXRfcm91dGVf
ZGV2KCkNCit7DQorCWxvY2FsIHBmeD0iJDEiDQorCWxvY2FsIG91dA0KKw0KKwlpZiBvdXQ9JCgk
SVAgLWogcm91dGUgZ2V0ICIkcGZ4IiB8IGpxIC1yZSAiLlswXS5kZXYiKTsgdGhlbg0KKwkJZWNo
byAiJG91dCINCisJZmkNCit9DQorDQorY2hlY2tfcm91dGVfZGV2KCkNCit7DQorCWxvY2FsIHBm
eD0iJDEiDQorCWxvY2FsIGV4cGVjdGVkPSIkMiINCisJbG9jYWwgb3V0DQorDQorCW91dD0kKGdl
dF9yb3V0ZV9kZXYgIiRwZngiKQ0KKw0KKwljaGVja19vdXRwdXQgIiRvdXQiICIkZXhwZWN0ZWQi
DQorfQ0KKw0KIHN0YXJ0X2lwX21vbml0b3IoKQ0KIHsNCiAJbG9jYWwgbXR5cGU9JDENCkBAIC01
NzUsNiArNTk4LDExMiBAQCBpcHY0X2ZkYl9ncnBfZmNuYWwoKQ0KIAkkSVAgbGluayBkZWwgZGV2
IHZ4MTANCiB9DQogDQoraXB2NF9tcGF0aF9zZWxlY3QoKQ0KK3sNCisJbG9jYWwgcmMgZGV2IG1h
dGNoIGggYWRkcg0KKw0KKwllY2hvDQorCWVjaG8gIklQdjQgbXVsdGlwYXRoIHNlbGVjdGlvbiIN
CisJZWNobyAiLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIg0KKwlpZiBbICEgLXggIiQoY29tbWFu
ZCAtdiBqcSkiIF07IHRoZW4NCisJCWVjaG8gIlNLSVA6IENvdWxkIG5vdCBydW4gdGVzdDsgbmVl
ZCBqcSB0b29sIg0KKwkJcmV0dXJuICRrc2Z0X3NraXANCisJZmkNCisNCisJIyBVc2Ugc3RhdHVz
IG9mIGV4aXN0aW5nIG5laWdoYm9yIGVudHJ5IHdoZW4gZGV0ZXJtaW5pbmcgbmV4dGhvcCBmb3IN
CisJIyBtdWx0aXBhdGggcm91dGVzLg0KKwlsb2NhbCAtQSBnd3MNCisJZ3dzPShbdmV0aDFdPTE3
Mi4xNi4xLjIgW3ZldGgzXT0xNzIuMTYuMi4yKQ0KKwlsb2NhbCAtQSBvdGhlcl9kZXYNCisJb3Ro
ZXJfZGV2PShbdmV0aDFdPXZldGgzIFt2ZXRoM109dmV0aDEpDQorDQorCXJ1bl9jbWQgIiRJUCBu
ZXh0aG9wIGFkZCBpZCAxIHZpYSAke2d3c1sidmV0aDEiXX0gZGV2IHZldGgxIg0KKwlydW5fY21k
ICIkSVAgbmV4dGhvcCBhZGQgaWQgMiB2aWEgJHtnd3NbInZldGgzIl19IGRldiB2ZXRoMyINCisJ
cnVuX2NtZCAiJElQIG5leHRob3AgYWRkIGlkIDEwMDEgZ3JvdXAgMS8yIg0KKwlydW5fY21kICIk
SVAgcm8gYWRkIDE3Mi4xNi4xMDEuMC8yNCBuaGlkIDEwMDEiDQorCXJjPTANCisJZm9yIGRldiBp
biB2ZXRoMSB2ZXRoMzsgZG8NCisJCW1hdGNoPTANCisJCWZvciBoIGluIHsxLi4yNTR9OyBkbw0K
KwkJCWFkZHI9IjE3Mi4xNi4xMDEuJGgiDQorCQkJaWYgWyAiJChnZXRfcm91dGVfZGV2ICIkYWRk
ciIpIiA9ICIkZGV2IiBdOyB0aGVuDQorCQkJCW1hdGNoPTENCisJCQkJYnJlYWsNCisJCQlmaQ0K
KwkJZG9uZQ0KKwkJaWYgKCggbWF0Y2ggPT0gMCApKTsgdGhlbg0KKwkJCWVjaG8gIlNLSVA6IERp
ZCBub3QgZmluZCBhIHJvdXRlIHVzaW5nIGRldmljZSAkZGV2Ig0KKwkJCXJldHVybiAka3NmdF9z
a2lwDQorCQlmaQ0KKwkJcnVuX2NtZCAiJElQIG5laWdoIGFkZCAke2d3c1skZGV2XX0gZGV2ICRk
ZXYgbnVkIGZhaWxlZCINCisJCWlmICEgY2hlY2tfcm91dGVfZGV2ICIkYWRkciIgIiR7b3RoZXJf
ZGV2WyRkZXZdfSI7IHRoZW4NCisJCQlyYz0xDQorCQkJYnJlYWsNCisJCWZpDQorCQlydW5fY21k
ICIkSVAgbmVpZ2ggZGVsICR7Z3dzWyRkZXZdfSBkZXYgJGRldiINCisJZG9uZQ0KKwlsb2dfdGVz
dCAkcmMgMCAiVXNlIHZhbGlkIG5laWdoYm9yIGR1cmluZyBtdWx0aXBhdGggc2VsZWN0aW9uIg0K
Kw0KKwlydW5fY21kICIkSVAgbmVpZ2ggYWRkIDE3Mi4xNi4xLjIgZGV2IHZldGgxIG51ZCBpbmNv
bXBsZXRlIg0KKwlydW5fY21kICIkSVAgbmVpZ2ggYWRkIDE3Mi4xNi4yLjIgZGV2IHZldGgzIG51
ZCBpbmNvbXBsZXRlIg0KKwlydW5fY21kICIkSVAgcm91dGUgZ2V0IDE3Mi4xNi4xMDEuMSINCisJ
IyBpZiB3ZSBkaWQgbm90IGNyYXNoLCBzdWNjZXNzDQorCWxvZ190ZXN0ICRyYyAwICJNdWx0aXBh
dGggc2VsZWN0aW9uIHdpdGggbm8gdmFsaWQgbmVpZ2hib3IiDQorfQ0KKw0KK2lwdjZfbXBhdGhf
c2VsZWN0KCkNCit7DQorCWxvY2FsIHJjIGRldiBtYXRjaCBoIGFkZHINCisNCisJZWNobw0KKwll
Y2hvICJJUHY2IG11bHRpcGF0aCBzZWxlY3Rpb24iDQorCWVjaG8gIi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLSINCisJaWYgWyAhIC14ICIkKGNvbW1hbmQgLXYganEpIiBdOyB0aGVuDQorCQllY2hv
ICJTS0lQOiBDb3VsZCBub3QgcnVuIHRlc3Q7IG5lZWQganEgdG9vbCINCisJCXJldHVybiAka3Nm
dF9za2lwDQorCWZpDQorDQorCSMgVXNlIHN0YXR1cyBvZiBleGlzdGluZyBuZWlnaGJvciBlbnRy
eSB3aGVuIGRldGVybWluaW5nIG5leHRob3AgZm9yDQorCSMgbXVsdGlwYXRoIHJvdXRlcy4NCisJ
bG9jYWwgLUEgZ3dzDQorCWd3cz0oW3ZldGgxXT0yMDAxOmRiODo5MTo6MiBbdmV0aDNdPTIwMDE6
ZGI4OjkyOjoyKQ0KKwlsb2NhbCAtQSBvdGhlcl9kZXYNCisJb3RoZXJfZGV2PShbdmV0aDFdPXZl
dGgzIFt2ZXRoM109dmV0aDEpDQorDQorCXJ1bl9jbWQgIiRJUCBuZXh0aG9wIGFkZCBpZCAxIHZp
YSAke2d3c1sidmV0aDEiXX0gZGV2IHZldGgxIg0KKwlydW5fY21kICIkSVAgbmV4dGhvcCBhZGQg
aWQgMiB2aWEgJHtnd3NbInZldGgzIl19IGRldiB2ZXRoMyINCisJcnVuX2NtZCAiJElQIG5leHRo
b3AgYWRkIGlkIDEwMDEgZ3JvdXAgMS8yIg0KKwlydW5fY21kICIkSVAgcm8gYWRkIDIwMDE6ZGI4
OjEwMTo6LzY0IG5oaWQgMTAwMSINCisJcmM9MA0KKwlmb3IgZGV2IGluIHZldGgxIHZldGgzOyBk
bw0KKwkJbWF0Y2g9MA0KKwkJZm9yIGggaW4gezEuLjY1NTM1fTsgZG8NCisJCQlhZGRyPSQocHJp
bnRmICIyMDAxOmRiODoxMDE6OiV4IiAkaCkNCisJCQlpZiBbICIkKGdldF9yb3V0ZV9kZXYgIiRh
ZGRyIikiID0gIiRkZXYiIF07IHRoZW4NCisJCQkJbWF0Y2g9MQ0KKwkJCQlicmVhaw0KKwkJCWZp
DQorCQlkb25lDQorCQlpZiAoKCBtYXRjaCA9PSAwICkpOyB0aGVuDQorCQkJZWNobyAiU0tJUDog
RGlkIG5vdCBmaW5kIGEgcm91dGUgdXNpbmcgZGV2aWNlICRkZXYiDQorCQkJcmV0dXJuICRrc2Z0
X3NraXANCisJCWZpDQorCQlydW5fY21kICIkSVAgbmVpZ2ggYWRkICR7Z3dzWyRkZXZdfSBkZXYg
JGRldiBudWQgZmFpbGVkIg0KKwkJaWYgISBjaGVja19yb3V0ZV9kZXYgIiRhZGRyIiAiJHtvdGhl
cl9kZXZbJGRldl19IjsgdGhlbg0KKwkJCXJjPTENCisJCQlicmVhaw0KKwkJZmkNCisJCXJ1bl9j
bWQgIiRJUCBuZWlnaCBkZWwgJHtnd3NbJGRldl19IGRldiAkZGV2Ig0KKwlkb25lDQorCWxvZ190
ZXN0ICRyYyAwICJVc2UgdmFsaWQgbmVpZ2hib3IgZHVyaW5nIG11bHRpcGF0aCBzZWxlY3Rpb24i
DQorDQorCXJ1bl9jbWQgIiRJUCBuZWlnaCBhZGQgMjAwMTpkYjg6OTE6OjIgZGV2IHZldGgxIG51
ZCBpbmNvbXBsZXRlIg0KKwlydW5fY21kICIkSVAgbmVpZ2ggYWRkIDIwMDE6ZGI4OjkyOjoyIGRl
diB2ZXRoMyBudWQgaW5jb21wbGV0ZSINCisJcnVuX2NtZCAiJElQIHJvdXRlIGdldCAyMDAxOmRi
ODoxMDE6OjEiDQorCSMgaWYgd2UgZGlkIG5vdCBjcmFzaCwgc3VjY2Vzcw0KKwlsb2dfdGVzdCAk
cmMgMCAiTXVsdGlwYXRoIHNlbGVjdGlvbiB3aXRoIG5vIHZhbGlkIG5laWdoYm9yIg0KK30NCisN
CiAjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIw0KICMgYmFzaWMgb3BlcmF0aW9ucyAoYWRkLCBkZWxl
dGUsIHJlcGxhY2UpIG9uIG5leHRob3BzIGFuZCBuZXh0aG9wIGdyb3Vwcw0KICMNCg0KLS0gDQoy
LjQwLjENCg0K
