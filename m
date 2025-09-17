Return-Path: <linux-kselftest+bounces-41662-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE64B7CF11
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A54188601A
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 07:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61E5302770;
	Wed, 17 Sep 2025 07:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="J33KV1OF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013026.outbound.protection.outlook.com [40.107.44.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962EA2DECBF;
	Wed, 17 Sep 2025 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758093824; cv=fail; b=eIduLycVO+MsQN8dr9uvxgRoT1tf1T/eoV+7gR+gcgSdkFbraR/E88dQJapArbmhRgfXXdZTSE5WkGfD9xubeY7nFfDx5ktyDIX3OlBTkIOk9vG+7o096emsDFevZn4Ogbrm/9nsvQzOLH0fM0HBFXzZevFW87ItiC8kneE/nQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758093824; c=relaxed/simple;
	bh=7HEDEWOft+vuizNagusAZfyVbE3yFAGDFTkmdqiQLgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BNoZ46hak4bf0ZFYsCzxPM6Nbl5gaF69/iwjNOEbTkDOnKM7lMVKqr0EHj1JYF2lozTinKJGSQenP8OmpPhWvqWOXQYY5nKmacbAeYbScj253zOscMSWDhuKysjgL/0XCRQSEb2bd6Gm137avaNTnu2GDmvJqSfti4IHItmQUN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=J33KV1OF; arc=fail smtp.client-ip=40.107.44.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgblTieBaRhKdupOJkhbD4nG1SmOiqPV61emBJAvQhgFQkybut3royHu5dp0tQk1eh/nU/h16fNofd4rrocpSXtjpMRw0B6sKk2J89spAHXoYo76A/fWcBTIDgHmVls9JNP8FCVFbpIhdAAABlN3H6qN/+1IaADEzUh6PAWX6ilWbzF/Sseak8LjRCMJVYS4T1tlCcCz4d2yyIxHhmkfKYXu2a8P3pBPw5VfS2JAw53sCdH0zO2+I6KU+4K918g/h5SANZxvm3Qf8Zh2miJsxlAWE1bHNfhfvltheiXMz2J3vgDt+fQMQFjgBSquWAnqNZyzsQvY/CeZmZqENb37VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCnN+8NULcSkchjFQQINPlAU8TWJGNxGDWaxpipStTs=;
 b=KjYlDgl8p6qrivO9u+wFud34/Q6ZCdQ6ack4RT+uM/1EuTRzAm77+H8U0bwcPHpUMaWbzv8pnt7UyEkOwMXGNgfIX1kpttHPU8KBUvy7LApzT/gDZ9rQ+veXRhhUjxTVutOUJOYsva9LVXKC74QeV3tHz8S/QWh7nDP+Rls8OuXJa5oJdx+uHyXIxP3yQ8bk3/F8tqSZTIhlG+kOsMwMI4h9WuqVXwRLlda/9l0kE/TZ/7sXDj4IxkPxYp1zvXmFrxzJhZd790lV02L16KG8bMIuJTXyeC+pn3Tcu4pxa0HntFkusmaozPSIOJc0ybOJBt2a4999RTlZQnmd+8G6uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCnN+8NULcSkchjFQQINPlAU8TWJGNxGDWaxpipStTs=;
 b=J33KV1OFfPmBIO3lI96CnlYIBRWN7WqMcqjZZGBCQfV5LxDBnBNIHQrQb5RRwzTYrsI+5QWs8Ji0EdX6J2g6SUP9QusJWiIgizIqiqYObwBJCgdF1Zx0kNkSd2Ad0FSPvx/47dkY0/XU03Qw8WUT7UgX65/Qj8QsDGHyCx3LKTAzC3eTnBKdN0OyCrWYe//Tq7o3zNn8UCQg9YGMFs+X8+lqEqtCPyWR5bZroihNFEO5g/PIy88LR9cOCz5+pMc+dDsWlCfUZj8vpZr6lM8RGd7mfRemaFq/TYe4xoxrFBwtfeWAxdqRlHYm8q3z8NGcrJbRACHVis3oj+evDT0CfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by KL1PR06MB6043.apcprd06.prod.outlook.com (2603:1096:820:d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 07:23:39 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%4]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 07:23:39 +0000
From: Fuyu Zhao <zhaofuyu@vivo.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	haoluo@google.com,
	jolsa@kernel.org,
	eddyz87@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	shuah@kernel.org,
	willemb@google.com,
	kerneljasonxing@gmail.com,
	paul.chaignon@gmail.com,
	chen.dylane@linux.dev,
	memxor@gmail.com,
	martin.kelly@crowdstrike.com,
	zhaofuyu@vivo.com,
	ameryhung@gmail.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: yikai.lin@vivo.com
Subject: [RFC PATCH bpf-next v1 3/3] selftests/bpf: Add selftest for "raw_tp.o"
Date: Wed, 17 Sep 2025 15:22:42 +0800
Message-ID: <20250917072242.674528-4-zhaofuyu@vivo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917072242.674528-1-zhaofuyu@vivo.com>
References: <20250917072242.674528-1-zhaofuyu@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|KL1PR06MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: 44380af7-b878-4122-85af-08ddf5bb1f5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sGt9VEZlu2G9jKiJSD/eTjqTlkKvxtSLhPR0u1yMTKvEStIIqYzm4tOmHF4t?=
 =?us-ascii?Q?iG9dgjy5ep07bgEjNV95FOWAD26LPea5Ogkr/iHY0BtlGzZ1uxvSV8Nq8jJ9?=
 =?us-ascii?Q?SPsOXKfxo6krjfe9qO6vYQcX+DGWSQdKabO63dGWT3sD/AYCifvs+PtTVlv1?=
 =?us-ascii?Q?CtwOI06f1odO011REi0FyXoONBX4QHeK3yaMxguTCcRU9TENc/Y0ZdQ5rhgb?=
 =?us-ascii?Q?A9gMIqLjoXSys7pltHH+NRgIgKlaaIhlnuQc0TD6bxPmywX9O4ANy7vIuBxy?=
 =?us-ascii?Q?nYT1BYNkEdnPvnmISUClztfDGuVerffYWIYCwCKF5f758J3g/ZtXG3jOvPSY?=
 =?us-ascii?Q?PWo8e8RByAsqH1gU7od10He8gy/iOqZn4AjX+6yWCcRKlfF9US22E/kALhw/?=
 =?us-ascii?Q?OgrSPe8+tEPJz9hxws23TmFAKBmwnPKVansas3J2Ay/hrseFmD4Hv/mr4Ttm?=
 =?us-ascii?Q?982TRL1677EdwJJwjHTzhAcmPi8In7sJgvzQcUrVjpzRti++I0M5pdCekZdM?=
 =?us-ascii?Q?Qf1WYLaHaFoFbRBrQpw/FZ3WWY1z+lkAwvqSujhc0WGKkszIArHKhS3pNO4U?=
 =?us-ascii?Q?NS8V0Gos403id+zfOsA9YiESZEW951h5dQYvKGqBOUXGy2t875bl1tvu/qTu?=
 =?us-ascii?Q?5piPzPjRoezwKMZCHKKc9B9STGZYDpwMVrj5bw6K4FdLk9Hgzc7guZNlfAFb?=
 =?us-ascii?Q?ZVyjJibj1VuIXshHAQj15fWRD2xozszzDXu5AgZcpjxDBnzKDFL1Pj0sU1L+?=
 =?us-ascii?Q?XFi3cSMfOAqOHtoFya3z793ujbvKN6jQtG83fzbjsL4WdRpQYWDocn8lUV4z?=
 =?us-ascii?Q?/w3KjLiLtA5h+iDGapsqMzvaoSkru1bwCQ3YyqJb3cWY5Bj519AH+cc3Lqsz?=
 =?us-ascii?Q?oVigx4khlagOAsGbUl26cI1POdCeiOKogWFZaswBj/8TPHCiB9qs4/MkiLcs?=
 =?us-ascii?Q?SkB/rq5BjI+6RpuxcniyOAPd5XZQmZOzKE/iLKYm99KUsJWKOKLQwzEfcD6r?=
 =?us-ascii?Q?1pQqT48zRBxTi4/468t+anzD7J3XbUaOnifPDxQDP82YI4Hrdkp/Rm1rVV6T?=
 =?us-ascii?Q?mMivAfkjUAAmDpXQ5vSKqIUDcxwUva8kjlRkGZ03NfC8yPE9qKUAC5la/P3q?=
 =?us-ascii?Q?qnRPb7C4QNt46Vctw4XJESiaXMPBS6ZmrHgojbuutUSkizSBV2e5MTUk7ksX?=
 =?us-ascii?Q?g1vD3J/kUzAp5kFDwH6Yo3rKk7Le850rElL0Pa11I1xV4dPYeVMZdlgIJJt5?=
 =?us-ascii?Q?p20fOzxoU+4l8K2PbE/2PPkhUb2BQNgcnQNi4eo/aAc42rdE4SDq3hXhqudy?=
 =?us-ascii?Q?9dRL4+Wl23HlONdmM2A3c5YLjxB6HInzJ2VeU6WsCQ5xdpobIaR8lboQCKsC?=
 =?us-ascii?Q?2IkcO2FrAHsVbSma6L6SWO1Wz1Km+yP9dpR/F7gu9XDkAXBOdOq1EUyS2hoP?=
 =?us-ascii?Q?+3g747N8QPFrBK5xwfCPm/EqgDsVteBsV6Tz3e9xZ8Pn4h9YmF8GJTZFaAnY?=
 =?us-ascii?Q?EmSumJvl18U9TTg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fYd1hdK7+269z+5ZwXkUAHnk85SKFAb6oZa857nSPbaXAkI5dg3Yo0Tj1hgK?=
 =?us-ascii?Q?PxF9e/urf/RruTkdhLD6hvtsEzHi4u63zgJ+rBZlp2Z6xkBTTHF7dwJ+TYk3?=
 =?us-ascii?Q?6vwp7XF8MAOHW5DZ9eX5NpuzbS4KTaRbXyDNEwElLWN8L7+X7dSoBHJ8ILxS?=
 =?us-ascii?Q?R5+Fi5oFJcAFV5lEeGpUNylZ/oELl4W5K5Q10fPXdL8j0riSYt0m9P6kO4uh?=
 =?us-ascii?Q?Uc3ha1ktQmYMOlmsAUAjJQBJdtZqNTwh9sbYaKxUxJGj46vg2KvIJBVGNt0/?=
 =?us-ascii?Q?DxRacyZZBNtwm3trVT1QPFIvKo3DylaHRgcwAT6SNbdQ6doi/PVe760yql2P?=
 =?us-ascii?Q?cKJfkYD23yoxz8LKZZcd9r6uyz5ow3gdquaJ+0Ru6H5doYzsA7JR8vYks3gk?=
 =?us-ascii?Q?Yc9jLQtlvu2pcOKs8uMh7WT0SrwCvQE3ljKHh9sZpngvgumDhSWhS/aK84mK?=
 =?us-ascii?Q?9gBsNRB27Aak126K28cCJEzCQBT1hvTcByITfxZrvHy04+XmtK7fRHbiK4ns?=
 =?us-ascii?Q?p5TUfz+srxC/YRFmENEXk68N8g/NDM8t88HBWuUHx5XYeUwVOi4Ud6m7f9O/?=
 =?us-ascii?Q?0IBVxrtxAQHEkhDIJavM1DkhwXvrWzmZkL3G36oGThXuXc2vqRCSPcEkXN2p?=
 =?us-ascii?Q?3oBqUYdweukJYkf6XxEMsMx9ZLpDsTSrGi6QLhvnDDDJS30Gx2sZwJmhIvGx?=
 =?us-ascii?Q?yEBJtEWsZ773j3WkPMN1DLeIUEGsoy1EkWom+4pZs/CSXeEbWo1Z1xG8IfNQ?=
 =?us-ascii?Q?9MRJcMw4ZfLAt1p3csoKiODXXRTUfM8oBu2V/tvpeixcO5aZlr7w9gi5yvHe?=
 =?us-ascii?Q?B+oBUtoblrL/hKAujjcxJNH+IwbPx6iTPV7u1P7BG2zzEWBTEFZcQeXrGZFA?=
 =?us-ascii?Q?fdsiW8iRMOjPzwRUe1Mbs9gBk15ywrb3C2e4a/7sJfYmOsuAUAGtVsyd1t3x?=
 =?us-ascii?Q?cigSWQ/b9G58oLL0V/M5v25kDTAUzIhVOmgFRxNmrXEMx9mm55k/1U7Ylu6v?=
 =?us-ascii?Q?CaNuMW+JmQUtVzHokWc7gcbx+tvszzI3ds7Pj6piP5nl8TVR772ocsNiRL4d?=
 =?us-ascii?Q?o1Hi9Y7HA7TD87FQ77ekN3ZcydF4H0JXjWY8d7tVLfRilnSfTd+VQskZvxyv?=
 =?us-ascii?Q?35vzeXLCdoD9hRcExCKVhvF9jiRo4bE87FEXEEvC7aUuSHVppAshhqbwS0Cn?=
 =?us-ascii?Q?zl8IKWtCiMwWQEQzUpN7CZGGt5MGNATvxPZRDLK5Rtebs/RewK1HmvIKrUKb?=
 =?us-ascii?Q?UDgzRWy6FvV+cbxorbzLNZLwIqxsauuQa7h/VDILNL8hiRQkUdKitz+b3nQr?=
 =?us-ascii?Q?aSJ/Uvf3/rpolQCgM8/T/uCzL+RkjdZ2r7SOa28x1a9bBigLRWWokp2IUj0W?=
 =?us-ascii?Q?1PbmOVGH1RTXpAUbPoJub+tD2Wpg0KkhJmtHuE/KKyj6wlpXXMDo5ewq/xjY?=
 =?us-ascii?Q?cHp87FN9ph1ZmYlihXMTGb941bv+2LjMrqWyPKXfsJfB56Pd5G6xcv9+vKlx?=
 =?us-ascii?Q?g8eKr8rmxdeW2rNXKIIM9x208wAvg9pATMr/8N4VYd6MEpKc7OMASzJKgNdh?=
 =?us-ascii?Q?9kmasMR7V4BzOCg5sITEfXzGSTAoalCMjPzqRTXw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44380af7-b878-4122-85af-08ddf5bb1f5d
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 07:23:39.2251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8H119WNUB33rS3IhyNnaQuW8JfCJ0OAYv9UWI79met2DNhvRQu/j5Do0HwFR4lcxigjEEcpAj1IriTHoPlIdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6043

Add test for the new BPF_PROG_TYPE_RAW_TRACEPOINT_OVERRIDE program type.
This test verifies whether a BPF program can successfully override the
target tracepoint probe function.

Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>
---
 .../bpf/prog_tests/raw_tp_override_test_run.c | 23 +++++++++++++++++++
 .../bpf/progs/test_raw_tp_override_test_run.c | 20 ++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  7 ++++++
 3 files changed, 50 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/raw_tp_override_test_run.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_raw_tp_override_test_run.c

diff --git a/tools/testing/selftests/bpf/prog_tests/raw_tp_override_test_run.c b/tools/testing/selftests/bpf/prog_tests/raw_tp_override_test_run.c
new file mode 100644
index 000000000000..02301253cd9b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/raw_tp_override_test_run.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "bpf/libbpf_internal.h"
+#include "test_raw_tp_override_test_run.skel.h"
+
+void test_raw_tp_override_test_run(void)
+{
+	struct test_raw_tp_override_test_run *skel;
+
+	skel = test_raw_tp_override_test_run__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_raw_tp_override_test_run__open_and_load"))
+		return;
+
+	if (!ASSERT_OK(test_raw_tp_override_test_run__attach(skel),
+		       "test_raw_tp_override_test_run__attach"))
+		goto cleanup;
+	ASSERT_OK(trigger_module_test_write(1), "trigger_write");
+	ASSERT_EQ(skel->bss->flag, 1, "check_flag");
+
+cleanup:
+	test_raw_tp_override_test_run__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_raw_tp_override_test_run.c b/tools/testing/selftests/bpf/progs/test_raw_tp_override_test_run.c
new file mode 100644
index 000000000000..eb6d24e1c737
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_raw_tp_override_test_run.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+__u32 flag = 0;
+
+/**
+ * This program overrides raw_tp_override_probe handler in
+ * tracepoint bpf_testmode_test_raw_tp_null_tp.
+ */
+SEC("raw_tp.o/bpf_testmod_test_write_bare_tp:raw_tp_override_probe")
+int BPF_PROG(tp_override, struct task_struct *task, char *comm)
+{
+	flag = 1;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 2beb9b2fcbd8..7a49178d2343 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1628,6 +1628,11 @@ static struct bpf_testmod_multi_st_ops multi_st_ops_cfi_stubs = {
 	.test_1 = bpf_testmod_multi_st_ops__test_1,
 };
 
+static void raw_tp_override_probe(void *ignored, struct task_struct *task,
+				  struct bpf_testmod_test_write_ctx *ctx)
+{
+}
+
 struct bpf_struct_ops testmod_multi_st_ops = {
 	.verifier_ops = &bpf_testmod_verifier_ops,
 	.init = multi_st_ops_init,
@@ -1665,6 +1670,7 @@ static int bpf_testmod_init(void)
 	ret = ret ?: register_btf_id_dtor_kfuncs(bpf_testmod_dtors,
 						 ARRAY_SIZE(bpf_testmod_dtors),
 						 THIS_MODULE);
+	ret = ret ?: register_trace_bpf_testmod_test_write_bare_tp(raw_tp_override_probe, NULL);
 	if (ret < 0)
 		return ret;
 	if (bpf_fentry_test1(0) < 0)
@@ -1701,6 +1707,7 @@ static void bpf_testmod_exit(void)
 	bpf_kfunc_close_sock();
 	sysfs_remove_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
 	unregister_bpf_testmod_uprobe();
+	unregister_trace_bpf_testmod_test_write_bare_tp(raw_tp_override_probe, NULL);
 }
 
 module_init(bpf_testmod_init);
-- 
2.43.0


