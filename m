Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2114E7B15E6
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 10:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjI1ITV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 04:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjI1ITT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 04:19:19 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Sep 2023 01:19:17 PDT
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE67D98;
        Thu, 28 Sep 2023 01:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1695889158; x=1727425158;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0Abt06A5VOFvLNKiV7yEgFJOCqfgvT82NMMR3huRj1o=;
  b=RboykihhqFkIUSD3rtX+V7rVrA0uuG8mga/mtjo7G2gyuLLip2JNpZGB
   pWOmKo6ZB++mWOxbmYJpQW7JABWj4MGS3waSLI6y3FpINU1y39pz80SAd
   bgCxY5S5jK4it2Zu74QU/IiYvBd8DtPb9e4NtTqDps3THV/uBF7UUkscj
   VpMYXxiqm/madsoE9isbY4RKgJCorT8ZR8NhoRg9W08aclBYN+gs+AnMN
   WsWesnxjuPdne9WwT+OSOBcN1hmha+EnGl6I/RWj5CUkkt8Zduz/IXhNt
   yg3V7PCE5yi4H0POQ7yiMG12lS3rM7z2f8cfEEhM+Rji5Y3EnrZgbWKFX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="97095721"
X-IronPort-AV: E=Sophos;i="6.03,183,1694703600"; 
   d="scan'208";a="97095721"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 17:18:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0iCEVXFb5cKjWNuvPlbgBjxPFOKyKayornHWq9NW9Mp5TadOsZfD8ywW2wPFnFfpK9/HhXrBAur1a/0P+cCiJGr2L/imZ1AnlfIxhvHNWWI9om3D8Ch4aVPy6YXCNeUXVviNfpWpaOexLNUiakqv820AiGVLTM+cQbxpecT8TeD28fCHKV6Bgh5dMfpeY0YsRhXgHt70K620q95pMpIcJxFFaHuByIwoYzqbZZpEGgT8iq4MGKAl7bRqLdLLZME5eNFpoNoOmQEpmh4bjRlYLuVv+gshGRJoEH+J7k7jmH3OJ+9br6ozDvdAuasIP761/hN/lTa/xsvuqAccpuing==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Abt06A5VOFvLNKiV7yEgFJOCqfgvT82NMMR3huRj1o=;
 b=oVbsmDvNUX4waeLhZhwmVMnDBS2T8iLmot8DuV7UykLLTIdQ5JxhEiRkQZ0VtVUUcQcuqsC1Y9zscDje0km9/r40ZwdnS/3k3w/gr4eLK6K6FX4sLP6/Lv2bom0MOvHk3VvdpZ7KHTES6zXvxQEeccUbYYKtbOf/0QVvZ8zBfzEFhqLSHJHFaTWMSoSQbTWya/Fyh5MtlL60q85fAE9skMlw7Yc80VSxprvverUIdGnhvl3nj/o/MZqWMndeTEU6T6VDVnivYTGfr4e0K6Bmks4XD6XIIecF9b4o+0DnT5Gnzu/O888+GxeYTNQgaLj/Op15RWJ8aaI+SiUBtYCELA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYCPR01MB9684.jpnprd01.prod.outlook.com (2603:1096:400:220::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 08:18:06 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::59bd:366a:131b:3f26]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::59bd:366a:131b:3f26%3]) with mapi id 15.20.6838.023; Thu, 28 Sep 2023
 08:18:06 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     =?utf-8?B?J0lscG8gSsOkcnZpbmVuJw==?= 
        <ilpo.jarvinen@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        =?utf-8?B?TWFjaWVqIFdpZWN6w7NyLVJldG1hbg==?= 
        <maciej.wieczor-retman@intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2 0/6] selftests/resctrl: Fixes to failing tests
Thread-Topic: [PATCH v2 0/6] selftests/resctrl: Fixes to failing tests
Thread-Index: AQHZ5+uUEkmiC6yUykqIxZhWW+NGabAv9zRQ
Date:   Thu, 28 Sep 2023 08:18:06 +0000
Message-ID: <TYAPR01MB6330C7644273743C888DE7E98BC1A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20230915154438.82931-1-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20230915154438.82931-1-ilpo.jarvinen@linux.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9NjQ5NzRjNTEtOTMwYi00YTdlLWEwNWMtM2MwNjY3MjJj?=
 =?utf-8?B?NjNiO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMy0wOS0yOFQwODoxMjoyOVo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 179b7dee35274234b850c7367a11da2a
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TYCPR01MB9684:EE_
x-ms-office365-filtering-correlation-id: 57719242-4045-495a-4674-08dbbffb7184
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wyWi1ZXaTmTYv3rt/3NBD25oM0+90QV7iBKj3uwbX+xlxXfDwrroW7GysFzrgelQ3sjhF5vtccqytG2zz+EiGn2Nlv+7XH5+rKMBP2UZ4sgrhzI9Cny9bPkNG9as0uiAsm13lcukFX6SxhRCKl9c4TVdjS8LIB8dV0T/5Ep7YQFWo3P2qzDuJ3oqMj8/YxwTKbP/HBx0+TAOMmjvXAuZG3/58nBkMJ4TWTc2wHTX/hrz4ioypVrkCYk0TLJ9I80DagGZ+0KuQ1gj3rI8PXOFIskbZJHW+1+qPGNsb6dgvwAyqhZsr02mhWl73t9GypyVCObGXjOd8Y8BkUtcmBSWG/k8HJsOgfU861xB4tlmAHUpR7TgjMsek0/0O9PmzgLBaNu/oea4fHkSkMMyqy4KWljRsZfH+vYNdpTKwaWPsH3PMStcwi32l/MDcrp59OBadaeOw5cRyXz0yU0Er6ddW0lybck4GNl28jKGwmq+7Qu3ym/uGdsXXibTIsNBaGE6Az/3IfiqNDpDY2tw/ZQkx5TM1dZMKjD/oIweHQDMPpCrgqMaez/Xio+wnKB73s1prQvta1q37Wpo+w3ffK/piy5fFMA6vKHGWgvKmNJ7mNd+rCA2sQNGn0uEIY57hzoPm0S8QKUjelPzDlKYB9+w4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(230922051799003)(64100799003)(1590799021)(186009)(1800799009)(451199024)(82960400001)(38100700002)(85182001)(33656002)(558084003)(38070700005)(86362001)(1580799018)(66946007)(55016003)(2906002)(122000001)(41300700001)(64756008)(110136005)(66556008)(66446008)(5660300002)(54906003)(478600001)(66476007)(52536014)(71200400001)(7696005)(6506007)(9686003)(8936002)(76116006)(4326008)(8676002)(316002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2l4SUJPcWt5REFDdUZxdUg0dHd2cVUxYVViOGFJQVhta3lpMjlzQTNKNTJv?=
 =?utf-8?B?U1JuTnRRMXNadk96NS9LRXo0SmdzSjNZV3ozODFpbkd5SnRuY1NueVh6NFU5?=
 =?utf-8?B?R3VKWDU0MjNHaUFzNDQzUWFhNTVKdWp5VHBwN1o2WWhpTmRrMmRFVjZiUmM1?=
 =?utf-8?B?N1k5TnVoOUxyMzZjK3ZIbUR4aUVyRm9OcWt1YVlSS1BHZnd1TUZwQW8vSWN1?=
 =?utf-8?B?dkV1R0V3Y0dMek1FUDVmMmZrdzFXdFRhaEpzdnJGM1R2TmdPVkZKQ1FWL2Yz?=
 =?utf-8?B?UTZ2dGRGQVlQMmM3RENFUG00TlZpUDl5cG5aM0c0QnM0ajBRQ0dTRlhMSUxo?=
 =?utf-8?B?RVFFUVprUmZjdUp6NGU1ckJjZDVYRlpEZ2x4UXVtcEFteFBDaUFQNnRCLzhi?=
 =?utf-8?B?MVNObS82MitBa3lkdWJSWTlCWDNsWDlmVGw1b0VienZsaGlmSDEvb1BFQkVY?=
 =?utf-8?B?blZ2alBIcit3bEIwZUVBNjlkbGpmMW9FenMxTS9oaUp2OXdsUkk4bzUxNHBJ?=
 =?utf-8?B?OC83TkwvSHZmbjZGSVQxYnRXaUdTbHdiN0QvZi9HUldocG1yQWdBN0M0VkYv?=
 =?utf-8?B?ZVM3akVSdWQ3cHZRSEpOYnFBOFNoUG0vN090cWFwRHBPRXJLcnhRellJQkJL?=
 =?utf-8?B?T0RzQWc0OVJDdTFMcTg4NlNlWVdhSjQ0T0JvOHJXYURJWWlqQ2YvWTNhemRP?=
 =?utf-8?B?WGZLNlJYQ0NtcDVkQlZlTWJHam5qMkNVeWxVNjBuT3JvWkV6RStycVZVRkQ5?=
 =?utf-8?B?QmdxRE9hZDlZc2dNdjFlR2ovYjJ4SXRDVGthTjcrQS9NdG5uRVZVMUh4dDhl?=
 =?utf-8?B?ZEhWeUNRNVpQMzZyamNDMGdMTzFEMlByRVZPLzhxY1R1RldKWDVCWVV0LzQ2?=
 =?utf-8?B?Ym1lcFZzTmpSVDE4SHJGSk5mUG9Cend0WUVLZ2VFYkVTWldWMlFCWWdkeVFa?=
 =?utf-8?B?d2lNcGF6a054SjREbWttZ0duMFVGUENTQzRIYWUvUGJBMzVGbG1tek9sZHNr?=
 =?utf-8?B?L2hUNTB3ZGJUZXJyaVVIc2JIUkNtbHBocnp3NzhlKzdxaGJScmF6MUpoRnVE?=
 =?utf-8?B?Nyt5MHhGSG5iS0VPdzdvYlhHSGNUNnpGTWVtNUQ0QjBPOGFXR3cyVGowM0VK?=
 =?utf-8?B?MGNuWXI0UXQyaDBwQkQ0VkkvY2MrazVUVGhHc2VSL3lwbVdRUUowdkM3NEln?=
 =?utf-8?B?VUM2MDcwWWVFckpXWVhaQVpFdVRKbVlJWUVXMWtZc2hBeC9aVnczY3gxenVq?=
 =?utf-8?B?ODByUjlVOHViN2FvcEtYZEx0OG83d0NYZXRHeEFsaUFWazNTN3dsQTExNDhB?=
 =?utf-8?B?NWJrZUhMTXB6Qmd0a3pEZkhhZGlQblkvUTh0bmtHSHhiUUJWVHZpMzZPZzNY?=
 =?utf-8?B?VVhGRldpQkVKSmQ3SjdaUkF6YWN0UHJIem5GNWFta0hlbmlxaWZma0k2SmY0?=
 =?utf-8?B?VjVoY3NnMjU2cmlZZnBEazV1UjVSQm5aT1U5UXNsQTAxOWhEamZKTStGMmpM?=
 =?utf-8?B?SzJJM3J2amhjT2FaK3ZFelQ4Ujh2WWVHQlBDdmtscDRDckNid3lPL21Rd2R5?=
 =?utf-8?B?VlAwWGZTa2VvUTVFZ0I2ZExueEx2Q2lGYVQzazhVSGN3VEdGZFFoQ3dyVlBD?=
 =?utf-8?B?UVZzNDFQa3dLRnovejlHVkpzZHlOM0NXc2kyd2JQMC9pakM1WTR4dzhkMHl4?=
 =?utf-8?B?SHlMOVVrOHE3NHJ6YnQ2dWJRS0UxVS9JRDJ2MFA3K2o0VTduNWN2VHlpamc5?=
 =?utf-8?B?dXdkK0tUYUphNW01QUlTKzgwczVvZ1pTWm5Oc1FvMHlWM3BqeGU5ZnFSdDJR?=
 =?utf-8?B?MmJoN1o3OVJLN2tlRjBKNlArWEYyMWxieUo2V3gxTzN1MUZJZHNHNXpjeFN3?=
 =?utf-8?B?TEtPaGw5dXk4aVVUSlJwcWRzOVA5ckZ4S1N0U0lDcTJnTUZSemNwWWZ6anBX?=
 =?utf-8?B?WHpuNVZqbTNGMHFwMEd2NURtUkdyVEhURW5IcTI5VS9yOE5WVXFNS0luZ0lT?=
 =?utf-8?B?N3NtNVJoVEhDZ3l2blJkeW9DRlFkMnpkWFhkQW92anNDLy9rd2pHbDlrczd3?=
 =?utf-8?B?U0hMWmRDK1lPRXg1QnhMeVlVS1Z4NERGc0xPOWk2ajhzODJrbVc1RzlFTWp4?=
 =?utf-8?B?dWwvd3dUc1NQOHNFRnRlVEI2c2toNy9URWNFVGxrVUNkYXVVdC9za05uUUlm?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0NVqLqWKZdsvuIoc/UM0fSW4FeAqOchPvA7NPOgGrusVgU6aC+5qtVmb1cUw8g5/8AhECxixGubuBwZUkrCWE1cA/5uCQ+yDLn1Yl3qZvUS6lpaHrQNJVAQ30FQHiMQi074KE/HkXQVg8/lAwcvjSuGLK0a45x0QYET53w7VVu6nQYDoiTOsuk5nFkpvbEuKrrW72ZOcdfwkY/CY8ywihhl/HVGFRxN1GEr/q7BCmeArHfJOsbuTZA7LtMF6gyecv8k4I/1GmjHt2N5InAyHSTSak8seZvkK0j0oIjIOvbvwrhFsvljPtbMZJB2ifLvZWPW9fcOCk1jRSEeUsF4uICfMVk6kVtATn/QgVrOeZlnCLIH09unyjQaGZr45wA2lEYKxZs3jXB0U42DkI5pD6NWA2Sba0zwYtr0ZXIpC7mhN9H4NFwLcnab8iCruwRp/+EGqmI9tsEZjxEXnQnPJuTgIAOMDlO14a6cqLj3d1cepEoEAabeQePB0RRbkPYSMX50cWng3JtSlZYA3RVHNWhw6EYmg4SpwEbSE/vMOZOXxC6Q8akUVOgtnkQl5O5EGwzxtJGey7OsKXy5ep3KMdC0QXNACv4vmkMcwotwOelNcobfYrC73TIzQGU+O9tVHSzvi4oaNwt1DgLDLLNQ+h/G1esckJ66omGD2H1jJfzJ+lkWVphKTx3R4vPEenDb46o1C76nauK12YEDmof7q0Yclkdu5h4DCEnGlZCHcdloUzn1YadyEA1pkrYh9zYhea90btJBMn6xoCO5/15kHkuAkPL3rsgOOhLsO9so7Ct4uwlpIhRI4NBeue/ojZa9+94r6+Y4eFVuWCvVI05nV1EEQy2wTGadfhvu2cmFX/HlQvPSrFPO+G8wHvOzfX9nxAe90Q/L8qiH+1x9L/iu1ymKymr1GlPmoaSRF/l3JYEk=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57719242-4045-495a-4674-08dbbffb7184
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 08:18:06.5019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e8W35+OAtivbBqFnOm1Q71tc2ZJF0a0SOFZaBdX2OTln2hkyHW/B9TV2xymFhljT6OD5cqD8mx4fv3G4aOjA3G2Ww2kbByf732R1cbhyYMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9684
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgSWxwbywNCg0KSSBydW4gdGhlIGZvbGxvd2luZyBjb21tYW5kIG9uIEludGVsKFIpIFhlb24o
UikgR29sZCA2MjU0IENQVS4NCiAtICQgc3VkbyBtYWtlIC1DIHRvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL3Jlc2N0cmwgcnVuX3Rlc3RzDQogLSB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9yZXNjdHJs
JCBzdWRvIC4vcmVzY3RybF90ZXN0cw0KVGhlcmUgaXMgbm8gcHJvYmxlbS4NCg0KPFJldmlld2Vk
LWJ5OnRhbi5zaGFvcGVuZ0BqcC5mdWppdHN1LmNvbT4NCjxUZXN0ZWQtYnk6dGFuLnNoYW9wZW5n
QGpwLmZ1aml0c3UuY29tPg0KDQpCZXN0IHJlZ2FyZHMsDQpTaGFvcGVuZyBUQU4NCg==
