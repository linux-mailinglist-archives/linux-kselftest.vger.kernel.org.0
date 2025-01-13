Return-Path: <linux-kselftest+bounces-24315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D3AA0B0D4
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 09:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37E567A347C
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 08:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C002232367;
	Mon, 13 Jan 2025 08:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DLksxyIK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1DF231A56;
	Mon, 13 Jan 2025 08:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736756259; cv=fail; b=ePVsZaP/vxBN6FsY+iGJ3xNbpwdi9zAUm1FRbzB3X0v7BD7RhOOoMYXm9wqIEMlpsadxjx9+KFpb9yoVlMj1eZcjadCMA40pTrwFmrHUCXqFC+BIu1mfSx4qAndnyZ4pIMZOYUYz2Jr0feWPkhaouHCNqpai8/CcSioIpKBUq2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736756259; c=relaxed/simple;
	bh=89BpI/eH3zJTFT+U9ilS3bmpFs4vpfywkGXPcVYl0yM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z37+REqjOHrZpGs+dzk+GFU1vCBpYcd7cLkBH4zbb7dQF+3m6Dx3ydXnaZfNKIYNtYQMLUF24V1zm6yA8kMrAqcPDuEi5Ku61Tq/LsR+zvC/7f7LOIFq7QuNckbscd4Xbrns5HJfxbO5vb/rKZXIEJ346PHX9oI5Nv/cbHSnKxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DLksxyIK; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736756258; x=1768292258;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=89BpI/eH3zJTFT+U9ilS3bmpFs4vpfywkGXPcVYl0yM=;
  b=DLksxyIKo6c35Vhn9aKcdm8i6X23CXgZFIXih8Uteu/5j/5b65Tyfz7K
   rEH9hkhuoGKV1FNsukQTy2bmEJ30LPZi0XoRiuYwU+YO/T9UOEW6eKGg2
   RNgJY38KJ4KAIB0UPeMuz8Gp5NXjFMC8GsQQ06DoDS7+2EKkN3nd69Mpg
   CCkqpuwyiPMmAC9t7imJSQaARVuK85i4Qtda641FNfAPj3gSnwS1cJ6pv
   xM39OiYlxihwtYW+w4sdzSiuL3/t1NQ+RVb4FsJz7tcjkuiW2lewHj2f6
   HzEFM6e8ShJz3oSiBuCSioBx2YOxzPHqRNF2AMS+4/AEOVKBTvWQQD97S
   w==;
X-CSE-ConnectionGUID: WQHPXyo3R1OY7BQvhiZruA==
X-CSE-MsgGUID: AtnO722LQQaWmNS0y1rXXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="37232580"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37232580"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 00:17:37 -0800
X-CSE-ConnectionGUID: BGA/Aa0eRgSHeCYu02dtAA==
X-CSE-MsgGUID: wpdhg2fASY6+8fr4oWBjIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="109332378"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 00:17:36 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 00:17:35 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 00:17:35 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 00:17:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhJx44G6e1gjCWaND4P2BBVgBJy/A8YsNjTYyGzSTlVXxKVIgBMSNA8a4AyTFnsZVYeM2ApaezlxLhrETEvOtN9yXxppL2lhh1Z6E5B8HSc5NK2QOULnPjcEgevVjYtltJM3yIhxddMETrzVpzDfi7tszUI8C/6zohQhBxFdeoK/iEQ4TDq4u19lU68L70pJEiBQqkGoBVMuOxmhjvs+28nASer6xEGXc1nAcwxghhpDay13RSL2wfWMYkTw0wiRK/zGELTD42wVYQk3HGHio40YjLDN6dbic1OXt/ReLDC4E7cUpAcWkuWzOG+6rJ6cGuHPLGLIqAdni+hhUvUHqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89BpI/eH3zJTFT+U9ilS3bmpFs4vpfywkGXPcVYl0yM=;
 b=HPuXgezkM56Dbtec/pf5Apsyon4kkoLjZwn83/l5XU0VfP13ANyQdWKcbDeYoMSfeD/V2HUq4VNjbiw/cOYqD8Ly/GOjr2izMnLT2faTNpVnSjoWMcU4qm6EnF1iwzQEPF0j450Vpi3hOvWOce0CaWJJrB27Lk8Dx5CL6xh/N4h5jYUAbdQH5ZjDQ6P55g55et2ySgGrz2aPcKQ4GZaSVzk6B0SMvBBHX86IHKm10QSnWfwY6RvVW22nukOECN/+i3cZY1su8ChgsiwX7P3KbPYgtSMaAT8D2nqHor5iYNIB/u32+nMgoh0924ep/iAM2EFMbg68Hyh67euYSU+s2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN6PR11MB8169.namprd11.prod.outlook.com (2603:10b6:208:47d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 08:17:32 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 08:17:26 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>, "mdf@kernel.org"
	<mdf@kernel.org>, "mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "ddutile@redhat.com" <ddutile@redhat.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 06/14] iommufd: Add IOMMUFD_OBJ_VEVENTQ and
 IOMMUFD_CMD_VEVENTQ_ALLOC
Thread-Topic: [PATCH v5 06/14] iommufd: Add IOMMUFD_OBJ_VEVENTQ and
 IOMMUFD_CMD_VEVENTQ_ALLOC
Thread-Index: AQHbYSc6iqK7HX06T0GpxaurMWOE+rMPlPbQgAD2JgCAA3pj4IAAJcuAgAA5XtA=
Date: Mon, 13 Jan 2025 08:17:26 +0000
Message-ID: <BN9PR11MB5276FAE8678BCA450B179E018C1F2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <86e78625c48d0c8fb815496dbc57708b98a46ec7.1736237481.git.nicolinc@nvidia.com>
 <BN9PR11MB52768B2EA84EDEFFB04662598C1C2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Z4GRMEjAIoBjHnMe@Asurada-Nvidia>
 <BN9PR11MB5276AAC06F5B90D09923677F8C1F2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Z4SbzRB8/me4kbDF@Asurada-Nvidia>
In-Reply-To: <Z4SbzRB8/me4kbDF@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN6PR11MB8169:EE_
x-ms-office365-filtering-correlation-id: e0a58d28-d881-4ed2-7f07-08dd33aab74e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eFlrMjErb3N4M2ZRbmkxaWxJRjJqNnRqcjRkV0k3UGZsaG5RV3ZEZzhYdmhJ?=
 =?utf-8?B?Z1NYMDJVbkFTcEthV0I5VjRROThUdW9KRUtCUTBJRUZ1MEd1MVhHVHlBbTFa?=
 =?utf-8?B?aWpqR1VFcE9Tc2Q3Sm9zYWIxaDNKbWU1NGZBczBlVlFiRWM2eG5vQWRpOGJS?=
 =?utf-8?B?aXFqb0FsOFdxZzFha0lNZ3F6eVpQTjIxQ2ZVa3lZZXhwbm5jeXh1MWlueHp4?=
 =?utf-8?B?SlZpNkN4aFN6V3dlR1VMREpwMmE3dXRLUWw4Wk9mNTZyWkR6aDFDREVQWjNq?=
 =?utf-8?B?YVNzNUY4S2NWRzNGRzl5VEFnamR4dnJRaGZxVkRWNEdVcUZCdnZOUFV1ck5t?=
 =?utf-8?B?ejh0cFpOQlN1NmwvSzd4R1o5UG5HOGVPNHh4WVMxR2E1djJtczhSYllPZkNH?=
 =?utf-8?B?bHR5cSttQjhlUUJZeVVDd2QvVWU1RThvUkdZNjg3N1NzQ1o1aENvSERtd0wy?=
 =?utf-8?B?S0g1NURnRE5RdEUrODgzbStaVERiYVB3TVY2ZUhJVXpHcE4zVlRYSHF1RUJL?=
 =?utf-8?B?RkNjalE4L056Mm1Qd1Z3OGNxQXQwdjlzSGFLeHM5L1M5Zm1oNko5NllxQzE2?=
 =?utf-8?B?VzMrYndIeVVjRnh5d1YyUmZST1RRdFpDakpXOUViV09ieHhHd1VXQ2UrczAw?=
 =?utf-8?B?MzJ1ejRSQ0g2WmVPVURUR0ZNSHNJcU95aVB1VzJhaXBEYVBIZFNIcEpzWUpU?=
 =?utf-8?B?dkdPdHQvRllJWUs1Q1c1anl1UDNxSFNkamtHVUh1UExRaVcyL3k2VDh5R3FH?=
 =?utf-8?B?WVNRZ1UxTVhpeWM4bFZVeFFYeUt5eDh1VHhIaE45TWNCUzNrMVNxZG5VTVgr?=
 =?utf-8?B?Zm5DOVNET01uMEFYajRUQWhXUnpZTFB4MjNYR3dtM3lrK2hPOVVKSlBHYnhK?=
 =?utf-8?B?ZGRlRmY3eGpXd0lEVTY1YVJtaW0wcUdCMnNkWnR5cVNDRFRFUzdYdnFqZFZM?=
 =?utf-8?B?QnZZMTdSWnRjN2xZMlNrTGJrbEpFZWFoZmFVZFR4ZURFbHMrTm1uQ2lUZ2dx?=
 =?utf-8?B?RzRXOEVrL0ErVnh3WXplYWo3bHowMG5uQlJMTlYrbmx2WW9ib0Qyc09lR0t5?=
 =?utf-8?B?OG5mY1dKdFlhcHZDbGhJWGwzajVSM0N0MUNBWC83c3F2Q2FMVFBXMmloR3pi?=
 =?utf-8?B?OHMvVG1ESEtwYjVEY280YjZkWGJuSVZsMFppQTdRRlRaMFVhNDRDZUdrY2Zj?=
 =?utf-8?B?bGkzMXRMWWh4TVVlWFhxRlkzWVBDdDBXMDA3WGNrUUpJRXZYYVVxL245ZjFW?=
 =?utf-8?B?Y2ZXeW5zZXBOYjhVZWpYc1RZSWgwUGd6a2xQL3YrM2FCOFJ5b1NaQlQ1akYz?=
 =?utf-8?B?R1lJMmFxOE1keDFrVFp6SGtFLy9oUXNtYzk5MVI2S3BnNlJCQXZJOEt0Mnda?=
 =?utf-8?B?ZjhoZnQ2OFZXOG5SeXpGVmpjZmRuRzlZT0FJejlWTlNiS25zTlRwK1QxZnZU?=
 =?utf-8?B?NGdyUzBsYmwwWWR1YXJOYlkrRnhOaFpwQ0VMbnJDdEZSUk4zK3lweThvTFhr?=
 =?utf-8?B?SWJqLzJvTCswb3JKNUN4U0cveUlHdjhZb1hmeGMyZ3FJUG5pNzJiUmlvUFhE?=
 =?utf-8?B?NVZXM09qNjV2WXk4VFdudFRmWkgxMi92Z1QwVm96SVNxakg4Z1JueUZTbFR6?=
 =?utf-8?B?dUgyb216STdXT20wTFBCdndyVVZxd0k0WWVuSHZmYXJGd215SUpQV1RnVStD?=
 =?utf-8?B?bzFzS0VqZkdXaUIyYkk1b0l5R3E3VmJ0SSs5YkJmbGp2cTdjNkxsVXYyOVB1?=
 =?utf-8?B?aFgyZXFYOFk3M1ZrWUFMa09JYkhqaGdHdk9sK21SMVdxSmd0b255d3g2bjNH?=
 =?utf-8?B?TVVqQnBmbTF2V2phVVF3ejdwVjZuUTFDeUYxenZmRXduM1ZPQ25oaVk0Yzk5?=
 =?utf-8?B?aUtzZ0dYN2tRTUJtNHRsKzF0WmUzUzZJWmY5NE0rQ2tpV1Q5M3FQL3VrV3JG?=
 =?utf-8?Q?5RVKwh9iA+hLNoygXSRRGkLRCK4VwLRG?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHhEcU9ZY0F6b2hGNURhVTkxazFLTy83Rmh4YUNuaGk2K2Q0dVZUTXc2c0d3?=
 =?utf-8?B?OHpOcTdvYzFHV3Zpdm5lK1hHbU03Q0svbzU2UjhaSGNKUjJvY3BQaERPQWJq?=
 =?utf-8?B?eTRKYWJhSTlYVFJNQ3NBZ1pFQXFSSXUwSEQrN0NaMWNKVmdYSUpsUXYrY0Fu?=
 =?utf-8?B?dFNzd0lKWDdZZHpjdzJ0Y3NMeHhtNEx5bEhMa1VQcW1FNHc1L2Jlc1NWbm02?=
 =?utf-8?B?ZE90T3Zja2laWGRtdHVWVVVkTnN1akprcUthclhPWjVYd1lIcEtBNWMxTFd1?=
 =?utf-8?B?dmFmU3l6YmNaMks3M1N5dWdlbGVrVTdtMlVORXErZTIrbjBEYUdGeHNnMGsy?=
 =?utf-8?B?d1dFTmt1NnN3ZmcwUU1ObTJ3SXJqYktvRGZxZjZQKzZVelYxc05tNHhtVVNH?=
 =?utf-8?B?YVR2VC85QnJsbkdCanlxOHRNTHg2NmtOenRLYis5b3dBUWRtUWY2MGdENlQ0?=
 =?utf-8?B?Q0xFeThsQkpyek16SjJOakpVNG9Uc0dLR0ZtUEpORFBnR3ZPUzhNbk55R2Z4?=
 =?utf-8?B?SGJ5TXNTL1VwdEJ5V3cvUGUzVjVBK1ZDMDdkaHd2VjBMV0tic1UvdmRLajRY?=
 =?utf-8?B?UUFEN3F2OHptMnFacEM0L0d5NVJudVdaRUNqZFQxNHdaanNoRm96bmRSb1FE?=
 =?utf-8?B?VG1ma0FndGdHMzhrNDVISUIxaXVZOXF3dTMyQlBNMVFPV2RqNTNYSlMxSkFa?=
 =?utf-8?B?dEhxL3dXMkNPUW9kMnFaUHJvVUFEcTNpcXdMZUZuWkV5eEpIbGE5TTVPd1F3?=
 =?utf-8?B?RW5xcWlxZlM0R05LZ0xLM0c5RWtDSjh3TmVzKzdyVC94ZjFuT2UyZTBRQm9N?=
 =?utf-8?B?dkF4Y2dmOW9UaXVnNVFrK3hLQnd1dHZjSkFKb0hKelJFTllDcXZCbGNISWlM?=
 =?utf-8?B?UnlnQXBEOUxrN3gxeFlIdmFoYWIwelhKSFdpY0FiUk12enB1YzRhR1NOd0Yy?=
 =?utf-8?B?VER3ekplR0lMY3I4akpvcGdVMmMwQTJkYXBhdmUrOTE1dmFvUGNadHFqd1hQ?=
 =?utf-8?B?NXpVMEFXUUhWRlpDOHlabGNpaWVFd3JpSFlIMmlaMExVZVpjeC9TaHRSQ2Yw?=
 =?utf-8?B?RFpXSDE0VlhhQjIyVUV1aVFvL3c3RVJNbyt3WnZ4SHlrTW9uOTJETGw5OGlE?=
 =?utf-8?B?dUZlVTdpWWFuN2VvUm5DRGlKQjA4Njh4eHJnQ3ltbG9FSm5Cc1J1clY0c1JZ?=
 =?utf-8?B?dmJKWjBFVFh1WUFkNlZxZjAzOTFGdDdzRUhiSGtZanFDd1h3Y0c2S0tTK1Q2?=
 =?utf-8?B?MklEM2xmNk5pSU9GMkdUYXptdnVIMTB3M0dmdkQ1cnRVaE5ZQXdkWjlNOHc2?=
 =?utf-8?B?eGtrYzIzNXppdG5YWHpJK1BwRkRsNWFrV0hodWlSYWY5NDNITUtFdVRnWUQw?=
 =?utf-8?B?SlF1Q2tjbHdGVVdqdjgyQ2ZiUjdhSTgrNFVlYmhXUndNUnE3UjBKeThROFp6?=
 =?utf-8?B?VkhFUzU4MHp2Y0hLWEkvMkh2QUpjRHpsK2ZFQjlSYnV0YVdiMWU3aFpzSnNw?=
 =?utf-8?B?Qkw0SERBakJaVjJFV0dONkJyeDhUK09COHVjbU16amxyNUJWci81VjFybWVq?=
 =?utf-8?B?Q2hvNlFFVkdrNjMrbEY5eFNjL0JyUXhTR1AydGhrbXVFMHd5SnA1eTFHL1Fl?=
 =?utf-8?B?U2ZDUEY4YUFobkYxODZkTzhSamU2WFh0cHp5YmFyMVE1QXJxQS96alAyWEFU?=
 =?utf-8?B?bWl3eG4rZUdzbCswbVpudEtiOTF6bmZsUDlRdTNIZzNOQ1V2T0hTZTRIK29D?=
 =?utf-8?B?N1F6U0M1MzZkQ2ZKL3ZaVTBBZlg4OWhWcFFkRG5jOERyRU5RTFFnTUNUR2s5?=
 =?utf-8?B?WHREbjRHbjJaK0s2WUFMMS9vYWpjV2NkdkVkS3BYZFNvWjEvRml5QTdtTndP?=
 =?utf-8?B?QnlqMTZ5TzdVR1JGekRMaVZrK0RMbnl0RUV3cTlrckQwNGduMC9OdEp5ZnVB?=
 =?utf-8?B?bFFxK292ZlMwZlUvcDBRQW5xZ1pvb1pnSXc2WGRwNW83eEpOMWxEVnB3OWVO?=
 =?utf-8?B?MlZRSWNKQ0hoS2hPVER3WVZ1dHQ2RThCd2lLaGFJU1BCSk5GNHJxWVhPRFBL?=
 =?utf-8?B?NFFKYml1bVFKNjh3YU4xRFlaTmJWNWpGVHpTSjZ0SXJUZWhxVmZMVjNsYkM1?=
 =?utf-8?Q?Gmu1Q22Ejqh+wUIbg2n/IWYy3?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a58d28-d881-4ed2-7f07-08dd33aab74e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2025 08:17:26.8708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lc6A0xMzWZ+XkssZKBIx9R3q6IZcVyAgDBfkYnjOjmJwNihYX9SE5RwxU2P6WJaJQYFq3ejXdKhdqlOqz87E8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8169
X-OriginatorOrg: intel.com

PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IE1vbmRh
eSwgSmFudWFyeSAxMywgMjAyNSAxMjo1MSBQTQ0KPiANCj4gT24gTW9uLCBKYW4gMTMsIDIwMjUg
YXQgMDI6NTI6MzJBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4gPiBGcm9tOiBOaWNv
bGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+ID4gPiBTZW50OiBTYXR1cmRheSwgSmFu
dWFyeSAxMSwgMjAyNSA1OjI5IEFNDQo+ID4gPg0KPiA+ID4gT24gRnJpLCBKYW4gMTAsIDIwMjUg
YXQgMDc6MDY6NDlBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4gPiA+ID4gRnJvbTog
Tmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiA+ID4gPiA+IFNlbnQ6IFdlZG5l
c2RheSwgSmFudWFyeSA4LCAyMDI1IDE6MTAgQU0NCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gK2lu
dCBpb21tdWZkX3ZldmVudHFfYWxsb2Moc3RydWN0IGlvbW11ZmRfdWNtZCAqdWNtZCkNCj4gPiA+
ID4gPiArew0KPiA+ID4gPiA+ICsJc3RydWN0IGlvbW11X3ZldmVudHFfYWxsb2MgKmNtZCA9IHVj
bWQtPmNtZDsNCj4gPiA+ID4gPiArCXN0cnVjdCBpb21tdWZkX3ZldmVudHEgKnZldmVudHE7DQo+
ID4gPiA+ID4gKwlzdHJ1Y3QgaW9tbXVmZF92aW9tbXUgKnZpb21tdTsNCj4gPiA+ID4gPiArCWlu
dCBmZG5vOw0KPiA+ID4gPiA+ICsJaW50IHJjOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArCWlm
IChjbWQtPmZsYWdzIHx8IGNtZC0+dHlwZSA9PQ0KPiBJT01NVV9WRVZFTlRRX1RZUEVfREVGQVVM
VCkNCj4gPiA+ID4gPiArCQlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+ID4gPiA+ID4gKw0KPiA+ID4g
PiA+ICsJdmlvbW11ID0gaW9tbXVmZF9nZXRfdmlvbW11KHVjbWQsIGNtZC0+dmlvbW11X2lkKTsN
Cj4gPiA+ID4gPiArCWlmIChJU19FUlIodmlvbW11KSkNCj4gPiA+ID4gPiArCQlyZXR1cm4gUFRS
X0VSUih2aW9tbXUpOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArCWlmICghdmlvbW11LT5vcHMg
fHwgIXZpb21tdS0+b3BzLT5zdXBwb3J0c192ZXZlbnRxIHx8DQo+ID4gPiA+ID4gKwkgICAgIXZp
b21tdS0+b3BzLT5zdXBwb3J0c192ZXZlbnRxKGNtZC0+dHlwZSkpDQo+ID4gPiA+ID4gKwkJcmV0
dXJuIC1FT1BOT1RTVVBQOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4NCj4gPiA+ID4gSSdtIG5vdCBz
dXJlIGFib3V0IHRoZSBuZWNlc3NpdHkgb2YgYWJvdmUgY2hlY2suIFRoZSBldmVudCBxdWV1ZQ0K
PiA+ID4gPiBpcyBqdXN0IGEgc29mdHdhcmUgc3RydWN0IHdpdGggYSB1c2VyLXNwZWNpZmllZCBm
b3JtYXQgZm9yIHRoZSBpb21tdQ0KPiA+ID4gPiBkcml2ZXIgdG8gcmVwb3J0IHZpb21tdSBldmVu
dC4gVGhlIHN0cnVjdCBpdHNlbGYgaXMgbm90IGNvbnN0cmFpbmVkDQo+ID4gPiA+IGJ5IHRoZSBo
YXJkd2FyZSBjYXBhYmlsaXR5LCB0aG91Z2ggSSdtIG5vdCBzdXJlIGEgcmVhbCB1c2FnZSBpbg0K
PiA+ID4gPiB3aGljaCBhIHNtbXUgZHJpdmVyIHdhbnRzIHRvIHJlcG9ydCBhIHZ0ZCBldmVudC4g
QnV0IGxlZ2l0aW1hdGVseQ0KPiA+ID4gPiBhbiB1c2VyIGNhbiBjcmVhdGUgYW55IHR5cGUgb2Yg
ZXZlbnQgcXVldWVzIHdoaWNoIG1pZ2h0IGp1c3QgYmUNCj4gPiA+ID4gbmV2ZXIgdXNlZC4NCj4g
PiA+DQo+ID4gPiBBbGxvd2luZyBhIHJhbmRvbSB0eXBlIHRoYXQgYSBkcml2ZXIgd2lsbCBuZXZl
ciB1c2UgZm9yIHJlcG9ydGluZw0KPiA+ID4gZG9lc24ndCBzb3VuZCB0byBtYWtlIGEgbG90IG9m
IHNlbnNlIHRvIG1lLi4uDQo+ID4gPg0KPiA+ID4gVGhhdCBiZWluZyBzYWlkLCB5ZWEuLkkgZ3Vl
c3Mgd2UgY291bGQgZHJvcCB0aGUgbGltaXQgaGVyZSwgc2luY2UNCj4gPiA+IGl0IGlzbid0IGdv
aW5nIHRvIGJyZWFrIGFueXRoaW5nPw0KPiA+ID4NCj4gPiA+ID4gSXQgc291bmRzIGNsZWFyZXIg
dG8gZG8gdGhlIGNoZWNrIHdoZW4gSU9QRiBjYXAgaXMgYWN0dWFsbHkgZW5hYmxlZA0KPiA+ID4g
PiBvbiBhIGRldmljZSBjb250YWluZWQgaW4gdGhlIHZpb21tdS4gQXQgdGhhdCBwb2ludCBjaGVj
ayB3aGV0aGVyDQo+ID4gPiA+IGEgcmVxdWlyZWQgdHlwZSBldmVudHF1ZXVlIGhhcyBiZWVuIGNy
ZWF0ZWQuIElmIG5vdCB0aGVuIGZhaWwgdGhlDQo+ID4gPiA+IGlvcGYgZW5hYmxpbmcuDQo+ID4g
Pg0KPiA+ID4gSG1tLCBpc24ndCBJT1BGIGEgZGlmZmVyZW50IGNoYW5uZWw/DQo+ID4NCj4gPiBX
ZSBoYXZlIGEgZmF1bHQgcXVldWUgZm9yIGRlbGl2ZXJpbmcgSU9QRiBvbiBod3B0LCB3aGVuIHZJ
T01NVSBpcw0KPiA+IG5vdCBpbnZvbHZlZA0KPiA+DQo+ID4gTm93IHdpdGggdklPTU1VIG15IHVu
ZGVyc3RhbmRpbmcgd2FzIHRoYXQgYWxsIGV2ZW50cyBpbmNsdWRpbmcNCj4gPiBJT1BGIGFyZSBk
ZWxpdmVyZWQgdmlhIHRoZSBldmVudCBxdWV1ZSBpbiB0aGUgdklPTU1VLiBKdXN0IGVjaG9lZA0K
PiA+IGJ5IHRoZSBkb2N1bWVudGF0aW9uIHBhdGNoOg0KPiA+DQo+ID4gKy0gSU9NTVVGRF9PQkpf
VkVWRU5UUSwgcmVwcmVzZW50aW5nIGEgc29mdHdhcmUgcXVldWUgZm9yIGENCj4gdklPTU1VIHRv
IHJlcG9ydCBpdHMNCj4gPiArICBldmVudHMgc3VjaCBhcyB0cmFuc2xhdGlvbiBmYXVsdHMgb2Nj
dXJyZWQgdG8gYSBuZXN0ZWQgc3RhZ2UtMSBhbmQgSFctDQo+IHNwZWNpZmljDQo+ID4gKyAgZXZl
bnRzLg0KPiANCj4gT2gsIGxvb2tzIGxpa2UgdGhhdCBsaW5lIG1pc2d1aWRlZCB5b3UuLiBJdCBz
aG91bGQgYmUgbm9uLVBSSSB0eXBlDQo+IG9mIGZhdWx0LCBlLmcuIGEgc3RhZ2UtMSBETUEgdHJh
bnNsYXRpb24gZXJyb3Igc2hvdWxkIGJlIGZvcndhcmRlZA0KPiB0byB0aGUgZ3Vlc3QuIEkgY2Fu
IG1ha2UgaXQgY2xlYXJlci4NCj4gDQo+ID4gPg0KPiA+ID4gQW5kIGEgdkVWRU5UUSBpcyBwZXIg
dklPTU1VLCBub3QgbmVjZXNzYXJpbHkgcGVyIHZERVZJQ0UvZGV2aWNlLi4NCj4gPg0KPiA+IFll
cy4gTXkgcG9pbnQgd2FzIHRvIHZlcmlmeSB3aGV0aGVyIHRoZSB2RVZFTlRRIHR5cGUgaXMgY29t
cGF0aWJsZSB3aGVuDQo+ID4gYSBuZXN0ZWQgZmF1bHRhYmxlIGh3cHQgaXMgY3JlYXRlZCB3aXRo
IHZJT01NVSBhcyB0aGUgcGFyZW50LiB0aGVuIHdoZW4NCj4gPiBhdHRhY2hpbmcgYSBkZXZpY2Ug
dG8gdGhlIG5lc3RlZCBod3B0IHdlIGR5bmFtaWNhbGx5IHR1cm4gb24gUFJJIG9uIHRoZQ0KPiA+
IGRldmljZSBqdXN0IGxpa2UgaG93IGl0J3MgaGFuZGxlZCBpbiB0aGUgZmF1bHQgcXVldWUgcGF0
aC4NCj4gDQo+IFdlIHdpbGwgc3RpbGwgaGF2ZSB0aGUgZmF1bHQgcXVldWU6DQo+IAlpZiAoZXJy
b3IgaXMgaGFuZGxlZCBieSBQUkkpDQo+IAkJcmVwb3J0IHZpYSBmYXVsdCBxdWV1ZTsgLy8gbmVl
ZCByZXNwb25zZQ0KPiAJZWxzZSAoZXJyb3IgaXMgaGFuZGxlZCBieSB2RVZFTlRRKQ0KPiAJCXJl
cG9ydCB2aWEgdkVWRU5UUTsgLy8gbm8gbmVlZCBvZiByZXNwb25zZQ0KPiAJZWxzZQ0KPiAJCWR1
bXAgdW5oYW5kbGVkIGZhdWx0czsNCj4gDQo+ID4gPiA+IFRoZW4gaXQgcmV2ZWFscyBwcm9iYWJs
eSBhbm90aGVyIHRvZG8gaW4gdGhpcyBzZXJpZXMuIFNlZW1zIHlvdSBzdGlsbA0KPiA+ID4gPiBs
ZXQgdGhlIHNtbXUgZHJpdmVyIHN0YXRpY2FsbHkgZW5hYmxlIGlvcGYgd2hlbiBwcm9iaW5nIHRo
ZSBkZXZpY2UuDQo+ID4gPiA+IFNvdW5kcyBsaWtlIGlvbW11ZmRfdmlvbW11X2FsbG9jX2h3cHRf
bmVzdGVkKCkgbWF5IGFjY2VwdA0KPiA+ID4gPiBJT01NVV9IV1BUX0ZBVUxUX0lEX1ZBTElEIHRv
IHJlZmVyIHRvIGEgZXZlbnQgcXVldWUgYW5kDQo+ID4gPiA+IGxhdGVyIGR5bmFtaWNhbGx5IGVu
YWJsZS9kaXNhYmxlIGlvcGYgd2hlbiBhdHRhY2hpbmcgYSBkZXZpY2UgdG8gdGhlDQo+ID4gPiA+
IGh3cHQgYW5kIGNoZWNrIHRoZSBldmVudCBxdWV1ZSB0eXBlIHRoZXJlLiBKdXN0IGxpa2UgaG93
IHRoZSBmYXVsdA0KPiA+ID4gPiBvYmplY3QgaXMgaGFuZGxlZC4NCj4gPiA+DQo+ID4gPiBZb3Un
dmUgbG9zdCBtZSBoZXJlIDotLw0KPiA+ID4NCj4gPg0KPiA+IEhvcGUgYWJvdmUgZXhwbGFuYXRp
b24gbWFrZXMgbXkgcG9pbnQgY2xlYXJlci4gVGhlbiBmb3IgYSBuZXN0ZWQNCj4gPiBod3B0IGNy
ZWF0ZWQgd2l0aGluIGEgdklPTU1VIHRoZXJlIGlzIGFuIG9wZW4gd2hldGhlciB3ZSB3YW50DQo+
ID4gYSBwZXItaHdwdCBvcHRpb24gdG8gbWFyayB3aGV0aGVyIGl0IGFsbG93cyBmYXVsdCwgb3Ig
YXNzdW1lIHRoYXQNCj4gPiBldmVyeSBuZXN0ZWQgaHdwdCAoYW5kIHRoZSBkZXZpY2VzIGF0dGFj
aGVkIHRvIGl0KSBtdXN0IGJlIGZhdWx0YWJsZQ0KPiA+IG9uY2UgYW55IHZFVkVOVFEgaXMgY3Jl
YXRlZCBpbiB0aGUgdklPTU1VLg0KPiANCj4gQSB2SU9NTVUtYmFzZWQgbmVzdGVkIEhXUFQgc2hv
dWxkIHN0aWxsIGVuYWJsZSBJT1BGIHZpYSB0aGUgZmxhZw0KPiBJT01NVV9IV1BUX0ZBVUxUX0lE
X1ZBTElELg0KPiANCg0KVGhhbmtzIGZvciBjbGFyaWZpY2F0aW9uLiBDbGVhcmx5IEkgZ290IGl0
IG1lc3NlZC4g8J+Yig0K

