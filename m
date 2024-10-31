Return-Path: <linux-kselftest+bounces-21193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A27599B753A
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 08:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4BC21C21B6E
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 07:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3F614A09F;
	Thu, 31 Oct 2024 07:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rhwnvn7r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDE7149C7B;
	Thu, 31 Oct 2024 07:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730359124; cv=fail; b=AZIGP2sund8SW6JZd7l4mCphilojBru09e9TZ/irKINJZbZHnQZ947krRTIP85coyXBnynEKSB5ZzIErEQHTL2e6GKDFeQTaHtaljB3inSrtHBlTBgERRPJ6A3B3QsWqbqbrnT5cgdGqGekevmpY/OoLLitbENuNvoWl3gKjkAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730359124; c=relaxed/simple;
	bh=N7XyVQbVJqFtSzLQNWtQDB2opjLvnnYaI1NyqtlJ5Pg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UxMCzoapEnhNCA5sBieZxoUQ7b+z4a0DehV471uKA8xt4TdGdzANzcAMGUbcelW231jzhnHXVXQf6DNOwWQTEnHiz2puUxl4VR9D/WMnv/Ffshm0sQwLLT50pNLynEbInwQ1Pzpj4YbKdhflJsLznpZrFZ74R+e0Ump/nCvqtH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rhwnvn7r; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730359121; x=1761895121;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N7XyVQbVJqFtSzLQNWtQDB2opjLvnnYaI1NyqtlJ5Pg=;
  b=Rhwnvn7rzk4Yj4JDqTQ38IAwsGbHai2J9tllxNBtKWuW3AfZBUA0i4iR
   R7bItjgmIkuLsHS3EPgNpWEMrutoARMuZstVYHimHNh+LE2xjLC06LWJy
   /geHYiiTcK1R26zx50Z7TFsxCkWuZOo+jUv+c+J5T4eeF4UzSEz+3MvDb
   8Vd9MjLiVTygK11ewDXVJDyvcTAMDm02GfaxzMvFFYCFum3Nt2qcyPJ6s
   KqyYtxDroSk+9fYr/2Cwvh0Da/hF9HYlsk3N9z6dBPk50WhgfpROnV6bm
   HNOLMnuRJMl//70QtehPJ6kh0+wz15OyM386BBSZ+uOjuPM1gjtDSWwiK
   A==;
X-CSE-ConnectionGUID: TkS+qYAmTf6J2dlyQ51v5Q==
X-CSE-MsgGUID: RYdeDMV/RIGxbUibTA+ISA==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="30297903"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="30297903"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 00:18:41 -0700
X-CSE-ConnectionGUID: Xxsr2pUUT9uVWt45GfnUYQ==
X-CSE-MsgGUID: Rxo0qWT9TNS1+FQB5IxUyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="86477841"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2024 00:18:41 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 31 Oct 2024 00:18:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 31 Oct 2024 00:18:40 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 31 Oct 2024 00:18:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DV3PmVD04+NtU4/N32DlytpeZ5GCBAq/zYNoSBzF/unnDc0Q/XXu17cLXjlHyFjbmwaSR5Ck1bRSJVatKZ33vMES/GnoIQc4m+zcVXR+b4+ew/QBZeTO0lk1XwIGLEOQLpS6i1mtuaEuWhWVvr9KF7YbbrZYkI8bfcp8a0Ndv9odeLe/p6enhMCEd9VnlQZAipOgg1Cbkkyqtw4qP6vyqGOJw6zd/J0N/Cg27irtWxUAyeAD20r7j9X+TXMzfGOTOqLs9R1Gy9ogHTH2va+zr5gmKDkNU4DG3pKNUWNWMlaodYw2e0UroIxS08BdwqzEGhK3tE7UiDRmmEa9rGjW9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgVxbWeJcEBCQ9Ru/RnWj9nE3lUew9frG8n/X5oYANw=;
 b=RaU33lzKizot6xHNknfGzygV5tL5oj7Ot1fU5MAWztucI0vGh16mKzL3a/l2483E23PB+Uun8S3U0gXnBey0Dzkxt0fG5rXcHGZaAVi537nWnsOe+1AqVY2VUYq0cAXeQk3PNTy5ent6kwQQ5Mq9RNwthVpdsobI2jBr5ghGWjaTFpU2eM8CXttsxwvQOE1djh2MFyLEC3lQsmz5+SZblgDyz61t/l55RRRLYWtb/E9ypGO9Q7vzheRD4EVLTtXbeLE15pNQGnn7rSBRULzVq0e1nwZmhwfVnwdhzAQedviifYvFDEgmnBRnA5KZrmYp6cHsWE7Mz7jkRqSPmaBKuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB8454.namprd11.prod.outlook.com (2603:10b6:510:30c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 07:18:37 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 07:18:37 +0000
Message-ID: <2e04d06c-24b5-4162-8b94-740b9544f951@intel.com>
Date: Thu, 31 Oct 2024 15:23:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] vfio: Add VFIO_DEVICE_PASID_[AT|DE]TACH_IOMMUFD_PT
To: Alex Williamson <alex.williamson@redhat.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>
References: <20240912131729.14951-1-yi.l.liu@intel.com>
 <20240912131729.14951-4-yi.l.liu@intel.com>
 <BN9PR11MB5276D2D0EEAC2904EDB60B048C762@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20241001121126.GC1365916@nvidia.com>
 <a435de20-2c25-46f5-a883-f10d425ef37e@intel.com>
 <20241014094911.46fba20e.alex.williamson@redhat.com>
 <2e5733a2-560e-4e8f-b547-ed75618afca5@intel.com>
 <20241015102215.05cd16c7.alex.williamson@redhat.com>
 <e76e4dec-f4d7-4a69-a670-88a2f4e10dd7@intel.com>
 <20241016101134.0e13f7d7.alex.williamson@redhat.com>
 <7f95f2cc-6691-4f40-bc50-e4430ebdbf1e@intel.com>
 <7d8b2457-8dc4-43d1-9a12-19e2a71a0821@intel.com>
 <20241030115142.47272017.alex.williamson@redhat.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20241030115142.47272017.alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b4ea2f1-d262-41a7-aed2-08dcf97c3cf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d21jZ2xtbWNtaWluR2ttY2xEYmFudUVmTkZVZStSQ2RPWXNDcVhaZWpxTnpz?=
 =?utf-8?B?eU5zVnhQOFU1bTZuTGFwYUhZU3NieW83aGIydFUzcy85WWVUVVZyQ3JRa2RH?=
 =?utf-8?B?ZkVaMk9BZk42RjZDMC96OER3ZWsvUFpXNk1rYUpWWXNabWlzM2xDNFhUejF3?=
 =?utf-8?B?QXMra1JBMjZUQ1VXQzZEd0gwNS9veEROejdic3ZvWmZaODRRYnNSN1BKY1Br?=
 =?utf-8?B?eXRRUzRrcXZEZWcrWW4wMkJsbXAxenVxTVdmRzlnUXUzaW9xVno1QXMxeGFz?=
 =?utf-8?B?elNrWTBTUFJtS3lTdnpldmc2WDBYSE9DUzhJTXM1MGE4SlNpNGc3dDFVdEhZ?=
 =?utf-8?B?MmdOVlNRVW1UWnhneHZQU3RZb2IwVlVDUXhSMDZnTUpiRDZlTGNZMk9UeDFY?=
 =?utf-8?B?VWZldWlOWnhWSFpUeHVkaTNZV2o2K1c2dnV3UVJtOTAzNGhGanExUHJVL0Q2?=
 =?utf-8?B?dEdYdGlSWkJmVytkcmFtQ1ZjZTFtUjBvQU9jcWdrZmZaZXFVVzQ4eUxCeVI5?=
 =?utf-8?B?Z3ZudnpLZDVTZjVHY3lYYmgxbHAycnY5bjRpNE1pc2pKbXp4bnk1TVFRRWtp?=
 =?utf-8?B?UThoTGlLUlRYZmQrMlEyZ0FOZzN0V1BuVEZrUVd6eC8vNVpsSVJBdnZOTHQ2?=
 =?utf-8?B?aFdhQ2UvMERlTzduUCtRSHZ2YVZFY1I4OUNhM2t1ZHd5ajNVaGlQWDA2c25E?=
 =?utf-8?B?b1FHM1RaQkNXK3VsY1c5a0NsTmdxdjZLVFIweXJRQlY3NldNVnZFeExVVkZl?=
 =?utf-8?B?L29zWWdSZ3p5U1c2VEVoSzhHWUhiaTloaXBqU3pWOTEwUERqVjBsaWtJakJG?=
 =?utf-8?B?K0xWd2xYREpvOG1iL3dPNzJBK1ZHQTdWemY1Y3gyMlI2NDF1VjFRRXMrSHJZ?=
 =?utf-8?B?elNGZ0MreEY3MEtJaStucDVTOVo5TGhIMG1oSjMwSTA3aXJyQmRvOFEyWk1I?=
 =?utf-8?B?Z1ovMnhQaXlSajBJak9VK3Z6LzRHYWJIK2g0WDVPZm5Bd3J6dU5CMHlVdm5U?=
 =?utf-8?B?NlYwMDZHcjdRVHhNMk5qKzFnc1pWdUhJVzZESmNyUXF2TnZ3Z0pWQXI5Vll0?=
 =?utf-8?B?bVVLL0EyLzhCYk1OSWhzMG9CZmJFV3V4NFUwSmhkWDBwWEthMXVPazlkOVcx?=
 =?utf-8?B?RHV5N1R3aTQzbk50MUs4djVHc011MnROaTNrUE52Sk5sRkxFUXBTVCtucUJy?=
 =?utf-8?B?MkJpWExNL0VRMlNaVmF4MkszbkJDeU9RWTVPUlJHbnFETEpkVmwySEM3bXBr?=
 =?utf-8?B?QUxWUnNDVmhWWDhvOTlxcDMxZEMvT3JtYm5SNndNOUVvdENyRVhZcFo0VHQy?=
 =?utf-8?B?V3MveExkalBnb1ZPWDh1bE9Cck84c1NtZWhmNjFTQzdKVDZrQnZRa2YrUUZ1?=
 =?utf-8?B?S1BhSHcvWGdFblNDN3JHN3JIY1QvY0ZZZ0JjTnpUdWd3cDlENVUyN1hlR0Zn?=
 =?utf-8?B?ZlYwQmV1enJiUlQ2RStVRDNwYUc4MzB1TmlnV1NZVDV2MGRoM3BSL2gwbkla?=
 =?utf-8?B?Sll5K1ZsNlJCYllaWURVbWlmbGRiQ2VQczR2SXpCT25jd2orbFVmOWMxcDRx?=
 =?utf-8?B?ejZUWkVzTVgxd3NtWnpydGZVUnpkNyt4UERsZHBPYUJkVFVzMHdsY0lUdGlK?=
 =?utf-8?B?NjRURGtTN2RZMkVPVkVhZ2JzRTd0ajVVSHZyYVpxZzVmWGNKNmVJZkE3dTFO?=
 =?utf-8?B?U3VCZ3hoSWJqclo1ZGlPYk8vOHJXVWpMSHVSeXVRN0RYVHRsZnI5aVJVV1c2?=
 =?utf-8?Q?4DrrDASTVQCSWEDh/A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0M2aFNZVjJ3VVVaUS9qUncwcDhlK3A4OC91RDJzZ0VhUEdRYmRHUGpCZ1F6?=
 =?utf-8?B?bDRsejZlemRGdDlSUjdtUCs3SnRYZVRXRUwwcThWbjVZUVhZMXE5UlZSSDZp?=
 =?utf-8?B?QitiU01xTWg4SitzSUpxZ1lFb21jdFQ2UWFUdjJKUHVPcFphcitteUxHNUp1?=
 =?utf-8?B?VXhXU0MrMWJOY2pvZzd4OC9SZUdBSExxV3gzdThVR2ZWaTVGMCtnZEloRUxn?=
 =?utf-8?B?Y1ptZmhjRTN3VC9KbW5SdWkxMTkyaVNjY0tOTGVpSFZVRHhMd0Z6VkM1Uy9D?=
 =?utf-8?B?YkJhZzEzcXU4bUNQR2VxdU9kbjJ5TitMYnpNazJTNjY3ZU9xZjM1aTIwNGVL?=
 =?utf-8?B?Y0dHT09KSlhpVkhqUUFYeXM0eVYzcmFGcjBUY2FEdE5LdTBBaW13K2lyQm1r?=
 =?utf-8?B?QXZWUE5DQmVhblhVa2FrTTBZeG53R2FCMFdzNlFGTE5vQlUvYytGU1lZanVE?=
 =?utf-8?B?ZGJnVkloU2VMS0M2SkNPdWN1OVdMTjhIYzFCSUUyaXQzUW5ycjBlYlVjSmFT?=
 =?utf-8?B?OEZER0xKQVcyOWg2VlJVd2I0R3Z2TkZlZDlFaEt6WVZ1cTRPVHNkMFIvSURh?=
 =?utf-8?B?SXd2YzAxNjNMdWsxbjhveGVBazJjNmorZndOT25vYTc4cWdOSThFUHJVZkll?=
 =?utf-8?B?eTU2ck1keEI2d3BrVnBBOW45WnFWTDh4SnhCL1RCQVZnT2VFMmVyajF0akZz?=
 =?utf-8?B?SmVHUFVScGJOWDZja2xuU0pheDdmOGpoRzN5VFptYjBrQzJDbHhKcC9TSnFP?=
 =?utf-8?B?WU5qTlZxRXY5L3RnTmhKZmJhQTFPU0FzM0Q4cTJHQVFiall3ZU0ySG5hQXN0?=
 =?utf-8?B?dG13Qy8rR0lNVXdCRVJKTGhBRUpJdU1yS0N2b3BiZStrZnVjK25nbHpYamI2?=
 =?utf-8?B?LzJEOWZXcjVOdms1d1ZBUUhYMkhuVFBtditNU3dTRC9SYkthcWxTblVhd3NG?=
 =?utf-8?B?SnlVMVZLclhVUm92SENnUlZqR0N3b2pvdWlvdXpjcUg5NHkrTUU5R1dLcDB5?=
 =?utf-8?B?UkYxdm5GTHh1YUVyMGw2b1NobVN4clJ2dElYOEZTemZ0TTd3NGpvYlR1amIw?=
 =?utf-8?B?Nzc2WjNRMjhjQzlBSnlQa2NneFdsN1YzUUNWVHJGYUJGU2FMdVRTeVZQcTd6?=
 =?utf-8?B?ZklnNFFUTWc0ZnFUZjdTTXl0OEVJWjJESStxQ1hhZ1YzNENhdVE5ck9lMlM0?=
 =?utf-8?B?MUdWMEtTcjhPcGVFZ25Ua1dBTDF4eHV2VENaa1ZIZkxnODRPSncxU0RTTHJa?=
 =?utf-8?B?M1IzS09jYUZobzlQdS85b2prMEpzUzhhL2UzZnpRU0tjMjFSdGZ6MVo4OEhu?=
 =?utf-8?B?L2dTN09JalR6U0RHMnVHQ0VwZTZyTU9ycG9WSGZmbmlId3F1VnJJTnlEN0sy?=
 =?utf-8?B?OVZjQzZzVTkwc0xKOTlaeU5uTUJtTkh2Z21uaDI0bU4rbThEYUNGMVYwMEhz?=
 =?utf-8?B?Z29zNG1HUGRPMXB1MHhHc2lwVm9aTUdXK3M5dXhtVWZHQ1hLMkV3Y2IyZE5j?=
 =?utf-8?B?ZzV3M3lkb3dJWWJaTWRQY3NTd0M0RFFaZ3hPZmpxNmp1ditKYUs2dE1RSTEz?=
 =?utf-8?B?MlFIYk1Xd3ppTUs0WEk5ZHJvY1hib2MvQTgrSFFrTDN0aEJQQTk4bkVJSENh?=
 =?utf-8?B?VGRLQ2dIQ0hpcEQyR1FDVHFQVzZoMXUyMjlHcTd6WFptWnBYU3RoZG9aMzJS?=
 =?utf-8?B?bURQbXI5U1dsSHlTS0p1WCtzMEkxYmhTaWtqR1VxOHJsN291UzBxMGpjVnRZ?=
 =?utf-8?B?Ykx1QXZxdEN5QzBIZXYxZ0tuVzM3aG9UeDlFaEhXYnRzem5JOEtrc0xqY2wv?=
 =?utf-8?B?dFFUL2lpdVBnbnJaRUZHVkNOVHQ3dVFacWN2ZklzZWQvVmJNMlZHTTBnV0pn?=
 =?utf-8?B?OG8zUGlueVoraHNPeVBadG4rWkhUVVJhVEZHbzU5b3N4ZVNIcDNvTTRTQUpE?=
 =?utf-8?B?OWU0NXZDejFPN3Z1dTIrN3RoekwxdWhZVXQ0c0plMGRhT1EvZmZEOGtaNUJI?=
 =?utf-8?B?azlJMEJQejByZnA1Ny9qMURRQ2RNMFZENzgyMSszV1JBb1k5NXp3a3BDZ2hD?=
 =?utf-8?B?Z0Z2NVYzRHZGdDRGbDJjNGhFOGk5alJzdyt2MFdCYXZZSTB0TlYyOHlCNnlj?=
 =?utf-8?Q?7Fb+K9UBZHzjUDkevGWvFd/af?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4ea2f1-d262-41a7-aed2-08dcf97c3cf0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 07:18:37.4977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFtAMl3xcU88O/oKim+D8ObdnMkqStaogBfRdnJQi100CpwHnJYoWJ41KtfSfn1aEsdS5Vu77b1Qi55Aba1lQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8454
X-OriginatorOrg: intel.com

On 2024/10/31 01:51, Alex Williamson wrote:
> On Wed, 30 Oct 2024 20:54:09 +0800
> Yi Liu <yi.l.liu@intel.com> wrote:
> 
>> Hi Alex,
>>
>> On 2024/10/18 13:40, Yi Liu wrote:
>>>>>> I think we need to monotonically increase the structure size,
>>>>>> but maybe something more like below, using flags.  The expectation
>>>>>> would be that if we add another flag that extends the structure, we'd
>>>>>> test that flag after PASID and clobber xend to a new value further into
>>>>>> the new structure.  We'd also add that flag to the flags mask, but we'd
>>>>>> share the copy code.
>>>>>
>>>>> agree, this share code might be needed for other path as well. Some macros
>>>>> I guess.
>>>>>   
>>>>>>
>>>>>>      if (attach.argsz < minsz)
>>>>>>          return -EINVAL;
>>>>>>
>>>>>>      if (attach.flags & (~VFIO_DEVICE_ATTACH_PASID))
>>>>>>          return -EINVAL;
>>>>>>
>>>>>>      if (attach.flags & VFIO_DEVICE_ATTACH_PASID)
>>>>>>          xend = offsetofend(struct vfio_device_attach_iommufd_pt, pasid);
>>>>>>
>>>>>>      if (xend) {
>>>>>>          if (attach.argsz < xend)
>>>>>>              return -EINVAL;
>>
>> Need to check the future usage of 'xend'. In understanding, 'xend' should
>> always be offsetofend(struct, the_last_field). A userspace that uses @pasid
>> field would set argsz >= offsetofend(struct, pasid), most likely it would
>> just set argsz==offsetofend(struct, pasid). If so, such userspace would be
>> failed when running on a kernel that has added new fields behind @pasid.
> 
> No, xend denotes the end of the structure we need to satisfy the flags
> that are requested by the user.
>   
>> Say two decades later, we add a new field (say @xyz) to this user struct,
>> the 'xend' would be updated to be offsetofend(struct, xyz). This 'xend'
>> would be larger than the argsz provided by the aforementioned userspace.
>> Hence it would be failed in the above check.
> 
> New field xyz would require a new flag, VFIO_DEVICE_XYZ and we'd extend
> the above code as:
> 
> 	if (attach.argsz < minsz)
> 		return -EINVAL;
> 
> 	if (attach.flags & (~(VFIO_DEVICE_ATTACH_PASID |
> 			      VFIO_DEVICE_XYZ)))
> 		return -EINVAL;
> 
> 	if (attach.flags & VFIO_DEVICE_ATTACH_PASID)
> 		xend = offsetofend(struct vfio_device_attach_iommufd_pt, pasid);
> 
> 	if (attach.flags & VFIO_DEVICE_XYZ)
> 		xend = offsetofend(struct vfio_device_attach_iommufd_pt, xyz);
> 
> 	if (xend) {
> 		if (attach.argsz < xend)
> 			return -EINVAL;
> 
> New userspace can provide argsz = offsetofend(, xyz), just as it could
> provide argsz = PAGE_SIZE now if it really wanted, but argsz > minsz is
> only required if the user sets any of these new flags.  Therefore old
> userspace on new kernel continues to work.

got it. This should work. thanks.:)

>> To make it work, I'm
>> considering to make some changes to the code. When argsz < xend, we only
>> copy extra data with size==argsz-minsz. Just as the below.
>>
>> 	if (xend) {
>> 		unsigned long size;
>>
>> 		if (attach.argsz < xend)
> 
> This is an -EINVAL condition, xend tracks the flags the user has set.
> The user must provide a sufficient buffer for the flags they've set.
> 
>> 			size = attach.argsz - minsz;
>> 		else
>> 			size = xend - minsz;
> 
> This is the only correct copy size.
> 
>>
>> 		if (copy_from_user((void *)&attach + minsz,
>> 				  (void __user *)arg + minsz, size))
>> 			return -EFAULT;
>> 	}
>>
>> However, it seems to have another problem. If the userspace that uses
>> @pasid set the argsz==offsetofend(struct, pasid) - 1, such userspace is
>> not supposed to work and should be failed by kernel. is it? However, my
>> above code cannot fail it. :(
>>
>> Any suggestion about it?
> 
> If a user sets the ATTACH_PASID flag and argsz is less than
> offsetofend(struct, pasid), we need to return -EINVAL as indicated
> above.  Thanks,

yep.

> 
>>
>>>>>>
>>>>>>          if (copy_from_user((void *)&attach + minsz,
>>>>>>                      (void __user *)arg + minsz, xend - minsz))
>>>>>>              return -EFAULT;
>>>>>>      }
>>>>>   
>>
> 
> 

-- 
Regards,
Yi Liu

