Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6397E1BBE
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Nov 2023 09:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjKFIPl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Nov 2023 03:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjKFIPj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Nov 2023 03:15:39 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4D8E0;
        Mon,  6 Nov 2023 00:15:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPerrCNnbQFZSJ5bzniAP00lUN57MUMeuIN6jkXRvPHe1qJXA1VzqhvypAptkthH3jDv0gRUqBx0yNGIrmQA9gFBh80YU/I0eJWOuNMAgQlv5bzY7WKPWYVmFsCcoQxvTpc0xiylJzlZzF60T41WFUn/iUujI3uAWuVxe31QWd9lNhLi/zbLzaFR83YCk2yiqyvgy6UN9IP44NlMOm/YFSXtdfSOp6AihXIlVfpUrUwQSyD+MGamQIXA/NdvBWZNsOoAY/1Hf9ZT/z5/3SAK1pv97j1RsBUFIe3sUJ6fMZ5Omle8mEheZWcwh8EQg788xVLhdlOvXCMXlPi+Rc8G1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2YKcAnwhYN3PZEGVOAknljmkoirsz7U05OjRjEbclE=;
 b=AhugW9IWavcUfdh/HXrJhQ7IntGlq6tsIPevCOCsGK/beB9TeVVnCrx3zze9L/1vNUfgZPEghdQt0w4t5mtICvROf4b6FrfvTvFWaX71pA47GMAA+OJacEqC1eB+tYuD1ouOcSwFyLwAGfrqp+gDExAapjioUjYgRIX+L/dXGr0hDv/USpHFM0nuaqrWN8ajr8vaopfGDYUrjsl8p2naDOVK7uY85uA4hJm8G+ltOvkaEDiWLlqXxF1/qHws8yDDI6dzu/DHDf3EJS8nZ/No59xrgE1OHRr6aFW79ym2diXZ9N7Lfty2bicskpwelnYVb4BJp8GmlrPpT0YoL2I0MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2YKcAnwhYN3PZEGVOAknljmkoirsz7U05OjRjEbclE=;
 b=3LFefN2c8koEcLdKPpm5nMxaqA6waN/44BBQSHMiBJREz8N59EaoHfgnJJa8gz+miw2VumBcxOQd17agVVX9CQ+U9rHivhSsqZM6X74LE6qRFXnylEuP3xtF09teQD1Fi0wbe+22qTKaj+GUxzD2HxozYXlOzkL9HbS5FelLUrE=
Received: from IA1PR12MB6332.namprd12.prod.outlook.com (2603:10b6:208:3e2::13)
 by DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 08:15:29 +0000
Received: from IA1PR12MB6332.namprd12.prod.outlook.com
 ([fe80::43ed:468d:3105:4071]) by IA1PR12MB6332.namprd12.prod.outlook.com
 ([fe80::43ed:468d:3105:4071%4]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 08:15:28 +0000
From:   "Meng, Li (Jassmine)" <Li.Meng@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        "Karny, Wyes" <Wyes.Karny@amd.com>
Subject: RE: [PATCH V10 3/7] cpufreq: amd-pstate: Enable amd-pstate preferred
 core supporting.
Thread-Topic: [PATCH V10 3/7] cpufreq: amd-pstate: Enable amd-pstate preferred
 core supporting.
Thread-Index: AQHaCvtEZLeRkIqFlEuvYO4YF3DfDbBmwYGAgAY6fDA=
Date:   Mon, 6 Nov 2023 08:15:27 +0000
Message-ID: <IA1PR12MB6332765961C9DE1544DD6D5EF7AAA@IA1PR12MB6332.namprd12.prod.outlook.com>
References: <20231030063403.3502816-1-li.meng@amd.com>
 <20231030063403.3502816-4-li.meng@amd.com>
 <CYYPR12MB86553FEBDCEB730FF606D2549CA6A@CYYPR12MB8655.namprd12.prod.outlook.com>
In-Reply-To: <CYYPR12MB86553FEBDCEB730FF606D2549CA6A@CYYPR12MB8655.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=962b80e8-47c8-4d0d-8d77-9d49e308844c;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-02T08:58:03Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6332:EE_|DM6PR12MB4156:EE_
x-ms-office365-filtering-correlation-id: e32ef18c-5dfe-4f12-d092-08dbdea088dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q6fM2qlXJHY5/f1Zqg23r+ELA8hVeyfjDGZTBvCcluzsVkZut7jR5RAW33mD3vsLmuEHGsF8R7VbvPF8xCyCx+gdamB7KYAxggJ98ScR38MSYlmrb2J3I55n6q2yjE/kLi5ZX+4FjL/Y4nFIJzsFOhP9A9v1m3JmPy5JH7txaB3+pTwJ1jgTKXTWzrIpCdYybwa4045AlMFOefQ+Vz+BQuGkR+PCh/jZBvxbz+CE6kcjJn7xeQYYRMTG1SWqckiRwHUyX6Fy+lNIxW4p0LRIRADqq/dDnSHAYH2pCRHFC5CqQIQgyabaWDvyxA2NSvbXLmaQss/6eZTf44qIbOS0HhUsPP2SiizDEkLleQlPU2F+81XWwlxTZf/9WK19GfWpMynFMgCT8JSvmZUqNhRZg1jb/YXiNPhxKB5pVd6LBiHFhcj/X+vkYhg0zqXdfSCIi11+V5wKY5G3/1lmXmpS0stwP/ANamS3ZLtRK0vWDknweEovWHinajHi3WFERhk66cepPA/67a+01wDCzqv8M/5lPLBcN3Aw3tTtDiLSHdacUfbt/W+ZcAt6cbhb476eSCRQRgxoBg8R1zrT3CW/lxSz0wFardjeXChyK2s5mnEtIUqn+5ndwCu2W/cxgfTp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6332.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(316002)(64756008)(66446008)(66556008)(66476007)(66946007)(54906003)(76116006)(6636002)(110136005)(71200400001)(7696005)(6506007)(9686003)(53546011)(26005)(38070700009)(38100700002)(122000001)(83380400001)(33656002)(86362001)(478600001)(5660300002)(41300700001)(8936002)(8676002)(52536014)(4326008)(2906002)(30864003)(7416002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?SlNJOC9XMjIwRUdPdEY2Q2lDWDVZaFdwWVZGdDN4SDJqWU5veFN3b3hL?=
 =?iso-2022-jp?B?S01hMFkzOHREcDduSlFqRkFpc1lOYURYbGFGSVJjdmtYYitmNTNLL3Ay?=
 =?iso-2022-jp?B?aFc3WUZLd2hkODhlZzNHcHd4MG1YMmp3d2ZGV0ZmcHU5VVI0cmtXcDRD?=
 =?iso-2022-jp?B?M3NPZzJNNHJvYmVhL1NkeitSeG5nMUx6SWI2SUtiTDZELzE5RjBTNTZY?=
 =?iso-2022-jp?B?TzNqaU11SDJ2elNVSzBKbnk1YTI3d0Qxb1FZeS9taStvT3BsVEhRNm4v?=
 =?iso-2022-jp?B?cWsyd0Z0NE9hRGFUVUlGZE9WUmFvM1BMc0JzMElNNHJiT0xVTWo4RnZp?=
 =?iso-2022-jp?B?VXV5cVRkOFk4R1F5eG1haDFsdnRjQ3FTY2tMM3ZEM3hnUG9OK3lNT29V?=
 =?iso-2022-jp?B?SUxyc3RVQjNJdkxONWlPUHZMUDRwZjYyQ0hzZlB6OHFJeFc4WGpIOUt0?=
 =?iso-2022-jp?B?N1JvNjIyU241SDJWSlgxVXFuSXN2elhVSFpVVmJIKzZ3REUzTEUzRHRw?=
 =?iso-2022-jp?B?YkhzVi9RbXRtOVhyQkFQRlZpTDhwbllQTWhvZ2E1TnU3aTBSVW4wd3dR?=
 =?iso-2022-jp?B?UWVURElNRWQyb3ptaDhvbi94SU9HYTkxL09BL2VNVHE3dG92Y21JdTJ1?=
 =?iso-2022-jp?B?ZGpPakt1VG9MQ3hQZ0svWVZmNnBVaHdCZ2J6elVoQWRHcHdxampXMFBw?=
 =?iso-2022-jp?B?dm4xWlZqeC9oTUJFYnpzK2FHWjl6TmZhTU02OGNmUWE5Rkx6M051WWto?=
 =?iso-2022-jp?B?b3ljZG9SSE5Zc3lYOGVkYldWZ2J6eDZlcWFvOXNwUzI2V280WDBNcUVJ?=
 =?iso-2022-jp?B?QTZFYkczbFZCL2FNTkduZDFCY1I0V3VtdjFYREVuOGFHcmsyOTd2bzUw?=
 =?iso-2022-jp?B?emFHaGx6WHI5TmFma0ZGUWtUNzVtdHhKSnlSaHRUK1lQSHVhcGh1MFBY?=
 =?iso-2022-jp?B?R1BoS0E2SXRTNG5VU1poL2MzMzZ3L2R1dmYreG0rYmI2QmpZcFJtK2h2?=
 =?iso-2022-jp?B?Zmx5V08vVG9iU2hKR3hxL3BaOVpUQytWWmtCMUNsbmRLdGdjV2F2M3Bn?=
 =?iso-2022-jp?B?dmVWNmp1OFE2RG9uVWpLY2VOamQwK1FvUVEwekp5bytNeWhLSDhMV0VF?=
 =?iso-2022-jp?B?TGptUXFOTkdrYm4zMXhJNjRIVkhtenBsS1loWW9Ub1VFM0JuOG56M0F1?=
 =?iso-2022-jp?B?aTVYTmpOYyt1V0krSEYxZ3A0a0EwNFU5SDV1ZjhiSlBtclZ5aHBmUzV6?=
 =?iso-2022-jp?B?YWNVSUNYR0VVSHZTd3VzZHVNK3M2VHFKdmVweU0yaHhQcmFUWVVhcWJB?=
 =?iso-2022-jp?B?ZlFMTTIvTWlXaFg2eElZeEZnUXlqVGQ1MUxJNGMxYjZSWlFrRU5QUnFq?=
 =?iso-2022-jp?B?ZzEvZXpkN1dJdkN3M3RuU1l5Q1FUN1h1OGhvOGJld00rRlltMGs4U3lE?=
 =?iso-2022-jp?B?SDMvYTMzb2lWSjZTWEJYQ0F4ZWNHMmhObk9xd05wQjJGanRuMFVNQjVJ?=
 =?iso-2022-jp?B?aDErQklSa2dla1BRMVRoVnBJcVlKakxvZ2FGYUk4RTBFU0JLNTRQS0c0?=
 =?iso-2022-jp?B?a0MrbkdBYWljbWxBNENaTVhXQVVnQ0NvaWFBVmt3bEtKakJ6UDJHWGY1?=
 =?iso-2022-jp?B?NHlrVTk2ZWdUV2FscTJaZTJ5K2NKclB6UWJHbk5nOWlrNkN0aUd3TVFQ?=
 =?iso-2022-jp?B?STArekt6b3RDWTJLLzRncFd5Vlk3dCtKU01ScVROKzZreFpCcWZ1ZElt?=
 =?iso-2022-jp?B?cWcyMDlUWFJvSWVPUVUzUUZIU2RnbXJFbGZKa0hGOUVMUE81OC9vYXhZ?=
 =?iso-2022-jp?B?elRHMVBHNFhhU0NSS1hmNVFZU3M0SGljdVFSOXI1MkN6STYxd2lXckVk?=
 =?iso-2022-jp?B?V1p3L2YwMVNlR0w2TXdwU2g4TldKbVVuRDU3bVBpeXNsMWFLRlQweHBu?=
 =?iso-2022-jp?B?WERIZ3FnWFVQSUVPc0RvaWlqRHBQSFRrRjQ0RkZBdHJ0TGs4UjhUZDNH?=
 =?iso-2022-jp?B?ME92TEl6TWVVODNQd0VPOWRUQXRkR2FKVlVMdmNuaXB3NjhnV200QWdX?=
 =?iso-2022-jp?B?aVU5K25WTm1vdjVUYjhZa1BxM0J2Uk1xV2hWUG9hME4rL04vNTU2cXl2?=
 =?iso-2022-jp?B?aGV6YVNMalc3L1hLUWRPMXZxUnRkY2hRSWsrVGEwU0ptUGZPcHZuRWlj?=
 =?iso-2022-jp?B?MzFRaGUxcGxJZyt5dmllYW82RW55S1MwZ2U3SWRvMU1hMXdvd3BQVTRY?=
 =?iso-2022-jp?B?d1I4cm56SlhZUlI1NVE2NytpKzNIRXIvST0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6332.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e32ef18c-5dfe-4f12-d092-08dbdea088dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 08:15:27.5059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dF2L7Pcg6c2pW2PR85VTLrmPbOggl8sqwl5bhwJunemgUkRe3QgfrSqFS4y1SgIEZ9U1RGAVAV3585AQ+O16Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[AMD Official Use Only - General]

Hi perry=1B$B!'=1B(B

> -----Original Message-----
> From: Yuan, Perry <Perry.Yuan@amd.com>
> Sent: Thursday, November 2, 2023 5:06 PM
> To: Meng, Li (Jassmine) <Li.Meng@amd.com>; Rafael J . Wysocki
> <rafael.j.wysocki@intel.com>; Huang, Ray <Ray.Huang@amd.com>
> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org;
> x86@kernel.org; linux-acpi@vger.kernel.org; Shuah Khan
> <skhan@linuxfoundation.org>; linux-kselftest@vger.kernel.org; Fontenot,
> Nathan <Nathan.Fontenot@amd.com>; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Viresh
> Kumar <viresh.kumar@linaro.org>; Borislav Petkov <bp@alien8.de>;
> Oleksandr Natalenko <oleksandr@natalenko.name>; Karny, Wyes
> <Wyes.Karny@amd.com>
> Subject: RE: [PATCH V10 3/7] cpufreq: amd-pstate: Enable amd-pstate
> preferred core supporting.
>
> [AMD Official Use Only - General]
>
> Hi meng Li,
>
>
> > -----Original Message-----
> > From: Meng, Li (Jassmine) <Li.Meng@amd.com>
> > Sent: Monday, October 30, 2023 2:34 PM
> > To: Rafael J . Wysocki <rafael.j.wysocki@intel.com>; Huang, Ray
> > <Ray.Huang@amd.com>
> > Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org;
> > x86@kernel.org; linux-acpi@vger.kernel.org; Shuah Khan
> > <skhan@linuxfoundation.org>; linux- kselftest@vger.kernel.org;
> > Fontenot, Nathan <Nathan.Fontenot@amd.com>; Sharma, Deepak
> > <Deepak.Sharma@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>;
> > Yuan, Perry <Perry.Yuan@amd.com>; Du, Xiaojian
> <Xiaojian.Du@amd.com>;
> > Viresh Kumar <viresh.kumar@linaro.org>; Borislav Petkov
> > <bp@alien8.de>; Oleksandr Natalenko <oleksandr@natalenko.name>;
> Meng,
> > Li (Jassmine) <Li.Meng@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>
> > Subject: [PATCH V10 3/7] cpufreq: amd-pstate: Enable amd-pstate
> > preferred core supporting.
> >
> > amd-pstate driver utilizes the functions and data structures provided
> > by the ITMT architecture to enable the scheduler to favor scheduling
> > on cores which can be get a higher frequency with lower voltage. We
> > call it amd-pstate preferrred core.
> >
> > Here sched_set_itmt_core_prio() is called to set priorities and
> > sched_set_itmt_support() is called to enable ITMT feature.
> > amd-pstate driver uses the highest performance value to indicate the
> > priority of CPU. The higher value has a higher priority.
> >
> > The initial core rankings are set up by amd-pstate when the system boot=
s.
> >
> > Add a variable hw_prefcore in cpudata structure. It will check if the
> > processor and power firmware support preferred core feature.
> >
> > Add one new early parameter `disable` to allow user to disable the
> > preferred core.
> >
> > Only when hardware supports preferred core and user set `enabled` in
> > early parameter, amd pstate driver supports preferred core featue.
> >
> > Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> > Reviewed-by: Huang Rui <ray.huang@amd.com>
> > Reviewed-by: Wyes Karny <wyes.karny@amd.com>
> > Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> > Co-developed-by: Perry Yuan <Perry.Yuan@amd.com>
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > Signed-off-by: Meng Li <li.meng@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 141
> > +++++++++++++++++++++++++++++++----
> >  include/linux/amd-pstate.h   |   4 +
> >  2 files changed, 129 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index 9a1e194d5cf8..2033e5e70017 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -37,6 +37,7 @@
> >  #include <linux/uaccess.h>
> >  #include <linux/static_call.h>
> >  #include <linux/amd-pstate.h>
> > +#include <linux/topology.h>
> >
> >  #include <acpi/processor.h>
> >  #include <acpi/cppc_acpi.h>
> > @@ -49,6 +50,7 @@
> >
> >  #define AMD_PSTATE_TRANSITION_LATENCY        20000
> >  #define AMD_PSTATE_TRANSITION_DELAY  1000
> > +#define AMD_PSTATE_PREFCORE_THRESHOLD        166
> >
> >  /*
> >   * TODO: We need more time to fine tune processors with shared memory
> > solution @@ -64,6 +66,7 @@ static struct cpufreq_driver
> > amd_pstate_driver; static struct cpufreq_driver amd_pstate_epp_driver;
> > static int cppc_state =3D AMD_PSTATE_UNDEFINED;  static bool
> > cppc_enabled;
> > +static bool amd_pstate_prefcore =3D true;
> >
> >  /*
> >   * AMD Energy Preference Performance (EPP) @@ -290,23 +293,21 @@
> > static inline int amd_pstate_enable(bool enable)  static int
> > pstate_init_perf(struct amd_cpudata *cpudata)  {
> >       u64 cap1;
> > -     u32 highest_perf;
> >
> >       int ret =3D rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
> >                                    &cap1);
> >       if (ret)
> >               return ret;
> >
> > -     /*
> > -      * TODO: Introduce AMD specific power feature.
> > -      *
> > -      * CPPC entry doesn't indicate the highest performance in some AS=
ICs.
> > +     /* For platforms that do not support the preferred core feature, =
the
> > +      * highest_pef may be configured with 166 or 255, to avoid max
> > frequency
> > +      * calculated wrongly. we take the AMD_CPPC_HIGHEST_PERF(cap1)
> > value as
> > +      * the default max perf.
> >        */
> > -     highest_perf =3D amd_get_highest_perf();
> > -     if (highest_perf > AMD_CPPC_HIGHEST_PERF(cap1))
> > -             highest_perf =3D AMD_CPPC_HIGHEST_PERF(cap1);
> > -
> > -     WRITE_ONCE(cpudata->highest_perf, highest_perf);
> > +     if (cpudata->hw_prefcore)
> > +             WRITE_ONCE(cpudata->highest_perf,
> > AMD_PSTATE_PREFCORE_THRESHOLD);
> > +     else
> > +             WRITE_ONCE(cpudata->highest_perf,
> > AMD_CPPC_HIGHEST_PERF(cap1));
> >
> >       WRITE_ONCE(cpudata->nominal_perf,
> AMD_CPPC_NOMINAL_PERF(cap1));
> >       WRITE_ONCE(cpudata->lowest_nonlinear_perf,
> > AMD_CPPC_LOWNONLIN_PERF(cap1)); @@ -318,17 +319,15 @@ static int
> > pstate_init_perf(struct amd_cpudata *cpudata)  static int
> > cppc_init_perf(struct amd_cpudata *cpudata)  {
> >       struct cppc_perf_caps cppc_perf;
> > -     u32 highest_perf;
> >
> >       int ret =3D cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> >       if (ret)
> >               return ret;
> >
> > -     highest_perf =3D amd_get_highest_perf();
> > -     if (highest_perf > cppc_perf.highest_perf)
> > -             highest_perf =3D cppc_perf.highest_perf;
> > -
> > -     WRITE_ONCE(cpudata->highest_perf, highest_perf);
> > +     if (cpudata->hw_prefcore)
> > +             WRITE_ONCE(cpudata->highest_perf,
> > AMD_PSTATE_PREFCORE_THRESHOLD);
> > +     else
> > +             WRITE_ONCE(cpudata->highest_perf,
> > cppc_perf.highest_perf);
> >
> >       WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
> >       WRITE_ONCE(cpudata->lowest_nonlinear_perf,
> > @@ -676,6 +675,80 @@ static void amd_perf_ctl_reset(unsigned int cpu)
> >       wrmsrl_on_cpu(cpu, MSR_AMD_PERF_CTL, 0);  }
> >
> > +/*
> > + * Set amd-pstate preferred core enable can't be done directly from
> > +cpufreq callbacks
> > + * due to locking, so queue the work for later.
> > + */
> > +static void amd_pstste_sched_prefcore_workfn(struct work_struct
> > +*work) {
> > +     sched_set_itmt_support();
> > +}
> > +static DECLARE_WORK(sched_prefcore_work,
> > +amd_pstste_sched_prefcore_workfn);
> > +
> > +/*
> > + * Get the highest performance register value.
> > + * @cpu: CPU from which to get highest performance.
> > + * @highest_perf: Return address.
> > + *
> > + * Return: 0 for success, -EIO otherwise.
> > + */
> > +static int amd_pstate_get_highest_perf(int cpu, u32 *highest_perf) {
> > +     int ret;
> > +
> > +     if (boot_cpu_has(X86_FEATURE_CPPC)) {
> > +             u64 cap1;
> > +
> > +             ret =3D rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1,
> > &cap1);
> > +             if (ret)
> > +                     return ret;
> > +             WRITE_ONCE(*highest_perf,
> > AMD_CPPC_HIGHEST_PERF(cap1));
> > +     } else {
> > +             u64 cppc_highest_perf;
> > +
> > +             ret =3D cppc_get_highest_perf(cpu, &cppc_highest_perf);
> > +             if (ret)
> > +                     return ret;
> > +             WRITE_ONCE(*highest_perf, cppc_highest_perf);
> > +     }
> > +
> > +     return (ret);
> > +}
> > +
> > +#define CPPC_MAX_PERF        U8_MAX
> > +
> > +static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata) {
> > +     int ret, prio;
> > +     u32 highest_perf;
> > +
> > +     ret =3D amd_pstate_get_highest_perf(cpudata->cpu, &highest_perf);
> > +     if (ret)
> > +             return;
> > +
> > +     cpudata->hw_prefcore =3D true;
> > +     /* check if CPPC preferred core feature is enabled*/
> > +     if (highest_perf < CPPC_MAX_PERF)
> > +             prio =3D (int)highest_perf;
> > +     else {
> > +             pr_debug("AMD CPPC preferred core is unsupported!\n");
> > +             cpudata->hw_prefcore =3D false;
> > +             return;
> > +     }
> > +
> > +     if (!amd_pstate_prefcore)
> > +             return;
>
> Move the feature state check to earlier before you call
> amd_pstate_get_highest_perf().
> If the feature is not enabled, you have no need to read highest perf.
>
[Meng, Li (Jassmine)] I need to set hw_prefcore by highest_perf.
Therefore, the judgment condition =1B$B!H=1B(Bamd_pstate_prefcore=1B$B!I=1B=
(B cannot be moved forward.
>
> > +
> > +     /*
> > +      * The priorities can be set regardless of whether or not
> > +      * sched_set_itmt_support(true) has been called and it is valid t=
o
> > +      * update them at any time after it has been called.
> > +      */
> > +     sched_set_itmt_core_prio(prio, cpudata->cpu);
> > +
> > +     schedule_work(&sched_prefcore_work);
> > +}
> > +
> >  static int amd_pstate_cpu_init(struct cpufreq_policy *policy)  {
> >       int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq,
> > ret; @@ -697,6 +770,8 @@ static int amd_pstate_cpu_init(struct
> > cpufreq_policy
> > *policy)
> >
> >       cpudata->cpu =3D policy->cpu;
> >
> > +     amd_pstate_init_prefcore(cpudata);
> > +
> >       ret =3D amd_pstate_init_perf(cpudata);
> >       if (ret)
> >               goto free_cpudata1;
> > @@ -845,6 +920,17 @@ static ssize_t
> > show_amd_pstate_highest_perf(struct
> > cpufreq_policy *policy,
> >       return sysfs_emit(buf, "%u\n", perf);  }
> >
> > +static ssize_t show_amd_pstate_hw_prefcore(struct cpufreq_policy
> *policy,
> > +                                        char *buf) {
> > +     bool hw_prefcore;
> > +     struct amd_cpudata *cpudata =3D policy->driver_data;
> > +
> > +     hw_prefcore =3D READ_ONCE(cpudata->hw_prefcore);
> > +
> > +     return sysfs_emit(buf, "%s\n", hw_prefcore ? "supported" :
> > +"unsupported"); }
>
> Replace the string with str_enabled_disabled() function that is defined a=
s
> below.
>
> include/linux/string_helpers.h
>
> static inline const char *str_enabled_disabled(bool v) {
>         return v ? "enabled" : "disabled"; }
>
> Perry.
>
> > +
> >  static ssize_t show_energy_performance_available_preferences(
> >                               struct cpufreq_policy *policy, char
> > *buf) { @@ -1037,18 +1123,27 @@ static ssize_t status_store(struct
> > device *a, struct device_attribute *b,
> >       return ret < 0 ? ret : count;
> >  }
> >
> > +static ssize_t prefcore_show(struct device *dev,
> > +                          struct device_attribute *attr, char *buf) {
> > +     return sysfs_emit(buf, "%s\n", amd_pstate_prefcore ? "enabled" :
> > +"disabled"); }
>
> Replace the string with str_enabled_disabled() function that is defined a=
s
> below.
>
> include/linux/string_helpers.h
>
>
> > +
> >  cpufreq_freq_attr_ro(amd_pstate_max_freq);
> >  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
> >
> >  cpufreq_freq_attr_ro(amd_pstate_highest_perf);
> > +cpufreq_freq_attr_ro(amd_pstate_hw_prefcore);
> >  cpufreq_freq_attr_rw(energy_performance_preference);
> >  cpufreq_freq_attr_ro(energy_performance_available_preferences);
> >  static DEVICE_ATTR_RW(status);
> > +static DEVICE_ATTR_RO(prefcore);
> >
> >  static struct freq_attr *amd_pstate_attr[] =3D {
> >       &amd_pstate_max_freq,
> >       &amd_pstate_lowest_nonlinear_freq,
> >       &amd_pstate_highest_perf,
> > +     &amd_pstate_hw_prefcore,
> >       NULL,
> >  };
> >
> > @@ -1056,6 +1151,7 @@ static struct freq_attr *amd_pstate_epp_attr[] =
=3D
> {
> >       &amd_pstate_max_freq,
> >       &amd_pstate_lowest_nonlinear_freq,
> >       &amd_pstate_highest_perf,
> > +     &amd_pstate_hw_prefcore,
> >       &energy_performance_preference,
> >       &energy_performance_available_preferences,
> >       NULL,
> > @@ -1063,6 +1159,7 @@ static struct freq_attr *amd_pstate_epp_attr[] =
=3D
> > {
> >
> >  static struct attribute *pstate_global_attributes[] =3D {
> >       &dev_attr_status.attr,
> > +     &dev_attr_prefcore.attr,
> >       NULL
> >  };
> >
> > @@ -1114,6 +1211,8 @@ static int amd_pstate_epp_cpu_init(struct
> > cpufreq_policy *policy)
> >       cpudata->cpu =3D policy->cpu;
> >       cpudata->epp_policy =3D 0;
> >
> > +     amd_pstate_init_prefcore(cpudata);
> > +
> >       ret =3D amd_pstate_init_perf(cpudata);
> >       if (ret)
> >               goto free_cpudata1;
> > @@ -1527,7 +1626,17 @@ static int __init amd_pstate_param(char *str)
> >
> >       return amd_pstate_set_driver(mode_idx);  }
> > +
> > +static int __init amd_prefcore_param(char *str) {
> > +     if (!strcmp(str, "disable"))
> > +             amd_pstate_prefcore =3D false;
> > +
> > +     return 0;
> > +}
> > +
> >  early_param("amd_pstate", amd_pstate_param);
> > +early_param("amd_prefcore", amd_prefcore_param);
> >
> >  MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
> > MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver"); diff
> > --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h index
> > 446394f84606..87e140e9e6db 100644
> > --- a/include/linux/amd-pstate.h
> > +++ b/include/linux/amd-pstate.h
> > @@ -52,6 +52,9 @@ struct amd_aperf_mperf {
> >   * @prev: Last Aperf/Mperf/tsc count value read from register
> >   * @freq: current cpu frequency value
> >   * @boost_supported: check whether the Processor or SBIOS supports
> > boost mode
> > + * @hw_prefcore: check whether HW supports preferred core featue.
> > + *             Only when hw_prefcore and early prefcore param are true=
,
> > + *             AMD P-State driver supports preferred core featue.
> >   * @epp_policy: Last saved policy used to set energy-performance
> preference
> >   * @epp_cached: Cached CPPC energy-performance preference value
> >   * @policy: Cpufreq policy value
> > @@ -81,6 +84,7 @@ struct amd_cpudata {
> >
> >       u64     freq;
> >       bool    boost_supported;
> > +     bool    hw_prefcore;
> >
> >       /* EPP feature related attributes*/
> >       s16     epp_policy;
> > --
> > 2.34.1
>

