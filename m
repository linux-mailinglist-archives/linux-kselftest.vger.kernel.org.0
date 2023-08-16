Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C2977D8AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 04:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241359AbjHPC4z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 22:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241448AbjHPC4h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 22:56:37 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F55F212D
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 19:56:35 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-76d70d17ab8so7978785a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 19:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1692154594; x=1692759394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wUS22k3AgcW7X1Fk7O5pl817ZLlS8d3V4wXOz1NMjBc=;
        b=tzza1nbLRB8tbdUG8ocRV16I6ZnKOByzToRA2xU6kZXHAGDsmmmGm2sOzBJKbA3t0e
         4zjkr+C6ZZGHDCtZMS3lIwRkoMGrc9SzfpPwfTr6KzcmXhXgWN/7yBcf9faXI3FTBDGa
         mZuc1c4raeXY7x/06gX+QvGNTm/IrBuQfwR8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692154594; x=1692759394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUS22k3AgcW7X1Fk7O5pl817ZLlS8d3V4wXOz1NMjBc=;
        b=PU9dXZyKu5eSI7NhbuhvdrItTmzW5Oqy/8mgDKVgVKFQ0fIGY84JiGf50tHRws8oeO
         tstUT7cLrr+Tb0XIjx6laaxKaxozS1+q9WPN3VlQKtIE+uQ8GcFQqoDF+3LxyNFicLjI
         wG8BMrLbOZjeIZB951RllPyU49rnGhPxhYwpHYX6jWkt0RHlVUvtfJBgYZfK5MyM6h6T
         08kelTlyG2RfHjdXCN/w/yNHh93rCZargo1DWD9KR00zB8P0Xirmq/osYV8j3x7uI5Wc
         ChjnurvIekaDBgwCWQeOhngyHCynH2eMaObE+W2QFxMWb0F7tG4nuowRhcr4HmIChY0h
         nWiw==
X-Gm-Message-State: AOJu0YwXkyRl2ahlTvvUt1OeYLlXb09Ls0VvostvvT84VP3bUIrrhAcZ
        0m9+ltlFRtKjpc8/D6Douw2acg==
X-Google-Smtp-Source: AGHT+IESBkcivUQmO8KQstVRbxG1ZYE+IqctD3ngwgi91s6USXC8ccBqkCKegatKNgP4AuwKaRIXUg==
X-Received: by 2002:a05:620a:178c:b0:75b:23a0:d9dc with SMTP id ay12-20020a05620a178c00b0075b23a0d9dcmr770197qkb.50.1692154594413;
        Tue, 15 Aug 2023 19:56:34 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id c7-20020a05620a11a700b0076827ce13f6sm4174464qkk.10.2023.08.15.19.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 19:56:33 -0700 (PDT)
Date:   Tue, 15 Aug 2023 19:56:31 -0700
From:   Yan Zhai <yan@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Yan Zhai <yan@cloudflare.com>, Thomas Graf <tgraf@suug.ch>,
        Jordan Griege <jgriege@cloudflare.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v5 bpf 3/4] selftests/bpf: add lwt_xmit tests for BPF_REDIRECT
Message-ID: <8d0477aaee535503082de6a85793ffb0be73fccb.1692153515.git.yan@cloudflare.com>
References: <cover.1692153515.git.yan@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1692153515.git.yan@cloudflare.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is no lwt_xmit selftest for BPF_REDIRECT yet. Add test cases for
both normal and abnormal situations. For abnormal test cases, devices
are set down or have its carrier set down. Without proper fixes,
BPF_REDIRECT to either ingress or egress of such device would panic the
kernel, so please run the test in a VM for safety.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 .../selftests/bpf/prog_tests/lwt_helpers.h    | 139 ++++++++
 .../selftests/bpf/prog_tests/lwt_redirect.c   | 319 ++++++++++++++++++
 .../selftests/bpf/progs/test_lwt_redirect.c   |  58 ++++
 3 files changed, 516 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lwt_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_lwt_redirect.c

diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h b/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h
new file mode 100644
index 000000000000..61333f2a03f9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h
@@ -0,0 +1,139 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __LWT_HELPERS_H
+#define __LWT_HELPERS_H
+
+#include <time.h>
+#include <net/if.h>
+#include <linux/if_tun.h>
+#include <linux/icmp.h>
+
+#include "test_progs.h"
+
+#define log_err(MSG, ...) \
+	fprintf(stderr, "(%s:%d: errno: %s) " MSG "\n", \
+		__FILE__, __LINE__, strerror(errno), ##__VA_ARGS__)
+
+#define RUN_TEST(name)                                                        \
+	({                                                                    \
+		if (test__start_subtest(#name))                               \
+			if (ASSERT_OK(netns_create(), "netns_create")) {      \
+				struct nstoken *token = open_netns(NETNS);    \
+				if (ASSERT_OK_PTR(token, "setns")) {          \
+					test_ ## name();                      \
+					close_netns(token);                   \
+				}                                             \
+				netns_delete();                               \
+			}                                                     \
+	})
+
+#define NETNS "ns_lwt"
+
+static inline int netns_create(void)
+{
+	return system("ip netns add " NETNS);
+}
+
+static inline int netns_delete(void)
+{
+	return system("ip netns del " NETNS ">/dev/null 2>&1");
+}
+
+static int open_tuntap(const char *dev_name, bool need_mac)
+{
+	int err = 0;
+	struct ifreq ifr;
+	int fd = open("/dev/net/tun", O_RDWR);
+
+	if (!ASSERT_GT(fd, 0, "open(/dev/net/tun)"))
+		return -1;
+
+	ifr.ifr_flags = IFF_NO_PI | (need_mac ? IFF_TAP : IFF_TUN);
+	memcpy(ifr.ifr_name, dev_name, IFNAMSIZ);
+
+	err = ioctl(fd, TUNSETIFF, &ifr);
+	if (!ASSERT_OK(err, "ioctl(TUNSETIFF)")) {
+		close(fd);
+		return -1;
+	}
+
+	err = fcntl(fd, F_SETFL, O_NONBLOCK);
+	if (!ASSERT_OK(err, "fcntl(O_NONBLOCK)")) {
+		close(fd);
+		return -1;
+	}
+
+	return fd;
+}
+
+#define ICMP_PAYLOAD_SIZE     100
+
+/* Match an ICMP packet with payload len ICMP_PAYLOAD_SIZE */
+static int __expect_icmp_ipv4(char *buf, ssize_t len)
+{
+	struct iphdr *ip = (struct iphdr *)buf;
+	struct icmphdr *icmp = (struct icmphdr *)(ip + 1);
+	ssize_t min_header_len = sizeof(*ip) + sizeof(*icmp);
+
+	if (len < min_header_len)
+		return -1;
+
+	if (ip->protocol != IPPROTO_ICMP)
+		return -1;
+
+	if (icmp->type != ICMP_ECHO)
+		return -1;
+
+	return len == ICMP_PAYLOAD_SIZE + min_header_len;
+}
+
+typedef int (*filter_t) (char *, ssize_t);
+
+/* wait_for_packet - wait for a packet that matches the filter
+ *
+ * @fd: tun fd/packet socket to read packet
+ * @filter: filter function, returning 1 if matches
+ * @timeout: timeout to wait for the packet
+ *
+ * Returns 1 if a matching packet is read, 0 if timeout expired, -1 on error.
+ */
+static int wait_for_packet(int fd, filter_t filter, struct timeval *timeout)
+{
+	char buf[4096];
+	int max_retry = 5; /* in case we read some spurious packets */
+	fd_set fds;
+
+	FD_ZERO(&fds);
+	while (max_retry--) {
+		/* Linux modifies timeout arg... So make a copy */
+		struct timeval copied_timeout = *timeout;
+		ssize_t ret = -1;
+
+		FD_SET(fd, &fds);
+
+		ret = select(1 + fd, &fds, NULL, NULL, &copied_timeout);
+		if (ret <= 0) {
+			if (errno == EINTR)
+				continue;
+			else if (errno == EAGAIN || ret == 0)
+				return 0;
+
+			log_err("select failed");
+			return -1;
+		}
+
+		ret = read(fd, buf, sizeof(buf));
+
+		if (ret <= 0) {
+			log_err("read(dev): %ld", ret);
+			return -1;
+		}
+
+		if (filter && filter(buf, ret) > 0)
+			return 1;
+	}
+
+	return 0;
+}
+
+#endif /* __LWT_HELPERS_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c b/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
new file mode 100644
index 000000000000..818642064bcb
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+
+/*
+ * Test suite of lwt_xmit BPF programs that redirect packets
+ *   The file tests focus not only if these programs work as expected normally,
+ *   but also if they can handle abnormal situations gracefully.
+ *
+ * WARNING
+ * -------
+ *  This test suite may crash the kernel, thus should be run in a VM.
+ *
+ * Setup:
+ * ---------
+ *  All tests are performed in a single netns. Two lwt encap routes are setup for
+ *  each subtest:
+ *
+ *    ip route add 10.0.0.2 encap bpf xmit <obj> sec "<ingress_sec>" dev link_err
+ *    ip route add 10.0.0.3 encap bpf xmit <obj> sec "<egress_sec>" dev link_err
+ *
+ *  Here <obj> is statically defined to test_lwt_redirect.bpf.o, and each section
+ *  of this object holds a program entry to test. The BPF object is built from
+ *  progs/test_lwt_redirect.c. We didn't use generated BPF skeleton since the
+ *  attachment for lwt programs are not supported by libbpf yet.
+ *
+ *  For testing, a ping command is running in the test netns:
+ *
+ *    ping -m <ifindex> 10.0.0.<N> -c 1 -w 1 -s 100
+ *
+ *  All the BPF redirect program use the packet mark as output device index.
+ *
+ * Scenarios:
+ * --------------------------------
+ *  1. Redirect to a running tap/tun device
+ *  2. Redirect to a down tap/tun device
+ *  3. Redirect to a vlan device with lower layer down
+ *
+ *  Case 1, ping packets should be received by packet socket on target device
+ *  when redirected to ingress, and by tun/tap fd when redirected to egress.
+ *
+ *  Case 2,3 are considered successful as long as they do not crash the kernel
+ *  as a regression.
+ *
+ *  Case 1,2 use tap device to test redirect to device that requires MAC
+ *  header, and tun device to test the case with no MAC header added.
+ */
+#include <sys/socket.h>
+#include <net/if.h>
+#include <linux/if_ether.h>
+#include <linux/if_packet.h>
+#include <linux/if_tun.h>
+#include <linux/icmp.h>
+#include <arpa/inet.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <stdlib.h>
+
+#include "lwt_helpers.h"
+#include "test_progs.h"
+#include "network_helpers.h"
+
+#define BPF_OBJECT            "test_lwt_redirect.bpf.o"
+#define INGRESS_SEC(need_mac) ((need_mac) ? "redir_ingress" : "redir_ingress_nomac")
+#define EGRESS_SEC(need_mac)  ((need_mac) ? "redir_egress" : "redir_egress_nomac")
+#define LOCAL_SRC             "10.0.0.1"
+#define IP_TO_INGRESS         "10.0.0.2"
+#define IP_TO_EGRESS          "10.0.0.3"
+
+/* ping to redirect toward given dev, with mark being its index */
+static void ping_dev(const char *dev, const char *ip)
+{
+	int link_index = if_nametoindex(dev);
+
+	if (!ASSERT_GE(link_index, 0, "if_nametoindex"))
+		return;
+
+	/* We won't get a reply. Don't fail here */
+	SYS_NOFAIL("ping -m %d %s -c1 -w1 -s %d >/dev/null 2>&1",
+		   link_index, ip, ICMP_PAYLOAD_SIZE);
+}
+
+static int new_packet_sock(const char *ifname)
+{
+	int err = 0;
+	int ignore_outgoing = 1;
+	int ifindex = -1;
+	int s = -1;
+
+	s = socket(AF_PACKET, SOCK_RAW, 0);
+	if (!ASSERT_GE(s, 0, "socket(AF_PACKET)"))
+		return -1;
+
+	ifindex = if_nametoindex(ifname);
+	if (!ASSERT_GE(ifindex, 0, "if_nametoindex")) {
+		close(s);
+		return -1;
+	}
+
+	struct sockaddr_ll addr = {
+		.sll_family = AF_PACKET,
+		.sll_protocol = htons(ETH_P_IP),
+		.sll_ifindex = ifindex,
+	};
+
+	err = bind(s, (struct sockaddr *)&addr, sizeof(addr));
+	if (!ASSERT_OK(err, "bind(AF_PACKET)")) {
+		close(s);
+		return -1;
+	}
+
+	/* Use packet socket to capture only the ingress, so we can distinguish
+	 * the case where a regression that actually redirects the packet to
+	 * the egress.
+	 */
+	err = setsockopt(s, SOL_PACKET, PACKET_IGNORE_OUTGOING,
+			 &ignore_outgoing, sizeof(ignore_outgoing));
+	if (!ASSERT_OK(err, "setsockopt(PACKET_IGNORE_OUTGOING)")) {
+		close(s);
+		return -1;
+	}
+
+	err = fcntl(s, F_SETFL, O_NONBLOCK);
+	if (!ASSERT_OK(err, "fcntl(O_NONBLOCK)")) {
+		close(s);
+		return -1;
+	}
+
+	return s;
+}
+
+static int expect_icmp(char *buf, ssize_t len)
+{
+	struct ethhdr *eth = (struct ethhdr *)buf;
+
+	if (len < (ssize_t)sizeof(*eth))
+		return -1;
+
+	if (eth->h_proto == htons(ETH_P_IP))
+		return __expect_icmp_ipv4((char *)(eth + 1), len - sizeof(*eth));
+
+	return -1;
+}
+
+static int expect_icmp_nomac(char *buf, ssize_t len)
+{
+	return __expect_icmp_ipv4(buf, len);
+}
+
+static void send_and_capture_test_packets(const char *test_name, int tap_fd,
+					  const char *target_dev, bool need_mac)
+{
+	int psock = -1;
+	struct timeval timeo = {
+		.tv_sec = 0,
+		.tv_usec = 250000,
+	};
+	int ret = -1;
+
+	filter_t filter = need_mac ? expect_icmp : expect_icmp_nomac;
+
+	ping_dev(target_dev, IP_TO_EGRESS);
+
+	ret = wait_for_packet(tap_fd, filter, &timeo);
+	if (!ASSERT_EQ(ret, 1, "wait_for_epacket")) {
+		log_err("%s egress test fails", test_name);
+		goto out;
+	}
+
+	psock = new_packet_sock(target_dev);
+	ping_dev(target_dev, IP_TO_INGRESS);
+
+	ret = wait_for_packet(psock, filter, &timeo);
+	if (!ASSERT_EQ(ret, 1, "wait_for_ipacket")) {
+		log_err("%s ingress test fails", test_name);
+		goto out;
+	}
+
+out:
+	if (psock >= 0)
+		close(psock);
+}
+
+static int setup_redirect_target(const char *target_dev, bool need_mac)
+{
+	int target_index = -1;
+	int tap_fd = -1;
+
+	tap_fd = open_tuntap(target_dev, need_mac);
+	if (!ASSERT_GE(tap_fd, 0, "open_tuntap"))
+		goto fail;
+
+	target_index = if_nametoindex(target_dev);
+	if (!ASSERT_GE(target_index, 0, "if_nametoindex"))
+		goto fail;
+
+	SYS(fail, "ip link add link_err type dummy");
+	SYS(fail, "ip link set lo up");
+	SYS(fail, "ip addr add dev lo " LOCAL_SRC "/32");
+	SYS(fail, "ip link set link_err up");
+	SYS(fail, "ip link set %s up", target_dev);
+
+	SYS(fail, "ip route add %s dev link_err encap bpf xmit obj %s sec %s",
+	    IP_TO_INGRESS, BPF_OBJECT, INGRESS_SEC(need_mac));
+	SYS(fail, "ip route add %s dev link_err encap bpf xmit obj %s sec %s",
+	    IP_TO_EGRESS, BPF_OBJECT, EGRESS_SEC(need_mac));
+
+	return tap_fd;
+
+fail:
+	if (tap_fd >= 0)
+		close(tap_fd);
+	return -1;
+}
+
+static void test_lwt_redirect_normal(void)
+{
+	const char *target_dev = "tap0";
+	int tap_fd = -1;
+	bool need_mac = true;
+
+	tap_fd = setup_redirect_target(target_dev, need_mac);
+	if (!ASSERT_GE(tap_fd, 0, "setup_redirect_target"))
+		return;
+
+	send_and_capture_test_packets(__func__, tap_fd, target_dev, need_mac);
+	close(tap_fd);
+}
+
+static void test_lwt_redirect_normal_nomac(void)
+{
+	const char *target_dev = "tun0";
+	int tap_fd = -1;
+	bool need_mac = false;
+
+	tap_fd = setup_redirect_target(target_dev, need_mac);
+	if (!ASSERT_GE(tap_fd, 0, "setup_redirect_target"))
+		return;
+
+	send_and_capture_test_packets(__func__, tap_fd, target_dev, need_mac);
+	close(tap_fd);
+}
+
+/* This test aims to prevent regression of future. As long as the kernel does
+ * not panic, it is considered as success.
+ */
+static void __test_lwt_redirect_dev_down(bool need_mac)
+{
+	const char *target_dev = "tap0";
+	int tap_fd = -1;
+
+	tap_fd = setup_redirect_target(target_dev, need_mac);
+	if (!ASSERT_GE(tap_fd, 0, "setup_redirect_target"))
+		return;
+
+	SYS(out, "ip link set %s down", target_dev);
+	ping_dev(target_dev, IP_TO_INGRESS);
+	ping_dev(target_dev, IP_TO_EGRESS);
+
+out:
+	close(tap_fd);
+}
+
+static void test_lwt_redirect_dev_down(void)
+{
+	__test_lwt_redirect_dev_down(true);
+}
+
+static void test_lwt_redirect_dev_down_nomac(void)
+{
+	__test_lwt_redirect_dev_down(false);
+}
+
+/* This test aims to prevent regression of future. As long as the kernel does
+ * not panic, it is considered as success.
+ */
+static void test_lwt_redirect_dev_carrier_down(void)
+{
+	const char *lower_dev = "tap0";
+	const char *vlan_dev = "vlan100";
+	int tap_fd = -1;
+
+	tap_fd = setup_redirect_target(lower_dev, true);
+	if (!ASSERT_GE(tap_fd, 0, "setup_redirect_target"))
+		return;
+
+	SYS(out, "ip link add vlan100 link %s type vlan id 100", lower_dev);
+	SYS(out, "ip link set %s up", vlan_dev);
+	SYS(out, "ip link set %s down", lower_dev);
+	ping_dev(vlan_dev, IP_TO_INGRESS);
+	ping_dev(vlan_dev, IP_TO_EGRESS);
+
+out:
+	close(tap_fd);
+}
+
+static void *test_lwt_redirect_run(void *arg)
+{
+	netns_delete();
+	RUN_TEST(lwt_redirect_normal);
+	RUN_TEST(lwt_redirect_normal_nomac);
+	RUN_TEST(lwt_redirect_dev_down);
+	RUN_TEST(lwt_redirect_dev_down_nomac);
+	RUN_TEST(lwt_redirect_dev_carrier_down);
+	return NULL;
+}
+
+void test_lwt_redirect(void)
+{
+	pthread_t test_thread;
+	int err;
+
+	/* Run the tests in their own thread to isolate the namespace changes
+	 * so they do not affect the environment of other tests.
+	 * (specifically needed because of unshare(CLONE_NEWNS) in open_netns())
+	 */
+	err = pthread_create(&test_thread, NULL, &test_lwt_redirect_run, NULL);
+	if (ASSERT_OK(err, "pthread_create"))
+		ASSERT_OK(pthread_join(test_thread, NULL), "pthread_join");
+}
diff --git a/tools/testing/selftests/bpf/progs/test_lwt_redirect.c b/tools/testing/selftests/bpf/progs/test_lwt_redirect.c
new file mode 100644
index 000000000000..f3dad9c8d356
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_lwt_redirect.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_tracing_net.h"
+
+/* We don't care about whether the packet can be received by network stack.
+ * Just care if the packet is sent to the correct device at correct direction
+ * and not panic the kernel.
+ */
+static int prepend_dummy_mac(struct __sk_buff *skb)
+{
+	char mac[] = {0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0xf,
+		      0xe, 0xd, 0xc, 0xb, 0xa, 0x08, 0x00};
+
+	if (bpf_skb_change_head(skb, ETH_HLEN, 0)) {
+		bpf_printk("%s: fail to change head", __func__);
+		return -1;
+	}
+
+	if (bpf_skb_store_bytes(skb, 0, mac, sizeof(mac), 0)) {
+		bpf_printk("%s: fail to update mac", __func__);
+		return -1;
+	}
+
+	return 0;
+}
+
+SEC("redir_ingress")
+int test_lwt_redirect_in(struct __sk_buff *skb)
+{
+	if (prepend_dummy_mac(skb))
+		return BPF_DROP;
+
+	return bpf_redirect(skb->mark, BPF_F_INGRESS);
+}
+
+SEC("redir_egress")
+int test_lwt_redirect_out(struct __sk_buff *skb)
+{
+	if (prepend_dummy_mac(skb))
+		return BPF_DROP;
+
+	return bpf_redirect(skb->mark, 0);
+}
+
+SEC("redir_egress_nomac")
+int test_lwt_redirect_out_nomac(struct __sk_buff *skb)
+{
+	return bpf_redirect(skb->mark, 0);
+}
+
+SEC("redir_ingress_nomac")
+int test_lwt_redirect_in_nomac(struct __sk_buff *skb)
+{
+	return bpf_redirect(skb->mark, BPF_F_INGRESS);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.30.2

