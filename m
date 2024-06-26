Return-Path: <linux-kselftest+bounces-12776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3ED917956
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 09:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D22231C209D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 07:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EB9155A25;
	Wed, 26 Jun 2024 07:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aw3WdLzu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EE6ECF;
	Wed, 26 Jun 2024 07:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719385817; cv=fail; b=PmtmV1nYPvMM2bbgq8dgMSrUlqxgYSN448Q6WCjroNDWE2x3apiZiBXeshdzQH4PgOXMmUwYqWAH/TyC1EDd+xP0P9kNjFNM2US9tAk+Xt0UaXOedFVkyQSI7Z4Xgpa4w/JZyKsV7Zfh3DuawlGHUNjnTWZUWBDBROsPy7vnrVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719385817; c=relaxed/simple;
	bh=RujmQsstKfwyB6cKbkjbhAN/tLNxHRgXVLyHctvhEMg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lF6OIb5hlzCk/rRxO631+72bDUE6h7x6S4a8SvYEcTfg//B8kjEZyXvXcshMBabQb29RCivMcn2kHmzT4we5G79nWz1RUcpQ3pOJzSYz3XOB0E9H0KWcY43WzYB5Ai7Gsa2Eo5H7FfKiTpF58FgCLX8Q3h/MafdU34KjaNHVQLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aw3WdLzu; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719385815; x=1750921815;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=RujmQsstKfwyB6cKbkjbhAN/tLNxHRgXVLyHctvhEMg=;
  b=Aw3WdLzuK7K/R4HOFcGRrWVzYUXJTzpWczF0sM+8YYBwQYwiDjeFsnDj
   o6Vjo60ns6MpD6zwaJ6jt+TxU0YlnDMGswssxnkcvHdfLXz4BxmifQztV
   yCz2RsFhj27FGvSJTQGnGtgFRQwfkCLSNM7DNKYqGUbnboDSzI1P/4vAF
   nsz75OtWj2qTUfJf8cEWg4zM35tiVeMvOa9XlqalGcj800XH8wz783+u4
   /0wf/dJR2UonYWW6wxtjN4KEtHfLVBQNRXURBwu4lTIRIXjxowdP47K2b
   6Whp8eMN7osLsP3Fz1gufgjwW5cvuFPhFS9AWsMhPOZlUeYfI4fFH57DX
   Q==;
X-CSE-ConnectionGUID: K2bgoGW/TYKQN89hCybUtw==
X-CSE-MsgGUID: /TX2Opg3QHSCVh2yAUJQDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="27030034"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="27030034"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 00:09:58 -0700
X-CSE-ConnectionGUID: 0Z+TM6InQM6D7xpKgdoIRg==
X-CSE-MsgGUID: 2+Z7CGwfSsOeg/6WEvjtzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="81441447"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 00:09:58 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 00:09:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 00:09:57 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 00:09:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3G2jgJ8l+CVmI7pI2vI+AvV6T+d9AUIIICvhz2oH7lFhz11h+51IYmXN8xZv6cOt7VnhQK9DRBAAeUUm8jvhMEcvsA9zEQqVLUA6MEkWbbnJLnr7L+tRvP6VVZo6LFGeXpOuTeGO8zlHqevF1atEqX/QMb8S8bJZiJ2skegdlsY4VL1b9Pz5+KSTaqqBabnw7XVPf+Jw8sy75ZxoI5TIEzBCme/m9v+4R/CCLtuN3LyhUdD72S1O4QPWo8buutMadVkne7409T0zlBf+UMwz/zpNLhLBCMwHCyGrjA6XkKtyXwAYT1rIOM6+35rIvk5h+iP1Ahiw9n8CK8Mprf7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvgpgVxERZ4wssKvLVswIbRWnuHQyIEAblebyhurUgc=;
 b=BWHfRMe4Jdw5PZJOM0SIamte8Wsk87OvLzkm8tc8GtDnkZjZKLc5l3aokRanmgY4uWerWGGEr/EpmlA9rwfV6hSSThLIOgLeHkqp3JJC6JhJ1273mOYf1MMtdsQcuglbXZVa4+AcSgBIBUXPz0/z0nqVBHrboqLWEFJUrKn6sQrFYR/fzxjygtsIyFjBqveOfICrnAY2UgCJU9CFCT8Q29OElxMtgtJjr/HE6Z77B9MXLXd9Z6k47bwxsRI+JFHB8KwLM2ef/b7QyOj3xqUnD9Xpeh9urF/0h003XmW7FKDvqI4YpZhmnM8F48bj6aqdKtX25OETGoQ7jrnlsCExMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by PH8PR11MB7023.namprd11.prod.outlook.com (2603:10b6:510:221::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 07:09:55 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%3]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 07:09:55 +0000
Date: Wed, 26 Jun 2024 09:09:37 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
Subject: Re: [PATCH v2 1/2] selftests/resctrl: Adjust effective L3 cache size
 with SNC enabled
Message-ID: <b5xggwzdvavhqmxpaeisovp3e2xzjjhvkoqcbt6hg3sv3wzh3i@a7qaatwfpbf6>
References: <cover.1715769576.git.maciej.wieczor-retman@intel.com>
 <fe9295c6be677d187b1607185e23993dbfe74761.1715769576.git.maciej.wieczor-retman@intel.com>
 <9fa47acf-86b1-4602-8790-39ed80fd775a@intel.com>
 <n2el3evhluilmjhrwgpkkb7ld2g26zhmctxvm77b3ome6u6egf@hym7rnr3h2o7>
 <9b976e89-0320-430f-9f0f-48e25612ec98@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b976e89-0320-430f-9f0f-48e25612ec98@intel.com>
X-ClientProxiedBy: DB6PR0301CA0091.eurprd03.prod.outlook.com
 (2603:10a6:6:30::38) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|PH8PR11MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: f4b0f2c7-d3fc-4422-876a-08dc95aefa98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|376012|366014|1800799022;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?yKH3AivFj7FCbGKPRTO6xsCXTO+8TP7ig3/0tBpm3m9EGsPG0RTQmtKcLU?=
 =?iso-8859-1?Q?7xPB0CAjtLjzC2iJtjPyuBFdML4BNiz8vGbuSXGefPzbCdStqay2ff6F9/?=
 =?iso-8859-1?Q?w4WMm8G+lmKa536s5a77Z+jBwxSYbxqTzx2XzZEqilDkme0bs6VqtyxA/U?=
 =?iso-8859-1?Q?1h8eSUjRg3em97eQyYDpgZlmMk6+ICxBd17GQ6/TqMxz9pF2+zFIurIjvI?=
 =?iso-8859-1?Q?yxwcxXknk11c0LpHLtSWblH6VafjEWyM6TWP6zh0ZnQox6tNDRhKbbVOqp?=
 =?iso-8859-1?Q?G2Q6fHsL+dKT+MqipBsiHlfq+5QIKHv44C9+HlHqwAw/40C04kSIb0DPoM?=
 =?iso-8859-1?Q?NijRYUkTbQJtfIAWcrRT/OMe3N049RbrxmIrLvfEyGEFX+ThLo3+03EhUt?=
 =?iso-8859-1?Q?OTR+qXNi1xxuoPZcYUA7VNVinLDBasPp3cl9R2+40ieilNHeMUK0ET530x?=
 =?iso-8859-1?Q?NUpvSc9bZh0hp3BQ8GnIPux0etTwkai05Vu/QFmcrRqiHcCjxsYIvVtqo9?=
 =?iso-8859-1?Q?iF8EZqkPnfSZzx6r86rh7AZ6V3NK/xkCRTKtc26WRkLhvkHyE9TF8nFa88?=
 =?iso-8859-1?Q?n4YfQGYmb+9iIo314VCAh6eq/5o80jnfrAfkyCJEXfKJ9nMdtM7DgZBqvJ?=
 =?iso-8859-1?Q?quAJuDkmC0Jc3Hfh7dURd63EPn96qukfK+dvyzGzpGICT7BzLZtu+e39au?=
 =?iso-8859-1?Q?OyYw1ty+OtiuIEd3J1RNuN9TbSFvSLEOYjDO99ceQfW/CP163Vzgri7gft?=
 =?iso-8859-1?Q?vqZLahw6F5+Psny9jyZMBjl3h9pYGrl6I9CbW5wUWOQjkN5ZsL0EOpblBi?=
 =?iso-8859-1?Q?bQnjE91L8YulAzp2Amur/++7+giiIC94az+M5VCYMrYXnNel0h4EkhKeqC?=
 =?iso-8859-1?Q?DANJck9AOEXioR1W5Br46B9lIB3kYN1QnctctRcLDmUH8PDBB1/+c9QnXH?=
 =?iso-8859-1?Q?CSGfRwMKgsaxNePhbccCHQXDWZibay0hZbeJC6oVYCL9kk2SzsSok1KZc9?=
 =?iso-8859-1?Q?WYFUYsp+Cs6zwLvR6rPapKaMwmtjXiuuTGkVKBqPlT+otz0jeURd31+91H?=
 =?iso-8859-1?Q?fW/aTSnogKhRWxRLyRrex3M/1kJsNQYyZeDUzyV4TCrqMeRF049cbihJVS?=
 =?iso-8859-1?Q?KXpayQkoumL18XvHL8Om7HMTEJl7glPDoDhycVQ1vLeTf4xafb/mU1cXo5?=
 =?iso-8859-1?Q?zUdG4KA1jgWbeX0OPoFPUmxY0BVe7zg0BWTgjQmunaBJLzElcV5tLEH6mB?=
 =?iso-8859-1?Q?VgZ62Gcuwy6JVu+oEE2Fs3VzV3a+liLxNOe2rIFODwDKBUUnCN/JC+mkea?=
 =?iso-8859-1?Q?a47Uih5dMqnNtIJOqMA6nXTBzRY5k2W9t6lPbFfbHJjXS6j7Iyj7EUGBFc?=
 =?iso-8859-1?Q?8loNnr2feV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(376012)(366014)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?45q2V9cMAAt2wmKS7qfgSvgCEc1+aWEyp9F1vllPYPohhpgqqNmkBbFLCM?=
 =?iso-8859-1?Q?Qub4dfJZPlRQpf3Q+SB0hx3rkJL6tUK36/MjJaOO84gCWYS/1k20DBk/KP?=
 =?iso-8859-1?Q?HS8K+Rq9NJ6QaL5o7cVZZzlN2RU3oGiLH7J3j7vccA0nyPU7Vj1fytS5s7?=
 =?iso-8859-1?Q?Ome/vmcZZ3pWgR11K8vZUf5/dQccCHeSIdfcGRZeepRHFDMdLZdyf94LiV?=
 =?iso-8859-1?Q?XCKfmc5up08vFCIBEzBGYz4KOR+332JwJA17i13Nm6lIy4VanuF6pyN6B/?=
 =?iso-8859-1?Q?n/yuIV/EInlq0ArPm5X45BMdk56V3pvmF9zJHAopuOeHJ2bdLcAOhQlzBi?=
 =?iso-8859-1?Q?p1cehVba4ayyNIcwJ4jchOH+tWf1YH9bmjI+uQMrm1uia3XJCGNYtgD/4w?=
 =?iso-8859-1?Q?y87DOARakmykFX5g/uKiI3ObIaaMngWWj04DvcdhSYq4JFSykgzA/EDjaB?=
 =?iso-8859-1?Q?sbn+20j0nlcV9VSNWmOHphHsjQZVwtpU5boLsL/3I+y5erCsApSjkLVOOT?=
 =?iso-8859-1?Q?kgOnnma7yFxTlMEKHVbXsSA8Z6cu+5TdbnqiJxkKA4eoL8Ug9wsXeXKmie?=
 =?iso-8859-1?Q?kDfU+uqQVtXYd1e05ofH2TMLcyksn5yPhpzu/sg3saaoqmIAN7S6L2ZIGH?=
 =?iso-8859-1?Q?hjOCppQ96mmGXW6eeSXb6zO6ZY5KZ66iiMrDbFjX0uIXzr1yJDUjSWLJ0K?=
 =?iso-8859-1?Q?hxeh32CBpkA8g2RcQRCbXqYoL1rOo6ndb0SBjQRc5EyIC+2C8irTNWjKM+?=
 =?iso-8859-1?Q?ohuQ2AqV7hUwv86I6YtpQgd5U4bZZcEHy8kaGkxY1yuuvhTwAkAm1S/X2Q?=
 =?iso-8859-1?Q?SwcOGVBY0x9hICZGpBA6297U3kebNbZwP1P0yetwxmc3tb8Fser+OzGdMm?=
 =?iso-8859-1?Q?BhcetXOpWTTjxucDKeZT9spF4tqQlJqYNH0rLG8vCfj7yUlgjUw4wyjqD6?=
 =?iso-8859-1?Q?m3V+90uX3U5S0A5diChQSjcYIay898RE7oq4MYSpPfUJ+3i/Bd6EGTxpTd?=
 =?iso-8859-1?Q?HP4TsgGNJa79hPVPtRql6LL0jRob/NnCY+Ya79Low4D8YS+LcoVrA+Xedn?=
 =?iso-8859-1?Q?0qdaPTaCtafmyOTFGOK1ZqEyV8eKV9fQXWxa22eSa5nqaD50DepDG9vMb/?=
 =?iso-8859-1?Q?hLDVlqpFr+X37YI3JlOEPXLjBTVYZgrLfcJhDq/+sqNbPqLneJK3qEFax+?=
 =?iso-8859-1?Q?KYbvGUXrwnADQ8S3fgTqhbsM5q8DIBmFFIvcMm0misgpWgpPa6wWOmUaaX?=
 =?iso-8859-1?Q?e1Bkt5kZrTIxOpZEs0GZf85y1jl0lvWuvtsfOYobBu04lrKqafaC4gMpU6?=
 =?iso-8859-1?Q?DJmPzlmYaCgeasLCqDnz6n7GcJZbdQWptYl2PcFL7YIXkf8s3oLqTOmZQD?=
 =?iso-8859-1?Q?Sub7t1lk3mgm8kROcRZpmOOq0OnPiofpuPPIIN9OoWvLMYziy462adwrW3?=
 =?iso-8859-1?Q?7+3VNapdxo14/ZAVMnSkCNeDGFl6lUnZpVLOzSyc52w4bUv1wmcilMOpYL?=
 =?iso-8859-1?Q?wmV8DsXRx9ft8w6sX3Vd8QNNCT95UTyUwpoxBVjTiKiluJN8150APDMyVU?=
 =?iso-8859-1?Q?tibatQG3H1lYQ8ngyFgxyHzqXNzB13LZ+0br/dqJQIDjmNaKpPczLZwK1p?=
 =?iso-8859-1?Q?193PyW1ceApeTKZ5JdMy/EidzbSB7BTopcPxm4YvzfUWQnkr181j1+71fW?=
 =?iso-8859-1?Q?JwudiK3uvRN+nKSZT1k=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b0f2c7-d3fc-4422-876a-08dc95aefa98
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 07:09:54.4331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5hMMO1OJ4eGHW7p5mcABVaBufXVhI23pga42SC7m7Dsdyo32muSliSuNL65X9UeJ/QF40SF2jNOVO7pM4G2UFqnKoyFbuJpppS238oS5eiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7023
X-OriginatorOrg: intel.com

Hello!,

On 2024-06-25 at 09:28:55 -0700, Reinette Chatre wrote:
>Hi Maciej,
>
>On 6/25/24 4:04 AM, Maciej Wieczor-Retman wrote:
>> Hello,
>> sorry it took me so long to get back to this. I prepared the next version with
>> your comments applied and Tony's replies taken into account.
>
>Thank you very much for sticking with this.
>
>> 
>> I wanted to briefly discuss this before posting:
>> 
>> On 2024-05-30 at 16:07:29 -0700, Reinette Chatre wrote:
>> > On 5/15/24 4:18 AM, Maciej Wieczor-Retman wrote:
>> > > +		return 1;
>> > > +	}
>> > > +
>> > > +	for (i = 1; i <= MAX_SNC ; i++) {
>> > > +		if (i * node_cpus >= cache_cpus)
>> > > +			return i;
>> > > +	}
>> > 
>> > This is not obvious to me. From the function comments this seems to address the
>> > scenarios when CPUs from other nodes are offline. It is not clear to me how
>> > this loop addresses this. For example, let's say there are four SNC nodes
>> > associated with a cache and only the node0 CPUs are online. The above would
>> > detect this as "1", not "4", if I read this right?
>> > 
>> > I wonder if it may not be easier to just follow what the kernel does
>> > (in the new version).
>> > User space can learn the number of online and present CPUs from
>> > /sys/devices/system/cpu/online and /sys/devices/system/cpu/present
>> > respectively. A simple string compare of the contents can be used to
>> > determine if they are identical and a warning can be printed if they are not.
>> > With a warning when accurate detection cannot be done the simple
>> > check will do.
>> > 
>> > Could you please add an informational message indicating how many SNC nodes
>> > were indeed detected?
>> 
>> Should the information "how many SNC nodes are detected?" get printed every time
>> (by which I mean at the end of CMT and MBM tests) or only when we get the error
>> "SNC enabled but kernel doesn't support it" happens? Of course in the first case
>> if there is only 1 node detected nothing would be printed to avoid noise.
>
>I agree that it is not needed to print something about SNC if it is disabled.
>hmmm ... so SNC impacts every test but it is only detected by default during CAT
>and CMT test, with MBA and MBM "detection" only triggered if the test fails?

Yes, snc_ways() ran before starting CAT and CMT to adjust cache size variable.
And then after CAT,CMT,MBM and MBA if the return value indicated failure.

>
>What if the "SNC detection" is moved to be within run_single_test() but instead of
>repeating the detection from scratch every time it rather works like get_vendor()
>where the full detection is only done on first attempt? run_single_test() can detect if
>SNC is enabled and (if number of SNC nodes > 1) print an informational message
>that is inherited by all tests.
>Any test that needs to know the number of SNC nodes can continue to use the
>same function used for detection (that only does actual detection once).
>
>What do you think?

I think running the detection once at the start and then reusing the results is
a good idea. You're proposing adding a value (global or passed through all the
tests) that would get initialized on the first run_single_test()?

And then the SNC status (if enabled) + a warning if the detection could be wrong
(because of the online/present cpus ratio) would happen before the test runs?

On the warning placement I think it should be moved out of being printed only on
failure. I did some experiments using "chcpu" to enable/disable cores and then
run selftests. They didn't have any problems succeeding even though SNC
detection detected different mode every time (I added a printf() around the line
that cache size is modified to show what SNC mode is detected). While I
understand these tests shouldn't fail since they just use a different portion of
the cache I think the user should be informed it's not really NUMA aware if the
detection was wrong:

(this was a 2 socket machine with SNC-2 and 55296K L3 cache size)

This is without any changes:
	[root]# ./resctrl_tests -t CMT
	# dmesg: [   11.464842] resctrl: Sub-NUMA Cluster mode detected with 2 nodes per L3 cache
	...
	SNC NODES DETECTED : 2
	# Cache size :28311552
	...
	# Average LLC val: 12413952
	# Cache span (bytes): 11796480
	ok 1 CMT: test

This is with all cores on node 1 disabled:
	[root]# ./resctrl_tests -t CMT
	# dmesg: [   11.464842] resctrl: Sub-NUMA Cluster mode detected with 2 nodes per L3 cache
	...
	SNC NODES DETECTED : 1
	# Cache size :56623104
	...
	# Average LLC val: 22606848
	# Cache span (bytes): 23592960
	ok 1 CMT: test

And this with one core on node 0 disabled:
	[root]# ./resctrl_tests -t CMT
	# dmesg: [   11.464842] resctrl: Sub-NUMA Cluster mode detected with 2 nodes per L3 cache
	...
	SNC NODES DETECTED : 3
	# Cache size :18874368
	...
	# Average LLC val: 7382016
	# Cache span (bytes): 7864320
	ok 1 CMT: test

CAT also succeeds although it reports bigger or smaller cache miss rates than
normally:

SNC NODES DETECTED : 1 <-- all cpus on node 1 offline
# Percent diff=12.7
# Percent diff=10.2
# Percent diff=7.8
# Percent diff=6.7
ok 1 L3_CAT: test

SNC NODES DETECTED : 2 <-- real
# Percent diff=49.6
# Percent diff=37.8
# Percent diff=22.4
# Percent diff=16.0
ok 1 L3_CAT: test

SNC NODES DETECTED : 3 <-- one cpu on node 0 offline
# Percent diff=76.6
# Percent diff=53.3
# Percent diff=35.1
# Percent diff=28.9
ok 1 L3_CAT: test

>
>Reinette
>

-- 
Kind regards
Maciej Wieczór-Retman

