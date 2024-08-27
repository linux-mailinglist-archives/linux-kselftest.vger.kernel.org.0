Return-Path: <linux-kselftest+bounces-16394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A99960A8B
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 14:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B57071C226C5
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 12:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFB91BDA87;
	Tue, 27 Aug 2024 12:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PhVVvuAn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22A11BA270;
	Tue, 27 Aug 2024 12:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762058; cv=fail; b=WDTeRtZWB8LG5UI9qXAKJVi3pUkq6mk/28xQ1XoawUFtK1zORKhql99OJJrr3U/1QqedTg9R6enQ2ZecKcHK0w1H6xv2HRPFwG4TdA7r+qtWe4doWTsvMjjcF0b4bnQZwd1kPShpMQJRFYHxVI+zUHuGzzeL3JOOWH8UfJ/F+T4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762058; c=relaxed/simple;
	bh=5W6QSWeHH5bR+CryRFczSkodcx23xhQa0CcmC7V2dGI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xsti8z/pTWVcYukpghHRBzxPjRUp+qghWx+WXLDBxYWpnb6/RnNAXNX6RJ+soASXCVTxQUXdgWDA0yj3oP0sV214gZhmZ4c6zlc+m6kUJtf/Jf5koy/OosprmgVq1gUeSFPI51I3qy3/n4pTmOpaAsAoMjlIuot0cMhL+hTgxYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PhVVvuAn; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724762057; x=1756298057;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=5W6QSWeHH5bR+CryRFczSkodcx23xhQa0CcmC7V2dGI=;
  b=PhVVvuAneUtGHahz/KbO/pwHK92VJIC9vHhna/8YJmla17VvaIF+8OjS
   DCKQFI3CClKwIJiLhInBZc9bsK2AAIYV2XF5qexAOoUW5nb0aVFxCEyid
   lMr7mG9MF+MUHLjvpQhV4AKyYrGg7qoIGHgDzSJtvGU1nVO0T+VdUfu9X
   EVF83MQP6NvD3kt5kux6I5y4Hd2tAEibkZIBfRAL7Ek2QQKfJcwam0Nb+
   rswp8FUamLsozZUdLBHP2CGaI6nTZl7HGgFMxyEzFxR5Kpqde1x/M2ub+
   6xdI831uRw7hvESSjnCxNwELZpZJ3Aha3VQX9kPTxQxIsf4QfV1e2KfA3
   g==;
X-CSE-ConnectionGUID: nr1VJaFLT+mXjh2qV/SRow==
X-CSE-MsgGUID: 8ikPFed9TaClweTUzSCQ+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="48621452"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="48621452"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 05:34:16 -0700
X-CSE-ConnectionGUID: TKzBKcltQca+UxNwGyvwgg==
X-CSE-MsgGUID: HR4Wvn1UQKOs0IMi2sQ3jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="67548012"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 05:34:17 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 05:34:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 05:34:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 05:34:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBk0SHZef1/qTUCJRoaG8TZgSbj+P5cSy36cG20jQ7v2zaU7cVKrmkr4R9uH5aAQ2khQwSX6zCVTrlALQAkOMOG3FiCkNXKA0OxPxgKCeq+tfqvjC7UQdaVwv31oItgAQEQAbpN0Ok8arKU9XG1V2QeaAOkkcgO8vRIfE9edm+oViD8QblUYClYt916qCS3jhoxll2o1mh5EXyaPQyJQ1yAGlaAyxZiBVUHb0UgBVfYeZbBttErl+5QoAR+xEbae6/Gm3JDQghgDEK3yFidWNn6nCn922bQdxDRBfRexcg3aJ+O2rAnfuUJDeY0VyAGlc5TYDxeMBDHnWNCceUX13A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qubY51iRb+kTkIva6jEbMSUxfhBC+z+N3K5pE+TX80E=;
 b=wlLy/wnpfl9W0mfy5PhliuLa/cXN6bBlK+cLsGcC9QIme1nAO8KFxdMg6Ov6k0Gtm9jZDvaOaDIhGtOUsoNBDm/Pc3CbFZ+PTr3SpD1IwhLxp7+RY+JC1H8uQKsPXnpIT9r6cbUTefHs5J3CaQUJNruNM2IGZfLu6Z/gDoydjzGDa5nnViwO1QHc31RK8KqZ2Tu0O36guCmJDluN2PpydOVCJZy2Ntjpj48nGkZCj7a0HnyWhcU3vTM04hho4Zd1ApZafQgxeUEoZRLkffXmLdgA2coa6h83WZ0g4C3HqpwjHs1WFISnri+crOkoPTgQZtVTwB3MhdJJWyq1IHy42g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by CO1PR11MB5025.namprd11.prod.outlook.com (2603:10b6:303:9e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 12:34:13 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%5]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 12:34:13 +0000
Date: Tue, 27 Aug 2024 20:34:03 +0800
From: kernel test robot <lkp@intel.com>
To: Yan Zhen <yanzhen@vivo.com>, <shuah@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <opensource.kernel@vivo.com>, Yan Zhen
	<yanzhen@vivo.com>
Subject: Re: [PATCH v1] selftests:tdx:Use min macro
Message-ID: <Zs3Hu6pBPWBEdiUF@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240822044630.1267500-1-yanzhen@vivo.com>
X-ClientProxiedBy: SG2PR04CA0153.apcprd04.prod.outlook.com (2603:1096:4::15)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|CO1PR11MB5025:EE_
X-MS-Office365-Filtering-Correlation-Id: 81bae2c1-8101-49df-c820-08dcc6948e8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VQzNOGDN5Q54khylh8vXHIMYyt2UE5RXHqD3Y2rzWn0jnF5Wb0H9YyjnRPDg?=
 =?us-ascii?Q?BVJofVj6yyYWAneVeIJTUQJcLMVmitQiaiIzU4MjG8+IZykq9Kvd9/gYvYg+?=
 =?us-ascii?Q?LpsWRVGoHg6CxDHVJzC3CyyLOULaYgFHY+Us0RGdD7gLYtR9ZOht9+m7GJoN?=
 =?us-ascii?Q?wJIP8o80ULcKCQsideI7k/0H1HcMCzds6DkFDLb+VTvw4eahhOV0ouQN3dHL?=
 =?us-ascii?Q?8Laip6/Kw597fh7XxQH8KXD+x779Dpod1g47bc2VYJYWsOX66g850bnKOzil?=
 =?us-ascii?Q?Z7Ddrd/AFj5PWXH/iQw4GHmjOYF+LPCTVVhfu74feZ4Kq00Mhl3RjNM2Ace9?=
 =?us-ascii?Q?jjyCHfhkD0nduV4dt2RxayrGrn4hVdLJQphU0c3AZLcvqxh+C+8bWMHYuXwz?=
 =?us-ascii?Q?qj13/X9ed7Ci53qiU015Ox4G9dyrH7UOpYegxaJ9cqVGyBZCWhePaDmWc8XM?=
 =?us-ascii?Q?+EsVcHI63xVjnYYnR/FRefvHfZvos3LQo9/+chWoortbK7+ouHBoRFK4XpEo?=
 =?us-ascii?Q?kQjqGj24r04GJPPODjczb+nICui/2mEkbqHP0NQXOM6fChFdsS4jV2Jc2Wk+?=
 =?us-ascii?Q?RduJ3y+liSbQhc+AGAfVEaVSZPBs5wrM6fQvCAYuaCkK09+yBZ7yfLVzIhA9?=
 =?us-ascii?Q?5YcaJlVWATdbhlcHF+jOgIAlB4qRu48tTnPPIeKeizY+pa8P+tUFfIChKewZ?=
 =?us-ascii?Q?Bmzh4E9JzJLRTyhmdnSXCnEXxRG+NxkLeKl5y41Gw3inhUksD/ca9S5oKQHt?=
 =?us-ascii?Q?6HApr1ykW3Xl6ZP5YPR7czLCM2ZU8MCiW6Okm/OTkytUHj9RTmGxC5F7/IvH?=
 =?us-ascii?Q?HKr4M6j1ydrMpbVkdKrIvPdlirdnu1RQHivppVB2nOn8VocH012WkXrKLhPi?=
 =?us-ascii?Q?mD0rq6XPeUDRlhxocBqPCPzS5E3/5CEU1U2vvu2vrApukyB+H5gAIh3CLiKj?=
 =?us-ascii?Q?IusQmrHc2lc1lUm5zK/gY6IBPmHk8rPGnCxPrw5FGtSOvFxxkk5UBYIMFdcr?=
 =?us-ascii?Q?QFkDHTOAvFuFHQYsdeeOt6dS2hdwnZ3XbNfHfFWy+hl/FxGO/iPvaDdaVwOp?=
 =?us-ascii?Q?6GAAkgn3V2P1btBX7bBXx2Ei0nxtrwpBc2RTMW1E1P7aQmrgunbqAWOte4m2?=
 =?us-ascii?Q?5sZDqg9xxywRKH8UZ45KS5hXiAXDvxNYSFU9J7C0uZIqCuAhbCilv6oqYKnN?=
 =?us-ascii?Q?EJ9yKpRx8mFYUmjSuk0wz95AOYeJby6AAZAul0GBUQn9Zft/vq/TGpDYXayj?=
 =?us-ascii?Q?+qzf7XgLYyTsJ0pxt9WNEtUrFAUpYjATe5+60uQNPlG5LanK1thHXLtbRIqk?=
 =?us-ascii?Q?hl4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pIsfws7BXS9SUMpTgAEU3AWPtBbuBKkFGBwDIlqQ3xuS4rPod+BGEi7dbXqE?=
 =?us-ascii?Q?AAq5H409aoxR/NPfL02rBrr78qxDLvK1cM1K4+e/k6nFD7B4nM7GlRdDRIa5?=
 =?us-ascii?Q?Krh8k0l8KXsrmY02scCZE3evyLhOnNQ3fcJuBUtuhqQbeqb2SuU89bBz/Z/E?=
 =?us-ascii?Q?ma8un/y3HPEY77KhyZWuMrB0wrLOB/0IqyQxglDaIE43gm2aTrbyKtKEztgk?=
 =?us-ascii?Q?BIo6NE5w+5dyaD7QwiZQ77Q3EED3Ld7pqfc7dTt/eDL2m68ya6VddQVQ5MMG?=
 =?us-ascii?Q?FuIgwhqs1ySOJwdkZUzWkB/x9NNkzdbRWucK4hjkLuSAlDdf+uZ32sa0vPmc?=
 =?us-ascii?Q?u8nonp1wjX7g/3gyI9k6rQkVQ32Xr32NytMdomzmfMlXxWwCKT6XuqyID80k?=
 =?us-ascii?Q?MwDiPAkC5PU2pjROG5lXLgjr1v55+bBKOxkQBeLdMsPEZE3g8nqeW6RrpyQ3?=
 =?us-ascii?Q?sKjHs5U98/gv64aW2xjpyXq4hRpo1zgjd4ZJ7dZCC8S5VePXSNV4lJCVwPKG?=
 =?us-ascii?Q?eiI6pZ7JSN9IZA+oS4JCUzrKZYG4Uiq6pJ5QVeBOT8yDIk1koiuL2SlHRQ8T?=
 =?us-ascii?Q?4m7gZ2a1IYjHAouYGPvkACFEM0X4M2Cdqhu3YwSCFgqKs6tLyot6O7jQ09rX?=
 =?us-ascii?Q?5hHEBHVWVNNru8qpavbHJlswEG/63JwUHqrS1KNVSENmyke/1mDWFVScpsn8?=
 =?us-ascii?Q?bkezM5KLLzLcN80WB+/xK8yECICXijmonzkd8W91xG337IMrYZIKzXuApxZ0?=
 =?us-ascii?Q?PGKUC5coZR1f3XYU50YYCuO4dEOBY+afU4AgyVU8XDbonHAwpBCa1jEWb8kf?=
 =?us-ascii?Q?tQJ83Z0sD2rdvHwrp5lVNTa2k0wJYElpPROXKwzQcZz6dfSBl55kI8rSlILZ?=
 =?us-ascii?Q?KlMw7gEe7EOgvQX1HYijzEMqjK4Wdfmg8gs1D/gEomsXUJn/jLHi7BF6ns0O?=
 =?us-ascii?Q?QkMDxvUVUx8ksJD2w45fGc90PozL7hkuoXSA0nIf6zgMYru9zU5uNSmD8hd0?=
 =?us-ascii?Q?mPi6XsxhKDY3nd1EpDcndrir4ugqBfVteG2im8Mydc52yqz3mBn38XipQ6MT?=
 =?us-ascii?Q?QvxDYFkxu08hHlPd89WS47iw0PgySJFgdYZoCurwefLK5mMAebmOryWPFVHD?=
 =?us-ascii?Q?hWkjJqnBBoCHzO8ukgDCBOVKs0zcx1EvKzgqeVE0qqHGyzx3ABdjEQkFdp1q?=
 =?us-ascii?Q?lHbkzL0kEYaI17Vj3Nz6bhkjILvVrgdTpaQtn4SfWbkik2Z8ypJeG5BAw56H?=
 =?us-ascii?Q?JxELCILpL0Ikyw//ILIXTcqdY1FjmdcNf+ghbwmbiAq3ItFo34A7wl48GGLH?=
 =?us-ascii?Q?4744t4G0qZZq4yuffQL3Wnu23EbjaUD10NbZUd1YCsdS4rRZ+c1sN0Oy3Sr8?=
 =?us-ascii?Q?7mczxOodISdZFOqnaYYNJyNSkl6IpGI1oxtmupXNG3WsE8zFAwmAPH53aV8N?=
 =?us-ascii?Q?I/uLI8uceUb+Gjk5bcdS5vunY9C4tM+cAnmmAhxa1WpHQA2qoy2kM1VFMQMK?=
 =?us-ascii?Q?qaXkEdXmApFNU5ljldX79hIN7UKnijGatSj0Zx9f+CUlu0Vgr+Mjzo1wUGXw?=
 =?us-ascii?Q?qEyxlDjZbbm37io/K6YPjlfa14jVlpmBVOcvQjH1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81bae2c1-8101-49df-c820-08dcc6948e8b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 12:34:13.3876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /cgG/fROYeuR2nE8qizzIRiJ/kz2toGrc3D7Sd6in1zKJ3b1hlSxK9EByM52ScLcHOD62STtEG9SjcskdLwXAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5025
X-OriginatorOrg: intel.com

Hi Yan,

kernel test robot noticed the following build errors:

[auto build test ERROR on shuah-kselftest/next]
[also build test ERROR on shuah-kselftest/fixes linus/master v6.11-rc5 next-20240826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yan-Zhen/selftests-tdx-Use-min-macro/20240822-125041
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20240822044630.1267500-1-yanzhen%40vivo.com
patch subject: [PATCH v1] selftests:tdx:Use min macro
:::::: branch date: 5 days ago
:::::: commit date: 5 days ago
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408271330.HMq39DWo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202408271330.HMq39DWo-lkp@intel.com/

All errors (new ones prefixed by >>):

>> tdx_guest_test.c:121:14: error: call to undeclared function 'min'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     121 |                 line_len = min((len - j), rowsize);
         |                            ^
   1 error generated.


vim +/min +121 tools/testing/selftests/tdx/tdx_guest_test.c

00e07cfbdf0b23 Kuppuswamy Sathyanarayanan 2022-11-16  111  
00e07cfbdf0b23 Kuppuswamy Sathyanarayanan 2022-11-16  112  static void print_array_hex(const char *title, const char *prefix_str,
00e07cfbdf0b23 Kuppuswamy Sathyanarayanan 2022-11-16  113  			    const void *buf, int len)
00e07cfbdf0b23 Kuppuswamy Sathyanarayanan 2022-11-16  114  {
00e07cfbdf0b23 Kuppuswamy Sathyanarayanan 2022-11-16  115  	int i, j, line_len, rowsize = HEX_DUMP_SIZE;
00e07cfbdf0b23 Kuppuswamy Sathyanarayanan 2022-11-16  116  	const __u8 *ptr = buf;
00e07cfbdf0b23 Kuppuswamy Sathyanarayanan 2022-11-16  117  
00e07cfbdf0b23 Kuppuswamy Sathyanarayanan 2022-11-16  118  	printf("\t\t%s", title);
00e07cfbdf0b23 Kuppuswamy Sathyanarayanan 2022-11-16  119  
00e07cfbdf0b23 Kuppuswamy Sathyanarayanan 2022-11-16  120  	for (j = 0; j < len; j += rowsize) {
712bf3fd186eaf Yan Zhen                   2024-08-22 @121  		line_len = min((len - j), rowsize);
00e07cfbdf0b23 Kuppuswamy Sathyanarayanan 2022-11-16  122  		printf("%s%.8x:", prefix_str, j);
00e07cfbdf0b23 Kuppuswamy Sathyanarayanan 2022-11-16  123  		for (i = 0; i < line_len; i++)
00e07cfbdf0b23 Kuppuswamy Sathyanarayanan 2022-11-16  124  			printf(" %.2x", ptr[j + i]);
00e07cfbdf0b23 Kuppuswamy Sathyanarayanan 2022-11-16  125  		printf("\n");
00e07cfbdf0b23 Kuppuswamy Sathyanarayanan 2022-11-16  126  	}
00e07cfbdf0b23 Kuppuswamy Sathyanarayanan 2022-11-16  127  
00e07cfbdf0b23 Kuppuswamy Sathyanarayanan 2022-11-16  128  	printf("\n");
00e07cfbdf0b23 Kuppuswamy Sathyanarayanan 2022-11-16  129  }
00e07cfbdf0b23 Kuppuswamy Sathyanarayanan 2022-11-16  130  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


