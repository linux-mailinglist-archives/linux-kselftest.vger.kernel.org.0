Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED826C607A
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 08:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjCWHRr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 03:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjCWHRq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 03:17:46 -0400
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2126.outbound.protection.outlook.com [40.107.135.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C762A234D1;
        Thu, 23 Mar 2023 00:17:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KM6uvVebmmA5qRumDWp3031P60cJkAC6YHJnmIply3oVIfGhOtj5SggWgeEKp8MNZPC66hu45t+puCZsShv6G2DUpxK9cYwikdGqXHqg6QhX/dFb6N8hhbrFJ7cFX5ZSNMrxOqZdRdzZ3djU+xDiTuHfaRdAbR77wdsB6cQbo9Asn3B1CyFkxeFELIKE4yS2vgpivZ8BKXwEpTeQMPE6qMSLX9YjpenDg+tExuqsVM4XFDVha3Gyvj8y3UrqLPhWF929ePJ5cAkaNh/hGD6U9waLIU4FddeXS/j5hR6mbmU1+CS13LIoGPIfwSFk90zz95xWo2IVAUCkOwGUqAXCTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drXVQ+PmIvE73f84r4WXGIOGseJKKXK3oTzZfuq8y/Y=;
 b=jeHQ3viDN3JFqg4m4U439YVM2uLZPaygc3zlnT5J43KHErNCzGwSD5hqKZGcZSyJL2c4ZO4BjoumjeBJiVjAytjU42leVgFWdHCirgUYy1AnbghoHw9cQmQwiToxGRS27L2h1SSZdwXKE0JMe8EI9dtAhA4Haxx/0GmigC9TB4957cq9wifcNUzrwlcgFFqK9z0fMOJijgLOsoSzRE4CVzcBIErtjRPqX4P2/M3XICeaYA6sm1xjRS1veCleECZxHjcyh8i1KD+mXJ90nwOshkcYCTNvv9cnjsQyzA6WamzJJGio1HyoZeyD279VG++P2V/NzcOU8R4/rGTJ6wu+hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drXVQ+PmIvE73f84r4WXGIOGseJKKXK3oTzZfuq8y/Y=;
 b=al7b/02xGDZ0d0TOsgkJw2XT3ovp1n0/zngROj1kwMgZmHZEyxO8WxXnqdZXyU9tUwsAPvUMANnSLT6jr+NKJTnR9ZkxaxeZEzDV7wRdiB8U4/3jxmAzhaD1xGTRxXhYmL4gP6u9190MBeiKuPBf5vcY81A56ntICA0iD/qHxEc=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by BE1P281MB2497.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:69::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 07:17:40 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3657:656:f6f6:dc8f]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3657:656:f6f6:dc8f%5]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 07:17:40 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device
 creation
Thread-Topic: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device
 creation
Thread-Index: AQHZXJ2KQN96MANwdEGQLkX9Bk1XRa8GtIiAgAAcEQCAAFZiAIAAzuOA
Date:   Thu, 23 Mar 2023 07:17:40 +0000
Message-ID: <12ea1d68-2a3c-0aa7-976c-7bd3eef35239@fi.rohmeurope.com>
References: <cover.1679474247.git.mazziesaccount@gmail.com>
 <bad670ee135391eb902bd34b8bcbe777afabc7fd.1679474247.git.mazziesaccount@gmail.com>
 <ZBrvhfX/NNrJefgt@kroah.com> <25f9758f-0010-0181-742a-b18a344110cf@gmail.com>
 <ZBtPhoelZo4U5jwC@kroah.com>
In-Reply-To: <ZBtPhoelZo4U5jwC@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|BE1P281MB2497:EE_
x-ms-office365-filtering-correlation-id: 00050615-13c1-4380-be8a-08db2b6eb006
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c1OqSw4Xevc1f1gl6ZkSR8n9L4nsuvU/aIID8qYfb1BDmTtP0nMGHCdYoHCTSABSkOvTwnIzn2K93EmsIn050viZXNdB7YbnI/fewVndP5dqEgViRCyGtP2GB9E1BDjHOgui5ga2NMZStFSJQvMbVpuPy8khrjPbiFdF711i5NCIbelaAsxHI1Vsf2WJ0lNnBsVK+MjlN3cApSpvMBpy+BHwHI0mxC4XSERBrHDiY+LH1IR/WsKZoN4lRXShmWMZXa5UEDXGAZahlk8LFHn67ik/L70vWHxA0FpKz3GkLkiEgOqwbSoit1ed6JLzA5+IKHhtbAHqS9+bqaVZxnajof+DjlEQqGDLrULtAEsFj0MmW6CQ2RolRc1Rfq+wQ+7YbKdIHFR2wmfG1Hif68iQFAjP34d0mYwa4RVVCA8U3kTUeJhVXX8OkoOMlxbKJQxjLId5wmphVVnudZjuDWS5PmFiobunKjwd7j8uNINwd1cVaLhoj/4rxBeLoc7+jAbtOYn1f8B/trmtXzX7A00IDOiLPTaxMotXqTAEcalOAa31WtiyXcTxwibkyD4iKncf5QnSOYcFAvy6yomXXHJKKkIi6dnXofJs69A9kaVFNz/1w3A4k0Qs8cBlz6tKSw91Zg7RxxLaYx8PFdPPqbqT73JuipT538UJ/5QmwJA97ZZDl3gqMM9g2ypyw5TzmeDlWvE8VGVMFffjBV1egs0o39Gi9l7lBlK+1WVP+72BFRXzzENVUedbgNfQ6EdbG4cUpU7drh09MfAwiu3mZFgMCuBWw8Oe32GzIfwgaXKRK7E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39850400004)(346002)(136003)(366004)(396003)(376002)(451199018)(38100700002)(110136005)(31696002)(71200400001)(66476007)(7416002)(64756008)(54906003)(316002)(91956017)(8676002)(66946007)(66556008)(41300700001)(66446008)(8936002)(5660300002)(76116006)(86362001)(478600001)(83380400001)(2906002)(4326008)(122000001)(53546011)(2616005)(38070700005)(31686004)(186003)(6512007)(6506007)(6486002)(66899018)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzJMdlpjVmNKTGZoN01DNFpiUVdMOVc5Zk1wZUVlZVVrcnZYK2hXVUhkWTZ5?=
 =?utf-8?B?eGczeUxsSU5YU1FUWldsdEpsZ1ZQeXJDWW55UStTTjcwVTlLcVNWU0Fqb1lV?=
 =?utf-8?B?Z055a29GSTMveEZmN1NPcWFxVk1paXRick9GblV6VkJ2RkRHQ3hVaVo1QWRt?=
 =?utf-8?B?b0JjKzdNNEEyU1lnelp4eWVSV2VOUkkwd29SYWlrK2lFK0o4SVprend2a1VR?=
 =?utf-8?B?K3ZHMzZ2WVpUVWRZM0JTMjhrdktNaUJZT2QwREwvM0pJNlNMdENQR0o3WHVt?=
 =?utf-8?B?TWliTC9jMzhhdE5XbkNHUFJrcXNsU2FqMkxCekE5MnF5RHJSNWRtcmJDL3lD?=
 =?utf-8?B?WFdXUkdWaDJ6RWliZ2hHMDBxYXZaSWVDQkdnYWpMZThoVS94U3U5VjNKTzYr?=
 =?utf-8?B?YjhGTDFGYzE4OE8rZnhNc2ZuamF5WmdpK0dFZkZiRWdtVUROY2RlakhpelpM?=
 =?utf-8?B?OHoxdVVwcERJQUdLamdlTUV3anFSL2lJc0E4WFR6NjJ0T3dWVFdWVnUrNVZR?=
 =?utf-8?B?dUIzK1ZzRzZWTnhER0p0cUN2elRaTk93S01YL092WG5aenlkeWloTlVmMGxz?=
 =?utf-8?B?NlN2QzBrUzNuVEZVbGNrYjM3OGxTNHcxZWVua0NLUUUySFNOZEE0T24yVzhS?=
 =?utf-8?B?SXZkSHN6QzZaL3hLUXoycUdqRlUvSHpkWm1xdG5ZNmt6YVQzRVN4Sk1YZW5N?=
 =?utf-8?B?M0MzWGhMQnRVSnhoaHZTTDdKdXFBQTJyejJOMVJMR24rZlpRWHd5akdYRDVm?=
 =?utf-8?B?N1Rzdjl3Y0N3QnlIaWRzU1VaRzJWbWk2NGp1NHZMNFdtTGpGd1dEaDRZc2w0?=
 =?utf-8?B?SncyQldqQmpNTVVncW42UWNvdEFmWDNXWnJzNVBlSUszTWo0M1dvRnFvSGZy?=
 =?utf-8?B?NEFXeDZNMk1iQ0EwYnM4UGZiYWNYSDJwR3lHUGs1UjdnRnZHelRuUW1jdDE3?=
 =?utf-8?B?NlNOM1NxSGJaMm5vR3o4MDJtZmRwSHFqcVRscng1M2ViSFJHdmE5S0xzelpF?=
 =?utf-8?B?eG1oNkl3Mk03WHJQM3BJYUlvRVF4WGthMFVRMHV6bnl5S3NtNUJ4WEIzYmJI?=
 =?utf-8?B?N2oxZW1uSWhsa0o0akJsbFQ3VVdvUU1yUmczTUlvQUhYZzNibmNOV1pIZzZW?=
 =?utf-8?B?ZzFvc0ZXU3NmcHIxWkRwMXF1SUE1ZldweDAxTGhGb0pwUkErRHcvb0FGSEZi?=
 =?utf-8?B?UlJ1MkRMbGtEbzFTamNhRUxENWZnNTdnU0lMQUE0UFZidUhtdEFpcGt2TW4z?=
 =?utf-8?B?YjN4YmRJdHpMWTNNQTdSZFp6ZmgwS1JGTVlIQ0ZFSjB1N21XSVQxRnpFTUxy?=
 =?utf-8?B?NXphazJxMExmVWVEcHFEOEJsVEg1WWxhUnJoME1kNm5TZjIrZ1FTS21lOW9r?=
 =?utf-8?B?UjcyeFpCd21JY3VRdno1VDRrbkR3a3puSUlKVnFuMmdzQ29KbmpKVHI2OVE2?=
 =?utf-8?B?VExEdVFlb2gxeWYrQUt4dzJMSzhnd2Z4cEtjMmNGbWk3RDZKUjAwMUFKTDNT?=
 =?utf-8?B?akFvOUZKY28zM2JqNUpSQjlLSWE3TEIxTzBNZ3o1QXlzVUlCTThWTnhLTmJL?=
 =?utf-8?B?TUpZR24xVjljbWIzZkk3OGRJWHF1VUN1ZkZ4VmYyaUlQK0VzUW42MnIyazFC?=
 =?utf-8?B?Nmh3TTNrKzBqZGpuVEhKeVBrYndpVys4ejRRME5oWHFodDBmZE54emFjYlli?=
 =?utf-8?B?MUdtWjJNUitFZitEY3BWY2FUQytsWGF2NHRvR2YzR0NIemhrS1NnQzZSN0ll?=
 =?utf-8?B?RkdyZ05vWENmSGRmVlBjVk9pSzVGUGVFamVsUlNSSnJIREozMG9LUUNudEsr?=
 =?utf-8?B?UnB5R2RYT1BwZEdOdm0rYWI5b2VyeWl6ckowdnZ4WFBmS3E1c0ZYVld4RzBS?=
 =?utf-8?B?TFZsY0dGS0dNSnVySHZ1dWhrMWU5UEdvMVhmM3lGL1l2eHJDZlg1ZVoxMUpo?=
 =?utf-8?B?Z2dLMnRMclFVNEtJdTRBL2RqQVlNZm5pQUFyV3ZkVDd1bXRSdVRQYVFGV2Vo?=
 =?utf-8?B?SU8vamZFTTUvK2tiUnQ4YkpvZDZXSG4xZWJxQUVjc21VOFY2Y2l1Q3BuOHMv?=
 =?utf-8?B?aXVzZlRONlFFbCs1QUVCWmtteDJUUEc2WmVjNWwrNGxBc0VnSEo4eTQ1ODNk?=
 =?utf-8?B?Skh5MEU2MUtERVNNa2N3Y3JWWkZqVzFoczgvYmE5ektqeENUakhRc1V0NHJw?=
 =?utf-8?Q?U+gvH0zr741ov4uTWnHOT48=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B42F2F8D4355CF44804585E3E14CEB8F@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 00050615-13c1-4380-be8a-08db2b6eb006
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 07:17:40.2529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cv57XspsIquyb7S+wuwN26P0oI6xrgznL6mhYFu941LgVsyujrwEMQqm20lfeEzpZJh5yEIi3VQJAeU6UZDv4A+4W9DqJkBNz/nu7DerepudOWOqaDmSpLCha1Qa2zpv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2497
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gMy8yMi8yMyAyMDo1NywgR3JlZyBLcm9haC1IYXJ0bWFuIHdyb3RlOg0KPiBPbiBXZWQsIE1h
ciAyMiwgMjAyMyBhdCAwMzo0ODowMFBNICswMjAwLCBNYXR0aSBWYWl0dGluZW4gd3JvdGU6DQo+
PiBIaSBHcmVnLA0KPj4NCj4+IFRoYW5rcyBmb3IgbG9va2luZyBhdCB0aGlzLg0KPj4NCj4+IE9u
IDMvMjIvMjMgMTQ6MDcsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4+PiBPbiBXZWQsIE1h
ciAyMiwgMjAyMyBhdCAxMTowNTo1NUFNICswMjAwLCBNYXR0aSBWYWl0dGluZW4gd3JvdGU6DQo+
Pj4+ICsvKioNCj4+Pj4gKyAqIHRlc3Rfa3VuaXRfaGVscGVyX2FsbG9jX2RldmljZSAtIEFsbG9j
YXRlIGEgbW9jayBkZXZpY2UgZm9yIGEgS1VuaXQgdGVzdA0KPj4+PiArICogQHRlc3Q6IFRoZSB0
ZXN0IGNvbnRleHQgb2JqZWN0DQo+Pj4+ICsgKg0KPj4+PiArICogVGhpcyBhbGxvY2F0ZXMgYSBm
YWtlIHN0cnVjdCAmZGV2aWNlIHRvIGNyZWF0ZSBhIG1vY2sgZm9yIGEgS1VuaXQNCj4+Pj4gKyAq
IHRlc3QuIFRoZSBkZXZpY2Ugd2lsbCBhbHNvIGJlIGJvdW5kIHRvIGEgZmFrZSBkcml2ZXIuIEl0
IHdpbGwgdGh1cyBiZQ0KPj4+PiArICogYWJsZSB0byBsZXZlcmFnZSB0aGUgdXN1YWwgaW5mcmFz
dHJ1Y3R1cmUgYW5kIG1vc3Qgbm90YWJseSB0aGUNCj4+Pj4gKyAqIGRldmljZS1tYW5hZ2VkIHJl
c291cmNlcyBqdXN0IGxpa2UgYSAicmVhbCIgZGV2aWNlLg0KPj4+DQo+Pj4gV2hhdCBzcGVjaWZp
YyAidXN1YWwgaW5mcmFzdHJ1Y3R1cmUiIGFyZSB5b3Ugd2FudGluZyB0byBhY2Nlc3MgaGVyZT8N
Cj4+Pg0KPj4+IEFuZCBhZ2FpbiwgaWYgeW91IHdhbnQgYSBmYWtlIGRldmljZSwgbWFrZSBhIHZp
cnR1YWwgb25lLCBieSBqdXN0DQo+Pj4gY2FsbGluZyBkZXZpY2VfY3JlYXRlKCkuDQo+Pj4NCj4+
PiBPciBhcmUgeW91IHdhbnRpbmcgdG8gZG8gIm1vcmUiIHdpdGggdGhhdCBkZXZpY2UgcG9pbnRl
ciB0aGFuDQo+Pj4gZGV2aWNlX2NyZWF0ZSgpIGNhbiBnaXZlIHlvdT8NCj4+DQo+PiBQZXJzb25h
bGx5LCBJIHdhcyAoYW0pIG9ubHkgaW50ZXJlc3RlZCBpbiBkZXZtXyB1bndpbmRpbmcuIEkgZ3Vl
c3MgdGhlDQo+PiBkZXZpY2VfY3JlYXRlKCksIGRldmljZV9hZGQoKSwgZGV2aWNlX3JlbW92ZSgp
Li4uIChkaWRuJ3Qgc3R1ZHkgdGhpcw0KPj4gc2VxdWVuY2UgaW4gZGV0YWlscyBzbyBzb3JyeSBp
ZiB0aGVyZSBpcyBlcnJvcnMpIGNvdWxkJ3ZlIGJlZW4gc3VmZmljaWVudA0KPj4gZm9yIG1lLiBJ
IGhhdmVuJ3QgbG9va2VkIGhvdyBtdWNoIG9mIHRoZSBjb2RlIHRoYXQgdGhlcmUgaXMgZm9yICdw
bGF0Zm9ybQ0KPj4gZGV2aWNlcycgc2hvdWxkIGJlIGR1cGxpY2F0ZWQgdG8gc3VwcG9ydCB0aGF0
IHNlcXVlbmNlIGZvciB0ZXN0YWJpbGl0eQ0KPj4gcHVycG9zZXMuDQo+IA0KPiBBbnkgZGV2aWNl
IGNhbiBhY2Nlc3MgZGV2bV8gY29kZSwgdGhlcmUncyBubyBuZWVkIGZvciBpdCB0byBiZSBhDQo+
IHBsYXRmb3JtIGRldmljZSBhdCBhbGwuDQo+IA0KPj4gVGhlIGJpZ2dlc3QgdGhpbmcgZm9yIG1l
IGlzIHRoYXQgSSBkb24ndCBsaWtlIHRoZSBpZGVhIG9mIGNyZWF0aW5nIG93biAndGVzdA0KPj4g
ZGV2aWNlJyBpbiA8YWRkIHN1YnN5c3RlbSBoZXJlPiB3aGlsZSB3ZSBhbHJlYWR5IGhhdmUgc29t
ZSBpbiBEUk0gKG9yDQo+PiBvdGhlcnMpLiBUaHVzLCBJIGRvIHNlZSB2YWx1ZSBpbiBhZGRpbmcg
Z2VuZXJpYyBoZWxwZXJzIGZvciBzdXBwb3J0aW5nDQo+PiBydW5uaW5nIEtVbml0IHRlc3RzIG9u
IGRldm1fKiBBUElzLiBIZW5jZSBpdCdkIGJlIGdvb2QgdG8gaGF2ZSBfc29tZV8NCj4+IHN1cHBv
cnQgZm9yIGl0Lg0KPiANCj4gSSBhZ3JlZSwgbGV0J3MgdXNlIGEgdmlydHVhbCBkZXZpY2UgYW5k
IGEgdmlydHVhbCBidXMgKHlvdSBjYW4gdXNlIHRoZQ0KPiBhdXhidXMgY29kZSBmb3IgdGhpcyBh
cyB0aGF0J3MgYWxsIHRoZXJlIGZvciB0aGlzIHR5cGUgb2YgdGhpbmcpDQoNCkhtLiBUaGUgYXV4
aWxpYXJ5X2RldmljZXMgcmVxdWlyZSBwYXJlbnQuIFdoYXQgd291bGQgYmUgdGhlIGJlc3Qgd2F5
IHRvIA0KZGVhbCB3aXRoIHRoYXQgaW4gS1VuaXQgdGVzdHM/DQoNCj4gdGhlbiB5b3UgY2FuIHRl
c3QgdGhlIGRldm1fKiBjb2RlLCBfQU5EXyB5b3UgY2FuIHRlc3QgdGhlIGRyaXZlciBjb3JlIGF0
DQo+IHRoZSBzYW1lIHRpbWUuDQo+IA0KPj4gQW5kIGhhdmluZyB0aGVtIGluIGRyaXZlcnMvYmFz
ZS90ZXN0IHNlZW1lZCBsaWtlIGEgY29ycmVjdA0KPj4gcGxhY2UgdG8gbWUuIFdoYXQgSSByZWFs
bHkgZG9uJ3Qga25vdyBpcyBpZiB0aGVyZSBhcmUgbGVnaXRpbWF0ZSB1c2UtY2FzZXMNCj4+IGZv
ciB1c2luZyBwbGF0Zm9ybV9kZXZpY2VzIGluIERSTSB0ZXN0cy4gUGVyaGFwcyBNYXhpbWUgY2Fu
IHNoZWQgbGlnaHQgb24NCj4+IHRoYXQuDQo+IA0KPiBJIGFncmVlIHRoYXQgdGhpcyBjb3VsZCBi
ZSBpbiBkcml2ZXJzL2Jhc2UvdGVzdC8gYnV0IHRoZW4gbGV0J3MgdGVzdCB0aGUNCj4gZHJpdmVy
IGNvcmUsIG5vdCBqdXN0IHByb3ZpZGUgYSBkdW1teSBwbGF0Zm9ybSBkZXZpY2UuDQo+IA0KPiBJ
ZiB5b3Ugd2FudCB0byB0ZXN0IHRoZSBwbGF0Zm9ybSBkcml2ZXIvZGV2aWNlIGFwaSwgdGhhdCB3
b3VsZCBiZSBncmVhdA0KPiB0b28sIHRoYXQgY2FuIGJlIHBsYWZvcm0gZGV2aWNlL2RyaXZlciBz
cGVjaWZpYywgYnV0IGRvbid0IHVzZSBvbmUgZm9yDQo+IHNvbWUgb3RoZXIgcmFuZG9tIGRyaXZl
ciBjb3JlIGZ1bmN0aW9uYWxpdHkgcGxlYXNlLg0KDQpJIGFtIHZlcnkgY29uc2VydmF0aXZlIHdo
YXQgY29tZXMgdG8gYWRkaW5nIHVuaXQgdGVzdHMgZHVlIHRvIHRoZSBodWdlIA0KaW5lcnRpYSB0
aGV5IGFkZCB0byBhbnkgZnVydGhlciBkZXZlbG9wbWVudC4gSSB1c3VhbGx5IG9ubHkgYWRkIHRl
c3RzIHRvIA0KQVBJcyB3aGljaCBJIGtub3cgd29uJ3QgcmVxdWlyZSBjaGFuZ2luZyAoSSBkb24n
dCBrbm93IHN1Y2ggaW4ta2VybmVsIA0KQVBJcykgLSBvciB0byBmdW5jdGlvbnMgd2hpY2ggSSB0
aGluayBhcmUgZXJyb3ItcHJvbmUuIFNvLCBJIGFtIHByb2JhYmx5IA0Kb25lIG9mIHRoZSBsYXN0
IHBlcnNvbnMgYWRkaW5nIFVUcyB0byBjb2RlIEkgZG9uJ3Qga25vdyA6KQ0KDQpZb3VycywNCgkt
LSBNYXR0aQ0KDQotLSANCk1hdHRpIFZhaXR0aW5lbg0KTGludXgga2VybmVsIGRldmVsb3BlciBh
dCBST0hNIFNlbWljb25kdWN0b3JzDQpPdWx1IEZpbmxhbmQNCg0Kfn4gV2hlbiB0aGluZ3MgZ28g
dXR0ZXJseSB3cm9uZyB2aW0gdXNlcnMgY2FuIGFsd2F5cyB0eXBlIDpoZWxwISB+fg0KDQo=
