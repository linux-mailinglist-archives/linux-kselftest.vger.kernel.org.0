Return-Path: <linux-kselftest+bounces-41808-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD1DB833B6
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 08:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8AE4540C8E
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 06:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C132E2DCD;
	Thu, 18 Sep 2025 06:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EeRh1HXR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3429A2DF703;
	Thu, 18 Sep 2025 06:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178689; cv=fail; b=aJGE68Dens9dA8eNpSaWVfsiRyItwYK1zHQRUYYGEzx2yAjI0MuLf82wqOGbAngVaRXOTJd/kcw1X0SaAdmmTAXXiuRrdOKdifKk52j8LrDETVfTTRfU05d/Ig0MITUuqwYmxUvSbNwZ3a+XX7aS86Nd4WIlFIssjvaEQBUO9Pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178689; c=relaxed/simple;
	bh=i2u06Gd5hZxGUjlI+7JEYLasoAdhUm+DNHEhdBKzZwo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=owNTNhylk4p+hlXETEh8I2g2oTw+iEQ10hY/PLqTqSbwuECCrPabcKkMUVP3eUOk1cCmGsDy+9Pf9m5LPDpAjOP13bYpuqThJTBfeqRdqvQE6/UYEfoIHuz09/wNg3GY7MYZZgK4tLYeDDcte8sJwXdaOycz785mlS9//o4EDB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EeRh1HXR; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758178688; x=1789714688;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i2u06Gd5hZxGUjlI+7JEYLasoAdhUm+DNHEhdBKzZwo=;
  b=EeRh1HXRkEPfD4PqYrDz+0PKodf+NXxcXs3yQrOEag3e299pWEO1dGhm
   vYRPjhHejxZHaZhlVXWizVDsjVzbO4tE1de/4DrLePTYX3z7W9lvzdAHO
   aqDN+vM+fIZCOB8dZQGan+Zi1dt5l+lweeOUhphhveMqLA53lcQ2Ry/NG
   AyO88YqvL83KcHYFCC9f7t3PZYQtYsnvBOzHmzGPfdNjYp8POtCdzuzJx
   GPvywyHxW2mgs4x84MYUg7YIGaLsWEXlFtPdQkG2tlwSeCjXSBeFHvW61
   dUmhvVkzA8hVg+d6odM0cqhlvD3HG9E/e5EidEpwx4VcAx9H5CXytMNE/
   A==;
X-CSE-ConnectionGUID: iyBnuTUVTj2ZhU2Mv1AQ0Q==
X-CSE-MsgGUID: 86hWsxL9RZ2cG4RKv663mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60552754"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60552754"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 23:58:07 -0700
X-CSE-ConnectionGUID: ivTmsX5OSNy4D3vxclHJqg==
X-CSE-MsgGUID: PLGZNHaJStGqEb/9D8kszQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="175035562"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 23:58:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 23:58:07 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 17 Sep 2025 23:58:07 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.24) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 23:58:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNf+GuRErtsqELseIcejNZDDvT1i9ER4R7bRPLepIeUYZVREJOUQM+pu3dtaVCCiutE/B+RApF87aD0iYXCZ++5s4I28LAPwddoZOqSiku6+pt1cbYuZXIAQ2/MUWnm70jYVTVCMa4xYXB9wB0aABDFYObp+8181duVHQTJUdfjAo1yuUFwtc17k3CgELfzWY51bSnwmOS5EBQkZpYGTZDjmndjMSRIMKwMYAl3JvQ4Yjh9veJNBEoL92smWlaSyIzGT+HtCPHI+okdhUNLo+4XEjI1e40D5MRwHM47uxlhSl2BnqwXa3q4nkeqFR71KaxT4q1uO2qhd0o3xgZ8+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+APZi5tVfI4fjiSS2bQIVAL72ZODOjw+izL6NtCpZP8=;
 b=QmBBYMtHzRG34iQaBHerE3vpWpSSF803tIosRg4hSQOHZQaxlUMcxaM1FRO3o71yGFymuj8CV3gxj3EP8Z12BQeXmSs9eVRj5BTKeHxI6xNQSxNQzokdZXIZPVPC25RW5zDr88RvcaFdPCLyQ/Ol3zTpqnXgtfIz1MHBq/Q5N+7PT/RDyRlJGw1m8Ot3aT7PJSf4Pk+kC8K/DdVwJGpwblnyiG9jMkCnkDkr1EM4GJAk9HnLEmDORi8KE0yC2icGhvzzgMelQ3OXQA+QM1TVQYw1YRRQdAtBOUr7LgJbk9HwE5LXuUJozo4+aGLFnQkRQ8NcQcRH1RaJG88QOuKiIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5010.namprd11.prod.outlook.com (2603:10b6:303:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 06:58:04 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 06:58:04 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, Justin Stitt <justinstitt@google.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, Bill Wendling
	<morbo@google.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>
CC: Alexey Kardashevskiy <aik@amd.com>, Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>, James Gowans <jgowans@amazon.com>, "Michael
 Roth" <michael.roth@amd.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 03/15] iommupt: Add the basic structure of the iommu
 implementation
Thread-Topic: [PATCH v5 03/15] iommupt: Add the basic structure of the iommu
 implementation
Thread-Index: AQHcHPrR8MFcZTbSXECVEcBg2V80YbSYmJ3Q
Date: Thu, 18 Sep 2025 06:58:04 +0000
Message-ID: <BN9PR11MB5276DB96BCDDFC2DB68FAE178C16A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <3-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
In-Reply-To: <3-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5010:EE_
x-ms-office365-filtering-correlation-id: 3f51be82-bd52-4415-2f45-08ddf680b71e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?g+3bXCPC/5wbW7tEmCSJJKkWvBO4N7z5AD1vMljdlkhJT/GZc2e4PdrUqvQR?=
 =?us-ascii?Q?W0Ra1BDPnpbUgvvukX7xWOuFV/VY/khSuOWL0YMjub/YizIeHGmtb2PwlFR8?=
 =?us-ascii?Q?LOMR9gjkFn+6M6Go8rywAwXm/NAtap5MPiag1ayT+8satDgW1vO0rnccxU4O?=
 =?us-ascii?Q?k5apaPQzUc+Ypw4omzjzlGquim1/EGXEMxsbAYafAee/WL9j+7k3pks36B9E?=
 =?us-ascii?Q?gEPw/2pfMY7srHv+bS0TO1Jfp81zQsbTi+zZGmW8gGor/PGbplMItIl+amwT?=
 =?us-ascii?Q?q9ZJL0/nBK7xtfz7Mkw9GuAWDwxgaibVdbcoXmZ1doX8gTiRh5toZGFaUoaM?=
 =?us-ascii?Q?nkncg4H3dqNppmMh5RedVlh4dnZ2eUBD/k746OhrYjSyFCQgbIfN+MsXpxSI?=
 =?us-ascii?Q?FknnrXMdCF09sXAmytJfbfPWyxMfb7v3A0NFOGp8vIyk2Vyz1rzOglDSdIO/?=
 =?us-ascii?Q?LAOAjznOWF8wCuFXDSoFPRjDLUv5aJHRa3raGDaHSxFjNO4r3/3q68Rd2Fnc?=
 =?us-ascii?Q?hORw8QWRK90jxLl9h/aX5qAhG8KNzl7GWac958SfYHvXkh61l3t7G3brNU0N?=
 =?us-ascii?Q?sM1VRScTdmq4HtYvBP/XIxJTcWBkI2je0v5GkDrkKOPoR5oWoZcc/WCh01Mr?=
 =?us-ascii?Q?1vwp/z/M2XDsBaS+Q8qkM425UsvH8a5Yhzdq58WxfitNkNxt+YY+EtmhINFa?=
 =?us-ascii?Q?Tdiduh6lRXbRKUqxF67Ul9niTXOhLMobdmTjpuCJMbUGqgEzsJSWXc5LBhBk?=
 =?us-ascii?Q?twVAIWPz32YOgwdZoIFxqBIhxRFCzfhK7aEFjau4oQGsWMNfS0ngRfsvyYhO?=
 =?us-ascii?Q?81wRg+BjnRsrvu2WmiZoIHTcZcAYEAzVm64BcKWA/ngjPGKtbtV3K0TdnosN?=
 =?us-ascii?Q?2U713X7uCf/1Ky40braO8ocP205l7duNfsmWf9o6CxeBCqFK3CZfyx6SmWWb?=
 =?us-ascii?Q?Mh0LN/4WZJ4a/cje2v+Y17Abb6jA9hNeP+65vFR6T6i92qBghlxHdfhcNVvN?=
 =?us-ascii?Q?BSjbCOVMTujDVj6jCmHwuH/TzEozd005iYziRR6VBJ1bw6KTY7fB9XlEtaZW?=
 =?us-ascii?Q?eksMGH7dNvrYiuE+Uw9BTtjpTBljyAQE5VyYLTEwMz5cFWGHFeyNZ29CgH+0?=
 =?us-ascii?Q?n8QuZJlAn4NzLDrpmgcOZzwM7K0F+iyyAFQwl1BSshiYOZv/L0sHbgXuHwhi?=
 =?us-ascii?Q?Hv6KeVvQFhfI6taIhXWzAUGuRTx4RBPi3W6T6i/kroqBrgmeP9Q7qBZ4Xf69?=
 =?us-ascii?Q?ClH3BiiXLXNM34YwqCwEcXzDMb6YsuQ3D3wqCg6Co6MZOuctqJV04rB+qW38?=
 =?us-ascii?Q?4V9MtQ2XXljyR38VA0HurZJv7WZXvm/G24myC1zOXbXe1qvyNErXrYxlJjxn?=
 =?us-ascii?Q?y82ODYNqXQdxQPTC5KmqprIbweXCiA+hwJtkMkXq7HPFwM4b1x3BYQkJTT11?=
 =?us-ascii?Q?w2wAwOSspZbd4EDViXTI89Ftlp/qKMxhHQB/HWqlsWYG96g7ubfyB1x/iof9?=
 =?us-ascii?Q?gxUmOY8EmGi/lTs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ugpetghNtc6BmJuGKKk9eLIupqNMvjjdT664siPhVdOg68rhGUac4upmkQvQ?=
 =?us-ascii?Q?pXkKl/o4BE1AjjzqMrNWVcIhyTYikYdk+MQ3KIiV+c910xIYqMcSt8gzpytK?=
 =?us-ascii?Q?W66tdeU3B6T8RxhWl+JN93lQO82LyoyB25VlyBX7eLQqgqMy/YyvhJ3za0xU?=
 =?us-ascii?Q?KCgfmb/EZIa9UN85TnIPquBJguttOYtttRUepM+r8XdSVy3vpNFfG9msDbSs?=
 =?us-ascii?Q?5q8qnYiPldfT4A0S/wT8Y8X8dWv61v2WChHNfcv0J9lO5Y+Z628dr7FKnOEj?=
 =?us-ascii?Q?utGVfXC2SPJCMMZjpPqVLm2G0roCoMrelIYLQwaTIwFAl4PepuKGUzdHDXoE?=
 =?us-ascii?Q?A6zPnBoLtzTc4NmirnfnJJ/4iohUdHGAqNVGmADfZN3ss6m3A87VKF9hU20A?=
 =?us-ascii?Q?jFLJB7DHUOGyq06VLTq0rrNrXq80+bLvVsfRpII2HtBzZ8gaDEsbwbEbC8Sb?=
 =?us-ascii?Q?NpEls6KW1s3ie/cb+35XSFdphWZK1BHqYLue1R1Ppi/gYpdQqu42WvEpXZYl?=
 =?us-ascii?Q?weTbsmZ/sO0Q4izJmnvGHPntaUDSQgrDffsGIcoBV9rOVjCezjrqJY8SvT/m?=
 =?us-ascii?Q?sa6L6qkdwtkBdm2C42rwdJEWcG7h+fd601zyFlA0ydP61P1werLCHr/WWp1y?=
 =?us-ascii?Q?AhWIOScaGEaXockYLMWnzQpknW1BLSRnfTz61KU3TDMmmZKOo4O6PURt0x+X?=
 =?us-ascii?Q?qFygWlk0yX5oHJn2g1fc2TQiaN9K2QtFebvUnRSRREk0tP7Vpt6St6umQsMA?=
 =?us-ascii?Q?43o8Dhhmope2tP2Px72LD3Py0HeGgyOpoY4G/IaowhFM8/vTFy+lhgx4kE0u?=
 =?us-ascii?Q?4ksaRMQJ51nXdL4vADOPlKnarZQdhm0qhG0sUVg1FmZmBHNnnvAVC7rKE7UK?=
 =?us-ascii?Q?ri9FRwsPq8YXX0Bu3ODEkMh1NRtCPn3kkWeFY1OsjpGOjDP2+AdCEi3kX3zx?=
 =?us-ascii?Q?IgBNWb5ceuMfAlX302bdw89fGTK9XoC5lXWVTrC0/DCG2C5AtFxAmDcYzvFg?=
 =?us-ascii?Q?MPHp0mFW7thHVIlkhs9L3Cvufjrmn0ZxNp2SsKSklyS3sa3jo0VPueoJjZkQ?=
 =?us-ascii?Q?o5GIjZ01MBCBoMqpEdkrBNc9iIZlRvp9ps3mC2/cawN33xiiY45kMrtlh1V8?=
 =?us-ascii?Q?IxmkMc3kB4XQXBd3z4vMYHXkTzHnqauMHVZ1/2XcqLp8H7FEFs69LrkERpR6?=
 =?us-ascii?Q?ZPgyBJyfPBpHXJW/I93dCfdMtzy0AeNWZs5LH9XhAN75SOV3Gjt9Am0I9Iiz?=
 =?us-ascii?Q?swXk4hoPP5HpntozDCeg+KOgeN2RsyDVcOwgFtE9kB7uezgTI/+GEPclhDR7?=
 =?us-ascii?Q?sWnjHEUz6eeYaLa4h5Kb2DwDQQpZoAHlcpS5P+A5xPsJD9p9eSe4i20WVsD/?=
 =?us-ascii?Q?8c/aJIiMDRlyPp8m9jZtj2SHQ4yJjhL7wFqNCo7rnzzgqWlG65Vt9KBQr+CH?=
 =?us-ascii?Q?9mCzmC44lFcNSI5Cczgx3qMPhDej9mPBLoXWmZ62JHMIYuRwaEuzcR0rEtPL?=
 =?us-ascii?Q?htnAFR+hgPfuO9+QhNfDL2dqYPVp+RjiYmnMCyWdrY/WrUNrUAWRA0fk3qGO?=
 =?us-ascii?Q?FxmGWM7r3J3N/9TGDCR6Q3sjEOWXnP9X6gXIr9mN?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f51be82-bd52-4415-2f45-08ddf680b71e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 06:58:04.4251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RtMX3bx4bF8sJV2dMLr8J/5pOdA1FHsehF9EGpjNvh3nkUmrKhVOOqqb/QYoHTi5veKZl8PogI9UO9ZZfej1kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5010
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, September 4, 2025 1:47 AM
>=20
> +
> +struct pt_iommu_collect_args {
> +	struct iommu_pages_list free_list;
> +	u8 ignore_mapped : 1;
> +};
> +
> +static int __collect_tables(struct pt_range *range, void *arg,
> +			    unsigned int level, struct pt_table_p *table)
> +{
> +	struct pt_state pts =3D pt_init(range, level, table);
> +	struct pt_iommu_collect_args *collect =3D arg;
> +	int ret;
> +
> +	if (collect->ignore_mapped && !pt_can_have_table(&pts))
> +		return 0;
> +
> +	for_each_pt_level_entry(&pts) {
> +		if (pts.type =3D=3D PT_ENTRY_TABLE) {
> +			iommu_pages_list_add(&collect->free_list,
> pts.table_lower);
> +			ret =3D pt_descend(&pts, arg, __collect_tables);
> +			if (ret)
> +				return ret;
> +			continue;
> +		}
> +		if (pts.type =3D=3D PT_ENTRY_OA && !collect->ignore_mapped)
> +			return -EADDRINUSE;
> +	}
> +	return 0;
> +}

I don't quite understand the purpose of ignore_mapped here. Could you
mind elaborating it? the only caller always sets it now...

