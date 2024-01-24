Return-Path: <linux-kselftest+bounces-3492-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5C083B403
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 22:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2501F2248D
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 21:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6054F135A42;
	Wed, 24 Jan 2024 21:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMOYd2fz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF121353E7
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 21:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706132080; cv=none; b=nTMJUGpty6OZFYznaTfW/QMiPcocCPoko2ULDvAm8YUt1Vp13A/TwcVEkg4ih/dHQwbv6K8kz3ZSQJmpOhoA8H3ZfLZxFKZTrIbW021vYe1ewE6h/bHXgnSLWu+ruKzmxnohBUCphLhzVGo/ZwkRt46/6Wxem1JQTlJXYBqMVKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706132080; c=relaxed/simple;
	bh=oA88pp4NvhUy2SkvtDXnJSuxtWBJfuTOzMnQxsOsNOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QiVFCHGpDpOGudS9XJKxCaOOtfUJwjbllbMu/V9am2LiW4mE+rQnPxgiZWtgGRE7WlUSGl9NaY39k7d6kecZvcrwQoNNjSJxLgB01OgSZBjbVzO0IxkRtcFa9kIPzkBCUO6wS8vxrMo+A8N/JeEF+BFax9SLOEZ/dgStT5pizNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RMOYd2fz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706132077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dA3qPaH+HoAYKj4lrFSopDZNcGElmJKrtZ/ka94a2aE=;
	b=RMOYd2fzzppsnANRWYXuJckoRJ1nlk3CtEdJiaeP1rGsjIAeRKcdCVTM1uychDoUUDs++2
	P5qQSHxabiVm/hq3Za25zqV541dbBILAtDO4u88+tfQlzxpTf+LfIIzaHSXhBetUqXSR+9
	/fmV79JhYjDKoUEDzM24fKoKKEQ6Udo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-qT2JHxJBPP-Z4Q6YwL4vJg-1; Wed,
 24 Jan 2024 16:34:31 -0500
X-MC-Unique: qT2JHxJBPP-Z4Q6YwL4vJg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1E481C0514D;
	Wed, 24 Jan 2024 21:34:30 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.29])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 36FAB2166B32;
	Wed, 24 Jan 2024 21:34:29 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Lucas Karpinski <lkarpins@redhat.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 2/3] selftests: net: included needed helper in the install targets
Date: Wed, 24 Jan 2024 22:33:21 +0100
Message-ID: <076e8758e21ff2061cc9f81640e7858df775f0a9.1706131762.git.pabeni@redhat.com>
In-Reply-To: <cover.1706131762.git.pabeni@redhat.com>
References: <cover.1706131762.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

The blamed commit below introduce a dependency in some net self-tests
towards a newly introduce helper script.

Such script is currently not included into the TEST_PROGS_EXTENDED list
and thus is not installed, causing failure for the relevant tests when
executed from the install dir.

Fix the issue updating the install targets.

Fixes: 3bdd9fd29cb0 ("selftests/net: synchronize udpgro tests' tx and rx connection")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 304d8b852ef0..48c6f93b8149 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -55,6 +55,7 @@ TEST_PROGS += rps_default_mask.sh
 TEST_PROGS += big_tcp.sh
 TEST_PROGS_EXTENDED := in_netns.sh setup_loopback.sh setup_veth.sh
 TEST_PROGS_EXTENDED += toeplitz_client.sh toeplitz.sh lib.sh
+TEST_PROGS_EXTENDED += net_helper.sh
 TEST_GEN_FILES =  socket nettest
 TEST_GEN_FILES += psock_fanout psock_tpacket msg_zerocopy reuseport_addr_any
 TEST_GEN_FILES += tcp_mmap tcp_inq psock_snd txring_overwrite
-- 
2.43.0


