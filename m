Return-Path: <linux-kselftest+bounces-6295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE9C87A5A2
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 11:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8603283215
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 10:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE7B38DF7;
	Wed, 13 Mar 2024 10:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YwLXuOHK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C88738FA3;
	Wed, 13 Mar 2024 10:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710324960; cv=fail; b=HU+ex6LTigkjgeDbWGC1UnFR4YvHebGDK+kNWu6QzP7PiJhqPLdQpAlGxYYA+cHvLSsKD8o+NTyIYgVcC3pnjOAs9ABDr0zKH0QQFtiUjsTfmZhUvE3S1HgPxB8tBvZ9hMA0RLvT/Wi83Bcif/WtikMvjtQFAolr/1DA8BLcCik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710324960; c=relaxed/simple;
	bh=AjfCj4E0OHh/GTnwAPNUdSqdUszFkzMLrLuW+qqwl0U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PorkbSOdo0YaptpS3zGY8tjHSAdg7jplSgQU7wev5adi7tTF1fQufWjzDNwrW0BvSalHSxBr2LdaQg6VErED/xkq/uuuQPWkQDdBCQcFzBNY9rRPpVspIXyE+/69/bpbSyteRxmAa6nNBY6av9TSRrNtOmUp1mi9gzQETIUex60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YwLXuOHK; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710324959; x=1741860959;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=AjfCj4E0OHh/GTnwAPNUdSqdUszFkzMLrLuW+qqwl0U=;
  b=YwLXuOHK3HEXlmYgddFSbmK3uXt/wEeDddtNWgGExSO+SNGZyMkPsg5C
   TlWn7BAUkqnn6nctH9JJGAfcxRD+r3Ft1ONrsHEXQvYvoPDXhYpsN12nY
   ES5bVTRNsvI9bG5tjdjr5FmzbjU533EId2UNnRdOynF8TekUWEf0GIPvz
   Mu0V2U9ZMBTnd8AQBSkRBbWRfNt3P12YEc13Vt+QHPjSC/anQaGelgfcy
   AZUCcYjyvsJ1nbc6w6ki1v5XuNiyITpEvvHjHT1AHFVg08Ln8p456khaT
   2h9lBJ21sKADuWUwa+xpL1L5wicSbNpu1+sa01SKxS8joSiYE3lzA+oVw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5204148"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="5204148"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 03:15:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="12293075"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2024 03:15:58 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 03:15:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Mar 2024 03:15:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 03:15:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWacqJpxnIpsbpjAwFqaZgCOzQz/MqrM5yXF4ArMbzzT76o5jyMJCZzXzK26uVZOIyqmmmGDOzU4hDhola8kiiFfk5bXsL6oVvY1s5cHHBrt5H8mA2VLGsbAhl5Ire6Xt7K3VftvyJaOhgvsc0nH4c12/jmEAGdJ2Z3B7scoZw8c806W23ecULbZLJqTPxV7QLC3NonaxwgvhFMwscScqT/d3lbUMeL3OsJNPG4LnaryCzS9mvxXhgeD9hYwJRjtyNDB84UMPzw2ssk0nf5eAU/YAxRwoPz0RWk9PsMJ0lnyyFh9jc1CWW/QmR9s/+b0UTx7lpIJUHvFZT2h+vUOGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/NI4nLHI+YITo39RYzXA3ivSdfsEZJpqHBWf4RKvlQ=;
 b=WMJ2JioZww1fv3eApCqQPORWVRbq11yst0dqMymiLaE8dd3gwWl9ajei3+lUlv3Pd3mgCedjZDHVZzV6hGN5sxOSp3k4pbstRrammxXOY4j09h+bGffM0vOGLX/NyZ+UtAr1/ywcqlhNuBYxRH5BrcHZsnoZTLtgjHNXvDndyNhIWYHPZ/XPLPtbpEveost2yYyvEbx9iZlhebF3XzgfeXu8LzhCld1176ni2W5YmrhwGAEMqRiDgHaqbmwq+c6nG/6LjJXTV+b/oA29sDtssGBX+tXaQVrUgLvJ9fUYFsGbMaiOqBfr2DkmpK+FosQJoyz5t66AZcg+v7sfInVVbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by DM4PR11MB6405.namprd11.prod.outlook.com (2603:10b6:8:b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Wed, 13 Mar
 2024 10:15:41 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7%5]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 10:15:41 +0000
Date: Wed, 13 Mar 2024 11:15:30 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-kselftest@vger.kernel.org>, Reinette Chatre
	<reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, Fenghua Yu <fenghua.yu@intel.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/13] selftests/resctrl: Add ->init() callback into
 resctrl_val_param
Message-ID: <zxrd5yzgtbet3d42c77ifgu5t2guyhwbz76zhk7zhrp6hnamrb@pl72dxisxax6>
References: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com>
 <20240311135230.7007-9-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240311135230.7007-9-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: ZR0P278CA0035.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::22) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|DM4PR11MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ce51d96-9354-45a1-55b2-08dc4346893e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /K5Ltop050j0k6rZsQZQylna0Ogf4w0uqJt2K7pmjRZyiKGY6qIKAMTsEDdFX6WdtN3L0M+zi8yL/OiWUoRkhLQhCj7YRWiZVCzPwq9O84o2HI3+DrEYfDEgebr0eRwzo01YM0ZtwMnlxnpGrDDBbVtKy9tMJn81UyG6q26jwiNdERJulj8QyRSHhGG2jmTOfO2pgCtAaH0hb6h4D8HDyaGEaGnahe23AkE2bP8bg0q1sTBWSkEkNRPUS90juQ+FVyzpl1Ue6HZOWJGifrsBDdlakf2T4RRCyqd17TVdL0A3raqLCAXCZ6F8abEMWkopg12ErZ+4IvfwxpgJhhXe9Ab2bAdxJB7t5Nu4ElJyEUxOQ0oSSQIV8TPzomrAcVJKV7Mt9s2LyhuFcsGgNWXIM+Y2I3RbJR0o2PZE0s03iCIF1mR5HrMaDkh6+QX5tNmd5Xft/Hs3aKUfaR4xF/a59ZqjtC7ujcbpuo/TZkp924ISQFTuhE5Mc8MuiE018WUjBm607JzloOaZV69gCgVyHXpZ43T7YmCpHOn0jUKtyv/cYFKAkYWLTT+PVSNVWTOWH+ddFOMd/MJuyL7hFjWfZ702T1PR7fxPlOVzTlGpfa50w7oAfAhqSGUejvm5yt+wUmHkB5ONhnK8Fjv/YIYaZjQau1bK+gQ+zaOhyaBaQ/w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?uIwNe/V/wiYRLKCJBgphlQACX9kWMP/sEH8Bt/2yJPzQa8/Jw4ze2lQJDq?=
 =?iso-8859-1?Q?ZLQMMp0+f6E/tN7P0ciKxeVH60g0xvzhGMwrOuQC2fms6Gppd0juDN2Q3t?=
 =?iso-8859-1?Q?LJti0sl7FLsNEpNAyu87ifNyv1RQrMEOLGfRONMdDAI3lCU6EEfLNc9DFZ?=
 =?iso-8859-1?Q?h8O8eEUcVHdN8exvV9Flt4wnw9j7f2l7RpT8unO15DpGxXYOQ2d3T47DYO?=
 =?iso-8859-1?Q?23O4flP0wGmuSHFIoCdO0M38BgqEc0W6lK/cbEDeh90PgNVurLMWw6hkqX?=
 =?iso-8859-1?Q?ivye/BQLvaR18wAi/ouiI2Wa+LUiHEjxbvyLvws1ZUcjLc1nrBldZZoRwO?=
 =?iso-8859-1?Q?JCgH0c7CPS9zZOcMQVHJLfDRC7mHGxEwkaU5OK9v9il1fNWKolUIN2wyBw?=
 =?iso-8859-1?Q?sn+tVrF7gvemIiZfwmOUaOoLrbaL38/JXmsTUzCwi/M5zICMn/FSnDO4kK?=
 =?iso-8859-1?Q?bu4bnR0jWhW0VQ5Wc+s4YloSW90AV25SnH0eKf9//h5YS4+3NtE/ArHo/K?=
 =?iso-8859-1?Q?pkXwL+cg6xfXfmqlGYoBkZYWxu+08OthaXzj+FxlMPm6uHQiNyPvXVXVyZ?=
 =?iso-8859-1?Q?0rf6dWIkG1VJ/IqayrOMDXBdPY6WfPDQgZ3BI29VyLXrH2uVpuXejf6ETC?=
 =?iso-8859-1?Q?jHcz7QlX8FFsfwy3DZWASkaX3eJy82Y1X0wXqT5OB6U5eRaTMJwIhExeIu?=
 =?iso-8859-1?Q?ihGfuT2RSXwJzd96U4EtQPzga9bz/gqvn7E522SWca5P5Kc0Ly4xsTa9TF?=
 =?iso-8859-1?Q?vUsscQHts3aXApnyodUHJndg7/1p8WNPdKHX5ovbz+ycCkmMdanX3LLsQ9?=
 =?iso-8859-1?Q?UXMK/y0x+RcF2I5xaOStc0BVmZIb8dRY7M1Glb2iRtjBWGYpjYyaGGSiJE?=
 =?iso-8859-1?Q?tLIdsIy9u6KOFXZfDoNTL4FsbJAXe9I1ElDKJ3rkqgQjX0o4HNYW1zA8RM?=
 =?iso-8859-1?Q?ynvvSfjAP/v65sNekKpyiVXxRgG1NdhTUuENg2sO49ONtMjoNjGIPwSFLr?=
 =?iso-8859-1?Q?R3Ca723gPnscBu2uDV6MVs3t+xpmpNb6BuNJfLHf076BsvaEropp88TbCh?=
 =?iso-8859-1?Q?Y0pSpg82lJHzlOAuUE/84hWSgszEgK82VXUlczP0dZIkJTONl/+/VoI+tN?=
 =?iso-8859-1?Q?717c19ith+mJIMIGSQ3+WxiSj/L6CZafU+CYVApuULKJ07qLRworW2gIhf?=
 =?iso-8859-1?Q?664mVYoaxj2NK/liWXOzbjrqUkaj6sfvJ34njaWfmeg/3cv1f0wMi0J/ov?=
 =?iso-8859-1?Q?KkFZJgk/8pSLcEM97GD3neM0atIUE6fpEn1HhkMb4Wh6WPr6xGjwO4gqqY?=
 =?iso-8859-1?Q?heLa8SXEUqqcmru9Z+zpACfEh0gQc5IL2+xHnxWO84VTzQHWnuL9qbCdCM?=
 =?iso-8859-1?Q?BOZuz6GZUg/CyEanIrhSe9yZxlcslSovsgMRv/vLi8X9ChK/S6nWOe56Ua?=
 =?iso-8859-1?Q?pMxNYCFddDurM3SKndxGXLpKGyAEyTE/HC8P4qIINAtPJ1a74kFjXkdYi8?=
 =?iso-8859-1?Q?mQk65D6YAa7mFGiY8G1n8QEGDpH8xtJmtgn27XoZAQgXFflew3H+KZ0yjC?=
 =?iso-8859-1?Q?WCLaOEj4ot+ZQUMgMFkNswzXbpShKQpsAe9eD1YZkyN/ZUSxLIO7T2m1Az?=
 =?iso-8859-1?Q?t+V8bgOTYN017fLrEh014wQv+u1qeWH/04CB3ZD4qnN+nxwNX0h9s1AzRh?=
 =?iso-8859-1?Q?mo9N4DP3mvGKHHAQcZY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce51d96-9354-45a1-55b2-08dc4346893e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 10:15:41.0551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lc+ma8lIHSgshUNgi1W06I9NSz9WW9+MMjpzb6JAmj8gInZrEOSbe6pdMHW8D+onjhrf0E4offvDwFgXFkZ/wO6XiLo3pFcLf2Bw37brkS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6405
X-OriginatorOrg: intel.com

Hi,

On 2024-03-11 at 15:52:25 +0200, Ilpo Järvinen wrote:
>diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
>index 241c0b129b58..e79eca9346f3 100644
>--- a/tools/testing/selftests/resctrl/cmt_test.c
>+++ b/tools/testing/selftests/resctrl/cmt_test.c
>@@ -16,6 +16,17 @@
> #define MAX_DIFF		2000000
> #define MAX_DIFF_PERCENT	15
> 
>+#define CON_MON_LCC_OCCUP_PATH		\
>+	"%s/%s/mon_groups/%s/mon_data/mon_L3_%02d/llc_occupancy"
>+
>+static int set_cmt_path(const struct resctrl_val_param *param, int domain_id)
>+{
>+	sprintf(llc_occup_path,	CON_MON_LCC_OCCUP_PATH,	RESCTRL_PATH,
>+		param->ctrlgrp, param->mongrp, domain_id);
>+
>+	return 0;
>+}
>+

Is there an option to make this function (and the set_mbm_path()) global through
the resctrl.h?

I'd like to use it in my SNC series [1] for looping over different nodes and
that requires changing the paths during the measure phase of the tests and that
part is currently in cache.c:measure_llc_resctrl().

Or would you suggest some other way of changing these paths in cache?

-- 
Kind regards
Maciej Wieczór-Retman

