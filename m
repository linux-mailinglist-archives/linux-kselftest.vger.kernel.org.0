Return-Path: <linux-kselftest+bounces-39609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8563BB308E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 00:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3721A1891FDC
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 22:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E532E719B;
	Thu, 21 Aug 2025 22:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iapxtzz5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81432DAFB5;
	Thu, 21 Aug 2025 22:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755813809; cv=fail; b=p0SVLK02hQdFE5oOxvu9rp7YZ/0Vm27BkAfhx9GKhXrEgrrwnZHqwa84R/bddb9lyFalX8YmqTTwNqOFqqCpV4FogAK69MCz4PziYXur/wgvoWCRqv+wZb7vIBS+6pALCI0LfRRiHr80EqHfTz64+u3h6Mfz7Vx3cfrFG+o22Rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755813809; c=relaxed/simple;
	bh=GD9XPVuvZhq80/Kc1ff6ROpWAcZOPzh8TfC3yRNoM7o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Av6EJ5di6vcmN1WJ6bQMiFhqAM3akq0eL4Lh1EQjRfLy7xAvLXAGS2Uk0BBbEqu1fRCFvvxemHnrB29vO3gYHA2pGBf8OtZVk5eyAMCUQzj46d+JZfQGLcpz39U39WZkY+/PfiVsboaTqz747fTFn8a7Bv8QcPv+qJeL5YeARJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iapxtzz5; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755813808; x=1787349808;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GD9XPVuvZhq80/Kc1ff6ROpWAcZOPzh8TfC3yRNoM7o=;
  b=iapxtzz53ch7BH8kWPaoKhGhJr67KgsT81qTcFCRz858TEM7E4fJiIPb
   4TSfiq185nCpNqtlyMXL/1Y9QAi1vyjp9LIvzLfBsTvienyNWAxph/8/G
   mfWMwCl+zyfpccpRv0gQQoz2JhDq9FHSCrJjfxmcGZjYEme0hWlvCJrsU
   dpCIEODOBSY1+W7gvd7ANBdOT0xI4DLU4J1g0jph3TEIWxCEe4v6OUYDn
   zALF7ZgXJWaT/wTQfwPORBpEcXaKajJ1MwOLmg0cJFfIbOTJgQRQ3qD8E
   F9gSpKuOasWj9l6I9Voefoyx4NGOraJzIEDsxZdW90qMFZe/5jRVrFWtF
   A==;
X-CSE-ConnectionGUID: 7th5UaRrRDSADTt2OsHbgQ==
X-CSE-MsgGUID: Zpe2q8uKTbGbiU0Gqvb6kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="83537346"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="83537346"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 15:03:27 -0700
X-CSE-ConnectionGUID: 4ZxNqxesQ7KvpXdnV/wuiw==
X-CSE-MsgGUID: NqewTIRPTvaqv7XO1hsH8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168431972"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 15:03:27 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 15:03:25 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 21 Aug 2025 15:03:25 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.82)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 15:03:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/XskkPIfZXThOwq6ZdnbyTcXUlC5/HQUhIcfqhbug8FFn85TUWzgLIw8H5DaY1Bbjx01g14Q95LXoGNs7t7M+0KZuOSCZ1ravJwLAMG1oJT4GPpiANeRF/dTbu4O11M69/81LyP+4qfCTj8Odx48qJ7KfQGvklDccFiUcxVpOKHxWX15u63N9OPreqym/3XvQ9A2wfInPX5lTPus6jp+Ico6tRMyQec8ABLCMFZbK1E4QJsR7TobORStF/OZiQpROxUjxQO30YkMLCfArdrzMhN9P9gw7H/6b/o0FPyCi3DDk3o8mM+HgwCHSChpgyAkG9ZJAIPGA0Oocjfh78PEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMRSeZVrJVZDGfCJpkwGk0ijCfab3/MSzARC1DwV22k=;
 b=pZmJW7EaECe0KaafIsMieEHakaHVPW4WUCqb7jKRcf5nyWmDFZtBwOl7xi/MfXcu/PoyHb/aez++uWaLHshvubYtWrELUSpsVetGrucvVWt3XlHhaLAwVIvGgPifTcY9G9e1AYuavPhlG3z+3Qtd4r09VYmv3G9buyqeL+14M+7uho/5/YASptcB7PN0nnqLccvfXx68uZtXaN3rIhNEsSfNIlvq7daLpG0FZ2p0DXWv+fmdHpM8WUb6/8eUePdUDj5WzsGPcqwso4Xv1QgKEas/pbpqqffJQprGvINumk0bwSQ89K1bKvGN3sGiMNu5JP9He0vGXuBKVT0oY8yLMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by IA0PR11MB7695.namprd11.prod.outlook.com
 (2603:10b6:208:400::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 22:03:20 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::bbd5:541c:86ba:3efa%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 22:03:20 +0000
Date: Thu, 21 Aug 2025 17:05:04 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas
	<erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Roger
 Wang" <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, "Oliver
 Upton" <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, Chenyi Qiang
	<chenyi.qiang@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Adrian Hunter
	<adrian.hunter@intel.com>
Subject: Re: [PATCH v9 05/19] KVM: selftests: Update
 kvm_init_vm_address_properties() for TDX
Message-ID: <68a7981019500_2be23a294ba@iweiny-mobl.notmuch>
References: <20250821042915.3712925-1-sagis@google.com>
 <20250821042915.3712925-6-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250821042915.3712925-6-sagis@google.com>
X-ClientProxiedBy: MW4P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::23) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|IA0PR11MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d2dd18-1bc9-41f6-f38f-08dde0fe89fd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0dc/c8ndiIJjVxYL9sRw1snuumKCB5OWvr3QhXDL8dWz49v7idyJZBK6rN+r?=
 =?us-ascii?Q?ZHWX1MhF/whiEjZ1AVAvjN6SSNLQgbPzzQpOQFIr1QXgzOXK8hJ/wytYmXDB?=
 =?us-ascii?Q?H2Remfglf8vNdycp57PDnU+7emCGEh63qTjxP9qAA1cZt6fuctPhzzBgdi8Q?=
 =?us-ascii?Q?ovPsFl/w/6MbnceZCW86u5qFvpiQ49DBWEz5Fvq/1uM0AOnkl+EcoU0IaY0O?=
 =?us-ascii?Q?PI2TxwpGprIj3diIwDbeIYKBe4h8Ux567yWQwGJMvJ+7AajxGjWXQcu83HQS?=
 =?us-ascii?Q?r7jPSlg6J30spjMfIMmr174uz7L5Sw2msIJzkEIGEUa6sYBZI4gP6Svzk+83?=
 =?us-ascii?Q?8Nz2AZ+mLYDglPvKx9JjvbiTbR8JNYaZs9b4SkB3maQYNI/Cg0UajbCefuVV?=
 =?us-ascii?Q?Zg60WNFFwJVrhmdHfopcUK5S9+LVr9cJDkxHOM6Khw6IdEIF/Cj3vDKBnac2?=
 =?us-ascii?Q?20d1RB9qmxiN4WJHZBsMQRjsBmPaFwfx2ycgVa8KnvFN/Na8dVacjcySdI75?=
 =?us-ascii?Q?AgvIyXFs5sSj8fWi0cBak7uIvxA7YZsDzjWR8c3wBt0zOb7yAs2P7FtwwT5W?=
 =?us-ascii?Q?h5Og8MW1w8BcqNw45nhBrGpdvISEFovYcSMzebvmurqWP89oYSBubAfTbCz3?=
 =?us-ascii?Q?I51OCA/sT/ygErIYg7o2brEluSaFeS/oE06dsTWCQxZ4hxbwgSWuVk9nIjih?=
 =?us-ascii?Q?5pKjIU7deiQVRs3O8r0VuZkTQSf6pNfCV8u0ap6sOLZREzqE25y7K1c7mF9t?=
 =?us-ascii?Q?NGyALL2+WB2osTyA87hjG6Bt5tTV0rzxDRtzwencWYSgcK5zWU0l5TbPjcZn?=
 =?us-ascii?Q?Ar0iY+Y3eNEeTmqWe/8QJDrApd2NY6T/jWij2nIAWMlzFhsyEC+Mw7rZ56gb?=
 =?us-ascii?Q?/c+tHoy0CXytkyk/sFQhJ8GaPt3rF3zYu9au1e+BQH3OqRR/3kHJllmdz55i?=
 =?us-ascii?Q?WnC2RWNTrn4AbfmICy8+JM19/b0gHAU9ZRVlUZPLUJQoTOJKwIy4wlG2FiDk?=
 =?us-ascii?Q?G6L81aO1tTTAhDtip4xjaBvyUKGH0LY5xhdE+HAE1vpq+CsLMu/Xhpvy315X?=
 =?us-ascii?Q?NAMeNa4mnn9VNJ0tVavGcz6R956QWL2iky/oHHROZh2qkA29IsWwHuZZ0ZX2?=
 =?us-ascii?Q?cKuTawGn1juB6LGPfX93JhE52ORxIV12SANiu3ZqXTDMBIUB+422fbk9QYUe?=
 =?us-ascii?Q?vwkJH1i9O+iCZxugqYNZxv7EdfKWbdY/OpN3sVYBDS0ocYTwxnF2Jrr0w9ZO?=
 =?us-ascii?Q?wJWfwuVHWu/qZWeYiTz46ydAArPM0gLqsUtCbI+JZLE4XYPEyhn5ZJi+7cP7?=
 =?us-ascii?Q?5opZcJnjH8AH8oLJJWQb/c3MVj1G1L+e0rPFtXBRHr9wVBC/04MuZhPTdT2Q?=
 =?us-ascii?Q?AaDcYGCsMHb9x1qoD/yChZlImZbOEOBZDiSs/eocZQh9/lGl85/W1sMTUNcF?=
 =?us-ascii?Q?oefd2MewLRDoRFrmshAawQF7XtzZzxzl6tma6FLPgRBECardO8apiQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oibghy7Ei0Bws1Q+oA8Wbvn1K7Ti31DA/KcWvUUlXEgM0VJqjc/V4lYRYkED?=
 =?us-ascii?Q?hO0QLkouPrbaS36n3u7YS7TdgNwZ277JOuYSOuZsNK9yAdxCDq0UZW24XXe2?=
 =?us-ascii?Q?gOa8ghR0pP2oum0erF7dB1QRCStcuGBKbKboIXZ5ToQnyO9LuLv0MdKc7nZS?=
 =?us-ascii?Q?7zZqvgEcPnf1kItztsI3qdYuZ1QROwkX1a+z03ZEYj6uzNI6h7cFM3vDb9JM?=
 =?us-ascii?Q?bL3Bgxu5OZxvjlF7pYLtGByBkG6HcXXYeXp/aPnjbbZK+7vJ+EbUdG7vZ6y/?=
 =?us-ascii?Q?L5sQPzNHx4sMA7IoQCDjyzQ4pE6hwiRJ43uTsPp81HDItRJ5evS8Ymj7H+7C?=
 =?us-ascii?Q?XueFk0GBo5GdEp2JPYyDZjMdn8RUijREq4Zsne6nEKhCjha1Fj5TUu++n5Rz?=
 =?us-ascii?Q?LqXMuUI6Vk5UH1xCqez6NUZtnR5vy6IsUM39qOJHnfZemGaGWdZLPw7U8fME?=
 =?us-ascii?Q?7tNK5ZCIq95+OzvS5ikEAfyZe+weckBDZX/K1RkqA4ib2eqioIeQSDVJPKv9?=
 =?us-ascii?Q?IMpALaM0t5a9hZxiNxMiK68MYsUML4RLl28odFrN7pl4W+Zc3dL8OByTWjoN?=
 =?us-ascii?Q?V5zLbwtc7AJxUtpqqf6ZrJkpB6Bp9+WUWBnUCbujQnZFK34DWcRV8C0uWH9u?=
 =?us-ascii?Q?eJX/COdKk6FI47f3Mjy8rW53ChRV130XhBGjo/0hq40/un7YZ6M1ajncpmlR?=
 =?us-ascii?Q?z0mfvJ4LzflOsmXY/VS1wfr6YGa0Mw0kocfG5pdnTZtJJmP1uc5Ul05QexC2?=
 =?us-ascii?Q?Rh8DC9imGTrRfNF6ujwz70aJcgtpM+wk8G67sFyCJdq64XGyulY+hv/03QvI?=
 =?us-ascii?Q?crOIYk9szJQLQHwle/xCgGYyufqLlfjUqSzU0z9GTMGmdKOzSlBwIx0Jy3Tv?=
 =?us-ascii?Q?4JsgPusu4sw7L+sVSp6WUjcP96E9ykYwYNjsQfHrDb05wcr8RRfOpFYwQrKz?=
 =?us-ascii?Q?7hErEt+QXwbhEbg5V38O2b8a9XPl/U+LxI4xfaIEmkwJ4Pby5NObeHaXTRLq?=
 =?us-ascii?Q?wKny7mwexLbqD5TpZWqqWBgpSl8MkoBx5XgWofH835sulMi0U0n/QOjq/tlv?=
 =?us-ascii?Q?Q3ABk7yIWGuBZ314eY9/0LTpAnFdy0I1R2EPAvOJSAM3LstaouN9mCzAXgU3?=
 =?us-ascii?Q?GbBx37GkLLgEO5jXUmNpUmUYQw64c2wn7YoR1nDTHZJ+O6Q3kTLhw+ECgzk0?=
 =?us-ascii?Q?JHF20vdKDICycDbfF5259GVPinK4221ldFD6hMD7+90eqfp2pjSZ/nIiWYDK?=
 =?us-ascii?Q?KYNRg69BtKWsPTWM5GNzS1rALDNmzAnnaHizkq0ongVyrUtb7vBj3pvQJzeR?=
 =?us-ascii?Q?h6JZ1uDlcNhBPfGdVYi9PickkQi8BwktzXyfocC6DS88hs7kDZ9FG+jy/kBN?=
 =?us-ascii?Q?A+tWeHpvgeTR3G6e3ultts3IeYeybTmjtoyKMeXdy2yE+LiFQ6+dv8SDHoTL?=
 =?us-ascii?Q?0FLxjZFsYNJD2WuIkHalQOUonu4hQTKdaau4GChOKWK1BHP2ESyK0hR6H2Lr?=
 =?us-ascii?Q?cyYwS3lvqXwJWXNoCMdlLzk73GQk/joiXYX35awTmJ4/t5popJUw3L1Hze/f?=
 =?us-ascii?Q?RZFt8xW9ApozYABjA94MhQeXsYC9LxEDiVurZO0xnHOLaDqNlf0enV09N5V1?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d2dd18-1bc9-41f6-f38f-08dde0fe89fd
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 22:03:20.0078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7q3z4es7did/3HEBSR0YtNVl4LmE7cxS4+nOKsOa8mF7/47QJK5yqS/m4twLS612P1CQvVEanT/KX4BZ6KI7UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7695
X-OriginatorOrg: intel.com

Sagi Shahar wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Let kvm_init_vm_address_properties() initialize vm->arch.{s_bit, tag_mask}
> similar to SEV.
> 
> TDX sets the shared bit based on the guest physical address width and
> currently supports 48 and 52 widths.
> 
> Co-developed-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Co-developed-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>  .../selftests/kvm/include/x86/tdx/tdx_util.h       | 14 ++++++++++++++
>  tools/testing/selftests/kvm/lib/x86/processor.c    | 12 ++++++++++--
>  2 files changed, 24 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> new file mode 100644
> index 000000000000..286d5e3c24b1
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef SELFTESTS_TDX_TDX_UTIL_H
> +#define SELFTESTS_TDX_TDX_UTIL_H
> +
> +#include <stdbool.h>
> +
> +#include "kvm_util.h"
> +
> +static inline bool is_tdx_vm(struct kvm_vm *vm)
> +{
> +	return vm->type == KVM_X86_TDX_VM;
> +}

NIT: Might have been better to define this in 4/19 and use it there.  But
looks like that logic is changed later on somewhere.  So...  meh.

Ira

[snip]

