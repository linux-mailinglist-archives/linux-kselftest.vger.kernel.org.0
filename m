Return-Path: <linux-kselftest+bounces-48861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD503D1955A
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 15:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A54C30118C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 14:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA14B392829;
	Tue, 13 Jan 2026 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="rX9j2+et"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster1-host4-snip4-10.eps.apple.com [57.103.76.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840AD392B64
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 14:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313599; cv=none; b=syjwIKdKgSQZ/K7qTnj5DiB5c4jaTSd/HJvjWiI4inFlJiyMlyc6pLYEuKOXl/GzzwvExv+K01VxKIFVqqP9Xaq9kVzEHJjHtfGz1LY2QvKET86rtQqJP6IrldizNgZL+/803iCkNPpMsRq37ThpTdOqiNylUCK3F6keiN//oGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313599; c=relaxed/simple;
	bh=Ic05N38IwE/4wqD5ZXjgmQwte1DpIEy/9ZTMntimdac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cx4DVIkGO/z8Y5ptj9v9GyH+Bsbx35DU0HCeEvPl03EP/nbMtFUcVrelNdCbwon5oQU+KQ6JzTYci7TWRd0+5gZNf5XphbwLzBiQFb78u9vILWLeq3Ber4ZHynJuHtH2db86zTS83X3bq7qHfs2VE48U7BpFqpaZ7mWKuUuQMlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=rX9j2+et reason="key not found in DNS"; arc=none smtp.client-ip=57.103.76.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id 30FD51801879;
	Tue, 13 Jan 2026 14:13:13 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; bh=afH/Mj5H8vualGKTm+xW5vFpaHkJrNlaQy6ZQfrpBls=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=rX9j2+et4LuWX+Oyoyf7al7vaLWFCKUQvtowmCj1P+wT/EKrK0z+LfPxXspqCPfslzlwufsuOP3ZKXDJbMvRv2xiubmbh2IFKdC8JmASNlHD4AAD86dgEThH+69TNTm2Lr+RzJdqjQQAtjmV3cUKX8PvvcVXfl+Ty88EzpLTWCkNGsivQRC9qj4NzBhi6JVQDGgNaMA1NyXmS/rxm4jaqHHYR5MW1vY8Hm32+oEnLDYDydhDPqdb0VvWksHUIxbTiaLkmW2wu5+u+sUsIgfTToBCP3B5HRk2OlWodFwmOQ5cQ093ITWQqL0mp8hzDaYbrUp5TA2vgjz/Xw5BD7qWqA==
mail-alias-created-date: 1719758601013
Received: from desktop.tail809fd.ts.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id EB11118000A5;
	Tue, 13 Jan 2026 14:13:10 +0000 (UTC)
From: Yohei Kojima <yk@y-koj.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Yohei Kojima <yk@y-koj.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Markus Elfring <Markus.Elfring@web.de>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/2] selftests: net: improve error handling in passive TFO test
Date: Tue, 13 Jan 2026 23:11:55 +0900
Message-ID: <24707c8133f7095c0e5a94afa69e75c3a80bf6e7.1768312014.git.yk@y-koj.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768312014.git.yk@y-koj.net>
References: <cover.1768312014.git.yk@y-koj.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8I63Zms5JlcKjlKZnZbK1Q8jV10IbCj3
X-Authority-Info: v=2.4 cv=TMZIilla c=1 sm=1 tr=0 ts=696652fb
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jnl5ZKOAAAAA:8 a=ZXA9zuh9vTPPph4ZHScA:9 a=RNrZ5ZR47oNZP8zBN2PD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDEyMCBTYWx0ZWRfXxqO8yJsRA3IS
 3FXVhX1fknG+LTCk371Hi0OBWEv8LziqqqPyOC3MzDW2eGpWZ8ZVL6t7ZwgYWDZA/sYezgddDzL
 3MZOGhSpqpyRgZsy0NwivfQvDlCvzv8xCIWx0f1jGg1b3j2gskBBeUgG6cuHI6hBzLC3i9WhVat
 aI20RIPnDrjyOeRjOtPc5yPZfH9/MHZYObIRhU/0Q/Jtr7zaAySx6jE35XuiHBhIOSHv/0OCkbu
 Wii/bsUCxwKN52PkwNOu5GmH+p+BTyiOEsWL09T3Zhv++wHYY/TSf7nlqd9DbyRz/3piEPCOgYl
 xhnZ0jvyJbE3FO87/tM
X-Proofpoint-GUID: 8I63Zms5JlcKjlKZnZbK1Q8jV10IbCj3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 clxscore=1030 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2601130120
X-JNJ: AAAAAAABWgyav4S6S7kZZlib5W7u9EWETIhk5XKz/IHVv5bojkzQ5weesz5OVdXAcO8cIuGJ7LvEE54K36khk5UidX+sgOdsvVQZEr6uqUS1FAiMxBznXUWJu5POdYyutms3hbAQUeT4TsZIiqJTOfadg3IiX+Ja4FPXpepK1lkpkXhAtxigZEAVCWTDfgi9ykSuzeJJMqw+1rb87edZYpl1e/S/0cK97SbfF+Zl7Z3+BvS+XEPqSJMqTJoywX1L5VCVBKAdT7txBYT3jLGHjrA/pIBKsNfWcO73/94rEoKSwg85yfvCgI6F6ekCjwYMnrG6lHyLVXYguOMa5P0cqRla3+05gqwaCDl7HdhrvGeH+V2nnWHdQpZL0IA60e5h4DdzLB5Tk15Wr3RZkTr3q4Em+8DfWB9qEkcDOsz1BsPZgEHGvW6px+ut59cuXdQ0b1z7Cu1K5uwbweGQ7QIOHDolcdFI8kHKii2QDhbigQyDRS/KmekiKACKigwgjwv2efYaz0DT7BKg6mauBytAKpbM/aBg9v8PBY4aHc3SKQu2T2HsbMI2OZwpxczBWUxpctoiw0DmCnY8Devq3Ll9ljZYHUW5in6Kj+5v6gtlYnBsAt5BMDvaB6oqjMJkUAojZz0mv37NKrjHLeqmddAG252MkNrF0ffnjDQvRds9hdayzRcHyeB4dOZ6vnBhSmRk1q0kachgwiwAX9e7zPI6zOWY3wIOHCJ9IWwOBmfEK75E6Usq10/DHMZM+/vkKp8NJDJDswy/f6O21L/Zjytsb3zbs+5tlh5XBXcoqS3OZg==

Improve the error handling in passive TFO test to check the return value
from sendto(), and to fail if read() or fprintf() failed.

Signed-off-by: Yohei Kojima <yk@y-koj.net>
---
 tools/testing/selftests/net/tfo.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/tfo.c b/tools/testing/selftests/net/tfo.c
index 8d82140f0f76..3b1ee2d3d417 100644
--- a/tools/testing/selftests/net/tfo.c
+++ b/tools/testing/selftests/net/tfo.c
@@ -82,8 +82,10 @@ static void run_server(void)
 		error(1, errno, "getsockopt(SO_INCOMING_NAPI_ID)");
 
 	if (read(connfd, buf, 64) < 0)
-		perror("read()");
-	fprintf(outfile, "%d\n", opt);
+		error(1, errno, "read()");
+
+	if (fprintf(outfile, "%d\n", opt) < 0)
+		error(1, errno, "fprintf()");
 
 	fclose(outfile);
 	close(connfd);
@@ -92,14 +94,17 @@ static void run_server(void)
 
 static void run_client(void)
 {
-	int fd;
+	int fd, ret;
 	char *msg = "Hello, world!";
 
 	fd = socket(AF_INET6, SOCK_STREAM, 0);
 	if (fd == -1)
 		error(1, errno, "socket()");
 
-	sendto(fd, msg, strlen(msg), MSG_FASTOPEN, (struct sockaddr *)&cfg_addr, sizeof(cfg_addr));
+	ret = sendto(fd, msg, strlen(msg), MSG_FASTOPEN,
+		     (struct sockaddr *)&cfg_addr, sizeof(cfg_addr));
+	if (ret < 0)
+		error(1, errno, "sendto()");
 
 	close(fd);
 }
-- 
2.52.0


