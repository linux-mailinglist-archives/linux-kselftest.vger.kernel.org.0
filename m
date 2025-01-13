Return-Path: <linux-kselftest+bounces-24381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8F2A0BC6A
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 16:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C673A0435
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 15:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141A42297E5;
	Mon, 13 Jan 2025 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8Oh+Mr/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13DC1C5D6F;
	Mon, 13 Jan 2025 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736783135; cv=none; b=frnROQccvq0ZCf2G7gtLGraqgmSUbIgV6mqyXL1rHUPGWgwogUN03PSka67uvJFRvF8yllMWShJySH8KrnYwAtElSRzwpmUy81e1zoj+uJkC2jbiM5fOWd2lTVY+DmNBPKFYy1Y6e45Lr8JyCQqDJg3MGm7fE7FE/sq4nXKSZA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736783135; c=relaxed/simple;
	bh=fG3xbLFjUW12Ssjew7xsKuz4ojI9yBcQdAaajeXFMiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RgfUnBnU7IT7U4uChYjXZ9bfR9dXYost2O94g7payw0G/z4P0+IIn5fPOj6ClEMN/pXEfSIFxYfoHA8JBwe4Tfp5+dwy7sdKUlNsWZN3V7vq+SpLC6OkdVfdGLnSCvV//sa5vK1Z/99WGLJMaGQJW6Bm1WgcC1ZtmyEPT0uEhpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8Oh+Mr/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FFEC4CEE6;
	Mon, 13 Jan 2025 15:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736783134;
	bh=fG3xbLFjUW12Ssjew7xsKuz4ojI9yBcQdAaajeXFMiA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g8Oh+Mr/gkIFvtlPbXrpyQpfAWVcsTuEPqSyORHj0kRRPPcL2zGammKerln6n8Syp
	 AhLTQFqW+Rb9crrhFN7tcKDjh11l99aq7cEjtn1R9SoZwinyBBeEhsz8NIBBDVe4C/
	 W5nZz3rBpOFBgG5GS5acCUCTzTVlkq91BcBuLEjPdUTRzJBfbQ3SJJh1DIAhhPIUNU
	 WPwwukh29Tg3CmzZh2FEdWKxcGXP83XHi1lzxrEh6CbLwUXrW3FZCak4dYGdY/7Gyy
	 KdM80xUVz+AwOzDMZD21lZ4NruhNoilGNjU+px+cOnpLkTKzl2TpFhollZEPc3X7J+
	 /W/GggQY4XPGA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 13 Jan 2025 16:44:58 +0100
Subject: [PATCH net 3/3] selftests: mptcp: avoid spurious errors on
 disconnect
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250113-net-mptcp-connect-st-flakes-v1-3-0d986ee7b1b6@kernel.org>
References: <20250113-net-mptcp-connect-st-flakes-v1-0-0d986ee7b1b6@kernel.org>
In-Reply-To: <20250113-net-mptcp-connect-st-flakes-v1-0-0d986ee7b1b6@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4147; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=HMHeFU265RAxalmgcayy5V/AECiL0u4m+mFxhLobykU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnhTURBAOsIDulk//XDrXyUSJcoyUUjSFRGmb/K
 UVDDnIhkJeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4U1EQAKCRD2t4JPQmmg
 c2fvD/sEwmb7hidlUYjFsi6wPM/OgR3K2AKH1DZVqqJtUPwcKMwXtwhvcZwWNiTtU7BvrKviAJx
 busvpoil/J759if16tF53QGvt5CYymBFWqCfaVfJc6a0xOztX83rRoTVRgxtDspsMV27o9SOH6K
 Ru1CUONYrWMaqxR0+nTPJjaPVEj+I4K+1PiJz/knNox59or+KPLLg26zSpybz4JoSE7O/ojMMrh
 n2DHwQpSaAXmlkABEQnWVlVBsKDjFu30RjH+jrO6BnPKoX/6pgmewdhWtIFCe6nrDIfFKieBJ+N
 rcFjl/afog8F9De/bblTI+okWDqEuwhoe7uKz1nUs9zUXGMQpotMhijzl/TT4z9qQST2jDN+P/X
 uM+de6+HV+1Dw6SaS4R12/cQv/7uMsE0/Wjm8Cwc5N8FaK1kKSIZqckfhybRzLdN5PgF3elgZIY
 6BtpVSla4LJzN7OjBJByLrDcvbNeyNOmIg20bGhGMCCTH+nsplkBVwp25GAJrBL5YhJiePwYHXL
 ZB9vou1RpZO79GZ3GDY4czi7NJUkKkuTriljc/3Rp7ljvyVaKi6ZOzcMAbiF2cZV0D7jI6GBr8J
 q8VVxnxTTFNqz2lAL4XUX7ZJcXgRTqv1McTcoPRNIkK1/3kfxEvLmcx5yOwl5jWOC1FZjl6uvk6
 FErQ++6RuDxT/Aw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

The disconnect test-case generates spurious errors:

  INFO: disconnect
  INFO: extra options: -I 3 -i /tmp/tmp.r43niviyoI
  01 ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP (duration 140ms) [FAIL]
  file received by server does not match (in, out):
  Unexpected revents: POLLERR/POLLNVAL(19)
  -rw-r--r-- 1 root root 10028676 Jan 10 10:47 /tmp/tmp.r43niviyoI.disconnect
  Trailing bytes are:
  ��\����R���!8��u2��5N%
  -rw------- 1 root root 9992290 Jan 10 10:47 /tmp/tmp.Os4UbnWbI1
  Trailing bytes are:
  ��\����R���!8��u2��5N%
  02 ns1 MPTCP -> ns1 (dead:beef:1::1:10001) MPTCP (duration 206ms) [ OK ]
  03 ns1 MPTCP -> ns1 (dead:beef:1::1:10002) TCP   (duration  31ms) [ OK ]
  04 ns1 TCP   -> ns1 (dead:beef:1::1:10003) MPTCP (duration  26ms) [ OK ]
  [FAIL] Tests of the full disconnection have failed
  Time: 2 seconds

The root cause is actually in the user-space bits: the test program
currently disconnects as soon as all the pending data has been spooled,
generating an FASTCLOSE. If such option reaches the peer before the
latter has reached the closed status, the msk socket will report an
error to the user-space, as per protocol specification, causing the
above failure.

Address the issue explicitly waiting for all the relevant sockets to
reach a closed status before performing the disconnect.

Fixes: 05be5e273c84 ("selftests: mptcp: add disconnect tests")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 43 +++++++++++++++++------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 4209b95690394b7565f330a37606bf39b6d2d228..414addef9a4514c489ecd09249143fe0ce2af649 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -25,6 +25,8 @@
 #include <sys/types.h>
 #include <sys/mman.h>
 
+#include <arpa/inet.h>
+
 #include <netdb.h>
 #include <netinet/in.h>
 
@@ -1211,23 +1213,42 @@ static void parse_setsock_options(const char *name)
 	exit(1);
 }
 
-void xdisconnect(int fd, int addrlen)
+void xdisconnect(int fd)
 {
-	struct sockaddr_storage empty;
+	socklen_t addrlen = sizeof(struct sockaddr_storage);
+	struct sockaddr_storage addr, empty;
 	int msec_sleep = 10;
-	int queued = 1;
-	int i;
+	void *raw_addr;
+	int i, cmdlen;
+	char cmd[128];
+
+	/* get the local address and convert it to string */
+	if (getsockname(fd, (struct sockaddr *)&addr, &addrlen) < 0)
+		xerror("getsockname");
+
+	if (addr.ss_family == AF_INET)
+		raw_addr = &(((struct sockaddr_in *)&addr)->sin_addr);
+	else if (addr.ss_family == AF_INET6)
+		raw_addr = &(((struct sockaddr_in6 *)&addr)->sin6_addr);
+	else
+		xerror("bad family");
+
+	strcpy(cmd, "ss -M | grep -q ");
+	cmdlen = strlen(cmd);
+	if (!inet_ntop(addr.ss_family, raw_addr, &cmd[cmdlen],
+		       sizeof(cmd) - cmdlen))
+		xerror("inet_ntop");
 
 	shutdown(fd, SHUT_WR);
 
-	/* while until the pending data is completely flushed, the later
+	/*
+	 * wait until the pending data is completely flushed and all
+	 * the MPTCP sockets reached the closed status.
 	 * disconnect will bypass/ignore/drop any pending data.
 	 */
 	for (i = 0; ; i += msec_sleep) {
-		if (ioctl(fd, SIOCOUTQ, &queued) < 0)
-			xerror("can't query out socket queue: %d", errno);
-
-		if (!queued)
+		/* closed socket are not listed by 'ss' */
+		if (system(cmd) != 0)
 			break;
 
 		if (i > poll_timeout)
@@ -1281,9 +1302,9 @@ int main_loop(void)
 		return ret;
 
 	if (cfg_truncate > 0) {
-		xdisconnect(fd, peer->ai_addrlen);
+		xdisconnect(fd);
 	} else if (--cfg_repeat > 0) {
-		xdisconnect(fd, peer->ai_addrlen);
+		xdisconnect(fd);
 
 		/* the socket could be unblocking at this point, we need the
 		 * connect to be blocking

-- 
2.47.1


