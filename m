Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A500719318
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 08:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjFAGVI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 02:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjFAGVH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 02:21:07 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8FDE2;
        Wed, 31 May 2023 23:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1685600465; x=1717136465;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AeViwsl2+ZJslcBcWE0g58FYdInnghJzFCU08cHpK8Q=;
  b=x82PRL8F3lmbC3cSmDs14QmFSj5q48Z174687rn8ouUVreF2X78cxeS1
   PPy86iMdUuRnXHYwNzya1IWqfb3aDtrAwDDR+Jb/v5cUlLDIbgG1rAe+z
   Gt4gfsNpVG32n/BbshMld1pIZi5KJXQhsTqy0hs94QlCBqgXzXEKe2gxb
   +vSLkoACJF+DkcdH/g+rwCOnIYo0Aconm0CITrYFdWKpLx+FrcbljAnvb
   hIMsojlOzp1lPAUOubmWDslADr9+8qZoc6VqgZVY62hRbkr91UYqkV84Q
   80gGl7QmSQaWjicT316sYzNOE6di4O85oE4kv/FRaD9jSFrsmeaobxybA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="86037242"
X-IronPort-AV: E=Sophos;i="6.00,209,1681138800"; 
   d="scan'208";a="86037242"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 15:21:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cR+vFV73xqNnHepIWqVbfGgV7YcqCitu3jBNss5Yoj2qZbuIlpeNs2nJdLy4glNlPSyScVDPIAsA5f6cIrCiaEaJk+1CJYKWL7kFMvCcQfdDn2NQfp+EuMe4cEvKZ+KIkrueozPtJRqmdM8Zt0z+t+xVyfhHA+VqLTHpTiMZZa0j/RUTSLOtqcneE4VJl7p3Zm5nzq7RuyCrLuvwg2FA1X9WeeMytRxcxUKun+NQwJJSD/NNNUYnMSSb+vy6jDbGjOmhP72ByV63uh5ISrI5xWBpkJby9+qHqGJMleLRlzDgzVBGsmDmOoNu7XgbfASEVG73TpYnaUMRzaVybEz/GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeViwsl2+ZJslcBcWE0g58FYdInnghJzFCU08cHpK8Q=;
 b=F/s7huBPDJZPcR9JPuKUjaIm8G8aKjWjDuOy8UqZkx0EQ+jpaBzBX0ZW8J06fFgW1JL9IXQ1KgD4BYnJr8YMDa7JSZIMd5cRhLLTWnjpoVkdbbvpIpzyo+SNHZeL880wYMqxswSLvXOkeA47aVd2IBKBI4SrZ/+fi7dBZonOC+iXlgNBZaj80iuE0He0B3PZW6519RGlNyf3DfqKegvW7kHh8xKNZaeLF7GJUSzXV9n67KXs7C85NA29LDSoqnm1pPwWcVqcbq/xuISFk21Lazia7+pT9X7YB7dAU83sF2Kch3xCpfQ0vzKAImBB5VhTTFltZsuPyiutH2Jsgsra8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYVPR01MB11339.jpnprd01.prod.outlook.com (2603:1096:400:366::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 06:20:58 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::cc02:64af:18c2:cd83]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::cc02:64af:18c2:cd83%7]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 06:20:58 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     =?utf-8?B?J0lscG8gSsOkcnZpbmVuJw==?= 
        <ilpo.jarvinen@linux.intel.com>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 17/24] selftests/resctrl: Replace count_bits with
 count_consecutive_bits()
Thread-Topic: [PATCH v2 17/24] selftests/resctrl: Replace count_bits with
 count_consecutive_bits()
Thread-Index: AQHZcetoQ9KLBje7YkSjdkQUGLMNp690PX8QgAAlQwCAAVtXIA==
Date:   Thu, 1 Jun 2023 06:20:58 +0000
Message-ID: <TYAPR01MB633001D05B8FB31BE3B390798B499@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
 <20230418114506.46788-18-ilpo.jarvinen@linux.intel.com>
 <OSZPR01MB6328A57213FA4E13C21F91D18B489@OSZPR01MB6328.jpnprd01.prod.outlook.com>
 <9043c594-68c2-b73e-2bad-c2506f206259@linux.intel.com>
In-Reply-To: <9043c594-68c2-b73e-2bad-c2506f206259@linux.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjMtMDYtMDFUMDY6MTk6?=
 =?utf-8?B?MDZaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD0yYjM0MzdiMy1mNDA5LTQyNTUt?=
 =?utf-8?B?YTEwMi02NWEyODE3MTdlYzQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 9988563078ef4e01bea73c4961f9b9bb
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TYVPR01MB11339:EE_
x-ms-office365-filtering-correlation-id: 24133656-86c5-4a4e-e81e-08db62685d49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Er3EP4bvcoQNmc1Z3MCyA9ut4cMpcVqjgpGsRHF9vTP9jex/iwI+97FirEsbpT65WlGFEhyl9cdjQghOuhL6QgOeqZJIUzxvuhBovjUFPF72meZaeZhbV3JtyJP4KKQzwGHzgH+G8yUgHl2hF2/Iumu7zfjelS2OneQobxUcDu3iN7YoOTYwrJl/b3DSl+ByVm1ptVUDfZDZF41EVnIeOYbgmTVyUVRusbdy2bpvGMjkzuL81cB/h19E3ut1UBjZs/3Pyv6jvYHSXWUSvXix7WUPt/b2vOi3bdADAef39VegDeaOMuWuvFXg1HjSvVDIQZDSL5t0lqAQclKUIfoiTdcl2HWxYjlrdKLg5Z8yFHH7C2Rx6PM8v1Fk5+wOSaUed+zDaDzJHYkHSAbzNgKp92pfGiCxmPMPlUHhWNTCCSqXQtb+ZI2djQ6cDA4tk2/FEi9NmS5pOdiSqHA4BXLdFECzCyfxdbMhuxXdHD1D9i/A+wXHVjavBdfie0rW818tDsqGybmzXSTbLZK8XpNxtFJa5n5yL9RaxA75I771izj5CWR6iT9l+Ec4f1quIVYvFFJTAlTCeB6yIwYyjaprsxYAi88y8+XAGy+XCXNUbuXkn3UCJ0yy1BehFFzPeIaLlpv4ZhbqEoHqbzcF1gwMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(1590799018)(451199021)(4326008)(76116006)(66556008)(64756008)(66946007)(66446008)(66476007)(6916009)(8676002)(52536014)(41300700001)(316002)(54906003)(1580799015)(8936002)(2906002)(5660300002)(71200400001)(7696005)(478600001)(55016003)(85182001)(6506007)(26005)(9686003)(186003)(33656002)(122000001)(82960400001)(38070700005)(86362001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWROZzY4YnRTNkJrc090SWswZHpkUmRpSGt4QkFLNDJ5dmttdTFyeGhNNU5Q?=
 =?utf-8?B?alhNMGsrcmJ1YWhGMFNWcGl2cklqdlA1SXpqQS8xZFl6WHdHOVFmM3NhZ1ho?=
 =?utf-8?B?MitrWnQvZ21nUjZjbEIva2M3cFNDamozeVNubmtXZjhkbnJvZlNQVHVUVGI1?=
 =?utf-8?B?M2Zkd3ZQR01ySXN0VUp5cmhvVTQzOStNK3RheUFSTTRpbE9nSi92QTMyTlZH?=
 =?utf-8?B?TlNVeGxKeUdFK1h2UDJlbTJ2ZkU3a0FONk5EZ0h5b3JUenpNVlNpSkQzVita?=
 =?utf-8?B?d0NjdSsrSGVRT2VCV1JDWjJLTkR5eUVqakYyRUZTT3FJajJ0L2E2aHVON3Iv?=
 =?utf-8?B?STNHNkRJZ3Y1YzVINkFFM2NHUjZqQml6WXErbWw4ZWtzUWtKbE9hdUVOMTVm?=
 =?utf-8?B?cmtBYVR5VERxYitLOVBneHVBTFE3UXh6SFFZbzJSaTNnNmlIbTB0OExaZEhG?=
 =?utf-8?B?bElVN3B0RzFrMFp3M3BEYzljclhQV0JkUkxZSjJpUm1TN1JXK3hMajhpTUw0?=
 =?utf-8?B?WEdyMlYxL0V6VnRZa3l5TTFVY08vdkEvMytDajBKcCsrTGt1OWhqckNDRmE5?=
 =?utf-8?B?Z0diUDJrWEtMUTM2S2dZOGU1QVFFelpLbldiY0RHUXc4U0xVaGFmWFN4aEVS?=
 =?utf-8?B?by9mS3VYSVZWZHZkTTRzOVJ5OUkzOWtFSHYwK1lTU1hWZWVGOVBVaUZpb3lG?=
 =?utf-8?B?NUtPR2hrOW1wc2lHa2t6L3NQUTh3ZjNFc0M4Nms4aUhxMkMwNkJoREthbHRC?=
 =?utf-8?B?d3VzUVhZUjdwVkRoZVArSDB1L0RHZHVUSnZpeWJ3aVRWREx1QjdEK3huT25v?=
 =?utf-8?B?K2J1VkM1a3ltdHpYdU5mNU1BVmwrZi9jR2F1Q3hRY3B1SDd4aW9TbHlXZWl4?=
 =?utf-8?B?alJ5SE9WVllUQTNsbEV4SXlVWGkvUXBSZGthdDFJOUd3YlJ2ajNsQUZWMW9w?=
 =?utf-8?B?T0xNdXNtU3p2d2FvRUFXMEkxOCt2WUVWNHJkYkhDeU5tTS8vbXY5akFSTk5W?=
 =?utf-8?B?YkJtSWRUZVJoRU5uaGc2clNtR1k3VlM3Y3NHcy9vMkM2czlpNkkwS3Jrd0FY?=
 =?utf-8?B?WGl4NExSbWVtY2F2RktLcHhsQjBGTVAyS1pqU0ZudVo4Y3hUUmFyai84V05T?=
 =?utf-8?B?WktEYTFJaEsrVFduaGMvU3UvV1hGNkxzNEVzQTk5ZXNOdkl6NDZ1NFk3Q3lU?=
 =?utf-8?B?QmR3ZEt2SE9rQWJScUZGTmo3bUpYWlgyVzJpVWdqQW5yVlI0STJSdXAwV2tv?=
 =?utf-8?B?NE1BVWpnS1RSUjF4NXluZ0xydXUrVEdTTGNyOEV4YlpnMmpUaFlERCtwYWpz?=
 =?utf-8?B?M0hvNzI0dWJPYVkvN3R3by85eG1tcm9ZYW9PR0RMWndRbzdUR2JVRzV0dVVO?=
 =?utf-8?B?TGxCVmtXZXZvaFhzT01jdElMQVUrVmZPbHdtQmhVV2RJRk50UWM4YXJ5UTRH?=
 =?utf-8?B?dXVxR2V1Y0xzUTlMVGtHbVgvbWhFSklzb0VqeXFZczZwdnZTWFBJTG9sQ1JS?=
 =?utf-8?B?amhxSDh2SE9JY0ExeTVEMlI5ZVNKSFFsaE1kaGVHL0ptK3JzQ09Vc08zTGhR?=
 =?utf-8?B?Z01STlhueWtxRTFYSkxvcEVvZFpZRFc5VVRPMmw5dzhuZlJPeDQ4cGpPUUsv?=
 =?utf-8?B?emwrcnlsNGlVVGV1RXhSNUZETlkvYmRnV3RhYU5GVkVEU01USURUTkVNSURx?=
 =?utf-8?B?dGZYaGE0VUhZd3RMYmlVZWtSd3dKRzJqQmFvOTlPVTlzdjQ0Tkd0aERJY3dp?=
 =?utf-8?B?L243VFM3bDJpdmZ6UFRKbytZRjRjTVhxWUJLN0huemFqYS9qZThYanRiMmRK?=
 =?utf-8?B?S21oTVVodFA5TGdXZ21IcVlQWEpTY1Y5cGRJNkVCa1EyMUMyWlBDa3BHQnds?=
 =?utf-8?B?YnlYMU03TWxKZGk4OW9IRmtmODdHU3JhajFhZXZVL1pSdm1YSkR3b1V4Y1du?=
 =?utf-8?B?bWVxS1c1WXRKbERJUW4rK0laaVNlNnBWVmIvelVoazA5U0ZhdWlRTmVHUHdV?=
 =?utf-8?B?N3lFVkZYTVBmQnVZWjVERFhkL0I0d2lwNEpNN3BwMFdNd1FBeGRiNGVwK0ZX?=
 =?utf-8?B?OFlNYmNJdWIvRXNzbUxHdVlHdyt3WFNGNmdOcXN5eFhGMlJ4VzFnQ0NiclFU?=
 =?utf-8?B?VUgrQ0ZnQWtJYnF5TCszdGROdytmUEV6dmR2OFdUMHd2ZDRJY1orK3dMTjdj?=
 =?utf-8?B?Y1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6GnnsvgK1/2K8ywU05vrYfKW40oGI5oET7M7VFKtZcMpK6mbZhNsFKY5sxI9TrcmlEtkdr12dzTj2Q4KPW7/AHA5QloxLBAnwcjVFpoZEMrd68eLQRbK7/idQFag1S6Jv1eEV1btTcY7lRWUjMjwASZYS+MGTo55mnD85VYU65fZtW1IxJ9+9Aanj8FZuZIJ8YUkhLaO0xvjpZ1KmI+mrqLD6wSbpNiEtnQPlNjRB12tw//pYzyjy69RwYEQhrUZiR27t8nqI0g2sbO1Re0hOEH2mpKJtSsPCZ88tJWDJb0bPwMue+/eVXxD8k0JAYryDFRo5FiU4DtcxN5xBtv+ibBSVCDk3mu7ZKEMNg25Aowq6QFgQc9BXl6TkwQ/m8kFYAnkMOZa7ZblAbOTPfiVFoxY/r+jC7jtOg3WOxwt85JXDGM3h378vePukWGMoHHibRnDH1vXZfTqvZ3YhR7U+AK7e2I3fYKm//HEvsWVBYCg6JXCYehpWeamNNVGb0HdJX8LlrlpawC5iQUBAKNLcnYC7GA7ahXLI3G4Y6vDCDKgeB4ka64vlobNYDAGOOW+oy/BNXzRmLdT8nxz0LijA0fGYAPlod9codxoupsCrPHAZl4R9RJnsZDUJIOHOGUDCbX94VeXfzvPxYqupw5trG/jOlzlX4MgyjZdnfG5rSATaR78jv0d3WhGqFQ61RzvbhYAfP0dDarJ6nw44AQ5M9BMpb9wpFhPGzCqK3NAZ2ITGA19KwMVtO8bqt3uJQk4xlAyX/kbrDsFGwCll8kZjaEndXwf6FTDrWUBUsktvFvUxxY/L2P9qZxRhcUfMYXKhys4hQM7g79QKjS/bO3sewgGf6/CR/A+xgbIPhoOaw+RRIT0N9Js6RDeqVe7WgtN
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24133656-86c5-4a4e-e81e-08db62685d49
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 06:20:58.3718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ns+30JW6I4OKFyVYiSV31lm+w89RR0doOYbkSRD1yZ62jt0Mh51gtbx8dYFYm+Dsrj5CI3ZBdSYb7qlKTBttAowK1W7xwSuVzghE63Jscaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11339
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgSWxwbywNCg0KPiBPbiBXZWQsIDMxIE1heSAyMDIzLCBTaGFvcGVuZyBUYW4gKEZ1aml0c3Up
IHdyb3RlOg0KPiANCj4gPiBIaSBJbHBvLA0KPiA+DQo+ID4gPiBDQVQgYW5kIENNVCB0ZXN0cyBk
ZXBlbmRzIG9uIG1hc2tzIGJlaW5nIGNvbnRpbnVvdXMuDQo+ID4gPg0KPiA+ID4gUmVwbGFjZSBj
b3VudF9iaXRzIHdpdGggbW9yZSBhcHByb3ByaWF0ZSB2YXJpYW50IHRoYXQgY291bnRzIGNvbnNl
Y3V0aXZlDQo+IGJpdHMuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogSWxwbyBKw6Rydmlu
ZW4gPGlscG8uamFydmluZW5AbGludXguaW50ZWwuY29tPg0KPiA+ID4gLS0tDQo+IA0KPiA+ID4g
QEAgLTIxOCw2ICsyMjAsMzQgQEAgc3RhdGljIGludCBnZXRfYml0X21hc2soY2hhciAqZmlsZW5h
bWUsDQo+ID4gPiB1bnNpZ25lZCBsb25nDQo+ID4gPiAqbWFzaykNCj4gPiA+ICAJcmV0dXJuIDA7
DQo+ID4gPiAgfQ0KPiA+ID4NCj4gPiA+ICsvKg0KPiA+ID4gKyAqIGNvdW50X2NvbnNlY3V0aXZl
X2JpdHMgLSBSZXR1cm5zIHRoZSBsb25nZXN0IHRyYWluIG9mIGJpdHMgaW4gYSBiaXQgbWFzaw0K
PiA+ID4gKyAqIEB2YWwJCUEgYml0IG1hc2sNCj4gPiA+ICsgKiBAc3RhcnQJVGhlIGxvY2F0aW9u
IG9mIHRoZSBsZWFzdC1zaWduaWZpY2FudCBiaXQgb2YgdGhlIGxvbmdlc3QgdHJhaW4NCj4gPiA+
ICsgKg0KPiA+ID4gKyAqIFJldHVybjoJVGhlIGxlbmd0aCBvZiB0aGUgY29uc2VjdXRpdmUgYml0
cyBpbiB0aGUgbG9uZ2VzdCB0cmFpbiBvZiBiaXRzDQo+ID4gPiArICovDQo+ID4gPiArdW5zaWdu
ZWQgaW50IGNvdW50X2NvbnNlY3V0aXZlX2JpdHModW5zaWduZWQgbG9uZyB2YWwsIHVuc2lnbmVk
IGludA0KPiA+ID4gKypzdGFydCkgew0KPiA+ID4gKwl1bnNpZ25lZCBsb25nIGxhc3RfdmFsOw0K
PiA+ID4gKwlpbnQgY291bnQgPSAwOw0KPiA+ID4gKw0KPiA+ID4gKwl3aGlsZSAodmFsKSB7DQo+
ID4gPiArCQlsYXN0X3ZhbCA9IHZhbDsNCj4gPiA+ICsJCXZhbCAmPSAodmFsID4+IDEpOw0KPiA+
ID4gKwkJY291bnQrKzsNCj4gPiA+ICsJfQ0KPiA+DQo+ID4gVGhlcmUgbWF5IG5vdCBiZSBhIGNh
c2UgdGhhdCB0aGUgbW9zdC1zaWduaWZpY2FudCBiaXQgaXMgMSBhdCBwcmVzZW50LA0KPiA+IGJ1
dCBpZiB0aGlzIGNhc2UgZXhpc3RzLCBpdCBjYW5ub3QgY291bnQgY29ycmVjdGx5Lg0KPiANCj4g
Q2FuIHlvdSBwbGVhc2UgcmVwaHJhc2Ugd2hhdCBpcyB5b3VyIGNvbmNlcm4gaGVyZSBwbGVhc2U/
DQo+IA0KPiBJIHRlc3QgMFUsIDFVLCB+MFUsIGFuZCBhIGZldyBtb3JlIGNvbXBsZXggY29tYmlu
YXRpb25zIG9mIGJpdHMsIGFuZCBhbGwNCj4gcmV0dXJuZWQgY29ycmVjdCBjb3VudCBzbyBJIG1p
Z2h0IG5vdCBoYXZlIHVuZGVyc3Rvb2Qgd2hhdCBjYXNlIHlvdSBtZWFudA0KPiB3aXRoIHlvdXIg
ZGVzY3JpcHRpb24uDQo+IA0KPiBUaGlzIGZ1bmN0aW9uIGRvZXMgbm90IGNvdW50IG5vciBjYWxj
dWxhdGUgdGhlIG1vc3Qtc2lnbmlmaWNhbnQgYml0IGluIGFueQ0KPiBwaGFzZSBidXQgdGhlIGxv
bmdlc3QgdHJhaW4gb2YgYml0cyB1c2luZyB0aGUgY291bnQgdmFyaWFibGUgKGFuZCB0aGUNCj4g
bGVhc3Qtc2lnbmlmaWNhbnQgYml0IG9mIHRoZSBsb25nZXN0IHRyYWluIGluIHRoZSBjb2RlIHRo
YXQgaXMgbm90IGluY2x1ZGVkIGludG8gdGhpcw0KPiBwYXJ0aWFsIHNuaXBwZXQpLg0KDQpUaGFu
a3MgZm9yIHlvdXIgZXhwbGFuYXRpb24uDQpJJ20gc29ycnksIGl0IHdhcyBteSBtaXN0YWtlLg0K
Tm8gcHJvYmxlbSBoZXJlLg0KDQpCZXN0IHJlZ2FyZHMNClNoYW9wZW5nIFRBTg0K
