Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1C479AF0E
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 01:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345314AbjIKVTb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 17:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235490AbjIKIoH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 04:44:07 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE5F125;
        Mon, 11 Sep 2023 01:44:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAcNrI3BJ20mbiuts070uxZwO3Hns7gQj/pxtKGU7iiBGuCkjuYiPCKQBguz5/2DhZtkiRHAHp5BlOtRJGpLmpxc6xhELGVt5irjjS7XStLu4b5emUSa92B4RgPMFukEzgv5TbcWpHijQ3PsHAhqBjJsyGxOIC5oOCKFbyHw+QQ7OYEqo/zwmUQdmUrXRic/EjzwqA2u9QRukX/WjLf/Z5uGI8++O1ATEknh74awIMMa1fZ87G1ZFN9JHoKLBQBr11H4374Yg9XECPbCvSpGT1GUNuPbT7vlpQK928CRSvEFevyAZ2pksTvtkWLiUsihpeOxcj7jeDv/TZq8bhYyRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1V9j6vu9hJ8aINllAtwkAovPybu+lwMDibnRLp4Slg=;
 b=keGvbtaWFIgzmCoyteGxvlIxcr3iFGLqSzj525cYrLEKVLDQhZcI7UgeORc+PtQeQcyN7FE3WcG+Vgh2YmYK1d4OwAWhuAaJ2uMygExxfNET6q8hNEg3i6+jDiMpcx66cq9DwfQ8PGwIK4VAzfKDQVpMcXF+4oBdOnxbIxKhqXbBF28W1Aeu0p7oS31VM2omTjPJIlqeuKqHw9bbjtJdqvTjamGLIJ8Kn1hPR7UPOkCB0QH8IUD3oRBgYOGqsIrCNfUOdy9FWUfnm2AZGprhO9zfgJukD/y3/9n/MLoro2QNUZe15r7k4lqTDKnUWsGUxj67a5hDK/FcJK5i+ecuYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1V9j6vu9hJ8aINllAtwkAovPybu+lwMDibnRLp4Slg=;
 b=yyC4J/1YfK2HxXlLscwSZgVfRSA6OdvFAJqpbP/9BP+D5rmrIWo04ejNVOTZ59eVF6g0opIKgTb7TQmb7U4UkeeSFz6izzhEdWsiW4GbwXAYs2UMb8p74/UPxotUG0GBPKUDIyvJ1XJfP99HAgBF/7vJWD0iB+CecSo3mAx/w7w=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 CH0PR12MB5073.namprd12.prod.outlook.com (2603:10b6:610:e0::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.35; Mon, 11 Sep 2023 08:43:59 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::d713:8aa1:8769:af10]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::d713:8aa1:8769:af10%7]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 08:43:59 +0000
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
Subject: RE: [PATCH V5 4/7] cpufreq: Add a notification message that the
 highest perf has changed
Thread-Topic: [PATCH V5 4/7] cpufreq: Add a notification message that the
 highest perf has changed
Thread-Index: AQHZ35uTcby90ScWIUu95x3lucaRQrAQ8D8AgARnniA=
Date:   Mon, 11 Sep 2023 08:43:59 +0000
Message-ID: <DM4PR12MB63511F8BB2B229120DC8D9AFF7F2A@DM4PR12MB6351.namprd12.prod.outlook.com>
References: <20230905015116.2268926-1-li.meng@amd.com>
 <20230905015116.2268926-5-li.meng@amd.com>
 <20230908132402.GH19320@noisy.programming.kicks-ass.net>
In-Reply-To: <20230908132402.GH19320@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8661df81-ca34-4eb2-90ac-08801417f685;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-11T08:39:55Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6351:EE_|CH0PR12MB5073:EE_
x-ms-office365-filtering-correlation-id: 2bfaf359-4926-4356-2076-08dbb2a33e0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j/FweT1YQYJfgoG/4y1zUfkPqU92nqSmW1ulCCwQilzMRH8nQpX9ElYSWe9f9yhe4E8T3iktKsLjI/pApW+poZ7MBwAF0y67WcnQUQ0KmIIK9FMYNwORX2qmulpQ3puZ2SmfVfC7JXna81hFdaFgp7GSSpHKPiRUQqU0wDdPJXefWKZKImJIEsCP1uXANEaPxgTaF1fO6QbTYMZvIUYYgeLmsc+5ZqLXF8TG3jBeR1o606YPTnctWWFiBbY5ExMFXmOCT5KP3bwRFxz5kW938wQ032O9KvogpunagVidFdElPOtJGsVfMXvd8CNdLnWZkxd6cnhrDxG/VZhl+U3N9voOxksHqMdPStsES2mi6bTjektpJskooBP3v/fMxSn4Kzmukn548vcHP/z9HSvoFwIoksplMb4LVXArCZeHCGzo5soSnWaobHMFQfN1QCOnRw5UdUZxa/uNnTE67aD7kP9JvQxWy4y2hl2jknUDLLELZCWVyR24Gyw7hcDhrEiadqZeOr/ZKQfebrR/3M38cexup2lPdhcutlHT7xQ4gZQmohW5DRwWbA8P7GfizLo/KYdUkt50mzvvcLf2sGeEIjJ9BYRoPPI9avNvClkPEBLsFpz3tVSIbR626qmfgR5HH9QGmhl273DqnJiBf5bFhoB1mbpVoTXaSEJwzHvC5NM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199024)(1800799009)(186009)(2906002)(26005)(86362001)(83380400001)(7696005)(9686003)(53546011)(55016003)(71200400001)(15650500001)(6506007)(33656002)(7416002)(38070700005)(38100700002)(122000001)(478600001)(966005)(52536014)(5660300002)(4326008)(8676002)(8936002)(66556008)(66476007)(66446008)(316002)(6916009)(64756008)(54906003)(41300700001)(76116006)(66946007)(226483002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aqQRm7P9IZWV0c971EB+carEwjJnar8CscVpDB0ebEAj9IETE1ynBpuwgmSS?=
 =?us-ascii?Q?m4CZ/YugRdnFlBhBc8hPX2Vm2v6hb787ZNMmcrEEVF7L5LfK2iGDEbfJqELs?=
 =?us-ascii?Q?37Ky4G+2dhk57KlhrikGsMTL9KiLhtqAfsW86O5uN9dKP76u3/RWHIZYMUX7?=
 =?us-ascii?Q?dEbBlHAKQ87pSKeXYzSZF3dbg6B7U4cKRIRxnsM+Fdy1gRrX4GLzpZo21R82?=
 =?us-ascii?Q?L+h3Sxjx09TqBgEGaOc6DPL+0geWgqOhmpcpTt0Zmba0TTOkyfvDZEVQvXkp?=
 =?us-ascii?Q?/4zftZ6HsyGLKiL4yqOFP1LMC/NcsJJohmz1XFMuV293HfXfvCWHNnuSz9ED?=
 =?us-ascii?Q?f3vVPvJFkmAW5G+j36WsR09s3mS9I+G4g0GfLCDITPfTdyg+tSGrSLYlw1Ik?=
 =?us-ascii?Q?S9COFuYLpKxWMDDPdACNmRewXrtukzXH+3Z7+Rik6mve7HSWVHwxm09+IZz4?=
 =?us-ascii?Q?cJT3ScT7rpQTBdJsejY6lbCLb/xmuwLX2C8T+UVgqYhIIXq2o4bcbPZaVrtp?=
 =?us-ascii?Q?WviYaEmwNofOKT03g2H5cRQ6Ws3DS5YtWwGNcgwnTkOTCado/0Li2dBTAYnR?=
 =?us-ascii?Q?Xb6Nzm9Jx1QlvdHszcOdfPYgZNg6SIgrJhpO93qUYT4PVmO+t1A1K84s5fJA?=
 =?us-ascii?Q?KeBGvZ0zdlHAWoQ5ucZZhUeK4pB54git5BwLTgmWWiw3H9hbjFiLoOgPV1V2?=
 =?us-ascii?Q?by6VHYnHbJSk8mtgB1ePxb/HlM4d3992IqLOc9hGn102W11y6/452sjSmQf+?=
 =?us-ascii?Q?GQlUGi6zsfSAKegqyQARiwjzV/VQ93MvSzsKuhFsKvYCz6XRi/YfAQ8cjtyA?=
 =?us-ascii?Q?b+LXTUwcTVhbvXS69yFLe/ZDdTDxBhQXYdwFbf/nE6AfCL2EZja+LP6pWpgu?=
 =?us-ascii?Q?DVQdYbmI6GeGrPl93wADeg7HrUP+mYqrHz/ttc5TIqoSKbbnBh7byjqfsdo+?=
 =?us-ascii?Q?IGixEQwWGGLmDC8K+01IBuYQ0zOwez6WcQXVc0sXMgrVmEmptloTN0seb2RF?=
 =?us-ascii?Q?khE13iXc+lec98qVfV6s9UOIB6CoCvNPo5xG1l8zxY01qWgWsdevttJ3fTz5?=
 =?us-ascii?Q?WGWwZxtoysdS32FHcFXPeWbM9+PHkRJcdByIhYeRZrYdC9fDu/mSfofs0iUG?=
 =?us-ascii?Q?5LXm3ffoCyZ+h21gt5JjNmjbbQGSDyyLV4tx8U78UxeYnrgt30WudL+DYXve?=
 =?us-ascii?Q?Huy3m8L3HcWwPZWnj8AKRhMDLbAsNvodljlIfpMRyAYqDndWcKLRvypS9bYA?=
 =?us-ascii?Q?EScyAKYOD2qTge6SeNY30u0tq+64HcacpWbbLjY6R8RyQhBvuIWz/Q+/Vetu?=
 =?us-ascii?Q?evc/OCQE1OpU0AyjiDn/uSN8cNWgYjKc7RraumJHmsFs17AN/xBq0uShboay?=
 =?us-ascii?Q?S+5oae6yCgncOWwY5wxfpJDB5L+yClvQJhBeLHnWlpnTNKksgRz8Azcuqelv?=
 =?us-ascii?Q?8OyDSxt9QEkpaqTBcWUxXrGE36YaRmrXiqnaNQrL43ze+yuQZbTMxpQyxfjA?=
 =?us-ascii?Q?YkPgD3ApkCoBRgasYU4HPDMWYDFT2cfg4VIIW62TT9iU4JDXR+42zEzmzc0K?=
 =?us-ascii?Q?Uz7rLopUJnJY8ei8FuU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bfaf359-4926-4356-2076-08dbb2a33e0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 08:43:59.3447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yOrj+wnhURJK4OIRXpzDXwW8wObGiM1KjtmiiSrYfRXWCI0Il04hA5DM8zPPaDhUBi2U5KQNAJ3RD3Z7+xZZTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5073
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
> Sent: Friday, September 8, 2023 9:24 PM
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
> Subject: Re: [PATCH V5 4/7] cpufreq: Add a notification message that the
> highest perf has changed
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> On Tue, Sep 05, 2023 at 09:51:13AM +0800, Meng Li wrote:
> > ACPI 6.5 section 8.4.6.1.1.1 specifies that Notify event 0x85 can be
> > emmitted to cause the the OSPM to re-evaluate the highest performance
> > register. Add support for this event.
> >
> > Signed-off-by: Meng Li <li.meng@amd.com>
> > Link:
> > https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control
> > .html?highlight=3Dcppc#cpc-continuous-performance-control
> > ---
> >  drivers/acpi/processor_driver.c |  6 ++++++
> >  drivers/cpufreq/cpufreq.c       | 13 +++++++++++++
> >  include/linux/cpufreq.h         |  5 +++++
> >  3 files changed, 24 insertions(+)
> >
> > diff --git a/drivers/acpi/processor_driver.c
> > b/drivers/acpi/processor_driver.c index 4bd16b3f0781..29b2fb68a35d
> > 100644
> > --- a/drivers/acpi/processor_driver.c
> > +++ b/drivers/acpi/processor_driver.c
> > @@ -27,6 +27,7 @@
> >  #define ACPI_PROCESSOR_NOTIFY_PERFORMANCE 0x80  #define
> > ACPI_PROCESSOR_NOTIFY_POWER  0x81
> >  #define ACPI_PROCESSOR_NOTIFY_THROTTLING     0x82
> > +#define ACPI_PROCESSOR_NOTIFY_HIGEST_PERF_CHANGED    0x85
> >
> >  MODULE_AUTHOR("Paul Diefenbaugh");
> >  MODULE_DESCRIPTION("ACPI Processor Driver"); @@ -83,6 +84,11 @@
> > static void acpi_processor_notify(acpi_handle handle, u32 event, void
> *data)
> >               acpi_bus_generate_netlink_event(device->pnp.device_class,
> >                                                 dev_name(&device->dev),=
 event, 0);
> >               break;
> > +     case ACPI_PROCESSOR_NOTIFY_HIGEST_PERF_CHANGED:
> > +             cpufreq_update_highest_perf(pr->id);
> > +             acpi_bus_generate_netlink_event(device->pnp.device_class,
> > +                                               dev_name(&device->dev),=
 event, 0);
> > +             break;
> >       default:
> >               acpi_handle_debug(handle, "Unsupported event [0x%x]\n", e=
vent);
> >               break;
>
> I've obviously not read the link, but the above seems to suggest that eve=
ry
> CPU that has its limits changed gets the 'interrupt' ?
[Meng, Li (Jassmine)]
Yes.
I will modify the link to https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_=
Programming_Model.html#processor-device-notification-values

