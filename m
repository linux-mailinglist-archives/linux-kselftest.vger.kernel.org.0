Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296815EBE8A
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Sep 2022 11:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiI0J0e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Sep 2022 05:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiI0J0O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Sep 2022 05:26:14 -0400
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C358994A
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Sep 2022 02:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1664270732; x=1695806732;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GzXHiePcD6vWSZueb2dC2r57kox/Cu5yfa5VJxWiQx8=;
  b=Mgc5N6Qc45LecMTG4mnIuxwQv5K51QkxweX1idH1t2sIzAYy72rrgEFk
   6St6nw/9aJTLW+6xJQVM4iraqMfZ39d9kox43pDlepJ43TWFy2KoqXCvs
   hEXmKkilNr3Xh5Rn60XxSIzBZUHrA08RsJNZNven3FqzFbH0QCttXH7NU
   GlxPfWTxfMBHQO6CAUh2CKx22cFFLZP3KVTn2q/tDa/axmH50BLsqUnSC
   /5I3qv4izaxeD/qVdKjgu/U7kq/WkeIC6dTHbiaxDA8zcI6+EDyqB6OXo
   btqOCknepoYXi3KcOs33LWBNcPnnIWAKl7/VCdWE9z3y1UFLur6R1fJhs
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="66277475"
X-IronPort-AV: E=Sophos;i="5.93,348,1654527600"; 
   d="scan'208";a="66277475"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 18:01:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hotz17Oz5Qk4i4TgVmhvEM/lpAvtY8lniYlu8334lhnxEFLDV2fhs3+4I6R4WR4YgzO3zuUPELo8D9HYNoNqvLmYGh+uyHLitO/gCqKQWnZgI0iH8IzT3HMekj9L0kFTi2dY6Je254MC/ehFXz51g8VzgNiBktgQ1LcXg6NGYUWr6oe72gSp64AybAX8ELz3tTSJn/MVp/8fBVJi9lS4WO5mo3gjdnMvfMaa2DQ7GbAw1wNmMV8KtIGOvKXCp/+DrU8IbFfCuaWkLWEp8Nqnfoqu12YxLn2WYvROMco9aD3Ahpe4s5/qxz+nEf57wzxeQV+ZyWeE54Y6alZHKN7bBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzXHiePcD6vWSZueb2dC2r57kox/Cu5yfa5VJxWiQx8=;
 b=BPTghpl32M4KumIVlueoi2UQnnkBb91Ugce2FoTdK8w4VvXC+6EZ74H4KdIniC/hnZnuGKJVphk9+Ghl9cCQX9eOUJ1zgz5ueGUU65pQ1MQSN+TajTvvePF27nkpYrTH83JS7WBRxhwOm23CMo/2ddWJqqmyoElStLCbQmFw4LEt8BdKbhOJdtsfT2cw57wFsGD89CHgmzBaAauq7+xIoE5bou1UMMU9txSvrgsyWpq807PupdKyYGPGYKZVubLLlZLojKaL8dJRsYaQ3utlEax8/tmeKQZg+C9u4iM84iRH1/2qdbUymkRtB71O6XHob6Ry4eiplEgaR8Qsfgso6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by OSZPR01MB6229.jpnprd01.prod.outlook.com (2603:1096:604:ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 09:01:35 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b0c7:c573:a888:8099]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b0c7:c573:a888:8099%5]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 09:01:34 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'Reinette Chatre' <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 2/5] selftests/resctrl: Clear unused common codes called
 by CAT/MBA tests
Thread-Topic: [PATCH 2/5] selftests/resctrl: Clear unused common codes called
 by CAT/MBA tests
Thread-Index: AQHYx90CiTkIKy+iG0qUHnEUnuFwN63rxkuAgAc+m7A=
Date:   Tue, 27 Sep 2022 09:01:34 +0000
Message-ID: <TYAPR01MB6330740D4D21CE76B22496258B559@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com>
 <20220914015147.3071025-4-tan.shaopeng@jp.fujitsu.com>
 <56578d75-d5e9-a4e4-b1ee-a4dbecc167dc@intel.com>
In-Reply-To: <56578d75-d5e9-a4e4-b1ee-a4dbecc167dc@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMDktMjdUMDg6MjI6?=
 =?utf-8?B?NDJaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD1hMGI5ZGE0OC04ZTdjLTQxNTAt?=
 =?utf-8?B?YThjOS03MmYyNTNhNDI3YmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: fd4c2763ae464710898006e7f3d31cad
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|OSZPR01MB6229:EE_
x-ms-office365-filtering-correlation-id: 08f5b543-7951-443f-08e8-08daa066e10b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z5JZuCEKcDCsALm9lxXUceMrrpLJYDPfVqTeUcG2mKHVh6Tv/Tp0FscaD7w8tddzGGgQ02bVru8YreeS9dOXky3lme6Z2TRojYMIaEo/1Z3Rmm13zWBnnrc8YYpCO4sqnbBMFrhCJ6q8Lc2CjS7uxntqDZQXTFzGpixukCGCzZ074uty6gRA15XPSJcGeIKEmtw/qlDrJU1TI+h2ik6PbP5NvcqdfxV6of1usiwJVCIseSuslvHxFb0b36CdrX+LzoxahJJ+w3RzYhE4VPbpledQ2mZFqv8Xh+8eBlIe/DEXClX+SnWsT/XKcp51uumJa0rHB3gUjac3WXbUOIQ3QUOrNh0eRjee+nPfEgTngJqMuVH2R2hbwqKmPPXUJfDDl4QYmQRYOLwENdLjcbxiSQJi8xFKg52uXW5Fp2RtGUAyk3ww4zkbYlvRyUAJSsPjhcTj4XwCIDiOPYjk2cbgR9ysknI/OB8oR4f2/eTZhvLIbNHTzXyO4rRj40PjMODVpXFjCHmxavwE2UmZWOX7ZzcqQ4YlyX0QB3lq8cEcs8Ao+dyJEWzcKkozjRjhOgE0lEmnfK79yJYe6Ea0D3DkQ/rmptQBq22HDNdGLOoUGz0cIwKRSjsLpd9sh+t+jab1WZ2DlZDgA/Aa1eZ+700yIsGe9AbTMWWFhW9tVthShDYOc903DhyLBaKGt1d4jJp8m/L5sm0bFL+a6BKNf+jx1PRKxchswTNv9Nk8BhXuSu3T9TGebtiGbm7n3fnvO0kcBzOc92+yPWfhRyKKHCfYX+7m9AGsQYjZWsUx61khjs8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(1590799012)(451199015)(55016003)(83380400001)(186003)(122000001)(38070700005)(82960400001)(38100700002)(8676002)(4326008)(64756008)(66446008)(54906003)(316002)(2906002)(76116006)(41300700001)(5660300002)(66476007)(26005)(52536014)(6506007)(53546011)(8936002)(71200400001)(66946007)(9686003)(110136005)(66556008)(7696005)(478600001)(33656002)(85182001)(1580799009)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlF1VHVxaU9ZZVgvUmUrQ2VqVjUyNXJNd3ZzZmpTd0o3ZzR4RnloZkppeGxI?=
 =?utf-8?B?eVBuMGJxS0hMV3NSYXRoeWVPdzRQZU1kNFlJdEpBcmd1Rmo2TjMwVld3NlUw?=
 =?utf-8?B?N2pMRnl0OE5nc2xYTjRkQ3JSQWZ2bVU2ZS9hcVRwdXZRZmVMUHo1WHdyb2Zm?=
 =?utf-8?B?NWMxSWlHcXM4MFduYnVqWlQ5aTZHVTR3aHZ6dkRHMDJ6Qm1uMk0xRTJrUktT?=
 =?utf-8?B?N0pyaTNGOUNFK2hra25JSUh5L0hkZjhqUmgxMFNWcFc3MU02dlpDdUkwYmpz?=
 =?utf-8?B?TVRwOE9uakxKT0g3M1paMUYydW9iM1ZZT284QWxyVWh0WldtdC84L29wL0hY?=
 =?utf-8?B?a0pTWG55M21zU0l6NTZLcDUvTWF6TmhPMzZoZDJRVW5CamM3bXliL2ZyRTJU?=
 =?utf-8?B?MzRqOTVBajA5VlQ5OGxlU2VIS29tbHJSemVXaGNBSTQrL3BrK3J0aEtEME1V?=
 =?utf-8?B?bHMwK1Y0RlhOeU5vblF1VU4wTkpIdEtZUVBpWW1xWW9aeVY1VUZLUlljL3RM?=
 =?utf-8?B?RU0xQ0oxNEdQbE9rU2NENXFNUmF4MWcyVmVvdnNyMTUvYWlDOXhOVitqdmlB?=
 =?utf-8?B?aXQ2a2EwdnRqdTh3dGtSalp4d0lMa0VrdFFUZEI0UkNJd0dEVlBGZW9zZ3RD?=
 =?utf-8?B?NjYwYVpwYWNMb0lLUFZXUlNWSnFXYUNVeDVPQmZmMWhSTDJ0cHU5dTRNQnVw?=
 =?utf-8?B?eHNKbjRsKzVxM0pJbHVmeE1kclZWenNzcDNHb2t6ZERsa3k4cFl5eHErcEdp?=
 =?utf-8?B?REtGbDVpS1VXZ3F0V24xWHBVZDdrTXd5aFQ4c0MrYUplRVZZaVhyMW1sYU5U?=
 =?utf-8?B?WVpRemcwbTA3RUtDbFFDZUorSHR1cVFUaThUOG9RTFI2WHNiZGtZZWo4U0dx?=
 =?utf-8?B?YmFpRGwzYXFMZzE0SjZ2OHliNnhuanJCVlR1VDBEOHZ0R3BwVUYrRjc1dEV2?=
 =?utf-8?B?STU0SDY4aFpITHczL29QaytIY2pwZWhTcXVuVklvTHplTVpNc1J1SjN3NGR0?=
 =?utf-8?B?SjlvS1Z1RUpKRmxKRENBNjFPekdQcDgvN2Y0VHRMVkhGUkV0bzBkNUxkTVpK?=
 =?utf-8?B?SWtOeFJ2MlA1RWtFNGZxUHVZZTRiK25IeHYwd3BBRFhET1kwU1o0S0dKdGYr?=
 =?utf-8?B?NVp1cXNnYWFxMWpERjBSem9hcEdXM2dSaEFZR3ZMeWViRHhvbVpRMlFZMFNX?=
 =?utf-8?B?S3RsTTFKV0ZjYjFaaFNUdmlRZitDMGN1VE1MQjZwUlp6aW5SU3NPYkhNUDRQ?=
 =?utf-8?B?RWZCSHVVQU5pQit4cXdIU21tZTBSWmpjMEFRWnVCQTFodmtLOXB3TXZQaDdK?=
 =?utf-8?B?TFkyRlhkV3hOWEx2c05GSVBaWHBWRDFsQU5CYjNWQ1VuZjJuNlZFMjJoS3cr?=
 =?utf-8?B?MnpRNndTdWttM3hpOVZCNjVUdG1aK1JBV29CODhtdkJYNndkWlRFQlZzQndY?=
 =?utf-8?B?RDl2bllqdVpTT29PR0pCemRBWlc0MjZSTytsWk9ESDBqUnRaRTdtZ2tVcVE2?=
 =?utf-8?B?UmhWcFFlZEl6TmVMYkgvbTZScXY1Ri9iNlU3ZmljbG96MHJxYWpMSzRMZEMv?=
 =?utf-8?B?M0E3V2w3ZkF6ZnZWTHlXVzhGWElyQ01qNVZRa044U2I4dGNLWmk1eFo1OXZo?=
 =?utf-8?B?bDlKMHdKdDQvV29sMXpVR2p0QWNrbXVjaWpJZ1loZ2ZKZTFCWDhaTERwMzk4?=
 =?utf-8?B?TnZUL2M5TXdxQ2lPK3FSbG52T2pUZ1VoN2ltQ1hHQi96N2gydCtZZTA3TU9U?=
 =?utf-8?B?dE9TQ0FvcnpwbU9jNHF3ZTU5TnBxeW1wNjltalF4TkN1dnJ0dFo0LzBrUXQ3?=
 =?utf-8?B?eTJVQ2xxUTduVjJQWk51UVJkNnJUTTRDaVhhZWE4WlE3REZnbXRqWFdpUVZq?=
 =?utf-8?B?M3RhVFNSYXhtRUpIb1ZER2hDYk54YmF5WE41OXZtTGhKT3NPNEFXTVBndGZT?=
 =?utf-8?B?aXBTem8xSUQ0YWJ2VjEvN3RuYkNwSkljbWFMQ0dBTThTOGlrYW8yM0VuaFVM?=
 =?utf-8?B?OWFGeTZsWGp0V2xvMDFRTWVOOTVwVGlrMUQwbWtWdEdTelVhbkloemhIN01E?=
 =?utf-8?B?dnI2a1hnbncwTW5YMFR6MWtjdEtzbmtObkl3a0lUYnEzMUZ6KzFuNCt6dVhN?=
 =?utf-8?B?OTdLVEZDVFdXc001dklGZWlleXhtNmVZQkU4c0p4eDFDcEovWitxREVNUTF0?=
 =?utf-8?B?aVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f5b543-7951-443f-08e8-08daa066e10b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 09:01:34.8426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VdpOwpdOkjM4x10M4NwmpLr7YOpmd5mHvgm/ySc9fgiBgI+ux7rccoXUtq/Hz29ExyWLFHME7Wgiwp86GFhZEUJWHOdFv4Gn7bfB7reuYGM=
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
ZToNCj4gPiBJbiBDQVQvTUJBKGFsbG9jYXRpb24pIHRlc3RzLCBmdW5jdGlvbiB3cml0ZV9zY2hl
bWF0YSgpIGlzIHVzZWQgdG8NCj4gPiBjaGFuZ2UgdGhlIHBlcmNlbnRhZ2Ugb2Ygc2NoZW1hdGEu
DQo+ID4gSW4gQ01UL01CTShtb25pdG9yaW5nKSB0ZXN0cyBzY2hlbWF0YSBvbmx5IG5lZWQgdG8g
YmUgc2V0IDEwMCUgb25jZSwNCj4gPiBhbmQgdGhlIGRlZmF1bHQgdmFsdWUgb2Ygc2NoZW1hdGEg
aXMgMTAwJSB3aGljaCBpcyBzZXQgYnkgZXhlY3V0aW5nDQo+ID4gbW91bnQvdW1vdXQgcmVzY3Ry
bCBmaWxlc3lzdGVtLg0KPiA+IEluIGFkZGl0aW9uLCB3cml0ZV9zY2hlbWF0YSgpIHdhcyBub3Qg
Y3VycmVudGx5IGNhbGxlZCBmcm9tIENNVC4NCj4gDQo+IFdoaWxlIHRoaXMgaXMgYWxsIGFjY3Vy
YXRlIGl0IGlzIG5vdCBjbGVhciB0byBtZSB0aGF0IHRoaXMganVzdGlmaWVzIHRoZSByZW1vdmFs
IG9mIHRoZQ0KPiBzdXBwb3J0IGZvciBjaGFuZ2luZyB0aGUgc2NoZW1hdGEgYXMgcGFydCBvZiBh
IENNVCB0ZXN0Lg0KPiANCj4gRnJvbSB3aGF0IEkgY2FuIHRlbGwgd3JpdGVfc2NoZW1hdGEoKSBp
cyBhIGEgZ2VuZXJpYyBmdW5jdGlvbiB0aGF0IGN1cnJlbnRseQ0KPiBzdXBwb3J0cyBhbGwgcG9z
c2libGUgdGVzdHMuIElmIGEgbGF0ZXIgdXBkYXRlIG5lZWRzIHRvIHVzZSB0aGlzIGZvciBhIENN
VCB0ZXN0DQo+IHRoZW4gaXQgc2hvdWxkIHdvcmsuDQo+IA0KPiBJIGRvIG5vdCBzZWUgYW55IGhh
cm0gaW4gbGVhdmluZyB0aGVzZSBjaGVja3MuDQoNCkFjY29yZGluZyB0byBteSByZXNlYXJjaCwg
d2hldGhlciBjbGVhcmluZyB0aGlzIGNvZGUgb3Igbm90IGhhcyBubyBlZmZlY3Qgb24gdGhlIGN1
cnJlbnQgcHJvZ3JhbS4NCkkgY2xlYXJlZCB0aGlzIGNvZGUgYmVjYXVzZSBpdCBsb29rcyByZWR1
bmRhbnQuIEJlY2F1c2UgQ01UIHRlc3QgZGlkbid0IGNhbGwgd3JpdGVfc2NoZW1hdGEoKS4NCkkg
d2lsbCByZW1vdmUgdGhpcyBwYXRjaCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpCZXN0IFJlZ2Fy
ZHMsDQpTaGFvcGVuZw0KDQo+ID4NCj4gPiBDbGVhbiB1cCB1bnVzZWQgQ01ULXJlbGF0ZWQgcHJv
Y2Vzc2luZyBpbiBmdW5jdGlvbiB3cml0ZV9zY2hlbWF0YSgpLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogU2hhb3BlbmcgVGFuIDx0YW4uc2hhb3BlbmdAanAuZnVqaXRzdS5jb20+DQo+ID4gLS0t
DQo+ID4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvcmVzY3RybGZzLmMgfCA2ICsr
LS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwv
cmVzY3RybGZzLmMNCj4gPiBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvcmVzY3Ry
bGZzLmMNCj4gPiBpbmRleCA2ZjU0M2U0NzBhZDQuLjM0OWRjZTAwNDcyZiAxMDA2NDQNCj4gPiAt
LS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL3Jlc2N0cmxmcy5jDQo+ID4gKysr
IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9yZXNjdHJsZnMuYw0KPiA+IEBAIC00
OTgsOCArNDk4LDcgQEAgaW50IHdyaXRlX3NjaGVtYXRhKGNoYXIgKmN0cmxncnAsIGNoYXIgKnNj
aGVtYXRhLCBpbnQNCj4gY3B1X25vLCBjaGFyICpyZXNjdHJsX3ZhbCkNCj4gPiAgCUZJTEUgKmZw
Ow0KPiA+DQo+ID4gIAlpZiAoc3RybmNtcChyZXNjdHJsX3ZhbCwgTUJBX1NUUiwgc2l6ZW9mKE1C
QV9TVFIpKSAmJg0KPiA+IC0JICAgIHN0cm5jbXAocmVzY3RybF92YWwsIENBVF9TVFIsIHNpemVv
ZihDQVRfU1RSKSkgJiYNCj4gPiAtCSAgICBzdHJuY21wKHJlc2N0cmxfdmFsLCBDTVRfU1RSLCBz
aXplb2YoQ01UX1NUUikpKQ0KPiA+ICsJICAgIHN0cm5jbXAocmVzY3RybF92YWwsIENBVF9TVFIs
IHNpemVvZihDQVRfU1RSKSkpDQo+ID4gIAkJcmV0dXJuIC1FTk9FTlQ7DQo+ID4NCj4gPiAgCWlm
ICghc2NoZW1hdGEpIHsNCj4gPiBAQCAtNTIwLDggKzUxOSw3IEBAIGludCB3cml0ZV9zY2hlbWF0
YShjaGFyICpjdHJsZ3JwLCBjaGFyICpzY2hlbWF0YSwgaW50DQo+IGNwdV9ubywgY2hhciAqcmVz
Y3RybF92YWwpDQo+ID4gIAllbHNlDQo+ID4gIAkJc3ByaW50Zihjb250cm9sZ3JvdXAsICIlcy9z
Y2hlbWF0YSIsIFJFU0NUUkxfUEFUSCk7DQo+ID4NCj4gPiAtCWlmICghc3RybmNtcChyZXNjdHJs
X3ZhbCwgQ0FUX1NUUiwgc2l6ZW9mKENBVF9TVFIpKSB8fA0KPiA+IC0JICAgICFzdHJuY21wKHJl
c2N0cmxfdmFsLCBDTVRfU1RSLCBzaXplb2YoQ01UX1NUUikpKQ0KPiA+ICsJaWYgKCFzdHJuY21w
KHJlc2N0cmxfdmFsLCBDQVRfU1RSLCBzaXplb2YoQ0FUX1NUUikpKQ0KPiA+ICAJCXNwcmludGYo
c2NoZW1hLCAiJXMlZCVjJXMiLCAiTDM6IiwgcmVzb3VyY2VfaWQsICc9JywNCj4gc2NoZW1hdGEp
Ow0KPiA+ICAJaWYgKCFzdHJuY21wKHJlc2N0cmxfdmFsLCBNQkFfU1RSLCBzaXplb2YoTUJBX1NU
UikpKQ0KPiA+ICAJCXNwcmludGYoc2NoZW1hLCAiJXMlZCVjJXMiLCAiTUI6IiwgcmVzb3VyY2Vf
aWQsICc9JywNCj4gc2NoZW1hdGEpOw0KPiANCj4gUmVpbmV0dGUNCg==
