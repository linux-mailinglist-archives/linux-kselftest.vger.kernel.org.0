Return-Path: <linux-kselftest+bounces-18430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B11987C34
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 02:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7C4D1F2375F
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 00:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8E68493;
	Fri, 27 Sep 2024 00:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KrrE358B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7DE33FE;
	Fri, 27 Sep 2024 00:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727397803; cv=fail; b=aIYYhk6wqHsTkQqPFfuCPGOI3NDn5F6Ry/950SR4Eho/GhZ7ckwezy9gebJ2ooj4r/RRCNpqJfHcOTXOEKnfjnlnk6lQNQf0OyJfp7ujE5yk5SyWdE7lD5qdL5zvDllueBm18eV+zxdGQUYLE3j8cTCmGPFUwJEExtADGlUCTas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727397803; c=relaxed/simple;
	bh=s8XcUs98KFhPWOQb4YhhzbuyEXavQbHIjhGBOGc+L1w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gatvw7OYtXutv4CKvvyzawMf5XEeiIN52pV7ZxgwBbCGIiX76/BjI3SGb/VEQ6+ZozubjnzsFoxgSUy4XrlwooWiBDpkthBSm+q6y9o5yIO8NeA8+SOjZtbvw1mzZ0dMSLHYEKWlvr+d8x0yyKWAElEIFNN/LrSrTeZ/IWkPETg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KrrE358B; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727397802; x=1758933802;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s8XcUs98KFhPWOQb4YhhzbuyEXavQbHIjhGBOGc+L1w=;
  b=KrrE358BuHZQ/MKDwmEY3ZAvqxi6qOUMZR76LlizZEcZIbnRgU3zRZAq
   yKPH2SAsPde+y1oJT67oBnFAm9q0M3ZLBnccl+OtOWtVhIZk0B0Gl7x+k
   ikyWlrx9Ogl6L5LHDn8ViAHglla4mTiD0OGCwVxEAvcnvv7Yu+lRguVt/
   j1aO1iirU+V6Vr9sEkw1vPD44Es5QCT+dmYua1UzK01Ea6TZYFxWN4q74
   wTEX8rBJiVtMI4QxB9bP5AWaLqMvGvYVoDexggBdwAx3rZrVkGt5P+Ahm
   1OqOZLadSqkfwG6Ot7T1Yr4GZvYugrtTDthQUcwlB0nudifrdWMZ27non
   w==;
X-CSE-ConnectionGUID: zlQ4jE7qTDanISmCp3obHw==
X-CSE-MsgGUID: TZ7wvPcJThqZETmuWvw9wA==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="30420459"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="30420459"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 17:43:21 -0700
X-CSE-ConnectionGUID: M1xV3a4uQFGK+YEa5N5xlQ==
X-CSE-MsgGUID: 2OgJov6hTY6wtbW04WukiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="76863770"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2024 17:43:21 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 17:43:20 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 17:43:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 17:43:20 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 17:43:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQ4Qhf63bNKRZ1SRe5X5QmGsz6u/kzJartimlZbyn3bl0QGXo13yhqrdMz9iad89wTJVFR9ztdfHqpL7olUTP8AZ/IVSbG64O45PMq2puTuwY+Xxt7/jLNNd8M8TFzygfYzNohYi9YeTS27l6sqajkU+KTitJuGXOQr3iP1p8hufu6STu+8wDAvc/8Q3W65S8XaBBa+J3b9Haibfgnu/2c5ZqoQ6i8To4PNUINRQpWKgBpGgM1OdqnATz5AlIAmolwEtGlDEsaV4GYHWtBR/pcb7J0c4FTh3GckbvLH7HU7uaA+0ND5+w5sjkhClOVks9BBjDhG5tHE2znZ/faxOFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkJcCW6MGcpxWpN6VVdk6EmaSb9PYMvX6M0zZefZSew=;
 b=PnjkiYx5o8x+GvnH0XkCc67Cv5Pb7JXQNDcqsAZFKzLHYwS5wJC2eY9Pnt90+CZDyAjlYWZVq2KNW5KYGQjd0ECpQFSo8ulJLaSdTHb02Hva5Eci7XXPw48woLcUO9C9wT4CiwmcuTb9cvcSgeMPsgpZJ09fj76+gHOmjvkABqHU6583d0J+tqKd//CAyfQSs+2Sj9gY6u9M0NaZA4rn0rXoHvjIUsoYmSq4OQXGGwks1IcZraY7t7eMiOS3RrLE9YlEi+sWCcOyGgqk5jKbDD+f3sNLQlloFZv7CZ/6xnxRv8OBtdc5HHYzUrIHyWlHxkUQSRSBNJfkquhWceqKMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB4850.namprd11.prod.outlook.com (2603:10b6:303:9c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Fri, 27 Sep
 2024 00:43:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8005.021; Fri, 27 Sep 2024
 00:43:16 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
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
	<smostafa@google.com>
Subject: RE: [PATCH v2 04/19] iommufd: Allow pt_id to carry viommu_id for
 IOMMU_HWPT_ALLOC
Thread-Topic: [PATCH v2 04/19] iommufd: Allow pt_id to carry viommu_id for
 IOMMU_HWPT_ALLOC
Thread-Index: AQHa+KL+WnU1UabCs0ODhwaBTMTv+rJp8RQAgAC984CAAEt2UA==
Date: Fri, 27 Sep 2024 00:43:16 +0000
Message-ID: <BN9PR11MB52763F8856FE20ACACDDCCE68C6B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <2d469a5279ef05820d5993df752d32239878338d.1724776335.git.nicolinc@nvidia.com>
 <3ddf97a3-cf5b-4907-bbe4-296456951e6b@intel.com>
 <ZvW/vS5/vulxw3co@Asurada-Nvidia>
In-Reply-To: <ZvW/vS5/vulxw3co@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB4850:EE_
x-ms-office365-filtering-correlation-id: bd3395f5-4d86-4706-2865-08dcde8d600b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?J5byUfvNwMJry/Y+5GtmtWQouhTUXWAg2uvGsEdtXA+Ck520A+AjT8jP2FsU?=
 =?us-ascii?Q?zWL3XXHxe6bbythPB0VRwtIoRrqhPEmJptcO1l0s9g4EDS4q0zj3nAGSD5Eb?=
 =?us-ascii?Q?p1CaJMlDYpcjixN8iUK6084aIfuNlSSW/Hx8eZHeprFQ3iwy2wvP3Ur0EnrN?=
 =?us-ascii?Q?XYI0QWLObseGzQYN81n7fgQzojgKQ3wurZoRY3jbK/39a+4H2R630ndFQlh9?=
 =?us-ascii?Q?MQWtUf9M1BDamzudIz3IlQ1LSjAcmiu0uisrZ4Uy6Jy4cvJo5nSklT1JyL/B?=
 =?us-ascii?Q?9+50nKtCC56JjJRM3C5TnaMLW2XjtrKkM78t9wUAtm9p742dLVsyXdk1bfVL?=
 =?us-ascii?Q?pDok3Iia1m07brZUz02+6v4KAmlVRix3QExBof50UV8UMkR7wEuq6QG/7JXL?=
 =?us-ascii?Q?YtGpITePns/hD1aMeB4WCkREPLGJzkpNshUA5rEpd8lsN8pWeYVJ31itR4GM?=
 =?us-ascii?Q?GcKGiAuWEcF33d8331hTa+37o7/W8y/TEUTUjOOcRcfSH78exqoYhbP2OFpO?=
 =?us-ascii?Q?YUNLLuNKLJdYq/JUxvQVzmlJR1gRYh7LtUAZutD18QQvCzZGcJLkL87EeIPy?=
 =?us-ascii?Q?LvJeVN3be6UHKuZNfYV0SJpymnZguwLxp6VCkrdUXvBa6NNpMPho+PHYN7p3?=
 =?us-ascii?Q?xjo9zZ3aoeZL67FuY4fOFiSoZUqly5WBwyX31OjlMoiKmi+btdKpOneYfhW2?=
 =?us-ascii?Q?ezej+8dNkb64txKFfRaKJ988HNE2vhC44OPr+Np4EE0nDy3GlxOme+SVlBtH?=
 =?us-ascii?Q?EmTWN4h4WuJFnh+ij+UlcCs4lGm/CFScOIT43+6VZMhKPUm7SiLKRKfxHist?=
 =?us-ascii?Q?kGFxHARYpflWD0elMMyYOfvEoJkWE2WMKWEOKO3Zv1vyswuH7sr7K7OSpZlv?=
 =?us-ascii?Q?1ZIBa6CILwFaivbty+VNqprpGzBxSe+kyKgF60Lgg3i15OI5TwKrXNFbskW9?=
 =?us-ascii?Q?r3ff1dOhWMqBiSp2btFMl3p81RGEf36m/XMmbFC1bz5qNYB+Z0z94FvzP7ds?=
 =?us-ascii?Q?v+hBx7my8M67f942N14PluT5baPndGT50IxlTCVrjILRerP9m8fXkiM3KEAi?=
 =?us-ascii?Q?FdfTQPueAdjPteTGhf+6PBrD6zQNy1t5Po4kWEbPOHfpRuOS7rPkF9gxmyml?=
 =?us-ascii?Q?6iDxW5NSqIdjLf9JyImyYDjGJf5oYgFXm7xSGlSZqtggAYsONcn/b5FpdP6u?=
 =?us-ascii?Q?RAmdT2bLHh6QtZrxYs5i9TDFIalPqmCxtUadV2RWcQN0n5tnUiVHNwYEHMKU?=
 =?us-ascii?Q?QITXcebCShHkEUt+gMPDf/t7XOPZjwBET8CuISoxHHOVlYfgwgPIXvogjaY1?=
 =?us-ascii?Q?iYSnlYAKkLR3QojQl2lSSmPMl8ZAsbb2saKpSEHKP3xKvreMl8b3fpVtkB62?=
 =?us-ascii?Q?Rkxj50hxXvHj9hPC94n56HYQf6UkQ+fwN7HDXSEe3P9zhsP3Rw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hFmgIp+MPvO2LTS1GW9Hl/1DrljdlHOhXiDLVfwgMNuVBzicMNobC8GPhppN?=
 =?us-ascii?Q?H9ReANP578Y2tFVa3lXm2YwU3uYGy9SXHTTT8O84Jn8ctWIoWeonkxUxs9k+?=
 =?us-ascii?Q?RLHWhDWip4JbWALMk5OQGPk+sp3ozVoRzpVHr2zF9Umhypc3bpwO93kCpYGW?=
 =?us-ascii?Q?RoCS7KsL3GO3OLXOoU2Vr20VRWZk83xMq3LqLvl2ducVQQ4BTW1GreukzW2b?=
 =?us-ascii?Q?vflnXOkMU9L93Nnpas8Y28ApuGHYU7YzAQEqNamIx6ypJgddC93qXfPLdD4m?=
 =?us-ascii?Q?R9YG4qDKnqGCeMl143t1gsCreWtpStBWwod3cBG8+JTtgu7zy2KnDFYSLN9J?=
 =?us-ascii?Q?F73Xn/tPWUqNOBHvKOUjQsjBr+fWIn4jyVS1sdMdEgeeo9aG786XexQ+sGNe?=
 =?us-ascii?Q?tpYL83qjV+u+IoQEkYM1YwtGlhvKjBJq+Blp+sszWIBHKx93lDTsTVY74kae?=
 =?us-ascii?Q?uZaVsQznxUxRsLwf2kqVvaEXNol6Hs0xlXyWUfFcwip52xQWJLgT/fmZMA8+?=
 =?us-ascii?Q?2iy8WBtNgQVqmR9yIwwJkdVSQS4j4CxNTa8B1kYzzxORZaYVSJj0NQqE8Rxg?=
 =?us-ascii?Q?gJ/e2y/vmjVv+jGckyMwYyweTf9gdWhZRJUM8PBm908Yegt4Z7DePWvzV2b5?=
 =?us-ascii?Q?z1SooHJdi/M7ERaWsQ/hgowenTRMDbUpX6atTu1xjEdcx0xCFcIglNcQSbh5?=
 =?us-ascii?Q?a/eUTPsUsBrmsGNK6D7cPOH15iyNpII9pA1dO+2Ev7vtGlFfSk3oNtOAFzbC?=
 =?us-ascii?Q?eN0D/k/NkL7oiHlzdZauIv6gwLdg9CffXI37BsH98EhUtf/4y9YFqueXEeQl?=
 =?us-ascii?Q?oZ8YtAOQ3bAgRGzsUhRWtUz8KQzNsHfuI1MO2EKXETgjlQMW3nvPJJs1uA1s?=
 =?us-ascii?Q?KsWSwGm0/XxX2YPsQ5J/jwPkPi5u++wAAL3l+4sW11T4mN6OEf0OQu354Mg1?=
 =?us-ascii?Q?42bhRC1RvrT9u4ZkvO6GmkXBhe4P+yAa+EhVFrooIQEQpX7d2U4yVN/cs5rI?=
 =?us-ascii?Q?8jpJBPvMchLOga3XPbCjPB77BBq2smcPC50PKeFpsF20jro2mM/GORXyRa4f?=
 =?us-ascii?Q?bs6PNqLO4vPJa9jQjHIZAFl1e+LMiQxtPywLBalkQrxxWg+jW6lblsg+UaOG?=
 =?us-ascii?Q?PHnwV+upTrKswlLIk84/NpR/CySnHtInkm8PZdt+3CV/CXdK874LO6I5iG9g?=
 =?us-ascii?Q?c2QCvKgXwiYxC8Bneu8QFhGOX4I4CdUH8uYPrFS2A5H0B31B4YI1SolWI8qh?=
 =?us-ascii?Q?InmH8lh84gXtvXJQr4C01HOm78A2u3Q1o1weUn3H/vlaSqzAI3QBrwHyqUDV?=
 =?us-ascii?Q?LFnF6OH/Jcl/EZpRZ/TmVqDapvbAuAMebKRZXyotFoXgoX3Sk5JpTN3+hOdn?=
 =?us-ascii?Q?ZhRWkKPSUlt0mmzpe+zLWJaLEx+IfKUiZefBSW603xr9OqZAPXGfu/IWAt3b?=
 =?us-ascii?Q?ht8RMyNUHjbNnNYHyqHbdnA55d4TU8K/+v00OblIkRzdQrVybv7XTM+/nYxr?=
 =?us-ascii?Q?PDmIGGk+ohiGZqsJZ8hcerf3GY2+EzarVRwa2WaHBvreBtPgDihR1wS9xRhX?=
 =?us-ascii?Q?G2HpSS6B4lTG6DQ7GnFWVpM4n7v8VwdyX8DwZNK0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3395f5-4d86-4706-2865-08dcde8d600b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 00:43:16.2608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UvEb4j8MVmIhM6Nzr3PA569McId++riSBNDuqwPlgMrh2ZBoXkA0iVhbxzz3MdQzKJvHOyTL3wcv0JalhOtSkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4850
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, September 27, 2024 4:11 AM
>=20
> On Thu, Sep 26, 2024 at 04:50:46PM +0800, Yi Liu wrote:
> > On 2024/8/28 00:59, Nicolin Chen wrote:
> > > Now a VIOMMU can wrap a shareable nested parent HWPT. So, it can act
> like
> > > a nested parent HWPT to allocate a nested HWPT.
> > >
> > > Support that in the IOMMU_HWPT_ALLOC ioctl handler, and update its
> kdoc.
> > >
> > > Also, associate a viommu to an allocating nested HWPT.
> >
> > it still not quite clear to me what vIOMMU obj stands for. Here, it is =
a
> > wrapper of s2 hpwt IIUC. But in the cover letter, vIOMMU obj can instan=
ced
> > per the vIOMMU units in VM.
>=20
> Yea, the implementation in this version is merely a wrapper. I
> had a general introduction of vIOMMU in the other reply. And I
> will put something similar in the next version of the series,
> so the idea would be bigger than a wrapper.
>=20
> > Does it mean each vIOMMU of VM can only have
> > one s2 HWPT?
>=20
> Giving some examples here:
>  - If a VM has 1 vIOMMU, there will be 1 vIOMMU object in the
>    kernel holding one S2 HWPT.
>  - If a VM has 2 vIOMMUs, there will be 2 vIOMMU objects in the
>    kernel that can hold two different S2 HWPTs, or share one S2
>    HWPT (saving memory).
>=20

this is not consistent with previous discussion.

even for 1 vIOMMU per VM there could be multiple vIOMMU objects
created in the kernel in case the devices connected to the VM-visible
vIOMMU locate behind different physical SMMUs.

we don't expect one vIOMMU object to span multiple physical ones.

