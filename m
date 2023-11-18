Return-Path: <linux-kselftest+bounces-267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EB37F020E
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Nov 2023 19:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005D81C204F5
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Nov 2023 18:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326B810941;
	Sat, 18 Nov 2023 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="qSIEa2UN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2017.outbound.protection.outlook.com [40.92.91.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FD9F2;
	Sat, 18 Nov 2023 10:45:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmmsjBTf1nZoAgpszJZZJCxqIlTtyWQaQWQZtM8F5mDjc38n8xbL+bVI/1KQQVR0UG5w4vHXOp1fbG24r11Y1GZG9xNJPTNuHPJCD6BarydvSi1k2cHNnFu6Ew90nAetsM1i3BKSHpLP1hr62yjWb6LjMpRfLYHdkNUIT8O+Rk2Fe/Pcg3Gll/XBYcx7JtpCARNewg4bDpOTjljhg9BphZ6sQTSTOFCafZtfyxjSQnnZ36douIwW4qCOZOgwLr15MakVNl5zYEJDlZnzi9Q0+0FS5eYiz7VjgMsp84hX3UC9JdZmXoH1wV+Z6VH+h1ELU208bVbTySwvv/HUijHqPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpgZioiHFXVOmVOt3m5Jvrrc9VUKdE04J+X25ImEGOc=;
 b=eSggE0kNH7eBc6457IlqimgI7ySI3fISM7KcCRd+Sp1i15dSOIl8D9LulzsvRnihQ3sS71wnP9Sk7aofB67RALUJsupgvc5RnZ4jSUM0KWQrkd+s4SbBd3Ka3ocZW7fKPjdVp7h2INYWUKdQS1NhKowBcpXpNOayg7SdzROrDHaSP8oR+r6ID/qXQrGmJynUF4kZm5nMWpSAapiDSOME4u5BVobjzi4t5xX8MIdABov3L6m07uolmmXWmxQS6ul+MXTDQZrhqunq11pOfEsJDhWu+g17+OAdwASQt7nWBLwy+HCkQuHHClyIclde5ZfWyIM5ReKK0cMqQwpsWQwdfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpgZioiHFXVOmVOt3m5Jvrrc9VUKdE04J+X25ImEGOc=;
 b=qSIEa2UNlkpmGzMZXQEF6RM0Tn4ghOJXDzVhw0bA0Usvx63xweXWhFr75LoozzZgAx3v1PQ1C0wKlfR2R6r3HRek6J4QMAtk6B6V4Qa9tJmZyBr3zy2U2P3ydlXvX74EHIsmFr1hmEAxyjSUkINuh5DcBjz42EP9xA9sUVgOB1HRL3QDXV/9E5Eh+PhaADyh9NYS0INxSYcIAX+hqHOP1caaq4x0GiKyQtP3QhIVBTYZm8jNStuYo2nlHlCt+e/JXThVa9bSfQpoTGl656D3rzSuDpKCrbP6obIUu6sNPYW4A4Gk+Yw9zfxWVzplApKcSmR7Wp+48ow/+Yje2ItEHg==
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
 by AS1PR10MB7936.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:471::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sat, 18 Nov
 2023 18:44:59 +0000
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450]) by GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450%7]) with mapi id 15.20.7002.025; Sat, 18 Nov 2023
 18:44:59 +0000
From: Yuran Pereira <yuran.pereira@hotmail.com>
To: bpf@vger.kernel.org
Cc: Yuran Pereira <yuran.pereira@hotmail.com>,
	andrii@kernel.org,
	andrii.nakryiko@gmail.com,
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
Subject: [PATCH bpf-next v2 2/4] selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in bind_perm
Date: Sun, 19 Nov 2023 00:14:29 +0530
Message-ID:
 <GV1PR10MB6563DA27C0B42E88881B6534E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <GV1PR10MB6563AECF8E94798A1E5B36A4E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
References: <GV1PR10MB6563AECF8E94798A1E5B36A4E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [d7GfQLp0rHVLD23IrrF97digOFuZwO/8]
X-ClientProxiedBy: JN3P275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:71::17)
 To GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
X-Microsoft-Original-Message-ID:
 <20231118184429.231463-1-yuran.pereira@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR10MB6563:EE_|AS1PR10MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: 640a8ffb-8465-492e-abf8-08dbe866774b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K7yfJjMruJ4hgLHDUECsSGenJnwyCBjCreAPz7CCYWaFzsCAExzz6RQdWfrOoKZXVPDrbjCMagHqJS+GiKhouCyutKxAqb1VniOYKPKu4B38h2YXvbOReG4LRMu7QvSC/HpTY9Xx6rDICn2goT7LX9f0oYq+9saS9PYcyA+dOZNlTvA3oqFpGaIz5b7cLkqGvlQCiHUdV0AgoHMYmPDaUxEE4kMH9/sFrneqUgHlKwR3EvSpi7fgVUr+XYztgADcdF7EV/SRCIB6uf7W8nRF8V9+DZton7ADvCVxjkQtuhnA/JpQw/Jp97GhEEV6ELdYe70EwI+zAYFdCcq0CQpq2ysMpts6WsKJHTLy0N7nIpSyRIbK2y7qatJjI5ED0mgqvmGFi+x9MlBb+ify/CG00PkULbhI81TS2+29H4CtI6JTIwebgcrOCMxJol+8WkIXRYmFN0vHhA/JWI514pXf4vMFchO1SlHb9Zi7Fe7zaUcABL+CAirFd20rrSTMXIuf1LLzJ4DP+p9lLMEN2PDcbhf9IQPLOoFJHTwWmKMo/t0793obYjGY13IoBiT5EJM0pljlTz9HOX3h5Y2rD6gujwcHvYtxlOu7hbUHg5r6kLFIU4h7d1GiiA8W7QRFXDgQ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jk6XEUBoVLFzdDXI3/RaAPrPmsKao3huQfWk4V3ONEjBSvRcL0zAF4moNbn3?=
 =?us-ascii?Q?tmXfF5q8RDaYaMvp7Mzqn0qIiJUD8sLOGshLZ10qH914tiXjAbboKKo52P3e?=
 =?us-ascii?Q?8GSLQu8X+fUXfpGEUteeTrIrc9dJwoD6aZkxgkgxPOevVJIuEkGvrsFJrl5E?=
 =?us-ascii?Q?U1G31NP6g/xDsVTxHg5qllcGfQw6kxJppT6gnLa6Oo7kbRrAFp19jAc8Cfei?=
 =?us-ascii?Q?s41gkravKe79y/cNg7tQXLhetDEDBuQBy49DGAKuo428mOLcSdxZhN/1egUk?=
 =?us-ascii?Q?PaSytJKecKEnKEx1JgvMWK/x7ob3jIOiXuXvcbm2rqmtMEf1gi71j7aELgFC?=
 =?us-ascii?Q?s3+BynW6isESh85Sit68xrOvUInY/PzshxbX2x6sdhgdf2SN/2ji+JawX5Xg?=
 =?us-ascii?Q?wnaLlv3BGMtoFhYaXZ6V++lrKbyxNKr7V20MD5It3L6+/lBL990EvPz6W9pD?=
 =?us-ascii?Q?2bd1oszrM3xlTsbbEGdqXQ+KRcouGMRLoHPAZb1nC7pTlPFWFK7d+zxvgsZg?=
 =?us-ascii?Q?q6UNcuHFsHGmTmuYiYHG01MHehxzPFrZEHICwps/2aTdkEfhhqGphfnZ4gtW?=
 =?us-ascii?Q?Gn+s86C7B2jwDSwG4jnRLGd4q3crKzh4BoZLZgiVQ2lfJDLo+JABqp0VjGvn?=
 =?us-ascii?Q?RK2nPyvdIM7uxw5to4U7uTnTAkmwWz3TChITuAH+RTGya3s5d7VOtRfzCamO?=
 =?us-ascii?Q?tFWYIcyJBfYQ7RRFWsuihIgMkSgdC5wAx2ayftqLuwilNJw7zZXCq5Mq7RY8?=
 =?us-ascii?Q?Edw9BLoCdS3dBYXAdb1rR+qKPVVlBn5FahD/obNRkTWqDHdrDC5+EWjRMEYb?=
 =?us-ascii?Q?lU8aifWOdocxKq0bI1pgX1HahQV0V+mfpnLRVyIubcRFiZw6plbwBFuU8A9l?=
 =?us-ascii?Q?nH/n0N/WtaPL54S/vBuECR0c8bFggrNWgs6t59xEhBLPAyTpGJNaZmULc8v6?=
 =?us-ascii?Q?vzlzeC5tBoKQ9oOoOE04mi2LJk5FY75MRNAwUfDPA5qmIxq8vmtlCnO9Gmx8?=
 =?us-ascii?Q?ECBdX8J2osHcthBcDLHqKMh2fcTz/2Gq7Eqs8hsPNxzEfOc+5sXDIGZNAv6b?=
 =?us-ascii?Q?r/cdA9wyf0U9qoxADnztgreOQgkzw71wlg8/5N1ChLxCA9St2bNBAuI3imWW?=
 =?us-ascii?Q?Ei+jfxMBWfzP0AZKMM2tt7KCBKmM0iiM5gkBUuuzjXWMBlvOtAObhlzaAKCU?=
 =?us-ascii?Q?4ftOYILxXBOtsbslStnl8o8nO2tZDvbsemoLSeQPKdBWuqur05zup2BwCAk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 640a8ffb-8465-492e-abf8-08dbe866774b
X-MS-Exchange-CrossTenant-AuthSource: GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 18:44:59.2032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB7936

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


