Return-Path: <linux-kselftest+bounces-20618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E6E9AFCA8
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 10:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0587328295F
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 08:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBAE1D1E70;
	Fri, 25 Oct 2024 08:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dxGMEx/V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3101B6D16;
	Fri, 25 Oct 2024 08:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729845288; cv=fail; b=kR97zDpA34kCH8mrsvraijEcMmDwfuXPlvmQx6AwUr7jqxCIhMTJpE9BH8peHQdFExtpycq935H0tWIDxqGSruoqY4vQP40cXd/YC8wK6Be/b1vZ/qxTqdYOjBFNOoqz6JQbfSbITy198C/8yIXdJrCbQADwpcfxINbUKOjRBaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729845288; c=relaxed/simple;
	bh=xpsKCiTmN7WF+/A399ILYd4EezMR9hpaWqx1Dh4s2ck=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ScrwfYzjiT+N4vgyJ4r+ROIDIhDAB8zom+zjglTPFXpAnRjyqRqUYM4IRR5IFdVT2hVh6K1fIrv69vsUsk1UrZ66WguvBeC5HHnBL0AnynJaokQZCuQh30DGDjy+nb74fUEQYZaw9zzY+9HFjOYdUAS5SyIet7goD8PkKu3UVY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dxGMEx/V; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729845286; x=1761381286;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xpsKCiTmN7WF+/A399ILYd4EezMR9hpaWqx1Dh4s2ck=;
  b=dxGMEx/VoEWZyABz8Q5T9z4HgNMr8QXMx0N7GC/ObW1POWTbUMnK7QQ4
   g6x6/zT0q2GlyCeI2tgAzxXUNnxJ/jQ3D5oesHMYkD+z3vgTECnPiiChW
   jYqqUR8zLgybDKasBFxjvaMo+g6ZFQ8p3vh1k8hy13caQm9HMR2Ivntgc
   ZbXfjKMfy30wWI6/L5O6FXnqSjHpTyZ8cbBxbQnQ3in5F05pMw1/S3R94
   WhvGUNmXipfR6RBGs0bWVRpu8pC9uRZOJlbKjo5sh9mxX9FfRKV4giSAl
   +H5+l9RraM1jia8Z213oZUObppszs0EqlJ+Bcy85fJje6bOTAawb5WBbM
   A==;
X-CSE-ConnectionGUID: ARgTsqjxTN+jIl4bBjMmKQ==
X-CSE-MsgGUID: fxGRjQQLS56M3w+zZdqO9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29624948"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="29624948"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 01:34:46 -0700
X-CSE-ConnectionGUID: eh4IkRv9QuGMczECUUvVMQ==
X-CSE-MsgGUID: SQWlKbZhT+iNSYEGGqgQ1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="118313644"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 01:34:46 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 01:34:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 01:34:44 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 01:34:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blegazMw9BFHQeTut6vZ++APFL0Wfnk4nGJ+hZLg/aMWjMTpqKJV61EcEqKnCJCWCSW/rKVJIEU0N0BWg7QGaDkNwoq8OQijsLLR1kBKaenmxWnYkjt64n7iUA+s+z/Ay2RFOxDV1Wi+JJyRMaFyr+Y5uXJ3UCFAKqXynAfnszxwESRWpu/seG8Q+5vqAM3eK8g6MakhEgjsmdUrjWB5nuLRFpxAmeVQTYlhwf+o2nM92tAGTeUcbJ9A/4oSJmQE2SyIWfpcunsnWA+jD3WBv71JlcOREQyr/p0BvfyjoleUqrQTbied+OtslWLEUbpaFl1zk0EwX5BCDricSgZ3+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEX82ifqOAO2G80vzipFtTou7Hc+n01NJlyOTWqqFjM=;
 b=HLd01qsYtWMu5V2tZrIyRWy8K1KBVktFeAh7mqwCS4bXqEmL9RWszVYLTnH4Sk2Dj/tnRax1VOnEFg/TF1rFEjipf0MUT32Q0gmL/e4Tf69qhPzDHQp7kL79GtkfqsQ+oaL+mLnUJA7IDs7d+WMx5f0zZNyFap7uPEnq0E8oQpLztLwHfLQQkrWSrZaMALrFk+/wNByqYvrzKjSYoLR0kv8GFL+hm5E5rLwNNzRhgx5Rua89uhurWGoI1Ya6yvtdy1hOl4phJ0GsiJBhE8HW+872T6wBx48HZrRP8ZbkldgWspNzc2/SpBUQP/sMIdfjLPtrOlol0OmHfioxcHbeaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB4951.namprd11.prod.outlook.com (2603:10b6:510:43::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 08:34:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 08:34:42 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>
CC: "joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "aik@amd.com"
	<aik@amd.com>, "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v4 01/11] iommufd: Move struct iommufd_object to public
 iommufd header
Thread-Topic: [PATCH v4 01/11] iommufd: Move struct iommufd_object to public
 iommufd header
Thread-Index: AQHbJBg9ZB7w/xJSCUul0tcEfIpv6rKXKSoQ
Date: Fri, 25 Oct 2024 08:34:42 +0000
Message-ID: <BN9PR11MB52763F21882988C30500817C8C4F2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1729553811.git.nicolinc@nvidia.com>
 <1452c535a2e6a6c61f38fa752132db7e88b55770.1729553811.git.nicolinc@nvidia.com>
In-Reply-To: <1452c535a2e6a6c61f38fa752132db7e88b55770.1729553811.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB4951:EE_
x-ms-office365-filtering-correlation-id: ea537fcc-f3a8-4904-984d-08dcf4cfdf7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Q6XarbfyZJDrytwWoLPGK42PjrZ89y7F9Ec4FYWhlw6aUN0auNqZJW9yicVO?=
 =?us-ascii?Q?Fr6T1Jt3EpNwu4WHbWRjS7hBO8eUhSfaGFDRvUCd/sCGQBy/uWXAtHauSr2F?=
 =?us-ascii?Q?wB2c7z7clZdLj4mjlEIXXVpFEbS3zaRTqjYhM4vXZx+JABw8CofgBI1Ye2gS?=
 =?us-ascii?Q?JbxOUewhrLo6aOTr5qgzaHEFpLaVOD7jdbHw3w7FXdcA5RfSTBrSbJ9Hy1FV?=
 =?us-ascii?Q?KlU8sZLP7sya4oUbNavnD47wPtvI6ADSXOKSs/ouwMoFUWmQapUrKi3Ru9A9?=
 =?us-ascii?Q?QqDZd9oV7P7e+8nDoKo4u3Y/naDBRSD65G0APqQCcxX3h5kKdeGSEys3F7vP?=
 =?us-ascii?Q?g/J/VklowAAK2x+S0EO2M8lQSO+vVltzIwqNJ+UWrOYB/jC1InfOyx+MqJ2g?=
 =?us-ascii?Q?3Yv2W+NwLEhwozDxaOnHjNozkC5oJiv+FfYMMtzhXZ1+NgsJCqyqZarRZTSP?=
 =?us-ascii?Q?JbZK4hBD5CaYoiq5h8Mcr7vFFyH5aIJCSwap8gnhVCKkZCTilcpzr01uXYYs?=
 =?us-ascii?Q?SZoyD2bHIATFCQePTdk1zxcUWVZm7xt6ikQ/pU2PsADX0RW6vYgEwOkoDNmw?=
 =?us-ascii?Q?ciYLwqWy+0HI8YxqiwdzUPksOpoQsOD9Qa8v4ELwmb3hOcn08CMXzK9BtvVI?=
 =?us-ascii?Q?XKJBdiq4n/HOdsJ7vW3SrZ3yuffQjciYe/ovJ0bF24JeNLUUwwUu2fHjmXwu?=
 =?us-ascii?Q?DBETRG1BCWQB6jr2hmkTEXa02H8GJumkO1xmRktC/hRjKkycwm91Fafa0woE?=
 =?us-ascii?Q?V56NoM020LF2VdFbar173LuxyHSSJDpY2fMuc8C9lVyXHNjMklnODk5ty2az?=
 =?us-ascii?Q?isV2fNLshgeAPFx27AMwXrvW3Lkhp3r07uTpHaax7tfVdIrgL7U2Bdw0L8yJ?=
 =?us-ascii?Q?hvbCuFxTraazzZBctDvGvmlkeNMawzd4pbQffHvWLXsDM5EkrnfpVRFgxQCn?=
 =?us-ascii?Q?tiTSzUOWtORf0fEjI0bDacN4cF5vlpJDYsyFqyLtClqPRK4t3h0u0rwugKyN?=
 =?us-ascii?Q?HNuof3EKS40X6xt36rRStM+rSLJusMNHyHch1CAG7sQCdxcS6ZakboK1vQTG?=
 =?us-ascii?Q?dSUzxUg/i63IwX5NlOoG5X6dHSosYDXD07zZ9ya/maTQeDW48yWIIi0Ii3lZ?=
 =?us-ascii?Q?wShFmPCA6wTIpmzJ+oV45GfWfmtP6RgESmULGS6nKAespy8z66mBCrwlf1FP?=
 =?us-ascii?Q?FM0QQ494uB/192NeBD2qQglqF/8lYwTYiihcbkE2n8LCYofYOORX5byl45GC?=
 =?us-ascii?Q?F3i9Z72W7xrd52fDoKDfXuJT3M4WWq8MGwWYRARTBLYlib5uEwvyIMbGCpm0?=
 =?us-ascii?Q?Vs5XGUcznl0fEJv0mrHFeZNgbmEUQdQCd4egdosRT26TaoyzlV1aH3WzAZgt?=
 =?us-ascii?Q?j6dYGdY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/3bzguAtE3XadIbd4moQ64Heb+YIqjH40j9yQ+5PX/I26PqHZxVwCI8oF73J?=
 =?us-ascii?Q?t6fSFsVkufTCq9/lAdHjJLJPeRutLEiSFeFNpCdt8o/eUgxlBtWD6Mb9Ga2s?=
 =?us-ascii?Q?L2e1m1/PkSXKRwnLcKaFqn9V2x9b7ARYc9Ihma5HP4CRN3C5PDtp9j2U76qf?=
 =?us-ascii?Q?6NJJUE7B7QptkATSLUavN6zhOHnLOFKfPMUTTTCKtNCQN0Lyna8WOng3o+Bq?=
 =?us-ascii?Q?g6FUB9zBw8uX5L6nmewDRMHcnLnZPwTDR+JsGL3+KNNMYwnq0qI8tEdgHQIv?=
 =?us-ascii?Q?3Rjx3JYWURz9PpNDGvwowhQ0jp1pfF9GOholhAm5ZbsH0AQ7dgD2UgTu1LHB?=
 =?us-ascii?Q?SSIFrjAmar0I0uMcko7IltSHb2EOe/Hk0ytbudgeDeYxUIqHvl+OTE5mg9Ol?=
 =?us-ascii?Q?tHZDmtThcKJDpXgnV4OYNkAcdVWZ4l6a/MWc8amtV+9vU2QzOFiVP6PeVacQ?=
 =?us-ascii?Q?fxvHaJh+NneI/+CY0OPf5mFmYwWW3Pon5mVvOwhSDZxSHOH1QTHL9Dl1D5Dg?=
 =?us-ascii?Q?SRC2hGIZck7iKF99iNX/o3QnLR55ExGOsK+uaWXPqt28NFFV8JZH2/nOLaMK?=
 =?us-ascii?Q?J58PSIA9RNLDlx9023lX8ZiQEbhXfgMR9pdMl5K/xO80Qc3BUWx+k1pfn2oZ?=
 =?us-ascii?Q?rjLq0ny4IXZU2U2JWxi1VMXE6/VwTS1+lBxEAIZeg+EYfn/127pm2AWEM1lG?=
 =?us-ascii?Q?kjRXscxm3TtHtdGtCe+jeGmgLFUcC839XKX8pYVYOPtrA5NAlM1CwEjk8SYe?=
 =?us-ascii?Q?qe45+c73dbR0DT8ml3r1JIgk/aEHDfB1zDQfVJ6So/XeIHvcrzD4ovehQyTb?=
 =?us-ascii?Q?aNuDhVOcFro83MzDyUqSx3Rb+9h5cGnhpXQU+hmDLEiNq+JrPnPCOniIdW9v?=
 =?us-ascii?Q?Aud+fdgtbqq4i70Y2tmkOstl9pL0nGJ4tpXc+hSwskWxFfeSOgeCzphrr8OX?=
 =?us-ascii?Q?hCaz9Dc/ipROBoBfbC8ah7f+r/UssKq3g+yptsH0Gwl6FFsePZxCpnTrMTeW?=
 =?us-ascii?Q?YF4CAYfxOfihYQpxomM7hdfmA5tSY1CQbh6PmQ9rmxoR4wBWe5WOkn63eqjq?=
 =?us-ascii?Q?fqLEkDIvbO3ielVW6XzyHyJGquArVKu6/BJ3trTVZU/tKlQhpS+JK7HxFhp0?=
 =?us-ascii?Q?2oPU+spxlRs9/yFTnKQmlVfyHUCNEziOCnU/yG7fYf7BBn2LiQM4e3bhbuog?=
 =?us-ascii?Q?hQKrRn3lHDBPRum1GqgVKz9MHMrPmzHQukt9Ur2fAszS5r1vZx3tckqHF028?=
 =?us-ascii?Q?lqmi0sF6TFlxUkgvEjmjY88ijJcs0Z8Wp3PBLOFUqQ+8el5buAF4ltpSGM96?=
 =?us-ascii?Q?qbD04gI/4frytyAuPPOQCkknEoqpon4JcU2jcDY9dsbweuRQuScVI9nN0ugQ?=
 =?us-ascii?Q?ivOMwX0Ucd82A6b+BZfay/pjom1cRtnBRTJXw3Q8RDRQjZs407sqj4IckzR9?=
 =?us-ascii?Q?Tp/iGPJQXtpCOZk3yGauhV3Ch4vaSKUuRNzgdszBlJz3MjcvqXnWN4rzOK/v?=
 =?us-ascii?Q?HvmRpzpthL6nlRcHXpQmWiraRhfTsnH0Evv2IFSBsVxw8mPhNnaxULOrcgy2?=
 =?us-ascii?Q?5MItgm5aUQxfvHMV999nglkvI9ajBIEgeo1mliWD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea537fcc-f3a8-4904-984d-08dcf4cfdf7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 08:34:42.4655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: feI5r0/TTdvIWQZR+JXzBE0tzj0/RLx0reXxypjGE4lhjZza4mHyK7H1p4DXs1VtR9RwuYJcW1TUC9stO6PF2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4951
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, October 22, 2024 8:19 AM
>=20
> Prepare for an embedded structure design for driver-level iommufd_viommu
> objects:
>     // include/linux/iommufd.h
>     struct iommufd_viommu {
>         struct iommufd_object obj;
>         ....
>     };
>=20
>     // Some IOMMU driver
>     struct iommu_driver_viommu {
>         struct iommufd_viommu core;
>         ....
>     };
>=20
> It has to expose struct iommufd_object and enum iommufd_object_type
> from
> the core-level private header to the public iommufd header.
>=20
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

