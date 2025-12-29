Return-Path: <linux-kselftest+bounces-47998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8BECE7D30
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Dec 2025 19:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F8BB301E17A
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Dec 2025 18:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041B3327BF3;
	Mon, 29 Dec 2025 18:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="0dTkri93"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster3-host8-snip4-5.eps.apple.com [57.103.77.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7140D1E5B7A
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Dec 2025 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.77.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033246; cv=none; b=rNKDJYpZ3W7TC7+n+3H9HqELwkoWEPO24u1qUi0MD3upEw+YxfdgqQK/1b8XSACi17BoLcO9GJQrU9V7nc/iczi2mXxTvt4ZZ/a1x/yf3dS6DU9pQDal5xgaryNwDfKp+pS3YtCYdFrdaUTafwD2U8OrvsKY63qm7kUXFttyJeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033246; c=relaxed/simple;
	bh=5R++VHYPwVydeKrO2RyVVwH77yGWLDXbB1stHgv7ku4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvDuy8n6Djr93EUzicFFTdzBSJ1htAb4BSKDfmMQJgS+s6xl5EkZKi7n6+pmSYpjaK+7Ogy0Irb0tG5qj9Nj2xz7mBpyA6eR4jhjWm9W3uSMvOOfj3rBHv7C7gs7eu/b7Z6aBLdPO7n2Gh4mnjz8ZfRaTh8Mx9pmkqDypKnOPxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=0dTkri93 reason="key not found in DNS"; arc=none smtp.client-ip=57.103.77.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-6 (Postfix) with ESMTPS id B1E1318005E1;
	Mon, 29 Dec 2025 18:34:00 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; bh=T3OS4wSdrCOmmXJoZP6eP5ZoQXioGsQL41ZtZ0kML+U=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=0dTkri93Ditzv5nzucPTk2K/l9g5R4fWQZJLobixWHGWHF1B/MuRGA5IkHlX/7PZSESWGeZE8MIyb1xBvJxw1N5ts9jltJHuMNssquDMF3pRY+lBcsqqqtiPKMP/BsSkSHQBsCPJWvRG8zr3BX/QAOzcwHaLxlklUtvUv5CNHIUeUGQoGMXLMbOO2evcOMRP+ezF8p3ph/QYq2TfxPERG0c0AHKutMTyTmIuo/wrwNZ6NQZ/93+QlY9MGmER38TB/Bg0DCUB8HwIM1c3G2YaNfOu4/PeFFFL1UFPtnbDS5j1fOkz/4vHBlnsFnvYDRbOinKapNxDaCt1v7ts0TuXwg==
mail-alias-created-date: 1719758601013
Received: from desktop.tail809fd.ts.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-6 (Postfix) with ESMTPSA id B99A718002A6;
	Mon, 29 Dec 2025 18:33:57 +0000 (UTC)
From: yk@y-koj.net
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Yohei Kojima <yk@y-koj.net>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 4/5] selftests: net: improve error handling in TFO test
Date: Tue, 30 Dec 2025 03:32:37 +0900
Message-ID: <7fdfbe8907c7f54ea65ffb4f8cd64cdb291eeedf.1767032397.git.yk@y-koj.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1767032397.git.yk@y-koj.net>
References: <cover.1767032397.git.yk@y-koj.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE3MCBTYWx0ZWRfX3vKdxLmI4Bc/
 eR02zRM9Y/z89uluAPtIK2hhHhYChsXm2VydtUl4WKRWioCnScfPiiDawoF7ef54nwtG+t7Yi99
 ljz4LEAw9nAw074gNCLE2pwu1JeIFVT1dY8Wa1r6TG9YmJLC3VtUMcy6pU9T6PSnH+CNZue7zMJ
 98VGWmLRjhgfKoCw6w+55fBvJEgdAmSqEFxmkEyUaNi3TDWI0rz1D35i1Nlroyik7feBbeWXX/8
 ibV8OEcVp6E0/jw0IxqfXj59GnJzWYDkayMuUUsNE8lPLSyTW9CVkBX4O5I+SR1/I97YyynzUz/
 nD4EzorHYDa0tEVBWhz
X-Proofpoint-ORIG-GUID: u8YhZbFIF6rFdXn-aG6pfYJYxsh59Lbi
X-Proofpoint-GUID: u8YhZbFIF6rFdXn-aG6pfYJYxsh59Lbi
X-Authority-Info: v=2.4 cv=YI2SCBGx c=1 sm=1 tr=0 ts=6952c99a cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jnl5ZKOAAAAA:8
 a=bbAjskgjQjIXU-ELhLQA:9 a=RNrZ5ZR47oNZP8zBN2PD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_05,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=979
 adultscore=0 spamscore=0 clxscore=1030 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512290170
X-JNJ: AAAAAAABpPGLt+tQJ1Y8GBvxs+5ZxgSzfXGXNKbc8N+GGLLFijtBF81uxeGAcG7QSDpiTyfjELSzQ6fxaBytRM2vnzsCSmUEp7zVItZ2BhEkp5ph7hqnPuVoFuKYJ3Td+RngUoJw/pSn9mReq6G5bwn127/ZVYtsl2qoFh+NexK0srFIod0+3j5c5thWt0hCWlT5nn5Y4oJ6atDFBRsvF5UQl/PXckzLSHWSP6yf0ZywfJgif41ca+jV0KnGTCeGewIKk3vOsmKP9hYI/sWYBKxhFRPQBePJIIGu73ZVv20gDihHsjrjbi/ok0+yaA12GxvGtVhg7m+vl+w10APdgLRBq1n9brD55i4bX/j3PRujvBVP9f2nGfcP8EI0XMsy8c5xtqDiZIOB6NO+qm/tUXmQ9i20tdpg2mG9nesPgrMfm3pUCJk6Ttnn445cAaY5v+lB70n0wniszn4bvn20cqmG1StLAXxEIziEzTNo9qpQaJP8eJmt0Be/Ox1p10SZ4fog3wvbp7hHRP4ZvUOU2+59T/9k/jQ5kzo+IQzLmfvkDQT0FEoDIkcORx0M8sXscQjry5IZi4Bg511bAdMHmsZT7hM9gMJMyqCpJdV+IzjFYqgyuFCFI3TDURAAz/MxSGRR6oq/qa3BBNwe46UAXZUsPg5r+aceqyzRAd5zqLfcmxoUbcysqL1Z2O6jrriCdOFfyhwm7XMXz9R9myMVWHWK

From: Yohei Kojima <yk@y-koj.net>

This commit improves the error handling in TCP Fast Open (TFO) test by
(1) adding the sendto() return value check and (2) changing read() error
handling code to exit with 1.

Signed-off-by: Yohei Kojima <yk@y-koj.net>
---
 tools/testing/selftests/net/tfo.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/tfo.c b/tools/testing/selftests/net/tfo.c
index 8d82140f0f76..4572eb9b8968 100644
--- a/tools/testing/selftests/net/tfo.c
+++ b/tools/testing/selftests/net/tfo.c
@@ -82,7 +82,8 @@ static void run_server(void)
 		error(1, errno, "getsockopt(SO_INCOMING_NAPI_ID)");
 
 	if (read(connfd, buf, 64) < 0)
-		perror("read()");
+		error(1, errno, "read()");
+
 	fprintf(outfile, "%d\n", opt);
 
 	fclose(outfile);
@@ -92,14 +93,17 @@ static void run_server(void)
 
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
2.51.2


