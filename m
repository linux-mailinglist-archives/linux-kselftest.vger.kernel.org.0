Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAFB7C9F68
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 08:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjJPGVC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 02:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjJPGU7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 02:20:59 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510A0DE;
        Sun, 15 Oct 2023 23:20:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVbBGAGyuE7Du2gjCYIuHRxp6/xLB0bFwcUATtZXuDoiPLbEIjJnneSNWB6z4E1NRFH0LkxkMeSpO3c98XrboulHX3Yc319wHn3JyldpQ68E8ClgI9QIg/5sn5YMbrZzWEsnxrRy79ChdzAGW5l43I97jddVSiEOhUxbBrAClxBHX7pWwkIaraoytPjKSDJjqQ31SYm3iW+uzsYWiptdmaFqaykJXNmuf+Ub3m2VoFvu036kMZkHUTyfry9Nf/kpHJGGvyiqGmhviSpTL9xPx1hpRk/aEhoUSOerPBdH3yG+/CVDPOE5eaYTGqe0SHKzqcy/juOJ1xLfb/7m4C/IiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0to1Y74iDYiIcR2d00Kj/QV5Tycqv3J6eClhO1rtbGI=;
 b=iox9WHNgSzgwjr4giLYPq8kTOh2XpYfh6ruHzbnM4g/q/WYcwCAEIlBbh/hKCPjIkpcUqNaYvr0pBMePlMfZT/JR5yLlmnBAlIu4cET8DC4LROK0xW/SGtR6o38q5Lk7ZX2FkcBAMvnfDCupQdwBvzWZ6VHse3t1IH5X+IwssVCpon9VmalY/vndLAzkGsmVUjAfvZsG57LairJoqZtueZyQxHAPyJmE2bG8LeiOyk5BxuDx2GAiYbtUDtlhkX9mcZ94ALc6d26e1DUVf0QWtNJWErZNBllxWD8++P3VbHtBIXridOu+9nNVqoa1odO6oga3jxYNUVOfxGGdWHOp1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0to1Y74iDYiIcR2d00Kj/QV5Tycqv3J6eClhO1rtbGI=;
 b=0RuzXhWsGDMeVwEKntnYVRTKc/LWHDFw7+97HYdKzdOtcVpa8mdJwyc3X5rj6ofPuyax025gjrwZEigsP5+r5GT+WMJiAj7KWummbXAlpd77pVXmCHgpbOjN3su5ebz2D/Vuu9asH6OXI14fs1JgEx3xhJcn/Q0hrHc0/Yz0HTY=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 CH2PR12MB4309.namprd12.prod.outlook.com (2603:10b6:610:a4::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.37; Mon, 16 Oct 2023 06:20:54 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::4ead:d69:799a:281e]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::4ead:d69:799a:281e%5]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 06:20:53 +0000
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
        Borislav Petkov <bp@alien8.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        "Karny, Wyes" <Wyes.Karny@amd.com>
Subject: RE: [RESEND PATCH V9 3/7] cpufreq: amd-pstate: Enable amd-pstate
 preferred core supporting.
Thread-Topic: [RESEND PATCH V9 3/7] cpufreq: amd-pstate: Enable amd-pstate
 preferred core supporting.
Thread-Index: AQHZ/YXbRWpJHuQ860GMQa8yy6kr3rBH4gAAgAQJJqA=
Date:   Mon, 16 Oct 2023 06:20:53 +0000
Message-ID: <DM4PR12MB6351E2E9504B57BD40DAE985F7D7A@DM4PR12MB6351.namprd12.prod.outlook.com>
References: <20231013033118.3759311-1-li.meng@amd.com>
 <20231013033118.3759311-4-li.meng@amd.com>
 <20231013160128.GB36211@noisy.programming.kicks-ass.net>
In-Reply-To: <20231013160128.GB36211@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e6678eaf-d33b-42cf-98d4-434d2b994a9a;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-16T05:39:14Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6351:EE_|CH2PR12MB4309:EE_
x-ms-office365-filtering-correlation-id: 06743fe4-0c6f-470f-60b7-08dbce100d19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DHxrkRwtKRRWPjD/2ERXtlOiTEXx9220LhlIBZHLcgInK0VFiwft4+1fkQqwhUuBb1164OW6tunmHVStQXKVKkDXSSat0oIa8bAWvahNIKRIW0ONu/DJ7h33pRrOKRTDO3OspzE3bTPTPpPmVk2VgXQE1OoV0yMuIhJvF9vPeC78oStVojLa1seFDBWDnApPzqxPSJERHPnY0S3Xsyv7+oWKXnWUXe1sUK9oO+hmXaVP4ojm6/SZpTZi5en6NWp/UmSs/Prhv4iPIYMuL9P+zA17u6zaNUf5Tt4a+njSGP+g6SU4k79QGMGhyWw1d07VJSF2K0r4hp2MM0TnOMGOldE3SGRabitTmlII8wi8SrT4L2SQkazXg/h4qeuHFfeTxkiHUO9p22rTzka6I9zKqjsBhSwhGY12VZ0+D4xkF8PPgtMoFrxTlBMaS9NxdZfeR1bxO9+Y/2dvtBNxrJrqr+W5pE7nZMfx4MCrd3WUm3Wyreu+l47tRy778Wo+ej8T2HcCgJX7IBYhOql7YQV66RVQbZ6zG+risns7az2SnBPgLjv3WUPDSXbqHwWHFzsQ4s4Pcp+Krf7T1zmI7r41lADFSmhQq3aPJ3ey3ZlRCsX4gMj5QmdIizB9vUMUCxnz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(7696005)(6506007)(9686003)(53546011)(55016003)(33656002)(86362001)(122000001)(38070700005)(38100700002)(316002)(7416002)(71200400001)(66556008)(41300700001)(478600001)(76116006)(2906002)(83380400001)(66946007)(26005)(8936002)(4326008)(5660300002)(66476007)(6916009)(52536014)(8676002)(64756008)(54906003)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QGdK9mmCuCsZQYJgbOgRNMiiwDh47aZpNNEY8LKs8SqpBnrDxbKYdcgvN0f+?=
 =?us-ascii?Q?GQxzf3b0q2a9I01/Wu6fPoxMkrTusu632G/gBRszbqBctORAGJNQZXzI1oE1?=
 =?us-ascii?Q?Uj1leN0xnsuthrHlSEE22iCRVHmz8SJXS0pfunt2MYU6ehtg23GVYndWZVur?=
 =?us-ascii?Q?hnE1EVDO948o/exFGYOEzk7yZ5qk+h6AXT8Spm3W0mULGUy0rYDs4bW6Xfn2?=
 =?us-ascii?Q?v1qwfBHBehGUSmkMLDTM0DbTMW1NEU3Bsfvb9bxkMOL7fyEMPSENrLBCiY/D?=
 =?us-ascii?Q?bUeOrKqDyQh/cH3bSIWWIpVFg+cals76zUefLVhp21nQt0sEjER60Ks/B4uQ?=
 =?us-ascii?Q?MZ5ed2xDscDVG270Su1RiJiJc0BbKziE9dxBFNsjby5HlbESrYlnM8owCeiM?=
 =?us-ascii?Q?Jgf2QYmgdPRlAyHE2DMYjMBnqB/9gKdssiZLs2+4EYReH2rHCeu+Dr2GUw4F?=
 =?us-ascii?Q?e08/NMLpakjYqU1SgZYdao34X4Me4HWJnaF/pMSck3Ai9ypYl0Z+oH7l1j+k?=
 =?us-ascii?Q?hAiFnvklnMEVE0t5f6l/H2HQjtARlTAscy9hAvMdM8NTUY2Zpd0mstrM8VU0?=
 =?us-ascii?Q?PiuH/a6c/nZykVFcmm/BPNidUS0Vbbe27/mcmWo+0UEtsvayZ05/USlv58EC?=
 =?us-ascii?Q?Z9jX7CjtgcDjfelLMmWke/5QrbI3PZu+HAmrGYd2loYVNh7txxxwEE55QHXk?=
 =?us-ascii?Q?997Tssq2AaXs6FhlKdv4EadEOozptB1RQPHkkB4AAgjO+C9b8EExUwk0RA0Q?=
 =?us-ascii?Q?34EkxTpnBtSr1BcNxeO3UfCU1rbU04ijDZxsMAm6PHROzH69L1DDzsJKgnhS?=
 =?us-ascii?Q?jO5n48qgA3jahs1V5sJL+qazq6orwQYRTC7OpREf9kNE58au5zH7jnVyXAB6?=
 =?us-ascii?Q?QLD3J1UpvcS0L7ndjrCYejSUgx7zD9ZuLQRbRVVVilf3UGOD07LlxZVHN/W+?=
 =?us-ascii?Q?skdtGcTvqw/a0sAeArkdiNPZnsNmGTbmn+zInPwBLa5T77jBvwWSXNvbHZHi?=
 =?us-ascii?Q?g5qyTjw0mHyHrfJrAk8DEEAME0Io21l5Ki4YtIGOF8XKV7+yEoa7IJ0nY+RK?=
 =?us-ascii?Q?umNi6/30vaLz3uChSQGVVyHrn08xSVVBZ/2JvsA9pAltgmzebETIyo+LdLNc?=
 =?us-ascii?Q?31OiDrKtDRNH/uHIq1BeboWYDKTstLwjiCQzR/BX269wQghayEk3+PpuEcEd?=
 =?us-ascii?Q?xQlFCTQMjedMHIHmUJuVbqPKsYOjbUVblPSuzxXJDyaGRGWT2QORFt/hRZtB?=
 =?us-ascii?Q?4EGD8+f2c1hwTwdkwfjCFpRe+qI2NFrjvbuYGg6P4XIWyiiE9p9KEJpUQB7H?=
 =?us-ascii?Q?sUty1xWhngch5aZ0lnk4U8ZBhmfFOm0V/F1HRuoAFxgWrg1tNj4BBJAWRHp/?=
 =?us-ascii?Q?eAzNewsLKsM6fvjCpxQr2B9t6KTe6QsCsux3zbjlH62pEpIfxVnum0nfjLMF?=
 =?us-ascii?Q?aV4Au2m9M8QPm0wJEOzYNQaJ5vR/ivcO2lZDBEaUZqtM139k7oNneHoARIaE?=
 =?us-ascii?Q?vqgvM7HyqepJVhXBGKRsraI+Tcq6z92fPD4q4il5kxfkmicC+AmsbzLmO+Pt?=
 =?us-ascii?Q?/4126AE6H+lRaTORZyk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06743fe4-0c6f-470f-60b7-08dbce100d19
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 06:20:53.7431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SeYG/ZPDRscy+Yk9lC81HACEfOiAOE5DQGYhbNol0fZxLiVgPgWMXGkeJlbnd6XDo4w09tqfsX1YE9tycA9YgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4309
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
> Sent: Saturday, October 14, 2023 12:01 AM
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
> Borislav Petkov <bp@alien8.de>; Oleksandr Natalenko
> <oleksandr@natalenko.name>; Karny, Wyes <Wyes.Karny@amd.com>
> Subject: Re: [RESEND PATCH V9 3/7] cpufreq: amd-pstate: Enable amd-
> pstate preferred core supporting.
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> On Fri, Oct 13, 2023 at 11:31:14AM +0800, Meng Li wrote:
>
> > +#define AMD_PSTATE_PREFCORE_THRESHOLD        166
> > +#define AMD_PSTATE_MAX_CPPC_PERF     255
>
> > +static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata) {
> > +     int ret, prio;
> > +     u32 highest_perf;
> > +     static u32 max_highest_perf =3D 0, min_highest_perf =3D U32_MAX;
>
> What serializes these things?
>
> Also, *why* are you using u32 here, what's wrong with something like:
>
>         int max_hp =3D INT_MIN, min_hp =3D INT_MAX;
>
[Meng, Li (Jassmine)]
We use ITMT architecture to utilize preferred core features.
Therefore, we need to try to be consistent with Intel's implementation as m=
uch as possible.
For details, please refer to the intel_pstate_set_itmt_prio function in fil=
e intel_pstate.c. (Line 355)

I think using the data type of u32 is consistent with the data structures o=
f cppc_perf_ctrls and amd_cpudata etc.

> > +
> > +     ret =3D amd_pstate_get_highest_perf(cpudata->cpu, &highest_perf);
> > +     if (ret)
> > +             return;
> > +
> > +     cpudata->hw_prefcore =3D true;
> > +     /* check if CPPC preferred core feature is enabled*/
> > +     if (highest_perf =3D=3D AMD_PSTATE_MAX_CPPC_PERF) {
>
> Which effectively means <255 (also, seems to suggest MAX_CPPC_PERF
> might not be the best name, hmm?)
>
> Should you not write '>=3D 255' then? Just in case something 'funny'
> happens?
>
[Meng, Li (Jassmine)]
OK, I will modify these.

> > +             pr_debug("AMD CPPC preferred core is unsupported!\n");
> > +             cpudata->hw_prefcore =3D false;
> > +             return;
> > +     }
> > +
> > +     if (!amd_pstate_prefcore)
> > +             return;
> > +
> > +     /* The maximum value of highest perf is 255 */
> > +     prio =3D (int)(highest_perf & 0xff);
>
> If for some weird reason you get 0x1ff or whatever above (dodgy BIOS neve=
r
> happens, right) then this makes sense how?
>
> Perhaps stop sending patches at break-nek speed and think for a little wh=
ile
> on how to write this and not be confused?
>
[Meng, Li (Jassmine)]
If I use '>=3D 255' to check, the issue mentioned will not exist.
Because it will be returned when highest_perff>0xff.
>
> > +     /*
> > +      * The priorities can be set regardless of whether or not
> > +      * sched_set_itmt_support(true) has been called and it is valid t=
o
> > +      * update them at any time after it has been called.
> > +      */
> > +     sched_set_itmt_core_prio(prio, cpudata->cpu);
> > +
> > +     if (max_highest_perf <=3D min_highest_perf) {
> > +             if (highest_perf > max_highest_perf)
> > +                     max_highest_perf =3D highest_perf;
> > +
> > +             if (highest_perf < min_highest_perf)
> > +                     min_highest_perf =3D highest_perf;
> > +
> > +             if (max_highest_perf > min_highest_perf) {
> > +                     /*
> > +                      * This code can be run during CPU online under t=
he
> > +                      * CPU hotplug locks, so sched_set_itmt_support()
> > +                      * cannot be called from here.  Queue up a work i=
tem
> > +                      * to invoke it.
> > +                      */
> > +                     schedule_work(&sched_prefcore_work);
> > +             }
> > +     }
>
> Not a word about what serializes these variables.
>
> > +}
