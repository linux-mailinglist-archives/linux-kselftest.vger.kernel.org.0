Return-Path: <linux-kselftest+bounces-34642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B1AAD4C84
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 09:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291151896494
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 07:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B9B22D9E0;
	Wed, 11 Jun 2025 07:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="memtE4D2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F78A923;
	Wed, 11 Jun 2025 07:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749626657; cv=fail; b=VnYOp3Ow1vENfVIcHkkBnxn0FEJxB2TA1fXxeFmNximvxAAm7D/o6hERezfIwE1nRC40P/fKxj6sF0t1ByDugIvsNWUSMIE1Y81BTGuV/wK58n72qv+PoZIlMSIp7R6iBXKj99M0qNeG87I7koE8OrvoScYB2czlGFbpb/MtiK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749626657; c=relaxed/simple;
	bh=P4n091rrB/i9vMIyjSVY+AhJ9DnEmI/hCMZvCeMDMK4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OomDjK6uLT+CQDNrqYnFlnSBlD5FPOAKdj8mnByaZ47Bm3EC0aA8zg4gvXF61crOyFEsmvVu397xV8smqkrUwjXZDRzMQIiP/llYDci6K2LcMQ/0H8JsMKvcMaIHRUuzXxQk9sTtG+51VdpJpSIvRBCe8/M9eZjeGlOHtRC+zU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=memtE4D2; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749626656; x=1781162656;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P4n091rrB/i9vMIyjSVY+AhJ9DnEmI/hCMZvCeMDMK4=;
  b=memtE4D20nu4a39tqslTsz9s6us6HzzWyuT+oO6meC2zoxzmfAlO2DZp
   1cw1PmvsLP5B5JIws/qixtuzI1uQBOLBtKBoPEmUKOMWyZgPxSH1TwbzP
   TZDIlOU1iA9ucNZgzEAFUqCH0qRtzxbRNGSrF7KQ8Jr2Hz5NtpYp2Uy3F
   mhQRsyg7KZY+p0MuooPHk8FL++nI8ndWuhy8fYs7RHKh+hoYjmmolnew+
   NOzM087aYiEhf2FtJFyxK3eY1NGeMeWLb0BXTbFrSvzcVS4/S4CsGvCGo
   IC6WnahrfRLlVnih3zjCf4jkSSJbjMG95WnxzZkHmzpQC7CVtCecqXPin
   w==;
X-CSE-ConnectionGUID: JzkBmtyqT2q2upllYtBriA==
X-CSE-MsgGUID: c3Ga4M3MQ5mCkQd7D7RDtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51618500"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="51618500"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 00:24:14 -0700
X-CSE-ConnectionGUID: yGZEb1cJTHK6vKhuERV7wA==
X-CSE-MsgGUID: 00EPSSk5TeqDM5aDFQcNiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="147589018"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 00:24:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Jun 2025 00:24:12 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 11 Jun 2025 00:24:12 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.41) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Jun 2025 00:24:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6DoLnSuviXnoJ+QH7W85w1MiN4v4end2UhTYm4eHrTbTNhSfCLMc4BwiR5Vbu0kFlyosC+vQC4p7IYTuBgAFtdpXja+D2g3ciH17k/6Tn4GsHwIinUc6n3oKJwKaU8AyAevf7PQ4aSDsexDGXgTtsM/hnVa7O1FOM8Sky9dVe5BMN+wzvOR7M4F7PjERB5Kk65nCSI38GRWvmpi8tA95FU8Ci3kK8A556Mrgx6ovdci2q6YEtsBqTgAcfVC0qumYfCgIyIrTzpfUFVsIQ+fSmIrM5tHPU50CqpmK/ZrLhllPAcQ4lIF27wifqOryWAmKZ6wC9n2EiZdhPcbXQiZ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+V5DD4e5su5WEQwb0Cktuc6w1kJVQUa56pfxuhdD0L8=;
 b=IqPt7Hpu3yCh7B1IHAUL7bLBeVkMC/dSwZACWhipAP2iDNDYVFA/0+VXePD/LY6bF7o4SR141EpTHOg0nkN+SlcVCjTm1e8x5WI9eSFkR7EAJ4iODn1iAslGwpMRr5URDTsOUuSELUCN5R596yfcJyGh482anid98q23LN3WhIINJ+x+Zb/FThiLAveVr4Skk23jisdo71X+ovKaCMO4T2yU+Kb+hJvTkdPuuNyMUBpogjPiCKyIS9ljJ3pCEifFQv1ALHhQ7dhC/uYWzSIGleE5Vf+bBk+eqASZiqJ7wNZuT8hwoqbffMF4mj8SPMd55cjo7MLf4x3+FrJIS7jvfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MN6PR11MB8169.namprd11.prod.outlook.com (2603:10b6:208:47d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 11 Jun
 2025 07:24:10 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%7]) with mapi id 15.20.8769.022; Wed, 11 Jun 2025
 07:24:10 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Stanislav Fomichev <stfomichev@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "skalluru@marvell.com"
	<skalluru@marvell.com>, "manishc@marvell.com" <manishc@marvell.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "michael.chan@broadcom.com"
	<michael.chan@broadcom.com>, "pavan.chebbi@broadcom.com"
	<pavan.chebbi@broadcom.com>, "ajit.khaparde@broadcom.com"
	<ajit.khaparde@broadcom.com>, "sriharsha.basavapatna@broadcom.com"
	<sriharsha.basavapatna@broadcom.com>, "somnath.kotur@broadcom.com"
	<somnath.kotur@broadcom.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "tariqt@nvidia.com" <tariqt@nvidia.com>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>, "louis.peens@corigine.com"
	<louis.peens@corigine.com>, "shshaikh@marvell.com" <shshaikh@marvell.com>,
	"GR-Linux-NIC-Dev@marvell.com" <GR-Linux-NIC-Dev@marvell.com>,
	"ecree.xilinx@gmail.com" <ecree.xilinx@gmail.com>, "horms@kernel.org"
	<horms@kernel.org>, "dsahern@kernel.org" <dsahern@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>, "ruanjinjie@huawei.com"
	<ruanjinjie@huawei.com>, "mheib@redhat.com" <mheib@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"oss-drivers@corigine.com" <oss-drivers@corigine.com>,
	"linux-net-drivers@amd.com" <linux-net-drivers@amd.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"leon@kernel.org" <leon@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next v3 2/4] net: remove redundant
 ASSERT_RTNL() in queue setup functions
Thread-Topic: [Intel-wired-lan] [PATCH net-next v3 2/4] net: remove redundant
 ASSERT_RTNL() in queue setup functions
Thread-Index: AQHb2itimoBKcUg66EmM61zCFYDEQ7P9jtOg
Date: Wed, 11 Jun 2025 07:24:10 +0000
Message-ID: <IA3PR11MB89868956679C54BD4E291C2EE575A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250610171522.2119030-1-stfomichev@gmail.com>
 <20250610171522.2119030-3-stfomichev@gmail.com>
In-Reply-To: <20250610171522.2119030-3-stfomichev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MN6PR11MB8169:EE_
x-ms-office365-filtering-correlation-id: 5498af33-4dd1-4519-a26e-08dda8b8f592
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?MYMK/pMF8vEZkJtvAvk+V6K2K819zR1D08VCionXXsM4aJ5izuCgTjWkWHly?=
 =?us-ascii?Q?lcioSoPXgtCw/WvXXhzfow2oROYaQmH4dRPI6IK9GYcknB/f1ukMibcXqb2j?=
 =?us-ascii?Q?EkpLsIRiqiTuPOiqVQRQQ3bVUJIfo1jaNsW85irWzoero7VlX5Y8H5NxHLR2?=
 =?us-ascii?Q?c/FaP11ML5WlV1DD7w9GsRJMwCOdQttWbO37KPPhj67CUUXNhUtZax0L0OZT?=
 =?us-ascii?Q?BUaReJzgbvcpc1cN/eKCEroNvLQnpstBCPJjPUnNpwKcBz9v8KVZAvMAKE3g?=
 =?us-ascii?Q?0RuGggtuSBU8TZbqeNHUZaB6L1VvL2PwEYlKb2OaT5wCY7hVXl/O0PNrINBz?=
 =?us-ascii?Q?IpcrG1ZVTjU+QjACbZLMK2FtppccGPxY5xDQQ2h2v//qac+z+Tgq7n3XBKEw?=
 =?us-ascii?Q?6pHuO8g9gDXiY/72DMczQADUNWG3luxQ3k8rK7ct+p1Dm+SBlKXjUUao1RlO?=
 =?us-ascii?Q?zQwLw69zwRwp8U+ZZFGPCZGfaB0h2DahgG2Te1H2EslgzrRahh5mg0upgZvZ?=
 =?us-ascii?Q?9/duVq3FnhkHtduBYYQHcSNUudjyxhcfcX9AA0cImFA6h10YIwAPzH91mbpL?=
 =?us-ascii?Q?aspNFKysBjkkBZbCnVraIYYM2P8MiylA9CVHnfu+p3WzdD6CkpIoKDfmpICN?=
 =?us-ascii?Q?rfUfOzW3Pj8wiIQ1l1UTlOSRSpWSko39PoRXWFhpanib2gUGivxHuNQpACeW?=
 =?us-ascii?Q?t9jDLF6S+Q7WGcg4iXEbfladeFkpiiHaejsg3UO4yJMhsxQpF5KJXNG/PlEl?=
 =?us-ascii?Q?ZInHgmg74S2LxG6P1EAlaH3OEnSPlNCD2wkweySSBa1OnrAC22Ih7HCCPMnC?=
 =?us-ascii?Q?b/NbFqz3RYZnJ+X4dlOvQt3SwUBK4PdhcIs7/O/Vf6SMg6hFWRvWiosOu6eh?=
 =?us-ascii?Q?y3Tcz7TGqaLTke0qJHHUs6xoUY3GBKBM+FAAwnNj29sP7bHZ2o7ZXdhQT7IW?=
 =?us-ascii?Q?VqPs0GNvKK6ONximiYxFLfN8h/jckuesNB6HIV2dl+rVloHWWHLhihpPTF1x?=
 =?us-ascii?Q?9TwghEEdaT1+cMDnP7vKVLALLLduBS7hNsG6QRCSD3UxoBdHQ6rpsQnfwIRo?=
 =?us-ascii?Q?dZn3VG9sQyWzBsoM/IXHTXEhO+/DjIFAiBScOZVapdT0FPn7DxkAWIIu+G+M?=
 =?us-ascii?Q?76b155CJunw7QB2ZIiuyjTw2CAIDVd37uvzEUgNLx1S36iGeVRhuRVW/V6Hl?=
 =?us-ascii?Q?XwlbBiD9twuY/EpCaIG5/vPUBxdlEiZT3SB1W17L1yIPwRGYc7x7Z/7TGttM?=
 =?us-ascii?Q?XY8CJ7j2PYBwLpikqHSMtCOiBD1Br+aqEj+X5FclDLdBSxDAMbOvAtvOiaol?=
 =?us-ascii?Q?we+nfxoTWvyPNTYP9N2NnE5+eHUz7oj/dLgA/cFAZRdHSc+brul0iyJ0WWBX?=
 =?us-ascii?Q?4upNB7FIMhmUE7Kn8WKqnqJlM4SnNmMMbh7ymP8COj+xcS7JieLM1xDvy3ig?=
 =?us-ascii?Q?hB5MDyUflXaKQsLeoG/RvtA7x/tbFMlPxwN83bfstykjPR1mGS3agw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YTnP0AcLfLJd/7jX6aUnlebRo4C9HEO+ch2nzhQoKlhHckiaEPoW0UQ9AXEg?=
 =?us-ascii?Q?OGFYogrKN5eB+O2TV+GgKHwhAdfA2fGM81nSDnK2NudTf6R7FK+f0nM0AKQU?=
 =?us-ascii?Q?VCVzdkdw7tbLqxgFJXnHScwbclNKtycUTj793++M9G4dG/SCt6ozYo1X2vzy?=
 =?us-ascii?Q?MzwZNxKw8T9wCD7ImIiTGhORgBk6+6AuUGAsJe+NAkSZbqAiSlr8lgaX0jzo?=
 =?us-ascii?Q?zpA5STx78MuVZEzym/123M7imn/FbAdbt0bGGicfSmfHcmmffffZtzoi2iIC?=
 =?us-ascii?Q?VRBDt3npZ+Qp9xuML0wWAWUzOh5KXY9SQgMq4yfJaC1NigyxQ+EW/pLdZsq6?=
 =?us-ascii?Q?RXFh1FAKkjwLPwT+9pFUr8siky87pgYr6f4y7ir1SqSLdkXcmOfCiWHazT6j?=
 =?us-ascii?Q?Yp8y79mlIbiqnGSVMM3CAQ5xPuq4il0A+tT/A71fLnlp0SEvpB9oew3PrTg7?=
 =?us-ascii?Q?Ga7zTOJghE4F5aI7/NtjKfEmba1utDY/hCDNm3Ofpph38j4lrHV/1917yT+L?=
 =?us-ascii?Q?PYY4dqLOIJIBvioqY1KX2vfdGzul8HLGKI/jUyWyLcVemCfL6ORQcgeprTrF?=
 =?us-ascii?Q?+MD9QpEpYcAf638iHrVQYNwszJ34zFLDAMPgIKEJ9sCjR+YIoAr7zHyMKnBD?=
 =?us-ascii?Q?ess4HF94O5iMML8BUboALz+OjUomVXR1t5dTZSKdNLekOi2+9jcKHW4cwWhu?=
 =?us-ascii?Q?8QIPG5elYu5e8erkJt9IrJoKhYKk3M4pBSDu0np6VvThmtLv69exTln4FhRg?=
 =?us-ascii?Q?bzZUGJCel/4XPiBTimd4zK7Px3HbwTgp+6rtzp4+jzYje3J3+pvJZcoS/l1P?=
 =?us-ascii?Q?aEpsxBbDB7A71r9UfxjFuiEMofx2HHZIY86yvWhdGiefbxSA5nOXtAs1fbi+?=
 =?us-ascii?Q?8rD4bymsdvcCSTwr8xi+UvLKXN8SWm388xoO/mVLDAlwJgWFCPWRMFxKxKbr?=
 =?us-ascii?Q?wQxRqQPMUffEwiuI5ILFKUycQQJnfRCUtT8rK6hfUlDOXy3mC6Bw+yodA07c?=
 =?us-ascii?Q?2jFHbogWKGnq6l+rvjYSEcq9qX9mK5GGhZso9mSMHVF5EpRwUpvKzDI3iUl5?=
 =?us-ascii?Q?KSVq+ZJ2G4a+u4F8egly+Iz8T/pQR6kYDsSY1jqSxfGWvGnHF+dvkIHYNgzS?=
 =?us-ascii?Q?+3SOIwK1E4OymNpqrOl8b47M3sb7Uqru7E418noprMNKQtseDdQyW3zdW8os?=
 =?us-ascii?Q?s4fFPx9KEesP0MmFW4PV18DTxcYrtEc4ldkVvg0LtUmFWcgTJvbATCsCtvIF?=
 =?us-ascii?Q?mMy8VP6peq8/qX6dGA3FLRyjissD6+BlMbScBhNric9WBhQuNlMkCUFSr2Uj?=
 =?us-ascii?Q?zj+HIHHO51Z18Z2WwWYaZQbWy1pfrMzvtZTgZtBSajIVZMKfiU5lI4kf/17B?=
 =?us-ascii?Q?y5Q5qQ8ShOUOyrudfoRKwq7cHS61i5zaVcea3aTD7NVDyEShPWuQAphSAwiz?=
 =?us-ascii?Q?TKT1R+NOVFd/hT0jfPNuVZy/h/Qc7CZF1m2ArwDAyAdLX/xMxp7d245hbXcH?=
 =?us-ascii?Q?hDNIcXdaq1mmdjkxljjvHM7AdDD5wMkgmwVI+3rcz/la6kU4EZh6YSWMDxwt?=
 =?us-ascii?Q?iAMmFnQntKPYlmBIZzx0Z0n/yFDeVYYLrPGja+zEQX8tvzJy/f31g91zUZyX?=
 =?us-ascii?Q?/Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5498af33-4dd1-4519-a26e-08dda8b8f592
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 07:24:10.3869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HtT2zYwuvUcHjBWJigaYFK9Lma1rDUDg8jOamHODo1TTfcXRwKI2cZMjDOwvjaJMIbkDiz6FOuzATyE7Qgy9TH+doA6MpZU3KgAGXu+fJ4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8169
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Stanislav Fomichev
> Sent: Tuesday, June 10, 2025 7:15 PM
> To: netdev@vger.kernel.org
> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; skalluru@marvell.com; manishc@marvell.com;
> andrew+netdev@lunn.ch; michael.chan@broadcom.com;
> pavan.chebbi@broadcom.com; ajit.khaparde@broadcom.com;
> sriharsha.basavapatna@broadcom.com; somnath.kotur@broadcom.com;
> Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; tariqt@nvidia.com; saeedm@nvidia.com;
> louis.peens@corigine.com; shshaikh@marvell.com; GR-Linux-NIC-
> Dev@marvell.com; ecree.xilinx@gmail.com; horms@kernel.org;
> dsahern@kernel.org; shuah@kernel.org; ruanjinjie@huawei.com;
> mheib@redhat.com; stfomichev@gmail.com; linux-kernel@vger.kernel.org;
> intel-wired-lan@lists.osuosl.org; linux-rdma@vger.kernel.org; oss-
> drivers@corigine.com; linux-net-drivers@amd.com; linux-
> kselftest@vger.kernel.org; leon@kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next v3 2/4] net: remove
> redundant ASSERT_RTNL() in queue setup functions
>=20
> The existing netdev_ops_assert_locked() already asserts that either
> the RTNL lock or the per-device lock is held, making the explicit
> ASSERT_RTNL() redundant.
>=20
> Cc: Michael Chan <michael.chan@broadcom.com>
> Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

> ---
>  net/core/dev.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/net/core/dev.c b/net/core/dev.c index
> be97c440ecd5..72997636b8ec 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3179,7 +3179,6 @@ int netif_set_real_num_tx_queues(struct
> net_device *dev, unsigned int txq)
>=20
>  	if (dev->reg_state =3D=3D NETREG_REGISTERED ||
>  	    dev->reg_state =3D=3D NETREG_UNREGISTERING) {
> -		ASSERT_RTNL();
>  		netdev_ops_assert_locked(dev);
>=20
>  		rc =3D netdev_queue_update_kobjects(dev, dev-
> >real_num_tx_queues, @@ -3229,7 +3228,6 @@ int
> netif_set_real_num_rx_queues(struct net_device *dev, unsigned int rxq)
>  		return -EINVAL;
>=20
>  	if (dev->reg_state =3D=3D NETREG_REGISTERED) {
> -		ASSERT_RTNL();
>  		netdev_ops_assert_locked(dev);
>=20
>  		rc =3D net_rx_queue_update_kobjects(dev, dev-
> >real_num_rx_queues,
> --
> 2.49.0


