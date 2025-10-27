Return-Path: <linux-kselftest+bounces-44095-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F09C0DD4A
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 14:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA27019A59BB
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 13:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859CE24A04A;
	Mon, 27 Oct 2025 12:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T2YjSzOt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F25246788;
	Mon, 27 Oct 2025 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569931; cv=fail; b=cKmxIqe8M9JgGcItyB40ypKAemSOprATUS8NWsNMR0k34jEwpF04+ElI/kFuSd1s0o0TOP64KKNuhy4R7lc37eAII37U3JxdFHkSZo8wqcAkgtmZUYpfjcXrTagL+pU4/4Mn69knXknjP14oug56sok8nKXQoPlq/sgeJVLlc5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569931; c=relaxed/simple;
	bh=wXjUAWvMdRa+Jz7wuwriBY3w8JZ4OIs7aIr9zUhJGgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T+eHDVBS0aYT4I6jADu27M7yU/abernz5U+hc6KZrSWUUvGt0DX0SmFpHU4glcPHbilvmeye1d6O17Bq+SdtVtPqiTy7oZ2oLXUsgWx3mHQHoTxSficFOni09ItTd1vSHafD5QkBE7nJmZtZfNXPc/aFY2awWywRODAv6uImBFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T2YjSzOt; arc=fail smtp.client-ip=52.101.53.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yomiQSUGHAcTYWrP+NOqLBU2sPl6R+JSbHZMeN+f9VAWgl2cUPoOFMaw2/fyGrGrEfTGFV0yT1N693aLucYF7JjwHzj6XohibGcJLCBH/wcXkQN0RdjcatrJ7Lwk99sPDoS68GH6NU4zk3QOyl52sjXJHI3+nmCMmXq6geQ+vL4f+2xCjrJlSAcGn71WSOIZnlvN6b+SGkn34zfBm67dTC0yWVTU+t8ShjQ7/eCuq2ce6LD0cJDcP5PKdD1YVOzeahaBDdsS7yiEdk1Bnnaqpijw4n/Wa4uBaHv2JAio8G1Wtxv1O2XBs6Ey3D+QW6MiQi/rjvikyzL+CFnVNtHjkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuhnVnExQxAohyXiZL2EsV8bgeJO43P9Bsc5t9PK52Y=;
 b=dEqel94WtNnYWL89FnFvPpmoXyGubJFY1ByEeaEYkYxnDstgK50e6O+iVx8ZRT/xcniK9aeKoYYmtvW7vCfVJnL3vss7Qtyf8Y/p9jRM9yiXSYejoFlYrDeBgk+RAnAnEB4zw8UzTgUMfqltUGY7/qvQq3p5emqGfBSgx5TDL6XO39eBpWcwuV9U92KrgUjGWaTqmE/hDyF2gNtj1wi75K18jUBAYhJbagI5ZCRilhyrOQXkQzF1fNSr0OtYV3EuMl5F+mvHAxn4yL3cqMzDBq5p6a1lTXZrKWWBFnsR1Gh2Si4ev7m/6oasqemEvO9Uka6DUFdExeo/hC69Pr6TxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuhnVnExQxAohyXiZL2EsV8bgeJO43P9Bsc5t9PK52Y=;
 b=T2YjSzOtlCpeM4B4zL5gDizxx+5ULdcpeE5olEjzqicbHMuFO0KyXqypNzVEb6x9NJ66UCe7+w9poAu9sZgSuZsxhdIXCSbU2p16HjqFtamYGBFL6IT0Mw86jRtzsKHeGqZ09aWN9l6+1FWJIocCkKN+i3CIPn0JBeqJNr9LbHXk9wI0/2tL+HSTsQ+nQaNVKGgl4hZlMwPg8qFyFVg4v8OqLK0cHtwMmBxUxCX/S8CKS1pvh6stpDGo+XTd7xVs7zwB/U/24EaJnHF4vw7+Zu79xFjKXAPMUYRIQKO+PNPRUiSrvDDzqdYnJqLZDUrucWsdbyx/Q7t0n5hWjst3nA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DS2PR12MB9797.namprd12.prod.outlook.com (2603:10b6:8:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 12:58:47 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 12:58:47 +0000
Date: Mon, 27 Oct 2025 09:58:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>,
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev, Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Michael Roth <michael.roth@amd.com>, patches@lists.linux.dev
Subject: Re: [PATCH v7 03/15] iommupt: Add the basic structure of the iommu
 implementation
Message-ID: <20251027125845.GB896317@nvidia.com>
References: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
 <3-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
 <CA+CK2bC5=rb1C6i5yMad_tG9JpbYYgSRxAX-vhYctuoLvcQbWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bC5=rb1C6i5yMad_tG9JpbYYgSRxAX-vhYctuoLvcQbWg@mail.gmail.com>
X-ClientProxiedBy: BN9PR03CA0687.namprd03.prod.outlook.com
 (2603:10b6:408:10e::32) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DS2PR12MB9797:EE_
X-MS-Office365-Filtering-Correlation-Id: bb400feb-1b96-4295-2cc7-08de15589108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1BYS1pPY2doTEFORkJpUnl6eWU2aEdEcWhBaWczY1NHVUFFYmJ0aHhkcHJH?=
 =?utf-8?B?OFl2bEp1VVFoRncrYVpQbXBQVHVNaXJ0MlEreFBIVW85Ukxsb2MwNGVTU0lq?=
 =?utf-8?B?WHVIcm9VdUQ1Q0tmNjVWb1hKQkRqS2cwTFRKSDJpWjlTZ21hTHdHSTFhMVox?=
 =?utf-8?B?bWNNNG5YTFRRNGUyM1NmcmdzZlltWko4SjdFdzEzNnRLZHNKYnJpSk02eTVk?=
 =?utf-8?B?T3U2WkFxLzBFM1JtRnFDNUVvU1RJY0dlMEV3RytBOXVrU3lybzdYOWJOWkhu?=
 =?utf-8?B?NDF4aDl3RXA5ekx0Sm9VS3hGcG94aFBGc2xjWXBtd1hPVmlKc0NVUzlKVU9k?=
 =?utf-8?B?eDRLMG5ST1dBVVoyRGlxQ2JYdjZqQVFHMy8yY1NqV0lnWDRJWmc1VUpVb0dP?=
 =?utf-8?B?ZUZ3cm1pcjZnTWo5dkliMFhkOUpZdWNsR1E0QVlSVmtIZFQvM2QzdGlmM0tL?=
 =?utf-8?B?UmRTdTJQZS9iQUhsUDNTSVZKYkVtR2lnczB1eU8vS2dWclVXNllVbnYrSnRz?=
 =?utf-8?B?TXY3QnlqQTZrT2tyeGowdENMWHZPZFZPcTJYVHR6VVBiY0VxQU91bHI5TGpQ?=
 =?utf-8?B?eUxiNzZldVhmbXY2RnE2elNJV2dabTFmdnphRjQzRStpcVF3ay9Kd0FCbEdO?=
 =?utf-8?B?Q1JYOE5iMkNkM29taEh4Mi9NakM3K0lVZGs1d0Q5NUx4SGgwTS9PTzZYVGVS?=
 =?utf-8?B?N1ZxZm45bGZoL3lheEhRSURjOTloUDJPbnhBbXZwOE55cG0rTGJjbTFQWW5E?=
 =?utf-8?B?clVOSEhpczc4VFdMK05HZ0NCYytodkZUSWZmcS9oQWdSS3pXM0M3MlN4VEtV?=
 =?utf-8?B?SXMzaVdUYUkwQjdxMTFJOFFKUkNDTUpaR2dUOEdsZDBucWE4K0xRcnR4ZEtG?=
 =?utf-8?B?ZzVZeW1aMTdxM2dQVkU0bmZISENJZElkZFI1NStsSml5QTlqNVQ1bXE0SW80?=
 =?utf-8?B?VkdURTNWL2tIZTNrS29FTmFuRFpNSUlmbEd5alBFbUYyWStXa1hJRHM0YWhP?=
 =?utf-8?B?cm5pMFFJZ3ErK01TZUFaM2RsSGpUd3dFMjU3Y3E4MElNTHlSbEZxYTVRdmNK?=
 =?utf-8?B?bXI3aStTOWlQSkpCRGd5dkhwRjhlek9maWt0aHY3eEhFNVpvSXFpZ1B3OVpD?=
 =?utf-8?B?eG45K3k4OElwRktxN2ZkQmZTNFN2RGZpZVViNzJwOG5ZZ0dKSHRuSTFmaXpB?=
 =?utf-8?B?U1lSU3NUK0ZmamNPcTJ3eHAyMXVsVUMwempJbmhpblo3eWJoT096cDlrcHhE?=
 =?utf-8?B?Tm9jY0RkWjlVV0xNUnFjcVIxTjNTNHNMS1UwdmlNeEN4RHFaZFJydVc0SWtw?=
 =?utf-8?B?YjdBSUpGNlJvYXhCZ3E3Yk1uaEk5UTZLa2dIVnVmY01OYUZ1Z3J2RHd3NEpC?=
 =?utf-8?B?TVBEUmxkZFZrQmE5ZitpV1ZpU2tNWjd0eUZIRGhORzI4TUhEM2dPeER4dGtN?=
 =?utf-8?B?NmFWS04xK1JoWVFxQVI5Y1B5UjQyNGJ0RW1jSC9zeXkxaEV4ZDY4Z1psdlVW?=
 =?utf-8?B?b1A5aXRSZlBhTTZjREFFS3dsQm44a3VPSVdVa3NLcG42dlViOTUxSEZJajJv?=
 =?utf-8?B?OC9PTGwxRzBIUld5OVYzcUwwUFhrcmk3eGkwb04wOEYybkR5clBkNnpxRlZ1?=
 =?utf-8?B?M1VvL3JoWGZPSWpmRUdFSnZ3a3k2SmEzMFluUTY1eGFGbXlPS2RsZ0FmUVpi?=
 =?utf-8?B?bGVwY05uUmVFdjQ2WjhUQlY4SXZzemRIM0J5M2h0ODJ0UGFaTWZKd09EZDdY?=
 =?utf-8?B?dWhMZkliV1Fod1JSazd5d2JNS2UrMG93VWNHN1Q3SGc4YmltcHo1WWs3eENP?=
 =?utf-8?B?ckQ3U0VXT1ZQZmlFMEFMZkFoQll1MWNDK2lyZDF3QWxqTUZPdTNQMUhqOUxl?=
 =?utf-8?B?Tm90bDJkTmFkVDQ2andaeGtudlNLSk9oeXFib3g2TXJWbTA2WXk2ODJRaklj?=
 =?utf-8?Q?F26JgqmOow0XfFLOrPlukw5McrQj7VRh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTlLRmJvemY1Q0o4c2ZhSk5SVVNJWXM0OUd3dTJPWGMzOHAveVZ2dmxMM3Aw?=
 =?utf-8?B?R2RmUWZGY3VYNlBibnNwVEJjWmZtYWVKcEwveHdQMW9zbUE3S1NDN3h3QzB5?=
 =?utf-8?B?aUJWbXU1NDFmN0VVeVZDamxZVWtGMy9Sc3BFemdVVVpGclhOOWZEMEI4QTFz?=
 =?utf-8?B?bS80endDdUpjQU5GUDJkdDNMU1dVUWNock5MbDA5Nk9YVEJQVWdiM2F1cFZw?=
 =?utf-8?B?aTF1b1F6TEx6MkpDeEh0UkNsMGZ6NjVEU3ZCdlhoVGQvZ2c3MjFGQ05uSXJI?=
 =?utf-8?B?aWYvZk0xRTFOWWZaL0VabnIybFUzZytianYyQmdsTS9HRGtpemg0bTFLOVJ3?=
 =?utf-8?B?NkwxL0dvOExyWUdLMTZRc1YrUmxVbzlBTkRpemQ0cXhBY1dFeG5sS3Zrc0Ur?=
 =?utf-8?B?VEhLcG9BM3hFMUNuWFdlN05SSmdwSlVDZGRhR2s4WU9jN2UvakJ3TC82YlRZ?=
 =?utf-8?B?aWo3TEVyYkpCNmdTaVJqTHppcTVUa055SWh6Wi9yaUswZDVSbjdMR2FEVHVu?=
 =?utf-8?B?M0dNOTNPSm15ZGx3dGIxcWdzWTBsMVFCcDl3MTgrbjdkaWJ5SVZZVjg5Ritu?=
 =?utf-8?B?akl0bmhkSkFZalJyNnFkNGYzK2JsRUlCQkJ6Q2FkRVhXTEh1SFRra284ODEv?=
 =?utf-8?B?T0dKOEpnS211YmF5VG1waXEwYjMrSnI1ckROUElva0I1d2F2TzhoRXlOdWp3?=
 =?utf-8?B?b0V5dTBMVFkvbTFEMWJCUmE5RmFKOUNjakNsMFFZaURQaGVSNE5BTUZVRzRO?=
 =?utf-8?B?Z3cyT2llcU1GT1N3YkJvSzhHNTJLejRvem1jZEx3WnMyTW9MSU52RldYek5U?=
 =?utf-8?B?TUNUeFluZVd0RjNWbHoxMHZBRU94aytQYUYwb2dia01SR3Q0bFpRekhySm95?=
 =?utf-8?B?bFpPMWFUS25aSXB3eVVqcHhrTk9zOS9sOFVPdHVaaXRMWUxaM3NPLy8yTjdB?=
 =?utf-8?B?UXdxUXdXT3lRMWlFZjB2VmVzekFKWmR2Q3lNOHZqMTBRd0E2VGdxOXJ4Rmps?=
 =?utf-8?B?bDNMZ3BFcWdZK0dZSm8rL1RCT0kxOWozZDhFZm5pbnRGcXlQM0JmZ1h3eVF0?=
 =?utf-8?B?WTg1aTQvck1ITzFucHBJRitwVDl6Q2pvNG5FaWdrazEzeFo2cDN0S3NFOVJM?=
 =?utf-8?B?OXJRclpTOTJ5U1Rja1VOYXI3dDB2UG1YOUJKVlBFSzJ5VEVMMmNwbDU5STlL?=
 =?utf-8?B?YXcvd2tndFpGbUdUdHVJTW5lVzFYeVpRUXlaNjMzKzgxdnhucE9XSmZxMWpE?=
 =?utf-8?B?SG1XdDM0RWVZek1SQjlGdHpWOVNOaE5ZSjRrbVhHdENKc09lYVpjdlBxQnVu?=
 =?utf-8?B?c0tIM3REWkRzaGFhbnBYcDQrUzJEZ1NlckpYeW5uNnIzL3RGZ0UzOVI5UFk3?=
 =?utf-8?B?bW1uekkrSzV2YUtrSWd0UWxzZzg2NVREYWZiWGtCYzVPNmIyNkhzQTgzbWJu?=
 =?utf-8?B?MThmMWwvTFo0Y3pIVzExbnE3TTBGcTdDS3Q0UGgzNmJodTJ5bVZnRnF4Q3NP?=
 =?utf-8?B?VkxoUjBPekFlTFRIQk5OMk1oSUVvZXB1RkZQdjZ1U1lZTVJHVEY4OTlLdllo?=
 =?utf-8?B?SWtScDhqcEtVaTFiRzlBQU1RRm1wRW5GaXk4eC8zWDVqTGlvVjdjOUE0cGIy?=
 =?utf-8?B?c3RIY29MbE9NVzd2WllEMWlGUUVTeGR0MndtcFVzTVVXN3J3OTJFdnNDc29y?=
 =?utf-8?B?Y0Noby9sQloyRkZ5cGc1Z3NyRTQzZzh6ZFJtWi9GTmZ2a3dYeUZqT0N4Q0dp?=
 =?utf-8?B?QkNIRC8xUmN0eVFtQ3ZLbjIyV1VHSGVOY3I4c0pFODlkZGZsRVlLUXpUNnlw?=
 =?utf-8?B?R0djdmNKTVNUc0pvdXJMcFBxYmNUZ3k5aDFtOTlPWkxXTzlpWHpzc29DdTBC?=
 =?utf-8?B?KytWcUhnRWZtSFdDbytyaVZlZFBNWHZjWUxRbXU3Wk5RWnpjWC9lWFZPNi9B?=
 =?utf-8?B?NFVDcUdJOEtlak15U1RNeHNHMHpWcjVDOFNHbVJXVmZGUDJsMlNHRFZFalpy?=
 =?utf-8?B?WDh0UU4vN1NQdkRkL1JRWUcvUVQ3WXVBV3BmbEtOaU1zTjJiT0k0aC9MbUF2?=
 =?utf-8?B?d2JVcEo5cExtUUhIK0ZDNmF6YmlBRVAyNFVVQTNvTW9kQkFzakhjSGdPUkc0?=
 =?utf-8?Q?MBRM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb400feb-1b96-4295-2cc7-08de15589108
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 12:58:46.9329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +yHimX5bRyYIP7thpH9WUm6vSewx8h7g0mmta+MQqfq3Abp53iL2f6goYu75dMxG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9797

On Sat, Oct 25, 2025 at 11:24:25AM -0400, Pasha Tatashin wrote:
> On Thu, Oct 23, 2025 at 2:21 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > The existing IOMMU page table implementations duplicate all of the working
> > algorithms for each format. By using the generic page table API a single C
> > version of the IOMMU algorithms can be created and re-used for all of the
> > different formats used in the drivers. The implementation will provide a
> > single C version of the iommu domain operations: iova_to_phys, map, unmap,
> > and read_and_clear_dirty.
> >
> > Further, adding new algorithms and techniques becomes easy to do across
> > the entire fleet of drivers and formats.
> 
> It is an enabler for cross-arch page_table_check for IOMMU. There is
> also a long-standing issue where PT pages are not freed on unmap,
> leading to substantial overhead on some configurations, especially
> where IOVA is cycled through for security purposes (as it was done in
> our environment). Having a single, solid fix for this issue that
> affects all arches is very much desirable.

Yes, I have a simple low cost plan to fix the PMD/etc unfreeing
problem, at least for iommufd.

In iommufd there is an interval tree of IOVA used in the
iommu_domain. When a range of IOVA is removed from the interval tree
it can be normally unmapped. iommufd can then compute the empty span,
this is the end of the prior populated range till the start of the
next populated range and do a cleaning operation on the iommu domain
with that range.

Cleaning will free any table levels that are fully included in the
empty span. cleaning will run under the same 'range-locked' rules as
map/unmap/iova_to_phys.

This cleaning algorithm is already used as part of map, it just needs
to be exposed as an independent op.

Thanks,
Jason

