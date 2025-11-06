Return-Path: <linux-kselftest+bounces-45021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92944C3CC81
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 18:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B091A4E1A08
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 17:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285B92D7DF3;
	Thu,  6 Nov 2025 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ahhfTV3I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010010.outbound.protection.outlook.com [52.101.46.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E86B2D6608;
	Thu,  6 Nov 2025 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449351; cv=fail; b=hjeWFKEeVJhv40+HFDbaikK/hem97piOTHAIdtWHYzmni3fXGfp/tc/MkXV9g2MzmAasX1g6se+4z/049CNaNug24PZqOt28WciJGLM9APzpU/07jjBJWfvbEFzT6pWEAQ5VZ77CEngSjRpb2TOYLPqkWoymCulEF0bDxZ6CSbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449351; c=relaxed/simple;
	bh=C3/hKlJKKJ7kIdWw0nnjDEwH+gRys7yXaLXPkAUw9ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=anBT6fkRKerqNvWLIIQbgYvrbuGAK5dHIRtexTeXTdxia9mZgjC6NCiBVSbvjeY9G7CVMBOpy9itD4WJyIHNB3VS3pOaU9mMMECbHXc5sFmRspnyX34cxY2NVwLjhmN93A0lDn2P1bjsuu/CcUHj/dPd8naPjKz8/eJMnlR4lkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ahhfTV3I; arc=fail smtp.client-ip=52.101.46.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijp4NediN8TuRfbai8jQhO0TdJZmYC9CIZb1OB215FK44eSHPVR10dtJb0p+lDtTOQkNhmsPdLMuLtlpozVANcgL5tq6ukztOP0qszRRL4Rn8FgbQZAQhRALxGSfoSwXoLJkJet0u85bsR0YIAQVEM2ew3mfEGoBiKHcEw8ggFc5ljuR735eUjq1BcHZduYAfYi7Z9f7rlboKSYRl11rvNXUGz2SVxJ6sWhpGCR08+kCFiuEjkpYMWLhehkWUkI9D/hN20Y1jGF0zkktPfAW/P6gGPvZOSjfKbT+vAZ22e22YDsNF4zhJofDAwR6MeTxAN6yBC3WVgLOfsst38BpBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJJeOcGwpqrMMeSJbtJzWtt7c8rHyAZ/lWBO8bBGJyE=;
 b=n7q2QLKD0C8dCioRaxA1irrr3ND6iXtooVAoYMn6AVl8Aj6F21pcaxPdFzvlpv6bTf0HQHNrH1t2vPTfkCGWY2+HfVe81jeRA5nG1CdH1Jg3F1kkuVbHUEYYzYSzOLQl4ixzMjHzlnVJ5zCRd4lHHYglpB4WWqnJAvqOCLPGbPn7RV108Hzfk8rsztp2OAOfB02fCmXLtKSHHqnV4rLP59eOp7Q6PMpzYPYL+TKFFaVdJpWYF7rVzaCvqvJxw4ebSKZC7zigzk3RsOL/TXFWpyjGl7FcgigDJo5LguCEr8zMXzm6jSFiNMs1TKZiAlWznFxjcNrXffoWIkFOBw4XMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJJeOcGwpqrMMeSJbtJzWtt7c8rHyAZ/lWBO8bBGJyE=;
 b=ahhfTV3IVpxtZFK4WV9dW3DZ6jwCybUdHjsMaS0hb8nxiIOnfiNhvpbfZsA/HpEwFHxYjX6Lv7H9EREJOq7pfqNVB0IItJrTJAMP2oTILhFywK9xJndbEqQNMUxIPi+PRl1xEVb9hg4GM3ISETA/pQ/aUdRXMnCD/34745BQd8XVr3YYE4ZlfsNjJRU+PJEhju5SIt5unFMCM2gPchZoSFzzO+ZrLYlrbRCef/LBvtMWsyfw4IhDhxTeevAxhFO+zrKXimXqzbsYdOgtQs3z0pjCgUkeWpQKKL861SylkQvdwbiEZCtoWEesXXmI9uRCtHoiLSoSsu8bFahqyq+oHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB6159.namprd12.prod.outlook.com (2603:10b6:8:a8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.8; Thu, 6 Nov 2025 17:15:46 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 17:15:46 +0000
Date: Thu, 6 Nov 2025 18:15:43 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Luigi De Matteis <ldematteis123@gmail.com>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <aQzXv0iW3A1W2yow@gpd4>
References: <20251029191111.167537-1-arighi@nvidia.com>
 <20251029191111.167537-7-arighi@nvidia.com>
 <aQx_rJccmaJEOAUk@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQx_rJccmaJEOAUk@jlelli-thinkpadt14gen4.remote.csb>
X-ClientProxiedBy: MI1P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f47f2a-b3e1-4588-9edd-08de1d581fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/EUhuEIiQAtGXpTGVvFckYpvfK0TYQgGaUk7LscfasVmw/FZESVZx0zrXZHi?=
 =?us-ascii?Q?bdEFANCaP5EA12+wD+K1xBZQdJS7UDJa5i8BuAyQibcwHkBI8eZ5yRQrbHM+?=
 =?us-ascii?Q?PGmCJ/DYHbrsRkhQFZDLw6iQriR8J/1vfrVgEA9IyQLqDhB/hKcyRD5pGxh5?=
 =?us-ascii?Q?XDmdzui6bai13XTnE3PxKwgyd3i9JRSQmFK7KRV+68muDcu1iHSxmCK8Hne1?=
 =?us-ascii?Q?VouVzvbNDY3c1yunoNYbk9TvoHcGX4fTGO2c68yNVBcMZOTiFjDgG2fQv2J1?=
 =?us-ascii?Q?q0H+UwANzTjRpl0gApaF6S/NDy2YqAcASMyVovt95M7ZmrfMPsAROyVtR3y7?=
 =?us-ascii?Q?CzTwnYKscqYML0vKetQLtgw2iS2riKZaiRrwVFmrxlCaHMvtN7sdMKvyIPpx?=
 =?us-ascii?Q?Wmk8kaCODhDh6hrjoBplPnRdp1GpsVIjd4uviz8Y1ORNyKbY2YGtEolvVpsz?=
 =?us-ascii?Q?TDudz/5xgej22h4OJp/jcCELucJK8MzEayIFXIuMwjtOh88hfaPbztMTqSfG?=
 =?us-ascii?Q?ze9I3a2T6PV8TTdtVO9iYtpmAB5/DszywZbkgMAu24DSVLPex+u1cPgAS2Sn?=
 =?us-ascii?Q?9ejEkzwVluGb0peettJRnfEwzADzewkuQcv7A31C6Y23nwhHQVw6NvNVGwdJ?=
 =?us-ascii?Q?vKmCZab+6wxSpHvOCJR63qBRzSIzRWZPC7Q+fmml+cLOzEskamhlKN9mwDbP?=
 =?us-ascii?Q?UIqfmIH0Uuot1HX6X11xLSGL4J6aTvNFXjuHiU0PC7fOMVoQgowKH5IUDOl7?=
 =?us-ascii?Q?9+BvL60OhxWwrIAtKJEDHruy1xogFlhmq+4QvP78xbiFQfj1Hb8Vap5GSmcf?=
 =?us-ascii?Q?i5fGL/hl63N/LGXm/XiruDRFfd3DU2FGfkqWgQKb0GmPKjG5/IOVhyJs7AXJ?=
 =?us-ascii?Q?UusN0CyGeIQjisIN1RWFWmH0vV2Uqo37Uca25qlPBuv+jRRmvoCwDX5LvvEW?=
 =?us-ascii?Q?5Ifk6a1r8VLiU6YBfH4tvY+txC7uSXBmbltL5L+TXUc9W4vcX72YBnFHgZAd?=
 =?us-ascii?Q?ZcBrNXSECP+LRclA2BTsMahO2mEvpDvGv3TFzhHUneUVenZ/iivr9kXunQRS?=
 =?us-ascii?Q?PwpJ00aQRvD6lHmtaBn4SEcStn4Ag+44b2pXWGwwc5aPCl2FC8ujVuI7rA1k?=
 =?us-ascii?Q?ky8a6aKwVCf9ho90SEfxCFpkkhpouuKsEHsDPTLlxw9HR1Eno/xsKERL1aoA?=
 =?us-ascii?Q?FjYzQvqV/oMq4yWGmNRYXUgd1HBufd25sRj6LY+yNA47dB5sI/QjH4sBNMUK?=
 =?us-ascii?Q?4BrQHPTlnyXKP+PSZjsH11ehWQX2BjxnNxctkTLmC7Y+hQyoqDduR3lgsqn1?=
 =?us-ascii?Q?4fCFlhakWPYRNPjvDcRQ3w1YEJ9ljrdpyaxcyismsO26iOVDswFHz09acgMN?=
 =?us-ascii?Q?OQ8RjI4YQHzAmO/J7k5c3Inm/gLq5zBqNLb6D0eGIot4o1etaVwueZvNFkui?=
 =?us-ascii?Q?UZPplKkZsFjPWwygHMXcfRu+XTQq7GaU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A9mALIQz0qtP137RpYp3CS+iHjqGoykSU7Z3d1Hmy7u7tbhj+0Aay34YJeMm?=
 =?us-ascii?Q?UkI5l7lygKJQCD2IM+FDK6k0mWn5aRRItkg/hfoNO8toWjTxdPqHCB8nVEAf?=
 =?us-ascii?Q?0SsKLpXlfTU76QUgw5p2S23vxFyWtIY26i7RArP+hQrgUuYgKBY4X70LnjDX?=
 =?us-ascii?Q?Bgn09xrSmLIeM7yt6eAHR+IDrvz+xwYaRMO1qJjMJZKsOSE3uJCB6P9foIZG?=
 =?us-ascii?Q?6HOVk8b2CwJVU3k7EAHXDYno5BqS5ubI8q9xf5SCZ5f8/fSRVFUJJ25xawH/?=
 =?us-ascii?Q?GgnTx+3KLfvu23dWV0V+biCAWSqRkw50VMJdEk3tFgZJpbaVGVs+PyQYwdpL?=
 =?us-ascii?Q?IbMGv01nKofP8KqD6tR+gWO2fPf+g/XiUOGK7RQ3wxh2BNBEAIco3vfijvpt?=
 =?us-ascii?Q?EhCFWBOI1hcxDKBGHKK3XCgXlnEjiOSEVcMKNcbENUUZbQop9l2UGNkFURsR?=
 =?us-ascii?Q?go7yYjtDBPki+bkLvkpGrXoeYeVmb+bxviz56WVBzTpgQhB/+7haUTtTU3Yg?=
 =?us-ascii?Q?8Udp3WQ5SB5pJvOnBpzZX+in4LW5wWcxHrjPIUFeHrxg3H4HdRTWAmCoENPD?=
 =?us-ascii?Q?NZwKfLGCQSm1a3x63q/0Fa6c0cuxQxjh5zsk/AQTtIDMKNkMCcgMURYwCaua?=
 =?us-ascii?Q?AspxQEbvb8dweNyU98rACooz8f6GPnQ179DXotso8cxhB359RZxBpcamFcUc?=
 =?us-ascii?Q?g5hFZrfvTHB7+YkGPeWcbbDj1HboymBXZvkXGL7V9N31m1/QHOZ2HddACmlw?=
 =?us-ascii?Q?GrbfM3zNqhZ79nI9LtfL9fP+zIxAiSUqT8ZFbRGvZhjQVcz8VbZF/NOPRemg?=
 =?us-ascii?Q?CN30ftaCZu/GrYPOhll1pC+ULae8M8j1hRwdtJRDGzjLanC4WWRnGVCq0yHC?=
 =?us-ascii?Q?4VVJq4IBJWP6caUqZ50fdcBeqs3Kq1fDXpnn9jhGqOOCwBsl640GbzMzx4ac?=
 =?us-ascii?Q?nykvj1YohtZVRR2SSMIGxfxiH/HjXcaed1zURuQ29+pI47t8KaOgFLzHKYQ1?=
 =?us-ascii?Q?aImRY+n3Zap8+xhQGNVp315h8ZSjapI1n5AJuwAajyW52gsxuFWhEIx4tIJH?=
 =?us-ascii?Q?TuOHSD13F7nC00j5lH/2ORRkfICmelRYvgdGi+EfbvwsvKNfKv+5pWVNqERS?=
 =?us-ascii?Q?B4W+fSP2iu3aZajRE6lpyyDZjKOUa0d7npvP076A0LHEyr7JgjJ0wfNwYCx1?=
 =?us-ascii?Q?1URKMC2YumaokHLw3jgd7zgDJpRoXR4IJTc8ZggLyqRac6m7pe/jpi3MzuI2?=
 =?us-ascii?Q?IkAr3fzE4scLMsHoTN260E49r7AU4copsGvIA7TqAoS0PfJOqHZNjHmKf5IU?=
 =?us-ascii?Q?Lc5/13s314YnWqaPYppbWQJBtfjL/DsNslrNrLce/hh1QIlfZVGz45TnzT1J?=
 =?us-ascii?Q?2ADXWvwuRZHqARkfZQzd8ThDW7eHre0iGH5y9uix+ayYL+aoCz/5TFWr4F6m?=
 =?us-ascii?Q?4sFU8NMd84Nx4iC8eNkmyOa7vPWKjuoAYV0TmKX3tuD13V2aVIEH5+5vHCKh?=
 =?us-ascii?Q?I2A4ig7vZmfKvTjPmPKCN8JPjbfT6OdCXi0r9fP+ZbbNH91dr9dE09U1KRzX?=
 =?us-ascii?Q?irdupDcivB/p0eNwMQrvVA3S94oYEKCriFNugkxt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f47f2a-b3e1-4588-9edd-08de1d581fd0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 17:15:46.2718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DIFmI0+XXKIPXaIvLlBFK4goevUT1xWzk6B4OYNbYHE7KzyItIzZcg7zMW6XIqaj9MAxlyIa4Qt+bh309rXh1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6159

On Thu, Nov 06, 2025 at 11:59:56AM +0100, Juri Lelli wrote:
> Hi,
> 
> On 29/10/25 20:08, Andrea Righi wrote:
> > sched_ext currently suffers starvation due to RT. The same workload when
> > converted to EXT can get zero runtime if RT is 100% running, causing EXT
> > processes to stall. Fix it by adding a DL server for EXT.
> > 
> > A kselftest is also provided later to verify:
> > 
> >  # ./runner -t rt_stall
> >  ===== START =====
> >  TEST: rt_stall
> >  DESCRIPTION: Verify that RT tasks cannot stall SCHED_EXT tasks
> >  OUTPUT:
> >  # Runtime of EXT task (PID 23338) is 0.250000 seconds
> >  # Runtime of RT task (PID 23339) is 4.750000 seconds
> >  # EXT task got 5.00% of total runtime
> >  ok 1 PASS: EXT task got more than 4.00% of runtime
> >  =====  END  =====
> > 
> > v3: - clarify that fair is not the only dl_server (Juri Lelli)
> >     - remove explicit stop to reduce timer reprogramming overhead
> >       (Juri Lelli)
> >     - do not restart pick_task() when it's invoked by the dl_server
> >       (Tejun Heo)
> >     - depend on CONFIG_SCHED_CLASS_EXT (Andrea Righi)
> > v2: - drop ->balance() now that pick_task() has an rf argument
> >       (Andrea Righi)
> > 
> > Cc: Luigi De Matteis <ldematteis123@gmail.com>
> > Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> 
> ...
> 
> > @@ -1409,6 +1412,15 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
> >  	if (enq_flags & SCX_ENQ_WAKEUP)
> >  		touch_core_sched(rq, p);
> >  
> > +	if (rq->scx.nr_running == 1) {
> > +		/* Account for idle runtime */
> > +		if (!rq->nr_running)
> 
> Hummm, didn't we just add_nr_running(rq, 1) before gettng here?

Oh, good catch, let me run some tests to see what happens here. :)

But looking at the code, it seems that we definitely need to move
add_nr_running() after this part.

Thanks!
-Andrea

> 
> > +			dl_server_update_idle_time(rq, rq->curr, &rq->ext_server);
> > +
> > +		/* Start dl_server if this is the first task being enqueued */
> > +		dl_server_start(&rq->ext_server);
> > +	}
> > +
> 
> Thanks,
> Juri
> 

