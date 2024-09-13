Return-Path: <linux-kselftest+bounces-17940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E065977F5E
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 14:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B65C11F22A95
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 12:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511531D933A;
	Fri, 13 Sep 2024 12:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ot5yq/f4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5641D9323
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Sep 2024 12:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229608; cv=fail; b=Om24VOzfh/EVdbIZThdBisT2MKm5Cea+8vdUuTsYBgFuxxlL7UNpYimPHX9U3zq9n4acM3qvyiTI8sS49BKZ9Jv0Wt9efs6YsqzWTGByfYOJ4rB5NspA1XCtpXyI5bgfS4+EQ1Q0DUwmjSvvXgcnZ8zWe8fyRorc+Z9jVUEGqvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229608; c=relaxed/simple;
	bh=yYYKerg55xEfiggIlrMl5rBrFvOdobwJrQiBTQqdUL8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GfRUWx9glI9utbHuhQ4vasRDCJPPGzj2NeDVH6S+QlaU4mSUIox8qT2M1ySHOtiGIcMEfSwoNaPly2PtiUeuqj0WtLMiDRZandIbx6HyDPPrgV8rYEUQ7J9N+JkVJYeCzj9sR1Dvzo5gf442/blYyup7TyeG7N63PlwiMM93IKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ot5yq/f4; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726229606; x=1757765606;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yYYKerg55xEfiggIlrMl5rBrFvOdobwJrQiBTQqdUL8=;
  b=Ot5yq/f4O7XLNkqGGRExVT1zCyJ7AhVM6eanh34Yl3mvj3S7lNjugNWV
   msPKRj/GLuUW3m3jMA95G54GhDx9bPFuyXPyawCoTHth3IpTKp5ZtMRQU
   Oaae2t+FI3MThdMKCLGgczHjUjkhBTbDdpUVGzx3LYmZjlwqQefIbGJ2R
   sEKlv/I9ENIKrExw4ZEDK6ovnKSznC4bzy5nzJsTUOSXXYy2N1v/rV59Q
   +5DakkdsJhKI1uhf1HQT3N6mEZPkz6TYp0I+yp/oRgG30fkaO7lS+6pT1
   AH+IaFNS7zQl83IFVDzQKbrCEKHGw214aMC+ipcZSwDYEyjak9FwFyzka
   g==;
X-CSE-ConnectionGUID: uRghfcJsRZC3wWzNt55I4A==
X-CSE-MsgGUID: YNejm3WQQRmqsMaZ+j3PMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="25003433"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="25003433"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 05:13:25 -0700
X-CSE-ConnectionGUID: 9exMv/VsRIyVCSwPRLaF9Q==
X-CSE-MsgGUID: 79d3xeFhSBO9dg4aiNYdkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="68294221"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 05:13:25 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 05:13:24 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 05:13:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 05:13:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 05:13:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDq1JAqd1PzWXKKSjF0lzchNNI91dHa3RAwetQleYTSFvCY7TSAPn3igwcRgPjjoDfvBtBllrpCjW3OGt2K+4LwKKQOSJYIy1o86+X7YIUMc2oPMf/qmGzHjNyMYpIZgsSVxLVAhms0TjfjQGXhtSgI/u60psnTcqhXyxtQIi33wTloxDHY67S9hMpo9kFwAT8lcpgSYvkRY9Hq5YfFydirgZL5ztCEkKjuZBtjwq2mfjy5El8/xh0sCQi1SCPUUq6wU4ETbXTTxreC63F4hEmGR7SyXNhn9Gay+AJl2i4+llA4fD5iMYuqToLlX5qPPMLGtqAdwW1XfaU+PnuvWSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1QItODnsuAPE40g0jVuwKZab/qDU0i2YHUMuiznPUY=;
 b=w/d2DBurDRdAL7p5gdeJpj6MGqrATDCJx2UZe3qftfdgenyTVS1k6mzEjScSJK99pfjPe1+EjbiLNYixvFYN9OrNfT3NFprDIsh5OreHgB6GD/BkU986MjamPpSZJfNf8vpQLrZRufZWQL1hyD/CxyHwkWDH6wKRJTY3LL6dfSjkYmIWwqSAH4uPTOTwLexEXBbF8iBVL0R8Qlh02i/MULhYe+dBOIGeWShUYJcLlpWR3iQsHCH/oWpaRSjzZf2pWbiGbturmA5waAjjA+5E4F9o83b0v+yi1Z5/p7XLomRLTXro8T8yBSfm85qJ3yeuTu96dsjfSRimUot4xkg+Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA0PR11MB4653.namprd11.prod.outlook.com (2603:10b6:806:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.20; Fri, 13 Sep
 2024 12:13:13 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 12:13:13 +0000
Message-ID: <0c6bec10-12cf-4ea1-aba3-631a413a78ce@intel.com>
Date: Fri, 13 Sep 2024 20:17:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] iommu/vt-d: Make intel_iommu_set_dev_pasid() to
 handle domain replacement
To: Baolu Lu <baolu.lu@linux.intel.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <alex.williamson@redhat.com>, <eric.auger@redhat.com>,
	<nicolinc@nvidia.com>, <chao.p.peng@linux.intel.com>,
	<iommu@lists.linux.dev>, <zhenzhong.duan@intel.com>,
	<linux-kselftest@vger.kernel.org>, <vasant.hegde@amd.com>
References: <20240912130427.10119-1-yi.l.liu@intel.com>
 <20240912130427.10119-4-yi.l.liu@intel.com>
 <a2cbc96f-7be3-4f70-a38b-540eddfd7c23@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <a2cbc96f-7be3-4f70-a38b-540eddfd7c23@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::18) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA0PR11MB4653:EE_
X-MS-Office365-Filtering-Correlation-Id: e15b89be-c230-413c-8148-08dcd3ed70c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjVCUjNCWGgzL05Jb2NFT2V4QUN6WGZrdW5Lb2pudmovVFhPWC96SjF1eFFO?=
 =?utf-8?B?eVBuUlNaTlVDeW1nZ3ZSaERrVFVuR2xhZk9iVUZiU1ZBUUIwVDlZS0orbEtq?=
 =?utf-8?B?NFF1TjBudUR1dzVOVGR2c2NwR3Z0VUQ0VmZtQUE0Tk5BenAzL01BaklHNGhz?=
 =?utf-8?B?M2ZZWEFTVENMMEJIUk05UjVaWnFuS2pUenVLZnBCS3BhN2gvcTVOeGpreGNv?=
 =?utf-8?B?NHFOQUdoVEg2WnVWYUxYT29wYTlBc0VjKzU5ODA1TStSbHJKZkY3SEZ3Yy9K?=
 =?utf-8?B?bFVTbDN6Z1FmOEE0VDgveFMrQWJHZ3dueEREa0xlUHNhY2hPNzJyb3lSTTdL?=
 =?utf-8?B?eVVnWmNIejJrbG9VQTRkUnc0cTZqYXNuVjR3SzBVS1Z6SHFRNktYUTRuQ3Jz?=
 =?utf-8?B?RXg0bEh3N1pKeEhaTjJnKzFLOXkzbFlZZDJuU09KSmhIN3YyMWZQdzB2RnNS?=
 =?utf-8?B?Q3NRV0YzcmtGa3c0eVZoSEtmemQvU1FKNWVsTDV2dDF1RWFpTUZEUVFqcTZm?=
 =?utf-8?B?cTdwWlJLTFo3M1RnazVoa1lXK0c5d2tCZkdSS3h2T3VGNFJHSTVRMFhzeVAy?=
 =?utf-8?B?a1pOcVdkQ1FWbTBNNGFjcW1lWGJkZFIrNTNVUWFOdEJxY3pLenFCYkxRYVZG?=
 =?utf-8?B?M2tvaVpTMlFGbFZxbDJaN1hQR0RFNkJNSkUvNGNxTFVrOUtZQTdmMUI3MFFB?=
 =?utf-8?B?M3hlUmlYcTB6b0l2V1YxVk1TRFZSM2tCMHZFWWhzZGRxWElHbStTbHFlNGdU?=
 =?utf-8?B?Zm1JRmtDL1JkL25VSFYzQVFTWDRkT2ZRYVc1M3Bldjl4WjVLZWpRNlp4bEJl?=
 =?utf-8?B?NCs3anUzWHlLRElJZTNCbkNrN2diTVl6YWF1YVlndXFwZUdVN3hCUjcySUxO?=
 =?utf-8?B?ZXRwUUVOSS95MWgxWFB6Uk9kaGJ5OXduS0VhdkNWaU5hMDY0bzNSWlVCQUIz?=
 =?utf-8?B?RmZUaHcwTTAxdHdvb1UxeEQwdFRsZGFtSEY5YmNGRGplWGg1QXFGQTMwVVc2?=
 =?utf-8?B?MDBTWmFuQ3VmcXZWMEV1ZEh4RTM1UUNpbWFZR2phaXUzY2hyY2JpK2FtZWEx?=
 =?utf-8?B?eVZ3RWhSWVVDaHNDTTVBUU5wYzhOY052QUg1clZuNUFIM3BBcnJIM1RwaEFK?=
 =?utf-8?B?QU1oQktQSU95Z1VobVlqOFBLOVJDaEkxMCs0WFdhVFVNOXpHbEJHZ3hFY0R3?=
 =?utf-8?B?RmI4TnQ0V1lvZ040S09IdmtuSXhEUU40MVZ6S0MrWkpaVnd5YlZkby82WW95?=
 =?utf-8?B?dVNabFJqNHRVNWlIZGdFb2NDWjltbC8zMzVBZmNiU1YvSWYraTQxQ3Zsb3M0?=
 =?utf-8?B?VXUwTVpPVHBvUmhxK3JWb3lrNy9GdjZ5UFZCT2lLdnFZbGRPaEpCNk5Hc0Mw?=
 =?utf-8?B?MjU4b3Z4U2NRMjlNK2NOdVM4bHBTZHBCejlwQ0gzUXBBMmpVOWZMaW13RFdW?=
 =?utf-8?B?UFBsdlZnbWhPVmdwK1VyUVl3dFhQajhyeEkxWGFZb0lIbGR0QmpqQ1NPSWZO?=
 =?utf-8?B?ZzBPUlc5K3E1ZTcvVkFQdU5hMmM3VEI4QWowZHZsM2E0NWdpRDgzQ2xidHhC?=
 =?utf-8?B?SmM1NDJJZ003NWdWUS8wNHBsUG43cWtHOTVQWldjVlFoZTV4VnF4Q3lvd3VN?=
 =?utf-8?B?MTUxVmhDL2hxVHhhTjJZZ3EzTy80NlJVTGk5YTgyc2NDUWlJWG4wTENYMC9r?=
 =?utf-8?B?dFU5S1Z0cTJ4NzlBVWF4Z3B5NjhXUm5hdXRlVmFQZmhFUEg3MG9UcFhsYjNV?=
 =?utf-8?B?d3Fud1BKMWlLTXRCdldHYmp5dU0rNHd6dHlRSTFLdGoyVHY4akNIMndvNk95?=
 =?utf-8?B?RlA3SWNReHVydlJ5SlRpUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGo0OUx3b1ZhY2N5WkVSYjJVU0VqelV5WlYvbkVoUXZVbm5EOXdxWkpLd1pK?=
 =?utf-8?B?SWR5WjJRVDFSNjRXZ2FqV1VvSFphYzFLVjNvQk5LakN0OXJYTWJWcE9OdGtz?=
 =?utf-8?B?V1NLTVVFampCNFNQbS9yYjdac3RsblNUUktiaDRFMDBvam8rakVHOW8xUUhD?=
 =?utf-8?B?aUVCYmtTSTVabDhFTDBZTTZGRkFZR2JrUHFMUHJ3NW5qTzRldFcwWjlGNklR?=
 =?utf-8?B?Q0prdEloV29weGtsRlRISWxWV3BJUk5jaW5jUU5OLzhVWXVTelZLLzg1M0tF?=
 =?utf-8?B?cWFOaEI5Ujk4ZTR1N2tnazhYMW4ydTQ3dWw5NGovRy9Ya3FRMS9JTUptVTFN?=
 =?utf-8?B?MTQ1cVk2Q2NvYWtuUFovdll1aWFzZytwNnUzdXJISEVNTWFuWUpwSmxWYTI4?=
 =?utf-8?B?UjZrRThiV2JrZE5EWXBSVlpRMVZWbDJETUdkOEVPeFRMK0E2TEVJbzhJaVdh?=
 =?utf-8?B?WmZZZDJsWGRDQXZhRkg4Ri96MStLN0dxcS9MUjlkdEhjR0pwL1Jzb1RlK1I4?=
 =?utf-8?B?c0IxVTY4UkRKRDdQTWZoWXlrZ3pDbFhWSGhGM1dvZnhqZHV4K3JjYU9pZCtC?=
 =?utf-8?B?cElaS1dXQUFLckhRUW5hVjJqeVd6cDNuRWlwWGFLNzNJZjZLamovZWhIMk1C?=
 =?utf-8?B?YzJXN3V3YjhjREkxYWkrUWlreHplUUFVVnB2ZDBhU25jK0N4Y3JFYjFUN21Z?=
 =?utf-8?B?UzZSU09IZC81OUVIaWhuVmJkK29uTlBvLzl1NStSYlJUUHpRM0cwK2paS29R?=
 =?utf-8?B?K0VPTGRhTzNNdXh0akduTEd6RHFnazJGUDJ3MVdtd29CZGFDMm1zaDY4RDdS?=
 =?utf-8?B?emFIdmpCUnAyMFN2Uy9qcGplbGRTMnVQcU1SbVIxd3o1TFdkSDI0S0ZtNlhQ?=
 =?utf-8?B?d0xzcFhhYThpQmhSK1NUNGhpUHgxNkNMSG8rTFc4c0ZpRStIME5Rdk1LTkFj?=
 =?utf-8?B?eU1FUTZaWVFzSndxcEUyT1hPRzgxajFGUU5rYVo4RjlkLy80c3gxMjBFTExB?=
 =?utf-8?B?dXFCZXo0c3o3V3AyMFFybXh0RkgzdkpTdk9LV001bUFWSHg2dE5LdWdQL2xu?=
 =?utf-8?B?M09HNis2aEp3bjljZ09lc3cvYXBYcS9HQ01QQWRFS2t5bnZqWFNzTGgvZlZu?=
 =?utf-8?B?S3RhZXhPRVFpdVd2d1ZCRytTUUJaMUM4N0UwQVd2QTl4WkdmaWpCNWMrdTI2?=
 =?utf-8?B?MWFTa0ZSRWR2V2tMVENxK1FHVWNKaWdSaUNVbWZwZUEyU0VPR0VvOGlWNXFU?=
 =?utf-8?B?Vm9ERXpWZmFGdDJWYSszbzM2TlVjWFA3UzlZMnlPaUxVanlJeVE3SVhJUThW?=
 =?utf-8?B?em12cEoweEVqRjA4WmZ1RzZlRzRHVTBrY0lCMTVtQUZkb2U2bmhSVmhaVnhR?=
 =?utf-8?B?b0VWNlBNSXI0cmszOHJBNG9PMnNUaVlib3NydldEMWQzRkxNVmlBZVZJaG15?=
 =?utf-8?B?S0VBVStTVFZVUFhxek80bW0xVXA0ZkxvSnNTd3NXaEVWVXRpYlduYnlRNDll?=
 =?utf-8?B?RW9ieHZ3b1E0K2dlNGJjb2FtSGFtMlRsOGw5YVVweFVycGxUMldsNERqU3dw?=
 =?utf-8?B?aUZiU3lIa0ppUjdWQlBwUjhENG45NDBLK2U5bUJTekVqR0t4cDAxSm5oWitp?=
 =?utf-8?B?RzRTeVhpcTlKL3JHc1g1NC9pRi9hZG0yMnRvSVZaVnJsZWhxS1J3OTZyaVQy?=
 =?utf-8?B?L0tIWVROR3l2YmpCaTdmcEVTNjJaRDRFRHdjUmRUeTlHVmxkOFFVVGlHTmlU?=
 =?utf-8?B?Y1kyOTBFN1FaK1VFTXFtVTl4em5zWFFaZGx3M2ZMWUlOSzB3Vm5NRUl0R3g4?=
 =?utf-8?B?SGdhMkxJNjVsM3JFZWkwdDdqQlM5dVNWREl3NEFWck9mSHMzc09xaHJ3NWlq?=
 =?utf-8?B?b24xRzd0eVBySGxYb1RDNHd3WkNPVmVNSGZKazFzdEdyMFRHdUlrRzNuQWha?=
 =?utf-8?B?Y2IrVkQ1MHhQWW5BcjkvN1p0QlVtRHJSalUxM0VWMjB0Mkh0S1VrNGRWRzRP?=
 =?utf-8?B?RDVSOUxCakphVENMekRMZitPTnFrWG1yZTd4dE5HZUpZSXh4MWMwcWNlUUln?=
 =?utf-8?B?WVJVQ3Ayb1pWRXJyNkZIZUZNSWhzTEt6WEtGQ3F4RHNVTHBrREQvNlRSK1RI?=
 =?utf-8?Q?je3CW4xG/VA2mSQFjhSXgZwUl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e15b89be-c230-413c-8148-08dcd3ed70c7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 12:13:13.3681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5GSElBBw8ugskp2Fr22n3lpVBp1sP0Ou+fSS+fmrLldXKPYy8Sr8v55IScxzPqcd9/9TT3Q5ifawfzgB/lyoNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4653
X-OriginatorOrg: intel.com

On 2024/9/13 09:35, Baolu Lu wrote:
> On 9/12/24 9:04 PM, Yi Liu wrote:
>> set_dev_pasid op is going to support domain replacement and keep the old
>> hardware config if it fails. Make the Intel iommu driver be prepared for
>> it.
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 98 ++++++++++++++++++++++++-------------
>>   1 file changed, 65 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 80b587de226d..6f5a8e549f3f 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4248,8 +4248,8 @@ static int intel_iommu_iotlb_sync_map(struct 
>> iommu_domain *domain,
>>       return 0;
>>   }
>> -static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t 
>> pasid,
>> -                     struct iommu_domain *domain)
>> +static void domain_remove_dev_pasid(struct iommu_domain *domain,
>> +                    struct device *dev, ioasid_t pasid)
>>   {
>>       struct device_domain_info *info = dev_iommu_priv_get(dev);
>>       struct dev_pasid_info *curr, *dev_pasid = NULL;
>> @@ -4257,11 +4257,6 @@ static void intel_iommu_remove_dev_pasid(struct 
>> device *dev, ioasid_t pasid,
>>       struct dmar_domain *dmar_domain;
>>       unsigned long flags;
>> -    if (domain->type == IOMMU_DOMAIN_IDENTITY) {
>> -        intel_pasid_tear_down_entry(iommu, dev, pasid, 0);
>> -        return;
>> -    }
>> -
>>       dmar_domain = to_dmar_domain(domain);
>>       spin_lock_irqsave(&dmar_domain->lock, flags);
>>       list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain) {
>> @@ -4278,13 +4273,24 @@ static void intel_iommu_remove_dev_pasid(struct 
>> device *dev, ioasid_t pasid,
>>       domain_detach_iommu(dmar_domain, iommu);
>>       intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
>>       kfree(dev_pasid);
>> +}
>> +
>> +static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t 
>> pasid,
>> +                     struct iommu_domain *domain)
>> +{
>> +    struct device_domain_info *info = dev_iommu_priv_get(dev);
>> +    struct intel_iommu *iommu = info->iommu;
>> +
>>       intel_pasid_tear_down_entry(iommu, dev, pasid,
>>                       INTEL_PASID_TEARDOWN_DRAIN_PRQ);
>> +    if (domain->type == IOMMU_DOMAIN_IDENTITY)
>> +        return;
> 
> The static identity domain is not capable of handling page requests.
> Therefore there is no need to drain PRQ for an identity domain removal.

oh, yes. so maybe for SI domain, there is no PRQ at all.

> So it probably should be something like this:
> 
>      if (domain->type == IOMMU_DOMAIN_IDENTITY) {
>          intel_pasid_tear_down_entry(iommu, dev, pasid, 0);
>          return;
>      }
> 
>      intel_pasid_tear_down_entry(iommu, dev, pasid,
>                                      INTEL_PASID_TEARDOWN_DRAIN_PRQ);
> 
>> +    domain_remove_dev_pasid(domain, dev, pasid);
>>   }
>> -static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
>> -                     struct device *dev, ioasid_t pasid,
>> -                     struct iommu_domain *old)
>> +static struct dev_pasid_info *
>> +domain_prepare_dev_pasid(struct iommu_domain *domain,
>> +             struct device *dev, ioasid_t pasid)
> 
> Why do you want to return a struct pointer instead of an integer? The
> returned pointer is not used after it is returned.

it's for the intel_iommu_debugfs_create_dev_pasid(). it needs the dev_pasid.

> Also, how about renaming this helper to domain_add_dev_pasid() to pair
> it with domain_remove_dev_pasid()?

sure.

>>   {
>>       struct device_domain_info *info = dev_iommu_priv_get(dev);
>>       struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>> @@ -4293,22 +4299,13 @@ static int intel_iommu_set_dev_pasid(struct 
>> iommu_domain *domain,
>>       unsigned long flags;
>>       int ret;
>> -    if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
>> -        return -EOPNOTSUPP;
>> -
>> -    if (domain->dirty_ops)
>> -        return -EINVAL;
>> -
>> -    if (context_copied(iommu, info->bus, info->devfn))
>> -        return -EBUSY;
>> -
>>       ret = prepare_domain_attach_device(domain, dev);
>>       if (ret)
>> -        return ret;
>> +        return ERR_PTR(ret);
>>       dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
>>       if (!dev_pasid)
>> -        return -ENOMEM;
>> +        return ERR_PTR(-ENOMEM);
>>       ret = domain_attach_iommu(dmar_domain, iommu);
>>       if (ret)
> 
> Thanks,
> baolu

-- 
Regards,
Yi Liu

