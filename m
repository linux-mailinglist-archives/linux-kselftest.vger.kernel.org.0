Return-Path: <linux-kselftest+bounces-3827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23089843F23
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 13:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA237284F20
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 12:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B90178670;
	Wed, 31 Jan 2024 12:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oFZvqQj6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C6A78B45;
	Wed, 31 Jan 2024 12:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706702846; cv=fail; b=EmxZZYdqI6lZcecUcY+cMZzVyzd92Sd2/NjXN2gyDtyriOiyKqJR26L81nCEnC6DHilG3CYZVE5Y92fgFTDYG0ljtKkhNyjkzQO2Ihve3ZC/JCt+KX9ioscK7jQxlww00kn5DgwELiCiduaAQrMM8mLNz5S5FhNV358rziZ31kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706702846; c=relaxed/simple;
	bh=kigdKkzDvoM7x7tcIFf21AEJKcgFocPa3jhP28Fs6DY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lnZ1/4bIy40trg7o4yCU/8ZFhpqrC0c01jEoku5vYZxtduBbCZKv47Qa10PW9pJo0XC0ae9YmzDUVacuWGJ8F/ZYZp82SRoI3KrygvKvwicUQPg9KoZcIfN+nmWEovuJo2ME/S0lZaaK60lCsI/MwB6DJ0yCseRNHHlOhy0yZmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oFZvqQj6; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706702845; x=1738238845;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=kigdKkzDvoM7x7tcIFf21AEJKcgFocPa3jhP28Fs6DY=;
  b=oFZvqQj6SoMIMjB7jJpHct0T+GbxPxnqhx7W5ELlR9o5EcogQyxFmy3n
   UlTg1a3C/djvyV4p5/cuAKKKN/CQroLCPebdz4UOndk/YbUe3+XZ7XBRz
   l6cCNyJdTxVxJL0eIIdMo+Gfk7VSRzlKTkoFp+IACC7i/cqE43nWfA2iZ
   fGYy1fubY1pWNNwADuyyDlx4pqFuDxBS1941GGmR0bQLGwZSpH7xGwRyD
   Cy8knXkx3teco+7T4Cm20dyPqzy6Vvnv1Pu21a93VC0/ja042fZKol4dl
   gwhU9LHXd6wmbM2HZxlTfCj1qPHT8NgSyHrpQDszQr88tkHkzuq7IlGMj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="22090033"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="22090033"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 04:07:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="907863842"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="907863842"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 04:07:23 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 04:07:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 04:07:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 04:07:21 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 04:07:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWL9QnwEtlkPZgyNnhRXZhVphYEsCgLCHiCYvHS9Xc5TcI+hxZHApYaWiub1z2K+Wo/c0E9JU+2ynGi9LprvIgVsrZtX5WkXK7oVL2kYD7vwnzXLPvW3vNeK0IpwhtpAUSPcx4FCUVXAiDU1ebKd3D0tjPrxcHCgqnKoHeK2r9chs51CbiqemKYWJ8tQmqOCiYLNBKC4tBacopnUHaTgl1MpfX9xhSYjw5mqAFk6r4GnSJkE2NGH3ejHMXJFh/C/k8RCrq1mY72PIRpLA0GOISuv1OvdERiFGqGJyAvLAFUOAwDO2VsLndyBtWTUsApNgQsOHBCqFy+0ywpyEgXu/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBUsJWIDG9MoGtDMjR3DuFOt3ZI4E1seXCS0YGkKZWk=;
 b=oBvKhbNMShjUl1p0nPSiwmgclayMrrj3PBvbrk60NM566x+c9y+Nc7N+LGTBUzmdIDbvUUOVmiFEgEgE8d68F9e/9y8CjCmWm1EroTTFseDZkz6X4ixZvFYysb6UctCMrzPNWq/UwejfAFUpqKa8K7pnHPp8tZtMwQQfbv6iQIOCKcfCZsRFmfQPHzCipGvUT30Vqb2sG5ls8bK77B/vrlwIOoHC143fes609RkcSe9/Pb+NDXu2qnceuXJoyUN0nTiJRzjIGabC6PWxGXVwSFPRC8+GdyDxjUBZ1WkN7XBwW2r3Ti5Jhpz25srRtu/0OQ/gbgM1nhxM9CNnVO/07w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by IA0PR11MB8304.namprd11.prod.outlook.com (2603:10b6:208:48b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 12:07:20 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530%4]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 12:07:20 +0000
Date: Wed, 31 Jan 2024 13:07:10 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: <shuah@kernel.org>, <fenghua.yu@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v3 4/5] selftests/resctrl: Add resource_info_file_exists()
Message-ID: <fog3ndnmeka3isn3recquazpd5wtrzty6v75iikd542rfwk4kd@emlyliiu7jop>
References: <cover.1706180726.git.maciej.wieczor-retman@intel.com>
 <e73a79210076d6b1b7b584b12d0499e2f2e5f4fe.1706180726.git.maciej.wieczor-retman@intel.com>
 <9f8f1f00-f8a8-4c40-90ab-fd3357ab3b6e@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f8f1f00-f8a8-4c40-90ab-fd3357ab3b6e@intel.com>
X-ClientProxiedBy: VI1PR0202CA0023.eurprd02.prod.outlook.com
 (2603:10a6:803:14::36) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|IA0PR11MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: c8dea873-03a3-47e0-76c5-08dc22552cb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +5s6J5//lO3oA1xHFLVZO/7YmSqPRmDGAzjI/vo1ei0jqp0NZnD2xLCe6omyanD2vefNCyWvxaqKZDwurQWDI2h+1YGMJ3/MO0K57Zso/rwJwy6FVac/LElylOFsPfqdPWUCsubeP+DfZ0i6iLTxz5rrW5Uao8crl0hUscuNSb1J9zz3UGClpTyMlp8TbUngBNbu1dz0JvproKeppZ/2u9RPefkZrhEwZM2Duw+I+CxtGtkVhI8rTxysHjaASKgkSFyjqZ5loehJIXuvWrQ4dyb4EN2Mr/zBrxj58FUtRiK+5LltAwdEJM3EaLHqOppeP1TPrLFhx1wpp66FEbETWVYGJeErKWz9IHkbfrSe3SVDHISpdViNdAzRpmwZgO1+dmsxoiEVAW1DFNTHlvBuflFH55aYoxhwtq+8HtAA2TU7uTb8RdrXm903dTG17+wgeam5di0NmcDyCVe1ahJ3dq9t3V1nkNqAzGsSH/00Y+NqyAlemGUH1HRpGHXxj+Wg+ZUqx9UA8pxl4TjYhorpIXdh2jbR6vmvFLV4l3OpzCh+gGIDsTxmKPAIXiWzheeolVG0JB3JeESeoe48yG8lQ2ToPylKZCzCK7jPG1VmWmpsv6idFN/+D98mKiHc7AAM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(136003)(346002)(366004)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(83380400001)(26005)(66574015)(82960400001)(53546011)(6506007)(6512007)(9686003)(6666004)(38100700002)(6486002)(478600001)(66556008)(4326008)(66476007)(316002)(6636002)(6862004)(8676002)(8936002)(66946007)(41300700001)(2906002)(5660300002)(86362001)(33716001)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?kC79Q+8lB3aSpyLof+JS+IuQ3rgQLrdvXfSlRyFmpPYEIOnKjnrDr7N5VI?=
 =?iso-8859-1?Q?cZDLWSkjMbHIPQxvHRfftTd5eJ3VsMJxdB192LAtakgkHxjU+ZXsToU0fO?=
 =?iso-8859-1?Q?KGBoIoLadmbMvUw4eAI4y6WirMhShe9raqNB/Lt63SnA4cuwPPIm+dRDe/?=
 =?iso-8859-1?Q?x1XVd1wmavztqFxkC1T0IF+qG1L72W6VbDxDp6oAM5vWgOtOtB+DuKSy0M?=
 =?iso-8859-1?Q?i8ppP6VZRkF5zZXFpMGiMCWQlxfxmQPasEoMIjRkg+HBL9oIoCvSNEFde2?=
 =?iso-8859-1?Q?ot+rt/U1b+K80NyD//WC3qCRBoeRz5lP+wgaRWDDKXp6KmC3JUG6isTzLZ?=
 =?iso-8859-1?Q?k1R6RQzwPi/V3uosZDDLm+w8PSqrjTyOevniGYVWL8Fo9dcVtVXPCZYg7r?=
 =?iso-8859-1?Q?7j9rHXvpA970ulpfwST1S5l/hEUXd/hY2vq0xdWAGF7MEbU6DBM/P6U3MJ?=
 =?iso-8859-1?Q?yv+ulZo7dzoPr7/xoGMX4aB+Lz7rUIveq0zhoxn4hrlxy495Ys/+vvcOFn?=
 =?iso-8859-1?Q?DKvjQcq6TDV2otKRdZS7t/TehBk4KVEupzPH0PVVP6MrcPscMzG+pi2SIi?=
 =?iso-8859-1?Q?dL5FwqFUMJCtNzLPcuqfQSS/4krRFwAh2l78uU87IV7m23iQWAyFXXlEGK?=
 =?iso-8859-1?Q?pL50Tg1EAx7xDOgd/IvjC31TwssYpq+Ip/WH9Yunrw5fZUm3WnZ/j+FVDv?=
 =?iso-8859-1?Q?dazBHBxyD7j5k6SBET7dByr1w9Mf7gNt7ujVstagFg6p3BJ/f7yYHKbXM0?=
 =?iso-8859-1?Q?dj+pIuliImEfLCGy+sKphtl5NHygN02BWlZj4KT+ty/xSslHWd9VRzihDP?=
 =?iso-8859-1?Q?JYYkvYRSdmZRE1qGba7/VSdZN1dDzb1ojxEQ+bmAxP8R9mTed8bUt3+4wN?=
 =?iso-8859-1?Q?t7lBL5WoN8WtkrC2+fmZuJxxGOV2fy9kJSi9NE/9NnyAEn8sYPp8Wd3nzO?=
 =?iso-8859-1?Q?QhdLUraG0W+/M4xINZoFjnhKjwIhOX8k6k4eombtKHRyyFjGEW4TfDvGwS?=
 =?iso-8859-1?Q?LNIb3AvEEMGjgBA9FSM+wTsIMB5so3ZO7Ag9ko6jEFi2P6z2vRAnUbyQJn?=
 =?iso-8859-1?Q?JdK0spQJV3sM5EKXVXGfecVCOAo+PoW8vb6qPsfoI2nX5BJfaVZiXAk+3M?=
 =?iso-8859-1?Q?us0ujFeoH76Lqs0eCHA7AdTG32dLPFVCu3ac18TGilhjVgA34ccdN75+7W?=
 =?iso-8859-1?Q?GiOrC1U77HCrHymUww02eOXGVMcrwBX7hoQuyT3iNUEYdnAk3rYhT8ikgE?=
 =?iso-8859-1?Q?rK4916mEEc+6whRAwqNKwp06gkgHoy2506yhcSj8UsPpLlyhPhNUpRL29n?=
 =?iso-8859-1?Q?DaRZ4AJARTOMuHcc/Swa6CA7le5C4kxyhgn2v8/B4nLaJYW/yeq7y7TCpE?=
 =?iso-8859-1?Q?PorbFX71pvkE2U0MAGiEMyWVOZmEbyljK5nKeMlOXgBHoBrtj35uLUyVJR?=
 =?iso-8859-1?Q?bggikogU1qMGOY2A9JZGFs26h4O50rVEws6q1C7PSdUJJJ201sRuUfDfOr?=
 =?iso-8859-1?Q?z9t+Tl09tEMofu+RL/JHwWDR0JD8vAjgzt4e1chq6EoLtVwh36JO1cNajj?=
 =?iso-8859-1?Q?YZMr+sYCM+3LhlFOLw8xrm6ppnPuFX015oUGq5YNxprIA4bbMSLMj3ArVw?=
 =?iso-8859-1?Q?eeu2s/799XtjMwiM2aKbNRBMx6av0QFI5bgK2WvDvNsBrmoxVy4PG56bce?=
 =?iso-8859-1?Q?wsx9SNzK4/DzIkKSA9I=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8dea873-03a3-47e0-76c5-08dc22552cb5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 12:07:19.9676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpMg+AcmkoekKDwgD+F6stJR8GNOLUp9WaNnulYjBe4VA3FdPtgZr0v7HjQfSXYzIXb/wlbnCjwnB8DkQMQLc3x4ymyWstuD/tLJziIIVn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8304
X-OriginatorOrg: intel.com

Hello Reinette,

On 2024-01-26 at 13:08:52 -0800, Reinette Chatre wrote:
>Hi Maciej,
>
>On 1/25/2024 3:12 AM, Maciej Wieczor-Retman wrote:
>> Feature checking done by resctrl_mon_feature_exists() covers features
>> represented by the feature name presence inside the 'mon_features' file
>> in /sys/fs/resctrl/info/L3_MON directory. There exists a different way
>> to represent feature support and that is by the presence of 0 or 1 in a
>> single file in the info/resource directory. In this case the filename
>> represents what feature support is being indicated.
>> 
>> Add a generic function to check file presence in the
>> /sys/fs/resctrl/info/<RESOURCE> directory.
>> 
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> ---
>> Changelog v3:
>> - Split off the new function into this patch. (Reinette)
>> 
>> Changelog v2:
>> - Add this patch.
>> 
>>  tools/testing/selftests/resctrl/resctrl.h   |  2 ++
>>  tools/testing/selftests/resctrl/resctrlfs.c | 26 +++++++++++++++++++++
>>  2 files changed, 28 insertions(+)
>> 
>> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
>> index 4603b215b97e..c39105f46da9 100644
>> --- a/tools/testing/selftests/resctrl/resctrl.h
>> +++ b/tools/testing/selftests/resctrl/resctrl.h
>> @@ -138,6 +138,8 @@ int umount_resctrlfs(void);
>>  int validate_bw_report_request(char *bw_report);
>>  bool resctrl_resource_exists(const char *resource);
>>  bool resctrl_mon_feature_exists(const char *feature);
>> +bool resource_info_file_exists(const char *resource,
>> +			       const char *feature);
>
>In addition what Ilpo commented about other line, this too can be
>on one line.

Thanks!

>
>>  bool test_resource_feature_check(const struct resctrl_test *test);
>>  char *fgrep(FILE *inf, const char *str);
>>  int taskset_benchmark(pid_t bm_pid, int cpu_no, cpu_set_t *old_affinity);
>> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
>> index e4ba8614fb7b..a6427732e0ad 100644
>> --- a/tools/testing/selftests/resctrl/resctrlfs.c
>> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
>> @@ -763,6 +763,32 @@ bool resctrl_mon_feature_exists(const char *feature)
>>  	return !!res;
>>  }
>>  
>> +/*
>> + * resource_info_file_exists - Check if a file is present inside
>> + * /sys/fs/resctrl/info/RESOURCE.
>
>As confirmed in the changelog this is intended to be a generic function that
>tests if a file exists ...
>
>> + * @resource:	Required resource (Eg: MB, L3, L2, etc.)
>> + * @feature:	Required feature.
>
>... so assuming a use of this by referring to the file as "feature" is unexpected.
>
>This function jumps between "file" and "feature" in comments and code, please
>just stick to goal of making it a generic utility that checks for a file and
>refer to it consistently so.

Okay, I'll stick to 'file'.

>
>Reinette

-- 
Kind regards
Maciej Wieczór-Retman

