Return-Path: <linux-kselftest+bounces-16583-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C897B96302C
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 20:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC7D1C21535
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 18:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B81A1AB51F;
	Wed, 28 Aug 2024 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DcVTAye4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D6E1AB502
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2024 18:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724870295; cv=none; b=ZcQ4PXveQRl6/CYyusX5yXPsgQOAvJB276AfsY1fkXA7zZGgZCLRtdjL27aYyEOa/TEYNkbHJ/0uifvpyszbFFauCp6dNsV/QRc35HMnaaquYJKuAQHmTTm+lJ3ybSZ6PGD+tLeF/rVED/BKNGG4eC9Msd5j/UL3wWVL44/fp1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724870295; c=relaxed/simple;
	bh=3afymSyClK1yApRj415S4tmjPqKL+pAEHtyyGVn6OlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZvTy0OLyelUomtA8i0DHGAiUMe+JXsC997y6YlkofPFXLRY7ifDQ9QOIBKii0pfnYfPZ9OSbDtFSuqjuP4ej+sLF1Oe9VBsNkvN77ZtwMHp7r3ErZR2cSzHlmJkV4fC11Pt0scicQ3mZPRfNj+Gr9Dg9tjIP2kn620RMa2qHrC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DcVTAye4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724870292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZeELRms0PnXtKRg3/5yoBnxroEiHUMeD7S1PS0A2MJg=;
	b=DcVTAye48P0NZyjnwSCHG/WwI1mlzNXeGQ7uDo+bEayq07/PfFMFeKeOIqJUjSxWaJ2tdb
	NWmGS52PdZf5QFNCJ/hL9c5LOlxRtoqcgk9UaKawBdSEvFk69EaOm5UVV6FFFy1lfq3lyn
	cqLFI4Rjoa4Q6nSgpgybiULv62EHWnU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-4n9xOS8CPq6RlB8g-n9ZTA-1; Wed,
 28 Aug 2024 14:38:06 -0400
X-MC-Unique: 4n9xOS8CPq6RlB8g-n9ZTA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A718B1955BED;
	Wed, 28 Aug 2024 18:38:04 +0000 (UTC)
Received: from jmaloy-thinkpadp16vgen1.rmtcaqc.csb (unknown [10.22.8.17])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 21AC81956052;
	Wed, 28 Aug 2024 18:38:00 +0000 (UTC)
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
Subject: [net-next, v3 2/2] selftests: add selftest for tcp SO_PEEK_OFF support
Date: Wed, 28 Aug 2024 14:37:52 -0400
Message-ID: <20240828183752.660267-3-jmaloy@redhat.com>
In-Reply-To: <20240828183752.660267-1-jmaloy@redhat.com>
References: <20240828183752.660267-1-jmaloy@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Jon Maloy <jmaloy@redhat.com>

We add a selftest to check that the new feature added in
commit 05ea491641d3 ("tcp: add support for SO_PEEK_OFF socket option")
works correctly.

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Tested-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Jon Maloy <jmaloy@redhat.com>

---
v2: Made correction based on Jason Xing's comment.
v3: Removed redundant whitespace at end of file.
    Based on comment from Jakub Kicinski.
---
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/tcp_so_peek_off.c | 183 ++++++++++++++++++
 2 files changed, 184 insertions(+)
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
index 000000000000..df8a39d9d3c3
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_so_peek_off.c
@@ -0,0 +1,183 @@
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
+		ksft_perror("Temporary socket creation failed\n");
+		goto out;
+	}
+	if (bind(s[0], &a.sa, sizeof(a)) < 0) {
+		ksft_perror("Temporary socket bind() failed\n");
+		goto out;
+	}
+	if (getsockname(s[0], &a.sa, &((socklen_t) { sizeof(a) })) < 0) {
+		ksft_perror("Temporary socket getsockname() failed\n");
+		goto out;
+	}
+	if (listen(s[0], 0) < 0) {
+		ksft_perror("Temporary socket listen() failed\n");
+		goto out;
+	}
+	if (connect(s[1], &a.sa, sizeof(a)) >= 0 || errno != EINPROGRESS) {
+		ksft_perror("Temporary socket connect() failed\n");
+		goto out;
+	}
+	recv_sock = accept(s[0], NULL, NULL);
+	if (recv_sock <= 0) {
+		ksft_perror("Temporary socket accept() failed\n");
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
+	if (recv_sock >= 0)
+		close(recv_sock);
+	if (s[1] >= 0)
+		close(s[1]);
+	if (s[0] >= 0)
+		close(s[0]);
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
-- 
2.45.2


