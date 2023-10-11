Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C642F7C46F9
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Oct 2023 03:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344469AbjJKBCG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 21:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344488AbjJKBCE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 21:02:04 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6271E98;
        Tue, 10 Oct 2023 18:02:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEbklP2QBrGQmqiXDlkn8fFLrlrHpvxvEN9uUP3IP//0dToxIxCdrNe0dFdnyPPkPuAq9JD7wy7RWC0ygvpx9rmWhmLUD1Mmse2JIlres3E30edihLx/bsn5lRx0f/A41RHcn48GDM5WNopGFUHh1+akz6vP1xx/6G777Yq2z8P6dkcdMAAz68OFikjGCzcX5XFMUpHRNT9zNqjy5MHk9ufU1XD5FV3NxoYeLL04nu5SmWHu1XidSyEwzpfKPaZebT02Iopg4YVuCUX9QeuMj0ogMzOel9bZt70DP1vlXnpak1+n+UD/qnBCA2rmNats2o48k5XNghRijTvSKCxwQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCfMy3WlkkL3HYNCDFdCi9DFrbrClxKjroXlhCXB7Sc=;
 b=Aqlp485YvTT6R4EaPFw6b2DpPF3k77vGBZql2UBuGYd8ude0f2ZXuD8OUDFEaZ4n/zbtCmmSgCzPbVCCSc8uj4I/IPpDhZ0UehlZG8qis7jBcuQfPkn9VTY6/Rhn89ZLXMkDNfdYu7bB5SXPKBxnfs6v6rJ55d4tJt6PX4XgBBXLApO253sjXQxRzl2wmOX+T75GnLL8OX5+Yo1EabTufUqV1PcL8YFhV/v2Upi7GnB17f9Zgs8lNpeMV4HCPyq/76W5ledjX9LbidE3hHZy9S3n6kyMYksgIate5KwmU/wL63a9Dp51y18R6l9ATydhZbDzgPF2CdUdFd5uqNtCLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCfMy3WlkkL3HYNCDFdCi9DFrbrClxKjroXlhCXB7Sc=;
 b=O1btytX1fa6Ka9b5chQo+PKzb6E8RZnsv7t9CAVq0yzV+r/o6g16kdqhfOhv8jf7ndSuh6KPFimujq9SniPzJ7idAvIWSIo3pNWf7zfc2/lA5q5VL4hTL6ximY+eqP3jLTjGPhrsNmKFp3pkm+3/uaRGwkh8HaGdLJuMSYxo394=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 CH3PR12MB8186.namprd12.prod.outlook.com (2603:10b6:610:129::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 01:01:56 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::4ead:d69:799a:281e]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::4ead:d69:799a:281e%5]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 01:01:56 +0000
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
Subject: RE: [PATCH V8 3/7] cpufreq: amd-pstate: Enable amd-pstate preferred
 core supporting.
Thread-Topic: [PATCH V8 3/7] cpufreq: amd-pstate: Enable amd-pstate preferred
 core supporting.
Thread-Index: AQHZ+ltmN5UUPx2tK0qrfRcVz/4ST7BC1oqAgADwr4A=
Date:   Wed, 11 Oct 2023 01:01:56 +0000
Message-ID: <DM4PR12MB6351B6577E32E8A27F1991E9F7CCA@DM4PR12MB6351.namprd12.prod.outlook.com>
References: <20231009024932.2563622-1-li.meng@amd.com>
 <20231009024932.2563622-4-li.meng@amd.com>
 <20231010103629.GI377@noisy.programming.kicks-ass.net>
In-Reply-To: <20231010103629.GI377@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2c2cadd2-4350-45b8-bc3e-4d7b20b37857;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-11T00:57:55Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6351:EE_|CH3PR12MB8186:EE_
x-ms-office365-filtering-correlation-id: 2ea5b752-b341-40f8-a618-08dbc9f5aa36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eZOGH3fiOGU9TdhFD7kNwS17rpPARfaHyzZa/ZYRLxLx71zlQuymfVe8KwnnpaWlx8ZOXDWtQ9726x9U+w1rwHJylq31NaWVotWRW2WTVUZDHtmWG5FDzibqFX+2hOSOvBxb2S6k0fU4VmdsPPh1DX0aUMDXEFTPHcJE6gjmvLdHZ9x2fAKAaOI32pxOG9JYc/7mK+NJoogWkNDdvS+gAWFSsvCpYo2SNxiuFwdTzJ6rpXwqrfR1a7VmRnQYFEHwP+EjFW39s+E52Vn2WBV7rNMb8w+6kH5nex+82Zb/S8Hswlo/wMjUrtvZjAotn4W4oI6N9cJ1HXZIRzRi9XiBLiwTtnFAarKqUvVWzOjMcBygrFQ19zyJfQKHnDywm0DJSK90TZAWRRQ9EoECR370prARGhm1Yj39GofhXy4UOu9uffjxiWsM+miuhKne8EJJibiA0HRkFQze1omY4L4LMhU5j5OBS6T2byeaFOimDNqgam2zefS07rR5Hhlfe6fS6uD4/V4x+69jGdp1V2n5SbA73qPh1vxEvNryONZugFnYc5dthBhcmkyzhvx9U0W/cvzz0lt6DdM6rNGGRxahvhBu0Nb4pUG+/x6auwQRF9s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(366004)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(26005)(71200400001)(33656002)(478600001)(38070700005)(83380400001)(53546011)(9686003)(38100700002)(122000001)(7696005)(6506007)(5660300002)(86362001)(8676002)(52536014)(316002)(4326008)(8936002)(54906003)(6916009)(66556008)(64756008)(66476007)(7416002)(66946007)(76116006)(66446008)(2906002)(55016003)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w7icwbRkybV7geXaWrKzENQFxkiifzGZwSufi0VBQrX3TjILDTxL6o1sYOfO?=
 =?us-ascii?Q?yU9BphwHe5he9/BuIJDMrG5eCwhwyEH3m77Wp2wlfkBAa8btjKwuD2qTZVho?=
 =?us-ascii?Q?jusCpQLoHYhwgMO8/TzWEIHTGaoIk5o2W58SmItbKjCY+Qb5/jSlhwmpjg+a?=
 =?us-ascii?Q?KhaJYgidB9P0FTuNnvy2xdRGpAJWIyqCBDXEQZL7nGtRzqbB1w1kA/D2owlU?=
 =?us-ascii?Q?vIb7RS8jAeUsPjFdfkRDdxVuQ5jRG1dHuQd1KiwFQAuSSCnzA6XzLnedxcAs?=
 =?us-ascii?Q?kpmDS3f5tvUWD1LEFH6989gwyRYO3I9nCqGh3ALuM/1egfCnUELk26EAm5SJ?=
 =?us-ascii?Q?qbgCsFBLS+xi31QR+I/1JhZvJGGtHJiLvfD/A29vR7H6W3MTJG07NgVcp5k6?=
 =?us-ascii?Q?Gif7NDpy5xVFqmH7K4GjBTAF+Y/PTvU7fkg3XzUZvYlx3tOaY5V3EEAERNzb?=
 =?us-ascii?Q?KRn3MjiKQ6PM2E8ovI5Rd9fd+1drBeu149323YGYCb6SXx8TEG/Am/1EWBLp?=
 =?us-ascii?Q?XMI2KyBJNSpSQo6Ggh7TNdNstxacadeP/E41rvDTTf0mSiVOJrDPKR9LqNnk?=
 =?us-ascii?Q?+O8XM5YLwQimj3jrYEmhxwKAqpLxWWTVda8/dIyrqBSMUD0vBEP0VeHTLa42?=
 =?us-ascii?Q?371EI9dqKsCuR/Or6HeyiPjkb21viBtUV5k+SFT+n+9+TUvifDUv9q+fvXmH?=
 =?us-ascii?Q?xm1in4hV05gVVRz7m+pqdryJ/vqg0YnKMmuiPYdHVBMqnltTW0GSFOa87+Lb?=
 =?us-ascii?Q?9ZbJErhyp81mlIGpaEbRngZGyRYzRxVHALR+zPo86HJR12fFt7e7FXwHNFNH?=
 =?us-ascii?Q?CarHL/rNhCyyhu2GJqq7IxIhow7HVMp7V6WCL6JCuhlsPHMcEUXcRmTYBRyg?=
 =?us-ascii?Q?RZ7SJEq/g6579i14kZEzaBGkroF2y41FUeTkX1f17hK74Vy8XdHSLl0IeV+6?=
 =?us-ascii?Q?0Cv2lXGVdOswBha55C3H30cl+NKjsBi2C1zmKqth0UOVlCkzWUUD17sUdgFm?=
 =?us-ascii?Q?qv5O1Poth92mbO5I9Efl2llPWsC9GAOK55z1pZEm1AmQXmsJnSMVEjGXAWrF?=
 =?us-ascii?Q?kibXQysLIquLjibvdE7hC9X8OyuJVfEB+vU1bRwbmfJTiR8WGStjtHpJf/ue?=
 =?us-ascii?Q?1TGjWeYySJfaoKgVD1VxkpRloars8ma/tYbegRlBlUv9X++Tpny5CU8nhqmL?=
 =?us-ascii?Q?I/5IdOYE2ZLZBGD0MfHSkLBh36mEfVUgEYL2O9PfQQ5+xJso8OIEC5AbixJZ?=
 =?us-ascii?Q?OsCjlz5QVO18a5X4/SUrWCJ5a8NAUAtsejBLw6p1Sdrc7Z754YEeGwkFWy/v?=
 =?us-ascii?Q?3AvLpzijoNBUwjU2nukZKX9afvUz6Q/7C8YmMalqDDOVU7pAxrE2R+V060cV?=
 =?us-ascii?Q?d6pDbJ03pAzVSaBRj78rKuHFst4Yg1klfOFgIxXkAfs6WoLqmPyOiGIYNCVd?=
 =?us-ascii?Q?RQgmiu9StoXNzJRmfEbCWz2zQnLxPVdLnoU5YON19p3ztyrm83WIVGPPUc3Y?=
 =?us-ascii?Q?FnyHhetnSg7919rjf0MIJ/8ZYSwS1i5EmGc5X3ZKykf7didav0pKSlG+2PEv?=
 =?us-ascii?Q?2WzQecuZHPx6KiEabFY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea5b752-b341-40f8-a618-08dbc9f5aa36
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 01:01:56.2913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tiGjcpGytPVo99Rb34DsvLtooODfyMe2hD6nuHcAEGUUYLYrpLz9Vtwvk3P5zlYoEwJ4UvjA94BH0L/hPLyzTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8186
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[AMD Official Use Only - General]

Hi Peter:

> -----Original Message-----
> From: Peter Zijlstra <peterz@infradead.org>
> Sent: Tuesday, October 10, 2023 6:36 PM
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
> Subject: Re: [PATCH V8 3/7] cpufreq: amd-pstate: Enable amd-pstate
> preferred core supporting.
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> On Mon, Oct 09, 2023 at 10:49:28AM +0800, Meng Li wrote:
>
> > +static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata) {
> > +     int ret;
> > +     u32 highest_perf;
> > +     static u32 max_highest_perf =3D 0, min_highest_perf =3D U32_MAX;
> > +
> > +     ret =3D amd_pstate_get_highest_perf(cpudata->cpu, &highest_perf);
> > +     if (ret)
> > +             return;
> > +
> > +     cpudata->hw_prefcore =3D true;
> > +     /* check if CPPC preferred core feature is enabled*/
> > +     if (highest_perf =3D=3D AMD_PSTATE_MAX_CPPC_PERF) {
> > +             pr_debug("AMD CPPC preferred core is unsupported!\n");
> > +             cpudata->hw_prefcore =3D false;
> > +             return;
> > +     }
> > +
> > +     if (!amd_pstate_prefcore)
> > +             return;
> > +
> > +     /*
> > +      * The priorities can be set regardless of whether or not
> > +      * sched_set_itmt_support(true) has been called and it is valid t=
o
> > +      * update them at any time after it has been called.
> > +      */
> > +     sched_set_itmt_core_prio(highest_perf, cpudata->cpu);
>
> You still got the whole u32 vs int thing confused, I've only pointed that=
 out
> *TWICE* before.
>
> Boris, can you pull out the clue hammer please?
>
[Meng, Li (Jassmine)]
I feel very sorry, I will immediately double check and correct all modified=
 data type.
Thanks a lot.

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
> > +}
