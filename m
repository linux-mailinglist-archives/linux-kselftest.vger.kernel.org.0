Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C268859F85A
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Aug 2022 13:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbiHXLHF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Aug 2022 07:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237068AbiHXLHB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Aug 2022 07:07:01 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84944786D9;
        Wed, 24 Aug 2022 04:06:54 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u14so20303822wrq.9;
        Wed, 24 Aug 2022 04:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ydXjeXmndQWLhyTrn0jldFjYnPcbZdsr5fRRvWC/KiA=;
        b=TGBs7vH1nzFA1zpSsZlN2jcmJspPyXQc9MuqNo0XjTSuGewwi3QcRKEJnOPSNhA9ry
         ke5OIJMPZxqFT/s71vwA6/i9epppVBGOA+LsoK6KxR1fF+Xaw7QSNTMka7q6kRJBlsDy
         Qx/aDUci390fzH3gpp/HwzfiZuvSLFBn33BIAvzvpgCfJeFnW9rOD9Xso71GWGSMDP3V
         J5/KRAaolewYJLhiTjymrcGQssbtHF29lQXllWbryR/z2qzfa6b0FZd1Ojq004VGB5oE
         sbTJ4KpsPRB5ruVUVFbBK1rNt3CqAK4uhHNK2HC9AkX4RqGx94xtKmiB6kIDAgd3cvVn
         PLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ydXjeXmndQWLhyTrn0jldFjYnPcbZdsr5fRRvWC/KiA=;
        b=Fw74GTNMlWSfTWn78aGWlTWTx+fDP7aBqDB7rOKJnk5EAhhpOM2cYsQ8zDIjIwA/in
         e7xkUz5HyC1PYaUh3WnPFPw21F7DCy73S5WzoRWf2qz0+6JaUFNjdbFVjotZUpU9pGJn
         /MvdedI5mJQnzwMBbIEdHlJGMoqbamj+bfMWOtmAyl0MmE1/RnGfwLCRj48eX39UT/7I
         gMzGB23h0TIjxcSNBrIYpamZIvf0pWwqN6c9ClQCCy//02xNXgnHghUuJdXgFl8BykYo
         6O6vuWCZu7zUPWYLhZocEWBsuHIX0mgbmWSAjco85uZmlVedRll0o2cSPTuDaKQldLWA
         zdWg==
X-Gm-Message-State: ACgBeo2+H3IpmiQlSMzlw417IgJuxhHIwcZdOSVpA/DnQhByQx7tCoNa
        Q3ZARazyTRDiXfh/GognIPdUIaEi6r5oqg==
X-Google-Smtp-Source: AA6agR4afyrLE6NN9xce+FIBiIjrjNyWtfPGrfXaV70f9bzSNP/S4W6YJzQxkz6ErOHgLJWPHUfW4Q==
X-Received: by 2002:a05:6000:1863:b0:220:6d5f:deb5 with SMTP id d3-20020a056000186300b002206d5fdeb5mr15243729wri.470.1661339212407;
        Wed, 24 Aug 2022 04:06:52 -0700 (PDT)
Received: from localhost.localdomain ([213.57.189.88])
        by smtp.gmail.com with ESMTPSA id m10-20020a5d624a000000b0021e6c52c921sm19734299wrv.54.2022.08.24.04.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 04:06:52 -0700 (PDT)
From:   Eyal Birger <eyal.birger@gmail.com>
To:     andrii@kernel.org, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Eyal Birger <eyal.birger@gmail.com>
Subject: [PATCH bpf-next,v3] selftests/bpf: add lwt ip encap tests to test_progs
Date:   Wed, 24 Aug 2022 14:06:32 +0300
Message-Id: <20220824110632.1592592-1-eyal.birger@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Port test_lwt_ip_encap.sh tests onto test_progs.

In addition, this commit adds "egress_md" tests which test a similar
flow as egress tests only they use gre devices in collect_md mode
for encapsulation and set the tunnel key using bpf_set_tunnel_key().

This introduces minor changes to the test setup and test_lwt_ip_encap.c:

- GRE key must exist as bpf_set_tunnel_key() explicitly sets the
  TUNNEL_KEY flag

- Source address for GRE traffic is set to IP*_5 instead of IP*_1 since
  GRE traffic is sent via veth5 so its address is selected when using
  bpf_set_tunnel_key()

Note: currently these programs use the legacy section name convention
as iproute2 lwt configuration does not support providing function names.

Since the shell version is not routinely tested, remove it
and rely on the C version.

Signed-off-by: Eyal Birger <eyal.birger@gmail.com>

----

v2: remove lwt_ip_encap.sh
v2:
  - set CONFIG_NET_VRF and CONFIG_NET_L3_MASTER_DEV in reference .config
  - add wait after sending large packet to allow it to get delivered as
    in the .sh test
---
 tools/testing/selftests/bpf/Makefile          |   1 -
 tools/testing/selftests/bpf/config            |   2 +
 .../selftests/bpf/prog_tests/lwt_ip_encap.c   | 585 ++++++++++++++++++
 .../selftests/bpf/progs/test_lwt_ip_encap.c   |  51 +-
 .../selftests/bpf/test_lwt_ip_encap.sh        | 475 --------------
 5 files changed, 634 insertions(+), 480 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
 delete mode 100755 tools/testing/selftests/bpf/test_lwt_ip_encap.sh

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index eecad99f1735..39b675cc4ca9 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -63,7 +63,6 @@ TEST_PROGS := test_kmod.sh \
 	test_flow_dissector.sh \
 	test_xdp_vlan_mode_generic.sh \
 	test_xdp_vlan_mode_native.sh \
-	test_lwt_ip_encap.sh \
 	test_tcp_check_syncookie.sh \
 	test_tc_tunnel.sh \
 	test_tc_edt.sh \
diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 3fc46f9cfb22..04cc64e334ef 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -64,3 +64,5 @@ CONFIG_TEST_BPF=m
 CONFIG_USERFAULTFD=y
 CONFIG_VXLAN=y
 CONFIG_XDP_SOCKETS=y
+CONFIG_NET_VRF=y
+CONFIG_NET_L3_MASTER_DEV=y
diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c b/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
new file mode 100644
index 000000000000..986c06d1bda1
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
@@ -0,0 +1,585 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+
+/* Setup/topology:
+ *
+ *    NS1             NS2             NS3
+ *   veth1 <---> veth2   veth3 <---> veth4 (the top route)
+ *   veth5 <---> veth6   veth7 <---> veth8 (the bottom route)
+ *
+ *   each vethN gets IP[4|6]_N address
+ *
+ *   IP*_SRC = IP*_1
+ *   IP*_DST = IP*_4
+ *
+ *   all tests test pings from IP*_SRC to IP*_DST
+ *
+ *   by default, routes are configured to allow packets to go
+ *   IP*_1 <=> IP*_2 <=> IP*_3 <=> IP*_4 (the top route)
+ *
+ *   a GRE device is installed in NS3 with IP*_GRE, and
+ *   NS1/NS2 are configured to route packets to IP*_GRE via IP*_8
+ *   (the bottom route)
+ *
+ * Tests:
+ *
+ *   1. routes NS2->IP*_DST are brought down, so the only way a ping
+ *      from IP*_SRC to IP*_DST can work is via IP*_GRE
+ *
+ *   2a. in an egress test, a bpf LWT_XMIT program is installed on veth1
+ *       that encaps the packets with an IP/GRE header to route to IP*_GRE
+ *
+ *       ping: SRC->[encap at veth1:egress]->GRE:decap->DST
+ *       ping replies go DST->SRC directly
+ *
+ *   2b. in an ingress test, a bpf LWT_IN program is installed on veth2
+ *       that encaps the packets with an IP/GRE header to route to IP*_GRE
+ *
+ *       ping: SRC->[encap at veth2:ingress]->GRE:decap->DST
+ *       ping replies go DST->SRC directly
+ *
+ *   2c. in an egress_md test, a bpf LWT_XMIT program is installed on a
+ *       route towards collect_md gre{,6} devices in NS1 and sets the tunnel
+ *       key such that packets are encapsulated with an IP/GRE header to route
+ *       to IP*_GRE
+ *
+ *       ping: SRC->[encap at gre{,6}_md:xmit]->GRE:decap->DST
+ *       ping replies go DST->SRC directly
+ */
+
+#include "test_progs.h"
+#include "network_helpers.h"
+
+#define NS_1 "ns_lwt_1"
+#define NS_2 "ns_lwt_2"
+#define NS_3 "ns_lwt_3"
+
+#define IP4_1 "172.16.1.100"
+#define IP4_2 "172.16.2.100"
+#define IP4_3 "172.16.3.100"
+#define IP4_4 "172.16.4.100"
+#define IP4_5 "172.16.5.100"
+#define IP4_6 "172.16.6.100"
+#define IP4_7 "172.16.7.100"
+#define IP4_8 "172.16.8.100"
+#define IP4_GRE "172.16.16.100"
+#define IP4_DST IP4_4
+
+#define IP6_1 "fb01::1"
+#define IP6_2 "fb02::1"
+#define IP6_3 "fb03::1"
+#define IP6_4 "fb04::1"
+#define IP6_5 "fb05::1"
+#define IP6_6 "fb06::1"
+#define IP6_7 "fb07::1"
+#define IP6_8 "fb08::1"
+#define IP6_GRE "fb10::1"
+#define IP6_DST IP6_4
+
+#define TEST_VRF_NAME "red"
+
+static const char * const namespaces[] = {NS_1, NS_2, NS_3, NULL};
+static __u32 duration;
+static bool use_vrf;
+
+enum encap_type {
+	ENCAP_EGRESS,
+	ENCAP_INGRESS,
+	ENCAP_EGRESS_MD,
+};
+
+#define SYS(fmt, ...)							\
+	({								\
+		char cmd[1024];						\
+		snprintf(cmd, sizeof(cmd), fmt,	##__VA_ARGS__);		\
+		if (!ASSERT_OK(system(cmd), cmd))			\
+			goto fail;					\
+	})
+
+#define ADD_VETH_PAIR(v1, ns1, v2, ns2)					\
+	SYS("ip link add " v1 " netns " ns1 " type veth "		\
+	    "peer name " v2 " netns " ns2)
+
+#define SET_NS_ROUTE(op, netns, family, fmt, ...)			\
+	SYS("ip %s%s %s route " op " %s " fmt,				\
+	    netns[0] ? "-netns " : "", netns[0] ? netns : "",		\
+	    family == AF_INET6 ? "-6" : "",				\
+	    use_vrf ? "vrf " TEST_VRF_NAME : "",			\
+	    ##__VA_ARGS__)
+
+#define SET_NS_ADDR_ROUTE(op, netns, addr, fmt, ...)			\
+	({								\
+		int family = strchr(addr, ':') ? AF_INET6 : AF_INET;	\
+		SET_NS_ROUTE(op, netns, family, addr "%s " fmt,		\
+			     family == AF_INET6 ? "/128" : "/32",	\
+			     ##__VA_ARGS__);				\
+	})
+
+#define ADD_ROUTE(family, ...) SET_NS_ROUTE("add", "", family, ##__VA_ARGS__)
+
+#define ADD_ADDR_ROUTE(...) SET_NS_ADDR_ROUTE("add", "", ##__VA_ARGS__)
+
+static int write_sysctl(const char *sysctl, const char *value)
+{
+	int fd, err, len;
+
+	fd = open(sysctl, O_WRONLY);
+	if (CHECK(fd == -1, "open sysctl", "open(%s): %s (%d)\n",
+		  sysctl, strerror(errno), errno))
+		return -1;
+
+	len = strlen(value);
+	err = write(fd, value, len);
+	close(fd);
+	if (CHECK(err != len, "write sysctl",
+		  "write(%s, %s): err:%d %s (%d)\n",
+		  sysctl, value, err, strerror(errno), errno))
+		return -1;
+
+	return 0;
+}
+
+static int setup_namespaces(const char *verb)
+{
+	const char * const *ns = namespaces;
+
+	while (*ns) {
+		SYS("ip netns %s %s", verb, *ns);
+		ns++;
+	}
+	return 0;
+fail:
+	return -1;
+}
+
+static void setup_namespaces_nofail(const char *verb)
+{
+	const char * const *ns = namespaces;
+	char cmd[128];
+
+	while (*ns) {
+		snprintf(cmd, sizeof(cmd), "ip netns %s %s > /dev/null 2>&1",
+			 verb, *ns);
+		system(cmd);
+		ns++;
+	}
+}
+
+static int setup_ns(const char *ns, int (*ns_setup_fn)(void))
+{
+	struct nstoken *nstoken;
+	int err = -1;
+
+	nstoken = open_netns(ns);
+	if (!ASSERT_OK_PTR(nstoken, "setns"))
+		return -1;
+
+	/* rp_filter gets confused by what these tests are doing,
+	 * so disable it.
+	 * also disable IPv6 DAD because it sometimes takes too long and fails
+	 * tests.
+	 */
+	if (write_sysctl("/proc/sys/net/ipv4/conf/all/rp_filter", "0") ||
+	    write_sysctl("/proc/sys/net/ipv4/conf/default/rp_filter", "0") ||
+	    write_sysctl("/proc/sys/net/ipv6/conf/all/accept_dad", "0") ||
+	    write_sysctl("/proc/sys/net/ipv6/conf/default/accept_dad", "0"))
+		goto exit;
+
+	err = ns_setup_fn();
+
+exit:
+	close_netns(nstoken);
+	return err;
+}
+
+static int setup_device(const char *devname, const char *addr4,
+			const char *addr6)
+{
+	if (use_vrf)
+		SYS("ip link set %s vrf %s", devname, TEST_VRF_NAME);
+
+	if (addr4)
+		SYS("ip addr add %s/24 dev %s", addr4, devname);
+
+	if (addr6)
+		SYS("ip -6 addr add %s/128 nodad dev %s", addr6, devname);
+
+	SYS("ip link set dev %s up", devname);
+	return 0;
+fail:
+	return -1;
+}
+
+static int setup_vrf(void)
+{
+	SYS("ip link add %s type vrf table 1001", TEST_VRF_NAME);
+	SYS("ip link set dev %s up", TEST_VRF_NAME);
+	SYS("ip route add table 1001 unreachable default metric 8192");
+	SYS("ip -6 route add table 1001 unreachable default metric 8192");
+	return 0;
+fail:
+	return -1;
+}
+
+static int setup_ns1(void)
+{
+	if (use_vrf && setup_vrf())
+		goto fail;
+
+	SYS("ip link add gre_md type gre external");
+	SYS("ip link add gre6_md type ip6gre external");
+
+	if (setup_device("veth1", IP4_1, IP6_1) ||
+	    setup_device("veth5", IP4_5, IP6_5) ||
+	    setup_device("gre_md", IP4_1, IP6_1) ||
+	    setup_device("gre6_md", IP4_1, IP6_1))
+		goto fail;
+
+	/* Top route */
+	ADD_ADDR_ROUTE(IP4_2, "dev veth1");
+	ADD_ADDR_ROUTE(IP6_2, "dev veth1");
+	ADD_ROUTE(AF_INET, "default dev veth1 via " IP4_2);
+	ADD_ROUTE(AF_INET6, "default dev veth1 via " IP6_2);
+
+	/* Bottom route */
+	ADD_ADDR_ROUTE(IP4_6, "dev veth5");
+	ADD_ADDR_ROUTE(IP4_7, "dev veth5 via " IP4_6);
+	ADD_ADDR_ROUTE(IP4_8, "dev veth5 via " IP4_6);
+	ADD_ADDR_ROUTE(IP6_6, "dev veth5");
+	ADD_ADDR_ROUTE(IP6_7, "dev veth5 via " IP6_6);
+	ADD_ADDR_ROUTE(IP6_8, "dev veth5 via " IP6_6);
+
+	/* GRE peer via the bottom route */
+	ADD_ADDR_ROUTE(IP4_GRE, "dev veth5 via " IP4_6);
+	ADD_ADDR_ROUTE(IP6_GRE, "dev veth5 via " IP6_6);
+	return 0;
+fail:
+	return -1;
+}
+
+static int setup_ns2(void)
+{
+	if (write_sysctl("/proc/sys/net/ipv4/ip_forward", "1") ||
+	    write_sysctl("/proc/sys/net/ipv6/conf/all/forwarding", "1"))
+		goto fail;
+
+	if (use_vrf && setup_vrf())
+		goto fail;
+
+	if (setup_device("veth2", IP4_2, IP6_2) ||
+	    setup_device("veth3", IP4_3, IP6_3) ||
+	    setup_device("veth6", IP4_6, IP6_6) ||
+	    setup_device("veth7", IP4_7, IP6_7))
+		goto fail;
+
+	/* Top route */
+	ADD_ADDR_ROUTE(IP4_1, "dev veth2");
+	ADD_ADDR_ROUTE(IP4_4, "dev veth3");
+	ADD_ADDR_ROUTE(IP6_1, "dev veth2");
+	ADD_ADDR_ROUTE(IP6_4, "dev veth3");
+
+	/* Bottom route */
+	ADD_ADDR_ROUTE(IP4_5, "dev veth6");
+	ADD_ADDR_ROUTE(IP4_8, "dev veth7");
+	ADD_ADDR_ROUTE(IP6_5, "dev veth6");
+	ADD_ADDR_ROUTE(IP6_8, "dev veth7");
+
+	/* GRE peer via the bottom route */
+	ADD_ADDR_ROUTE(IP4_GRE, "dev veth7 via " IP4_8);
+	ADD_ADDR_ROUTE(IP6_GRE, "dev veth7 via " IP6_8);
+	return 0;
+fail:
+	return -1;
+}
+
+static int setup_ns3(void)
+{
+	if (use_vrf && setup_vrf())
+		goto fail;
+
+	if (setup_device("veth4", IP4_4, IP6_4) ||
+	    setup_device("veth8", IP4_8, IP6_8))
+		goto fail;
+
+	/* Top route */
+	ADD_ADDR_ROUTE(IP4_3, "dev veth4");
+	ADD_ADDR_ROUTE(IP4_1, "dev veth4 via " IP4_3);
+	ADD_ADDR_ROUTE(IP4_2, "dev veth4 via " IP4_3);
+	ADD_ADDR_ROUTE(IP6_3, "dev veth4");
+	ADD_ADDR_ROUTE(IP6_1, "dev veth4 via " IP6_3);
+	ADD_ADDR_ROUTE(IP6_2, "dev veth4 via " IP6_3);
+
+	/* Bottom route */
+	ADD_ADDR_ROUTE(IP4_7, "dev veth8");
+	ADD_ADDR_ROUTE(IP4_5, "dev veth8 via " IP4_7);
+	ADD_ADDR_ROUTE(IP4_6, "dev veth8 via " IP4_7);
+	ADD_ADDR_ROUTE(IP6_7, "dev veth8");
+	ADD_ADDR_ROUTE(IP6_5, "dev veth8 via " IP6_7);
+	ADD_ADDR_ROUTE(IP6_6, "dev veth8 via " IP6_7);
+
+	/* configure IPv4 GRE device in NS3, and a route to it via the
+	 * "bottom" route
+	 */
+	SYS("ip tunnel add gre_dev mode gre remote " IP4_5 " local " IP4_GRE
+	    " ttl 255 key 0");
+	if (setup_device("gre_dev", IP4_GRE, NULL))
+		goto fail;
+
+	SYS("ip tunnel add gre6_dev mode ip6gre remote " IP6_5 " local " IP6_GRE
+	    " ttl 255 key 0");
+	if (setup_device("gre6_dev", NULL, IP6_GRE))
+		goto fail;
+
+	return 0;
+fail:
+	return -1;
+}
+
+static int setup_links_and_routes(void)
+{
+	ADD_VETH_PAIR("veth1", NS_1, "veth2", NS_2);
+	ADD_VETH_PAIR("veth3", NS_2, "veth4", NS_3);
+	ADD_VETH_PAIR("veth5", NS_1, "veth6", NS_2);
+	ADD_VETH_PAIR("veth7", NS_2, "veth8", NS_3);
+
+	if (setup_ns(NS_1, setup_ns1) ||
+	    setup_ns(NS_2, setup_ns2) ||
+	    setup_ns(NS_3, setup_ns3))
+		goto fail;
+
+	return 0;
+fail:
+	return -1;
+}
+
+static int remove_routes_to_gredev(void)
+{
+	SET_NS_ADDR_ROUTE("del", NS_1, IP4_GRE, "dev veth5");
+	SET_NS_ADDR_ROUTE("del", NS_1, IP6_GRE, "dev veth5");
+	SET_NS_ADDR_ROUTE("del", NS_2, IP4_GRE, "dev veth7");
+	SET_NS_ADDR_ROUTE("del", NS_2, IP6_GRE, "dev veth7");
+fail:
+	return -1;
+}
+
+static int add_unreachable_routes_to_gredev(void)
+{
+	SET_NS_ROUTE("add", NS_1, AF_INET, "unreachable " IP4_GRE "/32");
+	SET_NS_ROUTE("add", NS_1, AF_INET6, "unreachable " IP6_GRE "/128");
+	SET_NS_ROUTE("add", NS_2, AF_INET, "unreachable " IP4_GRE "/32");
+	SET_NS_ROUTE("add", NS_2, AF_INET6, "unreachable " IP6_GRE "/128");
+	return 0;
+fail:
+	return -1;
+}
+
+static int test_ping(int family, bool must_fail, bool bindtodev)
+{
+	const char *addr, *ping_args;
+	char cmd[1024];
+	int ret;
+
+	addr = family == AF_INET ? IP4_DST : IP6_DST;
+	ping_args = bindtodev ? "-c 1 -W 1 -I veth1" : "-c 1 -W 1";
+	snprintf(cmd, sizeof(cmd),
+		 "ip netns exec " NS_1 " %s %s %s > /dev/null",
+		 ping_command(family), ping_args, addr);
+	ret = system(cmd);
+	if (!ASSERT_EQ(!!ret, !!must_fail, cmd))
+		return -1;
+	return 0;
+}
+
+#define TIMEOUT_MILLIS 10000
+
+static int test_gso(int family, const char *dst)
+{
+	int listen_fd = -1, accept_fd = -1, client_fd = -1;
+	struct nstoken *nstoken;
+	static char buf[5000];
+	int n, ret = -1;
+
+	nstoken = open_netns(NS_3);
+	if (!ASSERT_OK_PTR(nstoken, "setns"))
+		return -1;
+
+	listen_fd = start_server(family, SOCK_STREAM, dst, 9000, 0);
+	if (!ASSERT_GE(listen_fd, 0, "listen"))
+		goto done;
+
+	close_netns(nstoken);
+	nstoken = open_netns(NS_1);
+	if (!ASSERT_OK_PTR(nstoken, "setns src"))
+		goto done;
+
+	client_fd = connect_to_fd(listen_fd, TIMEOUT_MILLIS);
+	if (!ASSERT_GE(client_fd, 0, "connect_to_fd"))
+		goto done;
+
+	accept_fd = accept(listen_fd, NULL, NULL);
+	if (!ASSERT_GE(accept_fd, 0, "accept"))
+		goto done;
+
+	if (!ASSERT_OK(settimeo(accept_fd, TIMEOUT_MILLIS), "settimeo"))
+		goto done;
+
+	/* Send a packet larger than the MTU */
+	n = write(client_fd, buf, sizeof(buf));
+	if (!ASSERT_EQ(n, sizeof(buf), "send to server"))
+		goto done;
+
+	sleep(2); /* let the packet get delivered */
+
+	n = read(accept_fd, buf, sizeof(buf));
+	ASSERT_EQ(n, sizeof(buf), "recv from server");
+
+	ret = 0;
+
+done:
+	if (nstoken)
+		close_netns(nstoken);
+	if (listen_fd >= 0)
+		close(listen_fd);
+	if (accept_fd >= 0)
+		close(accept_fd);
+	if (client_fd >= 0)
+		close(client_fd);
+	return ret;
+}
+
+static void lwt_ip_encap_test(int encap_family, enum encap_type encap_type)
+{
+	const char *prog_sec, *encap_dev, *lwt_type, *encap_ns;
+	bool bindtodev = true;
+
+	if (!ASSERT_OK(setup_namespaces("add"), "setup namespaces"))
+		return;
+	if (!ASSERT_OK(setup_links_and_routes(),
+		       "setup links and routes"))
+		goto fail;
+
+	sleep(2); /* reduce flakiness */
+
+	/* by default, pings work */
+	test_ping(AF_INET, false, bindtodev);
+	test_ping(AF_INET6, false, bindtodev);
+
+	/* remove NS2->DST routes, ping fails */
+	SET_NS_ADDR_ROUTE("del", NS_2, IP4_DST, "dev veth3");
+	SET_NS_ADDR_ROUTE("del", NS_2, IP6_DST, "dev veth3");
+
+	test_ping(AF_INET, true, bindtodev);
+	test_ping(AF_INET6, true, bindtodev);
+
+	prog_sec = encap_family == AF_INET ? "encap_gre" : "encap_gre6";
+
+	switch (encap_type) {
+	case ENCAP_EGRESS:
+		encap_dev = "veth1";
+		lwt_type = "xmit";
+		encap_ns = NS_1;
+		break;
+	case ENCAP_INGRESS:
+		encap_dev = "veth2";
+		lwt_type = "in";
+		encap_ns = NS_2;
+		break;
+	case ENCAP_EGRESS_MD:
+		switch (encap_family) {
+		case AF_INET:
+			prog_sec = "encap_gre_md";
+			encap_dev = "gre_md";
+			break;
+		case AF_INET6:
+			prog_sec = "encap_gre6_md";
+			encap_dev = "gre6_md";
+			break;
+		default:
+			goto fail;
+		}
+		lwt_type = "xmit";
+		encap_ns = NS_1;
+		break;
+	default:
+		goto fail;
+	}
+
+	/* install replacement routes (LWT/eBPF), pings succeed */
+	SET_NS_ADDR_ROUTE("add", encap_ns, IP4_DST,
+			  "encap bpf %s obj test_lwt_ip_encap.o sec %s dev %s",
+			  lwt_type, prog_sec, encap_dev);
+	SET_NS_ADDR_ROUTE("add", encap_ns, IP6_DST,
+			  "encap bpf %s obj test_lwt_ip_encap.o sec %s dev %s",
+			  lwt_type, prog_sec, encap_dev);
+
+	/* binding to device doesn't work for egress_md tests as routing is
+	 * asymmetrical
+	 */
+	bindtodev = encap_type != ENCAP_EGRESS_MD;
+	test_ping(AF_INET, false, bindtodev);
+	test_ping(AF_INET6, false, bindtodev);
+
+	/* VRF is complex for testing GSO in this setup */
+	if (!use_vrf && encap_type != ENCAP_INGRESS) {
+		test_gso(AF_INET, IP4_DST);
+		test_gso(AF_INET6, IP6_DST);
+	}
+
+	/* a negative test: remove routes to GRE devices: ping fails */
+	if (remove_routes_to_gredev())
+		goto fail;
+
+	test_ping(AF_INET, true, bindtodev);
+	test_ping(AF_INET6, true, bindtodev);
+
+	if (add_unreachable_routes_to_gredev())
+		goto fail;
+
+	test_ping(AF_INET, true, bindtodev);
+	test_ping(AF_INET6, true, bindtodev);
+fail:
+	setup_namespaces("delete");
+}
+
+#define RUN_TEST(name, family, encap_type, _use_vrf)		\
+	({							\
+		if (test__start_subtest(name)) {		\
+			use_vrf = _use_vrf;			\
+			lwt_ip_encap_test(family, encap_type);	\
+		}						\
+	})
+
+static void *lwt_ip_encap_run_tests(void *arg)
+{
+	setup_namespaces_nofail("delete");
+
+	RUN_TEST("lwt_ipv4_encap_egress", AF_INET, ENCAP_EGRESS, false);
+	RUN_TEST("lwt_ipv6_encap_egress", AF_INET6, ENCAP_EGRESS, false);
+	RUN_TEST("lwt_ipv4_encap_egress_vrf", AF_INET, ENCAP_EGRESS, true);
+	RUN_TEST("lwt_ipv6_encap_egress_vrf", AF_INET6, ENCAP_EGRESS, true);
+
+	RUN_TEST("lwt_ipv4_encap_ingress", AF_INET, ENCAP_INGRESS, false);
+	RUN_TEST("lwt_ipv6_encap_ingress", AF_INET6, ENCAP_INGRESS, false);
+	RUN_TEST("lwt_ipv4_encap_ingress_vrf", AF_INET, ENCAP_INGRESS, true);
+	RUN_TEST("lwt_ipv6_encap_ingress_vrf", AF_INET6, ENCAP_INGRESS, true);
+
+	/* bpf_set_tunnel_key() doesn't support setting underlying VRF routing
+	 * so egress_md tests don't run in VRF setup.
+	 */
+	RUN_TEST("lwt_ipv4_encap_egress_md", AF_INET, ENCAP_EGRESS_MD, false);
+	RUN_TEST("lwt_ipv6_encap_egress_md", AF_INET6, ENCAP_EGRESS_MD, false);
+	return NULL;
+}
+
+void serial_test_lwt_ip_encap(void)
+{
+	pthread_t test_thread;
+	int err;
+
+	/* Run the tests in their own thread to isolate the namespace changes
+	 * so they do not affect the environment of other tests.
+	 * (specifically needed because of unshare(CLONE_NEWNS) in open_netns())
+	 */
+	err = pthread_create(&test_thread, NULL, &lwt_ip_encap_run_tests, NULL);
+	if (ASSERT_OK(err, "pthread_create"))
+		ASSERT_OK(pthread_join(test_thread, NULL), "pthread_join");
+}
diff --git a/tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c b/tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c
index d6cb986e7533..39c6bd5402ae 100644
--- a/tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c
+++ b/tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c
@@ -10,8 +10,11 @@
 struct grehdr {
 	__be16 flags;
 	__be16 protocol;
+	__be32 key;
 };
 
+#define GRE_KEY	0x2000
+
 SEC("encap_gre")
 int bpf_lwt_encap_gre(struct __sk_buff *skb)
 {
@@ -28,10 +31,10 @@ int bpf_lwt_encap_gre(struct __sk_buff *skb)
 	hdr.iph.ttl = 0x40;
 	hdr.iph.protocol = 47;  /* IPPROTO_GRE */
 #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
-	hdr.iph.saddr = 0x640110ac;  /* 172.16.1.100 */
+	hdr.iph.saddr = 0x640510ac;  /* 172.16.5.100 */
 	hdr.iph.daddr = 0x641010ac;  /* 172.16.16.100 */
 #elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
-	hdr.iph.saddr = 0xac100164;  /* 172.16.1.100 */
+	hdr.iph.saddr = 0xac100564;  /* 172.16.5.100 */
 	hdr.iph.daddr = 0xac101064;  /* 172.16.16.100 */
 #else
 #error "Fix your compiler's __BYTE_ORDER__?!"
@@ -39,6 +42,7 @@ int bpf_lwt_encap_gre(struct __sk_buff *skb)
 	hdr.iph.tot_len = bpf_htons(skb->len + sizeof(struct encap_hdr));
 
 	hdr.greh.protocol = skb->protocol;
+	hdr.greh.flags = bpf_htons(GRE_KEY);
 
 	err = bpf_lwt_push_encap(skb, BPF_LWT_ENCAP_IP, &hdr,
 				 sizeof(struct encap_hdr));
@@ -63,9 +67,9 @@ int bpf_lwt_encap_gre6(struct __sk_buff *skb)
 	hdr.ip6hdr.payload_len = bpf_htons(skb->len + sizeof(struct grehdr));
 	hdr.ip6hdr.nexthdr = 47;  /* IPPROTO_GRE */
 	hdr.ip6hdr.hop_limit = 0x40;
-	/* fb01::1 */
+	/* fb05::1 */
 	hdr.ip6hdr.saddr.s6_addr[0] = 0xfb;
-	hdr.ip6hdr.saddr.s6_addr[1] = 1;
+	hdr.ip6hdr.saddr.s6_addr[1] = 5;
 	hdr.ip6hdr.saddr.s6_addr[15] = 1;
 	/* fb10::1 */
 	hdr.ip6hdr.daddr.s6_addr[0] = 0xfb;
@@ -73,6 +77,7 @@ int bpf_lwt_encap_gre6(struct __sk_buff *skb)
 	hdr.ip6hdr.daddr.s6_addr[15] = 1;
 
 	hdr.greh.protocol = skb->protocol;
+	hdr.greh.flags = bpf_htons(GRE_KEY);
 
 	err = bpf_lwt_push_encap(skb, BPF_LWT_ENCAP_IP, &hdr,
 				 sizeof(struct encap_hdr));
@@ -82,4 +87,42 @@ int bpf_lwt_encap_gre6(struct __sk_buff *skb)
 	return BPF_LWT_REROUTE;
 }
 
+SEC("encap_gre_md")
+int bpf_lwt_encap_gre_md(struct __sk_buff *skb)
+{
+	struct bpf_tunnel_key key;
+	int err;
+
+	__builtin_memset(&key, 0x0, sizeof(key));
+	key.remote_ipv4 = 0xac101064; /* 172.16.16.100 - always in host order */
+	key.tunnel_ttl = 0x40;
+	err = bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
+				     BPF_F_ZERO_CSUM_TX | BPF_F_SEQ_NUMBER);
+	if (err)
+		return BPF_DROP;
+
+	return BPF_OK;
+}
+
+SEC("encap_gre6_md")
+int bpf_lwt_encap_gre6_md(struct __sk_buff *skb)
+{
+	struct bpf_tunnel_key key;
+	int err;
+
+	__builtin_memset(&key, 0x0, sizeof(key));
+
+	/* fb10::1 */
+	key.remote_ipv6[0] = bpf_htonl(0xfb100000);
+	key.remote_ipv6[3] = bpf_htonl(0x01);
+	key.tunnel_ttl = 0x40;
+	err = bpf_skb_set_tunnel_key(skb, &key, sizeof(key),
+				     BPF_F_ZERO_CSUM_TX | BPF_F_SEQ_NUMBER |
+				     BPF_F_TUNINFO_IPV6);
+	if (err)
+		return BPF_DROP;
+
+	return BPF_OK;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_lwt_ip_encap.sh b/tools/testing/selftests/bpf/test_lwt_ip_encap.sh
deleted file mode 100755
index 6c69c42b1d60..000000000000
--- a/tools/testing/selftests/bpf/test_lwt_ip_encap.sh
+++ /dev/null
@@ -1,475 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-#
-# Setup/topology:
-#
-#    NS1             NS2             NS3
-#   veth1 <---> veth2   veth3 <---> veth4 (the top route)
-#   veth5 <---> veth6   veth7 <---> veth8 (the bottom route)
-#
-#   each vethN gets IPv[4|6]_N address
-#
-#   IPv*_SRC = IPv*_1
-#   IPv*_DST = IPv*_4
-#
-#   all tests test pings from IPv*_SRC to IPv*_DST
-#
-#   by default, routes are configured to allow packets to go
-#   IP*_1 <=> IP*_2 <=> IP*_3 <=> IP*_4 (the top route)
-#
-#   a GRE device is installed in NS3 with IPv*_GRE, and
-#   NS1/NS2 are configured to route packets to IPv*_GRE via IP*_8
-#   (the bottom route)
-#
-# Tests:
-#
-#   1. routes NS2->IPv*_DST are brought down, so the only way a ping
-#      from IP*_SRC to IP*_DST can work is via IPv*_GRE
-#
-#   2a. in an egress test, a bpf LWT_XMIT program is installed on veth1
-#       that encaps the packets with an IP/GRE header to route to IPv*_GRE
-#
-#       ping: SRC->[encap at veth1:egress]->GRE:decap->DST
-#       ping replies go DST->SRC directly
-#
-#   2b. in an ingress test, a bpf LWT_IN program is installed on veth2
-#       that encaps the packets with an IP/GRE header to route to IPv*_GRE
-#
-#       ping: SRC->[encap at veth2:ingress]->GRE:decap->DST
-#       ping replies go DST->SRC directly
-
-if [[ $EUID -ne 0 ]]; then
-	echo "This script must be run as root"
-	echo "FAIL"
-	exit 1
-fi
-
-readonly NS1="ns1-$(mktemp -u XXXXXX)"
-readonly NS2="ns2-$(mktemp -u XXXXXX)"
-readonly NS3="ns3-$(mktemp -u XXXXXX)"
-
-readonly IPv4_1="172.16.1.100"
-readonly IPv4_2="172.16.2.100"
-readonly IPv4_3="172.16.3.100"
-readonly IPv4_4="172.16.4.100"
-readonly IPv4_5="172.16.5.100"
-readonly IPv4_6="172.16.6.100"
-readonly IPv4_7="172.16.7.100"
-readonly IPv4_8="172.16.8.100"
-readonly IPv4_GRE="172.16.16.100"
-
-readonly IPv4_SRC=$IPv4_1
-readonly IPv4_DST=$IPv4_4
-
-readonly IPv6_1="fb01::1"
-readonly IPv6_2="fb02::1"
-readonly IPv6_3="fb03::1"
-readonly IPv6_4="fb04::1"
-readonly IPv6_5="fb05::1"
-readonly IPv6_6="fb06::1"
-readonly IPv6_7="fb07::1"
-readonly IPv6_8="fb08::1"
-readonly IPv6_GRE="fb10::1"
-
-readonly IPv6_SRC=$IPv6_1
-readonly IPv6_DST=$IPv6_4
-
-TEST_STATUS=0
-TESTS_SUCCEEDED=0
-TESTS_FAILED=0
-
-TMPFILE=""
-
-process_test_results()
-{
-	if [[ "${TEST_STATUS}" -eq 0 ]] ; then
-		echo "PASS"
-		TESTS_SUCCEEDED=$((TESTS_SUCCEEDED+1))
-	else
-		echo "FAIL"
-		TESTS_FAILED=$((TESTS_FAILED+1))
-	fi
-}
-
-print_test_summary_and_exit()
-{
-	echo "passed tests: ${TESTS_SUCCEEDED}"
-	echo "failed tests: ${TESTS_FAILED}"
-	if [ "${TESTS_FAILED}" -eq "0" ] ; then
-		exit 0
-	else
-		exit 1
-	fi
-}
-
-setup()
-{
-	set -e  # exit on error
-	TEST_STATUS=0
-
-	# create devices and namespaces
-	ip netns add "${NS1}"
-	ip netns add "${NS2}"
-	ip netns add "${NS3}"
-
-	# rp_filter gets confused by what these tests are doing, so disable it
-	ip netns exec ${NS1} sysctl -wq net.ipv4.conf.all.rp_filter=0
-	ip netns exec ${NS2} sysctl -wq net.ipv4.conf.all.rp_filter=0
-	ip netns exec ${NS3} sysctl -wq net.ipv4.conf.all.rp_filter=0
-	ip netns exec ${NS1} sysctl -wq net.ipv4.conf.default.rp_filter=0
-	ip netns exec ${NS2} sysctl -wq net.ipv4.conf.default.rp_filter=0
-	ip netns exec ${NS3} sysctl -wq net.ipv4.conf.default.rp_filter=0
-
-	# disable IPv6 DAD because it sometimes takes too long and fails tests
-	ip netns exec ${NS1} sysctl -wq net.ipv6.conf.all.accept_dad=0
-	ip netns exec ${NS2} sysctl -wq net.ipv6.conf.all.accept_dad=0
-	ip netns exec ${NS3} sysctl -wq net.ipv6.conf.all.accept_dad=0
-	ip netns exec ${NS1} sysctl -wq net.ipv6.conf.default.accept_dad=0
-	ip netns exec ${NS2} sysctl -wq net.ipv6.conf.default.accept_dad=0
-	ip netns exec ${NS3} sysctl -wq net.ipv6.conf.default.accept_dad=0
-
-	ip link add veth1 type veth peer name veth2
-	ip link add veth3 type veth peer name veth4
-	ip link add veth5 type veth peer name veth6
-	ip link add veth7 type veth peer name veth8
-
-	ip netns exec ${NS2} sysctl -wq net.ipv4.ip_forward=1
-	ip netns exec ${NS2} sysctl -wq net.ipv6.conf.all.forwarding=1
-
-	ip link set veth1 netns ${NS1}
-	ip link set veth2 netns ${NS2}
-	ip link set veth3 netns ${NS2}
-	ip link set veth4 netns ${NS3}
-	ip link set veth5 netns ${NS1}
-	ip link set veth6 netns ${NS2}
-	ip link set veth7 netns ${NS2}
-	ip link set veth8 netns ${NS3}
-
-	if [ ! -z "${VRF}" ] ; then
-		ip -netns ${NS1} link add red type vrf table 1001
-		ip -netns ${NS1} link set red up
-		ip -netns ${NS1} route add table 1001 unreachable default metric 8192
-		ip -netns ${NS1} -6 route add table 1001 unreachable default metric 8192
-		ip -netns ${NS1} link set veth1 vrf red
-		ip -netns ${NS1} link set veth5 vrf red
-
-		ip -netns ${NS2} link add red type vrf table 1001
-		ip -netns ${NS2} link set red up
-		ip -netns ${NS2} route add table 1001 unreachable default metric 8192
-		ip -netns ${NS2} -6 route add table 1001 unreachable default metric 8192
-		ip -netns ${NS2} link set veth2 vrf red
-		ip -netns ${NS2} link set veth3 vrf red
-		ip -netns ${NS2} link set veth6 vrf red
-		ip -netns ${NS2} link set veth7 vrf red
-	fi
-
-	# configure addesses: the top route (1-2-3-4)
-	ip -netns ${NS1}    addr add ${IPv4_1}/24  dev veth1
-	ip -netns ${NS2}    addr add ${IPv4_2}/24  dev veth2
-	ip -netns ${NS2}    addr add ${IPv4_3}/24  dev veth3
-	ip -netns ${NS3}    addr add ${IPv4_4}/24  dev veth4
-	ip -netns ${NS1} -6 addr add ${IPv6_1}/128 nodad dev veth1
-	ip -netns ${NS2} -6 addr add ${IPv6_2}/128 nodad dev veth2
-	ip -netns ${NS2} -6 addr add ${IPv6_3}/128 nodad dev veth3
-	ip -netns ${NS3} -6 addr add ${IPv6_4}/128 nodad dev veth4
-
-	# configure addresses: the bottom route (5-6-7-8)
-	ip -netns ${NS1}    addr add ${IPv4_5}/24  dev veth5
-	ip -netns ${NS2}    addr add ${IPv4_6}/24  dev veth6
-	ip -netns ${NS2}    addr add ${IPv4_7}/24  dev veth7
-	ip -netns ${NS3}    addr add ${IPv4_8}/24  dev veth8
-	ip -netns ${NS1} -6 addr add ${IPv6_5}/128 nodad dev veth5
-	ip -netns ${NS2} -6 addr add ${IPv6_6}/128 nodad dev veth6
-	ip -netns ${NS2} -6 addr add ${IPv6_7}/128 nodad dev veth7
-	ip -netns ${NS3} -6 addr add ${IPv6_8}/128 nodad dev veth8
-
-	ip -netns ${NS1} link set dev veth1 up
-	ip -netns ${NS2} link set dev veth2 up
-	ip -netns ${NS2} link set dev veth3 up
-	ip -netns ${NS3} link set dev veth4 up
-	ip -netns ${NS1} link set dev veth5 up
-	ip -netns ${NS2} link set dev veth6 up
-	ip -netns ${NS2} link set dev veth7 up
-	ip -netns ${NS3} link set dev veth8 up
-
-	# configure routes: IP*_SRC -> veth1/IP*_2 (= top route) default;
-	# the bottom route to specific bottom addresses
-
-	# NS1
-	# top route
-	ip -netns ${NS1}    route add ${IPv4_2}/32  dev veth1 ${VRF}
-	ip -netns ${NS1}    route add default dev veth1 via ${IPv4_2} ${VRF}  # go top by default
-	ip -netns ${NS1} -6 route add ${IPv6_2}/128 dev veth1 ${VRF}
-	ip -netns ${NS1} -6 route add default dev veth1 via ${IPv6_2} ${VRF}  # go top by default
-	# bottom route
-	ip -netns ${NS1}    route add ${IPv4_6}/32  dev veth5 ${VRF}
-	ip -netns ${NS1}    route add ${IPv4_7}/32  dev veth5 via ${IPv4_6} ${VRF}
-	ip -netns ${NS1}    route add ${IPv4_8}/32  dev veth5 via ${IPv4_6} ${VRF}
-	ip -netns ${NS1} -6 route add ${IPv6_6}/128 dev veth5 ${VRF}
-	ip -netns ${NS1} -6 route add ${IPv6_7}/128 dev veth5 via ${IPv6_6} ${VRF}
-	ip -netns ${NS1} -6 route add ${IPv6_8}/128 dev veth5 via ${IPv6_6} ${VRF}
-
-	# NS2
-	# top route
-	ip -netns ${NS2}    route add ${IPv4_1}/32  dev veth2 ${VRF}
-	ip -netns ${NS2}    route add ${IPv4_4}/32  dev veth3 ${VRF}
-	ip -netns ${NS2} -6 route add ${IPv6_1}/128 dev veth2 ${VRF}
-	ip -netns ${NS2} -6 route add ${IPv6_4}/128 dev veth3 ${VRF}
-	# bottom route
-	ip -netns ${NS2}    route add ${IPv4_5}/32  dev veth6 ${VRF}
-	ip -netns ${NS2}    route add ${IPv4_8}/32  dev veth7 ${VRF}
-	ip -netns ${NS2} -6 route add ${IPv6_5}/128 dev veth6 ${VRF}
-	ip -netns ${NS2} -6 route add ${IPv6_8}/128 dev veth7 ${VRF}
-
-	# NS3
-	# top route
-	ip -netns ${NS3}    route add ${IPv4_3}/32  dev veth4
-	ip -netns ${NS3}    route add ${IPv4_1}/32  dev veth4 via ${IPv4_3}
-	ip -netns ${NS3}    route add ${IPv4_2}/32  dev veth4 via ${IPv4_3}
-	ip -netns ${NS3} -6 route add ${IPv6_3}/128 dev veth4
-	ip -netns ${NS3} -6 route add ${IPv6_1}/128 dev veth4 via ${IPv6_3}
-	ip -netns ${NS3} -6 route add ${IPv6_2}/128 dev veth4 via ${IPv6_3}
-	# bottom route
-	ip -netns ${NS3}    route add ${IPv4_7}/32  dev veth8
-	ip -netns ${NS3}    route add ${IPv4_5}/32  dev veth8 via ${IPv4_7}
-	ip -netns ${NS3}    route add ${IPv4_6}/32  dev veth8 via ${IPv4_7}
-	ip -netns ${NS3} -6 route add ${IPv6_7}/128 dev veth8
-	ip -netns ${NS3} -6 route add ${IPv6_5}/128 dev veth8 via ${IPv6_7}
-	ip -netns ${NS3} -6 route add ${IPv6_6}/128 dev veth8 via ${IPv6_7}
-
-	# configure IPv4 GRE device in NS3, and a route to it via the "bottom" route
-	ip -netns ${NS3} tunnel add gre_dev mode gre remote ${IPv4_1} local ${IPv4_GRE} ttl 255
-	ip -netns ${NS3} link set gre_dev up
-	ip -netns ${NS3} addr add ${IPv4_GRE} dev gre_dev
-	ip -netns ${NS1} route add ${IPv4_GRE}/32 dev veth5 via ${IPv4_6} ${VRF}
-	ip -netns ${NS2} route add ${IPv4_GRE}/32 dev veth7 via ${IPv4_8} ${VRF}
-
-
-	# configure IPv6 GRE device in NS3, and a route to it via the "bottom" route
-	ip -netns ${NS3} -6 tunnel add name gre6_dev mode ip6gre remote ${IPv6_1} local ${IPv6_GRE} ttl 255
-	ip -netns ${NS3} link set gre6_dev up
-	ip -netns ${NS3} -6 addr add ${IPv6_GRE} nodad dev gre6_dev
-	ip -netns ${NS1} -6 route add ${IPv6_GRE}/128 dev veth5 via ${IPv6_6} ${VRF}
-	ip -netns ${NS2} -6 route add ${IPv6_GRE}/128 dev veth7 via ${IPv6_8} ${VRF}
-
-	TMPFILE=$(mktemp /tmp/test_lwt_ip_encap.XXXXXX)
-
-	sleep 1  # reduce flakiness
-	set +e
-}
-
-cleanup()
-{
-	if [ -f ${TMPFILE} ] ; then
-		rm ${TMPFILE}
-	fi
-
-	ip netns del ${NS1} 2> /dev/null
-	ip netns del ${NS2} 2> /dev/null
-	ip netns del ${NS3} 2> /dev/null
-}
-
-trap cleanup EXIT
-
-remove_routes_to_gredev()
-{
-	ip -netns ${NS1} route del ${IPv4_GRE} dev veth5 ${VRF}
-	ip -netns ${NS2} route del ${IPv4_GRE} dev veth7 ${VRF}
-	ip -netns ${NS1} -6 route del ${IPv6_GRE}/128 dev veth5 ${VRF}
-	ip -netns ${NS2} -6 route del ${IPv6_GRE}/128 dev veth7 ${VRF}
-}
-
-add_unreachable_routes_to_gredev()
-{
-	ip -netns ${NS1} route add unreachable ${IPv4_GRE}/32 ${VRF}
-	ip -netns ${NS2} route add unreachable ${IPv4_GRE}/32 ${VRF}
-	ip -netns ${NS1} -6 route add unreachable ${IPv6_GRE}/128 ${VRF}
-	ip -netns ${NS2} -6 route add unreachable ${IPv6_GRE}/128 ${VRF}
-}
-
-test_ping()
-{
-	local readonly PROTO=$1
-	local readonly EXPECTED=$2
-	local RET=0
-
-	if [ "${PROTO}" == "IPv4" ] ; then
-		ip netns exec ${NS1} ping  -c 1 -W 1 -I veth1 ${IPv4_DST} 2>&1 > /dev/null
-		RET=$?
-	elif [ "${PROTO}" == "IPv6" ] ; then
-		ip netns exec ${NS1} ping6 -c 1 -W 1 -I veth1 ${IPv6_DST} 2>&1 > /dev/null
-		RET=$?
-	else
-		echo "    test_ping: unknown PROTO: ${PROTO}"
-		TEST_STATUS=1
-	fi
-
-	if [ "0" != "${RET}" ]; then
-		RET=1
-	fi
-
-	if [ "${EXPECTED}" != "${RET}" ] ; then
-		echo "    test_ping failed: expected: ${EXPECTED}; got ${RET}"
-		TEST_STATUS=1
-	fi
-}
-
-test_gso()
-{
-	local readonly PROTO=$1
-	local readonly PKT_SZ=5000
-	local IP_DST=""
-	: > ${TMPFILE}  # trim the capture file
-
-	# check that nc is present
-	command -v nc >/dev/null 2>&1 || \
-		{ echo >&2 "nc is not available: skipping TSO tests"; return; }
-
-	# listen on port 9000, capture TCP into $TMPFILE
-	if [ "${PROTO}" == "IPv4" ] ; then
-		IP_DST=${IPv4_DST}
-		ip netns exec ${NS3} bash -c \
-			"nc -4 -l -p 9000 > ${TMPFILE} &"
-	elif [ "${PROTO}" == "IPv6" ] ; then
-		IP_DST=${IPv6_DST}
-		ip netns exec ${NS3} bash -c \
-			"nc -6 -l -p 9000 > ${TMPFILE} &"
-		RET=$?
-	else
-		echo "    test_gso: unknown PROTO: ${PROTO}"
-		TEST_STATUS=1
-	fi
-	sleep 1  # let nc start listening
-
-	# send a packet larger than MTU
-	ip netns exec ${NS1} bash -c \
-		"dd if=/dev/zero bs=$PKT_SZ count=1 > /dev/tcp/${IP_DST}/9000 2>/dev/null"
-	sleep 2 # let the packet get delivered
-
-	# verify we received all expected bytes
-	SZ=$(stat -c %s ${TMPFILE})
-	if [ "$SZ" != "$PKT_SZ" ] ; then
-		echo "    test_gso failed: ${PROTO}"
-		TEST_STATUS=1
-	fi
-}
-
-test_egress()
-{
-	local readonly ENCAP=$1
-	echo "starting egress ${ENCAP} encap test ${VRF}"
-	setup
-
-	# by default, pings work
-	test_ping IPv4 0
-	test_ping IPv6 0
-
-	# remove NS2->DST routes, ping fails
-	ip -netns ${NS2}    route del ${IPv4_DST}/32  dev veth3 ${VRF}
-	ip -netns ${NS2} -6 route del ${IPv6_DST}/128 dev veth3 ${VRF}
-	test_ping IPv4 1
-	test_ping IPv6 1
-
-	# install replacement routes (LWT/eBPF), pings succeed
-	if [ "${ENCAP}" == "IPv4" ] ; then
-		ip -netns ${NS1} route add ${IPv4_DST} encap bpf xmit obj \
-			test_lwt_ip_encap.o sec encap_gre dev veth1 ${VRF}
-		ip -netns ${NS1} -6 route add ${IPv6_DST} encap bpf xmit obj \
-			test_lwt_ip_encap.o sec encap_gre dev veth1 ${VRF}
-	elif [ "${ENCAP}" == "IPv6" ] ; then
-		ip -netns ${NS1} route add ${IPv4_DST} encap bpf xmit obj \
-			test_lwt_ip_encap.o sec encap_gre6 dev veth1 ${VRF}
-		ip -netns ${NS1} -6 route add ${IPv6_DST} encap bpf xmit obj \
-			test_lwt_ip_encap.o sec encap_gre6 dev veth1 ${VRF}
-	else
-		echo "    unknown encap ${ENCAP}"
-		TEST_STATUS=1
-	fi
-	test_ping IPv4 0
-	test_ping IPv6 0
-
-	# skip GSO tests with VRF: VRF routing needs properly assigned
-	# source IP/device, which is easy to do with ping and hard with dd/nc.
-	if [ -z "${VRF}" ] ; then
-		test_gso IPv4
-		test_gso IPv6
-	fi
-
-	# a negative test: remove routes to GRE devices: ping fails
-	remove_routes_to_gredev
-	test_ping IPv4 1
-	test_ping IPv6 1
-
-	# another negative test
-	add_unreachable_routes_to_gredev
-	test_ping IPv4 1
-	test_ping IPv6 1
-
-	cleanup
-	process_test_results
-}
-
-test_ingress()
-{
-	local readonly ENCAP=$1
-	echo "starting ingress ${ENCAP} encap test ${VRF}"
-	setup
-
-	# need to wait a bit for IPv6 to autoconf, otherwise
-	# ping6 sometimes fails with "unable to bind to address"
-
-	# by default, pings work
-	test_ping IPv4 0
-	test_ping IPv6 0
-
-	# remove NS2->DST routes, pings fail
-	ip -netns ${NS2}    route del ${IPv4_DST}/32  dev veth3 ${VRF}
-	ip -netns ${NS2} -6 route del ${IPv6_DST}/128 dev veth3 ${VRF}
-	test_ping IPv4 1
-	test_ping IPv6 1
-
-	# install replacement routes (LWT/eBPF), pings succeed
-	if [ "${ENCAP}" == "IPv4" ] ; then
-		ip -netns ${NS2} route add ${IPv4_DST} encap bpf in obj \
-			test_lwt_ip_encap.o sec encap_gre dev veth2 ${VRF}
-		ip -netns ${NS2} -6 route add ${IPv6_DST} encap bpf in obj \
-			test_lwt_ip_encap.o sec encap_gre dev veth2 ${VRF}
-	elif [ "${ENCAP}" == "IPv6" ] ; then
-		ip -netns ${NS2} route add ${IPv4_DST} encap bpf in obj \
-			test_lwt_ip_encap.o sec encap_gre6 dev veth2 ${VRF}
-		ip -netns ${NS2} -6 route add ${IPv6_DST} encap bpf in obj \
-			test_lwt_ip_encap.o sec encap_gre6 dev veth2 ${VRF}
-	else
-		echo "FAIL: unknown encap ${ENCAP}"
-		TEST_STATUS=1
-	fi
-	test_ping IPv4 0
-	test_ping IPv6 0
-
-	# a negative test: remove routes to GRE devices: ping fails
-	remove_routes_to_gredev
-	test_ping IPv4 1
-	test_ping IPv6 1
-
-	# another negative test
-	add_unreachable_routes_to_gredev
-	test_ping IPv4 1
-	test_ping IPv6 1
-
-	cleanup
-	process_test_results
-}
-
-VRF=""
-test_egress IPv4
-test_egress IPv6
-test_ingress IPv4
-test_ingress IPv6
-
-VRF="vrf red"
-test_egress IPv4
-test_egress IPv6
-test_ingress IPv4
-test_ingress IPv6
-
-print_test_summary_and_exit
-- 
2.34.1

