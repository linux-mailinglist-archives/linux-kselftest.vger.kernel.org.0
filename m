Return-Path: <linux-kselftest+bounces-31146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF24A93A6F
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 18:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C8BD8A1E3B
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 16:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C96E223704;
	Fri, 18 Apr 2025 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y67sZ2Y5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29C9222597;
	Fri, 18 Apr 2025 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992661; cv=fail; b=iKTAlrYNNMjiguYX4bRIglv7UUsVSt5w53eV5tx7T6ugi691Bg/ME8QEHaX4ZZZZGdbNY7aJjHa4RXcr1ghveWyhwr2reAQaInuHnjVE5Q1cqTClC+2trop05Z9Dmy1gIBrBzzLxsuBIbYC6vYo+NHAQsvJqEbnbxRMfujC6rx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992661; c=relaxed/simple;
	bh=KEl0LBnU3WQsJrO8Ldcb+Kpi365bGlQph3n39vakKK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qPp5M2eo2n9eWLZur+rmUED8gkirnk/fe/6xktnQz9PaWFAjS5zt3SxR1wo6SpmxZVu0FhLhi0SHTmwlXbK5H1NKjTheJlT6uGKraVIZPbJcbIfa4H7Cm/8RDEXh9l6a8E0t4eLfDUixBXrbDOwJh9AsUL2M1lUtnqqihn9Kgys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y67sZ2Y5; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGuT82YXUlCDQpQrLaxtanF6A/VScBj9woUFShSSNJ3KocTTviyZttwTXPi9AuOuFtUbkrzn+D05bUGGvALLJOSheY+pwPK19DAHze8lak6iCINI62ZERJ73d1oPOtD83VK43xsOyZy8dEyqz04zN+METb5HiH5UHzlMK+2KE2Vj2NYOxf1y6PJm0iJCZ6hIPKKLdjm7vIFgMX7Dth9z+ElA3dJcCODe2h93y02CZoLSHPRNpKwZNG5UQ1t6F65NVMOQ/MRWPTgot0j4gqZ/2iBYDO4DaqsmhrL3ojAgu9WtFc0owgPwQiW8Ug5sh8QEqcBlJ8HCUYWfsTMx3QTGLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fcuiC+7oyaqYgvXhDGY6OiNa386pzEP2TCloKjTN1E=;
 b=oMtq3uFmSeZS/y6CW1ihx+U7STExCiyRowIL+Z68c0CPzvZVeNnzMVrsVzkoK0OhgX08ZzvdjEAgNPlAMnrdsJcuxBEhO/zM6bd4oJmijSqewmaqU2iH2JcOQQk2Ie2onUHMHKaqQ4M3dvLyup3cwEvPDoIbGC6S2VzeNq3xE2Pjt8yUDxAzktpLRdicV2AuPZdZW1ioSEW9JRXadHlOmJl19LCdx9P7bFuNEIKdCaMiiNo5OcqESK5iQpoey6m2lltSLXRXkP00qSuWyFdBf9w/SKRiSweSU37n/R5p0KkeQbt9Jgn56DSxJIxsf5PKjJVxtGUGC0Bm7pv43WaFCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fcuiC+7oyaqYgvXhDGY6OiNa386pzEP2TCloKjTN1E=;
 b=Y67sZ2Y5LHrGQH365uPmO8LAg1WcguGVZ+8vkO1zo40JLS+iJTBR/0CqG7rhYRAaySijm100V4HvFuCoZgD1PGxyV61abUqfthRej1biwmuae2lisRrTo6B2k+khgC9KfTZVChcljpbe9YxO9Yo0gLKSHret2d+a+g6cEt8sO8TOFfN9kKhkmEPoGXklan7TDFeyH7fWXDWs1C553PwroU7WkJR8FABrNo2lwUb7WT5lIJJCvecSNmKGs53yO6XnhjM2sC1YbH4oPzFaQXE1WOtFbO0khAmCO7IM9uCO1n0H5ypMM2SQG9/OrGMqTulvLUQwALKzR51W9wFOJZR/EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 16:10:55 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:10:55 +0000
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
Subject: [PATCH 02/12] rcutorture: Make srcu_lockdep.sh check reader-conflict handling
Date: Fri, 18 Apr 2025 12:09:48 -0400
Message-ID: <20250418161005.2425391-17-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161005.2425391-1-joelagnelf@nvidia.com>
References: <20250418161005.2425391-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:408:fc::17) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 394a2887-0f1f-4a92-38b7-08dd7e939951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KPccYWAp0ikPgT8Z+ATsoeS9E+4PS8Gr+zRClmsysU8g2kiX+Bm8DUEFjxSq?=
 =?us-ascii?Q?8yeFET9t8NkyJLOvAh1fhiPGMyRUuK0t8P/8Xo0lwA0nnBtKBAFviI062rtt?=
 =?us-ascii?Q?GrFfbHAKNBTqDO1mR3OxzMCQi+GJHWXjKLl6Awd4UnKAZ5/m8ivad80ouA7l?=
 =?us-ascii?Q?/W9ZuIvVyWLTfT2TE1im8n70i4f2WEu4MCprSXJZUvT4TzmRn5+S89BFjxMb?=
 =?us-ascii?Q?IWTRi8hmtgWKDqPKXrkcrfLHJ9+5zu8T2FZea06No93I/hm+dSeXiAab4w0j?=
 =?us-ascii?Q?B8dgTR3MG13Tl5eK4Y1CwDk22sn8I8TExuV14K7hDovkce3nUyv425wuQHyd?=
 =?us-ascii?Q?4liQ9p131w4dn/QFp8mv72PoY1c2E/4bn+3h3k/22VKgtDkHXa7g3F4KJgK9?=
 =?us-ascii?Q?3R0qra+9N+B5VTTGfIGCKx0XkBU8DX2X97QMyrSzo+xwqAi9QYvxsSbgUXgP?=
 =?us-ascii?Q?Xz9cf+Ub5WELrRIll+Kk3Kwa98pM5/9HlR2/G0HM/m3A5kdb7/mKE2VtrRuT?=
 =?us-ascii?Q?puPCYEWZc07XNR+DsHl50TFAVYuwdoiMRXmq66XmbQbdjJpSHl4Z/UOM0WrQ?=
 =?us-ascii?Q?YDdzN/ZNLwmCH11jBAE1WP3+XHUURE6C1TONQsPnckwD7MukeUXSplRUBqj0?=
 =?us-ascii?Q?2k2zkiKxGrylkwgcDhq/vyM98d21SNSi6dvN9djLodLQ1BLBtmCvhQdjt5Wg?=
 =?us-ascii?Q?f8Sp0dNSuhxuE3HZ7Eb+MlNxC5aLsC8rZDfe8PYge6YTQWBEDPrN7OpLuCCY?=
 =?us-ascii?Q?RqMhT44dKvszWzii8WZ34Y+cgGiHV9TUQ18YUbhu4aE7u+jopBAtZmJdrkxV?=
 =?us-ascii?Q?nZnhsArWB0AJzDkNtVomsiQuw8VsrHtrcVUmJ82PYCvLHa0nfe0wVud84kdl?=
 =?us-ascii?Q?o1C+yAsVavP5s7J3DBESQmfVLLVNL/4QeCvTMCdm8mMnjWLbM3BYIBIbm2w2?=
 =?us-ascii?Q?uDsbIYBTZ0SlIjlgf4RONkOgyGJe1+oad+aO7aeZusm+1kQL9FV8KJq0fT04?=
 =?us-ascii?Q?EXPTrEbcu4PkqJXsLftoBaBJulyE+SRJYR+mg1OvE9Q8Ek10tkXXh+Zv8eUE?=
 =?us-ascii?Q?kWUhnBEYoSQkGVpdY6tUWIBNCgsSYXl+qt0lPHXnyA6SNg7ZBY73ngr5Ha3V?=
 =?us-ascii?Q?e+Ykxy4WS36U5OMyzKpV3fzKpH77vODusbLyILLHt6Gmog+6xwObW+vpbf1a?=
 =?us-ascii?Q?nrPUOTA22FSxErZFdOBeGmRcOOAA7dkJUzPuEwaeGzTfb9Ege1SULzWj2vnn?=
 =?us-ascii?Q?m/mrT5431gxjLwq1HtelPQKaWdQWWkWs4qqxZ5WAeEXtjXV/uFWWYnBdX6oS?=
 =?us-ascii?Q?3pX7YQZqlwAfH4Fis6Qr26N6A8OtffVBr2h3Xoz+j4NNPwSReFCd7VSk9MnB?=
 =?us-ascii?Q?/PbTq9EFlGuJACphe90B7ZtUzPMn4V2rAYZjU5vDgBqa8/3v3MXsddOBqm39?=
 =?us-ascii?Q?+wXQL21K/UQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PdU6bjSuTRmKhnBUT6ktXo7NqXMI+PRnBbYCiOEbbwv9VgrCi8JaKWBiYdHM?=
 =?us-ascii?Q?VZsJsPkDrlcZe5sULX8a9tQMO+NPoNYD3mTwfmt2pRKIWwFGK8HKbXrTPCb+?=
 =?us-ascii?Q?wS9qZj/q1eh+R8NSdZrAGaEyh6TtPxl7oYb/4DIYDtPS5REYuPjGBHZaDFm9?=
 =?us-ascii?Q?bXQYcNenjsqQhFl+a6tvoFH5LcZ061Z6/wEuZ+ySl/cabSpioSlYcyySnl1m?=
 =?us-ascii?Q?KLKoM4vKjxBqpzyZCq4/NGSGDrsAZ7NY7higs/S2IGcx6357bhUOYhur4YJb?=
 =?us-ascii?Q?fCfmxFsaaOYx/bEQT3k5x+unvg0Ko4j6oI547ai9ibxEMqSyvQq9gMMtYAIP?=
 =?us-ascii?Q?LOVbGwdRLvugJPiAXGCsC2/Sgho6pFIA5I4G4qV3S92UcwmwLH3WbyT0IRKK?=
 =?us-ascii?Q?4gsWpWkAFMjvE+w2W3dvkyUNHFCMtuQ+jgY84xNmp1IXrUiG7U/s92yxFrrS?=
 =?us-ascii?Q?6O3Zxx1MlG4bujZxpf7cfP87ruLJRtmkGUg0zJJ9D5cpaHCvx/upeyHLhJBG?=
 =?us-ascii?Q?MqSGqL3gfw1wN326Jfq+ziCW8GygEtlF8I+mGc6tMboMU47XN8Lwseno4mgX?=
 =?us-ascii?Q?YQ2FBs69fspgWcxebXAl+3gqvuXvTQ54nmNu/ZFec6pz/aHESqM0fH3IrUbu?=
 =?us-ascii?Q?+QOzm7NpNFHsNEmV1bwFnaoCLVqrw0s5cGmSb/HK+p32pKeTntOxTmLik+xZ?=
 =?us-ascii?Q?DEWJ9QyN/gLHFs/YNc21gbRDc6IrO1w1M7g2Gyxwm4twSHnQEaK4u1SaRNCj?=
 =?us-ascii?Q?JqvvBEA8lUHSXJFsv8kjo+3o7iKkmvRGiP089JTEy062iKFypF4k/e92ws+D?=
 =?us-ascii?Q?BJMeXPtxlKUSXDffTD5b1B24mVX78JN8mvWvYu6wbpnAUmfR+Y2qI3pNdcYp?=
 =?us-ascii?Q?/Zn6APXlwJsXjbElZkAK1A+dJ/BhEzcwUu/yz4j5q5WKV/2Du0TXDEcJ3FxU?=
 =?us-ascii?Q?JrMA4T/FJoWSzg/+QFWb8gr0iIINBXiEXa9tA9VyPqsV2Ir/2zvYpyDXxFq9?=
 =?us-ascii?Q?hciw/X1OKkJ67R76NXtV5yec+prp8TT24irCtkoee8Nu3t/d1foydR6Ts1XO?=
 =?us-ascii?Q?drc+LjC3UkIm4YJXwJDSjnpzGiuXT401iCHW6OfSZxI7+hY6Il1XeJJ4YK1j?=
 =?us-ascii?Q?He6Z/bE6/qbx9ag03L/k2Iv/gN6uzl+SqDcS91NNvvYBV2mtjJxUlyDpomS1?=
 =?us-ascii?Q?Pu4BwO1PEsvgmJ8HM6hyIYgP1bBx1PNmToLRKg2YKy0MLg2iL66dhakRNVNZ?=
 =?us-ascii?Q?DQDYiyrrdXfX07jfAhgC0Dce8z/H3hJvpIHE+4kIpvkX/9qJdV2ZUmKzrg7n?=
 =?us-ascii?Q?Ea/0qRgk6S+tYMmLnjUpilsPIT2Yuyh+whLRKwqA3lieOAW3oPl4u8MqoDoX?=
 =?us-ascii?Q?YFKHHmHdf66glmFGQslaht9NR/+PFlwJxXy4Ov2brUdRVCXw5r8Ko50hDzmf?=
 =?us-ascii?Q?/pjJP6p1OeA+eOtpfado2A8rNQ1s4f62g6x0TWXE+S8KC3OcNbfG/TsEjRlX?=
 =?us-ascii?Q?/SctyvQ/GZVXDqBqlL/c8LvwTumgNScAGko6c/z6TqRsLKtLGs7gZwQr+4G9?=
 =?us-ascii?Q?MiUXyGleFfI1bcFrcf/glNDOgmoX+u3C6x1Jg59L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394a2887-0f1f-4a92-38b7-08dd7e939951
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:10:55.5018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ytUpvSbhVRtGcEb+HMeI9Q1MvlqdlF0WhBma3SGKOS+nlEkGlcOSEtATfsUu0xWWC0i9rKSRGj1/s48UqN7SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962

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


