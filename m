Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF936D4324
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Apr 2023 13:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjDCLNW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Apr 2023 07:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjDCLNK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Apr 2023 07:13:10 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518002D4A
        for <linux-kselftest@vger.kernel.org>; Mon,  3 Apr 2023 04:12:44 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d17so28904707wrb.11
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Apr 2023 04:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1680520363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJGK6+z2A0j3BXRQbw4triQYURy3/oqOBEOPJiYTwI4=;
        b=tpFFS4UnM3prfzvnWok4lKRG4k267cw8oCzicAYmRl1H6CB6VSOmte/empqxGvcWy7
         Moqy9a1QyOZJ+XDWTAYRrDqM8ZZJZSxJG2WHAKEPIcRN2W2/t0mIggTKqDNFn6iAhKUd
         khD3w7P4NcOnjfp3u7S5/YNSB+jEavbx+NV+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680520363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJGK6+z2A0j3BXRQbw4triQYURy3/oqOBEOPJiYTwI4=;
        b=hvoI0at2kCAF/11GJEuB0CX6pPvGrnZdZHazGwmGpR2EzBLwVpXvbluSJw9un38WJ/
         rkRHHagkW0ehdbkhxgfo5fbJvIhyl4uO2mbEqGd7Enck25751FAJkQ786CpSb57Py6/Z
         XhKfrocBiPbFVtkKuSlg6QddFn3BaOPH74ZigjvrZ4Iv9L3hirkQwoOwwHDtvw2kHdYO
         LQ0duiIqFXkjtes2cAa+ACp4XjDx/WWS2qmpzYYLRbu4J16Aiy+PdZr3EF/e6hC4lEUs
         Xrk4VNBo8extyh88/o5JfIfLYzHW66G8CzWlKjCF6Rc3FBMmCsoLFv9LwfOMjNrZVQYT
         qXeg==
X-Gm-Message-State: AAQBX9dD4xn4MGN9rfJvH9mAP7tn94vU1nHwCN0Wj4zvDzDsanF40GRh
        8ZnM9TS/C4rjf0CofnQeeUQClw==
X-Google-Smtp-Source: AKy350bcITxGCnkiMeQi5Vz8Ia9/Zlb9CV3ZkbXUJUt3e/Xz42s2EhmH92FXuuBHO4CBhxxI/xNO2g==
X-Received: by 2002:adf:fccc:0:b0:2cf:e868:f789 with SMTP id f12-20020adffccc000000b002cfe868f789mr25909194wrs.48.1680520362592;
        Mon, 03 Apr 2023 04:12:42 -0700 (PDT)
Received: from workstation.ehrig.io (tmo-066-125.customers.d1-online.com. [80.187.66.125])
        by smtp.gmail.com with ESMTPSA id y11-20020adffa4b000000b002c7066a6f77sm9505517wrr.31.2023.04.03.04.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 04:12:42 -0700 (PDT)
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
        Kaixi Fan <fankaixi.li@bytedance.com>,
        Paul Chaignon <paul@isovalent.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Test FOU kfuncs for externally controlled ipip devices
Date:   Mon,  3 Apr 2023 14:12:09 +0200
Message-Id: <528a824713c1545839d870eaad84d87749a23371.1680520500.git.cehrig@cloudflare.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680520500.git.cehrig@cloudflare.com>
References: <cover.1680520500.git.cehrig@cloudflare.com>
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

