Return-Path: <linux-kselftest+bounces-33030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AB2AB7D50
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 07:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C1B3BA2C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 05:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32014295517;
	Thu, 15 May 2025 05:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jPRgpQwI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F35292901;
	Thu, 15 May 2025 05:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747288245; cv=fail; b=A33ySz60fhWDC4/mH513NDT+fasK3TRCwm9A2PpfHYfi9CQyR3I2Jgn7YSpTFYFIjDYfwsTML6V8W/zNf/AeTSRk/4iWYQqtFYRZw1XhdS0kXUs6JA57dSVhXpZB7DZuLjdUQraqAxODJhmeRmPBirk5/RPRBTVxMEtH3rchQBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747288245; c=relaxed/simple;
	bh=K87j6fx0GjDB30c6tyv0j1fM2NYbSL4svlR3Dj/pHtk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iqmC8J1MROLwZ/Xe8cn4UEo2RN6qZLlWP7AgPssWvhulD1tzSDNquviEjXvu2ny7TJQVABIrrz9cnvJ7mRlrEAHjBJOOYKk7pcPOTPXgb/q1Gepfkz/wdZPzUgK4AbO5pFOfYUdKMjD8u/sjD8k5OXcNyjHjUlOrwVgd2ustsSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jPRgpQwI; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747288243; x=1778824243;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K87j6fx0GjDB30c6tyv0j1fM2NYbSL4svlR3Dj/pHtk=;
  b=jPRgpQwIJHzoiWnoJg/sI0ytHfkPlIoyQm02QLsXYYSR4LpZ+z9BGHux
   oUhZqQC0DaYGZGz7QZmmPb/ESz/Pv47Dm6jlRLptIGKwuot3FZ/IiXjVo
   CXOb+M1h3ZVnbaugIN2eoPiuaKWFi5CLSl4t2d0v5qzf5rQE2o308yqm7
   x9mApKgVKbsc7YEQsDADd8Rso9FGF3/mnG8HRJD7zdkA/HDcw6FplREjA
   TE4Wiof7MPM81mX/fyAD+EsoVnGmkKEbH3fTLj5CxrtMUzJ4SpanEIE/e
   aK3gcNxSTxuVDgCczyrERl/6HxlZ72KY/xcKgBOoPwXMSr3KHFhUi/oIw
   Q==;
X-CSE-ConnectionGUID: SoEFEUQXSkmLyloe0UN1/A==
X-CSE-MsgGUID: q8o4LpzrTCuLeaShpWwWjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="59438805"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="59438805"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 22:50:43 -0700
X-CSE-ConnectionGUID: l3wn0UKjRCWYtZ4ya6nD2g==
X-CSE-MsgGUID: wzAuiyj8QjyyjTM9DLlcyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="139257542"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 22:50:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 14 May 2025 22:50:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 14 May 2025 22:50:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 14 May 2025 22:50:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWUHILSzseS9okgDmH9VruXiMVb9V8XH6mHYRHgO9NdSTQ3lDxPsxKEiO1LZ+8TUrRlLb3j9bbPlvrOODeXkNQbfAq+s2zwoR5wAGCo9IUA1VrKJDZJriwwlHUpIgZFuj7JAh11tr/mzjLef69ro3OpECmC8Su3DR+uhJmVm9eVTKnTZoFRbqp56M4bdTfcykPyRbwcY1uNFaAL93bERQkRcAIhraIy3dBbmE1s496KbyOqfKfN1+1hYDy1tj5Tph4y3WzReqtMWAaWp5i5D6USoih1yhuT2G5mfYN1nCdDRvN52T2eOncLvFjZ050FcmbIGpaMxBXDmGlIIYrGUvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K87j6fx0GjDB30c6tyv0j1fM2NYbSL4svlR3Dj/pHtk=;
 b=fAamp1qxER5FmpfCFsL/aJ2TbQUwSHRYUq9fSlH3TqreVSfhFCI6+G1j3cuq7E6BSGkrQ7tNKOsA/Y2R9Am0gIWN3DraOhhYvdXUqYrattzt+zG0FbHlrWH/dT613ZVrdKEdnzolm1et60FdimavxSbEtQkwHXnIjRuoQkyOA20VLPykRKx8gQPMbHCI80kVw7jgJPKdheIzguKMrXhP4dc/8EbjEH+8u3zkJ1KRqhwHoxZPZ9U4uB2iInJQR9Ore8DcpIXXjjIcZG2jmmt5+4wyB0yCVAHGVqKNfFmUHo8Xp3OpuRgZRk8MW5pls9qqajwdlv2RO8lFSb8U1FbtJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB5872.namprd11.prod.outlook.com (2603:10b6:303:169::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Thu, 15 May
 2025 05:50:24 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 05:50:24 +0000
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
Subject: RE: [PATCH v4 08/23] iommufd/selftest: Add covearge for viommu data
Thread-Topic: [PATCH v4 08/23] iommufd/selftest: Add covearge for viommu data
Thread-Index: AQHbwI77grzuveT9j06xVJVkvRc7D7PTOU4g
Date: Thu, 15 May 2025 05:50:24 +0000
Message-ID: <BN9PR11MB52761BC6E07BD6C63DB17C238C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <651538176a854f6c6aaa76f2f5f17a68cd270c0c.1746757630.git.nicolinc@nvidia.com>
In-Reply-To: <651538176a854f6c6aaa76f2f5f17a68cd270c0c.1746757630.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB5872:EE_
x-ms-office365-filtering-correlation-id: b2b6d1b5-6594-44fe-3478-08dd93746352
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?uvTgn3ZjNyv9JKNliVIyLcJ54Lgi1IUjJr4CQ30e5i7H+8jYPhup6QS6WZLh?=
 =?us-ascii?Q?uVd/9lWZoY+uGed5y0EF1nKn1hW8W8ewRT+3oRCDQv+Kflh7CFhtcwKB4+k7?=
 =?us-ascii?Q?KCyQN8mcLE458QVaNY+q4X94emvtea99tWCPejMSE3y+BewZvhKhMfpomvIO?=
 =?us-ascii?Q?ds8TJl5kDN+lHCL/OWZemq4UneYY3ANsx6P1c0riD+oWu+ky41+ZkVFYQeXB?=
 =?us-ascii?Q?JBj1NFZ6f1gRe9gtPlAPg3+w7aTM1Ny/TiBIAP009noBPQfhaCcSZKk0yg15?=
 =?us-ascii?Q?+A7NRVmJO2iCYwk+5rkww9A78a/a7dIfO07N71USK8/trzAaANXXcWh0/9vz?=
 =?us-ascii?Q?08KPpKazwn4TKx2t9q24p8oxh6uPYCMMrpHekJB3P4YqqiJZRK8lgDzwLmzk?=
 =?us-ascii?Q?I6xMj7ZRwDzivgkwngxy5pyzbvQ30Irv1eYtOgA84ad46X4TpYgaZbRWmDkt?=
 =?us-ascii?Q?EVE+EqE93S63WbxuuWhbVpAaYDtMAUTkm/TVEqbKe80EUd0q3B1VHilwe1Wq?=
 =?us-ascii?Q?Tq6IGtpGvWTzInGsHMN2S+9Qx5j24NvUHPz3A63fkpomo0LV0CPem4XpqWrh?=
 =?us-ascii?Q?1zEIEUw9qc4zfP9s0824MZHCMakngYaCurOkjreWFka2jO8gnUssJA41V+0p?=
 =?us-ascii?Q?IziQhyx9Gvlnj45RHLdCoxPupX2bM27EmEe9mL3JFLC3N2dn7CY19B/SvBep?=
 =?us-ascii?Q?Xhu/ziYItHfcDphVZoGxO45JX7k7/Glnp25v/1bDBD/I8XkI+akm7jMubr70?=
 =?us-ascii?Q?8kRuiScxZZLZS0tauOe2BrawsmJPF6L9xxrJlzvMTbVrQGSzOBp6GtTNJV30?=
 =?us-ascii?Q?k/RJsNx7sX2jNXA8sk3Xbbb49zfwMqAzM5rlTWc5LlfYSxCl2PYIM2Oxspew?=
 =?us-ascii?Q?u/E6LGSkjutd5B76//kifM9K0AEHU3hbDYdD5qrrR3mvH+iUlD+8lRe7vyj2?=
 =?us-ascii?Q?3oQdGy2sCjQsxj31CGnByLLUXiHHFN5kcGgh9Tg4vs+ee3DGIhXZL8kTH0EP?=
 =?us-ascii?Q?9pDaR/wJq4H3eHEgkr2nzpZwMbL6BtmJ7wz8OM8PdeRuB9iUzw73+AuWj2wX?=
 =?us-ascii?Q?kj4BjIEsg1OXbiR2ICHZk8uLj5zf/P1Hpf4EfvHmAAVq3E/a+DioT8dwmfqu?=
 =?us-ascii?Q?4ih4E6eHzrSLc9gJBBj00GENQsZ6+J9VvEeT2nf681tiNn6jxkjuX+htwptd?=
 =?us-ascii?Q?TUaBKPlJXiknD2mJAAacIrySm5w+mk622dKyseguDeenKDJmlDoH8spEzaOT?=
 =?us-ascii?Q?RBTxtq35R4boRsMB5bmsFJKBRQ3G9bt4pl/Bml81+XuRWOO1cifDNtnQksYm?=
 =?us-ascii?Q?3QXfbea4ayjVQAwSMIuv7m6ORDZsvZRMVQ+FDUA4TjybuDrK66q1w8kyTYYU?=
 =?us-ascii?Q?z1H1BD917T3ChS14aoH7gAwOCEuFOddgWWxyzBHdjXy2g3pgCAvNUeK6yDWd?=
 =?us-ascii?Q?vVZb3zgFt1WCxODb9iKyWJ0wRTyJSHyeOVTW731WPnsvhCU6b5G/IQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CadKI3YJjs8/RmXyzWxU6seypau49Hp2UknyZOQvYlxvMpINsNQhs5EnurCS?=
 =?us-ascii?Q?pFszpsFjJfncnERRvPlwpZbQbK1aohdyrsnrBzFY2k/S8SX3yYGjaTsR+0Gj?=
 =?us-ascii?Q?s6L8+8PP49DhJKZBPGTsLrhboZjNu64L1c3nwQoKdFUrh4RppPTLJ0To+gov?=
 =?us-ascii?Q?UOOJMQ6/+lKJ0mfaz+xIJfTlc6yExCsfCsxoPNkqZxkO59KciW63PRzI/t31?=
 =?us-ascii?Q?cK0pFSg2s7Gq5jx5A5bMTIfBW++cJ+Ip2LyEdAOwC5R2DJjL7J3Wl93J61CQ?=
 =?us-ascii?Q?foGTuG82+xD5WHMtFhP8ItS9jAGQ76CP8lYXisJNfhd9WjJ6Dr++M4+Cfd5G?=
 =?us-ascii?Q?SpcYzwQTbNgzmqOnA/nQ9+gjckVfpjaWq7x9MeTbHJ1tgEqBZt0gGmmPoh5/?=
 =?us-ascii?Q?rbwUHz+Q6YixoUI+lvJkodP+0abUlH5GezxIIbntEsnLxX2bPlV6iu+qyEGw?=
 =?us-ascii?Q?RAR4cFYxQVspsNWmFpf7pYzPY6n6XI2k6nOQb5S9hK1OgxUUUvqSy88EV9J8?=
 =?us-ascii?Q?qePOEmJa3EW3i4udHN+fdlPX0FfiG1kjS/gmK4wYgfFdg36IQSZWsS6lNpqs?=
 =?us-ascii?Q?1y5Y4Uxz6HLXrXxd3uti4hECpKk5+tpYLnT36yhnw8xfNqP3E2P/4zxrTWyN?=
 =?us-ascii?Q?2VIWjLVEmDSmMS3cYTaR5v4erZglu14BrIIg9TCF4fsvoPfSwLMYxpdqTZjk?=
 =?us-ascii?Q?bdvAR6y+a3BR0VqxAUfulEtDqIkSKgrG9p1JKn5nh5cdd22Oy/5LCx06BaHr?=
 =?us-ascii?Q?6HGzPdKsnX1j/SCStQ3yGkkE8ySoZDEyDP2Ev1rK/GP8gcW6762Yi6lA/Fnj?=
 =?us-ascii?Q?jsaCyPtlmdQ5NibuchSOuf6kbeGQ1zCZsFUqk7lietWquAfA+OhBHWheFqzl?=
 =?us-ascii?Q?jYYN/xpPJWwzO8sAzzFdPQufcFr/r1b1e/g0XKxZg8rSZ/PUmc7r8LoXnoD+?=
 =?us-ascii?Q?mmI5MHsYVfbocun8ee09FdoNBZJ7aOqZs1Hxz+ahm18h0a4ef5/i6JuMRFDd?=
 =?us-ascii?Q?5y0eDi1lEHRSHEwLggOAUkeDEE4oa5Vi788qCeJ3HkEBTg1IKZYoyHQ0F1rl?=
 =?us-ascii?Q?Ql3N733bKdlbFiDlnAkPNEXD15dQJsbQdoUc2gwj7SFvPtAdZFUan5UIKIyn?=
 =?us-ascii?Q?0mhYMPCIFwssT3D1RFwjS+5J33RVM7iSClPbtF3xSa0ydhtp4DcbvFwXlCf7?=
 =?us-ascii?Q?bydwJkQ7iCieGu2pKeVllfzbXL3ZcQ7NSD1t6gdaemyJZO+AGcXvbx0pV/M6?=
 =?us-ascii?Q?5l9EZmKgI1BLmsdDq4ksfV7bFxzZAKniPcyxkJ7y2AFjtl6O0qV/adFMX5Q/?=
 =?us-ascii?Q?opRRhQEM1DzB8dQdJY0sLw2X6SdzHnKjrFqcC5WTAXMkdt8Hw34SFTn7MkLi?=
 =?us-ascii?Q?xjKwMZkhEG+oP7Njem1MJdt7mqO6ehgpb4TYnoKWAFMoPTUgOnJx2adHrxy2?=
 =?us-ascii?Q?8d9PLETwcHVc6NXBvA8rsz7+puOFUZ1yBRy9FPPWcI4jO43rLZZt02dILYTm?=
 =?us-ascii?Q?UdlpZwc7AnElstuxGKxm8XDxjfxk3rI5uJU66y0rYa8BqtUXLfrwjEUUe8Yp?=
 =?us-ascii?Q?4AOPblSDazhDtCdGGpmiFQaQ9OzYcnIq9M/wbmCc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b6d1b5-6594-44fe-3478-08dd93746352
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 05:50:24.8044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kaJl5o9zKnvgE/txxsNVG6Z6qyEJTnuSpD2qI2/PaB+ZFqPN0O7mh3sJERR0ZrjrUhuAqYWPEdyoqsygPAf2ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5872
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, May 9, 2025 11:02 AM
>=20
> Extend the existing test_cmd/err_viommu_alloc helpers to accept optional
> user data. And add a TEST_F for a loopback test.
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

