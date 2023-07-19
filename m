Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE25759782
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 15:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjGSN5Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 09:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjGSN5T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 09:57:19 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25C71724;
        Wed, 19 Jul 2023 06:57:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Htr0M8fqOPdo0ZQUmDux4aWNKFM+AFgfaKgq1DoVvNhCXmbh0mIdvx6npmjO/Y25+maYRXLmqYd/XNYS7EjRKh/Kv3y/6r8Vy77sPUUtthJKd3aQL8C5AEynxzUdfgBE2Inx7xF7vvoHcGVgs0zWFN7qT7S5M3/CFbrflAqrZ/o7VT+xrt6lf/mBALVF+2ao5iqXStJL99GO+7km4gljmGzsj4QDxPTtaMD6CsyiVmT2TPTY30KcD5iB6vrcfp83cNTjopMqe2mikN2krNK3Czp9z5B7YJPvUdhwYve5H8VDLMNXISlLHNzoTPEMvEAf4oRse5zf1qzR5bHOpjlwCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5G7duKyBRwn33i/M0Orq92l5Mbix0iGcQuUUTFgRYXY=;
 b=AcDE73cdI6ULWf3Yvbard2MwmPbHfHuQCIIbXUdOrebJchCAHn/xM+/RlMBxv+JRKNVBIujK0dTe73MFX5RkBA7dsYFMRYG8jsGAu0M/hkRrPE5DXgKaOuPaQXy4c3doRGXU2yaHHUAHS5mF/4Qyjh4ubzA7FEIvXh4B4eY21ulGcTDpye1f7c3v7QUrz7/y7nMg6RvU3Hq312sqPFDpv0Y+AFAe6IZQFqRIuBQ3wugNqTIZt+CQku5oAJ8x5+hU53uYK4qLvnu9Xi33O0KethgnzC3kXx6jivf5R/2SntUpfKEJybNGC2DXj13HssoW2xnOChE+H1gmLkGTb5Cl5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5G7duKyBRwn33i/M0Orq92l5Mbix0iGcQuUUTFgRYXY=;
 b=Kw7AudvM5WaA+os5yY7N81/jEeJ4mxqKA1aakoTkPa8LLFAMSAENs1dQ6fr2lu3C8UGO3VqfKEUd9Q2qGRGVNWAaS7FozfE+DAEj6skE4Ol1WQbJK5MIV3xPrjhlMjaHNz8eIA5kYw2nBgfE9P8bm8ylvJ4972qoy1BYkYqE99kAbK3ML6aa4YUsfZ6u5OUtDP8TfrbDPP36psHW59GcQeLckYAG02ojWjC+zRTdQEmMsjf4SIR8i0dt5BojrDxv30uxOOkILBe6sEY3lkDTxddwoIqcmNwgRV/5uHUFLkkrascvr9CcvQ9o48CeIkoVlTPtmrM7RFpmozbmYvm5aQ==
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by SJ0PR12MB6687.namprd12.prod.outlook.com (2603:10b6:a03:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 13:57:16 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::982f:232b:f4af:29ec]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::982f:232b:f4af:29ec%5]) with mapi id 15.20.6609.022; Wed, 19 Jul 2023
 13:57:16 +0000
From:   Benjamin Poirier <bpoirier@nvidia.com>
To:     David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 2/4] nexthop: Factor out neighbor validity check
Thread-Topic: [PATCH net-next v2 2/4] nexthop: Factor out neighbor validity
 check
Thread-Index: Adm6SO0RjClS2VcqDUm7NVFWUjJK/g==
Date:   Wed, 19 Jul 2023 13:57:16 +0000
Message-ID: <20230719-nh_select-v2-2-04383e89f868@nvidia.com>
References: <20230719-nh_select-v2-0-04383e89f868@nvidia.com>
In-Reply-To: <20230719-nh_select-v2-0-04383e89f868@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXP288CA0030.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::36) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
x-mailer: b4 0.12.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4373:EE_|SJ0PR12MB6687:EE_
x-ms-office365-filtering-correlation-id: 843f0ad7-5f98-4caf-ac0b-08db88600f91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DglcoChecyAPBKHmC0sIjJko9m9ecUcVX/Qk08GIKSVd53q+qmNG0up0s9Fh5nLvCujlncTzopn/iw5d40886SN7hK/DreDvfESEG3z6NVO23FvjB09k4i9hV4YVUEpbjkpvrsiWS2vyJVckxRN2TUNbjZq44FfrcM49QGeVrl1uRX4lMkewM22HuFhdYE9Yu9dchRR+Ymh2xLl+GLXUqgnSBhjkIjjoCqFmsySKVdsB9bw/E2weueEmfRL15RkTHm4rfmjl8cuqPrA9Qpm0a59ioWjyxKXPXOYGQAr4fR3VPu04oNMPtkc0pAs6a96b0ki8FcJqzRzkB9k6SkVl8wfI+ZAUWhewKTJmmSR0vdG+ZvT3WjlqXx/8HrvLIEDPmS9tpaIfP5fQcaeAnQNhRZ3Px4LRQS5iSgRilH4rdfBBAXnz6UKUXj6GUPcdGSBrBe1oROOfW27KdeUAW1jtUsADDey66fxuJ3nN8wmmek0KYvfQ00mFnSXRfjcSCCNI0T9FWNIaE3QUg9plVys8mqxUxLRdlHdifyI6DzZ2DLZgT/52ovflImshJHxRSiU4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199021)(71200400001)(107886003)(38100700002)(122000001)(2906002)(6512007)(6486002)(2616005)(83380400001)(36756003)(186003)(6506007)(26005)(86362001)(64756008)(478600001)(4326008)(66446008)(41300700001)(8936002)(8676002)(54906003)(110136005)(66556008)(66476007)(316002)(66946007)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFVueEtJU3R1RzFjems1NXE1eXh6MkJPRWpodHlHc1RpbmcxdXZRRXRlVVV2?=
 =?utf-8?B?czR1UTIrdDY3eW94T0JNOEVtK2JRR0lqVUlOUDNJbTgzOU1xOEhlNVpSZ3NX?=
 =?utf-8?B?VjJ3RVc4bUtuVFVPVEZZeUVDekpiSkl1ZDU2QVFpTlhydFFnV3lnQzVTdWpU?=
 =?utf-8?B?bG5LaVB2UWpPT243SVUwU2ZuSjl5ZndIN3NjVWtMMGYxSDZQZElFTG1OdXg3?=
 =?utf-8?B?aUxyL09JVmxKVEJOSmtHd1B2ZjFBcmFPeVRLdWkrRnEvd2JRaEVQKzhOZk02?=
 =?utf-8?B?TG1lZHFvZkxXNWJGM1ZhYWJJZlNkUVVyaThyemVxOGh5K2xnMitRcTRCc0R4?=
 =?utf-8?B?Z1NPSUNKKy9qVlVacDRyZG5QUFp1MVBQNFhZdFYxQktRS3pwZEhJVTVId0hC?=
 =?utf-8?B?OWZUc01mai9ZSkNlNG56NHA2bjlTeFBGRy9mQzlpaTA2RUFTc0FzQmlyMDN4?=
 =?utf-8?B?U3dvcXF6Z2srQkgwWkdhdlVJTDZuUDQvaGU0T2tkd1U3UVJ2ZWNDcDhaZURp?=
 =?utf-8?B?Mkt6SVhvUUdVY1ZGSzAwOTNscnpJaER3Lzd6S1lqWGRnS0c0bytqajdLTlMv?=
 =?utf-8?B?cUN4SkJyK1RJb21jZkxKZ1RWVXg1VXEyb1RYc1FNREM5anlOSmFXK25RZGU1?=
 =?utf-8?B?NldOWUo5NWZzeklpYXpTN2JRMFhkSjcrRE1EVndJUzVVczdjczBWc2VJb3dj?=
 =?utf-8?B?R1RLNmdyVXpBcms5VVpQVmlUSWRGaWtmbk5CUGM1UlFVU21GT2pJejJpM2l4?=
 =?utf-8?B?WE5OYnZTV2dQcStoVWwvSjU0TmkzaUlvNlcxcDg0ejVoMU14aUtRVUF3U3Z0?=
 =?utf-8?B?eEZzZm5HTG16ZXBic0dwYWpzSEt3Y01RUEdkRmpYOGY5RkViVmtDTjBITTBw?=
 =?utf-8?B?bS9hK1IzeXBHSHpncmh0UHoxcEMyNTRFNzZQRmlIVUdFZVJQZmhMNlFCb0Va?=
 =?utf-8?B?VjI4RVNYZEtEOVNVRVMvKzJDOXVydnQyTlFMU2N5UmVDZFdCZUVtUTJrWmN6?=
 =?utf-8?B?QmhBelFjWlNxQUNzd2cvMlJFMjhQeGpzMEQ5TVptbUFJTEk5WERzcEl5cjcz?=
 =?utf-8?B?L3lNcGFVQmtJUWhQYXRVM2pGZ1U0alBTejgwbCtTekQvcDROdlFHbnRXTGtL?=
 =?utf-8?B?K1VpditSZE82VWlZWXBSTERNU3hYVC9CRi81NzkyNVV5ODZKSGdYMVQxczJt?=
 =?utf-8?B?Mk1OaFhzNElITkNFMUVhOWdrZEJUS2loNGliaUtyNXRUWUN6RDRZenpJRjJW?=
 =?utf-8?B?SFU4c1M0akxkaVdFYjdDUnIrQ2p2OWdKMUtOdkk1L0RZeTFIdmR2UXhmdTlQ?=
 =?utf-8?B?b3A5SFhkTXZKdmdHaTQyWmgrMDJvYXBMbWNwY1FaeGJweXU0dDc4MTUrTk43?=
 =?utf-8?B?QlNxMnNST1BydzUwa0hJc3k0SkVCVng5TmltbkNWT1hIMHlyYkhwRmtub1Zj?=
 =?utf-8?B?UkUzZzJ5SWdWN29IZWxSSmRla1RGaTgweDNSOWlNZ0pkczdFazNIdzI2REs5?=
 =?utf-8?B?NlE5SnJibGlMZVlrNXRIb2xWRHp4d1JlVEM1cktxbHZLTVFFLzcveWNhKzUw?=
 =?utf-8?B?VU40Ui8wMDA3b2NOaFU4WEMydFdQdysrVi9LTlFZdHo5eFVPY0VoZ2lCYms3?=
 =?utf-8?B?ejhoL0d3OWRzUGRUcHFlWmQ2dkk5cHZEVjFkalVMdW1Sb0F0bG1aR0F4NThp?=
 =?utf-8?B?MERrUk1nV1JBWlRyYytTNitsUU5XOXJhSnltaUlIL1UrNEtIUUhYZWRzWlNT?=
 =?utf-8?B?QzRjblJTTHIvV2hvbEVNUUZTY1NzamU0ak5CWnY2bXNpQ2RrVUZhZHJya1Fz?=
 =?utf-8?B?QkhrNUhJU0hPQUVtV2lNLzQveWVMY2cxd3RvTVp0TEJmYXpBa1AvbnBSUFhp?=
 =?utf-8?B?d01EV2lPZnNQVmJxaTFSeHBrQzk4YU9pQlBsRVFzZmk3cEpmN1FUamVoM01j?=
 =?utf-8?B?bTNBVHIzWXVodkxKQ1lSVmE1eTdmWGNOUDdLR0Jvc1RXdUVYaHNBL0tqNHRz?=
 =?utf-8?B?dHZYK2ptRS9TYks0YkZFSStBVU1LUjFKUUFVS2xBOGxSZ0hkdDh5ckg5RlI3?=
 =?utf-8?B?RnpXUjlBYXdWN1lCVzhMSE1STjFNYzByYytSUjdQTHJtSHE2c2x3SS9sZkFC?=
 =?utf-8?Q?tyQqRlXBxEud9YPiG9VY7l/aU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F768538C62DA6A43ACEAC6F63A9439D3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843f0ad7-5f98-4caf-ac0b-08db88600f91
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 13:57:16.2226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HhMQHGyVH8UioGs+m0raC7N9mhJ5qb4Y5F4ZGw1rsUXm8TPlDPKygFJ6Jc1+Q2UiMsx6S6WiwD+ueRTv6nTVww==
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

Rm9yIGxlZ2FjeSBuZXh0aG9wcywgdGhlcmUgaXMgZmliX2dvb2RfbmgoKSB0byBjaGVjayB0aGUg
bmVpZ2hib3IgdmFsaWRpdHkuDQpJbiBvcmRlciB0byBtYWtlIHRoZSBuZXh0aG9wIG9iamVjdCBj
b2RlIG1vcmUgc2ltaWxhciB0byB0aGUgbGVnYWN5IG5leHRob3ANCmNvZGUsIGZhY3RvciBvdXQg
dGhlIG5leHRob3Agb2JqZWN0IG5laWdoYm9yIHZhbGlkaXR5IGNoZWNrIGludG8gaXRzIG93bg0K
ZnVuY3Rpb24uDQoNClNpZ25lZC1vZmYtYnk6IElkbyBTY2hpbW1lbCA8aWRvc2NoQG52aWRpYS5j
b20+DQpTaWduZWQtb2ZmLWJ5OiBCZW5qYW1pbiBQb2lyaWVyIDxicG9pcmllckBudmlkaWEuY29t
Pg0KUmV2aWV3ZWQtYnk6IERhdmlkIEFoZXJuIDxkc2FoZXJuQGtlcm5lbC5vcmc+DQotLS0NCiBu
ZXQvaXB2NC9uZXh0aG9wLmMgfCAyOSArKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KIDEg
ZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
LWdpdCBhL25ldC9pcHY0L25leHRob3AuYyBiL25ldC9pcHY0L25leHRob3AuYw0KaW5kZXggMjcw
ODlkZWEwZWQwLi5jMTJhY2JmMzk2NTkgMTAwNjQ0DQotLS0gYS9uZXQvaXB2NC9uZXh0aG9wLmMN
CisrKyBiL25ldC9pcHY0L25leHRob3AuYw0KQEAgLTExNTIsNiArMTE1MiwyMCBAQCBzdGF0aWMg
Ym9vbCBpcHY0X2dvb2RfbmgoY29uc3Qgc3RydWN0IGZpYl9uaCAqbmgpDQogCXJldHVybiAhIShz
dGF0ZSAmIE5VRF9WQUxJRCk7DQogfQ0KIA0KK3N0YXRpYyBib29sIG5leHRob3BfaXNfZ29vZF9u
aChjb25zdCBzdHJ1Y3QgbmV4dGhvcCAqbmgpDQorew0KKwlzdHJ1Y3QgbmhfaW5mbyAqbmhpID0g
cmN1X2RlcmVmZXJlbmNlKG5oLT5uaF9pbmZvKTsNCisNCisJc3dpdGNoIChuaGktPmZhbWlseSkg
ew0KKwljYXNlIEFGX0lORVQ6DQorCQlyZXR1cm4gaXB2NF9nb29kX25oKCZuaGktPmZpYl9uaCk7
DQorCWNhc2UgQUZfSU5FVDY6DQorCQlyZXR1cm4gaXB2Nl9nb29kX25oKCZuaGktPmZpYjZfbmgp
Ow0KKwl9DQorDQorCXJldHVybiBmYWxzZTsNCit9DQorDQogc3RhdGljIHN0cnVjdCBuZXh0aG9w
ICpuZXh0aG9wX3NlbGVjdF9wYXRoX2ZkYihzdHJ1Y3QgbmhfZ3JvdXAgKm5oZywgaW50IGhhc2gp
DQogew0KIAlpbnQgaTsNCkBAIC0xMTc5LDI2ICsxMTkzLDE1IEBAIHN0YXRpYyBzdHJ1Y3QgbmV4
dGhvcCAqbmV4dGhvcF9zZWxlY3RfcGF0aF9odGhyKHN0cnVjdCBuaF9ncm91cCAqbmhnLCBpbnQg
aGFzaCkNCiANCiAJZm9yIChpID0gMDsgaSA8IG5oZy0+bnVtX25oOyArK2kpIHsNCiAJCXN0cnVj
dCBuaF9ncnBfZW50cnkgKm5oZ2UgPSAmbmhnLT5uaF9lbnRyaWVzW2ldOw0KLQkJc3RydWN0IG5o
X2luZm8gKm5oaTsNCiANCiAJCWlmIChoYXNoID4gYXRvbWljX3JlYWQoJm5oZ2UtPmh0aHIudXBw
ZXJfYm91bmQpKQ0KIAkJCWNvbnRpbnVlOw0KIA0KLQkJbmhpID0gcmN1X2RlcmVmZXJlbmNlKG5o
Z2UtPm5oLT5uaF9pbmZvKTsNCi0NCiAJCS8qIG5leHRob3BzIGFsd2F5cyBjaGVjayBpZiBpdCBp
cyBnb29kIGFuZCBkb2VzDQogCQkgKiBub3QgcmVseSBvbiBhIHN5c2N0bCBmb3IgdGhpcyBiZWhh
dmlvcg0KIAkJICovDQotCQlzd2l0Y2ggKG5oaS0+ZmFtaWx5KSB7DQotCQljYXNlIEFGX0lORVQ6
DQotCQkJaWYgKGlwdjRfZ29vZF9uaCgmbmhpLT5maWJfbmgpKQ0KLQkJCQlyZXR1cm4gbmhnZS0+
bmg7DQotCQkJYnJlYWs7DQotCQljYXNlIEFGX0lORVQ2Og0KLQkJCWlmIChpcHY2X2dvb2Rfbmgo
Jm5oaS0+ZmliNl9uaCkpDQotCQkJCXJldHVybiBuaGdlLT5uaDsNCi0JCQlicmVhazsNCi0JCX0N
CisJCWlmIChuZXh0aG9wX2lzX2dvb2RfbmgobmhnZS0+bmgpKQ0KKwkJCXJldHVybiBuaGdlLT5u
aDsNCiANCiAJCWlmICghcmMpDQogCQkJcmMgPSBuaGdlLT5uaDsNCg0KLS0gDQoyLjQwLjENCg0K
