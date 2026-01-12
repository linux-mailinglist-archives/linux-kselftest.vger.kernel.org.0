Return-Path: <linux-kselftest+bounces-48720-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 115F4D1158B
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 09:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 867463026189
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 08:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6BC3469E4;
	Mon, 12 Jan 2026 08:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="qhVfuhwP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster2-host11-snip4-9.eps.apple.com [57.103.78.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2632345CAA
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768207979; cv=none; b=M5lpWAw78wfvwOKdwyYP4A62sIik4KklQIIcCet9ZJVpKqJ2H4tZHXMsOgTEn2XeNCm4qqJYbqpMQqZAkoB9uOqoeVHd81NZkM0+sd6gdEd6lVrUGHfKGL9NQK0HOntC2aQ2HRGIoQpDkQKOgkvwgyEFo70479HEST8dRXgcKjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768207979; c=relaxed/simple;
	bh=HP+XBvzAZZe6ZDdctV1mJaps2CvpOUXtmq5bhKKyrhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6AJqEOxHEdqp8QiiGPHfq1nFOVtsOc+ffosSgxJ93hlK+Wa8it8yZZz6LVeARrtZBK35MAoR2O3b1KewB7Yw/aRg/bKc3A0tDi2rnceD6LxMEUV8SRa4mMtrh3B5y221qPYijwcTlgxqeqFzmKBmlIEJdZem0lLTJ/u5PQj4Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=qhVfuhwP reason="key not found in DNS"; arc=none smtp.client-ip=57.103.78.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id 08A1D1800176;
	Mon, 12 Jan 2026 08:52:53 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; bh=7GMNJGoWv7q+yUAaMvgB+dlAPnp9uN5GEATgw8djXug=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=qhVfuhwP5mIfryREsOYMsAkg2aFMrtH8lUU3zylUOVK+V4Xk0nzv1qEMFhQxzGfQZUd6PzDCAcOX0mbQuysdVJiW/agJuNNZWM/IjD5shM91gBFxWygZWIVGzJeJYmSxoZhq/Qn7y9iLjTg2v86o/wpyy3ZTSFl1JxhcR51hyW3558MwQ3hp0mlLO76UWZlbMiKbUkMIELR5MjKiV6D/XW4XsLLbXEFAejKZ9pk4f7F1C8vNg9buQD39BdoV8YjUcgMbfCxoPkW87Yjc9irP5L7g3sc/VntagtE41zVEwj4obvW0N7sQPWUrLCjq2p3p6gs+1lDg0NDIIDLck9GodQ==
mail-alias-created-date: 1719758601013
Received: from desktop.tail809fd.ts.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id 6D7C51800308;
	Mon, 12 Jan 2026 08:52:51 +0000 (UTC)
From: Yohei Kojima <yk@y-koj.net>
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
Subject: [PATCH net-next 2/2] selftests: net: improve error handling in passive TFO test
Date: Mon, 12 Jan 2026 17:51:44 +0900
Message-ID: <60dc3da1f913aa9625e864ea862c23c401e7bc6e.1768207347.git.yk@y-koj.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768207347.git.yk@y-koj.net>
References: <cover.1768207347.git.yk@y-koj.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA2OSBTYWx0ZWRfXwzaD7X2qOaH+
 XalJjAGHZbgoMnPpOT8f8jcCpH2yzEiUsN9UEFIuW6WDjSiVYuwalK3nDKG11VxDeHajNUoSNrB
 UhjVEORBay72OYDFWsU1C94d23qoBkT4rh+YX8IaeYfzh2lfQgg/bbeLxVANkaXWQcUQvvtui5d
 5sBdcdoUVMaSNcfJuhYEmJ1inqRIKXIz96mpQ436JpbmHA338UB1kBZTPusBNqT1VYfFIhYbdx/
 GI1F4qzGmunw80el0RPGYVLJpBgAoGbDYwr3yUzwxZahAbbSZhaNrmelc/L6KrPRG2BMV+6u5hy
 e7EhhLB1f++Ljx6Gp4Q
X-Proofpoint-ORIG-GUID: uHRBUSwWjHH81w3tcoV1-u084S6X_gXw
X-Authority-Info: v=2.4 cv=d5X4CBjE c=1 sm=1 tr=0 ts=6964b666
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jnl5ZKOAAAAA:8 a=ycCnPHV353GAyiuBZJ8A:9 a=RNrZ5ZR47oNZP8zBN2PD:22
X-Proofpoint-GUID: uHRBUSwWjHH81w3tcoV1-u084S6X_gXw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 clxscore=1030 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601120069
X-JNJ: AAAAAAAB8MtWQLSH1n/5K7FNnv3+ElpBVMEyMv7p92eaJEU6EN/RYVhdWWaAjTgLe+09K3KFWqUAe3HurXYp8d5grQNmiurQ4NB6eDOmYsyyNtoJCpCs2pxWueAy9goBOrB5h+cXDsJqL54xkG1QimkJ9p3OC6CsOXLexWjyzrBpTWG6OJL4aDldYWEBmH90xG79Q0lOICRGnyb7LsIJsFcHLH7m7QcI+ehkQp5PjN8qYQWhv2AiAoOOeX10llZaqhZq5VpwvJ15/ZE5kYlvH5xSpMLLQ1ePLys+GmN+NrOj/T3jjz912EIEW7fAEWP3eiPZWvB4LbIqN4lgdhuTFx9w1wgoKrY1+WUKi73I/fAaKxd3OG/ZTZamFMOmGJplSYdds7lKQp+FHlhmaSeBWhVdAH+ze1yuBIjzJBFshnwdp2r8YN0XfaFIEvITsnyVZXgt+xPj52b1VIlI6Frgl5OzhPV3UgN8CcvrtgiP7tk8dvuGtHd65GKmkISXGLUwW2smqH+q1w6vX9wWcwSX1524bg9jBjcF99Xg7r4bMeXcLQ9s7y5Vfexo/DDbUJ7+X6shR5z1G2VuRFwnUeu2UJ+Es1SkbewVMtXgZcSKR5n4PiTAbo9UsF9vKIgPcycibAN8NXwlg2cKBqxpqTUGL9VLcxGXqbBaq0rVIaY5k3yGfBM+7SZQf1jnPUWqPPADuIP5fENLAiUSScjjcbh8vpKyweXwzXE4Qqz74rD7jZsyLHWkuNhR

This commit improves the error handling in passive TFO test to check the
return value from sendto(), and  to fail if read() failed.

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
2.52.0


