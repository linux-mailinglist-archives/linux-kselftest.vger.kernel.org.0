Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9237178DBBA
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 20:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238267AbjH3Sha (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 14:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245654AbjH3Ps6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 11:48:58 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8332B19A;
        Wed, 30 Aug 2023 08:48:55 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 7294A5C0125;
        Wed, 30 Aug 2023 11:48:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 30 Aug 2023 11:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1693410532; x=1693496932; bh=OBnVGQWEM3kMS
        4B7KKbSwDUGaRUbADHZE4qYXlfiygM=; b=PvLNe5kKHYWU/kPp5/cS8VLuYCn9I
        4lNckk7tMtgEHmv4VNrGWwF88UPNyjelrIt7RkQqqlHto6gN4L8mntb0sbyqBSia
        86Gxu5hZr2/RTRD6MpIRfKuS2vc5Ib803/E+YRRgtv87koxrbg/1fwaDM87f5LwZ
        fowfKR72EM4xuLyc7Asu7O+tYYurB3QEkL6epRmM73azPWKMMRcNuzzT61Aj+JDq
        Br8aqCnp2Pvk1u9LMniYDnKecBb4IfHVIHOJkV4l+qvocqwDgFi/EpST95gUeyG0
        hUCw6NhUXB62k+XdF81EXT88acnubjpR1msWjpKWG/4AqtGRdnKNT5CGQ==
X-ME-Sender: <xms:5GTvZCaczUmjdeSEq0nl0ximLjWr1U7ozfldVZiKrqZPkz2nnpudAg>
    <xme:5GTvZFa801WI9x03l1A-ufF_yqbejNTdsiL_3h1XBVRzonkRW18yeoZop7EMD1jfe
    yN0haE1F5pSnWg>
X-ME-Received: <xmr:5GTvZM_MBPGrGMELEqs7Jdgkr7_MKzoZbntMVUU6iV1q_jBu2RQsOXHW-rDA45CY8wO5nez5mf_0o1qQwyIquIhXKBsBlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefkedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:5GTvZEqaxIQAAKiuq-FIvjQDhoLF0v9aUNUpPLz5BxSjyFAAHJKzuw>
    <xmx:5GTvZNrxz85PDRLg9sUaNoLDszxQmtGMjusVDuZzD3pCtt6FCdJTCA>
    <xmx:5GTvZCRysmOkjJ1pC5TIDwgLB72K86VK-Ju0Jx1Jznt93zQ_Sc4fSQ>
    <xmx:5GTvZBeHTOFhHHRduGki5e_tMbXpiDxjr4ZJN18IgrzifRAN7wSrUA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Aug 2023 11:48:51 -0400 (EDT)
Date:   Wed, 30 Aug 2023 18:48:46 +0300
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
Subject: Re: [PATCH net v4 3/3] selftests: fib_tests: Add multipath list
 receive tests
Message-ID: <ZO9k3kSVHpxO1owX@shredder>
References: <20230830091341.17273-1-sriram.yagnaraman@est.tech>
 <20230830091341.17273-4-sriram.yagnaraman@est.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830091341.17273-4-sriram.yagnaraman@est.tech>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 30, 2023 at 11:13:41AM +0200, Sriram Yagnaraman wrote:
> +link_stats_get()
> +{
> +	local ns=$1; shift
> +        local dev=$1; shift
> +        local dir=$1; shift
> +        local stat=$1; shift

Indentation is off...

> +
> +        ip -n $ns -j -s link show dev $dev \
> +                | jq '.[]["stats64"]["'$dir'"]["'$stat'"]'
> +}
> +
> +list_rcv_eval()
> +{
> +	local name=$1; shift
> +	local file=$1; shift
> +	local expected=$1; shift
> +	local exp=$1; shift

Nit: You can drop the first and last arguments since they don't change
between both invocations.

> +
> +

Unnecessary blank line


> +	local count=$(tail -n 1 $file | jq '.["counter-value"] | tonumber | floor')
> +	local ratio=$(echo "scale=2; $count / $expected" | bc -l)
> +	local res=$(echo "$ratio $exp" | bc)
> +	[[ $res -eq 1 ]]
> +	log_test $? 0 "$name route hit ratio ($ratio)"
> +}
> +
> +ipv4_mpath_list_test()
> +{
> +	echo
> +	echo "IPv4 multipath list receive tests"
> +
> +	mpath_dep_check || return 1
> +
> +	route_setup
> +
> +	set -e
> +	run_cmd "ip netns exec ns1 ethtool -K veth1 tcp-segmentation-offload off"
> +
> +	run_cmd "ip netns exec ns2 bash -c \"echo 20000 > /sys/class/net/veth2/gro_flush_timeout\""
> +	run_cmd "ip netns exec ns2 bash -c \"echo 1 > /sys/class/net/veth2/napi_defer_hard_irqs\""
> +	run_cmd "ip netns exec ns2 ethtool -K veth2 generic-receive-offload on"
> +	run_cmd "ip -n ns2 link add name nh1 up type dummy"
> +	run_cmd "ip -n ns2 link add name nh2 up type dummy"
> +	run_cmd "ip -n ns2 address add 172.16.201.1/24 dev nh1"
> +	run_cmd "ip -n ns2 address add 172.16.202.1/24 dev nh2"
> +	run_cmd "ip -n ns2 neigh add 172.16.201.2 lladdr 00:11:22:33:44:55 nud perm dev nh1"
> +	run_cmd "ip -n ns2 neigh add 172.16.202.2 lladdr 00:aa:bb:cc:dd:ee nud perm dev nh2"
> +	run_cmd "ip -n ns2 route add 203.0.113.0/24
> +		nexthop via 172.16.201.2 nexthop via 172.16.202.2"
> +	run_cmd "ip netns exec ns2 sysctl -qw net.ipv4.fib_multipath_hash_policy=1"
> +	set +e
> +
> +	local dmac=$(ip -n ns2 -j link show dev veth2 | jq -r '.[]["address"]')
> +	local tmp_file=$(mktemp)
> +	local cmd="ip netns exec ns1 mausezahn veth1 -a own -b $dmac
> +		-A 172.16.101.1 -B 203.0.113.1 -t udp 'sp=12345,dp=0-65535' -q"
> +
> +	# Packets forwarded in a list using a multipath route must not reuse a
> +	# cached result so that a flow always hits the same nexthop. In other
> +	# words, the FIB lookup tracepoint needs to be triggered for every
> +	# packet.
> +	local t0_rx_pkts=$(link_stats_get ns2 veth2 rx packets)
> +	run_cmd "perf stat -e fib:fib_table_lookup --filter 'err == 0' -j -o $tmp_file -- $cmd"
> +	local t1_rx_pkts=$(link_stats_get ns2 veth2 rx packets)
> +	local diff=$(echo $t1_rx_pkts - $t0_rx_pkts | bc -l)
> +	list_rcv_eval "Multipath" $tmp_file $diff ">= 0.95"
> +
> +	rm $tmp_file
> +	route_cleanup
> +}
> +
> +ipv6_mpath_list_test()
> +{
> +	echo
> +	echo "IPv6 multipath list receive tests"
> +
> +	mpath_dep_check || return 1
> +
> +	route_setup
> +
> +	set -e
> +	run_cmd "ip netns exec ns1 ethtool -K veth1 tcp-segmentation-offload off"
> +
> +	run_cmd "ip netns exec ns2 bash -c \"echo 20000 > /sys/class/net/veth2/gro_flush_timeout\""
> +	run_cmd "ip netns exec ns2 bash -c \"echo 1 > /sys/class/net/veth2/napi_defer_hard_irqs\""
> +	run_cmd "ip netns exec ns2 ethtool -K veth2 generic-receive-offload on"
> +	run_cmd "ip -n ns2 link add name nh1 up type dummy"
> +	run_cmd "ip -n ns2 link add name nh2 up type dummy"
> +	run_cmd "ip -n ns2 -6 address add 2001:db8:201::1/64 dev nh1"
> +	run_cmd "ip -n ns2 -6 address add 2001:db8:202::1/64 dev nh2"
> +	run_cmd "ip -n ns2 -6 neigh add 2001:db8:201::2 lladdr 00:11:22:33:44:55 nud perm dev nh1"
> +	run_cmd "ip -n ns2 -6 neigh add 2001:db8:202::2 lladdr 00:aa:bb:cc:dd:ee nud perm dev nh2"
> +	run_cmd "ip -n ns2 -6 route add 2001:db8:301::/64
> +		nexthop via 2001:db8:201::2 nexthop via 2001:db8:202::2"
> +	run_cmd "ip netns exec ns2 sysctl -qw net.ipv6.fib_multipath_hash_policy=1"
> +	set +e
> +
> +	local dmac=$(ip -n ns2 -j link show dev veth2 | jq -r '.[]["address"]')
> +	local tmp_file=$(mktemp)
> +	local cmd="ip netns exec ns1 mausezahn -6 veth1 -a own -b $dmac
> +		-A 2001:db8:101::1 -B 2001:db8:301::1 -t udp 'sp=12345,dp=0-65535' -q"
> +
> +	# Packets forwarded in a list using a multipath route must not reuse a
> +	# cached result so that a flow always hits the same nexthop. In other
> +	# words, the FIB lookup tracepoint needs to be triggered for every
> +	# packet.
> +	local t0_rx_pkts=$(link_stats_get ns2 veth2 rx packets)
> +	run_cmd "perf stat -e fib6:fib6_table_lookup --filter 'err == 0' -j -o $tmp_file -- $cmd"
> +	local t1_rx_pkts=$(link_stats_get ns2 veth2 rx packets)
> +	local diff=$(echo $t1_rx_pkts - $t0_rx_pkts | bc -l)
> +	list_rcv_eval "Multipath" $tmp_file $diff ">= 0.95"
> +
> +	rm $tmp_file
> +	route_cleanup
> +}
> +
>  ################################################################################
>  # usage
>  
> @@ -2433,6 +2587,8 @@ do
>  	ipv6_mangle)			ipv6_mangle_test;;
>  	ipv4_bcast_neigh)		ipv4_bcast_neigh_test;;
>  	fib6_gc_test|ipv6_gc)		fib6_gc_test;;
> +	ipv4_mpath_list)		ipv4_mpath_list_test;;
> +	ipv6_mpath_list)		ipv6_mpath_list_test;;
>  
>  	help) echo "Test names: $TESTS"; exit 0;;
>  	esac
> -- 
> 2.34.1
> 
> 
