Return-Path: <linux-kselftest+bounces-18099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F25497B90F
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 10:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4FFB28487A
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 08:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04B718A947;
	Wed, 18 Sep 2024 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W++W48Ov"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6664A18A939;
	Wed, 18 Sep 2024 08:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726647064; cv=fail; b=jAu2hjtAh4zIJ1h+WaD62pzhXZEaNC//H6O8+ePVn78ozkjdfwQBiny6LKLXhBWToTARidx5Jv3OWE2Tsgmak5UeLPolN4IUzfjWT8lUAkqltTcCL+yMNxEb6Ei7c7IECNNlLPZDJ9abzM8uVFxWFycG2MRvYfcen2xcCBDme0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726647064; c=relaxed/simple;
	bh=ApaW7zSNucDxr06pqfBtwYVyCqPyiwgH/cfRYvC6d+A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DfXTHGjsZ1Edu89E5EjGCRilS6VlfVCIe2Lq++5fYkPZ6MiqZGsuXeennZg0KnbiSoCiIxKOMbW2WvJyWp2+dETUdRj7Vr0m6wwf/gmQ09MK5TSlG5NxvS9GNGx843XE0gnr+0WkAbAueGnG6E1maymAemrCM/9p4amzt7fJvhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W++W48Ov; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726647063; x=1758183063;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ApaW7zSNucDxr06pqfBtwYVyCqPyiwgH/cfRYvC6d+A=;
  b=W++W48OvDOXGUkugGra2YF/AyC5ewAzsexkQVCVzjSfwkVG/GhcGm4j7
   vuuwhBKjptRN7Y13cnmjlJgG8R/Wy5dHzXvTrYAYngRlCsuNmUIztDvXj
   zPQOm9QreuXG40gx/onABwplJMDZF+RuIl/ToS8piFQN5AqQZxssfk2Rf
   52K7UMcch25468IJRX4jIbcA4dC/XzAeAtPpiLb4BNG83urqGLQYXvPL1
   0cCFpU5thSS5EnjGcn6tP2yArNLHobgYO8sYIEaw10NbCJNevJceTzXyK
   ckbgQxiqhvNaxBey6XYSBTHds9+FA+hQimPsz38lbOCD6J3NbTKipf1ah
   w==;
X-CSE-ConnectionGUID: V6N4JPTzQM60YxsSNUhcOQ==
X-CSE-MsgGUID: qpSJMI6SQAuD22PHJ5rbMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="36114502"
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="36114502"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 01:11:02 -0700
X-CSE-ConnectionGUID: hFGzvXxURx6TExiinTIHvg==
X-CSE-MsgGUID: bKfKIbJ6TJirwshG7ioQNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="74459093"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2024 01:11:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 18 Sep 2024 01:11:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 18 Sep 2024 01:11:00 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 18 Sep 2024 01:11:00 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 18 Sep 2024 01:11:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfMU9uHvtWWCOmpcOl9w64KWm2ts3CDM9hFaJucfIRLUsMZcBYTX+t6OsO+OLP/8erPhkAo2zUc1wlCvPmpN79HkEyAjHWKFoAXMWcAumR9t27MuMx5GN0YhETWRFg1kX+YxdWzRW5LtQrrtrTej9xepxVf7o91HiJKvnoKTqBssePHK+8GJgRV0Bm13B0LZ5Gd0L1tnhANpdAPvLXEQPVgTf8hyl0+nQadAqV7HbjMJAPfgfaZUogKARk1RLC1laNEcBcUDaYJYipTYqNS3xctSsivghAKHjVGj4q1HKye9MhpmaERE3sT/zB73sM3TmQoEo0/2TwnXoKyvURNKcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApaW7zSNucDxr06pqfBtwYVyCqPyiwgH/cfRYvC6d+A=;
 b=OW16fGyAhbHWm8/oWvTUHRMbhS9MWcpvXM4oTyYWVBAlnDyMIUzsh+8S90FPGoB6+PFvnBciMDgZwqKuuXBHvKmjHwb0ZhFfXiBb0k8vbh67Z5QVZPvdrCsRGR3pxWVlexI3xq7UKOLYaOB72vZBYAN53i4GMQJSLiP4ctpfAIOo2VAsuA94uHlRpr7kiDYjv5Lo50Z3KC7jBU3W+QtPy1tAchJtJZ6UTGRCwtldCeiLn343Y0CJ0WtLFqj07SXZ+QpkiuTKn2G2ZtINIEB1P07upnW7xVadQlnpDtPSdyJJizHoIV44TfP4gL+qCvhfSnNaCpjcOuMbmF0pYZc7PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ1PR11MB6252.namprd11.prod.outlook.com (2603:10b6:a03:457::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Wed, 18 Sep
 2024 08:10:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7962.025; Wed, 18 Sep 2024
 08:10:52 +0000
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
Thread-Index: AQHa+KLw6F1nSDclIE+ushKsvSKoLbJJbdGAgAAb/YCAAAXcAIAIpC/QgAARFYCAAA2CoIAA+xCAgAHLZBCAAmDZgIAF2EoA
Date: Wed, 18 Sep 2024 08:10:52 +0000
Message-ID: <BN9PR11MB527651ACAEBA0FFDE16267CB8C622@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <4b61aba3bc6c1cce628d9db44d5b18ea567a8be1.1724776335.git.nicolinc@nvidia.com>
 <20240905162039.GT1358970@nvidia.com> <Ztnx0c4BpGt6umrM@nvidia.com>
 <20240905182148.GA1358970@nvidia.com>
 <BL1PR11MB52712F4AAF7D1388A080A49E8C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZuFEx7mp3v0/lY/g@nvidia.com>
 <BN9PR11MB5276EBE0F714CF3EF0DAEDEC8C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240911230735.GQ58321@nvidia.com>
 <BN9PR11MB5276D3685466B590F36318AA8C652@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240914145057.GV58321@nvidia.com>
In-Reply-To: <20240914145057.GV58321@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ1PR11MB6252:EE_
x-ms-office365-filtering-correlation-id: 02c4cc3a-75f1-4f8d-20f3-08dcd7b96a1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?B6p/8OfIQ0MuqInGo7D+cIJd1E+r/F3fwQPbczq016uqXzQFNCy+5JFZM84I?=
 =?us-ascii?Q?S056cYmTIeG9PLX3sRl2e4xg4MiqCsH5o4PPpjB33UWxBcL65ioXJD4SvnJW?=
 =?us-ascii?Q?4daArBC4b6uaGKF32/J8yOOV0tlc9d3V0EB16qXVoDcpwtaGYiaBTr7ilebB?=
 =?us-ascii?Q?AHcH8ihczz2WqPzoQDofZ/E2VT3IhiLwZ6TvEqNom+sU6wTnYbtW8oFHo7a0?=
 =?us-ascii?Q?V1sG5ngWszQv7mQp0dHynhEqXsmv8ODKyGysAbwQ9fhZIdMFCLYU/seEXKf/?=
 =?us-ascii?Q?5gdIIdQ3WGrFxeRY0zNoU0Cl6RL8Yy2VE7VVto5Lsu7KeKSfwuHl99qjQ8RN?=
 =?us-ascii?Q?sAu4GGwEqKQPMnYmeVmRSID4ESKqRbwkUeVVTvfkOwV/IVMG9cc4MieLtnhC?=
 =?us-ascii?Q?GGHvlyl3kL9ffYM2jkGdDsLBAsvYTClsnTW8gfp16gpl1Yav/EtNL5wJnjUR?=
 =?us-ascii?Q?nEtJXHXWMnbE1FmDOmd8nTqP4TcbhgOyCrrlDZM9/ekabOH2lODNTcN9Rq8f?=
 =?us-ascii?Q?T1ISbXmj1WsUMwsGHd4+tz1T3Uf22F3F8e+o/51PLj3c0ne09N8nbrjh6Bvl?=
 =?us-ascii?Q?/CTHgsrGr7ex131XHjRX7RpS/HC+FaWE/AHoGZsiw1MMN+7DXYDR9y69khY5?=
 =?us-ascii?Q?yYMMsEoA/9ODGg8boPvmMdXbSuAAQ3pq4dxhLthpQHA/Tg4lxV0UgqBGZvP7?=
 =?us-ascii?Q?bqG/alblzqFHwdTlX24R7R4TDlvJPgDX2Jk6qjNLHKWTEHhWQedmQ7/EGvmY?=
 =?us-ascii?Q?lPMrGQmxoPVEjhPX57VeaGHiUZyiO/1qarOilOIAApaDgRhIYmkJKvEsXLK2?=
 =?us-ascii?Q?PJkiFwsHfEo7zaFKEbXaoxC/BNnAUVuzjUMvyVGSZjOEJzlpKEsS4OMnbDSQ?=
 =?us-ascii?Q?kUxGx6WedkstJDNn7OvooRGx2s2gyLx1RjSbKJayZWEug6c9G8mOeJC4Sl6S?=
 =?us-ascii?Q?n9MMBq9zx4nV72+2+KTxnf8l6umuT5YXKFvziTfbso6n9cdyR6WixMYu6Med?=
 =?us-ascii?Q?TLNVfB0AhxBqqGDni06txujg67OTq7Aa5DHb9Dk8sQwL6a2hU7RKkNrGFZX7?=
 =?us-ascii?Q?iJfdRGVj49lxCqo9lkfBJu3KQxcTKOoLblpJo8NkDXjrfheWYOTJY1dkc2CT?=
 =?us-ascii?Q?2F/B9bBhS9EWZS0L1ulMDGrCVtxS/ODfBkWqrTq9XyLkt/LtrI2FhXJs0AcU?=
 =?us-ascii?Q?EkweGH8oC2AeWwXaXNZ9mCkDJ6mqcWNBcVooPB8GiUTtaGtaNYYDipLcd43n?=
 =?us-ascii?Q?yvihrJ6btTZ8eHxLMvED1NbCrWnJpLED6QN81mYdozCBiwjS4qfm8RrSlZVg?=
 =?us-ascii?Q?w6f1jw/HQ7/1Tp5sNW1bLJ/8Lmyz1uHw2WpY8guniM61AVoN6juh8hx2Bn4Y?=
 =?us-ascii?Q?HdNeVFnIebGKPdmh+JO0ZF7KS9vJS35HEf6QqZSGNXaJeHt8Fw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hiiS12tzBkr8uaRqs3z42VvJ+bQ9kLBgqfJzCLktyFDy1MTuPVBjSn7mSxzq?=
 =?us-ascii?Q?l/a1iwLFP8xjUvwhfIE9DeheoEFfOj3Dwz2F27y6con56EmZqhYe+xQk5IJX?=
 =?us-ascii?Q?sMrWtbTBlr6pbfnZohM3e0NfSWRrG4jStout1atvH56DyavoqN0bdjhpC7Eo?=
 =?us-ascii?Q?P0nfmBZJg1Qy/rmHzlMeZE77Naur74mwRLYDbwSsCgAS3j5895p+K0e5fQpk?=
 =?us-ascii?Q?DeiWKWMrh70vifFVMFmZvJVjlmz4UpNlmWU4QyhVNuHemfsNVO0jPRNkJPM2?=
 =?us-ascii?Q?LTJ7JIiVOHeRq1GqtzIkTAVddJTp0Erhs6pyZMvIeqEE6q2eNj+4diCnqIOY?=
 =?us-ascii?Q?Q1WgEhPlEEvBSOln3S9LYJYny8HsAtHRhDZmTt4ceuFMQLkWI5NV8Vgd/hfG?=
 =?us-ascii?Q?P01CersB+WHAQKJQVYHVIMUKVZyIwDUaKAMyNv9pa6z5lrH7+r5wmrgkmMIi?=
 =?us-ascii?Q?ZANsRc0wSB3SvWAf2OgaKlF3LZewfhnq+qaacrWvABNExGFVOLq86Zjv9Bcp?=
 =?us-ascii?Q?pF+bl63yzMD9NY8UuSGaMPUOYx9nNNZUdB97wVqY8YwmdxMbOuJ+dyoLOTwI?=
 =?us-ascii?Q?Q/4OKn1k9SJiHDEQvKlAm5S4MrtZRa3QPUnQXtOZuR6dUfC0qIn/y7TjZQbS?=
 =?us-ascii?Q?J6cPReM3vfvL+p9WtNUh/U0uLYlR6tRj12xF3DPu5td8ABOZMVzxP8SXVfdV?=
 =?us-ascii?Q?6bi031IGoqkeu1qdIVXGpZaanR1Jiv6ol879SQ4udZGE+0+iIH4g1ylyxtEk?=
 =?us-ascii?Q?jo3fdM1scbwcGYRX9KNc7MlQSdqL3yHvJbQ0e6hQyhb26R2YKpXz4M8TbTz+?=
 =?us-ascii?Q?VL3ryvYYuZsXAmQ3AXjvAiD6yC3DtqzbtPBaH5F6Z2VWMsT/ce01clWeqbuv?=
 =?us-ascii?Q?rgXEAjdoIHu23GKJD6fdheRqTX4rRpnkHrVl9gD9LVtnkYXivAODh2b8cBWL?=
 =?us-ascii?Q?gO6wDsVN6Bfp0U4j/iTGCbfDNZWvU7gR1uf6PgKdKShitEHou+nJr4tUDslm?=
 =?us-ascii?Q?KyYIgwWUEdUBOjmbcDWEHJjqul8//q8nGPPzgB9PoFJX0pL2plkW5E17TBm1?=
 =?us-ascii?Q?kXXAuJU35wWm7yC5UAr6CEpVvkIVDhOJ+yB6mwedpL85zpTrOxxVAuF85+Dr?=
 =?us-ascii?Q?7DPDLZJiJg8OIkQYeRiPhz/NcQ7LMEkwJiK8l7vMwVUZA23nDbPqKfvbxP5U?=
 =?us-ascii?Q?Nb1MYGuCdVSOz8qBxDBF9PSm9IPOcBuBbHZ6GHRWYKpA5n2iW1+mNz7zUTqx?=
 =?us-ascii?Q?csjpAhlHForCLCA7CiMOSpALPzw2uZom5kawramzztS9u/luBtVe6wZRVaTK?=
 =?us-ascii?Q?3hxWWgWYP3OH6bDBG+W95yU4eGa07vUl/zgEpdw+lOlui8WkRafZAYR6SpER?=
 =?us-ascii?Q?yeW3i6xBE/2ZW/9WQOLurhfLe20qgYH93hZMQ6iEkXEq1M+mb+6t7lG7GbXV?=
 =?us-ascii?Q?i1nT8fICZqLbjozYMqSKThc51C0a2R/Xj5UMOTEla9R95SqoVoumjq1D7HxE?=
 =?us-ascii?Q?L89T+eBMwuJBlSgH5UnOnkfzfDYH7dxLZDpez2/M3Za0qamfH7Uyr1n3zgUj?=
 =?us-ascii?Q?5F/ljuqBzLOwlesJcv43er5kdJSYnZfyXldY8sxw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c4cc3a-75f1-4f8d-20f3-08dcd7b96a1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2024 08:10:52.8874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jmljx7aEb8tRcAPPA+8YRzAlNeEAHho2p98ztlYxYg2vXfYj4d7REeLNTWMW15gtsG90f8EEjRscFGUPxTFmUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6252
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, September 14, 2024 10:51 PM
>=20
> On Fri, Sep 13, 2024 at 02:33:59AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Thursday, September 12, 2024 7:08 AM
> > >
> > > On Wed, Sep 11, 2024 at 08:13:01AM +0000, Tian, Kevin wrote:
> > >
> > > > Probably there is a good reason e.g. for simplification or better
> > > > aligned with hw accel stuff. But it's not explained clearly so far.
> > >
> > > Probably the most concrete thing is if you have a direct assignment
> > > invalidation queue (ie DMA'd directly by HW) then it only applies to =
a
> > > single pIOMMU and invalidation commands placed there are unavoidably
> > > limited in scope.
> > >
> > > This creates a representation problem, if we have a vIOMMU that spans
> > > many pIOMMUs but invalidations do some subset how to do we model
> > > that. Just saying the vIOMMU is linked to the pIOMMU solves this
> > > nicely.
> > >
> >
> > yes that is a good reason.
> >
> > btw do we expect the VMM to try-and-fail when deciding whether a
> > new vIOMMU object is required when creating a new vdev?
>=20
> I think there was some suggestion the getinfo could return this, but
> also I think qemu needs to have a command line that matches physical
> so maybe it needs some sysfs?
>=20

My impression was that Qemu is moving away from directly accessing
sysfs (e.g. as the reason behind allowing Libvirt to pass in an opened=20
cdev fd to Qemu). So probably getinfo makes more sense...

