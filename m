Return-Path: <linux-kselftest+bounces-19725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 397BA99E4F3
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 13:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91633B233A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 11:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C221D2F59;
	Tue, 15 Oct 2024 11:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QI1Lr+by"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD01815821A;
	Tue, 15 Oct 2024 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990207; cv=fail; b=rWYqZ18vi2Kjakse7+YymX2NJWgjHOx4nCVF2qAJxm2qPv4hnj4u6y5O3GQC6Hn/ro8YAXJ+toq8q6p/DSlHV8x3jzqcA5uCFqdlgmhOk3+KC27mYz0BTp2gCE9wpSLyTWaXnLSz27DmH7YgBNlxp/PMhkUE+/SAP+6MjWsvo5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990207; c=relaxed/simple;
	bh=+Oyj9UIFA/aI7PvGaCzF9Fg0+J2Kjqs/wvWoG+0uz+4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n8P3RXa9tm1DjL4VOeYgpJccJzl3EqQe9iJDe0QorKpciHWB9Glhotzc3Sr6ZHOKBO2DImMx/cJBveCuhTtPrJnvtglHQpDiLxKV5QKL61RpBrdONKaBx5Vol7Iu+UAPMBc8WNjG/zth3wI9jjYThUvqKJAPfea+MpwiJOSPg4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QI1Lr+by; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728990207; x=1760526207;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+Oyj9UIFA/aI7PvGaCzF9Fg0+J2Kjqs/wvWoG+0uz+4=;
  b=QI1Lr+byubjaRIf9+KDiZOnuXxn9Klc8LG3t+d5YuTpTc58VidtocAuE
   CGUuPBGctQqdQTTZt8olAcbFs2eHpvCbINuhwT+ZLcL7w1l2wQDrLvMBY
   b3a4XXSjhHHkoAUry15HSS+2Nkg8GvzplL1fzSPnp4SuhSynJKsug0/dW
   ML2/tnT7Q5TJVExuq0cP50ocaEx8uOCovbyQoNeDRP911Wj7wd9T2DhDd
   alj8O7ET/Y3c+vZsfbdSlzdEq2HRHQEs6F2RebkMK0m5UI1YQr1XgNjF/
   21fOkdwsIU5znTNFNFe5bpTK4CwPu8LBdUJWzRtCjhJ/3dGMFXQ2DCCES
   Q==;
X-CSE-ConnectionGUID: Nhvixf14QS2Epvq9F5Of2w==
X-CSE-MsgGUID: g8wbY9FvRW6esBqxiahUVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="38954008"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="38954008"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 04:03:22 -0700
X-CSE-ConnectionGUID: ZHvZ4NpsT4O0IIHj7Kv8jA==
X-CSE-MsgGUID: p1NnKig/T6y1kn3NqMqSmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="77870197"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 04:03:21 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 04:03:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 04:03:20 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 04:03:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 04:03:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wz30HghvobZsztKUnTKcsQMKJpS8LVJ/H5JpjUDXSJtCrBTdBVW7uvQi8zzUrOnHajVTAKjeRRlqXnXXfufz4bmsZYqJvrQyrKjFGn2BLcPjzbZuUpINek+YlFBvbufF5EkVeEWGpYe1PM3TQ0bJD4yon7Jv0l9i5z5iG3AM18mMF4XAZQTLzJCJOYkVCd53wSjwyu3/tPteUyq3I1POG8XlEXoiEajaZ2NvRRFrfWnyAcoiGyTYU8CTaLBB2UQkZscm3YggkAXnkr4J47thKtbqotezP1uRUp4fihQ4KSmVPUyb5npzhHybvNHIYlcbkBXyJaTuU6evvUTZU3/jhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFZOxUDI02lNxB83CVHvObh8TRKMhHZGqvzkBHNqRSo=;
 b=DwPQeOYuQpRn4wOgXJ0Qu6abqWolmEQGFwFkJCHWj7167o6cP9kzrwtn1btnIheDJEMpjmilq+HqnninhSNZ4kvS2Wm/UanjzfnsiochN4BnMazNNr+iTRjMqjsg87txWh0ocEmIbXPUT45C++9phwuGr9LHrw0pKP+SQu2UP3RSreyQeEvgUWYR9CcPdy4eMrduvna2RsvBHTG/b8A1PyHZ6R4id/obhNxfhu/V3edujI3NjWydYZOFv0/fW9PEpMQB3zT7TF8950x0p4FNo7qQHBZVHyDNzMDhSrgCgeZsw1ewuN64t551oYFeBCxvwepZFlKrhMx5A55b+8QmLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA1PR11MB8804.namprd11.prod.outlook.com (2603:10b6:208:597::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 11:03:17 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 11:03:17 +0000
Message-ID: <2e5733a2-560e-4e8f-b547-ed75618afca5@intel.com>
Date: Tue, 15 Oct 2024 19:07:52 +0800
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
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20241014094911.46fba20e.alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:3:17::36) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA1PR11MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: da781924-5dde-458b-cf3d-08dced08f912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlNna2I3TkRXWVE3SDNjQ1lnMzlraHBsMEdTOE9lRkNBTlc4bE1tK1djV3k1?=
 =?utf-8?B?SUFMcGdFV2x0U3dPTTZ2eEQ4SENnMXhYU3FQckNydFdxeWxSMS9oeUxkYmlB?=
 =?utf-8?B?cnlRbVB0aThYNEt5eEI3YjhDdmdaN3R5SHBvSkN5QkdCQ0p3S2oxTUZzekFT?=
 =?utf-8?B?UXZJa0h4cnBFOFp6QVdKejl4bEFKdTFoSVhhM2VjMkc2T0c0VXQzYlM0SGZt?=
 =?utf-8?B?dE9vQk9kbVVxVEQ1eWNaZ2xkKytmM01IZlpFa2dMekVWMTRCUXBFWTBUVUIv?=
 =?utf-8?B?UlhrcUV0MzllR1gxZzNQZk5PTWVrM3RNL1dGT0hYbzA3NGJ4ZjhlWXlmay8x?=
 =?utf-8?B?aDg1N0FYRVl1Nm9mV3RaNy9kbUw4R3ZwR0Z6VHJhZXI4Sk1ZYUdJMTZ1cjJx?=
 =?utf-8?B?R2gxcUMyendQOGFtT29ua2JRV1E2MGNkdS9PcUtrWFpLS1dZSWg5REZpTmlz?=
 =?utf-8?B?Y2theFJraStEU0FnM0dpeVU1dDhNMFhVZjRkeVdZMm54TW1lbUFrUGlhVVJL?=
 =?utf-8?B?OG5QN3FLaS9XWHYxaXRMS1lTSjVwTEtyWlc3TE44QSthUFI4bnl0R2Zhc0lO?=
 =?utf-8?B?cmlReVRFS3h6RzNpaFY1TWRINWpZV3ZOZDIzRTVLRTR2ZlBTeDFrajJwczkx?=
 =?utf-8?B?NkZnZjkraW1tOUU4STNrZDFsanNKQ1hHOUVnSmptU1Q3V0EvVXJTdFQzMVc5?=
 =?utf-8?B?elRoRng4cmllSHh4bjJVTm9Renlyb2tCenlhQmVLODRhOURDMDRZMStDdFIz?=
 =?utf-8?B?a3JtTWNHWVBFUTI0NUFXYWVqR3p1ZHZYM1ZFckJSVjV3K1lXR0JzVUw0OUM1?=
 =?utf-8?B?OHZML094bXR0SnVnZThXb2NTYU56WU9EdGx1dWxiT2dzKy9Xa0JrUDZISjhv?=
 =?utf-8?B?U21nOXAycC9mL3pCTU9ncHQ3RTNaMUFLdVkvNWV0TkFYUEJzQkJ6MzB2dWR4?=
 =?utf-8?B?ZnRhMDJVUzZnQnJZU2NqZEdoUmJ5NkxxZEpSajEvd2xCS0wwblVCRC9GOU1I?=
 =?utf-8?B?cFNLL01XR1Q3b1pIblRKNWpMQmZhbUl0bzkrSG5LTm9iLzcya29RUUYram4w?=
 =?utf-8?B?S20wSXEwekhDQ3BqVk9hOHovWURJQzJ2Tm45cHB1aE1GN21Hd3NGWjg0Nk4x?=
 =?utf-8?B?c0liWmpOOFVNV2RIdjVZN21UQzJORUNWcGNRWW9GbVIxY0Fmd1UxSWlURUNV?=
 =?utf-8?B?WXZMbzl6bW9pMXg0enF3a2FNdExrSWp4eWcxeUNGS1hOZnVQWHk4c3cxeE1W?=
 =?utf-8?B?KzdLWWI5QUdaYjA5RHhBTHZHZkk0eGdpNmRTTmUrN0FSR2hrNzJzZndVbDFZ?=
 =?utf-8?B?dkcrcWNpbjRZVFVsUFVNVXJYNnRYaTViQnhpd2x1U2o3QU9QMlFuaUh5WlpR?=
 =?utf-8?B?eGdyeWNEK2h1K0NieERPRDQxWGpaa2JYZWx4ZDZsb2JrWVNNUzA0MFg2QUdY?=
 =?utf-8?B?NURMNXplTXBINjJQVm5NY2twbTRSR0kxSUNucTU3Yk4wL2VWMlRQWEYyRTZ4?=
 =?utf-8?B?UzlUUmF6R0J6cURCZXJVZnI4MEJSaUFTQ1JqZ2hPRjRkSklBL2Job0ZGS08v?=
 =?utf-8?B?U2ZWclNtcHBRU3RTdm9lMGFwYlJLMHlkTkgwWHhhTkNqb1l0L0lLV2kyb0Zv?=
 =?utf-8?B?S3ZIMzBhbnB6aTFRVWNpdzcxREVpSU5MY0dtOEpJbkFVamdEeWVBWjVLemlr?=
 =?utf-8?B?Q1paeXE5MHZMbEw4RVRzdlhZam1mSnpZdEI2ZzNzQlJEdmF4aGMyNHlRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OThLN0RVMjExL2p4THRxYkZzQTlzWFR2MnJwUGNGSDJ2T2tMbktySkFINC8y?=
 =?utf-8?B?Vi9BRDkwbVFZWkVJQ09TR3Blb2tucEFZVTd1OFRjR0V2Ny9zLzZETFdsR3BC?=
 =?utf-8?B?dXcrdVVyaG05UXh4ckExSE43YklHSi9TZzJSNDZnRzNoY1ZWQ2hUUVgvYjF0?=
 =?utf-8?B?bk41U2RJS2I2bDU3YzJtbmRHb05pTkY5cFQwQU1yaDB2NngvYkhLRHhPU1JX?=
 =?utf-8?B?QVlGdUlkMnZub0JOMmU0eUVHRmh4T2FKaXFvZWZOZE02YkpkaXhiMUlnTllz?=
 =?utf-8?B?eWs2amducFZzdDJld0x0TmVjUklxMTEvcm9NdzBidFFQYzhTUmE4ZEwxcjNl?=
 =?utf-8?B?K2IwYmxMMmo2dGtVQ2sxUVNjMndXUjE1ZlFOaTliNDZhM0twQVAzeTFHQlps?=
 =?utf-8?B?bWN5cTlVeTVpNEQyY0pSS01JMmNXUjdTY05wd29KNFZHVHRwcFppRmZqakZl?=
 =?utf-8?B?TCtxa3d4TmlrQmdGSzhEeDQ3NGtFQzVVSjZXRVdFSFZiTmJDdlFJWUo0RTNG?=
 =?utf-8?B?SnowOFdDMUcxVkVub1RDVHpXcFBxSTBqRFdjU0FBV0lDUWNpWTg3YmhOWjA0?=
 =?utf-8?B?akVCVDRzVGxxSmFka1ppMHB3OHh6Ym10S0hlZGNiTG82c1U3ODBDajZSbFNB?=
 =?utf-8?B?dFJXWnZ0R1hMdXUxL2NISGx3UDdvdG1tSGlxNVJrY00vNWJaVTB2WXBkSWpq?=
 =?utf-8?B?Y2FveDFEbkdYclMwV2JXdWJOa0ZjRis0dkRJRnFwbnBZeS9pNXdFZDNLRCtm?=
 =?utf-8?B?NDZOQy9ZYytSWEVwVTAvM1FFYzZ3WGcwaVQweGdiTS9RUlg0a0JkMHNDQ2FM?=
 =?utf-8?B?YW5FVXhveGZocWdvWGlDMGw4dUdhVzY1Tm1YakRBZ0lwQWxIbWRkTXIrdjEz?=
 =?utf-8?B?aklWQmdMV053aG9JSU9DTm9LQ3dYMWxvcmV5WlNoTUJJak1qUk9IQ3dYWWJm?=
 =?utf-8?B?eW1SWDNOSC9CQmgzY0tTS0I1cWFwOThOeVd3UzBZeHU4KzNFb29ZajBnb3BS?=
 =?utf-8?B?VWlaaEI1NmdzcFNGUExENGlqajhsNVRMaWllTU5OWGxIZjdPSmJiNDRSeFBU?=
 =?utf-8?B?ZVRDWlY1d0Nmais5UEFPM0VLbFhubnRtdWRCa0o5TzN2NXgzNFFXU0NXZEJs?=
 =?utf-8?B?QU42RXVFRllTbmNSNHFIVU5rVFBsNVA4ZTBubnl3SnJ2VVV1NjdGdTVySjVS?=
 =?utf-8?B?WUZpZkI1bUQ3MVl1b3ZZS2FJV2VINDdiaTFoa1hXYjRQWFlMS1hVVDdialdN?=
 =?utf-8?B?Umdac1huREVBUFdvOEtHYjhkaXJmL2IwNVdwN1VnNmVySlZ6blp6ZHRnTFlK?=
 =?utf-8?B?QVU5RDRzZHRDRjJJSEk3Z0xIUm9sWWsvNGNRWUE0MVJVbDhiWDNwT3JPUUg1?=
 =?utf-8?B?Ynh6Tm4xWnVLZ1E5NDBZVGlMVWdxaEJMMU9zbHowZ1UrejI4VUd2STArcnZZ?=
 =?utf-8?B?eWtSdVZLN3JQZXpFSDlldjFseDZ0S1dVZzBXMmhjR3U3WVMwK3d1TVgvU3c3?=
 =?utf-8?B?YWtBTldidFVvaG9lbE9TcDlXQTIvQTVQRXNXSHE5UXpEUWtjMGtYT1Fzcnl5?=
 =?utf-8?B?ckdnVEFhV0pkRSsyL3NPNzE3Y0c1cTJXS2YxR3MyU1Q3dW9SalEzYXhkK3lJ?=
 =?utf-8?B?NE1QWXJjRTJyWkYvNGIxL2FieThYV0NBQ3Q2bzRHMFVob3c5UnBTcUp0SkRC?=
 =?utf-8?B?eGJRSGY1Ry9WSittU0tqU0I5QjRsak8zblVKMGJHRDFTdm1QT3grL3QrMjBw?=
 =?utf-8?B?dkJqbVRXdE00NE1WN1FzUDZacy81K2dxOXEwWXoyUUFheCthYWtwbFltMjhu?=
 =?utf-8?B?K0srU3pYbjhjdWZ3L0N5TmlnWG53blhVeFR0RUJjU3ZJNDdKM2hXS1ZNMDVR?=
 =?utf-8?B?VVZLaFRGc2NQS2ludytuKzdnQlZOVWRLbE90c3JXU3NpczhPWFlUZ3BmYzBZ?=
 =?utf-8?B?MGJhUGZsSkhoOU1mSkZSaTNGUEVUV0Z3VkVaYVpZVFlCdnB3U2NaRVJjM2Jm?=
 =?utf-8?B?bkJpNzNkbEMwOVZKSkg5L3owclVVdFdLUGxCRWVLdmxpd1ZQT0drVWhGclpP?=
 =?utf-8?B?cHBKOEQvUmJseFh4elVkK1ZqVTJoOEE5WHZrN3hUaW5ZeXR0NFhrVlRFL2M3?=
 =?utf-8?Q?LT1UGlEdBvC+qnMvEkz3LjN6f?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da781924-5dde-458b-cf3d-08dced08f912
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 11:03:17.7185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkPdCRlpLFKI6APmCww2aNxRAgnVlXyHF4OJ/aDhrPuEa8S51wkIkFxw7KB7JOAH1X2JJezMbsDPJPrPqQxFww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8804
X-OriginatorOrg: intel.com

On 2024/10/14 23:49, Alex Williamson wrote:
> On Sat, 12 Oct 2024 21:49:05 +0800
> Yi Liu <yi.l.liu@intel.com> wrote:
> 
>> On 2024/10/1 20:11, Jason Gunthorpe wrote:
>>> On Mon, Sep 30, 2024 at 07:55:08AM +0000, Tian, Kevin wrote:
>>>    
>>>>> +struct vfio_device_pasid_attach_iommufd_pt {
>>>>> +	__u32	argsz;
>>>>> +	__u32	flags;
>>>>> +	__u32	pasid;
>>>>> +	__u32	pt_id;
>>>>> +};
>>>>> +
>>>>> +#define VFIO_DEVICE_PASID_ATTACH_IOMMUFD_PT	_IO(VFIO_TYPE,
>>>>> VFIO_BASE + 21)
>>>>
>>>> Not sure whether this was discussed before. Does it make sense
>>>> to reuse the existing VFIO_DEVICE_ATTACH_IOMMUFD_PT
>>>> by introducing a new pasid field and a new flag bit?
>>>
>>> Maybe? I don't have a strong feeling either way.
>>>
>>> There is somewhat less code if you reuse the ioctl at least
>>
>> I had a rough memory that I was suggested to add a separate ioctl for
>> PASID. Let's see Alex's opinion.
> 
> I don't recall any previous arguments for separate ioctls, but it seems
> to make a lot of sense to me to extend the existing ioctls with a flag
> to indicate pasid cscope and id.  Thanks,

thanks for the confirmation. How about the below?

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index bb1817bd4ff3..c78533bce3c6 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -162,21 +162,34 @@ void vfio_df_unbind_iommufd(struct vfio_device_file *df)
  int vfio_df_ioctl_attach_pt(struct vfio_device_file *df,
  			    struct vfio_device_attach_iommufd_pt __user *arg)
  {
-	struct vfio_device *device = df->device;
+	unsigned long minsz = offsetofend(
+			struct vfio_device_attach_iommufd_pt, pt_id);
  	struct vfio_device_attach_iommufd_pt attach;
-	unsigned long minsz;
+	struct vfio_device *device = df->device;
+	u32 user_size;
  	int ret;

-	minsz = offsetofend(struct vfio_device_attach_iommufd_pt, pt_id);
+	ret = get_user(user_size, (u32 __user *)arg);
+	if (ret)
+		return ret;

-	if (copy_from_user(&attach, arg, minsz))
-		return -EFAULT;
+	ret = copy_struct_from_user(&attach, sizeof(attach), arg, user_size);
+	if (ret)
+		return ret;

-	if (attach.argsz < minsz || attach.flags)
+	if (attach.argsz < minsz || attach.flags & (~VFIO_DEVICE_ATTACH_PASID))
  		return -EINVAL;

+	if ((attach.flags & VFIO_DEVICE_ATTACH_PASID) &&
+	    !device->ops->pasid_attach_ioas)
+		return -EOPNOTSUPP;
+
  	mutex_lock(&device->dev_set->lock);
-	ret = device->ops->attach_ioas(device, &attach.pt_id);
+	if (attach.flags & VFIO_DEVICE_ATTACH_PASID)
+		ret = device->ops->pasid_attach_ioas(device, attach.pasid,
+						     &attach.pt_id);
+	else
+		ret = device->ops->attach_ioas(device, &attach.pt_id);
  	if (ret)
  		goto out_unlock;

@@ -198,20 +211,33 @@ int vfio_df_ioctl_attach_pt(struct vfio_device_file *df,
  int vfio_df_ioctl_detach_pt(struct vfio_device_file *df,
  			    struct vfio_device_detach_iommufd_pt __user *arg)
  {
-	struct vfio_device *device = df->device;
+	unsigned long minsz =
+		offsetofend(struct vfio_device_detach_iommufd_pt, flags);
  	struct vfio_device_detach_iommufd_pt detach;
-	unsigned long minsz;
+	struct vfio_device *device = df->device;
+	u32 user_size;
+	int ret;

-	minsz = offsetofend(struct vfio_device_detach_iommufd_pt, flags);
+	ret = get_user(user_size, (u32 __user *)arg);
+	if (ret)
+		return ret;

-	if (copy_from_user(&detach, arg, minsz))
-		return -EFAULT;
+	ret = copy_struct_from_user(&detach, sizeof(detach), arg, user_size);
+	if (ret)
+		return ret;

-	if (detach.argsz < minsz || detach.flags)
+	if (detach.argsz < minsz || detach.flags & (~VFIO_DEVICE_DETACH_PASID))
  		return -EINVAL;

+	if ((detach.flags & VFIO_DEVICE_DETACH_PASID) &&
+	    !device->ops->pasid_detach_ioas)
+		return -EOPNOTSUPP;
+
  	mutex_lock(&device->dev_set->lock);
-	device->ops->detach_ioas(device);
+	if (detach.flags & VFIO_DEVICE_DETACH_PASID)
+		device->ops->pasid_detach_ioas(device, detach.pasid);
+	else
+		device->ops->detach_ioas(device);
  	mutex_unlock(&device->dev_set->lock);

  	return 0;
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 2b68e6cdf190..40b414e642f5 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -931,29 +931,34 @@ struct vfio_device_bind_iommufd {
   * VFIO_DEVICE_ATTACH_IOMMUFD_PT - _IOW(VFIO_TYPE, VFIO_BASE + 19,
   *					struct vfio_device_attach_iommufd_pt)
   * @argsz:	User filled size of this data.
- * @flags:	Must be 0.
+ * @flags:	Flags for attach.
   * @pt_id:	Input the target id which can represent an ioas or a hwpt
   *		allocated via iommufd subsystem.
   *		Output the input ioas id or the attached hwpt id which could
   *		be the specified hwpt itself or a hwpt automatically created
   *		for the specified ioas by kernel during the attachment.
+ * @pasid:	The pasid to be attached, only meaningful when
+ *		VFIO_DEVICE_ATTACH_PASID is set in @flags
   *
   * Associate the device with an address space within the bound iommufd.
   * Undo by VFIO_DEVICE_DETACH_IOMMUFD_PT or device fd close.  This is only
   * allowed on cdev fds.
   *
- * If a vfio device is currently attached to a valid hw_pagetable, without 
doing
- * a VFIO_DEVICE_DETACH_IOMMUFD_PT, a second VFIO_DEVICE_ATTACH_IOMMUFD_PT 
ioctl
- * passing in another hw_pagetable (hwpt) id is allowed. This action, also 
known
- * as a hw_pagetable replacement, will replace the device's currently attached
- * hw_pagetable with a new hw_pagetable corresponding to the given pt_id.
+ * If a vfio device or a pasid of this device is currently attached to a valid
+ * hw_pagetable (hwpt), without doing a VFIO_DEVICE_DETACH_IOMMUFD_PT, a 
second
+ * VFIO_DEVICE_ATTACH_IOMMUFD_PT ioctl passing in another hwpt id is allowed.
+ * This action, also known as a hw_pagetable replacement, will replace the
+ * currently attached hwpt of the device or the pasid of this device with 
a new
+ * hwpt corresponding to the given pt_id.
   *
   * Return: 0 on success, -errno on failure.
   */
  struct vfio_device_attach_iommufd_pt {
  	__u32	argsz;
  	__u32	flags;
+#define VFIO_DEVICE_ATTACH_PASID	(1 << 0)
  	__u32	pt_id;
+	__u32	pasid;
  };

  #define VFIO_DEVICE_ATTACH_IOMMUFD_PT		_IO(VFIO_TYPE, VFIO_BASE + 19)
@@ -962,17 +967,21 @@ struct vfio_device_attach_iommufd_pt {
   * VFIO_DEVICE_DETACH_IOMMUFD_PT - _IOW(VFIO_TYPE, VFIO_BASE + 20,
   *					struct vfio_device_detach_iommufd_pt)
   * @argsz:	User filled size of this data.
- * @flags:	Must be 0.
+ * @flags:	Flags for detach.
+ * @pasid:	The pasid to be detached, only meaningful when
+ *		VFIO_DEVICE_DETACH_PASID is set in @flags
   *
- * Remove the association of the device and its current associated address
- * space.  After it, the device should be in a blocking DMA state.  This 
is only
- * allowed on cdev fds.
+ * Remove the association of the device or a pasid of the device and its 
current
+ * associated address space.  After it, the device or the pasid should be in a
+ * blocking DMA state.  This is only allowed on cdev fds.
   *
   * Return: 0 on success, -errno on failure.
   */
  struct vfio_device_detach_iommufd_pt {
  	__u32	argsz;
  	__u32	flags;
+#define VFIO_DEVICE_DETACH_PASID	(1 << 0)
+	__u32	pasid;
  };

  #define VFIO_DEVICE_DETACH_IOMMUFD_PT		_IO(VFIO_TYPE, VFIO_BASE + 20)
-- 
2.34.1


-- 
Regards,
Yi Liu

