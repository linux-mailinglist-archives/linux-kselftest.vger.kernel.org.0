Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825976DADE8
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Apr 2023 15:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240875AbjDGNlJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Apr 2023 09:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240905AbjDGNkj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Apr 2023 09:40:39 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0260FB450
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Apr 2023 06:39:44 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id i8-20020a05600c354800b003ee93d2c914so597411wmq.2
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Apr 2023 06:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1680874782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJ8dLEHPX/vr4lIC48z7xqsg6C5SdL9O7h1kkVcNjwE=;
        b=dat8tlQQNEYeKcPPa4rPZfEzVIkFpNO3wu69pTNI1VUeM/BlvXYDmh30mk/uD65MoN
         Wk/udCHifvXPO2KN3wvGa773A62VfcmAisVhgUEzSetZIrFcrY0NWTNrKFVcCWRMFngJ
         sBLIW8A3dVMz0dfIWjAGWa9HV0x7pwr2efd2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680874782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJ8dLEHPX/vr4lIC48z7xqsg6C5SdL9O7h1kkVcNjwE=;
        b=jOR0cgzVFvtydrJK2Tfjh6tB4wszuXc4TOphda1ws4xSvQFxIFtNWpZtCBPL75YC6D
         UQ+Ne9MeLlHqVhgDGxqEKsRsuP5d8aP96JCtsE76zIFJIvFsnTxEboLPJDh1Kabc4Lgt
         GVKvMLvYszfWaD5SK3w2ZIUh2xupY7oB/kAFY2xfBCOPgSCVb8BuApxp7IE4uBM/lm+e
         blS6tjeEKYbF+Pz/iqkJgWZ82y3U5IuUpEIKuJ/FsjBePExMDHASDDTct0VLJKnQm7K4
         60fKWxSPXIv5GGD+Y7iic0pUd6qqIQ2H2QdodNvCWVGoTzEQmqMlXIk3+MxZvIQ8EpFG
         5vIg==
X-Gm-Message-State: AAQBX9dOT4GxJOPT5JH38Y/JPMpV79s6Ky8jQfxT++xrJTOxF1gXEhlB
        ZlwIJ/pMCL4TF8FUzx/QHbtf5w==
X-Google-Smtp-Source: AKy350Y+idqnCZ954OSR0g4+DBCHAEoN9t+h6JpFTDZ5xzN1cJMNLmvv0TaIFZP0DwjHQ0Viq/RPQQ==
X-Received: by 2002:a1c:7312:0:b0:3ed:9b20:c7c1 with SMTP id d18-20020a1c7312000000b003ed9b20c7c1mr1239983wmb.20.1680874782396;
        Fri, 07 Apr 2023 06:39:42 -0700 (PDT)
Received: from workstation.ehrig.io (p4fdbfbb0.dip0.t-ipconnect.de. [79.219.251.176])
        by smtp.gmail.com with ESMTPSA id m13-20020a056000180d00b002efac42ff35sm2380188wrh.37.2023.04.07.06.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 06:39:41 -0700 (PDT)
From:   Christian Ehrig <cehrig@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     cehrig@cloudflare.com, kernel-team@cloudflare.com,
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
        Hangbin Liu <liuhangbin@gmail.com>,
        Paul Chaignon <paul@isovalent.com>,
        Kaixi Fan <fankaixi.li@bytedance.com>,
        Shmulik Ladkani <shmulik@metanetworks.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Test FOU kfuncs for externally controlled ipip devices
Date:   Fri,  7 Apr 2023 15:38:55 +0200
Message-Id: <040193566ddbdb0b53eb359f7ac7bbd316f338b5.1680874078.git.cehrig@cloudflare.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680874078.git.cehrig@cloudflare.com>
References: <cover.1680874078.git.cehrig@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add tests for FOU and GUE encapsulation via the bpf_skb_{set,get}_fou_encap
kfuncs, using ipip devices in collect-metadata mode.

These tests make sure that we can successfully set and obtain FOU and GUE
encap parameters using ingress / egress BPF tc-hooks.

Signed-off-by: Christian Ehrig <cehrig@cloudflare.com>
---
 .../selftests/bpf/prog_tests/test_tunnel.c    | 153 +++++++++++++++++-
 .../selftests/bpf/progs/test_tunnel_kern.c    | 117 ++++++++++++++
 2 files changed, 268 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index 47f1d482fe39..d149ab98798d 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
@@ -89,6 +89,9 @@
 #define IP6VXLAN_TUNL_DEV0 "ip6vxlan00"
 #define IP6VXLAN_TUNL_DEV1 "ip6vxlan11"
 
+#define IPIP_TUNL_DEV0 "ipip00"
+#define IPIP_TUNL_DEV1 "ipip11"
+
 #define PING_ARGS "-i 0.01 -c 3 -w 10 -q"
 
 static int config_device(void)
@@ -188,6 +191,79 @@ static void delete_ip6vxlan_tunnel(void)
 	SYS_NOFAIL("ip link delete dev %s", IP6VXLAN_TUNL_DEV1);
 }
 
+enum ipip_encap {
+	NONE	= 0,
+	FOU	= 1,
+	GUE	= 2,
+};
+
+static int set_ipip_encap(const char *ipproto, const char *type)
+{
+	SYS(fail, "ip -n at_ns0 fou add port 5555 %s", ipproto);
+	SYS(fail, "ip -n at_ns0 link set dev %s type ipip encap %s",
+	    IPIP_TUNL_DEV0, type);
+	SYS(fail, "ip -n at_ns0 link set dev %s type ipip encap-dport 5555",
+	    IPIP_TUNL_DEV0);
+
+	return 0;
+fail:
+	return -1;
+}
+
+static int add_ipip_tunnel(enum ipip_encap encap)
+{
+	int err;
+	const char *ipproto, *type;
+
+	switch (encap) {
+	case FOU:
+		ipproto = "ipproto 4";
+		type = "fou";
+		break;
+	case GUE:
+		ipproto = "gue";
+		type = ipproto;
+		break;
+	default:
+		ipproto = NULL;
+		type = ipproto;
+	}
+
+	/* at_ns0 namespace */
+	SYS(fail, "ip -n at_ns0 link add dev %s type ipip local %s remote %s",
+	    IPIP_TUNL_DEV0, IP4_ADDR_VETH0, IP4_ADDR1_VETH1);
+
+	if (type && ipproto) {
+		err = set_ipip_encap(ipproto, type);
+		if (!ASSERT_OK(err, "set_ipip_encap"))
+			goto fail;
+	}
+
+	SYS(fail, "ip -n at_ns0 link set dev %s up", IPIP_TUNL_DEV0);
+	SYS(fail, "ip -n at_ns0 addr add dev %s %s/24",
+	    IPIP_TUNL_DEV0, IP4_ADDR_TUNL_DEV0);
+
+	/* root namespace */
+	if (type && ipproto)
+		SYS(fail, "ip fou add port 5555 %s", ipproto);
+	SYS(fail, "ip link add dev %s type ipip external", IPIP_TUNL_DEV1);
+	SYS(fail, "ip link set dev %s up", IPIP_TUNL_DEV1);
+	SYS(fail, "ip addr add dev %s %s/24", IPIP_TUNL_DEV1,
+	    IP4_ADDR_TUNL_DEV1);
+
+	return 0;
+fail:
+	return -1;
+}
+
+static void delete_ipip_tunnel(void)
+{
+	SYS_NOFAIL("ip -n at_ns0 link delete dev %s", IPIP_TUNL_DEV0);
+	SYS_NOFAIL("ip -n at_ns0 fou del port 5555 2> /dev/null");
+	SYS_NOFAIL("ip link delete dev %s", IPIP_TUNL_DEV1);
+	SYS_NOFAIL("ip fou del port 5555 2> /dev/null");
+}
+
 static int test_ping(int family, const char *addr)
 {
 	SYS(fail, "%s %s %s > /dev/null", ping_command(family), PING_ARGS, addr);
@@ -386,10 +462,80 @@ static void test_ip6vxlan_tunnel(void)
 		test_tunnel_kern__destroy(skel);
 }
 
-#define RUN_TEST(name)							\
+static void test_ipip_tunnel(enum ipip_encap encap)
+{
+	struct test_tunnel_kern *skel = NULL;
+	struct nstoken *nstoken;
+	int set_src_prog_fd, get_src_prog_fd;
+	int ifindex = -1;
+	int err;
+	DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook,
+			    .attach_point = BPF_TC_INGRESS);
+
+	/* add ipip tunnel */
+	err = add_ipip_tunnel(encap);
+	if (!ASSERT_OK(err, "add_ipip_tunnel"))
+		goto done;
+
+	/* load and attach bpf prog to tunnel dev tc hook point */
+	skel = test_tunnel_kern__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_tunnel_kern__open_and_load"))
+		goto done;
+	ifindex = if_nametoindex(IPIP_TUNL_DEV1);
+	if (!ASSERT_NEQ(ifindex, 0, "ipip11 ifindex"))
+		goto done;
+	tc_hook.ifindex = ifindex;
+
+	switch (encap) {
+	case FOU:
+		get_src_prog_fd = bpf_program__fd(
+			skel->progs.ipip_encap_get_tunnel);
+		set_src_prog_fd = bpf_program__fd(
+			skel->progs.ipip_fou_set_tunnel);
+		break;
+	case GUE:
+		get_src_prog_fd = bpf_program__fd(
+			skel->progs.ipip_encap_get_tunnel);
+		set_src_prog_fd = bpf_program__fd(
+			skel->progs.ipip_gue_set_tunnel);
+		break;
+	default:
+		get_src_prog_fd = bpf_program__fd(
+			skel->progs.ipip_get_tunnel);
+		set_src_prog_fd = bpf_program__fd(
+			skel->progs.ipip_set_tunnel);
+	}
+
+	if (!ASSERT_GE(set_src_prog_fd, 0, "bpf_program__fd"))
+		goto done;
+	if (!ASSERT_GE(get_src_prog_fd, 0, "bpf_program__fd"))
+		goto done;
+	if (attach_tc_prog(&tc_hook, get_src_prog_fd, set_src_prog_fd))
+		goto done;
+
+	/* ping from root namespace test */
+	err = test_ping(AF_INET, IP4_ADDR_TUNL_DEV0);
+	if (!ASSERT_OK(err, "test_ping"))
+		goto done;
+
+	/* ping from at_ns0 namespace test */
+	nstoken = open_netns("at_ns0");
+	err = test_ping(AF_INET, IP4_ADDR_TUNL_DEV1);
+	if (!ASSERT_OK(err, "test_ping"))
+		goto done;
+	close_netns(nstoken);
+
+done:
+	/* delete ipip tunnel */
+	delete_ipip_tunnel();
+	if (skel)
+		test_tunnel_kern__destroy(skel);
+}
+
+#define RUN_TEST(name, ...)						\
 	({								\
 		if (test__start_subtest(#name)) {			\
-			test_ ## name();				\
+			test_ ## name(__VA_ARGS__);			\
 		}							\
 	})
 
@@ -400,6 +546,9 @@ static void *test_tunnel_run_tests(void *arg)
 
 	RUN_TEST(vxlan_tunnel);
 	RUN_TEST(ip6vxlan_tunnel);
+	RUN_TEST(ipip_tunnel, NONE);
+	RUN_TEST(ipip_tunnel, FOU);
+	RUN_TEST(ipip_tunnel, GUE);
 
 	cleanup();
 
diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index 9ab2d55ab7c0..f66af753bbbb 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -52,6 +52,21 @@ struct vxlan_metadata {
 	__u32     gbp;
 };
 
+struct bpf_fou_encap {
+	__be16 sport;
+	__be16 dport;
+};
+
+enum bpf_fou_encap_type {
+	FOU_BPF_ENCAP_FOU,
+	FOU_BPF_ENCAP_GUE,
+};
+
+int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx,
+			  struct bpf_fou_encap *encap, int type) __ksym;
+int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
+			  struct bpf_fou_encap *encap) __ksym;
+
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
 	__uint(max_entries, 1);
@@ -749,6 +764,108 @@ int ipip_get_tunnel(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
+SEC("tc")
+int ipip_gue_set_tunnel(struct __sk_buff *skb)
+{
+	struct bpf_tunnel_key key = {};
+	struct bpf_fou_encap encap = {};
+	void *data = (void *)(long)skb->data;
+	struct iphdr *iph = data;
+	void *data_end = (void *)(long)skb->data_end;
+	int ret;
+
+	if (data + sizeof(*iph) > data_end) {
+		log_err(1);
+		return TC_ACT_SHOT;
+	}
+
+	key.tunnel_ttl = 64;
+	if (iph->protocol == IPPROTO_ICMP)
+		key.remote_ipv4 = 0xac100164; /* 172.16.1.100 */
+
+	ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key), 0);
+	if (ret < 0) {
+		log_err(ret);
+		return TC_ACT_SHOT;
+	}
+
+	encap.sport = 0;
+	encap.dport = bpf_htons(5555);
+
+	ret = bpf_skb_set_fou_encap(skb, &encap, FOU_BPF_ENCAP_GUE);
+	if (ret < 0) {
+		log_err(ret);
+		return TC_ACT_SHOT;
+	}
+
+	return TC_ACT_OK;
+}
+
+SEC("tc")
+int ipip_fou_set_tunnel(struct __sk_buff *skb)
+{
+	struct bpf_tunnel_key key = {};
+	struct bpf_fou_encap encap = {};
+	void *data = (void *)(long)skb->data;
+	struct iphdr *iph = data;
+	void *data_end = (void *)(long)skb->data_end;
+	int ret;
+
+	if (data + sizeof(*iph) > data_end) {
+		log_err(1);
+		return TC_ACT_SHOT;
+	}
+
+	key.tunnel_ttl = 64;
+	if (iph->protocol == IPPROTO_ICMP)
+		key.remote_ipv4 = 0xac100164; /* 172.16.1.100 */
+
+	ret = bpf_skb_set_tunnel_key(skb, &key, sizeof(key), 0);
+	if (ret < 0) {
+		log_err(ret);
+		return TC_ACT_SHOT;
+	}
+
+	encap.sport = 0;
+	encap.dport = bpf_htons(5555);
+
+	ret = bpf_skb_set_fou_encap(skb, &encap, FOU_BPF_ENCAP_FOU);
+	if (ret < 0) {
+		log_err(ret);
+		return TC_ACT_SHOT;
+	}
+
+	return TC_ACT_OK;
+}
+
+SEC("tc")
+int ipip_encap_get_tunnel(struct __sk_buff *skb)
+{
+	int ret;
+	struct bpf_tunnel_key key = {};
+	struct bpf_fou_encap encap = {};
+
+	ret = bpf_skb_get_tunnel_key(skb, &key, sizeof(key), 0);
+	if (ret < 0) {
+		log_err(ret);
+		return TC_ACT_SHOT;
+	}
+
+	ret = bpf_skb_get_fou_encap(skb, &encap);
+	if (ret < 0) {
+		log_err(ret);
+		return TC_ACT_SHOT;
+	}
+
+	if (bpf_ntohs(encap.dport) != 5555)
+		return TC_ACT_SHOT;
+
+	bpf_printk("%d remote ip 0x%x, sport %d, dport %d\n", ret,
+		   key.remote_ipv4, bpf_ntohs(encap.sport),
+		   bpf_ntohs(encap.dport));
+	return TC_ACT_OK;
+}
+
 SEC("tc")
 int ipip6_set_tunnel(struct __sk_buff *skb)
 {
-- 
2.39.2

