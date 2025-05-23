Return-Path: <linux-kselftest+bounces-33613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B1BAC1DEC
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 09:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34ECA3A72D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 07:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79F628368F;
	Fri, 23 May 2025 07:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j9g1Gw8X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F4D1A288;
	Fri, 23 May 2025 07:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747986644; cv=fail; b=EoccYdxpyx8osDi0CW6sGrxAbk+luSPyLZqRo4opP2l3jo8MxPkeMFwE5xUE0AiW48EnB4RtxO7GtydvBN/hE8hjeCcFSRbYr7YpBgNluMjaRhRdlC4FSgXszWsiOWWSPmerk20LR2ggpHPb2JMcDYjvDZ+avM1Q904yxc/a4uY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747986644; c=relaxed/simple;
	bh=APs+7BECWNirjpeO/rOsDmaFlY8ajkJXLX8R4pLka6Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SUJ5ll8xEedz9RFQ7sZJPfPVv2xCGteAUTX8zRPMm3Rgkql7h60cC/d6dJgAeoLnFkdTgX1ZYOKbVSNVgA8OkLwHv59vw/vypuQNeu2/jXxc1/I8Cz9mL/yDu3qRbcee/m6yx4JNo0Rlcc31HWr/Nvbd23WbkQIF+KeTm8T9LIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j9g1Gw8X; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747986644; x=1779522644;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=APs+7BECWNirjpeO/rOsDmaFlY8ajkJXLX8R4pLka6Y=;
  b=j9g1Gw8XOVK74xRZMITBAbCVMZBLZcekn/tX7q3g6jomSIyiJ2sYxAZw
   MAuzwBCh1zE2MP5JfQlcUkLUoO6hGtj2IRVu1K4XWqluHWPzHYsVIzjnR
   8WNdJOjgHwDo+HBubu3mgzN5nXlESMUyjzkGD+fPWC9jhABfa8xozSM19
   78BVQKWE+timI1Eyj/sHmnAuhVYZHzPAlkwIo4TpWJSE6624vpLjOJY6y
   mZ0o4JI/x4ovfDI2WEFkMb2xmqX4TV0Db9RlXwRzEOeDw2H5mJ/POhd+U
   vowX4qjCms0xJzF94c33hyhtzsNSKJ93GNIvOUH5P25xJbzUBl2lDTzB5
   w==;
X-CSE-ConnectionGUID: 78LZUDNlS6ezUYWlI1lETg==
X-CSE-MsgGUID: cJ2ALvVfQXW94SstiSBxVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="60290378"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="60290378"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 00:50:29 -0700
X-CSE-ConnectionGUID: eEg65ZZLTBKaBqcEEr1uQg==
X-CSE-MsgGUID: njRJ5txAQb2gbELA1Zhopg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="171919015"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 00:50:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 23 May 2025 00:50:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 23 May 2025 00:50:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.74) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 23 May 2025 00:50:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fC4zR12ZEp097DHv5n4jRdwWY0HBQFMyjvUL2gaZUUVMZHgcn63BOoqY0Fh0i7O4y0nrGweq7WUG6RB4ibVBLFE39Tg0nCVMu87X0ACPNBy3NBJ6lBrd4Yk6Guw503d7coZTIlF1FyDDQVXdTmWqCtFqckjQ4cgFKAIMLGWp91tNf7MDdb3QIrLmFypMWgQULnzHW5y2HdZeg4Bzrh91ZJraKnWP86TR7ELgTc9V+SyrgRBaEu3DzIjKXYSJ1myEFiTuOKa6WkeMIyb9JmN3dgiyZkaPCP5A9Ldj3B8sJg7unFtJkLSGgB/NxEpbkJP9rjR24eYI8vDKDoKPqNRh3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AK6aD5QlMVn+n2d9qrWVN3S3ygWa/Fh+9ChbM4AY9XA=;
 b=MO5xk0QXqqBFcHCohcL+KXehWpbunWre6vkYAhuK1uK6UUEqP5NYE/+BLQnZuu7RJEaadXnNrEZOLl9VXaNoOH+99NrBJFQy4ybD/WcxEzOOqxXjm8tAaUX0fcl8PUNt+iTlFfTqUx+Nxfs/WWzdVFopZ+jmPHXXtQ9/pfan9sSs5Ben4R34jgEc8GfVMyiBtudI6CZ/yJLb9urfGzi1naojxUbq5T6HxP79VVRJOPN5ep3dOUoOwa9U7teoRa+RPJsIbJHM/wU1gX4DPYZnwkmSkAOQ9uvPf4YW+8m6lLn8g6o5jOi4IcSuyPWAB28ZMR8U2qRL41yzG836fGYYhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB7252.namprd11.prod.outlook.com (2603:10b6:610:144::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 23 May
 2025 07:49:40 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8769.021; Fri, 23 May 2025
 07:49:40 +0000
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
Subject: RE: [PATCH v5 03/29] iommu: Apply the new iommufd_object_alloc_ucmd
 helper
Thread-Topic: [PATCH v5 03/29] iommu: Apply the new iommufd_object_alloc_ucmd
 helper
Thread-Index: AQHbx6QUab9gqVJWEE29OKdWGASVW7Pf3lGw
Date: Fri, 23 May 2025 07:49:40 +0000
Message-ID: <BN9PR11MB527605018977CA291C0D8E018C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <c01f145f9fd9a803a3154c3e7221dd76b4f8adfd.1747537752.git.nicolinc@nvidia.com>
In-Reply-To: <c01f145f9fd9a803a3154c3e7221dd76b4f8adfd.1747537752.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB7252:EE_
x-ms-office365-filtering-correlation-id: 3647afbf-e875-4311-868e-08dd99ce5fd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?L5fV3RjFrKKfSwHIpBrdOv3IS+IF8LgbzcS6YMn3P1M9YX5FYZOiSCcwus4G?=
 =?us-ascii?Q?LFhHaHjeBTUwftAsbViK940lHqF5JViBzp7NYZK8nlhKJfF3KSpeJYTi3JwA?=
 =?us-ascii?Q?E+82VWcdvP3jr7jULkyNwzAZHLWTjmg+lYou1gR9bPSAl7px1y5MbHNntokL?=
 =?us-ascii?Q?EY52KdM8VyV75JfNIq4vTm0oQG8rDzGoBpzs+azoSePjDR4Q1VCaw6OXTi9t?=
 =?us-ascii?Q?69uZcF9Ah8G/RgyO0RMTv6q1Sfs7l3Nes5RQEM5Jb74K9KalDb3U0mU35IFZ?=
 =?us-ascii?Q?wkxbWsn5HjoczAHEoKzuR+fsdSMn73w94LuaRy1gi75lHWqGFvh3k2Amxau6?=
 =?us-ascii?Q?1CTNrirkFxNqnPWktxICr91Az2WVVtTrw0bppi7fotKu/M7+PlfXTtzlS7I3?=
 =?us-ascii?Q?sHzukGH569PZ2mTMDWYbwhYK2iUcJh1lEBJjaseoRkPOCIS24YgOPX+We9+A?=
 =?us-ascii?Q?Diq2Kxwjy0N2O1tF0kHvs5KJPDoHzGGn3fijHGFxxsMULa8s3CKq/shAicdG?=
 =?us-ascii?Q?mHImJQEV60hMasQqzoh9bHGVjMO7OlhfhZrnUl9cCH7VKmumzEyT5tyOFq3c?=
 =?us-ascii?Q?MifId1sHmZzNVRZUbTQzo0Plm+YqyRR//wek9fVClmLqmtGFr0kBPIDK1BZ1?=
 =?us-ascii?Q?63u/iMvolmd4jxWkKuvOa9Ae9QBG4gYfyOJxxAZ2PMUZjd8jL3MxgiYe3vWP?=
 =?us-ascii?Q?L/shRc1Z10B3w+32E+UGsAuIrd1xuQf0tcozekBwTt4lK9TmIKXo4lbo/wxI?=
 =?us-ascii?Q?bPqs9Jgic/x2PMiou6sg2RtNN7K2NC9jXkoq5wrqY7GuPNfcevi+UI+NpZ+2?=
 =?us-ascii?Q?z18BF+s/1GTkgbGAHXGIMwBwRR7JYTkvnyQZCeXe8rFVTi7/2d8/8HUtTbYZ?=
 =?us-ascii?Q?UNWUZH5aJghGQz26xKELzbZTdM3N3TstTQ8UvKkLDh/r/w30EUKjX3wbO7Cs?=
 =?us-ascii?Q?funoS9P+aOUJ8/SWUAtE8Y/qHgedltDr+/0cWY+JLcnCaxVWbnZrkDeSRIm6?=
 =?us-ascii?Q?0STtPxJeQdnqbptayWgteecgBcUi30AydH8X8O1FkxEeIvmehg/bg0x8uGK0?=
 =?us-ascii?Q?qMVkqapV6lZ/NCNxl4iSbjK22aKQFU2CIYmgLc0pkijWi0oJCsUlzIsGsyWe?=
 =?us-ascii?Q?rV+IwwMEoVvQJ9l5PZSZmMnWX3fUkGQ/dsCAnMlwZ0vcF0GuFVw+YJam3hUk?=
 =?us-ascii?Q?9JJGXwfn5cd4ZnlwS/1+w1iJJu5UR60eFSm/utzZW2otl6qv2WRYUNRxc63E?=
 =?us-ascii?Q?+pFPUHfA6jEJU70+3Fqz9RCc6OJI8bnGwCIc1erFUtjobOuEhALVHq2GtoGb?=
 =?us-ascii?Q?8RRY/g/pCnYN8ckCUl/jqnlit6w2R1n7q7A//sT4be6VLicaYXK+nlfxixnf?=
 =?us-ascii?Q?PBKYmPOgH4gjgap813PDSRH1iZY6qxXM+YzQ0Y1TpWf95uqNFtfrIcwqnT6G?=
 =?us-ascii?Q?OkmgyL4II8VV+jmTtJPV2r/xXytvXwdGnklCQ+hJrasqR16fTzEMBQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UIEt4V3isIYSsxKoSEdmld1q3UOoPgSoh1r/aK9Zto8A5x7op6x4zlephV/v?=
 =?us-ascii?Q?srR88xt+zwvyJmKmBWTrigbN7BGuGPwzjRiGGW/1bytb5KhqWCF58e9HHTpQ?=
 =?us-ascii?Q?GdevYehTZQPZfH/5tb30PVBvgWYZPix/Nkf8H8bL+IN5MW57A8tLC3aeH2vo?=
 =?us-ascii?Q?0Vv4PJqxc74wuyfTq9Z2JKX4MQi27MgJ+e2LzTrUX0uNnlOJIIBIh6Y6NmD1?=
 =?us-ascii?Q?8npWcJlQHRUdeVtUJg50gmeEPiZa42tEnB3FaGrY+b2kZ4S96sbhMtgQX7tx?=
 =?us-ascii?Q?HNE5NI4ZUhXwBu+XmPDPA/BKX92EjdcXcI6GNYpDfJmQucbVgLac23ingT0m?=
 =?us-ascii?Q?OFHJz89MQjiC/fIDL50D2FpsBnDK3Mg7BrMWeAOGC8RNNxiJwnuWQLZ6Vcub?=
 =?us-ascii?Q?SezRBrMZ8X1am1+ZnGrNf6Adu4UmmGQTVDzfO7WBXQIemO+t5XQxVH/UmYdZ?=
 =?us-ascii?Q?l3rt56ENV6pm5oH7LFbTmWjGPrsuisaQCrwcN7Q1jOi4ywsD/yToQJVrFvCc?=
 =?us-ascii?Q?6fYGP6XxOWFVxXupPxJodxax5LrZKzi4HuJCAUQIF7Hx9KSJUZZT2nt7iqNK?=
 =?us-ascii?Q?uHPhc3g4r8+R30a5UN5VErj6pMJOq6x1Yi/31SE30S9a6k0LuPuo3BCTlLit?=
 =?us-ascii?Q?68HabHVfbMBO+2r9tkLwcm5RtxW9cP/GCTpeehft9CDsAKE2SK6zRD4Ezpxl?=
 =?us-ascii?Q?J8lpS9RFEqvYDtBHwwWL+Pn8GTypiwHUzwpZO/bP+slgHhmY8mERUfMIkKsl?=
 =?us-ascii?Q?IvBdI/Jn3sQ/D6S2KonhuBUvqNvOSzXjLMp4CUsuLSqpkpZDAaXCvT80NsMy?=
 =?us-ascii?Q?p8Il5HUbwhdIuG6IfClLnkqwy39XjFr5wd9n9GUCggq1zP4e1zGqLR0/xb5t?=
 =?us-ascii?Q?fViur1vhTDAJNnE5lDgU6ox97R0KP/aNmAfgpsz1SnwQzlJ3L7bAl+jXVuvG?=
 =?us-ascii?Q?LnzUiEQGIpW6bCK3JlzDgbb27aTp0tIobxSSL/7g6tkyttPXIcjf5vlySfp0?=
 =?us-ascii?Q?/9tNeWNrRGd8cnXJvcL5hWwEuFVDcViZbGxTAxCRSFbw1eFN2WMDv+1uqpwi?=
 =?us-ascii?Q?aq0HdGHuOI7iMNHX7PZg0gP+LDyBPsebVM+ZaCaHS2HDOaVFBsD5aCRGDaOI?=
 =?us-ascii?Q?Ol5C3L3YTau6b4U+aeqNhKO4fjJSsmn6jbhFW2rAKaZPijdulKdn8z2KN+8G?=
 =?us-ascii?Q?+220jYvdyDkeeqcIj3UsHl2CtLSHeDKLn01lt7oXtc5NyGwlde8Y2NW6BPmD?=
 =?us-ascii?Q?ftdQaAxPrMNL8msGgeHzcE80d6lm4A/cesf2/LYBT6LCZPqqE4d+WGHndLB3?=
 =?us-ascii?Q?wOEcrDv2GJonu/TLI8b5m5Re4HAbXqYHgxwz1wDavA9r7Lww2Ym5E4xpPiIP?=
 =?us-ascii?Q?AMRtKSHVA8uO+d+ThwMC7/jtkqbQDnWtVYE3f6McCPndbM05qHtqSGQeXQZC?=
 =?us-ascii?Q?blk3w2OWC9pftMWyfaJJj3OkBaCBeQg/SHBVk2SwzWe29EvD980c0xx154nt?=
 =?us-ascii?Q?HLTD/Wi8GZixd881OzvoetXuQ+8T3UDA2H5fTMZDv28ZZfmyeHtmHVDFfSr/?=
 =?us-ascii?Q?eTN4cGGhKFKiG4WN7o/bba6DdEYZMUWSCvjGuW3k?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3647afbf-e875-4311-868e-08dd99ce5fd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 07:49:40.5887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hvXFHxbtm5kBOZpQYJEATSwaB/y5YgBx2aiP08cOFM21h0ugCUsNAXFaQh397GysM98sTNCQe42gQtqnRAy8iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7252
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Sunday, May 18, 2025 11:21 AM
>=20
> Now the new ucmd-based object allocator eases the finalize/abort routine,
> apply this to all existing allocators that aren't protected by any lock.
>=20
> Upgrade the for-driver vIOMMU alloctor too, and pass down to all existing
> viommu_alloc op accordingly.
>=20
> Note that __iommufd_object_alloc_ucmd() builds in some static tests that
> cover both static_asserts in the iommufd_viommu_alloc(). Thus drop them.

I may overlook something, but at a quick glance the following check
Is not covered?

-		static_assert(__same_type(struct iommufd_viommu,               \
-					  ((drv_struct *)NULL)->member));      \

Btw this patch doesn't convert all object allocations to the new helper,
e.g. ioas. What is the criteria for when to use the old helpers vs. the
new helpers?

