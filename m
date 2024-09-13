Return-Path: <linux-kselftest+bounces-17941-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C50C9977F7D
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 14:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81D3628A04C
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 12:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51131DA0FC;
	Fri, 13 Sep 2024 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c94bkyoe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A14A1DA0FD
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Sep 2024 12:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229639; cv=fail; b=jFpn2kkeIpmP2LOIHjSqS2uM0VUScbcBBxsSujvXg0L9KMdLDCKESGwRKGul6fdhD6c5rxLZt4xNtoWBpQi+RJAo6R0wcBOYEUBcbQCaxlRTS3j4/baWQhcwLKqeH//rwhcdoUOyIQi6kUTRTS9OptfhSv1lA3pB20T/F64QXjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229639; c=relaxed/simple;
	bh=g7iKQVp3MMRoIfgrW9HCcKFLTY0NVI9YZnjFudOjDCc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gS2shONdDveokvWoKQ84yXUKGO/2CjNX2IPt2FZS5AItkokDSpKgN6wnEdkf0ZXa8287fCSTzq85bFDPtv0rsA6nGdfgGugirDlnIMRpcLmbl87ieNWwXYjRqU/g9oUXp9Q16PDnCWdtVZf2Q8YegbPwPXdGkozR4j2PgPIkioM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c94bkyoe; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726229638; x=1757765638;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g7iKQVp3MMRoIfgrW9HCcKFLTY0NVI9YZnjFudOjDCc=;
  b=c94bkyoeGocoteWwdpzUHC6uj+qA1IEe6zrL8qWSQ8s6Ya0rTu7nUQy9
   pfj2O93qjhiomzuYMtdPR8y6YI5q8kU15S92WjnwT/yA0hEtBaE6zbMeI
   wlGn3uqmtWyISXuU7S+oyrhRDCct1W8zHY8eNMA9I4pjKGUbXzJqCNu3M
   PTPYQz6kzQTqCIiWKCngtEDdCdrlaJaQgS6JldWh+K6T7sACUi8Efu7o/
   gNP+fUPqpte/4BSpubWPsQQtfqcnsiVOepabdvRjeIASynF8fFoOS6hhE
   KbG6fpSLeRG0FGKpFiOPpAzhkQU1JAZXGOdXsauaEWUmh1Mxpep/U/KIR
   w==;
X-CSE-ConnectionGUID: SmLAL6+cSB2k+Q0L3KIIXA==
X-CSE-MsgGUID: FUTOhmJSTbKU1nc8fdCRag==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="50541060"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="50541060"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 05:13:57 -0700
X-CSE-ConnectionGUID: LNKKSKMXRBWmWquE1jGsuQ==
X-CSE-MsgGUID: FiZGp3XSTCuzUR5j5cE1Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="105490920"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 05:13:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 05:13:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 05:13:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 05:13:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+Y6H+1nZe+rgaGmWiVzyE4Tsha2xVAl2xPjbWeJSZMJrViteWgqD9sWpj6FHd8MzFcAweX2pOYiCbXApSGnvHTIub8VTZiuI1db/PMQQ/zmmJCd7OrpD8QMTKXwZp5TIy22ror9I3O+PNGWpHyeRtf0+1JQ2d/3GXoV0VB36Xevsb6aJpwDKHTE2Vre7mn5ASJhCVEsteeVCbIPzAg+M0B80s770ZvtW627QE4YgnIvgqsuuuauQEoVQXuEddE1O8y/ZjSfaNOwOqfJyJqfYMlwCy6O2u9ydZ7WNDxlQYA+0qJiT7ImHVJn6iermpqO+l7PnG+AVcw65njPgdg3oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNMquN+uhTi8oC0p1fDPK98UlvI0xgfbLvtPzFmDQIM=;
 b=Y2+vggpJXYeDR3te+xK7CNvCFYRNqR3O4JnjmLGZiN7k0mMYHvl30+7LE9eyttKmREVrJMjPXTAg960PoVpHrflOWSLTBZAG1PSAGEkhpm7FDrkCupUvT1FjwbV2CHeqvJkiCeIBLP6v6xMtxnr6+4DMxvQIsAGL+dwMy8UdFMTvHm8zk5GLqkf7ucJ1fNXec7rmV/pkp6My/AH+SLvXTQ5o7jUsDjAMoaZa7TTLPxVwoHG54dYhiL0H9mD0vE150OJlYMCzz6XooTF7csS95A01j5AzszZ2KBXC7h6QPX4xVdQMB8H4w94t6KkW8yUMWv2FKjVbVTLHu8zs0TYl8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA0PR11MB4653.namprd11.prod.outlook.com (2603:10b6:806:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.20; Fri, 13 Sep
 2024 12:13:54 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 12:13:54 +0000
Message-ID: <021f7b42-e949-477d-b6aa-a509d0aea4e1@intel.com>
Date: Fri, 13 Sep 2024 20:18:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] iommu/vt-d: Make intel_iommu_set_dev_pasid() to
 handle domain replacement
To: Baolu Lu <baolu.lu@linux.intel.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <alex.williamson@redhat.com>, <eric.auger@redhat.com>,
	<nicolinc@nvidia.com>, <chao.p.peng@linux.intel.com>,
	<iommu@lists.linux.dev>, <zhenzhong.duan@intel.com>,
	<linux-kselftest@vger.kernel.org>, <vasant.hegde@amd.com>
References: <20240912130427.10119-1-yi.l.liu@intel.com>
 <20240912130427.10119-4-yi.l.liu@intel.com>
 <a2cbc96f-7be3-4f70-a38b-540eddfd7c23@linux.intel.com>
 <52ec3423-6061-4178-8728-832b5f61af15@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <52ec3423-6061-4178-8728-832b5f61af15@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA0PR11MB4653:EE_
X-MS-Office365-Filtering-Correlation-Id: 3429bc6e-f13a-4841-ee31-08dcd3ed8950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDJOTzd5REsrall2YlgwOUtmS1VPb0dhcmhtNUdMOHl3M3JPTXg1aG9KVnAw?=
 =?utf-8?B?ZklKOEZXb0xIdUlBRnRZSVhWanhTaVcva1I0dk9lTFNQMjY1cFR2NmkzR1hS?=
 =?utf-8?B?M2NtNmpZODRWZzh3LzN6c215TGxWYVNLemNjNTZHNlJUd0FkQ3pjZXF6Um16?=
 =?utf-8?B?aFh2anlOV3dyc0l0OVRyRmFybzFET2tGVndRZFlpVnVnRUVxMVdadnlNNDcx?=
 =?utf-8?B?MThGazdSa2ZyWFBKN0tQbUJRK0RjQmN4QS80cVVvaEJITzk4aHNhZ0Q0NEFU?=
 =?utf-8?B?NTR6dldPMFJNRDVjcGNaV0xsdmFkTk81TEZ3akFnT05WNlRkRGxzaktrV25N?=
 =?utf-8?B?RjhyY2lER0EzZ1d3eGg5aHptNnY2N2U2V3Bja1AwQ1N0VzZjOWY4WHBwV3lM?=
 =?utf-8?B?MytFS21HNGYwOWo4U3psajVBMHMrL3NLZ3gybkErMkFHa21HeWc0aWl3ZnBs?=
 =?utf-8?B?OUxZc2gzQXN4SHJNMDVHTUVTZzdOeG9rWFo3T0I0WlJ1REpldFE0RG5UeG5o?=
 =?utf-8?B?dFh3UzBOV05PK3NiYm9MaUpIYzJHbGtkYjY1dmhzUjBzVEc0dCsya3hQT0NV?=
 =?utf-8?B?a0JJZVYxdk9FazZ0TGg5NVhLMlNtaHFscHBFZnBZaXJHVkRpQlI2aWthaVVY?=
 =?utf-8?B?ZjBHdkwwUzBJSytpZnp1UURnN3IvZTZsS0FNR0tKS1h2YWdjWnV1NUdjUENG?=
 =?utf-8?B?U3RrV2gyN1E3V0tvSHlySUdKQ2VWS0tpVFR4SW1rNUhzRklONFduRkFOdXNl?=
 =?utf-8?B?VWMrUnRxcTE0dGZ2azV1RWRjZE8yU3hWYnRpdTJCQTFNVC82VmwzV2lpS0NM?=
 =?utf-8?B?THBLb2NCK1RZd2ltaGhXYWNBN3YraFJMV3J0TjlWME13enFFTENKemN6ZmlU?=
 =?utf-8?B?cjJ2Z3p5WWI0ZlBDRngvQ2V0bnJwaGxrOWZYMUF2WFhIcGZOdEU1NVpYOGFZ?=
 =?utf-8?B?eWtmbmxYeTVMZFpsSjZxdTFDdnQzODYwRXQ5T2oweW5rcDMrM2FHcXpEaGQ5?=
 =?utf-8?B?VjQvSVJGWHdHeDc3VjNsejZYL0RhWnFxSUJFN2VGSzhiZ3FhczMyUGNDekV6?=
 =?utf-8?B?THB5L3VjYWNndjFNSGNNbE5ML3dLa2ZJOXBCanU2ckxTN3hSVzYrMGFzREkr?=
 =?utf-8?B?QzQzTjV0VlUvLzFVZTRXRHU2bmVZczdjSy83TGpXbFhtTDJOR0p4NG5rencx?=
 =?utf-8?B?RFE1VFpMWDdsN2RYb1ZieHdPcEdtbGZTQ29aRzVVdlFrUlJIcm1YY0MvNUVS?=
 =?utf-8?B?RE1GWFBzTlpmZGdRcVAyelpsZFJ4dFBXQlhNcDNNS1dyVmFpeVQyU01CbElN?=
 =?utf-8?B?MlhXelpYWStSWGFWTXVmb3ZvTHFsUzBVUElZeXpJR2lGaGZBZ2NZbmZHWXFU?=
 =?utf-8?B?dmlIYUFNTUpMY1dFS0RYb2xDL20wQ3FZRnp4S2V1WHNJRmtwbXM0a2ljWjVq?=
 =?utf-8?B?YjBmVGFHa3ZXNzcxMnZtTWo1YkdqSXZxb0FIRG5UMDBqb3g5alpCMXdoU3Zl?=
 =?utf-8?B?UEx3dkhVWnVwajJrTnpVOFhKL2JoYWthVEdzbDdRclc0Q0llRWJSSy80TGxy?=
 =?utf-8?B?dHhCSUI2ZEdrUWpKNW0xaEFpcWsreExyYk1uV0wyM0pYdWhyNDllZ3Bud2Ey?=
 =?utf-8?B?QjJNZk5OVlFUa2cwc25MajMrc0Z5SmlnSmxpdFlvN0pyZWRUVzlzN0tpTkt3?=
 =?utf-8?B?aGIxUUo1czFwWGowTjQ1cklYL1FDMzgwSVEvdUlXM2dqZUU2SlJteVNuekRM?=
 =?utf-8?B?dSt5V3l5NHE3bEVMazZDS21iUEFSdTBKbm9sYXNwSVdlU3RJR1c2TlNBamR4?=
 =?utf-8?B?WjlJbkE3Y2VzWFg5OG1aZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVFRandnYTVWUWlWNGswWUZ0WDNsMzFRZG9ZVDZYUXRMVDFldWMxaGFiYnpI?=
 =?utf-8?B?UFU4WTFOQXA4MUc1bFZVMU0yZGQ5NjBhaEpQQnFrRldmRDhxcHVoUXNQMUxN?=
 =?utf-8?B?NGZXMXhtaWFXRndScVlEcXBBWEh5WFRITlkwdjVhbHZaZTRuYU1QYm5XNXly?=
 =?utf-8?B?UThrb0RNTitueDZ0dXk2RlVXalNFSjVxeVRUZ0FsSXdUOE1nZnB4cUFQb3g3?=
 =?utf-8?B?WFRvaWY1SXRVcmlUdWwwVmM4M2U1U3JxTGpEcVh0YTBQYVhYc09IYkNCSjhO?=
 =?utf-8?B?clNPcDdla2U1T2NxcklkZXh3ZnZqWkFtenNON1cxa2o1Y2oyZDFhZzUrZEw0?=
 =?utf-8?B?YjIxZnRlU3BIM3F5cXNhWG1Lb1cwNnMrMkJ4a1FnQkcxQ1lwd2dCVjRnOC9a?=
 =?utf-8?B?RFhDNkFqblUzNTMyOE5WOGFCcEFoekVxT3dXcDZaSVV3aHZZQjVSeWErNnEw?=
 =?utf-8?B?UGRNTDRPNmd3ZllPTnNaa0FYdXJONDFEcXVnSEVYZGNIQjVUK3BGM0pqUVly?=
 =?utf-8?B?TE1rcTZZZXdnRHh4UElJeFFYWTh0MUI5bTdzbFVJOHpOeUdoQnZJN3dmWGw0?=
 =?utf-8?B?UWxOdWZ0bmJ4OXpiTC8waEhBdkx3a1VOVFN6Vmxuc3puM3JOdDVZTlJMMFFW?=
 =?utf-8?B?d3FpUlFwNisyZGNGT2RQS1Y4eUY2K014WnBiRG5xblVvSjRMUU12cDE5cDFH?=
 =?utf-8?B?VDBJSkMwcExUYTA0djc0Nk5mQm92L3J4M3YxY3owRGlZWkdTTUdWWUVVK1dW?=
 =?utf-8?B?UWxDS3F5aFlHK3lNK3JDeHpXQVFlQW15dk5ybmxvcG5iZ2h1QWwrOUU0dTYw?=
 =?utf-8?B?V29BcFRSS0hHSXVzTGs2NGN2STFnRTZDL1JvS2Nta25kb3RBL3dSTVpEUnZi?=
 =?utf-8?B?ZnBYQXMzbjFaV09RTC9DRFE1bW0wb0xsVXZ3UUplcjhzS2ZMNk1Xd2d1dnNs?=
 =?utf-8?B?b2NNZ3dhc2JqQ2UvbE9sNGNPTUk2dE0zWXpZOFZsZjdSR0drWWpyY3Ztb0Rx?=
 =?utf-8?B?elI5OEJXQTlTbWZmUXU3aG9heTVGRHdzRWNIbzkrb2VsdnNTM1ZPQjU0TnBJ?=
 =?utf-8?B?MWpkOG80UVlISkxpMU1iZ2o5SUlYQXorSm45Z0o2TlNSL3BOdXc4cTJRVlNu?=
 =?utf-8?B?NTE4Q1JxdFg5TmJ6WWFwb0c4aEYzM1dnZjJSd1hLK2lZaC9YTm51a0Y2cktp?=
 =?utf-8?B?aVFIaFZLVjV5MUhiU1h0VTJlQzFlMFh6NFFmWEdnakdWYnU0QjZsM3hYWWZQ?=
 =?utf-8?B?bHZuUzhlOFJGUGUxcXdnTzdYTDZMUlE4R0QwclZSOUphU1k3NEVSZENpMG9W?=
 =?utf-8?B?eGM4Z2hka2FQeHRCM0N5QlJXYi9pTHJWcm5RdUI1NUR1OVVMU0NhWHVKWksz?=
 =?utf-8?B?VlZpNWowa0ZyRk5KbXVXM2lJdGhocFI3cUVxTEdqSGdoNFVXZzgvQ0ptMEhM?=
 =?utf-8?B?VTZYYjk5QUhCMFh4UzNpMzRVUHhJTTRTVWdUSzVEckVkVXZoZTE0MUVtNlNs?=
 =?utf-8?B?R1UvZWtOT1V0d1BzVkxmelFqTWdrSGtHYlFsdVQzTEZET2RNOWFKTFNLYU1Y?=
 =?utf-8?B?bWJ3UDZKRThlZkV3Zys2QXQ2UHl6NU8wTDA1Y3hlRlIrbEd4Z2h0RklnR0hU?=
 =?utf-8?B?UGdIL21BMUl4ZWpvT1hTWDZ0VkFwUzh4NGJYbFhWQ3ppSUtTa3hoUEFRc2p6?=
 =?utf-8?B?WkdZUGJCQW1oQy94dm1DYlpjejZsSEVReTVpWWtVNnRwWWNxemZZRS9hWGI4?=
 =?utf-8?B?QVRBbEU3VlY3U2ZKL2tmTXQyak1MZTBJWVp6UjI1eEJ2c203QWhudkRWbFln?=
 =?utf-8?B?dDE5UkRFM3J1WjdQVVBCdnh2UmYwREJOa1ZrVjRzeXRIODd1YllFTjd3QVZE?=
 =?utf-8?B?U2g2WXAvTVd2V3JmbXl1SFlnZFdLcWVvOVVTS3UxdlBGUUZoZmxSeTU2NFph?=
 =?utf-8?B?THJ1Q2FPc2FXWitOTXR4dCtzVC80L29adjlFUGYySHFyYXRrYVNMWkNQamV5?=
 =?utf-8?B?VmVwVnNTNVpEMTgrK3V3Y004SnpRZEc4U2tvSnl3YWF2QzdvV1NQVkI1eGxk?=
 =?utf-8?B?Tm5uTkNULzZUT3E1dXU3Y2FFUXJ3SnZUVldxRTJEN2d4aGpsMEV6Nzk5clhY?=
 =?utf-8?Q?3+w68FhzNQA2IEDC/gzpl1YMU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3429bc6e-f13a-4841-ee31-08dcd3ed8950
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 12:13:54.5700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpyddZMWMyJkgkx/ss1xmhuhOIjo3xsjaDVVcG6cSu9+gFaG82/23ywE5RtY/dAFEDWs5A0x2Z3RLXkoQNCOcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4653
X-OriginatorOrg: intel.com

On 2024/9/13 10:17, Baolu Lu wrote:
> On 9/13/24 9:35 AM, Baolu Lu wrote:
>> On 9/12/24 9:04 PM, Yi Liu wrote:
>>> set_dev_pasid op is going to support domain replacement and keep the old
>>> hardware config if it fails. Make the Intel iommu driver be prepared for
>>> it.
>>>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> ---
>>>   drivers/iommu/intel/iommu.c | 98 ++++++++++++++++++++++++-------------
>>>   1 file changed, 65 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>> index 80b587de226d..6f5a8e549f3f 100644
>>> --- a/drivers/iommu/intel/iommu.c
>>> +++ b/drivers/iommu/intel/iommu.c
>>> @@ -4248,8 +4248,8 @@ static int intel_iommu_iotlb_sync_map(struct 
>>> iommu_domain *domain,
>>>       return 0;
>>>   }
>>> -static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t 
>>> pasid,
>>> -                     struct iommu_domain *domain)
>>> +static void domain_remove_dev_pasid(struct iommu_domain *domain,
>>> +                    struct device *dev, ioasid_t pasid)
>>>   {
>>>       struct device_domain_info *info = dev_iommu_priv_get(dev);
>>>       struct dev_pasid_info *curr, *dev_pasid = NULL;
>>> @@ -4257,11 +4257,6 @@ static void intel_iommu_remove_dev_pasid(struct 
>>> device *dev, ioasid_t pasid,
>>>       struct dmar_domain *dmar_domain;
>>>       unsigned long flags;
>>> -    if (domain->type == IOMMU_DOMAIN_IDENTITY) {
>>> -        intel_pasid_tear_down_entry(iommu, dev, pasid, 0);
>>> -        return;
>>> -    }
>>> -
>>>       dmar_domain = to_dmar_domain(domain);
>>>       spin_lock_irqsave(&dmar_domain->lock, flags);
>>>       list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain) {
>>> @@ -4278,13 +4273,24 @@ static void intel_iommu_remove_dev_pasid(struct 
>>> device *dev, ioasid_t pasid,
>>>       domain_detach_iommu(dmar_domain, iommu);
>>>       intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
>>>       kfree(dev_pasid);
>>> +}
>>> +
>>> +static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t 
>>> pasid,
>>> +                     struct iommu_domain *domain)
>>> +{
>>> +    struct device_domain_info *info = dev_iommu_priv_get(dev);
>>> +    struct intel_iommu *iommu = info->iommu;
>>> +
>>>       intel_pasid_tear_down_entry(iommu, dev, pasid,
>>>                       INTEL_PASID_TEARDOWN_DRAIN_PRQ);
>>> +    if (domain->type == IOMMU_DOMAIN_IDENTITY)
>>> +        return;
>>
>> The static identity domain is not capable of handling page requests.
>> Therefore there is no need to drain PRQ for an identity domain removal.
>>
>> So it probably should be something like this:
>>
>>      if (domain->type == IOMMU_DOMAIN_IDENTITY) {
>>          intel_pasid_tear_down_entry(iommu, dev, pasid, 0);
>>          return;
>>      }
>>
>>      intel_pasid_tear_down_entry(iommu, dev, pasid,
>>                                      INTEL_PASID_TEARDOWN_DRAIN_PRQ);
> 
> Just revisited this. It seems that we just need to drain PRQ if the
> attached domain is iopf-capable. Therefore, how about making it like
> this?
> 
>      unsigned int flags = 0;
> 
>      if (domain->iopf_handler)
>          flags |= INTEL_PASID_TEARDOWN_DRAIN_PRQ;
> 
>      intel_pasid_tear_down_entry(iommu, dev, pasid, flags);
> 
>      /* Identity domain has no meta data for pasid. */
>      if (domain->type == IOMMU_DOMAIN_IDENTITY)
>          return;
> 
got it.

-- 
Regards,
Yi Liu

