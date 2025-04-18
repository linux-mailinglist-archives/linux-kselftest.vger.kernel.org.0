Return-Path: <linux-kselftest+bounces-31148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92640A93A77
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 18:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A99BA16DBBB
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 16:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7139422A7F0;
	Fri, 18 Apr 2025 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="leCyWV63"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB71A229B38;
	Fri, 18 Apr 2025 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992683; cv=fail; b=Gb8MyqkmVDEft5kM5cDImWmpOxFitSz93jp4r+k5iXqxUTI/vF+oSnHZIkLJPb6Mz7fXYzjqQTYbevK6q9QWVAFQjg41AfkcwcJwxY4LWv5798WSzDqYcZa8venNgjE2E3SfZ14+SLFCgHW4P7eh2RpBJRzQqkHlidh4rFdLMVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992683; c=relaxed/simple;
	bh=wD+2hf83OG2V9s+1/BD1svW8xAvsO0cZ/3ENfzPZ5nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gLbB+2cOyFjQdCfsQDLyx4e+d0GXUahppPXLLFoYXKa1lkW/xX7j4TvHyS61dk8iefVsDnhLe7mkISAQltVfooOY7mx2FEikrInAJ3gjkMlMxs9pNoLFwNpcLU8ZP9yd2UST6MEJkdxfYEJC9TYR+H/pQHsndzx+IHZAzU4PZ1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=leCyWV63; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCMJEQv9eKQEswiBOIyW0O8B7t2o7ZbvmIHWi3VSZiWyULQ3KaySoSba5Pq8Pebb6OuW62QUZrZMY4MfAcGDDLJFGFjI8bSC8To9TxD+ghP7NZhcBlfnM+sK9cpGkf64AvEhzzR+3t+BlofJ3EuuqB3tZzsSuBT+pK7lE3EO7s/xqLeoEkymfd+ZJYUeh6g/didJYVQxNRk0NzWXmE9by3iUs363/3ee/vWBJwse3LUP2wpScqU5BOIL4ecPM5YQNk3FjUI2SLoy6icV58BwB7EI+32CgHop1B4OSEJwnjTZr6P3lmW9B+lkfTxNzkDd1R7GhnVuhEGB1E9WHMCjRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IF/aPlvKpLBODosPwdlZr5OhaVuAad6SClh4d+Fkvpg=;
 b=TUGcuKw+Cfy0ryGd2BscfSrflxBNen2Ro8peWF1abEgVsNp+pSy8tw+xJ0Q4cDxlYr87R9/ioyObmSZI3Ev06VMqU6Q7VPK+vtzxYroZrEUy3UNOT9NUM4isk0ZK6aYJRz4ftiiZv1xAM9HEvhwIzm4jfUkz0J3GqsnZtCsbmQG5k/sJGlbg3yTn0n9AEcFgFUDmx91Lvei9CQNKayTDNmgrpE0v9nTywKKxU+rM/hBd0eRFpZR9en1K8jGC1OJgRtU8C8vZa2zSZKV+6u3WQy1+H8VQgsXWA6E5zCb5V5ew4fXGwBnK7XkFAueXv4mr6MfmsopsOEiWLVLmiNGIAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IF/aPlvKpLBODosPwdlZr5OhaVuAad6SClh4d+Fkvpg=;
 b=leCyWV63Xrhr8/rL9ZHnEy5LyIqRCvvjRfJdEBP3ccNHN99k101TyshMo/5ePwMfK2D6DzXdgIhp54xX+UM+TvWcKAfvtfXSzjJK6nvV6eJnZ6Y4a/uRt7p7YMMJRmBu8o78GiBoZXoZA3ojHikYsah7bcbBBU2gCnPfjZkWxAyrdGTuYIqz7TVx80GnAyomM8T2airiZ/v+ynLiiiU7yW88taYxghafmu82xCxa0Zva/CciHSQprZ6fVYRN3DSp51baRY53u/KKOBnST4IvWxjnsf5y2xU+Z/WWX/E0qpV3psNXCZthKgYk6srWMn/4976P9BO7W/66mb+YwNo1HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 16:11:15 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 16:11:15 +0000
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
Subject: [PATCH 11/12] torture: Add --do-{,no-}normal to torture.sh
Date: Fri, 18 Apr 2025 12:09:57 -0400
Message-ID: <20250418161005.2425391-26-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418161005.2425391-1-joelagnelf@nvidia.com>
References: <20250418161005.2425391-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0167.namprd03.prod.outlook.com
 (2603:10b6:208:32f::23) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: ef1f32c4-46ef-4bae-f208-08dd7e93a562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gePRPSBSGZYtlBRsVOILRMyg0o6vUUmVP1z3YR3DMcpNKzdtklCPzgmhR8/6?=
 =?us-ascii?Q?r/OjTpCfDvmOStl4omHRAYdqb+aOdcVf4UugN9f8UJShm7KgUenV1UMBxifT?=
 =?us-ascii?Q?Qgq8lTFUpN5whqeMq/WDLhRMyqW0p45wwGy6BYBnbj1K2KxPWT2RtsR0hWuF?=
 =?us-ascii?Q?Psl/R8SEcj9GtUWmzd3RQy/nm37XQ63XTasgS/wEiBxqNhq+sQPYTunSVghh?=
 =?us-ascii?Q?Zz6/Tu8XDziPwe/pG4ASGzBcTzyEi4dlglezU+3/kaPwkFFxm9g6G7noBgpJ?=
 =?us-ascii?Q?WzyYSwSRq0pbbMRrOpCXbgp3W4HPo6BtU8toH5gRYXo7QirXpWRwEocpL1G/?=
 =?us-ascii?Q?RUjkDtFMpKC9d8rlqmagKsKndOq3xYWkSzpuvQGM0P+A2RTxFMlFaoLA5uIP?=
 =?us-ascii?Q?iwHcFPNZhL1V45urPs4tDpgBd/XukrAtKPXX+V2slYf7TcO3OBJvJmbUbEuw?=
 =?us-ascii?Q?cmJxDz5XP0Yt6RY5URQMl3BlesSPZgn1TXM1BM7/iToVh2OB404MKlsZnF7J?=
 =?us-ascii?Q?hQzAiGVUN0zgzwmkRYlUTMA3tSiIdrztMkoniB0poPE0EhOpLvCXLNgoCOjP?=
 =?us-ascii?Q?HgtVsnCbJg6UklWXDzubNrHa4ljUZk10Sv3ECVmTXKSxYMkQp2Lc9bjiqbq3?=
 =?us-ascii?Q?Ymp2sPb7aS5nuO6kQL739FTqYz09q5p4LU4oBDiVlnMILm7AUIcEN4dVu7bV?=
 =?us-ascii?Q?I+esUhkbcWL0YaGxa74PRk6QO4TECEgP61LEJOZkJCHpJvfoWEKy8gABYctE?=
 =?us-ascii?Q?uhmnqCdC6DIxHtdkSEJLljuEp2u/Pdth0zsud3ivPTvHlZWwAghJFt8Pehlo?=
 =?us-ascii?Q?KGAtki/H9Wg/ulCFpFGQTX8OSa3y3y+VJPXoiAXoQ64YGe/DWE85yI70o5yg?=
 =?us-ascii?Q?1si/kE2Fvs2SSXKenmkJduj4k4a+qLmF9hRxuOuFOOpfM21NREZ/Cy/s4rTB?=
 =?us-ascii?Q?shGm8vPzzT1TihSOIyBvuwZtpJeX0Mcx0r19KD8XA2uTE39aR5kTyZAQEAD8?=
 =?us-ascii?Q?DEVMCaFnQHNmph0TDBYYyxcD4kDe65cHbEm4Z3fPN8z13o80M0kIIdjZb7mp?=
 =?us-ascii?Q?FAGbm/zqegnc1j1uc0rmdO9pf7NGzFwdf6Hb1pp/iJPiGlRFNgfhizf8c9vs?=
 =?us-ascii?Q?SACvIruty17/lWLVRivL7MniRaFgkSSh6uzmhgtgs25IS8hmYv34ATHnJU33?=
 =?us-ascii?Q?pOSeKF8SuCmTpMbZtiX7kUINOH5N50gD45Rv3YjLY3gucFItXP/lox0+7i/z?=
 =?us-ascii?Q?vtP/Bs90NqX1GcFHeNACa970FfOudIguRbmD9+KaiENO8TTG8u7He2KTMYL2?=
 =?us-ascii?Q?7zIBV+VLQi2xEGPGCY6rL6LQEZaPsL7HNEYsTHjD+fBZFXi+W9F1vgnmAeKD?=
 =?us-ascii?Q?mLyj7hPj0i0kBnJMVokpyk67iWdrhg9aQOWbnCXKgIFGhkatvg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7sRfjUYpOEfkDTuHw4ZsdHR+Bx6vQ85W0cif5z3EdKiWCUVrlzF0FpF3LS9J?=
 =?us-ascii?Q?vDPONEx0xEEsZdsybw+r5dyvgQYWdvHW7BIOsvzHRGk96jfH4X11fEWKKkml?=
 =?us-ascii?Q?5VZksT3cD7QlkJqy/Cm56otXoz1aZ5mAgwrABuBHghGthYcObax1ycbI9Ugx?=
 =?us-ascii?Q?9QfXcNuC32X7yUrDdNqa/R71oiaak2xDlRfMWMBCt5Pl+xfhSkpgzQnr9ggy?=
 =?us-ascii?Q?io31lNuYuW7AU9cXeWz1R3W23EiSJpdMYhzPa70JXiTlutqrkQeFHbNsAkrc?=
 =?us-ascii?Q?x/tc5JuuIJ08c5j1hBaz7M8DXeY1Hof0eqdTZO/UUD7LVY9uavcDr6+Bd1vG?=
 =?us-ascii?Q?uWfZXACedvmAPtc6zIuQBsB9Gl9HQh2DY2jrnuepqsvdHTIZY4wvU8y/IRjp?=
 =?us-ascii?Q?hAuRhG5BnK16xef9h/dPsFKTjcQCy6D3LYdwLFaVV90B6RjTjEyWlGUEh3iR?=
 =?us-ascii?Q?vFlyHHv1EdbtQuobnWUcENJ1fk1xwNf4/koYoEDZdhmA45GGm1xzMyVOWzfV?=
 =?us-ascii?Q?thxkig9qEPsyXKrxZnuSQq0v7a6BUKJSB53vwiBkPZOUaYug9pTgt645+tSH?=
 =?us-ascii?Q?OBbjt+aWykls608gEDIUd5fNUJlqKcumJHxeTwq0bNIUKeo5hdnnlUSXuSKw?=
 =?us-ascii?Q?aPcii7CgLyJ60RrrH/lomnJkS+IL+lj2oxYCOshQue33Ig/OrJ6TSYsGNZCJ?=
 =?us-ascii?Q?0vc7nhxf7gd1bcnjYSkESuMnl+0cF95VlG66QpvbiYwiNqmxVPO/+H1Ru5bf?=
 =?us-ascii?Q?BuIxkyER0Kn7xvHo2/zjwc/iQdPS+/9oY0pCwRTouKRi+n+OZWHkPCLHGFXG?=
 =?us-ascii?Q?I8oETWLY0dToWmnInBZtwH42rfBqFjmdP0GaAilLG26tRQnmICLw1OYDjhfK?=
 =?us-ascii?Q?VHM3S2f98NHy1LdwHoeCvNC0clMdystNlVD9VLtRCiybjYMor4dzNvcDozut?=
 =?us-ascii?Q?R8i3v7VOJY7xDpVWg2p2PUdkBGSj+tNbxj+dPhMVwfQ3fxXVGK7nf7Ta1+FV?=
 =?us-ascii?Q?yNossisBpunkLf24il0a4UbvIPUtnPKjkKkPn69lVjSDn5FaWqviTB9aJNrB?=
 =?us-ascii?Q?LOUtmv8f3jedMpjFT4xDbTbc84PPwJlSj1UR1vcew1KWhvUhGHdVCSVMpLy4?=
 =?us-ascii?Q?OnjnE1LlYOjnpRnHhvk0rBBso90STQUlDKhIgAnFpvTJ4/9NHqx/xiGhLrdQ?=
 =?us-ascii?Q?iUwTU5w6opZsN6lNtw44DSkN1rsgkgbFVvr53tR1kgHa+mcCcwmebj80g8qi?=
 =?us-ascii?Q?RlHApJ8sGD20V4jZketJLpFRghRKBI04Nr5JuR61O8znOOREk/r6LtE0lswv?=
 =?us-ascii?Q?kHvix5mwYXK6GcHa+s40LM/pkbsrYkurzIf9gF5DpykfIrCSo0dCC99q6D6I?=
 =?us-ascii?Q?3tb4Pt8ig0kfWXeSNDlSK1fWcjUZvCHU8pbnfk/diDDaiM6ao39T69Bpo0e7?=
 =?us-ascii?Q?ShxGTGyI3eoW4OECEHLhI0WGiyI7rvDBtXNEfQAPgphPPXDVUzJsdoBxhYmd?=
 =?us-ascii?Q?JeejT4fQClYbGSol7gopNQUu1MZedY7hZrzD4TYJtoR29bpD4x+aA8exB0nE?=
 =?us-ascii?Q?ueJUeCrHYpsAXI2z3Vr+lLQ6mO1OB+WqcjwOBacZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1f32c4-46ef-4bae-f208-08dd7e93a562
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 16:11:15.7565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5NsV8FurT0NOtu6zRjl02gJscS4BiLibVj93ZqWmXMVFrIIUZU4tfTVcLaC2DMbRtEu2/AOttqItrHi2EmPHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962

From: "Paul E. McKenney" <paulmck@kernel.org>

Right now, torture.sh runs normal runs unconditionally, which can be slow
and thus annoying when you only want to test --kcsan or --kasan runs.
This commit therefore adds a --do-normal argument so that "--kcsan
--do-no-kasan --do-no-normal" runs only KCSAN runs.  Note that specifying
"--do-no-kasan --do-no-kcsan --do-no-normal" gets normal runs, so you
should not try to use this as a synonym for --do-none.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 .../selftests/rcutorture/bin/torture.sh       | 30 +++++++++++++++++--
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index d53ee1e0ffc7..5ccd60a563be 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -51,6 +51,8 @@ do_scftorture=yes
 do_rcuscale=yes
 do_refscale=yes
 do_kvfree=yes
+do_normal=yes
+explicit_normal=no
 do_kasan=yes
 do_kcsan=no
 do_clocksourcewd=yes
@@ -128,6 +130,8 @@ do
 		do_refscale=yes
 		do_rt=yes
 		do_kvfree=yes
+		do_normal=yes
+		explicit_normal=no
 		do_kasan=yes
 		do_kcsan=yes
 		do_clocksourcewd=yes
@@ -161,11 +165,17 @@ do
 		do_refscale=no
 		do_rt=no
 		do_kvfree=no
+		do_normal=no
+		explicit_normal=no
 		do_kasan=no
 		do_kcsan=no
 		do_clocksourcewd=no
 		do_srcu_lockdep=no
 		;;
+	--do-normal|--do-no-normal|--no-normal)
+		do_normal=`doyesno "$1" --do-normal`
+		explicit_normal=yes
+		;;
 	--do-rcuscale|--do-no-rcuscale|--no-rcuscale)
 		do_rcuscale=`doyesno "$1" --do-rcuscale`
 		;;
@@ -242,6 +252,17 @@ trap 'rm -rf $T' 0 2
 echo " --- " $scriptname $args | tee -a $T/log
 echo " --- Results directory: " $ds | tee -a $T/log
 
+if test "$do_normal" = "no" && test "$do_kasan" = "no" && test "$do_kcsan" = "no"
+then
+	# Match old scripts so that "--do-none --do-rcutorture" does
+	# normal rcutorture testing, but no KASAN or KCSAN testing.
+	if test $explicit_normal = yes
+	then
+		echo " --- Everything disabled, so explicit --do-normal overridden" | tee -a $T/log
+	fi
+	do_normal=yes
+fi
+
 # Calculate rcutorture defaults and apportion time
 if test -z "$configs_rcutorture"
 then
@@ -332,9 +353,12 @@ function torture_set {
 	local kcsan_kmake_tag=
 	local flavor=$1
 	shift
-	curflavor=$flavor
-	torture_one "$@"
-	mv $T/last-resdir $T/last-resdir-nodebug || :
+	if test "$do_normal" = "yes"
+	then
+		curflavor=$flavor
+		torture_one "$@"
+		mv $T/last-resdir $T/last-resdir-nodebug || :
+	fi
 	if test "$do_kasan" = "yes"
 	then
 		curflavor=${flavor}-kasan
-- 
2.43.0


