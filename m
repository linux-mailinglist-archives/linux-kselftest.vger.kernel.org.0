Return-Path: <linux-kselftest+bounces-18286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 192919841B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 11:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BDB51C244A9
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 09:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ACA1552F5;
	Tue, 24 Sep 2024 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JtHyE3fx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD097154BE9;
	Tue, 24 Sep 2024 09:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169129; cv=fail; b=hL9aMzfEp/2pAcvavlMWssGw1Uto+slteYRx9W+5NA0njpYn/RhV3hjXZCx2HUeX5XmMWoJ7CvItriVMW2czYVeox0jODBUD06VCDw0L2p0/f7u5XBlb+sQkZS7XA+bfUwZLZOCHngdCIlQ7R3IBYrgPQVlqJ9Z7KjDyWi4kAzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169129; c=relaxed/simple;
	bh=MKbqffUzA9KjCu0XtYGZT+BM1GI8GHOndd9mEdPtmM0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A4jx71Ro+j7RBot4WsYzbuTBlnXTylgwYM5m1f05+6ccgr6JIcwmVgZCuAAnrX6cFAKGsQDL/6pRWRNBeJ08vEPbUOkiCx40okZc0BMvqaVIyAGgsHrk81w3RqKEsUkTWODJU/ix5me8StbQSi/lIewzktu11UQ3k5t/kqZB3QI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JtHyE3fx; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727169127; x=1758705127;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=MKbqffUzA9KjCu0XtYGZT+BM1GI8GHOndd9mEdPtmM0=;
  b=JtHyE3fxmm62mjb3I//lqibVk4VsF82UMa7BTHSAwWFERiUIqduKY7qK
   rcvYe5qXTwYG/NcQ1jPPkuRyL4RpzOOKif7cwxbZQlw4kQ83+smwwu76S
   3KIaW8ON95AtdL8VDuDVnqSVJsmDGOEI3u3g/6bxR5SvoDjjPJTmzI2NO
   sjxxaGlC+qZvDdN86JhUXJaJAeh13eGUpBIb/MjRKDLgv8E1hiJksphzc
   5H1Dn3xYU6F9TYQ17eg+Lwrb/F1/ZWZZ+JCwCl6cnGOGUVVUq+1u6++X/
   Lh8NBAn0DMMidRmu6jM1Z6VtiPokFwcAwJPk7Erc0AJrExNcVEhCeLTg7
   Q==;
X-CSE-ConnectionGUID: r3XrQNotSB+q3vcL6DTwXQ==
X-CSE-MsgGUID: x5R6P3B3QVWtzH3e8Lo6IA==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="43670280"
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="43670280"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 02:12:06 -0700
X-CSE-ConnectionGUID: vdj7QrLHRfGGZKGUrYqt9g==
X-CSE-MsgGUID: +Glw5lvYSKGeddpbYy6HfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="71408920"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2024 02:12:06 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 02:12:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 02:12:04 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 02:12:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Sep 2024 02:12:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 02:12:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIo3fTwhTtzLzeHXVwGPZ56W/CuXe6dojAdDUc38s9BNevjg33mFTPuGolAj4q2uF5dBPRyrJFFnE9fY4A+6yA6Dd5r0vHp9iT5twrZUUYsUS24Ky38h84iBnLb/TWr1Lc1xTNAwhJwXzd0MEhQ+v2DZtaaqMHwerHYFR6rnLkuiYdiWZlhhhf3JSCVQ1Zaj52NZC95MbBq7VabNMX3dOLZyDQ3LC5rPsdTlTVRPqiXCW4BsDIzsAUG19H3qw1F2sg8HKMzZq+FMvmUZtlaEqGoiH6pO3Lx/VvGti76dqqcMgc7qQG3fyF2Otl/yX1kRPamxx2xSfHJXudCj/8YsWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwGzu+iRCGnG46cixjarcCStYvNPQKNTH7hUP3LobaU=;
 b=f/e/mq1tMR8rXvz7QvtiyeXcotV7a0XwyMwt6v39jYZtUqBlihvrRC3k282lN8xyBaeTPaE/e1C484lmBYpTf7AHK7jv1jITZiWv02AlIKHerZQMeuyUtio5TlZC4npsNgY/CXw7BkOIKeO97U/zL1Z7en3Y8QZPrCHwTjqpHbAQN+FawJpSNz9bfRgpY8H373QUt+Rac0uldf8EJOxXFeEdtqYNKZgwfyBZLCmWVH+GwD8ibv40Fp3Ct7MHP42zKRXHFVpk0C7P4XYNPwSHzGPDnJR09Eq6WkcEmqFSKED6jcURDrscZ48BOQDS5c6e+MXpKqf4eemW6V9YCwIXEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by PH7PR11MB6980.namprd11.prod.outlook.com (2603:10b6:510:208::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 09:12:01 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%3]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 09:12:01 +0000
Date: Tue, 24 Sep 2024 17:11:52 +0800
From: kernel test robot <lkp@intel.com>
To: Ba Jing <bajing@cmss.chinamobile.com>, <shuah@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, <bajing@cmss.chinamobile.com>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memfd: fuse_mnt: remove unused macro
Message-ID: <ZvKCWJ+7u+wpgfyl@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240903044455.11268-1-bajing@cmss.chinamobile.com>
X-ClientProxiedBy: SG2PR04CA0162.apcprd04.prod.outlook.com (2603:1096:4::24)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|PH7PR11MB6980:EE_
X-MS-Office365-Filtering-Correlation-Id: bba378bf-cfa4-45e9-c3a3-08dcdc78f30c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2kGNZTvAbcTQOgGKZbdr96UElYtBLG6FM0+cIDfi7+QgVZSu9RxZ+bdZXk22?=
 =?us-ascii?Q?kMbcOEjnKJfpfEpQnZ8zAckWQouNdK1hbEC1/qV/eloxLhvlcYn3PUdVYj0a?=
 =?us-ascii?Q?j/ZiyqA5SjyKARpVfWFKr5WOPE+8MpJ9KxCz3gbHSNaObf0ruYMmdvqH5uk9?=
 =?us-ascii?Q?6X69CFbGuDJP3WFH3UtaOnvDzZ+6vcK++wyMxr9EKhTMixmHZZitYLCv6gOg?=
 =?us-ascii?Q?XnFAsz7yQmXXwXtZitoegxejPurB1B4XsHhZgzLmC5rRccqWybVQ6XLPi6C5?=
 =?us-ascii?Q?pziY0x7++Ibcm9nQcMs9S10y5CRPrWSChNeyNsZIpHmBDkMko18YgTMjsXPz?=
 =?us-ascii?Q?xTMIVLNE+EIHyGnwRSyGxiezGlOdQ67KqFJY68am5VVpSX6Z1OjkIYRKKxrQ?=
 =?us-ascii?Q?IA17pURJMD6jwWbbq9Hv7unq+xJrqCNls7eJG+sKOkAkH341LoFOelN/wE1R?=
 =?us-ascii?Q?fHXtmhPg+7rGQcbou2ZLkDmzOMm8MBNx9OJTONinPt3+qhQJ5zaXwW+LC1LS?=
 =?us-ascii?Q?stL9ZHXTfWpPV6fqtAL6hKV5JMAhZ847MeWNGQEu6CXo6gQWv724/TizMsAW?=
 =?us-ascii?Q?BG9wIa6RrQ0XlOcde5htaC80kuFAhkHXQ2JNM+6TrZlW2+pBwfYrX4RoKI10?=
 =?us-ascii?Q?ZEJbFZIS0J6KMcLfASuc5bhCROKK1OUi03DB8n6I4/TzWDweDcsEI2DNcv7k?=
 =?us-ascii?Q?AOA/FQ8nNcM+XguZIxQ6OWKTZ+B0FC4hDsn4iTW8pOlT4ISnmqszHZggbIFa?=
 =?us-ascii?Q?gX8b5/i6BfxYUY7riFxCPtY4iRaX8F6fCByxrTqd8s4f36s19fb73/41//lx?=
 =?us-ascii?Q?3q5wjodcGBEW2IT5xGqe3IrO6zaM3dwHXU3w7AAJqYQjgU+JrKkqTxQxVysI?=
 =?us-ascii?Q?fAbLQkJv0VKflP8NSMyCyUEsTyv7Xge6r6BZhCkFFxdEG1rrNe3E/EhaZFUJ?=
 =?us-ascii?Q?51CCBa1xVSrzXE2eK3qhLpO3iJX625n/JnX7C+fMcPpm1CzsXmtNHEYo+L5y?=
 =?us-ascii?Q?eA8gjlnoTxUb3OIedH4P81noIhscaAnnf8GVv1Tktobvaq1tpPzsXwYrIXpL?=
 =?us-ascii?Q?eu35mreD4uG+QMLVJ4KURAepBBLLS8fokeS4IQI07yEC2R176tYldREUIIMf?=
 =?us-ascii?Q?6dS2/4gwYj9IeGPYmE6VmIS5oEIJho5lp4IiKIntPja2Twy7qr1sY3Pd8thB?=
 =?us-ascii?Q?9gEpBnweOzaQgHR5xAgRS+LpUD1n1rdOXf/SJU7lHbfh1nEmf185otaM25Y?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?45qta8rFc1LzswDA3RVdMcjgODA6BBETLa2B1eZ7cSDUZBvk2uKYViSjDa/s?=
 =?us-ascii?Q?AAnQoGgVd6QevKKF1RYCED5xyl5+OnpRyOLVzlItpsq6IqGP04v/k4LGAaC+?=
 =?us-ascii?Q?DsBC4nZxll1V6aVNqIBNZujyD39nsbWZr3YF+7TmUZGyeBlNsdK/hRiCI/g0?=
 =?us-ascii?Q?37VEgG1X2x1Ao5v3//SfR4WV1lFl69tyb9VqP5rCBfQyWvJLq1BiNfLff1jX?=
 =?us-ascii?Q?n5XPxSDqnv47Gv1HR7sX4bkfCmm+5mOqYUdnVYj+ylZzsQSy8t0qs8sz4JUC?=
 =?us-ascii?Q?7QEQm9sA5eCUvRkRLEuuNcFb+zbodI6HFQNAK8NBuL7opYa7Ns5jdSPaUHJk?=
 =?us-ascii?Q?s8LKYBaeP2bSK6EcmI5vQbS8WchVrLYE/gS8xY2rf2QU+8CjrzgG8UnIqpNA?=
 =?us-ascii?Q?Sfm1OG8hQAjpn8QEz5SdbOcQK5car5GY8r795FNXp2FNEU2KiBEFsNU+IRHG?=
 =?us-ascii?Q?b3xiSXhj7mZo1VAK88AlhYmgaEDg1gMbIzFhYmh8l6PspQo2Jbg//G3OWbeK?=
 =?us-ascii?Q?4uINJXWYPAddeqZ31nwYVU/dFd74w6GENUaz3r83lWPkdOqpDQN8X2Ob3Ov4?=
 =?us-ascii?Q?DuJyUTNzrFPa49MJ2I/D5HhLQBYNvpIGVNmOVhbjcKfTGky7rceBEbRLvxe0?=
 =?us-ascii?Q?AGeVPNXbcb7slYiRgsiwm1OH+GMa45aLSQnjD3IvE0Qm29jLmKop8xz0CQT5?=
 =?us-ascii?Q?n6THdRf5fmO+adH++NJShVo9q4SwqcZmd0BbF+qmUzVkXC8VpZWlX2tMJMdW?=
 =?us-ascii?Q?sgW0hU/2J0YBYLqfYXD3i8iXIuoa29CnsqQIP+KNs1K4HB7I0BY1l99kSa1K?=
 =?us-ascii?Q?nWE85jPQYxfGKtGorwSejBl9q6TRD4MVrJldXwbx+Nqht8Ovyx+GSMJczRSs?=
 =?us-ascii?Q?nqujyPoeORp+iPjv6zLTySDhZj8b67VYhZxYeVzEBr6+uFaI8HqNpUOjkklk?=
 =?us-ascii?Q?2XnxEFgu/TeYzhZezMSBsSs8qDhSeoP/HmhToCB0BXeOAajBzdUnyepbTNGv?=
 =?us-ascii?Q?q8nrSPZ/mRLjyor9HxlHA8w+ptanSMb7Yg/XREy9BEyisljDY8mqPmHkbeix?=
 =?us-ascii?Q?zdp+Y891LiNRGyFgJnH+I1lZ7dDdvPKJ/ei4TJYE/fmjgnhs7rofxPMOqLHJ?=
 =?us-ascii?Q?HNpt8vW8VwlpIlhV02xq9/8GHxzwyjTvhhTvnoC6XMhw4TWOe1s4snVIsqGN?=
 =?us-ascii?Q?NejkVY/njstA1CdRWj+hjGjA36asaiKX7Ec/TaXCc8WNKfPdlvScnG6yJl94?=
 =?us-ascii?Q?JzN0tgm7iY0ipcHiNvuPXTwjGhfKu7e8I+7TF/YkJ4Qn7GH4gl/w7xSLy1Ht?=
 =?us-ascii?Q?pfqyi0ivBgRgZpbUVetqBkKHxVDVHqhMArqY3Rz9g0zcFdFNqvg5YlGLx1q+?=
 =?us-ascii?Q?ZXnfbz7z+P0+yy9RDREysyqkvQorl8LweBpbOnDI0KZ/F3o8NSVvM3eueUN9?=
 =?us-ascii?Q?OD8yAQC1t7ocbuVpDpItxXTUSzcxTUeeeOaGddZqaQc8zpoI8/ppVy/vP+QU?=
 =?us-ascii?Q?nEXLxQmEwmQpBCXm1HKM5GxNgCdsiqcRn8IzBEKt4hz2z8hS4BEHmCuYbSCg?=
 =?us-ascii?Q?7efvF47Qi9Z7EOWaSCh4CgwcgvnyOwxD11NKTyuv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bba378bf-cfa4-45e9-c3a3-08dcdc78f30c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 09:12:01.6859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dMVAP9LDjJ0NPjVTNkcuZmt8VO7gJbm5imZSvQURGTJ8v14dMU/MIeE/oxNH3YpQZRXk+70ILbJYkLkY1WUH/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6980
X-OriginatorOrg: intel.com

Hi Ba,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shuah-kselftest/next]
[also build test WARNING on shuah-kselftest/fixes linus/master v6.11 next-20240924]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ba-Jing/memfd-fuse_mnt-remove-unused-macro/20240923-161950
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20240903044455.11268-1-bajing%40cmss.chinamobile.com
patch subject: [PATCH] memfd: fuse_mnt: remove unused macro
:::::: branch date: 24 hours ago
:::::: commit date: 24 hours ago
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240924/202409241613.KyXs9fiF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202409241613.KyXs9fiF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fuse_mnt.c:101:10: error: 'struct fuse_operations_compat2' has no member named 'readdir'
     101 |         .readdir        = memfd_readdir,
         |          ^~~~~~~
>> fuse_mnt.c:101:27: warning: initialization of 'int (*)(const char *, char *, size_t)' {aka 'int (*)(const char *, char *, long unsigned int)'} from incompatible pointer type 'int (*)(const char *, void *, int (*)(void *, const char *, const struct stat *, off_t), off_t,  struct fuse_file_info *)' {aka 'int (*)(const char *, void *, int (*)(void *, const char *, const struct stat *, long int), long int,  struct fuse_file_info *)'} [-Wincompatible-pointer-types]
     101 |         .readdir        = memfd_readdir,
         |                           ^~~~~~~~~~~~~
   fuse_mnt.c:101:27: note: (near initialization for 'memfd_ops.readlink')
>> fuse_mnt.c:102:27: warning: initialization of 'int (*)(const char *, int)' from incompatible pointer type 'int (*)(const char *, struct fuse_file_info *)' [-Wincompatible-pointer-types]
     102 |         .open           = memfd_open,
         |                           ^~~~~~~~~~
   fuse_mnt.c:102:27: note: (near initialization for 'memfd_ops.open')
>> fuse_mnt.c:103:27: warning: initialization of 'int (*)(const char *, char *, size_t,  off_t)' {aka 'int (*)(const char *, char *, long unsigned int,  long int)'} from incompatible pointer type 'int (*)(const char *, char *, size_t,  off_t,  struct fuse_file_info *)' {aka 'int (*)(const char *, char *, long unsigned int,  long int,  struct fuse_file_info *)'} [-Wincompatible-pointer-types]
     103 |         .read           = memfd_read,
         |                           ^~~~~~~~~~
   fuse_mnt.c:103:27: note: (near initialization for 'memfd_ops.read')
   In file included from /usr/include/fuse.h:9,
                    from fuse_mnt.c:15:
   fuse_mnt.c: In function 'main':
   fuse_mnt.c:108:16: error: too many arguments to function 'fuse_main_compat2'
     108 |         return fuse_main(argc, argv, &memfd_ops, NULL);
         |                ^~~~~~~~~
   In file included from /usr/include/fuse/fuse.h:1012:
   /usr/include/fuse/fuse_compat.h:151:5: note: declared here
     151 | int fuse_main_compat2(int argc, char *argv[],
         |     ^~~~~~~~~~~~~~~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


