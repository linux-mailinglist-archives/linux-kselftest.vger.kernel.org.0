Return-Path: <linux-kselftest+bounces-28803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEB2A5D8EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 10:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75F3189C477
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 09:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50717239082;
	Wed, 12 Mar 2025 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Smpk0arl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FF9238D34;
	Wed, 12 Mar 2025 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741770688; cv=none; b=kbo0z8P4my8oK+r1lyh/Onixs28kIkPtDRfTsQhfBMBtz5evI0tzdc+4Ee830zU06lGDdDQXStoOZsGQNlqLv7Daol35Zns7uwQF0JFu6Je1G2hyjKQ2M6PZkaGzJQEPxWyf9buEGPz0+3nbcPegr1yf1x2BX4f/6uW4TjXOaec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741770688; c=relaxed/simple;
	bh=yM4mhVvJmZfLeISwx/iN5lE/1L/nC+VHGrVR2s+Sbz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k3SllNrbcPfaUnsM2bvA5SdMMTQ3BQKtOC4+Pc25A9PjV/Q1gsLj8tWl0Mq4Hpf122MvvnXXAAvqv0pVXnUu2zWUpxqJ4kEbITMgfYd8OfZwqHqN6UmNTUX8WtjsAJMjQ+wnNveMGk8ZgB6KpHygV3EvlQa8seCFb5epGCpgsk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Smpk0arl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F742C4CEED;
	Wed, 12 Mar 2025 09:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741770687;
	bh=yM4mhVvJmZfLeISwx/iN5lE/1L/nC+VHGrVR2s+Sbz4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Smpk0arlXQaGP8VufJdHYsVu1AgM9GIqemw/cA/R1uOVE99SXZMQfmj/sqfPec2g7
	 yo3CuyB5au2/ouduOTvVnmyXbi1BB7QLlUoKLdNm2b1RWXq88x/hqtWrNj6737aHkr
	 8KK8lMgIZz8XI2OD5g2zJ8T0Nb4zHz+Agk/1GXQ0D/nGbWYP1B/YnqiSdKpZ75CVyT
	 rHEX17D4Bv9WnqL9KYI3KeOtN2SkB3by0DiUSRi5KzNqBeUfJNBp4b1d0ROhFGPf/a
	 8VL59E31NOw9jSrvHPLH5RsoXuB0xvP+vcB6iT5jSxbIMEqfDKyHgoBDRfJRV4JL1W
	 fZq2X5RLDbAHA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80050C2BA1B;
	Wed, 12 Mar 2025 09:11:27 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Wed, 12 Mar 2025 09:10:55 +0000
Subject: [PATCH net 1/7] selftests/net: Print TCP flags in more common
 format
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-tcp-ao-selftests-polling-v1-1-72a642b855d5@gmail.com>
References: <20250312-tcp-ao-selftests-polling-v1-0-72a642b855d5@gmail.com>
In-Reply-To: <20250312-tcp-ao-selftests-polling-v1-0-72a642b855d5@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741770685; l=1922;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=iOlW43ng3yBwP5kn3YXXAavX+5ElU/Vcbzg1cmgHkUw=;
 b=FRPYyXOZbPmuvlev/hXq5yK0EP/muv/GXE5XFTI7TWoxOGPHCPluY1ZFLWSzx1ENxaQnfI27T
 36POI+xOkYeAJtRkMfYqimUBakKGcb4MHTQxtZ/Qx6eYiOLpB6zuVrA
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

Before:
># 13145[lib/ftrace-tcp.c:427] trace event filter tcp_ao_key_not_found [2001:db8:1::1:-1 => 2001:db8:254::1:7010, L3index 0, flags: !FS!R!P!., keyid: 100, rnext: 100, maclen: -1, sne: -1] = 1

After:
># 13487[lib/ftrace-tcp.c:427] trace event filter tcp_ao_key_not_found [2001:db8:1::1:-1 => 2001:db8:254::1:7010, L3index 0, flags: S, keyid: 100, rnext: 100, maclen: -1, sne: -1] = 1

For the history, I think the initial format was to emphasize the absence
of flags as well as their presence (!R meant no RST flag). But looking
again, it's just unreadable and hard to understand.
Make it the standard/expected one.

Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 tools/testing/selftests/net/tcp_ao/lib/ftrace-tcp.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/lib/ftrace-tcp.c b/tools/testing/selftests/net/tcp_ao/lib/ftrace-tcp.c
index 24380c68fec6b7613c363cdee68d13293e593aeb..27403f875054706718256e0007a4db77f82e60c8 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/ftrace-tcp.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/ftrace-tcp.c
@@ -427,11 +427,8 @@ static void dump_trace_event(struct expected_trace_point *e)
 	test_print("trace event filter %s [%s:%d => %s:%d, L3index %d, flags: %s%s%s%s%s, keyid: %d, rnext: %d, maclen: %d, sne: %d] = %zu",
 		   trace_event_names[e->type],
 		   src, e->src_port, dst, e->dst_port, e->L3index,
-		   (e->fin > 0) ? "F" : (e->fin == 0) ? "!F" : "",
-		   (e->syn > 0) ? "S" : (e->syn == 0) ? "!S" : "",
-		   (e->rst > 0) ? "R" : (e->rst == 0) ? "!R" : "",
-		   (e->psh > 0) ? "P" : (e->psh == 0) ? "!P" : "",
-		   (e->ack > 0) ? "." : (e->ack == 0) ? "!." : "",
+		   e->fin ? "F" : "", e->syn ? "S" : "", e->rst ? "R" : "",
+		   e->psh ? "P" : "", e->ack ? "." : "",
 		   e->keyid, e->rnext, e->maclen, e->sne, e->matched);
 }
 

-- 
2.42.2



