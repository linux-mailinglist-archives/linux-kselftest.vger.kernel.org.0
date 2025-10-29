Return-Path: <linux-kselftest+bounces-44342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3557C1CEF1
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 20:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4705B1884CFD
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 19:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A28350A2E;
	Wed, 29 Oct 2025 19:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="anZjhqW5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36493559F2;
	Wed, 29 Oct 2025 19:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761765096; cv=fail; b=E1coQAq+atYSLSBAw2d532n8P7yXUNd/DBGLoLRSmXAA2sg7iQ4INKmaYud1zpJNE0CGFGm6pP8tUN75LH1wf3JhsPQMkt1gcCq4H/BQJa6Pybi6iShd/xhKB51KkiFcwc53xntz7GL2M1bTer4uyWiPh5qmNoRQcjQXw9saMKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761765096; c=relaxed/simple;
	bh=S6uvZ1qbm/yNmnZidfpq2lXG+9AWbGymzVy6/lzKTEw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kg7TKBS0NFF1CO/R0e08rVir83pSQ5GKKN2ZKinNy3/cZcDfm+LliCX6cMBr6nkW3bn/1kgIkV0M8t1JKflwslWMBya8r+R+3fWtsL9LvvgEqCI3226fz4Zw1THnUBk0kWl3FzlGJ4PI0HrVxNUU+wizc0dfrP+vJrPZg/rSgIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=anZjhqW5; arc=fail smtp.client-ip=52.101.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBqyjdb3Cfs4vimoUbk3iBQ5XfSLQ7ExWZ4+8FSuygsjzptdjRvByalgnrHopGmiGeUlyXUknhZ0KjK3Oz1me+BLI2tGmAmkD9FwhiQt5Y0Ib+awKgtoXlpRQBQHgFHGEKfYCQrWSiGnQxGzV0nilm+QpGenvZxSHcBte5+jni0Rf+UdqeIVcN6TuIq1lxrzjVAZyLJKEHj62oNsM9bFtmez1oXbJNabCdOxy8VD+UMRFTym7XtSKfaDKALjvOFAbnVfTgzR9DGyM4M0bxDrg4rVjynXEeTk7Cpv5lHjVLAIW5OH+xC9XFTolAe67BQnvjy12wFVA65PJHZAiIHVuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cD27TibwNUxsj9Z8leEvCtHuouKmoS8/LqP+h9y2D8=;
 b=BgDEXlD9kg0tnclKduOl8mhH0e+vOZOn8Qr98NVOVRojZiodiquGY+cpKspwgptbE1nRQdmP25ocGv7OHqVHAQ6g+9ss2SmBPKCJR3J9GSfmI9T1CfsgPhrJPUpxL0zqXh5W7QajMHQS4s6TJk7e1aSu+p0jd7NxnLbfouAv9Y+OpRfSWXtpImwTXoErur+npQLDduP17j9w4sGRm70VYEKPmDL46HcoX3xZVtSPoH0KfIvj0LRuDkxuSEwZgi3WVSoA0FFS8boinIDUHsElZqKdQQgxJvIImdC+k8gGWcfAJG8A3bCWhAAjtcddUu3HhG+cG6xr8NFmZg/O1OLnLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cD27TibwNUxsj9Z8leEvCtHuouKmoS8/LqP+h9y2D8=;
 b=anZjhqW5wdjPKtRRMIYaTOX+lMMjKJUP4tHP6XlWel89nHFwO+ubQuKRzQwy5QUg01gqqPjosMckMdSIlLuMtBz6LlLV9RZ8RPztHOSsUJ+SE5Ou62RsS1GR3LnlaSa8Sro/MYncSQZCi4sj9DmitOzEHMUDnJ6fMhtNuRS8YsBpb5lguareQD2L4Ylhr2aTiH2KODfR7mwt4Yd2iv10Z8nxZ7ph2dMoUD1Ue+3afczqN9O3//OOctL4sxrM95Qv5z+wh16H8S7REXAnuAvOlYbcRh1HX68cVDfT6J4C+FxXe2jT6s8GAGY8sM4d0pfNldMJV9U0Yfz9SeZ6i90GuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB5617.namprd12.prod.outlook.com (2603:10b6:510:133::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 19:11:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 19:11:27 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Shuah Khan <shuah@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Luigi De Matteis <ldematteis123@gmail.com>,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v10 sched_ext/for-6.19] Add a deadline server for sched_ext tasks
Date: Wed, 29 Oct 2025 20:08:37 +0100
Message-ID: <20251029191111.167537-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: 17402d51-de50-4870-2003-08de171ef579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ScHIYxAj2VYBrZi3S/t86ee0eocznqPl3bZKvQDy/sxn1ZQQCGuqDmmraaUB?=
 =?us-ascii?Q?tiW2v9wm9jHe56IoUXvkunXJQsqGPJp+FrQxsf9ftQ39BnkqKPxj4KZARMut?=
 =?us-ascii?Q?XDPX6yqtQx51RGRVpuGHFXxHHXCVajwNZd6psG/1DXWFzk9Ski871KvhRfp+?=
 =?us-ascii?Q?6x3HmhvUsagsjxZ7sACTHKEcMIEhT4tfhJMPNcu46eVwekXk5qiqKZrGEcj2?=
 =?us-ascii?Q?dwPKKgQyB8xZ7ntSZlxpqesqzI4vDJIVhVx7nJZ9kW8cUk0bi1DLwYs9HeVe?=
 =?us-ascii?Q?ZSmVhrNGv/ReW1crsPv4wvzHSGLr88iE2JGEsybdc2Fa04HzrGD1+quJAPmQ?=
 =?us-ascii?Q?bpDKeqlNZ+zkQIFEATsNoEHlMNgM3V1HdFoaKbyya8vfMl/M9zNOCe02RioD?=
 =?us-ascii?Q?X7cR/A42vSDHToXO/p/JxgfTjiu/CcC2WS0Q9VzItLKCx+O8zCXXp4qYXk+c?=
 =?us-ascii?Q?VQhJTj7kSX84vP1LZND5JweviFXIaaWUmOj91v5ikjQpTJCyMO63mUnYsgZd?=
 =?us-ascii?Q?eUb1z/F9CEGYw+iRUmkSXq+jdjDtE2k6e5oETqDuvn4I1k6E+M63kxjraWbR?=
 =?us-ascii?Q?PYrtEKb0eaoFB1igONpUXMHxUZl7Fb+TQlwh0uciyIG19rmSEPbfKT1QyuHA?=
 =?us-ascii?Q?4Flrzi+7hu1/AUmQl4mZG98zKzsxBQbF/r2lT8b/51A5KUyZDNyBlaKL26eh?=
 =?us-ascii?Q?Fjv9a6NjM1515aEfDLYrgxQ/s8ra26cpSfGKc+M2XkYdS8vNJWHklxkMn2dp?=
 =?us-ascii?Q?ywLVepfoE5jZB6F48Mpe6N+nAVgSJ6wPOn2wD79tPmp3HC3qwc6X1NI9cSHe?=
 =?us-ascii?Q?vVmipfx7FS9TrNupTF8j2T8Uwws7nfDI6wzKVpI1M2P/5ovk285CzZmpuaH0?=
 =?us-ascii?Q?bZ2jFTj5D4w7AcwMixK+uxaxPF/4+wMZqd32YW7/DGucgQjlcozDIdglFt3p?=
 =?us-ascii?Q?MJ75BcclG6IYoGvM22a/ziAUgM7tDf89Bww/0jLq4ct9ud9YSPEHI84qoQj8?=
 =?us-ascii?Q?vH6nfhEPOOSZw3XidHOhWrM8W5uE1jbUQYeZ42dopxEjPLtB+2iYoFiSVzed?=
 =?us-ascii?Q?ix3Ukvj1I9s5kRyOw5yFa8BzLMmNaig3PxXQCbP08cdOMWwenvfwl7sS3zhH?=
 =?us-ascii?Q?bWsRNt8rBe9QPwlQmgMuDl9afKHQygos4vOb1V1a5DlWSwzQJxrYRm7+r5pq?=
 =?us-ascii?Q?N4kBaasZIM6zlbPYh8R3UEObqJ+asl34wIHTQsTHHzmqQWW8KQeIDvFMt2Jf?=
 =?us-ascii?Q?bgzLdAXPQIp779TvqZ6k/xQA799HlTaZ3WhF3gMYQWZJvgEcoxqXYGXIsVcK?=
 =?us-ascii?Q?AFkvkNQPqjxlKqkYt/IwQJ+B6Z/RXOLhYy5TXQcYYv1xS9iRwCHMmW2qZoKv?=
 =?us-ascii?Q?OADTcAzvdIHAvUQp5bFFVfe5fps+hcv0adDUckIP4jiRUrU570bWzBquj7KR?=
 =?us-ascii?Q?3gl5Y+Kg05Qevy8rHKNg7/0Ajb85KEilzrL7FxcuGPem3AsDrbnnbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y6tJU06NOongcoX/2/i2SO35SBUHspeqxTdtmCZiruq3/HVNSI56EctHR7u/?=
 =?us-ascii?Q?XQ5Ycsfs9AykhU8f0hEdckt9unQRWDU7k7rwgU5HBCs53E3+iKhMnH1d46Ig?=
 =?us-ascii?Q?GJ1rlt8wonU5grfX/S5M/VmK/0sx0ZfCp7ifQlEiOtkEM4PkMX7iymu0BHW/?=
 =?us-ascii?Q?7kIBMF8t+F7AIoAG1IcLtB1hgnh2wABk5qSUuSahB/GL7eb9kHH2eFfTZkUH?=
 =?us-ascii?Q?pfNijUtSYtIIMrzySwTA5uUecK7/uDOtSYug7rfg7MzKIl07WHXw2ze1JP+A?=
 =?us-ascii?Q?Gq9dCdME11rnfqidRJ2fkXTAYiyd/nfOmh+Ju/BOtsGvEiXyt0sfqzyL0CeY?=
 =?us-ascii?Q?VTIDrmmSY3qn/iGOvVtlA5nB3USivxmuLbaSfSQESyJMQDv7daP5ZJwwRtwE?=
 =?us-ascii?Q?9isqQ6dw1+CPo4SkMHP1IifxwT8mfp3sLQB/jaF6HdAwL3+mz4N00kjt4trE?=
 =?us-ascii?Q?Wv/NfC1iUzSj24X5dUIcdjPDYk2p7jZjo2szTp50yQEvyYpUlK7iE9uhBmL4?=
 =?us-ascii?Q?xWuwO0W8IIM34Vz7NVLCZAg7nJ/HSLZlSsd4Ztigt2Zq0y+gTRJCcVvbkLbT?=
 =?us-ascii?Q?HoaeL6I5L/k/7K/c7o9rAgQUebsLATBklKZC0G4jCshkgD8C+Wla9nEU/zd/?=
 =?us-ascii?Q?Eu9bhPLBb4NWneACX2PUD8MFrmKbIco4lzNlOc50LEg/e3sR6s2GWj1ZiISX?=
 =?us-ascii?Q?cs0ybQaJqJ4UhaDZnZ/kQx7k/L6N+VVsqDOD8RX4ID3O8UdRJ3Vtf0kCen6t?=
 =?us-ascii?Q?9w/8Q0HRL587KYJXHZxTrCuTaFX3s6SkKBjrqbqBOolEHmNIfLm9rwaiaYbA?=
 =?us-ascii?Q?+gsOYjLxkZFszkx2rPaArhwu/xn670Cstuo7B7XE1uwJtjSAUBaD6KoTAz8H?=
 =?us-ascii?Q?lNVQqECXjGIcnHAWV0B4Y07ljXvaS2LxTKmJqF/2Xk9TrLrRqIVjUylHNp96?=
 =?us-ascii?Q?8laL+VcuMKIJTTuFabNPdWZwei2venciN5pEAHNkns0Ing4w7Oa4aEz0h/8Q?=
 =?us-ascii?Q?puWWTZI/ZIhNVtiYANN0HTxawSFUYlL5ifu+1nYAGKnC+vI1GIRKECrQkCid?=
 =?us-ascii?Q?oqVnW8yDOCNiFeaZkb3a+zFkL1UXhNG19KfMhN2z9H6oY7s8XZJtb3za+3BE?=
 =?us-ascii?Q?PE47HIdnnzcJODquKTYJOLvT8shzlQf8XhQWbTZ1zhqqw/99rzTsZhgQIA5p?=
 =?us-ascii?Q?vRoLaUHJnFUY9aSwaOSBssDpgMSrbOtI1doptlCXTwBEBRRMfAj5jXsACP0A?=
 =?us-ascii?Q?2Cn7xzzplj7l6OK46l44RFx7bbz6v+YZFVRhQVH2K0GMdRo6jCFUGTxVBvQE?=
 =?us-ascii?Q?nnr92VW4eiKJa0qJ1VAvdNicHAAlNOvcLpmrw0AMi+EsDygbEunLRCXmsSX0?=
 =?us-ascii?Q?my9fjLgIgOlbMZeq6nj+IW+tjsFA0Os+KAMdCq2Uj+sgvbYUkekj+Yw+9fpo?=
 =?us-ascii?Q?6VqZhTy19AHCSB01Bw1U033599aWOif8K3bNGMIn5lGVq6rJ5mRxDVHHlI60?=
 =?us-ascii?Q?RAXG1y3hi4iMwi2A5oG/ZONG76mstKrlbIGmDtEJ9AmJAu1J0PYD0TNV3Ewe?=
 =?us-ascii?Q?pD0h8mLZFB7Xasf6F4kXfA9RD41VLGUmg/OkMy39?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17402d51-de50-4870-2003-08de171ef579
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:11:27.0020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQvM73TH626rVx5UO0NfqwmKOrQn9GGiAha7GRXdvjHZZMtoroGWZ9F8JPRMow6ISroDvIWgnSpt/48XWNCKxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5617

sched_ext tasks can be starved by long-running RT tasks, especially since
RT throttling was replaced by deadline servers to boost only SCHED_NORMAL
tasks.

Several users in the community have reported issues with RT stalling
sched_ext tasks. This is fairly common on distributions or environments
where applications like video compositors, audio services, etc. run as RT
tasks by default.

Example trace (showing a per-CPU kthread stalled due to the sway Wayland
compositor running as an RT task):

 runnable task stall (kworker/0:0[106377] failed to run for 5.043s)
 ...
 CPU 0   : nr_run=3 flags=0xd cpu_rel=0 ops_qseq=20646200 pnt_seq=45388738
           curr=sway[994] class=rt_sched_class
   R kworker/0:0[106377] -5043ms
       scx_state/flags=3/0x1 dsq_flags=0x0 ops_state/qseq=0/0
       sticky/holding_cpu=-1/-1 dsq_id=0x8000000000000002 dsq_vtime=0 slice=20000000
       cpus=01

This is often perceived as a bug in the BPF schedulers, but in reality
schedulers can't do much: RT tasks run outside their control and can
potentially consume 100% of the CPU bandwidth.

Fix this by adding a sched_ext deadline server, so that sched_ext tasks are
also boosted and do not suffer starvation.

Two kselftests are also provided to verify the starvation fixes and
bandwidth allocation is correct.

== Highlights in this version ==

 - wait for inactive_task_timer() to fire before removing the bandwidth
   reservation (Juri/Peter: please check if this new
   dl_server_remove_params() implementation makes sense to you)
 - removed the explicit dl_server_stop() from dequeue_task_scx() and rely
   on the delayed stop behavior (Juri/Peter: ditto)

This patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git scx-dl-server

Changes in v10:
 - reordered patches to better isolate sched_ext changes vs sched/deadline
   changes (Andrea Righi)
 - define ext_server only with CONFIG_SCHED_CLASS_EXT=y (Andrea Righi)
 - add WARN_ON_ONCE(!cpus) check in dl_server_apply_params() (Andrea Righi)
 - wait for inactive_task_timer to fire before removing the bandwidth
   reservation (Juri Lelli)
 - remove explicit dl_server_stop() in dequeue_task_scx() to reduce timer
   reprogramming overhead (Juri Lelli)
 - do not restart pick_task() when invoked by the dl_server (Tejun Heo)
 - rename rq_dl_server to dl_server (Peter Zijlstra)
 - fixed a missing dl_server start in dl_server_on() (Christian Loehle)
 - add a comment to the rt_stall selftest to better explain the 4%
   threshold (Emil Tsalapatis)

Changes in v9:
 - Drop the ->balance() logic as its functionality is now integrated into
   ->pick_task(), allowing dl_server to call pick_task_scx() directly
 - Link to v8: https://lore.kernel.org/all/20250903095008.162049-1-arighi@nvidia.com/

Changes in v8:
 - Add tj's patch to de-couple balance and pick_task and avoid changing
   sched/core callbacks to propagate @rf
 - Simplify dl_se->dl_server check (suggested by PeterZ)
 - Small coding style fixes in the kselftests
 - Link to v7: https://lore.kernel.org/all/20250809184800.129831-1-joelagnelf@nvidia.com/

Changes in v7:
 - Rebased to Linus master
 - Link to v6: https://lore.kernel.org/all/20250702232944.3221001-1-joelagnelf@nvidia.com/

Changes in v6:
 - Added Acks to few patches
 - Fixes to few nits suggested by Tejun
 - Link to v5: https://lore.kernel.org/all/20250620203234.3349930-1-joelagnelf@nvidia.com/

Changes in v5:
 - Added a kselftest (total_bw) to sched_ext to verify bandwidth values
   from debugfs
 - Address comment from Andrea about redundant rq clock invalidation
 - Link to v4: https://lore.kernel.org/all/20250617200523.1261231-1-joelagnelf@nvidia.com/

Changes in v4:
 - Fixed issues with hotplugged CPUs having their DL server bandwidth
   altered due to loading SCX
 - Fixed other issues
 - Rebased on Linus master
 - All sched_ext kselftests reliably pass now, also verified that the
   total_bw in debugfs (CONFIG_SCHED_DEBUG) is conserved with these patches
 - Link to v3: https://lore.kernel.org/all/20250613051734.4023260-1-joelagnelf@nvidia.com/

Changes in v3:
 - Removed code duplication in debugfs. Made ext interface separate
 - Fixed issue where rq_lock_irqsave was not used in the relinquish patch
 - Fixed running bw accounting issue in dl_server_remove_params
 - Link to v2: https://lore.kernel.org/all/20250602180110.816225-1-joelagnelf@nvidia.com/

Changes in v2:
 - Fixed a hang related to using rq_lock instead of rq_lock_irqsave
 - Added support to remove BW of DL servers when they are switched to/from EXT
 - Link to v1: https://lore.kernel.org/all/20250315022158.2354454-1-joelagnelf@nvidia.com/

Andrea Righi (5):
      sched/deadline: Add support to initialize and remove dl_server bandwidth
      sched_ext: Add a DL server for sched_ext tasks
      sched/deadline: Account ext server bandwidth
      sched_ext: Selectively enable ext and fair DL servers
      selftests/sched_ext: Add test for sched_ext dl_server

Joel Fernandes (6):
      sched/debug: Fix updating of ppos on server write ops
      sched/debug: Stop and start server based on if it was active
      sched/deadline: Clear the defer params
      sched/deadline: Add a server arg to dl_server_update_idle_time()
      sched/debug: Add support to change sched_ext server params
      selftests/sched_ext: Add test for DL server total_bw consistency

 kernel/sched/core.c                              |   3 +
 kernel/sched/deadline.c                          | 169 +++++++++++---
 kernel/sched/debug.c                             | 171 +++++++++++---
 kernel/sched/ext.c                               | 144 +++++++++++-
 kernel/sched/fair.c                              |   2 +-
 kernel/sched/idle.c                              |   2 +-
 kernel/sched/sched.h                             |   8 +-
 kernel/sched/topology.c                          |   5 +
 tools/testing/selftests/sched_ext/Makefile       |   2 +
 tools/testing/selftests/sched_ext/rt_stall.bpf.c |  23 ++
 tools/testing/selftests/sched_ext/rt_stall.c     | 222 ++++++++++++++++++
 tools/testing/selftests/sched_ext/total_bw.c     | 281 +++++++++++++++++++++++
 12 files changed, 955 insertions(+), 77 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c
 create mode 100644 tools/testing/selftests/sched_ext/total_bw.c

