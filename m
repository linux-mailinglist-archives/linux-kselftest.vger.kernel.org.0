Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E4A763634
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 14:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjGZMXS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 08:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbjGZMXC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 08:23:02 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8F9100;
        Wed, 26 Jul 2023 05:22:57 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 9AAC55C00FE;
        Wed, 26 Jul 2023 08:22:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 26 Jul 2023 08:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690374174; x=1690460574; bh=nkzmqGGyaTyM6
        C3rwgSVjdOiXlg1wgXUYIewV7EBzv8=; b=TVbQptaJxZGVKDcrbJhPFjfg1lYcL
        pQZfPof3bfGKSSQz9kzhZQ4nLK3XeJKp8eKWl+TK2xv/9rheOS9Tqgz5SS5jOzWp
        XqHD8/dy0Q9dKcELfQVmaAN+IbL+nClZ9jF9Zk0LBCDl6LGTsoQeBdUoPoxSjA03
        RzMNKNyKm7L3g0HpRCZHMtbAFqvVhontwW/v0LaIMPTR9RjtOSSBvN+6ci1acpZ+
        kQT1HKEDLr7gHk8ancWtoBC9rEgFE9IE4Y3gb5r4WNjA91VguKQy6uC+YUIkyx0l
        E104KkVu7yWK/bp65gRDy6NGAzDQ7IxE+p/EDBy6iGyPf35fwzbpyR9gw==
X-ME-Sender: <xms:HhDBZG5FuNsGIrpVUn0eLAYhsXSLdBkYebjLWh3nqvHJkmQPP5ClCA>
    <xme:HhDBZP5_NMl43vqsV-GDJTQ3e-ld-GnPnCAoOM5I8l3Q9-3BeVxS8nqlWjXTZoT_o
    1DVB0rfZVqQ5mE>
X-ME-Received: <xmr:HhDBZFcL4Q-2-CPh6hygFkmwRnUlq1fQJJIizUFB3ZTm4cPrvnKXwm6bTl3qsgOPBBKwzUzlY17xfUoFbCLbbeAisP6cdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedvgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpeefgfejkeduieefheehhfdvffekleeuteegvdejfedufffgleeugefglefhgefg
    teenucffohhmrghinhepuhhnihiighdrhhhrpdhgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihgu
    ohhstghhrdhorhhg
X-ME-Proxy: <xmx:HhDBZDJqGR5dnJKPTwDd0j6nBYxucLJS-TBIB73A4k_N_PN8F-UUmA>
    <xmx:HhDBZKLnliRASX3an8iW2VEaEY7Xi1tZKe0XppWDAH9rFllkg7M9Sg>
    <xmx:HhDBZEzImq6gbLgbPazKqjCdK3ZItccLG78RTvm_4bEB4F6vG3EvTg>
    <xmx:HhDBZLoF1rAU6431kbLRaQwPbnAvjTD9j4xs1Y9VdfaizwqRS8D7kg>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jul 2023 08:22:53 -0400 (EDT)
Date:   Wed, 26 Jul 2023 15:22:48 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v1 01/11] selftests: forwarding:
 custom_multipath_hash.sh: add cleanup for SIGTERM sent by timeout
Message-ID: <ZMEQGIOQXv6so30x@shredder>
References: <20230722003609.380549-1-mirsad.todorovac@alu.unizg.hr>
 <ZLzj5oYrbHGvCMkq@shredder>
 <0550924e-dce9-f90d-df8a-db810fd2499f@alu.unizg.hr>
 <adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr>
 <ZL6OljQubhVtQjcD@shredder>
 <cab8ea8a-98f4-ef9b-4215-e2a93cccaab1@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cab8ea8a-98f4-ef9b-4215-e2a93cccaab1@alu.unizg.hr>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 24, 2023 at 10:46:09PM +0200, Mirsad Todorovac wrote:
> On 7/24/23 16:45, Ido Schimmel wrote:
> > On Sun, Jul 23, 2023 at 11:37:46PM +0200, Mirsad Todorovac wrote:
> > > Some tests however exited with error:
> 
> Hi,
> 
> > > marvin@defiant:~/linux/kernel/linux_torvalds$ grep "not ok" ../kselftest-6.5-rc2-net-forwarding-11.log
> > > not ok 3 selftests: net/forwarding: bridge_mdb.sh # exit=1
> > > not ok 5 selftests: net/forwarding: bridge_mdb_max.sh # exit=1
> > > not ok 11 selftests: net/forwarding: bridge_vlan_mcast.sh # exit=1
> > 
> > I can't reproduce these three.
> 
> I have now enabled 'set -x' and here is the link to the output.
> 
> NOTE as there are side-effects to running the test scripts, I have ran the

I don't believe this is correct after "selftests: forwarding: Switch off
timeout".

> whole suite, just in case:
> 
> https://domac.alu.unizg.hr/~mtodorov/linux/selftests/net-forwarding/kselftest-6.5-rc3-net-forwarding-12.log.xz
> 
> > Do you have systemd-networkd running?
> 
> No:

[...]

> > > not ok 15 selftests: net/forwarding: ethtool_extended_state.sh # exit=1
> > > not ok 17 selftests: net/forwarding: ethtool.sh # exit=1
> > > not ok 25 selftests: net/forwarding: hw_stats_l3_gre.sh # exit=1
> > 
> > Fixed these three.
> > 
> > > not ok 26 selftests: net/forwarding: ip6_forward_instats_vrf.sh # exit=1
> > 
> > Fixed.
> 
> Great job, that's almost 50% of them!
> 
> > > not ok 80 selftests: net/forwarding: tc_actions.sh # exit=1
> > > not ok 83 selftests: net/forwarding: tc_flower.sh # exit=1
> > > not ok 84 selftests: net/forwarding: tc_flower_l2_miss.sh # exit=1
> > > not ok 89 selftests: net/forwarding: tc_tunnel_key.sh # exit=1
> > 
> > Can't reproduce these.
> 
> Hope the above will help.

Pushed fixes for tc_actions.sh, tc_flower.sh and tc_tunnel_key.sh to the
same branch. Please test them.

Regarding the MDB tests and tc_flower_l2_miss.sh, I suspect you might
have some daemon in user space that sends IGMP queries and therefore
messes with the tests. Please run the following commands in a separate
terminal before running tc_flower_l2_miss.sh:

# perf probe --add 'br_ip4_multicast_query'
# perf record -a -g -e 'probe:br_ip4_multicast_query'

After the test finishes, terminate the second command and run:

# perf report --stdio

It should show us if queries were received and which process sent them.

> 
> > Pushed the fixes on top of the fixes from yesterday:
> > 
> > https://github.com/idosch/linux/commits/submit/sefltests_fix_v1
> 
> I have applied them.
> 
> BTW, after running the full net/forwarding test suite, "ip link show"
> looks like this:
> 
> marvin@defiant:~/linux/kernel/linux_torvalds$ ip link show
> 256: veth7@veth6: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>     link/ether 16:74:e0:e6:f0:92 brd ff:ff:ff:ff:ff:ff
> 257: veth6@veth7: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>     link/ether 22:f3:40:50:fb:73 brd ff:ff:ff:ff:ff:ff
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> 2: enp16s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
>     link/ether 9c:6b:00:01:fb:80 brd ff:ff:ff:ff:ff:ff
> 3: veth1@veth0: <BROADCAST,MULTICAST,M-DOWN> mtu 10000 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>     link/ether b6:46:e6:4c:e4:00 brd ff:ff:ff:ff:ff:ff
> 4: veth0@veth1: <BROADCAST,MULTICAST,M-DOWN> mtu 2000 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>     link/ether 2e:ff:7f:8a:6b:d4 brd ff:ff:ff:ff:ff:ff
> 5: veth3@veth2: <BROADCAST,MULTICAST,M-DOWN> mtu 10000 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>     link/ether ba:33:37:81:dc:5b brd ff:ff:ff:ff:ff:ff
> 6: veth2@veth3: <BROADCAST,MULTICAST,M-DOWN> mtu 2000 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>     link/ether f2:fd:0a:9b:94:17 brd ff:ff:ff:ff:ff:ff
> 278: veth9@veth8: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>     link/ether 0a:f1:22:04:0f:55 brd ff:ff:ff:ff:ff:ff
> 279: veth8@veth9: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>     link/ether 92:be:71:00:59:0f brd ff:ff:ff:ff:ff:ff
> 282: gre0@NONE: <NOARP> mtu 1476 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/gre 0.0.0.0 brd 0.0.0.0
> 283: gretap0@NONE: <BROADCAST,MULTICAST> mtu 1462 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
> 284: erspan0@NONE: <BROADCAST,MULTICAST> mtu 1450 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
> 366: ip6tnl0@NONE: <NOARP> mtu 1452 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/tunnel6 :: brd :: permaddr ce1e:75f3:f565::
> 367: ip6gre0@NONE: <NOARP> mtu 1448 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/gre6 :: brd :: permaddr 1e91:da47:154d::
> 237: veth5@veth4: <BROADCAST,MULTICAST,M-DOWN> mtu 2000 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>     link/ether 6a:e3:dc:ad:8c:a0 brd ff:ff:ff:ff:ff:ff
> 238: veth4@veth5: <BROADCAST,MULTICAST,M-DOWN> mtu 10000 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>     link/ether ce:a7:61:90:c8:2d brd ff:ff:ff:ff:ff:ff
> marvin@defiant:~/linux/kernel/linux_torvalds$
> 
> This is kinda awkward, because I have to reboot the machine for the next run, each time.

Why? The fact that the veth pairs are already present doesn't impact the
selftests.

> 
> I am in no condition to try to figure out which tests leaked links.

The veth pairs were created by the first invocation of the selftests and
are not deleted at the end. We already discussed it. But the fact that
they are already present does not mean you can't re-run the tests.

Regarding gre0, gretap0, erspan0, ip6tnl0 and ip6gre0, they are
automatically created by the kernel when the relevant kernel modules are
loaded. They are not used by the selftests.
