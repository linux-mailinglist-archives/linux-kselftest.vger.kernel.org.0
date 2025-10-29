Return-Path: <linux-kselftest+bounces-44343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B91EC1CF18
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 20:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 283495843EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 19:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780B23590D4;
	Wed, 29 Oct 2025 19:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IvYdoLjH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB93A37A3C7;
	Wed, 29 Oct 2025 19:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761765104; cv=fail; b=sWPQQCqWfzTg3DX5D3B9Gn6Zis3+R+KG5nc3TCK3SrpLxOYxzYsNomVFpeNmdP+SKdmpEPZN7tXn3s+vNwYhDHBWWLUmW4cenkkCs29sLa2cb0R75aPfRQiyQIvRgsDhoHlrWd6u5eNLmXve6p7OEvVwverLY0XBk3HPRy/nsEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761765104; c=relaxed/simple;
	bh=ZwjSVQ9DaMRzzwNL3FFIYKhAVYYS+r3A7m4zu8fb438=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A35hB8V93mCiFY560PujSkAsmgj4MmaL28pBtN0hLfa5ifspMBQmhEJwOe44UabcOmyeeSbcGKnNpnDw7tIJKrMYHsy+C7J2I8JpcS8QpD8lk/TsxhNMW1Ah/vjxUwrke5Be+oFUKol/v07NEHtV4VuSEgDB7nTmX2IJZWKmJrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IvYdoLjH; arc=fail smtp.client-ip=40.107.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3JqOmYGxIXkr3iqecpw/cWvg/TwdDjSUwPv+QJO7fEd/mnqO2y1l6+ctXVntxz866u2YXTdCt0GJqS/EWp9NPjhupWQGA4+ujmKjNdgO2CMvP1YMX1yuqzOF0RBDhVZ0Z38j9475ICaUZjxMu/83fshEiAelp2M2P5NsL21L2V9JplMx616u8oGl+bxjrRVVI04dsbPYf97X+6IfKSf+PuoW6vvToe0pR7RH+49ERJDdUdIO6MtDG5p0jVVDn7nXzTK7Hs+uYK3OxrDy13/C82+YbtjuZRRhZcynMlcreIg44GU9WDPm2iSzTSuPeZDxKM9gqg4MmXi4MNk7SJtgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vmkYXV0KMfQ8IUCHkW1myzXbqRX4HdCVKyCUp1IKro=;
 b=eR3hOlF07CWA7m0SZRD/WTNszxIYVEa3lvIJoOXI5yAV7+PQQdIQn7+SG8ZW347JxwYtlbqP2r9jgztQ7IJVM9liNtgxmz9rVk3iwjzuBPp2VdjYF8U0imz66yNl21XL5MnZPwiTzy3+gKObzTANWmag8iRCWx4p8rRx5CNNjMYVZkAIeDkYOa8YzITEqqWraWrYRDLtcdYYfYymSJS4R5w+lvCNtxcmntUx4dtsw01mw4F2Yi/aOpTrPI15d5G1LrdlgOTFSyhHOlq0tl4601NKKqfHAHuLlAdMYfrIm1skXRGdg3OZo8+ej5EkA2YqNjqCYWimrbrXY6RzNXuMHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vmkYXV0KMfQ8IUCHkW1myzXbqRX4HdCVKyCUp1IKro=;
 b=IvYdoLjHkF5MTCUGlLDeXD+WQOc+7TgjHEKnpAjrgH0cybKOWBKfpMS+AoXTrO0IFPb7o2MQT+L3N1sGDcHj6drfC4wVR+AL+cJyAHrW6w/ayT4hwlweBGEKqlzsdIHlvfxhoxPSnyb4blVN0zuxOgvygWkP6M+mAAoy2a/yXWiIMQmV9/JW0LWQgTyZhqHyo7v0PXARijjhXXulsVFj2+DPtvHnRXugRtrORyEF/C9H2wK5VH0HpO4qXenYQmiGZQvdYzTDm3jEzZe54ZBUwbRUIPX69FKe60UssuCadGoON9QrLjn5xrLbO6Q0ezh4kib0p4jkduHJpHq7az4eqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB6735.namprd12.prod.outlook.com (2603:10b6:a03:479::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 19:11:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 19:11:34 +0000
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
Subject: [PATCH 01/11] sched/debug: Fix updating of ppos on server write ops
Date: Wed, 29 Oct 2025 20:08:38 +0100
Message-ID: <20251029191111.167537-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251029191111.167537-1-arighi@nvidia.com>
References: <20251029191111.167537-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0025.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e445e66-7915-41c9-9f56-08de171efa37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0buE53qVR5Dyb1dHdELnolNt4JBD268+AdqclFNfbh3or3F/GntWUmQx7Vp3?=
 =?us-ascii?Q?WOoq8YsGM4/iBaQ4P7OzAYjRiJZ56rNN6fzvJC0ZK89sjTWFPD3AV5EaZ1zx?=
 =?us-ascii?Q?5NNu3cuiCf4V63ZsUWGpIb/mO1qhb3LVPOWT69SFNWiEhcA6ctKv3d07ESRk?=
 =?us-ascii?Q?v1KbNuWvdwILbakpL/wkneYYFuX1KYLzA8HScc9RB946pnEvEM+igDyyVSZL?=
 =?us-ascii?Q?utNodooWHQvv7MTLhNfMmYftJYCQBtVQ9YLBe7EcI7Pem637lVs+bePa0XZN?=
 =?us-ascii?Q?GXN7P++1tgaTlqZcDWrLwyGiF69DHBeYF8EtVgWGEG8IziruFAeAhyecW8rx?=
 =?us-ascii?Q?+WOHP/lDoa2m2ZPz8xXBVwT5pd7oubsY80+n5a182zw9uJkeFCPF7QBMxbot?=
 =?us-ascii?Q?6LwzM6HB4zj+UlA2DP0weHeZdUJBhW0DjsmbVnoa0Py0oUjSkACEIF1ssrWm?=
 =?us-ascii?Q?sxzIdqZ28n2V5UwMWS408kAWlkykAbXumpT0tz7Lj/7bhcUqp79XBtcW7YbW?=
 =?us-ascii?Q?MV5IVQkKR0MOxaJgnhinCVsYjt4q9TEXO9cdylkMPkdEd7xToj81uNhoRIsT?=
 =?us-ascii?Q?tYtLkq6PukJcNQUXYtY9sfmYe8CeCbxdoW1wIqwBzpip6CanCTb62aR3slqH?=
 =?us-ascii?Q?15kqT8xqJrzFqwGDGyquhC5Nk4ydiTw7vqvptq7E+YxB2hNyCax460cjp2vd?=
 =?us-ascii?Q?PDjvQCRaO7Hu2YwBZKpDilI79yXPE+pcvzawkq219MlUymMO5LpgfJdvKtUP?=
 =?us-ascii?Q?o0DVLkp0S8hGPLjNiU3K0RTevM/k2C06RKirASh9HGFnw07Q2CCXYbfLeumB?=
 =?us-ascii?Q?+DTNutWRU1Lat+oRR3Nc6nuNUQqsI20prjrRVJA7ljagqcvpgnfDr5BogvTr?=
 =?us-ascii?Q?auPUMPYiMrwc70uIs2qt9FUgXFG5/3gI46ur78zV/5fgZv27iN4aBDxzNEGB?=
 =?us-ascii?Q?M3ykBLXmCYequkfOH3q3k5/IrsxETZRUgk5iw70pczf8YivhQfuw7eorZCb8?=
 =?us-ascii?Q?e/hyEQRCs70+wP0o/NnW3FiVx4h+GbjdvOSoPHdpFKs65+3NjOaCqmQSluvN?=
 =?us-ascii?Q?VUTyQkMqln1OebQhhpkRCQnCNivKoR174/CC7UAmtyU53ltsSxFYq5ZvctKO?=
 =?us-ascii?Q?Nw4I94D8MXjnn1hm4TLjS2DLKkyPq3F+RUxesM0k04KLQBy30AgJFzrX7sL5?=
 =?us-ascii?Q?xe6aPtwr9lOVW5vdE09Um6NwNw+CPU09DsLwFvNV/PNht06BLdnCJ4lWCBy2?=
 =?us-ascii?Q?c7brxC6vG4l4S/1UdzoZPw8mMy869hYv8wCV3J/oWNFdDNHB+3jPVZMKaK4k?=
 =?us-ascii?Q?T6jROAEDX5kilJFCNKNTBZT3t9aK83HtvIEChNbTV0lT/kSGIuSkPODy/uoW?=
 =?us-ascii?Q?kSCPABTUlCN5zTZOfNyG2lk3ofHyTP+uQkG9Og10r6Ubm8uEanbI6IdQYlPK?=
 =?us-ascii?Q?a9HHeQ5DEQ1Glj6xoihnDQVnbsl0w8j0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8SnzKhnJPpRJmzGD0xbk+1OdXSN48lRu5XmeKwxF+tiIZe0RV5BcJHz0vXTv?=
 =?us-ascii?Q?2AEqNX3ZbyapULQcgwyzjSysyv8OLN4vlqSiMfxfmXcuHn7Qr+DToXIMFGQo?=
 =?us-ascii?Q?J9RlS2Iq8p/8Aq3YBhLRCSGigPx1PSQubicB1Rn3CW0eX7oBiv10JgOMQSkk?=
 =?us-ascii?Q?toXLfwGQllXbFABCW3uqa2PRU+PNu6ZkzKwugGycrT4b0mEiGI/tJPA7+6C/?=
 =?us-ascii?Q?1FFxWMLd6GItQk+aVvQhT9Axl22MmBbXfFNTqi6w6P43OsqiHQSgaIrsrW8H?=
 =?us-ascii?Q?8OhU9RgYuob1XWhFcJhu9OSPNIUcXgIwuxsd5m2zd81J/dOsCWOm2ONLmGf4?=
 =?us-ascii?Q?JRHxAzQELXEdnUI8qypvy58ktsPpLlVnf8Yf4cwscmisp9oUKk+xcgSopfbn?=
 =?us-ascii?Q?WKZ73XvimWi3hskJK84thqJ6jBizcF5C4NTV6KAocPeMWKzz7Z4XzoPz9IfV?=
 =?us-ascii?Q?IAIiVbKbC5p/PbbuX3JhCVrgFWItFyzYynvipNmP4QRp031nP04EaFbclvgR?=
 =?us-ascii?Q?i28d0nDTxFKTWaSjgImtxQ4Z4Z+QHDlLQNGnmJZBaXgxjryzU8hdac+Si5Jr?=
 =?us-ascii?Q?LDxpB0M3ZmMznB3y9WN3OCbgCfG4zNQJM927rVByK2Otuj2MgrzUjIkKDh9N?=
 =?us-ascii?Q?PkZwg1xhGgJI7CeVCF1uZpZADqohJDbFIUz1mTJ4nagpKDVTdOUg7d2C6vMq?=
 =?us-ascii?Q?5mg618g7/eeWBKaKc9EPPgCAYE6X0IcYGzof/fJ/sdQMPXaIMovhFUaxBbEf?=
 =?us-ascii?Q?ufctm709XTj0zZrVw4tDJQIWBAGPmiesITIPbXaitc1uKGBTS/W4XmU0Rcas?=
 =?us-ascii?Q?QdqPGzezZTRlfg5E8D6vgzJY02oO4nco1IXB0CXWLDSilg10R9Wfa7yPN/m2?=
 =?us-ascii?Q?0dKiukWJMn8ApK9PndwQLcCrSWzt4zOo+85e9RPWfY2nmTthEhxyx1gCufw1?=
 =?us-ascii?Q?LC65qVz6xjX/ThrJdn5hFFY4cJq1pMBNLZAAIoQTJIsaqTXROfcFXYXF/m54?=
 =?us-ascii?Q?gG0Dsq4XoWrZdEHOPxzFgY6LYNCIvKzBrrMay05FIptEFLP6PxkRC73yMtoP?=
 =?us-ascii?Q?EJotxslw1il5AZNFxEH9PQvAL/VKjAwhYRWUic2sUKNG00HiPADRTg9SFdL1?=
 =?us-ascii?Q?GR00z/aQ9Fd7tcWqUZtHTXrFmusmQpUrS5wk1XCGEGY7Z18mldmKD40D8cn0?=
 =?us-ascii?Q?NfacJgHj1EY15Y3kUhUe92OdoFXboZuOMkNUBj9MzheMiwPR4ECwDcKVx3cH?=
 =?us-ascii?Q?C2kHS3e8qCZ3raBqGkEXWUIwWLhD+MBAjWPa0b5pydm+hMaeDQ9lUGg7aT87?=
 =?us-ascii?Q?7kBSZ99Ekw9DVMREXgtTLIMmbqtQov7qwxJD2bbf3kNDLLu0kZ/CuKpXoliR?=
 =?us-ascii?Q?UNN4PR3e4OzawphtFH+92FxZhnDrTRt7JU4Yvxit1UDasQcb7EPfxPjl8iv4?=
 =?us-ascii?Q?3EcSCrXSvQsyHJFlckMguXeTGF6+DdK5MTZzfTRjSD41v34WYKpk3Q3b/NWu?=
 =?us-ascii?Q?RGkDbUbyi3H58B0cBwDljKoeg6552hJLCGy6bfd74pS245VK2m47VuDeg8aN?=
 =?us-ascii?Q?9kiovokd6/cBXhnCzgxkBKzHuCSY+5C+XWoFO6la?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e445e66-7915-41c9-9f56-08de171efa37
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:11:34.8846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7sdjAHQQkcA9hN7qmVvgnEU0w60Vqr8B8Ev1unP8NzI4UOHEs0vfDODZX+TyPbbxsteXvsJ3MqmyKJoU7eEYsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6735

From: Joel Fernandes <joelagnelf@nvidia.com>

Updating "ppos" on error conditions does not make much sense. The pattern
is to return the error code directly without modifying the position, or
modify the position on success and return the number of bytes written.

Since on success, the return value of apply is 0, there is no point in
modifying ppos either. Fix it by removing all this and just returning
error code or number of bytes written on success.

Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/debug.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 02e16b70a7901..6cf9be6eea49a 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -345,8 +345,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
 	struct rq *rq = cpu_rq(cpu);
 	u64 runtime, period;
+	int retval = 0;
 	size_t err;
-	int retval;
 	u64 value;
 
 	err = kstrtoull_from_user(ubuf, cnt, 10, &value);
@@ -380,8 +380,6 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 		dl_server_stop(&rq->fair_server);
 
 		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
-		if (retval)
-			cnt = retval;
 
 		if (!runtime)
 			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
@@ -389,6 +387,9 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 
 		if (rq->cfs.h_nr_queued)
 			dl_server_start(&rq->fair_server);
+
+		if (retval < 0)
+			return retval;
 	}
 
 	*ppos += cnt;
-- 
2.51.2


