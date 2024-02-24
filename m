Return-Path: <linux-kselftest+bounces-5404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D1686239A
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 10:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C701C2031B
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 09:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4914517BA5;
	Sat, 24 Feb 2024 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Y1KeiGhY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE301B819
	for <linux-kselftest@vger.kernel.org>; Sat, 24 Feb 2024 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708765491; cv=none; b=FKV1SeIinMKcSAk/got344niCdchMq9TBhfrfTGFEUqVY+VHe79bz931U/yqaSnhv5kvm445cVwY+bkPwzptBZM2NzIavaRG6ClQythnU0Guy6Ba5NKQYO39v6smbDk/UzcUfAN1MrS0gu4/o6cYGm3HfzRDEowhxCCZ42fL8os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708765491; c=relaxed/simple;
	bh=dkVRlxZapEZPVo1HlQHs8NB5QOOr7LplY2MzBsV+hXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uYpcKPBmCZboFvSlq3GHQ5nPIwTVZuVsOFfoOMFgIEXuu+AaNDC/A1UfCrxM3eKOER6GRSv9xmnakr6AyWE/PktoL6rncFv3z0FXuQ2wtUmJX8JZcyPuWNbwJXLVrodJNss6hwYa/DObxNfUwe7keIHeAU/RXmeanglCupMGHE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=Y1KeiGhY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41296dce264so8175885e9.3
        for <linux-kselftest@vger.kernel.org>; Sat, 24 Feb 2024 01:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1708765486; x=1709370286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVf8ubtimcYBJcwjV010/pmV64cOLapisaNAn6DWlIA=;
        b=Y1KeiGhYmUO5yNXYu3tXNBNefWNzgQFKyVISJp771Q8EyXnqK0lgoU9UhWYPBUQrb0
         cLkgL1G7x3Fktjkufv5JfYqfPEPjo5lCRYFrz+4xkzRt5JZxGEt+oFKQi9/4m+NcoJeC
         tfmaKACaswdRybDwXxxdq8I1fmoEHFf0clKHilnZtNldwVWDHE399H757spCU+nnj3tY
         Y8ML9T9fhjBSDjhhj3RU9Ukl/DKfjg4LQR028cNrrgVz8OSHQ1k5ISqfcYObWDKBW4DB
         dI8PIHut7hTdVMw039V/qszB/yzk8AZ2ZYhKAsQZP42wabxjtic3N6GN9nXMU9mEBbE1
         bqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708765486; x=1709370286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVf8ubtimcYBJcwjV010/pmV64cOLapisaNAn6DWlIA=;
        b=mY8BGRN/xYqryC3pEIHO4p+bBsnOI6R0JB84ZkGDUTAXqrO5ZjM8l7HQ+2gDo04BCz
         Uk6USTgIwH8Az0qlyQA/kqPuO4enIjNRhMok6NcyOP36xvetgG+PDhi1QXNS/h5rBIgp
         I5NUi40ShDz0DJhKKbxxDdjdOlRb3EZ+9p0RMi4el3llDe/0MMpIctxt3gM7jsQvkn4j
         hSySw9ICcFdgYQcHxXdHdw51w0PtEmryVVlB6Y498uruiUFEPrrF2tkmc9DNs34Nbv9R
         yE18csUyoYwFugODne623vx0wH6hNunAERzHvOA4ME2fKyvrfH9X0hGvYrSfHZV0FWDR
         3/fg==
X-Forwarded-Encrypted: i=1; AJvYcCWPE6v5HRiuohq0RRq+mQEEglg+Bx4leEOtjeka2SZJyn90PeHs4iaxc0chNZ6e/N8fz1wfV3daNI+gJFhbGHMj0XSFbh1/W1p2ZfaYA3nR
X-Gm-Message-State: AOJu0YwQaEvPhGdA4kAbSq6wOTXgltod4ytX03tlHX27bGRKwIBUO91w
	nQOvHHIfDXyWRZPDZ8dN4vsvwsrrVq0awbzGhViZJ3EBtCws524LYhTMX2iRgw==
X-Google-Smtp-Source: AGHT+IE1zA2oVwN2wokBEqB14i6tIB2v07fTO+K5sVNBjM85YT4nUiMZu0rdoJDc0VuSJtpUaYXfAA==
X-Received: by 2002:a05:600c:384e:b0:412:7585:bea7 with SMTP id s14-20020a05600c384e00b004127585bea7mr1283665wmr.5.1708765486647;
        Sat, 24 Feb 2024 01:04:46 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bce06000000b00410bca333b7sm5320593wmc.27.2024.02.24.01.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 01:04:45 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dmitry Safonov <dima@arista.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [PATCH net-next 03/10] net/tcp: Move tcp_inbound_hash() from headers
Date: Sat, 24 Feb 2024 09:04:11 +0000
Message-ID: <20240224-tcp-ao-tracepoints-v1-3-15f31b7f30a7@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com>
References: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708765347; l=5609; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=dkVRlxZapEZPVo1HlQHs8NB5QOOr7LplY2MzBsV+hXk=; b=HzEYB6ULcdQGce14J2gKFfRi/qiy0saSFeVJiAIyNQYfdgJYh26AS2kS5GQd2tsYsFbfJlDkt lVKpB4nMSWxC0MKnXOuOAu7E1YHjZ5/TdYZz3PxiEU+/cpbB4dzQ3YG
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

Two reasons:
1. It's grown up enough
2. In order to not do header spaghetti by including
   <trace/events/tcp.h>, which is necessary for TCP tracepoints.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/net/tcp.h | 65 ++++---------------------------------------------
 net/ipv4/tcp.c    | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 61 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index c1fff9207e2d..c80bdfb5efe5 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2789,66 +2789,9 @@ static inline bool tcp_ao_required(struct sock *sk, const void *saddr,
 	return false;
 }
 
-/* Called with rcu_read_lock() */
-static inline enum skb_drop_reason
-tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
-		 const struct sk_buff *skb,
-		 const void *saddr, const void *daddr,
-		 int family, int dif, int sdif)
-{
-	const struct tcphdr *th = tcp_hdr(skb);
-	const struct tcp_ao_hdr *aoh;
-	const __u8 *md5_location;
-	int l3index;
-
-	/* Invalid option or two times meet any of auth options */
-	if (tcp_parse_auth_options(th, &md5_location, &aoh)) {
-		tcp_hash_fail("TCP segment has incorrect auth options set",
-			      family, skb, "");
-		return SKB_DROP_REASON_TCP_AUTH_HDR;
-	}
-
-	if (req) {
-		if (tcp_rsk_used_ao(req) != !!aoh) {
-			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
-			tcp_hash_fail("TCP connection can't start/end using TCP-AO",
-				      family, skb, "%s",
-				      !aoh ? "missing AO" : "AO signed");
-			return SKB_DROP_REASON_TCP_AOFAILURE;
-		}
-	}
-
-	/* sdif set, means packet ingressed via a device
-	 * in an L3 domain and dif is set to the l3mdev
-	 */
-	l3index = sdif ? dif : 0;
-
-	/* Fast path: unsigned segments */
-	if (likely(!md5_location && !aoh)) {
-		/* Drop if there's TCP-MD5 or TCP-AO key with any rcvid/sndid
-		 * for the remote peer. On TCP-AO established connection
-		 * the last key is impossible to remove, so there's
-		 * always at least one current_key.
-		 */
-		if (tcp_ao_required(sk, saddr, family, l3index, true)) {
-			tcp_hash_fail("AO hash is required, but not found",
-					family, skb, "L3 index %d", l3index);
-			return SKB_DROP_REASON_TCP_AONOTFOUND;
-		}
-		if (unlikely(tcp_md5_do_lookup(sk, l3index, saddr, family))) {
-			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5NOTFOUND);
-			tcp_hash_fail("MD5 Hash not found",
-				      family, skb, "L3 index %d", l3index);
-			return SKB_DROP_REASON_TCP_MD5NOTFOUND;
-		}
-		return SKB_NOT_DROPPED_YET;
-	}
-
-	if (aoh)
-		return tcp_inbound_ao_hash(sk, skb, family, req, l3index, aoh);
-
-	return tcp_inbound_md5_hash(sk, skb, saddr, daddr, family,
-				    l3index, md5_location);
-}
+enum skb_drop_reason tcp_inbound_hash(struct sock *sk,
+		const struct request_sock *req, const struct sk_buff *skb,
+		const void *saddr, const void *daddr,
+		int family, int dif, int sdif);
 
 #endif	/* _TCP_H */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index c82dc42f57c6..5fd61ae6bcc9 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4485,6 +4485,78 @@ EXPORT_SYMBOL(tcp_inbound_md5_hash);
 
 #endif
 
+/* Called with rcu_read_lock() */
+enum skb_drop_reason
+tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
+		 const struct sk_buff *skb,
+		 const void *saddr, const void *daddr,
+		 int family, int dif, int sdif)
+{
+	const struct tcphdr *th = tcp_hdr(skb);
+	const struct tcp_ao_hdr *aoh;
+	const __u8 *md5_location;
+	int l3index;
+
+	/* Invalid option or two times meet any of auth options */
+	if (tcp_parse_auth_options(th, &md5_location, &aoh)) {
+		tcp_hash_fail("TCP segment has incorrect auth options set",
+			      family, skb, "");
+		return SKB_DROP_REASON_TCP_AUTH_HDR;
+	}
+
+	if (req) {
+		if (tcp_rsk_used_ao(req) != !!aoh) {
+			u8 keyid, rnext, maclen;
+
+			if (aoh) {
+				keyid = aoh->keyid;
+				rnext = aoh->rnext_keyid;
+				maclen = tcp_ao_hdr_maclen(aoh);
+			} else {
+				keyid = rnext = maclen = 0;
+			}
+
+			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
+			tcp_hash_fail("TCP connection can't start/end using TCP-AO",
+				      family, skb, "%s",
+				      !aoh ? "missing AO" : "AO signed");
+			return SKB_DROP_REASON_TCP_AOFAILURE;
+		}
+	}
+
+	/* sdif set, means packet ingressed via a device
+	 * in an L3 domain and dif is set to the l3mdev
+	 */
+	l3index = sdif ? dif : 0;
+
+	/* Fast path: unsigned segments */
+	if (likely(!md5_location && !aoh)) {
+		/* Drop if there's TCP-MD5 or TCP-AO key with any rcvid/sndid
+		 * for the remote peer. On TCP-AO established connection
+		 * the last key is impossible to remove, so there's
+		 * always at least one current_key.
+		 */
+		if (tcp_ao_required(sk, saddr, family, l3index, true)) {
+			tcp_hash_fail("AO hash is required, but not found",
+					family, skb, "L3 index %d", l3index);
+			return SKB_DROP_REASON_TCP_AONOTFOUND;
+		}
+		if (unlikely(tcp_md5_do_lookup(sk, l3index, saddr, family))) {
+			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5NOTFOUND);
+			tcp_hash_fail("MD5 Hash not found",
+				      family, skb, "L3 index %d", l3index);
+			return SKB_DROP_REASON_TCP_MD5NOTFOUND;
+		}
+		return SKB_NOT_DROPPED_YET;
+	}
+
+	if (aoh)
+		return tcp_inbound_ao_hash(sk, skb, family, req, l3index, aoh);
+
+	return tcp_inbound_md5_hash(sk, skb, saddr, daddr, family,
+				    l3index, md5_location);
+}
+
 void tcp_done(struct sock *sk)
 {
 	struct request_sock *req;

-- 
2.43.0


