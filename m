Return-Path: <linux-kselftest+bounces-43289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF070BE1D22
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 08:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EEE91899222
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 06:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920252ED871;
	Thu, 16 Oct 2025 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C1+yp6Gb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD5E1FECB0;
	Thu, 16 Oct 2025 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760597647; cv=fail; b=geb+m8sEZeB6ULs5HxT32Ce4bZPtrsGzV5481gh/kVfVOxzm8aq3Niobw6EThI3dm7Wu+t8ov1hjzo0BJeJ2FacKffiEQz54tARhm3PbGwaadWt65MKIeATg3p+ZCs9EZ7o3FnC/czsWMwLR1Cl42+Mt+uZN4uiiMt1NFO5NdVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760597647; c=relaxed/simple;
	bh=IxXkpONyDRfa1ZXlcFD1+b5kMDCR6VbZCS0auydL/ZA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FtjT4EVpInRqs8EXjRQth/zd6aBI7ObB5IHYYKpdMPcF9wXAZ84njVW0zf03BXuP8NfGnkQsIrMIxoscrcfbqB+ks7UautGYdyDyxSwcyZ0dFqwWj/stHXKhXS/pdvGkMqJyXp6UTGU/BHXysUC5u7hB8jnaloHwbzS/v8S3KGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C1+yp6Gb; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760597644; x=1792133644;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IxXkpONyDRfa1ZXlcFD1+b5kMDCR6VbZCS0auydL/ZA=;
  b=C1+yp6GbWCmgEIcabG2uCuFX3cOTDI4wSWJdfgT0S6hiojv1gamj9B6B
   Hp7z++ununsWRxuT0P6NULqV3jjEj1WCETl7WG+hyVuoC7pFWQ/jm4rTD
   7uGEyRfUT2NdwiL648mvulqOPKR89ZtUpPJC25QYk9L7+pc08kzy8ALyU
   9xKZTKlvo7MQ5/ORBafMMkrYNce+4bB79DawU0jX9Lps8j7v7ga07zjqs
   l5Wvd0FpZ44jn1epvSjc6qUt6f5ouMUfCMXyF73RiG2ugiSOLMoHRJ0iS
   dQdKUE4h7qqgW8ONfHOppOoB47HVVbWscVhFvPZRyF07uwi4ACpXZPH3u
   g==;
X-CSE-ConnectionGUID: tsza8rBvRXmRWQaxkYNj7w==
X-CSE-MsgGUID: yRRlyYZNTlG2Aq80AND7gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="80416906"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="80416906"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 23:54:03 -0700
X-CSE-ConnectionGUID: LevtiGFQT2eWKqQ4iiblag==
X-CSE-MsgGUID: YTPjPwNvRyS/WWZ8k4vZ9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="182049847"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 23:54:01 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 23:54:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 23:54:02 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.42) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 23:54:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjyWHiZ1cJkbInxocGO8cWLlEbYcmLJGCSOk2nF1SzHou6e6hnjRL+V9uzbQor80S0m1e49I1x++yCgAnjit0NMHFG2yI/uNpXhy/YbyNkK3HID0NBesoLO7dV1fuc1BRVTDkLOIzuCAu5u/8CKDuBgvpUqIRPcyjFWGg2Kit9HTygjC6pqzKzVklfokeDbWD6zY354jFLKxutqCC6ykvgIGYR8BoFX/q7JsmaQ2WbcfO/1F9ROnABHZTQOOWAz7YYeVENLlLAvSdv5nXMi1dcVSvpKOyyrMotOBSAc6E4NDImeBwV15lIpVxT43HiD+Om11eFQDvJW/Tmlksi5S9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5yXk9MJ3HoidzA36zrirycR3YR7w38JmLlEj4zgDkg=;
 b=Haz189Ksg9Lyw5TXoDIxF0JW44Mnmg0AoaakpTtfEuW9SAjfkH93V8tl3pE9hnkY4UAo73CfHZ36i69Vv6cVLKpKJ8V/nRQRriWjAzYLPDoXW/XONzI+RZjADO4jeQmLM8Bb6r+UHplwjfNJzA33p+Y5k+lZPcOG4EUUhBloQK5dKJVvXhElaLSPu76dRopQ5S2WmM2zKUNQnXVM90UrptmEaXsBk4o9qxyXTt6UXqOpuyhacrB7pGTt64Y2j0upVr8J3Emcma0L1yXfDsivRulyXvRK2evX5DyqCZesMriJmmgxhcpMsTd7Bj9qjunaQdcKdE+wZL205XOOObs84A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB7905.namprd11.prod.outlook.com (2603:10b6:8:ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 06:54:00 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 06:54:00 +0000
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
Subject: RE: [PATCH v6 09/15] iommupt: Add a kunit test for Generic Page Table
Thread-Topic: [PATCH v6 09/15] iommupt: Add a kunit test for Generic Page
 Table
Thread-Index: AQHcN6UzU1w4B5muYEmbwC3LDCEj27TEY8pw
Date: Thu, 16 Oct 2025 06:54:00 +0000
Message-ID: <BN9PR11MB527699F655EB866AA0EB11B48CE9A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
 <9-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <9-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB7905:EE_
x-ms-office365-filtering-correlation-id: eb815200-c25a-4e92-571c-08de0c80c91c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?wFSrj3UiLEJPhvkjS4/D7Z3fe11u/b164Sa9JKhR7HjSpdvvgMwtUX/XO8ma?=
 =?us-ascii?Q?l5txHhG2PaSiodxUDVRdkalsMQPJJMdE8UVuur8R2BcY1LFwN/RjQDzp8JzO?=
 =?us-ascii?Q?fZknBoqZpZM+1PeSDL4UnrJ6bjYJIRnqxosiJB6qJ4+V7+5Phpbe/Qz1UiJm?=
 =?us-ascii?Q?i+v/vC2SnoWNc7IcmWxwdY3jBaRIT0HGg/YpZs+krajt4nG5zr4paPk9fOK9?=
 =?us-ascii?Q?7JR0wQgMaiaUu9KKDQTQLUBGvD3TCXVlHxhhYHrVd/SnvylFkBIbnxfD+hI2?=
 =?us-ascii?Q?INN9Wogw6qMNPEY/gNymgwO+Sv+/kibcj39u2epkYDkGEYPNQzwBlV4BRX7Z?=
 =?us-ascii?Q?+j3ydz4uDfNwKq4zXX6Ue5aC1aCEhsMXk7CzjUC1FFhhdlrf7CXGcClvktf2?=
 =?us-ascii?Q?Sbq5AeSKc8MeJHZl5kAPiQMo+GoxE2N/rJcuB6M8enS/48uVhXzZ/n0vkYRx?=
 =?us-ascii?Q?Q8cVvG7RrddNfn5ZKsDaVYn2phzZ4jZrMno9rim4WbBPAftk1CTh7yLX8iC0?=
 =?us-ascii?Q?DTrbh5gPD0J+t+O4s5n5COQk2SC/rhfExS1uXxTUWjmuJlYWEpScPwutp/RV?=
 =?us-ascii?Q?Datv09RFYF5c89Nr/BO5nNlxU56s9H2HZdr5kgVdpfpTxTmPGz91xZ69vPh0?=
 =?us-ascii?Q?6NOGD56mSUc3o6PRBhnyUMnjr07EiUWBgrz9faUqXR0/cO7pCgcV2W96oYRG?=
 =?us-ascii?Q?Hg+PLvULZwAgnt7yxILPn1HDmzs3j5ZTfjtTpia1vn2KjQKTCTe3vwJ83bEI?=
 =?us-ascii?Q?qLumkgnzolzNsIcC8SQpACKEzBwx96EL0SxRH4Md8gt41/MXjcnTbUgIAO14?=
 =?us-ascii?Q?eqAw7NtHCzi4YNTR7LtzKwIud3WDFr1bMmG7UYvh69EQbsn94nxXvHlbEhJM?=
 =?us-ascii?Q?MzNsVZHbmDO0DfncL9vN6R0Z4SvXbx7+GqL4lP+gnLL7lqE2beQe8B/IxoI4?=
 =?us-ascii?Q?rXP9HD9f1kpAdpZOlSz5oiFBbnFMvGhrpL6yNnfBQHvFN+7JmFIYAXMNReZK?=
 =?us-ascii?Q?r9npyzgvA9hMVzIcSBmTe31XBC1C/o9qo4RX3RngwUef7hPWbHap7ttCn9zP?=
 =?us-ascii?Q?O8+ijreSGhgZ/gXm5GS6arw7p49t+KiRk+NXLoHxoiyQYXODKoZzsbwuW+iD?=
 =?us-ascii?Q?hcyDNJuY7HXgpbjv7C6hz/SeQghuUqT82kDl5LnsEVaJrSDRlrc0eSd9mNnF?=
 =?us-ascii?Q?7E5RXBQk4d4O6mRCZh4WavzeQ1YfFYVxHBbTf+HyHgX6iOz+PzMxxaqUXo+r?=
 =?us-ascii?Q?juC9HVbNimJQItnUs36F2Pkfvl5c6ajhciD4vtzIN2MruqQdOUrf+XIc3qdo?=
 =?us-ascii?Q?abZyxgU3GJqTKSXFfNWsC1PMJa/qoLfL4LZq/h0Fg0MttFHqL7xWQb2JLWS/?=
 =?us-ascii?Q?9XyaI9ntZeIZM8aRapz0wpA9F/2h0kYDX43O4JpVEsWbhuRBEKWwQDZ0ZC7P?=
 =?us-ascii?Q?k4IJzoMAiSJH9mkFP37FzzJchp7w1jXW+kc4+H1F8L3ZJBeBadjw+pY276Mp?=
 =?us-ascii?Q?FwQf4++7/TjY7JuCydaGOK65jxd0DyxR0MKv1apYN05MliCLfrbu3g62fA?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qv0aDlJhF6pmtIScInH/qx1+cU6dUn58qE3A38WjoWh5BK1LNhQfuNdtld+V?=
 =?us-ascii?Q?u+LN1jnLuYIVNjcsCYxRmESeu+4eQjkqOMi1l4IaTjdf1ZVtHKuYmyt/Hudt?=
 =?us-ascii?Q?b5IFonPIcVxiOUkG49ZNYb/Hl0rhw/cYMmlRqlY+7KoUlz0eW+OW+nTtw/Tj?=
 =?us-ascii?Q?ehA08KW6eSDYT9EKPJ5Wv30x0/M8y+h5Wt+CRBh4LCiN0wswM7+jx6zduTWC?=
 =?us-ascii?Q?/zOU89vVyckv3YVZzW81AuolEmeX9DJwzACrqmy6KbT33SoSbUqNraEp5kd5?=
 =?us-ascii?Q?1Q3/NUMfpDqQk159sR8+HFTQfqWqT029OU/z55l5jmxQpqjjsq8odVvnv7/N?=
 =?us-ascii?Q?kgAJwyZv1NJr2YN92Zf7TqzRBXAobNvFqmEW/dZkgr1eXirxptVvMhWZmoJK?=
 =?us-ascii?Q?R6YBC2KqRu++H0XIkcfVFmCZFwbaSlvWbCOhwpHWc2a7GOmDXmBR5ox1FitP?=
 =?us-ascii?Q?2Cpj7zqHzgu0Lzetu1av1/EG1TYMzH5bsHeTnAH6xH9MJ1hxuWpE+bebxG7h?=
 =?us-ascii?Q?ZV7rm4EmaIZQb/JosrkTUL3z9B5mI8T6BD5CKS+P8m38Ae6wLEcxXYZhAKXQ?=
 =?us-ascii?Q?BlrsFIYzoZJtMx75LsHlG/WLu2a7enrB0lroGRkJFmb8sh+IZFcBusVbui+a?=
 =?us-ascii?Q?mQjouRjblnfK5x5hsBonv2fiGVqUkwykDIXVbwQBw3I6q8ebG5L7eHnVaiMp?=
 =?us-ascii?Q?xGRuy5JuiWNpe1cll0mMdJLz6IADRhZZ0rh/3Yl1rJqEhclPhVrGtJbezkZ/?=
 =?us-ascii?Q?uPq2lYgbHgGDxgw8pNEibXyjyyiSvcTMr+RlyAqLG4AMUAczoS2HW/dfzxll?=
 =?us-ascii?Q?nnkQ6i0V50TC4HSTSfjuLSHqu/FYvS8EojFqnChkktfYhsLEHGdB4cAB1Y1N?=
 =?us-ascii?Q?5TYvkNmq3nqbavY3sPxrHyRPiCyXplyA3KuaGkUBM/krjVqQfhSMn4yNCmz9?=
 =?us-ascii?Q?i1dI529NyEyUiO04cCzdu4i0+l9aVMshTvqHF2pYI6htoz5wStU0vS+HOg6w?=
 =?us-ascii?Q?+wQ6x42Veiy6sIGvQLTMuUPd5M8r4HlRCMvAkWsOKs88/xGpmueSXamr37ia?=
 =?us-ascii?Q?jdO3O4vsRB2odBf/xajHGWv500lgsfMzmjLxFwDa2pJ1S1PHzQK4P6BoDHcj?=
 =?us-ascii?Q?G5Xu/jHLuCtl9Qj4Ad7yY5bdfS7cOs62mbMpSX5zSoQxInXc0Ry3lF41OSn3?=
 =?us-ascii?Q?atcoj60dcM7MQ3drG4VsTXU9N6a7F2NA1r4BImU2JlT7GOIt4Nr0onNUKVDb?=
 =?us-ascii?Q?U4zcrYmINXhWdPQnm4Tm9Pqy0dpKO3ndRnDIVeD8suH0A5jLDNtmp1HfffUO?=
 =?us-ascii?Q?zFPYOUu2+Lh4n4hXqiQJRaxk9z5M3uH0KGRXrQN5bpWSvAChfFDFGmbU6SrX?=
 =?us-ascii?Q?D3CbbuF5PH93YwyBKhJtvuFA7SVPanW4AU2dgbmjwLhVdYK9tLbO57+zIXaj?=
 =?us-ascii?Q?R/4T9UinRVrzXIHP/SwO+urYy7OZXVe33IcmhWsg0V3mJRXLBqM20GYWh9h6?=
 =?us-ascii?Q?A/qE7lFQjw0zbIUgD+W9PFRXJxsPCQRfpKY6BKbiQX1PraWXZA4vk7VKtQNf?=
 =?us-ascii?Q?wTou+ZsAfa90DQ2D9gwrVZ53ueQiUn5cA3Kx5c9a?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eb815200-c25a-4e92-571c-08de0c80c91c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 06:54:00.2564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IKSnXCpiTS7zKW6xF5vyzvgJkQAJnoaeAALzRiSFbCIIJ7JsIn+U7Qt6FiGF40WH/IxOKa6R4YAgluFJQ53mXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7905
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, October 8, 2025 12:12 AM
>=20
> This intends to have high coverage of the page table format functions, it
> uses the IOMMU implementation to create a tree which it then walks
> through
> and directly calls the generic page table functions to test them.
>=20
> It is a good starting point to test a new format header as it is often
> able to find typos and inconsistencies much more directly, rather than
> with an obscure failure in the iommu implementation.
>=20
> The tests can be run with commands like:
>=20
> tools/testing/kunit/kunit.py run --build_dir build_kunit_arm64 --arch arm=
64 -
> -make_options LLVM=3D-19 --
> kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
> tools/testing/kunit/kunit.py run --build_dir build_kunit_uml --
> kunitconfig ./drivers/iommu/generic_pt/.kunitconfig --kconfig_add
> CONFIG_WERROR=3Dn
> tools/testing/kunit/kunit.py run --build_dir build_kunit_x86_64 --arch x8=
6_64
> --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
> tools/testing/kunit/kunit.py run --build_dir build_kunit_i386 --arch i386=
 --
> kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
> tools/testing/kunit/kunit.py run --build_dir build_kunit_i386pae --arch i=
386 --
> kunitconfig ./drivers/iommu/generic_pt/.kunitconfig --kconfig_add
> CONFIG_X86_PAE=3Dy
>=20
> There are several interesting corner cases on the 32 bit platforms that
> need checking.
>=20
> The format can declare a list of configurations that generate different
> configurations the initialize the page table, for instance with different
> top levels or other parameters. The kunit will turn these into "params"
> which cause each test to run multiple times.
>=20
> The tests are repeated to run at every table level to check that all the
> item encoding formats work.
>=20
> The following are checked:
>  - Basic init works for each configuration
>  - The various log2 functions have the expected behavior at the limits
>  - pt_compute_best_pgsize() works
>  - pt_table_pa() reads back what pt_install_table() writes
>  - range.max_vasz_lg2 works properly
>  - pt_table_oa_lg2sz() and pt_table_item_lg2sz() use a contiguous
>    non-overlapping set of bits from the VA up to the defined max_va
>  - pt_possible_sizes() and pt_can_have_leaf() produces a sensible layout
>  - pt_item_oa(), pt_entry_oa(), and pt_entry_num_contig_lg2() read back
>    what pt_install_leaf_entry() writes
>  - pt_clear_entry() works
>  - pt_attr_from_entry() reads back what pt_iommu_set_prot() &
>    pt_install_leaf_entry() writes
>  - pt_entry_set_write_clean(), pt_entry_make_write_dirty(), and
>    pt_entry_write_is_dirty() work
>=20
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

