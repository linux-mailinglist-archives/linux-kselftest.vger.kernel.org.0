Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD4C620B3B
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 09:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiKHIdZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 03:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbiKHIdY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 03:33:24 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Nov 2022 00:33:21 PST
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B4A24D;
        Tue,  8 Nov 2022 00:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1667896402; x=1699432402;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EjDmmRMVf+5y4EWPIEurzssjbJv4VAdsZRukITBJaRE=;
  b=cqlhRrd94J8E4RPUHYKPFLK26Sri5EiFfKF4DWSt8X5+jdDhLujyDDZj
   gNdcvRh/aQFuttbZ0T/dJzVAojtLiP5tNcRHw5XHLGEfr6FX4LRPfyCxt
   xoPD9GE4CVCymWGb9VHRgOWAczyMxL3ZDqJJNVfH9heqUpmwUkp/iPu5H
   /I7EWqEaP+pmpBMbZhHHM/5mLoHVwOVWS7n3RBszz35iEKDolrJD6vtHx
   HtYzibUFIGXRwKu27iUpePN0hFIaYgLtVznSUaC+P8WslX0TwwJCQbpp5
   FOdPJQGBWMhMMzvWrHhvQdjWmo5OXFdFlFZivG/rUsk+il+26EDsRUMDt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="69353548"
X-IronPort-AV: E=Sophos;i="5.96,147,1665414000"; 
   d="scan'208";a="69353548"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 17:32:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfhRxx6Iw6h6tz5233apMnkVV1SU0stI0D2OmIq2JaUlRShQ6UtiPmFUWz9u2+owgLbLF8rlRYv5Ik4lm+X8kzpQD7KJtPedofpGqp/hyySjI5Cb3tMnzjUxq4fvQoywJtnDv6RtbBCg3roLKiFjhxswnP8RgZIoV4Y5Emnoh9FwmF7uogJLLYBa/3j9WmjiGLifjcvvRVzHiFOBN7tmPHsEEBJSR74jIoqPxB/imH4LHTPZLIvGM5hltDk8V7X0HD0FIEtBQHVW8WnC40lBeYsRs9jFCDYRF5YuEaPwFcusGAJhFP761FOpP8hSYSFBtf/6XUPZ1AeYb5RwkaEv/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjDmmRMVf+5y4EWPIEurzssjbJv4VAdsZRukITBJaRE=;
 b=DXoaciHR1hu0MfUa8jEFkeLlT5w5bC3XGs9gRlPgVHRiKuSFrcQ50SIYD3lJI026z3ogG7KJSSekXu6BFiD6n3dylHXqpXXkIUI17z7IobBOfzq0SlGxOAIcbP86+of1gh4e+NtqENuFE8AydRdj6GMSkMjU5hVoaKwXRLUQu8kQUFg64SqtboHyNn3CNahaW2rnnSq5pix0CKi0sXfSp6kHMQnXWGJn+36v3Tv1KdceITneLUVJngc5x89+sZ1s/G1mKHlXWbCJpYaS0K5jIGG04suXEH8eid6DbYFKsFrcSSm9AK6uGWovTDq7YV3l0wqi85k3kazOWhnJIw599g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by OSYPR01MB5496.jpnprd01.prod.outlook.com (2603:1096:604:85::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 08:32:10 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::d69b:627a:eabb:b463]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::d69b:627a:eabb:b463%7]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 08:32:10 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     'Reinette Chatre' <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v3 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
Thread-Topic: [PATCH v3 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
Thread-Index: AQHY7dcknINu24UajUut23FYdzv5+q4rYviAgAiyuwCAAEoNsA==
Date:   Tue, 8 Nov 2022 08:32:10 +0000
Message-ID: <TYAPR01MB63300E29EB4C3AF501E28D5F8B3F9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20221101094341.3383073-1-tan.shaopeng@jp.fujitsu.com>
 <20221101094341.3383073-5-tan.shaopeng@jp.fujitsu.com>
 <39586b57-aad2-d9ca-df12-67f1dfe60258@linuxfoundation.org>
 <2ab9ca20-c757-7dd8-b770-2b84d171cbfb@intel.com>
In-Reply-To: <2ab9ca20-c757-7dd8-b770-2b84d171cbfb@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMTEtMDhUMDI6NTY6?=
 =?utf-8?B?MzdaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD0yMTk4YzQ2NC0xOTNkLTQ2NTct?=
 =?utf-8?B?YmYwMC04YjEwNjQ3ZTY2ZGY7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 29d46182667045cebaddb0c37028b8f3
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|OSYPR01MB5496:EE_
x-ms-office365-filtering-correlation-id: d59634ce-966c-4581-8746-08dac163bad1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mfqUfhf2Z44mHsOzaPaM/vZya5vyp2soSYCVKRnTpU4gf/Iextc1wIwH8dUj1513oOnpmfgpXW9oOZcZ5RHW3VekNg0X2P54n0YFCHRNxnZb3CMgmRkLt309OdpXAGSWSHpqeOMz8+vPe60fORLU+aykh4CJizphB4KwL13t8E4OCMWaTHdsARRatH9Woh+6OvAT+pQrP4/0TaFxUwotpAthKIoXu4YOshdAtjn4L7R2dFgTewOBlpYqd8HJEjXhwsWIfydbEVn8L/3eKRgEeudvJQkfcUZfovLkfWzq1iUBfuzYVvIHUjd1CW/lK81IPa+AI+WCE25q4V4TVhI2wBmSgusWM7CrZytVpOn+HRVrfDRc7j8Mv1nQLSuchHjsWM5v+gAj+97NXVH8I2OEG8XxRy6BMcQhlFfEvdHdnmY82WODcCk4MyXaYPEqW5icPf5dvsOpZ4YsjKeI1+XXDPJ/FhfjzpW1auRLk9UrlvRH4OA9FGXoIMxqE/a+ngC82cy5/voOew4SSsEil9qHfCLbtSKlm1D+3NcwvH4FbyW87rot6xTHJzl8LSs2NgRK/h1+54hQ8PKoMQfBtCW040loigOcgofcvJDUIFDhgLzHIvnhwR8SwwwgZiv4EXL+OjWO4IFFpSnZtDGC6t8jOchAsHvSKQY7R4ft3eiSNNLm6gpcr+NeQvGGQ4tBxOtQjZW67MxVCff4irmzp4ROh5JHrXLk1p8/fwB4EeivSPpZw4laFxFBDQmnSPEToQ3PADhVQRu9Bjc/IrCcj6+52rrWchmRYLOlsu1u4qwQdBA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(1590799012)(451199015)(38100700002)(82960400001)(2906002)(33656002)(122000001)(86362001)(38070700005)(9686003)(478600001)(41300700001)(26005)(7696005)(110136005)(316002)(64756008)(66556008)(54906003)(55016003)(71200400001)(4326008)(66446008)(66476007)(76116006)(53546011)(6506007)(66946007)(83380400001)(8936002)(52536014)(8676002)(5660300002)(186003)(1580799009)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnYxa3ZCYlMwZmZQM1loS3BYSnhvNEhSRnNMMS84eXhCVW5KSDM0S1A5TmdD?=
 =?utf-8?B?cW1adTQyVFlhWFgrUitEUUo1WDZUT1llb2w5cSt2QldoRGx4cXZnQW1SbDdW?=
 =?utf-8?B?OXlwVE1la3htT0lIa2o1RVBtKzh4bGtUTXBrTG11U3o0a0NxUFVVM3o4U0NU?=
 =?utf-8?B?Q0FkQ2tqbk5OWmV4dWp6R0tZampWT0dLTE90d2pNYWdJeTRIZWFMaytFRkl2?=
 =?utf-8?B?ZVZVWVB1NCtTbVdoTHZEeHlSOGNrUXNZeEx1ZVY4Wit4T1FCdnIvYlViTnFw?=
 =?utf-8?B?OURQSnlpdmZVNnhMOXNpaDBkUm1RYVlyTWRvdjFkd3FkdGRGbjFpM1V6cXRl?=
 =?utf-8?B?TmVDZ1JUcERNOVNUM3BLWHZNNEVINDBxUUZQcFZ3VzNaN3dZUlZxTkxUWThs?=
 =?utf-8?B?QzBsdDlEWFJRdURoNXl3ZXBnTnNhaklualM2QS9laUc5bHpsTHk3bGo2N3Vi?=
 =?utf-8?B?dUtOaXRnRnVPUE0weFpJdUVQaFUrQ2tKbVNQaDVpZmQzdDZHQXdrWlB0MHln?=
 =?utf-8?B?c29kNXh1VGxnZ3N4SW1uekpHOWNzKytBL0ZrZ28rcU5ya0lLa0c3dW45RlpW?=
 =?utf-8?B?SGNQQ0dsN3JGVEtGcWJ4MzNPa3pLa0dxVXM2ZFFXMUhzUnE3T29TZFJFZ1lv?=
 =?utf-8?B?TXBVOFVHRUt4VWpuZ1FlK3ZwMmpZNHZUS1U4enlvM1JlUmMvMXpaY2xjRjlR?=
 =?utf-8?B?U1hVNW9nUkZTS21kVDh4RVR1dTkxOGVDd2tQeGFvaG9IbUwzSTNyeWppRjdr?=
 =?utf-8?B?SmVFT3JPVXVtcmZNYUIyVDlReHNCYW5yUlVueklhWGwyWkxWNGV0MzBTeVlu?=
 =?utf-8?B?ZjdmRTNIR1QrUkdtRjFMdEVscURCbEI4a0tBaWdjbEpTbTdOTjBVcU1wSXNL?=
 =?utf-8?B?TG9zYk1lREpNb0luaUt2Y3pGOXNEQVNXSy9jdnJQck96ak5SUml3WW9sZmJW?=
 =?utf-8?B?S0Q4ZWdZZjFQNnZGT2FHaXpiaDNkWlQvVWdVeHN4bG01Y2pzcUpZVm93dkJP?=
 =?utf-8?B?UHVyYS83ekVYUXp6b0tVWkZidEl3WkVVeUg0T2s0RDl3YVFJTEJGWGtOekFl?=
 =?utf-8?B?NktnU2tJVEtOS1FrUzFBUHJGRmVDMU5Sclh3bUowWENkbFhJN2NjRFcxK01q?=
 =?utf-8?B?cGZ2RTc5U1JFYlNjRmtVZzh2RWpRSkJoT3VGRXVreU9IQnF1eTRGeHVEMkhx?=
 =?utf-8?B?cEZZV2I5S09WTmt6azYvSGF5b3AwRDc3WllabHVsblc4eVhRUE03NkZhZ1ZP?=
 =?utf-8?B?T29GMlYxUVB0bXFIaHR1RjdBL00yQWlsQW5UZS9HWlJpd2Exb09BcE02UzQx?=
 =?utf-8?B?bUZvZ09pTFZ4Qk1CQkR2ZkhwYnhXRUZIbUcweU5EZUR3NzJ2d0wxaUhFRkxq?=
 =?utf-8?B?WGtXSnlNSkh2eWZSaVBWVUdnTE5wa3lRSlpHNjdpbHJvWEl1K3VUcUg3SXdE?=
 =?utf-8?B?UnRYcDUzK1l2dXlYbThlVVIzN0pzLys3bVpMMG03ZksxNFJKb1dSVmRpbjY3?=
 =?utf-8?B?ckwyVG4vTlBrMEFCei9BQkFtMDFka1dVeE5VYlJ3MEFyaHk3bUZkam9LOHUv?=
 =?utf-8?B?ZnhDTCt1cjFjaUN3SE5OMnBXdzVVMndoM3FoN3VIM210bDRDbFdKRG5UNjBL?=
 =?utf-8?B?UmM1b1k2Vzh1QzJNVUFhU3VtSmtHMXB1SmI1emtBR1VnOERIWUxjWkorZUVB?=
 =?utf-8?B?S2JFOEpodW9qb2U2UjFFdjlBQ3hLUmVkTDNTallSNTZKbEhSenJkT2ZuSFE1?=
 =?utf-8?B?OVJUTm4wSEdwR0MrOVFmNmUzUDRHbGJFenhUMFFEQWRFeU92eTFiSnFwZ1Zu?=
 =?utf-8?B?SWFUbjhDTUVVV0Vwa3NHUy83TXZySjU1dzNKWllCY0plSW85ck9KOEFjRkZV?=
 =?utf-8?B?UGd0aHUvdGY1ems5OXA5Q2U1ZTE1WmVJMVkzMEhiZWRKNitES0wra1ViYXIv?=
 =?utf-8?B?STEyemdEd2tyZm1uSEpaS2s2bGZsTFlTZGp0ODZHcGVaQm1hc0xIQXgwRjJD?=
 =?utf-8?B?dVFoMElrSlZHR2lmOFRwWmlnTVBEbnF3QndJTnZlUkFiQUZhQkl5SGUySEdC?=
 =?utf-8?B?eEZpZFc1STJKbzNpbGw1MEZRMGYzUWp0cXQra2t0aWE3d2RLYlpTcUtQS2ds?=
 =?utf-8?B?dlV0Mk9yMmhOWEdiY28wUVNNQThqcDYzWURjL0s5U3hCOEI2aDJEM2FrY0Nq?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d59634ce-966c-4581-8746-08dac163bad1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 08:32:10.3581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JZlPJNwpQ7bNZv6piHIHbpC26ycBVRXlKCKK2Nxs6shKJT2DWMTCMqRLVKnhvd8NpByU2qzgiLFkc32ghNlZCO3JtrNxg07CsXE7U+eUocc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5496
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgUmVpbmV0dGUgYW5kIFNodWFoLA0KDQo+IE9uIDExLzIvMjAyMiAyOjQxIEFNLCBTaHVhaCBL
aGFuIHdyb3RlOg0KPiA+IE9uIDExLzEvMjIgMDM6NDMsIFNoYW9wZW5nIFRhbiB3cm90ZToNCj4g
Pj4gQWZ0ZXIgY3JlYXRpbmcgYSBjaGlsZCBwcm9jZXNzIHdpdGggZm9yaygpIGluIENBVCB0ZXN0
LCBpZiB0aGVyZSBpcw0KPiA+PiBhbiBlcnJvciBvY2N1cnMgb3Igc3VjaCBhcyBhIFNJR0lOVCBz
aWduYWwgaXMgcmVjZWl2ZWQsIHRoZSBwYXJlbnQNCj4gPj4gcHJvY2VzcyB3aWxsIGJlIHRlcm1p
bmF0ZWQgaW1tZWRpYXRlbHksIGJ1dCB0aGUgY2hpbGQgcHJvY2VzcyB3aWxsDQo+ID4+IG5vdCBi
ZSBraWxsZWQgYW5kIGFsc28gdW1vdW50X3Jlc2N0cmxmcygpIHdpbGwgbm90IGJlIGNhbGxlZC4N
Cj4gPj4NCj4gPj4gQWRkIGEgc2lnbmFsIGhhbmRsZXIgbGlrZSBvdGhlciB0ZXN0cyB0byBraWxs
IGNoaWxkIHByb2Nlc3MsIHVtb3VudA0KPiA+PiByZXNjdHJsZnMsIGNsZWFudXAgcmVzdWx0IGZp
bGVzLCBldGMuIHdoZW4gYW4gZXJyb3Igb2NjdXJzLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5
OiBTaGFvcGVuZyBUYW4gPHRhbi5zaGFvcGVuZ0BqcC5mdWppdHN1LmNvbT4NCj4gPj4gLS0tDQo+
ID4+IMKgIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvY2F0X3Rlc3QuYyB8IDI4DQo+
ID4+ICsrKysrKysrKysrKysrKy0tLS0tLS0NCj4gPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDE5IGlu
c2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL2NhdF90ZXN0LmMNCj4gPj4gYi90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL2NhdF90ZXN0LmMNCj4gPj4gaW5kZXggNmE4MzA2YjBhMTA5
Li41ZjgxODE3ZjQzNjYgMTAwNjQ0DQo+ID4+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L3Jlc2N0cmwvY2F0X3Rlc3QuYw0KPiA+PiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9y
ZXNjdHJsL2NhdF90ZXN0LmMNCj4gPj4gQEAgLTk4LDEyICs5OCwyMSBAQCB2b2lkIGNhdF90ZXN0
X2NsZWFudXAodm9pZCkNCj4gPj4gwqDCoMKgwqDCoCByZW1vdmUoUkVTVUxUX0ZJTEVfTkFNRTIp
Ow0KPiA+PiDCoCB9DQo+ID4+IMKgICtzdGF0aWMgdm9pZCBjdHJsX2hhbmRsZXIoaW50IHNpZ25v
KQ0KPiA+PiArew0KPiA+PiArwqDCoMKgIGtpbGwoYm1fcGlkLCBTSUdLSUxMKTsNCj4gPj4gK8Kg
wqDCoCB1bW91bnRfcmVzY3RybGZzKCk7DQo+ID4+ICvCoMKgwqAgdGVzdHNfY2xlYW51cCgpOw0K
PiA+PiArwqDCoMKgIGtzZnRfcHJpbnRfbXNnKCJFbmRpbmdcblxuIik7DQo+ID4NCj4gPiBJcyB0
aGVyZSBhIHJlYXNvbiB0byBwcmludCB0aGlzIG1lc3NhZ2U/IFJlbW92ZSBpdCB1bmxlc3MgaXQg
c2VydmVzIGENCj4gPiBwdXJwb3NlLg0KPiANCj4gVGhpcyBmdW5jdGlvbiBhcHBlYXJzIHRvIGJl
IGEgZHVwbGljYXRlIG9mIGV4aXN0aW5nIHJlc2N0cmxfdmFsLmM6Y3RybGNfaGFuZGxlcigpLg0K
PiBDb3VsZCB0aGUgZHVwbGljYXRpb24gYmUgYXZvaWRlZCBpbnN0ZWFkIG9mIHJlZmluaW5nIHRo
ZSBjb3B5Pw0KDQpZZXMsIGl0J3MgYSBkdXBsaWNhdGUgb2YgZXhpc3RpbmcgcmVzY3RybF92YWwu
YzpjdHJsY19oYW5kbGVyKCkuDQpJIHdpbGwgdHJ5IHRvIHVzZSByZXNjdHJsX3ZhbC5jOmN0cmxj
X2hhbmRsZXIoKSBpbiBuZXh0IHZlcnNpb24gcGF0Y2ggc2VyaWVzLg0KDQo+ID4+ICsNCj4gPj4g
K8KgwqDCoCBleGl0KEVYSVRfU1VDQ0VTUyk7DQo+ID4+ICt9DQo+ID4+ICsNCj4gPj4gwqAgaW50
IGNhdF9wZXJmX21pc3NfdmFsKGludCBjcHVfbm8sIGludCBuLCBjaGFyICpjYWNoZV90eXBlKQ0K
PiA+PiDCoCB7DQo+ID4+IMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBsX21hc2ssIGxfbWFza18x
Ow0KPiA+PiDCoMKgwqDCoMKgIGludCByZXQsIHBpcGVmZFsyXSwgc2libGluZ19jcHVfbm87DQo+
ID4+IMKgwqDCoMKgwqAgY2hhciBwaXBlX21lc3NhZ2U7DQo+ID4+IC3CoMKgwqAgcGlkX3QgYm1f
cGlkOw0KPiA+DQo+ID4gT2RkLiBibV9waWQgaXMgdXNlZCBiZWxvdyAtIHdoeSByZW1vdmUgaXQg
aGVyZT8NCj4gDQo+IFRoZXJlIGlzIGEgZ2xvYmFsIGJtX3BpZCBpbiByZXNjdHJsX3ZhbC5jIHRo
YXQgaXMgbWFkZSBhdmFpbGFibGUgdmlhIGV4dGVybiBpbg0KPiByZXNjdHJsLmguIFRoaXMgaXMg
d2hhdCBjYXVzZXMgdGhpcyBjb2RlIHRvIHN0aWxsIGNvbXBpbGUgYnV0IEkgd291bGQgYWxzbyBs
aWtlIHRvDQo+IGxlYXJuIHdoeSBtb3ZpbmcgdG8gdGhhdCBpcyBkZXNpcmVkIGFzIGEgY2hhbmdl
IGhlcmUuIEkgZXhwZWN0IHN1Y2ggYSBiaWcNCj4gY2hhbmdlIHRvIGdldCBhIG1lbnRpb24gaW4g
dGhlIGNvbW1pdCBtZXNzYWdlLg0KDQpZZXMuIEkgdXNlZCBnbG9iYWwgYm1fcGlkLCBzaW5jZSBi
bV9waWQgaXMgdXNlZCBpbiBjdHJsX2hhbmRsZXIoKSBiZWZvcmUgdGhpcyBmdW5jdGlvbiBjYXRf
cGVyZl9taXNzX3ZhbCgpLg0KSSB3aWxsIGFkZCBhIGRlc2NyaXB0aW9uIHRvIGNvbW1pdCBtZXNz
YWdlLg0KDQo+ID4+IMKgIMKgwqDCoMKgwqAgY2FjaGVfc2l6ZSA9IDA7DQo+ID4+IMKgIEBAIC0x
ODEsMTcgKzE5MCwxOSBAQCBpbnQgY2F0X3BlcmZfbWlzc192YWwoaW50IGNwdV9ubywgaW50IG4s
IGNoYXINCj4gPj4gKmNhY2hlX3R5cGUpDQo+ID4+IMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJjcHko
cGFyYW0uZmlsZW5hbWUsIFJFU1VMVF9GSUxFX05BTUUxKTsNCj4gPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIHBhcmFtLm51bV9vZl9ydW5zID0gMDsNCj4gPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHBhcmFt
LmNwdV9ubyA9IHNpYmxpbmdfY3B1X25vOw0KPiA+PiArwqDCoMKgIH0gZWxzZSB7DQo+ID4+ICvC
oMKgwqDCoMKgwqDCoCAvKiBzZXQgdXAgY3RybC1jIGhhbmRsZXIgKi8NCj4gPj4gK8KgwqDCoMKg
wqDCoMKgIGlmIChzaWduYWwoU0lHSU5ULCBjdHJsX2hhbmRsZXIpID09IFNJR19FUlIgfHwNCj4g
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2lnbmFsKFNJR0hVUCwgY3RybF9oYW5kbGVyKSA9
PSBTSUdfRVJSIHx8DQo+ID4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNpZ25hbChTSUdURVJN
LCBjdHJsX2hhbmRsZXIpID09IFNJR19FUlIpDQo+ID4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHByaW50ZigiRmFpbGVkIHRvIGNhdGNoIFNJR05BTCFcbiIpOw0KPiA+DQo+ID4gSXMgcGVycm9y
KCkgbW9yZSBhcHByb3ByaWF0ZSBoZXJlPw0KPiANCj4gU2hvdWxkIHdlIGJlIHVzaW5nIHNpZ25h
bCgpIGF0IGFsbD8gIm1hbiBzaWduYWwiIHJlYWRzOg0KPiAiV0FSTklORzogdGhlIGJlaGF2aW9y
IG9mIHNpZ25hbCgpIHZhcmllcyBhY3Jvc3MgVU5JWCB2ZXJzaW9ucywgYW5kIGhhcyBhbHNvDQo+
IHZhcmllZCBoaXN0b3JpY2FsbHkgYWNyb3NzIGRpZmZlcmVudCB2ZXJzaW9ucyBvZiBMaW51eC4N
Cj4gQXZvaWQgaXRzIHVzZTogdXNlIHNpZ2FjdGlvbigyKSBpbnN0ZWFkLiINCj4gDQo+ICJGYWls
ZWQgdG8gY2F0Y2ggU0lHTkFMIiBhbHNvIHNlZW1zIHVuY2xlYXIgdG8gbWUuIFRoaXMgaXMgd2hl
cmUgYSBzaWduYWwNCj4gaGFuZGxlciBpcyBzZXQgdXAsIHRoZSBzaWduYWwgZm9yIHdoaWNoIHRo
ZSBoYW5kbGVyIGlzIGluc3RhbGxlZCBoYXMgbm90IGFycml2ZWQuDQoNCkkgd2lsbCB1c2Ugc2ln
YWN0aW9uKDIpIGFuZCBwZXJyb3IoKS4NCg0KPiA+PiDCoMKgwqDCoMKgIH0NCj4gPj4gwqAgwqDC
oMKgwqDCoCByZW1vdmUocGFyYW0uZmlsZW5hbWUpOw0KPiA+PiDCoCDCoMKgwqDCoMKgIHJldCA9
IGNhdF92YWwoJnBhcmFtKTsNCj4gPj4gLcKgwqDCoCBpZiAocmV0KQ0KPiA+PiAtwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIHJldDsNCj4gPj4gLQ0KPiA+PiAtwqDCoMKgIHJldCA9IGNoZWNrX3Jlc3Vs
dHMoJnBhcmFtKTsNCj4gPj4gLcKgwqDCoCBpZiAocmV0KQ0KPiA+PiAtwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIHJldDsNCj4gPj4gK8KgwqDCoCBpZiAocmV0ID09IDApDQo+ID4+ICvCoMKgwqDCoMKg
wqDCoCByZXQgPSBjaGVja19yZXN1bHRzKCZwYXJhbSk7DQo+ID4NCj4gPiBXaHkgbm90IHVzZSBh
IGdvdG8gaW4gZXJyb3IgY2FzZSB0byBkbyB1bW91bnRfcmVzY3RybGZzKCkgaW5zdGVhZCBvZg0K
PiA+IGNoYW5naW5nIHRoZSBjb25kaXRpb25hbHM/DQo+IA0KPiBNeSB1bmRlcnN0YW5kaW5nIGlz
IHRoZSBjb2RlIHRoYXQgZm9sbG93cyBpcyBuZWVkZWQgdG8gc3luY2hyb25pemUgdGhlIGV4aXRz
DQo+IGJldHdlZW4gdGhlIHBhcmVudCBhbmQgY2hpbGQuIEl0IGlzIHRoZSBwYXJlbnQgdGhhdCB3
aWxsIHJ1biB1bW91bnRfcmVzY3RybGZzKCkNCj4gYW5kIGl0IHNob3VsZCBvbmx5IGRvIHNvIGFm
dGVyIHRoZSBjaGlsZCBpcyBkb25lLiBBIGdvdG8gYnkgdGhlIHBhcmVudCBtYXkgdGh1cw0KPiBj
YXVzZQ0KPiB1bW91bnRfcmVzY3RybGZzKCkgdG8gYmUgcnVuIHdoaWxlIHRoZSBjaGlsZCBzdGls
bCByZWxpZXMgb24gaXQgd2hpbGUgYSBnb3RvIGJ5IHRoZQ0KPiBjaGlsZCBtYXkgY2F1c2UgdGhl
IHBhcmVudCBub3QgdG8gcmVjZWl2ZSB0aGUgbWVzc2FnZSB0aGF0IHRoZSBjaGlsZCBpcw0KPiBj
b21wbGV0ZS4NCg0KWWVzLCB0aGUgY29kZSB0aGF0IGZvbGxvd3MgaXMgbmVlZGVkIHRvIHN5bmNo
cm9uaXplIHRoZSBleGl0cyBiZXR3ZWVuIHRoZSBwYXJlbnQgYW5kIGNoaWxkLg0KDQo+ID4gQEAg
LTIwMSw3ICsyMTIsNiBAQCBpbnQgY2F0X3BlcmZfbWlzc192YWwoaW50IGNwdV9ubywgaW50IG4s
IGNoYXINCj4gKmNhY2hlX3R5cGUpDQo+ID4gIAkJICAgIHNpemVvZihwaXBlX21lc3NhZ2UpKSB7
DQo+ID4gIAkJCWNsb3NlKHBpcGVmZFsxXSk7DQo+ID4gIAkJCXBlcnJvcigiIyBmYWlsZWQgc2ln
bmFsaW5nIHBhcmVudCBwcm9jZXNzIik7DQo+ID4gLQkJCXJldHVybiBlcnJubzsNCj4gDQo+IEl0
IGxvb2tzIGxpa2UgcGlwZWZkWzFdIHdpbGwgYmUgY2xvc2VkIHR3aWNlIGlmIHRoZSB3cml0ZSgp
IGZhaWxlZC4NCg0KVGhpcyBjbG9zZShwaXBlZmRbMV0pOyBzaG91bGQgYWxzbyBiZSByZW1vdmVk
Lg0KDQo+IEl0IGRvZXMgbG9vayBzdHJhbmdlIHRvIGxldCB0aGUgY2hpbGQgY29udGludWUgdG8g
aXRzIGluZmluaXRlIGxvb3AgYWZ0ZXIgdGhlIHdyaXRlKCkNCj4gZmFpbGVkLiBJIGFzc3VtZSB0
aGF0IGl0IGlzIGJlY2F1c2UgdGhlIHBhcmVudCB3aWxsIGFsc28gYmUgc3R1Y2sgYW5kIHRoZSBu
ZXcNCj4gY3RybF9oYW5kbGVyKCkgaXMgZXhwZWN0ZWQgdG8gdW5ibG9jayBib3RoPw0KDQpJZiBh
IFNJR05BTCBpcyByZWNlaXZlZCwgY3RybF9oYW5kbGVyKCkgd2lsbCBiZSBjYWxsZWQgdG8ga2ls
bCB0aGUgY2hpbGQgcHJvY2VzcyBhbmQgZXhpdCBwYXJlbnQgcHJvY2Vzcy4NCklmIG5vIFNJR05B
TCBpcyByZWNlaXZlZCwgdGhlIHBhcmVudCBwcm9jZXNzIHdpbGwga2lsbCB0aGUgY2hpbGQgcHJv
Y2Vzcy4gKGJ5IGVsc2V7a2lsbChibV9waWQsIFNJR0tJTEwpO30pDQoNCj4gQ291bGQgeW91IHBs
ZWFzZSBhZGQgYSBjb21tZW50IHRvIHRoZSBjb2RlIHRvIGNsYXJpZnkgdGhpcyBmbG93Pw0KSSB3
aWxsIGFkZCBjb21tZW50cyBoZXJlLg0KDQpCZXN0IHJlZ2FyZHMsDQpTaGFvcGVuZyBUYW4NCg0K
DQo=
