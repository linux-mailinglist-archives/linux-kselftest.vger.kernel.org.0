Return-Path: <linux-kselftest+bounces-41407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BBCB554C4
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 18:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 558795C488D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 16:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B1931DDB2;
	Fri, 12 Sep 2025 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7ptIAXf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BB631B126;
	Fri, 12 Sep 2025 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757695033; cv=none; b=oMrgwNYn0XmNn+XDrRB/GM7MDl0CQ+2M24DZSBedsZ3IBSaWtucTJpyPiq457c88Eix9yytMK9n4KxGicPJliyV6l9fgNRN3IX3sAvcjzFN57ofjUr0V9zkQMcWa64vjUtZ0PhGSugQTdXrGHaMxV57KDCWIPq/vfIRxkja5yW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757695033; c=relaxed/simple;
	bh=MGDNUYkapRM8C1jFeBnXh80+SZemTEKjmnxYU7exbaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BuJXVIS/LKAiLSi4P1A/D4IiBM8C51RFNBj9FWKjXAh0YmWpi+rslu+ojGqaMmgvLRQ58YREwQGtw2OK42NdNGCkNt+g3UmEyJamxgxpqqqnnfQIcNCfg5toYSqaCsEYuUDiykIgWnPUlJ/05Ehi9ukAciWjcYXaIw70aV8Uvho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7ptIAXf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC40C4CEFB;
	Fri, 12 Sep 2025 16:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757695031;
	bh=MGDNUYkapRM8C1jFeBnXh80+SZemTEKjmnxYU7exbaY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=S7ptIAXfwtIUdA2+O/iMJ3pcGheSVG/bpgXiiCKgWlvYzcB9XcAyHzBRmnHMVs7Mg
	 KLAQ6LgKddqOuYkkDHJUUPFegSy+LQuPys1GuH/XRn3VfTsdLoxjX3XHPnfilUOLas
	 5tFZFG53JSxvZPQ03Y5O0DehF8niJO/u1Yi8uuImiQp5C733KB/v7k7k2p/ZhJM969
	 9KfdX9Nsa1c3NH1sUAJaVZGOGpHTCu03GZcTBNGabY3wmhqybcS2LiA56tgeBtezm1
	 /iVro/BkGlw2sCs7PFRHmbVFtY1Y+Wg1ItBEAxqCiKAIqAGMxNcq2sn/xDeWs7Itqm
	 svQ6NQCN4SPsA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 12 Sep 2025 18:36:48 +0200
Subject: [PATCH net-next 2/3] selftests: mptcp: close server IPC
 descriptors
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-net-next-mptcp-minor-fixes-6-18-v1-2-99d179b483ad@kernel.org>
References: <20250912-net-next-mptcp-minor-fixes-6-18-v1-0-99d179b483ad@kernel.org>
In-Reply-To: <20250912-net-next-mptcp-minor-fixes-6-18-v1-0-99d179b483ad@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2169; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=SzQNF7P+VIga7z4erajbLk7KkSiLRbluQtVLzA5e2lQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKO+OjN2HnKMHrnxMok5tNz/yw1uF/wIlOsXbx6drcPu
 0qXgcHJjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImUz2D4p1AqvV9v+/79S79O
 OXI5guX6tsrZAlcs1mz3ZrsSGfTocSXDP1V28S33g3uWxncnfw3yKLr8gUvpmuGyL0fuXJt41p6
 BiREA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The client-side function connect_one_server() properly closes its IPC
descriptor after use, but the server-side code in both mptcp_sockopt.c
and mptcp_inq.c was missing corresponding close() calls for their IPC
descriptors, leaving file descriptors open unnecessarily.

This change ensures proper cleanup by:
1. Adding missing close(pipefds[0]/unixfds[0]) in server processes
2. Adding close(pipefds[1]/unixfds[1]) after server() function calls

This ensures both ends of the IPC pipe are properly closed in their
respective processes, preventing file descriptor leaks.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_inq.c     | 8 ++++++--
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_inq.c b/tools/testing/selftests/net/mptcp/mptcp_inq.c
index 40f2a1b24763e3b84e12bfae7b893c35e6c2af71..8e8f6441ad8b0a79216eaf8f3b34c4ed2c2a1736 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_inq.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_inq.c
@@ -581,8 +581,12 @@ int main(int argc, char *argv[])
 		die_perror("pipe");
 
 	s = xfork();
-	if (s == 0)
-		return server(unixfds[1]);
+	if (s == 0) {
+		close(unixfds[0]);
+		ret = server(unixfds[1]);
+		close(unixfds[1]);
+		return ret;
+	}
 
 	close(unixfds[1]);
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b44b6c9b05507780fa85221e61813182cf7c082e..e9c359df941604b9d5eec17bb83d57afe1aa34fb 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -848,8 +848,12 @@ int main(int argc, char *argv[])
 		die_perror("pipe");
 
 	s = xfork();
-	if (s == 0)
-		return server(pipefds[1]);
+	if (s == 0) {
+		close(pipefds[0]);
+		ret = server(pipefds[1]);
+		close(pipefds[1]);
+		return ret;
+	}
 
 	close(pipefds[1]);
 

-- 
2.51.0


