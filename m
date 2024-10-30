Return-Path: <linux-kselftest+bounces-21095-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE779B634A
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 13:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3FD61F21C09
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 12:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1B41E884B;
	Wed, 30 Oct 2024 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ACcZf6u3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E70C22315;
	Wed, 30 Oct 2024 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292581; cv=fail; b=pnw+VXe8PdG8ov0lH9AF2mDpTFTLFw32n59YJiR0S06EoZIEfgMuOMX5/NWfImZDVJFQ2tECypwdlSDCQKz2HEiwf15Aa4qqNvwUxcQGqwgMYPMA7jZ/kmu3DgNlxQ8/xO2l8fZZkaICwDLW1BT4KZ/utGRdqT9sfjuNC9WQRTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292581; c=relaxed/simple;
	bh=ZeHpB0WbttHMzOfUex3cQdDlAdLuUvxtx/UWL+c3mMk=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e6YZMsYJlmQZdjxtMp7HqddMYOxDngDFfk/dffN8AL0/AYV7TsD0CJ2jrVy0GceD5cZHCzbp0YpmgPN0OUW5X/SR33a5U3D8q0Pc1msJmp0I1wHtnfIjKWBBWip54b+ivyMN5tcv04koAOCDEL2/+Y2CcHwevGa5BxayBqXem7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ACcZf6u3; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730292579; x=1761828579;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZeHpB0WbttHMzOfUex3cQdDlAdLuUvxtx/UWL+c3mMk=;
  b=ACcZf6u3xZgAyVaTSsUb2SDUqOKVRDnfERf3LKvbDAF8QCVzlPpVPCg6
   rqxMgAhwTIdxvGYK9k665j6foG1hwwOT/CuaQSloNa98nzd8cUQWmsNDm
   dgdQsHcoUqE57tNQUzucLv9+0rf44vlRuyHVo0cpq9nH3ALznHLsmbi2g
   m6cR4GfgCL87ZtpXeU2/P3LEJBxg88Uk84V6hVTbIAJcSsHOcWjkwKobk
   53D9x6eOU05d1Ib4ZyJx8X0AykOmkEBWlnAEKAHJYcrqfwecvjV5KBEIl
   +uVpf5ZPw9CQg+i5CMY2IjuWYxMnWjgLe0rtnl/z8IZso8NVzXota93ez
   g==;
X-CSE-ConnectionGUID: 2K2q1nViTgCUmnKu0txmyA==
X-CSE-MsgGUID: hylbt2OIRGeVY08fu+9Cqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="41391405"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="41391405"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 05:49:38 -0700
X-CSE-ConnectionGUID: mPBVknotREG/tMWNrXWk3g==
X-CSE-MsgGUID: KcPyhpuNR6GmOacTB4QDEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="86238478"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2024 05:49:38 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 30 Oct 2024 05:49:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 30 Oct 2024 05:49:37 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 05:49:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMNhTwnOT+tUVQJKHri919Im50HEF4WUgl/oRSAS9W7vP+GH7NQzQvznaMVNAX11u+JZvmGWMxOgsmbQ90SpVDf2mkjHyW6klF3vJzigDpHwAsWywOFOdAOak16gbw2U+Dh94LRhuaY5ektbqR7ZG/A1yWtvTmu5V3vOvAf9ie/ZnAUBbj/+5XNu1zFbQCKvOX40n6sHJyd8SW9f4kCPQpxByOnUCiKgA92wTyEG0jJgfUf0s7kET+0/s2Uw57K5GTke+N+nQyBAcB8EzZg+0v1YXCnneb5DVqt+zy9ZOAx3ERgme38fH3ihjZyjQDRihGPBZkzU2gYDpuq6KcFuWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfA/g80Wet60qx/FNIFa41JHP5Q8HPp687ORR45wNe8=;
 b=sP/JacxY7KgRvN91cEEnV+YSalBrCy2wB3hsuCNl8DD8W5NF6UedoENDgjSE4C6qhG81+PoLetIwGl77IFiqweKB7W73OpD3eWWf0U5/xxspWVh3Rb7U4EHaJKW+Nd22ytGxQXuRSSdVwTZMSxv+MpbrRXWTddjEik0YP8j2ikcx2aDacByw+3/i9FsG/YPv/cC9/gj06FbP0eSzfZDijIPbi8tcpnN8gAIG3boSbBBgjNI+FrjkZKhuzHFTN5nqGFuu0jBidwiVGCsAE7qRtTRa7YOSnHs9W1/3ZG2eo8O1cXbtY5nNjsNz6Q/xOh1WYQQlWGp8UPStZ7bIGsw5Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SN7PR11MB7996.namprd11.prod.outlook.com (2603:10b6:806:2e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 12:49:34 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 12:49:34 +0000
Message-ID: <7d8b2457-8dc4-43d1-9a12-19e2a71a0821@intel.com>
Date: Wed, 30 Oct 2024 20:54:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] vfio: Add VFIO_DEVICE_PASID_[AT|DE]TACH_IOMMUFD_PT
From: Yi Liu <yi.l.liu@intel.com>
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
Content-Language: en-US
In-Reply-To: <7f95f2cc-6691-4f40-bc50-e4430ebdbf1e@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SN7PR11MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d58280b-3e2e-4fe2-7a4d-08dcf8e14de8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFdlWjcwWW16QW9QdWVLd2swanY3M0haaGg1aGpvdGtlWGFRMTYyMWpBeHlD?=
 =?utf-8?B?U1h0L3M2TVR1dDc4b1g2WTgvd2h0WFR3aUNOQ1Y2LzdFOURRMGpMNktRWk5s?=
 =?utf-8?B?cmJ3anJEYldyOG8zdy84aWlVemI2L09RSmtucjdGcEE0WDR5cCtYMUQyOTJl?=
 =?utf-8?B?UEl0R1ZFQ1V0RmZKcytiSmdaTHVQdW15WGZvK0hrdTM1d3BiK09ESWRWS2dD?=
 =?utf-8?B?K2xjKzdtTUxrVTlpWFYzUXZlekN3Y204NHgwWXZXZmlpSnNYcmFsbHhtTFF1?=
 =?utf-8?B?T2hrTmYweG1iaTRUTlpTVFZhM2R2OHFpU1NIRDdRQ2I4OVVCVW53RU0vZmts?=
 =?utf-8?B?Q1ZtNjZqUy9PT1I0TysyRmJOQXpXWUVsWFVLVC8wZHhxM1dYZUk2STg0aHAy?=
 =?utf-8?B?SHlsM2ZHcnhFblFUZm8zRy8zeU8wODdscldtbk5PV3VkRThBWmw0NnFESjFR?=
 =?utf-8?B?c1RqblBUdnd4amlYNk14WU9zSk5RYWVMM1lOWU5xVnhMaUErVy9HVlB0RzZs?=
 =?utf-8?B?d3h3NGtJaXJmRVA2K2c2NWFHdmM5ajBmSFlsbkNMUHR4Wk4wbHVON29GODUx?=
 =?utf-8?B?b2FJcCttaUJzSUhVczZTWVRlZ21oYnJGaWJPR25tOGIxVS9ORURBckJwSUJE?=
 =?utf-8?B?cndzdzE5RWo2Uk9yaUhJN0xpOHRtdmYzdUtLQklDNTNEZU4zS3BUUlI1dzFn?=
 =?utf-8?B?ZFBJblVyR1RSblc5bEMwdWdJWEFYekM2VWQ5NWhpZUkrLzg2dTNnNzZvRFVG?=
 =?utf-8?B?OUZGWSsrRU5CWjQycXBHVlJQdG9iRUZaUEVTTjEwd2xuNHRmTEJ3SHp2Ni9K?=
 =?utf-8?B?OFBOSVBWc2kxUzd6bmNnZHVFK0l3U1cyNkk0bkJveTBTcmZZNzZVZitCU2ZH?=
 =?utf-8?B?WWhGTGtQcmVSSkRiVDdFZG5NcDFmbWVHQU9YNmxoTHNZWHFsd2ExOVJQVWJK?=
 =?utf-8?B?Ujh0bHc0OURTWk94cGNDalBWTjEwT3haamcvRDRtY3lhTndNMzR2Z0I2eTl5?=
 =?utf-8?B?WG9RNFg5Q1c3YzNqUUdDRjMreHg4QmNRN0hYSXJGeU9sbEFleXRqQVRwSHdK?=
 =?utf-8?B?bnFUQ3BzMk5CbDZqMmx0anEvNDJGdU9UcFhCby9DdzZhbll5WDNCQVZRUVZP?=
 =?utf-8?B?c0V4WklnWExZLzZrNmQ4SFpkQmVmYWdtbmhoSEswTStPN2hBaUgxRzA2c3FC?=
 =?utf-8?B?ZFNkeVROaHlsUHZmUGZjTEZtN2IyZ2ZsS0lLUUJQcVMwSlBreDhybUdLVVRF?=
 =?utf-8?B?dUd1QmZ3Z3ZyZE9VdVJSSTFNMmE1akhJZERLMlFLOXFSdU1CM09sZVNjRVls?=
 =?utf-8?B?WGRlZTRMSDlXRndaQUQ1a2V1eHhVQ24wdms5QWJHL2tMUStnaTk5NHoyaWt6?=
 =?utf-8?B?QlFEd2hjTTZGMG8vT0Era01KTHI1NjZWcDRoOHFZK29nclZpNzRtMlVFd012?=
 =?utf-8?B?L1Zhdy9PcXZHSjllc0ZTZzRpMnZVRDdDa3E2Y2FYZkl1VU1iRnlBMFpFOFhn?=
 =?utf-8?B?TmZsY1RGTitGQk0vZEI1blRMYUdRaXdMS05OSmhRdTdjQjRERHF6V1BHV3Zk?=
 =?utf-8?B?cHg1YW40QytaZVErSk5SZERNc1NVTm9HQThaN2pjNkhtd0dnMkFkRFFVcjRz?=
 =?utf-8?B?MFFiMVFEMnJjUlMrWU5SVElBa29hMjE3WmpVRWZFalQ5a3ljekdXWWVUc0s4?=
 =?utf-8?B?SnRUZytXUHZqVnBWMG5WYlIyc3dKWGVGVjdHbFdxSDgvZC9pQ05KL3ErMnJC?=
 =?utf-8?Q?HI6J2UAls4JjsZCUns=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3EySFVTR3RxbVB5bGs0cktuV21SQm9ERVg4UmQyM1VXQkZldUZncjVMdlVa?=
 =?utf-8?B?ZEtkTUNtTUVOaUc4Y1pPSG9BT2hVenU5d2FTV3NUaitTa3hUTGJSVlhwWTRH?=
 =?utf-8?B?MTBxMjlYYjBzT2djcG1senFDb05jNm1UZEFPcVJlc2piOWptMWw1WWRHY3Ro?=
 =?utf-8?B?RWlvbktWMHlXME5ZZnB4c1l5VlJiTFVqSDdtbWxlUWhra2JmWEF0M0RhVVd3?=
 =?utf-8?B?MWNJR0t1VHNvUWl6K2hBY0F4b3Zsc3pqMytTbGErSFVkMi9SRGoyYXpFRFkv?=
 =?utf-8?B?QVhDWE44NGtWdkdCWlBsaFhXeHlKU1ZoNnllNU83MFNmMUZSYnlJK3RYSnIy?=
 =?utf-8?B?Qy9Sd0I2WkVubWN4UTJjOWFEZExZVWgzcVVkVUdTOExrZHQ1SHZETHkyNWZl?=
 =?utf-8?B?bC81dFFBcGlBYzRtU0VLYUFnYW5RYWUvT3FwQmlocEIrcmR6S0VtUDBwMVhy?=
 =?utf-8?B?eE1JSzdEWk93YW1aSm9HWVZmMVZiWHJ1WGxaelYvOTdYNnU1ZXpqNjdId1oy?=
 =?utf-8?B?WHJzOWdBNk1Qa2I5TDl5UjhVSXhsWmh4dm44c3FnczNmUUk5cU1YdUR6MGVQ?=
 =?utf-8?B?dGp1dzFMOFhNSDMwQlpSeTVjY2lMK3M3MFlidmJ6ZDRPeStodzBId0hCdkVu?=
 =?utf-8?B?UUhESTVqSU02YnR1QmN0bTJCT0htMnl3Z3NkOS9tYXpHNmkxVUgvOStZV0hY?=
 =?utf-8?B?enhBUVdXMThtUTFhcWVBWlgrcDBRY3N0WVl6NkFxWklTeFhqUjN0RE94dDJI?=
 =?utf-8?B?R1ljcThDVkdWaytsRXZUYTMvaVFUeVdzUHpMSllrMURmOVY0a0VMZ1QyRXlt?=
 =?utf-8?B?ajVSY2x5VTBOTmp5Y3lqOGNMekt1TTNTQ1pvbkdZV1habDM2N2FQRkxxTko5?=
 =?utf-8?B?eVlBWk14MHluK0F0c1dNMDhGKzlKVDBmNzJZSEh1Z3FpL1QwR1psekpQdjJZ?=
 =?utf-8?B?dnp0TXMwdW1Dc3Era0s1bHN1c015YldtVWZZMDJlK0toNkhzeHV6azVkS0xi?=
 =?utf-8?B?R0poTm9lZkovWmN5VzRybXh3RUMvSG5QMm5NNVkrRmpOQkNEc2FrMHJ0Tmov?=
 =?utf-8?B?UDBRTmxhekEwWmpPMkZiejd1OUo5ZFdjYlprdU9nY3pxUjVpWVd1bzJvdytB?=
 =?utf-8?B?aDQ5SkNGK2lEN09tS0ZzRUZxOHBrTlpZZXZvL3VTRmNQMmlxTUE2YnB5M3lP?=
 =?utf-8?B?MkhqckU4MWYwYjUzV0F1NjJ5eURXYm1MU2JwS3N0by9td3B1U2tEcURpREJL?=
 =?utf-8?B?aHRKY29jZmEraWQ2SVVMMDNTZ1B5VDQxUFNhc0Q5YnlKY24yanV3Rng0TGxB?=
 =?utf-8?B?MU1Lc3J0TjhBc25SenErelVKano5cGtoOUFCdm5BM3N1enJSVEFKRFF4V0Zu?=
 =?utf-8?B?K0swVUxENjdobHI2M2dlVU5xaHlLcVlKczI3ZVpvU3l2RTdNRi9mZm1YTmhH?=
 =?utf-8?B?aHIwZFRkRE1HUzdNSVQvaVZ0bWJjcndJVTFZWEU2em1hL1ZOTGQrcm1FZ0V3?=
 =?utf-8?B?b0ZIRno3UFArWDZ3aGlsSnB3SE5Xa0NyazR2VWlUenFGTWlqRXdOYmhMODdi?=
 =?utf-8?B?Z3Jmam5IVkFySHNOODJnMno0eW9UaUhLaUlub09qYldZNEJCWGFEN0NDWS9N?=
 =?utf-8?B?a0pWSmxFN1c2SFROUVJMeStMeXduUzU3cXo4NWUyR3lQR3lWUWZNOFBBOGEx?=
 =?utf-8?B?RlVVKzg1ZXJxbWNyVjZNVGZ6S01OUG9wdG9nZ1pzY1k5eWVnRHg4aC9vYzBX?=
 =?utf-8?B?SUZMUXNVN1JkOGhlZWFXS0tqcXY2NlZOd3R3ckpBcDQ2R1Y3anR0WWtQWGNs?=
 =?utf-8?B?WXVnZmU5WFh5ZURmSHY1cXNCcmtWbEprdDZyS1hNcjRvV0paYzFoUVdqZURs?=
 =?utf-8?B?Y3ErOC90eFpJT2tCSWxFR0pHa1ZYbG10WVRIdzhDMXlPbEVYc3BWUUZZbWw2?=
 =?utf-8?B?T2ZpcmdCUjJKanY3a1N4ZXQ1NDA3ZW1tVEZhakJIdU82WDBTMUt4dlEycEFy?=
 =?utf-8?B?bDNEQWVLWHlKMllwa1d4MStrRVVsKzRjU3ZZSU50OWtCSzNqWksxa3BKRERU?=
 =?utf-8?B?R3kvdUlaSlhia1lqcVF3eTVVaDZlb09tdXQwaDU1dE9jUmVRL3B4aGxJYUVW?=
 =?utf-8?Q?BtIudHg40qOn6eb2YSTKkfgyl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d58280b-3e2e-4fe2-7a4d-08dcf8e14de8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 12:49:34.1389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FB6CqUM3zG4sKK63gL1wEP5KgXNeV2IOmrItboa202g+MHOOO8nxBomShLXNOaRyYzFJuqKBZHJtaU65M5Bew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7996
X-OriginatorOrg: intel.com

Hi Alex,

On 2024/10/18 13:40, Yi Liu wrote:
>>>> I think we need to monotonically increase the structure size,
>>>> but maybe something more like below, using flags.  The expectation
>>>> would be that if we add another flag that extends the structure, we'd
>>>> test that flag after PASID and clobber xend to a new value further into
>>>> the new structure.  We'd also add that flag to the flags mask, but we'd
>>>> share the copy code.
>>>
>>> agree, this share code might be needed for other path as well. Some macros
>>> I guess.
>>>
>>>>
>>>>     if (attach.argsz < minsz)
>>>>         return -EINVAL;
>>>>
>>>>     if (attach.flags & (~VFIO_DEVICE_ATTACH_PASID))
>>>>         return -EINVAL;
>>>>
>>>>     if (attach.flags & VFIO_DEVICE_ATTACH_PASID)
>>>>         xend = offsetofend(struct vfio_device_attach_iommufd_pt, pasid);
>>>>
>>>>     if (xend) {
>>>>         if (attach.argsz < xend)
>>>>             return -EINVAL;

Need to check the future usage of 'xend'. In understanding, 'xend' should
always be offsetofend(struct, the_last_field). A userspace that uses @pasid 
field would set argsz >= offsetofend(struct, pasid), most likely it would
just set argsz==offsetofend(struct, pasid). If so, such userspace would be
failed when running on a kernel that has added new fields behind @pasid.

Say two decades later, we add a new field (say @xyz) to this user struct,
the 'xend' would be updated to be offsetofend(struct, xyz). This 'xend'
would be larger than the argsz provided by the aforementioned userspace.
Hence it would be failed in the above check. To make it work, I'm
considering to make some changes to the code. When argsz < xend, we only
copy extra data with size==argsz-minsz. Just as the below.

	if (xend) {
		unsigned long size;

		if (attach.argsz < xend)
			size = attach.argsz - minsz;
		else
			size = xend - minsz;

		if (copy_from_user((void *)&attach + minsz,
				  (void __user *)arg + minsz, size))
			return -EFAULT;
	}

However, it seems to have another problem. If the userspace that uses
@pasid set the argsz==offsetofend(struct, pasid) - 1, such userspace is
not supposed to work and should be failed by kernel. is it? However, my
above code cannot fail it. :(

Any suggestion about it?

>>>>
>>>>         if (copy_from_user((void *)&attach + minsz,
>>>>                     (void __user *)arg + minsz, xend - minsz))
>>>>             return -EFAULT;
>>>>     }
>>>

-- 
Regards,
Yi Liu

