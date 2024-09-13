Return-Path: <linux-kselftest+bounces-17937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B80977F3B
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 14:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9BD1C21CFB
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 12:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203FA1D88AA;
	Fri, 13 Sep 2024 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T09RGikh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850101BFDF6
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Sep 2024 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229204; cv=fail; b=gc4lkMwiOb5WrkRWV8JF71UaR8xzunn3PlmOFxysD8KsgxmYPgqU4ZcbI4MheW3BLVGfnB739o8wGZX2MMY3sySVVcHi5olepCXDXfhTZonBD6Wpw350Oud1LXv3atnmX77jUbTt2G+OEGrqZwlOUun1CAeCK1XDcYYJmzgNPzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229204; c=relaxed/simple;
	bh=+vKXxQtp7dEnuACxH7AcCUX8yhZghNgyKdaMUrTdhfw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vmfo6bSssW9U86FzmfIqnF3EdII7PJPSbo6ORXBCiiAm6CnGhbMHBCC05JnAWXWYpBgd0/Xp/bKEQ0XPkGsPqXSA2bVY2hvbG2QhebfNJiZ03s5JI6gxdcGNL0JFP90dO5dkUc77H+ukxCfDrYauustul6Y4WOEHcikN+G+nNbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T09RGikh; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726229203; x=1757765203;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+vKXxQtp7dEnuACxH7AcCUX8yhZghNgyKdaMUrTdhfw=;
  b=T09RGikhiDncWg3Fhx7/FgqEJg/nhrdafqjddAzmU2hFzFSK7CRWBhdj
   gWeKuwV5sFpjAwT6ppk4OcXN7Qqk4XkHzGeQNuIEox3JHl5xSiDGLE3Em
   XmrR7ptrLSiyqF4POxrhv4pyw6Jw49B/pjr6HBUNipJMo8WyCyr+dUM9p
   hVlaYPiIXScu6IVDoB25vQpXz6Bn0HTEl/kbhysI8isu9bPlzA/iWJPhE
   9U2lcjV1MjScr9dI9NJPJEbJQRSbZpxfrv/55xRt6KOco+/rV2rDe9kBI
   yRrT1lgx2jJhC97umXi2RWgxb88A7Tq/5sLKb/BzeVqttU5AYb2tVX7ST
   Q==;
X-CSE-ConnectionGUID: GSSaWynHSm62nrQGQRkNEA==
X-CSE-MsgGUID: bWmOR+feRtih8IMU9wbOBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="25277967"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="25277967"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 05:06:42 -0700
X-CSE-ConnectionGUID: c8J/QDqrR7iiLYTF8YM0Fg==
X-CSE-MsgGUID: CM005RV9S4uNBOrfN+DmiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="67976767"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 05:06:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 05:06:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 05:06:41 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 05:06:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSjtGPuiAUbHh0FCrdk+Vco/Sb7KYpVjoxn7sVTIAn/+2p8PSrjfPbuOfGb3/Ft0G7+j2uW1VnTZkbkTiZI9u7Ac/uRyhsDNsme5TpVUzl+cR7146cNPv6NpTu//QY2M2ynkRcsdTWntCOSrB2wm5V3764nRJSVqcX9DAUJjTrxLoy7lHY5r8uR3GcvtSlzSZIywLWiy+bn2+Yf1ozFF/imbdQsw7D981f5wD5m+iLq3m8uiXn8zk28F92hxNUTFm9fZIUiUH4t3E9Yp4r/W+NL5rbL9EtCgs2w+tYBLcrCBy1T17EVgor1zaB20wwefBrlrvzji5WezVlOoSm999w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afHBfsee4ZDNAKv7hT3q0Wicq4XQYYY3xJ+GvvdscGo=;
 b=naPCj43EoY/R7mQv51YeOwr8vOKA0SPPcLXbONCzhRQojm5m6+TrmjnywWPEyzRAQpaiPi8y3dNm7/tu0PCV7EydRUMtQXoMCfDXH90Qg34wkN9OtkSuNLcQrqDEVuz0kpuSndB7NZ3d0n9n/WzwgRox13vAbV02eldPEhATHfbSbB7rYDOS/xXd6VsLlaoB/1hAhTCeZxzAocmtDkOaSWN3Rbk3NPAfKg0Sc6J/GVjeQE2zvCf8tY9O1N6dg/QLVphWFznpC9hXcN/eShJngvl0IF67LAcS993mBn+vr/UedA6/ivHQ5WKPgx8JYhZF14kbz+dNXwemojbbM3FlvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA1PR11MB8319.namprd11.prod.outlook.com (2603:10b6:806:38c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Fri, 13 Sep
 2024 12:06:35 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 12:06:35 +0000
Message-ID: <2b4c29ab-1fcb-474a-9c09-b6be61c04d44@intel.com>
Date: Fri, 13 Sep 2024 20:10:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] iommu/vt-d: Move intel_drain_pasid_prq() into
 intel_pasid_tear_down_entry()
To: Baolu Lu <baolu.lu@linux.intel.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <alex.williamson@redhat.com>, <eric.auger@redhat.com>,
	<nicolinc@nvidia.com>, <chao.p.peng@linux.intel.com>,
	<iommu@lists.linux.dev>, <zhenzhong.duan@intel.com>,
	<linux-kselftest@vger.kernel.org>, <vasant.hegde@amd.com>
References: <20240912130427.10119-1-yi.l.liu@intel.com>
 <20240912130427.10119-3-yi.l.liu@intel.com>
 <5244f1fb-6e25-46f5-a6b6-9509de231374@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <5244f1fb-6e25-46f5-a6b6-9509de231374@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA1PR11MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: 268ac124-1afe-4e87-108e-08dcd3ec8329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckJUT0gyZm03bHZHZndkWUxuQzJyUmc1WFNmcU1NZEF5NjJuZUE2Q2Jza3VL?=
 =?utf-8?B?V2EwUk9tS2JTUkV0WjViWXEzU2pFU3c2RGVYV2kyWjQwMUVieHlyRVlLZkFR?=
 =?utf-8?B?Wnh5TWpoRGpXSHlKNU5HemxwVkh0Rm9CVCsrdkMzRlE0MjVTV0JrNnhUTzZR?=
 =?utf-8?B?OU1EWXJ4cmdnY3A2Y1FOYkJ6bFRZaXdoeEYxSWloVHNUaUltUlpIMUkyalpv?=
 =?utf-8?B?c1djSVI2eG9Ga3FTVEF6VExwWDN3TEpyOE1udnZ2UVF5Ky9ISUJSQWFaM3FY?=
 =?utf-8?B?ZU5DVjg0cUpjWGpKMUtnSkQ0N2s2eFJzK0lQM2ZlSXkvOCtlMUl3c1NuaU9v?=
 =?utf-8?B?Vm1QbzRJRkdpUXhNMkpWaCtzWUxSS2Z1UDRVRmdmSWZaL1hLc0dLdGhiWFpK?=
 =?utf-8?B?OTh3bGJzQnovVUdlanRETEI4TjV3Qm9TMFdJaTlGcEt0Y3locmo2TmRVa0hR?=
 =?utf-8?B?R2xPd0FuR0hCNytOQzdLcWhhWk9VSlU2Nk5zZmFKQ0dzcjd4UlgvYzJCZVo1?=
 =?utf-8?B?QTllajRiQTJEb0c3Z3ZRc3NQQkN2aldjeU9QdzA5eTBrSjEvYXl5bUVTVTUr?=
 =?utf-8?B?clhhWVJEWTVIOVUyVE5oeEN6RlJxR0lOLzAzYlBmNHpaVXhpVU5aTWNvYmRU?=
 =?utf-8?B?RDNaUjZRRWozR0IySTVyY0FJZjhHb3FycDQxK3J6d1crTXZ1c01aSWZaUHU5?=
 =?utf-8?B?OEQ5a1lNWjh2TmtPazJ5a1pPV2ZubmI0M3YrMjdRMmpJLzQ0RGhSeGVVOUVN?=
 =?utf-8?B?VDNLc21WMW5ZWTNxRjEwQXdHK0tkc2VybWJnRzdHcDBmMHM2OHhVOXk0Y1By?=
 =?utf-8?B?YVEwdEdtL1N6WXIzbFliTGlZVWhkVlVDUHAwQnc1cFRLOVJOMERkL1pEa2pw?=
 =?utf-8?B?aWlEdjl5TExJbDBmZmtYM0s1aGQzWHJBckM4Ym0wWU9Fd3h3R1JkUHNLMjk1?=
 =?utf-8?B?REZ0dThFbzA3aWdkT0xIU0s5OVhOMHNFZlZ6Vit0TFVjWmxlbkVRNjJwQkJV?=
 =?utf-8?B?enN6bmFEaHFmSVNXa29vSFJkbFZuQ1BnTWdIbm9sTEhMa1BVYjdvM0FZcmJr?=
 =?utf-8?B?QTl5ZFBEV2tKM1dCMXh1T2ZGZ3luNkdhRGF6K29lV0E2K3AyN29yVjBrRGg5?=
 =?utf-8?B?VjJmUDh0djBSbjJsOU1mVVhBb3hYR1JrSnplNU1kV1RwWkNTODlvMWYyT2tY?=
 =?utf-8?B?cU0vcXp2OTIrK2wvSnJ6WXY5c3RwWm4vbk03MXNCYjNLZDlNS2Rud1BHYjdq?=
 =?utf-8?B?dEhzVi90WmxmZlpISjhrNXAzL0lMcUthUXZJd0FqTHVvZnZKeEwxTGFPTXln?=
 =?utf-8?B?bFVtS0tDT3N1WmJqWmtGK2FLZEM1QW15SG9RVE1MQm13bm5JbFpWWkZTYkZK?=
 =?utf-8?B?L1MvMWNyTXhKdlUraDJaTTkyZ2ZzNE1lT1lyeXB3ejAwOUFCN2MzdmlFK0VG?=
 =?utf-8?B?ZE0wQ0xmbU5EVnpnUjdyUm1NMUE5Q0RXYlVCamwwMlNkZ0JuTGdIcXVZMXQw?=
 =?utf-8?B?NS9RVUpWeVYxcEptNFptUlBoWTRGalRFblprQmFxUzdIUEZzMEt4ZEIyclNT?=
 =?utf-8?B?SHRDN1kwVVVvQnVyYm1pbWhra2VOYW5JQVZYbTNiSCtlLy9CQ3F4SDIvYWgz?=
 =?utf-8?B?aGhyZGZ4RGU0bVpjK3FOY3FPUzFIU1VFQy9TWWZpSTBOTktmcHk1REZkcysw?=
 =?utf-8?B?QXBzdUpKVkRJSkNTRlNVOUV5czhERzRqUHJqWE1TOG9xNTJld0NCdkE5VnVF?=
 =?utf-8?B?cy9sZVVaeEMxMW5oeXJUanREQk82dTBqV01DOVFaRU5ZUG84ZU5NeFNhV2gz?=
 =?utf-8?B?MmI0bVczeXg0Q2ZYNnJXZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SllaOWNPam9FNWRiZ1o1dWJUYU10TGdZWVNmaTExd1c3TzVZWml0cGlYWVg1?=
 =?utf-8?B?MC94T1ZGbDVHTm9KY3VzN1cvSy9XRFZsMy8xaTVLVkFHT3VURnhDd3ZZQW9r?=
 =?utf-8?B?SVRyNHU2bGtwcDhOVWkvUGdpNFBoV0hnRzZCdFo3d3JSSTdmQ1ZOSGJLV1Bk?=
 =?utf-8?B?aFkxcFZ0UjBpam5paEQ4dXkrK0xoYzZTdHJYQlNtTHhwLzY1dDZzNW1uME5B?=
 =?utf-8?B?WkZTVmplSnVtQzZlSTZCQ1A2TE5Gd1RLaTlMN3dkRm1ZNUluUmJ1N0NJeDZi?=
 =?utf-8?B?bEllc3UzbE91bHFpYmJ0c2NzamRLeDRnZ3AzVTVURHIxNmtMRE44TWRSU1J1?=
 =?utf-8?B?ZmQyNG1STFlOQ0t3VEZMTE5GSnZsSFFZUUwzYmt0MlhabVhYZjJrUDRieGow?=
 =?utf-8?B?MUZkNU9uU2JaNWtuU21hU2VDS3pFb2IvU3VRN3hwU0ZiNlF5TnpESDRzMTBy?=
 =?utf-8?B?VmZ4Vm9JaXBGR2x0a3Fyd2lQTlpybGJyTElvcW4rMENrZjM5REt3UWJwV0c3?=
 =?utf-8?B?T1lDVG05eWkray9VNksxcVYrZVgrR3BMd1RMc2lrSzI3dFBIZWR6ZFRteUZr?=
 =?utf-8?B?Z0xaTTU2OGZNYnczSkIwYTB1QXFuVU4zL0dHNFFCTks2YVUxZWlaeW91WXI5?=
 =?utf-8?B?czFkb3B4Q1JCdkYxbXR3NG9GZXNPTnE2MmdWdEE5dVZjeFdnYUthekkrQXZT?=
 =?utf-8?B?d3JkZ2d1UUFJdy81V3BWY0pmTHk1cFp5WUcwTGtOU3h2VTJDSmR1R1RlZnpP?=
 =?utf-8?B?bzJBdCt4U3plMk5DKzVrQ1NrTWwrTzZ2d0dxc0o5NFJTT05ZMzlHNSttbEgv?=
 =?utf-8?B?ZzdRWFhwWGRlMnN2aUx4NURiNzJFSzRYcDRtMDgyYzJDVEFRdWtZUHJFN0h1?=
 =?utf-8?B?V09sai8wNDBEaUcrQ2daZjBWaEtnM3lmN2oyZDIrNURabjhXK3BSbnNGRll5?=
 =?utf-8?B?SHdoZjJzQmVaWXc1YkZqVUxjSjcxTEJnWW42V3psRXNzR0hyb2U5YmRoaU1Q?=
 =?utf-8?B?U2dieHAwVitVYm1GNGhiNmdQRXhneFdCOWIrL2FQRWJTRDFrQ0tEWERrWmYy?=
 =?utf-8?B?dFBmY2tuVFpRVTg0YjFRd0JpV1ZWVFlKRzZoM1k5VHltQUtBdSsxVitqU2Y2?=
 =?utf-8?B?N2Fqdkd0czNvVGJYaDR2MndGL2hXN2tMODk2disxanFSbVhGZEZReVlGYXBp?=
 =?utf-8?B?L1NlTHBPdm0vcTdVQ0lnamNOKzIrR3JrRWNGazZqa0xtdWFKQ1VTRDY4cm9P?=
 =?utf-8?B?T2FWbUw4ZEFHeEZ5NWlJaE1qQlBQcXRMczhHYlBkMER3ZFh3U1AyYTZ5cDRz?=
 =?utf-8?B?ekdSRGRQMTlTbUQ3bHJEVkk3QzFhMjhrVFEvdWV3dzE4alpuVzQ4QnkzV3Bs?=
 =?utf-8?B?OWM4Y3A3Q2Npa3JabHBxWnZnSTBDU21XYkZnSWZJbUdOSVZKTC8wS1c0NS9q?=
 =?utf-8?B?SlN6dWlmSXhwZHBQVmdBakY4NU9HNU5mTGpXdDVncDBlYytQY1RIdXFINmpV?=
 =?utf-8?B?V0lZeFFIM0U3YS9mbVllRDd5QmRxS2R1NnduM2R4TkRxQkxIM0dudGtWZlM3?=
 =?utf-8?B?SGYzemVoSXV5VDVlV2JFWGFKbzA2STdLTjdKSGxsbzM3RXJuaFlVNFJPeWVB?=
 =?utf-8?B?aFlzRU93amRoNW9kRzgwaWREVW9BelNtU3ZYdWptcGpCdzJ0K2RndkozL200?=
 =?utf-8?B?VVVPdHQzWktndGdITW8zelQvUnoyMzNrNmd4YmNoWUNnd3dFQUJBUm5LVGpL?=
 =?utf-8?B?cWpFbW9zTFlwa3FHNEg5WFBUcjBtSVRWWkpYV01manNDNWFJclg4SVVzRFZK?=
 =?utf-8?B?eFFHR1lnaWx3bmlBRm5yMkxiZVg5TjZSWU5nN084ZXdHY0ttL0FUYlZPaHBn?=
 =?utf-8?B?dHRGaHZ3T1JlaS9rZXc4akZzUU1zS3pZa3FzSHo5L1AzcC8wY0tVVUc1V2t2?=
 =?utf-8?B?OUkwZ3pzR2VFdFdtQWlJLzVyaVJ5L1lJKzlUenhraVo5Y0lBRTdRQitXL0d4?=
 =?utf-8?B?ZE9YbGQzUG5uU3lDQU9PZTdzclJmcUx3RGJPazNNZGE2Mk45YWthTDVsVUov?=
 =?utf-8?B?OU5vVXczRDhseTlRYk9vdk0rWTIrNEZBOXhCcmE5bzY5d2ovblVjQzB2LzdO?=
 =?utf-8?Q?OgFk+WiBuOwlWTBDFZXIbg8na?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 268ac124-1afe-4e87-108e-08dcd3ec8329
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 12:06:34.9354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xv4b5WmzapVZGHJx/t9cbX1G0YiuQuyHVPQpIaouZRCRqMOJ9dG8cvHW3fuKtV4xfJGdq2F5fpwfaB6LDOHrwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8319
X-OriginatorOrg: intel.com

On 2024/9/12 21:22, Baolu Lu wrote:
> On 2024/9/12 21:04, Yi Liu wrote:
>> Draining PRQ is mostly conjuncted with pasid teardown, and with more 
>> callers coming,
>> move it into it in the intel_pasid_tear_down_entry(). But there is 
>> scenario that only
>> teardown pasid entry but no PRQ drain, so passing a flag to mark it.
> 
> Is it a reasonable case where PRI needs to be drained but the pasid
> entry won't be torn down? For example, could this happen when a PRI is
> disabled?

in concept, yes. But it seems no more than a debugging method in my
opinion. I cannot map it to a usage so far.

>>
>> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c |  8 ++++----
>>   drivers/iommu/intel/pasid.c | 13 +++++++++++--
>>   drivers/iommu/intel/pasid.h |  8 +++++---
>>   drivers/iommu/intel/svm.c   |  3 ++-
>>   4 files changed, 22 insertions(+), 10 deletions(-)
> 
> Thanks,
> baolu

-- 
Regards,
Yi Liu

