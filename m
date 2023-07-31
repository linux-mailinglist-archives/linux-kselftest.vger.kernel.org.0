Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72549769A8C
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 17:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjGaPO2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 11:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjGaPOZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 11:14:25 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FA8C3;
        Mon, 31 Jul 2023 08:14:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 3B5856017F;
        Mon, 31 Jul 2023 17:14:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690816448; bh=NxXGa4uFSywbb/jKA1tSuonK4wBF0KYvphWm5DL7A0w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aXW0WPeQ5HPxrL45CHWaPdqMcqpjc5BodOBvAFfaZoAj7DxSZFoV9FpF1z5XgJuGl
         kNV7tkUU0tzjCkJ6A/okTBe49QNJ465wBodMyoRq10iJxPDiQNgQQUqGYOBtY8NfTu
         p/n2Ub39fE9eKe/9Cd4iP0AmKmGBNnert6NKczlR3tTxUJnxpN7zjG5wRIjB3vtSda
         nVuV62oA1gtSBxGvuPMzOumVZPYh0ncnkgi339dXq05qLNWirBNonepJf1HxhqbPAZ
         4dnxMDDb3gaFyaQagpe+ediGT17wgic3ayaMWGriv9YmK6qd6xhRn7L46hiGghuHoZ
         0K4OSblLH3nqA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id l8fhQsgxTSSd; Mon, 31 Jul 2023 17:14:05 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id A210260173;
        Mon, 31 Jul 2023 17:13:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690816445; bh=NxXGa4uFSywbb/jKA1tSuonK4wBF0KYvphWm5DL7A0w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=M7enfuT0YSo07VF+cbuN5tPGvdkVLFvCmCOcbsseoszOEmv9sD8AkSqyExnMWfKfx
         CFL6/Lb0q9ey+g5kyp2aYL3YvdL/MYGjGpAw4VVe//2IeWXrPU5VCFw1BRtcyZieV8
         CzMW2oJqYcSiadjaUWiMzAhrDU2+JoXpsVqt2CV4LQkH+665CmAQoyRomutiIA+q6O
         njL09R83gXhzTefEL2v1xNhUkOc7NBVm7c1ri3VmFtYCAqvanI4mIOaFxAIZAUxz2J
         LF+UokUMK9uFBZBq+f0f7ydaiy1oLqaOfFcWThBxeoU5SPUBKNfh9qh6AOuPSEx7GJ
         3tDazhxa+5LuA==
Message-ID: <cadad022-b241-398d-c79d-187596356a72@alu.unizg.hr>
Date:   Mon, 31 Jul 2023 17:13:37 +0200
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
 <ZMei0VMIH/l1GzVM@shredder>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZMei0VMIH/l1GzVM@shredder>
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

On 7/31/23 14:02, Ido Schimmel wrote:
> On Mon, Jul 31, 2023 at 11:24:27AM +0200, Mirsad Todorovac wrote:
>> I guess that means only three are left.
>>
>> # ./bridge_mdb.sh
>> dev br0 port veth1 grp 239.1.1.1 src 192.0.2.1 temp filter_mode include proto static vid 10  259.99
>> TEST: IPv4 (S, G) port group entries configuration tests            [FAIL]
>> 	Entry has an unpending group timer after replace
>> dev br0 port veth1 grp ff0e::1 src 2001:db8:1::1 temp filter_mode include proto static vid 10  259.99
>> TEST: IPv6 (S, G) port group entries configuration tests            [FAIL]
>> 	Entry has an unpending group timer after replace
> 
> I suspect that what happens here is that you have a faster system
> than me or a different HZ value (check CONFIG_HZ, mine is 1000). The
> group membership time is probably 260.00 which is why grepping for
> "0.00" works when it shouldn't. Can you try the patch below? No need to
> run all the other tests.
> 
> diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
> index 8493c3dfc01e..41c33a2de0a6 100755
> --- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
> +++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
> @@ -617,7 +617,7 @@ __cfg_test_port_ip_sg()
>                  grep -q "permanent"
>          check_err $? "Entry not added as \"permanent\" when should"
>          bridge -d -s mdb show dev br0 vid 10 | grep "$grp_key" | \
> -               grep -q "0.00"
> +               grep -q " 0.00"
>          check_err $? "\"permanent\" entry has a pending group timer"
>          bridge mdb del dev br0 port $swp1 $grp_key vid 10
>   
> @@ -626,7 +626,7 @@ __cfg_test_port_ip_sg()
>                  grep -q "temp"
>          check_err $? "Entry not added as \"temp\" when should"
>          bridge -d -s mdb show dev br0 vid 10 | grep "$grp_key" | \
> -               grep -q "0.00"
> +               grep -q " 0.00"
>          check_fail $? "\"temp\" entry has an unpending group timer"
>          bridge mdb del dev br0 port $swp1 $grp_key vid 10
>   
> @@ -659,7 +659,7 @@ __cfg_test_port_ip_sg()
>                  grep -q "permanent"
>          check_err $? "Entry not marked as \"permanent\" after replace"
>          bridge -d -s mdb show dev br0 vid 10 | grep "$grp_key" | \
> -               grep -q "0.00"
> +               grep -q " 0.00"
>          check_err $? "Entry has a pending group timer after replace"
>   
>          bridge mdb replace dev br0 port $swp1 $grp_key vid 10 temp
> @@ -667,7 +667,7 @@ __cfg_test_port_ip_sg()
>                  grep -q "temp"
>          check_err $? "Entry not marked as \"temp\" after replace"
>          bridge -d -s mdb show dev br0 vid 10 | grep "$grp_key" | \
> -               grep -q "0.00"
> +               grep -q " 0.00"
>          check_fail $? "Entry has an unpending group timer after replace"
>          bridge mdb del dev br0 port $swp1 $grp_key vid 10

Congrats! This worked:

root@defiant:tools/testing/selftests/net/forwarding# ./bridge_mdb.sh

INFO: # Host entries configuration tests
TEST: Common host entries configuration tests (IPv4)                [ OK ]
TEST: Common host entries configuration tests (IPv6)                [ OK ]
TEST: Common host entries configuration tests (L2)                  [ OK ]

INFO: # Port group entries configuration tests - (*, G)
TEST: Common port group entries configuration tests (IPv4 (*, G))   [ OK ]
TEST: Common port group entries configuration tests (IPv6 (*, G))   [ OK ]
TEST: IPv4 (*, G) port group entries configuration tests            [ OK ]
TEST: IPv6 (*, G) port group entries configuration tests            [ OK ]

INFO: # Port group entries configuration tests - (S, G)
TEST: Common port group entries configuration tests (IPv4 (S, G))   [ OK ]
TEST: Common port group entries configuration tests (IPv6 (S, G))   [ OK ]
dev br0 port veth1 grp 239.1.1.1 src 192.0.2.1 temp filter_mode include proto static vid 10  259.99
TEST: IPv4 (S, G) port group entries configuration tests            [ OK ]
dev br0 port veth1 grp ff0e::1 src 2001:db8:1::1 temp filter_mode include proto static vid 10  259.99
TEST: IPv6 (S, G) port group entries configuration tests            [ OK ]

INFO: # Port group entries configuration tests - L2
TEST: Common port group entries configuration tests (L2 (*, G))     [ OK ]
TEST: L2 (*, G) port group entries configuration tests              [ OK ]

INFO: # Large scale dump tests
TEST: IPv4 large scale dump tests                                   [ OK ]
TEST: IPv6 large scale dump tests                                   [ OK ]
TEST: L2 large scale dump tests                                     [ OK ]

INFO: # Forwarding tests
TEST: IPv4 host entries forwarding tests                            [ OK ]
TEST: IPv6 host entries forwarding tests                            [ OK ]
TEST: L2 host entries forwarding tests                              [ OK ]
TEST: IPv4 port group "exclude" entries forwarding tests            [ OK ]
TEST: IPv6 port group "exclude" entries forwarding tests            [ OK ]
TEST: IPv4 port group "include" entries forwarding tests            [ OK ]
TEST: IPv6 port group "include" entries forwarding tests            [ OK ]
TEST: L2 port entries forwarding tests                              [ OK ]

INFO: # Control packets tests
TEST: IGMPv3 MODE_IS_INCLUDE tests                                  [ OK ]
TEST: MLDv2 MODE_IS_INCLUDE tests                                   [ OK ]
root@defiant:tools/testing/selftests/net/forwarding#

>> # ./bridge_vlan_mcast.sh
>> TEST: Vlan mcast_startup_query_interval global option default value   [FAIL]
>> 	Wrong default mcast_startup_query_interval global vlan option value
>> # ./mirror_gre_changes.sh
>> TEST: mirror to gretap: TTL change (skip_hw)                        [FAIL]
>> 	Expected to capture 10 packets, got 15.
>> TEST: mirror to ip6gretap: TTL change (skip_hw)                     [FAIL]
>> 	Expected to capture 10 packets, got 13.
>> WARN: Could not test offloaded functionality
> 
> I hope Nik and Petr will find the time to look into those. If not, I
> will check when I can.

Great. I will wait for the follow-up then ...

You can add:

Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>

at your convenience. I think that it appropriate with the Code of Conduct.

Kind regards,
Mirsad


>> NOTE: The error happened because two patches collided. This patch
>>
>> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
>> index 975fc5168c6334..40a8c1541b7f81 100755
>> --- a/tools/testing/selftests/net/forwarding/lib.sh
>> +++ b/tools/testing/selftests/net/forwarding/lib.sh
>> @@ -30,6 +30,7 @@ REQUIRE_MZ=${REQUIRE_MZ:=yes}
>>   REQUIRE_MTOOLS=${REQUIRE_MTOOLS:=no}
>>   STABLE_MAC_ADDRS=${STABLE_MAC_ADDRS:=no}
>>   TCPDUMP_EXTRA_FLAGS=${TCPDUMP_EXTRA_FLAGS:=}
>> +TROUTE6=${TROUTE6:=traceroute6}
>>   relative_path="${BASH_SOURCE%/*}"
>>   if [[ "$relative_path" == "${BASH_SOURCE}" ]]; then
>>
>> and this patch
>>
>> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
>> index 71f7c0c49677..5b0183013017 100755
>> --- a/tools/testing/selftests/net/forwarding/lib.sh
>> +++ b/tools/testing/selftests/net/forwarding/lib.sh
>> @@ -16,8 +16,6 @@ TEAMD=${TEAMD:=teamd}
>>   WAIT_TIME=${WAIT_TIME:=5}
>>   PAUSE_ON_FAIL=${PAUSE_ON_FAIL:=no}
>>   PAUSE_ON_CLEANUP=${PAUSE_ON_CLEANUP:=no}
>> -NETIF_TYPE=${NETIF_TYPE:=veth}
>> -NETIF_CREATE=${NETIF_CREATE:=yes}
>>   MCD=${MCD:=smcrouted}
>>   MC_CLI=${MC_CLI:=smcroutectl}
>>   PING_COUNT=${PING_COUNT:=10}
>> @@ -30,6 +28,20 @@ REQUIRE_MZ=${REQUIRE_MZ:=yes}
>>   REQUIRE_MTOOLS=${REQUIRE_MTOOLS:=no}
>>   STABLE_MAC_ADDRS=${STABLE_MAC_ADDRS:=no}
>>   TCPDUMP_EXTRA_FLAGS=${TCPDUMP_EXTRA_FLAGS:=}
>> +NETIF_TYPE=${NETIF_TYPE:=veth}
>> +NETIF_CREATE=${NETIF_CREATE:=yes}
>> +declare -A NETIFS=(
>> +       [p1]=veth0
>> +       [p2]=veth1
>> +       [p3]=veth2
>> +       [p4]=veth3
>> +       [p5]=veth4
>> +       [p6]=veth5
>> +       [p7]=veth6
>> +       [p8]=veth7
>> +       [p9]=veth8
>> +       [p10]=veth9
>> +)
>>
>>   relative_path="${BASH_SOURCE%/*}"
>>   if [[ "$relative_path" == "${BASH_SOURCE}" ]]; then
>>
>> are not compatible.
>>
>> I have applied the 'require_command $TROUTE6' patch manually.
>>
>> I suppose this is what you intended to have:
>>
>> # Can be overridden by the configuration file.
>> PING=${PING:=ping}
>> PING6=${PING6:=ping6}
>> MZ=${MZ:=mausezahn}
>> ARPING=${ARPING:=arping}
>> TEAMD=${TEAMD:=teamd}
>> WAIT_TIME=${WAIT_TIME:=5}
>> PAUSE_ON_FAIL=${PAUSE_ON_FAIL:=no}
>> PAUSE_ON_CLEANUP=${PAUSE_ON_CLEANUP:=no}
>> MCD=${MCD:=smcrouted}
>> MC_CLI=${MC_CLI:=smcroutectl}
>> PING_COUNT=${PING_COUNT:=10}
>> PING_TIMEOUT=${PING_TIMEOUT:=5}
>> WAIT_TIMEOUT=${WAIT_TIMEOUT:=20}
>> INTERFACE_TIMEOUT=${INTERFACE_TIMEOUT:=600}
>> LOW_AGEING_TIME=${LOW_AGEING_TIME:=1000}
>> REQUIRE_JQ=${REQUIRE_JQ:=yes}
>> REQUIRE_MZ=${REQUIRE_MZ:=yes}
>> REQUIRE_MTOOLS=${REQUIRE_MTOOLS:=no}
>> STABLE_MAC_ADDRS=${STABLE_MAC_ADDRS:=no}
>> TCPDUMP_EXTRA_FLAGS=${TCPDUMP_EXTRA_FLAGS:=}
>> TROUTE6=${TROUTE6:=traceroute6}
>> NETIF_TYPE=${NETIF_TYPE:=veth}
>> NETIF_CREATE=${NETIF_CREATE:=yes}
>> declare -A NETIFS=(
>>         [p1]=veth0
>>         [p2]=veth1
>>         [p3]=veth2
>>         [p4]=veth3
>>         [p5]=veth4
>>         [p6]=veth5
>>         [p7]=veth6
>>         [p8]=veth7
>>         [p9]=veth8
>>         [p10]=veth9
>> )
>>
>> relative_path="${BASH_SOURCE%/*}"
>> if [[ "$relative_path" == "${BASH_SOURCE}" ]]; then
>>          relative_path="."
>> fi
>> ------------------------------------------------
>>
>> Probably for the production patch you would like to have this fixed.
> 
> No, I don't intend to submit the patch that automatically creates the
> veth pairs. It is superseded by "selftests: forwarding: Skip test when
> no interfaces are specified".
