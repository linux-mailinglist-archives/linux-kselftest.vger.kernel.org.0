Return-Path: <linux-kselftest+bounces-19512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC917999BEC
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 07:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AD311C22445
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 05:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046051BFDF7;
	Fri, 11 Oct 2024 05:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mrj5i33l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5501991B5
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 05:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728622869; cv=fail; b=avzfPo3Bntqwf9ongJT66wrupuG5Ur13eYHVLdTDIWxCg/aPKLNSNm9ANvC/xBj1ARi70Vq477BMRbYydtNrcGsWUpmT8QuyvujgbjF7JRhhy4oPZPTKy9okE49cJJFfcfYE7WdZ5tZuL3V88hmpoHRuWPe7k2d4mXLV1iAifhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728622869; c=relaxed/simple;
	bh=BZQvzPPm3PnywEjBxCxK/BkmfJjpZvXZDM5S8skhATg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OiyQbOxtIltOdzMEgHXTKMwoZ1cAhgujyoVr5wtwHl1UH22uv664PzGPM/XQwHyvvWVpehAVZtXoWqeJUiHq6rKJOaQ3BewaSkr3qWcJnY1QAIDWUmY2JJex0JmzomqlDmdGYSiAVrY6E9RcAT4rqiAKWmqNuOShmEjWWUdyPhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mrj5i33l; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728622868; x=1760158868;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BZQvzPPm3PnywEjBxCxK/BkmfJjpZvXZDM5S8skhATg=;
  b=Mrj5i33lqkYWuOoMkT2YStt3QIKhP/0K3WwP1LpvfVomJHtQTwjUz4rz
   3rzjl8ufYRtvt72IyMGYz/4hRmY+rFlO/bGi9R7+ohePf4aMlZYIl5+sP
   eItcdoPccZldsA3jks+HoF/EckiTLiNPstqgfPsK2/Hv11e6xil0y8luQ
   s49wtt7HGdRBq41UosICdoVk/A8PLmXMlanPip30SQeP2xyX08sXUURce
   YW1dW0edzvPaXub/zNVkItrKAUApi9pxee4rlPXPLhNyDgo9/omqlnFkP
   soOyM9Idqv+rp/3BVL2RGFqelvgznWPoi7gftkx6e9anNNyqwZJjVgDg7
   g==;
X-CSE-ConnectionGUID: xkMtfi2BQNOhsv8cQgBxfQ==
X-CSE-MsgGUID: 5A8rwD7kSj6Yu9WJeUpW/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="31917799"
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="31917799"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 22:01:08 -0700
X-CSE-ConnectionGUID: jKceUz7iTByRL4ySXwso0w==
X-CSE-MsgGUID: zQdXp1s4QG2aZQeIbM9R+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="76905049"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2024 22:01:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 22:01:06 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 22:01:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 10 Oct 2024 22:01:06 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 22:01:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYNCq4ewXNjopZoeN8VgNJNLgapx/w7N8tYSqAqXEkYtvgXabwobjQjWdrr6Y22Lykib8D0g/RP+OusFa/J5jhlQXr0vTRumbrd5C2RpyT/T0eWVlWN/t3Kj69t/DaFgv7nXchnshW2WavzO1cCT2f6gp/5R+aj8XFrXF81XdLTMCa1+0SeBRDP38ix5prO21yDN4GSZhDmuMd7XPwC5Qq0uvc55lkRAdNglJwbDdMkziO4F9+5wIOmPTCMCMWHG2UM3yqFT2FBVZ1ZbOQbQ5I2l1Us6fVe/e2iWQpos0SNBhUso/ysoOj+kVfrrYU02OQ2Zns7M8CTfdsTHiuS8mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZQvzPPm3PnywEjBxCxK/BkmfJjpZvXZDM5S8skhATg=;
 b=xdEXHK98qKwFSO4+nM3fqYAyzQwpiMbzLMl0bKrK8i/THxok/junxPEcTVx6i9x8Nec4DhWzXjkBoTqCS1hUXay9xKYyTFp6xvYBU5IUxbRDfysdcT+HKZNRowo6+iOWFwUcj9UEtdXyAwxjYFEErz8KOHOqgzL1OZ9rCkrUQLB5/g9JQMoJa15NR6Q1DTf7yemg7qAL/5AG91aqYZhzNg4WDYvjWUFd6LRbvTUN6ZHhUejtL/dj9LbGnge0eBZOerZyu736RUAMdn22lx8v7uU26cWU7TUH3V0NdpgskenEkecwVSfRyC6dlrPCi3NOKKsX1fXVaccfrH4uU1GrnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8489.namprd11.prod.outlook.com (2603:10b6:806:3a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 05:01:03 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8026.020; Fri, 11 Oct 2024
 05:01:03 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>
Subject: RE: [PATCH v2 3/6] iommu/vt-d: Make intel_iommu_set_dev_pasid() to
 handle domain replacement
Thread-Topic: [PATCH v2 3/6] iommu/vt-d: Make intel_iommu_set_dev_pasid() to
 handle domain replacement
Thread-Index: AQHbBRRZ/Gs6JvHngEmEM2d8kGigh7JU8DuAgAALpYCAGwsiQIANvpiAgANlOPA=
Date: Fri, 11 Oct 2024 05:01:03 +0000
Message-ID: <BN9PR11MB5276D95DE99D1472EAC3A3978C792@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240912130427.10119-1-yi.l.liu@intel.com>
 <20240912130427.10119-4-yi.l.liu@intel.com>
 <a2cbc96f-7be3-4f70-a38b-540eddfd7c23@linux.intel.com>
 <52ec3423-6061-4178-8728-832b5f61af15@linux.intel.com>
 <BN9PR11MB5276AF2CB65A36369CF10A008C762@BN9PR11MB5276.namprd11.prod.outlook.com>
 <50824ceb-71c4-4b1b-95ba-291461d647b6@linux.intel.com>
In-Reply-To: <50824ceb-71c4-4b1b-95ba-291461d647b6@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8489:EE_
x-ms-office365-filtering-correlation-id: f09e1280-5ab2-417b-f21e-08dce9b1b50e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WEpFT0d6V0w1MmVzVXZiY25nckpnaWpwQ1U2cEZ5MXFYZ1FmQmdPUzJtL3lG?=
 =?utf-8?B?MDN4eVk1Q3RKRHFMb2Y1MzRJVlVUVmlUbkJtbXFpRmV5dzhwd2FVUnd4a1Ez?=
 =?utf-8?B?K0x5c1g1WFFrNERYRmY4dzg0aVUzWGtyVGIrSTdOZjNWeG1rdGV0cWhiL2to?=
 =?utf-8?B?K3ZkNEdISm41TitvNHE2L0V1MlpHSjVUMnZraVQyY3MrVFpMNmQ5MzNLc0VN?=
 =?utf-8?B?VGdWTlEwd2drclVqMVhNb1ozZml3d3NMUXIwbzBiVGE5VFJwQW5TdXZRdDYr?=
 =?utf-8?B?R0xiOWkxOTU3Q0d1SWRTOTM4bFIvb0FlV3BJMldUR0RsQXpjdkIrMEVaeWdC?=
 =?utf-8?B?ODRPTDdrMWtDN2Q3RmtDenJRTjBsa0ViMHBlVkM5NlV1NUlKdVhFMzRmQ2JZ?=
 =?utf-8?B?TGp0a1o5OXFFd2toRytqT2lKS0F5dUYwbWlUODVnQjE2VE1vK3VWcEhObEIr?=
 =?utf-8?B?aTNXQkFJL05pZDN5ZFVOa09pVGQwYlArRjVqSlRuUTVIYUpnU2pwR21xUHND?=
 =?utf-8?B?YXd2ajVETmt0cTFtUE1jWWxhSk54QXJ2WjdxNXYvNWRkS0hKaWVUUjlMRGtn?=
 =?utf-8?B?Qm1ENUZ1UURSVExpM3MwdzVCd1Nsb21NelRIVlcvN1RLMHFSdVE4OW1NYXJK?=
 =?utf-8?B?OFFhRVpkcDk3Q2hLb29yS29mdHh4OVRzcUk0M1JXd01qaCsxTWszekJ4bXJE?=
 =?utf-8?B?ZnFWOENrUjl5amt6eHYvelpyWWRldjhwczhET1FVZ2RGZHYvK21uQi9zMDlu?=
 =?utf-8?B?aXdhN09ER0c1QktyMjlNN3NDNnBuUndnVFgrc1FpRFliZHZVSmpTRDlnQUJR?=
 =?utf-8?B?QlZhclVWRW1FcHRMVDNBYjJ3Nk50U2w4R2xJRUhKWC9aMkFtSWdRNW1SVmxh?=
 =?utf-8?B?OW8wWDNVTm5Kdkl3QTZ4TTBST3A1TkVNMnUrd0JyeTFQc2NIZ2g3d0lKZU1k?=
 =?utf-8?B?YktSTWUyUzJmejBlQ2RPU0x5U1JsWURySnR0aURzdFpIYUdWMHhoZUttblN6?=
 =?utf-8?B?ZEVFUGRIcWhtbHlxZG96YTAzdDJWMzFudk5QQzQ2V1Y3bm9TRHZjVkJRVjAz?=
 =?utf-8?B?b2dWS0lwdkxxZmhLU0xmZmdIVCt6M3ViTzhQR0pGeXRNUmpnbUVJcFNZdGhM?=
 =?utf-8?B?MkJOUXQwWEZVS3ppejJvbnl1dGdVTGhRR0sva1YvSVFBUGlrdlRVOFQyTXM4?=
 =?utf-8?B?K1RXeXJBN0l5Rm4xb1A2R0tDMytqMys0Qzl6TVNnTWZrOVB5emJLT2U0cFVT?=
 =?utf-8?B?ZXZ1YldIb0pYazRteVYxNDlyYjVCb3BBZjRBSkQ3YmpNekFMV2Q5b1E1bmhD?=
 =?utf-8?B?ZHNaUXJpbjRLWWV6SEI1TVUxWGY0NHdVYjU4RXpyNjFNWVVpa2p5VklCOEVU?=
 =?utf-8?B?NzlOd2I1OHJqaUVSY3VValdCV0VLUmZZN25yS01QdmJ6QjdaYlNkaDN2R3FC?=
 =?utf-8?B?djZQN0orU3c0MU04OVZ6SThac3F0V0l1cHB5bk4yaUxOc2ExNmkrSXpjc1Yv?=
 =?utf-8?B?c1pRV2VOdG5PQytpZE5mWjRzeitIN3lSbzcxQUFZaWdNSnRaVVM1MXZESXRM?=
 =?utf-8?B?L0VlWkZ1WHdrdTJTVHdqU1pkWmI2eFAzMkNwMndZQWpFck10ZXBPOEVkVmVR?=
 =?utf-8?B?Ykdzczk3TWJKaWcyQWhWd0xKczJSUTc3UkVqclRONmlHOTByT1RJcVFNRU5Q?=
 =?utf-8?B?TEFRc3M5aTJHeFRZendacERvOFIxU1JBMkt6UlhhVHlvQUtqZ203SmhkOWp3?=
 =?utf-8?B?akoyd2VGV2lqT3E2NTF0U0FFWHFwbHpCRFZEUGoxQTFsVzNsaGNXMExNdHVs?=
 =?utf-8?B?VnhmZ0IxNXBmdkdSaFpiUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkZrcXR2bjJtbkVYMTkzOTE1N1c0ZGh1V2dQZFQ1QnFybnc2bktVcWN4QXk4?=
 =?utf-8?B?SXhkcGRHQnRCLzhWSUd5THZQVFpiV1NsVzhiY085SkwzY3Q1L2s2VGdYc3pV?=
 =?utf-8?B?UlA0V0RJVWVlRnA1Z0xQdUJWOW9tNlFhM3N0c2lCemx1bURRMjNXT3RidEcz?=
 =?utf-8?B?cExiL2c4SmlQL0JDTjRSZHlOWVVDanExSFB1aHIxZy9WMkk1aUdOSEtxZ2VH?=
 =?utf-8?B?TnFUcTE4R1dNYitwVU1YYkdac1N5QXhuaDVxbjBOQUZSOHQ5M2R1U2MzRFlE?=
 =?utf-8?B?ODZmSTRLVUdLTnpiZk94SWZTRU5QMTBMYXVPNTVhMDArN1JQTUt1NnRRWERu?=
 =?utf-8?B?NVVUM09lbWtjbXJDc3RNd201V0x2UTVnZVJRMHlsQTJGLzl5RE5uTTdWTWdh?=
 =?utf-8?B?djlDZkFsdXVPcXJUQWdIemQvUWRSQU5oalY5d0hVRVVhNTZxbEpuTzBtQjdy?=
 =?utf-8?B?S21kWWtXaVN6Tlc4V3o1TFhXMFYyMGpra3MvWjVUakNHcWhUUi9YU0N3SCtt?=
 =?utf-8?B?TXBBbTRMcUpzcEl4aEp5RExMbXM5K2pQKzJhTStWV3dRVk1oNFpqdVp3OXAw?=
 =?utf-8?B?VUM1VXdvUE1pU2ZlRGZtRFJzd2t2NFBkaU1jYk9VY1pZd3NNeXhURUExQW8y?=
 =?utf-8?B?VXF1VjkwRWxtNWZQelNWN0tLMDEvTmJUMGRvdHVjUFd5c04yWVZodFk1UzJK?=
 =?utf-8?B?M0RMRnJ5SVVERVV5OTB5UVFYa3Z1ZWxSRlNFWXlWbkxwdzZ6SThuaFY4b3ls?=
 =?utf-8?B?ZTVsdDZrRWcvbDV1ek83SUsrdXBCL3lXcmNNWXI0OXVza0JJUTIrQ0E1cEFw?=
 =?utf-8?B?czJpRXdOZ3ZhdUNZblppSHcwWGZvNk5ZVUppMFd0cHA4Q1lCWG1hZVBDVWxo?=
 =?utf-8?B?R09NZU9rRmljTHN3djBtL3lYOTB0RFFtaVFpUzlYU0VHMEtMcWYrV1FCSVhM?=
 =?utf-8?B?eXRkNkt6dUwxSFRicjU2eUgyRlBzbGhWVS9abWx4VjBMWG9uSkdtWG5JQmow?=
 =?utf-8?B?OTZHQ1VVOE9BOHN2bTNUK1k1Zmk5cDJXU051NWZDN0tvcUpva1QxRnlnTXU0?=
 =?utf-8?B?QjVOM3JYbHJFWDgrbEdWSmVSdjJLSnUyUmdOZk1Gb21NN2xJcHUvOW9pcy9G?=
 =?utf-8?B?bEc0dU1SZG9YSkFtdnh2Qlo3cjBhWUZCK2graVJDQUlvOE1hbHlKdGRsdnFT?=
 =?utf-8?B?c2xNYUtBUHl6VUtESWxvMmNETUNLaUM2RUdGVlNNUWNmcXpJdUNUbSttUE1a?=
 =?utf-8?B?Q2dkdDRNZW1RVElQdFVSbFZ0M3RDeG1qYjVrUWxzM1lqQ09STEw2aThLUnR5?=
 =?utf-8?B?ZytqK3kraHQwcnRWWXF6ZmYrektsZ2JYUmw3Wk05VXVNZE1SMXp1TWNKVUg1?=
 =?utf-8?B?Uk1yQWRiclgwRG03WWFXMUdrUjV0VVlaZnJ2TnRTaW4yTURGRG9zU2VoU0Nh?=
 =?utf-8?B?M0xnUjRnSlM4N2xLdEJ2ck03NGRUODVheEN4OUZid1BRbmdWTVFobUErejVI?=
 =?utf-8?B?bXVkK05qbStZWTA4UVNaaG53VW5rVURzNHNqNG1zR3ZFSXZxbUZ2VFY3SnAr?=
 =?utf-8?B?MEpld2F5a01IT1JJL2pySXhtYUlFZVR3VVVVMUdicXNuZ2JKanBTNlpyMGZs?=
 =?utf-8?B?bXl3d09uTmhERXdiUVR6aWJCdXF1b0hpZm8zdEFIcWR3dDhaNlY5bkdBNXRi?=
 =?utf-8?B?Nzh4Mm1FTE9heFhVQ2syQ09td2pYTFpDUEdaVEI1UlkwR0c5V1VaTCtKeVpR?=
 =?utf-8?B?ZjgrLzUzOUt6MUt2SkhtQ3NybHlqcnFSUHJEblF6QzVmczJRYk04UGlLUXlG?=
 =?utf-8?B?TVhKUGlIeGFmZUo3c09nOThhMzY3b3RlWVIrdnpESGFaM2JnRXFic2ozYnNG?=
 =?utf-8?B?SFkvcWorSUZydnROOUJ2enU3ZVAvSVBLQWI0cEoxYmpWK2ZOVUNGVFZaZkhk?=
 =?utf-8?B?cFI0TjFQM1picmVLdGdmQjhRMThLTVAzbVoxT0NQNUxCUUgyaUZjYUdWeTha?=
 =?utf-8?B?TDl3R0lUemxyZW8yVHNoWTYzZWdPTmR3TmRLQUxzc3lVNnJ6aUJRYzVpZk5u?=
 =?utf-8?B?QjBvRk54ZEVuajliaUF6bld4dnZjeEhyaW9TelZwNjBuQlFiLzM5UmdLa3J3?=
 =?utf-8?Q?eFLKjLD8Py1N13vpx1Pd/hjJe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09e1280-5ab2-417b-f21e-08dce9b1b50e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 05:01:03.5270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uIES1Bn3Dg64QKLqQhhFjoFsT7Mc1KQVDrumcdGdlk6hy/Bup1PEutejqDPFA5DGb+GvtDpiIVKamXiXGs/pLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8489
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIE9jdG9iZXIgOSwgMjAyNCA5OjA5IEFNDQo+IA0KPiBPbiAyMDI0LzkvMzAgMTU6MTks
IFRpYW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXgu
aW50ZWwuY29tPg0KPiA+PiBTZW50OiBGcmlkYXksIFNlcHRlbWJlciAxMywgMjAyNCAxMDoxNyBB
TQ0KPiA+Pg0KPiA+PiBPbiA5LzEzLzI0IDk6MzUgQU0sIEJhb2x1IEx1IHdyb3RlOg0KPiA+Pj4g
T24gOS8xMi8yNCA5OjA0IFBNLCBZaSBMaXUgd3JvdGU6DQo+ID4+Pj4gK3N0YXRpYyB2b2lkIGlu
dGVsX2lvbW11X3JlbW92ZV9kZXZfcGFzaWQoc3RydWN0IGRldmljZSAqZGV2LA0KPiBpb2FzaWRf
dA0KPiA+Pj4+IHBhc2lkLA0KPiA+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbikNCj4gPj4+PiArew0KPiA+Pj4+
ICvCoMKgwqAgc3RydWN0IGRldmljZV9kb21haW5faW5mbyAqaW5mbyA9IGRldl9pb21tdV9wcml2
X2dldChkZXYpOw0KPiA+Pj4+ICvCoMKgwqAgc3RydWN0IGludGVsX2lvbW11ICppb21tdSA9IGlu
Zm8tPmlvbW11Ow0KPiA+Pj4+ICsNCj4gPj4+PiAgwqDCoMKgwqDCoCBpbnRlbF9wYXNpZF90ZWFy
X2Rvd25fZW50cnkoaW9tbXUsIGRldiwgcGFzaWQsDQo+ID4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBJTlRFTF9QQVNJRF9URUFSRE9XTl9EUkFJTl9QUlEp
Ow0KPiA+Pj4+ICvCoMKgwqAgaWYgKGRvbWFpbi0+dHlwZSA9PSBJT01NVV9ET01BSU5fSURFTlRJ
VFkpDQo+ID4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4gPj4+DQo+ID4+PiBUaGUgc3Rh
dGljIGlkZW50aXR5IGRvbWFpbiBpcyBub3QgY2FwYWJsZSBvZiBoYW5kbGluZyBwYWdlIHJlcXVl
c3RzLg0KPiA+Pj4gVGhlcmVmb3JlIHRoZXJlIGlzIG5vIG5lZWQgdG8gZHJhaW4gUFJRIGZvciBh
biBpZGVudGl0eSBkb21haW4gcmVtb3ZhbC4NCj4gPj4+DQo+ID4+PiBTbyBpdCBwcm9iYWJseSBz
aG91bGQgYmUgc29tZXRoaW5nIGxpa2UgdGhpczoNCj4gPj4+DQo+ID4+PiAgIMKgwqDCoMKgaWYg
KGRvbWFpbi0+dHlwZSA9PSBJT01NVV9ET01BSU5fSURFTlRJVFkpIHsNCj4gPj4+ICAgwqDCoMKg
wqDCoMKgwqAgaW50ZWxfcGFzaWRfdGVhcl9kb3duX2VudHJ5KGlvbW11LCBkZXYsIHBhc2lkLCAw
KTsNCj4gPj4+ICAgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPiA+Pj4gICDCoMKgwqDCoH0NCj4g
Pj4+DQo+ID4+PiAgIMKgwqDCoMKgaW50ZWxfcGFzaWRfdGVhcl9kb3duX2VudHJ5KGlvbW11LCBk
ZXYsIHBhc2lkLA0KPiA+Pj4gICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIElOVEVMX1BBU0lEX1RFQVJET1dOX0RS
QUlOX1BSUSk7DQo+ID4+DQo+ID4+IEp1c3QgcmV2aXNpdGVkIHRoaXMuIEl0IHNlZW1zIHRoYXQg
d2UganVzdCBuZWVkIHRvIGRyYWluIFBSUSBpZiB0aGUNCj4gPj4gYXR0YWNoZWQgZG9tYWluIGlz
IGlvcGYtY2FwYWJsZS4gVGhlcmVmb3JlLCBob3cgYWJvdXQgbWFraW5nIGl0IGxpa2UNCj4gPj4g
dGhpcz8NCj4gPj4NCj4gPj4gCXVuc2lnbmVkIGludCBmbGFncyA9IDA7DQo+ID4+DQo+ID4+IAlp
ZiAoZG9tYWluLT5pb3BmX2hhbmRsZXIpDQo+ID4+IAkJZmxhZ3MgfD0gSU5URUxfUEFTSURfVEVB
UkRPV05fRFJBSU5fUFJROw0KPiA+Pg0KPiA+PiAJaW50ZWxfcGFzaWRfdGVhcl9kb3duX2VudHJ5
KGlvbW11LCBkZXYsIHBhc2lkLCBmbGFncyk7DQo+ID4+DQo+ID4+IAkvKiBJZGVudGl0eSBkb21h
aW4gaGFzIG5vIG1ldGEgZGF0YSBmb3IgcGFzaWQuICovDQo+ID4+IAlpZiAoZG9tYWluLT50eXBl
ID09IElPTU1VX0RPTUFJTl9JREVOVElUWSkNCj4gPj4gCQlyZXR1cm47DQo+ID4+DQo+ID4NCj4g
PiB0aGlzIGlzIHRoZSByaWdodCB0aGluZyB0byBkbywgYnV0IGFsc28gc3VnZ2VzdGluZyBhIGJ1
ZyBpbiBleGlzdGluZw0KPiA+IGNvZGUuIGludGVsX3Bhc2lkX3RlYXJfZG93bl9lbnRyeSgpIGlz
IG5vdCBqdXN0IGZvciBQUlEgZHJhaW4uDQo+ID4gSXQncyBhbHNvIGFib3V0IGlvdGxiL2RldnRs
YiBpbnZhbGlkYXRpb24uIEZyb20gZGV2aWNlIHAuby52IGl0DQo+ID4gaGFzIG5vIGlkZWEgYWJv
dXQgdGhlIHRyYW5zbGF0aW9uIG1vZGUgaW4gdGhlIElPTU1VIHNpZGUgYW5kDQo+ID4gYWx3YXlz
IGNhY2hlcyB0aGUgdmFsaWQgbWFwcGluZ3MgaW4gZGV2dGxiIHdoZW4gQVRTIGlzIGVuYWJsZWQu
DQo+IA0KPiBZZXMuIFlvdSBhcmUgcmlnaHQuDQo+IA0KPiBpbnRlbF9wYXNpZF90ZWFyX2Rvd25f
ZW50cnkoKSB0YWtlcyBjYXJlIG9mIGlvdGxiL2RldnRsYiBpbnZhbGlkYXRpb24uDQo+IFNvIGl0
J3MgZmluZSBhcyBsb25nIGFzIGludGVsX3Bhc2lkX3RlYXJfZG93bl9lbnRyeSgpIGlzIGNhbGxl
ZCBmb3IgdGhlDQo+IElERU5USVRZIGRvbWFpbiBwYXRoLCByaWdodD8NCj4gDQo+ID4gRXhpc3Rp
bmcgY29kZSBza2lwcyBhbGwgdGhvc2UgaG91c2VrZWVwaW5nIGZvciBpZGVudGlmeSBkb21haW4N
Cj4gPiBieSBlYXJseSByZXR1cm4gYmVmb3JlIGludGVsX3Bhc2lkX3RlYXJfZG93bl9lbnRyeSgp
LiBXZSBuZWVkDQo+ID4gYSBzZXBhcmF0ZSBmaXggZm9yIGl0IGJlZm9yZSB0aGlzIHNlcmllcz8N
Cj4gDQo+IEV4aXN0aW5nIGNvZGUgZG9lc24ndCBza2lwIGludGVsX3Bhc2lkX3RlYXJfZG93bl9l
bnRyeSgpLg0KPiANCj4gICAgICAgICAgaWYgKGRvbWFpbi0+dHlwZSA9PSBJT01NVV9ET01BSU5f
SURFTlRJVFkpIHsNCj4gICAgICAgICAgICAgICAgICBpbnRlbF9wYXNpZF90ZWFyX2Rvd25fZW50
cnkoaW9tbXUsIGRldiwgcGFzaWQsIGZhbHNlKTsNCj4gICAgICAgICAgICAgICAgICByZXR1cm47
DQo+ICAgICAgICAgIH0NCj4gDQo+IE9yIGFueXRoaW5nIEkgb3Zlcmxvb2tlZD8NCg0KTm8uIExv
b2tzIEkgd2FzIGNvbmZ1c2VkIGJ5IHRoaXMgcGF0Y2ggYW5kIG1pc3VuZGVyc3Rvb2QgdGhlDQpl
eGlzdGluZyBjb2RlLg0K

