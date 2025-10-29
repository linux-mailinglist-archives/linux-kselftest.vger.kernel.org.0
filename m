Return-Path: <linux-kselftest+bounces-44351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BC6C1CFB8
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 20:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6088561FAC
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 19:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096CF35971B;
	Wed, 29 Oct 2025 19:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a3/hXv+Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010029.outbound.protection.outlook.com [52.101.56.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE4D359FB7;
	Wed, 29 Oct 2025 19:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761765171; cv=fail; b=bWjJDtunMjdnaXliU5SteXOKvPCd6FPGlykmhPfpzeM5N+kplvoSA+DIehUDpY59P6hLjFOmqgeOAcxIyWO2wnpVlCmm39alQEW5f7JUZp61PqUsqt/Mihf1pnf81+iznYAqdKyOTjqWsaJP/N1H90+jidiCNxc0SZpvA9ztASQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761765171; c=relaxed/simple;
	bh=pkB4/NIWKL4Elg6OlylQnbc0GBg8Nw9BXrBAAo7d+TE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ks98dgRvpRiUC8wuqGommjjPw91PrKRwvUZ/0c+hWfHyzNxDQCrWYRxhPzpHocb5d34ptMx7M97QzSgle1BTH6TPfSGZBXsZoiT8BILCyrlTG1fP1H4eVtd7yjsf1fkQdWqF/W3Usv20rRDQFzWgCMR5tpjn616vZSKr/2DZ8Vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a3/hXv+Z; arc=fail smtp.client-ip=52.101.56.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xnv7hBVveNO8X/QrF2p5jd6V9hxeKFZJbzpDF5Ht4brIC1baK0Qc4CfS+njPJljdN20ft7U5huBUpNba++fIQVmdXwaIfOb1/i+b0UJkZgNnTM3K/9q1FrezCz7Yud4XL1HJNM9EpDw7hyyz1Lsrqj5I40NBALPU4sIupsJm7PnlxDQilwkeUJUpa5FqRIi8oD3AwF5F0SrB0xQubpghI621dBYHTuCYGEMAjZFRLJtC1dWH8GmoYMZI6wy1PH8VwwR/c5rn14yUpZ6fC8bxaEhJmcX/K972zddXSLjYTSkfJLaxL/JAmafK8MAj7aRhFRZOQqazSqjR08lMQexojg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvJcLdF9Db8/CAMFqa8QLdSJRChpzkjwBUo3kY02OfM=;
 b=WlG3WD262HC23E33D2xYdGQUq9zg6WV3uI7O0PxH9Dz8sSeMGIuRGl7IKMsfQsyHe2FWu3HNOmtnG8Fpd6tEj1GTcGQf1U3MgmQPFeKdYG47Vo2VRylmtcUWn0xMVFLYpptNQX5xlQ2D69tm6HGSbL4yt2XMoJ85jTNbZYV1KsSyIolWQ1PczsRG8a993+dvUNl5XTumTDBxwZdVV9vDhwBLzlFldxtwQ3STEciK5mfZWBvkvG8leluSi7eDzIzJsz+/hPTnFtbM0VQ577000uf12Z9Krds3WjNYYm1IwpUc/15zoBKhjP8KvX/f+gymAYeYDhnlsHqEjKiQ1ynEeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvJcLdF9Db8/CAMFqa8QLdSJRChpzkjwBUo3kY02OfM=;
 b=a3/hXv+Z+6AFEAga5PiRKaAzbvZ84wiB5dXQEpD3Z+Saz1L8Zy8KjUVcfVt0mYDjNlz40kESDRLFHoVO/TZUql8vxatA8oUAqsAWwMiKQdWV9JagIG1zdJViF0PKkpNIDLR9dyo/eztrpiRVZ8NZzocsmWPprwSZzoyGQqL1geKAKxV8zOc4/6dAQHrFr1NUlbE91ESmjxNxbET7oUor6NgzPunV96xGCMkuNlSP1JzZaZkc6x1MAJJBsfmyMkDCePyluzlFmFak/pxaw3hyamYQw/0QGxTczlDPNViSpb77r53SE0I98ykeMGFVTS1U/y92QRgQXmTb4KUz8y1OUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB6735.namprd12.prod.outlook.com (2603:10b6:a03:479::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 19:12:43 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 19:12:43 +0000
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
Subject: [PATCH 09/11] sched_ext: Selectively enable ext and fair DL servers
Date: Wed, 29 Oct 2025 20:08:46 +0100
Message-ID: <20251029191111.167537-10-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251029191111.167537-1-arighi@nvidia.com>
References: <20251029191111.167537-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0001.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 2718f72e-dfff-48f6-ec1e-08de171f22d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pwfjgoN0MhUnGvVLDXnzoytmbeMRY/EgT8lBYLwJoxIUYBYzPgzQN3QopRfd?=
 =?us-ascii?Q?2M2YsXcQ24dfELa0NNISlx82bznG21AYLzqC5y1kokOddJqbpWVFVBF4O9Dw?=
 =?us-ascii?Q?jdoPwqccPBKCfe72XCspd7nmYz5hQol53VuiXgP/FjDDwyr0ZlzMmh65fQfb?=
 =?us-ascii?Q?pSDCcbedHPnIIYj+VL54muorilKeK/Cj+AJRnaij4G2Q9g4Pi9O5xEawk8fU?=
 =?us-ascii?Q?7hYL37vPp9Ds9lq5FkNeZZ3RbpVv/6wKtZEyU7NEcEi8Y3A/S9P8UzMsX1gI?=
 =?us-ascii?Q?jCZlgtUP2VXbbp+JC636a31u/7MKG5B1D2mqWahz2VoxP72Mpg6hSpiORlAD?=
 =?us-ascii?Q?rp7YiO1RmXcYYcgAF6HoSJ3YMJmFOUIxzX6M800W3gh3E76K3R56Kca3Qxvn?=
 =?us-ascii?Q?NiwTQJnc8ctMW2RBoRzStGSFyJTGsb8oKJODbG1MXVqyyWhNCQItpxw0TNlP?=
 =?us-ascii?Q?jwUITu6EJSRZFDGGhRw+EQxMPqVZqHuCI9cFYBl9Pp5IXGP6jPNIpb6emuFQ?=
 =?us-ascii?Q?nf8jBlZADsEdXaNzFu3FNYMaZhrA+ioFzz1mjF7VCqgZUlpejbKvuSgA1PvI?=
 =?us-ascii?Q?gUKYDx6mj81XQOHaDMj5M2pvX0RUFGU5nt9EYkq/6Qauh4Kf7J+NHfthDFiR?=
 =?us-ascii?Q?226fsS6LcqSsxhHlKLe17ibyKpjShRa6uAPaHJuyRYMmZxNU8fK4ygRK7Opt?=
 =?us-ascii?Q?3yRccOfVrjcii9W09bXicTHoFOKUS3RyD2npZaAW385cYbMkjIxVFPGaAVk5?=
 =?us-ascii?Q?DqmYqzDpfFvPk3B/A2Z28Z+FPn7E5ZVoJfKshMPgalu/pZLY5MKeCQO78OBN?=
 =?us-ascii?Q?2IjqkJeEp9ax0Se4akb+BJpl+6QsXov3egKGLpli8231Y/M5aKe5rQEjwlwp?=
 =?us-ascii?Q?0fXQMiPYbPTfpggxWQXB0B1F1aCYrlLZ52spgcKusEMazi5X054QgPXT2azJ?=
 =?us-ascii?Q?rHWmixqRqbemlntjRSF48/Y5rmbvAk6OVDwok7oSOIyJSNyJE1EPAhf0raKr?=
 =?us-ascii?Q?MCYB68jZXNiEXiS9ZKMjAonbq7knGhi4D6NehK3Ir8ym4/D6AczK7/83XCYK?=
 =?us-ascii?Q?td5sgrqN0c0BCuXxsXpeyRoiNF6fvcZAe1vWOZFb+pFUT9qIfY2rcxgBF+DC?=
 =?us-ascii?Q?SBLFBQ2Bpo2DGgSGLJUZslGEzGdl8jhiRmWvpKjR0CVr6uz02C2caj4DQ4G1?=
 =?us-ascii?Q?4AQTe+bCFjNixF6tVZluFZEFNDFgrbUzPZ4PRK3iQipZhBV0dGsfno2jCSeO?=
 =?us-ascii?Q?0Gvmj81vVnHKWmK/60JZKl31467w8uAJrlx+dXu19FCo579SjzsYUvQktwfG?=
 =?us-ascii?Q?d3YaLQ+LUWDBUJgIa3HhQDGNw/USxeuyQHp6kXtsp44D0ZeBlbMzk8Nq6/Cy?=
 =?us-ascii?Q?zWaq8Z7MnsJ8Ebp0cFzWc7Bslhr4g0gEhqsF+/wkJPPcLsVcNGlvN29wZGEe?=
 =?us-ascii?Q?zGuIG8nKpTMtpDcu6y/BYVHJFxBV24Cj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xw78qvHJnfLHz1wclC1LbPa0rn36TPjx6rtwvi46K/oImt8HHY0A5gmcIbty?=
 =?us-ascii?Q?yPn0LotgYBIQDP0yoo6msBykcteSkQLzEsLVOwpC6eGh04xldK2nPHIm0a64?=
 =?us-ascii?Q?d49omI0Bzw8mOb8oAI1Ae6dCQp9isEsmtq+kTaah4vDb6Am8z2bDlnNu6UOd?=
 =?us-ascii?Q?trJq101M/KxC5sTZQdC9zgX6gmM6nZ+yfahkPmtoEhe2tx3y7kyUoAQLfns3?=
 =?us-ascii?Q?W33h59aGUl69Ai/FF6fsCsp4DtLaRzAKi0ZiMstZupWUfR9hLovvuRA896HX?=
 =?us-ascii?Q?nKN2JzHh5m0GXkEBnwSwr7l/5k4gZjNcsOeO/RauIe7vbInOq04i7MrOnCYM?=
 =?us-ascii?Q?onB6TGBkUrHNlcb4OxNZL9IC7WR4hnRpYdYKcz0V8D33XqGcRRXdvmnc4NSO?=
 =?us-ascii?Q?XTLTf/ewKYtJluf/ofMfEXOxNrGbP9BaVcJh2l6Fassx4PrVnnE1/7xI5+b9?=
 =?us-ascii?Q?YgkLBkT7nWL+qYZebygCebDpjA8lZx6AROPcHeoMSiMkzhQHNyysRWl/Q/S6?=
 =?us-ascii?Q?g1QILhhi3h0OVJwVAWFJ+Zrnu+vGPcid1I6/Ps7FIECraw1pr7iIu/42PORY?=
 =?us-ascii?Q?zRgtHqWlKKkRHdym0jGmUshBqCwyFVJ2QJOyLfj3cNwL2k/Q/xXfGwr8WIpR?=
 =?us-ascii?Q?rCRNzL9w/subumQwFxZZH6cgZ8PQa3ZyshE8/3AqQyoHp+lVkUBoty51Hs4o?=
 =?us-ascii?Q?JixvSaqN4rc8CE/oGCsuMk9Sf+7SHyV0YRv9dF/X/JF4i6D0R+Wb/ncMVNx1?=
 =?us-ascii?Q?RWNb0GCJ3JchjLUdg7rSnJ7zR2ZGWqmOPja3FW5+YMGGcqTsYeKsuUafqFvh?=
 =?us-ascii?Q?WsOW5M1T7lfT/lUuZbzKEJccmC5ZsuaFHkMJAF2ztOls/ohQnZMniMkKNSPC?=
 =?us-ascii?Q?TgiLjjOiYKSqiJc3i9xn2CPZTvlbRcsTVZApXSCnWun8adtcQvat+/9CKr7O?=
 =?us-ascii?Q?HFVoc/WYoIUsbjuTAfqCHqKI8dmwFNY4XENIkY9x+2gUdVUOVpCJjIe1jRjI?=
 =?us-ascii?Q?abuSt+pc9L8zG0YY5CLOfHCO6N/niPrxw60TF1FGZPWGgXa9D7Erx7CCEJoT?=
 =?us-ascii?Q?cmtEsc0+SzExldICALRrkQ92OzGQOqw+c+AAysvlbOjOCgB+o6VB2Mf/1AM1?=
 =?us-ascii?Q?nfx5zkjnBQtLw/Bwd6CQwsu7bhY7jzJgfMFJPSkXQqi31baeXGb6aPKF41V0?=
 =?us-ascii?Q?Jz+mRsIKQzzNluUjzz4RRlqbaWtQ5rszOjjihgFAyP54fYsuT7QCNis02PY2?=
 =?us-ascii?Q?9EHTwRsreRvMeX1NlzDPKjL+CstDD+iSmM0GKHGbt9Ls1XnE2sKf4qLWHuja?=
 =?us-ascii?Q?rFkEofS41gxzHAakrBGpCGV/MgFo7xqit9BDIQ7qUDWKLSLXWjInr9TofdIU?=
 =?us-ascii?Q?y89Aj7Cl144qTwMVd99gIzyMxYCKY+Wf9eXQFHVD0TYlr8Jp5TSCKwqRALcm?=
 =?us-ascii?Q?jFBn39eT9acgb4XSo18LRxt8/kqYmh1HMlNb9ki54nMJQx3rZwySgf8RNJV9?=
 =?us-ascii?Q?jze7U0ZM37VYj4cbR1yA0bp8pJyFvdl1ELICe0ZabgiGWpjMWzBgRfQfm/Hh?=
 =?us-ascii?Q?aRavNH5eCz591M40GdpGTxISfPG3qN6zFxA8wRIe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2718f72e-dfff-48f6-ec1e-08de171f22d4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:12:43.0322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aaYL5DdQgGisVAa7Fz14sMlL0XDTttb0jzLNU2cAnmJ9gRULKtG/tvfoLaCtE3yyzYN/1YNTtF/VfSnCzYx0hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6735

Enable or disable the appropriate DL servers (ext and fair) depending on
whether an scx scheduler is started in full or partial mode:

 - in full mode, disable the fair DL server and enable the ext DL server
   on all online CPUs,
 - in partial mode (%SCX_OPS_SWITCH_PARTIAL), keep both fair and ext DL
   servers active to support tasks in both scheduling classes.

Additionally, handle CPU hotplug events by selectively enabling or
disabling the relevant DL servers on the CPU that is going
offline/online. This ensures correct bandwidth reservation also when
CPUs are brought online or offline.

v2: - start the dl_server if there's any scx task running in the rq
      (Christian Loehle)

Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 99 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 89 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2a25749c54ba1..9e23ead618e16 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2600,6 +2600,59 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 				 p, (struct cpumask *)p->cpus_ptr);
 }
 
+static void dl_server_on(struct rq *rq, bool switch_all)
+{
+	struct rq_flags rf;
+	int err;
+
+	rq_lock_irqsave(rq, &rf);
+	update_rq_clock(rq);
+
+	if (switch_all) {
+		/*
+		 * If all fair tasks are moved to the scx scheduler, we
+		 * don't need the fair DL server anymore, so remove it.
+		 *
+		 * When the current scx scheduler is unloaded, the fair DL
+		 * server will be re-initialized.
+		 */
+		if (dl_server_active(&rq->fair_server))
+			dl_server_stop(&rq->fair_server);
+		dl_server_remove_params(&rq->fair_server, rq, &rf);
+	}
+
+	err = dl_server_init_params(&rq->ext_server);
+	WARN_ON_ONCE(err);
+	if (rq->scx.nr_running)
+		dl_server_start(&rq->ext_server);
+
+	rq_unlock_irqrestore(rq, &rf);
+}
+
+static void dl_server_off(struct rq *rq, bool switch_all)
+{
+	struct rq_flags rf;
+	int err;
+
+	rq_lock_irqsave(rq, &rf);
+	update_rq_clock(rq);
+
+	if (dl_server_active(&rq->ext_server))
+		dl_server_stop(&rq->ext_server);
+	dl_server_remove_params(&rq->ext_server, rq, &rf);
+
+	if (switch_all) {
+		/*
+		 * Re-initialize the fair DL server if it was previously disabled
+		 * because all fair tasks had been moved to the ext class.
+		 */
+		err = dl_server_init_params(&rq->fair_server);
+		WARN_ON_ONCE(err);
+	}
+
+	rq_unlock_irqrestore(rq, &rf);
+}
+
 static void handle_hotplug(struct rq *rq, bool online)
 {
 	struct scx_sched *sch = scx_root;
@@ -2615,9 +2668,20 @@ static void handle_hotplug(struct rq *rq, bool online)
 	if (unlikely(!sch))
 		return;
 
-	if (scx_enabled())
+	if (scx_enabled()) {
+		bool is_switching_all = READ_ONCE(scx_switching_all);
+
 		scx_idle_update_selcpu_topology(&sch->ops);
 
+		/*
+		 * Update ext and fair DL servers on hotplug events.
+		 */
+		if (online)
+			dl_server_on(rq, is_switching_all);
+		else
+			dl_server_off(rq, is_switching_all);
+	}
+
 	if (online && SCX_HAS_OP(sch, cpu_online))
 		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, cpu_online, NULL, cpu);
 	else if (!online && SCX_HAS_OP(sch, cpu_offline))
@@ -3976,6 +4040,7 @@ static void scx_disable_workfn(struct kthread_work *work)
 	struct scx_exit_info *ei = sch->exit_info;
 	struct scx_task_iter sti;
 	struct task_struct *p;
+	bool is_switching_all = READ_ONCE(scx_switching_all);
 	int kind, cpu;
 
 	kind = atomic_read(&sch->exit_kind);
@@ -4031,6 +4096,22 @@ static void scx_disable_workfn(struct kthread_work *work)
 
 	scx_init_task_enabled = false;
 
+	for_each_online_cpu(cpu) {
+		struct rq *rq = cpu_rq(cpu);
+
+		/*
+		 * Invalidate all the rq clocks to prevent getting outdated
+		 * rq clocks from a previous scx scheduler.
+		 */
+		scx_rq_clock_invalidate(rq);
+
+		/*
+		 * We are unloading the sched_ext scheduler, we do not need its
+		 * DL server bandwidth anymore, remove it for all CPUs.
+		 */
+		dl_server_off(rq, is_switching_all);
+	}
+
 	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
@@ -4052,15 +4133,6 @@ static void scx_disable_workfn(struct kthread_work *work)
 	scx_task_iter_stop(&sti);
 	percpu_up_write(&scx_fork_rwsem);
 
-	/*
-	 * Invalidate all the rq clocks to prevent getting outdated
-	 * rq clocks from a previous scx scheduler.
-	 */
-	for_each_possible_cpu(cpu) {
-		struct rq *rq = cpu_rq(cpu);
-		scx_rq_clock_invalidate(rq);
-	}
-
 	/* no task is on scx, turn off all the switches and flush in-progress calls */
 	static_branch_disable(&__scx_enabled);
 	bitmap_zero(sch->has_op, SCX_OPI_END);
@@ -4834,6 +4906,13 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		}
 	}
 	scx_task_iter_stop(&sti);
+
+	/*
+	 * Enable the ext DL server on all online CPUs.
+	 */
+	for_each_online_cpu(cpu)
+		dl_server_on(cpu_rq(cpu), !(ops->flags & SCX_OPS_SWITCH_PARTIAL));
+
 	percpu_up_write(&scx_fork_rwsem);
 
 	scx_bypass(false);
-- 
2.51.2


