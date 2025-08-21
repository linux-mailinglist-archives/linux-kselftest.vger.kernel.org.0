Return-Path: <linux-kselftest+bounces-39427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1693B2EB40
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 04:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C293A1CC350A
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 02:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D3A24A06D;
	Thu, 21 Aug 2025 02:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P8oG4PeY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C226246774
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 02:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755743542; cv=fail; b=Gab7rScSrwRbuGjiqiss3UThw1i09586YZBXpiQQfLJ9xRGEaoegCblv9h3fAHgjC4zekG9ZILbAIDy1BA1h+hLC2jjEehscum8kmNXclBchFr2ECPxe9paH+orjnYSuA9KQU8WxiVKtCN3iXYxnqSPDG9kHdHvp8uM5zTuUmP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755743542; c=relaxed/simple;
	bh=qKEtIIeHsNjwumhl9lLndytk+LHUAW/tnM2N8Qe52Bk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=qMIn+2NglrrExqk6+yN8NLtHDvVtQvFmKgEE+dgsjOFEqVTToXB77eKNGiyf1QzY8ubI6clh7KHErdg3LAAhwr4cjo4q2lu+91xvtnVpSwD/PGZG1vpxGo1LJhh+1aGbTrMkVpkoT1BqFiqmF/ru+DIxRVWooSnZLE9hl1Hcytw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P8oG4PeY; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755743541; x=1787279541;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qKEtIIeHsNjwumhl9lLndytk+LHUAW/tnM2N8Qe52Bk=;
  b=P8oG4PeYMcYvRh+ZgqJmolU8jeok1o6h+7eHA70ycQSxxF8pdnTOIvO5
   sG8k9d5wcDM6Y7KScuUJJrxXy27+MAfYU+NEJsHq5tbfAZTiEE3e+FoGx
   Lg5q6yNhd0RZ5/9+Bcl9EPhtc25qunoCzE/fOInwVD47VoljyDkJRYwHh
   p+7M2+Oo+5E/S+pnaJuHjl3gO9PwCp28d2kzsv9tOq/qjx2W2ktN46PxJ
   WwQaXK0+Lgg9RPbiaBnNa8i/XGBAGMDv2Ggk+YiXl8emBU/AMDttZwig9
   ck0Q7zpcqzvDKbiX1/KA8fTL2vUDSaCf5GkwYZYarZM5CguLYV2m+Im0Z
   A==;
X-CSE-ConnectionGUID: Ynx/50TGQYC10XoR3I/RZg==
X-CSE-MsgGUID: 9inEqU2XQa+F5SpC2muk/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="45595304"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="45595304"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 19:32:21 -0700
X-CSE-ConnectionGUID: 8Sr5W1KGT+G6X2iLL1itlw==
X-CSE-MsgGUID: TTGlEzljRxu1TplQJ7ZXXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="168220140"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 19:32:20 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 19:32:20 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 20 Aug 2025 19:32:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.54)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 19:32:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OewNS1S43MShvW7fG0ZIvO4QL+NxUA69lslPHY+SPulkaWS/ujz4pJ+3zRhEdM+mHKIuRTaq0/yc8Y8ihtbC+0x83FCyBsHPyzZsGMItSa6FJlxxi3ORLHx0LCiVHMWkmXGWMwAjGrQW5mrDaBGajmN/sPESXdKLfIgx+xH9lx231QKe3UuNXv+GquF7WGyYH4ohynzfS3T09CcUWpdsddDnkT9p6GRXtGARlf+ggW68Iv11qmM66ZKuLqRZ28eZTuwo97CJsINuBa8dAnT/pbJjub3zSI/dV14dQShguoqivOtHLIR33+k6g7SEEVTfOXp4/PdDM5BmQWILt4NTRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aII+3pbNAZ518297r5KU+O6qK7VJf6JhUB75HMQJzgQ=;
 b=c1fSH/8AAlkXuKkqRfm4xty1qGpwwWjyCXrhTj6KTpkFWFG2cNJ6pDxaHBgR/YQx57xlHs0V+l4Z1b0G34LcgAa5JIKaCRGN/zZvwxZoH0zHOC4K66Ldl8oVBCWu99OVCGTiWJXM4u+O/M33DhgoSZnSAURZKCERqE/VLISnL2xY8E9EfouNKDamX2Kp+Y3PhCqYR3rafvlYx0RME75CzE9Zc6xxpOWwSIShj1InYkxP+v9PRetjHqPNEPXLNFHAjm+y9JaxCvTAPcX5YCGGOYsK43PKfHqZjwj7NEfYK6mY+Fyn33WOJ1GjEc3A83LtsortpZvVw61lZw2iq2tjLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6213.namprd11.prod.outlook.com (2603:10b6:8:ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Thu, 21 Aug
 2025 02:32:17 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 02:32:17 +0000
Date: Thu, 21 Aug 2025 10:32:09 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mark Brown <broonie@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-kselftest@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [broonie-ci:selftest-filelock-ktap] [kselftest/filelock] e5f8cea6cb:
 kernel-selftests.filelock.ofdlocks.fail
Message-ID: <202508211022.50b4caaf-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0024.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::11)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: 216f2719-e87b-4dcf-1489-08dde05af260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IbSCP2YPPuCqArgc/bskHeY/1J7AMtesApjP5CvEXjI1gM2teYVIbyg8lyjy?=
 =?us-ascii?Q?WhhMGlg90mYzMkHDfvGmDqqPCdd/Xfbi1tuMY7n7EOVoCq+yQsy13R68XUpK?=
 =?us-ascii?Q?MQECILrNs8ezhnUOUVmA17VqpwqVAz2w0vPHczv6bcbfvdBpyukJ6iUig4FG?=
 =?us-ascii?Q?al5qU2r30fqYcOVCNNWuvSTp5gq581HRe1wK2tnUyJEGr30SuRR3SBrAW+4l?=
 =?us-ascii?Q?N6ZCFd+tXcgejsIAnIn3UJGes6xMqQKjzZ6WMWwDMeSKojPxPf792k5b6Q7I?=
 =?us-ascii?Q?ALUchOG045bfZtERQIwU7V1eqKmJqM8P8ACDW7dtytz67yPJYpAViBEufWqM?=
 =?us-ascii?Q?3c8afJ4jBBl7Y2DsZmftdZ8ZVVLqetRXFvNShl1Z7WR8vs/QFyKvekKKo9LU?=
 =?us-ascii?Q?/V1h3Zo0gsy9NwIX1AybCGCP1F7v5Ld33FFxfZ4ZH4YSa9Vjra3f5h/1thAF?=
 =?us-ascii?Q?3trv43tLqSIRfurAdh5rWQhMOWXaB6cjItfZRE8kZctk3DGhgMVhLTALGVzW?=
 =?us-ascii?Q?tphFgV4y4KTabS6GikFRuvlGKjVJLH9RTYFFi/JgfuAIpEg4NYBi/AyCGZaR?=
 =?us-ascii?Q?TQWIL+/LZA2DG7LbRpx5NZPQvhhbSc2D/Xaz25lwha5SAKVAtyjZGaWGUgA8?=
 =?us-ascii?Q?2tXms6Pdbdrm0u7cVS3ZeKS6ZGJbrEM0JUPFvJwDn/xdb+H/8iA9wassMGBk?=
 =?us-ascii?Q?88kLmxNOn2MnKoK4AH/yuSLwUST+xTAPZvhwUtuZp+VSLJnOnX0XP/IOhIsK?=
 =?us-ascii?Q?6uxEWFdzC9u1nvq6ZQtVBWNPuvIWzOs58boPGEDZDGtQXvUg9liS9q+Am6Zk?=
 =?us-ascii?Q?EOoXtBtWOFcSk9qFmZ+ASRSatKp6T/G430hZE5/z3UBG1OeUscXGOKjQrjd7?=
 =?us-ascii?Q?rZhu9vEtsyUXlYVsCO6WuoHJFyMrU+MkGloOBpA96fDFEyDjzqX0FEpFID3m?=
 =?us-ascii?Q?iKcYNU/3cS8YsxYN8r0MkhqCMl6WwVkB4zn6BQ+ZWAhkdHljRutSSAUVQmm6?=
 =?us-ascii?Q?lQ27weHUtnJ7lu5YONkZMTZDxXPr+cdL0zrSEX8swijZtAKPkVefgYL8r3YL?=
 =?us-ascii?Q?q874qhdPErxOJPDixz5jf0Saykmi5opq4cZRgIgrXXXH2EAzqM8LwRIJC9f0?=
 =?us-ascii?Q?KtjCzOX6jjqiEV/Vk6rUbe09QgCwph8IzKgTfHthOMSiKhuYnZcJ17fqyFJv?=
 =?us-ascii?Q?zFv78wgd+StnWt+6aiBPmm3w77+eq1wFMi2sGUe0Bahrl5YXFFXw4EcUbgEO?=
 =?us-ascii?Q?q744eZNIL8UtvAeSD4LDO3SG/84M2+RVvG1epEIwE259jcZfnaEVAvRColed?=
 =?us-ascii?Q?ycfpz8GoCNKIUpwRr3sGgtFrwRdbMTEzz1MWEz7b+KGoSyDLuiRgWqIpuR3D?=
 =?us-ascii?Q?IgaTSj2rdi35lepd/emEg4R2eR0x?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hlJDkk1C38MRNPuE5tRNLuH8XQzdIU/ZUgyCJ2qxjeM48n6bUjSlVlnyfCPG?=
 =?us-ascii?Q?1NYyKopYZVhN8FXLCwC8WjMGxrL76wFmCpESiVpGdvOhjTnHLtyuaAyumetM?=
 =?us-ascii?Q?O4iwcWkuBkLeEjPQB5xfXeUUmT97jMCDNaYZOWRto/VaxBSA8RbJWqzGJzI8?=
 =?us-ascii?Q?lGpN+qmRlIqNC+fdBLb8oG2rhetiULGR07kIx6mVuI5wbWVJKrThVdNVcKIC?=
 =?us-ascii?Q?pH2o61W4WSW6IbseCp1pLFBcYmAq/3pneJ2gWC/sNiXaxSaHc9IhUhq/lUVi?=
 =?us-ascii?Q?2TRDQUfRDcdW+fnRbXjuSbsxV6T+4iEzs34qbpIgCOGQcM8/yFW5atG6olbE?=
 =?us-ascii?Q?QfyCus6rIuCzikKX32fmDp21v4qo8r7sV5PCd47FWshICgebhm1jWcPh0/fE?=
 =?us-ascii?Q?9I1+N1R8+T+6tFA1GPniPVpx9fQ7aP6kg8pcvfbs22QbOXvg+Sz90vG60Yar?=
 =?us-ascii?Q?W1vHzWD/cUefofSYkhicmQ+nO8E6E6Aj/jEM7b60aH42KeU6onGCIjoS01OO?=
 =?us-ascii?Q?TpDwpmwXK1ZHr4cokiCUnAE2E4dJ0KvyGekcsmdXbnH6cwbp3a1b9WOO+coj?=
 =?us-ascii?Q?ZIhxIyW2wgT0Wpj35AL/Ycp9Ndwe1AihpEFCnDkb7fAsrB631S3T8a4ICV6s?=
 =?us-ascii?Q?ZwxESmKvm3ta5rtil66V2CgzmrruMHhCmjRYpqAyukyt88Bg0aoH/jg7kcPA?=
 =?us-ascii?Q?nFWXO0jN8PLCqIk4jz85wCwnpP5eEIL6qcdAH+TzgnzPOEUYf5BQWcKpLKY7?=
 =?us-ascii?Q?6J8oq6MG+Tj8J0cGgGxanC/J7HsjxH9p85Pz7ybye23TwvB7Uw9tkdYLxrUd?=
 =?us-ascii?Q?ziBIG1UNVu6DbUX+o/F+ujJzIjxb69XWhDWwPvtZUrk+YHmSLRD78MRo7A59?=
 =?us-ascii?Q?fNY5Nd109BwvC69xrk6FuctAFptK7dkEwhxTgNn+JfwfNP3BUp70FbT+Uwyj?=
 =?us-ascii?Q?f0JkljHgI3iJhrP75iaIwfWUH5x/ad5YPj9eDWaUlMsDq/qnNlGP6+4ou+Jn?=
 =?us-ascii?Q?G/GjzeU9KLJO6m9xAMLmoXHAimhGOsD2+fnTwIA33EqOEm2y5XTbbeGzphMV?=
 =?us-ascii?Q?7xJWg14viiOZg9pGiNHdD8nVHI0/Rsjoede2iYsE5ubKHQ6AA39BCpQMHKFD?=
 =?us-ascii?Q?ildVOAcT0GkdOutr4ipTrjd85/i3gBjGe6/GRyf4g773X1NxoTqbfAMXmjzu?=
 =?us-ascii?Q?qptYXf69hR+cZLARfhAWCYjXWvcn4f0x886HQs02tBxPsS3XaRa2LOe1S0gE?=
 =?us-ascii?Q?IrtW96GVDvuoDL1w379jRtD6OfMyD1RE/Ww/c9+fX2o5AdEJHHuprLs/oV9U?=
 =?us-ascii?Q?bV+jEuEsnpvGJB6TQniKbP6gz47kDOyMYlL18BeR3cS+cWZi2PgQqOJEbMOG?=
 =?us-ascii?Q?+rTVkXbH43XsCTf+IbPrPPjcHq85QCzy2HCMkm48BwFy22qHPZ2cNUOkEekc?=
 =?us-ascii?Q?bxpPaRvNE5eT751/vhqFIB6Ysv1iIKv+z6Kv/CGByK4uUNi6uADXApP7x811?=
 =?us-ascii?Q?TvGKIk4UaEzN/57RR1UumgVMKnulqLeHn8z3aCzcG9UKO6sAJ6QUDqQ14c6b?=
 =?us-ascii?Q?3NlBROpUv16wzMVpBY/Xtsb7Mx6PPuKw0/qlVlqJUlto4UYQwRQ05G/q4dLD?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 216f2719-e87b-4dcf-1489-08dde05af260
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 02:32:17.5849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNQ+tNrfN/lbheAmEMAoj1BYUjs6bLHt7ldxMhPPFd/goULrtBJbcitkyZ4tzEsXRwM8hzMxAHj5z/J13Rz3Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6213
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.filelock.ofdlocks.fail" on:

commit: e5f8cea6cbc538442951308fa36559ae0044d1f9 ("kselftest/filelock: Report each test in oftlocks separately")
https://git.kernel.org/cgit/linux/kernel/git/broonie/ci.git selftest-filelock-ktap

in testcase: kernel-selftests
version: kernel-selftests-x86_64-8d561baae505-1_20250817
with following parameters:

	group: filelock



config: x86_64-rhel-9.4-kselftests
compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508211022.50b4caaf-lkp@intel.com


# timeout set to 300
# selftests: filelock: ofdlocks
# TAP version 13
# 1..4
# # opened fds 5 6
# ok 1 set OFD read lock on first fd
# ok 2 read and write locks conflicted
# ok 3 F_OFD_GETLK with F_UNLCK returned lock info
# # F_UNLCK test returns: locked, type 0 pid -1 len 3
# ok 4 F_UNLCK with len==0 returned the same
# ok 5 F_OFD_GETLK with F_UNLCK return lock info from another fd
# # Planned tests != run tests (4 != 5)
# # Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: filelock: ofdlocks # exit=1



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250821/202508211022.50b4caaf-lkp@intel.com


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


