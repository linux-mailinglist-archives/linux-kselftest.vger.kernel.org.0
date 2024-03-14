Return-Path: <linux-kselftest+bounces-6334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1D887C0F5
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 17:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D504628273B
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 16:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4496973510;
	Thu, 14 Mar 2024 16:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dcmLyjLm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0646F08A;
	Thu, 14 Mar 2024 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710432470; cv=fail; b=bqEQABXadYCZ3HORVYxzJ/ojo+0hQUaZW6hXPGNXAXJnDectnGXTc54lw+gqByoOgk2LVtlcBzIKdLWhqbi8cFSHI9uyX2I0Dc1YeJmhvxvD2msyGe5Wzv4qQDAKMPFbcJf/V8T3p50MfZinCgwFrs0wq+bAu3omdco4CHExsT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710432470; c=relaxed/simple;
	bh=i5VhoAlM9TEGQvdN/xtAhSMF34yekxguomZucuJSvRc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kEfMhzwgmtXzbXPHk+mRSI45hwsVqTzPN61AKW6wPPFza3pt0d/DlmYJ4ZJDGZoZB8e7QGXjXQpxiLGkR6g64fq6gyI9chjO+L82KU2eaHhvf5QXvOe6cnV2i/teAq7YdRP6hz3N830BKvg4qiinKQVnQ6Ob5EWda6pk+tRYqTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dcmLyjLm; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710432468; x=1741968468;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=i5VhoAlM9TEGQvdN/xtAhSMF34yekxguomZucuJSvRc=;
  b=dcmLyjLmskbOCS1jfKs0r9HplSjpKgBcvSeA9WHDTufLka7Q2NAsXO0/
   IJu2MGDlfDd48LpVqvP1dnKHikJ6BOx/6BtE14Jbq9BmuLTQQyjtBkAL0
   nh23+6b9rX8wj5/ZFzxH6TUSkMiVr4RZ6RxMsnfIyYkHUj3wTQ4YlJy+a
   6wt5FN0agjsNGep3eSzsqJo8iFNj7saHJObAK7VRajbRR11DSAie3M47x
   Gt9XwLWyEpK9QEy6yhHHBdWLsvY1Cv/YVKSJ93p7YggN5MWNV2wkAffnx
   126Yogkeqcyjk3CNqeUXLm994TWJJxgFAyaDXcO3mtmIlc1TqqkAVxavR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="27732578"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="27732578"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 09:07:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="12412006"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2024 09:07:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 09:07:42 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 09:07:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 09:07:41 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 09:07:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XllzyGqwMYKvaPbr8aqf4VxSCCJBfcG1PIviPk991AhMtvdcVnrTLclyfZSXvidsu6rwKl88YmiMDudU/u7ttn94SIyrDQIGQuRBdLYsThxjS+tWYHiSZg6j/xznOzH7qPGbyZkg+lRFbb37aatOlsiQEKvtPCGwKMHRhtsLuPHlIvm3z56e8HsESOJZ3uTWgGC3CkqHUFcWX0cksoAIhcpBIJ9G6/1W93JzUH3PdAGissciXmu6QwJLOJimbBPsBSFuNVXFoS+TdxcOF161XctNZCud1pbHNSrYp+JhHkbJPPi4Z4aW5BI2c8Sdvp238qmJgbqckEUcagP5dUocuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDnfbGb//h8Hp+BoAcCIDr9J8CpLRwEkeZ6vZywsAWg=;
 b=VTxR3g4eQXp0Y0kVQqUWZYJ+gY3BCEUqSVSirptT9gDwzg2f0eu6kO/xoAvKvEME6uGYVL1iFfgK3cUqTnttAhpNPEKUNpFKTRifJIWjC/KlP3TG+BMYh3+Lx3gwHAmguDw5b5O/W+Adr49tVacb6+xcbqGRqpLPCMjD+vJDM8MeFPjWQ0IWwH1YfOifl7opBGAVWWtKQYX0MTQsuvA5x+dTjOzpRngNg7qF8Cl5qCp2lWU04gSyfeFDMZA3+6xmXNRHGEYWlxG6nVWUp4G12lgJQx6SS3ZsM/dkBFlJ2GOx/FkeTHHyEdqAGbgZCSdX+oIlzSXR7LihC4yPE1kRtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by MW6PR11MB8389.namprd11.prod.outlook.com (2603:10b6:303:23d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Thu, 14 Mar
 2024 16:07:38 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7%5]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 16:07:35 +0000
Date: Thu, 14 Mar 2024 17:07:24 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-kselftest@vger.kernel.org>, Reinette Chatre
	<reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, Fenghua Yu <fenghua.yu@intel.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/13] selftests/resctrl: Add ->init() callback into
 resctrl_val_param
Message-ID: <jzyc3lehsspybfa7fjzpwwcw2lgyfftsyqysqmpbrpq37aggln@cbjul5wgozu7>
References: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com>
 <20240311135230.7007-9-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240311135230.7007-9-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: ZR0P278CA0076.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::9) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|MW6PR11MB8389:EE_
X-MS-Office365-Filtering-Correlation-Id: 20750c78-9397-4a97-0611-08dc4440dc7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bpq4AfS4l3qHR/s8oC8FTrTdDMLb0DZCjUJ3B0T/RSXP9UfScbEyMf+owbNFjdkY/XOJdord2TMypDm7vRD3Fp62BbqemnfoWUqp1/cu79DYLwetdd5wItJsfuQaKdoJGtutDEyx4sMQDOF9wa/9aCYJkI9rkkPjlKHoqO6lGy5drZogXvC9npj5mitaPVGI5+C1Yt/lq0Ta/KJWHkWi++nvYbQcrSck3GvwOR2U0m9i/TSfWdxl51NJGcmAOLVtBpLSiZdoKYSa1gr3TsMBzoNaDumLADLfTsE5tLNNHxGSgzOOuwHrCxyeqCH3HduKKVB+L0niTelqe4xTwGsI/lMLq4XflpIVPRa3aGe+vFcv5Bfpu+XwrP67gFXfa6Rv/S7Y774H7qY9YeX0SshFS02UxJE1w1F1N3VKVV475i9wuAWF7bUd/xesAYzzufojmJ1S5TcoP7dg/sjOteEB3aFw2Zj7MsowfKd/jt6oPoDGfqv8u5vXU28wp2REVUR1LvRI3V+yDLf0AYFj8s3Bam4VnQcWDxW5pDCFypUQ9j8asIDAwCwOZWcezaVZdpFC0qBJRkcN9HbuUmWnMy6sHOtta3Nf1gBgXCkFG3DSiT/rlGd0CuTNE7B9kOaG5VHw3a1xN963bj9SAiAC+2jv7s0DkTKT/E3e2jqeEVnyXDA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?9cLJ+S6nqgZdKip+nZXGkkyvC1zpyTH91uRkODLyh2hjEFz6zx7KlMVwk6?=
 =?iso-8859-1?Q?JYOokydRtNOsGz3KAhqMqoek6Lvf7SnJZjoetePKF7urZwK5wJuke+w/f/?=
 =?iso-8859-1?Q?LpaCUNksXl6AZwAPg1uEn+om7ABpPWb5wTmFQ9q5QAR84x5PZAUDa4tPtN?=
 =?iso-8859-1?Q?pt6Hc0RhcPHQQgqkVt43cPX9VAfHxmS9idonC7Fqlb1kQ7yUOd4urYaJv8?=
 =?iso-8859-1?Q?6aY+u0lI/kb7YOJ/oBfhxsdGP0xZVPO/MqFG0T+9RcI6mp0tD8xVSQ/n7k?=
 =?iso-8859-1?Q?VH3bwTb3J8a/4TF/KIU0ragzFuYyxzxFrd2Qq0ZpFqytcPg5XQbHIlrWoe?=
 =?iso-8859-1?Q?9Ap0WKjx1+nsWtOgF0+pm0p0ihpEQcgBT9yTG0jKcVYgsQ8iIl+GogxK49?=
 =?iso-8859-1?Q?hebL1qPXwNDg0NmfLl7m8novAzsukEvECfhA+D8a0fhWt/dMVEcE3WNber?=
 =?iso-8859-1?Q?6ZWRA8t9ztQO2NNfp4honcz6LUUSGHAznvUT3rxcvyreq6QiSxZ5TWCy6W?=
 =?iso-8859-1?Q?+QS3A2JgIBW0HMK59+R2VXPAib3VpIpKy7l5QMh1vQH4dV3U4dN86S8JwF?=
 =?iso-8859-1?Q?cj1T97QUoGFQub1k9FY5yf9q+wsHA5X5gL82htz+/9bVfCIWjefpQAMURO?=
 =?iso-8859-1?Q?jA5I5DroGGUQ3YLGtdTyaNhDc4rl3TfoWY90OzXUxcMIj0k+Mxie7VaXtx?=
 =?iso-8859-1?Q?bvo3hOVy9Ca4nFUUW+bD2org1zt/XnlLtl5zWCjPUU7Wkea4MvDg8bAS6H?=
 =?iso-8859-1?Q?+r9qdLj7cvLP5023vu0ZgW/fWTqXH6qgvBRX4uKBxjJ3iH7Rvd8thsdpQ4?=
 =?iso-8859-1?Q?dFxINFkFdFEtP+s7TpQIMPKdN07T/ipzsGSueNsX4mYkxXoMqlHvBQHIMC?=
 =?iso-8859-1?Q?dLH28PV2pGZ9eiOtZXWC6N/O6HTxDAouSYPZpoFS4OR4oPXSBoRfVxAMMk?=
 =?iso-8859-1?Q?aAGMMFFuUxFWkVl+1r7RJ6TCk57L9rwKaggoIndauV32H3v6vWn9IxMGZI?=
 =?iso-8859-1?Q?dRJEwd9BopmxdtLvYZhnMEWiNsHEyAHkjHoEt8OXdPGW+CExKzqarMcqmX?=
 =?iso-8859-1?Q?c4s0zDS/vQMrQZcivTnJG6aNVSQ7sGZyLsbNPtGv2TDzqd3TZMT0UpZTWy?=
 =?iso-8859-1?Q?OOFpjHDd4TjxXixUBrR7ixciNqfYUGcr8ZJXxw9G9Hhp/3h7ml0t4tsfqd?=
 =?iso-8859-1?Q?ftDdUacZVXApdjwQxSRjd1kx7Pjb9VzbK2qetciR5YBXBdpfIMogWr3h58?=
 =?iso-8859-1?Q?EeLp8djH7IQpCZ7ZPsmpggAGFCgtXUHK2mjIr7Uk/k6O0utLFzFdhKSzkd?=
 =?iso-8859-1?Q?/1zNyW8G4CKhg7dyDEbXMxaq3ObAfJG4VO7okIQsmVigN3LAu1pTg0mtHy?=
 =?iso-8859-1?Q?763Pw2NQPITBRmoS7PDNPrI34WcRqQ4/shCV/CPbIZFWTxcckMXURitEcq?=
 =?iso-8859-1?Q?MN/BOR2qsNT6YNekJ3iDd1BWevy3Bh/8w34aDf97Yz05qJ2vsYH36iryL/?=
 =?iso-8859-1?Q?tYELnsMgaP8jfg7Hoh+LPj3TCjvolSXsqBccHjgyKAYJrh4eIjjhITXytX?=
 =?iso-8859-1?Q?/gceeaDogOv6KaFER0WP3jk4O9VEhSBSluFLfI+Lkdxbwg6y9T5KM/04Tv?=
 =?iso-8859-1?Q?/2Nq7FU0mzBNFZWov6xCKXmbW8PJ7fen6WY+YWJvbdU98qJE+Ix3MFLozI?=
 =?iso-8859-1?Q?sC2RQqyr4RFcwnEeUug=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20750c78-9397-4a97-0611-08dc4440dc7c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 16:07:35.0634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6EajvMM3zgBYkjIwP/pEQMwugw2KW/9+0khAND/gQyKovwLx9R3ZH2q/36d3NAaEGAeN6XVb72V4IkjB8sKzTfOMAsz1jZ2VeRetNw45d0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8389
X-OriginatorOrg: intel.com

Hi again :)

On 2024-03-11 at 15:52:25 +0200, Ilpo Järvinen wrote:
>diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
>index 17398cd3aace..ffbfcecf9bd6 100644
>--- a/tools/testing/selftests/resctrl/mbm_test.c
>+++ b/tools/testing/selftests/resctrl/mbm_test.c
>@@ -8,12 +8,19 @@
>  *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
>  *    Fenghua Yu <fenghua.yu@intel.com>
>  */
>+#include <limits.h>
>+
> #include "resctrl.h"
> 
> #define RESULT_FILE_NAME	"result_mbm"
> #define MAX_DIFF_PERCENT	8
> #define NUM_OF_RUNS		5
> 
>+#define CON_MON_MBM_LOCAL_BYTES_PATH \
>+	"%s/%s/mon_groups/%s/mon_data/mon_L3_%02d/mbm_local_bytes"
>+
>+static char mbm_total_path[PATH_MAX];
>+
> static int
> show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
> {
>@@ -86,6 +93,20 @@ static int check_results(size_t span)
> 	return ret;
> }
> 
>+static int set_mbm_path(const struct resctrl_val_param *param, int domain_id)
>+{
>+	int ret;
>+
>+	ret = initialize_mem_bw_imc();

I just noticed this. Since there is not only path stuff here but also some imc
logic maybe the function names could be changed? Something like

	set_mbm_path -> init_mbm

The same could apply for all these init functions or at least the mba one.

>+	if (ret)
>+		return ret;
>+
>+	sprintf(mbm_total_path, CON_MON_MBM_LOCAL_BYTES_PATH,
>+		RESCTRL_PATH, param->ctrlgrp, param->mongrp, domain_id);
>+
>+	return 0;
>+}
>+
>

-- 
Kind regards
Maciej Wieczór-Retman

