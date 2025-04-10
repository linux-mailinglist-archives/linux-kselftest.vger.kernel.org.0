Return-Path: <linux-kselftest+bounces-30483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E84A84748
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 17:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C20F19E53EE
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 15:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628AB1DF261;
	Thu, 10 Apr 2025 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LvDBQeCA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AD21DE3C7;
	Thu, 10 Apr 2025 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744297425; cv=fail; b=l18NKh0doyblFP51dTwxLGXMuC5Z6a+PmKS/mvRsh1JJMxS6xJdjQggR/nyiI/V9rdzQ+gyHdLjHtPd8qxdQo0qqb1bfd4Y4v/jtmWTl5YaqjJ6hmI1qQgJLNIwtoo9oUb2tq2ojtxWWx6xBFdqIcf7tHeYCR+R++FzCmV8bNGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744297425; c=relaxed/simple;
	bh=kcLxMG/V0MzRjfUgxUlB2xqStwxMDpICsbJHoFejQGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OLNIG0Y7fhyIeoV6j9+FkMMaIWkUGMBUGMxrgcdDRSASrDWOafqQSqxxK/Tt3bMKdY9npLnhUOqP4mI2XHGyxWJYgZ+2JYlUCvfiJ3ed872Xe40jTGlM612E4AIC1lSLUI6TwyZzziBFzmwbRbWjZxRcvv2l4PtQdoek2jyyyY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LvDBQeCA; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=peT3B9t+GKqIPjgSVTurOdTQ4zQzmipti/uRjj0FqOHbVaL+2zyGB9MZE3WYi3Djl7iVNMIA7NWtKxAifBvvZ3Mw6vEIfEkQnsrXvx0Y8/yNOKVo9im2NKOD/n/ZouwT4P794QOxlanVlEvvHvVD9zNoMi4NGTVQdG+8PhWFhGg/I76vICXB/UHYeBPQjvqURMUVUmPbsgzSPNtmDCNGBClrGADkkgZD3W4PwLLjnNRTtCtBjCTvbVaO7slK+J3/5+TA2QJ0Sh45cAqc+2xOIGINdaJgK4c0t8OZvnAGNhYDVq93x8NlEakBsza9EAMWgQ97MtY4fXYLIwU2htqxLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rNFKeLjRKTTU75FA/ta1UJpQtXt5oKU85xJPuzX7jE=;
 b=uWOD1ALbmZVz9qAf2GyqDF/av+WqeKOu3FS+Sf/NyI4dwdlQTx4zsrTxx7LnZQTlHwWBlAcykXIPPjvoMustZnrYgjVEsM6RT6dfEdD4QrUCo9U36VWVmMmapM67S38h/tQBkUWE0xG3pRa93VfWL4OwwDHqVnfrf7VDR2HClfhgaDtELEPE2A9uHxzQDTFywlOd4mMpDpgza4O+skXWu6BcymgLPaI/FXWp1j1/hPcLFvPMDPAkjyisWQ+nG2+Qa7r6nAQWPxdYtabmMPnnClXMCHqjd0/G6gRcoDjR6bDxGrxs+kROfEEFv5rq6IX/2HnvWprBb4pZ4iWLmnLcZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rNFKeLjRKTTU75FA/ta1UJpQtXt5oKU85xJPuzX7jE=;
 b=LvDBQeCAOsV4VmBJ4H2faldWYBv1Rccu7rB/WsTLeaix4ZLchRXItkVKFVvkL1liSbjfVeqEj1PcPSuLKuPQmTACbyd1yuZbh14pKCZhLq3Dk8A5FMraHnJHiKE95H5css58VghG92H8f7sQAgETznmHZXiFoabmTDF5ZnsWbdGTshI3NJMsrovSnfl9uXHJqAVF44I6lQCuq0WZkCCiK+CjpJQ5HAlUTaz6NZUzgYjGlNzlCm8SBideNC3kWprZ9gbaNNZgylTvD4O61wpdBgNE5Xt3Ao5qSJuDJeAhjdaRT7v0/HiqjOEuODKbrvNPHOh03C70yiz8YDfK2vUluw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Thu, 10 Apr
 2025 15:03:38 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8632.017; Thu, 10 Apr 2025
 15:03:38 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 2/2] rcutorture: Fix issue with re-using old images on ARM64
Date: Thu, 10 Apr 2025 11:03:28 -0400
Message-ID: <20250410150329.3807285-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250410150329.3807285-1-joelagnelf@nvidia.com>
References: <20250410150329.3807285-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::9) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS0PR12MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b2ca8fe-b325-496d-f454-08dd7840dfd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LpIiOwq4yRp0h69Aez/w2sd5kz3vFDEp3UaOa67ns8rq8GU+LLfQQyrP/TRX?=
 =?us-ascii?Q?8J/gCpJFJuR+w76fF+oLmUOQhBQ3Su9nFFqrEHTuOuTAkMrZiCv79JKUbd2N?=
 =?us-ascii?Q?b2mPZFvqsqsGDoHerkvNSOJip21vp8VMRHTuHl6Rsviotq0G90b5dd8jFl//?=
 =?us-ascii?Q?TtkcY7pdqMmXsfP0WJxDJEe5C6DAuaUONe/66niwX2J2G5OC9Vuie0bc61ij?=
 =?us-ascii?Q?R0TnBBGZknu6X9tWi1CqBUk1FBNamyIrR+UOz8mLLoHSbtNtyEzsiOZdFmKl?=
 =?us-ascii?Q?0ygn6hEZLSSgb7nQnTCmrMhWjJoqmVqy0C5qgn4rsTRCgnMnEKUikIoRHs2c?=
 =?us-ascii?Q?8KunMQ4B7xxODYaTEj5dG905vahCgGg2VnCoKs9oUfdzAfSBT8sf2yrETzvK?=
 =?us-ascii?Q?MMBqMhDsIqSFrD8dt0hrpnKmnj1wJt882DpVvaGFSralienBuGgvM3/ZuJyC?=
 =?us-ascii?Q?n3E9UPqpSRKAAl9fs5w/pm/VTy37xE6Wq2FPW3MmHlwZSaHxGe/fz2prjm8n?=
 =?us-ascii?Q?rih/LjhXO3xQbv5PiCOHS8SHcyaBOE+CHkLq1c4Fdhn/Vo5G4Tbg2ay6KdfJ?=
 =?us-ascii?Q?FIYxEpk5YASF5qFrfYNBAHNZaORJ/zxpCZlnp/SXEpTx1Tdse92dKfh56+l+?=
 =?us-ascii?Q?Eb8G4xfQSHjfuUiWDQVjCdkAtzAL2mBK1QZKt0/WFmP0B8b1K8Nc6afvcnpX?=
 =?us-ascii?Q?UA/d7PLgrXxsRI889689lzfRovjHxKyrLcLxp3HA5IJKsJtqD4b06FGzVblc?=
 =?us-ascii?Q?FeBQ5qrE6ExBhI9/GO2+6P2q23dzAkRQfukV8F0edGF08A0FmmvoS6aFpK5v?=
 =?us-ascii?Q?+uVymTK/C9i5pOWSgrebVCjoiywo3vENv1WerqP4H8y0gIMvNheLR6zvAiX/?=
 =?us-ascii?Q?2pDxi7VwLCWhxB42PooM1bOO0bFYxqrBbeOscSb07R2fM9SWjbz0+LWdbVYr?=
 =?us-ascii?Q?uOIS00TmOvnHP5hEQDOVkpw9oT7DRTEV8DIdIwrLaLRB1Mh7GynWhNfxNBZw?=
 =?us-ascii?Q?S0/ni6en92KbseFNDrlz07iPmrSYwAHbJMnWiPiKgSMY/B/tBtN79KWzwm0v?=
 =?us-ascii?Q?wm+ukxK7iYeSg98yZYromZF1Au3+rMXMU5JEK0+otvXKZNaOFYdcHMdYtp78?=
 =?us-ascii?Q?D6pMJQ++Hc4NZSdu65AMFbr5itfLis3RLCKeWWT/7XhkCDfdLoPDBj7mJXWU?=
 =?us-ascii?Q?J3F0Pkz/T6L5KPUqaDRPqYPiJlE5dunf5ttYBGMWZFWhTvBHwasLavWssvCv?=
 =?us-ascii?Q?XFcM9RfR4VR71E/OQGOCndxUUsClinA6mEnUGZc8zhKse9yflcExaXgBQeJf?=
 =?us-ascii?Q?5p8smbueFVwoPx+KR4C71++y0Mro4+5rmKAzcK9G8PsPe1wvJfU+q+Q9gFSL?=
 =?us-ascii?Q?PDQqoR148LDGxG3uGwhdX7r7oW59?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EddNj2GaAcph9j5DFRaOb7lbegpa1G5BuA6seKp9useHhzsSsFp3rkTA204Q?=
 =?us-ascii?Q?stBvvABu+KsymwSaMtJE9O1Ovp9yvvG3o5fnDppqmLOWGPUJO6jpLXcQTCD2?=
 =?us-ascii?Q?mQwHvW+Z+vIUNtDuG+YdDbe13y4PbHmrQFWaDecl+gJIq1j+iU3aZkOPitlp?=
 =?us-ascii?Q?79OJLl4ANVszGxkae73Am6EnYj9RTrppRN+YMuRekHKslqGLwPhbLX0aVSRt?=
 =?us-ascii?Q?q0RAqKqYf/kF9h2nQ12Uxm48rvk5Uuq7Ed8m9kizZT2AM/5EFbuA1a2Vv5PO?=
 =?us-ascii?Q?pedhoF65cCRZrNPJiMMC4WhDh6uOA7VFvHoseI9XS4/f3KVJkxPddXmCzVXC?=
 =?us-ascii?Q?cZhYEDh8MOrlMHEe0NmFpXyi9iFfLoAV+WoRDoAibsXyPHxBvULSk6z1dH7j?=
 =?us-ascii?Q?6Uh6VjG26qo7+coHo3a9mqopowfUU2K/r0U4g/JumfQHYzf8QsVznfseU5Jj?=
 =?us-ascii?Q?FY5d8+ijZjoPgAhXLBIwvG6uF89XT6rCC0poxmuG0hLJ70PqTAvrGbXtC9XQ?=
 =?us-ascii?Q?lgbZR90rmeQdRMk/WIze4alxh1QesrOwGDTOvaDwFRgTd9nKV8CG5kl3UYoB?=
 =?us-ascii?Q?xJzMQ2JFTnM30KRoTUzRf8tzvOnGZyCjRVqzpfOeFlXu6+By0Y2msOiN66aE?=
 =?us-ascii?Q?Ag/7YFSeuiMcKPC35RZKGOCa9Mo1/ggv4nbbqTqtV+lZfCrW/IT9RWUezJEH?=
 =?us-ascii?Q?5nbyjwcZnFnM+YbKuhZvI9KSLfh7QrYPJcTdZ/M6GhVPn5SWGbOZvRcPmN5y?=
 =?us-ascii?Q?uGNktno2avSqcZDc4JvJcuWozoJ//ZF1OVage+yxaZzcg8Dojrs1RkD5dozb?=
 =?us-ascii?Q?pwVVvcjqaW6Qd85J9I64KWZC0dC1mqFxj0doxhXil4qAOtNFSJdfVMTlPuYq?=
 =?us-ascii?Q?P1rB8abXyNPFFPwVYDHocvojHt4aS+doMORyEOz8OymUKP85k7ayTcKXmbl7?=
 =?us-ascii?Q?ATcJb10Y4fzCTs9NE3lQ5BxuD07KA3UhnrOYCI+1vcAhhxeun8DY7yveWvU5?=
 =?us-ascii?Q?9qqZ3OwiKjIFQ6qYYLfQJGw4zVETmBd4QD95zFBCLD8VJuIA8hDa8pYRMrO4?=
 =?us-ascii?Q?SQDFD//OcgCjWuhzvAdgoxG7M7XFQZ3SibV5/ThH4r1gfh9zprl8OSm5JdT7?=
 =?us-ascii?Q?jq2TTuRNa2N42ytXwq9FivMDi8CInyt9gMqUBMUujxgTWaC7DZGPor/S6gFj?=
 =?us-ascii?Q?7y+c4fEdF7oKvGH1c1EqwgqTqyGbwo2B4EVGxbBd2gf78PiYa3AFiANxU0kA?=
 =?us-ascii?Q?oZCFKEozx+38m5+tpzYj2FPddXq5QZP2R5pMPcJGajA6MU3f7j9rqqKY485x?=
 =?us-ascii?Q?2DSghMYOBlbLCOay1+8f2r3h5hYvDPrH95JtYNVe/GeYEjBah2pmKHUEj6av?=
 =?us-ascii?Q?OegmczLdP8FpIPoiObNEeUapX61YTn3ndPrKPG6PPTw7Aqk1kxArJ8lwlrU4?=
 =?us-ascii?Q?l1gPktwNoiYBHenCOl9dOA6QjhfiqWAqDOoFExm4LkzrxJNZ8J2nAox7jcW6?=
 =?us-ascii?Q?0gXRkGYrUkFol4CQbtPmKhb2eOBh0c69Qtcpke6dKIfOYuODkNTzLDoYXvgR?=
 =?us-ascii?Q?kBA4kU+OXk2KdWRoMGJTJfQfy2MtgxPEzDODmPYhWS84mx9UhH9RIagNna00?=
 =?us-ascii?Q?3A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2ca8fe-b325-496d-f454-08dd7840dfd2
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 15:03:38.6002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmlDpQY+5bStXXu/vs3zWb4430puGOnbGnG1JlKmFzH2CVwqou5HolW1O60D9rZWUqmmOQT69K7umlemsY58zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463

On ARM64, when running with --configs '36*SRCU-P', I noticed that only 1 instance
instead of 36 for starting.

Fix it by checking for Image files, instead of bzImage which ARM does
not seem to have. With this I see all 36 instances running at the same
time in the batch.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index ad79784e552d..957800c9ffba 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -73,7 +73,7 @@ config_override_param "$config_dir/CFcommon.$(uname -m)" KcList \
 cp $T/KcList $resdir/ConfigFragment
 
 base_resdir=`echo $resdir | sed -e 's/\.[0-9]\+$//'`
-if test "$base_resdir" != "$resdir" && test -f $base_resdir/bzImage && test -f $base_resdir/vmlinux
+if test "$base_resdir" != "$resdir" && (test -f $base_resdir/bzImage || test -f $base_resdir/Image) && test -f $base_resdir/vmlinux
 then
 	# Rerunning previous test, so use that test's kernel.
 	QEMU="`identify_qemu $base_resdir/vmlinux`"
-- 
2.43.0


