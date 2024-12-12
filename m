Return-Path: <linux-kselftest+bounces-23263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1542D9EECEE
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 16:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD60168BCA
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 15:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D7A22145E;
	Thu, 12 Dec 2024 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="M3fgMpKc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NWViMQyd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291182210DE;
	Thu, 12 Dec 2024 15:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017824; cv=none; b=YaCvOw96/ZU2yChcYbr2T7YKRNy9ziwz2aLzS2gg0yfJyuv8Oha0JmNfjJ1I1qtBJnwB+hGccLl5+P49PNDUJMw4+yrk1iOtJwdP6vl/A0J1pGCEMxFDPKO7isxW2Jqw3JsAPq4Dp/WQVMYB2f9h4fdTo37t5kVUJoe/VqoZQiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017824; c=relaxed/simple;
	bh=rTwanP42XOBdb+zOnioml7iQv76SwfryJp542TqCjTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=np6gOT+ZnRqWlsdwLaaPBqvQUto7/fAj4uCj9cTr1zcw/m3PRcEwIRTibOAmB9RUF9z8NI9E1zDg9p4JTmMONOaK6ltczIkkcFb+sMUT61Jul4sPNklbiXaPVTlzrsBIw4FjttkcqSg9nkAcwo7F9U888xcHyso8Jb3AN3T/xEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=M3fgMpKc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NWViMQyd; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A431E2540248;
	Thu, 12 Dec 2024 10:37:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 12 Dec 2024 10:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1734017820; x=
	1734104220; bh=/1sPIy3F/7iL/wC8sHu+r0fChs97m/vcWccB/KjfqdA=; b=M
	3fgMpKcwQUY85lEgXSQlDVT8lmkl85QbzmPxXoVQQHJ3TusNS5iDiOiea2hQpx55
	4OueMz9ngo0lHMEzSk3Zo+9ttfHMCsDRg28g/itdLUS7Eb7cj95gqBRR7TcQHS25
	whPwOer9RxyzhcjDkKvPfpK4KJ2yKw4WrM8lCAGD+ATIRtI0b51Ac/nTKh32A0xb
	iTpsZNmJ8gaHoPFZGgADLuGlokQzx07Zj7UCm0WWSslGymyuRKFpgGQO7FG5/kcu
	Ak6IGPOv5FwW8mfe/JpuffofHKVwXhDtHcej1ukJPX6k2gqZK7cCD0Zk3HQUGIyO
	wzKcYicDxUWU+gdIBm7vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1734017820; x=1734104220; bh=/
	1sPIy3F/7iL/wC8sHu+r0fChs97m/vcWccB/KjfqdA=; b=NWViMQydh+nM1c/g5
	77r7iGmmfrcpC8jsVlHOCjn9eELv1uBJW+iaVe+Doto+TJZk3pa3PkAlG53IDSpC
	Sg9hXsJSHP2nv5SQW0Ki0w+5IHHU1VgGQPmhR9W4SgSvdIT7DUNDLZHuyntINwf9
	4hZYDdZbLxgrmjtKHAcSNCuTAirlzuJCzGpDOXCD162RyEu2g0AGBZrTPP1lXCym
	8ZdPyePy2h+zt2BFcwLU3zSCyMLLZHO7lcwic1SCcFbHN0uo8DTRvLLR+I6QPvxq
	sFEFZ8FBKttk0CPje9tI3QS0r7dR+F/+UCCwD1n5XXCtmp3G5jiFJFqXaiP+Pb5W
	r7WFw==
X-ME-Sender: <xms:HANbZ-a7surtmwQNlnVWuj8USiNPh3zAm39mmW6_bIHuEI-A-kl_mQ>
    <xme:HANbZxbB6HYehn4QSMrG3OREh9HebBX8KbUZY7gfdEi8PfbitcJ_flMxWlrYNT7_-
    ATDAKzKWwdb7aOQbr8>
X-ME-Received: <xmr:HANbZ49SPMqN5E_1RLUdpqmgqw45AUHLtaCR_y95dMIT8eEKCClmWBIImicb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeehgdejiecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:HANbZwoNk7A8DZNl6iCP6bwYm3ucFZltcHOhlRN7CSAgHk6YHkWLWQ>
    <xmx:HANbZ5pNzzljJSNZkdb5sfOMIsbBNYsi11LwkBU9IWAk-zf6_gIIMQ>
    <xmx:HANbZ-QC23P4q0XABdhjxduAPU1WR12lpehPQgnNgqfD8Ar3tgTzQw>
    <xmx:HANbZ5qkpu306V_5-PI-oR9hYj66EefQueM6l1M-KgQpmFDnDodPHg>
    <xmx:HANbZxbREsz7okLHfyK1n0s70f6CUq0yIc9-8hkCiwSeHEkCduCciQ74>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 10:36:59 -0500 (EST)
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
Subject: [PATCH net-next v5 4/6] docs: tls: document TLS1.3 key updates
Date: Thu, 12 Dec 2024 16:36:07 +0100
Message-ID: <91966d3f6ec42ddb898825f581cb4631ede65da6.1734013874.git.sd@queasysnail.net>
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

Document the kernel's behavior and userspace expectations.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
v3: added following Jakub's comment on the cover letter
v4: add the new counters
v5: improve wording for poll() (Jakub)
    add the new counter

 Documentation/networking/tls.rst | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/networking/tls.rst b/Documentation/networking/tls.rst
index 658ed3a71e1b..c7904a1bc167 100644
--- a/Documentation/networking/tls.rst
+++ b/Documentation/networking/tls.rst
@@ -200,6 +200,32 @@ received without a cmsg buffer set.
 
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
+before the new key is provided will fail with EKEYEXPIRED. poll() will
+not report any read events from the socket until the new key is
+provided. There is no pausing on the transmit side.
+
+Userspace should make sure that the crypto_info provided has been set
+properly. In particular, the kernel will not check for key/nonce
+reuse.
+
+The number of successful and failed key updates is tracked in the
+``TlsTxRekeyOk``, ``TlsRxRekeyOk``, ``TlsTxRekeyError``,
+``TlsRxRekeyError`` statistics. The ``TlsRxRekeyReceived`` statistic
+counts KeyUpdate handshake messages that have been received.
+
 Integrating in to userspace TLS library
 ---------------------------------------
 
@@ -286,3 +312,13 @@ TLS implementation exposes the following per-namespace statistics
 - ``TlsRxNoPadViolation`` -
   number of data RX records which had to be re-decrypted due to
   ``TLS_RX_EXPECT_NO_PAD`` mis-prediction.
+
+- ``TlsTxRekeyOk``, ``TlsRxRekeyOk`` -
+  number of successful rekeys on existing sessions for TX and RX
+
+- ``TlsTxRekeyError``, ``TlsRxRekeyError`` -
+  number of failed rekeys on existing sessions for TX and RX
+
+- ``TlsRxRekeyReceived`` -
+  number of received KeyUpdate handshake messages, requiring userspace
+  to provide a new RX key
-- 
2.47.1


