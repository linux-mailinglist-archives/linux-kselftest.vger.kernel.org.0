Return-Path: <linux-kselftest+bounces-44942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35660C3A714
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 12:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A043B1A46F9D
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 11:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4385D30C61B;
	Thu,  6 Nov 2025 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kEa/f9Oe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013066.outbound.protection.outlook.com [40.93.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F30B2DE6F9;
	Thu,  6 Nov 2025 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427069; cv=fail; b=gQHSdJk5vrVM4VPQDjieRdpiVB4RYo37yyr03VD1T1chGmwBMotzgFY5cC9Yt2Ld7nujXv1YJ66MKZ1RcfBqsccLES0p/PlL6+lSlQlDw8rBzQjhXVF1MQzhJtpRXq1bnGCGyWV65PzQIDsnkXnpwPfhaqJ3nZZOvzbmyOBc42o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427069; c=relaxed/simple;
	bh=WPsSep5LnKuKL9TSFpQXYnCe6eTsC74kOOhDaKToLTw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BIbJhWpX/IGqarPSF/Zo6+kiiYjQJQ6jLBEm6lvqqn5thxXuqCt279Fsnsvvnj/bJ9QsqKpfaBXcBZzYQjJgK+6pmpK0bvynkQjW+JHfGKNPjEdAuwwR9GqdBn+Eil4tGu+GRh6WhyNr3G58kxkBjBwjd9292lST5XT6GL/gchY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kEa/f9Oe; arc=fail smtp.client-ip=40.93.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCjoZRnaXe5tjqFMBEp6YQSZSbIyL/IMlIDzlDEqltczgHGo3e6PmwYjnm9PX3FmLL3HDCqat/8TMdcANPJvXy38RuSlCz2KhslrZNKZet1z8CKILOQv2CTdgGuCefErcnN+1BEQ8fUWdJLnNGEBVr0qV73wer9NzsDxjnT8ZrXUI/FhCNAnAICiDlyTWmVOj4kFyKsObVonMGM5rcPTUW1jx3LBsFVwwzdfeVDGQ8cRS23Fu/qWqpu5hfvwDOs0Fv4xL2Q2GtCETxLJ0Qur3f5cjw89jJ0oznhgKb8uhapuFekQljUalvtuzHiAZy10nOYpTjRtJ+6IrhP/v0Qeeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUFpadyjHK7ptlNHWM2GQfy8J9KS2F9XpHUIAACK5BI=;
 b=krXljimb6NkQtsOpMn7BYAfXdsomoKObS9T1jkh1z1Guc8ok6KLQo9KhbcZMYX4gUsNKZoOrbyMYhM18LUJS3iHvFefKElDgEuwOBYAChApW7pBabCgrnGlEuXEO0IEpSHa2XrNX69PAmnjSRzEV588Rc7BMc4PeU8kf8I9k6d844NNX9gIbx+reWmO+WJQyb3BCR/PLNehZNHot1tPGhI3HmgLYBmEKF3ZdMGx6e10ZzN5wiFj53fsu5wrD+Ux6GE7LSyxgtLbTJDmgT7+Nq0rzRS7TZzkZWpcVTkG9r5VMKNB7auABFvx/YaaRNubKpps+oVJ4hxNNpxI3A89zdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUFpadyjHK7ptlNHWM2GQfy8J9KS2F9XpHUIAACK5BI=;
 b=kEa/f9OelU6skEB0JdCdE68Sfr7oPHwjOBqi6ucD0rW/7pGUcYPYlZLy9XGPaQr4OwSthkMaQ6fSDeONAzWyMv+0X8fUila+3wR9/nWaf0y6HbhE5k5PxS2MIlsE3MXpHw+M7p5Fc/9M+LtFAT7WiyNfhPwePXRjQG28H+MRR0/lfUmtPBDg9XsP3nVC0sEjjjednV4DCaeOFV89C0/Rh/VOjXjQ84B8h7jfbtdsfX+VB614NDC0s2GRq8Of7p7h73V8dQH08xvTIUshVowNxzaQWoeJmAbt9OHz2Y5lXzxYVCLZJMy9F2jU7fzyGa3iqIrqN3s2r6DfMauR5bRnsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8294.namprd12.prod.outlook.com (2603:10b6:8:f4::16) by
 PH8PR12MB6724.namprd12.prod.outlook.com (2603:10b6:510:1cf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 11:04:24 +0000
Received: from DS0PR12MB8294.namprd12.prod.outlook.com
 ([fe80::d6a9:5e83:27dc:a968]) by DS0PR12MB8294.namprd12.prod.outlook.com
 ([fe80::d6a9:5e83:27dc:a968%7]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 11:04:24 +0000
From: Colin Ian King <coking@nvidia.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests/bpf: test_xsk: Fix spelling mistake "conigure" -> "configure"
Date: Thu,  6 Nov 2025 11:04:19 +0000
Message-ID: <20251106110419.16265-1-coking@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::19) To DS0PR12MB8294.namprd12.prod.outlook.com
 (2603:10b6:8:f4::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8294:EE_|PH8PR12MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: b175d36e-a8cc-4c98-eb0d-08de1d243e14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Zs8/JQI0s7o2XIss8SwS5uQQexEir98PotE1TU8WLRsTWAB/7MwXA4mN1r+?=
 =?us-ascii?Q?rZShw6c9gui0KhWdp7MHOF7CVZcynNYZWokbB7TE/KKJN8TWDqBfzprwFkyb?=
 =?us-ascii?Q?1w3qfhMsoqPQKipgRjEwXbPnKYDj19lyJoozeentyjC15/SLT4aq5KDzH2Qq?=
 =?us-ascii?Q?QMJZuJJDsYaLbDI01+Lve6giSl5H1VmZjl4C5QqhkX7W1eLwgDu6mE7Kr5et?=
 =?us-ascii?Q?hdE3/l4FB4HF5pwldm9PDl7kPxJ6qhv8wUZlJgWyp1lvzJ8m32mWWDs+cYeO?=
 =?us-ascii?Q?hl+QLBzSPOP4uilhhJ3ypo16nRrsnixbhAUB3A1p3TxFBBQH4joB0o3JeOAH?=
 =?us-ascii?Q?p8S9M2GihzweHrVlF9xf/exeh4ogtO1zgP8umpik5oraCMnlH9W7aqzp+rf5?=
 =?us-ascii?Q?TR6vdA86pHIOex4wCOf9S4q1YVdkwr4BJA88S/bLDy9HCMpg9IyPhO0GrMQM?=
 =?us-ascii?Q?486bceR7J8oJOZKTP0dWZ7cf8dTxfgcoTZzjLLUrCx9efwrqT7mkEz/aPxMW?=
 =?us-ascii?Q?V+wdsNJRNhrZqLzJVVSauLvJcYH2y24aGRpEQ3kmUZuOGArs5lI/f9aaLcWb?=
 =?us-ascii?Q?OVuL3qVLawmAgvuNwhXy8Rs7qZNvIEcxu72nQtZLiG153vz4K8FwYIDh0+ME?=
 =?us-ascii?Q?kjlqWXdtEkzgSoBMmqAsrXC05KPMkRuQ0VaRAiqzjXfvwprh6IS48xMCRPHj?=
 =?us-ascii?Q?KlZahKwz7nIG72Z/N67dJ107RM5kiKeRJwKtlqn9eRg8ZHHy5RYnmJFLXZdo?=
 =?us-ascii?Q?FwmBWV2tYqlWdVJeFgHFzWFAa9ovmeBknGGQy7WPZoycIp/o1QvFyLDkn+R2?=
 =?us-ascii?Q?JCAzUbOvA6zzSiVDD3p8j41vRoOhcNtsVSZLx8LW4RRf5nquKVJH5CwIbU6g?=
 =?us-ascii?Q?MY9NkMgM78umsH9hZ3fjl0ZUx+iBFkDEl6KlsMyhYSx7lysZ7BIcSKfculix?=
 =?us-ascii?Q?9upnl4gNPquipDyNQHgMedmhGRxlwKSRaQIU7BaJYvMsNGZneYrapZZiYWEL?=
 =?us-ascii?Q?GeA1VVcJ1oqSuZszAK3uyOHmD9B01LAqzEzyfOX+/QrrHTwr3VnNzrpHCEwg?=
 =?us-ascii?Q?g/f3m+H86oqUCkYDQaQYb8mMukF91ic9LuA33uTjryMyMRWcg1AdjoJwic7u?=
 =?us-ascii?Q?ep7o8bve8DcBg/1ga2Ha7P+Y7MnJs2jQxLjlyHFbpZVV1EGr8t5NQsjgKM6R?=
 =?us-ascii?Q?t0qCoUfZhqS9fNLpbQh8avtb7FUZwi8+ZVReG2zlDS3rGxCyscZvU9BN7KBR?=
 =?us-ascii?Q?d3mJ87DetqE6X0z/9HBDotbEKokiuHC90RMT5oX8GE4ORjLinPpJHEfiI3Hi?=
 =?us-ascii?Q?gUMVbjt73RVB1gP+F1BJ3nE1BZl9bMiioLPrB/0A/9VBhfORT9dM4zgyM1LT?=
 =?us-ascii?Q?hbEPPe/MrWZSF1v3OUn83Emx4rX7GvULCIBtX6Q0QEEhGiZ+WT7FYJtCI++G?=
 =?us-ascii?Q?s2Sqz9E62FozLhhxAwdzC1w/ZY00iLcZg6tjR0iU8ghFeS1mHdDxG5cGbLG1?=
 =?us-ascii?Q?INm/ZkV5OsLvToo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8294.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RqGbaPIhLyBcU2BF3zGpuez25MyhN83Ta7g2+tuCS76FPYqCSgFQsSegMtC3?=
 =?us-ascii?Q?5Ds3WwGpWOF0J7mSwJRwFWmKGgenMknMaY5MmP3e6mV+/jYuypUqmBZXVPOL?=
 =?us-ascii?Q?iPGRqQZVpoifBZ00GtqYOxe84bsDKgCrD2CU1qf+zPo3sNmw/HXAXeiR6lf/?=
 =?us-ascii?Q?Bjv0R0YDYFEHqTdHQFC/E1nuhKDoYise7qv1VGj2ctghG3XXwzl+IKqq+ALv?=
 =?us-ascii?Q?ANRaqnJawIWeOn3G4xEqGWqQE5suA6Lp8w5JpgN5WhUxFXdNi/OQKvIq4XA1?=
 =?us-ascii?Q?B3IAs9ZZEL/wIlElksijv0fXh5E3BFLiDyHvQy7VfzrtFri5S8bQyAlDH7l7?=
 =?us-ascii?Q?eMEfv3+6sdlSMiXLu5AYVu81ZD7UBfr7TdWQSh4cO3DtERkDPsquPe3NmOGq?=
 =?us-ascii?Q?kbne9ntgC0dWrLVxM4X6Dz5CLgtg6in+hAt+zQvFZEwQ0hG/pTP2wGyDDpDj?=
 =?us-ascii?Q?GI3rcD71nWYMMigM+yXetgSd90bKFEJpxqC1omvcr/qS3xiHzHUgpMsht6px?=
 =?us-ascii?Q?v0CAf3WWLoPehK/P+MHBw57vm6qUCzZJB0TYy8a8kSVsnWuwrQsf+jTPdjKf?=
 =?us-ascii?Q?690ohYv+Fbrelt3xTOUshMWYGCE/TpMwEU+jJEipNuUASVpg3EUFpo/ZaOTj?=
 =?us-ascii?Q?OIc2BQG445kfPV47i4Z/NHlHeLtijXEuBk8BHdl6oFv5j1RPxf5jzoHIsRGo?=
 =?us-ascii?Q?C6tzkESRM58tPnRDvdIaimgl63pxpXxxgtxVeaVqjMHQbp7hcYsotMHLha9a?=
 =?us-ascii?Q?mQezpvE2DtpbgGqQwsOv3JsLNnzztUegN3JY9M/Y3zVAhTeSpnddtN6SAaKu?=
 =?us-ascii?Q?goAO1wkR+kGl0Y+QHc4vBgAIGinbIPW2a1BKOo6T7SHugWItLZZfUsUQo4Pu?=
 =?us-ascii?Q?yXWeGU7MV6fmVCCbEoUEfP5Zp9P3DPV6BLEOMOkOzlUqmzvznfch5TuwcLuj?=
 =?us-ascii?Q?ApyYeFoiQcVck88jkfSU/XY5ctU14xd6m3TBvJ1BO+oZZsn874tqINCOMSpM?=
 =?us-ascii?Q?2oWdN0jsxVGAjgqvHC6B39txyftE8ocAj2vX7qslBnkHICs6zHwMTHDgrjJ3?=
 =?us-ascii?Q?/I9TXiQfnG7FOhILECrC7wYJwl09kBmawP3sxDRynXXJ2bBuXMvmxafmp4sj?=
 =?us-ascii?Q?16z/8GCvldu2r0hQtfGotuaTTh1fyUvwmHM6SnmrFp/kEXQ9YjURdIplgbhD?=
 =?us-ascii?Q?pUt7qdLnjfQcvGCpfNc8970/0k71gFiFIV9uYLvYM/hTfrfcXG1pju0zL8KY?=
 =?us-ascii?Q?RrvLJNRmdpOipFIzvBdjVWLnijZBhU5hEimksw4zaas0rTddEoi1qt9XZGhd?=
 =?us-ascii?Q?OYNiBcPXMCAtFR/6Rfn9MY3EnGhmsxKs0+gDNVdg7JxXxXzaAO033IZhq0zG?=
 =?us-ascii?Q?45ibosCqZprjQutWpkwuY/0DZ9pQWZzlKZdORWAUy4ChQHkQsD1mgD2Mk6LP?=
 =?us-ascii?Q?J7yaT0VTrnFNLkuaD+jb++AT1p+Apzmk2NEyoWnemDloaldIepPnYujErTxx?=
 =?us-ascii?Q?zyTIcah1jv9BAMGRmirwm6ezea9u0BT0poRui42pvIXWzV3acXzf8uGl1gv/?=
 =?us-ascii?Q?+fYOufb5yjP2TIYLpMTRGRYeDqbh9M8mUQejpEcs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b175d36e-a8cc-4c98-eb0d-08de1d243e14
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8294.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 11:04:24.0365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yU7AzEF8HILOfh3A//AN+HUKoSa9xm/3IIbpyMhoSqKalts379470AmlYFlDxaWh4eY8PN3Mev61p/T/CikZIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6724

There is a spelling mistake in an ASSERT_OK message. Fix it.

Signed-off-by: Colin Ian King <coking@nvidia.com>
---
 tools/testing/selftests/bpf/prog_tests/xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xsk.c b/tools/testing/selftests/bpf/prog_tests/xsk.c
index dd4c35c0e428..04f9a5e73e5e 100644
--- a/tools/testing/selftests/bpf/prog_tests/xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/xsk.c
@@ -74,7 +74,7 @@ static void test_xsk(const struct test_spec *test_to_run, enum test_mode mode)
 	if (!ASSERT_OK_PTR(ifobj_rx, "create ifobj_rx"))
 		goto delete_tx;
 
-	if (!ASSERT_OK(configure_ifobj(ifobj_tx, ifobj_rx), "conigure ifobj"))
+	if (!ASSERT_OK(configure_ifobj(ifobj_tx, ifobj_rx), "configure ifobj"))
 		goto delete_rx;
 
 	ret = get_hw_ring_size(ifobj_tx->ifname, &ifobj_tx->ring);
-- 
2.51.0


