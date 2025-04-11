Return-Path: <linux-kselftest+bounces-30574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E697FA85B0C
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 13:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD1967B9674
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E581627EC9D;
	Fri, 11 Apr 2025 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnJQDS8w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E1827C169;
	Fri, 11 Apr 2025 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369518; cv=none; b=fmiNov/3bC8xt21o1DmumKOqWefsMavc1ZtK8Vat31U2HCqWuH0Gqkc9cL8EJi66gZodq/zOzth4qabpBL+Cg+i9QqRSm3ke2KBsmNaXLNR9g9HB0lMrgQ+DoPBJTB1Me612FDgBz8RU/hUlPzMecfb+PULSO5gMtiDR3mEP+l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369518; c=relaxed/simple;
	bh=tnU+y61NbN2UXnKCrxVnFsdhCNNTemdbEE5PAQolLWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jrA9vXjTHy9lrl+d2Up6DxKSzFDdGOXPXdliRJY13v6j5PraRGVP+kH6GU8nBvI8dSGE0hiBohrirD3WLPZTB/C1fD+hU3EooBHorZ+Vd+6h/Ku95DoZYN3Fi206vM/XY7H6VTiFXx8VKwGYpHgp6o8sEseWEsbDb+DrBh/Kuyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnJQDS8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5ACC4CEEA;
	Fri, 11 Apr 2025 11:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744369515;
	bh=tnU+y61NbN2UXnKCrxVnFsdhCNNTemdbEE5PAQolLWA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pnJQDS8whjF57yXjv4al7w1iPWE9xwjlGmJu1FpdpvqZWe1eNhYUQaymm6IQrHtm5
	 0dlHrxMW//1aBSPSZOTJdhIBebNabnoQA+JNSvcWJG+M7GEDmLk+CF9iAhI3S3xeQB
	 7/08QbSq0PdLse5P3NM5Ke2cMdRoMc1zBFPJ7b+34xsdqNOLqxjSh15u1vYgIgdrXN
	 Q1n4i6AyObCi5d4EZY+jQBOVc5inYvsVB4nYx3qxzXf+bKhhPTXyMUM02G8WOACpVu
	 LtNgwNEjySodMaiPASH9bHFfKCjeomcfTYxDbwiaUHXtJs5N/k5pqzdZgPkdVkhEM1
	 6qR+2eiCdzVQA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 11 Apr 2025 13:04:47 +0200
Subject: [PATCH net-next 1/8] mptcp: sched: remove mptcp_sched_data
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-net-next-mptcp-sched-mib-sft-misc-v1-1-85ac8c6654c3@kernel.org>
References: <20250411-net-next-mptcp-sched-mib-sft-misc-v1-0-85ac8c6654c3@kernel.org>
In-Reply-To: <20250411-net-next-mptcp-sched-mib-sft-misc-v1-0-85ac8c6654c3@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3375; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=tnU+y61NbN2UXnKCrxVnFsdhCNNTemdbEE5PAQolLWA=;
 b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBn+PdcG5+qL4n3qRFl3V7+bitSqEUVu20UrFif1
 12o+FGIjrCJAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ/j3XAAKCRD2t4JPQmmg
 cwzbEACrcS8XEBPWKTeRfx0pINLvOQhJbGCGiA156YK/IzRT66CDGO9v2CziIWIWtFj7b6glROC
 jTJIF9tIwNsK2eaL1jaYejxHi0vLwRKTACf6cO1ooWjOzmq22Gq1EATeBzXU0Zvhsm+kzqsSZqS
 w1EgbLX0to2h+twYuZD5RwPtpwazeBcXVjjWQH4d4gGZpS+i0lONcwFu1U6NNxrc2isDdZO4T3k
 qngc4NhnE7MmhuoQw0oFHG7Y139Fv17JnKBdudHpwHofxkHRTxfdaaTj2+WelVDQLTS9rbmn5mB
 XnqHpBgIUhkP6NpIM5wZ5nItPToWncVP5TsUs+vZxeWfZuV1Y2Yuw40zXbLrWRERMByODCxyLxT
 cSLLD9k/WFYONujk212c5avMbx1g5jlq2DLIlbOCjTgLm11LwbZZhjhvURSJCS6mnQb7GmfhWGM
 gm7Ivmcnv8gUnwB0PugXkGyDOx5s55ytQCL/Azmr7O2AT0v811GuqLueR/idXCkA1P8tcY+o3VO
 MVe8mKoNe9BGtMQwZuBYx+RF9FQ37okbq4XSCLboluH58i1FmGkRMEJp/zolomQe273sN2kWggz
 pQsQA6tbfMa6vQfP3Ap19z++u+hqMhv6oJBVOEdzejzJek5HuYvtJPLHQuXdqJGR2TGBsunMRJT
 xVqMpDL3fcfxxig==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This is a follow-up of commit b68b106b0f15 ("mptcp: sched: reduce size
for unused data"), now removing the mptcp_sched_data structure.

Now is a good time to do that, because the previously mentioned WIP work
has been updated, no longer depending on this structure.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/net/mptcp.h | 13 ++-----------
 net/mptcp/sched.c   | 18 +++++++-----------
 2 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index bfbad695951cf664af4d05390104883268b6bcd2..f7263fe2a2e40b507257c3720cc2d78d37357d6d 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -101,18 +101,9 @@ struct mptcp_out_options {
 #define MPTCP_SCHED_MAX		128
 #define MPTCP_SCHED_BUF_MAX	(MPTCP_SCHED_NAME_MAX * MPTCP_SCHED_MAX)
 
-#define MPTCP_SUBFLOWS_MAX	8
-
-struct mptcp_sched_data {
-	u8	subflows;
-	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
-};
-
 struct mptcp_sched_ops {
-	int (*get_send)(struct mptcp_sock *msk,
-			struct mptcp_sched_data *data);
-	int (*get_retrans)(struct mptcp_sock *msk,
-			   struct mptcp_sched_data *data);
+	int (*get_send)(struct mptcp_sock *msk);
+	int (*get_retrans)(struct mptcp_sock *msk);
 
 	char			name[MPTCP_SCHED_NAME_MAX];
 	struct module		*owner;
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c16c6fbd4ba2f89a2fffcfd6b1916098d7a18cbe..f09f7eb1d63f86b9899c72b5c2fd36c8445898a8 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -16,8 +16,7 @@
 static DEFINE_SPINLOCK(mptcp_sched_list_lock);
 static LIST_HEAD(mptcp_sched_list);
 
-static int mptcp_sched_default_get_send(struct mptcp_sock *msk,
-					struct mptcp_sched_data *data)
+static int mptcp_sched_default_get_send(struct mptcp_sock *msk)
 {
 	struct sock *ssk;
 
@@ -29,8 +28,7 @@ static int mptcp_sched_default_get_send(struct mptcp_sock *msk,
 	return 0;
 }
 
-static int mptcp_sched_default_get_retrans(struct mptcp_sock *msk,
-					   struct mptcp_sched_data *data)
+static int mptcp_sched_default_get_retrans(struct mptcp_sock *msk)
 {
 	struct sock *ssk;
 
@@ -157,7 +155,6 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sched_data *data = NULL;
 
 	msk_owned_by_me(msk);
 
@@ -178,14 +175,13 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	}
 
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
-		return mptcp_sched_default_get_send(msk, data);
-	return msk->sched->get_send(msk, data);
+		return mptcp_sched_default_get_send(msk);
+	return msk->sched->get_send(msk);
 }
 
 int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sched_data *data = NULL;
 
 	msk_owned_by_me(msk);
 
@@ -199,8 +195,8 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 	}
 
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
-		return mptcp_sched_default_get_retrans(msk, data);
+		return mptcp_sched_default_get_retrans(msk);
 	if (msk->sched->get_retrans)
-		return msk->sched->get_retrans(msk, data);
-	return msk->sched->get_send(msk, data);
+		return msk->sched->get_retrans(msk);
+	return msk->sched->get_send(msk);
 }

-- 
2.48.1


