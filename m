Return-Path: <linux-kselftest+bounces-42448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C56BBA2DAE
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 09:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2305D7A495A
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 07:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D178288527;
	Fri, 26 Sep 2025 07:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nEvr8mYe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C1C27B33B;
	Fri, 26 Sep 2025 07:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758873010; cv=fail; b=pAyQO1wDNDwqRbGLuWWMKLMy80U4I1uJcKsRWGvWWUk8ozfee9G5pPq9ytzcmWb1CLAkIkmN6zDflh+ABe4YCIWMxirpQhTi20FUOjlR5dtgZz6L2VlIm9Mx/bRZl+snpy7tb2GwdTxo4fMvSzJYnONPXy4tUHsVNtjuvhk8KMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758873010; c=relaxed/simple;
	bh=+KcQPgLzCJlZDj2q4FXRGsQcMj0N8LD4IMgT54z4vFw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q/YeVJshtoZO8Et2NmxKS4BT//y/B9Dxuz8GCaXx5txkxYCsITZFw9hg+/Ep7H7TElixKVNfK2CU6qoZMpRqMchmwgVPGRUp2SCJS+Um27TluFAKVktj4p+eWz8cHU4g0N9HmH74oAqyGPKJjUcrDsoA4fx1EhNi/DZmHLPPvEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nEvr8mYe; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758873009; x=1790409009;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+KcQPgLzCJlZDj2q4FXRGsQcMj0N8LD4IMgT54z4vFw=;
  b=nEvr8mYed9g32V9WR5ZZW3cq7sYop6+J3U2oP2GvyneRS63RSAgWjLLJ
   fMzoJVGst3JjHbo3ehF2o9mBvawbsgt8XjZhwolp2U080jPcqBrvxo+Gs
   qIDWfwncRxkAWYgN3oCElYzdvhfQmcaQaJj0cH7FaRuQOJCtNH/yjtNq3
   UG7QvE5QXvVvL/Gsuuk2T+Mo+xJ8VctAMSrclrF8JnkCHaHN+rTqZmLyB
   woI+IsvDuw/Z5qTUvFZPyQQa6cafo96tF0z9P91Z0RbhnZZUZ39UXfF3r
   qnaZi1bYf4RHGJQMuwjX32+3Pn8QeUwCtDEFpR5qMzeXlhW9/NcUjUnM7
   Q==;
X-CSE-ConnectionGUID: tQRORVAkTeuMFW/xCkENew==
X-CSE-MsgGUID: Eu+dJrWZTh2btk2F2KUX2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="61090891"
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; 
   d="scan'208";a="61090891"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 00:50:09 -0700
X-CSE-ConnectionGUID: m+IkztBlRgCOeK1DXECBqw==
X-CSE-MsgGUID: hxMGRS99SKe5cu2LmP9pVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; 
   d="scan'208";a="182824778"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 00:50:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 00:50:06 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 26 Sep 2025 00:50:06 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.46) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 00:50:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igCTU5paQYo9k1sFv4IXLkAezMo2jXsD7PpfW2LmTUnO/bfVF2sjL7gn8sf7HzfyYlUateq3l8w318cDYe4r7xo80H42PdwHxzW68QNHFgS2KSoqJqK273nEpgV5he4EVRbrDfhlAfMAEn6jxyIFvpU9XjaPJmBiMbW6FrlbRV6N3ylSM3RGg2UvDzoDwnFEVWl/b6DJFVQenxaGXqjjFkjwqVAOhhMj1GCUublNi6TCYepe5dXNoX+R8Ukg80TVRnW5q+zI7oXaE98nW8+8O75enssqO3aYH2ChVE7MeigT7QE2LOrVcNomi+ayZ9h2yGgxzb1cqrS2PA/BDqYoGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7GfBfqg+wq+WhjSD4Dlx2zyqogEaUu65vfKaOF6H3k=;
 b=vBm0+F5AziFvTReY3U6NKLnk1QbPjyYptC1CPDrklAaYxJ/LLFvvjlmErHhGwB5y117G+zTpW+OH7EpmX1Uao6Tzh+AHHiB8LsvAw5mveSiBcRvsEFY+61ei7P00K/n7eG8MxT5O84Od7BkUbHfcm48I++Rs/CqUHw4/8hjxEx1OZiTgZcPjI/0UCj3CNSWXt//ubT0Uznz+C46KEFYCjEypinQkNNko+b+kV1w7Dfl2/y8xNAF1Ye70ZCCMbMzXJics8le1zqiWxqWapviZMZ5Z8Npygm6tgT2LvxhoWdfnv/0NNxYf2Eia8QdiCrLY3qXNQHo9Llr6ZkdAQkFtqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8543.namprd11.prod.outlook.com (2603:10b6:806:3ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 07:50:04 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9160.013; Fri, 26 Sep 2025
 07:50:04 +0000
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
Subject: RE: [PATCH v5 10/15] iommupt: Add a mock pagetable format for iommufd
 selftest to use
Thread-Topic: [PATCH v5 10/15] iommupt: Add a mock pagetable format for
 iommufd selftest to use
Thread-Index: AQHcHPrFzZCp2/7rA0OgASNP0Una57SlOkKw
Date: Fri, 26 Sep 2025 07:50:04 +0000
Message-ID: <BN9PR11MB527616FF92CAF5F0310474108C1EA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <10-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
In-Reply-To: <10-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8543:EE_
x-ms-office365-filtering-correlation-id: ecd26fb7-c96f-46c3-63b2-08ddfcd14df0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?v422nAQWd0rlf+049bMe8zOsdo899LYIbkkL7sgGA15NDdZYPrqmzf3Sb94w?=
 =?us-ascii?Q?jNjjaMV/IIGMwwYY4oe6TMWMRyibU7EdpltrO5hodRSIliuezVW2MPPOmzR1?=
 =?us-ascii?Q?+qMr+xSlzPSRACqiigl6VTJaToyGDEKtruoKa//6qSqRbWN/MsAx6V63iyRR?=
 =?us-ascii?Q?k4Tgt1rJhMoSmPlIesrY4GysK60fMj1J2HgpVnxlxE+0KAgQrHCLGX47Lmfy?=
 =?us-ascii?Q?I4UEtqfv9mOB+CbJEoVVX9NYxzzxd6FpRJcNyVNN3TXgRW1d+/Jii+/qJESs?=
 =?us-ascii?Q?S4YNzk8vgyudEW/GzYw+ttplZxPU5QddkW7orPjC3x72j0B5zuReuyrhTv1k?=
 =?us-ascii?Q?DmP0tZHjxB/66gc761pJ4gsVyR5faqMsWOkED4V1mhA4J8nBpwyvet/nBZHK?=
 =?us-ascii?Q?x3l/QjjnfBXgZdpV+VYwj7kF0wsRjDaTqyfjaDV35Kq8L6tzHq0P/u0HFOKb?=
 =?us-ascii?Q?d26sR2s+Gl/cCVRlMy7aDvP4dse1ApJY6IH1rGqOXxJc9KnbxpTQWMNMwYvb?=
 =?us-ascii?Q?mScEVrXVthpquxpTo33OmT+ocQKTh0/ukS4546339N9/f5zkW1ecwsDFnaPd?=
 =?us-ascii?Q?o48oR+3l8nxbqHQRmR9CatSryEYe4WExIbB0ZB4RJHQPFQd9yQwrQBI+ySvQ?=
 =?us-ascii?Q?mLJOuES5PWFzqXs5xyoZCE/FaWvMAq4V+a0Kn9Q18e+OkbPPd/druaLP9xNL?=
 =?us-ascii?Q?KRVJgcSUtZYCAPC3IFUG/IirpxM8i3weVHwV928WSVp7aeficSogejQelem+?=
 =?us-ascii?Q?V37MOrpCOio9k9Lkx7DMB5IiGKukX0SeMt+YnLvVr46zYp7nZYlVWp2uinWl?=
 =?us-ascii?Q?aSYXPa0nlx/UJ4pVnB20ZyPfSbljMJd6iWnCPeE9hFp5qJBDdMrIY9+MPAlp?=
 =?us-ascii?Q?yqMWuzsdhzmZsuj8Hh/YtakQXLre/DMuNE/Qx9y4IjKUOrZCP+uS9/mxcfLT?=
 =?us-ascii?Q?EfzINg+4n5DSd55ggH45+u+NxV8CAYolnlS10Kc+K/UD++kpGnvYcw57miJ4?=
 =?us-ascii?Q?VoYvEqKINIxiglHfp6H4XvfEt6+pbwmbYDbFat++s3T9L635SQo6fD0oNO4B?=
 =?us-ascii?Q?AmtMv8wEEoYccCDo9CxPHMI43pxT81JlAX6w4Sr3BhJzZ1j/7jFKq5NOOMwK?=
 =?us-ascii?Q?hJuyZI/hnGDOaKNkZ3vxh+T5xGwZ3ONs9+iW/sEpdoLcL8HO5j4I5MVbsCei?=
 =?us-ascii?Q?2VkB3LvE91HZXYfJAmBpHOWZkNMHv/xupW/lY2OxnmyczcVzkNsQJyWY0X+m?=
 =?us-ascii?Q?hA4zVUidHrjFxH3SrcbunPoXrQlA8jBAvmugy44z4Kl/jx/QzVghmoZgsUiI?=
 =?us-ascii?Q?kb2n8cemx+mxiE0cgeAX0cSGE5nhBpDXxa8eiJ5xCqH1d4MULueX88Zwfcsv?=
 =?us-ascii?Q?GsIpLWQvMR86ULL3Z528qNegMrq6gYx8IrIv9vhFRwbjuLOvvicknqHeRD8Y?=
 =?us-ascii?Q?ZjV84sbloYzPO/6St1529hyTUX93+aR07Fy+cvaKlxWlRD6I+2xGlsRE2fcq?=
 =?us-ascii?Q?DJvLaApYQsCCnSM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+acFd2iR9mp802MhrjK4vLFaFbTSSZxurQ9laLjqzQsDnNdgct7PklhkuNIF?=
 =?us-ascii?Q?BjEVjGelUuRXeWanIaBjXwEQA3ur85lJx2ZoT5Ed4pGqUV4CtBIs/w9GYShF?=
 =?us-ascii?Q?QM2lx7qPsgyQhf9BQTGbKrUU37PkZ7HMbBjo6zhQsHH0aP/cs6h9A9fjBiri?=
 =?us-ascii?Q?XNMBSMm0ni+AqwwNeVQM2SEDeykCZOI7OIjNnyloqM/zAzcesU86+MOrA/q8?=
 =?us-ascii?Q?xD6+hwYtlMaJrPfq9DN4SzX/WtquKOsrAOr+RZdugYNFhH6pPiI5ZPYgXyxO?=
 =?us-ascii?Q?TiPm0/O7cvy8WHonj9Iq8INn2eAiOTBkO3Z1keBLCp4Va+1imuliKEIqCc4y?=
 =?us-ascii?Q?EpaWvdwJRekczk83KQd3AUOPMQqvCM40zER4sZsQHKRlWzIREvuo0IPpSRRd?=
 =?us-ascii?Q?v1rO90YA8I1NWNG3fkVQvXhy+oi6AyASILXY8MK+ac+Y8/tpSHM61OZO9zr0?=
 =?us-ascii?Q?vU/1A2xexPNQCRjpw2CySRsnptu6o9sWceR65Nkz1mDXEr0UlPHXf299g/Y7?=
 =?us-ascii?Q?APGDvT1rgy0qpIvC7UjmZhiL9iyIlUJ4pVhRzS0vhVUHRiMVsgzOXXdyg3tF?=
 =?us-ascii?Q?QBwzW3jC515ySqRiZDXTmy0oOTovWvmWl0DOxspQbzCBOpeKM9C/xsFsEn0o?=
 =?us-ascii?Q?a/3cO1fwKqvS0EB8VFFLY2wqAVGyYlOSBuzEDSbb88HV/JXNBn09o/Bf0vaS?=
 =?us-ascii?Q?ryVpyymb0kJtO2DM9X6CCqCM5hx0XJtBXGQcZ1U5s8d+laxwwfsHNZQtx+Rr?=
 =?us-ascii?Q?BuFhFuRx2mMuBh7Zji/Cct46X8SUbYXtQigaHgofvn/RWxD4GBSJaf4rjbqs?=
 =?us-ascii?Q?wccS73lBI+gwyWS0xiV+hemS80NuAIw2IgYasyuX7sC8Isojas44GIZ2GKyE?=
 =?us-ascii?Q?r8KTJRFQJunuDQUpq/Ti7bsaSJ3FdWg6SAOhKKeV7Ks4pKx43CECfKBdY4Xt?=
 =?us-ascii?Q?nmChr6Z9uLzTiqvkM/6QHHJIJMecMkywfHXP8KyHhag3bAVr1ofwp2vYfovJ?=
 =?us-ascii?Q?xUZAyXn5HWSkaI7gYBwSPZfb3e2ZtFViPYbw4g29c4pqtNNPyRHJyMuq0td/?=
 =?us-ascii?Q?A3i5Dxcqa82a6oiJsn4LPrVXy7Vs1uSCWN/Pz94iYvqlU5nBgFXLAVElIclP?=
 =?us-ascii?Q?FDz+N1jbHPI362JMgfsA2K+SVPyUkCsfMrlgWT6/mHT7xcArKOGr/1a1RYy7?=
 =?us-ascii?Q?OztDs8vUNhIU2AK9+3lMyVlqe7dOTUufKLTk1XZxkJoh4gRbBieU8IyD+x9L?=
 =?us-ascii?Q?+2am2fUK20jJZo4eDR2UKaOiwfWfPKhMqQwInN4buOJO54b8kwuZGax2eaIy?=
 =?us-ascii?Q?YwgQXf7c7h36npap6KmuEcQth2kzggWYZGSZiGGwjwvltzGLOcafSbIzE/W9?=
 =?us-ascii?Q?3mRj1a2mnLOCJzF61zy+thqz0BQ/0I7pjrtPf5AIl3P4etnp5jKX3tkidcQQ?=
 =?us-ascii?Q?tnOXzt+gzyRjMvoFKVkbmcV64GnPZ09rgPPeXRM/7S0/maFmbNA577PDmA62?=
 =?us-ascii?Q?vzKWvbmQTp3MmyPdQPEUlpmTZHBdPzJTFNAQ9v2tXfzzg1hS26Tv1sKM9k3I?=
 =?us-ascii?Q?shYMLbp2uDwZWlRVNGoxfhdnV7PBmzurb28k9QgQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd26fb7-c96f-46c3-63b2-08ddfcd14df0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 07:50:04.2102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5/vtwtX1gUp1zh9vEdGgbc7dLymgwAICsUsnleaBk3DB6H9iENpO/LV18A5WGDDq7wJFKwXGW1W0+s79/XlhDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8543
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, September 4, 2025 1:47 AM
>=20
> The iommufd self test uses an xarray to store the pfns and their orders t=
o
> emulate a page table. Slightly modify the amdv1 page table to create a
> real page table that has similar properties:
>=20
>  - 2k base granule to simulate something like a 4k page table on a 64K
>    PAGE_SIZE ARM system
>  - Contiguous page support for every PFN order
>  - Dirty tracking
>=20
> AMDv1 is the closest format, as it is the only one that already supports
> every page size. Tweak it to have only 5 levels and an 11 bit base granul=
e
> and compile it separately as a format variant.
>=20
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

