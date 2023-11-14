Return-Path: <linux-kselftest+bounces-60-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EAA7EA828
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 02:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9520AB209C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 01:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADBE5241;
	Tue, 14 Nov 2023 01:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BoHrienP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66F45237;
	Tue, 14 Nov 2023 01:21:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA571A7;
	Mon, 13 Nov 2023 17:21:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAqYVjVN9Bjf00Y4YZqHl7CQvNnVkdknJiys9LK28j6Fc9qpnzAe1jTwHWHs/csu4m5Sbb18TeQkyfHg3xeH78EO9yPj5qIGOeAp84S65+wy1P/t9zzpNcNgoynQwPwx0QCWq7XS04VIZkr+zz/6IK0JqR+zmUHwvb9mtOLDtnhWvsc4oH5hIp7iIR8H5HcaR/KvxLsP7Y5DzqgIB+ZOVWCFRek9umGY3+aBiPu+6sG6wK3reTlk+PBjwGU/I1Ucg1t5inC+eUCi6mtuyr/6th+nWVZYLBJqC4va8oyiuvhRSyizpU3EttKe9qhDQcBcotz0y8I+owNGHILpnoMtdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2zf2i84FsURjurRwfT3Qa1QDoM62lsHthcticpumf4=;
 b=j7hEWUpgvunu9yrGmlb4Q9OGDqneyCEAbGZU0l45/qGJSSI/r1WXUpzJrB1jYlvHpBaYhjF7WNZWx42QRruRBBBALIN3Rh0bpPzLEBGEEP6FsOp1OUQRkuAR85oCN+J6d4GCCDPAYVudtGRN45o/XV0BcHwr6Ml/1f0TeTkAHxqldyTY4OmD4jDBKiBatTL01fMwFEjUGB++7BlNROZCd5r1+5/O0zFPerM1E/gQl5Y6FZy01ePf77gAGf6zGG8TXhv0doztLFZBaitFtnGgz2RpNcZ7ZqnLRaJQFp73nbt3W2lF4Xdhdr0uTAK3sWSGcbAq0UbZrvnipyHngNpJ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2zf2i84FsURjurRwfT3Qa1QDoM62lsHthcticpumf4=;
 b=BoHrienPjOqaOXA7PeeybnrlxqOdh8rncIjgECk3+TlNJDijHsLJfKOqdNKtVZa2p3I0IpHD6aVLTZpgUz+x6erb7W8T9ZGkhi+cvWwgzqOihOJrCq8fvwNmuzx7bU3W34P9NlSy36bZsd/StOjMQdUOFktNE8k5L6JDuV/0PHs=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 PH0PR12MB5452.namprd12.prod.outlook.com (2603:10b6:510:d7::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.31; Tue, 14 Nov 2023 01:21:20 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5287:5f3:34f:4402]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5287:5f3:34f:4402%7]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 01:21:20 +0000
From: "Meng, Li (Jassmine)" <Li.Meng@amd.com>
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Huang, Ray"
	<Ray.Huang@amd.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"Fontenot, Nathan" <Nathan.Fontenot@amd.com>, "Sharma, Deepak"
	<Deepak.Sharma@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>, "Huang, Shimmer"
	<Shimmer.Huang@amd.com>, "Yuan, Perry" <Perry.Yuan@amd.com>, "Du, Xiaojian"
	<Xiaojian.Du@amd.com>, Viresh Kumar <viresh.kumar@linaro.org>, Borislav
 Petkov <bp@alien8.de>, Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: RE: [PATCH V10 0/7] amd-pstate preferred core
Thread-Topic: [PATCH V10 0/7] amd-pstate preferred core
Thread-Index: AQHaCvsxsvnY3JVffEmz6S3Ly5DxerB5GlWg
Date: Tue, 14 Nov 2023 01:21:20 +0000
Message-ID:
 <DM4PR12MB6351C6DB983ED720A273526BF7B2A@DM4PR12MB6351.namprd12.prod.outlook.com>
References: <20231030063403.3502816-1-li.meng@amd.com>
In-Reply-To: <20231030063403.3502816-1-li.meng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5b6305e2-861f-44cf-869e-8b9cd8a02316;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-14T01:16:08Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6351:EE_|PH0PR12MB5452:EE_
x-ms-office365-filtering-correlation-id: 1af9d7db-b72f-4814-9b49-08dbe4b00212
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NFbLqYbvSIyoxIMNPRx1snfREPczHypT15ao7y1Hq+plWEReWfK3ih+zVgIMV4qoGiQzNQjAxRz2DO00mQ5x3Qdu46IPLoZbKOJywPDc93OK5Psr8QVV0VmzXDNUKTFRX2bjopsCCDdiwwsH21RdWTXtsDEBndDKylwDTEMvPrSFqL+/L8l3kAs981vzgEanxm6/pU/sk+csXOatsoG3NGBSfl6SRs3E+aObZwWKXuPQ2NCD6/PZnwob1XgTKJh+OjDTOX0smc0k93MrH0B+dKhe84NP4uMvZAB9T9cnv9n1/exaqHLNLIfHtPa05acvHcg0ojB8TrGLiM7uz7BZTa6yIu0A8XrvIq+d1VcSprodQyccmL1wnN62aDX2LN3SYcVxI8AmtdIIoOHySxalUQWwVbJSK2cjeMdCZnDzO4e9OHKxW4gbHj7uU8ZdFK9KYg5/74ZsBp7LdghjvIBYMmkCuJ9KI84/vssMx4Q/0MbsGAHOW6E7g3YA4tg58PpNXMoVly0GSM41wz5bRIBFzVGvHWAemmQhjx7wRwJK8Y5U6rQt6f9ZAho8PVr6RPofFA3fOlEv4WSRHwnaAYoIFT+FnSfCjWryQd4cTCRwDM1Shj1oo7Fcnd+2A47MMLlBo3r6VOoOMMY3F6LY3VGqpfhqW5O2MVd85YNJq4q0C3w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(230273577357003)(230173577357003)(451199024)(1800799009)(64100799003)(186009)(7416002)(52536014)(5660300002)(26005)(55016003)(7696005)(6506007)(53546011)(9686003)(71200400001)(83380400001)(2906002)(33656002)(122000001)(478600001)(41300700001)(54906003)(110136005)(76116006)(66946007)(66446008)(64756008)(66556008)(66476007)(6636002)(316002)(4326008)(8936002)(8676002)(38070700009)(86362001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?cDNRODB1eTJCRTZBL2M3dnJzM1RlZUtFUWp3cm5PdkN2QVBFQk96SUw5?=
 =?iso-2022-jp?B?bEtMNGpieU1KMzNMQVl5bmQ1THd3QU9NN1ViWVp3eGdYSHJSc3Z1RzlR?=
 =?iso-2022-jp?B?MTZ5ejljZTYxWmo2RG1GYlhpS281YW9zdVFzZjZvcHJUeTZ3akU5T3J1?=
 =?iso-2022-jp?B?V0l4ZjRMaEs5OWJMSkpjQjBNbGswSmJRS2gzTTQwaUhZRDR3NTBEcHNL?=
 =?iso-2022-jp?B?cXIvUkozSm0wMWU4a1RVZnJpeHJVeExGYVFZUFFXNGZoQTFqR1VjK2ZJ?=
 =?iso-2022-jp?B?OHR0YU9wajFzeEVtTTd1aWhWUkpMMTVCYlgzaFNNbTdiTGhJcVhadHl6?=
 =?iso-2022-jp?B?VUVvbk82RFMvd3lNcDFFMUgrMWZ0NlI0TnJuc3NNMlNYQm5yTkR0YSsr?=
 =?iso-2022-jp?B?UGdodnV4bTVaOWt6NkdjMHJPN1JaYzBMd2dzS1lFQURwdktyaGlRbS9o?=
 =?iso-2022-jp?B?SktlWVlJcDBwR1JpM1Avb3RMNzhhc0I2OXA2cXhZOU5xcU91eGFxcVpL?=
 =?iso-2022-jp?B?S29ZNzVKbWl1V3o3Si9MdXRRZEFLZjhsWERrYnFQQmZGQTVDUGp2dUxm?=
 =?iso-2022-jp?B?NWhVZElZa1c2aERtaDF2S1lSQXpJNk9Feko5Z09MNmVHbDdqZlJpNVMz?=
 =?iso-2022-jp?B?YTBMY2l6SGM5cVc0NnZwcHVlcVVodW5WbGR3NU5qSkJ1YW0yS0JESWdY?=
 =?iso-2022-jp?B?Y2RQUStta0I1d3JnWU1aMG5rM0dGS09BamdkVlhNTERRdkpwTGtuOGdq?=
 =?iso-2022-jp?B?Q0lLeG9aSjZIZUsrdFh6ajFTRkdRWWttYy9naEc4eWZOZUwzeEErbWNi?=
 =?iso-2022-jp?B?Mk8wbHFLSUkxL0ZOQXRka2JGVFNpYlBNSkJtL2pnR2tjcjFFamJLUWRa?=
 =?iso-2022-jp?B?a3FTQWlWWmlUQ2NveitSZm1UeTM2UXEyOTN3Q3dObXZ6ZnJMQ3ZHYTRr?=
 =?iso-2022-jp?B?cnRQbTV0YWFWVzhjZmV3RXl2Y0J3MjUyeGJmNWRGR054QU05K3VWY2Ey?=
 =?iso-2022-jp?B?aUlEOEtkQ2djUDRCaUxBSmQ1QkFYeEtQWTI0eS9KSFQ3dmlVSldwZ29I?=
 =?iso-2022-jp?B?ZXU0SkJEY21TVHBLWTRBUE9tcGk1K2Y4TGZaUWZPQ2wwNy9UcjBqVHZG?=
 =?iso-2022-jp?B?WVRxRG5LR3dockIwYnlrTE5GU0x6Q0tLdWJUZmx1QjkzUExib1hGaXBJ?=
 =?iso-2022-jp?B?VGptWkVGSnFlMnkwYktqVklyRmc0UTRlblZvWFFJYVBwMUlwS0dsYXlp?=
 =?iso-2022-jp?B?V2RCZnhBcStDRjYrSmt1UFpMNDYzWGdDUjB5QmFOLy9SdU5WcjltZE1q?=
 =?iso-2022-jp?B?MGViWlpTYnZOZVJGSU1ST1NxRDFUMllubGpNdnNYcis4VmdLeS9zdFpR?=
 =?iso-2022-jp?B?SjRuZjFhUXQvR2JKbjB4V3FHUU5MY0wrRXBFKzBDVitPOFB0dW1uUHV4?=
 =?iso-2022-jp?B?TUFhTlRiK0VKWFArMlR0aWpRdSt6dHlKMk5aa2JjUEtHOTB6dmRraHd2?=
 =?iso-2022-jp?B?MEM5NnRGWVJ0WTFUajJUOTY3WENheXB1RW45RFBreEVVQ2owa3FFUlUr?=
 =?iso-2022-jp?B?WmFGODBta2dtL0JMRklBZjVMRVBvVE1ySHU0cE1ZUWFLUG01Z3ZET2tI?=
 =?iso-2022-jp?B?UkxUWDhEejdvZlVzWkZLbm94dVR0Z2c1RGtoQzdpcC85MDUrTGo3MS8r?=
 =?iso-2022-jp?B?Rk1pM1k1RFRNTVB0WGk0VTN4bFFTTjNBOGVleFdEVWxndzdQby9PQnlo?=
 =?iso-2022-jp?B?UTMzdmVxS29rZlRaUFd0VEVpVVBQQUhaUlNVSTQzNUN1cXdjenNjamw1?=
 =?iso-2022-jp?B?SW84azFHVEt5K0pMU1JkZUpBSmlZNy9McUhvbHVCZ0pLU0RtZ1czNlVm?=
 =?iso-2022-jp?B?UGpxYUphSVZta2QzcU53cnFtUFRnRkFzMEZvL3A2a3FqZ3pDTlYvTnRR?=
 =?iso-2022-jp?B?L0R2a05pVXBKTVB6ZGJLQW5DMmpCaEZGMVJ4cU9qanNsVG9tQjZEOUFG?=
 =?iso-2022-jp?B?YlZyWHJWSGhMTjhsV1JDa2hEdFFvNGpReXNTNHN1ZnlWMjFTcHIxbG9n?=
 =?iso-2022-jp?B?cXBDOG94OG1YSEttbWVmcU95Mll4SURWTTVDU1BwcFlJWkU3YkRxeUpi?=
 =?iso-2022-jp?B?VDRxVGs5dUd0SE4rVy9zSFBGK20zM1c2VEVGUTE4NjZ6RUZPb0QvV0lO?=
 =?iso-2022-jp?B?anVMYVhqejZxSmdwQ2V5QmZlQTdsZ0tSYjhROWNpU05zZkFFVUFyVHRz?=
 =?iso-2022-jp?B?UE9rbWcvUHc4YkxBMlpURldqdlNvL3N0ND0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af9d7db-b72f-4814-9b49-08dbe4b00212
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 01:21:20.2704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vmh+/L3eZUUrdeUAQSf3VcWz0mCB9crku/20fcwacj2d90Hgix+4VpT7ClVL7GkC1WFFKoWgJmUTv+TJB2+K0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5452

[AMD Official Use Only - General]

Hi all:
Do you have any other review comments?

Hi Rafael=1B$B!'=1B(B
If there are no other issues, can you merge it to linux-next?


> -----Original Message-----
> From: Meng, Li (Jassmine) <Li.Meng@amd.com>
> Sent: Monday, October 30, 2023 2:34 PM
> To: Rafael J . Wysocki <rafael.j.wysocki@intel.com>; Huang, Ray
> <Ray.Huang@amd.com>
> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org;
> x86@kernel.org; linux-acpi@vger.kernel.org; Shuah Khan
> <skhan@linuxfoundation.org>; linux-kselftest@vger.kernel.org; Fontenot,
> Nathan <Nathan.Fontenot@amd.com>; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; Du,
> Xiaojian <Xiaojian.Du@amd.com>; Viresh Kumar <viresh.kumar@linaro.org>;
> Borislav Petkov <bp@alien8.de>; Oleksandr Natalenko
> <oleksandr@natalenko.name>; Meng, Li (Jassmine) <Li.Meng@amd.com>
> Subject: [PATCH V10 0/7] amd-pstate preferred core
>
> Hi all:
>
> The core frequency is subjected to the process variation in semiconductor=
s.
> Not all cores are able to reach the maximum frequency respecting the
> infrastructure limits. Consequently, AMD has redefined the concept of
> maximum frequency of a part. This means that a fraction of cores can reac=
h
> maximum frequency. To find the best process scheduling policy for a given
> scenario, OS needs to know the core ordering informed by the platform
> through highest performance capability register of the CPPC interface.
>
> Earlier implementations of amd-pstate preferred core only support a stati=
c
> core ranking and targeted performance. Now it has the ability to dynamica=
lly
> change the preferred core based on the workload and platform conditions
> and accounting for thermals and aging.
>
> Amd-pstate driver utilizes the functions and data structures provided by =
the
> ITMT architecture to enable the scheduler to favor scheduling on cores wh=
ich
> can be get a higher frequency with lower voltage.
> We call it amd-pstate preferred core.
>
> Here sched_set_itmt_core_prio() is called to set priorities and
> sched_set_itmt_support() is called to enable ITMT feature.
> Amd-pstate driver uses the highest performance value to indicate the
> priority of CPU. The higher value has a higher priority.
>
> Amd-pstate driver will provide an initial core ordering at boot time.
> It relies on the CPPC interface to communicate the core ranking to the
> operating system and scheduler to make sure that OS is choosing the cores
> with highest performance firstly for scheduling the process. When amd-
> pstate driver receives a message with the highest performance change, it =
will
> update the core ranking.
>
> Changes from V9->V10:
> - cpufreq: amd-pstate:
> - - add judgement for highest_perf. When it is less than 255, the
>   preferred core feature is enabled. And it will set the priority.
> - - deleset "static u32 max_highest_perf" etc, because amd p-state
>   perferred coe does not require specail process for hotpulg.
>
> Changes form V8->V9:
> - all:
> - - pick up Tested-By flag added by Oleksandr.
> - cpufreq: amd-pstate:
> - - pick up Review-By flag added by Wyes.
> - - ignore modification of bug.
> - - add a attribute of prefcore_ranking.
> - - modify data type conversion from u32 to int.
> - Documentation: amd-pstate:
> - - pick up Review-By flag added by Wyes.
>
> Changes form V7->V8:
> - all:
> - - pick up Review-By flag added by Mario and Ray.
> - cpufreq: amd-pstate:
> - - use hw_prefcore embeds into cpudata structure.
> - - delete preferred core init from cpu online/off.
>
> Changes form V6->V7:
> - x86:
> - - Modify kconfig about X86_AMD_PSTATE.
> - cpufreq: amd-pstate:
> - - modify incorrect comments about scheduler_work().
> - - convert highest_perf data type.
> - - modify preferred core init when cpu init and online.
> - acpi: cppc:
> - - modify link of CPPC highest performance.
> - cpufreq:
> - - modify link of CPPC highest performance changed.
>
> Changes form V5->V6:
> - cpufreq: amd-pstate:
> - - modify the wrong tag order.
> - - modify warning about hw_prefcore sysfs attribute.
> - - delete duplicate comments.
> - - modify the variable name cppc_highest_perf to prefcore_ranking.
> - - modify judgment conditions for setting highest_perf.
> - - modify sysfs attribute for CPPC highest perf to pr_debug message.
> - Documentation: amd-pstate:
> - - modify warning: title underline too short.
>
> Changes form V4->V5:
> - cpufreq: amd-pstate:
> - - modify sysfs attribute for CPPC highest perf.
> - - modify warning about comments
> - - rebase linux-next
> - cpufreq:
> - - Moidfy warning about function declarations.
> - Documentation: amd-pstate:
> - - align with ``amd-pstat``
>
> Changes form V3->V4:
> - Documentation: amd-pstate:
> - - Modify inappropriate descriptions.
>
> Changes form V2->V3:
> - x86:
> - - Modify kconfig and description.
> - cpufreq: amd-pstate:
> - - Add Co-developed-by tag in commit message.
> - cpufreq:
> - - Modify commit message.
> - Documentation: amd-pstate:
> - - Modify inappropriate descriptions.
>
> Changes form V1->V2:
> - acpi: cppc:
> - - Add reference link.
> - cpufreq:
> - - Moidfy link error.
> - cpufreq: amd-pstate:
> - - Init the priorities of all online CPUs
> - - Use a single variable to represent the status of preferred core.
> - Documentation:
> - - Default enabled preferred core.
> - Documentation: amd-pstate:
> - - Modify inappropriate descriptions.
> - - Default enabled preferred core.
> - - Use a single variable to represent the status of preferred core.
>
> Meng Li (7):
>   x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for the expansion.
>   acpi: cppc: Add get the highest performance cppc control
>   cpufreq: amd-pstate: Enable amd-pstate preferred core supporting.
>   cpufreq: Add a notification message that the highest perf has changed
>   cpufreq: amd-pstate: Update amd-pstate preferred core ranking
>     dynamically
>   Documentation: amd-pstate: introduce amd-pstate preferred core
>   Documentation: introduce amd-pstate preferrd core mode kernel
> command
>     line options
>
>  .../admin-guide/kernel-parameters.txt         |   5 +
>  Documentation/admin-guide/pm/amd-pstate.rst   |  59 +++++-
>  arch/x86/Kconfig                              |   5 +-
>  drivers/acpi/cppc_acpi.c                      |  13 ++
>  drivers/acpi/processor_driver.c               |   6 +
>  drivers/cpufreq/amd-pstate.c                  | 187 ++++++++++++++++--
>  drivers/cpufreq/cpufreq.c                     |  13 ++
>  include/acpi/cppc_acpi.h                      |   5 +
>  include/linux/amd-pstate.h                    |  10 +
>  include/linux/cpufreq.h                       |   5 +
>  10 files changed, 288 insertions(+), 20 deletions(-)
>
> --
> 2.34.1


