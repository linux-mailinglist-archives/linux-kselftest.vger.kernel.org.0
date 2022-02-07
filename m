Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22044AC896
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 19:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiBGScM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 13:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiBGS3B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 13:29:01 -0500
X-Greylist: delayed 1686 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 10:29:00 PST
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44108C0401D9;
        Mon,  7 Feb 2022 10:29:00 -0800 (PST)
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 217EdpHf018725;
        Mon, 7 Feb 2022 17:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=NndxJtymYscJBEr7lJXAW3Y+KihGJzlky87w4lJ1kpQ=;
 b=eLTdUdsvOzyY6z14gGJY+rzq1Vt3MXhiVpbNrS+kEep1IOBwCJBE/UYJRo9ZmDb1YOeP
 KByCuqI16fPehh+wO4igKzwmKPCjHGcj6O2VQvp8t88trsRQpUzzGR/+6z7fZ3oMXo3w
 x03/jrec3PSjWm43Dvu7QBkTIJv9JPxuy5Sm0BdG1hnSm4YBD1LZ+EaUhik5seUPajY4
 Cs74z/KkuPEOCUYJq8OMgK1ZA73Ej9ovfmmBizdeznjA2vFuPsjzfdJ1co3MaZqm7Tpo
 u8tEl7Ml4twkstUpQXyOn2Hid6F32CFQtJvOu/7SumvT+7dtP4OHLr+zNuE37X0Xih9j 3Q== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx08-001d1705.pphosted.com with ESMTP id 3e1fvxhwp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 17:06:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1H2/dGXfOphtYMyrvbkU34sRunbXxA6cs4el4LaJzVKalRXSuZuKsEhn97ibujL1KYnTCXQcD57ziKq0UfM62DrM1IW6mcu5OPRrhduqUZbZrImANYjM3O3Qoi/7V7riw59/2H/Rw9RYkP8EzGzj0xJ86jw3nhEGIEjhsOzTlo7GlAd2cPn+IjpUctM5VJsqy5SKIkvoRKWbBqyWUpAfKzAsG7BA/JKySJDFePka7mQZSWEkXHYfcdYZ9xrpVHwNH0W4m/bPTIERMCohIcj0jodfMLf7S+0mMESnReXkb+JdFmzm5wB9fqEXDFDPcTGhqsqooNlwL9pc9+jqPZMWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NndxJtymYscJBEr7lJXAW3Y+KihGJzlky87w4lJ1kpQ=;
 b=GUqLdqMR6ptQCrPAEmqcXJUBwnPa9YCkcXUe8IIVfFRyo5jIjCDUM/emFvc7lbWScRV1PSebx05CGtE502ijjK9pfods3bnkgXbhEI/VsCC3bC1X2+XSEXTisEntq4MypmMA09JMrqCTBO5nYj35Yav5hcHdIKW0suGRU1Jl/3maQ1NvuMBARckWyin/n+I2SkFT85Maz8fRKoeiBDvA+eaWgpgqN+T5PLvSWComLfh3LO4sdlmL/wWos7Qe0L3NFcR4zzZ7MwQLJfag1PQwp1f25sj6skBekoyVNKFi/8jYIOvP2UE4XfuRFbgI+weqk/X2/Wog4mkTpPtoWZRKPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR13MB2503.namprd13.prod.outlook.com (2603:10b6:a02:cd::33)
 by PH0PR13MB4908.namprd13.prod.outlook.com (2603:10b6:510:7b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.8; Mon, 7 Feb
 2022 17:06:08 +0000
Received: from BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::20e9:1719:a46:8b20]) by BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::20e9:1719:a46:8b20%6]) with mapi id 15.20.4975.011; Mon, 7 Feb 2022
 17:06:08 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Frank Rowand <frowand.list@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Rae Moar <rmoar@google.com>,
        Brendan Higgins <brendanhiggins@google.com>
CC:     "rmr167@gmail.com" <rmr167@gmail.com>,
        "guillaume.tucker@collabora.com" <guillaume.tucker@collabora.com>,
        "dlatypov@google.com" <dlatypov@google.com>,
        "kernelci@groups.io" <kernelci@groups.io>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] Documentation: dev-tools: clarify KTAP
 specification wording
Thread-Topic: [PATCH v2 1/1] Documentation: dev-tools: clarify KTAP
 specification wording
Thread-Index: AQHYHD+8KD+C8WNM1kmsUaQyeoggOqyISeEAgAAEsYCAAAFyMA==
Date:   Mon, 7 Feb 2022 17:06:07 +0000
Message-ID: <BYAPR13MB2503C78EE66DBC27ECF3FE8AFD2C9@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <20220207162813.3091899-1-frowand.list@gmail.com>
 <e795ad1a-ddb1-f0af-4a74-7c2c6a0a949a@gmail.com>
 <0de1426c-5b5d-9160-cd5c-00185fa516f5@gmail.com>
In-Reply-To: <0de1426c-5b5d-9160-cd5c-00185fa516f5@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f06dfe0-4cb8-4aba-0751-08d9ea5c2226
x-ms-traffictypediagnostic: PH0PR13MB4908:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <PH0PR13MB4908591C38DEF36D9AC9A48DFD2C9@PH0PR13MB4908.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UhxhsUAnmpd76TMxrMWuuR0/2iueUMBLwUvxiNM54UDWbKeTc47M4BcRx5lD+uflwQQ59c/7T5TTxkDh5fitjoKHA5nYiIJlwVu5JKzyXXCmcE55wI+BMpQBahom8mONXRVIgPyerzNLu4zeQWg7ubRczdokJNoS0DpRD8p/hsc5mh3ql6qM2Ud2dL/E0tpfh5AnIrYcm3ZLVlPeQL6ShMF+QZdEDqFT8L5vXdfQGEvZ3IAO1rSmVxsSqljsPQq+X7FjOydyw+YqN9LzxcVvJQeRBgQOJKv34IG7NxHcho7iqAAEms8YwLEhVWK1BEdac7Z8nq5BYLg7+PeGF9sOUrKi5zVuNN3JbV872I+MkDyTGeCTlSlCM9EfWvrXfb9K6ai81iGsMfIT6UGbIz/Asuo5FqYhS+FXwOnPStS159zkkvB5gSr5cm+Ce3YMNgL5oIzEu+UKX3C4pywox6OJ/NIde4fpam1CtWsEMOCc4XDFpsKZjd7w6XsCTWfVArkp/JdGRGyL/+fRNgcnZBoacBpbR00fKrUPRblIOxS7PG+PsJj5EcLIPqfbrMTOyeIwXtKxy6F0UsYxOgERKgs4UsSi9jYiAhNemgUspR4QgVQWNm7om0AU0phkLvLCDQP93eMvSdLFVqVvEKDFz0d1wQarSCwLX0DUdthay8J8VscJtViCtyVMG2LAsHCiTBKZWFbTbnwWNCXTzDEQrBQ8jn9/gBoTrurWgMrvGkKVsHxHpPUH6nQVFP5gyNY/9YhW80nWomxZqh9jX7+3ePbfSAPUW6oHrk6DsQ4hQfLnTu6gDnKt3IIzFaNpqAHffFDM0WhuPq4nBDtrPDO8gX1m3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2503.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(82960400001)(55016003)(38100700002)(6506007)(966005)(53546011)(71200400001)(5660300002)(52536014)(186003)(26005)(86362001)(122000001)(7696005)(83380400001)(7416002)(33656002)(66446008)(66476007)(66556008)(64756008)(110136005)(54906003)(2906002)(8676002)(38070700005)(9686003)(4326008)(8936002)(76116006)(66946007)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUp4WEpaNHdXV2JydlpzdkJaTjBaeXFxcXdvL2RNaXJRMkY4d3BrbHVCMms4?=
 =?utf-8?B?NUVyR2NjUWhyUjhkVU1MOG44eWNlUlBneVAraDFHMjBCd2plaElLTkJIdVJQ?=
 =?utf-8?B?U2ZNemRCRyszc2Y3RXVqWFpON2lBSHhlUGx6dW1EZFRFYUdyQVEwREJ3WlM3?=
 =?utf-8?B?SnR3WlhyV0RHZ0ppcnBMS0Jwc2NVdzkxdFpsQWRPRjRlTW80aHI3bVFkRTNn?=
 =?utf-8?B?RHAyN3lzVGR5QnlEbGt5UCt0aHdGWlIyNVBBNHFqZmZSUWgzYzBoVm1Ta2Jh?=
 =?utf-8?B?QkN5ei9kalpTRWFaSE5GTXZCU2pmWGVMUFVjUXo4alRFbDVwMlJsdEEyQlpR?=
 =?utf-8?B?VEdvQTZZOTZnbnZpbkV2cExkVUhHaDRTN2N3T2hrZGhRbXNUbVk5dXRMLzJH?=
 =?utf-8?B?bGdPTWpRZllmZUdnL1dOY2JHSGtCaEtMSU0wWWprazNFdmErTTNqOFdDWHBs?=
 =?utf-8?B?djZkek4rQnlrb1pMN25MKzljVFJRSzRJQ1krUE9HZGVWTnBMOXV4ZHFySWE1?=
 =?utf-8?B?aFR5RUc2UjlKYnRObkFERWFndVhtWEkzMkZhTlFxS2tIcUpHaGRjOVV3SHBI?=
 =?utf-8?B?OXNGdTk3aG5OQmJ2bTZ6NXg1enZJRExFY0I1M2FXRmdETHQ5enp4NzhHajEv?=
 =?utf-8?B?cTg2NmJzTWgyLzJhb3RCaWsyZ0wvRk9GSm5yRE45dGRZSUdNL084ZkhaVGVp?=
 =?utf-8?B?QkR2dUE3bWtXRHdWeEk1UVNGaFVOdmUybmxjWVN2Z1BucENRaHlLZTZmK2Fx?=
 =?utf-8?B?bmNMOWhnZ3ZpZGpHNklCV2lRdnM1SHF5aVBmcExxcWtud1dqK2tHVEY5VVdL?=
 =?utf-8?B?L2hlMDFNRUhMSnkrWFJ2Nk5kQmwzS2Z3ekswN0hnV2V1YXdJS0c4UTJlS2J0?=
 =?utf-8?B?Rjg4S2daa1BkLzVGUHpsdzFkSXppZzFFeExQRFFLWGY3Z0JKMTNUbmVpU0lS?=
 =?utf-8?B?RTczTWE1b3RNa1lmYTl1eW9FSHBtQ05TZVN6aWREQUY0a0pJY05QVk5XTzFF?=
 =?utf-8?B?cmdDbm5HU3Qwb1pjMkdrSGx4YmRYd0EvTjVidTNzUmZKL3hHTVlIS2Z1YmZH?=
 =?utf-8?B?TFlrYU5adTh6QlpBSDRJTlJWckxNM0lvaGZTRUdSV2VPRVIwd1JxUk1RTHhZ?=
 =?utf-8?B?ZFdZZTg4ZG0zVDI0Q00xM2QyZjNCc3VTZmxYV2JkY2NTQUF6aWVONzZsVitW?=
 =?utf-8?B?NS82dGptNm5SVzVMRGlrVUNHVGVTZEF3eHhBMVZSTUVDRjVjaGJsbi9KWmRh?=
 =?utf-8?B?NWloeDBxRko1TDdpbzkvOURGTmM4MEhHdTZ6RjlkU2E5VFhEZFAzVG1ocjd3?=
 =?utf-8?B?d0cwNENlRlZoQlVtcnB2d3RXWVh1aEdweDE4NEZPVjkxbU1HbUdJSGNUQ1F4?=
 =?utf-8?B?MWNIZWpFc252UFppWDZmZmJ3TXAxLzBkMVpnS0ducHJIbFZLQUhxdDRacmM5?=
 =?utf-8?B?enZVVHNpUHJMSjdEUXJ0QmxIUFA2M0kybGwwaC9YUXIvK2diY0Vvb1YrRFRL?=
 =?utf-8?B?SklUSVJtbkIvMGsrZ2pqdjdIR0orTzFIS3NQS05wVW9pajFLOEs5dDVHSTFH?=
 =?utf-8?B?K1dTSWs2UlY4cldIMkNWRVBaMi9qdzNwUHVuL1htWnhsTjNDS3haNnRJc2VF?=
 =?utf-8?B?SUREN3dWS0VidDI4dmJjRlk4N3Z6bnJvbVlVcEJXcW5OV2tLUVoxMWJCcU5S?=
 =?utf-8?B?VXlTU2xkK2FqeFMwaEFTL2RKMy9YSG1EZGNDTXA2bmRvMk9yeklPWW9VNElL?=
 =?utf-8?B?cjI5ZnJmblpDcWhMWUhwdmJlMDVra2tkaG1samYrN1RSNGRHa3VIeVJ4RitD?=
 =?utf-8?B?SGRKUk5nbXFPL1FtcFZHaVo1Wld6MkJGU1RhY2FSWVJ3dE8yZ290WjJFZVQw?=
 =?utf-8?B?V2ppaSttSGpYeFRWM3ZMb1lnR0FMM3puL2JWcnRreVJjbHQ5bnhpUGFtMFNt?=
 =?utf-8?B?NmNuc2pjcTB5RmovSXVUMzNEbU1ZWVhXZ1p2ZkF5UnR1bXltL3V5UW9tMUVJ?=
 =?utf-8?B?YkMyUnd5ZU55VERmTmNnMUU4ZlVyWklhbGdYaW1XLzdiSGhQS2lkVjRkbFFY?=
 =?utf-8?B?SmI3T2xpSWF6WEE5amVYcnRYcnBJQWpjZHVIeGQyY1UwTjljZmhMaktGQktY?=
 =?utf-8?B?amFQUTAxdHM0Y0MyeXpSeC8vN3R3SU4wTXpwZ0lRSnRwOTRPVGNJSTYydEhY?=
 =?utf-8?Q?5tcH5oXdJBg3Q2+Hm+6ocY0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2503.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f06dfe0-4cb8-4aba-0751-08d9ea5c2226
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 17:06:07.9194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aBnsWarKTOzzg7XfHMqBrAYTJQplQ4ZK0IYag2E4LkXs9MuhkCtZ8SSys7u0sKb8TRcUi5Egd+OmuJHvn4b9XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB4908
X-Proofpoint-GUID: U7071z2IR7aJgQXwxtI75bNVEgTXUfx-
X-Proofpoint-ORIG-GUID: U7071z2IR7aJgQXwxtI75bNVEgTXUfx-
X-Sony-Outbound-GUID: U7071z2IR7aJgQXwxtI75bNVEgTXUfx-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-07_06,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 clxscore=1011 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202070106
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRnJhbmsgUm93YW5kIDxm
cm93YW5kLmxpc3RAZ21haWwuY29tPg0KPiANCj4gT24gMi83LzIyIDEwOjM4IEFNLCBGcmFuayBS
b3dhbmQgd3JvdGU6DQo+ID4gT24gMi83LzIyIDEwOjI4IEFNLCBmcm93YW5kLmxpc3RAZ21haWwu
Y29tIHdyb3RlOg0KPiA+PiBGcm9tOiBGcmFuayBSb3dhbmQgPGZyYW5rLnJvd2FuZEBzb255LmNv
bT4NCj4gPj4NCj4gPj4gQWRkIHRoZSBzcGVjIHZlcnNpb24gdG8gdGhlIHRpdGxlIGxpbmUuDQo+
ID4+DQo+ID4+IEV4cGxhaW4gbGlrZWx5IHNvdXJjZSBvZiAiVW5rbm93biBsaW5lcyIuDQo+ID4+
DQo+ID4+ICJVbmtub3duIGxpbmVzIiBpbiBuZXN0ZWQgdGVzdHMgYXJlIG9wdGlvbmFsbHkgaW5k
ZW50ZWQuDQo+ID4+DQo+ID4+IEFkZCAiVW5rbm93biBsaW5lcyIgaXRlbXMgdG8gZGlmZmVyZW5j
ZXMgYmV0d2VlbiBUQVAgJiBLVEFQIGxpc3QNCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogRnJh
bmsgUm93YW5kIDxmcmFuay5yb3dhbmRAc29ueS5jb20+DQo+ID4+IC0tLQ0KPiA+DQo+ID4gUGxl
YXNlIGRvIG5vdCBhcHBseSB0aGlzIHZlcnNpb24gKHYyKS4gIEkgd2FzIHdvcmtpbmcgb2ZmIHRo
ZSBLVEFQIHNwZWNpZmljYXRpb24NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5eXl4gVEFQDQoNCldoYXQ/Pz8NCg0KPiA+
IGZyb20gYSBkaWZmZXJlbnQgZ2l0aHViIHJlcG8gdGhhbiBJIHNob3VsZCBoYXZlIGJlZW4gcmVm
ZXJlbmNpbmcuDQo+IA0KPiBPSyB0byBwcm9jZWVkIHdpdGggdGhpcyB2ZXJzaW9uIG9mIHRoZSBw
YXRjaC4gIEkgd2FzIHJlZmVyZW5jaW5nIHRoZSBwcm9wb3NlZA0KPiBUQVAgdmVyc2lvbiAxNCwg
d2hpY2ggaXMgaW4gYSBkaWZmZXJlbnQgZ2l0aHViIHJlcG8gdGhhbiB0aGUgVEFQIHZlcnNpb24g
MTMNCj4gc3BlY2lmaWNhdGlvbi4gIEV2ZXJ5dGhpbmcgaW4gdGhpcyBwYXRjaCBpcyBjb25zaXN0
ZW50IHdpdGggVEFQIHZlcnNpb24gMTMsDQo+IGFzIHdlbGwgYXMgdGhlIHByb3Bvc2VkIFRBUCB2
ZXJzaW9uIDE0Lg0KDQpJJ20gY29uZnVzZWQgYnkgdGhpcyBtZXNzYWdlLg0KV2lsbCB0aGVyZSBi
ZSBhIHYzIG9mIHRoZSBwYXRjaCwgb3IgYXJlIHlvdSBzYXlpbmcgdG8ganVzdCBhcHBseSB0aGUg
b3JpZ2luYWwgdjIgb2YNCnRoaXMgcGF0Y2g/DQoNCkZvciB0aGUgb3JpZ2luYWwgKHYyKSBvZiB0
aGUgcGF0Y2gsIHdoaWNoIEkgYmVsaWV2ZSBpcyANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC8yMDIyMDIwNzE2MjgxMy4zMDkxODk5LTEtZnJvd2FuZC5saXN0QGdtYWlsLmNvbS8NCg0KeW91
IGNhbiBhZGQgYSAiUmV2aWV3ZWQtYnkiIGZyb20gbWUuDQogLS0gVGltDQoNCg==
