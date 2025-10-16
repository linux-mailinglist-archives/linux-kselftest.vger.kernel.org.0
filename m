Return-Path: <linux-kselftest+bounces-43309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E4561BE20A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 09:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 462154F984C
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 07:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BD53009E7;
	Thu, 16 Oct 2025 07:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VhnjvLRt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA302FDC4E;
	Thu, 16 Oct 2025 07:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600846; cv=fail; b=sDVNTVPP82mKZAsEY2zKIKjkV0RxNudOSydtMVuWeSWyVFYpnuqsx+8p9lTrY6nlIW1QvpVdIqXqGiRV9cz0l3olMO1qtmBSREuzkMD+iTCMxMFGFk5c94kLRloBFXGc2o244wOfUHf8q4eX/L8y7gy2Om4VYDDXz/49QORPCZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600846; c=relaxed/simple;
	bh=g54Rvx4gsm7M/pp4TwqX7c/a9WkRxgdaimQXmX+HgPg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OhdAg7meVCzXhjkJyrToau5a4aIlSwClquRbz2ApE468qn/jEqAAmu53evK/ZjtneXCgXN2YMsecYgIY2mZOJ8bT9SrsmeJCTQSdEokZINoJArx3V0PXFA6vKbLIrX2p6PeXnem3pLNo6xSa7P2q2+eRdBSI100TxR5Umy2l5lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VhnjvLRt; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760600845; x=1792136845;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g54Rvx4gsm7M/pp4TwqX7c/a9WkRxgdaimQXmX+HgPg=;
  b=VhnjvLRthztZsk9aSrgqIOFnll6lfLIqrSPYZ0ul+h5LWG7tOpplP2Uk
   TDzFaa/yNeAEzSQyxhmjI/jqoMFYg2gD5tCWlfP5sddcUOfRiuNyeTlWH
   D76CWJ3U9KbbA2qbLkgkDTVF1i3tqBbqysr64RWEenjwDNEyiZqZn5S2F
   vQZUtE++JbL80NbEjI6dRVhbLfvz18kOo9mBMhdTYAgHMoWm21FDvya6/
   7TrqCRtFZvzQp2Mbq7FIAh+BkgFQOS0vcCzxcv0S58HaMjLWGAMtoHzBU
   d8vj1G1GUTvHS7hG8POBZ/mVH5dEQhhtk7UmtoDIKaiUZH/aUbFVJw6u+
   Q==;
X-CSE-ConnectionGUID: bqj70GCMRhK7hD1xuLBU3Q==
X-CSE-MsgGUID: goYMxRatTxuO1lW1PiTQXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="62826175"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="62826175"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 00:47:24 -0700
X-CSE-ConnectionGUID: pOVEnrsiTGKxKO6Ri+Zdww==
X-CSE-MsgGUID: LXDo4EwlR1m5k+Lbnf0x3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="181596517"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 00:47:24 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 00:47:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 00:47:23 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.52) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 00:47:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBPNcI1GZc5/XFhbdTmFXxrAixRTrJwaPI+HF1rV88yDlTraOZMw00ZwS5C9GQ4EX4lYCgtO6/4a2hjy8GyVfBmFvQSdxiZjLVic6v11sVXUZyHZvT5skSH2kqBRzoGvuD9a06lwtGvBzipLpW1o+Bsv+rm5BnOx06stex5qP3J8SFc4n7nSkywH6vOYpb0+S3rCqTelb8knVkeU77g/UlOGLYnwFcp/ni/7YHP2jKGnl8UTbbgDb/vCX+5hddJyrcxko8pjaiVIXfR8eMEppUk7RN3iqkp/dJGv/rKa/pjRCp0REkTCQnkZv51q7Ydrv1vDmg2TkDU+ykHwNAS5uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g54Rvx4gsm7M/pp4TwqX7c/a9WkRxgdaimQXmX+HgPg=;
 b=gB83xsQ1QstWaIez6gyI3MnfvM+NaWxU9nZwxZbMuJ3QaqgnBWI7EOkv8SJVp6p/xevfHzeMav2iGq+Qqro7OYFFkm/DJCKfmhiVWVuAjQBCBoea3KpCWuk0OE5KD/1BOTXvMeZzizjcfwyMqDA6mENXBz0s00UUx9h8J4NMOB2vo8WXfuanzFXshrqQweAkY2OIF1Axki+8yDfck03u525847ueAieH/lg9f/7OpYR/XwriB0w6EwY90nXrT08gnh4PnsfrxHWOrt1W1NhTPj7lotNKYJTXSE3OwrsOkADDiWlOS0BOu8dABHU+xQaPgLH1BtS9ronrqd+wXr6eoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW5PR11MB5787.namprd11.prod.outlook.com (2603:10b6:303:192::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 07:47:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 07:47:20 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "shuah@kernel.org" <shuah@kernel.org>, "alessandro.zanni87@gmail.com"
	<alessandro.zanni87@gmail.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rc] iommufd/selftest: Fix ioctl return value in
 _test_cmd_trigger_vevents()
Thread-Topic: [PATCH rc] iommufd/selftest: Fix ioctl return value in
 _test_cmd_trigger_vevents()
Thread-Index: AQHcPVRnkLZe3dbGA0qfw2AZydGM8LTEZ2yQ
Date: Thu, 16 Oct 2025 07:47:20 +0000
Message-ID: <BN9PR11MB5276834E90A7990269EBBF608CE9A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20251014214847.1113759-1-nicolinc@nvidia.com>
In-Reply-To: <20251014214847.1113759-1-nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW5PR11MB5787:EE_
x-ms-office365-filtering-correlation-id: 4645af4b-958a-42ab-8aa6-08de0c883c79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?7lDQdiUR9i3TtJLQEBP9uX5GOQSXHf/N+t34LnEuvnUN0gE2+/phxsmkhVXr?=
 =?us-ascii?Q?6tGh63bsyReRTa0jXeLytiJXYksz+b1IaQWUHGk/+E4ZTtI6bsdcodAFIx6F?=
 =?us-ascii?Q?RyNnhDsvit0DS2cb/vnc7Y/d1nSc3d6wgEKy90e4W+1r3sT9NVpKiEhI2crE?=
 =?us-ascii?Q?zo8IHLz8r+VbrGtNejExYWUsOsw2xnfeEw0t9XGkVL/SMMVDiTIbXZyEoZa6?=
 =?us-ascii?Q?1kTxbdGrxyFuZkOCca2VOXGCQEdtGzvWhusJsTIM4m2EHQ9Tl/2h/5v0Sfwc?=
 =?us-ascii?Q?EwAWUSGB4kjy97p5SUQyz+Rv8lpCdYxKeMcD3hVdzu4TdYDmJuj52Gk6rcLL?=
 =?us-ascii?Q?hvu6XkW1MsGYpt9IzVYEPKJA9VzrtLnDHalNk8EnYWWIxNQdjOJzes7+QcEH?=
 =?us-ascii?Q?FRSztxIXEIQYgz22aH6IywE8tGGqI8jSSj/aIA9UUmq9Qr1135VUqLHr6ids?=
 =?us-ascii?Q?RVMNqaHV4K9D7uD/fa2FIdWzo1JGU39tyz31o01Knb2ivKPqCMGm+CAEFsYV?=
 =?us-ascii?Q?4nFUyTWPSWUZuXhfdUZ+um20nm7exEak+orh8Tv6vLRDfQ0/rnny7uI0P0+p?=
 =?us-ascii?Q?o3hupbhobpDtlyNXL4KDiidMev5T16KPQMKbsuObzwJWoPVwp5ipEIiZtPKX?=
 =?us-ascii?Q?jruL+W1K6SoUmXPa5/YRe+egym7bgC1Usyr7hIOM+tseJeV26P1emm9/+7zZ?=
 =?us-ascii?Q?Wm7SiTJAQrMcZY8pmvz5fJBSHzQSfQNHX2cN4tCEiDG6Cvck3sVUB5UwztiY?=
 =?us-ascii?Q?IEzbiVIyuEp5hTRAuwr22ziCJamD0QC5nulfl+mSJ53QqHsjPTx+vtFGkxLr?=
 =?us-ascii?Q?YzknYSg9KqY/Yidki1kdubdeE1A508JPIp4Rz1vBf3Z+XFNd/w8tlQSKkBpK?=
 =?us-ascii?Q?CQ8FhycRzQnqN1quKsYn3H+qNVnUG5509hPTDWrDVijBpofUu0i5xC+2vquG?=
 =?us-ascii?Q?xHuf3qwTXyNBj4ruJJlBe8kNEiwaChlafB4L50GGcZiski6rXnlmkmOz9ha3?=
 =?us-ascii?Q?0SZPI4FboduVMwu6Z41FDTLUMm0l5CUWKs4MRzz1iOvrXZ8t+D7a7J2CQ8eV?=
 =?us-ascii?Q?HZAFbRzpCp3U5GpstwyiW5YujUPwcmaW/5jhQA6nC6J78gMeFz8rQjgyBUSH?=
 =?us-ascii?Q?Krz3KeA8xkh+QGj9JnfKR8KO2q0BizN8KWu7aAAKeDfrCD7nDWgZ11HcyEqd?=
 =?us-ascii?Q?S3iWEDtIt8AvsDsYRLhIeHTbIziaD/SqkAOkHawH1VqaeOP7uHr4jtXdsuOO?=
 =?us-ascii?Q?p4OjDqmY6J7/C4hBYDdQGDTXPAtYjMPNU/WTXhwr5wbv9Ie0O1Qvk9t4OC9N?=
 =?us-ascii?Q?8auoBt0uhmRYoXm2TxpW89NerHSjUw13OQmZjhrU63X49G9yX6Iqd9hNfmjk?=
 =?us-ascii?Q?kFKo1HvYES6M8xd6M6UlDRI1yPr303A8+eELNkG6uz22bEzuR+yyeCITwByn?=
 =?us-ascii?Q?yimznljqngo80UpIgMVcGzUSoTdrVmUMbRwPg12MQWqVx7XoJ4eYwfmcYkOP?=
 =?us-ascii?Q?aS5XN8eMUQfbiH2qZGQduaeDcZqMOcCzztYJ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8e7pN55iEsjQikyFsf3BZpTOBTrczi51/ExKHIeLfP/3kSVQAQEhsOHlQIE2?=
 =?us-ascii?Q?rbJB4rzty1/A4WUOa2yLbQFCaOWJKiXBFieqWtkTIYj5ZrsDFoandesAb+nY?=
 =?us-ascii?Q?ApF1bvkxTv5qoSe8GSsla6EQuXlELR5gISAAPgOqK4JE/uKOMkX/sshROvGR?=
 =?us-ascii?Q?ZdUbAIrjREJYQNh1V2Ev0gv5rP7wyyVt533/AMWXr+xu2OpFG2iAhMZ1ejzD?=
 =?us-ascii?Q?7ATAoBdsMDPkSHBvPggrUQD/s0VEEWOjyvCqkhelFSlzSWEXrBEpK7KpjPVT?=
 =?us-ascii?Q?KtIe92uLn+8V44G8PPJv73TxrXyaTgsUcREWeF2oRUXzrze+x7kxHCkduxXl?=
 =?us-ascii?Q?ZrmAD/J8l6a1aFj3Y3quT9d5evnmPe1wlgPp9NHlNhe+Ndqckc+okevnzm1j?=
 =?us-ascii?Q?6HUkknGGtB2WsZwJEQijyHlCQBq9ODQvP683xg9e5JkucOWYLRXWrCj0pQrc?=
 =?us-ascii?Q?BIXl+57+3GNs6ziLvOkjcTsgB+v8738F1CJNPk4S/KmwV44maKavHxWbCLQC?=
 =?us-ascii?Q?kHkwUBcDMsnJJ29yux0liHS5AQYMQ3+UN/LUXbuNUKzZ8O2QaDGof+0rpTEd?=
 =?us-ascii?Q?VDPa06LxbXih38viY8ghQ5a1Ppy8azVC9IRjqiog/VaWj8/jUW+b377iTdHy?=
 =?us-ascii?Q?YgTYVLpoiRE/tPaxh+y/NZzic9Ae9KQPpZISt9kYcpvaTMr2ErtQGzIMLjCY?=
 =?us-ascii?Q?TfMiqrb4Fod1DBQ8t0yD4nhGPwZYO/kIG69D8J5SOmaRjNsop804NPp0qEvA?=
 =?us-ascii?Q?VEz/2L6xjJ2NriUqmS6BYZkKGZBlFCElGfi3RvRkVfQNp8ouD9LGnBOFiVr1?=
 =?us-ascii?Q?eyX5Wk6t4YPAQi3pSEefbgIXzcwMUsRjTa3jWOL3BbD4tGs0VrIkTp7sa2Oa?=
 =?us-ascii?Q?5NQGt1ZztjFnk6pH3gecaYrjETcjwD7Mv7PIQcjs4SxFjBZO3leNOaFpWCFW?=
 =?us-ascii?Q?gyBgN48hOcUvs+9sXdoargr/O/xPmfx+2jCCgf8R6wyhSIpBly7dfEIRHG4v?=
 =?us-ascii?Q?zxrKwSDY5swtd2bukiQIPNY1CQlUigs99ycg/6yZkNQxSj5nM5D3P0omjPPG?=
 =?us-ascii?Q?iHrSOJnhKf3dvVPUV6wAXUFLbHyT0ccfXRcwHApJEeVgR+iQ+U25zfP8C2Kr?=
 =?us-ascii?Q?4li9U6c+CYHbUSnJaHfT+++Pi4aMVBIrqLVRQ1ljClE24nDgzwoYPc5bSyp4?=
 =?us-ascii?Q?yvpHxu5o9vi/77UM9MxHWFapqGGdsTrn9iNP1hlucwc+mmvyPiY05iPXW76n?=
 =?us-ascii?Q?uZozvbTKYrAu7MjZq83Zam6HtFmd0gv3C9SJNHdWzRTGHTS+zj4ahNfoye60?=
 =?us-ascii?Q?f84nJuJw+gjVog76UpNOjSTKog+bVjasaimJhqubcr5Va663EslzMFygI7sl?=
 =?us-ascii?Q?GGujlyYmLlwpoOspKeyxSULx3SfJPupf0QPNHU4BStpvFeO9sGS474Rlq1U1?=
 =?us-ascii?Q?TtfKiSFCQY0epOQu1TwPri+LRFlLw4PJJcukydq64yymcej+lXE4vx/fFDVg?=
 =?us-ascii?Q?qqon2HheM9clvI0EbDd/o5IqENK/0+A84Vc2h++wYmU4sCOYjKlZAyh/YuQ7?=
 =?us-ascii?Q?oBnoB90vtuDgAb9KNY5M4Vwu2gUFFx0Hc9SjeGza?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4645af4b-958a-42ab-8aa6-08de0c883c79
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 07:47:20.2423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cgR4dNYRdEZ8AuMMnWGT9xljDHFnq+olTgbYK+dw9AwFxGfZH4X0hTYKz84AnuWgQzja+37cjPEJCAfb/paUXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5787
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, October 15, 2025 5:49 AM
>=20
> The ioctl returns 0 upon success, so !0 returning -1 breaks the selftest.
>=20
> Drop the '!' to fix it.
>=20
> Fixes: 1d235d849425 ("iommu/selftest: prevent use of uninitialized variab=
le")
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

