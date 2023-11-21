Return-Path: <linux-kselftest+bounces-351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F44D7F21F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 01:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D83DEB213DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 00:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6CF38C;
	Tue, 21 Nov 2023 00:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="RdqNrDBU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01olkn2023.outbound.protection.outlook.com [40.92.65.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5FF95;
	Mon, 20 Nov 2023 16:08:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONnCQzX4mhqXBl9w1jMM8Blf1PUZBMtHKeFutj2w/65zbQQi6i96ygQsU0QtLtyPo53RI9JkJzeabc+cbP2Q8jNu0nd7gZKYwh0X5DLd5am7kF6kFK1tNeIBVoX6AvCtQedVNhqakAMpqwi2gQIwsDYs/o4Jx8EZ/4gxyjgLQLRsOCau7tDdTgwYGNw059q3mw5YvYMWKKDnHO7KzhKmFznUhZCSRI66NEffieHWFBwUqVFf+nOlD+T54dDIxyItejVbcS5P+Wx+TCDi/KrnvUY/vBPjlj/ATtJOExz6AFx/EONr9DgwzNKHEWBKLa8nMx7iAuiimd7CsJXrkYaQxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpgZioiHFXVOmVOt3m5Jvrrc9VUKdE04J+X25ImEGOc=;
 b=mLIQ4N6dYm2ky3YdfpOJImZarbb68DG9/BFPmzD6Y4sqGAIP3Jc3bEj6VxJovOwZxA8B1HwGO+bQx2jwxDGd+qckqbknYm6llDeBwE6sfln/vcmU4DSWKfWTUxvr1mSiJStTgGUol2tcuHW1JWtTzxBlJ3gZ7SL1DQ571UkeC6t/c2dOaHppJZrT6FNLm7ZO5aWXGeHSz5h8Vq3yFgScA9xE9aTCf4jvc/XYxM7CITblZuEzbTlYnOVmLGoAjkRV/8zr3W/2FlrYfXjv1rOpshPyuaU6Fh7xe22aWArfFi2FIPyeFprfu2vMngvEbBbffvJ21TN/mctPARBOAKXTGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpgZioiHFXVOmVOt3m5Jvrrc9VUKdE04J+X25ImEGOc=;
 b=RdqNrDBUval7utcV7TmPI+q38QxlJvDBSi9fm2Eut7YKujK1i6UWoDs28BGOvhuDlLzeqWmLxZA7rnE9JRnLTsp01YIQXoW6lI7YIvWLXIjNeWuHwu77O2Nj36TjR6cm85jW0JMTeNoIS4mX0y8GAmsyBVVuE28FWpKGNUC1i5+1pWiJQtgxTDD3DGdGOLH0ST7peIExDUwIkfBAZomykS9QP++p0HHGDbzX6BYBWehKEzc2gTUCfZKHpDl+NWrIS7g1wTQwcBLieGZmpgk+oEmmN3wfksezDurtY5i9NvMcf4H+8NcUCX/h+cy1fViOjCOi8RozFgTfGFekxR/fDQ==
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
 by AS2PR10MB7477.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:593::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 00:08:13 +0000
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450]) by GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450%7]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 00:08:13 +0000
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
Subject: [PATCH bpf-next v3 2/4] selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in bind_perm
Date: Tue, 21 Nov 2023 05:37:43 +0530
Message-ID:
 <GV1PR10MB656314F467E075A106CA02BFE8BBA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <GV1PR10MB6563BEFEA4269E1DDBC264B1E8BBA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
References: <GV1PR10MB6563BEFEA4269E1DDBC264B1E8BBA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [cfuuiBYTyYKY8XKatAoyLyXoEV6aUwGc]
X-ClientProxiedBy: JNXP275CA0008.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::20)
 To GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
X-Microsoft-Original-Message-ID:
 <20231121000743.421363-1-yuran.pereira@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR10MB6563:EE_|AS2PR10MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: a3c6f762-e668-4fd6-2521-08dbea25f3df
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Qeiej13jVPmQodDHaJ+4NKCSLSzWgamDzeCNgF7tBZCA+wFF69Byki2CLQDO2kw/boLWe30zY/sJJxRpI7nl+2utEWH8pcp1apSbNBXRzj1YliOsE8OaAyA/kl5LSOg3NM5IEMbKr8jOZoVqjtFdudpuQyAXqRGTf5xqK9ud+BMrjzSu1uRbsZGLIt4gtdy9mLq8IB9fKXjVRw20AfNcPP8Fz3c8Qm2GXfoR3VWrXunTxcYmtXvqddsvDrGXtAOPfEtZxV5M7eR7qglB58WKG9kKeclusJQzBwhw2Nz+QV4LjApRgNLEsEamp4wGfAUSWscHzbvBaM5r4uc4QDTwiofG9eYpcOKlJvJP402DoElDLUm5FLgqhCYEtSUlN+6SOEEGGnmzY2jSe9Deuh8g5LRZNbUOjSPXESwpUs5RP1LlRbkyAONu6GPdxhUCt/O2nSZ0zXhV8HJvaXwPPDuBEnIJmhiWk8jE3gXxTlPfZbjfXksANNemf5B3RX2XDi8LpNBYfLeq6yRBSabm6CLe2ZDcR8cWukRMjG+3F9657HmBZN2xLZ1NmbpJEfSOFMidu1s4j6/+ceQjm6ySw3ia4G+S470UYdbcqDBBGxBo2JPg+t58KutOMZvbd1giQjgf
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0VrYSza5TW17HpBZHh5AdKO0R5X4vKMez2Q48LrDEfIDQychsS1S//3hHPTk?=
 =?us-ascii?Q?Xs0pVuFvv96li7MPFGjFHEVrF2a/AfSoGZ8UdidYasUgwVce64XatYqcgdZM?=
 =?us-ascii?Q?aO6ccbr7rJIOoJa7EUBVUJMAY0oPfX/9wa32rXY33VxYiQ5+w0w1JkA14zPN?=
 =?us-ascii?Q?zxnT1+HNY4Xh851MNw8DTLhS2VcR83ekdpGj5tWyc53woBJOuAF8oS2j7x+x?=
 =?us-ascii?Q?gCel0BZ8UImXyzAaUFwjm9Vkjt8/bWGwSNUT8PVR3+wAKoDJxnw6OSQ0foAw?=
 =?us-ascii?Q?YmMCOHttmKzXIDMZwpBVQEjHbjpP/lHrNH51xmcTqJuNzt5hn/RYfzZCB587?=
 =?us-ascii?Q?i/06ZNPBBYCp8n5PeJSbC23ZbSHJ38oN0pQGNo2m/r9VACXl7mW0Sg3U+I2v?=
 =?us-ascii?Q?WB9Up5zRIhwVESbxkAhkYWSmss/Zuojpc+llABDNLBw6Vuu5iP0K6ysRMWe6?=
 =?us-ascii?Q?kxlqLWdfRPEKDkwv+iRGvBjs21YC2dnWOclN8U1LRIuAdaq81pnxZRoJyITL?=
 =?us-ascii?Q?7DIO1fyDi7efnFyu8vXN/o9gqsNp+M1z9riF1pOM4hT4JxH+QBHiw4bftTUl?=
 =?us-ascii?Q?tzKVBNK/1pecA9zaNQ6XlKvvXUuS0ushYFLrOYcCNgMmT4BkuvwL/rU8pncg?=
 =?us-ascii?Q?xZcnWglWN9HeYBzfxLMJD9SgWeZAra2cFPt/jwimt5ERSI3SxEJMKkrnngJJ?=
 =?us-ascii?Q?5l0PsAHi19rufj8S+iAybwqkla3wCdvPGbGMa1+vXq1NgEEkpw9TagTWRutQ?=
 =?us-ascii?Q?e5p7hpVhtbIxTj2vuc9b1giWDBxNeAU/wIHwIkWUQ+UtooGZI3YHT2JQqBF6?=
 =?us-ascii?Q?HnrvjBWi09rP2+Tbz6BrxN+/tU/7uEvw2UOwH33ONvPguSlIcRtEBBP2w4rm?=
 =?us-ascii?Q?YCM8HRnDyInoP3KN6mmxX6W20njPqz0VDuDoiYZbFbxx/RTqUlDkpTwoJGR8?=
 =?us-ascii?Q?tL2ztuymD++LT1OKwxBWPeZe8WnshlFx8hbFwr/Oxi2wx/Z9uUAKo2iZEFhk?=
 =?us-ascii?Q?6TIyqRPt5OKPATeV8555hcbqWWaLxCixf0+/JNjseUIzCnz5dM8f799s9vp3?=
 =?us-ascii?Q?nYSeF7kGonaFdbO8f1DiCEV9BOO5FSz6JNi7HsrZObjzH04qCIbNpMI9iuxv?=
 =?us-ascii?Q?PFtNKR1UwroVjHGAL+ZpFVJYc39uuHwApRg/GIVg3XH1lJoqaQD2Xgzpplb1?=
 =?us-ascii?Q?GVB4PhEWgQxY4DCpRctKmNArC09+6vtJ5oi7INZl//3m1PhVkPdehotj33g?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c6f762-e668-4fd6-2521-08dbea25f3df
X-MS-Exchange-CrossTenant-AuthSource: GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 00:08:13.2656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7477

bind_perm uses the `CHECK` calls even though the use of
ASSERT_ series of macros is preferred in the bpf selftests.

This patch replaces all `CHECK` calls for equivalent `ASSERT_`
macro calls.

Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
---
 tools/testing/selftests/bpf/prog_tests/bind_perm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bind_perm.c b/tools/testing/selftests/bpf/prog_tests/bind_perm.c
index a1766a298bb7..f7cd129cb82b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bind_perm.c
+++ b/tools/testing/selftests/bpf/prog_tests/bind_perm.c
@@ -9,8 +9,6 @@
 #include "cap_helpers.h"
 #include "bind_perm.skel.h"
 
-static int duration;
-
 static int create_netns(void)
 {
 	if (!ASSERT_OK(unshare(CLONE_NEWNET), "create netns"))
@@ -27,7 +25,7 @@ void try_bind(int family, int port, int expected_errno)
 	int fd = -1;
 
 	fd = socket(family, SOCK_STREAM, 0);
-	if (CHECK(fd < 0, "fd", "errno %d", errno))
+	if (!ASSERT_GE(fd, 0, "socket"))
 		goto close_socket;
 
 	if (family == AF_INET) {
@@ -60,7 +58,7 @@ void test_bind_perm(void)
 		return;
 
 	cgroup_fd = test__join_cgroup("/bind_perm");
-	if (CHECK(cgroup_fd < 0, "cg-join", "errno %d", errno))
+	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
 		return;
 
 	skel = bind_perm__open_and_load();
-- 
2.25.1


