Return-Path: <linux-kselftest+bounces-6397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F03787F187
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 21:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74CF2B221B5
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 20:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FC226AF0;
	Mon, 18 Mar 2024 20:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RXQZaXYa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61CB25760;
	Mon, 18 Mar 2024 20:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794867; cv=fail; b=mdV161VyvmMypCBmt6jROKK90YsYsd6fcsmXKT7UPDN6gCeaI79I+hL220XDRqjVL7qYrg4RA6GRiVxm3/DVW+CjIPEiSJ122m+zyTBxi4VimUCaC8oy/+SxIqvwPaZGOppqF/BVBOi/tdSVc5PfqjdyTOm3lObYDC+wb02IVIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794867; c=relaxed/simple;
	bh=GrnrWkJ7PFY+s/4NxtD7e/mIOQ/TFWi/UeVFIG9Jf4U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KsMbvlXicloL6N7RN3JsL3fj/dDNRACHNaEDblFgRlHn+m2FUFuXc1l9tRWMtnz0A8gC5xl9GYZFjJBzQfnBMgJb4a2XjFjTmqWnLeSfHKzAHkUhpCZM/I1/Yf++XcZS6FGWye8zO5SDH3A44f0C386xxErus8IEQahQzqVIu8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RXQZaXYa; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710794866; x=1742330866;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GrnrWkJ7PFY+s/4NxtD7e/mIOQ/TFWi/UeVFIG9Jf4U=;
  b=RXQZaXYaAhSaDPie+kjZZot2l35OCW/FIYUCIdvA0ZTLRif1CBcVKFIU
   huaqMlf/5tF44M9XEiXPMqjO5G4Qylrt0WQuO0zKxTUab0OBPMXHJjhup
   q8IEdCp/9zFww9G7YbCXC3SQZmaCTIsEFBqoJWPfyNKmigDthdRiugmTR
   QuF1IQAKfY24wwHeHQFrG3nEkBg7IJSDPMxzA2Es4o3oEKS1LZNsdI+kK
   l0JeBrljHOiQNmTPfgMKBWIBU5Hq04UeCM9guVlKxhaEOkVLp6l4/0WTx
   Sb001+a3IKjCq+V+fyvhI9h0sp45GJwjoX16FM5wJWExMmMk5NWZ6+NZC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5483503"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="5483503"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 13:47:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="18158430"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2024 13:47:45 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 13:47:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 13:47:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 13:47:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 13:47:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emDYOrjlD6pUrQZ1zXS4435ooIIAZjnFjK56x0xcBrCaeXlmHmJNb02LPFxt4YE5gZWG+9qDiUjbshsHMZF1Eri+Ji15UsyPnaaSWMPLhJcAJ+zvKOSi+AXSqUxhX3Z9Srwsof7i8TK/oNXANsKirVifRXvkS8PZM0xeu5zz+FBbATjcmgEcuvr/9z5HfdLgSs4gcSQad1zaAqMljwY/0cRj/oa3shoLCN9lcH0c9n13JaLcfpSLNFfYdcE+Y3G0vbYOBJ3NpXggdSiBISZfme60iJDY5d7l6xDuFBFkQXrs3553nsbDqvnOTGID6kTdPM8sQiR/dvIL8RgKr0O77g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrnrWkJ7PFY+s/4NxtD7e/mIOQ/TFWi/UeVFIG9Jf4U=;
 b=QVeNOP8YiZniA6+MazXZ0NTXCeWewy3P9Ter5FwWxgwSEcFRObFouBaKF5Dh5ymkm+blr7uIZjWnkOhBif/D/0ImvuhzAOVw/MUOusoyiMIAhnx6wnm0+XmBOdGqbzE2YkoOnFK+iWpCzkfL6qv7HnP9b18tXAYQ+zXe3LB1k/KLLPwRollmXtCLBn1ERSL/zxU1n101LOwtqkfXdkyf32+Q3t4KMkVSkJQY+Jf/m/vnEW6arRZV0e7+6bfTnzaT5X6BhKjbvE1nr7x3jQP4Ay8bo1wjQfRAa0M22nDISdp1M2k/GVCIqiCYU98D2KulE0rfnv1U5PDoXNFMK8a9Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA0PR11MB4653.namprd11.prod.outlook.com (2603:10b6:806:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Mon, 18 Mar
 2024 20:47:41 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7409.010; Mon, 18 Mar 2024
 20:47:41 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, James Morse
	<james.morse@arm.com>
CC: "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Yu, Fenghua"
	<fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Thread-Topic: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Thread-Index: AQHab7KwshA04b3b7kGAda4tCZ9C1LErPGXQgADHEoCAAIKhUIAAB+aAgAABPhCAACNlgIAAEarAgAAc2ACAAUZZboAK/v/LgATLiICAAAEvkIAAFESAgAADgIA=
Date: Mon, 18 Mar 2024 20:47:41 +0000
Message-ID: <SJ1PR11MB608303C5E0BEB42CAC5B02BAFC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <SJ1PR11MB608310C72D7189C139EA6302FC212@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <o6va7b7rc3q46olsbscav7pla4hxot2g6xhctflhmf64pj5hpx@56vtbg3yyquy>
 <SJ1PR11MB60830E546B3D575B01D37104FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <159474e6-ef11-4769-a182-86483efcf2a6@intel.com>
 <SJ1PR11MB60832DAD58E864F99A16FCC4FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0393c4ce-7e41-4dcc-940a-a6bea9437970@intel.com>
 <SJ1PR11MB6083AACB10645E41DD3F9639FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <55a55960-8bb1-4ce2-a2c7-68e167da8bcc@intel.com>
 <ZepK4mtoV_J8-UbE@agluck-desk3>
 <eacdc287-24bd-4137-85c8-df055cfd78b1@arm.com>
 <ZetcM9GO2PH6SC0j@agluck-desk3>
 <88430722-67b3-4f7d-8db2-95ee52b6f0b0@arm.com>
 <47c28b3d-3b90-4b33-ba71-1e359d43238e@intel.com>
 <SJ1PR11MB60832422CBDCCDA580010769FC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <6948784d-6a20-435a-8781-30f324bed472@intel.com>
In-Reply-To: <6948784d-6a20-435a-8781-30f324bed472@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA0PR11MB4653:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9qhoclO+jWVl8mvJSgyWDDnIZrdfwQnIMOgLyOF4vO11LT876Hu6dzwETVRZ3bYQN9RPFZu/FbLpDU+25Y46jzgpG19CQRfSQka5KA2FomHa17XjkIzZGBzdLGgZ6iWwM6wSBIoxGpZUBaDBW6Z1n3T3hrtiZZdY9mVPMHVN3sy0msPGfF1JAZ5LBo4Dn/E9gJHbI+T2NHzMaboATks7c4Cb80dJR9MS9E/zwPUZmiaiYV90PYrESlOVANdZ59Rit53bvHB0LBBdjtXy5YtUeFaO7kGwOisTkCIi3xgMAclRDaYE70UBO7kc0yVx8SywGW2tSTlCQIYMZrlLLTKQBUDOl4YGyIERxzrSsDjJ6esS1g+dXJSWcJsSIl+65NLVCx5eNcueyGtnJdzr1SiHOpIOm2B/Qm1iVcX6kFSc444MjnL30NPGGKe1YdUi1Xnq9FT57XwsFVWMCNgF0ySRns49GCSv1PLKJRw1zca7JMPkZwwKed+xcEPalmWrZQZ5dOMRAUbiZJfgwkKTIjeMZjOrMVgS6JmjNKOaeEWL1iWFYT7C4Ux5XOSeUxq0pu+oxbvJqFlA+RpZ/c459OBr9AY4MIKMe6TJQDNOlL1KvYUEujiv0p5hLW6pdqdsbXCXdJK4h0muPLNTcCGR9qK1sFjFD7hY758ctBfc9NEittg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXdRTE5lcGVWbE5xRUFWeUp3OTlJcUd3eTI5bEEwNTBCMWNQdld1RTRJLzI4?=
 =?utf-8?B?K2FoV0tEa2tHdFN6bzU2ZjdNa0E1S1BJOVVNOHVRN1kvZFdqcGtBd0Fabjcv?=
 =?utf-8?B?dnFrTGlvWjVIMTRhQnVsMFhUU2xvSVoyakFLV3RjMjN2UDNwYStBcnJVZVM5?=
 =?utf-8?B?bVNHZ3JMd2U5djgxY05aSko5NEMwa0M1Zk9lVGZuZWZvY1djbnZQbTZ2Wkpp?=
 =?utf-8?B?MFpSeTcvUzR6UFY4TWhHYzFJanFCL0xvSkNVMExNOXdheHZXYWQ2c29hUE1k?=
 =?utf-8?B?dzZiTUJtTlN4cTNSUk5iSlJ3dFBkS3NjeGdIVUNmNCt6N3JGNnQ2Ly80VjI5?=
 =?utf-8?B?d1lrRFlJS3ZielVUV04vcTVOMUF3SllmL1hWQUFQRFJyakU2dnRVS2ovZitC?=
 =?utf-8?B?V01IaVVoSVVmUytVZlBmcUNrYnlKOFVTOUV0YzFOUUlSQzhlcDc3M0ZVK1JC?=
 =?utf-8?B?TnZwNytlUXRzVy9xSnBFQndOTjdQbkFDMFM3d3Jzb3hqTDhuTk52S3ljK1NE?=
 =?utf-8?B?VjRaY2FZL1p2Q1krRk1ham1NV2h5aXpYano1bXlrVmpoUFZzVWR3U1VhanRJ?=
 =?utf-8?B?akplMGpxVDEwajI3aXB4MmV4WG9YZlp0TXF0Nk9sQVRyRXpPZDhDQlJ3RnpK?=
 =?utf-8?B?SjJYUXRXUFB2MWRtSExXUHFSUEI1S2FFTmlLQldVUlBnVXdLRTZCa2dSL3B0?=
 =?utf-8?B?V2I1OGRaYnFXdjVjZmZmZ2RWTVRmNkt1VlljbXAzRVo1WHNiRDk4WW9KQUsy?=
 =?utf-8?B?NENLMnE1Y3FkdUtKdGtLakhTZFhHbVhFa2NZSXJabEVpN3ZtZTk4TytCWndv?=
 =?utf-8?B?T0kxSU1TMExaS05FQUp6QlZ3dlY1cGsxL21HeFFubDZqMWtLR1NPRHVuSGsz?=
 =?utf-8?B?WXExRGhFYXBrUDFLOStDam41L1ozOThtNDNJWHBwWE5aaUNIS3pmUmp6QTRp?=
 =?utf-8?B?eisxVEJ3czNKSnplQkhNUUxmT1VibEhBTWFyVGh5SERwdndHTGxlV1ppUDNI?=
 =?utf-8?B?TkZVV3hzOVZQVisvbFkrODFzMENkSnlMcENuMHZZTmFhSzVDZWZnaGxyUHE1?=
 =?utf-8?B?UEpLKy9NTFFmdG9ENkJGY0NkWlo0c1Uwc1dZY3ovR2hMYno3Z1BvbWhYQjA5?=
 =?utf-8?B?dGlWdUl5WENRZGtDOUpBUTJpR0lYQkU2LzlCMXFoUUtEWmprbUdCbjNvcVlH?=
 =?utf-8?B?OVlFdHo2K09ENXNQZnRKeU9jTUttQmk3Rm1iTlBaMnZvZlFwMXFKS2toL1Bz?=
 =?utf-8?B?Zm5HeWdtSldMZEJWVU90djdvREo3VkFvc1hEWVRZcUdBVmRxMWo4Znlic3hW?=
 =?utf-8?B?KzV4ZUtxVGtEMnFMMFg2V09mT29BQkZteEpEM21vcFlWR25sVnNWUXhGb2J3?=
 =?utf-8?B?VEk5OEsvcis1NmZkVkp5bVM4T082c0tMU2tMN0JtNWU5RW5od1hVNlQ1Wi9r?=
 =?utf-8?B?ZGZNRUgrNzJ6Z2crRkJPRGNqSWtoQzQyNlUxZ1MwMU5CZThkUUtXVktORkMv?=
 =?utf-8?B?bGVuVE54T2FwNW5tQ2VpTHZlQkxCNitMdDdqZkE0ME1RaldlK3E2VU05OUdH?=
 =?utf-8?B?a0htWUU0YldUa3dPcXVFcTc1NFJTRDB5S0hMUGtkSjBXUjhyK0pzMVFhdHA4?=
 =?utf-8?B?eHdDc1o2Yk5kWjU2azZRelN3TjZGd0NEUm5QcHIxc1dNMHNGLzlZeUJNcHcw?=
 =?utf-8?B?MmZmSnlvTzFVeUl0eXNScHJWcGxJZG5DZXlnRnZ4dTExZU1mL3Y2ZVV1MExa?=
 =?utf-8?B?b0FaRFhnUTN3VEFPMzhYSitITmtXdW1TT3E4anNkdUNRNmJTWEdnWmFzWEFy?=
 =?utf-8?B?dWFOR0NkRGtOK0F1NCsvb3M2Z0J5cCsySWQ2Ny9CZmVLOTJ2MUVLNU5MaElj?=
 =?utf-8?B?WGsvYmxFOWpLaW1DbThGeVJZYmVxbGQ5dTBvR2FyYUhpbDZ3SnBYd0F0dGdl?=
 =?utf-8?B?OC8rSTlrZWJiRFJzTk16dDNtWjNLNjh5bEFXMjk4cHgzV3M1cUljdk00S0Iz?=
 =?utf-8?B?Zmg0bk9iTDZxRWgwUkkrOHJCMTJPK2ZOZ3A4dzdoNHpzTFUwUWxydWxjZTUw?=
 =?utf-8?B?c2crT3JPM2crK0tsK1dKeUpxcGlaM2czbzNPMWxHeW5GU01HZGdnMzVNdDNT?=
 =?utf-8?Q?8D3/hPRilArrVrJ2H3PQtIp6i?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0cb527-cc12-4883-128b-08dc478ca7a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 20:47:41.3244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ONLyW9EBhSs/o9bxZNV3+7Sr3+HO1E4tShuVco0lI/fIgnqJCgXRN6LNCmfZHJWdeB4SVtxgSlEpdkJ67kO8Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4653
X-OriginatorOrg: intel.com

PiBXaGF0IGlzIHRoZSB1c2UgY2FzZSBmb3IgbmVlZGluZyB0byBleHBvc2UgdGhlIGluZGl2aWR1
YWwgY2x1c3RlciBjb3VudHM/IFdoYXQgaWYNCj4gcmVzY3RybCBqdXN0IHN1bW1lZCB0aGUgY2x1
c3RlciBjb3VudHMgYW5kIHByZXNlbnRlZCB0aGUgZGF0YSBhcyBiZWZvcmUgLSBwZXIgTDMNCj4g
Y2FjaGUgaW5zdGFuY2U/IEkgZG91YnQgdGhhdCByZXNjdHJsIHdvdWxkIGJlIHdoYXQgYXBwbGlj
YXRpb25zIHdvdWxkIHVzZSB0byB2ZXJpZnkNCj4gd2hldGhlciB0aGV5IGFyZSAid2VsbCBiZWhh
dmVkIiB3cnQgTlVNQS4NCg0KUmVpbmV0dGUsDQoNCk15IChwZXJoYXBzIG5hw692ZSkgYmVsaWVm
IGlzIHRoYXQgaW4gYSBjbG91ZCBzZXJ2ZXIgZW52aXJvbm1lbnQgdGhlcmUgYXJlIG1hbnkNCndl
bGwgYmVoYXZlZCBOVU1BIGFwcGxpY2F0aW9ucy4gT25seSBwcmVzZW50aW5nIHRoZSBzdW0gd291
bGQgbG9zZSB0aGUgZGV0YWlsZWQNCmluZm9ybWF0aW9uIGZyb20gZWFjaCBTTkMgbm9kZS4NCg0K
LVRvbnkNCg0K

