Return-Path: <linux-kselftest+bounces-3430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E79B08396A4
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 18:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189D41C20CFB
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 17:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E7C80046;
	Tue, 23 Jan 2024 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mDOjUbHl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06E980036;
	Tue, 23 Jan 2024 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031749; cv=fail; b=FpHv8pbsOb1V5iUKudW9HLZtEE+ZzCmr05/abY+fjfmR6ygGLmwfetoVwa7ltVrEbK3O/xeLj77TYwW5YmhxDnzMfUypwba4I9dPvufi2MqtpP2FiaRf9CyK516kuy1iLE71xqFABV571rPYCu2uUu3pnzPcjYvf6hnERFo4Dsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031749; c=relaxed/simple;
	bh=0V5TEuQezAzuGKyA38caAwXN5X6gaC4YGdy8UFZxFcA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fPnxVpCXYpq8DEWTSO0OEUwMaQVKBes5BipqL7X1RPg1YBT1bsNhCQdDQwJlrNe+1PRzFSZoZC2kR8B2O4qcmbihuarkHB4M82f2p81pizi4kdXm1KdUjNCYKyLDPvAMYkCP262vqb3RcXaYIzo/LrqjuOjMHgzRuXeHn2W4B0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mDOjUbHl; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706031748; x=1737567748;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0V5TEuQezAzuGKyA38caAwXN5X6gaC4YGdy8UFZxFcA=;
  b=mDOjUbHlPuKvLAoTqynZOMywNz8ZecxnU0TD3nGQHX3V1w5HaMv+G2m0
   J8kqUtRLYlnmJjaTW4g+sOnyFIrDOab0XG+7rRbkgMRh8f09I5VRw2Z7K
   e0IBfOwuzrJK9nG6fIwyf2lBtHqABnPUhXy278dIONNsQXowV+U8Ammpt
   nfDwuH9QhAFlE4tZ4w30B15asSrKddQtiKT2yLn87rit6fRmj/dIxr/8a
   eMDoYoszRbDmR0otQCvtAIRF8YFjuI0/l/BRDeETZwGd4b1JDU3G9oJpT
   8TPmkcH8dHUA9HxKG2uIQzxvMiQ2STvaXTgMwc2tDHMxGfiFe1eSiuckx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="8252200"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="8252200"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 09:42:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="1688089"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2024 09:42:26 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 09:42:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 09:42:25 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Jan 2024 09:42:24 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Jan 2024 09:42:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRjBdUKf/hICPG/SgLPEGAgGuTZuti9p9/tqv828Ib+neEBTDpWVnu3xinEBrki2MbQXmuvQYKsnPOk1m1fT+v2FpJ7IsT6jxUfxS+JMpEtWBFKUSn6PLWI5Er6Z832mc16AXGKFzmR1vGnvUhxuGr+dlZZ8rBATUGcpeQbfWkv1vz7t8+O4dE2It9qmQpln6ngHhC7iAN1Hi7TmpIU/3VSlODcJVRuKiXpOKyGe8fDAAuKmFk5WOZYbzllFqqDw6/xAsvuSWoVtR7TtOcIvp/0dVaJAixT5LQqzGGB/ygCjN2L4FfPMsu+E0DZhNkKO4meAaHf31fgQLBYD+DTTSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIizG/5WPxSNSWLbQiZypiaZTUnqLZnEq9UXSen4OYA=;
 b=oVzDkhcZgxqy7AfcwaeRQ7SPyX5MhUQBs6OoqLO5OoeDHOKsvCzUIsIAmMKqSJa+NBhjectq92i7mkxsoCb+EsrUbO53rEWnmwZaWmkoiJTM3XlEP5/tWWzhlVxX2e8U+ip/7kVhzJSA/YeRmxt1SDGriZcE8Q8HQkVEnqnt+pG5bA7J/sZesnF9p6WsEBoJRUSxmOR9n6xGGu9YtneLSwBtmPzYlhjxzoopVFL+Svxp0p29AH0Yxoj3Jxh/JzphMgqPlddEhmhVqUHXqKi6pCs/g1hGY1KU4D0IdtUhOYBLvpL/Wj/kUzvH3L/589PWN/qK9Yp3UMv841eMVZH5ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BN9PR11MB5244.namprd11.prod.outlook.com (2603:10b6:408:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Tue, 23 Jan
 2024 17:42:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7202.034; Tue, 23 Jan 2024
 17:42:09 +0000
Message-ID: <1dd1c812-ecbb-4972-88a8-4ec7dd82ba8a@intel.com>
Date: Tue, 23 Jan 2024 09:42:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] selftests/resctrl: Add non-contiguous CBMs CAT
 test
Content-Language: en-US
To: =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <10c3afd7f62c63db31a3d4af86529144a5d7bbf9.1702392177.git.maciej.wieczor-retman@intel.com>
 <fd6acf6a-2610-406b-b363-220121a45aee@intel.com>
 <6v4hgra7bd5nwubcgtbsidmoohrgxdw7no4faa4a54g4vrxo63@c6qnujvwn5ej>
 <73cea732-3757-4aec-a39c-4f0e50f6fb70@intel.com>
 <su2d6i22icynusoykmowfnzery6hlqugovaw4xcrhb7r3ymbx2@aeimvrxsc5xw>
 <05db3bdc-9d54-44d2-8aae-07d66053892e@intel.com>
 <wvehk3j2dcf3lkuantb7shefymxj2mnzv4pgbiqbk4jkmmzeid@lurk3dam5tb6>
 <92bccaea-b73f-42e0-a386-1a73eb6f88de@intel.com>
 <m3bhu3j3jzdo67mmuezjmwu4elyqjdwmoixcxm7qthls5tueqk@h7bvwxmy3l4y>
 <227e43a1-a11a-4d49-8dde-c8b65527e926@intel.com>
 <h7cbw6x7bxx5o7vyamhacgarx5fs5rgmyttawxkrl6fgtjjqmk@naisceux4lns>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <h7cbw6x7bxx5o7vyamhacgarx5fs5rgmyttawxkrl6fgtjjqmk@naisceux4lns>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0180.namprd04.prod.outlook.com
 (2603:10b6:303:85::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BN9PR11MB5244:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db3cf7b-9c23-4504-2555-08dc1c3a9ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qcScAVoVA96GOK4UqatD0YktURZycOrJNNn2jMn+il5OauuIPtjgMa7N/OPpySxJjJyBUtmmjKLZNFKV086mrUAfRIorqVsDlacw92Xc6DBdF0rjQuoa8naEzcoTTpsEcta6vVe+ISA6IPmDk5AAFip/B/+fAd7R8TJCXvwg30hGxpueDNA/UTvgO8Y9UpXbGn8lhnimllC+HGMoMOpzDnBMZJ1QvX0JbEduQ1bq179APlFG72IGAddgECi8XqoGspW41tkTneLg63TzKxAVEwMhi18TiYzNHfByhIEm8/MNzqQLEnCrrYcrtPQIPdLpvCFrh1YnBkl2GlEHz5s/R9dgp0cpqcG3+ipC5K+vZ0mypv6U7GA8HNKKy2hRRNmk/j7HGShF3jVZueK6SvNOO0QbaVQy35OCvNAdTcVCVr/XRrdKWHglnUzzmJ3VmA+abxfoIkoxOlEL3uC+hQvL4BikM2TgnkxLLInM43mk/zr8K6U+cc+823bBjxpjAWsROOBtfc7po2r0460Hjswu2WMEFaBSMiMyhJIYQ0MUg17mglYkHNsdni44yknhxlG6mZb5FVo/4CMLfKlafLexlQFafZLfkhhtFvmRpjmTgY6AstARFKbkzzgD4mXkT6h1dMpxF1yL15OzpbO8hYBpdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(8676002)(26005)(66574015)(6506007)(41300700001)(53546011)(36756003)(6512007)(2616005)(6636002)(5660300002)(54906003)(316002)(66476007)(37006003)(66946007)(66556008)(8936002)(82960400001)(6862004)(4326008)(44832011)(478600001)(38100700002)(31696002)(2906002)(6486002)(86362001)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0dBSFdGaEVlcjBtMlpYSlZSMVZmblkySGZIa2prQlZvRjFKVVVvSlYzbHZZ?=
 =?utf-8?B?MTA0R0lhbEtDakxDbHRmL1JvT0J6cmEvekxxdFBabkJPSGpmZWhVRHk0MnAw?=
 =?utf-8?B?M3YzL3dXUE13OGNBMXB1UmZPeS9RRkVBbDU0cWVQbFMyMFF1RXZCWm5qSE9p?=
 =?utf-8?B?dHRvOFE1VGs2ZVpBbEx1VGgzRGNjamhXU0VIWWMzL1l4RGRicUxEQnFiK3Ri?=
 =?utf-8?B?dWZpL2VhOEpFNW5WbFUvMm1PVlJIR2xRcHNEY0U1VDhURWlxNmFGbVZSaitM?=
 =?utf-8?B?S3cyUzgzbVEyWEhSMmM0clhQNXA3ajlJd3F6SUV6RC9xYmx4d0MvV05RT3VN?=
 =?utf-8?B?Y3ZINnlRcTJiM3k2bTdpOGZYVFI3ck50Z0pUM3lEbUJaOGpmaXRxY1pDOEEz?=
 =?utf-8?B?dGU1bDdhNXprYUdXRmprakEzelJSTXQ0TUV3WFY1SmpPV25oNGg1VUFueVY1?=
 =?utf-8?B?MG40b3ZMb2JuUS95cnoxN0cvdUZSblFiamprZ1R0UVdsVFBMcmVqVUJTbUJl?=
 =?utf-8?B?WnBTbDBhK0tPV1d6eVpoSGtpUytkR3d2dmFBcU5hbDNvQ0RMR1hYOGdVRmZB?=
 =?utf-8?B?WGgwTkJva0tEcllMQmxUMEsrbmhRc0RiSkZGUERnOUNWeFpjcGU0YzRpWUcw?=
 =?utf-8?B?RmlneVF3TW5xTWYxYytLTlNxemEzRlc2TjhPMUdVdDlHemYrNVczMU9vZ0pG?=
 =?utf-8?B?Q0ZHOU1yRGlrOXBwcmZtUXFPWlZJdUJsRXpPQWpaekM0cytKejI2QW84STEw?=
 =?utf-8?B?azR3Q1hMWkhnM0lZcXRUUjJNbHkzeDcza0E2UzRCZFNSQkRtQk1mT3pjQzA2?=
 =?utf-8?B?ZDh6emR4TUZzcTByMkg2eGU2QURCS3lxNzA5Mk1ZY2NaU0crdWR5VG1iKzVw?=
 =?utf-8?B?RmkwNHFTQ0pLa1A0TWx3SUtSY3VhTnhFa1FoaXdkOEswN2dGMGxHVC9ObU9l?=
 =?utf-8?B?VXBvK0ZTVFp6Q3pHS3FsTk9wZ3BMSEFuZCtjZjRBUDEwNnpobVAwWXRiQU82?=
 =?utf-8?B?cG1KdVhpdmhqS1dwTExiWU1FMDN0UWw0Tld2TUs5ZlI3dWNid25PMEJpeUFY?=
 =?utf-8?B?QkxZR09XcGFLWS9iWFpSdS9YTmoycHJPczJQSDZKUmp3OTY1QVpaVzBxWVZ2?=
 =?utf-8?B?RjFFZm9POWd2UXJZYkxWRDNQMjdCZlAyZG9lMEJVTW1KeSs3eEZOaXV0K1Nt?=
 =?utf-8?B?YUJOR21QdjVjVlpBUGZ2SExZeC92TUNWb0tYbm85WXBNbHFUaCtvS05oQnFD?=
 =?utf-8?B?cUFmQzJpT3VxN3h3TjlRaC9rUzJIVGxZWXNrL1VFei9BTW1icVoxTzl2ZzhP?=
 =?utf-8?B?RGtSd2hmZ0c2Tm9obHZhV1NXeFNDR2xtZ1ZmcFdvdUtOb3R1dGJHY25kVHBL?=
 =?utf-8?B?bXlGWmtrZW9qUE16bHprb0RqNzRyVlBhVXN6TkdxM2xScmJvZFVQU1h6Z2Z3?=
 =?utf-8?B?ODV3UjZQSCtjN1FaYklBUlorQVlwUmRyL0dPTkpDUFQrZUxCMHMrY1l5UFp4?=
 =?utf-8?B?NlU0Ui9kbXpDb3JyakFJK20xT0VDL3M5WDUwaUUzUk5QUTcxQjNwc25NNFFB?=
 =?utf-8?B?OFlEZWJPczVWWkhKNHE1cEFjSWJHck5LTkp5N2RiM2hQaFJTRTJVdUt1dklE?=
 =?utf-8?B?YncyTWh1Y3hVVFBDeU0wSU5oR0pFcEVLNDlRMkFRNFoxeUlnR1V0ZFFzQjVh?=
 =?utf-8?B?MnUwT0FwRnJlSm9tZHFnZEtIcStldVdKNG5vMC9GVkg2eTFwVklKMVR0YllK?=
 =?utf-8?B?YXFzR09TQ3U0V0RHNDBHWWswbXd6RlZ0UFY2VThlSHBxdWYvNkMwVTdkdVdi?=
 =?utf-8?B?bDlwMTdkZzhsaWduWUZYd3VHUHZORjB3TkJjRUROUXNhZ2RWNWpyN25UK09z?=
 =?utf-8?B?dXo4Ky81Mmk1SVJzeko2SFNrZkkzY3l1RnZIRDR0dGtQTXVWb3hLcE9xMDFx?=
 =?utf-8?B?cGxQUVhNTlFTRStUWkNvbG1nU2VtamdUSTdvcnlQVURDM3h1L0ZyYWpWVU9p?=
 =?utf-8?B?Nm5hc2JQVXRJY2IxcGMrQTBjdkRFd0xYQWV2dks4ZTBPRzk3Z21WcEQ4MVND?=
 =?utf-8?B?d29ZdzBlSzJwZ1hQN05ZN0c4YVFVa3NTdmlQZDdHb3hnTmVDOW92cjYwUG9P?=
 =?utf-8?B?cEZJVW5wRXdUUmdaSk02cC9DY0NvQ1RlTURITVlybEhaYmxJSWY5bU9PWFZ3?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db3cf7b-9c23-4504-2555-08dc1c3a9ffb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 17:42:09.8995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5VBb1WzNyyKd4i+cv7bdQ9+KNIRItehERqmS6idSCEXvoWRS7vtA8TcYXZ2NsZQZ9PbLSqg16nYO14vvNthGWW3cEQYOLabBmr2uTHUlDF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5244
X-OriginatorOrg: intel.com

Hi Maciej,

On 1/22/2024 11:58 PM, Maciej Wieczór-Retman wrote:
> On 2024-01-22 at 08:32:36 -0800, Reinette Chatre wrote:
>> Hi Maciej,
>>
>> On 1/21/2024 11:56 PM, Maciej Wieczór-Retman wrote:
>>> Hi!
>>>
>>> On 2024-01-19 at 08:39:31 -0800, Reinette Chatre wrote:
>>>> Hi Maciej,
>>>>
>>>> On 1/18/2024 11:37 PM, Maciej Wieczór-Retman wrote:
>>>>> On 2024-01-18 at 09:15:46 -0800, Reinette Chatre wrote:
>>>>>> On 1/18/2024 4:02 AM, Maciej Wieczór-Retman wrote:
>>>>>>> On 2024-01-17 at 10:49:06 -0800, Reinette Chatre wrote:
>>>>>>>> On 1/17/2024 12:26 AM, Maciej Wieczór-Retman wrote:
>>>>>>>>> On 2024-01-08 at 14:42:11 -0800, Reinette Chatre wrote:
>>>>>>>>>> On 12/12/2023 6:52 AM, Maciej Wieczor-Retman wrote:
>>>>>>
>>>>>>>>>>> +	bit_center = count_bits(full_cache_mask) / 2;
>>>>>>>>>>> +	cont_mask = full_cache_mask >> bit_center;
>>>>>>>>>>> +
>>>>>>>>>>> +	/* Contiguous mask write check. */
>>>>>>>>>>> +	snprintf(schemata, sizeof(schemata), "%lx", cont_mask);
>>>>>>>>>>> +	ret = write_schemata("", schemata, uparams->cpu, test->resource);
>>>>>>>>>>> +	if (ret)
>>>>>>>>>>> +		return ret;
>>>>>>>>>>
>>>>>>>>>> How will user know what failed? I am seeing this single test exercise a few scenarios
>>>>>>>>>> and it is not obvious to me if the issue will be clear if this test,
>>>>>>>>>> noncont_cat_run_test(), fails.
>>>>>>>>>
>>>>>>>>> write_schemata() either succeeds with '0' or errors out with a negative value. If
>>>>>>>>> the contiguous mask write fails, write_schemata should print out what was wrong
>>>>>>>>> and I believe that the test will report an error rather than failure.
>>>>>>>>
>>>>>>>> Right. I am trying to understand whether the user will be able to decipher what failed
>>>>>>>> in case there is an error. Seems like in this case the user is expected to look at the
>>>>>>>> source code of the test to understand what the test was trying to do at the time it
>>>>>>>> encountered the failure. In this case user may be "lucky" that this test only has
>>>>>>>> one write_schemata() call _not_ followed by a ksft_print_msg() so user can use that
>>>>>>>> reasoning to figure out which write_schemata() failed to further dig what test was
>>>>>>>> trying to do. 
>>>>>>>
>>>>>>> When a write_schemata() is executed the string that is being written gets
>>>>>>> printed. If there are multiple calls in a single tests and one fails I'd imagine
>>>>>>> it would be easy for the user to figure out which one failed.
>>>>>>
>>>>>> It would be easy for the user the figure out if (a) it is obvious to the user
>>>>>> what schema a particular write_schema() call attempted to write and (b) all the
>>>>>> write_schema() calls attempt to write different schema.
>>>
>>>>> As for (b) depends on what you meant. Other tests that run more than one
>>>>> write_schemata() use different ones every time (CAT, MBM, MBA). Do you suggest
>>>>> that the non-contiguous test should attempt more schematas? For example shift
>>>>> the bit hole from one side to the other? I assumed one CBM with a centered bit
>>>>> hole would be enough to check if non-contiguous CBM feature works properly and
>>>>> more CBMs would be redundant.
>>>>
>>>> Let me try with an example.
>>>> Scenario 1:
>>>> The test has the following code:
>>>> 	...
>>>> 	write_schemata(..., "0xfff", ...);
>>>> 	...
>>>> 	write_schemata(..., "0xf0f", ...);
>>>> 	...
>>>>
>>>> Scenario 2:
>>>> The test has the following code:
>>>> 	...
>>>> 	write_schemata(..., "0xfff", ...);
>>>> 	...
>>>> 	write_schemata(..., "0xfff", ...);
>>>> 	...
>>>>
>>>> A failure of either write_schemata() in scenario 1 will be easy to trace since 
>>>> the schemata attempted is different in each case. The schemata printed by the
>>>> write_schemata() error message can thus easily be connected to the specific
>>>> write_schemata() call.
>>>> A failure of either write_schemata() in scenario 2 is not so obvious since they
>>>> both attempted the same schemata so the error message printed by write_schemata()
>>>> could belong to either. 
>>
>>> I'm sorry to drag this thread out but I want to be sure if I'm right or are you
>>> suggesting something and I missed it?
>>
>> Please just add a ksft_print_msg() to noncont_cat_run_test() when this
>> write_schemata() fails.
> 
> My point all along was that if write_schemata() fails it already prints out all
> the necessary information. I'd like to avoid adding redundant messages so please
> take a look at how it looks now:

Please consider that there may be different perspectives of "necessary information".

> I injected write_schemata() with an error so it will take a path as if write()
> failed with 'Permission denied' as a reason. Here is the output for L3
> non-contiguous CAT test:
> 
> 	[root@spr1 ~]# ./resctrl_tests -t L3_NONCONT_CAT
> 	TAP version 13
> 	# Pass: Check kernel supports resctrl filesystem
> 	# Pass: Check resctrl mountpoint "/sys/fs/resctrl" exists
> 	# resctrl filesystem not mounted
> 	# dmesg: [   18.579861] resctrl: L3 allocation detected
> 	# dmesg: [   18.590395] resctrl: L2 allocation detected
> 	# dmesg: [   18.595181] resctrl: MB allocation detected
> 	# dmesg: [   18.599963] resctrl: L3 monitoring detected
> 	1..1
> 	# Starting L3_NONCONT_CAT test ...
> 	# Mounting resctrl to "/sys/fs/resctrl"
> 	# Write schema "L3:0=ff" to resctrl FS # write() failed : Permission denied
> 	not ok 1 L3_NONCONT_CAT: test
> 	# Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0

Understood.

> Of course if you still think adding a ksft_print_msg() there would be meaningful
> I'll try to write a sensible message. But I hope you can see what I meant when I
> wrote that the user could already easily see what failed.

I do still believe that it will be helpful if there is a ksft_print_msg() with
something like "Unable to write contiguous CBM" or "Write of contiguous CBM failed"
or ... ? 

Reinette


