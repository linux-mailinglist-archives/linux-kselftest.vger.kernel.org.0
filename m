Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52304780407
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 04:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357357AbjHRC63 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 22:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357352AbjHRC6Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 22:58:24 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639362727
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Aug 2023 19:58:21 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76d764128d2so29518885a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Aug 2023 19:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1692327500; x=1692932300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vjV6aNUTuuSNDwStLeDVY3FrysRgluVjJM7kylN+jBw=;
        b=sXJnlisFGWEESfGIPFNx+eHq1c5hVs/cGoCgH5xBTYzrpZsiO0vsuKvP2SMTbRppn7
         EswOXQhXHAxVsYPB7xC3vWA42ON3GBBGEXlR5bs++L0yT4czuZNM+OFZcY8T/luV03RP
         TwHd3RdYEE8E+kiK/gmZ/3DjxNj69idlvv+9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692327500; x=1692932300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjV6aNUTuuSNDwStLeDVY3FrysRgluVjJM7kylN+jBw=;
        b=U1y5++kyKgxFjXudYLpO/TTs2Z5eCFjU6vWi+nYRodpWNYz4+Gvm/nLFFmMSeutMKB
         nfxfTJUeI2Ji+WiFsisDOISTRHMsr5Aqyon5WEEIarDcEbcfUtnF5zOg7vvPN6cRp1TD
         seUsvQDQgyhkXPvGgFTGtaoYsAwt4zAujUsO5wXIpyVScfL48U/onixsXmvyEtc5PR+T
         REAfmtsHBjrq8dhNu9lo9jOWRDFn+J0U5fDGGNfFe2vB86dL7r31PFSN6uzoUXDitTWC
         x8A4A5m9XRaDftmslwAOvBAA45TYkVfA5oE/inoB28iGr/gbbeu14yvo3BnOLPLpk0TP
         rXZg==
X-Gm-Message-State: AOJu0Yx3WEsYITbp3V47Xvkfiy202jl6i44L0NTuLeJvG1nshfG5wPcf
        QUBEEIydFLFWhrsaxp4rvdCS3Q==
X-Google-Smtp-Source: AGHT+IGay1kP8z+wNAb7o3gQ/QH6D47COE6RTPCNK1BWQrV4YyWrBxEw/mIWWzc3g+qDltcs5yZrIg==
X-Received: by 2002:a05:620a:471f:b0:767:2bbc:fcc7 with SMTP id bs31-20020a05620a471f00b007672bbcfcc7mr1724541qkb.14.1692327500437;
        Thu, 17 Aug 2023 19:58:20 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id h7-20020a05620a13e700b0076cb3690ae7sm238671qkl.68.2023.08.17.19.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 19:58:19 -0700 (PDT)
Date:   Thu, 17 Aug 2023 19:58:18 -0700
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
        linux-kselftest@vger.kernel.org
Subject: [PATCH v6 bpf 4/4] selftests/bpf: add lwt_xmit tests for BPF_REROUTE
Message-ID: <62c8ddc1e924269dcf80d2e8af1a1e632cee0b3a.1692326837.git.yan@cloudflare.com>
References: <cover.1692326837.git.yan@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1692326837.git.yan@cloudflare.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is no lwt test case for BPF_REROUTE yet. Add test cases for both
normal and abnormal situations. The abnormal situation is set up with an
fq qdisc on the reroute target device. Without proper fixes, overflow
this qdisc queue limit (to trigger a drop) would panic the kernel.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/lwt_reroute.c    | 262 ++++++++++++++++++
 .../selftests/bpf/progs/test_lwt_reroute.c    |  36 +++
 3 files changed, 299 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lwt_reroute.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_lwt_reroute.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index fa083f1e5b34..1c7584e8dd9e 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -60,6 +60,7 @@ CONFIG_NET_IPGRE=y
 CONFIG_NET_IPGRE_DEMUX=y
 CONFIG_NET_IPIP=y
 CONFIG_NET_MPLS_GSO=y
+CONFIG_NET_SCH_FQ=y
 CONFIG_NET_SCH_INGRESS=y
 CONFIG_NET_SCHED=y
 CONFIG_NETDEVSIM=y
diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_reroute.c b/tools/testing/selftests/bpf/prog_tests/lwt_reroute.c
new file mode 100644
index 000000000000..f4bb2d5fcae0
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_reroute.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+
+/*
+ * Test suite of lwt BPF programs that reroutes packets
+ *   The file tests focus not only if these programs work as expected normally,
+ *   but also if they can handle abnormal situations gracefully. This test
+ *   suite currently only covers lwt_xmit hook. lwt_in tests have not been
+ *   implemented.
+ *
+ * WARNING
+ * -------
+ *  This test suite can crash the kernel, thus should be run in a VM.
+ *
+ * Setup:
+ * ---------
+ *  all tests are performed in a single netns. A lwt encap route is setup for
+ *  each subtest:
+ *
+ *    ip route add 10.0.0.0/24 encap bpf xmit <obj> sec "<section_N>" dev link_err
+ *
+ *  Here <obj> is statically defined to test_lwt_reroute.bpf.o, and it contains
+ *  a single test program entry. This program sets packet mark by last byte of
+ *  the IPv4 daddr. For example, a packet going to 1.2.3.4 will receive a skb
+ *  mark 4. A packet will only be marked once, and IP x.x.x.0 will be skipped
+ *  to avoid route loop. We didn't use generated BPF skeleton since the
+ *  attachment for lwt programs are not supported by libbpf yet.
+ *
+ *  The test program will bring up a tun device, and sets up the following
+ *  routes:
+ *
+ *    ip rule add pref 100 from all fwmark <tun_index> lookup 100
+ *    ip route add table 100 default dev tun0
+ *
+ *  For normal testing, a ping command is running in the test netns:
+ *
+ *    ping 10.0.0.<tun_index> -c 1 -w 1 -s 100
+ *
+ *  For abnormal testing, fq is used as the qdisc of the tun device. Then a UDP
+ *  socket will try to overflow the fq queue and trigger qdisc drop error.
+ *
+ * Scenarios:
+ * --------------------------------
+ *  1. Reroute to a running tun device
+ *  2. Reroute to a device where qdisc drop
+ *
+ *  For case 1, ping packets should be received by the tun device.
+ *
+ *  For case 2, force UDP packets to overflow fq limit. As long as kernel
+ *  is not crashed, it is considered successful.
+ */
+#include "lwt_helpers.h"
+#include "network_helpers.h"
+#include <linux/net_tstamp.h>
+
+#define BPF_OBJECT            "test_lwt_reroute.bpf.o"
+#define LOCAL_SRC             "10.0.0.1"
+#define TEST_CIDR             "10.0.0.0/24"
+#define XMIT_HOOK             "xmit"
+#define XMIT_SECTION          "lwt_xmit"
+#define NSEC_PER_SEC          1000000000ULL
+
+/* send a ping to be rerouted to the target device */
+static void ping_once(const char *ip)
+{
+	/* We won't get a reply. Don't fail here */
+	SYS_NOFAIL("ping %s -c1 -W1 -s %d >/dev/null 2>&1",
+		   ip, ICMP_PAYLOAD_SIZE);
+}
+
+/* Send snd_target UDP packets to overflow the fq queue and trigger qdisc drop
+ * error. This is done via TX tstamp to force buffering delayed packets.
+ */
+static int overflow_fq(int snd_target, const char *target_ip)
+{
+	struct sockaddr_in addr = {
+		.sin_family = AF_INET,
+		.sin_port = htons(1234),
+	};
+
+	char data_buf[8]; /* only #pkts matter, so use a random small buffer */
+	char control_buf[CMSG_SPACE(sizeof(uint64_t))];
+	struct iovec iov = {
+		.iov_base = data_buf,
+		.iov_len = sizeof(data_buf),
+	};
+	int err = -1;
+	int s = -1;
+	struct sock_txtime txtime_on = {
+		.clockid = CLOCK_MONOTONIC,
+		.flags = 0,
+	};
+	struct msghdr msg = {
+		.msg_name = &addr,
+		.msg_namelen = sizeof(addr),
+		.msg_control = control_buf,
+		.msg_controllen = sizeof(control_buf),
+		.msg_iovlen = 1,
+		.msg_iov = &iov,
+	};
+	struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
+
+	memset(data_buf, 0, sizeof(data_buf));
+
+	s = socket(AF_INET, SOCK_DGRAM, 0);
+	if (!ASSERT_GE(s, 0, "socket"))
+		goto out;
+
+	err = setsockopt(s, SOL_SOCKET, SO_TXTIME, &txtime_on, sizeof(txtime_on));
+	if (!ASSERT_OK(err, "setsockopt(SO_TXTIME)"))
+		goto out;
+
+	err = inet_pton(AF_INET, target_ip, &addr.sin_addr);
+	if (!ASSERT_EQ(err, 1, "inet_pton"))
+		goto out;
+
+	while (snd_target > 0) {
+		struct timespec now;
+
+		memset(control_buf, 0, sizeof(control_buf));
+		cmsg->cmsg_type = SCM_TXTIME;
+		cmsg->cmsg_level = SOL_SOCKET;
+		cmsg->cmsg_len = CMSG_LEN(sizeof(uint64_t));
+
+		err = clock_gettime(CLOCK_MONOTONIC, &now);
+		if (!ASSERT_OK(err, "clock_gettime(CLOCK_MONOTONIC)")) {
+			err = -1;
+			goto out;
+		}
+
+		*(uint64_t *)CMSG_DATA(cmsg) = (now.tv_nsec + 1) * NSEC_PER_SEC +
+					       now.tv_nsec;
+
+		/* we will intentionally send more than fq limit, so ignore
+		 * the error here.
+		 */
+		sendmsg(s, &msg, MSG_NOSIGNAL);
+		snd_target--;
+	}
+
+	/* no kernel crash so far is considered success */
+	err = 0;
+
+out:
+	if (s >= 0)
+		close(s);
+
+	return err;
+}
+
+static int setup(const char *tun_dev)
+{
+	int target_index = -1;
+	int tap_fd = -1;
+
+	tap_fd = open_tuntap(tun_dev, false);
+	if (!ASSERT_GE(tap_fd, 0, "open_tun"))
+		return -1;
+
+	target_index = if_nametoindex(tun_dev);
+	if (!ASSERT_GE(target_index, 0, "if_nametoindex"))
+		return -1;
+
+	SYS(fail, "ip link add link_err type dummy");
+	SYS(fail, "ip link set lo up");
+	SYS(fail, "ip addr add dev lo " LOCAL_SRC "/32");
+	SYS(fail, "ip link set link_err up");
+	SYS(fail, "ip link set %s up", tun_dev);
+
+	SYS(fail, "ip route add %s dev link_err encap bpf xmit obj %s sec lwt_xmit",
+	    TEST_CIDR, BPF_OBJECT);
+
+	SYS(fail, "ip rule add pref 100 from all fwmark %d lookup 100",
+	    target_index);
+	SYS(fail, "ip route add t 100 default dev %s", tun_dev);
+
+	return tap_fd;
+
+fail:
+	if (tap_fd >= 0)
+		close(tap_fd);
+	return -1;
+}
+
+static void test_lwt_reroute_normal_xmit(void)
+{
+	const char *tun_dev = "tun0";
+	int tun_fd = -1;
+	int ifindex = -1;
+	char ip[256];
+	struct timeval timeo = {
+		.tv_sec = 0,
+		.tv_usec = 250000,
+	};
+
+	tun_fd = setup(tun_dev);
+	if (!ASSERT_GE(tun_fd, 0, "setup_reroute"))
+		return;
+
+	ifindex = if_nametoindex(tun_dev);
+	if (!ASSERT_GE(ifindex, 0, "if_nametoindex"))
+		return;
+
+	snprintf(ip, 256, "10.0.0.%d", ifindex);
+
+	/* ping packets should be received by the tun device */
+	ping_once(ip);
+
+	if (!ASSERT_EQ(wait_for_packet(tun_fd, __expect_icmp_ipv4, &timeo), 1,
+		       "wait_for_packet"))
+		log_err("%s xmit", __func__);
+}
+
+/*
+ * Test the failure case when the skb is dropped at the qdisc. This is a
+ * regression prevention at the xmit hook only.
+ */
+static void test_lwt_reroute_qdisc_dropped(void)
+{
+	const char *tun_dev = "tun0";
+	int tun_fd = -1;
+	int ifindex = -1;
+	char ip[256];
+
+	tun_fd = setup(tun_dev);
+	if (!ASSERT_GE(tun_fd, 0, "setup_reroute"))
+		goto fail;
+
+	SYS(fail, "tc qdisc replace dev %s root fq limit 5 flow_limit 5", tun_dev);
+
+	ifindex = if_nametoindex(tun_dev);
+	if (!ASSERT_GE(ifindex, 0, "if_nametoindex"))
+		return;
+
+	snprintf(ip, 256, "10.0.0.%d", ifindex);
+	ASSERT_EQ(overflow_fq(10, ip), 0, "overflow_fq");
+
+fail:
+	if (tun_fd >= 0)
+		close(tun_fd);
+}
+
+static void *test_lwt_reroute_run(void *arg)
+{
+	netns_delete();
+	RUN_TEST(lwt_reroute_normal_xmit);
+	RUN_TEST(lwt_reroute_qdisc_dropped);
+	return NULL;
+}
+
+void test_lwt_reroute(void)
+{
+	pthread_t test_thread;
+	int err;
+
+	/* Run the tests in their own thread to isolate the namespace changes
+	 * so they do not affect the environment of other tests.
+	 * (specifically needed because of unshare(CLONE_NEWNS) in open_netns())
+	 */
+	err = pthread_create(&test_thread, NULL, &test_lwt_reroute_run, NULL);
+	if (ASSERT_OK(err, "pthread_create"))
+		ASSERT_OK(pthread_join(test_thread, NULL), "pthread_join");
+}
diff --git a/tools/testing/selftests/bpf/progs/test_lwt_reroute.c b/tools/testing/selftests/bpf/progs/test_lwt_reroute.c
new file mode 100644
index 000000000000..1dc64351929c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_lwt_reroute.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <inttypes.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_helpers.h>
+#include <linux/if_ether.h>
+#include <linux/ip.h>
+
+/* This function extracts the last byte of the daddr, and uses it
+ * as output dev index.
+ */
+SEC("lwt_xmit")
+int test_lwt_reroute(struct __sk_buff *skb)
+{
+	struct iphdr *iph = NULL;
+	void *start = (void *)(long)skb->data;
+	void *end = (void *)(long)skb->data_end;
+
+	/* set mark at most once */
+	if (skb->mark != 0)
+		return BPF_OK;
+
+	if (start + sizeof(*iph) > end)
+		return BPF_DROP;
+
+	iph = (struct iphdr *)start;
+	skb->mark = bpf_ntohl(iph->daddr) & 0xff;
+
+	/* do not reroute x.x.x.0 packets */
+	if (skb->mark == 0)
+		return BPF_OK;
+
+	return BPF_LWT_REROUTE;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.30.2


