Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052116D3398
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Apr 2023 21:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjDATes (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 1 Apr 2023 15:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjDATek (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 1 Apr 2023 15:34:40 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7082659F
        for <linux-kselftest@vger.kernel.org>; Sat,  1 Apr 2023 12:34:32 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o32so14820630wms.1
        for <linux-kselftest@vger.kernel.org>; Sat, 01 Apr 2023 12:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1680377670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJGK6+z2A0j3BXRQbw4triQYURy3/oqOBEOPJiYTwI4=;
        b=fUuzcCs0NUU3SF2RUYCuNn0Oiw2gCmHfvbhb1BD0pbWHICjCtDnjAa7+y6w73qRq72
         mltQJK0qPM/N6qSKeoiMDhQB+qitpwsUynr1O0OegqaW2bYknXOl9fuGKnt/5rWK5HcN
         RXZ1NARlPOdxDC8ynDFmoLr4BpKVznv8DWJyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680377670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJGK6+z2A0j3BXRQbw4triQYURy3/oqOBEOPJiYTwI4=;
        b=dQrmLE6pJ63D4YZAn0TXC5DdhK1+QSM06UJQr6UlJc4FVJIfeB6f9q7Z//koHhBn17
         UMIT6emjEwP5AczLJ+qDtpLAlA4hRkZSVa0b8XoqxGWW+Uh3hd9/8Z5z20CYEBHIY3F3
         K0KkvkGxeW7rgzOfXukBoWdLeXM4L0+zhQqUJfI8x+0ri7Nh7qZlbYyu7MAeobTOO1WY
         IGegLPuXGd9xCayqQD6OobcPhpGLsLisMJlQp9tHLyxnyLKUqHe4tKSLRrEizSWYnwxE
         y0A4NNsjkJZNKsYTdzsFd5w5eTF3XepK1GncZkWJpp8rXC6BnTvG5wEVh3aIr5WuZ/Jg
         5EVA==
X-Gm-Message-State: AAQBX9cj8tIKlLMwTY8npY14fJneWIIfi1OODU4nhe+qJLmPMFuMBpBo
        iIWyDWFIm0xD3oR9YIOUBm51OQ==
X-Google-Smtp-Source: AKy350YrXN4Lsh7rTurigCkf4XLICVCHCRcuzwpOC4+RdNQ72wWylG4jPAt/uABsVHthrKbbpu2tmg==
X-Received: by 2002:a05:600c:2242:b0:3eb:3998:8c05 with SMTP id a2-20020a05600c224200b003eb39988c05mr9843697wmm.6.1680377670553;
        Sat, 01 Apr 2023 12:34:30 -0700 (PDT)
Received: from workstation.ehrig.io (tmo-065-106.customers.d1-online.com. [80.187.65.106])
        by smtp.gmail.com with ESMTPSA id b5-20020a5d4b85000000b002c559843748sm5600416wrt.10.2023.04.01.12.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 12:34:30 -0700 (PDT)
From:   Christian Ehrig <cehrig@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     cehrig@cloudflare.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Kaixi Fan <fankaixi.li@bytedance.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik@metanetworks.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 3/3] selftests/bpf: Test FOU kfuncs for externally controlled ipip devices
Date:   Sat,  1 Apr 2023 22:33:28 +0200
Message-Id: <3501bec71e3b50c59b4c6caa16906fb56168828b.1680379518.git.cehrig@cloudflare.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680379518.git.cehrig@cloudflare.com>
References: <cover.1680379518.git.cehrig@cloudflare.com>
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
 .../selftests/bpf/progs/test_tunnel_kern.c    | 117 ++++++++++++++++++
 tools/testing/selftests/bpf/test_tunnel.sh    |  81 ++++++++++++
 2 files changed, 198 insertions(+)

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
diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
index 2dec7dbf29a2..f2379414a887 100755
--- a/tools/testing/selftests/bpf/test_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tunnel.sh
@@ -212,6 +212,24 @@ add_ipip_tunnel()
 	ip addr add dev $DEV 10.1.1.200/24
 }
 
+add_ipip_encap_tunnel()
+{
+	# at_ns0 namespace
+  ip netns exec at_ns0 ip fou add port 5555 $IPPROTO
+  ip netns exec at_ns0 \
+  	ip link add dev $DEV_NS type $TYPE \
+  	local 172.16.1.100 remote 172.16.1.200 \
+  	encap $ENCAP encap-sport auto encap-dport 5555 noencap-csum
+  ip netns exec at_ns0 ip link set dev $DEV_NS up
+  ip netns exec at_ns0 ip addr add dev $DEV_NS 10.1.1.100/24
+
+  # root namespace
+  ip fou add port 5555 $IPPROTO
+  ip link add dev $DEV type $TYPE external
+  ip link set dev $DEV up
+  ip addr add dev $DEV 10.1.1.200/24
+}
+
 add_ip6tnl_tunnel()
 {
 	ip netns exec at_ns0 ip addr add ::11/96 dev veth0
@@ -461,6 +479,60 @@ test_ipip()
         echo -e ${GREEN}"PASS: $TYPE"${NC}
 }
 
+test_ipip_gue()
+{
+	TYPE=ipip
+	DEV_NS=ipip00
+	DEV=ipip11
+	ret=0
+	ENCAP=gue
+	IPPROTO=$ENCAP
+
+	check $TYPE
+	config_device
+	add_ipip_encap_tunnel
+	ip link set dev veth1 mtu 1500
+	attach_bpf $DEV ipip_gue_set_tunnel ipip_encap_get_tunnel
+	ping $PING_ARG 10.1.1.100
+	check_err $?
+	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
+	check_err $?
+	cleanup
+
+	if [ $ret -ne 0 ]; then
+                echo -e ${RED}"FAIL: $TYPE (GUE)"${NC}
+                return 1
+        fi
+        echo -e ${GREEN}"PASS: $TYPE (GUE)"${NC}
+}
+
+test_ipip_fou()
+{
+	TYPE=ipip
+	DEV_NS=ipip00
+	DEV=ipip11
+	ret=0
+	ENCAP=fou
+	IPPROTO="ipproto 4"
+
+	check $TYPE
+	config_device
+	add_ipip_encap_tunnel
+	ip link set dev veth1 mtu 1500
+	attach_bpf $DEV ipip_fou_set_tunnel ipip_encap_get_tunnel
+	ping $PING_ARG 10.1.1.100
+	check_err $?
+	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
+	check_err $?
+	cleanup
+
+	if [ $ret -ne 0 ]; then
+                echo -e ${RED}"FAIL: $TYPE (FOU)"${NC}
+                return 1
+        fi
+        echo -e ${GREEN}"PASS: $TYPE (FOU)"${NC}
+}
+
 test_ipip6()
 {
 	TYPE=ip6tnl
@@ -634,6 +706,7 @@ cleanup()
 	ip xfrm policy delete dir in src 10.1.1.100/32 dst 10.1.1.200/32 2> /dev/null
 	ip xfrm state delete src 172.16.1.100 dst 172.16.1.200 proto esp spi 0x1 2> /dev/null
 	ip xfrm state delete src 172.16.1.200 dst 172.16.1.100 proto esp spi 0x2 2> /dev/null
+	ip fou del port 5555 gue 2> /dev/null
 }
 
 cleanup_exit()
@@ -708,6 +781,14 @@ bpf_tunnel_test()
 	test_ipip
 	errors=$(( $errors + $? ))
 
+	echo "Testing IPIP (GUE) tunnel..."
+  test_ipip_gue
+  errors=$(( $errors + $? ))
+
+	echo "Testing IPIP (FOU) tunnel..."
+  test_ipip_fou
+  errors=$(( $errors + $? ))
+
 	echo "Testing IPIP6 tunnel..."
 	test_ipip6
 	errors=$(( $errors + $? ))
-- 
2.39.2

