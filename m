Return-Path: <linux-kselftest+bounces-31235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C963A94D97
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 10:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81119170D61
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 08:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142E613BC02;
	Mon, 21 Apr 2025 08:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K1sgSQ5i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142B2F9C0;
	Mon, 21 Apr 2025 08:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745222470; cv=fail; b=aBywZAwS1MqS+VqItX+9MLgBjQLC1MoxgbdYkV70iGoohpp358LU6wQPFyopEyaE4Jj/C54iYwUZ3EnNA1QcUaR4zKlSCHWOcfZ8U1Mju6+lNJHrdFu10aonHXFD0S2fXy7tleBn1BF0lFASixvNMNSCrsAs/GMrtJqEfxUiKos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745222470; c=relaxed/simple;
	bh=nbuwpFHm9j4tblZNlz8AlqVhvLhgzrqbu+s2MZKHhjs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WLqF1YUMjEYYmDDOX8KPO6JaedCSqbsg1SGwFMRiK8xRISvqk4oIsKqWOoEbssOUkxvsj+WGgwW47ft1PLHcvjhNrjc/EiYDVeZ3/VKSs/2JLkIYamGbAtl0fAKTOPUfGv6AHMYzLe2G1PUkqO6PMhEz0llAaVC4QV0+RyVryN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K1sgSQ5i; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745222465; x=1776758465;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nbuwpFHm9j4tblZNlz8AlqVhvLhgzrqbu+s2MZKHhjs=;
  b=K1sgSQ5i14ZnX4daqpkhAnTuelefsWKSYSl6rTHcoC58Vxb94lv17bJU
   krxnKZoHZt+PQ2s90X4KuYvJF/dpeCM9rLgzR0wBbkqJ3mjI5v7JhqW7P
   njy1r0TBU8bH46yzI/7K09GYzg1SOZ6WmwFIpWHAL6kulnhQzTR2CiHAw
   Q8EI6F9WyNdwyf+8VoOa/AD5AA9YXX9SC1i60I+mFx1bLPzKBNn449CG1
   WzGIb06DBg3RLwf5NGc7XO/kVy5wg9EaIVn34YtsvVrOSFhv3fSTpMYDr
   GCfzPWm79MzPm5AlJb4ytPlVT7sFQyBq4KJmcHHN+8EM10F6HPhaJfNGi
   g==;
X-CSE-ConnectionGUID: nNZ2vKQmSfe/4ESf0TIZ3g==
X-CSE-MsgGUID: fwtSjchtSYO2QJed/QLq7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11409"; a="64161787"
X-IronPort-AV: E=Sophos;i="6.15,227,1739865600"; 
   d="scan'208";a="64161787"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 01:01:04 -0700
X-CSE-ConnectionGUID: Udh/7U7URo+jCw5acA8rxQ==
X-CSE-MsgGUID: tN5KU/fLQjaFcbDjpQiitA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,227,1739865600"; 
   d="scan'208";a="131569485"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 01:00:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 21 Apr 2025 01:00:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 21 Apr 2025 01:00:40 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 21 Apr 2025 01:00:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZ4nM7PXHhNWbNVamYrIaMrktWAqVUPygjibwzPHZhqwOicHT3B6wXVT0y2k150GWOZV+OWVmEGTh2KxNrB5CQl8w7Ulo2tL+VbYa/LL8y41F1o9FLYx8MS84qvG0VZx1fMvHOl4OiPIornRvp0fKrNcuU0yNBQgcDBwjJFncUWUg1HPGL3TnF5rn3h/id1ChkqNUcf2K1Xbzhy5tJDCz12KsDm1V2pflrypRX0W6nzQ4orS39YdgOkYTMWhaDg1W3nsX1G/NBukNM75vbdoEBE1pVTJCCijmpHQguXa3deuW0++m18CawePZFJXhM+di9xJ58XDL6hqrSgxNixwBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYSSAPxrS0IdplOkK/c2+FX2wz6CzvJkaMUT7qHYCbk=;
 b=GRtvozE7OYjvGw2q4wky+VLpjZHCZGQumyzz5CnFR9znb+aEXFBXW8X2OFy/Lzvxfx/0VFluaHUnpnCkOjxa7/mjfzIryazgne35Yhzkw5ZVK1RIXiEkKZDCkmEBgVaBllyGU283y/37QybqY5wT5a2G6hAEOzntboW5riIBXo/3NNInUolssc3gDiPmB1X5ghCxrWJuJDVR3GOZtSSYXPBCyLdSLcnyfuWc8+xSDPg4RGTQ0ThvGQk2Ba+DpQmzJ0fxLtat1WgFVVhxpOqD+xfPzy9cY/NEv8QWHTD4WVEM/xC8tZA0eIc2UP3OCjKP8faFWCFoiWmwp0FKyb1F3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ5PPF5DFCDEDFC.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::82e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 08:00:37 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 08:00:37 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"vdumpa@nvidia.com" <vdumpa@nvidia.com>, "jonathanh@nvidia.com"
	<jonathanh@nvidia.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"praan@google.com" <praan@google.com>, "nathan@kernel.org"
	<nathan@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"mshavit@google.com" <mshavit@google.com>, "zhangzekun11@huawei.com"
	<zhangzekun11@huawei.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: RE: [PATCH v1 07/16] iommufd/viommu: Add driver-allocated vDEVICE
 support
Thread-Topic: [PATCH v1 07/16] iommufd/viommu: Add driver-allocated vDEVICE
 support
Thread-Index: AQHbqqxj+R/ibWUos0Gs+XtXZ1ED0bOt0Tfg
Date: Mon, 21 Apr 2025 08:00:37 +0000
Message-ID: <BN9PR11MB527601845E1E55D02F57F04E8CB82@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1744353300.git.nicolinc@nvidia.com>
 <349fa2c4c291488bb5bae6e4a8bc0dcbd0c51fd4.1744353300.git.nicolinc@nvidia.com>
In-Reply-To: <349fa2c4c291488bb5bae6e4a8bc0dcbd0c51fd4.1744353300.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ5PPF5DFCDEDFC:EE_
x-ms-office365-filtering-correlation-id: b82f3b01-0aec-439b-2323-08dd80aa9a0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?90kJ2o4zjCiI8TzeZHN1GQx9SLoSAKFlWe+ZxdkBGDddWShJ/kPZ6MrkV7i9?=
 =?us-ascii?Q?JYBCs4xFsKB7kTu2lDQ/puWgvvg/l82+STKQZIvXD+yF1dOfxHrpr3LQhn5I?=
 =?us-ascii?Q?qCwEYQi7ydjV2Ivmxanwi3pcbkXRHAZLIf9ab6klpPkRBAQOTRfXAOgKcAOs?=
 =?us-ascii?Q?jjuMbuTan6AVezYBbSDriAhQL6tAHEhGA+zy/VW3vMFO8DjfuEsmygBqzMlZ?=
 =?us-ascii?Q?nr5beCH1uXK+hiZpclajPKAZpDKBifyolsLLbhk9rhp7PNtJvLghQbOF6PEJ?=
 =?us-ascii?Q?YLEjeLHM1Kx/9+oyeOM3YYxn/W1GR7aqtf4DIAEooosuFKsJNcsYiEKZF3xC?=
 =?us-ascii?Q?bDR/VRphyPQz9t1cUXr3uxMneiGjqFdC5h0fMKmuwa5xJ/jhN4fg1Bo8cA1P?=
 =?us-ascii?Q?/OJgcpJSGSW7hZIk3QBg2x2+ldEzHn+7yKSh5Ta/Qvj55rfKKNTFHI35H2dB?=
 =?us-ascii?Q?j6h6c7AQg3wTofM7+5OPfKEpaewXPTvoLl6AIyg1+b9c6fpquuRelHPIISQQ?=
 =?us-ascii?Q?ncOcb9iZUu0PAGuc5bgdM6jbCIbiRQssnXqzEJXGvhJ21MK34T7wlU03LTTC?=
 =?us-ascii?Q?AeU7o4kOiXmqsRERNoFzNcFs5SFvhX72GlHa09f52BHM0aeD5N9Pdeng/dFX?=
 =?us-ascii?Q?ud7vO1PaAdRWe3i3m1xKWyMNk83W8hLlIIhh9j+RHMq0m9hNSyZOfKdNDfbx?=
 =?us-ascii?Q?JplQwqbpiUm0Jlnpd+CU0AbNs3gG4hMIgCpiAflJ8ROw/WsqLqXsV+Gv+u6y?=
 =?us-ascii?Q?RKXrGvbwGqGFD96zvHBxtqj0/uu9S0GHxiyPcl5VMqHbDVg9tczLnQvrGAnJ?=
 =?us-ascii?Q?lUGVtMaD2c6RpkhwYXv+yqxzDyrQte3z05t+9AWWCcEhtDVnsPLyFFexjYZG?=
 =?us-ascii?Q?0odaupKSefRyhPKUw/sOwOSCxHD2Qd5ttNdePmBG1uPzC1v+/N1HgbxGr8L8?=
 =?us-ascii?Q?+I2R6BMcjkZdP+COsEm20lPoOoXw+25M0fmb+hae2oiuKUaJiYX5dWB2Fbkk?=
 =?us-ascii?Q?IkM858oVdFvoN+dXBeMpEa4X1zCGhPiUYylHgCkxmGq07E5FrLO+6HJx4gMi?=
 =?us-ascii?Q?rceTAUN5Oyfxtkp734Eo4djnd38HWEp6LdWlh5p5y71CB7OH1EyU1sAIiken?=
 =?us-ascii?Q?xiSgJMMpoI/HaWU4i8tWIZtIGgA9PBVDStqBiAqwua/I0Q/E4oCVBqFLYRT2?=
 =?us-ascii?Q?uWyrDr5UNjoxjIRf5c59z7XmMGM5glC1HZL4DaCGenXtOXWNu0wQEOobHvB1?=
 =?us-ascii?Q?Fe/lvOOX1z4CnHWFvudSoZpEXQW/RA0uGuOENxJmcf4wdUQwGWegnHjZJxmc?=
 =?us-ascii?Q?qzUwQfMn/x5dXR6SOJSswcrG+O7GpWb+jfotl9OXDDKHB92/XIJYlvO4YESc?=
 =?us-ascii?Q?XLqP+C4QPX+oTnbrJdEcfo04+Gwq6XJmeaRl2O26tNS6va2U/3/FH1NGesQq?=
 =?us-ascii?Q?9Il6fs0C+xfzfGMrDjszDLwiAO5u7JAeFP7TKkqY3ZbmMAH/+3rrcd+DK6tI?=
 =?us-ascii?Q?4MRlU6ILFqZ69yg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?idYlSNq1vB8HkDCcu4vcUwd3VY+P5BQY3mpjGRzUVawcwAEjFx4TrX3/uz5Q?=
 =?us-ascii?Q?k9IuOcJPkus1Ubt1E3KppKxxaIiz6Us1jjoP/4QKJOhzl7UpZ9Ve9/Pbe/39?=
 =?us-ascii?Q?sPUxJwHVOvo8wm6ATNXqy/LbCr+gzH/zFIlJorDk7SMiH5Jnh7F5kg4EMJM7?=
 =?us-ascii?Q?A2mzPCxzT85rKmDWeFdjJzQq87FWjU0N+F2Dt1/RcMoHUWLhT0RLK9XmQkZW?=
 =?us-ascii?Q?/RkwKqpiP8IZTo4fzTh3Il/e8j80yX2qDgCddvdiXDwTLg8Qfs7ll4rcm4Zq?=
 =?us-ascii?Q?RKJhMvOLgr+0qwFsUXEYoGpLvgWcU9ZwdqJBh2BfWQhpXeTGfvbOyn8kcHuu?=
 =?us-ascii?Q?covIseNkgolXuFx+DXSAXTUlo9H4H8OwrIk+tZGwKLlA6sQpKOXdCXIq7NMh?=
 =?us-ascii?Q?0pNUKKbLmERNBL/OsM5yNQNoIEz6Q8UXUSzjus1sNEZV7xtS14PTtXxDzsVe?=
 =?us-ascii?Q?qudf83vE9mfMwW79iZMw8c82xqKh6Mik7SMzO63uAVf2xW/R6JAfqtcmG1GT?=
 =?us-ascii?Q?oVYZE3XmxL1bcK5eEGW2yUgLjlk/NTYHb3TJxEYEWScspcdC5EDcvOOapswe?=
 =?us-ascii?Q?BZ/iEJZBi/2Qd7H9L99+EUW82qoOWGxOaJ+8TTe52pTTLjmRl3cZePifX+n+?=
 =?us-ascii?Q?WoiZv9OS8Y4c6HLqMepsohaTGKvwIlxgZ8sQibpKJ518uV1gKY4WOsJ1UfRw?=
 =?us-ascii?Q?pc5VUE3sZVItBbQx4gA4jDSi/6RtexxhbNJ8hhRb3yFGGGsWJmdQcF2SE870?=
 =?us-ascii?Q?O0eDFiagMbfrkak4HUOyHW7JbohQ6Q6lkAQUXOlMYUze5QiXhrMpmF2ufzo9?=
 =?us-ascii?Q?tbPdmq3FF3gcRZp9uT1AxIaaHL2gIi9KWeEyDYFVC8ZBT6YDGT9zP0Dqnm+G?=
 =?us-ascii?Q?F9ldTBkeQhfS22nMd4LY5kxBv5Aox2bR8Rypg4NQ8R9dtwTqsRR9W49U/yQ+?=
 =?us-ascii?Q?pdLZatFjhyYVkQdovWvyppgJFRJrdyDcqXTQDsucPHaFLX4CJbtzpQwSc1zr?=
 =?us-ascii?Q?w6ltzcknhOKL1RfxZUQ1ITOzHnq+ivKK89rwDKFeR2zyf9TOIY2CGIH3zQWE?=
 =?us-ascii?Q?rrnOdx7ULLyGf8uAc5EO1OveK+M8ZWIqWbHcMMPDngE+QOsK6ACUKThKOLep?=
 =?us-ascii?Q?WTIArC2hP2LX6ebsVTUNe445rz6uTL6EfYi2TQgfvkm9uoU3Gr1N6GDkqjN7?=
 =?us-ascii?Q?SA4eAw5CL4MX7cT8KG4S3xfCeOxIC6mqO6jngBX+v/64c92etM1s6pYEGwYD?=
 =?us-ascii?Q?ohQB5bO5Ga5PYcyIckREr0YENuYOp1U8iCgBNvFoKDtdl4AZcIlBJa53tfg5?=
 =?us-ascii?Q?5pUL4vsFqOSjbOVKzTyVRJu2ZVli1hxN1C/9x5s7ulbNB0SN9F7eF4QrbHYU?=
 =?us-ascii?Q?ViVf8XW3iIyMexsJdlQnHP8MQjinSbJ6fCUsirgE729ye8WvM6AKUyDazUVe?=
 =?us-ascii?Q?Cxlt40kC2GQLPf/QafsP6tN7EMDAVD3m5HhSuJgdFMhY7WnSPlod9sSOQ/dP?=
 =?us-ascii?Q?y3wh90eExDSrgtKFjbDM2ATEZVhoPf0SSAfP5knxt6QirCFqUKujaDLulGWn?=
 =?us-ascii?Q?gGPqSt4FbeFZ0m6WA39dxKi78YzYkpcDCXfL5REi?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b82f3b01-0aec-439b-2323-08dd80aa9a0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 08:00:37.3471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DuSbmMUaVwf8kzKBcZsb17ZHCteBRbIcmFQIpBUXzhFtrEMhYKkjV9RilDAEIuJVzDIR9IfyT9augxm8haSZ/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF5DFCDEDFC
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, April 11, 2025 2:38 PM
>=20
> @@ -128,6 +142,9 @@ struct iommufd_viommu_ops {
>  		const struct iommu_user_data *user_data);
>  	int (*cache_invalidate)(struct iommufd_viommu *viommu,
>  				struct iommu_user_data_array *array);
> +	struct iommufd_vdevice *(*vdevice_alloc)(struct iommufd_viommu
> *viommu,
> +						 struct device *dev, u64 id);

s/id/virt_id/ would be clearer.

