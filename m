Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82F53F91F3
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Aug 2021 03:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243938AbhH0Bgc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Aug 2021 21:36:32 -0400
Received: from esa16.fujitsucc.c3s2.iphmx.com ([216.71.158.33]:35640 "EHLO
        esa16.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243923AbhH0Bgb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Aug 2021 21:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1630028144; x=1661564144;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DJ8d1IW5RM2UrO2J79DELfPaF/ux7quRWVnkFoq/iF8=;
  b=Z5xH3rzcqk4MHuiq8hgYSNetacJpqgQqx4q/xAmdBPBjYcuczRbuiKyg
   cFcSh1NnBqe4tEt+XzjkDirAFS9fMylXK5IYu1laqxIiKoziIuVHQ5Xmj
   duYK9mVnDNtqj7V8fiR0jwpd7UOV0Y7cz6Ytz0O26ZmtedGjnf0QCQgDr
   0SIIqDFoGO987wPoo9Y5hHimG/Y0ZKiXjnpkNIIvY1DNSJmrIJFduDd1G
   KN2THt8sdsxCyFzh3RaIHyHg0OE1nAeQ0CD4H5V/73qR+sIkrQoNBVahD
   Eem4uJs4L+l6siU7w0AMJ+9cx1eX2VQlKWuBEbHRkaa9fVm/8VA2euFRQ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="37804745"
X-IronPort-AV: E=Sophos;i="5.84,355,1620658800"; 
   d="scan'208";a="37804745"
Received: from mail-ty1jpn01lp2050.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.50])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 10:35:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEADiifWyIXt5NqIamKzpZ38erIaafo7NQkJi1agRGDJi1SH3VHO//Xz5fmTIRKdjHDy1P+uC4FfALIq0VATlH9IKe8BBYNDc+rizWGpDmMuvozxDckMcXuggkuJjoN5NqvqQx3IzVynzB/4DB+bMo6zg5TRXvoHk0Fo03m/rSpRj+dOkZV0GWZJpbAOMiq1n1aWKffUCM5oQBWPwnQISipNoB6Te9Hch8NgrpXmhPhmMqcpu93G1FO2w7NnZN002ThKM+3sVCYJukp6kwHbfWCxkXqRmvs+WHgTfjiZsUfbj5w7Z7c8GwuHV4TXqP4sSZd2Ju4cq4kXAERvdPyk1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJ8d1IW5RM2UrO2J79DELfPaF/ux7quRWVnkFoq/iF8=;
 b=eT4OqdZiEmAIdjm+aAPABZJleakQr2gckRT95TiGu5uvZ0iC9ciR4Y/K0gBmNEA94kmv3u1h++gzMeg5PxPZMZFCW828LF+7GA7BCCb2hnOws6e4eccz2hGyewtgLAI36wIX8ppiREvBNFWA/0GTpgkxkHfS/mScrn1KFtTO/wKrYqSbb82J1fUZICFLPd4dlhfKzgwKWtlAtd/KRpVeOGROsc/dFPKiXQaigCJhx8risVfx8OykI38oNT7KaVHAkc1ByrUuYXqD28nVS7yRMBX1WR8WV83GayXN3tnDaMfjq1QfP2hGASrjCBcfp1koCGgT8UWs5CgyPTWZU2muvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJ8d1IW5RM2UrO2J79DELfPaF/ux7quRWVnkFoq/iF8=;
 b=FgRt/k86ftw5EmcG2w8US2zqRLpwt9Q8o72YtR4FzK3Pl4w3Eqz+ZBOos6vFo4zObl22OVscoTFiOYvH7cw9waU/Qw+3/DistJCkbxxucM/77SZ9NLQB6nllKRF/6KCxaOGMXl1dvW8O8VlvskUSnydq4++amtYdQUt/+8UbvJk=
Received: from OS3PR01MB7650.jpnprd01.prod.outlook.com (2603:1096:604:14f::5)
 by OSZPR01MB7988.jpnprd01.prod.outlook.com (2603:1096:604:1bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Fri, 27 Aug
 2021 01:35:34 +0000
Received: from OS3PR01MB7650.jpnprd01.prod.outlook.com
 ([fe80::7407:c85b:2ea4:2ba9]) by OS3PR01MB7650.jpnprd01.prod.outlook.com
 ([fe80::7407:c85b:2ea4:2ba9%5]) with mapi id 15.20.4457.023; Fri, 27 Aug 2021
 01:35:34 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "philip.li@intel.com" <philip.li@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 1/3] selftests/sync: Remove the deprecated config SYNC
Thread-Topic: [PATCH v2 1/3] selftests/sync: Remove the deprecated config SYNC
Thread-Index: AQHXmh1P4IEybxgKl0qVPyRSxm2LuKuGSUsAgABJkoA=
Date:   Fri, 27 Aug 2021 01:35:34 +0000
Message-ID: <69835666-1710-5103-fb06-2636a3a3c5bb@fujitsu.com>
References: <20210826015847.7416-1-lizhijian@cn.fujitsu.com>
 <20210826015847.7416-2-lizhijian@cn.fujitsu.com>
 <239339d5-5626-ea04-97db-7dc070a48636@linuxfoundation.org>
In-Reply-To: <239339d5-5626-ea04-97db-7dc070a48636@linuxfoundation.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dff2632f-87eb-4552-951e-08d968faf734
x-ms-traffictypediagnostic: OSZPR01MB7988:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSZPR01MB7988CED6C3980CB5879501F4A5C89@OSZPR01MB7988.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WsVvAnzxRJWPMK0Of7lLFuCn+xthwYGDhn0ZDI1wd9pnvcwhPuo6ylwUMwUqajiN1GAQiHYDQd6QT+nB3GHv4YEws/tsqZugEgj96A7cwK+ESWgH1zu5mt0ft1S/iU4qV1hmObcO5/y90se7xFOkrOSoLbvy77kESUf0qzssA2Kn/w4fdwShWdP9ED+Hm9vTdfacHjJfYRvlFKPBM1irfFb/DOj/fbYT3/qbilEUs4s99XMhDAxiHFf+IuAsthz5FJgExbR8xnSS+I50L4hGYQeJDUPQOL/ALXr5jlEPx+LlzbDgUaeKpOk6u+GyjbgHSIita15cVFo12tdTyXKBWo+hOD/0s1bMDb49KbZWuVH9S3ogXzjbODX+ahYtpXpIkm2GF9KvTSEj3Nt1GlXTrty6EQMQS1Pk3ma2Dnz8QxuSI481DpFkvKYZTwOdzE2ORaAZt30B1+smpCwq4oNRLtXNZHeLHG2tPQiKmA/d0ZdMpNIMjQ9WWQBnHsDIEwgPRzIbHSDPUk2PBN5ryEhN9+LyIHVRY3sbAgRhnLqGQwLspbUMN5gUun3cEQzYraHzbae0Eba5IUZHS6xO+lObzXqE86WbJUUEBZV3nguu7j2QTiyJbRkX+ZGBZdhs2xNeNYFJwUAu7vyuHPahOskd/3gINNGzkmwrffFJcsOfie0D11c9TN4lzcQ/Ztz1t+FERRvb9VbIEmeiXDEJ2cz2d3tBb+D4nwmeaEM7FQI7XMYnASPnk1oHMEFRAz3ahi+aZGwNCqXvH3REGKAaWLvgGYjeOnDwZSvh1a2bC8AicPnO2GFM7LorLUntQcaYcIeG247dPQCTSfGsmHNsRfr9R84N7xTTkz/97yetGyKjMb8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB7650.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(8936002)(66556008)(6486002)(66446008)(2906002)(85182001)(5660300002)(38070700005)(2616005)(86362001)(64756008)(66476007)(83380400001)(478600001)(110136005)(54906003)(4326008)(53546011)(71200400001)(6506007)(8676002)(122000001)(38100700002)(6512007)(36756003)(186003)(31696002)(31686004)(316002)(966005)(26005)(76116006)(66946007)(91956017)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3plZ1k4NllhQ3h3ZTBGOWVHQjh2TUhsSk5saW02UTNzMEZLVzZMbzd4ZEs0?=
 =?utf-8?B?UVNHajZ2aDZIRWJUNlluYVg1eG45MmI3QUxyMkJRWUNOSG5lK1lGZ25FQzV2?=
 =?utf-8?B?UVMrVzdoa3FuWjVFY1N0RnY3Slp1YVV3NGhrbkJ6V296RUYxeDlTNkQ4V2xr?=
 =?utf-8?B?WnV3STQyWmJPZnozSVhOZ0Z1YTEvQWdYYkhJcFM0cEE0dUFzVnZsSTFyY1dz?=
 =?utf-8?B?dDBUMUVPSjA4R0I1VTVmU1NEdkxNSXp5QmI1ampBRlpzL1RMR20wZG4rVkRW?=
 =?utf-8?B?RkFWSWhOMlpENWN4R3kxRGMxZFBhV0NMYjFobDE3clhNNTFrT1NGVlFIWUJ0?=
 =?utf-8?B?ZHc0Uk5ZL1U2NlNTYnBZb3JjQU1lOUNtN1ZOTUkxM0pDM2JZbnRnREhZamRI?=
 =?utf-8?B?NEl0bEg4UUUwN0RxTTIxZG56c3lTK1ByZFRGODF6VXVnYml6bTRjZWs0Q1JG?=
 =?utf-8?B?Vm1ickNTRGN1dGVQSUJVZFhqSzJ6U25adENLMVFXbnJTNFRDNWxaM1l1dUJv?=
 =?utf-8?B?WVpuQXRKNTJwTkJFT0RzTUpkQm1vaStWTFZJL2ZTSkxuN3RYV25CM0kwY1Bt?=
 =?utf-8?B?NFJZV0o5VXVjaTd5TnJrd2RZeXpzc2tvRjVPalpZeElSZGVpVFVsdHZZK3M5?=
 =?utf-8?B?K3dEN2RLaE9UdVB3Z1VBU1MrdzdETWJRT3B1V0dvQTFyN3ZEa2lBbTVzLzNq?=
 =?utf-8?B?cGhjcGFpalhPNWNFWjBHM3daNW1JU1kzeFVhZ1hIWW5td3IxZkFucHU2cURJ?=
 =?utf-8?B?ZGNtd1hWRENxYXRJeGxDS2kwWHdQQUtHUFpYWTdYZG8xOCtEOUZlVWJLdTB2?=
 =?utf-8?B?Zkc5VmJpdnJ0TXVYL3ZWcC9mMElmOGp5SlNuUUptWE1OR2lONzN2YStHWTl0?=
 =?utf-8?B?RTk4N0srREJJdVZ4VlNvNUFLR2lvMVJtVTBlTkprQ3FKZC9vSnJOcmJTcDYr?=
 =?utf-8?B?M04yL1ZZS0szL0hFandMdE92MWYwdmF0ZFpnbStEcm0yT3RxdWtDb1d1TVJs?=
 =?utf-8?B?NmE0aFRMWHZ3TVJSazFFa1dyUEhJRU51dWxLcDllZFdkNHhiRXBXQ1Q2SU9Z?=
 =?utf-8?B?WnNYcUFETXBZdVUwME5SbnU5MS94UFBlRzhpU0kvOCtkMHNVVFlXWk9Mcko1?=
 =?utf-8?B?QW1xUkp3cnVSYzUxTmNxZnprYXhub2x1dVd2MndTbkw2Vi9aQUEvOWRwM29H?=
 =?utf-8?B?dkNzNlhsREZENjRETDdYY3czM1JqQUhDcWpXWlg1SklsUXVxRW0vV0oyWDVF?=
 =?utf-8?B?ZVVjRkdnSGhrbit3ejBnVVlUNm9NTkZlaXIwWmRlVllpTGlNaktrWXYrMzYw?=
 =?utf-8?B?U2ZzSzFiV0pBOUJseW0zL2tyQklQaXA2QWdqeXJYakNHdVNQMUlnQlJzN1A4?=
 =?utf-8?B?dk5iZWh1aEdSRGZvOGp4dm5VaUhmYTJCeEtpK1JuMVVEUkVkVE9hc2RPTHpX?=
 =?utf-8?B?dDg3cXRQd3pTeEIxU0VaMUJ2cy9tc1IxZ0NPa281VGd3S20xdENSK21kT0tn?=
 =?utf-8?B?YmV2MnpjRm94QkUzbHlSRHluVnZyODBqMHdETzJaaUhsV2l6RXpUSDhXWVZj?=
 =?utf-8?B?bWVnTlBZTDlSeDVOTDNZUzNXdDBlRXE2eDlyU2FDU0s5WEFMeG5iSmMrWXN3?=
 =?utf-8?B?RndqQzJnTG9SOTlQS0ZVVkhKcnZqeXYzekxGVm5pZmF3eXBqdmlLWFN6blJ5?=
 =?utf-8?B?ZTZoaGZ3Vk1pRmFtVDRUZlJpaCtTVHV4bjFVcHYrSmVHdHFxT1RzZ0lBMDJw?=
 =?utf-8?B?aFYza0ljR2lpbEZvRUxadmttVWxwZnNycUQzYlpLYXJrQmpWeUN2aldneXlm?=
 =?utf-8?B?WUw1M0tWZEVwSU5hMFY2Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77974BE93D34C54391B55D992307E611@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB7650.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff2632f-87eb-4552-951e-08d968faf734
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2021 01:35:34.7420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gTr8oz46Hj0g6r+m8dSsvIjminKHbCzSPfw/n/ZW7kRrAODKDySmkgAH/k9i8ESBVmBokwFCp+nswES7n76i6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7988
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCk9uIDI3LzA4LzIwMjEgMDU6MTAsIFNodWFoIEtoYW4gd3JvdGU6DQo+IE9uIDgvMjUvMjEg
Nzo1OCBQTSwgTGkgWmhpamlhbiB3cm90ZToNCj4+IFNZTkMgd2FzIHJlbW92ZWQgc2luY2UgYWZm
OWRhMTBlMjEgKCJzdGFnaW5nL2FuZHJvaWQ6IG1ha2Ugc3luY190aW1lbGluZSBpbnRlcm5hbCB0
byBzd19zeW5jIikNCj4+IExLUC8wRGF5IHdpbGwgY2hlY2sgaWYgYWxsIGNvbmZpZ3MgbGlzdGlu
ZyB1bmRlciBzZWxmdGVzdHMgYXJlIGFibGUgdG8gYmUgZW5hYmxlZCBwcm9wZXJseS4NCj4+DQo+
DQo+IENhbiB5b3UgcGxlYXNlIHN0YXRlIHdoYXQgeW91IGFyciBmeGluZyBhbmQgYWxzbyBrZWVw
IHRoZSBzZW50ZW5jZXMNCj4gNzUgY2hhcnMgb3IgbGVzcy4NCj4NCj4gV2hlcmUgaXMgTEtQIHdh
cm5pbmc/IA0KaHR0cHM6Ly8wMS5vcmcvbGtwDQpMS1AoYWthLiAwRGF5KSBvZnRlbiByZXBvcnRz
IGlzc3VlIHJlbGF0ZWQgdG8gdGhlICpyZWNlbnQqIGtlcm5lbCBjb21taXRzL1dJUCBwYXRjaGVz
IHB1YmxpY2x5Lg0KQXMgdGhlIExLUCBrZWVwaW5nIGltcHJvdmVtZW50LCBpdCB3aWxsIGNvdmVy
IG1vcmUgYXNwZWN0cyBpbiB0aGUga2VybmVsIHNvIHRoYXQgbW9yZSBpc3N1ZXMgd2lsbCBiZSBk
ZXRlY3RlZC4NCg0KU28gaW4gdGhpcyBjYXNlLCB3aGljaCBpcyByZWxhdGVkIHRvIHRvbyBvbGQg
a2VybmVsLCBpdCBqdXN0IHJlcG9ydGVkIGl0IGludGVybmFsbHkuDQoNCg0KPiBJbmNsdWRlIHRo
ZSB3YXJuaW5nIGFuZCBleHBsYWluIHdoeSB0aGlzDQo+IGNoYW5nZSBpcyBuZWNlc3NhcnkuDQot
IGl0J3Mgbm90IHJlYXNvbmFibGUgdG8ga2VlcCB0aGUgZGVwcmVjYXRlZCBjb25maWdzLCByaWdo
dCA/DQoNCi0gSW4gbXkgdW5kZXJzdGFuZGluZywgY29uZmlncyB1bmRlciBrc2VsZnRlc3RzIGFy
ZSByZWNvbW1lbmRlZCBieSBjb3JyZXNwb25kaW5nIHRlc3RzLg0KU28gaWYgc29tZSBjb25maWdz
IGFyZSBtaXNzaW5nLCBpdCB3aWxsIGltcGFjdCB0aGUgdGVzdGluZyByZXN1bHRzDQoNCkRvIHlv
dSBtZWFuIHRoZSBjb21taXQgbG9nIHNob3VsZCBpbmNsdWRlIGFib3ZlIDIgcmVhc29ucyA/DQoN
ClRoYW5rcw0KDQo+DQo+PiBGb3IgdGhlIG1pc3NpbmcgY29uZmlncywgaXQgd2lsbCByZXBvcnQg
c29tZXRoaW5nIGxpa2U6DQo+PiBMS1AgV0FSTiBtaXNzIGNvbmZpZyBDT05GSUdfU1lOQz0gb2Yg
c3luYy9jb25maWcNCj4+DQo+PiBDQzogUGhpbGlwIExpIDxwaGlsaXAubGlAaW50ZWwuY29tPg0K
Pj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPj4gU2ln
bmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGNuLmZ1aml0c3UuY29tPg0KPj4gLS0t
DQo+DQo+IHRoYW5rcywNCj4gLS0gU2h1YWgNCj4NCj4NCg==
