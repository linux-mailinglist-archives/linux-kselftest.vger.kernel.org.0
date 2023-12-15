Return-Path: <linux-kselftest+bounces-1987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91194813FFA
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 03:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0BDC1C221F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 02:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BF9107BB;
	Fri, 15 Dec 2023 02:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="B5fek7H3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671F0FC08
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Dec 2023 02:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c580ba223so2490945e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 18:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1702607852; x=1703212652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWwFWTodpMTGSjl3gEogz/5Nort09Oyr5zwqMosShg8=;
        b=B5fek7H3Y4QiB7jeTYTXy5KSM6LmWbEzfe8pGk6sbIwcFO4bn25WtZLNh+xvbL/esG
         XZRdEqEsa/Zl6krqkHHLdHaFNEFpaPSyl/iCJUlfZHHq6FEbpowCDHTieb1gzRlWFb7v
         vwN4ZBgA+eHn4m87gMLRBupysIh6ivMl35rtV6sZUdtm1E6Dwi+ZfDIp2qsAfVg3NJev
         jJRJ6jpqU3l2xYB/WQyZgMif4mV86obvJNY9iWspH8cHyh+RyILWEXZDQlAQUxbPIBZW
         tFpFgHu134eZhBSycpHr9uwzj/duns5tSvXuzs6/4Mb+KrZ8D2xFVc7b/guk+MQh+KHh
         NFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702607852; x=1703212652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWwFWTodpMTGSjl3gEogz/5Nort09Oyr5zwqMosShg8=;
        b=kAczkf7azFBXMSpgB/MUVAsp+92Ytvpi2NstSz0qsu/CxNR+UdVzpE0dkdcXWFiK8A
         UBAVImrKKhMJnhigjLW+v/3PWmeFX9TGB4BrmkSyx21C8NcNR4+GkpRslwNjYgLTcSMG
         FkHS+XIhYF5wy7+fNj5N6m6t7awhdApidiJSyEI7BSP2hCQWl5gsNE+DdDsa7cEz5sqT
         hnKTdDAY+H0kDm3M6GEU9EqEGunjPwsZ4tt2dFnxLHQNrV8pfVhxS1lJSYEnRZ47Z+q4
         UhHeeLdl7fJE++7PEO3AHIK4lYnic2RImtT3QX0sf3k2XjIenYyzopCKL+97FhSH/0my
         1Idw==
X-Gm-Message-State: AOJu0YxfS1zbA+rhi8SSbsabVXFc3s2EevAN/YdfeDabR2pPHfO9J53K
	qCmlAyG6yQmBUxtYrDqsQa5xyQ==
X-Google-Smtp-Source: AGHT+IGJej2dDQ9eUrkdVsLgTXdNr/Du2z//gHeLzMPto6d6oHaPBY94PyY7iur9NgeglgpwL3V7FQ==
X-Received: by 2002:a05:600c:3556:b0:405:3e9a:f1e3 with SMTP id i22-20020a05600c355600b004053e9af1e3mr6247218wmq.11.1702607852630;
        Thu, 14 Dec 2023 18:37:32 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id fc17-20020a05600c525100b0040c42681fcesm20096363wmb.15.2023.12.14.18.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 18:37:32 -0800 (PST)
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
Subject: [PATCH 07/12] selftests/net: Add test/benchmark for removing MKTs
Date: Fri, 15 Dec 2023 02:36:21 +0000
Message-ID: <20231215-tcp-ao-selftests-v1-7-f6c08180b985@arista.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702607833; l=14434; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=yfglzaz3jqImUp8sJQiHV6B+QBtqFqJiDnWZfjXsgNA=; b=j6hhGvZvlopdPPQAGkGZSRJQ3OMY4O67n4QpccLBRVsUppSNAfa1f+3sOS8nkPlCX0u7DwGcg 9d71OXfMHNfBa/RL8/u3FHIKCyXKMWtF/WbwjxKWPJSGHzzLSN8WqTP
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

Sample output:
> 1..36
> # 1106[lib/setup.c:207] rand seed 1660754406
> TAP version 13
> ok 1   Worst case connect       512 keys: min=0ms max=1ms mean=0.583329ms stddev=0.076376
> ok 2 Connect random-search      512 keys: min=0ms max=1ms mean=0.53412ms stddev=0.0516779
> ok 3    Worst case delete       512 keys: min=2ms max=11ms mean=6.04139ms stddev=0.245792
> ok 4        Add a new key       512 keys: min=0ms max=13ms mean=0.673415ms stddev=0.0820618
> ok 5 Remove random-search       512 keys: min=5ms max=9ms mean=6.65969ms stddev=0.258064
> ok 6         Remove async       512 keys: min=0ms max=0ms mean=0.041825ms stddev=0.0204512
> ok 7   Worst case connect       1024 keys: min=0ms max=2ms mean=0.520357ms stddev=0.0721358
> ok 8 Connect random-search      1024 keys: min=0ms max=2ms mean=0.535312ms stddev=0.0517355
> ok 9    Worst case delete       1024 keys: min=5ms max=9ms mean=8.27219ms stddev=0.287614
> ok 10        Add a new key      1024 keys: min=0ms max=1ms mean=0.688121ms stddev=0.0829531
> ok 11 Remove random-search      1024 keys: min=5ms max=9ms mean=8.37649ms stddev=0.289422
> ok 12         Remove async      1024 keys: min=0ms max=0ms mean=0.0457096ms stddev=0.0213798
> ok 13   Worst case connect      2048 keys: min=0ms max=2ms mean=0.748804ms stddev=0.0865335
> ok 14 Connect random-search     2048 keys: min=0ms max=2ms mean=0.782993ms stddev=0.0625697
> ok 15    Worst case delete      2048 keys: min=5ms max=10ms mean=8.23106ms stddev=0.286898
> ok 16        Add a new key      2048 keys: min=0ms max=1ms mean=0.812988ms stddev=0.0901658
> ok 17 Remove random-search      2048 keys: min=8ms max=9ms mean=8.84949ms stddev=0.297481
> ok 18         Remove async      2048 keys: min=0ms max=0ms mean=0.0297223ms stddev=0.0172402
> ok 19   Worst case connect      4096 keys: min=1ms max=5ms mean=1.53352ms stddev=0.123836
> ok 20 Connect random-search     4096 keys: min=1ms max=5ms mean=1.52226ms stddev=0.0872429
> ok 21    Worst case delete      4096 keys: min=5ms max=9ms mean=8.25874ms stddev=0.28738
> ok 22        Add a new key      4096 keys: min=0ms max=3ms mean=1.67382ms stddev=0.129376
> ok 23 Remove random-search      4096 keys: min=5ms max=10ms mean=8.26178ms stddev=0.287433
> ok 24         Remove async      4096 keys: min=0ms max=0ms mean=0.0340009ms stddev=0.0184393
> ok 25   Worst case connect      8192 keys: min=2ms max=4ms mean=2.86208ms stddev=0.169177
> ok 26 Connect random-search     8192 keys: min=2ms max=4ms mean=2.87592ms stddev=0.119915
> ok 27    Worst case delete      8192 keys: min=6ms max=11ms mean=7.55291ms stddev=0.274826
> ok 28        Add a new key      8192 keys: min=1ms max=5ms mean=2.56797ms stddev=0.160249
> ok 29 Remove random-search      8192 keys: min=5ms max=10ms mean=7.14002ms stddev=0.267208
> ok 30         Remove async      8192 keys: min=0ms max=0ms mean=0.0320066ms stddev=0.0178904
> ok 31   Worst case connect      16384 keys: min=5ms max=6ms mean=5.55334ms stddev=0.235655
> ok 32 Connect random-search     16384 keys: min=5ms max=6ms mean=5.52614ms stddev=0.166225
> ok 33    Worst case delete      16384 keys: min=5ms max=11ms mean=7.39109ms stddev=0.271866
> ok 34        Add a new key      16384 keys: min=2ms max=4ms mean=3.35799ms stddev=0.183248
> ok 35 Remove random-search      16384 keys: min=5ms max=8ms mean=6.86078ms stddev=0.261931
> ok 36         Remove async      16384 keys: min=0ms max=0ms mean=0.0302384ms stddev=0.0173892
> # Totals: pass:36 fail:0 xfail:0 xpass:0 skip:0 error:0

From the output it's visible that the current simplified approach with
linked-list of MKTs scales quite fine even for thousands of keys.
And that also means that the majority of the time for delete is eaten by
synchronize_rcu() [which I can confirm separately by tracing].

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/tcp_ao/Makefile        |   5 +-
 tools/testing/selftests/net/tcp_ao/bench-lookups.c | 358 +++++++++++++++++++++
 2 files changed, 362 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tcp_ao/Makefile b/tools/testing/selftests/net/tcp_ao/Makefile
index ee2f1a17e805..f0b218b99506 100644
--- a/tools/testing/selftests/net/tcp_ao/Makefile
+++ b/tools/testing/selftests/net/tcp_ao/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-TEST_BOTH_AF := connect
+TEST_BOTH_AF := bench-lookups
+TEST_BOTH_AF += connect
 TEST_BOTH_AF += connect-deny
 TEST_BOTH_AF += icmps-accept icmps-discard
 TEST_BOTH_AF += setsockopt-closed
@@ -49,3 +50,5 @@ $(OUTPUT)/%_ipv6: %.c
 
 $(OUTPUT)/icmps-accept_ipv4: CFLAGS+= -DTEST_ICMPS_ACCEPT
 $(OUTPUT)/icmps-accept_ipv6: CFLAGS+= -DTEST_ICMPS_ACCEPT
+$(OUTPUT)/bench-lookups_ipv4: LDFLAGS+= -lm
+$(OUTPUT)/bench-lookups_ipv6: LDFLAGS+= -lm
diff --git a/tools/testing/selftests/net/tcp_ao/bench-lookups.c b/tools/testing/selftests/net/tcp_ao/bench-lookups.c
new file mode 100644
index 000000000000..7be8a7d9308c
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_ao/bench-lookups.c
@@ -0,0 +1,358 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Author: Dmitry Safonov <dima@arista.com> */
+#include <arpa/inet.h>
+#include <inttypes.h>
+#include <math.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <time.h>
+
+#include "../../../../include/linux/bits.h"
+#include "../../../../include/linux/kernel.h"
+#include "aolib.h"
+
+#define BENCH_NR_ITERS	100 /* number of times to run gathering statistics */
+
+static void gen_test_ips(union tcp_addr *ips, size_t ips_nr, bool use_rand)
+{
+	union tcp_addr net = {};
+	size_t i, j;
+
+	if (inet_pton(TEST_FAMILY, TEST_NETWORK, &net) != 1)
+		test_error("Can't convert ip address %s", TEST_NETWORK);
+
+	if (!use_rand) {
+		for (i = 0; i < ips_nr; i++)
+			ips[i] = gen_tcp_addr(net, 2 * i + 1);
+		return;
+	}
+	for (i = 0; i < ips_nr; i++) {
+		size_t r = (size_t)random() | 0x1;
+
+		ips[i] = gen_tcp_addr(net, r);
+
+		for (j = i - 1; j > 0 && i > 0; j--) {
+			if (!memcmp(&ips[i], &ips[j], sizeof(union tcp_addr))) {
+				i--; /* collision */
+				break;
+			}
+		}
+	}
+}
+
+static void test_add_routes(union tcp_addr *ips, size_t ips_nr)
+{
+	size_t i;
+
+	for (i = 0; i < ips_nr; i++) {
+		union tcp_addr *p = (union tcp_addr *)&ips[i];
+
+		if (ip_route_add(veth_name, TEST_FAMILY, this_ip_addr, *p))
+			test_error("Failed to add route");
+	}
+}
+
+static void server_apply_keys(int lsk, union tcp_addr *ips, size_t ips_nr)
+{
+	size_t i;
+
+	for (i = 0; i < ips_nr; i++) {
+		union tcp_addr *p = (union tcp_addr *)&ips[i];
+
+		if (test_add_key(lsk, DEFAULT_TEST_PASSWORD, *p, -1, 100, 100))
+			test_error("setsockopt(TCP_AO)");
+	}
+}
+
+static const size_t nr_keys[] = { 512, 1024, 2048, 4096, 8192 };
+static union tcp_addr *test_ips;
+
+struct bench_stats {
+	uint64_t min;
+	uint64_t max;
+	uint64_t nr;
+	double mean;
+	double s2;
+};
+
+static struct bench_tests {
+	struct bench_stats delete_last_key;
+	struct bench_stats add_key;
+	struct bench_stats delete_rand_key;
+	struct bench_stats connect_last_key;
+	struct bench_stats connect_rand_key;
+	struct bench_stats delete_async;
+} bench_results[ARRAY_SIZE(nr_keys)];
+
+#define NSEC_PER_SEC 1000000000ULL
+
+static void measure_call(struct bench_stats *st,
+			 void (*f)(int, void *), int sk, void *arg)
+{
+	struct timespec start = {}, end = {};
+	double delta;
+	uint64_t nsec;
+
+	if (clock_gettime(CLOCK_MONOTONIC, &start))
+		test_error("clock_gettime()");
+
+	f(sk, arg);
+
+	if (clock_gettime(CLOCK_MONOTONIC, &end))
+		test_error("clock_gettime()");
+
+	nsec = (end.tv_sec - start.tv_sec) * NSEC_PER_SEC;
+	if (end.tv_nsec >= start.tv_nsec)
+		nsec += end.tv_nsec - start.tv_nsec;
+	else
+		nsec -= start.tv_nsec - end.tv_nsec;
+
+	if (st->nr == 0) {
+		st->min = st->max = nsec;
+	} else {
+		if (st->min > nsec)
+			st->min = nsec;
+		if (st->max < nsec)
+			st->max = nsec;
+	}
+
+	/* Welford-Knuth algorithm */
+	st->nr++;
+	delta = (double)nsec - st->mean;
+	st->mean += delta / st->nr;
+	st->s2 += delta * ((double)nsec - st->mean);
+}
+
+static void delete_mkt(int sk, void *arg)
+{
+	struct tcp_ao_del *ao = arg;
+
+	if (setsockopt(sk, IPPROTO_TCP, TCP_AO_DEL_KEY, ao, sizeof(*ao)))
+		test_error("setsockopt(TCP_AO_DEL_KEY)");
+}
+
+static void add_back_mkt(int sk, void *arg)
+{
+	union tcp_addr *p = arg;
+
+	if (test_add_key(sk, DEFAULT_TEST_PASSWORD, *p, -1, 100, 100))
+		test_error("setsockopt(TCP_AO)");
+}
+
+static void bench_delete(int lsk, struct bench_stats *add,
+			 struct bench_stats *del,
+			 union tcp_addr *ips, size_t ips_nr,
+			 bool rand_order, bool async)
+{
+	struct tcp_ao_del ao_del = {};
+	union tcp_addr *p;
+	size_t i;
+
+	ao_del.sndid = 100;
+	ao_del.rcvid = 100;
+	ao_del.del_async = !!async;
+	ao_del.prefix = DEFAULT_TEST_PREFIX;
+
+	/* Remove the first added */
+	p = (union tcp_addr *)&ips[0];
+	tcp_addr_to_sockaddr_in(&ao_del.addr, p, 0);
+
+	for (i = 0; i < BENCH_NR_ITERS; i++) {
+		measure_call(del, delete_mkt, lsk, (void *)&ao_del);
+
+		/* Restore it back */
+		measure_call(add, add_back_mkt, lsk, (void *)p);
+
+		/*
+		 * Slowest for FILO-linked-list:
+		 * on (i) iteration removing ips[i] element. When it gets
+		 * added to the list back - it becomes first to fetch, so
+		 * on (i + 1) iteration go to ips[i + 1] element.
+		 */
+		if (rand_order)
+			p = (union tcp_addr *)&ips[rand() % ips_nr];
+		else
+			p = (union tcp_addr *)&ips[i % ips_nr];
+		tcp_addr_to_sockaddr_in(&ao_del.addr, p, 0);
+	}
+}
+
+static void bench_connect_srv(int lsk, union tcp_addr *ips, size_t ips_nr)
+{
+	size_t i;
+
+	for (i = 0; i < BENCH_NR_ITERS; i++) {
+		int sk;
+
+		synchronize_threads();
+
+		if (test_wait_fd(lsk, TEST_TIMEOUT_SEC, 0))
+			test_error("test_wait_fd()");
+
+		sk = accept(lsk, NULL, NULL);
+		if (sk < 0)
+			test_error("accept()");
+
+		close(sk);
+	}
+}
+
+static void test_print_stats(const char *desc, size_t nr, struct bench_stats *bs)
+{
+	test_ok("%-20s\t%zu keys: min=%" PRIu64 "ms max=%" PRIu64 "ms mean=%gms stddev=%g",
+		desc, nr, bs->min / 1000000, bs->max / 1000000,
+		bs->mean / 1000000, sqrt((bs->mean / 1000000) / bs->nr));
+}
+
+static void *server_fn(void *arg)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(nr_keys); i++) {
+		struct bench_tests *bt = &bench_results[i];
+		int lsk;
+
+		test_ips = malloc(nr_keys[i] * sizeof(union tcp_addr));
+		if (!test_ips)
+			test_error("malloc()");
+
+		lsk = test_listen_socket(this_ip_addr, test_server_port + i, 1);
+
+		gen_test_ips(test_ips, nr_keys[i], false);
+		test_add_routes(test_ips, nr_keys[i]);
+		test_set_optmem(KERNEL_TCP_AO_KEY_SZ_ROUND_UP * nr_keys[i]);
+		server_apply_keys(lsk, test_ips, nr_keys[i]);
+
+		synchronize_threads();
+		bench_connect_srv(lsk, test_ips, nr_keys[i]);
+		bench_connect_srv(lsk, test_ips, nr_keys[i]);
+
+		/* The worst case for FILO-list */
+		bench_delete(lsk, &bt->add_key, &bt->delete_last_key,
+			     test_ips, nr_keys[i], false, false);
+		test_print_stats("Add a new key",
+				nr_keys[i], &bt->add_key);
+		test_print_stats("Delete: worst case",
+				nr_keys[i], &bt->delete_last_key);
+
+		bench_delete(lsk, &bt->add_key, &bt->delete_rand_key,
+			     test_ips, nr_keys[i], true, false);
+		test_print_stats("Delete: random-search",
+				nr_keys[i], &bt->delete_rand_key);
+
+		bench_delete(lsk, &bt->add_key, &bt->delete_async,
+			     test_ips, nr_keys[i], false, true);
+		test_print_stats("Delete: async", nr_keys[i], &bt->delete_async);
+
+		free(test_ips);
+		close(lsk);
+	}
+
+	return NULL;
+}
+
+static void connect_client(int sk, void *arg)
+{
+	size_t *p = arg;
+
+	if (test_connect_socket(sk, this_ip_dest, test_server_port + *p) <= 0)
+		test_error("failed to connect()");
+}
+
+static void client_addr_setup(int sk, union tcp_addr taddr)
+{
+#ifdef IPV6_TEST
+	struct sockaddr_in6 addr = {
+		.sin6_family	= AF_INET6,
+		.sin6_port	= 0,
+		.sin6_addr	= taddr.a6,
+	};
+#else
+	struct sockaddr_in addr = {
+		.sin_family	= AF_INET,
+		.sin_port	= 0,
+		.sin_addr	= taddr.a4,
+	};
+#endif
+	int ret;
+
+	ret = ip_addr_add(veth_name, TEST_FAMILY, taddr, TEST_PREFIX);
+	if (ret && ret != -EEXIST)
+		test_error("Failed to add ip address");
+	ret = ip_route_add(veth_name, TEST_FAMILY, taddr, this_ip_dest);
+	if (ret && ret != -EEXIST)
+		test_error("Failed to add route");
+
+	if (bind(sk, &addr, sizeof(addr)))
+		test_error("bind()");
+}
+
+static void bench_connect_client(size_t port_off, struct bench_tests *bt,
+		union tcp_addr *ips, size_t ips_nr, bool rand_order)
+{
+	struct bench_stats *con;
+	union tcp_addr *p;
+	size_t i;
+
+	if (rand_order)
+		con = &bt->connect_rand_key;
+	else
+		con = &bt->connect_last_key;
+
+	p = (union tcp_addr *)&ips[0];
+
+	for (i = 0; i < BENCH_NR_ITERS; i++) {
+		int sk = socket(test_family, SOCK_STREAM, IPPROTO_TCP);
+
+		if (sk < 0)
+			test_error("socket()");
+
+		client_addr_setup(sk, *p);
+		if (test_add_key(sk, DEFAULT_TEST_PASSWORD, this_ip_dest,
+				 -1, 100, 100))
+			test_error("setsockopt(TCP_AO_ADD_KEY)");
+
+		synchronize_threads();
+
+		measure_call(con, connect_client, sk, (void *)&port_off);
+
+		close(sk);
+
+		/*
+		 * Slowest for FILO-linked-list:
+		 * on (i) iteration removing ips[i] element. When it gets
+		 * added to the list back - it becomes first to fetch, so
+		 * on (i + 1) iteration go to ips[i + 1] element.
+		 */
+		if (rand_order)
+			p = (union tcp_addr *)&ips[rand() % ips_nr];
+		else
+			p = (union tcp_addr *)&ips[i % ips_nr];
+	}
+}
+
+static void *client_fn(void *arg)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(nr_keys); i++) {
+		struct bench_tests *bt = &bench_results[i];
+
+		synchronize_threads();
+		bench_connect_client(i, bt, test_ips, nr_keys[i], false);
+		test_print_stats("Connect: worst case",
+				nr_keys[i], &bt->connect_last_key);
+
+		bench_connect_client(i, bt, test_ips, nr_keys[i], false);
+		test_print_stats("Connect: random-search",
+				nr_keys[i], &bt->connect_last_key);
+	}
+	synchronize_threads();
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	test_init(30, server_fn, client_fn);
+	return 0;
+}

-- 
2.43.0


