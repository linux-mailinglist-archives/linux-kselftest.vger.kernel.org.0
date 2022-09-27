Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24125EBE89
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Sep 2022 11:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiI0J0d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Sep 2022 05:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiI0J0M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Sep 2022 05:26:12 -0400
X-Greylist: delayed 1375 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Sep 2022 02:25:29 PDT
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281453DF2B
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Sep 2022 02:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1664270729; x=1695806729;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7G2Zuqnv3xICQcUy1w/POVgyl/Hrguq0l1roZlxJlEk=;
  b=Rtw3Nm1HIJFYHrJmPP4rZLPKZNqNKwUGLADtNs65oeiqFVwIX6je7S30
   N41Z33K2tYcDxriVYIgL3WGGgAVamaYd+b9q0dCrx27hkrcbpKlTuzZnH
   +rL8AZkZjMbMlExqfy8RWFWDn+Sc/RJGm1PeJRJ0ZVtSrmbuk5qahm6UO
   haSJadSpKUE/K/np6yggrnVJCIrNC1y4RUdbhSdQuKk/cku9I0HC4ScYF
   JwUGrdFm5sZ8Aofxt/FvR74ixSGXetQbGG+kmbRt6LP+fcNzBsu0nr3YZ
   zDeoxnJaCZkAd5d1FBG1VHbSjuZnbEJBlm+qqSXfU7kiv4RZrwyHKwN1C
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="66277569"
X-IronPort-AV: E=Sophos;i="5.93,348,1654527600"; 
   d="scan'208";a="66277569"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 18:02:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/Mq25Y2J8yHNy0g9+gFZle3JTnavDCPiUvX0NNtooVRsnlieRxAGjV5DMX/ZfS/Whvsto/HG/H9SMNq7H44zmZJPlSct4Kkt/zKq6C+oBdn4lYkOXkZvc8S1KOmXrjeD78OikCe5RqpwNQUFZlFHqjbbf8uV7iBgpk7pSdfdh0lxAm3NW8c+ojHhwMXFU4VR2BXle0JnKw4hd84j29sSMm2/QVsCvIUXqS0bZEJ/2ozeHxn611MMGEB713B/yVJVu4DDsYXT8trSOFkCjKJk91s07nKrz+5GI8Elr9YVOh+Pijr/Wo2TAQK1vJmLW+bdQnqeIh8xtH0oK06KMwwng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7G2Zuqnv3xICQcUy1w/POVgyl/Hrguq0l1roZlxJlEk=;
 b=JwE/iD8GAitJng5hmV6NT1Qd98N6jCidWnEIy0RYrhWvlYXOapGHHeSZtL7tQ+zmYUZZlNzUx9ANvYTceqx/xDryxQvrljNBXKYsH+leo58Iw+9h8mGqXpo+5ufCef07e52TNA4sEvybxsPAxiU4uoLtaDu46vZZL1ErdrZ9ytFQuN/vZwNBNPlsn5gQJjH4nYlKFgJ6oJ27AQ79OuxTVhicJLj2Wpouf4UzL2BJayXtXZ9M5jgUoyUWxdHiNa/xRxJaSysFBgSiqgR7bRN3rCJLTtGII6t5sJE3ikCl0KJ1yRlcfd/iCt3tvclqhqtYjqvRWUcIKOqz9FKK+q7Lmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by OSZPR01MB6229.jpnprd01.prod.outlook.com (2603:1096:604:ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 09:02:08 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b0c7:c573:a888:8099]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b0c7:c573:a888:8099%5]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 09:02:07 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'Reinette Chatre' <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 4/5] selftests/resctrl: Kill the child process before
 exiting the parent process if an exception occurs
Thread-Topic: [PATCH 4/5] selftests/resctrl: Kill the child process before
 exiting the parent process if an exception occurs
Thread-Index: AQHYx90D2PkWQvR5sUOQcnTxoVj/y63rxvgAgAc+4oA=
Date:   Tue, 27 Sep 2022 09:02:07 +0000
Message-ID: <TYAPR01MB63307858164BED63E126779B8B559@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com>
 <20220914015147.3071025-6-tan.shaopeng@jp.fujitsu.com>
 <9094c887-afbc-98b5-33eb-f448ea8ee4ba@intel.com>
In-Reply-To: <9094c887-afbc-98b5-33eb-f448ea8ee4ba@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMDktMjdUMDg6MjY6?=
 =?utf-8?B?MDdaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD02OWI2YTNhZC1hZDBkLTQ3ZDUt?=
 =?utf-8?B?ODQyNS0xZGY3ODFiNmRmYWM7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: b693b73529f047769a5a10179a861d9f
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|OSZPR01MB6229:EE_
x-ms-office365-filtering-correlation-id: 0646bdcc-0999-4db6-e2e4-08daa066f4ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x/ieZ/xz73s1Oz7DvwPUwSSJTYwz8NMuqQhDN8Z58hjyJbmDYS/ibfUbC4e0TqDqJx0LCR7EdFMsusj03hsWjaaJ/NTEJLh2uMDxfCTVum3tAe7gC+hP6w0OLVkdX/TMby4JkqVnfLoBvKB21nG+kk6te4YXWtwhYpiqSQU40AKxpRKi1MhqgxZr8d38L18keYkuV9KzHJ09LGn3QsiFLhWfi7gPD3x12kAF1TAAuMshSA8ULRVG0ZDzY+WqB+UFo0nutiprVRhdnSdSm1jIgebQC51SdAH+ow648NFO+uFjw+5eV7CfWMLicEixiKAb07ewfov2FeP4kjs9J2FfBSiUV/jzOt1cQPW4f6s+XZtgpHOS7wJr9BsoaM/3+B8ZxTjrUqMhWpkhiMa5zIxzUodNQKcIHQpUT3ZHgwWNXZBIIXYhitev4ndmRuR77LRr30w65mnImvAZaUp2Rdx8eiaW6O3YJ8ZL7H+l+6e+xF+bCiNnfobBV4XkD3VrYcf+xNI/XJYjQWntOzVWJvrBN4Ah7dYNcenwRJq9+WQIMEcaUQqa/yRruYEcNljzzNiOzzx2mtH9mJgEJhcgowDu9cEvc8Lm42bDKwjr0DJDU0eEqdmcJhrUAM/kp+owBiv/0xFzww/FBHnExS7hUsubwbFZfqTRb1Hk2CDX8VffCuOok7fszgq4jLWcJFFV31wJUpKz08D5I2RTaJKR9+xU94A7so2oqYF6KIaFWVVpQvEECQcoeIOQy0tR3fiDn6zDBjl4GTcMKiEDuqd3fzWisR78JwAxdj55s607Ds4Isfg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(1590799012)(451199015)(55016003)(83380400001)(186003)(122000001)(38070700005)(82960400001)(38100700002)(8676002)(4326008)(64756008)(66446008)(54906003)(316002)(2906002)(76116006)(4744005)(41300700001)(5660300002)(66476007)(26005)(52536014)(6506007)(53546011)(8936002)(71200400001)(66946007)(9686003)(110136005)(66556008)(7696005)(478600001)(33656002)(85182001)(1580799009)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjgwTWhwZHgxMmkyRURQS3lyL1ZpWUxTRWFaNWJ5d1psdVF1UHh1VjM1RGVV?=
 =?utf-8?B?QlQ3MkhyWWo5WTJHYmxORWNFTVRDdzJreVNEUkZxamxiMVRibVNsb0E3TENP?=
 =?utf-8?B?QXBwOWU0YndZZFBjYXdkODRuSC9ydDBqMkJ3NDM4aUdua25WQTJGVXYrdkpO?=
 =?utf-8?B?Y1czbExYczhiWjdNTGluYUlpYmNobnlHdXdZSVQ2Z2xSL29lUmtaYk10KzA4?=
 =?utf-8?B?QXlHbDJvdGN1MGc0MkNQWHBkVkx5R2Q5b25WZEJZS1dLZDJhRmFsWUt0TmtH?=
 =?utf-8?B?czAyZ3I0Y2R4MVVRVFlFRU5vRUtSQXJsUXVORm1uZm9qMVpoUUJjMXRqOUZo?=
 =?utf-8?B?UVRBVm9zeHBFdnBiMTdsUFpVZG5GWWxkNDdZMTgxdnZzUEdvay90SGJPczMv?=
 =?utf-8?B?bW1sZWYzNnhlTk5YdGN6UEw0cTFKRmcxanM5cnpJeUhkMGt4VE5qK2k3Q0pt?=
 =?utf-8?B?WHZZaDlUYjdpM3F5TTByYU42SjV3YVMxVWVKZXZOUmdKb1hzTCswbnR1TXBD?=
 =?utf-8?B?aVF1ckVEUkFVMzBXVklGNGtCTThYRGhuUjVjbzVpd0YxTGxET0RjL1FXWUxs?=
 =?utf-8?B?dFlZOG1qSUdueEtud1V4dDJpRlBtWTJpeWtET09SR21MVTBVZXVhQkh1dldy?=
 =?utf-8?B?VXJsdXJNeFBtRlFiUGM3WkIwNy82ejM0aDNibkdBMGxBVkJPdk5yYVNoV2d1?=
 =?utf-8?B?cVEzZ1NTbTZpRGExaFN0dTNsOWp2VjBraHJHVTMwcXAyVEx2NzA5eG83V3Uy?=
 =?utf-8?B?VVhFWTRkSFFYVHM2R3FGVzNqWnVMNnpoL01LWklHckFSQTVuQVU3bHZueEtw?=
 =?utf-8?B?MmFoTXFKNWt0cDhHOVVYR3c0bFhLTWxsaGFkRitPNkhaaUFKWmgyalkrb2w1?=
 =?utf-8?B?ZVFVbzBRU1UzYkVEVkw3OG5iU0MrZStPclRJcUJZbXRTaXcrNWI5ekY1dTFW?=
 =?utf-8?B?VDU4MXBEckp2ektKQm42VTVqYXlzdDJQdlMwaWhUNm9xTitlRFlqQ2FRNnhB?=
 =?utf-8?B?UmI2N3NsTG9MRmhBckJLWnFCYzBUUlU4NnhYL0dWSEdJcmFyQlBManhVNlVl?=
 =?utf-8?B?UUlBTzVDOHRFcWV6N1Z6QW5zbFA2UXkyQUcwNlByWmFnZXZDMnFPVmhNOWFR?=
 =?utf-8?B?MExKb1F0Y2dUOThlWVNQMTdSTGU5VjByNVEycVZCZGZsQVdkamU4TGtFNWg2?=
 =?utf-8?B?ZjlnNzVweGtVWWJhK0tGaUJRSklmcG44YkRiWkx0WUtObm9pZFJWNFFuSmdz?=
 =?utf-8?B?MFhLZDNaZDNhQkJOZ1RzUDcvUzB5Mm9pbzA2bENDV1ZwMzh4Vk4rVVlGeUVp?=
 =?utf-8?B?ZUFwdkwxUU1sZG1yRUIyTzZ6SmQ2Umk0K0lYVGFVM2hXYWg3NkFWVEFVVjYv?=
 =?utf-8?B?VGV4UEQyY2wvQ0l6WWVvRU1SVE5xeWp0L3g0aVJYM1lBYUViU2t5eU1GbTZD?=
 =?utf-8?B?UjdwQVpPTzlPMDZHbmFsc1RxU2xZRk9keTJiTEVTdWpaMGs1cTgyTUtxSms1?=
 =?utf-8?B?TkdQZ3cyTFlGV01MeGx3cFcyQ2JKWVBLdkRiZkdTNWFuR3NvblNJVTZ5RlNK?=
 =?utf-8?B?clJsK1BIbDhpUndOUzdaeklWZStleEdNV2MrZ2pidzRUbG1xOENjUXkyU282?=
 =?utf-8?B?R1ZWQk9XSDRWWkdtWit6YlRUUWduUWNlMTJrMGVOM0I1UDFMOGk3alRuUWgw?=
 =?utf-8?B?RjNlQlJrL1p2c1lIdURaYWlNRWZXTThHWlJMVWhja3gxTGNDVW5maXJENVd1?=
 =?utf-8?B?cUloem5oNm5CbWx4dlZJT0s0SHhPM3VIdnlHVmV0clhaaTdzenN0clBrRnNV?=
 =?utf-8?B?K1JGT2NsSlZad0FzZGFJalFEU1RVTXowSDdNeldCNk9FZWFRRzBHYStXdkZv?=
 =?utf-8?B?UHZtKzNrMmNHM3M2eUU3WWt3R3RhM1ZOU2NiOHVMSVBoSEREVUhEYVltR0JQ?=
 =?utf-8?B?VnFwK2ZnVnZENHhTV3ZuQ2pMR1poZGlVTnd1dm1DU29yaDNwSEc4dndFdk5x?=
 =?utf-8?B?QXJIV3pWYlFubWd1Y1VPMWhzVHU4TzRQUTJaNnl5TkEzaEdIcTZtSFRscGlr?=
 =?utf-8?B?TG1kVGtxVXVxQlBxZVFOdjQrUzBpSUg4THlyTmhBQU1CbmczWlV4djk0b1R4?=
 =?utf-8?B?Q00zNStPaHp3K2R3akp3QjdRK3BRK1psaVgwNXp6VlRDWUN5VjVVOVFjOGFR?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0646bdcc-0999-4db6-e2e4-08daa066f4ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 09:02:07.8088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hQj/EJwPTkxA7VCie7GjcCqO0ITUNQ78eqLtaAoEDL3M8TimFPr2uqre8brWvfJmSxKRMSnlw6b+y1cVSMAlGimHl/R/1noI9Ool5FCbYIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6229
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgUmVpbmV0dGUsDQoNCj4gT24gOS8xMy8yMDIyIDY6NTEgUE0sIFNoYW9wZW5nIFRhbiB3cm90
ZToNCj4gDQo+IC4uLg0KPiANCj4gPiBAQCAtMjE4LDExICsyMTksMTEgQEAgaW50IGNhdF9wZXJm
X21pc3NfdmFsKGludCBjcHVfbm8sIGludCBuLCBjaGFyDQo+ICpjYWNoZV90eXBlKQ0KPiA+ICAJ
CQl9DQo+ID4gIAkJfQ0KPiA+ICAJCWNsb3NlKHBpcGVmZFswXSk7DQo+ID4gLQkJa2lsbChibV9w
aWQsIFNJR0tJTEwpOw0KPiA+ICAJfQ0KPiA+DQo+ID4gLQlpZiAoYm1fcGlkKQ0KPiA+IC0JCXVt
b3VudF9yZXNjdHJsZnMoKTsNCj4gPiArb3V0Og0KPiA+ICsJa2lsbChibV9waWQsIFNJR0tJTEwp
Ow0KPiA+ICsJdW1vdW50X3Jlc2N0cmxmcygpOw0KPiA+DQo+IA0KPiBGcm9tIHdoYXQgSSBjYW4g
dGVsbCBib3RoIHBhcmVudCBhbmQgY2hpbGQgd2lsbCBub3cgcnVuIHRoaXMgY29kZS4gU28gYm90
aCB3aWxsDQo+IGF0dGVtcHQgdG8gdW5tb3VudCByZXNjdHJsIGZzIGFuZCB0aGUgY2hpbGQgd2ls
bCBhdHRlbXB0IHRvIGtpbGwgUElEIDA/DQoNClRoYW5rcyBmb3IgeW91ciBhZHZpY2UuIFRoZXJl
IGFyZSBwcm9ibGVtcyBhcyB5b3UgcG9pbnQgb3V0Lg0KSSB0aGluayBpdCBpcyBjb21wbGljYXRl
ZCBpZiB3ZSBmaXggdGhpcyBidWcgbGlrZSBNQk0vTUJBL0NNVCB0ZXN0IHVzaW5nIHNpZ2FjdGlv
bigpLg0KSXQgc2VlbXMgdGhpcyBidWcgY2Fubm90IGJlIHNvbHZlZCBlYXNpbHkuDQpQbGVhc2Ug
Z2l2ZSBtZSBzb21lIHRpbWUuDQoNCkJlc3QgUmVnYXJkcywNClNoYW9wZW5nDQo=
