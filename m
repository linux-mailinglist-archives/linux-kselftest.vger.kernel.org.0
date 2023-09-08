Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A737982C3
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 08:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242304AbjIHGyS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 02:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242254AbjIHGyQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 02:54:16 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B439E1BD8;
        Thu,  7 Sep 2023 23:54:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+2xWoiIqeslTZZeB7MPQPS6Liq2hY689CHLTtSQbwXCOv3QwPdOTMbk0ww+ROt/Ecp7ZW/M+Qc9p1Q8ChNiVPPTRZbHNg7uHIhrY8W7iE+tUzZr1J9CyVeAczYgVb2oSrVLzY7VZEWFhG+apGSp3vWRir/BVQ47eogXmVy3p9uoD/Djm+ReIu4kwrmE5CY2FXRsqDQE8yvK4IdSN8grRuqCf4pxQU/uBvZ0rTCO7LikFoEq3FMW82uE3vF48LMjG7XmAqwzDk6VeK9N5QINYBCvConcWf8PSEaAHDtET6JUF+Wfon+lREvcupX9FWjYyMrER3ShCcBvcU4YkywOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8Tg6hAM+J+UMIfGdD2gB+Eb/ULmEkyI4o1woFlkMVo=;
 b=JTXN9OFTL30KvYDR0k33Mrq+ZKY8JkiPwVS270kgf9cDiv3JZB6b2gH7y69JLSBN/POVWaGQIB6PI7P3cl/dZaYQatyrqBoyrQAYutLVK6avfhvIvyg7vPRwptW0bKgbMTKDJ3OsKJNvL9GQ4zBcfBwSzzUE1+M1RKlv+xtmV8Ikhkn79k81JqxQyoaK378I1cnqIk2Cm7wISsdPcZt0ThJ+65wQekkrG9/9AR9+JnWU7nP/oiBstLvhVpfcx3pXWj8+SsHIN7yxoi7CAnAS+3nHazl9gVGsJCnLwtqwK5OtrCRYCvL+N/QNcXchRjgmeU+A3dG62oBXtMdcu2EQww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8Tg6hAM+J+UMIfGdD2gB+Eb/ULmEkyI4o1woFlkMVo=;
 b=iHR1MasND1HAW1O+NZeqBSlAbcfLCRSH5CakUeFRHatrx7BsBELDISyGZRxW7GobG/+XgdJlCWnMbJiUGPAHhEplkmIhrZTRxurPYdlg/B7NcQdIYRtVrWb4qKM7gY2DMmOLYXAXh2hX6pAjWHzjWE+msVC1uHXiU4wajHBg3OU=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 CY8PR12MB7267.namprd12.prod.outlook.com (2603:10b6:930:55::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.33; Fri, 8 Sep 2023 06:54:08 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::d713:8aa1:8769:af10]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::d713:8aa1:8769:af10%7]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 06:54:08 +0000
From:   "Meng, Li (Jassmine)" <Li.Meng@amd.com>
To:     "Huang, Ray" <Ray.Huang@amd.com>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
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
Subject: RE: [PATCH V5 3/7] cpufreq: amd-pstate: Enable amd-pstate preferred
 core supporting.
Thread-Topic: [PATCH V5 3/7] cpufreq: amd-pstate: Enable amd-pstate preferred
 core supporting.
Thread-Index: AQHZ35uS8NTpemZxe0Ollcnywf59+LAN06OAgAKrg9A=
Date:   Fri, 8 Sep 2023 06:54:07 +0000
Message-ID: <DM4PR12MB6351A4F9619AF096C88AA460F7EDA@DM4PR12MB6351.namprd12.prod.outlook.com>
References: <20230905015116.2268926-1-li.meng@amd.com>
 <20230905015116.2268926-4-li.meng@amd.com> <ZPiEM+gusure7vKy@amd.com>
In-Reply-To: <ZPiEM+gusure7vKy@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5f462c95-27fa-4a08-b414-f833e07ba351;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-08T06:39:14Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6351:EE_|CY8PR12MB7267:EE_
x-ms-office365-filtering-correlation-id: 8f269e7e-d04f-463a-c2e6-08dbb03865fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bBdRyx7iobpDq6EPiQwBkePJsMXCJuD2Bh53shZ6l0Ua3O40JceQn9icJry0lHODgxCxPKrhsGw6GdBtLsatp4I0+gj7XzQBcpiA06ZAdxj611MZxioO53MDLmWWcCjvwTIWce0RN8IcZIC5h1l45uEitcJIVXy/aamcurFKnRn8eCtRd6Kt75rwMhxLqRTlqGcM7FoIkLVP9uIDgvVpEECri9Pn+GGsYHdSziGDlBL+BAXu9qrvZAwG1t/T0m70Z+4qdvzQdin+yUuyUJTlP56G3tNnQViJJe2nKhmzCr0EvINorcUjv4XQElbwaJd/zZ5Kcw7PCQwSsC4Ts7UHTBdrGe5C8VlG5uY31mwk9OjjvpAlfCCLkExq2KfN5mcW2P4irM9Ks+LseGjP3lt5uaZOWsPeZg/6614fCKRw8mT6cJFn3LRX7CcpIPj00QTHHS7VftZS3yp5MXLXT13TVdmtuwlnFOvw/zNcBWl/BcMvK+tk3YDikvxb8heCoYNv0Fph0tELV9XVN63OmBnkGYYEUov63Rqj7cRzmeIMogcIojI90nXXcjnGqCtZqMGsbjBPnO9YFsTmM971PPPQQbclGA6rDngHqxIaCLBvrb9bVeyOSRiapoL/2I9+FNvX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(376002)(39860400002)(1800799009)(451199024)(186009)(6862004)(5660300002)(8936002)(66556008)(6636002)(2906002)(54906003)(66446008)(64756008)(66476007)(76116006)(66946007)(316002)(8676002)(52536014)(4326008)(33656002)(41300700001)(7696005)(6506007)(55016003)(9686003)(53546011)(26005)(71200400001)(122000001)(38070700005)(38100700002)(478600001)(83380400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NEdydaAjT1SBbj+A2mM3NgCNAU7V+gB2FWlighXbLF1WKaHhC6QTi/Eu2AJF?=
 =?us-ascii?Q?/9dWtNGIFXnfXDMcktcJA+PIYf/NQPZdnEIWFKgquRq+ezXFdBTQglHGVnx2?=
 =?us-ascii?Q?pAMn3S54NYpS7huKXncGY7ddVOVGz0Z34oJm4nSiTnrDJDwn/NccAkONXqE6?=
 =?us-ascii?Q?X7EoAZfDH4zBs7+x7wbQq0iaDmDBWA5hIaZBrShnl2ii6+EMnudcCuDsTmcN?=
 =?us-ascii?Q?myFFA5z7gJ5/yuKEd623XOIHFnK4+9cboD4sSbzTOABRdy6m/r+8nlxwnBE5?=
 =?us-ascii?Q?Sic9qh84ilAFK41bVcrezrKjjCqbK8AckvrRYliC5c7Tk8hVww6wVg27bACx?=
 =?us-ascii?Q?Tbao34Y02FOfxaWf0oHlI0AS6cqef6LDwwDXkHF9eN+faybRZk+uvwj91HFV?=
 =?us-ascii?Q?9X6Mvu/ZXnJUT/P7CeUbbGSMLs+jhrmN60MBXP0Rhjc0Rgl06eHAKMfX7nZh?=
 =?us-ascii?Q?Xg0VVrnr/MlGDzdtp6fXuE4iWMCC/pmXcUVVSiD7BL0c+1Yy4oRscDoZZ+c1?=
 =?us-ascii?Q?sxFqHi8Q4IHuGImhGOSpd10bisz5DEdrcTD7YVpun/M1sTVGSC5AgK4fOM+d?=
 =?us-ascii?Q?TlbVoCksPflGDvoSXLkOJ3rUqgZ4swLXFXcsXuluFz8L1CNX9yu9/6PgaI2L?=
 =?us-ascii?Q?qg3llJ3qYFuCRTffiws9EZ+plHA+LFc1tHMNWBlGM8uicuoxUFQ+YsYVjDQO?=
 =?us-ascii?Q?zJzVKf7M8MvBjeCGiN0NgHoTvb4MDwQqByRSMoGQWv9MGuQ5+f7rCblINfEg?=
 =?us-ascii?Q?uCj5HPdYFDjKTuMC49eSLBNqgO9SVHtUd46j9UcbpJGjcvYHzRX8ZHBLPBsT?=
 =?us-ascii?Q?O6W4uY3IBsL7SngwC2MGZEzh5rnpSbpbV1SV2R/q6XrtM6UlFaPY8qusO3t/?=
 =?us-ascii?Q?387GzN7osg4bYSyhaS2SD8+Dr/WrO/3EG0aN9i0bmzOr76i8T+Z9QtaCn3VO?=
 =?us-ascii?Q?u9GOOA6ohbWyocBHqc6OaDF6OHb81T/pdh9P7tN++K0JUH1sEAvqNxefXYmG?=
 =?us-ascii?Q?1YQfOM8Bk0a1CcniS6+ZDo4mfhxkNXpay6bfEWrksftKZjp8QpvDsfabRuA4?=
 =?us-ascii?Q?8HA/PEXLoJoL3cZPkWrL6LdmaIcY0ggvfowxHNXweTHSsf0vwFuF+9fmJ+U+?=
 =?us-ascii?Q?JPzXDAzzxaS1Ij4MTx3cCdf1YlgaoqtE9GzoG+n694DhCRZRnmT4NWyavWg4?=
 =?us-ascii?Q?T414blS90KXDzfAZuAjFK3+tJzqCsJ6vwMDf3jP1IfyjuGCGJsfufEjbibNc?=
 =?us-ascii?Q?df2atsUAxUO88AIV7+JKOGjScjMI/5F9yjDkaNbmA9A8NnzUlylULTfY+QjQ?=
 =?us-ascii?Q?LyFAvgXdiOOChQJKEnlcdcXTiNAdT28fkiKGSUtjc9Bu6y7llePoD4VfltvJ?=
 =?us-ascii?Q?KXdNV/T+4uqENq91D/HyUV+dxQIO/KcRtFj7VEDAnwjtA5JzEZZ52W49rEBL?=
 =?us-ascii?Q?kwL9yeP8R+aMPj/AeJBrOGfpFNblGNNb9z7OD02wxBacRLrhO8PHxz/UoUNq?=
 =?us-ascii?Q?D16ehZ1uDHVK5hr10UmwFzQxQh9rHyuE0rlD39JDe7tk4sAq0YQDsNdE5OQj?=
 =?us-ascii?Q?aBtZLZ1Jcq8A43ISWxc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f269e7e-d04f-463a-c2e6-08dbb03865fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 06:54:07.8365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WH/3yF4Bemumhp1AaCCPZ2ImuV5ZHrpLUSZnoYaxVQBplve+1mTj0xAxtDu07UtuMucGTxfIZ9vKjJSfHa3rLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7267
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

Hi Ray:

> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Wednesday, September 6, 2023 9:53 PM
> To: Meng, Li (Jassmine) <Li.Meng@amd.com>
> Cc: Rafael J . Wysocki <rafael.j.wysocki@intel.com>; linux-
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
> Subject: Re: [PATCH V5 3/7] cpufreq: amd-pstate: Enable amd-pstate
> preferred core supporting.
>
> On Tue, Sep 05, 2023 at 09:51:12AM +0800, Meng, Li (Jassmine) wrote:
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
> > The initial core rankings are set up by amd-pstate when the system
> > boots.
> >
> > Add device attribute for hardware preferred core. It will check if the
> > processor and power firmware support preferred core feature.
> >
> > Add device attribute for preferred core. Only when hardware supports
> > preferred core and user set `enabled` in early parameter, it can be
> > set to enabled.
> >
> > Add one new early parameter `disable` to allow user to disable the
> > preferred core.
> >
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > Co-developed-by: Perry Yuan <Perry.Yuan@amd.com>
> > Signed-off-by: Meng Li <li.meng@amd.com>
> > Co-developed-by: Meng Li <li.meng@amd.com>
> > Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 131
> > ++++++++++++++++++++++++++++++-----
> >  1 file changed, 115 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index 9a1e194d5cf8..454eb6e789e7
> 100644
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
> > @@ -49,6 +50,8 @@
> >
> >  #define AMD_PSTATE_TRANSITION_LATENCY      20000
> >  #define AMD_PSTATE_TRANSITION_DELAY        1000
> > +#define AMD_PSTATE_PREFCORE_THRESHOLD      166
> > +#define AMD_PSTATE_MAX_CPPC_PERF   255
> >
> >  /*
> >   * TODO: We need more time to fine tune processors with shared memory
> > solution @@ -65,6 +68,12 @@ static struct cpufreq_driver
> > amd_pstate_epp_driver;  static int cppc_state =3D
> AMD_PSTATE_UNDEFINED;
> > static bool cppc_enabled;
> >
> > +/*HW preferred Core featue is supported*/ static bool hw_prefcore =3D
> > +true;
> > +
> > +/*Preferred Core featue is supported*/ static bool prefcore =3D true;
> > +
> >  /*
> >   * AMD Energy Preference Performance (EPP)
> >   * The EPP is used in the CCLK DPM controller to drive @@ -290,23
> > +299,21 @@ static inline int amd_pstate_enable(bool enable)  static
> > int pstate_init_perf(struct amd_cpudata *cpudata)  {
> >     u64 cap1;
> > -   u32 highest_perf;
> >
> >     int ret =3D rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
> >                                  &cap1);
> >     if (ret)
> >             return ret;
> >
> > -   /*
> > -    * TODO: Introduce AMD specific power feature.
> > -    *
> > -    * CPPC entry doesn't indicate the highest performance in some
> ASICs.
> > +   /* For platforms that do not support the preferred core feature, th=
e
> > +    * highest_pef may be configured with 166 or 255, to avoid max
> frequency
> > +    * calculated wrongly. we take the AMD_CPPC_HIGHEST_PERF(cap1)
> value as
> > +    * the default max perf.
> >      */
> > -   highest_perf =3D amd_get_highest_perf();
> > -   if (highest_perf > AMD_CPPC_HIGHEST_PERF(cap1))
> > -           highest_perf =3D AMD_CPPC_HIGHEST_PERF(cap1);
> > -
> > -   WRITE_ONCE(cpudata->highest_perf, highest_perf);
> > +   if (prefcore)
> > +           WRITE_ONCE(cpudata->highest_perf,
> AMD_PSTATE_PREFCORE_THRESHOLD);
> > +   else
> > +           WRITE_ONCE(cpudata->highest_perf,
> AMD_CPPC_HIGHEST_PERF(cap1));
> >
> >     WRITE_ONCE(cpudata->nominal_perf,
> AMD_CPPC_NOMINAL_PERF(cap1));
> >     WRITE_ONCE(cpudata->lowest_nonlinear_perf,
> > AMD_CPPC_LOWNONLIN_PERF(cap1)); @@ -318,17 +325,15 @@ static int
> > pstate_init_perf(struct amd_cpudata *cpudata)  static int
> > cppc_init_perf(struct amd_cpudata *cpudata)  {
> >     struct cppc_perf_caps cppc_perf;
> > -   u32 highest_perf;
> >
> >     int ret =3D cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> >     if (ret)
> >             return ret;
> >
> > -   highest_perf =3D amd_get_highest_perf();
> > -   if (highest_perf > cppc_perf.highest_perf)
> > -           highest_perf =3D cppc_perf.highest_perf;
> > -
> > -   WRITE_ONCE(cpudata->highest_perf, highest_perf);
> > +   if (prefcore)
> > +           WRITE_ONCE(cpudata->highest_perf,
> AMD_PSTATE_PREFCORE_THRESHOLD);
> > +   else
> > +           WRITE_ONCE(cpudata->highest_perf,
> cppc_perf.highest_perf);
> >
> >     WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
> >     WRITE_ONCE(cpudata->lowest_nonlinear_perf,
> > @@ -676,6 +681,73 @@ static void amd_perf_ctl_reset(unsigned int cpu)
> >     wrmsrl_on_cpu(cpu, MSR_AMD_PERF_CTL, 0);  }
> >
> > +/*
> > + * Set amd-pstate preferred core enable can't be done directly from
> > +cpufreq callbacks
> > + * due to locking, so queue the work for later.
> > + */
> > +static void amd_pstste_sched_prefcore_workfn(struct work_struct
> > +*work) {
> > +   sched_set_itmt_support();
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
> > +static int amd_pstate_get_highest_perf(int cpu, u64 *highest_perf) {
> > +   int ret;
> > +
> > +   if (boot_cpu_has(X86_FEATURE_CPPC)) {
> > +           u64 cap1;
> > +
> > +           ret =3D rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1,
> &cap1);
> > +           if (ret)
> > +                   return ret;
> > +           WRITE_ONCE(*highest_perf,
> AMD_CPPC_HIGHEST_PERF(cap1));
> > +   } else {
> > +           ret =3D cppc_get_highest_perf(cpu, highest_perf);
> > +   }
> > +
> > +   return (ret);
> > +}
> > +
> > +static void amd_pstate_init_prefcore(void) {
> > +   int cpu, ret;
> > +   u64 highest_perf;
> > +
> > +   if (!prefcore)
> > +           return;
> > +
> > +   for_each_online_cpu(cpu) {
> > +           ret =3D amd_pstate_get_highest_perf(cpu, &highest_perf);
> > +           if (ret)
> > +                   break;
> > +
> > +           sched_set_itmt_core_prio(highest_perf, cpu);
> > +
> > +           /* check if CPPC preferred core feature is enabled*/
> > +           if (highest_perf =3D=3D AMD_PSTATE_MAX_CPPC_PERF) {
> > +                   hw_prefcore =3D false;
> > +                   prefcore =3D false;
>
> I think you should use prefcore which embeds into cpudata structure inste=
ad
> of global variable. Here, actually, you walked through all online cpus, t=
he last
> cpu's status will overwrite the previous one.
>
[Meng, Li (Jassmine)]
The variable "prefcore" is an early kernel param.
User can set it status to enabled or disabled.
I think it cannot be embedded into "cpudata" structure.
> > +                   return;
> > +           }
> > +   }
> > +
> > +   /*
> > +    * This code can be run during CPU online under the
> > +    * CPU hotplug locks, so sched_set_amd_prefcore_support()
> > +    * cannot be called from here.  Queue up a work item
> > +    * to invoke it.
> > +    */
> > +   schedule_work(&sched_prefcore_work);
> > +}
> > +
> >  static int amd_pstate_cpu_init(struct cpufreq_policy *policy)  {
> >     int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> @@
> > -1037,6 +1109,18 @@ static ssize_t status_store(struct device *a, struc=
t
> device_attribute *b,
> >     return ret < 0 ? ret : count;
> >  }
> >
> > +static ssize_t hw_prefcore_show(struct device *dev,
> > +                           struct device_attribute *attr, char *buf) {
> > +   return sysfs_emit(buf, "%s\n", hw_prefcore ? "supported" :
> > +"unsupported"); }
>
> Is there any requirement from user space (cpupower or other tool) to quer=
y
> the capacity at runtime?  In fact, we can simplify the codes that use a p=
rint in
> the kernel to let user know whether current cpu supports prefcore in
> hardware side.
>
> Thanks,
> Ray
[Meng, Li (Jassmine)]
I will modify it to pr_debug() message.

>
> > +
> > +static ssize_t prefcore_show(struct device *dev,
> > +                        struct device_attribute *attr, char *buf) {
> > +   return sysfs_emit(buf, "%s\n", prefcore ? "enabled" : "disabled"); =
}
> > +
> >  cpufreq_freq_attr_ro(amd_pstate_max_freq);
> >  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
> >
> > @@ -1044,6 +1128,8 @@ cpufreq_freq_attr_ro(amd_pstate_highest_perf);
> >  cpufreq_freq_attr_rw(energy_performance_preference);
> >  cpufreq_freq_attr_ro(energy_performance_available_preferences);
> >  static DEVICE_ATTR_RW(status);
> > +static DEVICE_ATTR_RO(hw_prefcore);
> > +static DEVICE_ATTR_RO(prefcore);
> >
> >  static struct freq_attr *amd_pstate_attr[] =3D {
> >     &amd_pstate_max_freq,
> > @@ -1063,6 +1149,7 @@ static struct freq_attr *amd_pstate_epp_attr[] =
=3D
> > {
> >
> >  static struct attribute *pstate_global_attributes[] =3D {
> >     &dev_attr_status.attr,
> > +   &dev_attr_prefcore.attr,
> >     NULL
> >  };
> >
> > @@ -1506,6 +1593,8 @@ static int __init amd_pstate_init(void)
> >             }
> >     }
> >
> > +   amd_pstate_init_prefcore();
> > +
> >     return ret;
> >
> >  global_attr_free:
> > @@ -1527,7 +1616,17 @@ static int __init amd_pstate_param(char *str)
> >
> >     return amd_pstate_set_driver(mode_idx);  }
> > +
> > +static int __init amd_prefcore_param(char *str) {
> > +   if (!strcmp(str, "disable"))
> > +           prefcore =3D false;
> > +
> > +   return 0;
> > +}
> > +
> >  early_param("amd_pstate", amd_pstate_param);
> > +early_param("amd_prefcore", amd_prefcore_param);
> >
> >  MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
> > MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
> > --
> > 2.34.1
> >
