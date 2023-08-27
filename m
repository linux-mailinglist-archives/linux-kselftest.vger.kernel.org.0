Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FCB78A078
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Aug 2023 19:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjH0RSe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Aug 2023 13:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjH0RSP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Aug 2023 13:18:15 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D50B4;
        Sun, 27 Aug 2023 10:18:10 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 81889320076F;
        Sun, 27 Aug 2023 13:18:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 27 Aug 2023 13:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1693156686; x=1693243086; bh=tJv/AQ1qUk8XI
        cGYa2IeHHGFgUMAkpcwasA2plQ3J6o=; b=ddPDOv+oiW0tbtzXYD1iulTZwLfSI
        1x6IRY1hGy768h3Fo28AI8OsC9ALnMnI6qNKlC0nsVwoeZQTTopLOJdlSHFaA2Vg
        Kh72elHfPhpY9J6ZnOmA1lYyi7rou7HEMMohZmOMM/RTWSkllF98oRe567au12b1
        woZUg/WqIy9GVmveDAB9mBNFpeDkULd3vSs9K3PRTA1S7+viI413gOVl/MBVqhIJ
        +q9ILxRupGQaKTl29cM7JRH7UjtkFVdO+bcwUoNUHyxy7ix2PWDi0Yp5UdKeLMZK
        WqoGIOsOcOWAooTQJyt2RkfyhDXVs+hzt2AIfxck9CBcsJg/Yk+Ujk2sg==
X-ME-Sender: <xms:TYXrZG5X03-Hd8fSZg17WdqMaeAdA4YwAbkUxVaOg2mGJX-lyKGebA>
    <xme:TYXrZP4p55J4Vxu6ccfzGNzDKT3UP6vhRfmKs1az_l839mBOLY0cakS3s70PY4PpC
    cKhZnxkKpD4PEY>
X-ME-Received: <xmr:TYXrZFdtry21eUJzXoUUXGLfwgMU-OGD0qRKU_UWecr3pcGgPN4p43hMV3S3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefvddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkugho
    ucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrg
    htthgvrhhnpedtffelvddvudelieeutddvlefhteejieeivdefhffhudejgedvgfdtueeg
    vedtkeenucffohhmrghinheprhhouhhtvghrmhhulhhtihhprghthhhvihhprdhshhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgt
    hhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:TYXrZDIkBZNfe1Og02xD1IXmOS9t6HV4Xj16ETSl-uBrAaPhMqKY8w>
    <xmx:TYXrZKIZES5qW0zYLJbLuh5l9e71QyjspfKLkQLqESBx4IQkego1-w>
    <xmx:TYXrZEwSjpgBYXWeE1v8gBohuCQl0AZMChQYvWcpLc1kZCQd-alJ1A>
    <xmx:ToXrZJ9ZgFuKINHtq0cMneIZIxeNRo4mg0XqTVla15ETe3oWeenqpg>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Aug 2023 13:18:05 -0400 (EDT)
Date:   Sun, 27 Aug 2023 20:18:01 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>,
        Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net v2 3/3] selftests: forwarding: Add test for
 load-balancing between multiple servers
Message-ID: <ZOuFSbnxgaST4qKD@shredder>
References: <20230825090830.18635-1-sriram.yagnaraman@est.tech>
 <20230825090830.18635-4-sriram.yagnaraman@est.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825090830.18635-4-sriram.yagnaraman@est.tech>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 25, 2023 at 11:08:30AM +0200, Sriram Yagnaraman wrote:
> Create a topology with a host, and a router. The host (veth0) is in the
> default namespace, and a network namespace is created for the router,
> the peer veth1 is moved to the router netns. A dummy interface is added
> inside the router netns, to simulate a network that has two neighbors.
> An ECMP route to a virtual IP (vip) with the two neighbors as the next
> hop is added.
> 
> The test uses perf stat to count the number of fib:fib_table_lookup
> tracepoint hits for IPv4 and the number of fib6:fib6_table_lookup for
> IPv6. The measured count is checked to be within 15% for the number of
> packets received on veth1 in the router.
> 
> See diagram in the test for more information.
> 
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> ---
>  .../testing/selftests/net/forwarding/Makefile |   1 +
>  tools/testing/selftests/net/forwarding/lib.sh |   5 +
>  .../net/forwarding/router_multipath_vip.sh    | 255 ++++++++++++++++++

I believe this test better fits in fib_tests.sh. Here's a diff that uses
the previously mentioned method [1]. I verified that it fails without
the fixes and passes with them:

Before:

IPv4 multipath list receive tests
    TEST: Multipath route hit ratio (.15)                               [FAIL]
    TEST: Single path route hit ratio (.15)                             [ OK ]

IPv6 multipath list receive tests
    TEST: Multipath route hit ratio (.15)                               [FAIL]
    TEST: Single path route hit ratio (.14)                             [ OK ]

After:

IPv4 multipath list receive tests
    TEST: Multipath route hit ratio (.99)                               [ OK ]
    TEST: Single path route hit ratio (.15)                             [ OK ]

IPv6 multipath list receive tests
    TEST: Multipath route hit ratio (.99)                               [ OK ]
    TEST: Single path route hit ratio (.14)                             [ OK ]

[1]
diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 35d89dfa6f11..5ffbfdad943c 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -9,7 +9,7 @@ ret=0
 ksft_skip=4
 
 # all tests in this script. Can be overridden with -t option
-TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh"
+TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh ipv4_mpath_list ipv6_mpath_list"
 
 VERBOSE=0
 PAUSE_ON_FAIL=no
@@ -2138,6 +2138,143 @@ ipv4_bcast_neigh_test()
 	cleanup
 }
 
+mpath_dep_check()
+{
+	if [ ! -x "$(command -v mausezahn)" ]; then
+		echo "mausezahn command not found. Skipping test"
+		return 1
+	fi
+
+	if [ ! -x "$(command -v jq)" ]; then
+		echo "jq command not found. Skipping test"
+		return 1
+	fi
+
+	if [ ! -x "$(command -v bc)" ]; then
+		echo "bc command not found. Skipping test"
+		return 1
+	fi
+
+	if [ ! -x "$(command -v perf)" ]; then
+		echo "perf command not found. Skipping test"
+		return 1
+	fi
+
+	perf list fib:* | grep -q fib_table_lookup
+	if [ $? -ne 0 ]; then
+		echo "IPv4 FIB tracepoint not found. Skipping test"
+		return 1
+	fi
+
+	perf list fib6:* | grep -q fib6_table_lookup
+	if [ $? -ne 0 ]; then
+		echo "IPv6 FIB tracepoint not found. Skipping test"
+		return 1
+	fi
+
+	return 0
+}
+
+list_rcv_eval()
+{
+	local name=$1; shift
+	local file=$1; shift
+	local exp=$1; shift
+
+
+	local count=$(tail -n 1 $file | jq '.["counter-value"] | tonumber | floor')
+	local ratio=$(echo "scale=2; $count / 65536" | bc -l)
+	local res=$(echo "$ratio $exp" | bc)
+	[[ $res -eq 1 ]]
+	log_test $? 0 "$name route hit ratio ($ratio)"
+}
+
+ipv4_mpath_list_test()
+{
+	echo
+	echo "IPv4 multipath list receive tests"
+
+	mpath_dep_check || return 1
+
+	route_setup
+
+	set -e
+	run_cmd "ip netns exec ns1 ethtool -K veth1 tcp-segmentation-offload off"
+
+	run_cmd "ip netns exec ns2 bash -c \"echo 20000 > /sys/class/net/veth2/gro_flush_timeout\""
+	run_cmd "ip netns exec ns2 bash -c \"echo 1 > /sys/class/net/veth2/napi_defer_hard_irqs\""
+	run_cmd "ip netns exec ns2 ethtool -K veth2 generic-receive-offload on"
+	run_cmd "ip -n ns2 link add name nh1 up type dummy"
+	run_cmd "ip -n ns2 link add name nh2 up type dummy"
+	run_cmd "ip -n ns2 address add 172.16.201.1/24 dev nh1"
+	run_cmd "ip -n ns2 address add 172.16.202.1/24 dev nh2"
+	run_cmd "ip -n ns2 neigh add 172.16.201.2 lladdr 00:11:22:33:44:55 nud perm dev nh1"
+	run_cmd "ip -n ns2 neigh add 172.16.202.2 lladdr 00:aa:bb:cc:dd:ee nud perm dev nh2"
+	run_cmd "ip -n ns2 route add 203.0.113.0/24 nexthop via 172.16.201.2 nexthop via 172.16.202.2"
+	run_cmd "ip netns exec ns2 sysctl -qw net.ipv4.fib_multipath_hash_policy=1"
+	set +e
+
+	local dmac=$(ip -n ns2 -j link show dev veth2 | jq -r '.[]["address"]')
+	local tmp_file=$(mktemp)
+
+	# Packets forwarded in a list using a multipath route must not reuse a
+	# cached result so that a flow always hits the same nexthop. In other
+	# words, the FIB lookup tracepoint needs to be triggered for every
+	# packet.
+	run_cmd "perf stat -e fib:fib_table_lookup --filter 'err == 0' -j -o $tmp_file -- ip netns exec ns1 mausezahn veth1 -a own -b $dmac -A 172.16.101.1 -B 203.0.113.1 -t udp 'sp=12345,dp=0-65535' -q"
+	list_rcv_eval "Multipath" $tmp_file ">= 0.95"
+
+	# The same is not true for a single path route.
+	run_cmd "ip -n ns2 route replace 203.0.113.0/24 nexthop via 172.16.201.2"
+	run_cmd "perf stat -e fib:fib_table_lookup --filter 'err == 0' -j -o $tmp_file -- ip netns exec ns1 mausezahn veth1 -a own -b $dmac -A 172.16.101.1 -B 203.0.113.1 -t udp 'sp=12345,dp=0-65535' -q"
+	list_rcv_eval "Single path" $tmp_file "< 0.95"
+
+	rm $tmp_file
+	route_cleanup
+}
+
+ipv6_mpath_list_test()
+{
+	echo
+	echo "IPv6 multipath list receive tests"
+
+	mpath_dep_check || return 1
+
+	route_setup
+
+	set -e
+	run_cmd "ip netns exec ns1 ethtool -K veth1 tcp-segmentation-offload off"
+
+	run_cmd "ip netns exec ns2 bash -c \"echo 20000 > /sys/class/net/veth2/gro_flush_timeout\""
+	run_cmd "ip netns exec ns2 bash -c \"echo 1 > /sys/class/net/veth2/napi_defer_hard_irqs\""
+	run_cmd "ip netns exec ns2 ethtool -K veth2 generic-receive-offload on"
+	run_cmd "ip -n ns2 link add name nh1 up type dummy"
+	run_cmd "ip -n ns2 link add name nh2 up type dummy"
+	run_cmd "ip -n ns2 -6 address add 2001:db8:201::1/64 dev nh1"
+	run_cmd "ip -n ns2 -6 address add 2001:db8:202::1/64 dev nh2"
+	run_cmd "ip -n ns2 -6 neigh add 2001:db8:201::2 lladdr 00:11:22:33:44:55 nud perm dev nh1"
+	run_cmd "ip -n ns2 -6 neigh add 2001:db8:202::2 lladdr 00:aa:bb:cc:dd:ee nud perm dev nh2"
+	run_cmd "ip -n ns2 -6 route add 2001:db8:301::/64 nexthop via 2001:db8:201::2 nexthop via 2001:db8:202::2"
+	run_cmd "ip netns exec ns2 sysctl -qw net.ipv6.fib_multipath_hash_policy=1"
+	set +e
+
+	local dmac=$(ip -n ns2 -j link show dev veth2 | jq -r '.[]["address"]')
+	local tmp_file=$(mktemp)
+
+	# Packets forwarded in a list using a multipath route must not reuse a
+	# cached result so that a flow always hits the same nexthop. In other
+	# words, the FIB lookup tracepoint needs to be triggered for every
+	# packet.
+	run_cmd "perf stat -e fib6:fib6_table_lookup --filter 'err == 0' -j -o $tmp_file -- ip netns exec ns1 mausezahn -6 veth1 -a own -b $dmac -A 2001:db8:101::1 -B 2001:db8:301::1 -t udp 'sp=12345,dp=0-65535' -q"
+	list_rcv_eval "Multipath" $tmp_file ">= 0.95"
+
+	# The same is not true for a single path route.
+	run_cmd "ip -n ns2 route replace 2001:db8:301::/64 nexthop via 2001:db8:201::2"
+	run_cmd "perf stat -e fib6:fib6_table_lookup --filter 'err == 0' -j -o $tmp_file -- ip netns exec ns1 mausezahn -6 veth1 -a own -b $dmac -A 2001:db8:101::1 -B 2001:db8:301::1 -t udp 'sp=12345,dp=0-65535' -q"
+	list_rcv_eval "Single path" $tmp_file "< 0.95"
+
+	rm $tmp_file
+	route_cleanup
+}
+
 ################################################################################
 # usage
 
@@ -2217,6 +2354,8 @@ do
 	ipv4_mangle)			ipv4_mangle_test;;
 	ipv6_mangle)			ipv6_mangle_test;;
 	ipv4_bcast_neigh)		ipv4_bcast_neigh_test;;
+	ipv4_mpath_list)		ipv4_mpath_list_test;;
+	ipv6_mpath_list)		ipv6_mpath_list_test;;
 
 	help) echo "Test names: $TESTS"; exit 0;;
 	esac
-- 
2.40.1
