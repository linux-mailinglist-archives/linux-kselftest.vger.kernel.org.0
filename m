Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1BA49F069
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 02:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344930AbiA1BRf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jan 2022 20:17:35 -0500
Received: from esa16.fujitsucc.c3s2.iphmx.com ([216.71.158.33]:17390 "EHLO
        esa16.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344950AbiA1BRb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jan 2022 20:17:31 -0500
X-Greylist: delayed 155320 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Jan 2022 20:17:31 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1643332652; x=1674868652;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GDXYPXDemfTLu4MxJl0+xO+Ol/G7M4ggz3qmRi5DIAo=;
  b=QMs195uEyT3Io/NgnHEqpkMiYSxNwmZzquUEzRZfAd1fZg72+8Q/Oe56
   2wl/fN2GdzZ80hxoAwYfS6WwK0EG3fYBU2A+yfPPZVgmyZLgYJupHorrb
   QKhum6QHyxgksBbIiy2x0KUEGSCNgr+ZVlfPtrPdVS23Pr1T20wdNyyVl
   KGIoanxLY1/QdL6uQzYG0VjoyPgFmJusKBfVpfvvzsPbq1ojyArkdVkZs
   qoArwkOuiNMW/FGRJkiXf5KIaUo+b6GaUuOLElqgeewU93t0xsHW6Kx89
   4psVByExlSTQTaFo83JojTCCUGsQNRCGK7S5v52Z63AE+9AYq8N0vRu3i
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="48534985"
X-IronPort-AV: E=Sophos;i="5.88,322,1635174000"; 
   d="scan'208";a="48534985"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 10:17:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkmUXSGvCIAaIsjf2MYDdIDxgULMf7gkVhvCtL3rtfX5dijkEsqUKfa3dVUpCvwK2/Vn4SFe0G6DFKeGMreGE5uxaA5xCQUToActbixQbQ1xvbj/Y6NELK/U0r3WpmOCB9hQm1Vyf/uIRi8+am6aMuPBaIy/AlBWchNO8ycF++TAVRciQCVyTKaffWPoNO5Apvu94Su0pjlDKauD//YczsTr5EW/VIPYTkqZTXYpdOY1+c8yaHiaVpSGSaBO/Sj5shLA6Vu/4JtcQOoY4cgRGSl6MZSN966pd1rRIfr5/gYa3lIYOUqjf0OUWY92YJJbf1n/LZDX4SI1K0Ho3ZGARQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDXYPXDemfTLu4MxJl0+xO+Ol/G7M4ggz3qmRi5DIAo=;
 b=WEOU+nqqX7PRmdnznqPOvyb9KRoyOnTwV4jBoKqK0X2Q6lWokxipqJeRXo1Yx9QHjEjpxy1haDXqM0gBtTjIZ6s0Vwg7EAy1yuyDP+EV6G7ZlrURrs5kHBUHnSLLZcdd+WnSrCqCrF38WJ+QY3uy/6yhGogXmzIoy6q0W2wd7R3HZhqHgQxplZlYdUNpbV8LrMHy9QfrZENCDDCJQo399dkPyg+28yIhj5f2fwLV0moYfkWIJJmI8zxut+dHVzXgC2+HHhV8RAuaENhkt27cGKX6IW78knLtLv08a5hUUYypgamgjtVz1w8IuEqKXosG+ja52nNuMlqBESWf24T2Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDXYPXDemfTLu4MxJl0+xO+Ol/G7M4ggz3qmRi5DIAo=;
 b=ALWM/ki29qSSBnI/XnfdCLjblLtE/2Vy5Yznh/Iqy/sy0uRmTLbrPlzCh1GtsWrDG35lzznMxqp15SUJaghPAQ/fimDDVx7hzIckHc5tz1aKzjQ07EMS8V16bg7Hl/YS5DVeyBeXszPYm4WzZ0uvo5TypEHaHo6m1LmovfLfENw=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSZPR01MB8687.jpnprd01.prod.outlook.com (2603:1096:604:15e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 01:17:22 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f%5]) with mapi id 15.20.4909.017; Fri, 28 Jan 2022
 01:17:22 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "naresh.kamboju@linaro.org" <naresh.kamboju@linaro.org>,
        "pvorel@suse.cz" <pvorel@suse.cz>
Subject: Re: [PATCH v2 1/3] selftests/zram: Skip max_comp_streams interface on
 newer kernel
Thread-Topic: [PATCH v2 1/3] selftests/zram: Skip max_comp_streams interface
 on newer kernel
Thread-Index: AQHYE13vM2S9JBREJ0CSbx06wPWwXKx3KjyAgAB41AA=
Date:   Fri, 28 Jan 2022 01:17:22 +0000
Message-ID: <61F3444C.9090000@fujitsu.com>
References: <590c1f1c-2da1-583a-d055-83c15969cf80@linuxfoundation.org>
 <1643274697-3393-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <c3410567-7d69-9020-8477-a8ba957505c8@linuxfoundation.org>
In-Reply-To: <c3410567-7d69-9020-8477-a8ba957505c8@linuxfoundation.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d622da0b-cd8b-40ba-5543-08d9e1fbeffc
x-ms-traffictypediagnostic: OSZPR01MB8687:EE_
x-microsoft-antispam-prvs: <OSZPR01MB8687DD3C7A001A163258DA0EFD229@OSZPR01MB8687.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:546;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VhQtKG/tDctbczStXTzenZw3edW7lNtmC7DJXgNtUISB6pKsmiSoS3Ps6ngcF7cOSzl7aQ/ehlDIPDN7fO0hrAAMkYQ1hUopdHRWrLBOGELvk+SoIEQfVpNGeZhCmGMy5loazW60FnsHES586IIP0FIhwuQyoYPEJ6tu0h7quUNf5oYsg3tq+cHCudMPuWHEJaX0GkSYDAS8QDB3hY24ZqUdcvNuHXn8FGJ2f3OGKln2j/NKSYaL2YtlEa1wUvzeFnOQvlKC71DP4JWJXwB+21/1yUZZkEiA/K3J9OhFFpyfvbBsxVc9fH6ORchJoslT6EOBtdiXsw5QlmMBP9b/Id2/V+t4bDCTmeJbk+YN3/boUPfHuzCizE3nvkqVzcebcYT3WZzDCCllB4HhbWXHOmJiIdixzul8iXqmeeNJqz64vzPlBXkbL7Rriiw9jtZ5Msw3dJiJs27bHxWLmNvNiUD29lZrjtLrl+HXxztZ03Sbk8rRTUPlqnJRY/4vBI9Qx0auhEXQI+vSNTxsI4syAdz9LFO25ltftA8i9vaosbtJe0LLdos+60tf3nxyJxDvXw8VpWnFj7Pfd7RAjXuAz1kzeZy6n+PCLiGJwks1r8DgCDnbpkXWS3ACmVb6p+ijXyVBhICPp0qm4oPOjiah+fk196JsCkrUu4ICxKzuHP4QVTdn090C+evt/5EMP8336+nNPSiqKcbpd/KMJ3FYkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(508600001)(6486002)(8676002)(186003)(82960400001)(4326008)(64756008)(6512007)(122000001)(4744005)(26005)(316002)(66446008)(66476007)(76116006)(6916009)(2616005)(66556008)(33656002)(91956017)(66946007)(2906002)(54906003)(53546011)(38070700005)(71200400001)(86362001)(85182001)(38100700002)(36756003)(87266011)(6506007)(5660300002)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1h0RFJUb0RXeU9NSFZ5WjlSZGlMdmsvbjFWdnloTkpacFdZOFlYV2dyTlZ1?=
 =?utf-8?B?Qkt2WnVNVDFDUDI1WXFnUFlGTmNJNlFLUXFWUC95WThJRmJlclJwTzNkQkZJ?=
 =?utf-8?B?WmhGMDhzdG5VTnVXKzJ5TGM3bnpWR1U1L0dwRFJCMG9LZG5VbDV5UWszWW0y?=
 =?utf-8?B?MCtlOGorRENYNVRpdlh4amNja3d4Sk43TS9GdmZIcFhDaGswVWV1OU5uZ0VB?=
 =?utf-8?B?NEhKZndHYWIrVDZqSzdDNGxZOWZpTjA5ZEdYalNRMGp6Q3BjVUtpeTdObzh3?=
 =?utf-8?B?VUtMdjNzRURGdXFhYU5DcVc5VGJjYWtYRGRaR2dsKzNvNEh1QS9BSWJjeUM3?=
 =?utf-8?B?V3pJQkJITG1NREF5L0pUWkVqVzJzSjZURm1pTGRJa0ZjY0VDa294OWlSbUth?=
 =?utf-8?B?MUlFU2RjOWxwM04vSE56N3kwTlZuZDZteU9UVG82bUdSdDNXblJzbVU5Zk4z?=
 =?utf-8?B?SjNnUTdlbjBPYW5zSVdUWEd4QndQdk9JTjJQT1paSUdiclZUcFg1eWtGaWlU?=
 =?utf-8?B?VWo5TW4xbWhlNWJxYmlQV25JTXhUcVJVMnkrN002QUgxUk5DV014dTlkbHNh?=
 =?utf-8?B?NmlqUC95MDVFZVczQzFiSXdOQUUxcmc1THFncDMwQXpVL01xRjJxdS9Nekpp?=
 =?utf-8?B?U3c0d2ZpZDRRT2NjWWkzVkVhOXhHNEphYVIxT3N6NUx0MFIrR3Z5NG9tMXB4?=
 =?utf-8?B?ZVQ1ZHhpNUEvY0FJWGMrVTA3Vmora2htWlV6TDU4UlgwSVgyRGYvZ0h5TDF0?=
 =?utf-8?B?Rk10YTZLNFJaRzlDUWFyOVhQbUNza2FyUUgrUmhFMmUydDI5dFpFb0xRb3Y1?=
 =?utf-8?B?ZXcxY3B2WHJrYVZORTFYaklGeG40MVFlOW5JT1JlT0lYcW93WGUxMHFpaUVP?=
 =?utf-8?B?T3NuK0EvUjcwaTk3aXVmMER4Z2djMlhhWHI1VFBZTjJDNHBaZ05VUnU1ejVt?=
 =?utf-8?B?S3JlZXhPb2lpZm03MWhOM2dyNzVlTmw2OHdnUVFkOXZYVGZkU3BVUlV5S0VC?=
 =?utf-8?B?eU5maEpORHVDMnkzNDB4Rm9IQk0wdC9ZdDBSbmgrZSs5ejFxUEJjdXQyUG1W?=
 =?utf-8?B?VTl4U0RFY3ZoSkxsV2hzcDBhc2RZTllEcGg4WGNiK2tpUmxJZlpGQXROMW5O?=
 =?utf-8?B?aEZUV05hL3pIVkpPRUNNSUxSVG1mN0pIWEpRb2VVOEE3Q0JrZFh0ZVlPaGhz?=
 =?utf-8?B?RmlXUys1VngzajlPMUpyOXdEbFh4Qi9EUGdIeXI4aysyeU5wRTd1VThJd1Ev?=
 =?utf-8?B?UTdSRW0zUTVBV3hwRmJUR1lVYTBZOU1PVFB5U3RSQ3c3dGxnSTJoWU1rcFpn?=
 =?utf-8?B?eXZyU2F4KzViWWEwaExvbmp6M3JDekVkL01lc0I0eG0zTHl4T1NuVjBxK2J1?=
 =?utf-8?B?UWxPVks1ZDZYcUNHU2RWc3N4MUtrdXlMY1R2S3FnZ1ZuRjhHWnVXNHdjT2Nq?=
 =?utf-8?B?aUtkMzVuYVFlRFQ2MVNUcEtYWnMvcHBUNkpYK1dIdEdwLzIvQmJrTkhjaFZ2?=
 =?utf-8?B?NTkvbVE2LzBJNHdLSFhZc21hK3BNSm4rK3N1eVJZUk8yR3RXb2doNklUeVIr?=
 =?utf-8?B?ZDV6b0RuUXpneTVvZ0JIMnFxMUorRGVBZnZWb2FiTWZxaTBncXNoczBwTWpE?=
 =?utf-8?B?L3R2QS9YYk1DbFJXODM5MFZMSmd2MFpFMW12bm82ZG1HRHhwQThpQXY2by9h?=
 =?utf-8?B?aWliVWYrNEgxN2tOQVhvWmc3dVJOQlhYUzJXOWsyUlQyTjhQUmxrOTVrZ0da?=
 =?utf-8?B?UldCTEtTYWJBQjhlNWlDZHBZb0dDWGdCTUxmb0R3NWNGUHIvakhISFkwUHdu?=
 =?utf-8?B?c3h6YmoyTlZ1cmM2MWZ2cFR0cklTYURXM3J0Q1I0alIvZW5tdTcySFY3c1NT?=
 =?utf-8?B?UEFpbXlqZTI4S3dVYW5wRHkvNFZlL3AzTlRtWmt1VUpiNnc0NGJnc1JqQURy?=
 =?utf-8?B?NEVsaSsvMTFwdjE0eU5pWnN6b3pKYTBBOFg3T3B3clY3VkovNnNXNDdaSlJY?=
 =?utf-8?B?M1FLajFTQVBLMUFlK0U0R2tDUFJuR1dORXYwMDdUS1hoS2srRDFVaUtRak1D?=
 =?utf-8?B?MlhHSE16TE84Mlp0UnpvVE9GV1R1UUtUTEJVU3B2dldkdWdVTURod0FJWDA2?=
 =?utf-8?B?VGNtWXlnREtqRlI1TXcycko2QkJ6clJ6QzlvbjQ2amdZWXFNb1oxa2Zockh2?=
 =?utf-8?B?SENKU200Vm9MMEFEbDdDdWtNZUU1R2JrVGVIR3MzRjJTT3F1czhJQ210SUUw?=
 =?utf-8?Q?kka41RE5GIazHW0wT9R0+Z/srBPi4GE+milJtG0ahQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <745DD33660576741A2EDD864020F5E2D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d622da0b-cd8b-40ba-5543-08d9e1fbeffc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 01:17:22.8030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Rr8Yzy7PZrZHFYU+PSejEI3XEcGIjdXLoaXX3RjwH8RGHH5R4FXoVlYKpD/H39dOiKjFkeF51rrsIUZf7KfK5eOS/v51I5R4OAWgZWreLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8687
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

b24gMjAyMi8xLzI4IDI6MDUsIFNodWFoIEtoYW4gd3JvdGU6DQo+IE9uIDEvMjcvMjIgMjoxMSBB
TSwgWWFuZyBYdSB3cm90ZToNCj4+IFNpbmNlIGNvbW1pdCA0MzIwOWVhMmQxN2EgKCJ6cmFtOiBy
ZW1vdmUgbWF4X2NvbXBfc3RyZWFtcyBpbnRlcm5hbHMiKSwNCj4+IHpyYW0NCj4+IGhhcyBzd2l0
Y2hlZCB0byBwZXItY3B1IHN0cmVhbXMuIEV2ZW4ga2VybmVsIHN0aWxsIGtlZXAgdGhpcyBpbnRl
cmZhY2UNCj4+IGZvcg0KPj4gc29tZSByZWFzb25zLCBidXQgd3JpdGluZyB0byBtYXhfY29tcF9z
dHJlYW0gZG9lc24ndCB0YWtlIGFueSBlZmZlY3QuIFNvDQo+PiBza2lwIGl0IG9uIG5ld2VyIGtl
cm5lbCBpZSA0LjcuDQo+Pg0KPj4gVGhlIGNvZGUgdGhhdCBjb21wYXJpbmcga2VybmVsIHZlcnNp
b24gaXMgZnJvbSB4ZnN0ZXN0cyB0ZXN0c3VpdGUNCj4+IGV4dDQvMDUzLg0KPj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IFlhbmcgWHUgPHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4N
Cj4gVGhhbmsgeW91LiBUaGlzIGFuZCB0aGUgb3RoZXIgMiBwYXRjaGVzIGFyZSBpbiBsaW51eC1r
c2VsZnRlc3QgZml4ZXMgYnJhbmNoDQo+IGZvciByYzMuDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3
IGFuZCBtZXJnZS4NCg0KQmVzdCBSZWdhcmRzDQpZYW5nIFh1DQo+DQo+IHRoYW5rcywNCj4gLS0g
U2h1YWgNCg==
