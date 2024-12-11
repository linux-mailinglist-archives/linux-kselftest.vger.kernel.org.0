Return-Path: <linux-kselftest+bounces-23163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D799EC661
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 09:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 087071663E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 08:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FE21C5F2A;
	Wed, 11 Dec 2024 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CP6OgkS5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F5D1C5490;
	Wed, 11 Dec 2024 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904174; cv=fail; b=lEKy26vGdKOX+rtGleea2uNtxVweRrxY0srOpW1f3wkWq79k3uFF+tVPWwHX5A119oy8QGnhBcVHiAZtqBDxjOIfEXb5GH+Ah8xeGBoG5WN4o2uECW2sRdv86I8is3VwXf6vT1I/FL2COgw96mCJh/GGcClDHGGvuzvh1aMBJq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904174; c=relaxed/simple;
	bh=KUQ2HvXF7GCRbLU1MD+9ZPIsL4nAkOKlckmV32gfRUM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=klSZLEg359LFveDCUFZXAki39eMgcdB+gEgrK9NSQ2gzx+OF+t9+WB47YnO0jP6Otn6ZcAP6OVBtJFXei7FpQLvl8LqUNDsG3ZfYhJPh/vpScxglCp3y8NAlpSvWNFVEVITbZdAOkW/4JLShSeCPpnONZSjFjvYht7oKcdD6OuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CP6OgkS5; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733904174; x=1765440174;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KUQ2HvXF7GCRbLU1MD+9ZPIsL4nAkOKlckmV32gfRUM=;
  b=CP6OgkS5uU3XoafoMgZBF4ny4ZrCijFqFVvAURgXXnPQbHxJNzkbZXQx
   3B8hVH+V8XLT+0rVqTpnGyw8jIArj1tlr/e520MyuMr+3qm6+ZrqAo0su
   s+7Wy4LvB9W+ZqDD0nEnDLz+JA2Y/tG8iId+nJm7nt9L/hjM0z6fr7Qp3
   u8iGqWy/Cf4JZgnQtnAJaCHEQrPi6Bcufz86QY4emeQV7Kih3t+H+w/OY
   0YccF+c5Qsx/ybOz4tipmE2NwLdwWruV2Fl0/tWTeC1vvFKd2+pOHrJdC
   B7MLZEsa1O+7uD/aJFeOABuy7/++pnNRkFfNtHOI37PV6pXG1hWC7jzLf
   w==;
X-CSE-ConnectionGUID: xK667KJ6TsuClbuC52Mpfg==
X-CSE-MsgGUID: XL6ptfP4TQ6xz+nx0Q0xrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34150758"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="34150758"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 00:02:52 -0800
X-CSE-ConnectionGUID: 3JJiX4nBRrqtmcRxB6iqAg==
X-CSE-MsgGUID: 8L/1D9FwSwWtPLPi0nuaJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133095931"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2024 00:02:52 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Dec 2024 00:02:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Dec 2024 00:02:51 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Dec 2024 00:02:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EeJGC8JQSoUCCpCiXDgnuQo0lPgA8Vy2OnMOwscynTdr/a/8WCGelgQUkytpDHIumISk8kIFVmNNMxWqBLuVl/FP6OVzSPluSgzsDZQnuzgFYS1RpW50ld/6TIEBDU2vrw+c0+8ukSevbojsORuxvbi6jbXq1QY8qyG+hljMI2otF5PcvG3/5taeAEetrwMYXvYI8LyQ7ZhkQOGCyAnDWR62TdF0R7g2OB673Fyo+lC9MaiauFeZEHbUpmW+gx4uirY8F1Mi9Y/8QIs9Mx5kqkyzgMbpUR5hXJmId+TucNxIFfrvReuC83rBFrwoAdwq+qdVMz1EXm3yTotu6FUYxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/F/GnmKHUGcjYez1bu2AajW9wl4djpT8Tr/U/+1TlbU=;
 b=KIpj7s4nWkV9V2NHcEdzbZVIQc60Qhl6a/sa1DdfpZQNq8U/kgTnUjXaCFVJ7KM0Cx4XXXoCqCi4yMdxg9XEQK7PWrBXcfnINApMQS6xz2NGPUqX4cA1lo8myZFcCWE6NQq0kdA0j0HqSocfgNeCmKroMLFx1Ehi6tWmes/zeapVlcjDdMASjGKUQilt1y7DRGm20UdKZDkkGEb4gbUZ9O76JeLebTfCI279XzGeRiiyPyhvKW3/34b20CGCZOFT6yTVt3FzBAjAEHtr5LlHxavb1af26anPZL5Js1qDeJnvn1X+YuNEBM1JsTxoS+MVJEjM1kEO+OeIMUY16qZSBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB8207.namprd11.prod.outlook.com (2603:10b6:8:164::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 08:02:48 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 08:02:48 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>, "mdf@kernel.org"
	<mdf@kernel.org>, "mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "ddutile@redhat.com" <ddutile@redhat.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
Subject: RE: [PATCH v2 06/13] iommufd/viommu: Add iommufd_viommu_get_vdev_id
 helper
Thread-Topic: [PATCH v2 06/13] iommufd/viommu: Add iommufd_viommu_get_vdev_id
 helper
Thread-Index: AQHbRdBHdskB65/qokySWpmil3JWPbLgue0A
Date: Wed, 11 Dec 2024 08:02:48 +0000
Message-ID: <BN9PR11MB52769AB45C92A820CC5233068C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1733263737.git.nicolinc@nvidia.com>
 <d1e5f16d2fa4e9950e9caa93c5f98a5115c1580f.1733263737.git.nicolinc@nvidia.com>
In-Reply-To: <d1e5f16d2fa4e9950e9caa93c5f98a5115c1580f.1733263737.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB8207:EE_
x-ms-office365-filtering-correlation-id: b09bbdd0-c244-4ea1-d8b5-08dd19ba3449
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?orA2Y3krOymnK4eGjPUSEN+oFOo8JLZUZEQTc+1UhTDHI3Fy1BoIih4w6vPj?=
 =?us-ascii?Q?V1F9C3Isy4trL1cJd9kJ+YhjS6rdz2GeWyhZlVyn6OMz7rEpX3K5R4WzuQjT?=
 =?us-ascii?Q?s5+WAe+j5dWtaY4DA3F14cD3x/sfNRKQoBfCySJZrfXICFx47O8HsjhDEjfW?=
 =?us-ascii?Q?8TYPoYEoQvSAWwKCyTmk/unEQ1WjKByzEXn7NMb4vfRj9qaRCcPXU6dMDN7s?=
 =?us-ascii?Q?tXPDNNL57XxThuDf9vUHJA4mq09e965v5+TTH1U/0WN5+83umc5o4qdxDcKu?=
 =?us-ascii?Q?MLdSDV1OXzcXv6UOwpBzOvJp9t8moFVOUsGQkexv6h8PtB5Ke88jsWYfjso/?=
 =?us-ascii?Q?e3M5QQXO/E/1iSGwT+11aTYp9zs5FnO6OhaaJyAFARU9mq0U7hh9mXMl5k+P?=
 =?us-ascii?Q?DWK7vzY1xokOcot+8+IxZtskhmalqv5mU6BRNeFKZaS36cJejRunczakh/h8?=
 =?us-ascii?Q?ujFcSJuwPunToMayey4Iuc14re1Ld5aZgEr0hDda2cGRVLE/mGYaFsa2e1jH?=
 =?us-ascii?Q?VwAjxqYwikrhpLJxX38sAGNhdxYIwYtF3ILGtNbPDKM8dXAaC3JPCqwczDdM?=
 =?us-ascii?Q?anUmwwbVz/RYloHeQJSiOnHcCTTqSkaAHvvNqaUQKGQtq1nLXRuuAdEyZwXq?=
 =?us-ascii?Q?gr7JNEuubemFd+3jSOivhFwpH73zo9kTKunFiS2EThcz31K9ockMgx+T4mEy?=
 =?us-ascii?Q?OgEuRqGqC/YkCdIp3c2jnLGxFpQ7WOK75MNgdhzieqjDmWMqvvQDmeDrf0PD?=
 =?us-ascii?Q?NsZVAVqyktQHMR7UlsQkZ5sPb2yLMA9a2P7ARTTZ9T1U40hs+O4KRScM3PVL?=
 =?us-ascii?Q?9/ataXu0eRhDqY2Tley+74y8utwbwtJZJfPFanuRPdaIsgVp3cxX/P+XFt1r?=
 =?us-ascii?Q?DTW6Qdo8vAh85/2yHlF9ObwnRNn5FWHAhqD+IeHxpHHrX9YUBwkAX7FlkFN+?=
 =?us-ascii?Q?j/ocpPzdH1bRoySCBW12URsg4dWITfNNiPnENgNzNdBjFGq6NMqkFbiWhtgN?=
 =?us-ascii?Q?jGy/tYlWEdKfOBGeAf4X3JHq8llUbY9u8Bs9zhgAozjKwq78YvQ5usWK6v7r?=
 =?us-ascii?Q?zjWpAMDZxaVHgAMRKpwVNfUKA0g1ORvjF3k6vS24yZQ4X/CUKJ2kPJXbwcYj?=
 =?us-ascii?Q?SX7EV6NHTk1/ePQDu27tDEw7wUsAT23iTgJCN28Ls/Ewodn9nyqFlR98ssCB?=
 =?us-ascii?Q?/5lBCz9JfZ/uawDi5sNqZPA2SR6VVQn5e+of20dDnEsOelfoMtmQfk40jsp/?=
 =?us-ascii?Q?kjsPh98NvKSm+IkWXqFXR+aAyZBdLxl6Wor5OkXYMm5wOQejiBZ3A6Aym64j?=
 =?us-ascii?Q?Vh8RcHp2mqYb/w+g/2L/q8k5bTSu4bq/20g3XeCD4cfitrqmCs4FDiIr/yOd?=
 =?us-ascii?Q?vloEXOCq1CLlZRzP90L98Owr324pIAEQ5yk5uU6IoBGnBkRClQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cSubjdgVpkltrazTcRmfswiP/WYsLVC9fg5kaae/UnK101FwGJOHouxF8CxD?=
 =?us-ascii?Q?8zTdfe1bHNLI6mqkVPfuSJkUi7gscJP+Rsj3qOR3l6KMNSuJX6xnrMxeLX4+?=
 =?us-ascii?Q?U6RXExt6s9qRN2iERVgGPa19bq+wMfLD8EMpjnFiauPwXMqvIrafuGMVI6Ps?=
 =?us-ascii?Q?JuF+LM8oyhg9YMi32dmRoqm5vnZ7hxNAPl3QAYMzGuQohc/W0JO5yq2j/wnP?=
 =?us-ascii?Q?rlgOBcgqgscFEgEb/ilzrj0dlsXBOlQmIXuntThB3DzgmUicEev0KjWpmNBb?=
 =?us-ascii?Q?vqJolDT/NtN8/sHqdu5JGRmuP1Mhy4Vg1PRJrfZ7n8YRcfGLf9sOHDhKshsJ?=
 =?us-ascii?Q?OUPuCgEZQPtIKdHVls/oXUVGIwQ2QK4e2PV5DWL03xS3MUqkUE/dODld+Ihw?=
 =?us-ascii?Q?chIl6myVy+YorRDuLJ2UY7d73PIU9WxPkQP1XUnU7n4BpWddn5b/Y4XzJO9n?=
 =?us-ascii?Q?5KnwuhzIE0aViRr7E+pLdao6wTN+/eaFAEMOClk0+etu8eXIkfZzUBkw8Dvh?=
 =?us-ascii?Q?pTFl2Izp4cSke+UuAIJbHjhaOvlEpvj5+HB1AsET0TvU1/sq8b/e1V9OSudV?=
 =?us-ascii?Q?EBImkkwek3tNKEGpzU24ftrzSitFKpALkJFaEXrvbWXORYMhk6+lEYyJOf9Q?=
 =?us-ascii?Q?XyF0JxAsawolGvIjoiz5H88ODlUTTCARnu2pW0VXsR2b2YBjSH+PsxKlDLyC?=
 =?us-ascii?Q?YTiOxZpTnvNLdeghCWQuZnUF4TG1xOQnoPl3XDRwfzNZBCCk6OKLFdTc2tzc?=
 =?us-ascii?Q?tMoz9dQrT5ogb50FzSDLmCxZYDWdFckuMBoT/L9HxMOqVJJi7COf3Czz9kWF?=
 =?us-ascii?Q?wqehW0sQAsVZQ0uAhW+2Gp91UwkR9R0xERQJceg5kDznJWgZ1+XP6CTdGj3q?=
 =?us-ascii?Q?GpWZ3HdZA/GE8arIvM07oocou5tjsm9IAbkul2SY9wk1uRAMxJQSdFZt3l3O?=
 =?us-ascii?Q?pNSgwq+6rA0IMRkWKYVJzLUsNDCtx93SWS2wrSHtyFgfFZcLF1odwxsKGiH5?=
 =?us-ascii?Q?jvjyHLOFjC3oTB192zA0jtGPre/vBFnl1+FRL8P6pG8zJ0sRxEGQiQQ3iBBa?=
 =?us-ascii?Q?zYa472dySuBKe8yw2B8ZmylAJlTvxvHLSJDWC45j+c7z5AoXVLiR33pcLU+Y?=
 =?us-ascii?Q?U6/V/0jV+HE/vU+SdQ8i+jmqJgRKzNPL6nno8o4ndFRDeJ5F7DMOxPuTWuDy?=
 =?us-ascii?Q?NrC+vMwnCZvu5olC0+aesJL+Twi/Yd0+PPHS+sZN/jGkRyuOlJQVHyfuuXJ1?=
 =?us-ascii?Q?ZDhw53AzPi4gU2XXmP3kWhdjKsfTnL/O03NQJoulhYl4CSm5DzaLrspTPxwY?=
 =?us-ascii?Q?n2JCfZicm3DBSkmR8tbvi1Zv9A1ko1JIfjOoCXR8SP6zMnFb9sKgx6bRlxU7?=
 =?us-ascii?Q?foUGHwi8txw313bzEa5eqy0tGs6ylZUB3Bpo8lW0LN6EmSf/1O6pqrGSrwfF?=
 =?us-ascii?Q?3KN+wkQXhPXMwca64O9cFd+WJBvwuc0cJ32vBvv5nLmnUu78V01y29JKPD2w?=
 =?us-ascii?Q?NnlVF/Jriv7abgIvErWftIOkhmExHvLHnK5EV61ZDj5Mq/u3B28lyrcAI2BR?=
 =?us-ascii?Q?NxyuCOsxIn2zh0X5C3eNFbEov0yyXUKfZpia/M/y?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b09bbdd0-c244-4ea1-d8b5-08dd19ba3449
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 08:02:48.7823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h7Bh0G9D6/2JMpXt/1i/W4v54GRht825xZo0/rwPlArGO2e6TdsGPEOQNT1KIGmzVdPkhIR1AjoGcA/uZ2eTbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8207
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, December 4, 2024 6:10 AM
>=20
> +/* Return 0 if device is not associated to the vIOMMU */
> +unsigned long iommufd_viommu_get_vdev_id(struct iommufd_viommu
> *viommu,
> +					 struct device *dev)
> +{
> +	struct iommufd_vdevice *vdev;
> +	unsigned long vdev_id =3D 0;
> +	unsigned long index;
> +
> +	xa_lock(&viommu->vdevs);
> +	xa_for_each(&viommu->vdevs, index, vdev) {
> +		if (vdev && vdev->dev =3D=3D dev)

xa_for_each only find valid entries, so if (vdev) is redundant?

> +			vdev_id =3D (unsigned long)vdev->id;

break out of the loop if hit.

> +	}
> +	xa_unlock(&viommu->vdevs);
> +	return vdev_id;
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_viommu_get_vdev_id, IOMMUFD);
> +
>  MODULE_DESCRIPTION("iommufd code shared with builtin modules");
>  MODULE_LICENSE("GPL");
> --
> 2.43.0


