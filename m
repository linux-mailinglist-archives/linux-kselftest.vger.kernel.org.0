Return-Path: <linux-kselftest+bounces-1984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF01813FF2
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 03:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64CFCB21D42
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 02:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD11D266;
	Fri, 15 Dec 2023 02:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Em/Mvw1O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB48468C
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Dec 2023 02:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40c38e292c8so702065e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 18:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1702607848; x=1703212648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twIaLqkUgpXnHQi+Wv9jh8LDthZQ5REG5q2HxCdAUNU=;
        b=Em/Mvw1OMIVLfFKZms1vFZ2lrnxh8Mj0DxNiU6TgoPWONUd32QA9HoVjcIqcHY6Pdv
         3Sd/vs2JMsHqnrp6YtXXkjIPc2x3uQTD9oabLqq/Hax8vze2/1/hOLh4pYFKRnVb4CW5
         z9VwZPH1QRrl989qSh693LW6Nt4BaNjLzMcTnJRVSxoclEfOlH1MN9OXG6l9e6yrRb6P
         lBuHtRiMpZ7q3JW3znfj+UJPwk7qH0jzYxx+DXteGwQ0MwADx+6bnsS+D4ufExYrQWCV
         3Ky9tUamhVkJ+HuPWw8jX1BfhSyfHshi56Y3L4/w0BZNPPFiQEGfBLboXvCK7mZAOFxK
         jmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702607848; x=1703212648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twIaLqkUgpXnHQi+Wv9jh8LDthZQ5REG5q2HxCdAUNU=;
        b=erf2pv3VJG4K1w2b0D3sFg9MUEDlqBukGd2Iqq5nBBvIcUC8/Npb+YyNpdUifi10Nm
         xocDWr8u4KCuqhpw+dOZKvsNw+Ff1+OtZ0VyFqimsCF42oWiac/stIUwJBypNPxKYWhZ
         QULJKLMddGUJsuZMYTSIwicfEskWFrc/mZk9T3NvDw49ZT2I4uBRu466Jl3W/lcPLcf7
         822MDpaFEXBDMgyTsrLVW/0Y3hFQtD3TebUceeCrffiNp4C/lBpsp2Xy330Rdm0aqQHK
         o2cJMNk7BOn4ssCmXScgoXami8RSOTBmEEHJo47yfgdDdBy3+Vs+QOBwxRGduLuQCnFx
         yLUA==
X-Gm-Message-State: AOJu0YyiX42lutYoofLpjdwciHE3/UwvpcUVgKesDRRCeO0KgsrXAP9F
	2L3HhIwmyYKgsXbIhMtPW1NfGA==
X-Google-Smtp-Source: AGHT+IGAX+XV9nz0VoAvcRfps1GEF8WCiL7qS0VDQZw8xyQmkOeWxDTiiKk8chyIkC7JOO4FqgywCg==
X-Received: by 2002:a05:600c:3b99:b0:40b:5e26:237b with SMTP id n25-20020a05600c3b9900b0040b5e26237bmr5376880wms.44.1702607847933;
        Thu, 14 Dec 2023 18:37:27 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id fc17-20020a05600c525100b0040c42681fcesm20096363wmb.15.2023.12.14.18.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 18:37:27 -0800 (PST)
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
Subject: [PATCH 04/12] selftests/net: Add a test for TCP-AO keys matching
Date: Fri, 15 Dec 2023 02:36:18 +0000
Message-ID: <20231215-tcp-ao-selftests-v1-4-f6c08180b985@arista.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702607832; l=11851; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=6quMnyEgj7X3QNVHQVaEpMhTsWkwDsGtUiuLgzJMxiQ=; b=waieuRu4ZABsxPf8X2VokyRwwwgWsPvGZijecp63lY9aXdToBwPHhq5sglhYv65or4fgdHq1o EsqjUUlQbdBAw+6mVHD1PGLH5a3hujEcxRkiV6LWWQMrhcYXySZJhy6
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

Add TCP-AO tests on connect()/accept() pair.
SNMP counters exposed by kernel are very useful here to verify the
expected behavior of TCP-AO.

Expected output for ipv4 version:
> # ./connect-deny_ipv4
> 1..19
> # 1702[lib/setup.c:254] rand seed 1680553689
> TAP version 13
> ok 1 Non-AO server + AO client
> ok 2 Non-AO server + AO client: counter TCPAOKeyNotFound increased 0 => 1
> ok 3 AO server + Non-AO client
> ok 4 AO server + Non-AO client: counter TCPAORequired increased 0 => 1
> ok 5 Wrong password
> ok 6 Wrong password: counter TCPAOBad increased 0 => 1
> ok 7 Wrong rcv id
> ok 8 Wrong rcv id: counter TCPAOKeyNotFound increased 1 => 2
> ok 9 Wrong snd id
> ok 10 Wrong snd id: counter TCPAOGood increased 0 => 1
> ok 11 Server: Wrong addr: counter TCPAOKeyNotFound increased 2 => 3
> ok 12 Server: Wrong addr
> ok 13 Client: Wrong addr: connect() was prevented
> ok 14 rcv id != snd id: connected
> ok 15 rcv id != snd id: counter TCPAOGood increased 1 => 3
> ok 16 Server: prefix match: connected
> ok 17 Server: prefix match: counter TCPAOGood increased 4 => 6
> ok 18 Client: prefix match: connected
> ok 19 Client: prefix match: counter TCPAOGood increased 7 => 9
> # Totals: pass:19 fail:0 xfail:0 xpass:0 skip:0 error:0

Expected output for ipv6 version:
> # ./connect-deny_ipv6
> 1..19
> # 1725[lib/setup.c:254] rand seed 1680553711
> TAP version 13
> ok 1 Non-AO server + AO client
> ok 2 Non-AO server + AO client: counter TCPAOKeyNotFound increased 0 => 1
> ok 3 AO server + Non-AO client: counter TCPAORequired increased 0 => 1
> ok 4 AO server + Non-AO client
> ok 5 Wrong password: counter TCPAOBad increased 0 => 1
> ok 6 Wrong password
> ok 7 Wrong rcv id: counter TCPAOKeyNotFound increased 1 => 2
> ok 8 Wrong rcv id
> ok 9 Wrong snd id: counter TCPAOGood increased 0 => 1
> ok 10 Wrong snd id
> ok 11 Server: Wrong addr
> ok 12 Server: Wrong addr: counter TCPAOKeyNotFound increased 2 => 3
> ok 13 Client: Wrong addr: connect() was prevented
> ok 14 rcv id != snd id: connected
> ok 15 rcv id != snd id: counter TCPAOGood increased 1 => 3
> ok 16 Server: prefix match: connected
> ok 17 Server: prefix match: counter TCPAOGood increased 5 => 7
> ok 18 Client: prefix match: connected
> ok 19 Client: prefix match: counter TCPAOGood increased 8 => 10
> # Totals: pass:19 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/tcp_ao/Makefile       |   1 +
 tools/testing/selftests/net/tcp_ao/connect-deny.c | 264 ++++++++++++++++++++++
 2 files changed, 265 insertions(+)

diff --git a/tools/testing/selftests/net/tcp_ao/Makefile b/tools/testing/selftests/net/tcp_ao/Makefile
index 7bf61b167ec5..f3b1d7f42edb 100644
--- a/tools/testing/selftests/net/tcp_ao/Makefile
+++ b/tools/testing/selftests/net/tcp_ao/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 TEST_BOTH_AF := connect
+TEST_BOTH_AF += connect-deny
 TEST_BOTH_AF += icmps-accept icmps-discard
 
 TEST_IPV4_PROGS := $(TEST_BOTH_AF:%=%_ipv4)
diff --git a/tools/testing/selftests/net/tcp_ao/connect-deny.c b/tools/testing/selftests/net/tcp_ao/connect-deny.c
new file mode 100644
index 000000000000..1ca78040d8b7
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_ao/connect-deny.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Author: Dmitry Safonov <dima@arista.com> */
+#include <inttypes.h>
+#include "aolib.h"
+
+#define fault(type)	(inj == FAULT_ ## type)
+
+static inline int test_add_key_maclen(int sk, const char *key, uint8_t maclen,
+				      union tcp_addr in_addr, uint8_t prefix,
+				      uint8_t sndid, uint8_t rcvid)
+{
+	struct tcp_ao_add tmp = {};
+	int err;
+
+	if (prefix > DEFAULT_TEST_PREFIX)
+		prefix = DEFAULT_TEST_PREFIX;
+
+	err = test_prepare_key(&tmp, DEFAULT_TEST_ALGO, in_addr, false, false,
+			       prefix, 0, sndid, rcvid, maclen,
+			       0, strlen(key), key);
+	if (err)
+		return err;
+
+	err = setsockopt(sk, IPPROTO_TCP, TCP_AO_ADD_KEY, &tmp, sizeof(tmp));
+	if (err < 0)
+		return -errno;
+
+	return test_verify_socket_key(sk, &tmp);
+}
+
+static void try_accept(const char *tst_name, unsigned int port, const char *pwd,
+		       union tcp_addr addr, uint8_t prefix,
+		       uint8_t sndid, uint8_t rcvid, uint8_t maclen,
+		       const char *cnt_name, test_cnt cnt_expected,
+		       fault_t inj)
+{
+	struct tcp_ao_counters ao_cnt1, ao_cnt2;
+	uint64_t before_cnt = 0, after_cnt = 0; /* silence GCC */
+	int lsk, err, sk = 0;
+	time_t timeout;
+
+	lsk = test_listen_socket(this_ip_addr, port, 1);
+
+	if (pwd && test_add_key_maclen(lsk, pwd, maclen, addr, prefix, sndid, rcvid))
+		test_error("setsockopt(TCP_AO_ADD_KEY)");
+
+	if (cnt_name)
+		before_cnt = netstat_get_one(cnt_name, NULL);
+	if (pwd && test_get_tcp_ao_counters(lsk, &ao_cnt1))
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
+	if (pwd && test_get_tcp_ao_counters(lsk, &ao_cnt2))
+		test_error("test_get_tcp_ao_counters()");
+
+	close(lsk);
+	if (pwd)
+		test_tcp_ao_counters_cmp(tst_name, &ao_cnt1, &ao_cnt2, cnt_expected);
+
+	if (!cnt_name)
+		goto out;
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
+
+out:
+	synchronize_threads(); /* close() */
+	if (sk > 0)
+		close(sk);
+}
+
+static void *server_fn(void *arg)
+{
+	union tcp_addr wrong_addr, network_addr;
+	unsigned int port = test_server_port;
+
+	if (inet_pton(TEST_FAMILY, TEST_WRONG_IP, &wrong_addr) != 1)
+		test_error("Can't convert ip address %s", TEST_WRONG_IP);
+
+	try_accept("Non-AO server + AO client", port++, NULL,
+		   this_ip_dest, -1, 100, 100, 0,
+		   "TCPAOKeyNotFound", 0, FAULT_TIMEOUT);
+
+	try_accept("AO server + Non-AO client", port++, DEFAULT_TEST_PASSWORD,
+		   this_ip_dest, -1, 100, 100, 0,
+		   "TCPAORequired", TEST_CNT_AO_REQUIRED, FAULT_TIMEOUT);
+
+	try_accept("Wrong password", port++, "something that is not DEFAULT_TEST_PASSWORD",
+		   this_ip_dest, -1, 100, 100, 0,
+		   "TCPAOBad", TEST_CNT_BAD, FAULT_TIMEOUT);
+
+	try_accept("Wrong rcv id", port++, DEFAULT_TEST_PASSWORD,
+		   this_ip_dest, -1, 100, 101, 0,
+		   "TCPAOKeyNotFound", TEST_CNT_AO_KEY_NOT_FOUND, FAULT_TIMEOUT);
+
+	try_accept("Wrong snd id", port++, DEFAULT_TEST_PASSWORD,
+		   this_ip_dest, -1, 101, 100, 0,
+		   "TCPAOGood", TEST_CNT_GOOD, FAULT_TIMEOUT);
+
+	try_accept("Different maclen", port++, DEFAULT_TEST_PASSWORD,
+		   this_ip_dest, -1, 100, 100, 8,
+		   "TCPAOBad", TEST_CNT_BAD, FAULT_TIMEOUT);
+
+	try_accept("Server: Wrong addr", port++, DEFAULT_TEST_PASSWORD,
+		   wrong_addr, -1, 100, 100, 0,
+		   "TCPAOKeyNotFound", TEST_CNT_AO_KEY_NOT_FOUND, FAULT_TIMEOUT);
+
+	try_accept("Client: Wrong addr", port++, NULL,
+		   this_ip_dest, -1, 100, 100, 0, NULL, 0, FAULT_TIMEOUT);
+
+	try_accept("rcv id != snd id", port++, DEFAULT_TEST_PASSWORD,
+		   this_ip_dest, -1, 200, 100, 0,
+		   "TCPAOGood", TEST_CNT_GOOD, 0);
+
+	if (inet_pton(TEST_FAMILY, TEST_NETWORK, &network_addr) != 1)
+		test_error("Can't convert ip address %s", TEST_NETWORK);
+
+	try_accept("Server: prefix match", port++, DEFAULT_TEST_PASSWORD,
+		   network_addr, 16, 100, 100, 0,
+		   "TCPAOGood", TEST_CNT_GOOD, 0);
+
+	try_accept("Client: prefix match", port++, DEFAULT_TEST_PASSWORD,
+		   this_ip_dest, -1, 100, 100, 0,
+		   "TCPAOGood", TEST_CNT_GOOD, 0);
+
+	/* client exits */
+	synchronize_threads();
+	return NULL;
+}
+
+static void try_connect(const char *tst_name, unsigned int port,
+			const char *pwd, union tcp_addr addr, uint8_t prefix,
+			uint8_t sndid, uint8_t rcvid,
+			test_cnt cnt_expected, fault_t inj)
+{
+	struct tcp_ao_counters ao_cnt1, ao_cnt2;
+	time_t timeout;
+	int sk, ret;
+
+	sk = socket(test_family, SOCK_STREAM, IPPROTO_TCP);
+	if (sk < 0)
+		test_error("socket()");
+
+	if (pwd && test_add_key(sk, pwd, addr, prefix, sndid, rcvid))
+		test_error("setsockopt(TCP_AO_ADD_KEY)");
+
+	if (pwd && test_get_tcp_ao_counters(sk, &ao_cnt1))
+		test_error("test_get_tcp_ao_counters()");
+
+	synchronize_threads(); /* preparations done */
+
+	timeout = fault(TIMEOUT) ? TEST_RETRANSMIT_SEC : TEST_TIMEOUT_SEC;
+	ret = _test_connect_socket(sk, this_ip_dest, port, timeout);
+
+	if (ret < 0) {
+		if (fault(KEYREJECT) && ret == -EKEYREJECTED) {
+			test_ok("%s: connect() was prevented", tst_name);
+		} else if (ret == -ETIMEDOUT && fault(TIMEOUT)) {
+			test_ok("%s", tst_name);
+		} else if (ret == -ECONNREFUSED &&
+				(fault(TIMEOUT) || fault(KEYREJECT))) {
+			test_ok("%s: refused to connect", tst_name);
+		} else {
+			test_error("%s: connect() returned %d", tst_name, ret);
+		}
+		goto out;
+	}
+
+	if (fault(TIMEOUT) || fault(KEYREJECT))
+		test_fail("%s: connected", tst_name);
+	else
+		test_ok("%s: connected", tst_name);
+	if (pwd && ret > 0) {
+		if (test_get_tcp_ao_counters(sk, &ao_cnt2))
+			test_error("test_get_tcp_ao_counters()");
+		test_tcp_ao_counters_cmp(tst_name, &ao_cnt1, &ao_cnt2, cnt_expected);
+	}
+out:
+	synchronize_threads(); /* close() */
+
+	if (ret > 0)
+		close(sk);
+}
+
+static void *client_fn(void *arg)
+{
+	union tcp_addr wrong_addr, network_addr;
+	unsigned int port = test_server_port;
+
+	if (inet_pton(TEST_FAMILY, TEST_WRONG_IP, &wrong_addr) != 1)
+		test_error("Can't convert ip address %s", TEST_WRONG_IP);
+
+	try_connect("Non-AO server + AO client", port++, DEFAULT_TEST_PASSWORD,
+			this_ip_dest, -1, 100, 100, 0, FAULT_TIMEOUT);
+
+	try_connect("AO server + Non-AO client", port++, NULL,
+			this_ip_dest, -1, 100, 100, 0, FAULT_TIMEOUT);
+
+	try_connect("Wrong password", port++, DEFAULT_TEST_PASSWORD,
+			this_ip_dest, -1, 100, 100, 0, FAULT_TIMEOUT);
+
+	try_connect("Wrong rcv id", port++, DEFAULT_TEST_PASSWORD,
+			this_ip_dest, -1, 100, 100, 0, FAULT_TIMEOUT);
+
+	try_connect("Wrong snd id", port++, DEFAULT_TEST_PASSWORD,
+			this_ip_dest, -1, 100, 100, 0, FAULT_TIMEOUT);
+
+	try_connect("Different maclen", port++, DEFAULT_TEST_PASSWORD,
+			this_ip_dest, -1, 100, 100, 0, FAULT_TIMEOUT);
+
+	try_connect("Server: Wrong addr", port++, DEFAULT_TEST_PASSWORD,
+			this_ip_dest, -1, 100, 100, 0, FAULT_TIMEOUT);
+
+	try_connect("Client: Wrong addr", port++, DEFAULT_TEST_PASSWORD,
+			wrong_addr, -1, 100, 100, 0, FAULT_KEYREJECT);
+
+	try_connect("rcv id != snd id", port++, DEFAULT_TEST_PASSWORD,
+			this_ip_dest, -1, 100, 200, TEST_CNT_GOOD, 0);
+
+	if (inet_pton(TEST_FAMILY, TEST_NETWORK, &network_addr) != 1)
+		test_error("Can't convert ip address %s", TEST_NETWORK);
+
+	try_connect("Server: prefix match", port++, DEFAULT_TEST_PASSWORD,
+			this_ip_dest, -1, 100, 100, TEST_CNT_GOOD, 0);
+
+	try_connect("Client: prefix match", port++, DEFAULT_TEST_PASSWORD,
+			network_addr, 16, 100, 100, TEST_CNT_GOOD, 0);
+
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	test_init(21, server_fn, client_fn);
+	return 0;
+}

-- 
2.43.0


