Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADE93C181D
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jul 2021 19:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhGHRcP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jul 2021 13:32:15 -0400
Received: from mx08-001d1705.pphosted.com ([185.183.30.70]:5690 "EHLO
        mx08-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229516AbhGHRcO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jul 2021 13:32:14 -0400
X-Greylist: delayed 1150 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Jul 2021 13:32:13 EDT
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 168H4Mjq021137;
        Thu, 8 Jul 2021 17:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=ORnudcUqaiPWv9RTwU5jryvWVZkfpB6qLJqCm+8ZaWs=;
 b=B/QOKzZnWh3UtRoNOkslnRNNrHcqYCGfhVrNzo8WDvKli0j/GUGzDNxRO8opo1AMmH/j
 4dDNNYed2pl6xqzuhrc7cttcQxOE9IFza7Wc/Tk7HYJEEWYH27lXmRiQpH+vKRVVJW6c
 INZk/LvD8l6mGNpp01OqXCtVdHxBj0P/ZKLIuyCofY97vyjf2NKzUInJmnKjTctZzwTC
 Iwk6eC3KiWvI84ARRnzlVEbWtijwsQg4UjxIilWY9uT+vsfF9knyrgEuUDtDeBfVdIi5
 wPP4MwAjyJoFAJzRpkqTXHb2FNdbvZrxD+bojJXRtaezL8wsk6ckm6DV8ZUIyBY0CuZj jQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx08-001d1705.pphosted.com with ESMTP id 39nkju1huk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jul 2021 17:08:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZcelbsTxs4wXY7jNwlnq7/zpRzgAOGI0V5TirrmD7s41u3jnwf3BX+TNICiqEYeUgJYdIJEmRECDhVIxINn9JOut29mXW8znjrIv+k/whjVrlTtYTlEU/knRnbA/5M3Hp395Sd85s9EDEZImpUBUzmuEHcb4CFiGIW4t7mt2yMP7FcoVY0UWGNvwF37cgqgAF0+/01Ib7+K1zTvpWFfu3BkKl3jdgZHH1ElM+kRPkVFohSFl4Re3G/6byHJybigANbH66CQZTL7gH7G35MmR9uifGeGssfK4aqDouQ/M8j3cvFg5fq6VvsAIAmAWTjtoWsGCh3SJ0xTsoxqs5Te1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORnudcUqaiPWv9RTwU5jryvWVZkfpB6qLJqCm+8ZaWs=;
 b=cMIc1qn0i3/juin6t16Edh0RvowjA1XzmNhghbVW4eutvti0vGbVMfY7tNtEW2OeHye4ouZ3DOY3/4vGhqXJHNhw+C1VGEwVFJV58VbArMCK4X2zzSAytq1rH5jITNHrEdgRRjtBKXI5tFV0vqcudQZxN5GakxeahoTSMo45bdaUSn6LmZY4GgKqugYG65kukpr+cMKrUNMyX4Q+jMJkcz4M2ssie1eIRtlw+pw/CZb0kkM8lTcPwL4EU3pr4uWsjnDtiAAO+zrCmeT+bqCcAgKjJSU4YqzTmrnrYV0PXFSMzWpviWGj3FkQ5GuQ5yRrt9hvBHQTQdRrONvR/TRK1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2503.namprd13.prod.outlook.com (2603:10b6:a02:cd::33)
 by BY5PR13MB3876.namprd13.prod.outlook.com (2603:10b6:a03:22c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.12; Thu, 8 Jul
 2021 17:08:24 +0000
Received: from BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::5190:4162:72e8:7998]) by BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::5190:4162:72e8:7998%7]) with mapi id 15.20.4331.012; Thu, 8 Jul 2021
 17:08:24 +0000
From:   <Tim.Bird@sony.com>
To:     <bkuhn@ebb.org>, <gregkh@linuxfoundation.org>
CC:     <mcgrof@kernel.org>, <tglx@linutronix.de>,
        <akpm@linux-foundation.org>, <shuah@kernel.org>,
        <rafael@kernel.org>, <rgoldwyn@suse.com>, <kuno@frob.nl>,
        <fontana@sharpeleven.org>, <Ciaran.Farrell@suse.com>,
        <Christopher.DeNicolo@suse.com>, <hch@lst.de>, <corbet@lwn.net>,
        <linux@leemhuis.info>, <ast@kernel.org>, <andriin@fb.com>,
        <daniel@iogearbox.net>, <atenart@kernel.org>, <alobakin@pm.me>,
        <weiwan@google.com>, <ap420073@gmail.com>, <tj@kernel.org>,
        <jeyu@kernel.org>, <ngupta@vflare.org>,
        <sergey.senozhatsky.work@gmail.com>, <minchan@kernel.org>,
        <axboe@kernel.dk>, <mbenes@suse.com>, <jpoimboe@redhat.com>,
        <keescook@chromium.org>, <jikos@kernel.org>, <rostedt@goodmis.org>,
        <peterz@infradead.org>, <linux-block@vger.kernel.org>,
        <linux-spdx@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <copyleft-next@lists.fedorahosted.org>
Subject: RE: [PATCH 0/2] LICENSES: add and use copyleft-next-0.3.1
Thread-Topic: [PATCH 0/2] LICENSES: add and use copyleft-next-0.3.1
Thread-Index: AQHXc1/2NjCxLPiqcECSnSQ6/aAQZqs4nH0AgACQY4CAACHhEA==
Date:   Thu, 8 Jul 2021 17:08:24 +0000
Message-ID: <BYAPR13MB2503F3D55FACFAE7868731BFFD199@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <20210707184310.3624761-1-mcgrof@kernel.org>
 <YOaZohB/2Z3x5grc@kroah.com> <YOcSwXkpzAFGucXM@ebb.org>
In-Reply-To: <YOcSwXkpzAFGucXM@ebb.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ebb.org; dkim=none (message not signed)
 header.d=none;ebb.org; dmarc=none action=none header.from=sony.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 707f5529-7bb8-4cdf-4080-08d94232feec
x-ms-traffictypediagnostic: BY5PR13MB3876:
x-microsoft-antispam-prvs: <BY5PR13MB387612769CC1E02CBD25DFEBFD199@BY5PR13MB3876.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xn5iMo736jwnPQGqae8jm5uA1/W5X8581jsGlWV97qJXsZM126P3KWzpuH6dDyDyY3kr7qwocZVHieEtRttpmVB5bXe2zPRYztamd1uLiLRSHYrP5Ap4MUBtezCZw64p255PCvp4RdB4jJegaUqmMOexPKYaEzZOGZsdEsOgWPKFLdgTmo1E55N8blZDw2hRox8mVD1uEUu6EW+UCkROyZu/uWoz/XPmnPbOmHyb9aZFozdbvJBYuAUwgRsUq2HUGpB3WTI2Wq9HC1Ub7oVLmZngpTpmFwXtzc9ZC3clHPJA9sdBg8J/PqnkSKmFDi1IizkGCCCM5ZxThUMPzYZqY8dYs3nIntQMw/MydLaK1kNyzAziZEtk/eiK284fJD+l4POJmQHI8w4KFdaS/s8wztb7B1YUaGLADcYvjrFkbjSfIeaWQDswCW6DdbpXq8fCwxq3I4RDRDY2i5HeTy2IbjOmRKxi6YJbLuom/b8v0msPXKI0t63I7JOxiAKcBcFenUs3NeTJ3Pb96+TkzMZoosF5IA1C5TfUvMYzGt9AZzmurlXeFtcpa44GdYQqM3MsNUS3f1Fp/rjrNtkVn8KaTtnHMrGLVptE2GSkGr9cs2cDs2ZxxW4w2Hv15HiLoUabbC6Q0SZwSiCI0Z9Eup7hhVu3d1X9ZcM8duCntEtwihSd7NYube1GOOzGsKsnfQ/QyBWCk4aOfWXa/yWpqsbqEElzbKI3nrJcRdRo+k8c64Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2503.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(8676002)(4326008)(110136005)(54906003)(76116006)(71200400001)(8936002)(7406005)(26005)(86362001)(55016002)(9686003)(316002)(5660300002)(66446008)(478600001)(52536014)(966005)(2906002)(122000001)(38100700002)(33656002)(6506007)(66476007)(83380400001)(66556008)(186003)(64756008)(7696005)(7416002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elQxbHcyVkVpaUdFVXpqbGZyWUJQbXV3NldzNlBUdk1mOHcvWFZWQllyOVE5?=
 =?utf-8?B?K0ZOSEdRQ3laeVd3RE56Y2NNYU9aUzI5NENyRUtVYlRIV2hFMjJPVjV0dzdD?=
 =?utf-8?B?ZGZHQU05RThqY0xBSy9LemZkc0FzS01Bc3RKY3BTdVgyV3FDWEthWENWUCtU?=
 =?utf-8?B?eGl4RHpkZDl5aWJwMkZrRmg5RkRFc2s4K0txbi9iWlA4d2dJZTJWNU1DZ3hr?=
 =?utf-8?B?UVhWTE4xR1IxTE9pRU1tVGQwNGs1V0FnNnFDVjB5L1hpcUFrUWorSGdVMzhi?=
 =?utf-8?B?WGNJUkR4ZDJhTndySEV0eERpUW9paVVGTnBGak1Ba01Da3hiMW9lSlRDNmhk?=
 =?utf-8?B?VzM3SXZSODE3M2lSU2ZkeXJKN2FvRnZ3cUdvSEsybFRPS3dISHJPbStDTmN1?=
 =?utf-8?B?RTNpWkRsWkREdVg0MGQvcjhVYW4wMDNIUkpmdDliWEVlb1FYcmV6SnF2cm1H?=
 =?utf-8?B?ZWsvTWJET0ZmYjNFUXU5SHVyNG0wSStLV1JtRGt1VVozY1JJWFJDTkZEb3V5?=
 =?utf-8?B?NVVOYUtZNllWamlleGRWc1RndmI1WFd2VVBVNjJvemZJTjZ2SGJ6UVhERHZX?=
 =?utf-8?B?dnJJWUY2aVlMbWMyVnJPT1J1SDVwVnJDQ2lPblprK1JDbWJ4S2w4d1UrLzU5?=
 =?utf-8?B?VE9RQjdyQTg0UlBuSkJ1dkJRUUliZFhlTTc4cTBCbG8wTE5JN1dnckF2Q29N?=
 =?utf-8?B?ZjJ6U1R3MGo4ekIvRXZtOFArbE9mVEJpTjZFQ3pJS2VLRGNKMlpzQThRYVNO?=
 =?utf-8?B?Q3diOWNCOStrR3RLMXVDcUJEaUZOaW8wOTgwMWdLaW0zR0JFS3RnWnZ6OUFh?=
 =?utf-8?B?VllsYkhMTXRoamtpTHJBVFhPcHlQMmxRY3o5WUFPQ3lOcWg2ZlhOeEVxdkxu?=
 =?utf-8?B?Sjg1ZFlXcVNjL3dRVkxReHdpWmpHci9hS0tDWk5WLzNlMk5KWFBFODJhNEVC?=
 =?utf-8?B?cWRhS3JoaUJKcFhiWjdBeExmeFZXcm5FTkZwVCtxR24ycFB6aU1CeFR4YWpZ?=
 =?utf-8?B?aVA5d21xdUNqRHdBWHRvU292VGZOMzR0d0xtWWJrb2V5dXV6WFlaLzJEUmtR?=
 =?utf-8?B?MTJYYzhNWG43Nkk1K2JzSnloR3pQVElPdWNCWEhsRDRJTDRWNzJ2TktBN0Rm?=
 =?utf-8?B?QnNQbHRUL1BnZVBEek5vMDNJUjhzQ1JNV3IzWHhidDRFZE8vU0ZpL3NiTEt2?=
 =?utf-8?B?SXU3UEwxcHdhTDJCN25Ld2I1TWZPc3pETlhVVTJHaVhJbEptOTk2N3p4SXNZ?=
 =?utf-8?B?RlhKZ1BGL2NMREFIQzIrTTF6SXgvam1TS2pzVkozeTdjYi9hVkNjK2czamEx?=
 =?utf-8?B?NHVZTUtZSytTbzEyU0tGL1kyWVhuWHdCNEJUSUxxcTBWN2VPb1BnMDVQNFNo?=
 =?utf-8?B?Ymw4VDlneVVnalVtZXNDenUrenlUM1cyTGRMUXFybDg2cmxsbFNiTkRLM1NN?=
 =?utf-8?B?ejhIQUJCWFlYLzc3c2RIZUREcFpyTXZBaXVoQS9UUWV1MFFPTElCV3hTN0ov?=
 =?utf-8?B?eEFOcUhCbFlSTUNaRjB0R2o3cjE5Vlh0Vk9qd2c1MzBMSDNIOUNGVWJ4Z2Jx?=
 =?utf-8?B?cHVBa3V3S1QraUc5aUxER2gxMlpHYTUyd2swQ1JoT1lnYk1ZR2loVnJqM3A3?=
 =?utf-8?B?Si8yc1o3aUJpZWZIWm5YYnh6VDVucGg4TWd6cDByVC9IV1BoWXJhNnB6MFY4?=
 =?utf-8?B?OFAxRFk3Y1JTK2FITkFVdUxjUXV3aDdwd0NhNFFseTJoWDl5eUhBQndDN2F3?=
 =?utf-8?Q?s/Wp7wqfL5+PrN/wSLsJBqU8wtX4QeIWlmurlhx?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2503.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707f5529-7bb8-4cdf-4080-08d94232feec
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2021 17:08:24.0830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wH2HQ3xGULlYNYW4GePoMMuhadrBNwxrvdcAjT3dfPEMx/t/Obes49jFoHIZ+jWstog+50BcA3ru0MkynqaXSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3876
X-Proofpoint-ORIG-GUID: CazF-Lqej73WUBySwVCcSXZJsrWWAzku
X-Proofpoint-GUID: CazF-Lqej73WUBySwVCcSXZJsrWWAzku
X-Sony-Outbound-GUID: CazF-Lqej73WUBySwVCcSXZJsrWWAzku
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-08_10:2021-07-08,2021-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1011 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107080091
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCcmFkbGV5IE0uIEt1aG4gPGJr
dWhuQGViYi5vcmc+DQo+IA0KPiBbIEZ1bGwgRGlzY2xvc3VyZTogSSd2ZSB3cml0dGVuIHBhcnRz
IG9mIGNvcHlsZWZ0LW5leHQsIGhhdmUgYmVlbiBpbnZvbHZlZA0KPiAgIHdpdGggdGhlIGluaXRp
YXRpdmUgYmFzaWNhbGx5IHNpbmNlIGl0cyBpbmNlcHRpb24sIGFuZCBvYnZpb3VzbHkgSSBsaWtl
IHRoZQ0KPiAgIGxpY2Vuc2UgYSBsb3QuICBUYWtlIG15IGNvbW1lbnRzIHdpdGggdGhlIHJlY29t
bWVuZCBkb3NlIE5hQ2wgZ3JhbnVsZXMNCj4gICB0aG9zZSBmYWN0cyByZXF1aXJlLiBdDQo+IA0K
PiBHcmVnIEtIIHdyb3RlOg0KPiA+IEFueSBjaGFuY2UgeW91IHdpc2ggdG8ganVzdCBjaGFuZ2Ug
dGhlIGxpY2Vuc2Ugb2YgdGhlc2UgZmlsZXMsIGdpdmVuIHRoYXQNCj4gPiB5b3UgYXJlIHRoZSBv
bmx5IG9uZSB0aGF0IGhhcyB0cmllZCB0byB1c2UgaXQgZm9yIGtlcm5lbCBjb2RlPw0KPiANCj4g
VGhlcmUgaXMgYSBsb3Qgb2YgZHVhbC1saWNlbnNlZCAoR1BMdjItb25seXx7MiwzfS1DbGF1c2Ut
QlNEKSBjb2RlIGFscmVhZHkgaW4NCj4gTGludXguICBNYW55IGNvcnBvcmF0ZSBjb3B5cmlnaHQg
aG9sZGVycyBoYXZlIHdlbGwgZG9jdW1lbnRlZCBzdHJvbmcgcmVhc29ucw0KPiBmb3Igd2FudGlu
ZyB0aGF0LiAgKFRob3NlIHBvbGljeSBnb2FscyBhbmQgdGhlIGFuYWx5c2lzIGJlaGluZCB0aGVt
LCBJIGZpbmQNCj4gcHJvYmxlbWF0aWMgYW5kIHNvbWV0aW1lcyBvdXRyaWdodCB3cm9uZywgYnV0
IG5vbmV0aGVsZXNzIGl0J3MgdGhlaXIgcmlnaHQgdG8NCj4gbGljZW5zZSB0aGVpciBjb3B5cmln
aHRzIHRoYXQgd2F5LCBhbmQgdGhlIGxpY2Vuc2UgKmlzKiBHUEx2Mi1vbmx5DQo+IGNvbXBhdGli
bGUsIGFzIGlzIEx1aXMnISkuDQo+IA0KPiBJIGFzc3VtZSB0aGF0IHlvdSdyZSBub3QgYXNraW5n
IHRob3NlIGNvbXBhbmllcyB0byByZWxpY2Vuc2UgdG8gcHVyZQ0KPiBHUEx2Mi1vbmx5LiAgV2hp
bGUgdGhvc2UgY29tcGFuaWVzIHBlcmhhcHMgZmFjZWQgZWFybHkgcmVzaXN0YW5jZSB3aGVuIHRo
ZXkNCj4gYmVnYW4gdGhlaXIgZHVhbC1saWNlbnNpbmctaW4tdXBzdHJlYW0gZW5kZWF2b3IsIGl0
IHdhcyB1bHRpbWF0ZWx5IGFjY2VwdGVkDQo+IGFuZCB0aGF0IG9wZW5zIHRoZSBkb29yLCBJTU8s
IHRvIGFjY2VwdGluZyBhbnkgZm9ybSBvZiBHUEwtY29tcGF0aWJsZQ0KPiBkdWFsLWxpY2Vuc2lu
ZyB1cHN0cmVhbS4gIFRoZXJlIGlzIG5vIGNvZ2VudCBhcmd1bWVudCB0aGF0IEkgY2FuIHNlZSB0
aGF0DQo+IHNheXMg4oCcKEdQTHYyLW9ubHl8ezIsM30tQ2xhdXNlLUJTRCkgaXMgc28gc3BlY2lh
bCB0aGF0IGl0IHNob3VsZCBiZQ0KPiBncmFuZGZhdGhlcmVkIGluIG92ZXIgb3RoZXIgZm9ybXMg
b2YgZHVhbCBsaWNlbnNpbmfigJ0uDQo+IA0KPiAoSXJvbmljYWxseSwgSUlSQywgKHRoZW4gYWN0
aW5nIG9uIGJlaGFsZiBvZiBRdWFsY29tbS9BdGhlcm9zLCBMdWlzIOKAlCB0aGUNCj4gcGVyc29u
IHByb3Bvc2luZyB0aGUgKEdQTHYyLW9ubHl8Y29weWxlZnQtbmV4dCkgZHVhbC1saWNlbnNpbmcg
Km5vdyogd2FzIGENCj4gY2hhbXBpb24gb2YgdXBzdHJlYW1pbmcgKEdQTHYyLW9ubHl8ezIsM30t
Q2xhdXNlLUJTRCkgY29kZSB5ZWFycyBhZ28gYmVmb3JlDQo+IGl0IHdhcyBhIHdpZGUgYW5kIGNv
bW1vbiBwcmFjdGljZS4pDQo+IA0KPiA+IEFzIGEgZm9sbG93LXVwIHRvIHRoaXMsIEkgZG8gbm90
IHdhbnQgdG8gc2VlIHlvdXIgInRlc3Rfc3lzZnMuYyIgbW9kdWxlIGFzDQo+ID4gYSBkdWFsLWxp
Y2Vuc2VkIGZpbGUsIGFzIHRoYXQgbWFrZXMgbm8gc2Vuc2Ugd2hhdHNvZXZlci4gIEl0IGlzIGRp
cmVjdGx5DQo+ID4gdGVzdGluZyBHUEwtdjItb25seSBjb2RlLCBzbyB0aGUgYXR0ZW1wdCB0byBk
dWFsIGxpY2Vuc2UgaXQgbWFrZXMgbm8gc2Vuc2UNCj4gPiB0byBtZS4gIEhvdyBjb3VsZCBhbnlv
bmUgdGFrZSB0aGF0IGNvZGUgYW5kIGRvIGFueXRoaW5nIHdpdGggaXQgdW5kZXIgdGhlDQo+ID4g
Y29weWxlZnQtbmV4dCBsaWNlbnNlIG9ubHk/ICBBbmQgd2hlcmUgd291bGQgdGhhdCBoYXBwZW4/
DQo+IA0KPiBCdXQsIGl0J3MgYSB2YWxpZCBjb21wYXRpYmxlIGxpY2Vuc2UsIHNvIHRoZXJlIGlz
IG5vIGhhcm0uICBBbmQsIHNlZSBiZWxvdywNCj4gcmVnYXJkaW5nIHBvbGljeSByZWFzb25zIOKA
pg0KPiANCj4gPiBJIHVuZGVyc3RhbmQgdGhlIGFwcGVhbCBvZiBjb3B5bGVmdC1uZXh0IGluIHRo
YXQgaXQgcmVzb2x2ZXMgbWFueSBvZiB0aGUNCj4gPiAiZ3JleSIgYXJlYXMgYXJvdW5kIGdwbHYy
LCBidXQgZ2l2ZW4gdGhhdCBubyBvbmUgaXMgcnVzaGluZyB0byBhZHZpc2UgdXMgdG8NCj4gPiBy
ZWxpY2Vuc2UgYWxsIG9mIHRoZSBrZXJuZWwgd2l0aCB0aGlzIHRoaW5nLA0KPiANCj4gQ29uc2lk
ZXIgbWUgdG8gYmUgdGhlIGZpcnN0IHRvIGFkdmlzZSB0aGF0ISAgSSByZWFsaXplIGl0J3MgYSB0
b3VnaCB0aGluZyB0bw0KPiBkbywgYnV0IGV2ZXJ5IGdyZWF0IGFkdmVudHVyZSB0byBzb2x2ZSBh
IGJpZyBwcm9ibGVtIHN0YXJ0cyB3aXRoIGEgZmlyc3QNCj4gc3RlcCEgIEkgZnVydGhlciByZWFs
aXplIGl0J3MgYSBub24tc3RhcnRlciwgYnV0IHBsZWFzZSBkb24ndCBzYXkgYWdhaW4gbm8NCj4g
b25lIGhhcyBhZHZpc2VkIHlvdSBzdWNoIQ0KPiANCj4gQlRXLCB0aGUgb25seSByZWFzb24gSSBk
aWRuJ3QgYWR2aXNlIGl0IGJlY2F1c2UgSSBrbm93IGEgdG9wLWxldmVsIGxpY2Vuc2UNCj4gY2hh
bmdlIGF3YXkgZnJvbSBzdHJhaWdodCwgbm8tZXhjZXB0aW9ucy9uby1hZGRpdGlvbmFsLXBlcm1p
c3Npb25zIEdQTHYyLW9ubHkNCj4gaXMgYSBub24tc3RhcnRlciBmb3IgdGhlIExpbnV4IGNvbW11
bml0eS4gIChHcmVhdCwgQlRXLCB0aGF0IHlvdSd2ZSBzdHVjayBzbw0KPiBmaXJtbHkgdG8geW91
ciBzdGVhZGZhc3QgcGxhbiBvbiB0aGlzISkNCj4gDQo+IEdyZWcgY29udGludWVkOg0KPiA+IHRo
ZXJlIGlzIG5vIG5lZWQgdG8gZW5jb3VyYWdlIHRoZSBzcHJlYWQgb2YgaXQgZ2l2ZW4gdGhlIGFk
ZGVkIGNvbXBsZXhpdHkNCj4gPiBhbmQgY29uZnVzaW9uIHRoYXQgYWRkaW5nIGFub3RoZXIgbGlj
ZW5zZSB0byBvdXIgbWl4IGNhbiBvbmx5IGNhdXNlLg0KPiBSZWxhdGVkbHksIENocmlzdG9waCBh
c2tlZCAoZm9vdG5vdGUgbWluZSk6DQo+ID4+IFdoeSBkbyB3ZSBuZWVkIGEgcmFuZG9tIHdlaXJk
byBbMF0gbGljZW5zZSBpbiB0aGUga2VybmVsIHRyZWU/ICBJcyB0aGVyZQ0KPiA+PiBhbnkgYmVu
ZWZpdD8NCj4gDQo+IFRvIGJlIGZyYW5rLCB3ZSBpbiB0aGUgY29weWxlZnQtbmV4dCBjb21tdW5p
dHkgd2VyZSB2ZXJ5IGV4Y2l0ZWQgdG8gbGVhcm4NCj4gdGhhdCBzdWNoIGR1YWwtbGljZW5zZWQg
Y29kZSBoYWQgYmVlbiBhZGRlZCB0byB1cHN0cmVhbSBMaW51eCwgYmFjayB3aGVuIGl0DQo+IHdh
cyBtYW55IHllYXJzIGFnby4gIEl0J3MgYSB2b3RlIG9mIGNvbmZpZGVuY2UgZnJvbSBhIHdlbGwt
a25vd24gZGV2ZWxvcGVyDQo+IHdobyByZWFsbHkgaXMgZXhjaXRlZCBhYm91dCBvdXIgcG9saWN5
IGdvYWxzLiAgRk9TUyBsaWNlbnNpbmcgaXNuJ3QganVzdA0KPiBhYm91dCBzaW1wbGljaXR5IGFu
ZCBjbGVhbmxpbmVzcy4gIExpa2UgYnVkZ2V0cywgd2hpY2ggc2VlbSBkcnkgdG9waWNzIG9uDQo+
IHN1cmZhY2UsIHRoZXkgYXJlIGFjdHVhbCBtb3JhbCBkb2N1bWVudHMgdGhhdCBtYWtlIGEgc3Rh
dGVtZW50IGFib3V0IHRoZQ0KPiBwaGlsb3NvcGh5IGFuZCBhc3BpcmF0aW9ucyBmb3Igc29mdHdh
cmUgZnJlZWRvbSBieSB0aGUgbGljZW5zb3IuICBPZiBjb3Vyc2UsDQo+IHdlIGFsbCBrbm93IGl0
J3MgY29tcGxldGVseSBzeW1ib2xpYyB0byBkdWFsIGxpY2Vuc2UNCj4gKEdQTHYyLW9ubHl8Y29w
eWxlZnQtbmV4dCksIGp1c3QgbGlrZSBpdCdzIHB1cmVseSBzeW1ib2xpYyB0byBkdWFsIGxpY2Vu
c2UNCj4gKEdQTHYyLW9ubHl8Mi1DbGF1c2UtQlNEKSB1cHN0cmVhbSBbMV0uIA0KDQpJdCdzIG5v
dCBhdCBhbGwgcHVyZWx5IHN5bWJvbGljIHRvIGR1YWwgbGljZW5zZSAoR1BMdjItb25seXwyLUNs
YXVzZS1CU0QpLg0KVGhhdCBkdWFsLWxpY2Vuc2luZyBoYXMgYWxsb3dlZCB0aGUgaW50ZXJjaGFu
Z2Ugb2YgYSBsb3Qgb2YgY29kZSBiZXR3ZWVuDQp0aGUgQlNEIFVuaXhlcyBhbmQgTGludXgsIHRo
YXQgb3RoZXJ3aXNlIHdvdWxkIG5vdCBoYXZlIGhhcHBlbmVkLg0KDQpJdCdzIHZlcnkgbXVjaCBp
biB0aGUgc3Bpcml0IG9mIExpbnVzJyB0aXQtZm9yLXRhdCBjb21wYWN0IHRvIGFsbG93IHRoZSBC
U0QgVW5peGVzDQp0byBiZW5lZml0IGZyb20gaW1wcm92ZW1lbnRzIG1hZGUgdG8gY29kZSB0aGF0
IG9yaWdpbmF0ZWQgdGhlcmUgYW5kIG1hZGUNCml0J3Mgd2F5IHRvIExpbnV4Lg0KIC0tIFRpbQ0K
DQo+IEJ1dCBpdCBtYWtlcyBhIHN0YXRlbWVudCB0aGF0IEkNCj4gdGhpbmsgaXMgYSBnb29kIG9u
ZS4NCj4gDQo+IEZpbmFsbHksIHdoaWxlIEdQTHYyLW9ubHkgY29tcGF0aWJpbGl0eSBoYXMgYmVl
biBhIG1haW5zdGF5IHNvIGZhciBpbg0KPiBjb3B5bGVmdC1uZXh0IGRyYWZ0aW5nLCBpdCdzIG5v
dCBjbGVhciB0byBtZSB0aGF0IHdlIGNhbiBrZWVwIHRoYXQNCj4gY29tcGF0aWJpbGl0eSBmb3Jl
dmVyIGFuZCByZWFjaCBjb3B5bGVmdC1uZXh0J3MgcG9saWN5IGdvYWxzLiAgVGhlcmUncyBiZWVu
DQo+IG5vIGRpc2N1c3Npb24gb2YgdGhpcyB5ZXQsIGJ1dCBpdCdzIGNlcnRhaW5seSBpbiB0aGUg
cmVhbG0gb2YgcG9zc2liaWxpdHkuDQo+IElmIEdQTHYyLWluY29tcGF0aWJpbGl0eSB1bHRpbWF0
ZWx5IGhhcHBlbnMgaW4gZnV0dXJlIGNvcHlsZWZ0LW5leHQgdmVyc2lvbnMsDQo+IGhhdmluZyBk
dWFsLWxpY2Vuc2VkIGNvZGUgb3V0IHRoZXJlIHdpbGwgYmUgYSBodWdlIGhlbHAgYXMgaXQgd2ls
bCBhc3N1cmUNCj4gdGhhdCBjb2RlIGNhbiBmb3JldmVyIGJlIHVzZWQgYm90aCBvbiBHUEx2Mi1v
bmx5IGFuZCBjb3B5bGVmdC1uZXh0IHNpZGVzIG9mDQo+IGZ1dHVyZSBzaW5nbGUtbGljZW5zZS1w
cm9qZWN0IGVxdWF0aW9ucy4NCj4gDQo+IFRoYW5rcyBmb3IgbGlzdGVuaW5nOyBvZiBjb3Vyc2Ug
aXQncyB0aGUgc29sZSBwcmVyb2dhdGl2ZSBmb3IgdGhlIGNvcHlyaWdodA0KPiBob2xkZXIgdG8g
ZGVjaWRlIHdoZXRoZXIgdG8gY2hhbmdlIHRoZSBsaWNlbnNlIG9mIHRoZWlyIGNvZGUgb3Igbm90
LCBhbmQgSQ0KPiBob3BlIHRoYXQgdGhleSBkb24ndCBib3cgdG8gcHJlc3N1cmUsIGp1c3QgYXMg
UXVhbGNvbW0gd291bGRuJ3QgYm93IHRvDQo+IHByZXNzdXJlIGlmIHlvdSBzdGFydGVkIGFza2lu
ZyB0aGVtIHRvIHN0b3AgZHVhbCBsaWNlbnNpbmcgYWxsIHRoZWlyIHVwc3RyZWFtDQo+IExpbnV4
IGNvZGUgdW5kZXIgQlNEIGxpY2Vuc2VzLg0KPiANCj4gWzBdIEJUVywgQ2hyaXN0b3BoLCBJIHJl
bWVtYmVyIHdoZW4gSSBzdGFydGVkIGluIEZPU1MgaW4gdGhlIGVhcmx5IDE5OTBzLA0KPiAgICAg
ZXZlcnlvbmUgY2FsbGVkIHRoZSBHUEwgYSDigJxyYW5kb20gd2VpcmRvIGxpY2Vuc2XigJ0uICBU
aGUgaW5jdW1iZW50IGFsd2F5cw0KPiAgICAgc2VlbXMgbm90IGFzIHJhbmRvbSBhbmQgd2VpcmRv
IGFzIHRoZSBjaGFsbGVuZ2VyLg0KPiANCj4gWzFdIFRoZXJlIGlzIHRoZSBhcmd1bWVudCB0aGF0
IDItQ2xhdXNlLUJTRCBoYXMgZmV3ZXIgcmVxdWlyZW1lbnRzIHRoYW4NCj4gICAgIEdQTHYyLW9u
bHk7IGhvd2V2ZXIsIHRoYXQncyBub3QgYW4gYXJndW1lbnQgdG8gcmVsZWFzZSB0aGUgY29kZQ0K
PiAgICAgKnVwc3RyZWFtKiB0aGF0IHdheSwgaXQncyBhbiBhcmd1bWVudCB0byByZWxlYXNlIGEg
c2VwYXJhdGUgdmVyc2lvbiB1bmRlcg0KPiAgICAgMi1DbGF1c2UtQlNELg0KPiANCj4gLS0NCj4g
QnJhZGxleSBNLiBLdWhuIC0gaGUvaGltDQo+IA0KPiBQbHMuIHN1cHBvcnQgdGhlIGNoYXJpdHkg
d2hlcmUgSSB3b3JrLCBTb2Z0d2FyZSBGcmVlZG9tIENvbnNlcnZhbmN5Og0KPiBodHRwczovL3Nm
Y29uc2VydmFuY3kub3JnL3N1cHBvcnRlci8NCg==
