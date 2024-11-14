Return-Path: <linux-kselftest+bounces-22039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D84FA9C8EE3
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 16:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A04288C7C
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 15:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CDE1AED3F;
	Thu, 14 Nov 2024 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="B887D/6l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rd9VErAa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044411AE00E;
	Thu, 14 Nov 2024 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599484; cv=none; b=KcyVHmMJ3eyLlkUBxPL4QeayCD3ifibO0PnQMD85hFTtC9M6YvtIVWtHQb5eoKCV02wavVa3o5T2fpd3h+rbrkHBB0q04KZmbFDqdZljmtP36//MCZflU5V8y+BljYPgx+SrW6ypU9Cp9vwcnyIiqbjm7+wNvuvXbOPbG6kI5ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599484; c=relaxed/simple;
	bh=qKdQM8FeF+A3Tnlxcv2K8QFuoAvxRzOFJ/DMk2TKJCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TcHbw3qkeda9ERQCKcAi6UqFGfjRfPtiau2m6dxeCchB7PAGlcO+Szq6j6sdgiEjLae8QxFA+TQ0ZOnT3sZuK3TPe6/tLs9Fb+B7WCH4FDNJuN1VpGlhQ1klMhJlL7E0Tm6juilwCzhUDnSBU8YN22sWBL2P/OaapDCFZoeUrOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=B887D/6l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rd9VErAa; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailflow.stl.internal (Postfix) with ESMTP id CF3A41D406CA;
	Thu, 14 Nov 2024 10:51:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 14 Nov 2024 10:51:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1731599481; x=
	1731603081; bh=cBeja80XPGADhlBgSU4qc0hgXpVWcNJ9Htq3slTuA5c=; b=B
	887D/6lXhe+nSYfLyTGJKDrlVjqp4XjLM8DSi5KZ3Ow5lVxXPeXwtMdPEcWZTOf6
	KLb9R3rJpar75pLpPzc3IMJbZUxSuPhdvH/uK9wzpHdWcuNt9qm4ZGsNvlCW87LV
	oebkPlm379riy44jY0fnDz3x1YB1CmvTwuc7WwHceh9i23WNrgz++I09xKXbunCB
	lDuplltbD+A6sXxY5uani+BbUR62rRJgVM9mTLu6VfuYg6u8cXvBygjHtnfsEd0q
	et3FV37v1Lqdh5PeXgp2/7Jn2X4c8Hu6JZeQ57kVpyW8b0zNmNkh8HzuWj0u0fjS
	Yuc0LYexWY/1MARcDx2UA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731599481; x=1731603081; bh=c
	Beja80XPGADhlBgSU4qc0hgXpVWcNJ9Htq3slTuA5c=; b=Rd9VErAaOiJgH+b25
	CGRBO6Q6y8r+q2wAr3b0SyR4vKcHNre3fxsCKLwlrmcDO/ooNiMw12zbeLSkzWxy
	/bjt1tKStzNBbS6IPTAQ8dcK5MUgFHZ1riv8soHOQWl19RlO5s7XJMVWX7/MYETi
	4icgaaNjMa7TEYZp2NT4AJxHDYXAF2ArmQfSZPzN2QMkFYAIB30zkffSHGHITfuF
	j5l9R5Xh0rCMQuZAHtaVMAJ+P9B5v78SdU1AsChz3dpbPA5GiYeaseWaVvWumxGM
	s0U6mOJwhjeOIX/yvznUq/ZhpA/8gODjq6hr+pgrW7yz5JkZ9gsTyoXdBmEVLwsi
	nUoVg==
X-ME-Sender: <xms:eRw2Z8a9uOlQZJSzDjUpiQfV1S4QmCnyqTCvR1l4Kz8gwU2Q2fkscA>
    <xme:eRw2Z3bNpmwB2BgHoxT9KKDoMfwXJ8Ontj8KW42utzRMVF6Ml0O6NyySaiNfDrh6D
    sE6W6YBtrnhf7RhhSg>
X-ME-Received: <xmr:eRw2Z2_XxdMZzoarHk3tfoZQ-FAb1FY6bzyK8QCm0dwRzvIi2gPQQl8EYoxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddvgdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeeiieeuieethedtfeehkefhhfegveeuhfet
    veeuleejieejieevhefghedugfehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghr
    tghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvghtuggvvh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsugesqhhuvggrshihshhn
    rghilhdrnhgvthdprhgtphhtthhopehvfhgvughorhgvnhhkohesnhhovhgvkhdrrhhupd
    hrtghpthhtohepfhhkrhgvnhiivghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopehk
    uhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhunhhihihusegrmhgriihonh
    drtghomhdprhgtphhtthhopegrphhoohhrvhhkohesrghmrgiiohhnrdgtohhmpdhrtghp
    thhtohepsghorhhishhpsehnvhhiughirgdrtghomhdprhgtphhtthhopehjohhhnhdrfh
    grshhtrggsvghnugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:eRw2Z2rgAQwUIq-x7pptGy0JwaS6ZbTrc1LUw_J2X3O3pIs6rNirQQ>
    <xmx:eRw2Z3qNZ9Y8OEZYCuwIJlC4bqdqlbbbxZNlgqCN8_8rOcxWTxrBNQ>
    <xmx:eRw2Z0R1kQySp8MtcVpqfKJzNAxjTlmOruXGRJAed4JB1UR9MLgpbA>
    <xmx:eRw2Z3qXl452Ny1s0NXS5ePxJlxR691ei0-1VhBThbBGr2J0P_ci6w>
    <xmx:eRw2ZwRhPzWwWY8n7Avh1XAaiXM-u67rdhYgYBNzay2o7uxvCEq8-tb2>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 10:51:20 -0500 (EST)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Vadim Fedorenko <vfedorenko@novek.ru>,
	Frantisek Krenzelok <fkrenzel@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Apoorv Kothari <apoorvko@amazon.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v4 3/6] tls: add counters for rekey
Date: Thu, 14 Nov 2024 16:50:50 +0100
Message-ID: <2f5b01548afb3795fb5f6aace6c2182ab98b9076.1731597571.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731597571.git.sd@queasysnail.net>
References: <cover.1731597571.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This introduces 4 counters to keep track of key updates:
Tls{Rx,Tx}Rekey{Ok,Error}.

v4: new patch

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 include/uapi/linux/snmp.h |  4 ++++
 net/tls/tls_main.c        | 27 ++++++++++++++++++++++-----
 net/tls/tls_proc.c        |  4 ++++
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index adf5fd78dd50..b0e6f922e72f 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -358,6 +358,10 @@ enum
 	LINUX_MIB_TLSRXDEVICERESYNC,		/* TlsRxDeviceResync */
 	LINUX_MIB_TLSDECRYPTRETRY,		/* TlsDecryptRetry */
 	LINUX_MIB_TLSRXNOPADVIOL,		/* TlsRxNoPadViolation */
+	LINUX_MIB_TLSRXREKEYOK,			/* TlsRxRekeyOk */
+	LINUX_MIB_TLSRXREKEYERROR,		/* TlsRxRekeyError */
+	LINUX_MIB_TLSTXREKEYOK,			/* TlsTxRekeyOk */
+	LINUX_MIB_TLSTXREKEYERROR,		/* TlsTxRekeyError */
 	__LINUX_MIB_TLSMAX
 };
 
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 68b5735dafc1..9ee5a83c5b40 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -640,8 +640,11 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 		/* Currently we only support setting crypto info more
 		 * than one time for TLS 1.3
 		 */
-		if (crypto_info->version != TLS_1_3_VERSION)
+		if (crypto_info->version != TLS_1_3_VERSION) {
+			TLS_INC_STATS(sock_net(sk), tx ? LINUX_MIB_TLSTXREKEYERROR
+						       : LINUX_MIB_TLSRXREKEYERROR);
 			return -EBUSY;
+		}
 
 		update = true;
 		old_crypto_info = crypto_info;
@@ -696,8 +699,13 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 						update ? crypto_info : NULL);
 			if (rc)
 				goto err_crypto_info;
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXSW);
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW);
+
+			if (update) {
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
+			} else {
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXSW);
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW);
+			}
 			conf = TLS_SW;
 		}
 	} else {
@@ -711,8 +719,13 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 						update ? crypto_info : NULL);
 			if (rc)
 				goto err_crypto_info;
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXSW);
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXSW);
+
+			if (update) {
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
+			} else {
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXSW);
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXSW);
+			}
 			conf = TLS_SW;
 		}
 		if (!update)
@@ -735,6 +748,10 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 	return 0;
 
 err_crypto_info:
+	if (update) {
+		TLS_INC_STATS(sock_net(sk), tx ? LINUX_MIB_TLSTXREKEYERROR
+					       : LINUX_MIB_TLSRXREKEYERROR);
+	}
 	memzero_explicit(crypto_ctx, sizeof(*crypto_ctx));
 	return rc;
 }
diff --git a/net/tls/tls_proc.c b/net/tls/tls_proc.c
index 68982728f620..44ccdc90095c 100644
--- a/net/tls/tls_proc.c
+++ b/net/tls/tls_proc.c
@@ -22,6 +22,10 @@ static const struct snmp_mib tls_mib_list[] = {
 	SNMP_MIB_ITEM("TlsRxDeviceResync", LINUX_MIB_TLSRXDEVICERESYNC),
 	SNMP_MIB_ITEM("TlsDecryptRetry", LINUX_MIB_TLSDECRYPTRETRY),
 	SNMP_MIB_ITEM("TlsRxNoPadViolation", LINUX_MIB_TLSRXNOPADVIOL),
+	SNMP_MIB_ITEM("TlsRxRekeyOk", LINUX_MIB_TLSRXREKEYOK),
+	SNMP_MIB_ITEM("TlsRxRekeyError", LINUX_MIB_TLSRXREKEYERROR),
+	SNMP_MIB_ITEM("TlsTxRekeyOk", LINUX_MIB_TLSTXREKEYOK),
+	SNMP_MIB_ITEM("TlsTxRekeyError", LINUX_MIB_TLSTXREKEYERROR),
 	SNMP_MIB_SENTINEL
 };
 
-- 
2.47.0


