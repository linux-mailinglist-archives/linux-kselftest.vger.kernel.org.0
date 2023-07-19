Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A25A759610
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 14:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjGSM7a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 08:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjGSM7a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 08:59:30 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E79C113;
        Wed, 19 Jul 2023 05:59:28 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 512D05C00AD;
        Wed, 19 Jul 2023 08:59:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 19 Jul 2023 08:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689771565; x=1689857965; bh=tTNyPZitoSE69
        bfMeeZHw81SO7vH8/lOR1ecEDTdkuU=; b=ma/TCNemj65HAhn9cHs93Q6YY6arL
        h8f+aLsoF91MhCiTtVlDNkNPUoWUD0TEPuDp0qO8fFBR15XNTRvHKODwi7iuNTDP
        jUlEcrsfPQbzvI2dviMK3eRaeerSHJfBTyWg9gPLjT0KMXOQUOHsyRQwL6wqAo8L
        1W+/6mBm4pKqL7epyZEIXt5J9tswjLqkNxsN+K+S9QjGlF4t7POkkV83P2j/K89y
        WoGeD+GlveXaG3FACMLLMFRXVD1Q1WqpwG1xWWRBpvV1K7TlNZWRfB0UNmF5T2PI
        M/k8Tf58fHEkwlEn80t1a5wZ6jR9j0Tcv5h77u9glQWfX/SruiOIWWepg==
X-ME-Sender: <xms:LN63ZPx8QTKwCBbR6Vsam_9clItFGtG6_59BiFQHxxAQg9X7sBTsgA>
    <xme:LN63ZHS7ckRWg4g3PJ6mkCD4snAeZJ20YjZFSRSop0OuHTzKjKDo9ReskwKINBk7M
    8XTxOovqMt4OaE>
X-ME-Received: <xmr:LN63ZJVglJfeLJHzPYTfExMbX2SPmSamT8Pfjp2_REF30VRzhXPSD96gK0D9GqLxiOwYzVZMU2RpJrmsvQk91m3l4Kk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgeekgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:LN63ZJhpMl0B24HzAzwYR1_LHEl4HDy5iydMQAZ_na3gEmdVy-0FJg>
    <xmx:LN63ZBBKuV3MaWtCxXzqw3Ny5n7f7q6XwevW9YN06leud4-YW7N67Q>
    <xmx:LN63ZCKFFQhBYhGUNwTU1f1gTTFiRAulMmv_js3iZoGIItn15Q4RhQ>
    <xmx:Ld63ZFsglQSXT6V74-B81LCui_2UgJ-pwis7YBMqwebwbhoXrL-zcQ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Jul 2023 08:59:23 -0400 (EDT)
Date:   Wed, 19 Jul 2023 15:59:19 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        petrm@nvidia.com
Subject: Re: [PROBLEM] selftests: net/forwarding/*.sh: 'Command line is not
 complete. Try option "help"'
Message-ID: <ZLfeJzFJ1HEeooZR@shredder>
References: <856d454e-f83c-20cf-e166-6dc06cbc1543@alu.unizg.hr>
 <ZLY9yiaVwCGy5H3R@shredder>
 <8d149f8c-818e-d141-a0ce-a6bae606bc22@alu.unizg.hr>
 <1c2a2d56-95a0-72f8-23a0-1e186e6443a2@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c2a2d56-95a0-72f8-23a0-1e186e6443a2@alu.unizg.hr>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 18, 2023 at 08:39:33PM +0200, Mirsad Todorovac wrote:
> There is also a gotcha here: you do not delete all veths:
> 
> root@defiant:# ip link show
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> 2: enp16s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
>     link/ether 9c:6b:00:01:fb:80 brd ff:ff:ff:ff:ff:ff
> root@defiant:# ./bridge_igmp.sh

[...]

> root@defiant:# ip link show
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> 2: enp16s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
>     link/ether 9c:6b:00:01:fb:80 brd ff:ff:ff:ff:ff:ff
> 3: veth1@veth0: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>     link/ether b6:46:e6:4c:e4:00 brd ff:ff:ff:ff:ff:ff
> 4: veth0@veth1: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>     link/ether 2e:ff:7f:8a:6b:d4 brd ff:ff:ff:ff:ff:ff
> 5: veth3@veth2: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>     link/ether ba:33:37:81:dc:5b brd ff:ff:ff:ff:ff:ff
> 6: veth2@veth3: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>     link/ether f2:fd:0a:9b:94:17 brd ff:ff:ff:ff:ff:ff
> root@defiant:#

These tests can be run with veth pairs or with loop backed physical
ports. We can't delete the latter and I don't see a clean way to delete
the veth pairs.

The following patch [1] changes the default to not create interfaces so
that by default these tests will be skipped [2]. Those who care about
running the tests can create a forwarding.config file (using
forwarding.config.sample as an example) and either create the veth pairs
themselves or opt-in for the interfaces to be created automatically
(setting NETIF_CREATE=yes), but not deleted.

[1]
diff --git a/tools/testing/selftests/net/forwarding/forwarding.config.sample b/tools/testing/selftests/net/forwarding/forwarding.config.sample
index 4a546509de90..b72f08dfd491 100644
--- a/tools/testing/selftests/net/forwarding/forwarding.config.sample
+++ b/tools/testing/selftests/net/forwarding/forwarding.config.sample
@@ -36,8 +36,9 @@ PAUSE_ON_FAIL=no
 PAUSE_ON_CLEANUP=no
 # Type of network interface to create
 NETIF_TYPE=veth
-# Whether to create virtual interfaces (veth) or not
-NETIF_CREATE=yes
+# Whether to create virtual interfaces (veth) or not. Created interfaces are
+# not automatically deleted
+NETIF_CREATE=no
 # Timeout (in seconds) before ping exits regardless of how many packets have
 # been sent or received
 PING_TIMEOUT=5
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 9ddb68dd6a08..1b1bc634c63e 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -17,7 +17,7 @@ WAIT_TIME=${WAIT_TIME:=5}
 PAUSE_ON_FAIL=${PAUSE_ON_FAIL:=no}
 PAUSE_ON_CLEANUP=${PAUSE_ON_CLEANUP:=no}
 NETIF_TYPE=${NETIF_TYPE:=veth}
-NETIF_CREATE=${NETIF_CREATE:=yes}
+NETIF_CREATE=${NETIF_CREATE:=no}
 MCD=${MCD:=smcrouted}
 MC_CLI=${MC_CLI:=smcroutectl}
 PING_COUNT=${PING_COUNT:=10}

[2]
# ./bridge_igmp.sh 
SKIP: could not find all required interfaces
