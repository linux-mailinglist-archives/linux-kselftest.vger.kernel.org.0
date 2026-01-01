Return-Path: <linux-kselftest+bounces-48044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE9ECED2AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 01 Jan 2026 17:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5926E300EA14
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jan 2026 16:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B302EDD6B;
	Thu,  1 Jan 2026 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XJwCOOUc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011051.outbound.protection.outlook.com [40.93.194.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFF2240611;
	Thu,  1 Jan 2026 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767285275; cv=fail; b=fpmraI4lEqQDNX0GMndtzmR0Nw0WI7eJkCE7NWa6l5cjuQ7um+3T1mIJpUava1Aj1FqHHgKP911XmIZtIUWRca4ulefF6qhX+vVCg2/pW7qZQUmPf3tqtJ6aK+/rtc3cn8CXibqfUQesLHYCgalvIrV6QAJuRoTMX7gv7Oagf68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767285275; c=relaxed/simple;
	bh=lEiXzjqJtdjGrLEjrFKKE1ym8sWjGPlXDWv1fgJJiHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IiR4+fAbBWj36xl9qShrFrBAc5+jOtUxlDrdLSV13DLcUWHCHtYNe22QtVZk0goBzpxKOqqIM0l3460RfP3h92u/aRLObE/UqQ8fl+1nPn+bLIPr2iERr01tS4ZhLo66exGq6rc6jH1PAWkrUhnzF5MUdSYFgEUTM8V7VS20jMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XJwCOOUc; arc=fail smtp.client-ip=40.93.194.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePDaTE+oXs+ktvIstIOHk1ESUCYdO1+/SExVD2GNAVh1fDkm8WT1YMseED4G13M2HV6YLZJ4GF0WgqTka8J+QkEeKILRKEhxwiFA5Gw4rKMGULxw80z3Af1y0Vf43X8SsSejUwTSKLkcGeMNlQiXG1dmmzy6e/WsdqPpxoj1gfU7vUumJ0rHARv9yIY9h33/HItuCN1Ontm+Ru9v1d+9mjPrAiAVetu4QdrwqEiuT4s9tpO+ip+KFlEOuAuAKkd/YkHj8+jLUf221z/idsqJBs3jRPNOAC0zTzIiffOSZ9uTCRMUOvg4xvBsdgvNmYm+R3xr/a/6R3p05DCO7rGyGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJZmZHaAdWvMYk20Kdz7Fl7cCtyMqT6tIcPwuY3+YMg=;
 b=Po/XUYoQdpPRUQNPoqcDheP7gRGyZ+1Jn+VvRQl/QDkysPWWU18wORqyvpOcCV2bVYq/McKqts/rToDZr4OQW67jAbtNammKTXAuEPGKj7D4LhsWZjurY4bje0/d654Um6K5RRFZw7TuacR6ggD48UtnifedlmRXl6U9+Lqc1nn+rjF2ZgdtbXBGNE/bk3vAIA88/Qht0UUNgOf1eVUsUo7XsTluIoiI6mElpPuS+7t7grCm+4/nQAV9rocJCrDFma/FWWJBZ8UbliL7dxPkd2ZQWF8Fw57tgnWrQNmSWcuY5uR/OXhqui6Yi6BK59H9dc2IoYCUhIyAJ3khAF1fbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJZmZHaAdWvMYk20Kdz7Fl7cCtyMqT6tIcPwuY3+YMg=;
 b=XJwCOOUcq061a4KIkdb52gS3aKtLbItGrkqqCY3Z9DwNqoPsXF+9QKjHdc8HjcKyLpQ0uEZRO1sZ0gJydMYKgsNNrjXJhoYMgeO72Cc4invfzg4s301eis1ZXeHtYWcQCbLW01Aq0VXk5U+/erqptFkHGdKy2LJXHc6IA9hIduPiKGFEJeIoIRcIjO2VKYGVItC96t5B4vNnbxmquuMvBgvCOsRjttYVExIUq26AKUbbXfErLBy4P1PwGkQcuMufNn4l0ZPRjXL5oEBA3AIsWELCXRDShiRkbaCuLHIoun0C2Aixe0zGrJrhJYMxSQ8bUItlWT6x2iUXFfVdr+f9MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 1 Jan
 2026 16:34:32 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Thu, 1 Jan 2026
 16:34:32 +0000
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
Subject: [PATCH -next 2/8] srcu: Use suitable gfp_flags for the init_srcu_struct_nodes()
Date: Thu,  1 Jan 2026 11:34:11 -0500
Message-Id: <20260101163417.1065705-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260101163417.1065705-1-joelagnelf@nvidia.com>
References: <20260101163417.1065705-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0179.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::34) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: cb7e9f8d-2343-4b25-6321-08de4953a451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jnwFAC3+KSifle1xAjvBNwJgu8dS+UaCxTbLnZ3KAvNUbVjZlitGjzdK0871?=
 =?us-ascii?Q?1lHqoZ5n1TftKgIHNRlcVapirZ/NKmSFtXnqn1u/w7ZUPV8lA2UpmeAKh3Lv?=
 =?us-ascii?Q?ZTh6XAyN+N+LNXq8LsRBdjAm3QcyB038QecKD9nA22V851mPpqpZWAp1ApjD?=
 =?us-ascii?Q?cCQeV1HqkpptLhcuhinV5bo9pJNijeSs9LZ8sstg8pgLGAgvfu9N8StRavgw?=
 =?us-ascii?Q?W8VjlVc95idUILjYMCk2Gn+GC2++uTYrylpELueypJqfBFZp3ee3GZzbyZFV?=
 =?us-ascii?Q?vfmxoDm/OBHdPWJKZubL8HWDH0DXaP/p20iPLG3g0FEzWcEHNd4q0wUwIIkl?=
 =?us-ascii?Q?2z1u010MjcpX/xdAbbnF0TeaqYU7J/KL1qlO20E35Q1q+7KJb9g6Ke2u3BTq?=
 =?us-ascii?Q?geuGrcvewKFEVtMgkA7qWIT/5mfsodP+5rdsARGlro2Uqdje+YIkkzJiNM1o?=
 =?us-ascii?Q?CEL7stATatmikWSqULmcFyfIE3LABCUVv9GTfGnT1eiRjENK4KpLtxOUpPvo?=
 =?us-ascii?Q?aoM1e9OTyF28bIksy7761NTgHRrXyXvlbTZlAUUpEB5hriUHmaXeKNE7uZM0?=
 =?us-ascii?Q?SjAM9aHIqMWg86DE3OJLBFbWO6Qja7NmBhLk63VErCQyWiMf5ntMh4K+ovjs?=
 =?us-ascii?Q?JE8ZOwgfb0B+/sZwXw1ajjhz/WyDNmwTVgvaYsb1gcQ3+yZDPv5rZT/EIbtt?=
 =?us-ascii?Q?BXWP00eIs41JcawW6PeR0pmdA00NoXmUEVgADM587MVr24077aaAGLz9iQRE?=
 =?us-ascii?Q?gWfcqqB0Z2KJ0RrH0cR6kknXu40rEsz4BrR9wWmXOZDXMegvg9o/XtG9sord?=
 =?us-ascii?Q?dUoy3SNhg+GqGdWR1YwSlRmr+wUyj0ZWN8zlBiyBthI292mztdFJ6CTyngE/?=
 =?us-ascii?Q?fbP66OZBXV5X6Zw2P7Xhj/MowYEQ8mFxgHfs6JHSLpDlnxxLDMVXzx/xCX7f?=
 =?us-ascii?Q?lae1jkZm9ghpiSYA1J4MVf3rAw+rq2k1g6gQ7jBjXbk47pnC71FAJsRXg68w?=
 =?us-ascii?Q?jGdveUuHYOiNBnU6HCLB1WriJBY3S9ea7X6OLFbMhgsOTXGjWjA7lkjNIV4V?=
 =?us-ascii?Q?2kWyHoPKEhCzz3Jvo8M5eH49B6eZOJ/vtdLpdr9jpZnpsMfK0XEj3KK4ufKp?=
 =?us-ascii?Q?omx8hBHAFuH+mrkOexuJXxq19PkejeZTRDMsmzZveSI16XDvqIJ2R7qndWLJ?=
 =?us-ascii?Q?7Ivr1kV4DPwOq58phDOHbBP+EGfT3xZ6dVgBzi6ZyXoJWzd113DYkz32tHyu?=
 =?us-ascii?Q?SH09f2ETMf4GsMgfRJCAwgWisZNe3MvggWMMIYYQTm7TWkri9R2PVM/eK8Jr?=
 =?us-ascii?Q?TmITu0Q7pHsHv5r4qypCsNAlh9VjvanO3TU3q546BN1Eh6vlVQNPf81kSE43?=
 =?us-ascii?Q?Zs2lljDgp+wKXfHtX82Ime7QQFcgAjKW9KkRi+wRZoPRRmP/OZzCbQaqktaV?=
 =?us-ascii?Q?R1z+KkKUDETnBKXFuBmJRyrmd/+d2iBx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?POm4nu7Uvcp1Na584lZYWCDHmt4nDfUwKuKvSTobwBw/7M1fK/0zXDsJdmg+?=
 =?us-ascii?Q?Gxv839D9XiKG949wjyxWu8341zsJhSyqqiZXlkvM0P8vKwSYtM49DrLTRK3K?=
 =?us-ascii?Q?PqUZzZEmQMEGc2yAdjVZxMN+HLv8A9y4F3ostWCvT/nnFc3PdPFw7mCsE/qJ?=
 =?us-ascii?Q?jcJB2Jq4CWi9zdPyYKpUWxiy0i5OTTc+kXvPFN7ifmfIxO83LchChcxTTTZI?=
 =?us-ascii?Q?Cax2hdrcuAr5DpEssRcW8eNcbN9FeYuJ30bMG5CEV2RT8LIrdPPgUOCcq7Js?=
 =?us-ascii?Q?aFIQo9lmIXI/qlsuwnxTJf4XesDLNfm3wZA2tjJ3SIXPi7XQOgGnLhXFEo91?=
 =?us-ascii?Q?kJ8a+vUbYg/rBK0fW/akSxvPFb7yEIgU+QAOK73WCwtagrR0SM32JZoSxpAL?=
 =?us-ascii?Q?SbCJMvBEZ8K5+BgQQ2DUHmmE55PRcSZGF4HD1fBMcYS02EBALtcY7KEAKx0k?=
 =?us-ascii?Q?yhqgvaAIeGF7uxdtKJPphWOv7oxURH83qbwxKAicmSN0JpBypV9GXHgnnog9?=
 =?us-ascii?Q?t1fO6LFXHZDuul3y4nTvJAGut9mVi0B7o5uAijDAgCttuxdcfEeYovf8bTGs?=
 =?us-ascii?Q?T+hUN1stzhH+/xH116v10cf7841Nrx5/t0VQYdSgwxBWsbJxqKVg6FN2z0lG?=
 =?us-ascii?Q?2ofJ0GlWfwZ+QZwW7whb7Js37qIY9VQI2dxD7exEp15OClOhHqc86tmc2UCW?=
 =?us-ascii?Q?GP++CmP0RUFZRkdD5ZaG/vL3BwTRr2lLpOdAN5xLGl5GybVGGGkov4j/X8G+?=
 =?us-ascii?Q?+s2Volz8uLds0FARebmkYQlSiwscXS0yl2zpH2PzZj6zYJ94qOUHgfOrp2GZ?=
 =?us-ascii?Q?HICtXs5oH7UxpoMvKNvE/k1pBCprd11Aq+3+HU4shyYZWA1/XWY6PLzDlImm?=
 =?us-ascii?Q?d0plL7WFtGDuT4F9JkTqOl9PTNQPTmdjFa4qhetbor/bRrLRTvx1ytDEqhGf?=
 =?us-ascii?Q?614C1kklAC8g1lwqwSC18sPcFhb6rlsjaO+AUUrSyvTmh0X75UOXK7GPlqRH?=
 =?us-ascii?Q?jj0fOSCYGAEcbd9aAJTgrOYK+mSX7ltbLo7kO8+cw3v+XpYqRzXLjByTDDSs?=
 =?us-ascii?Q?IVvS7cm86gLu8AkP9j2Biebvm8PF3sRaFZxf6JmsJkWzDHoIdto5XPtah1ut?=
 =?us-ascii?Q?lDeA+IgLiTuGuUWC8OwRUHXH1+RdQ76/wtNOCPNvaYDTIKyb251b5vXh65iX?=
 =?us-ascii?Q?07BXdZSIzZ0C9HY3u2715Rk2XHY2wgzKWuvMBprGNz0treLjuWfNx0xGgDkf?=
 =?us-ascii?Q?w17dZe+4d8oht5txNjoefRp+d58iYIe0aIU4oFf0ZR6DWxERRTSCh/TcYNQj?=
 =?us-ascii?Q?wErpsOa4Rge+/ZQsrPvc25PHKFhyWOdu3qMMfkUBBTHe9baxF39/4k1YRhex?=
 =?us-ascii?Q?rIQkPHLdtyywJ5h52nmv1CYSbaSQCosxmfvP1p8ET919oZcA5YX0W35T4gk5?=
 =?us-ascii?Q?97q0L/qbzFvc+ADw/Q/Vfab7/EbAa063DPT1gAvdCxT8hWXvLciOkDP4vXc/?=
 =?us-ascii?Q?pHTMA/vSRvcbxDbMHun8bBKUVeZ1ljg/+PIGM+zcFUkrD0nQuUV4VMaAHRMG?=
 =?us-ascii?Q?wV21mjYZV0t3x6rW/oZU5ZrSfYfXIV+OFX/id0X/uFvErzhCrjM8D3qfLoyJ?=
 =?us-ascii?Q?/lUJbydx6Vm645dPg91gqTprZXxzKnI4gJ+guNqc0Q+R8KV+XX4H9EJayNKC?=
 =?us-ascii?Q?/0XvN/vRr62tCrMIol0Cl2+oQwaN3u3aMA6X3pSzHbPCwwqSFB2ppKn0zs7h?=
 =?us-ascii?Q?X4KKtRK+oA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7e9f8d-2343-4b25-6321-08de4953a451
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2026 16:34:32.2176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MEIK7hCbpgpl4XKhl5Nh6PPihViidwXNrSOOwspAK+IrS5gyk4Uz7r8SmjQIqneSGkdTz6tAHEWhgyz0vUVeKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974

From: Zqiang <qiang.zhang@linux.dev>

For use the init_srcu_struct*() to initialized srcu structure,
the srcu structure's->srcu_sup and sda use GFP_KERNEL flags to
allocate memory. similarly, if set SRCU_SIZING_INIT, the
srcu_sup's->node can still use GFP_KERNEL flags to allocate
memory, not need to use GFP_ATOMIC flags all the time.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index ea3f128de06f..c469c708fdd6 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -262,7 +262,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	ssp->srcu_sup->srcu_gp_seq_needed_exp = SRCU_GP_SEQ_INITIAL_VAL;
 	ssp->srcu_sup->srcu_last_gp_end = ktime_get_mono_fast_ns();
 	if (READ_ONCE(ssp->srcu_sup->srcu_size_state) == SRCU_SIZE_SMALL && SRCU_SIZING_IS_INIT()) {
-		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC))
+		if (!init_srcu_struct_nodes(ssp, is_static ? GFP_ATOMIC : GFP_KERNEL))
 			goto err_free_sda;
 		WRITE_ONCE(ssp->srcu_sup->srcu_size_state, SRCU_SIZE_BIG);
 	}
-- 
2.34.1


