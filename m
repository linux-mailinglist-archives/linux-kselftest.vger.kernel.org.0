Return-Path: <linux-kselftest+bounces-19322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1553996077
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 09:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B31D282B8B
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 07:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F58178CC5;
	Wed,  9 Oct 2024 07:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VhWc/lZF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58FD154BEE;
	Wed,  9 Oct 2024 07:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728458190; cv=fail; b=K6sIIUWr6BFAXZV2je5OgddOHd4DYyomz5hgjwB0DDrYZppRFW5KyS6EPnUY82CRY6Rc8Xke9rtz8JEeMhnlwo+J2aycEyXFMo/JeezNPAcL8qTGNV3/U5Nuze3Nl0QuPqolrUkAzb2fe3xdKArDoEhO3W+aEBG8YOGpF1ymuhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728458190; c=relaxed/simple;
	bh=HGhmA7sDY/kkVagtrjGJC3s1TCP3bTUGQbmPhL35bkc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t2V4DN7x6WVTLekxSAgMWkwStj3U+rB3YVSXH84BpndKrgo41kpamJVp429dlCgGX1jot2015QIRrFiAInnOMO9kpMk10RPfXsKd9x0c8wQ/CcH1Wzt/Mi4ux+Bz1r2iKV1e+fiI1DNB1xnMhJFklirp2cmFVS8HJ7KPE6wijKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VhWc/lZF; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728458189; x=1759994189;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HGhmA7sDY/kkVagtrjGJC3s1TCP3bTUGQbmPhL35bkc=;
  b=VhWc/lZF/wxsNxxE/LkDzZ/sW1Mv86xr2JoX4EZGyskGGPtnsSr3EOY+
   pKSFF8mMSJELwGh8U7YHHgK1MLyOIrhkdP5HK63Qd1xJHvyQ3UPqSPNns
   Wzjf8cf5DpgchmNHfoD1HHVtaaayWD74iiTzKLmwiayXc7o83ptog7Mu1
   i8grVIhcsKbdTLtsP7BhHidHV84F5ugW4r474ExriCqmz4rIncLpD3SMy
   sHGt0CwQYCAqeYCFFULq7hT/XGqU5Z+omHjnk61VCBqQGDv25b0EasC0T
   Gh2gpOsEMlX3FJ+fvoDYHZS+mbzbun0XWQdMuQktQM4Mo16AWOpOInkM/
   A==;
X-CSE-ConnectionGUID: nnhzHEKFSputy963ORmhsA==
X-CSE-MsgGUID: YJdjH3ywQ9adwZPHdZLbDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27873715"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="27873715"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 00:16:28 -0700
X-CSE-ConnectionGUID: +9La61OgScu3oH+FXhD6fw==
X-CSE-MsgGUID: 0cGvX9xrQt+NG8EL0zf7hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="106978998"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2024 00:16:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 00:16:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 9 Oct 2024 00:16:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 00:16:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6Zp7TGDyvc+hxfEUc/anRu5eLYaSlfAvWvaeiAOi2cepwT7dm62zYMxdnfTTBJx85fJ6mgc3tgMoy4vVseoi0HTgh93RtGEGHtiuJx/9g3j6hSsEipuPcp1cVXnEw3CwSon7dDyi30v39aGMsTmvt4gCXXr5Agfm4uct2PWzKHf0yruJtHc4hKfs9gG8qQbvWimDNRTnOICZxU1xOxYPSA1Of2FmOeFJnJmvUMBPjOiZMK0GIEDgu0SPyE51ud0i5I456RzVhYM6NshpWNlEpQfQw1Pumgia3sR3WGIE+KE9uxUVuB2xyE8BtQP8NzzZCeSJ3PsY0r3RMR/kIz/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8CIc1mEIWBzU2eQ0DEz5lFq9dgi8yeRhYLJGxvHINA=;
 b=tmxqVHfLSEyJJ3QIpAzCRcVr1fDXaRVYKrzV+vzSKkkhk9DMhYCdBfioCFT6Yy6QQLzmdUMKgnUezxtxdRxs0gtQ9gTSAGyyNf77IzMGpVIbt/Zj8bqftLBDD2QdEVNJP2q3Sq5lpNemJg5MNqmGcFeB+WKP5lyac4tm8YGeEB9Bs/y7u0MF2kPmGXC7LTqmf33eVZFH4flLMN0Xu5AuKQvSPIb8oVsQ/c9OXjWqQHhMQeNUVMFaCrmodcoK/JvOSNG0oVsGU+gdvuM429puuQUiLvbRZ4TLpWaEFIVMANTTZjKvvUFoI8GKm6f2bAOgzMhR67dKcuyKuq3R2a2NsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS7PR11MB8805.namprd11.prod.outlook.com (2603:10b6:8:254::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 07:16:25 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 07:16:25 +0000
Message-ID: <e2567891-44dc-48d5-abd0-e3fcfa02a4e6@intel.com>
Date: Wed, 9 Oct 2024 15:20:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/19] iommufd: Add VIOMMU infrastructure (Part-1)
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <bf95f910-e837-4d79-8218-18d234ece730@intel.com>
 <ZvRcskGx2u94Vs+R@Asurada-Nvidia>
 <82632802-c55a-4199-b685-8b594a8e7104@intel.com>
 <ZvW+BoovlyJ/wziX@Asurada-Nvidia>
 <ff35efa5-ba7e-4974-94be-59bf794a14e3@intel.com>
 <ZvZRapZlAsEGDIge@Asurada-Nvidia>
 <8440cd72-ced6-4887-b724-ce6a1650db13@intel.com>
 <ZvcZFDqu6Xf5P0Xr@Asurada-Nvidia>
 <380fe58a-934a-4e57-aa18-f4e0841b5fb4@intel.com>
 <ZvsfViW28vF+v6uN@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <ZvsfViW28vF+v6uN@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0042.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::11)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS7PR11MB8805:EE_
X-MS-Office365-Filtering-Correlation-Id: 03033896-11bf-4f90-39cf-08dce83248d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZDRtMEdvanlZbFE5bERqTGZHbzJwS2Z0MXAvZWl4RDRIY3ZoUk50U0ZpZ3pt?=
 =?utf-8?B?UzI0VmJoaUozRzkwaDlUbmtBRGdJcWR3RTd1OUV5VEpZV0pEVU1ORnpGRlJt?=
 =?utf-8?B?Y1dtNW1DWkZ5clIzbWQrMU92ZE00SlRPSGZlV2ROWFdmT2NNWTJBa3JVZmFH?=
 =?utf-8?B?MUVMOVdmWEdrMlFydWhycm5VSUUxV3BCOENtanZ1Z0xLekluQU05N01hOTQx?=
 =?utf-8?B?eDgxZVkzaXB3VHFwR2E5ZFNMVXkwN2FjMm5qdFU1bVJXM1pvWnQ5cGpEMHVM?=
 =?utf-8?B?Uzl2L3BWZ2VXcHU2TVh0LzMzZXhiU042OVc2VVY5Qml0c1BMcnpPZ3k4L3VN?=
 =?utf-8?B?b0JjdHE1T21QQUlpYUhGS0d0Zm9jRU9QR0l0OWVCREF1dkJRVURpWXgwUDh3?=
 =?utf-8?B?YUM1OFRIMVN4YXAxc2tHam5iYVhyNjNsNW9xUk9WMkpXbC9INS9Da05DWG5D?=
 =?utf-8?B?alJNU0tld3N2ZlRiMllJR01MMEpEbzBKdTZNeUpjblkvbVJwRjdtWldjdUhD?=
 =?utf-8?B?a0RCdkRScWN4WHQ1SlJJSFd6Z3R0S3hncFBqK0piWkNIaVU4alRSby9USXp6?=
 =?utf-8?B?SGJXZmg2QjBwNmRBS2VVQ1F6c3dMZVpXSzNmaUlMQmxGUDUzUkRraWhCclpn?=
 =?utf-8?B?RFFHVjRUcEJDOHpZUURuWC82bjJMcmk3ZEg0eitsZ2pSRUM3bjRjVnBjVjMz?=
 =?utf-8?B?TEhydDJwRE5KUzN2UjVqTGVmd1V4RFp4VGRxYkJnRHVsc2xHRXNtcllLcXVz?=
 =?utf-8?B?NWFLYjBRQnBJMlozN0ErZXg4djJnWmQ2YXIyRHZJZEx0aG5nY2l2czBSUnY5?=
 =?utf-8?B?aXV0dFBpQ2t1RHJNbFgzREhzN1QrM0ZmWmF0bis0TlV3c1FFVVBQUGFmeit5?=
 =?utf-8?B?YWRlVlozd2hGQ0ZYTHpkNjUrLzNyUFYveWFPSWdwUG5rVTFURFZYMUdoMnRu?=
 =?utf-8?B?Z0ZsaEtPbUVaMHBmcnI0ZmtodVc2d2ZKS3NhUEhFZlpWV0w2UVRaQmp0cVdS?=
 =?utf-8?B?citZbkxLc25LVWNBNGhnZ2JoSFdZd1R6NDhmSE85b0x0TzREaXkxKzJobXlV?=
 =?utf-8?B?RlhTZld0S1FqeUoxNzR4ZmFrTUlKbWFVeFJtSWhJYWlYaFhjRi9WYWpESXhD?=
 =?utf-8?B?cXNia2QzYU1hU2hwVjFEYjNYNGlyTXF2YlNObi9NQnVHS3BsZUVkcnVqNmZ0?=
 =?utf-8?B?U2pHOTBaNmVEdWVvdzVzd0k3V0c3TGJ2SzIvTEk1ZW9jTHRLVlM1VGZqYWpD?=
 =?utf-8?B?RDJpeXVkNEVERFZ2Nk5QMnZpeHVFamYxZmFybGZqZk43ZzZUTnI3MzZVb0Zn?=
 =?utf-8?B?MnREYVpFby9uUXFwdzNUVDdPcG5WbjJPcnV5ekJGUVBheVBKRncvWklaZjdY?=
 =?utf-8?B?Uktma1V1K2Y3RnVKQlM3Q21INGZacUxqTTRoMk5URjFEWjhZNVlGZDJGTG9k?=
 =?utf-8?B?MjJvWkUvWTg5OVBKN0ZkMDMxcXNkZUZ1bFNCZmFIYmlkbWVlTGN1RjQ1ME5D?=
 =?utf-8?B?ZTV0QnNic2FVUG02b09OczhXOUtjaTF0eDF2KzJVS2FEUnRkSHA2M2EwM2g5?=
 =?utf-8?B?V2NuZ0JiMndZT0c4NS8zMUlNcXVlSCtRcWZQc080OGJmUElOcUVENnI2dEs1?=
 =?utf-8?B?Tmk1QkJRTVVKamxjcFFsd1BFdWZUT3J3TzBkUURKVmFDcFg4cVFxdXcrRVpy?=
 =?utf-8?B?SXF0US91amtnUkozSThpd29uNEFBcTQrbVRPL0UxckZkV3BFTlVFY0FnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWVWV3IvaTBWY0ZWTkl0QzRwdDcyWGJncmQ1aGw1ODhFdHZYcndWR3lHZEM1?=
 =?utf-8?B?U2lncFlRbkpxaktqVk0xdnlKczNmR25IT1lVYjRXU2J4SzlnRGtVR3puazhR?=
 =?utf-8?B?MVM1NjErYnVER0ZMaUltVVE3N012alQyMGNWWDdtOWMyZk10UUpNTHJSdElt?=
 =?utf-8?B?VW5Qa0JZVzJIb2V6ZzlWUG84NU5mek5BZGROVGNMOVAvcFlRYWRURlZ2Tjd6?=
 =?utf-8?B?VkRDOW1SazgvVkIzMEIraENvQ0ZPZFFOUHVtdTFOMWtxdWJzL3Vjayt3dDBv?=
 =?utf-8?B?UzMyaHJCS1J3eDkvMmU3YXYxSmszTUVlZms0dmpKaE1FSE05aDdxcHBDY2Y1?=
 =?utf-8?B?QVdhREE2TUtkY1RIQmNrN1RKK2huSFBZb0hPV1owK045WUxXdlB2NlZPZTBT?=
 =?utf-8?B?YUl3YVNNMUVFU25SdVUvMWJheGpRUDlaOVlwRlQrdWk3RVExU2lWbEIrWWxD?=
 =?utf-8?B?OG92RnppcTRNS29JVGJUSjYzU21aVE5kbGNDTFVFeUtFbW8ySXdOV082MXBJ?=
 =?utf-8?B?Mlo4WnFyS2puRkpPUlNOOURzMEVNem45WHpXdWdYY0xYVHdiWEkrRlRSR1cr?=
 =?utf-8?B?eWx1QllvUm5ZTU9Bd1FTRVkzelVJdzZ6SndQR2xiRGRvUUxmVTFBdkZaWmtn?=
 =?utf-8?B?OHloZjdZVVJHcUVrMDJnY3Y2Qit6WC9MaHhhWXRXdWhoMXo2VldKVEo2aHF3?=
 =?utf-8?B?KzY5eU5HWk5XRk51dVNJa0RpSkRPUHRZcEFaMkg3KzVPaEhxL2h1TVZkMk52?=
 =?utf-8?B?b0c1NWpvK2kwQXVjNTdHU2k2ZVRVWE1mVFl4WTFNU252cXdEdkxwRklMUklk?=
 =?utf-8?B?UFVaOW1qdDRGVFR3TW9QZ09SYnI3V2dkcXlLNFEvRTdVOTFValpvQkJYUUg2?=
 =?utf-8?B?bnJ2UTZRMFlFVGdFWW85T3RZWC9tbTRoQ3hLd3RSVWQyeTRWeit3Z3BwcW10?=
 =?utf-8?B?Zko4YUtnQXZHOTBOZkxOblVqakVtK0w0WStZUzN1akFQQVNsZWFLaXZ0Z1Fo?=
 =?utf-8?B?ZEZWTGZjMW5xZVBCVjRwelU2SmR3QmVsQnQzUEo1QXNGTGh1S25TMTZzK3c3?=
 =?utf-8?B?YXRnbDBRcnFGdWtZZzhLTDF0TzlRTXpQNzJ5Q2RCSFhFZ1pVZWZhdTlqQ2Qw?=
 =?utf-8?B?U05kODlmYUJlTmZYQVVtZWxlVkFJai8wOFJ1eVpvbFRmSFlZMHY1RzBKUUli?=
 =?utf-8?B?VG9IcVc1UnQ3UmsxeWhoeFAxWE0zYWwvblhPZHJnYjNQM0luQVF1LzZRWFNY?=
 =?utf-8?B?bENIN09MdFIyWndaMHg3WEQ4b1pUVHJwa2xXVFlNbWk4U1pKZzZxMzlaMTFa?=
 =?utf-8?B?dVNCOGNlWGFHRkwvUlczRTNWUmNtN1BEZEFSZzRTT1BwT3E0UDFEbytTcW9j?=
 =?utf-8?B?eUpqT2xzYkJ4UG11bHZ6ZkNBR3hqcWw4ZWlaUDI1Q2RMcTQzYUJRVE43djFs?=
 =?utf-8?B?L3pnYjBqRTRRRmtqMDE3MW1jbU1QdFlVZU11TWM1UGRsd1dsUjlFNHMrbWN4?=
 =?utf-8?B?ZStLdXVTODU1eVdtWGxoaStLVkFnRk5RK1dzci93dmVUZ1NWR3c4dktUUkt4?=
 =?utf-8?B?bFh0U3RmM0hVb0U1c3o2ZStWRVZES0pPQnN1TG11dWRkY3RERkkyenFYMzll?=
 =?utf-8?B?NWxYd0k4RXBpVmtWemF0VDAyUUZTWjhxeU9MblBPMGlyVW1SWWVVK2RHc3Ar?=
 =?utf-8?B?d05SOUpMM21Ic2NYbWhwVnY5a1JMcklYQ2JXMEJtVEVkeVVGZG5wbEp3UTNW?=
 =?utf-8?B?N2dxUnBTQkZ1OUNQSkM4TTB0a0pFWVZKV1R6cSsyT2Z4TEJuVFoxU3JGMWVu?=
 =?utf-8?B?WjJEYjhSLzB2eThlYWU5eWN6TzlyUzJPWE9nSFVMUlIyME5nYXNOYWhPdTN0?=
 =?utf-8?B?TnZIWWIxbHcvaXNMTVExekNGV2hzQm13a1B0S2ExOUtJdzNIb1pFWU41cURV?=
 =?utf-8?B?QVo0TXBjNGFxNkNtVmlBdE9tT2FQWHgvc2ZoOWJWVVFXMVlVKzhxMGt3MGpD?=
 =?utf-8?B?d0YvSVVtY1NRVFFsVTFQdVJ2VFJkQTVOcU1MVmx2TngwL3M3TlMwc2Y4RGkx?=
 =?utf-8?B?clBiZ1NNeU5GNTdVcHZjTzlJVnBRRm02ZFhnekpVczVBOTJDc2t2Y2srYzhz?=
 =?utf-8?Q?/2ZzJpG6JzOkVdqa9IYpx/szH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03033896-11bf-4f90-39cf-08dce83248d9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 07:16:25.1120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GiG55dVpvUdPCKGf4p5adrVeMKhUQIOuhrqSbG1dkAnQ+UVKZd8+aSgvR9AKh4QExkT44ghGY7b12h407xsbaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8805
X-OriginatorOrg: intel.com

On 2024/10/1 05:59, Nicolin Chen wrote:
> On Sun, Sep 29, 2024 at 03:16:55PM +0800, Yi Liu wrote:
>>>>> I feel these two might act somehow similarly to the two DIDs
>>>>> during nested translations?
>>>>
>>>> not quite the same. Is it possible that the ASID is the same for stage-1?
>>>> Intel VT-d side can have the pasid to be the same. Like the gIOVA, all
>>>> devices use the same ridpasid. Like the scenario I replied to Baolu[1],
>>>> do er choose to use different DIDs to differentiate the caches for the
>>>> two devices.
>>>
>>> On ARM, each S1 domain (either a normal stage-1 PASID=0 domain or
>>> an SVA PASID>0 domain) has a unique ASID.
>>
>> I see. Looks like ASID is not the PASID.
> 
> It's not. PASID is called Substream ID in SMMU term. It's used to
> index the PASID table. For cache invalidations, a PASID (ssid) is
> for ATC (dev cache) or PASID table entry invalidation only.

sure. Is there any relationship between PASID and ASID? Per the below
link, ASID is used to tag the TLB entries of an application. So it's
used in the SVA case. right?

https://developer.arm.com/documentation/102142/0100/Stage-2-translation


>>> So it unlikely has the
>>> situation of two identical ASIDs if they are on the same vIOMMU,
>>> because the ASID pool is per IOMMU instance (whether p or v).
>>>
>>> With two vIOMMU instances, there might be the same ASIDs but they
>>> will be tagged with different VMIDs.
>>>
>>>> [1]
>>>> https://lore.kernel.org/linux-iommu/4bc9bd20-5aae-440d-84fd-f530d0747c23@intel.com/
>>>
>>> Is "gIOVA" a type of invalidation that only uses "address" out of
>>> "PASID, DID and address"? I.e. PASID and DID are not provided via
>>> the invalidation request, so it's going to broadcast all viommus?
>>
>> gIOVA is just a term v.s. vSVA. Just want to differentiate it from vSVA. :)
>> PASID and DID are still provided in the invalidation.
> 
> I am still not getting this gIOVA. What it does exactly v.s. vSVA?
> And should RIDPASID be IOMMU_NO_PASID?
gIOVA is the IOVA in guest. vSVA just the SVA in guest. Maybe the confusion
comes why not use vIOVA instead of gIOVA. is it? I think you are clear
about IOVA v.s. SVA. :)

yes, RIDPASID is the IOMMU_NO_PASID although VT-d arch allows it to be non
IOMMU_NO_PASID.

-- 
Regards,
Yi Liu

