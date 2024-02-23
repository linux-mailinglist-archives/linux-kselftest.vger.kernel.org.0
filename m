Return-Path: <linux-kselftest+bounces-5328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02441860981
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 04:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2910B24639
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 03:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099F2DDBB;
	Fri, 23 Feb 2024 03:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JIo3zNbF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FFBC2E9;
	Fri, 23 Feb 2024 03:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708660020; cv=fail; b=CkM6HVAsN0Gyh9RMk5ZnxsCDDR03Pxgl+skHg89VIbV28iAAzOlwIDCtdSWttMDoWCEMauWxNH3FjYa/+ZfYIfMd6uszP1p4DAJx9Gsmu4A/EOURimjghO/fY9rJsRa5a1PU5jw9clRZ/ab0cO0QZIKBMLO8JSQrq3V5X9VHRB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708660020; c=relaxed/simple;
	bh=6TfxUCA5yLr/J+r2RcfRHGIxyg3zxYQ/asHQuBLBb1k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V8sWylVmIkCyR/N5COGe6D101YpwmQZAjk2VP+vjLhTTjIhCfWTVPYevBUiRDC43sRD3FLYechheetX48RLXIL0CB62ar/RVLrF2LcEUscSrpUbII90HlHUoZ99Pe9tHD0Nsg+NUVDzV74tdUCpA+bsjYEeK/9SIcE6+K2vLTts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JIo3zNbF; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708660019; x=1740196019;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6TfxUCA5yLr/J+r2RcfRHGIxyg3zxYQ/asHQuBLBb1k=;
  b=JIo3zNbFhGr5leE8d8wLOlNHDw84tTU70r+pi0/OC1gFiCrXdP5E8bJj
   5zON4VKf3gegjohN6hO62h5x6A4Ka6hFKXUeGLHjU+UItsBMP9iKrNyQz
   trp+WY78GJLiz3ED4DFtNNQ11gTXPZCyMYjhv6rIQY4eGyUEZLQRe4uu/
   igj1Z5vTJi16ntl68nPdCY63msesyalKbsbHEm5BvrCEoU65f0hOyfiAY
   EoxZR4EjR6lMiWZzO9Mhd2jztOpborOIfk/gYUFJQVIqhh9VmJq9udUX1
   7tw9eF/PYdQo14ND+4bB7+6ltsdKtNL7D5MiW0caOzM7RY/nnIqIgH32K
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2877898"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2877898"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 19:46:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10536174"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 19:46:59 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 19:46:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 19:46:57 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 19:46:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGAcUOCvMJ/BBy4x8D7g5BiSMnSxN0Yc/IiWgTUTF/4QjOsLjxd3CCt+uNBg6USpjvFTYw9Fm0sy0DqsMe2facDuj9GmNHr2jCHZPveu5Y11A8krMjT6jLIy+I1c6/iBBaZgFloDt/K0Le60zgyOmfL0npBaJ/S4OzQ7toe8C27Qblwj8Gb1jm4xrH3RPXCbIELxvhdYQp6QAThvTVUiCbWQELyzRV3vTQHEMrawB9jqY6uAOuPrOsMTyYpXq8K2LmRfXRlB9pbYBN4lHVLgVwQRlJb+omDalKEdzK25zRDdvd49gFykFFouRQ40ov0lWkjcmO/0MNeGjfHoJYyAsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=df/W4PoRMzki0943yx5hpmQ3Gf9SctUBHfaT7jpdGG8=;
 b=lZNU5hDs+iD8rYEwhljGYa8tx03XVm6k312IWaaFk2ahxMegCqJcdAim5tASdjfOBHidNbV+RSTuYUd0OnoawDqKst9h7BC2Ppfc2P4EI5qNfyz/AUa33qg3Z+wvMBygDxMdO7vZ4AFMY3n1Qk38mMdr3u+EDfd5zbzupCG2WxCPK/4WGq6m31gdWZ0nY8mkVp9n5lWV7jYan/+xv4ni3xlaUALw2f1BwVnO6Y7AskCnvLLuH6WxT7IzqDwImSlU+VffK9f+RiIYfb3BTpgJtjyUirz7ft4dNFfb/t4sfDv63ZOPvaYvQuoG6dk2Y/9RRj2wU9W+RuYYuNGpJyd2dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by MN2PR11MB4535.namprd11.prod.outlook.com (2603:10b6:208:24e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Fri, 23 Feb
 2024 03:46:55 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b99c:f603:f176:aca]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b99c:f603:f176:aca%5]) with mapi id 15.20.7316.018; Fri, 23 Feb 2024
 03:46:55 +0000
Date: Fri, 23 Feb 2024 11:40:00 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
CC: kernel test robot <lkp@intel.com>, Shuah Khan <skhan@linuxfoundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, Joe Lawrence
	<joe.lawrence@redhat.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<live-patching@vger.kernel.org>
Subject: Re: [PATCH 2/3] selftests: lib.mk: Simplify TEST_GEN_MODS_DIR
 handling
Message-ID: <ZdgTkKSSme5Evgwq@yujie-X299>
References: <202402191502.dALlSRz0-lkp@intel.com>
 <20240221122949.26263-1-mpdesouza@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240221122949.26263-1-mpdesouza@suse.com>
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|MN2PR11MB4535:EE_
X-MS-Office365-Filtering-Correlation-Id: da7b7cdc-321a-496a-c856-08dc3422144b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AkpJS1bFuj5MFIKOXWYtvjRPYflK40mOgDye1KjOUI/tyGMrN6lJziq7j4DYoFDRPf9yLIxolGPPf+Kwcd4hwnp09VsOFJbHG5pAtntgD2zesoJaLZ9nLJpfK+vUPHTTh8n9D2uhY7WcK0EeoNfjaPn07krH49fXSP+Vqd7Egf0ijgtkTgzifx7UYXNQE3v6kfvOpoqPoW0Xhisflyi+H90XYDY54GA8STWDwJnEdrEuOTQu2OxJloTUe9StJ7g8gl+CgWGDbfFLJ34kY2l+j13iJb5nYsjemlugcOK9/4QGiSiyA6lDqnrVQKZw7czmx8j+VsrWd8+qSm/9KUFeoFzOyRizvd/9uItZo75ZF5AGt1B8qvQPwG4N2YAf7EpflMvI1QXalzIRteHCYM4vRA/oG6wmKEcQqX4hqWxGfg+mYnfYwADvNI4beuwQGv3hC/S9BYt+22qHZrrCYQJ2WRhhHnp5MnuAKmHoZiS60TEU1goP5QVyYK9vYfZJVFxn3c1t21Alz70vYr5KhT11qr0uqZZnycEoreQUDoAZ6T3Dag+fGZcPezpAS10+VbKM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W8Wv6Wy+5Lo40x9rwOYGIlG0/Khex2kCIkUwgSrQoxmHTdINHWCtMw8TSc7c?=
 =?us-ascii?Q?NlP2VLTJraeO2MSkeFSGIKGIWIAZWgNISBkRdnNZklQlvY829zB5l809J+eE?=
 =?us-ascii?Q?/3yiq7rn/TUYE8uZnp7iSNsvK1Bxux11Q8kq1lWZObgn6QGDUwqP8DCBVnBW?=
 =?us-ascii?Q?RyJu33ir3sckrthJoaR3DrcLiFA8IcPCwYnwpN93vemSXjK6gW5fhjwKDwDa?=
 =?us-ascii?Q?Reej/UO+YFHwQ2LJLf5aPuu+O4t84is0QB8e1FTKUtEbyNy5i6sC1m9QJfT3?=
 =?us-ascii?Q?6UWEnT62cG/zVQnmATtGB9gflc0Z4hvXCCYYnOEPoI1uv1AbTV05q3GUGCJM?=
 =?us-ascii?Q?H3CM4dG33pDm47kTMC7xzmKuy/rC/2hMlGcJSx9NhPQu6C7MIwhhcYXpqLzu?=
 =?us-ascii?Q?9Y2pQC/TJe5HR98WypDLavX1+YmEZv7N7vJ17OLT3iaYm9Ca9krHS9WFD6Z3?=
 =?us-ascii?Q?dY4bWe1JflBkmCjRabjq6llrO4O3AblFcCZQhhL3MsQFw2FKnD2ZKvj2oFg/?=
 =?us-ascii?Q?Mjiv+6iJMmNU6e5veuh+eu2cjlcz6Br4Bp+MOnWvgSPaAieRPlN0YwDQqit5?=
 =?us-ascii?Q?IQbAOTWTHpcp24xe7R7x+Tlo68zrKbhdGpXAuEtofnGQt4H/1AiAc/44paYM?=
 =?us-ascii?Q?v71rkZ1imXlKpny/7qRbyOfTE/7iij52T7iy4OaO47PQ3GL8qIcmSchlvmSR?=
 =?us-ascii?Q?xUo2ObVSGX15NNxtdo6wKpZstk+82yt8XxkKoK1Uka2mo+2336G18suy0mSM?=
 =?us-ascii?Q?jMDcQRR3Ko477L7pVWJGgowTHi3/sDik+pDr9z50cLqi4YWgTYDJZN+q7P5G?=
 =?us-ascii?Q?BwvbAakQ9y+d7axB2RvnRZMrjSrNL4vQiAQTPNdKU3M2BBPEBurjnGpXUTbo?=
 =?us-ascii?Q?VALeQplujmD2pOw0GXlzQuWyG1uANgoCVnhMAy396GfsSnbaMgvTYOrREqyO?=
 =?us-ascii?Q?ZqiXJKT0S2W86FJ8g0Ci+piXmyhFe527C0xZmzMwwzbYRTE2x3Wqh+MxAbPO?=
 =?us-ascii?Q?vVhcHEATRPU08OMNhpe1KKJaFzmKkM0yn7CjWPowsbHme4aIV6hLDs6+IXwU?=
 =?us-ascii?Q?V/E1haKpolTtr0gIoTkOhejv80WAGYP6pjTwc49cmmcKh+aKzmta7P4HJdRX?=
 =?us-ascii?Q?83PMF9s0IEuY1XP8ebv/5A0BnWXVut22tltKn1URkQTBxVB7vjpfaqYa7ZzX?=
 =?us-ascii?Q?WNA0HVtOwt3wmlZv/cnYQHc/2+fZhgpcPiGWDJ9cpwskHJ0K2xjykdK5FtRr?=
 =?us-ascii?Q?Ab7YaQodJpTisXwFnKn+7nOypbJMZGrJ5w4rP/SCX4u2Q2TB7IWvSdRh41Xm?=
 =?us-ascii?Q?gzqH+Y9VJvjp9XTjIo/bYQKlWcakkcN2kzVA8ezWNcivXD5WQwyYTRqgET+E?=
 =?us-ascii?Q?UXCsqwLh/ciLr+zwftMmvMshTsmNT1WCdJAEkQSCzmw8rczgG7+lfp3qi/Rj?=
 =?us-ascii?Q?U710OIcPs3BJeGpr+rtj8E8IWOHb3TjyIngsqxtkC1nS8evmiy3F8sNgaX/V?=
 =?us-ascii?Q?SZyFVM0WMDhSzplYGwpAB4yfjR3Le9wuGPH8H550hoAtQfN0mYAYgZAqMR3o?=
 =?us-ascii?Q?HwKs/ELgFJzGRrZ1WoucL30kx2XOcQRKTMprC/wZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da7b7cdc-321a-496a-c856-08dc3422144b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 03:46:55.4760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shmiNJujuwjonf8Vjv+tXBzpzp/11+D5jaQZ08ylAl7wdK1USoDlWi34aeNARDMzNEcxQHLJny2SKYhcRZjf7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4535
X-OriginatorOrg: intel.com

On Wed, Feb 21, 2024 at 09:29:47AM -0300, Marcos Paulo de Souza wrote:
> On Mon, 19 Feb 2024 15:16:51 +0800 kernel test robot <lkp@intel.com> wrote:
> 
> > Hi Marcos,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on 345e8abe4c355bc24bab3f4a5634122e55be8665]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Marcos-Paulo-de-Souza/selftests-lib-mk-Do-not-process-TEST_GEN_MODS_DIR/20240216-021601
> > base:   345e8abe4c355bc24bab3f4a5634122e55be8665
> > patch link:    https://lore.kernel.org/r/20240215-lp-selftests-fixes-v1-2-89f4a6f5cddc%40suse.com
> > patch subject: [PATCH 2/3] selftests: lib.mk: Simplify TEST_GEN_MODS_DIR handling
> > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240219/202402191502.dALlSRz0-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202402191502.dALlSRz0-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> Makefile:11: warning: overriding recipe for target 'all'
> > >> ../lib.mk:62: warning: ignoring old recipe for target 'all'
> 
> I couldn't reproduce this one locally. Shuah, have you seen this issue in your
> setup? I followed the steps to reproduce this issue (it's the same sequence
> already reported in earlier patches...)

Hi Marcos,

This seems to be a warning when compiling futex selftest.

linux/tools/testing/selftests/futex$ make
Makefile:11: warning: overriding recipe for target 'all'
../lib.mk:62: warning: ignoring old recipe for target 'all'

There is no such warning if this patch is not applied. Looks like it is
due to the "all" target is defined in lib.mk but overridden in futex
Makefile? Could you please help take a look?

Thanks,
Yujie

