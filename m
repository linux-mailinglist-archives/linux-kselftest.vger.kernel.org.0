Return-Path: <linux-kselftest+bounces-5258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0373B85EEBB
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 02:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39A59B23ED6
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 01:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422B7134A1;
	Thu, 22 Feb 2024 01:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QRfpqNr6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645CF11712;
	Thu, 22 Feb 2024 01:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708565862; cv=fail; b=AtM1Ts5CeOMcoekPkuG76niHWp3G06oVuaFDNfN2OrwR2z1u2Srpr2As8lGU97AQZEt2WlP/7xUxTvKP2Lg5xX1vRYHtugcSqGlp6cXijduUjNdkgqB0OImWr7DFSPzemWd1pXt7gglTKeV+sqTSSV2miPRwzRSQDxqucjy5I5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708565862; c=relaxed/simple;
	bh=ErK+4EawX/zr6zhyyK7UNgFjhdY7BzDuWbCs9c4ZRIU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=suEFtz6qwHyG9PBCIhxFul61xefpfyJ13JBDkwIsiwcBdm1mTyTYCbPoGuC8VsssnbOzTyVclEW7GV7fofKeigL0fWh7v0gBzXaTDQaueKdY/dP3j2+B/JcOkLWlKk6iwMLVLBp0vkPyHhTfNozDbPmbPJ33iGldhJa9V0OQJkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QRfpqNr6; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708565860; x=1740101860;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ErK+4EawX/zr6zhyyK7UNgFjhdY7BzDuWbCs9c4ZRIU=;
  b=QRfpqNr6iPuxyjvaEBkqYEj5OiYsZwLI9VJkFivXZEBVnON1P+HX+tki
   B1g5RpOm7osJ4EdUzqaj/LxQth11uQt9jJ9avWhvQIlOp8PbumJk/Tex0
   q6t0nqc9LrbWC4MhVXQq5ri2FCG3IksSgSm9GLARBtEPMjmGmVzCE4O47
   zx9Renl+5xah+wPE2bNXeM5ZtXCHhsEbvXZGNbx0mn0RxS78frn1rcFox
   4iG99ZHIfDY1+Cx9Qw4H8k71zA7xECaYfX3m3fsRFP/mF2fc9W0LASaRY
   hSqrPhV2FV9PB1wTn7kKCe14GtSeGgr78/BXxaOShLWKtTGf4i5DwvwS4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2649389"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="2649389"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 17:35:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5219667"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 17:35:24 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 17:35:23 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 17:35:22 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 17:35:22 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 17:35:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0YYKU3V/pJnBuYnJHVClN9qndXhG+8rWrpDaEzs0c3PdwEX1gmhMXqV8AILI8u2Wm9WPQEMvGxwlC/3rha+jig9pm1g1rhUKG/avlI4f/3VAG2BYiDgDnyvUX542kgu49CkBJYwh72GyScRHOOGtisDE2GPNU/YZwU7hbKZK4b5T3YVwW3uG/rhZf1Atw/mf4R7LqAsPnNB39h4knSMNzZMTBMRcg20KbmarKAkSThMB2i/rBIUtTEa8TVsd1rbZnw4MOleEMdxF6PxaO2x7Jw0j9vO4XxPBaNOikfpuLIUTZt6K6tHQoTtV8PSkRdrIu+7YNA4KgC/3q6oj4rKgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8mwgF7TFa79BKgimT+yqv7ZS27nU10zdSbMY+F7MXA=;
 b=iiuToqaihaQNN2Q2QwU6UBS1RdalnDwxzAAtb/K3srg0n51S6VLzjffk2qXYTkEUUsd+dKZt0NAnFkINO06dfI32exMVmtaTnhJ1EqbEBKI6X0jvBOhSJ6dSWq1e5zJ+9/Y6X91JnUOVxE/ALYy/3Ue83I0vUTIybfhRTkEuwoWjykIVDlhmbeMylYcT3we+YQbEznZUZRTjNW1uego+S7lmrAKcBFrLFQ2kgrA8I1maPJlBFzbGjeS9+g5PtAuOiKRoM6I7FjIaxskHhcOTYgi7KI2DScE2N23lbxo1w5606t1tK1MA6lnrizeKy2igz5QC6LT+omZZLI34DAsyqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by IA0PR11MB7282.namprd11.prod.outlook.com (2603:10b6:208:43a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.42; Thu, 22 Feb
 2024 01:35:14 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b99c:f603:f176:aca]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b99c:f603:f176:aca%5]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 01:35:14 +0000
Date: Thu, 22 Feb 2024 09:28:19 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Shuah Khan <skhan@linuxfoundation.org>, Marcos Paulo de Souza
	<mpdesouza@suse.com>
CC: kernel test robot <lkp@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek
	<pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
	<oe-kbuild-all@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <live-patching@vger.kernel.org>
Subject: Re: [PATCH 1/3] selftests: lib.mk: Do not process TEST_GEN_MODS_DIR
Message-ID: <ZdajMy061zaqq8fP@yujie-X299>
References: <d984977f-b7ad-44b9-82dd-27aeb2fad592@linuxfoundation.org>
 <20240221220404.11585-1-mpdesouza@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240221220404.11585-1-mpdesouza@suse.com>
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|IA0PR11MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: 38248064-059f-4998-9dfd-08dc33468485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BfWLbLeWvXeJc59aUQckKaePEbaYw9Oe+dfFCkIvzqIAC5IXyLmhjXFivqCcY5xtwzx4qWKRUrpk019Mv3unnxrpPbgMWJsprReJH8SwR6QwFfn0xoEL9KdoVSgFz3ps8+QAFtXmowH0IPUqs9NpwoEtyJC5tCpzAvcWVt10L+myKgMhYezo/vg/Rlun6HFHqdVtjTTqmLY9Cl+cnSFDMxrOkBF5T8aKuhGy/LA0tS1EWtSZrtgnz/YpkJk4VHgoMSb2SBl1dzJPmfKq+NxiNiB53f9J0drfE0hBsnPIzW0LeMshaWKJkJ6xaVgfJehGlQVJ6iGdnJ6oGBn2GwOZMGObZ4FaXZ++QKTpSo11lgjUa7qzCBbeOep94ueKCq3teJsOGMG524rIUWxzSaFhVqt7c7pMHeRBDBwXZtQs4EaZYCr9WJZnIpSIZKdwms2DWMYgg+2PbgtRDOcM0qi43hVIBO9bATWWjUUJ4fPGcPuw+Ts3gD55rLaurXSxj/q5Vp6BeyTYQfX9Sa/8kpufbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1DV/KPYZe2eGA+HaK29XmoEs0c+8YZB7Nd4nvtTpebXvDvsuCQoR5rWSpb06?=
 =?us-ascii?Q?jJnaasSRPtmncyh5vOKQ1+P7R8ClRRu4ljqg2VAv8+TKU+gjtxsSXEgxT+mn?=
 =?us-ascii?Q?xKUU+2Xdv3kDwskv7T4NNlRe1gfl8gRwIaGgWR/Qet7RUYbDoq5xl+iMVgbq?=
 =?us-ascii?Q?n5Wfqbr7o7T7fa+F2AWtcysj0LEAFqqh4G+Cc1Bha9Doxlz5+baLyNssxzhs?=
 =?us-ascii?Q?nKtM8N/OpMHcOvBUYsZ/wZL9nCJ+z8RsMrrKlteXvd9edyKHqAbq+pFysrOq?=
 =?us-ascii?Q?xre3FeENb04aY0jspejUbz9XEJ9DPyrdKb2m6ie5HBhLM24fC45Sn95E40al?=
 =?us-ascii?Q?olhtg9aRV6RAVklkLFpn1DBUwKk0A2CYjSQDRbf0YG0ROQRHI1HvqBRfy1nt?=
 =?us-ascii?Q?rmRCXRdNVDnGGN05Pxd2q+mo2IjILZFOjwwza/dGsC9RtvbJ5BsbLPfbhrLm?=
 =?us-ascii?Q?ArrG59wNZXGBf5SSapABZENEbPoStsVmq3o0kmwMuXNNPJoaBnaWwdaC9GIs?=
 =?us-ascii?Q?aQwBkZsMM016TXmoc/mznslXatMFC3tADIe1qWRNhNgi4kRYODnZGKe0Gyrr?=
 =?us-ascii?Q?dgXqfaZajpWj0vb5aanQUZnSUrN02ybr9jhwoz659WNc833tS6PzJRlef6yl?=
 =?us-ascii?Q?uIiRMPnRsQiGDwu6wNp91fdZQgLX9SAoLLeuz7foUi49BZsnOZKBy/4GYgoq?=
 =?us-ascii?Q?KnUKHgbFULoPOubfmvlYksgMBnSgoyHGG/j0YPyaXPO/wtgYCku62J6hNseh?=
 =?us-ascii?Q?JnDzqWVLViQwI2nsmxT+76+wHdQopINDx/704VvNdUUbr9Dx4XjJvwkV9gv8?=
 =?us-ascii?Q?NFBLsu9QSQB/EE1wmIZOZbjAQaZh4MaPoSoCAy7k9F4ixziLZHYknyj8K203?=
 =?us-ascii?Q?DtDw9gApQ0ixhi4bq7+EM53APxqRZZEnYMu1QhABDKZfKtiHpQOs9/1tZ2gr?=
 =?us-ascii?Q?yjrSRYW/ca+YTZUDEZhyECD3cLfkGPMzRmYdedwkxTbd+j2Gccdt60mbdAlf?=
 =?us-ascii?Q?+kIOGlBNbd5rX/D08PT3jLUkRlFOU8BVLqFMgWhKss55Nnnqmx0zCSQfIPTO?=
 =?us-ascii?Q?QOro8z+u0Dn6r2t295Vv8KH0ms08ZN29AXENSOXltL/RujM3ub2VqYBLMfax?=
 =?us-ascii?Q?2A9h3WbKteiXAz1omvAjrzNKQDtNzRP/r1SqkapCOs6AJnCWjxIDuNnFvLqW?=
 =?us-ascii?Q?WBMyKowVIz4rD70dcCOmq3wwWCO2XKf/kOAQsE4pbjnEr40oUBV57WKCoano?=
 =?us-ascii?Q?Bhlm0IPnxJ3z27VLxP4yWH9ITX9ZmMqJ3Qzfw4Jzw42xeFNuTp2H25IjLFgn?=
 =?us-ascii?Q?r+5LJ4jdxgA8AxSYv/3AN/t6ne+2aKkO8VMQxwed4YhvgNqpoPqwCwYTnu7y?=
 =?us-ascii?Q?ox/0SNQSeOporSyp5jK/Ttn8Apq+bjwb/3rZWN6CVv6I0Trz/aL9Yzc81m+R?=
 =?us-ascii?Q?kMZ1nZDF1tNvqkYj7gn2UVwSdXKzndcKBnHfnGhOmdw2+9ketpbjh9H4YWLU?=
 =?us-ascii?Q?hGcIOV8sYvh3wxYcAVOfdDBn/yqBJwPR8eWCDPxqzVyPeb6USFm4ofkIxgO6?=
 =?us-ascii?Q?gcfS9V5C1sKeMA9aUwn6t8hzOCXVE2S165F8Al/J?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38248064-059f-4998-9dfd-08dc33468485
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 01:35:14.4926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPv6qDgvG5h0+PB+lxjE46SWhs6XmUZp8odCa6OOpsE8utm2FohyhVIp5DaLzyEXGqWkYe7A2mcvqvV3wkj82Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7282
X-OriginatorOrg: intel.com

On Wed, Feb 21, 2024 at 07:04:03PM -0300, Marcos Paulo de Souza wrote:
> On Wed, 21 Feb 2024 14:12:00 -0700 Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
> > On 2/21/24 05:26, Marcos Paulo de Souza wrote:
> > > On Tue, 20 Feb 2024 17:19:54 -0700 Shuah Khan <skhan@linuxfoundation.org> wrote:
> > > 
> > >> On 2/19/24 06:53, Marcos Paulo de Souza wrote:
> > >>> On Mon, 19 Feb 2024 09:15:15 -0300 Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> > >>>
> > >>>> On Mon, 19 Feb 2024 14:35:16 +0800 kernel test robot <lkp@intel.com> wrote:
> > >>>>
> > >>>>> Hi Marcos,
> > >>>>>
> > >>>>> kernel test robot noticed the following build errors:
> > >>>>>
> > >>>>> [auto build test ERROR on 345e8abe4c355bc24bab3f4a5634122e55be8665]
> > >>>>>
> > >>>>> url:    https://github.com/intel-lab-lkp/linux/commits/Marcos-Paulo-de-Souza/selftests-lib-mk-Do-not-process-TEST_GEN_MODS_DIR/20240216-021601
> > >>>>> base:   345e8abe4c355bc24bab3f4a5634122e55be8665
> > >>>>> patch link:    https://lore.kernel.org/r/20240215-lp-selftests-fixes-v1-1-89f4a6f5cddc%40suse.com
> > >>>>> patch subject: [PATCH 1/3] selftests: lib.mk: Do not process TEST_GEN_MODS_DIR
> > >>>>> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > >>>>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240219/202402191417.XULH88Ct-lkp@intel.com/reproduce)
> > >>>>>
> > >>>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > >>>>> the same patch/commit), kindly add following tags
> > >>>>> | Reported-by: kernel test robot <lkp@intel.com>
> > >>>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202402191417.XULH88Ct-lkp@intel.com/
> > >>>>>
> > >>>>> All errors (new ones prefixed by >>):
> > >>>>>
> > >>>>>>> make[3]: *** /lib/modules/5.9.0-2-amd64/build: No such file or directory.  Stop.
> > >>>>
> > >>>> We should ask the kernel test robot machine owners to install kernel-devel
> > >>>> package in order to have this fixed.
> > >>>
> > >>> Or maybe ask them to change the reproducer to specify KDIR to the git tree,
> > >>> instead of /lib/modules/?
> > >>>
> > >>
> > >> This would be a regression to automated test rings. Do you have any other
> > >> solutions?
> > > 
> > > I would say that we could skip the these tests if kernel-devel package is not
> > > installed. Would it be acceptable? At least we would avoid such issues like this
> > > in the future as well.
> > > 
> > 
> > We have to check and skip build. Something we could do in the livepatch
> > Makefile. Can you send patch for this - I will oull this in for next
> > so we don't break test rings.
> 
> I added a new patch in the same patchset that would cover this, skipping the
> build and test if kernel-devel is not installed. The patchset was sent earlier
> today. Please check if the new patch fixes things on the build robot.

Hi Shuah, Hi Marcos,

Sorry for this wrong report. The files are organized in a different way
in the bot and cause this issue. We have fixed the bot to explicitly
set KDIR to the correct path before building the selftests. The patch
[1] can also work well in bot's environment.

[1] https://lore.kernel.org/all/20240221-lp-selftests-fixes-v2-2-a19be1e029a7@suse.com/

Best Regards,
Yujie

