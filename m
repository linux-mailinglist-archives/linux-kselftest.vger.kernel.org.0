Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015C2768440
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jul 2023 09:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjG3Hxw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Jul 2023 03:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjG3Hxv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Jul 2023 03:53:51 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A193D1710;
        Sun, 30 Jul 2023 00:53:46 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 7F0CD32007E8;
        Sun, 30 Jul 2023 03:53:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 30 Jul 2023 03:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690703622; x=1690790022; bh=Ox8XX+DFWsQ+y
        SWz/zYHcBXH3EUzbdJw0d8uXXlexl4=; b=oZ8GHy3nDWRG4gZOf4HimFHIjBhBp
        Es57m/Kr3uq7Sr0dCq9FvyOh+jbRmaI32RhSOQyJGToHhKcFPu6na136YiLHotaz
        y3ZOEcydv4tBK47Bm9IY22Ncup9G6qvwxCkXISwTz+aOI3AKu7iNG+5/u3wBSfke
        +l8V5ffAvr7fH36c0W/RBWHoDX6dexp6bJ6YrqNQnBSdC8LHJ5J/zbmAMKiq2r8Z
        deZGxtHsrtnAM+VqBsj59bOa5YslD9kfsdKoHB8IOteu7MjSmRjudsflcvi45tjm
        +OIM6yRGq416GmzOY87L4/AfYes4eGnkHHe09eYQRYU442TyFlwFq1LUg==
X-ME-Sender: <xms:BRfGZC_fnYWCtgM9pPaSyZ8E4-pvfmBPnv56Rzie0maO8HCmHggqhg>
    <xme:BRfGZCtdBoSLgJ2fIsUr8SVDz4_bAPJFd0DACwjS3ocDei-RgIkD1Hh_6k-ep0pH_
    iXPExtG6YQK3EY>
X-ME-Received: <xmr:BRfGZIClbhMoHQZ0Ut2PrNNkSRibnx3Yf5dwmz3M72eRz1AcdMQSfIa4wK7S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjedtgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpeejgeevleffteffhfdtveegteekheeggefhvddvveeufedtgfeggedvueejhfel
    leenucffohhmrghinhepuhhnihiighdrhhhrnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:BRfGZKfjsIUj47AYhL6Z-dUgtKjNxWNmhttuEPJtJiY90ia7JMlz-Q>
    <xmx:BRfGZHO8EMV8ulwpH-t3ptVL-4Gyrz5exfy_J2xTqMiGGh-E2-747w>
    <xmx:BRfGZEkrWuaaMB5PkY0A-qb_1zncCeXBcQaofKn8yVGje0TNQhRqDg>
    <xmx:BhfGZCo8cjiZL94kqunOQNLSO4bBaepxyD65qB5nokg-W5Za8hMjbA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Jul 2023 03:53:40 -0400 (EDT)
Date:   Sun, 30 Jul 2023 10:53:36 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>, petrm@nvidia.com,
        razor@blackwall.org
Cc:     Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v1 01/11] selftests: forwarding:
 custom_multipath_hash.sh: add cleanup for SIGTERM sent by timeout
Message-ID: <ZMYXABUN9OzfN5D3@shredder>
References: <20230722003609.380549-1-mirsad.todorovac@alu.unizg.hr>
 <ZLzj5oYrbHGvCMkq@shredder>
 <0550924e-dce9-f90d-df8a-db810fd2499f@alu.unizg.hr>
 <adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr>
 <ZL6OljQubhVtQjcD@shredder>
 <cab8ea8a-98f4-ef9b-4215-e2a93cccaab1@alu.unizg.hr>
 <ZMEQGIOQXv6so30x@shredder>
 <a9b6d9f5-14ae-a931-ab7b-d31b5e40f5df@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9b6d9f5-14ae-a931-ab7b-d31b5e40f5df@alu.unizg.hr>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 27, 2023 at 09:26:03PM +0200, Mirsad Todorovac wrote:
> marvin@defiant:~/linux/kernel/linux_torvalds$ grep "not ok" ../kselftest-6.5-rc3-net-forwarding-16.log
> not ok 3 selftests: net/forwarding: bridge_mdb.sh # exit=1

Other than one test case (see below), I believe this should be fixed by
the patches I just pushed to the existing branch. My earlier fix was
incomplete which is why it didn't solve the problem.

> not ok 5 selftests: net/forwarding: bridge_mdb_max.sh # exit=1

Should be fixed with the patches.

> not ok 11 selftests: net/forwarding: bridge_vlan_mcast.sh # exit=1

Nik, the relevant failure is this one:

# TEST: Vlan mcast_startup_query_interval global option default value   [FAIL]
# 	Wrong default mcast_startup_query_interval global vlan option value

Any idea why the kernel will report "mcast_startup_query_interval" as
3124 instead of 3125?

# + jq -e '.[].vlans[] | select(.vlan == 10 and                                             .mcast_startup_query_interval == 3125) '
# + echo -n '[{"ifname":"br0","vlans":[{"vlan":1,"mcast_snooping":1,"mcast_querier":0,"mcast_igmp_version":2,"mcast_mld_version":1,"mcast_last_member_count":2,"mcast_last_member_interval":100,"mcast_startup_query_count":2,"mcast_startup_query_interval":3124,"mcast_membership_interval":26000,"mcast_querier_interval":25500,"mcast_query_interval":12500,"mcast_query_response_interval":1000},{"vlan":10,"vlanEnd":11,"mcast_snooping":1,"mcast_querier":0,"mcast_igmp_version":2,"mcast_mld_version":1,"mcast_last_member_count":2,"mcast_last_member_interval":100,"mcast_startup_query_count":2,"mcast_startup_query_interval":3124,"mcast_membership_interval":26000,"mcast_querier_interval":25500,"mcast_query_interval":12500,"mcast_query_response_interval":1000}]}]'
# + check_err 4 'Wrong default mcast_startup_query_interval global vlan option value'

> not ok 26 selftests: net/forwarding: ip6_forward_instats_vrf.sh # exit=1

Please run this one with +x so that we will get more info.

> not ok 49 selftests: net/forwarding: mirror_gre_changes.sh # exit=1

Petr, please take a look. Probably need to make the filters more
specific. The failure is:

# TEST: mirror to gretap: TTL change (skip_hw)                        [FAIL]
# 	Expected to capture 10 packets, got 14.

> not ok 84 selftests: net/forwarding: tc_flower_l2_miss.sh # exit=1

Should be fixed with the patches.

> marvin@defiant:~/linux/kernel/linux_torvalds$ grep -v "^# +" ../kselftest-6.5-rc3-net-forwarding-16.log | grep -A1 FAIL | grep -v -e -- | grep -v OK
> # TEST: IPv6 (S, G) port group entries configuration tests            [FAIL]
> # 	"temp" entry has an unpending group timer

Not sure about this one. What is the output with the following diff?

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index 8493c3dfc01e..2b2a3b150861 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -628,6 +628,7 @@ __cfg_test_port_ip_sg()
        bridge -d -s mdb show dev br0 vid 10 | grep "$grp_key" | \
                grep -q "0.00"
        check_fail $? "\"temp\" entry has an unpending group timer"
+       bridge -d -s mdb show dev br0 vid 10 | grep "$grp_key"
        bridge mdb del dev br0 port $swp1 $grp_key vid 10
 
        # Check error cases.

> # TEST: IPv4 host entries forwarding tests                            [FAIL]
> # 	Packet not locally received after adding a host entry
> # TEST: IPv4 port group "exclude" entries forwarding tests            [FAIL]
> # 	Packet from valid source not received on H2 after adding entry
> # TEST: IPv4 port group "include" entries forwarding tests            [FAIL]
> # 	Packet from valid source not received on H2 after adding entry
> # TEST: IGMPv3 MODE_IS_INCLUDE tests                                  [FAIL]
> # 	Source not add to source list
> # TEST: ctl4: port: ngroups reporting                                 [FAIL]
> # 	Couldn't add MDB entries
> # TEST: ctl4: port maxgroups: reporting and treatment of 0            [FAIL]
> # 	Adding 5 MDB entries failed but should have passed
> # TEST: ctl4: port maxgroups: configure below ngroups                 [FAIL]
> # 	dev veth1: Couldn't add MDB entries
> # TEST: ctl4: port: ngroups reporting                                 [FAIL]
> # 	Couldn't add MDB entries
> # TEST: ctl4: port maxgroups: reporting and treatment of 0            [FAIL]
> # 	Adding 5 MDB entries failed but should have passed
> # TEST: ctl4: port maxgroups: configure below ngroups                 [FAIL]
> # 	dev veth1 vid 10: Couldn't add MDB entries
> # TEST: ctl4: port_vlan: ngroups reporting                            [FAIL]
> # 	Couldn't add MDB entries
> # TEST: ctl4: port_vlan: isolation of port and per-VLAN ngroups       [FAIL]
> # 	Couldn't add MDB entries to VLAN 10
> # TEST: ctl4: port_vlan maxgroups: reporting and treatment of 0       [FAIL]
> # 	Adding 5 MDB entries failed but should have passed
> # TEST: ctl4: port_vlan maxgroups: configure below ngroups            [FAIL]
> # 	dev veth1 vid 10: Couldn't add MDB entries
> # TEST: ctl4: port_vlan maxgroups: isolation of port and per-VLAN ngroups   [FAIL]
> # 	Couldn't add 5 entries
> # TEST: Vlan mcast_startup_query_interval global option default value   [FAIL]
> # 	Wrong default mcast_startup_query_interval global vlan option value
> # TEST: Ip6InHdrErrors                                                [FAIL]
> # TEST: mirror to gretap: TTL change (skip_hw)                        [FAIL]
> # 	Expected to capture 10 packets, got 14.
> # TEST: L2 miss - Multicast (IPv4)                                    [FAIL]
> # 	Unregistered multicast filter was not hit before adding MDB entry
> marvin@defiant:~/linux/kernel/linux_torvalds$
> 
> In case you want to pursue these failures, there is the complete test output log
> here:
> 
> https://domac.alu.unizg.hr/~mtodorov/linux/selftests/net-forwarding/kselftest-6.5-rc3-net-forwarding-16.log.xz
> 
> Thanks again, great work!
> 
> Kind regards,
> Mirsad
