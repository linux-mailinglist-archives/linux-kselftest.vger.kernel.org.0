Return-Path: <linux-kselftest+bounces-47667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A98CC8A2C
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 17:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66EF63113374
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 15:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F950352947;
	Wed, 17 Dec 2025 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pU/8u59n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012001.outbound.protection.outlook.com [40.93.195.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9A6347FD0;
	Wed, 17 Dec 2025 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765986526; cv=fail; b=Y2B+kakoqBlJ89K6JwLnk+F+ibIJJZvnF5YMt0W4C0RIAfBoQ1SH2mUIWW1IWkBbIp+CrIiq/ghnSphS6glg3mZrKHDIqyGINUFVZGhdjyVJYYFpMO6di4bt3drqJVGzaFpxUcyV7hB6Haw1AqCucxCYPtRKw6HNhZkJ/aElOKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765986526; c=relaxed/simple;
	bh=stDKbYKVwN4NtS+nDYp/LzxQ9AaOF2DoTl/2wWA0srs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KTrADVC7XtMGDNarzoqtYunbBmzrRrdLvChtkgYD5Dq0Ns/uIKVq8rgAyqqiKA+K9tTpY8Dl2dzHelQg/zyf8Kgzb+LcCAClirIx8tlnk2HDXTZYQ1eDSE08uddCi0ZQnpkvx3YhT16V3MZVf0ER0nUMdzcPlsJofOOY46geiVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pU/8u59n; arc=fail smtp.client-ip=40.93.195.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1zQkF23x+gI89hsIsv+LPFQpoJLQE66E3be/quxYvGrFNq2M3r3Yd23z9HWhtzCUoDIsTys1GB3DoB9xyQXU/X2Y4Q35sy+HmGRR8zs/Hizxgxc1wMfxyJKeiHjURByDXGpDk0hGZUfpU+qBMVfJzlX6OLwlgDHvcr44aw0oo2LPTYuwBsB46St8O/glc7yauM4zKtiLZZf7i7sNYmgytydQeC2rcecDqMBB3yfQbbUl/5Z2cnWG7+bI+ZBXVpIH5ffhH7CrAveMHHt5DsLXH6Wi2NUUrvtgBw+ccNUR2Rc0D7z+xVKxBf2thEwfM++R+6jhhcesLUsrC/Jnybt0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bERVX6r8RiMygm7pWo2rsnY3ZsQqMHll8P/O3hASjRs=;
 b=FEp3hkH7fmtfz/1BvhN+bcU0LEliSX3G6jgHanXfxMgfAlL06G59icHmN9qxpov3nLaSsixtRSWDUcKY2Wq3MYQwKBYJ0zb20VWJJTRu2sVtp0F5hNFRfsxOG2pmo/lrlRL91GK9kaLtlNvH130/V7k/WVLPxbPzPVkQWx8lfiByDJMkyo0/CIuXlpNtynxRM2bMNBopCe2XXXSET0P+J/sEvkMyo+VEWNJazamA+nXIX+TaUmss2EPu2IERTg8+hr8sue930twCwN9MzDcsLnBaHIUFj2dndrJSKyEpKLc/izwA7Ey2XtEXpJpEzwrR3HDgYgZlbrNrOsStYorzMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bERVX6r8RiMygm7pWo2rsnY3ZsQqMHll8P/O3hASjRs=;
 b=pU/8u59n8r7FIdory9Kr6dgZpO5Z81ocVSPZMBRJYWOr0deKV5WHCDq+pw8u1yCKMA4ecSusXchF+cVpKA9pdALrMGYTJhZP+0SzaxFkBHBv1tlcYSGMDuMWGIagJuc9Q9slYTRjYeLSyC4/jo2mmiQ0XBGkyS8yjqLfPxcXvChO/6PLvrN7FxbedI14Zw3TLL6NXaSGP53LlOp4a9sCCBZ0ZqGNPp5UIWAgJcDmJbUhMsgg0utwhRAO2yIPc5eQdAX/AQAQv3HBfF1Vo6aTlT/KGtgwnXBkt+dC4qkr4XvBBTgCTEfTJTzMi314+ZpcHXyX8Mmd6qz0R2VcA83OjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 09:39:59 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 09:39:59 +0000
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
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] sched_ext: Add a DL server for sched_ext tasks
Date: Wed, 17 Dec 2025 10:35:42 +0100
Message-ID: <20251217093923.1556187-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217093923.1556187-1-arighi@nvidia.com>
References: <20251217093923.1556187-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: a3434b4a-d7b1-43c3-9747-08de3d503e89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nd5oJJFAO/Cy/78GVHGAB8AUhazKL5rkjsl3VxTJh5YbgjU9cWfzLuwmv/RS?=
 =?us-ascii?Q?HMnj6OJcGnvSEKXLJxZkqh04g2qkX+HmZo8pgG+qLM4Rx/+O3v6sj/lTIx1i?=
 =?us-ascii?Q?045jY+l7dfqTmou1yq0lvSeGLAAEVozMVPVBu+Ec2Yms9F2ONwfFn++l11Ml?=
 =?us-ascii?Q?tJeMO0RTCRVWftOBEDyrfyUJ8CFVxaePD9miMCEG2paWuzvOYqcJuyB9ivas?=
 =?us-ascii?Q?L8nlfjCgvk3pI/gNgptHtdcuOIa+42i8VASAdQbnPnYrdhJ0Pi5ifh+rrYBb?=
 =?us-ascii?Q?F2JS/U73f7FecH0duCr+U8wevq6pMKzVaOxcG6dK+WrIVxMBpuXAA7Yr0Xz/?=
 =?us-ascii?Q?uqfCecPSmqHae+Kjqy0ziZBteHBtsngeWwKylxuOKPSMKzebgLao4tCR4Fcc?=
 =?us-ascii?Q?6/wZZdJh6iS2PIcbONEIdRUOtmycsyfVTeFdH7Fde3kpSMAP5sUvzsAreU/4?=
 =?us-ascii?Q?ab1Czc5kU0IS/gUnrV1RTIi4IGGGZkX47Tlj02oNVwu1jn4dQ3Xi0VzYXWzZ?=
 =?us-ascii?Q?CzZ5Ezw0mgs/h5AB6FiRQ2aZXaFbNPk0eWu5vdQeN5tYkK259JvqCD2TLERJ?=
 =?us-ascii?Q?7DU9KCFBMoqL6RVDy9i0mzt3m/CKAyD3Y1di0vZC+aV96EaDDK3vZ7yEOnVN?=
 =?us-ascii?Q?/lopTO6noRA2lFx8RGQLaYzmjWNc4DcoA1K/kmhfOaP6/d0s0cWSwss+/QbO?=
 =?us-ascii?Q?bXieic+ZNFj97tVH+465ywewOtgFntYANFZP0kZyMzzvIAvPqLsDoMzYwMUM?=
 =?us-ascii?Q?mMMTtP+am6iQKOj6lsOYlXifYyfmanJWS5YUAav0cvAeebRiypzDRAugaHjN?=
 =?us-ascii?Q?0zx1OorQ04rFHl+qsHir6JW93brA+ehbjEgwCcVVZNQjzpLx3Rc0QBmCB7SK?=
 =?us-ascii?Q?lYVT2H7cmrKlkF0sUuIAhD0oZOlr3TADcb/AdiDdZNVf8MNhXCs58gIp6Jd2?=
 =?us-ascii?Q?+p2A1GEnIK+4TuNdPe27XzL6bfN4SCjBQEHQVZ3wSGHh8k7ewOV7oiYMtPdm?=
 =?us-ascii?Q?uv2CF9pSJRnupZw57TOhcTgbTDWy1cExvaOQK3jJPXIdx7/pfAw9acwBVSok?=
 =?us-ascii?Q?Kd/8Tdd0VkZQ7ynMPEdxq+NxXr2R0YVVxrsD5uV85YwuF4ZAlvJeMgyr/u35?=
 =?us-ascii?Q?qcwGLlUgvTpteNcg4bub/daVli6cSzD4tzNbLRiXaD2V74tg5TUY1wP6ChWU?=
 =?us-ascii?Q?SkP10hwIwMv3IzRUzmn3Y1gTyCBtX3bi9+RYiOgJyEXIAkiVNcvFn03uKijF?=
 =?us-ascii?Q?/GhzG9LlUc1mHOKb0ra/d7m9l1uGycAR+Yj3N5HhzGF/idbAChXtaG7YiGJ3?=
 =?us-ascii?Q?br9tP++Sw7TaDuYBcDhcSCCf0LcHy/1wyfxpuUv4nWYL+6gGPTFI93Eo5o/r?=
 =?us-ascii?Q?1oNlOUAsTsRFKtMFFHeKBS2e5+nh0i5G37EFkYYU5hPo0TVQb+VoNuwuKkoZ?=
 =?us-ascii?Q?ONsV7yOi8s+QFEULo9SCFdxcepzleGkX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VvbqmaSoPU5ylw+iyvCfNodTBDSKLatnA6ywHl2c2JVwPQybYH0ccJyFdBZd?=
 =?us-ascii?Q?P4iBpPxWMp4Qc4y7SWr/5DqrtRqIqTzviuZT9t/FmEQdHdU8yHU9yGsqkTMz?=
 =?us-ascii?Q?nWXDkTspHbHiqBRmIfosjuOp/GDq4uPakX1z+3FTuG6yfgV6/gOZ86ScEjJW?=
 =?us-ascii?Q?nUBmQfgMT1RwtWnxv1QsErc5AgKufsMNw1WwO/NHi2Oic2p3BOyB4dBwhJKJ?=
 =?us-ascii?Q?wfU4lWmrElMkzsRKPqDYIIj14VbxBcckpWddaA5P5wJQZmqA4SkndBirGsYl?=
 =?us-ascii?Q?3dy4WwDic4uQl8WbKealRSBY2QuhGVfYDwt6ZHhdGG0FMhqgjr310CuKkSFK?=
 =?us-ascii?Q?5XIKFAVMshRZ1bBjTt3VsLFC3v+97fuYZzS2aDEm/BIQ3AtzX3njBVue1ojT?=
 =?us-ascii?Q?2yP5JKrDWzHbc8r8pNX7+S+MmHOPYe414e1aXdGx1E4fZx+gvHyUwL/pD1hK?=
 =?us-ascii?Q?OmBIfFe3ZENGnN5ajZmdJaqjDTadAfAIlwVhAVF28AnvGh7VdGNtyFWWLFWV?=
 =?us-ascii?Q?C/dajER4NQ+XfVXytyTSJt6PsacI4QomyIKITB031ix2DRbWMxo5iGgBwW+c?=
 =?us-ascii?Q?6uslWDbuma30nKhcnN/JMk0ngGVuVANUYytW1rMsHSaBDtSjWJpzpnKRhSnh?=
 =?us-ascii?Q?yLXJyJyQ9FsfmzqY5xzIxtCYS0FaahbdPzuSDXs/L0NdvZ/ghVvC5nRE98Rp?=
 =?us-ascii?Q?LZ3HzV8y7Pwnbz9eQlSeM+DjTqsQ/bhu0r3k6QAbSxTJOyC/gqHpWMkzKqBl?=
 =?us-ascii?Q?dTbg+GBzxXLan9+cbfboJqsCzoY4Qkyv/jjy+MiULRpAVG96Jtlmcut1tc6h?=
 =?us-ascii?Q?E8i4GX6Mt7V7dsOh9UnL+nMDarvCFjHm0L87CSnR2jod61xcCZk63BOsGBsP?=
 =?us-ascii?Q?BX4VfgXJ0eeYi1h47k8UiaLrxBlUxH5njh9Cik9FO8xikOr8nmJOO75pEkyT?=
 =?us-ascii?Q?xtVx1THUUBA+PVEPQ0E2K/aqz6D3GQDi5Eub7N2sQV1vovzeEVLYffCdcrjB?=
 =?us-ascii?Q?FbkluoqsIabmB39tZOL4US2jrn+QaoZ9FflDGgOZJRAVkQMRqNBzxjwTTKsx?=
 =?us-ascii?Q?lhmMX4oDpHYiNttusFfpfx+hpXB2J1O1saUI91ODwBAgHtxOdoqfiQPIAcCB?=
 =?us-ascii?Q?FFvxs523UHXSImbdDoZAL/n6TFG10Gz0koXJ0Dc7BxCual0icjLA3i0EuUVK?=
 =?us-ascii?Q?Efw+oYbypjbqabX0tYNPIHWFUHnBygbxYENcNIoIVdJnTQsT/EDw9ElJDg04?=
 =?us-ascii?Q?XCGscpeBvbiAmHMFYZaC8J+IJw2kpylB2doN98PEqpI88154Bx2LjI/Vya3n?=
 =?us-ascii?Q?MPJzDyqzDqZKhQv5TeKxA8R5u/O4VL7MxNjxStZ1ZZUU0PNQWS/MT/+rPOVF?=
 =?us-ascii?Q?8rx1Niovq3CubiizpjLpldVbH9hyM6i7DblohVZHgaF9uItMX1G7z5ZNkFlT?=
 =?us-ascii?Q?kUchiQVIVQiVa8eWv3wCYgW5JslCaZXixWg/7cD7SUjsQw4wMCy80EhmQoSh?=
 =?us-ascii?Q?tIz7VfnwsqkRtE+TTzeKOSTPqE38u1JlgYAas5xSnCASJ73+8VVLab6i2M1A?=
 =?us-ascii?Q?4uplmunkuCoc3Dx011dWUM8fwTlpqGYNuBhMzKXG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3434b4a-d7b1-43c3-9747-08de3d503e89
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 09:39:59.0400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndnyjDDguSwf6ilmZnU25ltXqJ1D0RMn7dqRQBtu3GP8hUdrCVan82YTDnT7IwRabl4aCfZOcEi/YZJik7+V+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413

sched_ext currently suffers starvation due to RT. The same workload when
converted to EXT can get zero runtime if RT is 100% running, causing EXT
processes to stall. Fix it by adding a DL server for EXT.

A kselftest is also included later to confirm that both DL servers are
functioning correctly:

 # ./runner -t rt_stall
 ===== START =====
 TEST: rt_stall
 DESCRIPTION: Verify that RT tasks cannot stall SCHED_EXT tasks
 OUTPUT:
 TAP version 13
 1..1
 # Runtime of FAIR task (PID 1511) is 0.250000 seconds
 # Runtime of RT task (PID 1512) is 4.750000 seconds
 # FAIR task got 5.00% of total runtime
 ok 1 PASS: FAIR task got more than 4.00% of runtime
 TAP version 13
 1..1
 # Runtime of EXT task (PID 1514) is 0.250000 seconds
 # Runtime of RT task (PID 1515) is 4.750000 seconds
 # EXT task got 5.00% of total runtime
 ok 2 PASS: EXT task got more than 4.00% of runtime
 TAP version 13
 1..1
 # Runtime of FAIR task (PID 1517) is 0.250000 seconds
 # Runtime of RT task (PID 1518) is 4.750000 seconds
 # FAIR task got 5.00% of total runtime
 ok 3 PASS: FAIR task got more than 4.00% of runtime
 TAP version 13
 1..1
 # Runtime of EXT task (PID 1521) is 0.250000 seconds
 # Runtime of RT task (PID 1522) is 4.750000 seconds
 # EXT task got 5.00% of total runtime
 ok 4 PASS: EXT task got more than 4.00% of runtime
 ok 1 rt_stall #
 =====  END  =====

v4: - initialize EXT server bandwidth reservation at init time and
      always keep it active (Andrea Righi)
    - check for rq->nr_running == 1 to determine when to account idle
      time (Juri Lelli)
v3: - clarify that fair is not the only dl_server (Juri Lelli)
    - remove explicit stop to reduce timer reprogramming overhead
      (Juri Lelli)
    - do not restart pick_task() when it's invoked by the dl_server
      (Tejun Heo)
    - depend on CONFIG_SCHED_CLASS_EXT (Andrea Righi)
v2: - drop ->balance() now that pick_task() has an rf argument
      (Andrea Righi)

Tested-by: Christian Loehle <christian.loehle@arm.com>
Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c     |  6 +++
 kernel/sched/deadline.c | 84 ++++++++++++++++++++++++++++++-----------
 kernel/sched/ext.c      | 42 +++++++++++++++++++++
 kernel/sched/idle.c     |  3 ++
 kernel/sched/sched.h    |  2 +
 kernel/sched/topology.c |  5 +++
 6 files changed, 119 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 41ba0be169117..a2400ee33a356 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8475,6 +8475,9 @@ int sched_cpu_dying(unsigned int cpu)
 		dump_rq_tasks(rq, KERN_WARNING);
 	}
 	dl_server_stop(&rq->fair_server);
+#ifdef CONFIG_SCHED_CLASS_EXT
+	dl_server_stop(&rq->ext_server);
+#endif
 	rq_unlock_irqrestore(rq, &rf);
 
 	calc_load_migrate(rq);
@@ -8678,6 +8681,9 @@ void __init sched_init(void)
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
 		fair_server_init(rq);
+#ifdef CONFIG_SCHED_CLASS_EXT
+		ext_server_init(rq);
+#endif
 
 #ifdef CONFIG_SCHED_CORE
 		rq->core = rq;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 2789db5217cd4..88f2b5ed5678a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1445,8 +1445,8 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 		dl_se->dl_defer_idle = 0;
 
 	/*
-	 * The fair server can consume its runtime while throttled (not queued/
-	 * running as regular CFS).
+	 * The DL server can consume its runtime while throttled (not
+	 * queued / running as regular CFS).
 	 *
 	 * If the server consumes its entire runtime in this state. The server
 	 * is not required for the current period. Thus, reset the server by
@@ -1531,10 +1531,10 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 	}
 
 	/*
-	 * The fair server (sole dl_server) does not account for real-time
-	 * workload because it is running fair work.
+	 * The dl_server does not account for real-time workload because it
+	 * is running fair work.
 	 */
-	if (dl_se == &rq->fair_server)
+	if (dl_se->dl_server)
 		return;
 
 #ifdef CONFIG_RT_GROUP_SCHED
@@ -1569,9 +1569,9 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
  * In the non-defer mode, the idle time is not accounted, as the
  * server provides a guarantee.
  *
- * If the dl_server is in defer mode, the idle time is also considered
- * as time available for the fair server, avoiding a penalty for the
- * rt scheduler that did not consumed that time.
+ * If the dl_server is in defer mode, the idle time is also considered as
+ * time available for the dl_server, avoiding a penalty for the rt
+ * scheduler that did not consumed that time.
  */
 void dl_server_update_idle(struct sched_dl_entity *dl_se, s64 delta_exec)
 {
@@ -1810,6 +1810,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 	hrtimer_try_to_cancel(&dl_se->dl_timer);
 	dl_se->dl_defer_armed = 0;
 	dl_se->dl_throttled = 0;
+	dl_se->dl_defer_running = 0;
 	dl_se->dl_defer_idle = 0;
 	dl_se->dl_server_active = 0;
 }
@@ -1844,6 +1845,18 @@ void sched_init_dl_servers(void)
 		dl_se->dl_server = 1;
 		dl_se->dl_defer = 1;
 		setup_new_dl_entity(dl_se);
+
+#ifdef CONFIG_SCHED_CLASS_EXT
+		dl_se = &rq->ext_server;
+
+		WARN_ON(dl_server(dl_se));
+
+		dl_server_apply_params(dl_se, runtime, period, 1);
+
+		dl_se->dl_server = 1;
+		dl_se->dl_defer = 1;
+		setup_new_dl_entity(dl_se);
+#endif
 	}
 }
 
@@ -3183,6 +3196,36 @@ void dl_add_task_root_domain(struct task_struct *p)
 	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 }
 
+static void dl_server_add_bw(struct root_domain *rd, int cpu)
+{
+	struct sched_dl_entity *dl_se;
+
+	dl_se = &cpu_rq(cpu)->fair_server;
+	if (dl_server(dl_se) && cpu_active(cpu))
+		__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(cpu));
+
+#ifdef CONFIG_SCHED_CLASS_EXT
+	dl_se = &cpu_rq(cpu)->ext_server;
+	if (dl_server(dl_se) && cpu_active(cpu))
+		__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(cpu));
+#endif
+}
+
+static u64 dl_server_read_bw(int cpu)
+{
+	u64 dl_bw = 0;
+
+	if (cpu_rq(cpu)->fair_server.dl_server)
+		dl_bw += cpu_rq(cpu)->fair_server.dl_bw;
+
+#ifdef CONFIG_SCHED_CLASS_EXT
+	if (cpu_rq(cpu)->ext_server.dl_server)
+		dl_bw += cpu_rq(cpu)->ext_server.dl_bw;
+#endif
+
+	return dl_bw;
+}
+
 void dl_clear_root_domain(struct root_domain *rd)
 {
 	int i;
@@ -3201,12 +3244,8 @@ void dl_clear_root_domain(struct root_domain *rd)
 	 * dl_servers are not tasks. Since dl_add_task_root_domain ignores
 	 * them, we need to account for them here explicitly.
 	 */
-	for_each_cpu(i, rd->span) {
-		struct sched_dl_entity *dl_se = &cpu_rq(i)->fair_server;
-
-		if (dl_server(dl_se) && cpu_active(i))
-			__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(i));
-	}
+	for_each_cpu(i, rd->span)
+		dl_server_add_bw(rd, i);
 }
 
 void dl_clear_root_domain_cpu(int cpu)
@@ -3702,7 +3741,7 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 	unsigned long flags, cap;
 	struct dl_bw *dl_b;
 	bool overflow = 0;
-	u64 fair_server_bw = 0;
+	u64 dl_server_bw = 0;
 
 	rcu_read_lock_sched();
 	dl_b = dl_bw_of(cpu);
@@ -3735,27 +3774,26 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 		cap -= arch_scale_cpu_capacity(cpu);
 
 		/*
-		 * cpu is going offline and NORMAL tasks will be moved away
-		 * from it. We can thus discount dl_server bandwidth
-		 * contribution as it won't need to be servicing tasks after
-		 * the cpu is off.
+		 * cpu is going offline and NORMAL and EXT tasks will be
+		 * moved away from it. We can thus discount dl_server
+		 * bandwidth contribution as it won't need to be servicing
+		 * tasks after the cpu is off.
 		 */
-		if (cpu_rq(cpu)->fair_server.dl_server)
-			fair_server_bw = cpu_rq(cpu)->fair_server.dl_bw;
+		dl_server_bw = dl_server_read_bw(cpu);
 
 		/*
 		 * Not much to check if no DEADLINE bandwidth is present.
 		 * dl_servers we can discount, as tasks will be moved out the
 		 * offlined CPUs anyway.
 		 */
-		if (dl_b->total_bw - fair_server_bw > 0) {
+		if (dl_b->total_bw - dl_server_bw > 0) {
 			/*
 			 * Leaving at least one CPU for DEADLINE tasks seems a
 			 * wise thing to do. As said above, cpu is not offline
 			 * yet, so account for that.
 			 */
 			if (dl_bw_cpus(cpu) - 1)
-				overflow = __dl_overflow(dl_b, cap, fair_server_bw, 0);
+				overflow = __dl_overflow(dl_b, cap, dl_server_bw, 0);
 			else
 				overflow = 1;
 		}
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 94164f2dec6dc..04daaac74f514 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -957,6 +957,8 @@ static void update_curr_scx(struct rq *rq)
 		if (!curr->scx.slice)
 			touch_core_sched(rq, curr);
 	}
+
+	dl_server_update(&rq->ext_server, delta_exec);
 }
 
 static bool scx_dsq_priq_less(struct rb_node *node_a,
@@ -1500,6 +1502,10 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 	if (enq_flags & SCX_ENQ_WAKEUP)
 		touch_core_sched(rq, p);
 
+	/* Start dl_server if this is the first task being enqueued */
+	if (rq->scx.nr_running == 1)
+		dl_server_start(&rq->ext_server);
+
 	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
 out:
 	rq->scx.flags &= ~SCX_RQ_IN_WAKEUP;
@@ -2511,6 +2517,33 @@ static struct task_struct *pick_task_scx(struct rq *rq, struct rq_flags *rf)
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
+	if (!scx_enabled())
+		return NULL;
+
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
@@ -3090,6 +3123,15 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
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
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index c174afe1dd177..53793b9a04185 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -530,6 +530,9 @@ static void update_curr_idle(struct rq *rq)
 	se->exec_start = now;
 
 	dl_server_update_idle(&rq->fair_server, delta_exec);
+#ifdef CONFIG_SCHED_CLASS_EXT
+	dl_server_update_idle(&rq->ext_server, delta_exec);
+#endif
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d30cca6870f5f..28c24cda1c3ce 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -414,6 +414,7 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 extern void sched_init_dl_servers(void);
 
 extern void fair_server_init(struct rq *rq);
+extern void ext_server_init(struct rq *rq);
 extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
 		    u64 runtime, u64 period, bool init);
@@ -1151,6 +1152,7 @@ struct rq {
 	struct dl_rq		dl;
 #ifdef CONFIG_SCHED_CLASS_EXT
 	struct scx_rq		scx;
+	struct sched_dl_entity	ext_server;
 #endif
 
 	struct sched_dl_entity	fair_server;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index cf643a5ddedd2..ac268da917781 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -508,6 +508,11 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 	if (rq->fair_server.dl_server)
 		__dl_server_attach_root(&rq->fair_server, rq);
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+	if (rq->ext_server.dl_server)
+		__dl_server_attach_root(&rq->ext_server, rq);
+#endif
+
 	rq_unlock_irqrestore(rq, &rf);
 
 	if (old_rd)
-- 
2.52.0


