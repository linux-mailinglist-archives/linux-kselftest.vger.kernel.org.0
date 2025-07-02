Return-Path: <linux-kselftest+bounces-36283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8257FAF1059
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 11:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4E3165C00
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 09:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74BF24728E;
	Wed,  2 Jul 2025 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="grgkxSVO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20611248191;
	Wed,  2 Jul 2025 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449283; cv=fail; b=XqPb4wPkKYMCDU1pPQf4NHZInWYlMwoV2pXqS/e56hOxNLI9cLhgy1k7IcNHYj9wzYH2hR6jkk40/D6HtldsNIQBLvjcb+A2GL0TNU1FPcuRCl90T+DcxLxqHHWtFw2BE0WW0ja095hcgOY1tXyQv/0L1G7TBnYeAPOrFrOoeCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449283; c=relaxed/simple;
	bh=75zF1kgRe8uGaYbFwsNCtoS5zo1uYVo6hx4kzJO7N9c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GaWe6EWfSQj2YZpsxIIH0XhXjT4/3nhmiYzUDgZk2L63J5M3b7t5meHgPwK1nTd1c3QFmUeEgMRMKAMA/IMF7b9RNy7ddx/gp/LElo2a3ckw9Pc/dxk/R8jIZu/JZCtnWkyG5SGwxU4rmrcKy49V3AGdQOVHhHLkNlMlm0dyX4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=grgkxSVO; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751449283; x=1782985283;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=75zF1kgRe8uGaYbFwsNCtoS5zo1uYVo6hx4kzJO7N9c=;
  b=grgkxSVOqvBABh7hZy5x539JnhHisjJqFLO/zZC7Gaz701sRSChEGwNs
   7IiuQk4eCS7NLRquE5kHmv9MYdo2jj1AzXtoRiA2G4bSHU7QiBvEzTKEL
   e/XWIMLWpbQ46XZvYZ9vfEYA2V7HT8n59VzhpDKlZS7l0O3JqO5kd6gA9
   PLwTGkA0rG0E70UWRryoPxL7xKRhXtPKDiNj4W0Nky45qQT9e/LXkY/gC
   o/vK1d0duurJjfgshT55MOA9WNP5R7T5MQGWDNO5HoK/SZ53lIlx1ZHNW
   ok31+92mVnEW+F3Tl9YqgXBVhHaralX3HO7smvkNqv43UUi0fhp/mSg4D
   Q==;
X-CSE-ConnectionGUID: 9Uht2FnaTAacN2W3RSACtw==
X-CSE-MsgGUID: GmtgsSv0QterqchUaTJ8rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53853508"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="53853508"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 02:41:22 -0700
X-CSE-ConnectionGUID: MCGbwZyARjazP1D8tJRScg==
X-CSE-MsgGUID: 54tG72vbTnqfQPmO1T8AMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="158405948"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 02:41:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 02:41:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 02:41:21 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.73)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 02:41:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pv4rHx/chYMtInAblnd2+JD9jmwArDMlsafgF3mFSmEhm620l17vcVYxhUH8kjRErD9B5ApZkhi9Y3YnxT118iGtDjcK5Wuy4xpv5Ys54TtofRdyA2HuGKDX8BXfnknqB1NIukcZaM5pJu1ixDvrr0drFEq3EiA7lXlxw2MbndLecuHVKghnI42vqy75nZWpjoQ6VB4QnRZbNduN5glyyXTofLE8heBApGnTo8sYJysACZeYvwbHjW5durr/BJRrSxjtlDq0WnH9r0F/k+s+E0nJn9iewnybvS6wNHcd9ed35hyMstcTHybcQ/f+90+KvY5Iowoa1raUAnfhMI0hKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5z3/d1YhbUq/N055rWRCwqmm/7FDfgE232LZodMVsI=;
 b=koOQFAEdY+WcdZ/hiBjHmRerFO7qyvqasJ9xAIcsivF6OU5STwtAmiX8ZEIjT+0WhqOhSJ0fk6U9+CrnYNWbeoFuTaZ4P7NerCHGANwfdhuYoWzuWCMP7/B151npDyOuUc4iKO7Sctmovwz9LC4PiZan6WNNH0dz8fQLlA83h3hTjuCa8/2EhI8sR+ZnaQxbUyfeeYbuoObE9DQqIlhQgbG+xI2VHgNXvD7xri8AwinaQBUpoCP+z5crmhwpffIfwC5X6GJ0Rvz+UoUamH0qjwVOutNHgQ/3bipIXIHxJbIAJ7CFVPbnyULu5a5pXCJqXwys4cDgUb72oJZGectv/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Wed, 2 Jul
 2025 09:40:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 09:40:50 +0000
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
Subject: RE: [PATCH v7 02/28] iommufd/viommu: Explicitly define vdev->virt_id
Thread-Topic: [PATCH v7 02/28] iommufd/viommu: Explicitly define vdev->virt_id
Thread-Index: AQHb5tF/xVhwEB1Fqkayrko6abrVo7QenOeg
Date: Wed, 2 Jul 2025 09:40:50 +0000
Message-ID: <BN9PR11MB5276E7F8A69CAC8F4B0E416F8C40A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
 <cc7a558bfcdce5c2ea0d53b0c9c382f944df33ce.1750966133.git.nicolinc@nvidia.com>
In-Reply-To: <cc7a558bfcdce5c2ea0d53b0c9c382f944df33ce.1750966133.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6171:EE_
x-ms-office365-filtering-correlation-id: ef493149-28db-458c-90c9-08ddb94c87b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?9vNmifVIGBWxaejGHvDh5XYIDU6FUXhB9YwUppQkeagym1cujz9nDB3EJy4c?=
 =?us-ascii?Q?/n/Kt+O0YKlHCwGYpftsgQgOVXm9sW7cVxy7+W8/DROf2dfW9M+VxRRo/M1a?=
 =?us-ascii?Q?kaiQalacwm4du6dvkl3Vd6DqXoMbR2J77eb5vcc7ipkYjnc6yQqbsF4/rItL?=
 =?us-ascii?Q?2lf5TrM+eXavZVF5ZN9Mz5bqJTTtTwnQF/uAZoeArez72d6XjrnuNpkTsR7U?=
 =?us-ascii?Q?G244Rjyjhk9EptDKStviSfQ2OWs8GVdud7ks58QlSyhfLJbV1NgqCb6+C2/P?=
 =?us-ascii?Q?hfpF9jHFswg36tb5Ltn1ezwCGQRBvHIfX89wZD4bvd7KQdTNXpF1W7HOplH6?=
 =?us-ascii?Q?1cA8FDZ3xNxWdxnzxpD7DH71eque78ZvS7dxUEtWs8scLI+f2AWuC+syPyDK?=
 =?us-ascii?Q?L2NHtr5YFCaIalUFCadbvUhZnxDSPLcy0FP8RX/isv/T2zz6K5sf2Tako6+E?=
 =?us-ascii?Q?gXRGEuVAFZiAAF30Qh3dKJeJ/gl1luJiTxSK9w+8m0fUfuKNSEdud8267rcQ?=
 =?us-ascii?Q?X7U48O8frFl+fNixtWVPmm/Vc2Pjjvk2p+rkEM0uCyD3A03IgKCBo4qGANeJ?=
 =?us-ascii?Q?YlfXOUbqmp7RMezxw+/JdEQ6ffebsBSr/20qdKWJsNmuibCCGqlsQyVjZt0F?=
 =?us-ascii?Q?ndwfU0rgfmpo83BrJJOVc3k8PiDJd1uhsDtBHvF0qIzBtnGwlP+091ByiHH+?=
 =?us-ascii?Q?wYu71hbK7P7DnUv0Ka2ufItPcF8Z8QjxTMuYAtr7W/fVXaf9WUNP2A7HuzKx?=
 =?us-ascii?Q?qOsWuvV+jeELe48UUerCnAgBnp8htTkz/vX/9lsr04raHPwPAVSg/SZBMSmz?=
 =?us-ascii?Q?csmRUV86fcnpx1EdJvh5OSKtw5WZW7pkNpHnieuHdHQaz/E8L6pqTZ10Q2Rz?=
 =?us-ascii?Q?T0A7ZGyFCimREU5WzZMjDQxUwgtWeTTD0+VZXeLAobpCMlQ953+8wAvS09Za?=
 =?us-ascii?Q?0wbXNApnx868ZidwLcHQ56aHtIsJyPS4Sodd+pGtF8GP3pJYLZv1PLQD60uX?=
 =?us-ascii?Q?4XYSJYzWgNFKL96qWRFJ7eGvx/JKxTFJYp8JaJu6CKe9wEttSVroHV/GvsTx?=
 =?us-ascii?Q?11jP8yaD0vj7GgFjqsMJpN9/SctM6Amz7Ai0b1kYqLoetmeX9IzQuwiNLg8L?=
 =?us-ascii?Q?eduSTfBCqrCISkf5GNsodSiqXZKIzf069AtyI3lbiIBm76hvuOKe1k1NxQp4?=
 =?us-ascii?Q?LVHAVkuUUjoMPInHCI1hvlUto2n6fG5nxKkK8Z1aZ8BfONP01pwazA3B3lzV?=
 =?us-ascii?Q?2iwwlZhbyWtAdE2cELbpdYhMPH8TTHThdkNtt2+OCBlnIDOCvIX/gyL33Jg8?=
 =?us-ascii?Q?XjCrRQpVtYdn2w/RI+ek8SyfKKBn6kDFV2bRQGq63lb8VyVXCEFpHVboooY1?=
 =?us-ascii?Q?CQyB0aYgFAozitms7xmWtd44Tnz7J4RcbDI5ebHBzUA2cCjmW3pJgnFMw+NW?=
 =?us-ascii?Q?ADrnILZGrzydmS6AfX3LcnxjnsPi5DlrJlVtWQB0kFfofzF29z8CQ342AyU1?=
 =?us-ascii?Q?7QJKpgSxRYM9Z64=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HeGGeiGCl/6SMCBT/VC3RiIF/e4JkGm60em+Pe2QU73cv2c53gOQvmotmyzb?=
 =?us-ascii?Q?hMUfx6oknqVhwAlkBPffUAPYcX499AAlDMmfPbdR4HVZ2RZ7Plbqtte5fM7Y?=
 =?us-ascii?Q?B+Jy+yKcuvynFNvYq0v9X0PVVF0/CmHp/Q/H6rVUXNkbNvirqGwB+zEGkTPV?=
 =?us-ascii?Q?3JslbO3J5Uk5v9z7JNEdv+htUyk6lTaXp1R3O6WHq4PqasJSIovrmfQSjY6w?=
 =?us-ascii?Q?yifcRy73QuFup9F2/ywCknLXzKqdaHChM0gFwxE8S7M5phBwEXJDxzE5T6On?=
 =?us-ascii?Q?JM6xNeCCUwYc215etwciF7aIdwurvH/fpXY+YSxfJHAOiBpadjCWt6a3Vd6H?=
 =?us-ascii?Q?YcUoo9w1HI7mk3wcJQao5J4u08OODLlU0lWLxfyq45KziMf7jj8hK0QTxjqu?=
 =?us-ascii?Q?ykeWKRoovYVNxMQI0H6OCn3TGsD+Hr9F+ys7/5K42gSJi0ly9B7LFDEg59a+?=
 =?us-ascii?Q?LW0iCe4juQ+ENyKGiSW2XbWKalAuGBg5i7TwFHa427MMQ4OjM3Isas3lBg9j?=
 =?us-ascii?Q?QFUbzg6g51ELrmJMCQm39L9w0sS6aylOsMp8DUQxg+ZsIvmSrpKd8CtZPSm4?=
 =?us-ascii?Q?m1MWd0pnlbGOw1jh2+Y9us5Ux/i2djjPKQ7UHv52F840OImw5KEAh1/AnYwc?=
 =?us-ascii?Q?+Imh4Ixo1c9tEPIx2fxT74k22DDuCdNJgrf4wycA2kBUERVGV8L/BKewZVPe?=
 =?us-ascii?Q?bNIznNFQsXMRzwE4EdyGVCUbJHnUefC7eaWQ0AEFH0rtOeXg8+JlAqdWf+og?=
 =?us-ascii?Q?Qoh+4DxZLSZby70WrycnQ4PZhBpmS6ceUt9V131WuUW1aEgWh5BYurdQD07K?=
 =?us-ascii?Q?It+ikgGAVqJwfWO+IT5v79UIeMy4H5HKPj6RNroi8gGByRIHEfZjh9XzPHWm?=
 =?us-ascii?Q?PQBbarjWgEHcGWDPEvNoo8r1Fv+AFQIqSbF8fQ31lYBrCRPnIzw+1EVIK1fg?=
 =?us-ascii?Q?vosnizyd5APBOIOESGAKNVxbs2q8rwZaMk7YmKO65CAuXNCAx3A/FjRWSRZm?=
 =?us-ascii?Q?KOkVzj4bA6yuZSGJN/eCiG8Hy+IAqkcTTHhsp1U7oI5jeEqe7rtCwviLAfjU?=
 =?us-ascii?Q?xs+Awlsdp3BU4W8w7gE+R0M6QC6QbWElOAt/0eqkMhT2ptKulEtD5nyCWxBw?=
 =?us-ascii?Q?ICS0uxT+P7IEVX9luHQAXUMXq2mbJ++GVoe2uLtnkhb4UMY+B3SKBTyKSpmY?=
 =?us-ascii?Q?f6Kq0l3j2cTHrNA2vGRmn1PI104ZetgdccxVvo5R4xqMNQb/kAntx/UUaMP3?=
 =?us-ascii?Q?rKr74zuIhEXueHRvhSkQtBdVxC5ZPzu2wB7AsPym+h0z0xq9s39WIxfnhfrU?=
 =?us-ascii?Q?TM/zJWN6c0ilPOn+hLl1dvWXiH8xJvR0bdKrG8adIC+j+8+HeWagoTtP5ODn?=
 =?us-ascii?Q?kXpZ093rIFiavlwSLdhCdYDDGEBzXNAQh/ffHJeNSYoVA8ZSaBIH/hVKHOEK?=
 =?us-ascii?Q?002zO4J7ZrQUeD2lIF0ld+mrMSMA49+8Xs1FPcaeVTbkARBwCdsOseQZWSyO?=
 =?us-ascii?Q?xoXuxaplQMrmrYvf/t0MnqBfphixCmKpIjCF1/AmVtwHJZ1IN7GZ6NVKBKgo?=
 =?us-ascii?Q?diyXBkebSQ+86SJaV82giEoeLhbgeYnc8Bv5GCTZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ef493149-28db-458c-90c9-08ddb94c87b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 09:40:50.1680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vr+tde71xfxHmEw65P7TeTCfqdOc9Fmi1o28VDzpVmGKYCWc6TEpp2b3Kwo2bNXgYAUob9jzeo1Wk+XBn1KjIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6171
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, June 27, 2025 3:35 AM
> +
> +	/*
> +	 * Virtual device ID per vIOMMU, e.g. vSID of ARM SMMUv3,
> vDeviceID of
> +	 * AMD IOMMU, and vRID of a nested Intel VT-d to a Context Table
> +	 */
> +	u64 virt_id;

Just "vRID of Intel VT-d"? the current description is not very clear
to me.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

