Return-Path: <linux-kselftest+bounces-5026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FB685BD04
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 14:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6151F23F76
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 13:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5726A03C;
	Tue, 20 Feb 2024 13:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQcHV52X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8A369DE4;
	Tue, 20 Feb 2024 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708435133; cv=fail; b=J5CADtxE4B1TekPeu1FTzvpQ/G164hseOVbpY1SaD+oqm/KcWheCEFng6dkK1llKViB5hEkFZvOcasax8agTjqrUJpEzGhOpeld00eyzMRVQ5z3lncZdoNjvG3Kc8yIaeqXFPd5kFpT7X2k5Bf/fimRlR52gBzyLK9aksfeaUkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708435133; c=relaxed/simple;
	bh=YJO4EdfAu9mE/9ZWuTfJlpns+CROReL3HUDUDXJ/LBg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ucCLApRO/Zgv/aq93RDlWoXeSXySCES7waTvRzweodctqteHxplCyZ9agXXJzsJCwP0BrzUx0hHsDmqbITC+i74heU7ZIjii0eUvlmPmDCzq7G0nbPqyDoSFWeJ7ghqRfF2c4ERl3MmOjQsUPu/e/woNnX/JLK1IXo3Btwx9on0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQcHV52X; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708435132; x=1739971132;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=YJO4EdfAu9mE/9ZWuTfJlpns+CROReL3HUDUDXJ/LBg=;
  b=cQcHV52XIOrgY5Ok/CIj9eprl4uzgNedHiI6BAEVOia6wm/Kle7FMBOp
   vdv/sVyDnLf8M1XnM74ZNKGVWXTAUph2m4BKy7U4Dc6dLdt+X4iCA4tu3
   tkzLakljcnbQabw+FqefgBvO7qjN6eNFZ4FGzmLeVLEQz6eZIEflzV7oo
   j4UPFlFhxJUCwr1PQfS4/0hcxaaxyhatZCsXwyuHUodUhpXlzk5K5gs23
   4Vhj1ouUP51O1RFBAX7kwWUpaidMmkfPpKcHOaUU0bYvuCDEFIs7HYyUe
   KC/sIUVVEmljh30F+DPSORL43/QZ8F5KImp05uOzKGcxFq9VgttCAGOIv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2669201"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2669201"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 05:18:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="35539598"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 05:18:36 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 05:18:35 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 05:18:35 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 05:18:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zal4OYOPp0RMYc8dW5tDpvF3LaUAb6vdyg+RIHvrP52Zvn0mFzJ2Ln1Kl+g4O7Gkx1HILBP7kJj8/mGIzaOv4KC/p8SzwFJkEvimBloCGtGXNCgiRb7fRQu/3QmdkeObfFd+zfgaoBE0+Vdnu1jdt4SBREtl+G9RgRmHcZnRt+Q2fe5Lqj44xKKHuDwJxkow5fogzUT648iYEKRRlpNkD8BKYPUFyWpYDEGdcIAoGoZyqIKyDC8WXU6WYrIVIJ9Iv23vAVBk6l/Hb9WKsIcpkKeAbHL9T6fwW5YhFMylcqhAyZ+QvED1QpgkcSoseoozPpeaDKyJAqgL1T4cx4i8rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQovFeAOwifinlCkRKT92k+dxorBt/VCJ4F94vH9OcI=;
 b=P7CJxa3Z5sq3MF+s6JzefQGClWwgxvyWKHHknTCSg0NEXhR9PSznTg1L3559IDlljazAFBfMx7E843iVwnc17CDHt8TNz5H26GwnnsziR2H+sGc2Lv07abAttRP2iDVuc7+d+8uqKz70nfTaAyHmoaGgn9lk2HunCLnNCvo5zx0EuEOQ0nTrMrzdYubvDqGbKCIJNvbdTsThzpEjxgxy0Ka6sopzCtQ9gwfNP6Y7cdD166+oyvxg+YX+114Zrc8OVvkc0OP3r+J8OBStlfh89B/cnXCdeb/75px42E//lMbzk19ITyjpb4L1NxjlVEBDCbkBtNzezZ4JQ+Arj8+nbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by PH0PR11MB5925.namprd11.prod.outlook.com (2603:10b6:510:143::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.28; Tue, 20 Feb
 2024 13:18:27 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::b2fa:6a11:bef7:179f]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::b2fa:6a11:bef7:179f%4]) with mapi id 15.20.7292.033; Tue, 20 Feb 2024
 13:18:27 +0000
Date: Tue, 20 Feb 2024 14:18:17 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: <shuah@kernel.org>, <reinette.chatre@intel.com>, <fenghua.yu@intel.com>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 0/3] selftests/resctrl: Simplify test cleanup functions
Message-ID: <uagazywgvbp6h6at4t4dqszltvzm5bb2oprkblrvczl4xzs6fn@ndg7hufelfdp>
References: <cover.1708434017.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1708434017.git.maciej.wieczor-retman@intel.com>
X-ClientProxiedBy: WA0P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::10) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|PH0PR11MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: 1599570c-3fae-4e51-c9eb-08dc32166c4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FvNwg03TOJffx8vlTYXoU8vIgd3KIRiuvWKR/MT50D0OTc2oO9U6KUYLil+i+DbrSj0LD8NHz7t2k5HceXH8fVEGgKcvB+XlMYFHyxh2R+6E5ZVI1urRGGONLHTeQmrpEnIEii4ylBTJs3QfdK6FtKarXism0sk9vA5SO4R3V9iEHnzhm+qQoyje5hHiWBNDO+jRLnMs9rADSjTK2KbogRcvYa2lGlQ9rsNkZ2z3XFJgFCdqaseAbmqLmEAFWcrDuNTiXc6aZeuw++KUQCoKKYGfUjAv0voHMqnloeBjou5ntywEl3py39XaWB2KVBo8F/R4P+qAc019fSeufN7Vg8w/OMTBzuBLCt5EmaaR71CRMxA+OEjJEJhaxKLYuidErXPFBkT8vA8a8AtepZDVs3IO4eG1l4R9+MS9jKlajkB7zThCU5aFfYfaeTOMSeFtAaTB4wQfwBZeWKiKB/oUjD0h1n24WoG3KQJkv4BPoLiams6cU5xOXhd8/d5VVzJZxHsvoho67PZKYBZ0IfL/Kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?GpWhiYWsYNJ2TMbtCf/Y2tEtS5iFy0AIJC75lr8/+eRTMJ78tBLATVao/N?=
 =?iso-8859-1?Q?AIO+GY7wPnyN1AvoWLo4FJbiXJdBo5m1oICcTlbNUhAP2xMQ3lUtfETDDz?=
 =?iso-8859-1?Q?075R0iME8SHLrPpoI0OdekYM9Jm359Mcja8aPJGa7Tc5wPpuve9mlWiIjV?=
 =?iso-8859-1?Q?fQcwmDfYV9i+mSi5Bd11/oMSm/rfshvhA31tJAklKs/HFvMyrAMlCQcLp9?=
 =?iso-8859-1?Q?IfjJFVItIGw6Kjn7wxR9xT2X1dKJMDx4vjaZO9njxPFDbc7hI0gm60zPNm?=
 =?iso-8859-1?Q?Dcg0wm9px4w5tVjnTV9atFGDM2N6juphmAVcNlsMXc/MipNWh5TdwvR0fp?=
 =?iso-8859-1?Q?tD1t01tEZ8pMhKmP2ujchFCip+3K4fCQzPRBIyfMj2dYCvPzKphx0IgHFZ?=
 =?iso-8859-1?Q?eZdI+VnH66IcnhL6aJVf03/ImO2qgI9tyo3LRHERZdcACc1JJ1L9EFqb94?=
 =?iso-8859-1?Q?fh5c6Yn0BJFpcOMlAbZJXN6OWU1TzZVSBveFherYc2K/M3cs+ka+wZagOr?=
 =?iso-8859-1?Q?RUAgelXcSTG0ak3aTHGkA3oWjTJsEPbP77e6GdffUOM+q8enTldlFKeCmJ?=
 =?iso-8859-1?Q?ZuWepntUj59CX2qXu1DUxyu6k2LSH1fxKUu5AJeAg7QEP7zCZKWkzeWDo/?=
 =?iso-8859-1?Q?Mih1TU973pY2+C56d3NoTiKYF3qR2Gl3jnbcfH9fDIHZNZ34qcWDvc0SuL?=
 =?iso-8859-1?Q?UxJv2hPaD0eRio7yz7KlLfcgB60nN8kkt99XaarUssIkjoypXD1PMbYDP1?=
 =?iso-8859-1?Q?0zl0SuJUBELcXFglJEUoxOPUbfBCzCYwnSjUQEMnQvKLRn0Zyl64XeDaRo?=
 =?iso-8859-1?Q?ZGGhzVC1Eoq8s8MDTb9VLaY9yiAJITFI1u/q+Vr5ynRXqcmcNt8/lxuuC2?=
 =?iso-8859-1?Q?diS9VpYhwWs8AX70RRIBk9jPPc/Ia36ZbmZC6y1VJaIJBaqsRxlD6BGXoD?=
 =?iso-8859-1?Q?iextENYs1vrKGoKCrP65AFXkf+y4e9kQCQRtsqnPMOxvrGEC27A8wHs0zb?=
 =?iso-8859-1?Q?3wAnTNJfkg6mS8LEHurDO75T4O3IvzbUGlBDq3iu4sJXblYlYm72O7ZnR0?=
 =?iso-8859-1?Q?3eabU6ZoefVIY0v3gDGH5JO6wDd0t+j/5W+v0DX/BmeclTj+MN+mhQ9KjB?=
 =?iso-8859-1?Q?p5ImlbABoHDVCRCelRmwY67TnOKf+y8iA8It9Infa69qwLCaz0Vnr+3ixy?=
 =?iso-8859-1?Q?NdH3M0NUWQp77rZ/Z7lif/UTgGt0sRgyOTUz3k7tTDvFYqtI894+vvWudR?=
 =?iso-8859-1?Q?icWgEcB4w/J+AFFAu1II/7ZCldWlzE80ol5Rwl37DsvxgGPcGoSdj7dSLa?=
 =?iso-8859-1?Q?mtdC/L40YwxSPPsx6+vF+yizrVlTe7Q6IK6fI7S5vyvYEBFmthdnm/t5li?=
 =?iso-8859-1?Q?yHsQAY/DzhYOZiJq8JThNMzDdYX+I/Enbr+lXD6v+Qs8QhjhPO5v0XG/tn?=
 =?iso-8859-1?Q?bNB/SnAZZMf/nBBdGi5xbr2IyCTSMC+il//2QBEzvjS0iZbe7FTlEJ+O1B?=
 =?iso-8859-1?Q?4/gDLSIsBuEGAtTVx7LBYuDODMkIGsvI8W5qxvT17urvYdjbM0JgtbuGnf?=
 =?iso-8859-1?Q?fCxrjWD2ZMZaluOg4vUgphBiKiJ0Ojt2jl+JS24sECZWeMNKAlRlr60KQo?=
 =?iso-8859-1?Q?Gt1ZdyAluBtt7nIynrS7qWr/JuytNExlJTgMfyCTaPVZFG6XSgi5PNXzjE?=
 =?iso-8859-1?Q?xLkYhN1TxsrHncTZAJc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1599570c-3fae-4e51-c9eb-08dc32166c4e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 13:18:27.0274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4QpyFnvyFXkoADP5OYpMKjZsd1O2SAmkuT8gXRNNDEhg+PDS6UJKQQa18XOTN+RdxF7SQx5Zy6xeElVSG7LUjJ6c2YA50cg5/39MSoFNmMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5925
X-OriginatorOrg: intel.com

I forgot to add to the cover letter that this series applies cleanly on both
kselftests/next and on top of my other series [1] currently in review.

[1] https://lore.kernel.org/all/cover.1708072203.git.maciej.wieczor-retman@intel.com/

-- 
Kind regards
Maciej Wieczór-Retman

