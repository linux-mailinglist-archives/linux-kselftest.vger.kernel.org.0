Return-Path: <linux-kselftest+bounces-12190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B8590E101
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 02:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A989D283FC5
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 00:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9364A19;
	Wed, 19 Jun 2024 00:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KeRhmTWf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D4E17F6;
	Wed, 19 Jun 2024 00:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718758374; cv=fail; b=ECbH4ccacNSGj7dxryo6Ndf/gK1tDNt5Nvg83Knn4DujTEnKVguw6zfdWW3BPa+aLjr93WmsNW/V5631eDbTclRzxs3lcbTFehRaHbCQTrUy+rVfrsAtRmPp8RHqquL5TPlj/+d+JeKFQJRaRIL0TbKuReVg5p6bR9PsEdewB24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718758374; c=relaxed/simple;
	bh=I5qvvTCOYf4wGZJsxU2Va4wddb6R1AyxHCrT6nGN8oI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q4uE0SIvE5p6V8MeCFBa3HGix1Jku3KqV3Rt2Bd7G5BmCW5Yoo2Ki+w8VSz9aXG+TZ45biSx13i0ogtqeliJ9xSFnYnagq0VSpT7s7vegJSkiFIZtyLTF+MCuB2Lg+h6wMSIhuzrRC/xAfulAKjMsf2VrPPO4v+Fek3D7JKJZkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KeRhmTWf; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718758372; x=1750294372;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=I5qvvTCOYf4wGZJsxU2Va4wddb6R1AyxHCrT6nGN8oI=;
  b=KeRhmTWf6mOCiMG3j4Vl6cKKMNj6mew13vm3E8esIYQqGq768cQnIPTC
   pkAIUkvoSPKrAIG7jeWv8kBB4RstFyOPhYi1FnUWWMapYEtqq4Er6RSfe
   ddnxC5B97AFxHhXbmwOyPAST0ezbLdtBDfE0JS7nZYQpbZ52H5Yp8C+40
   IzWcq4LdNaPfxhpjyR/clRfLCexxbpKj9gIu5Pxr8cWCia0dvXpxJJD7t
   1jmf0LcTB4jTuYGqfCen0QqnotNlB/a/71XbLibr5UOX5wdz2HKn0X+4i
   kffCOyN7sEUjRJI8sHpPRNzWM6Z0MEHBA7t5xylQLaSsmnrg2jDAfj8I9
   Q==;
X-CSE-ConnectionGUID: 258H+JnMSX62VKvx0NK+8w==
X-CSE-MsgGUID: rtbimmAwQwSse5hYNJ6Kqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="33142349"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="33142349"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 17:52:52 -0700
X-CSE-ConnectionGUID: rkIi/qaSTtGAuaMqyrFjvg==
X-CSE-MsgGUID: WJxCd0BEQhWdvkiE/flURQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="72489230"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jun 2024 17:52:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 17:52:51 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 17:52:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 18 Jun 2024 17:52:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Jun 2024 17:52:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMysxe6MRvSJLZcaMc/2XiPACgFyxoJKR+ZOGwh2pFVN4LOE7HUrj56pLW6CaZJqGbAulH4LI4I/Xq4FGSeXtJBbUWwVBq5ic7cEHrYYwXL6ahDWS63Muq9Z1re0ul1wXbObv+CgnczP/6y112bRWHB4JG8N5oPXhFIjSPCwLVjFDHRs3yBEmayLgyWzQlj7C7n8D6z6vrgZ9KyC0rc0hqNaz3eXS9rJwvTUqMSo4sNKEVo0ddLZmWCwgJMT8q9DPCdJe+/fKFjaUCBFEF++HNRe69oBVao2OtLG+2PgxsHAa7PWartci/l0mZYwrT3mUfuqItWWs+1MKyub7folAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5NAank1uZdaunLQg3nZaex/TezPU/+7j5xXo/Rf3gU=;
 b=BmND04FltdNL2hojrd0CAMZj8pwJemY0zaOcuyhrfdsTmCTErYvst44NJ2BhX/0BB487VOY/mskgshbrzL73WC7WHMSrogcWlf9fydPY+QC//9KGhGsljicAkOAXDatjML+jxvFew4TkVyHs8sQ/2QJr4bchfkKCUKQHqqzRlr50iFfwLbKIvoqHrt94ahQnT4Rsbk71CnDjEggCfjt8h/VGeYfDTFDOlrHHUk/udExuOb1AO6GTL63bBL9HxNN0ufMM/BiPJNEtGRnZIMYntlxBRhJFLXCpswV595eSjRciLe33nEPTCmqpBNTd0tPyWWFNl9Qgn0tSTUacycfh6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6)
 by PH7PR11MB7570.namprd11.prod.outlook.com (2603:10b6:510:27a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 00:52:48 +0000
Received: from SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::b3b:d200:42be:fe4c]) by SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::b3b:d200:42be:fe4c%6]) with mapi id 15.20.7677.026; Wed, 19 Jun 2024
 00:52:48 +0000
Date: Wed, 19 Jun 2024 08:53:15 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Shuah Khan <skhan@linuxfoundation.org>, <shuah@kernel.org>,
	linux-kselftest <linux-kselftest@vger.kernel.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, <jithu.joseph@intel.com>,
	<ashok.raj@intel.com>, <sathyanarayanan.kuppuswamy@intel.com>
Subject: Re: [PATCH v2 0/4] add tests to verify IFS (In Field Scan) driver
 functionality
Message-ID: <ZnIr+4kB2wxMG+FP@xpf.sh.intel.com>
References: <cover.1717137348.git.pengfei.xu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1717137348.git.pengfei.xu@intel.com>
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To SA2PR11MB4844.namprd11.prod.outlook.com
 (2603:10b6:806:f9::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR11MB4844:EE_|PH7PR11MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: b79cbc02-2fea-44b0-a165-08dc8ffa23b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7xGa77JAndZ8OhL/qZTpVmE+xiK2DT6RgBAyteR5yxF5CgnDmBqwd+ocJfvT?=
 =?us-ascii?Q?892cdiUd5MmsXgyzUGZiVE10UvPQ430SVmSsXQy/7obrJtfx3fn8M9f3YK9+?=
 =?us-ascii?Q?FRDR9u8KfI3OMglBQI+JroQp4sFTZvGvQCLY1wjar7pqijNteZ+B7eDuOn+Y?=
 =?us-ascii?Q?O7dN3IdrOCzr2hxTfJP38bm+CNsy1zf+pgNNkQo8oBJob9eonovMCHUdHUpM?=
 =?us-ascii?Q?3afKUZuRcZ0x4qFpy2cniVlYLU8pfgFMSqYpvbUO3yy7FTgoZv/hIvJBP1lj?=
 =?us-ascii?Q?whCefB7+9UH+h5CVzGVawHKMOSD72PjBpmeLJp1932Gz3ckyTfWSmGNguaii?=
 =?us-ascii?Q?xfSi7Pe0MYVUA3j/QnqOWNKL5i28xkeqDP3brrQM/dwuIWh3M6f4YgE4nnOF?=
 =?us-ascii?Q?vuYJW6A1F6QFGKiIakUAlldbklj8o2zKy7FDPUx35CywYdqIus+Uk1txQZnB?=
 =?us-ascii?Q?/RgkZJ/gxr+PkLKh9WlaElb6O25gzTLRTMRIZhJ0X35Hb4TpsAW8+aiU9vg0?=
 =?us-ascii?Q?qlvuxPx5/jtHtEAyp60xMSGC8FawVLkWOcVy9DZz4U2e+29KBSLT8QHVTJp5?=
 =?us-ascii?Q?qtqi2h8td+jyz89MNZn19MmXvZ4FaZLdBEBzrLH8ZCr7COoH4Au49xs0bWRs?=
 =?us-ascii?Q?ZYVFgVpmXXh0au9nzGqWY1eDkT25QoYnsT00X2Zn85xEaXqykWItEt4548IO?=
 =?us-ascii?Q?nGhISaEAcQROH7ioZ5fI9dbAJvX94p0OMV2HG6RWsUgZ/YwlvqYQhYkLP2Jl?=
 =?us-ascii?Q?TECmeG7QPS0iGIQ/UV6YiNWVF+uI7Y2JxMsSxoUHZeSosZZo4aMjI98xfB4M?=
 =?us-ascii?Q?4LtkS/C0J2hdRgcmYpoVNrxiw+3tiP/Hsfl7CjzVxrhfIpq81jbiCh2lRa99?=
 =?us-ascii?Q?C2+UbvWFo2JKHuSE5D3f6ylrofFHU6dY2eR/8WDcnZOVO+MNeXtwRMfSS7uA?=
 =?us-ascii?Q?ZCLLFJ5vE4lfkJ2f094q4tU2TXG3ATEefPBo8CNaIksYsxMuGq8nON4HZtxT?=
 =?us-ascii?Q?tqlRMECyVVJ2PDERVdq286pKs00BwTMrIs6XtDW0rMrnXJJ2RNQEGHkmAgpn?=
 =?us-ascii?Q?U7axaMfYNfdN8MsXljjm8P/ww2UyXgFEI2hCsQ81CLtIH5iFDfrbVtxpjON4?=
 =?us-ascii?Q?bx8KNPJH71J2aRnaSvmqqpoC+GFtIXH2mnoM58kro6AIbnoKqsHz5pJ36dyb?=
 =?us-ascii?Q?vxRAKmkwfOxFD5ZIi+UBingk7Pw0GMI1sCDTWODjWOzQO7urNoosTv9vZCLN?=
 =?us-ascii?Q?7WByFXM/O50KGVbjjmJb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4844.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QGBGnJ+Ep2CrCn6hftblP/m6/9RctTS/708LoxjyUeIt+fSPopL76OEgqGMX?=
 =?us-ascii?Q?/n/w/u91huBIJl2RNXkkQx0pTo0sToDALGlhqJHFSbFXdr1J8n+pAdrpsT7c?=
 =?us-ascii?Q?D1aJzKbdPtjNqvz1PPrLkIsI4jHTLsG7Th/oiIYck+uIqp1UdI64qE9zYPU+?=
 =?us-ascii?Q?INMClNn8UB1DhbHlglZBP93m6mndgUwR+PIIcNNyQq5E5KqEa+S2DDKr9lo5?=
 =?us-ascii?Q?f9h6QJzk0tPTZUsWxYk2HKUV+2n3w9e/LIfOBNzTiUHgTHDECVhytazwZT2X?=
 =?us-ascii?Q?psOyPG93jA4yZneCL+bfuMu05FgpmkVdLvSjPjOu7ncc3NI/NpwuRuqJAChM?=
 =?us-ascii?Q?A4LIUa9vCcneIwGQg33rNwmJrYyDWSllz9cQxszwYkH7TmgI6JB0afhT8+ey?=
 =?us-ascii?Q?snbx0Jg/kpmU2AjHemu33opQKZ7YuW62bAJmP6EkmkwzwYTKfRRCvL0NvLYv?=
 =?us-ascii?Q?pyWimR9xlABkTq9dbVWTITCcEe0YH9Qgz8CSW/0JgWCCwxlht8Nb+yGDMLEo?=
 =?us-ascii?Q?pnkD9Hk/LZf7Asngb76F/nicIqSOyqspZl/Z270bB6knOEb3vzBoGAB/38Yl?=
 =?us-ascii?Q?TfXa91Vjx6ejDYDPM3Po2OWAytLOqvHYiPc6ddXe0zGV9PutwGmie6MjwFDe?=
 =?us-ascii?Q?ZX6IzcTArX435zLyFBafNioImQaxBRHzCRsxYqEvhWic6fXvk2Xl8YwwwhdQ?=
 =?us-ascii?Q?yxO04kpsiBOMgIT69oUWMbkgYelICmn2Dnjzta2mZF37dnBjpYmk7lBQe9MD?=
 =?us-ascii?Q?TqKLsaEshZ4fQwmvR9z3qh+rekke2r1pzGo696DGJf+8Dmkk5HanPTOnPDWb?=
 =?us-ascii?Q?vJg5C+oYOJ1X+CV1H0W6I2JW5huS/ri/hZ3BvKXxLzYa3bY4EuW+I/zbaG7H?=
 =?us-ascii?Q?WgyIARWPZwA6VxSvYdHqEsj9eqEuHQZLjsTIi8FUkB/tsKKQbjQy8BAVIhIt?=
 =?us-ascii?Q?YFn+oHMlYwhWQLIxfP7VKWnz342+Aa+S5s/JRqrDNO4KF1qPyBJ3suerC1QA?=
 =?us-ascii?Q?qcg4l5pxHqUYhYE239UJDOdyfjLHOrw0SvtvJ4F8/wyD/yvuBh7A8eV9fMe5?=
 =?us-ascii?Q?LvhkfQPbVR5GvXwUNEHcMXbIZsxcrh7L8IP8LgZ5qaeo9XsMnK63yiOcgXOr?=
 =?us-ascii?Q?3A91tuFFpL1Uh7vd/9+t3lHFC3AKsZpN9MX5CenFL70M7om/IyK7t7VgAwcN?=
 =?us-ascii?Q?/93WlQCRG3PQbp6JiuGrQWSyKtzW3/4eCsUwR2JJI1CPs+tM2aoVlEORoIx+?=
 =?us-ascii?Q?R4ymSiUb2PtzK95gY5DniD937Wv7U2GcscgfaBSKgwZ/ymtgaFV9ZGkJx+/M?=
 =?us-ascii?Q?lTTABTBOUzXH710A1z+pkWIyrJBvg7npdUaGe/F47Hv7vUN9qZ/n42PT9BaK?=
 =?us-ascii?Q?/cLdl+yDzjTWnFzropcTIsT32F/VBGWVMW6quSjja1facDuSsDaGbMX7Yf5+?=
 =?us-ascii?Q?3P8qZ7hMmpY97PM7luLL3AqfyHHwKWeT/vvCOdXyGKGTgC+6Q6Mw93tq5RxT?=
 =?us-ascii?Q?jt635xmekzYe+hNFyaJPgaQJxHiQ3T75D8Wla+cU9d++hOQ0WlM+rmZRqRA6?=
 =?us-ascii?Q?kdlrLfHwteOhU6ouS6ecQme67uHs2zwXw394Eo/J?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b79cbc02-2fea-44b0-a165-08dc8ffa23b0
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4844.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 00:52:48.4023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sVoJuSDjH/kFe1/D5e+29jUt9KFHoR+BE/nPBBg68kGibFB82evooWKz+Zg/01HV+nMkTwaYfLWdOjCFDC1SsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7570
X-OriginatorOrg: intel.com

On 2024-05-31 at 15:53:46 +0800, Pengfei Xu wrote:
> To verify IFS (In Field Scan [1]) driver functionality, add the following 6
> test cases:
>   1. Verify that IFS sysfs entries are created after loading the IFS module
>   2. Check if loading an invalid IFS test image fails and loading a valid
>      one succeeds
>   3. Perform IFS scan test on each CPU using all the available image files
>   4. Perform IFS scan with first test image file on a random CPU for 3
>      rounds
>   5. Perform IFS ARRAY BIST(Board Integrated System Test) test on each CPU
>   6. Perform IFS ARRAY BIST test on a random CPU for 3 rounds
> 
> These are not exhaustive, but some minimal test runs to check various
> parts of the driver. Some negative tests are also included.
> 
> [1] https://docs.kernel.org/arch/x86/ifs.html
> 
> Pengfei Xu (4):
>   selftests: ifs: verify test interfaces are created by the driver
>   selftests: ifs: verify test image loading functionality
>   selftests: ifs: verify IFS scan test functionality
>   selftests: ifs: verify IFS ARRAY BIST functionality
> 
>  MAINTAINERS                                   |   1 +
>  tools/testing/selftests/Makefile              |   1 +
>  .../drivers/platform/x86/intel/ifs/Makefile   |   6 +
>  .../platform/x86/intel/ifs/test_ifs.sh        | 494 ++++++++++++++++++
>  4 files changed, 502 insertions(+)
>  create mode 100644 tools/testing/selftests/drivers/platform/x86/intel/ifs/Makefile
>  create mode 100755 tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh
> 
> ---
> Changes:
> v1 to v2:
>   - Rebase to v6.10 cycle kernel and resolve some code conflicts
>   - Improved checking of IFS ARRAY_BIST support by leveraging sysfs entry
>     methods (suggested by Ashok)
> 

A gentle ping on this patch :)

Best Regards,
Thanks!

> -- 
> 2.43.0
> 

