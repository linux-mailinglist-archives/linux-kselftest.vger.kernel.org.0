Return-Path: <linux-kselftest+bounces-32656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5D6AAF96D
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 14:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 300924A69E2
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 12:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFE822425B;
	Thu,  8 May 2025 12:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bAmCPKvZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4135199931;
	Thu,  8 May 2025 12:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706338; cv=fail; b=htMyqS2yMiHStPguoVcjmZrkU2BgqJY0o529EYAJ+2VplLcechVb7n8P6VMgHzryVyIyUkOl9Cp6SYbJM6j679Cfoe9+P+kymzjNityoxkU9Hi0ieHN/AGNBHmpbiv0CzAzZyXRp2kCR2Me0MxJxoAIGuSvXA8FFiXOlj4JD2r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706338; c=relaxed/simple;
	bh=Fi1lunk0VngbCWpFi4QiYdPScWDlNH+qoUU6hoAm0bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NSV3b2f+/zLGBbmwUp5+FLpaILO9o0K4kkYE4dLMxB3u+DwJ08KupJ/D4ncgZwS7aNGNfmglMX0wO7jk/X/Huj/BF50A41y6mYr6jYSFow2ZVBhIqGcUAqODyx6F1dACGdODkPfreT/37btFB9uNy1l3/OTejuqKQnO9i9O07II=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bAmCPKvZ; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=poG2xQRitBWi+99VlJ03xh+dzzYKCfpz84R9jJuTD2Hhb+dZ0Bn+vO4eOL8WpvmwV+8EGrYVoL/CQf1hh/ZN9l29CMTfltvNRNMyW8IXTWocmrHBG9bShlHzOMCPm0X4F4E4hK/2j5YMPUzHKhSdpXwF5YsC9PlQnMlya2CcmKWDbTMV7p4BUdgYzP//i1JcFQckFN1/7cIFGiPmYJ9urwZzLe6t9mLPQGQgOq2UwEtsFd0uP7OkaiFp9K4p25jj7qai4N4jKbhJkIcQLlDCTCw97XQrEblLMk1HmzFsxsolge4j2aSGG246DiFRv1O3YX8LkJMtKWIsZFTfNcZCOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdcZk3AmnU6fy/QXAs1E/N+YXMotIaR6Q3oj+2zBQfw=;
 b=yraljiTpTfRo1g/IEIOrHVNGggt8GzpdGSh9UrD9PY2XUDLzyEiU4kuNRe6u33J27W7lii5g4qdtJwo6J6jR0x9td9AgjT2JjRTj3UFemULkozOJzd2SztCV75NP1+9SDiYuauocASgHurbWB3TKrwZBB4q1LkZeSvbhxdcMkRKcLv7GOHEgh4u4RfQMY2+JyNHJ5xdypnMYmzyevrU2A2SAUS6oZi+hAu1LKcOXPrWu+FJ6Uy6WDyMGk2y0rZIGBcrpnuFVfAWnM+uq08Vh/ol3Pi0BJEum0z3DAWCh7IR1I3FoiwQZJBVwI5PJvLhOheypFs+vYZsPhgQrBFFuKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdcZk3AmnU6fy/QXAs1E/N+YXMotIaR6Q3oj+2zBQfw=;
 b=bAmCPKvZnA0iQHSNwdV5PgbpidAls5/MYQAV76BF5QoyQdWBhqW2juAJynsOVYQG4RDI3lp6ZWDlM5sitPuXeVtDmB1dGUGzlg2CLORpa32JYdPHWBzrj1ZZDg+zikJFk+/mPMMO2doTLQ5d+iRdhy6sw10MIuIl+abRMJHeFAPE+6N6R7KRfYKWfs1oUY2bz0ufd3sp2+mBy/lsonU8S1Ks9HhOkY0Xii4nM2IRVgs8q8kF1RsmGxIfkfu40W69QbDWMnwbIQNjpY30wjc0Q4MqSwkPi9rXmOeSw+OLCiJFWqa7TBX1GR4ll9Wx224xJJUBkqMYA+zraGawb6YPyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PPF4D923B935.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bcd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Thu, 8 May
 2025 12:12:10 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 12:12:09 +0000
Date: Thu, 8 May 2025 09:12:08 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>,
	"bagasdotme@gmail.com" <bagasdotme@gmail.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"nathan@kernel.org" <nathan@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"mshavit@google.com" <mshavit@google.com>,
	"zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	"mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 13/22] iommufd: Add mmap interface
Message-ID: <20250508121208.GA5657@nvidia.com>
References: <aBj1Av6Xaj8flMN+@nvidia.com>
 <20250505173101.GT2260709@nvidia.com>
 <aBkWoH23VysYake3@nvidia.com>
 <20250506125222.GW2260709@nvidia.com>
 <aBpjbtRgR1nK/LIm@nvidia.com>
 <20250507123901.GF90261@nvidia.com>
 <aBvMC7dnYghoX5Aq@nvidia.com>
 <20250507220809.GB232705@nvidia.com>
 <aBwp0JviKskqbPXz@nvidia.com>
 <BL1PR11MB52711314C2A6E1C55AE694288C8BA@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BL1PR11MB52711314C2A6E1C55AE694288C8BA@BL1PR11MB5271.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN8PR12CA0025.namprd12.prod.outlook.com
 (2603:10b6:408:60::38) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PPF4D923B935:EE_
X-MS-Office365-Filtering-Correlation-Id: 6528100e-314d-439b-0205-08dd8e298eae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXUzT3RpRUhpa3FkOGF1alo2dVZBWmhFMzNtUU5BKzducmhpVUpLaGtSRGtn?=
 =?utf-8?B?MU1ZNEFXbktaTzQwdURkMHZBUTJLRzBsdG5ueXFJbCthS1R1SzNja09WVFk5?=
 =?utf-8?B?S2M3VXpUbDhUbThJR3dXNGNuSVZmdWJhWlJWVXZBNXNzRVJhLzVnRFhuWmZI?=
 =?utf-8?B?U2FGd0UrWFRBcERURytXWGFqREoxMlh3aEc5RlZUaEVzS0VPTWRONnpWRG4z?=
 =?utf-8?B?QktTZlNxaUcxc0VGaktJaGx3bjdtem1BT3czWld5K1o4NXFqcEt5SUxrT3R2?=
 =?utf-8?B?T1RMRUpXWjVzYWF6WFFock5OTEdDTDVDcnFTajBYMXNNWXduWm1rQlhJZTZ6?=
 =?utf-8?B?NnR2T1BMbzNvUjRZNHFIQlRQUnRtVmc5c1NpamRDVDRobm4yMFg3RkZHQk5C?=
 =?utf-8?B?SUQzZnBiWmRRSktQNFJmOE9OU1U0K2xYeC9ER2owRFZnR2NNZ2FON1o2dyta?=
 =?utf-8?B?cThhQnd5dVlQUUVVM3dSd20yUDVod2syNU5wZmJPdGovZXJ5V0haK3paU1pO?=
 =?utf-8?B?algvL04rVnhhdEtldW9nQkMrZFJ6TTg0cHBRcDIrc3VRZi9PVGd6WVJNN3Zh?=
 =?utf-8?B?eU4vdGJIclVjeUNPWk5jZEU1YVBacXhxL3grUGZhY2RxNHpBbGR4eTBIaGZi?=
 =?utf-8?B?bzU0R2VJdkF5SzJaWmFtVTRhMGtUY013TDVMazJpRW1ZSUhCMFZ3NzFPSjho?=
 =?utf-8?B?MGZaU0dpYUYvNTRybUgvTFJBY1FrOUVyeXhyV1JLMkVWdW9sekc1QUlOOG1E?=
 =?utf-8?B?azZ0YWQxblVlSnk3NTJXY1IvSllBakxyS3FYVGpmMHgrQWZyT3VoL29IOFRx?=
 =?utf-8?B?QStQZmFqZDRHbmJ3eWpGT0t2T2JiaHB5Tmt5Nm9HZ1JXSGpyVDNBbVh4cmZI?=
 =?utf-8?B?dDdlbVFkQzYzNGZxVnZVQmI5RUtxVG5PZlZXNVBZUGROSTVkaU9zb2ZIK1J1?=
 =?utf-8?B?elZKUmhUais3OVczb0x4OG5tOTJBQ0o4dDBodElTM0lUajlWelEyZXdBakJV?=
 =?utf-8?B?ZkwvZ1UyNmMzeWxDbmgzY3h5NjQxMEFBSnlkbE90Q0kxTk8wUkdGbE50SmhM?=
 =?utf-8?B?aERieDFkdHNEWTlCSC9YYzZCK2FnNmt3bS9veHBtRFdNanJKYnhna2krOHBW?=
 =?utf-8?B?anJ6eVhMd3F4MmtHME11UllFMTluMmxuRG04K0xZWFpTV0ZuNTN3cHNMZjB3?=
 =?utf-8?B?L2pDbHNSSXpibFlNTHZJOUFSMkxtbDhCeElGbjQyRUZTeUpYd2tOQkhmMWta?=
 =?utf-8?B?SmpyNGRCR0txKzUrS0h0MVRNY3RCa2N3S0VlYTVjakJoaUlheDFwV2N1TitB?=
 =?utf-8?B?b0NHeCtjV0pkMitVOFlqU0d1NG11a1paMHVhcXZ1QVVJZzNsaU5lb1crVjcy?=
 =?utf-8?B?dUZVNXp2cDFkSUhtc09CeEdrbWZab245Vk1HN0V1UVNBS29LWGcrK1pjZlJU?=
 =?utf-8?B?QVZnNk1pU0FaN3NuTXdKU21hSklQekZnSGVVckVsanFWZ2krSGxOQkJnME5L?=
 =?utf-8?B?dE1HNG1oTDV6OStZTHNUbmUzWXMyQmJkL21ObkQvNjRRSmE4Vngydi8zUkFt?=
 =?utf-8?B?S0FLakRZODBrVkNnUmZlMzdialZWS1R4ek5mOEdEcGJkaTNBQlpjVnNmTFh6?=
 =?utf-8?B?MlR5RGxMamFDL29Uc1puaktjd2FxZDYwcjFxcFBEU201QzUrcis2eCtBTUxl?=
 =?utf-8?B?NGovQkVYaDRNUWZuWkJ4UHVLcEs0cmFmM3pOMjRWYkpnQ2JLMTRtR3Zod1hu?=
 =?utf-8?B?NDU0ZloraXBacTNqY3N3Mlh5TmpzeVg1U3pIS0d6UHRCTlFJQnNvZ2xZZWFl?=
 =?utf-8?B?ZUU0b2xpVTl1SmZTaEZ5WlhZRzYyaVQ4NlhUNU05Yk5FY2FtTkM2TnE0My9U?=
 =?utf-8?B?aDE1NkE3WS84dTI2NTFlVnVNcERUZTI0S1pqb1d4aTJVZTUrbkp0M3dSOTB3?=
 =?utf-8?Q?voxt6Z2B4dQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnhaaTMvdjVlNVVTT1lJV0EvYzRXRTBGamc5RFRINXlydkxsdno1amtBMUZs?=
 =?utf-8?B?QjJyUWZ2WFczbmdobVJ0TEw1VElmNmZkTllPNEtRRUNaeVBlYWlpN0lwTW16?=
 =?utf-8?B?ZFgrZDFNd3VMTitvaFE2TkhvYUEyeUVSR0VoL3BOVjVvLzF0RzdmRG5aT1Qx?=
 =?utf-8?B?UEVXdkRhNVR0TlJDbXpWL1g1aHk5Tzg0UTFnU2FQTC9na3JaSFFkeDlZWVky?=
 =?utf-8?B?T1N1WXdwcXNqb2lxb2s2TTJsajBja2xid3E5ZTRQSWtXVWpJejdXL3dCVzN3?=
 =?utf-8?B?VU5ic1VHcWFuQndSa3pxSXZrV0lzZnBJVDZOeXRNS1d1dSs4eWhXT3pwbE9u?=
 =?utf-8?B?Q0pKSFU5RWY0MzZaU2lhVUFBSVBuaHJrOE5sbVp1ZVVZZDFySFFIV1ZNN2Z1?=
 =?utf-8?B?Zi9xOW5NdzJoYVVpa0p2TXdveUFaRzQ3YWFaTGlrcnc5K3pRSjJwdTdaRGU1?=
 =?utf-8?B?NG4xeGJDOUdLRXVmVCtSazV3ZE5mOWFaMmlWdk91bTlLTi9nM1RYYlVod0J3?=
 =?utf-8?B?VWhFTFY3MkdMcDdGYlpkcXFuWXhaOGMzV3lOZm1XR1BGbDV0Z3cybzA5QTQ3?=
 =?utf-8?B?WFV2NzVEczJJQTdKN2tRditRZzFHSUliRXJCTTVvM2pPM3N0TmFaY2hZbjRN?=
 =?utf-8?B?QVhIemJBU1Y3RUF0dEZEQjhyaGxZUlgvZnNpdHVJeGtIUkpBZzZxM0gwMnVv?=
 =?utf-8?B?MUJYVmxzTnlzT0lmT0RhT0JjSDliNDBsblpxaEdRLzIyT041MEVCaDlNemFZ?=
 =?utf-8?B?Z0MyYVAvWFZDWHYyQUU4QmhjWURMRlhsbEJCbEFvMW5Vd05adUIrdGdtRlBi?=
 =?utf-8?B?Z2JhNitKYmg5S3oydGxtY21URys4OE91N0ZmWGozZHo3QmFSWDFHQlJORThO?=
 =?utf-8?B?NzZxclBTOTZuTlRjS0swVHV6bEpiL3hNY3ZYOVU0UmRCODdOSnQ4UDI3eEp4?=
 =?utf-8?B?WDl5c1lRRHp2NTBZbkN5dldGSTlvUGdSSUxsYm95Tnp6TklQOWFsYnZTdkp5?=
 =?utf-8?B?NU1jRnd6eHh3bUV4eW05Z3pDb3NCa21xUk5ob3pHTEtwd1J4bUtYcUszR2ZC?=
 =?utf-8?B?RklaNHYrZmd0T1U3K2YxWk4rdWZUck5GL3BtMHlLMklrUEtDaUUxVStFM0ZR?=
 =?utf-8?B?dEU5b25idTY5Y0JGcjZHOUViOWNYK25Vdkk2YXh0cFhzUElCUlpndzRKT1VP?=
 =?utf-8?B?a1BDSHVYS29hZWJCTm1veG5SUTJmM2lhYzNqdm16aEZseHNzQnpETEJoRW9M?=
 =?utf-8?B?RERFV2NQSW5pVGEyNGlGVEpYelh5SFMwNEhLQnlrcmtaeHp0UHUrMmZBMmxW?=
 =?utf-8?B?ZUZaV1V1bklKOTZPM2t1MmsyeWRsQVN5N2VLdFJmVm5JZlltZTduNTBRZnc4?=
 =?utf-8?B?Z3IvYWNYT3RYSWc4WFJ2RUQyU1lFamZFOENlK3ZiY2Q2azIxc0pKanh3cmZ1?=
 =?utf-8?B?d21rcjBObFpPdFFCYkh2NW5mdHhYbkFZYkxvNWtXb29xOENYMkN4WmFTZUpq?=
 =?utf-8?B?dFNGZjlJaWdDQ3IrSGR5ampjSGp3SEc2Y0NxMkorSUc2cFRrTFFyemRVWWxO?=
 =?utf-8?B?R2ZvZjA3YkRWK3hFNnpHSTBYSzY1NmtGR0ttSHN4ODFLbTA4SkxNQXkvUVVq?=
 =?utf-8?B?dWV3WUZUZ2Z1cUdkSDk5RXNXQ1czM3Y4MzRGd1N5RGVBMHpidWxzWVozYS9M?=
 =?utf-8?B?YVVVM1FiTXUxTmFjdlkweS8vTFBhUzJmTjdHWHJtWkNRZC9ER2pUNzZNSWxY?=
 =?utf-8?B?VThUWmFVQzJZZ0w3YTZZME5IMGQ4V29NSFU3YUIweUhMVnZHSi9vWGxHMTVX?=
 =?utf-8?B?RVVMcmtMRWpnNUtuVlpsZ0IzY3A0WFpQdUl1VHQ1cE5uSmVkSVFydjM5bFhD?=
 =?utf-8?B?bm00TStlM1NGVVZ3aEtzQlZRTUZkS0VReFFFUVoySlBEdGk4ODJSQkd0NDg5?=
 =?utf-8?B?SENRa3RvSzhjcG9mQnduRUQ5ci9teDZXaUFNMEw4Um5naE5udWdLS2NValRI?=
 =?utf-8?B?WDd3OWxUd0ZmYjI3QmxaSU13eHRXVVlUV3d6WWI5eiszV0xGek92UTY4ci9u?=
 =?utf-8?B?N3dYb2oyVXRCU0oxSVA2S1pKTUV6VnBIVi92c1pDaDdkOVRTZUFOU3lvTHly?=
 =?utf-8?Q?MJjQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6528100e-314d-439b-0205-08dd8e298eae
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 12:12:09.7727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYp7NVle0ERxuwi6enQQp/d82jhJfoQD+5u11bz77jodNW8+uFeb6SRASU7HrS3e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF4D923B935

On Thu, May 08, 2025 at 09:15:47AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Thursday, May 8, 2025 11:50 AM
> > 
> > On Wed, May 07, 2025 at 07:08:09PM -0300, Jason Gunthorpe wrote:
> > > On Wed, May 07, 2025 at 02:09:31PM -0700, Nicolin Chen wrote:
> > > > I have another question: while I don't think my code is handling
> > > > this well either, how should we validate the input address is an
> > > > allowed one?
> > >
> > > The pgoff to mmap? If it isn't in the maple tree it is not allowed, if
> > > it isn't at the start of range it is not allowed, if the size is not
> > > exactly the same as the range it is not allowed.
> > 
> > Kevin suggested to allow a partial mmap, i.e allow the size to be
> > smaller than what the cookie describes. Yet, surely the mmap size
> > should not above the allocated size.
> > 
> 
> let me clarify - I didn't suggested it. Instead it's what the code 
> does hence I suggested to make it explicit. 😊

It is probably reasonable to require the pgoff to be at the start but
allow a shorter map, for forward compatability.

But also, you could add flags to the ioctl creating the mmap to
request future bigger sizes.

There is some appeal to be more strict to make misuse less likely..

Jason

