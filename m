Return-Path: <linux-kselftest+bounces-42534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7EABA5CB9
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 11:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B13CF7AE894
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 09:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5EE2D839F;
	Sat, 27 Sep 2025 09:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNQDvfLP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCF0224B09;
	Sat, 27 Sep 2025 09:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758966064; cv=none; b=BnJBydRm9cmTPDS+1w/kkaoU+DK9K4KEEpp3Puz1xyhc3dl5kiai5AwQaZsqyDzwwFCIuUZtGPcjDJDjKSzDzP4i4z/TPtmHWLbhyrde6e3p9SVM6v0mJVn/bfeMbgdDosNy0V5Jul1ThqRCm5SrEGU2v+dBUDeEQfBOubYElA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758966064; c=relaxed/simple;
	bh=HsR6vI/YnFPkdFnl2rxL8na+IY3keIOGzaIFqyFVzo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bNXgmB614sQ3eMlHASzk0De3mm/878N8PayQR9qLWbiatG8wnk26NStf6NwFjkFWCJ71baespbBOaR9t/3HxAFXmJWh8VYJXpoBv8KHyjEXFOiZqSdnR7rrAxYIzMPEbnBraDMrpLy42PkDH7l6kJ6E2oEaueGLlH2bCpyN+FAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNQDvfLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA76C113CF;
	Sat, 27 Sep 2025 09:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758966064;
	bh=HsR6vI/YnFPkdFnl2rxL8na+IY3keIOGzaIFqyFVzo8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gNQDvfLP2ZUMp4wUTC2cRV7ScihQd7ixjTTEVzKjq5FGakYWJYyKbfZ7SitNppfP4
	 3sQwTOFCxwcVAFdzbZ+ZGqKgcmBN+fXV/7Iy3kCKjcn6IWtOMoH+nBWFTJsjd7uiQ9
	 QHDGHly5e5JnCs0nUEYCtn80u/WZVos5kL5p0pmo+P+oJS0xyFhPp4FWQhl7gdzJVp
	 xBNVcODn2E1LNGnFzcshcFq66ifUhURBNG9/03BkQSVgFFgg2dlzWigLTHWzNyBEyi
	 YGbBLE64tjroCtF8F4cfSJWcbKTYYyPDjMoDaSihpbwLHTpN9JWT4/DZXR9A/SfuyK
	 dViHA4DtVQiwg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Sep 2025 11:40:38 +0200
Subject: [PATCH net-next 2/8] tcp: make tcp_rcvbuf_grow() accessible to
 mptcp code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-net-next-mptcp-rcv-path-imp-v1-2-5da266aa9c1a@kernel.org>
References: <20250927-net-next-mptcp-rcv-path-imp-v1-0-5da266aa9c1a@kernel.org>
In-Reply-To: <20250927-net-next-mptcp-rcv-path-imp-v1-0-5da266aa9c1a@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1665; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ZCorjkYZU93IuWz0Ujs0IvajzlZtodMVGTU9qYMX9cc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKub5SrlhU/URrA6mRo9evgv2D+8IutIlv652iITvSX3
 N4eH3Omo5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCKHDzMyzPgpE3WDecXaiTWT
 k26yT16YPsva+LzkhfebGmazetw8conhf2r2qmmmHyPMTTi4AgJ0t/iLKKTeDKuTfd5/NFVhgxI
 nHwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

To leverage the auto-tuning improvements brought by commit 2da35e4b4df9
("Merge branch 'tcp-receive-side-improvements'"), the MPTCP stack need
to access the mentioned helper.

Acked-by: Geliang Tang <geliang@kernel.org>
Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/net/tcp.h    | 1 +
 net/ipv4/tcp_input.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 7c51a0a5ace820bd45d4cc551a15154f8488a880..5ca230ed526ae02711e8d2a409b91664b73390f2 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -370,6 +370,7 @@ void tcp_delack_timer_handler(struct sock *sk);
 int tcp_ioctl(struct sock *sk, int cmd, int *karg);
 enum skb_drop_reason tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
 void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
+void tcp_rcvbuf_grow(struct sock *sk);
 void tcp_rcv_space_adjust(struct sock *sk);
 int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
 void tcp_twsk_destructor(struct sock *sk);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 79d5252ed6cc1a24ec898f4168d47c39c6e92fe1..e2b5a739fb16dcbfce62d63f28bbd1c971aad747 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -891,7 +891,7 @@ static inline void tcp_rcv_rtt_measure_ts(struct sock *sk,
 	}
 }
 
-static void tcp_rcvbuf_grow(struct sock *sk)
+void tcp_rcvbuf_grow(struct sock *sk)
 {
 	const struct net *net = sock_net(sk);
 	struct tcp_sock *tp = tcp_sk(sk);

-- 
2.51.0


