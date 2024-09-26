Return-Path: <linux-kselftest+bounces-18385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664A0986F2A
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 10:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886B41C21552
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 08:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447491A4E9C;
	Thu, 26 Sep 2024 08:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MpjLV4uD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799C614A4D4;
	Thu, 26 Sep 2024 08:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340381; cv=fail; b=VrNgCWWY61WuGMMfV98rCJaUYjPZJYH9GTwwAVghqmlKfWIgJvpgScnG6Uk3MzK9JFGeA7hUzfMC6ykOoiBHvSZE6ygIpfzaW8y5MgwPoEXv5VdWi15KHU8gKnS4VbS7mDT8OAEWc5bZhbhHtpOjYnwaB6rxv0CxRBbQ1Jzp6QE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340381; c=relaxed/simple;
	bh=IZVqm6N5TOwDHMEU1K2USnX2rRCKpjD5U5VtSjUoMWo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QVYYEejiNLiuY4/y+3C9YWcCfXb6qD+9uTRuozVH5f4EMilxBAzlYg/YdRbdp2C5to7rYlH/G8ct6eSzOvG+2UhMn+Sd6ehxROEoPII3ZsN9TK8GLThJRjFfNEJu2evJnmL49vbD/nHwCkQ+P1eI3aOc5vTslJ87YKc7xD9U2B0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MpjLV4uD; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727340380; x=1758876380;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IZVqm6N5TOwDHMEU1K2USnX2rRCKpjD5U5VtSjUoMWo=;
  b=MpjLV4uDf8EdzvNZ0At/Th88NNamqXSr0a2ONzdbOel6tgNyA+VRbjXA
   3RAp6+r9TU0ZDZQyZTA0GtqZUUknMBLfH9ElhZiYwTHn6cdex/if/daiN
   9T5KhawWr6oA5L3RVj3T5S8+eUL6g8IzGhDP9dUxQw2BNCNZT7dR2qMCH
   CJA3eLl8uJxTws1ajEVO2BWqYGPU+anQfbAzavAqPgAE4UTVamhnpPtCD
   otd+MrMfSJucDgpIuV+Jt7JRne0K3g8VhDxYsRLy+/Xs4c5Ipcv0WDYKS
   N1QRyfU/9r6sXCDAkwyv+avmTWVfL2qQHLHQIYOQlAK+2urFKfcGB79nv
   g==;
X-CSE-ConnectionGUID: 2O/svjkiSaG+9diBiX9FTw==
X-CSE-MsgGUID: QAzgrIAHQIq5gsBnsVuafg==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="37006090"
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="37006090"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 01:46:19 -0700
X-CSE-ConnectionGUID: mVisYdKiT7GXLJM4UKM/bQ==
X-CSE-MsgGUID: cmZBBrzATPm7DK0YbqUP+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="71740422"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2024 01:46:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 01:46:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 01:46:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 01:46:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 01:46:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZlbWgx/Mc0J6TExSS3pzCnIpNAWFyrzB1XnWLsbq4AJ3h22wkgDfxFXXFSu5BKeehvlPz8lOsw+ZzwAQeEycJJ3ZqNPkW+qby4Gs5hdGqfo+ZPp0QpmzV7PSfxV4gXuQCOyJIcGMAv7zm3BzCuETMpQj7xDvQiLZxYacwFq0FZaN35heVNB/VpN74w/FAcqRuB1ndN1jNaic6v8OOAjOwjT84/PolvMrdIDs63kLEbKkPO7XfX9H/ZtHAmis0he/AVkkUyt/C27bY9f/jIXEEWoT+Lw4UMXUNw2fI+Mwbv3k1ye2DmgywxsDbjak9DsSGfW+CTcWAHHP9vL+QBdpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUAye7A1c9rggs6e8eaJR2VT4oWVgzrypFs3r20aisQ=;
 b=KLyk1zOA5bA4jaCVtANxshcCn0089lVa18t/uMT5M7b4cNCgba6N03doGZxnIDCRWEL7PgVcUaatHACfX+c+wcjHVssTvvGRhWh/TDcA7EU+hgult3CWLqNqmwb/xpuZ0RdazJHzf0tlQVmHdBwHt/zsG8JePWPS9ijMapy2X/xri/s8aHbaWDLg17AoGfFzWFVyJ3bStfzEEeYiqB72bemrSYNNUopfrNHA3yN5PYfeG2rJRXbeOHUO3F1U72eO2ojGQHTJES7cex/hyVm323Uez0YB9/xYDa3ZfC6FDmd/OSxXKDfbLF6o9ovZMDaeXx72r73+BrdruZNV+f5gEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB6673.namprd11.prod.outlook.com (2603:10b6:510:1ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Thu, 26 Sep
 2024 08:46:14 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 08:46:14 +0000
Message-ID: <3ddf97a3-cf5b-4907-bbe4-296456951e6b@intel.com>
Date: Thu, 26 Sep 2024 16:50:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/19] iommufd: Allow pt_id to carry viommu_id for
 IOMMU_HWPT_ALLOC
To: Nicolin Chen <nicolinc@nvidia.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <2d469a5279ef05820d5993df752d32239878338d.1724776335.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <2d469a5279ef05820d5993df752d32239878338d.1724776335.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b53593c-903f-49fe-9b72-08dcde07adf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXQzLzA1eXRmSUVia0ttdWFtYmI1S2tEbWRSdEFjVWhJbkEzekpXaVRDQm9n?=
 =?utf-8?B?cmlMSnh0THZTdHlqcFJvdTNtQ2RkekIxK0FabEVjOERWRTliVzR3aXN3ZmF3?=
 =?utf-8?B?VFEyQXAwZDBibGRqZ3djUFVSOGovRW5qbks3NjZ6R2g2c2hVYkFIWmlJMXV6?=
 =?utf-8?B?L254SmFXUnhsdWNYMWJzdkZBZmRLNVF3dE9vaGVhTVk4ZkdJdFZ2NWVxeXIv?=
 =?utf-8?B?K1E1YkRBYnpGamFicjZkUW4rNzJLQ0xpTVl1SmE2Rzg3TTluNVJ3VmhqY01u?=
 =?utf-8?B?WW1ka0tzS1hkRnIvQnhIbFJaZEcyR05RbWxZNGJUU2RSc2xia1hFZG84T20x?=
 =?utf-8?B?OFYwY1g1QU9YdndZWmtVTzRXMFJPaSs0bW5MRllsQ0R0Z1l0anprT041OTlG?=
 =?utf-8?B?L0FGcFVJME9jUGZVcWFFcWhUQjlLUTRvOVZhMWFnU0RWWUozUHZmZTRpM05p?=
 =?utf-8?B?Yi9BM09YN2dNSWtuQk9SUGlML24raU5ZWXl5ZnU2c1pWNmJMMTdhMCtWYWMx?=
 =?utf-8?B?NGtnWi9HVzJrWkVRcitEY3Z3c0NqNjRUbU1pNG5jSzRWaGxwTURFKzBGTHB1?=
 =?utf-8?B?S1ExTDh3eElwMjltbHVNT1IxbFdoNHdFUDltRDN1VUxadWxsWWdvcjdjclFj?=
 =?utf-8?B?dTBmU0RubFh5cUViQ1laSUFoOUI5VTZwR2xvd2pKSERvK01IWU5aVVVYTU5R?=
 =?utf-8?B?ZVNpaUphLzNZeVEvVXh5Q3FIRWJrRDh3NUtoWDRqd0hKbFB1ZHFTUWlheGRQ?=
 =?utf-8?B?S3lyVzQ2eDdZZEZUaDN2UmE5RDFpYlF0cFM1YVRFN1BINXErVEQyWHJUM0p6?=
 =?utf-8?B?NXcvcmVuZi9GVGwvdkpzdnpaUnVIM2R6NmFEREVtS2pDR0pnQ2V3NUtqTlcy?=
 =?utf-8?B?R3ZxSEJmNHZURzEzQ2pneE95S0lYa1dGbWczZktlQnlTQVhGV1BvSWhFckor?=
 =?utf-8?B?Q3ljNmt3SEQrZlRRY1djb0NkQ01jaGI2U1dHTGFRT0RoRjI3dVhyR1lNR096?=
 =?utf-8?B?VUNjL1lmRS9SNmkxNlhsTk01Z00wN2VHdVFCSjlwV1M1bXJxYWZsLzhxL0ha?=
 =?utf-8?B?TFBGTjNkUnZvTmdGYlhjd2x4WHBGZjVCdUhtc0J5R1hFeVQ0Mkc4Z3dLK3JE?=
 =?utf-8?B?elVKTkR0d0V1aXNLbGJDZGtRNXZneFMvU3UydnJ4UWdIK21ic2pDWUx3ZTRZ?=
 =?utf-8?B?UHVhWkJsbUZoU0FDWHN1YzJrKzIxTVNOcWlQOUtBUjVsTGtpYlJsdjZERnZk?=
 =?utf-8?B?U2c5UzJNOGNRMm0zWm1YaSs2RzdoT1JaTjBnbG9GUHEvekpDZVBoV2VMNmZJ?=
 =?utf-8?B?cXdvL0JHU3BmVC9kMmt3R09zMjBBdERnRk16RElxOFFHZ0dnL2pvV2dKTXJv?=
 =?utf-8?B?Skx3Um93TTI1UGxjc3NFbG5XU1o0Ni9EdUVFa2dhbSs5WDNrcHFoSnYwanc5?=
 =?utf-8?B?TmNET081S2NkNEllQUs5SGMxdVp3bFBjQXdZdlJaeFNaMC9vQ0Z1YkNPemtL?=
 =?utf-8?B?WlcraTZvakpkcXNOZlZoQ2Z1SXhHYXBWRENnUjVUcjZrbnp4WEIvbFJqVnJM?=
 =?utf-8?B?M2l1TGRFUHdvd0FlMUVKb2Z2eVpKc0NpRERLU2VnMG42R01qUXY3Z2lpRWYw?=
 =?utf-8?B?S25XbERTeDU4R1Vxak11WURsZmJiUTRNdEFubk0xaXhQdEVCQ2pIQW9UeHN0?=
 =?utf-8?B?YXJ1dzYvMXN0K2xscWF5MjZ4UlIzdUJhZ2U3S0IxZDhBd2Y2MzBaUnNxbWRR?=
 =?utf-8?B?U3M1dlpuZm96OStqRXhOS3pvN0pjNFFaZTNDMS94WFNiRUViMmFXS01rNTBP?=
 =?utf-8?B?SFlrTEJMQXlPZ2QrWlVDZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGhZVFowaU54dWFVU3V0SFFXU1RKcmtSMVhpVGIwWU9jQWdIYnV1NmtEakJM?=
 =?utf-8?B?QU9KN25ZT3A1M2xOZDBzTU0wcHo1eTdmYlJGM2N1Z0NXems2SkUxWGxmUUJX?=
 =?utf-8?B?OUdDYnNvN0tuaStNNWdwc1pWVVRTN1NNQkE1anNMRzc5L2lrdHFTbVZQeEl2?=
 =?utf-8?B?cHI1c3lmeEdESlNHclhpRUlsdTgzcFd3NFJwYUxoSCswczNqZ0FodGErYlJt?=
 =?utf-8?B?b012THJKZGtGcC9SSjh0N2hzSUdPMUZxV2tqOG03TjI4aGdQdi9LbDJ0eS9k?=
 =?utf-8?B?b1Fza1VJanlwSlVUekNhdTVrejJMbzgxYmpJeGdCdTVHTzh5YUVoOWZRRVRQ?=
 =?utf-8?B?SWoyZGwwM29GU2d2Zm5WNlBjK3Q1ZjVtdGRMTWdPbEZ2aVpFblE1ckUwZHgx?=
 =?utf-8?B?MXpKRi9OUUl5bmtWN0gyb2YremtEcENpWVFtSjJHeXR6MjduT2twZVNMUXdu?=
 =?utf-8?B?Uzh2eFI2L2VlSUZYUm9DVGhwNmNnRzBMKzJHSEdrUmM3SDRvTHNTM0Nid0hm?=
 =?utf-8?B?dmtJemRkZHJFQjNKbnl1RGlkWVJNTHlYMllsR1liUmJDTW5RUmc1U2VIeU04?=
 =?utf-8?B?WU80elpGWEN3SmowWW5ZZHVHYmxrUnMvb0dFc1JEYUQrV2hDSUlQRDZ4Y0tt?=
 =?utf-8?B?SENyV24vL242L2tBeTVYUU1LQk9adEZ2OGNqbHoyY1I2Ukd3ZlBNOEFObHNx?=
 =?utf-8?B?N05DY3JkUkt6UEZNMHNhR2VPYzlYaEIxRm1SbnZXSWF1dVFQdHlqY0VibXo2?=
 =?utf-8?B?bDgwc1N2Zk1HaTNLV3JBcnRxaVVieE1LWXdyeDVMbkMrNEFLSERhdVowRklI?=
 =?utf-8?B?R0JxRUJNQ0tITGFuekt4Q1VwaFVRVEJjaFpFb05mcGZjd0xFKzJTMHR1WmZS?=
 =?utf-8?B?NytJUHcxeStNdkRJK2dadWQzbE85eEQ1bktVSllkUGUzRmFkNnUzYzhTYm1D?=
 =?utf-8?B?akRQQkdyN1ZJRmRKR3N6WmVvWkIzOUF4TkdsUnB3RFJxT1RVMDUwTHZPa0hv?=
 =?utf-8?B?OWZMaG52STNlekNVNjNOeVZKb01vNjhqd3dORS9uVkw3RzQ2YS90dWZyRVJp?=
 =?utf-8?B?ZENBNW14QW9JOEkvamNkSjJXNG1nNU5mRGx2RjFNd2Rac1NxWVhGOVBYQWNn?=
 =?utf-8?B?S20zODlwMk80cTJSU2RhNjlFWU1JQUVuVUhIL21ISW5PWXJLd1hrNTRLMnRE?=
 =?utf-8?B?NVNUdUVYVDJ0NG83NE15UUx0RytvZW8ydU1BTEtwMC91bElaMm11K01lNGc0?=
 =?utf-8?B?V0ZGNUVEU0ladXdhNU8vekw0RVpPd00zQjE4OWFmTXJURmV6ckxJUVlzT3V1?=
 =?utf-8?B?OGNSWVdLQ3lrTWxOZ1ZoemV2dVdkZE13RlM0MzZVWEF1eDUvUzl0bGwzKzFr?=
 =?utf-8?B?QXZLV0hBeHptSkpDVXVKcVM2U2JmL0J4ZUNqWi9oZm83QnNpYXFyNk5oRDdE?=
 =?utf-8?B?QTBnWWpjU05QT2hLRlhtQS9KNE5RaS9ZcHVIcWRlQmtZaWxCMHo4cnBvQThu?=
 =?utf-8?B?Tm5KL1V5ZUY0QnlJUkRDbyt5L2VHUlpFVmQrdGNienQxMHEwVFRhM0NOL3Nt?=
 =?utf-8?B?d1RwOEdxckVIVnJ0QlphbHVCUDIrWW9OY0JlQU96clFqZUF5RkovNzZCdlFs?=
 =?utf-8?B?M3AwcWV3VGpVb1RQK3BJdm9XMC90cTl4V0k0TW1FNE8ySG1jbDVMZzBqdlJT?=
 =?utf-8?B?SUw3aWFMOGE0bDg0RlBKQm5ESHplaUhaWE8xbUlrMXVkMXZQL1pDbWdkL2dV?=
 =?utf-8?B?czBSM3Q3dU9SbC9BVXp5dDJadm9jSXVyNDZZNURnTysrL2NUbTAvZm4wOURP?=
 =?utf-8?B?VnNURElpZmVjTzhGcGxNZmdSSDgyRlJINW9VbG1DS1ozRTlPaGYyNTJrc1pJ?=
 =?utf-8?B?NTNqWmRETU5OSCtxN3hRTFR1ZXpKT2VOVHlxUnNsazNNRTVCbUI2MEkzZXZs?=
 =?utf-8?B?UnpiblBVamhqOVhqUm85R2drSmphaWdSWGRMVk5xVjdZSXJCVndwVmJ4ckw5?=
 =?utf-8?B?MmRWLzhrZzZIcXZ3M1EzaTFiTHIxTGNBR2tkZWxPa2hDaFdGbW5Ubzl3Y3Bu?=
 =?utf-8?B?dnFZeVludTZidHF5MCtDVG5MNm8rVDZkdzhKTkJYdEVMdHZMdmtvM0NYTCt2?=
 =?utf-8?Q?+2iMBUhIAt/sJE0jf2CClfwFG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b53593c-903f-49fe-9b72-08dcde07adf8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 08:46:14.7798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ysk/uzW09ThPEzUPb2aceIrl9QvSvMS59YLbE6o86hUYRNUXc8QgRd4JYBQhPe0muHf4OtjswFwbchdbpaR/Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6673
X-OriginatorOrg: intel.com

On 2024/8/28 00:59, Nicolin Chen wrote:
> Now a VIOMMU can wrap a shareable nested parent HWPT. So, it can act like
> a nested parent HWPT to allocate a nested HWPT.
> 
> Support that in the IOMMU_HWPT_ALLOC ioctl handler, and update its kdoc.
> 
> Also, associate a viommu to an allocating nested HWPT.

it still not quite clear to me what vIOMMU obj stands for. Here, it is a
wrapper of s2 hpwt IIUC. But in the cover letter, vIOMMU obj can instanced
per the vIOMMU units in VM. Does it mean each vIOMMU of VM can only have
one s2 HWPT?

> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommufd/hw_pagetable.c    | 24 ++++++++++++++++++++++--
>   drivers/iommu/iommufd/iommufd_private.h |  1 +
>   include/uapi/linux/iommufd.h            | 12 ++++++------
>   3 files changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index c21bb59c4022..06adbcc304bc 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -57,6 +57,9 @@ void iommufd_hwpt_nested_destroy(struct iommufd_object *obj)
>   		container_of(obj, struct iommufd_hwpt_nested, common.obj);
>   
>   	__iommufd_hwpt_destroy(&hwpt_nested->common);
> +
> +	if (hwpt_nested->viommu)
> +		refcount_dec(&hwpt_nested->viommu->obj.users);
>   	refcount_dec(&hwpt_nested->parent->common.obj.users);
>   }
>   
> @@ -213,6 +216,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
>    */
>   static struct iommufd_hwpt_nested *
>   iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
> +			  struct iommufd_viommu *viommu,
>   			  struct iommufd_hwpt_paging *parent,
>   			  struct iommufd_device *idev, u32 flags,
>   			  const struct iommu_user_data *user_data)
> @@ -234,13 +238,16 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
>   		return ERR_CAST(hwpt_nested);
>   	hwpt = &hwpt_nested->common;
>   
> +	if (viommu)
> +		refcount_inc(&viommu->obj.users);
> +	hwpt_nested->viommu = viommu;
>   	refcount_inc(&parent->common.obj.users);
>   	hwpt_nested->parent = parent;
>   
>   	hwpt->domain = ops->domain_alloc_user(idev->dev,
>   					      flags & ~IOMMU_HWPT_FAULT_ID_VALID,
>   					      parent->common.domain,
> -					      NULL, user_data);
> +					      viommu, user_data);
>   	if (IS_ERR(hwpt->domain)) {
>   		rc = PTR_ERR(hwpt->domain);
>   		hwpt->domain = NULL;
> @@ -307,7 +314,7 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
>   		struct iommufd_hwpt_nested *hwpt_nested;
>   
>   		hwpt_nested = iommufd_hwpt_nested_alloc(
> -			ucmd->ictx,
> +			ucmd->ictx, NULL,
>   			container_of(pt_obj, struct iommufd_hwpt_paging,
>   				     common.obj),
>   			idev, cmd->flags, &user_data);
> @@ -316,6 +323,19 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
>   			goto out_unlock;
>   		}
>   		hwpt = &hwpt_nested->common;
> +	} else if (pt_obj->type == IOMMUFD_OBJ_VIOMMU) {
> +		struct iommufd_hwpt_nested *hwpt_nested;
> +		struct iommufd_viommu *viommu;
> +
> +		viommu = container_of(pt_obj, struct iommufd_viommu, obj);
> +		hwpt_nested = iommufd_hwpt_nested_alloc(
> +			ucmd->ictx, viommu, viommu->hwpt, idev,
> +			cmd->flags, &user_data);
> +		if (IS_ERR(hwpt_nested)) {
> +			rc = PTR_ERR(hwpt_nested);
> +			goto out_unlock;
> +		}
> +		hwpt = &hwpt_nested->common;
>   	} else {
>   		rc = -EINVAL;
>   		goto out_put_pt;
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 154f7ba5f45c..1f2a1c133b9a 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -313,6 +313,7 @@ struct iommufd_hwpt_paging {
>   struct iommufd_hwpt_nested {
>   	struct iommufd_hw_pagetable common;
>   	struct iommufd_hwpt_paging *parent;
> +	struct iommufd_viommu *viommu;
>   };
>   
>   static inline bool hwpt_is_paging(struct iommufd_hw_pagetable *hwpt)
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index ac77903b5cc4..51ce6a019c34 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -430,7 +430,7 @@ enum iommu_hwpt_data_type {
>    * @size: sizeof(struct iommu_hwpt_alloc)
>    * @flags: Combination of enum iommufd_hwpt_alloc_flags
>    * @dev_id: The device to allocate this HWPT for
> - * @pt_id: The IOAS or HWPT to connect this HWPT to
> + * @pt_id: The IOAS or HWPT or VIOMMU to connect this HWPT to
>    * @out_hwpt_id: The ID of the new HWPT
>    * @__reserved: Must be 0
>    * @data_type: One of enum iommu_hwpt_data_type
> @@ -449,11 +449,11 @@ enum iommu_hwpt_data_type {
>    * IOMMU_HWPT_DATA_NONE. The HWPT can be allocated as a parent HWPT for a
>    * nesting configuration by passing IOMMU_HWPT_ALLOC_NEST_PARENT via @flags.
>    *
> - * A user-managed nested HWPT will be created from a given parent HWPT via
> - * @pt_id, in which the parent HWPT must be allocated previously via the
> - * same ioctl from a given IOAS (@pt_id). In this case, the @data_type
> - * must be set to a pre-defined type corresponding to an I/O page table
> - * type supported by the underlying IOMMU hardware.
> + * A user-managed nested HWPT will be created from a given VIOMMU (wrapping a
> + * parent HWPT) or a parent HWPT via @pt_id, in which the parent HWPT must be
> + * allocated previously via the same ioctl from a given IOAS (@pt_id). In this
> + * case, the @data_type must be set to a pre-defined type corresponding to an
> + * I/O page table type supported by the underlying IOMMU hardware.
>    *
>    * If the @data_type is set to IOMMU_HWPT_DATA_NONE, @data_len and
>    * @data_uptr should be zero. Otherwise, both @data_len and @data_uptr

-- 
Regards,
Yi Liu

