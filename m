Return-Path: <linux-kselftest+bounces-1983-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BEC813FEF
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 03:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0881F22DFC
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 02:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3722E6AA4;
	Fri, 15 Dec 2023 02:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="PAn/rUdD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953DFEC9
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Dec 2023 02:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40c32df9174so2225095e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 18:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1702607845; x=1703212645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snS36lEKEInsqbVDekZ2tneNzf23BuNU36j++uf6Hwc=;
        b=PAn/rUdDHe+JHClrjaVgTd3vwnJhn+/l0+6SqlxRNfDthGqeWs/8poBzkNsTn49hej
         u9xMi0310S+QWo6GUAz2d8YhzUF1qRjVTp+eUwq1i/37jZ8e8+twzkwR/ZqjclVUnrss
         /FYUN7iN3ugPrBx0yCu31rDaorRwPpI2rjNjN1/rRcSk6AFbS66Xtl0vnRDCaldZD1iL
         xoTSNPgp+u2UC/hsO6B966hQWt7Ye3+PMduTKLJVMvwA8sNZ3eQSC86S845vt1KvVwr7
         mZ1TOEFs3yS8x3oY3N9pqdFudDp+HsoBRgS14UBdFmEGy47tr6ysUHUgilyrIjtAGyo4
         mfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702607845; x=1703212645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snS36lEKEInsqbVDekZ2tneNzf23BuNU36j++uf6Hwc=;
        b=fY3SyHK1EGeTC/80iaK4MlsKSCAcNYskqfQSJTumtCvqULhiysgC4rWWuRQ5B/hHYR
         22cB3X9WCTL9wbcWilrWXh5Z490Bjb8nwipu0ABSWDbOxMeKbVueEaLf+JAoKOYZ+doJ
         9fD3KjWUaF9DF0TSmNYu+k6118FO/6wUjuufHD7u07H78XDvC5q5snJssPS2GiFHN8p3
         noyLrejVGEKUYKt+7xGtRyfphDOzHoS115nwi19x94RCZ714t7fubgoAYjkMi+O6oZMw
         QeoLk1flHNiC1GV6KTSQwhzT+x7+FLd3t1tPK5jW8kQSliuNS1qPZEUFzz+Blq3QURs+
         b28g==
X-Gm-Message-State: AOJu0Yw7rP9azQomeb0bewk2CnQYRwLRbT3JWQ5LA7CdjAuFKbScDjE+
	ku+nUdXP60LoahkupIIXenywTQ==
X-Google-Smtp-Source: AGHT+IEp5lCRJdXjv9Khut3FKqMO2nFNmyAe3+hYQ0nNkwcG2mg2MslkNtEGQfb5UmBXyaAtNQQU9Q==
X-Received: by 2002:a05:600c:3b23:b0:40b:5e21:c5ba with SMTP id m35-20020a05600c3b2300b0040b5e21c5bamr3840648wms.136.1702607844756;
        Thu, 14 Dec 2023 18:37:24 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id fc17-20020a05600c525100b0040c42681fcesm20096363wmb.15.2023.12.14.18.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 18:37:23 -0800 (PST)
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
Subject: [PATCH 02/12] selftests/net: Verify that TCP-AO complies with ignoring ICMPs
Date: Fri, 15 Dec 2023 02:36:16 +0000
Message-ID: <20231215-tcp-ao-selftests-v1-2-f6c08180b985@arista.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702607832; l=17469; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=ssihzIeqkCAsz+ESG6MtsS4y9A87cf92KRaPGpwXdPI=; b=QD2IeULrL+WHjbnKfJtxMskd+TBZV413w1pGcC/sxt9nfDtJI9QkicRs89nEygGMkPy2V8s4K vGoPLAFvnkzBW50vublZ26qLMVlKGemUkwcjN3bhE0OuLGRtEWWEqVC
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

Hand-crafted ICMP packets are sent to the server, the server checks for
hard/soft errors and fails if any.

Expected output for ipv4 version:
> # ./icmps-discard_ipv4
> 1..3
> # 3164[lib/setup.c:166] rand seed 1642623745
> TAP version 13
> # 3164[lib/proc.c:207]    Snmp6             Ip6InReceives: 0 => 1
> # 3164[lib/proc.c:207]    Snmp6             Ip6InNoRoutes: 0 => 1
> # 3164[lib/proc.c:207]    Snmp6               Ip6InOctets: 0 => 76
> # 3164[lib/proc.c:207]    Snmp6            Ip6InNoECTPkts: 0 => 1
> # 3164[lib/proc.c:207]      Tcp                    InSegs: 2 => 203
> # 3164[lib/proc.c:207]      Tcp                   OutSegs: 1 => 202
> # 3164[lib/proc.c:207]  IcmpMsg                   InType3: 0 => 543
> # 3164[lib/proc.c:207]     Icmp                    InMsgs: 0 => 543
> # 3164[lib/proc.c:207]     Icmp            InDestUnreachs: 0 => 543
> # 3164[lib/proc.c:207]       Ip                InReceives: 2 => 746
> # 3164[lib/proc.c:207]       Ip                InDelivers: 2 => 746
> # 3164[lib/proc.c:207]       Ip               OutRequests: 1 => 202
> # 3164[lib/proc.c:207]    IpExt                  InOctets: 132 => 61684
> # 3164[lib/proc.c:207]    IpExt                 OutOctets: 68 => 31324
> # 3164[lib/proc.c:207]    IpExt               InNoECTPkts: 2 => 744
> # 3164[lib/proc.c:207]   TcpExt               TCPPureAcks: 1 => 2
> # 3164[lib/proc.c:207]   TcpExt           TCPOrigDataSent: 0 => 200
> # 3164[lib/proc.c:207]   TcpExt              TCPDelivered: 0 => 199
> # 3164[lib/proc.c:207]   TcpExt                 TCPAOGood: 2 => 203
> # 3164[lib/proc.c:207]   TcpExt         TCPAODroppedIcmps: 0 => 541
> ok 1 InDestUnreachs delivered 543
> ok 2 Server survived 20000 bytes of traffic
> ok 3 ICMPs ignored 541
> # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0

Expected output for ipv6 version:
> # ./icmps-discard_ipv6
> 1..3
> # 3186[lib/setup.c:166] rand seed 1642623803
> TAP version 13
> # 3186[lib/proc.c:207]    Snmp6             Ip6InReceives: 4 => 568
> # 3186[lib/proc.c:207]    Snmp6             Ip6InDelivers: 3 => 564
> # 3186[lib/proc.c:207]    Snmp6            Ip6OutRequests: 2 => 204
> # 3186[lib/proc.c:207]    Snmp6            Ip6InMcastPkts: 1 => 4
> # 3186[lib/proc.c:207]    Snmp6           Ip6OutMcastPkts: 0 => 1
> # 3186[lib/proc.c:207]    Snmp6               Ip6InOctets: 320 => 70420
> # 3186[lib/proc.c:207]    Snmp6              Ip6OutOctets: 160 => 35512
> # 3186[lib/proc.c:207]    Snmp6          Ip6InMcastOctets: 72 => 336
> # 3186[lib/proc.c:207]    Snmp6         Ip6OutMcastOctets: 0 => 76
> # 3186[lib/proc.c:207]    Snmp6            Ip6InNoECTPkts: 4 => 568
> # 3186[lib/proc.c:207]    Snmp6               Icmp6InMsgs: 1 => 361
> # 3186[lib/proc.c:207]    Snmp6              Icmp6OutMsgs: 1 => 2
> # 3186[lib/proc.c:207]    Snmp6       Icmp6InDestUnreachs: 0 => 360
> # 3186[lib/proc.c:207]    Snmp6      Icmp6OutMLDv2Reports: 0 => 1
> # 3186[lib/proc.c:207]    Snmp6              Icmp6InType1: 0 => 360
> # 3186[lib/proc.c:207]    Snmp6           Icmp6OutType143: 0 => 1
> # 3186[lib/proc.c:207]      Tcp                    InSegs: 2 => 203
> # 3186[lib/proc.c:207]      Tcp                   OutSegs: 1 => 202
> # 3186[lib/proc.c:207]   TcpExt               TCPPureAcks: 1 => 2
> # 3186[lib/proc.c:207]   TcpExt           TCPOrigDataSent: 0 => 200
> # 3186[lib/proc.c:207]   TcpExt              TCPDelivered: 0 => 199
> # 3186[lib/proc.c:207]   TcpExt                 TCPAOGood: 2 => 203
> # 3186[lib/proc.c:207]   TcpExt         TCPAODroppedIcmps: 0 => 360
> ok 1 Icmp6InDestUnreachs delivered 360
> ok 2 Server survived 20000 bytes of traffic
> ok 3 ICMPs ignored 360
> # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/tcp_ao/Makefile        |   1 +
 tools/testing/selftests/net/tcp_ao/icmps-discard.c | 438 +++++++++++++++++++++
 2 files changed, 439 insertions(+)

diff --git a/tools/testing/selftests/net/tcp_ao/Makefile b/tools/testing/selftests/net/tcp_ao/Makefile
index 62425b9fb73c..0fc5db59be0c 100644
--- a/tools/testing/selftests/net/tcp_ao/Makefile
+++ b/tools/testing/selftests/net/tcp_ao/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 TEST_BOTH_AF := connect
+TEST_BOTH_AF += icmps-discard
 
 TEST_IPV4_PROGS := $(TEST_BOTH_AF:%=%_ipv4)
 TEST_IPV6_PROGS := $(TEST_BOTH_AF:%=%_ipv6)
diff --git a/tools/testing/selftests/net/tcp_ao/icmps-discard.c b/tools/testing/selftests/net/tcp_ao/icmps-discard.c
new file mode 100644
index 000000000000..d77c791754de
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_ao/icmps-discard.c
@@ -0,0 +1,438 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Selftest that verifies that incomping ICMPs are ignored,
+ * the TCP connection stays alive, no hard or soft errors get reported
+ * to the usespace and the counter for ignored ICMPs is updated.
+ *
+ * RFC5925, 7.8:
+ * >> A TCP-AO implementation MUST default to ignore incoming ICMPv4
+ * messages of Type 3 (destination unreachable), Codes 2-4 (protocol
+ * unreachable, port unreachable, and fragmentation needed -- ’hard
+ * errors’), and ICMPv6 Type 1 (destination unreachable), Code 1
+ * (administratively prohibited) and Code 4 (port unreachable) intended
+ * for connections in synchronized states (ESTABLISHED, FIN-WAIT-1, FIN-
+ * WAIT-2, CLOSE-WAIT, CLOSING, LAST-ACK, TIME-WAIT) that match MKTs.
+ *
+ * Author: Dmitry Safonov <dima@arista.com>
+ */
+#include <inttypes.h>
+#include <linux/icmp.h>
+#include <linux/icmpv6.h>
+#include <linux/ipv6.h>
+#include <netinet/in.h>
+#include <netinet/ip.h>
+#include <sys/socket.h>
+#include "aolib.h"
+#include "../../../../include/linux/compiler.h"
+
+const size_t packets_nr = 20;
+const size_t packet_size = 100;
+const char *tcpao_icmps	= "TCPAODroppedIcmps";
+
+#ifdef IPV6_TEST
+const char *dst_unreach	= "Icmp6InDestUnreachs";
+const int sk_ip_level	= SOL_IPV6;
+const int sk_recverr	= IPV6_RECVERR;
+#else
+const char *dst_unreach	= "InDestUnreachs";
+const int sk_ip_level	= SOL_IP;
+const int sk_recverr	= IP_RECVERR;
+#endif
+
+#define test_icmps_fail test_fail
+#define test_icmps_ok test_ok
+
+static void serve_interfered(int sk)
+{
+	ssize_t test_quota = packet_size * packets_nr * 10;
+	uint64_t dest_unreach_a, dest_unreach_b;
+	uint64_t icmp_ignored_a, icmp_ignored_b;
+	struct tcp_ao_counters ao_cnt1, ao_cnt2;
+	bool counter_not_found;
+	struct netstat *ns_after, *ns_before;
+	ssize_t bytes;
+
+	ns_before = netstat_read();
+	dest_unreach_a = netstat_get(ns_before, dst_unreach, NULL);
+	icmp_ignored_a = netstat_get(ns_before, tcpao_icmps, NULL);
+	if (test_get_tcp_ao_counters(sk, &ao_cnt1))
+		test_error("test_get_tcp_ao_counters()");
+	bytes = test_server_run(sk, test_quota, 0);
+	ns_after = netstat_read();
+	netstat_print_diff(ns_before, ns_after);
+	dest_unreach_b = netstat_get(ns_after, dst_unreach, NULL);
+	icmp_ignored_b = netstat_get(ns_after, tcpao_icmps,
+					&counter_not_found);
+	if (test_get_tcp_ao_counters(sk, &ao_cnt2))
+		test_error("test_get_tcp_ao_counters()");
+
+	netstat_free(ns_before);
+	netstat_free(ns_after);
+
+	if (dest_unreach_a >= dest_unreach_b) {
+		test_fail("%s counter didn't change: %" PRIu64 " >= %" PRIu64,
+				dst_unreach, dest_unreach_a, dest_unreach_b);
+		return;
+	}
+	test_ok("%s delivered %" PRIu64,
+		dst_unreach, dest_unreach_b - dest_unreach_a);
+	if (bytes < 0)
+		test_icmps_fail("Server failed with %zd: %s", bytes, strerrordesc_np(-bytes));
+	else
+		test_icmps_ok("Server survived %zd bytes of traffic", test_quota);
+	if (counter_not_found) {
+		test_fail("Not found %s counter", tcpao_icmps);
+		return;
+	}
+	test_tcp_ao_counters_cmp(NULL, &ao_cnt1, &ao_cnt2, TEST_CNT_GOOD | TEST_CNT_AO_DROPPED_ICMP);
+	if (icmp_ignored_a >= icmp_ignored_b) {
+		test_icmps_fail("%s counter didn't change: %" PRIu64 " >= %" PRIu64,
+				tcpao_icmps, icmp_ignored_a, icmp_ignored_b);
+		return;
+	}
+	test_icmps_ok("ICMPs ignored %" PRIu64, icmp_ignored_b - icmp_ignored_a);
+}
+
+static void *server_fn(void *arg)
+{
+	int val, err, sk, lsk;
+	bool accept_icmps = false;
+
+	lsk = test_listen_socket(this_ip_addr, test_server_port, 1);
+
+	if (test_set_ao_flags(lsk, false, accept_icmps))
+		test_error("setsockopt(TCP_AO_INFO)");
+
+	if (test_add_key(lsk, DEFAULT_TEST_PASSWORD, this_ip_dest, -1, 100, 100))
+		test_error("setsockopt(TCP_AO_ADD_KEY)");
+	synchronize_threads();
+
+	err = test_wait_fd(lsk, TEST_TIMEOUT_SEC, 0);
+	if (!err)
+		test_error("timeouted for accept()");
+	else if (err < 0)
+		test_error("test_wait_fd()");
+
+	sk = accept(lsk, NULL, NULL);
+	if (sk < 0)
+		test_error("accept()");
+
+	/* Fail on hard ip errors, such as dest unreachable (RFC1122) */
+	val = 1;
+	if (setsockopt(sk, sk_ip_level, sk_recverr, &val, sizeof(val)))
+		test_error("setsockopt()");
+
+	synchronize_threads();
+
+	serve_interfered(sk);
+	return NULL;
+}
+
+static size_t packets_sent;
+static size_t icmps_sent;
+
+static uint32_t checksum4_nofold(void *data, size_t len, uint32_t sum)
+{
+	uint16_t *words = data;
+	size_t i;
+
+	for (i = 0; i < len / sizeof(uint16_t); i++)
+		sum += words[i];
+	if (len & 1)
+		sum += ((char *)data)[len - 1];
+	return sum;
+}
+
+static uint16_t checksum4_fold(void *data, size_t len, uint32_t sum)
+{
+	sum = checksum4_nofold(data, len, sum);
+	while (sum > 0xFFFF)
+		sum = (sum & 0xFFFF) + (sum >> 16);
+	return ~sum;
+}
+
+static void set_ip4hdr(struct iphdr *iph, size_t packet_len, int proto,
+		struct sockaddr_in *src, struct sockaddr_in *dst)
+{
+	iph->version	= 4;
+	iph->ihl	= 5;
+	iph->tos	= 0;
+	iph->tot_len	= htons(packet_len);
+	iph->ttl	= 2;
+	iph->protocol	= proto;
+	iph->saddr	= src->sin_addr.s_addr;
+	iph->daddr	= dst->sin_addr.s_addr;
+	iph->check	= checksum4_fold((void *)iph, iph->ihl << 1, 0);
+}
+
+static void icmp_interfere4(uint8_t type, uint8_t code, uint32_t rcv_nxt,
+		struct sockaddr_in *src, struct sockaddr_in *dst)
+{
+	int sk = socket(AF_INET, SOCK_RAW, IPPROTO_RAW);
+	struct {
+		struct iphdr iph;
+		struct icmphdr icmph;
+		struct iphdr iphe;
+		struct {
+			uint16_t sport;
+			uint16_t dport;
+			uint32_t seq;
+		} tcph;
+	} packet = {};
+	size_t packet_len;
+	ssize_t bytes;
+
+	if (sk < 0)
+		test_error("socket(AF_INET, SOCK_RAW, IPPROTO_RAW)");
+
+	packet_len = sizeof(packet);
+	set_ip4hdr(&packet.iph, packet_len, IPPROTO_ICMP, src, dst);
+
+	packet.icmph.type = type;
+	packet.icmph.code = code;
+	if (code == ICMP_FRAG_NEEDED) {
+		randomize_buffer(&packet.icmph.un.frag.mtu,
+				sizeof(packet.icmph.un.frag.mtu));
+	}
+
+	packet_len = sizeof(packet.iphe) + sizeof(packet.tcph);
+	set_ip4hdr(&packet.iphe, packet_len, IPPROTO_TCP, dst, src);
+
+	packet.tcph.sport = dst->sin_port;
+	packet.tcph.dport = src->sin_port;
+	packet.tcph.seq = htonl(rcv_nxt);
+
+	packet_len = sizeof(packet) - sizeof(packet.iph);
+	packet.icmph.checksum = checksum4_fold((void *)&packet.icmph,
+						packet_len, 0);
+
+	bytes = sendto(sk, &packet, sizeof(packet), 0,
+		       (struct sockaddr *)dst, sizeof(*dst));
+	if (bytes != sizeof(packet))
+		test_error("send(): %zd", bytes);
+	icmps_sent++;
+
+	close(sk);
+}
+
+static void set_ip6hdr(struct ipv6hdr *iph, size_t packet_len, int proto,
+		struct sockaddr_in6 *src, struct sockaddr_in6 *dst)
+{
+	iph->version		= 6;
+	iph->payload_len	= htons(packet_len);
+	iph->nexthdr		= proto;
+	iph->hop_limit		= 2;
+	iph->saddr		= src->sin6_addr;
+	iph->daddr		= dst->sin6_addr;
+}
+
+static inline uint16_t csum_fold(uint32_t csum)
+{
+	uint32_t sum = csum;
+
+	sum = (sum & 0xffff) + (sum >> 16);
+	sum = (sum & 0xffff) + (sum >> 16);
+	return (uint16_t)~sum;
+}
+
+static inline uint32_t csum_add(uint32_t csum, uint32_t addend)
+{
+	uint32_t res = csum;
+
+	res += addend;
+	return res + (res < addend);
+}
+
+noinline uint32_t checksum6_nofold(void *data, size_t len, uint32_t sum)
+{
+	uint16_t *words = data;
+	size_t i;
+
+	for (i = 0; i < len / sizeof(uint16_t); i++)
+		sum = csum_add(sum, words[i]);
+	if (len & 1)
+		sum = csum_add(sum, ((char *)data)[len - 1]);
+	return sum;
+}
+
+noinline uint16_t icmp6_checksum(struct sockaddr_in6 *src,
+				 struct sockaddr_in6 *dst,
+				 void *ptr, size_t len, uint8_t proto)
+{
+	struct {
+		struct in6_addr saddr;
+		struct in6_addr daddr;
+		uint32_t payload_len;
+		uint8_t zero[3];
+		uint8_t nexthdr;
+	} pseudo_header = {};
+	uint32_t sum;
+
+	pseudo_header.saddr		= src->sin6_addr;
+	pseudo_header.daddr		= dst->sin6_addr;
+	pseudo_header.payload_len	= htonl(len);
+	pseudo_header.nexthdr		= proto;
+
+	sum = checksum6_nofold(&pseudo_header, sizeof(pseudo_header), 0);
+	sum = checksum6_nofold(ptr, len, sum);
+
+	return csum_fold(sum);
+}
+
+static void icmp6_interfere(int type, int code, uint32_t rcv_nxt,
+		struct sockaddr_in6 *src, struct sockaddr_in6 *dst)
+{
+	int sk = socket(AF_INET6, SOCK_RAW, IPPROTO_RAW);
+	struct sockaddr_in6 dst_raw = *dst;
+	struct {
+		struct ipv6hdr iph;
+		struct icmp6hdr icmph;
+		struct ipv6hdr iphe;
+		struct {
+			uint16_t sport;
+			uint16_t dport;
+			uint32_t seq;
+		} tcph;
+	} packet = {};
+	size_t packet_len;
+	ssize_t bytes;
+
+
+	if (sk < 0)
+		test_error("socket(AF_INET6, SOCK_RAW, IPPROTO_RAW)");
+
+	packet_len = sizeof(packet) - sizeof(packet.iph);
+	set_ip6hdr(&packet.iph, packet_len, IPPROTO_ICMPV6, src, dst);
+
+	packet.icmph.icmp6_type = type;
+	packet.icmph.icmp6_code = code;
+
+	packet_len = sizeof(packet.iphe) + sizeof(packet.tcph);
+	set_ip6hdr(&packet.iphe, packet_len, IPPROTO_TCP, dst, src);
+
+	packet.tcph.sport = dst->sin6_port;
+	packet.tcph.dport = src->sin6_port;
+	packet.tcph.seq = htonl(rcv_nxt);
+
+	packet_len = sizeof(packet) - sizeof(packet.iph);
+
+	packet.icmph.icmp6_cksum = icmp6_checksum(src, dst,
+			(void *)&packet.icmph, packet_len, IPPROTO_ICMPV6);
+
+	dst_raw.sin6_port = htons(IPPROTO_RAW);
+	bytes = sendto(sk, &packet, sizeof(packet), 0,
+		       (struct sockaddr *)&dst_raw, sizeof(dst_raw));
+	if (bytes != sizeof(packet))
+		test_error("send(): %zd", bytes);
+	icmps_sent++;
+
+	close(sk);
+}
+
+static uint32_t get_rcv_nxt(int sk)
+{
+	int val = TCP_REPAIR_ON;
+	uint32_t ret;
+	socklen_t sz = sizeof(ret);
+
+	if (setsockopt(sk, SOL_TCP, TCP_REPAIR, &val, sizeof(val)))
+		test_error("setsockopt(TCP_REPAIR)");
+	val = TCP_RECV_QUEUE;
+	if (setsockopt(sk, SOL_TCP, TCP_REPAIR_QUEUE, &val, sizeof(val)))
+		test_error("setsockopt(TCP_REPAIR_QUEUE)");
+	if (getsockopt(sk, SOL_TCP, TCP_QUEUE_SEQ, &ret, &sz))
+		test_error("getsockopt(TCP_QUEUE_SEQ)");
+	val = TCP_REPAIR_OFF_NO_WP;
+	if (setsockopt(sk, SOL_TCP, TCP_REPAIR, &val, sizeof(val)))
+		test_error("setsockopt(TCP_REPAIR)");
+	return ret;
+}
+
+static void icmp_interfere(const size_t nr, uint32_t rcv_nxt, void *src, void *dst)
+{
+	struct sockaddr_in *saddr4 = src;
+	struct sockaddr_in *daddr4 = dst;
+	struct sockaddr_in6 *saddr6 = src;
+	struct sockaddr_in6 *daddr6 = dst;
+	size_t i;
+
+	if (saddr4->sin_family != daddr4->sin_family)
+		test_error("Different address families");
+
+	for (i = 0; i < nr; i++) {
+		if (saddr4->sin_family == AF_INET) {
+			icmp_interfere4(ICMP_DEST_UNREACH, ICMP_PROT_UNREACH,
+					rcv_nxt, saddr4, daddr4);
+			icmp_interfere4(ICMP_DEST_UNREACH, ICMP_PORT_UNREACH,
+					rcv_nxt, saddr4, daddr4);
+			icmp_interfere4(ICMP_DEST_UNREACH, ICMP_FRAG_NEEDED,
+					rcv_nxt, saddr4, daddr4);
+			icmps_sent += 3;
+		} else if (saddr4->sin_family == AF_INET6) {
+			icmp6_interfere(ICMPV6_DEST_UNREACH,
+					ICMPV6_ADM_PROHIBITED,
+					rcv_nxt, saddr6, daddr6);
+			icmp6_interfere(ICMPV6_DEST_UNREACH,
+					ICMPV6_PORT_UNREACH,
+					rcv_nxt, saddr6, daddr6);
+			icmps_sent += 2;
+		} else {
+			test_error("Not ip address family");
+		}
+	}
+}
+
+static void send_interfered(int sk)
+{
+	const unsigned int timeout = TEST_TIMEOUT_SEC;
+	struct sockaddr_in6 src, dst;
+	socklen_t addr_sz;
+
+	addr_sz = sizeof(src);
+	if (getsockname(sk, &src, &addr_sz))
+		test_error("getsockname()");
+	addr_sz = sizeof(dst);
+	if (getpeername(sk, &dst, &addr_sz))
+		test_error("getpeername()");
+
+	while (1) {
+		uint32_t rcv_nxt;
+
+		if (test_client_verify(sk, packet_size, packets_nr, timeout)) {
+			test_fail("client: connection is broken");
+			return;
+		}
+		packets_sent += packets_nr;
+		rcv_nxt = get_rcv_nxt(sk);
+		icmp_interfere(packets_nr, rcv_nxt, (void *)&src, (void *)&dst);
+	}
+}
+
+static void *client_fn(void *arg)
+{
+	int sk = socket(test_family, SOCK_STREAM, IPPROTO_TCP);
+
+	if (sk < 0)
+		test_error("socket()");
+
+	if (test_add_key(sk, DEFAULT_TEST_PASSWORD, this_ip_dest, -1, 100, 100))
+		test_error("setsockopt(TCP_AO_ADD_KEY)");
+
+	synchronize_threads();
+	if (test_connect_socket(sk, this_ip_dest, test_server_port) <= 0)
+		test_error("failed to connect()");
+	synchronize_threads();
+
+	send_interfered(sk);
+
+	/* Not expecting client to quit */
+	test_fail("client disconnected");
+
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	test_init(3, server_fn, client_fn);
+	return 0;
+}

-- 
2.43.0


