Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2116765C0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 21:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjG0T0R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 15:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjG0T0Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 15:26:16 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28430268B;
        Thu, 27 Jul 2023 12:26:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 64CB260171;
        Thu, 27 Jul 2023 21:26:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690485971; bh=7fw+979HTyI3g1irHu9HUvXN9G+83ViUcHnWOykGLQo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ds7DmjwyRCEn/utPKUwbq8uOWCVvzYsxdhFPhfZCeG7V7oijdsNqGDIxntdSCBjoI
         mRlymUUKnIR56QpsixQIYBble7Ye3+K/6jYGivvFeEdM9Nc7bSvpzmnXNKBgbjrRvW
         1sRtInDngtJWDHJ8brAuRvGaxsDh3hZm0UYaB4jmQciDkjBpisgJR8Ne6tbJE7Kxot
         oUAIkVqq1y8Bw2++ZG2ddjRTd4Y80apfiS6FG72WeBLILcKXHU7Zjd9pJGoC+hrtkF
         Dynlh+WqLc4bdOjRLGkCteC7nypRGxWWH4ML7tJBHKf3yN2shLvHWnrRtxMJQwAijv
         WTyEicERvYA1g==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JQ1USOFRCqN7; Thu, 27 Jul 2023 21:26:08 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 6AAA96016E;
        Thu, 27 Jul 2023 21:26:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690485968; bh=7fw+979HTyI3g1irHu9HUvXN9G+83ViUcHnWOykGLQo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YdkWLbc/ePFiF615XLOoQ43cVK8dZujUylvK+MTbybvavLuJA0m2bq3GcDpPDq1AJ
         bVdFbK6i4/x8v+mQbDGoS24Ze1pJNPrsT2ypJgak3qEaYsrpxQjYBBQUF7btXEdvwP
         sa2iEjxnr0cLEj9cZxg8DycbAIe2vSiRNCA06U1EZAmr23SjoxrqFFSgLrPHH3RwGQ
         KnGOpO7pmJ50LXnvlPHZLdhVu1i00swp+K3RMu0xP3dD6Qvn7eH/bwsjTTj1ViUo9W
         z0ZxoEF3zSujUciSa5drnAWBBElnCOfkw3gIo+YSo5xTiVoqrly1GFHjBMa/AdjThV
         8IBxsb/7JtwUw==
Message-ID: <a9b6d9f5-14ae-a931-ab7b-d31b5e40f5df@alu.unizg.hr>
Date:   Thu, 27 Jul 2023 21:26:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v1 01/11] selftests: forwarding: custom_multipath_hash.sh:
 add cleanup for SIGTERM sent by timeout
Content-Language: en-US
To:     Ido Schimmel <idosch@idosch.org>
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
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZMEQGIOQXv6so30x@shredder>
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

On 7/26/23 14:22, Ido Schimmel wrote:
> On Mon, Jul 24, 2023 at 10:46:09PM +0200, Mirsad Todorovac wrote:
>> On 7/24/23 16:45, Ido Schimmel wrote:
>>> On Sun, Jul 23, 2023 at 11:37:46PM +0200, Mirsad Todorovac wrote:
>>>> Some tests however exited with error:
>>
>> Hi,
>>
>>>> marvin@defiant:~/linux/kernel/linux_torvalds$ grep "not ok" ../kselftest-6.5-rc2-net-forwarding-11.log
>>>> not ok 3 selftests: net/forwarding: bridge_mdb.sh # exit=1
>>>> not ok 5 selftests: net/forwarding: bridge_mdb_max.sh # exit=1
>>>> not ok 11 selftests: net/forwarding: bridge_vlan_mcast.sh # exit=1
>>>
>>> I can't reproduce these three.
>>
>> I have now enabled 'set -x' and here is the link to the output.
>>
>> NOTE as there are side-effects to running the test scripts, I have ran the
> 
> I don't believe this is correct after "selftests: forwarding: Switch off
> timeout".
> 
>> whole suite, just in case:
>>
>> https://domac.alu.unizg.hr/~mtodorov/linux/selftests/net-forwarding/kselftest-6.5-rc3-net-forwarding-12.log.xz
>>
>>> Do you have systemd-networkd running?
>>
>> No:
> 
> [...]
> 
>>>> not ok 15 selftests: net/forwarding: ethtool_extended_state.sh # exit=1
>>>> not ok 17 selftests: net/forwarding: ethtool.sh # exit=1
>>>> not ok 25 selftests: net/forwarding: hw_stats_l3_gre.sh # exit=1
>>>
>>> Fixed these three.
>>>
>>>> not ok 26 selftests: net/forwarding: ip6_forward_instats_vrf.sh # exit=1
>>>
>>> Fixed.
>>
>> Great job, that's almost 50% of them!
>>
>>>> not ok 80 selftests: net/forwarding: tc_actions.sh # exit=1
>>>> not ok 83 selftests: net/forwarding: tc_flower.sh # exit=1
>>>> not ok 84 selftests: net/forwarding: tc_flower_l2_miss.sh # exit=1
>>>> not ok 89 selftests: net/forwarding: tc_tunnel_key.sh # exit=1
>>>
>>> Can't reproduce these.
>>
>> Hope the above will help.
> 
> Pushed fixes for tc_actions.sh, tc_flower.sh and tc_tunnel_key.sh to the
> same branch. Please test them.
> 
> Regarding the MDB tests and tc_flower_l2_miss.sh, I suspect you might
> have some daemon in user space that sends IGMP queries and therefore
> messes with the tests. Please run the following commands in a separate
> terminal before running tc_flower_l2_miss.sh:
> 
> # perf probe --add 'br_ip4_multicast_query'
> # perf record -a -g -e 'probe:br_ip4_multicast_query'
> 
> After the test finishes, terminate the second command and run:
> 
> # perf report --stdio
> 
> It should show us if queries were received and which process sent them.
> 
>>
>>> Pushed the fixes on top of the fixes from yesterday:
>>>
>>> https://github.com/idosch/linux/commits/submit/sefltests_fix_v1
>>
>> I have applied them.
>>
>> BTW, after running the full net/forwarding test suite, "ip link show"
>> looks like this:
>>
>> marvin@defiant:~/linux/kernel/linux_torvalds$ ip link show
>> 256: veth7@veth6: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>>      link/ether 16:74:e0:e6:f0:92 brd ff:ff:ff:ff:ff:ff
>> 257: veth6@veth7: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>>      link/ether 22:f3:40:50:fb:73 brd ff:ff:ff:ff:ff:ff
>> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
>>      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>> 2: enp16s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
>>      link/ether 9c:6b:00:01:fb:80 brd ff:ff:ff:ff:ff:ff
>> 3: veth1@veth0: <BROADCAST,MULTICAST,M-DOWN> mtu 10000 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>>      link/ether b6:46:e6:4c:e4:00 brd ff:ff:ff:ff:ff:ff
>> 4: veth0@veth1: <BROADCAST,MULTICAST,M-DOWN> mtu 2000 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>>      link/ether 2e:ff:7f:8a:6b:d4 brd ff:ff:ff:ff:ff:ff
>> 5: veth3@veth2: <BROADCAST,MULTICAST,M-DOWN> mtu 10000 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>>      link/ether ba:33:37:81:dc:5b brd ff:ff:ff:ff:ff:ff
>> 6: veth2@veth3: <BROADCAST,MULTICAST,M-DOWN> mtu 2000 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>>      link/ether f2:fd:0a:9b:94:17 brd ff:ff:ff:ff:ff:ff
>> 278: veth9@veth8: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>>      link/ether 0a:f1:22:04:0f:55 brd ff:ff:ff:ff:ff:ff
>> 279: veth8@veth9: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>>      link/ether 92:be:71:00:59:0f brd ff:ff:ff:ff:ff:ff
>> 282: gre0@NONE: <NOARP> mtu 1476 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>>      link/gre 0.0.0.0 brd 0.0.0.0
>> 283: gretap0@NONE: <BROADCAST,MULTICAST> mtu 1462 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>>      link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
>> 284: erspan0@NONE: <BROADCAST,MULTICAST> mtu 1450 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>>      link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
>> 366: ip6tnl0@NONE: <NOARP> mtu 1452 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>>      link/tunnel6 :: brd :: permaddr ce1e:75f3:f565::
>> 367: ip6gre0@NONE: <NOARP> mtu 1448 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>>      link/gre6 :: brd :: permaddr 1e91:da47:154d::
>> 237: veth5@veth4: <BROADCAST,MULTICAST,M-DOWN> mtu 2000 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>>      link/ether 6a:e3:dc:ad:8c:a0 brd ff:ff:ff:ff:ff:ff
>> 238: veth4@veth5: <BROADCAST,MULTICAST,M-DOWN> mtu 10000 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>>      link/ether ce:a7:61:90:c8:2d brd ff:ff:ff:ff:ff:ff
>> marvin@defiant:~/linux/kernel/linux_torvalds$
>>
>> This is kinda awkward, because I have to reboot the machine for the next run, each time.
> 
> Why? The fact that the veth pairs are already present doesn't impact the
> selftests.
> 
>>
>> I am in no condition to try to figure out which tests leaked links.
> 
> The veth pairs were created by the first invocation of the selftests and
> are not deleted at the end. We already discussed it. But the fact that
> they are already present does not mean you can't re-run the tests.
> 
> Regarding gre0, gretap0, erspan0, ip6tnl0 and ip6gre0, they are
> automatically created by the kernel when the relevant kernel modules are
> loaded. They are not used by the selftests.

If you're in dilemma, my experiment had shown that it is sufficient to delete one
side of the veth link, for another side automagically vanishes.

BTW, the patches successfully applied, safe for the following:

error: patch failed: tools/testing/selftests/net/forwarding/hw_stats_l3_gre.sh:99
error: tools/testing/selftests/net/forwarding/hw_stats_l3_gre.sh: patch does not apply

error: patch failed: tools/testing/selftests/net/forwarding/ethtool_extended_state.sh:108
error: tools/testing/selftests/net/forwarding/ethtool_extended_state.sh: patch does not apply

error: patch failed: tools/testing/selftests/net/forwarding/ethtool_mm.sh:278
error: tools/testing/selftests/net/forwarding/ethtool_mm.sh: patch does not apply

(Manual inspection revealed that all of those are adding of skip_on_veth which was already
present in the script, but I recall you added skip_on_veth recently, so I guess this is something
in our patch communication.)

The test results are very good:

marvin@defiant:~/linux/kernel/linux_torvalds$ grep "not ok" ../kselftest-6.5-rc3-net-forwarding-16.log
not ok 3 selftests: net/forwarding: bridge_mdb.sh # exit=1
not ok 5 selftests: net/forwarding: bridge_mdb_max.sh # exit=1
not ok 11 selftests: net/forwarding: bridge_vlan_mcast.sh # exit=1
not ok 26 selftests: net/forwarding: ip6_forward_instats_vrf.sh # exit=1
not ok 49 selftests: net/forwarding: mirror_gre_changes.sh # exit=1
not ok 84 selftests: net/forwarding: tc_flower_l2_miss.sh # exit=1
marvin@defiant:~/linux/kernel/linux_torvalds$ grep -v "^# +" ../kselftest-6.5-rc3-net-forwarding-16.log | grep -A1 FAIL | grep -v -e -- | grep -v OK
# TEST: IPv6 (S, G) port group entries configuration tests            [FAIL]
# 	"temp" entry has an unpending group timer
# TEST: IPv4 host entries forwarding tests                            [FAIL]
# 	Packet not locally received after adding a host entry
# TEST: IPv4 port group "exclude" entries forwarding tests            [FAIL]
# 	Packet from valid source not received on H2 after adding entry
# TEST: IPv4 port group "include" entries forwarding tests            [FAIL]
# 	Packet from valid source not received on H2 after adding entry
# TEST: IGMPv3 MODE_IS_INCLUDE tests                                  [FAIL]
# 	Source not add to source list
# TEST: ctl4: port: ngroups reporting                                 [FAIL]
# 	Couldn't add MDB entries
# TEST: ctl4: port maxgroups: reporting and treatment of 0            [FAIL]
# 	Adding 5 MDB entries failed but should have passed
# TEST: ctl4: port maxgroups: configure below ngroups                 [FAIL]
# 	dev veth1: Couldn't add MDB entries
# TEST: ctl4: port: ngroups reporting                                 [FAIL]
# 	Couldn't add MDB entries
# TEST: ctl4: port maxgroups: reporting and treatment of 0            [FAIL]
# 	Adding 5 MDB entries failed but should have passed
# TEST: ctl4: port maxgroups: configure below ngroups                 [FAIL]
# 	dev veth1 vid 10: Couldn't add MDB entries
# TEST: ctl4: port_vlan: ngroups reporting                            [FAIL]
# 	Couldn't add MDB entries
# TEST: ctl4: port_vlan: isolation of port and per-VLAN ngroups       [FAIL]
# 	Couldn't add MDB entries to VLAN 10
# TEST: ctl4: port_vlan maxgroups: reporting and treatment of 0       [FAIL]
# 	Adding 5 MDB entries failed but should have passed
# TEST: ctl4: port_vlan maxgroups: configure below ngroups            [FAIL]
# 	dev veth1 vid 10: Couldn't add MDB entries
# TEST: ctl4: port_vlan maxgroups: isolation of port and per-VLAN ngroups   [FAIL]
# 	Couldn't add 5 entries
# TEST: Vlan mcast_startup_query_interval global option default value   [FAIL]
# 	Wrong default mcast_startup_query_interval global vlan option value
# TEST: Ip6InHdrErrors                                                [FAIL]
# TEST: mirror to gretap: TTL change (skip_hw)                        [FAIL]
# 	Expected to capture 10 packets, got 14.
# TEST: L2 miss - Multicast (IPv4)                                    [FAIL]
# 	Unregistered multicast filter was not hit before adding MDB entry
marvin@defiant:~/linux/kernel/linux_torvalds$

In case you want to pursue these failures, there is the complete test output log
here:

https://domac.alu.unizg.hr/~mtodorov/linux/selftests/net-forwarding/kselftest-6.5-rc3-net-forwarding-16.log.xz

Thanks again, great work!

Kind regards,
Mirsad
