Return-Path: <linux-kselftest+bounces-48043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6922CCED2A2
	for <lists+linux-kselftest@lfdr.de>; Thu, 01 Jan 2026 17:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABB433009AA4
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jan 2026 16:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A5C2EDD58;
	Thu,  1 Jan 2026 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hxcE8HzA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011051.outbound.protection.outlook.com [40.93.194.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29082147E6;
	Thu,  1 Jan 2026 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767285274; cv=fail; b=Ljfnph0Ty1sSRwVUVwKhb7pGczLm6UwST/pShdNyzLz2Vk9UWIIVWy1bK9F7k+QsWTqaecf3fKh1ticNsLqYmujdWUMYx5rSIY+MsaCdtMwxT6K64f1OLPDOITfFledk5g8LJG8QZx69FGFZfnQHBgwOojp5fZtecP0+S/cnAiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767285274; c=relaxed/simple;
	bh=AyO3Vy+yHjiP5HULX5q2SnsVfZJeXocYveMXRpRz6jo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eEWSK0y4jvLBKGBNZMx7/ZZiJ15nwTpcG2XSj6PUYDu5bTIT8OgDJ4wBEtwgrJsyuAhQGF6UI//bGPBYi6IGpnN/qzUziurZFKp184zLF5/p0Q/Df6Dfz9PvbyDxAw3lpmYSPsemThV/9LwecSibDjLIXzrVwIlTbC4txvQxhbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hxcE8HzA; arc=fail smtp.client-ip=40.93.194.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pE2MhDDGv59ROlzLlPZ+6+sXgK1SXwZe4OPWwCBnpXy5jLYQLPHhgH+ZSeqaEhVOt8D+OGBSEpLmwWNvEMHocr3AmJ7U+tlGj4/AwoD0FYA8lLi/H6yQjUgs4rqGoiDNO/pwzYr3W5Mpi9klODd3wN3O1Q342f+3o9/OrMaxmxbTWQGdJZFzykpfmh44samarCnI+iFDebE5vDri0lVybQSflTN67KTph4LKfAkhF10jMWdx6Qzlw4/fU1IgmnA9FbkSWxlG6QNVYe7IWu5MFWXwNoWYcUp0ika5793tS7UzOnx+SXmCLCSETQgyZJMyc+BA1UhonHND85f+W0M6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1+h17et1v5VEuaoZ1OD7aU9PPHbmJPAgcNRkMBb0KA=;
 b=wp+zSXCxexCTHwXvZekQO62cTZ9Ux2SdU5Q9z348s2o+oYhU5GlSVACKB3ZX6XhUDwwUdepbI1t55QL3jS+ws6preYyBCR+tV1LTf7n+5mSEKuVSE7drjnQgSRT+kLXv6j3GY+kJWJY7t8wdxU+UPeD5Swa0Q37qCFDAsryCJK1GvDUdcCi9XwIlo8hXcsqrmRtGG44qi0aMHuLx5Jp/qblfL/1qhUx3wdK34USb1BH2OkSkIzdYVYKJcQaZSAW6YGdLZ6iM17wz5Gddonhaw1qdjFqpfJGZCcY2ZdPhn0LI5HcJ5sl5wDgWl9YBvE6kD5m3v7pwQfGaR3uKiTu6ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1+h17et1v5VEuaoZ1OD7aU9PPHbmJPAgcNRkMBb0KA=;
 b=hxcE8HzACmicx+pE0wSQmGvyTnGr1ie7DmCpRGIpMV6bzsA7rl2Uapo3859fw1VzFd+9S+74HBb8gu494K42+Zc8l7rkOOreNTmg+T97s6xeuORkmnz/+ieUO+FLIuo1XhgZelhk/Ks/fmepPeobFRFjG+zN9yH9Em/FMLP0c9ccWF7vER/BlbRZsxzZMI17O6FEl1HE1TDIm2/DDl5p8zDjxaPPYUwkxMSXxNNDpH1QCe42O0o7IMBdroLF8zsFnTwjJYLSHzHEHkPRtD/wqyjxp1V6QHpVXBrY5eUf/B7K/eM+xNUFnPkEW7Nyr0ChPHBvqY6Oqf/i+dBfjD1znQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 1 Jan
 2026 16:34:30 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Thu, 1 Jan 2026
 16:34:30 +0000
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
	Yao Kai <yaokai34@huawei.com>,
	Tengda Wu <wutengda2@huawei.com>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH -next 1/8] rcu: Fix rcu_read_unlock() deadloop due to softirq
Date: Thu,  1 Jan 2026 11:34:10 -0500
Message-Id: <20260101163417.1065705-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260101163417.1065705-1-joelagnelf@nvidia.com>
References: <20260101163417.1065705-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: IA4P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:559::13) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: c47ab652-b8dd-4761-dac5-08de4953a31b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9zt6eHsKcKE9fjjRHWNJUQi3txiRI7hC4kO1I9BraYJYWbhazXqmmUMMe5z+?=
 =?us-ascii?Q?hMvJsVEZLCdSjVEYIncC2M40erbMyRFyeYSUMwEBag9mHvqqyq+NxkHgXnfd?=
 =?us-ascii?Q?lIYYbSCG70NZdvmUNx1yfZSK3WjFKCKM9W2IyX9LYIQvjPbduE+Ooj4jIr3Y?=
 =?us-ascii?Q?Tatrpfz+SbqT1Q8uu7QaH+3f2rJvUY03WVDgndVPn2fq+z4wsVEUOylomfgL?=
 =?us-ascii?Q?42V8oFP4FnepV0wtS7B+0F3R1IyeBYmMIPbs4ygmhu+MCaTAxPTSgHUbmLVI?=
 =?us-ascii?Q?AfQb2y+/kSkfPlg0v4XKzy5pKFY2QowD3zJvELQ4zvpRlLyl2GVym0Zp7qbm?=
 =?us-ascii?Q?fVNIRZEQjOVVG6XarJMggRrwLkGhLEuWG43R7EB6Losy6rTOM7n8dkZSOdjT?=
 =?us-ascii?Q?AZc1rypXS9yqfvCc/70TJ9VrtPw1wXae1Y/UC+SLGOIXdzpgb7T+yjnCV9X5?=
 =?us-ascii?Q?vMjAuNNsTRANDiMPszB6hgJ8qiNTcDjtuDH/zkjfTRd4P+EcdEG0bR8y40+E?=
 =?us-ascii?Q?yrHFnOX5qV4ex4ISxwlWqt5Q/g7n190taq1cUCHrceaf7zxIKaZnTPpmnRa+?=
 =?us-ascii?Q?ARDotpneRUWLekqIfynZJnqQZ6UbEWGlCQMvppDnWfhkxhhwwU8QIGLjds+y?=
 =?us-ascii?Q?KBmElU7Z5SEHMrlHgVWJrbJgI6ot3qTiCdRr3w/nOpnkYgmRG7guy6H4ds0A?=
 =?us-ascii?Q?4Bn+ppobyN6kFl37PZmAh8PYQRovO0pzrCiiOLlBdOGiCHWLFkrUTDXS4SQ+?=
 =?us-ascii?Q?PMGYD98NVG9m+jc5n9+ko08YeTEHllAInWQmU8XfilcFH40N+rI8g2pJGkOB?=
 =?us-ascii?Q?MJi6jodcH7ScZ3OBPmGl8B62XBjmz7qbr4u4f/gwh6BlWMRNmZJ9N8v/vqqo?=
 =?us-ascii?Q?HGsF4CJKlz39P7w5goiEHmviufukJ62AOuVoop1jRpgTrftnLvIk4SloVVMW?=
 =?us-ascii?Q?nWSc67C/5Ae2TPQFen8bROeIrnKqwm+GxYKBcGGz9oYp9zRniVthSkKzOoqr?=
 =?us-ascii?Q?jitWTDCg2TNqkO9rk01lou35dLTfMuYYdjRclyhUAUNMDJ2xDk5zx9k0Fm6w?=
 =?us-ascii?Q?h2fyU0O8xQi3gjKJ5uOka7W4fUbfLt/r6BuDPOw1NuXWpzhNmvXc385cZ87g?=
 =?us-ascii?Q?AkiAAxZct6iy162B7KVCDl8yjXbsPN99UOeQN0rsbSnMnIyn8DTVRWByTPR0?=
 =?us-ascii?Q?0zMAt7LRim/wA9Cd2HE2y0j8oA7VREtENz80OnPYf+CYqWCkelGrNKhsFqNM?=
 =?us-ascii?Q?PP3+fXqHW32FzTrofarzfSjwvAhSFrEHifr3oCu2gpvIaftUSJM52Z6vZpiC?=
 =?us-ascii?Q?PT/CgbCwKrINW+L5a1aOA1HTZTI/u5c+za/4XEPosa4g2k8bL3ofH7a5ocmq?=
 =?us-ascii?Q?wCBfEhdGPg8l8BmZYpawVu7ZA+kmNppW9YcvpZGLDJp+GnZQkiIR1u/p8zPV?=
 =?us-ascii?Q?xvrYBEgyIB9enf1ttCVg63nOCZGODEtW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SgC1OU9GXR/Tw0cRpHiY4cLvOEGl/KAU6v7YbeA1eKjd0CqKjJkU+BfSOH08?=
 =?us-ascii?Q?9uCFEyrRcDfK3TZmlm4agiEu6cp5i+ECdYuB9umuCCaON7fbpbLO4/eCHdqJ?=
 =?us-ascii?Q?634itbFpPkSgOMx4Gd/L94Dy0oe4yd7JZ0VFR7Uw4vKWrfjsR5AEFuYQBJDV?=
 =?us-ascii?Q?aAOKZOEDRWHFHU3Of83jXk47fHcQEa2/brBW9obCbCzoo+jQ7bcnrwGI3r+d?=
 =?us-ascii?Q?OB9v0FLfh1Hto1oqE04p3rSd/MzxQ68g0Yy/Kute4SGKosAKcTdiLuaPG9JV?=
 =?us-ascii?Q?1pVYOmIZer2dPIOtzh7NDn59aZzU6WVPCVeR9paMcinQSm8e3PGj3AsMQrfu?=
 =?us-ascii?Q?bg0pieEDIibz/84gHcKvkBY8dCosq6q712zzdL41wy+kdyzPm0gK8Kr+06JQ?=
 =?us-ascii?Q?/01GO9sG50JsX0cGXXVfkQK/iOPnNoXffF3LwJa3wcexuNkP8/kaOLbxTD3w?=
 =?us-ascii?Q?NklvxC9LwAgcqRaVjr919uZxFaV5xTfGc7TQ5LzJb24giDXSF5n+l98t3kbE?=
 =?us-ascii?Q?7bmtxP9Vum8pb003AOu5ul0FIuP2Mp5HuoVxUUjuW1jmZYdeRnaNhOInsQcX?=
 =?us-ascii?Q?5nUvxk351QSONvhpqUdrVo1+KFR3rWB7UkfPY/jYubj5wiFldGQrr3t8Cl/F?=
 =?us-ascii?Q?LxBRzhMGG//v3kqI0o2yHtYFFXEfm4r12hFwo4b8t1T1Vm6W38CgsJzKji+H?=
 =?us-ascii?Q?yvg6H+YzBnwalrjFfSA1z8btH6xiVyWOo/aQq68pgL4k4dYUB7sGPkaLz3wI?=
 =?us-ascii?Q?Owc5LcYX27op14nE8SONTgjTWMjk9JrnGX/B1+EL0s9BgvQCe8Pey7xju6Zc?=
 =?us-ascii?Q?HHYMw/gQ0Ib0w4RduzK00klwR41tBXFOod1L6MHBkIf/n5P69hVuGJP18qPt?=
 =?us-ascii?Q?mtCcsZxnMbPu+X3OJkJuA6AG0uFvW34G9tQpD3ypRQHmTPQQjq+ewLytQuvd?=
 =?us-ascii?Q?ImgKaeyjXsjwJVltpZTiWLyHvo48/TMIk7ma9IRXO0Yd0m5yUa2pmPQl5P6N?=
 =?us-ascii?Q?8Pflku99hBviEg5vIW3Mdj6Ktl8M4vBeJp9J7+PPYa7g1DCLnb5JV6SutvfN?=
 =?us-ascii?Q?OEzlDTfh0IzOVEaUE7V2eWH7y7REa/jrVHFd8m3B+P3Gay0NFUb9ZbBz4RB3?=
 =?us-ascii?Q?w3IMwksWXczReB9qFqB2KHm+TMrF7vwQTlPEU8aePrAJjJEajnu34WiTr5V9?=
 =?us-ascii?Q?KbPHK6y6suycevvui679WTo6j4WI6FWJY/43UztgMR2uspXv/86V2ffHMwrh?=
 =?us-ascii?Q?eELiLTNUGkUar5OnU5dZtamoFANIu0sacVMIL1vGPkGC4ysxezyj51LOpCwp?=
 =?us-ascii?Q?h0p7TAsKfDohUEZM68zwZ5fuc+IcxBFiL4c32/G/yH2/0XruH1D4vxQMlKYH?=
 =?us-ascii?Q?Xg3sLpvzCeCG3g9VDj8Aa1bjhwXdGhMDizLDP67qLGjooTvOHDr+DcJxzqqD?=
 =?us-ascii?Q?4lSZjlf4kOwmoJzKoZJEpci6B4sIwWzfvI0hhzKTM9ckWNLjdNf/I2xzPYOn?=
 =?us-ascii?Q?RgiVoPxdNLdVgWXgALLq3J7fp9cIAsrMznj4xz4/imvuDXPGs6h12ZN7S0wg?=
 =?us-ascii?Q?61NWkcuu4LTJBGpmKhgPBQfJeWutayDQ686NMjEmt3uXZ85qU+XfU+zHiFot?=
 =?us-ascii?Q?hqSVvIHsdoRoP9x4P3nXVoTLYTP2UWpU3ggoY7fym9SnO504lxAaPJDw5yev?=
 =?us-ascii?Q?OM0kZUf4gco0jUaKBrQ1GlRPcV5kXcQcZaJO6nIX4mIEO84VUZlRlr80QIR6?=
 =?us-ascii?Q?gSiLdPz6Cg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c47ab652-b8dd-4761-dac5-08de4953a31b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2026 16:34:30.1419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifDXK/14oEz9POmqwXjrqtyXDNi2lvmATEuk3S2kodj0oafel6twZ1Lj2MAM+JrH3xAWebGPEn6qDc381aDD0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974

From: Yao Kai <yaokai34@huawei.com>

Commit 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in
__rcu_read_unlock()") removes the recursion-protection code from
__rcu_read_unlock(). Therefore, we could invoke the deadloop in
raise_softirq_irqoff() with ftrace enabled as follows:

WARNING: CPU: 0 PID: 0 at kernel/trace/trace.c:3021 __ftrace_trace_stack.constprop.0+0x172/0x180
Modules linked in: my_irq_work(O)
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G O 6.18.0-rc7-dirty #23 PREEMPT(full)
Tainted: [O]=OOT_MODULE
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:__ftrace_trace_stack.constprop.0+0x172/0x180
RSP: 0018:ffffc900000034a8 EFLAGS: 00010002
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000000000
RDX: 0000000000000003 RSI: ffffffff826d7b87 RDI: ffffffff826e9329
RBP: 0000000000090009 R08: 0000000000000005 R09: ffffffff82afbc4c
R10: 0000000000000008 R11: 0000000000011d7a R12: 0000000000000000
R13: ffff888003874100 R14: 0000000000000003 R15: ffff8880038c1054
FS:  0000000000000000(0000) GS:ffff8880fa8ea000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b31fa7f540 CR3: 00000000078f4005 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <IRQ>
 trace_buffer_unlock_commit_regs+0x6d/0x220
 trace_event_buffer_commit+0x5c/0x260
 trace_event_raw_event_softirq+0x47/0x80
 raise_softirq_irqoff+0x6e/0xa0
 rcu_read_unlock_special+0xb1/0x160
 unwind_next_frame+0x203/0x9b0
 __unwind_start+0x15d/0x1c0
 arch_stack_walk+0x62/0xf0
 stack_trace_save+0x48/0x70
 __ftrace_trace_stack.constprop.0+0x144/0x180
 trace_buffer_unlock_commit_regs+0x6d/0x220
 trace_event_buffer_commit+0x5c/0x260
 trace_event_raw_event_softirq+0x47/0x80
 raise_softirq_irqoff+0x6e/0xa0
 rcu_read_unlock_special+0xb1/0x160
 unwind_next_frame+0x203/0x9b0
 __unwind_start+0x15d/0x1c0
 arch_stack_walk+0x62/0xf0
 stack_trace_save+0x48/0x70
 __ftrace_trace_stack.constprop.0+0x144/0x180
 trace_buffer_unlock_commit_regs+0x6d/0x220
 trace_event_buffer_commit+0x5c/0x260
 trace_event_raw_event_softirq+0x47/0x80
 raise_softirq_irqoff+0x6e/0xa0
 rcu_read_unlock_special+0xb1/0x160
 unwind_next_frame+0x203/0x9b0
 __unwind_start+0x15d/0x1c0
 arch_stack_walk+0x62/0xf0
 stack_trace_save+0x48/0x70
 __ftrace_trace_stack.constprop.0+0x144/0x180
 trace_buffer_unlock_commit_regs+0x6d/0x220
 trace_event_buffer_commit+0x5c/0x260
 trace_event_raw_event_softirq+0x47/0x80
 raise_softirq_irqoff+0x6e/0xa0
 rcu_read_unlock_special+0xb1/0x160
 __is_insn_slot_addr+0x54/0x70
 kernel_text_address+0x48/0xc0
 __kernel_text_address+0xd/0x40
 unwind_get_return_address+0x1e/0x40
 arch_stack_walk+0x9c/0xf0
 stack_trace_save+0x48/0x70
 __ftrace_trace_stack.constprop.0+0x144/0x180
 trace_buffer_unlock_commit_regs+0x6d/0x220
 trace_event_buffer_commit+0x5c/0x260
 trace_event_raw_event_softirq+0x47/0x80
 __raise_softirq_irqoff+0x61/0x80
 __flush_smp_call_function_queue+0x115/0x420
 __sysvec_call_function_single+0x17/0xb0
 sysvec_call_function_single+0x8c/0xc0
 </IRQ>

Commit b41642c87716 ("rcu: Fix rcu_read_unlock() deadloop due to IRQ work")
fixed the infinite loop in rcu_read_unlock_special() for IRQ work by
setting a flag before calling irq_work_queue_on(). We fix this issue by
setting the same flag before calling raise_softirq_irqoff() and rename the
flag to defer_qs_pending for more common.

Fixes: 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in __rcu_read_unlock()")
Reported-by: Tengda Wu <wutengda2@huawei.com>
Signed-off-by: Yao Kai <yaokai34@huawei.com>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.h        |  2 +-
 kernel/rcu/tree_plugin.h | 15 +++++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index b8bbe7960cda..2265b9c2906e 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -203,7 +203,7 @@ struct rcu_data {
 					/*  during and after the last grace */
 					/* period it is aware of. */
 	struct irq_work defer_qs_iw;	/* Obtain later scheduler attention. */
-	int defer_qs_iw_pending;	/* Scheduler attention pending? */
+	int defer_qs_pending;		/* irqwork or softirq pending? */
 	struct work_struct strict_work;	/* Schedule readers for strict GPs. */
 
 	/* 2) batch handling */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index dbe2d02be824..95ad967adcf3 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -487,8 +487,8 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	union rcu_special special;
 
 	rdp = this_cpu_ptr(&rcu_data);
-	if (rdp->defer_qs_iw_pending == DEFER_QS_PENDING)
-		rdp->defer_qs_iw_pending = DEFER_QS_IDLE;
+	if (rdp->defer_qs_pending == DEFER_QS_PENDING)
+		rdp->defer_qs_pending = DEFER_QS_IDLE;
 
 	/*
 	 * If RCU core is waiting for this CPU to exit its critical section,
@@ -645,7 +645,7 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 	 * 5. Deferred QS reporting does not happen.
 	 */
 	if (rcu_preempt_depth() > 0)
-		WRITE_ONCE(rdp->defer_qs_iw_pending, DEFER_QS_IDLE);
+		WRITE_ONCE(rdp->defer_qs_pending, DEFER_QS_IDLE);
 }
 
 /*
@@ -747,7 +747,10 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			// Using softirq, safe to awaken, and either the
 			// wakeup is free or there is either an expedited
 			// GP in flight or a potential need to deboost.
-			raise_softirq_irqoff(RCU_SOFTIRQ);
+			if (rdp->defer_qs_pending != DEFER_QS_PENDING) {
+				rdp->defer_qs_pending = DEFER_QS_PENDING;
+				raise_softirq_irqoff(RCU_SOFTIRQ);
+			}
 		} else {
 			// Enabling BH or preempt does reschedule, so...
 			// Also if no expediting and no possible deboosting,
@@ -755,11 +758,11 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			// tick enabled.
 			set_need_resched_current();
 			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
-			    needs_exp && rdp->defer_qs_iw_pending != DEFER_QS_PENDING &&
+			    needs_exp && rdp->defer_qs_pending != DEFER_QS_PENDING &&
 			    cpu_online(rdp->cpu)) {
 				// Get scheduler to re-evaluate and call hooks.
 				// If !IRQ_WORK, FQS scan will eventually IPI.
-				rdp->defer_qs_iw_pending = DEFER_QS_PENDING;
+				rdp->defer_qs_pending = DEFER_QS_PENDING;
 				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
 			}
 		}
-- 
2.34.1


