Return-Path: <linux-kselftest+bounces-36282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 152AFAF1044
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 11:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8BD1C27E0B
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 09:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9D125D527;
	Wed,  2 Jul 2025 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="itU0BOpM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E4125CC40;
	Wed,  2 Jul 2025 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449234; cv=fail; b=ASLxfws8QOqwYv1n/iUf1PoOwCpG2UVp9IBc4qxf6M8stEh7p9CEe+c4GlNY7fhk0wOptgqNmUx9bfHq9i+YcGccLE+xdPykY+AU7ahB/fErDIk10rAENqHXkqJ9PouBT1Z2le+6/EQ8rlQ6g3dKTAuWhHpFalgttYjMRau8R0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449234; c=relaxed/simple;
	bh=9KRmkM4Fb8FCHcRKzUg9TALKYkyS1Nd3u4kTB5VrfIo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DDqcg80IaI7aQwXywuE6rhWEtB6ogAXMbE2QHy3KH87fujrZMto4XdEc52tcpfJ8eYEIVPIEDf4p50pQs1A7A4OUGcZlw8PkNY3ory6qPk6B6TFBr4+e+TPk37Pabk5Z4MAxTVGy01Ne6LvsDYgfe1KVU3tbMrx8TDowpt8WrUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=itU0BOpM; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751449233; x=1782985233;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9KRmkM4Fb8FCHcRKzUg9TALKYkyS1Nd3u4kTB5VrfIo=;
  b=itU0BOpMp5ivcWEYA2QxED4heQsiC5KooHFDdbej2/USsu+sdY3wnblG
   LwCL87Bfy4wlxGxZAIIGpC15eNySb5kSYe3SjCrkdQSFPNatZ5NO21Np0
   9CQRFIKc7n5KlGSSvGnhMnxo+d0gIBAkL6hgSRkds3YD0bOHjwP3hBqOu
   trP5U4oL1yFYeOnARcHP1crGY76UcDfQgMSs1Dqtu0Mpc40P2JO8LVswJ
   CEZSMX84/4WtdU3uffFZgE4Fj9xoh7+dAYsm4AEMsIGZitEip1wtK/kkt
   3YT/CJRsNsRd/EN3+sD2ZAvQyR0Wj5PAB4mfCod0m2baz8w/e79oZIjI2
   A==;
X-CSE-ConnectionGUID: Q88kdOipTEuJhCLhXTOt6g==
X-CSE-MsgGUID: 9yisFGNZROaxHw42MfhQdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53878225"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="53878225"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 02:40:32 -0700
X-CSE-ConnectionGUID: 3I8+whlmRemNvqHMscYOlg==
X-CSE-MsgGUID: g62D2IMaTeKG/3vfuIheDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="159541665"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 02:40:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 02:40:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 02:40:31 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.48)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 02:40:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXCk7xeWE0WIkaNJl1/saU2bztQk1DHNnS1mIYpyZPlZz+wP8GXWpUbkZy/PZ6oRdePmlEogNFi4hl1X+vTdjLb1IBagkBBCfNxj/Uh1NV++v+mUXCB9BQ+KiUAGqi9Ypt9ue6c65svdIP+rMJTMYH8qhGxMmfUXWO62AOGF16qHC8BMtFLlQVknqqVNhKf3nKqCgTJ3xidxdrRiUmck0sDmgjdWL65ts1cTsnmR4UHawP2vS5qTq98kUwPV6JOXTsp0wQYAOMCbxI8SIs5livzfAYYfwGe34+hmCc7rRBPr9EC2lCXONw0Js/P+HEc29R6u3hZVGao0Qx5Ci+Qq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KRmkM4Fb8FCHcRKzUg9TALKYkyS1Nd3u4kTB5VrfIo=;
 b=ZZzQ0bxV5u9Obl8fSGNBa0nuoX8F7dcOxMvSTC8WpRxraw8YmzF9nPqt6x+NBKPxcrjrp7bXijAzJVmaqRlj6ZdpLMnMk1y82b2IrUYnc8HYuAbdOoau76wQoxjlmfK6Os92LDZYzCRslPlo53y99k6rNOC6PdFtxyHzXZ43U4pcjhjQzKJ81s/Herr7HyLkIiPGHalHikG5d8nzA+PMCzvJHDCdiwtubjvMK41x39SgryHuwO8bi9jxv71bZSM/SuwYXaL1uKitYRs+YF0DmTWDl8/k+hTxcGLn1sT4f+WRIldys9beTC4SYPHc+CB9STd7NPpj+hzcnhk6dS4Q9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB6780.namprd11.prod.outlook.com (2603:10b6:510:1cb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 09:39:48 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 09:39:47 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>
CC: "bagasdotme@gmail.com" <bagasdotme@gmail.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "vdumpa@nvidia.com"
	<vdumpa@nvidia.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "jsnitsel@redhat.com"
	<jsnitsel@redhat.com>, "nathan@kernel.org" <nathan@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "mshavit@google.com" <mshavit@google.com>,
	"praan@google.com" <praan@google.com>, "zhangzekun11@huawei.com"
	<zhangzekun11@huawei.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v7 01/28] iommufd: Report unmapped bytes in the error path
 of iopt_unmap_iova_range
Thread-Topic: [PATCH v7 01/28] iommufd: Report unmapped bytes in the error
 path of iopt_unmap_iova_range
Thread-Index: AQHb5tF/lvbLpFwWBEqY7w9B7idgybQenGrA
Date: Wed, 2 Jul 2025 09:39:47 +0000
Message-ID: <BN9PR11MB527604B00DDD7F46CFBA1C2E8C40A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
 <102e38967b38c28abbe8ebe70b39dcc8e14450ba.1750966133.git.nicolinc@nvidia.com>
In-Reply-To: <102e38967b38c28abbe8ebe70b39dcc8e14450ba.1750966133.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB6780:EE_
x-ms-office365-filtering-correlation-id: 45f751be-a5a9-4e81-2f43-08ddb94c629b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?fh1vX2yJVWRXk88YQPcnHeO5DqVFmYGGFGAs2jI47DHDwXbhMtYZj3G1rL+4?=
 =?us-ascii?Q?N9pmk8FY3cJFMyoDDxcc1dg90nEuV05aUCHph41nz+kJNvwYEkfN9ussJsuA?=
 =?us-ascii?Q?9cbJUsMMoDoKz6AeXeLFOZq10fwPPEjcGmBgi2PtgBzlwGZtatUszP9b5Eb3?=
 =?us-ascii?Q?fbZS6XLHw920kUTrZz+waywWSPHjwfoL6NV3vNl4u6pnDlE6LGKpTPOdDq3O?=
 =?us-ascii?Q?Al93PEoYFaqswIsNxUba3oPYWkY/iKGj9sKkHkFpjm5BAX6PP7OohH++36Ps?=
 =?us-ascii?Q?nZs6iKMq+fyRxTo7cgUXY7A79cW02Shc8E/62B+xhnStggSLjBAcMQTeOwKw?=
 =?us-ascii?Q?zPkYYjaGmsZ1xXzV555t0a6Bu63cnUIEf9u2r6Ujkj6STSTd+6NTQPX9oav0?=
 =?us-ascii?Q?MdZoaX7Aj/JHHEVyBLrdnB6TqBZe4ecXsi6LGmBiLqF5Tl1qdQ0dv7xFa+cj?=
 =?us-ascii?Q?ale/sszWaQGfCyzJTPXy3KCuJpgiY8sV4ljMah3tl2Kfg0BEOEcSvcvW9bzF?=
 =?us-ascii?Q?sswtkjVXHmHWe5OZOVZG1il+OLWUuA+O6/I4QBdFLcZqVmcqK+qf3A+t54j4?=
 =?us-ascii?Q?NHBezv7/OqKi7ZMqO07XQe258HzdMhOkCNJfOuA2+0IogVD0SLfW4StAv3XS?=
 =?us-ascii?Q?6TTo+LZQ8bw+BRPZRuU5SkhehsBMZ3qeFghjH6kM6/d6PSGhvd56Wr+FFi19?=
 =?us-ascii?Q?fE3UlAp+z16l7vNAlCjVPnd+XJwIeBf6PB4/Nzg+NS7xkjPrnPMJFUJdInWv?=
 =?us-ascii?Q?OKG+AsVMkmRcEEEVo74dwMvCii9b4xttEZb+uaCV3tFYKsCULSYErUr6Cl+B?=
 =?us-ascii?Q?j5THHFrdBeqylRnvXIiAh0qXxsNc4plFt7rwFqqO0fDWp+mCkKpLBg6cAlRr?=
 =?us-ascii?Q?ZaGWW4zY1kuyc+UIYbnPWSy0zWLuu8Q/KTGlZcacvCd3X47PsSVwdMk2VOR0?=
 =?us-ascii?Q?TcDzs0l19xvI0bO1/8iMlwkM+0AktzpRtvH+A0k8VCZ8YWxLFPy8C0KBJeGY?=
 =?us-ascii?Q?ammrlVjftRmOTgyzFLLmXaRIuTGYLJ41aJ0CFaJAWijCJcfFuvZwcOBp04Et?=
 =?us-ascii?Q?7xZg4CzLJKy1vxyR+TjOONiB2iboMIZ05HBszvrLCx/I6z5OrC7uG1A57sz4?=
 =?us-ascii?Q?iQRuQrjD2R2lPhG/mWSKXAwGeTvGi78Dcu7na+Y2DlYyPvx4Rn12FLj76nIj?=
 =?us-ascii?Q?9lX/HWkuJZ64HJFw4w6+knjLUKMKFLTxY3Lb+5twS5Vov6MTuH5n8WU2a0J+?=
 =?us-ascii?Q?gek6Prit+9QnlaAyO3kAZfptDvpF66CWh9d5OQpBxhDrJQGCveu0OJUvjlAp?=
 =?us-ascii?Q?WCuyuyH+UJUWx2HAxhbey5JmPoI1Gp/dFfVZcxQ0GiYtT0RkSzs9tsgZJBPY?=
 =?us-ascii?Q?kRVihcVhG4Ntyq6l9q2prll6djU6T0ynoEa22S+67+Dpl8eRmDGzFoL+qZIN?=
 =?us-ascii?Q?77O2svrnbyCBhn5mYqqbSM8qWo0aEXORZFa7RTR9stnTFQc1WcLiQg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?09hd2MMKSFZwaXzHCboCs5Qu7Aace/qudqW9lhrYH6uftRvgUuQBul1w9L2z?=
 =?us-ascii?Q?Fk1HtTyBk0EW1FH6Ss0b7NR4BNUKPw35mpcI++Mi3kZx5+67PPAUgtiCZaZA?=
 =?us-ascii?Q?JXmRDbdVB+YcKAC2zH2VqQ3CLSg3jOjnGcGyk4CXtUEJJ5zL86UJbH01mrNI?=
 =?us-ascii?Q?QX6Y3zopCJ/FdCY9GKPmeZnOAcEG0xBFhVsvw04IBjILOMeG/jC2JyVWCFVO?=
 =?us-ascii?Q?MIRftQ9mGG3U9bcvgzo4sDvf+vrprXBTlOzAMGkyW0Gfp+kjOBSA936espMW?=
 =?us-ascii?Q?Q9ZNlpFbwyYXkOA6XSSQdQ30/eQBIYuh6dxWQ+4mTTCvg9l8a4k3qSf7d6IX?=
 =?us-ascii?Q?6UJwUm+0k70QBKYyi9l7upFVRMszQEW4CowHE+sfcjhWo/w1CngZ9YUoT/Nb?=
 =?us-ascii?Q?ihz++ifHtNMSBKxmpx8WsJBYN9axAsnXqba7JyvU7g4DeTO1//XNgIJKlw6C?=
 =?us-ascii?Q?Mzv40lCQcl/BW1htQPTxbs3pLRLPBVu8gKBjg19hRiUVI5fIjSwlbym7dvOd?=
 =?us-ascii?Q?pLJau3ot+JCNvzHUnF2ErfFfuSnWJZTi250Eia3tfvXDCm+ziFNYktie45yC?=
 =?us-ascii?Q?kgMEIiLiEy5eWhWvw5YMmXgCi1DRVxwrhat6C3EfbxlGIQ5QEyhS9vBjJNfS?=
 =?us-ascii?Q?l7xc8JLQTaUL+IlmMy2FEZ6WBZUoHRoui91/Sgy2Ml0499CedIB+q5H0P/Mo?=
 =?us-ascii?Q?/BeD5RA4lP16uGUdtQb6IGTm3WvU5Xvylg1Tmn/Merh785kjTVyFytNZcdhK?=
 =?us-ascii?Q?wwrYc6ANw+RVhYxz9IslnUrUO/U8C73l5Q8tx56KVpDuPVgO1dr470hSErNY?=
 =?us-ascii?Q?TEHRAqycCQRnFhN5w6d4y8bXsYsNlaCvFs31bBzQxTfHybX5KR6Ni9mfriG2?=
 =?us-ascii?Q?ExmOaeQZx86dZgO9sFZwIy/QdF525XgcdvmO0tOYCDzalj7Q/wlcdhVXVh27?=
 =?us-ascii?Q?xdGWRUcoabH0pXiCmqw8J0o66GnaXY6vN3yjQsHHN2wDBHAsCy2tLswvJGkK?=
 =?us-ascii?Q?vtd752Yr7AsYuV/5LRrmXDrtMUcD1yuJiZRmSQi5J1DyjO9K2PI1Dn+L1Ilm?=
 =?us-ascii?Q?VG524VTifWJMlp5T8IM3DH6RKxFI4Vu6e+StiT6zaHwjFGPeKllnbwADxkQa?=
 =?us-ascii?Q?CXvlEQhL5ix80rwV7eM2sKJHMeQhhCLJsDGSWlB3uoYEfQ7skf6TmnEE71ci?=
 =?us-ascii?Q?Nrsz3hb4yTJy01DDXG3a3M2vuYKq52JEV04T9MfF4aFG/J9Q2028Q+9cGOeB?=
 =?us-ascii?Q?KW+6caBENc1VZV8cl+yVfslZROwQ2wSfdvyj/wMTpm7k3c5X5f3vG3OQAeWG?=
 =?us-ascii?Q?b5N8GFc+aQ2t5bEBzfJHlfNBC/qfl4rggR2ZXX4rmNs49VvMG3kmGLbkrknk?=
 =?us-ascii?Q?0oGcKGpCObKPMlkqJXSO+MuY2a6iIKSbHrosgmnn6V8L+bNpqVK69JxYyRF9?=
 =?us-ascii?Q?/WQWhp1FolSiPYVVLMlnRhGQre6sHzo1U1Qi0QqLpC7PyxTpe6EAdIWVw34o?=
 =?us-ascii?Q?TRXeiKqcHTMIXL2jFJruOO8IgzbqeOwAnTe2vKUuG1SuDZzD9CYkr/72FriQ?=
 =?us-ascii?Q?hMwA2ufa2LmYI8Zs7iyAiot4z58awMrDbuodzzyJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f751be-a5a9-4e81-2f43-08ddb94c629b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 09:39:47.9411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RXK/nQzOfqxxOX8D8H+wZ8epvEEhVEuY9GnHJbzYfGfUF1ioj+CDyMcQrcCkXNHCg/tOxCjC6/yu335tW5hLtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6780
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, June 27, 2025 3:35 AM
>=20
> There are callers that read the unmapped bytes even when rc !=3D 0. Thus,=
 do
> not forget to report it in the error path too.
>=20
> Fixes: 8d40205f6093 ("iommufd: Add kAPI toward external drivers for kerne=
l
> access")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

