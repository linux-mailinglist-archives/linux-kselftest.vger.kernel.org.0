Return-Path: <linux-kselftest+bounces-17936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F67D977F18
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 14:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8649288282
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 12:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AAD19CC34;
	Fri, 13 Sep 2024 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CTfFgMfH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A22153BC7
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Sep 2024 12:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228828; cv=fail; b=V5qcvYLjLnTFKln9DrLJA+ytRpF9WgNgRgtJ+fDK4iZxxCeae6fRvUBl10nswB3FeGLirCDTK7E0CIQH6HeTMT4/BSVLKcpJmMlnmtM18ZL3RaXhbznQpOUPm4g5CXi2aPymC50Fnm0D/9ie32plsthuS3vmVW03Rby/Ctu6zRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228828; c=relaxed/simple;
	bh=zLgKS800Tm2pzP0Kk7OyzS5gP11yX7sJhaakT6IQEug=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KDtkFgr5YoFaUIthBgNJdL2EVXfeXeu97Br7D0WSMXovC7kH58DSfh1ymzUUftSDYsKi4A3Erdq0l+SCVldFYrLw4LecLrlfZN/r5SElxAOoc6dkSoBBprGQ6tVxhNCbnh93sI8Q2zx+5AIhUQSoK1bDry1mXv7ivwlsofKt32g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CTfFgMfH; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726228826; x=1757764826;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zLgKS800Tm2pzP0Kk7OyzS5gP11yX7sJhaakT6IQEug=;
  b=CTfFgMfHN0fxjhqg5VXrBNxXrJWTAyxdpOsCIycKQ5KxQXlRNgjh6E5A
   t8YRB+eI41iZMTrmQZtxjmbrcXdFQ/hXxU+XkC/juPvpbxgJxKwzoSanQ
   6ec1rhI5bxhQUWd/M10fMH9SUQwIUuJfr9H3pT+fE1Ex1zh1DHbuqxHfW
   1VHAjcQHeOsMHskujzjW2ybOXLpzNja0/2+E8pVE1KYrllvqf8WJFvzCk
   k7MTRe3b/aHIOvLebNmrLjCbQEFVHhEo8tN9FyEHWQkoV9AlVY6oEpZYk
   +1T+ctxYU/W70m65NJQvhnaddquIoRhkAvoI+U3XTi7GkzKigrzMFx+Nq
   w==;
X-CSE-ConnectionGUID: M78LCqWnQuCTCEYmkOb9EQ==
X-CSE-MsgGUID: p4LAeqGNSuS+Gk8z4hbHbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="25276979"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="25276979"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 05:00:25 -0700
X-CSE-ConnectionGUID: ixczgIcFQV2mUpL6ylhdUg==
X-CSE-MsgGUID: MLJzeRLETAiOc8lOG2mrkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="67973158"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 05:00:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 05:00:24 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 05:00:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 05:00:24 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 05:00:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRDsT7+bSvZXHMmoahsW4x8BKYydzWhKkjSvsKcUNhHiJ9/Zwa1G0y7USe64yYl3O+3u3Sa+rTkiy3f7vvQ0tS+RrWyvN4YLDwFNadbOrYgaHJwaLf/q6Bu7gw7hhmcR5htDI2ILs2lf7BmPuP+Oz+arc4b0GDOksx6IMiuHj0dWnLw5ES1+yJHZ5cswUGgKCTKFv+VO6m/ZbJl2oBlJgF/5ie09pzHpfBae4dn4GykP0yzORJ9UWCkf3YK8i/dDqSPE6jk7C56hgL6MY34DXYqmMKktG7u5IFO9Mb8buZFHzNUf2hvsk8dtdMXD3kcjvrxco6WsjLjyd26xC8lwbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6K9jc3l3LyXnbKIdiIxNDxieL9HYAFodW2vJC9ffNg=;
 b=nLANam/76U6bInWTKaEiyvZ0YONQKHw8flAMaSqDW6Ylf22kZsyv2qRRbrOCmdM5FzR6Agatg5j8i7gSrII1keiwKLzaloc9TEO75U3uPn9ffr7VJdfIeBcqTiQLwn3t4HY+f1MuSm/K6TJN7UVgfJXtAhEzu1QvcsJFzTPqhgVEDcEUEZOaZFuV+PHl4Zw6pvPA3OGCR8gr54/UVT9iT4LjkWa/LSnlD3CXRyKEk/BaLpQ3Z6rTVol1QQdLWhtFSvajWlNKMLFTgF1Iaa89He8XN12K2y4kWJDwRKdVTZoS/gau5kIeTu4DVDezPkxVsfSztu0jVnl9lbUe+C02qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CO1PR11MB4884.namprd11.prod.outlook.com (2603:10b6:303:6c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 12:00:21 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 12:00:21 +0000
Message-ID: <c0294acf-d34b-454c-8464-3de386ef3a56@intel.com>
Date: Fri, 13 Sep 2024 20:04:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] iommu: Introduce a replace API for device pasid
To: Baolu Lu <baolu.lu@linux.intel.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <alex.williamson@redhat.com>, <eric.auger@redhat.com>,
	<nicolinc@nvidia.com>, <chao.p.peng@linux.intel.com>,
	<iommu@lists.linux.dev>, <zhenzhong.duan@intel.com>,
	<linux-kselftest@vger.kernel.org>, <vasant.hegde@amd.com>
References: <20240912131255.13305-1-yi.l.liu@intel.com>
 <20240912131255.13305-2-yi.l.liu@intel.com>
 <881fd7d0-dd9e-4d9d-9529-c9ff03088351@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <881fd7d0-dd9e-4d9d-9529-c9ff03088351@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:3:18::34) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CO1PR11MB4884:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c9e9597-f2c5-429c-4bb6-08dcd3eba449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rk12cFZlMmNYai9QNjY5eE9iZTJQTXFlbjJKVU9iUU9XdTVIK09Id0I1WWln?=
 =?utf-8?B?UU80VHRkbnRhcElxbXFSYWZwRjdVWG1CSHMwdmo2TWUxN0VpQTdEQy9PaXB1?=
 =?utf-8?B?cWN1cVZaMFFiQmdCNWw0S3hrRVhKTG9FejNuY0h2OVlyOWNVanJSZGZvS2lr?=
 =?utf-8?B?MVRxWGVkRk05SlYwK0lHQkNHOGo3Uzg4QjBuOWUwUVdiWnBiWUlNZEYvUWIw?=
 =?utf-8?B?RFFFbXltODZQZXZQVnZZVzl0Y0ZXTGp4bTFsTWJjTXhpYVNIVXNaaHJMSjU0?=
 =?utf-8?B?UlJ3enc1MWRKZWJCcUVxN2swYm1OMG82amhzc3FyS3FCb1RVRXR5U2tvVk5h?=
 =?utf-8?B?QmFIQUQxRXZvUDl3M3BuQ241cUZEQWtwTjVKdWlqRmNzU2QzUVEyNHdIUG5u?=
 =?utf-8?B?ZTdVNStnc2R6T01xSUd0V2RpbGlBOU0rUGRTMlQ4MVU3bXRadjdkQS9JZVdw?=
 =?utf-8?B?S3J0MG9RQXFqZGxiOTBvbEw3SUNKMGpMamFaaVVGN2FUMVErRUN2dU1yNGxJ?=
 =?utf-8?B?ZFhGc0RQTHcvMUZWcTd2MVdLMi8vb25JcnFFY0VFMFhVTWdDTFRyeUFFaHA4?=
 =?utf-8?B?bC90YmNnbjNQL3BBTmZXM3h5WTNjNzN3MkxrclZhQ1dyT3AwaWx2TStGejlh?=
 =?utf-8?B?MzdQSUtBZDlIQ1VhRVg1V3p4UjVMZzBGck9QRUNFNSt1RDA1TTVodmw2QldN?=
 =?utf-8?B?TVFPTnl1dkZZSUdneEZMQkF5WmtIUVM4NXNocndQNnNoNE52UTVCNGdCclNK?=
 =?utf-8?B?K1lPVWNqeXRPOGVDVndZM2dnNldjdkdJWkVIOXdDK0RFazlSV2s3YmNaYUU1?=
 =?utf-8?B?TEkrUTdUMjYyYk9ZZ1RSR3g2YU9FTVBWS3ZsTGJ2WEVybUNicEVYM1R2ckpH?=
 =?utf-8?B?L3lqN05ONXhETGxmY3hDaTRqM0FIaHFPMDVuc3JqODd0dGRLZGtrbHQrc0xW?=
 =?utf-8?B?WWdLTHFVVmNqQ0ROWEV2SlpoaU5Qczg2MGg3MXlLM2psMTc5WHdkakl6cWNy?=
 =?utf-8?B?UFJUVTdkUlFEbkhXL3NjcmhsMmNyY1dPUjNoWlFrMGdRandRckRtbm1wR1h0?=
 =?utf-8?B?akZTTitHNGU5S28xR1psSWxIRDVRY0JGWGZkWmRMTHBzMlNVTzZ3L1kvREp1?=
 =?utf-8?B?em1sZUtJdGcwSTZxcjZTM1lDMUlFL3ZrSDZhV2xSSWROcWdPRE1nUW10SURT?=
 =?utf-8?B?Wk1iMEpDY1lseVF6dmk5bkhGYWJxNUlWMHJ4MFNtTzB2Z3Z6WG5PNU5OSXgr?=
 =?utf-8?B?TFNzcDArVjkzcCtUd25lcExlTFh5OWNubktDZmYwQ3JGYkw3WFNCSzV0RFlv?=
 =?utf-8?B?WHBUWWN2NERJNkREdXNhRjBHVTkydXIzT3ozQi94TnpYQ2s2WTNJL3RIRm1H?=
 =?utf-8?B?UXNERmZYT0VrdVJCTlBUYjljWGxBY0tIOWNwTEt4YWNNOHR6cEtEQ3F1U3ow?=
 =?utf-8?B?QmpkcEZCcis3OFNEdmt1YUk0d0JaRFlHYXA5UmQyVUJmam1vaVFUaU5DcjVm?=
 =?utf-8?B?WmxMbXoyeE84U1pzZjFDYlZBVGpkcndqQjFqZEFNTnVBSk5JZEpTN3BwV2xT?=
 =?utf-8?B?MUw2UmdIT0JiZXAwVmM3UEZHR0ZNaldGZDFHWU5VS2FtUWVuSzJVRnUwNm1n?=
 =?utf-8?B?ZjNyV29nMGdacS9qeE9tS090Vlg5U25ZeUh1NW9FZ1BGTGJxRkpBanIvb3JO?=
 =?utf-8?B?azBKenh0WW5vbFdSODYvR1h3bWdheVVsTUhtTjNtV3dRRC82UG5KNU0zQnVK?=
 =?utf-8?B?ankwblkrR3JFY3lvVlpYdlFuRVpBaUFsRDVLcTJnc1NLRnZjM3ZXdGdaenhI?=
 =?utf-8?Q?mM3+JPt/mA/smWakY4ZZa0AHGuLyUSV4V6dEs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWt3ajluZnRuL0pCK3Q1VHJVK0gva3NLV0w5Q3BmaGp2Z2RSVFkxczd5OU1N?=
 =?utf-8?B?b0NiNzBoMmhxaUhNUkFoR3BLdWkyQWhObmhGUDNWc2FCSEVYemRhZGNqaDc4?=
 =?utf-8?B?SVR0K3RWWjYwM3RoaUFua2Q5YzhiTWl4dlhxYTV0VGlUVW5RM0NZT0EvWWFI?=
 =?utf-8?B?czNIc1FEdFdUTkxOZmIyTXNFOE1Tb2RCY0x2WjVKUS9HdG1vVCtHSE96aTFa?=
 =?utf-8?B?YjJuRk96aVVzMWk3aGZpQm91SDBzWWhJM2YvMktzN3NSdHNmWitNbDhkNWlZ?=
 =?utf-8?B?WjdDQW1BdWw5V3MyMzQvVjgyUnVlN0lTTUVXRUorTXVieGkwS1JuS0hQYjdT?=
 =?utf-8?B?bFYyYUtrRmwvZEg1aENEbW9UeWpBOU5wRjFueXlDSXFPZkVOQksrVHN3QXRn?=
 =?utf-8?B?bC9pR01RdDhlSDQyaG9jVWxYb0tBejloK2hhK0JEWENWVk1FTzBGcGNrSm9t?=
 =?utf-8?B?MldIeXk3WlJ2QXBWS0Y2UVNkYlkwUlVuR1p6ZXdGaHhhYW5ENTczQTRobStN?=
 =?utf-8?B?cGI1cjdzWTF3WE5MWU00R2JLcGNURjlpRXNUL0s0MzhaKzRBMW1yUFRjQkJS?=
 =?utf-8?B?Q280eUlzUHB3bUNHUkRqRDhmYWVjV1dOUC8rZWVhb3NIQWo2b0VpdUE3ZXd4?=
 =?utf-8?B?bW0yRmJUM3diTGNyRjBCRi9OcyszVEtQeDd5ZXVaZGVEVFhmYjNyWm8wejU3?=
 =?utf-8?B?UkFkYVNWQmp4WHZ5VUhTVlg4aDlHV2w1NkY3SnZDVGtlUkQxaEg2SWxlNm5Y?=
 =?utf-8?B?VytkUjU0eVprd1VyNEtydzAvMytIbXNXcnhnZldUQjY1RFlYUFdpUDNYb1Q0?=
 =?utf-8?B?aVFkVFNTUU52WkVERDlocGtBbkZVOFluaDFxWGFIYVVXSkZHTHBnQ2dQbzNv?=
 =?utf-8?B?eVZETFZtYUI3TXA3YVpRcjhKOVRoUXo3MEsvck1CZDVXeGo2ZnRvL3hJVkFq?=
 =?utf-8?B?U1NvWXhGeUFCcDR4Wm9nS2FQZFFUQkFBcXJHeEZTNms1ekRackJLbFBDcmRr?=
 =?utf-8?B?Y1lPck52anR2cjEvQ0EvdTBQTUtVLzNTeHppUzhMZkpDLzh0dkZzN2h2Uzl2?=
 =?utf-8?B?RmhEK3g5MytuQmNPdXFybGQrWnI5ajZvMGtQMWU1c1BGTUxrQ1hORzROM0pj?=
 =?utf-8?B?N1pHNFFOTktkSFNNaTMwbEE0ek5xeVNTTjVuaU12YUJRTFlSaDQ5aGtHekFI?=
 =?utf-8?B?K09xOU1lQU05blBqcno3UEE5Yjg3LzNXRjBSS0g3NUdIanVtRnVUSjNhSUV3?=
 =?utf-8?B?OUhaM0VYbEZPMWM5dVhRRERVcnZHUzBHeWFBQ2VCaUo3MjVuWUM5Tmk4WU1s?=
 =?utf-8?B?RnRGUnJtUmZZZU95Q3FKUmxsNXlyTFZOZDBFQjFLM0RYeTAvU05vRXdoKzVi?=
 =?utf-8?B?ajZvTTVzZU9IeGNqWnJXUCtBMEVBUlpkY2VtSFpCWDd0QkdDOU1tczB0OHJB?=
 =?utf-8?B?NHVScFFNVDNLWlR3bytabzBtZkQwZEdqdnRMSTZhM08wdWZFRi96NFd0ZGFy?=
 =?utf-8?B?TzZaNllqanRKWG5MTHVYQ08xTXhJeEtFNWxRaVlEOXluc2gzMXFOSllBQjRp?=
 =?utf-8?B?VDJ1a3licGpVWXhENlI5WitMTWNNc3VlN2NjNzNjMjN6aHFiV3pvSkxWbVh2?=
 =?utf-8?B?aU92enVWdUdNeGVkY1hOSkJJYnRmb2VQb2x1MFFCdlZGYUhwWEdPbE4vaFdK?=
 =?utf-8?B?WUw0YkFSYzEwTThQVTBPNnNuanNxNUpTbHN6cGVDWFhtZGc4dGJwZWI3VkUv?=
 =?utf-8?B?bC9PaURGNEJyZVl3alA4cWV2UXFMQUxBUEExOE0zUEE2Nk9UM2JFVVdiSy9K?=
 =?utf-8?B?anBiVWIzZWkvbkpsN2E5d0lBVzdMcVppRzVaaXFnb0IyUkRUV2l5Vlh4WkUx?=
 =?utf-8?B?UTUyNGNnaFJDZm5zbmRoSXdsOUhGZy9iSVNJdTV5MVhWTEY1QkZRdWU3Yk10?=
 =?utf-8?B?S2pra2piWVV6V1VDaC9TeS96TEpualdCa0lnbWkvTnNmWjJ3RHJ2MU02WVlr?=
 =?utf-8?B?VWYyR2ZQcDlrZHZLNnM4djk4em5DQS9MZ25Cb0xRV0h4RXZDYSs3NmRrTVhO?=
 =?utf-8?B?WVlrOEp4bkN3eWRScEtPSDhRc0Q5ZGJnU2R5bDhoOThQQmRyazRhMGdCVFpY?=
 =?utf-8?Q?WUPZGP9qAwAVcw5JeL8iWgjPr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9e9597-f2c5-429c-4bb6-08dcd3eba449
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 12:00:20.9780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BO08hJg2QFqYZiAM9J1vra1oNRHciAQ3VMlSGjXpmNdF/HTPCLz0GLlOXw83fsmEFDGknNBWq6VJGXCu20Vd0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4884
X-OriginatorOrg: intel.com

On 2024/9/13 10:44, Baolu Lu wrote:
> On 9/12/24 9:12 PM, Yi Liu wrote:
>> Provide a high-level API to allow replacements of one domain with
>> another for specific pasid of a device. This is similar to
>> iommu_group_replace_domain() and it is expected to be used only by
>> IOMMUFD.
>>
>> Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/iommu-priv.h |  4 ++
>>   drivers/iommu/iommu.c      | 90 ++++++++++++++++++++++++++++++++++++--
>>   2 files changed, 90 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
>> index de5b54eaa8bf..90b367de267e 100644
>> --- a/drivers/iommu/iommu-priv.h
>> +++ b/drivers/iommu/iommu-priv.h
>> @@ -27,6 +27,10 @@ static inline const struct iommu_ops 
>> *iommu_fwspec_ops(struct iommu_fwspec *fwsp
>>   int iommu_group_replace_domain(struct iommu_group *group,
>>                      struct iommu_domain *new_domain);
>> +int iommu_replace_device_pasid(struct iommu_domain *domain,
>> +                   struct device *dev, ioasid_t pasid,
>> +                   struct iommu_attach_handle *handle);
>> +
>>   int iommu_device_register_bus(struct iommu_device *iommu,
>>                     const struct iommu_ops *ops,
>>                     const struct bus_type *bus,
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index b6b44b184004..066f659018a5 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -3347,14 +3347,15 @@ static void iommu_remove_dev_pasid(struct device 
>> *dev, ioasid_t pasid,
>>   }
>>   static int __iommu_set_group_pasid(struct iommu_domain *domain,
>> -                   struct iommu_group *group, ioasid_t pasid)
>> +                   struct iommu_group *group, ioasid_t pasid,
>> +                   struct iommu_domain *old)
>>   {
>>       struct group_device *device, *last_gdev;
>>       int ret;
>>       for_each_group_device(group, device) {
>>           ret = domain->ops->set_dev_pasid(domain, device->dev,
>> -                         pasid, NULL);
>> +                         pasid, old);
>>           if (ret)
>>               goto err_revert;
>>       }
>> @@ -3366,7 +3367,20 @@ static int __iommu_set_group_pasid(struct 
>> iommu_domain *domain,
>>       for_each_group_device(group, device) {
>>           if (device == last_gdev)
>>               break;
>> -        iommu_remove_dev_pasid(device->dev, pasid, domain);
>> +        /* If no old domain, undo the succeeded devices/pasid */
>> +        if (!old) {
>> +            iommu_remove_dev_pasid(device->dev, pasid, domain);
>> +            continue;
>> +        }
>> +
>> +        /*
>> +         * Rollback the succeeded devices/pasid to the old domain.
>> +         * And it is a driver bug to fail attaching with a previously
>> +         * good domain.
>> +         */
>> +        if (WARN_ON(old->ops->set_dev_pasid(old, device->dev,
>> +                            pasid, domain)))
>> +            iommu_remove_dev_pasid(device->dev, pasid, domain);
> 
> You want to rollback to the 'old' domain, right? So, %s/domain/old/ ?

this will be invoked if the rollback failed. Since the set_dev_pasid op
would keep the 'old' configure, so at this point, the 'old' domain is 'domain'.

>>       }
>>       return ret;
>>   }
>> @@ -3425,7 +3439,7 @@ int iommu_attach_device_pasid(struct iommu_domain 
>> *domain,
>>       if (ret)
>>           goto out_unlock;
>> -    ret = __iommu_set_group_pasid(domain, group, pasid);
>> +    ret = __iommu_set_group_pasid(domain, group, pasid, NULL);
>>       if (ret)
>>           xa_erase(&group->pasid_array, pasid);
>>   out_unlock:
>> @@ -3434,6 +3448,74 @@ int iommu_attach_device_pasid(struct iommu_domain 
>> *domain,
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
>> +/**
>> + * iommu_replace_device_pasid - Replace the domain that a pasid is 
>> attached to
>> + * @domain: the new iommu domain
>> + * @dev: the attached device.
>> + * @pasid: the pasid of the device.
>> + * @handle: the attach handle.
>> + *
>> + * This API allows the pasid to switch domains. Return 0 on success, or an
>> + * error. The pasid will keep the old configuration if replacement failed.
>> + * This is supposed to be used by iommufd, and iommufd can guarantee that
>> + * both iommu_attach_device_pasid() and iommu_replace_device_pasid() would
>> + * pass in a valid @handle.
>> + */
>> +int iommu_replace_device_pasid(struct iommu_domain *domain,
>> +                   struct device *dev, ioasid_t pasid,
>> +                   struct iommu_attach_handle *handle)
> 
> How about passing the old domain as a parameter?

I suppose it was agreed in the below link.

https://lore.kernel.org/linux-iommu/20240816124707.GZ2032816@nvidia.com/

>> +{
>> +    /* Caller must be a probed driver on dev */
>> +    struct iommu_group *group = dev->iommu_group;
>> +    struct iommu_attach_handle *curr;
>> +    int ret;
>> +
>> +    if (!domain->ops->set_dev_pasid)
>> +        return -EOPNOTSUPP;
>> +
>> +    if (!group)
>> +        return -ENODEV;
>> +
>> +    if (!dev_has_iommu(dev) || dev_iommu_ops(dev) != domain->owner ||
>> +        pasid == IOMMU_NO_PASID || !handle)
> 
> dev_has_iommu() check is duplicate with above if (!group) check.

I was just referring to the iommu_attach_device_pasid(). So both the two
path could drop the dev_has_iommu() check, is it?

> By the way, why do you require a non-NULL attach handle? In the current
> design, attach handles are only used for domains with iopf capability.

yeah, but it looks fine to always pass in an attach handle. The iopf
path would require hwpt->domain->iopf_handler.

>> +        return -EINVAL;
>> +
>> +    handle->domain = domain;
>> +
>> +    mutex_lock(&group->mutex);
>> +    /*
>> +     * The iommu_attach_handle of the pasid becomes inconsistent with the
>> +     * actual handle per the below operation. The concurrent PRI path will
>> +     * deliver the PRQs per the new handle, this does not have a function
>> +     * impact. The PRI path would eventually become consistent when the
>> +     * replacement is done.
>> +     */
>> +    curr = (struct iommu_attach_handle *)xa_store(&group->pasid_array,
>> +                              pasid, handle,
>> +                              GFP_KERNEL);
>> +    if (!curr) {
>> +        xa_erase(&group->pasid_array, pasid);
>> +        ret = -EINVAL;
>> +        goto out_unlock;
>> +    }
> 
> This seems to be broken as explained above. The attach handle is
> currently only for iopf-capable domains.

if attach handle is always passed, then this is not broken. is it?

> If I understand it correctly, you just want the previous attached domain
> here, right? If so, why not just passing it to this helper from callers?

yeah, I'm open about it. :) @Jason, your opinion?

>> +
>> +    ret = xa_err(curr);
>> +    if (ret)
>> +        goto out_unlock;
>> +
>> +    if (curr->domain == domain)
>> +        goto out_unlock;
>> +
>> +    ret = __iommu_set_group_pasid(domain, group, pasid, curr->domain);
>> +    if (ret)
>> +        WARN_ON(handle != xa_store(&group->pasid_array, pasid,
>> +                       curr, GFP_KERNEL));
>> +out_unlock:
>> +    mutex_unlock(&group->mutex);
>> +    return ret;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(iommu_replace_device_pasid, IOMMUFD_INTERNAL);
>> +
>>   /*
>>    * iommu_detach_device_pasid() - Detach the domain from pasid of device
>>    * @domain: the iommu domain.

-- 
Regards,
Yi Liu

