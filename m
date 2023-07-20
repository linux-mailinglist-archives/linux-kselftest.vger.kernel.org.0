Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A000F75B422
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 18:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjGTQ0O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 12:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjGTQ0J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 12:26:09 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A0C1FC8;
        Thu, 20 Jul 2023 09:26:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id A9A4A60171;
        Thu, 20 Jul 2023 18:26:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689870360; bh=NEI6e7DDmJGQzGyTC+xQLiypOjyhxqGecFp3wbDma+U=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=vwPCbqQRi/hgnOAoSrGHI4y+TSkWpuE96w9EvRHl5vTkYLvp9/8HnCs4BhYe2chYE
         IjrwGWD028ylIcLHv8Y3uJEfCgCNYZFNIbFGFB1Ytr25CCeVeDGQ+ILvyJf/7ZMElI
         iUHoH2NeAFmzoLXJCMKaRbyjGkGNx4AJOIETrQMgERwEbhCEmQ/Fzs47lsSExYHVMV
         tbyl5s9jLArxsxgQdRQt3UQJLnYOETPnKW/xN28/G2ilz6pyloZ5FcKvCIHCDBQLZ4
         pv2a32t3C6QzMKW3uMgiVFGAtGgqdtsWrnkOULuAEWwGoSJPKXxdBBwlqF+9Me9j1C
         q8d9zC0rc+/cw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CLOnXUoUF6be; Thu, 20 Jul 2023 18:25:57 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 924E86016E;
        Thu, 20 Jul 2023 18:25:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689870357; bh=NEI6e7DDmJGQzGyTC+xQLiypOjyhxqGecFp3wbDma+U=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=T06xtu2TschfPuXRVCylOYeG2OeJra4PNhMl62B9qcq8Bjo5+K1oMfarLKsJdVNeb
         HSy27u+ngu3w2QhFWVzxftA7smrwIBrlOjnoeF9Bf8sGF66aoYSgv5Xhq7sjSPfnjk
         0mRamR4Cp5PAIdQGOrpdFv0l2VtTc2ih7jjN6YmncFe1boE5aOVyEgRYdgwtqwxpkj
         BMg4NViELHEbXtWFr9MZOrrHdOF5ZMJkUnBepMtOwwTtsn5WL4me8s3hiHgoovgTCg
         XmSTKqmMalkx4BR/UjnMySoIT4KKEam/e2MkqnIrSY01AW2IKHc/6U7isntLMc5lSW
         jDXVy9l5J1kCg==
Message-ID: <6c871d89-390d-41ae-ef48-6cd12b99fd74@alu.unizg.hr>
Date:   Thu, 20 Jul 2023 18:25:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PROBLEM] seltests: net/forwarding/sch_ets.sh [HANG]
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
Content-Language: en-US
In-Reply-To: <580b9f28-7a68-e618-b2d5-b8663386aa12@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/20/23 18:07, Mirsad Todorovac wrote:
> On 7/20/23 11:43, Petr Machata wrote:
>>
>> Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr> writes:
>>
>>> Using the same config for 6.5-rc2 on Ubuntu 22.04 LTS and 22.10, the execution
>>> stop at the exact same line on both boxes (os I reckon it is more than an
>>> accident):
>>>
>>> # selftests: net/forwarding: sch_ets.sh
>>> # TEST: ping vlan 10                                                  [ OK ]
>>> # TEST: ping vlan 11                                                  [ OK ]
>>> # TEST: ping vlan 12                                                  [ OK ]
>>> # Running in priomap mode
>>> # Testing ets bands 3 strict 3, streams 0 1
>>> # TEST: band 0                                                        [ OK ]
>>> # INFO: Expected ratio >95% Measured ratio 100.00
>>> # TEST: band 1                                                        [ OK ]
>>> # INFO: Expected ratio <5% Measured ratio 0
>>> # Testing ets bands 3 strict 3, streams 1 2
>>> # TEST: band 1                                                        [ OK ]
>>> # INFO: Expected ratio >95% Measured ratio 100.00
>>> # TEST: band 2                                                        [ OK ]
>>> # INFO: Expected ratio <5% Measured ratio 0
>>> # Testing ets bands 4 strict 1 quanta 5000 2500 1500, streams 0 1
>>> # TEST: band 0                                                        [ OK ]
>>> # INFO: Expected ratio >95% Measured ratio 100.00
>>> # TEST: band 1                                                        [ OK ]
>>> # INFO: Expected ratio <5% Measured ratio 0
>>> # Testing ets bands 4 strict 1 quanta 5000 2500 1500, streams 1 2
>>> # TEST: bands 1:2                                                     [ OK ]
>>> # INFO: Expected ratio 2.00 Measured ratio 1.99
>>> # Testing ets bands 3 quanta 3300 3300 3300, streams 0 1 2
>>> # TEST: bands 0:1                                                     [ OK ]
>>> # INFO: Expected ratio 1.00 Measured ratio .99
>>> # TEST: bands 0:2                                                     [ OK ]
>>> # INFO: Expected ratio 1.00 Measured ratio 1.00
>>> # Testing ets bands 3 quanta 5000 3500 1500, streams 0 1 2
>>> # TEST: bands 0:1                                                     [ OK ]
>>> # INFO: Expected ratio 1.42 Measured ratio 1.42
>>> # TEST: bands 0:2                                                     [ OK ]
>>> # INFO: Expected ratio 3.33 Measured ratio 3.33
>>> # Testing ets bands 3 quanta 5000 8000 1500, streams 0 1 2
>>> # TEST: bands 0:1                                                     [ OK ]
>>> # INFO: Expected ratio 1.60 Measured ratio 1.59
>>> # TEST: bands 0:2                                                     [ OK ]
>>> # INFO: Expected ratio 3.33 Measured ratio 3.33
>>> # Testing ets bands 2 quanta 5000 2500, streams 0 1
>>> # TEST: bands 0:1                                                     [ OK ]
>>> # INFO: Expected ratio 2.00 Measured ratio 1.99
>>> # Running in classifier mode
>>> # Testing ets bands 3 strict 3, streams 0 1
>>> # TEST: band 0                                                        [ OK ]
>>> # INFO: Expected ratio >95% Measured ratio 100.00
>>> # TEST: band 1                                                        [ OK ]
>>> # INFO: Expected ratio <5% Measured ratio 0
>>> # Testing ets bands 3 strict 3, streams 1 2
>>> # TEST: band 1                                                        [ OK ]
>>> # INFO: Expected ratio >95% Measured ratio 100.00
>>> # TEST: band 2                                                        [ OK ]
>>> # INFO: Expected ratio <5% Measured ratio 0
>>> # Testing ets bands 4 strict 1 quanta 5000 2500 1500, streams 0 1
>>>
>>> I tried to run 'set -x' enabled version standalone, but that one finished
>>> correctly (?).
>>>
>>> It could be something previous scripts left, but right now I don't have a clue.
>>> I can attempt to rerun all tests with sch_ets.sh bash 'set -x' enabled later today.
>>
>> If you run it standalone without set -x, does it finish as well?
> 
> Added that. Yes, standlone run finishes correctly, with or without 'set -x':
> 
> root@defiant:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/net/forwarding# ./sch_ets.sh
> TEST: ping vlan 10                                                  [ OK ]
> TEST: ping vlan 11                                                  [ OK ]
> TEST: ping vlan 12                                                  [ OK ]
> Running in priomap mode
> Testing ets bands 3 strict 3, streams 0 1
> TEST: band 0                                                        [ OK ]
> INFO: Expected ratio >95% Measured ratio 100.00
> TEST: band 1                                                        [ OK ]
> INFO: Expected ratio <5% Measured ratio 0
> killing MZ
> killed MZ
> killing MZ
> killed MZ
> Testing ets bands 3 strict 3, streams 1 2
> TEST: band 1                                                        [ OK ]
> INFO: Expected ratio >95% Measured ratio 100.00
> TEST: band 2                                                        [ OK ]
> INFO: Expected ratio <5% Measured ratio 0
> killing MZ
> killed MZ
> killing MZ
> killed MZ
> Testing ets bands 4 strict 1 quanta 5000 2500 1500, streams 0 1
> TEST: band 0                                                        [ OK ]
> INFO: Expected ratio >95% Measured ratio 100.00
> TEST: band 1                                                        [ OK ]
> INFO: Expected ratio <5% Measured ratio 0
> killing MZ
> killed MZ
> killing MZ
> killed MZ
> Testing ets bands 4 strict 1 quanta 5000 2500 1500, streams 1 2
> TEST: bands 1:2                                                     [ OK ]
> INFO: Expected ratio 2.00 Measured ratio 1.99
> killing MZ
> killed MZ
> killing MZ
> killed MZ
> Testing ets bands 3 quanta 3300 3300 3300, streams 0 1 2
> TEST: bands 0:1                                                     [ OK ]
> INFO: Expected ratio 1.00 Measured ratio 1.00
> TEST: bands 0:2                                                     [ OK ]
> INFO: Expected ratio 1.00 Measured ratio .99
> killing MZ
> killed MZ
> killing MZ
> killed MZ
> killing MZ
> killed MZ
> Testing ets bands 3 quanta 5000 3500 1500, streams 0 1 2
> TEST: bands 0:1                                                     [ OK ]
> INFO: Expected ratio 1.42 Measured ratio 1.42
> TEST: bands 0:2                                                     [ OK ]
> INFO: Expected ratio 3.33 Measured ratio 3.33
> killing MZ
> killed MZ
> killing MZ
> killed MZ
> killing MZ
> killed MZ
> Testing ets bands 3 quanta 5000 8000 1500, streams 0 1 2
> TEST: bands 0:1                                                     [ OK ]
> INFO: Expected ratio 1.60 Measured ratio 1.59
> TEST: bands 0:2                                                     [ OK ]
> INFO: Expected ratio 3.33 Measured ratio 3.33
> killing MZ
> killed MZ
> killing MZ
> killed MZ
> killing MZ
> killed MZ
> Testing ets bands 2 quanta 5000 2500, streams 0 1
> TEST: bands 0:1                                                     [ OK ]
> INFO: Expected ratio 2.00 Measured ratio 1.99
> killing MZ
> killed MZ
> killing MZ
> killed MZ
> Running in classifier mode
> Testing ets bands 3 strict 3, streams 0 1
> TEST: band 0                                                        [ OK ]
> INFO: Expected ratio >95% Measured ratio 100.00
> TEST: band 1                                                        [ OK ]
> INFO: Expected ratio <5% Measured ratio 0
> killing MZ
> killed MZ
> killing MZ
> killed MZ
> Testing ets bands 3 strict 3, streams 1 2
> TEST: band 1                                                        [ OK ]
> INFO: Expected ratio >95% Measured ratio 100.00
> TEST: band 2                                                        [ OK ]
> INFO: Expected ratio <5% Measured ratio 0
> killing MZ
> killed MZ
> killing MZ
> killed MZ
> Testing ets bands 4 strict 1 quanta 5000 2500 1500, streams 0 1
> TEST: band 0                                                        [ OK ]
> INFO: Expected ratio >95% Measured ratio 100.00
> TEST: band 1                                                        [ OK ]
> INFO: Expected ratio <5% Measured ratio 0
> killing MZ
> killed MZ
> killing MZ
> killed MZ
> Testing ets bands 4 strict 1 quanta 5000 2500 1500, streams 1 2
> TEST: bands 1:2                                                     [ OK ]
> INFO: Expected ratio 2.00 Measured ratio 1.99
> killing MZ
> killed MZ
> killing MZ
> killed MZ
> Testing ets bands 3 quanta 3300 3300 3300, streams 0 1 2
> TEST: bands 0:1                                                     [ OK ]
> INFO: Expected ratio 1.00 Measured ratio .99
> TEST: bands 0:2                                                     [ OK ]
> INFO: Expected ratio 1.00 Measured ratio .99
> killing MZ
> killed MZ
> killing MZ
> killed MZ
> killing MZ
> killed MZ
> Testing ets bands 3 quanta 5000 3500 1500, streams 0 1 2
> TEST: bands 0:1                                                     [ OK ]
> INFO: Expected ratio 1.42 Measured ratio 1.42
> TEST: bands 0:2                                                     [ OK ]
> INFO: Expected ratio 3.33 Measured ratio 3.33
> killing MZ
> killed MZ
> killing MZ
> killed MZ
> killing MZ
> killed MZ
> Testing ets bands 3 quanta 5000 8000 1500, streams 0 1 2
> TEST: bands 0:1                                                     [ OK ]
> INFO: Expected ratio 1.60 Measured ratio 1.60
> TEST: bands 0:2                                                     [ OK ]
> INFO: Expected ratio 3.33 Measured ratio 3.33
> killing MZ
> killed MZ
> killing MZ
> killed MZ
> killing MZ
> killed MZ
> Testing ets bands 2 quanta 5000 2500, streams 0 1
> TEST: bands 0:1                                                     [ OK ]
> INFO: Expected ratio 2.00 Measured ratio 2.00
> killing MZ
> killed MZ
> killing MZ
> killed MZ
> root@defiant:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/net/forwarding#
> 
>> That would imply that the reproducer needs to include the previous tests as
>> well.
> 
> This is entirely possible, as timeouts and CTRL+C events do not seem to be caught
> and the cleanup is not done ...
> 
> sch_ets_core.sh:    trap cleanup EXIT
> 
> Some tests time out even after settings:timeout=240, so IMHO this should be taken into account.
> 
> Best regards,
> Mirsad Todorovac
> 
>> It looks like the test is stuck in ets_test_mixed in classifier_mode.
>> A way to run just this test would be:
>>
>>      TESTS="classifier_mode ets_test_mixed" ./sch_ets.sh
>>
>> Looking at the code, the only place that I can see that waits on
>> anything is the "{ kill %% && wait %%; } 2>/dev/null" line in
>> stop_traffic() (in lib.sh). Maybe something like this would let
>> us see if that's the case:
>>
>> modified   tools/testing/selftests/net/forwarding/lib.sh
>> @@ -1468,8 +1470,10 @@ start_tcp_traffic()
>>   stop_traffic()
>>   {
>> +    echo killing MZ
>>       # Suppress noise from killing mausezahn.
>>       { kill %% && wait %%; } 2>/dev/null
>> +    echo killed MZ
>>   }

FYI, this is the [incomplete] list of the tests that time out even after
being assigned long timeout of 240s instead of default.

marvin@defiant:~/linux/kernel/linux_torvalds$ grep TIMEOUT ../kselftest-6.5-rc2-net-forwarding-8.log
not ok 13 selftests: net/forwarding: custom_multipath_hash.sh # TIMEOUT 240 seconds
not ok 18 selftests: net/forwarding: gre_custom_multipath_hash.sh # TIMEOUT 240 seconds
not ok 19 selftests: net/forwarding: gre_inner_v4_multipath.sh # TIMEOUT 240 seconds
not ok 21 selftests: net/forwarding: gre_multipath_nh_res.sh # TIMEOUT 240 seconds
not ok 22 selftests: net/forwarding: gre_multipath_nh.sh # TIMEOUT 240 seconds
not ok 27 selftests: net/forwarding: ip6gre_custom_multipath_hash.sh # TIMEOUT 240 seconds
not ok 34 selftests: net/forwarding: ip6gre_inner_v4_multipath.sh # TIMEOUT 240 seconds
not ok 58 selftests: net/forwarding: no_forwarding.sh # TIMEOUT 240 seconds
not ok 67 selftests: net/forwarding: router_mpath_nh_res.sh # TIMEOUT 240 seconds
not ok 68 selftests: net/forwarding: router_mpath_nh.sh # TIMEOUT 240 seconds
not ok 70 selftests: net/forwarding: router_multipath.sh # TIMEOUT 240 seconds
marvin@defiant:~/linux/kernel/linux_torvalds$

Hope this helps.

Best regards,
Mirsad Todorovac
