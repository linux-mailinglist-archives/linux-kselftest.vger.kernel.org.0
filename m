Return-Path: <linux-kselftest+bounces-33045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10898AB7F84
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 10:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454A64C5049
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 08:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D9E283FD5;
	Thu, 15 May 2025 08:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xtqh6c9Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D63327A935;
	Thu, 15 May 2025 08:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747296054; cv=fail; b=KI8PBI17YKezn8PMXTFRFmWEzKD7ZnRzTWStLSczOwrA8Zo9jwpsz4/M0WPn8NFGUZAKfL9XSsJqPe80NXAssrA4f7pJVkg12t86X7ERTMGlogepTQ6gzEiwkh8iX3eHU6obtUMdb5cShf3bNAHZJpWGoxRuqs4vQczgDT9UPMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747296054; c=relaxed/simple;
	bh=8vYo2TgO6+CB7Xi4lPH0lZ0ICk8fKs0E4B8TWkvwYy0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SLneACH9HeU1U79/mGw6DlGYZV8NEIRmdwTidbe1S8/dZyY9pO2kPjwet6Zior9nX/DcaWyb5iDGGqj+nnnxhAXeVaOfgRFt1mquh4J1d2PTGDdDV42G+ihEedtkxRxpoWbyWBhdaTRe4bGHCi0syhsI6F2oU4F1lEZSoPBPuBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xtqh6c9Q; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747296053; x=1778832053;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8vYo2TgO6+CB7Xi4lPH0lZ0ICk8fKs0E4B8TWkvwYy0=;
  b=Xtqh6c9Q1fzjoQJxG7aPJosBnBKLMSBecHJZHR0cyJ4sgjQVJnBmH5YZ
   kaQ0q9nisomwKt4W0gg1HSK5Zomx5kJqsL7Iv8RxrXc2I4/qD4i2axQiJ
   Fju6HvcHeD6/tHGmpykDpVex/egPTT+GL/eWUJ073Oag6JcwQiYMxQJQt
   tKv0VHQi/+B/Uiyx8JKC6k8iHgChT8rp8Gl+eWM4dYT8Q7oL2BP8Xj51A
   FOdBXORPQ1/X5dfL67EmO34yIrh1xaJI5+YUThGnNpwcn7jMRhrGJgB5U
   p3Jc1oB6/oA4Tp1Y3phoKHn7faTsKxiSOk4o6igvu9+/XET6TOlfJ/p4B
   A==;
X-CSE-ConnectionGUID: hghZjr2zRyCCaAH/hxiS6w==
X-CSE-MsgGUID: /hSVPtHKRsSZq2dxVFSNow==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49116241"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="49116241"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 01:00:52 -0700
X-CSE-ConnectionGUID: dxZmblflRjyZPalpKDsdhA==
X-CSE-MsgGUID: MOWXtE2tRYq1zUJEixb8LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="139290217"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 01:00:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 01:00:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 01:00:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 01:00:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AsUdixcHCArIVbEXhJTpEnBR4huRpvis7wkHytqxfX0MldUAk5AYFC/gZTtKkQzn+6glIbgmmzpvnjSNsMQM5jAog1PYLulY/2pYsTqSLauJYITvItwHqxtvfhCSNJ5h8Zd3REMbqzUtXYkSR5eCoKkI+ELth5Oom1SUv/65fKj5R5d+2X56W/tu2Xh8kJWdIj+VKuGEnIwOQQCflDsrIA/z1AGrBzHOASZqNoJjJ7liqIVb9FiXoH9qz806lAx27j1IQvWlytYh17nsrFSvKu5qmOljQUfmDZR8blAqdkVU+nmKYajcGENOmieaAi9dcKgrxoWELBjj1ytRpNhEKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDLWWgvjZhgV9+K/iP9+Sctu7bobFqHLvzt7paqcogY=;
 b=JJa9kPGjj0Nb9pfNvSbD3NXpX4cuw4zA+i3x8j8GqyEOaFoL2RMsggT3XnHM/oA1StSPbQyPgBnDzlghMIRe0TfaVPgHcKtDs9QA9sS4vfF/sj72bBh5QNf3ubA5jG1vcmo8lHczOyjIVpOR5c1vjePserjGkqSzt6nKFDZiuHvBDQ/zr0mpHh/K+1MocT8MPFMKkMa17MLR8s2hMaZqY+pCNF0ifVXfq3aUnRbl0XUbtjZfUCl6N15WX8BSJNBvwMuiS10Nd1oHv3IJTVXI3koZTg4bg5sqDjAdn7DYtHB7KUr2Fa7j3kN6/UDBL4CPE+l5Gec9NVTxKkzh+s84tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM3PPF7C7D8332C.namprd11.prod.outlook.com (2603:10b6:f:fc00::f31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 08:00:43 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 08:00:43 +0000
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
	<vasant.hegde@amd.com>
Subject: RE: [PATCH v4 20/23] iommu/tegra241-cmdqv: Simplify deinit flow in
 tegra241_cmdqv_remove_vintf()
Thread-Topic: [PATCH v4 20/23] iommu/tegra241-cmdqv: Simplify deinit flow in
 tegra241_cmdqv_remove_vintf()
Thread-Index: AQHbwI8SeMucwdPuKky0w43xR3P9GLPTXbOQ
Date: Thu, 15 May 2025 08:00:43 +0000
Message-ID: <BN9PR11MB5276E43E56DBB09FA3D495118C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <9d4d85724f872033157ceb576bbfe92102261248.1746757630.git.nicolinc@nvidia.com>
In-Reply-To: <9d4d85724f872033157ceb576bbfe92102261248.1746757630.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM3PPF7C7D8332C:EE_
x-ms-office365-filtering-correlation-id: 3b986523-9bff-4a6d-ef0f-08dd93869784
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?lfRXLRcHjlB9WRqtG7X1FvdY0UFFPg+tWiK0FM1oe6KJn0zyEkPS9t1HF19f?=
 =?us-ascii?Q?zTre1/96NnmmjlLYYMjMe1ZnyRF8aLGPnbTN7ff6n9M/Jr2XpJ0P1YZEpcCm?=
 =?us-ascii?Q?a7hEwDZcjvFySlrI9Bor1DUR3SwG0UPDs5Zyyd0Jy5yAsj48huHlkJfd3JPk?=
 =?us-ascii?Q?AmzEma5C95lYGMjrzFYNTQtnT9GBWW1cipU1KjlGc2IfEIf7ng48pdKkni47?=
 =?us-ascii?Q?I7xS8tkGZHCCdyMqnVj9aGOF3h1OHIsRvCfuKrI8GvnIE/2bJzWSzDPnuHLA?=
 =?us-ascii?Q?em7918ZXodqZeXHLH0lIubwThvheuuuVx827YuI92Y8I/xdXBfVPSgT0rtaw?=
 =?us-ascii?Q?4N8iGKKsTx1VjV4s9JQdgn6yZkGp//FK/2P7FG5Uad5MTR4SFzrZ9JvVKYAz?=
 =?us-ascii?Q?RIdGxs15C7BCl/0XAxgJuBmm22FSfAk+EhHJfeQ5jM+Q2Gi6szqbbK7Ro5DQ?=
 =?us-ascii?Q?qUaksUikRWTOy8J/KKqWHjgWz+O4jGOF8qHNtx8IxRotUIshv2DaqE3CK4h3?=
 =?us-ascii?Q?baImG4WFV9L6XS0V5qAEuqefaiHjUq+TtLUy+LXBp3RZipI7J9Px+BkNBMMM?=
 =?us-ascii?Q?bJ5wafs0aHBjoOSr1ogY9GmjmQsbKob9PoV5Jfg6bV0B7xqWzuGm810+zsQn?=
 =?us-ascii?Q?edmOAbakAkxLFSzBykfPowjmZESUiDEL4YxJ3rPkuNKoVA+ysG89dzOarxIY?=
 =?us-ascii?Q?mFU0Nqz5GO6GS/tOP+vVuuF5rk2bAmcx5pszt0Fnv3rw1wtVS2Luiz2Mh451?=
 =?us-ascii?Q?rUrdO9FSNUUCiYpKVp56r0mFLGMlig0ZYgpkuPlZrPRevacyC8H4MKepzasj?=
 =?us-ascii?Q?mwpJ5vVxiHL/FIV/1+nJNBMG9qrm0g5e13lsJbU8S9ZzedXmPeTcX4MTU8Ar?=
 =?us-ascii?Q?6fJ4uRya4xp3aipkcyFiwY/CWQo9gowiCgoYQ7SIaIOu6L3G6iPp1PzMqHDr?=
 =?us-ascii?Q?xu1xuzcWCwr8e9U6+ernaEqk6jJWiH3KVBw4JouQ2WJW3+AqOMU5HpwQZJgV?=
 =?us-ascii?Q?8xY/IUpLW8nlIiNJ/o+ufGCdigdQkgz2oKvAgVRiMcnG/C+tLLtaRaQ+vGt0?=
 =?us-ascii?Q?Ue0MFb4Rn4dE00U1xnVSjtBT73nBjz43H+3Z+6bWz2RRn581JYWVO5fM5JWe?=
 =?us-ascii?Q?oxY+d3zGPX0U48+WaTvDg72WgK1qqzxD/t3uq/F6WTcDRK+6XJc0A36otvLu?=
 =?us-ascii?Q?cAl0LcZ1WirdKXgwsIGUp0D5iON5fHgdghmlkKQM5jjhvrwtFsT2Q6NURAuz?=
 =?us-ascii?Q?IZZlIc2VdBOh9UoiRKET9e214nAwXU4s0EbuaweoebNZ/a9sAkt+fB94X8qz?=
 =?us-ascii?Q?AbSLiC+dd1hL4I0BJUEmZlBk8K68ha4lNfgjyyoz6RbvFmxAm4gMeeUrp0Zi?=
 =?us-ascii?Q?GJ0DsrkKgEuikgvzaSufiSguJC3UWhDcydNlI/B0UHQNyw9U7Q7mf9OeTYIO?=
 =?us-ascii?Q?mr0s9qnUJu58h31emPmNinr+ciG3I0GZWhKz/R0olJGglIM/pp9NPrJ7G1Fj?=
 =?us-ascii?Q?NXGonKUdB4ljW2w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XoWkVfROWto4WgWcfEZhPYaO9Zpd/8mnnLq8A0Ecm3nY7UhCmNO1jCmai/Wh?=
 =?us-ascii?Q?BNzOSxfjwIAHjNsPBiwcVE0Qs5qdW3sfFo/8zgs47fR9BaN46t8Mt7428lln?=
 =?us-ascii?Q?shsJxhitepTN4DaFND1lWeKgV6Lia3ZupPw/+Gv9fpkBx+ZHZ+McCo8ZAzR8?=
 =?us-ascii?Q?AmZn3nPvOaEIgufkGAEA0I3ZKHZpauVaqTW1KDwBYSiD/4tZ41Nhw1sOGjxq?=
 =?us-ascii?Q?5PGuV/OcsnrY8s9Z172e2GswNQcEXRl2Qmfa2T7mBwBx/tcJBqQwLcYGuM8c?=
 =?us-ascii?Q?hQPGZCT1yPBPV5PW8kLd3+bbtlkoP8YYga/B1NNUAMWX0t+4jUDV6FUgdkTu?=
 =?us-ascii?Q?2WIGov2Bf1HCeKLt0nG8koITZehzC0/7AXv1MZ+P2KNOZGmA6LZ2uZbGIBra?=
 =?us-ascii?Q?4d+DW7vXgD2j58DRHzwURKUbMzoCH08UKC+QHNTUkDjMiVjo/70HfiEUEVkc?=
 =?us-ascii?Q?FNOF7aJv4tI+/Ew2qlCCxyzjmORIQYlr3VU43ETZ6lcCqh5559u4aGMU2OhW?=
 =?us-ascii?Q?LtRd+RMyE5NIwFVftNkm5hMA1/DQqOum60DIpylqMzFzz9ppErNY5YvxaezW?=
 =?us-ascii?Q?v6jw+u2z9bOq4GZWNskzxN0+0k2ETI1Fpu58vDNPex2Kv7kTrOwO9tn0Kfy+?=
 =?us-ascii?Q?f3tQ/OqLqEZDbePOJFW+tnKQxnHQNUNFXobGEadjjLkTQQESCTlb/kyRqMlT?=
 =?us-ascii?Q?HZNT3ebBpY9LDJdaSHC1/tDrHQF2a399BDtp6X2/tuGkYrtGcmBPbLwKOTYq?=
 =?us-ascii?Q?7xpOmJQA2W0DscsgVWLJPSKMlgGAfs9UCY4jMlBrnsMnZuOKH/qwoWKTMIvm?=
 =?us-ascii?Q?CbBpAaVBVEOeYOREfqBIkjw8+yYyi0t2bdIs8r14gPNZ/AFlNV4TYcEq8AxG?=
 =?us-ascii?Q?KiCE6nR8rZwee5l5f4b6ZgWxEO/vcCsnTAvFM0i/dL+QPVE9DRzGbSQtuYWT?=
 =?us-ascii?Q?5PvtugX/48saBdfM3qkUCdprrkIuz5qYtNjNJ8k5Ek0e108zoY8AYtjutKZG?=
 =?us-ascii?Q?mqbRWTArhblQnnJRXnZD+2l2O9trLnW2F79XQdXp6qhbALAGjys9wxyjMjDl?=
 =?us-ascii?Q?5vQWHwd5fStJMEggb+NvBzTVrMDQr0+qcTYRb+a+TiWvhK7uanZVl86en148?=
 =?us-ascii?Q?QvUPciybmIkdwl6qhY2ShuNIqoIbz5AEvr0y3Q36yS9E0AgBpegIvYmgan7S?=
 =?us-ascii?Q?NXxFcxWbOF11WUH1nEZXChuau9Vdy04k6Z5IGoOD5iklF01Mil8sePg1u9Dk?=
 =?us-ascii?Q?PstccuXv1VJ8UUjvPGkGRpl9cmoAq3/EHHRGITKps6P89Yf+clva7fNBf8c2?=
 =?us-ascii?Q?ZDPX2QVBIwEkd6IfApeOu6fYJvRz74SDvon23ovcamN7PubkPB5RKG50Ts1D?=
 =?us-ascii?Q?NLGIpcLSu5v2zaFenlFbiq/cf/jWIe3ggOO4H7m9BlGEyYNrIiYmH3HS9XYr?=
 =?us-ascii?Q?YenXzLhCDE4Cuw4vQf8CbT+D1OhqC3/5RgCAlk8AhD2bBoJjLHDXn16XPWsA?=
 =?us-ascii?Q?CNki36u0MwGqudBYVexwterdx32g63HsoAmEp2wlooDo86wIL4YenRSH6aJD?=
 =?us-ascii?Q?o4k5wz/sB61meL6mrSjePwCOIYlJWHW7X6av2jyV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b986523-9bff-4a6d-ef0f-08dd93869784
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 08:00:43.3258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oF/nZELzNaiyxIWMZtwbQrSug3eWYsT4bcC1U1qZBadJoV45/Emxlr3TKuHJCDWX0LE28sokHTuVWBAJqG5nYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF7C7D8332C
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, May 9, 2025 11:03 AM
>=20
> The current flow of tegra241_cmdqv_remove_vintf() is:
>  1. For each LVCMDQ, tegra241_vintf_remove_lvcmdq():
>     a. Disable the LVCMDQ HW
>     b. Release the LVCMDQ SW resource
>  2. For current VINTF, tegra241_vintf_hw_deinit():
>     c. Disable all LVCMDQ HWs
>     d. Disable VINTF HW
>=20
> Obviously, the step 1.a and the step 2.c are redundant.
>=20
> Since tegra241_vintf_hw_deinit() disables all of its LVCMDQ HWs, it could
> simplify the flow in tegra241_cmdqv_remove_vintf() by calling that first:
>  1. For current VINTF, tegra241_vintf_hw_deinit():
>     a. Disable all LVCMDQ HWs
>     b. Disable VINTF HW
>  2. Release all LVCMDQ SW resources
>=20
> Drop tegra241_vintf_remove_lvcmdq(), and move
> tegra241_vintf_free_lvcmdq()
> as the new step 2.
>=20
> Acked-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

