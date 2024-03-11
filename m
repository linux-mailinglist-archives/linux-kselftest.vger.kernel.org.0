Return-Path: <linux-kselftest+bounces-6172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D573877CA8
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 10:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 810C11C20E6D
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 09:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCA71756E;
	Mon, 11 Mar 2024 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lOElgtRq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C1417548;
	Mon, 11 Mar 2024 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710149185; cv=fail; b=eCVhLyqAvaDidFAPTFHBSRJDi5KrITzjOWBcx3U6JXTv8zgSZzoL+erFcdhxBsf81v2w/g0btcODhuCAgM//+fADtsxJIQ1wKrom4117QQXtDwiYdQpUy+QI7Beb7YNjXYroEqJuN04wEcmGoX7ZY8koy2iOX6iCzGCEXWEZkE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710149185; c=relaxed/simple;
	bh=YCNGlj83nw+S2HiJQGo8TsEC3dReQDapIJPe6doeBNA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NZGWU9lP+BovfCQdy8KMnOKmtnnj9+tb2chroJ1N7qIJLiHFFUPmn7XJIB3ucDWB2gLGKDg+bgNbMbL2+icvpR6H9xb8lpCNytJjqTZN0YzQjZjBBVdGmkQO0veY392xARf6soE3QwnxX2068w/4k+1ox8CoIhnvkJ2jli1sOH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lOElgtRq; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710149182; x=1741685182;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YCNGlj83nw+S2HiJQGo8TsEC3dReQDapIJPe6doeBNA=;
  b=lOElgtRqKU6Ijfp2OXy+XoFyIqEhmvQEL6lVKGDU+6kzFy3mExcR7tSS
   FtjU7WA4ZlHvEa5heI3cynZg0/X/4dcFCtrFCj57+wQ01pn4zzxOeFw2f
   PRe3rluWaTuTpRkToAJ9aedaQArLh+24B+2OOuYq0xXd5/nT85V8USKg/
   HxAiSy45WPxI6DgRhFXGlWaV7IYIU6/LX3TNAWNCnKtRPigg1Bne2L6u2
   OZZb3/rZrIUNU0JOy6l7bOu7Y5NKVga9o2m46JJRQ1Dnf4A7cDWza5ziY
   Gf2tvKPoV5GBO6+zT3U1JwLm7/gsf3JN5oBPagKQqQHJ2RM2jFoymTnmL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="15440567"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="15440567"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 02:26:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="42035044"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Mar 2024 02:26:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 02:26:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 02:26:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Mar 2024 02:26:16 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 02:26:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9xC2HhcBTvC9CyFcbk9zfvMJLl+SoDqmI4EyND+uSwPj9vlRoLfjE/+vefrFbUR6cpOHXgJCAhBKxUDKvUBpFJG6htVEkRpACNuhUMPdzpH6i6LwpP7pDczG4AeOz88ARrRSrzvHWSlU2YpD9MDORsJKO9Q68h+LbEET2Lv6hgd4r0t38lCMxxZsK3rADRJchwtsyAGwh4dDqKGTbfTIw9vS265Z/h9qgj1YJUGmvCgNlckLFUr7DAIlHcnYxMuWsZrhXkueSc8dubi42/+FZl6EMd2aJS3zAgHw8dljM6BgfGaGJoAY7wxRDCWjRCYU483okmhDnskGEQZ1IBFmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCNGlj83nw+S2HiJQGo8TsEC3dReQDapIJPe6doeBNA=;
 b=BXJPAFrepPHBXhY4Vf3I2YcWxYoH/87KroA4S9oYDRPMdryqy7DAJVJpF+3e8PJespvAtTf82ZgWDYZBfJ2NPp4KUxmub4Xkfp/Erk/Rg0XBr8k+4WZc07OJpOs70eurt0riXwfMOmC+ncHRFaf5mp6QRttyaaaXg44QO9l2DJhdbRor6OcOOkvLqd9JMW++/sUuiYBPmBUSp2WcJnvaMKSqouphRRwAqMFj11v7FJ/PSAwUqBHiMTShaQ/7+geP2KHMWBVsURyty/1yVa1fUjeInyXFDEEDYPbhZTKP92+CeBeRN5JGDuxM7sDvFfkAy9zcmE7iASwWsARmm6tsig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5092.namprd11.prod.outlook.com (2603:10b6:303:6e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Mon, 11 Mar
 2024 09:26:15 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::39d:5a9c:c9f5:c327]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::39d:5a9c:c9f5:c327%5]) with mapi id 15.20.7386.016; Mon, 11 Mar 2024
 09:26:14 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
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
Subject: RE: [PATCH 1/8] iommu: Introduce a replace API for device pasid
Thread-Topic: [PATCH 1/8] iommu: Introduce a replace API for device pasid
Thread-Index: AQHaIPvLwYwLgeiapkWsYOVGHYVJTrDbbB8AgFYpTACAAVNM8A==
Date: Mon, 11 Mar 2024 09:26:14 +0000
Message-ID: <BN9PR11MB52766161477C2540969C83568C242@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231127063428.127436-1-yi.l.liu@intel.com>
 <20231127063428.127436-2-yi.l.liu@intel.com>
 <20240115171950.GL734935@nvidia.com>
 <c831bf5e-f623-402d-9347-8718987d1610@intel.com>
In-Reply-To: <c831bf5e-f623-402d-9347-8718987d1610@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5092:EE_
x-ms-office365-filtering-correlation-id: b2f5d572-797f-4755-63d1-08dc41ad4c7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fynPnmOfw+fH98CT/zwHk+GSkQDMobH0MaSOHtyA4gyXYfAneStzYKurITIsSQlr2ER7UpLyG+dCijGGduisc3C+aks1JbItGCc8DPK6mBursibgzYkA+L4KTpGkiDgqVH8ejH3bmqGGM3XHMOVx9gDMZq58CsdQEABOKVMjUwuLB0Lna5B8ED4LJ09IbahUYGF1ufGp230iiqlGwRNiNeC3vUK1/40bPsXcIXvDFU8DKdlteTqOkmb2rj552uQ7Ky2GHdtBL4zX81pr8dlPheeJ6Ml6Nrku9FjVzni3+P8pZWWQ17U88FXto16wWBxkoHLOBqGrRjGJReU9By7+xr485sbfTrclMpA7vvcOjrS7fnHp0r/eOqMxXtFgGO+Q6HWtvPoAinN/gncW+yO6njBC6WHfWNqZm17DiqoG+iQtrwWYF4CDItyLp+xR5hHAhBtSfKSDwuIvPhrWjPFE11HD4sq3be/BnU6IsCVGlObnQCYij8mdyuAn71lI7lNWvjM1xTKx8rPyhTRBfFAlxPOMj0+uusaQX6ZRpzpGxJMGbb68ugIQiM0/uz5SbmhYzOMclI8XrDKsTaK+Z8MJYnAgfjN8uELY4ouWWYilEP5DSi9Cptt/ZrtM5iwp3x4N8h5/ixZiF+1vCmbmBPQ/m2VKNqct6MScobfMCzOhbrQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjlUVTM3Z2sxdjl3VHcwdzV5YlV2SU5rbUkrN1lLWmJwYjE0ZUxHZG9McnVo?=
 =?utf-8?B?YTNLM2NSK0s3bC8ydjFkWmdiQldoS2ZBL2hLczdqdkFneU5GazlqOUY1MUU4?=
 =?utf-8?B?T1lxL1B5UHcrRVVtUzVTTENZTlA5dFcwRUpRbjZ3VVJaV1lETnZGcW01Ump1?=
 =?utf-8?B?UzgzMmF1QzNpSVppNnV6eUdZWVkwdC91RVpBQTRhUGlEU1ZJcWt1dDM3K0hW?=
 =?utf-8?B?Vk5pTnhhcjNiSDUwTGgxZEJFa2k3Y08vbnQ1T1dsQTRDc3dLelBmYlUvMUJ4?=
 =?utf-8?B?SFNZOGFuVkV4Q1hyaE1UWFU2Sysyc21IU3pHcnBPRDRQQWVpZklRK1NNaUdJ?=
 =?utf-8?B?czltdm1QbElXQlNQV2kxMU5ybFE1L0IwNW9Ma1VGZmNoVXB6WnJnU2VzQmpJ?=
 =?utf-8?B?ck9TbXZ1ekF4RnJWaTZUYUZjdUlFRHorRVBGR1dobjJ5c1pURDdiR0M2bDA5?=
 =?utf-8?B?T1dHRnBocHpJRElPc3hySCtXaDRtbTNJMnpLaVhCSHBsM2lHWkNEZ2xBekow?=
 =?utf-8?B?YzNnUXVDMXdMckV0Q3JPYVZCekZ0Y3huYnBEUTczTWdGWkFDdjM0Y01CRFFi?=
 =?utf-8?B?aU1ZZWlTK09rLzc2bjBUbmVlTHRVU2RLa3ZiL2xham5XbnJTbTJ2UEMvMktV?=
 =?utf-8?B?bXQyVzJLTVQyaEpIZWRvVGpheXYvT2ljT1lYd2xOU3VUVk5TeTJRblNsd0Rl?=
 =?utf-8?B?aVFkeUhzTkxoejlTaGhiNWFUWUlDb1BaZVhEM0hPVFpWdG11ekVOMzNzWDFu?=
 =?utf-8?B?WkxVUVI4OFlBMTlTa29EYTRXdkh3QUg4djl6eFIvSTNNWU41azRnS0wzVnBm?=
 =?utf-8?B?bmlHMlVFMDgwNXR2Z1lMV0VSa1cvRys0RFhEc2dIMG9LOHFzT3J4eHBkV2s2?=
 =?utf-8?B?UnNCRFk1SHhNeXBYUTdJUkc4eXdycFI0VThCYVBYR0N4MTYrYmJoWnBja3Na?=
 =?utf-8?B?Zk8zZzNEUXBseHM2L0RLeFMzbGFRejdid3diVVIybnUvY042RURRbWpERFlG?=
 =?utf-8?B?dWZCWlNwWlVyUThsOUlhc1pUcXpmcGx3VW1wbnpJKzN5bVdTemUyaGkrZlVo?=
 =?utf-8?B?ZnNmVTF0TmF1MklQeE9KMVlNSkRGeTRpQnZGTkM4QUh6ZWhIUWtJYk8zL2Mv?=
 =?utf-8?B?V1V4TVJxMzJXVi9vd3RJYXVvOEx2L1pkQkZVMUh4RnF1a0FZNENmNkVId09G?=
 =?utf-8?B?am5LZDhGYWEyREx0dktRY3Z2R0hNTjRzTmVzbVltSHE1enVIaEdKT1FESjBp?=
 =?utf-8?B?V09NTHczUkdrSzFLWHIreksxL3FSRTJyTUVmRWNrY3ZIclNubVdVeGRpL1Zt?=
 =?utf-8?B?b3VIMTIzdkwrd3VNTXVmdHV0ZEVvUGs0YmJESG1ZdjJnbzdWUTB5RU5nM0tH?=
 =?utf-8?B?K3N0WVN4ZWd4b1VieXNpNDl1R2s1dW5JUFYyQ0NBdEU5ZldqWmVQV2VZTWwx?=
 =?utf-8?B?cldqQ3JBUkoxamhMTllidHk3Rkx4UW1qakNhNjRxdk8weXA4bmp2d3hkMWNs?=
 =?utf-8?B?YlJuQ1hVdXF0ZXdGMSs4cHJSWDgwTTkreXVncTZmQ2JwLzBFZWpDUksvV0dW?=
 =?utf-8?B?NjNBS2lWdDFZczNhQ0NNb0VwbzNsd21NbVpPazVudWhwZ3l2bERCSGJDLzl4?=
 =?utf-8?B?SzZ6aUFhdXVlODdBd0FoR1p6c1JnUFVvZXV0TS9UQzE5d05vWVV6dkJxelVa?=
 =?utf-8?B?WlE3L2xrN2wreEk2cEVWYjlUR2FtMjhRbU1pTU5TWDVCWVB2cG56MmF5Ui9U?=
 =?utf-8?B?R3cwcHRRdlo1aHdUOTFIQmtSUTNsZjh5QWVRQ3JZN3lERDNhODJFa2hDUFNW?=
 =?utf-8?B?OWxmNjlVdzJFYTRxcXg0Und4Y1RUQlZjd25ScGFNQlJrdGNqb2dzYmU4UVo1?=
 =?utf-8?B?ZkVMM2tkdTZUdXJPTzJsRDVBUmNkdTExdkZUbE1rY1ZGckRsM1B2OXRFQlFv?=
 =?utf-8?B?bnMzNTh2NXRQd21aWlF1a0JiTHFuWUFHSHNUOWVOUTQ4TmdDTEV5THlVNlZv?=
 =?utf-8?B?dDFWY3drdEVxd2NuQXo0SXR4angzOTVnNVp5elZpR0NzSi9GK1BtNFNSM2M3?=
 =?utf-8?B?ekNOUE1yVFdKUDhpZVBDME5NUHc2T2dnUGlqUnJDTHlpZVJMQzRrNDVlbU90?=
 =?utf-8?Q?7oicmA7tELs+MMWt/ulP2NuB/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f5d572-797f-4755-63d1-08dc41ad4c7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 09:26:14.8110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nDO5saf8+gvYMbpLz4LGk7tVFyTCio3xWW226Izzb/a/A3pIqGyJRc6XhweFk2JvcXotClbD9848ficpliBNig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5092
X-OriginatorOrg: intel.com

PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2VudDogU3VuZGF5LCBN
YXJjaCAxMCwgMjAyNCA5OjA2IFBNDQo+IA0KPiBPbiAyMDI0LzEvMTYgMDE6MTksIEphc29uIEd1
bnRob3JwZSB3cm90ZToNCj4gPiBPbiBTdW4sIE5vdiAyNiwgMjAyMyBhdCAxMDozNDoyMVBNIC0w
ODAwLCBZaSBMaXUgd3JvdGU6DQo+ID4+ICtpbnQgaW9tbXVfcmVwbGFjZV9kZXZpY2VfcGFzaWQo
c3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLA0KPiA+PiArCQkJICAgICAgIHN0cnVjdCBkZXZp
Y2UgKmRldiwgaW9hc2lkX3QgcGFzaWQpDQo+ID4+ICt7DQo+ID4+ICsJc3RydWN0IGlvbW11X2dy
b3VwICpncm91cCA9IGRldi0+aW9tbXVfZ3JvdXA7DQo+ID4+ICsJc3RydWN0IGlvbW11X2RvbWFp
biAqb2xkX2RvbWFpbjsNCj4gPj4gKwlpbnQgcmV0Ow0KPiA+PiArDQo+ID4+ICsJaWYgKCFkb21h
aW4pDQo+ID4+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+PiArDQo+ID4+ICsJaWYgKCFncm91cCkN
Cj4gPj4gKwkJcmV0dXJuIC1FTk9ERVY7DQo+ID4+ICsNCj4gPj4gKwltdXRleF9sb2NrKCZncm91
cC0+bXV0ZXgpOw0KPiA+PiArCV9faW9tbXVfcmVtb3ZlX2dyb3VwX3Bhc2lkKGdyb3VwLCBwYXNp
ZCk7DQo+ID4NCj4gPiBJdCBpcyBub3QgcmVwbGFjZSBpZiB5b3UgZG8gcmVtb3ZlIGZpcnN0Lg0K
PiA+DQo+ID4gUmVwbGFjZSBtdXN0IGp1c3QgY2FsbCBzZXRfZGV2X3Bhc2lkIGFuZCBub3RoaW5n
IG11Y2ggZWxzZS4uDQo+IA0KPiBTZWVtcyB1bmVhc3kgdG8gZG8gaXQgc28gZmFyLiBUaGUgVlQt
ZCBkcml2ZXIgbmVlZHMgdG8gZ2V0IHRoZSBvbGQgZG9tYWluDQo+IGZpcnN0IGluIG9yZGVyIHRv
IGRvIHJlcGxhY2VtZW50LiBIb3dldmVyLCBWVC1kIGRyaXZlciBkb2VzIG5vdCB0cmFjayB0aGUN
Cj4gYXR0YWNoZWQgZG9tYWlucyBvZiBwYXNpZHMuIEl0IGdldHMgZG9tYWluIG9mIGEgcGFzaWQN
Cj4gYnkgaW9tbXVfZ2V0X2RvbWFpbl9mb3JfZGV2X3Bhc2lkKCkuIExpa2UNCj4gaW50ZWxfaW9t
bXVfcmVtb3ZlX2Rldl9wYXNpZCkNCj4gaW4gbGluayBbMV0uIFdoaWxlIHRoZSBpb21tdSBsYXll
ciBleGNoYW5nZXMgdGhlIGRvbWFpbiBpbiB0aGUNCj4gZ3JvdXAtPnBhc2lkX2FycmF5IGJlZm9y
ZSBjYWxsaW5nIGludG8gVlQtZCBkcml2ZXIuIFNvIHdoZW4gY2FsbGluZyBpbnRvDQo+IFZULWQg
ZHJpdmVyLCB0aGUgZG9tYWluIGdvdCBieSBpb21tdV9nZXRfZG9tYWluX2Zvcl9kZXZfcGFzaWQo
KSBpcw0KPiBhbHJlYWR5DQo+IHRoZSBuZXcgZG9tYWluLiBUbyBzb2x2ZSBpdCwgd2UgbWF5IG5l
ZWQgdG8gbGV0IFZULWQgZHJpdmVyIGhhdmUgaXRzDQo+IG93biB0cmFja2luZyBvbiB0aGUgZG9t
YWlucy4gSG93IGFib3V0IHlvdXIgdGhvdWdodHM/IEBKYXNvbiwgQEtldmluLA0KPiBAQmFvcGx1
Pw0KPiANCj4gWzFdDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iL21h
c3Rlci9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11DQo+IC5jI0w0NjIxQzE5LUw0NjIxQzIwDQo+
IA0KDQpKYXNvbidzIHBvaW50IHdhcyB0aGF0IHRoZSBjb3JlIGhlbHBlciBzaG91bGQgZGlyZWN0
bHkgY2FsbCBzZXRfZGV2X3Bhc2lkDQphbmQgdW5kZXJseWluZyBpb21tdSBkcml2ZXIgZGVjaWRl
cyB3aGV0aGVyIGF0b21pYyByZXBsYWNlbWVudA0KY2FuIGJlIGltcGxlbWVudGVkIGluc2lkZSB0
aGUgY2FsbGJhY2suIElmIHlvdSBmaXJzdCByZW1vdmUgaW4gdGhlIGNvcmUNCnRoZW4gb25lIGNh
biBuZXZlciBpbXBsZW1lbnQgYSByZXBsYWNlIHNlbWFudGljcy4NCg==

