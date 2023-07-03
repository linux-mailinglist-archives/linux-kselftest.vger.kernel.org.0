Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BCD7462BF
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 20:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjGCSv1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 14:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjGCSv0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 14:51:26 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011010.outbound.protection.outlook.com [40.93.199.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64737AF;
        Mon,  3 Jul 2023 11:51:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASvsSl/6ZKshn6tMTK8VLN7CNw2t/3v85R1lGheVAFLo5CfA5c/ydL9F6Sw0mImit7iHWiceh0hmGEQeb3xSb3tZDB5UPgR/MAqxGsrFAgej9Gg87Uwo6N8rDX49NCUh+6PdOB+aq6Y4W5Zw48XkemFmv8GDqBm7YYPAJqqFouARWa0TSJWQ8ntvJ5CZmu4fXKCWm6ER052PzaOX9on8vOSG/48mU0P3WbHAJqolV3oz0QYRWdG9gZHKqLXWHjPg62gHHG3H7LK7Q0Ue4v+SAWQXi+SZI3Rck7fh8UseiPbERm85SP5Cb2Ks7WPq/1s8tpj0NGQyCGy6KT75iZM/Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TonDN9Zf/z4uq4VH6rcaqKasf+5epT/wr2sZ3bx7q0=;
 b=XxH+9ONBjVfqt+4I5JKgMu705s8ClhNYhoRTK8+a71kIK/4TEO4Bnv7sZKfGPKJBve9ZmtNXIAwkoWw1jtBtTajH4810yScX/i43/H+TKDlKbG+EijafFkIgdqW5FXQn/ymZ5KtkxBIjHflI0ZUJcvA4z082GR9aU1zBpG0YnS7At/2gDfKYuE61Alc3AmwoPAigWE9v+Zy5XwMlAonaoA1YaKpJlygUZdvXKN9G1ZbBXcVKuq32awSnEcma4eInkXjKhfuu6J/a4+LhSAONB8awi5MTXaAaYpTa3GIEAj4/vfteMonUUU45uNoqqTvLZC22EuF7GmoR2FsS5Qe/WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TonDN9Zf/z4uq4VH6rcaqKasf+5epT/wr2sZ3bx7q0=;
 b=Tx/GEKBsyxu06/YSXKkZt63SWT/j4327eiubDyI6Ke2sdmFrqDBQKiLajr6UHrklIisSnKwblJppg3iy4xWt+eSvG4LX6wzFnGJiGRWanCDwC5ixgWwNwawzfdaPsNUJCKF1Az4YXCwNBG2l8Is+yz7Ik6YHtnb+oFxU6tmmPJ0=
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by SA0PR05MB7322.namprd05.prod.outlook.com (2603:10b6:806:b4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 18:51:22 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::4f1a:ecac:2dab:7044]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::4f1a:ecac:2dab:7044%3]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 18:51:22 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Ching-lin Yu <chinglinyu@google.com>,
        Nadav Amit <namit@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Tapas Kundu <tkundu@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>
Subject: Re: [PATCH v3 03/10] eventfs: adding eventfs dir add functions
Thread-Topic: [PATCH v3 03/10] eventfs: adding eventfs dir add functions
Thread-Index: AQHZlGea+LkXVQ0q2UG3T24LzaVAwK+lHj6AgALm5ACAAFKigIAAPhiA
Date:   Mon, 3 Jul 2023 18:51:22 +0000
Message-ID: <84CA259A-8A99-471C-B44C-08D289972F43@vmware.com>
References: <1685610013-33478-1-git-send-email-akaher@vmware.com>
 <1685610013-33478-4-git-send-email-akaher@vmware.com>
 <20230701095417.3de5baab@rorschach.local.home>
 <ECB0097D-A323-4CFC-9C9E-D4DA2AA6E662@vmware.com>
 <20230703110857.2d051af5@rorschach.local.home>
In-Reply-To: <20230703110857.2d051af5@rorschach.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR05MB8703:EE_|SA0PR05MB7322:EE_
x-ms-office365-filtering-correlation-id: be0a7cc2-8c95-4a16-d229-08db7bf67ed5
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZSNnM/98XDsntWRhvOft0kfaH3hccOqNvK/nbRxoNBg4+QpKS3RU2+u77eZco+1xTF/b4NRx+y+1+iEM5QwViAVaBrRIQTQOmpbpnxneyxwtIoMADNHfHIdeyUKGpzEWdbHSFBHD6LrUcniC38XB7QcRetPxMwUA55XlPB403LuqjmenSCTOf1XgYIqXHP1jBthH3NTggVeGOjfLpa/GRH8wHyDSCK1+4lJDQqrPTxaBJ1r6dxoq/aig//RG/xkQLtvBgrEX+8XZPWZ0ww8aF12BMRM0xssk+96x0cbpmBbPlFKxRgctcqef/rz86+G7686EHXVzhr29lT+1xEAzIltsP9avRl6EeesAcXz4x//oVeRelYFbB4P2ve/67UbqpionPoB4sqtFi4WbeWwGDs5B0Z8TVuNVPH4BCvvdPfXod3rjfAqlxEskvB92Y349mFGSj/9xXzBNlofaGShceEfdT83hqtX1OWSr4C07HgzahYtb5m8MWTIrL7PZwXoRvf2hp5hM0VjmAgJqjhz7jzi2q+PBaqA9PiIYFX2Co1WrqZLwR19YteW1AaDddNZY24oe/QJDjJiF1wbWAiR4RhcDtgwNfJXX2bFNnHdIO9kQT+GDJzhKPLFl1SoYoF2jfUA9XWXoVNEl2Qj9VLFWtzN6SWNK5OfvoKnsKf5duab8817Y3UYXugX2DlBz1FcuH1dAaQ14b62JZjBWZkIJpOLr88uLm2zjvkZLDIrhDWM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(451199021)(38070700005)(2906002)(41300700001)(5660300002)(8676002)(8936002)(33656002)(36756003)(86362001)(186003)(2616005)(478600001)(26005)(966005)(6506007)(6512007)(71200400001)(53546011)(6486002)(76116006)(91956017)(122000001)(316002)(6916009)(66446008)(66476007)(4326008)(64756008)(66946007)(66556008)(38100700002)(54906003)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjRwajlRMmtZQXVLZThlUFFLTjZuaHdhTnFHc0tNS0Z3Sk9yQnZrdWVINmJx?=
 =?utf-8?B?cC9HVXRJWUkzNHNVaENqb2hqSnI5d3Q5TTZJQ3VaSXNvYWIvbk5GYjNCc3RU?=
 =?utf-8?B?ZkJUR0NVdjl5N2hrOFphMzBmZjVLVWtVa1oyeWthWm94OGhlTW9BclVpMC9M?=
 =?utf-8?B?NDNPRm9QRWZKRG9PT2g2eTBycnVSK0FjL0U2YmdUNVBPd1ZHRTZBWFRwenBD?=
 =?utf-8?B?dEtBcllIa3Rra3d6UTg5Mk92VWgvUXNncGw4akhnajNTbG1BMU52d3pWS1pN?=
 =?utf-8?B?YXNsR2VOcERJcmNoMDdsazQ4ZUNZN0Y1Ui84eHN5MW90SU5wWEJZVUhvakNF?=
 =?utf-8?B?cm5IRTZBOS8zaHRCSDJvWmtwWGFGell1S1FTVFF0MHlzUmtsdEp4NjdEUkZt?=
 =?utf-8?B?cXgzMHFBZWdlT2xVelArZkFnRVF0bVBydWt3VUhOVmV2Q28wZktxWGhYM1Rk?=
 =?utf-8?B?ekNMNG9PbVhNL085OTVWTkVNRFpYQWZRSUxwWFIvZXZmVHE1cm1QWHFxU1Iv?=
 =?utf-8?B?YVlzWVBPQlpSK04rWW5KbHMrSVo3L2ZEYk1nYzRoUjFNN3NRSkVNeExrWGFv?=
 =?utf-8?B?N3pmK1VCUFE3TE5mWE9EcG91YjRZYjVlZ21CalI0RVBiVmk2V0FlY0NvVSta?=
 =?utf-8?B?SHNLQ05XRWZnRDE2WjNiZGpyZUhsVE0yYzA5T29Pc2RwYjlSN25rcHFTaFlY?=
 =?utf-8?B?bGlQNmJIRXl5eHI2L1l1b085dGxEVTBYdEk0MUgxdERTc1RBYVF6SisrZVBK?=
 =?utf-8?B?K01JMTBSRVpRU0ZtVm5BeUluTkZnVFRyUnI1WjQwdEcxdzI4eG9uMm5IWDVL?=
 =?utf-8?B?SDlwdXR3Nmxoa1FEL3Z3WGdqeWM3VFZKZlA0bW8vUUVETFdob0RsRU5PbGZB?=
 =?utf-8?B?UEgrdnNrN0FPdlRPN0pMYzNEM09TWndJNGs4TldQRFVyRy93MTJteTFSUzlE?=
 =?utf-8?B?NllrKzlMeEUwbzZIL1BWSGRiMSsyWWxjNzdtZHM0YnR0VklKZXNTRXFtOCtB?=
 =?utf-8?B?OWUwd0M5bi9ZdEkzQ2RHbmdWZDd5b3pIT0pXdjZqSTB0YzVOUGc1Yno3eS9s?=
 =?utf-8?B?N1RVVE9EMmRDZlN1RXBBcXpwcUR4cHIxUHpmWitCNkxRL0tXN2RqYUwyaUxV?=
 =?utf-8?B?VkxIa255K3hBSHpwbzNmRThyaThneFBUbjhhVDFuV2dvRnVIcFhhS1hnK2M2?=
 =?utf-8?B?Wml6d1dXMy9ONnJLMHNjL1VWTTJ1L01BOTVVcTR1SUQ3bkxueS94Y1lIczZC?=
 =?utf-8?B?NWdYSzN6ajBZNCsxaXgrVWdGU1pkemFpY3lhNHBvelNvN21NU1lQcjF5aUlP?=
 =?utf-8?B?a0RRL05FeCt2YlJHeldQc2VJWDhtMHBjaStyZEl5cnFPTGRVT0FCOXdvTzI0?=
 =?utf-8?B?enVCZ01JMmNram1hYjNKR0lna0tmNWtoZlk3SXg2SVd3aG8zcXduRjdmSG05?=
 =?utf-8?B?R09VdEdBRGZVM1FrSnlDa0t2RHJmdnJXdFc5RWxTQ3BRakUxbFlneCt5cnBs?=
 =?utf-8?B?MGMwTDNGSlBydHBWNDJ5dVdxRGlyTEF2WnA2Smx5bUw1TG9INE5LN28vbm9N?=
 =?utf-8?B?QndrTjZqWEhhdmROR3JjM1J3Mm1iYjVNWERKbkY0eUllVm9PVU9sNFN6NHhR?=
 =?utf-8?B?YyswTHpoRW5wOWtYNTg4T1c0SkZlcEhQU3dFQ0F4VkFkeGhLa1gvbHZ1d2xx?=
 =?utf-8?B?TVBZMWdMVkZ0K0dzWHhoUmpTbTNwTUZMY1JUaU1uV2E2VktUbklweHcvSUVr?=
 =?utf-8?B?eDlUL2dla3NwY3B1VFFtU283R2MwV0xhbS9yWmNWbWJzWjFwNitZclpjNEI0?=
 =?utf-8?B?VlppQ2FDRklST21jTjMvZ3VUYVRRK2VHTjdqVzRqUWdvZUdEaUY2VDhQS1dx?=
 =?utf-8?B?cEVXTlVjWUF2RVVOQkZZY0Y3STBkZ3p5ckhrR1piS3FOaGFsWTMzLzdTTU1T?=
 =?utf-8?B?cHF1Yzg3Z0lSVU04R0ZzWlNtQWh0TFdPamI3M3Q4QWM0cCtRQ0lDRDF1TUdG?=
 =?utf-8?B?YTJHZGhsOGJFVDFFcGNoYWFtMjNsNmhOTmlWdnk5T2hEUjZ2cDhpREFiWS9R?=
 =?utf-8?B?c0Judk95S1BTKzZ1bjBsR216MDlUTHlNcGtRVCttZ0hJaXVpVjk5Rm1QQjhm?=
 =?utf-8?Q?0EAYRpnNznqD6ba2COmvRobuj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66A27D7C2A7F1743908DC43D04065EBE@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0a7cc2-8c95-4a16-d229-08db7bf67ed5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 18:51:22.2733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mvHG8JBS1AEwD6YDWzblJGNPEZDPlcICqzZR7mwKJRTsPrRbTNV2cbensg2T/KvLWlQZkKqO3iwv3cvSWPTOjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR05MB7322
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gT24gMDMtSnVsLTIwMjMsIGF0IDg6MzggUE0sIFN0ZXZlbiBSb3N0ZWR0IDxyb3N0ZWR0
QGdvb2RtaXMub3JnPiB3cm90ZToNCj4gDQo+IEkganVzdCBsb29rZWQgYXQgdGhhdCBjb2RlIGFu
ZCB0aGUgY29tbWl0LCBhbmQgSSBob25lc3RseSBiZWxpZXZlIHRoYXQNCj4gaXMgYSBob3JyaWJs
ZSBoYWNrLCBhbmQgdmVyeSBmcmFnaWxlLiBJdCdzIGluIHRoZSBzbWIgY29kZSwgc28gaXQgd2Fz
DQo+IHVubGlrZWx5IHJldmlld2VkIGJ5IGFueW9uZSBvdXRzaWRlIHRoYXQgc3Vic3lzdGVtLiBJ
IHJlYWxseSBkbyBub3QNCj4gd2FudCB0byBwcm9saWZpY2F0ZSB0aGF0IHNvbHV0aW9uIGFyb3Vu
ZCB0aGUga2VybmVsLiBXZSBuZWVkIHRvIGNvbWUgdXANCj4gd2l0aCBzb21ldGhpbmcgZWxzZS4N
Cj4gDQo+IEkgYWxzbyB0aGluayBpdCdzIGJ1Z2d5ICh5ZXMgdGhlIGNpZnMgY29kZSBpcyBidWdn
eSEpIGJlY2F1c2UgaW4gdGhlDQo+IGNvbW1lbnQgYWJvdmUgdGhlIGRvd25fcmVhZF9uZXN0ZWQo
KSBpdCBzYXlzOg0KPiANCj4gLyoNCj4gKiBuZXN0ZWQgbG9ja2luZy4gTk9URTogcndzZW1zIGFy
ZSBub3QgYWxsb3dlZCB0byByZWN1cnNlDQo+ICogKHdoaWNoIG9jY3VycyBpZiB0aGUgc2FtZSB0
YXNrIHRyaWVzIHRvIGFjcXVpcmUgdGhlIHNhbWUNCj4gKiBsb2NrIGluc3RhbmNlIG11bHRpcGxl
IHRpbWVzKSwgYnV0IG11bHRpcGxlIGxvY2tzIG9mIHRoZQ0KPiAqIHNhbWUgbG9jayBjbGFzcyBt
aWdodCBiZSB0YWtlbiwgaWYgdGhlIG9yZGVyIG9mIHRoZSBsb2Nrcw0KPiAqIGlzIGFsd2F5cyB0
aGUgc2FtZS4gVGhpcyBvcmRlcmluZyBydWxlIGNhbiBiZSBleHByZXNzZWQNCj4gKiB0byBsb2Nr
ZGVwIHZpYSB0aGUgX25lc3RlZCgpIEFQSXMsIGJ1dCBlbnVtZXJhdGluZyB0aGUNCj4gKiBzdWJj
bGFzc2VzIHRoYXQgYXJlIHVzZWQuIChJZiB0aGUgbmVzdGluZyByZWxhdGlvbnNoaXAgaXMNCj4g
KiBzdGF0aWMgdGhlbiBhbm90aGVyIG1ldGhvZCBmb3IgZXhwcmVzc2luZyBuZXN0ZWQgbG9ja2lu
ZyBpcw0KPiAqIHRoZSBleHBsaWNpdCBkZWZpbml0aW9uIG9mIGxvY2sgY2xhc3Mga2V5cyBhbmQg
dGhlIHVzZSBvZg0KPiAqIGxvY2tkZXBfc2V0X2NsYXNzKCkgYXQgbG9jayBpbml0aWFsaXphdGlv
biB0aW1lLg0KPiAqIFNlZSBEb2N1bWVudGF0aW9uL2xvY2tpbmcvbG9ja2RlcC1kZXNpZ24ucnN0
IGZvciBtb3JlIGRldGFpbHMuKQ0KPiAqLw0KPiANCj4gU28gdGhpcyBpcyBOT1QgYSBzb2x1dGlv
biAoYW5kIHRoZSBjaWZzIGNvZGUgc2hvdWxkIGJlIGZpeGVkIHRvbyEpDQo+IA0KPiBDYW4geW91
IHNob3cgbWUgdGhlIGV4YWN0IGJhY2t0cmFjZSB3aGVyZSB0aGUgcmVhZGVyIGxvY2sgZ2V0cyB0
YWtlbg0KPiBhZ2Fpbj8gV2Ugd2lsbCBoYXZlIHRvIGNvbWUgdXAgd2l0aCBhIHdheSB0byBub3Qg
dGFrZSB0aGUgc2FtZSBsb2NrDQo+IHR3aWNlLg0KDQoNClsgMjQ0LjE4NTUwNV0gZXZlbnRmc19y
b290X2xvb2t1cCsweDM3LzB4MWYwICAgICAgICAgICAgICAgICAgICAgICAgICA8LS0tIHJlcXVp
cmUgcmVhZCBsb2NrDQpbIDI0NC4xODU1MDldIF9fbG9va3VwX3Nsb3crMHg3Mi8weDEwMA0KWyAy
NDQuMTg1NTExXSBsb29rdXBfb25lX2xlbisweDZhLzB4NzANClsgMjQ0LjE4NTUxM10gZXZlbnRm
c19zdGFydF9jcmVhdGluZysweDU4LzB4ZDANClsgMjQ0LjE4NTUxNV0gPyBzZWN1cml0eV9sb2Nr
ZWRfZG93bisweDJlLzB4NTANClsgMjQ0LjE4NTUxOF0gZXZlbnRmc19jcmVhdGVfZmlsZSsweDU3
LzB4MTUwDQpbIDI0NC4xODU1MjFdIGRjYWNoZV9kaXJfb3Blbl93cmFwcGVyKzB4MWM2LzB4MjYw
ICAgICAgICAgICAgIDwtLS0gcmVxdWlyZSByZWFkIGxvY2sNClsgMjQ0LjE4NTUyNF0gPyBfX3Bm
eF9kY2FjaGVfZGlyX29wZW5fd3JhcHBlcisweDEwLzB4MTANClsgMjQ0LjE4NTUyNl0gZG9fZGVu
dHJ5X29wZW4rMHgxZWQvMHg0MjANClsgMjQ0LjE4NTUyOV0gdmZzX29wZW4rMHgyZC8weDQwDQoN
Cg0KPiANCj4gV2UgY2FuIGFsc28gbG9vayB0byBzZWUgaWYgd2UgY2FuIGltcGxlbWVudCB0aGlz
IHdpdGggUkNVLiBXaGF0IGV4YWN0bHkNCj4gaXMgdGhpcyByd3NlbSBwcm90ZWN0aW5nPw0KPiAN
Cg0KLSBzdHJ1Y3QgZXZlbnRmc19maWxlIGhvbGRzIHRoZSBtZXRhLWRhdGEgZm9yIGZpbGUgb3Ig
ZGlyLg0KaHR0cHM6Ly9naXRodWIuY29tL2ludGVsLWxhYi1sa3AvbGludXgvYmxvYi9kZmUwZGMx
NWE3MzI2MWVkODNjZGM3MjhlNDNmNGIzZDRlMzE1YWFlL2luY2x1ZGUvbGludXgvdHJhY2Vmcy5o
I0wyOA0KLSBldmVudGZzX3J3c2VtIGlzIHN1cHBvc2VkIHRvIHByb3RlY3QgdGhlICdsaW5rLWxp
c3Qgd2hpY2ggaXMgbWFkZSBvZiBzdHJ1Y3QgZXZlbnRmc19maWxlDQonIGFuZCBlbGVtZW50cyBv
ZiBzdHJ1Y3QgZXZlbnRmc19maWxlLg0KDQpJIHRyaWVkIG9uZSBtb3JlIHNvbHV0aW9uIGkuZSBi
eSBjaGVja2luZyBvd25lciBvZiBsb2NrOg0Kc3RhdGljIGlubGluZSBzdHJ1Y3QgdGFza19zdHJ1
Y3QgKnJ3c2VtX293bmVyKHN0cnVjdCByd19zZW1hcGhvcmUgKnNlbSkNCnsNCiAgICByZXR1cm4g
KHN0cnVjdCB0YXNrX3N0cnVjdCAqKQ0KICAgIChhdG9taWNfbG9uZ19yZWFkKCZzZW0tPm93bmVy
KSAmIH5SV1NFTV9PV05FUl9GTEFHU19NQVNLKTsNCn0NCg0KQnV0IHJ3c2VtX293bmVyKCkgaXMg
c3RhdGljLg0KDQo+IA0KPj4gDQo+PiBMb29raW5nIGZ1cnRoZXIgZm9yIHlvdXIgaW5wdXQuIEkg
d2lsbCBhZGQgZXhwbGFuYXRpb24gaW4gdjQuDQo+PiANCj4+IA0KPj4+PiArfQ0KPj4+PiArDQo+
IA0KPiBbLi5dDQo+IA0KPj4+PiArICoNCj4+Pj4gKyAqIFRoaXMgZnVuY3Rpb24gY3JlYXRlcyB0
aGUgdG9wIG9mIHRoZSB0cmFjZSBldmVudCBkaXJlY3RvcnkuDQo+Pj4+ICsgKi8NCj4+Pj4gK3N0
cnVjdCBkZW50cnkgKmV2ZW50ZnNfY3JlYXRlX2V2ZW50c19kaXIoY29uc3QgY2hhciAqbmFtZSwN
Cj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRlbnRy
eSAqcGFyZW50LA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
dHJ1Y3Qgcndfc2VtYXBob3JlICpldmVudGZzX3J3c2VtKQ0KPj4+IA0KPj4+IE9LLCBJJ20gZ29p
bmcgdG8gaGF2ZSB0byByZWFsbHkgbG9vayBhdCB0aGlzLiBQYXNzaW5nIGluIGEgbG9jayB0byB0
aGUNCj4+PiBBUEkgaXMganVzdCBicm9rZW4uIFdlIG5lZWQgdG8gZmluZCBhIHdheSB0byBzb2x2
ZSB0aGlzIGFub3RoZXIgd2F5Lg0KPj4gDQo+PiBldmVudGZzX3J3c2VtIGlzIGEgbWVtYmVyIG9m
IHN0cnVjdCB0cmFjZV9hcnJheSwgSSBndWVzcyB3ZSBzaG91bGQNCj4+IHBhc3MgcG9pbnRlciB0
byB0cmFjZV9hcnJheS4NCj4gDQo+IE5vLCBpdCBzaG91bGQgbm90IGJlIHBhcnQgb2YgdGhlIHRy
YWNlX2FycmF5LiBJZiB3ZSBjYW4ndCBkbyB0aGlzIHdpdGgNCj4gUkNVLCB0aGVuIHdlIG5lZWQg
dG8gYWRkIGEgZGVzY3JpcHRvciB0aGF0IGNvbnRhaW5zIHRoZSBkZW50cnkgdGhhdCBpcw0KPiBy
ZXR1cm5lZCBhYm92ZSwgYW5kIGhhdmUgdGhlIGxvY2sgaGVsZCB0aGVyZS4gVGhlIGNhbGxlciBv
ZiB0aGUNCj4gZXZlbnRmc19jcmVhdGVfZXZlbnRzX2RpcigpIHNob3VsZCBub3QgY2FyZSBhYm91
dCBsb2NraW5nLiBUaGF0J3MgYW4NCj4gaW1wbGVtZW50YXRpb24gZGV0YWlsIHRoYXQgc2hvdWxk
ICpub3QqIGJlIHBhcnQgb2YgdGhlIEFQSS4NCj4gDQo+IFRoYXQgaXMsIGlmIHlvdSBuZWVkIGEg
bG9jazoNCj4gDQo+IHN0cnVjdCBldmVudGZzX2RlbnRyeSB7DQo+ICAgICAgICBzdHJ1Y3QgZGVu
dHJ5ICAgICAgICAgICAqZGVudHJ5Ow0KPiAgICAgICAgc3RydWN0IHJ3c2VtICAgICAgICAgICAg
KnJ3c2VtOw0KPiB9Ow0KPiANCj4gQW5kIHRoZW4gZ2V0IHRvIHRoYXQgbG9jayBieSB1c2luZyB0
aGUgY29udGFpbmVyX29mKCkgbWFjcm8uIEFsbA0KPiBjcmVhdGVkIGV2ZW50ZnMgZGVudHJ5J3Mg
Y291bGQgaGF2ZSB0aGlzIHN0cnVjdHVyZSwgd2hlcmUgdGhlIHJ3c2VtDQo+IHBvaW50cyB0byB0
aGUgdG9wIG9uZS4gQWdhaW4sIHRoYXQncyBvbmx5IGlmIHdlIGNhbid0IGRvIHRoaXMgd2l0aCBS
Q1UuDQoNCk9rLiBMZXTigJlzIGZpcnN0IGZpeCBsb2NraW5nIGlzc3VlLg0KDQotQWpheQ0KDQo=
