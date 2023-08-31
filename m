Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D9C78E8FE
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 11:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242724AbjHaJDG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 05:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbjHaJDF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 05:03:05 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0851CFA;
        Thu, 31 Aug 2023 02:02:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/F/eyeSFeMyo2B1JvXiLCF6HQJ1LzBn0X6tl8JSIho1WL8OxY9AIFjvzt2oon4kp3aPCd4bkwUYB+rSLVT3e+OxUnSyHc3ZhTPdIabDddQWQ2E4GOEEeu2JH/WabbyZXCgXOBCetrROm6xWQB5arwoD7OcwSKEoHH71C5opaDSjs9VuVdcBaTBK3czWZcPGn82DGhc7Kf0PwyhU7t3bo8tycLcf1ZMJvExfv0KNhrY8O5ZOx1ceBLKq9iFpma+AKpGpWx6hCbqIrC/0UWRsknkF/depHXN+XqxDFy3fe/LyVU5adk/GPiT4TAVaN/1DT3NKjm99iktsvEbjLLTkCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWC/fCbDExfwNNAQP0fU+UMGVQYUpcWLto9fnk4Vtt0=;
 b=VwFHAuno503Ohid54SVy7w4AHrP9CtKVpCwKTSCsNfnWiUYPhFMLSehT0GtT5DTaT2NiEdXAN/dL8g8zCWk8wlmqrx4xEizTPCykTOxbVaBhFE898SbLOP8E0Wjj1gsd4qKVkd3xv8myApLNH0CsruX/5iKtW4sO4ziuAepHhyjMz0UK9xPa2LAggYNvH8b6B0xgSbloDULLA5teLdLQcb6YFfeqs5W2SPlnjLy+gqR6v/+1pVr+G8Qikn4j2LkDimLwxEcK0+En6vI6dfpgNKUqzdV23aIQT+e8JgDwLADeLgER3cvxQb2+3n755/ZPVuW3hu3Sbq9olQp2MxwbPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWC/fCbDExfwNNAQP0fU+UMGVQYUpcWLto9fnk4Vtt0=;
 b=JSyUEF524m2I81OstGK442t/Lam7Sm0v6lkuI9mUx+1n8Agy5JnUXnJGHgg+NBYWNe83rTUy5RPiX3+pjr1StHE/BwZHdKDLLVUmYob49w+XwNvffWSnPQzMjoyabRVtG6X1Jlf+DBtYHoV/wQTCg6GqHdJixg0izBN0s1rGGok=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 PH0PR12MB5420.namprd12.prod.outlook.com (2603:10b6:510:e8::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.35; Thu, 31 Aug 2023 09:02:56 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::d713:8aa1:8769:af10]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::d713:8aa1:8769:af10%7]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 09:02:56 +0000
From:   "Meng, Li (Jassmine)" <Li.Meng@amd.com>
To:     Rene Rebe <rene@exactcode.com>
CC:     "Huang, Ray" <Ray.Huang@amd.com>,
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
        Borislav Petkov <bp@alien8.de>,
        "Karny, Wyes" <Wyes.Karny@amd.com>
Subject: RE: [PATCH V4 3/7] cpufreq: amd-pstate: Enable AMD Pstate Preferred
 Core Supporting.
Thread-Topic: [PATCH V4 3/7] cpufreq: amd-pstate: Enable AMD Pstate Preferred
 Core Supporting.
Thread-Index: AQHZ2lwnDZs38JoMJkCO7wshJ7Z987AEHZdg
Date:   Thu, 31 Aug 2023 09:02:56 +0000
Message-ID: <DM4PR12MB635166747883C322C7199D74F7E5A@DM4PR12MB6351.namprd12.prod.outlook.com>
References: <20230829.113519.1499398743089914237.rene@exactcode.com>
In-Reply-To: <20230829.113519.1499398743089914237.rene@exactcode.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9d1ac992-2eb0-4f9f-bde1-06193d0d57f5;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-31T08:57:22Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6351:EE_|PH0PR12MB5420:EE_
x-ms-office365-filtering-correlation-id: 73ba7118-bdac-47fc-0482-08dbaa01110f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6DW5Ay1MxexBR1E7hztfcmH7+nAV8RRruOeGng6exBQr8OckluBFyKjAb9syhqwA9wltEt9kimsowD0pet3YzkGDc1zOJ80h+8Vg/nPeW1U9yeCCiWXXbJZtjtF1BxtO5J5qOufOHA21E6C0cLdeE5ctk82c55reSZKPTGgqiMTSXDAbUL6pqReO0+ezCPCMfgDOWUoY4zJbYBz/6NkqgjL3/Oe+1uGmstPqtC/3o1P8WRRTY1bWyoT+EK7NeuBMGQcHWC/gVswPPEmfPo9uhuYW320cKHdW1XmkPuGpU/RG/gl2G6ClIF1Q2hFj4EAV2BJiOyTy3xQ0r9zFWRUibW+9wHV0/dmBB44fydzd8eT7J7RI/ArltVUHainUNOityZy5lvgVklf0J3w8qNHkyiLhr1yfuzHHCHRJYLvtQgXA6Mo/G1lfyizMRc5VJ+d1VHqDwNxA/JAxyZTeS4bxB3CEDMkl7XpUDNjbeDlG6lhfdwB/6ghojB/2uDhcKngOc63EcX+7VRZ9fw3/YFYyK7lX7t5tlhs5LzodctJIxScynGNRldmDYVxtO9skiWCxADLh0j6hca+15MNh91d3bBdvMYFOZmBqIuaOlCkG26k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199024)(1800799009)(186009)(9686003)(38100700002)(41300700001)(316002)(38070700005)(8676002)(4326008)(33656002)(2906002)(55016003)(52536014)(86362001)(5660300002)(83380400001)(26005)(6916009)(8936002)(71200400001)(66476007)(966005)(66556008)(7696005)(66946007)(64756008)(6506007)(66446008)(54906003)(53546011)(478600001)(76116006)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yWtisxNh3rEFpZfPw63iSmxrz1A6qa4nKCz2s4GnOTv2HVNMmkIKcWoaA8?=
 =?iso-8859-1?Q?WWHGifJrEqY83MY2//rIenCDqCbb3eHT6D7VJi0k57mMYHvCIckaSFM2xu?=
 =?iso-8859-1?Q?nbnVfrMBXo66m8qFX1hR+MZRaZ5m4KHGPN0RiR3HKzfMDRTNhjXKaELNEr?=
 =?iso-8859-1?Q?rGrBQR1vjfRG+1lHcmWAJTWq4ZCsskxrwiRtehem4yhFnTddRQDoYEcS4S?=
 =?iso-8859-1?Q?eEEVCSJj6WQUSrZn+CzEC7geOfW3OlRffeYwDg7NPB7MVQMf6xat1kpWst?=
 =?iso-8859-1?Q?P+B49JzwJvw3TZHzCkuf9Vl1ekSkFrlllHfuw+6Wz0fiyYNd3p2QpoogjN?=
 =?iso-8859-1?Q?51pYAzVGBYkPY/qOTuPNXqCpPwGHGeHKfbXzb68Wd6YKKvHmJlqQ7jzrtX?=
 =?iso-8859-1?Q?0tpvaVd1RAbdZnNXzCOJrmzmhspmjOQ9TQeoU2FqHOVuwFGUzj4Xxizyk/?=
 =?iso-8859-1?Q?mpfP6KvoNhPyJtcbK+nGaVBZd8PFk19kEipNY/l6qtRzBXSOghcqoCCwod?=
 =?iso-8859-1?Q?DoaLq5FMbjOfPzAGhHhSTLi+f6G9Zr4sjD3twuOjVHv9gqpwu9tgtmpyJj?=
 =?iso-8859-1?Q?ily/NzFxuRNPQ1SfsM+cGy/4kY+cvqjni8pexlCIS+REHTHm9/2AGlNqMV?=
 =?iso-8859-1?Q?uEjU7F0fB+mf5zMmYgLbTMyiwpNdpDCj+Gbgl8YuO9CZixYhZ96wx6kfc6?=
 =?iso-8859-1?Q?PnyHfEL0B5/j79Cl0wU0pCUqTiYUay27si5jpSqmA6JrPsi42smuXvkqsD?=
 =?iso-8859-1?Q?hVVu6OyCxptb42xQMSIbWnWUHzZCIRER9hwgn+DNzWUHBFvHrZ0pLT/W3v?=
 =?iso-8859-1?Q?IxdWgb1qLlFN1dFzKCqlITKdbjwWaB2SiQbpVvDjD7Hw4YnUVs3FmetAXO?=
 =?iso-8859-1?Q?E/D4bhtzBS9OK+3CaE2aBWOqSmuXqgsEumNunoSSEht1TukrM89veZiEZY?=
 =?iso-8859-1?Q?by6t7Ff+e6nMvn35/h780qvSlfvq8wogq2OahpEUxfmyDzahlbgFqUU4nF?=
 =?iso-8859-1?Q?KmhVK00nx+m0twfXDyJtu8u0s6wcoBNj0ya+jgWJMhJeYAgc6gakorJbI7?=
 =?iso-8859-1?Q?P8SZOxPdpb/xH7EQWhBwMglYq6Qkh+4t9Kw6RMocgNUB2t2wdiCScy4VQT?=
 =?iso-8859-1?Q?68gbXX0jvrT1/phZ/Fn4pMc5XxV0XYLAHvBpPC2pEwzi7hJ7ifCRth4nzj?=
 =?iso-8859-1?Q?a4SplgnTRA2Y5WxEf3lI7BMq7VLP01lIM9g25E7j9Cq5FJmgt01E5qEaaU?=
 =?iso-8859-1?Q?SXNt7bfMZHgw5/u86EBaLyh7HEJERwaTm/6+YOLMEaJkPIFnejNy/RS9ya?=
 =?iso-8859-1?Q?1HyZIiTRqb2gFAuykQldJpibrnLp3Cf927iySBexPLCjH1wB11WDLx+KwG?=
 =?iso-8859-1?Q?zGn7qEJM46SGyUb6NIUF48B36oheoFZDMO3JIm+2OYoNpH4GiMy0MCKdYX?=
 =?iso-8859-1?Q?E1oUPUT878YXCmJAkJPoL3laLmKz9PBzkBSPtMZm/0VLiF31OhUmBXMwRK?=
 =?iso-8859-1?Q?EVrui5YURf4LtXTQa6PeiHUDrGp5ase3+DBHWoEEB1Ai6VChrq7riM++DW?=
 =?iso-8859-1?Q?/dNeVEZ+0bT6b861vY9nOJNGj3YwYjc+EcXCcNcq/pnOGPjPc0vgiLVjCT?=
 =?iso-8859-1?Q?pCiPUpMuXq0fY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ba7118-bdac-47fc-0482-08dbaa01110f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 09:02:56.0637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gGywdvnvNKFvdAp3pFdsmclu29C8DGPMnFy0ReKR7QtCs8/5kk4MyV5Wwqn9zwkvA/FAOPERMFjamWat1HmJlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5420
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[AMD Official Use Only - General]

Hi Rene:

> -----Original Message-----
> From: Rene Rebe <rene@exactcode.com>
> Sent: Tuesday, August 29, 2023 5:35 PM
> To: Meng, Li (Jassmine) <Li.Meng@amd.com>
> Cc: Huang, Ray <Ray.Huang@amd.com>; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org; x86@kernel.org; linux-acpi@vger.kernel.org; Shuah
> Khan <skhan@linuxfoundation.org>; linux-kselftest@vger.kernel.org;
> Fontenot, Nathan <Nathan.Fontenot@amd.com>; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; Du,
> Xiaojian <Xiaojian.Du@amd.com>; Viresh Kumar <viresh.kumar@linaro.org>;
> Borislav Petkov <bp@alien8.de>; Meng, Li (Jassmine) <Li.Meng@amd.com>;
> Karny, Wyes <Wyes.Karny@amd.com>
> Subject: Re: [PATCH V4 3/7] cpufreq: amd-pstate: Enable AMD Pstate
> Preferred Core Supporting.
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> Dear Meng Li and team,
>
> thank you so much for working on finally bringing AMD preferred core
> scheduling to mainline Linux!
>
> > The initial core rankings are set up by AMD Pstate when the system
> > boots.
>
> I tested this patch on our Ryzen 7950x and 5950x systems and could
> unfortunatlely not find any performance differences. I therefore took a
> closer look and as far as I can tell the conditional for the initial pref=
erred
> performance priorities appears to be reversed. I marked them down below. =
I
> also attached a patch for the fix. With that fixed I can measure a 0.7%
> improvement compiling Firefox on 7950x. I wonder slightly how this ever p=
ast
> testing before, ...
>
> I think it would be a good idea to always expose the hw perf values in sy=
sfs to
> help users debugging hardware issues or BIOS settings even with percore n=
ot
> enabled and therefore not using the unused 166 or 255 values anyway.
>
[Meng, Li (Jassmine)]
I will add a new sysfs attribute for the highest performance of preferred c=
ore.


> With that fixed, however, Linux is still not always scheduling to preferr=
ed
> cores, but that appears to be an independant limitation of the current li=
nux
> scheduler not strictly using the priority for scheduling, yet. With manua=
l
> taskset guidance I could further improve the Firefox build time by some
> more seconds to over 1% overall performance improvement, if the linux
> scheudler would more reliably schedule minute long running rust lto link
> tasks to the preferred cores and not some mediocre ones.
>
>
> > -     highest_perf =3D amd_get_highest_perf();
> > -     if (highest_perf > AMD_CPPC_HIGHEST_PERF(cap1))
> > -             highest_perf =3D AMD_CPPC_HIGHEST_PERF(cap1);
> > -
> > -     WRITE_ONCE(cpudata->highest_perf, highest_perf);
> > +     if (prefcore)
> > +             WRITE_ONCE(cpudata->highest_perf,
> AMD_PSTATE_PREFCORE_THRESHOLD);
> > +     else
> > +             WRITE_ONCE(cpudata->highest_perf,
> > + AMD_CPPC_HIGHEST_PERF(cap1));
>
> Conditional reversed, assigns THRESHOLD if enabled!
[Meng, Li (Jassmine)]
The highest_perf is used to calculate the frequency value.
The values between 166 and 255 represent priority, not the highest perf.

>
> >       WRITE_ONCE(cpudata->nominal_perf,
> AMD_CPPC_NOMINAL_PERF(cap1));
> >       WRITE_ONCE(cpudata->lowest_nonlinear_perf,
> > AMD_CPPC_LOWNONLIN_PERF(cap1)); @@ -318,17 +322,15 @@ static int
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
> > +     if (prefcore)
> > +             WRITE_ONCE(cpudata->highest_perf,
> AMD_PSTATE_PREFCORE_THRESHOLD);
> > +     else
> > +             WRITE_ONCE(cpudata->highest_perf,
> > + cppc_perf.highest_perf);
>
> Same here. Not using highest_perf if enabled, ...
>
> Signed-off-by: Ren=E9 Rebe <rene@exactcode.de>
>
> --- linux-6.4/drivers/cpufreq/amd-pstate.c.vanilla      2023-08-25
> 22:34:25.254995690 +0200
> +++ linux-6.4/drivers/cpufreq/amd-pstate.c      2023-08-25
> 22:35:49.194991446 +0200
> @@ -282,9 +282,9 @@
>          * the default max perf.
>          */
>         if (prefcore)
> -               WRITE_ONCE(cpudata->highest_perf,
> AMD_PSTATE_PREFCORE_THRESHOLD);
> -       else
>                 WRITE_ONCE(cpudata->highest_perf,
> AMD_CPPC_HIGHEST_PERF(cap1));
> +       else
> +               WRITE_ONCE(cpudata->highest_perf,
> + AMD_PSTATE_PREFCORE_THRESHOLD);
>
>         WRITE_ONCE(cpudata->nominal_perf,
> AMD_CPPC_NOMINAL_PERF(cap1));
>         WRITE_ONCE(cpudata->lowest_nonlinear_perf,
> AMD_CPPC_LOWNONLIN_PERF(cap1)); @@ -303,9 +303,9 @@
>                 return ret;
>
>         if (prefcore)
> -               WRITE_ONCE(cpudata->highest_perf,
> AMD_PSTATE_PREFCORE_THRESHOLD);
> -       else
>                 WRITE_ONCE(cpudata->highest_perf, cppc_perf.highest_perf)=
;
> +       else
> +               WRITE_ONCE(cpudata->highest_perf,
> + AMD_PSTATE_PREFCORE_THRESHOLD);
>
>         WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
>         WRITE_ONCE(cpudata->lowest_nonlinear_perf,
>
>
> --
>   Ren=E9 Rebe, ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
>   https://exactcode.com | https://t2sde.org | https://rene.rebe.de
