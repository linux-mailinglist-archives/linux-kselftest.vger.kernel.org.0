Return-Path: <linux-kselftest+bounces-16187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7332B95D868
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 23:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF721F23D82
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 21:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3413A1C825A;
	Fri, 23 Aug 2024 21:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UaKMTh3Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCC780C02
	for <linux-kselftest@vger.kernel.org>; Fri, 23 Aug 2024 21:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724447960; cv=none; b=A1XicdRGAxnOk0NmIIi8fyuT4xB3mF62ZwaRFKrFCoigK9t1sDek3Zs4hgiSMBvrwQ4j8hYjiHF7lRnKr4gkIKAEwH4COky7mYkV5boiQ3rInmPX2EXjRjQLVP2yz09GANnvIPQZcYqqmnHemz01HtRw2qA8PaWBhKMLjKYl5ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724447960; c=relaxed/simple;
	bh=z9DoF77M59dkcj7/Nj4B7xczX1M2tpV+qCbbx0rXcbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbyiWlT5ppapGYByIYzzVY7gfIqbY/eI2bGJyWwQVa7mb24+inG1esbBA+LHI/CxvBznC/0mS6uuEJGwWRJF07ehzLLE9ec/5ysWM2NCVXl5EcAipIMR91hpmqrEfktmnYcRWXBSSXmt4VvTreRalsf6IwqZrSg0vgjPIvJB2BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UaKMTh3Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724447957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=85P6i54SBeZdIS1BQpJqApegrd3JJod+srvcKYi8t0E=;
	b=UaKMTh3ZMuqlmSOtRqjC9ZLobIcOPPdrp8+CY1gZ/1zv7Db0cB4/BkpuSvrcn8gNQuVJoR
	LeMQeqyFeReDlwVjp+UXVupRimcKq56g5e/RJChcZjp48BSniANNBDJN/ho/RtlIevVBH8
	LKuzmCTm2TG598sySC3HI/oUcYr4/wU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-dkZpodcmNRmOK5PgT_ZrHQ-1; Fri,
 23 Aug 2024 17:19:16 -0400
X-MC-Unique: dkZpodcmNRmOK5PgT_ZrHQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67D4919560AD;
	Fri, 23 Aug 2024 21:19:14 +0000 (UTC)
Received: from jmaloy-thinkpadp16vgen1.rmtcaqc.csb (unknown [10.22.8.17])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4887B300019C;
	Fri, 23 Aug 2024 21:19:11 +0000 (UTC)
From: jmaloy@redhat.com
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	davem@davemloft.net
Cc: kuba@kernel.org,
	passt-dev@passt.top,
	jmaloy@redhat.com,
	sbrivio@redhat.com,
	lvivier@redhat.com,
	dgibson@redhat.com,
	eric.dumazet@gmail.com,
	edumazet@google.com
Subject: [PATCH  2/2] selftests: add selftest for tcp SO_PEEK_OFF support
Date: Fri, 23 Aug 2024 17:19:02 -0400
Message-ID: <20240823211902.143210-3-jmaloy@redhat.com>
In-Reply-To: <20240823211902.143210-1-jmaloy@redhat.com>
References: <20240823211902.143210-1-jmaloy@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Jon Maloy <jmaloy@redhat.com>

We add a selftest to check that the new feature added in
commit 05ea491641d3 ("tcp: add support for SO_PEEK_OFF socket option")
works correctly.

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Tested-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Jon Maloy <jmaloy@redhat.com>
---
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/tcp_so_peek_off.c | 181 ++++++++++++++++++
 2 files changed, 182 insertions(+)
 create mode 100644 tools/testing/selftests/net/tcp_so_peek_off.c

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 8eaffd7a641c..1179e3261bef 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -80,6 +80,7 @@ TEST_PROGS += io_uring_zerocopy_tx.sh
 TEST_GEN_FILES += bind_bhash
 TEST_GEN_PROGS += sk_bind_sendto_listen
 TEST_GEN_PROGS += sk_connect_zero_addr
+TEST_GEN_PROGS += tcp_so_peek_off
 TEST_PROGS += test_ingress_egress_chaining.sh
 TEST_GEN_PROGS += so_incoming_cpu
 TEST_PROGS += sctp_vrf.sh
diff --git a/tools/testing/selftests/net/tcp_so_peek_off.c b/tools/testing/selftests/net/tcp_so_peek_off.c
new file mode 100644
index 000000000000..8379ea02e3d7
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_so_peek_off.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#include "../kselftest.h"
+
+static char *afstr(int af)
+{
+	return af == AF_INET ? "TCP/IPv4" : "TCP/IPv6";
+}
+
+int tcp_peek_offset_probe(sa_family_t af)
+{
+	int optv = 0;
+	int ret = 0;
+	int s;
+
+	s = socket(af, SOCK_STREAM | SOCK_CLOEXEC, IPPROTO_TCP);
+	if (s < 0) {
+		ksft_perror("Temporary TCP socket creation failed");
+	} else {
+		if (!setsockopt(s, SOL_SOCKET, SO_PEEK_OFF, &optv, sizeof(int)))
+			ret = 1;
+		else
+			printf("%s does not support SO_PEEK_OFF\n", afstr(af));
+		close(s);
+	}
+	return ret;
+}
+
+static void tcp_peek_offset_set(int s, int offset)
+{
+	if (setsockopt(s, SOL_SOCKET, SO_PEEK_OFF, &offset, sizeof(offset)))
+		ksft_perror("Failed to set SO_PEEK_OFF value\n");
+}
+
+static int tcp_peek_offset_get(int s)
+{
+	int offset;
+	socklen_t len = sizeof(offset);
+
+	if (getsockopt(s, SOL_SOCKET, SO_PEEK_OFF, &offset, &len))
+		ksft_perror("Failed to get SO_PEEK_OFF value\n");
+	return offset;
+}
+
+static int tcp_peek_offset_test(sa_family_t af)
+{
+	union {
+		struct sockaddr sa;
+		struct sockaddr_in a4;
+		struct sockaddr_in6 a6;
+	} a;
+	int res = 0;
+	int s[2] = {0, 0};
+	int recv_sock = 0;
+	int offset = 0;
+	ssize_t len;
+	char buf;
+
+	memset(&a, 0, sizeof(a));
+	a.sa.sa_family = af;
+
+	s[0] = socket(af, SOCK_STREAM, IPPROTO_TCP);
+	s[1] = socket(af, SOCK_STREAM | SOCK_NONBLOCK, IPPROTO_TCP);
+
+	if (s[0] < 0 || s[1] < 0) {
+		ksft_perror("Temporary probe socket creation failed\n");
+		goto out;
+	}
+	if (bind(s[0], &a.sa, sizeof(a)) < 0) {
+		ksft_perror("Temporary probe socket bind() failed\n");
+		goto out;
+	}
+	if (getsockname(s[0], &a.sa, &((socklen_t) { sizeof(a) })) < 0) {
+		ksft_perror("Temporary probe socket getsockname() failed\n");
+		goto out;
+	}
+	if (listen(s[0], 0) < 0) {
+		ksft_perror("Temporary probe socket listen() failed\n");
+		goto out;
+	}
+	if (connect(s[1], &a.sa, sizeof(a)) >= 0 || errno != EINPROGRESS) {
+		ksft_perror("Temporary probe socket connect() failed\n");
+		goto out;
+	}
+	recv_sock = accept(s[0], NULL, NULL);
+	if (recv_sock <= 0) {
+		ksft_perror("Temporary probe socket accept() failed\n");
+		goto out;
+	}
+
+	/* Some basic tests of getting/setting offset */
+	offset = tcp_peek_offset_get(recv_sock);
+	if (offset != -1) {
+		ksft_perror("Initial value of socket offset not -1\n");
+		goto out;
+	}
+	tcp_peek_offset_set(recv_sock, 0);
+	offset = tcp_peek_offset_get(recv_sock);
+	if (offset != 0) {
+		ksft_perror("Failed to set socket offset to 0\n");
+		goto out;
+	}
+
+	/* Transfer a message */
+	if (send(s[1], (char *)("ab"), 2, 0) <= 0 || errno != EINPROGRESS) {
+		ksft_perror("Temporary probe socket send() failed\n");
+		goto out;
+	}
+	/* Read first byte */
+	len = recv(recv_sock, &buf, 1, MSG_PEEK);
+	if (len != 1 || buf != 'a') {
+		ksft_perror("Failed to read first byte of message\n");
+		goto out;
+	}
+	offset = tcp_peek_offset_get(recv_sock);
+	if (offset != 1) {
+		ksft_perror("Offset not forwarded correctly at first byte\n");
+		goto out;
+	}
+	/* Try to read beyond last byte */
+	len = recv(recv_sock, &buf, 2, MSG_PEEK);
+	if (len != 1 || buf != 'b') {
+		ksft_perror("Failed to read last byte of message\n");
+		goto out;
+	}
+	offset = tcp_peek_offset_get(recv_sock);
+	if (offset != 2) {
+		ksft_perror("Offset not forwarded correctly at last byte\n");
+		goto out;
+	}
+	/* Flush message */
+	len = recv(recv_sock, NULL, 2, MSG_TRUNC);
+	if (len != 2) {
+		ksft_perror("Failed to flush message\n");
+		goto out;
+	}
+	offset = tcp_peek_offset_get(recv_sock);
+	if (offset != 0) {
+		ksft_perror("Offset not reverted correctly after flush\n");
+		goto out;
+	}
+
+	printf("%s with MSG_PEEK_OFF works correctly\n", afstr(af));
+	res = 1;
+out:
+	close(recv_sock);
+	close(s[1]);
+	close(s[0]);
+	return res;
+}
+
+int main(void)
+{
+	int res4, res6;
+
+	res4 = tcp_peek_offset_probe(AF_INET);
+	res6 = tcp_peek_offset_probe(AF_INET6);
+
+	if (!res4 && !res6)
+		return KSFT_SKIP;
+
+	if (res4)
+		res4 = tcp_peek_offset_test(AF_INET);
+
+	if (res6)
+		res6 = tcp_peek_offset_test(AF_INET6);
+
+	if (!res4 || !res6)
+		return KSFT_FAIL;
+
+	return KSFT_PASS;
+}
+
-- 
2.45.2


