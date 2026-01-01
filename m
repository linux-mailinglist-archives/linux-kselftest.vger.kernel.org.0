Return-Path: <linux-kselftest+bounces-48045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F9BCED2A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 01 Jan 2026 17:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 644A030028BA
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jan 2026 16:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60902EDD70;
	Thu,  1 Jan 2026 16:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TgXuPX+E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011026.outbound.protection.outlook.com [40.93.194.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC20222756A;
	Thu,  1 Jan 2026 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767285280; cv=fail; b=BAzL/yjLGR/oHDuyxlKFJ5HtNUn01pMZbmNifT24/R4enI7ezN3llc3CRXnDvUBJ57ak6aiWX1JyQdrDO/+yIzl2yWlh/8vHRMW1rF2TkmvFw9aexBVygE6cGdEIKFeyPHmKhFIQuf/zoPPINz4UBhmha2BeBJkPtoNIDWKTKLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767285280; c=relaxed/simple;
	bh=90WiF5dM5M8Bno21M8A0111k/0yhFtigc0Gixt1ly2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sQ1D20sf7aknSHh9uPBPvGh7YhRG+5ZIe2Cix+tNaZTNVi/OBT8VjCHxj2UoRcqY/YSC+uOiTnDMdo1Wlx4PTnpL7TwPamB0dvq6eAdCUfBasVXb4ZbCtDFvKqTgqf2rSPZ0iDuTbfreb9IgYGf9SNNfycLE3LTqdVBhXmk6i2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TgXuPX+E; arc=fail smtp.client-ip=40.93.194.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRXi7+ZxltxXAUME58kVOOp0RENfhPMfKKXESCh5Q0UyodISPgVYb+vNY/3xZUpjp1z6SPLEBBgOl8AfwJloi4KVonZ8RrYXfpLCsGuX4I17J9+6XFe4/CzzgXKg7EQCsB+51MLSrh0k/JRBpRikX2Fd1sPBYVQG6t4f+3LHQ9sUETRoNkzUSWu3lv25pkSSA+d8EunlqPXTnktS3s22ANgLj11Ul6jheklUb4ksZuexnIiSfmU3AGTx+gRFaxXxZc/a1h7lnamqG9DXB69dGwAQq5H8cqfFJ4Bk2kAkGi50ROAWY2gakB2tJJOu4nEGRBV/IxhVORobaObX+N3SmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMWVcUXVqS/HkO838tchoY3CuPiBkWabieK5F8nOMHs=;
 b=YwQ33ZiXcj/Ku//NywY/DDDb87IyRsAFGANEwwATe5j+oOsLijFKYYWpsAoH9AU+IIESHeNJiyFCwwytv6YKI//UBoUu3pWBMgm8bCgMef5jl1nI+wf8ityR2/CEXInBf2faN4A/vAU6a+df6hW/bNX003eAPYZ9JXVneECTiETiyBzaFUSLHH3lplZuAG+DB9Hzvp3vAsn+ySmwo3yDyw++sbBoTewngavFU7yBdhNzTIPl/NV8nKW5jPiYTKtcEZPDxemYIn1AmyxC5VTFHBsVZrfPCFJPvZfvEwMfKyVopw5TnGCwyUOWirpKJUNV6pUeJob5jwxcYZnOw2kHwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMWVcUXVqS/HkO838tchoY3CuPiBkWabieK5F8nOMHs=;
 b=TgXuPX+Ebhu2PFZ0G+dts3E0ykg2Qh5XGerTz1H+Yc1eaKk0jYgDnb9aTpw4LyXexXho+5we8S56GtkYzG5akB58y6ItD8VjwAdosabdVl6hfDn2ZQyFBte1TDr2i4+JLdXQrZPbB6o3AmEFiKJzCkvet+NPUNfHggHzMBIqyi7rIvLBi1Y8701FqO0+c6PRiSYtMq6F9cGZba/PcnI8lyLJHB1IyqOBabFcTPOvDmn0S3nEmoz1ZdFjFtztYdU3rkfIjY76UjoETjgOE7JnKb85otv+lc8e9q5jseJv03VcHnO0IJdjRIClONiy0epxRLZeroVL6H1rkdRW01rbdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 1 Jan
 2026 16:34:36 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Thu, 1 Jan 2026
 16:34:36 +0000
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
Subject: [PATCH -next 4/8] rcu/nocb: Add warning if no rcuog wake up attempt happened during overload
Date: Thu,  1 Jan 2026 11:34:13 -0500
Message-Id: <20260101163417.1065705-5-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260101163417.1065705-1-joelagnelf@nvidia.com>
References: <20260101163417.1065705-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0253.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::18) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: daa98f79-c645-4806-aab8-08de4953a699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SuLxm92k2f/w2tAOQfVwLU/6DcM8UW7fomJpSBGKJy00+rSj2Ay8jNlrkHi8?=
 =?us-ascii?Q?t9dmbeMcsuLmIq0aZ21KzfiCmgi1c6EIzTxQKL/A0x1zD1dfarwxtvq7fIfT?=
 =?us-ascii?Q?bMFoYwo1lofQ8U0iMtks9NpV+1LUNrgbSusUMhYgezgryV5M+tByWoWK0pEx?=
 =?us-ascii?Q?DCs3xhmbaJU2vwWhfAL5MkIPpoO0GJjLnd4I7gNG6o9FxH9VlyIf8+TmVwNs?=
 =?us-ascii?Q?GKK5PfzuBTib6J/JlC7YoOxHHZH6K61ypemhA8Dm6ji3JjZYELgvuvDF1PUa?=
 =?us-ascii?Q?XLUvVJHL97BHrOlhbDTT6hVLuMeMBuQTZPN8qdzPqQn+dbM7MGvrolSplCcj?=
 =?us-ascii?Q?yrwZbCln/oDjtUbR0zSRNZdufjLNHsyaRmV4nDmWX7bKf7oLrG3cygbdSN/t?=
 =?us-ascii?Q?tBp+iAN1WolrMTPx2QnUA2A81WargnOotJoxoXIYTJpiEP2dArNpNk+NIlSv?=
 =?us-ascii?Q?s2eoAMAab1D3gRaT3qDaUdfvLecI3hwx6k55mDZL6lybW1qj2wwPUAjBYnuT?=
 =?us-ascii?Q?UHl/etZHUmSEdrur26/pz1Q57M+vF9aSfBlwvUKKHfcEF5HZza5BrIpD2u/b?=
 =?us-ascii?Q?Pz3OyouWtMeRZ+zV9EtO/Efe1j8tY6a2pcWgR88DZKLwlntx6piVz+x0JUh6?=
 =?us-ascii?Q?4MeKTAhjZEaiD86mzMIpNFw3qe5dnBtlt2V0aAMoxUM6zVgo4koiUk9x49es?=
 =?us-ascii?Q?Mz48i1waBAzRxQNz/gnIlMee9ZVtuySZe03T0Hy2hqhZfHing+Ei0fJOC1n+?=
 =?us-ascii?Q?9rqk/Zj6qINBmepGDt4baYupxe71FSSySsgonR1eMItpfB7W61S8WKarsZRK?=
 =?us-ascii?Q?IxpSJnhrOZZriLKnx6YPryObQ7Cycz7El//KXbuMPSdvSVNvR1COWvWkx/6U?=
 =?us-ascii?Q?zVkMor/Ho648zjxtM5yBro0bomtS98bQA1b/RexxHUSzTz4ZNUqUEbH4atWM?=
 =?us-ascii?Q?rA/BpFIZ8wvDtFVGP53d/z8nXlQzeZ3HSsHJOnkCPAeKr+cp1Cf79ufzreQM?=
 =?us-ascii?Q?HEOW90k2XWECQeBpw3aA6sNRYzIU5x94ZwwClTV6mLAoVhhDmxKoHXhYL40b?=
 =?us-ascii?Q?sliEpp0JnK3ypEZt85aouSHPHD5DKVzSbNQ5zxJmRym3jB6TXrUCRSF/uy7p?=
 =?us-ascii?Q?DOjkzI5EwEGzYJDYnFv/3BYS9oSp0Dz/IRUb4zeozmeBeNuoj4npSwKfZ0ib?=
 =?us-ascii?Q?2yj/sAcgkTD3sKvuxvd5N6eTgf+62MQpMkUC9IaHASV2Vwz/YOBabLMepvRP?=
 =?us-ascii?Q?EGjiLq0iHQOhBMl4iG2QCkSGKQ7gRRYko2vzNtkzsc/fuW9o3O8y+Zv3RqWM?=
 =?us-ascii?Q?Xi2WpU2wlbSTFbTVCC3UEV6gC1KMDpy9NkjoZjwitcdo56BVXAh2iNAMp2LR?=
 =?us-ascii?Q?a7QG5ZylLVV2MRSB2x3smpzh+jZKmda/zMaoHG/BO6PzvvfLscJn4NEamIg8?=
 =?us-ascii?Q?0uDQszIeNVgTjvsIk3c3TMF/4VCiP6K2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NHfuOogDbesaIhKL3NlRF3IkWhiLHLHp5BTq9BXhZdMaBYC5HWKfb6Jyw5li?=
 =?us-ascii?Q?Q1o7EvWKvvmC3lb36LziEyhXJgZ5yMcad7WIfcDPeCeNvkCtqGYc5LpTmCUK?=
 =?us-ascii?Q?2yaLv6O1c85StQA0IAtPyd2DetS/6Kq/PPffzmdoVpbu25xgVzmQNLg/94wg?=
 =?us-ascii?Q?PP105bdumxXtRy3uHfidL2wGf6q+NtoMMt/WDq0jpYng/rvgdDiiMCWWVXzP?=
 =?us-ascii?Q?r5O/fUX3ZQkmF6/P4MmbMeDaGdkA2GG0S8vyNmpfWlcbQmGuERsf6zZz6GOf?=
 =?us-ascii?Q?3DBQsa56Hbq3AEBXS+L+j6A2xM/CcI6MAZildFm/isKRrm3Kt5FChBvTJP+n?=
 =?us-ascii?Q?eWv49zQ5qrmlM/1l+pbx9u5nSIdmxV6913jvS5bRwtM++oTiYid78jVOw+PV?=
 =?us-ascii?Q?vOUEu2eb+o1iH5+0xbt5z6Pniu1Cnh1MJGdRLLxXlohHyoDvV9bJLvgOgTEe?=
 =?us-ascii?Q?dI5TSKzh6SMY7aF8OO4ElqLUIH1z40QeYYlZRfKckiMJJIaGu8qjXx2CSD5F?=
 =?us-ascii?Q?2qH9sE/5DYvd0JJcV26XSJDv+kcU8T6Qq8ONx2YmAYxMlxI2V/VSYIJ8mHPO?=
 =?us-ascii?Q?zHoU6CiXqF1OifwY0JwXdRMfOU7mrP7J+3l7Ml09Z07WoE522zNVVvZ2IiGv?=
 =?us-ascii?Q?yyo+G96zMtyAJ2Qmlzo+1zUlu3YsGUBzoj7+TMhw5uD6IRpkHsIyGb8hs5ob?=
 =?us-ascii?Q?jZ+8RhmgE+OkKIEhERs9v4TT6GM6o/QF0Ju3rgSHqR6bwGqm/VaBbkH69B5h?=
 =?us-ascii?Q?4kzVBJWab9UyxLiw6hJ0hUHerbMp4tetvnD3+izF6dOuY2QyvDuoFSYIrgwr?=
 =?us-ascii?Q?g7KsR7HwimwVngggSfXY+HgZ0p48qqmkYCK3QSI2hk79QvIirWKgfVPfGId4?=
 =?us-ascii?Q?sn3yhifxl6QKbHfnV1LpRFRQz+TCIkwM4cKUVgDACjFRuUsJNJ8F7Y+NmWxb?=
 =?us-ascii?Q?Gksqflii2tIGHP4VBSKbJLrCXlc9mPfxQ3JkW3PYmNVWbuQeaPgqeNt6FiFp?=
 =?us-ascii?Q?3vZMCyr9+gKkboYMTLcEH6qiZCMSvi+fqUTIIcy7uuvaf55wqtP3g5TbdcSm?=
 =?us-ascii?Q?791jArHSxgaoHtuomCfYsXMfWD0YTpVO032BedmvqmYnWmyddYT4MaLgHK6U?=
 =?us-ascii?Q?TXTWkzGKnXUD/txYB+Vj8qg9BbbzrdJ4VRCLSICDVbSy0bKNs99Js7WD2MIa?=
 =?us-ascii?Q?5zkjdGbaFoJh1AjpjLXW8761Z8iTEO12WvUPGDVgyjwgVfBNPFidDLt55Eh+?=
 =?us-ascii?Q?m7FNi990VRSjxdI0AU2xilNjbqU7uimjAQ21/29HJGj5djjj4U1H8ipLCqb7?=
 =?us-ascii?Q?N4HYa3ImmALEwoHHwqmXNHiW/2nSh23Mzw+Dt6SYPsF/qfmpswbkZvmyHYG9?=
 =?us-ascii?Q?Wo1mo+UlaVYheLj85t21/3kWEmJ3FT6d0cdlEYXQyo9qfHWkYcgODEQ4+v3d?=
 =?us-ascii?Q?DmsyYH84EzzJ7NdwMfMGhArNfRFSazAC6CUtBLSgI55u8p+PQViYcDBYfary?=
 =?us-ascii?Q?KuaoOfjeQHSZ2YOnqw3+QsChci12nVD5OXvDpYzZOZ1zxejf7jIgNrUMjBal?=
 =?us-ascii?Q?csHr08K3u2z4TqTcx8E/uGdasMYZzftXSE+yTf0FyPBpv2bduuch4lg9nXi5?=
 =?us-ascii?Q?VSUnPtFG3Bg5kGJKkSB8SN2E2G7bRR2dvccuejzcYWtu0lI4xVNoXzbaMxel?=
 =?us-ascii?Q?d1pAR6RryoEYA2cOz+U7Nvcilda419m1bPLItZF8ZTTaeTnIQca4a4G9+rhm?=
 =?us-ascii?Q?tLNPC7NuDg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daa98f79-c645-4806-aab8-08de4953a699
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2026 16:34:35.9935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oqYOKT2N2mWEor64jcdMfn1IOPZvfbJ6UJSrLYJqg3JYhQKZ+kZ83if5pmGCNl5+oltAt/UUURxQ6BNq9InoJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974

To be sure we have no rcog wake ups that were lost, add a warning
to cover the case where the rdp is overloaded with callbacks but
no wake up was attempted.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.c      | 4 ++++
 kernel/rcu/tree.h      | 1 +
 kernel/rcu/tree_nocb.h | 6 +++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 293bbd9ac3f4..78c045a5ef03 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3767,6 +3767,10 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 		debug_rcu_head_unqueue(&rdp->barrier_head);
 		rcu_barrier_trace(TPS("IRQNQ"), -1, rcu_state.barrier_sequence);
 	}
+#ifdef CONFIG_RCU_NOCB_CPU
+	if (wake_nocb)
+		rdp->nocb_gp_wake_attempt = true;
+#endif
 	rcu_nocb_unlock(rdp);
 	if (wake_nocb)
 		wake_nocb_gp(rdp, false);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 653fb4ba5852..74bd6a2a2f84 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -257,6 +257,7 @@ struct rcu_data {
 	unsigned long nocb_gp_loops;	/* # passes through wait code. */
 	struct swait_queue_head nocb_gp_wq; /* For nocb kthreads to sleep on. */
 	bool nocb_cb_sleep;		/* Is the nocb CB thread asleep? */
+	bool nocb_gp_wake_attempt;	/* Was a rcuog wakeup attempted? */
 	struct task_struct *nocb_cb_kthread;
 	struct list_head nocb_head_rdp; /*
 					 * Head of rcu_data list in wakeup chain,
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index daff2756cd90..7e9d465c8ab1 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -546,6 +546,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	lazy_len = READ_ONCE(rdp->lazy_len);
 	if (was_alldone) {
 		rdp->qlen_last_fqs_check = len;
+		rdp->nocb_gp_wake_attempt = true;
 		rcu_nocb_unlock(rdp);
 		// Only lazy CBs in bypass list
 		if (lazy_len && bypass_len == lazy_len) {
@@ -563,7 +564,8 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 
 		return;
 	} else if (len > rdp->qlen_last_fqs_check + qhimark) {
-		/* ... or if many callbacks queued. */
+		/* Callback overload condition. */
+		WARN_ON_ONCE(!rdp->nocb_gp_wake_attempt);
 		rdp->qlen_last_fqs_check = len;
 		j = jiffies;
 		if (j != rdp->nocb_gp_adv_time &&
@@ -688,6 +690,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		     bypass_ncbs > 2 * qhimark)) {
 			flush_bypass = true;
 		} else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
+			rdp->nocb_gp_wake_attempt = false;
 			rcu_nocb_unlock_irqrestore(rdp, flags);
 			continue; /* No callbacks here, try next. */
 		}
@@ -1254,6 +1257,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 			continue;
 		}
 		rcu_nocb_try_flush_bypass(rdp, jiffies);
+		rdp->nocb_gp_wake_attempt = true;
 		rcu_nocb_unlock_irqrestore(rdp, flags);
 		wake_nocb_gp(rdp, false);
 		sc->nr_to_scan -= _count;
-- 
2.34.1


