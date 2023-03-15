Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165AE6BA490
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 02:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjCOBZR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Mar 2023 21:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCOBZQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Mar 2023 21:25:16 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8911A65E;
        Tue, 14 Mar 2023 18:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1678843514; x=1710379514;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PCgOHcu3CQ+gWK3ED0ITFHJGsCsmr25Gr9NWhI58EIk=;
  b=fAIusPDWKCSp35pI70zTy3GHvA//iWKqxLvQTHl0Oe1IYU/59Juueeb/
   VB17GsQzeZsZkdVTLJhKX4JVEStPPFDchn+cR6YS8Uw1fI13OqfDckKwh
   Zk/Q7Say3BOWZTmOyx8m9SsRh7oKF3B3dIlOD7C1csMC/V5LXCF7D98bu
   Yu64eBUlC5T+iwwIXvP/mS6dJavGgbNjwLk13XRT7jeO89XFXv9EXpl5l
   JVt0C1eYeLGbpzX6RDCirSjjglGrCT/tiXZhzFjff5G+PZjgTE/D7t5QD
   Wr9GT8BPuhT/XahD1vTbcoUFQ5ip4a5cDxmi1wVcUwZn6sI/pPrCWfQIE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="79412509"
X-IronPort-AV: E=Sophos;i="5.98,261,1673881200"; 
   d="scan'208";a="79412509"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 10:25:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2wyLCqFSX6TF+Gs3qC6IajZkE3OBjMHdpWY8NbC5JVGzDn6Tx1uzO25Pj+8Oii9fV6j/+Zot6y0G4FfHzjy93laCi7dfy8ZX3E8AwDQwVzkxPtqlOwHVS0nGQF46q7ZbqfUO/4G0zS4ERG64e6WgJEBhfeUDpKhXpvVMMupTvtLlaqTmWax4QQE1FAIdF+zp5BmjAR1ITeNygEqdnCxLpEngG6ra9ivsKjvMqupUF+aQitCWpiLyNACRKF3vCon6SOgWi1qrjulidNDOvnVfgdQLVx35IqcF+nX7ZQJLO7c/rSpCwQ7O2qvRz6nb6gBnqy+/CGPY/6PLLJTgXpblQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCgOHcu3CQ+gWK3ED0ITFHJGsCsmr25Gr9NWhI58EIk=;
 b=Ks9wbhcdpk3DK/Rxsfd/EyVoTdyZPED2BZn1aBV6Q2Cb7+rd47b0cozIgVdn0zVckwe/YGLnJ+BHdXDy+/vvfOUDk0vxu/T6/0O/jJiqs0F3Aa/WRkTlA8OSBEbKsHhFT8EeTgoMaLUePGncBOKLFMe9dHiI8SgDOCbIm0BdRO40d0N+9BaTt1S4IVKPr2BV3/6GNXyOui/t9arKtxyIbgSbYugwRyQKsAz4gxBz8sfgvah4cvFcOp7PzzLnmQzrA49NPWCJVP4nVnMdCFxGsmVz6wd8X+vwPYrIl/A26IuObl0WyvrzYxibI/MgEIyn4BVWiGP0mHop1R7JRZ0xvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYCPR01MB7727.jpnprd01.prod.outlook.com (2603:1096:400:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 01:25:07 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::2f96:c0c5:79bb:3a59]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::2f96:c0c5:79bb:3a59%4]) with mapi id 15.20.6178.026; Wed, 15 Mar 2023
 01:25:07 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     'Peter Newman' <peternewman@google.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
CC:     Shuah Khan <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "eranian@google.com" <eranian@google.com>
Subject: RE: [PATCH] selftests/resctrl: Use correct exit code when tests fail
Thread-Topic: [PATCH] selftests/resctrl: Use correct exit code when tests fail
Thread-Index: AQHZUpepdLq+tJ0ycEysbgb8veKyqa77Em3g
Date:   Wed, 15 Mar 2023 01:25:07 +0000
Message-ID: <TYAPR01MB6330DE75101E82B1A8FD84BE8BBF9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20230309145757.2280518-1-peternewman@google.com>
In-Reply-To: <20230309145757.2280518-1-peternewman@google.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjMtMDMtMTVUMDE6MTY6?=
 =?utf-8?B?NDRaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD00Y2IyOGI0NC0xYTAyLTQyMzct?=
 =?utf-8?B?YmI4Ny0wMmJlNzNhOGRjNTI7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 5b0aca2107ad4a6797fc998bf966abb4
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TYCPR01MB7727:EE_
x-ms-office365-filtering-correlation-id: abb7edf1-fd94-4a90-d64a-08db24f41c89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: byLYxxYAEwyciSLmEkqc8CEeaXuU/K18QpImoqQ1r0BQj/5/agRG69nNF6IFq9rnwP0J0sJrZGLYVUyVR4WMuH9xZLkOfNs/gOohuMTUbzIPwlkh/18C9Z5sXPisjM/PSn5M/JAuw+s2yaLNoBUoP5tldWME0SDvEFpBN8DD23QXhJOx16imt1Wb8SuqJ0KZYiJN/Wz8ptdRv7HL4DMWxiJrbqF6y+lUSVDFj8wBaysBk7sOcN6mOyFXUX6IsgimZNJ3AWA0G1HIZcud0ly/Ig1idii4a2kIMdYdgfmErkUidq5G9CkYQEkJqTCumm1VnRHEHxCs+pohqet6clGKlUcYiGxTJNkn/3HnkPJXMW+boHUSJLVGezR9wa3T4+QeJ0L+jT+YQsSGAi78Us+SJV+fAI/300dsu/8o/Dcm5CsG6/BuzQsULY+6NWhWsyLHW+kf4s9NFHfpxloS4iEhAFH4i91b5FprK9lkAKUaBIYdGj7EmbadrB1R85I2XyyNyb2LS3KyikUbY69lsvk//7453hYCrif6cfUmJkUTIdibME4xIc2dJMQRM3eBB5QWdNLlaJt4GwY1+jVdQyqU4+pPDO0tnvOpUEtvlOvNZ39ZM+yKiKBeTl5tv/w9iq+IDe8mpaEEbVnC7UUwjBmmW1+BFVfNf8DllV/87c66R3mg/H2xMPuuLMTSxgMGYtsgSz4bBrEsrK/tx61cOXeUcMZ0lZbl4cEuYTHlcehUqFo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199018)(1590799015)(1580799012)(8936002)(52536014)(5660300002)(2906002)(82960400001)(86362001)(33656002)(38070700005)(38100700002)(85182001)(122000001)(7696005)(71200400001)(478600001)(66446008)(66476007)(66556008)(64756008)(66946007)(41300700001)(8676002)(76116006)(55016003)(4326008)(54906003)(83380400001)(110136005)(316002)(186003)(6506007)(9686003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXhUeWdsREdzYkZORzRQWFlSeXhHRlhvenBveU9xWkJ4cUtsam9FVzlWOUU2?=
 =?utf-8?B?OS92OGszcTNOb2RxamdXNFhHRkcxTTB0NWxMaW1OT011Mk9sZTV4am9uVVNF?=
 =?utf-8?B?TkExR1o0aDZHNFUxS3NOa3hrTXY1amlYVk1KR0UwbE03QytrZ3IxUS9EVUhh?=
 =?utf-8?B?SlFvV1RqNVNOc00xU0xyN09mQXJlVkROdjBzc2xiVXZWcUxadWJTNzhzQTdB?=
 =?utf-8?B?MkJ3dUkvbGJQTUQwclpiTFN4QjhaRklZUldVTEp3RDJFQnkxNTQ3bVJMK3Nr?=
 =?utf-8?B?c2pEeEhNZ3FxNkI4TEVFNitpc0tINVYzbXVFUW5WU1lZNmVyZWxvV2c2RVZu?=
 =?utf-8?B?Uy92SzhaSFBlMHdRbW43QWl2RDQvangzUU9xYitvbzloRlkyM3ZKV2tXM1Zv?=
 =?utf-8?B?TUg1dXk3OXQ5UnNGODlIQjNyY3gzSWM1RHNYNHRkRnBGblVpU3FrRENkb0xn?=
 =?utf-8?B?WHNpYkpnaml6OHNWZElQNmVhQitLMVc2UzlaNE9jL3ZZOU8xUXI0TFBDYVhG?=
 =?utf-8?B?a2tGeHlHV2lUcVpFa0JsSWpKV1o0NjAzdDFyaHlNVDQ2d0FkL1kvbTRCKzZu?=
 =?utf-8?B?N2xyTXF0QlUwKzRuaGJWSGVWeDdmNUtlS2Y5NlpQMUZGcElkdjhqaGwzVTNZ?=
 =?utf-8?B?Rk00bHNZYnhaMmNNcUNLcHNkaUN4SnB1eVRVRndFVndvWUtSNU41UGpvMGJi?=
 =?utf-8?B?YmhsendPZlhYYngzbjRXNWRtcksydmxSTnZ3dXpGbFphRUtSTnRRekJ5bGE0?=
 =?utf-8?B?dkliVU9FUnh1Z016ck5HYUNrQjM5NzJsWW1qQ3dEQ2tlQ0ZXMFRKOHY0L1ZQ?=
 =?utf-8?B?NHFLZEg4VmFtKytTV1ZMMjJkMEdYTFhHMklKczQwb1p4bWh5N1ZCU2lubWJZ?=
 =?utf-8?B?Q1VhNkRRazdkTHVOR25OQjV5N3VrWFJ2QlVOWUhJTjJkWmc4cGI0U1RjUWh2?=
 =?utf-8?B?dWdVcFE5Qkg0aEdNb1M3a0xmY0lDV21Cajd1OUpXOVFCTFlqZXVyQ0NhczJL?=
 =?utf-8?B?UmZSOXFDRmZNN0FhQnVmUnM5UWFyLzJZUWVFN2dOT2VZdXg3L29FRGo5bS80?=
 =?utf-8?B?c2thZ1hFRWxTQ2M2SjA2d1pROERyRTVFMmgxNEY2c0xjc2dXbkpBcldYVHlp?=
 =?utf-8?B?cnE1Y012cWR0bmlYSEREOFhVQnRzTTVQNEdkQzNVMTBhbzgvZjJTNm1vbzBx?=
 =?utf-8?B?RDNhL2U0Y3hHVmNWRG9ndStRTEZhcTd1QVJuMjVNcFZ5L2xvTVBGYnMrUkRM?=
 =?utf-8?B?dkVPTWFOVVdPL3Nlb01SaUxuVUMybG10c1dueXYwVHFFRzZjUEV4QkwzRSsw?=
 =?utf-8?B?WE84b2VtUUNURHhHdDRYcmZXZ2ZzcVZ3MFA0a3dSU2hWaEhNQ04vS2c5Qjlu?=
 =?utf-8?B?ai9TRGtaN24zRFRqS1ZsNWsxS1ZKN0xhQ2VWMUpBVTJKYXZsbEZZeGZnYXln?=
 =?utf-8?B?N1EvYzlJMHpka3ptWHMzODJVZFlZcDVMVWxrckJpRnZobXZQL3RJZHBacHVP?=
 =?utf-8?B?bm1QQk52RlNKbitIRW5Udm8yOVp3K2R5aVJrVWNvYUlUdzJZallid21FMGFZ?=
 =?utf-8?B?WkJ0Q25CeWZ2TmZvT1V2T1E5dlI2dlVNODJRT3hPcHoxMkxwckZxOWlNYUh3?=
 =?utf-8?B?OGVabDFoa3E5M3BqekhEc1h5Mk1SWXo1NUc5K1pCOUh6V1h4QVFDWjhPNTBj?=
 =?utf-8?B?NkYvbEZXT3dZaFZRYmNEWElRQjFCWDZsVlJLUHNCWmQrazBUYkhRczdXTk55?=
 =?utf-8?B?dXgrNVY4WWJJbUdmR2hOaUIrKyszSTQvYS8zeTNObnZHQWFZUW9FREk4d2tY?=
 =?utf-8?B?UGtIaWN0amtYNkpDTElEa1Z6L1orTWxlRGxNQ0xCcEg1OFg5Ri9tNnkxaTJM?=
 =?utf-8?B?VDJaWFFsL0FKTnFEU01HYVF0ejNXbUw0SVY2WmVHaFgyREhoQnZ0a1lDYkpu?=
 =?utf-8?B?NlJGUVJCL0NqOFVpcVp2SmQzYmhVYUlWZ0lrYzkxSjdNUlY4R2JabWl3QU01?=
 =?utf-8?B?TWFMODF4aDVOK0ZzNmRRRHF5YkRkWGgzQ0QvVHZhMWZIQkF3SjE2YWFQV1dV?=
 =?utf-8?B?ZE82WUlNK1BUM0t6NmtJVDA5WThMSHcya0hXMVkremV4ZjVFUXZKRjExaWZ5?=
 =?utf-8?B?OFZmMFI0amhBWXhFMU1uUXZIc2MwOUlvTElDNWVWSHZZcHVxcjZBWUhYVjZJ?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 30eJsOlWFC4sRKr6B4lRVtg8axW88XvHtsg73N45U+sS3g8wvH+5ebbGHLAtrcr30eKSPjX6EblVu91zFLu8r2UTE3VMXUuzO1fxC7rlHtj6utt869vm3Fm9hUZeHFFRl34hZ6PCTAhVTTD0MtrUe+BxwQ4NQORhZZKD39aaXcUOBCpYVcKM60uwsDzibasrggN8dFa7HpUZxKm+QbmmL61mdyxSJNp+Tn1zac45HSMLgGl2NTSD6xB6UGfNqdED79IViymAGfXarQ0pw5HZwojthZa923VX/ddlskpnHiFUDuWBRR2Pd2nIUn8iLbhsDeTAgn3s9FNTwzBB0FXan3KO6JYbWblLMfomfsO6MnKMD9F8Xx1mB0bc8ZJuoiGvIgWl20Y+NYz4/SP1E82ThUqevERciQl7K1XteEyhgR8mggHz2VfROlT3joxCaYwbkGb2Ciq69DjfgWHxJulXGCfPxnx4rUuwEhgNQ5qL+TrHHKvyfDg5DIocKaeagJQMC3YZcJnkf82DvdIydm6CFwXAMDzKDSjlnkHo7z3HiP1geyN/LoeJN7sbFuEAql6El/u2iqPEboCeLrI7y+rqKKTfNDTd8nQ/SOvj0r0lAR34Q9ChAiM4wdctvGIdc0hz9nG9a2YO5JP+pc/GfhTpgAg2iytgyvFkHtwozlMP3rNCMP+fMX9bvIFQl3Rt0+BJGc/4Snr6LNeFhdRtRtcCKARZnNOzlxA40Ni42IxXSPRdXDp4mOm7EIfVqTAaXCR1bwPOn1IGAmr+YDavCTFzi8Wc9Y8eKwcdG7M+c6Hrb7HCOX+FyOqweC6Ft1ws/art0zO8TOowWcLvU9sScWYZKyqTL1bpKkVWSVbflswdRDQ=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb7edf1-fd94-4a90-d64a-08db24f41c89
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 01:25:07.2160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1SH2WBkLaQKSWInOjZ2ZRmocLuA5Xr9mS4fKdNkTxustnYHwVKNphiFGjJmc4irckGouyvIFoxx4mG9TQnxs6xzhsqpFifH0Qhqq7nzG2VI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7727
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgUGV0ZXIsDQoNCj4gU3ViamVjdDogW1BBVENIXSBzZWxmdGVzdHMvcmVzY3RybDogVXNlIGNv
cnJlY3QgZXhpdCBjb2RlIHdoZW4gdGVzdHMgZmFpbA0KPiANCj4gVXNlIGtzZnRfZmluaXNoZWQo
KSBhZnRlciBydW5uaW5nIHRlc3RzIHNvIHRoYXQgcmVzY3RybF90ZXN0cyBkb2Vzbid0IHJldHVy
biBleGl0DQo+IGNvZGUgMCB3aGVuIHRlc3RzIGZhaWwuDQo+IA0KPiBDb25zZXF1ZW50bHksIHJl
cG9ydCB0aGUgTUJBIGFuZCBNQk0gdGVzdHMgYXMgc2tpcHBlZCB3aGVuIHJ1bm5pbmcgb24NCj4g
bm9uLUludGVsIGhhcmR3YXJlLCBvdGhlcndpc2UgcmVzY3RybF90ZXN0cyB3aWxsIGV4aXQgd2l0
aCBhIGZhaWx1cmUgY29kZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBldGVyIE5ld21hbiA8cGV0
ZXJuZXdtYW5AZ29vZ2xlLmNvbT4NCj4gLS0tDQo+ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9y
ZXNjdHJsL3Jlc2N0cmxfdGVzdHMuYyB8IDEwICsrKysrLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9yZXNjdHJsX3Rlc3RzLmMNCj4gYi90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL3Jlc2N0cmxfdGVzdHMuYw0KPiBpbmRleCBkZjBkOGQ4
NTI2ZmMuLjY5ZWJiMGQ3ZmZmNiAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvcmVzY3RybC9yZXNjdHJsX3Rlc3RzLmMNCj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvcmVzY3RybC9yZXNjdHJsX3Rlc3RzLmMNCj4gQEAgLTc3LDcgKzc3LDcgQEAgc3RhdGljIHZv
aWQgcnVuX21ibV90ZXN0KGJvb2wgaGFzX2JlbiwgY2hhcg0KPiAqKmJlbmNobWFya19jbWQsIGlu
dCBzcGFuLA0KPiANCj4gIAlrc2Z0X3ByaW50X21zZygiU3RhcnRpbmcgTUJNIEJXIGNoYW5nZSAu
Li5cbiIpOw0KPiANCj4gLQlpZiAoIXZhbGlkYXRlX3Jlc2N0cmxfZmVhdHVyZV9yZXF1ZXN0KE1C
TV9TVFIpKSB7DQo+ICsJaWYgKCF2YWxpZGF0ZV9yZXNjdHJsX2ZlYXR1cmVfcmVxdWVzdChNQk1f
U1RSKSB8fCAoZ2V0X3ZlbmRvcigpICE9DQo+ICtBUkNIX0lOVEVMKSkgew0KPiAgCQlrc2Z0X3Rl
c3RfcmVzdWx0X3NraXAoIkhhcmR3YXJlIGRvZXMgbm90IHN1cHBvcnQgTUJNIG9yDQo+IE1CTSBp
cyBkaXNhYmxlZFxuIik7DQo+ICAJCXJldHVybjsNCj4gIAl9DQo+IEBAIC05OCw3ICs5OCw3IEBA
IHN0YXRpYyB2b2lkIHJ1bl9tYmFfdGVzdChib29sIGhhc19iZW4sIGNoYXINCj4gKipiZW5jaG1h
cmtfY21kLCBpbnQgc3BhbiwNCj4gDQo+ICAJa3NmdF9wcmludF9tc2coIlN0YXJ0aW5nIE1CQSBT
Y2hlbWF0YSBjaGFuZ2UgLi4uXG4iKTsNCj4gDQo+IC0JaWYgKCF2YWxpZGF0ZV9yZXNjdHJsX2Zl
YXR1cmVfcmVxdWVzdChNQkFfU1RSKSkgew0KPiArCWlmICghdmFsaWRhdGVfcmVzY3RybF9mZWF0
dXJlX3JlcXVlc3QoTUJBX1NUUikgfHwgKGdldF92ZW5kb3IoKSAhPQ0KPiArQVJDSF9JTlRFTCkp
IHsNCj4gIAkJa3NmdF90ZXN0X3Jlc3VsdF9za2lwKCJIYXJkd2FyZSBkb2VzIG5vdCBzdXBwb3J0
IE1CQSBvcg0KPiBNQkEgaXMgZGlzYWJsZWRcbiIpOw0KPiAgCQlyZXR1cm47DQo+ICAJfQ0KPiBA
QCAtMjU4LDEwICsyNTgsMTAgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KPiAN
Cj4gIAlrc2Z0X3NldF9wbGFuKHRlc3RzID8gOiA0KTsNCj4gDQo+IC0JaWYgKChnZXRfdmVuZG9y
KCkgPT0gQVJDSF9JTlRFTCkgJiYgbWJtX3Rlc3QpDQo+ICsJaWYgKG1ibV90ZXN0KQ0KPiAgCQly
dW5fbWJtX3Rlc3QoaGFzX2JlbiwgYmVuY2htYXJrX2NtZCwgc3BhbiwgY3B1X25vLA0KPiBid19y
ZXBvcnQpOw0KPiANCj4gLQlpZiAoKGdldF92ZW5kb3IoKSA9PSBBUkNIX0lOVEVMKSAmJiBtYmFf
dGVzdCkNCj4gKwlpZiAobWJhX3Rlc3QpDQo+ICAJCXJ1bl9tYmFfdGVzdChoYXNfYmVuLCBiZW5j
aG1hcmtfY21kLCBzcGFuLCBjcHVfbm8sDQo+IGJ3X3JlcG9ydCk7DQo+IA0KPiAgCWlmIChjbXRf
dGVzdCkNCj4gQEAgLTI3Miw1ICsyNzIsNSBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFy
Z3YpDQo+IA0KPiAgCXVtb3VudF9yZXNjdHJsZnMoKTsNCj4gDQo+IC0JcmV0dXJuIGtzZnRfZXhp
dF9wYXNzKCk7DQo+ICsJa3NmdF9maW5pc2hlZCgpOw0KPiAgfQ0KPiANCj4gYmFzZS1jb21taXQ6
IGM5YzMzOTVkNWUzZGNjNmRhZWU2NmM2OTA4MzU0ZDQ3YmY5OGNiMGMNCj4gLS0NCj4gMi40MC4w
LnJjMS4yODQuZzg4MjU0ZDUxYzUtZ29vZw0KDQpJIHRoaW5rIGl0IGlzIG5vIHByb2JsZW0uDQpS
ZXZpZXdlZC1ieTogU2hhb3BlbmcgVGFuIDx0YW4uc2hhb3BlbmdAZnVqaXRzdS5jb20+DQpUZXN0
ZWQtYnk6IFNoYW9wZW5nIFRhbiA8dGFuLnNoYW9wZW5nQGZ1aml0c3UuY29tPg0KDQpCZXN0IHJl
Z2FyZHMsDQpTaGFvcGVuZyBUQU4NCg==
