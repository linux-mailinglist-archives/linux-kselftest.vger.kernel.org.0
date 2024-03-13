Return-Path: <linux-kselftest+bounces-6298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0045587A5DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 11:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58BD7B21C75
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 10:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D893987A;
	Wed, 13 Mar 2024 10:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VUxE/1JC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09CF3B29A;
	Wed, 13 Mar 2024 10:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710325734; cv=fail; b=fkJOn6v9z+6BWMnu4IxS7A8sQzsmZZb62qpFzpxhn7tMNj6Sr6ENTnuyJV9RcqXAfjgBCYmVm3KuM391izgPB6u0kwGiffWWWOZEs4gAl1evBk7QdAib2f0eSCO6N+f9eEwW9pjyWzbRkjKk7+PsmD8VM/fAVPNK4QXld9KvgnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710325734; c=relaxed/simple;
	bh=17nnAaI1wMdkQIzEzFxt40aGgLF1oqcW0fOis4+jIik=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C4CSRTKA69/Tj8aYk94JZjiyhyO93YeA9MCQ3BABy3+pooMo2dts2b/sZ0DXOeMnSAV+wILZvFmZ1s5j2HHCc/ry3SDYaBBxHQrFy7a+MVzNdat0JqYcnRNkleAxLpTjBG+zJ9JHMLFu8b4hypOgj/Kv661JuSt9HifKRyKaobk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VUxE/1JC; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710325733; x=1741861733;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=17nnAaI1wMdkQIzEzFxt40aGgLF1oqcW0fOis4+jIik=;
  b=VUxE/1JCDBVLfLEqjDnIAZ6K95WL3N/uzLChPhdqVwzlJQjZ+4HGbGGl
   oooGSj5+A/5D5jeGjBk5wL8Y0zEnlKk1XWd0Ii00ibFiUcR3RcZPu8SrY
   nUCrhzv/rpUuvm8+Sw9RRz6JyumEuSDCjI6XN7wTTgUS/q1VfZn21JjtQ
   jP2dFgWPhCEK3IQgGhwWto7DAK/ja3U7a0/8zAelveGyi9hvtEAi7CuKN
   GT1LGVNTCssQQJGZ2eN78gO/kAlX0pE7JvfGC/QdeOw1Y0CVhVBWZGAqx
   m0+EVdzeTmVi2VTTDrqyBgCqid6zvsgVc2kyzFP0InzrD+6v4jdoOm0yN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="27556873"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="27556873"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 03:28:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="12296364"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2024 03:28:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 03:28:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 03:28:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Mar 2024 03:28:51 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 03:28:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUTFHoBg0vwWs0/9/mSiEk+9ztR/fdz2L4ZqVzOUTggwY23F6wIl6F3M3pTQHHI6ldFmASD2G0Pnj6nkq1HjjWP38O1WbE4a7M6Dj4RmEQ0tVYBU3r9wXzKRHBFFn/ZIi/CnP7NfydhY/CbLecEzKCQXaey/3/dLG7Fre/8Agu2tZgWtmmqQV5K3NL9gPIsOrDgzrdxToPBtZzOdP08NW1VbS+XfmYx55Mc/wNswGM+SSqA3et0VwP/12uJajG4VmyIhfI3xh35xcvlxyXl1HCdFM9mo4HnmXTVJksDgX081XoAEKrRUqKKMRgE0WlI2XkFC+FYA9UyCiteA3W9D5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYe+Mffvd7dhCZWdwFZw/T1X6xW0Q0jojRDO+0XkvZU=;
 b=iOc5PW10y8SepPHt4oIsG/cXWsg6Vdid5gxen4qqO/qqWzgyX2lIAH1UeSiZUXGtFCWc+xWlBrDzi1uQ0C5Kc60Xmeu3+p5OJdXfQ60aHwgjcKvT/kv/zlXgG5OwEMuNG+1zjoB/8PceMS4y6PNRP7oTsUUqhcDHLbRKWB6nPbcgMOA8bcQ4x0G2gjmNWnZSlzChSTskdVwinJthFbJpH+3aodeFida67gNe1DvkpyNtSljH/WifAr/LJ2mDOXp8R03UWxY6sXkRbkK+I0nzI6tSnJGEWh8THUmEBDj4v4DU/PALG5JcOQ8+sdCz0BbMG9W/W3qV6knk8/+zN08b2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by IA1PR11MB6395.namprd11.prod.outlook.com (2603:10b6:208:3ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Wed, 13 Mar
 2024 10:28:31 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7%5]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 10:28:31 +0000
Date: Wed, 13 Mar 2024 11:28:19 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-kselftest@vger.kernel.org>, Reinette Chatre
	<reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, Fenghua Yu <fenghua.yu@intel.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/13] selftests/resctrl: Add ->init() callback into
 resctrl_val_param
Message-ID: <vzluzxmks6bqfszwoib72ufbanxucxk5xzilavp3wrwoh7fqxh@rugv6wcptofu>
References: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com>
 <20240311135230.7007-9-ilpo.jarvinen@linux.intel.com>
 <zxrd5yzgtbet3d42c77ifgu5t2guyhwbz76zhk7zhrp6hnamrb@pl72dxisxax6>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zxrd5yzgtbet3d42c77ifgu5t2guyhwbz76zhk7zhrp6hnamrb@pl72dxisxax6>
X-ClientProxiedBy: WA2P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::24) To DM4PR11MB6239.namprd11.prod.outlook.com
 (2603:10b6:8:a7::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|IA1PR11MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 86f2c51a-93b8-44e8-cb31-08dc434853f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DW8bBJw0Zz6fhGGs6ZdWH5J9qUyMwAvy09KJT7nTQz9dCyW8GSxL350p5BD7T7ABRlhqXKdOc7JrZJSnWskMWNQn2Y9iFUOKCs6pfzTNkBxcmG8gce/m4jwwMDyrhH4T3BChg658hHc9kBLc5KSIW5n7Q3m12iijg2EJVa5Ad0rnowx9SrffqZnW+KAXHuwFKSeki0KdkPoinVoH1FpaDmwl/CpDPF6cWSnYdGLemqEJ9YeUG/rQ6iSMSyYhYY5dq2nfpaDQ7omiTNFnIgsH7Y/ZeOWB8AuJjuu6NgWJGZG/0fdBHyBSopo3AwjeDpFC2QziESQtxCKC622BZUavaWoW9q0JPBNWz1+J0y2wYn7S0U699LnIkojbVni3k/13yTLbM3INi1/YdwMmnfvAiD9APYQf+iX29rLS9WqJuQf7/gm3Gnk9ZFqRLkrRZgc/3FOVjRZw28NSBpZDfY0XIEYFoqhrqATkShlVghxyhm1QGzLvU5ArClHycaey+S3VIx1nrtabddZ05s/hPWxLc+n4fF1cQxKeCd6095v1cV7QP47wOg07n2TdLUizQZyNTk+Q3I4W60tTRTv9kAddsvDLeiNlqjBjY7e59FRKyII=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?5mqAf8fJgSse74xu48DmfBmqaRNHPRs4D5/zv9DAebHdBebLH4htBM6PTt?=
 =?iso-8859-1?Q?MsKRIykBmhHcCvaJ5jXbpB+c9r5VHbPy02UGJK03UdNMDj9GNcaJ4z+VUN?=
 =?iso-8859-1?Q?X7VFAMyABZ96R2Tj8KFGZ6na4QU1KrvIJQ6AjeVkkMvzrOCg5iM0INaKoV?=
 =?iso-8859-1?Q?jvH7shcwUHXOJ9E/ZVFgZNO5P8XiFobQOskvkuU6C5bhMpb817I6wn1RMG?=
 =?iso-8859-1?Q?jbQDm4YVxfX/La0GBuMZzCqxEAaSlNhSHa+WUvkN1PUX+bL2TUT4mlX5UW?=
 =?iso-8859-1?Q?SM5ImHl80wNDyx6Bih2jFDSAdYKSx8LreBfAZYJ3s8w7lv0XPdq9hK5uKP?=
 =?iso-8859-1?Q?TsjtFtQBl8tImZ5TXTyExcX4nC4xH2nTGPrTsZsENomAOxeCk6Q/WbNTtK?=
 =?iso-8859-1?Q?LSPpxGGAGPTkvX08UYor2SdxDbdQO33AxMGmBOxq6KIzOB0/WySRA5Sdby?=
 =?iso-8859-1?Q?P8MW4ZyBNULjyRD+S8XLo7f6JdnrZBBSAtDpNxBo5T5U8d2ISjxafii6UD?=
 =?iso-8859-1?Q?A7/kHI+PC4uYXX8knJpXNDl7vlE+AKdoIT7DQdmzVYXyORuaium7/7a+kk?=
 =?iso-8859-1?Q?5T0V1ChAYkkoF3Fx9gu+JbmSldlXqDyklDrB+kHQH31Gi0JXOMHQWVfTZX?=
 =?iso-8859-1?Q?0kTJbDSulUyEOyZlYcjMgbcY6ZIkXyOkdvAYSJKedd478TgrOQjONKJbCe?=
 =?iso-8859-1?Q?8LoxeB2ACVI7tb6r3F2xRbzmXa6G1bTZSI+ZL0xQnvxpEvjktNefAEs5rn?=
 =?iso-8859-1?Q?mNn3FwLWrQCZ21lOGHFqT7BPCJRbruD4wzO5ZuiaqXS3Q/VY2zBLdE1i4l?=
 =?iso-8859-1?Q?SySPx1MBj2UIdCZaX88ICM0FTdnMRVnv6K5UTP62zpyt38xn+3gmkNZerl?=
 =?iso-8859-1?Q?aLN02sfkEDtUU1npn5TCK1OxAaBjRIKQYrcNmXR44nuNFABDJCYDH3WiFw?=
 =?iso-8859-1?Q?3XqrRrDkvap4jzdN/YyP5IypGbXI5sCHTiZ8AdZLwqDCDGv+q4OQA7zbQO?=
 =?iso-8859-1?Q?O1fBlbFfXVzCOh27mWPDvUvOGDYm341vfJeEBbbOkv5DvcGNxBGrqB3vCe?=
 =?iso-8859-1?Q?0/1rGvy7JD/rNEkRgkqiCmLWWyf9SNtB+J7LaJG8Y5MB71MLITSYHGfvZc?=
 =?iso-8859-1?Q?psE+KsHZNv9qfI7uBnamI3uGWS3cYJYAY1fr7QwGw6TYwYv5SXh2QDmtXw?=
 =?iso-8859-1?Q?LtqyROb0jsZv4Df47tJkyqAnjOEDfSXhGmUxpj/8bep2YWJ+w649gJnNFD?=
 =?iso-8859-1?Q?lD7l9Ucqic1eVop/NRPk/pZZ2wHk3t5v7mpEh6ZLAw2pwEwYJ7KlOsGB9M?=
 =?iso-8859-1?Q?hO7csvPSQs36fhEj+2pLC52ULIJgsDu+SoQS1c9ncD/TRPzNSdsyus452m?=
 =?iso-8859-1?Q?k69WpnTf9LTyWxvyFsrwq0ZmGl4xCfqgPghPzNpLkDOYnLotCJuBQdP0bT?=
 =?iso-8859-1?Q?SLYh0GtT0AErYtufVBxPo8QTEMj6Y1bv1q/bJjgfV6NI3MwROnjmlqSQ+p?=
 =?iso-8859-1?Q?e4dJsYC+Mjy4pRiJLEyUwyprDYRkGjpSmNEshvhUR+qKUrHZojVFfpQ/Eh?=
 =?iso-8859-1?Q?OUFsWKKBqmYYjBpK92vnu6nr9vtEHXGQdpV8d0kk/HydiIwoDNXHeePi4E?=
 =?iso-8859-1?Q?gzQF+gXVGaYNLKiOSIWYQU7U2D5RXqIFpQnEMjZviE1LZaZmp4QIXdJZom?=
 =?iso-8859-1?Q?ev6PnbAan/eIuk2t6rE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f2c51a-93b8-44e8-cb31-08dc434853f5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6239.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 10:28:31.5278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSel23LJAAYbL9nUO8JaID5hcT+ClKMZyGg1KAUZrwIykZMz8rqkkIJtE8+DFDDqdrVbQU9uZNsmIcfF4Q3ZzwgrgxctM1n799mZFcmCKGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6395
X-OriginatorOrg: intel.com

On 2024-03-13 at 11:15:30 +0100, Maciej Wieczor-Retman wrote:
>Hi,
>
>On 2024-03-11 at 15:52:25 +0200, Ilpo Järvinen wrote:
>>diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
>>index 241c0b129b58..e79eca9346f3 100644
>>--- a/tools/testing/selftests/resctrl/cmt_test.c
>>+++ b/tools/testing/selftests/resctrl/cmt_test.c
>>@@ -16,6 +16,17 @@
>> #define MAX_DIFF		2000000
>> #define MAX_DIFF_PERCENT	15
>> 
>>+#define CON_MON_LCC_OCCUP_PATH		\
>>+	"%s/%s/mon_groups/%s/mon_data/mon_L3_%02d/llc_occupancy"
>>+
>>+static int set_cmt_path(const struct resctrl_val_param *param, int domain_id)
>>+{
>>+	sprintf(llc_occup_path,	CON_MON_LCC_OCCUP_PATH,	RESCTRL_PATH,
>>+		param->ctrlgrp, param->mongrp, domain_id);
>>+
>>+	return 0;
>>+}
>>+
>
>Is there an option to make this function (and the set_mbm_path()) global through
>the resctrl.h?
>
>I'd like to use it in my SNC series [1] for looping over different nodes and
>that requires changing the paths during the measure phase of the tests and that
>part is currently in cache.c:measure_llc_resctrl().
>
>Or would you suggest some other way of changing these paths in cache?
>

+forgot to add the link :b

[1] https://lore.kernel.org/all/cover.1709721159.git.maciej.wieczor-retman@intel.com/

-- 
Kind regards
Maciej Wieczór-Retman

