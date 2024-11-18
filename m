Return-Path: <linux-kselftest+bounces-22166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DB99D0946
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 07:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C391AB239AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 06:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E400145B03;
	Mon, 18 Nov 2024 06:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YnyGYg5y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90976DDC1;
	Mon, 18 Nov 2024 06:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731909948; cv=fail; b=Co2e+mijT338yFyF8pLBlDNFwZ+1AqtEOfY5PInyqZc05AZjnxODrMELB3ujE3EXsKGdmDRhlvePCRF3apaFv+9QPrCEx/i93pUtnEf30jN9f4MsrFdz+SUXhVnitrAvxKMkwjS8glKNXiJUA2maOkMz+7F3rKpPRpsHPyY5sR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731909948; c=relaxed/simple;
	bh=rwRju7gtgENzkg8vw6NjqE5goRlAPbHQjBPVOn7wO9E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JFewO7Nx/qvk1SHxRyyPP6QLWDFGcmws4nL6oD3MleRTtTxJcm0UbEeNZi6tfZJ/h51ajui4K9nZFQTYnhKEtrPz2qhRO8pGyqQ6/LCIEYUeOo/B7s4GDDwKgm/JO9LEcUp4/4iZd9JXzofDf9h0kziymC6jla/9dgnzgfF/gbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YnyGYg5y; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731909946; x=1763445946;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rwRju7gtgENzkg8vw6NjqE5goRlAPbHQjBPVOn7wO9E=;
  b=YnyGYg5yDkPprxuwYzWCOR/oeWTvEMXSgjxkFOYYisWzG4KmnxYOhoB3
   Gd7O6Bk76VAy4gnYBxe2oaEk4OWRimkxRKfoDKreoQJdY4HYHmx4DGJZr
   seaZaN0vR0zs9jnpF5mZ6YJa7iBQ0ihlnFzZYbK2qPYpGTnmMBebuBQOO
   4gqt08Cc9OKc92iHvDY6tzg+PZBN/zE+OwKpVpO2iSHlblvfgTZdzopvb
   Dxf4My+kuNxXg0Jhg7TQzcRhOVZdlBo0ZuBOEQMNwC2R1Q2XNvIvGPD+Z
   kT0xG/Vgo1RQn5sy4UE1NpsKBSvykRsrSOQ8jaaOlsZK1WWF6+TxjgyzE
   Q==;
X-CSE-ConnectionGUID: lbOql8kEQn+ZUV/xsRk9og==
X-CSE-MsgGUID: a0UrVLVoS1mbh4SyOEeWpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="42489980"
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="42489980"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 22:05:46 -0800
X-CSE-ConnectionGUID: 1RVLqIuCQ4qcDNOi8Jr4eA==
X-CSE-MsgGUID: ItyEW3RjTdmmCitBDiN9Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="119981082"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Nov 2024 22:05:46 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 17 Nov 2024 22:05:45 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 17 Nov 2024 22:05:45 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 17 Nov 2024 22:05:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HT22E52SVSFITS0gPWq/OCgEj8mov8To06WZhZjhyBf5mByTdpvvJoApX5ds9slgmoQ2bV+EebdVr6uJ4UjEP+2ezSesquzuyVPYmXf0PL1Y9wl74v0r8wpIHXRlep+NCuAZiw8obSOQxaj/H1fEQwq+ihsWCTYjxsuRVl32AqlLsA33mPoqtSqZAk/e/fllM2BbXPVRsCx/gthV5vnvgO7xOLiLbxsSzuwJiDaR6aQp8v2584Wt9w7soxJXY5PVVy8M8RolxmtNOcs7h9daLilPN9tO8DGPzItSOEsfG89Hn2Mg2fBsczGu5eoIA+158wXMkMcXRdtNCbniiuoyXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZQPokV68D9b83xyi1OcGy39qeadwQhlkTB5e9nvq/Y=;
 b=HROfowPkQRUkbFYqwzAKDccGDu/NR/YNH3jTnG8PytW3iZuwVMJNACCi//hr793kBuKu7Y3M0rSaP/bCCoLdScczwlQ+NQRF9IW2gtjr7RF6oI7UYKcpDnxt+bWmf2GgXKDJXuAl60fiyIuK76wgz2UqcOvaR8eUqq1Ijo1OhBM81yoAoHmjh3L53Cxpntz3QNHlDnGvb1QDEDya3/5Q0FF86wbZgSTQgu07AIMgMGwnxMQfWuxMna6+pyVago7yOxD52DGQUNWb4rZKRtnWTtRe20ZT3fyvbE4gFeTo9wWTWKW13kgaKqVpmL/6mC9uHSdbRFSSHBI2RJiw98HbAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB7498.namprd11.prod.outlook.com (2603:10b6:510:276::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 06:05:42 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%5]) with mapi id 15.20.8158.019; Mon, 18 Nov 2024
 06:05:42 +0000
Message-ID: <46d2d0ea-45a9-4179-bd1f-838c82af8d16@intel.com>
Date: Mon, 18 Nov 2024 14:10:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/13] Documentation: userspace-api: iommufd: Update
 vIOMMU
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <shuah@kernel.org>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <baolu.lu@linux.intel.com>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <aik@amd.com>, <zhangfei.gao@linaro.org>,
	<patches@lists.linux.dev>
References: <cover.1730836219.git.nicolinc@nvidia.com>
 <7e4302064e0d02137c1b1e139342affc0485ed3f.1730836219.git.nicolinc@nvidia.com>
 <f0c45d5b-b8cd-4f75-a9d7-21808f18583d@intel.com>
 <ZzVB7Fun48rGztuV@Asurada-Nvidia>
 <8f6cdd11-3bd3-4c4c-9424-c0d52eaa6f93@intel.com>
 <ZzVsEmzc1UyDdi//@Asurada-Nvidia> <20241114162010.GP35230@nvidia.com>
 <ZzfGLdgykZ0M3jy5@Asurada-Nvidia> <20241116003443.GB35230@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20241116003443.GB35230@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::29)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: a961edc2-60ce-4474-b2f2-08dd079708c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVNBMUR3RTRkcWN0eHgwVlk3dXVRQWhkQnFkeGh2eVFwYXZNcEtqQnhtbjhj?=
 =?utf-8?B?RVlKMDNSdk1FM2o3MFlLMVRYOU5wcEdZbEg0NzF5L2liZFI3U2RoRVord2xk?=
 =?utf-8?B?cUpqUUordk9mb1F3MEtjL25NZUM0L3J1K3R5Wm1JbFhaMURPOFFLem5iY3M5?=
 =?utf-8?B?bTlERlNLS2NsTHNvVkRQSHNld2pjTm1BYVVKYzUwbXI4TGRoaFZON3BTUWt2?=
 =?utf-8?B?T2U4S1ljclRNejltNzU3d2hFYnRBVnlMeEZNbWcrZlBYb3NMRUhEK3k1aFUw?=
 =?utf-8?B?K2Fyb0o1NytGQ0tTa3ZJR2FnWEJ5K2NKMmt1Qno5ZHBYakFIN2ZLRXFDMXhx?=
 =?utf-8?B?NksvWmJqcURUOXl4S3Q5L2s4cGlNNkhFTUxhbGlUUzY5ZEcrbUxYWWxCcWxh?=
 =?utf-8?B?TUlSR1ZQZWc4Wm4vS0JNK1Yrd3RuckllNGxPa1RHUUs1ODdkZ21CcUNNdmpq?=
 =?utf-8?B?K2pxYXZyU1RNeTA2aU5JLyszYnFvb2RFWTMxRnNhbFJJYjNnMnl5clYyN01y?=
 =?utf-8?B?M3MzbEdGZmpQbWptUERQZlIrZEVQNHltY0hWYzFEd0dnZXhXRHo1UjJUZjUx?=
 =?utf-8?B?Um9xeVZvMzlHckhBeXVqQyt1UU9UVVhOSlVMRW1xNmJMQ3BWakVHNytoK2tS?=
 =?utf-8?B?bWFFZnVHMXZlYTdWSlc3Z25BOW9ZTFErQUl0a1p1VEtyQkp6dWIyaWpvNDRy?=
 =?utf-8?B?N09GZDhlcnhRV2d4T0lkZ3N0M2ZZWVFNaUI5UGFGYkVZME90SXN5azc3d3c5?=
 =?utf-8?B?ZWhoeCs2cEY2cDlkbytpSlJtQzlpdGY4bnpkSTJiZ1JZK1lrOTJhTkowazdq?=
 =?utf-8?B?N1JpNmNWKzhXd0swOTBlSlNJakVKejNoK2VabVFIYU0vVU1rRE94dzJKUmxL?=
 =?utf-8?B?SkJvZnlBYkhqT1V5K0pEMEt6RUZOTEsvWC9nY2x0THJZZlpLd09JakYxek5p?=
 =?utf-8?B?Z2NrN2N1Y1Y0cW5rWUlWTkVManNEQU8rTGRkUzJEcnlYbUJvazdkeVdJWnhR?=
 =?utf-8?B?THdUYy9URDVGMXpYcFFQbEMvNmxuUHdWY294Zmx1enNnamlsY0ljMUNHTVdK?=
 =?utf-8?B?Y2djM3dWR3JtSExOK3gyTWhtUDNiZUoyWE5BME1nZnkxNEhhS0h5UmIzR3da?=
 =?utf-8?B?bkN1UmVwekNWVDRlY3pselZEUjNycGRjZzFLMVk4aWtMV2VpTEdKOFZtN204?=
 =?utf-8?B?Q09HNjBJb1RaNU8vQzlFYWpwdHFmVUl2SE1KNDFucVhQeDJkeVV2bnBpTEVv?=
 =?utf-8?B?ZjEzdHU1dVBIUmtpb2ZhRTV2c2pXMkN6dlRvbU5rU2xxYVVjYkV4NXcwcVFQ?=
 =?utf-8?B?SU5iaDRCaEh0RG9RakhiR1plTFR2RHBQRzlHYjN4Tk5POFo1TGExTXNKS2hx?=
 =?utf-8?B?MVZsajA1SlNzdkYweUk3NzhMQVhSU1UyL3ZrRzBiN1V2dXNuMC9pb0ljc3hZ?=
 =?utf-8?B?aFphTGxSWHlhdFEybEpoRzEySCtSNENkK2w3RUpBZjUrd2Q5S050OUJKSFBZ?=
 =?utf-8?B?UEFVWGZqTHI0VDRDT3NacXlQY1BnenVTcmJKd2MyVk5wbHpLK21VOStCY0tM?=
 =?utf-8?B?cWloUGxLN3Jnd2I0OHc5aStHSmRja0NvcGZiZitIU1pBaExaOVNERXNpNkFO?=
 =?utf-8?B?RlRpKzdabmorZHZDNHpmNkhUZmRVUDlpYkorbDUwWFE1WC84cHN0Q1FXVGN1?=
 =?utf-8?B?a2hoVzRqazY0emY4MEFxMzZMb1NjdnQvQnFrWkJYWEIrUTYvWElYYUtJQjFJ?=
 =?utf-8?Q?ijvOdUVBNb5yk3dm6EXJMMet+LgO3RlopWoDC57?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K09rdEpKTlFWMCtmQ2N0RVY0S2lXeTNqMTI0UllFcjZ5S0ZvR2ZKUEJnbHI4?=
 =?utf-8?B?dmhPMlQ2R3U4bDZETzhOczc0WGxJdE1GNFo0S1N3cnF3amFwdGR0cm1oakd0?=
 =?utf-8?B?ek45VmVJY0lLMEp4aEM0OG1XNm1WYWpzeGVZeWlmWDFrS2ZJUzhyQ1d1aU1s?=
 =?utf-8?B?RTc2Z3NqbFIrOTlGNDNPRTVkejNraGFDSTlGSXVzUWh4cTFmZld5elhndE1P?=
 =?utf-8?B?RS9TT3g2enRyRS8zeWV4dWF6Vms3c3NubVdOR3hSclZWTWtNZkJiaWt3K2JI?=
 =?utf-8?B?ajFiYzBTN05pSnRjbzJMU0NONUhSRy9zWFAwdkxUdVRleDZ0UVc4Yzg4Nm5t?=
 =?utf-8?B?b3E2MFVnRlVyM3VtQXJKUmVaZXczUVZxRFZKUEFna0JqQ2dEbFlySXBoNXJs?=
 =?utf-8?B?UjFGdXJ2UlRWM1RTQnRSb05jWUc2YVF0L0FxM1I0cWNGOXI0TGVjYlRncjN2?=
 =?utf-8?B?YnAvbmt3WWdLcjg2RkhqMVoxYzJGYkZ1NHdrbXJtVzFjcE5wU01CVndvV2JS?=
 =?utf-8?B?ZG83cFQvYlFWcXZEbGlxQ0RiTmhPYjgxaDU3WndHbEVZUHkwK1ZDMXpmSTZH?=
 =?utf-8?B?SE1pa25PS0RNOTlRaytJU3VHZlpRcTNpRTh4eG54L3QxaGF6MTFmRllsK0Zh?=
 =?utf-8?B?b2NvaVhLQjhGTnNzVE94aWs0dzE2SXNWdzBJUjk3SVM5b2hLK1VxWW00Mm5o?=
 =?utf-8?B?RkJCbjNWV2M2ZG5TdGlFSVlhV0wxekNlZDhMaVlBcVBvNVI1Rk5ndXo0dDRu?=
 =?utf-8?B?bHJTbHJIUU9XMkJCNkJNbFNqWEZEZk94Sm13NEp4cU91V3RWeFJQZmtpRGp3?=
 =?utf-8?B?UnJKUFZnUmxRRGs0dDRBM2oxMjVqWDR6bG83S3FrMnE1akFZZEh0dkJtbHc3?=
 =?utf-8?B?dXFRQ2ZpcUV0Tnp0YUtZd1hXb3RNNGtUSTh6bHpLLzQ1amxsRnkydjNKdlYv?=
 =?utf-8?B?ckV1NjZnNTNsN28wcFJaZjR5bmNvaWdtQmJuQmpvMjU5cURQdjU0SjhHT1pa?=
 =?utf-8?B?c3A1eUxqRDYvWHZKYjYvM3Y3eEtlSWd0WVhDL204Ui9rZzR6YUU3ZDZ3WU9L?=
 =?utf-8?B?UkZZc2Z5a3lrVjVKR2t6SGI3Z3JqYXZid2FIQWJzTll3SjQ1bUJaNFNibXlD?=
 =?utf-8?B?TkVvcFdKNkx3cVpBSm9SUEh4OHJRN3dyQS9Ud1FCZlpPa0d3Um5sbWxLSzdt?=
 =?utf-8?B?K2hOV3dZWTdFNHBLVnIyNXhWcTRrWkhVbHJSempaTTRlaXNIYzN1RVVmV0lj?=
 =?utf-8?B?QzcvTDgxTFhJTG5uRzdLS0RQZWxGV2Z5dWRqdHovWnhhclp5Wm9CdXVya2Nu?=
 =?utf-8?B?QWJpekJVZkZCTW5Ma0taVGRVM21DVXpUVENkWFpqNlJzYy9rVDNRNTlIOG1I?=
 =?utf-8?B?ak9hOFJCaVlJdjgzaUJRb3hnK1JpYi9lZ3RWQlZERkhBK1crYUV3NVRyNUZI?=
 =?utf-8?B?MnZvNjhWY1dKZGVMM2lRY0J2VVJGYWViUjVrM0p1ekh1K3J6bEE0Q3B1T3Fw?=
 =?utf-8?B?dFlLR1F5ZllSNDZyTXZHL0VHdmRxMkNOY2hxYzhhVVYyMFl3Y2VCTFYyTmVr?=
 =?utf-8?B?ek4wSmhKSk1sMklUcUJkSWJjVW9zczU5Zk1ZNDBQMlhXdXZVeW1sRXFmL2Iy?=
 =?utf-8?B?UTA1bFlxRGRxS1NsYW1ZOEJDRlRjaVViNlZVSjlIYjhPdVlUUzhRNnBxK0E3?=
 =?utf-8?B?NmwwRXozMlpyU2RsY1lTaGVDNEp0eFl0bEVCQnRRWTlwLzA5MExnQUR5UUdK?=
 =?utf-8?B?Z1NsNzRRS1BneGI4a0h2L1hjYnE2K1NuTEx2eG93cnhYa2JxZUxBOFlXU0h4?=
 =?utf-8?B?cjNZUkJIUHdDcGFxQWZFOHNlNThYUFFtR01WSGxkZUxWQ3lvNklSL2Z5c04v?=
 =?utf-8?B?UTFub1FZQlJ2d0YvNlVTbjlBdTVPQXVieU43SGNRSkV3bGcrWHVjYkpiOEdm?=
 =?utf-8?B?SnNON0xMbUQ2N0RLdWFBNDBVUXl0NUFlR3hMa0ZqR1Z6ZVhab1NmVmIzcFZP?=
 =?utf-8?B?ZzhhVVBtcGxGVllyUzY2d2pqWUdZYklub1Z1aTgvVGMyRWhCOFhzc1A1RFRY?=
 =?utf-8?B?TjE4cVhURWJ3VEozMTlRSXFSZi95TVBTVUIwLzBQa0cvOGEvWnVHQWhqSDlr?=
 =?utf-8?Q?+gPvcCzXM3iD7ALrQoluHD7Qk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a961edc2-60ce-4474-b2f2-08dd079708c0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 06:05:42.7882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYy0S04WDKeo0bqCxAigVDtaqdMaoUXVY0YT+ZKdyvIXjD7ESXrxCzzIxuSNw9u9lsHvm15WsBLoyPqcu9447w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7498
X-OriginatorOrg: intel.com

On 2024/11/16 08:34, Jason Gunthorpe wrote:
> On Fri, Nov 15, 2024 at 02:07:41PM -0800, Nicolin Chen wrote:
>> On Thu, Nov 14, 2024 at 12:20:10PM -0400, Jason Gunthorpe wrote:
>>> On Wed, Nov 13, 2024 at 07:18:42PM -0800, Nicolin Chen wrote:
>>>>> so the user would try to create vDevices with a given viommu_obj until
>>>>> failure, then it would allocate another viommu_obj for the failed device.
>>>>> is it? sounds reasonable.
>>>>
>>>> Yes. It is the same as previously dealing with a nesting parent:
>>>> test and allocate if fails. The virtual IOMMU driver in VMM can
>>>> keep a list of the vIOMMU objects for each device to test.
>>>
>>> The viommu object should be tied to the VMM's vIOMMU vHW object that
>>> it is paravirtualizing toward the VM.
>>>
>>> So we shouldn't be creating viommu objects on demand, it should be
>>> created when the vIOMMU is created, and the presumably the qemu
>>> command line will describe how to link vPCI/VFIO functions to vIOMMU
>>> instances. If they kernel won't allow the user's configuration then it
>>> should fail, IMHO.
>>
>> Intel's virtual IOMMU in QEMU has one instance but could create
>> two vIOMMU objects for devices behind two different pIOMMUs. So,
>> in this case, it does the on-demand (or try-and-fail) approach?
> 
> I suspect Intel does need viommu at all, and if it ever does it will
> not be able to have one instance..

hmmm. As long as I got, the viommu_obj is a representative of the hw
IOMMU slice of resource used by the VM. It is hence instanced per hw
iommu. Based on this, one vIOMMU can have multiple or one viommu_obj.
Either should be allowed by design.

BTW. @Nic, I think the viommu_obj instance is not strictly be per hw
IOMMUs. e.g. two devices behind one hw IOMMU can have their own viommu_obj
as well. Is it? I didn't see a problem for it. So the viommu_obj is
instanced >= hw IOMMU number used by the VM.

Regards,
Yi Liu

