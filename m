Return-Path: <linux-kselftest+bounces-29407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D2CA68377
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 04:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9EE17DA15
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 03:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9BF20DD65;
	Wed, 19 Mar 2025 03:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XT3FLa6V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5D142A80;
	Wed, 19 Mar 2025 03:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742354052; cv=none; b=fiYJ7w4b2zlrpopcNqbJgQ5MMOG7QFBBHgE/yb+6H4JzBc/4wnUrtJ0fw30yDukLFEME2x2cYwQiTyyu8VtukSo3jgRD8JQ285hO6MKOE5F1LKHhThtq7kwWgV86cggk9LWd/kKJsjBkAmLC7qDl4AwmOCPFsJxi+ahorLvY2Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742354052; c=relaxed/simple;
	bh=yM4mhVvJmZfLeISwx/iN5lE/1L/nC+VHGrVR2s+Sbz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gZlAMTvJCS9ue+j6uq64mZOyo4nINm6ow5rqNdptZRMXoWXHu2prlUIMUx0jkrbCuxf6bHkoGfJQi9pRIiqo464TTNkuttWez6AcY/GYZKxCxEyyLK4Q2ZRTmNLkCbNWWwgbqmtxmgXWKpywixfCSBS5vlmTmUaBEwS/tEmIkRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XT3FLa6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3C47C4CEE3;
	Wed, 19 Mar 2025 03:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742354052;
	bh=yM4mhVvJmZfLeISwx/iN5lE/1L/nC+VHGrVR2s+Sbz4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XT3FLa6VCWKyh5tVufhiPLl5dZ6VT8KqeEIBL4AmFMixEHOOYmUoDMcrHaf/hKBLs
	 CIPbVnxSSnj8F8TVe7oj5pRSyD7gKXlToYekQruLJk1GeEDTIyNZsardLNnASeaK+h
	 8yNYq23pwWdNG6LLxFwA/pCHwAz+ovso2yNfpdHyOyE55QmtZ0ifkki066/kr9/BmH
	 PdSHr6spa99FnZxsC0tj/W73R6yWF23E+tQa4WmVJ00dqkXvqz0uEPoR7qRVLk5A5V
	 tt8ZxTiS58+/I4/YCCr5Le8SzF0mshOiXCTDF3F7A3M2rsgOz3U2z7bAnN4E1XPgxh
	 TRNIB4+RApjZQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AA4C35FF3;
	Wed, 19 Mar 2025 03:14:11 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Wed, 19 Mar 2025 03:13:34 +0000
Subject: [PATCH net-next v2 1/7] selftests/net: Print TCP flags in more
 common format
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-tcp-ao-selftests-polling-v2-1-da48040153d1@gmail.com>
References: <20250319-tcp-ao-selftests-polling-v2-0-da48040153d1@gmail.com>
In-Reply-To: <20250319-tcp-ao-selftests-polling-v2-0-da48040153d1@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742354050; l=1922;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=iOlW43ng3yBwP5kn3YXXAavX+5ElU/Vcbzg1cmgHkUw=;
 b=/+hRgGy1a3TxFF9aNzAm4ditnNMPN89DK7HhC1C7dEgHmLJJI8E/fCYVraGO8WaqbEoDS6YGb
 6D0neO2WTVvCNtEi/J4kAvyqCW1WAmXgg2Ll7ANTW/EkDUPjy7jDBiQ
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



