Return-Path: <linux-kselftest+bounces-31149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 173DBA93A7D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 18:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66BD1B677A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 16:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492BF22AE49;
	Fri, 18 Apr 2025 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TDpxIXfK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6294522A81E;
	Fri, 18 Apr 2025 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992686; cv=fail; b=qaSWsKptimfsRXm4OgERWgstMu3vJPEYWCRO/shHJ+0HPfCgIej5Y9NfXTdAcEvFeAFWZScMuslUhYPCqnXu8bEczxg7pzftni67dFtduJtL3l1A1LXCQZh2D9RRqeq9InCYMaI64IgcZ9/usMEnz+FcCYRQW9iOUtNnldaDuXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992686; c=relaxed/simple;
	bh=1pNIOSwVlcx74oHBooiZZQ7JFRmKzg0JM8bjMi2JezM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ApCutObvqRgtkeGTPrVgwRRgjL+qnwWCD1C6//7qtEO3c+BKizX7eWsUTBL4Fu+dXk24n0BlKRf2dfWMVLp87L6qmrjNwc7S+590kErf8N+Zrle8BVScw3qd43a31kCt1B0F1GrQQkjRLBiAufLPrZynK15LI3YdwQF7Rh2xD+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TDpxIXfK; arc=fail smtp.client-ip=40.107.93.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHXKBrbeC8AY2KZbB5eatu9e2IQNjjgy5Aum1QdC/2Wf2kDOMohEmkZ60J46tYB0rvUnlmNfmMGyXSJEPzz4ak8p3V9sSzKAxnf0Ai4FcN6InQne+tRoOiK2ZqHwiNAmxn/GQHXyTWfxfmfj15O+nRmApNuVQXj/7Adawrm7ZNpt9fhWKPnvcONQ02WrMbo4krmO6rCfXvXiQhswFQC25bp4TkrVrQgIDxVuOyGzHhb8Kjwu/v840f6OxMaAyyKPipBLxxin6VUqoAJ+OfBumXlHPQ20565jGat8jmq774n64b3zBZJBuNYK7amAby0F4ChOKCvX1k/puRfwov2iSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WReI1uJwFhOyrWHr5wPh2PS07rRsGdVVD2iitr8WYU=;
 b=wXVCBtkdzgtQ7LS+xcTj4ovBAw9KpAyqxIRIg46AZeN4UDc52mIhgVlS2GTUKtBMin38bsrYwW8pMMJJ2Z43pfqGGVtO0IuJ0nu+zVswXpw5iyqvuxTE+RFPjVcLH32os5lDJkWUCq0iNCuhIR8qmRwBjlLL+Rq3NUwxqfaFfJoocHzSbdDY34sKDySQlSOLrwGiNmBeBv6VU8yYwUW/EYsNH+iMaV6Ftfk/lnGq7c+cE9wEnwBwMJrZF4VP1UQ9YOdE3ftZBFRIk3JmvybD8q6YyqRkrfysvJobvghneEqhLhEBf5IYlSNTuAuy/ancB5z5D4Y7Ki5tcQIa+2SwkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WReI1uJwFhOyrWHr5wPh2PS07rRsGdVVD2iitr8WYU=;
 b=TDpxIXfKpNI235XBCl5EUb9y1TT//ORDmptyhqOOowZlGpsbbQODmvc6IBSSMA5BCLb6igyqK/V2zKNvKLU99RUUlv9qvub27CyE3Ea0XebMZ72awZ04WTD1RB4Fdu08tSdOeiEnJyL7mxA03ucz1tFX8MGXDyX9mWu5imo2BTScXVDll1mP+P859UV3qylWAgjDDTMteCdVbPMVor9rt8IlSyrrdqALGHDMPO5M6pLeaSnpzH+R2j5ynPGH8xos6O7GT71Hy3sJe/ZtKIjgjyAr7N4qdEvjuMG5v4g2irla3wlYScamB5KZg1QkoI6Z6iVSOQp0AJY2ZXbjQdnVxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 16:11:17 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:11:17 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 12/12] torture: Add testing of RCU's Rust bindings to torture.sh
Date: Fri, 18 Apr 2025 12:09:58 -0400
Message-ID: <20250418161005.2425391-27-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161005.2425391-1-joelagnelf@nvidia.com>
References: <20250418161005.2425391-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::20) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 084bc372-7dd5-47d7-ed65-08dd7e93a6a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hnry+nqOgep/MqVVs8DK8PSLXjUX5roFNzlRxtZmkT0bexJOsJMRt2RRuaJ7?=
 =?us-ascii?Q?rOKWg2WjZ6iLNm3z/w+JGIOMs3jUAlLpzxQ1onTbE6CN8vMJLUm1XMS00cs7?=
 =?us-ascii?Q?+Tyy2ZI4OlZU/OJ3FPMC3vNvaeHUbg+ovm2ewnkN1Sq2FTGol09bzZWL2tnL?=
 =?us-ascii?Q?acJEadm5IP/nvpGTKZ4daLTO/w0eVY40Vj3LheFYdS3aL46QCPwzJ5iXDGoF?=
 =?us-ascii?Q?EoaupIethWaPK/khCoSOPTymGgWAOnEtjKozDeW02vz67ay8mByTOi1V4eAK?=
 =?us-ascii?Q?5jbIuBd/re2iP7GNqMcq+j7hKwpJ/O6OYdBkyX/T+Fe6WdmC5nSOfuU4SxgB?=
 =?us-ascii?Q?zBob4Injb5Mo8Ht0AeIUuRj70ubYRxtMgYW8JGmprE/XwzIHf3BQI3OAf6y7?=
 =?us-ascii?Q?+LiJDCtfw6jHj7ktG5VOdMivJqgf9QuN3MTDE6KcPPPwOATIjOAskJs10bpH?=
 =?us-ascii?Q?MRF8maiHP63SN32gQTKeJsV7+at0qSgObzox00SEGylPoWQeSSiJ2sgk2hbi?=
 =?us-ascii?Q?+3xo4baEAL7u7wqwAsfDFJDh24xtlJiB8JIi7TpC/koyZ0taunI4Tx8Uog7S?=
 =?us-ascii?Q?eif+Y/IcHgZI1XLYbI0kfr4wpbxeD1R06WaX8zcd0xJSrT0poFHkaiqT6G0B?=
 =?us-ascii?Q?NSKC9iQnCTsvuo6VLVwpqdvwIZPXfBHtcjuKTtAiJ3zPe6VXhKxrz2Qa/L5d?=
 =?us-ascii?Q?UjigIoc8w6NcTBUb22R0Ziw9qCItdKALgwjKt6s2gUinhrbHRujIYiwAn2dC?=
 =?us-ascii?Q?BLyjJboDE0mhgWmsgs0Yr0YtdKo8WoQ7PzXRzzAgb9O24Kvcj8xOCBQuaRDm?=
 =?us-ascii?Q?C+K1njQKYnJYqq/TGRpPK+vw9sGpaHNvmz2q4Rau9yENHGvIoyeZ/KIJG0TZ?=
 =?us-ascii?Q?JQpQXOrW0qQAinkxTjhqqAoR30PfKja+9vBmtSxVd1MeWOTUEOtSkl9ju7D9?=
 =?us-ascii?Q?0GOH14wpq1A2pztTb6cDkkJhd/vGftYKnb+jxgf+hCvQ61/63WobdPEzolry?=
 =?us-ascii?Q?F69YjBMW4UNz2JshWbh9c1r2pHAf2stkZr6bivIL6GM5o8uqNrUOwidUdo46?=
 =?us-ascii?Q?YCPeZnyf0HLIJgL2KlxcZJiuWAoS0RUc8PMjQYOzTw4++Y4ZPbyGo4ccMFNL?=
 =?us-ascii?Q?yMcUJWhYlp3OK0/NrBzavPFpn6OqWLwctEu13no+co3mUtZCkxuXdPId+/2e?=
 =?us-ascii?Q?fdLLee7n94RADNW6J/YjplI8vyez+noc1SZMVGXMfiyYc2OUEn9rbA1HrKtF?=
 =?us-ascii?Q?qjrR8oSZfof1grGRHgDx4/ob1NctHeQK/rMlu8mPmC+S4dJOnvP1ap7tebXZ?=
 =?us-ascii?Q?9eFh0K+YpOXWbMVh7822pe2HCqhmuFxvSTIGjwij3cGBARi1vH/uO5unqK+Q?=
 =?us-ascii?Q?4W9gXFryV91jucNLNXxYyJ2wUtXD9V1mCfDMDHB/lrD7zxFEBrUWZFHUPdUP?=
 =?us-ascii?Q?My9U5fhVI+PX7ooWA/bltyNr2wKpYNw6CoN1rlIcfLifctUlznO1rA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n+8tyuSgVD8srbW7Nh1+gIJoeVBrx38H7kMiCQvecQi2XSghxo1OPa3D74G7?=
 =?us-ascii?Q?Na4SenAYG9xTdvWgz7YYIZ/a34RoCjGkv2GKmn21bEpjytJ71CP+fVVrv1Wo?=
 =?us-ascii?Q?rrxR4Flo81MQfxfOriGPk/H6uxq7P8u3uIfQgX8cHdak5TIU0pqOqOo3/lf5?=
 =?us-ascii?Q?D57B35I16M3cq5nYVDZs35CjfH/1XQGdXZvZrrdkHK+bZAGmSLhvxefuPw/D?=
 =?us-ascii?Q?2/cHiC2wLbmpXEskWTEIMAy+OxshB28CYaReG0/zCo4cW6JwNGTccaNmOt9i?=
 =?us-ascii?Q?pZtPxZ9idzXbYJWJqkq/VXIEtKSYEadcAdKldXUR+ws9urNeN8CKOguFoDxr?=
 =?us-ascii?Q?tArl7cDdlATpSkkNWjbcRnOi0LXl5gTwctN2gLrhlVk+/V3xnkdxZrwd0V9B?=
 =?us-ascii?Q?/LXP/gRJE3e7jMY12aJrERnskusRhfeEQ4th4Y1ZuokyfxYJ1YT5qvnNgV1/?=
 =?us-ascii?Q?Z4xesyGR6V2uxnB0L1lX/Apbx6OnbQoa5ApbC0NHdRPvrwudxRUwrq15H3gl?=
 =?us-ascii?Q?UCC4EAzT/lyTDy2rfK7pdojPFhRU18130ZxKQTYfq9v+YxGAxJktz0aNPhpZ?=
 =?us-ascii?Q?M7Nz5pE7WkHjXzr0N4MMesmn2GeKJjFhMhWPsHTJOvnuHVGb5eKcbj8nSwlr?=
 =?us-ascii?Q?R0KzTq2yeHn2xvUEdHB7p481NV5M2qO22QNCc9UD0PF3MYpGmFB5bpnbaT2m?=
 =?us-ascii?Q?IFShFBy+kZLXrNNs3kdfG7DBDcBBoitwfmxDQIi6/awwALiM4hJukoQ4NgIi?=
 =?us-ascii?Q?Cd4SFriTKIhXYSdT/8oNsspYQxGZS8NVuY14CEX9+x3P5dNcxf5xx6aisSI7?=
 =?us-ascii?Q?rzPasysh5ao2Yd86hWBzZQcd8vPgznF1bzLHAY3IRORO0HPkGytUXv13cAhP?=
 =?us-ascii?Q?a9h5RvxhJnyzEUV7XdHGazxdGrLsIYJX3G41m18xKfei76vNzkGUuX9rCrIJ?=
 =?us-ascii?Q?fmM7qKiEYZl/7ezszzcMmAr5YFkcSwrc43uIjY/c7ubsEExA+jskSp3+dvzh?=
 =?us-ascii?Q?jcWXoh3/U9mSG4PopAlCTs6g0AXR+89klXNuEXNqAQGVReWqP4V3Fwr36e/k?=
 =?us-ascii?Q?KJrNAbUlpn023TimNNSrkngdlx13rVx15v4CIuoWETIVdibughKvLM3wmdsR?=
 =?us-ascii?Q?bbGsz2Z47fEtNwK64WmvClN46tEJ8QV3etpcK2WENCkkRVTn8qIsjhROx6e9?=
 =?us-ascii?Q?KdH8usjUgqt01r8Mj5/QPCFudFxE4i38Ec6oMtOVl4mg5orubxuLdRDNzIvu?=
 =?us-ascii?Q?/lYXfmh/z4qS8uEra7wOC58WXAvhKSqhUNAalRfp0YDm6graQkFZUli/U1Hd?=
 =?us-ascii?Q?ewDgPVDtKqzpjRNJspNwZN3XAKbfROmDSD8QZrewirLT/nQ6GnoW+PsH/rXH?=
 =?us-ascii?Q?cgmvhLTa9rYbhHB54uDSLdTR9gTUx5BSFFQh9KYOdUZPdP0shRky/1r/GePo?=
 =?us-ascii?Q?0GSPTUe0FL73L9E6t9KuqUcaNgtEH6ZAtXHNUXsOifL8gPHbXFl6zTE07oYY?=
 =?us-ascii?Q?ROJvm/elLGDbndpYjihF581vV5e/Pim7GU89OqYR41GP0B8Kzllgs5bi0Bgs?=
 =?us-ascii?Q?s8kJj5ELMfx7Gm5yPoOzjud8YhMwN/QoJyk079Dn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 084bc372-7dd5-47d7-ed65-08dd7e93a6a1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:11:17.8769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4l09TfyXMI8SAp7A44TmFEXNLWHU+sllm+q82BWBwg/b2Ev/cufCwdENFTQv33wmArAje6/3SzD4Qm7Wvz2Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a --do-rcu-rust parameter to torture.sh, which invokes
a rust_doctests_kernel kunit run.  Note that kunit wants a clean source
tree, so this runs "make mrproper", which might come as a surprise to
some users.  Should there be a --mrproper parameter to torture.sh to make
the user explicitly ask for it?

Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 .../selftests/rcutorture/bin/torture.sh       | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 5ccd60a563be..6d1a84f3f631 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -59,6 +59,7 @@ do_clocksourcewd=yes
 do_rt=yes
 do_rcutasksflavors=yes
 do_srcu_lockdep=yes
+do_rcu_rust=no
 
 # doyesno - Helper function for yes/no arguments
 function doyesno () {
@@ -89,6 +90,7 @@ usage () {
 	echo "       --do-rcutorture / --do-no-rcutorture / --no-rcutorture"
 	echo "       --do-refscale / --do-no-refscale / --no-refscale"
 	echo "       --do-rt / --do-no-rt / --no-rt"
+	echo "       --do-rcu-rust / --do-no-rcu-rust / --no-rcu-rust"
 	echo "       --do-scftorture / --do-no-scftorture / --no-scftorture"
 	echo "       --do-srcu-lockdep / --do-no-srcu-lockdep / --no-srcu-lockdep"
 	echo "       --duration [ <minutes> | <hours>h | <days>d ]"
@@ -191,6 +193,9 @@ do
 	--do-rt|--do-no-rt|--no-rt)
 		do_rt=`doyesno "$1" --do-rt`
 		;;
+	--do-rcu-rust|--do-no-rcu-rust|--no-rcu-rust)
+		do_rcu_rust=`doyesno "$1" --do-rcu-rust`
+		;;
 	--do-scftorture|--do-no-scftorture|--no-scftorture)
 		do_scftorture=`doyesno "$1" --do-scftorture`
 		;;
@@ -485,6 +490,46 @@ then
 	torture_set "rcurttorture-exp" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE03" --kconfig "CONFIG_PREEMPT_RT=y CONFIG_EXPERT=y CONFIG_HZ_PERIODIC=n CONFIG_NO_HZ_FULL=y" --trust-make
 fi
 
+if test "$do_rcu_rust" = "yes"
+then
+	echo " --- do-rcu-rust:" Start `date` | tee -a $T/log
+	rrdir="tools/testing/selftests/rcutorture/res/$ds/results-rcu-rust"
+	mkdir -p "$rrdir"
+	echo " --- make LLVM=1 rustavailable " | tee -a $rrdir/log > $rrdir/rustavailable.out
+	make LLVM=1 rustavailable > $T/rustavailable.out 2>&1
+	retcode=$?
+	echo $retcode > $rrdir/rustavailable.exitcode
+	cat $T/rustavailable.out | tee -a $rrdir/log >> $rrdir/rustavailable.out 2>&1
+	buildphase=rustavailable
+	if test "$retcode" -eq 0
+	then
+		echo " --- Running 'make mrproper' in order to run kunit." | tee -a $rrdir/log > $rrdir/mrproper.out
+		make mrproper > $rrdir/mrproper.out 2>&1
+		retcode=$?
+		echo $retcode > $rrdir/mrproper.exitcode
+		buildphase=mrproper
+	fi
+	if test "$retcode" -eq 0
+	then
+		echo " --- Running rust_doctests_kernel." | tee -a $rrdir/log > $rrdir/rust_doctests_kernel.out
+		./tools/testing/kunit/kunit.py run --make_options LLVM=1 --make_options CLIPPY=1 --arch arm64 --kconfig_add CONFIG_SMP=y --kconfig_add CONFIG_WERROR=y --kconfig_add CONFIG_RUST=y rust_doctests_kernel >> $rrdir/rust_doctests_kernel.out 2>&1
+		# @@@ Remove "--arch arm64" in order to test on native architecture?
+		# @@@ Analyze $rrdir/rust_doctests_kernel.out contents?
+		retcode=$?
+		echo $retcode > $rrdir/rust_doctests_kernel.exitcode
+		buildphase=rust_doctests_kernel
+	fi
+	if test "$retcode" -eq 0
+	then
+		echo "rcu-rust($retcode)" $rrdir >> $T/successes
+		echo Success >> $rrdir/log
+	else
+		echo "rcu-rust($retcode)" $rrdir >> $T/failures
+		echo " --- rcu-rust Test summary:" >> $rrdir/log
+		echo " --- Summary: Exit code $retcode from $buildphase, see $rrdir/$buildphase.out" >> $rrdir/log
+	fi
+fi
+
 if test "$do_srcu_lockdep" = "yes"
 then
 	echo " --- do-srcu-lockdep:" Start `date` | tee -a $T/log
-- 
2.43.0


