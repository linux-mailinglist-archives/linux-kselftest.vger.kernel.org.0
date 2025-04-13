Return-Path: <linux-kselftest+bounces-30644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C6BA8714A
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Apr 2025 11:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B9E3BA986
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Apr 2025 09:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EDA19F130;
	Sun, 13 Apr 2025 09:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyrZxP0r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C5919E971;
	Sun, 13 Apr 2025 09:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744536898; cv=none; b=gtT0OjtPLL/lBNwUk/ZDnFke9DqpepBaUxzM/OmTyhCXx9k3p5J7hwKzYQRZg63dPtz3KAxghYuWIkXRFpnDkjXPiW/tMtmWEAaj1ccXsGXBtcB/K7BDGC2qqCMl4jvp3Smxcy3V/OF3UQTPJ8saAjudZwrGXlcisgE0rV/idg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744536898; c=relaxed/simple;
	bh=tnU+y61NbN2UXnKCrxVnFsdhCNNTemdbEE5PAQolLWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=srjuXkwxEHOAbpLk4Fq+JYOKh4k+wkadxlh+hTWiOLDLJFw1SNZ1tV2fymO4KQTrb03Bux+Zu0HrT0mLP/nPovGtdGb0DsOzFjYE93UA8M6Jb8M7obSAf73+VWVnKFf7woGdxOyIBPLrpaY0Bj+8rRVgydvxVT1LFFhlQoc82vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyrZxP0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2739C4CEEF;
	Sun, 13 Apr 2025 09:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744536898;
	bh=tnU+y61NbN2UXnKCrxVnFsdhCNNTemdbEE5PAQolLWA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JyrZxP0rFDlzthkBUwGyXdMkhAHtCW2vziP6mmej3VHoLI2vq4Uq6EZY9M8XwV7Z4
	 Rx79VA58GGYmVWCe1UjEbxjvJ6sr/7SzB0B7+0fJsKTQCC1wgu20QvCbeVkxgQuxRr
	 wfksc4efCXzyOeh4E9E5l+n4o8VEotLwWZZk5ZtEEkf+d++wg7lzExCpfCfXAQhHoa
	 nJoLS5KEF2qWaUqVPM9MIaW4hTn7SXa5UNek9SyPQF0d5X0vQUkagACN41cL7WdMxv
	 7ugsFsgruU595Q2N5HUxAukKYOmNYfWzzgd4uRlyMqWxw9HsbuBICnx8BM9uPTQg9B
	 HIRmTBnwEzBXA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sun, 13 Apr 2025 11:34:32 +0200
Subject: [PATCH net-next v2 1/8] mptcp: sched: remove mptcp_sched_data
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250413-net-next-mptcp-sched-mib-sft-misc-v2-1-0f83a4350150@kernel.org>
References: <20250413-net-next-mptcp-sched-mib-sft-misc-v2-0-0f83a4350150@kernel.org>
In-Reply-To: <20250413-net-next-mptcp-sched-mib-sft-misc-v2-0-0f83a4350150@kernel.org>
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
 b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBn+4UyyRcRlaGI92ZxLl1ksC1xi9E3uftMTgBVn
 unN72haoT+JAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ/uFMgAKCRD2t4JPQmmg
 c1+CD/0QYZ4dv0LhFLzrcqNSZbziVUB/ZSTkgvN00eut1EUGgdzHUmuMlIirbVZS/qyTJie+pN5
 Paa6VpA5eNBweG4QMnlTISY0pmMaop99CSFHQWEyvSiSzfRXXwfPotx2ff/G9xU00ppBkEcF2TO
 H6o0ulUQZ69/zFmEI1scwTRibEhq1M4FFQbvMyTmUef9D1NcSVfc/uRbD2u9Dt1g+biFrXhltCb
 X44lIfRPtKLUPCoroE52Bzl9ZoW5CNXSLQlxwdMdss9n4kkwRQr6xgO+/f0IdyI4jCjbNdux00N
 YrLcT3ZnU2PhU3q0kPlqPhxG0Diduig9w5yW6g5BDROvTlwoh5h1Ih4jVMuSVL766UExSJNNAbv
 /FfznrdE30ghPbo5MQ68h8dWK2gHAknfX+rQwfoEve8w0zIhPwzaH3Ed68GYXPQvzh8dC4seRoG
 h+nFKRCT6TcpufFtzS1ETDxxBct/qEXg8nszS95ZhK6rKzFpujzpA3XTTkCnJ1S8zHE8BSYllGA
 ixOEDotdldrBMqg0rbWacVytNks1C6ExI0A5zDXBOqWkgCuCIoLAY18EZ+Izv5Ctv70EzP4qUys
 nIUo2z9dFyzAMDMat9N8al9OU1RnBxpEv6JZ/RdegOjKdu0hCZiXzVzq8nFlnk4NkGdiuBPVaAo
 ZybHb4xni/lZ/DQ==
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


