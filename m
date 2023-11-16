Return-Path: <linux-kselftest+bounces-191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E7E7ED9EC
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 04:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4EA61F236CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 03:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C964C6FD2;
	Thu, 16 Nov 2023 03:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="nORFT9hu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2015.outbound.protection.outlook.com [40.92.91.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC8719E;
	Wed, 15 Nov 2023 19:17:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZr6+hJ8Iu4/meg0HUIxb6pHWrlOgGv3uEyA9gXgoWwVfEm2h2MwxtvSUC1sEbL9Y+qHhuJWPstsTcSAs1+/MEHN7Y1WMRt8VO87tKQYtR6rA0NghDALTdc2jfjZv081SPOwkmrtUz0VJNwzGY48onEdTJ30NmT0HSz2MNcMs2yw+R7ov0fMFLrMb2AVB3c+8Re15TI7w6T+jyANFuKseIUgNMVKzsnHruhbE3Ql9zxz70Z0PmeAn5rjO+CZkGMnU6IrOfn/JUczOVol1XQ50mvIy6PNo/wq5BC2j/WgCm7V3n2ljVqcwAIT1NU1baeBozLek3wVOYifsEC5PQcTGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kieiaA/pL+wMfRgL+l0MlG/OcfWJYSk6lI0ghA7o/E=;
 b=bWuTs1ykmLwXjpfK2M5HPWpUaXOn21A4MQbCYrOSZQ/0BTqrYbOtfsqI9fayDWB6pjORcpzWJoCRr2hCpzwtUv14Y6rydRGPml//ZmDCOtcn/HJZNNWeY5XvKHpwgZrU/EN34xRQ5y1sL5Qp0P/IQrL8rL7D1V2dNh9rkEp0s1NIcYCcN1QMcFmyEHrsibFv/HGTAxCn/Izuy6VgH4oPoHL5g0KmU58hl1RGRzP3UD0q/vp6DDGku9VWm8H+FCu9Dmm5ClLuPQJTf1qpUWAr9zmBinIUZ1+4rTwOTBFqZEHj5VI1WM/MK7ITwrli/Z+YHU5fEufes9Ob7Ow8ul47yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kieiaA/pL+wMfRgL+l0MlG/OcfWJYSk6lI0ghA7o/E=;
 b=nORFT9huSqx46XrwtVcICFYD37Q58BOS/0MGWlEveNbSUXspfJtjw3h0ooOrqSs+qVEptiW6PGXSwmQFTYwlP2aYCSwvEMnwiChHIXZYUWg4AaUBwAIKP71a+R1Zih7SI0ga9JGAresBv1mL8xX+WJNHzDVFBJCClgeRG/igv2dFGJceWqtPYiStLu5VhA2Lu0ZO2xMmNMUUcvOrMTH2YgRnkL1iA9VXLs+dNOb+bWcbdu4orQA3JPEAVCoDUFgkEVhK+N650tI3Rt7Pec/tibskZet3/d7rxsld9zYQqP1fDgoen3jgFkDxUzSOEmkb2zmqgVnn43ojnzlrFYqJ/w==
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
 by AS2PR10MB7227.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:609::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Thu, 16 Nov
 2023 03:17:31 +0000
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450]) by GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450%7]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 03:17:30 +0000
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
Subject: [PATCH bpf-next 1/4] selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in bpf_tcp_ca
Date: Thu, 16 Nov 2023 08:46:58 +0530
Message-ID:
 <GV1PR10MB6563A0BE91080E6E8EC2651DE8B0A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <GV1PR10MB6563FCFF1C5DEBE84FEA985FE8B0A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
References: <GV1PR10MB6563FCFF1C5DEBE84FEA985FE8B0A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [DgREM1ts3urqaRvHw9L2q9uXLRFHqr4L]
X-ClientProxiedBy: JN2P275CA0001.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::13)
 To GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
X-Microsoft-Original-Message-ID:
 <20231116031658.70661-1-yuran.pereira@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR10MB6563:EE_|AS2PR10MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e35c3da-0016-4631-e3f7-08dbe652913d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NbMQRAfG6xVX8nh2tloRlSQvoqhbTiQb6I52PhXkktyg2rE6IcRa5ORCqt5JzpdzREOTTxJ4TqLAeqG9qJw0zLR9CwNwTYLOH5+PaUa1Ibx713lypey++AASurc6MHzTkiuS3+eYFjC1vORbLnnKQG9QFQRIc+JtAkP1w2VWoXcjD40ltlObT8J9f0qBJXqjwSdwEmi1mzG0HDk7ptpZQTUyNAD3TH32uF4BPiS3fPZJ7xO9de14YjOeQcpyBU+VUiktgsutL+IGuSEhQaM9pBDSuT+GseV26YJNrB066nbAvJ9btEH7A2mVxtq/lj4mDQtyIkV6DaVzPcLvGDLozuxkFoKhBo/vbRzeR6z0GycWMO9yec6b+ItrUYfM9Rk7OkM+l2LMwzQmgKnFOpv1YVEDuvw1cviPv12frkXvFfVj0KYcLVq6+a/UJsyfiZOlvsZGhHef/IVncfUO8/LacLwVVZ1LiKLQXbezR2YtvXK7N/mFHvGrm+yVH5/U1nU1j50hTfClUEuMfcT5Z+auVjlwRnkdv5Zr/TxzncS4QPVooBAw9JeB1Pqpd3gH8+/Mgz9A/nJF7CIohjHlt/6BzsYHIJF5mUNkTQg5bcOwT5U=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NJZDMNIBQrxmsRA9acRmDHWTGw4rvAjuyGk6TbCyxBVzl1cry2pxrA/RfIT4?=
 =?us-ascii?Q?lPVj2RkNGWNxQ2WGUR9n4bx5jLETGQn71tae4bhujdPrlAhgxyOHldYF+PeH?=
 =?us-ascii?Q?uamJnrrmsRZYrQ8wHt1G723cqSUje7QIsfyDuBIoKwQcDt+HwcQznki4UXG6?=
 =?us-ascii?Q?tUgmc1swu1PyMX62qwWGc1I89N5wVtE+eRtCJZOgqlpAJEJzPoNKS8owqpa6?=
 =?us-ascii?Q?ABQuC5vitzdZmzYRCraVnoaeQh70BwqWYwqm4In0lygXnXgk/79yGs/emvzf?=
 =?us-ascii?Q?BZK7cjHtGxv9ZxHfape2QHpPPDOTJ1U6RQDJfDmXmlQ4O4/CwDN/lV3o3YxP?=
 =?us-ascii?Q?46F9ua8VmX3+v1tzDnowCCuEsbMpcxNkDPl5VdQw6A4HJr0jE1pnc3QtDtea?=
 =?us-ascii?Q?GeRUDyVR+/AHR89IVFo2AAFs1WmFFHVM/D6zeLhob7X5PlEv4PPUBiTQxhYK?=
 =?us-ascii?Q?jbVbHMEIT8bKEusvzODNqAcgscjhVPdw1zAg7qUsujEoIKlgdRNifp6HA5Zc?=
 =?us-ascii?Q?DpiiCFXGUAimM4UbprGzdYHR6ioS0GYhmkHCOwBIigKyzdrC88LRehWEO2lQ?=
 =?us-ascii?Q?RKs2kPSEZ25MfFo0J/MZQoZUgB0ZedZn9FrcwTJO8VSfyQL+nQ1M9heYytwf?=
 =?us-ascii?Q?VWCfKeX0VIdVZ8O+EdWwY5NTywjia+Kyw0vj89cK16MMa8C1MZU+TAdPn9U9?=
 =?us-ascii?Q?IK1+jq8qaEeGaEmJhU78qK3OOCe/K0SR6W9zfwUeSr5r6xuAmx0sl2Bbdt8x?=
 =?us-ascii?Q?tQOToqzc0fPsBGfcGpICrLAJoYHN58p8yS1GN/d9MhPSl8L/CO3ThyHDPTzr?=
 =?us-ascii?Q?CTi29ozqP4YWBmyfAoN3oFhvyX9RZPcFRd1AFYlmmIlVTdpxQ37IsgzWiADY?=
 =?us-ascii?Q?Vy1Z/72yM21m7HCBJHTRRBmfztWw6oJWuPwjSY44/1J1FzIYiQiEWnjGI2qB?=
 =?us-ascii?Q?2o71NwsQ7feaQ1nOB80y07EWQYs6GqKcBK5bjzBr6bZcfKsz9MogjoLtx1lB?=
 =?us-ascii?Q?ET/RWe4Fx7sUNd+eGIO3AfQS4t0PzFgFFKRAIrzteQ6RM8tIH5hFoGXt6m8Z?=
 =?us-ascii?Q?rfR/Z8ZEYQn2kDGiKNUCOM4JjXAp+SunYqIjIVwQ10ARy7ezJPD4yUcjWA2Z?=
 =?us-ascii?Q?T0uC+5Reowu4iutkEGP5lS2JeG3VYoOA5i9FS3TSDGS2NeLZLcJH/LHM/+TI?=
 =?us-ascii?Q?tCLw0QKzlBMTJkkkKPLuJD4ruNKyZWLe9HsASwEOglwmlPOjOJP+bgSQ6Mk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e35c3da-0016-4631-e3f7-08dbe652913d
X-MS-Exchange-CrossTenant-AuthSource: GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 03:17:30.8500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7227

bpf_tcp_ca uses the `CHECK` calls even though the use of
ASSERT_ series of macros is preferred in the bpf selftests.

This patch replaces all `CHECK` calls for equivalent `ASSERT_`
macro calls.

Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
---
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 48 +++++++++----------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 4aabeaa525d4..9f5fb97ac0c5 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -20,15 +20,14 @@
 
 static const unsigned int total_bytes = 10 * 1024 * 1024;
 static int expected_stg = 0xeB9F;
-static int stop, duration;
+static int stop;
 
 static int settcpca(int fd, const char *tcp_ca)
 {
 	int err;
 
 	err = setsockopt(fd, IPPROTO_TCP, TCP_CONGESTION, tcp_ca, strlen(tcp_ca));
-	if (CHECK(err == -1, "setsockopt(fd, TCP_CONGESTION)", "errno:%d\n",
-		  errno))
+	if (!ASSERT_NEQ(err, -1, "setsockopt"))
 		return -1;
 
 	return 0;
@@ -65,8 +64,7 @@ static void *server(void *arg)
 		bytes += nr_sent;
 	}
 
-	CHECK(bytes != total_bytes, "send", "%zd != %u nr_sent:%zd errno:%d\n",
-	      bytes, total_bytes, nr_sent, errno);
+	ASSERT_EQ(bytes, total_bytes, "send");
 
 done:
 	if (fd >= 0)
@@ -92,10 +90,11 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 	WRITE_ONCE(stop, 0);
 
 	lfd = socket(AF_INET6, SOCK_STREAM, 0);
-	if (CHECK(lfd == -1, "socket", "errno:%d\n", errno))
+	if (!ASSERT_NEQ(lfd, -1, "socket"))
 		return;
+
 	fd = socket(AF_INET6, SOCK_STREAM, 0);
-	if (CHECK(fd == -1, "socket", "errno:%d\n", errno)) {
+	if (!ASSERT_NEQ(fd, -1, "socket")) {
 		close(lfd);
 		return;
 	}
@@ -108,26 +107,27 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 	sa6.sin6_family = AF_INET6;
 	sa6.sin6_addr = in6addr_loopback;
 	err = bind(lfd, (struct sockaddr *)&sa6, addrlen);
-	if (CHECK(err == -1, "bind", "errno:%d\n", errno))
+	if (!ASSERT_NEQ(err, -1, "bind"))
 		goto done;
+
 	err = getsockname(lfd, (struct sockaddr *)&sa6, &addrlen);
-	if (CHECK(err == -1, "getsockname", "errno:%d\n", errno))
+	if (!ASSERT_NEQ(err, -1, "getsockname"))
 		goto done;
+
 	err = listen(lfd, 1);
-	if (CHECK(err == -1, "listen", "errno:%d\n", errno))
+	if (!ASSERT_NEQ(err, -1, "listen"))
 		goto done;
 
 	if (sk_stg_map) {
 		err = bpf_map_update_elem(bpf_map__fd(sk_stg_map), &fd,
 					  &expected_stg, BPF_NOEXIST);
-		if (CHECK(err, "bpf_map_update_elem(sk_stg_map)",
-			  "err:%d errno:%d\n", err, errno))
+		if (!ASSERT_OK(err, "bpf_map_update_elem(sk_stg_map)"))
 			goto done;
 	}
 
 	/* connect to server */
 	err = connect(fd, (struct sockaddr *)&sa6, addrlen);
-	if (CHECK(err == -1, "connect", "errno:%d\n", errno))
+	if (!ASSERT_NEQ(err, -1, "connect"))
 		goto done;
 
 	if (sk_stg_map) {
@@ -135,14 +135,13 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 
 		err = bpf_map_lookup_elem(bpf_map__fd(sk_stg_map), &fd,
 					  &tmp_stg);
-		if (CHECK(!err || errno != ENOENT,
-			  "bpf_map_lookup_elem(sk_stg_map)",
-			  "err:%d errno:%d\n", err, errno))
+		if (!ASSERT_NEQ(err, 0, "bpf_map_lookup_elem(sk_stg_map)") ||
+				!ASSERT_EQ(errno, ENOENT, "bpf_map_lookup_elem(sk_stg_map)"))
 			goto done;
 	}
 
 	err = pthread_create(&srv_thread, NULL, server, (void *)(long)lfd);
-	if (CHECK(err != 0, "pthread_create", "err:%d errno:%d\n", err, errno))
+	if (!ASSERT_OK(err, "pthread_create"))
 		goto done;
 
 	/* recv total_bytes */
@@ -156,13 +155,12 @@ static void do_test(const char *tcp_ca, const struct bpf_map *sk_stg_map)
 		bytes += nr_recv;
 	}
 
-	CHECK(bytes != total_bytes, "recv", "%zd != %u nr_recv:%zd errno:%d\n",
-	      bytes, total_bytes, nr_recv, errno);
+	ASSERT_EQ(bytes, total_bytes, "recv");
 
 	WRITE_ONCE(stop, 1);
 	pthread_join(srv_thread, &thread_ret);
-	CHECK(IS_ERR(thread_ret), "pthread_join", "thread_ret:%ld",
-	      PTR_ERR(thread_ret));
+	ASSERT_OK_PTR(thread_ret, "pthread_join");
+
 done:
 	close(lfd);
 	close(fd);
@@ -174,7 +172,7 @@ static void test_cubic(void)
 	struct bpf_link *link;
 
 	cubic_skel = bpf_cubic__open_and_load();
-	if (CHECK(!cubic_skel, "bpf_cubic__open_and_load", "failed\n"))
+	if (!ASSERT_OK_PTR(cubic_skel, "bpf_cubic__open_and_load"))
 		return;
 
 	link = bpf_map__attach_struct_ops(cubic_skel->maps.cubic);
@@ -197,7 +195,7 @@ static void test_dctcp(void)
 	struct bpf_link *link;
 
 	dctcp_skel = bpf_dctcp__open_and_load();
-	if (CHECK(!dctcp_skel, "bpf_dctcp__open_and_load", "failed\n"))
+	if (!ASSERT_OK_PTR(dctcp_skel, "bpf_dctcp__open_and_load"))
 		return;
 
 	link = bpf_map__attach_struct_ops(dctcp_skel->maps.dctcp);
@@ -207,9 +205,7 @@ static void test_dctcp(void)
 	}
 
 	do_test("bpf_dctcp", dctcp_skel->maps.sk_stg_map);
-	CHECK(dctcp_skel->bss->stg_result != expected_stg,
-	      "Unexpected stg_result", "stg_result (%x) != expected_stg (%x)\n",
-	      dctcp_skel->bss->stg_result, expected_stg);
+	ASSERT_EQ(dctcp_skel->bss->stg_result, expected_stg, "stg_result");
 
 	bpf_link__destroy(link);
 	bpf_dctcp__destroy(dctcp_skel);
-- 
2.25.1


