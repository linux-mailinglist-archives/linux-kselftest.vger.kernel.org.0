Return-Path: <linux-kselftest+bounces-39118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E40CB2851F
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 19:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC8C1CE81A8
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 17:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B773176EB;
	Fri, 15 Aug 2025 17:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A86cYmj/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F793176E3;
	Fri, 15 Aug 2025 17:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755278955; cv=none; b=NUdHhsaJX85uAl+iRuWmtwMDT9r8uoHS6LvIssBJsuWj3pDTs8r10WoI1E4ici4JpzfcOOuicXaKNF0Uvols3akGQj3/O+C+uSpetMJX8IvutARcOQoAh72gqKRWbsVc0S+OxKTH+zabqUhOqSP/ttSckpbxacAjH9K/Rg6EArY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755278955; c=relaxed/simple;
	bh=PK26ncj1sRIqMENRXER6Zb/SJgspRGIPg5z97PYQV90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mQQ4soKdvKM+WE5xmK4jFTGFUw+1rwqZszfIscAiy2s6aktVLPB+cKaSCidgmGDgeiBGvaRJtl8mKOUpQmke8DjGiBCwXcMeAVK0Msl9lOFJ6NdB1qUgZD8+qrdH+Ai0KZHB5g+5yg7bBm3IaV2FfwzX3fxkfcNmj012QisgJ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A86cYmj/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CAEC4CEEB;
	Fri, 15 Aug 2025 17:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755278954;
	bh=PK26ncj1sRIqMENRXER6Zb/SJgspRGIPg5z97PYQV90=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A86cYmj/HBFtAAj2CzEkcbBe9jKSWZ7H0ENkfA7ZqLkv/UaoRHpkSjCPW0va0KBQb
	 chCDuL+Rrbtcm2OVRFrTt3eKhVFvySV0AUFQaOQBZy05QZ81wKzAYzcBSx8ZgMBKNn
	 LBfiouBXINSjhqMyXFUFDhhZYTkpQCVaLGX9LSeUlgFOiLOd22+JBzgCP9Gx7HEQ/a
	 L3mSYdpTJX9zbE44nmA1tVIznYNF1QUM2xpXGcEFaZUUd5EJzGYXyPu3lnyNKhVOXE
	 3DyXWrfsKkRO/kZctZ+arUNTbxqi2G+nbqwzLPyF9MImVBvC93fd6BO0MnPbNQ17iN
	 J7PDRmlHRoQdw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 15 Aug 2025 19:28:26 +0200
Subject: [PATCH net 8/8] selftests: mptcp: sockopt: fix C23 extension
 warning
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-net-mptcp-misc-fixes-6-17-rc2-v1-8-521fe9957892@kernel.org>
References: <20250815-net-mptcp-misc-fixes-6-17-rc2-v1-0-521fe9957892@kernel.org>
In-Reply-To: <20250815-net-mptcp-misc-fixes-6-17-rc2-v1-0-521fe9957892@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jianguo Wu <wujianguo@chinatelecom.cn>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, zhenwei pi <pizhenwei@bytedance.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2202; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=PK26ncj1sRIqMENRXER6Zb/SJgspRGIPg5z97PYQV90=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLm53k53Fm9pdLSzs7IPexQu1+hfEeN6WlZi4497y6dm
 vL08rzijlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIms/8Twm11tamCvUNOUL+E2
 K2p62jcvXOZlfenXrm/lwiyzKp779DH8FdL34fOYrZMn0mq87G6W1js2rgx1KZ6/nxe/FNCJmbm
 eBwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

GCC was complaining about the new label:

  mptcp_inq.c:79:2: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     79 |         int err = getaddrinfo(node, service, hints, res);
        |         ^

  mptcp_sockopt.c:166:2: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
    166 |         int err = getaddrinfo(node, service, hints, res);
        |         ^

Simply declare 'err' before the label to avoid this warning.

Fixes: dd367e81b79a ("selftests: mptcp: sockopt: use IPPROTO_MPTCP for getaddrinfo")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_inq.c     | 5 +++--
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_inq.c b/tools/testing/selftests/net/mptcp/mptcp_inq.c
index 3cf1e2a612cef911028f46569563d16dd5d32129..f3bcaa48df8f22e8f4833fcc3b919d21764bf7fb 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_inq.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_inq.c
@@ -75,9 +75,10 @@ static void xgetaddrinfo(const char *node, const char *service,
 			 struct addrinfo *hints,
 			 struct addrinfo **res)
 {
-again:
-	int err = getaddrinfo(node, service, hints, res);
+	int err;
 
+again:
+	err = getaddrinfo(node, service, hints, res);
 	if (err) {
 		const char *errstr;
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 9934a68df23708ecb413c4ab26523989e3b9f158..e934dd26a59d9b50445d61e8b8013ce3c8d2a8a0 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -162,9 +162,10 @@ static void xgetaddrinfo(const char *node, const char *service,
 			 struct addrinfo *hints,
 			 struct addrinfo **res)
 {
-again:
-	int err = getaddrinfo(node, service, hints, res);
+	int err;
 
+again:
+	err = getaddrinfo(node, service, hints, res);
 	if (err) {
 		const char *errstr;
 

-- 
2.50.0


