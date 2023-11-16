Return-Path: <linux-kselftest+bounces-194-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B9A7ED9FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 04:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A7EEB20CA1
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 03:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4776FD9;
	Thu, 16 Nov 2023 03:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Pd69ZkF5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2078.outbound.protection.outlook.com [40.92.59.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E57199;
	Wed, 15 Nov 2023 19:23:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwPrRS6O+siegdK2UwgZ7Xd7jYHivMKanZHUyEiUjwz1wNCtQQRF12EWLyy5AnwmjnbfsglSSeqG4nUyBwSJ/nXpygflqnPjPYLWDxZFi9GojVzmcheDPCzkrFbRN6qnsz/r7b1PqHwuVT+Gj+o4b+XkCzT2xNTJJ7MRL1sRnOgflY9V0VGPLwU2fozZMAeTPWPV5Fk//mLUsKybmvAAQv3CeC7ydSsOPwai3ME1xDvXX4EZYh6I6WMDXItczb6aGU1mc/LylKCskyVEBpOvj1vNqutMzm3hIsaoGz8ZzAkN2kqXEGRcB2yoRUVgZ/CJJGtlpVIAty5n6R+YKn7/bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEV6FSvKBUg1qgQLg6TT1AC2iHwQLooeot5R9UOQzCQ=;
 b=CXp4t9LFA8qizmseF/6DYraK6lwG6H9kvZh6zYxU2L75XN12RNcVmsGxG7Cpgbp9CrNozyOKdDTezWMcaTVOh/UY6rWky/PffoKK3nw0fXWsohrl/7sdBrUFh+huxu5ED2PpOCmpT33O8ty5lk3Y/eCvcNX1dc/oAjsW9Z8TeNBKwLQW6EyhSQh9qtsytYJF+r4Ox6SCQQaihjx5zXsfomGvbzGB9EyKT+gYRKMZKJX27/Su6pYfna6N3YKMQratqvy2Xq+C51m1lMQvLWT1cNQWx/OVuR3+JJ9hFCInaJXaxaK+3vk3mu8tLG20MdKgjENboKR0HDHVDptUaOnXVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEV6FSvKBUg1qgQLg6TT1AC2iHwQLooeot5R9UOQzCQ=;
 b=Pd69ZkF58wbDXztHq/KKSSQMQRPk2wRNSa2/DVMJoXXJMTh0WR6CUaRps7gYbV4wAHvnQ8LqU6JaQvXEU6ccPsP2LjktWvdoCrVcDbXMtK0K82PVumOWMZ2Tan496ZdqO1XakmcfbteP00oa0uNY0Mi9SNeg8ZyRAoJeDlpnJjwzZR6CTDRfNmucgudMR62JJC6EStrWnyGWqMPRLAt0pKvxGcVFMrfYLwYxW0koAwF2CFxvJDi/LWfJu623MaWsqSHt9LL6MN1h0PGjr7AN7147FQPF8EwuzMwv/3/hB2cMspjtwqf1i1DWe/htFRSQavILp3+P0VVRK7l6yz+n4g==
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
 by GVXPR10MB6006.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.31; Thu, 16 Nov 2023 03:23:06 +0000
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450]) by GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450%7]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 03:23:06 +0000
From: Yuran Pereira <yuran.pereira@hotmail.com>
To: bpf@vger.kernel.org
Cc: Yuran Pereira <yuran.pereira@hotmail.com>,
	andrii@kernel.org,
	mykolal@fb.com,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH bpf-next 4/4] selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in vmlinux
Date: Thu, 16 Nov 2023 08:52:43 +0530
Message-ID:
 <GV1PR10MB656384C49CCCC553BEA0BD70E8B0A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <GV1PR10MB6563FCFF1C5DEBE84FEA985FE8B0A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
References: <GV1PR10MB6563FCFF1C5DEBE84FEA985FE8B0A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [iMtSmVnLqn/2ghnN2cAbiWv5/xBu1pCR]
X-ClientProxiedBy: JNAP275CA0032.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::9)
 To GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
X-Microsoft-Original-Message-ID:
 <20231116032243.71104-1-yuran.pereira@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR10MB6563:EE_|GVXPR10MB6006:EE_
X-MS-Office365-Filtering-Correlation-Id: 777e759c-2e07-4ddd-0741-08dbe653596c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dxEroqIItCupgcP7+UoT7Y8mfgqpx/aVbWB5m9OPjaX/+Tt2Ip+FQPKgZrX4to8Ex9oFoeftYwqkoJvwdmhQgEmmxHxZjigqB+KXzrGUzssm8DL3OcQzXKn6uy9+AsqIKuPy2DitQyJ20cbWmLFv/1ewWpkw2jsUN7Ki8QscHgrQ9aeiegNb4E3YHhHdK1aeOPw2EPLQ94+St8SBC582OSRS4juQoeEqqz0wwYjzdAOcrtwxBW7JxYr2dGtbspae6C88kWUZHwzChbrDihmxfUhjtlhpH0dnUy6INVFJIw1IrbqaZJ1+v8uzVJl04USE3k6ydiGfj/K+Y9BTfmnvNrPMo/Z5EPcBHxW38MbrmpaOnhPXbZhbZDUfV0A7WKpNJLDtIkrqSJetXBSEr29p0tXIl7Ds6a1BTaTUU+AanXbps1ujajoCNE5n2Lmio+VELjmkUgWuzLxIY27EXqC5/rCE0IPd1EkflT1VAQmr1veVjDxDKuhU2BqIMWYgsh/9i4iFBopB0YPnpzCo7due6IfivYBbmRrHMnpLVMn0Tlw7p7OfA1P0JDdLqPFRQVPxruK0czmrTgPwwjRVLBJ9LDGCkjdvoT9TeWXmgxtOc04=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NxeMUoE1m6pFTGnMmXhur84xft9QEpoRRTqawZh7guUqeK6ljwdT8NgGVk3+?=
 =?us-ascii?Q?OEqvWiwoqMbfhn1DHElq2KOannlNSpbRa84f3Gh9SYhfhzR8rB7aGaQpi1zk?=
 =?us-ascii?Q?3iTMHCrv1ctntl/m7iJjNlaMLvYGfXb33VjUO0Zx8RefgnVWdKThlR1lESZJ?=
 =?us-ascii?Q?PDBWm3mt55EJnzm6pEAJlCZNKfIpy0WP5CmjjkferJdQfmQ4Oo1g7P4MZWBA?=
 =?us-ascii?Q?7vpFE7C68ALxPros8M2tPDX8BWgtGgWG7OJeWebxF1CMw897R03SiJAjuBMV?=
 =?us-ascii?Q?lQVrwew/+r3iPE7KcPZHJqVUNsoFPasHSlQzW1ChWjnixm1Uti3kdcLe/QFv?=
 =?us-ascii?Q?d/gFqa/K02EJxvnwkFIdffAtYREO/kJrL1lE/Ue6Qm+dcYvNFZqZ+NONvsJj?=
 =?us-ascii?Q?N1Bs8Pd0RL4yWBoffq+rYjjcIyaWUZ2LpP9XosxgylVWxcYKKhv4BFKN1pfW?=
 =?us-ascii?Q?pZbjg8f4IuHMQdUgbdCfHEtqsqwGWY1Opbo5xuB75hlyJN1ctkMi3fjgpcBr?=
 =?us-ascii?Q?v5P/NY8/3e59NrRZQ1HGGwYwE1ZZ53l/4M9hBLd1w4HqlkXmuKkMDKf/ZDLr?=
 =?us-ascii?Q?i8lyeLKbdV4JLTKPoa7yUmBxy0orLQF+zWJ59HorXp6h9J/5LGnQtP5TrVku?=
 =?us-ascii?Q?FUPv9752te4UGwRmvGU9JuAv5DntQoKR60+Z7Mb/opuAuBFtLFj//IE2Otq/?=
 =?us-ascii?Q?lTL3sC1YoeygvQ3+r0uXRNmHjQdxsumvIwTMiLTSz36e257L8I8sfVh68QUr?=
 =?us-ascii?Q?8HCetrAYKw6gkcnKi/ozFTH1/FUPIGmarstq6Kp9w5m4VIyL+aEAv/epYN4k?=
 =?us-ascii?Q?nUVuddxwMhOZMZ/rdyQRGyMtbmah8o+UEolrAlDLDMF4wCQmdc8LSgf6VBYs?=
 =?us-ascii?Q?4aVtPkurf01UyYHtR2EHvb11LeGiOAK+F65XZcNxV4V79SG/7dzeCXpz82nU?=
 =?us-ascii?Q?O7ckhWcTDbqEN10szexLTQCHHpnXKYzQS+KVTCcMBlgiGOT4GSIilpOj3xF2?=
 =?us-ascii?Q?1DO9ajsGgQc/4c0IxRi03RIKfBp+GnW2xncFGNDQ+QQUaY60qMt913/vXNIc?=
 =?us-ascii?Q?wscymakyNji41VOD6jwdZ6e3ZsB2doWuitnIH/TTkP1xNN+2P0+0ysBJCzs9?=
 =?us-ascii?Q?PZaDQ//saONJKCeDmQ+URy3/dvyAwHAPjhVDhI+UmVRuT7IcxmvC0RhI9Rik?=
 =?us-ascii?Q?eSS94HCZCqL/mUu5/A7+b6zMrl9VJjjv1SD5DHswbydJfD+8RFdwK64IX5o?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 777e759c-2e07-4ddd-0741-08dbe653596c
X-MS-Exchange-CrossTenant-AuthSource: GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 03:23:06.2889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB6006

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


