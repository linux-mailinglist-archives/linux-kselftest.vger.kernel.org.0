Return-Path: <linux-kselftest+bounces-6416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DCF87F853
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Mar 2024 08:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDFEFB21AA0
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Mar 2024 07:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5321524A2;
	Tue, 19 Mar 2024 07:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DtIH2p0W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC2851C36;
	Tue, 19 Mar 2024 07:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710833182; cv=fail; b=i+YUC1k+uT6gUJqwpInYCgbUHp8zhOLxnu6cu2o5i7fqil+nSAZ7avsAWAhYN6SJUM2NTwbX6P3Mpe11uYPTKuMDcM5LT+MoH9CiEVPLp4LGZiIQ3P5llKdwVtEKdUs3OWhCgB+u1QYBrr+pHFnAc56cecKBg4U+xFUlcGV8B0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710833182; c=relaxed/simple;
	bh=dMYFL7LBB782/XOg/WSIWVVmCpMPNiv/CvyIU9SojZc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uNAlKX/PgctttvIHJ9Dwixc6hBMkRxJ/4phD6mYIJRn60HRIy2YjtkhggHHdeUHIGtGx19ezii8wAfiNuUHt39I93eSNn/sqwnkORl2TIdjRmauqihVZwWidrOaKXSfwU0H82O1/SMjELh6AxrwXIQRc8wZ3L4gstnXC08esI1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DtIH2p0W; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710833180; x=1742369180;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dMYFL7LBB782/XOg/WSIWVVmCpMPNiv/CvyIU9SojZc=;
  b=DtIH2p0WUe6GE6Q8gZNbpZjjt/KOwr1ZdKpqwuhTuou6a3wEe9ot+LfM
   3pyJmBlMvn3NsfTl/1dDYLIgLgoBzuYZmGroKSZgqokauM2Va0ppFwhH5
   BJgaVMOXLGyMVEadb6/7S9gtba0ccxNGkVQkYM0dW9Zb0dAk3B58vPKAR
   qv36+7X2WeBZ6DsOSPRykl5d3JOLK4NJ2oNr42frciwouNBHTzkXXdLDr
   UvDAJFje7sRQdYrrTTwXvpOYfq3oNsJcqPAYbf24Yxlf1CNha3Au7yISA
   s5JTwBmGOvYuuvN7KzhLsPKSs0puVT38LWsyTTJiC56S+8YoCtOOB7+hr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="16411840"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="16411840"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 00:26:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="13613181"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2024 00:26:18 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 00:26:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 00:26:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 00:26:16 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 00:26:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYNgQ/fwnM3cSxu4AepjCavhKpJ0klPytcAqLojAkzxU4Fc/AxVExW4jxHwEoxwUVqJBniD7TzuYDMExIaMJy7z8HXNzhPen/Ka6bYdQxRBmX136l33wFT4xPzNHI6SOmXgxOd8amjyERa37O5b5uGppm7uH+eKhQaUSOEl/DRwNU9kEXVC4K2KcQ1uASxuwBxAp6oWEN6ArOZfHNmCpuhf6d1OLJAshEYJScx0TQeMG91hAfShM1EDbH16paJx6rBNXyoJIYP3BAi2x3pmRj5+J7Ak6T5QgDmEiLvcVkL8QB+zZjZ5Fr0vXa0sEsztI7x+toFYC79TDe+5LykCfLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7h3EbF8DLFIc9cfhEui1ZaFsSAwp4SJoh/17kPTQvec=;
 b=VH0UzkLr67ZEFxsiIIhnL+PP2Vxk+mEToa+epmKvr9sraUb1468N9v8jeKykx3rQ5+UxC5ScizOSy2YzMCg1+JLuk1epTh8jwFvjZnkqP2G+pApTjgY0EwJoFoddNLtlzcb625jGT6CrLrtohAt+9yUL1iW5Didf6x6bnXkb1fd+4cCNfZcbmcoZxxoqSfP6v35H/YgQlCtOGtyxrsGENJCB178UIFF49LtRLcwOpRS5RrXNkdgMvtQ5dPceeCi3dJOAlgzHHXdnX1fxG77CERKiQFjMJL5JuSxlwIwQmHX6T5SgaRSOTEzskfDdCcUerY5uiI0MSitQSVxU21ilVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM3PR11MB8716.namprd11.prod.outlook.com (2603:10b6:0:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Tue, 19 Mar
 2024 07:26:14 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b1f5:9d1f:f510:d54c]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b1f5:9d1f:f510:d54c%3]) with mapi id 15.20.7409.009; Tue, 19 Mar 2024
 07:26:14 +0000
Message-ID: <13645a9f-239a-46c9-bde2-a1d5c365df4f@intel.com>
Date: Tue, 19 Mar 2024 15:29:39 +0800
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
References: <20231127063428.127436-1-yi.l.liu@intel.com>
 <20231127063428.127436-2-yi.l.liu@intel.com>
 <20240115171950.GL734935@nvidia.com>
 <c831bf5e-f623-402d-9347-8718987d1610@intel.com>
 <BN9PR11MB52766161477C2540969C83568C242@BN9PR11MB5276.namprd11.prod.outlook.com>
 <585423de-9173-4c97-b596-71e1564d8b4e@intel.com>
 <87a2be0d-6a24-4ca8-be30-35287072dda4@linux.intel.com>
 <749b23c7-ab0e-42b4-9992-e1867fc7d4d7@intel.com>
 <20240318165247.GD5825@nvidia.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240318165247.GD5825@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM3PR11MB8716:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pZg6x+nB4hFwTCg7ETuXzyNG6r4kPcobAkssJc08YvNqqb5TXucFQrBEieFfNWGfdCS2u9sN0DChwaw/NWRwgiaZrY32YYcucKpu6SV34h4hhRGziwoCYbG79p0WKgU118d7vXmSvpeO1ADwTeZ52W2V2VlZ4NbMf0clPEjuspsK2o+vxDlDPFeQXPpAyXggMmbhLM7JmCCkhY1LkoFoWSE6t4y2K5Wbksf7Am3IRI5Njgq5cCuxSuL/oRwH1dy0A53sE+S/ja9mONuK5rhW4kHBW7J/f5jZfhPeJywULaiq6G3oLM0Us82K6Y8cbOCrMLXV9x9KCvk9S47p2RqRUfhzthyuBTHtZXpUsVRvo2CiCIpIXGHBe89pEHlQNx8+KxPYUUEhb0Gcxewc5nrFCSda8UvPjlsExOMiNqoOY0I0F3e1gmxl9tJ8uyXjkOTfPtUd//O4OmnTlxKOPvbsgrEB9Y6icRyKExL5p9G8Vy5rp7gL3Ylz0FTLLgenZpLM6IET2OUPRZek23UtUst6jCoXW990PUvPy+/6hRirhBKF8ty9YBmVqx207pvfqgZ2uD/tMnUFagJ+I4zNtPWpa2oIRbl4QFunbihRfFyyvSM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXZISUtvcDVWR3JYYnBJY1NyZTdZSVkzaGNXeDJJNlRrQlQwaFN0by93bWtI?=
 =?utf-8?B?ZGJDTTNzK0lDakVPNFBwa0NpMkNzTU1UYkVZVm9FdmpUdHh0YjRpWjJ0Mjcz?=
 =?utf-8?B?cWovdGQ2RDBmc2JCbUgxeDFQcUd1ckNEanluKzgzYy9mZFFnQm12ZTY1V1NW?=
 =?utf-8?B?MjNJbDZHTDlRalVCcllyL2tKT3M4RS9Eb3AwQnQ0bE95ZUdpeVNsSy94dFlw?=
 =?utf-8?B?OUJQQnB5R0VWcElIN3JKSCtLK0U0ZG5ZZ0x1UGtTbUpqL1A3WHo0Q2RLVyt2?=
 =?utf-8?B?YkQ3TnlhWVNnRVovcFJadHl4YzJJLzhpaTNOckZnbDBXWldUSnhnZ2FjQzdz?=
 =?utf-8?B?clJ1R1JLWTkyNDI3eUtGUzlTVXFyWkFEbEo4NFVGMkZ1dE41RjVCdElMRGdP?=
 =?utf-8?B?VytKRC9HTnJob3M1azIrSVA0VWtVVHpSV3NGWkRMYjk5SUpIUmlWVitlWWhK?=
 =?utf-8?B?VGVmQ3M2UCtiWXE3eVIxcGhYU2EvTThCWFU4UHVFbENWRzF5eEg1YlE5dXJm?=
 =?utf-8?B?MDJCb1ZFVVc4RHpkbDJpdHdkaFpVS245d2VsclZKTEkvQnIxVmRoNzNYd0hK?=
 =?utf-8?B?QlJmSHhiMnJ4MUh3L3pFWVhaenJJaHdmZ3V4NkUxVmpOdzd1U2tTZTAwQVNh?=
 =?utf-8?B?N1ZJZTZ3YnpORlhJVWg3TCt3UlR3NlgwLzNhVFpFZkp6c2lLUUV5cnB1QTI3?=
 =?utf-8?B?RDFaVVh5czBPR2NlWXJaTC9FMzBMRm14TnRzUVNjSHBYdFpNMXZsS25xemNy?=
 =?utf-8?B?c0R6Y01kbEFiT0lsRzVpUUlhaFlZb3g5WUpIRGlyU0tNL0doR0toRVVSWFNK?=
 =?utf-8?B?TGtSNWdkQm1FWC8rQmRlSFhTMVUwb2U3UU5XOS83Y1Q1VXo5ZHF3YUhUK2Vp?=
 =?utf-8?B?bXJkMUJPakoxRnlxMG11Yjc1UWRiVnZoOVNXOUZaRTNpTGsrbUdjYS9RYUFV?=
 =?utf-8?B?VlVHOG9QeWhkbHM5S2I1VlhqeHlRVWltbUpYT21Vcjc5VUx2Qzhpa09uT2Rv?=
 =?utf-8?B?MHFQOTJ1VmJOSUF0cFQxRnEwcTdtU1VlTnNZSWdHNTJEQU9oRnhTdXlWQ2dB?=
 =?utf-8?B?clpWdlJDdjdWaUZqV2ZIQjVmWXZZcjhNR0RhcTNjcjJ4R2R2eG8wWGQzUy9I?=
 =?utf-8?B?ZGMvK0NKQ0lXNmJrRU83eFo0WTlJb1RqTytScU9jRTM1VlUwZGw1TElUcS9K?=
 =?utf-8?B?Q0RFUWdhTTRndFAzMkF5Wkl4YkFaWW54QWNKdlZLT3NUWnZCaW1ZdFEreFN1?=
 =?utf-8?B?cU93WlNXQnp2UHc3c3hpdHNtUVJ0RWdMS2dpR2ZWaU5XbDYvaWhYNUl5TS9O?=
 =?utf-8?B?MHhydlpoN3AvQXg1Umt0cmhwUXlGTVZhUUxoa2pxR1dIMElUd0dEcGl5Rmds?=
 =?utf-8?B?Y2dydUJ3V29vRW1FSG41SlVWaXZKWjhGUFl6Y0VkNmhEYTdOc0hkOFZHL1p3?=
 =?utf-8?B?cFRveVZFTEszWVNidjZ2WFNUM2hWaHc1QWJUL3V5TkRiSHlBdWFaQ2pNVExB?=
 =?utf-8?B?Rm5pRmNsdVJlYlA4cXNjZlBKY1U5SnpWcHU2QmFxUEVqWTRTTERoUFZORHBP?=
 =?utf-8?B?Z2RLSHJEN2JVME9CRXEyQzRUNVU4dUxiai80cGY2L0g1SThtTDdrSXpSNW1U?=
 =?utf-8?B?NlhSeXB3U2ppdmdZTStlOWY4RUNVaUpsR1hVWTFQTDRLVGttbmpIZW1HWmxL?=
 =?utf-8?B?Nk1JY0lmRlhicW5rZE1FcVlzT0RWNWJJNWxaYWk2ZGZIYUxITmQwWStxM3Zq?=
 =?utf-8?B?bWVRb1RBWjVIMlhPTzB2SUFEMXdrNDZOS3ovSkY5VmViUzJVY3NrYi9PSWla?=
 =?utf-8?B?Y3pXZm9zNGdzYy9tQmt0c0ptQzBrWmVWalNaN3hIYjVGaE1ORUlHRFhNcmRN?=
 =?utf-8?B?U3pRTDk2TDh2bUsrZll2ZUZsUExBajZGckRWUVhzWVpRaDJSb2Ezdnh6a3Q3?=
 =?utf-8?B?RFRubUtKQXV6dEovSEhZYjZtbXpYdEVQbTVtMzJsQm1hMnY1STlrTWFOa2xv?=
 =?utf-8?B?eHhDbG1POXdxOU1SM2d6YXNJMnNBVGlRMXNoaUhiSG95bDJZeHNYQmJTMkxM?=
 =?utf-8?B?bXRtTnVtcDZnT2praGdYenVUUUx5UDlxRzV4cGR0d25IcElqTkM5OEtWR3pr?=
 =?utf-8?Q?QYNYv1N2OO52X8jlrqnEfbe6K?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 981f377f-ffb6-48f8-66e5-08dc47e5dc04
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 07:26:14.7220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: viGh7nzSSe8htbeQUFxcaCtwxXaRGJ6/Xb7sv9Q7BVpd3j4At49pEwtebxYvJ5vxUMUcS5XUNBqBg/ik5Fq1+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8716
X-OriginatorOrg: intel.com

On 2024/3/19 00:52, Jason Gunthorpe wrote:
> On Wed, Mar 13, 2024 at 04:11:41PM +0800, Yi Liu wrote:
> 
>> yes. how about your opinion? @Jason. I noticed the set_dev_pasid callback
>> and pasid_array update is under the group->lock, so update it should be
>> fine to adjust the order to update pasid_array after set_dev_pasid returns.
> 
> Yes, it makes some sense
> 
> But, also I would like it very much if we just have the core pass in
> the actual old domain as a an addition function argument.

ok, this works too. For normal attach, just pass in a NULL old domain.

> I think we have some small mistakes in multi-device group error
> unwinding for remove because the global xarray can't isn't actually
> going to be correct in all scenarios.

do you mean the __iommu_remove_group_pasid() call in the below function?
Currently, it is called when __iommu_set_group_pasid() failed. However,
__iommu_set_group_pasid() may need to do remove itself when error happens,
so the helper can be more self-contained. Or you mean something else?

int iommu_attach_device_pasid(struct iommu_domain *domain,
			      struct device *dev, ioasid_t pasid)
{
	/* Caller must be a probed driver on dev */
	struct iommu_group *group = dev->iommu_group;
	void *curr;
	int ret;

	if (!domain->ops->set_dev_pasid)
		return -EOPNOTSUPP;

	if (!group)
		return -ENODEV;

	if (!dev_has_iommu(dev) || dev_iommu_ops(dev) != domain->owner)
		return -EINVAL;

	mutex_lock(&group->mutex);
	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, GFP_KERNEL);
	if (curr) {
		ret = xa_err(curr) ? : -EBUSY;
		goto out_unlock;
	}

	ret = __iommu_set_group_pasid(domain, group, pasid);
	if (ret) {
		__iommu_remove_group_pasid(group, pasid);
		xa_erase(&group->pasid_array, pasid);
	}
out_unlock:
	mutex_unlock(&group->mutex);
	return ret;
}
EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);

https://github.com/torvalds/linux/blob/b3603fcb79b1036acae10602bffc4855a4b9af80/drivers/iommu/iommu.c#L3376

-- 
Regards,
Yi Liu

