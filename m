Return-Path: <linux-kselftest+bounces-18343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D7B985721
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 12:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF551F24DA5
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 10:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747FB15B968;
	Wed, 25 Sep 2024 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWVvv/2p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C63980043;
	Wed, 25 Sep 2024 10:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727259956; cv=fail; b=hTwHSdPwMSpVS1k2z9G77vSHc6owxR76xCjl+nrE/ANBfa9MWmqX+/ccTvBLwZ+ygbP5FEboZlIN04URor+29Z00phjC9CpAfnQCJozpUssYuZ4rk6sxv3kMWRg3EuootjK/UvYAZrPXdvJ2qD5CudwBuPi3GBxumBGVMVBjb6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727259956; c=relaxed/simple;
	bh=E5vpxo8A73uqUR8+xx7DNpIGbVkZMZIFX4cSJoNdquc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WyIFkHjKB3Jn8WfOOxwZz5HD1FNadMAkzzUgjHGAUwrW/sBzNRcIBWD3PjsQz/LiAttkLNV5uA/lOyxXSTMRyEqXsBxi34T8sncRdRoWw1Hwj8nJ/LnQp23IHu+CYLXa5g5aBbRgq/Vn/HakTBSe7hgbw5cQs/FlfM7fAxXBTWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWVvv/2p; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727259953; x=1758795953;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E5vpxo8A73uqUR8+xx7DNpIGbVkZMZIFX4cSJoNdquc=;
  b=FWVvv/2pb1oLvu3WonvyJvg3K6M1FiHSyjkN6FeAk7oopsBtLDNe8NPv
   ikjLTPxgU9a1+OupySbe11fSQjorltq3ll2vLhxFvdlcKL6y5oNaLEum8
   938RKY2Ay6sacNQuMBlD21oJ7dkNUcv9+SBYn1dSgIj6ypUGVLG+1rY3w
   ghVNkTnU2GbOYBbXHscnnJwy7cBvPKtxYemRJTsOzcCJcVvmsokhvLRfY
   LRHxCfz+6r1tIlGU1N5bC+rGMjrWZJKYmhKuKS69IA7FLkpplL2hLPtRO
   YYu+ei2FBwNonjpEExVgRI5JizXtAzNWbvWvala4AyYM7eTIaqjAZOT0P
   A==;
X-CSE-ConnectionGUID: PQvXkUp7QamTh6Q7QxyF6g==
X-CSE-MsgGUID: C4b//AltTn+WOjYzdqFvPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="30089641"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="30089641"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 03:25:52 -0700
X-CSE-ConnectionGUID: 1duyPrEKQsWlhsr4gnbSbw==
X-CSE-MsgGUID: d5V9WavSQuug9wRpi1GF3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="76119995"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2024 03:25:52 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 03:25:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 03:25:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 25 Sep 2024 03:25:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 03:25:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evItyj65mdwPqtBl5SZsOWa/MPAmvmzncQgQ5YoqJKr/hT3ptA8vgDRejXeqUTXj9k21vdf3l/aifZqghWeZ6Fpy1MkiekdmoWcvekKzsj4f+ZpJMlgxcCIkgRdD/fbXTtuW0Mr04vE+CsUVeg4xM6gX1u+DZWzini9MMfVG5itxxLq6pBelbn06JawiEQYan85AVvorLgefhLB2zrqWrmHtfHh0zn/QW9+kBQXl3bsCe1T3d1YagvgJteFLpU8gQ0qVYjY9eMl/udI3DVEFPfpQh9xZX30yMUMtoJncDX7UAkiBq66BW98hICm56LdD0AKjbBFBh4mqYnwxWzyduQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHbCERkUiGq63MYIoq4GJWor3R6lvLJn95leaB06U6s=;
 b=yR6f111muHlUSTEs2TJ8FiI4rtTKSp7Xz5tw4NpO7hHO7ijiAv+wCq2l/vZ2fEETtWEEX7t7hTpPw5FYLPLW47fk8kta5RWudK0O3FSsnKYLJDx8CcSf0F2mjT1dMwi1Q9FdjxO4kDpyMAeGB8e//zZytoAk+C3DCIeL5o6jAW8tnBZnomsh6zEskv9i34ZdXuA27EVfsJWIdNbpXlLV+2k1Y/u3CV4SDaTUHOXUX51Oq63u192RRy+Gc/zzghlu2dq79KTz13n4AJ4u7Z57/qmmjm8Le/aPBwGNolE7idccKlcrQztuZPz+uW3ZEQQqHWm/TCEebCLvnvt4ReKNLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA0PR11MB7814.namprd11.prod.outlook.com (2603:10b6:208:408::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 10:25:49 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 10:25:48 +0000
Message-ID: <bf95f910-e837-4d79-8218-18d234ece730@intel.com>
Date: Wed, 25 Sep 2024 18:30:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/19] iommufd: Add VIOMMU infrastructure (Part-1)
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
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <cover.1724776335.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA0PR11MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: 814e4d84-cc9b-4fb8-fff9-08dcdd4c6c54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWV1bnpZQnJqM0MvNnlORzNFUlFhUlllbGl1ZEhXTzdxRlVvSVJIcTdnd3Bw?=
 =?utf-8?B?bWwxOE9UT3JmOHhUZWgyYVcxUEw2emovcWpvM0s4QkNsZXZaS3lxaU82Vk1X?=
 =?utf-8?B?WlZ5SkJtcWdIdHBiZDNOYnc3Q2RRa0VXbDREU3FyYW00VjBXWFVPZ3R5Wkda?=
 =?utf-8?B?U3lKZVdpdy9SeTFRU096U0IyUjFhUy9YazdIS2VwY01xdWVDZjhnbHdCSXZu?=
 =?utf-8?B?RFdsc2ErVnpjWnl2SXp3MzVHM2l3WkZUSG4xZ1VzeG52VVpiQzk5V3BJTFU1?=
 =?utf-8?B?MEFhY1puQUVXWlVWVDBBUUYvbDh5R2ozeitBR05SZktoOWhqWFBKWkRqSHBL?=
 =?utf-8?B?eElQRDV0YjZMNjJoN0F0TFdqbDJPeXFPYTNZV3JZdllBRnExUlptQ3NyTUZF?=
 =?utf-8?B?dGZpSUQ2U1BNTHNCTm5aY3NYSjBuTENFUUpkUlFLZlFpMlUyYUxKUkZoWWlo?=
 =?utf-8?B?WWxTVnJVUm83aHBmdGJlS1hQenpGWGZtZkVmWHZKN1QvMzMxSVVKNVMvNkNS?=
 =?utf-8?B?NUhkczZhUUc0aDZKT2NrcG4zM3N2UHZDUERwdUcvci9YTk9vZWlOM3RGWmF5?=
 =?utf-8?B?UmJubVNXbktZODZXekRvaDZVeUJXRFhFUWVQbTBydzQ3WGZ4VXBXNmZqM2Qw?=
 =?utf-8?B?dXhQb3R0d0VMVEhpaldaSUphOVNDWU9OTkVpSFNwTDV1MWJJTHBlYXRYS0tF?=
 =?utf-8?B?RVNrN1grbklZK0YyS0J6NThIam8vWkQyWXJ3RVNHdzB3OEFWSTY5NmRhaTZ1?=
 =?utf-8?B?SFpYcy82RWZHYXJkZjFjRFFTaHVKaFowamp0cnZWSWlyV0xVeHl3N3Fxb0lJ?=
 =?utf-8?B?VjhRNXZ0VHVrTmVRSVlpZkVZcW9nbXU0RDV2NU52T0tJaldnZ2I1alUvRU1x?=
 =?utf-8?B?TTNpd0JEZmtYZ01OLzdpeDZ2OGM2WWlEclVvS2NBRFRtZHRGMFpVcDlMWEp1?=
 =?utf-8?B?S2R5eS9GRUg3a1E4c2xwRmpVQ1pMU2VtdEZ0dkY0R1pGZC9YbHBtTmhzRW9x?=
 =?utf-8?B?QTloZE9tQnArSjZnSDYyVHV3M0F5QmFpaHZrZmVVbE4ra0xHelZUVWZRQmFK?=
 =?utf-8?B?RnQ0U3dwYWtKTTB1WmMwNTBUbzdTQ1NCeWx6amZYZWx4WWV5ZStNeXVGUWRW?=
 =?utf-8?B?bFlCOGtobG1jblprTWRkeVl2QzFSV1k5MGd3M3JxcGNOdzVmTnR5UWVuaSsv?=
 =?utf-8?B?ekN3Vmo0SHA3RzloQ3BkeVVCSHRFc0RMVk15NklxbDB3SGZtSHJPT2s4dThE?=
 =?utf-8?B?QXlBc0I4RVlCL3M1SDlURjVlMVBsWEJELy90dEU1SWJYaGswVDl2eGFTWE9I?=
 =?utf-8?B?MzBLejNjMitHdmVhQkhNQVhSdCtnSm9rOWptVnpCSzJSUHEzUjQreTB6Mk1i?=
 =?utf-8?B?VXl0VjVOS0paZ3c5OVBOWklOWEZKeVpFUm1YQ0VIaEJuV3FZNmlxMzJYR1FE?=
 =?utf-8?B?MDk5MUNjbXBtUG9UKzlrN1hnMVBxbXFOOEJkNGJJenFzNkNhOCtIS1FTVWQv?=
 =?utf-8?B?RXdkSnBleDEvSnhFZXRBRHJINWk4UGJ0cWwzaFg3ZXlmUVdOSnJlaS91QTJE?=
 =?utf-8?B?eHEvajNIY0tucXhkNUU2ZElxeGs0a3FMMFdsakJReGJ1akVFUnJobldNQ1hB?=
 =?utf-8?B?bzlnTVNNdHBOMW00cG9maHdhTHZESXBvT21vOVNINy9CdGd3S1dsOXlncHNm?=
 =?utf-8?B?RmF0YThJR2JGOUpDMnRQRTRnaXo5ZUIvd3pidHJ2MkJyMGxnZFp6d2lSRnZM?=
 =?utf-8?B?bXBvYkZ4TGtvQ1NMaklPK0o5N29ZdUJKbStyOUYwRVFobkYxcmNzODFLaVJr?=
 =?utf-8?Q?ucWTVlEZL1sIMu2eyGWTgJDFpzfq3ZzITFMz8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUVKZWY2cE1laktuVithcG9TYjdhYTZkREVCa2dFNzZkQTdHM0xkMHU4QnFs?=
 =?utf-8?B?bEk5RlpjQkdKRGZMSG9VSXpQcnA3ZC9iRE5NMUE3ODhuTTAyK29Td1RTQlJm?=
 =?utf-8?B?ZTZiRVdobHF5T2twdjdmaEptS3dqa1NITXBmOTJ6Z21oc1ZhOWl3VGJPUURH?=
 =?utf-8?B?QVVnWmFWYnM5UWVUb2pWRHpYTTMxcHVsY2JXZ1QwVXJrNG0vbUs2a2hIT1Vo?=
 =?utf-8?B?amdUNk1BRm5TcWtKYThSOFZOT2R3LzBmUmZ2NlI1a2xRTjlEWTl3cXRscFpw?=
 =?utf-8?B?UUpQSmNsU2w1RjFTYXdQeXY4WGFCdDVYUlVxUHhGYzRRYWlGNk4vdTNJWUda?=
 =?utf-8?B?ajN1YW55Z05YUXRLVEVBSmR0NUhPQzhSQ2tmcmo2Z0tQUWdnNUY5bW9KVGhT?=
 =?utf-8?B?bEM0UmhqTGUrL01DbVNNbzhkSU9TZDNabW5KWUQxWDNrQStYL3pNa0FHY2xH?=
 =?utf-8?B?UzUydWlXWDBJYmZpNVJwc3BIaG1KMWE2WWVDR1FLR1d4NlB2N1RHZjI1V1pw?=
 =?utf-8?B?cFRYc2REVFN0VDVWUi81bHF5QXN4Y3pJUlY1N0FUOVNNZlhwU3lqY1FMby9Z?=
 =?utf-8?B?VEdUOTc2TTh1Z3FwcEZORTA1YzVTcE5kR3p5bFJuYjA2QjRpSld6UlNhOXA0?=
 =?utf-8?B?Uk51bEc3N3ovSjgxd1dwTHBJdllmbnl5S1lTbzhLdnByd0FVanJzZkdoT2tO?=
 =?utf-8?B?aUtTT3hhZFdMek8wbXJKenU5aTBKbUFKN1VLTUc3YkNzbWVoWDZXK0p2ZHQx?=
 =?utf-8?B?T1NrUm02aVFWZ1d1eERtUnFtWE0ya3ErbVc0TnRtODFpSEkwMTNrYVVXRll2?=
 =?utf-8?B?ZXowc05vQnFwZ3BZV2RDMjlDZFlMVnloR1J3YTBkTGJ6dU8zZ1R0UDd4c1B1?=
 =?utf-8?B?bDhQOGxQNkF2dCtXdDl4dnFCVGhBM1FZMVJPeWRKbEJra1gyR2kwMVU4dENx?=
 =?utf-8?B?bGhJdllqOTMwZWFJMHNDdUxCcE9uU29EVlk0dC8vc1FzRFRUYVFqNnRNSU95?=
 =?utf-8?B?RnFlU3VOQTQzaEJZQWxZWlNwZ2kyRGIycGR5VlZTZXdFbzdhcDBPcDZXZExX?=
 =?utf-8?B?N0M0OVdaUXErSEI2Z2czSHB2Y1hJMGsvZlF6THEwOGlJa1dKNzhJTk1LM2xZ?=
 =?utf-8?B?M0NQTU4rYUc5dStVYzd6eXozZ0dpdVgrVVNCTDRSa25WZVNreVd6S3Y3c0tL?=
 =?utf-8?B?STN1NVhHMXJaZ2svSWJNc2Z3MVhrRDdjeGV3Wmp4cmZ0bXY2N21OQnJ0MERn?=
 =?utf-8?B?dUJJSHpON2VlNjVJVFFjNjlFRmNiMkRvU1p0ZHFYZmk5LytjaW9LdlQ0N2NJ?=
 =?utf-8?B?dW9DVTR2bjZXbXVIVE9TQU5QRjNvajRsc1FTcEhYQm1QYjFYbjVQR2c0N3I4?=
 =?utf-8?B?RjZFcWdScTJvMFVFdS94dllUbmVDSWt5MC9ZK0l1bjdkNkt1L1NwdlYzcVZz?=
 =?utf-8?B?eHBuL0ZLU3IwL2VzOFpOOGNUcHZiSXBtU3FVRGNNdklGcG1zZ0FMN01yS3h3?=
 =?utf-8?B?ZXFwZk0veTlaRWNUb0MyM2tmWlBhUUtRM0dMMHFQdzZYRmE1TE9XRkJMUW1F?=
 =?utf-8?B?cmlPaGZsVjF1NkZhRmxmcmZYUVlrU0FKQWFkL281THV2Y2NSdVdsbFJaRm1J?=
 =?utf-8?B?REIxYWV6QW5GaWdrQXUxVFh0bFJCalNoUlBVZ0JKZGpJZ0JlQjBrNEpUcGJq?=
 =?utf-8?B?b1Q0M25peExqTGhXbjJMckpGMzZwak5UZFovckVnQzhmUWVudHhkM3pRSW9p?=
 =?utf-8?B?S01uZmR6c1lycWxmYmxueVBEcDZ4eVZOTzhFdDRrWGhNWlFmRE1pbjdwR1l1?=
 =?utf-8?B?NkMvWkNpVmtaU2gwam52Y0dBZUZMS2dQSUJ4cnJHcERlVEFHVWdTSWVwRWFy?=
 =?utf-8?B?ZlVkSXI0TzQ4UHBGaGdnaHZHMkxkMXBRSnpha2FNcXVMd3Z6dStqTWcwU2xr?=
 =?utf-8?B?Zyt4VlFXT0s4aTdmMllJcStZNmJIc3Zxc1NHOEN4akpZS29HN1pzcExGSkJz?=
 =?utf-8?B?NW5xY212K0lyV3F0N2JyNmE4a09QcmpvRlNWc1hIV291ekthNTFDNTlBeDd0?=
 =?utf-8?B?VW4zOVZDcnoyNm5icWtjUHpTTEUrRVB5R0k0QUwrTUg1cTVLcjB4MzUwNEVZ?=
 =?utf-8?Q?hCGZBK9jgbugB0TfoYtuMYrG6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 814e4d84-cc9b-4fb8-fff9-08dcdd4c6c54
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 10:25:48.7458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3AyDzSgykVwVeHIegDCVJcTSVRlOk3cu8oaXQPN0eV3qvTJXc5IBpkrMfO6lEFfDTFXqw4q1UYGLMcCiSLPK5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7814
X-OriginatorOrg: intel.com

Hi Nic,

On 2024/8/28 00:59, Nicolin Chen wrote:
> This series introduces a new VIOMMU infrastructure and related ioctls.
> 
> IOMMUFD has been using the HWPT infrastructure for all cases, including a
> nested IO page table support. Yet, there're limitations for an HWPT-based
> structure to support some advanced HW-accelerated features, such as CMDQV
> on NVIDIA Grace, and HW-accelerated vIOMMU on AMD. Even for a multi-IOMMU
> environment, it is not straightforward for nested HWPTs to share the same
> parent HWPT (stage-2 IO pagetable), with the HWPT infrastructure alone.

could you elaborate a bit for the last sentence in the above paragraph?

> 
> The new VIOMMU object is an additional layer, between the nested HWPT and
> its parent HWPT, to give to both the IOMMUFD core and an IOMMU driver an
> additional structure to support HW-accelerated feature:
>                       ----------------------------
>   ----------------    |         |  paging_hwpt0  |
>   | hwpt_nested0 |--->| viommu0 ------------------
>   ----------------    |         | HW-accel feats |
>                       ----------------------------
> 
> On a multi-IOMMU system, the VIOMMU object can be instanced to the number
> of vIOMMUs in a guest VM, while holding the same parent HWPT to share the
> stage-2 IO pagetable. Each VIOMMU then just need to only allocate its own
> VMID to attach the shared stage-2 IO pagetable to the physical IOMMU:
>                       ----------------------------
>   ----------------    |         |  paging_hwpt0  |
>   | hwpt_nested0 |--->| viommu0 ------------------
>   ----------------    |         |     VMID0      |
>                       ----------------------------
>                       ----------------------------
>   ----------------    |         |  paging_hwpt0  |
>   | hwpt_nested1 |--->| viommu1 ------------------
>   ----------------    |         |     VMID1      |
>                       ----------------------------
> 
> As an initial part-1, add ioctls to support a VIOMMU-based invalidation:
>      IOMMUFD_CMD_VIOMMU_ALLOC to allocate a VIOMMU object
>      IOMMUFD_CMD_VIOMMU_SET/UNSET_VDEV_ID to set/clear device's virtual ID
>      (Resue IOMMUFD_CMD_HWPT_INVALIDATE for a VIOMMU object to flush cache
>       by a given driver data)
> 
> Worth noting that the VDEV_ID is for a per-VIOMMU device list for drivers
> to look up the device's physical instance from its virtual ID in a VM. It
> is essential for a VIOMMU-based invalidation where the request contains a
> device's virtual ID for its device cache flush, e.g. ATC invalidation.
> 
> As for the implementation of the series, add an IOMMU_VIOMMU_TYPE_DEFAULT
> type for a core-allocated-core-managed VIOMMU object, allowing drivers to
> simply hook a default viommu ops for viommu-based invalidation alone. And
> provide some viommu helpers to drivers for VDEV_ID translation and parent
> domain lookup. Add VIOMMU invalidation support to ARM SMMUv3 driver for a
> real world use case. This adds supports of arm-smmuv-v3's CMDQ_OP_ATC_INV
> and CMDQ_OP_CFGI_CD/ALL commands, supplementing HWPT-based invalidations.
> 
> In the future, drivers will also be able to choose a driver-managed type
> to hold its own structure by adding a new type to enum iommu_viommu_type.
> More VIOMMU-based structures and ioctls will be introduced in part-2/3 to
> support a driver-managed VIOMMU, e.g. VQUEUE object for a HW accelerated
> queue, VIRQ (or VEVENT) object for IRQ injections. Although we repurposed
> the VIOMMU object from an earlier RFC discussion, for a referece:
> https://lore.kernel.org/all/cover.1712978212.git.nicolinc@nvidia.com/
> 
> This series is on Github:
> https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p1-v2
> Paring QEMU branch for testing:
> https://github.com/nicolinc/qemu/commits/wip/for_iommufd_viommu_p1-v2
> 
> Changelog
> v2
>   * Limited vdev_id to one per idev
>   * Added a rw_sem to protect the vdev_id list
>   * Reworked driver-level APIs with proper lockings
>   * Added a new viommu_api file for IOMMUFD_DRIVER config
>   * Dropped useless iommu_dev point from the viommu structure
>   * Added missing index numnbers to new types in the uAPI header
>   * Dropped IOMMU_VIOMMU_INVALIDATE uAPI; Instead, reuse the HWPT one
>   * Reworked mock_viommu_cache_invalidate() using the new iommu helper
>   * Reordered details of set/unset_vdev_id handlers for proper lockings
>   * Added arm_smmu_cache_invalidate_user patch from Jason's nesting series
> v1
>   https://lore.kernel.org/all/cover.1723061377.git.nicolinc@nvidia.com/
> 
> Thanks!
> Nicolin
> 
> Jason Gunthorpe (3):
>    iommu: Add iommu_copy_struct_from_full_user_array helper
>    iommu/arm-smmu-v3: Allow ATS for IOMMU_DOMAIN_NESTED
>    iommu/arm-smmu-v3: Update comments about ATS and bypass
> 
> Nicolin Chen (16):
>    iommufd: Reorder struct forward declarations
>    iommufd/viommu: Add IOMMUFD_OBJ_VIOMMU and IOMMU_VIOMMU_ALLOC ioctl
>    iommu: Pass in a viommu pointer to domain_alloc_user op
>    iommufd: Allow pt_id to carry viommu_id for IOMMU_HWPT_ALLOC
>    iommufd/selftest: Add IOMMU_VIOMMU_ALLOC test coverage
>    iommufd/viommu: Add IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
>    iommufd/selftest: Add IOMMU_VIOMMU_SET/UNSET_VDEV_ID test coverage
>    iommufd/viommu: Add cache_invalidate for IOMMU_VIOMMU_TYPE_DEFAULT
>    iommufd: Allow hwpt_id to carry viommu_id for IOMMU_HWPT_INVALIDATE
>    iommufd/viommu: Add vdev_id helpers for IOMMU drivers
>    iommufd/selftest: Add mock_viommu_invalidate_user op
>    iommufd/selftest: Add IOMMU_TEST_OP_DEV_CHECK_CACHE test command
>    iommufd/selftest: Add VIOMMU coverage for IOMMU_HWPT_INVALIDATE ioctl
>    iommufd/viommu: Add iommufd_viommu_to_parent_domain helper
>    iommu/arm-smmu-v3: Add arm_smmu_cache_invalidate_user
>    iommu/arm-smmu-v3: Add arm_smmu_viommu_cache_invalidate
> 
>   drivers/iommu/amd/iommu.c                     |   1 +
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 218 ++++++++++++++-
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   3 +
>   drivers/iommu/intel/iommu.c                   |   1 +
>   drivers/iommu/iommufd/Makefile                |   5 +-
>   drivers/iommu/iommufd/device.c                |  12 +
>   drivers/iommu/iommufd/hw_pagetable.c          |  59 +++-
>   drivers/iommu/iommufd/iommufd_private.h       |  37 +++
>   drivers/iommu/iommufd/iommufd_test.h          |  30 ++
>   drivers/iommu/iommufd/main.c                  |  12 +
>   drivers/iommu/iommufd/selftest.c              | 101 ++++++-
>   drivers/iommu/iommufd/viommu.c                | 196 +++++++++++++
>   drivers/iommu/iommufd/viommu_api.c            |  53 ++++
>   include/linux/iommu.h                         |  56 +++-
>   include/linux/iommufd.h                       |  51 +++-
>   include/uapi/linux/iommufd.h                  | 117 +++++++-
>   tools/testing/selftests/iommu/iommufd.c       | 259 +++++++++++++++++-
>   tools/testing/selftests/iommu/iommufd_utils.h | 126 +++++++++
>   18 files changed, 1299 insertions(+), 38 deletions(-)
>   create mode 100644 drivers/iommu/iommufd/viommu.c
>   create mode 100644 drivers/iommu/iommufd/viommu_api.c
> 

-- 
Regards,
Yi Liu

