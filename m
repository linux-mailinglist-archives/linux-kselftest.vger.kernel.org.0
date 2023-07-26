Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B777627FF
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 03:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjGZBJT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 21:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjGZBJS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 21:09:18 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E30268D
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 18:09:15 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4039f0d140eso50796321cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 18:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690333755; x=1690938555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0j4SOStVYxHKXGyoHBk90Z9/7O0dfp1WmJmpO/HijKg=;
        b=sOVJjNqJxLUNOQKu8TUIs4EQXTFg4cyJ9WibcU6EPSNjZpSapC1e9ycnqVsUNFjzyD
         9ZgMOAAmCDW3u4hbbP83OgjbUiZxD6av/PTe1NceH+6ufifpQsyofAHGSmkP0OQs9ErZ
         IWg0eW2mUmPiUpWXpw+zPfINGloxY602J4CSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690333755; x=1690938555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0j4SOStVYxHKXGyoHBk90Z9/7O0dfp1WmJmpO/HijKg=;
        b=WoO4HKdHiiRrx7XyeL6leXXUKk9oFkcpfN+3vxWLvWnHIizdDq65n4bKVd7/PIYDQO
         LZkK3Ou/+iL9Pode0BnPp6ZQjxcL2Zerjwdn1I6tG+IQL2WRnfeRFHFHlNyT0ELK1MTw
         ooHU9xy89tkljwEF48rpqpxyyazL/44Dg8Yme4XBVpLs4jmDNbBRGq/DWhJxpbmwsTGl
         9VM/Fdojnd33QH1id/6cxLE16q9WqmszeW2XVfDwekwjSThB+9pY6o7ZjR9xSzKo/rMb
         nxGQXqR1dsH5XiF8+/AsVwdHU0OCPH+mA8mUxgAkxFIqSfHsYrTh2vRMRcRlK6+i2ox1
         XUKA==
X-Gm-Message-State: ABy/qLZM8W6j++c645eELalkx414fF1DuR7GrhmNIwped9vxvricrqOW
        yXCd8L7jtWL/H4ZiXjIUa9bKUw==
X-Google-Smtp-Source: APBJJlFUth/aSY8rBZymZAD3NLSJzY7rSe0GwigSDuaV3WLpvc5NGyNX5px/T+GiWiLtdzhGQYMlXA==
X-Received: by 2002:a05:622a:1111:b0:402:2e84:f06e with SMTP id e17-20020a05622a111100b004022e84f06emr738486qty.27.1690333755005;
        Tue, 25 Jul 2023 18:09:15 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id b20-20020ac85414000000b0040541a8bd66sm4398523qtq.60.2023.07.25.18.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 18:09:14 -0700 (PDT)
Date:   Tue, 25 Jul 2023 18:09:12 -0700
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
        kernel-team@cloudflare.com, Jordan Griege <jgriege@cloudflare.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH v4 bpf 2/2] bpf: selftests: add lwt redirect regression test
 cases
Message-ID: <9c4896b109a39c3fa088844addaa1737a84bbbb5.1690332693.git.yan@cloudflare.com>
References: <cover.1690332693.git.yan@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690332693.git.yan@cloudflare.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Tests BPF redirect at the lwt xmit hook to ensure error handling are
safe, i.e. won't panic the kernel.

Tested-by: Jakub Sitnicki <jakub@cloudflare.com>
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 tools/testing/selftests/bpf/Makefile          |   1 +
 .../selftests/bpf/progs/test_lwt_redirect.c   |  66 +++++++
 .../selftests/bpf/test_lwt_redirect.sh        | 174 ++++++++++++++++++
 3 files changed, 241 insertions(+)
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
index 000000000000..3674e101f68f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_lwt_redirect.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_tracing_net.h"
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
index 000000000000..1b7b78b48174
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_lwt_redirect.sh
@@ -0,0 +1,174 @@
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
+get_ip_direction()
+{
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
+setup()
+{
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
+
+	# link_err is only used to make sure packets are redirected instead of
+	# being routed
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
+cleanup_and_summary()
+{
+	ip netns del $NS1
+	echo PASSED:$PASS FAILED:$FAIL
+	if [ $FAIL -ne 0 ]; then
+		exit 1
+	else
+		exit 0
+	fi
+}
+
+test_redirect_normal()
+{
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
+test_redirect_no_panic_on_link_down()
+{
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
+test_redirect_no_panic_on_link_carrier_down()
+{
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

