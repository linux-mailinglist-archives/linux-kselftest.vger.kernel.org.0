Return-Path: <linux-kselftest+bounces-20622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C49709AFD6A
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 10:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2AC51C21B78
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 08:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892041D2F6D;
	Fri, 25 Oct 2024 08:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Loh0ngW1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BEF1D318C;
	Fri, 25 Oct 2024 08:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846757; cv=fail; b=T258ge0oIMh+RJbeDksaTzgZne7G2RwPQKBvof2TqtEYjI3Mkh3JRnjOfvN5soABmKauefSX7SMpVfc0NEe73tgojV5cfixBTRb918B7H20IP7E7Ia15oaKgYmfQQUj7yKxB9AcT+Kkv14MsgV1mCc5DDujckJBzk4glpni99mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846757; c=relaxed/simple;
	bh=DFWu/t0pwpz9WSrKVZOuYLvvJbr8sOV5HAjPuxCrD/c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oVYgFI3lVeDLXEc/LGnQFh6xaukOz2laFAz45EUuS1IFQU8v0xciqStcHb8PpfPSb7fXWET+4kQYwXMS42Zm2Ew6IQrLJCqeF5zLYSLipn85Bp4BwLjxjKtGxFxSmaECdldHZ9XadXGcuPK1NhnZ4w9w593sfG+IqKa4IXhSosg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Loh0ngW1; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729846756; x=1761382756;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DFWu/t0pwpz9WSrKVZOuYLvvJbr8sOV5HAjPuxCrD/c=;
  b=Loh0ngW1wyo+LWNASqjbQNWCW9JA6IKbV8HMRKKVmQI0QjpS+aUacef2
   YlK7KfA3PgPrQztt+1bC9YqCVLO2CnoBhJJdyBWNIKo/BeIOuMuk4D+Hq
   koPirCNiY8jMicHD9ARmrDiYcg2KenDvRhUs6BAvOIxX266KVdv41DpCn
   vDYjsoG3RRVIqYP4oTQm4sXHigeXQY0djCKnWO6nZZjprjB1pqs0AQmqy
   u/bJFNJufaFN8UF7FeOWN3EFPe2GTL3LB2zivlr9gvqZxDvFQxPS36Ila
   YPl5vIUriMLDvRj8i1GWsH7lf+9HhWvaKRJQGmzoKp8DMVEwYXTTcbpAJ
   g==;
X-CSE-ConnectionGUID: 6l3BEqwOTeeyWUF4aUKHEA==
X-CSE-MsgGUID: 9HytFhYrRyGjcliFSFJAXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52064108"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52064108"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 01:59:14 -0700
X-CSE-ConnectionGUID: E1oeUuqUSiSbQUI27Zetzw==
X-CSE-MsgGUID: j+DKjRG4SdS7d3V+wASACQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="118318986"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 01:59:15 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 01:59:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 01:59:13 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 01:59:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yF9huUk4229454FuXU7YzCvXpREr0mK40AOn1uuUTSIO6fiHZwf2HRrQKEaccqylpNmIEaEqJUUUN/45LKb8DKec0Uc11p5vv8Pnx4M02tEBPtxu6Hp4TOh38Zb2dZaUrD77g3vt17wdSMrEFaTv3JrwW8mT/3THtEpy+e8AUidpHdz7cneBvhaUbH6nJlSl9CTjqt1L4BTF7VQSDHDg5HJ2hz19MPcPv4SGXxnvzMwuAAal+LgKr+1Uwm2zBBEoO47fq4BwzZWYSd25CMX7ZOo8NxmVrv/kwkHG87Z0rQyrIOPN1w+zboICCD6VnoS/pg7Na9td2EcNrhPLKNSt+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFWu/t0pwpz9WSrKVZOuYLvvJbr8sOV5HAjPuxCrD/c=;
 b=MKcQkFDzFoz8H+5frP9VAjmr3L8vpjdS1XOwM8TY2Nlct916lSMVIVhFKMEM6E0WWWmszM9GvBxHR5ZYiFHmvB3ZKokPLwuk6m5gxu7b8xG/gs8R/ocR3dcKocwQaVxHq/DU+MGtWwN+eASXavlgpUFQh2BV8790sZhpdcEqbveENmZBsPJB4/mSj4COywUBYI1GPQQCfuAH8OCcuzH/Hi666Svkh9UCAiOVkW0jRsYOWXSbq/Tk4N1vacVmBOTMPiITyOBs1ixPA/MESSsIXrLgTRCnQuZ0RWA5VIjDNvrBf1XldHBYjSjqPEO8CZCeDhECUPIey7xD0pMFkX2/Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA3PR11MB7433.namprd11.prod.outlook.com (2603:10b6:806:31e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 08:59:11 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 08:59:11 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>
CC: "joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
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
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "aik@amd.com"
	<aik@amd.com>, "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v4 04/11] iommufd/viommu: Add IOMMU_VIOMMU_ALLOC ioctl
Thread-Topic: [PATCH v4 04/11] iommufd/viommu: Add IOMMU_VIOMMU_ALLOC ioctl
Thread-Index: AQHbJBg1YAeYUD/RJEqxNQPpgn5DG7KXL3MA
Date: Fri, 25 Oct 2024 08:59:11 +0000
Message-ID: <BN9PR11MB5276BC711E46B073AF8846048C4F2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1729553811.git.nicolinc@nvidia.com>
 <9da2cf334a182ced4d4ffa578b87889e9c0856f3.1729553811.git.nicolinc@nvidia.com>
In-Reply-To: <9da2cf334a182ced4d4ffa578b87889e9c0856f3.1729553811.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA3PR11MB7433:EE_
x-ms-office365-filtering-correlation-id: 2eb02976-9486-4998-b064-08dcf4d34b3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Xs9blUS6Y4Q/6lCY/t/8FuGFOmRlvIzw/48yKz3LNgVzI3VDNu3gTXylwtqT?=
 =?us-ascii?Q?FFNWw90Qtz4zeh3szrzXVMi2WS0oRPj/EBHYQATNfPzpZ9/+99k7IK0gBthh?=
 =?us-ascii?Q?puJBk7FUUz2ztl93YLdJPHnAfAMAgHBsLsrjWPPgkAghKh+ajAolb/he9EK5?=
 =?us-ascii?Q?Ym4SZpevFYpiff+o2PcuiSUeqfqCSq9hKTNCty9ONuVHTQmh+aWQsuQLifal?=
 =?us-ascii?Q?Wq0D0cx4mad4joothBI1nwun9RENuhmdbANRBo4k+TFaasAOn8tCBp35ly4L?=
 =?us-ascii?Q?Bonyx+xLPPrRBTFw1InlJrp/nvMJKEZZwo3tKjam7VlVgj0EKOXS4Y4Cz3ke?=
 =?us-ascii?Q?jHg5UhuzCux5AmhKzvtWsudnLVB82f84djUL2nf/jEouS/ZdEq3ThQkvlo+o?=
 =?us-ascii?Q?fXGTxM7Gy+OtasgUFgJYdLLbyUJjHpQ949R8NzIGpi9sLpv7fDIvAYj+5Vgi?=
 =?us-ascii?Q?USKqc7CFtV8vEjhsLAoWNZdVmpbhihzfTuWUAndtedwbTngJcz6Gqdq4iuwH?=
 =?us-ascii?Q?l3oGUY9B5sFODzJeHGD9rXwo2gZ6GlXAm0yH3+bj38mMhf+BG0K4MI0HmI3q?=
 =?us-ascii?Q?Sk8Q+tKwcY1RJPXAKRDltmydYoGPdwwJMeYIDNdP4nJDuch9ELssU5P+fjZu?=
 =?us-ascii?Q?HSwAGWoGgCWyq8hI6thGhK2fMz384ujzgeb82rofq2KKIekoPT5aixAv4Ys+?=
 =?us-ascii?Q?8YdpoTknKFzSh2ubqBTy3BxJ5W2Ton/mZl45W5E0t3CYr00B4RZyCK/kHL8k?=
 =?us-ascii?Q?hp0WfbsLTzj+ZRyWm+zuwdJtglZ0fh4o5qtYyZ8QsivbuJwo76jBDggvRhfr?=
 =?us-ascii?Q?PTekASGNaRYfAEClI3D8wrTW3PjF8wbHxyod93QBHOYuFbVPG7Veq/i7nl1Y?=
 =?us-ascii?Q?xCV9IMwj5yw77Vlvb4SvLkxpUjbZHhFtER2bzKktzVqTDC0oLqKb+yt2f4Ge?=
 =?us-ascii?Q?2AbYWHH0/sYPD0oR0INAFqp1Q4PCBJvrYszSplV/Yr15bJyJDksk0FSD6JaT?=
 =?us-ascii?Q?eN19Cfl6U+rg44zT+GPquM8lN3ZgXHk2i0r0s932Lf3B6SrGDvHKWYXZlbN1?=
 =?us-ascii?Q?N/Cwpl0UoT0kJagTd/5WNu6dcEFteoaXNmS03zdz5EqfVlhS/ac4rIT8c+2g?=
 =?us-ascii?Q?AZe56n/ObZMSszdw5SOT5Obcsg9EBr+iH+rkBQom04P6LKXs/6kXdBbIiGv5?=
 =?us-ascii?Q?WQxLyTOcf09TDnBc6nwMTMb8WwWMGne8i4jK/lItrLlwur/HqNfbrWRMIPcp?=
 =?us-ascii?Q?AwJBbt/kGj3yxT2rQjwgC9kHqyA6rT1yAN2O8nXVBrn82elxeTZ26YVAR0eX?=
 =?us-ascii?Q?LClowJRa/q7/IBiNnGBp/sn7K7XY2C8gkfZpxaNTIsM3EY6zboNB9JbUUHyx?=
 =?us-ascii?Q?krRyl9A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/FRG+6Cz1xqsrCupEcR2ryqZlEjbYC7X7cwXJdpUtXrE+RhYTyatmCtGMd5t?=
 =?us-ascii?Q?+kj0VtBJdEgw2jLuxDRuWO/uYzwV8CWtSiVqrLTqi+8gDlkj+cJ5jkBW7nNz?=
 =?us-ascii?Q?Obyg2x4LKqfrwVzR13O42sdGbYI7SIZzpnQJd0I7X3PR+4iPZY6Z5MonIgxw?=
 =?us-ascii?Q?I6GP5LtNS32W4blw/LHV3O/budymz4+o1emG/Nftpm4bDOXbUecjJMhyIo/4?=
 =?us-ascii?Q?CTP1vWqHg/Ztxrfne17pM71gQ9E/NoAcYSlehgmeqRaR34LjAp+CfJOwds7H?=
 =?us-ascii?Q?dCFN3F2raDJkHbnIADPjp2erpm03GWeEVZyW4RZZzgHKT+V4QQ24+0m5aPfH?=
 =?us-ascii?Q?CqXg4aT7QKOXMkDP6O/ZdCi6p/mYYP9W9LX85K6ZR2KFNq4UMOJQfl0DE3ok?=
 =?us-ascii?Q?LJ+ZUWQ4tIhQdACIQ3DJdneKu9FBpPNDLIobxyiIY0FJCmRO3PnF4uyyQ+PX?=
 =?us-ascii?Q?sH0DcyoCLKWIU9QN+56W91C8d7H6/lKNtXccOtBf3nbANLkaOkJ6pPe9SiIB?=
 =?us-ascii?Q?GMHHz12X5xOEpSmR3WrO7h04kYLtGUcENU4iLrWBXfZw8q3WauIgyrDnQhNU?=
 =?us-ascii?Q?jCcRNFgjB9kgEbS4z+wcSqcVFW+zBO4hpXq8LtLMZNYtWvA53Dh1zdTUiUIp?=
 =?us-ascii?Q?j9++iTD1RwnZzmSdlO3BgOuFsXhp/SOFyhKmTtneFOaiptNLnbfNF7VDY+fT?=
 =?us-ascii?Q?MlNcWtBE4KWodhdRK4KcEr2NygFGgIy8EgfgoawoFC4+WXF+VBL9XR56HM6U?=
 =?us-ascii?Q?QLewRsiS7PdY9a91i4GbSsPiiEYwym6xoN2Vpzkypbwz5wA1Aw9+PTiuTmNd?=
 =?us-ascii?Q?789srcW7qNaes4/AHiXh6heGnf/rugpt/FpxwsbeoNAVbXbvWJ4SpMX5oZNZ?=
 =?us-ascii?Q?P0JRMKVUGaf1gL6Ta9WiIp8eEz9nwJunF7MIMJpKAd+YgEo6aE2PWZjYxbag?=
 =?us-ascii?Q?ZkZESifT4UmP48G0s8wL/0VwWnPhO9aKZ0mNbqYNEOwjv8h/hm8Eh8ByIK8g?=
 =?us-ascii?Q?WsUYia4VTvp5+ltX1ucKZqphznqFO8L0V/7AofI9ZCY5/QlmX6ZICzVNyvPS?=
 =?us-ascii?Q?VKfQ7ILh7x4PloEzKGANBLjKXhZ8GVozuvPRSmZ1KuW2tgnIePuLaZx+fBbG?=
 =?us-ascii?Q?hGDvk1PRnV7vYfmeW7z76Bzrl8D/ZxYL55YHMFSE+95HFBFjkILuWXocJYrJ?=
 =?us-ascii?Q?QKebcB390bF8WiTdoAmaK+vdu9c5ETYw7WMkdujbxATnLce/IvJ8CfpjRphL?=
 =?us-ascii?Q?c6gQkM4r2+VyotGUOXtFNiI3h7/uKYXRpE/5ZxZxQKIk8J6EXNsGzmSHmGYA?=
 =?us-ascii?Q?+7RVZj2VF9tlWmaCj9gKTzPTJky4tK1hv+eN9bDOd+2KmXaGAEXSk8uSYMhh?=
 =?us-ascii?Q?jfq7gVtQTpXTJghJmJr2SaxSXnKexl66BGkUqK+c+u1CRNGJ0K1G5IS3uoZg?=
 =?us-ascii?Q?S+TCKVuquSQPlOZpFp62yoLCyv9tkkAm606DwwRj9RoXVCkUzyqZmml5ZW2R?=
 =?us-ascii?Q?I0O60KWLWtRkirQmLeBTllZOvXCM8x+5bwxGJdNhtpzW6F4uusDT7XXSVw3E?=
 =?us-ascii?Q?UEi85tkYRvj7st4w1D2AvibNvVAkG39pU0KotF8n?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb02976-9486-4998-b064-08dcf4d34b3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 08:59:11.7112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mKsqn7e4FFQ2hyHhFVHts6SRBwHm5MigEjHe3GT73jEymqiMEMKUXxN79jR1OVSQuTs8cRRWIPTnIjg3zmzD3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7433
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, October 22, 2024 8:19 AM
>=20
> Add a new ioctl for user space to do a vIOMMU allocation. It must be base=
d
> on a nesting parent HWPT, so take its refcount.
>=20
> If an IOMMU driver supports a driver-managed vIOMMU object, it must
> define

why highlight 'driver-managed', implying a core-managed vIOMMU=20
object some day?

> +/**
> + * struct iommu_viommu_alloc - ioctl(IOMMU_VIOMMU_ALLOC)
> + * @size: sizeof(struct iommu_viommu_alloc)
> + * @flags: Must be 0
> + * @type: Type of the virtual IOMMU. Must be defined in enum
> iommu_viommu_type
> + * @dev_id: The device's physical IOMMU will be used to back the virtual
> IOMMU
> + * @hwpt_id: ID of a nesting parent HWPT to associate to
> + * @out_viommu_id: Output virtual IOMMU ID for the allocated object
> + *
> + * Allocate a virtual IOMMU object that represents the underlying physic=
al
> + * IOMMU's virtualization support. The vIOMMU object is a security-isola=
ted
> + * slice of the physical IOMMU HW that is unique to a specific VM.

the object itself is a software abstraction, while a 'slice' is a set of
real hw resources.


