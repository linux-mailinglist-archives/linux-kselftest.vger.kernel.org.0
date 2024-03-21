Return-Path: <linux-kselftest+bounces-6462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEBA885A28
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 14:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE1D1C21384
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 13:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD87E84A5C;
	Thu, 21 Mar 2024 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GGOerKXs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C4D84A58;
	Thu, 21 Mar 2024 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711029288; cv=fail; b=HJuCVgnyJJXZGVr4bMJ0r99aHOt1HiPsDpAJsUPu3dHh4rrOjduWJ5L9fYrIVTU25ZVS62uD8QoQHNQvrjslHJuSnobusRGMB0PVlhfjI9GKEb4fUbBbpIxfiJR0yi+jV2HiuMIUr1gGcUYARZU9c/6ulACp7UdV9uFg8bf7D8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711029288; c=relaxed/simple;
	bh=6hyR9BKhSqEmhrR+xWlZVXvuysFI01d+AfMOHdT8mnk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uBehyQo4NlvnRtcAAlPx2yFKvXEUD4Q3lv4iPHTpde0kpMt7uoy47TK6cqJDBqP/tEJobIPw2v4UkO5L8Eumxd3drjet+Aw2ekxw6r4W/5KLGRHr/p0Qc9lOwpC/EQoXGJR0aI3St7hoZi58T3KM6fDiEb1XnQj2si1nBRTAJrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GGOerKXs; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711029286; x=1742565286;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6hyR9BKhSqEmhrR+xWlZVXvuysFI01d+AfMOHdT8mnk=;
  b=GGOerKXsXa3wd7+18bKuqg+/mFipcBjrW5MgRetP6CgvBJKtN4zcL+z0
   WnNNFyr4ZaN4PrjJG1gf+g8obSi8KDrwQh0rrUtcFXhht6xR6y9/Q5jmZ
   77yFPvoH5esJWSFMJvxsylZOgqtp4cAksGo+120fGdy0FK8Q6HWHJW6L9
   x+EpI1bXwzUaTA5Mb8kgfqJ9qGj9vQKTrUvAhVcKrYgLfhJtqRxiOMUz7
   Ccc7Nel1RNgtahZKG9pLCHYhcdeTcnjTs9wEgK/pr/BUHROtafI3IXD+D
   NoVepeU2rGiXvAQ70eJFDhZswDOuGeRXofKajLtZQAf/y4cRxEdb1KLLs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="9821112"
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="9821112"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:54:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="18985089"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Mar 2024 06:54:46 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Mar 2024 06:54:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Mar 2024 06:54:45 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 06:54:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J994Gydaj3+tW1pG1cSRia2lKFLELH8tzzbJ1B+TbOOkeTKshKTg3zmWHGPPNB0SL2daoJd6h/QN2xIKP9orutblw6zmHg+AwGDTmsqeBAWQEfjU9rFhDKiYllx+vHGaMN+osB5vzs69aJwsJvZv4Zr3BsED5GM9NDCJk/wvRvVu4rm+Slg4Xw8tu1+V5wUI87jP78dJdAmO7lFRPIVkDmCItdaFBtSsks28lryzIgfrdtzb/monH1PWS05lYG1BkLp1Tcfqrlk3RngoU7b6TZgF2UMuHjpUdU3wXoTjp7U8x0otPNsVpmkwJTRplsZWRUD5E6vJeHJBL4kiAPam+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3ArbVBw/ko/7BhxX2ckeMFJhjnCHF3FoAXEgETIkJs=;
 b=YOIFGZbAFC7TszbzK/GOao3B8GlWKMQ/U2uwi4vWC5+SwXZEu6Bbb/0Y9PqxqyAVa2fOtBeINDGYvhgLqqbZ3MFtpeKf9oRmny+fTY+lcl7pE93AhOhMg7v1NAq6E96wDQhr9kZzao4eCljHwh3Ty+bMMv3ZCSeEQ3fPm1fHRAsde3QpvnzyFANm84uNWfgU00zLeKpUJYSxV9t9AJNlzAecPXAUPti8Us7/QWWHCNQjaSj7YniAlEM2mTop6CL/JJ3+fdGtmcPcIsTcUfkKVcVUV8t651AEQMEkybuldn7yAi3Nij8Cd7ANiUCLWlREJ9Arzovk5j1ORlfSRBM6gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB8762.namprd11.prod.outlook.com (2603:10b6:8:1a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Thu, 21 Mar
 2024 13:54:43 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b1f5:9d1f:f510:d54c]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b1f5:9d1f:f510:d54c%3]) with mapi id 15.20.7409.023; Thu, 21 Mar 2024
 13:54:42 +0000
Message-ID: <a477bb58-951c-491a-b4cc-b5cfe9cca646@intel.com>
Date: Thu, 21 Mar 2024 21:58:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] iommu: Introduce a replace API for device pasid
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
References: <c831bf5e-f623-402d-9347-8718987d1610@intel.com>
 <BN9PR11MB52766161477C2540969C83568C242@BN9PR11MB5276.namprd11.prod.outlook.com>
 <585423de-9173-4c97-b596-71e1564d8b4e@intel.com>
 <87a2be0d-6a24-4ca8-be30-35287072dda4@linux.intel.com>
 <749b23c7-ab0e-42b4-9992-e1867fc7d4d7@intel.com>
 <20240318165247.GD5825@nvidia.com>
 <13645a9f-239a-46c9-bde2-a1d5c365df4f@intel.com>
 <20240320123803.GD159172@nvidia.com>
 <65c517a9-72dc-4342-b2f2-c3c44735bfad@intel.com>
 <7a4777dd-2359-4bcd-839e-c2d0b5f6be14@intel.com>
 <20240321122059.GF159172@nvidia.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240321122059.GF159172@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS0PR11MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: 388047f2-0487-47c0-6f5d-08dc49ae7582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zf9XZIX98ZYcQYGjSluPRHI0uZZIrqywSfmW/Dv5lPQ9BXjJg/oEPZaY86My/tOHk39jqXmNvXlKW6GWqz9jSRNCr6da4tvoFAyNqUKehvdOfRXIG4rCkDfM++/btveiCwjFkdNCJabQzuAln6t2kO2msm1jSL/NOH6qwQqKXPOMu7lUL0Sz2G7Gf6/bGZ99wgQNjIgbadEdvBlKdJXrP/Geyexem7rbHupB4zkF0OIgY+6lBRa8uMEwqmKI3WgEdye2MZhWLY1gd/801f1dT9mpN60xAdgG6zprhN55o8VpYtd5sRAyBbpKwKiF802lBiWGq9ThMoPr3ymJdcI9Kzh3KH7AeQqbUOMTd6E4EFWYeWcCO/HyYtl8KJ/Iog0u/q9GV3vYG8w5ZtPBoCDYWdBfTZWl8+/f8ZQJuIL08SlCh2Tu/W7klycf8ytcTK2Kpl9Sr6JI/0rMxVt6Sndra70qa72IcEOiDZX4hBvPdy8xZ7SCLhTvQ0N1bPkrCzkcvbDMA2G85ZkAFZ2ESfOX8kHeccTMPMG/hLZ8IIefw6G1qd6euEL/V11/Jwj5TWd5+Uzj30+FkDKYYwVZSHKJm8Rso1ulOmm4UB78kRTcfOXNttqvm1fZds3i7bA0Cx1aozTEo5dh/b+v2JkzIfhJylNSWqwf+M/XSNYHgAhD6Os=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1IvS0JOcHNFdDB5QVhFRlhGQ3o5Rlo2U3Ztbk14SXpJc2V0L2xqeFh6eUtM?=
 =?utf-8?B?ZzdxZldvT3hMaUlXTUxpNVF3aFJNTWIyVmY2S2hVRWRXSjQySzdTN1I2ZStX?=
 =?utf-8?B?amkva2FOYjhKRkxWS3cwbzk5cDBJS05YQXQ1ZFNWc05LeS9QZlpSb3l5V1dC?=
 =?utf-8?B?Vi9zbC80bzFLeGx6Y08yZHFRL3ZNN1BrM3Rlc1oydHpKUjJWNjRDNkUzcnZW?=
 =?utf-8?B?T2VmT0Z0OW1CdThadkluSWs3d1Q0SFRTZnREVEM1L1RzRHhqY0diSFQ1UzAx?=
 =?utf-8?B?VHRWbm9jRmxMSWdDNjBhS3VvUk5xOVlBVE1NWWVDd3FKbVdFaDBIS0RDLzE3?=
 =?utf-8?B?OG0rSXVydFpVM0piWXd3U3ZwaVdudTBQWnZrUGRGa3E3Q005Nkx4a1BhL0pC?=
 =?utf-8?B?RThBSVMyQWhhalk1dm9XOXp3RDZiZFRXOHAyRjFNMzVtSG94ZjlwTjB1YURV?=
 =?utf-8?B?bFBwakZJd1hhKy9MRWRQcXVvSVJqVkh5NGV2c0NjTkgwSkd0SzlXMUNSMlk2?=
 =?utf-8?B?d2hkblVMcy9WbFZPdzlJd2VFS05zSUJlN2E2dDBnNzZxTjZEU0grY2s4ZGFE?=
 =?utf-8?B?OGcwSGV5cm5GNTdGV0tGM1ZTd2Q1STdQSWptZEt6STdEQWw3SFdVUzFRNVF6?=
 =?utf-8?B?SDRYWVZLczRYV1k1WU4yWnAzZE9ubmxsd0krRDByRmlqSXZDRU5iMEFPSlow?=
 =?utf-8?B?aTcrUlV0UE9jc0czZTg0WGRVdDFUelg5Rnh5T3ViNzZRVTJuTVpzNm5pRUo3?=
 =?utf-8?B?YUxtTzRPSWY3V2lKM0w1eWJJQjM4ZElrSW5qbkhWTnYra2JhRHBERHA5d01a?=
 =?utf-8?B?QnQxbTJCL3Y5cVlIMGptK2xOeGpJQk00Z2pnd2lhZVZaRU01aE9BRm5NTE9T?=
 =?utf-8?B?TmVGRzFZaTNJQ2s5Tkpra21QVjR3Z29jeW82bnJncjlyUi9kZnVEdXYwNkxn?=
 =?utf-8?B?ZnRCVjdqbDBpaDlpbFFPZ01aOVVoNDZVVVFRQ1prMml0K1FBVHh2QXFPOVRY?=
 =?utf-8?B?ZjRGTDB3QnRHU0xwWlg3Y2NUNG5ybm9nbkVGRWlZeHJYaFhzZE1MWExORStm?=
 =?utf-8?B?QkUyeGV6dHp3RWtQcWN0OVhNVUZQNTdlOUdRdk12NWRlS1VNd1JSbUxNVXJX?=
 =?utf-8?B?a3ZqVC9KemV0a1dqS20vY2dId3VOMkRwTUY3d2l3bUxhb3VuK3VSS2lXSmdM?=
 =?utf-8?B?QWhCaGg3aGs2VU92RndTWXVWcWdOaE5ZS1ArUDlzZys4ZnJCNTNhVVpVV2Rq?=
 =?utf-8?B?TXZDMjRzZVM2azRzUGdGSjVxUmUzaUNWYTc4QWM2VVU2VDI5QzNha1BUUXZP?=
 =?utf-8?B?WHZTYW41d2ZoNGpEbmxOYmk5Z21DZ2JHRGl3U2hmaVBjOEFaTTFyOG5PNmZQ?=
 =?utf-8?B?QWhQb0JVYXZ6aVE0bUcwZ3VpTGRuajd5Z0hTdUcreW9sbGV6WlpPTldKRDVZ?=
 =?utf-8?B?Y3J1RUJTd1NCQ0tRVnRuRGg1TGF5a2xXYkM3OVdBb1RDZ21ndGtEN1pMamVF?=
 =?utf-8?B?cU9neGp4Y1IvMFdjekR5YTJ5Y1YrTE9ZajdQTnYrTmJuTHF0Qzc2Ry9oUGVk?=
 =?utf-8?B?elUyMnkvY2M0VlQramRnS0U5UjNFajZ5VW92Mkd1WU5RR1Y5U2g5NmJRWWZx?=
 =?utf-8?B?WTV4WW1GOVp3WkJOL01LOTFySjZ6YU45NUd1Y3pvNG1vNFhoaFhpcHdDN05q?=
 =?utf-8?B?elc3VlF5eHB1SHdZdG53MVNFc1kvaW9aOWVBUVVYZjFTcXFpMzZYa3VGUExj?=
 =?utf-8?B?dkFXZFM1R2wxN2ZsRW51MURqelRlWC9rZnhZRHE2RWFOdCs3Rk9rU0RlSmNa?=
 =?utf-8?B?T0M5WGc1N3NmcWNzQ2wrM25UUDlmR1Zzb01KclkzdzJmN3RoMDFlY2xJcVhJ?=
 =?utf-8?B?Vkc1RG5xYWVBNEN2WWJFR25CZW1pZ3NhRS9FRjlldE9mUjVyU3dPTHQzQzUr?=
 =?utf-8?B?RG05b0JzUWx1N3ZJaGJMSm9UbFVkaDdqVm1HN3RXNFB2UHZCMnJEdlNBUXZs?=
 =?utf-8?B?am5wdTRsUnZjajNMdkV3OW5ZVWFXZ1J2cDVkQmdVZ0FidUVTU0E2ckFrUmdt?=
 =?utf-8?B?UGgvSVNJVXpoS09jcGpjRTAvZ3pncUdFcjlpTmNsT0NXd2VYV3Z2enNLVmhm?=
 =?utf-8?Q?7Gl89QdHJSZL//z94U3+aTmY1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 388047f2-0487-47c0-6f5d-08dc49ae7582
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 13:54:42.7807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pP5ZRgbD8IN5CoR6wWdkBMiLiwBoECAbtYYF5jOYUuJ4kbYE4nZwiAo0k6Ko90OXKr+Ul7RjOVp1Ui3hvH7kkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8762
X-OriginatorOrg: intel.com

On 2024/3/21 20:20, Jason Gunthorpe wrote:
> On Thu, Mar 21, 2024 at 07:26:41PM +0800, Yi Liu wrote:
>>> yes, the correct way is to undo what have been done before the fail
>>> device. However, I somehow remember that pasid capability is only
>>> available when the group is singleton. So iterate all devices of the
>>> devices just means one device in fact. If this is true, then the
>>> current code is fine although a bit confusing.
> 
> Platform devicse don't have that limitation.. It is PCI only.

ok.

>>>> And the whole thing is easier to reason about if an input argument
>>>> specifies the current attached domain instead of having the driver
>>>> read it from the xarray.
>>>
>>> yep, will correct it as a fix patch.
>>
>> Hi Jason,
>>
>> It appears there are two solutions here.
>>
>> First, only undo the devices that have set_dev_pasid successfully in
>> the __iommu_set_group_pasid(), so the problematic
>> __iommu_remove_group_pasid() call at line 3378 [1] would go away.
>> This also makes the helper more self-contained. Draft patch in [2]
>>
>> Second, pass in the domain to remove_dev_pasid(). Draft patch in [3]
>>
>> Either of the above two should be able to solve the mistake you mentioned.
>> BTW. They are orthogonal, so it's also possible to apply both of them.
>> Which one is your preference then?
> 
> I would do both because I also think it is not nice that the drivers
> always have to have the boiler plate to read the xarray in their
> remove..

sure. I'll send the two patches as Fix series.

-- 
Regards,
Yi Liu

