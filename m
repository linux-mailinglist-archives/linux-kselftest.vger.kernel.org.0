Return-Path: <linux-kselftest+bounces-10768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0268D1577
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 09:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B96B283333
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 07:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946D54DA0F;
	Tue, 28 May 2024 07:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eklT77RD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DC811713;
	Tue, 28 May 2024 07:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716882382; cv=fail; b=qiqBLCdrXHNsNmx6Qm3d0XJJawFRisSZww0ztmioOYb3lh/vjownKLztgpakTg0x7MxuumlrbUHB4/uj1+vZ3HVWMcgTgVbeOMKbg/8dTFbb+M1MAsAaXHOvYJCtSsJM0hNizB4oVYFDwHLFxLvTXu5y/z6klWh5ID4poSN/81Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716882382; c=relaxed/simple;
	bh=ZDAM4RiJBf2y7Hi3tJUTHfyv4u6pIKWOOFBCNSfhF6c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rTfmA5pLYhm2Wo+FWgSwYrYPzK+70C2MBfsFleaMVvGGUSgLnZ78ewywOHhvHfH/kWoLbTteC3GT6gqG5AEamjcyXsc1Ie56r1W0QuE+X22dTlH3xH95Zo0k4PL/ELBuSd3DETYisrxH4TtQ4qUPk/1SMO9rJOj3cDN5RsAy75c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eklT77RD; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716882381; x=1748418381;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZDAM4RiJBf2y7Hi3tJUTHfyv4u6pIKWOOFBCNSfhF6c=;
  b=eklT77RDjPu3/PxoHs8LTrrtFURv/GlJVMiBFRYFLuOCqSt/e760yBMr
   z7MoeMMUBitWN/gnqlfd6M5JoJDnvg773zpR4oZAQbcCtt1w0DyGzi0cX
   EKVb1NzlkVsRi2BxmfbwzZ4vNQXLHBElzCtZbZvZWNLalwVKQc+VDYn4w
   SoSsLtbUeRCStzObXjAjcWpgxC4Ubbhw9d2MEj3HmJDl1w51tEyTjQLq8
   dIUAzFAQjZ+GeeCWTNfQEuTTbxJNL5xb5NsrAbZ8X/70ZKkBeFUgOlycz
   iCIc9UpVkAS0VmxXQqwUzLCcoThMgU9zEuEIjZOxTP6Efsf6ppbWebeF7
   g==;
X-CSE-ConnectionGUID: mw4fsWgPRHa8cFVth6wz9A==
X-CSE-MsgGUID: CMJ9cf8vSCSTe+jADbe71w==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="30732840"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="30732840"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 00:46:19 -0700
X-CSE-ConnectionGUID: tu9MIsQXR8W8fTEynHEIDQ==
X-CSE-MsgGUID: V4XW64gPQZeF8+4hrjHX1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="39793455"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 00:46:19 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 00:46:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 00:46:18 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 00:46:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esnwbF8b2RC0F0TeESnDKXEFYQHg2eJwRTdX7WrZWPNwjnCZBFzd56t858ZsjzZCRdzI6m84eb/EU8fDWBOa92XISwU68avUbcbY6BMyiuWL29wRFctf3ijvAjtxTduEVND/eiPEaySaJdpcxVonqCEoDCSjtprXZuIrb+9B0Uxr85D900C7n4hyM/Plu/xBw3+D+mAvHQWIb3zu+teOICbrGLpVg0grIAXINw0iuJpgSGj21nYV3EcCyqx+Ox+0UihRZg7t2DK3kpjAI/8CU+1QbPunu0u7AsO7bzRIv8CSXOi7GzuYCXJ3nQhamfvpnzpGyu4M5iRaGvxLLCUAIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5bMBJ+BsgT24oRtNRjbWkGSabVx8ce1jndcjy94kEg=;
 b=bEvJWV4EcKPFWypxpNWiM4HpW6dc0G2mqwMaGofA9Sk9aeQiO6f1H36WH1lX5ErWiJRw504NBfrGZBLf8Id1HyXtJrUP2kVBzeApR4HfNNnCEKsYlEiSK5+yu4iYhWVbhsbbHwexZ6+ImREPb2AiRN/xmVvNvNkKZAgifkOSigC58jBnBmk8+a/xc7Jm8cF9M4jjwsdRgGR7quUYT3+MCD/1nzqXsXVIV8+HuOFIXt7XbMSVLIjG+gmkIjadoZ5ntqFQgOCzmBnaOnwMMWYqNzKKn3yRxztHaLmB3bin9BKIZYEy/KHbDlZXgrSbl9bpmTQ3Ef9z60v2JgP2P1laOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by CO1PR11MB4852.namprd11.prod.outlook.com (2603:10b6:303:9f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 07:46:12 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 07:46:11 +0000
Date: Tue, 28 May 2024 15:46:02 +0800
From: Chao Gao <chao.gao@intel.com>
To: Manali Shukla <manali.shukla@amd.com>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<bp@alien8.de>, <ajones@ventanamicro.com>
Subject: Re: [PATCH v3 5/5] KVM: selftests: KVM: SVM: Add Idle HLT intercept
 test
Message-ID: <ZlWLupfpODawPX3P@chao-email>
References: <20240528041926.3989-1-manali.shukla@amd.com>
 <20240528041926.3989-6-manali.shukla@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240528041926.3989-6-manali.shukla@amd.com>
X-ClientProxiedBy: KL1PR0401CA0028.apcprd04.prod.outlook.com
 (2603:1096:820:e::15) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|CO1PR11MB4852:EE_
X-MS-Office365-Filtering-Correlation-Id: 7824b673-c1a7-4b67-8baa-08dc7eea3e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sBDgM1fcyDb1mmoKOx1Ux+HXHt/C5/eXJqwmN2/eY+t9YXWEmV5dPoHSgbPQ?=
 =?us-ascii?Q?S5MiQsORa/chXmJqUTD4d3nJiInjQYzW74Ddvgura45tCmOcPqEUVALh10tF?=
 =?us-ascii?Q?dgS1NBp7dqJDxpSZOIWuCPoljNYlYB5F5ug97gtpPRkinCH5XlfzHCnFOiLd?=
 =?us-ascii?Q?RvimTWUCzftBqfrpt1ZSjsbb7Zujb4uoEYH2ZZ+IFaXY6gXSZiuxeHYqsFo7?=
 =?us-ascii?Q?HKHngptLfs1LmbtBnqP/cpIknits5bDJ1haTYzHHUOnep+00lTKL8AvF+XYs?=
 =?us-ascii?Q?gmNd+R/JC3bNe0Lemw/O+Q+uj8yyf0YzHihWcFaCMAnnWCS6virn5v+Eht6V?=
 =?us-ascii?Q?clKcnOA3f7RstKSq+t+ABfC37L7IgHKDJf2y8P+EvDleL3zQn1+rf5ihFjC0?=
 =?us-ascii?Q?A8dG4BlBXeDxo3o1AepXEoaW0FPCZAQbXh1LnIQ0uBr4kFLOinuqZPY6NuYi?=
 =?us-ascii?Q?z9JeGHq3RdtthHDR9FFXsoqNnuEu4jNwyXtPOW1r0gke/njjDEUmZ+FsiFTe?=
 =?us-ascii?Q?6oPLdfJ+mMoU5xzFaqdn99SXINIhDDahSYNISGFS7bcv1CIqPGPtmII00NNe?=
 =?us-ascii?Q?WSmdn1H/63wqFNeKmabMcx+pCwN8CPG1Fn0MILyAWgt+AmRVlb6TsGpug8bl?=
 =?us-ascii?Q?/HNqKvAwN4/Fe7YQrnri7BfOw+UlazrZNBZ5dR3BcUsvlRoEJpjJdZYZiWrX?=
 =?us-ascii?Q?SaV5YWlChfWhZ7LqwjVYWQq6sCsUsxUGtMrcAO2XB3TRU1LaXj6gufQRrojF?=
 =?us-ascii?Q?saC0EI0SXDl3Of3fcpVqf79lqYxfny8fUux33ZzwFCUMnJJFNlzh+Qlm9lbO?=
 =?us-ascii?Q?2a3V5LK+klPTlVvsLjhx5vstcJiiu69YeAZTE/EU0qFU1GDp0d0/P7cxveuF?=
 =?us-ascii?Q?+qubPGF8tt0XMhMerlFM81UcMwAhbRCFrrgkfTM5FmA9WpmxPP0JnHdbFCLq?=
 =?us-ascii?Q?vk2WynwGFXKPy8X688HlziQpZ5tyiFJjsyTVA6M4PmTp34QARlRTJu9RJ8I/?=
 =?us-ascii?Q?W9CMWqO0PbnZvMK5XZxi+XdfQ6egWOeSxDL3RfwaXNtGO+mZZO4XQqPaW4KB?=
 =?us-ascii?Q?AlvGXHRuWpawnFS5bdZqrzrqmo1cGmFHEMieIh3LTnx+i1fueaIlPPLgZklK?=
 =?us-ascii?Q?RctpwhOK5kGR3y9wt+KT0KZROiZYBgBJ9md1fn2Y9v/Zqylls9VnzttOjAYd?=
 =?us-ascii?Q?6lIJHX7APXshSCBapjm3h8+YLIyelrU/aT/pbstYh7Nq11PH+A+8FWHFsKyS?=
 =?us-ascii?Q?dyTFDhkjV6i4qQ7b8ENccW7TAP6ZdDxEYhIqUTCRGw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aUeR5+bUj9nIOWA2dEr6x4HYbMOoI3eT/GHq0Wun6JIaqgs50xjX8JFKDYyZ?=
 =?us-ascii?Q?Mh1kkH3kFn1442xyoyXt+anRiMKUbtOMzdR/LPvQZ+CVfvigGwX8HRTt85r5?=
 =?us-ascii?Q?9igbZe+l6VbggaVgg9Ul9yfk3XivFSY28CDQTWl1DiL7sBRpUxh29LFu7Qdd?=
 =?us-ascii?Q?+Xi72+297jhhjMhM5jNzBefPabZW23I7pBqv3PkaHk+Qt9s05zQY4VPkvHk3?=
 =?us-ascii?Q?5lhiLseNHWsEFuC5mDxKQ9Y92L+uZ5k9D1RLdcWDoMyogPHBiLvDCo1mw9eu?=
 =?us-ascii?Q?apeyv1KQk/g3JB9cf+zUKqVa0YHRA33IJwEhSy3AxWWK2gtcmWwXerH5tSTn?=
 =?us-ascii?Q?XZqqK+K6W27dQQuqYhsGEJn4x/h5Yqto99VgOeh1tXSaUDNTsZPCJ8ClcqpQ?=
 =?us-ascii?Q?of96P+lV3TaWGOPYPP+xI9a6pZQIi6iIfWhgN0kZFIfOEssOC48oxCBlrMSY?=
 =?us-ascii?Q?PP5ZYBlmYmPGh5srQHOvtVM84mNnW7tz5OIjmmFJTpjRC5xUN1yJaCAFyV+4?=
 =?us-ascii?Q?oomPmfAGC0yBmiH2qbHraKxvJ2i2+W+IQlngq0lFwJPFIwOCNvYbBXKj5FUF?=
 =?us-ascii?Q?WnGB4+aXEUK5Jn+D9ZYBZawwxhM3zf8RM1Apt31rKSvyzVN+N3YVWcMCBsVY?=
 =?us-ascii?Q?lE2R8r2OmBbVrhlBFyeLYWEkMbhL1dpG5gfTE0JqpUBl+9URMDPzGeBgf+oR?=
 =?us-ascii?Q?MCZ/cJDPhEY6Vkc9qxhJAfy1mVObpw5y0GYDDFZW4KprHwzD77ylcjusi7eD?=
 =?us-ascii?Q?2NyKQFqdPZ3yW/jnPUD32lhhcL6xx4JmeU9Z16OXQDNWC4FAdMfEQgt0Tl6w?=
 =?us-ascii?Q?XgOKXFFjXGAP+5c9U7cnZE93EArQI7srY1hNn64VPtse8+pIbchqqqMzXJzN?=
 =?us-ascii?Q?l/b1HxE3IXs4nRL1FWvsqzqLu3gfT6YWK9KdPUzQ4OS8KqhMiw0+4dUC+Axa?=
 =?us-ascii?Q?TWQB0T018L4vtldy4AZ0S82ZiXJJ4qH4QnHRNjJI03gribEGKeUhWj/s/Gzh?=
 =?us-ascii?Q?E0CBdjyLb8aJwbxo/X0n2u5mVggYIWzLzzj8+L/k4aeiF5ppSbQrUYIikXGQ?=
 =?us-ascii?Q?/7nFo0tjW6+5mjlDQOEmgbXfI8pcuwRq0Nbxey/p+E/DG3Uio7b1M6WCMnxR?=
 =?us-ascii?Q?numqv/BxyKlaeNE9R3KtiIj9/Pd+FSxYfCrfQqyDxf6GWOqt71hogHY3/RSF?=
 =?us-ascii?Q?tY3FctL4PHtz/DPyfKuGbyCoH2/b525QeXvGHWuYTwSdDKHPogGXV+GxDir6?=
 =?us-ascii?Q?HB6h6Lo6QMt+LB/4kt1SyWacdSDR+uvyBxKLg35mwgLtQmZz/FrkYaU7XW9u?=
 =?us-ascii?Q?/4kEFhzR5xY5KJDmLM6q3E+2Y+PzY1CJQBVcciUDpqOpYTxFQd3XhneFh9qH?=
 =?us-ascii?Q?KaRiTUyakJNRoUmggEP7rl9vYMLX1zOUlQdyzSKjcJ7Nf1c4qfk81fuBo/UQ?=
 =?us-ascii?Q?C4qEYmDkgyA2lMyUvWPrSDOFp5mv13IHFlqzlap3rpoJkSLAZ2gpkhUMGAbb?=
 =?us-ascii?Q?x7INeoVtLnl/bdQ17BymlMqx6lKsfT3vStMZBICcetkw4joUMuE+oi6Xwj4K?=
 =?us-ascii?Q?vM7UFAAe3zsxLq0j0KpTMuvyW30SsjefEuak+HT/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7824b673-c1a7-4b67-8baa-08dc7eea3e81
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 07:46:11.6938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mz3/qv8m+JhJaJ4QzWOyiduXNw5ET8cE6OOeLekKir2wqmh1GtxrVzv7OxTf11L78My21ZnDR9atVcLVyesVpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4852
X-OriginatorOrg: intel.com

>+static void guest_code(void)
>+{
>+	uint32_t icr_val;
>+	int i;
>+
>+	xapic_enable();
>+
>+	icr_val = (APIC_DEST_SELF | APIC_INT_ASSERT | VINTR_VECTOR);
>+
>+	for (i = 0; i < NUM_ITERATIONS; i++) {
>+		cli();
>+		xapic_write_reg(APIC_ICR, icr_val);
>+		safe_halt();
>+		GUEST_ASSERT(READ_ONCE(irq_received));
>+		WRITE_ONCE(irq_received, false);

any reason to use READ/WRITE_ONCE here?

>+	}
>+	GUEST_DONE();
>+}
>+
>+static void guest_vintr_handler(struct ex_regs *regs)
>+{
>+	WRITE_ONCE(irq_received, true);
>+	xapic_write_reg(APIC_EOI, 0x00);
>+}
>+
>+int main(int argc, char *argv[])
>+{
>+	struct kvm_vm *vm;
>+	struct kvm_vcpu *vcpu;
>+	struct ucall uc;
>+	uint64_t  halt_exits, vintr_exits;
>+
>+	/* Check the extension for binary stats */
>+	TEST_REQUIRE(this_cpu_has(X86_FEATURE_IDLE_HLT));

IIUC, this test assumes that the IDLE_HLT feature is enabled for guests if it
is supported by the CPU. But this isn't true in some cases:

1. an old KVM runs on new hardware
2. the feature bit is somehow cleared, e.g., by "clearcpuid" cmdline


>+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_BINARY_STATS_FD));
>+
>+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
>+
>+	vm_install_exception_handler(vm, VINTR_VECTOR, guest_vintr_handler);
>+	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
>+
>+	vcpu_run(vcpu);
>+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
>+
>+	halt_exits = vcpu_get_stat(vcpu, HALT_EXITS);
>+	vintr_exits = vcpu_get_stat(vcpu, IRQ_WINDOW_EXITS);
>+
>+	switch (get_ucall(vcpu, &uc)) {
>+	case UCALL_ABORT:
>+		REPORT_GUEST_ASSERT(uc);
>+		/* NOT REACHED */
>+	case UCALL_DONE:
>+		break;
>+
>+	default:
>+		TEST_FAIL("Unknown ucall 0x%lx.", uc.cmd);
>+	}
>+
>+	TEST_ASSERT_EQ(halt_exits, 0);
>+	pr_debug("Guest executed VINTR followed by halts: %d times.\n"
>+		 "The guest exited due to halt: %ld times and number\n"
>+		 "of vintr exits: %ld.\n",
>+		 NUM_ITERATIONS, halt_exits, vintr_exits);
>+
>+	kvm_vm_free(vm);
>+	return 0;
>+}
>-- 
>2.34.1
>
>

