Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A7B7691A9
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 11:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjGaJ0Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 05:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjGaJZ6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 05:25:58 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0071FCA;
        Mon, 31 Jul 2023 02:24:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id F086F6017F;
        Mon, 31 Jul 2023 11:24:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690795477; bh=LkfFeBRdv/EiJnFEypSxyrbE9TqdrljO0R0Su/jnKm8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ipJ4XoHkuLqw/vryVgWHk4rtZwdzao6FreVkphSRGsQ3aFVo+iQbRLY9S/viexub/
         O4MCvloxyXxuGeK/94KBEL14ZSvMXBUc4fqIEOwBc1IDmItZ/0bdybbcSwEQwQNHsa
         UqcdlK/hpkgjLlA6s/WYI7Fw794BbuWa6K2asgwOKEk/S6UAjf9PrmCnnWlO5tgvqJ
         YC3O2C6JGBYhUsybRb+7sdoxH2f4lU9EBISfmkSuVTxtMiGlZUxVW8T67i5VY8Nh25
         XhhIbfqq7wvt/YC21TjOwvqWgka+qzBrqqvgr1YPKqq4lJCfe97MztJY3DXW5qYs56
         3N1q5Q5eBdVdg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KX89WtKi1hOD; Mon, 31 Jul 2023 11:24:35 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id C9FF560182;
        Mon, 31 Jul 2023 11:24:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690795475; bh=LkfFeBRdv/EiJnFEypSxyrbE9TqdrljO0R0Su/jnKm8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BP6T+IoFeVtMtBCpyHkzSvgZVMcAMwnq5LlGPOj9y/+gNnKdP6pxegH9amjbtgUA4
         b6QHdAmpbt1JeCTNZMe9k1WUxET5R30qgwqQ83nZ486jdRRsPP9hwTt7xIREfsAveG
         02LOO4dC5bKeZCg+l9uwco3ivDkQEtyDrKoMmBvYOdvT8rV2qWqfcQqSpkXgR2Pcx6
         CoQTxCurnyH7E4N87qjM7HxIsxFkdtG+h8u41AHmstseCm+dZWeWNN2T6PHaa8tuuL
         9QYlES7qB2XpPo+x/Ja7LkuKJp1aOdk35KED8zX0XAfx7PQLEyGhMLQhZtQB8vKExN
         w1XyvNe9yag0A==
Message-ID: <2f203995-5ae0-13bc-d1a6-997c2b36a2b8@alu.unizg.hr>
Date:   Mon, 31 Jul 2023 11:24:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v1 01/11] selftests: forwarding: custom_multipath_hash.sh:
 add cleanup for SIGTERM sent by timeout
Content-Language: en-US
To:     Ido Schimmel <idosch@idosch.org>
Cc:     petrm@nvidia.com, razor@blackwall.org,
        Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
References: <20230722003609.380549-1-mirsad.todorovac@alu.unizg.hr>
 <ZLzj5oYrbHGvCMkq@shredder>
 <0550924e-dce9-f90d-df8a-db810fd2499f@alu.unizg.hr>
 <adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr>
 <ZL6OljQubhVtQjcD@shredder>
 <cab8ea8a-98f4-ef9b-4215-e2a93cccaab1@alu.unizg.hr>
 <ZMEQGIOQXv6so30x@shredder>
 <a9b6d9f5-14ae-a931-ab7b-d31b5e40f5df@alu.unizg.hr>
 <ZMYXABUN9OzfN5D3@shredder>
 <da3f4f4e-47a7-25be-fa61-aebeba1d8d0c@alu.unizg.hr>
 <ZMdouQRypZCGZhV0@shredder>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZMdouQRypZCGZhV0@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/31/23 09:54, Ido Schimmel wrote:
> Thanks for testing.

Not at all.

> On Sun, Jul 30, 2023 at 06:48:04PM +0200, Mirsad Todorovac wrote:
>> not ok 26 selftests: net/forwarding: ip6_forward_instats_vrf.sh # exit=1
> 
> Regarding this one, in the log I don't see the require_command() that I
> added in "selftests: forwarding: Set default IPv6 traceroute utility".
> Also, at line 470 I see "ip vrf exec vveth0 2001:1:2::2" which is
> another indication that you don't have the patch.

This is correct.

Now I have:

root@defiant:tools/testing/selftests/net/forwarding# ./ip6_forward_instats_vrf.sh
SKIP: traceroute6 not installed

Mystery solved. This is much more useful output :-)

Installed traceroute6 and now the test is OK:

root@defiant:tools/testing/selftests/net/forwarding# ./ip6_forward_instats_vrf.sh
TEST: ping6                                                         [ OK ]
TEST: Ip6InTooBigErrors                                             [ OK ]
TEST: Ip6InHdrErrors                                                [ OK ]
TEST: Ip6InAddrErrors                                               [ OK ]
TEST: Ip6InDiscards                                                 [ OK ]
root@defiant:tools/testing/selftests/net/forwarding#

I guess that means only three are left.

# ./bridge_mdb.sh
dev br0 port veth1 grp 239.1.1.1 src 192.0.2.1 temp filter_mode include proto static vid 10  259.99
TEST: IPv4 (S, G) port group entries configuration tests            [FAIL]
	Entry has an unpending group timer after replace
dev br0 port veth1 grp ff0e::1 src 2001:db8:1::1 temp filter_mode include proto static vid 10  259.99
TEST: IPv6 (S, G) port group entries configuration tests            [FAIL]
	Entry has an unpending group timer after replace
# ./bridge_vlan_mcast.sh
TEST: Vlan mcast_startup_query_interval global option default value   [FAIL]
	Wrong default mcast_startup_query_interval global vlan option value
# ./mirror_gre_changes.sh
TEST: mirror to gretap: TTL change (skip_hw)                        [FAIL]
	Expected to capture 10 packets, got 15.
TEST: mirror to ip6gretap: TTL change (skip_hw)                     [FAIL]
	Expected to capture 10 packets, got 13.
WARN: Could not test offloaded functionality
#

NOTE: The error happened because two patches collided. This patch

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 975fc5168c6334..40a8c1541b7f81 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -30,6 +30,7 @@ REQUIRE_MZ=${REQUIRE_MZ:=yes}
  REQUIRE_MTOOLS=${REQUIRE_MTOOLS:=no}
  STABLE_MAC_ADDRS=${STABLE_MAC_ADDRS:=no}
  TCPDUMP_EXTRA_FLAGS=${TCPDUMP_EXTRA_FLAGS:=}
+TROUTE6=${TROUTE6:=traceroute6}
  
  relative_path="${BASH_SOURCE%/*}"
  if [[ "$relative_path" == "${BASH_SOURCE}" ]]; then

and this patch

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 71f7c0c49677..5b0183013017 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -16,8 +16,6 @@ TEAMD=${TEAMD:=teamd}
  WAIT_TIME=${WAIT_TIME:=5}
  PAUSE_ON_FAIL=${PAUSE_ON_FAIL:=no}
  PAUSE_ON_CLEANUP=${PAUSE_ON_CLEANUP:=no}
-NETIF_TYPE=${NETIF_TYPE:=veth}
-NETIF_CREATE=${NETIF_CREATE:=yes}
  MCD=${MCD:=smcrouted}
  MC_CLI=${MC_CLI:=smcroutectl}
  PING_COUNT=${PING_COUNT:=10}
@@ -30,6 +28,20 @@ REQUIRE_MZ=${REQUIRE_MZ:=yes}
  REQUIRE_MTOOLS=${REQUIRE_MTOOLS:=no}
  STABLE_MAC_ADDRS=${STABLE_MAC_ADDRS:=no}
  TCPDUMP_EXTRA_FLAGS=${TCPDUMP_EXTRA_FLAGS:=}
+NETIF_TYPE=${NETIF_TYPE:=veth}
+NETIF_CREATE=${NETIF_CREATE:=yes}
+declare -A NETIFS=(
+       [p1]=veth0
+       [p2]=veth1
+       [p3]=veth2
+       [p4]=veth3
+       [p5]=veth4
+       [p6]=veth5
+       [p7]=veth6
+       [p8]=veth7
+       [p9]=veth8
+       [p10]=veth9
+)

  relative_path="${BASH_SOURCE%/*}"
  if [[ "$relative_path" == "${BASH_SOURCE}" ]]; then

are not compatible.

I have applied the 'require_command $TROUTE6' patch manually.

I suppose this is what you intended to have:

# Can be overridden by the configuration file.
PING=${PING:=ping}
PING6=${PING6:=ping6}
MZ=${MZ:=mausezahn}
ARPING=${ARPING:=arping}
TEAMD=${TEAMD:=teamd}
WAIT_TIME=${WAIT_TIME:=5}
PAUSE_ON_FAIL=${PAUSE_ON_FAIL:=no}
PAUSE_ON_CLEANUP=${PAUSE_ON_CLEANUP:=no}
MCD=${MCD:=smcrouted}
MC_CLI=${MC_CLI:=smcroutectl}
PING_COUNT=${PING_COUNT:=10}
PING_TIMEOUT=${PING_TIMEOUT:=5}
WAIT_TIMEOUT=${WAIT_TIMEOUT:=20}
INTERFACE_TIMEOUT=${INTERFACE_TIMEOUT:=600}
LOW_AGEING_TIME=${LOW_AGEING_TIME:=1000}
REQUIRE_JQ=${REQUIRE_JQ:=yes}
REQUIRE_MZ=${REQUIRE_MZ:=yes}
REQUIRE_MTOOLS=${REQUIRE_MTOOLS:=no}
STABLE_MAC_ADDRS=${STABLE_MAC_ADDRS:=no}
TCPDUMP_EXTRA_FLAGS=${TCPDUMP_EXTRA_FLAGS:=}
TROUTE6=${TROUTE6:=traceroute6}
NETIF_TYPE=${NETIF_TYPE:=veth}
NETIF_CREATE=${NETIF_CREATE:=yes}
declare -A NETIFS=(
        [p1]=veth0
        [p2]=veth1
        [p3]=veth2
        [p4]=veth3
        [p5]=veth4
        [p6]=veth5
        [p7]=veth6
        [p8]=veth7
        [p9]=veth8
        [p10]=veth9
)

relative_path="${BASH_SOURCE%/*}"
if [[ "$relative_path" == "${BASH_SOURCE}" ]]; then
         relative_path="."
fi
------------------------------------------------

Probably for the production patch you would like to have this fixed.

Have a nice day.

Kind regards,
Mirsad
