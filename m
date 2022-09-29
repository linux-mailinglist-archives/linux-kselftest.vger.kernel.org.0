Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0DC5EED39
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Sep 2022 07:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbiI2F2j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Sep 2022 01:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbiI2F2f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Sep 2022 01:28:35 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF85712AEE4;
        Wed, 28 Sep 2022 22:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1664429305; x=1695965305;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mi5mIohB1rtxUUyzFQi0/VuvmjMq2NOG36MyXKozOt4=;
  b=Q4xrIEkKcjLmARhm2PFPLlnF9Um8PmQpmnpt7rDefET3xS5Viq4GgZkG
   aqud4L4zAWtpmZVfsaK4YO/olFmP8A9sVbS/NQEb5u8VE71mBuRgH+nZl
   obYILhaeTWPJfuwFT1bHgSjFaUR3+q4ELhykOmUvWM+3Mqn6kS+SYC8/1
   SM21v4zBwHjB1AKDmT9qqMStlNtO/Rx3cyufGIyhlxXwQGsKnLEJ7Vy3y
   xoIl/xubpJ7UKtA+VaGbJpdib47V1TgDblXKWZCay94izSwsAFpSqf1ZM
   XhViVKWX5Ao7pM9oPO728Nvp9FRO1CbDgkXpq7ycOlgt08N/sXW/RHWYZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="66341668"
X-IronPort-AV: E=Sophos;i="5.93,354,1654527600"; 
   d="scan'208";a="66341668"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 14:28:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUqNC00lXUkjtQBtcu9eBOFtMekxNSR2shXX2VjsSOLYT+xzvRIgKRZ9YXgHj3iVsOIJHsf7vc3DsVS8rbjZg+AXi972l/X6DK78XpuIge/fT6LUl6CGfC1xtqm+bBtfK1XFo1UZNUS0u7QVh7Jb9lO9pT/m0HRGoN64PnD7L+nW12+QYpiIqQ20jlm6XDB5ATnJknMyiT0YHqaA1cP7k4WYpGLRzeaN2fEczn3XVzW+VMT/knshpgN70GC/j07xoALXSjcGXkUiiF33JJHc3bNyCxR/oTCEfNhJUBpvs83x4WDGfH+s3i87atXoppbOcVa/P1WCZ5t9dq8nqCodIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mi5mIohB1rtxUUyzFQi0/VuvmjMq2NOG36MyXKozOt4=;
 b=TPMpi5BPvDZSBYh7nfWLm0CBLusEWU0RvBmILN2B1QaZnqX7ESd87cpaLqxgGPktDT3qyoskUqc5bqoMOgjUS3Ems7W5GfhQiJO35c66JPJzqI33Q1QBhFEJQh/JNxqTXavPqLDXrXiSXbbW4qAG3uY5gc6JJ+q2Z2MtHqmCfiMygt/WEm+M3d+ZMJYnafQeZ53w2e5kx7EyhbrMNFuEGAv10OER/hblbfWpl0CEa8ZdNswFNXVGKaURC6X6mLBdcdXb2OeBUGHfntxkX+C0D5nPyNh39NQo+cHjBvtWg2vE3Cg7lXtrHZmahTkcsUW3rz2wJib0gSO16J67NviVyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYCPR01MB8501.jpnprd01.prod.outlook.com (2603:1096:400:156::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Thu, 29 Sep
 2022 05:28:17 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b0c7:c573:a888:8099]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b0c7:c573:a888:8099%5]) with mapi id 15.20.5676.019; Thu, 29 Sep 2022
 05:28:17 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'Reinette Chatre' <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 1/5] selftests/resctrl: Clear unused initalization code in
 MBM tests
Thread-Topic: [PATCH 1/5] selftests/resctrl: Clear unused initalization code
 in MBM tests
Thread-Index: AQHYx90ANVYDcoa1XUasHigKIwI5B63rxheAgAc+ARCAAg+YgIAA4/dg
Date:   Thu, 29 Sep 2022 05:28:17 +0000
Message-ID: <TYAPR01MB63302FA7919E8C95B9C56FC08B579@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com>
 <20220914015147.3071025-2-tan.shaopeng@jp.fujitsu.com>
 <24cbb6e4-d853-6c7e-cffc-daa7412d1eab@intel.com>
 <TYAPR01MB63300E751096E8F613CC7F398B559@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <580b7e0f-1303-bb27-0f9c-f05f793a30d3@intel.com>
In-Reply-To: <580b7e0f-1303-bb27-0f9c-f05f793a30d3@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMDktMjlUMDU6MjQ6?=
 =?utf-8?B?MDRaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD1iY2QyNmFhMC01ZjM3LTRhMGUt?=
 =?utf-8?B?YmNkYS04MjYyOTM0YzY2ZTg7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: f4a0dcdfe6d4452aa67bbbd383a4064b
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TYCPR01MB8501:EE_
x-ms-office365-filtering-correlation-id: a0f0eefb-b3e7-46f3-bcb3-08daa1db6a32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DHWnaN/xTT7nbWIIzS83C6xT3892td3ubw4MKYeDugfYNibWfgTIOgD43DtqCT4pfp4VOFOfvvxTBg1GE15aw0ljaSTLKfBZj2h5lSEc09+k8AMEDl1udRCxtKqg4w1Vuw6aETe5WQCFE1A0UzfWKZorONjql5jS2qbdpuZy1leHt7bjxQRNMP1e6V9R+42zbKUgOkOnaQUBCv5UMxEUJ6ivkiCvj0lLLymD2C2cI7/whku+6YGRlwrYEgN5ZIXXsXFW6u6ZLTdmZq6OUgi+XGa2bSECjB9HdQ8e8PxEGzAnhpoE+fyJg3jSxMd5994JWd1Z1lv0YTdDxJaXu6nVBCTPTeSrEevnp0PhPEZ3qijSgSzOp0tCmWze20FHdKV0qB1fs6kkqdsNwmeSNMm49WDb10H4t2eenPkOfPsBTe9SFDAjfaEtpEwpgl6sH/WYvDeKTI5IdQpHxSvxscvvQ8Aey0QDBRsW2Nv7isElsrmyVWAps05Hpegz+pjVjiNhuQTevIR8HV/3qw6gMeV9gqdkp1iTje3/XUDRtByVSOS5vEZpytLajmp94ENkwt1FEkxIT5mE/glduepsN9jBzofT/DZ4gB13Pg47lJA1t2e0t/IQ2Eomml9ixUbvEtIhaQMY8m/3KydxqVTbvzYQ+ohFFJhjXU8zOHigXPOmCWoqUFfIsQQenASrU1vyD8tS87z56I5aIm4Pd72qr3CURfA132NhgneVyjGbUK0/xAYXe6ErNUEhAMoSS4v2v5mjXEK9p4Kj/lEB+5lU/TzuTXwJ12lAEXXUTI5SA4ZRNiQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199015)(1590799012)(1580799009)(55016003)(38070700005)(38100700002)(71200400001)(122000001)(478600001)(86362001)(41300700001)(52536014)(7696005)(8936002)(316002)(54906003)(110136005)(2906002)(53546011)(6506007)(66446008)(83380400001)(9686003)(26005)(5660300002)(8676002)(186003)(33656002)(76116006)(4326008)(85182001)(82960400001)(64756008)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGRSQ3AwYXNqRTJiQzdmRWpxL0pGZk40enptWUkxVjFnWW5ITmNoclpTS2Mv?=
 =?utf-8?B?UmhtUmd3R3RpR0dxZFVkd0I5ajQwTzBoby9iNVB1SjNtbWw1YWt1LzNZUWxn?=
 =?utf-8?B?dzhZdkp6TzBsQTRvWW01c1J4aGo5Ry9lSmJHdVg0RzRHWTJvY0VldUxqZHVs?=
 =?utf-8?B?dE5HNFVqQ2hTako1NU5ZRVpVWWhIRkVBSHY5LzRkeDQyUFViTlpabnlFcnpu?=
 =?utf-8?B?NU9ZOTIxRlFPNEZ0MUo5Rzd4N3dKR0E1NU94cnBXbGJRMWRackdWSzMvdTc4?=
 =?utf-8?B?cStrK2U1TDlZYXpjR1JER0JDajE3Ti9PVUZUbVM2N0VqQnJHTG9PbHNtT3lu?=
 =?utf-8?B?aGFzWjc3WFNQWXZlS1UwUjR0Rm9iZ0ZCSzAzQ1EvMlVpNU5qeEhxSkw3T1gw?=
 =?utf-8?B?NVQ4a0F5anUvSXlQSVo4N0xlS211eUhHNWJxclkyUStOSmdFamZjdHgzVi9T?=
 =?utf-8?B?aDR0QkpZUGNZSm5VU3RqQkd5OVpHQ24vMUd4a1dpdHphNU9POWM0bnRiVktv?=
 =?utf-8?B?Wk9FalVMM1VNNjVDMWxWeW5RTFdlNXVUTVRDdUVSM241UjRlY013QmhsQUFN?=
 =?utf-8?B?Tm5aeHp3NlovQXh0blBZY0s4T20wUVpOei9CbDJQMGhZQ1BkenlwakxNNGpF?=
 =?utf-8?B?SS9uMVNMTXhUT25sZlZJTkZjbjYycVBKZEE3ckcvQzdKWnMyQWRseHk5c1dq?=
 =?utf-8?B?Ry9heGFmV25ITXRqU3JxUW5SU2x4aGd3VVVxRG0ySUptWUxHTXBxUmxEbzR0?=
 =?utf-8?B?UHorem5lSjc1QVI1SzV4WWlEV0xBWHFkQklxSS9vaWprcVYxRk1FcjVVbC9q?=
 =?utf-8?B?YTBqTVVKeWRHcmFxeE9Lb1NaRkNaWHE2ZEZXUmNRb2sva1JydnNBSm43TUhz?=
 =?utf-8?B?cXhDTnd6anhod1NWaVlZRTdSWXl6d0QwV1htMjNMMmJ0cTBRWkM5RzZlSW5q?=
 =?utf-8?B?dWh4M1EwV2FObGxabVU4UE14bUMwYjNldExkT2tWUGpESnlrdEJhQUdaaUtW?=
 =?utf-8?B?UlZhcVA0d0NDYVdycGJFaWJTL3doSDdoQmhPK2lFZloxcW9WTDJNbUhKM0pG?=
 =?utf-8?B?Z2NCZkJOa3JpYVdJWU9TZWp2R0lEOTlGVU5aRHNhaHVWNG0zaHVKUVNVYXVr?=
 =?utf-8?B?VkY0Z2IrNktGWUpMUW9CN3UyMjZFclpFRHdYcjdZMmRBRHJMVEpxQSswRUU3?=
 =?utf-8?B?alIrdXlvZkxWYWVIRyswT1F1amJOVExqSy95a2lFYXdqbFRzOS9kUnBVUGlh?=
 =?utf-8?B?Z2NGT2o4bjdWOUxUUjdVTUcrTXp1ZytQbWd0MEJ0bGdPT1hHUlRGNDVpSVVv?=
 =?utf-8?B?NW10Y1pzYWdPWjc0YjN6SzF3OFlMTUNqM1J5dDNnMm1sL1B0QzBTRzlEYThN?=
 =?utf-8?B?SnpkaXU3c3AxcTJQRGpsL1NUam5XNWduUFQ2UHVMcDJWcHFqMCswS3M1bDhT?=
 =?utf-8?B?WE1HbGtUbG9TdlNGME90dXMycnF1TjJFK3U4RTRTUnMyVUkxL2t6emZNcVVl?=
 =?utf-8?B?UTVOaFJ5MlVMREQzeWdqOXM3ZVBBQnpCcmZ6YjRBN0NQMm5NY1l1Wi9RM095?=
 =?utf-8?B?OXBJYldsSiszYm1TZVM2NldVSFhMUEpPTDk0aU5IZXZydmE3dGNObFZHTmtO?=
 =?utf-8?B?WExsNTFma1V4cFNvY0xISEFnSEcxNU8zYnlaYmRjNHVhL01DUlFWaDh3ODM0?=
 =?utf-8?B?QVU3UkFmNjN6amlHaVZmQkVoQ1hReTRRT2o1UG5jV1h3TWlzS1g2UU1sNmpm?=
 =?utf-8?B?ZGJJNFlQRDZjblZEbjFYL2Zla3VYUXNjSWlZT0VZaDRuc0REY0RNdGJvdGdP?=
 =?utf-8?B?eG1jOXNqQUsrUGVCYjN5RFE5QUVsNWp3em01dTE3YXNLWFYxWVB0YTEwVVVU?=
 =?utf-8?B?aHljaWdwQjlhUUo5UG9idzhKWnJEb0xuSlh4NVB6K1NhaHhsbzM2QTJXYUt3?=
 =?utf-8?B?RlVLSnNyRjl3d1dyUjBadlJNRVpIRzRTNWMyZktpN1QwVWZWWnpNVmdJYlpm?=
 =?utf-8?B?d3NFOTlkYmVTNnR5OTlJT0lRS1lUN3FPWFQ4UDdzaUt2VHd0MGZSWlFMQlBv?=
 =?utf-8?B?T2s0QlVHTDFYT3Zsc0kvNFVrWHlBQXYxRUQ4VVI2L3N0ZkRQQUJRMzdXVUxm?=
 =?utf-8?B?TnRabjh1TUR1TmE4V3EwY3ZGU3VIRS9vdWt4WFlyeFM2Z0xIMERKV2pqNE14?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f0eefb-b3e7-46f3-bcb3-08daa1db6a32
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 05:28:17.7653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hIFwr4KlHzbsXhXei/cxgGIrBYGSg21nnRPukEmLt/Cj5b/eTohBEQbkK9JKdBaU2kr9y4nJwyAbAVIVmPRD67dN+CC17JnsjroCz8v9pwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8501
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgUmVpbmV0dGUsDQoNCj4gT24gOS8yNy8yMDIyIDI6MDEgQU0sIHRhbi5zaGFvcGVuZ0BmdWpp
dHN1LmNvbSB3cm90ZToNCj4gPj4gT24gOS8xMy8yMDIyIDY6NTEgUE0sIFNoYW9wZW5nIFRhbiB3
cm90ZToNCj4gPj4+IFRoZXJlIGlzIGEgY29tbWVudCAiU2V0IHVwIHNoZW1hdGEgd2l0aCAxMDAl
IGFsbG9jYXRpb24gb24gdGhlIGZpcnN0IHJ1biINCj4gPj4+IGluIGZ1bmN0aW9uIG1ibV9zZXR1
cCgpLCBidXQgdGhlIGNvbmRpdGlvbiAibnVtX29mX3J1bnMgPT0gMCIgd2lsbA0KPiA+Pj4gbmV2
ZXIgYmUgbWV0IGFuZCB3cml0ZV9zY2hlbWF0YSgpIHdpbGwgbmV2ZXIgYmUgY2FsbGVkIHRvIHNl
dA0KPiA+Pj4gc2NoZW1hdGEgdG8gMTAwJS4NCj4gPj4NCj4gPj4gVGhhbmtzIGZvciBjYXRjaGlu
ZyB0aGlzLg0KPiA+Pg0KPiA+Pj4NCj4gPj4+IFNpbmNlIHVtb3VudC9tb3VudCByZXNjdHJsIGZp
bGUgc3lzdGVtIGlzIHJ1biBvbiBlYWNoIHJlc2N0cmwgdGVzdCwNCj4gPj4+IGF0IHRoZSBzYW1l
IHRpbWUgdGhlIGRlZmF1bHQgc2NoZW1hdGEgd2lsbCBhbHNvIGJlIHNldCB0byAxMDAlLg0KPiA+
Pg0KPiA+PiBUaGlzIGlzIHRoZSBjYXNlIHdoZW4gYSB0ZXN0IGlzIHJ1biB3aXRoIHN0cnVjdA0K
PiA+PiByZXNjdHJsX3ZhbF9wYXJhbS0+bXVtX3Jlc2N0cmxmcyA9PSAxLCBidXQgaWYgdGhlIHRl
c3QgaXMgcnVuIHdpdGgNCj4gPj4gc3RydWN0IHJlc2N0cmxfdmFsX3BhcmFtLT5tdW1fcmVzY3Ry
bGZzID09IDAgdGhlbiByZXNjdHJsIGZpbGVzeXN0ZW0NCj4gPj4gd2lsbCBub3QgYmUgcmVtb3Vu
dGVkLg0KPiA+Pg0KPiA+PiBJIGRvIHRoaW5rIHRoYXQgdGhpcyBzZXR1cCBmdW5jdGlvbiBzaG91
bGQgc3VwcG9ydCBib3RoIGNhc2VzLg0KPiA+DQo+ID4gSW4gbWJtIHRlc3QobWJtX3Rlc3QuYyks
IHJlc2N0cmxfdmFsX3BhcmFtLm11bV9yZXNjdHJsZnMgaXMgc2V0IHRvIDENCj4gPiBhbmQgbmV2
ZXIgYmUgY2hhbmdlZCwgYW5kIHVtb3VudC9tb3VudCByZXNjdHJsIGZpbGUgc3lzdGVtIGlzIGFs
d2F5cw0KPiBleGVjdXRlZC4NCj4gPiBTbyBpdCBpcyBub3QgbmVjZXNzYXJ5IHRvIHJ1biAiaWYg
KG51bV9vZl9ydW5zID09IDApIi4NCj4gDQo+IFRoaXMgaXMgdHJ1ZSBmb3IgdGhlIGN1cnJlbnQg
dXNhZ2UuIFlvdSBjb3VsZCBhbHNvIGFkZCBhIHdhcm5pbmcgaGVyZSAoInJ1bm5pbmcNCj4gdGVz
dCB3aXRoIHN0YWxlIGNvbmZpZyIpIGlmIGEgZnV0dXJlIHRlc3Qgc2V0cyBtdW1fcmVzY3RybGZz
IC0gYnV0IHdpdGggYWxsIHRoZQ0KPiBjdXJyZW50IG91dHB1dCBvZiB0aGUgc2VsZnRlc3RzIGEg
d2FybmluZyBtYXkgYmUgbG9zdCBpbiB0aGUgbm9pc2UuDQo+IA0KPiBJIHRoaW5rIGl0IHdvdWxk
IGp1c3QgYmUgc2ltcGxlciB0byBzdXBwb3J0IGJvdGggY2FzZXMuIEhhdmluZyB0aGUgdGVzdHMg
YmUgbW9yZQ0KPiByb2J1c3QgaXMgZ29vZC4NCg0KSSB1bmRlcnN0YW5kIHRoYXQgbXVtX3Jlc2N0
cmxmcyBzaG91bGQgc3VwcG9ydCBib3RoIGNhc2VzKDAmMSkuDQoNCkhvd2V2ZXIsICJudW1fb2Zf
cnVucysrIiBpcyBleGVjdXRlZCBiZWZvcmUgImlmIChudW1fb2ZfcnVucyA9PSAwKSIsDQpTbyB3
cml0ZV9zY2hlbWF0YSgpIGlzIG5ldmVyIGV4ZWN1dGVkIHJlZ2FyZGxlc3Mgb2YgbXVtX3JlY3Ry
bGZzIGlzIDAgb3IgMS4NCg0KOTcgICAgICAgICBpZiAobnVtX29mX3J1bnMrKyA+PSBOVU1fT0Zf
UlVOUykNCjEwNSAgICAgICAgIGlmIChudW1fb2ZfcnVucyA9PSAwKQ0KMTA2ICAgICAgICAgICAg
ICAgICByZXQgPSB3cml0ZV9zY2hlbWF0YShwLT5jdHJsZ3JwLCAiMTAwIiwgcC0+Y3B1X25vLA0K
DQpJIHdpbGwgZml4IHRoaXMgaW4gdGhlIG5leHQgdmVyc2lvbg0KDQpCZXN0IFJlZ2FyZHMsDQpT
aGFvcGVuZw0K
