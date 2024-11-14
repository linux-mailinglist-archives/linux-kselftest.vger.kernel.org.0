Return-Path: <linux-kselftest+bounces-22036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A72BE9C8ED9
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 16:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A581F21BB2
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 15:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BB9187550;
	Thu, 14 Nov 2024 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="aFaQ6kR3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pr2S4V5m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00D336AF5;
	Thu, 14 Nov 2024 15:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599477; cv=none; b=E9fk9s29D4S6X6j8oKup4qkcdHfKdOfYO9Bxh3RN7SlSTgHbOr+pZqgAcPJ1q8N3ONSnGyRokXc57zWMOAnJxNEujQCjEI5hhT+t+SJnUn5pgIKHHKGydWyeNLiV6FsWnMOeYnO2ZU1oHQkhoCOFVv9Jo9ovNkdy5iSfOwoMIS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599477; c=relaxed/simple;
	bh=NWVrAREi7Y6JrcFlDDljiiCiPxtkbQBrxSD50fu/TY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oQBuehMDoV9geOQ+4CTkapbRgDf6pyHI90N4/hoiHMaPsRBB7XWQCP9sFEIws467cFrnf/2JusthMkQZoApqEj2YAcJudB2MFswOkdSUKJufA7hd0AB12SGDBngzbxVSRYBMrxxM8W0m+A4K/5PeyB0AcF4X/8MIN4g9an/DH7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=aFaQ6kR3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pr2S4V5m; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 16E491D406FA;
	Thu, 14 Nov 2024 10:51:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 14 Nov 2024 10:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1731599471; x=1731603071; bh=DZpfHJ919O
	FLwOe089qQmbHfntTUi+mQcmGOGQa7MSU=; b=aFaQ6kR37jEr3uhAoV2j3M3jlR
	b5DcgI1KKvFRTCSOJ0SCiboMyAlda1nIYRA+/9gDUwx/0EuWIVtCRdKT48ozAAnY
	/vghGstLMJOBcNuIfVNP3goasI8NM/8VzOR743nHXSVjAtdOBjhkhjKtCHbDhlcO
	z4NPAM9iWDcm6Hr/BlPqVJrWJsBYw9X+j11QlsfVMs6ICWYjAGOeG0blwjsLi+TS
	sppN9EfBRauTzGbHYZPy7ejaFDHV3MDGQjqodiv210jTdaFefVxSRAP6nMcN+NWp
	iGMs0JN29NEXZLdF5zWzMmTmKSmQCdX7wjp1UcQNYyYRm7zCdSAZbaMxneoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731599471; x=1731603071; bh=DZpfHJ919OFLwOe089qQmbHfntTUi+mQcmG
	OGQa7MSU=; b=Pr2S4V5mwIAPNCG7jp2RMpxkJHz41HEpq+YtfrKjKsYufKAAxfb
	K3nbuQEYhyWf8ElGlhkkbQoE5sz2tGidaNG9NaVTYPRxAIGnUKr6ggtefKQdiRqF
	9sz+unwqemM11kKIfHN87Y1uhQBVquH9MK3lavumvyUbiaf+sO6qYHsMrxM26L4c
	HE+TzTa6LZUHNJl8zCABQSFZv8DvqHPEhCTj2Hb/VCqr6mP68l+8Xjuwj1x3cYRG
	tBqAkyfR8o16q0XJPNeorVXFJ+z3P5DqJbHrcdp6RaPvdQNHsZeDLx+aHBLnUsoS
	u9DW6h2sUvfJ7/fl4ZbVBDzNblMWQcJ6Axg==
X-ME-Sender: <xms:bhw2ZzlOcrXgEYA0lr5TDtJ7Mj1anbqr8-7B_Jo54JxpdQeKEXdOGw>
    <xme:bhw2Z22gdMZmviHyFyIIA_hplrYD9bPh6e0-O1ABvOZKnEsV5ZMlDxvUMJX8fxkk1
    kbrK5cXlHa3No5DmzE>
X-ME-Received: <xmr:bhw2Z5qUpqmhfK8eipeEXvcrj3j8_fLKU9j6SsPFY_w1t2t-PkcAuV5JVhJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddvgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhr
    ohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrd
    hnvghtqeenucggtffrrghtthgvrhhnpeegfeefudehueeggeevheffudejgefgkefgffeu
    feeljeduiefffefgueeuleegudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhrfh
    gtqdgvughithhorhdrohhrghdpghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrd
    hnvghtpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshguse
    hquhgvrghshihsnhgrihhlrdhnvghtpdhrtghpthhtohepvhhfvgguohhrvghnkhhosehn
    ohhvvghkrdhruhdprhgtphhtthhopehfkhhrvghniigvlhesrhgvughhrghtrdgtohhmpd
    hrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhhnihih
    uhesrghmrgiiohhnrdgtohhmpdhrtghpthhtoheprghpohhorhhvkhhosegrmhgriihonh
    drtghomhdprhgtphhtthhopegsohhrihhsphesnhhvihguihgrrdgtohhmpdhrtghpthht
    ohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:bhw2Z7kNS7Tx3STyailer0jc69pQMTu4nZ0ti9NlDAnl4qI1vxPC2g>
    <xmx:bhw2Zx3SGIN1EqmLuzoOhVd1Y2hpYYKHWlDBwg-kZiPzU3HPVZ3QVg>
    <xmx:bhw2Z6sg-ne4FqgJStqvotiEKfFSNYEUezsJdMeuYDt9Y4S8eUMInQ>
    <xmx:bhw2Z1UcG6n9r7Us_B7Vsk8_bztmmtkeE9dz_GEZ0rEMBF6je5AcQw>
    <xmx:bxw2Zyu01ZaK8SM5BzM2geGxMJE9UQPIZJjrRZ9tOM7n-WC-TYgzdU8P>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 10:51:09 -0500 (EST)
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
Subject: [PATCH net-next v4 0/6] tls: implement key updates for TLS1.3
Date: Thu, 14 Nov 2024 16:50:47 +0100
Message-ID: <cover.1731597571.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for receiving KeyUpdate messages (RFC 8446, 4.6.3
[1]). A sender transmits a KeyUpdate message and then changes its TX
key. The receiver should react by updating its RX key before
processing the next message.

This patchset implements key updates by:
 1. pausing decryption when a KeyUpdate message is received, to avoid
    attempting to use the old key to decrypt a record encrypted with
    the new key
 2. returning -EKEYEXPIRED to syscalls that cannot receive the
    KeyUpdate message, until the rekey has been performed by userspace
 3. passing the KeyUpdate message to userspace as a control message
 4. allowing updates of the crypto_info via the TLS_TX/TLS_RX
    setsockopts

This API has been tested with gnutls to make sure that it allows
userspace libraries to implement key updates [2]. Thanks to Frantisek
Krenzelok <fkrenzel@redhat.com> for providing the implementation in
gnutls and testing the kernel patches.


=======================================================================
Discussions around v2 of this patchset focused on how HW offload would
interact with rekey.

RX
 - The existing SW path will handle all records between the KeyUpdate
   message signaling the change of key and the new key becoming known
   to the kernel -- those will be queued encrypted, and decrypted in
   SW as they are read by userspace (once the key is provided, ie same
   as this patchset)
 - Call ->tls_dev_del + ->tls_dev_add immediately during
   setsockopt(TLS_RX)

TX
 - After setsockopt(TLS_TX), switch to the existing SW path (not the
   current device_fallback) until we're able to re-enable HW offload
   - tls_device_sendmsg will call into tls_sw_sendmsg under lock_sock
     to avoid changing socket ops during the rekey while another
     thread might be waiting on the lock
 - We only re-enable HW offload (call ->tls_dev_add to install the new
   key in HW) once all records sent with the old key have been
   ACKed. At this point, all unacked records are SW-encrypted with the
   new key, and the old key is unused by both HW and retransmissions.
   - If there are no unacked records when userspace does
     setsockopt(TLS_TX), we can (try to) install the new key in HW
     immediately.
   - If yet another key has been provided via setsockopt(TLS_TX), we
     don't install intermediate keys, only the latest.
   - TCP notifies ktls of ACKs via the icsk_clean_acked callback. In
     case of a rekey, tls_icsk_clean_acked will record when all data
     sent with the most recent past key has been sent. The next call
     to sendmsg will install the new key in HW.
   - We close and push the current SW record before reenabling
     offload.

If ->tls_dev_add fails to install the new key in HW, we stay in SW
mode. We can add a counter to keep track of this.


In addition:

Because we can't change socket ops during a rekey, we'll also have to
modify do_tls_setsockopt_conf to check ctx->tx_conf and only call
either tls_set_device_offload or tls_set_sw_offload. RX already uses
the same ops for both TLS_HW and TLS_SW, so we could switch between HW
and SW mode on rekey.

An alternative would be to have a common sendmsg which locks
the socket and then calls the correct implementation. We'll need that
anyway for the offload under rekey case, so that would only add a test
to the SW path's ops (compared to the current code). That should allow
us to simplify build_protos a bit, but might have a performance
impact - we'll need to check it if we want to go that route.
=======================================================================

Changes since v3:
 - rebase on top of net-next
 - rework tls_check_pending_rekey according to Jakub's feedback
 - add statistics for rekey: {RX,TX}REKEY{OK,ERROR}
 - some coding style clean ups

Link: https://lore.kernel.org/netdev/cover.1691584074.git.sd@queasysnail.net/ [v3]
Link: https://lore.kernel.org/netdev/cover.1676052788.git.sd@queasysnail.net/ [v2]
Link: https://lore.kernel.org/netdev/cover.1673952268.git.sd@queasysnail.net/ [v1]

Link: https://www.rfc-editor.org/rfc/rfc8446#section-4.6.3 [1]
Link: https://gitlab.com/gnutls/gnutls/-/merge_requests/1625 [2]

Sabrina Dubroca (6):
  tls: block decryption when a rekey is pending
  tls: implement rekey for TLS1.3
  tls: add counters for rekey
  docs: tls: document TLS1.3 key updates
  selftests: tls: add key_generation argument to tls_crypto_info_init
  selftests: tls: add rekey tests

 Documentation/networking/tls.rst  |  31 ++
 include/net/tls.h                 |   3 +
 include/uapi/linux/snmp.h         |   4 +
 net/tls/tls.h                     |   3 +-
 net/tls/tls_device.c              |   2 +-
 net/tls/tls_main.c                |  71 ++++-
 net/tls/tls_proc.c                |   4 +
 net/tls/tls_sw.c                  | 138 +++++++--
 tools/testing/selftests/net/tls.c | 480 +++++++++++++++++++++++++++++-
 9 files changed, 676 insertions(+), 60 deletions(-)

-- 
2.47.0


