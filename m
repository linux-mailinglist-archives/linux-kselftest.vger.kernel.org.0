Return-Path: <linux-kselftest+bounces-1986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CEB813FF8
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 03:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4475F284825
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 02:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66E4A3F;
	Fri, 15 Dec 2023 02:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Zk4Cv3/b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1A4D2E5
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Dec 2023 02:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40c2718a768so2126245e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 18:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1702607851; x=1703212651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5mCh/n6QPIQDvFqW6sCvozdVQ64HChvlZudkTjlDtY=;
        b=Zk4Cv3/bv0U00h/wJ9WMWJO2LeWFiu32GRRuCWtpSCRmzz+qMdsK4GIoLNnIZsCmRU
         hj/lBy4KdHLLmp/BxcJ9oJlZ4fMne6qkbGspBezoLwwdLN4bQa1TZSfQBePn6TaeBkho
         ++NvkVTXWEVbM3bNnwRkTemHxmfI7dwL9tkC1NNBjNiw55NgfYfYpA5vG5iBj1gPFcq8
         VD/h14hV6NVoDYykJU5E+i11nYfbLDV73yQtEZz9TN3lMFiZmgN0qkM7EllepRKtLWPx
         UFkOHfO6LukQzqreIgDQgHyyku/4RDH35SDzKVLoHjSJC/lzkluK2/njQVXhSXvkxIeV
         hboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702607851; x=1703212651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5mCh/n6QPIQDvFqW6sCvozdVQ64HChvlZudkTjlDtY=;
        b=Ai36SG+sxFmRdjviNDBjDYgiTw/YjW1pPf9HYEC0T6hcgRMRsPEFtqIXK3P7ssLj1p
         pr4CQUWQ+zSf1ZdHw+jrO23pfM/uJbMobHiG1nc6FcchnJVmft7o8V0TmG0LduQ0jaBw
         foPIIST3K4NAExexhGn5RFqCNd3WKJt+S9snppT9kDuzogi9pn54vU+SWd5Oag8MBUk0
         /o9xdKKqDSDyfEpxyZew83Zmuo2+hXt4C7QKZbEtXJNnFDpGpbeFnxZIQBUK4KB2KVS0
         EcIct9KPdcfulrWZw2E1IQyukN5JPNkYVV7bYtUAjnafIC+08T5X/JeKWLMF3Z3qIb+m
         zBuw==
X-Gm-Message-State: AOJu0YychYi/cTIRtZP8T95XMw642IqeRzxXI836yy0RMCbocVHac6aa
	k4cWMbZIDprdy82+Wz13b2wJ4w==
X-Google-Smtp-Source: AGHT+IGrL5Pp4HVmffGhL7lf8TRNtTwtFTucX7lswpuU1FUvU7R4JBGTDjNSH3GZzTr0F0eJK+RP3Q==
X-Received: by 2002:a05:600c:221a:b0:40c:33be:d193 with SMTP id z26-20020a05600c221a00b0040c33bed193mr6292850wml.78.1702607851094;
        Thu, 14 Dec 2023 18:37:31 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id fc17-20020a05600c525100b0040c42681fcesm20096363wmb.15.2023.12.14.18.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 18:37:30 -0800 (PST)
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
Subject: [PATCH 06/12] selftests/net: Add TCP-AO + TCP-MD5 + no sign listen socket tests
Date: Fri, 15 Dec 2023 02:36:20 +0000
Message-ID: <20231215-tcp-ao-selftests-v1-6-f6c08180b985@arista.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702607833; l=35234; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=VfoDboeEwXJXO5XIVj6L1Vig+ft3PBO/uc5bqM+F1EA=; b=EEZVVoSZqqZCAAOosgtdgRPL6KkCJNMzXkKTBU2QucoHlVWF0lBMq5Nb23odND0TuPt8qaxbD /MgRBoiZpvcBVwB2nF/kkhcPyy7tiUqmgaFCIB4EAS9cirTTNUndvY3
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

The test plan was (most of tests have all 3 client types):
1. TCP-AO listen (INADDR_ANY)
2. TCP-MD5 listen (INADDR_ANY)
3. non-signed listen (INADDR_ANY)
4. TCP-AO + TCP-MD5 listen (prefix)
5. TCP-AO subprefix add failure [checked in setsockopt-closed.c]
6. TCP-AO out of prefix connect [checked in connect-deny.c]
7. TCP-AO + TCP-MD5 on connect()
8. TCP-AO intersect with TCP-MD5 failure
9. Established TCP-AO: add TCP-MD5 key
10. Established TCP-MD5: add TCP-AO key
11. Established non-signed: add TCP-AO key

Output produced:
> # ./unsigned-md5_ipv6
> 1..72
> # 1592[lib/setup.c:239] rand seed 1697567046
> TAP version 13
> ok 1 AO server (INADDR_ANY): AO client: counter TCPAOGood increased 0 => 2
> ok 2 AO server (INADDR_ANY): AO client: connected
> ok 3 AO server (INADDR_ANY): MD5 client
> ok 4 AO server (INADDR_ANY): MD5 client: counter TCPMD5Unexpected increased 0 => 1
> ok 5 AO server (INADDR_ANY): no sign client: counter TCPAORequired increased 0 => 1
> ok 6 AO server (INADDR_ANY): unsigned client
> ok 7 AO server (AO_REQUIRED): AO client: connected
> ok 8 AO server (AO_REQUIRED): AO client: counter TCPAOGood increased 4 => 6
> ok 9 AO server (AO_REQUIRED): unsigned client
> ok 10 AO server (AO_REQUIRED): unsigned client: counter TCPAORequired increased 1 => 2
> ok 11 MD5 server (INADDR_ANY): AO client: counter TCPAOKeyNotFound increased 0 => 1
> ok 12 MD5 server (INADDR_ANY): AO client
> ok 13 MD5 server (INADDR_ANY): MD5 client: connected
> ok 14 MD5 server (INADDR_ANY): MD5 client: no counter checks
> ok 15 MD5 server (INADDR_ANY): no sign client
> ok 16 MD5 server (INADDR_ANY): no sign client: counter TCPMD5NotFound increased 0 => 1
> ok 17 no sign server: AO client
> ok 18 no sign server: AO client: counter TCPAOKeyNotFound increased 1 => 2
> ok 19 no sign server: MD5 client
> ok 20 no sign server: MD5 client: counter TCPMD5Unexpected increased 1 => 2
> ok 21 no sign server: no sign client: connected
> ok 22 no sign server: no sign client: counter CurrEstab increased 0 => 1
> ok 23 AO+MD5 server: AO client (matching): connected
> ok 24 AO+MD5 server: AO client (matching): counter TCPAOGood increased 8 => 10
> ok 25 AO+MD5 server: AO client (misconfig, matching MD5)
> ok 26 AO+MD5 server: AO client (misconfig, matching MD5): counter TCPAOKeyNotFound increased 2 => 3
> ok 27 AO+MD5 server: AO client (misconfig, non-matching): counter TCPAOKeyNotFound increased 3 => 4
> ok 28 AO+MD5 server: AO client (misconfig, non-matching)
> ok 29 AO+MD5 server: MD5 client (matching): connected
> ok 30 AO+MD5 server: MD5 client (matching): no counter checks
> ok 31 AO+MD5 server: MD5 client (misconfig, matching AO)
> ok 32 AO+MD5 server: MD5 client (misconfig, matching AO): counter TCPMD5Unexpected increased 2 => 3
> ok 33 AO+MD5 server: MD5 client (misconfig, non-matching)
> ok 34 AO+MD5 server: MD5 client (misconfig, non-matching): counter TCPMD5Unexpected increased 3 => 4
> ok 35 AO+MD5 server: no sign client (unmatched): connected
> ok 36 AO+MD5 server: no sign client (unmatched): counter CurrEstab increased 0 => 1
> ok 37 AO+MD5 server: no sign client (misconfig, matching AO)
> ok 38 AO+MD5 server: no sign client (misconfig, matching AO): counter TCPAORequired increased 2 => 3
> ok 39 AO+MD5 server: no sign client (misconfig, matching MD5)
> ok 40 AO+MD5 server: no sign client (misconfig, matching MD5): counter TCPMD5NotFound increased 1 => 2
> ok 41 AO+MD5 server: client with both [TCP-MD5] and TCP-AO keys: connect() was prevented
> ok 42 AO+MD5 server: client with both [TCP-MD5] and TCP-AO keys: no counter checks
> ok 43 AO+MD5 server: client with both TCP-MD5 and [TCP-AO] keys: connect() was prevented
> ok 44 AO+MD5 server: client with both TCP-MD5 and [TCP-AO] keys: no counter checks
> ok 45 TCP-AO established: add TCP-MD5 key: postfailed as expected
> ok 46 TCP-AO established: add TCP-MD5 key: counter TCPAOGood increased 12 => 14
> ok 47 TCP-MD5 established: add TCP-AO key: postfailed as expected
> ok 48 TCP-MD5 established: add TCP-AO key: no counter checks
> ok 49 non-signed established: add TCP-AO key: postfailed as expected
> ok 50 non-signed established: add TCP-AO key: counter CurrEstab increased 0 => 1
> ok 51 TCP-AO key intersects with existing TCP-MD5 key: prefailed as expected: Key was rejected by service
> ok 52 TCP-MD5 key intersects with existing TCP-AO key: prefailed as expected: Key was rejected by service
> ok 53 TCP-MD5 key + TCP-AO required: prefailed as expected: Key was rejected by service
> ok 54 TCP-AO required on socket + TCP-MD5 key: prefailed as expected: Key was rejected by service
> ok 55 VRF: TCP-AO key (no l3index) + TCP-MD5 key (no l3index): prefailed as expected: Key was rejected by service
> ok 56 VRF: TCP-MD5 key (no l3index) + TCP-AO key (no l3index): prefailed as expected: Key was rejected by service
> ok 57 VRF: TCP-AO key (no l3index) + TCP-MD5 key (l3index=0): prefailed as expected: Key was rejected by service
> ok 58 VRF: TCP-MD5 key (l3index=0) + TCP-AO key (no l3index): prefailed as expected: Key was rejected by service
> ok 59 VRF: TCP-AO key (no l3index) + TCP-MD5 key (l3index=N): prefailed as expected: Key was rejected by service
> ok 60 VRF: TCP-MD5 key (l3index=N) + TCP-AO key (no l3index): prefailed as expected: Key was rejected by service
> ok 61 VRF: TCP-AO key (l3index=0) + TCP-MD5 key (no l3index): prefailed as expected: Key was rejected by service
> ok 62 VRF: TCP-MD5 key (no l3index) + TCP-AO key (l3index=0): prefailed as expected: Key was rejected by service
> ok 63 VRF: TCP-AO key (l3index=0) + TCP-MD5 key (l3index=0): prefailed as expected: Key was rejected by service
> ok 64 VRF: TCP-MD5 key (l3index=0) + TCP-AO key (l3index=0): prefailed as expected: Key was rejected by service
> ok 65 VRF: TCP-AO key (l3index=0) + TCP-MD5 key (l3index=N)
> ok 66 VRF: TCP-MD5 key (l3index=N) + TCP-AO key (l3index=0)
> ok 67 VRF: TCP-AO key (l3index=N) + TCP-MD5 key (no l3index): prefailed as expected: Key was rejected by service
> ok 68 VRF: TCP-MD5 key (no l3index) + TCP-AO key (l3index=N): prefailed as expected: Key was rejected by service
> ok 69 VRF: TCP-AO key (l3index=N) + TCP-MD5 key (l3index=0)
> ok 70 VRF: TCP-MD5 key (l3index=0) + TCP-AO key (l3index=N)
> ok 71 VRF: TCP-AO key (l3index=N) + TCP-MD5 key (l3index=N): prefailed as expected: Key was rejected by service
> ok 72 VRF: TCP-MD5 key (l3index=N) + TCP-AO key (l3index=N): prefailed as expected: Key was rejected by service
> # Totals: pass:72 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/tcp_ao/Makefile       |   1 +
 tools/testing/selftests/net/tcp_ao/unsigned-md5.c | 742 ++++++++++++++++++++++
 2 files changed, 743 insertions(+)

diff --git a/tools/testing/selftests/net/tcp_ao/Makefile b/tools/testing/selftests/net/tcp_ao/Makefile
index 1efd98ca12db..ee2f1a17e805 100644
--- a/tools/testing/selftests/net/tcp_ao/Makefile
+++ b/tools/testing/selftests/net/tcp_ao/Makefile
@@ -3,6 +3,7 @@ TEST_BOTH_AF := connect
 TEST_BOTH_AF += connect-deny
 TEST_BOTH_AF += icmps-accept icmps-discard
 TEST_BOTH_AF += setsockopt-closed
+TEST_BOTH_AF += unsigned-md5
 
 TEST_IPV4_PROGS := $(TEST_BOTH_AF:%=%_ipv4)
 TEST_IPV6_PROGS := $(TEST_BOTH_AF:%=%_ipv6)
diff --git a/tools/testing/selftests/net/tcp_ao/unsigned-md5.c b/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
new file mode 100644
index 000000000000..7cffde02d2be
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
@@ -0,0 +1,742 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Author: Dmitry Safonov <dima@arista.com> */
+#include <inttypes.h>
+#include "aolib.h"
+
+#define fault(type)	(inj == FAULT_ ## type)
+static const char *md5_password = "Some evil genius, enemy to mankind, must have been the first contriver.";
+static const char *ao_password = DEFAULT_TEST_PASSWORD;
+
+static union tcp_addr client2;
+static union tcp_addr client3;
+
+static const int test_vrf_ifindex = 200;
+static const uint8_t test_vrf_tabid = 42;
+static void setup_vrfs(void)
+{
+	int err;
+
+	if (!kernel_config_has(KCONFIG_NET_VRF))
+		return;
+
+	err = add_vrf("ksft-vrf", test_vrf_tabid, test_vrf_ifindex, -1);
+	if (err)
+		test_error("Failed to add a VRF: %d", err);
+
+	err = link_set_up("ksft-vrf");
+	if (err)
+		test_error("Failed to bring up a VRF");
+
+	err = ip_route_add_vrf(veth_name, TEST_FAMILY,
+			       this_ip_addr, this_ip_dest, test_vrf_tabid);
+	if (err)
+		test_error("Failed to add a route to VRF");
+}
+
+static void try_accept(const char *tst_name, unsigned int port,
+		       union tcp_addr *md5_addr, uint8_t md5_prefix,
+		       union tcp_addr *ao_addr, uint8_t ao_prefix,
+		       bool set_ao_required,
+		       uint8_t sndid, uint8_t rcvid, uint8_t vrf,
+		       const char *cnt_name, test_cnt cnt_expected,
+		       int needs_tcp_md5, fault_t inj)
+{
+	struct tcp_ao_counters ao_cnt1, ao_cnt2;
+	uint64_t before_cnt = 0, after_cnt = 0; /* silence GCC */
+	int lsk, err, sk = 0;
+	time_t timeout;
+
+	if (needs_tcp_md5 && should_skip_test(tst_name, KCONFIG_TCP_MD5))
+		return;
+
+	lsk = test_listen_socket(this_ip_addr, port, 1);
+
+	if (md5_addr && test_set_md5(lsk, *md5_addr, md5_prefix, -1, md5_password))
+		test_error("setsockopt(TCP_MD5SIG_EXT)");
+
+	if (ao_addr && test_add_key(lsk, ao_password,
+				    *ao_addr, ao_prefix, sndid, rcvid))
+		test_error("setsockopt(TCP_AO_ADD_KEY)");
+
+	if (set_ao_required && test_set_ao_flags(lsk, true, false))
+		test_error("setsockopt(TCP_AO_INFO)");
+
+	if (cnt_name)
+		before_cnt = netstat_get_one(cnt_name, NULL);
+	if (ao_addr && test_get_tcp_ao_counters(lsk, &ao_cnt1))
+		test_error("test_get_tcp_ao_counters()");
+
+	synchronize_threads(); /* preparations done */
+
+	timeout = fault(TIMEOUT) ? TEST_RETRANSMIT_SEC : TEST_TIMEOUT_SEC;
+	err = test_wait_fd(lsk, timeout, 0);
+	if (err == -ETIMEDOUT) {
+		if (!fault(TIMEOUT))
+			test_fail("timeouted for accept()");
+	} else if (err < 0) {
+		test_error("test_wait_fd()");
+	} else {
+		if (fault(TIMEOUT))
+			test_fail("ready to accept");
+
+		sk = accept(lsk, NULL, NULL);
+		if (sk < 0) {
+			test_error("accept()");
+		} else {
+			if (fault(TIMEOUT))
+				test_fail("%s: accepted", tst_name);
+		}
+	}
+
+	if (ao_addr && test_get_tcp_ao_counters(lsk, &ao_cnt2))
+		test_error("test_get_tcp_ao_counters()");
+	close(lsk);
+
+	if (!cnt_name) {
+		test_ok("%s: no counter checks", tst_name);
+		goto out;
+	}
+
+	after_cnt = netstat_get_one(cnt_name, NULL);
+
+	if (after_cnt <= before_cnt) {
+		test_fail("%s: %s counter did not increase: %zu <= %zu",
+				tst_name, cnt_name, after_cnt, before_cnt);
+	} else {
+		test_ok("%s: counter %s increased %zu => %zu",
+			tst_name, cnt_name, before_cnt, after_cnt);
+	}
+	if (ao_addr)
+		test_tcp_ao_counters_cmp(tst_name, &ao_cnt1, &ao_cnt2, cnt_expected);
+
+out:
+	synchronize_threads(); /* close() */
+	if (sk > 0)
+		close(sk);
+}
+
+static void server_add_routes(void)
+{
+	int family = TEST_FAMILY;
+
+	synchronize_threads(); /* client_add_ips() */
+
+	if (ip_route_add(veth_name, family, this_ip_addr, client2))
+		test_error("Failed to add route");
+	if (ip_route_add(veth_name, family, this_ip_addr, client3))
+		test_error("Failed to add route");
+}
+
+static void server_add_fail_tests(unsigned int *port)
+{
+	union tcp_addr addr_any = {};
+
+	try_accept("TCP-AO established: add TCP-MD5 key", (*port)++, NULL, 0,
+		   &addr_any, 0, 0, 100, 100, 0, "TCPAOGood", TEST_CNT_GOOD,
+		   1, 0);
+	try_accept("TCP-MD5 established: add TCP-AO key", (*port)++, &addr_any,
+		   0, NULL, 0, 0, 0, 0, 0, NULL, 0, 1, 0);
+	try_accept("non-signed established: add TCP-AO key", (*port)++, NULL, 0,
+		   NULL, 0, 0, 0, 0, 0, "CurrEstab", 0, 0, 0);
+}
+
+static void server_vrf_tests(unsigned int *port)
+{
+	setup_vrfs();
+}
+
+static void *server_fn(void *arg)
+{
+	unsigned int port = test_server_port;
+	union tcp_addr addr_any = {};
+
+	server_add_routes();
+
+	try_accept("AO server (INADDR_ANY): AO client", port++, NULL, 0,
+		   &addr_any, 0, 0, 100, 100, 0, "TCPAOGood",
+		   TEST_CNT_GOOD, 0, 0);
+	try_accept("AO server (INADDR_ANY): MD5 client", port++, NULL, 0,
+		   &addr_any, 0, 0, 100, 100, 0, "TCPMD5Unexpected",
+		   0, 1, FAULT_TIMEOUT);
+	try_accept("AO server (INADDR_ANY): no sign client", port++, NULL, 0,
+		   &addr_any, 0, 0, 100, 100, 0, "TCPAORequired",
+		   TEST_CNT_AO_REQUIRED, 0, FAULT_TIMEOUT);
+	try_accept("AO server (AO_REQUIRED): AO client", port++, NULL, 0,
+		   &this_ip_dest, TEST_PREFIX, true,
+		   100, 100, 0, "TCPAOGood", TEST_CNT_GOOD, 0, 0);
+	try_accept("AO server (AO_REQUIRED): unsigned client", port++, NULL, 0,
+		   &this_ip_dest, TEST_PREFIX, true,
+		   100, 100, 0, "TCPAORequired",
+		   TEST_CNT_AO_REQUIRED, 0, FAULT_TIMEOUT);
+
+	try_accept("MD5 server (INADDR_ANY): AO client", port++, &addr_any, 0,
+		   NULL, 0, 0, 0, 0, 0, "TCPAOKeyNotFound",
+		   0, 1, FAULT_TIMEOUT);
+	try_accept("MD5 server (INADDR_ANY): MD5 client", port++, &addr_any, 0,
+		   NULL, 0, 0, 0, 0, 0, NULL, 0, 1, 0);
+	try_accept("MD5 server (INADDR_ANY): no sign client", port++, &addr_any,
+		   0, NULL, 0, 0, 0, 0, 0, "TCPMD5NotFound",
+		   0, 1, FAULT_TIMEOUT);
+
+	try_accept("no sign server: AO client", port++, NULL, 0,
+		   NULL, 0, 0, 0, 0, 0, "TCPAOKeyNotFound",
+		   TEST_CNT_AO_KEY_NOT_FOUND, 0, FAULT_TIMEOUT);
+	try_accept("no sign server: MD5 client", port++, NULL, 0,
+		   NULL, 0, 0, 0, 0, 0, "TCPMD5Unexpected",
+		   0, 1, FAULT_TIMEOUT);
+	try_accept("no sign server: no sign client", port++, NULL, 0,
+		   NULL, 0, 0, 0, 0, 0, "CurrEstab", 0, 0, 0);
+
+	try_accept("AO+MD5 server: AO client (matching)", port++,
+		   &this_ip_dest, TEST_PREFIX, &client2, TEST_PREFIX, 0,
+		   100, 100, 0, "TCPAOGood", TEST_CNT_GOOD, 1, 0);
+	try_accept("AO+MD5 server: AO client (misconfig, matching MD5)", port++,
+		   &this_ip_dest, TEST_PREFIX, &client2, TEST_PREFIX, 0,
+		   100, 100, 0, "TCPAOKeyNotFound", TEST_CNT_AO_KEY_NOT_FOUND,
+		   1, FAULT_TIMEOUT);
+	try_accept("AO+MD5 server: AO client (misconfig, non-matching)", port++,
+		   &this_ip_dest, TEST_PREFIX, &client2, TEST_PREFIX, 0,
+		   100, 100, 0, "TCPAOKeyNotFound", TEST_CNT_AO_KEY_NOT_FOUND,
+		   1, FAULT_TIMEOUT);
+	try_accept("AO+MD5 server: MD5 client (matching)", port++,
+		   &this_ip_dest, TEST_PREFIX, &client2, TEST_PREFIX, 0,
+		   100, 100, 0, NULL, 0, 1, 0);
+	try_accept("AO+MD5 server: MD5 client (misconfig, matching AO)", port++,
+		   &this_ip_dest, TEST_PREFIX, &client2, TEST_PREFIX, 0,
+		   100, 100, 0, "TCPMD5Unexpected", 0, 1, FAULT_TIMEOUT);
+	try_accept("AO+MD5 server: MD5 client (misconfig, non-matching)", port++,
+		   &this_ip_dest, TEST_PREFIX, &client2, TEST_PREFIX, 0,
+		   100, 100, 0, "TCPMD5Unexpected", 0, 1, FAULT_TIMEOUT);
+	try_accept("AO+MD5 server: no sign client (unmatched)", port++,
+		   &this_ip_dest, TEST_PREFIX, &client2, TEST_PREFIX, 0,
+		   100, 100, 0, "CurrEstab", 0, 1, 0);
+	try_accept("AO+MD5 server: no sign client (misconfig, matching AO)",
+		   port++, &this_ip_dest, TEST_PREFIX, &client2, TEST_PREFIX, 0,
+		   100, 100, 0, "TCPAORequired",
+		   TEST_CNT_AO_REQUIRED, 1, FAULT_TIMEOUT);
+	try_accept("AO+MD5 server: no sign client (misconfig, matching MD5)",
+		   port++, &this_ip_dest, TEST_PREFIX, &client2, TEST_PREFIX, 0,
+		   100, 100, 0, "TCPMD5NotFound", 0, 1, FAULT_TIMEOUT);
+
+	try_accept("AO+MD5 server: client with both [TCP-MD5] and TCP-AO keys",
+		   port++, &this_ip_dest, TEST_PREFIX, &client2, TEST_PREFIX, 0,
+		   100, 100, 0, NULL, 0, 1, FAULT_TIMEOUT);
+	try_accept("AO+MD5 server: client with both TCP-MD5 and [TCP-AO] keys",
+		   port++, &this_ip_dest, TEST_PREFIX, &client2, TEST_PREFIX, 0,
+		   100, 100, 0, NULL, 0, 1, FAULT_TIMEOUT);
+
+	server_add_fail_tests(&port);
+
+	server_vrf_tests(&port);
+
+	/* client exits */
+	synchronize_threads();
+	return NULL;
+}
+
+static int client_bind(int sk, union tcp_addr bind_addr)
+{
+#ifdef IPV6_TEST
+	struct sockaddr_in6 addr = {
+		.sin6_family	= AF_INET6,
+		.sin6_port	= 0,
+		.sin6_addr	= bind_addr.a6,
+	};
+#else
+	struct sockaddr_in addr = {
+		.sin_family	= AF_INET,
+		.sin_port	= 0,
+		.sin_addr	= bind_addr.a4,
+	};
+#endif
+	return bind(sk, &addr, sizeof(addr));
+}
+
+static void try_connect(const char *tst_name, unsigned int port,
+		       union tcp_addr *md5_addr, uint8_t md5_prefix,
+		       union tcp_addr *ao_addr, uint8_t ao_prefix,
+		       uint8_t sndid, uint8_t rcvid, uint8_t vrf,
+		       fault_t inj, int needs_tcp_md5, union tcp_addr *bind_addr)
+{
+	time_t timeout;
+	int sk, ret;
+
+	if (needs_tcp_md5 && should_skip_test(tst_name, KCONFIG_TCP_MD5))
+		return;
+
+	sk = socket(test_family, SOCK_STREAM, IPPROTO_TCP);
+	if (sk < 0)
+		test_error("socket()");
+
+	if (bind_addr && client_bind(sk, *bind_addr))
+		test_error("bind()");
+
+	if (md5_addr && test_set_md5(sk, *md5_addr, md5_prefix, -1, md5_password))
+		test_error("setsockopt(TCP_MD5SIG_EXT)");
+
+	if (ao_addr && test_add_key(sk, ao_password, *ao_addr,
+				    ao_prefix, sndid, rcvid))
+		test_error("setsockopt(TCP_AO_ADD_KEY)");
+
+	synchronize_threads(); /* preparations done */
+
+	timeout = fault(TIMEOUT) ? TEST_RETRANSMIT_SEC : TEST_TIMEOUT_SEC;
+	ret = _test_connect_socket(sk, this_ip_dest, port, timeout);
+
+	if (ret < 0) {
+		if (fault(KEYREJECT) && ret == -EKEYREJECTED)
+			test_ok("%s: connect() was prevented", tst_name);
+		else if (ret == -ETIMEDOUT && fault(TIMEOUT))
+			test_ok("%s", tst_name);
+		else if (ret == -ECONNREFUSED &&
+				(fault(TIMEOUT) || fault(KEYREJECT)))
+			test_ok("%s: refused to connect", tst_name);
+		else
+			test_error("%s: connect() returned %d", tst_name, ret);
+		goto out;
+	}
+
+	if (fault(TIMEOUT) || fault(KEYREJECT))
+		test_fail("%s: connected", tst_name);
+	else
+		test_ok("%s: connected", tst_name);
+
+out:
+	synchronize_threads(); /* close() */
+	/* _test_connect_socket() cleans up on failure */
+	if (ret > 0)
+		close(sk);
+}
+
+#define PREINSTALL_MD5_FIRST	BIT(0)
+#define PREINSTALL_AO		BIT(1)
+#define POSTINSTALL_AO		BIT(2)
+#define PREINSTALL_MD5		BIT(3)
+#define POSTINSTALL_MD5		BIT(4)
+
+static int try_add_key_vrf(int sk, union tcp_addr in_addr, uint8_t prefix,
+			   int vrf, uint8_t sndid, uint8_t rcvid,
+			   bool set_ao_required)
+{
+	uint8_t keyflags = 0;
+
+	if (vrf >= 0)
+		keyflags |= TCP_AO_KEYF_IFINDEX;
+	else
+		vrf = 0;
+	if (set_ao_required) {
+		int err = test_set_ao_flags(sk, true, 0);
+
+		if (err)
+			return err;
+	}
+	return test_add_key_vrf(sk, ao_password, keyflags, in_addr, prefix,
+				(uint8_t)vrf, sndid, rcvid);
+}
+
+static bool test_continue(const char *tst_name, int err,
+			  fault_t inj, bool added_ao)
+{
+	bool expected_to_fail;
+
+	expected_to_fail = fault(PREINSTALL_AO) && added_ao;
+	expected_to_fail |= fault(PREINSTALL_MD5) && !added_ao;
+
+	if (!err) {
+		if (!expected_to_fail)
+			return true;
+		test_fail("%s: setsockopt()s were expected to fail", tst_name);
+		return false;
+	}
+	if (err != -EKEYREJECTED || !expected_to_fail) {
+		test_error("%s: setsockopt(%s) = %d", tst_name,
+			   added_ao ? "TCP_AO_ADD_KEY" : "TCP_MD5SIG_EXT", err);
+		return false;
+	}
+	test_ok("%s: prefailed as expected: %m", tst_name);
+	return false;
+}
+
+static int open_add(const char *tst_name, unsigned int port,
+		    unsigned int strategy,
+		    union tcp_addr md5_addr, uint8_t md5_prefix, int md5_vrf,
+		    union tcp_addr ao_addr, uint8_t ao_prefix,
+		    int ao_vrf, bool set_ao_required,
+		    uint8_t sndid, uint8_t rcvid,
+		    fault_t inj)
+{
+	int sk;
+
+	sk = socket(test_family, SOCK_STREAM, IPPROTO_TCP);
+	if (sk < 0)
+		test_error("socket()");
+
+	if (client_bind(sk, this_ip_addr))
+		test_error("bind()");
+
+	if (strategy & PREINSTALL_MD5_FIRST) {
+		if (test_set_md5(sk, md5_addr, md5_prefix, md5_vrf, md5_password))
+			test_error("setsockopt(TCP_MD5SIG_EXT)");
+	}
+
+	if (strategy & PREINSTALL_AO) {
+		int err = try_add_key_vrf(sk, ao_addr, ao_prefix, ao_vrf,
+					  sndid, rcvid, set_ao_required);
+
+		if (!test_continue(tst_name, err, inj, true)) {
+			close(sk);
+			return -1;
+		}
+	}
+
+	if (strategy & PREINSTALL_MD5) {
+		errno = 0;
+		test_set_md5(sk, md5_addr, md5_prefix, md5_vrf, md5_password);
+		if (!test_continue(tst_name, -errno, inj, false)) {
+			close(sk);
+			return -1;
+		}
+	}
+
+	return sk;
+}
+
+static void try_to_preadd(const char *tst_name, unsigned int port,
+			  unsigned int strategy,
+			  union tcp_addr md5_addr, uint8_t md5_prefix,
+			  int md5_vrf,
+			  union tcp_addr ao_addr, uint8_t ao_prefix,
+			  int ao_vrf, bool set_ao_required,
+			  uint8_t sndid, uint8_t rcvid,
+			  int needs_tcp_md5, int needs_vrf, fault_t inj)
+{
+	int sk;
+
+	if (needs_tcp_md5 && should_skip_test(tst_name, KCONFIG_TCP_MD5))
+		return;
+	if (needs_vrf && should_skip_test(tst_name, KCONFIG_NET_VRF))
+		return;
+
+	sk = open_add(tst_name, port, strategy, md5_addr, md5_prefix, md5_vrf,
+		      ao_addr, ao_prefix, ao_vrf, set_ao_required,
+		      sndid, rcvid, inj);
+	if (sk < 0)
+		return;
+
+	test_ok("%s", tst_name);
+	close(sk);
+}
+
+static void try_to_add(const char *tst_name, unsigned int port,
+		       unsigned int strategy,
+		       union tcp_addr md5_addr, uint8_t md5_prefix,
+		       int md5_vrf,
+		       union tcp_addr ao_addr, uint8_t ao_prefix,
+		       int ao_vrf, uint8_t sndid, uint8_t rcvid,
+		       int needs_tcp_md5, fault_t inj)
+{
+	time_t timeout;
+	int sk, ret;
+
+	if (needs_tcp_md5 && should_skip_test(tst_name, KCONFIG_TCP_MD5))
+		return;
+
+	sk = open_add(tst_name, port, strategy, md5_addr, md5_prefix, md5_vrf,
+		      ao_addr, ao_prefix, ao_vrf, 0, sndid, rcvid, inj);
+	if (sk < 0)
+		return;
+
+	synchronize_threads(); /* preparations done */
+
+	timeout = fault(TIMEOUT) ? TEST_RETRANSMIT_SEC : TEST_TIMEOUT_SEC;
+	ret = _test_connect_socket(sk, this_ip_dest, port, timeout);
+
+	if (ret <= 0) {
+		test_error("%s: connect() returned %d", tst_name, ret);
+		goto out;
+	}
+
+	if (strategy & POSTINSTALL_MD5) {
+		if (test_set_md5(sk, md5_addr, md5_prefix, md5_vrf, md5_password)) {
+			if (fault(POSTINSTALL)) {
+				test_ok("%s: postfailed as expected", tst_name);
+				goto out;
+			} else {
+				test_error("setsockopt(TCP_MD5SIG_EXT)");
+			}
+		} else if (fault(POSTINSTALL)) {
+			test_fail("%s: post setsockopt() was expected to fail", tst_name);
+			goto out;
+		}
+	}
+
+	if (strategy & POSTINSTALL_AO) {
+		if (try_add_key_vrf(sk, ao_addr, ao_prefix, ao_vrf,
+				   sndid, rcvid, 0)) {
+			if (fault(POSTINSTALL)) {
+				test_ok("%s: postfailed as expected", tst_name);
+				goto out;
+			} else {
+				test_error("setsockopt(TCP_AO_ADD_KEY)");
+			}
+		} else if (fault(POSTINSTALL)) {
+			test_fail("%s: post setsockopt() was expected to fail", tst_name);
+			goto out;
+		}
+	}
+
+out:
+	synchronize_threads(); /* close() */
+	/* _test_connect_socket() cleans up on failure */
+	if (ret > 0)
+		close(sk);
+}
+
+static void client_add_ip(union tcp_addr *client, const char *ip)
+{
+	int family = TEST_FAMILY;
+
+	if (inet_pton(family, ip, client) != 1)
+		test_error("Can't convert ip address %s", ip);
+
+	if (ip_addr_add(veth_name, family, *client, TEST_PREFIX))
+		test_error("Failed to add ip address");
+	if (ip_route_add(veth_name, family, *client, this_ip_dest))
+		test_error("Failed to add route");
+}
+
+static void client_add_ips(void)
+{
+	client_add_ip(&client2, __TEST_CLIENT_IP(2));
+	client_add_ip(&client3, __TEST_CLIENT_IP(3));
+	synchronize_threads(); /* server_add_routes() */
+}
+
+static void client_add_fail_tests(unsigned int *port)
+{
+	try_to_add("TCP-AO established: add TCP-MD5 key",
+		   (*port)++, POSTINSTALL_MD5 | PREINSTALL_AO,
+		   this_ip_dest, TEST_PREFIX, -1, this_ip_dest, TEST_PREFIX, 0,
+		   100, 100, 1, FAULT_POSTINSTALL);
+	try_to_add("TCP-MD5 established: add TCP-AO key",
+		   (*port)++, PREINSTALL_MD5 | POSTINSTALL_AO,
+		   this_ip_dest, TEST_PREFIX, -1, this_ip_dest, TEST_PREFIX, 0,
+		   100, 100, 1, FAULT_POSTINSTALL);
+	try_to_add("non-signed established: add TCP-AO key",
+		   (*port)++, POSTINSTALL_AO,
+		   this_ip_dest, TEST_PREFIX, -1, this_ip_dest, TEST_PREFIX, 0,
+		   100, 100, 0, FAULT_POSTINSTALL);
+
+	try_to_add("TCP-AO key intersects with existing TCP-MD5 key",
+		   (*port)++, PREINSTALL_MD5_FIRST | PREINSTALL_AO,
+		   this_ip_addr, TEST_PREFIX, -1, this_ip_addr, TEST_PREFIX, -1,
+		   100, 100, 1, FAULT_PREINSTALL_AO);
+	try_to_add("TCP-MD5 key intersects with existing TCP-AO key",
+		   (*port)++, PREINSTALL_MD5 | PREINSTALL_AO,
+		   this_ip_addr, TEST_PREFIX, -1, this_ip_addr, TEST_PREFIX, -1,
+		   100, 100, 1, FAULT_PREINSTALL_MD5);
+
+	try_to_preadd("TCP-MD5 key + TCP-AO required",
+		      (*port)++, PREINSTALL_MD5_FIRST | PREINSTALL_AO,
+		      this_ip_addr, TEST_PREFIX, -1,
+		      this_ip_addr, TEST_PREFIX, -1, true,
+		      100, 100, 1, 0, FAULT_PREINSTALL_AO);
+	try_to_preadd("TCP-AO required on socket + TCP-MD5 key",
+		      (*port)++, PREINSTALL_MD5 | PREINSTALL_AO,
+		      this_ip_addr, TEST_PREFIX, -1,
+		      this_ip_addr, TEST_PREFIX, -1, true,
+		      100, 100, 1, 0, FAULT_PREINSTALL_MD5);
+}
+
+static void client_vrf_tests(unsigned int *port)
+{
+	setup_vrfs();
+
+	/* The following restrictions for setsockopt()s are expected:
+	 *
+	 * |--------------|-----------------|-------------|-------------|
+	 * |              | MD5 key without |   MD5 key   |   MD5 key   |
+	 * |              |     l3index     |  l3index=0  |  l3index=N  |
+	 * |--------------|-----------------|-------------|-------------|
+	 * |  TCP-AO key  |                 |             |             |
+	 * |  without     |     reject      |    reject   |    reject   |
+	 * |  l3index     |                 |             |             |
+	 * |--------------|-----------------|-------------|-------------|
+	 * |  TCP-AO key  |                 |             |             |
+	 * |  l3index=0   |     reject      |    reject   |    allow    |
+	 * |--------------|-----------------|-------------|-------------|
+	 * |  TCP-AO key  |                 |             |             |
+	 * |  l3index=N   |     reject      |    allow    |    reject   |
+	 * |--------------|-----------------|-------------|-------------|
+	 */
+	try_to_preadd("VRF: TCP-AO key (no l3index) + TCP-MD5 key (no l3index)",
+		      (*port)++, PREINSTALL_MD5 | PREINSTALL_AO,
+		      this_ip_addr, TEST_PREFIX, -1,
+		      this_ip_addr, TEST_PREFIX, -1, 0, 100, 100,
+		      1, 1, FAULT_PREINSTALL_MD5);
+	try_to_preadd("VRF: TCP-MD5 key (no l3index) + TCP-AO key (no l3index)",
+		      (*port)++, PREINSTALL_MD5_FIRST | PREINSTALL_AO,
+		      this_ip_addr, TEST_PREFIX, -1,
+		      this_ip_addr, TEST_PREFIX, -1, 0, 100, 100,
+		      1, 1, FAULT_PREINSTALL_AO);
+	try_to_preadd("VRF: TCP-AO key (no l3index) + TCP-MD5 key (l3index=0)",
+		      (*port)++, PREINSTALL_MD5 | PREINSTALL_AO,
+		      this_ip_addr, TEST_PREFIX, 0,
+		      this_ip_addr, TEST_PREFIX, -1, 0, 100, 100,
+		      1, 1, FAULT_PREINSTALL_MD5);
+	try_to_preadd("VRF: TCP-MD5 key (l3index=0) + TCP-AO key (no l3index)",
+		      (*port)++, PREINSTALL_MD5_FIRST | PREINSTALL_AO,
+		      this_ip_addr, TEST_PREFIX, 0,
+		      this_ip_addr, TEST_PREFIX, -1, 0, 100, 100,
+		      1, 1, FAULT_PREINSTALL_AO);
+	try_to_preadd("VRF: TCP-AO key (no l3index) + TCP-MD5 key (l3index=N)",
+		      (*port)++, PREINSTALL_MD5 | PREINSTALL_AO,
+		      this_ip_addr, TEST_PREFIX, test_vrf_ifindex,
+		      this_ip_addr, TEST_PREFIX, -1, 0, 100, 100,
+		      1, 1, FAULT_PREINSTALL_MD5);
+	try_to_preadd("VRF: TCP-MD5 key (l3index=N) + TCP-AO key (no l3index)",
+		      (*port)++, PREINSTALL_MD5_FIRST | PREINSTALL_AO,
+		      this_ip_addr, TEST_PREFIX, test_vrf_ifindex,
+		      this_ip_addr, TEST_PREFIX, -1, 0, 100, 100,
+		      1, 1, FAULT_PREINSTALL_AO);
+
+	try_to_preadd("VRF: TCP-AO key (l3index=0) + TCP-MD5 key (no l3index)",
+		      (*port)++, PREINSTALL_MD5 | PREINSTALL_AO,
+		      this_ip_addr, TEST_PREFIX, -1,
+		      this_ip_addr, TEST_PREFIX, 0, 0, 100, 100,
+		      1, 1, FAULT_PREINSTALL_MD5);
+	try_to_preadd("VRF: TCP-MD5 key (no l3index) + TCP-AO key (l3index=0)",
+		      (*port)++, PREINSTALL_MD5_FIRST | PREINSTALL_AO,
+		      this_ip_addr, TEST_PREFIX, -1,
+		      this_ip_addr, TEST_PREFIX, 0, 0, 100, 100,
+		      1, 1, FAULT_PREINSTALL_AO);
+	try_to_preadd("VRF: TCP-AO key (l3index=0) + TCP-MD5 key (l3index=0)",
+		      (*port)++, PREINSTALL_MD5 | PREINSTALL_AO,
+		      this_ip_addr, TEST_PREFIX, 0,
+		      this_ip_addr, TEST_PREFIX, 0, 0, 100, 100,
+		      1, 1, FAULT_PREINSTALL_MD5);
+	try_to_preadd("VRF: TCP-MD5 key (l3index=0) + TCP-AO key (l3index=0)",
+		      (*port)++, PREINSTALL_MD5_FIRST | PREINSTALL_AO,
+		      this_ip_addr, TEST_PREFIX, 0,
+		      this_ip_addr, TEST_PREFIX, 0, 0, 100, 100,
+		      1, 1, FAULT_PREINSTALL_AO);
+	try_to_preadd("VRF: TCP-AO key (l3index=0) + TCP-MD5 key (l3index=N)",
+		      (*port)++, PREINSTALL_MD5 | PREINSTALL_AO,
+		      this_ip_addr, TEST_PREFIX, test_vrf_ifindex,
+		      this_ip_addr, TEST_PREFIX, 0, 0, 100, 100,
+		      1, 1, 0);
+	try_to_preadd("VRF: TCP-MD5 key (l3index=N) + TCP-AO key (l3index=0)",
+		      (*port)++, PREINSTALL_MD5_FIRST | PREINSTALL_AO,
+		      this_ip_addr, TEST_PREFIX, test_vrf_ifindex,
+		      this_ip_addr, TEST_PREFIX, 0, 0, 100, 100,
+		      1, 1, 0);
+
+	try_to_preadd("VRF: TCP-AO key (l3index=N) + TCP-MD5 key (no l3index)",
+		      (*port)++, PREINSTALL_MD5 | PREINSTALL_AO,
+		      this_ip_addr, TEST_PREFIX, test_vrf_ifindex,
+		      this_ip_addr, TEST_PREFIX, -1, 0, 100, 100,
+		      1, 1, FAULT_PREINSTALL_MD5);
+	try_to_preadd("VRF: TCP-MD5 key (no l3index) + TCP-AO key (l3index=N)",
+		      (*port)++, PREINSTALL_MD5_FIRST | PREINSTALL_AO,
+		      this_ip_addr, TEST_PREFIX, -1,
+		      this_ip_addr, TEST_PREFIX, test_vrf_ifindex, 0, 100, 100,
+		      1, 1, FAULT_PREINSTALL_AO);
+	try_to_preadd("VRF: TCP-AO key (l3index=N) + TCP-MD5 key (l3index=0)",
+		      (*port)++, PREINSTALL_MD5 | PREINSTALL_AO,
+		      this_ip_addr, TEST_PREFIX, 0,
+		      this_ip_addr, TEST_PREFIX, test_vrf_ifindex, 0, 100, 100,
+		      1, 1, 0);
+	try_to_preadd("VRF: TCP-MD5 key (l3index=0) + TCP-AO key (l3index=N)",
+		      (*port)++, PREINSTALL_MD5_FIRST | PREINSTALL_AO,
+		      this_ip_addr, TEST_PREFIX, 0,
+		      this_ip_addr, TEST_PREFIX, test_vrf_ifindex, 0, 100, 100,
+		      1, 1, 0);
+	try_to_preadd("VRF: TCP-AO key (l3index=N) + TCP-MD5 key (l3index=N)",
+		      (*port)++, PREINSTALL_MD5 | PREINSTALL_AO,
+		      this_ip_addr, TEST_PREFIX, test_vrf_ifindex,
+		      this_ip_addr, TEST_PREFIX, test_vrf_ifindex, 0, 100, 100,
+		      1, 1, FAULT_PREINSTALL_MD5);
+	try_to_preadd("VRF: TCP-MD5 key (l3index=N) + TCP-AO key (l3index=N)",
+		      (*port)++, PREINSTALL_MD5_FIRST | PREINSTALL_AO,
+		      this_ip_addr, TEST_PREFIX, test_vrf_ifindex,
+		      this_ip_addr, TEST_PREFIX, test_vrf_ifindex, 0, 100, 100,
+		      1, 1, FAULT_PREINSTALL_AO);
+}
+
+static void *client_fn(void *arg)
+{
+	unsigned int port = test_server_port;
+	union tcp_addr addr_any = {};
+
+	client_add_ips();
+
+	try_connect("AO server (INADDR_ANY): AO client", port++, NULL, 0,
+		    &addr_any, 0, 100, 100, 0, 0, 0, &this_ip_addr);
+	try_connect("AO server (INADDR_ANY): MD5 client", port++, &addr_any, 0,
+		    NULL, 0, 100, 100, 0, FAULT_TIMEOUT, 1, &this_ip_addr);
+	try_connect("AO server (INADDR_ANY): unsigned client", port++, NULL, 0,
+		    NULL, 0, 100, 100, 0, FAULT_TIMEOUT, 0, &this_ip_addr);
+	try_connect("AO server (AO_REQUIRED): AO client", port++, NULL, 0,
+		    &addr_any, 0, 100, 100, 0, 0, 0, &this_ip_addr);
+	try_connect("AO server (AO_REQUIRED): unsigned client", port++, NULL, 0,
+		    NULL, 0, 100, 100, 0, FAULT_TIMEOUT, 0, &client2);
+
+	try_connect("MD5 server (INADDR_ANY): AO client", port++, NULL, 0,
+		   &addr_any, 0, 100, 100, 0, FAULT_TIMEOUT, 1, &this_ip_addr);
+	try_connect("MD5 server (INADDR_ANY): MD5 client", port++, &addr_any, 0,
+		   NULL, 0, 100, 100, 0, 0, 1, &this_ip_addr);
+	try_connect("MD5 server (INADDR_ANY): no sign client", port++, NULL, 0,
+		   NULL, 0, 100, 100, 0, FAULT_TIMEOUT, 1, &this_ip_addr);
+
+	try_connect("no sign server: AO client", port++, NULL, 0,
+		   &addr_any, 0, 100, 100, 0, FAULT_TIMEOUT, 0, &this_ip_addr);
+	try_connect("no sign server: MD5 client", port++, &addr_any, 0,
+		   NULL, 0, 100, 100, 0, FAULT_TIMEOUT, 1, &this_ip_addr);
+	try_connect("no sign server: no sign client", port++, NULL, 0,
+		   NULL, 0, 100, 100, 0, 0, 0, &this_ip_addr);
+
+	try_connect("AO+MD5 server: AO client (matching)", port++, NULL, 0,
+		   &addr_any, 0, 100, 100, 0, 0, 1, &client2);
+	try_connect("AO+MD5 server: AO client (misconfig, matching MD5)",
+		   port++, NULL, 0, &addr_any, 0, 100, 100, 0,
+		   FAULT_TIMEOUT, 1, &this_ip_addr);
+	try_connect("AO+MD5 server: AO client (misconfig, non-matching)",
+		   port++, NULL, 0, &addr_any, 0, 100, 100, 0,
+		   FAULT_TIMEOUT, 1, &client3);
+	try_connect("AO+MD5 server: MD5 client (matching)", port++, &addr_any, 0,
+		   NULL, 0, 100, 100, 0, 0, 1, &this_ip_addr);
+	try_connect("AO+MD5 server: MD5 client (misconfig, matching AO)",
+		   port++, &addr_any, 0, NULL, 0, 100, 100, 0, FAULT_TIMEOUT,
+		   1, &client2);
+	try_connect("AO+MD5 server: MD5 client (misconfig, non-matching)",
+		   port++, &addr_any, 0, NULL, 0, 100, 100, 0, FAULT_TIMEOUT,
+		   1, &client3);
+	try_connect("AO+MD5 server: no sign client (unmatched)",
+		   port++, NULL, 0, NULL, 0, 100, 100, 0, 0, 1, &client3);
+	try_connect("AO+MD5 server: no sign client (misconfig, matching AO)",
+		   port++, NULL, 0, NULL, 0, 100, 100, 0, FAULT_TIMEOUT,
+		   1, &client2);
+	try_connect("AO+MD5 server: no sign client (misconfig, matching MD5)",
+		   port++, NULL, 0, NULL, 0, 100, 100, 0, FAULT_TIMEOUT,
+		   1, &this_ip_addr);
+
+	try_connect("AO+MD5 server: client with both [TCP-MD5] and TCP-AO keys",
+		   port++, &this_ip_addr, TEST_PREFIX,
+		   &client2, TEST_PREFIX, 100, 100, 0, FAULT_KEYREJECT,
+		   1, &this_ip_addr);
+	try_connect("AO+MD5 server: client with both TCP-MD5 and [TCP-AO] keys",
+		   port++, &this_ip_addr, TEST_PREFIX,
+		   &client2, TEST_PREFIX, 100, 100, 0, FAULT_KEYREJECT,
+		   1, &client2);
+
+	client_add_fail_tests(&port);
+	client_vrf_tests(&port);
+
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	test_init(72, server_fn, client_fn);
+	return 0;
+}

-- 
2.43.0


