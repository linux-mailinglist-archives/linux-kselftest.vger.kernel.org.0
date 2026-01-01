Return-Path: <linux-kselftest+bounces-48047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FACCCED2C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 01 Jan 2026 17:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56048302488A
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jan 2026 16:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7C62EC569;
	Thu,  1 Jan 2026 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SNangqSO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011026.outbound.protection.outlook.com [40.93.194.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A9EA930;
	Thu,  1 Jan 2026 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767285284; cv=fail; b=rz4VgYQf0NwjZKpxSRrecfa+kDNNNHY5E3CPN72vfDIgi2KAfDzsixqwuACqurV1qlF4SM6rh+9RxZjMKrjb7TmvpryDm7KDRgSPxR55+Bo6y3n6GobW5OuViCJrVrhEQlTjRJn40fjLrUbcXjh2PNcJCT/0bPuiTFZImblVzZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767285284; c=relaxed/simple;
	bh=p8KVKgo8s4PArie4m4TQlGRVINi1bNqNqFXJK21zs2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zqv2eI6vo2aBL9IHY40/yDBE/9DaFi7nEXhFYkWg8ALby9QR5HNC6YOdtzmLUgFyWdikZPLOt/zYkveOPPNHVA9kewn8Ven3UdW9+fceXlqDMxR/xAGCuHAox4vLKMJ6atb/6O0WBeE21c5SGL3QDcQUtd4jRTEHdqeB3XMAJ7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SNangqSO; arc=fail smtp.client-ip=40.93.194.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhsfdFJ0XkVhvkFY4FsRC4fFpyuLe+FbrE/ky5QRxmF/PKsEljyMzLp7adAVgVbMZXR1S9HlEKAflVi3pDf9vLhSKpnRANWvHyLWTugJabcfnEgdIvRDmd+MkSnZSORLy/NJNxekNUQd1V5YewAnEiM2gMdbDj2z/SxkS0Sc8Ef61NmHB+A1dZYrGzt84txUFE0e2vdtCbjrXULbd2OItsXaOdjBNgyfDPz+CVVncySVCeHU9KF9jPiV9ZroWVraPYFfhpniqY6oIv1tyOMcl9DEieBWo/JBhlIosjv4Mtrrmxe/RyUOEFuxzEeS5ybBkph1mp2L42zrW9Ux8nbVtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEa64l8vP7wMhTDFq3tXSJTh+Xg2v4Agv8G5JTTR/lw=;
 b=uG68qVWUHZzVdxaPiCENs837tOhjnUQJtnLd2qz25NVbgFiMetj+je8QCRtIP6IO6Pcq9Ro2/DKiTXs5snCPT9qfFZ64hGU6IowUJdqsILcPberv0amXS8ciAwbzOD9gWdt14TYGkUDyj7K2WkyXyR+cJpk6PjWWCmPnOtmtmJb3KiUbKM6nVqy1GT7Dz+m80GRUFeilAT+OcApHdflrPrT3MzZjsciw9G3kpcblTVjIBCFfUhSQk7vYYwElwl4TGrXX47ptl4nkUl6yYC3jI5Y9Eq3/x3ZuPDyM+XSM0PAPTEDkOF39+5uOAgV9LfQLwVhRd7ixMEfkZum6aq4ymA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEa64l8vP7wMhTDFq3tXSJTh+Xg2v4Agv8G5JTTR/lw=;
 b=SNangqSOx7skRyrYzYqfYw1Gk7SO21NAdsa44pKxpEINzK9Fj4MktWSiceW/422t8izNIzr9r0uo3cNTFSLu8yT6Wbe/FwSmASpQvmAn8NoMRlzI+z5MrvRIy4/ig04WkpssvQVyoVhNH5Ui2fRZRyGGCnqPOt81HlvIilce934Xo2Iu4+1+HrpTsDRMsOw3DLg7ITt7vIe3s/Ey6fMwScBB0aaMUrfbObvr1cUSH3Y7KkSE8wk0DOP0qcrDOs9C0HJZgbdoFB5g21RBxbDpbIKVGcAG3l+JFg27Uw7qnceeW6rKTxbTOFbbCtwKqtZ/t1rxo9Qud7JHqh0ObT4nQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 1 Jan
 2026 16:34:34 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Thu, 1 Jan 2026
 16:34:34 +0000
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
Subject: [PATCH -next 3/8] rcu/nocb: Remove unnecessary WakeOvfIsDeferred wake path
Date: Thu,  1 Jan 2026 11:34:12 -0500
Message-Id: <20260101163417.1065705-4-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260101163417.1065705-1-joelagnelf@nvidia.com>
References: <20260101163417.1065705-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0157.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::12) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: de950f6b-3b24-4c9d-4aa6-08de4953a579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HeZQrZbU0sB+XpMIhYYSF56zQq5SM5k/0QEC19MDvsBWCCdwIJG2riBKJuMo?=
 =?us-ascii?Q?9JG5/OXyAjKBA0Xo1UEfiYJQUfiCQ1zY+iYF6bBr7q6lNT42TRdshYC8yxjk?=
 =?us-ascii?Q?79n4/pK7U2PlErMtEXb6TbK5M5vEA7DF7Af5ITcKkPr7HoRaWB7fj95Tl6AJ?=
 =?us-ascii?Q?gK+VBU3LIHM21UdHfMDSWkvf4KG0kLjrKqi+yjlCseYwtFBMUdDx938b/XNP?=
 =?us-ascii?Q?RC+KvGdt6J1UUCylAnOvESnj1j1oRlt1MqtI2T9rx4Iei7o8X8qx7YcgyYIz?=
 =?us-ascii?Q?lDmds3BEwHhESPSeQ9zNqNCFOY8jPEa+hAIhWrBCNVCX0xGTP89lvRVTZDRr?=
 =?us-ascii?Q?vErxtviBj0pMSYv63gkWquMMIEP6W77wMTF+k4CMGGpNkAqBqdttn3Ak+bch?=
 =?us-ascii?Q?Agj5XMKo0u+4ugpotDqGeUMwx7kqm45GlC8Ar3zndXnu7m2QYqOWlnBpLhyD?=
 =?us-ascii?Q?toJuzLKkUbarWH4XrtRtdi5O41Ag5AQ9kD2sXoN6EWJXgFfrpK6+K0uC0bxZ?=
 =?us-ascii?Q?i3pK5r+k/jFhqoNCYAA0SgBP2nJWMh8IFfi+fxS15Os66D4/YlCs4x2Uow9g?=
 =?us-ascii?Q?tmrxHCJN4QNjjBpROkbltSdZMyJSziS2y2TLShzDZ2PdJ/PdGPHjQR5vnDco?=
 =?us-ascii?Q?0cIMHxEM54PrJ0fYHXQvBTxink64GVvKD0Kos1SZZiXSUzsAF36mCzhbEfnU?=
 =?us-ascii?Q?LiB6rjTmWAj2/bE8ptkYdOwa4ETgz7b+JGwWna0E0A0hiNHCCiBe46Iew8l7?=
 =?us-ascii?Q?yeA2EyHICKtubTbKy/XRLjQ3JMrI4/HzoujPLuAIB39O6MVeOEHZx1oHuE92?=
 =?us-ascii?Q?SFSYMja9SC3VNa23YyXu+PcR6sxbC/U/ilu2uwfsX/nc39YneJ3aMmnUX1J5?=
 =?us-ascii?Q?bTDeD3Wo0kT0bDCH3RgHftgWnX/Zi+1HFtQXOtGgrU3L4aDYmT/s+UnpLlYT?=
 =?us-ascii?Q?DxulDxQEQVU4u3k0wh2DmKgm6g0Cdq1fZbOXM4JDZ9vGuy138BJARrchKzpr?=
 =?us-ascii?Q?qiHlt7euUl52H1GWv0tGHp/T2LvlJRrL268N7BoRQO7dWW2S73Bx8gzvhhaf?=
 =?us-ascii?Q?rIJbg8X8vxEPVnSldd6MS+ltBglgZ7vRVZzwarrykTEG0mhjpKVVyHBrTBIL?=
 =?us-ascii?Q?4/wgTNM+oBCXD1349hUt4bfZ9ZSTyr9HcOyJWvPluaEntxAk8iz8FgdGSr8Q?=
 =?us-ascii?Q?Y3JLSPEnOpy2mRA+McssAP6CqO9WPCpZhKhjRtKOm9sRSe774hUC3mugXVLh?=
 =?us-ascii?Q?gQXZ+/b08mGVISjs1gcqynbcei6CUcnAhTZOmmhVtXNsTVXlfBLvlbXN4NVF?=
 =?us-ascii?Q?eOv+/P5311Rb9go7t8mMs49rHr/udjfXwyw1dx5Q2+ZK5OLsW1GoPl2MFi5c?=
 =?us-ascii?Q?22pDjfhZx2jJM2lW5EF+f1RQ55QHSN6a4DuGBoraiH6+zzFDsLcPWVDBjYxk?=
 =?us-ascii?Q?TTGk2L3DoKLD+r/fZQqH4frjV9mvJpdn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W5rurDIya/uMFS0PwJWPYf+DramJOLQ7qDkCByfjCImhJZJyfP6r/ukLjubS?=
 =?us-ascii?Q?roUDvCzpzcGIUJQdyjOB8OIsPU9AqTfpPfApbXdoZPdQgeK1zqrzpWvCLEor?=
 =?us-ascii?Q?XLws1qZiXu9HRWLZGqnA+daXbKQwS4AABT6mGSLbvn0owbeTbbABhg0jtmZH?=
 =?us-ascii?Q?WX+vA6C1VwOoJiQkcneF79VbHcTeoIaeU/Ncj/QCIjRjkX9TCYSG5rxt0z2m?=
 =?us-ascii?Q?SSx+WnAnKvw4EO2f0JzRrlmmfOty+sevYSv4zrS60keHSIcZS1pK4FQKXgnk?=
 =?us-ascii?Q?Ass0FO2dDzNw7PInamCo3z4U8jZB8Dg9NbV/o/5UgMkFuFJAUaltVI2yH09u?=
 =?us-ascii?Q?7lLnwXWR/Ga5gxkz17cGBSl3qwW5IQe5UBsIOpZkKpv+9YG3WAgZTyIysFB5?=
 =?us-ascii?Q?ImZxFeEAA4YSg5lVdsbxn6F89nI/BXQj/C0rqR65iQp1r6tciSvQW9q0+1s2?=
 =?us-ascii?Q?iLJDWD02KA2mynn6oJolg31jXGDE2N9URoanGYughLyfZCdphe5ZV+1TPxBS?=
 =?us-ascii?Q?k819iaPVVQBXOHHu7Ggh/vh6B1m3LKKL3vGKHp324QBdS+F3Fs52vhoq/k3a?=
 =?us-ascii?Q?x8QTxP/FqAE8wB/LTImAkJJpWWP5JJQpz1sWF6ohHEHBGwzoetzJq3dXUgHw?=
 =?us-ascii?Q?du6qWKgJWFfiOLXMD42DsgFLqL69/YPwdzfUTtPKPyOFAnfDrbiEodyEkYIF?=
 =?us-ascii?Q?G8oPxHCMQTWs4D1tGl10KL/o79pk8dM4HEHtdXPJqcRtm/vh5Udi0UGOzKlj?=
 =?us-ascii?Q?8VEbp9MWoy7Gdnp1EnOkfu08uGENr2QzmhAA92flUmgkJfB+ZzOyP7hwrh+t?=
 =?us-ascii?Q?f7ez4/mp4B+F0zR2H5MHtxa8IsyBtdvB+Nc+xvCRmC3kJadkMIzyFkxJYB+K?=
 =?us-ascii?Q?0xk5SczdCWBpNgKjqGzvsExYSwWkaOte+7CNAXFB1tneBRM/n0qPv3ctkJ1a?=
 =?us-ascii?Q?6i/tNQaVYcCZnjcQ2IBrJ0RXnoL0xf0ncfDTDDORdXuh7qOZ89nW/d6JU2kT?=
 =?us-ascii?Q?1/KtMQcbMMz5rILzalMvuPo0vPDErj3jZ4/uwyHZuQQaaIi4ijcqtpxb8gSD?=
 =?us-ascii?Q?ZQ3VEjfU4LuLSp7fHDz9RWHbQP3fXCsbE7No6Sz2Gy9WRyWuGH7qwsY+Z1T6?=
 =?us-ascii?Q?7tqrvW61PJWvsH7reOrAlhAp/eJixmnI/MeNzGHQIXd5lzte3JEvOIRr7EKk?=
 =?us-ascii?Q?Z5eUkbsreLdUcCstJGXO/4WziZ1FCz0iVMYa9x/qbxO0dPQWOCtM2JX3lqn2?=
 =?us-ascii?Q?J/NmsE5lZ5nyBbcv1hVIZfqJLK61jkXQMvnHqIZqhkG8FHOpWCQjsCT9xAzb?=
 =?us-ascii?Q?35bP0+qUygQYrM/i3keOFNAkVM23wjfzD01HcVbVL8wLDgO0/nB/jPr91+cW?=
 =?us-ascii?Q?IHPozXotOH+mu9L3Y1wT9PySWimNVaYddR5l3Az+wAtFQDHjcgmdkhjXPr8H?=
 =?us-ascii?Q?dquin4maSJ52PQLnUjmjUgp+Gd5avm5aS937cpoz/rZR9bb5W7FwVZVNpImS?=
 =?us-ascii?Q?JAN4AQfKZvec6yP0D4mtwFGJNea/d+USSVLycXut1RsS2k//KQVQblmu4SCJ?=
 =?us-ascii?Q?45JvZARbTcF+oF5C1FgwW5xCqBNqioqB2Nnq2EzqtPxZVAgdhGE1fYfBAXaz?=
 =?us-ascii?Q?clMFMV5rI39EuOfhvqqrKl7NMnUHyt62GY4QX7o3r5fYIjyk0UFR5I2R94vr?=
 =?us-ascii?Q?KzYCuw5IiACXlU8VLaZOAkM6ZGw0eg8Fn0OFJxWepkiLGfnSWSd3CyASUdxE?=
 =?us-ascii?Q?fO8JLuvaiQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de950f6b-3b24-4c9d-4aa6-08de4953a579
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2026 16:34:34.1609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lyc/SI1kejonyCKSQ3f4Ee+rvLqQyE393qOXL0r6PyK8IHg0MkK+lTtCsekYZIl8EFGuULzr4CKKzkldcDoiJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974

The WakeOvfIsDeferred code path in __call_rcu_nocb_wake() attempts to
wake rcuog when the callback count exceeds qhimark and callbacks aren't
done with their GP (newly queued or awaiting GP). However, a lot of
testing proves this wake is always redundant or useless.

In the flooding case, rcuog is always waiting for a GP to finish. So
waking up the rcuog thread is pointless. The timer wakeup adds overhead,
rcuog simply wakes up and goes back to sleep achieving nothing.

This path also adds a full memory barrier, and additional timer expiry
modifications unnecessarily.

The root cause is that WakeOvfIsDeferred fires when
!rcu_segcblist_ready_cbs() (GP not complete), but waking rcuog cannot
accelerate GP completion.

This commit therefore removes this path.

Tested with rcutorture scenarios: TREE01, TREE05, TREE08 (all NOCB
configurations) - all pass. Also stress tested using a kernel module
that floods call_rcu() to trigger the overload conditions and made the
observations confirming the findings.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.h      |  1 -
 kernel/rcu/tree_nocb.h | 35 +++++++++--------------------------
 2 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 2265b9c2906e..653fb4ba5852 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -301,7 +301,6 @@ struct rcu_data {
 #define RCU_NOCB_WAKE_BYPASS	1
 #define RCU_NOCB_WAKE_LAZY	2
 #define RCU_NOCB_WAKE		3
-#define RCU_NOCB_WAKE_FORCE	4
 
 #define RCU_JIFFIES_TILL_FORCE_QS (1 + (HZ > 250) + (HZ > 500))
 					/* For jiffies_till_first_fqs and */
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index e6cd56603cad..daff2756cd90 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -518,10 +518,8 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 }
 
 /*
- * Awaken the no-CBs grace-period kthread if needed, either due to it
- * legitimately being asleep or due to overload conditions.
- *
- * If warranted, also wake up the kthread servicing this CPUs queues.
+ * Awaken the no-CBs grace-period kthread if needed due to it legitimately
+ * being asleep.
  */
 static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 				 unsigned long flags)
@@ -533,7 +531,6 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	long lazy_len;
 	long len;
 	struct task_struct *t;
-	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 
 	// If we are being polled or there is no kthread, just leave.
 	t = READ_ONCE(rdp->nocb_gp_kthread);
@@ -549,22 +546,22 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	lazy_len = READ_ONCE(rdp->lazy_len);
 	if (was_alldone) {
 		rdp->qlen_last_fqs_check = len;
+		rcu_nocb_unlock(rdp);
 		// Only lazy CBs in bypass list
 		if (lazy_len && bypass_len == lazy_len) {
-			rcu_nocb_unlock(rdp);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_LAZY,
 					   TPS("WakeLazy"));
 		} else if (!irqs_disabled_flags(flags)) {
 			/* ... if queue was empty ... */
-			rcu_nocb_unlock(rdp);
 			wake_nocb_gp(rdp, false);
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("WakeEmpty"));
 		} else {
-			rcu_nocb_unlock(rdp);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE,
 					   TPS("WakeEmptyIsDeferred"));
 		}
+
+		return;
 	} else if (len > rdp->qlen_last_fqs_check + qhimark) {
 		/* ... or if many callbacks queued. */
 		rdp->qlen_last_fqs_check = len;
@@ -575,21 +572,10 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 			rcu_advance_cbs_nowake(rdp->mynode, rdp);
 			rdp->nocb_gp_adv_time = j;
 		}
-		smp_mb(); /* Enqueue before timer_pending(). */
-		if ((rdp->nocb_cb_sleep ||
-		     !rcu_segcblist_ready_cbs(&rdp->cblist)) &&
-		    !timer_pending(&rdp_gp->nocb_timer)) {
-			rcu_nocb_unlock(rdp);
-			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_FORCE,
-					   TPS("WakeOvfIsDeferred"));
-		} else {
-			rcu_nocb_unlock(rdp);
-			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
-		}
-	} else {
-		rcu_nocb_unlock(rdp);
-		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
 	}
+
+	rcu_nocb_unlock(rdp);
+	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
 }
 
 static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
@@ -966,7 +952,6 @@ static bool do_nocb_deferred_wakeup_common(struct rcu_data *rdp_gp,
 					   unsigned long flags)
 	__releases(rdp_gp->nocb_gp_lock)
 {
-	int ndw;
 	int ret;
 
 	if (!rcu_nocb_need_deferred_wakeup(rdp_gp, level)) {
@@ -974,8 +959,7 @@ static bool do_nocb_deferred_wakeup_common(struct rcu_data *rdp_gp,
 		return false;
 	}
 
-	ndw = rdp_gp->nocb_defer_wakeup;
-	ret = __wake_nocb_gp(rdp_gp, rdp, ndw == RCU_NOCB_WAKE_FORCE, flags);
+	ret = __wake_nocb_gp(rdp_gp, rdp, false, flags);
 	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("DeferredWake"));
 
 	return ret;
@@ -991,7 +975,6 @@ static void do_nocb_deferred_wakeup_timer(struct timer_list *t)
 	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Timer"));
 
 	raw_spin_lock_irqsave(&rdp->nocb_gp_lock, flags);
-	smp_mb__after_spinlock(); /* Timer expire before wakeup. */
 	do_nocb_deferred_wakeup_common(rdp, rdp, RCU_NOCB_WAKE_BYPASS, flags);
 }
 
-- 
2.34.1


