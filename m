Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAA67BEF9E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 02:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379215AbjJJARZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 20:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379198AbjJJARY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 20:17:24 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB49B4;
        Mon,  9 Oct 2023 17:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1696897043; x=1728433043;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c8fQEsdXWukNSghGxj1HIAxZo1T6gHh/mSVfd4yDUG4=;
  b=PBEHgwwJGuxCj+VMQKxwbcejovyfEEhrLK/GtT5a2EjYpl2HbMWTgCbK
   LMdlMvVUa8Jlb4TDZbdEhMKLJ/IW0ZOD0tRki2wGdExPZ/7yCzZb6zVBX
   PNcozsLkcsIgZMcMPH/M5kBvFazbRPF0eM9S9Ah/kQuVIUONUVR8+BaZH
   19O0l7UCFcdeDR90Ee7NUUmRwq0WwyaA3xAn8muMMP3kZKuWrdAkGk1oR
   qNxY89tUHsFamcU0pmfkhuyIxoVOstXDZVAXzjg6P5l8kMZM81Dg7wraa
   JgrpC2GKsioDSUnpv4z2vUXfI9PdxQ3ZCMTU6RugP1cZ04FYtEEz2lX2Q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="98455972"
X-IronPort-AV: E=Sophos;i="6.03,211,1694703600"; 
   d="scan'208";a="98455972"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 09:17:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEj37xS8mXfajqTEO6ibnXS6NcQvHE2SCCwNQxJqHPx3LFNzmemDxjEMODFktK+VcpFuPbjplHzuAmuaiu7LTEZbKpPG7QbYSZDwg068LJV/k0qU6E6+SHhym3Y7bU4r950Gft2EwR35Q6axUMi4FO8uzc3JJG2lMink9lKOG8LPhncxHGSzpsT/98aSfMFmgFY02v85NbnUgEwtaC7+n61g8qn7pJhjhGYceYeYXVa6Xvukb3wOd3FFJ6nTQa3wSULfK9IeQGHEkx8DieCAFbD3lpR8OLoJb/oTuBxNTTnPXUsGlGXUAJ8YS9eFlffo0MWJUucz1jWBPnvqahNzjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8fQEsdXWukNSghGxj1HIAxZo1T6gHh/mSVfd4yDUG4=;
 b=lOi22HemZgHUwbkobB/w1xffgxQDWa5EHzz5sZE1pnsnHF+PHUU24xH/mF5jtEoEVJiuYMFKVF+ggHDIJ+J8+ZxVBiIjMAyvRMTI5yQjtf2pRpjKFLwclxRbhJtUmizCVXVgxmCEigDpDUPD6oXcmANf4QdZQ3zpOaO1E2iAh4oglgZ9Sedwq3RFyWW5zSsTBVL4OegiixssVqScBPwxO5XbZHn1JuIoErXxqBCRUAIg32U/UXUq9sULtNHSVRyActfhJJNNll1dzh2oSLqnlq0mZSqGp4sYhfJUDZ6Z+//+9umrQKXbFrB5U0keznIgnYM2ThW19BCx9CB3ZPSMUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by OS3PR01MB8458.jpnprd01.prod.outlook.com (2603:1096:604:195::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 00:17:14 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::59bd:366a:131b:3f26]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::59bd:366a:131b:3f26%3]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 00:17:14 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     =?utf-8?B?J0lscG8gSsOkcnZpbmVuJw==?= 
        <ilpo.jarvinen@linux.intel.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        =?utf-8?B?TWFjaWVqIFdpZWN6w7NyLVJldG1hbg==?= 
        <maciej.wieczor-retman@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v4 0/7] selftests/resctrl: Fixes to failing tests
Thread-Topic: [PATCH v4 0/7] selftests/resctrl: Fixes to failing tests
Thread-Index: AQHZ9RWaUV/p/uLq5E6/rTB20IxCpbA61uWw
Date:   Tue, 10 Oct 2023 00:17:14 +0000
Message-ID: <TYAPR01MB63302A63FA8161243CE7E5E78BCDA@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20231002094813.6633-1-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20231002094813.6633-1-ilpo.jarvinen@linux.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9MzU4ZTdiMDYtMDNiYy00MmJmLThjMDEtZDhmOWUzNzg1?=
 =?utf-8?B?YmFmO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMy0xMC0wNVQwNzo0OTo1NVo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: d13dfe057fe54f1ea4a36822527dd4a2
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|OS3PR01MB8458:EE_
x-ms-office365-filtering-correlation-id: 27b98a05-0093-4d4c-d427-08dbc926412c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BIhKzOWaKUGNjo5oxraHXZCbGhbPgx8VZPOw27Dy+QR7LakMU+lGqH/AoyDw6sfgwFBl6pywC0Hko1z8xtNVzvdgZTeZ9CRgomIn6KWwh5joWtBmtD+HTd4Bc05sQ4WOd3JBJruQEgSKMk0FBZuva2V++ZSkJJv8nb13iUi4drlVZqhLPUlm7W8hc9Uz84uBFYq9J8wm2vdlM5BEp8+WYhxxcRiHkt1loFWL+LVeVLz+SADTZggDd2ZV6b4NvC9lqkjAFu13mrokOz04dsBuIXJrP3jiGAiSGKXaH9XpfexN+jprtUAWFNnPZQkOBK5UxE7BVcMQy2+kauM7J43BXZimJTyKoLGkKn2e3u03FYi0BVej+WkjVvcMGG5OdEDW7XzcyVudZ+n/wIu3tfIMOlzJOXf1tBSd/9zdOUMMHEtAtRN5lU7eLPvEg0GIF2Sz9i9OhJA5g2xmyZ/XcgNXYEEGfymijZtnc806a/buPoPCNZ7Z3Lbv5HGaRrRLgPcg5XE4/YLjwEUKzF6sTlruSz4LcXGEPYr6ep10PIOCS8Ej/0q9VQkasxo4JwINai1TybiDYi2wuX2Fm/0BEjiOc28EqK4+TKI+ZlDqaoKzIx8UMIilpG4qc8FgGJ7hzz9ffWAO3b55KEQCvZYy6HCn+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(1590799021)(1800799009)(186009)(558084003)(26005)(5660300002)(71200400001)(38070700005)(38100700002)(7696005)(1580799018)(55016003)(33656002)(6506007)(478600001)(82960400001)(8936002)(4326008)(8676002)(41300700001)(2906002)(52536014)(122000001)(85182001)(66446008)(66556008)(66476007)(66946007)(54906003)(76116006)(64756008)(86362001)(110136005)(9686003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWtIU1hvNlBYUW1SQkpnM0p5RlMwaHl4OUI4TVN5d1o1Y05PVTcxcjgxUk1t?=
 =?utf-8?B?bWNoNmIrViszYmE3bXlMbTdNaXpYS3VHTmU3VEFBeFNEa3VmdGpwcmdjUyta?=
 =?utf-8?B?MERKK25NYU9VTlNWVFh1eG1OdGxGU0dtY2Ira1FHSzlpRnZzV00xY0N2SFQw?=
 =?utf-8?B?UFpxNHo1Qi9wRk5YY3NobDA5clB5RGd2c2lMRUlhbGhxUjl2QmdyOXhhdktq?=
 =?utf-8?B?NGZJSGFTTXhkN21aeDdlbm94WW02b3FIRVJoVFA3TnpHcjBzZVBnVlVYd3RN?=
 =?utf-8?B?NllLczBJbHZFcmxmOUFWQXd0MExhU3R4cDZJdHJWZlF3M2g3KzI3eG4wZkh4?=
 =?utf-8?B?ZUQ5cVFtbFFHTi8xT0tZTEF4TDJWUmxSS05OZGNvV0RKMjVwRDlNWGl0ZkpD?=
 =?utf-8?B?NGd4SFRYVTViRFpUY1A5Rm12VlU5MFcvaFFWZEpVZWtDejl1d3dQbXlBbGFj?=
 =?utf-8?B?ZVdWZWNwVUtQUlFmbHhVV0ovdCtGYksyS09ESlVWUk84aGZ2ZVlsY3V0b29D?=
 =?utf-8?B?bXNxSEYvMUVUcWY5MzBHNXBjclhSNWpFdm5kV0toN1JzWE1HMjhPWXZFS2tX?=
 =?utf-8?B?Q0h5WTlaL1JmQ2EreFJ2RWxPcEpjZ3U5NW1DRFJkWkN1SitIaVdVeGkyM05Q?=
 =?utf-8?B?L2wwMU5Hek5oNGRZd3dINEprWXB6M0doVERuaExoWWduQVg5Nk1YdVhTUnNu?=
 =?utf-8?B?aDZFUWlOZ01QdVNIRnVTZWErd2lURWJYQW5PUDQ1TmdnbjY0bVJUWE5JRXVt?=
 =?utf-8?B?UDcxbDlaRFY5ZVg1K04vemhFYUpDelFBa3ZJVmhYcXJ1K29WdFIwejlFQ2N6?=
 =?utf-8?B?YVZoMk80N0NObkVleGtKd0tEek8rWEdLKzVQL0wxOG1LSmlvT2V2TkZ5Y2dY?=
 =?utf-8?B?eUFlK3FnRDhMWm82ZTVGV3VYQ0ZVTk9hTU1QdUJRVGJIOWNJaXI5VlpHdlpI?=
 =?utf-8?B?KzQ5d0JxYU9wMUplYi9BS25FdDFqZFNTL2dEaXIydmtvTTRMS294VURpVXBF?=
 =?utf-8?B?MXdIMjE4QmIydWZYcldacWtRam9KbTFPemlCR2ZKNHgrVGRJMXJ1bGVDd0Vu?=
 =?utf-8?B?QXdSYnBQUG9pOUlNb1RqT0xGY0ROVnB4OVEzWHVFZGRmb3JmeklXSWdIVFNn?=
 =?utf-8?B?S05hcDVJVkplOU9FQVVMZk4rQmw0cENKUTZCWm9VNjlmSUNKMi9kOC9EdkZt?=
 =?utf-8?B?Z1A4b3h2ZFpKUTdkKzVlai9EbHhKOVU5VDhVQ242UFc1algxN3pJdGpkTXly?=
 =?utf-8?B?dVE4RVdiQnhhVVhzOU1MSmV1aUozRmROa3EzVHFkWDE3QlpSS2Q0alRkRjl3?=
 =?utf-8?B?c0x6dXNvWTlFamJjZGV0bUdSTUt0enIzeWhicXZRS0N0VHBrMTV6Uk1jaDlK?=
 =?utf-8?B?L2ZXMk54MDVMU05Oc0hYM3VLbUxxWEhQQ3l2MUt0N24yWUhWb2FPRmpDTVl4?=
 =?utf-8?B?SHBwbWtFd0JPbktsMVgxV2Y2aGQvWjVpdXArZ3crRFNGYy8wd25qVDNSV0lQ?=
 =?utf-8?B?RUJ0OWtadUVxT1FSQXFHcGhyNC9ZMUViQk0rY1dORk90VVU5LzdxdGVCSDdK?=
 =?utf-8?B?UTJPbU5kazRZb0ZXSHI5S1p6emd0Rkd6TVppVzBsNWo1Q0JnSFlSRno0cEo2?=
 =?utf-8?B?YjhXYVp5R29TNWU4K1Fsb2NWTFFSZlowdnJ2dElheXdlcFIycGplQ0VOM2xj?=
 =?utf-8?B?eklSSlU2cjFmck5pWXA5RHBzdEthS0xZV09DMFFBRlJNa1h2WnRvQS91Y2sx?=
 =?utf-8?B?Y0MrOUpSdmxrSklpWWNCYm4wL2ZEd1F5MUtpSU40Y0d6MklmdUlXaEoyenlJ?=
 =?utf-8?B?dGFUT2ozcE1WNVl1RXFDMTlyOXNzSlZMUkVvNzVFSFR4YTEyY1JjQzhPamdm?=
 =?utf-8?B?WXY1UkQ1NzQ0L2hidzRmUDMvWW5VZlZLWHJVejBpQUxOdytIT2JGZnBMLzB2?=
 =?utf-8?B?andGNWRzVFRBeDNDOVVrOFNPa3ZzVmdWekdJdzcvcHJKUThmeTROZWc1T1Fj?=
 =?utf-8?B?M3FZZ1FoVzJvdXpTTGVDRURCZUNSZ3d4RUxvNXRmNXhwbzZibExPYWxDTTF2?=
 =?utf-8?B?L1RMU2FXWGRjWjRUZFVaVEdBYVdacXpvdzZobUUyWWx6azA0Vy9qQ2k2cXRl?=
 =?utf-8?B?VURJQ0phSm5sMGFzcGdTY0pNNTVZYmRqQmtuSVhqOTl6SDZXdEl0VitVM25n?=
 =?utf-8?B?cEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: e3Y8ruTdhGydDt1d5kGjzShS2FUIFMdbHWPQSd9ezmhblIVIVuQPyGOytAmmMeHd+8DqMrD2WO099w0nZfa/HMaPq2a24u3OiRRhlXDrjh3jHZIuV72J6RUw71b7ikqaad5acP2UK+t4XXjysLunGqF+FzqBW2t9/zq9ZlgTb8Q3BrgYk4M2iXKiBvzutu9cV+EuTuTPOjr6lKHEBAuYImE7wBbxBRz15GP5fEwtQaDu5mnNRA+lMYYo+D33nHKq04P6mlwAX6fdKufzXN/4T5Wbg5CWymqT3pbfpD1DZpblCrNUngwMB2TBArw7owP2+RW681f1yKBG3h16P1pdxGLf3G6ar02rxo5gnQ7RT36Aq4FyreqMVsNf7mA/w+h6cZpFEx0w5sxXwnFJOtrJnSTvG2N+evh+pU2+2L0EUY38gk6c7rV+/NLy3agGX7Odc7lUJ64KeEYVKBIeXwATlz1krMY/LS1W5hyKxZ99kF4AYX8AQ3kAjxL+uOBEdf7rMUrO+qAQ91zO0bkcJmBF0Nx2SFm4si3lJauIA+IHxVU4HZOJTs8IV0YMtPyP8DaEHVC6Q5G+qjZcffbZst2Zu3DsKPRJSlrgF4BIDrdW4wxU419fOMPTTJy/f8yEd1E/wb/1lVcB2mGC6VHhFmHY7pv9WpX4hW1LhzsoHXqJ2dqa64uX/ACgiWqLCFV5jdaJQbBIGMf7/1KDAMhaEPVd9WX45sB+naSujJv6b2yVjhZF/4XBOx8vivzf3JmBp6eV2VLSXv9SvtNpbGveEJ4MvvFBYSbnT6dI39/bYD1c4VpH6QU/YZQH9ktM+oaeMj3CCGQouGk2r8A6R/YFu3PJ6dOlYHAUBXKcKIDw5ig+ghMhrgmJjdc0eYi77OCjwgQG
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b98a05-0093-4d4c-d427-08dbc926412c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 00:17:14.2368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iK5UHtmMecvvKugQHiYLpSR9PbQjOuyFm7f8pfUBymoshgqTVqCyg3VNcJygCOvQm+D9zJyuUaMpy078g8QHQyXwlmE6Xvtvr50rT8spzR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8458
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgSWxwbywNCg0KSSByYW4gdGhlIHRlc3Qgc2V0IG9uIEludGVsKFIpIFhlb24oUikgR29sZCA2
MjU0IENQVS4NClRoZXJlIGlzIG5vIHByb2JsZW0uDQoNClJldmlld2VkLWJ5OiBTaGFvcGVuZyBU
YW4gPHRhbi5zaGFvcGVuZ0BqcC5mdWppdHN1LmNvbT4NClRlc3RlZC1ieTogU2hhb3BlbmcgVGFu
IDx0YW4uc2hhb3BlbmdAanAuZnVqaXRzdS5jb20+DQoNCkJlc3QgcmVnYXJkcywNClNoYW9wZW5n
IFRBTg0KDQoNCg==
