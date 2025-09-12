Return-Path: <linux-kselftest+bounces-41406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562E5B554C0
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 18:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0722BAA48AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 16:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4E931DDBC;
	Fri, 12 Sep 2025 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9ldPuUE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAE031DDB2;
	Fri, 12 Sep 2025 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757695029; cv=none; b=WFXUo694UpvdkfHLMdBp2CQl2LYWsD6ZEDR2Uq9Dxv3WBPAc1950QFxRJIomnw/amBAjjUhgM/6hK4gLRc83ESRaDFLYpjLBHu5pOtEAdsFoMsYGqkj0XDfVA9jhzwtqD0oLRglqk4fHlIneoNx8fVoEZsmdVqG6xtH83f2iiHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757695029; c=relaxed/simple;
	bh=6jBa6+u6eDtKQ+KKne0oa/UNjl2R0gXUaeauUFcoiw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EjFvkr/iiyMChsEzkVPlBuYWpKOPkjyQSv+XDzcjzc69Wgr2iJFjWVZLCskFgTAJYF8HAmQwEmMWYV9AUkfqgkAT3vBgYczhCfo31hOWvpew+OGNBM+6VyLWF3bo41vVIvBisxlUr3mUXQPxj5d/FshgfEOTbgVcdKb23xGpi5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9ldPuUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0801C4CEF4;
	Fri, 12 Sep 2025 16:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757695029;
	bh=6jBa6+u6eDtKQ+KKne0oa/UNjl2R0gXUaeauUFcoiw8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G9ldPuUEC7auONraJNxkM9upq64dA/o2Jlaa1o8egaUaws0MBm3sdHKLrW2eCibyj
	 s1ngWyfu9JOB9yXadbNIK59CWxOJ2f5brqcFZYaZMfRVXxPs9ShTC6X0leDnUcWloi
	 7t8yRh0jq+vp/inp+m/6+6NCvLTsqIoatFQYF85aArOCtL1OxeKlyk+sTta1EEtcoj
	 1zmCQlAQixHLW1WAF1lB1jR6SBYgpNG8N8T5qyy3L8XSjUeYGxPgNFYP20aKj7L0Gg
	 OlgU2gMiuZSxbWRJZa/IYCZYo62sH4P3fXJ3cyjPUy1W2MIqq8PvcOg2QtkxFgKaRl
	 oxmabROhuUdMg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 12 Sep 2025 18:36:47 +0200
Subject: [PATCH net-next 1/3] selftests: mptcp: close server file
 descriptors
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-net-next-mptcp-minor-fixes-6-18-v1-1-99d179b483ad@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1620; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Kzg2XB2o+mHfwAGKHZDWGGwwW0y7jRnKWHH47jzwYH0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKO+OhIuetmS+pKMwpozjfLXLH0zyGetF++E8M6nm2+o
 PX3d71hRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwET+3GJkuGSkKMjNerOr0Oij
 u1/9VpvyX8Hatl4Wf/ObvV+a7libxPCHO992nfq238sCQ6dHLvm79U14wcq/3ouzGVnWZ280EGv
 nAQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The server file descriptor ('fd') is opened in server() but never closed.
While accepted connections are properly closed in process_one_client(),
the main listening socket remains open, causing a resource leak.

This patch ensures the server fd is properly closed after processing
clients, bringing the sockopt and inq test cases in line with proper
resource cleanup practices.

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_inq.c     | 1 +
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_inq.c b/tools/testing/selftests/net/mptcp/mptcp_inq.c
index f3bcaa48df8f22e8f4833fcc3b919d21764bf7fb..40f2a1b24763e3b84e12bfae7b893c35e6c2af71 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_inq.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_inq.c
@@ -502,6 +502,7 @@ static int server(int unixfd)
 
 	process_one_client(r, unixfd);
 
+	close(fd);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index e934dd26a59d9b50445d61e8b8013ce3c8d2a8a0..b44b6c9b05507780fa85221e61813182cf7c082e 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -722,6 +722,7 @@ static int server(int pipefd)
 
 	process_one_client(r, pipefd);
 
+	close(fd);
 	return 0;
 }
 

-- 
2.51.0


