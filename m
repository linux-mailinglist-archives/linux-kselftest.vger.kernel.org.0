Return-Path: <linux-kselftest+bounces-44348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB2BC1CFA3
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 20:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16DFB585A8E
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 19:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237D7359F97;
	Wed, 29 Oct 2025 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vg8q/rr3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863D53596E2;
	Wed, 29 Oct 2025 19:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761765147; cv=fail; b=eDYKwo3xdNhlKYmqt5jO6xKqdBvtmabC+uTbkx/xFKPGFfd5yqEl82opcyGNnuyupfJFOey29y8wGXZtZHeyA8rAMaTc+C8nma0MO+r9KHQIpoZwujHVHxtnCZKdCe9bjDdrCH7JkACAtbuKqjO0SbaWcuBX4DjJ828eS9WFf7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761765147; c=relaxed/simple;
	bh=gXbBXzbUX0C5rJU5CjELG+RAUDucpZbh9SjnrL4biG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EZhhqARCguUufmBdla2mPDMcgGGfLXBtuYqOzLMoFtViyMM1HlRiffK5z0qG7vTOiGc5GBJCJqZ/svzkn814CXbmXcT+88aChHqt4rKt51uRkbAuhJKVydPuCoDRswJxVvoZpridyhya8zIGT9TWcNVUD+rqhzODn4yAhPZIVns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vg8q/rr3; arc=fail smtp.client-ip=52.101.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Frq4TaWMji61U/22b5D/xyfYcoo5P93tURG133JxFkUYv09sY25LxzCVMft4EG5l4NiuusCpL0AxnYrwIVW7q1L1xrcvjWgvvHse1JeZpjO+3uvW5joNwXgULuud+O5fhk8fJNwiQ28kX39NZ5m65jEPNYrG2mk1v3Y+a9Kny5T6W2W75TEK3Xy7yzdZRlWnQszmUGzLjyasECQpVYOAtBExDIim0xLMokcNXMssDpt2LB/9UrXYPUWWIwx7XmpqpoRTGuBzieGG1D2cBcGME6DnRgjNu6U7TkBo6J/UsuWkdSQTk0nihQeKceFl7aGgI6NZOvXefEseFvuEmzuFfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TM+nxCTp+Nph6c5TxjFgpX0LghG66PZYzuAmx3d15Is=;
 b=HFggEt0ua1jKzto3djB5+uBCGZ6btojfLFNdJvwXlOD1MQqcLa1sWDbgU3C+ecxjIoBau5rZq/ujiIu3jeJTbVihtrEZTYgtG3WBYFfuPG7kbkEZ4mae7iU0XGXdnTwwg+1FBCz5H/MYPpITOfnCKzeADOVa1n6v4sWr2ViK1QjZS/OXIcShQo1XV8akZC13sKSpIV+ERhkv+wR5QXVjSEqS3mgd+ssJDgMG9svbAMYwOVwR8Q0TU1BbeLzroRKTRtF/cf9JzO2gTYihAwkF7Hzp8DD+O4NpU3eH7SEoQXf4CkejzmQ8FkEHtVPJiTJ5e9hsieyzaPmcmni6Dj/Deg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TM+nxCTp+Nph6c5TxjFgpX0LghG66PZYzuAmx3d15Is=;
 b=Vg8q/rr3zDrn6TDKTO4H4lgSAlmfxEMuXN3Pe5zI2J51sMqqH+TLz4LYegAyLeO8K2PupqkEqU+X8SEx7aHyq2vs53ZKt3sAzx8dwBcPcrSCMk6qWKJD0gAtzvLAkz/MO0RHfLXf/svDnbXGylTqfMOkezuI3ht6ZMSTHNuIXcL3+oN5kAav13deOFYSdVSlXFTFQLowF0CGMxvUpx7wL3BgfT7cfyzWowimeCRMgUg5W05OLRcypW4f8fWv/w6njqnyEX80YW53lldxzuG+AGzYUrAYzW2yyC2B3DjfkGauozN2qG8vUM9f/Zj5uVIHhfJwGD866gd1p78Ojvv9sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB6735.namprd12.prod.outlook.com (2603:10b6:a03:479::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 19:12:16 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 19:12:16 +0000
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
Subject: [PATCH 06/11] sched_ext: Add a DL server for sched_ext tasks
Date: Wed, 29 Oct 2025 20:08:43 +0100
Message-ID: <20251029191111.167537-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251029191111.167537-1-arighi@nvidia.com>
References: <20251029191111.167537-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e10e682-a99b-4e1f-1c33-08de171f1325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3QMc2o7Cbee9kCi2SbXGfEM7jj2uVW6aYQOJweWpydmBRc2vObVLmoY0T0gt?=
 =?us-ascii?Q?cxvgQbKttvaAiS883jXnCCUIjHae9Tb2N/r9r0WV0cCM+0bUC4oyLB3ETJjR?=
 =?us-ascii?Q?4jC2gdg+UapUgb2M8HVPjSkjDxE1jQOyqnfwpbmVD8Gmm14TqZVaM+qxl2hc?=
 =?us-ascii?Q?bw3mMIf4/jr4LDc464V3tYpPbHtaKhODVfH6QotDdCoGnj4GVMqO177sMGK1?=
 =?us-ascii?Q?AXs9thZsizIatDBB1TQfnr2SWTch4w++rWQ39AtpSSg1Oj3POReQfGVGdvhg?=
 =?us-ascii?Q?7fCFjsmfZYTq+oacSQ3GYcfZ1Le8NPgf4DS+zSd3Hej+36nwipLiKwuoSVwi?=
 =?us-ascii?Q?AcyVmbuWeATYO5m38JtHPUsjlM/hOPfKzVeUAi+sbjID1PJc+vOHkhAv4CIV?=
 =?us-ascii?Q?UFpxQlM/o+JABYBurNmC0Tarr/KxOCmnZn9RaVl2AkKnmInADIHmRucbanXc?=
 =?us-ascii?Q?E5eBoBlhrOgy1ZxorF0rpaeCvchYWYq/86wnCzd8FhHbFyi9hxL0bm2R4Opl?=
 =?us-ascii?Q?yw0x02LZCr9BPfrGXrspG/FYbA90tkv7upxSojPKeAjAgKlfK2IKaivyXWCf?=
 =?us-ascii?Q?h+QJfg4IfFtUTSx+5/pg24FJp80CVLwk1bKr1kEWB9RInAIUiSQkUHTH8GKA?=
 =?us-ascii?Q?SEjRIR9pZ6ah01c5TP4zIT02oztmbmhGg26pmCFNNcYIlTun6+oHQQ65OpOf?=
 =?us-ascii?Q?du2PpOxZFg+K0EiNPaMcWjMzYDvmvyio1i68/HRQ46kfYedEG38vLi8zjP37?=
 =?us-ascii?Q?knHRmZJAg+sv67UldG6wceKh0vXlV+g0WSIP/tyhacKnKvKbERl6/WhOwjP5?=
 =?us-ascii?Q?mjHXnEdlA79uRr9sKXCKP6+H2Fi+y9l9zo8lHf/UyKPBWEKo0qbO58CR8gSp?=
 =?us-ascii?Q?nc+Zv33gBy3iW0blnfO01+Y8/NZvHC2s35sUZNUVP5YHR3SvQ6K5NeEwQY/3?=
 =?us-ascii?Q?Wix/vJ1EYRnYUrS3wos1oEubhT1NMpSmU8s8QIrqTkQe8c/Gw0ZhsJOw+HSX?=
 =?us-ascii?Q?2BBz5ECd9Z4S3QHsUvnZXqkrXj676BsWhBISeBBcAw6GOlEQHMY2GLNLv+JN?=
 =?us-ascii?Q?Kk9kUNUuEb3vS9/CVcqqyGNzNg+2a+TJRjJxHHrp03YE8TJYwlelIzb/rwhD?=
 =?us-ascii?Q?YjYHAh0LTCkxUD3VG9tVRstW7NwwH+dlHsIRQM0EF6RDPZLx4v2dj9d+5Zx7?=
 =?us-ascii?Q?lnjYXxnmeaf489a1o5QTlISjcX6uvQrS8ggKKAzlWlDPRKhyohvWH53vEhki?=
 =?us-ascii?Q?vcLGqd54h9BWtJUDzzZTE2aRPof4UYaFcSzFScP8x0DvVOiV+SaiVS53MAUg?=
 =?us-ascii?Q?O+TbpbCS232AaTVapsAZinvpoRD5OKBgsyLdMyqxazMPRJwxUFsYAo+snuvT?=
 =?us-ascii?Q?4S0Tim9jPZ0HlQDF0mSG07oEVhJes+QzRKY5IZw7Bv9Glh24PAWagKmHQc9x?=
 =?us-ascii?Q?T8ta32xrK0r3T+DoUegbt7qPWBQ/jb9i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MhmT6rNdl01GPnciJwYNP33HISq0RAdiHV1cYiQGeN7JczqQ8bVTuDMPJ/SM?=
 =?us-ascii?Q?kchxlGdHll/POhDXMB12lRYKMU0JiNFayVhpOxluw9FBY+E4/daCYWYAMr9h?=
 =?us-ascii?Q?SNG4EvU2aD48MtH1ZbfuHdHkq9hxHd1EHsf5OBvLcHTpaiTRHlvU5yfjbPpf?=
 =?us-ascii?Q?lqOy1IxNeSbSp1VERjDVrnUBPzDLvAuNuaqDPwLR1oBZT25x950X2f+X2Y4D?=
 =?us-ascii?Q?M48L9VoZ/F7OjS0mgWivsw8PlMTAerlPzKcbyrsx+BWcm+pxEiVu1v3JVbcS?=
 =?us-ascii?Q?rdNVaLXEmneB/1NdlxhOfxkvzGhYZJCGeDKdXjN+DC4MKi2bIx/xQjTwxOeh?=
 =?us-ascii?Q?gshMWXaZc+GxpgTXTUhbXYnkR4J+7gj+2pYwLIWtCrbsIduIY6pgsK7tRwKw?=
 =?us-ascii?Q?nJUOzjof9zzyWmQ845R6Cb76amqdsSEn4qyApHXZbM/96KUg3QWSGEmvHFn+?=
 =?us-ascii?Q?HZkJMQJt6xQGuJ0H4zTUbY7OtwgcKPbV6+M5A4CpoZ3bCb2BEP1Nr4Jg08l3?=
 =?us-ascii?Q?WNLaXouk6cY70rrvt2aXcImor6v+QCQsnmVMSVjyaib1MqVJwo5V28/r4UM3?=
 =?us-ascii?Q?LnlDIGU88Awt62ePMwoIaDvj6Cq1Hz+JptC5qnROo4PMlfUziR1ox9GEi7J9?=
 =?us-ascii?Q?elwnFWHSnDntzoeHAv/b0LMddkF+wOiaGJWIYX8b+aU6dm8digI7WCOOXvGs?=
 =?us-ascii?Q?QoHh1apbcl0hrXLXDaSEoExhnvqVf1kPU72LHQ8On76J+sr6efT80CACSTQC?=
 =?us-ascii?Q?XBCGHcAMu595OV3CxhDdWxgfpzweJSUJUe9SdIT8LqsdYdYYfX11C08dUDgx?=
 =?us-ascii?Q?48l6BQ/fZFuebLumhQKHUx7Ae95dXKnl+p33tKxNwohwxN9ANypMWns6rKGF?=
 =?us-ascii?Q?77cbIbcC4YNP6WJPVddp1Kf1fDIqdTj66IRFMlrTGihI9rCs7ijLdQi2d/aL?=
 =?us-ascii?Q?TIIT+/RhwIzqb3mOVK00R2IfyP46ioEBPXMPEwUJyjtxQKBRA9HVbCtB0sNV?=
 =?us-ascii?Q?Y8jeo9d46FuJCGfTB2UZQxddVnfiDLsK53Bp0JsSXcaoKCBrf5DUdcepqoeI?=
 =?us-ascii?Q?kBCzmT70x+j1KDlylZuwrmMtqhRAp0bSkzY2qwJrnKSb3FyT9rY4e5yg6yRT?=
 =?us-ascii?Q?ug4CDJpYeLBUSi4vVhMSly2fK3SJXrsg9+MEbtFl0uJeAY/iIbneCNGC1u5e?=
 =?us-ascii?Q?O6M7TdLixj6pfvldsDpdcmHIbEOI9/KEHpoF3QG/MrBIGOzeweAk5te+eugJ?=
 =?us-ascii?Q?2l5uxt4C4WNI/jh1ODIc4IQ1IWHe2L8OUPTtH/C2HVd9PPnxkeEkoUSSnzb0?=
 =?us-ascii?Q?80hlWtRLzbPqANkx97W6PcWP4cIB4DO+/5NI515RyrUtz7eqEGVuy7CUHBZD?=
 =?us-ascii?Q?5wt0BWAOnVBNavOM8QxYWsDnRcXD9dW5mKZQhoYH48jHC7UQDsnlVWWNtLhB?=
 =?us-ascii?Q?sJu64AnTVexWJ0OlVDN1k/QPvAyE0vVKNN2n07pgM1+F/ofyKL2bjejv2tLk?=
 =?us-ascii?Q?XFqv0fE8neCPmq2IyW//1pGVqg/srJp9p9P0yr/hnje6tLSUd4SXqq3bYMRI?=
 =?us-ascii?Q?hW7dhbYVKxwc36NAqvznhxDYsECzjOa6G1YRseiU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e10e682-a99b-4e1f-1c33-08de171f1325
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:12:16.7167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWlcNHUUVxHYWZNRdHtDYMzMkOkQ5PZtCaotdgt5878eHxfXnnChx/zObYm3vj/O8qXIjTNg2M2WRHRFWr3vxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6735

sched_ext currently suffers starvation due to RT. The same workload when
converted to EXT can get zero runtime if RT is 100% running, causing EXT
processes to stall. Fix it by adding a DL server for EXT.

A kselftest is also provided later to verify:

 # ./runner -t rt_stall
 ===== START =====
 TEST: rt_stall
 DESCRIPTION: Verify that RT tasks cannot stall SCHED_EXT tasks
 OUTPUT:
 # Runtime of EXT task (PID 23338) is 0.250000 seconds
 # Runtime of RT task (PID 23339) is 4.750000 seconds
 # EXT task got 5.00% of total runtime
 ok 1 PASS: EXT task got more than 4.00% of runtime
 =====  END  =====

v3: - clarify that fair is not the only dl_server (Juri Lelli)
    - remove explicit stop to reduce timer reprogramming overhead
      (Juri Lelli)
    - do not restart pick_task() when it's invoked by the dl_server
      (Tejun Heo)
    - depend on CONFIG_SCHED_CLASS_EXT (Andrea Righi)
v2: - drop ->balance() now that pick_task() has an rf argument
      (Andrea Righi)

Cc: Luigi De Matteis <ldematteis123@gmail.com>
Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c  |  3 +++
 kernel/sched/ext.c   | 45 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  2 ++
 3 files changed, 50 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 096e8d03d85e7..31a9c9381c63f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8679,6 +8679,9 @@ void __init sched_init(void)
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
 		fair_server_init(rq);
+#ifdef CONFIG_SCHED_CLASS_EXT
+		ext_server_init(rq);
+#endif
 
 #ifdef CONFIG_SCHED_CORE
 		rq->core = rq;
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d1ef5bda95aec..2a25749c54ba1 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -902,6 +902,9 @@ static void update_curr_scx(struct rq *rq)
 		if (!curr->scx.slice)
 			touch_core_sched(rq, curr);
 	}
+
+	if (dl_server_active(&rq->ext_server))
+		dl_server_update(&rq->ext_server, delta_exec);
 }
 
 static bool scx_dsq_priq_less(struct rb_node *node_a,
@@ -1409,6 +1412,15 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 	if (enq_flags & SCX_ENQ_WAKEUP)
 		touch_core_sched(rq, p);
 
+	if (rq->scx.nr_running == 1) {
+		/* Account for idle runtime */
+		if (!rq->nr_running)
+			dl_server_update_idle_time(rq, rq->curr, &rq->ext_server);
+
+		/* Start dl_server if this is the first task being enqueued */
+		dl_server_start(&rq->ext_server);
+	}
+
 	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
 out:
 	rq->scx.flags &= ~SCX_RQ_IN_WAKEUP;
@@ -2444,6 +2456,30 @@ static struct task_struct *pick_task_scx(struct rq *rq, struct rq_flags *rf)
 	return do_pick_task_scx(rq, rf, false);
 }
 
+/*
+ * Select the next task to run from the ext scheduling class.
+ *
+ * Use do_pick_task_scx() directly with @force_scx enabled, since the
+ * dl_server must always select a sched_ext task.
+ */
+static struct task_struct *
+ext_server_pick_task(struct sched_dl_entity *dl_se, struct rq_flags *rf)
+{
+	return do_pick_task_scx(dl_se->rq, rf, true);
+}
+
+/*
+ * Initialize the ext server deadline entity.
+ */
+void ext_server_init(struct rq *rq)
+{
+	struct sched_dl_entity *dl_se = &rq->ext_server;
+
+	init_dl_entity(dl_se);
+
+	dl_server_init(dl_se, rq, ext_server_pick_task);
+}
+
 #ifdef CONFIG_SCHED_CORE
 /**
  * scx_prio_less - Task ordering for core-sched
@@ -3023,6 +3059,15 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
 static void switched_from_scx(struct rq *rq, struct task_struct *p)
 {
 	scx_disable_task(p);
+
+	/*
+	 * After class switch, if the DL server is still active, restart it so
+	 * that DL timers will be queued, in case SCX switched to higher class.
+	 */
+	if (dl_server_active(&rq->ext_server)) {
+		dl_server_stop(&rq->ext_server);
+		dl_server_start(&rq->ext_server);
+	}
 }
 
 static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p,int wake_flags) {}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index eaae470841dea..002e5c1808014 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -415,6 +415,7 @@ extern void dl_server_update_idle_time(struct rq *rq,
 		    struct task_struct *p,
 		    struct sched_dl_entity *rq_dl_server);
 extern void fair_server_init(struct rq *rq);
+extern void ext_server_init(struct rq *rq);
 extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
 		    u64 runtime, u64 period, bool init);
@@ -1154,6 +1155,7 @@ struct rq {
 	struct dl_rq		dl;
 #ifdef CONFIG_SCHED_CLASS_EXT
 	struct scx_rq		scx;
+	struct sched_dl_entity	ext_server;
 #endif
 
 	struct sched_dl_entity	fair_server;
-- 
2.51.2


