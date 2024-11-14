Return-Path: <linux-kselftest+bounces-22040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B89A69C8EE7
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 16:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB371F230A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 15:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF07A1AF0B5;
	Thu, 14 Nov 2024 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="UYWfvp5A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="av5enSUK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38231AF0AB;
	Thu, 14 Nov 2024 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599487; cv=none; b=IoJD0HjUsvL5yFlnybu16oD9Ff7k0PraNdxoEF8xbxXtUh+2LfAHtsG7txu1EePkQfSCo1D7UHi/FqdoZBkwkDHG21VEybhfcFV6vWI1RVTDWOIF+ZDSiJtsOep/He25LepkEb8laWlLnxMC2TsthzdqejSfw0VJ0N/MFuiGE5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599487; c=relaxed/simple;
	bh=30wy1Z/spB0lDwPBePbo84QECXK23WetMqA2PARD/oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8MSpd7kxlT6G08uBv0s020M40507IHqP5AP6rPjDQEmHlNyqsj1+teYMSFf7iNvNLqV64+F6MQHDUprUUeXAdDVyKQzKNp6dzQEC6Z/5Ta4S6uYJ8nddsFKtFicUGrKFscwmcvuW1RrVHPQfFF5rQXd58jgw3yD3dS3/ZuN/8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=UYWfvp5A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=av5enSUK; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 941F61D40729;
	Thu, 14 Nov 2024 10:51:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 14 Nov 2024 10:51:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1731599484; x=
	1731603084; bh=PJFJaTCYaCgnYeYgp2KXQVQEnYzvS8ukYY8+k8Qw6AU=; b=U
	YWfvp5AJ0zcbJMWdx/01gkSXSwA/LyjkTTeV+2l+gSOhC2ab1xZRSrpX8yenXkVm
	Ooqa21c0QyFBX0+ipD0JgBxfzWOMrOUsAeitb85ffm+cdlq3HIN4W5ZJidwcZUy/
	otsHQqFRmB+O4gfMW6GHcU4YqTQGBoa04eumubgHbwV1btkY4Rqt32D5qykG6Dqs
	YWrzrRwsnfq0F1od1XQ5gxyO1mzk/5CbMGn0J16hE4Q+Ts4N2zs7Sl95+aOSLT3o
	BuYwidkNBlkp7zIgHQonKAE1Hk/1Z0u3I8efoHsSDXOcXwIfZax+JvVjgx50s4R1
	9RjsK/Tk4aaw+T/VFViwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731599484; x=1731603084; bh=P
	JFJaTCYaCgnYeYgp2KXQVQEnYzvS8ukYY8+k8Qw6AU=; b=av5enSUK5/08qHueb
	NpmPtlroAbvLSsSu17O5VFr451Nv8PMoHMxacqSdc2C2M/7dtHeNw/IfQcPkGjAp
	2PZ9cUjqZA8mkb4lNtoOGrIk/+rGOvi1fqBP6E/zfhW+PlaeRGzz5I939qxuFCvV
	nz+P2bw3nP7FiUvDQcvlmkiLLfF9jSrd9T8SrpwbLkY0Q7d68n/5HYe8Wzn7Iqx8
	ZRcRHjlzyW2R5EJ8/ogEtD+tTZVeFusP16t8a8jy2xazb9TwB89I9D2RYnI2FAga
	gHhUDR/ezDG5Yz6cciP7HMuzCxPq2i5LmT/OWgvq9zLVV0zPYNOfvngtBH2BsBUk
	dNcrw==
X-ME-Sender: <xms:fBw2Z_bAOuJkerSjfpI4v5vBw6RnSJFE3sOp6zHuL-iUpkn9c8EOAg>
    <xme:fBw2Z-ZIH5vjqv_sbwwu_SjWtAZOeYcK17hfgiyUsUsRAlMI6jPYQmXNKgFh-4g-P
    Qr9sqpNrhktxpWw-CY>
X-ME-Received: <xmr:fBw2Zx8GOcc7WjpxpK5uh7WtItnVEOC1rMEisQVIwJYGhU9tL8nNzciVU25e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddvgdekudcutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:fBw2Z1rhPtqc12FeWjlpl1wsYZLLbVTCZAeHhf_pnu8nPqKGvCRR8Q>
    <xmx:fBw2Z6qTeHKgf642cd8EQAVEU3ZOptPNpWhmnyrk2jHIX9oy5OoKgg>
    <xmx:fBw2Z7Q3oB8PcykA5dVayNW62nTyclItUntZE2DNmU4OdKJiZfXAPQ>
    <xmx:fBw2ZyoB0U1UarbGMkjUZa0F8gikGJpKlsRn-R4NTYP45PuKYzDeeg>
    <xmx:fBw2Z3SfQ0RKhlZWuZ8DhB3jIqNoFhhtTttE7eAFrt_z3Gx8G4ZBBfIa>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 10:51:23 -0500 (EST)
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
Subject: [PATCH net-next v4 4/6] docs: tls: document TLS1.3 key updates
Date: Thu, 14 Nov 2024 16:50:51 +0100
Message-ID: <6baaaaf467845c56d7ec47250aaa2138de948003.1731597571.git.sd@queasysnail.net>
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

v3: added following Jakub's comment on the cover letter
v4: add the new counters

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 Documentation/networking/tls.rst | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/networking/tls.rst b/Documentation/networking/tls.rst
index 658ed3a71e1b..dfce109fe2ca 100644
--- a/Documentation/networking/tls.rst
+++ b/Documentation/networking/tls.rst
@@ -200,6 +200,31 @@ received without a cmsg buffer set.
 
 recv will never return data from mixed types of TLS records.
 
+TLS 1.3 Key Updates
+-------------------
+
+In TLS 1.3, KeyUpdate handshake messages signal that the sender is
+updating its TX key. Any message sent after a KeyUpdate will be
+encrypted using the new key. The userspace library can pass the new
+key to the kernel using the TLS_TX and TLS_RX socket options, as for
+the initial keys. TLS version and cipher cannot be changed.
+
+To prevent attempting to decrypt incoming records using the wrong key,
+decryption will be paused when a KeyUpdate message is received by the
+kernel, until the new key has been provided using the TLS_RX socket
+option. Any read occurring after the KeyUpdate has been read and
+before the new key is provided will fail with EKEYEXPIRED. Poll()'ing
+the socket will also sleep until the new key is provided. There is no
+pausing on the transmit side.
+
+Userspace should make sure that the crypto_info provided has been set
+properly. In particular, the kernel will not check for key/nonce
+reuse.
+
+The number of successful and failed key updates is tracked in the
+``TlsTxRekeyOk``, ``TlsRxRekeyOk``, ``TlsTxRekeyError``,
+``TlsRxRekeyError`` statistics.
+
 Integrating in to userspace TLS library
 ---------------------------------------
 
@@ -286,3 +311,9 @@ TLS implementation exposes the following per-namespace statistics
 - ``TlsRxNoPadViolation`` -
   number of data RX records which had to be re-decrypted due to
   ``TLS_RX_EXPECT_NO_PAD`` mis-prediction.
+
+- ``TlsTxRekeyOk``, ``TlsRxRekeyOk`` -
+  number of successful rekeys on existing sessions for TX and RX
+
+- ``TlsTxRekeyError``, ``TlsRxRekeyError`` -
+  number of failed rekeys on existing sessions for TX and RX
-- 
2.47.0


