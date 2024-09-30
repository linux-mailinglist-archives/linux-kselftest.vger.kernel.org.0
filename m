Return-Path: <linux-kselftest+bounces-18571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26948989B46
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 09:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6F11F24007
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 07:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B8F154433;
	Mon, 30 Sep 2024 07:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jcO574HZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF8615099C
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 07:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727680822; cv=fail; b=OVN7tq9L+T3gcUrlGZ0eClIJAZFQ+e7rmCuZw7b0Gef6MHYDyDrMbzlXa3yGZBtfTIu5PaD1mbu6PapM+HTzRN4ADxWxGJHiAaZeYH5aK4eSJcqov4pewz70AfutWpIYVDlyu/YqAwDPYSK5IcFmmDtWqwMqO3uI3C38h7HDfMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727680822; c=relaxed/simple;
	bh=zNQKxjBmrePxBN96lnkd6SQP1o3YKe0YDhy6czTEF7Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SHKW6h7zuD+9cvQtg+p20kpJaPdnUQBWqKCkcWBcsDNreyEV1+hdiYcH423/BkOFnnIoduLN2I1rPU2l9FMItKStgPjxJv6aG85ZkM4hDrRsHqpCP21kdSZRNYIktAoM5D/xsYBNDFmuWa04b0wNc/N2YBADTYhfpm7yScx+S1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jcO574HZ; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727680821; x=1759216821;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zNQKxjBmrePxBN96lnkd6SQP1o3YKe0YDhy6czTEF7Y=;
  b=jcO574HZPtZLqAyfgn60i40W98hjNqAraNZ8oFXeZZZLK1J8tA4aPoAv
   FCmEK11nQnG+CrJiS5CLnKC1jybE9WaTM/aXS78U0w4EUJLDDwxrc9X8O
   iOkLUdukCBeQY2W0kf6UFXeyY45Mjvo7P80sPJoc0V8oHpvmHNdMGZumH
   +9FPalfl+NecG6TeTiVYeYPVYRS1+Fl30qti+rfXvrTX02RQ8H6Hy9dRF
   nR1mnuJnKg3ZJhTOHAAP7EfdN4o0LMtWae8UgdkZ/QFdnqD+n/gUthKxf
   BJhNgJ1QfT2yiuqJ4tMyDhrLlJx2rvL5FAaFVdeEYWhccLOtXgkbBsx4J
   g==;
X-CSE-ConnectionGUID: 8OhQdTlQS9uDsaSKB4rteg==
X-CSE-MsgGUID: nLF+hu+iQnqmkAgO9eWzDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="30549296"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="30549296"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 00:20:21 -0700
X-CSE-ConnectionGUID: AwCsYq3fTcmhNHZmKcLJMg==
X-CSE-MsgGUID: Q8LcU7CARNSL4LKrGi5rjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="73608188"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 00:20:21 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 00:20:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 00:20:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 00:20:19 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 00:20:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GzLu1ERMo4+pftmLDVmZV7MZBvZV8VtVJqyPjFY6cVASvRNh6Kyl1Ouu2LEK16MpGRIB1sZ0TnqbYz5LsCeV9PPinA+lLvvYNZ65ThzMDOuIQKrsKdH2V24TrqGS5fKO3KuO4SwVX/HYjSLr20Zestp328CKPzmoaMkzEpoJNx3l5+QxLde6bUsTsQKzBkentIoCsvQJisZq7NlP3bP7e4YYlov5IoOqLtiMgm4MHAAU6kxRBLcFvusGYpwMmxaoPL2gpOrDDyJoQdV2A2IuUJCTl50rdnrYulcabHeB3MWear0hkAXOGSBtmEewW6SpM5YPwZADKqHChWypoy0D/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNQKxjBmrePxBN96lnkd6SQP1o3YKe0YDhy6czTEF7Y=;
 b=PhJEGwgyE4IfDFkco1B4WyZSE9UY8bRO8YUIAuUYdNOJvZWy90WMzgRxxqItK89A78AxX6m5Vet6zXQla4fI7RABsQhmo8aAUNTUkALey5JT3pZym9ix5omc6v3EZBHhrSLxn1llTLaqxkZkNBTWecwrZETzJRQAipa73SGV5F8+T7H6voSLDh7WpdMMbA9fQazuk8PKWZmxgP6t0PsjP6hvqGmysQTsIzalTPcz0Y9GWU7a1bkalMUGxEopwe7AU4mzuM4JnWUeNXx2rZ4HVG1YzpwA6bKc+F0TJ3v6KKDC6aGFmxbq+T+AkQO93JwHQxZ2HnvyO7WrbROO4CCyjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL3PR11MB6529.namprd11.prod.outlook.com (2603:10b6:208:38c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 07:20:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 07:20:17 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>
Subject: RE: [PATCH v2 5/6] iommu/arm-smmu-v3: Make smmuv3 set_dev_pasid() op
 support replace
Thread-Topic: [PATCH v2 5/6] iommu/arm-smmu-v3: Make smmuv3 set_dev_pasid() op
 support replace
Thread-Index: AQHbBRRYVVF0yg3NUEiNA2WvuiVU1LJwCCig
Date: Mon, 30 Sep 2024 07:20:17 +0000
Message-ID: <BN9PR11MB5276408084D69B783EEEC6408C762@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240912130427.10119-1-yi.l.liu@intel.com>
 <20240912130427.10119-6-yi.l.liu@intel.com>
In-Reply-To: <20240912130427.10119-6-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL3PR11MB6529:EE_
x-ms-office365-filtering-correlation-id: 43f1b58f-dc79-47f1-c382-08dce12055b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?SYrJbNyyP621SOkXmEAPP4FtElmYJV7y1ceIzEf6K7z1Gtq9CLd5ZJiFSMQd?=
 =?us-ascii?Q?nTawWiB3sG+qizx/ZPOHsMAfrKkxg5DdAFUfenzm92gUH5JE1gY7wIWnWbOm?=
 =?us-ascii?Q?QD0zILuUfAtZbPK8a/3DnUaBR5DZXCpb7rEIYBj26N2k5rYvlJ8XTPNds3XY?=
 =?us-ascii?Q?jmcsDj+6M8jycAw/bwyumzjPUdnjIram3m0iLSem7ozSWYf9cTuiEhzBSe9M?=
 =?us-ascii?Q?7OH6et6Kd9WFGWftdd1rMnLLuL37Nr55JrlUqCpecYXt6OYfbYyssbHnlXI5?=
 =?us-ascii?Q?OgpQZYNpuLlRlfLLBheKAxUh0k5WVeklVz7Z6nRkCzaWlSrP1Qax4Orionjd?=
 =?us-ascii?Q?mkg52PIk4TEH3i9mXj7XEUzYAVP/NkSvYO/MHijFT8tVzOZPPLejpvs3WFbr?=
 =?us-ascii?Q?QQLox/Ti8N4fhsEu6kMR5g1CYwmBFpF7qD/mfFyclBtNcnTNOHIFWhDDqfFd?=
 =?us-ascii?Q?r54cYVKnKrlqEtdUysc72CtX5wRFauHlZ6GqkYrhCEBHrN52LaAc1Sfnh4C/?=
 =?us-ascii?Q?GinXIdCvCpI87dDUHj5kAs7KBaSwC5VniwjdM+4c1evac8FbvuSMhb8fgOFC?=
 =?us-ascii?Q?p2Z6aB3hFgLUd7OexgN/DcQxcyT3n+7T3LJp+OdSfL4S98ya2BNIuF0XtEDL?=
 =?us-ascii?Q?+fL7fT/ac9W5LhZEAuf0Q05ZeGUu1kLUtndn3arib+eMulfiE7Acl0v6TRyY?=
 =?us-ascii?Q?WXHsR5iZ3Kkux4mYfddHTVyutGClDx30BdjNJS74qzqtG3cDzuYaDn3QYkPO?=
 =?us-ascii?Q?mup1/7UlDTc2I7RqqPGTTlxSFDH+xOQ30CQcKEcnyuU9bt+HU/VGWDt0Ntzq?=
 =?us-ascii?Q?M+aC7u6Dz7OOVwMw+vlwhRuCGlIj9K+Tg4AeEjl+NeUjwkHNkatVuyuqKq8K?=
 =?us-ascii?Q?s8O44kdM+SwhA7S8ekF81Q3ku5MzEy/k7AAzeIaXqy3Hm63uW+bSaDJjhrTn?=
 =?us-ascii?Q?VXEIbCplvOGcMcaTx3j+7qn1j/vKY78xMIn/feOeeMFcDpJQFJZv/9gAaMnd?=
 =?us-ascii?Q?xxQ84NER4zrtACACcRWaCgovgxagyFqXQChan5CsZ9jyn9jQQJ2lQshDGl2X?=
 =?us-ascii?Q?Mqcwq3bZ67NywVj5r/hb0dmryEWOLY6EPpKpFE8yio7KlQIEiSosRnXDw5iJ?=
 =?us-ascii?Q?Fj7vJXmF202N8fMjfjEFmouI7HOtDfvC2Z9B14pizqGCTi1IrjC/7q6EnnP1?=
 =?us-ascii?Q?8pbUCss0Fqg8p12jHeYHYjjSYEmoejnmW565i8/PTt/OjeBSWjUjBO2ep4SB?=
 =?us-ascii?Q?ptwKABbiIaVu4Iop4qx+WyXgzIrwJk2teAFzjj7onOPoX/RiSYYA9daqxdvf?=
 =?us-ascii?Q?rG+sqSnUlyITaTQqJBn3tIy7sCZjFXF/hUro9cz85WXvGyj6UCgAzyutzO5i?=
 =?us-ascii?Q?RANWDB0MbC8lfmL6OicoqNjLHLqkJhmmZ1p6sq17mW20ITCMww=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fws4QMubNuUawITG5ZdhfnkELtPv/leKATrAav4xI2PLlH+tZ8A00wUo4sTC?=
 =?us-ascii?Q?40WOT0vRoGxb/zUftd+dzylTCe9RbabahvggWkUE929/GuUansiWZDxbpUSi?=
 =?us-ascii?Q?GWYeXwy6AhZ4Bt9jef4FPI7e4oGZfxp7ftu/oFmZGPTvvtocbz37pLxBGRMU?=
 =?us-ascii?Q?kN4YmmEQO5IuQvNXioMpk0eP7H7F2VC/HDUNh6tMphbSAKD6/I0uxRQDaNNe?=
 =?us-ascii?Q?f1P6QKfbFOynt2OB5Il162qxKuLhgBkZA0ZTFsrVJ9ucnkZAN/1ienFjol/B?=
 =?us-ascii?Q?buoWAqsOk9J7OVGE7cfLjIKdhiZA9iCL5QslUcyexhJc+M/IiedmgKoAG85+?=
 =?us-ascii?Q?0NK3ah1UtxXM63bo7UF9vrwLrLPhPtjGWfGqdm5AFGxMcrmTm9J8I4KeJI0N?=
 =?us-ascii?Q?Jvw8v8OT5A1Reoo4z+NR67bruEKkEU2WDsH8pb8M7w+q9XFC0F/cer8Il8zt?=
 =?us-ascii?Q?MkcLMWfsGV9nxhgerYW0HKkBsyd6qDKJ0vKfmJZDNKEY4r93QjRJ0JWkAIG/?=
 =?us-ascii?Q?vQhJrE7lCvJ7CfUHVxRW+Rd+AFXLbwVV84negwCGRWTKoHbd5Gcgvarqvq7J?=
 =?us-ascii?Q?aUaQJPAo4lRz8ZMpD2HlVvRVZ0OrCWz71GIFiZMe0AYgw4cUQfiJaNSx18QU?=
 =?us-ascii?Q?LUfjfojbBZCYLrRb0poi6I6aV0uPr/bEJZOHBo4ym7dbrEa/BO7FhIjrcGL4?=
 =?us-ascii?Q?jSRJfkvnGaPW6ZVMr5SWS03I3wFy4jUFepRMJ01ikhCc4ZZW9J/DJohdqp4k?=
 =?us-ascii?Q?Jx2OcTifHK6uJlBcWpczRAv1C1AIIHpTrqWOHWb+bmKhXlJ5+KZXFwSL7IYo?=
 =?us-ascii?Q?AaT0XrvTZmMVcSvTBqcjv4DvplpVFGdpoNS/5+6CNXaYF3nGihmNG5L3TV0B?=
 =?us-ascii?Q?sb6stBFfL2lo3i+rdz/FoAJ8ypqbNjc34NEoUHWJSAkShM1TD0xPrGXd1RU/?=
 =?us-ascii?Q?vwHRgt389iEQbRRwV+fFIMrpj3sQeLfOSEaxFOOyRzUdTfKId0N1cNvZ4GHt?=
 =?us-ascii?Q?Z8ul1mI9UTOtwXqNVIHvc9zn37aL51I9UTNwRt1JhPfvwPSWXHBeF8vYWWmL?=
 =?us-ascii?Q?ZefAOJ6NhcwHm+SY82sbXMyY2kmjBRAVJcSl3020hosIUP4JdAdZgcTPD8O0?=
 =?us-ascii?Q?JbZaYuRtEnZ5bTcqOfeD6RzzQ4CvwxU95QOTVRIijtQ9XQzMTUcyvS2K8vpO?=
 =?us-ascii?Q?2QHH4iO2wGUukbqGyH4iJqjAPHWV46XAnA0oFrCc4leH5FjqamExwA2xcVna?=
 =?us-ascii?Q?1H8s5McxikzdpurvIHWcKHkoHk7xY3Y6VK01V2xw1/GQXU7kiceMf/l/85eW?=
 =?us-ascii?Q?qhC0GhcHr/P8n75UI5NLdzWmNSTiJOrIyIsCgeDM/2DxKHuY/NgME1iuBK0j?=
 =?us-ascii?Q?Gq9TP8OwKPlS0kNF3kSddCF+X5OVHDK0SzVvyMSMsaPIj3awZceVYLlc+yHv?=
 =?us-ascii?Q?NhkGSQuL9NGjIH4PAFBAtVgo5iJnWVyTCAydNkpkvg80X7p280o8+QDmj9qd?=
 =?us-ascii?Q?Ln0yUeADxJOn23QhLkXMi9mAJyxc3rSzfC/W2kH6n22eX1s+2LAsTdHifO0c?=
 =?us-ascii?Q?Q6KI8f2RhgmsLqZGsjnhNinm/i7OrKGEIJwDpC7l?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f1b58f-dc79-47f1-c382-08dce12055b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 07:20:17.2786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YGtHOhKip/ek7ZYtO34rJn29Vh//o3S5ERlr4UCr1rOC2qxhYHG0zIXc5ZYtvJat5QwJABfKXNQyPkfkk60ixA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6529
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, September 12, 2024 9:04 PM
>=20
> From: Jason Gunthorpe <jgg@nvidia.com>
>=20
> set_dev_pasid() op is going to be enhanced to support domain replacement
> of a pasid. This prepares for this op definition.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

