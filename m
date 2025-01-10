Return-Path: <linux-kselftest+bounces-24185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 462F4A088C3
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 08:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1FA9188B898
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 07:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8303206F06;
	Fri, 10 Jan 2025 07:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PYPZHTQp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025E52063CE;
	Fri, 10 Jan 2025 07:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736492876; cv=fail; b=btMqNOwSAaZHcMIwjtNB4nKDTPp/QDysdYRCcwp+zeqiBQsDrJ3IiBaGx9rwvp4olvzYQEWV4AxoF3dtMIh21X6jjQ5W0tZtPb/xSwMrs8UWUN1SYqTz5nZJ45Sf77vevOzMf5dKp5WzbDYUCOTdTfOqhzSyA3LXOh2WPyE+ny0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736492876; c=relaxed/simple;
	bh=ss+Ox31JMCB/w+voibN26Ik6iZeSiLqkkGWSTaqPeRc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qvNG3ktS9Xs9GYei+4pZDRn1TkpKu1FsSw4rezaxHGXVPuIBjX3YM3oaCVemK2TpB7LdZFqXKQBMQL3WM5EbcczQu7TwFlsdVO3PJuRYAU00qc2+Z2VK57MKG0ndsU/b44J9KYRId5V3OZu06DSg1Yoz4kXjo94CB5z9e/NouOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PYPZHTQp; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736492876; x=1768028876;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ss+Ox31JMCB/w+voibN26Ik6iZeSiLqkkGWSTaqPeRc=;
  b=PYPZHTQpRuGJWZHNJbKOhdx31FeYws37QidGU505k/iFQ5FQJL55VLno
   Dw97j801mbb32nULUis0U0RXS4gIaRyMAq/F69k1IXI/DTazwu1luX0nb
   A13Vu4zbmOEwiwPsA0QKkRREOzWNYE44NmbEDKu196IKy5crbeD2BwqjY
   bhmfMYDnzYCXPtwpK37UGlYK53x/MH0HAtZkOJhnhJBH4lAGz2k/2TNQj
   0Ui25qhmMyDvidQ6pNfz5lRxdiw/qN5Db0oZe3l5jJvJ0YbEHTQ+sVWGy
   hcPjDy/J72ikvlODdcThKqXG678LjtaiV9hJjmMBORvfES58ewMds32rf
   g==;
X-CSE-ConnectionGUID: LdFoTVN5SheMK9/iAmHsow==
X-CSE-MsgGUID: 17wYSRQgSMC3hJ/dIRs9kA==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36886607"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="36886607"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 23:07:55 -0800
X-CSE-ConnectionGUID: hLmuLVnvSniC1N9ZeITm9A==
X-CSE-MsgGUID: j6wq8+k4Sm2RFuJ+z4avJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="108697293"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 23:07:55 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 23:07:53 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 23:07:53 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 23:07:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLvu7IUluUQa8wgVXrc6VR3ggJGLHUUMOdGeHX4KwJEJyqxQKAm/hQI21AtIq3kv5cuYJ4Q05Ks6T2PXQshlAnYps9aeMlLZCIXRdGCartezOJdrXzn3z64Rx14aJexgzYI/KFMRO8sF8w5nGzpUcF0gnVUBle92jQlP8tZhUO7ZkRUkp1/JAwKZNLJXOPkBjlKvYKpZcQYH3Vo//cXpKFkgemEkXNVOxs7jExbw9rioFiFAn9ZEy6yV7VZIFG727iP80RMeJWJf1HpACvABTktE4FfgKDqH/HhVtJHB6nmoSvXyZQMF66Bl8tGrG8WZt7vC7Ac1NwQ8TYw6BtII7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iW9VQIQwJGm++Upt/14s2QPpplrUSMYN6rETyFVPfj0=;
 b=QqFRPKqHun1bfDHDW4VMkfsU1MxA1lF6cgNFzUpi1o1sejKjNWOBGQ29w2ygZaVcSJinGT78Ufu0hdKeixfINTtJ9XEYa8R3oBenlPm51bMSui6O2uGJamX03Y7WYc2nZq0DQbkrhh+wgaMgiTpvNmNyOdqRAQ1cqfJWwfjeKaOHGeBHl48YEIyWVViiyfk3Zk8XgU42ciIM48fL2kitMPQvzXkZwdHOuwNtNFtg8TYYZtT+9ZCggYADUwCCSUweMYG4uxpptqpIMcRHGpa2oAGyA/sxII6/8u60ZFJomvK2Wo1DeuFFV10uZTETI0tS/Dx6Txor9uxUenI5XgUwNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB4852.namprd11.prod.outlook.com (2603:10b6:303:9f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Fri, 10 Jan
 2025 07:07:36 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 07:07:36 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>
CC: "joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
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
Subject: RE: [PATCH v5 07/14] iommufd/viommu: Add iommufd_viommu_get_vdev_id
 helper
Thread-Topic: [PATCH v5 07/14] iommufd/viommu: Add iommufd_viommu_get_vdev_id
 helper
Thread-Index: AQHbYSdFpCRmOztoB0uLfPQzXQwAa7MPmirA
Date: Fri, 10 Jan 2025 07:07:36 +0000
Message-ID: <BN9PR11MB5276544E0043A69C66F354488C1C2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <1dc30375464927950e12a5a52ed0433c3b01b8d6.1736237481.git.nicolinc@nvidia.com>
In-Reply-To: <1dc30375464927950e12a5a52ed0433c3b01b8d6.1736237481.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB4852:EE_
x-ms-office365-filtering-correlation-id: ec6c490b-c5ed-4645-5109-08dd31457653
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?EdaQB05Oc62XQ4WlxWmRfBQqpopCbyDKe0yMY1JzY0dOCQIKX+rvkSE4ZL1Y?=
 =?us-ascii?Q?SO7ZiQWWHT2i3ZuGkFUSVLv0k4hYmiPOwIpu/Akcu80ht/OaulHmKjzLpyw3?=
 =?us-ascii?Q?v2q9QKqQFtpdKXIusbrsCjktoCWb+UWFulukkyoRFni7k9Ggri1RXByRYCZl?=
 =?us-ascii?Q?RhxqubTB1Go3l8UGfolxdcQonDhCKL+sN/N6Bz1F6L5wbOB3og0TMLXlHkgO?=
 =?us-ascii?Q?nt/11h8HUnb3XkA5Mo1BHjoQr89M0uuRDLAsw4Ljl5k1Y530CzlUcqGZ2muu?=
 =?us-ascii?Q?tjS/fm2pEZQX0qeJoCMoD4ebVIoxAbDN1vig+0WebxTvOEEZEmVe/mOotpMf?=
 =?us-ascii?Q?08dfSYO6J6nS3W4r34FopCTSMhXIhOK2Z0QEY+ZiCmZzyAjUsS3gw73gGyZl?=
 =?us-ascii?Q?1JzSGo3YD5/6Ds9p3zrWcC4vKm0KzUU7KKU1FVSrkLZfGZFqfV4qiGmT24xx?=
 =?us-ascii?Q?IQFg5Oss/7HauI44cPKP7ilfNx3+viy6vJ4Ia25I3D6iprVKzxBLodQ+wBkT?=
 =?us-ascii?Q?SPlY+7lflhMcktTblqFdNmqFxhcR+zINKNaF720c1Gq4a+voQNRgX+LofGC6?=
 =?us-ascii?Q?qro2Ac2YD6pT3FilqBjBtwTIFgrVwFYyoWUIUZpPh8LOsZnpn/IesWpSgCXL?=
 =?us-ascii?Q?GlJNYcxhVc4E8ko/UgNouZSfD4MLmSHGGQmnIVEsF92Yu9TyzAkGGsYdGuDq?=
 =?us-ascii?Q?ou0qVmdkVEMJ2GPoYSkeYC0RFZ22RYN5qe4fCW1eFPwgzKCp8/V/oPN4WWJq?=
 =?us-ascii?Q?Dow31DW51Z/qeOu3tO/71QtO204geIxBiVxOHhZ3qJQy8nMudTPu9NIlaGo4?=
 =?us-ascii?Q?NcY0uj3mpaE9LP98g4wLpEkiZ/2X4avwkCTVlQpefUr0L5O2l6T8xKTvgFfT?=
 =?us-ascii?Q?eiuCqh68jlBs5Jm9l8FRL+5zaHPcQPh9AsRG39/JbfDuT+BCEkuMM2I7qXuF?=
 =?us-ascii?Q?ElFj5BphI2KHYojIcldJfnO+GUvBKexkzT2z6CB7ub3PZ0mbSuT6squD6rQy?=
 =?us-ascii?Q?VGd1Tt1nxmNcj0CnjZWlWcQYeklk5bAkUcTNukj6LABiP/4Ae0uyeCBlx0T/?=
 =?us-ascii?Q?5AHqCi+8+IU/SWX/hdcUpl3dyio8n0ppn7b9N49cH+hXmGiq7wKlmeOrN8FF?=
 =?us-ascii?Q?paeBbrER9uF1VamnGiA9be1jqwxj9tUlBigGzuZQEYuPxi9AILBcA3AbyvOs?=
 =?us-ascii?Q?6Ze4fUSMwiWyg6buw667PmmM4UkV2BBgaTG74AMbgHAsgO7Qw07H6hMgx9Ks?=
 =?us-ascii?Q?uPV3bDCrM44nZCetHTEu2XTFXQq2Ggl7kbeOTKP1fFoNflN7Dnxs9kjGueLl?=
 =?us-ascii?Q?iLukHUHm+FFAS4IhNIlItcNo274iOEKALAvoEAmXvImovuVOQJhS3E0OuzHr?=
 =?us-ascii?Q?NvHBSveXMk5YQIteBLi7D5Xp/ZI6ajoshJdMF5oGclNWHIxr6uSNTupgtihR?=
 =?us-ascii?Q?i1lWN1PTnMYJsTmqfYVlkgQSuYa3okQh?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eb5/3NZNGY2vEPJAUvEiWTjweB1vZTS1mhBwsi70zZzmTnSS0do7+fFCWGsE?=
 =?us-ascii?Q?WGjf2WM/6Q/zYYc+Uu2kvP6xCnh3DO3LGZKH6HC2NkC45uYZp2vshBvFteIW?=
 =?us-ascii?Q?3OlMrbMQtJzmSJpylaF4LYt8pUpOy3dHm/Gf+QxxViGJMRURbm/229k4kjw4?=
 =?us-ascii?Q?7t38EZ3wj721AZzWYhz5xLk5MDoxMkt9bCsvBiLIE6cOOusGnjqtysokXsJ9?=
 =?us-ascii?Q?ZCtK6dvGuW/VKOONNEfJ2u+//AgkF4SWtOft1billRMKK9ej66m6jqmGhdMB?=
 =?us-ascii?Q?+KdKieBggUhqIVsUoAwoH6BwaqRcs4gHDEU0M2N68Sz/dF5L5rMa5cZoNMPK?=
 =?us-ascii?Q?72om3J3wvSI6ISe3Tqf1BeXeVVCNE4xLIZrZCIG3C60ybycUUm/ax4rApHsC?=
 =?us-ascii?Q?gdfns1XbkH/8awKrnqgjOuNTqMK/CuTtFQlKB5rgo6QmBpfXaot7S4BMIT5z?=
 =?us-ascii?Q?pVdN1YxQTwFGUWrlB5LnbthPUFo6BmRgsaf/53jgJEgp0jh+gmIoq7UyABv0?=
 =?us-ascii?Q?6zCU8ubOUilKywlDVCxdeGd1tDFA49eQxZRWmcIkip/WZ4mntepYcDvm6Am7?=
 =?us-ascii?Q?BvIfvQg+KZsea0LBPoJs8vVvEaIwQp5JQ/RAi4/OksvVNe+ebjnxlA2X8xkx?=
 =?us-ascii?Q?5XP+mTEn/6QfIXt0p2rfhJ/OK+gAaxp7CHUSOw+Etg+bPOlg3rWmZkLpd4iO?=
 =?us-ascii?Q?FO4ZLe8kNTgV/eUTi9jtyuSEf20uiJAnM9BEFx7Or6NJpD7/HRXYtd8UyMIU?=
 =?us-ascii?Q?rQWyz4czuDjFpVQFZxHNhWR7fXwhEfVd6PQikOcpAaX3jI+ifESiEj+4VhHN?=
 =?us-ascii?Q?ekVMd+mbpBFAlnbqxrcS8dcts5vN9/8bCzWJH4i4OiCLPyNeD6596Y2mKuIm?=
 =?us-ascii?Q?7pv1HVtEkHIYcIuXZpVJ/mKC9dqefE2+FoyQ9yhn3nBnSW882WHVu/kweKb8?=
 =?us-ascii?Q?Qb7jRI+z+3xDqDJM1YZu6dR9xgStuAE/0KWagGnfpHzsYt3MAPpL8Zzq67hB?=
 =?us-ascii?Q?iQHvt7synxjBA+ozwT52pv5oYZ0JB73viizdkczC4k/7PjhcyDXOXH+NYRMB?=
 =?us-ascii?Q?0tzdXcvBDP2mOg3PedeS7Fxo3PlQRBSF3z41xJFMGIE2smwT4DSw5gIrAsrI?=
 =?us-ascii?Q?lNk/ilAKvbjKlDI389PlyheO//PW+nY384DyaChQs4eV5ZWACU2BHHQXqKSh?=
 =?us-ascii?Q?+uJaGMx8tAG85v0t+fYPLO1gKg62ckct9o1jsCrIOM7KktS9Yf6tnICDhIp7?=
 =?us-ascii?Q?b2JED75UUMdHtHbTbI1pB2u8opVh/876QdmHg9U7mZM4vHZZHjONsivV0QDK?=
 =?us-ascii?Q?dhRUU0j1ZOCYs+PFUz4eIl2yWxsn4pRfx5W9gKlIYfBGZRMKWNA+xCbhwGYU?=
 =?us-ascii?Q?Sb7JrvKuzFm4dt+PVReCwhXfQqKIMvMr4PuOzZlyQwkPVZcCMVcajVU7KcNZ?=
 =?us-ascii?Q?dUFF48eRephuxL3G5yyxnNV8MyvH3bFrgjbjiuEEVed9j2ZAc/WeLenQtMQA?=
 =?us-ascii?Q?1K0pW119yD8N/K5lNJW6sZIdRd5v5Nqqi65q2+l3veMNOo4KNFJJ+OKDoewk?=
 =?us-ascii?Q?6apjHgv/FxOmu3r4bMi7UYmKe3rJK2miJzL4c1pY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6c490b-c5ed-4645-5109-08dd31457653
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 07:07:36.3697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s/b9CuNCurK7sXfNOP0HqbSn5FOBLYcRxMSMjsoWZOt5s2VKNcn+jQBT87/huTsWWyRIvWR/1sYlubi1Hcmbpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4852
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, January 8, 2025 1:10 AM
> +
> +	xa_lock(&viommu->vdevs);
> +	xa_for_each(&viommu->vdevs, index, vdev) {
> +		if (vdev && vdev->dev =3D=3D dev) {
> +			vdev_id =3D (unsigned long)vdev->id;
> +			break;
> +		}
> +	}

Nit. No need to check vdev pointer as commented in last review.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

