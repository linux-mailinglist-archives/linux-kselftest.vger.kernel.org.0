Return-Path: <linux-kselftest+bounces-19605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E4F99B522
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 15:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52591C2123A
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 13:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48D11865EB;
	Sat, 12 Oct 2024 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HWmwS6u2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20907184524;
	Sat, 12 Oct 2024 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728740677; cv=fail; b=aZvBfnwP7t5KVa2XbUTDordePqfmMnc3qpIDF9DltkOKk5/D0pWk3B4ciZAAe37IlTDfXf78hvI3aR1nvFGoOMetKCVMOqRPv8SUy9EUfld9SuLJlf51dpLqo5+vD6tpT9zQr+KVxGichnCygIp2AU1tODdF+SZSPQN3USsEAFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728740677; c=relaxed/simple;
	bh=RTE5Qv3xcQorKRviymv+7Bs8mOQ787eksBuI67MDIOU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gc3mk0grLVRniGB/Lq+SbkZrb8h6kwgr3IETVxk4JbBUzCfKFVxnzU8zskXm3g5eMjR9cCEqxWwr/xMbBtZgtM9b8t5/u7xTtZORbWvnDpHgYlc02cSp+C5yM7b2gczHubSHZ2XRMOvT+W0GZEtlwruWvClt32sRD8sx/bJkZy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HWmwS6u2; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728740676; x=1760276676;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RTE5Qv3xcQorKRviymv+7Bs8mOQ787eksBuI67MDIOU=;
  b=HWmwS6u2kmsKbNdC63/eRyIw3aOH32DYxIdjLavkdPk4r75/pwtbYgVB
   zh95bmcxsDKWQ3y2vv32/SUu/5OWhHuDOyB4ln3XsMLTM4m/NnXXRKyL6
   MSAZY06L4l1ByZfqre4CJAgC6EJsWZVa0lIb5kpkZ6TgvB8599jC9hiuj
   WfTzyCMZAnjQ9PR9y5IZYrM+jmHmZ1LrtWJZfgR9A1p4VmvYYEXb1HOre
   p64Y5Pb5OWREv9792mvrACLYo4BRNu+QfseszPkc1c/KBLFFO9jsEpX89
   2eI7vIHm3I0OEo6U7daT1GkPHSrSm6B+QZTbP/QU+I939Hre1top5kYig
   w==;
X-CSE-ConnectionGUID: bJ63ibAUSMSeiMFmc4zd4w==
X-CSE-MsgGUID: oX2kxn9BRbmWbsRs+EbbvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28267532"
X-IronPort-AV: E=Sophos;i="6.11,198,1725346800"; 
   d="scan'208";a="28267532"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2024 06:44:35 -0700
X-CSE-ConnectionGUID: hp7V3K29TzyHxswVLidjDQ==
X-CSE-MsgGUID: izS9vYY1ROCVxocF7X3/ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,198,1725346800"; 
   d="scan'208";a="82163083"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2024 06:44:35 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 12 Oct 2024 06:44:34 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 12 Oct 2024 06:44:34 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 12 Oct 2024 06:44:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 12 Oct 2024 06:44:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 12 Oct 2024 06:44:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZEp7oYyQQjis1cHX/igNKm1CHFJc9g9IacZdQX5Zh2EAR4D58o62e2LGloVbxh7JsHMfOvciTtF/CGN9YnsKYw6y2ynxovNN3Kjgu1sViMSLus1NLv5Wc+l9wFlFJPF3Mu9PRGMQV3QgJEfUgxoxVeo86qoYlethLCqn4FxsJr/Q+vhnAusfqJ/2uFuc7GqClbHnRGLtVmaYx8YSTbXL8nGSkEQY9k5ZG92+ptOy7+MzPS102ZR3GMtMgTS9wECI4YVjq05XuOT6ua9taHNe4eBqEdLfYIISgN36J2l53For2xEKEoU8TdSVNuBvU7tPiwJL5FlPzyt0BmjVgJdnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7xYBB0tu8mRCPOKOBZx6ZxwmqevFksvlu55UtY3qsA=;
 b=fq+KLyPXgNsaHDw+zMDHywge2IKAZVCluM8x4G7fByCH1z+G+G6T41S/gQt3drq17J/YDHDnzvHJO+ULib4fd1wLm0fOqmm1BBHJI9P3TGPTpn3GMKTNuWmg3fye/9F1WnBhddnXJa9+SSVi4E6C8u95tAulOkmfSHbkS3vlTJm1+Vcr3JuRQnPKwMiPjl+2ccabPD+z2ttWCQ4b/cdkMK2eU5ryzhCvDbMrbJbazrhqN2+2I+2Xt1jXwYmN2x9XQBduK0n8p8rhtJutPzo0aTBAT2ewouXk6nwsRiLeBFEZf9V2j50zgHAdEmHHfv8IswQhKalrIC0rguk+ptRKmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW3PR11MB4603.namprd11.prod.outlook.com (2603:10b6:303:5e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Sat, 12 Oct
 2024 13:44:30 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8048.020; Sat, 12 Oct 2024
 13:44:30 +0000
Message-ID: <a435de20-2c25-46f5-a883-f10d425ef37e@intel.com>
Date: Sat, 12 Oct 2024 21:49:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] vfio: Add VFIO_DEVICE_PASID_[AT|DE]TACH_IOMMUFD_PT
To: "alex.williamson@redhat.com" <alex.williamson@redhat.com>, Jason Gunthorpe
	<jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>
References: <20240912131729.14951-1-yi.l.liu@intel.com>
 <20240912131729.14951-4-yi.l.liu@intel.com>
 <BN9PR11MB5276D2D0EEAC2904EDB60B048C762@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20241001121126.GC1365916@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20241001121126.GC1365916@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0220.apcprd06.prod.outlook.com
 (2603:1096:4:68::28) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW3PR11MB4603:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d605e4c-e063-4eaa-49cb-08dceac3ff43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVVwNVVOb0l6L1pvaTFNS2xRbXkwZVg4YWcrZEs1WEUvd2JGbUxpM1BNTVVK?=
 =?utf-8?B?UWs4VUJLNDFBRkZpOThaUzdJeW8rSjBhUEpRUVo2NlRyY3dtMkdXaGFscTN0?=
 =?utf-8?B?a2ZkWUhueVphT0JUV0V2SUR1aDdPOTNRZGlsM2VmUmYzTVJOYTFxQ0ZpTFlG?=
 =?utf-8?B?dkJmNDNaTGxnR0ZOa1dNNEk4dDBadllwdUlBdFNkRk00Ti9EN0taTHNiT3hZ?=
 =?utf-8?B?bW8zS0gxUmNKMVRSaTRDV2tzT3dQMGlUd0hnQW1QRlBWVFZxVnBDaXhZS2Vy?=
 =?utf-8?B?N3ZtTEZLRHRQR29wYzhxckZaY0U4Yk5JMnBOUk5SbEc1eEEyQmZuUjJzMTU5?=
 =?utf-8?B?aFh0T0l3TXViQmVQdk1RaDZFMjBBUTJJTzZtOGxEQUJLbEJyL1ZOM2dFS2Rt?=
 =?utf-8?B?M1d4dXJod3p2RDR0STZ2Mnc1OVZ4R09MSGJObkxNQzdPR2t3eElhOVRHRmdJ?=
 =?utf-8?B?cXVXc290WVVWSXVjRWMvb2ljUmxvbDZjY1hpaHZackRSc09hQkYwZVdUTU51?=
 =?utf-8?B?WnN3THNVMGw1NmJRL3JQQUFmZDJjTDQzWi9ieE1wRncvSVBGM3JFYlc0SHRI?=
 =?utf-8?B?WVEwSGFiTkxETHdtL0lBbzRZQ2syV2YrU1JXMXlTSW44dUZiYWJKR2h2cnZw?=
 =?utf-8?B?S0RORUtoeFNXL1AzNG1KRTd6dVNWaVVPUk55ZHo0TGFLOHMxeGltWGVCWjdr?=
 =?utf-8?B?L3FJZTYxL2h4N25zODJXNGs5RnpndWxxN3B6SXd1RW9QQkllMlZUT2loejJ2?=
 =?utf-8?B?bGV4enZqdzJBNlB5VlJqY1FlWGs3ckpGNkhHTE1BT0xnbWlVT0FJQXVNSVFN?=
 =?utf-8?B?WFpiQkNKbXN5NVRJN1FEdUNsYTlEYmFPckYwbFd5dWxEQ1RaQUhRSy9lZ2M2?=
 =?utf-8?B?QkpyaDhYVDNKbTZmYitIUkI5VXNwREtVejZxT0x6QUcwQVVqL0JjY2hrZUJI?=
 =?utf-8?B?cmRQNjJhZDVJaFRYRGhWdmVUb3RTdk4vWDJlOWc0VzdmanBUVW1TZXVZRkR2?=
 =?utf-8?B?YkRwalhVWDVET0I1bUVha2s5RHBqQkxGMXdocHd6SGhyb1VrYWR5MHpjd3VW?=
 =?utf-8?B?Z3R0eGpmUFg0Nnh4NVM1RjNIRkFzZXhwWGZVMXdBbkJTOXlzVGQ0eWIyTy9D?=
 =?utf-8?B?NGJpcmZObjcrL3FlMjNQcjRrNnRIZVBOL09PUXhZY3FzdThCOTlyWXh1WHpX?=
 =?utf-8?B?K3gvRHEyYzZTa0ttVnJNVHNuMzIzeU94TG1Xd2lxdHZrVThsK1krYmxNNVlI?=
 =?utf-8?B?aFR3V3JEVGh1OS9rOCs5dklGNnl4MXVYOFEwYWhUaE5qd0Q1QW9kQXJhR1dm?=
 =?utf-8?B?a29icFBnbmdKZ0ZkT2NkZnZocmRZMGVsWEQ0S25DbHdsbzU5ZG0rcTd0bC80?=
 =?utf-8?B?RlVJRERXa2d1VFJiais5WFNYalVLWTMwL3ROb1JVemFGVHl5MFFMMFhwWlpI?=
 =?utf-8?B?N1NzYTNjTWZiSTUyck9HNzNBQWdLdXlMeXA4QmFKVUFkRVorSWllV2pJeUVp?=
 =?utf-8?B?ZFExa1Q4VjVrbExhYlMyQlpwWW5LNklGcHJLOVpNaDI2MlU1bkdBTnpIY1BO?=
 =?utf-8?B?NDBSSmVNRnYxcHVER1Z0cWVOY1FiNmJIWklHaFZ1RzlaS2hEbU1TZGE5b0N0?=
 =?utf-8?B?YXROZk1QRHJ3TDNVa3VIRDR4ZTRxWXdVdmlqUnlSb0tmWXoyUnZOMGlCcjF3?=
 =?utf-8?B?M215c2hBR1ZOV3JUdG4xQzhQd1RpM3lNSFp6bWNMcHQyU1NjbzA3MlpBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGRNZE83ZkFUZGRwemgyNjV6bksrSnRSZEEvMlM5cjBtd0NVOVJkWE9FRE5N?=
 =?utf-8?B?a0NDRlRGQXVCc3lXbC8zUkp5L0R0WmRFMG1WTFE3R2p6M0RVcGpIRVlpSGll?=
 =?utf-8?B?UU9tbXdWYkZrSm5vbjFndWNRNldxM0thMW4xMUtMakJDV001OGxzcnpMZjFx?=
 =?utf-8?B?L1VwRnlhS0JXMlpTeGY2ZDJ2MVRyM0I4RHpyY0FwRFBNMFZpQS83TGg2U0lz?=
 =?utf-8?B?V2pyTFh4QjdIRENvZk93aUdJUHpVRU5uamtVUjlZQUdzUThEK1BTUGpZNGZy?=
 =?utf-8?B?dWRVN01NQXNLTjhyUXB0M1BFVjV5NmpqWkZ3dHhyS0FDZSt2TmNENnBLQVVj?=
 =?utf-8?B?c2N4RWUzSUxsR3RicUJ0VFZCUTZMb0M2ZjlnbEZueEhJSm9kekxXMEhScjhN?=
 =?utf-8?B?UHdLN3lKMGFWRDVGNEhyZ2s3WXRPekVMbnZxS2VqNFdSVUtBT2Q4OGVBVEFQ?=
 =?utf-8?B?ZHNBTHpyTGZJbENkVC9CdE05ZFhkb01Da3AxeGRHM2dGN1BwWktlQVJOdDBD?=
 =?utf-8?B?Tlh2QW9YOEtSZzVmYU44RDdoYzlla296eEVqTGNJS2l3SEJXWFk5WHNHWlhV?=
 =?utf-8?B?cG9PemZybG1LYjRDYmp0K3d3cTN3QVZnbHBkNkpKNEpEVFhtcmplbmpZbzNt?=
 =?utf-8?B?Qm9zWllqSXhSWU11Mk1HWjVZbGxoTFV6emRnclRReHlWOXNxbTF6dGR6U1N3?=
 =?utf-8?B?VmRUU3NMSzM0VTNIb01MZldLWUlFdGhHSytBOWVvQVZxRXErQzBGMVRMZUZk?=
 =?utf-8?B?eWNGYUxkUEswYWdLNGlpaTFZSlEyVUpmcXNxdnJKNDdmb3BRNEFORnRycUtY?=
 =?utf-8?B?RDNXVUJkUmg1K2RyVWhoWmc1bjZmRDA2ME8wOEpqbnQ1KzhwUExoVjhHMjBD?=
 =?utf-8?B?U1ZFbHZoS1Jsbk55a2ZFaTJyV0JmOFJGR1FsRXUzLy9pVHFqamlMMDl3ZDdn?=
 =?utf-8?B?UFlPN2FUdTVqR2ZhS2ZjeTJQNmYrU1JNV0VqSVBKNy9PYk93R3I5eit2SGIz?=
 =?utf-8?B?Y1FaQU4xeGt6RU8vVXlzeVBWcnRQQy8vQmZLZU1GMk8zWDQ2T1NIdkswZHZ4?=
 =?utf-8?B?ZEk2Sjc1b3pFdkQxWER3eVZUYjhqZ0toTk5OTWFzaS84V2hYZUpWZllZYTF2?=
 =?utf-8?B?YmtrNlhyTzR2eXJidnJ6djM4cDVHN1JaQnFFVzI1dTZkMklnQVBSYk5JUEVm?=
 =?utf-8?B?dTJObnBNaDFzeEhSQ044NVlvdUNRZHRyMVZTdGs3WTJyZ1BtcUJZV1RZV3Zw?=
 =?utf-8?B?VTJmeVFnSDZoRXlmVlJrQU1HS3ExOXlJYzgrS250R1VIZTJCT0VoMmlQdTVU?=
 =?utf-8?B?R256WmhKM2xnVnlBeTR3bTlkYlJwSmVpLzVpOFNsd3R6Q2JVZ0Y2ZFhCK1NR?=
 =?utf-8?B?NWc5R3JCWERDZ1ROSExvbjZQVWsxTDJIQlgvMk1ESGsySWtCbFl1VzR0SW1j?=
 =?utf-8?B?MnhtTDNtZkFHYmtOTS9JYTI3aG52UFNvelRsUDNvT2JtWFRwMmYwaG5tZVJj?=
 =?utf-8?B?eS9BdFhYUDc5eU1NaktBdUR3QXh0WFJWNnBiR0R3RE1IRE15VHI1U1h5c2Yr?=
 =?utf-8?B?ZHBQTjhFZkFPV2xmUVZMK3lMVkcwNG5RMVVCUTVvWFg4SkNEOXBzQ1NQQzRT?=
 =?utf-8?B?a3NBU1FKeVlmRmM0NlJlZTBDR0lmd3lNOS84ZUpERmI4MVpYMktsdlVROEZm?=
 =?utf-8?B?K25uZmVTUkJOalQyc2YxbitUdDZsUFljejFwNnBnV0FOdkxZRkJ6bmxWZUc4?=
 =?utf-8?B?M0l6RXdTQnR4RWkvNkQ2akVnVmNTeHNFaEFua051ei9VZlloNG5COUtEdFZZ?=
 =?utf-8?B?U2NsZjFpOW9TU1lXNmRMSkJBeFV3QzVlNWVodkR4SFhWY3lvQ2tDVlp4OVZv?=
 =?utf-8?B?UGN2U2tqaVlja2dFMzdNM3hPbE85TTNDWW5URDYwd0d5L1hXMUxoOFRQQ0Jq?=
 =?utf-8?B?aXdORHBoQkZKaDZqSkdZTlo5UHZlZkFYcEFGSWQ1anVpQ3dmL3ZGZVJSdzFq?=
 =?utf-8?B?UlV4SmVmM3NkL3V6S05KQ2g5QWU3OUx0bVFRVVdXZWorWVhrQ0k4UU10NXNu?=
 =?utf-8?B?d3F2V3d2WFhpV21TOHVXalREYmgrMGIxM2JxZTBJd1BYelNDZUtSdkkycG5V?=
 =?utf-8?Q?hqi6rE9fdjDyH4GXFZ3YV7gB8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d605e4c-e063-4eaa-49cb-08dceac3ff43
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 13:44:30.5113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ih2GMN0sRSwNCs3nLrqXk0MZVUSNPlXLCermDoSCnQt7TSTmHIPJeqAs6R+ZgLYVcdsVKAogWIW6FRADqV6BUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4603
X-OriginatorOrg: intel.com

On 2024/10/1 20:11, Jason Gunthorpe wrote:
> On Mon, Sep 30, 2024 at 07:55:08AM +0000, Tian, Kevin wrote:
> 
>>> +struct vfio_device_pasid_attach_iommufd_pt {
>>> +	__u32	argsz;
>>> +	__u32	flags;
>>> +	__u32	pasid;
>>> +	__u32	pt_id;
>>> +};
>>> +
>>> +#define VFIO_DEVICE_PASID_ATTACH_IOMMUFD_PT	_IO(VFIO_TYPE,
>>> VFIO_BASE + 21)
>>
>> Not sure whether this was discussed before. Does it make sense
>> to reuse the existing VFIO_DEVICE_ATTACH_IOMMUFD_PT
>> by introducing a new pasid field and a new flag bit?
> 
> Maybe? I don't have a strong feeling either way.
> 
> There is somewhat less code if you reuse the ioctl at least

I had a rough memory that I was suggested to add a separate ioctl for
PASID. Let's see Alex's opinion.

@Alex.

-- 
Regards,
Yi Liu

