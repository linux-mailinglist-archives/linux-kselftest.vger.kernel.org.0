Return-Path: <linux-kselftest+bounces-38777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AB0B229D9
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 16:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6153A029C
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 13:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28942288C3D;
	Tue, 12 Aug 2025 13:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jBSnvHp8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5032E288535;
	Tue, 12 Aug 2025 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006873; cv=fail; b=GaLcKuTPEo+pG5sN79PBrkSDiDzl8yymAM9y+qXZswT+ux4DK1LYwG6vUqrm68Gdpl1AYu72c+bAR3Pv3o+DdQclV4KOA8jyX32QlQnf8OygNSrRotJE5raJ7sEKPhm0NmFXUkRzcxNRfbh/5U6/EbMSxlD/V3B1wvIBpLBzb4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006873; c=relaxed/simple;
	bh=/4Z0v+SxzMXtMg1k62+YEO9joVwXMiaygo51aS00sZU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WbRDZ+IipkyrzpbGryS10Qys8eN4ZbGIIACROA2sBScyH+45UADujyXs7cKDdFVbaDfwNZRKXpcwQVog9Z1S6xpJenDF0mDzq7GUuQDPlAp8+VuYeW+NPgGDbG5IqXW0H12s4+iq1Nte5zG20FpdjggeJ/geHNyQDNhU3HDAHW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jBSnvHp8; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755006871; x=1786542871;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/4Z0v+SxzMXtMg1k62+YEO9joVwXMiaygo51aS00sZU=;
  b=jBSnvHp82D1WLSqkP7UDm5XPaNWvOo5vWfkbHAO7XklOCBLxPxz1wqmp
   nhQlJxcRc9aL2tSsuCzooVum+8jA1GpoYqHjSnTYM2a1ItnFyq3NI8IF+
   swYbrZ1f/5HoSwOcHAib++yqOAp+khFoiN9DUxQtq9cThEqxkA8EuXv+f
   Ss5iyD1t6G+duo5UHEpgRbIxxaFgJnQANSWI00Xaoz+Vxi3vxhFSBgaYl
   KRopzzHFlUU+HeHVhi3I112d97U0F7sQDus7CcqVwMsfygTGxbgg2N/xL
   m0qankUGAjz2Sqg72K5n/wDhLIb/bqwpsUMbQfpVRCju2a9GEvgj3zYHe
   Q==;
X-CSE-ConnectionGUID: NJQgl6bpT+u0AS+YnWOsbQ==
X-CSE-MsgGUID: 2xNPCuX/QZ+8vANz6boK0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="61082454"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="61082454"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 06:54:31 -0700
X-CSE-ConnectionGUID: ExgDA7LpS9G+aKFRaXvaRg==
X-CSE-MsgGUID: cCEfD0clQhGAaL0coWgOBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="171451465"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 06:54:31 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 12 Aug 2025 06:54:30 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 12 Aug 2025 06:54:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.67)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 12 Aug 2025 06:54:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QAhygCq1xsZoOUiB4VAlhVi8pFD5Oeg9Rb07okq6fZGX2R9rfRX52jW54hrlIL3Fc11MgtJrcXn71q/6bZYVznGL45ZKZmS6kzISR2vFjb00tEX47GpPH3sEN7cgWppFY4lK+Y/Scga5Tc05QQ7ruGtWCA7S+rVQaBsy3WP1SJNajva/ShQM6yfs9Ut+/9GyAXX9RNNN3lzF+nQjli3oIPBRP8BFw5P2V+PFClj7Aq9SEUhbSX/Iicawu8/Z+QJwnuQdDpfbW1vrJcwCYMPlhEjbp4t8pAsmTCcTUVLXXf6npDxNt1oh0Nz4thXt48F1Gd074bL9zmaPaVIpjfNIOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxXamfLfVn5bIG1FRT6FdUY6y1f8euD/QfX8SclFtRg=;
 b=pXoFw2bNS8dD1d9AHkV2jg0FOpyAeUn85DvgOkTuKjQnlbp87Nru5HfWOkHCWEuzQgFEsP1FMvJ+PJY+7Oy5OYHUGbZlYEJLWYIGUSNE2ICZL/XAtlJKce2KhpXHaDEP9BfwhTM6D//BlIPNLMTnKIRH95cLFqw77zMPaz+wA0J3aOY7h/29Pcdock/dEPdA6s/phTHJxqdmE/8gkDai2sWcynVcCG8UsKgJDPvWqePO3TEMvu5mT9YIQ1Db4bcfpkQvZ7YE/w+P7wQXUa5U5Th9q9tspuEiM0dmuCbmXqt0gb/gdwhYaTGynKIzrZrTGeUbdRG+AJBNRxzD/N2DrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by BL1PR11MB5304.namprd11.prod.outlook.com (2603:10b6:208:316::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 12 Aug
 2025 13:54:26 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563%5]) with mapi id 15.20.9009.017; Tue, 12 Aug 2025
 13:54:26 +0000
Date: Tue, 12 Aug 2025 09:54:13 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Marie Zhussupova <marievic@google.com>
CC: <rmoar@google.com>, <davidgow@google.com>, <shuah@kernel.org>,
	<brendan.higgins@linux.dev>, <mark.rutland@arm.com>, <elver@google.com>,
	<dvyukov@google.com>, <lucas.demarchi@intel.com>,
	<thomas.hellstrom@linux.intel.com>, <linux-kselftest@vger.kernel.org>,
	<kunit-dev@googlegroups.com>, <kasan-dev@googlegroups.com>,
	<intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/7] kunit: Pass parameterized test context to
 generate_params()
Message-ID: <aJtHhZqiLk-z99cv@intel.com>
References: <20250811221739.2694336-1-marievic@google.com>
 <20250811221739.2694336-4-marievic@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250811221739.2694336-4-marievic@google.com>
X-ClientProxiedBy: BYAPR02CA0036.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::49) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|BL1PR11MB5304:EE_
X-MS-Office365-Filtering-Correlation-Id: dc85afe3-f52d-4d50-e064-08ddd9a7bc26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FEKAM7qc4KVmFH9Sf1gKPrDkv1ReeIstC9K5vDSLbZPV1MvQjsWjL8r1nMxz?=
 =?us-ascii?Q?ir7icnnSdKta4Jrvdv1/FKoTdfe47QGn3U/Bbda21/LrRv1Sj1R0h7ixr29H?=
 =?us-ascii?Q?d2+h3D1HoSHkXOBgP5zP/eGntzUJ0X0aLMHLhmX/EBNHKyKBhnqZk0KFCu/2?=
 =?us-ascii?Q?sN4uOHNylljPaoh05TJD06bwXS1ZbSJ9WOyi1xBuOmE77uw/nHQrel3I067t?=
 =?us-ascii?Q?bdlUdOQfLRCfHMEBS9DSXIpClG3c103v8P0AtaGsEWpLMzdak9u344hvQKjn?=
 =?us-ascii?Q?382D9UXax+1RGimemecPE+wlZEaCj1gn4YOS+kLvLbgSG+4kLwxzt4FHNOwP?=
 =?us-ascii?Q?Hejyo4rikV3dhrnSBCX+YmmjY0cwEuDE0jwBD0FvLFFyG4or4GyJLLAD2IxA?=
 =?us-ascii?Q?sXGHiBsLHoBGqOp5ygJcNaz/jVre/gQOBpqgYd8ebU9hiJhBmRDnbLQAypdU?=
 =?us-ascii?Q?22jvCBxsd+JNahCtgLIAssx0bZS8KgdZ+EdLmxSV8IWOPP2aMJUuRBJf0sFv?=
 =?us-ascii?Q?FtQkfhqlozYwzZCCMXJQ7AoPj9NlqGDu49DgW04nEoc5fPZHobwQf8bdSKwO?=
 =?us-ascii?Q?0JVzAJNZF7XtGuhKRDJDWDkeON4d0ZIUcL+cGNXw6He6A7cwWMQnwUvyyriN?=
 =?us-ascii?Q?0eHNPnWdcY9h6ogY53dJZQ6cKZm4giAbtTA2sxUalqOoWXPu1EfgMU4pvURg?=
 =?us-ascii?Q?HcGBSwiFlMmLC3GuViG8sXIfeCedydAv/j0JCTidqSh55PmUlm+ir4Urpw45?=
 =?us-ascii?Q?Z8+SG5Q2SWUxwYLykJVtTEWGmzSuQAEdXopIAI9nPrSsofMgfsN5niGNeJ3Y?=
 =?us-ascii?Q?jjCa/a3UTkgXke/PSDg253CygCfYd32GURNq9l19t2THlY9GJrqSuTm9pUsK?=
 =?us-ascii?Q?446bokyAlxE9ZZUD4ZT8wNeh0Rbosq2ZeOvmIxeTTI8j8mmN/ti3+tOqvzEG?=
 =?us-ascii?Q?6764h9mwjPg9I7s7dLccQwD0DKLXfxhbM3SAmgN/+97Iho/FcF//oJB6nML0?=
 =?us-ascii?Q?w2YUIqdrJKOytlrEwRjQC4C9ZBDm88cxD9K/HT+DM/ow0Oqxu25x3Emvme84?=
 =?us-ascii?Q?8BM7JNw04HVgeDdV+/mvYKgjfw33zxiUB+m6QX7fYYDCOLCKvEHKCTh8wVv/?=
 =?us-ascii?Q?KG7GFRWgCd8jjyciahMlT3FRWQNRcUgJq0SgaxJm3UdqaOJz7CyHPH2UjHdJ?=
 =?us-ascii?Q?sMjnsAhse22d2hg7AOLoPRP8wqFaSLIj4nfhGOZQBE//f5B3GioP2hFSseTH?=
 =?us-ascii?Q?jXguUJOzvK2Yhx9xNAsaqZYq2n+dUrYWkwxiczncAf+XiSzxYMCGRTIaUDoj?=
 =?us-ascii?Q?17YdAgnajiFPqfum4QlCt9UHzaZIW/JzT8kuD6s8hlJaeSe/2AAXCK3EDEpv?=
 =?us-ascii?Q?oPX9+NyyeTpwuAlpR21rOSizxJYqy6LvHf0F+JfJbcsfc6J/cVLEqh6a5CIM?=
 =?us-ascii?Q?SJ2UR2vB+k8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UlucT7idBjPr9svmCdhbJyJwjN+c3YSo5jtW8WcYjX39R2iNa3LiRyFm0ElY?=
 =?us-ascii?Q?mWb/yM6Y2hrb1nOoG5huzrTsCdg/e0Oh3ClxjJSttGzwBRfkEPBLRrTvkjEq?=
 =?us-ascii?Q?xYHMOd7KME59pC4NoTiVbcPWaFk/yC57zL+c6aOPJMxkqmov/6qSTbcx4BKz?=
 =?us-ascii?Q?vcM2F4TR6ENRtCIpq5rxwfgOcRZK/cMfvjCyQIVHZoMunfso4UuvqXKpUTw6?=
 =?us-ascii?Q?0JvJn3m+DvBldwASGrvczlQur5THhiPpLbSe8GUwDdntr5wkGGQz0ajsLhdH?=
 =?us-ascii?Q?rZJZFfq2ADaRFQgkau2dRkcgvlDgadCq5EU5v1KHG4EigVVmgxSswTyV9CC7?=
 =?us-ascii?Q?pTOqhWglQnaj1y7npM6vK6BQs3AkMX7dNR7B9VrX6+I/jbzXwheXkdY1OCZ1?=
 =?us-ascii?Q?TsQPfK5DLyCY17Whr7V+NcxJdWdRbDW6ECwHxClboSU6jR35Qn/e+klDdwjB?=
 =?us-ascii?Q?7QCGugnl5uCTviYDyl/fjn8b7kRjQHRGlNlfJ2soPGPg4gKqKxO9hcWNv5Q/?=
 =?us-ascii?Q?Q7g7Ycj3PCSrkJPLqe1nOE5DJ/C3JB7x4HoDOusJDQVk13u4DNFSBUZL5OtJ?=
 =?us-ascii?Q?yULGbk8Cu/3z6qsG2pRdYboZ3JqretRJ6tBuE8w9tFAuUctIpfMsFmQ7ts4B?=
 =?us-ascii?Q?6pSQ2es9yLofepUwbo8PwiolRFbZJougZ8x/4KeSA9lRB0srv/F1hmsZezTg?=
 =?us-ascii?Q?VnxlVlhvH2BR9JZUaLrFdBSL/l5nipJFDyVpNblck/iDbRtVcYWI4HEQPFzY?=
 =?us-ascii?Q?l7Qbt8qqcB1zXT/347FzWeVmYaLCvSQkObYMMXIkvC1TtdWvIppjjFkMzh1m?=
 =?us-ascii?Q?cQhb37b/QF5gg0hWicKxBAq5fVWlDAdp7cmyGk63NxO372zPwamiXvF+vHpU?=
 =?us-ascii?Q?ZVxkqdrQZIz453kJ1s50QFv3iohhGKcaq/Scg0hzuG4hfs12evBrPuzOecql?=
 =?us-ascii?Q?L07hP9LLwdZen9vMsBvPcb8ZmZiym4IVz/eLtYPhr6qIJGw947riKLQAnHP7?=
 =?us-ascii?Q?cp411ni+/WXk2fggJqASN3Sfmoo9u6qp0/LjrKwwbg8MQc0SLclxpuzzek7z?=
 =?us-ascii?Q?+OqBBcPCz8ieVrgRzxNvEnjX2yUB+31x9klMUOcHRkqwF1OZGB2ORZW2IbNu?=
 =?us-ascii?Q?PB9ZbWB2uxYKul1roDsGvBz70eh6UU7bEFvNlGiUimvO6LzlOqypTjnyZkfC?=
 =?us-ascii?Q?zR4fNMARidfIOon8FDl47mjEEI5P3D4tvmhNlWND/Hrd6yibMmZO5ebu1lf2?=
 =?us-ascii?Q?fVmgKan2sSPjTx/ttqrUE3qLg8qz0QvzhOCwiz4azFDidPhL1i2icq509Yew?=
 =?us-ascii?Q?9XQu7/NwaIjxrJMGKoQxe+5rnBdwDau9J2uwRK4XBjAqJeIfAYE0yqpeuNVR?=
 =?us-ascii?Q?Y3kdgMeHf2mov7/Y6KtpYsk+d4P0A1i3CPdzUJz1tuah+aedKmdwfGzkuga1?=
 =?us-ascii?Q?ndS+z7nE8JSmbyP92Hbiwf4X1hkCJzROvRnHi37RzfaJifuA8s6SQOeUak/f?=
 =?us-ascii?Q?3LUd09hM8lx8JB0XEOLqs3Q8tJpRBpyoHJUbMkmgo2mF63zyJ+kM1peirm2L?=
 =?us-ascii?Q?rMZ/uV/ECfg2YeHw2rAaq4spWxJhI43krc+sVCd/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc85afe3-f52d-4d50-e064-08ddd9a7bc26
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 13:54:23.6020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1q+Pxf+etk0h4F91rC/Pu3veV9ZyBRV2NwsneLzMOxqo+hl5OCt765kDlXgCKFyGf3CgOJ8OYGi7tLcu0kr+1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5304
X-OriginatorOrg: intel.com

On Mon, Aug 11, 2025 at 10:17:35PM +0000, Marie Zhussupova wrote:
> To enable more complex parameterized testing scenarios,
> the generate_params() function needs additional context
> beyond just the previously generated parameter. This patch
> modifies the generate_params() function signature to
> include an extra `struct kunit *test` argument, giving
> test users access to the parameterized test context when
> generating parameters.
> 
> The `struct kunit *test` argument was added as the first parameter
> to the function signature as it aligns with the convention
> of other KUnit functions that accept `struct kunit *test` first.
> This also mirrors the "this" or "self" reference found
> in object-oriented programming languages.
> 
> This patch also modifies xe_pci_live_device_gen_param()
> in xe_pci.c and nthreads_gen_params() in kcsan_test.c
> to reflect this signature change.
> 
> Signed-off-by: Marie Zhussupova <marievic@google.com>
> ---
> 
> Changes in v2:
> 
> - generate_params signature changes in
>   xe_pci.c and kcsan_test.c were squashed
>   into a single patch to avoid in-between
>   breakages in the series.
> - The comments and the commit message were changed to
>   reflect the parameterized testing terminology. See
>   the patch series cover letter change log for the
>   definitions.
> 
> ---
>  drivers/gpu/drm/xe/tests/xe_pci.c | 2 +-
>  include/kunit/test.h              | 9 ++++++---
>  kernel/kcsan/kcsan_test.c         | 2 +-
>  lib/kunit/test.c                  | 5 +++--
>  4 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/tests/xe_pci.c b/drivers/gpu/drm/xe/tests/xe_pci.c
> index 1d3e2e50c355..62c016e84227 100644
> --- a/drivers/gpu/drm/xe/tests/xe_pci.c
> +++ b/drivers/gpu/drm/xe/tests/xe_pci.c
> @@ -129,7 +129,7 @@ EXPORT_SYMBOL_IF_KUNIT(xe_pci_fake_device_init);
>   * Return: pointer to the next &struct xe_device ready to be used as a parameter
>   *         or NULL if there are no more Xe devices on the system.
>   */
> -const void *xe_pci_live_device_gen_param(const void *prev, char *desc)
> +const void *xe_pci_live_device_gen_param(struct kunit *test, const void *prev, char *desc)
>  {
>  	const struct xe_device *xe = prev;
>  	struct device *dev = xe ? xe->drm.dev : NULL;

Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index d2e1b986b161..b527189d2d1c 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -128,7 +128,8 @@ struct kunit_attributes {
>  struct kunit_case {
>  	void (*run_case)(struct kunit *test);
>  	const char *name;
> -	const void* (*generate_params)(const void *prev, char *desc);
> +	const void* (*generate_params)(struct kunit *test,
> +				       const void *prev, char *desc);
>  	struct kunit_attributes attr;
>  	int (*param_init)(struct kunit *test);
>  	void (*param_exit)(struct kunit *test);
> @@ -1691,7 +1692,8 @@ do {									       \
>   * Define function @name_gen_params which uses @array to generate parameters.
>   */
>  #define KUNIT_ARRAY_PARAM(name, array, get_desc)						\
> -	static const void *name##_gen_params(const void *prev, char *desc)			\
> +	static const void *name##_gen_params(struct kunit *test,				\
> +					     const void *prev, char *desc)			\
>  	{											\
>  		typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : (array);	\
>  		if (__next - (array) < ARRAY_SIZE((array))) {					\
> @@ -1712,7 +1714,8 @@ do {									       \
>   * Define function @name_gen_params which uses @array to generate parameters.
>   */
>  #define KUNIT_ARRAY_PARAM_DESC(name, array, desc_member)					\
> -	static const void *name##_gen_params(const void *prev, char *desc)			\
> +	static const void *name##_gen_params(struct kunit *test,				\
> +					     const void *prev, char *desc)			\
>  	{											\
>  		typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : (array);	\
>  		if (__next - (array) < ARRAY_SIZE((array))) {					\
> diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> index c2871180edcc..fc76648525ac 100644
> --- a/kernel/kcsan/kcsan_test.c
> +++ b/kernel/kcsan/kcsan_test.c
> @@ -1383,7 +1383,7 @@ static void test_atomic_builtins_missing_barrier(struct kunit *test)
>   * The thread counts are chosen to cover potentially interesting boundaries and
>   * corner cases (2 to 5), and then stress the system with larger counts.
>   */
> -static const void *nthreads_gen_params(const void *prev, char *desc)
> +static const void *nthreads_gen_params(struct kunit *test, const void *prev, char *desc)
>  {
>  	long nthreads = (long)prev;
>  
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 49a5e6c30c86..01b20702a5a2 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -695,7 +695,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>  			/* Get initial param. */
>  			param_desc[0] = '\0';
>  			/* TODO: Make generate_params try-catch */
> -			curr_param = test_case->generate_params(NULL, param_desc);
> +			curr_param = test_case->generate_params(&test, NULL, param_desc);
>  			test_case->status = KUNIT_SKIPPED;
>  			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
>  				  "KTAP version 1\n");
> @@ -726,7 +726,8 @@ int kunit_run_tests(struct kunit_suite *suite)
>  
>  				/* Get next param. */
>  				param_desc[0] = '\0';
> -				curr_param = test_case->generate_params(curr_param, param_desc);
> +				curr_param = test_case->generate_params(&test, curr_param,
> +									param_desc);
>  			}
>  			/*
>  			 * TODO: Put into a try catch. Since we don't need suite->exit
> -- 
> 2.51.0.rc0.205.g4a044479a3-goog
> 

