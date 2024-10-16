Return-Path: <linux-kselftest+bounces-19816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0095D99FF84
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 05:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4D182867ED
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 03:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50DF16F909;
	Wed, 16 Oct 2024 03:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XQTvUQTW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1053915B987;
	Wed, 16 Oct 2024 03:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729049437; cv=fail; b=gljsubzIXN4om14muc/sO+QUiKBPYTbkHi0GFAKuPnUeVaCeD3WjU9LA0VjoZHHlEZWRpyE+SzIMbQ6CmgrITt5/FsJAVf6BeftPUxjkodC83zGugq0Qv3Ij5WKxznCmG/AYd4au5Q5zn4cI2qYmM+p2zpfOWTEr7rEBjMdIL8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729049437; c=relaxed/simple;
	bh=WUxfx1KRDZn56EaN0EMLWvUiY6y6Yd1yr+SAKIdxeTg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EE/MooLmxhiDcHw5AVGNk/4hcDlMT33NEYcrGqqWHtIUuQS+j3K+jm1R7fb0Hdy9Nbnobb0cQEC00aiV9HhHOtyfXYsFweix3+SEA1PJWBhX2erpYcrvZP/uDNoe1XA8I9DqRawlGw2mhBcGXFpjBejJs+Bs5b0uRcG2hSg4YNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XQTvUQTW; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729049436; x=1760585436;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WUxfx1KRDZn56EaN0EMLWvUiY6y6Yd1yr+SAKIdxeTg=;
  b=XQTvUQTWt5Q/4r7itWf8fThSXuhI+CrUw8/wx5OwaSAAQQhn0U34Ypci
   mjviqo56Ce/EeMhsYkvHApz0xqnZuMIKcAkGxaH6+8ISPQU0xXf4/88i9
   oy9siVZdWj4qyb/ONPd6WIXrY4gWBjANs7vvyXo9qRIMvbmZd6m9gQaA6
   lJjxXdsStIc7of80rgnZCjvNgeKZt6WJFtRonGaZoD9FygITf4IPa9pd2
   OHg+RzsKZdrWKoflOTPr5fimFMFiOJFAQFYmcYSFQI6C6IV8lsVqYk7Hw
   ms2l51L7xkqbauht1HLWjJrYkBDFjDbyoHe+FGgYk7stUuTh8afhJpFDM
   w==;
X-CSE-ConnectionGUID: bCdVwbmbSoGJ80scVe+q6Q==
X-CSE-MsgGUID: q+DeWu1fQgG6tDMD2fjAGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28611308"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="28611308"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:30:35 -0700
X-CSE-ConnectionGUID: xNArHigCTLiowD0q6htgkg==
X-CSE-MsgGUID: jseBIrk8R9OYvNFfuKrMlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="78268762"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 20:30:35 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:30:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 20:30:34 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 20:30:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmzP7HBkxSib7XsnH//tcpyjy8Q+9BEIJrX0xoEkA471veMmtJuDjTRYQJLkXpZxG44mZTeXBlq+85phBuKYIzNrZVPL5CL8yWLuJv4+rHFM91lI+K5tBxpeZrAl5rzD7EQQj+AEQ/L48H1AjRq0i59L5bhnnYNOnd9xiHggrEecSV9rZsVQYu6GrbvEE/uyewqKN4qBKljo2Tk5lYQmNUDlPnq/8XAWpy3TsZ2ToWUgQY7hBpu1i84dXkwldyaKA50BGVQuzoIZ8Ek3Oa2BJvdi1vqo+cKOuHtOlG0HzTGc67b00d71FMfZirH958XBrJDHW5mLx3dFWpJfjyUO9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xC6NyslSgla1Zwdt29OLcODOzVELREl/cHyXnzBJLRw=;
 b=nKKilbLLGYOkg7V8jHZwu/IMcizPKFxBDgB/QzRvJqtX78Bw+ByVIZh/rT/0a9NmI79jeq93yYnWcalk6kW7AHgt8ZNh5SrDfFTHG8utYe8EDpqp5rqA6uViigMGXO+mFwxLukvU4fjdzXwLuzjaXBsmmD6BKzKWIeRE3OlmVyPd69n17W3/6Y3M5maOhMhMo0N2TPc9nUHryzGPBvzAS4X3YQZSL3nwNTuQfOpcv6ZlICVR2+4lEXbMJ79jaJmAp9sNoI5TJwwji0wvhRDLTrwNTRCwFplfxAkyI+JElfNihv5nLsIX1q2Sl/oMcVga6TnZ6KRAOrognJJ1Rh3xrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CH0PR11MB5249.namprd11.prod.outlook.com (2603:10b6:610:e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 03:30:31 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 03:30:31 +0000
Message-ID: <e76e4dec-f4d7-4a69-a670-88a2f4e10dd7@intel.com>
Date: Wed, 16 Oct 2024 11:35:05 +0800
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
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20241015102215.05cd16c7.alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0131.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::23) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CH0PR11MB5249:EE_
X-MS-Office365-Filtering-Correlation-Id: 42cce055-9cdb-40d9-e510-08dced92e31f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkJENHhHTmhiMzc1Q0Y4T1lsM0FIUXA5VHBHRG54dVl5NUZteFo0VE5ZSk5G?=
 =?utf-8?B?YnczM3hUdzhFS0N6K0c2WDZSRkRwV0NEanN4WHBQajREYklreTNNK093UEt5?=
 =?utf-8?B?QmNndEgycXc0U2VSSkhuRDhCYjM4azBwc2RZRFlzUkJHNnNlb3JLa0pTU05M?=
 =?utf-8?B?a0RmdXhjNkxDdk9VVHlpelRUZXl4TUQ3RVdvWnNoSW5nb1ZNMi9hT3ovVlJx?=
 =?utf-8?B?b3lMUjNKZW5vZ1BzQ0VGVjd2UjFpTXB1Qkhjb3lXMHhjVlhqb3NNRitHVGJq?=
 =?utf-8?B?ZVoyYmFZeGN0UmJNdlVhcU04QWhVbHBvWWZmTWcvOXFLaTk0N1JMbC9iR3hL?=
 =?utf-8?B?c01NcXdBZVo4WDB1bnNJVkpCQ0xONTFVL0J1Q2VlR0hvT2FVcXBSeDJWUjlp?=
 =?utf-8?B?RkUxSGpRWjVlb3QxUmUvcUxGZVV5SUNsY0VNaVVXVEVlVHU2U3B3WGJQNXla?=
 =?utf-8?B?UzJQd1YwZHJpSUlheTQ3b3YwUGFIeE40K3pMaFFXNHNvOUZHNXZSMmVQaldJ?=
 =?utf-8?B?R1dwWE9DWnkwRXExbThKZzcveFNBcFpUUUtQUkNIQTNYUjRycFFVdjJkS1ZO?=
 =?utf-8?B?K1ZrUk03K2lyWGJHL0xaMkZBUEwwZzlndzBxRzRUNnRxWEFlVTFjRGdwZEVs?=
 =?utf-8?B?bkFVRHAyNnk0S01NNndHamJ0WlJvNERoV1FnOWZpUUdzRWs5RE9sY29IVWhw?=
 =?utf-8?B?NzV3MXkweDN2WDluRm1uOTBReFBmb0l6aG5KRi9xN2UrNk9rRVZxeHhwM05h?=
 =?utf-8?B?cTVpLytwTU5iNDJuN1hWdTR1VlVZSHdVRFhXeitkbDNGNFFkUVl2b3Q5RmRz?=
 =?utf-8?B?blFYZHBrS0ZmRlVTVm5ZeEo0ekdzdUd2WERHRTF6Rm9LNFhkQ1JEc1FaQk5n?=
 =?utf-8?B?OXlDdmExb2JKaFpDcXBQR2ordVlXNUF4bEcyL2ZpU2oxUnJsL1c5Nmk1YnBN?=
 =?utf-8?B?Y0NaWFJWQ3hkV3VUNFpJdXJSdWpQaWJ4aXk4eVlPTHU4dVNyOEROc1Y3RzBm?=
 =?utf-8?B?bm9hOUMzLzVVRHNRVjlYdHJoaGpEcEp0bXdpK2libHduazFtV2dqcC9zbDVC?=
 =?utf-8?B?WHhqTTEzVTJjWkVoeGV5N3FBQmZoVzI2QTJ6RnJmNDliSkcyV210Ni9mbmgy?=
 =?utf-8?B?K203VTBZWW1ZeEZZZm5pbklmYWliaW9jU1NTdzcwUDlib2cwamNJR2kweWF5?=
 =?utf-8?B?anlYOU1OVm1qOGIrM2RnclZleTlOckllVDNiZnJVdWZyK3dmWXNyVGcya3Jv?=
 =?utf-8?B?KzJCRzVxZzB3TlBmUHpFMHlBUUs5VmI2dFJsWjNLbmg4NTJ2Ukh3MmlqQnFR?=
 =?utf-8?B?ZGh0UDd2a1J3Q1hmbGZqTFFyMWRaVnVHN2FYUGZzZUsyS1FOZUJWanQ4cXFx?=
 =?utf-8?B?YTQrMEVjblhpK2lHS0pqNmtCVEhHYWt6VDJpb1F6ZnRrSEJ1a2xsTzBoSEFq?=
 =?utf-8?B?NHRVZmswQ0FneDVudWJjc2V0cys1b3JvbDYyRUJvTGJkb3ZLWnZMZ3RRTE14?=
 =?utf-8?B?bzF4QnBrMzk1RGFiNmhVMUszMjBiRTZKOTdIRm9mQm80enAvMERJeFRvVWE5?=
 =?utf-8?B?L2JVSXJKL0pQMEpYcE00RWRCYis4VmVtbzllQ1F0VGRGWUJJMnFjVlRuQzUx?=
 =?utf-8?B?NWlXREo4Y3BkYWxLZHZxMGJJUy8xTFc2Y0xUZlIxY1ZtekFvNjROb1FJWmNW?=
 =?utf-8?B?VlBzSmliMHVNY0x2V1ZvaThkd1UxWFZlL0p1Tjdaa1ZyNVllcFN6QXdnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGVYV0YwQitRSFIxMHc2NFRxZmV3MzV1bnBZTFV4cnZsRDhNMmxha2QwYW5q?=
 =?utf-8?B?OWsyR3dyS0dtQWhCeER2aGVDVU1MTDZkY1NmVW5jNTJjekZBWjlSMU5hUnVS?=
 =?utf-8?B?bS9MR1FKVkc2RjQ5UGV6UVZVSVNvUTlVUEx4bmJETk9raU01N3VRRXpyMTJK?=
 =?utf-8?B?dGZ0dFlzUkx3cHhqNmh1TVUwWEJEZUpVSW9HaVBxU3pOWllvWkZYZWE5T3VI?=
 =?utf-8?B?NUExSUljSGgvQ2djV0NJT01xMFhoUkdGZWlMcG9ibENUWVBPQ2NUWnJpT0hk?=
 =?utf-8?B?NE1nQ2tLaE96bXBNb2RJUGsyQit3MTArdWpwVTNmRHlWUEoxN2ZWMGV0N2Ny?=
 =?utf-8?B?K0Q4Uzdid1BnQ0htY29RdUpHMEZWNkRZQ29TTm42amFXdmIvS3FzRlNMK3Rz?=
 =?utf-8?B?OWg5dm5yS09xSUg1Y2xiTXkrYnN2dm85UXJrZllHNlJBczNkZ0M3ZGdocUpz?=
 =?utf-8?B?bjc4M2I0TldwaFhsZVlhMEgvdFIwb1ZXMFJHWW40aVFDYTJnaVFGWjBXVGpE?=
 =?utf-8?B?dzdXRm0wcGZZcnVNOGlIMElpTFR0VlVjU0k1QlV5Z0U3bkxOYklyeVFCclEw?=
 =?utf-8?B?Z0tKSnlIajRST1N2ZjE1SEJMbFg3NVlOZm9yR3drQis1ZWxwQVFaU0hRait1?=
 =?utf-8?B?ZiszRmZpM1R4ZmN6S1RCV1hCK1hBWC9pUVNxRXVmUXZvNG5yM1p3M214R0c1?=
 =?utf-8?B?SWlhRVNNcmtxSW5Da0ptTXJ3dTAzUU56MWdYSnNWTU1lQ0lXMkcyMURDSUJI?=
 =?utf-8?B?ZFFTUThzeWJIV01udFJ2TEZGVDBnUGtTaWZIZHJxZmtSZWMxMnJUU1pKT01Q?=
 =?utf-8?B?dXZhNEhEQzhpZEFaS3pzV2hJQzc3QktHa1R4Q2pOT1JIYktTQys2YTlrNXJQ?=
 =?utf-8?B?bk5LQ0hpbCtMdFQ5Zjk0QjZDQW5veFJzMWE4bUV5allQbmtWMGhHaHI0U3lo?=
 =?utf-8?B?Q2Z5VmtUbExiS2FPZWxIeStNN1JFMkQxQ3JVbnB1RkxHSG82M1F0M3ptZ2JY?=
 =?utf-8?B?NzVqN0hObEVwWHhQOVFqdlpiMHg5QlBQTVlkZTBIUnpBdDdOcWlJNU1JYm9j?=
 =?utf-8?B?SWhsYk9sdlJZR2dHR3VEV2J0YnlKRmhRUWRIVEs5SWlNRmxLVjhzeE4weWF3?=
 =?utf-8?B?SExudUpuRDdWWS9IK0NOdzgweVRKNGd4MmlIdUVZNzBEaHo5R3FNR2VZVk9w?=
 =?utf-8?B?TCtxcHN4YWZjYWUzOUc1S0NaZDV2b0lBSWlqZ2diK05XVTU2a2dpVDcyRXJJ?=
 =?utf-8?B?WmpTRXFNcjFiQkh4MHV6OC9CV3FkanE0eHhvOHVKSUpiRElQRG1EVmNwSmVi?=
 =?utf-8?B?RHVpUjgxeHk3S0pTaXY0cjM5eTBxVldFSVF2Vjg2bkpVQzNGUVNvNlJmaXl3?=
 =?utf-8?B?dDl3UXRUTFdDK25TcFEwNlM4S1U2Y2VYWnBnK2lhRXVEOFVQS3VyVmFPZ0pO?=
 =?utf-8?B?OU9zK0YxaCthUTQ1Q1Jzd0hwc21hSzNwS093NVh0NEpvWXVtY2VmZC92OHFl?=
 =?utf-8?B?MENtVzZWeDh0ZlhiQzBKbjJSRmY3QThCQU9lUGNHa0lrRVZOcS92Z0Rjd3RN?=
 =?utf-8?B?czNHbjdUc1A5WDkxakxEeWdlRk1FWFh5RnQ0L3kvc1V2dnc5YkRYOXRobTdK?=
 =?utf-8?B?RDM5dDFKeUpHMU9BekRLMW9CWVdlNUFWZ1VNNzlvUjE1bEhYZFpxS1RIOEp0?=
 =?utf-8?B?ajY2VnYwT0c2N20wUUZSTDl0TWpTSFNRZEE3QUlqb3ZTZGttcU1Ga1dYZGZ4?=
 =?utf-8?B?WnFHdDRJUzI4b05UTHIwTU5xR2c3WlBNajdVUmI2c0NWc0hoc0RGQ05teHpP?=
 =?utf-8?B?TjhhMVpVN3Q5MmhVRGg5TWxKUXFmUEdrNjcxUFdXTDlVQXQrOVlyS0JrbnJN?=
 =?utf-8?B?QlpzVjAvcm02L0lUaHJZL3ppbTIzQURxcHlZMzJCbXFEZGh2UU4wbHQvUkFK?=
 =?utf-8?B?QUtsTCtlNU5BRjJHTXo0ZEh5TFNydmZja2lvVExxYjBFVVRWV3NreDdhanZS?=
 =?utf-8?B?VXp2WHVkKzl1ek1GTE9HZlNwaXRlZEFkZEROQ1lhcElONlRXLzJIdjV2YkNI?=
 =?utf-8?B?YTM1b1d1MjBjbkIrdmpvdXRLai94bHpmVlNaa2FlK2dLUUlYbEd5Y1dlUzha?=
 =?utf-8?Q?6cjDawVnq17w32+LY409TJHdo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42cce055-9cdb-40d9-e510-08dced92e31f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 03:30:31.4381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kvJl0MxA20+hCjf40a1vpYnuJOMM5/fFl3Es49RRH82YK7+E5zsZ7yxad5PrLE5FRURon8+bRHsgQlc6wwGfAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5249
X-OriginatorOrg: intel.com

On 2024/10/16 00:22, Alex Williamson wrote:
> On Tue, 15 Oct 2024 19:07:52 +0800
> Yi Liu <yi.l.liu@intel.com> wrote:
> 
>> On 2024/10/14 23:49, Alex Williamson wrote:
>>> On Sat, 12 Oct 2024 21:49:05 +0800
>>> Yi Liu <yi.l.liu@intel.com> wrote:
>>>    
>>>> On 2024/10/1 20:11, Jason Gunthorpe wrote:
>>>>> On Mon, Sep 30, 2024 at 07:55:08AM +0000, Tian, Kevin wrote:
>>>>>       
>>>>>>> +struct vfio_device_pasid_attach_iommufd_pt {
>>>>>>> +	__u32	argsz;
>>>>>>> +	__u32	flags;
>>>>>>> +	__u32	pasid;
>>>>>>> +	__u32	pt_id;
>>>>>>> +};
>>>>>>> +
>>>>>>> +#define VFIO_DEVICE_PASID_ATTACH_IOMMUFD_PT	_IO(VFIO_TYPE,
>>>>>>> VFIO_BASE + 21)
>>>>>>
>>>>>> Not sure whether this was discussed before. Does it make sense
>>>>>> to reuse the existing VFIO_DEVICE_ATTACH_IOMMUFD_PT
>>>>>> by introducing a new pasid field and a new flag bit?
>>>>>
>>>>> Maybe? I don't have a strong feeling either way.
>>>>>
>>>>> There is somewhat less code if you reuse the ioctl at least
>>>>
>>>> I had a rough memory that I was suggested to add a separate ioctl for
>>>> PASID. Let's see Alex's opinion.
>>>
>>> I don't recall any previous arguments for separate ioctls, but it seems
>>> to make a lot of sense to me to extend the existing ioctls with a flag
>>> to indicate pasid cscope and id.  Thanks,
>>
>> thanks for the confirmation. How about the below?
>>
>> diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
>> index bb1817bd4ff3..c78533bce3c6 100644
>> --- a/drivers/vfio/device_cdev.c
>> +++ b/drivers/vfio/device_cdev.c
>> @@ -162,21 +162,34 @@ void vfio_df_unbind_iommufd(struct vfio_device_file *df)
>>    int vfio_df_ioctl_attach_pt(struct vfio_device_file *df,
>>    			    struct vfio_device_attach_iommufd_pt __user *arg)
>>    {
>> -	struct vfio_device *device = df->device;
>> +	unsigned long minsz = offsetofend(
>> +			struct vfio_device_attach_iommufd_pt, pt_id);
>>    	struct vfio_device_attach_iommufd_pt attach;
>> -	unsigned long minsz;
>> +	struct vfio_device *device = df->device;
>> +	u32 user_size;
>>    	int ret;
>>
>> -	minsz = offsetofend(struct vfio_device_attach_iommufd_pt, pt_id);
>> +	ret = get_user(user_size, (u32 __user *)arg);
>> +	if (ret)
>> +		return ret;
>>
>> -	if (copy_from_user(&attach, arg, minsz))
>> -		return -EFAULT;
>> +	ret = copy_struct_from_user(&attach, sizeof(attach), arg, user_size);
>> +	if (ret)
>> +		return ret;
> 
> I think this could break current users. 

not quite get here. My understanding is as the below:

If the current user (compiled with the existing uapi struct), it will
provide less data that the new kernel knows. The copy_struct_from_user()
would zero the trailing bytes. And such user won't set the new flag, so
it should be fine.

So to me, the trailing bytes concern comes when user is compiled with the
new uapi struct but running on an eld kernel (say <= 6.12).But the eld
kernel uses copy_from_user(), so even there is non-zero trailing bytes in
the user buffer, the eld kernel just ignores them. So this seems not an
issue to me so far.

> For better or worse, we don't
> currently have any requirements for the remainder of the user buffer,
> whereas copy_struct_from_user() returns an error for non-zero trailing
> bytes.

This seems to be a general requirement when using copy_struct_from_user().
User needs to zero the fields that it does not intend to use. If there is
no such requirement for user, then the trailing bytes can be a concern in
the future but not this time as the existing kernel uses copy_from_user().

> I think we need to monotonically increase the structure size,
> but maybe something more like below, using flags.  The expectation
> would be that if we add another flag that extends the structure, we'd
> test that flag after PASID and clobber xend to a new value further into
> the new structure.  We'd also add that flag to the flags mask, but we'd
> share the copy code.

agree, this share code might be needed for other path as well. Some macros
I guess.

> 
> 	if (attach.argsz < minsz)
> 		return -EINVAL;
> 
> 	if (attach.flags & (~VFIO_DEVICE_ATTACH_PASID))
> 		return -EINVAL;
> 
> 	if (attach.flags & VFIO_DEVICE_ATTACH_PASID)
> 		xend = offsetofend(struct vfio_device_attach_iommufd_pt, pasid);
> 
> 	if (xend) {
> 		if (attach.argsz < xend)
> 			return -EINVAL;
> 	
> 		if (copy_from_user((void *)&attach + minsz,
> 				    (void __user *)arg + minsz, xend - minsz))
> 			return -EFAULT;
> 	}

I think it might need to zero the trailing bytes if the user does not set
the extended flag. is it?

> Maybe there are still more elegant options available.
> 
> We also generally try to label flags with FLAGS in the name, but it
> does get rather unwieldy, so I'm open to suggestions.  Thanks,

There is already examples that new field added to a kernel-to-user uapi
struct like the vfio_region_info::cap_offset and
vfio_device_info::cap_offset. But it might be a little bit different
with the case we face here as it's user-to-kernel struct. It's a time for
you to set a rule for such extensions. :)

-- 
Regards,
Yi Liu

