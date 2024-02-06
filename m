Return-Path: <linux-kselftest+bounces-4180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4F484AF0B
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 08:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFF4CB20C51
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 07:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4522312882D;
	Tue,  6 Feb 2024 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VQFBjwHn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525027EEE0;
	Tue,  6 Feb 2024 07:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707204863; cv=fail; b=Bc84iGtiP3ApXEODJt9HIQP1mn4gfqpGosijMYZcBk1uWsg0I5OzPcOQ58Dvosr8l3QZHNr8JKpA7RkUIVlqaR4g+iILjkb3nyzdXgY4LIe1UAOHNx0zDQWLeUJ2zLxFCPACL4hDPyheQ1VSUNuTPKEUWrltn/7lrlQsfcj3cgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707204863; c=relaxed/simple;
	bh=TV5TsR9YUkDZmNcACK5+TestpQt1GSjBkmhCxNpyWTY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tvLIcyMIuNCsL5UStCWR5hYNQCXZAUbAz22YDCQxHPa6//mqH4BVk3m87ja9zfvskvTdBKJDSKOlCCenG7Vs4fDsq23gb4Bq1RzfuK7mfMqI+MXXF4Tsy62cOxw5eimd9bB0yvWUyMxPBCSAncyMQJFoJnOZo9VaxT5LwdXuyYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VQFBjwHn; arc=fail smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707204861; x=1738740861;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=TV5TsR9YUkDZmNcACK5+TestpQt1GSjBkmhCxNpyWTY=;
  b=VQFBjwHnG4u1++0+5OYOMQWCW/IS2vVI9MUuiXhx2/pJ2cccgxeQ21IO
   DmOqTMt0VJaQMDg/fxkPJjwM4MpT8qdw3CdE0xzzsa8Zg8TLd5Au/TLW3
   IyOXAQkIpl8pPxq8wS6KEgePX4yf+dHbBLl5Sp5vQRjXUWoxgE/ObTbY8
   FS6NqnmU6JA2YHHZYdP8RM/TjntFA5GgBtd8wq/LyOTY8mfZ324coJYGt
   l+/PLvvn3HjaweW64RKUgyXsf9ZsrMZE9e3zhJBdvvjwElFF9SlT3mHqe
   2f2pbMGFnXPaTyLqm7b5cuUVT+pADMH0wFZaIErfaIWl1XfzkYhkcDYXs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="435822392"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="435822392"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 23:34:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="5576716"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 23:34:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 23:34:19 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 23:34:19 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 23:34:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwMJxT9Bj+u6c0IRG9Ef3QyZ9kzmFOM0/NYApQiwT+oNf/txHEVbQtmvxfBGlqf/ecHISV7Ueu4oqn/BTzL/vv6q15YSsav+vb/m8Bo3n1tNTeMhkzwvkJ2+RN7ps1hrNALt7Lz/PAVWpulZ4xHwvU68qrXKiRUz8UZycj42lhxhBGP/IIWw/46W0HvRNkBCSooRqISSDONKPKvw1XTc+R/Q7wk1F1EpeAeDL7G2yYzCda+Kehm+rC6Z8xiYKOTXUpWcXtRZrNQ4zmjHVMo93c61xsty1inGppvvhExV2fu5bfZwpFgaOAcfwittxTWkS1y7O+VBq8astImsnWD24A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XPNcCpZdFtQD/SqC7UyljfmmTKRUeTRfJmxgVJz3rA=;
 b=ULawBOlz57yEcYKvmdAsZm9M+1jEXwHx5rYOnJsKJjYYMFaal6eGAONqfqhZx9mQF/JdKYsKOvy15BrznhuTtIDSWchmaesalIYqHxpSKjFWrJiXdaH4aS0WvZSCIvxcma54OyA1Yi0RTu9bcmj6X9PgZY8gs1utrfw89ERhuW2iwPwL1Vm4hCGkHYATRMK7Ex0e0PrYkUkYHizUDzxDXSH8gGqGZPXMXDfRuc2lx96iZ0VyO3nI4v+7JuUoaBpHOQQoUoGr1qIFYOwcIV2Wy8GGaE6majb6uk+O6fB6Bj1oOAaPWuf9RtAAVPbvLh++pP1Q/i/vN44XTKYsecPxow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by BL3PR11MB6507.namprd11.prod.outlook.com (2603:10b6:208:38e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 07:34:17 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530%4]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 07:34:17 +0000
Date: Tue, 6 Feb 2024 08:34:09 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v4 4/5] selftests/resctrl: Add resource_info_file_exists()
Message-ID: <5b5uw43oj6i3sw56xocsqkvvqv6vvdjitekq3koou5oaoq6lf3@irolbzyiljbs>
References: <cover.1707130307.git.maciej.wieczor-retman@intel.com>
 <9c38bb317d4246182f87e376926b61adbb7e20fd.1707130307.git.maciej.wieczor-retman@intel.com>
 <17fd1cd7-6b52-4c5a-af6d-2a2c0973cc58@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17fd1cd7-6b52-4c5a-af6d-2a2c0973cc58@intel.com>
X-ClientProxiedBy: FR3P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::8) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|BL3PR11MB6507:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc725af-5ed6-476a-85e4-08dc26e60657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YF3fu4U0kVeROc6CkBryad46ru7T+3K2qIljJjDc/p02jctxPEnWqrTIe38SmGi4rzL7SJZzsLmRx+f29xi4ojUC+Ksc7gPe55KsB+BjbP0EXSWZ2YAE4/0r/ersPL44AVhCmJPpgvmsVQSyLCbXw/1FEXxdIQkGqrZwfsVDlmBlqUckZ2xRh1Ls16r0IkEOHOf/aWbU//mO/Pfd4LvPmwqbps4XOWGskSrOJIhPSwxEwCuQ37BXmhge1FjPY5xmCuRDxcboKg/Heg0FANhUe/ig3VIukUgdJ9hxLKY8lbR5iJzllDddJSx79CGhmhtheP1KBVysEOah1cXmBEwYRAw1PvIc6ujL+CHQSAqNf6a7T/jVkghC9T/d0Bso0H8OzunRO4k/+qSydnv22LBWNmvLHv2+HsmukVpMtjMkhmulrR3/m5AxPsAi5btCz4NNUAP9uOp3/orq4glwuP3hCsFiKsj37jp7dyZW0ay3NwfvfCh2gg30CTavmkqWA+9WnilmuAqbD9uJgKd0eSANQE6E20qLghVvT/Nu3AxTCsCZZjdiJGzkXvZYe0BBbP79
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(396003)(136003)(39860400002)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(82960400001)(38100700002)(2906002)(83380400001)(66574015)(86362001)(26005)(6666004)(6506007)(53546011)(6486002)(478600001)(9686003)(6512007)(66556008)(66946007)(6636002)(66476007)(316002)(41300700001)(8936002)(4326008)(8676002)(6862004)(33716001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ZsgTaa7DOun53Hqxa5cmxXJh1CmFg2BswzyJCFDC/k485GcmmDUax8NOZ+?=
 =?iso-8859-1?Q?ZYGTJpaegZRC1nGRFPUKNHLC7XMkXB/Yq/G3b3TTDxittPjK7RBVGaGj4o?=
 =?iso-8859-1?Q?cntpTr3VFy9dwpaydhOUiUKe/SL4PRuFiIQJlD+Ly8UcS0sMHENQcnGoAg?=
 =?iso-8859-1?Q?aSB6yiomU2175yYJ3FsU2lwOxlQ50WlrYLSdPjQnwaw/SyLAdU3Bu8ksVF?=
 =?iso-8859-1?Q?eKbGNgxFtQI8EF6qr5uAmaZpOdhXdzY7Sxi790dx2kqRmv249RJaMCMCUl?=
 =?iso-8859-1?Q?DbJp9lbfZw6uR1A78V2lEGDLSfjnTLnoy6XtfXFH0WRm03txSOvNmhGpfa?=
 =?iso-8859-1?Q?OEKzuG38vLtAa/xkJ/h6PDy8mCXK7osREIW+HBmeO+1OWq9Ke15J393sVS?=
 =?iso-8859-1?Q?318T2URmMrPBe+7Q/FNimXDHKAuwvNx4wPvq8uGnxH+DOvQhQgh2zcw4MI?=
 =?iso-8859-1?Q?/rEB14AyAo/2tGrLPrwcoXVS1wF6LFKSJM0gKPbvSdgNAV7Ui1pvwRyhfm?=
 =?iso-8859-1?Q?SnBCqlto9JvG1l0vOn3EbTmNeT+UQ7vxBSplbotM1GncUGcT2OTK4hcMWH?=
 =?iso-8859-1?Q?3l1natrAxC3Mm61IZavbdcPhQT4PrIZVjXthKu47arJ3sR3WhL37b09wi2?=
 =?iso-8859-1?Q?BkEBfOaVYyd3uMzgdHcg/uU4yHGFWdV9WHPse/T+Xadx44o0kfY50c0GWs?=
 =?iso-8859-1?Q?Mjy860qON4jnqrkyH5KlFJzDYGfyyL1SYu6BKqkGNcbcuYhsu/odgJG6X0?=
 =?iso-8859-1?Q?vBkQLw88QJPq14vC3zxe5RjPfi2Xb1ZjA02NbYHgOr13JPeutSclyaA0yf?=
 =?iso-8859-1?Q?+TkGAzirz/PG89qut+n+EHdslhuBWJxdYGaSvU9sPU/3DNZ9Je+u2qJHaU?=
 =?iso-8859-1?Q?bkLLsGIXi8AkagZ6QHfrp5zpCYJ71xwJt2NIy9cd9Jvgdc+SpzJVkA8rIo?=
 =?iso-8859-1?Q?9w+dmzQoh5K6/gPWJ3ybmopERm+Gqtk7JD3Wd6SnMLlyeN68c+5aRHVZ2y?=
 =?iso-8859-1?Q?KolXG2RclrCSaZGem73UC1shx7GFe+tczaE6YH9Bu6WDRkeRRu12k7BUdl?=
 =?iso-8859-1?Q?TmgrpbDHmXRAyrMZy1a6qmwu2UJziAeBmtp0871cz8uKPStHnA4Dxu9qZh?=
 =?iso-8859-1?Q?t7tB+tIUiyT+t3f0KX/rp27L+3zII+TPe7rZWsq/3DdDSm8a69pkJ2M0kL?=
 =?iso-8859-1?Q?yWxDRghcAnvbSiyPUprTAhjFWijDs6qu8SrouwYqGOq+nd/xOme/4WQFv5?=
 =?iso-8859-1?Q?Qoo9VIpjFKFNmGPnONp+YjhkNZM5V39K62ulAI1KOfJ1166TpFlImHaFGq?=
 =?iso-8859-1?Q?mXJiku9oAn1ILMvtUqL2uK6/jA98gh26PifJsoXLWdE5lglQmZiiFYlu7v?=
 =?iso-8859-1?Q?hocoJf/qvqQc1vVNSufYP+mEP+yxKqM2OXxtROjWiCSRsjh3sYs92EbHl0?=
 =?iso-8859-1?Q?QiFBeOXrQzRD8Zdx1gVx0V1ZEMNRuoxM/cStRAdt8JtuF8/K5m+4I1qsLb?=
 =?iso-8859-1?Q?2U1zX7SfiPjOoX53WlSBdB3WYclUyZ/ZMXlXegiK6xjtV4shmXlotvp+Je?=
 =?iso-8859-1?Q?TMwv3xPSG/393nAKs4/md50iUEHha6tuLN7Nf1zMGYh8urOok8FYsZ7PGN?=
 =?iso-8859-1?Q?R2a7qLGQt3SvwPnfQDPMmGOhaitv4oge8I+Td9xlEMuk6yEAqAIb/usr8H?=
 =?iso-8859-1?Q?+fb/SiyxRhvX06OqKWs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc725af-5ed6-476a-85e4-08dc26e60657
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 07:34:17.5902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ORH5s2FQKGMVH0KpasdCukX+8mQfF8nA0S1kLtPiWIz6VcxgVK1w7P+wGpVbi4VNMmfxofDbCo0iSpc+A43FNg7QIKoiglVqMN5lSeEkOiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6507
X-OriginatorOrg: intel.com

Hi Reinette!

On 2024-02-05 at 20:17:48 -0800, Reinette Chatre wrote:
>Hi Maciej,
>
>On 2/5/2024 4:08 AM, Maciej Wieczor-Retman wrote:
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
>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> ---
>> Changelog v4:
>> - Remove unnecessary new lines.
>> - Change 'feature' -> 'file' to keep things generic. (Reinette)
>> - Add Ilpo's reviewed-by tag.
>> 
>> Changelog v3:
>> - Split off the new function into this patch. (Reinette)
>> 
>> Changelog v2:
>> - Add this patch.
>> 
>>  tools/testing/selftests/resctrl/resctrl.h   |  1 +
>>  tools/testing/selftests/resctrl/resctrlfs.c | 25 +++++++++++++++++++++
>>  2 files changed, 26 insertions(+)
>> 
>> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
>> index 4603b215b97e..2b9a3d0570c7 100644
>> --- a/tools/testing/selftests/resctrl/resctrl.h
>> +++ b/tools/testing/selftests/resctrl/resctrl.h
>> @@ -138,6 +138,7 @@ int umount_resctrlfs(void);
>>  int validate_bw_report_request(char *bw_report);
>>  bool resctrl_resource_exists(const char *resource);
>>  bool resctrl_mon_feature_exists(const char *feature);
>> +bool resource_info_file_exists(const char *resource, const char *feature);
>
>One stray "feature" usage.

Thank you for catching that!

>
>>  bool test_resource_feature_check(const struct resctrl_test *test);
>>  char *fgrep(FILE *inf, const char *str);
>>  int taskset_benchmark(pid_t bm_pid, int cpu_no, cpu_set_t *old_affinity);
>> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
>> index 0cfec8bb23fd..6a3082ca58b5 100644
>> --- a/tools/testing/selftests/resctrl/resctrlfs.c
>> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
>> @@ -760,6 +760,31 @@ bool resctrl_mon_feature_exists(const char *feature)
>>  	return !!res;
>>  }
>>  
>> +/*
>> + * resource_info_file_exists - Check if a file is present inside
>> + * /sys/fs/resctrl/info/RESOURCE.
>> + * @resource:	Required resource (Eg: MB, L3, L2, etc.)
>> + * @file:	Required file.
>> + *
>> + * Return: True if the file exists, else false.
>
>How about "True if /sys/fs/resctrl/info/@resource/@file exists, else false"?

Sure. I was wondering what the best format of paths in the function comments
could be and that does look very sensible. I'll redo the other paths in the
comments of this series for consistency.

>
>Reinette

-- 
Kind regards
Maciej Wieczór-Retman

