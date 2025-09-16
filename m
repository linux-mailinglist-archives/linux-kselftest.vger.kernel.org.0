Return-Path: <linux-kselftest+bounces-41602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E794B59BEA
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 17:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61DD163174
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 15:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E548335BA6;
	Tue, 16 Sep 2025 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S6d4sc35"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FE62063F0;
	Tue, 16 Sep 2025 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036057; cv=fail; b=rwqohIRlogTyyoE81iZARcmAH3qAv4Q00zJlIEtsHhyZixxLc1k7taowqt5mYhu41vfTiE5Ax8Uezo1mhNDo+VadAAlNDPd7HyR+5IpQMsuVNdkcKHE+NUz06amogrw2ZRHzRIyD58bYPViJ2cb8/JYsC5SKw2pl+nD6QUEwthk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036057; c=relaxed/simple;
	bh=ZThAOSL1MNujkEfCZh8IlQUeg0rP1NZ31XIMq6wlwWE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tdX5HNMVh4PdDZsC/ewi0GfVUh94yVFMyZI1d0ur4LhzxdYXYo2NfEPWqvQIOF/aBhm81o9LCVWtdqc+h3VjEm4MQe+vMozFAzPY8khuV1d7EWt7P8h+CwQakwQZRlH1heIM2w/HBNAX+InvaERw6mVZPNF++HKlhlEo1HW38aU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S6d4sc35; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758036055; x=1789572055;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZThAOSL1MNujkEfCZh8IlQUeg0rP1NZ31XIMq6wlwWE=;
  b=S6d4sc350pzxUDXVgYJnT0Xa9WAgLl8yXqrFLB+0as5H2D/qLh9oL4Qg
   UgmoIJ8QIHVFPU/PE1H6Go/gweLqaZsc+qQEFmLu+GQ2aJV8GP5ilzeQR
   5V7Ci83VZb0mvzfXuZYF11s6Y4YzseezSbeiN9+UeSqkUflCchND99Re0
   LEgPFCfrG1zqUV4pAdNkHOVvUwb+PLLO+vgtPBahwc/iMib2uBdogBEtG
   NF9cvCjJYKMCLfasfQrLurb96TBuXphuyC5ODGUL3lz6lpkrs6MOvwM0h
   HAqTSGVqY8RQm7aZ7rdoHUwy3+mTVd7yfL/dvle/UYEA77BbCJ9a6F5Zn
   Q==;
X-CSE-ConnectionGUID: zbu7W8d7RQ6C5i3uo6927Q==
X-CSE-MsgGUID: Su/MWL1LT56uVJ9hW7foxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="82915187"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="82915187"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 08:20:54 -0700
X-CSE-ConnectionGUID: RzdbJXoMTruB6Za3dbUq/g==
X-CSE-MsgGUID: GTkeuo+CRzaG34FDsW+AVA==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 08:20:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 08:20:53 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 16 Sep 2025 08:20:53 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.56) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 08:20:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YmLWsxo16LhRyqM4fOEEKzLrDfV9y+praPDGvUXSh88jOINnFXtXY8m69l+JO5gY1pSG6+Zz/847RRZ59X+xnTTjOlrL+m9ZHyNW6+jrUOdOclBGzC6fSboncIBap7NxObI5BJ6ECVn1QG9ylfywxx877pOjoPdVlpY11Yzct3eyTLEhgJgKcLJVGmgxjDzZvZL9w6uoyMQbOQPGyaHwNhlmR876FMMdNlxBwgFxZQtX4WrR0ELL0Pzdg/Q9ksaZjeJMvj0rVQA5ygQoZfLA1KIUgmB/a76STW6kS17OnV6t0l89T2R6ovr19pvvQpHPpMgKyLgW6mU2A9PIgoOnoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TAk+a+Fiqu53TuQBhWrJUP6y3aqP5pScCSo3NBv1ro=;
 b=irCvYHmXlzKdRPCdDOkCCKqywG0ra/JxTDuGfe6SSkeX0Gq/eTYgO52eQ39JMIsNlS+ErZwOKRN3gsC0fiqbqE4SoNERn7hLmjy/4NwmivUBRN07Zlpzy65ZMqcuqPRc9xf9cwD70pZAZD4VPOO1TzdMMkWFDL4JFDWwBL1MFY7Kcq2uVrkbl+OuIOuZylpxlkAntc3b8sVxjnDp2SKhvt/f03Tx2XfdozstNMc8oqDWN/GRr5tjeSWZCIdKn2kqmQ3MxjHH1Qa1UvjZbdp0HQEyJe9D+8WbLmyGNiUZT5wIZVlrIx04LRh/srpvovrlWxvmT8Lv46JGkevCjf4tmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA1PR11MB7296.namprd11.prod.outlook.com (2603:10b6:208:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Tue, 16 Sep
 2025 15:20:49 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 15:20:49 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Meyer, Kyle" <kyle.meyer@hpe.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "david@redhat.com" <david@redhat.com>,
	"linmiaohe@huawei.com" <linmiaohe@huawei.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "jane.chu@oracle.com" <jane.chu@oracle.com>,
	"jiaqiyan@google.com" <jiaqiyan@google.com>, "Liam.Howlett@oracle.com"
	<Liam.Howlett@oracle.com>, "bp@alien8.de" <bp@alien8.de>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "jack@suse.cz" <jack@suse.cz>,
	"joel.granados@kernel.org" <joel.granados@kernel.org>, "laoar.shao@gmail.com"
	<laoar.shao@gmail.com>, "lorenzo.stoakes@oracle.com"
	<lorenzo.stoakes@oracle.com>, "mclapinski@google.com"
	<mclapinski@google.com>, "mhocko@suse.com" <mhocko@suse.com>,
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>, "osalvador@suse.de"
	<osalvador@suse.de>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	"rppt@kernel.org" <rppt@kernel.org>, "Anderson, Russ"
	<russ.anderson@hpe.com>, "Fan, Shawn" <shawn.fan@intel.com>,
	"surenb@google.com" <surenb@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH v2] mm/memory-failure: Support disabling soft offline for
 HugeTLB pages
Thread-Topic: [PATCH v2] mm/memory-failure: Support disabling soft offline for
 HugeTLB pages
Thread-Index: AQHcJqDfpZlme4fMVEeHtkBl9XAZ4LSVI0cAgABCfoCAAIYXcA==
Date: Tue, 16 Sep 2025 15:20:49 +0000
Message-ID: <SJ1PR11MB60831F028E2FEB6B5A3390D9FC14A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <aMiu_Uku6Y5ZbuhM@hpe.com>
 <20250915201618.7d9d294a6b22e0f71540884b@linux-foundation.org>
 <aMkOCmGBhZKhKPrI@hpe.com>
In-Reply-To: <aMkOCmGBhZKhKPrI@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA1PR11MB7296:EE_
x-ms-office365-filtering-correlation-id: 466daece-5646-45cc-f921-08ddf5349de9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?LSGmjhf8iiQtIyvAfqadrMRqGxqUJdVPWnzEMrdN/pP1dz4wfGnPqp6UXo64?=
 =?us-ascii?Q?12QKt1ukyEVKmaUo+kJf60+EotTrcnEH1CdQ5sinECc7395VH+9lxWpSiKwn?=
 =?us-ascii?Q?nth2YqxaE88WbQdiYSH7I3j4/HQD8mzAPncJsFroZm+XPZIydxtSLtEVrwJc?=
 =?us-ascii?Q?VsoC5UPClWkQL3fK3/NNbeaXfqN2jW9OwPHEPTwlhGSdRMCqJ75qq0vwv8zL?=
 =?us-ascii?Q?zLrjssexNkQPGJJ6uPquTE0G920l67JiuWwGJLApQjCa5JlLut2vIgRJZWdW?=
 =?us-ascii?Q?GkwA5VLbodmlFWbknouGyLW2hyYzm3Zy9r4Bu0Lk+TIdFyJrM/1KX6kx9heU?=
 =?us-ascii?Q?8vg3KRg8sleAJBLkO6RtXY5rZ6MWkWqo4nfyJPhiMJnnN8fQ9VTNXWEHBs/0?=
 =?us-ascii?Q?KjewttKkkRgx0tFtcUC3npDii859my+r7Qqo4DG/mKLz2HDlZyzX1wYArqaY?=
 =?us-ascii?Q?0Q3OO6Il+jUtEUb3oi1WEKedHcGllTDK0pa51QBSvJxfvh5hY2G2soFilQeB?=
 =?us-ascii?Q?gvL/HLEl5QMBvUp64owM4LYeg41uccT0mD8BC0D8lpwXnVLqRJ+Pn/xyNxxq?=
 =?us-ascii?Q?jLVTgPxBoMYvCl3OPEaCVxeab/1NhEl/n9gpAWb9Ju0BL8C+ZzeV+dVy5+sm?=
 =?us-ascii?Q?Bcqr1gc2vONdX4RlSq8oOlOxEd+Xnr672NUWnWbYxf4t67MAon4/z/grp1Pf?=
 =?us-ascii?Q?wIJXMujRa8vnLb+HFqpCcdFdzV7jPVOSyVUgPP5yBKLgFK9tLOr2ev97WQxL?=
 =?us-ascii?Q?FW5SgCnBEmDycbkDy91VK6Yx79AJUTHpZRtPID9VQOLWavJnLkMDO2oB6gxz?=
 =?us-ascii?Q?h1qgxJWPOjMXnLsn+JfMzre7SEKwtjlylchRleLWkeRagcLLaLHSfNyBx4BB?=
 =?us-ascii?Q?dI+L4xp2GfuDYuyBpx35qr2iqrJpn/Xz8CU6/dHCh52+N9T4A2pqT48faSsO?=
 =?us-ascii?Q?sd0yeQnCyrsiZXCvkheuDBj5GxEY1yyGPtuUBeLQNVHUaO6ZGX1BXsFZPrTn?=
 =?us-ascii?Q?UiLTQsihQ/zRyGBr+OL63Vx5SmXPsOU+lR3I2xVBJB8nsS650GNXZFbKhcmw?=
 =?us-ascii?Q?h2q6XPhtZ8vipro/00qYZ7G8vFqYJMYgmFd7zdoSYrdyAIvMQfqbsZWdKq+K?=
 =?us-ascii?Q?GVNdunR4KiChDli4gD24FNtsAwd5hRXiiVnaQlBEOR3aoJlUZGAozCO7Rw31?=
 =?us-ascii?Q?4b/WM6TYPTchyHohC6g3GZYgPAFD52rAUa1oQ/AHJ9QdaqrvtWEr5WZ2dOzU?=
 =?us-ascii?Q?vaO2hms756vV5c7FVuFziYPkiqTX2rH9jm+AKlgBW/hlOslEWC3ooRoSMcSh?=
 =?us-ascii?Q?qOrKuq27mKod+kvM4xDVHeQOrBqWkdAADbfpm6SZWPpAY+WBNcGNrpj1urLY?=
 =?us-ascii?Q?Ov4k+y5Kvh8uWH/PMV605CXn1Mw+N2+mSgkNSX2so4++mO5RkOLqOLCMKLVk?=
 =?us-ascii?Q?J9uxC//qz1q2dmtI3xpx/jSaEyj79RhQOB6yfUlBhpOXSS3yy+CgQA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PefRpv2NRBfTl1ncLFOV7/3NkYY+M+r1Z0ZtBosX61BvdhXLIiXszGE3PSBx?=
 =?us-ascii?Q?dmy5thCCeXYms8s5vG0DyTsZGx9PIBcPNb+dA7jsqJE+sMUn6Te79lxf2T+H?=
 =?us-ascii?Q?KBUzoqp/8VpUAq7twn6o5iXy2aUJjY9T065cRt4ttOZ3srJ/ftzAm5dJLtSv?=
 =?us-ascii?Q?0IEOaO5AIWiaKLgbTAl8sOA1Qm8YBoBeKudyfgpBpbE5/CXg7PsGTL6lLzbb?=
 =?us-ascii?Q?IYfPJU6tucXduTiAd99UmGGqm25oY8wQ+SxQjZWpEIm4zRZwVkB2A9DOxzR9?=
 =?us-ascii?Q?gHe14HHu8SfJQlbjZOYgDgeBcFwIEi0P5vhlDxtiAIfuL5dbXV3OcNlh5vzP?=
 =?us-ascii?Q?HhCvbo0aDfrmiT9oz4oPa6cU0+GRaaKqK87Hmo66nA375oXY5qcCB8zFamRa?=
 =?us-ascii?Q?zdRu2SA2CfoTKF5B2Slk9V/fA4tmWT3MCjWxlRfa7oSdcCckPogXjf9FyGE3?=
 =?us-ascii?Q?JYoWo3cTA33KWqiJAt8YN1lzFLvmaYTiLv0Ye+1K+EKGdMY54ChxFncgDQiP?=
 =?us-ascii?Q?ffftelWisceQ9y0kfguYMU9IQOx+iQgYAKXAOSgM4FwC5W6R7XG9HNRBh5Dx?=
 =?us-ascii?Q?43kn0nlftAbt+HaLvp5dbTUC6rYgnsgTPd7t50hcuwLbrRq4Oe355Znf3V+y?=
 =?us-ascii?Q?nB6L47gYot4OvZ2QoLqPW0VwfKTfyrwJnAxfdvhBYss90ETrzBIPLeUJF26E?=
 =?us-ascii?Q?VCD/0EEO1NDYM4c/tX8R2NQHGEDGHf0JYltDp83n2JNhd0eJ7Qj5Y10FOJrU?=
 =?us-ascii?Q?nwi81DHstJe3MWwXittquAU9X2Ucg6VbebYfP2bvn8RtEG5RhakqJXZbvhsW?=
 =?us-ascii?Q?A1oPCsM2DfFADaDZhRkjkNL/PdLe2pTm6jlqz7o5blL0HGBNgMmJ1f15VTRN?=
 =?us-ascii?Q?h7BgYjzhIUJdZJhnDOVNL0eSDKcd6Dn2nyPxlLWxACfyeFb+muojyHUrp5Zi?=
 =?us-ascii?Q?V4kBBbGTiCIIrPlVi040YUhSGKLRIKMaaIJo5G7rN35FE3A8t5A6wvWTfHq8?=
 =?us-ascii?Q?5TWnK+ccMjrRHI36tRRCaQUQBKkB2EcoUDdLIJk8wva2pylI3til0wN/UEVm?=
 =?us-ascii?Q?o8BuRr1IKkrorbTLw0LUiAPLxSyM7kM6bc7wlD64LGetTobPL9spxas87WFN?=
 =?us-ascii?Q?2/4yFMe2pAxmrl+6C4DMkJDzw4/VgLuyyRVAxPWnXpWN2SMzNsjESaK0d8Pc?=
 =?us-ascii?Q?IQmIgDzTG1BnMUybe66rmZxrGljI/36HMH/fNt1GshClxPF36vh+TJpRJR1A?=
 =?us-ascii?Q?/hcljTQrrkkirjlocMgdoDzLkWYRM9+RFpTV4Hn0F5tCIOtiO7SHKGSYx0PF?=
 =?us-ascii?Q?ilxlxj4chi1WvHQdOwVwc66d9RQIb1KkL7t5ZEX0fMcPnETDY7kLAEhdWse3?=
 =?us-ascii?Q?KwI67MmJKEQAwVwO/RvZhqeSrZgl0d25zOMbtUFDp2wQEfZVejHuUWJjWEUj?=
 =?us-ascii?Q?f4RLLkE+P5DQ03H4HFJkFWtEP7Qj31zVV2sHuq1tvyoGnOuUOSTHQSjWDmoi?=
 =?us-ascii?Q?jgZqLRcKGB3nSwY2aOEOfujaeccNnzMOVZZPZ1zl15//FafnJ1/yLy//fk0J?=
 =?us-ascii?Q?BgKJikW/+qwZ6Y+by/o7XUmbKHc/fkksMaCcAHaB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 466daece-5646-45cc-f921-08ddf5349de9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 15:20:49.2472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cPFMQziRYHv3SjONFdCkhE8AAVXFsajiix1SzqmRQ7GJfUDHqHOv5KR9DrioV2uCGjobqQnZY4BwdL9Bryzq1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7296
X-OriginatorOrg: intel.com

>> > Reported-by: Shawn Fan <shawn.fan@intel.com>
>>=20
>> Interesting.  What did Shawn report? (Closes:!).
>
> Tony or Shawn, could you please point me to the original report? Thanks!

Original report is internal to Intel, so no useful link for the community (=
but
I still wanted to give credit).

Recap of original problem is that some BIOS keep track of error threshold
per-rank and use this GHES mechanism to report threshold exceeded on
the rank.

Systems that stay up a long time can accumulate enough soft errors
to trigger this threshold. But the action of taking a page offline isn't
going to help. For a 4K page this is merely annoying. For 1G page
it can mess things up badly.

My original patch for this just skipped the GHES->offline process
for huge pages. But I wasn't aware of the sysctl control. That provides
a better solution.

-Tony

