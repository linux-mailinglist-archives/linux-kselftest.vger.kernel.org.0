Return-Path: <linux-kselftest+bounces-42447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B4EBA2DA2
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 09:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979351C023E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 07:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9770B2882C5;
	Fri, 26 Sep 2025 07:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KRK85qzL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4441EC01B;
	Fri, 26 Sep 2025 07:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758872935; cv=fail; b=CLvZaRwMOcDNqmsuWtt1BQCG2rgOHaMUHKzx6qfrIbYr/Qm3kMGJUSE+4eESqbYfv5YJpVpJ2FwzlvFDZqudtP0+fAfPjNX/wfwgULp0NybIb0BTkmRtGJyMsw9KwSQaV0iMatwwzKHEfFi8mjiOLWf0b3SIWU2onkDx/BFFUq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758872935; c=relaxed/simple;
	bh=RB7z9y4/OBFpTudynYRRg8OPIdHJ6rC7+/rIZivasmM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=txai9idZALF+/IP9GBwIGaJMy+9k4BVsMwCOBpzvosLdoGrrCRcB+yq3WvoJXXzNscZVnFemu4pE6oPDFB3eCkseuLwIELvnqri9rPtI82jjr+yy8eNPOeas2TKSyjwGwckLPavQa0Vj/50m6MHLRXuIESGq/xDuGmTgRGiqgJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KRK85qzL; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758872934; x=1790408934;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RB7z9y4/OBFpTudynYRRg8OPIdHJ6rC7+/rIZivasmM=;
  b=KRK85qzLbBZdZDlsTe9222V1OCuj2YJCB4OkAnPp8jsLkc4ovV7B6mHC
   24un+/xBGvdPtk9O5sgCTCPHsknC9+5pRaoPJAFoxVBoqFtGrTINTNucB
   lB8dAWwzn6kMeoYHINgOMZuHAk3wGXgldoyz1DqqSnwiqEImYi+guY2/F
   6mod95uGbgnv+TxIjW4aD6FJBr2vgSLWicXeLGrddzShwDDDsCJr8fNMY
   UmBhji+nIy4dD2uuuWqEM8rF0xWBB1ybWijMWDgG5MJzyk7PLnGMSEIAZ
   T2dCe4/Dg7GDnN/PKAdoreAXqueGdgRr+PKd7xey4MXhff6ZLwLpmmIrX
   A==;
X-CSE-ConnectionGUID: hYc1+nkaSNOH0rpf7N3Uxw==
X-CSE-MsgGUID: al71cGjzRJ6LnWSiZ3dETA==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="83810420"
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; 
   d="scan'208";a="83810420"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 00:48:54 -0700
X-CSE-ConnectionGUID: jr/bc+uZTFGENVxiCcICKQ==
X-CSE-MsgGUID: 3JJ3+vMJQ0K2Mx32VlRZhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; 
   d="scan'208";a="182824448"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 00:48:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 00:48:50 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 26 Sep 2025 00:48:50 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.24) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 00:48:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/L+RL7JI07/v6HMWpPeX45+ILDgpjmCbGrc2YvsfWkDx09KpW77RkCrbhAucvWnxUqyq5ED0P+H14UE8npe/oVXn50MnX8UIq8ykNXk8+x9FsidOYItsaHEP17EiMRm3L2/AzrMKr2ii6nzZr58cHlvbGcw4+3aMRyRZAxeqvb+6YEiUOQ5aKayVuqOFiQKDg/G2MtsUHuH+aBwEeOtlMb3SFuPqjg9EES2MUEhbEBiNGTjCfdik5E0Q9CWCcZCYjOMP9yx1f5btOAUOI3ApZcXQ5CrESgbL0uhFw67zu/uNhD/lBTQQs/8eqJOQT73N5xBn/NMRv0j+aFawy4Jww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RB7z9y4/OBFpTudynYRRg8OPIdHJ6rC7+/rIZivasmM=;
 b=Nk3a+SQtX8SuPSVW0yJ/MfWRZubRjrGJGSyld5J9UYDsE90bsgL/PuX87Oi09yhm7Gnj5ZGEhGkZOJfL1eupUM6Pxp6fN3YkR+n/bqk67zUFKYB90MI+E+rKWjP9KtZ+zUvvxVqP6IpdmvIQJAdRE/bpcXJrKFelaZ0tEj4v/zbwe3Fn4WBXWTy6GksISE8vfCZfjy1c2R/VpOS3dfgVkZMRW0WvK4EGFwflVfitrNGxJ9Q9KiHB8eEEPMG4sWHizrsq9xZNlG+PuWqtvtw7ynaTwDYjvSc4CsBeNf6gtOCaS5djmTxkamHuu5YJGALWF0E1Gbr29WH0cZ/YK8yidA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8543.namprd11.prod.outlook.com (2603:10b6:806:3ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 07:48:47 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9160.013; Fri, 26 Sep 2025
 07:48:47 +0000
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
Subject: RE: [PATCH v5 08/15] iommupt: Add read_and_clear_dirty op
Thread-Topic: [PATCH v5 08/15] iommupt: Add read_and_clear_dirty op
Thread-Index: AQHcHPrEBeqvHOzQ2kqeEV62V4ZTzLSlOe/w
Date: Fri, 26 Sep 2025 07:48:47 +0000
Message-ID: <BN9PR11MB5276C15BE99786E13907606C8C1EA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <8-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
In-Reply-To: <8-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8543:EE_
x-ms-office365-filtering-correlation-id: 854bbf02-9ff0-4dce-ba26-08ddfcd12006
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?jAIvVdCHKLU4iWRZWnJehyvx3J6mWCNLPiVR1wlysyFM9VeF9BK8dcEb4vaO?=
 =?us-ascii?Q?iSn680yOTntzwMRTKLFNsBgsT0g67x81Z+ji+05ubdwbJk9nHh3g05Ktrjmo?=
 =?us-ascii?Q?huYZTcMkDChsPyzpiTTRf1/Gl0uHfjiQ1YmEr8veJP60/533CphoFJWxOC5z?=
 =?us-ascii?Q?zjRvSGq39o5+RwGOTA2LaQla4jVi1lMvs39mQVFNSAHVkBTs1Yv1x2cfzfvE?=
 =?us-ascii?Q?Z7hbK/feDyZA9Vnqejj9TS89ZLt40Guz4m5aE0ohZXB5T9naCtlkdDvrzR8L?=
 =?us-ascii?Q?6+q8Sg32TG/OZLh2mnDbj2NVwC3nJTcEc05ooxBs1ufrjYu8g+DLcPvXCRY3?=
 =?us-ascii?Q?neh4BK57hL36B5Pbo56V+iy9eWD/UbErnkVtDMjlAmZdr1ZWeOhl+T+uv5S4?=
 =?us-ascii?Q?zjUViMESz02AIhiMMph0K3RvAjBCLv7+Dtgn5FfZAuFvinyBEvX12AhIpgvP?=
 =?us-ascii?Q?oX+6yLTDJCkDgLn/fs8Q/fh7O+ohtNIFb6RBlRFuZVUq7kpY/+d66YpN+57l?=
 =?us-ascii?Q?E+lVu2lkXPJKDksxnTfjl8T67zog31lTlLagGdEti4QCPh59/t7cY5yBezIa?=
 =?us-ascii?Q?oQx3BkAL0fS468NyZaQ1DW5WwnHXVY57sT3ZByTck/7wQrf7hg3ve4tDusOr?=
 =?us-ascii?Q?FulTOK6QiwSozBVqiOBltX6PXYgp9G0VkjgcUFOO+pTPRaug3Q6eDcQn9OZC?=
 =?us-ascii?Q?7+D6qORrneRrxXoJaCanSpCisg1wlH/6aWZKooyhxWYW49KIJVjRdpVQA67V?=
 =?us-ascii?Q?n6loxW8gEEUam0RS/ZAez5x6urA+YDsWG1XxRXr544Su/j/aGLRX7B9/hzuJ?=
 =?us-ascii?Q?lFtPbYlF1WsjQTkLaOUiaEvt+YDgIVAyiJTbQ044wpTCjkiDLB5AKME0ic75?=
 =?us-ascii?Q?lF6pnYGfQwrm/L9B5Q3AMhrGqyfkKYfHNXIbSDU8vl+yvFcEsraf1TN1ahj1?=
 =?us-ascii?Q?t0420/phszraIo1UrvdBzsTWpvz5hEjJlaKIDSxEWY5uZFe4lekR6WxUlru1?=
 =?us-ascii?Q?lmv8kB8L/fBmj18b210Ahz47n7xuMBkNRhr8VOMY/rPe9Mtyek8EUwCdRY13?=
 =?us-ascii?Q?3i8i+9/JbcEHVVJD+DNjbJk89jH8L2aVBPg/KHoDzqNYEGr1fsTgikLsPl/c?=
 =?us-ascii?Q?BRvkNSriPSLk0nhX3uQwBPxJc6SCn8QyMM7MvarFYWrdNfh8aHA5NX+Q+yUS?=
 =?us-ascii?Q?VOa3e3dCq4/uuW3vIJYt3vQbElkvP8EnU6yzNd6OMFPNRMW2OE6it5YCeOuZ?=
 =?us-ascii?Q?Th7QdaFMcPL6XPXrCKjhEYrXlNbN4vj2EF23orT5eibRLcR6oH6aW8ZHrvVO?=
 =?us-ascii?Q?InaePQsZmSFwMRc8llB04LiVpZgjMuSI7QXyeddcKJyLCyBGzZnUJVImHq2D?=
 =?us-ascii?Q?O3+aYgZl9rtQdRxJtdQqXotPWxrdIjZLlWo9V9jKVoz58xZZM9r7hdFkBLIB?=
 =?us-ascii?Q?nLSbQht8ylEtLaBm8eKeV6bZTR3Vjw1AHyI+me/pSF6i4+4HJcbJ2f3NBj6r?=
 =?us-ascii?Q?nMTCIt0JHMGKii0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4JEC1jtV95hguG+0gnC/iucefLel/BmLVyQqaZJKW4HOeFyQIZRypvles+xP?=
 =?us-ascii?Q?lpmEMF6SMNhiRx6fWYY0+/f51+IzJ8ZJKQSkPZo9EyxqEM8D2jzsC1azJ2YW?=
 =?us-ascii?Q?GTUBx+ZjQq9Brt1fvImQ2LnnXdFO0q63M28nf78GzFMYhZt5JD+lD1DcHJt4?=
 =?us-ascii?Q?bLsOeu6OUjbAb2f7HkuvpEH6d8knoQoy56UynH9YTSMWvcR59/N6vi2HgJnZ?=
 =?us-ascii?Q?f5goC26SnQ4tvv7omOrbc8yoeWx5hdC76DN82UljCtUc9z2wa8EhysVhpI6D?=
 =?us-ascii?Q?skMDdnPQLCwpRlEVeo2l3TvL1tTNLFw0TuSdyrZvdEmQfKyZOqOgEenS8dND?=
 =?us-ascii?Q?aXy8pUS+czq8p6obbd/SeowYW290YhF9SjLMqtA8i9VQ3AVsEEcuSShea44z?=
 =?us-ascii?Q?SW1r0cZIXHA4JhLauo4nG9Hmb4QxdJ+nZnEyKsL5OHIFSvSh8WCeFrmkEMH8?=
 =?us-ascii?Q?V++B1gpWdg8lZbl4lvKDAzNgT52sDg9cDG2OUOF6cAYWQWW3BrRJxk4q/S6j?=
 =?us-ascii?Q?CqY/tYt6yG1uapojdvrr9K9OfwZ58cHqWgj0WiTcwBW+0QiJxmPRhISQarq2?=
 =?us-ascii?Q?de+Q4O+mlN0YYUiC5KuOjZbtN9xR1VLpl2p5gbZscTRurX5dccJjJcLtFxvC?=
 =?us-ascii?Q?yn1MhzUGa3Nl4Ezny+tSsJ+61a4F812QjMvDfZA/zJ5Vxp7+EbGK+J60z1rh?=
 =?us-ascii?Q?nFOL5SWLl1aKe3DIoEId3ikg5UMYmdS2ihJpVYDNGKhiA1KYlwwFDrOhEHZD?=
 =?us-ascii?Q?wcfSS6DfBPCcsQzslEmFulGFzSWyPogpwJzTrp3jWIj+6Eezu2SZCdDfmcD0?=
 =?us-ascii?Q?zCVAWZ593gFGwTGdPAx529Zdc5rCg+xSxv3F+xpM6BRYwwS+1P/Yxs8r1yrJ?=
 =?us-ascii?Q?Rwv09sbfvRm2cO/02ioGY0AUAMlWB2kPk4fzWCQoNZEyGjzf5TzWBfUn/eYa?=
 =?us-ascii?Q?0cj9UCIvhZPYz+yQeJMEd+vlK1ULA+Uv2IT7qSFMTTgdpAmSriY3t9/HSGHB?=
 =?us-ascii?Q?wNem1UbUQfdTDsugqSEOyskp4WFKRuwZ0/VfuZ2hZfccZLch8V1ttLlDuEtQ?=
 =?us-ascii?Q?KSn7N0nFkqZDwKXjKCtcNuXzWk/VHu6dtk0aiVFErOFWC8G3Kk3mhrGSDyVb?=
 =?us-ascii?Q?pPJGw5NJiH0CFw1W4r2TMxUgLcTAZrILn8xAeqQIa6JjLG9MAHjKAq3bympT?=
 =?us-ascii?Q?a5ntp3mkp3xPb1qg6ED7BPpU5jQGrwUmJFGG2GdyhBqPcBrggJSzOYeuywXd?=
 =?us-ascii?Q?aYqgktp+a5GPmsbnWg0t9Ld7pZM0T01AFeHm3e8BqtI/96C92UJJxY6h98W+?=
 =?us-ascii?Q?w5cf4eJTcQ4VXSD+/lmDYmvX6wfwfnNjuPH0jksnWJpB2cpsCoo5WQVZ9euC?=
 =?us-ascii?Q?l1tIjPGDlZEfxSs0ebApak9qxl3XMZx3dWqhBPe23zPhTy6JE5a7/KUfERCO?=
 =?us-ascii?Q?/53oKPh2TiM0qBboBQZDUcgYeDwxZGBgrMY2EkVZkSG5Gz2mFl4jb56y73P/?=
 =?us-ascii?Q?QfpJz9uc1S3vsHw0xkRc9DuM1233i6Nj2JzS/KIMr6L4U1svcouBgemgD7tJ?=
 =?us-ascii?Q?VqzOh3+3jm4LN6oz1Dx/UHQROF4V3sOQmJx9LQwn?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 854bbf02-9ff0-4dce-ba26-08ddfcd12006
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 07:48:47.1828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HnHtMZ01GWPW4+e5O7RycWjFqwLWj9UsZTTNyVNS5aeJJcXFoKKn1PH6+QM9q5MefHZP2SmNj4ttdJIoc2LqPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8543
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, September 4, 2025 1:47 AM
>=20
> IOMMU HW now supports updating a dirty bit in an entry when a DMA
> writes
> to the entry's VA range. iommufd has a uAPI to read and clear the dirty
> bits from the tables.
>=20
> This is a trivial recursive descent algorithm to read and optionally clea=
r
> the dirty bits. The format needs a function to tell if a contiguous entry
> is dirty, and a function to clear a contiguous entry back to clean.
>=20
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

