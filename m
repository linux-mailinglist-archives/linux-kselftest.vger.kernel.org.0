Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74ACA76956F
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 14:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjGaMCt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 08:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjGaMCs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 08:02:48 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC0E10F7;
        Mon, 31 Jul 2023 05:02:37 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id CEC1B5C0127;
        Mon, 31 Jul 2023 08:02:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 31 Jul 2023 08:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690804954; x=1690891354; bh=j40iFgR8znkwD
        nes11QIZUBFrePDVRliFxxrmg4h4mQ=; b=x/2rJZ+9fqPXutkZg6s5yXHxqggkT
        ccWLIHfgug9r24dtWg4YcPYK6KdJckBpYzhTj6NfNLh0DXxNjHubmgMhonms4I9U
        hjCskC78PYtq7sf05r+FDuH0HitxO6VQSrUcUs66a5ft+36yeAsqlO/uaKt3tIjF
        fm6brproJVuFahJ1tb4HLH1kz9jy0pakAIlEX/IvBiqBfkkBAktGaYfA5OXuUk2h
        i0mvXAfI5lppFoOoELAsoAiGEkrSGEHN5M3wOkyK8wkLcpfV4W6BrFUuhffJ1Qb0
        b2711HoRzGfQ4k1ERuf82iY8SKbTYygEIHDNSYPFlVU7pAnJX7uTfHUxg==
X-ME-Sender: <xms:2qLHZCfslkKfPgsvtGZbLjwt9FI_N5VwRAAHw3r-La91hkK6KmEkJQ>
    <xme:2qLHZMOyV8DjRYu9AUCCETweaLL7ho6bCBk_5vMQ9PzdW6-vkko3kXsS_LtJ6abH6
    5R6BvTrromHPXI>
X-ME-Received: <xmr:2qLHZDinFo19eErkDDqrdHk__yvSh8ZMlQxpel2wsSznWV2kNswqe4-MR6Qg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeeggddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:2qLHZP_uZGmEQd-Klz8tTaiz4woEZWowhcOdEsd7dr7hqvlVxxmRUA>
    <xmx:2qLHZOugCkDRGTd18nnPcouWV7LE9xc1YfL4Byk-y-vqS-_GoUEMRw>
    <xmx:2qLHZGFCpHRpyPgLvCdfKqqSzri3STBeK9BT3xN-Z23HLe7Gtmp4ng>
    <xmx:2qLHZILNH5VqWMODTHZOSUmvfiQGizOcuUJZjIuMxZkGb9Wjfmq9Kw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Jul 2023 08:02:33 -0400 (EDT)
Date:   Mon, 31 Jul 2023 15:02:25 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     petrm@nvidia.com, razor@blackwall.org,
        Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v1 01/11] selftests: forwarding:
 custom_multipath_hash.sh: add cleanup for SIGTERM sent by timeout
Message-ID: <ZMei0VMIH/l1GzVM@shredder>
References: <0550924e-dce9-f90d-df8a-db810fd2499f@alu.unizg.hr>
 <adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr>
 <ZL6OljQubhVtQjcD@shredder>
 <cab8ea8a-98f4-ef9b-4215-e2a93cccaab1@alu.unizg.hr>
 <ZMEQGIOQXv6so30x@shredder>
 <a9b6d9f5-14ae-a931-ab7b-d31b5e40f5df@alu.unizg.hr>
 <ZMYXABUN9OzfN5D3@shredder>
 <da3f4f4e-47a7-25be-fa61-aebeba1d8d0c@alu.unizg.hr>
 <ZMdouQRypZCGZhV0@shredder>
 <2f203995-5ae0-13bc-d1a6-997c2b36a2b8@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f203995-5ae0-13bc-d1a6-997c2b36a2b8@alu.unizg.hr>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 31, 2023 at 11:24:27AM +0200, Mirsad Todorovac wrote:
> I guess that means only three are left.
> 
> # ./bridge_mdb.sh
> dev br0 port veth1 grp 239.1.1.1 src 192.0.2.1 temp filter_mode include proto static vid 10  259.99
> TEST: IPv4 (S, G) port group entries configuration tests            [FAIL]
> 	Entry has an unpending group timer after replace
> dev br0 port veth1 grp ff0e::1 src 2001:db8:1::1 temp filter_mode include proto static vid 10  259.99
> TEST: IPv6 (S, G) port group entries configuration tests            [FAIL]
> 	Entry has an unpending group timer after replace

I suspect that what happens here is that you have a faster system
than me or a different HZ value (check CONFIG_HZ, mine is 1000). The
group membership time is probably 260.00 which is why grepping for
"0.00" works when it shouldn't. Can you try the patch below? No need to
run all the other tests.

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index 8493c3dfc01e..41c33a2de0a6 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -617,7 +617,7 @@ __cfg_test_port_ip_sg()
                grep -q "permanent"
        check_err $? "Entry not added as \"permanent\" when should"
        bridge -d -s mdb show dev br0 vid 10 | grep "$grp_key" | \
-               grep -q "0.00"
+               grep -q " 0.00"
        check_err $? "\"permanent\" entry has a pending group timer"
        bridge mdb del dev br0 port $swp1 $grp_key vid 10
 
@@ -626,7 +626,7 @@ __cfg_test_port_ip_sg()
                grep -q "temp"
        check_err $? "Entry not added as \"temp\" when should"
        bridge -d -s mdb show dev br0 vid 10 | grep "$grp_key" | \
-               grep -q "0.00"
+               grep -q " 0.00"
        check_fail $? "\"temp\" entry has an unpending group timer"
        bridge mdb del dev br0 port $swp1 $grp_key vid 10
 
@@ -659,7 +659,7 @@ __cfg_test_port_ip_sg()
                grep -q "permanent"
        check_err $? "Entry not marked as \"permanent\" after replace"
        bridge -d -s mdb show dev br0 vid 10 | grep "$grp_key" | \
-               grep -q "0.00"
+               grep -q " 0.00"
        check_err $? "Entry has a pending group timer after replace"
 
        bridge mdb replace dev br0 port $swp1 $grp_key vid 10 temp
@@ -667,7 +667,7 @@ __cfg_test_port_ip_sg()
                grep -q "temp"
        check_err $? "Entry not marked as \"temp\" after replace"
        bridge -d -s mdb show dev br0 vid 10 | grep "$grp_key" | \
-               grep -q "0.00"
+               grep -q " 0.00"
        check_fail $? "Entry has an unpending group timer after replace"
        bridge mdb del dev br0 port $swp1 $grp_key vid 10

> # ./bridge_vlan_mcast.sh
> TEST: Vlan mcast_startup_query_interval global option default value   [FAIL]
> 	Wrong default mcast_startup_query_interval global vlan option value
> # ./mirror_gre_changes.sh
> TEST: mirror to gretap: TTL change (skip_hw)                        [FAIL]
> 	Expected to capture 10 packets, got 15.
> TEST: mirror to ip6gretap: TTL change (skip_hw)                     [FAIL]
> 	Expected to capture 10 packets, got 13.
> WARN: Could not test offloaded functionality

I hope Nik and Petr will find the time to look into those. If not, I
will check when I can.

> 
> NOTE: The error happened because two patches collided. This patch
> 
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 975fc5168c6334..40a8c1541b7f81 100755
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -30,6 +30,7 @@ REQUIRE_MZ=${REQUIRE_MZ:=yes}
>  REQUIRE_MTOOLS=${REQUIRE_MTOOLS:=no}
>  STABLE_MAC_ADDRS=${STABLE_MAC_ADDRS:=no}
>  TCPDUMP_EXTRA_FLAGS=${TCPDUMP_EXTRA_FLAGS:=}
> +TROUTE6=${TROUTE6:=traceroute6}
>  relative_path="${BASH_SOURCE%/*}"
>  if [[ "$relative_path" == "${BASH_SOURCE}" ]]; then
> 
> and this patch
> 
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 71f7c0c49677..5b0183013017 100755
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -16,8 +16,6 @@ TEAMD=${TEAMD:=teamd}
>  WAIT_TIME=${WAIT_TIME:=5}
>  PAUSE_ON_FAIL=${PAUSE_ON_FAIL:=no}
>  PAUSE_ON_CLEANUP=${PAUSE_ON_CLEANUP:=no}
> -NETIF_TYPE=${NETIF_TYPE:=veth}
> -NETIF_CREATE=${NETIF_CREATE:=yes}
>  MCD=${MCD:=smcrouted}
>  MC_CLI=${MC_CLI:=smcroutectl}
>  PING_COUNT=${PING_COUNT:=10}
> @@ -30,6 +28,20 @@ REQUIRE_MZ=${REQUIRE_MZ:=yes}
>  REQUIRE_MTOOLS=${REQUIRE_MTOOLS:=no}
>  STABLE_MAC_ADDRS=${STABLE_MAC_ADDRS:=no}
>  TCPDUMP_EXTRA_FLAGS=${TCPDUMP_EXTRA_FLAGS:=}
> +NETIF_TYPE=${NETIF_TYPE:=veth}
> +NETIF_CREATE=${NETIF_CREATE:=yes}
> +declare -A NETIFS=(
> +       [p1]=veth0
> +       [p2]=veth1
> +       [p3]=veth2
> +       [p4]=veth3
> +       [p5]=veth4
> +       [p6]=veth5
> +       [p7]=veth6
> +       [p8]=veth7
> +       [p9]=veth8
> +       [p10]=veth9
> +)
> 
>  relative_path="${BASH_SOURCE%/*}"
>  if [[ "$relative_path" == "${BASH_SOURCE}" ]]; then
> 
> are not compatible.
> 
> I have applied the 'require_command $TROUTE6' patch manually.
> 
> I suppose this is what you intended to have:
> 
> # Can be overridden by the configuration file.
> PING=${PING:=ping}
> PING6=${PING6:=ping6}
> MZ=${MZ:=mausezahn}
> ARPING=${ARPING:=arping}
> TEAMD=${TEAMD:=teamd}
> WAIT_TIME=${WAIT_TIME:=5}
> PAUSE_ON_FAIL=${PAUSE_ON_FAIL:=no}
> PAUSE_ON_CLEANUP=${PAUSE_ON_CLEANUP:=no}
> MCD=${MCD:=smcrouted}
> MC_CLI=${MC_CLI:=smcroutectl}
> PING_COUNT=${PING_COUNT:=10}
> PING_TIMEOUT=${PING_TIMEOUT:=5}
> WAIT_TIMEOUT=${WAIT_TIMEOUT:=20}
> INTERFACE_TIMEOUT=${INTERFACE_TIMEOUT:=600}
> LOW_AGEING_TIME=${LOW_AGEING_TIME:=1000}
> REQUIRE_JQ=${REQUIRE_JQ:=yes}
> REQUIRE_MZ=${REQUIRE_MZ:=yes}
> REQUIRE_MTOOLS=${REQUIRE_MTOOLS:=no}
> STABLE_MAC_ADDRS=${STABLE_MAC_ADDRS:=no}
> TCPDUMP_EXTRA_FLAGS=${TCPDUMP_EXTRA_FLAGS:=}
> TROUTE6=${TROUTE6:=traceroute6}
> NETIF_TYPE=${NETIF_TYPE:=veth}
> NETIF_CREATE=${NETIF_CREATE:=yes}
> declare -A NETIFS=(
>        [p1]=veth0
>        [p2]=veth1
>        [p3]=veth2
>        [p4]=veth3
>        [p5]=veth4
>        [p6]=veth5
>        [p7]=veth6
>        [p8]=veth7
>        [p9]=veth8
>        [p10]=veth9
> )
> 
> relative_path="${BASH_SOURCE%/*}"
> if [[ "$relative_path" == "${BASH_SOURCE}" ]]; then
>         relative_path="."
> fi
> ------------------------------------------------
> 
> Probably for the production patch you would like to have this fixed.

No, I don't intend to submit the patch that automatically creates the
veth pairs. It is superseded by "selftests: forwarding: Skip test when
no interfaces are specified".
