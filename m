Return-Path: <linux-kselftest+bounces-31145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D48C2A93A6E
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 18:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD4C1B67956
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 16:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B63222594;
	Fri, 18 Apr 2025 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ae5xpJVz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026502222D4;
	Fri, 18 Apr 2025 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992659; cv=fail; b=Ygv72qGPW4U9O2S96F0qLrYA2OYcjOotYuwvZi3zn8VIViZSfAiGbY90dMvcBlczm7WMc7kAGjaHnNNrotczzm1KN04lK1S/TFRBlfJqY1fOAgkCJdgxGOMOLLop45RFIwrvFHk6cxxEsGXt568Lz0IdyyOpuaWjncXStcRLkn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992659; c=relaxed/simple;
	bh=SOyhGC0pPN09w4WjbFHrNewdQ+j1R4XL7Ril1+7wWsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=baGXmBqwYw1vLkvYsp8vHAV4zyFFQiRN5Wm2osSybuj+33nHajoPcW6aPk3FxMR3gpdSog7dnVcZHwZOvO9OGa2LH10Kk201IScKf/oDNJkKFBBnvgqNvjI6f/TcLRWSBMUCovA/PeRlnRxCOn82wRvI56HbQMeSok2A587W+Kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ae5xpJVz; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7Ux1WxUFunjdnxmh3M3gs2N+0Ty0f9dF3e8q8VRmG2jyMl+PBrEtVhEZvtHPeQievRdvHzS9vBEd3KggrF4KVvMpxTCxXX8obfi3cc4CMQyjTGAVEvelwR8u9rAyl8UV+tUfnFyvRw/ww5YJTYNJofXGsfmY4W7tiFHe63jsbuEQTOMj1broUs6Ry7NN41MXFjmZdh244x5/TO1sWlDMrCkGAn+gmKQ31whhwzQyZt0tkklUuG2HO+izwgqHiZNNXCpeos/dZXHg5EIe8uiVXK3Taw9TSKtn/Kl9uCmlYFeTRPV+NmgXd5F3v424uHxkmEKK8mcbQD6md535E9E5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rUryLepTa2cjbLKJkNgaNsPrNToD9mdZ2QWuf5WMrM=;
 b=IN189XQgs/rWasS4JXBMPi/PBVIr503W5QERaaRaC3FcnbbafOYxeZcAmUABSsqiKT1x76rHiXgEcxveFdSEvwEdM/oUNtTWP5hlJ6I6D79S/r4sOJCP2r7MeVdg4jJnH5DZh9hdtZVi/PNdoDYnSdB+o+7nLYOZRO7QLQDM9dw/z92q+nB5v/NxiVs4V51Km7ODlAagetxW1vLHV67pVoPuo6nl4PDQfSGe51uH/Sljj3nPzYLUEW4w8i+01m3D1OBN58JGxemN3iO4wPBLS1Jf6HPj8HetfRhf6Pb6YgVtdpMLhWjA7ErdEcQXIxUeo6EkvkxVDnMEwmviNGlAvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rUryLepTa2cjbLKJkNgaNsPrNToD9mdZ2QWuf5WMrM=;
 b=Ae5xpJVzZnKW+fiNC3GvY1iqF+JafISWj3W9ssX8QJNUrJ9T3tgrVjUrfoZw0Xged4E7Hm6w5hAJxBz/RttpNYjauAxkNSx7BZKvWqd1Ogq1prdwVfv2ERvkvoKPB7hSztuxPhms7sPaoY3uTg37Pj9VhcqC8+cbW3Modp5n/NYQhdE1hCF9l+KFO4aKGeDsNqKufBGOMo8DoqF8pR2dT+NDcLFf8zXTsGQGL1JyHFGvvKPzga6bJClmdzY7uxppXIZ0a7clJQxhWtrIfFAb+BWUThlzBVWVu5aca4HBIR9Req0b0Tc8ihlBoj8WX5xs28fEMeHeQma7B0Kz533Big==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 16:10:53 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:10:53 +0000
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
Subject: [PATCH 01/12] rcutorture: Make srcu_lockdep.sh check kernel Kconfig
Date: Fri, 18 Apr 2025 12:09:47 -0400
Message-ID: <20250418161005.2425391-16-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161005.2425391-1-joelagnelf@nvidia.com>
References: <20250418161005.2425391-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAP220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::21) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 33645445-a8df-4a10-f509-08dd7e93981a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y8tujoIS6Nka7NStWOIi3VbNaueUVjcTsrJ2fD7k2Q0YaQZM5iGqHhQHfDHn?=
 =?us-ascii?Q?z7rEpONSS5jxrEdC3g/3Ajoon14P/Talt6bjS1RVBVQbACzdNeQJ+DE0isOh?=
 =?us-ascii?Q?1pkUGgYm8PaaNv4Vp4hkJW0QaQqOYjpp6fhwqdB8iAixYmY3SpE9iNrwUCEw?=
 =?us-ascii?Q?FaAk4VBIfo2cTgqWvAL3mAJ9AgJTeE26NoTcE/utS8l4fAZXhJVmijGuk7+R?=
 =?us-ascii?Q?5T6+9l8Z+sVcLY9W8yhB+X+EK7myfASbKwmDEITwDIPbEanW9m2wpoah6OD/?=
 =?us-ascii?Q?11CWFV+ZeuBL9eLmxKPFjn/nK/NaQLBXDqUkWWpwfCUXSW/bqI0iN8QQmDdB?=
 =?us-ascii?Q?2cmk1Q5jhGneOgYPLKy9JTOSH/jmJ/FWMhhKgyW9kQxfgAdeJDKH1PDvdlaB?=
 =?us-ascii?Q?x8c5CmTD/8bW9s4MeNb76dFgapXXACRh2vOmhcfJThzzgUw2FdW1edc/tOOw?=
 =?us-ascii?Q?JFUQvW+MfkD+kKnSo7Gg4Kfv/JdGbraoLkMWHkLVEA/8xH75U2KFUYoB47q9?=
 =?us-ascii?Q?gXG5fDlpAlXUAaxD/ripr0xyWAcaLwRadIosgVwTyBRJsDnYMJPAXafdsc8J?=
 =?us-ascii?Q?J+5SHAHtzQWtVBdXU4qyRu7Tb3jjFkIDFWkdOhE+0ghPu748rykQRwMhPbJL?=
 =?us-ascii?Q?xwNTgivUiWzFNmw7BXoawPH/ndoqNMxeXfx+yVQ2gvROfJYk2pC93Uu5bItE?=
 =?us-ascii?Q?9Yn62g2TqK6M7H36M3i3c+G4uPX58mcMM8NPSE5o4eItMT8tMZm8tQA3vCgj?=
 =?us-ascii?Q?XEvNu4WGDHvaK6BtwzIkOFFuNqANB4Z3x93V+2xqrVzub//yLiio6SOogXtD?=
 =?us-ascii?Q?b3+fgiOUpvOw1f5xua3S2TitvsoQS5hEDxtRo54xIZvo40mN/QXJNIhSj0zB?=
 =?us-ascii?Q?8aBxaEywM3EGHDh4EAqoI0x518YyV8gBciLvANH3X16DQnkGLgqJL7z8ph54?=
 =?us-ascii?Q?7szBHQXfVO/MkngndEgVPLEtqhud3BateKjLnsRL8vTUG7SrvWAVrjVe/5Qz?=
 =?us-ascii?Q?RfPo9KIQIYt8kh2eKOyeWQzbMmVFRAlijnl8sPQyCBIkx3B0c/68xARpMvF9?=
 =?us-ascii?Q?sW3baNVXz5wxQXCpfPbHQqYqadNDqP/lYi+MNCmpzKII8TvKn/roN56H1GMh?=
 =?us-ascii?Q?qW83Grt3WWU/22FyFetAYBlTQQGoVE5ok6nJFfrQZOAMAjN4zBnsbLJJ9ao0?=
 =?us-ascii?Q?8txNKnafk9M4Zynx2Ou8d3GZt2voRjPduQXDs2TDagFWWExpBaej7Tx/MJLQ?=
 =?us-ascii?Q?WtAsyaBTlob2TxlnCTox4MR0bxyZbRp8zdS/7XGcXTyjcJB6D9NsPvqM2Qa0?=
 =?us-ascii?Q?ajxJB+toq8aWhQWaxzPWTVXOgu/TcnFfgK35xlaXLS+Xd5baXVEH+nhVkn2U?=
 =?us-ascii?Q?rQcb5qQ9gpHyBl1HrPuWt2OYp3zPqzTakVmODhttHdNFvni/G+z0p9+EaLxO?=
 =?us-ascii?Q?gESeyyuPtxs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sdIcs4xkfwpNnG3BOsx9pjmflgqZqn3Gfu+6pyoDQfeSSUvW1M39bOxvSWmU?=
 =?us-ascii?Q?RcNl6jbnn38ynIeJSwL+SsT0i2k8yojLZ7UJLh/V+2RIwEGxrvVu21BQ4KM8?=
 =?us-ascii?Q?HDJssKA7QLiyUDEyVd7SX3QeuIeK1I+2RnBhcr0vcuiYRU+i2AhZOt+WFfQw?=
 =?us-ascii?Q?SdBoB2zS/BD/LUEhykO2wwRFCuBwBWvY5isghUQzqZ1rSLIj94omQT2u/AIr?=
 =?us-ascii?Q?2/MozfhDVN8Ll07SEDXFXXwFVjJ7U+lPuL4Mujc3OuYWgxaz0ltQCuCbF2vm?=
 =?us-ascii?Q?i4PmmSA3vdgUKEttmPt8SKMoX46CDLxaoUPrdajl4axEO+VuPyW5PaooxP+i?=
 =?us-ascii?Q?MJ4k+40RFIRCztFKrPf2ulewzCzArgMwiv4i8IwDkEKd8OGRBttuZKC73UF5?=
 =?us-ascii?Q?Y1QErPjmMYY+sCe63aUbplq5//KZhKslusYq3oSEXNcJNfR6SI9nB4Ic7GpS?=
 =?us-ascii?Q?eNoCPLKFxhquO41smnt8Up59R6xjCrk8R0JtYdhcRP5AiAEqWo/wP1d8Wikx?=
 =?us-ascii?Q?pi6+SZVLWwq1iemmyZWCA4Q5/MkhBVGxWqF4oaNSgA4GMAjiVDT20BQ5q0YD?=
 =?us-ascii?Q?h42667ctouq7IFVyz7auEcQwyKLmvj8FDGXB9z7bY2AdCw69IxfUpU8qD/eN?=
 =?us-ascii?Q?8PcdXQAIKc2N9pZzRCy1mGlK7vSBi0M8oXREpfeA7KJRNX5mBxxnh4dExKah?=
 =?us-ascii?Q?RSnHvdVudmW2t4xL8ZWtbx6IfkrieVXIuLcjH5bSISy+Sd+N6/YqVfak8DFD?=
 =?us-ascii?Q?X+9uUlS9JGXy5qF18+x27tZTQ9G0W1U/s6nRGHj12tVixBLgW5lMOLyStXu6?=
 =?us-ascii?Q?VX7fMNUqeZ21UngsI9kiG49JOcPk6YkyeJvkt0icpSyjWWGyrVLpqy1qVt16?=
 =?us-ascii?Q?BVYSHfvvZ8XM+om8fy9fKoqHhjeCBvl+QeabeWK7ogzrox26uJM2J9LukpC5?=
 =?us-ascii?Q?z0CWaKnwJfsHuGw9qX1Qiz8WRfnByTc4Phv4LHEGLQXGvdV9BMG5yRMQK0me?=
 =?us-ascii?Q?xk5/7CNh4UMwwBuFdXbjvCp8WD7jLaJ62gFBs1gj7hUcOme9L2jL3q/CqELA?=
 =?us-ascii?Q?ZLdm7IKJzUXPtuVKj0U3T1QPKo5MTXyTwVv2F6gsNoNwwNZ8Mbv85DtSwcXJ?=
 =?us-ascii?Q?Jpy/vchHTPftGb9zOpdWqGHSjQPazR2BI768v/UFA2A0Mla5mXc52aw3KOUb?=
 =?us-ascii?Q?S6ZhDY5Aocs41PDcHQIRxtsKOm3Zj4D4oZMWHcSZx3pRs3XcV3Tr9XAStVdI?=
 =?us-ascii?Q?j2/+F9X2Ghx8Pmugo6m43PkWmg5t5QeSZWXeDqNY5y51kb+ZVWqnPf6eynwt?=
 =?us-ascii?Q?qr0SFH73i2aYzvnxDup0FLWZFgf37KzmTGJIMtD5xBORmoyk4dMJrXKiXGj3?=
 =?us-ascii?Q?vjGC7882O9Xx57aYLX/MpfJnR6N/B5TUXEOAcD0Db3vR8HCinb0Qv3Kr7MOa?=
 =?us-ascii?Q?HQuKIsCpXwjaPtGA6N5+rVGrjjWUGZXlX9Z1Kwyu9b1zRDpv4yw3JHF+3CtI?=
 =?us-ascii?Q?Jgwmp+P2pLjN/QvAwRxEMusyyoIbNCzsxL+L2T6sQaveNJFKsr57ULh8eROg?=
 =?us-ascii?Q?EYsuz7VL/VAJ0u3wIPYJx3GSpi4677rWNSlOsh/z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33645445-a8df-4a10-f509-08dd7e93981a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:10:53.4609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AO3NQwssEzc97MaXnG57GaVsS5uMbcE7POztbT0FxSz0dZ5ePnYRpCNopjUJwurJqrmnvLgqHikQnPpxeVCSlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962

From: "Paul E. McKenney" <paulmck@kernel.org>

The srcu_lockdep.sh currently blindly trusts the rcutorture SRCU-P
scenario to build its kernel with lockdep enabled.  Of course, this
dependency might not be obvious to someone rebalancing SRCU scenarios.
This commit therefore adds code to srcu_lockdep.sh that verifies that
the .config file has lockdep enabled.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 .../testing/selftests/rcutorture/bin/srcu_lockdep.sh  | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
index 2db12c5cad9c..b94f6d3445c6 100755
--- a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
+++ b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
@@ -39,8 +39,9 @@ do
 	shift
 done
 
-err=
 nerrs=0
+
+# Test lockdep's handling of deadlocks.
 for d in 0 1
 do
 	for t in 0 1 2
@@ -52,6 +53,12 @@ do
 			tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5s --configs "SRCU-P" --kconfig "CONFIG_FORCE_NEED_SRCU_NMI_SAFE=y" --bootargs "rcutorture.test_srcu_lockdep=$val rcutorture.reader_flavor=0x2" --trust-make --datestamp "$ds/$val" > "$T/kvm.sh.out" 2>&1
 			ret=$?
 			mv "$T/kvm.sh.out" "$RCUTORTURE/res/$ds/$val"
+			if ! grep -q '^CONFIG_PROVE_LOCKING=y' .config
+			then
+				echo "rcu_torture_init_srcu_lockdep:Error: CONFIG_PROVE_LOCKING disabled in rcutorture SRCU-P scenario"
+				nerrs=$((nerrs+1))
+				err=1
+			fi
 			if test "$d" -ne 0 && test "$ret" -eq 0
 			then
 				err=1
@@ -71,6 +78,8 @@ do
 		done
 	done
 done
+
+# Set up exit code.
 if test "$nerrs" -ne 0
 then
 	exit 1
-- 
2.43.0


