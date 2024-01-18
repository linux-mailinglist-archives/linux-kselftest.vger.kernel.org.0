Return-Path: <linux-kselftest+bounces-3188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 773CB8315AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 10:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5C171F26E80
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 09:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1DA1D55A;
	Thu, 18 Jan 2024 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kCrS70Rp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247581BDFC;
	Thu, 18 Jan 2024 09:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705569930; cv=fail; b=CCQN4nTUQyHPRefvBLR6K9CYV0WoqOIaY1hoaQF2LDl8BWx+UCzQpZJGJhFsq2ONDjmT22vANiySN1Lc8teL7QCmmHIPmujN0EDSM1wwiWiXX7cWCK8YMXO2j1N3tjuj6SjxKJDE5JktGoomDyjkW1VgpA4SvZtrhs789/ln4qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705569930; c=relaxed/simple;
	bh=mz7XXlIeNs/NZop2YeZ1+JS5dJ44plfL7/Vw6IfXYJE=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 Received:ARC-Message-Signature:ARC-Authentication-Results:Received:
	 Received:Message-ID:Date:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=r1Ltsbdd+JJOujpgmA+IDyhp050bi6/R/3Hh3GhjLfaGb+fwkJDUdZzuoxJ7ba9vFThxREsw2bgUHljTNkKulJWJzA7JXSIxPFwKAlMstrp9MDSG2+KUVu/KbvrKWtQLRcloAAjLdif4DNrXkfegXMq2uWgKnPFX32QjP+pN8bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kCrS70Rp; arc=fail smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705569929; x=1737105929;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mz7XXlIeNs/NZop2YeZ1+JS5dJ44plfL7/Vw6IfXYJE=;
  b=kCrS70Rpl8BfbSY5XHcFx8nmZkfRpBvljeYgmdv/AnaGesr1MSWMs/MH
   0nv8bJQIi8ugolmhNcGJr2MXe4vuyVOzDl1+BFQAUMBa6nXpGgilDpK2e
   Oag+TatKhGallX4odDxl5ofV88FUqwSfxIoSgHIOeHDcD+uv11sxLNn+G
   3uW30Y3DQylV9HTNU+KMni5SFfv1lep18XNrMUo5lYLudMKczTrSXSJqA
   2GYvrikhUqFDaqEVIhRmQWxCyCpAnA4DNKHheZyKZBpsv5tqx7u3ik3GK
   g+dSZKvFYOyS2KM0ENGtsRk24mzy2tgme6jyYdoNUNFpNcgej5RIYWRmM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="404164035"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="404164035"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 01:25:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="854941479"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="854941479"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jan 2024 01:25:27 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 01:25:27 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 01:25:26 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 01:25:26 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jan 2024 01:25:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7DGWTLbpMqxzZmtcbFiL8Jd+B7yCmfN0LpgL9VsevtgXd7HHoBoKlz2l6n6tipQHTsHA2QQXadl5sWt50o6V4d9vVgkjWPPrWnvoZ2Ds4VGtl8lk05Lid9tJuPTrbpPNP3HHGz9pxhkZb/Lg1tQ4zXB+e9HnlWqhh+Sbj5nlJ42FWt0PdxUoJ4xtD6gwb+D0tPTDJYteVBaDF9t3oS5WwF/BSNTzSF5FRv+i8McqyaNcBpemDszq1lrCWCftqwgqKJjfvr+FxMpHgT6gkQ0CkJrlXn6urTXqVLZAEe83/TU7SympxBZ/PZaEHDZTPQQaVhrAO1k7UnzTcu0wLgYPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlLbJgsdjSGMJhZN68QCIRxS9jdKgUWLclRbvNAwLzs=;
 b=YhGqZRyMBBwSpiEaJh7PWl35yzukrAuE8Yg539uD8YEUmEUViP3M+TkRMVoCQsSbbwT6slKMiFCZlddCGlovVtdTswok55I/xADHxxNcmDFk3/NkCyiENDhXjPxx6h+zQXrYe6HBGQYDPi9BTYPQffqag1N8WW9tSNhY4tFLR1lfhrFaDr13wfUGrK06+SOwSKbRrcn8In2q1Ts5imFFNfAQaQox88G4zmf65J8G6YJ/3TAXLFeDyB6whfV1o2nnndMRncSwm0qHtlKjTi7tfKGTI4TCGfWm+fq+NEdIQLHd3nxyAGPMsFR3fC+TSzW2gz+o4D2K5B4rF/ndgmcvMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by CYYPR11MB8358.namprd11.prod.outlook.com (2603:10b6:930:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 09:25:15 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::a421:69e5:14fc:79d2]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::a421:69e5:14fc:79d2%2]) with mapi id 15.20.7202.020; Thu, 18 Jan 2024
 09:25:15 +0000
Message-ID: <459d6a3a-0ad9-4980-be37-103211e927c2@intel.com>
Date: Thu, 18 Jan 2024 17:28:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] iommufd: Support attach/replace hwpt per pasid
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>, "peterx@redhat.com"
	<peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
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
 <20231127063428.127436-4-yi.l.liu@intel.com>
 <20240115172430.GN734935@nvidia.com>
 <BN9PR11MB52761349DFB5DAD2797C3EBF8C732@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240116125756.GB734935@nvidia.com>
 <BN9PR11MB52763DDDE39C211E761A05168C722@BN9PR11MB5276.namprd11.prod.outlook.com>
 <88e46f6c-4d64-4357-be2a-833797e6de15@intel.com>
 <20240117125625.GF734935@nvidia.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240117125625.GF734935@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|CYYPR11MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: cd8efee1-222c-4e8b-b102-08dc180760dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sIvr6ZChM6vnV/mmHKXGaAdR9vhU/R4V9zbVfO8Biyc+HcCYTjhscpfBoyPUq5+DTk8uap5Tz3bfn0h/ZH4hJi4k6J6HZX851S/1Z0rQo1QCH2jgYHrUgdaooEXL9f/Ct/eN8HYBFg75muI0wEin09JU15WikjcEVqC37LN7SJcOqmxYmmlxuw9TRAegkLmjojHCj/4BTD4erepW8sXQMEtzb2j8w711z6NLq7Z2xaMt+88+6OsNMBT67GE/NYCEmnrSHGeiML1vGudKhCEtNHvuXu70PLTfhYhU/NRui36UV/3DeSyppcl+FlHvfjU61qC3sKOED6rfAoPVWOsZlS5LvPs4jnJKq80N5qBJYDRMezVLbg34IpZBozlSasoIJ8pQS6A6kxwHgB0SQpnoOsEnTYz4NZpjvbHRdpkGvtucAcGUZIyki5ECx1miCet9zU6UCfjtRXuRtTS6V3mUiQbp9BVVzF+ryyvy95rqG74XFnKsdGG621Y643zKugpRKgItvDr9ykdF+uHYn2zT0pxFEoMT37KEwU/jgoRh4dYtn9lJPZLvpw8TVabC5h0xQEr5jsRfR4TN4ap5AfCgkUgmhRa3XCGCimxtvLrTAdpbLrkIJQTZLjq8NG9xbvyz0MjD1Gt7QtlwRFwVSUfgrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(83380400001)(82960400001)(31696002)(86362001)(36756003)(38100700002)(41300700001)(6916009)(66556008)(316002)(66946007)(54906003)(7416002)(5660300002)(2906002)(8936002)(8676002)(4326008)(66476007)(31686004)(53546011)(2616005)(6512007)(478600001)(6666004)(6506007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjRVdnMyM3VmUnlZT1A5bDh4WHhaVEN2MWw3c0Q3c0hvdnJSV3F2RnVoNHl4?=
 =?utf-8?B?SjllRzE4WjRmM1hidFl4K3pZZk5vZko4NjV3WTVJUWpmUDFpZWpFaDM2VGNt?=
 =?utf-8?B?WVY4TTJ1cnNGZ0FyQ3lONjN6OVNRYXFLNUpOMnR6aW1QNktLN0w0RnBDcDRR?=
 =?utf-8?B?a1VvQSt2RGx0eDJuVmVrNW16bEl1Qnl3VnVNOU4vb0UvcXI5SzVrWEFra0Nk?=
 =?utf-8?B?eDZsV0psL2dkZ2t0R3hsanVBTlBlMEFzZHBlN0lnOVphZVk5TFp6bVRrUnQ5?=
 =?utf-8?B?ZkpZdW82WUpaRFptRlR2ZUpucUhkcW9XUWQ3ZUZFV1U1ZnptOS9xdzBkNkdI?=
 =?utf-8?B?NjZQa3RRS3Q2K2pqYUNKSWlwZ3RrbXNrSTB2ZWQxM1FNR2xXU09udm0xbHll?=
 =?utf-8?B?ay8vamZFZnUwdnM1RHgzN0o2RXpVeTZIRHNNZGw2MUYzU0VLVVl2V0g1ZUhR?=
 =?utf-8?B?aUdURVJhbGhMMTZTWVl4YzRxcy80NlpaMk9SMEFWU0hEdG1XTkhzRHkvazU4?=
 =?utf-8?B?YkQ1WTRsZGl1eThtc1VyMmltN0psQWRPK0xpWDdCcmpxaTRiN0UrLysyQjdi?=
 =?utf-8?B?MkdWemZwRWxRM3U0cENqOGd2bU1zV213eXUyZHRrdWFjc1pEWWUwU284YW5G?=
 =?utf-8?B?ZHdqRG4raTZMaFhqdW9MVlNkcEJMbVJ2UHdNVEJvLzdNMlk3NitsUWdQZmg1?=
 =?utf-8?B?WXZuMWRyS2srY0tQSFA0Mk9KRE1CK0loOW5QZkpkbUw3SXArd3ZiTzZKNVpT?=
 =?utf-8?B?NFlPdThzTzQ3ckN6M21kVjBibXp2dEx2TWVXWm9qRlY4bytHUml4cVhqY05t?=
 =?utf-8?B?WDVTOFp1R3RFeHk0YUlkUDIxRkVoR0xaWFZ3RWk2RUhXaGVLcTZIZUFNckxB?=
 =?utf-8?B?a3BvTURMZVcvcXIrNkhvdzU5RGdYcWtNWTVQTkg3eW9lSGlCS3JoQ3BwOWg0?=
 =?utf-8?B?blR2RGhJLyswQjNBKzlhbHlMZmZXbTQ3dUxSRjFSTVVpalhaSVRGNVU5ZkxQ?=
 =?utf-8?B?MHF1Rmx6VWlRMUVRUzFPZml2SE81amZPVmo0UEpla0ZtL3Z1RDJnT3FqOXpz?=
 =?utf-8?B?TnNUeFZWdjhnYWtTTlBaRldVSGpTSnB2UkhpS2hFdUFqOHpnTmI1RzNWeHIw?=
 =?utf-8?B?NXQ3dWwwT0xTcnNiejRPWmluemJCT3FjOXlNVU1XWEV2VVF4TTl0eU1HUWRC?=
 =?utf-8?B?WjNRK3c1M3J1WHRuUUtIOHE2KzhXN0VXU3N3NCsvRXhRSXBQbkhLU2dnQTI3?=
 =?utf-8?B?ZEdIa3pEVnl4V29DYWt3NHhjVWhZeHBwV1M2TFhUekM2bFoyVmxiWEFoVFVZ?=
 =?utf-8?B?U05DeFQ0ZmtQZmUzVDZpM0Q5S2Z4bjVDQmVaZzYyUzVWd0xUTmJzT2xHTlVr?=
 =?utf-8?B?UXYzNTVCdkl2R1hZQ29WcFFGT0pHeTFnTEgxMjFaL2NybHhnZHE1ZzZOSmRy?=
 =?utf-8?B?b1Rsc1ltbG9WdEVqS05XblJlTmN0cWRnQ09HZUtTdGN0ZWVlbGdqNlh4dlNV?=
 =?utf-8?B?Um9GeUc3a2NpYjhuVzBWdUJhdjBYZldDbnQ1TS93QjhwUWdBS0dhNnRLVTYw?=
 =?utf-8?B?NFk4OTI4aDAyRU9sUE9sYlBSR3ZPTHd2L3U3OEJhTTc5QkExaXVnNEpWV3pp?=
 =?utf-8?B?WUVCajJ6ZXEzZlhZeXBoME1nLzg0eWp1aHl3eUhzQlJHUGpFcmg3QzJyeFNO?=
 =?utf-8?B?c1dBNFRpUmZ1Zi9ENEZGcUdwUnp4ZDhYR3BKN0tMaFZXY2YvM05pb2ZhbXY5?=
 =?utf-8?B?WkVMckRTbEd1RkJFb2RwRGQ2WWdVd3JaZ1RadkdVYk5pWElUdndINnByQjVL?=
 =?utf-8?B?eEJ3NUNTdU9FNzVYVmR6OER6dTErYlFlZEpCQ0FoV05mTFlZY2EvVG9rZXVN?=
 =?utf-8?B?bEZSc3VWMlhVRTgyZFBWdG9mSHcyKzZramdwdE9YUHVyZ21yMWU2d0dFUVVr?=
 =?utf-8?B?OTBMdk4yd0ZhMkdWOXYrVGVONU9EUk9BWk1ST0N0WU5heFRxRzBjS05ncnRa?=
 =?utf-8?B?SXg2MkgzMnFXTXdJaVJOZ3hEVkJJRGdlQlAva1FuemFkcGtyR3I3MHUzdG16?=
 =?utf-8?B?blM5R2xqWFNUK3dqZkVhbnRMT21kUXl6OVA0WXNBbUpiM0Z3eUIzNkVGK3Z6?=
 =?utf-8?Q?IACSxzWBsiy7Fx01NJ+AH6xC8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8efee1-222c-4e8b-b102-08dc180760dc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 09:25:15.1539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iug4cia1Or0+v4m8Hu60YBRrxQjQWNDcduz8m+pSwsQvZfnuccv6GoxY1tdXPaQgsnBIeLTsdaqA1AeA0UyLAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8358
X-OriginatorOrg: intel.com

On 2024/1/17 20:56, Jason Gunthorpe wrote:
> On Wed, Jan 17, 2024 at 04:24:24PM +0800, Yi Liu wrote:
>> Above indeed makes more sense if there can be concurrent attach/replace/detach
>> on a single pasid. Just have one doubt should we add lock to protect the
>> whole attach/replace/detach paths. In the attach/replace path[1] [2], the
>> xarray entry is verified firstly, and then updated after returning from
>> iommu attach/replace API. It is uneasy to protect the xarray operations only
>> with xa_lock as a detach path can acquire xa_lock right after attach/replace
>> path checks the xarray. To avoid it, may need a mutex to protect the whole
>> attach/replace/detach path to avoid race. Or maybe the attach/replace path
>> should mark the corresponding entry as a special state that can block the
>> other path like detach until the attach/replace path update the final hwpt to
>> the xarray. Is there such state in xarray?
> 
> If the caller is not allowed to make concurrent attaches/detaches to
> the same pasid then you can document that in a comment,

yes. I can document it. Otherwise, we may need a mutex for pasid to allow
concurrent attaches/detaches.

> but it is
> still better to use xarray in a self-consistent way.

sure. I'll try. At least in the detach path, xarray should be what you've
suggested in prior email. Currently in the attach path, the logic is as
below. Perhaps I can skip the check on old_hwpt since
iommu_attach_device_pasid() should fail if there is an existing domain
attached on the pasid. Then the xarray should be more consistent. what
about your opinion?

	old_hwpt = xa_load(&idev->pasid_hwpts, pasid);
	if (old_hwpt) {
		/* Attach does not allow overwrite */
		if (old_hwpt == hwpt)
			return NULL;
		else
			return ERR_PTR(-EINVAL);
	}

	rc = iommu_attach_device_pasid(hwpt->domain, idev->dev, pasid);
	if (rc)
		return ERR_PTR(rc);

	refcount_inc(&hwpt->obj.users);
	xa_store(&idev->pasid_hwpts, pasid, hwpt, GFP_KERNEL);

-- 
Regards,
Yi Liu

