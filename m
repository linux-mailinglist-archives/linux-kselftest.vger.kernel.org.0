Return-Path: <linux-kselftest+bounces-44344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDCDC1CF36
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 20:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D3EA5836A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 19:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2AC3596ED;
	Wed, 29 Oct 2025 19:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L8EIBe2W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012040.outbound.protection.outlook.com [40.107.209.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2B83590D1;
	Wed, 29 Oct 2025 19:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761765107; cv=fail; b=qoqFvju4GGc1XiaDXzvwQ7TNStYJgf6GqOmk4vnT1iZA4vk9MHkgTnYIkr7m19V1WhG5f6/97rYMJlF5bcLphj0GRcA0oZNS9VhBZ/+SvaeT7H4Pm4xt8GKG+JHzCZbBgr9wEBSdQiEFQR023FoDTnkZpnAgxcyzIVenP1DEA9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761765107; c=relaxed/simple;
	bh=omkjJkCf70XhOrVc5AI1Vo1QOyfvF+2WuSpKQwFsvqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jrG5LxCz8sKIQ+3t/JMGOoyr2jPThWlQK4bWY1WxHs468piPCrleudhV9+FVK7mCPG4XuiB1kTJZVXCtGV8gRSjt2VYVDfAxHF08PPuBUNSveIkG6iJS8YgdGCeoM3IHZVXA4C5aRYwH2FgyqNGIsOPQOriTmybgjpZ636GomJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L8EIBe2W; arc=fail smtp.client-ip=40.107.209.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1umJe1fVeM5yPlSbFBFz0ewgALPVLY2SjRGyARqB8IHDUKBi3unA0r9XZx+rCEMaTmqFeLa4DD0qhGd63TI1zKtgWjN1os5rHSXj5rTJmJk0hRA3UieBxLj8klSERmzOOrEJ7dkdOppV4nv2bH8QuW2Iaea6hRx5JevZkWg2/j9uoJKr+HIANthrA7AmatApdDJsYvHU2tVBHqI6kaQgo/dHsUPMj//Ayz+WIqqIb/COLv/Lb1VI+/876d6wh8YKxvWrhDkWOpwKKRdfhUj78TYuXyc8Bftx/SswUhhRkx1a5gqcrc9uitEy8hJ4kMfMkbNTqV0Xdfd5Y1Sp22YEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmDRlIpJHam+lQBYyqup4/MgUD9sL9nALDLMQstXM2c=;
 b=cbG+7ugpWGWVXaORzTm1vDVBkQCnBXEPcga1GK0S7Si/WmTPR49QN1va58GaypWuAu0JVMQ0LvGZVHD3V873gG7b32bMIiB/SfZYL85ICWJdYF+keiRYlELeeNKBIiUzCT+2zA4BN+H9F9Y0/u7ojB6Afy+TPd2SRLWu7ZEOE0j4EP5RZdMHKhW/ESS7w/AeqfNSwjBPlFkEfqlcn6zuggSDQ30WHnnGTjjbuCY9bGn1kO9zn4dpBEPd2BSfAUR7439DegAyS7etoOLC3bkxG+XOfl4DgDwBYDnejKbav81966D3j/O/G0YAvDwMxLnVO+1YXGoK3154vJBKJ98p0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmDRlIpJHam+lQBYyqup4/MgUD9sL9nALDLMQstXM2c=;
 b=L8EIBe2WSk7PmcwSD0Eoqsnlp1EzTKCaDj+tERIixnYwtBWIkVk8/dWnlWtyZlbhyUqiugunfGqxfXVKjE3XK2GdUZAQUGTyNlf5aYHhD1ksuIQmEBAvIOa8WTF0YpkdMNs+wx7hle7Pxy9bX5blX/RXSZ90/dCgWKR0ukjTZj5MgmSiuFja/ULTg83yGbYXbStpZeJMCQjEfXPc5MG/uNOHh5iHDjGJsw+Ejsba16wbS8sOz9SgT38yx33lk4A7nqREAmOIbesFQvIenOrVsNNarj8BEQooeAR1+oT4CignrYpDM4p0pfxeiv+rWAQjA8NaTGFF/7mHaEV4IAVMOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB6735.namprd12.prod.outlook.com (2603:10b6:a03:479::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 19:11:43 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 19:11:43 +0000
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
Subject: [PATCH 02/11] sched/debug: Stop and start server based on if it was active
Date: Wed, 29 Oct 2025 20:08:39 +0100
Message-ID: <20251029191111.167537-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251029191111.167537-1-arighi@nvidia.com>
References: <20251029191111.167537-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0016.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::8)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 7523d3a8-4901-41c9-237b-08de171eff0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dXwKhCQjSsO4VoH0JT7N8iR/3IhHRpfTC3XroqixQj+Z1x0PJbONIi+oyEKA?=
 =?us-ascii?Q?DhpeXRtqZulJhNEuPV4mSBIX/Z2sCWLJpKOQ2rUq44QObTGy0fIOnoCwsJTW?=
 =?us-ascii?Q?zc5CcyGFE4nvJMnE0AtYYlP9YKPsBQoCCT7s62FwZlxnLp+2kmAWIGnDpoie?=
 =?us-ascii?Q?rCNKuBkR+2wry0gVcgUcHWRHXDV1o+p1j224KqZ+wxEATBlGOyCe++9+xcAI?=
 =?us-ascii?Q?bAXkQPiKaet4JJiWSe6+AlzgFtOxGfqhZ7C4ZMMs1Xydsebb4YvOPJMIiIKl?=
 =?us-ascii?Q?uSMbQxF2cEkJ8cqM/1URG4qA1FdeirAG8BAOEpMxawc7k3t74WfsHnHiiYBY?=
 =?us-ascii?Q?uEbYnaHJpvfw7lPJkcsnT/BzvHu3zhYSdEAlbhsKLriOEy2h01z+IBLIfTia?=
 =?us-ascii?Q?zvEgBcxX45Fxb66AQ1dU2ymN8iGvERiov1ME7pXeqmYBiYxzCxEMnfiowC7/?=
 =?us-ascii?Q?kg+sq6p2ulJAuOUoRS/vQY6zwF3r8nLMmNgIskhmpMvubyyTCVmkzPig17Pz?=
 =?us-ascii?Q?9tC6ZabzI+jJKMIA4CxzDEqGyVN6zSUBjL26ZB9i9aBTfVg1g3ZrwgnM+1yd?=
 =?us-ascii?Q?SeuRS2Dg4hilHGOYma4P2WX4uDS3JTU47sj/+0uHhNDn2PD77AOaMWpNdlf4?=
 =?us-ascii?Q?15Vkr2tVlBZEqrc5EfhYfFNY9XYLkc7g/uMF3oP58DpuPoMVARk0D7JUeBH/?=
 =?us-ascii?Q?qea9s7m67e35AvS/PwmAih2ybNZMxI7tBUCVjVYwqCULcsHmBH4bFCPpT75J?=
 =?us-ascii?Q?jn5xw9dMYEDTIXoC1+ht1kPRQdUQUwQlGbgRgj7DBQQgGd4kecc57T4CO8Q1?=
 =?us-ascii?Q?RhPZAjj3lHyYHP4UyWcNGxUgJSyCNduT6a29kLoK6rIE0tBMQXF//sU3ng3v?=
 =?us-ascii?Q?+/LIIDc65JTsuiAMJAwFbpALw+wwwuBKNvM4cwZQ1frq3DtZKOYX+GD4LHj+?=
 =?us-ascii?Q?8Mbe3w00rZlomZcAfqHnJcVTks0jlpJWb/Bct74cTmHACKuvjOHIYllDwA9u?=
 =?us-ascii?Q?XbNE9xLBDAsPbPAgSssF3HB1wUMFfrsqIW5/LKF/0uF7mTxl/pDeoe73HuqH?=
 =?us-ascii?Q?o6F1SptMyDkvEbGp8VVaaSvWWEs2aokH1Gg8mTqey39DHkLLQQgHam8/pFwD?=
 =?us-ascii?Q?xAn+Nr+Me75ddpJ0fYxsKaE5dT5QdhadiafazKWhq3itWEqjtnoz23AyRK5G?=
 =?us-ascii?Q?jZRQ56gVFbr8/GE8Y1HEvN7mToN6oYwqKNo1eFUAiUOisNsa2xUUYam5slXI?=
 =?us-ascii?Q?YFjWocnqr2JItZ4HoGIhStZclHhYUvq5EtOzFafB45wp7KeClQ28HKOXmWio?=
 =?us-ascii?Q?gwxv5A41Qx6Psp3E+LBpEEiXorh070vcOIzyPgbbvDFHbWo7AFsfKgiBANiu?=
 =?us-ascii?Q?hGCNyaw0YtjZYsMHyguf1yE7nZC9E0Zqnb5tEf3gxuLKwjCdPeEA2YiqFCXQ?=
 =?us-ascii?Q?4pZAooTPXOAubBAYdl2a/6c7JxT1mq5a?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vxy4LgImc2c56627hXNh2fgUQplM8bqScpbDuTEYmTvAO4T0dFF+OO/5CL/y?=
 =?us-ascii?Q?+7z+CXvlk8EhkZidqMxOnZOYaZMq9pQv88mrqYKy2sF3xzCpPXDxl/J1ULWx?=
 =?us-ascii?Q?s/ymKRUgSOQ+hk3qaGH60z6dSNbOGrQgc2ijkxTX/+Y88HOKcZhEY7J755S8?=
 =?us-ascii?Q?+e/b84UO0oHzT798dngQpRS1devxmRoW05CEVR1cG4YqA+mRUUOmzPK4147X?=
 =?us-ascii?Q?kONW+E+24ddvhyG1TzV2c3Og5k745O+CY/OWrgl6VdaOBVrYbRMR3k9A3+2u?=
 =?us-ascii?Q?4qCvsbyA+NE/ivOIzXv2Jx8KvN0mBgWvdswkbc+t8cg4dyAi+8h6HOtIt0L1?=
 =?us-ascii?Q?DHQRwsvEvhcrwfdn0ehS+pEQZgbLGem5YbhPS3tZ84E3NQRis3ctiAPreLWU?=
 =?us-ascii?Q?ce5eMfkN83BrujIgR2SuCwQGXsWXIMHXcP2J7v2Gh60VNRtLfNELcblSo8oG?=
 =?us-ascii?Q?yRHrqtsmAzGob/ih88/tiWpIfn5fnq5UMn3CjpfVNUQiUqYuy+jIj4H0ilNt?=
 =?us-ascii?Q?ROrFV9xol77K0MlTWr/9Tp7A5GWaGdr8Q2vj95t8wybHmquUNwaO49ZNzHTx?=
 =?us-ascii?Q?W3tVPTYqPauzc9/b9LGLB1iwSNZrODdDWgOLR5deLyyj7FspAKYORn+ifWam?=
 =?us-ascii?Q?pT/0rVFBAnp7Oy++tCQF4gr9s6E7klHDQhxbKvvWIws3NEnGOEh8kxXbQM+Q?=
 =?us-ascii?Q?yP8JW4JoQ9p+c2hxyqBwcv3AaRnd/8vE+7bz+UYRX5Kci3sJ1FIK6LpHLPSM?=
 =?us-ascii?Q?Wh3zgKeLOkeK/EKTCBD/qWXxj+M0xXyexOuRQP+TszEBKHvzfYrgb+LzOB4t?=
 =?us-ascii?Q?GiOsWASfhdOqfu6+wNkhbC+DyjiPKy6Imo0ixQV5xOOZm/w+hlZNpw7M0Kh/?=
 =?us-ascii?Q?fkbQeq7/5mDW7SmzzipiESXyuu9c5i4e5GXbxkdo/lguGW5qMIO2j+aR4/It?=
 =?us-ascii?Q?ImTwZDlpWzHoJx/nvonYT1X6Ei2K7L9WU8eYhERRGCwo5T1UDg/OyGBsta/Z?=
 =?us-ascii?Q?nFo9GSJYEhePhkuFmQKxRuBDgfrpTuYV8HXarw/cmD4DrMGvv873AEWjyphh?=
 =?us-ascii?Q?jhHdMYahUW68Tv9gO9UZzyw6yKydB8G30AqNGDI9Vx8v/8no7zpPZywniYKx?=
 =?us-ascii?Q?59YlZPpRemQiUmGxR0LGQp8OPep07snVNpqZiZub1OL6t1cu8Et+9H0BBz4l?=
 =?us-ascii?Q?HBMxhZ05tMPRHSypf6H+HP6bw2NtSB8UzQCD2nXky1ANNdFe7KwWfPYakxHs?=
 =?us-ascii?Q?FedOVLM9YItnkHsbwcSmvNO9MEO4j1q9SpZ4woB6MNTF9kr4QCIDgpDh+5mr?=
 =?us-ascii?Q?rV5A/G4v+SdTt2YJ9XfbJtwBAZgwALEIEu4F4a2RhRIkH865jlvGKrGclwHl?=
 =?us-ascii?Q?RYvbxfD6sA/Qq2vmwIGHV8TZTx+H0b+rFZpRG98pHS0xxB8x1B3X17oOlxms?=
 =?us-ascii?Q?NJwXmwjg0f01rNwtjjuAFUYIjiCkhylVZr9cWrVSLvZQDiJ1+zUSlW8Czn+s?=
 =?us-ascii?Q?peM44gr5iAL+wBQ3F9spX/NiXuhOIK0SIXJtQIKN4bCaRMUQbIFXyugPJERq?=
 =?us-ascii?Q?WEHyv71RxOzW4e73/c5OAAdsFP8q/n872S8x8/L7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7523d3a8-4901-41c9-237b-08de171eff0f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:11:42.9947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDbx3f3OJ0sCqGfzOThps6gLojGz2KX0rOc5Ek7zbjLqKN9StdT7T9Pt2wRZ3fDfO9BvpfpDjbDn9v4V/1atTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6735

From: Joel Fernandes <joelagnelf@nvidia.com>

Currently the DL server interface for applying parameters checks
CFS-internals to identify if the server is active. This is error-prone
and makes it difficult when adding new servers in the future.

Fix it, by using dl_server_active() which is also used by the DL server
code to determine if the DL server was started.

Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/debug.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 6cf9be6eea49a..e71f6618c1a6a 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -354,6 +354,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 		return err;
 
 	scoped_guard (rq_lock_irqsave, rq) {
+		bool is_active;
+
 		runtime  = rq->fair_server.dl_runtime;
 		period = rq->fair_server.dl_period;
 
@@ -376,8 +378,11 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 			return  -EINVAL;
 		}
 
-		update_rq_clock(rq);
-		dl_server_stop(&rq->fair_server);
+		is_active = dl_server_active(&rq->fair_server);
+		if (is_active) {
+			update_rq_clock(rq);
+			dl_server_stop(&rq->fair_server);
+		}
 
 		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
 
@@ -385,7 +390,7 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
 					cpu_of(rq));
 
-		if (rq->cfs.h_nr_queued)
+		if (is_active)
 			dl_server_start(&rq->fair_server);
 
 		if (retval < 0)
-- 
2.51.2


