Return-Path: <linux-kselftest+bounces-6300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 020B487A8C6
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 14:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC60D287969
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 13:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9979B42069;
	Wed, 13 Mar 2024 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NMVvKYG3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB3D4502E;
	Wed, 13 Mar 2024 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338047; cv=fail; b=RVNkcHGSjN0ZrfEV5WyI6oTvpJ2G3vApfhfUv1ywg46/dr3QclbQO1P01bqeqjQ3BOOO3eQQLsEUIpnpqNcF3WngtyxrpF4DdQ9QaUg3jaI4kt0BCAzV38M8hQxD929MpYN4Z+5Rd49C16ZBaXhwoTwjN/eFmce/qmuK9/HBQ3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338047; c=relaxed/simple;
	bh=Bwhd7pNfmg2VOcmHtUW3yJp22Ey6AsIkEQZMZSkbOvM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gt7Xi5tMG9uAdnOie3bjWJy1zAntc4Z86ERnrb4NTBfbBpJeTVSYtdvqZfV3h9xhl7aakJRUD6B44i2jBlpLpfPIxPNoFuu8laA4FCsG4PBwbulQ/aOSUY0ehjJHOUghaW+hHEImihYxBAqC2dfdrIlZPWedpHzvw5O7UNoRUqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NMVvKYG3; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710338046; x=1741874046;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Bwhd7pNfmg2VOcmHtUW3yJp22Ey6AsIkEQZMZSkbOvM=;
  b=NMVvKYG3ZTtCaC72m6Pt5stbBFgUUyybynZtP7q5YWUtsMO82O4uP39G
   73aenaXlZqfVNhrOokF1W+ChpAlWY+PJd2sD6MKzyvpnyNKJaDePm77Cn
   li6kwVpYA/BaPEEivpafKAKltCs0GOvYjeBKJhhAa9B0TpS8lO8xdnDOr
   Eh7/4CgEF9eaxzuXtaWhc/MWVQD/JR3Kpv6/E16KMdqMYIXWJ0bd4lemk
   jwnO1vnTe7jsGD1IubxJlqTVI3mq0bl5u8OsQYonqPwzJsy3+MxYqejm6
   4PXP6tHY0URN0+XexIvBfp71wJJbCYIgZjl64iz/Srk6L8lySKVInp62G
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="15828435"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="15828435"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 06:54:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="16530061"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2024 06:54:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 06:54:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Mar 2024 06:54:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 06:54:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRZEsyYJTJz4/R6zVkWJ+lMu/nwhJfiNwpXdiiv4/dZ/bigo81qq5meeXcj/mJ0rCThGDbMhU9WMrJ972vuNAgZUK+K8qQF32ZXjeSIrYv5yWG2BPdXGXv19OWgN3gxoAh/6Y62SsI74xtPiUF6GcLvlWaeSWUk3onqPCRrNpbPu1aWg+GjDrniLA90ggyW46tCT/WQtrg0FaOrbC878SQddDzQzLmYz4Gl6iqWB1XOxgte9c0fRNJ1PdYjgkg4ol3mrU+5zZOEkr4Q7TkTleMsP+FiPPTZaWF0mhL6UxW9bQ0MX+1B3YnX+uiCrZyqGgUhlhNnXJMJ/f9D/X0eYCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyNc5pIk/5DTT67lscXdTC/VVJEPRTm46HF4WIF3qsc=;
 b=RJq/k+EkL70PqkcZRasK5Ygs0F6z3Husidn/qGxWCr/McLGEMC8N9j/XULn9ANfIF6JXUGfri+NrsN3eqDy1Xvpr0f5Avc+TH28a+ryk4iphfCFjrSvNZYtUOZ3QGhVEaTLjr/mjP/jekW7Mm7gK4Ona9hntn/Z/pf7/aMbLwJulffGWCFgSvFIlT2LVAdlfX3QCHUrR073E9MuNbLZWSw8JYhs8L+zWcgtzh1nHSEz8t7uJ21+NXaO/4nqEmkiemiwXzYQHwGFHXxITu/nAYG6Cy1Q44LWAf0In17jE+O/yEaVs2039qtyITO/FbY7B6sTbuCEu3znd7QKPgQfZUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SA1PR11MB8448.namprd11.prod.outlook.com (2603:10b6:806:3a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Wed, 13 Mar
 2024 13:54:01 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7%5]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 13:54:00 +0000
Date: Wed, 13 Mar 2024 14:53:50 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-kselftest@vger.kernel.org>, Reinette Chatre
	<reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, Fenghua Yu <fenghua.yu@intel.com>, LKML
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/13] selftests/resctrl: Add ->init() callback into
 resctrl_val_param
Message-ID: <7zhdrvbb2w2ytyhbr2pl22exkzktqhv4ykb5pht6wsefg3yfyz@72xhgz3uyawo>
References: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com>
 <20240311135230.7007-9-ilpo.jarvinen@linux.intel.com>
 <zxrd5yzgtbet3d42c77ifgu5t2guyhwbz76zhk7zhrp6hnamrb@pl72dxisxax6>
 <vzluzxmks6bqfszwoib72ufbanxucxk5xzilavp3wrwoh7fqxh@rugv6wcptofu>
 <511bb602-e29d-0a2c-3076-81fdd5a5955f@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <511bb602-e29d-0a2c-3076-81fdd5a5955f@linux.intel.com>
X-ClientProxiedBy: ZR2P278CA0030.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::20) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SA1PR11MB8448:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d59b631-dc82-42c7-b4af-08dc43650956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Uh7QUYacqoqNWFGDZeASuOL9H6XZA7X+LbsEDOFRj4xTx3HIFYqgtvGwxB9J2Isr23WQ8foGdwO4XtIYZT7gmhJNeUqusr66udy5dEPVOPR3pC0ADhMMAtU2CdEczrUZjIXfO41hILYKlHKDIurtZCve2dkSycEYPVJDdur4UAbNXDs5VHyAsM9kngOiUaYPS0KIS6CDLVv5MOU+S7bojtz0T0+ISTpXKAzJtqGhj0H5YTYRPA1P/wQzQi4HpJA+w6GuEq05WHIZxaOaLbLz3H47s5a3B2RINeHhyT2hgIATmTJXIWt9JPqZf401q1TSNlpXAlG8cxNE6hNErIBfj8lwzAKvJQmG2R9ptVuElk8wTsm5paVZiHYuKHb7f6kefjKWH8hvJa0HtG0DUoOfrGWcaLvv4rPu46E0MYLF6geHtlgAsYJy84DBXFsUohCwzOBoqU1HTuvzaffdQoUL6SvT6vOafXss43qtPbyKYm2FDbcM2XygFWEiX+S5cIvMPMRTw3/sB6+1Sg/xFo5poDm3CClPYHaYaytOXXnnzWwTz4oaWOJvEZh32vGHNfH8sOY2+BIf0Wj+l/GjT/9Bfg+DrrRtVClsvpEFDyhAOw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?4WlFfTbTUz0m7rOvderSiGgZIRXeXA+21HetuoYjNqH6Yw4N5tiXqf+dFm?=
 =?iso-8859-1?Q?XQlFJnhqLDx0cuS/4ptHXVp/Fp8D2n7qQFTdZF23il3dlMjQ7zfb7j/Mva?=
 =?iso-8859-1?Q?JKOQdaRupPAO5ivivKk2vBOtPE9o03ZzcJv7cQRpJGNlGZBKZDqeZUuObq?=
 =?iso-8859-1?Q?8HLgGQxD4wf32pzZXuCaGpkwH0AmA9jHv15aZf+0q64yt9gk7bW062rdby?=
 =?iso-8859-1?Q?U4Cdlt1TJC4hCYNMRlF/auHCDFnFZKqezX/94vNNlcojqzK8X6kJi+0X6C?=
 =?iso-8859-1?Q?/SKWER3S4lDO3/Ipu+ACQ/nuHDg/qHIkOiHLsNU8IOzuWyqQWgUzdj47qX?=
 =?iso-8859-1?Q?w6l7Dvo5JTbo6WYpBM3y+gmJAwzLhXoNnfOEiMETU6amj9GtyQX7uQx5ct?=
 =?iso-8859-1?Q?Bx51OmWV8APqZcUuWYZfPzeDc97dZDOxvglLm/Fzzxbz77wNFl+41cJMb7?=
 =?iso-8859-1?Q?B15IC7KoClBnnSZ65hU/yeiH4c7jP1tpNLcn7tLF9P5rI18nFj7XtPNZYj?=
 =?iso-8859-1?Q?p5oFfiIzoZgNmIi+BLrH4etwMCtuomK4WJBBLI/X92GrOnOiJS514ln5PH?=
 =?iso-8859-1?Q?ieHrikqb1eJTBnW1Fm3KE03/3frdUITei6qRR3l1ywyPIB3DvDiZzpv/4s?=
 =?iso-8859-1?Q?CscBAH5bUYDW7eZVP0nUPxsDjUClA9b8BIxluPT/5veLccr+iU6YxQAAqY?=
 =?iso-8859-1?Q?k58b3i0Hnj46j2Ews+JsfUmKFmKYTpsVBkLUurkqSM/WFfcp7OlTYcmLCx?=
 =?iso-8859-1?Q?jgk9aOWbIqiKk409jn2PYQsTGr8j3iagPb79CwcdqN2KJGI7fv3NSsIIFL?=
 =?iso-8859-1?Q?7Gtbd8PmHqR/FjzMw9xf+jcDxVKg2SCmp49wQvo35Ly8aytjKVX7tJ77tO?=
 =?iso-8859-1?Q?Vb+rTCFU7yaGr2f1ZLyxyzXa1HLg0G/z/B8Tb4Jdh7nfluGOuTE/KzUvAn?=
 =?iso-8859-1?Q?WJ4KbsiafVPmB45g9rFKSJNno6nqvuq3SIe+pKalHmK5xPJa8QAJXYm0/z?=
 =?iso-8859-1?Q?PBhoa9fIA0WhIGtDQdIxVyNMTfvX30toh7C88nvhPk7iSygCVIRPVzG7p2?=
 =?iso-8859-1?Q?Km4MWwMGrx/RGB3iqX0Epp8VrLIw+MI6sEXOXWBT2c/zw83ilEo+qKTSm7?=
 =?iso-8859-1?Q?LAnXszla9z7Pnx+p/v2khFnfh2oDbSnA93aVXP23/pr0ht3mlf3c5T4J4t?=
 =?iso-8859-1?Q?N90o+ABgJOE2Qc5rkemV40Wogh1l9GcWcPzvfNqHPL/4m1NGa8LwrDcITc?=
 =?iso-8859-1?Q?67btitp0KYABqrEqPPGe7okRhwRSfD3IQAuLdkZwp9VdYDuvySkxTlbGi0?=
 =?iso-8859-1?Q?kHonPCAHYlp7eXqX5OU52k34h5yQgZAmG89mQmJikudrqlpEd1Gb2xjuj6?=
 =?iso-8859-1?Q?sRMzSq2nD/lBm0oMATtzVs6vNwfn04fGxxiDfmEyU1io3G4kjQ7UHItUll?=
 =?iso-8859-1?Q?BU0ZWMBndj4t7nT0hoPuXU7oceHnhCQNK5j6ocPwjnUfwHIKLZu/0yF7zw?=
 =?iso-8859-1?Q?vtS0KwX0dtHOu6wxxgvm+k9Kg6OvPOXIUG+IyEzlQFbAtYEf1xOy0Q1pEn?=
 =?iso-8859-1?Q?ybNf+u4KN/uuGEjeGKEgT0tUBv7r/zJSlN7V9ohj8Yo2+UGu6VdRq+V6Fq?=
 =?iso-8859-1?Q?YEXFkODf2W5WP1W2c1AEsApKPaeWcXEwUxwZw0bx7wQ/3kQiJSmCAT+9o4?=
 =?iso-8859-1?Q?pNEZEEhHmzzUiOldtnw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d59b631-dc82-42c7-b4af-08dc43650956
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 13:54:00.8697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQHwnYY4tWB4i3DN4VLR78rbmT11bREOiC55OYWJzHKpDxD7P5FHac8jVCfEx3yln5MR14ZvvwFEVgmhjN7zQpRRLu2tsiY4AHUe5EZFJbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8448
X-OriginatorOrg: intel.com

On 2024-03-13 at 13:37:51 +0200, Ilpo Järvinen wrote:
>On Wed, 13 Mar 2024, Maciej Wieczor-Retman wrote:
>> On 2024-03-13 at 11:15:30 +0100, Maciej Wieczor-Retman wrote:
>> >On 2024-03-11 at 15:52:25 +0200, Ilpo Järvinen wrote:
>> >>diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
>> >>index 241c0b129b58..e79eca9346f3 100644
>> >>--- a/tools/testing/selftests/resctrl/cmt_test.c
>> >>+++ b/tools/testing/selftests/resctrl/cmt_test.c
>> >>@@ -16,6 +16,17 @@
>> >> #define MAX_DIFF		2000000
>> >> #define MAX_DIFF_PERCENT	15
>> >> 
>> >>+#define CON_MON_LCC_OCCUP_PATH		\
>> >>+	"%s/%s/mon_groups/%s/mon_data/mon_L3_%02d/llc_occupancy"
>> >>+
>> >>+static int set_cmt_path(const struct resctrl_val_param *param, int domain_id)
>> >>+{
>> >>+	sprintf(llc_occup_path,	CON_MON_LCC_OCCUP_PATH,	RESCTRL_PATH,
>> >>+		param->ctrlgrp, param->mongrp, domain_id);
>> >>+
>> >>+	return 0;
>> >>+}
>> >>+
>> >
>> >Is there an option to make this function (and the set_mbm_path()) global through
>> >the resctrl.h?
>> >
>> >I'd like to use it in my SNC series [1] for looping over different nodes and
>> >that requires changing the paths during the measure phase of the tests and that
>> >part is currently in cache.c:measure_llc_resctrl().
>> >
>> >Or would you suggest some other way of changing these paths in cache?
>> >
>> 
>> +forgot to add the link :b
>> 
>> [1] https://lore.kernel.org/all/cover.1709721159.git.maciej.wieczor-retman@intel.com/
>
>Perhaps ->init() should just prepare an array of filenames to read from 
>to support SNC. That would keep the filename preparations out of the 
>measurement period.
>
>It feels slightly hacky to have an array of files but I cannot think of 
>anything else that would be cleaner and would not require creating the 
>filenames during the actual test.

So the array of names would be a part of "struct resctrl_val_param"?

It would have to be dynamically allocated too before running the tests.

I kinda agree, creating filenames during measurements messes the whole
separation idea between setup and measuring. And as you said there are like 4
nodes max so not much memory would be wasted there.

I can experiment with it and try to add it in my series - since it's much more
tied to SNC. Unless you see it'd better fit here then that's fine with me too.

>
>
>-- 
> i.


-- 
Kind regards
Maciej Wieczór-Retman

