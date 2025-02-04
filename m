Return-Path: <linux-kselftest+bounces-25740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0078FA27E30
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 23:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9513F1887D17
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 22:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969C621B19F;
	Tue,  4 Feb 2025 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1FNfi3Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAD11FAC5C;
	Tue,  4 Feb 2025 22:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738707616; cv=none; b=VmA6iuxAns6hFutlAdYSrOQLnmoWTmBRt9fVkPSjRnm67/M0X07jfjmhPon7kd9PJpXyW+f+0cA3XaVNztJlX6fpIlv3SRWMBUackyt7mLYQeGgj91QPmxCcAKqoToMyxo5g3/vXaciOTYxf+TM4NKIA2aJdXW0XZI65NWqMZGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738707616; c=relaxed/simple;
	bh=Ofg3xhSGKHnj2+K7N2sYVNrGu7WKXnhEyI2OiZYqCyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ic50P48sHlAibuz8bCEL32WaICv6MPXdWsQtCurfZL2eYA1Cs9Z4XBi2x6sKhaG4xBueeuObWCWZkO1TuOYed5v0JBYX583DsiJxf3y18HUeIeM8t8fsVGEZBeLfRvNiiDbBCfxDGdeWxaykv3XtaSzzeUYn4MEXjnpY0Icz0x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1FNfi3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D374C4CEDF;
	Tue,  4 Feb 2025 22:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738707615;
	bh=Ofg3xhSGKHnj2+K7N2sYVNrGu7WKXnhEyI2OiZYqCyc=;
	h=From:Date:Subject:To:Cc:From;
	b=o1FNfi3QM3KcNkDfnxZMfJf6s8wyRBoc3vFV5N7u+VdLJj0RQ4shLisPwnGhufeKN
	 VROKlmxbQ87OvueEbA3MIfFSO9uhJMr/X4999SXIIYqkj6nAlHdK9Ha5vmAXDgiBC0
	 Chd1cmGMchTnhttGTDnTwM5uchOg3vhm0l4cszz4uiZlM4L9TxvE4ptX78D6wgw1SK
	 tkcVjDwY1onpNGQAtUqiwXi91q8SM2uOe6OqUwMs3lnohC3FaATXPVAYDuvEYM2q2k
	 wm1SNcSPmLMR7YFrbf3B4ODGbJONS8FWmrH/gtKzK3L4CJALm9J8GJx+nxkWo1dn9G
	 rAXb2wSOHM/MA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 04 Feb 2025 23:19:53 +0100
Subject: [PATCH net] selftests: mptcp: connect: -f: no reconnect
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-net-mptcp-sft-conn-f-v1-1-6b470c72fffa@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIiSomcC/x3MQQqAIBBA0avErBtQsYKuEi3KxppFk6hEIN09a
 fkX7xdIFJkSjE2BSDcnvqSGbhtwxyI7IW+1wSjTKaMsCmU8Q3YBk8/oLhH0uGmnrRnsuvQ9VBo
 ieX7+7QRVwPy+H1RNVetrAAAA
X-Change-ID: 20250204-net-mptcp-sft-conn-f-d1c14274ba66
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2021; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Ofg3xhSGKHnj2+K7N2sYVNrGu7WKXnhEyI2OiZYqCyc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnopKYLQZU4YyKbSKz5pUlq54AT8014h2s72eXB
 o75Fr0Jql6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ6KSmAAKCRD2t4JPQmmg
 c7JvD/9g08zZZi2rntY2iKHW6N+QUbZgSWYgSl+dIqRo3CjhD1LsKTxoupIfaU6EL+JQj/UBlJD
 1p7EW6tjd/98J4hsI5vSyt+5NS5VYlMvCrvSez+QxRh/Ne//X2uwXXoA8AOQoFDaq2/o8WOh7F0
 3Ib9uR6urG/kpRoQ9VxHHIfXl8Z499uRvJWtzX5eopvZU8xLlURVSkxjIHZ9mq0BdQTIOZip0Pt
 ecs88Eh49YksLdi0WrSfKrNEngRcuAuUGNOus0O6MXMKnqtisR35H1Hc2BYxMvZOB3Aghm48OcD
 2U1pMF6dYGyUh+avYkfsrY8/N3W3gwwC+BYsz7hzDOeMvtTXjvCHNThwxjN0Ge4VLNJI7WyVxAS
 Ra91FDb1JrhJaXC1K27iKdM+9uTht63YDlcU7lGpscc9WnCzaORWSK0rRKRzS3HTH59jOn0XTjA
 3w5tKK5UH5t90wTQMbfbyAgPkl+lzkaRa/5n8RVeN+r/90QG9xDzDMEyiWbbOLnxl1ICZSiBWLu
 nMd/nlLtRKa47Gv/Qm+0VZrt53Gl8v+ejzGOd5d2PBNlF2cvYRJtozLZRrpzN2szJC+uqzG/Tx6
 N2QRcK9GTjwf2F2OJJCVvRF/gD8sE/qk2Gc9ngMUU+pXPTmG+SQU34yTrw+eSfNxwqmtfyZihBy
 Yzncvbtwc6VSdFQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The '-f' parameter is there to force the kernel to emit MPTCP FASTCLOSE
by closing the connection with unread bytes in the receive queue.

The xdisconnect() helper was used to stop the connection, but it does
more than that: it will shut it down, then wait before reconnecting to
the same address. This causes the mptcp_join's "fastclose test" to fail
all the time.

This failure is due to a recent change, with commit 218cc166321f
("selftests: mptcp: avoid spurious errors on disconnect"), but that went
unnoticed because the test is currently ignored. The recent modification
only shown an existing issue: xdisconnect() doesn't need to be used
here, only the shutdown() part is needed.

Fixes: 6bf41020b72b ("selftests: mptcp: update and extend fastclose test-cases")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - The failure was not clearly visible on NIPA, because the results for
   the two impacted sub-tests are currently ignored (unstable). Still,
   it looks important to fix that, as this will help when the tests will
   be improved not to be unstable any more.
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 414addef9a4514c489ecd09249143fe0ce2af649..d240d02fa443a1cd802f0e705ab36db5c22063a8 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1302,7 +1302,7 @@ int main_loop(void)
 		return ret;
 
 	if (cfg_truncate > 0) {
-		xdisconnect(fd);
+		shutdown(fd, SHUT_WR);
 	} else if (--cfg_repeat > 0) {
 		xdisconnect(fd);
 

---
base-commit: 4241a702e0d0c2ca9364cfac08dbf134264962de
change-id: 20250204-net-mptcp-sft-conn-f-d1c14274ba66

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


