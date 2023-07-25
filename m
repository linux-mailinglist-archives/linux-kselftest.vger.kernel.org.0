Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912DE760716
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 06:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjGYEOT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 00:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGYEOS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 00:14:18 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C85E59
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jul 2023 21:14:16 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7658430eb5dso542885885a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jul 2023 21:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690258456; x=1690863256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H5Unmq6oikn4ADho9QqUfzK7Esqr6kPDSC3udHTdE3Y=;
        b=NYN0m+yAt2wJGCDAMDqxtGwqkhER+qdoiasNFvcMRY6AJ9xHz+uNsWy7LHtHbxdhKD
         7p0tNZHJLH7liKIqfK+uPjQLy+CuRMhGGDD24qWesU9Khtm29yuDaFiGOagASZ+AyVeq
         WY2OmMSy+9SEcr2SBwZSgXaoH1b7XHWmDoy7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690258456; x=1690863256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5Unmq6oikn4ADho9QqUfzK7Esqr6kPDSC3udHTdE3Y=;
        b=Y+D7kBg4OS8tlqPQZK/6x6QyqIMx59SdVpIs4BLBBa+KSIRON242IRhVyVVjksXCVJ
         qd+z248rDupyXnFOGs9uPfl2L1+PneMfKhqqqCEsMeSiBPEzOUT6jNs2//3F79SBXdwY
         HxvnM4MUUEBeCx7Xv0TGTWuubCoOjCYo9ypwSDHui0DfHC/r8zEn/JlctldRZGjcqRU+
         HC/96rsKcYK4ELP0kYig750gAlLm8d94i34vqxvIbEr80CuMA2UtbNU6TOdIl7qKTvUd
         CyTb3eEvVJnznkxh4SW2lBjB9skQ/0WLb+opPOiFAk2MmnyI2FekvycJunxstbVozMdP
         0SQA==
X-Gm-Message-State: ABy/qLaPYN50PLs8qhiaw+nLkuGdvkrmUA7suq0hhqeO8zCo343gmO/0
        zCrWIf5dYtTgQi+VGWfeDxwYTw==
X-Google-Smtp-Source: APBJJlF0iw2TioJNhnLh5aH7gbpQD5xjZTA6a9XppFsKqUhXdSSEouvHkSCMUBU2JRB7L24/N0z61Q==
X-Received: by 2002:a05:620a:3906:b0:765:a633:43f2 with SMTP id qr6-20020a05620a390600b00765a63343f2mr2162337qkn.12.1690258455789;
        Mon, 24 Jul 2023 21:14:15 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id u12-20020a0cb40c000000b0061a68b5a8c4sm4111455qve.134.2023.07.24.21.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 21:14:15 -0700 (PDT)
Date:   Mon, 24 Jul 2023 21:14:12 -0700
From:   Yan Zhai <yan@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Yan Zhai <yan@cloudflare.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@cloudflare.com, Jordan Griege <jgriege@cloudflare.com>
Subject: [PATCH v3 bpf 2/2] selftests/bpf: test lwt redirect error handling
Message-ID: <25c13cb89412b120616f4e31a31c3108e45bc6af.1690255889.git.yan@cloudflare.com>
References: <cover.1690255889.git.yan@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690255889.git.yan@cloudflare.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Tests BPF redirect at the lwt xmit hook to ensure error handling are
safe, i.e. won't panic the kernel.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 tools/testing/selftests/bpf/Makefile          |   1 +
 .../selftests/bpf/progs/test_lwt_redirect.c   |  67 +++++++
 .../selftests/bpf/test_lwt_redirect.sh        | 165 ++++++++++++++++++
 3 files changed, 233 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_lwt_redirect.c
 create mode 100755 tools/testing/selftests/bpf/test_lwt_redirect.sh

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 538df8fb8c42..e3a24d053793 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -66,6 +66,7 @@ TEST_PROGS := test_kmod.sh \
 	test_xdp_vlan_mode_generic.sh \
 	test_xdp_vlan_mode_native.sh \
 	test_lwt_ip_encap.sh \
+	test_lwt_redirect.sh \
 	test_tcp_check_syncookie.sh \
 	test_tc_tunnel.sh \
 	test_tc_edt.sh \
diff --git a/tools/testing/selftests/bpf/progs/test_lwt_redirect.c b/tools/testing/selftests/bpf/progs/test_lwt_redirect.c
new file mode 100644
index 000000000000..622c6b1e7128
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_lwt_redirect.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+#define ETH_LEN 14
+
+/* We don't care about whether the packet can be received by network stack.
+ * Just care if the packet is sent to the correct device at correct direction
+ * and not panic the kernel.
+ */
+static __always_inline int prepend_dummy_mac(struct __sk_buff *skb)
+{
+	char mac[] = {0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0xf,
+		      0xe, 0xd, 0xc, 0xb, 0xa, 0x08, 0x00};
+
+	if (bpf_skb_change_head(skb, ETH_LEN, 0)) {
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
+	bpf_printk("Redirect skb to link %d ingress", skb->mark);
+	return bpf_redirect(skb->mark, BPF_F_INGRESS);
+}
+
+SEC("redir_egress")
+int test_lwt_redirect_out(struct __sk_buff *skb)
+{
+	if (prepend_dummy_mac(skb))
+		return BPF_DROP;
+
+	bpf_printk("Redirect skb to link %d egress", skb->mark);
+	return bpf_redirect(skb->mark, 0);
+}
+
+SEC("redir_egress_nomac")
+int test_lwt_redirect_out_nomac(struct __sk_buff *skb)
+{
+	int ret = bpf_redirect(skb->mark, 0);
+
+	bpf_printk("Redirect skb to link %d egress nomac: %d", skb->mark, ret);
+	return ret;
+}
+
+SEC("redir_ingress_nomac")
+int test_lwt_redirect_in_nomac(struct __sk_buff *skb)
+{
+	int ret = bpf_redirect(skb->mark, BPF_F_INGRESS);
+
+	bpf_printk("Redirect skb to link %d ingress nomac: %d", skb->mark, ret);
+	return ret;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_lwt_redirect.sh b/tools/testing/selftests/bpf/test_lwt_redirect.sh
new file mode 100755
index 000000000000..fe97cbc40ee8
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_lwt_redirect.sh
@@ -0,0 +1,165 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# This regression test checks basic lwt redirect functionality,
+# making sure the kernel would not crash when redirecting packets
+# to a device, regardless its administration state:
+#
+# 1. redirect to a device egress/ingress should work normally
+# 2. redirect to a device egress/ingress should not panic when target is down
+# 3. redirect to a device egress/ingress should not panic when target carrier is down
+#
+# All test setup are simple: redirect ping packet via lwt xmit to cover above
+# situations. We do not worry about specific device type, except for the two
+# categories of devices that require MAC header and not require MAC header. For
+# carrier down situation, we use a vlan device as upper link, and bring down its
+# lower device.
+#
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+BPF_FILE="test_lwt_redirect.bpf.o"
+INGRESS_REDIR_IP=2.2.2.2
+EGRESS_REDIR_IP=3.3.3.3
+INGRESS_REDIR_IP_NOMAC=4.4.4.4
+EGRESS_REDIR_IP_NOMAC=5.5.5.5
+PASS=0
+FAIL=0
+
+readonly NS1="ns1-$(mktemp -u XXXXXX)"
+
+msg="skip all tests:"
+if [ $UID != 0 ]; then
+	echo $msg please run this as root >&2
+	exit $ksft_skip
+fi
+
+get_ip_direction() {
+	case $1 in
+		$INGRESS_REDIR_IP|$INGRESS_REDIR_IP_NOMAC)
+			echo ingress
+			;;
+		$EGRESS_REDIR_IP|$EGRESS_REDIR_IP_NOMAC)
+			echo egress
+			;;
+		*)
+			echo bug
+			;;
+	esac
+}
+
+test_pass()
+{
+	local testname=$1
+	local direction=`get_ip_direction $2`
+	shift 2
+	echo "Pass: $testname $direction $@"
+	PASS=$((PASS + 1))
+}
+
+test_fail()
+{
+	local testname=$1
+	local direction=`get_ip_direction $2`
+	shift 2
+	echo "Fail: $testname $direction $@"
+	FAIL=$((FAIL + 1))
+}
+
+setup() {
+	ip netns add $NS1
+
+	ip -n $NS1 link set lo up
+	ip -n $NS1 link add link_err type dummy
+	ip -n $NS1 link add link_w_mac type dummy
+	ip -n $NS1 link add link link_w_mac link_upper type vlan id 1
+	ip -n $NS1 link add link_wo_mac type gre remote 4.3.2.1 local 1.2.3.4
+	ip -n $NS1 link set link_err up
+	ip -n $NS1 link set link_w_mac up
+	ip -n $NS1 link set link_upper up
+	ip -n $NS1 link set link_wo_mac up
+
+	ip -n $NS1 addr add dev lo 1.1.1.1/32
+	ip -n $NS1 route add $INGRESS_REDIR_IP encap bpf xmit \
+		obj $BPF_FILE sec redir_ingress dev link_err
+	ip -n $NS1 route add $EGRESS_REDIR_IP encap bpf xmit \
+		obj $BPF_FILE sec redir_egress dev link_err
+	ip -n $NS1 route add $INGRESS_REDIR_IP_NOMAC encap bpf xmit \
+		obj $BPF_FILE sec redir_ingress_nomac dev link_err
+	ip -n $NS1 route add $EGRESS_REDIR_IP_NOMAC encap bpf xmit \
+		obj $BPF_FILE sec redir_egress_nomac dev link_err
+}
+
+cleanup_and_summary() {
+	ip netns del $NS1
+	echo PASSED:$PASS FAILED:$FAIL
+	if [ $FAIL -ne 0 ]; then
+		exit 1
+	else
+		exit 0
+	fi
+}
+
+test_redirect_normal() {
+	local test_name=${FUNCNAME[0]}
+	local link_name=$1
+	local link_id=`ip netns exec $NS1 cat /sys/class/net/${link_name}/ifindex`
+	local dest=$2
+
+	ip netns exec $NS1 timeout 2 tcpdump -i ${link_name} -c 1 -n -p icmp >/dev/null 2>&1 &
+	local jobid=$!
+	sleep 1
+
+	# hack: mark indicates the link to redirect to
+	ip netns exec $NS1 ping -m $link_id $dest -c 1 -w 1  > /dev/null 2>&1
+	wait $jobid
+
+	if [ $? -ne 0 ]; then
+		test_fail $test_name $dest $link_name
+	else
+		test_pass $test_name $dest $link_name
+	fi
+}
+
+test_redirect_no_panic_on_link_down() {
+	local test_name=${FUNCNAME[0]}
+	local link_name=$1
+	local link_id=`ip netns exec $NS1 cat /sys/class/net/${link_name}/ifindex`
+	local dest=$2
+
+	ip -n $NS1 link set $link_name down
+	# hack: mark indicates the link to redirect to
+	ip netns exec $NS1 ping -m $link_id $dest -c 1 -w 1 >/dev/null 2>&1
+
+	test_pass $test_name $dest to $link_name
+	ip -n $NS1 link set $link_name up
+}
+
+test_redirect_no_panic_on_link_carrier_down() {
+	local test_name=${FUNCNAME[0]}
+	local link_id=`ip netns exec $NS1 cat /sys/class/net/link_upper/ifindex`
+	local dest=$1
+
+	ip -n $NS1 link set link_w_mac down
+	# hack: mark indicates the link to redirect to
+	ip netns exec $NS1 ping -m $link_id $dest -c 1 -w 1 >/dev/null 2>&1
+
+	test_pass $test_name $dest to link_upper
+	ip -n $NS1 link set link_w_mac up
+}
+
+setup
+
+echo "Testing lwt redirect to devices requiring MAC header"
+for dest in $INGRESS_REDIR_IP $EGRESS_REDIR_IP; do
+	test_redirect_normal link_w_mac $dest
+	test_redirect_no_panic_on_link_down link_w_mac $dest
+	test_redirect_no_panic_on_link_carrier_down $dest
+done
+
+echo "Testing lwt redirect to devices not requiring MAC header"
+for dest in $INGRESS_REDIR_IP_NOMAC $EGRESS_REDIR_IP_NOMAC; do
+	test_redirect_normal link_wo_mac $dest
+	test_redirect_no_panic_on_link_down link_wo_mac $dest
+done
+
+cleanup_and_summary
-- 
2.30.2

