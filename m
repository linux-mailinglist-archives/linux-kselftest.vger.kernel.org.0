Return-Path: <linux-kselftest+bounces-33035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A857AB7E2D
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 08:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F40D1B61E05
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 06:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D305E29713B;
	Thu, 15 May 2025 06:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d1B+21ey"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AE7296FC8;
	Thu, 15 May 2025 06:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747291314; cv=fail; b=ht/io2cdWlgZytT7Sz/T+UEDsTA0v1aZE0TA1RjMSexRuvTAQpYv2BpwscWiX6kRuiM8MQVYxVlv/Ye0puJ84l8r7fSEBJ20G+BG/Zo758Kjc1DtGMuzGQIgsS8YGNlgds6z1U2sd19/OsT34h2Aza7cDYjWclsrQzxepn0F/Kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747291314; c=relaxed/simple;
	bh=8b1vd54aqX5oDtjOSQ+dS3E1t8HWzeDRREx+EwLYG6k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i0w3iLn9iJuEA9SihD6jbspmHuQDzoBdl4OG5Fm/LCMdQE67y8rjxkBSni1nepsPl60RfRJFzCQnWGP2EKfDA1aqzdiBmRVjwq7OCG6/JHGAJ5cNQD9p1hw8GB7tSZ91Kx16cMiHPDtvjV3IR5D0X8+4uLi250HZ4VbYrlRDv3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d1B+21ey; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747291313; x=1778827313;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8b1vd54aqX5oDtjOSQ+dS3E1t8HWzeDRREx+EwLYG6k=;
  b=d1B+21eyln/F318WpvA4F5NBLoM3bOvCOWLqbodyxTHRpnPiegWkh8U2
   Tj8FjnSQDTcrTM42/yfkxujNrqzVJA8gtAZxkXXr3EShJTbevlnNtGAFT
   N4exMdPkpYsESbduOFKzpoLVoY7p98B8aZXK6kUe6fVNjyFuBTuE34IiT
   rSNthSK5Sbd4VkhqfYec77PveNXlEdcqex8nBk2ZuVyl8VqkE+c/UX5M9
   FDAzkc4Tgsjoi4ixMMphi3CQggFDN5d0Gm7A3AQTxfNyuzVHmmaRU9m4r
   GNnWB8/+GEmca7vHi4ba5y5ppLuRga9MHtR8Ry73HwyZ7coKYOSDEmsBN
   g==;
X-CSE-ConnectionGUID: ruExX/54TrOJdh5a9OCHZw==
X-CSE-MsgGUID: NZPkT3mhS52sTKbRpk8L5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="60550077"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="60550077"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 23:41:51 -0700
X-CSE-ConnectionGUID: 4GHTABV+TNiXLkAagcp/Hw==
X-CSE-MsgGUID: KSjrrzyZTY2e6KGFC2UBRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="138142396"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 23:41:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 14 May 2025 23:41:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 14 May 2025 23:41:49 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 14 May 2025 23:41:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qoe0jbnmoYd/YqxlMlMJoo83VZAy800uSbpUVEsqqab/8XUqHopfXAYYSD1Kc9wXcdsogyD7GdjlBXMd1aGCXvRIPyTbOT3TQjxLmvjMDCpsL0jzSTsgS1yZ/qOckKlj/F4wQiYGSX1UqWsK21YvEPfv9x02SM59/Pp8y6pMvC5dF0p5Ro5PVffYtIOxR2F0ZTpj4sPmvRU/lgyFY5Ttpz9TXuTb58Y0FUZkGGA9JoYZSW1kKommBeWE5ARrAvUKIpr/aeVCPSlNrlVwShIwLDkIe27JofqxNH0SRfov6/ZEPGmz/80HveD+bf+x8RnLmO6lQzm+3b097OVGNk6rzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPHWZyb8nVWwtAknqbLZkU9K7lsbGjqT9ExLw6AMeTQ=;
 b=A3v8+YRWFKHWnfGVx7qIf/jGT57TKKpWG8/gERAdHGq8wswP4FIBB0TbajBsFGgz6IFsjQp+0j0Cd9kfF03SEGV0Jz+VKej+609Gnaan5lPv5HZIMyzeVfrTaZwtFWPDKjMxqAiwuBK8SFNMSJKyH7FpjOB20GKx3gG9N7orzjBwfXyy4QV8MUCbvY0db/Y/l7UNQxmS711rfWCKr22LxISzXFVtZywx+AG+rqL8+n9lJk3aRTe7k/ayibT9fSWXHxfuCNfgD2oZ4awU+oVz11igdsmCry2Wqa379JK37vZFmEOr6cuZm1yP3wUR7xP2vqXz0vt5vvT0seKsQ9ek6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4551.namprd11.prod.outlook.com (2603:10b6:208:269::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 06:41:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 06:41:04 +0000
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
	<vasant.hegde@amd.com>
Subject: RE: [PATCH v4 14/23] iommufd: Add mmap interface
Thread-Topic: [PATCH v4 14/23] iommufd: Add mmap interface
Thread-Index: AQHbwI8VTngA5r6ko0WEuL66n25SVbPTRuzg
Date: Thu, 15 May 2025 06:41:04 +0000
Message-ID: <BN9PR11MB52762B5DAD68943C4C4AB0DD8C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <ee9ee287264fd75eb4fc64a63f20d03e9ba18161.1746757630.git.nicolinc@nvidia.com>
In-Reply-To: <ee9ee287264fd75eb4fc64a63f20d03e9ba18161.1746757630.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN2PR11MB4551:EE_
x-ms-office365-filtering-correlation-id: 1ab16f9b-9284-46b6-18d9-08dd937b7756
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?0G11ydMMvj8O+tOyrM/sfnWsT0ixLlDoohSsHdEtRfjUMgV25d03RNaa3q0f?=
 =?us-ascii?Q?t2QE6AN7hL237LFGjio0UZIs6qP9AfehTobAgfYBQYMfCM0w7upUYRfMIHDH?=
 =?us-ascii?Q?Sl2X5O9iiiI/IRb2yPzDm7GKsUJOTYHVv5Ibm95mu3z/lCAeFUZtvzuHX+mp?=
 =?us-ascii?Q?9ohBTFYWLi7LGJvv0TXr0S1P5O92xibJMYJ3ZCH3r1k5WnheWBYVJYMjhi0B?=
 =?us-ascii?Q?Gb3a3caY9zHRmBd/ZCysRpT6ey/GUCX+t/wrstjLu0i6HfXxQJosPhP2WGio?=
 =?us-ascii?Q?58zCICY7G7o7fLHh//83fL950sqJGW0exgfrCLJJZ4ZedFAFaDbC+kSPhNz+?=
 =?us-ascii?Q?3YXNwjD+ZC+Xv5/SH6xQxzGs2aEt48tZD2oUeEJ1gYBRhCYTrOAnrcBVmfzd?=
 =?us-ascii?Q?O0s27wgFchFWpN37sSkmDLuIJgaVOQR4NvudMGXiHTW6O1MgQz+1bIYrwPO5?=
 =?us-ascii?Q?okhTV+CSEboSAX3lJgJuoh+WHwk3/VQ1i0w6OjDDRvyp98M5kTt7gPsedfug?=
 =?us-ascii?Q?D92o8pGwKgE+6h4CX0MfsBDao3GGkwhAppERCLBKJbfngtle40cG6Sn/chqa?=
 =?us-ascii?Q?ODXl4h0MpnANGRJUfxqsLJ+6Y/u790Ba0FxQTvlSanj4tvMImS/2yQ0mjMg/?=
 =?us-ascii?Q?TY+IQF7MVgz/6egIu5Avn9sgPFpBvGyAUu5ikZdd+rUSU/0gJXg0Clsq8O3A?=
 =?us-ascii?Q?Ivjgd8I+Qu6SqHxAXtoPmG9GXt+l5gdCQu+SAVArPdh1Io5N6KzjprruxQOs?=
 =?us-ascii?Q?T2hR4fIzMRcz53DXnGRBMSas1BerrnPW6xg4Q2zWBcpT033r0qwq/9LO7DMd?=
 =?us-ascii?Q?p3Keru4kf1bkR3DVmMoRfPiPuTkLPoJzb2G4hMLvHkZMgNV1otxr+g3KlHWD?=
 =?us-ascii?Q?DFZYY7psAxUwSrJtIADNe4RoquvNSGuBSKgcrmTK+nQmrDg0oLmH0JRgyQCq?=
 =?us-ascii?Q?y8hle8ius04CTr73AxT4c7fE/2yX08XSbbfZEIg+IY5mXLLwlT60uGaYJMSq?=
 =?us-ascii?Q?ghmKcJGSNWnYH8tryHgtZUP8MITHSYZQ8342zQJjoJEXQeU2dqGy1NR7Vo2H?=
 =?us-ascii?Q?9WmZBdb0peWQd9EpzzPlKzjQ2c0TbtJcUdGW3ygWdPtuovc+iXgrCW2NI50U?=
 =?us-ascii?Q?Y94WLetOLHRyJCTKyFosbuWyo8AHq/3YX3417HBJcrSSNmyojkOWbEhtNvsR?=
 =?us-ascii?Q?wCNq/y55eEYeedKe0zMuNJrb+ktoJamcbiaXME+EQ2/xfsEspOTOZJDRzBP/?=
 =?us-ascii?Q?klhRSshGwenkF9WsDTgGrjptcOtx0BnsdW4Ri7yz00Lf8Fu78ib6pU/BkeU0?=
 =?us-ascii?Q?oIAzFunkxTXjRUFLa0rA6vKllmXHEyL1oYHGP9nNIT2IfI8BvLVbCoPskuwq?=
 =?us-ascii?Q?netIkjxkeobrsIOOE5c3botF6/TSHzWhSodULhFwuN5qTo06xVB365xmnfku?=
 =?us-ascii?Q?PejHNa5+YjVeWUfTVniFUudMuTdgaXXxU6fc3EWPpoixOIVFcNGpvSqOZnHe?=
 =?us-ascii?Q?ZGy79Ul7s+MavsA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HNN2FySYG8Iz26MhFImu/ZwaWnny6G46wiS1m4BGVsnEgCDMmJYdU3lxR01w?=
 =?us-ascii?Q?B2Mz+yAAKNRXjuQe9ZxjVLMdW2TBOiX3+gRdobZu51tnD4+txQe3s3kQn7s8?=
 =?us-ascii?Q?UYrJuTZ8wl5BC0TqCkzugLQ4T+R1UlDM3Ng+Ai3rWbrOGgHdO6LW1Cd7DwaN?=
 =?us-ascii?Q?yvXoYSZVlwG8vTtiEne+EiRScx3g+iGtfCbAPxqH5aGpR+r8o42mRjTitRWq?=
 =?us-ascii?Q?191S+Pk7FyGc9pBRha1Ah6ywUogCYRRgUMvmLn51BnXY5e0ggkhg8kmI3EzJ?=
 =?us-ascii?Q?exq8BzkLxfjBTfA17yai4rNVA488f0ObwZYilX5qDLvqzOt3yUMDbITvDWw6?=
 =?us-ascii?Q?sIXL73yTcpV5Rzitvglg2sWoEx7np2Xq81lSVTL2XdIJWPttxxUtVqVhAYhG?=
 =?us-ascii?Q?P183a6hR8/kGz9NDmbAwMf7pShEwGM8NxkBpX8bOyTMZVfZgoEspZ71AUOf4?=
 =?us-ascii?Q?QXqP/uNd0AHhrzYsfdzNz8gla/xh6D/Ba1AMISfzbARq5str28/SRwYPAz8X?=
 =?us-ascii?Q?Jd7HtrSIUL/dvWKMk5XQRe7RkaliGFzXsVXQDFXqCC2jR2T6OPSSZvDtAcsO?=
 =?us-ascii?Q?pnxCx/Gz3kLwcnOKJG4hM7V6oAX6j+BnFTXObb+hMCt4Qkckeh5ftFtQ7NDN?=
 =?us-ascii?Q?ll1n2O82QkGKWhbulJlnIXVgNyGN+oMUVgV46D5F5DKE5SRvk5yKvV/wSYUW?=
 =?us-ascii?Q?zeK4q+9L9QDL5ynZWbcoHXZUU94ffAGRF9kqhdcKWtNlK0oATGgnbluAHbAp?=
 =?us-ascii?Q?GOFjZ37LJC/jKfiS8lvVjKYdI5yFIn54nlTeEVk+Fh+kYiQITtNqf3i4tjo7?=
 =?us-ascii?Q?2+esAFnCxdKEQe2eXpKVcHxn07D5UF+hDWlmP3gYqCtX4JERUtiMvnWZLScM?=
 =?us-ascii?Q?LJ8oNQVbyddnBdraffmXyZiPTn19wGJ2ohPp4aK0V22XZ6GX5HfMJJ6IpNbv?=
 =?us-ascii?Q?c2CaX7M3giCVwCWCiUY/zOQKM8APL3QHyBy/0UFH4Glud+Yb+L7DhRcXtbPf?=
 =?us-ascii?Q?HnKlrQe8bXiOJjhZccONIqL6N5OornjDGXeittfUjnDppioO4OHM4jOTDIgE?=
 =?us-ascii?Q?s+n+fJQGaCorieaFZ01Xtsz1HUVcJ26wUxqFwxDsB+bnTNZ37z0Vzwctmu95?=
 =?us-ascii?Q?vcxFIg/M4GChhhfCDKFx6QGSyoJLqDb4MkqDVXwyQuK9+x+7So3/736OKSAr?=
 =?us-ascii?Q?L3fVMFm/uQDeM3JwiPd8nhcXBXNwbZCBBCtr3IR35AygJ+yLzvNAJiY6gf90?=
 =?us-ascii?Q?rjWwO0iMJXb+RPcehxsUUt4+ff46zqMDoUKfdQTSQ1Q+72Z7dbEv5+Xys/iF?=
 =?us-ascii?Q?nraou2G4JOE3AlqCz9ugKebViVTb2MA8gkASph8KSdeJbaphny1I90M3JrcH?=
 =?us-ascii?Q?7LaBqoB1Kfqi81S+airUD0YStHvnc8Fu0TBbZU3Bgk01Y7iW88tInb2aOcKI?=
 =?us-ascii?Q?TATUZPOrsJnc8Alsnrou+KvIvKLbt4P6GrSYOyk52ReRlB8I0k0KYif5oxrQ?=
 =?us-ascii?Q?/OdcoD7icZqbJ41hhBCBd+OYHyaihYiZhD/GwtWAlCa+gz5tvd4UejXPNpQv?=
 =?us-ascii?Q?G2uThTYlyET0+6+EGA5IkVT4WkNv0lKEic3HdK/0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab16f9b-9284-46b6-18d9-08dd937b7756
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 06:41:04.8704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oNrNzTjACRuFsrG/rvbqacR+CVoNOgsq4JnrSW72jQ4FOZcba6z1/MgUQgg2aeje9sGFeDDt7yrOSGeXb/UYjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4551
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, May 9, 2025 11:03 AM
>=20
> +/*
> + * Kernel driver must first use the for-driver helpers to register an
> mmappable
> + * MMIO region to the iommufd core to allocate an offset. Then, it shoul=
d
> report
> + * to user space this offset and the length of the MMIO region for mmap
> syscall,
> + * via a prior IOMMU_VIOMMU_ALLOC ioctl.
> + */

this comment better suits _iommufd_alloc_mmap()

> +static int iommufd_fops_mmap(struct file *filp, struct vm_area_struct *v=
ma)
> +{
> +	struct iommufd_ctx *ictx =3D filp->private_data;
> +	size_t length =3D vma->vm_end - vma->vm_start;
> +	struct iommufd_mmap *immap;
> +	int rc;
> +
> +	if (!PAGE_ALIGNED(length))
> +		return -EINVAL;
> +	if (!(vma->vm_flags & VM_SHARED))
> +		return -EINVAL;
> +	if (vma->vm_flags & VM_EXEC)
> +		return -EPERM;
> +
> +	/* vma->vm_pgoff carries an index to an mtree entry (immap) */
> +	immap =3D mtree_load(&ictx->mt_mmap, vma->vm_pgoff);
> +	if (!immap)
> +		return -ENXIO;
> +	if (length >> PAGE_SHIFT !=3D immap->num_pfns)
> +		return -ENXIO;
> +
> +	vma->vm_pgoff =3D 0;
> +	vma->vm_private_data =3D immap;
> +	vma->vm_ops =3D &iommufd_vma_ops;
> +	vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
> +	vm_flags_set(vma, VM_PFNMAP | VM_DONTEXPAND |
> VM_DONTDUMP | VM_IO);
> +
> +	rc =3D remap_pfn_range(vma, vma->vm_start, immap->base_pfn,
> length,
> +			     vma->vm_page_prot);
> +	if (!rc) /* vm_ops.open won't be called for mmap itself. */
> +		refcount_inc(&immap->owner->users);
> +	return rc;

let's add some words for this refcnt thing in the commit msg.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

