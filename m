Return-Path: <linux-kselftest+bounces-31139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6873DA93A59
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 18:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D25E17602C
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 16:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87257215047;
	Fri, 18 Apr 2025 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lKTnz1n5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC585214A77;
	Fri, 18 Apr 2025 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992626; cv=fail; b=l7c6Dr8hTkMuWWWws8yEgKFL4+O0jX8KSDeDDsAaTH/m/hw3jP2GtL2Hg3QPPhxEddEGvrbYXoZ5eU4Nj3Rr4rEFGIXgVPuqihlFplIQh16oMNPzNIDH6NTbO+VVn5i2YqlJSj3z7LwIrSp8FtoD1CuEusUhQdV3JfjVGi5ixd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992626; c=relaxed/simple;
	bh=SOyhGC0pPN09w4WjbFHrNewdQ+j1R4XL7Ril1+7wWsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y4ZiQkJ710mrsV6wZTINP35VRElokmV4ERgOjEeleNoSj5vWpBYqUPfzTX9Au35C/3kuvJ7F2nytERzu09Gy8/0pStBYEaMpE9I989EYHqTEnhpFsRAlmVZNZw/LnwcIYYrl3/9vVmnatoDloJBexqjm1pk1S/tplWVLhbV+16E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lKTnz1n5; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNS3sA7gAoIkVkjWfGt9OsJrVtcXQEa0IHyTEsRCtVRV1+C/Yg2BoW40NmiiNPyeLqaXSCYv5yX0PSVdOt005G3N575rvt/PlCjFBOMjar8epPBKun8FRn8PgRkCd4KGSTd3KWTfJqJDtFP9vABj6efwsTaJK8ai7eEonSt3UyHhGqWlIG6+ns0yjCyBPNm+z04tI9hl3ytBKK0gGmx3n+7FqMzRyoMcMUoLWuBpI6Y1QGu+1k/eufWDPPmq2KFarTvhYyu3xO9tofS5y74VsOUB+Xeq/SDXA3QMHYTJM7Mnh5+csJp27zwVVObSLtvntceROjm5XtKAG3sSSPTpvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rUryLepTa2cjbLKJkNgaNsPrNToD9mdZ2QWuf5WMrM=;
 b=b0vysPulT/17AhpPlNGooFzBlga+BE0QZadu3vU5iT7AfIHtcCkv7ii0a+Rqb96pP53GIMjUTjTsU88wLWQJD9NQOxxy69FpGAWVzvb2g3nHZu3RVqswu5HSufeUB8yJA08zN2/hmBu1Sy9koCG5LQtdhNa44DCJsaFcN4vdeqhORFRIz+lVZUsIIhEWeVc+onu3ifbr4BIJUl/6qz0l+fuX5bSm7yuqKyxUZeQr+sx4T56xqq0fHGpr3T5BRe881S95UZNgZviw3K0NKZpLpcBL2TkHbr2/i7Y4zF7dwcu2hixpcbe3d7BzCLzfjbF9SNiOUNIPOoesjkRTIMVB/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rUryLepTa2cjbLKJkNgaNsPrNToD9mdZ2QWuf5WMrM=;
 b=lKTnz1n5L8Y0oBDoegTFC+p8vMM1HZFFxQv7X73m5BOoE9oi+VZI31xSjy1Ve8Zlg9Q6QopoAhtTMHQ5T5RvQqr1gHL8qNlzaSAAFYgwmZD6EVaZjx5Mg+7zTDClOiHe6MQ2tTUCHgODY2V5ZSSqaxDOSl6IVVQWKoOONNB7tv5jGyUXTK+nIiOnTMPxVa5sdqgU6/ErKin80ZBkAX6uPI6yyxPXxirnBw96NY1Pzr0X0b7e/LTWDX3RYKbH/WdCKsfME1/wFjFAaal5Bln0t5RzTjTUogs2hm6s77+kXrbfyRlREs/Z2O1kamDkvdc7WszTWqScKj+kN7j6U7GVpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH2PR12MB9544.namprd12.prod.outlook.com (2603:10b6:610:280::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Fri, 18 Apr
 2025 16:10:20 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:10:20 +0000
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
Subject: [PATCH 01/14] rcutorture: Make srcu_lockdep.sh check kernel Kconfig
Date: Fri, 18 Apr 2025 12:09:33 -0400
Message-ID: <20250418161005.2425391-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161005.2425391-1-joelagnelf@nvidia.com>
References: <20250418161005.2425391-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:408:fc::10) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH2PR12MB9544:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df093e7-9646-4545-f6d3-08dd7e9384ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EC9UqGpyje7N50c3n/2zSrWSpdzA1moPTFDodiXyZ2tuvuspcXL3h4Svhz7+?=
 =?us-ascii?Q?rxOq/vvScLZ7xJnD0s7DBYwjjMf8c1CMk1ZpIyaGBwSlAxbLRCfGoHypUIL2?=
 =?us-ascii?Q?zjynomTmRD51todJ7oeAkpw+Bm7DL2fvHGlzCIQ51fm+2pc+uPZfHJo/sqsF?=
 =?us-ascii?Q?2AgEDGt4WcBOTsNSn5ihRCBGU21s+YP64fHEtutAYLVAVAnZzUPSm9BVd62Y?=
 =?us-ascii?Q?tyRO27dhhKYisV3Qbz5LmOk+vquQzhHwy4GvmhIGpWwp2x0GbFl0zNLgLOv6?=
 =?us-ascii?Q?sz7z/o0ipSNxz0VpeJY9P/DZphroCvp3qcCv72Sdh4b1m+PmYePDpBPePzon?=
 =?us-ascii?Q?/KCQCMb0HRBsf7HcBfM0k4ELwfruU+JP/4BxIXWLAJQ2RU9A2Xt6Na90rmuv?=
 =?us-ascii?Q?BNo8/gmLtfxsoglrNsz9moXNROgw0p5UBvUMHwCB+/ymKC0Gf6ODd8W6tPcq?=
 =?us-ascii?Q?1wPeiYgyQhRzhMmf20b3kgyKpSzrkEvNFSbmMzXg7u1fwAZF0oeEveJy89AR?=
 =?us-ascii?Q?wqYbHrVmfHYIFgdCkXC6+FU8xnrjEL9z4qNlqxs7GzqzHXusnEhLDT1lhJv2?=
 =?us-ascii?Q?K6gNG9uoqjVtT4Cq8g+L96/yRUZFDNbnnWAOVag7dz4UNumzfpGB80YGUCZr?=
 =?us-ascii?Q?dzTGxeUP/TCMgRjbvzN+g3Kh1Rt3OnjU0vBmf4HxXDXvw+tm8ftmxhurxSP6?=
 =?us-ascii?Q?OilaHmlAeyWFJSWdN6pZoJKhM+aeVq47Lx4LJl1swjxt6YGixarf+2hbOe7P?=
 =?us-ascii?Q?/YQp9ehUIE7nyfrye35usiiILh0zivvq+zGi4u0L9N0L882/sOXBtxa/52sr?=
 =?us-ascii?Q?2lippPiWP1v9SwBC8uaWmwC3dEFA1NNI5ifUldq77lpWCkVp62eH0Ey+Cim9?=
 =?us-ascii?Q?MEIPIYgNOykgny5MMw/09ovh0xCh5NRXtUIqh/w1p9fXk3YTRoAcn2goSU3Q?=
 =?us-ascii?Q?zqaj1umAecuDBbO/MoquLnkTM8u4zvyc5/GxCqI7mRTkPW/Vz0UNPqSR7QLi?=
 =?us-ascii?Q?S9nDy8S8T+svhrE3LlKrxQ7WstPXi1w3gTQvs0uf5zzFTmYqRHlB6CqG0kRA?=
 =?us-ascii?Q?fSg/+kfPBhzyErerbhaNaez0mosXEPcEuUhBB7Z7+TgRogtmhbTwWKFxjbmn?=
 =?us-ascii?Q?r86kpol6WR1G+TRBxtncDI7W73NB91isepLTwTAkqeKst/7x1O7euPZvV9Yk?=
 =?us-ascii?Q?nVm9GmVxRUxL+BEXt7gbTcGsNuUJM47oox3r/DC9IT4yfcis82CgsDqiebor?=
 =?us-ascii?Q?7M1JOkQwUNCl+miQhKZ9xhNe1xXocIoZ/oLH3LrX/+D076cS26tc2FQ1rVVj?=
 =?us-ascii?Q?xhCLEqy0436u/oaJozrQyEAB4bw6NQR1z7Yim4i0lDpZCsnLArxRE3Fbhy8M?=
 =?us-ascii?Q?ecZ12lkLh8JXOmsGpw/mQnHO9nG1ChxBKmASvoEot11sGRyDZpvaI6JtGSMV?=
 =?us-ascii?Q?WIXxSgPw/Kw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H4WZ4L8FWSOyDs+N1CN+6Y4KGtLy3mB2u10fkHdqPVYfRUOZo80OPdvwPB7v?=
 =?us-ascii?Q?S0ZOVdPFOAW/AEnD7rRK/CJADne+IMqpKCjLaPjYaquueTehyDsO8CRT6DG9?=
 =?us-ascii?Q?qjZI9G2GzlR34YlfvCcl8JbGrpiZuOy9J3zti/VHv9t7Qkgbz72mks2WmmzG?=
 =?us-ascii?Q?R04sdqyxwj27Njym5lNYdtnulqH0SjHiHZTr5rsq15XKdbZiJESHfghS3C8V?=
 =?us-ascii?Q?1oXwKCQ0Fm1SSnJbNK+QiiJdbjuzkIJVHJERp3MXk0mJ59+VeNbJ1sh3k2t7?=
 =?us-ascii?Q?qNmEu+lSTwxaFmRrxGmFKFPnnSdr6Fkn7GaLplgFvGailvJWvWmYBNlbRYwO?=
 =?us-ascii?Q?xT7qh/O/7DKfIiZd9Pdv6r1xxuF6eJqkTAQq4gA1kIur6/LQUwKl0+MyTHI7?=
 =?us-ascii?Q?WSQz45syuXxc/B90dYyznJ0EjAy3yFNWhzW7QVAS279xkMbgNBFOvLs3KW0a?=
 =?us-ascii?Q?YUlQAs4FyzmtZU/IRY0VqJhyExhA6C+OeHZSa23vjkjzJZgzEaq5BPlph3tT?=
 =?us-ascii?Q?v4A8DHvCwNneWqvVYXM/qmzGRS4Z+qfL6z2eNFKkQQjkbGCF0/FYNacDygV7?=
 =?us-ascii?Q?Zhx51uif+GHe5AtlVYOx0x3Pqnz+bG/dVpNozZsJgttBDMbz1Qd/GHVzXARd?=
 =?us-ascii?Q?nWTHpsjC2svJkwQKIzJwReJh17556QUxiUkFK95aSSzYKZ7cAqI4d67gIlHP?=
 =?us-ascii?Q?Vos/IhH1UySyCXfpiF4ERzOMsLsH3f5l03rKcSqplpbWDeZ2XRTBw4vNoMCf?=
 =?us-ascii?Q?uxKz2FpaDFrLcjikC1msSG2brMDdA1JvgBaetP+CkfSiJiJooX7lM9LVU9TQ?=
 =?us-ascii?Q?tHwe0zNI7HhPnaN737YVaqLoS7GPwpG+Mn69hZw3uWVp9N6Z98lrqhhgGsEa?=
 =?us-ascii?Q?4WK829FXOPqpBFd/YvUapbl3H3S9HchEA5zm4Lqk2LkpHrZ3lgG/pVOZZWxo?=
 =?us-ascii?Q?NZcnn5gMapG09cP5wrS+xs9mjkkdOrWRYepswr9QLjh/Xaa1FC+yfD3L9Clc?=
 =?us-ascii?Q?NHZM4OvYo0cQtIVYD/h5WYXuu8XC0PHzIk/qVojF4LVOwgM1AgF8IwNEj32C?=
 =?us-ascii?Q?5vI+6VTJ46lQDWhUY5nwK8xBy04Omu8AA2SHi8kUO82AAtw7hH9LQMG13eHm?=
 =?us-ascii?Q?WLxMus+HufqLs+vbdS1zjBpyCsPfxibWq+ncuCSe7jmR/EalzcPxqsMF5ikq?=
 =?us-ascii?Q?sAnWDw5SJfZTz0UrMOOvyK4fAMvnqJYs28q5J89843wcO7QmEziCIDq3PKZb?=
 =?us-ascii?Q?If441ZlwzVagm887UrO94BvKoWys+s/tUbnoddR3pAzEkYSfsYsdoR0aQ0nb?=
 =?us-ascii?Q?p8Yy2v8ENXMDRhmSzNZtwz+//t86sBB9bSYSsHvqfWwaV4zCfVOQkZecaatq?=
 =?us-ascii?Q?lbyUczNp7y7Ir7acF/gQnlVjDtq5u7/3BITQiRPLL2OLghw/6VEvnlZWknn8?=
 =?us-ascii?Q?lWfcV1BqcX/j8tygGM8kJZtw+wiBLHk8MKGncO8YCDrZB46LJwmutmWOWrHE?=
 =?us-ascii?Q?KOM04tSSNLRzOCTLwaR6EEYJU+p5ERxuwdGE0xi4dhUq97+3rOkpU2DZPMmN?=
 =?us-ascii?Q?1QZspJ8V1U5CY38q3Gg7IiD9YHAeWlh/JSBYDwIF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df093e7-9646-4545-f6d3-08dd7e9384ad
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:10:20.8526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AgyiTkgVyeu9lWq+4MKliIADqtGm77qybLByjh7E5aIGx/wzM2l8nuMFM44La2Fxg6AdbwKuCjZ3n6BqoItnpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9544

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


