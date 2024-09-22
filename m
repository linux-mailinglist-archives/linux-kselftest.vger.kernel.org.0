Return-Path: <linux-kselftest+bounces-18195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF9B97DFBF
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Sep 2024 03:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42248B20EF3
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Sep 2024 01:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADB1192B66;
	Sun, 22 Sep 2024 01:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LJc/fCo6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABF718784B;
	Sun, 22 Sep 2024 01:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726968237; cv=fail; b=O8FU70sZ3UGBc0mAnwFGDRw3+S2V+wNtQy8+jl8yiUqjf+NVaFCExPpMwrt4qkwWCUjjBI6U0qTyUJWbriMQY5wGWpn4gqDSixisr5gIoe9TXMueMRuYf48M8nNr+QtKJ/+HE5Fyexdath8eTUkdRskF3jBoWZOoAMHczj2yBNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726968237; c=relaxed/simple;
	bh=LZw9cqAC8qK2PXsE/5wpXXkcVB18E+SUnUFMJ8F9URo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PCa53e1X32H74LWlsX5x1Thv0p+mhicNYVYX00mHx8NCLgqo6MQQf5IKVgLP0cZAoe23epynR7z1jng0RvJ5klSXSiqB1gpshyYCBajlMVjrtJOX6rXXfGn5zWMle9R7Xhje+SUgJSaLA0qpJnokfFdAb6k78d6WtFGrM5EEEMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LJc/fCo6; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726968236; x=1758504236;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=LZw9cqAC8qK2PXsE/5wpXXkcVB18E+SUnUFMJ8F9URo=;
  b=LJc/fCo6Qm4BnO6Gn0GdsYsggVH+kkMc7Bq95j1ysdd7zLsDDaYHgpQL
   6/wmWyjzMUqDkJFCqXT8l3lNf7lwo9k/XG+N1i6l8zrL5HfCZ/YzmHnyy
   09GSRWexVzvCcErlN44XqDTLLFmt9TXbUXUqJ9DV2N393IFLTxd7McRdZ
   lO9ogVohbtetp9BVNlLTij8MoOnN+qfhEhMDAufqYEhHbidotYslYF6Yt
   SBRvXOROYgQIqr6UO+YzsUHfnHLFo2Uv6Ge0huAam4fR0MoVNIj21YFEo
   5MlgYO+0ZsRsv/eMnDCVJ8poLGjIgKqpCEbVN4jmPzXNvi9xMfsa+O+dn
   A==;
X-CSE-ConnectionGUID: k90hipTiTK+KRooBQkfQIQ==
X-CSE-MsgGUID: 3LTO76NtSourYadu9ppdew==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="29730713"
X-IronPort-AV: E=Sophos;i="6.10,248,1719903600"; 
   d="scan'208";a="29730713"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 18:23:55 -0700
X-CSE-ConnectionGUID: PQyzGPrsQ+CAzWZFtEaetg==
X-CSE-MsgGUID: 4ycem8GIRdWAAO8OGOvKRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,248,1719903600"; 
   d="scan'208";a="101413914"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2024 18:23:55 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 21 Sep 2024 18:23:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 21 Sep 2024 18:23:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 21 Sep 2024 18:23:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGpk0p0hNqCEKXsHFJab7ny0B9rYZtJICesmWaPHPdg+6xvyEi/BSG13ADMCDbZRG9QLENWnwi3/QJGnKOM2Wu82f1eX1JVSMzEvm5U8jRGiXubR4xyv23iPLyj3iDc/N2TUJfMfKGUofPfoMGjrfSXkoXtCufTcu1VfIONBBJ7kFCzOauHuz59qV+S9eLRzK3fuawVAWPpnQSodtUjqtT0WiZcMNxF9x1fxXwQCqpfasWFgwErTDctyhhRkauhKGzahDTnNWw5NwXHm2G5uB8GQad/MaQHGghDxTnmciia004I5nD6oO3oVBIB33n4wTjCNd1+NARiBPqscbN1aPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRNq4kY7g9ZFt5dec5I/7U4dRZUTxiWyenDsgCgn8Hc=;
 b=GOmjSJTXyqjVyA8uLxy0+Zpr+5EJKYGGY++qb/OnvBUwHa2Ge+/XfYOW20H3FW0PIDXvWfffR7m4ROuEzRsxHNt9nBJB0fuz8d7G5L6wNKFYgisuQd6qm0HSP/yt068bRXOL5oZ5bjrw9KohdbGI8qQec5ASqgzKwJaFAQcslA9lm/tUpVvC1Solja6rKQLFOxBEN0YqU22IW9CsoOrYynn8vIqtxtf78a3gsU2I8CoRsfPCW3p/OUW1puZK+HO+u3z4bUy7KlGuSdeAb+GWM6mP6+46i5A6q5OnT3TLumm3kB11npnCSqvCeTW+DI5Yyw/4OFhT7ZJ+a1M6k0Bqrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by SN7PR11MB6945.namprd11.prod.outlook.com (2603:10b6:806:2a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.24; Sun, 22 Sep
 2024 01:23:51 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%3]) with mapi id 15.20.7982.022; Sun, 22 Sep 2024
 01:23:51 +0000
Date: Sun, 22 Sep 2024 09:23:38 +0800
From: kernel test robot <lkp@intel.com>
To: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>, <davem@davemloft.net>,
	<Liam.Howlett@oracle.com>
CC: <oe-kbuild-all@lists.linux.dev>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <oleg@redhat.com>, <akpm@linux-foundation.org>,
	<axboe@kernel.dk>, <brauner@kernel.org>, <mhocko@suse.com>,
	<alexjlzheng@tencent.com>, <willy@infradead.org>,
	<michael.christie@oracle.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <anjali.k.kulkarni@oracle.com>,
	<peili.io@oracle.com>
Subject: Re: [PATCH net-next 2/2] connector/cn_proc: Selftest for threads case
Message-ID: <Zu9xmkQYUkRhSx9k@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240920000933.185090-3-anjali.k.kulkarni@oracle.com>
X-ClientProxiedBy: SG2PR04CA0161.apcprd04.prod.outlook.com (2603:1096:4::23)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|SN7PR11MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 46dfbf60-1a52-45ea-05fb-08dcdaa53759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z6J41HcguVMp5A758tGc2y2lk0vuUPCUsYTxyukhg8FHSD3QH4pHsqxzVapG?=
 =?us-ascii?Q?RjWBkeeOPllEov4NYt9p2NQsp1xnOH2MtSGOw2fevgiQ5inb9/CBm1mKqw7A?=
 =?us-ascii?Q?CA+ycfxIz2K6zLFqgLJIn2CoYRxpzjGBJTxFY1+aeRQJUXvk/cJO6K1IS5Rs?=
 =?us-ascii?Q?dh8BE1Qzralc9z08GmI9vr1lDkRt8hsF/pJVWO8lzZl44NuuBHcg5qcHIDyg?=
 =?us-ascii?Q?A6w2QuRsshz5JTz/pNgJdX/+jicEIw3HktAgaVNuKLP41LQLE9A5BjQoLDo8?=
 =?us-ascii?Q?BWhWV5xpZZhftP0DrNHCDQis8Us7+OgCg/wiDMI1R70Iwt9TpOSspcMhG7ca?=
 =?us-ascii?Q?vUK7K3z0ijrDbPrNAOWXLBE3iIBCAEzRaw0eamjs1Yurleejhe9XHXLBQ6vS?=
 =?us-ascii?Q?Yv7qTpsy6M0LTUmr01PN35i1Y1b8jEYCBS0UdP7fAQwDEZsCAH70Ys/mqfHy?=
 =?us-ascii?Q?+pKBy5fc4JahBHd6MYrZcb4IySrTObPb1FdQl7GZwjXSiwdl8GHFgNZ6VPpT?=
 =?us-ascii?Q?JjNfcXxJDFfOUxT2zDafUBzv/1OYP/pxndbzeoenWbhjJJ7L61aCoJoeMMAO?=
 =?us-ascii?Q?DyDzDVj7ZwDq7StRInfy8nKbIlt+LMwnRqbydQ22ZsaCyRMOJstKLbsae8lb?=
 =?us-ascii?Q?6Hy6cpFxmHgt1HRkpv5N+DqRk7AXAStbrDxaU2OYd0NxsUCfGr/wWerbfCRU?=
 =?us-ascii?Q?4/LLxDMCSr283wg3zbQTfdnqeySaTqooTOUguZc8o6sumjO7asLBFHDxXB/C?=
 =?us-ascii?Q?uNIrqqJ8lGMygy5vdsmHXjOOLezEqkGyriR8MHpSIETQ4VPd7FdYBfnnH/gj?=
 =?us-ascii?Q?/WHEljmduv9U4K4/q+EXVnQmceuJFfpiIEg9wjI9yvEHUqNqywJoCJ+VDBtC?=
 =?us-ascii?Q?qATwP9u+2SwSk9lz2epbWlMM/ib2TrnEyGHp2zxaCcZWM3JTszW/d45uJ+Y0?=
 =?us-ascii?Q?ygeLBrtbt8VjL86cqYDnL0Tux9E1MgZKvnLcoFwrGGeQG8i85lN0noHI/Eqg?=
 =?us-ascii?Q?YVxTBp31Sl0dxXYF4awvdCFgdGSbN3Xl4uQ1rjPevv2HoLofo/e3FxQy/+rG?=
 =?us-ascii?Q?Urd/t+R7+tIk5DMOUoYZLGqCzAGOAKrLgXKj0Gb7sG0ddZ5VzMwJTeWb1mil?=
 =?us-ascii?Q?IlgyNvI6oE9RdOa9WOz362G81tyqWXL72JmhVp7eJUgg5Lf/ttnbvZcunnMC?=
 =?us-ascii?Q?rd9OphOMFaFKazsqS2JgTlT5otRfwSAaA3Jbk1nZtTmR+0yG7tQAsWEvn/zm?=
 =?us-ascii?Q?CRcAYFqBO/VlhqZWiojP1KvmJv6KZcDZm8oRvMLiM/cqk4/qsqbwfYb/4BbK?=
 =?us-ascii?Q?hc4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oHNQLH6Jz0rizU65j74RDiz3Fbl3VhH+NUiW8tMR4dl6kELjxkF9arC/U97R?=
 =?us-ascii?Q?JQRIUxyWPeQtUQr7MQ0jkTVJwUW7IMMSgr1nOICRwzWQo9EXpickwqCEHnxk?=
 =?us-ascii?Q?lbpxRLL/rVlcJoFAD7HLgTMmqG29TtsOUgfe8RV3SzrQHnSj7V0gNyvyXkIa?=
 =?us-ascii?Q?ek56VrqlBTBUyyV254c66uvlMrYhYIak56rO5DSVXEy6J56g+lpcu48zH9X2?=
 =?us-ascii?Q?rJZWvb58cMNRNtzmchjrk5/KSfoezwRCaFohk0f6Anxx6QDWfEbUKdMXwaQS?=
 =?us-ascii?Q?K4EWpqTaLqGhYnndB4np/s3DaX8ztlohyuc0ekqam7XGyWPcwdHc9Ay+YPHA?=
 =?us-ascii?Q?chCuAodoCSYkFSkPVrDTcmEvyNTjDbSLjwD5lbMIBO6E6X/E8D1Yt0FqCtjb?=
 =?us-ascii?Q?YsJosKlRMHOAVCc2UGHpvG/XqfcYnWzXqi4XJIGwtqvf2lgzV/+i5PkBxUrM?=
 =?us-ascii?Q?8YnVztPiqgVvo89yEsub9s692uwN7SfIZCE3+t6FicUF3cYb2SCIV4eM/oXZ?=
 =?us-ascii?Q?7Xb/XDmEFmBInIJupJTL1cVdQGAr1vSXBOkZw7IOBXMcHxwM84oe2F+jB7pv?=
 =?us-ascii?Q?JGOyngBesO6frL4dwnmxhRQF0wkc4iBvgwS87SwXK+bwb56dQ9eX6nqY83PD?=
 =?us-ascii?Q?wVonJjp4m/yvXhjRxasSOS65rYO32FyQQiVFjfn64fBDb1HPOnDQKIlxTS15?=
 =?us-ascii?Q?BVQbfBlvzFl5x0n3eQ1s1VP81zqoxJniTjcYYmKLxMNtgsyt5G8oTPSoPo/Y?=
 =?us-ascii?Q?eBpP7S4sY3HoTKcH/RQ0H5RiGVi5cQTGN8yYDU/vhJlt1pILWoBTKV1XAW29?=
 =?us-ascii?Q?bYaNb8wN0n1IT5FZUDxPNA6Tc19k2NYMFnfDfMHmUmd5a2TNrcyxhqGN1tyP?=
 =?us-ascii?Q?MGIBqNQ9MRq3RDN+ApZxP5UIOfeFy4RWhGx/EM16rZKIli93h+xQg+RFijNT?=
 =?us-ascii?Q?uScE2pggF9nPMRA96hYSsjX0bDTaro3NfunO1TtVKkreL9im7LxXMLoQIZVl?=
 =?us-ascii?Q?DZhz31OR+PRqF1yu65PhA4kuMGEAXGGb8qElg3ZFMPEYw5A+Su5ErczAP7Se?=
 =?us-ascii?Q?7mPK1XC7/qagwY/9BMtZhITgzku5P7NrnF5PB1QL8D84oEem07PbqNP9tGgT?=
 =?us-ascii?Q?CPOf6ngIcvhJqhjI3wOQM8xNgTNDlxlaZQmN0Pkt6BC4fpC7slBaLF1EfCO2?=
 =?us-ascii?Q?5jBRmFuDLXxvwUGgDR9km8KMSZxkubkaRki827/IUCCP1iDAdt5wmfIvkxlk?=
 =?us-ascii?Q?BY0FlMD62DQ6IJ58c3BlR/Gt4hl2gDVERG/OyQ3v/JaXNF46yu8A3Ou5BJoZ?=
 =?us-ascii?Q?w2sr9d9JdVrBXAGroG/eN70LhYdU3XYTSd8w9km+FNDuFyTQGdNc94vHwwpW?=
 =?us-ascii?Q?lsUBjCirhk+bmNeSDvacwr+p9eCMNpHqCf4KGo9UCxblRIWecWtEuCnPowgM?=
 =?us-ascii?Q?Pb8qzI+AEGoSeYFxao3vYeet7tFaWI2CIHgxKkG6YqNV12YLLeW2Zi1przyA?=
 =?us-ascii?Q?k6o2WhiVjys5NPLWEZwyAvGc6N6yLsv+xbabJ5b7r8LBc9HmKI90gMEE2vg1?=
 =?us-ascii?Q?knRA0ICePrZPSPZ52AAOC72b7NH30In9X9HlDZIv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46dfbf60-1a52-45ea-05fb-08dcdaa53759
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2024 01:23:51.6939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEmXz31vJjwlDv/ixBYiMoi6YY6ctF8OVwXRbgu432DtSNtFYv3qQxJXqclaj3SEe0G1mG/BXCYu9SO7Gw+7iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6945
X-OriginatorOrg: intel.com

Hi Anjali,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Anjali-Kulkarni/connector-cn_proc-Handle-threads-for-proc-connector/20240920-081249
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240920000933.185090-3-anjali.k.kulkarni%40oracle.com
patch subject: [PATCH net-next 2/2] connector/cn_proc: Selftest for threads case
:::::: branch date: 2 days ago
:::::: commit date: 2 days ago
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240921/202409212201.l94GHFkW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202409212201.l94GHFkW-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from ../../../../include/uapi/linux/netlink.h:7,
                    from proc_filter.c:11:
>> ../../../../include/uapi/linux/types.h:10:2: warning: #warning "Attempt to use kernel headers from user space, see https://kernelnewbies.org/KernelHeaders" [-Wcpp]
      10 | #warning "Attempt to use kernel headers from user space, see https://kernelnewbies.org/KernelHeaders"
         |  ^~~~~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


