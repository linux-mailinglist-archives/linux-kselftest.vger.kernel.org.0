Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565E8768681
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jul 2023 18:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjG3QsS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Jul 2023 12:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjG3QsR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Jul 2023 12:48:17 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9EB1A5;
        Sun, 30 Jul 2023 09:48:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 6A6AB6017E;
        Sun, 30 Jul 2023 18:48:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690735693; bh=43H4EXXoSMkvICv8uWwTafOuMnO3jp1tSKuXKs07nSM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O1LmJRe7kY/vLUf9mYBqz0JnpRpzhjjM1x1b7UsidEbs3JnmEaEcmPMOQ9idsoTsH
         p0mHd+LzKUcP2ZZsVWC9ZOYHz2MtEfGJFQznH7AxcCz9lvUVmfKjTZguhbVtdCWlXb
         SU/O3OBiVT1h4/k+DrQ0vuhmSSaSfFCVw+qt/ehh1DiWazisnJn8EPVg2ILGlf1wag
         avErB/ys0sAyoBeqYZkxNLOULH/3q1zUJtEDc+D9qy3TioRyI77Va2639trummpmND
         IZmuvKHV4/rOQO+BrSqKDlgDbG0oLh3uTlqgofLsd9BAG86euRfXBBsj0X9KemZzIP
         Xi2O2YJj8aDYg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EooBxH1sf3dr; Sun, 30 Jul 2023 18:48:10 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 884376017C;
        Sun, 30 Jul 2023 18:48:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690735690; bh=43H4EXXoSMkvICv8uWwTafOuMnO3jp1tSKuXKs07nSM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bz52X3+hOPWW6X6imEEOH1PR0YPoXncckUJNQivuaajGkd2Ube7vtKOJovG67fAdL
         tAsfwFpeY9Cr0qX+EvpCQh8oR680Ecnddhs0BpDX3Go5RTlm3N/5mUK34BzOdHcbiX
         BTjEdVovBT59v3U+NeV31qdLyZinYEudrWtjRXc8YLIa6RK2oAnMsVu5b64TMnP31F
         41XQOXb5U7xlk3eUAiiMi1oYBX0LlQrq8KyV/9n8bFxKCClLEk+alzHkC69K4e9s99
         693eWYzkAn0Uh8ZLQKq6MyuCySt7OlBLNDeP5TbaW20rtS6l0ORBFjO8fIip8bHy2x
         DyFndGx1y63Ig==
Message-ID: <da3f4f4e-47a7-25be-fa61-aebeba1d8d0c@alu.unizg.hr>
Date:   Sun, 30 Jul 2023 18:48:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v1 01/11] selftests: forwarding: custom_multipath_hash.sh:
 add cleanup for SIGTERM sent by timeout
To:     Ido Schimmel <idosch@idosch.org>, petrm@nvidia.com,
        razor@blackwall.org
Cc:     Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
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
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZMYXABUN9OzfN5D3@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/30/23 09:53, Ido Schimmel wrote:
> On Thu, Jul 27, 2023 at 09:26:03PM +0200, Mirsad Todorovac wrote:
>> marvin@defiant:~/linux/kernel/linux_torvalds$ grep "not ok" ../kselftest-6.5-rc3-net-forwarding-16.log
>> not ok 3 selftests: net/forwarding: bridge_mdb.sh # exit=1
> 
> Other than one test case (see below), I believe this should be fixed by
> the patches I just pushed to the existing branch. My earlier fix was
> incomplete which is why it didn't solve the problem.
> 
>> not ok 5 selftests: net/forwarding: bridge_mdb_max.sh # exit=1
> 
> Should be fixed with the patches.

Congratulations! Indeed, it looks a lot better:

marvin@defiant:~/linux/kernel/linux_torvalds$ grep "not ok" ../kselftest-6.5-rc3-net-forwarding-18.log
not ok 3 selftests: net/forwarding: bridge_mdb.sh # exit=1
not ok 11 selftests: net/forwarding: bridge_vlan_mcast.sh # exit=1
not ok 26 selftests: net/forwarding: ip6_forward_instats_vrf.sh # exit=1
not ok 49 selftests: net/forwarding: mirror_gre_changes.sh # exit=1
marvin@defiant:~/linux/kernel/linux_torvalds$ grep -v '^# +' ../kselftest-6.5-rc3-net-forwarding-18.log | grep -A1 -e '\[FAIL\]' | grep -v -e -- | grep -v OK
# TEST: IPv4 (S, G) port group entries configuration tests            [FAIL]
# 	Entry has an unpending group timer after replace
# TEST: IPv6 (S, G) port group entries configuration tests            [FAIL]
# 	Entry has an unpending group timer after replace
# TEST: Vlan mcast_startup_query_interval global option default value   [FAIL]
# 	Wrong default mcast_startup_query_interval global vlan option value
# TEST: Ip6InHdrErrors                                                [FAIL]
# TEST: mirror to gretap: TTL change (skip_hw)                        [FAIL]
# 	Expected to capture 10 packets, got 15.
# TEST: mirror to ip6gretap: TTL change (skip_hw)                     [FAIL]
# 	Expected to capture 10 packets, got 13.
marvin@defiant:~/linux/kernel/linux_torvalds$

>> not ok 11 selftests: net/forwarding: bridge_vlan_mcast.sh # exit=1
> 
> Nik, the relevant failure is this one:
> 
> # TEST: Vlan mcast_startup_query_interval global option default value   [FAIL]
> # 	Wrong default mcast_startup_query_interval global vlan option value
> 
> Any idea why the kernel will report "mcast_startup_query_interval" as
> 3124 instead of 3125?
> 
> # + jq -e '.[].vlans[] | select(.vlan == 10 and                                             .mcast_startup_query_interval == 3125) '
> # + echo -n '[{"ifname":"br0","vlans":[{"vlan":1,"mcast_snooping":1,"mcast_querier":0,"mcast_igmp_version":2,"mcast_mld_version":1,"mcast_last_member_count":2,"mcast_last_member_interval":100,"mcast_startup_query_count":2,"mcast_startup_query_interval":3124,"mcast_membership_interval":26000,"mcast_querier_interval":25500,"mcast_query_interval":12500,"mcast_query_response_interval":1000},{"vlan":10,"vlanEnd":11,"mcast_snooping":1,"mcast_querier":0,"mcast_igmp_version":2,"mcast_mld_version":1,"mcast_last_member_count":2,"mcast_last_member_interval":100,"mcast_startup_query_count":2,"mcast_startup_query_interval":3124,"mcast_membership_interval":26000,"mcast_querier_interval":25500,"mcast_query_interval":12500,"mcast_query_response_interval":1000}]}]'
> # + check_err 4 'Wrong default mcast_startup_query_interval global vlan option value'
> 
>> not ok 26 selftests: net/forwarding: ip6_forward_instats_vrf.sh # exit=1
> 
> Please run this one with +x so that we will get more info.

In fact, I have turned it on on all the remaining failing tests.

In case you want to investigate further, please find the debug output log
at the usual place:

https://domac.alu.unizg.hr/~mtodorov/linux/selftests/net-forwarding/kselftest-6.5-rc3-net-forwarding-18.log.xz

https://domac.alu.unizg.hr/~mtodorov/linux/selftests/net-forwarding/bridge_mdb.sh.out.xz
https://domac.alu.unizg.hr/~mtodorov/linux/selftests/net-forwarding/bridge_vlan_mcast.sh.out.xz
https://domac.alu.unizg.hr/~mtodorov/linux/selftests/net-forwarding/ip6_forward_instats_vrf.sh.out.xz
https://domac.alu.unizg.hr/~mtodorov/linux/selftests/net-forwarding/mirror_gre_changes.sh.out.xz

I hope this helps, because you drastically reduced the number of [FAIL] results.

If it matters being heard from me, I think it's a great job!

Kind regards,
Mirsad

>> not ok 49 selftests: net/forwarding: mirror_gre_changes.sh # exit=1
> 
> Petr, please take a look. Probably need to make the filters more
> specific. The failure is:
> 
> # TEST: mirror to gretap: TTL change (skip_hw)                        [FAIL]
> # 	Expected to capture 10 packets, got 14.
> 
>> not ok 84 selftests: net/forwarding: tc_flower_l2_miss.sh # exit=1
> 
> Should be fixed with the patches.
> 
>> marvin@defiant:~/linux/kernel/linux_torvalds$ grep -v "^# +" ../kselftest-6.5-rc3-net-forwarding-16.log | grep -A1 FAIL | grep -v -e -- | grep -v OK
>> # TEST: IPv6 (S, G) port group entries configuration tests            [FAIL]
>> # 	"temp" entry has an unpending group timer
> 
> Not sure about this one. What is the output with the following diff?
> 
> diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
> index 8493c3dfc01e..2b2a3b150861 100755
> --- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
> +++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
> @@ -628,6 +628,7 @@ __cfg_test_port_ip_sg()
>          bridge -d -s mdb show dev br0 vid 10 | grep "$grp_key" | \
>                  grep -q "0.00"
>          check_fail $? "\"temp\" entry has an unpending group timer"
> +       bridge -d -s mdb show dev br0 vid 10 | grep "$grp_key"
>          bridge mdb del dev br0 port $swp1 $grp_key vid 10
>   
>          # Check error cases.
> 
>> # TEST: IPv4 host entries forwarding tests                            [FAIL]
>> # 	Packet not locally received after adding a host entry
>> # TEST: IPv4 port group "exclude" entries forwarding tests            [FAIL]
>> # 	Packet from valid source not received on H2 after adding entry
>> # TEST: IPv4 port group "include" entries forwarding tests            [FAIL]
>> # 	Packet from valid source not received on H2 after adding entry
>> # TEST: IGMPv3 MODE_IS_INCLUDE tests                                  [FAIL]
>> # 	Source not add to source list
>> # TEST: ctl4: port: ngroups reporting                                 [FAIL]
>> # 	Couldn't add MDB entries
>> # TEST: ctl4: port maxgroups: reporting and treatment of 0            [FAIL]
>> # 	Adding 5 MDB entries failed but should have passed
>> # TEST: ctl4: port maxgroups: configure below ngroups                 [FAIL]
>> # 	dev veth1: Couldn't add MDB entries
>> # TEST: ctl4: port: ngroups reporting                                 [FAIL]
>> # 	Couldn't add MDB entries
>> # TEST: ctl4: port maxgroups: reporting and treatment of 0            [FAIL]
>> # 	Adding 5 MDB entries failed but should have passed
>> # TEST: ctl4: port maxgroups: configure below ngroups                 [FAIL]
>> # 	dev veth1 vid 10: Couldn't add MDB entries
>> # TEST: ctl4: port_vlan: ngroups reporting                            [FAIL]
>> # 	Couldn't add MDB entries
>> # TEST: ctl4: port_vlan: isolation of port and per-VLAN ngroups       [FAIL]
>> # 	Couldn't add MDB entries to VLAN 10
>> # TEST: ctl4: port_vlan maxgroups: reporting and treatment of 0       [FAIL]
>> # 	Adding 5 MDB entries failed but should have passed
>> # TEST: ctl4: port_vlan maxgroups: configure below ngroups            [FAIL]
>> # 	dev veth1 vid 10: Couldn't add MDB entries
>> # TEST: ctl4: port_vlan maxgroups: isolation of port and per-VLAN ngroups   [FAIL]
>> # 	Couldn't add 5 entries
>> # TEST: Vlan mcast_startup_query_interval global option default value   [FAIL]
>> # 	Wrong default mcast_startup_query_interval global vlan option value
>> # TEST: Ip6InHdrErrors                                                [FAIL]
>> # TEST: mirror to gretap: TTL change (skip_hw)                        [FAIL]
>> # 	Expected to capture 10 packets, got 14.
>> # TEST: L2 miss - Multicast (IPv4)                                    [FAIL]
>> # 	Unregistered multicast filter was not hit before adding MDB entry
>> marvin@defiant:~/linux/kernel/linux_torvalds$
>>
>> In case you want to pursue these failures, there is the complete test output log
>> here:
>>
>> https://domac.alu.unizg.hr/~mtodorov/linux/selftests/net-forwarding/kselftest-6.5-rc3-net-forwarding-16.log.xz
>>
>> Thanks again, great work!
>>
>> Kind regards,
>> Mirsad
