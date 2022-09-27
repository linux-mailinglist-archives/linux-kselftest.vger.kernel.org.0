Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908FB5EBDD6
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Sep 2022 10:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiI0Izy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Sep 2022 04:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiI0Izu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Sep 2022 04:55:50 -0400
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7803E67CB0;
        Tue, 27 Sep 2022 01:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1664268949; x=1695804949;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SYndDlk0doP7vpuwmZCR+hfwT00Sh5SaVb0JeYoqGQo=;
  b=hPpPc1LBgsnQcQGIG6K68w/RkNEWN9FqL5ayYGed01ovEaajRtPLC5qr
   t+NiIMebehll4cw/laIUp1i5LA8WBnWA7/w5HvrrRBJMYP3/dPAnbzjo7
   /E2QJdQtswYyVpdVVEZ/YpaiiKdyl+zG06L5h4rAj+2qO3wV1p6pghwPW
   ECdcyR3+cDkeY6X+vbG7zVmh/I4lSg8b2saZNW9u2O350mIh1B1GjUCTL
   mb9/aE0kbFPthpBf4SBLgExwdfDg+GsjoZ1wzhbTrpQXVkNtxH5zaPmYH
   lz9w+6sl098kdQWwsppFuvUfqXBZjOkm2x1rnlXWY6bSr+r5SYdqFwz+q
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="73953065"
X-IronPort-AV: E=Sophos;i="5.93,348,1654527600"; 
   d="scan'208";a="73953065"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 17:55:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItmFclWp4bbD5A7o4mmppqwy4a0TrqF9RepNVzZAKSBRJ+TfdeIRjRo7jV0p2Te8wljcj518akSktcaqfYiGYqm0Tn7MA+9dJgeSw+uzfaTL6o0QO1+TtsXLlBepA/1I0sALoMpgDGKbWtGn0l59OTjBobK+R6t336ITng2nAo8pBFUrSFJTOpRsYMQqbSSyMMrRmsxjd8VAN3hdflakRskguZPQpkAW4BPpn9Vecre6NN1b/Xfx5Al0MpVEJ5A0BURiEulfPLXB7gQ69IsZlPgWbIEW3WFFxwN194g6Riw6BVj/FI71rcvmuB7frky6hWkBarhwDdFJMvExEpSDXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYndDlk0doP7vpuwmZCR+hfwT00Sh5SaVb0JeYoqGQo=;
 b=BxxO4ReR/NXvn7guGJ7CJuKOu7zHvpPkG4PHwE+COKq7O5FNlMJYbBO0G1qTx26uYzHUTZBmTgP7abSH4BxkPGVhosINBOQObgYStb/Uc6dkAKdvKh7LC1OcB2poLOzusDqRy4aUwjiTC64zzMDGYCNC6pkpaL9gnVUQkk+w0rf6mFcdbyui/+oWOBIhh7/lIyN/cJvdk0Q9WyIjC5884ZCZsaqHHXN7Oo+xsq5OQPQyIQst3WFHUA3sXS/lYUlyhAfO9LHU3ax1Pv/JnIqkwVbzeb5qkEe+aK0GNU+9CQUuoxtbU3wGA1HMdY6jdG8KlmrZ/94Tv7D2XaRIP8n1XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TY3PR01MB9793.jpnprd01.prod.outlook.com (2603:1096:400:22b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 08:55:42 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b0c7:c573:a888:8099]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b0c7:c573:a888:8099%5]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 08:55:42 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'Reinette Chatre' <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH] selftests/resctrl: Return MBA check result and make it to
 output message
Thread-Topic: [PATCH] selftests/resctrl: Return MBA check result and make it
 to output message
Thread-Index: AQHYx90BWRcamk0cZEK+Hm0C3kTh063ryAmAgAc+S5A=
Date:   Tue, 27 Sep 2022 08:55:42 +0000
Message-ID: <TYAPR01MB63306CF2660A3D7937C37D618B559@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com>
 <20220914015147.3071025-3-tan.shaopeng@jp.fujitsu.com>
 <97522844-0b19-fcfa-dd39-c2c2c9ca37ca@intel.com>
In-Reply-To: <97522844-0b19-fcfa-dd39-c2c2c9ca37ca@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMDktMjdUMDg6Mjc6?=
 =?utf-8?B?NDlaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD01NzY1NWRhZC1jMzEzLTQ1MmMt?=
 =?utf-8?B?YjJjMC0wZTIzYjg2NjY1YTQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 314af9ecda5f4f729930fc7099dabb23
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TY3PR01MB9793:EE_
x-ms-office365-filtering-correlation-id: 261635e0-4b95-454d-d6cd-08daa0660ede
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u7nOPw7YgrVDwKEhKb2R6XTvOKyYaO8d2t3UZ/f170MzAR5dHiIUoIpcnNW/6CZ/ZTsxNaJ5I1gNWZvpjBnnZMTDSuhdgHqPm/Sn2MmNJ6bOIqYfHY5FfFkX86Quku2pYpgyevc/OBxoqU9VtUolKh0DTdbHIVHZWxyhGubR3Qaj3byA9I5BUm49DAWwBxLkEgwDA/9KC630tSQ0clm2pO5crImBQyKQ1jvkU7Dc22wTwLCeIXrmtjy4NrtZllhsjiC3bCEXtYd6Bi1SFe09JDW9/tpmwZ6L/Pa7grVc6ic+h6qhgT6t/DOE41X/Z4cg17PsWe3mHPSYUzVVQ5HNH4AUV5U3Lds2yeHqKrlnrIAUgnNU4uLN1dtobHNlmRPyWZW52XOYAf+UXndyCNQtEvJ9ciHbkLhpEzYh4bPBo2NwyFfAo489GMRp3euM+EB7HEWD396clcZnHpH4VfpF7goVOpr2+0vEjOFrYX0TIU/WApOGmDp4YLnMRb3YPUxPBXgAesUNDFQrehCMEOGJihhRPaa/tyuIQ2Q1CQnod8QYWBym3Bg/rBNO5JKbB6MNn6H3TlUVQQCyUfkm84YjW4fY+Znwxyi98YRdcoHa1i7HHtxJRL206L0Djsh1Nli5S5o3tbpa2G3pToNS5VvfI6mGEZRjfT2NHqzAOnjkni0ErYYutgWZL3yQrVnKEyrnP17+liA4OR93bxWD/j7IMtSqIgRJ2LTSnI3l4gTw5EhF+Q+Abg/jHPL4IuSnUd2O+RbHm/u4mp2MNrOZ57DuPjqeRgPTkj5S/P3HgfGr4Os=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(1590799012)(38100700002)(122000001)(38070700005)(82960400001)(86362001)(85182001)(33656002)(15650500001)(53546011)(26005)(9686003)(2906002)(4744005)(55016003)(83380400001)(186003)(6506007)(7696005)(71200400001)(478600001)(54906003)(1580799009)(316002)(8676002)(110136005)(76116006)(41300700001)(8936002)(66946007)(66476007)(64756008)(4326008)(5660300002)(66556008)(66446008)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3pHbUdjYVB3cURRY3IvaUNUN25GNHdZSW0zMHVpTkpGc3dnL1FFVi9VYTAy?=
 =?utf-8?B?UUg5cXRQQ0ZRdXBSdHp2MUs4WHZqdytKV2owZncycFV4YlJHcm1jenVLRDZz?=
 =?utf-8?B?R1Rtdkl6bDdlNlBCdm9GR29Hc0NHYXl3QzFlODRyR0VSbmlNMmFDSG1vdnly?=
 =?utf-8?B?bmlIaVF6Q0JNTVI0enBNaW5VQ0N0TXBENGVLbEQrcno3WnBkSEd5bndKVzFS?=
 =?utf-8?B?eUowMjM0YWJBN29qV2FjaHFWMHZnVzgzYmpSbXFRQnNES090bHhhT3RDUkdH?=
 =?utf-8?B?UUYrckFqUjlOUUVTblNSWWZSUkFKb1VqZmVFcW80c0FvOVlIS0NtZGc0SVdr?=
 =?utf-8?B?UXZQOGR0K1ZibG51MENSZHBoV3JFQmtqcnl1NzJnS21EVno2MllwYytoVEpP?=
 =?utf-8?B?T25WKzVxSVNDSFlKeFA3ZFBDZmRoSVNNb3gycmk2N3huTG9XWkNwQTVKWlJk?=
 =?utf-8?B?em5KOXNHUU5DMnNQbWE0RWVCNTBxeGViUnNjMTI0QitxNDR3Mk5ES3pEL0VO?=
 =?utf-8?B?RGFOYkpCZVNpMURGZ0x2UnBDUm5lNGZIam9nMS9kbU1QRGtGVmFjbVp1TVhk?=
 =?utf-8?B?WExvcFBMSG5UbVh1RjBZQzFNOS9kdk40d2FVcHFwejVQc0xaeU9wOG41cnNZ?=
 =?utf-8?B?bVVPYTA1aGJxZnZ4QnNjTHZ1d2Z5Zk1lb1h0d1lZaTM3amxtR042cWhsUEw1?=
 =?utf-8?B?T3ZtbXB5QUR1cVR2ZjlLa2ZuU21OcnROS3RGN2ExdSsyam5IN2FxUUVkWU1C?=
 =?utf-8?B?TVh3MjJsdXI3SXV1V0ZyNDBqMGlVdnN1dGlzVWVyaXRrMmhIMGp5d3MvNUxk?=
 =?utf-8?B?M09jS2Z0U1ovMjNLOTVEc3JuN1BENmJQVGtNSG1Xa3VyR1lqTGpsWEwvcUJD?=
 =?utf-8?B?NnVvVW1CekdBSTVkd1BOYU9GWkJIRG9reG9PbFhpNUs4L2FTNmhSOXpaKzZr?=
 =?utf-8?B?bzFUaG5hY1NUQ0hpaUJ0QnBzN3F0REVLSWZYUVZ5Y3A1NCtCZ3J2a3lEcy9r?=
 =?utf-8?B?RjFBTCtPaHR2WWhIRWhoUXJBbC9lVXVlOVJPcEVxalhuZThmbDRsbHJ6UjVi?=
 =?utf-8?B?Y1pNR2YzcHVTY0hTWGlqZzRYZDFPamhjSWUrbU5zekovT1pPb280eGpXS3NI?=
 =?utf-8?B?SXdwbzVSVUhKbThqUXpWYWJnOWRocllxcHMwS2hyalRZekxPdTZhc29MQ0lL?=
 =?utf-8?B?a21vcklhV29pZ1ljN1cvZUhLMzBXSGJkME54NEg5dm1KdE1ZUVZLbU5CV3NR?=
 =?utf-8?B?bXVWMjE2R2Z6SUNhQ1dlMHJWZmdDM013TUZwOHk5S3hXQWg0LzFRRkp1bGdN?=
 =?utf-8?B?L3E5cGZHaGVEVHBkaTZRMHZHeC84Q2xKazhWNlUyajNpU3U2b0Q5RjcyaTNl?=
 =?utf-8?B?MXlOZTBpcXl2QWwzaEI0WGx6VFR2bGRvQm9UdHdOeEpaTEZBQk8zcGJJN2VD?=
 =?utf-8?B?ZFNQSzZOZ081bmpSaWlKNy9Md0FESVJIL3dxMkxmUTBQSVVLeDRBZG5pb3dQ?=
 =?utf-8?B?ZnNTQkVxQlhWMEpyZzdrUXNTek9zOTFGTno1TVhDQU0rSm13NHY3a1JDRDBN?=
 =?utf-8?B?cWhDQ3Y3aVJqcGFHd0dkWW81andFeFNpRFRKWDBWZE5LeUNYUmdrSWlHTDdx?=
 =?utf-8?B?Mk0vdHlVdkx2U1NSTmZLV3JSaVNlbHhwTDRYb2hOekNRRDRwUnJxY0tTeGh4?=
 =?utf-8?B?WGI5QVFaWUd1MEVqZE1RdUErWVFYNDB0OWRBanVYM1BpZDRZTzlSZFp3NnBP?=
 =?utf-8?B?S2NCM21Xa3hXN1M3L0M4bFlYWUcrcHRHcmNiVTVnbjcxd1hPQmxoVlRiZElE?=
 =?utf-8?B?bEFBVHhVQnlEL21ZbDJacWIrc2xvR1hobHp2L3BzRG9TdkQxY0pBV1QxT3hJ?=
 =?utf-8?B?Wlc3eDlQR2tJQm52bHhQZDlMSVBHaVlvZWJna0FQMXNkSm9hV2V5bmFEaFlS?=
 =?utf-8?B?L0g0N1Bid3N1dVNLQjBwUm8vNG9IbytZeTF4NkU4YURUKzhwR3U4R0IveHlH?=
 =?utf-8?B?TWoxdGZxQ2pqQTFndHQzR29YT1JUejc2ZGhBa3pGRjFxUzlkOU1EbFhPRHJ4?=
 =?utf-8?B?MzR6RWdJaU1yOC9HbDlES2RPM3plZHN3Rlg5TGdyRlRnU2pzNVFhU043Rlph?=
 =?utf-8?B?YlpaUTdDNmQyTGVGK2E5RXlvTHk4M1g0T1BKbHI2aGY4Q3pvRHNKeUk4ZEpZ?=
 =?utf-8?B?K3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 261635e0-4b95-454d-d6cd-08daa0660ede
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 08:55:42.2471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rZX35W7LJHyiPTuhZMH6qTyH5pKIY+R7YtYSUNxvM8Pkp0B3/pR7TtNlFCQDk4MVFirOHf02yTtD4lJutdsHJAL4tCeFUSc58Ch7ViRTjfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9793
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgUmVpbmV0dGUsDQoNClRoYW5rcyBmb3IgeW91ciBhZHZpY2UuDQoNCj4gT24gbXkgc2lkZSB0
aGlzIHBhdGNoIGFycml2ZWQgYXMgYW4gdW5udW1iZXJlZCBzaXh0aCBwYXRjaCBmb3JtaW5nIHBh
cnQgb2YgYQ0KPiBmaXZlIHBhdGNoIHNlcmllcy4NCg0KSW4gbmV4dCB2ZXJzaW9uLCBJIHdpbGwg
YWRkIHRoaXMgcGF0Y2ggaW50byBwYXRjaCBzZXJpZXMuDQoNCj4gT24gOS8xMy8yMDIyIDY6NTEg
UE0sIFNoYW9wZW5nIFRhbiB3cm90ZToNCj4gPiBTaW5jZSBNQkEgY2hlY2sgcmVzdWx0IGlzIG5v
dCByZXR1cm5lZCwgdGhlIE1CQSB0ZXN0IHJlc3VsdCBtZXNzYWdlIGlzDQo+ID4gYWx3YXlzIG91
dHB1dCBhcyBPSyByZWdhcmRsZXNzIG9mIHdoZXRoZXIgdGhlIE1CQSBjaGVjayByZXN1bHQgaXMg
dHJ1ZQ0KPiA+IG9yIGZhaWwuDQo+IA0KPiBmYWlsIC0+IGZhbHNlPw0KDQpJdCBpcyBmYWxzZS4N
Cg0KPiBJIHRoaW5rIGl0IHNob3VsZCBiZSBlaXRoZXIgc3VjY2VlZC9mYWlsIG9yIHRydWUvZmFs
c2UuDQo+IA0KPiA+DQo+ID4gTWFrZSBvdXRwdXQgbWVzc2FnZSB0byBiZSAibm90IG9rIiBpZiBN
QkEgY2hlY2sgcmVzdWx0IGlzIGZhaWxlZC4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggaXMgYmFzZWQg
b24gTGludXggdjYuMC1yYzUNCj4gDQo+IFRoaXMgc2hvdWxkIG5vdCBiZSBwYXJ0IG9mIHRoZSBj
aGFuZ2Vsb2cgYnV0IGluc3RlYWQgYmUgYmVsb3cgdGhlICItLS0iLg0KDQpUaGFua3MuDQoNCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoYW9wZW5nIFRhbiA8dGFuLnNoYW9wZW5nQGpwLmZ1aml0
c3UuY29tPg0KPiA+IC0tLQ0KPiANCj4gVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgY2F0Y2hpbmcg
dGhpcy4gVGhlIGZpeCBsb29rcyBnb29kLCBJIG9ubHkgaGF2ZSBuaXRwaWNrcw0KPiBhYm91dCB0
aGUgY2hhbmdlbG9nLg0KPiANCj4gUmV2aWV3ZWQtYnk6IFJlaW5ldHRlIENoYXRyZSA8cmVpbmV0
dGUuY2hhdHJlQGludGVsLmNvbT4NCg0KVGhhbmtzLg0KDQpCZXN0IFJlZ2FyZHMsDQpTaGFvcGVu
Zw0K
