Return-Path: <linux-kselftest+bounces-5893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4862871719
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 08:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02AD28469B
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 07:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230B97E58F;
	Tue,  5 Mar 2024 07:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TkD8qXDb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922F17E593;
	Tue,  5 Mar 2024 07:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709624394; cv=fail; b=DEMIcUdoYEaOq1NzxVXvKPGJXegXKPnUbSayW4SPySvmmL3j0ewG7T8F4VPxN8ed5qvEmgMCbsIQRQtRLpnCmfuPwifCkjDj3IhyrcfbSWEI7VjRwKLuhSM3y4MRvF8nvT/wVDmX/wwOrsACWp7oLFQASgpQfYS53ZjhwXSPCqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709624394; c=relaxed/simple;
	bh=ov+dEunALEC5WNzdepGVukG+vRxuWKitPGTZgan5qd8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hPaMnXV39ovo7pdnCiW+ln/quUwX0O5frTxGVzbhrz2it8R2WEDZrNgazz0bYVLsHEiIBRZjpKK+Km6NV0Qxj4vuX4qgIkuZEQEinkYrl/E/gwAh+1oT+YAYkR1bf3garSqFyBhZzJOoc+glom/RPOgi78WQEmLUI8kz7tbdfPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TkD8qXDb; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709624392; x=1741160392;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=ov+dEunALEC5WNzdepGVukG+vRxuWKitPGTZgan5qd8=;
  b=TkD8qXDb4rusrweOGmv+ns2UjHpkWKQqi2VC9Mv0QXAEVob4Y1puTH43
   JHjXfggJ0Ct3PorhpnyuTslXI2mSkCEkqaaPyvdoCSleW+LfRRJQ/J8oG
   gk15d/bzPlrdgskAkk4tATEq1sNWxkLMtHK6NZc1WsfuAL+7R4qYhIJmT
   XWj0RmY0hOyPekoNCliXGP8wQ4qH8MuvJsumS0O99sxN8Z6EWlAJM7fa5
   Yvm2bJIZWIHJX4lWQp3b+WKyQn18tdRgf3KVDidakaQ16u+zxiP3vLlh6
   uP0pqAvaUXoGwPCCJNQfIM4JJJW1c3N2Z2Lr+du5OIwjCCVXSkcZA1Rxd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="15586569"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="15586569"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 23:39:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="13777367"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 23:39:48 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 23:39:47 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 23:39:47 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 23:39:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENpo236j1kAQRIKGLb7xf0IjyKUAL9AXWcQs5VgTb8yafbV22FBvGFHuTfCCBxNYkjsKpJxLTBhTLe+OfrEfvqxx21wS18kPwP5RHhZPCmj0hWTn2kQJqC2fVJcwVlJjRE0lh56zJ9SNN69MZ5no9QNtUrdwV8Cd81hikS/Tv8BoEG9m9YtbrzXOR5uDOxMffzj2NwDYCViSBenSyd57y1gZK3d18iuOZ0f3K3zsatR8rWi51c3ORFC3PI5zXY24DXrCNOZ+1e1IeKAbcaJhTKvuamo6SehyPG2cJhrPCJZBXs/WyI4pC0gCcQ721xXq7lb+GcntdjYgOd3Ji2Wwsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ov+dEunALEC5WNzdepGVukG+vRxuWKitPGTZgan5qd8=;
 b=V3uvMLOxyIbjnLcOlrAZ90h7jEin7W1EP2xVVNNPVOOcYqlUA01py+5/1WW5Ca+ta4nwDs0GCH/NImPP1NRvihVC2xfVgkag4YSJlrz+V7ftEhNPBJf62Gg6DuI8vOdmU0CX6iarVGkbvXyWrchDYHWzpkoEUcl1F5xVY7Qj4y4GsO79yrN4zUFX/GY58XwwZfF2RW1Bp6oJyTMebav8ZvkJniA1aVzbzZbJfvImAehQ1hHUVmKGq+gtlb7bJEolGBm4dngvW57/ADl0OrqXddNoZ6MYX6MQefl0i7EQiZaj1xeN80CEqlydcL22uy2ToelX1/+fcnWePAbDA1BfJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 DM4PR11MB6357.namprd11.prod.outlook.com (2603:10b6:8:b5::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.23; Tue, 5 Mar 2024 07:39:45 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::55f1:8d0:2fa1:c7af%5]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 07:39:45 +0000
Date: Tue, 5 Mar 2024 15:09:52 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sagi Shahar <sagis@google.com>
CC: <linux-kselftest@vger.kernel.org>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Erdem Aktas <erdemaktas@google.com>,
	"Isaku Yamahata" <isaku.yamahata@intel.com>, Sean Christopherson
	<seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan
	<shuah@kernel.org>, "Peter Gonda" <pgonda@google.com>, Haibo Xu
	<haibo1.xu@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Vishal
 Annapurve <vannapurve@google.com>, Roger Wang <runanwang@google.com>, Vipin
 Sharma <vipinsh@google.com>, <jmattson@google.com>, <dmatlack@google.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v5 17/29] KVM: selftests: TDX: Add TDX MMIO reads test
Message-ID: <ZebFQOQMjZAA2XXN@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-18-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231212204647.2170650-18-sagis@google.com>
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|DM4PR11MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e70175-9676-4538-dd26-08dc3ce76d36
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c4zYJNywUSuFeXQbdnQJH+ugJCV4uSz25hoJpWZ4HxEPv0P3QcDcZSwBGyHQBrIS2RAnEHMLeYRvlCVrwlyzyoZophhZ4KBJE2NMSbGpHxFBc11NCmlfqCl4mmCvi9scp2bfbckP4o2yloWllhrxrEi6/zXzQ3CaLR/SW3/qGkT1Aq7/LXh9EH+cQRpc1xRw+7xqtuhIDoaPGAyvqeHDfHRxz5eHYmjgHGxVGyCcKBsOgdR4j5q6eoP5K3AwTUKxZKwHFlWeieEu8glwXSx0B7DgoIYaDoGmbBhcmf+gYnE8jf1gnrU3bM8p0YAtA4Cyzd8RHQxKl5Gw8k82Nl4YPp8cmdgj2kVk+oMpbw2b686osSPQcrDZg6xatJe/gU+BrB9MXpcnj2nHDeBcfAdcHtK0ctbD9L1aRnwL3f6UORFO6GucJY0aw2efRkBk2K8il91w7h0+3GnrzwjEVY8oMJKRh2DFtRnLf5cgiMu/+LwOGwOoy33lLJ8R2L0HSWQuWCemyO4R6Rq/XE4xOI3OomX0ZoFaWbH7iX2afvxeJi1x/04ChBmFZQryS96Pr56l1y8tO0l3FUTUuUaCDH8MI0anZod5iuK3DMB0pf3s2wHhCdBx7/TbfgFffO42Y8TqN1TctWI6roV5Su/3fIOzh0xqfoTEm6Z/5Jowy/TGtz4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9mvkgJaUdsu92zB+odRIuGXLTevOw98wyRKCAhZDM1+v7uEmKAiQ6KJQtNy3?=
 =?us-ascii?Q?BO076SzGQ/TesnR3i/rlxLrwdC3HthD8BaM6mhmM4ce8MeTKEcFDPoNMrqsQ?=
 =?us-ascii?Q?4dqDyM7ubUP75K+YkXdRdcXEqXnR1O4EmkJqkQ+aRvKHlO7l9MJpkDYhU2Bl?=
 =?us-ascii?Q?7kjoH1SxZ4jE0KYa87vJNb5VvOiaZI1f6WBAOdMymC+WQyofrdKi527+qEmH?=
 =?us-ascii?Q?RJSPJ4LHpWOJFL9k7wzW9Q9Y4rayaqYu1jdMwpWEXf5IUdiw7tpYVWyIpcuK?=
 =?us-ascii?Q?7Fabvbtr9CLFN25iOvzEYEdOMerVfnzviUhT+n8s8vembR+zjvpSntwaWSJ6?=
 =?us-ascii?Q?FaLu4LtHOM32L/pKmmHv8NqPJ8OtVWFNuySkjlftPdn0gy1a7xiormxXqGLw?=
 =?us-ascii?Q?IDTLF9oQQKBfcLiD9NQk3NtUhxhnXs9S5tXLXeXzg5ufcJCYEK5hPXawg/81?=
 =?us-ascii?Q?qB/nUOFoXm1yS5a9C73x2yPXDoHQWKNs6DuBNKn25iVBsCduvSRBEEnBsoEE?=
 =?us-ascii?Q?lMsjBuUSEu66iiVk4yzIohTPp1C/GZk8M9DcvWAMIg3JQI2tfBh970E1iPV2?=
 =?us-ascii?Q?da8Oj94ZdxXbuXfMWOEZIeJBiEhCVwB7ZJtvdgHA5+SrnXc/Rh9LDAcviU/Z?=
 =?us-ascii?Q?Nzay8YvOTFPh7SonNoffWGXnVgp8yNegwSQxDy6+Wal7ocSKlJcPqqVa/GIX?=
 =?us-ascii?Q?qctvDM5m8GAoMlSa3z3E2opvZK+TCh6DA94exRyFB/MRY9ufLJHubi+aqDBk?=
 =?us-ascii?Q?pdMwSj1SEe+3jHNk8g9NDbJ6JjFFaYT9GBkTEfrt+aOoklhGIwd4CzWHNZZn?=
 =?us-ascii?Q?gMlgzV2ogYNMmy8ZE6gQjn9hh15o3V/fBwaCosYZekp2Xr3LBa3xqW3TUAoo?=
 =?us-ascii?Q?jUsfr6TQRruBJFje2k3odfg9wjwrXxzA/PTHbYlJvCACU5wJ/H3HCltSgXS7?=
 =?us-ascii?Q?PmWUsSi0GnZ58Y+dLih8P4I7qlmAZ3rSJ8wAUYMP8qAyVds/7j0lZBsIbqGG?=
 =?us-ascii?Q?B3ymyVE8+l5baaMhAa8+Jd88qvsM0lv1av1dcR8Y5x1AfpOE6qpDXFd4Nw5n?=
 =?us-ascii?Q?1Jjl+hBEEKvCbK4p3zKqcvhWcwm7wLr9wEnZyOzhy2+4PRqK+RcMZtVOK1vg?=
 =?us-ascii?Q?5l/GOT9O50YGENAcy4uBjxNPB0R9BBuK/XPe2j1r0gSSkNnkIKsxDaYJyNID?=
 =?us-ascii?Q?yFyrHWZ1pztvLefttDPa1PT4rAk8bRNpsSpOWUq0F1Mgv7iEG/Kl7PZdC2Qp?=
 =?us-ascii?Q?HalfcqqOPZF45P1c6RhjbnOiciD4yRCKi8Wji5SnlmB6GJlyTeh1PQ5lWfOX?=
 =?us-ascii?Q?pfypHCxymSpClEbE/4seB7UkvCtqw14QpTib5XgTfqTZ5IiGUUkEoXgvKgh0?=
 =?us-ascii?Q?i/S1ULXusuVXcXJLrEsvjnKhcP+wBebBny1U1uNtnFAgIYsR3Sqt0jeyBpGA?=
 =?us-ascii?Q?raOjfKHNAYQlTm1OP3ZnlFnEJpmptxTbgrMJMmPB8N6/Z4bIWSg7cXx4/Edq?=
 =?us-ascii?Q?JBSUlEQDii+kkN33mVhu62h41+Y7pXrt0EBIuVg7jA72grT3rcFg6Ka1REsK?=
 =?us-ascii?Q?hoFcdQAsg6/vkUQ7yQf+pcW18kYri6eg+uOd9aMk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e70175-9676-4538-dd26-08dc3ce76d36
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 07:39:45.0914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00PmxS2Ukc+sqGBcoz2TBP+ZbVj/j6UaBJgbZ1j18a3KmAmqhbDn9ck87KmKawe/WT/gX0nb2V81oBUZpJqa2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6357
X-OriginatorOrg: intel.com

> +/* Pick any address that was not mapped into the guest to test MMIO */
> +#define TDX_MMIO_TEST_ADDR 0x200000000
Also need to test below MMIO addresses
(1) GPA with shared bit on.
(2) GPA in memslot

