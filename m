Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A04675D82F
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 02:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjGVAbX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jul 2023 20:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjGVAbW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jul 2023 20:31:22 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FABA272D;
        Fri, 21 Jul 2023 17:31:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 2CEB86016E;
        Sat, 22 Jul 2023 02:31:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689985876; bh=vHQq3ZzNW3zorfLxkEgx2EZDUysb20GUI2w0lOAJB34=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=reihfOX2LnpQb5NcYgkF4y7wXf39c/bTOlbuiBmBlTPNj3yxwtx9ht2eimJCK8NQ/
         L6dYX6APSmOIkXIN6q+zrzmd26RVUgDskTD+KQKEIHu/M9zX6KAx4MVPoJtKwBa2jG
         z+DDafP2jznGHSSDiZ1H1+ZxboTQHsP0zaAcs0cDonyzPq/4iT+SEoAeha1lXLmsIA
         hh42+mLpdWyzSQdKGrae0pTaqzCsRLjuM6fIoYad47UtaTEXoYszdagE6W4jtEO8Es
         k2qhMt8tdVerfcpKzy9fMtUZ8iDoiAuI/lnuzqS6p/Z0svaSjljy/mpF6pIaZaSqlH
         nsRQ9ET3XmLYw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2YsFdt3FoqKt; Sat, 22 Jul 2023 02:31:13 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 6F2296015F;
        Sat, 22 Jul 2023 02:31:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689985873; bh=vHQq3ZzNW3zorfLxkEgx2EZDUysb20GUI2w0lOAJB34=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=hxXR1YpD2E4RfeXEX1B5LMGbLrJbutaax6aiQJIm1hI5PG1GoOcCEzpvHPUFxNm10
         uQHBVeXuZQHhxR27hwx3d3PY7unYVhLaGRi1+em5rkvfY1fIjpkXDAEChtcG3TEokA
         HXlfnJalYREAbgLD/X+GANEOI/NT3K2gXk3WN6cWhmiYCFu8j+fOlqLlPgUkK5PfhC
         OajSx5S+exzYN7/9V0Roh1WI02lYbxl/PAdIHQN/BpkB2UySmK9xRVN8XejEgrUmvV
         1BESbPU14+s1HfBvqHxvEmBevD5EP/qKoWhETRLDPSoq19L6e5IHRdtAX2dOKjIMJf
         9ffjrdFUg+yew==
Message-ID: <c9a9856b-4a86-3f32-b6e5-d89af4a46048@alu.unizg.hr>
Date:   Sat, 22 Jul 2023 02:31:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PROBLEM] [ADDITIONAL DIAG] seltests: net/forwarding/sch_ets.sh
 [HANG]
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Petr Machata <petrm@nvidia.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>
References: <759fe934-2e43-e9ff-8946-4fd579c09b05@alu.unizg.hr>
 <87cz0m9a3n.fsf@nvidia.com>
 <580b9f28-7a68-e618-b2d5-b8663386aa12@alu.unizg.hr>
 <6c871d89-390d-41ae-ef48-6cd12b99fd74@alu.unizg.hr>
In-Reply-To: <6c871d89-390d-41ae-ef48-6cd12b99fd74@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/20/23 18:25, Mirsad Todorovac wrote:
> On 7/20/23 18:07, Mirsad Todorovac wrote:
>> On 7/20/23 11:43, Petr Machata wrote:
>>>
>>> Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr> writes:
>>>
>>>> Using the same config for 6.5-rc2 on Ubuntu 22.04 LTS and 22.10, the execution
>>>> stop at the exact same line on both boxes (os I reckon it is more than an
>>>> accident):
>>>>
>>>> # selftests: net/forwarding: sch_ets.sh
>>>> # TEST: ping vlan 10                                                  [ OK ]
>>>> # TEST: ping vlan 11                                                  [ OK ]
>>>> # TEST: ping vlan 12                                                  [ OK ]
>>>> # Running in priomap mode
>>>> # Testing ets bands 3 strict 3, streams 0 1
>>>> # TEST: band 0                                                        [ OK ]
>>>> # INFO: Expected ratio >95% Measured ratio 100.00
>>>> # TEST: band 1                                                        [ OK ]
>>>> # INFO: Expected ratio <5% Measured ratio 0
>>>> # Testing ets bands 3 strict 3, streams 1 2
>>>> # TEST: band 1                                                        [ OK ]
>>>> # INFO: Expected ratio >95% Measured ratio 100.00
>>>> # TEST: band 2                                                        [ OK ]
>>>> # INFO: Expected ratio <5% Measured ratio 0
>>>> # Testing ets bands 4 strict 1 quanta 5000 2500 1500, streams 0 1
>>>> # TEST: band 0                                                        [ OK ]
>>>> # INFO: Expected ratio >95% Measured ratio 100.00
>>>> # TEST: band 1                                                        [ OK ]
>>>> # INFO: Expected ratio <5% Measured ratio 0
>>>> # Testing ets bands 4 strict 1 quanta 5000 2500 1500, streams 1 2
>>>> # TEST: bands 1:2                                                     [ OK ]
>>>> # INFO: Expected ratio 2.00 Measured ratio 1.99
>>>> # Testing ets bands 3 quanta 3300 3300 3300, streams 0 1 2
>>>> # TEST: bands 0:1                                                     [ OK ]
>>>> # INFO: Expected ratio 1.00 Measured ratio .99
>>>> # TEST: bands 0:2                                                     [ OK ]
>>>> # INFO: Expected ratio 1.00 Measured ratio 1.00
>>>> # Testing ets bands 3 quanta 5000 3500 1500, streams 0 1 2
>>>> # TEST: bands 0:1                                                     [ OK ]
>>>> # INFO: Expected ratio 1.42 Measured ratio 1.42
>>>> # TEST: bands 0:2                                                     [ OK ]
>>>> # INFO: Expected ratio 3.33 Measured ratio 3.33
>>>> # Testing ets bands 3 quanta 5000 8000 1500, streams 0 1 2
>>>> # TEST: bands 0:1                                                     [ OK ]
>>>> # INFO: Expected ratio 1.60 Measured ratio 1.59
>>>> # TEST: bands 0:2                                                     [ OK ]
>>>> # INFO: Expected ratio 3.33 Measured ratio 3.33
>>>> # Testing ets bands 2 quanta 5000 2500, streams 0 1
>>>> # TEST: bands 0:1                                                     [ OK ]
>>>> # INFO: Expected ratio 2.00 Measured ratio 1.99
>>>> # Running in classifier mode
>>>> # Testing ets bands 3 strict 3, streams 0 1
>>>> # TEST: band 0                                                        [ OK ]
>>>> # INFO: Expected ratio >95% Measured ratio 100.00
>>>> # TEST: band 1                                                        [ OK ]
>>>> # INFO: Expected ratio <5% Measured ratio 0
>>>> # Testing ets bands 3 strict 3, streams 1 2
>>>> # TEST: band 1                                                        [ OK ]
>>>> # INFO: Expected ratio >95% Measured ratio 100.00
>>>> # TEST: band 2                                                        [ OK ]
>>>> # INFO: Expected ratio <5% Measured ratio 0
>>>> # Testing ets bands 4 strict 1 quanta 5000 2500 1500, streams 0 1
>>>>
>>>> I tried to run 'set -x' enabled version standalone, but that one finished
>>>> correctly (?).
>>>>
>>>> It could be something previous scripts left, but right now I don't have a clue.
>>>> I can attempt to rerun all tests with sch_ets.sh bash 'set -x' enabled later today.
>>>
>>> If you run it standalone without set -x, does it finish as well?
>>
>> Added that. Yes, standlone run finishes correctly, with or without 'set -x':
>>
>> root@defiant:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/net/forwarding# ./sch_ets.sh
>> TEST: ping vlan 10                                                  [ OK ]
>> TEST: ping vlan 11                                                  [ OK ]
>> TEST: ping vlan 12                                                  [ OK ]
>> Running in priomap mode
>> Testing ets bands 3 strict 3, streams 0 1
>> TEST: band 0                                                        [ OK ]
>> INFO: Expected ratio >95% Measured ratio 100.00
>> TEST: band 1                                                        [ OK ]
>> INFO: Expected ratio <5% Measured ratio 0
>> killing MZ
>> killed MZ
>> killing MZ
>> killed MZ
>> Testing ets bands 3 strict 3, streams 1 2
>> TEST: band 1                                                        [ OK ]
>> INFO: Expected ratio >95% Measured ratio 100.00
>> TEST: band 2                                                        [ OK ]
>> INFO: Expected ratio <5% Measured ratio 0
>> killing MZ
>> killed MZ
>> killing MZ
>> killed MZ
>> Testing ets bands 4 strict 1 quanta 5000 2500 1500, streams 0 1
>> TEST: band 0                                                        [ OK ]
>> INFO: Expected ratio >95% Measured ratio 100.00
>> TEST: band 1                                                        [ OK ]
>> INFO: Expected ratio <5% Measured ratio 0
>> killing MZ
>> killed MZ
>> killing MZ
>> killed MZ
>> Testing ets bands 4 strict 1 quanta 5000 2500 1500, streams 1 2
>> TEST: bands 1:2                                                     [ OK ]
>> INFO: Expected ratio 2.00 Measured ratio 1.99
>> killing MZ
>> killed MZ
>> killing MZ
>> killed MZ
>> Testing ets bands 3 quanta 3300 3300 3300, streams 0 1 2
>> TEST: bands 0:1                                                     [ OK ]
>> INFO: Expected ratio 1.00 Measured ratio 1.00
>> TEST: bands 0:2                                                     [ OK ]
>> INFO: Expected ratio 1.00 Measured ratio .99
>> killing MZ
>> killed MZ
>> killing MZ
>> killed MZ
>> killing MZ
>> killed MZ
>> Testing ets bands 3 quanta 5000 3500 1500, streams 0 1 2
>> TEST: bands 0:1                                                     [ OK ]
>> INFO: Expected ratio 1.42 Measured ratio 1.42
>> TEST: bands 0:2                                                     [ OK ]
>> INFO: Expected ratio 3.33 Measured ratio 3.33
>> killing MZ
>> killed MZ
>> killing MZ
>> killed MZ
>> killing MZ
>> killed MZ
>> Testing ets bands 3 quanta 5000 8000 1500, streams 0 1 2
>> TEST: bands 0:1                                                     [ OK ]
>> INFO: Expected ratio 1.60 Measured ratio 1.59
>> TEST: bands 0:2                                                     [ OK ]
>> INFO: Expected ratio 3.33 Measured ratio 3.33
>> killing MZ
>> killed MZ
>> killing MZ
>> killed MZ
>> killing MZ
>> killed MZ
>> Testing ets bands 2 quanta 5000 2500, streams 0 1
>> TEST: bands 0:1                                                     [ OK ]
>> INFO: Expected ratio 2.00 Measured ratio 1.99
>> killing MZ
>> killed MZ
>> killing MZ
>> killed MZ
>> Running in classifier mode
>> Testing ets bands 3 strict 3, streams 0 1
>> TEST: band 0                                                        [ OK ]
>> INFO: Expected ratio >95% Measured ratio 100.00
>> TEST: band 1                                                        [ OK ]
>> INFO: Expected ratio <5% Measured ratio 0
>> killing MZ
>> killed MZ
>> killing MZ
>> killed MZ
>> Testing ets bands 3 strict 3, streams 1 2
>> TEST: band 1                                                        [ OK ]
>> INFO: Expected ratio >95% Measured ratio 100.00
>> TEST: band 2                                                        [ OK ]
>> INFO: Expected ratio <5% Measured ratio 0
>> killing MZ
>> killed MZ
>> killing MZ
>> killed MZ
>> Testing ets bands 4 strict 1 quanta 5000 2500 1500, streams 0 1
>> TEST: band 0                                                        [ OK ]
>> INFO: Expected ratio >95% Measured ratio 100.00
>> TEST: band 1                                                        [ OK ]
>> INFO: Expected ratio <5% Measured ratio 0
>> killing MZ
>> killed MZ
>> killing MZ
>> killed MZ
>> Testing ets bands 4 strict 1 quanta 5000 2500 1500, streams 1 2
>> TEST: bands 1:2                                                     [ OK ]
>> INFO: Expected ratio 2.00 Measured ratio 1.99
>> killing MZ
>> killed MZ
>> killing MZ
>> killed MZ
>> Testing ets bands 3 quanta 3300 3300 3300, streams 0 1 2
>> TEST: bands 0:1                                                     [ OK ]
>> INFO: Expected ratio 1.00 Measured ratio .99
>> TEST: bands 0:2                                                     [ OK ]
>> INFO: Expected ratio 1.00 Measured ratio .99
>> killing MZ
>> killed MZ
>> killing MZ
>> killed MZ
>> killing MZ
>> killed MZ
>> Testing ets bands 3 quanta 5000 3500 1500, streams 0 1 2
>> TEST: bands 0:1                                                     [ OK ]
>> INFO: Expected ratio 1.42 Measured ratio 1.42
>> TEST: bands 0:2                                                     [ OK ]
>> INFO: Expected ratio 3.33 Measured ratio 3.33
>> killing MZ
>> killed MZ
>> killing MZ
>> killed MZ
>> killing MZ
>> killed MZ
>> Testing ets bands 3 quanta 5000 8000 1500, streams 0 1 2
>> TEST: bands 0:1                                                     [ OK ]
>> INFO: Expected ratio 1.60 Measured ratio 1.60
>> TEST: bands 0:2                                                     [ OK ]
>> INFO: Expected ratio 3.33 Measured ratio 3.33
>> killing MZ
>> killed MZ
>> killing MZ
>> killed MZ
>> killing MZ
>> killed MZ
>> Testing ets bands 2 quanta 5000 2500, streams 0 1
>> TEST: bands 0:1                                                     [ OK ]
>> INFO: Expected ratio 2.00 Measured ratio 2.00
>> killing MZ
>> killed MZ
>> killing MZ
>> killed MZ
>> root@defiant:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/net/forwarding#
>>
>>> That would imply that the reproducer needs to include the previous tests as
>>> well.
>>
>> This is entirely possible, as timeouts and CTRL+C events do not seem to be caught
>> and the cleanup is not done ...
>>
>> sch_ets_core.sh:    trap cleanup EXIT
>>
>> Some tests time out even after settings:timeout=240, so IMHO this should be taken into account.
>>
>> Best regards,
>> Mirsad Todorovac
>>
>>> It looks like the test is stuck in ets_test_mixed in classifier_mode.
>>> A way to run just this test would be:
>>>
>>>      TESTS="classifier_mode ets_test_mixed" ./sch_ets.sh
>>>
>>> Looking at the code, the only place that I can see that waits on
>>> anything is the "{ kill %% && wait %%; } 2>/dev/null" line in
>>> stop_traffic() (in lib.sh). Maybe something like this would let
>>> us see if that's the case:
>>>
>>> modified   tools/testing/selftests/net/forwarding/lib.sh
>>> @@ -1468,8 +1470,10 @@ start_tcp_traffic()
>>>   stop_traffic()
>>>   {
>>> +    echo killing MZ
>>>       # Suppress noise from killing mausezahn.
>>>       { kill %% && wait %%; } 2>/dev/null
>>> +    echo killed MZ
>>>   }
> 
> FYI, this is the [incomplete] list of the tests that time out even after
> being assigned long timeout of 240s instead of default.
> 
> marvin@defiant:~/linux/kernel/linux_torvalds$ grep TIMEOUT ../kselftest-6.5-rc2-net-forwarding-8.log
> not ok 13 selftests: net/forwarding: custom_multipath_hash.sh # TIMEOUT 240 seconds
> not ok 18 selftests: net/forwarding: gre_custom_multipath_hash.sh # TIMEOUT 240 seconds
> not ok 19 selftests: net/forwarding: gre_inner_v4_multipath.sh # TIMEOUT 240 seconds
> not ok 21 selftests: net/forwarding: gre_multipath_nh_res.sh # TIMEOUT 240 seconds
> not ok 22 selftests: net/forwarding: gre_multipath_nh.sh # TIMEOUT 240 seconds
> not ok 27 selftests: net/forwarding: ip6gre_custom_multipath_hash.sh # TIMEOUT 240 seconds
> not ok 34 selftests: net/forwarding: ip6gre_inner_v4_multipath.sh # TIMEOUT 240 seconds
> not ok 58 selftests: net/forwarding: no_forwarding.sh # TIMEOUT 240 seconds
> not ok 67 selftests: net/forwarding: router_mpath_nh_res.sh # TIMEOUT 240 seconds
> not ok 68 selftests: net/forwarding: router_mpath_nh.sh # TIMEOUT 240 seconds
> not ok 70 selftests: net/forwarding: router_multipath.sh # TIMEOUT 240 seconds
> marvin@defiant:~/linux/kernel/linux_torvalds$

The test seem to be stuck despite adding SIGTERM cleanup to all tests
that timed out:

# selftests: net/forwarding: sch_ets.sh
# TEST: ping vlan 10                                                  [ OK ]
# TEST: ping vlan 11                                                  [ OK ]
# TEST: ping vlan 12                                                  [ OK ]
# Running in priomap mode
# Testing ets bands 3 strict 3, streams 0 1
# TEST: band 0                                                        [ OK ]
# INFO: Expected ratio >95% Measured ratio 100.00
# TEST: band 1                                                        [ OK ]
# INFO: Expected ratio <5% Measured ratio 0
# Testing ets bands 3 strict 3, streams 1 2
# TEST: band 1                                                        [ OK ]
# INFO: Expected ratio >95% Measured ratio 100.00
# TEST: band 2                                                        [ OK ]
# INFO: Expected ratio <5% Measured ratio 0
# Testing ets bands 4 strict 1 quanta 5000 2500 1500, streams 0 1
# TEST: band 0                                                        [ OK ]
# INFO: Expected ratio >95% Measured ratio 100.00
# TEST: band 1                                                        [ OK ]
# INFO: Expected ratio <5% Measured ratio 0
# Testing ets bands 4 strict 1 quanta 5000 2500 1500, streams 1 2
# TEST: bands 1:2                                                     [ OK ]
# INFO: Expected ratio 2.00 Measured ratio 2.00
# Testing ets bands 3 quanta 3300 3300 3300, streams 0 1 2
# TEST: bands 0:1                                                     [ OK ]
# INFO: Expected ratio 1.00 Measured ratio .99
# TEST: bands 0:2                                                     [ OK ]
# INFO: Expected ratio 1.00 Measured ratio .99
# Testing ets bands 3 quanta 5000 3500 1500, streams 0 1 2
# TEST: bands 0:1                                                     [ OK ]
# INFO: Expected ratio 1.42 Measured ratio 1.42
# TEST: bands 0:2                                                     [ OK ]
# INFO: Expected ratio 3.33 Measured ratio 3.33
# Testing ets bands 3 quanta 5000 8000 1500, streams 0 1 2
# TEST: bands 0:1                                                     [ OK ]
# INFO: Expected ratio 1.60 Measured ratio 1.59
# TEST: bands 0:2                                                     [ OK ]
# INFO: Expected ratio 3.33 Measured ratio 3.33
# Testing ets bands 2 quanta 5000 2500, streams 0 1
# TEST: bands 0:1                                                     [ OK ]
# INFO: Expected ratio 2.00 Measured ratio 1.99
# Running in classifier mode
# Testing ets bands 3 strict 3, streams 0 1
# TEST: band 0                                                        [ OK ]
# INFO: Expected ratio >95% Measured ratio 100.00
# TEST: band 1                                                        [ OK ]
# INFO: Expected ratio <5% Measured ratio 0
# Testing ets bands 3 strict 3, streams 1 2
# TEST: band 1                                                        [ OK ]
# INFO: Expected ratio >95% Measured ratio 100.00
# TEST: band 2                                                        [ OK ]
# INFO: Expected ratio <5% Measured ratio 0
# Testing ets bands 4 strict 1 quanta 5000 2500 1500, streams 0 1

What is happening is a stuck mousezahn loop:

root      558266    2732  0 01:17 pts/2    00:00:23 mausezahn veth0.10 -p 8000 -A 192.0.2.1 -B 192.0.2.2 -c 0 -a own -b ba:33:37:81:dc:5
root      558273    2732  0 01:17 pts/2    00:00:23 mausezahn veth0.11 -p 8000 -A 192.0.2.17 -B 192.0.2.18 -c 0 -a own -b ba:33:37:81:dc

$ sudo strace -p 558266
ioctl(5, SIOCGIFINDEX, {ifr_name="veth0.10"}) = -1 ENODEV (No such device)
ioctl(5, SIOCGIFINDEX, {ifr_name="veth0.10"}) = -1 ENODEV (No such device)
ioctl(5, SIOCGIFINDEX, {ifr_name="veth0.10"}) = -1 ENODEV (No such device)
ioctl(5, SIOCGIFINDEX, {ifr_name="veth0.10"}) = -1 ENODEV (No such device)
ioctl(5, SIOCGIFINDEX, {ifr_name="veth0.10"}) = -1 ENODEV (No such device)
ioctl(5, SIOCGIFINDEX, {ifr_name="veth0.10"}) = -1 ENODEV (No such device)
ioctl(5, SIOCGIFINDEX, {ifr_name="veth0.10"}) = -1 ENODEV (No such device)
ioctl(5, SIOCGIFINDEX, {ifr_name="veth0.10"}) = -1 ENODEV (No such device)
ioctl(5, SIOCGIFINDEX, {ifr_name="veth0.10"}) = -1 ENODEV (No such device)
ioctl(5, SIOCGIFINDEX, {ifr_name="veth0.10"}) = -1 ENODEV (No such device)
ioctl(5, SIOCGIFINDEX, {ifr_name="veth0.10"}) = -1 ENODEV (No such device)
ioctl(5, SIOCGIFINDEX, {ifr_name="veth0.10"}) = -1 ENODEV (No such device)
ioctl(5, SIOCGIFINDEX, {ifr_name="veth0.10"}) = -1 ENODEV (No such device)
ioctl(5, SIOCGIFINDEX, {ifr_name="veth0.10"}) = -1 ENODEV (No such device)
ioctl(5, SIOCGIFINDEX, {ifr_name="veth0.10"}) = -1 ENODEV (No such device)
ioctl(5, SIOCGIFINDEX, {ifr_name="veth0.10"}) = -1 ENODEV (No such device)
ioctl(5, SIOCGIFINDEX, {ifr_name="veth0.10"}) = -1 ENODEV (No such device)
ioctl(5, SIOCGIFINDEX, {ifr_name="veth0.10"}) = -1 ENODEV (No such device)
ioctl(5, SIOCGIFINDEX, {ifr_name="veth0.10"}) = -1 ENODEV (No such device)
ioctl(5, SIOCGIFINDEX, {ifr_name="veth0.10"}) = -1 ENODEV (No such device)
ioctl(5, SIOCGIFINDEX, {ifr_name="veth0.10"}) = -1 ENODEV (No such device)
ioctl(5, SIOCGIFINDEX, {ifr_name="veth0.10"}) = -1 ENODEV (No such device)

I am not sure if this will ever complete, or is it a runaway loop?

Probably it is stuck, for nothing was written to the test log for 71 minutes.

I hope we are coming closer to the cause.

Previously I didn't figure out what hanged.

FWIW, I will post the patches for the scripts that timed out for your review.

Kind regards,
Mirsad
