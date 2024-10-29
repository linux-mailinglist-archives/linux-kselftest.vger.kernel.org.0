Return-Path: <linux-kselftest+bounces-20902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 149329B4406
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 09:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DECD1F21ADB
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 08:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53BA203700;
	Tue, 29 Oct 2024 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kpahxN7A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E2F20102A;
	Tue, 29 Oct 2024 08:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730189989; cv=fail; b=n1Y1cXlRCr2BLpM5+lzKdXJeMCrdBD7iU2LRGHO6CFbfz5sJxom2kAkw0BqLe2ewpndZARtCrwjskXJ6N4LMx5H4SGOvIYgf+jtn/MY+UyK7/zOPtrn/XN2P+GIG9PlwapehvLCYuwnpBpeusNyu+eVkslzcCC1qGALcMFJMgSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730189989; c=relaxed/simple;
	bh=ELoQ5y4zSAyA6qHpg7Zmc39dkMS/Bde1hDvCJIWYP3I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Px/gqCReGUHKserBt7SVQ58MPquGfsoox4hrn5Q54nhQW6zcnkk16EgcN3ZOb3svAe/KnzGM8gOUOY04CA+hMUoOr/0ST5ep+6eRIQB3FhpBeYmIh9jvv95wL9617C5PxEv8gnUHw7LOvZCTjVLlJe2Ae/2MxJxqgs5OY5NbyIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kpahxN7A; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730189988; x=1761725988;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ELoQ5y4zSAyA6qHpg7Zmc39dkMS/Bde1hDvCJIWYP3I=;
  b=kpahxN7A92xjmah/P/QHwO63urGjFh8CAXRM1IHsjlen7UWX+wKaSCND
   WEtPBQtD1hSirvAGbOV5K8kWUPYKrULsEHTb6x4aAXa1MblkwceHuX/2K
   +ybmtyv6Tv/qtd4rCW83BZx8kwUlBEMcByDfuiEoQdi5f7qk1k51BPosd
   h5O6tNK8C9Q/7lwF7wc9vJGqWq03ndt+RW5406/K0At8VNyz5jrC3/C1F
   I0z370TOt+/6AZS2XKwhQdBSwpqG5T8wQHkAfRBph6k1WwrLLVy1xL+J/
   D9e0JspZotZ4lO937ylimJ3bja1xtK+FEuIR95whXXkmCw6xsxDbee6La
   Q==;
X-CSE-ConnectionGUID: KKtD0jhJSyit5pZshpm3/g==
X-CSE-MsgGUID: XKi2ybuCQ8+WhFvHlQ2p0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29244915"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="29244915"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 01:19:47 -0700
X-CSE-ConnectionGUID: DbcTJLMyT5igZHdi5r+2Uw==
X-CSE-MsgGUID: UbgvhlBAT5anFQzi1UlZ2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="81813710"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 01:19:46 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 01:19:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 01:19:45 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 01:19:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBzFIWti2dVNWwiItJ8dg7wTVRz0z+KK17VuSR+gMI+PW5WEi3GkNH3j6E5MRJ3A4p9atqF4uOanfR5qw6qKUiPAn2b/knJPffLSxVqiV5Eqj/bSZEiKarVsUcnblVHGFQt4jLzcNiZHIeBv0Lg/569PxlqTmvHT+4GVviqHPodPZFCwaSbzody2Sl17P491X6UgLVLFHKgPadce4BD5KktX/vRc1dpQZm/fcnER5WAk0Bys4PGFOiAv+mV0zHGabqI1CkRr5Unw59KlXmxEGrnc+2olbWFmW9KV+lBIjArKCZjDKBPRjMa1x3RiAOkPWctX7TK7a1DUGujU/dfAoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELoQ5y4zSAyA6qHpg7Zmc39dkMS/Bde1hDvCJIWYP3I=;
 b=MIb9r7Mf+bk0TXHv9GuifKQwW1NqWjO8h5SC8PCs7zpW9+V1Soa7Q2w5AXlYa1jDcBy+aPXhEqlu8anssqyiji1dJs1ZqIQrxWL76AxoJeV76basYYjzjGrEVzejBGpUak9mMOmW3RkmHGMBw5yzpyvApkxKLE0Fepfo6C6gAnzswL9kDW9yRLUV0+jD3kLXOQq5OrpLuJ+wrvM+And/3IHLRv2cwGIKmu57cZw7mUHJx9yTpx35YSFalM/EIfgOpvCnrWNpsxacRxnixamZFagOHJTgeYdlNkxGXB8z2RPL4XFhx+VmcnD7frmiyxcqWfm21ehHypRQINlHNIM29A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW5PR11MB5785.namprd11.prod.outlook.com (2603:10b6:303:197::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Tue, 29 Oct
 2024 08:19:43 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.025; Tue, 29 Oct 2024
 08:19:43 +0000
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
Subject: RE: [PATCH v5 03/13] iommu/viommu: Add cache_invalidate to
 iommufd_viommu_ops
Thread-Topic: [PATCH v5 03/13] iommu/viommu: Add cache_invalidate to
 iommufd_viommu_ops
Thread-Index: AQHbJzjNsYUVPikDxkCKKz8wZdt0lbKdaBMA
Date: Tue, 29 Oct 2024 08:19:43 +0000
Message-ID: <BN9PR11MB527636EB86B125CDFAD11AF88C4B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
 <e4817b7c2aa58b010a1453a3db9e9804b3acf5dc.1729897278.git.nicolinc@nvidia.com>
In-Reply-To: <e4817b7c2aa58b010a1453a3db9e9804b3acf5dc.1729897278.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW5PR11MB5785:EE_
x-ms-office365-filtering-correlation-id: 042e1beb-aa6c-404c-35f0-08dcf7f27111
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?0PXTA7zFtBG1J3SmZ9fWyyYvCA8oP/YDf2hM6Fa1y3tADcZasak8ZLZk4vIJ?=
 =?us-ascii?Q?uyKf76YzCUiQw3o4Vt/bM2PcFaZ7fiFvL6YH6IRim6XefFt/D+uzZNS9WYo4?=
 =?us-ascii?Q?x0VNzWs/XgSjtqSBOVaBgp142fMQxOLkDDBtwZE934l6RC27LvUDZ6UTHrUR?=
 =?us-ascii?Q?0bb3S+vJ3LsIwgZWrc3JSmBp3tuewjcn3u1bJBfCPBjSP+KYxl2wIIACLdud?=
 =?us-ascii?Q?YwGL/AU0BF8XRnPf9T9wtKSO/yL+lmecTNFb2Y9n2APXgH9n+bpGXVgHHwGd?=
 =?us-ascii?Q?n9ONWl74Y0JrSTeH/nwK1V621KyphqpxdEJngGvQNB7OdrP+scAypVmBwdBo?=
 =?us-ascii?Q?a9TSqdm7xDnoNkuRKltIjCSaa7UW/Yr9mCfsraEA1hZ/5vQzDtAidf/f0ZOD?=
 =?us-ascii?Q?MZhqZMS19guzQU9beQbQ9K31fzu5pvLgJ/qB4mJg70HGSoVimyGrSSo5Lx3G?=
 =?us-ascii?Q?spXT1yxIGMQfII0RxMRf1QlGN15vuoNAJwnILlOK75o11cOMKHPG3kPCGwUR?=
 =?us-ascii?Q?7JOdi2In+zvhlNLs9JKGai7jg1bSKXpxxZucl0QwPvsIpl6YFwu/tkyeVIxF?=
 =?us-ascii?Q?m/4d6A4Kh5ELVwLQfIwjUjGXTptv9kltskaQ1434vycdamRZTBRvTSSXgnp8?=
 =?us-ascii?Q?P74YcvJaw/aPS4AZlFQ4TJCrbh1uyBa0OeLrjoYLy4pNO2L3ea/crLJQB46P?=
 =?us-ascii?Q?I3YrU1xMg8z82MLUHmjZCRgFrKSKgPxNuGSsar1/y95HNgwiHxwFNZ91jxIs?=
 =?us-ascii?Q?IVssoDhOsioFvSzisd1RlEGUCg9v/DDU4+qmiCS8tl1RFN+4dsT1Qb9pCG11?=
 =?us-ascii?Q?GXs0Sv+S52LzxXZaywXC642fQyNLFASL7TjruRS9FlVWRJncrA/+7jXKYA6h?=
 =?us-ascii?Q?3r88rLsqcmmJCoC51/iXDB5T4lPWu1kAHgoBbHjj2ELfTGvuk428jQUM0hDp?=
 =?us-ascii?Q?CFGuYy//fcXrJhbJXR9ZNXGlqbMjD0fGSBzjrY875/xPxGrd129QGVqyjTNf?=
 =?us-ascii?Q?vo4f1X6YdHAWZr7+CqJufmGZRN5t4Hw7ZN1tgm9qqmyxauwTZGKDuq2qw+XD?=
 =?us-ascii?Q?F47EBuhALyubiGmhDEXTE0afubap++AE+9RYJjopUov0b7Yy4iYG0fb3iB0k?=
 =?us-ascii?Q?C9VYOQ6A79PBUwuCRz/ojQJhJDef3hk16jF0uWNeO9jFwFuMlnmkFq6FyEnG?=
 =?us-ascii?Q?TPao7oorovHodxF4p6+V1NQjXHY4Td/4ZGkczQkpSU9OrssHt3Rd66RxK4TV?=
 =?us-ascii?Q?r9liHYqp5+YM2iHqfWcPuQm9vH6v3kg4WywOMbc9LBWqs02GJyRh74aeTnDy?=
 =?us-ascii?Q?C8X8y/Ymc0gzeQzvbHEQdkS6mORZZFON1dmUNFx1E4zZKyg/fBfXlZCx3pT5?=
 =?us-ascii?Q?/n7U4eQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nExIxtx78luvOYP+I88IWBx7nO2t7AUG/uCp7QU9c7J3oRlgRtsv+HKtW9xY?=
 =?us-ascii?Q?/AJczlr56sEloJrWzgDerLQLG43hs7bW8XAhF2Bb/0AjfGGl1TkICSYytgj5?=
 =?us-ascii?Q?kMZncZTJ31ib6MRnu4NHanFSMkJeSrk4We41MG4IWQg3BCoPX/T3OnLevsy0?=
 =?us-ascii?Q?wb1Q+5I9I3DvSem+K3zFDA1JeDQcnZREl9GqED03kDwXcw8eoEvb6FXVK98d?=
 =?us-ascii?Q?yg71uPdmlf16pHszaW7gdZML/A4jlmBNR5htNOEQ8k5UxSrba5/jgffN62+t?=
 =?us-ascii?Q?MJFKEGlgiPjQ4tb8ljjeXjPySk3cSfU9DegXPnghvqihkz+DfPoU1ouaUk20?=
 =?us-ascii?Q?jbF8HNrlhCINWeuAyOypgsZdfPz9a/YOEJdbWOaMp/rhYPVzZRUs7Wjcz6UO?=
 =?us-ascii?Q?hVCqdc/yd8Hu3VU747o03HbvB/Gm6eIu+YEpDY9sPAe880WQj+Y+IDJBzXY5?=
 =?us-ascii?Q?oRKfqLqObFhCQlxJ2vm6KCFPHX/O+g7Noe/3HXMLXZ4mxNLiHxzMcdqYXbAz?=
 =?us-ascii?Q?+sDSM1986VcIiPgoj3GbuPOPce/Xbnayy5hEbRrPdXJVXVYTzFnDpk9idxEo?=
 =?us-ascii?Q?Myj0YQtSBOrLz+UrJJv5jf8inlgp72CC6mRcDBRNljlrB7QzzM6K/QR1dUM5?=
 =?us-ascii?Q?UB+CQFlzYI8aeGR+3F94R6vHgoOJtPThp501ezttLh8FZ7e+IY6vD0FAW4AY?=
 =?us-ascii?Q?tsUvtgepKXmFfsIYIH44C/YRbopOW5yOGxD7bywDcaRnTALY67YIb2mV4L/h?=
 =?us-ascii?Q?MrKW/e0caqP3JS+mqRIWxYzQ4PibzXNKvBazWKUY0PwA84qjt/JWLooxyM73?=
 =?us-ascii?Q?p1Poxv1EPZis4TaQTBU6yc8/EoDUHDnQf5l6icavtRXApF0TnHSSAzxJZ9wa?=
 =?us-ascii?Q?LUiTMATzZ05LHWtvfXnRjiXbl6WEMEbGYOOCxjnzFR2MhSHfRL+xJps1t9WV?=
 =?us-ascii?Q?CDtKSU9R49/MOjuP1fUnT5sgMcv+N3OPEE8oV7f2RUZO+C0wnOX3ON7bWYR0?=
 =?us-ascii?Q?p3harnjTN/ZJwP0R3GuC5WvLnFuWUX7huvHhBWRlhh6B1gUMaMvgHggbJDt3?=
 =?us-ascii?Q?XGt31IqXKd2ZZFVqwyAy7DNjqtI3XN4Hm8eYiKVC726YCltnQZi+o/6eB2Jt?=
 =?us-ascii?Q?MXjvoU/T6OPEirkUa72NMOQY9s2O5su/h6PgpWM0jFCkqMQjJZ+wmG8RBYjj?=
 =?us-ascii?Q?DvklwhbAGOuYrGEvm6ZeorhPa/vsqOLUFelUXha5HRK2gFi4tkNmCSs0mnMX?=
 =?us-ascii?Q?TrkqwuqCF3OMvqubpyhm7xHI3mdNNzQO4Vh5etAQzq7EgKCfsaRBbAkCv03F?=
 =?us-ascii?Q?9oMY46rowLJh90jLPU26kOyKOXVJzeXrA1wRmwY7LbLdsAiEAMoTvXy/3ulA?=
 =?us-ascii?Q?bKEaSS0s1iFQPjbRgJLMX23uLYXKL36WUI3Xkec3Jggvg8tZYrWL37adXALs?=
 =?us-ascii?Q?7sVmYfuLqL4nXMJFw+bhdO4eviNqYOuRURPpW0YhIo1qiyub2I+ILlaKpbQ0?=
 =?us-ascii?Q?ncvSdwIGF8v0jE4rzBx7kH5qnZoDfEnEtGdfgxniKPXtHYSas4Ywh4tYf6aV?=
 =?us-ascii?Q?NbCtiGePc1R9iqrMwgXdLOphpl3reJ0dzYFV5olf?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 042e1beb-aa6c-404c-35f0-08dcf7f27111
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 08:19:43.0312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z5+ykaFf+hXbhYfBt+m36kx2PcMXYj1mvfNKspW9rVG1gY6t61JZ5nQHlHhCdPcjSix67MhryaNlqU4N19+v9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5785
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, October 26, 2024 7:51 AM
>=20
> This per-vIOMMU cache_invalidate op is like the cache_invalidate_user op
> in struct iommu_domain_ops, but wider, supporting device cache (e.g. PCI
> ATC invaldiations).
>=20
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

