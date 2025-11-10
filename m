Return-Path: <linux-kselftest+bounces-45216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A92CEC46303
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 12:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE52318856DD
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 11:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BD93064AA;
	Mon, 10 Nov 2025 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OhJKB/h0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8DB1D5141
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Nov 2025 11:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773345; cv=fail; b=hylwYbt4asF85uJeQcDhJBeXYWQENAqMq5FM2MyPSfBy6Lb2tXlU9o9YRw5TEFY93mo7Dy36ppLI2rINppjC/UmxTEWb7fPQp0EtUHXPX0Kj4KNsPTnHjQdEJhR74n7odNHnnyuMshPO69PotCDIN5dfMCCGGSfn8o7VKjyDAEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773345; c=relaxed/simple;
	bh=m9VKJiu7gq/VvVEpGbTf1GBiSmFyLhrGKi2uMMS0LXk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U676Bh86ByfDUX6tLmn2LnNCTExp5qn+pmOzthrJoVriK26k0hCNr4+T/FdWnQ6QSz3MFUfESdz2nbiEjLNtq3t9Pk7DzsSq+aw8btcKSDEFm0CrbUxx/Lgv35kO1qEWg0HlsueW5JweD+XB3WVZjfHLMXU0JNwLZeesvkyESpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OhJKB/h0; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762773344; x=1794309344;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m9VKJiu7gq/VvVEpGbTf1GBiSmFyLhrGKi2uMMS0LXk=;
  b=OhJKB/h0XfZpr6CkYQ9bdUSTcGxc7LFhpdwubLQLkFHhI551e6DI1aqE
   mWSy74FZSWlnzIbTbKNmfTXf9mjYrbOb3iSrYjMj5TliG1/TsC6MsaOQZ
   sMkM/rjcZLAah3Ovg4nVvcbabwQ7ilKsaz/gzfEiFz2cYDeCIz/SUxZ89
   7X6pZ4OJMI8Z//Ir9ClcspSdJp/lC/UOaExAok8TpudiJ3/I9Z1QcspMM
   kl7brvs+1Ro1UkCUTl54unAHW3ucB4RBafDlm67z+QsOwGJb17LUjSkJu
   DQAeXdCVsaD1L9fb5Ci8JMpto0wLR1+RIM/ztmPDf9gqsHgStivq1ElcV
   w==;
X-CSE-ConnectionGUID: aHzj8x/yS5io1ovU3AkHHQ==
X-CSE-MsgGUID: YS1JLXXaT4KJpw2odb/sKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="64702715"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="64702715"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 03:15:43 -0800
X-CSE-ConnectionGUID: Vw5eLl1pTcGs0a99zAI92g==
X-CSE-MsgGUID: diACgJSfQ8KZrxdhafMmwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="193829808"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 03:15:42 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 03:15:42 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 03:15:42 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.69) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 03:15:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFIdMoMeJ/zXka+vyomBzgf8aB5DwT1dLL4+AEzO4IKd8w17aDjRPl4JvLZBn0RJA7z12sA9t9/N7ja2SsBSoU/z/ZraWLJDE/l5G7kvvNhRZeyOU1bp/Ioyf3zqJhXO/fmVBn0GsRfsgnzGLNXuefeEqgSscdJxCIPYFD1rNru9K91863Xq00FngfoMXS6LRsnOfUmWIdAzqq5ur8DP3qabR/xpI+IB+jxQ3HWB5VHKhXxy8+xHigwP9fD0e5WVmgI9lnlqfNFJoNJ6NBYKFPm/K1wwvs+JfbEiR6SPYdHvDquZizGA7cWZJnwRXUhFs5iegrn6OR5liD86fRRa9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piacjMFMPq/Ydk8OwDu2yjj/foL5UFwu28FxJpY4Hlo=;
 b=GdRv9mVLvqXyQsrGAB0DEcISp/JVa3MVvwUfIzQHTdx5RJsNdKLzrnIkdTcfdxVBkKYuY8xR7smAObDqlPrN9bee43TB/hTSN3fdkbTogxgqovfsSpE7vlyFGmT+fEIqx2d8Yi7mFHTvO6QL0sNA9xng/GckNDt++3F+XYgxKKFYXRXtCm/tvzcc9/IdWVR2x+Tb84rNV69NogT6pQUxfRgHOT6ib05TINtyqMbcRsyqliKZvrbLK6vb3vXK4ZboGCw9n065y7R4H6MPhtAzVUplVcsieW1NKsAB7oXbOaaEJzXpzEzntlb/s7dccmdnLGnxdjfj9IH7rPCZkpjRaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by PH0PR11MB4998.namprd11.prod.outlook.com (2603:10b6:510:32::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 11:15:40 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 11:15:40 +0000
Message-ID: <c31d494d-dabb-4490-bb94-f8357c5e2dea@intel.com>
Date: Mon, 10 Nov 2025 19:22:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iommufd] iommufd: Make vfio_compat's unmap succeed if the
 range is already empty
To: Jason Gunthorpe <jgg@nvidia.com>, <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, <linux-kselftest@vger.kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, Will Deacon
	<will@kernel.org>
CC: Alex Mastro <amastro@fb.com>, Eric Auger <eric.auger@redhat.com>, "Kevin
 Tian" <kevin.tian@intel.com>, Lixiao Yang <lixiao.yang@intel.com>, "Matthew
 Rosato" <mjrosato@linux.ibm.com>, Nicolin Chen <nicolinc@nvidia.com>,
	<patches@lists.linux.dev>
References: <0-v1-76be45eff0be+5d-iommufd_unmap_compat_jgg@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <0-v1-76be45eff0be+5d-iommufd_unmap_compat_jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0026.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:5::7)
 To SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|PH0PR11MB4998:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f167e37-d143-47b0-6f52-08de204a7b7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|42112799006|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amx5V3lFV0JvT2xUTGRQb0d1dS9CYzdONWZNMXRsN0FNZEdJeWhEY2tveldR?=
 =?utf-8?B?cW1NTUxuM0NYOGN2eWZWbHA0RE40NHo5czhscFpaSUxrU2d4em5peHUwS1pq?=
 =?utf-8?B?V05nMlNHTXh3SXRmK0ozN3htbThTN3BVYzdpYU5qSEw2Rks4bmczS2tlRDY5?=
 =?utf-8?B?aWE1YUJBVHROcmZUSm5Idk13eUtmMGZZZDE2S2FDbElJQXd4UGVTNWptQzNJ?=
 =?utf-8?B?NHV4czRLbmJ0YWg2a0VlV25mVVM4VU03WSsrZWdxY21DLy9aVmY5SjFINUFm?=
 =?utf-8?B?aWszOUQ2TFVXbFd6ajVPd012cnNveFhSTHFReHRGcUJQQ0kzN2t6ZDFnSXVs?=
 =?utf-8?B?ZDN5Tlp3cGZhYkdhUVo0SnJzUUo1MndVZVhkbVY4S1BvY092QXJwTEFYdVpi?=
 =?utf-8?B?ZFcrZlpsMzJyZEEzNzlYQ0RXRWF6OXBuKzdjbVdnRlFndHM3ZkVzZzhHSFBD?=
 =?utf-8?B?N0FWSUQralQrWXBaSFNhREZIclk5dXlmWGZyZHhmYUE1NGFLUW15ZnBUaEl4?=
 =?utf-8?B?M09wMFpHSGZTbWVNMXNkM0ZjNCs2KzRidHdSN29Ic1Qrb0Y3N203bGJtKzBm?=
 =?utf-8?B?MGtkTWlkSkR4VFdIdzVyMGlDMkhqUHFUaGRicFNVeXQxTUw1THhrQnZTUVho?=
 =?utf-8?B?cFNWYVdNcWFBYlhHMXVtNmN5Si9iYlgvOWY5N056VW9rUUV3WWZZWjNKSFR0?=
 =?utf-8?B?MG0xQ2w4UkR6eExEU3o0SlFlY3c5Sm9pNzVsMEN6amxkcXNzNXY5cDk2Q041?=
 =?utf-8?B?QWlHVjV5c3lieWJ1eitQc2wrcW13ZnR3WHgyclk5UDZpTVEvZnMweWQrblVV?=
 =?utf-8?B?cStHQ1lPMVcwL083YW1kWkNPbERPcmROeWwxUTR1c1B5WTQ0YlVKRWI1THNU?=
 =?utf-8?B?OE1FRTUrNm1KN0JUWDZpOHJIdVczTU1VNUZrRW15bEoxdlkzY0FvdlBTRlJC?=
 =?utf-8?B?QVJndDVOeDFDVFV0cjEvL1VneXVrbjRQY1hFaGEzcXpzL3RLblZXZ3hXNEpK?=
 =?utf-8?B?YXpXWDRGUDMva2ZvU0k4WmU2NGd5bTRUanNGS2tuS1BRdGY3WXdGa09sR1RH?=
 =?utf-8?B?aThiLy84amxFODhuRzJSNE9VMzhHL000cFpFSzJUODZoTTlGRUNhQ2FEUnRu?=
 =?utf-8?B?Y0dtU3h0cnZCWm1sbnVHak1ZcW9BbW9SNlRvYldqdE03OWZ1S3RpbWhBd3lG?=
 =?utf-8?B?VWRBSEFsUG8xM2VPcXNvMTlHRUdnNEhQWkpNd1NaQXY1UklpS2VIVDVGNGR5?=
 =?utf-8?B?cUE4VWFFZVVXWFQ2OWJ3ejFDWDRsVEpMQmlhOUd2M0lvQTRkVlpWVktvSDdm?=
 =?utf-8?B?WkFoT2c2NGk1d2lnbW1kRGE2SU0zWDJVc1MyZml1ditSTTNJT2ttYjMwV05z?=
 =?utf-8?B?Y1BwZzVWN3dHTFRtSlVKVUk1cnJKZndhREU4YXVPbFZZVGR0QVdqVDFDMWJN?=
 =?utf-8?B?b3BkSFF2K1lXNVZTMkY1cFVPcUhhUGNqS3I2OWtiTkdVdndqQUVnVkxXR1hn?=
 =?utf-8?B?eGlFYm5oeE5KblRwbEtSdHB2Z3g0Y0owczBkb1FZUEJGZVExVDZVZEZ4b1J5?=
 =?utf-8?B?VzBObkd3YSt2K2tYdi85bkZSTHlGbzIyNCtQWHkxZllJY3ZPZkdURXJQdmo1?=
 =?utf-8?B?MFk3VWtLZFRLekhKZCthcjZzSStCejdaaXlLQmk3djZka1RsVUVxOGZXTXVw?=
 =?utf-8?B?VEhCZC9rYXZPYmpjT3EvNWtJT01HOGJzWkVNaG1SQ3ZvRkhqUWRXbUpEN3d1?=
 =?utf-8?B?TlhDRjFEcDIrQ21MallEYTFzS0kyaUNjazRhMXV1bTd4d2lqTzMxZlNkSHBY?=
 =?utf-8?B?YlJjOTg1M0Q0bm5pNi9jSUFlclZtMk9YOXlLY2FSaERFUm1HMy9Dak5zL284?=
 =?utf-8?B?TUxTUjUvV1g5QS82VHZqTE5jUFQ3SksvMCtYRTNjdFUyZmFEZVdIWFpLSVdI?=
 =?utf-8?Q?nf4jsMtRmfzGqKLO9O4Jbpw4IEAfgM7g?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4798.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(42112799006)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHhSOElaSzRQdEFsUVNwRklnQTJxWnNFeTEyQWFRUVR0NXNaYTFzNUFqUmhC?=
 =?utf-8?B?ZEVkUEExVnQ2bUxkNThOcFo2MzFseWlDK3gwdnhFZDE5RGFrN1kzQUVCaTlx?=
 =?utf-8?B?WTBDWnFFbUpFTk8zRHZrRjJVaWZSSEpZeG02dU9kMmF6VTR3dXJIbVFDQktO?=
 =?utf-8?B?NXoxbkFtcnA2Y3JUbEdPWmVzNUdqWTc5em5LeXNCMC9UelpIdm1Tcmhpcm9V?=
 =?utf-8?B?TUMwZTFSc3lUV2dVNDZuVlBJbVp0NnJlWTRDNTlEeTVkLzMwU0tTQmQ5N3ly?=
 =?utf-8?B?cjc3VDVZaUtZblRhNzl5SjBpaW4wZlNGTWQrakQrRm9odFQvL3dEd2hvbXpX?=
 =?utf-8?B?SGxzMlRhYmpSVU9TY01udnJ2QW9KR29nTFBaVzVkQXhsQkd6OXZkYUJ3T2RM?=
 =?utf-8?B?M0YrUDZFbU9VTVNGeWFNcnZRMWJFb0plVXp6SzR3dWlubk1kakNtT0FUclFK?=
 =?utf-8?B?QWhjNERMRjIwNXQwNVAzdnR2SG9BVXF4VkhMa3pCYjJvQWxJMnBVK0Qvam5h?=
 =?utf-8?B?VWhuanpzZ0RJZkQvRkx4bmpROXhrUmJoL3ZPQnZZQlk4R0trOTZqNXNOQnph?=
 =?utf-8?B?cGVvaWt4S0lMM2ZxeGJlKzNkSFZTSGtqZU9LdmVZRmxGbDlpU3dkcFo3ck50?=
 =?utf-8?B?QUN1L1Rlc2drM3VnalBkV1JZR2xzbDFHUk5LWHYyQk1iU0NpQzZEVU5PTGVn?=
 =?utf-8?B?TG91ekFKRnhmd25uYytiNXJTYXhubWRxVW4yWDdpSGFOc1hlY1ZwblYrdGFn?=
 =?utf-8?B?VlNPMG5LYysyZVlEeGJQTUV1eXBSNUxSa01ybFh1SHVONXFXOUhjUlRrUmpL?=
 =?utf-8?B?S01XTzR4aEhDekhydFk4RmxJR1hhSldmR25RQ3JJTy80NnBaNEg4bUxBZGhx?=
 =?utf-8?B?bDlYMXBTRkpHaHlNbXdGUWd6TlFkRjE0QU8vMmgyT2hlNXVaVHJVc2NOd0ha?=
 =?utf-8?B?YTViZjVnWGt4bXZQS2x3bkhHWFlsSEhQejBONzE3Z1REbTVZd3h0enJJNDdv?=
 =?utf-8?B?VkswYW1JUXdyTWdCcEJzbC9mVXFxSndkYld2MzZoSDFEK083amNKVVVDbkoy?=
 =?utf-8?B?MnVtUGUyU1pHSWFFWTh6VUovQml3TU9hTVMzQ3lsZmFaTE1IY2MvbE8yV3Jj?=
 =?utf-8?B?WE1UMkZ3T0dZZUxheHlYbzYrVC8rZ0tZZGRrVXNSUGRuamtSRkV1K29OclRh?=
 =?utf-8?B?MzllUnhaeDVURUxidWZQcExCcUNLa0M4cHVyWW1mQ1AzVTlDOEFPMWtFeCty?=
 =?utf-8?B?bklsYjZiSm04cGI5MERGb1ZXTU9vUUxZeS9BQUU0YUFIRmlvOVZ6V0w5ejFq?=
 =?utf-8?B?a3VVQ082NTlKRHpSSHUrWGczSWdpWXRpQjhyd1diQ0F1cFR0Sm5iVUJHQ1ZT?=
 =?utf-8?B?elJRSUFMeE54ZXVrNjJKWnBEZzY1Q3ZGL24yQlBSSGcwcDRUWUdoTlVMaHBP?=
 =?utf-8?B?elhMTWcwMGttNHpvTmVmdU04TS9pSlhoVXMvNjVWcXU5M2Z0ejFFRS90S251?=
 =?utf-8?B?QnV2R3U3WC9NZGtSbmE2VFRXVXBhQU9rcitVV0xUZWZ2RzIzWXF2dnNtNmVN?=
 =?utf-8?B?WFQ4YUNUcWU3N2MyOTFjTkxXWWxiMkRJRWNpT0R0T1d3Y3JqWUxXZXEyZ1dR?=
 =?utf-8?B?NTVYcmUrM05PWUJSSklITkRIZGh0ai96OXJsUTYrWGRVb3h3aCtPdnZSSmZT?=
 =?utf-8?B?TktQTk9Fdm44T25za2pWVmYrdmFEUmltaWdhZ2xlTXlDanhJeWxYNUhaVWJE?=
 =?utf-8?B?TTByeTM3Zi8wYnRLMjNSb0UxbG5tQWJMK2t3dEk5UTZ2ZWlINC9mUUdiUWho?=
 =?utf-8?B?bnBLbEZTNUJzdFBlWWZSQkdITmFkcWxuSTN1QVZkTXdmYjlTUlhxOVNnMjd6?=
 =?utf-8?B?azZWalFyVXVaVUp5djFoOVBVY3VXbTB6OXc3UGZLZk1OVkU5OVdaRFNOalhS?=
 =?utf-8?B?MjFZdWVzMVh4VmNJM09nSlV1TGNRL1crYk1VdXNFVTdISzFMa3plQmRHam9L?=
 =?utf-8?B?MHRqMTZQbmRaY3VSYy9xMHN0Tm9PQUVla051OEk1OHVyeER2OFhWYUprQlpz?=
 =?utf-8?B?QkNENEJuTHBMejhMckhEMXdab0tIQWcvaFUyZHA5UVBpb2VxN3hhK1Fxci8z?=
 =?utf-8?Q?An8sgGj1C5CkGJVXN8GSnyZfa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f167e37-d143-47b0-6f52-08de204a7b7d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 11:15:40.6177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+5ZbUwRD+Sns6YMA4IM1LKrx12KsNgpsGtk5wsULKsmmBErWChbd0SxY8xKKcirzI+fZ0SvMgEuRi9vE0eJTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4998
X-OriginatorOrg: intel.com

On 2025/11/5 02:11, Jason Gunthorpe wrote:
> iommufd returns ENOENT when attempting to unmap a range that is already
> empty, while vfio type1 returns success. Fix vfio_compat to match.
> 
> Fixes: d624d6652a65 ("iommufd: vfio container FD ioctl compatibility")
> Reported-by: Alex Mastro <amastro@fb.com>
> Closes: https://lore.kernel.org/r/aP0S5ZF9l3sWkJ1G@devgpu012.nha5.facebook.com
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/iommufd/io_pagetable.c    | 12 +++---------
>   drivers/iommu/iommufd/ioas.c            |  4 ++++
>   tools/testing/selftests/iommu/iommufd.c |  2 ++
>   3 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
> index c0360c450880b8..75d60f2ad90082 100644
> --- a/drivers/iommu/iommufd/io_pagetable.c
> +++ b/drivers/iommu/iommufd/io_pagetable.c
> @@ -707,7 +707,8 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
>   	struct iopt_area *area;
>   	unsigned long unmapped_bytes = 0;
>   	unsigned int tries = 0;
> -	int rc = -ENOENT;
> +	/* If there are no mapped entries then success */
> +	int rc = 0;
>   
>   	/*
>   	 * The domains_rwsem must be held in read mode any time any area->pages
> @@ -777,8 +778,6 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
>   
>   		down_write(&iopt->iova_rwsem);
>   	}
> -	if (unmapped_bytes)
> -		rc = 0;
>   
>   out_unlock_iova:
>   	up_write(&iopt->iova_rwsem);
> @@ -815,13 +814,8 @@ int iopt_unmap_iova(struct io_pagetable *iopt, unsigned long iova,
>   
>   int iopt_unmap_all(struct io_pagetable *iopt, unsigned long *unmapped)
>   {
> -	int rc;
> -
> -	rc = iopt_unmap_iova_range(iopt, 0, ULONG_MAX, unmapped);
>   	/* If the IOVAs are empty then unmap all succeeds */
> -	if (rc == -ENOENT)
> -		return 0;
> -	return rc;
> +	return iopt_unmap_iova_range(iopt, 0, ULONG_MAX, unmapped);
>   }
>   
>   /* The caller must always free all the nodes in the allowed_iova rb_root. */
> diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
> index 1542c5fd10a85c..459a7c5169154b 100644
> --- a/drivers/iommu/iommufd/ioas.c
> +++ b/drivers/iommu/iommufd/ioas.c
> @@ -367,6 +367,10 @@ int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd)
>   				     &unmapped);
>   		if (rc)
>   			goto out_put;
> +		if (!unmapped) {
> +			rc = -ENOENT;
> +			goto out_put;
> +		}
>   	}
>   
>   	cmd->length = unmapped;
> diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
> index 3eebf5e3b974f4..bb4d33dde3c899 100644
> --- a/tools/testing/selftests/iommu/iommufd.c
> +++ b/tools/testing/selftests/iommu/iommufd.c
> @@ -2638,6 +2638,8 @@ TEST_F(vfio_compat_mock_domain, map)
>   	ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_MAP_DMA, &map_cmd));
>   	ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA, &unmap_cmd));
>   	ASSERT_EQ(BUFFER_SIZE, unmap_cmd.size);
> +	/* Unmap of empty is success */
> +	ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA, &unmap_cmd));
>   
>   	/* UNMAP_FLAG_ALL requires 0 iova/size */
>   	ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_MAP_DMA, &map_cmd));
> 
> base-commit: b09ed52db1e688eb8205b1939ca1345179ecd515

