Return-Path: <linux-kselftest+bounces-14322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCED93E3B1
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 08:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A811F21A06
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 06:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01968BEE;
	Sun, 28 Jul 2024 06:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TPpTsBF3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0AE79EA;
	Sun, 28 Jul 2024 06:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722147058; cv=fail; b=Ff7rscczCRwWBUA4/43OZs+yL4KfwIQ0LGUeAMakaJVr+wW/EeiqTCqgvyp+y1wvxiV0kbrRWqgB3skL4WGHs0c8NnoF5FROgwESQU27TTb/qOkBSKQEcbcnMCyJqzRwXuK1ktZK40n/wjLad7/FU2hiXwCJQwLNRJ+y2vg39EQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722147058; c=relaxed/simple;
	bh=YlkucCPjVcwELHAOvHnu1sOgW/mgg1t6s/GzyXGmGEY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KDMv5f+B2BZjrb1U/AICE06iNzb2Ao9WevB99N1lCOblxG6Bqkck3F3FZI0yYo5II+juk3wiVbXAm6MSkeYcha/uRdytOdCk5DUH2TQBMsIBI8qDkvrfXC+1nzrd66kZHD8/ZsuVilSvhF1Os6aXMSv/UQDFt2243jek00eYZAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TPpTsBF3; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722147056; x=1753683056;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=YlkucCPjVcwELHAOvHnu1sOgW/mgg1t6s/GzyXGmGEY=;
  b=TPpTsBF3/HsSWPREro2r8ueH6EiiI3mjTLTOa7dNd6CH+P7lHXkJyyhZ
   WpFZrubf44ow8oh8Si1CR+k28eVbp4fliklgSjqvFjIWzF4O6LD4lNDGb
   4AfKqRrpJUZLqL1DthgXwqf/eIzN96Q7rBdaPlXawq5m4yz1ueCzywIek
   EvyhQ51fC2PeerX79pJqmSwEcjP/uLrT9roYdmhYUip6f0DZubVApGHyw
   DVkLm5mil8aWvUg5fDu+z5Q6CKEPCcLcSRejLC6b6HGGJM7ukuxQvUFAh
   MIfrjXGtUf39wbXe2q9Ndfd3jIoOwv1sxnKrtD2sSE1ZwE2DmijIow5LH
   A==;
X-CSE-ConnectionGUID: s9sg0I9hS4ywFMqNvugHWQ==
X-CSE-MsgGUID: tNUEU/qlTdC4fJ4190CGdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11146"; a="12750457"
X-IronPort-AV: E=Sophos;i="6.09,243,1716274800"; 
   d="scan'208";a="12750457"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2024 23:10:25 -0700
X-CSE-ConnectionGUID: /hbEPG1YT1aVciXWqna/Iw==
X-CSE-MsgGUID: v8S3gPrvTQ+cxCKzL20JHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,243,1716274800"; 
   d="scan'208";a="58436704"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jul 2024 23:10:24 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 27 Jul 2024 23:10:23 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 27 Jul 2024 23:10:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 27 Jul 2024 23:10:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 27 Jul 2024 23:10:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMt35rCsUs6ROnQxLcw+2yPQrFbKFcQOnBMEYqflgfzYc0XtSNIieo/RvNjATCDk73zV7u1I9jYHbjB0SHsHES0tMVcVKi3x8UAGe3wzs2AjAf/4xjSjfF0lktXPoNfBqrTsvzVaNgoPeQuCqjb075pSz3ZjTi9bZaqtxBkyo21rnZIjr/nFlGfJiNX3WVtBwj8mDXcBrqkvoGuFrOKcIwNmW+i4HDfj3Mjs4dyhzLpx6PRmb1K3sAXv0KoH7tTi7bKouWY4bsCV6rzV502eoHkmm3fxRwzR8/GzpVDld8PcIlz9rsKxlhGlDhfUtsSMcQK07hoMY5/xOCkIy3RaOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9IEB9PSZ/6dEl7dXCXDFgFUzL+7GRJyzYKsulTvJAs=;
 b=JCtUi0m4YJ4evh8nNDQTVvqxMqfOmvpVjWS9yu2bEtHz72qXVFE7NfNyuyiCKDAYqvBd2uXbswKQjE4dCyIHm78VQeBBzuBXKDUwJtTknb9NkA8iOmFM/UFCafEm2V2SqVGx3irWTneInSY+YQVG8UKECvLfzQG9kSvjHpX6udv9AmuhKD6FLES3nOluW9DDtTR/mf3TqZmqLe2QZvDKSB14254djlJFnHnS5yy8s+PNOAz3BIX7pXy0jYq37b7UnmhDfv8lzA1LtoD5lFuXfzKLOLoE/5EUrNzuxD1krSnq5i0IKqVQJVOgxLIb+7TOv0aJMjBjwijMImvEbAxEAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6) by
 SA1PR11MB6896.namprd11.prod.outlook.com (2603:10b6:806:2bd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.26; Sun, 28 Jul 2024 06:10:20 +0000
Received: from DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9]) by DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9%3]) with mapi id 15.20.7807.026; Sun, 28 Jul 2024
 06:10:20 +0000
Date: Sun, 28 Jul 2024 14:10:07 +0800
From: kernel test robot <lkp@intel.com>
To: Ivan Orlov <ivan.orlov0322@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
	<corbet@lwn.net>, <broonie@kernel.org>, <shuah@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, Ivan Orlov <ivan.orlov0322@gmail.com>,
	<linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<aholzinger@gmx.de>
Subject: Re: [PATCH 4/4] selftests: ALSA: Cover userspace-driven timers with
 test
Message-ID: <ZqXgv8QyRabQ31ig@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240726074750.626671-5-ivan.orlov0322@gmail.com>
X-ClientProxiedBy: SG2PR04CA0156.apcprd04.prod.outlook.com (2603:1096:4::18)
 To DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6039:EE_|SA1PR11MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: 4856178f-43ca-470d-37cf-08dcaecbf4d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SHCIiUewaF4pB3/NaJJw8L8dGrZCLHFVHb4dr7hy4bmnu+/m5K38xweaMQjZ?=
 =?us-ascii?Q?YnSH07CsRkHDfV3qSnYqjrYk6pewsuhxFFO+RkSgeXn15EYoyKQjmuaWRant?=
 =?us-ascii?Q?nY215ZpZtEEJ/gpLtdWDwdhfCPx7C0ZHha0Y+oD/WCg/CbZK5IygWwmEleYU?=
 =?us-ascii?Q?KTJhz5EHLj9+QjYS4AJPL7KJOoom00y+t2bkJSM95gKBfZ2nVh0tS9R1/6KG?=
 =?us-ascii?Q?oedyp7tAmkH3JBrIZUUH+HeP+mFU5AxeHuafZN6DuAF8RMcoHDbkymSlzZAG?=
 =?us-ascii?Q?xFkgECNv8r6kXHkM8Jook/KW0bs4OonIricOC6RHa8y8uFOKLxzfNpxIuFFt?=
 =?us-ascii?Q?1bHcpYGxOUrn0W774YI3gNCK8sGuL8OpPCail1mrVMGgwikwkVLdyFwkZ+qP?=
 =?us-ascii?Q?m2w97PyNNMgFnIqWnwXuaIdyst4qkmaUaAn9yJkBSfJhb+lA2YkkKnYY1cKu?=
 =?us-ascii?Q?B4auSqzuXUUq0SsDlwojSwuPKqNogAyyKk6zIH0hsCfmC6bcFZojM8x7MV45?=
 =?us-ascii?Q?R8+Yzz/fggvloNXCGcf7E4QT03UgP3zTGe75bnrDR4R5myelEy8zuWiWFRx6?=
 =?us-ascii?Q?7EbFW3KZZOxBZDnCBZS5US8Urp6d1EQJ5Nz0l31Ml4CIYwr6RnyVZvNquDUk?=
 =?us-ascii?Q?h1z9ilFmLaxuRLlAnscjhgffK9LAhX41RmXAy5lTx/cgmTC2y38h/iSRre7m?=
 =?us-ascii?Q?dhTJoNX15yY5z3ZZ35muL1E7SGq6IJql5/FvcohImFkgfPFFaO8wkGLY5N7C?=
 =?us-ascii?Q?uJVX1wjig1oSi8RDL2Z1yZ3dy/u5Z40uDHaN3aymO8+I6dnhL2oOCiWwjsA6?=
 =?us-ascii?Q?/wBVFGeYAyOeEj/NbbA5cMUV6scD3XXNb/uzzgzdaK9NWZtQN0kPAyNhDZyM?=
 =?us-ascii?Q?v+hhQVNJzHddie2NS14Y9CBhi/vjArCDZDuX/a61EMX4iHstmibmOFumKCjN?=
 =?us-ascii?Q?yzd6LBndbeanbkUEeXyWYnL896K2/vEPei1hyYahNbLj6ozKwDr7FFweeZ2X?=
 =?us-ascii?Q?UvolgM+KoQCVJ472jbWRmSIca812Cmmyax687BnVJxfWqAVf0EA1d72jeVTU?=
 =?us-ascii?Q?PKJC6BfDT7nOZLjkOMS6OgziJgGj/megZwq73ptXr3X56isy65AQfrszznW4?=
 =?us-ascii?Q?kfzVU//saReOzaS/x6cdk3XrBMgaDRoWIbOTgDt7sJDVNHu7ExPhAaYgHnP9?=
 =?us-ascii?Q?oI2a9X39C+prmpQTQgvwrwJX+UaB3+k30CJbr9n5uHwtzGxNv+ZzlNf9+XZV?=
 =?us-ascii?Q?rLHYRkafvNJ/mD/AO5JoQSbuxR8f6MjADDytACWcWL+iv4PT1ZjcMsbYDhlQ?=
 =?us-ascii?Q?/PWOuU/Ql+W7/PS4ibwXMSvK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?43MlaM0GUQI+FF0sXc+2A72hzJ9src0IRA0DvejNQXvCxt9vcHcBn70yQfQo?=
 =?us-ascii?Q?Sx5s9oCK7PfkcChcv+JJgRfuJa9huOMygJb4FmyKF/LVTIW3FhLRO9tfpno8?=
 =?us-ascii?Q?C02J7d/v/QyfRRhQ2NGWSXj3T65rkY65vr0PWrl89m79ddOFiBRRITtpGazZ?=
 =?us-ascii?Q?1yvHoFZS35nJsyJfBIqygRjqh4u0GR6auXJ8SlAKfBUDwLGhtN4JXHJnvHpP?=
 =?us-ascii?Q?sa3DyJaCh9zX0yTlBcXO0xWsazJq4jrsAl2JI/QpQKow2ffmzdQIq12w4LtY?=
 =?us-ascii?Q?DeBCVMrPFdI9ZpakcbF2BIWhPiwuBstDlBpeZeJOLwi5GjbeRT9nI5z5LsvJ?=
 =?us-ascii?Q?+OFPacG7b2rhZR1u8KXSQ7hpSUAN5vzKQEPfi3qNEpqYufSpz9uP/OUD6iDK?=
 =?us-ascii?Q?FVpggHhqyn96ez8D5SQ4jJ/DeHYK8lbwSgtS2ih1iLo48bXXPxxn3PCWe0hu?=
 =?us-ascii?Q?R7VeZaPq49MpvwtBNulPYMNaqdmYBhpPhreBpBwn7oQlJglSYi5F9G0pTqQH?=
 =?us-ascii?Q?MnabHqHIYHsz+svRaXW5PyWZjLzad+NvnDDdgOv3pHioIQnO2G4lTnrprkKs?=
 =?us-ascii?Q?de6zkVW26Gtub4Ybk2OmaFgTgbIe0lItxbE4bBrdrhbK7rWTwg0f8P/X5FgU?=
 =?us-ascii?Q?k2VDgEFN1TGGAYyOlRl+/Is7/S2r5a1TNuXRP2koEVVQ3pQO2y27rUFxj3GZ?=
 =?us-ascii?Q?s4+17o9nkLwwk3USKYnmoxa6ywREmaA1DNIEI2CHZqk3UF3jGM1GEiRa98Rk?=
 =?us-ascii?Q?VICE2Dkr/CwJIYSOlsc5HhwGbhn0jEPa6KQEjhqB9SMmAj4kYJHxXSXxeXLq?=
 =?us-ascii?Q?hUSoFNCJd9aP5jgfNYSpcD7IPqb1lv6PxrCgXMlEACP7S2gS98oj6ao4cBaK?=
 =?us-ascii?Q?RBoo93jzLg1iEpO+GbHmxAdEu9ANoHZ39YgY4CvVvJbl149r+M/5nksdP/Kk?=
 =?us-ascii?Q?KfonYeGPMInZWqWpaiUc14TGvH23P9JfvfRK+KHT/mdgoGmJxC5kQJWVCQgN?=
 =?us-ascii?Q?7d4mbXXDa4yYN+2jRAlzhZeeb8wVOOgr/3rGCas+gM7f82YQjZ7JRe5W+Q2r?=
 =?us-ascii?Q?cwRSNibAgcJ9wb7AZDymRQ3PPAp4IiRFJ8DHqLXCZ+T6a9ecLJRk1efnQLDc?=
 =?us-ascii?Q?OvraTT7hyYY0OZpU+EEvnBmgH1rNrzvIHpiqwumhbwP3bGxuI2DLqwFfiNx1?=
 =?us-ascii?Q?Qgw8hvZ373BSkK1Oo+gOvilUh5h2/C4nTY+I6sup6JWEcDr6CDbZ1MFQw20W?=
 =?us-ascii?Q?3vKKN6qsH/Blcv706ORW1lr8qtfnDcXwDttNVdFcfd1atz2+OA6TU4UQYOVy?=
 =?us-ascii?Q?o7aMaLapjnzYA5CksyWsuDn6SGcpU7VsEFDf/KJrM8DHoncYVy3LyUg7/aAG?=
 =?us-ascii?Q?pfQg+04lcyfF/bRDqQhvHZWMZGEyoVMkvAJgLQ6rjeRckFz3OeKgs92px8F5?=
 =?us-ascii?Q?6kgK6zIo/niRCIBpoW75/EXumx1Oa0oGhfNz9NbhG+C5QCsuAZT83EKGRhE+?=
 =?us-ascii?Q?Drp3yxmFKss2tX+jzuTZzoHocmy4zJXby/YtiwtYWyxTrRqvC6EUz5+SIN8m?=
 =?us-ascii?Q?/+OiIFKzmMTCeLEx5LcC8M5hM+PDfKhM5Gk/ftui?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4856178f-43ca-470d-37cf-08dcaecbf4d0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2024 06:10:20.5882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4EcoyOzbLwY+vaXBP2btgpkmRcidZcr+7KQ6NJKf2UD/jv9kARaSHK8omjCKvCCfCYStiwBbUckNqP9oRrS3fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6896
X-OriginatorOrg: intel.com

Hi Ivan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tiwai-sound/for-next]
[also build test WARNING on tiwai-sound/for-linus linus/master v6.10 next-20240726]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ivan-Orlov/ALSA-aloop-Allow-using-global-timers/20240726-155158
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/20240726074750.626671-5-ivan.orlov0322%40gmail.com
patch subject: [PATCH 4/4] selftests: ALSA: Cover userspace-driven timers with test
:::::: branch date: 2 days ago
:::::: commit date: 2 days ago
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240728/202407281359.vMYdESrT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202407281359.vMYdESrT-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> utimer-test.c:73:1: warning: non-void function does not return a value [-Wreturn-type]
      73 | }
         | ^
>> utimer-test.c:117:11: warning: enumeration value 'TIMER_NO_EVENT' not handled in switch [-Wswitch]
     117 |                 switch (parse_timer_output(buf)) {
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
   2 warnings generated.


vim +73 tools/testing/selftests/alsa/utimer-test.c

5cf58530fa628b Ivan Orlov 2024-07-26  62  
5cf58530fa628b Ivan Orlov 2024-07-26  63  static void *ticking_func(void *data)
5cf58530fa628b Ivan Orlov 2024-07-26  64  {
5cf58530fa628b Ivan Orlov 2024-07-26  65  	int i;
5cf58530fa628b Ivan Orlov 2024-07-26  66  	int *fd = (int *)data;
5cf58530fa628b Ivan Orlov 2024-07-26  67  
5cf58530fa628b Ivan Orlov 2024-07-26  68  	for (i = 0; i < TICKS_COUNT; i++) {
5cf58530fa628b Ivan Orlov 2024-07-26  69  		/* Well, trigger the timer! */
5cf58530fa628b Ivan Orlov 2024-07-26  70  		ioctl(*fd, SNDRV_TIMER_IOCTL_TRIGGER, NULL);
5cf58530fa628b Ivan Orlov 2024-07-26  71  		sleep(TIMER_FREQ_SEC);
5cf58530fa628b Ivan Orlov 2024-07-26  72  	}
5cf58530fa628b Ivan Orlov 2024-07-26 @73  }
5cf58530fa628b Ivan Orlov 2024-07-26  74  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


