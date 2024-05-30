Return-Path: <linux-kselftest+bounces-10969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650E48D5604
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 01:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889621C20B97
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 23:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECB818509C;
	Thu, 30 May 2024 23:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hnuFAnx2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9624186282;
	Thu, 30 May 2024 23:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717110463; cv=fail; b=FVVNezKcd4h1e605yb6dF6uQQXLaeDAFtCnvkAkKx1HuwdZzY+UfvXxWFAMwwLCNLVAfLJgoyhjm+1+TLPLWXjuXRoAyE/L2rkwVAA8TDnFLot3ALU/94kNO4WQcs8aed1GNb833GtMHBh3P8zY67MKFj0X8FMO7SpkQkjI8SxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717110463; c=relaxed/simple;
	bh=6V6jSMBj9iiCHKoaDBTBw5hFxk6BhpXaUdgEXeflLcI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O7SSGtz7txYaMFljE4CN71k5xYDxFAcTlW6mEV1DnnCSKz8RqxhKbZZG73ztsQGo+p6ktDtyF1kPOwO7i/cr4gibXACwKw7P4uju++PIqK18ruL8Kw5FbcgT443enm6HVV1yipw+mLliANf12DlePfUEevXFfOCMHnArW+snOZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hnuFAnx2; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717110462; x=1748646462;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6V6jSMBj9iiCHKoaDBTBw5hFxk6BhpXaUdgEXeflLcI=;
  b=hnuFAnx21BNwfR5CAFnua9r+QycxySZymeXnKcmADc/lBh5a2+PPyK1+
   RW2wdUYdGom6Q9pzLGJM8/cXpk88HVtGJSRZG/DCaoAyeOaHzT3q+NFem
   lPApJLid1YIhtz5CqoGEhRoTgdOr2MSV7rGP4vLKl7ZU1hDggWjvVjcP/
   RAzBncJS2nGSmWfdI/pXT9Sg5fcuYn1EM7Gu/7MIwoxqU8LCK2r+wvRRA
   OS7oSfIv9JfGR8VBebK1YBDSgExOvh0iaXeQr0n8BcncHwyPEr/B94OKs
   j9JydAALTYsmL9gS62J4Y9QIgusDfH5vqL16g2+XTP3eMv2tYe2xIL+ng
   A==;
X-CSE-ConnectionGUID: K5WpYo5kTTK2x9OVzgy9RA==
X-CSE-MsgGUID: C9nqFLE+RMy0CeZ7AA6rbA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="16584032"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="16584032"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 16:07:40 -0700
X-CSE-ConnectionGUID: xjQiL0gaS1GidpSYgxM0rg==
X-CSE-MsgGUID: PlGArqMJQPqTEaU3ndL/kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="35904945"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 16:07:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 16:07:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 16:07:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 16:07:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCygKoiDItgS7c7Q8tY+ONt6VAGPkmPt5of0z0trAc4jze5ioOcEEBYnbBl7OVOuAtVmvOdwYEAz0T6ec3ZSM/Xk/G2beRXrPFzhqhb478W2P90KkgTKs5cUOaorAX8AjmSXKxPSvHd0yrCzUd4CQGmlpp3vWBjQskmU45E1oPj6wKgtpbuuzYhnR2TPDuP6/Vek1nrQ1pug/e1CCwvQTJ2+qIbRioNobLW1UQI507svzUaToyuHGN46u16fI/degaRhxsZaWo9uQ21dpxwp3x209fzwX0Ezfsj7touKfEPli/aDP8C9SQWqQLteYs2UOpQDF9i40eJ5UN8ndlvt8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3H5/XPxRRkSjNAU2Hi7CYMJ3vxEZlBGsJ4wSensHOJg=;
 b=e4+fSKJ2ccDbho7OR8oSO0/ygQ8fIvc4e0hKR+ZscyGiCkIZ4hR1AXyxRR4Y0XsBK+KedUHfHo7+OtvBPhVlJVpZ/2gzU4JbxBHMyORc0xE8FZUd4nJhYaKJCRNhZMIP0osEBm5soPPqD3IZ0uLn2wErioK5NPrJ+NmfwUowxG52cmEnAeVqvcdUKBRin5LCxP+bwjuz42m7r6YrWe6vpSNVHBgo6myJlaeBmoJA29KM9uk654NBUQLuddi4RdvhJfl1XTFmCuSuc7FEqeuuvZNzUsCdllvnhRPLOkurTvpvzxILxO4XUCgpwlUKoSUzc+TVe5FAjOC9rLzWtm5rfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB7833.namprd11.prod.outlook.com (2603:10b6:8:ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 30 May
 2024 23:07:35 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Thu, 30 May 2024
 23:07:35 +0000
Message-ID: <d8396d97-5000-4ffb-aaba-e71de5d6d909@intel.com>
Date: Thu, 30 May 2024 16:07:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] selftests/resctrl: Adjust SNC support messages
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<fenghua.yu@intel.com>, <shuah@kernel.org>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
References: <cover.1715769576.git.maciej.wieczor-retman@intel.com>
 <16764746e8f9f42cbd45d61210764a9b67085cbf.1715769576.git.maciej.wieczor-retman@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <16764746e8f9f42cbd45d61210764a9b67085cbf.1715769576.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:303:dc::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd6609e-5015-4bf7-7861-08dc80fd4b05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0JmSTBwMUtvRFU1bFFHZ3Z2VHY2MXRVWm1WdUJsclQwa1ExYVpldjJjbngr?=
 =?utf-8?B?NFJOMkVhcktEc2Y1ckhJQzRVVWFxWDQzSkxkblVXSk0wa3VlMGxqSHJoZVFQ?=
 =?utf-8?B?b2p4d2xMUnJlWmJmYmhmU3lacnRIdVBHMXA5ZHg3L3UwZmtrT0pwekp5Ti9k?=
 =?utf-8?B?dlhFN3BSL24zaWNVa3pvS0JZeWxNQjF5TDJBUC9wL1laMGVkWktwVDFGU3hK?=
 =?utf-8?B?eW1GNyt0MDF3ZGNxY2VDNjhIZUNleS8zV3U4Z255ZjRoNXZOQzd5NERvZ0M2?=
 =?utf-8?B?aXBRMlVpOVkzVmM2c0JXTGlGMkVmZmUybTZySVd3d25xYmdqeC83b3pnd0Z0?=
 =?utf-8?B?ZEZOWlhVRkQzZDRKc2RLaG1ZWlVEY2Q1L2lpQWc0MGgvQkNvMGVnSFhGeGRr?=
 =?utf-8?B?RS80a3lPZzdlRk4xdmt6RXNNYzdpQjU0dFh4eEpGYlI2V0ZUZU9yNFA0YzdQ?=
 =?utf-8?B?Vk5kMFVBZ2NtM2VDN080aDNRN1B3QjcrRVhCeDZqVTNiNlNxQ2lUc2dPdTFG?=
 =?utf-8?B?VnZKMVI5eDR1Z0s5OEFkb0M4eTRmUjljQzBST3NScnNxTERxazBjOXJzRUdT?=
 =?utf-8?B?QnBXYlZNYmVsY2tya0tYdlBHWFZtbGF1cHJJS1FmcGtyQmdKVTRCWFFXMExY?=
 =?utf-8?B?KzhXUHQ0eTBSUlNlbUdSaEllYU9rdi9iSFVKczRNREhESWRsUFJEaGhIS2tM?=
 =?utf-8?B?TG05ZlhFazhCc3l6VnhSN2R4bmoyWUJQTG5IQUpzb3hDWVV6S3g2Z0E1UlBv?=
 =?utf-8?B?SXMrUXVhUFlmRzZlM1BYdDFKUVhtWXRCOTZKTEZWbmtnR1BkZ2oySk9vdTds?=
 =?utf-8?B?dDloSGFxOWVQMzRKcEUyZ3YvSHZVS3N2ODMvSmJRN1oyVWluVS90TFk2dGw4?=
 =?utf-8?B?TzFQczJRc2hjZGdKZHBhMnFkNlIrWU9mV2ppbGY3WlA1bVJSbFE1dm5mbkNY?=
 =?utf-8?B?dy9oS0l3aHdKMk4wejQwRFk3NGdiN25rSFNrYyt0R05NNE5kc2cxeDhXTXlO?=
 =?utf-8?B?UHRZSlZxZGM0aVpIRUFQTTR6OTdMRFVJYlBqZWtqczJWQWVGMVVrWENnc3BN?=
 =?utf-8?B?MS9QWEZEYnNQUC9BT2NtMmtDNWtZWW9tamxUS1BKQmNDRitzV1I0SCtlZkdz?=
 =?utf-8?B?ek43UVYxbzlaMTN5ZmJIN2N0dnlhaElvZkNGbHB4c2kwTlJNRE9CWm5VOVI2?=
 =?utf-8?B?MWZpTlBuTENZQ0RpMkpML0pRdE8xNndLSlE2RzlaRURjSDJ2N00zMzdzRldt?=
 =?utf-8?B?emVGTTNzVzlwNmdhTHdmN1Axa1puOUYvQmlWU0lvVGFxdlB1MFFtVHZuTGZa?=
 =?utf-8?B?ZVRhU0lkWjN4WUtOcDUvdXF2N3kwMGZNME8zZ0JlbDFhQVVwUDhMV2U5dHFr?=
 =?utf-8?B?QjVpcnJnV014eWFVM2t0all2VUtHTHhvN2x0elZpMTVQY2M5L1Vka3ZWZHBp?=
 =?utf-8?B?d2lGcStteHA1cFJ6bDdQWlF1TkdWRVJmTW1maFBlM2VuYit5SUd0RVFyRk9y?=
 =?utf-8?B?TGRCemw2SXBSeEdNRW1DbHNTVTBXNFNkMTYyNWFEU2creTh4MDArVlV5ZC9J?=
 =?utf-8?B?RE94OUNIdGlFNXc0ZG5IcWprTkg3QTBWdGZZNnAwZldEalJsYkFSenRjYUx0?=
 =?utf-8?Q?CPF2iTBvDFKcDMADyBl1r7Fz+Mp0HNoD3iXhopS3vozw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGpYdWFDVldpMG95anFocjFYVFFVeUE3TTRkZ2hDS3NLOGhoSldkcldGTStm?=
 =?utf-8?B?ZEFXVEdzbjdXKzlYbkhoYjdDWFVJZHpjdU9oak5ES21VQnN5bG8xUks5alJs?=
 =?utf-8?B?aHUyeWltK1ZiY2F4a3ZlTHIxKzFnS2hIT0xnME5ZbUE1NDQxTFdrN0dya3lC?=
 =?utf-8?B?UkIxT0NETG52RHAva1Z4a0FERnN1bEJxN3RZakhENU04bzZ0STFXemI3OWpv?=
 =?utf-8?B?NVdtWENkUEVuLzFKSlhkZzVSbWM1MHVXRUtxVE0ydXh2cldyVDZDUzJ6cWlo?=
 =?utf-8?B?WGVvNW9xNi9aY3ZkWVV6aExkNFpybFRIZHh4dGZiVkZrdDk5MkVxUUxMSTdM?=
 =?utf-8?B?M0JweDZCYjZMVkx4enNOU080MHJIQlBoeExEbHJLci95Z1p1WDExOTZWQjdP?=
 =?utf-8?B?a3A2aGwxczhQUVo5WDQ5VWE4enl6YjdsQTNKN3UrVnJZM3MyUG5JTksvVTF6?=
 =?utf-8?B?RnA2bTd0MkwxaFdGNS9FNGlTcEJReW9zTGxmcnRodzEwQStYTmNKOC9VdWRM?=
 =?utf-8?B?clNOcjlteUE2enRaQVQvc2d1SnJEQzFDL0VBSmUzbDR5OTJJeDF3d3VSS3pw?=
 =?utf-8?B?Um5YNkJxS1gxSERYUEMrUTUyNTBLZndTQ1Zmd2xoTCtCY1Yvdm5SRExsc1V1?=
 =?utf-8?B?YkgycTRPWExUU1QvRTRXeTZ2bkpLZjhqOVZXb1ZrSlczTThqZm1EWkJ1L3U5?=
 =?utf-8?B?K2g3dittUmpBWTVaN25TTnhEeGowODNjUUNoVnpGdEhueHQ3WXR5bGhrN0Jr?=
 =?utf-8?B?M3NnaVMzNlRleHBWa0lXcVYzaEg5UEEwbjBjVUNTRUl1VXV6Y0h2SDgwaGNs?=
 =?utf-8?B?L05aR3RyNGoveHkvYkc2OTlJWmlyM3NtODRtTVNHS3NBTkIweDBySkF5RVlZ?=
 =?utf-8?B?NkQ2aDcyYmhIeEk0d09QYnMvRFZucENDZ1BacmsrQlBUZDlKS3pXbVkyZE1S?=
 =?utf-8?B?a0cwbndWS2t0WmwxU2NZRG9VbGROTGIrdmtLVnpPMGJ1TE5meGVRYWpBSHhM?=
 =?utf-8?B?VWpCSGVEcWdOVUt6OHZrUUpFVmxPU1NsZ1lNTlBYZVFxMTBQenFhWldjOENx?=
 =?utf-8?B?UDJzOERUY005Tm5oS3pnTnVYWTlRZElFTUUyRytCU2RiWHk1ckgxMDZtdVhT?=
 =?utf-8?B?VlkxUU9Hb1JTUWhiTUI2ZlpmNk9XeHJHT2YxNnFVd3hhVU1od24vV1dnZno2?=
 =?utf-8?B?TWRCNU43emU3TVB6WlJuY0QwQVdITi9seFowcUg3OWd6eFVabjF3czRwdHZ0?=
 =?utf-8?B?bUpSdGViZ1lGVHVGMk11NXVhYW5rQWhVaGRZdTNCc3VBc1BsUWc2ZG8rcDVW?=
 =?utf-8?B?VmptVlNUbjB4QlFPZkZ5Zk5McmUrOWVqVDVQTVJHU09tWldqVmh2dDVDb1VW?=
 =?utf-8?B?NGRLNmFGbmREdUFjMjJYYlVUZDlqR2FjTmpyVzY4VWdIRHRwUEg3NE9VNEFE?=
 =?utf-8?B?ODh0Qm12bkZxRmQ0Z1FicnJkWUViOTl3SjlDSXIzUlE5Tk5Bek1hQllsN0RO?=
 =?utf-8?B?VHZnWEN0U2ZVOFpFYjlIVkQ0N0FvcmVQNStjVWNBTTAreGVObk8rLzJES2pr?=
 =?utf-8?B?bHVyTVBUdEt2M2YwMHh6bThldGYwTmYrMFR0dDZqSW8wd3hiUTIyMEordVdO?=
 =?utf-8?B?YzJrK0pBclNSWkk1aytxd0l0NDcvRjhLNk9qN0c0a3p3VnBHclovWWxDYkFk?=
 =?utf-8?B?dnBzSVZWVmRPTWN1c3UxQ1lXY3RuMElZTStraGdZVVpFOXdaaHFzSlVreVYz?=
 =?utf-8?B?UEIvY1FTRldsRTk5Yyt6cE5rOVJTM1RHS25qTTdiNndkeE8veFBWQXpYUU5U?=
 =?utf-8?B?QVd5VWg3K3lTbU83K24rYzRUd3EvYmN1VXhDVDFmbXVscmxuK2hWejdLRFpj?=
 =?utf-8?B?T3lKTEVrbmtXdzBjOWc3NTFTMFd5QnRSVWpIWTFkTHRsajZlVGxIRzYyQytX?=
 =?utf-8?B?SGNIeE1HTVkrUmFSbWIrZitHSGdiSVVlbEVscW90N254RUpZem9LV1ROeTgz?=
 =?utf-8?B?bjg1UUF6MFMvWm05QmFTNFhIY1VONmhWM3VKdEszUXJoNGszMG9pQzd5UzFj?=
 =?utf-8?B?TkJqNUYzbWMyQVp0anVJN0RiVkFORUtwVHhveTRzc2RYZFQ2MXZodXRqdmox?=
 =?utf-8?B?bW5EU3BhMEdDZVk0UHRzaFl2NFZYMEp2VU5iMUExZnA3UGtTT1M0ZHNPRk55?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd6609e-5015-4bf7-7861-08dc80fd4b05
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 23:07:35.5352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9xyWej88MvWheBmD/IOeyvQ8iixwkCyUjmb6c+xYG/qko+OVYTVrsnsrJ5VXBZDXFBBvEKaHFJNjtrQuSYFnTwYnJKhgi0Zk+lrGWhHrP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7833
X-OriginatorOrg: intel.com

Hi Maciej,

On 5/15/24 4:18 AM, Maciej Wieczor-Retman wrote:
> Resctrl selftest prints a message on test failure that Sub-Numa
> Clustering (SNC) could be enabled and points the user to check theirs BIOS
> settings. No actual check is performed before printing that message so
> it is not very accurate in pinpointing a problem.
> 
> Figuring out if SNC is enabled is only one part of the problem, the
> other being whether the kernel supports it. As there is no easy
> interface that simply states SNC support in the kernel one can find that
> information by comparing L3 cache sizes from different sources. Cache
> size reported by /sys/devices/system/node/node0/cpu0/cache/index3/size
> will always show the full cache size even if it's split by enabled SNC.
> On the other hand /sys/fs/resctrl/size has information about L3 size,
> that with kernel support is adjusted for enabled SNC.
> 
> Add a function to find a cache size from /sys/fs/resctrl/size since
> finding that information from the other source is already implemented.
> 
> Add a function that compares the two cache sizes and use it to make the
> SNC support message more meaningful.

Please note that the new version of SNC kernel support ([1]) that this
series is based on no longer adjusts the cache size. Detecting kernel support
for SNC (if the new solution is accepted) can be done with the test for the
existence of the files Tony mentioned in [2].

> 
> Add the SNC support message just after MBA's check_results() since MBA
> shares code with MBM and also can suffer from enabled SNC if there is no
> support in the kernel.
> 
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---

Reinette

[1] https://lore.kernel.org/all/20240503203325.21512-1-tony.luck@intel.com/
[2] https://lore.kernel.org/lkml/SJ1PR11MB6083320F30DBCBB59574F0BDFCEC2@SJ1PR11MB6083.namprd11.prod.outlook.com/


