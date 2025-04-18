Return-Path: <linux-kselftest+bounces-31140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61403A93A5B
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 18:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E78091B65F4B
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 16:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ECE215191;
	Fri, 18 Apr 2025 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kgm6JJfy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC47215168;
	Fri, 18 Apr 2025 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992629; cv=fail; b=Xfd6DrwhqGsaDSiI/cxUbvMl0h1SXxlsIKOM13r/MoRYQ3dktpkZrmXdfJOVy99P1yRpA2Q7DUGw4wChGqnEwRxgiQ2dFx7UagIHc/So0iDLF8q/IFMWI57mEv9pXkHDr02JAUkxp7upSY/pMjjwtq2xjPq/C+RMDdtV7QyzIyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992629; c=relaxed/simple;
	bh=KEl0LBnU3WQsJrO8Ldcb+Kpi365bGlQph3n39vakKK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ia+GU4RlfOhxEaCkr/ekLiXa+MP+v1z1bROmAXJYiRZGeK2zif1AjXvRWQAlppCHrxYHP9oDUn3z0zogyWdRW71iCuMILWjliR3W8nPln3azLyQT+IElZbkyZkY6QL7BIvZARJOop7iLdZE21liH7aXWrKDyfkl7p2PSwn5/zpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kgm6JJfy; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXSxv1RzeuWFmZtEUJwiPdQGQRywFAnCirI73udUU4XezBa4k7PE7ZqN77SBndiQ52qafaSKzMlk2DYxkvh4wy1A5ZmpV0g3jSVy6IBCpnFIQAIvVHyrP0Lpaod7rc3drWfD3301K9J6HakOw5UzqiL8nks8//UzXpov+43ImLz1U2sH3F9GwIIUNBTCBG5Shjd9543xw7gigJm34OGeIwzVJlNqsJbAmbpEJIiAyRoeZw0ByoLcQreOrdSkFRSxWdw6cNty8yCnSxMu56AZbFTtf1DZ3RSUeGXm8dpHXCa35Q4nT5buqjoqOE1UKhouq89EpF5xB7uyhmCFADeRug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fcuiC+7oyaqYgvXhDGY6OiNa386pzEP2TCloKjTN1E=;
 b=LuBPmqP78f8haicDAiVeOauxhDCGVTRE3KsVks3qfznSs0OFSYgNf61iqQSg8jbTzvKAc9jifF8Wxy515R2ErcqJhJToJu5IKowz3WS1HpiWyncWudmJJLq/ubvK5TVBMcrduMzp44ZTouqdHZ6AJzs74itjReC+SrW76TWWSmmfcEv3t0TDofKCP8UZRs71UBiYjA+KT4/aFiVgb/FzoDgzW6ZnBm1IkB0KeJfX5b18ZZau7nP/gBajdVLPYedD8tDxlAgDPY3/4GPjGQsvnbO/Ys0aG1Jbmn6LrPLfewS7Kz5A7bqI0/e19cZXYEiM1PAVqaLW+ri7bEZtWVch7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fcuiC+7oyaqYgvXhDGY6OiNa386pzEP2TCloKjTN1E=;
 b=kgm6JJfy4Z0WBkW4TOnuHgX4T3tAZMVcsCExBlnVG7MlUPub2KD/3uHa8WCpHgJnDJq3p0Ox/SOUluZ2olHAj08Xo4y9qZbFOb841Qjxv40MbAUFjaS38YGoL4YDGlC9pwrPoCqwMWf8g8Wx9bF55BQWbbBLsmz9CGIzv/3kVbKFj7T1CUMYpZ6fnEFjTu2iPXhEIjbxGAPY5C1cqGt178lQm7nGva2LkZ3y2PjIVlZQesjPJzO8KA9wrdcaxanH3AjRghU6RkWIk3PhwWMaTXXHdkiqfCXlRmE1i4N203pT4A/chMmWD2asFgNuuybvS7ngE31NEOtotglO7igJTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH2PR12MB9544.namprd12.prod.outlook.com (2603:10b6:610:280::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Fri, 18 Apr
 2025 16:10:23 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:10:23 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 02/14] rcutorture: Make srcu_lockdep.sh check reader-conflict handling
Date: Fri, 18 Apr 2025 12:09:34 -0400
Message-ID: <20250418161005.2425391-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161005.2425391-1-joelagnelf@nvidia.com>
References: <20250418161005.2425391-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAP220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::33) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH2PR12MB9544:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a97f27-4d31-4af3-6818-08dd7e9385ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YzWc6eAUfZv1GOU4CpZAgNBlqjhqzXhG447oWfWt2WSoV99V3Myg9Y5t4G1M?=
 =?us-ascii?Q?MItrSH/jmlRsw4n8uTakdv/Xvf8IT8R1MkjMq/aljoK9/QNyXst21mM3TCYz?=
 =?us-ascii?Q?VHvOYoKoUeDkdRCUTOzPK/kZYH6I4eCoaXjlJTGhVg/BsFCUUNGOvDD8nAWz?=
 =?us-ascii?Q?HdgrlHr7tuuQ0UDL5R06znXpRQmvGku1hKPjY1q38M0Ea1krnO9KZDrXOSRP?=
 =?us-ascii?Q?g5oL8ZSSqoJiDFIWrWFF1Dma7JXZuaWffkRq24Bi/Zvt/8DFN0B4gXQuiIQa?=
 =?us-ascii?Q?kb65D3owF0tQGm+3Dg5WLh1tWl8RkrU2rFvyr/2/gDPlY69D//Y4Zm9vr40H?=
 =?us-ascii?Q?1MzsjQpx+N3ei+jUWPvj0PieZ07EqjjKEAmdZCLhMF7eEFHJUmvJKb61x3Mj?=
 =?us-ascii?Q?jdqBpZ2rptuG33FW9TwUStIaRdUEuIO8n+JRrvXaJ1TzKJYH0Lk2ySxCMjZV?=
 =?us-ascii?Q?0uLlh48cJQYkwxaGLclQAukWtAsCfhBnCVYY193iPgD6uW5Tlv/3YVZ7N546?=
 =?us-ascii?Q?j/yT39EoBYO/83E+W8ERFfvvZb4Jav1uB/INjJgpTPyenOF/NP8PIsGAF8f0?=
 =?us-ascii?Q?91ki8ke5xItdVPkdLr01/9qQS8oOMn9+A2OAg5o3YqIa4JXIkkDandpEjlko?=
 =?us-ascii?Q?EoMKzP78unc8BuFkrdnCvxYMmYQ6ccw0VbrhNfWzrcHbPuoQF3Zv9MHvcmAu?=
 =?us-ascii?Q?TCyTrmq45XnD2prpNTJFkanRdiw8h5brz4mv5UtDq8XjJb11Y6+RKZOqxgi/?=
 =?us-ascii?Q?XzCONJlr7grwtRa0MI/V5yCMPxLXxdI5+emucQpOP0Ux6K5Oy65KbpbqVzjg?=
 =?us-ascii?Q?vqrp5dm5RNzEskQIe+w054z48jXRaXgOvphsCVnmZcErEME1ArJ8MYm+k//G?=
 =?us-ascii?Q?sY1WnGv2HCLUsQ69xgxXnpt1+oeTWgtjOSNtWwaWsEj2i2ceSsdrg7KZNwgx?=
 =?us-ascii?Q?3DojEEfvUAVDC3nQIS/N/562ugkpTrvvBakb+HK5f4KBz/EfjjoeWU2iI2QA?=
 =?us-ascii?Q?eob58TSNivV+V0T292jqsWrgbwDeC4HSxiWfwHncHychhkRusfNYP20JYC0F?=
 =?us-ascii?Q?jOAyY23uOEUMI9tCXUnj3hWlEDcoFvIws0PcbY4hD1UHozfeeZPAm4ANexVy?=
 =?us-ascii?Q?BlNAfknxeydNGQ+V3j/W2x2uKEA73cZ2CyKZtgD+N4kT0OM6h6e/pbz2GveH?=
 =?us-ascii?Q?cQXtTYAfGuC9BDCetOPWoqiY3qaxoFdMX1/Q2Oe+ScBy/s+j1dlCmDYXvmEt?=
 =?us-ascii?Q?ruH5z4iiuoxF46UixB3A96sERTQsGJqH8Ldgo7P2c1rcmb1heD27Y0HGEAfs?=
 =?us-ascii?Q?Tl23iVCIT5wuUoW8ei2vcPcO6t0HRlPJbar3HGb0ZAkyk5NlME+0QU/Z21sj?=
 =?us-ascii?Q?Gi1DRdiz5fBqQdsUd9de7Shw/igsgEUYx2bA2UEcCB1fDMANiyCUsj5Mk7d1?=
 =?us-ascii?Q?S39la8Zy3NY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eTd3utZkeMcBUtce6Up9EYQgIUMQz92Z4kdQq/am4Egvpr9LgR8U18NwNaqd?=
 =?us-ascii?Q?H6dSlpmAVD9DEKPvR9ckSWiBFrvXTpiluXQoek21F1RPfdLkz6eS/aj6Zm1b?=
 =?us-ascii?Q?W386QSkG99pdFTxClFx5STGKcRj5yBt+rWoA1jh728bbGPqfhiYK2hkAFCgU?=
 =?us-ascii?Q?UAOBVltwuVHCPewkjHPIj/cfr7M7Lmm01ooplN+1GjeNM82BuXVNTuO7budE?=
 =?us-ascii?Q?6pJ1UnoRtvOSZJxKSIgONgsPnC6b/Yll0iUAp6kQSRrucYgSgtlTm4ztKcR5?=
 =?us-ascii?Q?+1T794mrrlSgBabZk7/s12snOUUXZpZeLhaU9dJ/ylqR7kBR25yGFiReeL1n?=
 =?us-ascii?Q?AH6osuOVhNEavGDg2kteGr8o7lNjvS+g6VFK18fLP5VTWQjr9Ke3gtuzD8QT?=
 =?us-ascii?Q?T33obWilccfNgx6t/yGuo0g1DZ656kwkugTTekGoyeghMMCmXmfeS9+WeTpb?=
 =?us-ascii?Q?doT97T3QgDj87D2SSXCcx/hLoFlSalHFSXdVpk43X3gjxm7viEHioQ92Cfxw?=
 =?us-ascii?Q?fDuhaCArYpUCvmr+05BAtLe46yi4lY3d44JIklWlZ0IioNsHl8hNO128BiEd?=
 =?us-ascii?Q?NhfBLuoIzl9y0U5xPyD232qI4tchlmAlVZ6C8xN4Eh+6SoaW6wCZr1rTCzqN?=
 =?us-ascii?Q?vCgNY2Qd8C7DhCrR8wkFAb7Y4iQNPvknYwsc6pYxybKXyLmOOzZsxqO+lHGb?=
 =?us-ascii?Q?DUzKGPtzCWqdEghCku6SrSvEUcPbsB9c0ENtS1CwLdU2oPKuQmEDynUfztQz?=
 =?us-ascii?Q?6OGAycyh4rX/B85vsp8E3MYcRKl9EggUS3GALht/9ReICSzu2oFkf5O/uT6P?=
 =?us-ascii?Q?RGECdlErt07ebN0qjB5zIz9CggQamLNyJgJ90HRc4r4WQIstmTTmST1RrWAq?=
 =?us-ascii?Q?txxK66FWKepqS8axONwnBe79n92vCwLUpHltluhwuaPTFWS36hUAmrY2NSCv?=
 =?us-ascii?Q?R81JnMHhd1wcBUf9WSVRAt6ltD+s2DoRtEN3hNW120f/Z+SfEimTh/g+pgWT?=
 =?us-ascii?Q?9zQi90caPeFSvZ32iIgci/bSkMZeu8yJIcJRz0yW1k3tiQjetK+GlBOqPRXG?=
 =?us-ascii?Q?IkqnXbJigpmGkvIlFO3YNouo2s09f8eh6Zk+afFrk0fYaWCusFEGoj/dPUEV?=
 =?us-ascii?Q?1FEx4UUvr4je6WnnCTTQIfG7h5A5BFnXWpyb3HSk/Wt5LuU5+WiIZX2J+d+z?=
 =?us-ascii?Q?TnbBMqb9EMDixuA8Ktee/i14M6bBznr+NY7UinkGJQQdl/Vk2C9VFv8E5Z5t?=
 =?us-ascii?Q?DYL3/xsLrxJ7v5BRdqBDbFVBybHLB/+tIq4FH/loayz+DTKb7cREkiwPViaq?=
 =?us-ascii?Q?gs76cnbd1l/y6RsXVaN3cUeCegfGAap89vTDY/3+9VEz+pi0P1GvteViueCo?=
 =?us-ascii?Q?8AYwZyQLRJg3MQoQKlLMc5ERT4rlXo3RO+CSPBRTB7xJn726Ir/bgh4EWSxD?=
 =?us-ascii?Q?W9JabFfq0gbByCXBydA/esmagUjrX1TdIYWAXe1WBpuigFObGGlnK+Ue35Nn?=
 =?us-ascii?Q?xhPPtN+X0V7pbFNNYsjnySUtpt2dt4+3Xe3mnzY0UVRvpySmdfuH/lx0Kueh?=
 =?us-ascii?Q?yt7TAS4CfgsKjO51dC3Qv2ciMpd/ciOktJpdDGeD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a97f27-4d31-4af3-6818-08dd7e9385ea
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:10:22.9413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0nag/jzAmUDHbxladmoB5jrj7K0GtDUBHZOh3+G5d5k+5TiOLTAQoZLk1ciRHkiMXpqc9nbrYduzznL6rNaXDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9544

From: "Paul E. McKenney" <paulmck@kernel.org>

Mixing different flavors of RCU readers is forbidden, for example, you
should not use srcu_read_lock() and srcu_read_lock_nmisafe() on the same
srcu_struct structure.  There are checks for this, but these checks are
not tested on a regular basis.  This commit therefore adds such tests
to srcu_lockdep.sh.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 .../selftests/rcutorture/bin/srcu_lockdep.sh  | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
index b94f6d3445c6..208be7d09a61 100755
--- a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
+++ b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
@@ -79,6 +79,37 @@ do
 	done
 done
 
+# Test lockdep-enabled testing of mixed SRCU readers.
+for val in 0x1 0xf
+do
+	err=
+	tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5s --configs "SRCU-P" --kconfig "CONFIG_FORCE_NEED_SRCU_NMI_SAFE=y" --bootargs "rcutorture.reader_flavor=$val" --trust-make --datestamp "$ds/$val" > "$T/kvm.sh.out" 2>&1
+	ret=$?
+	mv "$T/kvm.sh.out" "$RCUTORTURE/res/$ds/$val"
+	if ! grep -q '^CONFIG_PROVE_LOCKING=y' .config
+	then
+		echo "rcu_torture_init_srcu_lockdep:Error: CONFIG_PROVE_LOCKING disabled in rcutorture SRCU-P scenario"
+		nerrs=$((nerrs+1))
+		err=1
+	fi
+	if test "$val" -eq 0xf && test "$ret" -eq 0
+	then
+		err=1
+		echo -n Unexpected success for > "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
+	fi
+	if test "$val" -eq 0x1 && test "$ret" -ne 0
+	then
+		err=1
+		echo -n Unexpected failure for > "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
+	fi
+	if test -n "$err"
+	then
+		grep "rcu_torture_init_srcu_lockdep: test_srcu_lockdep = " "$RCUTORTURE/res/$ds/$val/SRCU-P/console.log" | sed -e 's/^.*rcu_torture_init_srcu_lockdep://' >> "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
+		cat "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
+		nerrs=$((nerrs+1))
+	fi
+done
+
 # Set up exit code.
 if test "$nerrs" -ne 0
 then
-- 
2.43.0


