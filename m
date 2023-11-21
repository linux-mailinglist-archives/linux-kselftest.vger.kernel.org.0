Return-Path: <linux-kselftest+bounces-353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEDC7F21FB
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 01:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AC721C21806
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 00:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327D238C;
	Tue, 21 Nov 2023 00:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="mmF5eUNU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01olkn2025.outbound.protection.outlook.com [40.92.65.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E922FAC;
	Mon, 20 Nov 2023 16:11:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hj3OdIg7D7wqQSg3H68xRBqHrA4YYIbSqi5JRDRKS6kuBLhemcOhwejqxMGxvfrRQnDyG/t25oiX8JiBZzqq7qYiAlww0U9DVfGuOcP11vEy1AHJYX9YHK0ljB8edFBRjbyJuY3NSZKXJsONlkEBMUyMzvtE2sK09q+vyiplB4R7wiJHhladdlccpBV46RomCCWbwDxFKhBCjv4i/bvu2N7ApFTHNcrr5HuMUMORwi2241xvw44+dSGspHllxHaugPEKf8GAFf1MzW1ghP2qnbBUFtwB1aUCv2uzfG5PUf6vIjACyN36mz2izx2vp/TcoIS2/rp1y2/SnMxOdzkfoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEV6FSvKBUg1qgQLg6TT1AC2iHwQLooeot5R9UOQzCQ=;
 b=LUOMeB12b0joju/0Zp/HBcKic012Kv6OIx+9uao/BF/SrXZRHg5l0zZiYt7Z26uVmSTzmTDDMT489Y+2xMLIZFDq1Qogt7d38COCPio/Y4CjmdbCOFKHVZUygAkV8Z0ym07eKBZm71SonaY0GX59sfwrDbmOfpe7TXEGB2VlBzGFFMfOvUpP3qw0rYVrjO21h0pJSDO1ObnqVJ4dMJRR2uvKS7DR2EkiEv5M2GvAzadt3yTy16ihTOBwTyU/vLAnXoyGiCXCyotk6PqJuJqIYkvoUyK6Ku01Nb1fbsBx4D6psdwzrbZr/pxPjNg0fRbcF9caF0bfP1QR74s0MewRlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEV6FSvKBUg1qgQLg6TT1AC2iHwQLooeot5R9UOQzCQ=;
 b=mmF5eUNU3EzBf04DJ46VbeCsvyeQgljRqyTaLZTgCJ/uhIa0YL+ty58On2cNASs0M0+Z2+MaVV/euiLvuAVI0dNHYhCdVAD1hI6NV7ENEy4MKcbAJnzZNTW1HOjt3CU5gF5PhfTwvEn/U1DI8pNiQx5XR5XJJrerUz/wMZJu+Ge353g8rpigf0A5ADdEVgd8TgB7V+fXYzJvPeVjs4FEBkbMLxfS9i+V+vquT/rjV/PiyJ3LaUAjIeRqeVwuXaGG/64vLTpI350NUDmX18kZ2x2NdU9/8duSk1HqEPA4MUZKuT6dYHeSgTB0CU3JC+Yzo2+aW14ZunB6VGaLPGvdGg==
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
 by AS2PR10MB7477.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:593::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 00:11:50 +0000
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450]) by GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450%7]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 00:11:50 +0000
From: Yuran Pereira <yuran.pereira@hotmail.com>
To: bpf@vger.kernel.org
Cc: Yuran Pereira <yuran.pereira@hotmail.com>,
	andrii@kernel.org,
	ast@kernel.org,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	mykolal@fb.com,
	sdf@google.com,
	shuah@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH bpf-next v3 4/4] selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in vmlinux
Date: Tue, 21 Nov 2023 05:40:41 +0530
Message-ID:
 <GV1PR10MB6563ED1023A2A3AEF30BDA5DE8BBA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <GV1PR10MB6563BEFEA4269E1DDBC264B1E8BBA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
References: <GV1PR10MB6563BEFEA4269E1DDBC264B1E8BBA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [JDLWPmLeA0eLagYv2ue0MT27N/ICeQkd]
X-ClientProxiedBy: JN2P275CA0012.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::24)
 To GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
X-Microsoft-Original-Message-ID:
 <20231121001041.421657-1-yuran.pereira@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR10MB6563:EE_|AS2PR10MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f2328b-f843-4611-eaa8-08dbea267542
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NS24g2DnoxWFNSyLkhbSLja6G/JSLLwPte3nr4QkxhTNFrebQHHKs0xYgeDhGID/rrZHBgwNDtD7uYjK6oNyPcZE+rWa6H8GpvZ00R/66uGxTzM4VlHwFZJQxH6ejSlL+A1gFGKVPTeKT7+9BiUEhuwj1Thx1oIgBG3+EZA+jPopFiW0KtOkhUEfQ9ibT+I1klRd5NfCz0Yvud3D2VYtdFUe77/GJd/xxCdccTci06NMTzU+bommktvIw4Vo/1yGe0a41CxsiSlEl+vP1A5jPAhfS1d9XAOli3kjeO+vheOOXlnipziyq1rWmCNIiSLdRLzxX06yarli05PWKChgkUEbmZK9tSjHVT55nvwcPi0L/H3Pou5ifzxy08fUHchCx2ofMWGWCn7wRs1K3gZyrtQhUEP7tTLan9dR+0SyHSz0r7VSQDq+w0uh5ZmCkowpuhvL287C8Z7beHbtygkopZI91JPJOCzqAtwjZhaXdf1E3h6jL/wNlxRXbGDGV6pN3x3fYBYSaNaCmfxlu6NctfWtC7ifxvXQPCg1rhuen/KkBr7mM8cKQtRqgOc51AkriVEVMgOrFhtJfEo33sexxITSEAuXAlc4aXt7QpmayTM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4DSfMlgQE6YPc5gos16W5U5qyhWbsqwmGS1US9fvbAfPP+zMh5y5e2LwIY+n?=
 =?us-ascii?Q?maP30he6DVDsQSbUDWzfx0kwSrIlXT++KvkzBmxd9wa9e0ua8ONIvhFf6g3u?=
 =?us-ascii?Q?oMgb74gwDUZ5ehI3ADSMmMaa2jz4PiBb/XhPhbtdvcxcJL7/aEi7qOPJCOUi?=
 =?us-ascii?Q?o3xyph9Dwp/HRxqc5mm2yPufqlETTxxz0i5xOoJ5b4eA22L6qcxrJCnBngUQ?=
 =?us-ascii?Q?a5/RikylXM5yCWuz2Jw8SDCYiN57cMudJYYgcy+OzbBYzX6oJ5AlU7pzVfuo?=
 =?us-ascii?Q?YE3Tlay1nOBFgkOf0h9MRqQVjegI0Ewf3HcUPG9KleJcC8e0e3hk25kiy/8M?=
 =?us-ascii?Q?Yy+VqiiS4J8lM4Cs2SmJRKXr46Sr6g9WL+YDX6ASo25FqrIgCLgl+Hjiuo4T?=
 =?us-ascii?Q?S4T0A7c1zEU5p822lYQ/sUGUwU3OctX5wEhUeFjtDrM3nIUyn/MJQpSowxo/?=
 =?us-ascii?Q?gnqgpcoIKyDg5bBrerLSkd55GePBAIiIQkA0/nFBL5y5obQVlzOUWtapIy+i?=
 =?us-ascii?Q?YkpKhy2wq7LMlQrjJLd8UzP9gAhFSGSduAgWGEbPAoTCsNyXtOTULPl57CNo?=
 =?us-ascii?Q?OZcUA17IRyKBk3RKfIdGoTYtoueQzwoDM+xgj0a/Q5YXs55bqKu3onm/zmxd?=
 =?us-ascii?Q?LKRgPYte6X1wYK4g/ZoZ5ztFzLD/WkjyPRZhQuDUGiuLZ08dURc8yDcRUIbc?=
 =?us-ascii?Q?z86YsIk7V5tsUk41nLskTe3eed+1lBCj4KGULxnddoCo2QORFyQpgVtwyviL?=
 =?us-ascii?Q?7Waxv1fbgbDuS+gwN11aI6P410iJsXzmG51krvXNEbdZupPpcu4KpKSbj4/B?=
 =?us-ascii?Q?ZqkGFX17xt/wRkcLqor4+3CMUhul2aWQ0N9qZfBGvmu9LL9I/OTHBn+lT3EL?=
 =?us-ascii?Q?xCYHqWKo1qh6H5HOn8ediPlmBTPjE1OezSbW0kL+Id/NktJzrE6+lXNgb9Gi?=
 =?us-ascii?Q?qLiu1ps61pRaRwiTBnNOpDoxNTil4ITc845OeX706JCDZs+3lHe1mFxpeOK3?=
 =?us-ascii?Q?v0RqmdIz6+Zh/WVP3b9jsEPgdUfjlZyhBH7fFsBwJ2Uf5N3SC6dbxX56CGka?=
 =?us-ascii?Q?yb7Q5dU7TgDCPJRn3iR3DU7bibdmjXfpoyVf0KBUJajXxlm3LkCHACwQuDy5?=
 =?us-ascii?Q?vHCKQE0cx//ALCwqHKERcOa2IS5QHTE9Y5hDZxIydKOHpKy3HEhwfZn5YIOO?=
 =?us-ascii?Q?nbO6i9pnsFulEDh5tZ9v7uOz2ATGJ33JKdkPJ5Q2ogbV9rDxQGWO03SHIVc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f2328b-f843-4611-eaa8-08dbea267542
X-MS-Exchange-CrossTenant-AuthSource: GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 00:11:50.3329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7477

vmlinux.c uses the `CHECK` calls even though the use of ASSERT_ series
of macros is preferred in the bpf selftests.

This patch replaces all `CHECK` calls for equivalent `ASSERT_`
macro calls.

Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
---
 tools/testing/selftests/bpf/prog_tests/vmlinux.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/vmlinux.c b/tools/testing/selftests/bpf/prog_tests/vmlinux.c
index 72310cfc6474..6fb2217d940b 100644
--- a/tools/testing/selftests/bpf/prog_tests/vmlinux.c
+++ b/tools/testing/selftests/bpf/prog_tests/vmlinux.c
@@ -16,27 +16,27 @@ static void nsleep()
 
 void test_vmlinux(void)
 {
-	int duration = 0, err;
+	int err;
 	struct test_vmlinux* skel;
 	struct test_vmlinux__bss *bss;
 
 	skel = test_vmlinux__open_and_load();
-	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
+	if (!ASSERT_OK_PTR(skel, "test_vmlinux__open_and_load"))
 		return;
 	bss = skel->bss;
 
 	err = test_vmlinux__attach(skel);
-	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
+	if (!ASSERT_OK(err, "test_vmlinux__attach"))
 		goto cleanup;
 
 	/* trigger everything */
 	nsleep();
 
-	CHECK(!bss->tp_called, "tp", "not called\n");
-	CHECK(!bss->raw_tp_called, "raw_tp", "not called\n");
-	CHECK(!bss->tp_btf_called, "tp_btf", "not called\n");
-	CHECK(!bss->kprobe_called, "kprobe", "not called\n");
-	CHECK(!bss->fentry_called, "fentry", "not called\n");
+	ASSERT_TRUE(bss->tp_called, "tp");
+	ASSERT_TRUE(bss->raw_tp_called, "raw_tp");
+	ASSERT_TRUE(bss->tp_btf_called, "tp_btf");
+	ASSERT_TRUE(bss->kprobe_called, "kprobe");
+	ASSERT_TRUE(bss->fentry_called, "fentry");
 
 cleanup:
 	test_vmlinux__destroy(skel);
-- 
2.25.1


