Return-Path: <linux-kselftest+bounces-48046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5A6CED2A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 01 Jan 2026 17:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B1A23007E4D
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jan 2026 16:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD7F2EDD6B;
	Thu,  1 Jan 2026 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RBF+PYtY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011026.outbound.protection.outlook.com [40.93.194.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5E32EDD7E;
	Thu,  1 Jan 2026 16:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767285282; cv=fail; b=DCUKaoxtVJOcbsEaPgWYctPIktDqjaVJMpEZgHHEVgFQsddOt2ItCcdT0UN+gcfNLVbF3ANHYJizT77T/AWwbrzcqteT9Xhkk8R7Aq3EPDw5Ljdfu2kfxLG9a//PtVKt1jZ63W+TKpcYGbhkVHLerSKuFxTiFSRtu7ZJbKEBSIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767285282; c=relaxed/simple;
	bh=KyF0xXKvBwAN+yiv1dgAfGAxaYaLnKvQedIJO5nqKRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FAiw4p+Xb/sal/1GOdedbBKC1jlq1Jq6uXYKcpc5wZDvkoNXA5VKxlC4ZpIhPOzIgKAsYoNOiKDlwZjfkZlt3UKtzkq9yfKT7FzkMPggiEyrhDofEU1fOsJ6VE5Fyz1o7+WVE1eWVCV6j4NuoIWPYqkpkWQ0Xf4E+c6inr4QOrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RBF+PYtY; arc=fail smtp.client-ip=40.93.194.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sywiqNMRxlNnSh4ydN6Fmtzm6bymzKv9AJ97F/mTJJIfo9otYaSJyV06sulP6KBRQxqVhaA6f6HkQHLZ2Rj6+gxxOYLEJoHG3Sf+2Jm28F7S55MYcjB1rIP3re9GgzC8AAhw96y7qDrND92xQCNqnqmjWOjNN8pbXtbAWdwoKFzejFU2pvXRAYZHEQnayN0EiALDbUc/oZCJwGg8rj/LqDoBdbRklwR2gG9HoYXz+jueP7jqmhmpfP/AsGWRSA2oO024wIAgx+k76aQDslDbq1U8Tx9aMHB4e2DDHUSd/hqQvFLZ3gaeZlx2WQNk6vULyRh1AKmbKOfCXUmWhzV9QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//zyC2NyEe7TuAV4RkC3qdrK/3/JJhsjQUiqoQdogJ8=;
 b=E1u+0jQSYn9kcR0Z3D7K+R3bONEQXtEBCeVawBbc8a1+GWcM0NvEmvP2g1OFD4qmu2+wP61+2rwV2rlRjg+RrDdifOdEXbZpxMLYjEVcr7NHROnF10DGwHzFWSyxkLlEo3DD0ZIEDDQ/n93UbUJwojFbXE0bmiT+ftasS7Awa01j4ZDQmwdoRgafhpp9GEvRgXT2sPnCdGkua0NS9aHh3tRJRW1rkAET4rJNINCbz4ba4NOCwF4uT+akaa8D2eocNjSnfZOC5mQytILw/P1sRMmf2o5zRnpUDXJmYdvYz6BlGakbO75gaSSGFgRPmnULxCdEwb2V4U9MrupRovb32A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//zyC2NyEe7TuAV4RkC3qdrK/3/JJhsjQUiqoQdogJ8=;
 b=RBF+PYtYHMfMzw1ggntXgzw759Xb1EQlyQROzyEPz3TSsUILpgOAaX49wqZ/b3HQsgAwe+xq/Eqhi3kYBfO8UJ02bOzpVcWuJNG69I9e+r8f2X4kwtl+6Y2dmk5dXhiFGDi913ivaQIYuUhgLViJK0hPJBAmo9+RbDQ9KfiJ45V0wTWDg4ALxt/IDdvwxYFVCYO79ciJSfOBFv+mRhU5Ysy6wxTKEFL0buRsXQ2SuW0jfOzt1nL/8JtGeCWS3GYlFQkDTyeExn4MroXAPuawlNnSDWj6IW+WN4Vyp9BB5UBRWOAvb9b52xRcCcF3vUpfs/NuUVYDPGzFa1fjs1blcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 1 Jan
 2026 16:34:38 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Thu, 1 Jan 2026
 16:34:38 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	rcu@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH -next 5/8] rcu/nocb: Add warning to detect if overload advancement is ever useful
Date: Thu,  1 Jan 2026 11:34:14 -0500
Message-Id: <20260101163417.1065705-6-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260101163417.1065705-1-joelagnelf@nvidia.com>
References: <20260101163417.1065705-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR02CA0032.namprd02.prod.outlook.com
 (2603:10b6:208:fc::45) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 423afa4b-867f-4668-deac-08de4953a7dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dDi7bh4Q4BzpIBnTSMvcIj61RN4ovmMCbRCn/XzCypShUG5KyxA2zyhx2xsP?=
 =?us-ascii?Q?SVc7iwZzChL3e1ObwTTbETmq+T3GLPvlKMB87c2LCaV7bEMKb4ibHxFUM0vc?=
 =?us-ascii?Q?0YJJyq85mK/oi3TV31ZgNHRac8BkiiFyRdPTtYqHG94w/KsxXVyNZiK/dRVH?=
 =?us-ascii?Q?wio2M5A5H8HSi5FPxTbz0UllXjkYPXxJGkzHIp1eRhE0xz2aJ0lSc39Vu8Dq?=
 =?us-ascii?Q?c4AWpSAXyOnAVxgPde85N4JHvnxnYyE51RjB/5xi6AXV8JuZmCatowOu0CVQ?=
 =?us-ascii?Q?lbzZhwV6NXAt0le4/o0oASI/4jhKiQv+dV1ybb5tDDoUkXuo0AZRUwvCfbCx?=
 =?us-ascii?Q?nQzzAdkpGcgCKTZvAudW4ya6MUs4S1yeI7oEgAJyDcLNDoDirmlr9KUkiFKV?=
 =?us-ascii?Q?MzglIvknjYaLTmHTGr7DlHd2S/Nb2VM7hKsyXkxC2EBi0/2cecPjn9A+Yf4g?=
 =?us-ascii?Q?LLBk89ICW/JTk5hCFfXBegI6+9kRlZ60foOxc1kZ1ugKub4hk61UmBFqaF0W?=
 =?us-ascii?Q?f9VDFeGow9hqEX17K7Ifz6UT2mgb81sYqIJw8ZNSbbfsRV2GTdZSr0a9YZ/l?=
 =?us-ascii?Q?nO2Du33UqhSMtDwQUtTdKCuSNk3m6jj24gKzNnzVAW0PE1Wc1ayjgcbVNRK1?=
 =?us-ascii?Q?xvuGsscrnJhObOSLXljwNLmlHLquZshrvTBD2b54Qd8bLej+DY599O2xqlZI?=
 =?us-ascii?Q?9JrwER5JAkuNr6p7aa4Khz6bPTIAKaIqEvil6/U8ktNTKryaEOfbhJpANNrr?=
 =?us-ascii?Q?8neQ6HH+rLJBtAT1JUzxH9cY2G40MAur2KtT8ubwrPX3BLLUrmgVJYxrPtiQ?=
 =?us-ascii?Q?i/NfP6DReDqLHPM40f0iqtdbal7WyU4iL1WdOznY9fg4NxugEiM2BqL9RCMA?=
 =?us-ascii?Q?607pVWxUwyawvBrjUq9NhdOYgi2Osm3bsMByq/0oM+Uq03AJ68hdnVKdNq2r?=
 =?us-ascii?Q?xt24svKXFT7dc6EeBu73JRvuVdb2qB6A/j2wwKBvABK2JOuLqROljqTRitK5?=
 =?us-ascii?Q?w2xZPICxNc+ExOAlG1WDI4p4sCc2yNWoQmcxnnH7Q1j9NgLL+8cpcKPJ0wa4?=
 =?us-ascii?Q?extgZYr9gSRQrIxUEzkvC4ZCiq3T2DH7gVwrhKzj1yxNzO+g227EhGPYsIUO?=
 =?us-ascii?Q?CvBUJn0LT40uus/Vjao9KavWEP3Ks8xsgBUk7kEl5MbXEzij6oEobELzgoVu?=
 =?us-ascii?Q?J+DNbn3LNTGJfuALTyfONN8lNR5cakWzGLhKlqy0885ALuk5K9ObW+V9OwGR?=
 =?us-ascii?Q?2cHhWjFHzwvmr587ra1XzPDfo+OWDrMUSWCS3MqCPmDpTA/YCqchJ8rPP9a3?=
 =?us-ascii?Q?IZYNdQQpcZlpxzGVGcyk5l//8KhR8Dbkzlr7G3KzbBRQ1tXnauP2aSentnfy?=
 =?us-ascii?Q?AybqD/4SBlZzuPKnJFtps9NCdS1Ngsr9tpi36Kw718nT/g6XvRTXmxpt4UMr?=
 =?us-ascii?Q?xLzGhiGQ3PRWgjUL4qEkh1M7o09saINz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YcCjFQkIyOAP+BfTxV7R3zk43Vz2xGeWo7Jz+Mz+QZ3KxOPqH8P8f+k2T50U?=
 =?us-ascii?Q?O0v1Ka/jli1U38KzaVTB+p4stupexwYPARYUoIqb34zaHpKQqP7MKcEKsoso?=
 =?us-ascii?Q?OHcWJfmU3xcw3xXXTd5RHkj9FY35MShxfPEX3xQqJY72RMNBefUUgC3/ynVs?=
 =?us-ascii?Q?JY3wZvkof2XIdjD1i1Edp+1wA+08fvDc7cgsQa5XW1/3lrrelsznNsU1IrqP?=
 =?us-ascii?Q?Sc1MU8AvdhR53ydhao7VPQa6KBb3//i2Bysf7ihwtKbnC74+oBNbegcfieRA?=
 =?us-ascii?Q?T6VmUC3BDc8OeWL18F7v8e6khSv0dit/Ifnt9v8JbSeEFBFkifr+pu9A5fFZ?=
 =?us-ascii?Q?s3H55FGY5m03pkU3ld/s4T7dwuvFWowh55bCiSPnHuh4jQNOIRg72h7tDdOY?=
 =?us-ascii?Q?v4fZNXQdoFwNQWe0868nUvNYNL/Mj8JlOEjVCGaJiG4sy7ThOjAqxCdyGRVF?=
 =?us-ascii?Q?fPVlRKgrGQ2+ud7nKJwQXAH5Pz5yGZlBchl0Tms00uFs8VJqCUw8vfU18JvB?=
 =?us-ascii?Q?Oj59Mhy/OwTnKOk0yKhvh7HDHBxkctkkIJr3I7rFQJnVa6V4bVYtvxdWyv/6?=
 =?us-ascii?Q?1UtuTQAmKgaHXk5LStn6F1rafzkeejNkbWb4CX1CEw2d3OkAvllY8klpgzre?=
 =?us-ascii?Q?ykFDppEKXcTpnMvfEy8Y1zWgwrBe2+dWg+78CIa4gUB7riDIr2X/LE4t2n0T?=
 =?us-ascii?Q?8qWxk6N0uMIL/JcqJWtZejXxF8hvwe8n074muoVNd+5UK5vTCLvcTxjqTbK0?=
 =?us-ascii?Q?YDF45UNCpfsrUGpqrjq3lbct5ThrofJOYXFuQ0iieFJ6nITwAKP35alDNAGc?=
 =?us-ascii?Q?8zIKDcWV+aJOgQNw/FOUAoNUwEiZypWP7lVR9uqbpXyMpPQfOL+41LmBrMMY?=
 =?us-ascii?Q?VPnzS/bFtIyMD6AdnCer3oIXgI3syRNgeW3IIwIAMjui0x0Zj+C4fgLfGqNv?=
 =?us-ascii?Q?Z7njV4icE3Vdz9dPkgmPPhQjmtbwuSPGW2ANE7zaDVCJR4VgECaYDzHLhGJr?=
 =?us-ascii?Q?tI94+PX4evuECNgvPMtToNtcXB9bWrcA/vJomRL6Ov1/tq+Thkp3ptjiSk6D?=
 =?us-ascii?Q?YFF9VUWVzG/5nmKkgq2bSOOgQv451UXEeUAZF+CtiFxJPqXVvLgSGEXzshqZ?=
 =?us-ascii?Q?GeKRKsSayTWDqmIqqHnfyM3w9sMmJrkEJ5tqYc2vKslk+EI0rhFWK1AZ8T/j?=
 =?us-ascii?Q?Y06sLLxFUXMv+BJ7uumzzj5PZijKF4AlvlWrruhWupA47QzZMYGVhkU/Z5sC?=
 =?us-ascii?Q?IbAFzeBhM69TmaybN5eDxK4e0RSF//Lw1KlicuhvIXC7rgGlxAyhKvdZ/isi?=
 =?us-ascii?Q?NrLx68wkE+p+grtiLbUOZc8JhsJoEbTQ8GXOsaBVvIdcriRiul+EWhrSw8He?=
 =?us-ascii?Q?Zced6uWNOvmiywh5QGI7lAOGyYyzugBss5UeEnsnx6AFfPubanJTU05ikiPe?=
 =?us-ascii?Q?YiiBOLWo4HpVavfimpO2HADf0NR9A8noAtk+PL2m1lyldXgw3c7fgxNb8sos?=
 =?us-ascii?Q?+xvIeeepS1kVEsM5sSY+FKJJE4dkG59CpmounmHeCCnOAFGdaNPVJD12UEgB?=
 =?us-ascii?Q?WeaXObTzW2W/vyP0kVX9C294eQLD/Ceb3jg1eDPMmRef31BSrNZexh1ILZsw?=
 =?us-ascii?Q?tne5XoguFAeGgFDCtLdBAO4verKFWkDdRbNJwlRua2YUYMw6/ECFcaBT8yoJ?=
 =?us-ascii?Q?cwlFmW/W0wXa5H9Lu9K5BwDif35NrBn3eg/IlMm6fnswj+S8zf8yMOpzYz7T?=
 =?us-ascii?Q?6ryACi/Iag=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 423afa4b-867f-4668-deac-08de4953a7dc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2026 16:34:38.1102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7lSJmsVfzG1ZRjA57s5i5sZpRNsI5yUKDvYzvY3X0PCx4ldLh8cQLRUARNJdAdgeQjWvEmqI5dY8XGIT0XnBog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974

During callback overload, the NOCB code attempts an opportunistic
advancement via rcu_advance_cbs_nowake().

Analysis via tracing with 300,000 callbacks flooded shows this
optimization is likely dead code:
- 30 overload conditions triggered
- 0 advancements actually occurred
- 100% of time no advancement due to current GP not done.

I also ran TREE05 and TREE08 for 2 hours and cannot trigger it.

When callbacks overflow (exceed qhimark), they are waiting for a grace
period that hasn't completed yet. The optimization requires the GP to be
complete to advance callbacks, but the overload condition itself is
caused by callbacks piling up faster than GPs can complete. This creates
a logical contradiction where the advancement cannot happen.

In *theory* this might be possible, the GP completed just in the nick of
time as we hit the overload, but this is just so rare that it can be
considered impossible when we cannot even hit it with synthetic callback
flooding even, it is a waste of cycles to even try to advance, let alone
be useful and is a maintenance burden complexity we don't need.

I suggest deletion. However, add a WARN_ON_ONCE for a merge window or 2
and delete it after out of extreme caution.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_nocb.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 7e9d465c8ab1..d3e6a0e77210 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -571,8 +571,20 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 		if (j != rdp->nocb_gp_adv_time &&
 		    rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
 		    rcu_seq_done(&rdp->mynode->gp_seq, cur_gp_seq)) {
+			long done_before = rcu_segcblist_get_seglen(&rdp->cblist, RCU_DONE_TAIL);
+
 			rcu_advance_cbs_nowake(rdp->mynode, rdp);
 			rdp->nocb_gp_adv_time = j;
+
+			/*
+			 * The advance_cbs call above is not useful. Under an
+			 * overload condition, nocb_gp_wait() is always waiting
+			 * for GP completion, due to this nothing can be moved
+			 * from WAIT to DONE, in the list. WARN if an
+			 * advancement happened (next step is deletion of advance).
+			 */
+			WARN_ON_ONCE(rcu_segcblist_get_seglen(&rdp->cblist,
+				     RCU_DONE_TAIL) > done_before);
 		}
 	}
 
-- 
2.34.1


