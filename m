Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0091F79A2EF
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Sep 2023 07:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjIKFnB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 01:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjIKFnB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 01:43:01 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A131B8;
        Sun, 10 Sep 2023 22:42:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrbESbiLYB+N63VLfRFeJqFEhq2ccqPwJmoIQ7RtSDpu+XKmAVEKtp9yn9+VehhGpu/Zw/r5rv4Li9ojna39z3wNpEKIfJN9TrSv0RvwyuuhrBMcedAGEo+avNyyf20Yp3jvK7Q7DOV9v14KBq0uvvZJ7ouO0otz1zWuwBcx+oEhPnEGw5tCn5oeCg618EOo58cD+oPAv8+ymlwPFBYwGEDf+u2D3pD9LCA7prvFMFEllSDbAuxE8aa2y8lCZeT4dxqYNQB7LVsGXBy01QrOjYYfBhbnjgd2hJrAr44MC+PSO60hXJqUoIu4L2nwTu+x7uhCEbfAKi5bIH1WhWmSZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gooU+xoYA7SG42oJ8/uCIGX7ii//+ALzntEM1ZAQojs=;
 b=Gkpd+Pm9sfcTdLS705/obZOLtuZyVPFKg4mljGZDkrS2/iMzUUwr4O8G5WQso4ZYtm2KL+USGePIbWmfGGh+HKSXJP9hswSpVTm0xcxSw2I5jCdnQuSmsP70Otd2mQW3+6mibNuTt4SuxRpOw5Cbpla1v1EY/NSHBAxSeKwvFsE1VQ4BGpN4ZECn638jWJjDMFd7Ov9f1uFa4mwhCQvUlXSzOcWsxDyGxoI5SEgfSvXubGderzlrbpc2jMqVO+RL6OuDJAY5Mg8A8FsxNtpzyyL9Us9hzLf4CQi9sWXwkgYpf4T+aylGDL904s4VXptdQ3XaRfM2rgA+pJNxGlmiAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gooU+xoYA7SG42oJ8/uCIGX7ii//+ALzntEM1ZAQojs=;
 b=2di96dLrSgq8J4gaMy2CCRANGT3cAMsIGMjVPIZ9TaPfncvc1ywRvJwosm1EjB2G3F82CcTucNkTTSoBR/i6rf+v53neqBmQs5pEknm3B4Jm6viluLtktpZ7mBIGRN9yykIpBPfJDQt1b4jJy5axxi4D1YqkEqeKarNhcmEhiyc=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 SA1PR12MB8119.namprd12.prod.outlook.com (2603:10b6:806:337::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 05:42:53 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::d713:8aa1:8769:af10]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::d713:8aa1:8769:af10%7]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 05:42:53 +0000
From:   "Meng, Li (Jassmine)" <Li.Meng@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
Subject: RE: [PATCH V6 3/7] cpufreq: amd-pstate: Enable amd-pstate preferred
 core supporting.
Thread-Topic: [PATCH V6 3/7] cpufreq: amd-pstate: Enable amd-pstate preferred
 core supporting.
Thread-Index: AQHZ4ijFhBqhyiTr1EOLCr1wgHOXobASxPIAgAJbeIA=
Date:   Mon, 11 Sep 2023 05:42:52 +0000
Message-ID: <DM4PR12MB6351B968FEB93729E2DACCF0F7F2A@DM4PR12MB6351.namprd12.prod.outlook.com>
References: <20230908074653.2799055-1-li.meng@amd.com>
 <20230908074653.2799055-4-li.meng@amd.com>
 <20230909173950.GA33532@noisy.programming.kicks-ass.net>
In-Reply-To: <20230909173950.GA33532@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=400d3b4f-5cdc-4cf2-b69a-81cec4aadd08;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-11T05:39:43Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6351:EE_|SA1PR12MB8119:EE_
x-ms-office365-filtering-correlation-id: 9eb80223-77d7-48e5-7329-08dbb289f10f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pordnu5wPGpZD+QxXJRE4QSSL+mBuKkm2r8n7X55U8Amxz7doz8W8NsaaDz1l2ZNZ8FFsvsyt05CeBDDn6stuzKHLbxIHM1P4q01A9u3pnqNLmdILtynQjgfckdK9r3Mfq+kDwdmxfoKmTs4O83wMr55qpRVEGVrD4zf8jMp9M5OGQ1Z+ZLyfFGA7MvSQc3ogDSsV7OmQ0ZdIBSEqtmrgpdC/yvn+Nbc3zoTqOrVTqqyfTe1oNZuU4dcGywCN9bTWTbA6wq8MGHVNX/pC7GOu46STMTCdPAICGyMh40J954LJUUsU/vx74w/dP5etUb3V6R8Q2Kqm0c2zCcSXo414yByiK+1ssV7WiEm7eMx137bMb/ya6kiKi2zeq7fuzCEE+sNDJW8OHr4iUK7mKMgghQcf7kj/gb6DpV7/ctzJzHIqn6ReW9V5qnKkYcXobAIqVtRuviRWV6PeOLRSd0rOxCwL4Fg2eCB8N4W8ZU7zF6fUAQmptV5tkHkJ00mHxE5q1cXb3rzjC8goZYbBsFWzZnUqt/GM2IGXOeBvf7zTejARuO5JIGj+bbGuAzFXX6Jv7LUllFXOqwx7qUrID+4+LQ4Gz9anmnRzH1jkbSW95J1XFKG74qxFgDRtVGtIHwN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(186009)(1800799009)(451199024)(7696005)(6506007)(53546011)(9686003)(71200400001)(83380400001)(86362001)(38100700002)(38070700005)(33656002)(122000001)(55016003)(26005)(316002)(6916009)(7416002)(41300700001)(8936002)(2906002)(76116006)(8676002)(54906003)(66556008)(66446008)(66476007)(4326008)(66946007)(64756008)(478600001)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D40NHd84TE5PCVWSSUEaK2KmHwTJqwYmJ8YUH4jp65Xx90Be9iLi8P0Qt3Mk?=
 =?us-ascii?Q?rIRzkEZHzAVjdqTdNn17PxVoyq/rAv/HBfU2fn7nPr5nNRbuWv3UjNOC5d46?=
 =?us-ascii?Q?048GkyAWQmQl4ptm/TVaZFSzr+SjmYqZKCR0mjnyhYFd0a0Njfc5iMBNdEt1?=
 =?us-ascii?Q?y8fcI3F1AiPD9uV4KGv7iTgY1WMZlHVFEMFG0XFCbic6r1bMwNb3k2Txrtat?=
 =?us-ascii?Q?FbKov43hBQPia/ESfiK3GyNQHmDMCFnzDbp6tWAigGxMRS6GEtCfVMbemuMH?=
 =?us-ascii?Q?Wz5/WcqPV9Oig55kXqA9pg+dMCyg0wmT5ylNUKGoBLIGubiOc1n7g0x7CeSA?=
 =?us-ascii?Q?I1ExKZaWQj7V/Aot8M/3bUJbsdEfLDI0hm8TtwoOlIf29l+ComFoIgabUGVq?=
 =?us-ascii?Q?Kf2wnClEH/etqms8BdeZeYADJ/v7UihkjWjhAD57C6pFxQnCwKKo42nHdSIv?=
 =?us-ascii?Q?bBKDIv9Bq6zIbandCN2Yl4RV8ylxBKcN8ir7Me3fAGe7d0pWpW788yR91REw?=
 =?us-ascii?Q?vj7I6hNW/GUTYP7+IHm61XYAnOzurS1gRwVHRXJCiSVjujXzqyDeyV/X5+FS?=
 =?us-ascii?Q?TRASFudfZgJVekbwqVVYdAhFHstyN6eQxQC2EPxE+hb+IwVboRaAvfJ4nJQ/?=
 =?us-ascii?Q?8t47VgniQ2ZpoQr+lnDa4dWuLCTfIj4V1hBEdAqDeG+0eJ3MmJ6epTRExlOk?=
 =?us-ascii?Q?Hqx2X5qqxuRSjJc+jcSAd7v6t276rQIJU0Y8KFxUVuucZMFzFTzbn1RP40E6?=
 =?us-ascii?Q?YdlzVkdEBQP3TrKB2RIwIY5UbOI64gO0EmLD7vmzCw+ZOR8xh6HgVQG1sHlC?=
 =?us-ascii?Q?bhlHYa5B9IGOVG+CRh1kx3HCGahyI6BvZ9IYkZKro045TuRsDgxTF9xtsaRv?=
 =?us-ascii?Q?/G1Ce/xJQjA06k3iFcpnMeIQF+h7GndcCZf+H8Qv+XaV6yCDo8PoGHdYhve8?=
 =?us-ascii?Q?tX6E9g9U5JqZmP+EDxyfJTh15ad+ODXCwqBUV/oGJniDGX1qra/69tZA6WSA?=
 =?us-ascii?Q?P2W90D9LlShFF8pcmFmTFC9+PSRLdUz5D9fovoVAq+I7QQmZeErTBuppyICc?=
 =?us-ascii?Q?OMwh3DJsnk0AUWaBSiE8xtDIXziDA6iGNnWktZ0+sL2XZAg/mgtZLejXkqi3?=
 =?us-ascii?Q?oQ0po2S0qV3W4UD665rI/NRiQ5B/Q6SNDSht7v9/IPSEV5XxOw8lNAKBty1u?=
 =?us-ascii?Q?p1GD3SJjU8L3W4puXU6Z23h55ZxW57CFa0Xf4RMgSnt01xtP1sSL7ixefV+h?=
 =?us-ascii?Q?56jKCdnCL6KnPkteTJZCcaqGto0nlQgZFroOpsh+nQWZDL+QFWKFYesVCVD3?=
 =?us-ascii?Q?p9mMPwN5rCsvg214eZtDugYkUN2ZrY1ZGyhKu2lBB43KAwWbiJB5vBFjqVNC?=
 =?us-ascii?Q?Q65j6Sj0y3kF+wo7n/zJH0beSyXneC5cwAj1KG802fWL+NLE4wznJqtK0kz4?=
 =?us-ascii?Q?lsfwAXknNzpd7hYBGnokw6CMS60kVWZ5gnwrhRCKf3MAQDFaABM38kRYxvwA?=
 =?us-ascii?Q?Os+U+K6s6jPK1o5BELzFmCZxr0TvvsmATD6D8BW02hpI4TUr0Ws+rBfKYws8?=
 =?us-ascii?Q?FQMIeG1Ayc9YDlTJpHg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb80223-77d7-48e5-7329-08dbb289f10f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 05:42:52.7359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y8JYDUXpblXht45kHPaDPFr8xFM+FWq8fKsKkjuljJMwWInTSvt06wlzQgPrx217AZ/HFpAOeuC8XhUiZFs+hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8119
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

Hi Peter:

> -----Original Message-----
> From: Peter Zijlstra <peterz@infradead.org>
> Sent: Sunday, September 10, 2023 1:40 AM
> To: Meng, Li (Jassmine) <Li.Meng@amd.com>
> Cc: Rafael J . Wysocki <rafael.j.wysocki@intel.com>; Huang, Ray
> <Ray.Huang@amd.com>; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org; x86@kernel.org; linux-acpi@vger.kernel.org; Shuah
> Khan <skhan@linuxfoundation.org>; linux-kselftest@vger.kernel.org;
> Fontenot, Nathan <Nathan.Fontenot@amd.com>; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; Du,
> Xiaojian <Xiaojian.Du@amd.com>; Viresh Kumar <viresh.kumar@linaro.org>;
> Borislav Petkov <bp@alien8.de>
> Subject: Re: [PATCH V6 3/7] cpufreq: amd-pstate: Enable amd-pstate
> preferred core supporting.
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> On Fri, Sep 08, 2023 at 03:46:49PM +0800, Meng Li wrote:
> > +static void amd_pstate_init_prefcore(void) {
> > +     int cpu, ret;
> > +     u64 highest_perf;
> > +
> > +     if (!prefcore)
> > +             return;
> > +
> > +     for_each_online_cpu(cpu) {
> > +             ret =3D amd_pstate_get_highest_perf(cpu, &highest_perf);
> > +             if (ret)
> > +                     break;
> > +
> > +             sched_set_itmt_core_prio(highest_perf, cpu);
> > +
> > +             /* check if CPPC preferred core feature is enabled*/
> > +             if (highest_perf =3D=3D AMD_PSTATE_MAX_CPPC_PERF) {
> > +                     pr_debug("AMD CPPC preferred core is unsupported!=
\n");
> > +                     hw_prefcore =3D false;
> > +                     prefcore =3D false;
> > +                     return;
> > +             }
> > +     }
> > +
> > +     /*
> > +      * This code can be run during CPU online under the
> > +      * CPU hotplug locks, so sched_set_amd_prefcore_support()
> > +      * cannot be called from here.  Queue up a work item
> > +      * to invoke it.
> > +      */
> > +     schedule_work(&sched_prefcore_work);
> > +}
>
> Brilliant, repost without addressing prior feedback..  :-(
[Meng, Li (Jassmine)]
I am very sorry that I did not receive your V5 review comments before sendi=
ng V6 patches.
However, thank you very much for your review.
I will solve them one by one in the future V7 patches.
Thank you very much!
