Return-Path: <linux-kselftest+bounces-24752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06969A15BEA
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Jan 2025 09:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED7D188A1E4
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Jan 2025 08:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203C815B99E;
	Sat, 18 Jan 2025 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pj6n1Jsq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749F83234;
	Sat, 18 Jan 2025 08:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737188341; cv=fail; b=e11zZkZHbBZc8NJ2agvl6TxnOig+MEEmu5aJnemRUN7NkdbGdTiKCWTfYBpXsRoJsJkirVX0LMpitDIrQdWkXnS8jpCli6J82QGfSIyxYnEVVgM0KONyHu2xu2j2/c/R6c5gwpKCDZyH2+VNOGdhkrsxKEX3hkFW0Q+YsCwbhAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737188341; c=relaxed/simple;
	bh=cNa2NB/mog0MX8mJGPUl1J3GMsUJNUqACZw4Uw5AUS8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oov3kCQc4ux+nTkfUmxtB/HqlKmvEaHCLVGx9OihlDjyMxr3qOhU8RwHQ9rEXUB+jzM9sMWEkMKjI4HdC6pzW4zQq7dilIU0ybqRdXj4MyNwVLRnmIWQ/uEczm9jhQekGdNPhfK3flORRk4nnY84r/xBTDReVyA/QiU65/tzPAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pj6n1Jsq; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737188339; x=1768724339;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cNa2NB/mog0MX8mJGPUl1J3GMsUJNUqACZw4Uw5AUS8=;
  b=Pj6n1JsquI5nL+TFPEtmbe+GHc9bAOGo1yBgh4ZCDCI17dRWS2/3buqH
   jcfXoGcMCik4LJq+bmdXoBSkWrY9LALpide2Uu9qvaC0rm9R+i7LlV45k
   K3F/shq4UMx6dc/z6O/sPuJRgq9RjKym+NL00qVoN8yX7Nna7ouxljxUi
   BOr3qHQ1JLYL1tGcT0cRTMkhYlBjWkTybt7nJ6ftb4zGuUqxhmWZ311sp
   S1pjimDKkfCf/+gQlDMHuj2emX+7p128PjNYgOX0Qn4fTiwahdEBpsahq
   H7g2yFlbhlMSW8GOoS1Y2gD2lKDhexpnDooQ5GrcBqpIX6f7FBIuwlvKk
   w==;
X-CSE-ConnectionGUID: Uju2O2LDQIewjA0VH/XCRQ==
X-CSE-MsgGUID: lugE5q5STP2VDumwZswxmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="36902617"
X-IronPort-AV: E=Sophos;i="6.13,214,1732608000"; 
   d="scan'208";a="36902617"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2025 00:18:58 -0800
X-CSE-ConnectionGUID: EGz25Re8Swy436wNGQN8Hg==
X-CSE-MsgGUID: MZYl+n60Qs22l43OdqA/jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111129089"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jan 2025 00:18:57 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sat, 18 Jan 2025 00:18:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sat, 18 Jan 2025 00:18:57 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sat, 18 Jan 2025 00:18:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRMa3z6B8n8Nf9n8f3RlTYFSCxSiQc0Fhr/PFrV6lrCUOWiSdBqZR+SCAiSbLjadht7vlmAPxVJ5p/uSxkcgxiX5a/UhAftSd5p41BkzfFDpksLmHtEF5FaTWmxv87BdYWPqAPjbnCK7syRLet6r1ixxDAVgMrf57nvQfKXy8nRZrQ3eir2twh5Xfb4/t8quEvvrTzKB+RsM4MUSnaYGGqe1RVbJ+rNMX+yVgTMHz2pOvrLUhxvriwDJIOo/hIg7+MoL1Iul/FhOIQ5m3SVJHvPaivYQ4/0N0fHNUuh1Kwfq+u76Ek7y4KIyvSrHRjmWHkZNFUdz3XG7kBtWfxOY6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RyAYfBvtITeB9ur3CayWZ/TV62GNdwFukWaBzk2rto=;
 b=Z6SO2gabgR0mozrOUFlvkkleObMGmR7fWrV7coS2SGuW7h02ISx7lzeQjj/ZbTgxUh6P0tdK8Ay931g0z8uSLfTTiQhFCr9Hy16aObiFdu326x/seel5GHZeT5ZVxD8h607m6KHU4IgWS4iZoFlPmJJFBZF6mASmk10oYM5oyAXqi3lbfnKtXtgCOK5NSmdqDHHsmL5jA9c5vqpHJTblc0y5q4xyUcRvz/pGkc1CQOjs1fUuS7OM+qsQKsz2MIbtv0yAZ70eV8TuWlDA0oB86UXWEa9Rg2EwgF72CFCR81XUHxQ+FdfQGjmhy0wn4eZ8j6ec/jMS3dPxzAxrCawEzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB8719.namprd11.prod.outlook.com (2603:10b6:8:1a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Sat, 18 Jan
 2025 08:18:14 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8356.010; Sat, 18 Jan 2025
 08:18:13 +0000
Message-ID: <62ccc75d-3f30-4167-b9e1-21dd95a6631d@intel.com>
Date: Sat, 18 Jan 2025 16:23:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2 06/13] iommufd: Make attach_handle generic
To: Nicolin Chen <nicolinc@nvidia.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <jgg@nvidia.com>, <kevin.tian@intel.com>,
	<tglx@linutronix.de>, <maz@kernel.org>, <alex.williamson@redhat.com>
CC: <joro@8bytes.org>, <shuah@kernel.org>, <reinette.chatre@intel.com>,
	<eric.auger@redhat.com>, <yebin10@huawei.com>, <apatel@ventanamicro.com>,
	<shivamurthy.shastri@linutronix.de>, <bhelgaas@google.com>,
	<anna-maria@linutronix.de>, <yury.norov@gmail.com>, <nipun.gupta@amd.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <c708aedc678c63e2466b43ab9d4f8ac876e49aa1.1736550979.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <c708aedc678c63e2466b43ab9d4f8ac876e49aa1.1736550979.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS0PR11MB8719:EE_
X-MS-Office365-Filtering-Correlation-Id: e9355028-11f5-4744-14e8-08dd3798a728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3I3V3g1cXJGK2J3UUpnTVI1ZUNLRkJWb0pUM1U0Q0N3QkNGRk5QWjBEdXdX?=
 =?utf-8?B?cWw1YlNOMFRYOWh2T3hGMlJDMEw0eC9rZURQczdDZllBVXEwN2RsTTlqeHph?=
 =?utf-8?B?TDNhRlNWMkdLQSsyVDBZb1ZYS1p3M1dFNWFsMmJteSs1RXVRbGFWYk4yY1RF?=
 =?utf-8?B?RjdiWE5IRWlzQm1RWlRHbjcyQy9Yb3Z6SXVGT1Y0UVpsT2FjN3BXTm1BbXp3?=
 =?utf-8?B?cUQ4ckJKak9Sa2U3NEtzNXNxS0xES2FXMUh5Qk5aOVJMYzNpbzVRalg4dEZD?=
 =?utf-8?B?bWY5SkM5OE5GRU5uL2p6M0t0MG5RRTluSDJkSnRBNFJ5OXRLSk5DNG1leHEx?=
 =?utf-8?B?Y21qTXYxZlJ4dlNMQW51VGFTbjQxa2V6bW1maUtSR2NnY1VpK0poc0lVQ2No?=
 =?utf-8?B?MzBhd3pXcjBKeFFlb0g0Y0gzUUhNOTlrVGp2TmFZc3UvUTVPY3U0cmtmSGc0?=
 =?utf-8?B?RFUxdHNXbisxY2E1MVZNM3hRUFAySWowVUdzQmYwL2JkRVRFVE1NbVRjdmdW?=
 =?utf-8?B?UGw0Y3I3dndMSWczOWRxWWJEaEdXRElFUHRZNG9JbDh4TmRDSlRMaWVFVlFY?=
 =?utf-8?B?TmdyODQzQ2psUHRQYk5GU000SkhmR3UvU1ZMZ09DOFRjWGJmTWFvUEd2eDFN?=
 =?utf-8?B?Ym0rcGpnS09taHVhS09pSHR2WjNOb0hhckdZbUhtQWY5Tmhyc1hKd21tOUJZ?=
 =?utf-8?B?TXR6LzdQaDFpajJaa3krOVlYMDAvOVBnc09Fa2k4bFBvRXJvNkhUUHF4NGY5?=
 =?utf-8?B?SllrYTdubU0vQmVoeEl4ZEprVDRIM2gyUUl4cjFUQnRJVkh6SDR2MnV4UUVN?=
 =?utf-8?B?ejNzN1c1VVE1cUpvR3R3ZThJYm5kcFExQ3hLRmhxYXpPZWt3Ylh6N1JaUlBI?=
 =?utf-8?B?Qk5kZnlqQ3BueVlHOVRTL0tIT3Yzcy9MM2ZLNkpnVjdqanQwR0pQK3RPbzlT?=
 =?utf-8?B?dFdvZnd5QjhpN21KRUlnRFVkSFJLSlhGaVk1YVBERHpSQzdaZU1tMmhHdFBp?=
 =?utf-8?B?c2IrcVZVMW5LeTlxZGtWL1NmMW1DZE40K0ZVUHVwVkFhQUt0RnpGR29MVURk?=
 =?utf-8?B?V0xnd1orL3ByNjZpc2dpc3dMVmR1RzFIUis2WGJHOWpMbnlBT0NuVTcvai9q?=
 =?utf-8?B?ZW9PNTF5OEp6RkllbXZNc3hEQ0M3NjhCcEdxcUdBK2ZscHhnbUIyV1ZPckNj?=
 =?utf-8?B?QWtrM3ROSUQzM0pjK0thakE1UFJzWkRKbTlEakR5aXVkQUNVYVYvWHllYWJB?=
 =?utf-8?B?d1FzZ1pCQlBqL0dweGRHY0hwOFdoZ2lNSlliVWVTdno1cHNqREwrL1NBOUhW?=
 =?utf-8?B?Q0FoT2RhMGxCdkVzOTVlWDFNYmd3YTg1ZEJ2OUhvNmhDU1BiZ2RPMGsxWm9q?=
 =?utf-8?B?Vk9KczhjS0Q3b2V6OXlFZmEzVmhSUUNkRm5UdmxmRDZibFNMQ2JqVUpvRW8z?=
 =?utf-8?B?VElKWGlQZmJjeE1IYkZ0Qm1yU3I1VzNYS2FKK1ljR01LTFAwSUZrOFJPdGUx?=
 =?utf-8?B?RGNEdDhtZ2ZDSmhSejJUamtOL0FFYSt2ZXRCbTRUS203ZVJ5bFhScEZnY0dS?=
 =?utf-8?B?OTg1ZXB2N2UvL084eitVWHhnVThRSnAwQlFmSjRZMy9NZTRZMWxZVWpOUHZx?=
 =?utf-8?B?T1E1ZEtBMVplQmhZMzErZlMxeXdaek5jbmZPUVBCeWNJb1Iwckp0YUI0M1RJ?=
 =?utf-8?B?dVBYVk00ZC9yVENqdnFraTg2TWh4UkZGRnhlM3BLSm8zVTZPSHlZa3ZpdG5W?=
 =?utf-8?B?NmJkbldWRXdXL093L01OY3JiRTJxN0NnVnZhRzNqamdoNW9Fa3dyNWlTSWVs?=
 =?utf-8?B?VXRBb0NiSTRSM2FwQk5NbHAwMXBUUW81SjYzKzFjNlN0MlM4Zm9IQUQxeHZT?=
 =?utf-8?Q?voinOl0b7vXiK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHFWQzZkZ3ZwcVlZdWpIYXcxeURKSjE2M1BwSmt2WEpjR2ZUd3FHNm92Vk8v?=
 =?utf-8?B?eVZSWi9zZXFHaStKZW8wMEtUbE9lTHVPOWQzdDg2aFZtWmN1MjhpYU85Nnhq?=
 =?utf-8?B?Z2Y0Q241elB6b0N1bzFGMVpUWHV2ZnBJTWZnWEhQYjIyNU0veFdQdlV0a1FF?=
 =?utf-8?B?NEdJdFJXVi9UTVMzOWVHUHJrN3NHZXR5OE5weXpwVFIxeTF2Nk9mTWZjYVc1?=
 =?utf-8?B?VSticUkzdHk4WXBBUG9yL3c5WTNCTHM5bDZFY0h6SVkzVUpSNklwS0tJRlNt?=
 =?utf-8?B?b3FpSjJUTGt1M0RXVytoczN1OUhINHFJNmsySVllcW5PUzJnaHdlbDhrdmFl?=
 =?utf-8?B?SDQ1aFJsT2pjSEVxdlB5cUk4S1FmU3hwVjJ1clBpUTlVby90WmxSRzNEdUtX?=
 =?utf-8?B?SUhsNlFCbzUvVjJyOXJiczlNSk1XRmZYYlIveExDZVZoY0lSazV6cGpzL3dN?=
 =?utf-8?B?a3kxYUFQWWQ4bTJIdGZWNHA0REZPbnlkb0JxVDJOd1BMN0pGZFI3SmxoYStq?=
 =?utf-8?B?ZXpmdEhiRXRtd2xUS205M3I4WXMwcW1CVGVCTEtTeW1OdnJzLzI2dWlCVDcz?=
 =?utf-8?B?NlR4TWxwN3BtUVhnRGZPVXg3am02eU1xdGZ4dWsyWHNZZkkxa1M0V1BZcjRq?=
 =?utf-8?B?UzFpSTdYMm1IbVZ3S0t4VHJqaUduWjFRNkFNT05kTTBNaTRnbnExbk91N0hH?=
 =?utf-8?B?eGo4Y09WUXpmUm1vVCtzMmw0ZTF2L2VhSnlZREhCMW9sQzJRN0I5VnZ2aHky?=
 =?utf-8?B?cG4rUjNlNFVwank2WFFxQ0R6MGJhekphVTJac2VGbWpJYnpCd2VqSElVamFZ?=
 =?utf-8?B?TXVHbGUwUGJTWU9pQThDTWxIdVRZNDFRSFdaNSsrbWxUZTRIV3RtZktITSt1?=
 =?utf-8?B?KzdtN2xXL29WcEx6amJsWGdRSkFuVkp3OURWT3FIeEZ0bjRTNGthbXR0UXZS?=
 =?utf-8?B?d1BtRnFmVmZQMW1VbS9Ua2RsVys2UVJ0dTgxaldZRDBWNXEvVmMveVg0WE1L?=
 =?utf-8?B?ODNJbjVpbmk2K2I3aEc1QVVKRW5nc2pGcUZGNWxsRE50dGtIdmg1STZHZlgv?=
 =?utf-8?B?eWFxWnhRSDRFNGs3L1lWRVYrT09qLytBeVBna1F6SUVZOXZFZmw5bVRnWjhU?=
 =?utf-8?B?cVo4QWZqYXplbnhtSUo2SXBKR1EyS1ZCdEI5bDRSRXR5ZnFsNkZkQ1owV0x0?=
 =?utf-8?B?RE1hWGJhQlpQR3JhVmczeXRteWRSRFU1TXRUaExMaWFZL1hhZXF3ZHVaMUt5?=
 =?utf-8?B?N1U5MEFUVGw0SmhUZ082a3NzUHdTR2ZxV09yKzdMR1RNYzdtVXlzMDFuNVlV?=
 =?utf-8?B?MHZINzhQVmI4WWxHdUlFd2lMTTY5MEFZNmZ6cGdnUlRMZEpHUG41WGZxVnpv?=
 =?utf-8?B?WjlGK09mZU5ZbndBaEFPUDNZMFNIdDdZVFpaMHgvTnNPcWRCMjk5NGlqUmk4?=
 =?utf-8?B?MnlZblJkUVFCbGYyWDFtakpTZEZlTjdkTkFLYXA3REhyQU1ldW5Fd01NTnVk?=
 =?utf-8?B?RlB5YURRQmhVVTcxVEtHQndDRzVYenpNVE5mdWlKeXAyODV4Z1NSejN0Vlpv?=
 =?utf-8?B?MWcyc2FzUE83SUNSMkl2MEFQQ05QUFcvZVQ3eldoL2Z1NUk2V2dMcGFFTFp4?=
 =?utf-8?B?NUlhTzAveU9FeXVsNmtGT1BUcVhtUWxuTTFOaVBhenZTTFhoUFBldHNaMXBK?=
 =?utf-8?B?UEVWd0VzL0dJM1JvQ0liNUVoNEUxS1FvblNkZWgwdHVTd2hZNU5WL3lFMjN2?=
 =?utf-8?B?RDJSWHRUQ2U1cW5TSS9EWEQ3dnVONTRFZ0JDOVRXcGlVZmNlS2EzN21Lc0My?=
 =?utf-8?B?bWNjbmJMaTdXQ1NkSFl4cDhoU0pId0FsZkVkU3ZaaDNrV3I1cmFvWU9yZ2FX?=
 =?utf-8?B?ZmFxSGh1SmkveEZhSjAxWFcyVE02SXM5ZVQ4L1k1MmlqaStibXZGVklldW00?=
 =?utf-8?B?YmY1ekpmZjU5M2xXMEx1eGl2VC9FMHdmUFEwYnhSOHlQY085RlAyQlV2Ylp2?=
 =?utf-8?B?Q2tST0dPWnZqNmdkU0xkTzU0N3N1akllay9Yb2UwK2tzWU5mS1U3ckd0eHJq?=
 =?utf-8?B?UFNOV0I3V21VTmo3SGlDQWlHdC9IUDBHS3diUk9RREJpc2tIcDM1OXBiNjJo?=
 =?utf-8?Q?QA+VCv/NhkkjgywAwBHcOZGMj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9355028-11f5-4744-14e8-08dd3798a728
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2025 08:18:13.6745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MkrDJHfhnglWswgpSP7d5wPFja/3jSMqekBg8EGXPKw8yLLfFaaQTV7aQAy4bmhHLdvSh3dZ4kOmnSOChYKmPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8719
X-OriginatorOrg: intel.com

On 2025/1/11 11:32, Nicolin Chen wrote:
> "attach_handle" was added exclusively for the iommufd_fault_iopf_handler()
> used by IOPF/PRI use cases, along with the "fault_data". Now, the iommufd
> version of sw_msi function will resue the attach_handle and fault_data for
> a non-fault case.
> 
> Move the attach_handle part out of the fault.c file to make it generic for
> all cases. Simplify the remaining fault specific routine to attach/detach.

I guess you can send it separately since both of our series need it. :)

> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommufd/iommufd_private.h |  40 +-------
>   drivers/iommu/iommufd/device.c          | 105 +++++++++++++++++++++
>   drivers/iommu/iommufd/fault.c           | 120 +++---------------------
>   3 files changed, 122 insertions(+), 143 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index b6d706cf2c66..063c0a42f54f 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -472,42 +472,12 @@ void iommufd_fault_destroy(struct iommufd_object *obj);
>   int iommufd_fault_iopf_handler(struct iopf_group *group);
>   
>   int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
> -				    struct iommufd_device *idev);
> +				    struct iommufd_device *idev,
> +				    bool enable_iopf);
>   void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
> -				     struct iommufd_device *idev);
> -int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
> -				     struct iommufd_hw_pagetable *hwpt,
> -				     struct iommufd_hw_pagetable *old);
> -
> -static inline int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
> -					     struct iommufd_device *idev)
> -{
> -	if (hwpt->fault)
> -		return iommufd_fault_domain_attach_dev(hwpt, idev);
> -
> -	return iommu_attach_group(hwpt->domain, idev->igroup->group);
> -}
> -
> -static inline void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
> -					      struct iommufd_device *idev)
> -{
> -	if (hwpt->fault) {
> -		iommufd_fault_domain_detach_dev(hwpt, idev);
> -		return;
> -	}
> -
> -	iommu_detach_group(hwpt->domain, idev->igroup->group);
> -}
> -
> -static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
> -					      struct iommufd_hw_pagetable *hwpt,
> -					      struct iommufd_hw_pagetable *old)
> -{
> -	if (old->fault || hwpt->fault)
> -		return iommufd_fault_domain_replace_dev(idev, hwpt, old);
> -
> -	return iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
> -}
> +				     struct iommufd_device *idev,
> +				     struct iommufd_attach_handle *handle,
> +				     bool disable_iopf);
>   
>   static inline struct iommufd_viommu *
>   iommufd_get_viommu(struct iommufd_ucmd *ucmd, u32 id)
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index dfd0898fb6c1..38b31b652147 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -352,6 +352,111 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
>   	return 0;
>   }
>   
> +/* The device attach/detach/replace helpers for attach_handle */
> +
> +static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
> +				      struct iommufd_device *idev)
> +{
> +	struct iommufd_attach_handle *handle;
> +	int rc;
> +
> +	if (hwpt->fault) {
> +		rc = iommufd_fault_domain_attach_dev(hwpt, idev, true);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
> +	if (!handle) {
> +		rc = -ENOMEM;
> +		goto out_fault_detach;
> +	}
> +
> +	handle->idev = idev;
> +	rc = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
> +				       &handle->handle);
> +	if (rc)
> +		goto out_free_handle;
> +
> +	return 0;
> +
> +out_free_handle:
> +	kfree(handle);
> +	handle = NULL;
> +out_fault_detach:
> +	if (hwpt->fault)
> +		iommufd_fault_domain_detach_dev(hwpt, idev, handle, true);
> +	return rc;
> +}
> +
> +static struct iommufd_attach_handle *
> +iommufd_device_get_attach_handle(struct iommufd_device *idev)
> +{
> +	struct iommu_attach_handle *handle;
> +
> +	handle =
> +		iommu_attach_handle_get(idev->igroup->group, IOMMU_NO_PASID, 0);
> +	if (IS_ERR(handle))
> +		return NULL;
> +	return to_iommufd_handle(handle);
> +}
> +
> +static void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
> +				       struct iommufd_device *idev)
> +{
> +	struct iommufd_attach_handle *handle;
> +
> +	handle = iommufd_device_get_attach_handle(idev);
> +	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
> +	if (hwpt->fault)
> +		iommufd_fault_domain_detach_dev(hwpt, idev, handle, true);
> +	kfree(handle);
> +}
> +
> +static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
> +				       struct iommufd_hw_pagetable *hwpt,
> +				       struct iommufd_hw_pagetable *old)
> +{
> +	struct iommufd_attach_handle *old_handle =
> +		iommufd_device_get_attach_handle(idev);
> +	struct iommufd_attach_handle *handle;
> +	int rc;
> +
> +	if (hwpt->fault) {
> +		rc = iommufd_fault_domain_attach_dev(hwpt, idev, !old->fault);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
> +	if (!handle) {
> +		rc = -ENOMEM;
> +		goto out_fault_detach;
> +	}
> +
> +	handle->idev = idev;
> +	rc = iommu_replace_group_handle(idev->igroup->group, hwpt->domain,
> +					&handle->handle);
> +	if (rc)
> +		goto out_free_handle;
> +
> +	if (old->fault)
> +		iommufd_fault_domain_detach_dev(old, idev, old_handle,
> +						!hwpt->fault);
> +	kfree(old_handle);
> +
> +	return 0;
> +
> +out_free_handle:
> +	kfree(handle);
> +	handle = NULL;
> +out_fault_detach:
> +	if (hwpt->fault)
> +		iommufd_fault_domain_detach_dev(hwpt, idev, handle,
> +						!old->fault);
> +	return rc;
> +}
> +
>   int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
>   				struct iommufd_device *idev)
>   {
> diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
> index 06aa83a75e94..1d9bd3024b57 100644
> --- a/drivers/iommu/iommufd/fault.c
> +++ b/drivers/iommu/iommufd/fault.c
> @@ -60,42 +60,17 @@ static void iommufd_fault_iopf_disable(struct iommufd_device *idev)
>   	mutex_unlock(&idev->iopf_lock);
>   }
>   
> -static int __fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
> -				     struct iommufd_device *idev)
> -{
> -	struct iommufd_attach_handle *handle;
> -	int ret;
> -
> -	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
> -	if (!handle)
> -		return -ENOMEM;
> -
> -	handle->idev = idev;
> -	ret = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
> -					&handle->handle);
> -	if (ret)
> -		kfree(handle);
> -
> -	return ret;
> -}
> -
>   int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
> -				    struct iommufd_device *idev)
> +				    struct iommufd_device *idev,
> +				    bool enable_iopf)
>   {
> -	int ret;
> +	int rc = 0;
>   
>   	if (!hwpt->fault)
>   		return -EINVAL;
> -
> -	ret = iommufd_fault_iopf_enable(idev);
> -	if (ret)
> -		return ret;
> -
> -	ret = __fault_domain_attach_dev(hwpt, idev);
> -	if (ret)
> -		iommufd_fault_iopf_disable(idev);
> -
> -	return ret;
> +	if (enable_iopf)
> +		rc = iommufd_fault_iopf_enable(idev);
> +	return rc;
>   }
>   
>   static void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
> @@ -127,86 +102,15 @@ static void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
>   	mutex_unlock(&fault->mutex);
>   }
>   
> -static struct iommufd_attach_handle *
> -iommufd_device_get_attach_handle(struct iommufd_device *idev)
> -{
> -	struct iommu_attach_handle *handle;
> -
> -	handle = iommu_attach_handle_get(idev->igroup->group, IOMMU_NO_PASID, 0);
> -	if (IS_ERR(handle))
> -		return NULL;
> -
> -	return to_iommufd_handle(handle);
> -}
> -
>   void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
> -				     struct iommufd_device *idev)
> +				     struct iommufd_device *idev,
> +				     struct iommufd_attach_handle *handle,
> +				     bool disable_iopf)
>   {
> -	struct iommufd_attach_handle *handle;
> -
> -	handle = iommufd_device_get_attach_handle(idev);
> -	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
> -	iommufd_auto_response_faults(hwpt, handle);
> -	iommufd_fault_iopf_disable(idev);
> -	kfree(handle);
> -}
> -
> -static int __fault_domain_replace_dev(struct iommufd_device *idev,
> -				      struct iommufd_hw_pagetable *hwpt,
> -				      struct iommufd_hw_pagetable *old)
> -{
> -	struct iommufd_attach_handle *handle, *curr = NULL;
> -	int ret;
> -
> -	if (old->fault)
> -		curr = iommufd_device_get_attach_handle(idev);
> -
> -	if (hwpt->fault) {
> -		handle = kzalloc(sizeof(*handle), GFP_KERNEL);
> -		if (!handle)
> -			return -ENOMEM;
> -
> -		handle->idev = idev;
> -		ret = iommu_replace_group_handle(idev->igroup->group,
> -						 hwpt->domain, &handle->handle);
> -	} else {
> -		ret = iommu_replace_group_handle(idev->igroup->group,
> -						 hwpt->domain, NULL);
> -	}
> -
> -	if (!ret && curr) {
> -		iommufd_auto_response_faults(old, curr);
> -		kfree(curr);
> -	}
> -
> -	return ret;
> -}
> -
> -int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
> -				     struct iommufd_hw_pagetable *hwpt,
> -				     struct iommufd_hw_pagetable *old)
> -{
> -	bool iopf_off = !hwpt->fault && old->fault;
> -	bool iopf_on = hwpt->fault && !old->fault;
> -	int ret;
> -
> -	if (iopf_on) {
> -		ret = iommufd_fault_iopf_enable(idev);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	ret = __fault_domain_replace_dev(idev, hwpt, old);
> -	if (ret) {
> -		if (iopf_on)
> -			iommufd_fault_iopf_disable(idev);
> -		return ret;
> -	}
> -
> -	if (iopf_off)
> +	if (handle)
> +		iommufd_auto_response_faults(hwpt, handle);

no need to check handle. After this patch, both the non-fault and the fault
path will allocate handle. It cannot be used to isolate fault and non-fault
path. Also, the callers of iommufd_fault_domain_detach_dev() will check
hwpt->fault before calling it. So just call iommufd_auto_response_faults().

> +	if (disable_iopf)
>   		iommufd_fault_iopf_disable(idev);
> -
> -	return 0;
>   }
>   
>   void iommufd_fault_destroy(struct iommufd_object *obj)

-- 
Regards,
Yi Liu

