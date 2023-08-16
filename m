Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57D877D8B3
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 04:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241340AbjHPC6B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 22:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241413AbjHPC5a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 22:57:30 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137F3212E
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 19:57:28 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-76d5352bdb0so216400585a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 19:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1692154647; x=1692759447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YSGdEnCqI6zb744rb3nN7Qwri65wFsNuiAOi4seAdmc=;
        b=u8cfweM9p3FM+s756YlMsJ0fuQr8ukg7dueUa3JJLNQdPPFyaZbCSs4ccefaj1/nrB
         06xrJB2KpDhj7NKdcmHtxZb1+LriH2ZkfnZdZ1i4GzAjV9ujS1Kg35AhZ9AwH1ytBXpZ
         TshUcVzBwe92qWPX6hm0jYNjIfMyuACs5mtTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692154647; x=1692759447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSGdEnCqI6zb744rb3nN7Qwri65wFsNuiAOi4seAdmc=;
        b=ApX4NR6k4GeRboZFuVnPf+gIOrNhd+Ttc3LC3omiWapwXYrmP+xViE1Js7/jvcj7Yv
         krBzJfhdDKW8wxYsd8ozbCgiWklqpS1qTIQKzHeE36QbtlY5d8aEBK5mf2xfhjc17AMD
         2zQDaHmTPA/MjAilAcFH3lCsYmtzKP3zMG+biRNNs3NLX/k8M6EnSvhhlYiyKbWeRZUr
         vaXMI9oDrRmB5E5yxx5co6LJNco6gpxxXKRzvTUOpRSMlJXWB/PIgtbzuU6P6YbpTfAv
         WkmE61JRekHuvyykx6j0OdQ8nY6x3lN7m65gr3qM2t+jIvawKifsOq+jlKjcCy42zLm/
         PxxQ==
X-Gm-Message-State: AOJu0Yws5YEACHQbjO7F403sxVV1lV0g+5RSdvrfX7DGSF+Z3gb6+hKw
        +MNZLZYpoY7aqtTsmxxQLk9trA==
X-Google-Smtp-Source: AGHT+IG+B5NS32lthGUirYjWUP3Lv0I6Z9Ii988Ra+jZxvPldsot/LT2oAEmBFcInF/JgS6mgB5+yQ==
X-Received: by 2002:a05:620a:4414:b0:767:edc0:64f8 with SMTP id v20-20020a05620a441400b00767edc064f8mr950843qkp.2.1692154647011;
        Tue, 15 Aug 2023 19:57:27 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id q4-20020a05620a038400b0076639dfca8dsm4158014qkm.80.2023.08.15.19.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 19:57:26 -0700 (PDT)
Date:   Tue, 15 Aug 2023 19:57:24 -0700
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
Subject: [PATCH v5 bpf 4/4] selftests/bpf: add lwt_xmit tests for BPF_REROUTE
Message-ID: <db5f4baf2577d52ee6894286e35e3689ad21c22f.1692153515.git.yan@cloudflare.com>
References: <cover.1692153515.git.yan@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1692153515.git.yan@cloudflare.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is no lwt selftest for BPF_REROUTE yet. Add test cases for both
normal and abnormal situations. The abnormal situation is set up with an
fq qdisc on the reroute target device. Without proper fixes, BPF_REROUTE
to this device and overflow this qdisc queue limit (to trigger a drop)
would panic the kernel, so please run the test in a VM for safety.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 .../selftests/bpf/prog_tests/lwt_reroute.c    | 256 ++++++++++++++++++
 .../selftests/bpf/progs/test_lwt_reroute.c    |  36 +++
 2 files changed, 292 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lwt_reroute.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_lwt_reroute.c

diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_reroute.c b/tools/testing/selftests/bpf/prog_tests/lwt_reroute.c
new file mode 100644
index 000000000000..e5fa5451bd2c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_reroute.c
@@ -0,0 +1,256 @@
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
+	SYS_NOFAIL("ping %s -c1 -w1 -s %d >/dev/null 2>&1",
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

