Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CD778E479
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 03:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240480AbjHaBma (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 21:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbjHaBm3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 21:42:29 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CC4CC5;
        Wed, 30 Aug 2023 18:42:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FR4nKqpa5xMNtKo1VhrllJNlY3DYzljXvGpidBAm4S5t6cXpSgE1HXZ+Y/D/7utOmy6X0YjDOr+WvGnaSwo//azHgUzBeK0FTJkKZKjejKEu4k/tTqEhh2WGzNpvpI3vRjLuHY3ihW/Bekwp3x/sF/XICShFABorsTMuEcsavx+AWlhggoO0YjRbG0RrPchdT++oHcKTXP4rGq6My1pftbnTgVbT55vGoT/I5PYvmr8i0nSpe0mbdSzcy4v5qcLMMoY/0KC3w5FDDDoLrPX28hDTk3IzZwB7zhG3i2cy4YtcE5Hh+SBtChnvKw879/+NDRs4V/eGGwcOh0KjE/cIPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOdeKaSc9jGjh0mh28zXcRgoM0IkFfsLSOQWE0mntdA=;
 b=UYLAxWHTH+3baBQu+VSw9CxTfc8eUKPix2fg4lHMvxTY7oCI6qHNNMiUrddZ4aX7gIcojZ5XaqHKZe7NzuiJhUcE5lKjLjNkufuzq3WBjKjsrONjSg9QHSvgfWddr67ObFp6Hl+bW7uM3IWb1U8nEfng4zZCB/iwbnLk2RpyhVtpQHeqpQPppPg36meSRPeZHjIH1eShQMgYSLrCcvT7c7cgGox0q3eGyoxEf8zZHKDiu+0zf2h2DhbcK79JwuR41ipUyppyHXvYey5ydeH3i700pcQDEA2s3LJtEeaCsdwN0BhHsjxSBC/T+E70g6U2c2o023RxkSqi3lHBjA5lGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOdeKaSc9jGjh0mh28zXcRgoM0IkFfsLSOQWE0mntdA=;
 b=lyzM4v/6UHQTlwsUzrYJIx/ZEvic8RYP2XXQb5QVGcceNsje4xEirU0Mb8eEHmF9P7CO5uCdwl5mc1iVg8fBG9oLfMKkACoeQ88eCNjFg93qh04jKp7Wg+7C7JdkOhXgmrgoYL4ncFrgmeKPc+bFETvR50qzqB2/pcApqaeJuV4=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 PH0PR12MB7981.namprd12.prod.outlook.com (2603:10b6:510:26c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 01:42:21 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::d713:8aa1:8769:af10]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::d713:8aa1:8769:af10%7]) with mapi id 15.20.6699.035; Thu, 31 Aug 2023
 01:42:20 +0000
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
Subject: RE: [PATCH V4 3/7] cpufreq: amd-pstate: Enable AMD Pstate Preferred
 Core Supporting.
Thread-Topic: [PATCH V4 3/7] cpufreq: amd-pstate: Enable AMD Pstate Preferred
 Core Supporting.
Thread-Index: AQHZ2kRBKsX4/z87M0i11D78P55WSrAA6XwAgAK4noA=
Date:   Thu, 31 Aug 2023 01:42:20 +0000
Message-ID: <DM4PR12MB6351E836BE12ADC5504BEAAAF7E5A@DM4PR12MB6351.namprd12.prod.outlook.com>
References: <20230829064340.1136448-1-li.meng@amd.com>
 <20230829064340.1136448-4-li.meng@amd.com> <ZO2l1oaqNlV2sCQY@amd.com>
In-Reply-To: <ZO2l1oaqNlV2sCQY@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d52fa28f-292b-4442-b098-21ea0eb538c7;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-31T01:34:43Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6351:EE_|PH0PR12MB7981:EE_
x-ms-office365-filtering-correlation-id: 04a6700c-52a6-4639-a5e9-08dba9c38466
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MvO6vH5akhDE63003PYwS04X1v3BmSp1F8CVm6/shOvAeQ+LXOd1NIv0W9XDCqX/eawfiiDQvLpSwvsdibnxYI8cxNWBUGY8ikOlWaD9epGCD06Ngr82BAnzkZkWPztAei87F/jy1X7Rn2vwXEBbZ4DL/FBG4gDK9BHSVFoyQH40tlZuJLsl0XCVee5TLs42BSAMC6sEZOTdqfWJecaisHGuXnxkNjRpAP688H76zs8kpz4Rg7Z/fGuxq6iGe7/j0P7tongNmamsVTuxkL6o167/Nx4fDgtEAKyTW/p7SMRtcMnGDCzxXnKghHxhpuNvu0Remz6FSOteN88n5jxp6J8jwayoaXHJA9/DGrlKIX1ElMebCax+b1V5ZULEXATQOEEiDKTDjjAbc0npgbvHOoIVx084hF0e2GRTp89+GFBrwX5Cph53LHnB3DdeUXaVeYyjUjDzsmdkEfp+JntrCAQqHBgn2HriRLR8y4+puw9GnQXY9p3LORDVWNMD7eWQsXsqn0gNS3RYeBBerel+hQwGWEYb3u7SvlyeyKRp5DJS+fjAG+ywh6AwLJyBk5zJFWJCAFSjzlLKSW98oyRDdsikS3HocX3hLv+ISg18Bv8tuEna4SKLW94/VrqpgMEt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(376002)(396003)(1800799009)(451199024)(186009)(33656002)(55016003)(83380400001)(52536014)(86362001)(9686003)(4326008)(6506007)(6862004)(5660300002)(53546011)(7696005)(8676002)(8936002)(26005)(41300700001)(71200400001)(478600001)(122000001)(2906002)(76116006)(38070700005)(66556008)(38100700002)(66446008)(66476007)(6636002)(64756008)(66946007)(54906003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5Jj3clgpc+vm1rOv25oulv9NY47y33qGTeJvR5vllf28QqxoY7lswRBYcM92?=
 =?us-ascii?Q?d0UodF/QZqd6tfSeGXHUIrL7LO3y83LLj+/YZDG/b+49vPPHR0Cch0rrcL14?=
 =?us-ascii?Q?Qq1QqQ9vAq3zhSUOPwKlEk/fZBsw3WPSr+Y321h1mOy5gswAg1hbcGoAFJuF?=
 =?us-ascii?Q?BSn/RMuyfQ+cZt7de5x5Bg0WDet/LKOT4hcLSmRk+gUAnaQvob+kjYPzUUWq?=
 =?us-ascii?Q?JHCWjzJS335lzm+xOVgttq9Ji1WR3zAoqdhYqU3hWlsPdSHBZIybVsILv08s?=
 =?us-ascii?Q?F7DO5jOoNQluI7KYOt17ePC/SSZvj9EG0NRN/XN+KGcM42tg9nmtJfX8EcJR?=
 =?us-ascii?Q?Bc55JHqxMm5/W3Vd2Gr+vZiHjVLEQrl7YPcIOWGSO6xkMw2C0TNW3y8WTQ1D?=
 =?us-ascii?Q?TrOBftnZbOZrm+2tOSgdLyI3GR68SG0SR1JKT6yASmD6Xiv+2b2JEvICPy/E?=
 =?us-ascii?Q?H4RfvejeABTagTR7HkUqbyMwuxod+uYty7fhdIZVVVuOjuj/hh5CWt1IO02v?=
 =?us-ascii?Q?X8XSWkh29hsy4fc2JVjGa53mQStVQYERmEAEz8aAGMb5btTybpEUe8Z3S2/z?=
 =?us-ascii?Q?UKIrNP3qCSURsr3jS1kfNRFWWcGrEsdliUfislNbjCSCseBBXtHSBI3bWgO6?=
 =?us-ascii?Q?Y44wr7k/ZX3c103GGlO7yztMZ26yzkMFBYlRshGm9xXjkENZIo79EPTnDgRc?=
 =?us-ascii?Q?10iUlVqTVHTdQiXcbYdjhSih26MQGrJGnbjMsIu5oRqUxA7JALkEOdFTE/2I?=
 =?us-ascii?Q?lMdheZjccqGCFOgXeQIXFhqx6f9fZ3Eru+LFDiQKQ1IM0cvAOCI91KnBaUPJ?=
 =?us-ascii?Q?ornIaZ2O4a5sT/97rATMHIkLjUX9EEjAfk2W1NMutfqFv77qmYfgNGGdqM86?=
 =?us-ascii?Q?TDI2he2Xp9cpWZCUmM7XfwO6BUG9ASb79UY4UzaU9Lwu//1h3hZxJKu2LonD?=
 =?us-ascii?Q?zOkStKatGhbHPR4xp4K9+zmwF6933Mx8QzCnxLJoOU2XAfqdzRzndH0Em0pO?=
 =?us-ascii?Q?gGz+vpURDE05nHXtg5uZxOL80b0lKBdTAOzXDTWNEvgloeEYhAqtva2KjqE8?=
 =?us-ascii?Q?rfS2qCgqqpUwoaOD4GoPb81sgJrx9X4tkdXh3ypLOfDarD8E75fPzcTwE/w6?=
 =?us-ascii?Q?x7HA/+JJtPSMeYqKt3l7C9jQnG9VAoKWIwHMUPwqSG18wenpPyt4HelX/+0m?=
 =?us-ascii?Q?N3YzCZ2F1N9PxUvbxxA7xyCZV0Ig8O+C1GWqp4W5yxn2AvnjSCQeK2o6qtuk?=
 =?us-ascii?Q?ks+pgbTki+eYdt+b0ZUqcwL1BacSXKC40QDRj1KPVrORFIuton+bx4kXNH2w?=
 =?us-ascii?Q?whJnP4WImLF30j2n0UIPsGwgCjVTt9q3WSr5x6MK/TzlT9sTzQOYyOTa3lKX?=
 =?us-ascii?Q?M1PcQDb3mQmnCe51mt4wCxMjE81to2gADDaVKZwSZFFb5AY8Q/H1gRYrjlxb?=
 =?us-ascii?Q?+6+d9HAzKQtVqznlHbNXBsJFROVAKPxd6+3dFfh3VfM5pM/C3FfyQpFXcQhW?=
 =?us-ascii?Q?EH8ttWejq5059+p4V+SAfkA2J20+/tDgKBGxWr72jHWM6xC9n1KkZmS2Yyzx?=
 =?us-ascii?Q?v+WXZEQruCH1jUkUyj8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a6700c-52a6-4639-a5e9-08dba9c38466
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 01:42:20.7916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O/TVny+xaArTBuslMAGPQY7EmzXFFM2RbG6FKU0B6p5CkBVOMlhWtYy0SSXxCGUbC4KOXlN6YDPp32eRCJOa8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7981
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[AMD Official Use Only - General]

Hi Ray:

> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Tuesday, August 29, 2023 4:01 PM
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
> Subject: Re: [PATCH V4 3/7] cpufreq: amd-pstate: Enable AMD Pstate
> Preferred Core Supporting.
>
> On Tue, Aug 29, 2023 at 02:43:36PM +0800, Meng, Li (Jassmine) wrote:
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
>
> You know, the prefercore is a hardware capacity, so we should have a way =
to
> detect current processor whether it's supported. E.X. whether we can read
> highest_perf value is AMD_PSTATE_PREFCORE_THRESHOLD or less than
> AMD_PSTATE_MAX_CPPC_PERF, then set the prefcore enabled.
>
> Thanks,
> Ray
>
[Meng, Li (Jassmine)]
Yes, you are right.
Here we only provide an interface for users to disable preferred core.
Default platform enables preferred core if HW supports this feature.

When HW doesn't support this feature, the variable "prefcore" will be set f=
alse.
Only when Hw support preferred core and users set "enable", , the variable =
"prefcore" will be set true.

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
