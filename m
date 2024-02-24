Return-Path: <linux-kselftest+bounces-5411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F15EF8623AF
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 10:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E3B4B23059
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 09:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA5547A5D;
	Sat, 24 Feb 2024 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="YVaBz+RL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5FE4597F
	for <linux-kselftest@vger.kernel.org>; Sat, 24 Feb 2024 09:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708765504; cv=none; b=SzeM2SvLeanh0I61/kT2oF6HS1K+DBcOb1MsgUm17JbGpeFXNG4VAv7sxV2JhVniM3DbMOH3Z9m0xZa5z33q0R0S3b8eADY6aoKp+n6crB9tnnXfPV6h4Oap50fOaV03E8RxMLKhiB6e5INAgdAZPtGY8vDX8zQPxqwyzMbbsQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708765504; c=relaxed/simple;
	bh=8AUpEOT88u/8zRD9q6ic9a6ef0BcUKnt4ik9VKTAhE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RG27VnW1nLVAYDUcVljQyXhrHb6hxL5Yjjvb54oCbRunLHozOZJfkJrZBWmKkfogXi6nff7Wt9bapG2G/RThkgeDwsZZWbTNSYJfoqZDOkFqpi7u+Lms4KHTB72LchJNtMSSWXtX4znNk8gFpGtTFl2zTFLdT6l+RLxOLEuggMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=YVaBz+RL; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41298159608so4365285e9.0
        for <linux-kselftest@vger.kernel.org>; Sat, 24 Feb 2024 01:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1708765499; x=1709370299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcJhh022VDfxpiDKm7FqqnzrMHW/udPkKTDf9bA9ocg=;
        b=YVaBz+RLySZjTCd6rciPb52K1JcSqKX/AieRSjC/6QHGj7J6LmhJvejiTONKho4xEA
         nAbfMsWEaIo0CTtI4hDXS+7VkjSmm+YK0WbKC4HAZpDrmizPhOYml0aYTRKo+8ImqnrL
         vhuzRSqOLheUyCJ8UmXAiyCeFqFwuhV3e3mC9OSX0WhmYhSvzuz5ehy4yVFGxmK3m/Yu
         kzxgxLthTjdPqxQL6aOiQPeCts76ZHP/rnbRaWCEb7Q87Mvd180omPk8ouiS8Zfz9aqF
         ZY2kdEqRjIm49qIgxtBK2KafEcHHNRTbr1p6JS6Dv6VQL2LeQQ1hEnoMRjvobwa8CU1B
         9V+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708765499; x=1709370299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcJhh022VDfxpiDKm7FqqnzrMHW/udPkKTDf9bA9ocg=;
        b=NAsTYsLLxmrKUAo2ocwhaXon7hPy6tALMoCyy0/aM58h3oamwS92QGEM8Hht3xhkCJ
         XLH7cUGi4wuOEOXli/br8PxDns/1XIXLgEXGaACJVXcXHPJe4Ka0yK5mPRbwxE7DrTuH
         afsezMkAL/Y83Bv0aYSqZelufT+30GxvlXH8c0GYHvk1juT8+4coA8tG6Yc/pj6KRX8R
         rjF9FxnW2BoH0yM8sOaxpuCJZ7JW5CHyvspDD2FfLgOsl9LrsL1IOPyg0YlF34gtVOye
         E2n0+llr35Hbq2VdWpYDHwwcsHnKqsCI9nqUIiIYgZRlErg/OMfbgUwwfFHd513U1SPX
         uUQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvWO899jz6EojiHZVBEihxjObIzNXgfFIwraTYLBTg4Ui+4pb1T+t5Vzt/UAvU9ckVa+3j+KYYgS7EoPR920TZFn244ceT2MbtJygkuPbI
X-Gm-Message-State: AOJu0YzHiJgbRdp38dcpaAG7PQ2H7QYYg67Pnhdi18dxwxlt9cGRMP6s
	h5JhJsi/2Qlfqyihvk1CTNYU8GwXdJmeYiYKsP7LnH7d7S/O1qDWZP1p6/l7PQ==
X-Google-Smtp-Source: AGHT+IHt1rprcHHpmFeXPeNc/wCHRlA6KUWRllUypQdOgWrHMYxT1v0jfoSLSMRQ65oZnChyI5SXjQ==
X-Received: by 2002:a05:600c:1992:b0:412:9c2a:7622 with SMTP id t18-20020a05600c199200b004129c2a7622mr802476wmq.8.1708765498917;
        Sat, 24 Feb 2024 01:04:58 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bce06000000b00410bca333b7sm5320593wmc.27.2024.02.24.01.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 01:04:58 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dmitry Safonov <dima@arista.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [PATCH net-next 10/10] selftest/net: Add trace events matching to tcp_ao
Date: Sat, 24 Feb 2024 09:04:18 +0000
Message-ID: <20240224-tcp-ao-tracepoints-v1-10-15f31b7f30a7@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com>
References: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708765347; l=47733; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=8AUpEOT88u/8zRD9q6ic9a6ef0BcUKnt4ik9VKTAhE4=; b=JPfTlnGbkTJiMQsclOIwor9e9YUve7lHfH48SzSE64v0+3JRWz6FN3DX1AvasUnHOBGKKDyIH MYu+qgrutP2DvCoVkWhkvvkWD1JAPES1Gk5h9n1VcG+oOKb5ESFTQEX
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

Setup trace points, add a new ftrace instance in order to not interfere
with the rest of the system, filtering by net namespace cookies.
Raise a new background thread that parses trace_pipe, matches them with
the list of expected events.

Wiring up trace events to selftests provides another insight if there is
anything unexpected happining in the tcp-ao code (i.e. key rotation when
it's not expected).

Note: in real programs libtraceevent should be used instead of this
manual labor of setting ftrace up and parsing. I'm not using it here
as I don't want to have an .so library dependency that one would have to
bring into VM or DUT (Device Under Test). Please, don't copy it over
into any real world programs, that aren't tests.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/tcp_ao/Makefile        |   2 +-
 tools/testing/selftests/net/tcp_ao/bench-lookups.c |   2 +-
 tools/testing/selftests/net/tcp_ao/connect-deny.c  |  18 +-
 tools/testing/selftests/net/tcp_ao/connect.c       |   2 +-
 tools/testing/selftests/net/tcp_ao/icmps-discard.c |   2 +-
 .../testing/selftests/net/tcp_ao/key-management.c  |  18 +-
 tools/testing/selftests/net/tcp_ao/lib/aolib.h     |  94 +++
 tools/testing/selftests/net/tcp_ao/lib/ftrace.c    | 846 +++++++++++++++++++++
 tools/testing/selftests/net/tcp_ao/lib/kconfig.c   |   8 +
 tools/testing/selftests/net/tcp_ao/lib/setup.c     |   2 +-
 tools/testing/selftests/net/tcp_ao/lib/utils.c     |  26 +
 tools/testing/selftests/net/tcp_ao/restore.c       |  18 +-
 tools/testing/selftests/net/tcp_ao/rst.c           |   2 +-
 tools/testing/selftests/net/tcp_ao/self-connect.c  |  19 +-
 tools/testing/selftests/net/tcp_ao/seq-ext.c       |  10 +-
 .../selftests/net/tcp_ao/setsockopt-closed.c       |   2 +-
 tools/testing/selftests/net/tcp_ao/unsigned-md5.c  |  28 +-
 17 files changed, 1081 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/Makefile b/tools/testing/selftests/net/tcp_ao/Makefile
index 522d991e310e..2df0e4607ae5 100644
--- a/tools/testing/selftests/net/tcp_ao/Makefile
+++ b/tools/testing/selftests/net/tcp_ao/Makefile
@@ -31,7 +31,7 @@ CFLAGS	+= $(KHDR_INCLUDES)
 CFLAGS	+= -iquote ./lib/ -I ../../../../include/
 
 # Library
-LIBSRC	:= kconfig.c netlink.c proc.c repair.c setup.c sock.c utils.c
+LIBSRC	:= ftrace.c kconfig.c netlink.c proc.c repair.c setup.c sock.c utils.c
 LIBOBJ	:= $(LIBSRC:%.c=$(LIBDIR)/%.o)
 EXTRA_CLEAN += $(LIBOBJ) $(LIB)
 
diff --git a/tools/testing/selftests/net/tcp_ao/bench-lookups.c b/tools/testing/selftests/net/tcp_ao/bench-lookups.c
index a1e6e007c291..6736484996a3 100644
--- a/tools/testing/selftests/net/tcp_ao/bench-lookups.c
+++ b/tools/testing/selftests/net/tcp_ao/bench-lookups.c
@@ -355,6 +355,6 @@ static void *client_fn(void *arg)
 
 int main(int argc, char *argv[])
 {
-	test_init(30, server_fn, client_fn);
+	test_init(31, server_fn, client_fn);
 	return 0;
 }
diff --git a/tools/testing/selftests/net/tcp_ao/connect-deny.c b/tools/testing/selftests/net/tcp_ao/connect-deny.c
index 185a2f6e5ff3..cfe2501c0dfe 100644
--- a/tools/testing/selftests/net/tcp_ao/connect-deny.c
+++ b/tools/testing/selftests/net/tcp_ao/connect-deny.c
@@ -212,30 +212,44 @@ static void try_connect(const char *tst_name, unsigned int port,
 
 static void *client_fn(void *arg)
 {
-	union tcp_addr wrong_addr, network_addr;
+	union tcp_addr wrong_addr, network_addr, addr_any = {};
 	unsigned int port = test_server_port;
 
 	if (inet_pton(TEST_FAMILY, TEST_WRONG_IP, &wrong_addr) != 1)
 		test_error("Can't convert ip address %s", TEST_WRONG_IP);
 
+	trace_ao_event_expect(TCP_AO_KEY_NOT_FOUND, this_ip_addr, this_ip_dest,
+			      -1, port, 0, 0, 1, 0, 0, 0, 100, 100, -1);
 	try_connect("Non-AO server + AO client", port++, DEFAULT_TEST_PASSWORD,
 			this_ip_dest, -1, 100, 100, 0, FAULT_TIMEOUT);
 
+	trace_hash_event_expect(TCP_HASH_AO_REQUIRED, this_ip_addr, this_ip_dest,
+				-1, port, 0, 0, 1, 0, 0, 0);
 	try_connect("AO server + Non-AO client", port++, NULL,
 			this_ip_dest, -1, 100, 100, 0, FAULT_TIMEOUT);
 
+	trace_ao_event_expect(TCP_AO_MISMATCH, this_ip_addr, this_ip_dest,
+			      -1, port, 0, 0, 1, 0, 0, 0, 100, 100, -1);
 	try_connect("Wrong password", port++, DEFAULT_TEST_PASSWORD,
 			this_ip_dest, -1, 100, 100, 0, FAULT_TIMEOUT);
 
+	trace_ao_event_expect(TCP_AO_KEY_NOT_FOUND, this_ip_addr, this_ip_dest,
+			      -1, port, 0, 0, 1, 0, 0, 0, 100, 100, -1);
 	try_connect("Wrong rcv id", port++, DEFAULT_TEST_PASSWORD,
 			this_ip_dest, -1, 100, 100, 0, FAULT_TIMEOUT);
 
+	trace_ao_event_sk_expect(TCP_AO_SYNACK_NO_KEY, this_ip_dest, addr_any,
+				 port, 0, 100, 100);
 	try_connect("Wrong snd id", port++, DEFAULT_TEST_PASSWORD,
 			this_ip_dest, -1, 100, 100, 0, FAULT_TIMEOUT);
 
+	trace_ao_event_expect(TCP_AO_WRONG_MACLEN, this_ip_addr, this_ip_dest,
+			      -1, port, 0, 0, 1, 0, 0, 0, 100, 100, -1);
 	try_connect("Different maclen", port++, DEFAULT_TEST_PASSWORD,
 			this_ip_dest, -1, 100, 100, 0, FAULT_TIMEOUT);
 
+	trace_ao_event_expect(TCP_AO_KEY_NOT_FOUND, this_ip_addr, this_ip_dest,
+			      -1, port, 0, 0, 1, 0, 0, 0, 100, 100, -1);
 	try_connect("Server: Wrong addr", port++, DEFAULT_TEST_PASSWORD,
 			this_ip_dest, -1, 100, 100, 0, FAULT_TIMEOUT);
 
@@ -259,6 +273,6 @@ static void *client_fn(void *arg)
 
 int main(int argc, char *argv[])
 {
-	test_init(21, server_fn, client_fn);
+	test_init(22, server_fn, client_fn);
 	return 0;
 }
diff --git a/tools/testing/selftests/net/tcp_ao/connect.c b/tools/testing/selftests/net/tcp_ao/connect.c
index 81653b47f303..05dc5efc37c1 100644
--- a/tools/testing/selftests/net/tcp_ao/connect.c
+++ b/tools/testing/selftests/net/tcp_ao/connect.c
@@ -85,6 +85,6 @@ static void *client_fn(void *arg)
 
 int main(int argc, char *argv[])
 {
-	test_init(1, server_fn, client_fn);
+	test_init(2, server_fn, client_fn);
 	return 0;
 }
diff --git a/tools/testing/selftests/net/tcp_ao/icmps-discard.c b/tools/testing/selftests/net/tcp_ao/icmps-discard.c
index d69bcba3c929..a1614f0d8c44 100644
--- a/tools/testing/selftests/net/tcp_ao/icmps-discard.c
+++ b/tools/testing/selftests/net/tcp_ao/icmps-discard.c
@@ -444,6 +444,6 @@ static void *client_fn(void *arg)
 
 int main(int argc, char *argv[])
 {
-	test_init(3, server_fn, client_fn);
+	test_init(4, server_fn, client_fn);
 	return 0;
 }
diff --git a/tools/testing/selftests/net/tcp_ao/key-management.c b/tools/testing/selftests/net/tcp_ao/key-management.c
index 24e62120b792..d4385b52c10b 100644
--- a/tools/testing/selftests/net/tcp_ao/key-management.c
+++ b/tools/testing/selftests/net/tcp_ao/key-management.c
@@ -965,7 +965,7 @@ static void end_client(const char *tst_name, int sk, unsigned int nr_keys,
 	synchronize_threads(); /* 5: counters */
 }
 
-static void try_unmatched_keys(int sk, int *rnext_index)
+static void try_unmatched_keys(int sk, int *rnext_index, unsigned int port)
 {
 	struct test_key *key;
 	unsigned int i = 0;
@@ -1013,6 +1013,9 @@ static void try_unmatched_keys(int sk, int *rnext_index)
 		test_error("all keys on server match the client");
 	if (test_set_key(sk, -1, key->server_keyid))
 		test_error("Can't change the current key");
+	trace_ao_event_expect(TCP_AO_RNEXT_REQUEST, this_ip_addr, this_ip_dest,
+			      -1, port, 0, -1, -1, -1, -1, -1,
+			      -1, key->server_keyid, -1);
 	if (test_client_verify(sk, msg_len, nr_packets, TEST_TIMEOUT_SEC))
 		test_fail("verify failed");
 	*rnext_index = i;
@@ -1054,6 +1057,10 @@ static void check_current_back(const char *tst_name, unsigned int port,
 		return;
 	if (test_set_key(sk, collection.keys[rotate_to_index].client_keyid, -1))
 		test_error("Can't change the current key");
+	trace_ao_event_expect(TCP_AO_RNEXT_REQUEST, this_ip_dest, this_ip_addr,
+			      port, -1, 0, -1, -1, -1, -1, -1,
+			      collection.keys[rotate_to_index].client_keyid,
+			      collection.keys[current_index].client_keyid, -1);
 	if (test_client_verify(sk, msg_len, nr_packets, TEST_TIMEOUT_SEC))
 		test_fail("verify failed");
 	/* There is a race here: between setting the current_key with
@@ -1085,6 +1092,11 @@ static void roll_over_keys(const char *tst_name, unsigned int port,
 	for (i = rnext_index + 1; rotations > 0; i++, rotations--) {
 		if (i >= collection.nr_keys)
 			i = 0;
+		trace_ao_event_expect(TCP_AO_RNEXT_REQUEST,
+				this_ip_addr, this_ip_dest,
+				-1, port, 0, -1, -1, -1, -1, -1,
+				i == 0 ? -1 : collection.keys[i - 1].server_keyid,
+				collection.keys[i].server_keyid, -1);
 		if (test_set_key(sk, -1, collection.keys[i].server_keyid))
 			test_error("Can't change the Rnext key");
 		if (test_client_verify(sk, msg_len, nr_packets, TEST_TIMEOUT_SEC)) {
@@ -1124,7 +1136,7 @@ static void try_client_match(const char *tst_name, unsigned int port,
 				 rnext_index, msg_len, nr_packets);
 	if (sk < 0)
 		return;
-	try_unmatched_keys(sk, &rnext_index);
+	try_unmatched_keys(sk, &rnext_index, port);
 	end_client(tst_name, sk, nr_keys, current_index, rnext_index, NULL);
 }
 
@@ -1181,6 +1193,6 @@ static void *client_fn(void *arg)
 
 int main(int argc, char *argv[])
 {
-	test_init(120, server_fn, client_fn);
+	test_init(121, server_fn, client_fn);
 	return 0;
 }
diff --git a/tools/testing/selftests/net/tcp_ao/lib/aolib.h b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
index fdf44d176e0b..e19974df3193 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/aolib.h
+++ b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
@@ -145,6 +145,7 @@ enum test_needs_kconfig {
 	KCONFIG_TCP_AO,			/* required */
 	KCONFIG_TCP_MD5,		/* optional, for TCP-MD5 features */
 	KCONFIG_NET_VRF,		/* optional, for L3/VRF testing */
+	KCONFIG_FTRACE,			/* optional, for tracepoints checks */
 	__KCONFIG_LAST__
 };
 extern bool kernel_config_has(enum test_needs_kconfig k);
@@ -184,6 +185,8 @@ static inline void test_init2(unsigned int ntests,
 	__test_init(ntests, family, prefix, taddr1, taddr2, peer1, peer2);
 }
 extern void test_add_destructor(void (*d)(void));
+extern void test_init_ftrace(int nsfd1, int nsfd2);
+extern int test_setup_tracing(void);
 
 /* To adjust optmem socket limit, approximately estimate a number,
  * that is bigger than sizeof(struct tcp_ao_key).
@@ -258,12 +261,17 @@ static inline void test_init(unsigned int ntests,
 }
 extern void synchronize_threads(void);
 extern void switch_ns(int fd);
+extern int switch_save_ns(int fd);
+extern void switch_close_ns(int fd);
 
 extern __thread union tcp_addr this_ip_addr;
 extern __thread union tcp_addr this_ip_dest;
 extern int test_family;
 
 extern void randomize_buffer(void *buf, size_t buflen);
+__attribute__((__format__(__printf__, 3, 4)))
+extern int test_echo(const char *fname, bool append, const char *fmt, ...);
+
 extern int open_netns(void);
 extern int unshare_open_netns(void);
 extern const char veth_name[];
@@ -644,4 +652,90 @@ static inline int test_add_repaired_key(int sk,
 	return test_verify_socket_key(sk, &tmp);
 }
 
+enum trace_events {
+	/* TCP_HASH_EVENT */
+	TCP_HASH_BAD_HEADER = 0,
+	TCP_HASH_MD5_REQUIRED,
+	TCP_HASH_MD5_UNEXPECTED,
+	TCP_HASH_MD5_MISMATCH,
+	TCP_HASH_AO_REQUIRED,
+	/* TCP_AO_EVENT */
+	TCP_AO_HANDSHAKE_FAILURE,
+	TCP_AO_WRONG_MACLEN,
+	TCP_AO_MISMATCH,
+	TCP_AO_KEY_NOT_FOUND,
+	TCP_AO_RNEXT_REQUEST,
+	/* TCP_AO_EVENT_SK */
+	TCP_AO_SYNACK_NO_KEY,
+	/* TCP_AO_EVENT_SNE */
+	TCP_AO_SND_SNE_UPDATE,
+	TCP_AO_RCV_SNE_UPDATE,
+	__MAX_TRACE_EVENTS
+};
+extern int __trace_event_expect(enum trace_events type, int family,
+				union tcp_addr src, union tcp_addr dst,
+				int src_port, int dst_port, int L3index,
+				int fin, int syn, int rst, int psh, int ack,
+				int keyid, int rnext, int maclen, int sne);
+
+static inline void trace_hash_event_expect(enum trace_events type,
+				union tcp_addr src, union tcp_addr dst,
+				int src_port, int dst_port, int L3index,
+				int fin, int syn, int rst, int psh, int ack)
+{
+	int err;
+
+	err = __trace_event_expect(type, TEST_FAMILY, src, dst,
+				   src_port, dst_port, L3index,
+				   fin, syn, rst, psh, ack,
+				   -1, -1, -1, -1);
+	if (err)
+		test_error("Couldn't add a trace event: %d", err);
+}
+
+static inline void trace_ao_event_expect(enum trace_events type,
+				union tcp_addr src, union tcp_addr dst,
+				int src_port, int dst_port, int L3index,
+				int fin, int syn, int rst, int psh, int ack,
+				int keyid, int rnext, int maclen)
+{
+	int err;
+
+	err = __trace_event_expect(type, TEST_FAMILY, src, dst,
+				   src_port, dst_port, L3index,
+				   fin, syn, rst, psh, ack,
+				   keyid, rnext, maclen, -1);
+	if (err)
+		test_error("Couldn't add a trace event: %d", err);
+}
+
+static inline void trace_ao_event_sk_expect(enum trace_events type,
+				union tcp_addr src, union tcp_addr dst,
+				int src_port, int dst_port,
+				int keyid, int rnext)
+{
+	int err;
+
+	err = __trace_event_expect(type, TEST_FAMILY, src, dst,
+				   src_port, dst_port, -1,
+				   -1, -1, -1, -1, -1,
+				   keyid, rnext, -1, -1);
+	if (err)
+		test_error("Couldn't add a trace event: %d", err);
+}
+
+static inline void trace_ao_event_sne_expect(enum trace_events type,
+				union tcp_addr src, union tcp_addr dst,
+				int src_port, int dst_port, int sne)
+{
+	int err;
+
+	err = __trace_event_expect(type, TEST_FAMILY, src, dst,
+				   src_port, dst_port, -1,
+				   -1, -1, -1, -1, -1,
+				   -1, -1, -1, sne);
+	if (err)
+		test_error("Couldn't add a trace event: %d", err);
+}
+
 #endif /* _AOLIB_H_ */
diff --git a/tools/testing/selftests/net/tcp_ao/lib/ftrace.c b/tools/testing/selftests/net/tcp_ao/lib/ftrace.c
new file mode 100644
index 000000000000..67cb3849ad0e
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_ao/lib/ftrace.c
@@ -0,0 +1,846 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <inttypes.h>
+#include <pthread.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/mount.h>
+#include <unistd.h>
+#include "../../../../../include/linux/kernel.h"
+#include "aolib.h"
+
+static const size_t buffer_size_kb = 10000;
+static char ftrace_path_fmt[] = "ksft-ftrace-XXXXXX";
+static char instance_path_fmt[] = "ksft-XXXXXX";
+static char *ftrace_path, *instance_path;
+static bool ftrace_mounted;
+static uint64_t ns_cookie1, ns_cookie2;
+static pthread_t tracer_thread;
+static bool tracer_thread_created;
+static bool tracing_was_dead;
+
+static const char *trace_event_names[__MAX_TRACE_EVENTS] = {
+	/* TCP_HASH_EVENT */
+	"tcp_hash_bad_header",
+	"tcp_hash_md5_required",
+	"tcp_hash_md5_unexpected",
+	"tcp_hash_md5_mismatch",
+	"tcp_hash_ao_required",
+	/* TCP_AO_EVENT */
+	"tcp_ao_handshake_failure",
+	"tcp_ao_wrong_maclen",
+	"tcp_ao_mismatch",
+	"tcp_ao_key_not_found",
+	"tcp_ao_rnext_request",
+	/* TCP_AO_EVENT_SK */
+	"tcp_ao_synack_no_key",
+	/* TCP_AO_EVENT_SNE */
+	"tcp_ao_snd_sne_update",
+	"tcp_ao_rcv_sne_update"
+};
+
+struct expected_trace_point {
+	/* required */
+	enum trace_events type;
+	int family;
+	union tcp_addr src;
+	union tcp_addr dst;
+
+	/* optional */
+	int src_port;
+	int dst_port;
+	int L3index;
+
+	int fin;
+	int syn;
+	int rst;
+	int psh;
+	int ack;
+
+	int keyid;
+	int rnext;
+	int maclen;
+	int sne;
+
+	size_t matched;
+};
+
+static struct expected_trace_point *exp_tps;
+static size_t exp_tps_nr;
+static size_t exp_tps_size;
+static pthread_mutex_t exp_tps_mutex = PTHREAD_MUTEX_INITIALIZER;
+
+int __trace_event_expect(enum trace_events type, int family,
+			 union tcp_addr src, union tcp_addr dst,
+			 int src_port, int dst_port, int L3index,
+			 int fin, int syn, int rst, int psh, int ack,
+			 int keyid, int rnext, int maclen, int sne)
+{
+	struct expected_trace_point new_tp = {
+		.type		= type,
+		.family		= family,
+		.src		= src,
+		.dst		= dst,
+		.src_port	= src_port,
+		.dst_port	= dst_port,
+		.L3index	= L3index,
+		.fin		= fin,
+		.syn		= syn,
+		.rst		= rst,
+		.psh		= psh,
+		.ack		= ack,
+		.keyid		= keyid,
+		.rnext		= rnext,
+		.maclen		= maclen,
+		.sne		= sne,
+		.matched	= 0,
+	};
+	int ret = 0;
+
+	if (!kernel_config_has(KCONFIG_FTRACE))
+		return 0;
+
+	pthread_mutex_lock(&exp_tps_mutex);
+	if (exp_tps_nr == exp_tps_size) {
+		struct expected_trace_point *tmp;
+
+		if (exp_tps_size == 0)
+			exp_tps_size = 10;
+		else
+			exp_tps_size = exp_tps_size * 1.6;
+
+		tmp = reallocarray(exp_tps, exp_tps_size, sizeof(exp_tps[0]));
+		if (!tmp) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		exp_tps = tmp;
+	}
+	exp_tps[exp_tps_nr] = new_tp;
+	exp_tps_nr++;
+out:
+	pthread_mutex_unlock(&exp_tps_mutex);
+	return ret;
+}
+
+static size_t how_many_matched(void)
+{
+	size_t i, ret = 0;
+
+	/* We're from the process destructor - not taking the mutex */
+	for (i = 0; i < exp_tps_nr; i++)
+		ret += exp_tps[i].matched;
+	return ret;
+}
+
+static void free_expected_events(void)
+{
+	/* We're from the process destructor - not taking the mutex */
+	exp_tps_size = 0;
+	exp_tps = NULL;
+	free(exp_tps);
+}
+
+struct trace_point {
+	int family;
+	union tcp_addr src;
+	union tcp_addr dst;
+	unsigned int src_port;
+	unsigned int dst_port;
+	int L3index;
+	unsigned int fin:1,
+		     syn:1,
+		     rst:1,
+		     psh:1,
+		     ack:1;
+
+	unsigned keyid;
+	unsigned rnext;
+	unsigned maclen;
+
+	unsigned sne;
+};
+
+static bool lookup_expected_event(int event_type, struct trace_point *e)
+{
+	size_t i;
+
+	pthread_mutex_lock(&exp_tps_mutex);
+	for (i = 0; i < exp_tps_nr; i++) {
+		struct expected_trace_point *p = &exp_tps[i];
+		size_t sk_size;
+
+		if (p->type != event_type)
+			continue;
+		if (p->family != e->family)
+			continue;
+		if (p->family == AF_INET)
+			sk_size = sizeof(p->src.a4);
+		else
+			sk_size = sizeof(p->src.a6);
+		if (memcmp(&p->src, &e->src, sk_size))
+			continue;
+		if (memcmp(&p->dst, &e->dst, sk_size))
+			continue;
+		if (p->src_port >= 0 && p->src_port != e->src_port)
+			continue;
+		if (p->dst_port >= 0 && p->dst_port != e->dst_port)
+			continue;
+		if (p->L3index >= 0 && p->L3index != e->L3index)
+			continue;
+
+		if (p->fin >= 0 && p->fin != e->fin)
+			continue;
+		if (p->syn >= 0 && p->syn != e->syn)
+			continue;
+		if (p->rst >= 0 && p->rst != e->rst)
+			continue;
+		if (p->psh >= 0 && p->psh != e->psh)
+			continue;
+		if (p->ack >= 0 && p->ack != e->ack)
+			continue;
+
+		if (p->keyid >= 0 && p->keyid != e->keyid)
+			continue;
+		if (p->rnext >= 0 && p->rnext != e->rnext)
+			continue;
+		if (p->maclen >= 0 && p->maclen != e->maclen)
+			continue;
+		if (p->sne >= 0 && p->sne != e->sne)
+			continue;
+		p->matched++;
+		pthread_mutex_unlock(&exp_tps_mutex);
+		return true;
+	}
+	pthread_mutex_unlock(&exp_tps_mutex);
+	return false;
+}
+
+static int mount_ftrace(void)
+{
+	ftrace_path = mkdtemp(ftrace_path_fmt);
+	if (!ftrace_path)
+		test_error("Can't create temp dir");
+
+	if (mount("tracefs", ftrace_path, "tracefs", 0, "rw"))
+		return -errno;
+
+	ftrace_mounted = true;
+
+	return 0;
+}
+
+static void unmount_ftrace(void)
+{
+	if (!ftrace_path)
+		return;
+
+	if (ftrace_mounted && umount(ftrace_path))
+		test_print("Failed on cleanup: can't unmount tracefs: %m");
+
+	if (rmdir(ftrace_path))
+		test_error("Failed on cleanup: can't remove ftrace dir %s",
+			   ftrace_path);
+}
+
+struct opts_list_t {
+	char *opt_name;
+	struct opts_list_t *next;
+};
+
+static int adjust_trace_options(const char *ftrace_path)
+{
+	struct opts_list_t *opts_list = NULL;
+	char *fopts, *line = NULL;
+	size_t buf_len = 0;
+	ssize_t line_len;
+	int ret = 0;
+	FILE *opts;
+
+	fopts = test_sprintf("%s/%s", ftrace_path, "trace_options");
+	if (!fopts)
+		return -ENOMEM;
+
+	opts = fopen(fopts, "r+");
+	if (opts == NULL) {
+		ret = -errno;
+		goto out_free;
+	}
+
+	while ((line_len = getline(&line, &buf_len, opts)) != -1) {
+		struct opts_list_t *tmp;
+
+		if (!strncmp(line, "no", 2))
+			continue;
+
+		/* XXX: fix show_tcp_state_name() with "nohash-ptr" */
+		if (!strncmp(line, "hash-ptr", 8))
+			continue;
+
+		tmp = malloc(sizeof(*tmp));
+		if (!tmp) {
+			ret = -ENOMEM;
+			goto out_free_opts_list;
+		}
+		tmp->next = opts_list;
+		tmp->opt_name = test_sprintf("no%s", line);
+		if (!tmp->opt_name) {
+			ret = -ENOMEM;
+			free(tmp);
+			goto out_free_opts_list;
+		}
+		opts_list = tmp;
+	}
+
+	while (opts_list) {
+		struct opts_list_t *tmp = opts_list;
+
+		fseek(opts, 0, SEEK_SET);
+		fwrite(tmp->opt_name, 1, strlen(tmp->opt_name), opts);
+
+		opts_list = opts_list->next;
+		free(tmp->opt_name);
+		free(tmp);
+	}
+
+out_free_opts_list:
+	while (opts_list) {
+		struct opts_list_t *tmp = opts_list;
+
+		opts_list = opts_list->next;
+		free(tmp->opt_name);
+		free(tmp);
+	}
+	free(line);
+	fclose(opts);
+out_free:
+	free(fopts);
+	return ret;
+}
+
+static int setup_buffer_size(const char *ftrace_path, size_t sz)
+{
+	char *fbuf_size = test_sprintf("%s/buffer_size_kb", ftrace_path);
+	int ret;
+
+	if (!fbuf_size)
+		return -1;
+
+	ret = test_echo(fbuf_size, 0, "%zu", sz);
+	free(fbuf_size);
+	return ret;
+}
+
+static int setup_ftrace_instance(void)
+{
+	char *tmp;
+
+	tmp = test_sprintf("%s/instances/%s", ftrace_path, instance_path_fmt);
+	if (!tmp)
+		return -ENOMEM;
+
+	instance_path = mkdtemp(tmp);
+	if (!instance_path) {
+		free(tmp);
+		return -errno;
+	}
+
+	adjust_trace_options(instance_path);
+	setup_buffer_size(instance_path, buffer_size_kb);
+
+	/* instance_path has tmp and gets freed in remove_ftrace_instance() */
+	return 0;
+}
+
+static void remove_ftrace_instance(void)
+{
+	if (!instance_path)
+		return;
+	if (rmdir(instance_path))
+		test_print("Failed on cleanup: can't remove ftrace instance %s",
+			   instance_path);
+	free(instance_path);
+}
+
+struct trace_events_list {
+	char *line;
+	struct trace_events_list *next;
+};
+static struct trace_events_list *unexpected_events;
+
+static int check_event_type(const char *line)
+{
+	size_t i;
+
+	/*
+	 * This should have been a set or hashmap, but it's a selftest,
+	 * so... KISS.
+	 */
+	for (i = 0; i < __MAX_TRACE_EVENTS; i++) {
+		if (!strncmp(trace_event_names[i], line, strlen(trace_event_names[i])))
+			return i;
+	}
+	return -1;
+}
+
+static bool event_has_flags(enum trace_events event)
+{
+	switch (event) {
+	case TCP_HASH_BAD_HEADER:
+	case TCP_HASH_MD5_REQUIRED:
+	case TCP_HASH_MD5_UNEXPECTED:
+	case TCP_HASH_MD5_MISMATCH:
+	case TCP_HASH_AO_REQUIRED:
+	case TCP_AO_HANDSHAKE_FAILURE:
+	case TCP_AO_WRONG_MACLEN:
+	case TCP_AO_MISMATCH:
+	case TCP_AO_KEY_NOT_FOUND:
+	case TCP_AO_RNEXT_REQUEST:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int tracer_ip_split(int family, char *src, char **addr, char **port)
+{
+	char *p;
+
+	if (family == AF_INET) {
+		/* fomat is <addr>:port, i.e.: 10.0.254.1:7015 */
+		*addr = src;
+		p = strchr(src, ':');
+		if (p == NULL) {
+			test_print("Couldn't parse trace event addr:port %s", src);
+			return -EINVAL;
+		}
+		*p++ = '\0';
+		*port = p;
+		return 0;
+	}
+	if (family != AF_INET6)
+		return -EAFNOSUPPORT;
+
+	/* format is [<addr>]:port, i.e.: [2001:db8:254::1]:7013 */
+	*addr = strchr(src, '[');
+	p = strchr(src, ']');
+
+	if (p == NULL || *addr == NULL) {
+		test_print("Couldn't parse trace event [addr]:port %s", src);
+		return -EINVAL;
+	}
+
+	*addr = *addr + 1;	/* '[' */
+	*p++ = '\0';		/* ']' */
+	if (*p != ':') {
+		test_print("Couldn't parse trace event :port %s", p);
+		return -EINVAL;
+	}
+	*p++ = '\0';		/* ':' */
+	*port = p;
+	return 0;
+}
+
+static int tracer_scan_address(int family, char *src,
+			       union tcp_addr *dst, unsigned int *port)
+{
+	char *addr, *port_str;
+	int ret;
+
+	ret = tracer_ip_split(family, src, &addr, &port_str);
+	if (ret)
+		return ret;
+
+	if (inet_pton(family, addr, dst) != 1) {
+		test_print("Couldn't parse trace event addr %s", addr);
+		return -EINVAL;
+	}
+	errno = 0;
+	*port = (unsigned int)strtoul(port_str, NULL, 10);
+	if (errno != 0) {
+		test_print("Couldn't parse trace event port %s", port_str);
+		return -errno;
+	}
+	return 0;
+}
+
+static int tracer_scan_event(const char *line, enum trace_events event,
+			     struct trace_point *out)
+{
+	char *src = NULL, *dst = NULL, *family = NULL;
+	char fin, syn, rst, psh, ack;
+	int nr_matched, ret = 0;
+	uint64_t netns_cookie;
+
+	switch (event) {
+	case TCP_HASH_BAD_HEADER:
+	case TCP_HASH_MD5_REQUIRED:
+	case TCP_HASH_MD5_UNEXPECTED:
+	case TCP_HASH_MD5_MISMATCH:
+	case TCP_HASH_AO_REQUIRED: {
+		nr_matched = sscanf(line, "%*s net=%" PRIu64 " state=%*s family=%ms src=%ms dest=%ms L3index=%d [%c%c%c%c%c]",
+			&netns_cookie, &family,
+			&src, &dst, &out->L3index,
+			&fin, &syn, &rst, &psh, &ack);
+		if (nr_matched != 10)
+			test_print("Couldn't parse trace event, matched = %d/10",
+				   nr_matched);
+		break;
+	}
+	case TCP_AO_HANDSHAKE_FAILURE:
+	case TCP_AO_WRONG_MACLEN:
+	case TCP_AO_MISMATCH:
+	case TCP_AO_KEY_NOT_FOUND:
+	case TCP_AO_RNEXT_REQUEST: {
+		nr_matched = sscanf(line, "%*s net=%" PRIu64 " state=%*s family=%ms src=%ms dest=%ms L3index=%d [%c%c%c%c%c] keyid=%u rnext=%u maclen=%u",
+			&netns_cookie, &family,
+			&src, &dst, &out->L3index,
+			&fin, &syn, &rst, &psh, &ack,
+			&out->keyid, &out->rnext, &out->maclen);
+		if (nr_matched != 13)
+			test_print("Couldn't parse trace event, matched = %d/13",
+				   nr_matched);
+		break;
+	}
+	case TCP_AO_SYNACK_NO_KEY: {
+		nr_matched = sscanf(line, "%*s net=%" PRIu64 " state=%*s family=%ms src=%ms dest=%ms keyid=%u rnext=%u",
+			&netns_cookie, &family,
+			&src, &dst, &out->keyid, &out->rnext);
+		if (nr_matched != 6)
+			test_print("Couldn't parse trace event, matched = %d/6",
+				   nr_matched);
+		break;
+	}
+	case TCP_AO_SND_SNE_UPDATE:
+	case TCP_AO_RCV_SNE_UPDATE: {
+		nr_matched = sscanf(line, "%*s net=%" PRIu64 " state=%*s family=%ms src=%ms dest=%ms sne=%u",
+			&netns_cookie, &family,
+			&src, &dst, &out->sne);
+		if (nr_matched != 5)
+			test_print("Couldn't parse trace event, matched = %d/5",
+				   nr_matched);
+		break;
+	}
+	default:
+			return -1;
+	}
+
+	if (family) {
+		if (!strcmp(family, "AF_INET")) {
+			out->family = AF_INET;
+		} else if (!strcmp(family, "AF_INET6")) {
+			out->family = AF_INET6;
+		} else {
+			test_print("Couldn't parse trace event family %s", family);
+			ret = -EINVAL;
+			goto out_free;
+		}
+	}
+
+	if (event_has_flags(event)) {
+		out->fin = (fin == 'F');
+		out->syn = (syn == 'S');
+		out->rst = (rst == 'R');
+		out->psh = (psh == '.');
+		out->ack = (ack == 'A');
+
+		if ((fin != 'F' && fin != ' ') ||
+		    (syn != 'S' && syn != ' ') ||
+		    (rst != 'R' && rst != ' ') ||
+		    (psh != 'P' && psh != ' ') ||
+		    (ack != '.' && ack != ' ')) {
+			test_print("Couldn't parse trace event flags %c%c%c%c%c",
+				   fin, syn, rst, psh, ack);
+			ret = -EINVAL;
+			goto out_free;
+		}
+	}
+
+	if (src && tracer_scan_address(out->family, src, &out->src, &out->src_port)) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	if (dst && tracer_scan_address(out->family, dst, &out->dst, &out->dst_port)) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	if (netns_cookie != ns_cookie1 && netns_cookie != ns_cookie2) {
+		test_print("Net namespace filter for trace event didn't work: %" PRIu64 " != %" PRIu64 " OR %" PRIu64,
+			   netns_cookie, ns_cookie1, ns_cookie2);
+		ret = -EINVAL;
+	}
+
+out_free:
+	free(src);
+	free(dst);
+	free(family);
+	return ret;
+}
+
+static bool tracer_expected_event(const char *line)
+{
+	int event_type = check_event_type(line);
+	struct trace_point tmp = {};
+
+	if (event_type < 0)
+		return false;
+
+	if (tracer_scan_event(line, event_type, &tmp))
+		return false;
+
+	return lookup_expected_event(event_type, &tmp);
+}
+
+struct tracer_cleanup_t {
+	FILE *pipe;
+	char **line;
+};
+
+static void tracer_cleanup(void *arg)
+{
+	struct tracer_cleanup_t *t = arg;
+
+	fclose(t->pipe);
+	free(*(t->line));
+}
+
+static void *tracer_thread_func(void *arg)
+{
+	FILE *trace_pipe = arg;
+	size_t buf_len = 0;
+	char *line = NULL;
+	ssize_t line_len;
+	struct tracer_cleanup_t tmp = {
+		.pipe = trace_pipe,
+		.line = &line,
+	};
+
+	pthread_cleanup_push(tracer_cleanup, (void *)&tmp);
+
+	while ((line_len = getline(&line, &buf_len, trace_pipe)) != -1) {
+		struct trace_events_list *t;
+		bool expected_event;
+
+		pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, NULL);
+		expected_event = tracer_expected_event(line);
+		pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
+
+		if (expected_event)
+			continue;
+
+		t = malloc(sizeof(*t));
+		if (!t)
+			test_error("malloc()");
+		t->line = line;
+		t->next = unexpected_events;
+		unexpected_events = t;
+		line = NULL;
+		buf_len = 0;
+	}
+
+	pthread_cleanup_pop(1);
+	return NULL;
+}
+
+static void setup_trace_thread(void)
+{
+	FILE *trace_pipe;
+	char *path;
+
+	path = test_sprintf("%s/trace_pipe", instance_path);
+	if (!path)
+		test_error("Not enough memory");
+
+	trace_pipe = fopen(path, "r");
+	if (!trace_pipe)
+		test_error("fopen()");
+
+	if (pthread_create(&tracer_thread, NULL,
+			   tracer_thread_func, (void *)trace_pipe))
+		test_error("Failed pthread_create()");
+	free(path);
+	tracer_thread_created = true;
+}
+
+static void stop_trace_thread(void)
+{
+	void *res;
+
+	if (!tracer_thread_created)
+		return;
+
+	if (pthread_cancel(tracer_thread)) {
+		test_fail("Can't stop tracer pthread: %m");
+		tracing_was_dead = true;
+	}
+	if (pthread_join(tracer_thread, &res))
+		test_print("Can't join tracer pthread: %m");
+	if (res != PTHREAD_CANCELED) {
+		test_fail("Tracer thread wasn't canceled");
+		tracing_was_dead = true;
+	}
+}
+
+#define dump_events(fmt, ...)				\
+	__test_print(__test_msg, fmt, ##__VA_ARGS__)
+static void check_free_events(void)
+{
+	struct trace_events_list *tmp;
+	size_t nr;
+
+	if (!kernel_config_has(KCONFIG_FTRACE)) {
+		test_skip("kernel config doesn't have ftrace - no checks");
+		return;
+	}
+
+	if (!unexpected_events) {
+		if (tracing_was_dead)
+			return;
+
+		nr = how_many_matched();
+		if (nr)
+			test_ok("Trace events matched expectations: %zu", nr);
+		else
+			test_ok("No unexpected trace events during the test run");
+		return;
+	}
+
+	tmp = unexpected_events;
+	for (nr = 0; tmp; nr++)
+		tmp = tmp->next;
+
+	errno = 0;
+	test_fail("Trace events [%zu] were not expected:", nr);
+	while (unexpected_events) {
+		tmp = unexpected_events;
+		unexpected_events = tmp->next;
+		dump_events("\t%s", tmp->line);
+		free(tmp->line);
+		free(tmp);
+	}
+}
+
+static void test_unset_tracing(void)
+{
+	stop_trace_thread();
+	remove_ftrace_instance();
+	unmount_ftrace();
+	check_free_events();
+	free_expected_events();
+}
+
+static int setup_trace_tcp_event(const char *path, const char *name,
+				 const char *filter)
+{
+	char *enable_path, *filter_path;
+	int ret;
+
+	enable_path = test_sprintf("%s/events/tcp/%s/enable", path, name);
+	if (!enable_path)
+		return -ENOMEM;
+
+	filter_path = test_sprintf("%s/events/tcp/%s/filter", path, name);
+	if (!filter_path) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	ret = test_echo(filter_path, 0, "%s", filter);
+	if (!ret)
+		ret = test_echo(enable_path, 0, "1");
+
+out_free:
+	free(filter_path);
+	free(enable_path);
+	return ret;
+}
+
+static int setup_trace_events(void)
+{
+	char *filter;
+	size_t i;
+	int ret;
+
+	filter = test_sprintf("net_cookie == %zu || net_cookie == %zu",
+			      ns_cookie1, ns_cookie2);
+	if (!filter)
+		return -ENOMEM;
+
+	for (i = 0; i < __MAX_TRACE_EVENTS; i++) {
+		ret = setup_trace_tcp_event(instance_path, trace_event_names[i],
+					    filter);
+		if (ret)
+			break;
+	}
+
+	free(filter);
+	return ret;
+}
+
+int test_setup_tracing(void)
+{
+	/*
+	 * Just a basic protection - this should be called only once from
+	 * lib/kconfig. Not thread safe, which is fine as it's early, before
+	 * threads are created.
+	 */
+	static int already_set = 0;
+	int err;
+
+	/* Needs net-namespace cookies for filters */
+	if (ns_cookie1 == ns_cookie2)
+		return -1;
+
+	if (already_set)
+		return -1;
+	already_set = 1;
+
+	test_add_destructor(test_unset_tracing);
+	err = mount_ftrace();
+	if (err)
+		return err;
+
+	err = setup_ftrace_instance();
+	if (err)
+		return err;
+
+	err = setup_trace_events();
+	if (err)
+		return err;
+	setup_trace_thread();
+
+	return 0;
+}
+
+static int get_ns_cookie(int nsfd, uint64_t *out)
+{
+	int old_ns = switch_save_ns(nsfd);
+	socklen_t size = sizeof(*out);
+	int sk;
+
+	sk = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+	if (sk < 0) {
+		test_print("socket(): %m");
+		return -errno;
+	}
+
+	if (getsockopt(sk, SOL_SOCKET, SO_NETNS_COOKIE, out, &size)) {
+		test_print("getsockopt(SO_NETNS_COOKIE): %m");
+		close(sk);
+		return -errno;
+	}
+
+	close(sk);
+	switch_close_ns(old_ns);
+	return 0;
+}
+
+void test_init_ftrace(int nsfd1, int nsfd2)
+{
+	get_ns_cookie(nsfd1, &ns_cookie1);
+	get_ns_cookie(nsfd2, &ns_cookie2);
+	/* Populate kernel config state */
+	kernel_config_has(KCONFIG_FTRACE);
+}
diff --git a/tools/testing/selftests/net/tcp_ao/lib/kconfig.c b/tools/testing/selftests/net/tcp_ao/lib/kconfig.c
index 3bf4a7e4b3c9..9f1c175846f8 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/kconfig.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/kconfig.c
@@ -116,6 +116,12 @@ static int has_vrfs(int *err)
 	return ret;
 }
 
+static int has_ftrace(int *err)
+{
+	*err = test_setup_tracing();
+	return 0;
+}
+
 #define KCONFIG_UNKNOWN			1
 static pthread_mutex_t kconfig_lock = PTHREAD_MUTEX_INITIALIZER;
 static struct kconfig_t kconfig[__KCONFIG_LAST__] = {
@@ -124,6 +130,7 @@ static struct kconfig_t kconfig[__KCONFIG_LAST__] = {
 	{ KCONFIG_UNKNOWN, has_tcp_ao },
 	{ KCONFIG_UNKNOWN, has_tcp_md5 },
 	{ KCONFIG_UNKNOWN, has_vrfs },
+	{ KCONFIG_UNKNOWN, has_ftrace },
 };
 
 const char *tests_skip_reason[__KCONFIG_LAST__] = {
@@ -132,6 +139,7 @@ const char *tests_skip_reason[__KCONFIG_LAST__] = {
 	"Tests require TCP-AO support (CONFIG_TCP_AO)",
 	"setsockopt(TCP_MD5SIG_EXT) is not supported (CONFIG_TCP_MD5)",
 	"VRFs are not supported (CONFIG_NET_VRF)",
+	"Ftrace points are not supported (CONFIG_TRACEPOINTS)",
 };
 
 bool kernel_config_has(enum test_needs_kconfig k)
diff --git a/tools/testing/selftests/net/tcp_ao/lib/setup.c b/tools/testing/selftests/net/tcp_ao/lib/setup.c
index f80120bef3dc..bd5620cc6d86 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/setup.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/setup.c
@@ -250,9 +250,9 @@ void __test_init(unsigned int ntests, int family, unsigned int prefix,
 	test_print("rand seed %u", (unsigned int)seed);
 	srand(seed);
 
-
 	ksft_print_header();
 	init_namespaces();
+	test_init_ftrace(nsfd_parent, nsfd_child);
 
 	if (add_veth(veth_name, nsfd_parent, nsfd_child))
 		test_error("Failed to add veth");
diff --git a/tools/testing/selftests/net/tcp_ao/lib/utils.c b/tools/testing/selftests/net/tcp_ao/lib/utils.c
index 372daca525f5..60eeb9157b20 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/utils.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/utils.c
@@ -21,6 +21,32 @@ void randomize_buffer(void *buf, size_t buflen)
 	}
 }
 
+__attribute__((__format__(__printf__, 3, 4)))
+int test_echo(const char *fname, bool append, const char *fmt, ...)
+{
+	size_t len, written;
+	va_list vargs;
+	char *msg;
+	FILE *f;
+
+	f = fopen(fname, append ? "a" : "w");
+	if (!f)
+		return -errno;
+
+	va_start(vargs, fmt);
+	msg = test_snprintf(fmt, vargs);
+	va_end(vargs);
+	if (!msg) {
+		fclose(f);
+		return -1;
+	}
+	len = strlen(msg);
+	written = fwrite(msg, 1, len, f);
+	fclose(f);
+	free(msg);
+	return written == len ? 0 : -1;
+}
+
 const struct sockaddr_in6 addr_any6 = {
 	.sin6_family	= AF_INET6,
 };
diff --git a/tools/testing/selftests/net/tcp_ao/restore.c b/tools/testing/selftests/net/tcp_ao/restore.c
index 8fdc808df325..472b7781f989 100644
--- a/tools/testing/selftests/net/tcp_ao/restore.c
+++ b/tools/testing/selftests/net/tcp_ao/restore.c
@@ -206,22 +206,38 @@ static void *client_fn(void *arg)
 
 	test_get_sk_checkpoint(port, &saddr, &tcp_img, &ao_img);
 	ao_img.snt_isn += 1;
+	trace_ao_event_expect(TCP_AO_MISMATCH, this_ip_addr, this_ip_dest,
+			      -1, port, 0, -1, -1, -1, -1, -1, 100, 100, -1);
+	trace_ao_event_expect(TCP_AO_MISMATCH, this_ip_dest, this_ip_addr,
+			      port, -1, 0, -1, -1, -1, -1, -1, 100, 100, -1);
 	test_sk_restore("TCP-AO with wrong send ISN", port++,
 			&saddr, &tcp_img, &ao_img, FAULT_TIMEOUT, TEST_CNT_BAD);
 
 	test_get_sk_checkpoint(port, &saddr, &tcp_img, &ao_img);
 	ao_img.rcv_isn += 1;
+	trace_ao_event_expect(TCP_AO_MISMATCH, this_ip_addr, this_ip_dest,
+			      -1, port, 0, -1, -1, -1, -1, -1, 100, 100, -1);
+	trace_ao_event_expect(TCP_AO_MISMATCH, this_ip_dest, this_ip_addr,
+			      port, -1, 0, -1, -1, -1, -1, -1, 100, 100, -1);
 	test_sk_restore("TCP-AO with wrong receive ISN", port++,
 			&saddr, &tcp_img, &ao_img, FAULT_TIMEOUT, TEST_CNT_BAD);
 
 	test_get_sk_checkpoint(port, &saddr, &tcp_img, &ao_img);
 	ao_img.snd_sne += 1;
+	trace_ao_event_expect(TCP_AO_MISMATCH, this_ip_addr, this_ip_dest,
+			      -1, port, 0, -1, -1, -1, -1, -1, 100, 100, -1);
+	trace_ao_event_expect(TCP_AO_MISMATCH, this_ip_dest, this_ip_addr,
+			      port, -1, 0, -1, -1, -1, -1, -1, 100, 100, -1);
 	test_sk_restore("TCP-AO with wrong send SEQ ext number", port++,
 			&saddr, &tcp_img, &ao_img, FAULT_TIMEOUT,
 			TEST_CNT_NS_BAD | TEST_CNT_GOOD);
 
 	test_get_sk_checkpoint(port, &saddr, &tcp_img, &ao_img);
 	ao_img.rcv_sne += 1;
+	trace_ao_event_expect(TCP_AO_MISMATCH, this_ip_addr, this_ip_dest,
+			      -1, port, 0, -1, -1, -1, -1, -1, 100, 100, -1);
+	trace_ao_event_expect(TCP_AO_MISMATCH, this_ip_dest, this_ip_addr,
+			      port, -1, 0, -1, -1, -1, -1, -1, 100, 100, -1);
 	test_sk_restore("TCP-AO with wrong receive SEQ ext number", port++,
 			&saddr, &tcp_img, &ao_img, FAULT_TIMEOUT,
 			TEST_CNT_NS_GOOD | TEST_CNT_BAD);
@@ -231,6 +247,6 @@ static void *client_fn(void *arg)
 
 int main(int argc, char *argv[])
 {
-	test_init(20, server_fn, client_fn);
+	test_init(21, server_fn, client_fn);
 	return 0;
 }
diff --git a/tools/testing/selftests/net/tcp_ao/rst.c b/tools/testing/selftests/net/tcp_ao/rst.c
index 7df8b8700e39..0d16d59ee432 100644
--- a/tools/testing/selftests/net/tcp_ao/rst.c
+++ b/tools/testing/selftests/net/tcp_ao/rst.c
@@ -452,6 +452,6 @@ static void *client_fn(void *arg)
 
 int main(int argc, char *argv[])
 {
-	test_init(14, server_fn, client_fn);
+	test_init(15, server_fn, client_fn);
 	return 0;
 }
diff --git a/tools/testing/selftests/net/tcp_ao/self-connect.c b/tools/testing/selftests/net/tcp_ao/self-connect.c
index e154d9e198a9..98eb436d023a 100644
--- a/tools/testing/selftests/net/tcp_ao/self-connect.c
+++ b/tools/testing/selftests/net/tcp_ao/self-connect.c
@@ -181,17 +181,30 @@ static void *client_fn(void *arg)
 	setup_lo_intf("lo");
 
 	tcp_self_connect("self-connect(same keyids)", port++, false, false);
+
+	trace_ao_event_expect(TCP_AO_RNEXT_REQUEST, local_addr, local_addr,
+			      port, port, 0, -1, -1, -1, -1, -1, 5, 7, -1);
+	trace_ao_event_expect(TCP_AO_RNEXT_REQUEST, local_addr, local_addr,
+			      port, port, 0, -1, -1, -1, -1, -1, 7, 5, -1);
 	tcp_self_connect("self-connect(different keyids)", port++, true, false);
 	tcp_self_connect("self-connect(restore)", port, false, true);
-	port += 2;
+	port += 2; /* restore test restores over different port */
+	trace_ao_event_expect(TCP_AO_RNEXT_REQUEST, local_addr, local_addr,
+			      port, port, 0, -1, -1, -1, -1, -1, 5, 7, -1);
+	trace_ao_event_expect(TCP_AO_RNEXT_REQUEST, local_addr, local_addr,
+			      port, port, 0, -1, -1, -1, -1, -1, 7, 5, -1);
+	trace_ao_event_expect(TCP_AO_RNEXT_REQUEST, local_addr, local_addr,
+			      port + 1, port + 1, 0, -1, -1, -1, -1, -1, 5, 7, -1);
+	trace_ao_event_expect(TCP_AO_RNEXT_REQUEST, local_addr, local_addr,
+			      port + 1, port + 1, 0, -1, -1, -1, -1, -1, 7, 5, -1);
 	tcp_self_connect("self-connect(restore, different keyids)", port, true, true);
-	port += 2;
+	port += 2; /* restore test restores over different port */
 
 	return NULL;
 }
 
 int main(int argc, char *argv[])
 {
-	test_init(4, client_fn, NULL);
+	test_init(5, client_fn, NULL);
 	return 0;
 }
diff --git a/tools/testing/selftests/net/tcp_ao/seq-ext.c b/tools/testing/selftests/net/tcp_ao/seq-ext.c
index ad4e77d6823e..aac2f335ca46 100644
--- a/tools/testing/selftests/net/tcp_ao/seq-ext.c
+++ b/tools/testing/selftests/net/tcp_ao/seq-ext.c
@@ -116,6 +116,14 @@ static void *server_fn(void *arg)
 	sk = test_sk_restore(&img, &ao_img, &saddr, this_ip_dest,
 			     client_new_port, &ao1);
 
+	trace_ao_event_sne_expect(TCP_AO_SND_SNE_UPDATE, this_ip_addr,
+			this_ip_dest, test_server_port + 1, client_new_port, 1);
+	trace_ao_event_sne_expect(TCP_AO_SND_SNE_UPDATE, this_ip_dest,
+			this_ip_addr, client_new_port, test_server_port + 1, 1);
+	trace_ao_event_sne_expect(TCP_AO_RCV_SNE_UPDATE, this_ip_addr,
+			this_ip_dest, test_server_port + 1, client_new_port, 1);
+	trace_ao_event_sne_expect(TCP_AO_RCV_SNE_UPDATE, this_ip_dest,
+			this_ip_addr, client_new_port, test_server_port + 1, 1);
 	synchronize_threads(); /* 5: verify counters during SEQ-number rollover */
 	bytes = test_server_run(sk, quota, TEST_TIMEOUT_SEC);
 	if (bytes != quota) {
@@ -240,6 +248,6 @@ static void *client_fn(void *arg)
 
 int main(int argc, char *argv[])
 {
-	test_init(7, server_fn, client_fn);
+	test_init(8, server_fn, client_fn);
 	return 0;
 }
diff --git a/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c b/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
index 452de131fa3a..2646be5b0c82 100644
--- a/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
+++ b/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
@@ -830,6 +830,6 @@ static void *client_fn(void *arg)
 
 int main(int argc, char *argv[])
 {
-	test_init(120, client_fn, NULL);
+	test_init(121, client_fn, NULL);
 	return 0;
 }
diff --git a/tools/testing/selftests/net/tcp_ao/unsigned-md5.c b/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
index 6b59a652159f..8bc383cf7374 100644
--- a/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
+++ b/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
@@ -671,24 +671,38 @@ static void *client_fn(void *arg)
 
 	try_connect("AO server (INADDR_ANY): AO client", port++, NULL, 0,
 		    &addr_any, 0, 100, 100, 0, 0, 0, &this_ip_addr);
+	trace_hash_event_expect(TCP_HASH_MD5_UNEXPECTED, this_ip_addr,
+				this_ip_dest, -1, port, 0, 0, 1, 0, 0, 0);
 	try_connect("AO server (INADDR_ANY): MD5 client", port++, &addr_any, 0,
 		    NULL, 0, 100, 100, 0, FAULT_TIMEOUT, 1, &this_ip_addr);
+	trace_hash_event_expect(TCP_HASH_AO_REQUIRED, this_ip_addr,
+				this_ip_dest, -1, port, 0, 0, 1, 0, 0, 0);
 	try_connect("AO server (INADDR_ANY): unsigned client", port++, NULL, 0,
 		    NULL, 0, 100, 100, 0, FAULT_TIMEOUT, 0, &this_ip_addr);
 	try_connect("AO server (AO_REQUIRED): AO client", port++, NULL, 0,
 		    &addr_any, 0, 100, 100, 0, 0, 0, &this_ip_addr);
+	trace_hash_event_expect(TCP_HASH_AO_REQUIRED, client2,
+				this_ip_dest, -1, port, 0, 0, 1, 0, 0, 0);
 	try_connect("AO server (AO_REQUIRED): unsigned client", port++, NULL, 0,
 		    NULL, 0, 100, 100, 0, FAULT_TIMEOUT, 0, &client2);
 
+	trace_ao_event_expect(TCP_AO_KEY_NOT_FOUND, this_ip_addr, this_ip_dest,
+			      -1, port, 0, 0, 1, 0, 0, 0, 100, 100, -1);
 	try_connect("MD5 server (INADDR_ANY): AO client", port++, NULL, 0,
 		   &addr_any, 0, 100, 100, 0, FAULT_TIMEOUT, 1, &this_ip_addr);
 	try_connect("MD5 server (INADDR_ANY): MD5 client", port++, &addr_any, 0,
 		   NULL, 0, 100, 100, 0, 0, 1, &this_ip_addr);
+	trace_hash_event_expect(TCP_HASH_MD5_REQUIRED, this_ip_addr,
+				this_ip_dest, -1, port, 0, 0, 1, 0, 0, 0);
 	try_connect("MD5 server (INADDR_ANY): no sign client", port++, NULL, 0,
 		   NULL, 0, 100, 100, 0, FAULT_TIMEOUT, 1, &this_ip_addr);
 
+	trace_ao_event_expect(TCP_AO_KEY_NOT_FOUND, this_ip_addr, this_ip_dest,
+			      -1, port, 0, 0, 1, 0, 0, 0, 100, 100, -1);
 	try_connect("no sign server: AO client", port++, NULL, 0,
 		   &addr_any, 0, 100, 100, 0, FAULT_TIMEOUT, 0, &this_ip_addr);
+	trace_hash_event_expect(TCP_HASH_MD5_UNEXPECTED, this_ip_addr,
+				this_ip_dest, -1, port, 0, 0, 1, 0, 0, 0);
 	try_connect("no sign server: MD5 client", port++, &addr_any, 0,
 		   NULL, 0, 100, 100, 0, FAULT_TIMEOUT, 1, &this_ip_addr);
 	try_connect("no sign server: no sign client", port++, NULL, 0,
@@ -696,25 +710,37 @@ static void *client_fn(void *arg)
 
 	try_connect("AO+MD5 server: AO client (matching)", port++, NULL, 0,
 		   &addr_any, 0, 100, 100, 0, 0, 1, &client2);
+	trace_ao_event_expect(TCP_AO_KEY_NOT_FOUND, this_ip_addr, this_ip_dest,
+			      -1, port, 0, 0, 1, 0, 0, 0, 100, 100, -1);
 	try_connect("AO+MD5 server: AO client (misconfig, matching MD5)",
 		   port++, NULL, 0, &addr_any, 0, 100, 100, 0,
 		   FAULT_TIMEOUT, 1, &this_ip_addr);
+	trace_ao_event_expect(TCP_AO_KEY_NOT_FOUND, client3, this_ip_dest,
+			      -1, port, 0, 0, 1, 0, 0, 0, 100, 100, -1);
 	try_connect("AO+MD5 server: AO client (misconfig, non-matching)",
 		   port++, NULL, 0, &addr_any, 0, 100, 100, 0,
 		   FAULT_TIMEOUT, 1, &client3);
 	try_connect("AO+MD5 server: MD5 client (matching)", port++, &addr_any, 0,
 		   NULL, 0, 100, 100, 0, 0, 1, &this_ip_addr);
+	trace_hash_event_expect(TCP_HASH_MD5_UNEXPECTED, client2,
+				this_ip_dest, -1, port, 0, 0, 1, 0, 0, 0);
 	try_connect("AO+MD5 server: MD5 client (misconfig, matching AO)",
 		   port++, &addr_any, 0, NULL, 0, 100, 100, 0, FAULT_TIMEOUT,
 		   1, &client2);
+	trace_hash_event_expect(TCP_HASH_MD5_UNEXPECTED, client3,
+				this_ip_dest, -1, port, 0, 0, 1, 0, 0, 0);
 	try_connect("AO+MD5 server: MD5 client (misconfig, non-matching)",
 		   port++, &addr_any, 0, NULL, 0, 100, 100, 0, FAULT_TIMEOUT,
 		   1, &client3);
 	try_connect("AO+MD5 server: no sign client (unmatched)",
 		   port++, NULL, 0, NULL, 0, 100, 100, 0, 0, 1, &client3);
+	trace_hash_event_expect(TCP_HASH_AO_REQUIRED, client2,
+				this_ip_dest, -1, port, 0, 0, 1, 0, 0, 0);
 	try_connect("AO+MD5 server: no sign client (misconfig, matching AO)",
 		   port++, NULL, 0, NULL, 0, 100, 100, 0, FAULT_TIMEOUT,
 		   1, &client2);
+	trace_hash_event_expect(TCP_HASH_MD5_REQUIRED, this_ip_addr,
+				this_ip_dest, -1, port, 0, 0, 1, 0, 0, 0);
 	try_connect("AO+MD5 server: no sign client (misconfig, matching MD5)",
 		   port++, NULL, 0, NULL, 0, 100, 100, 0, FAULT_TIMEOUT,
 		   1, &this_ip_addr);
@@ -736,6 +762,6 @@ static void *client_fn(void *arg)
 
 int main(int argc, char *argv[])
 {
-	test_init(72, server_fn, client_fn);
+	test_init(73, server_fn, client_fn);
 	return 0;
 }

-- 
2.43.0


