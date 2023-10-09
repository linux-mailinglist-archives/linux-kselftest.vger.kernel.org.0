Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFB07BD4E1
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 10:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345488AbjJIIJC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 04:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345486AbjJIIJB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 04:09:01 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092578F;
        Mon,  9 Oct 2023 01:08:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaVlp+n/lau14gRPlzJ0/YHnAKh5AhGNZdvjTlRDG+8Jsjo39ISZdr0zBcNB8cjx01Yx14hCmvtVZjCm1qep9TGgxUsdJHkkZJ1D9Eo1BVIFm5BrxJN4AmsViC83GepXILFj/KiSnaLa0aleMWHyO2b+4Nc5Vua6B13lN+o9eLeWPvu5DfqC455hU2iszSZhOV9XlZ/g0xwrDkNOjri1iRdTIq4TGZH3y7TM/5I0Vv1H2ASqrjfIjKEQaEvYSwUAHsSt2/KtJQMGsH585xkBwzJTR7DhdbS7OHI/STxors1qK+58bDiLyU7fGDmSSjrHllR8ppO12vmFNeD6/Q0AKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oggIWsAdXG9VzgB5g+W1DLhLomm0Oop1x+E9gvYhfQ=;
 b=K+6t2d+F7vu2hMyUGhQnnegONChfexiyhLGAwRkgFTQUkLvKQcfYtuJUbh90e7X/pvX98vlK71t7cPWI9H0l3vfMt+whYhk9v+aHCtqPLXnUGAX9OkH20XHluONUzMg9p446te/CmyNO5SIbfO+ZvHsL4JtwnZQQsUMzj5piu5+1OGW8XwwSD2TXvUQFYoELSG+Ld1RuA8VKd44CKHOuD+c4icUOe9cH0AsvIBN+FqOnwO+cq8g27yuB9IY9KjrQRiONeWcVH+Yo/8sSogh/tCQDnWS6u/OojwVaAME53oAiGURQmmP83HASWCx8SNdjClolRaF61Ki9V6Y+PIdp7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oggIWsAdXG9VzgB5g+W1DLhLomm0Oop1x+E9gvYhfQ=;
 b=wAgETxl8pHlvGM/d+0WR+768aztlguJjXK2tAUpuX4eFOADrGloJJz22Had3CDCaBN55yKqMciFnto8/rF4ie/MYCdQKca5T/zVD5r8KHIo0pd+uiCnVH7B5QQi+q9RVm0MSqGBhnYn6cZcYjRrMogq5VXgA/wWmbZmw3YMDpbE=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 DS7PR12MB6023.namprd12.prod.outlook.com (2603:10b6:8:85::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.37; Mon, 9 Oct 2023 08:08:56 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::4ead:d69:799a:281e]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::4ead:d69:799a:281e%5]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 08:08:55 +0000
From:   "Meng, Li (Jassmine)" <Li.Meng@amd.com>
To:     "Karny, Wyes" <Wyes.Karny@amd.com>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
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
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>
Subject: RE: [PATCH V8 5/7] cpufreq: amd-pstate: Update amd-pstate preferred
 core ranking dynamically
Thread-Topic: [PATCH V8 5/7] cpufreq: amd-pstate: Update amd-pstate preferred
 core ranking dynamically
Thread-Index: AQHZ+ltr70TOZzLXYkmrkF9CcgKnLLBA/EkAgAAeYIA=
Date:   Mon, 9 Oct 2023 08:08:55 +0000
Message-ID: <DM4PR12MB6351ABFFA54D5D3E243EE369F7CEA@DM4PR12MB6351.namprd12.prod.outlook.com>
References: <20231009024932.2563622-1-li.meng@amd.com>
 <20231009024932.2563622-6-li.meng@amd.com>
 <20231009061621.vrpzz5aaqiv56grh@BLR-5CG13462PL.amd.com>
In-Reply-To: <20231009061621.vrpzz5aaqiv56grh@BLR-5CG13462PL.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=01b1bde0-e55b-4574-8118-6c5d2363789f;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-09T08:07:46Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6351:EE_|DS7PR12MB6023:EE_
x-ms-office365-filtering-correlation-id: d1df6638-26e2-44af-abdb-08dbc89efbb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GmIXdrr7W18cTRM68opPSEsKIcmn29+HT78WUIrnzdr9p+XIMK6AswYtt4CPnrECnt8TmmNiH5QWvvC2Ksmqq5g8sWRQZp+BOzWizJ4jtRj+XggsEOX1G6qH0wK7wczAh2wM2uhWaldKcRnieffC2nrfTQkJTN2vBlBHHM/CgHfWRt5lAlr+EW61b9yGGxV0hFcfcc5I/lYQWE/YPeEo7hWxsBMNpQUuEino7D2qKl+5M5nXYf1ZlhnnHIeO5GOzViMBMv6c5ML0p93kuY4CfxiO+qB0lbO+7xKfATPVCEfFKqvnsnkgdWdyjqUe+8e7qdvWKYUZ4krXNUQIKVEqcGHVVo9HTSKqdtE3whYe3Sm//iKlMMVGy9R5y4E053go17yrt/aJU+HAep2BKV5hkZo91e+DxI+BF20oxmQJ9K9S+aFMOQ110825uEJE0PriSNK2SF/oMeBaEP7VagLCoNxANRAMvqfFMmXPSz6XPEGn1S328c7fFiQNDze4oG1AwIw+XJauQtkAZ+ER7MFk/moWR8Nd1YAZZoc2Vbc3dr1exNSXqJC1gorS3f7ywLsT//mR959ZuTgjUPcbEvCH1z03zrLC416oXdnS7wGQhC82O5+OH8o6n+5R3d+S2e7/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(376002)(136003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(122000001)(86362001)(38100700002)(38070700005)(33656002)(66899024)(55016003)(15650500001)(2906002)(9686003)(478600001)(52536014)(5660300002)(41300700001)(8936002)(4326008)(6862004)(8676002)(7696005)(71200400001)(53546011)(6506007)(83380400001)(66556008)(66476007)(6636002)(54906003)(76116006)(64756008)(66446008)(66946007)(316002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tqBm09NFTk9xUUGgGrCGtRg4Z0kocBZD/kpHeTOhAior9TdB4tvTg9edBKfo?=
 =?us-ascii?Q?UitrvD0HvXL9zTceYvNwdvG7adCt7PmvmttjJg2VBoGl5hvAiY4o//1p2cn4?=
 =?us-ascii?Q?uPi7zvlxCmb5t7xN5UVH0DeYwNiRx5s+gW/37Hmr177r/emDMTR6xdEtJQ+j?=
 =?us-ascii?Q?C/BijEzrsgChGMUPMg2wY3e8lHFXypsDb5tzKO5136fu+VSfe6I0xtpCpLQE?=
 =?us-ascii?Q?Hu5oJspd1Dz6x21PLxZAMvV1CZMVguxFNOtTbz9mG1Dvyi1c5ucQX02mSBjZ?=
 =?us-ascii?Q?LY7zlVQ8dwsXFo4/2UmHmEx/Mh7+ROT4bzE3IakBZJG7AZ/GolBqPUmXXHCY?=
 =?us-ascii?Q?pfJaZHjnWoJjFW5g2qdCh98m9mRTdA+ii59huOjCqZ9wcJ91wHmpZhjBTW0r?=
 =?us-ascii?Q?5irI0jo9kYTs8YgzedYuB9rI64Q/SdwmxP1/2u4fTaI7sRVrU4OJJ1Gkaqwz?=
 =?us-ascii?Q?J7i10vmqEV5rfltxkXFqhB1PLL/BYcwNlBN0W+DKIKuiGBGaHCheimmSwxlM?=
 =?us-ascii?Q?sqC8FzZ1wLXYqYAwHdGrzgKeCbe4H43wnnTwxNwAYzQboa5xSEk2gHeePBg9?=
 =?us-ascii?Q?z7zdvRvuZzYQb6Bv4Wt2RC2kl+LJzvYm4QTn7sjlnr1Y60est+4aeLnK8H2h?=
 =?us-ascii?Q?e0Zs/EaDoB4qbN/jiZRrRtLH/kT1/o2mlLfmjSxSfK61QT+Fj9AWyxl/N+/M?=
 =?us-ascii?Q?Hz9xbTT8mkpu3ja/Hh0QxHpM+sh0EI6xMcYmRHzlXzlxFpphph+aLUYP5RZ1?=
 =?us-ascii?Q?DXSE7AfKai57/629baOWA7eULrjRt8UXSfB/HEYCDwuRiUmWoC8RJxuEcrU7?=
 =?us-ascii?Q?UbtkvW0pDNWdToSE01ZX1HTzSr23HafuqNvXplTGEAZji39frUQGcGbdSNzJ?=
 =?us-ascii?Q?zS0qSaP8HSPSFcxeVLn5dUPDnOLJRcFD3QZwf3Y8fRB04qtn0WortTTYP87J?=
 =?us-ascii?Q?J4sr/8EHpaavfukFM8bEQtnKvyuXVJ1BpLJd59Vsob41g9X9B2P3MuXV6YMV?=
 =?us-ascii?Q?UiEQTXcvoP6dLpKehcrxFm6TMBk1zswOsdm+Q6l9J7ilUAbpToYW9e1tXPRC?=
 =?us-ascii?Q?cII8NLMaslX/pD+VRRtxhdiDCLtHqYmknEZ+QqzStaCuT3LMIzWwLBFhLOgg?=
 =?us-ascii?Q?erPtu5yIltt7djmKoXtGW2E9fNAqJxr0m5xlMuwT04mMX2DZEzJYZu3e7DKs?=
 =?us-ascii?Q?fi8jZ1vI/l1/eSedVqmAcDOb3rjYtcE7MPpAWrixX1T3BaWovDpAtYFj1idN?=
 =?us-ascii?Q?+Us0iB2VDiv6aWG8IvzfybYUDvGY2EhfJ7LBX4iDehjK+OhhlsCJLeWA0UOW?=
 =?us-ascii?Q?gOv6UDCx88/sFO6IPSWdqVUWx5nYIVVIagw6y2FWp2tNiQpW5NfQ5s8kb6yw?=
 =?us-ascii?Q?RKRXYsEkteEvqYrT+rDJH55WjP3qpcsbcA8/QkwhVzfsC8SvGbrx8VSKgpzG?=
 =?us-ascii?Q?Q1k1Zt7dCrvK6fk5Imj+wPrvnB5Abp5CMT7T195E0OAe3YDB/vgHcTakV5hR?=
 =?us-ascii?Q?9nOQgOeEuzrfM9sv6mdTsj7iry9seAWBlx60/xY4LZQthzQIkRRovdnslOae?=
 =?us-ascii?Q?50cJ7jilzRjvSKtd8y8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1df6638-26e2-44af-abdb-08dbc89efbb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 08:08:55.6067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rNue0ZOej3bmcsAPglP2jdaa0WDiY/NJsjdWc7uh57u0DGG7dA7pr3BK+C3TOEAOzOEtLTmFzmgwCbjmvckftw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6023
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[AMD Official Use Only - General]

Hi Wyes:

> -----Original Message-----
> From: Karny, Wyes <Wyes.Karny@amd.com>
> Sent: Monday, October 9, 2023 2:19 PM
> To: Meng, Li (Jassmine) <Li.Meng@amd.com>
> Cc: Karny, Wyes <Wyes.Karny@amd.com>; Rafael J . Wysocki
> <rafael.j.wysocki@intel.com>; Huang, Ray <Ray.Huang@amd.com>; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org; x86@kernel.org; linux-
> acpi@vger.kernel.org; Shuah Khan <skhan@linuxfoundation.org>; linux-
> kselftest@vger.kernel.org; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; Du,
> Xiaojian <Xiaojian.Du@amd.com>; Viresh Kumar <viresh.kumar@linaro.org>;
> Borislav Petkov <bp@alien8.de>
> Subject: Re: [PATCH V8 5/7] cpufreq: amd-pstate: Update amd-pstate
> preferred core ranking dynamically
>
> Hi Meng Li,
>
> On 09 Oct 10:49, Meng Li wrote:
> > Preferred core rankings can be changed dynamically by the platform
> > based on the workload and platform conditions and accounting for
> > thermals and aging.
> > When this occurs, cpu priority need to be set.
> >
> > Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> > Reviewed-by: Wyes Karny <wyes.karny@amd.com>
> > Reviewed-by: Huang Rui <ray.huang@amd.com>
> > Signed-off-by: Meng Li <li.meng@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 34
> ++++++++++++++++++++++++++++++++--
> >  include/linux/amd-pstate.h   |  6 ++++++
> >  2 files changed, 38 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index 6ac8939fce5a..d3369247c6c9 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -313,6 +313,7 @@ static int pstate_init_perf(struct amd_cpudata
> *cpudata)
> >     WRITE_ONCE(cpudata->nominal_perf,
> AMD_CPPC_NOMINAL_PERF(cap1));
> >     WRITE_ONCE(cpudata->lowest_nonlinear_perf,
> AMD_CPPC_LOWNONLIN_PERF(cap1));
> >     WRITE_ONCE(cpudata->lowest_perf,
> AMD_CPPC_LOWEST_PERF(cap1));
> > +   WRITE_ONCE(cpudata->prefcore_ranking,
> AMD_CPPC_HIGHEST_PERF(cap1));
> >
> >     return 0;
> >  }
> > @@ -334,6 +335,7 @@ static int cppc_init_perf(struct amd_cpudata
> *cpudata)
> >     WRITE_ONCE(cpudata->lowest_nonlinear_perf,
> >                cppc_perf.lowest_nonlinear_perf);
> >     WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
> > +   WRITE_ONCE(cpudata->prefcore_ranking, cppc_perf.highest_perf);
> >
> >     if (cppc_state =3D=3D AMD_PSTATE_ACTIVE)
> >             return 0;
> > @@ -540,7 +542,7 @@ static void amd_pstate_adjust_perf(unsigned int
> cpu,
> >     if (target_perf < capacity)
> >             des_perf =3D DIV_ROUND_UP(cap_perf * target_perf,
> capacity);
> >
> > -   min_perf =3D READ_ONCE(cpudata->highest_perf);
> > +   min_perf =3D READ_ONCE(cpudata->lowest_perf);
>
> This seems to be a fix. So, this could be a separate patch.
[Meng, Li (Jassmine)] Thanks, I will modify it.
>
> >     if (_min_perf < capacity)
> >             min_perf =3D DIV_ROUND_UP(cap_perf * _min_perf, capacity);
> >
> > @@ -760,6 +762,32 @@ static void amd_pstate_init_prefcore(struct
> amd_cpudata *cpudata)
> >     }
> >  }
> >
> > +static void amd_pstate_update_highest_perf(unsigned int cpu) {
> > +   struct cpufreq_policy *policy;
> > +   struct amd_cpudata *cpudata;
> > +   u32 prev_high =3D 0, cur_high =3D 0;
> > +   int ret;
> > +
> > +   if ((!amd_pstate_prefcore) || (!cpudata->hw_prefcore))
> > +           return;
> > +
> > +   ret =3D amd_pstate_get_highest_perf(cpu, &cur_high);
> > +   if (ret)
> > +           return;
> > +
> > +   policy =3D cpufreq_cpu_get(cpu);
> > +   cpudata =3D policy->driver_data;
> > +   prev_high =3D READ_ONCE(cpudata->prefcore_ranking);
> > +
> > +   if (prev_high !=3D cur_high) {
> > +           WRITE_ONCE(cpudata->prefcore_ranking, cur_high);
> > +           sched_set_itmt_core_prio(cur_high, cpu);
> > +   }
> > +
> > +   cpufreq_cpu_put(policy);
> > +}
> > +
> >  static int amd_pstate_cpu_init(struct cpufreq_policy *policy)  {
> >     int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> @@
> > -926,7 +954,7 @@ static ssize_t show_amd_pstate_highest_perf(struct
> cpufreq_policy *policy,
> >     u32 perf;
> >     struct amd_cpudata *cpudata =3D policy->driver_data;
> >
> > -   perf =3D READ_ONCE(cpudata->highest_perf);
> > +   perf =3D READ_ONCE(cpudata->prefcore_ranking);
>
> I think this should show cpudata->highest_perf.
[Meng, Li (Jassmine)] Thanks, I will modify it.
Add a new function for prefcore_ranking.
>
> Thanks,
> Wyes
> >
> >     return sysfs_emit(buf, "%u\n", perf);  } @@ -1502,6 +1530,7 @@
> > static struct cpufreq_driver amd_pstate_driver =3D {
> >     .suspend        =3D amd_pstate_cpu_suspend,
> >     .resume         =3D amd_pstate_cpu_resume,
> >     .set_boost      =3D amd_pstate_set_boost,
> > +   .update_highest_perf    =3D amd_pstate_update_highest_perf,
> >     .name           =3D "amd-pstate",
> >     .attr           =3D amd_pstate_attr,
> >  };
> > @@ -1516,6 +1545,7 @@ static struct cpufreq_driver
> amd_pstate_epp_driver =3D {
> >     .online         =3D amd_pstate_epp_cpu_online,
> >     .suspend        =3D amd_pstate_epp_suspend,
> >     .resume         =3D amd_pstate_epp_resume,
> > +   .update_highest_perf    =3D amd_pstate_update_highest_perf,
> >     .name           =3D "amd-pstate-epp",
> >     .attr           =3D amd_pstate_epp_attr,
> >  };
> > diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> > index 87e140e9e6db..426822612373 100644
> > --- a/include/linux/amd-pstate.h
> > +++ b/include/linux/amd-pstate.h
> > @@ -39,11 +39,16 @@ struct amd_aperf_mperf {
> >   * @cppc_req_cached: cached performance request hints
> >   * @highest_perf: the maximum performance an individual processor may
> reach,
> >   *           assuming ideal conditions
> > + *           For platforms that do not support the preferred core
> feature, the
> > + *           highest_pef may be configured with 166 or 255, to avoid
> max frequency
> > + *           calculated wrongly. we take the fixed value as the
> highest_perf.
> >   * @nominal_perf: the maximum sustained performance level of the
> processor,
> >   *           assuming ideal operating conditions
> >   * @lowest_nonlinear_perf: the lowest performance level at which
> nonlinear power
> >   *                    savings are achieved
> >   * @lowest_perf: the absolute lowest performance level of the
> > processor
> > + * @prefcore_ranking: the preferred core ranking, the higher value
> indicates a higher
> > + *                   priority.
> >   * @max_freq: the frequency that mapped to highest_perf
> >   * @min_freq: the frequency that mapped to lowest_perf
> >   * @nominal_freq: the frequency that mapped to nominal_perf @@ -73,6
> > +78,7 @@ struct amd_cpudata {
> >     u32     nominal_perf;
> >     u32     lowest_nonlinear_perf;
> >     u32     lowest_perf;
> > +   u32     prefcore_ranking;
> >
> >     u32     max_freq;
> >     u32     min_freq;
> > --
> > 2.34.1
> >
