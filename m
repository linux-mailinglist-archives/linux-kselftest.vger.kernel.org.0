Return-Path: <linux-kselftest+bounces-20773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 775F19B2317
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 03:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0F431F211CF
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 02:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2E86BFCA;
	Mon, 28 Oct 2024 02:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EkctC+1g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7977C2C697;
	Mon, 28 Oct 2024 02:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730083615; cv=fail; b=oh5oL1ZXJp7mqkpL/J1e13vv0Nskrb1x/qPjIrlzu8sONKrSOks01ZPpi0TG5kFKqnI6NkdAO2XgiJ3Kj08mtn75D++mAduef+QUuUHiRWjuB6RN/tzhKYp6AG+oCiqPrnMGqCiWrjQGI+eh2Qt2pdmNadZFwuPxEUzkLLvg08g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730083615; c=relaxed/simple;
	bh=AKG4qdlzrqh42HFzWnPLCslc1JMcK8vW5Fk1Y/7Kzag=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l5WFnHRYWQz2HwQiPsI5AK8bsvG3H8SxctzCXoIEe0h6bUYsI0GMR7yRb7h+alJQ1G1nL2IlE1tywSkSDf9W8nWNyIas7Jw+zUMehwd8p+8/cwrfXJgsMpo9NeHPTApqtP2erZjQL1qOirnhAs/CZ7jjSJIinX0EBq/RrRf4GBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EkctC+1g; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730083613; x=1761619613;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AKG4qdlzrqh42HFzWnPLCslc1JMcK8vW5Fk1Y/7Kzag=;
  b=EkctC+1gcnyZtBvozmMsYKBmnFQeDw3tofvWCX/J4KP8hJV/K43gURWT
   nq2DoGrtJdVVV2usEulGaL9iGx+BptOyyjs5h6PrxbP122Fxb4dpi3V3c
   nHIltH7Ws4mU+woJeDRWlVN0UhT2xpAkhTB/1Hsxz63rMA2SxYh50SODr
   SuwDRoXWWIAo8RoZyKKgQ/7HS4Rzu8iQdMi7nCXGxkULlQ5O1FzyAORnI
   +J9iDUXiNaeYbFYeuX/eJ/O/OsiBqMHR9NORqoIpADCA8q/wHMmCHwwFd
   KGfUVFES5/cPDe7lzDu2YFHqC3Uk7A4XOG28z7SHGr3UV0WbNClwUOIZg
   w==;
X-CSE-ConnectionGUID: 1SdaxWIOQZePhKF0agWgkw==
X-CSE-MsgGUID: 73rmBB4sQLiCc496MkRyAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="32533359"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="32533359"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 19:46:34 -0700
X-CSE-ConnectionGUID: RkZzTx68TZq6SAg5IE4Zcw==
X-CSE-MsgGUID: JDmtEW5iTw+zVmEQsYg+Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="81634892"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2024 19:46:32 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 27 Oct 2024 19:46:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 27 Oct 2024 19:46:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 27 Oct 2024 19:46:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZSJ670Za9jp2opdecXn6TItJLUbnxaVntcJOyzXyZywuDQ/lw/Z3QDabumZyXChdoM3/d/1OgSL/35jISEbad1KY6vbqvmofaQSUfWaaI6Vp+tPMX+0APooYuA4/pkY9PNKmSWWW8P08vca6Oy+EezAj4Qcj/xbp9sD9/6alItyv1YyKCgOB+0OtS1JuuVpakm6luNnZY3OYbjBL3NxaLh4tythS5u7Oo0dk1lX76Kf+wYBp9zOcw0gKYKa5jAwcGrWYQQndJlty7luHZa5wbIxk6qB04jNki2tCJIF71RvGH23zP/t8xmdoKXPogAHZ0WsKnaVVsq2yaE/76gmHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKG4qdlzrqh42HFzWnPLCslc1JMcK8vW5Fk1Y/7Kzag=;
 b=oW7I/43w/nqrIF2cl9IvJ/QaDumjN3pfY50Pl9rr8asskM7iQoetc6FTQ8E/k4jdDPizTR1GoN7nDE8VptVf3G5DPjMFrw9gWtCToypSE2NKZdOyCYRmRIlJcIh/k2lhsqHIKcIfOqvDroLBg4mKBHTrRCChqF7Dse2E18Yv+SVF3IJNMG58xi/KxGB7pXqV1KR8WVxv+S6laLfrRJ+8ULYUaGdaJ3FRreLz6kZ3gZ5Cql5EdLwdCWi0ICF3TM60Zm5/k2bFHO7rW9iZJaxcpysu8irQJjH3Y4Cpc7TEQrHkQ2evDTUqHXHmtd5KoI8h5AoeA094bbTMWKjcKbLO5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7567.namprd11.prod.outlook.com (2603:10b6:806:328::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 02:46:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 02:46:29 +0000
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
Subject: RE: [PATCH v5 06/13] iommufd: Allow pt_id to carry viommu_id for
 IOMMU_HWPT_ALLOC
Thread-Topic: [PATCH v5 06/13] iommufd: Allow pt_id to carry viommu_id for
 IOMMU_HWPT_ALLOC
Thread-Index: AQHbJzivjVz1nRvBi0SPfInHDcQ/5rKbeJew
Date: Mon, 28 Oct 2024 02:46:29 +0000
Message-ID: <BN9PR11MB5276C669AE11D94CD2A1BD1E8C4A2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <4f5ed9d75c23a503ffe672a85cf9010569652794.1729897352.git.nicolinc@nvidia.com>
In-Reply-To: <4f5ed9d75c23a503ffe672a85cf9010569652794.1729897352.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7567:EE_
x-ms-office365-filtering-correlation-id: 119dabee-565c-4cdd-260b-08dcf6fab9b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?rFH2ePrTv9MjY375oE266VJVxWeWdYbxxLc/FE+usdEWr55ufF8ji+EeRQb9?=
 =?us-ascii?Q?YBKULiT9UtWNwX1dc2Z8WfmOxUl90ObgLqueGai9Kx9A9GcNo003k0GkPx6p?=
 =?us-ascii?Q?DTVNnOoC74y5Y71agqLp1/XNLJo8owUeWiD9eOqxJsYkBF66bStQoAI2xkZb?=
 =?us-ascii?Q?Z++vsJwJLIwTZZTxTP5m5m6/Ks6dVMC8kcoL67QgOCQLOVopB154NwEi4/UZ?=
 =?us-ascii?Q?j3AGDO0JSZ6q3Mq5QRfK/x1cA3rsXy3s208cJY0OTbfiyUOC4EAlDSvOYGd6?=
 =?us-ascii?Q?kcxZHJ6EZ9pKmIJ5Xde1OK9GuXGiEsldYUp5myU8of7c3E+WdjKZQN1XyFU8?=
 =?us-ascii?Q?vP6FsSZ1xcQCuxgMenEbH0xG9thVuUlCWwJZIpDFSlMfVjAUErwH7sxmYEAC?=
 =?us-ascii?Q?j1krUnwH5RJ/vCkDvEArlUddcmbHGYAZbUiUjI0/1hBw62Py4U3/nG0q1NZ+?=
 =?us-ascii?Q?kFG4vsGERhZTurwebuC4dp9klJGZgCWG+/IVfwQlqqEWjJfmL/jj7l8Z5tMJ?=
 =?us-ascii?Q?ydsH62RTch5GHMV0ThNu7Ob7OmAw2fX8WeYD2gw+9P2wr0J1Lba05HzfZnVM?=
 =?us-ascii?Q?eU+ReCnp4l/3+lhLWtC9vZWu/SpKjbIn9qLUvXM5vAIq1b23rA0el8srX8r8?=
 =?us-ascii?Q?o6zY1N+YkxQMETemI/DfD9UHNHx3hA/Qlo38vtKbfgpcaVQM21V++SgR0tQT?=
 =?us-ascii?Q?obi19tqlKpsVPp1XbrkryLcXAsDcU0S93auubBxcHujxTY/hPcW43tkAkpF7?=
 =?us-ascii?Q?q7cntONG9FHQ9RgqD+1tv+Pvgu82GZBOujFNVpyFfYFvF43InOv516i4J7sh?=
 =?us-ascii?Q?OM5TBXjVw1sd1FHEjWVW3fGJhtMmjJNX0mywyOCLefn030RSCGBTW/+6MWKt?=
 =?us-ascii?Q?Efrk5CUsQfhjE/Wsory5/A2teAzCqAzyEESYQWriPO5TKCYKA0V3GKJ1Zvzv?=
 =?us-ascii?Q?fdEE4Pnzik7DXFmLiD6Tg9HAgzMoYYtdk1bvad69SHrwlGmw+4gZOjaitezO?=
 =?us-ascii?Q?bRN9ZPC9uVpmy8a51/nIml5z2nhYRfFEl9rUiHJMgD5HGFiAooiqcKyYHeFb?=
 =?us-ascii?Q?2sESIF6Lls09Kh1k2ggjtQllNb6r8KGYSOf/f/da2Kb3a3U5njc2513hZj/a?=
 =?us-ascii?Q?+tsiJ+ZEx65sVtQGwlZ1NEgOkPmPkuR1kXpsrJ4rIqzF33OEJdUt2i4TJi94?=
 =?us-ascii?Q?VYzcWtbYGqCOJCkTd6O9AikgP9JAm1B9xDBglsmUcTDPRy/zt3f/1xufsw9U?=
 =?us-ascii?Q?nsBWvrRV1SLCThGx5g0eZ08cwWYHe4FRX22ZpEaIvFBmAMRW4iAuWwwsbBrS?=
 =?us-ascii?Q?2aa4Rnigm9m744LYvzlzSHhmpqlUocKypXkmbELtQ6+dndtT6suqunbzplgA?=
 =?us-ascii?Q?/arGPK4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UOvxI3MiV2tTV3OOHpQutbNyD0Zor5RR7jaTW8P1v7xvlA9oOU3rWM9XiJKu?=
 =?us-ascii?Q?B5GerUjw9+0R4FcbCccj39Aw5dpcK4A08eXFgehXPPrjkIYM7msV0UmFD5QY?=
 =?us-ascii?Q?/XSUgObBfe4bZVuOxO4dKF5087s5lrv4i52axk6n0UrRdaL/vOFmWmdoy7dD?=
 =?us-ascii?Q?QrOlDcWIEC+c7HL9tNYZuUf0ROWsLvUj4Hf+tmEGc9+LZXvogj3N2bi/fIxr?=
 =?us-ascii?Q?iFZr9LmJP4G51zEFs9zANRgqA0Wzkdc8zavzKf1poQNXqWdB1zbp7+r1ZxiD?=
 =?us-ascii?Q?Gm8CX2FCHxBvaNbLuuWtCLIp0Hr8mNOcnNLZNOurP4QGUYeSjsGOjcdRQ/1c?=
 =?us-ascii?Q?IbZsEaUJi/K5+oAkOQOkelyr9o+tbLnlJZ6KWGxUzr9DHvqetq5cYw7mHfHF?=
 =?us-ascii?Q?g3fF2hljzUQVa5/1V1Qlvkx+N/TdJQMp61d7aOtcl/Alfpg3vYh3JfLTgHkK?=
 =?us-ascii?Q?1Gfl7bYUwQP14PWWz0g+nxDYzXbXiWAzbrGqRj5TlmGfLPTJIVkZ6zAB7Q8n?=
 =?us-ascii?Q?Z/OgxxROBMMO4iQmWPR+kZ219oDexvaHq6HD0R1J8Jyrdih9phOlDAoLJKTv?=
 =?us-ascii?Q?Ep7k8x8sY4GRBigbcTNlvnxoBqnquWBZkwb6C1XEqZOO7kLVucIlOoXt94W+?=
 =?us-ascii?Q?LM5CAKW06r7XuDlCEqizxJCQv8wUBWNE+oM/rxjMKSMPVCyMSuh9NlqKL8ho?=
 =?us-ascii?Q?W9EYZA5wF4kjtsnDT+gLDNiDtjXWfbQGEhkFp2i/vJjvK1IVVWhvLL53X5o4?=
 =?us-ascii?Q?Y5XmzDY4Lu1P3ZdWqVXc3Tk0K2JWlbOaiy/+eZ3LucBQmUDx6lZwq2pCbaUx?=
 =?us-ascii?Q?p8iyqsodnt6XJyNEa3idLNDzNOhvLQh0Rqtax2feBUyEDNjK+eU9/2KGqsYh?=
 =?us-ascii?Q?SNuCM/ldwwmfPXGa+JRx2sW1H7FgCuFyPaNy1vH8nGKVn0ExuTWEuJwMeauQ?=
 =?us-ascii?Q?3dXnn3ggsa2xWgvyltpbaVaCcyWh1uZnYVUpT+/HyywOTmO+iZfHtkLmwuYu?=
 =?us-ascii?Q?1xLNhu1v/sHNyrXWHEzzCzqqAKb6eLDgBQ+hKEl34Shn4JSoc1upY7yIK97y?=
 =?us-ascii?Q?uZe9f3EyInKiwDKNqHw8mCupg1v1crqcEX9yg88RwKda2xf6yHMRQ135g7nb?=
 =?us-ascii?Q?xV2n/uWpvZw1LRYzjY0SNFR5APF0NNdseL0S/1jzWJFf5Ddf2tqx33EDLQTa?=
 =?us-ascii?Q?dhYompFhCMH9H45lRNIh82TuKIfZPIHw+cQkU9XSbt8HKsoRSm7My0boabSR?=
 =?us-ascii?Q?j38NkdwIf/QhplsKMcfkkg7Te+qgFfFkDL9QAcFdc0lR3rslE6v/a4y/LvMb?=
 =?us-ascii?Q?D+d9+vpfL2WzJjVp72MKmSg4hg6G6SsumL1MKt5NRV4EJzjRhKvlVln47KKQ?=
 =?us-ascii?Q?s6GK0Vjg8YCV5XHqO5RqsBz40QVpK/+kSBGBAnv5cSYb5lpzGk8Ubig/WGD2?=
 =?us-ascii?Q?EwxSzdIUldYMz9n+sskr+GgBOMm+PuWavuh44WMS+NsAplZ+NoD4dXnZ6gHb?=
 =?us-ascii?Q?JWGUfXYG6hHgKre1jdFjA6biujXUpJ8ZC5B3J/HjkF/UZEEODbzC9lKGhlUx?=
 =?us-ascii?Q?lpf1bQJa6V6QuQLsQp+xvcx9v2e0qXb4/dFa4L2D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 119dabee-565c-4cdd-260b-08dcf6fab9b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 02:46:29.7534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sxy4uXerfvf+bDoLidB218lBV2ScnTZ3XOaHSkAG0H3amKhRh3TFcg4oioDprP0e2Dg/kcjlod/zKUhZPXitLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7567
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, October 26, 2024 7:50 AM
>=20
> Now a vIOMMU holds a shareable nesting parent HWPT. So, it can act like
> that nesting parent HWPT to allocate a nested HWPT.
>=20
> Support that in the IOMMU_HWPT_ALLOC ioctl handler, and update its kdoc.
>=20
> Also, add an iommufd_hwpt_nested_alloc_for_viommu helper to allocate a

the helper name is not updated.

> nested HWPT for a vIOMMU object. Since a vIOMMU object holds the parent
> hwpt's refcount already, increase the refcount of the vIOMMU only.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

