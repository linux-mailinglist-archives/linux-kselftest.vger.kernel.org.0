Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E21787D62
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 03:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238900AbjHYB6x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 21:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjHYB6Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 21:58:25 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329D9E4E;
        Thu, 24 Aug 2023 18:58:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STyGtmD0jwB7lJgZ1iOxJkXERlMLDxxBqvlTrjZo/HspGg9ZK37djaGAg0KuCOgnw453kwW15RJNi/6yIFOyCyIVBbChudiDkqUZHCZ5+LePo7zT/TAHoPFS6cLjl+XY1GBOZG4Q/Vc0gAp51gP08dKZl5bCCeA5IepD97Qjggsos39LkgVef1CWj2BZ6G0Ch8eWZwr6flYKS4zVJHXD9a6Sp241DX/Sy8MzNXPRxzIRmDYWq4AjqWWUM+2PgVdShE+sV4wHJr8pZ1yripNAGKLm+3j+MG2HYOx+d11rJiladVOlcSuRVOf3lUefj5rm0DkPd1KACkhBe7TluEqA2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AR0TNJCPCIw3sfIgQQEwNQQhKvgP1lkNhCuInE4GNRk=;
 b=d907HgJfNWd0zBoPvC/K1HnPZWXusl/NfMxGkszUtlP0PJECYBsMSXwuffLSLJcCBwG17Tk8qHZf8sVK9WYpX3KngxAeIAPpSU4AoGj0lqfJj5nMQQe25CzwM8pAaA/DPz+WmeU4YVpe858kYsEN/uz4fwINGZ0zYvU3uvoFVnwQCSwnta3gulOrzJxxcqcEXcwALUxkBxXN/7VT/0ifJOjnwJwfZ4a5ziwSps9lP1kqFcoKd7HcguKMFkeIGic3C+jg0gOD9TiDWkfKnLLj7AooyH4wZ5CGGFa752CJhGLOe4Dm59GijvuUYdPQilBJN/2lH8s4r2mRc8yEg/C6ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AR0TNJCPCIw3sfIgQQEwNQQhKvgP1lkNhCuInE4GNRk=;
 b=Yob6G1k2osLIUtPupn9oUQYMc5rpVy3qqptdy6rOhDtXW52NCBUernUu34y66NiD24WUA4QL+RTjDeYVrVf2+RDm6eE1D+9xHjtpGr240Id2bRY1Md0K8l7dX2trbquPgDxGvDskW+pwhqsw6m8wJqkch5VRDRuslU6haxSfhOQ=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 MN2PR12MB4502.namprd12.prod.outlook.com (2603:10b6:208:263::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 01:58:19 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::d713:8aa1:8769:af10]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::d713:8aa1:8769:af10%7]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 01:58:19 +0000
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
Subject: RE: [PATCH V3 3/7] cpufreq: amd-pstate: Enable AMD Pstate Preferred
 Core Supporting.
Thread-Topic: [PATCH V3 3/7] cpufreq: amd-pstate: Enable AMD Pstate Preferred
 Core Supporting.
Thread-Index: AQHZ1jCz/8rbohNb0USR2LHG8e7XyK/5AZAAgAE/coA=
Date:   Fri, 25 Aug 2023 01:58:19 +0000
Message-ID: <DM4PR12MB6351253AD088DCF862C0B675F7E3A@DM4PR12MB6351.namprd12.prod.outlook.com>
References: <20230824021249.271946-1-li.meng@amd.com>
 <20230824021249.271946-4-li.meng@amd.com>
 <20230824063803.ryqf6uet3yhxiiak@BLR-5CG13462PL.amd.com>
In-Reply-To: <20230824063803.ryqf6uet3yhxiiak@BLR-5CG13462PL.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8fba828b-4ace-4cf7-a160-9f58514d1705;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-25T01:51:41Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6351:EE_|MN2PR12MB4502:EE_
x-ms-office365-filtering-correlation-id: 7042a99a-2761-470e-bb2f-08dba50ec126
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DZw1PLfshgh1dxPUcOzlDiLegQSNo4dG6R5f09hHCfhTPMVZzbM8mQONY9VD0VA9fN1ykJ76ahEwJxMbI0NhKN91/NMu0ASTZhgXb/spVn9zmw+AA/6LzCMqKYDrc/pCC+anG0lUxKyTb1Phk8whlxX7uqt/biSURa1NdvE5RhfXwnNwmS6Y61es2X+MkTcEP4jzrAstfiMPYSIRYF9ksFT73coXQtpGuHv3w7if/zUmIRHLkdLlUysZ7mbzmw3jomMj2rE/hdwhY97JLRGxiQnI5jYEyyyglMIsMXU3h8KyxECaf375dbGecOmWmJhAHhUntrnt2Url779+wHrAAHNXVHQ13dFoFLxP+eGPBB3TOIqpEx87KJ3Qw5k10iiVMbOgbnQgP3Tdj/T62qWkxvhJ70UDB5gHDuEHqAf+rRPQjtqbtyTi8rnLhnPzqnoJnDhVfW13SKcCxHNbgcdqndpPTyL0Uyi8ULxauiIL7jCp/x4YCQASKVx6tAQOkr6HtlX6QZ5FVn3CiF7SI/eur81OxDMRdYD9g2IpJytBjQhU1ufaqiXAPT2F2W4FOxbVzVBR/yuXbI6HXnMhfrdSj66GUvon7W/YgmMTGmpMlIvCHgMAVhVSc1JEKlNFavJY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(451199024)(52536014)(5660300002)(4326008)(8676002)(6862004)(8936002)(83380400001)(33656002)(7696005)(55016003)(26005)(71200400001)(38100700002)(38070700005)(122000001)(76116006)(66556008)(66946007)(66476007)(66446008)(64756008)(54906003)(6636002)(316002)(478600001)(53546011)(41300700001)(9686003)(6506007)(2906002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fdd10doCRFkWtqDIB5BMSQnMoV0JP4wdPzPq9z1+UsuRqfmFSgz1UaqKIVhh?=
 =?us-ascii?Q?5t9aVa4pKFiWU8gSt1jpn7ORk/JSYZo7pAWzhkbwXIgU7d5+irYj/YjCYHpl?=
 =?us-ascii?Q?E82OreSY29kkPiHWIecyshjC4/+R6uQGKpPuF4b/m1MsuO1NA1SGN78CqmYD?=
 =?us-ascii?Q?rkzA8M/DChXJV0/gigzYDE8hJbu8NPBWtwN+s7yR5t3gwuOsV6X+sF9ScbAo?=
 =?us-ascii?Q?gXxDIDPNWChLnhH5biuvSXhVikZ/Tl/510IHE4ijqRt/d0Vf3VcZ6X31OYRl?=
 =?us-ascii?Q?niMmXWo9acZ9GQhsOcDAd/xuWoPxfp4E0i3gvgJBIE5toeCEyIOw70JfSKPJ?=
 =?us-ascii?Q?l/EDuHUpv0m4rCd1QoZiYL0XKKidr8MVqASU5vPuw2llY+TzgLh4ICp2IqhQ?=
 =?us-ascii?Q?zSF5FWlBEtJfl+yItC+mpgqGZa4LmoCJJBgAfNcOibZtL0SEexeNeCG/iaEH?=
 =?us-ascii?Q?uR+VikXwmM1V5cXN2yadI9I7vv1UmNfFN5rxqeJ2Xq7L+eJouDHNqv3O6ogz?=
 =?us-ascii?Q?Lv/6Lr0fmVyQG2wnp4xJzgAJ2QDMQSrFlIiOxRRDiDC0JLRxDCyya8M+3Tfh?=
 =?us-ascii?Q?RTLhR9PCBipZldFq/99M7QK0qwRkgl5oop7deyX+yrFd7++ELAmX4DdjieHZ?=
 =?us-ascii?Q?Bi2aLemnbz1ScH6TsU41sxLBgPgUki/hwjJgYxjOwN2XU9zu/9beqr0Qxmoo?=
 =?us-ascii?Q?ikxU5UqX3i2Ju6LmzWCeF4tfSoYVtgh6YG6ADfJ99dfoX4aXVWjg7bg80Qex?=
 =?us-ascii?Q?aAIE8M67fnTM1jMo2h6P/yAsHN8XSOMhAxxZd3y7HiEhT3XMYEg6r8OEGWds?=
 =?us-ascii?Q?/3PABHj4ctIhyLufEkE5P3jtAZRauNByE1d/pj9UieJYD4qXZIIhbM6ShtDw?=
 =?us-ascii?Q?GMmn87MLcNjEGHMHaA+/wzSCX31PrO39lLYFw/WSiwBJxkREJ9iBjBgWa2S6?=
 =?us-ascii?Q?jiBbx2CyM3A9ooM4zpF12ttiq6GX5LDe4RXW2+h4/EhVzJUZo7FytPWlc8eE?=
 =?us-ascii?Q?9psGpzdFNz5J2K25jebHkB5//j2QyJT3oZmhA6Tt9/g7Ult9ts8QMlwxWOz1?=
 =?us-ascii?Q?nIHO4bCGY9VqJc89yXM/tUfDufCArPde4YHl/hyFo5py7rubHQX9cRo0Srvu?=
 =?us-ascii?Q?E9ahy97qMZOUP+Mgw8amKQV7RXRyxKJCPRQRPxiTsE/99PoQgxi8P2bRcYiI?=
 =?us-ascii?Q?wrohqHUgbo0dW5didIPg8RJ8UDAP7Ha0jIQi3YlpKJft5JwgVHnW8ajfECiA?=
 =?us-ascii?Q?DltI3ur8QSzULSSh4NA7PrBp+YGM8WNpkuIwtaL5WlzK9cJ5yMJEE0vT10Dt?=
 =?us-ascii?Q?BwECHO8vP1fxdIpFZoyEAsMgu0kf+uAjDntK8D0w0O8EkW6fpHFtgJ0FU2yD?=
 =?us-ascii?Q?EKNonyZqVIvjbluhiM3bNqgnSJvPOgIcItJdXyzZg4rGYbQLJLCVfhiG+wiG?=
 =?us-ascii?Q?kniWARI9BK9GxzFmtPM5pTfo6EZtO6OKuE5DahJjnjRVeNeDFZApfzttOYlz?=
 =?us-ascii?Q?sfVhr8C6YtacB/a9vxip/IE4LUCn6H0J0zSNuQIVlKoDVjJ7SkTyAJcTnhnC?=
 =?us-ascii?Q?3PSnary23EpvlaD9cLE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7042a99a-2761-470e-bb2f-08dba50ec126
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 01:58:19.0956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sgSTIouxu2mMvfwAwtVwt1Q/F86CP31ApjuzsxdoAD47FYn/ptAJXIrvkd9m8CMUvd2BLu+WscGIM/Mq9Qp3uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4502
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

Hello Wyes:

> -----Original Message-----
> From: Karny, Wyes <Wyes.Karny@amd.com>
> Sent: Thursday, August 24, 2023 2:48 PM
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
> Subject: Re: [PATCH V3 3/7] cpufreq: amd-pstate: Enable AMD Pstate
> Preferred Core Supporting.
>
> Hi Meng Li,
>
> On 24 Aug 10:12, Meng Li wrote:
> > AMD Pstate driver utilizes the functions and data structures provided
> > by the ITMT architecture to enable the scheduler to favor scheduling
> > on cores which can be get a higher frequency with lower voltage. We
> > call it AMD Pstate Preferrred Core.
> >
> > Here sched_set_itmt_core_prio() is called to set priorities and
> > sched_set_itmt_support() is called to enable ITMT feature.
> > AMD Pstate driver uses the highest performance value to indicate the
> > priority of CPU. The higher value has a higher priority.
> >
> > The initial core rankings are set up by AMD Pstate when the system
> > boots.
> >
> > Add device attribute for preferred core states.
> >
> > Add one new early parameter `enable` to allow user to enable the
> > preferred core if the processor and power firmware can support
> > preferred core feature.
> >
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > Co-developed-by: Perry Yuan <Perry.Yuan@amd.com>
> > Signed-off-by: Meng Li <li.meng@amd.com>
> > Co-developed-by: Meng Li <li.meng@amd.com>
> > Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 120
> > ++++++++++++++++++++++++++++++-----
> >  1 file changed, 104 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index 9a1e194d5cf8..d02305675f66 100644
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
> > solution @@ -65,6 +68,9 @@ static struct cpufreq_driver
> > amd_pstate_epp_driver;  static int cppc_state =3D
> AMD_PSTATE_UNDEFINED;
> > static bool cppc_enabled;
> >
> > +/*Preferred Core featue is supported*/ static bool prefcore =3D true;
> > +
> >  /*
> >   * AMD Energy Preference Performance (EPP)
> >   * The EPP is used in the CCLK DPM controller to drive @@ -290,23
> > +296,21 @@ static inline int amd_pstate_enable(bool enable)  static
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
>
> Can we disable `preferred core` in HW? If not then when we disable
> `preferred core` in software (via the cmd line param you have created), H=
W
> still gives core ranking through highest perf register/MSR. So, we have t=
o
> filter the core ranking info form the highest perf register/MSR and set
> cpudata->highest_perf accordingly. IMO we should have two variables, one
> which indicated HW support and other one which indicates SW overwrite. In
> this function we should be checking only HW support.
>
[Meng, Li (Jassmine)]
We use one variable 'prefcore' to check whether the `preferred core` is sup=
ported.
When either HW or SW does not support `preferred core`, it will be set to f=
alse.
When 'highest_perf' is 255, it indicates that HW does not support `preferre=
d core`.

> >
> >     WRITE_ONCE(cpudata->nominal_perf,
> AMD_CPPC_NOMINAL_PERF(cap1));
> >     WRITE_ONCE(cpudata->lowest_nonlinear_perf,
> > AMD_CPPC_LOWNONLIN_PERF(cap1)); @@ -318,17 +322,15 @@ static int
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
>
> Here also we should be checking only HW support.
>
> >
> >     WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
> >     WRITE_ONCE(cpudata->lowest_nonlinear_perf,
> > @@ -676,6 +678,72 @@ static void amd_perf_ctl_reset(unsigned int cpu)
> >     wrmsrl_on_cpu(cpu, MSR_AMD_PERF_CTL, 0);  }
> >
> > +/*
> > + * Set AMD Pstate Preferred Core enable can't be done directly from
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
> > +/**
> > + * Get the highest performance register value.
> > + * @cpu: CPU from which to get highest performance.
> > + * @highest_perf: Return address.
> > + *
> > + * Return: 0 for success, -EIO otherwise.
> > + */
> > +static int amd_pstate_get_highest_perf(int cpu, u64 *highest_perf) {
> > +       int ret;
> > +
> > +       if (boot_cpu_has(X86_FEATURE_CPPC)) {
> > +               u64 cap1;
> > +
> > +               ret =3D rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap=
1);
> > +               if (ret)
> > +                       return ret;
> > +               WRITE_ONCE(*highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
> > +       } else {
> > +               ret =3D cppc_get_highest_perf(cpu, highest_perf);
> > +       }
> > +
> > +       return (ret);
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
> > +                   prefcore =3D false;
> > +                   return;
>
> 255 is a valid core ranking right?
>
> Thanks & Regards,
> Wyes
>
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
> > -1037,6 +1105,12 @@ static ssize_t status_store(struct device *a, struc=
t
> device_attribute *b,
> >     return ret < 0 ? ret : count;
> >  }
> >
> > +static ssize_t prefcore_show(struct device *dev,
> > +                              struct device_attribute *attr, char *buf=
) {
> > +   return sysfs_emit(buf, "%s\n", prefcore ? "enabled" : "disabled"); =
}
> > +
> >  cpufreq_freq_attr_ro(amd_pstate_max_freq);
> >  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
> >
> > @@ -1044,6 +1118,7 @@ cpufreq_freq_attr_ro(amd_pstate_highest_perf);
> >  cpufreq_freq_attr_rw(energy_performance_preference);
> >  cpufreq_freq_attr_ro(energy_performance_available_preferences);
> >  static DEVICE_ATTR_RW(status);
> > +static DEVICE_ATTR_RO(prefcore);
> >
> >  static struct freq_attr *amd_pstate_attr[] =3D {
> >     &amd_pstate_max_freq,
> > @@ -1063,6 +1138,7 @@ static struct freq_attr *amd_pstate_epp_attr[] =
=3D
> > {
> >
> >  static struct attribute *pstate_global_attributes[] =3D {
> >     &dev_attr_status.attr,
> > +   &dev_attr_prefcore.attr,
> >     NULL
> >  };
> >
> > @@ -1506,6 +1582,8 @@ static int __init amd_pstate_init(void)
> >             }
> >     }
> >
> > +   amd_pstate_init_prefcore();
> > +
> >     return ret;
> >
> >  global_attr_free:
> > @@ -1527,7 +1605,17 @@ static int __init amd_pstate_param(char *str)
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
