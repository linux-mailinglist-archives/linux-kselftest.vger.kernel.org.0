Return-Path: <linux-kselftest+bounces-23259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887B49EECE1
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 16:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4DD316412C
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 15:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709D6217F26;
	Thu, 12 Dec 2024 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="JRwSXgm8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BZwizUGW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785272135C1;
	Thu, 12 Dec 2024 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017813; cv=none; b=f+GvGAsjlnUcVKNztR23QiJbI73XdqubZGc2gGrnh2LT/htftS8cpU+qrgaG9XUFcCReJJhaZQ5mKTRdTA4mPoL3XmehXknH8c/TIeTx2Q1i1qQ2kjBkfumKVP4G92vVKl93qzjTF3mSnpKFMTKMFsX9bYJt6YGbV90QpaHHLj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017813; c=relaxed/simple;
	bh=DLLLbvi69BQMicdx2BH6I8SwkfRaZHD371VuFz38cUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QbrfgNJWFwzQ+voFJTRDhNQoFS03IcJB10Qh6ExW4F9HYrfCk2vvmLeaBGzZakRuLLWCA6WeKbr51+XLPxQJZWwe+4kLZ6JkUFHeTEPOgb6zjxeZHw8Pwc4mZ00yzuv4ZjzhQ/3XyRuFN5IgWAoDWfTfOM62EvyBAkLmiLiwxTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=JRwSXgm8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BZwizUGW; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D144811400CA;
	Thu, 12 Dec 2024 10:36:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 12 Dec 2024 10:36:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1734017807; x=1734104207; bh=0UIpBo4G/A
	rQh5vm5xHd4YRs9JES7SmgkYyHOoNV6/Q=; b=JRwSXgm8EEJWrepnPHzqvNZc4d
	Ru1QWxaXyQHG+4k+NnTLCf7fL/uJggge/an/kIvAZfMxge4wZPnn0NjZgUluaYh+
	bSoMkYRb67SXlDlcEhZQ5KxJDmye/TedXuiCeZUGJtdqGeQuWTHXewGK+wNPsNqE
	YnJP99aYC7pjhhNxIVf/vnqExr1ewSQbMHv2w9KXPkrPjMBjLkWtRhC4SYf7ozcA
	T245pYgxPzW0PjQmJH0/I/dRE5u4XolDtV/nE6pK669kM/dwfL1AWTVpKl134i8K
	lx2PA6i4t97FuQwb8p0V7xjHddF4Cj69B8rbp4Dkg9vEvap+FTj57l3j6Fpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734017807; x=1734104207; bh=0UIpBo4G/ArQh5vm5xHd4YRs9JES7SmgkYy
	HOoNV6/Q=; b=BZwizUGWh6agRw0jFiD3FVPZWkkH2nDRm0lT67R5d4lK4lMR9AZ
	oJGS8JG2NMya81lMkqKLKAIgQj3J3Q+LDOmdc+LD7T396qLYQpFgzlyUpElhMESI
	qVDfjsTw6mNUxQhSP3zTTKnJ6cyC5uFrqiF20n2KfiA+kBFzoxNgCWxeTbz3kf7u
	qu4/RwPqMOpzvHzs2C6+5jjLA2uo/2KVt3GpZ7w4l4KYpMvo449jBPl1siws2WQZ
	EiEDdpNMC2Gz4qpQ+mwwE3x9PYryqTqin7zuk6sg3/+adh2jVr8ekpAgtB0lDkGj
	rffo0xboF+HzouYxkoxK1DbqZ/jS1krQXSg==
X-ME-Sender: <xms:DgNbZzpxXYrFnm35g6u-wAKnlKvlyUfljoVgoJOKt3tXS96lDL5eZQ>
    <xme:DgNbZ9pt8dKn3f6ycilX_f_0on-iQP9psWOfHN8ezHHiIt9bXy4qqOUumqukYZzgy
    LmBvbES3LM4_RcNmjA>
X-ME-Received: <xmr:DgNbZwP61QGiZ8fsCED4vPZASbioWdbktcmQjRaPF1lMzfOX04WFqeuB2a6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeehgdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhr
    ohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrd
    hnvghtqeenucggtffrrghtthgvrhhnpeegfeefudehueeggeevheffudejgefgkefgffeu
    feeljeduiefffefgueeuleegudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhrfh
    gtqdgvughithhorhdrohhrghdpghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrd
    hnvghtpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshguse
    hquhgvrghshihsnhgrihhlrdhnvghtpdhrtghpthhtohepvhhfvgguohhrvghnkhhosehn
    ohhvvghkrdhruhdprhgtphhtthhopehfkhhrvghniigvlhesrhgvughhrghtrdgtohhmpd
    hrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhhnihih
    uhesrghmrgiiohhnrdgtohhmpdhrtghpthhtoheprghpohhorhhvkhhosegrmhgriihonh
    drtghomhdprhgtphhtthhopegsohhrihhsphesnhhvihguihgrrdgtohhmpdhrtghpthht
    ohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:DgNbZ26RYWCUNoNm4iL1XbZBMS9PXGNA1dVRxi8K6pD5SECEqky7pw>
    <xmx:DgNbZy6E32OnFCwwNzK0f0UtwIu9wFQN-cpB9dLwPmEeJX0_dqeIDg>
    <xmx:DgNbZ-g3O5aSFXTL_JrG9Z23sZvHZpNMkm52bT-wr94QLjeGdbFUCw>
    <xmx:DgNbZ07P7ld0xPN2l0MSWavsZEVJR48FRk5_7vUpmlFPZXA0l7CqJg>
    <xmx:DwNbZ1qrpYN2qHwYqQQVI09PsfhyTf3cy8kUmb4bhuFSLCXn0krFKCs2>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 10:36:45 -0500 (EST)
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
Subject: [PATCH net-next v5 0/6] tls: implement key updates for TLS1.3
Date: Thu, 12 Dec 2024 16:36:03 +0100
Message-ID: <cover.1734013874.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.47.1
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

Changes since v4:
 - add counter for received KeyUpdate messages
 - improve wording in the documentation
 - improve handling of bogus messages when looking for KeyUpdate's
 - some coding style clean ups

Changes since v3:
 - rebase on top of net-next
 - rework tls_check_pending_rekey according to Jakub's feedback
 - add statistics for rekey: {RX,TX}REKEY{OK,ERROR}
 - some coding style clean ups

Link: https://lore.kernel.org/netdev/cover.1731597571.git.sd@queasysnail.net/ [v4]
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

 Documentation/networking/tls.rst  |  36 +++
 include/net/tls.h                 |   3 +
 include/uapi/linux/snmp.h         |   5 +
 net/tls/tls.h                     |   3 +-
 net/tls/tls_device.c              |   2 +-
 net/tls/tls_main.c                |  71 ++++-
 net/tls/tls_proc.c                |   5 +
 net/tls/tls_sw.c                  | 140 ++++++---
 tools/testing/selftests/net/tls.c | 478 +++++++++++++++++++++++++++++-
 9 files changed, 682 insertions(+), 61 deletions(-)

-- 
2.47.1


