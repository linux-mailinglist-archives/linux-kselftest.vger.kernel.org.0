Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39702717823
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 May 2023 09:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbjEaH1M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 May 2023 03:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbjEaH1K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 May 2023 03:27:10 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 May 2023 00:26:53 PDT
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E124718C
        for <linux-kselftest@vger.kernel.org>; Wed, 31 May 2023 00:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1685518014; x=1717054014;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=A6FBsV8aqKuKQ2kb/8Jk5ynBkDD0R9C/iGUWpCoFPvs=;
  b=ck/sm7Yd79pmjFV1lE7xerA3cqlSKzBxo1jBKkihKn8ygAhBu9M+PYP4
   h7YRoegJQvfUKxTLLczkU1svKDQCp5IFlCkspBZcRNcBzyStSE7bNlSjl
   TbQ7peWea8r4ZeiuyisTwm2eM+WW/OV9rWpdHNhVjcUgrYUl77EEPGZdZ
   JnDFPxTcamJMgfufjHEG1MGtYnNYXo+n1AFOW1hSc+M2e7SthTU/KcDpt
   7WQUukYv8cAodyoApVpOnVFtjNJ/7kbrJTaYYje6tS5K9B597XJ2geg8B
   HOdeiihQ7SIJYOnSfvJJ9Q6nDTPIB2mqbmGDc70quVk9vhc2Zrgjs3i7b
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="85733173"
X-IronPort-AV: E=Sophos;i="6.00,205,1681138800"; 
   d="scan'208";a="85733173"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 16:25:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGlneKNti7BmTlvtYgKyy+htkFDF6gb6dF+ZQjqcp/bjsBCJih5NQmkkdJ29S+lzllxZFYkb0ndsUSTPK+TzZes9w7ZaG6XaT2WUMglJJ6/TR1yr6yEgInAU9Kc0TqvwHDYe9Hf7tYUiDuXDs//yNLG0a1O5zglf1xWOMOd3J6+7b+hHYxyJxRdRmptorHM7LYasyH84aibBblYJDFOet+vh+QzEIvcjZu3G1Ijn5anb+WtXbjBqOdUmAxSI+N7nN1TNSb96r7gvw7NZDfhaSTvNcO3XSzY7xdb3wviVf6AdX1Br0HWyxn4qtI0xKim0vYmMVu1ARNxAOGh6H0Ix6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6FBsV8aqKuKQ2kb/8Jk5ynBkDD0R9C/iGUWpCoFPvs=;
 b=V/TKY6VT69TrpF/53ZdJQOn4i2lq1esdhfx951VgtUL94sv7QAmC5QAuu9QR+e2/jJhJ6RmzI4W3nVUtizgrZ/Urr5i31t80lpWKzVaiA4FEkCrLjf5wwiyWLmOvM7pgXuliJQ48MQYn2fPAhuOcDY2ZNnjm1W1OuZQVi/LkPQAMKlybWkaKGf3NYsTI+3LIv0us7EFiV4FyCmBquVThTrULRFdsvIw1V2s0scE2H6lSkKn48MXPbIODNRavQOiZKZfsI10hh8dn8BU1EN+yLKx8QompjKIv6bYWEfdHjOKmdfRE98QYlp/a9oN8RVZq2WLcImLAAv3YQpd/C9NiEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6328.jpnprd01.prod.outlook.com (2603:1096:604:e8::8)
 by OS3PR01MB5896.jpnprd01.prod.outlook.com (2603:1096:604:c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 07:25:42 +0000
Received: from OSZPR01MB6328.jpnprd01.prod.outlook.com
 ([fe80::cc8b:a287:185b:3ea9]) by OSZPR01MB6328.jpnprd01.prod.outlook.com
 ([fe80::cc8b:a287:185b:3ea9%4]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 07:25:42 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     =?utf-8?B?J0lscG8gSsOkcnZpbmVuJw==?= 
        <ilpo.jarvinen@linux.intel.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 17/24] selftests/resctrl: Replace count_bits with
 count_consecutive_bits()
Thread-Topic: [PATCH v2 17/24] selftests/resctrl: Replace count_bits with
 count_consecutive_bits()
Thread-Index: AQHZcetoQ9KLBje7YkSjdkQUGLMNp690PX8Q
Date:   Wed, 31 May 2023 07:25:42 +0000
Message-ID: <OSZPR01MB6328A57213FA4E13C21F91D18B489@OSZPR01MB6328.jpnprd01.prod.outlook.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
 <20230418114506.46788-18-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20230418114506.46788-18-ilpo.jarvinen@linux.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjMtMDUtMzFUMDc6MjI6?=
 =?utf-8?B?MzRaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD0zNTMzMWMwMC04Zjg4LTRmMDUt?=
 =?utf-8?B?YmRmMS1hNGYyNTBlMzA2YjM7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 725ae82196e045c9a95b260dc70642fc
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6328:EE_|OS3PR01MB5896:EE_
x-ms-office365-filtering-correlation-id: 20fda3f6-acaa-4e8f-806b-08db61a83e27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6MGmO9IkborFX6LlNq7jXHO1AvcLYOCXrlAUlsPyIQwqsomx4NWfYRJVu6RMnG2kd0uv0N/YsnF+B0HIciJVFd5YZVNMKFWPSx4JSC+4HrxK/4BylPYhZ07iAO220wrir+qLSQKmmYl/cLDGPODm/vMIxxKTxWjFNEmzSRqcFH2yq47v8xRA/py8RBG6+NmsQiUPpPy2IxnzhGrdQMH49iwDwVpri/nkZYjkxPBZxBNAZBsKBWdyLNKoyZ/ZQ4vk7v51qFGVAPxGgNkLKRep5i7Ih/s6s+muQrYq/wzzeRnQRGge5Q+4cCnPZSYnKKwDeOcfuTKnjhZYXeh4aQeoB+adPupGXEzKOGismHRToKIV4kD2yyUjq6QOWruk5KmmqX0apeQA6s70BUe357mFEl6eeK+pAlxxGkA9C1n1RxsuwBEldMm+1xYVqqQjxszIIJ5zbj584ULhJ96HONN/QD9pf/eTu1FHCpn9zet2DfWJCkXWYLsMmHw2EhG35LPVC6l9xwyTQtVOAu24PY19QUf/EqTOS8jPmjxkk70ueSzLwqIhpH9UT//IG4nP00gOJFL9uL65LoYU93AVWVvAE8X2Li/KmlrLCUfspn8r5vO0G3Mhk8mwjyqYqUt+gu2M7VNnpw2mfGHghHKg3pZA0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6328.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(1590799018)(451199021)(83380400001)(41300700001)(38100700002)(71200400001)(6506007)(186003)(7696005)(26005)(9686003)(478600001)(110136005)(1580799015)(66476007)(82960400001)(66946007)(66556008)(64756008)(66446008)(122000001)(76116006)(55016003)(316002)(52536014)(5660300002)(8936002)(8676002)(33656002)(2906002)(38070700005)(85182001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjhjTkpFYk9aSnJ2UC9Yd2V5R3FBKzlQTUJqVzNEMVdxNzdTYVo0WldqeGRK?=
 =?utf-8?B?WnZ2ZkZuWEtjQ0N1dlp0ZzNmRlA2OFJyVGIzQkRuNGNlbGRqTGhMN1VBaEFJ?=
 =?utf-8?B?L1Q4ckJ5R2pjMlMzL0RSM2RiYWNicFpob2lLWjV6MU1pYXRXakJTNWREakJO?=
 =?utf-8?B?V1JidUlhbGVSUDdhajdCUjVuQkhPcXp0bGlVZytCS1VLSzFRbHh0ajNmMFB6?=
 =?utf-8?B?N3Q4QkhSYjh4cHp4NG9wY0xwZUFHVldqMTZVbFFBL1lBbUFHc3dRQjg5YlV4?=
 =?utf-8?B?RG04SUpWd1g0aE13dFdZd3RVZ2NZUHoyb1VxMnl0SGlBdEdTR0N3RFdsZzlN?=
 =?utf-8?B?UlhIQzZ3U3lmTWdScVdsVWFPMWtrdzhEb0MrM0VWbVBKaWlYN3RBd3hxdTFN?=
 =?utf-8?B?cnA2ck5tdmZ1QjIwNSsvYmdWSFZOK3F2WFRkUnhBM09IejFUMmNQajM3NHJY?=
 =?utf-8?B?T1lNOWNqbmJuQ1IwUWZrY044OWlVZ1p3TFlrWTRKdlFMajFIRXVUdVNVemVh?=
 =?utf-8?B?SGFJUUZLUERwcmgvVUFvMDRvVGhqZWE1VDE0M0Nub3piKzlkSDFNUzV3K2RM?=
 =?utf-8?B?WERJSXgrOG96TFVuNE8vSU40Wm00dmZqZ2dlRGhOQkhFa2ZabkZJV00rdGt2?=
 =?utf-8?B?NzQ3VzJhUVlHVTBXRHlMQzE3QnFheXpmeldMN3AzUUVGOENxSXc2TWlHeGVt?=
 =?utf-8?B?Z2l1TDNodlJXWWZKaXhQU2k1bGd4QUkwRi91bmJvYUYyL3FndWpMclZvcmIx?=
 =?utf-8?B?cVdnb0JXRzdOaTZiOTZUUGh4QktmTWNFVjZwbDBvNVNyUTBOWVhVZ2JnajEy?=
 =?utf-8?B?YndzNzZmRVRXdm9qck9sRGhRYWd3aWRPVm9YcUN3emIwSElrWkJhYURUVlpK?=
 =?utf-8?B?TktpUkFUWjNVYjcrSjluSVIwcXVaYTJNSXh1ZzFDRkxtay91dDRWdjY0R2R1?=
 =?utf-8?B?dWpNYzI1U2w4NFF2dS91eUk2MVVVYXlldFl6ck1uZzROZVd3ZEdGSE0yOGdX?=
 =?utf-8?B?b2FWQXVHRm1YVEQwMXU4Nm1LWk5qZGY2anQzR0hLSWVCbFJzWkVlbWRzV1Nx?=
 =?utf-8?B?YURhMzJXOHlocWpncGtsWmI2Q3pGYmlwSStaUnFVQzljS1pEYnpEYkJydm5L?=
 =?utf-8?B?NXZYQ0tFalRRVWNmNmtXOGZSQXhyMHhqallqSTlVZlZXTXNpWG1aNmhqWE9S?=
 =?utf-8?B?QTUzMWZ2cDRqR2pGdjlrdm1qTVE3cVlxTmEzQ0tVVTZKeWY1dGo0OGliZFd5?=
 =?utf-8?B?K0dKT3NlVWF0TzR2WHd2d3l2dTRQWXNRSENyMk5qTlFuSG8wc2lPbG5PRmg0?=
 =?utf-8?B?TzZaZDNvN2E3NzhzOVRWRU9XR3pYbXJHcEE5Rld0Z3k3U0hyNG9HZFVhNkhh?=
 =?utf-8?B?UWV6ZlE2RWlic010c1VFM2lqZFlyb2IxUVpYWU5pbEVVNVNBL3E3K2swbi9I?=
 =?utf-8?B?MFdER3AzVGczelNINFdENWlKZi9MZmduVUFkSjM1ODNWRFVvUmZFckRYa29o?=
 =?utf-8?B?M01oNjNPU0dvdVp6V1ByMnNyL3NwNWtWdW84Q3ZkaVpIVmdiTVk0OHJGYWx1?=
 =?utf-8?B?dmhkU2FnbithYUlVZ0oyUTQzUXFVOG9tUEdIMTBzOEx6SjJSdDhHeXRCSnUw?=
 =?utf-8?B?STRBZ3Jxc01Cb080Z2ZYNHNoZ1l1YmE0ZXlvTmNlZnNSc3NpUVY2TWRPV1lu?=
 =?utf-8?B?cWNyandJRmVJbDJwZ0VxZmFJUHRXaXpoQ0ZLR0owWDZmVlpvRGtuTGp3emZ2?=
 =?utf-8?B?cDI3U3cydktDMGF6NVFJYlVPWjNQNTBBZlNSZU9kK3F6Y3c2WS91Zkp1OHRD?=
 =?utf-8?B?QjJzaVpPdWxPaFdNTWFFVHlUMUZ2UzdPRmQyNFN4d0IwSDRwOHUwTHF1STdx?=
 =?utf-8?B?QnhIL1VJK0RuQXBaWVNsT0VveFVLS0E0QkljQ3ZCZFR4QjZ4YXV6VFI5aW1v?=
 =?utf-8?B?WmNXZ3lvbnZoakRnK1VDdDNkS01ySm8wOHNvaGRnc0hSdXYzb2t5UEZMYVUy?=
 =?utf-8?B?QitsbHJYNlNXUVJpMHA0THY2TXZseHN0MzFMZGZwTklSYTcwSHkramdHNjVo?=
 =?utf-8?B?QzczanNVQUh6VTBIL3pJV0xEaUdZRVNBYVk4OHROSERzVkNBdUNsQkFUUml4?=
 =?utf-8?B?WmluR3ByclErbUJBOWNZMThWSWpOaWE0dE5wL2NCanZPY2J5SWNPejduVWVl?=
 =?utf-8?B?cnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4gJO+pPpanxpNLGnnbZVkrx6281j1gPZupAquBypz1vbiHAeb3c6GB06bw2kLwM1PfkN1EHqTRrd4iOOfx3OcxnfkYosARDwcO+QQyMy37os/jyGsnFMQwCL/hUUimncr9lB/QKyHCDuHtk6nbeooMIA9lz1Hk2JrC/f2k5tjNTpBoSeB9sttUh1GjZiYyfQ1nUiNJuyA7M4wFlXoI1nwrsai1e0qw2AgGArbNlDcGSq85FOqY7P1VWpftn+CDfc6GC0jFciHLaKKY4D/djntQyvYy3FkyaPAOP1NaEnQXtHXSwq+LnfXWBbeAKE4kIg+LoBLXsWNAvapAU+kIUBUtxu1/yP950f4vE8H3TNf8c4bg/LbgWs3gB95OH0PCSrN5AjbPY+/sz1Cs75sGxX7+4TMuvbnDJQaGaT/Pceb9ZAlKr958HMBu/6L5j+zAsCEPnx/nC7J5uTjfReiBq8S/d6yU/6c8eK71UWv556Xw4MOPJAAjQX7ItAmI1BMoWS2g5oONWRcIdzYBGtIu9k+XYiCKK+7aNzuKHfQvGlayqrCaUF10VwRGR+Pc1P2uc2ZTRNivvTRJcwVA3uOzPx3j09QXIRlojHxlJpn1ENF4SEfmus2lps5/gTSomB4FVNSlrJVBXMcuKqVkkwglrhMKqLEZ9KxRo9Apq3cq2m61GfEsfe2Z8xi8CYHOaAh9WSCQzh8t990AMVYwG0boXV7Ci2KzaYc+5I5TwGM1bFxFP/bQ1OCHFk0apZVlA3f8QNgQhsaVoTj8mUNAc20yPDtG72jYluuqqToUrmmwisapNft6WVS9c10u8rkAact8dQQbEWJ649MWQ3VREzXQVi/YdWs2OL5JUPk8hITHkhVlor95StkZs0xGtiYhck6wxN
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6328.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fda3f6-acaa-4e8f-806b-08db61a83e27
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 07:25:42.8231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rWxey3t9xW2yHkN6VGQyAmmwm3iiFKLTpZU/gNQiSZJMdYrB032WjQc6sWojITBeZCA4FzoPESe0O+u24jYq0/aNjQlLZlMoTBztS4CPcHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5896
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgSWxwbywNCg0KPiBDQVQgYW5kIENNVCB0ZXN0cyBkZXBlbmRzIG9uIG1hc2tzIGJlaW5nIGNv
bnRpbnVvdXMuDQo+IA0KPiBSZXBsYWNlIGNvdW50X2JpdHMgd2l0aCBtb3JlIGFwcHJvcHJpYXRl
IHZhcmlhbnQgdGhhdCBjb3VudHMgY29uc2VjdXRpdmUgYml0cy4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IElscG8gSsOkcnZpbmVuIDxpbHBvLmphcnZpbmVuQGxpbnV4LmludGVsLmNvbT4NCj4gLS0t
DQo+ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL2NhdF90ZXN0LmMgIHwgIDYgKyst
LS0NCj4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9jbXRfdGVzdC5jICB8ICAzICst
LQ0KPiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9yZXNjdHJsLmggICB8ICAxICsN
Cj4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvcmVzY3RybGZzLmMgfCAzMA0KPiAr
KysrKysrKysrKysrKysrKysrKysNCj4gIDQgZmlsZXMgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygr
KSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9yZXNjdHJsL2NhdF90ZXN0LmMNCj4gYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNj
dHJsL2NhdF90ZXN0LmMNCj4gaW5kZXggZDNmYmQ0ZGU5ZjhhLi5hMTgzNGRkNWFkOWEgMTAwNjQ0
DQo+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvY2F0X3Rlc3QuYw0KPiAr
KysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL2NhdF90ZXN0LmMNCj4gQEAgLTc4
LDcgKzc4LDcgQEAgc3RhdGljIGludCBjaGVja19yZXN1bHRzKHN0cnVjdCByZXNjdHJsX3ZhbF9w
YXJhbSAqcGFyYW0pDQo+ICAJfQ0KPiANCj4gIAlmY2xvc2UoZnApOw0KPiAtCW5vX29mX2JpdHMg
PSBjb3VudF9iaXRzKHBhcmFtLT5tYXNrKTsNCj4gKwlub19vZl9iaXRzID0gY291bnRfY29uc2Vj
dXRpdmVfYml0cyhwYXJhbS0+bWFzaywgTlVMTCk7DQo+IA0KPiAgCXJldHVybiBzaG93X2NhY2hl
X2luZm8oc3VtX2xsY19wZXJmX21pc3MsIG5vX29mX2JpdHMsDQo+IHBhcmFtLT5zcGFuIC8gNjQs
DQo+ICAJCQkgICAgICAgTUFYX0RJRkYsIE1BWF9ESUZGX1BFUkNFTlQsDQo+IE5VTV9PRl9SVU5T
LCBAQCAtMTAzLDYgKzEwMyw3IEBAIGludCBjYXRfcGVyZl9taXNzX3ZhbChpbnQgY3B1X25vLCBp
bnQNCj4gbiwgY2hhciAqY2FjaGVfdHlwZSkNCj4gIAlyZXQgPSBnZXRfY2JtX21hc2soY2FjaGVf
dHlwZSwgJmxvbmdfbWFzayk7DQo+ICAJaWYgKHJldCkNCj4gIAkJcmV0dXJuIHJldDsNCj4gKwlj
b3VudF9vZl9iaXRzID0gY291bnRfY29uc2VjdXRpdmVfYml0cyhsb25nX21hc2ssIE5VTEwpOw0K
PiANCj4gIAkvKiBHZXQgTDMvTDIgY2FjaGUgc2l6ZSAqLw0KPiAgCXJldCA9IGdldF9jYWNoZV9z
aXplKGNwdV9ubywgY2FjaGVfdHlwZSwgJmNhY2hlX3NpemUpOyBAQCAtMTEwLDkNCj4gKzExMSw2
IEBAIGludCBjYXRfcGVyZl9taXNzX3ZhbChpbnQgY3B1X25vLCBpbnQgbiwgY2hhciAqY2FjaGVf
dHlwZSkNCj4gIAkJcmV0dXJuIHJldDsNCj4gIAlrc2Z0X3ByaW50X21zZygiQ2FjaGUgc2l6ZSA6
JWx1XG4iLCBjYWNoZV9zaXplKTsNCj4gDQo+IC0JLyogR2V0IG1heCBudW1iZXIgb2YgYml0cyBm
cm9tIGRlZmF1bHQtY2FibSBtYXNrICovDQo+IC0JY291bnRfb2ZfYml0cyA9IGNvdW50X2JpdHMo
bG9uZ19tYXNrKTsNCj4gLQ0KPiAgCWlmICghbikNCj4gIAkJbiA9IGNvdW50X29mX2JpdHMgLyAy
Ow0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvY210
X3Rlc3QuYw0KPiBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvY210X3Rlc3QuYw0K
PiBpbmRleCBlZmU3N2UwZjFkNGMuLjk4ZTdkM2FjY2Q3MyAxMDA2NDQNCj4gLS0tIGEvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9jbXRfdGVzdC5jDQo+ICsrKyBiL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL3Jlc2N0cmwvY210X3Rlc3QuYw0KPiBAQCAtODQsMTQgKzg0LDEzIEBAIGlu
dCBjbXRfcmVzY3RybF92YWwoaW50IGNwdV9ubywgaW50IG4sIGNoYXINCj4gKipiZW5jaG1hcmtf
Y21kKQ0KPiAgCXJldCA9IGdldF9jYm1fbWFzaygiTDMiLCAmbG9uZ19tYXNrKTsNCj4gIAlpZiAo
cmV0KQ0KPiAgCQlyZXR1cm4gcmV0Ow0KPiArCWNvdW50X29mX2JpdHMgPSBjb3VudF9jb25zZWN1
dGl2ZV9iaXRzKGxvbmdfbWFzaywgTlVMTCk7DQo+IA0KPiAgCXJldCA9IGdldF9jYWNoZV9zaXpl
KGNwdV9ubywgIkwzIiwgJmNhY2hlX3NpemUpOw0KPiAgCWlmIChyZXQpDQo+ICAJCXJldHVybiBy
ZXQ7DQo+ICAJa3NmdF9wcmludF9tc2coIkNhY2hlIHNpemUgOiVsdVxuIiwgY2FjaGVfc2l6ZSk7
DQo+IA0KPiAtCWNvdW50X29mX2JpdHMgPSBjb3VudF9iaXRzKGxvbmdfbWFzayk7DQo+IC0NCj4g
IAlpZiAobiA8IDEgfHwgbiA+IGNvdW50X29mX2JpdHMpIHsNCj4gIAkJa3NmdF9wcmludF9tc2co
IkludmFsaWQgaW5wdXQgdmFsdWUgZm9yIG51bWJyX29mX2JpdHMgbiFcbiIpOw0KPiAgCQlrc2Z0
X3ByaW50X21zZygiUGxlYXNlIGVudGVyIHZhbHVlIGluIHJhbmdlIDEgdG8gJWRcbiIsDQo+IGNv
dW50X29mX2JpdHMpOyBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3Ry
bC9yZXNjdHJsLmgNCj4gYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL3Jlc2N0cmwu
aA0KPiBpbmRleCA2NTQyNWQ5MjY4NGUuLmFhNWRjOGI5NWEwNiAxMDA2NDQNCj4gLS0tIGEvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9yZXNjdHJsLmgNCj4gKysrIGIvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvcmVzY3RybC9yZXNjdHJsLmgNCj4gQEAgLTEwNiw2ICsxMDYsNyBAQCB2
b2lkIHRlc3RzX2NsZWFudXAodm9pZCk7ICB2b2lkDQo+IG1ibV90ZXN0X2NsZWFudXAodm9pZCk7
ICBpbnQgbWJhX3NjaGVtYXRhX2NoYW5nZShpbnQgY3B1X25vLCBjaGFyDQo+ICpid19yZXBvcnQs
IGNoYXIgKipiZW5jaG1hcmtfY21kKTsgIHZvaWQgbWJhX3Rlc3RfY2xlYW51cCh2b2lkKTsNCj4g
K3Vuc2lnbmVkIGludCBjb3VudF9jb25zZWN1dGl2ZV9iaXRzKHVuc2lnbmVkIGxvbmcgdmFsLCB1
bnNpZ25lZCBpbnQNCj4gKypzdGFydCk7DQo+ICBpbnQgZ2V0X2NibV9tYXNrKGNoYXIgKmNhY2hl
X3R5cGUsIHVuc2lnbmVkIGxvbmcgKm1hc2spOyAgaW50DQo+IGdldF9jYWNoZV9zaXplKGludCBj
cHVfbm8sIGNoYXIgKmNhY2hlX3R5cGUsIHVuc2lnbmVkIGxvbmcgKmNhY2hlX3NpemUpOw0KPiBp
bnQgY2FjaGVfYWxsb2Nfc2l6ZShpbnQgY3B1X25vLCBjaGFyICpjYWNoZV90eXBlLCB1bnNpZ25l
ZCBsb25nIGFsbG9jX21hc2ssDQo+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9yZXNjdHJsL3Jlc2N0cmxmcy5jDQo+IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3Ry
bC9yZXNjdHJsZnMuYw0KPiBpbmRleCBmMDFlY2ZhNjQwNjMuLjRlZmFmNjljODE1MiAxMDA2NDQN
Cj4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcmVzY3RybC9yZXNjdHJsZnMuYw0KPiAr
KysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJsL3Jlc2N0cmxmcy5jDQo+IEBAIC0x
MCw2ICsxMCw4IEBADQo+ICAgKi8NCj4gICNpbmNsdWRlICJyZXNjdHJsLmgiDQo+IA0KPiArI2lu
Y2x1ZGUgPHN0cmluZ3MuaD4NCj4gKw0KPiAgc3RhdGljIGludCBmaW5kX3Jlc2N0cmxfbW91bnQo
Y2hhciAqYnVmZmVyKSAgew0KPiAgCUZJTEUgKm1vdW50czsNCj4gQEAgLTIxOCw2ICsyMjAsMzQg
QEAgc3RhdGljIGludCBnZXRfYml0X21hc2soY2hhciAqZmlsZW5hbWUsIHVuc2lnbmVkIGxvbmcN
Cj4gKm1hc2spDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+IA0KPiArLyoNCj4gKyAqIGNvdW50X2Nv
bnNlY3V0aXZlX2JpdHMgLSBSZXR1cm5zIHRoZSBsb25nZXN0IHRyYWluIG9mIGJpdHMgaW4gYSBi
aXQgbWFzaw0KPiArICogQHZhbAkJQSBiaXQgbWFzaw0KPiArICogQHN0YXJ0CVRoZSBsb2NhdGlv
biBvZiB0aGUgbGVhc3Qtc2lnbmlmaWNhbnQgYml0IG9mIHRoZSBsb25nZXN0IHRyYWluDQo+ICsg
Kg0KPiArICogUmV0dXJuOglUaGUgbGVuZ3RoIG9mIHRoZSBjb25zZWN1dGl2ZSBiaXRzIGluIHRo
ZSBsb25nZXN0IHRyYWluIG9mIGJpdHMNCj4gKyAqLw0KPiArdW5zaWduZWQgaW50IGNvdW50X2Nv
bnNlY3V0aXZlX2JpdHModW5zaWduZWQgbG9uZyB2YWwsIHVuc2lnbmVkIGludA0KPiArKnN0YXJ0
KSB7DQo+ICsJdW5zaWduZWQgbG9uZyBsYXN0X3ZhbDsNCj4gKwlpbnQgY291bnQgPSAwOw0KPiAr
DQo+ICsJd2hpbGUgKHZhbCkgew0KPiArCQlsYXN0X3ZhbCA9IHZhbDsNCj4gKwkJdmFsICY9ICh2
YWwgPj4gMSk7DQo+ICsJCWNvdW50Kys7DQo+ICsJfQ0KDQpUaGVyZSBtYXkgbm90IGJlIGEgY2Fz
ZSB0aGF0IHRoZSBtb3N0LXNpZ25pZmljYW50IGJpdCBpcyAxIGF0IHByZXNlbnQsIA0KYnV0IGlm
IHRoaXMgY2FzZSBleGlzdHMsIGl0IGNhbm5vdCBjb3VudCBjb3JyZWN0bHkuDQoNCkJlc3QgcmVn
YXJkcywNClNoYW9wZW5nIFRBTg0K
