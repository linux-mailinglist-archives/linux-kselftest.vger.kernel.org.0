Return-Path: <linux-kselftest+bounces-1991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FEE81400A
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 03:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23311C221A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 02:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DC6DF6D;
	Fri, 15 Dec 2023 02:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="iiyB+OOo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4157E171DB
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Dec 2023 02:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c2db2ee28so2529945e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 18:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1702607858; x=1703212658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSHMuEM4mkXgiV/o3pzgHKa8VeGG/uOU+Zc5RrKY7ps=;
        b=iiyB+OOoRTHaz2eL7AuDioVYqt3Wt+NQSDo6V0UJWa1ZhrxGT2LkHJCu5NoX5eR/TM
         UGlwPERqdkDa9eqgx09sKF7jXDO4lNm6B7qBD1NZi39RzFdSSV/cg0dHCBe+59DleYw/
         fweaOFQJ0KRIP2lDriTWijwoaVPx3Nakgp5LfkvsQHRGYNPhF/1timXij7rZWtaZyEXr
         QiBVdbIj+cvpIKeyL3uR75Bm+T87HpPxuGNN17Z0Yx617zfVKAUyuR6uVKxQZH0FOg20
         Ev+osKiohivneUd14c4nfxf6ZMgLRipFqCzBXz3fH7i8W6bmNxChrzJM2C1B4Q/LvyBg
         X8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702607858; x=1703212658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSHMuEM4mkXgiV/o3pzgHKa8VeGG/uOU+Zc5RrKY7ps=;
        b=ni1G0WC9Ut1tzkaSsegjvrATGdB6nm+Hl6hMNtkdm5WrJYvGt8KvTmXpJmS3EkXW+f
         CIDPKflzgy14q306ipAE4vDl2BSjVxuLZZYrV0j+6dlBHIO9dCzfZE7/PfbREFGIAdSD
         pFfAa/oJoUhqqcedoWbBrT6PagSEHbd8ThaDTnLje4qOppeWSt9LwpH6Sq41YTn3pjOo
         odaaIGExlpJgfghb6MUHFd0ll2AAMnjm9swdaGMTCMbWy9OMGmPHEVhaLjt6UBHUaTrg
         lCvsCqhy8pBE/Dn3LJ3VYuls9SwTT/J3z7jCJApUpAjPgQr7fdPAkE4kA/sri/6qrqbd
         Ea3A==
X-Gm-Message-State: AOJu0YyqLbBp/86Thtckb+k+VvfWPd4AbwGEXAkfudA7Rt7vIJ4ZggTE
	HlWtgoDtk8gRxdB4EB8l5wyYJg==
X-Google-Smtp-Source: AGHT+IHyev3e7YUqLnPZePu4qOKEG6CqzHxm6egjWFOGWcLmhSvllM5uR36kTxutAAAFPBGHqLgIGw==
X-Received: by 2002:a05:600c:4d0d:b0:40c:3555:e233 with SMTP id u13-20020a05600c4d0d00b0040c3555e233mr5747650wmp.69.1702607858645;
        Thu, 14 Dec 2023 18:37:38 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id fc17-20020a05600c525100b0040c42681fcesm20096363wmb.15.2023.12.14.18.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 18:37:38 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Dmitry Safonov <dima@arista.com>,
	Salam Noureddine <noureddine@arista.com>,
	Bob Gilligan <gilligan@arista.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [PATCH 11/12] selftests/net: Add TCP-AO selfconnect/simultaneous connect test
Date: Fri, 15 Dec 2023 02:36:25 +0000
Message-ID: <20231215-tcp-ao-selftests-v1-11-f6c08180b985@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215-tcp-ao-selftests-v1-0-f6c08180b985@arista.com>
References: <20231215-tcp-ao-selftests-v1-0-f6c08180b985@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702607833; l=8008; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=+tWgmGWacvQuSpFv6ELIBYa/m0joOM6XsOHGZFm+/F0=; b=db1PWVjFm/G/6sJvTxRyKwxhWIW0IIX0712kQsGH3HYz4FbpKCEq01Lm2CHYKPb0rR/3J9gY5 mNibxITY5hEBjaG9dMXndYxtthXCAKqRQaswUmVEjQgwxYACpM8gF3b
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

Check that a rare functionality of TCP named self-connect works with
TCP-AO. This "under the cover" also checks TCP simultaneous connect
(TCP_SYN_RECV socket state), which would be harder to check other ways.

In order to verify that it's indeed TCP simultaneous connect, check
the counters TCPChallengeACK and TCPSYNChallenge.

Sample of the output:
> # ./self-connect_ipv6
> 1..4
> # 1738[lib/setup.c:254] rand seed 1696451931
> TAP version 13
> ok 1 self-connect(same keyids): connect TCPAOGood 0 => 24
> ok 2 self-connect(different keyids): connect TCPAOGood 26 => 50
> ok 3 self-connect(restore): connect TCPAOGood 52 => 97
> ok 4 self-connect(restore, different keyids): connect TCPAOGood 99 => 144
> # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/tcp_ao/Makefile       |   1 +
 tools/testing/selftests/net/tcp_ao/self-connect.c | 197 ++++++++++++++++++++++
 2 files changed, 198 insertions(+)

diff --git a/tools/testing/selftests/net/tcp_ao/Makefile b/tools/testing/selftests/net/tcp_ao/Makefile
index 1d4f7576d774..9286f9b99c86 100644
--- a/tools/testing/selftests/net/tcp_ao/Makefile
+++ b/tools/testing/selftests/net/tcp_ao/Makefile
@@ -5,6 +5,7 @@ TEST_BOTH_AF += connect-deny
 TEST_BOTH_AF += icmps-accept icmps-discard
 TEST_BOTH_AF += restore
 TEST_BOTH_AF += rst
+TEST_BOTH_AF += self-connect
 TEST_BOTH_AF += seq-ext
 TEST_BOTH_AF += setsockopt-closed
 TEST_BOTH_AF += unsigned-md5
diff --git a/tools/testing/selftests/net/tcp_ao/self-connect.c b/tools/testing/selftests/net/tcp_ao/self-connect.c
new file mode 100644
index 000000000000..e154d9e198a9
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_ao/self-connect.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Author: Dmitry Safonov <dima@arista.com> */
+#include <inttypes.h>
+#include "aolib.h"
+
+static union tcp_addr local_addr;
+
+static void __setup_lo_intf(const char *lo_intf,
+			    const char *addr_str, uint8_t prefix)
+{
+	if (inet_pton(TEST_FAMILY, addr_str, &local_addr) != 1)
+		test_error("Can't convert local ip address");
+
+	if (ip_addr_add(lo_intf, TEST_FAMILY, local_addr, prefix))
+		test_error("Failed to add %s ip address", lo_intf);
+
+	if (link_set_up(lo_intf))
+		test_error("Failed to bring %s up", lo_intf);
+}
+
+static void setup_lo_intf(const char *lo_intf)
+{
+#ifdef IPV6_TEST
+	__setup_lo_intf(lo_intf, "::1", 128);
+#else
+	__setup_lo_intf(lo_intf, "127.0.0.1", 8);
+#endif
+}
+
+static void tcp_self_connect(const char *tst, unsigned int port,
+			     bool different_keyids, bool check_restore)
+{
+	uint64_t before_challenge_ack, after_challenge_ack;
+	uint64_t before_syn_challenge, after_syn_challenge;
+	struct tcp_ao_counters before_ao, after_ao;
+	uint64_t before_aogood, after_aogood;
+	struct netstat *ns_before, *ns_after;
+	const size_t nr_packets = 20;
+	struct tcp_ao_repair ao_img;
+	struct tcp_sock_state img;
+	sockaddr_af addr;
+	int sk;
+
+	tcp_addr_to_sockaddr_in(&addr, &local_addr, htons(port));
+
+	sk = socket(test_family, SOCK_STREAM, IPPROTO_TCP);
+	if (sk < 0)
+		test_error("socket()");
+
+	if (different_keyids) {
+		if (test_add_key(sk, DEFAULT_TEST_PASSWORD, local_addr, -1, 5, 7))
+			test_error("setsockopt(TCP_AO_ADD_KEY)");
+		if (test_add_key(sk, DEFAULT_TEST_PASSWORD, local_addr, -1, 7, 5))
+			test_error("setsockopt(TCP_AO_ADD_KEY)");
+	} else {
+		if (test_add_key(sk, DEFAULT_TEST_PASSWORD, local_addr, -1, 100, 100))
+			test_error("setsockopt(TCP_AO_ADD_KEY)");
+	}
+
+	if (bind(sk, (struct sockaddr *)&addr, sizeof(addr)) < 0)
+		test_error("bind()");
+
+	ns_before = netstat_read();
+	before_aogood = netstat_get(ns_before, "TCPAOGood", NULL);
+	before_challenge_ack = netstat_get(ns_before, "TCPChallengeACK", NULL);
+	before_syn_challenge = netstat_get(ns_before, "TCPSYNChallenge", NULL);
+	if (test_get_tcp_ao_counters(sk, &before_ao))
+		test_error("test_get_tcp_ao_counters()");
+
+	if (__test_connect_socket(sk, "lo", (struct sockaddr *)&addr,
+				  sizeof(addr), TEST_TIMEOUT_SEC) < 0) {
+		ns_after = netstat_read();
+		netstat_print_diff(ns_before, ns_after);
+		test_error("failed to connect()");
+	}
+
+	if (test_client_verify(sk, 100, nr_packets, TEST_TIMEOUT_SEC)) {
+		test_fail("%s: tcp connection verify failed", tst);
+		close(sk);
+		return;
+	}
+
+	ns_after = netstat_read();
+	after_aogood = netstat_get(ns_after, "TCPAOGood", NULL);
+	after_challenge_ack = netstat_get(ns_after, "TCPChallengeACK", NULL);
+	after_syn_challenge = netstat_get(ns_after, "TCPSYNChallenge", NULL);
+	if (test_get_tcp_ao_counters(sk, &after_ao))
+		test_error("test_get_tcp_ao_counters()");
+	if (!check_restore) {
+		/* to debug: netstat_print_diff(ns_before, ns_after); */
+		netstat_free(ns_before);
+	}
+	netstat_free(ns_after);
+
+	if (after_aogood <= before_aogood) {
+		test_fail("%s: TCPAOGood counter mismatch: %zu <= %zu",
+			  tst, after_aogood, before_aogood);
+		close(sk);
+		return;
+	}
+	if (after_challenge_ack <= before_challenge_ack ||
+	    after_syn_challenge <= before_syn_challenge) {
+		/*
+		 * It's also meant to test simultaneous open, so check
+		 * these counters as well.
+		 */
+		test_fail("%s: Didn't challenge SYN or ACK: %zu <= %zu OR %zu <= %zu",
+			  tst, after_challenge_ack, before_challenge_ack,
+			  after_syn_challenge, before_syn_challenge);
+		close(sk);
+		return;
+	}
+
+	if (test_tcp_ao_counters_cmp(tst, &before_ao, &after_ao, TEST_CNT_GOOD)) {
+		close(sk);
+		return;
+	}
+
+	if (!check_restore) {
+		test_ok("%s: connect TCPAOGood %" PRIu64 " => %" PRIu64,
+				tst, before_aogood, after_aogood);
+		close(sk);
+		return;
+	}
+
+	test_enable_repair(sk);
+	test_sock_checkpoint(sk, &img, &addr);
+#ifdef IPV6_TEST
+	addr.sin6_port = htons(port + 1);
+#else
+	addr.sin_port = htons(port + 1);
+#endif
+	test_ao_checkpoint(sk, &ao_img);
+	test_kill_sk(sk);
+
+	sk = socket(test_family, SOCK_STREAM, IPPROTO_TCP);
+	if (sk < 0)
+		test_error("socket()");
+
+	test_enable_repair(sk);
+	__test_sock_restore(sk, "lo", &img, &addr, &addr, sizeof(addr));
+	if (different_keyids) {
+		if (test_add_repaired_key(sk, DEFAULT_TEST_PASSWORD, 0,
+					  local_addr, -1, 7, 5))
+			test_error("setsockopt(TCP_AO_ADD_KEY)");
+		if (test_add_repaired_key(sk, DEFAULT_TEST_PASSWORD, 0,
+					  local_addr, -1, 5, 7))
+			test_error("setsockopt(TCP_AO_ADD_KEY)");
+	} else {
+		if (test_add_repaired_key(sk, DEFAULT_TEST_PASSWORD, 0,
+					  local_addr, -1, 100, 100))
+			test_error("setsockopt(TCP_AO_ADD_KEY)");
+	}
+	test_ao_restore(sk, &ao_img);
+	test_disable_repair(sk);
+	test_sock_state_free(&img);
+	if (test_client_verify(sk, 100, nr_packets, TEST_TIMEOUT_SEC)) {
+		test_fail("%s: tcp connection verify failed", tst);
+		close(sk);
+		return;
+	}
+	ns_after = netstat_read();
+	after_aogood = netstat_get(ns_after, "TCPAOGood", NULL);
+	/* to debug: netstat_print_diff(ns_before, ns_after); */
+	netstat_free(ns_before);
+	netstat_free(ns_after);
+	close(sk);
+	if (after_aogood <= before_aogood) {
+		test_fail("%s: TCPAOGood counter mismatch: %zu <= %zu",
+			  tst, after_aogood, before_aogood);
+		return;
+	}
+	test_ok("%s: connect TCPAOGood %" PRIu64 " => %" PRIu64,
+			tst, before_aogood, after_aogood);
+}
+
+static void *client_fn(void *arg)
+{
+	unsigned int port = test_server_port;
+
+	setup_lo_intf("lo");
+
+	tcp_self_connect("self-connect(same keyids)", port++, false, false);
+	tcp_self_connect("self-connect(different keyids)", port++, true, false);
+	tcp_self_connect("self-connect(restore)", port, false, true);
+	port += 2;
+	tcp_self_connect("self-connect(restore, different keyids)", port, true, true);
+	port += 2;
+
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	test_init(4, client_fn, NULL);
+	return 0;
+}

-- 
2.43.0


