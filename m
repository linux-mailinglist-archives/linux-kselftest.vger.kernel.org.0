Return-Path: <linux-kselftest+bounces-882-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDF67FE8F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 07:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98BF282225
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 06:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF75A1CFA7;
	Thu, 30 Nov 2023 06:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mBanhiuX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9767B9;
	Wed, 29 Nov 2023 22:04:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AX0IgZZ2H7pMFeXdj1VI6wyaJo10I3qo+PAm0r4lvLGjjINtHIbeigb/ZK14ddUTJ3whjcDcGocFwN9tBZVGgiJMD1HDQSld2vbfss8aHr9aicaaj1TYeWeJCM1yxxFRVCnftngwqKrPiV9OEl5unHYJ0E8jBjMzenwcFN9yhvYv7pmx6/8mz4qpYsNHxmEWTmcERNRCg1q7mMBYWlpFr+rohCM8m/u7i/LNDeABTVunZB+rkZ7cpdjwVxrRAThivD5xacOBlOu+WRVse+grRfiL0jZ/gomq95/5PhiSpAXNPn6vjlCNPGQNA2Og1CstD9nArYzfHbwHLg9lgb03Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1rTu/rPYRGwTosm2IKvDrAnD3Nvy18wGyi5+9jY9ZU=;
 b=IRDJA/6oqT0QmsS/DkbQKuhRw2gREKlNmzqLpVE5S4iZaD0I598Kdkad429Z3EGsR9MQxaKaIyN6HdAcB2fjLfCTTza+RP6BDuiU0BWebLtc5HdJRFmroEFZzUXziRdBP90rNLd8dA3o6AOfZGzS0yiRvAFPyV8moPKdiRl1Qmk/FxNeWRcRbqAwG8Z/2T0u9aUgjjsG8ykfLj7E9bXt4d6Z9RUn3Ji6gP0Cj6Z7dUBc53+5SCmJb8IJm9AxkkQTvD7zK1a6dtcxIvWulkHETxb7U3yr9UmSVTj9CbRztZQbVa1iG8217JwwHssQIIn68+SGmhvYsPd5u/6c2/Onyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1rTu/rPYRGwTosm2IKvDrAnD3Nvy18wGyi5+9jY9ZU=;
 b=mBanhiuXIjUARDxJoXZn/WX7HLxuRqLlO+uLvCvHnqkefqjSbJD8EL8DlDsB6Sk/wJu2AEK/Xp+w+ccbwHT4pp9ZzShoB1yRgfZUYQxMckEDl20r/vF8X5GiounPBFrlOfqoCqqYHeZW3B7oKWo1y0BOZlYo/PQav6jNFRB6NIc=
Received: from CH3PR12MB8657.namprd12.prod.outlook.com (2603:10b6:610:172::6)
 by SA1PR12MB6799.namprd12.prod.outlook.com (2603:10b6:806:25b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 06:04:39 +0000
Received: from CH3PR12MB8657.namprd12.prod.outlook.com
 ([fe80::466c:b6a0:f281:1e99]) by CH3PR12MB8657.namprd12.prod.outlook.com
 ([fe80::466c:b6a0:f281:1e99%7]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 06:04:38 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Meng, Li (Jassmine)" <Li.Meng@amd.com>, "Rafael J . Wysocki"
	<rafael.j.wysocki@intel.com>, "Huang, Ray" <Ray.Huang@amd.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"Fontenot, Nathan" <Nathan.Fontenot@amd.com>, "Sharma, Deepak"
	<Deepak.Sharma@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>, "Huang, Shimmer"
	<Shimmer.Huang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>, Viresh Kumar
	<viresh.kumar@linaro.org>, Borislav Petkov <bp@alien8.de>, Oleksandr
 Natalenko <oleksandr@natalenko.name>
Subject: RE: [PATCH V11 4/7] cpufreq: Add a notification message that the
 highest perf has changed
Thread-Topic: [PATCH V11 4/7] cpufreq: Add a notification message that the
 highest perf has changed
Thread-Index: AQHaIpEIwn35AdYFckSuoJ70xhKCerCSYHpA
Date: Thu, 30 Nov 2023 06:04:38 +0000
Message-ID:
 <CH3PR12MB8657C54DF76BC3C8BD4286A19C82A@CH3PR12MB8657.namprd12.prod.outlook.com>
References: <20231129065437.290183-1-li.meng@amd.com>
 <20231129065437.290183-5-li.meng@amd.com>
In-Reply-To: <20231129065437.290183-5-li.meng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e9ab14e3-3959-4fee-a817-5b54e0646f18;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-30T06:02:31Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8657:EE_|SA1PR12MB6799:EE_
x-ms-office365-filtering-correlation-id: 5ec7c44a-9f4a-4e67-946c-08dbf16a3c9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IxM+XULZuLngSJauoappIPHtKrPl1nR2+HjinZk4PYsp3JnecUmN1yzVDIoc+azIHjLNMOjPTVnNGZne1qM70bHSfqV9BQMnr31OQYfoKaQGwBXcg0aNrzK7nbXHg7dajZW8CVCWtLKZsCR3T//kCd7SFoPS6d7/Xe7fXVGHwbmU+7EsDne1PDcXDDEEmHqlFRBwVhnFdggsOKGyBKW4GMlUy3x4QKbbkY+54rdJ3xCYrNlEVmRa9KAbRhJz+ZkTs+0cwmIXfYJv8wXR1MaSPPC9d1AUbW0h2vMQ8o3u7/NuJq7+jVr274kKpaYYNfZ3OAOYMHLprfWmPZISATqPnKkL3sMbP/8o8oTbpFWMSW8fExBfD2my0hLLUVoEDSBrIVuuAlucgWkesOLSUn9uRMND/BKNf/vzfUfq4qoeGBmQGr6GSyv10pvCeWF6Dn1K0dGIwQZno6UCuP7C0mFtWaDq9c7/1enlCYq3+gs5zA1o1C4J8dkQYAaRn8DVb7bhqxTFLAyzKRa/bSGiYZJiiSONpURlYfshT8UMG0CCK5wwF+xMcamyr9yO9mOVm5HOvTYId3uVLFzOZ5mKjLtOdztT1ZbFBZ5DeFhG/Mt3iojD+eqt2Pj+CPmrk8FnSqszizf46pukZ98C9jDI8eTAdVzh7tCGZMmtB3m83YfhkH4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(15650500001)(55016003)(2906002)(7416002)(5660300002)(71200400001)(52536014)(38070700009)(202311291699003)(83380400001)(33656002)(966005)(9686003)(38100700002)(64756008)(7696005)(41300700001)(4326008)(8676002)(478600001)(122000001)(8936002)(53546011)(86362001)(6506007)(54906003)(6636002)(316002)(76116006)(66946007)(66556008)(110136005)(66446008)(26005)(66476007)(226483002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DtSEOhS0BbeoxyQPG6a3K9b39D4yNpPCMJzYYEWNt0Xw7ec1Pb6Q4tv/GyXj?=
 =?us-ascii?Q?NDKusVT0baQV0lqGAElzFSZrnuruZ0SPtFE66rVV8ClBxd8PfolwbvhVFIpk?=
 =?us-ascii?Q?X/UHkSfxmNWdS8RlFHtPF6VgC7Jy7jZwmepS7j9z4BJ3BCHS15dXltBKYqoB?=
 =?us-ascii?Q?3c/gVCdyjo0L0pV9ehYcXNN0xJSgddXvm2yDC3Gygk/r5SvhBcgr7MmS3bb6?=
 =?us-ascii?Q?zrGROXB9B2TToiWWNIqsMNj75djYdUuknIPQoDEbg98qEeMhiILvKkVBNieF?=
 =?us-ascii?Q?SR0acnBQ0uumpmkJ/W+ItMG5ftohGy1g628+t1wGY16+PqV1a4nx5cC9TJp8?=
 =?us-ascii?Q?HUOeummWBtgkTJgEEKFFveLoyjtLe7KyPgtojTt7qlJZ4bwIilu4/NbZDImy?=
 =?us-ascii?Q?1R53xiRC/9Il89tHMMTKSAobP+zHJmCT24ueGudYNWMnJWB0xWOw3jQjGIcu?=
 =?us-ascii?Q?9JkOrBptt7aT/CagduOVNRTcwfdXrZuB0EMz20aD5X9+iy2OEkZHP9FHvjM9?=
 =?us-ascii?Q?2ZxwTBXNz7JK3NzPAK593HaAdsDHUHtYWjL/Mh3PSdB2oMKYFeic0i9/Nyev?=
 =?us-ascii?Q?bLh7K+fxTp1l/3/kZViKGN7gGBBDMZ+qa9p69LF/B9KPGDRVkUcbM6Sl3klu?=
 =?us-ascii?Q?l2+m6CGiVKTrP4C79YJy6cX/ZoZFGnu1SI2Q8UZblD7L/ASam50nmzZh6sFl?=
 =?us-ascii?Q?1/ptMzWPcC/oj38e+7ae6WfNFp4CZ21/DOBJplPVsY/VdUQ7cPKX3hACY6UY?=
 =?us-ascii?Q?/qIKTkZSewsg22E7McMGLGMHCWKJBkLi1y7nEce8YFD6k1Ur104E770hdpQI?=
 =?us-ascii?Q?Dwd0s/iNHlEmIOzjR6JRd4xgAc2wpgzfx5U3StikRp89inio64Fs1mGZ3Csz?=
 =?us-ascii?Q?+GMI7MbhlYwsL3e/ouB9GyunuSzvi5dbQYlO9OF68ZSOKjI06xTUWIKohI7V?=
 =?us-ascii?Q?6oZIVL2ymYk0MKPz73e77LwDW1RbKa3kObJnc2MqIQ65CLzyihLfGnKt95Sq?=
 =?us-ascii?Q?sOEEwbvSrW+AMYhUH3ktzFrN0BisdTslTSMTJFD8IT9UVVuOy8pgr8w7bsGI?=
 =?us-ascii?Q?cp5K3E99sVqRKwxCllrC0aR3fq3GGePLvOcBNf2C9SpkexunAx6eTKSb82MU?=
 =?us-ascii?Q?i11DwlZeGxjRX0U8xqM2MC7Dh68gRdw9ar8vmRHeYx6JKZnGXNazkJ+rYwf7?=
 =?us-ascii?Q?yuby0NTqYi6th4CClFMdKF8CT71vfRlzJ8Iv5/9Dwx9I2DO6LoiEz4O7bWfB?=
 =?us-ascii?Q?uwPNUamwx0Qr5jp0svcY2k0TGJ1k/+Je1vs5m2azzu6NVakreSAKJkBavvIY?=
 =?us-ascii?Q?ke8/fiiT2f2XAO3IR3Qjgfl9yc7K3pUD7rfD/soJqamQ+lHZT19fWmdUbKE8?=
 =?us-ascii?Q?5uKY19mDhOCqGcjj14W8ZKW4Yo3MqaWJjR+k6RTnwiaAFTbdIt9IdnA0kytC?=
 =?us-ascii?Q?tmU4ORVXIv7VFhdSnlJfS4gFfGtDL62qqorqTv+cC0Q7x7x5linTGSgCsK1L?=
 =?us-ascii?Q?t9Ipg4QiJvqEFctuFGmucak6hh6Ddv/qXX9FUOJMyz09U4Sg5UygMKXCbwRo?=
 =?us-ascii?Q?vD1yf15YUH9ZQccN0LE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec7c44a-9f4a-4e67-946c-08dbf16a3c9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 06:04:38.8299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RZ2pntClsKTu0ubRaYCngMBaz6vQea0SBC+Lx2pUY18IS5jB3za33sHd+9GkRlLeN000oMHCMdnvZ8v7xHcmtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6799

[AMD Official Use Only - General]

> -----Original Message-----
> From: Meng, Li (Jassmine) <Li.Meng@amd.com>
> Sent: Wednesday, November 29, 2023 2:55 PM
> To: Rafael J . Wysocki <rafael.j.wysocki@intel.com>; Huang, Ray
> <Ray.Huang@amd.com>
> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; x86@kernel.or=
g;
> linux-acpi@vger.kernel.org; Shuah Khan <skhan@linuxfoundation.org>; linux=
-
> kselftest@vger.kernel.org; Fontenot, Nathan <Nathan.Fontenot@amd.com>;
> Sharma, Deepak <Deepak.Sharma@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; Du,
> Xiaojian <Xiaojian.Du@amd.com>; Viresh Kumar <viresh.kumar@linaro.org>;
> Borislav Petkov <bp@alien8.de>; Oleksandr Natalenko
> <oleksandr@natalenko.name>; Meng, Li (Jassmine) <Li.Meng@amd.com>
> Subject: [PATCH V11 4/7] cpufreq: Add a notification message that the
> highest perf has changed
>
> ACPI 6.5 section 8.4.6.1.1.1 specifies that Notify event 0x85 can be emmi=
tted
> to cause the the OSPM to re-evaluate the highest performance register. Ad=
d
> support for this event.
>
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Meng Li <li.meng@amd.com>
> Link:
> https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.ht
> ml#processor-device-notification-values
> ---
>  drivers/acpi/processor_driver.c |  6 ++++++
>  drivers/cpufreq/cpufreq.c       | 13 +++++++++++++
>  include/linux/cpufreq.h         |  5 +++++
>  3 files changed, 24 insertions(+)
>
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_dri=
ver.c
> index 4bd16b3f0781..29b2fb68a35d 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -27,6 +27,7 @@
>  #define ACPI_PROCESSOR_NOTIFY_PERFORMANCE 0x80
>  #define ACPI_PROCESSOR_NOTIFY_POWER  0x81
>  #define ACPI_PROCESSOR_NOTIFY_THROTTLING     0x82
> +#define ACPI_PROCESSOR_NOTIFY_HIGEST_PERF_CHANGED    0x85
>
>  MODULE_AUTHOR("Paul Diefenbaugh");
>  MODULE_DESCRIPTION("ACPI Processor Driver"); @@ -83,6 +84,11 @@
> static void acpi_processor_notify(acpi_handle handle, u32 event, void *da=
ta)
>               acpi_bus_generate_netlink_event(device->pnp.device_class,
>                                                 dev_name(&device->dev),
> event, 0);
>               break;
> +     case ACPI_PROCESSOR_NOTIFY_HIGEST_PERF_CHANGED:
> +             cpufreq_update_highest_perf(pr->id);
> +             acpi_bus_generate_netlink_event(device->pnp.device_class,
> +                                               dev_name(&device->dev),
> event, 0);
> +             break;
>       default:
>               acpi_handle_debug(handle, "Unsupported event [0x%x]\n",
> event);
>               break;
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c index
> 934d35f570b7..14a4cbc6dd05 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2717,6 +2717,19 @@ void cpufreq_update_limits(unsigned int cpu)  }
> EXPORT_SYMBOL_GPL(cpufreq_update_limits);
>
> +/**
> + * cpufreq_update_highest_perf - Update highest performance for a given
> CPU.
> + * @cpu: CPU to update the highest performance for.
> + *
> + * Invoke the driver's ->update_highest_perf callback if present  */
> +void cpufreq_update_highest_perf(unsigned int cpu) {
> +     if (cpufreq_driver->update_highest_perf)
> +             cpufreq_driver->update_highest_perf(cpu);
> +}
> +EXPORT_SYMBOL_GPL(cpufreq_update_highest_perf);
> +
>
> /******************************************************************
> ***
>   *               BOOST                                                  =
  *
>
> *******************************************************************
> **/
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h index
> 1c5ca92a0555..f62257b2a42f 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -235,6 +235,7 @@ int cpufreq_get_policy(struct cpufreq_policy *policy,
> unsigned int cpu);  void refresh_frequency_limits(struct cpufreq_policy
> *policy);  void cpufreq_update_policy(unsigned int cpu);  void
> cpufreq_update_limits(unsigned int cpu);
> +void cpufreq_update_highest_perf(unsigned int cpu);
>  bool have_governor_per_policy(void);
>  bool cpufreq_supports_freq_invariance(void);
>  struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
> @@ -263,6 +264,7 @@ static inline bool
> cpufreq_supports_freq_invariance(void)
>       return false;
>  }
>  static inline void disable_cpufreq(void) { }
> +static inline void cpufreq_update_highest_perf(unsigned int cpu) { }
>  #endif
>
>  #ifdef CONFIG_CPU_FREQ_STAT
> @@ -380,6 +382,9 @@ struct cpufreq_driver {
>       /* Called to update policy limits on firmware notifications. */
>       void            (*update_limits)(unsigned int cpu);
>
> +     /* Called to update highest performance on firmware notifications. =
*/
> +     void            (*update_highest_perf)(unsigned int cpu);
> +
>       /* optional */
>       int             (*bios_limit)(int cpu, unsigned int *limit);
>
> --
> 2.34.1


Reviewed-by: Perry Yuan <perry.yuan@amd.com>

