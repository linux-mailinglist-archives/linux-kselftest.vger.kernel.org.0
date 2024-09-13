Return-Path: <linux-kselftest+bounces-17915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979899776EB
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 04:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC8B91C23B0E
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 02:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCA51AD24D;
	Fri, 13 Sep 2024 02:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m0Gyf7HA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06E01885A8;
	Fri, 13 Sep 2024 02:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726194846; cv=fail; b=TzV2XhYkXr8FpU4MI1Eark9m45McSV7wd4ikhsPffLf7u0ce6FeGPQOSFDh+A7sPKrPrPEsE69iRSlUFEQeeVO8EO9i0d6YtN3MlHgKrpfJVJSNE488yAKZu9tuoBZrKpOEP43BKNnuUtHyPTn1RpWq7WgfBFPwpmMWY74rJYIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726194846; c=relaxed/simple;
	bh=P130I2TKbpnqbfWuw+FktbbsayA/X5ZuhcMP75T3d/A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U3Djh5WfLdYut5hNxw2FJpp22CCXFR+LXv5kn5wdsuA4HiyVhMWqTMKz6iF4wh1H75qZfnKNr6FMpGiR6onsGOZ1Hn8K7FdwcFX8jAEny+7pvVFRSRPG1rDVzEAF+cFmfzRfX1v9eCsDhRo673u6D3C+bVZVaNrQ1aZZ+Xl8iM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m0Gyf7HA; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726194845; x=1757730845;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P130I2TKbpnqbfWuw+FktbbsayA/X5ZuhcMP75T3d/A=;
  b=m0Gyf7HA5PSjPtFig09au8ReNR2oamWKifoIgf5S6vYyJPIL/hMw8R+1
   LULXUCjZ1ox7IqFD/9n4LzayD/JMJlVoHTe9dQgQJ+glfr7UnO5l1U8XZ
   BvIMxfCZKAJF6unS9qLXoieH4l7yDMhXI3tam1+iYsss02im6BV+03Ty0
   CU6y89b0KQTg8Bo8F4plMFZ/cHY30vbFG+W9gwHqS0NjLwBFUyawmXWBk
   k0xGhOq4MamV2mEeE0v9CM5IM6FQ3VOmsBO8CzhhRTgOZXP4OnisvMvkL
   +rzaMYsIQT9Om5A4Xq7CLoiHFkPjaTGX+uhoqvSY8R4kwbAPheXALwbZw
   g==;
X-CSE-ConnectionGUID: YBIKfwbCR0O0ozbtiGeOew==
X-CSE-MsgGUID: fBAw832wRCubEPMja06CrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="27997949"
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="27997949"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 19:34:03 -0700
X-CSE-ConnectionGUID: w/DNC1lUQnu8TCfQ/zdtxQ==
X-CSE-MsgGUID: XHQzHmt3S1ivEZiQp/GR/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="68212130"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2024 19:34:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 19:34:02 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 12 Sep 2024 19:34:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 19:34:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vje4Cwf96pXZnhLOHUaE1KIgJsecuKsdMeUsNd5H3FQ3glwdb/tFVqiZrVGnE/jsKKlTRxD8suOnJGoO7dLfr+g+bSybG9xS5zOi6kcZkPmI1W/0B/w8u4IKg+ytf9Vg0Sit1bm5KwcCt32MtKfFnExk/X4bu+ee0BXw3pJGOVVorpu0tomhzUDKuWSmXcDUeAZ493Z82ckoBc6Zk3yhGUNGdVXAO6JBAtOfr1rPqCMrXoDHyNXXxb2gzKN1wrgnzIr2XmpXFye8KZItswjXCq+h1FtC0Rbiggj5r17ySHvahQSZN66Kti1UDCKlSxR+y56iep0FX0lpv7NNmGBCgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P130I2TKbpnqbfWuw+FktbbsayA/X5ZuhcMP75T3d/A=;
 b=lJA+erdxEHJ1Jzyy0S3ca4hRXllnXVOKBs3DIEmVy6gIytUZGlvl63S1WN9CffMvogjHnVQTyIAayJNGbz3V6mwWEinWIZICsRQoEh9ZQlRw4AEN82Ghs82QniFxc2C/FLCh70fZBeAuLbS2QT67J9lzel8upD7dshzcCuYAhSGCno4h47wR5EFcH30DmanNJL6AItbwaQt5wMFd8tQ9gf9t30zTsaBtnCFT149Agoqk1m9vYAelTTqzbELdNpH4WLfh2ns+XyefJN3VxBh7gtt9+9jdtmpncWJXETlczWbx4Msid6DZfPbkkjGxUaOIJw/7zCdKmldSLXA2il5I8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW3PR11MB4650.namprd11.prod.outlook.com (2603:10b6:303:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 02:33:59 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7962.016; Fri, 13 Sep 2024
 02:33:59 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
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
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 17/19] iommu/arm-smmu-v3: Add
 arm_smmu_viommu_cache_invalidate
Thread-Topic: [PATCH v2 17/19] iommu/arm-smmu-v3: Add
 arm_smmu_viommu_cache_invalidate
Thread-Index: AQHa+KLw6F1nSDclIE+ushKsvSKoLbJJbdGAgAAb/YCAAAXcAIAIpC/QgAARFYCAAA2CoIAA+xCAgAHLZBA=
Date: Fri, 13 Sep 2024 02:33:59 +0000
Message-ID: <BN9PR11MB5276D3685466B590F36318AA8C652@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <4b61aba3bc6c1cce628d9db44d5b18ea567a8be1.1724776335.git.nicolinc@nvidia.com>
 <20240905162039.GT1358970@nvidia.com> <Ztnx0c4BpGt6umrM@nvidia.com>
 <20240905182148.GA1358970@nvidia.com>
 <BL1PR11MB52712F4AAF7D1388A080A49E8C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZuFEx7mp3v0/lY/g@nvidia.com>
 <BN9PR11MB5276EBE0F714CF3EF0DAEDEC8C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240911230735.GQ58321@nvidia.com>
In-Reply-To: <20240911230735.GQ58321@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW3PR11MB4650:EE_
x-ms-office365-filtering-correlation-id: b8c8bedf-6196-4882-362d-08dcd39c8617
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?7E3YLCeonjqTdRhSApLls2qjyHK7XHinmc4L1d92x7tMIUcyFmwV/gaLSwt/?=
 =?us-ascii?Q?NIvFA0tWapNfkLeq4ux7CcOQFREVNiKPyWXFP/MZ5on11L3AMeibpwVj71A9?=
 =?us-ascii?Q?HLpS30dB2k02LyXy9VAsF19WxpO1vHQfMb5HSEW2CXSmPgB7ybqe0lxcygL5?=
 =?us-ascii?Q?sOSrLu3XQGydzv1HPyVkqsTSsFi3ArOhMf4filGZbHjv06SZ2DASVqmXGdqh?=
 =?us-ascii?Q?b2892iLSNg8+KsIQu4ZWzgqK1mV/bg9oeG1y8lnhIBPVUfxVNVUueNLSaGr9?=
 =?us-ascii?Q?b5RKqV0/NsJNVIpJvQa6oDHuoWBh5Ld6yhtSIsvZRe8BhCojyScdSw2hJItB?=
 =?us-ascii?Q?CPgb9TCplxmYXPkbyHRsKMklUKF2cO6uLl/QvXU2MRVhLCwUHO6vAlfN+Q24?=
 =?us-ascii?Q?wGCkcuRWBSxQbVFvM1PdRgVYMBdbVMrG1i8zShh/rsQZanT+PSf/2lFnUyZk?=
 =?us-ascii?Q?0a5CAqYw1WyBSkpwuieJxNlxNGHhyzFN0UdYK09vWHs9iM4eVIIITwr/N260?=
 =?us-ascii?Q?OJ4amrwgBGnYyOkAyoMF/jTnmOr8Fk2NZymuHXA2cx3nGuj/6/95Q57AQafC?=
 =?us-ascii?Q?a/Lzm3Y6CZTSF28kEmsRRV4dLVI4hJTp7nTI5xFTihlEQLW/C38ICPrKMcvg?=
 =?us-ascii?Q?bjZAEvPoT+jyvkvzuYS3tC5O9EPbx17X581AgIA0JawndCqNCtPSPm0hG0vo?=
 =?us-ascii?Q?rcNnVXf7JdXzUYunjaRKDnn6gy9pGjNs5dmMTpD9ORSg9Smr2jwW0fOVcUxG?=
 =?us-ascii?Q?vkaDWoJZBFRV9VFOmlHdCarkvXCsSpJ+yqLGkFjYLIh2JNdbJYx+rvlXsnoM?=
 =?us-ascii?Q?HwsK/CldJuXWL1GqVT/cIjElTo8sF21UrDQfVPPBLie50qdaAsmtfEez2cNB?=
 =?us-ascii?Q?RSKykPfQsLbYSYaPNsDLa6e2WiPMaCG6fwVE/iRbjrWzQBFQt4M0vflvVSJS?=
 =?us-ascii?Q?Vay7iJJJ4POxCWbKAT4kLOIw8OufRlCACV8XJ4QgmRIOjHiIm662brf5YlbK?=
 =?us-ascii?Q?l6DW9lRnKLlV7qaKD3ZuEdzZo3xjhwYn9wemmZCDgS2AOcReyJxc7N6P+Vjo?=
 =?us-ascii?Q?ai9jPj2ywOFv/kO1CCcB8knaY9v/g+wMCHtwIILwYJpAl+RSvsrz+ndTYgqr?=
 =?us-ascii?Q?rhbHm2gj0s2+BKEodHUb3zRwOjoTnBytW7Fgje5GVZN8OwYoljhK3fvFrO4z?=
 =?us-ascii?Q?nJFIJI9LNhX9YcDG3CCjtl3sYTgvcpL2koVz6OVsD3GwX9ZsyUgCGQy6fb/r?=
 =?us-ascii?Q?cSet7bKOow3Tl+7YI1KaKJxlDn3+T4uf/oThIpjMpvP3+lwLHFKfupKPK6Ew?=
 =?us-ascii?Q?MdW1194jXvi5upbieJ3WFCVxwHX3Hjwqp3anyK60uqr2qCUaIac7xKy8zqfk?=
 =?us-ascii?Q?DfOjtqG/VorSVQXZbIB9k3nbwRMaB1PUgX7RRD2H+Xv6WoI4tg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ekvR/ZqFPhmGmjyWHqtUe09NodiVAl2HrSXtMX68siq1K5m2RAHmOTq4tfWk?=
 =?us-ascii?Q?TvG99zwN0BEuJ9+0oYT9hDXMAW3OQN2pz7YWvrC85aFVzWkhuOQFxrWpPDzA?=
 =?us-ascii?Q?6dFOP+YppdMDDKVlfzrQfJxwfDSHOSKDdifJ3eTtZ4rPTfXloJT0VSe2avqx?=
 =?us-ascii?Q?C7YmKcoE+WS/46fj+A3G6N9kx0bw0MgPjavbUdc84+Ug64E2a8q2a+ChLroP?=
 =?us-ascii?Q?maU8iS557YCj89JlaARDQc9n/I97hXEZWxLqMKhsP9pJhdhLGFEjNRzy+upZ?=
 =?us-ascii?Q?UJeCRj/dgBdZtn6S6Cy3F8ZnMXCki2WDYTA4Wf0AqzZ0MLtlpS8Auo0hHcI8?=
 =?us-ascii?Q?nRpNiN5L12uZtzy+dfj76W3YNRI8SfhuFB60cGZHSyvseGc9QRm2TKDwPl65?=
 =?us-ascii?Q?1GOEZJ063o+772qWcrgJcEnJ7hWQQQ9Wf3XCcAhS5qnQT2FqOEZly93FH3+Q?=
 =?us-ascii?Q?L5CcNW61g3t93TO/k++j/6M8EnWgxPpFb0rAU7WBf3/izMp3wyr5YCRnLAFH?=
 =?us-ascii?Q?GXYQpzpq11mHD7nqXlwv5BNj0RPUi7rxpljgy+LGIsNo7YoKYhHatIt/gpZZ?=
 =?us-ascii?Q?Ji8jQ7Zwg1lsXI7KrMW5YzKAOnMNZ8oP0HN29AcWM1Ig+L6xD7Lg9ZM/U2XR?=
 =?us-ascii?Q?Zu+BnXhzV/JvisczEkmdT/ktkgO9xKJnHsaxORf9+ujOQsCDhd8RUuepcPdl?=
 =?us-ascii?Q?XY9CG+JhFybkVhHGBIgD3O+EfDKWtCCK+yPBE1mKdfrGqmOX71AtchdsxjkE?=
 =?us-ascii?Q?44z6p5Ehw73K7Hltj6NNeExihUoeNoCxNT6gGF3QR13BDNSZO7+/plQkQJQf?=
 =?us-ascii?Q?fF+r04ANpaGrr7x3aooYEvmoEHNFms8VBJg+L6x0im6GImAAHSpV2VVLI74H?=
 =?us-ascii?Q?kDQm1jcL3WgLQfRxBhtZZgcDJHDqIX0now1NiwwTNyTeiBICUswgtUwk9YD7?=
 =?us-ascii?Q?7PTNYWXZs7Mxoy6CMCiSb4F1vyvMjyyVoIMpzYnfP0oISLNKoW5N6eBVs+tt?=
 =?us-ascii?Q?mVoDEYdejkoYEkXWAjXiAZVyGTbEZp90unH9mrBXUp7zKGGx9mskLV9lTM8V?=
 =?us-ascii?Q?NLmeDkwfOlE5hICRmD5Pq9PVMYoaQ3m4VF64w4xlkxHWqSvytrl6++Z7VUUU?=
 =?us-ascii?Q?1AkE9BFSs9XLH1tPiNWa48dak7UmjCa92CiWOFv4s2OOKJ0gAFX9hO7IVj99?=
 =?us-ascii?Q?CDFEgCuL5kRMumDSWIfHfnXZWZpEo5KGwp4qzp9cjXVX9gpY9n52Z1QLLZhY?=
 =?us-ascii?Q?eXLjduLDExbheUEfqEo/rCfdhE3aJo2qYqX6RDvBF5F4Yhhy427o0/H6GXK1?=
 =?us-ascii?Q?q82jlyr6snmv7Qf6LXsPa0OLfUIIry0yzS+SncsKuoZzBDRu6TEFxqYg9Mpr?=
 =?us-ascii?Q?sgf6NNokGomRSB4ce7RL8/Hcshcov3pwKXmN2frbkd/9UX6swlIaah1g1OjR?=
 =?us-ascii?Q?fb/MfAVTZPkBktrfuz+MH0iznvC0D9cfrKNpft5dkwaGN/apLCrE/g/Eb3UM?=
 =?us-ascii?Q?XKjYTBn2Dzf0gm36XLV03VdJN86C/Dkgb+twjdu4GwsRavMOuKq5h1EnOObx?=
 =?us-ascii?Q?wQAML6EM5irTSBMuJF6qZaRpE3uMAwnfexWbP5w6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c8bedf-6196-4882-362d-08dcd39c8617
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 02:33:59.7589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w+S2OEJTHcE4CYcV19QfB6NYX96hDZaogblWjjgVG7SV0El3VF4ZS2WSqLc/esxW9sQHwXpMKbJo5mTiSF1atg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4650
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, September 12, 2024 7:08 AM
>=20
> On Wed, Sep 11, 2024 at 08:13:01AM +0000, Tian, Kevin wrote:
>=20
> > Probably there is a good reason e.g. for simplification or better
> > aligned with hw accel stuff. But it's not explained clearly so far.
>=20
> Probably the most concrete thing is if you have a direct assignment
> invalidation queue (ie DMA'd directly by HW) then it only applies to a
> single pIOMMU and invalidation commands placed there are unavoidably
> limited in scope.
>=20
> This creates a representation problem, if we have a vIOMMU that spans
> many pIOMMUs but invalidations do some subset how to do we model
> that. Just saying the vIOMMU is linked to the pIOMMU solves this
> nicely.
>=20

yes that is a good reason.

btw do we expect the VMM to try-and-fail when deciding whether a
new vIOMMU object is required when creating a new vdev?

