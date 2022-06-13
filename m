Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDD2548380
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jun 2022 11:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbiFMJRL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jun 2022 05:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbiFMJRK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jun 2022 05:17:10 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120088.outbound.protection.outlook.com [40.107.12.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF6D18B00;
        Mon, 13 Jun 2022 02:17:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLOLazHYTSHiqjiydVjySKNH4Ike89mPc1iYI/F2OKo6MERBD7JM2CymoolbBbcSR5lP+0P3YWlJve4t5JQOe4AlumTiNMBCm9ErMPFyaAqybCKPUyZY9VGRW7wiCVZxZ4vLf6XiwO97G/4sKbmsrCi3qSW5H5fIAbLMpLudby4uHMokyJVGYF2Neb2I7hdfEzE6HQUiYLL9CHyPSz/ttZXAkKhHf5HKSa+eY2016HM4+HW6pErMXaqIMrQXUoPQssjDN42uuqRJO/qt6Wzh1r9gCxDx5EXCfyj+AxiC2FL6gtt0biA3FCQZLftM+a+6yYoiHsuk5kJ28wXBj4uctQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pL9BtOf5L0HqysI4/VCazndKu0ej9ckaaxy0qOu4Wng=;
 b=EIB7fAJ0F2jW7/PEhkSW3B/PJDkQqtUo8FCl2TBrDZGxstSTHz8qAEl8acIHneOFtBAvkbVYAeROOWfLxemIHtKek8s3qXpndDVk8p+XlAx9hXuFowSsNkpGHLDlD65IF5j3lpVDbKGJP0VYLknwIe7TeI+cOo3K+fFZ0wgvdQAuy4idy2zGzane+NkPbgv32yfIdtQdOBgDT5Ok1FhsxwCT0ojEu+XhDyYIQqdBccfx2ODdA9yjFDqx7fMJbTR+i4CqDzKn2Nk3lxzPVIoVmtMk5y05gZYbNXrzejU/bYohHAfFM6n+YUgBwSa2msRRE9pnvOyL2TaQq/d468L6eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pL9BtOf5L0HqysI4/VCazndKu0ej9ckaaxy0qOu4Wng=;
 b=zIR+XjelDeZQD/xz9ZZflCFDwSyrLGGEAU3maUZizVy3t9q2ezFcmDrjrUfeYS+j76TzC8k1FEbT1CF4mSSjOimSoxxcSV1fhA/TzUvreNv/V7lGPPp7GFKVXSpWxNSpZyoPekD+CohP4/x9gCK1F156Kf4XK7GCzgZKg5JAV6K73wp3QTLPwxx3lExPJz3YrXjZdMl9jSg0k3m0wyuoi5n83Es+ZditwxISTy4HUchT8+sb1BPDI+Jp8BcI0X5zhx95rxISJVMuiEZ/gXY75+WfhHehvvoYUJrAY+cWDqyo8TVdLygWidBj8JbkYzke8vd7+H2CapZRv8cAz6pWxA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB3599.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:142::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Mon, 13 Jun
 2022 09:17:06 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b15e:862f:adf7:5356]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b15e:862f:adf7:5356%6]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 09:17:06 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Sohil Mehta <sohil.mehta@intel.com>
Subject: Re: [RFC PATCH 6/6] pkeys: Change mm_pkey_free() to void
Thread-Topic: [RFC PATCH 6/6] pkeys: Change mm_pkey_free() to void
Thread-Index: AQHYfSNbq2f9fHUGa0mUBXLLqQ9kg61NEmwA
Date:   Mon, 13 Jun 2022 09:17:06 +0000
Message-ID: <af035c24-36f6-7d55-5be7-b52cfe26e2c6@csgroup.eu>
References: <20220610233533.3649584-1-ira.weiny@intel.com>
 <20220610233533.3649584-7-ira.weiny@intel.com>
In-Reply-To: <20220610233533.3649584-7-ira.weiny@intel.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c6adbe0-563f-42be-f289-08da4d1d7cb4
x-ms-traffictypediagnostic: PR1P264MB3599:EE_
x-microsoft-antispam-prvs: <PR1P264MB3599FABED3E95CCEA74908F8EDAB9@PR1P264MB3599.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +qFnlPMcz2sJeswo8Y/lpft3fkoi+tFbp3hnjTKco9KqIV7fn+ieFNEnbQhHEd2Dzrn5FoAeiox+E9tS8wxNLxvL1MU+3F6Rhss+XdbLiOnI6hYuPMwpOI6c84daSvLiPkx7Hx8oU3dWC2bFBoAa8a9x1l/xdTrbjvEDldWrU+5soNPrkph5kSU98tIwRyZ5pD1+k2DvZ/8VDBXPJddf719kjPhNhAjJpNS3vPxCTUASOhqARKKHglx01bQ7myS1uy6hs7wXp4QvxUrRgUnzh6iKVJHdIXe04brilqvABWpu02tapPCPxcxfqeP5YfMq7qtr8C51remlwHob4+4y8uFxWKoCtPEqH6oxYB3PEE0cZiHgWBhpqNa0MwFWVXu9Ba/kHQ/txWYM+wa96eA1UFt8CNEjYAXk0AFdLKUYKTBSLceCJ83bJyUtJAg7Rr08lz1k8Y7eBeGhVcyyCNoywlXm4Zs12UwzS4fco95YylMds3SDcO1lxbuJWZpGpuSjhy+GjeeUwQhj7lk4LT4pZO8RRYjJnjvyG5gm7mtTEUkYphp9y+oXJsmWmmV+Jwa3mLi9dzj6F5iQ/QlULawx7QJDZXmJKFhB8SoRdrNm2Yh098vNXNINmLLimoZ+E9kkipW6rNkAVwEJe55CDIUC3m+h2WT1vvA+4dRUbO3/iiajH8mTjAaWtX0qX07U+TwDvdB8EsdeVwULGzbGlPyjdbHKdrsmMZk+0Q+bdaBTPyQzo70GD1ACUoWFbjTmMEVuTNcSObrMiGs8Gg5xSYnOmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(6486002)(26005)(6512007)(4326008)(36756003)(91956017)(83380400001)(54906003)(110136005)(44832011)(71200400001)(2616005)(508600001)(8676002)(38070700005)(316002)(186003)(2906002)(122000001)(6506007)(7416002)(31696002)(38100700002)(86362001)(5660300002)(66946007)(31686004)(8936002)(66446008)(66574015)(66476007)(76116006)(64756008)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWlWUm1KMW1uL3lKVm4zOGIrTE9pNEV6am4wRllRajVmMVMrSkYxanQzT2U3?=
 =?utf-8?B?QzFpYUw4RURBS2NKOGd6eVJFZS9SSFhFU0RnQTcrTjhodjh5K0FOY2dVY25x?=
 =?utf-8?B?QnFBNEtVSHdzQkdsMzlWeFcvT1VSa1E5bzU1QUE1ZjlCSlg0NHBwRENJWkJr?=
 =?utf-8?B?K2NxWXk3QkJXYmZMVjh4bnQwZ3hiNWxwNUZjeEh0Q1EwVWZwc2pJaHU3OGsz?=
 =?utf-8?B?QUpUU0Vxb0dWNTU0WWVSUUNLd3U3OElIR1VkYk1DT1BNQTdLWVg1SG1GSmFx?=
 =?utf-8?B?RHZwdnQ1cUUzRFEvd3VXdHhSTWNOUExVdG01R1JKcWJ3ODJMTk9xd3ZIVmNw?=
 =?utf-8?B?cmxtdHJQdDBiQXdvNll5ekltSDQzWFBSWmlCcm5MVFUyUVA5bWc3QWZJMG85?=
 =?utf-8?B?ZHU3ZmxlRU5WdmtySGhTVTBBekRrOEdaaHZKUjhoTk1oMGJ0UUxKZzQzWS9X?=
 =?utf-8?B?NTBJUkorS2djSksyYS8wampaTWJka2QxM0pTYmFnSXRpQTRQQklxL0JSTUg4?=
 =?utf-8?B?ZEpJSmszeTk5emVYS2JXK29Ca1QwQ3Q1RE15OWM0T01jOXcxTk5MVUFsV3Mw?=
 =?utf-8?B?ckYvb1F1N3V1L0VoUjd5WkUyLzZDYnpWTUNhSXZFUTZQdUpheW80UzJNTHlO?=
 =?utf-8?B?RGI4dytMNEZmUGwxaUh5MjF3RmdlODhPUWE4K2l1eVdZQ2VpMDhZd1lweWpZ?=
 =?utf-8?B?eGs5cmFvMWREd3ZKeTRuQ0FqdVBXK0ZZYzAzQ0FzNGgvay9kdVVQZGtvUkk3?=
 =?utf-8?B?M0FYN2twWm5JK1dNVmZPS1RiMW95QmpLNS9BMnQrV3h4TUYrTy9zRDRKUVAz?=
 =?utf-8?B?N0ltYnNlN2pXcHB5SkJHd2V0TzFHeENLMXZXVXRad3BQeTdpRFR3cDhOSUNB?=
 =?utf-8?B?S3JEeXgzYkRiaVNuVEZkdWVXZGZXTVE2QThTQkwyVDRvSDdXc0drbWJDQlNr?=
 =?utf-8?B?NWljR0RBczJBK2NnM0dFcnE1THZQUlU1Wi9rcHRtSUpqQVRkTDAwYk5zZ1M0?=
 =?utf-8?B?emM5ZVVoeG43ZXJ0OU52K21kVnNRZENBR3NIMklwQ3JUYlEwbGhKZW54Vml4?=
 =?utf-8?B?TWJSamlqR2dDRXk5U3hydVB2aWJ0SHpjVzRhRkdkdmZhOHZiODJJWk1VUE1E?=
 =?utf-8?B?eG5KcFUxOWhVc3hub1N4V0x2bVdxRnB0K0NiVjFzbmw1Zmt1OFdQU3lHcW9L?=
 =?utf-8?B?bDZBb2FiTFZGSFdFYlkzT3k5QkFPc2o2SC84Sit6MGgwMERaaytVRXRJSU96?=
 =?utf-8?B?b0hwaFA4N2lBejZtdWhCUTMwN21aUEgwa3YwVDNJQ3dVUGVhSU5qclVCK1FX?=
 =?utf-8?B?eTdIdlNmT0F0ZWRWSExCcXk2S2dXT0cwMzAwa2IzelozdDdTRC8ybXpBSjI0?=
 =?utf-8?B?VVExdXJqV0NwOWpoS1lYK00zeklHcXRyaUxtbjFnc2E3eG9aMzJ1SEZKOHpX?=
 =?utf-8?B?UTVxeUJCRDFQRUVtRHF2Mno2eUJYTDVKb2FzNkowYkFhTXVZN0hCbm0wY3Ra?=
 =?utf-8?B?MzlNMzN5MlhSQU4xMU1HcGR5R1lvbU9uWFI3NU1OS0xvaDdFK3BLMHJpNk1V?=
 =?utf-8?B?MXVuT0RLWTRNU0ZoQlFZKzNwcHVoY0JaRGJrZjhrQlNybWtIUGpWYWFzR3NG?=
 =?utf-8?B?TXd4UEF1VEpJMkxkMG1zRS9VbGVYUERncHRscVZndyszdk5sTGowekRMYXpO?=
 =?utf-8?B?Y2FaUjZ1V2k5OVdKZ2N2OXlRVThveEh2dzAzZ2Yzb0VVa2NESE5jaG9sNVp3?=
 =?utf-8?B?NENib29ZeFBKcnluUms0Y1h4WURpMmkxaTEvdnA4MEovV1psUDBkcW1OVzVU?=
 =?utf-8?B?SkxZL28xb3E3ZWdaYWRBQldmcWQrbGZTVFhwa2dEbGJOZUUzQWNJaDlTbWN1?=
 =?utf-8?B?Tml0Z3dVUDBCako4TnY3SmMxMDVmWDdheWZ1c29rWGZhZnlnU0JqTHhXN0FY?=
 =?utf-8?B?VDVNS3loUGdTMko0M0xoSE9vM0VGK1UyTVNGZ2ZFR05tb2xBWTZyOHZRYyta?=
 =?utf-8?B?ZUZNUkQydEVIb3NLNGx1RWtFQzIvVDc3YVhGMmhieE9yQXZyVUhxblVseU9H?=
 =?utf-8?B?dkV4NzdwOGdmZTJIVUxNVjcrNjVTQlZSc2NIOHpqaVl3MkpJNllaT0l3clp6?=
 =?utf-8?B?NlpodG91NWZyQVRFOHJaSlpoaFFLWDVyL2w0Yk5FU0tacmR6blJ6Y3U0NXNX?=
 =?utf-8?B?N1NocDltUzhwVy9yR3NBVUxreU4vc1VxdUpCaWVlcjZZcEJyNnR5V0s2T1NX?=
 =?utf-8?B?SGgvdGUzeHR3U0JVSWFsWkNYT3VrQlhHd2ZBNm5xZzdKRWhwZkdpTW1UTlhZ?=
 =?utf-8?B?cjk5RC9OQlhiU1NBMnRaTndLdjJkSllyY3ViNGpNNDFIR2ExTy84VWZFVDha?=
 =?utf-8?Q?Bpz0d6eisNWS41wizrywWL5KMtT2QqG4bmog/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06471B3461B69040A94F9FB2E8492542@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6adbe0-563f-42be-f289-08da4d1d7cb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 09:17:06.7813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +3xAzh7NspQOgTxGDJF2qwfvJ0cTruVtURvsd8t57HtefL3Pnt6nAUvKTA3Tu7LanwpNSO00DJRSbLKReA94GerAr26ENWiNFSr87WyuS/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3599
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCkxlIDExLzA2LzIwMjIgw6AgMDE6MzUsIGlyYS53ZWlueUBpbnRlbC5jb20gYSDDqWNyaXTC
oDoNCj4gRnJvbTogSXJhIFdlaW55IDxpcmEud2VpbnlAaW50ZWwuY29tPg0KPiANCj4gTm93IHRo
YXQgdGhlIHBrZXkgYXJjaCBzdXBwb3J0IGlzIG5vIGxvbmdlciBjaGVja2VkIGluIG1tX3BrZXlf
ZnJlZSgpDQo+IHRoZXJlIGlzIG5vIHJlYXNvbiB0byBoYXZlIGl0IHJldHVybiBpbnQuDQoNClJp
Z2h0LCBJIHNlZSB0aGlzIGlzIGRvaW5nIHdoYXQgSSBjb21tZW50ZWQgaW4gcHJldmlvdXMgcGF0
Y2guDQoNCg0KPiANCj4gQ2hhbmdlIHRoZSByZXR1cm4gdmFsdWUgdG8gdm9pZC4NCj4gDQo+IENj
OiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPg0KPiBDYzogQW5lZXNo
IEt1bWFyIEsuViA8YW5lZXNoLmt1bWFyQGxpbnV4LmlibS5jb20+DQo+IFN1Z2dlc3RlZC1ieTog
U29oaWwgTWVodGEgPHNvaGlsLm1laHRhQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSXJh
IFdlaW55IDxpcmEud2VpbnlAaW50ZWwuY29tPg0KPiAtLS0NCj4gICBhcmNoL3Bvd2VycGMvaW5j
bHVkZS9hc20vcGtleXMuaCB8IDQgKy0tLQ0KPiAgIGFyY2gveDg2L2luY2x1ZGUvYXNtL3BrZXlz
LmggICAgIHwgNCArLS0tDQo+ICAgaW5jbHVkZS9saW51eC9wa2V5cy5oICAgICAgICAgICAgfCA1
ICstLS0tDQo+ICAgbW0vbXByb3RlY3QuYyAgICAgICAgICAgICAgICAgICAgfCA2ICsrKystLQ0K
PiAgIDQgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vcGtleXMuaCBiL2FyY2gv
cG93ZXJwYy9pbmNsdWRlL2FzbS9wa2V5cy5oDQo+IGluZGV4IGU5NmFhOTFmODE3Yi4uNGQwMWE0
OGFiOTQxIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vcGtleXMuaA0K
PiArKysgYi9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vcGtleXMuaA0KPiBAQCAtMTA1LDExICsx
MDUsOSBAQCBzdGF0aWMgaW5saW5lIGludCBtbV9wa2V5X2FsbG9jKHN0cnVjdCBtbV9zdHJ1Y3Qg
Km1tKQ0KPiAgIAlyZXR1cm4gcmV0Ow0KPiAgIH0NCj4gICANCj4gLXN0YXRpYyBpbmxpbmUgaW50
IG1tX3BrZXlfZnJlZShzdHJ1Y3QgbW1fc3RydWN0ICptbSwgaW50IHBrZXkpDQo+ICtzdGF0aWMg
aW5saW5lIHZvaWQgbW1fcGtleV9mcmVlKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCBpbnQgcGtleSkN
Cj4gICB7DQo+ICAgCV9fbW1fcGtleV9mcmVlKG1tLCBwa2V5KTsNCj4gLQ0KPiAtCXJldHVybiAw
Ow0KPiAgIH0NCj4gICANCj4gICAvKg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9h
c20vcGtleXMuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BrZXlzLmgNCj4gaW5kZXggZGEwMjcz
N2NjNGQxLi4xZjQwOGY0NmZhOWEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNt
L3BrZXlzLmgNCj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vcGtleXMuaA0KPiBAQCAtMTA1
LDExICsxMDUsOSBAQCBpbnQgbW1fcGtleV9hbGxvYyhzdHJ1Y3QgbW1fc3RydWN0ICptbSkNCj4g
ICB9DQo+ICAgDQo+ICAgc3RhdGljIGlubGluZQ0KPiAtaW50IG1tX3BrZXlfZnJlZShzdHJ1Y3Qg
bW1fc3RydWN0ICptbSwgaW50IHBrZXkpDQo+ICt2b2lkIG1tX3BrZXlfZnJlZShzdHJ1Y3QgbW1f
c3RydWN0ICptbSwgaW50IHBrZXkpDQo+ICAgew0KPiAgIAltbV9zZXRfcGtleV9mcmVlKG1tLCBw
a2V5KTsNCj4gLQ0KPiAtCXJldHVybiAwOw0KPiAgIH0NCj4gICANCj4gICBzdGF0aWMgaW5saW5l
IGludCB2bWFfcGtleShzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSkNCj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbGludXgvcGtleXMuaCBiL2luY2x1ZGUvbGludXgvcGtleXMuaA0KPiBpbmRleCA4
NmJlOGJmMjdiNDEuLmJmOThjNTBhMzQzNyAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9w
a2V5cy5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvcGtleXMuaA0KPiBAQCAtMzAsMTAgKzMwLDcg
QEAgc3RhdGljIGlubGluZSBpbnQgbW1fcGtleV9hbGxvYyhzdHJ1Y3QgbW1fc3RydWN0ICptbSkN
Cj4gICAJcmV0dXJuIC0xOw0KPiAgIH0NCj4gICANCj4gLXN0YXRpYyBpbmxpbmUgaW50IG1tX3Br
ZXlfZnJlZShzdHJ1Y3QgbW1fc3RydWN0ICptbSwgaW50IHBrZXkpDQo+IC17DQo+IC0JcmV0dXJu
IC1FSU5WQUw7DQo+IC19DQo+ICtzdGF0aWMgaW5saW5lIHZvaWQgbW1fcGtleV9mcmVlKHN0cnVj
dCBtbV9zdHJ1Y3QgKm1tLCBpbnQgcGtleSkgeyB9DQo+ICAgDQo+ICAgc3RhdGljIGlubGluZSBp
bnQgYXJjaF9zZXRfdXNlcl9wa2V5X2FjY2VzcyhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRzaywgaW50
IHBrZXksDQo+ICAgCQkJdW5zaWduZWQgbG9uZyBpbml0X3ZhbCkNCj4gZGlmZiAtLWdpdCBhL21t
L21wcm90ZWN0LmMgYi9tbS9tcHJvdGVjdC5jDQo+IGluZGV4IDQxNDU4ZTcyOWMyNy4uZTg3MmJk
ZDJlMjI4IDEwMDY0NA0KPiAtLS0gYS9tbS9tcHJvdGVjdC5jDQo+ICsrKyBiL21tL21wcm90ZWN0
LmMNCj4gQEAgLTgwOSw4ICs4MDksMTAgQEAgU1lTQ0FMTF9ERUZJTkUxKHBrZXlfZnJlZSwgaW50
LCBwa2V5KQ0KPiAgIAkJcmV0dXJuIHJldDsNCj4gICANCj4gICAJbW1hcF93cml0ZV9sb2NrKGN1
cnJlbnQtPm1tKTsNCj4gLQlpZiAobW1fcGtleV9pc19hbGxvY2F0ZWQoY3VycmVudC0+bW0sIHBr
ZXkpKQ0KPiAtCQlyZXQgPSBtbV9wa2V5X2ZyZWUoY3VycmVudC0+bW0sIHBrZXkpOw0KPiArCWlm
IChtbV9wa2V5X2lzX2FsbG9jYXRlZChjdXJyZW50LT5tbSwgcGtleSkpIHsNCj4gKwkJbW1fcGtl
eV9mcmVlKGN1cnJlbnQtPm1tLCBwa2V5KTsNCj4gKwkJcmV0ID0gMDsNCj4gKwl9DQoNCk9yIHlv
dSBjb3VsZCBoYXZlIHJldCA9IDAgYnkgZGVmYXVsdCBhbmQgZG8NCg0KCWlmIChtbV9wa2V5X2lz
X2FsbG9jYXRlZChjdXJyZW50LT5tbSwgcGtleSkpDQoJCW1tX3BrZXlfZnJlZShjdXJyZW50LT5t
bSwgcGtleSk7DQoJZWxzZQ0KCQlyZXQgPSAtRUlOVkFMOw0KDQo+ICAgCW1tYXBfd3JpdGVfdW5s
b2NrKGN1cnJlbnQtPm1tKTsNCj4gICANCj4gICAJLyo=
