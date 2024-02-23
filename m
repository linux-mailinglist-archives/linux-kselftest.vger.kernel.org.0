Return-Path: <linux-kselftest+bounces-5352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE82861772
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 17:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A16B928606C
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 16:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F74A85638;
	Fri, 23 Feb 2024 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUPjmnLG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6173012D217;
	Fri, 23 Feb 2024 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704898; cv=none; b=feLp0ItEVShUBUMm9Ug88vnjse8sRGZDt5UQOMpIymfQ8J+HoWs5/l3HQIah8F/BBpJsyU5Fw8FnG+CKcQASHyeRB/AhtTIIresGqwmAL/kFLOgqM+4ivC2E7l4I/Yeu0dIWh/K2nTep2C/9cPOIVvp6OPoyfaMB/mYHXoF+2x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704898; c=relaxed/simple;
	bh=CPDy4dZRwTDEbx1YV7BtHTXQsWFT3BnDEbIFrcORF/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nwBbSZsKAlHN9J6ntBZFCQHLir7FL4b5J3twpPDmJakSATE6wq2fIEexO7s+/ShUsyE95v9xCz5jyEfq+p+WpIHTBVsnfqgmtMtemOTiizlkHekrg79CSKePb/NDhE2XZ923aAr4TniPH/EDXFnxK2RaLgtacRm32v7hVytDuEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUPjmnLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DCAC433C7;
	Fri, 23 Feb 2024 16:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708704898;
	bh=CPDy4dZRwTDEbx1YV7BtHTXQsWFT3BnDEbIFrcORF/U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BUPjmnLG4EEmoVkbZHiYUh7NwbhZCFW8cRCOI8JkXk7KNYhfGf0eWhjI2Q4DpQ/Sw
	 XMY0eyyGd1RfmIbrbIzd3NFYp+WKtM+NIlG2C01Us8QZNDOqRNh5fAO4f7F3AlQ8yV
	 ySICiAGPLUSnxezVUpRAaav2d5y23+HnubAlYdyZgaPmllyKKe8BFOdBhPX3hjDzA8
	 6/tiZMTWf0PP+aEn/P9qKzM3MUasfUy/MX5szPYDtXqsg668tWv4DL8pXQ3mpqYFBp
	 xhxAq2vd6I44gOrualYJsG8nrhbRabcc8/tqkdQQMo881/k9Sa75UhGNvwPAuA0PdV
	 h7fkDmjtsxDuQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 23 Feb 2024 17:14:15 +0100
Subject: [PATCH net 05/10] mptcp: fix snd_wnd initialization for passive
 socket
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-upstream-net-20240223-misc-fixes-v1-5-162e87e48497@kernel.org>
References: <20240223-upstream-net-20240223-misc-fixes-v1-0-162e87e48497@kernel.org>
In-Reply-To: <20240223-upstream-net-20240223-misc-fixes-v1-0-162e87e48497@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, 
 Kishen Maloor <kishen.maloor@intel.com>, Shuah Khan <shuah@kernel.org>, 
 Peter Krystad <peter.krystad@linux.intel.com>, 
 Christoph Paasch <cpaasch@apple.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1025; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=zIc0DvPqwvck70+qa3G7AqDo3nn6CKmR3M+FTdYp/kk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl2MRqFg1UztakYnL93CqFyVtJ6zltzN2Dr5BA2
 ORlY27pbKCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZdjEagAKCRD2t4JPQmmg
 cxXGD/0dD0CgsDVdaPHL6m2LuFAFjfFkSA8ug4hqwJ4GqD7EiIpES0CraAvncxkciSjNhcpuesm
 ySM4ZvVEM3bzupke4g/8zbrWuxUPaDA1BVPEPt7tqfK94s7D+LWmVVyY3zJVr3M/Iimycecqma9
 lQ2zmQ1n2glNN6wufx2rnNoXMlCgvo5kTlv8p0Wt9wLMNKwk0Po1Ff61mJxglpAbBNuZ2F2RvO5
 Hk6DqPEsGpk5eZQW03ZnwQYxP+RvwtooQQ2X+htxX1vfHWrIaNxuwBjVQFIWtOmGODQyLMncDaH
 aaD2YeYzxzXT3Q7X4UzQWcsuBFAvujsfb+f8evylOhoBmJ0y1mHF5j0jmkC8y8l7fTDTI7V6p9r
 JhZ6nLhyArvLuAd9xpFaMPvUPB3x4QPkDCnqjPpRhMWHzqyWIVfEsv6csb4kWs3K0e3qSOrVLa3
 PV22ytZblYDccuv5aXNECi3Vcce4NNKpZnDmvQzXY9RCJJyG7tlZ+FeRUbWqJXbX7Vwzp82Rq0L
 4Gdkrfzsk2ytzNj3kSXD9kB/XxvDyfaTn25bya0oTCvodbUYNXwTTQiFu++LsV9UghyjkSVuMTe
 7NUTSVi7BVhVs4UGC324V/8sZ5j+706CxoXYkQ9A7mVVg4I3Hw73qjLl5a374Wy8eYCQAUflTDP
 z3l4epqYIK9HmNw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Such value should be inherited from the first subflow, but
passive sockets always used 'rsk_rcv_wnd'.

Fixes: 6f8a612a33e4 ("mptcp: keep track of advertised windows right edge")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 442fa7d9b57a..2c8f931c6d5b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3211,7 +3211,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	msk->write_seq = subflow_req->idsn + 1;
 	msk->snd_nxt = msk->write_seq;
 	msk->snd_una = msk->write_seq;
-	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
+	msk->wnd_end = msk->snd_nxt + tcp_sk(ssk)->snd_wnd;
 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
 	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
 

-- 
2.43.0


