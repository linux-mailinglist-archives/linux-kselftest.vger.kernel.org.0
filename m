Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1287868E630
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Feb 2023 03:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjBHCoM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Feb 2023 21:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjBHCoI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Feb 2023 21:44:08 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Feb 2023 18:44:06 PST
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17ED65B2;
        Tue,  7 Feb 2023 18:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1675824246; x=1707360246;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6c0OaLHjyZRx8/DJ82dZz4Y9Mt1iuV/AfHGwopGUz4A=;
  b=YELXxXr03oAAHwNLJuU721ek5w038lPuTojGdwtC4WkeVHPp1tXSdFTM
   vnvA5oZciLkTigUIqXaxHEgZWSJlul1BJya9K0zEoI2XtOsUTmV0ah4Hw
   OmVtp0jD7amquP1+LDC8caOahIGUSZNuKHA/9wNBz+LzvOE+mYCE8Xk1B
   ZaKhDoqCZg7AnHmANff3YeLqHgBAMO+Lf1CaUk625r1adCEkl7dGAoTgf
   UcBGPcigr+ykErPDQPzLc5qKJmUnNyB0MQMbVFi/w663y/QRd1X7CnEbz
   MkqqJMRObY3MBfSE6wiu8L7oTdh9vrBjsYIX1AXWD7PQlJia0xRK4yqA3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="76668471"
X-IronPort-AV: E=Sophos;i="5.97,279,1669042800"; 
   d="scan'208";a="76668471"
Received: from mail-psaapc01lp2041.outbound.protection.outlook.com (HELO APC01-PSA-obe.outbound.protection.outlook.com) ([104.47.26.41])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 11:42:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtB7kLqryN2nBV+R8L7fsWA04fDPnAEcHv+vawtBu+ecGMtunnyC5tcfrQpi+5belQFBQH2BGnRes/EKdVZIrlRKgOYP483NeOeeMDDlVGRPWq52hi+Mf5I389TVkDV0KMN2dH81lzAX0//3gL819Rk0AyND5NzokdbomaJfuZhCcWkM6hK/MZq0rXq4Ibw2zXz7u7Gi/dC2sGGlYQIVm0qe0XLXWwaHYsfRycYUAeoaVCj4Q1ykn64hutrWzOYMk+2VpHdaxVTYeUFee4ccPdgYetX0ozho/Jx8NIrdrTws/qUevDWS2WbUmQbOzjGLuXYTQCK6jSP6Y5GNFcp80w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6c0OaLHjyZRx8/DJ82dZz4Y9Mt1iuV/AfHGwopGUz4A=;
 b=dapUXB60jjpbhQc3E9Zc9ol4i0yzVoZiMx6arew4hRHlQUum6n4jllLhKAqvV3ljjg4yTQKTHb+KtAUJnHnDeo4W2HNM9QbEbjwaCxgwNk7ykRkR9BSv4lGcmwfCrc0AMiEiCHBVJVago+5uRrIUskA88JOvN4wt88Na5q5sWTD7tulTQUI9uBZ98NcgHUObX7m2k5eq9MXkyoPQeL+PwqkRDxTyDM+del6JAW3Il5L/uT6pji4lsfAkZHPPaDBijP/rhttBMmK9Y6yPqkv3tQ2tWs/mgAVXkMujqbqB71aVWyOTg5Fz7kehNL4ing2Bl57wINwHliqYnVmFpvtMdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6328.jpnprd01.prod.outlook.com (2603:1096:604:e8::8)
 by OS3PR01MB10106.jpnprd01.prod.outlook.com (2603:1096:604:1e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Wed, 8 Feb
 2023 02:42:56 +0000
Received: from OSZPR01MB6328.jpnprd01.prod.outlook.com
 ([fe80::2c7c:9e83:3a3d:4038]) by OSZPR01MB6328.jpnprd01.prod.outlook.com
 ([fe80::2c7c:9e83:3a3d:4038%5]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 02:42:56 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     =?utf-8?B?J0lscG8gSsOkcnZpbmVuJw==?= 
        <ilpo.jarvinen@linux.intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v6 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
Thread-Topic: [PATCH v6 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
Thread-Index: AQHZNTfwUctSaAnC40SoDIvwW0nv4a7B1qIAgAEfUuCAAEIKgIABK2Ew
Date:   Wed, 8 Feb 2023 02:42:56 +0000
Message-ID: <OSZPR01MB63287E0DB7DEF1029305D7D98BD89@OSZPR01MB6328.jpnprd01.prod.outlook.com>
References: <20230131054655.396270-1-tan.shaopeng@jp.fujitsu.com>
 <20230131054655.396270-5-tan.shaopeng@jp.fujitsu.com>
 <a9ab65a6-f750-7fd9-99ba-1cbd15427d2c@linux.intel.com>
 <TYAPR01MB6330A24D0B7B52567453FF388BDB9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <406496b7-877b-d9e7-10e-d7b31da51add@linux.intel.com>
In-Reply-To: <406496b7-877b-d9e7-10e-d7b31da51add@linux.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjMtMDItMDhUMDI6NDE6?=
 =?utf-8?B?NTRaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD1mNzE0ZTBjMi1jMDQwLTRlM2Mt?=
 =?utf-8?B?YmQyNC02ODMyZjc4MTI2OTM7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: ad709ed3e5aa4c8ab629ce5c8b8f6af8
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6328:EE_|OS3PR01MB10106:EE_
x-ms-office365-filtering-correlation-id: b0461b79-4077-437c-61b8-08db097e2efe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y+716BXr8p49G0jToG10f41tUxOVbsU1XAQpJz+ECM+tmbcf8Ly1xl/gvJSzUCZ39im0WftXfPSfT5g3gOZZl+O7fz4RpwEso6ErgTrX/tb80PF1YRrA0GJBXwTzH0HZySYL4OqrSR1wZa5tJ4BU75VfcaamD2JumZ7e9XcQKlXv6aQuBm3wj0SOl8QF07Vpu/L0XytLr5INzQvKbyDL7hF0z3+z7bjUKbkvHRveOpJ++pHZ2KKIs6Cu/TA89n0z84rKXXAShOBVbTXFq6kJnOmgQBTPcsTlilnyutJDpK3N+RCC1pf/xKEFmrP1MeO22awKpi7pHklCRLE6hMlnONU5Gue5Y8ynhHTvIjx/CtOru0TDieaYVcqGRyqew8yBvIe88B4dPWnoDc2v6AHeDTpeyP0of+CagiBrr0hXonkKNW5CHo8p/LlSgkZKPWkdZ3KSJzz4axS2l8NxWSFm/UqUe/KMgZ5D9XQx3bXCPxLz3BVEsUdg9QjjXbTimpovFFTIDHahNh+pWivUtpefuQXkE+rAkIbfciwWu9po+YiOMlGvT1MWVozzS96OGiYD/vC/72+caGvQKNtjS8X0PICuTvpEjJA4OSZ1UTwKWcqN2N7ZH0oSsguQHEExsXLHQNdxUXiwe13NriObeXuzIRNHUFaa/es2CijyrsSS+8HhkaTowkxY+qEZPIv5+aLQYYyyYqoshymXJKpzVoGvKufpyOS6jDYNZ+/PIZYKJgU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6328.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(1590799015)(451199018)(54906003)(33656002)(316002)(55016003)(85182001)(71200400001)(7696005)(1580799012)(86362001)(6506007)(26005)(186003)(66476007)(9686003)(64756008)(4326008)(8676002)(66556008)(6916009)(5660300002)(2906002)(66446008)(478600001)(41300700001)(76116006)(38100700002)(8936002)(66946007)(38070700005)(52536014)(122000001)(82960400001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0hGRS92SEVsbzh1YkQ2TzFBQkdYWjNBLzJFd1VPUnVqYjFxRHVudy9oaDRw?=
 =?utf-8?B?WXpFbXQ2VHVaN0JxMTBEeDgwK3dXaWFsc0ZRa2ZrSXRkUXhYZXYxc3ZVNi9h?=
 =?utf-8?B?SktDdld3SEI4NW1BUzkxVXhwSnR3OEkzeGw2MGdDcXdyelJIeUlWMVBGd2RW?=
 =?utf-8?B?cEUrOGJna0pyRzVqTFJLaUpxZzdaYkthVXczNk5WOWJ3ZTVYZEVKZnRHOVlj?=
 =?utf-8?B?WkFFblhPTkRQb3JrYXg2bzFsTkxQZ3h4Njh3a2w0WUc5SW1DVmtJdmJpbVgx?=
 =?utf-8?B?b2h1Q0lRY2c4WlByMUwrUEJLYTAvbTArTVhpblcreTgwdG0yeXRKWHVIRjVJ?=
 =?utf-8?B?dDl3cUZuWllyZWpNYzFHT0xZNVJFa2hTbWQrdCt4c3RBd1h6a1pkeTlUTHRo?=
 =?utf-8?B?VXhmc2RvM1pBTWduRkJodGlsK3RhSlQ2aUM4QmU0by85cS9Sc053U2lNdEpQ?=
 =?utf-8?B?eloxYWw4MFBzMFl1eUxEL3VhdGlEbS8zUHFyT0lyZGtTcXJpOGxWcXBiLzBG?=
 =?utf-8?B?ckhRTUlDVmJSOWp6Q2crckdrV2E2MTMvc3NxU0VqcU1tNXR0dWx2ZlMxT0w0?=
 =?utf-8?B?ak5HalJCcWd5NEtJenE0VHBkRUpId1FIVWsxMk1nTXdIR2psSE93U2QranZU?=
 =?utf-8?B?UDhqVy95S2VrMmRuVkxkTHpEZktoKzZxVE02TkdZMmx6eXZiWnRKMFNOTjAz?=
 =?utf-8?B?YkdyWVlGT3Z6NTZ1bXlnL0FlWGlKdzZyR0dHMGFhQk9mSUlDT3lkQlk4V3hR?=
 =?utf-8?B?aTdyVlhROUVkWHBKaG8rRU1MTk8yWDdmUE9obkNVaWlhdUlKa1NWSExlY0JJ?=
 =?utf-8?B?U0pmaythbmxYdkdtMloyWjAvempveFFEck9uSzVnd0J6L0h4ZHNGQXVIendH?=
 =?utf-8?B?RmJjTG5COHErSEROanNoWFpmT2NsT0prU1JpMENka1E3U3o1MWNDWk04NnVn?=
 =?utf-8?B?Si9MVkZlcnNFRTErUWFpUU5OMDgyMmpaMFN2MmpFcTVmTXNBaWNHVEQyZWhh?=
 =?utf-8?B?TTMyVHNSS1NSZWZFaG00bkhwSkpYVVg0aVNHV1R0RkRqREZIS1pBeUgwK2cz?=
 =?utf-8?B?eUFmY2lqWjAwRGdpYUJpRTRTdEhlSG9RdHdPbTc1UHZIM2tYdFN3YkV1blRB?=
 =?utf-8?B?dUtPVFZ5UDlpQXJBWEh1QWNURHIzK1EyS1B5NlZ2MUl5Q2RsVlMvU3pGVG0x?=
 =?utf-8?B?V3ZJeWtFN1NSVDZqdEpLdnQwaUVrSVZYMkdqcE1FdnVNb1FWYmlCR3kwRWJH?=
 =?utf-8?B?eXZPbU5uL2NRM0pwYnJQT1Rjb21nR2M0NzYvYWczMVl6MEtiVmhXbkZ5RlQ1?=
 =?utf-8?B?b1FaTm1hVUJxSUg2bEh4V0tYVTA0NWptSkRwNFZOczNXVFdHZElyUHh4OHh4?=
 =?utf-8?B?MUJ0VmZOMFRUY1dZeUhCR0ExeTc2TmpkRWRVS3ZCNm02VS84ZmkxWkVSZEFM?=
 =?utf-8?B?WlVHeU8rNnNRVGdIMWVIdVJHSmFzUHRnVHhLTWVxYWkvT211ZVBKQVBEZ1lM?=
 =?utf-8?B?MlZsUjhZeHZPZXF1YXlWdlZyWkhkSnI1WEdtbTdWOU9yN1RSVUNxS3MrWlZH?=
 =?utf-8?B?QU5PSjRueHlWZVF0cjV3ZzNZcGNlWWhObGJuSVJZblVydXpmMlFlZlk2SWJT?=
 =?utf-8?B?NjlYS3FBYnR5WUFXUjMza3FKd1ViWlJIUHR6ek8zZjhMZTdpYTErRDBLekVD?=
 =?utf-8?B?bTIvKzFsM3lYREZpaERZUTA5Q1lhUUJQSlB1ak9VNnNObmRaeDUxTjlKUU5P?=
 =?utf-8?B?WisrVUdpY2pLUHhUTHFjekt1amkxK3czeUx5Q0xnTkJGV3B2QnFSS3AreDc5?=
 =?utf-8?B?ZWliNzdQQytWNVhNcjJ3amwzL01MZERjMjRLR0xIdHNmcFVPSFVHVzVJdCs0?=
 =?utf-8?B?akJVZGRhY3dQbURqd0pjemxpcC9uT1FuWWlQVmc4c0pjT1FXOVBvVlQxaUgy?=
 =?utf-8?B?K0xSdlc1WUxqWkFhWHdKRTFCTW1DZTY5dG9Db2tHVzlwelpGaVl0RTRrZjhx?=
 =?utf-8?B?Mjg2WWJqWDNGSzU0djR1eHhtQWF2UzYzR3pmQ0FNYXIrYkIxeTRncGhCem9v?=
 =?utf-8?B?NWtUeUZ5OWlIcjhia0pDb1pHekJ3cFo1UFBpUEo2V1dEUTUrdWFRQ2hiZUdE?=
 =?utf-8?B?c0tPRXNZWERnbDZEbkVHUDE2TWZpY0g4Tng0WFhzRVJJZ29aYk13ckVMdmRZ?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gA+GRsr5f0njbIsIcVxoyiUGksmO2p/nG5xs/4XgYye6mIEh5sic5CKFSShWaMI+A5i7erMEALwgbOmZ387EEiKP1yh2xJ/xpRVdGgT+br8Q1B8yeUGnF5KSSElMCbsiqPS1CodzNXv+0C4ujmlsrdx3/lOfOYSDuKI8YEOvMwCI14PKXLQxq9PbdZZo1g6rwRye774ckWMOC3QCHNesQLM68dGRUlmUFHCvWA+uatDBDnIKatZWtL11fwxO8Iyf741TUyGYdBx3LwTyF7X/J3Yh+Yj6RZnQuYnCZktbGt53ZQhrkLiMHuJvPEjgDvsZUj5241lMv0jjTuTu2KcMazq0/Z66abWnAMC7rMD3J6aRPSML3bzlr5JSEuLn7bE6fc+FGveiZqODYenGSP8ofAYoqlRL8yg+2b/NCJdeaJFDLdZjDkwcdODG4QLtjirNlqkCe9UxnwwN9g/WfxrNAk0TbtVNUOiQI1lyd64BJTjdfcFCwlo65AVprGfNHKYu+aXHssePW8kfiCgF6NJNlMDXQ8tx2S6EwsdVDK6jN5bAJVAqsyXqgtXGOcxxDT4TBYHgDuhZbM43iZrZ27oTmy2ReCZaKAnSu68mqY2dOlkt3GpjwMM/2iPAwczj1DXDFSj7LQ3aJyGghQjRptYLmnt9HNweuF7wJNcgg/Sx+1sA5CFqFosMKUXK3kWWH9++uTj1oWmXzVAc4e9ynJaa4YaAr9S/WEtR9S751TDXji+2wq/acdWGcD6cWrlb5j028EHv6BuDnJ3pduCZA2rJA/rYiAdfMiXmAAX/AACC1gl7u1LJZ2KYXZQMgDuGkBELD1+cNYm+NHI5FBVKCJTGDugxwP+8zWdPcw2ptIfVMnaXkl9Nye6wk80J1YcAxA7W
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6328.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0461b79-4077-437c-61b8-08db097e2efe
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 02:42:56.1540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xrdf7K2BGTU3fIcusa4LI/vc9PPnP0WWi5AVdfOXd+gIetrsatBRBltucjxWinrVUlLhr84EAudmaDn2Y4deg5itOnx6+RGfnCp9uadAlUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10106
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgSWxwbywNCg0KPiBPbiBUdWUsIDcgRmViIDIwMjMsIFNoYW9wZW5nIFRhbiAoRnVqaXRzdSkg
d3JvdGU6DQo+IA0KPiA+ID4gT24gVHVlLCAzMSBKYW4gMjAyMywgU2hhb3BlbmcgVGFuIHdyb3Rl
Og0KPiA+ID4NCj4gPiA+ID4gQWZ0ZXIgY3JlYXRpbmcgYSBjaGlsZCBwcm9jZXNzIHdpdGggZm9y
aygpIGluIENBVCB0ZXN0LCBpZiBhbg0KPiA+ID4gPiBlcnJvciBvY2N1cnMgb3IgYSBzaWduYWwg
c3VjaCBhcyBTSUdJTlQgaXMgcmVjZWl2ZWQsIHRoZSBwYXJlbnQNCj4gPiA+ID4gcHJvY2VzcyB3
aWxsIGJlIHRlcm1pbmF0ZWQgaW1tZWRpYXRlbHksIGFuZCB0aGVyZWZvciB0aGUgY2hpbGQNCj4g
PiA+ID4gcHJvY2VzcyB3aWxsIG5vdCBiZSBraWxsZWQgYW5kIGFsc28gcmVzY3RybGZzIGlzIG5v
dCB1bm1vdW50ZWQuDQo+ID4gPiA+DQo+ID4gPiA+IFRoZXJlIGlzIGEgc2lnbmFsIGhhbmRsZXIg
cmVnaXN0ZXJlZCBpbiBDTVQvTUJNL01CQSB0ZXN0cywgd2hpY2gNCj4gPiA+ID4ga2lsbHMgY2hp
bGQgcHJvY2VzcywgdW5tb3VudCByZXNjdHJsZnMsIGNsZWFudXBzIHJlc3VsdCBmaWxlcywNCj4g
PiA+ID4gZXRjLiwgaWYgYSBzaWduYWwgc3VjaCBhcyBTSUdJTlQgaXMgcmVjZWl2ZWQuDQo+ID4g
PiA+DQo+ID4gPiA+IENvbW1vbml6ZSB0aGUgc2lnbmFsIGhhbmRsZXIgcmVnaXN0ZXJlZCBmb3Ig
Q01UL01CTS9NQkEgdGVzdHMgYW5kDQo+ID4gPiA+IHJldXNlIGl0IGluIENBVCB0b28uDQo+ID4g
PiA+DQo+ID4gPiA+IFRvIHJldXNlIHRoZSBzaWduYWwgaGFuZGxlciwgbWFrZSB0aGUgY2hpbGQg
cHJvY2VzcyBpbiBDQVQgd2FpdCB0bw0KPiA+ID4gPiBiZSBraWxsZWQgYnkgcGFyZW50IHByb2Nl
c3MgaW4gYW55IGNhc2UgKGFuIGVycm9yIG9jY3VycmVkIG9yIGENCj4gPiA+ID4gc2lnbmFsIHdh
cyByZWNlaXZlZCksIGFuZCB3aGVuIGtpbGxpbmcgY2hpbGQgcHJvY2VzcyB1c2UgZ2xvYmFsDQo+
ID4gPiA+IGJtX3BpZCBpbnN0ZWFkIG9mIGxvY2FsIGJtX3BpZC4NCj4gPiA+ID4NCj4gPiA+ID4g
QWxzbywgc2luY2UgdGhlIE1CQS9NQkEvQ01UL0NBVCBhcmUgcnVuIGluIG9yZGVyLCB1bnJlZ2lz
dGVyIHRoZQ0KPiA+ID4gPiBzaWduYWwgaGFuZGxlciBhdCB0aGUgZW5kIG9mIGVhY2ggdGVzdCBz
byB0aGF0IHRoZSBzaWduYWwgaGFuZGxlcg0KPiA+ID4gPiBjYW5ub3QgYmUgaW5oZXJpdGVkIGJ5
IG90aGVyIHRlc3RzLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFvcGVuZyBU
YW4gPHRhbi5zaGFvcGVuZ0BqcC5mdWppdHN1LmNvbT4NCj4gPiA+ID4gLS0tDQo+IA0KPiA+ID4g
PiAgCXJldCA9IGNhdF92YWwoJnBhcmFtKTsNCj4gPiA+ID4gLQlpZiAocmV0KQ0KPiA+ID4gPiAt
CQlyZXR1cm4gcmV0Ow0KPiA+ID4gPiAtDQo+ID4gPiA+IC0JcmV0ID0gY2hlY2tfcmVzdWx0cygm
cGFyYW0pOw0KPiA+ID4gPiAtCWlmIChyZXQpDQo+ID4gPiA+IC0JCXJldHVybiByZXQ7DQo+ID4g
PiA+ICsJaWYgKHJldCA9PSAwKQ0KPiA+ID4gPiArCQlyZXQgPSBjaGVja19yZXN1bHRzKCZwYXJh
bSk7DQo+ID4gPg0KPiA+ID4gSXQgd291bGQgYmUgdGFrZSB0aGlzIHByb2dyYW0gZmxvdyBmaXgg
b3V0IG9mIHRoZSBzaWduYWwgaGFuZGxlcg0KPiA+ID4gY2hhbmdlIGludG8gYSBzZXBhcmF0ZSBj
aGFuZ2UuDQo+ID4NCj4gPiBEbyB5b3UgbWVhbiB0aGlzIGZpeCBzaG91bGQgYmUgc2VwYXJhdGVk
IGludG8gdHdvIHBhdGNoZXM/DQo+IA0KPiBZZXMuDQo+IA0KPiBDdXJyZW50bHksIEkgc2VlIHlv
dXIgcGF0Y2ggZG9pbmcgKG1haW5seSkgdHdvIHRoaW5nczoNCj4gMSkgY2xlYW5pbmcgdXAgdGhl
IG1lc3N5IHNpZ25hbCBoYW5kbGVyIGxvZ2ljDQo+IDIpIGZpeGluZyB0aGUgZWFybHkgcmV0dXJu
IGluIGNhc2Ugb2YgZXJyb3IgZnJvbSBjYXRfdmFsKCkgb3INCj4gICAgY2hlY2tfcmVzdWx0cygp
DQo+IA0KPiBCb3RoIGFyZSBnb29kIGNoYW5nZXMgYW5kIGJvdGggYXJlIG5lZWRlZCB0byBmdWxs
eSBmaXggdGhpbmdzLiBCdXQgKElNSE8pDQo+IHRob3NlIGFyZSBpbmRlcGVkZW50IGVub3VnaCB0
aGF0IGl0IHdvdWxkIHdhcnJhbnQgdG8gc3BsaXQgdGhpcyBjaGFuZ2UgaW50byB0d28uDQoNClRo
YW5rcyBmb3IgeW91ciBhZHZpY2UsIEkgd2lsbCBzcGxpdCBpdCBpbiBuZXh0IHZlcnNpb24NCg0K
DQpCZXN0IHJlZ2FyZHMsDQpTaGFvcGVuZyBUQU4NCg==
