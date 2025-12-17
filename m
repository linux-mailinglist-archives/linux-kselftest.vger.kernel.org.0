Return-Path: <linux-kselftest+bounces-47674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3C3CC98DF
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 22:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CA81300FE00
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 21:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA9030E0F4;
	Wed, 17 Dec 2025 21:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EEtYb7FH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013018.outbound.protection.outlook.com [40.93.196.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564EC3093B2;
	Wed, 17 Dec 2025 21:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766005819; cv=fail; b=WtpbNRohaHD29vzOCCWEerPYFJDxTw2U6qKa/04XBOxyAQ8/tko9pdbIaZ6iDCPcOqph+rGgDUnDJ5xjBi1465skPFO2mYqOfEjYlcYcT2aq6o+6PBmWCb8rqCdjNEoP6BqfgqvGDZEYQa5p9Y28f1YeZkrrQvy/kmGVcV/rOIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766005819; c=relaxed/simple;
	bh=nvxH8al/FPKDLCBCHNwGvRG5AJwAZqm6BXw0HKquYCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c3D86aM5K2Q8DBATH2JSsDXntKSy41uwokQ0zX0kz7MvFCdW3vOA4dV+ogJT5hjRGnOgFI77maBkTzmECaoEUAooFa12SsAZLflQMwj+GO0Y2VqpT/jCOiUemiMFiIS86TJTCMyjd0HB4dlbchpJu/Jzsvf/d0niC5V4QA0cHEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EEtYb7FH; arc=fail smtp.client-ip=40.93.196.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nwpjw22Nc99JhJeunhhqjV6L+bEi/QLeF6D61fvxSSCxNJ8ZIcASMbQQFfw+Cyra0hjzsLP/uSg6/As4igFAOkk5xwvc7YI7ohPmt2gQFfEATz95W6e0MJi8GxhO9hg53fxRorWi2WDFDH6/1lnmd1opZ4rHyhhV0QyGxycpfBO4Xsb2zknQLYjUWbpFU2kkl7aVzBK4NwsrdJY4eEq6Ja7fmDbxMh+x+ynegRKdfvdy48ORUi+mlVi6yo3uuY32Ih8RK3hlKKI1oBtylMRnHdtA++J3UsNnZzroWW2UokUs/Hwjb3/pZuGqw44J5I93ysaHvxyWyhxX2Q07zSJGNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iffmp15lSnqlc8xnYAXSSOIpsgcBdtNh2SGSU5XkBxY=;
 b=B+pn8jMe/q4v6IFnQ5dboQeB6YAKp1zzwZFnhLMcN7dW695AI9VHFRj24dx5k4ESVefhp67SUvAeIWti7CbG2qHlAxqTjgf3+QX6APa/GJmioqF8z4HZTbxdD1vSIXp3FrQ1JEiKBp2smU5M+5bziqkslAy1XXAo6HFYzhydHeK2iT5RwMuEL16+4DinvhUCMUkDM+eu9Q7pJu3+LzF6OliOoQvTsWVpTQlUtcmjoVFXZDaA3uGwrT5BtvvDJeqGDuBRgSx6paetrEfvk4EpdnA5+1ugzSAEwn8yOjsvUHatnbCgrfDfzWD9hw4xK14ptR2RSHbvYy3Tr+aNhnCsgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iffmp15lSnqlc8xnYAXSSOIpsgcBdtNh2SGSU5XkBxY=;
 b=EEtYb7FHKxfGe/xpu5iaabAoJIBBQwbw19EO3BZVIUZMntbU4qRtXTZF2usgX34pWnRTErZ+VyGLkMb4xnGBbL0duFshS50k4Tks1Pu0M+aVvoQ/2Thbj9V0gvfeBo1LMaTuNrHMx0ZAneVcU6QH4ReQhJLXfNhbibDkMAKyxjNOtSV3Z86CWFdHfgncYudQPKkwyjPNQxH+YNtjoluA48DlAPTFTcU9tKr5At9Ah9sIZmtzEJ3TWD7mfXpw/O/wMSL8te9ulVKvMNNjW/mtZYX2t1hSfNhManzqZjDYBLy8syu4y+Q0JeJ/gK945Lz6kjKGnG3IWfWOf7JnEAbbXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 20:35:51 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 20:35:51 +0000
Date: Wed, 17 Dec 2025 21:35:43 +0100
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
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <aUMUH846NzfQYjZO@gpd4>
References: <20251217093923.1556187-1-arighi@nvidia.com>
 <20251217093923.1556187-5-arighi@nvidia.com>
 <aULQ7kPm-RqHWGDL@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aULQ7kPm-RqHWGDL@jlelli-thinkpadt14gen4.remote.csb>
X-ClientProxiedBy: MI2P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 7adb9565-43f0-477c-6654-08de3dabde1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?G/ROFpA5L9P8cL0i+IoNyHS8E4wgO9xcgMkVdFZ2Kz7ZhC5LX35Xb9tnY8Pa?=
 =?us-ascii?Q?tpXZcflDdzygkO04c7d9KTlBJlg/Nu4WJuKxT6BptZ2VRZYg6JNhkkxKr7Nd?=
 =?us-ascii?Q?UHu3HLVmKarkoCrKiuHlrb8TFjM+MIPkpQWbGNMWijddCI1IfRJR3N7yDRYc?=
 =?us-ascii?Q?JYapef6F4U8qMkvqTfGotq+UXbklg26QQBnmFcYWjfNibnd2j88TBCARrWde?=
 =?us-ascii?Q?lA48WwchvslN8WPU7VhqWyiAO9De7/evE/WgW10T4JmZ76v5JlTtmS/T3e8d?=
 =?us-ascii?Q?WZrHZEgL6v0izCuyRQF0wlEILgFL9k/1erxTEPimTro0trgDjBTBcDRnKbbD?=
 =?us-ascii?Q?64MnhhVXIqF/uwdnDYXg/Lj9yqU2sOntMz3BufU057oQYYvmf+4qK+wtmDvL?=
 =?us-ascii?Q?8hUSSe0zPmoMIYHjaGeORV5oRY5KEysGsQFr94w4TXVS+ls+/hqphBQt95xa?=
 =?us-ascii?Q?Oh4vxdBjlQlgYpRWCZuxQRLrqMulS7IocJ3NIiumfmOxu0HOj1JsERBp1BVW?=
 =?us-ascii?Q?49tgHMl16P9r8sapHYalwG8auHGwiM9w2ynZWQjUgmKe6XSyKVXR8JcJ4S1W?=
 =?us-ascii?Q?TejNgk4nc2r0Q4NFUDm0AUT/D3eiKRq4uQhPMDdfasrBQJIn2Empf302biao?=
 =?us-ascii?Q?9RSBApfMIkTWwMCbQwYSM+A5aA+1Z6CugpFvxd7n5URcCUD/L2RP9sQhBtvH?=
 =?us-ascii?Q?gmmkFOSlTJvJU13mnpCrTxHvjktpneeeacyn/H1M+/2X/FoQPhHdQyH/yM9e?=
 =?us-ascii?Q?Pvnc/WFPjgy0BOdjXI6Y7O3N5mU/PmJ0FwW/VQp5xv/DkrHtnjNPszL9auTU?=
 =?us-ascii?Q?yh5LTR/HEK7VSAlD51BQuD1lCXgSEUPWGGzokzOqjOSD+gOrmSIPIpI3HdVZ?=
 =?us-ascii?Q?Sww9XrRGuNl9ou6i5anxbQa/TCt1lQL5Qn7N5kAuDK5JVRBn23w6aXxM/E6U?=
 =?us-ascii?Q?4sbYq+2N076lfvEB7byUDJ0qWCPozK2f5ML0c6TSuY8SroNYWjIScYjNjAhm?=
 =?us-ascii?Q?erJCZQw4q1uhRKwFKKXTu/UWvuc/nrrZrv04KmqXzX+6qPBfy597gsJIrAtm?=
 =?us-ascii?Q?9pJPEEjAamC5SkZM3jWUpn6R7+gN/AkDCKTPKPzKqKuM5lODuYYrLv227i1L?=
 =?us-ascii?Q?mWF7OfGpgCv047QHGxuKT01nmSVDlpMrFyrh9YpAqOkabwZqcNQ9pPWoISJc?=
 =?us-ascii?Q?0Ftlw3HDUSd5c0Nts+UTGR1CXKCs+tOiH8r5NkVS3wOwWAvDNbnWrzES8bpn?=
 =?us-ascii?Q?jAvY88jVTAJPPFiIHJNDgCAYMXFJKH7ftjVOJx2xZWjtMP0/TDlq+KCZfOdk?=
 =?us-ascii?Q?cW5WL68Xa7UNhc2nJnCb1iU2nY9i0ymnqWB5B6gS9tK3wZX3Y3HaBu9tkfev?=
 =?us-ascii?Q?pQ6RuwvRM9i6cBYvCg7ZNVITshyAaUcoQuli8WSuFgTwcCTctCdoDa2B8Ku3?=
 =?us-ascii?Q?uKX9sdk9D7ML+rmypeeBFI+G9lutN65b?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?JkzVOMzwSEOJk6GtmvwxSn7vZOJ9oPFiGnAaT/xnJQBGm5N6+pxBdW3e3Wvm?=
 =?us-ascii?Q?rE03u2wnqU4GzN36Hpo7CDzc94Ai6as0XLhSPCw6o4q1NQQCcHpKK/NTbhDa?=
 =?us-ascii?Q?+hq+tSg8OERUvghNWiuoyEtnSPdaR0uvwZHvPstxgkodHJByvFcZVPHYu29l?=
 =?us-ascii?Q?j40wuMnomcSb2dISaDTjSlDZ4buejQI29XjUXktW8wkOgAJ6gFUN7nk1JRwX?=
 =?us-ascii?Q?sSFoRZgxktNRuPQ6xqX+QAoWdZTykuPL4e7dGcSE+jYSOPjmyf2gvkyzkU//?=
 =?us-ascii?Q?1foEJGJRYL3eIrPb0kGQ3B/rSwnQ85KA7WIwRQCurYx3kDDJUOq/hYapgmgR?=
 =?us-ascii?Q?pses5nALh2Wizvt9sKASVZHVThijcD4NqX7WcypNXAZn7Y758VCvp/KauWYW?=
 =?us-ascii?Q?gYlG//WYzo9MYgveOtQbXJvfkgRX7UIBZw/K0m5AaW21whCf3MhlMJWJ09sO?=
 =?us-ascii?Q?kulLumKokzbFNInyS/nXo10OeAJ1Lo1/peGr0XU96Ip7em+XHam+RChyFlbA?=
 =?us-ascii?Q?F16aSH7Bv+338ktivzx5bqEfumv5WMfld9luAn/hTw7VH+carw6fkcW5c3cb?=
 =?us-ascii?Q?GoYfYbuAeR7ZGC1cZh9pZhCCz7jihohpGO8pUFBg2JporRv6rZxeQ4afeXG2?=
 =?us-ascii?Q?qH4ESaZWTuobWZd49aSuDMxhKfc2ZvJmahSEl0cZZDGw529lPhbgtcVc7Kzj?=
 =?us-ascii?Q?ReVX9u5y7bPDN30k97GV4/VtCOZwOLOSf4iWO8eXtrAeiPA5NK6tcLBaf3sm?=
 =?us-ascii?Q?w0Z8PppAnwUQiAIHtG4GvyeLsz40Vl5EdWJ/ukqgdbm+3jJJH1t2NdS16vqQ?=
 =?us-ascii?Q?jPRk4o57hCzBoxYwnffjH1IN4wijNtN02ox6s857h2alKRotYODi8DEmpy8H?=
 =?us-ascii?Q?dazM83hpx8xEsJsJCr7y7qzBBKQcsx/dYxRh3ss3e6DkHb0E9+lip6oBFUtD?=
 =?us-ascii?Q?ssMS/gK3U5B6awRh2Pt1uyI0pB8/d60GcBZeYwawJ/s7x+v6cTPcybVcoGWa?=
 =?us-ascii?Q?XIbYuzPhX37eBa3bv/N91xiYamcm2T3x4FWBwOhOyKyem+Wdh7KpPwmR6kik?=
 =?us-ascii?Q?XRkYPy/Rgbtqg6nGzef0odTruWxovq07Hyk6XRo54uL0rLqDB3drAGiKuhqB?=
 =?us-ascii?Q?jJ1oArK8QanlfEtFTNzHAuGpyGpuZQHfDc21xkIo4gmozm3fbt5gxIoV53F9?=
 =?us-ascii?Q?rz+k+XUyvjG0viNTg+Bsy8kflZ7nSp6KxgV9SO9R2oHN1ru2eE/yAmRccjnR?=
 =?us-ascii?Q?uDqRprjJ6glRj45ZFMAF9MduKiyxOmvZ1jNNUQ0fNhM2osoB6T5Zc1bO72sb?=
 =?us-ascii?Q?5SYq/Qsuvn+LKAhP4c2fsh/al1jt5OGfmpz0IVAZQJkm77SEL+BHXTqadD5S?=
 =?us-ascii?Q?Jsvc+mkfO4cxGWNJzKT07kPvvMak/zQYAonSOZXhhAzZ1WhFNq0RdYbJepl/?=
 =?us-ascii?Q?r5SOCW3r7xGrK1wyFa3155pZRV5AICQ2W9XJPnKVuKHzADv2wMV0ly15Abpd?=
 =?us-ascii?Q?5kc1LAsEGGy/sY4hIxz1CL0UvTdoiip4AHxqVlzi6e8bG6lZcU8jzrmrXjAC?=
 =?us-ascii?Q?ZIPpe4VpIIrMcltHXFwIhAEIC43AsHNR56Mar1js?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7adb9565-43f0-477c-6654-08de3dabde1c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 20:35:50.9880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngp8qtXB+O4qoBhXQkNwDLCB8+DcvlCWCZres/ID/Bfo9cQtKw7lWVLHbeqWbQ/udNzby/YuCCKZGymoa+4AkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628

Hi Juri,

On Wed, Dec 17, 2025 at 04:49:02PM +0100, Juri Lelli wrote:
> Hi!
> 
> On 17/12/25 10:35, Andrea Righi wrote:
> > sched_ext currently suffers starvation due to RT. The same workload when
> > converted to EXT can get zero runtime if RT is 100% running, causing EXT
> > processes to stall. Fix it by adding a DL server for EXT.
> 
> ...
> 
> > v4: - initialize EXT server bandwidth reservation at init time and
> >       always keep it active (Andrea Righi)
> >     - check for rq->nr_running == 1 to determine when to account idle
> >       time (Juri Lelli)
> > v3: - clarify that fair is not the only dl_server (Juri Lelli)
> >     - remove explicit stop to reduce timer reprogramming overhead
> >       (Juri Lelli)
> >     - do not restart pick_task() when it's invoked by the dl_server
> >       (Tejun Heo)
> >     - depend on CONFIG_SCHED_CLASS_EXT (Andrea Righi)
> > v2: - drop ->balance() now that pick_task() has an rf argument
> >       (Andrea Righi)
> > 
> > Tested-by: Christian Loehle <christian.loehle@arm.com>
> > Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> 
> ...
> 
> > @@ -3090,6 +3123,15 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
> >  static void switched_from_scx(struct rq *rq, struct task_struct *p)
> >  {
> >  	scx_disable_task(p);
> > +
> > +	/*
> > +	 * After class switch, if the DL server is still active, restart it so
> > +	 * that DL timers will be queued, in case SCX switched to higher class.
> > +	 */
> > +	if (dl_server_active(&rq->ext_server)) {
> > +		dl_server_stop(&rq->ext_server);
> > +		dl_server_start(&rq->ext_server);
> > +	}
> >  }
> 
> We might have discussed this already, in that case I forgot, sorry. But,
> why we do need to start the server again if switched from scx? Couldn't
> make sense of the comment that is already present.

The intention was to restart the DL timers, but thinking more about it,
this appears more harmful than helpful, as it may actually disrupt
accounting.

I did a quick test without the restart and everything seems to work. I'll
run more tests and I'll send an updated patch if everything works well
without the restart.

Thanks!
-Andrea

