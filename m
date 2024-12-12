Return-Path: <linux-kselftest+bounces-23262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB409EECAD
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 16:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470CE283D03
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 15:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9EC21E0AA;
	Thu, 12 Dec 2024 15:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="A0SiBgXe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="abScBvya"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AA1217F28;
	Thu, 12 Dec 2024 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017821; cv=none; b=Ga7s+46M9qfjBZvIHsmf4ufdUKzyhjnLN1IIIo6THbhcI69hNi0LxRGmiHIhbhibTRwxsbk0ekdGaJjglJIACF6nzIsMijQi6yYjcAdWrn4Ppooe70pcIzJmcSnN8wzNvBMLPsffHTFoq+4UCm/K2rj+A2MvrTjzWb7CGMzx/uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017821; c=relaxed/simple;
	bh=J+XawYgeYRTJx6++DRkn7cg4UxvLyp0v/UPreTWiB00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZy0HeJjdwfwLdfBCwtJ06pZgXVyxD4GiMokk0X3kswNK9YFO+n6QNg0Zrc5APJx280uBc8ippl+/kWOYai3WSOe+2dEX7HA90w9PotaCOzPGmyafX94Npp2DN96Ly+Fh+jvVEFrisieE28ou+xS6RxgW33brZ6mtrb1GB4FPC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=A0SiBgXe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=abScBvya; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id BB58F11400E4;
	Thu, 12 Dec 2024 10:36:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 12 Dec 2024 10:36:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1734017817; x=
	1734104217; bh=nC7C7XefrK+Mqd1EomVee/4r+rsa1AmZ2n6KhZZFBlo=; b=A
	0SiBgXeWFrJKzUVPPqRmlgHNd8TgLnUiun4Z91jbQA9mud0tTGw+bUFPHcCtezO+
	z6X7DirbTwVLi+yM8IgKO3zx/WZF5ll6s8/Atzg3fbM38QHADeopfmfWVXWezCk1
	YJBvzGXfooudIGmnhShvK0mxe5tP2bpPgS399nltrsZEJsIowYtN0bpHDmpHNx+b
	t8L7FqXAAS1VTARc8guCygCfbe8FiVhrc8sVICoDeuCW3senaPW2DXiNqzFoCslI
	rYA88dFdzMuxIkYlyLhEhObpMvS8gTMZgqWNeHakMk2yq1EApa0pmPfu+CUhk3A2
	B7FHgj93R75Rt53g6OiGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1734017817; x=1734104217; bh=n
	C7C7XefrK+Mqd1EomVee/4r+rsa1AmZ2n6KhZZFBlo=; b=abScBvyaQcf7szzb4
	wVQluaXD9acA1KEDlVRDxjjjejQ6DGqOQtHzfDOtIA9r5To4zSvAuyMMhGMT0bBI
	sz9Ep3e3w9bKc5ET35zljXBvNNfQJy95+Ux9mjK333t4aIgSQDFUL/pCAAkA94Dz
	zuN05Ed3NJCWXaUTxR7vn3lc5c4dAkfy0yVCQpUwi3tSADg3cytucQZlxnj8WhMO
	/pqHlrIY6aS5u25onDfYOfRqJBALm+nqNokCmFZGLE5j/pHtzOo1qQbJDDRBN0oo
	WJFtgZ5/Jt2r+JuTHRfhSIGZojiv5M6rPwQwIEKxJtoRXXT5SO8rbG7UBOHJxCzG
	NV9/g==
X-ME-Sender: <xms:GQNbZ3_xiM_WMmJtuxtmydX4UMx_Gz8jA_4TKzkfMd3Ubuddq3suJg>
    <xme:GQNbZzsJUXHD6oAKZmCVnensXQ0I-aX2IbFqmgyITJ7tQo-h9UTvVh_mgpsZPN0Cv
    wEKY50hEwu83fOvYbg>
X-ME-Received: <xmr:GQNbZ1BIkLHJUhWfXAtN2g7y7TJ3qpyA_YGX6GTr64ch2_amn2Sqb4zZC3Di>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeehgdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeeiieeuieethedtfeehkefhhfegveeuhfet
    veeuleejieejieevhefghedugfehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghr
    tghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvghtuggvvh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsugesqhhuvggrshihshhn
    rghilhdrnhgvthdprhgtphhtthhopehvfhgvughorhgvnhhkohesnhhovhgvkhdrrhhupd
    hrtghpthhtohepfhhkrhgvnhiivghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopehk
    uhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhunhhihihusegrmhgriihonh
    drtghomhdprhgtphhtthhopegrphhoohhrvhhkohesrghmrgiiohhnrdgtohhmpdhrtghp
    thhtohepsghorhhishhpsehnvhhiughirgdrtghomhdprhgtphhtthhopehjohhhnhdrfh
    grshhtrggsvghnugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:GQNbZzcWCoocTLts3NVSYJkKg5pd_dxiliYifvMujbsi37IbiClBxA>
    <xmx:GQNbZ8OjOD-eutfOB2hkuP5mr0_ax3trgH8TuNxa6ze7wz298HoPiQ>
    <xmx:GQNbZ1mI6WBaAxiY3k8dcF6fYyNznogzwsv7pnSeLhRIriVYEcM2MA>
    <xmx:GQNbZ2uVmGY9BYWTLfIFCxYaGfTuS5ZLal3a3UJxZn5mBIlcjo9k6g>
    <xmx:GQNbZxuU0f54gSawnT8CUhOSY171M6P9zHl95HzS0kket81UntRLPqWi>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 10:36:56 -0500 (EST)
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
	Simon Horman <horms@kernel.org>,
	Parthiban.Veerasooran@microchip.com
Subject: [PATCH net-next v5 3/6] tls: add counters for rekey
Date: Thu, 12 Dec 2024 16:36:06 +0100
Message-ID: <d4c4b98697d369bbbdcb3b40d0570fb30be2c86e.1734013874.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734013874.git.sd@queasysnail.net>
References: <cover.1734013874.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This introduces 5 counters to keep track of key updates:
Tls{Rx,Tx}Rekey{Ok,Error} and TlsRxRekeyReceived.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
v4: new patch, suggested by Jakub
v5: add TlsRxRekeyReceived

 include/uapi/linux/snmp.h |  5 +++++
 net/tls/tls_main.c        | 27 ++++++++++++++++++++++-----
 net/tls/tls_proc.c        |  5 +++++
 net/tls/tls_sw.c          |  6 ++++--
 4 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index adf5fd78dd50..51da2e00112d 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -358,6 +358,11 @@ enum
 	LINUX_MIB_TLSRXDEVICERESYNC,		/* TlsRxDeviceResync */
 	LINUX_MIB_TLSDECRYPTRETRY,		/* TlsDecryptRetry */
 	LINUX_MIB_TLSRXNOPADVIOL,		/* TlsRxNoPadViolation */
+	LINUX_MIB_TLSRXREKEYOK,			/* TlsRxRekeyOk */
+	LINUX_MIB_TLSRXREKEYERROR,		/* TlsRxRekeyError */
+	LINUX_MIB_TLSTXREKEYOK,			/* TlsTxRekeyOk */
+	LINUX_MIB_TLSTXREKEYERROR,		/* TlsTxRekeyError */
+	LINUX_MIB_TLSRXREKEYRECEIVED,		/* TlsRxRekeyReceived */
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
index 68982728f620..367666aa07b8 100644
--- a/net/tls/tls_proc.c
+++ b/net/tls/tls_proc.c
@@ -22,6 +22,11 @@ static const struct snmp_mib tls_mib_list[] = {
 	SNMP_MIB_ITEM("TlsRxDeviceResync", LINUX_MIB_TLSRXDEVICERESYNC),
 	SNMP_MIB_ITEM("TlsDecryptRetry", LINUX_MIB_TLSDECRYPTRETRY),
 	SNMP_MIB_ITEM("TlsRxNoPadViolation", LINUX_MIB_TLSRXNOPADVIOL),
+	SNMP_MIB_ITEM("TlsRxRekeyOk", LINUX_MIB_TLSRXREKEYOK),
+	SNMP_MIB_ITEM("TlsRxRekeyError", LINUX_MIB_TLSRXREKEYERROR),
+	SNMP_MIB_ITEM("TlsTxRekeyOk", LINUX_MIB_TLSTXREKEYOK),
+	SNMP_MIB_ITEM("TlsTxRekeyError", LINUX_MIB_TLSTXREKEYERROR),
+	SNMP_MIB_ITEM("TlsRxRekeyReceived", LINUX_MIB_TLSRXREKEYRECEIVED),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 9e5aff5bab98..47550d485819 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1724,7 +1724,8 @@ tls_decrypt_device(struct sock *sk, struct msghdr *msg,
 	return 1;
 }
 
-static int tls_check_pending_rekey(struct tls_context *ctx, struct sk_buff *skb)
+static int tls_check_pending_rekey(struct sock *sk, struct tls_context *ctx,
+				   struct sk_buff *skb)
 {
 	const struct strp_msg *rxm = strp_msg(skb);
 	const struct tls_msg *tlm = tls_msg(skb);
@@ -1747,6 +1748,7 @@ static int tls_check_pending_rekey(struct tls_context *ctx, struct sk_buff *skb)
 		struct tls_sw_context_rx *rx_ctx = ctx->priv_ctx_rx;
 
 		WRITE_ONCE(rx_ctx->key_update_pending, true);
+		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYRECEIVED);
 	}
 
 	return 0;
@@ -1771,7 +1773,7 @@ static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
 	rxm->full_len -= prot->overhead_size;
 	tls_advance_record_sn(sk, prot, &tls_ctx->rx);
 
-	return tls_check_pending_rekey(tls_ctx, darg->skb);
+	return tls_check_pending_rekey(sk, tls_ctx, darg->skb);
 }
 
 int decrypt_skb(struct sock *sk, struct scatterlist *sgout)
-- 
2.47.1


