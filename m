Return-Path: <linux-kselftest+bounces-23593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7CB9F7E61
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 16:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47E78188E718
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 15:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9AC22655E;
	Thu, 19 Dec 2024 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBQInViE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D3F226552;
	Thu, 19 Dec 2024 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623417; cv=none; b=brMNocpb6zozY9IxFkSkTCk5mPVj/EIlu3E7HF4VwjiCP/+4jgwxQ9LpuCS16OFbHpJVj+8Xi9oMjheRJgHUqzIeflvayWYE+ZlPK0TE6XDAMvVlhrbcVJMq2U/IW3rL2TprvXCS7EGCUxNbJj/nvP4IIeiSixA1In4MzWYrLwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623417; c=relaxed/simple;
	bh=uSOupaSl0R2bP+tGvViCkeLrCZOlUFfU6pCZQqCqeKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fIoF/tFrtwUHXhoaoZuirCMYU/aZN4dJVzOoj0kiToStbtFESy3b7UCNaD1aVQpq1p5ZU8WNxaOKwk0MusfPpbJqq3JFjyLGq2L/7pGt/6kFTIz+euuIBrQBBQp6XVv3ucPDwqrT0CcqZgWwYdMGKmQIyouVlBRcLaicWLobacs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBQInViE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4A2C4CEE1;
	Thu, 19 Dec 2024 15:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734623417;
	bh=uSOupaSl0R2bP+tGvViCkeLrCZOlUFfU6pCZQqCqeKA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qBQInViE3X3MrBuNQTZ0fawJH+eTIscHj4mTNPkqJqMDpkthDT9cMiHJichU/81iS
	 OteNVeV1YeEgjxKxnmRgR+m5GHu4dTJngRyb+j9aJDMjmMdRUn07tmTda/ZcSUz3IP
	 ibZfy9hoh4PUlI+PYdu1QDyBBq5TKX95H51RT/tGA3EUxQjzbzM2EyJxbOdZ2bKFxQ
	 kvBvnr2mtz9Bnhzc07ynV17FTtxW0rUXFfIEhjuSzQJ/eJPfih28ljWOcHu9XVIw6P
	 kzvN3xBZWrWVMytHl18vUYs3twUVwl3/SYCp22o+NYCrYIdyfGkxoiycCaQMrv9ujx
	 8hPGDDdWxtSmQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 19 Dec 2024 16:46:40 +0100
Subject: [PATCH bpf-next/net v2 1/7] bpf: Extend bpf_skc_to_mptcp_sock to
 MPTCP sock
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-1-ae244d3cdbbc@kernel.org>
References: <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-0-ae244d3cdbbc@kernel.org>
In-Reply-To: <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-0-ae244d3cdbbc@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3112; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=lnryqshajbYUd9cCgDiyIBOFzeb7Ox7Vw7A9hLDDvHY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnZECtu/pzH08fKosSsCBeA/bO7d2/QiJaRXxhB
 BAAKUCg+U2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ2RArQAKCRD2t4JPQmmg
 cyReEAC0BjYOvTnlmA+RuJIdOqEBdGShz7oSfVgeHZgeoS9NEDaAt50uuVuNvOhNBoCp78WV6B6
 8+T6yLk3EXmYmiX7cAkAwqofnTePZ3PhbNNTrXx4AiBZcBkbjsMfGG8dPsKCAKTjj60vJI1GURL
 GtIkusE6YPni4VQlWrnlkLWiDtsSvx7jvaKZ/DSvyOCZNBUeklzfpqGKTNbzSvWX1mQ3Dj4sfaG
 ZMTywh5qpnxj96WHfj1ax2E+/xOijw6AJZSDrAKU02qxBcJVYJHaqJtr3u7Odhwce/NxAVpxioC
 QAgAJMdEwTgZCTMMXO7Epo4z+2bMKpiprsbk0lyFpc0M1NEnsCoLDysD4vnnvvhMno48cDulusp
 +570GUwrZuGUgJHjQkysfDWTpb60BPIahbZVK/NDST5/1gpvN4QpZcMaeJIcsHvN0wlFcR/M35I
 ZTue6+cpPAOkGHBedToehoVCk9AvCXqzWPEZYgAOU/ZhBKRtn9rVC5QntwsiM91llJzmFoCoqRR
 Il5d9bSe0V8WA2JLS9AkfKXnNTXKXYuC6XGTy84uMTBmt0FVkZwsyzIKDHL/eauELfsVfNnF7Pk
 S0r/KQhbrUYmDLM4U3sAfuybeOWfK9f5AFoUIIHiJXGegqmtXBk7G1h3l6W2NFosh2X6hW0YhDI
 ygFZCx+xjTaiWdQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Currently, bpf_skc_to_mptcp_sock() can only be used with sockets that
are MPTCP subflows: TCP sockets with tp->is_mptcp, created by the kernel
from an MPTCP socket (IPPROTO_MPTCP). Typically used with BPF sock_ops
operators.

Here, this helper is extended to support MPTCP sockets, the ones created
by the userspace (IPPROTO_MPTCP). This is useful for BPF hooks involving
these sockets, e.g. [gs]etsocktopt.

bpf_skc_to_mptcp_sock() uses bpf_mptcp_sock_from_subflow(). The former
suggests any MPTCP type/subtype can be used, but the latter only accepts
subflow ones. So bpf_mptcp_sock_from_subflow is modified here to support
MPTCP socket, and renamed to avoid confusions.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - v2: new patch.
---
 include/net/mptcp.h |  4 ++--
 net/core/filter.c   |  2 +-
 net/mptcp/bpf.c     | 10 ++++++++--
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 814b5f2e3ed5e3e474a2bac5e4cca5a89abcfe1c..94d5976f7b8d8eb8b82f298f7b33ecd653937dc0 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -322,9 +322,9 @@ static inline void mptcpv6_handle_mapped(struct sock *sk, bool mapped) { }
 #endif
 
 #if defined(CONFIG_MPTCP) && defined(CONFIG_BPF_SYSCALL)
-struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk);
+struct mptcp_sock *bpf_mptcp_sock_from_sock(struct sock *sk);
 #else
-static inline struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk) { return NULL; }
+static inline struct mptcp_sock *bpf_mptcp_sock_from_sock(struct sock *sk) { return NULL; }
 #endif
 
 #if !IS_ENABLED(CONFIG_MPTCP)
diff --git a/net/core/filter.c b/net/core/filter.c
index 6625b3f563a4a3110a76b9c12a46340828e16b6e..40ed3854a899bf9d11847ec0e8aee174923f03d2 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11833,7 +11833,7 @@ const struct bpf_func_proto bpf_skc_to_unix_sock_proto = {
 BPF_CALL_1(bpf_skc_to_mptcp_sock, struct sock *, sk)
 {
 	BTF_TYPE_EMIT(struct mptcp_sock);
-	return (unsigned long)bpf_mptcp_sock_from_subflow(sk);
+	return (unsigned long)bpf_mptcp_sock_from_sock(sk);
 }
 
 const struct bpf_func_proto bpf_skc_to_mptcp_sock_proto = {
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 8a16672b94e2384f5263e1432296cbca1236bb30..988b22a06331ac293b36f3c6f9bc29ff0f6db048 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -12,9 +12,15 @@
 #include <linux/bpf.h>
 #include "protocol.h"
 
-struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
+struct mptcp_sock *bpf_mptcp_sock_from_sock(struct sock *sk)
 {
-	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
+	if (unlikely(!sk || !sk_fullsock(sk)))
+		return NULL;
+
+	if (sk->sk_protocol == IPPROTO_MPTCP)
+		return mptcp_sk(sk);
+
+	if (sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
 		return mptcp_sk(mptcp_subflow_ctx(sk)->conn);
 
 	return NULL;

-- 
2.47.1


