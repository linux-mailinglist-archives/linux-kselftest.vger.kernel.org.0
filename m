Return-Path: <linux-kselftest+bounces-41810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 144A1B8343F
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 09:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 977023B825C
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 07:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068492EA472;
	Thu, 18 Sep 2025 07:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AobXobEC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3552E9751;
	Thu, 18 Sep 2025 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758179325; cv=fail; b=uVwscGg1e/Y1rJLS+1o3ROEG5CLVMay+w0ZuExHD+R+bLb5ybqQfKtZxJh7aJ7obRJaOF1q6XRYsUtuKzUOdSVKv8QHb6jtEbRjFj5xEfGRFSQ8tfFDY2y7UTMT0VVrkrg/V9VZU2pRJoIyztUQQHz2/v+egZOCPl96wAMdqQDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758179325; c=relaxed/simple;
	bh=+cEa0IU8fVaEBMoOkgGu1cl5IQ+4pSZLT9A7S6ORpYs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OoBWHH41h+DhHHZVZXOKjRDzrYjUzstWw3EQGf1vEpzEpD10hgu4pIRHrygxbXnpUFYUNHy34KrlVydFbu58Wld7lHT0kXJheqwvGb/fEE3sV6K+B0NhUXx2k81yskLDFslWK0djT3+OHEJhJZnRy7RpVm99LHQbUDqO2/Kdv1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AobXobEC; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758179324; x=1789715324;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+cEa0IU8fVaEBMoOkgGu1cl5IQ+4pSZLT9A7S6ORpYs=;
  b=AobXobECAF4BihNXCUpHFD0BZ0E0/Peb7QxO7r3hxI9OIwHqESwLmI/v
   P3qjAig73Fq++H4CMhac5ppudV0gVPaKDX0NUISG7RylPRU3lZ0XaGEFC
   uTsW3wnUiwn+V030I7a9NwAjIbsS/nxQ1mAdh4um59Q5monayKGCfJtVE
   cIJXK6kn6lKCSW6+L73ecWtiLvtcarUx/lsbnqcAb+PJ3plBFYIQ3IG3I
   J2iLUNcsohLnDiZQYpxvIJzPR0et0eqBNDI0C6WDv27fVPrh2Buwg5DDB
   jSVC75B6JUeFXHQ80GuJxboq6F+TvnN9kgf3pPmrDz7MIJrE0BMvFwuH/
   g==;
X-CSE-ConnectionGUID: LgQR5y35RxCI//B/TvI4aA==
X-CSE-MsgGUID: gdjbhzCGTI6m4qdI6FenEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60417765"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60417765"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 00:08:43 -0700
X-CSE-ConnectionGUID: 3YuRJfakRMO2kOp3jvm1/Q==
X-CSE-MsgGUID: cBafiiuOR5+MbWgOw9/ZfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="180739584"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 00:08:43 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 00:08:42 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 00:08:42 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.15) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 00:08:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5MK+C6mS6u64fD22e/F/lOGtEDkoOggqi2FRn1fZcfbzpe3/xCQe3Rj+I3UmYf5Fm7CVxzFrU3hrX+gFyTjqhYxTbkv9BB4nhV7MSAh87reP/X5lTyEZ/b6wMAbbUTN8z+SaK1DBppXaaSsIuR9j5EAsTi37/iKoFzdmWcC5EdeCHhIX87IQGOTtR6Rz8oEpcLwuKLg9V6xdsFRz9EnUuZFohaG0VrtHZjid/iJk4pbtro2ix+sgjyStuuRRV3qD49E+fD0Fpybi7URHPJqXzeTQqmHZ+hCBm9DPOOBxYkPRRtvTjgqZ9THFKSVD7VVX/xcquC6K7NShSum9RG1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h74oLwxAKkB4m6YXg1aFnSlnlmd3qqWVI14PqJq2FwQ=;
 b=ofEtaRTiWQnzM0WAdPphzB7ZM3lxHPoznhZv9TedeZ4M4FnEUCQAqR8UKgxDZn5RCA2jyZislCYY3ezdajeK7veQpr4sQO4+p64ottWhvdi06ycnUxCUmzPxcqSIe8PLz29dFJFdYdx65o8ciOCoEm7cA3u6LLRXaqvExQbCeeX6+zgocIHdzdlprvwcqPQ9+GKPAbSYU5UBbfHI0yj8Hbt02EYgNTPgNF+Cad2/P6y+9oVsRUETOCg8gYSkGWcSJ7ouAR6a3IS0wr8MRWxzqDw80MfD2N/CwWbz7h089/5uIwCqGMuX/I2e1sYRrSjZqvXcTgsu7B4HjnOpU7RUxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB6886.namprd11.prod.outlook.com (2603:10b6:303:224::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 18 Sep
 2025 07:08:40 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 07:08:39 +0000
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
Subject: RE: [PATCH v5 05/15] iommupt: Add iova_to_phys op
Thread-Topic: [PATCH v5 05/15] iommupt: Add iova_to_phys op
Thread-Index: AQHcHPrAvuDqZm2qmEGsEiAUVezeKbSYm4Hg
Date: Thu, 18 Sep 2025 07:08:39 +0000
Message-ID: <BN9PR11MB5276A792314370662660E5098C16A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <5-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
In-Reply-To: <5-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB6886:EE_
x-ms-office365-filtering-correlation-id: 42d214fc-6945-4994-4541-08ddf68231e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?TmTFgKp8lbZlIJSC51R0vmeQ6XdfSNPO9C+xGxcfFLDo6uv8x5ejOx+rXh1V?=
 =?us-ascii?Q?TaqtqEBUjeg/6H80IFvUILFDw/3pJFWJ/cLOojjmIqYF+3BG9U+zyRP4yEvh?=
 =?us-ascii?Q?1OLnvf/71tZSm2Eqd/ad8urI1stHwkgDnrclT4YyuzzctFbGbce1ZKf2D2cQ?=
 =?us-ascii?Q?UDRvkaxFWBtM1R/+sX3mg9jiy9CEc9+DT3e6dTeQZO/vmyqdYsiTN08tMk7h?=
 =?us-ascii?Q?XnU9zxgCh61pc9uSe/zPMknvdvCWz/djvw1FsJs3NRmUe++RSAn95ExobY49?=
 =?us-ascii?Q?5zB7Iec5WXdug/tdxwbKh2W0o4+myAu4/8tXg9GLUbI8bfEj/CRcpV2l3U5s?=
 =?us-ascii?Q?P8noTODwSiUNlHUxnKi6405ZT8AoALJsJOTUPppFv7h+YtEaSL8TIfUqQoVE?=
 =?us-ascii?Q?VWnlXSFmIIsL80yQFATE8a/dDJ+D7clbpBbbVfwNgW3CAP92VfN34nhS+kos?=
 =?us-ascii?Q?wJsJCSc0vWB7t2Pt8Qw/DY14livzK35dTc7bXYEvD5KfIcl8egyQgxVeof6v?=
 =?us-ascii?Q?TTZvKHSq3nlV34JHChyhT33LL62Ll72MwbSdSsqJBml268wFThHNUk37k9xp?=
 =?us-ascii?Q?UTWSb8If38ms0bZQRMgNrFG0zlGwoUuSd7KZTx/uUGjO/PooUkF8IS4oaeLI?=
 =?us-ascii?Q?kqkg77csLkEoJAzH3uPf9tCAvmGfehu+tNBpYIegZNQsm+oUGCQMDmIFvGdW?=
 =?us-ascii?Q?JkkjmqGS4/qO5ZJakbLl15Ictk2C1O33iCgzPgRY1N1/E0AL2pPvNx9nX6Gh?=
 =?us-ascii?Q?RWxl52KpRYrEw+rXjDbDUyPZUOw2lvSTbUo7s6QCBazrk7gZQ0aGCri2TQM2?=
 =?us-ascii?Q?AiiwVAnWguHkUtozGJTbqTw12PUAQBjf+JIuUnjpllOCpcagkDhhD84ncMx/?=
 =?us-ascii?Q?AdJ3LRlCs0sbs1eNilrZFUlS3i7mgkEkAEjhOJz7rV85jzroD2j2/Bah5NN9?=
 =?us-ascii?Q?OvryUlZbeQuS3i7RuVJWR1tX5s83/hZvTw0OvLRoV7PrMPldlAA+gfNatF82?=
 =?us-ascii?Q?4Usljuq98f8nBpWlkJBAoutb4yMoeQFUpjMQ353z60Lu22ZOFI3Obhbpgb5K?=
 =?us-ascii?Q?STURtPChsa6C8UthbJkG9sncEIXRslgvzbJ3LOPGUrspQ6ckYBeLLnD2JN37?=
 =?us-ascii?Q?MVymhthiJdXelJYQlJV+z1lOQxQ9y40k4cF5ECgF+ie9B0vDkZJ2cmX39ZAg?=
 =?us-ascii?Q?vTwq3/9S6eVJllw3y85C3Jg5fYSPUsCEuLQUmw3aOL6xHQkIzHO3M9HAeGEB?=
 =?us-ascii?Q?gYKNOlkZTagBFW4Sb1J4bJrhfOKFpLW7NBy3kGVM0UY0E612p9OVJpf1WM5a?=
 =?us-ascii?Q?0zhuGaUpCc0yuc/+aTPgUBr+7GmNJJymuTEMjrEbba8q/1AFtyQzfe7RaZCk?=
 =?us-ascii?Q?Ku3QZbRHh/K6J4Vndlp/R6TDYRfKcIixH8eurQONbUmEgrUP51+ZsQnVnTRr?=
 =?us-ascii?Q?qy7lm0MHb4zsBSIzlhRRyW7wZx9+oNWenS8KExxAQoBhetRvPMvPdaQ/k/09?=
 =?us-ascii?Q?WypOMedGFSU3K8w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m65uLqnbLA7E2Yh9B4NSM0oinKw0EDAaF50ZUQ3j5oJl0Srw+96sv1EH7UMD?=
 =?us-ascii?Q?a6DfvBlIXCEzikd/hHlloVrC8mXBF2OlfURobV5xD6+nH+hb/+6BaNhZZA3H?=
 =?us-ascii?Q?CNM9tRWW/4Ihl+vndlTZ/uMSlwtC4Ql7qfNxP4DxWoKB9IGeCeGdAqAP7mnt?=
 =?us-ascii?Q?5zIXtaOXbTpR5ZjKK+PhqgM0U97IMlhN5Hj653XIUioPpcARE8RFx/HQ37Fq?=
 =?us-ascii?Q?6NCDAEsUrczncDN44dGYTLQXBHh9t2o9S6DMR2EfssGEpHmXR/d3FSV9yZM5?=
 =?us-ascii?Q?SDR1UlYVWDPosziw2seDgiPnX5Tiyk/eof6k6CI2Rp/qh6As44V76MRjYyUH?=
 =?us-ascii?Q?zWeRsmx7UqGc2Tdh3VHct09nfNkzFCxX0LWt2Fai8qHaTCYkPR0zMtTzzSdc?=
 =?us-ascii?Q?uzXXuzdT2NzC1sd3dTzr8ON8U2pMuztrnLLvfMT7AmA0OWt3QF+mYrTkYJCg?=
 =?us-ascii?Q?yDKZu2B3ut3r2vKV3EKQPyBN5pSAQmeKjLXxLUUs93WZ8fP+O+QTVxk5CfY1?=
 =?us-ascii?Q?Glv67F5K9xU9CNveJE2kxQHgs0epZeog2kiom9DlcKRgumc8+eyP9k53J2k1?=
 =?us-ascii?Q?RihoeDttXL5IBb11epKlhk/tm43P7RugX25AkgRQ+3djyOxWC8gG4N8dReC8?=
 =?us-ascii?Q?wyYoAkNV3fMM4gFrbYdL0NOnsPWIvSaj5xRaxad0AAbQu/Q1QR2yPBhU83Bi?=
 =?us-ascii?Q?BBLF/mhGZTkGJnNtaBVS2/45bHl9f+ZtBXusBAGm9wzwrtbi+aSiQq7pGbEm?=
 =?us-ascii?Q?xMBjxlh6Rs2V97lGVi/P04u/YF7xBNwhFUU9w45VrAx5WakCjJbx109spVXe?=
 =?us-ascii?Q?9lePSahEwtxnQDRxl6qFZV1iWO2fEmFlDXzrltBDWJmVCNRV/aD0EbSW5OHo?=
 =?us-ascii?Q?9pDP00aVUI35pI0ynZzgyTJ9SvcBit7fF2g6JbuLDTmFmXavGF5tvVLfDpLv?=
 =?us-ascii?Q?ws1k/Wvudj5lrIGz+Rtb0lOhwkQBoJ/CIKFj70J99/xJ4bQ0VLJPNUzuvt4O?=
 =?us-ascii?Q?lAGdh6eC9zFZYTtrfTXow5I69gCCVTH/UyCSvDq8FAX7g6fqWcxlGqjXHAag?=
 =?us-ascii?Q?JftB+8IctI77KMZa/YkXcxeV/CRtCGMdaW0zQgmX1vo1mUecmDh3yyafFQcU?=
 =?us-ascii?Q?/4123dkMaEeNSlFInYyHRLZRGpVPtCI0fOzkew+KBqbbuXY8xHlKhwiAY+Kd?=
 =?us-ascii?Q?M4XK1zXb87m+1ejCnJHv/x7ADwuuAS7fAlD9q8eZqoDtnAuubqdCLDWxrarH?=
 =?us-ascii?Q?COVnYwKInN1FTkg/HtPh0/qnnrWcZJO5O7nTKLKRxqBwYnjxAkEPqBMm5eME?=
 =?us-ascii?Q?4Z8iEsKXSHRVWTS+JI3Rnh/n+NuTxanVbjlqw8jxXys39EofGDyx3lhZrFXI?=
 =?us-ascii?Q?24DYkyBEsgiqjbKUfFSAAZs7P4/NdfwwIiCb3rbRGzH42LYmedu/Hvy4FkRB?=
 =?us-ascii?Q?81XYEhhq/tbnYI6T/baBy4sXTllgpmjXpIU6v5Lssaw56h32C1QgHuktMk4t?=
 =?us-ascii?Q?pNCvdqjwK0p5YBnyhLGYKqwPrB9I7Ek2ob/QpsogFFT3/E7vjCGAJ6DWkhXL?=
 =?us-ascii?Q?Agz/jLatbRiTVWqh0w1p+28srTEX5Y9Xk+ZofIZ/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d214fc-6945-4994-4541-08ddf68231e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 07:08:39.9141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yKMETJceG2F2eI8Btpya/gci3qSut4xANiLWOgZEhX0LPLwkB0s4nNCH33vT0gidjPD8GsS4Y4EpKc9k7VjW6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6886
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, September 4, 2025 1:47 AM
>=20
> +
> +/*
> + * Some APIs use unsigned long some use dma_addr_t as the type. Dispatch
> to the
> + * correct validation based on the type.

"Some APIs use unsigned long, while others use..."

> +
> +/*
> + * The driver should setup its domain struct like
> + *	union {
> + *		struct iommu_domain domain;
> + *		struct pt_iommu_xxx xx;
> + *	};
> + * PT_IOMMU_CHECK_DOMAIN(struct mock_iommu_domain, xx.iommu,
> domain);
> + *
> + * Which creates an alias between driver_domain.domain and
> + * driver_domain.xx.iommu.domain. This is to avoid a mass rename of
> existing
> + * driver_domain.domain users.
> + */
> +#define PT_IOMMU_CHECK_DOMAIN(s, pt_iommu_memb, domain_memb)
> \
> +	static_assert(offsetof(s, pt_iommu_memb.domain) =3D=3D   \
> +		      offsetof(s, domain_memb))
>=20

not belong to this patch

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

