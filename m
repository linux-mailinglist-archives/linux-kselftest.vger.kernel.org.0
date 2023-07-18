Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3367584F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 20:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjGRSjz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 14:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjGRSju (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 14:39:50 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAF1F9;
        Tue, 18 Jul 2023 11:39:48 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id AAAD660173;
        Tue, 18 Jul 2023 20:39:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689705586; bh=y8LKM/0CokKO2vVzIn2LDXeZ5ru9UAbuIkefHGPIjm4=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=0r83uC3SXNE1V7UD/Y2I2f/LbJkRGPCF9dyh+rMv8N192XY4z7NyuyFhCMnlT9PDI
         I23jHs3Q3FN0o6MPsUwh1Xva+cPSDOwoUABiZ508xYz6mzgEMBi8/y23WNm2MUIOSq
         nqEo/Ew/FHhHG+0KOt4NxtGIU7a5A0T0dnozud89jsy0a1PE9+MCgUJLkJiLdEsaJo
         VFUdwjvdiW6pkPBLEODeEbBT9wkaQQuu/z1N+8HIcr7qCrE7WpjfuVXxqInQ7hqA7J
         NsD3lHXKRzOciTNlEC48afYYO4qYM3AkvIdR+h3z/LUn7T0WjyOtprwSHtAu/xDhi/
         aUpe7vlVBe4Xg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zhmTaWmv8Cp7; Tue, 18 Jul 2023 20:39:44 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 1E93F60171;
        Tue, 18 Jul 2023 20:39:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689705583; bh=y8LKM/0CokKO2vVzIn2LDXeZ5ru9UAbuIkefHGPIjm4=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=diwIpzLCpPKaQey0gkERET0dKbleabhoImIHjU+FNwr5NnbDA/ezscEjrg6TseVlQ
         HuNvVTp0Da5fEALfq/AQZxdglu6VAfJrOTNEfAeBASiVKJnTWL2Pp9I+QaiJ+xc37+
         mf4NkuJDJFplHqnmEtJMdTXJhKaaSfNjKNibu+M+DlWg0A2d3CSR3dToa7OpKJgq+E
         hKEL77KvqkiNggtxDpPY5Lh/pgT3K1IfCB/wgXN7un49XexgmH9Cccp5l1qTZNxyEm
         OjTVkvaRlSj0Cjblo6PFnLUsyNSjE1UeF3bcjjRdDndyAw5e2GNm9ugSmTfNXMsT7O
         RHP5DtUcUFEUw==
Message-ID: <1c2a2d56-95a0-72f8-23a0-1e186e6443a2@alu.unizg.hr>
Date:   Tue, 18 Jul 2023 20:39:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PROBLEM] selftests: net/forwarding/*.sh: 'Command line is not
 complete. Try option "help"'
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Ido Schimmel <idosch@idosch.org>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        petrm@nvidia.com
References: <856d454e-f83c-20cf-e166-6dc06cbc1543@alu.unizg.hr>
 <ZLY9yiaVwCGy5H3R@shredder>
 <8d149f8c-818e-d141-a0ce-a6bae606bc22@alu.unizg.hr>
Content-Language: en-US
In-Reply-To: <8d149f8c-818e-d141-a0ce-a6bae606bc22@alu.unizg.hr>
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

On 7/18/23 20:19, Mirsad Todorovac wrote:
> On 7/18/23 09:22, Ido Schimmel wrote:
>> On Mon, Jul 17, 2023 at 10:51:04PM +0200, Mirsad Todorovac wrote:
>>> Tests fail with error message:
>>>
>>> Command line is not complete. Try option "help"
>>> Failed to create netif
>>>
>>> The script
>>>
>>> # tools/testing/seltests/net/forwarding/bridge_igmp.sh
>>>
>>> bash `set -x` ends with an error:
>>>
>>> ++ create_netif_veth
>>> ++ local i
>>> ++ (( i = 1 ))
>>> ++ (( i <= NUM_NETIFS ))
>>> ++ local j=2
>>> ++ ip link show dev
>>> ++ [[ 255 -ne 0 ]]
>>> ++ ip link add type veth peer name
>>> Command line is not complete. Try option "help"
>>> ++ [[ 255 -ne 0 ]]
>>> ++ echo 'Failed to create netif'
>>> Failed to create netif
>>> ++ exit 1
>>>
>>> The problem seems to be linked with this piece of code of "lib.sh":
>>>
>>> create_netif_veth()
>>> {
>>>          local i
>>>
>>>          for ((i = 1; i <= NUM_NETIFS; ++i)); do
>>>                  local j=$((i+1))
>>>
>>>                  ip link show dev ${NETIFS[p$i]} &> /dev/null
>>>                  if [[ $? -ne 0 ]]; then
>>>                          ip link add ${NETIFS[p$i]} type veth \
>>>                                  peer name ${NETIFS[p$j]}
>>>                          if [[ $? -ne 0 ]]; then
>>>                                  echo "Failed to create netif"
>>>                                  exit 1
>>>                          fi
>>>                  fi
>>>                  i=$j
>>>          done
>>> }
>>>
>>> Somehow, ${NETIFS[p$i]} is evaluated to an empty string?
>>
>> You need to provide a configuration file in
>> tools/testing/selftests/net/forwarding/forwarding.config. See
>> tools/testing/selftests/net/forwarding/forwarding.config.sample for
>> example.
>>
>> Another option is to provide the interfaces on the command line.
>>
>> ./bridge_igmp.sh veth0 veth1 veth2 veth3
>>
>> If no configuration file is present, we can try to assume that the
>> tests are meant to be run with veth pairs and not with physical
>> loopbacks. Something like:
>>
>> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
>> index 71f7c0c49677..5b0183013017 100755
>> --- a/tools/testing/selftests/net/forwarding/lib.sh
>> +++ b/tools/testing/selftests/net/forwarding/lib.sh
>> @@ -16,8 +16,6 @@ TEAMD=${TEAMD:=teamd}
>>   WAIT_TIME=${WAIT_TIME:=5}
>>   PAUSE_ON_FAIL=${PAUSE_ON_FAIL:=no}
>>   PAUSE_ON_CLEANUP=${PAUSE_ON_CLEANUP:=no}
>> -NETIF_TYPE=${NETIF_TYPE:=veth}
>> -NETIF_CREATE=${NETIF_CREATE:=yes}
>>   MCD=${MCD:=smcrouted}
>>   MC_CLI=${MC_CLI:=smcroutectl}
>>   PING_COUNT=${PING_COUNT:=10}
>> @@ -30,6 +28,20 @@ REQUIRE_MZ=${REQUIRE_MZ:=yes}
>>   REQUIRE_MTOOLS=${REQUIRE_MTOOLS:=no}
>>   STABLE_MAC_ADDRS=${STABLE_MAC_ADDRS:=no}
>>   TCPDUMP_EXTRA_FLAGS=${TCPDUMP_EXTRA_FLAGS:=}
>> +NETIF_TYPE=${NETIF_TYPE:=veth}
>> +NETIF_CREATE=${NETIF_CREATE:=yes}
>> +declare -A NETIFS=(
>> +       [p1]=veth0
>> +       [p2]=veth1
>> +       [p3]=veth2
>> +       [p4]=veth3
>> +       [p5]=veth4
>> +       [p6]=veth5
>> +       [p7]=veth6
>> +       [p8]=veth7
>> +       [p9]=veth8
>> +       [p10]=veth9
>> +)
>>   relative_path="${BASH_SOURCE%/*}"
>>   if [[ "$relative_path" == "${BASH_SOURCE}" ]]; then
> 
> This patch appears to work for the first testing script
> 
> root@defiant:# ./bridge_igmp.sh
> TEST: IGMPv2 report 239.10.10.10                                    [ OK ]
> TEST: IGMPv2 leave 239.10.10.10                                     [ OK ]
> TEST: IGMPv3 report 239.10.10.10 is_include                         [ OK ]
> TEST: IGMPv3 report 239.10.10.10 include -> allow                   [ OK ]
> TEST: IGMPv3 report 239.10.10.10 include -> is_include              [ OK ]
> TEST: IGMPv3 report 239.10.10.10 include -> is_exclude              [ OK ]
> TEST: IGMPv3 report 239.10.10.10 include -> to_exclude              [ OK ]
> TEST: IGMPv3 report 239.10.10.10 exclude -> allow                   [ OK ]
> TEST: IGMPv3 report 239.10.10.10 exclude -> is_include              [ OK ]
> TEST: IGMPv3 report 239.10.10.10 exclude -> is_exclude              [ OK ]
> TEST: IGMPv3 report 239.10.10.10 exclude -> to_exclude              [ OK ]
> TEST: IGMPv3 report 239.10.10.10 include -> block                   [ OK ]
> TEST: IGMPv3 report 239.10.10.10 exclude -> block                   [ OK ]
> TEST: IGMPv3 group 239.10.10.10 exclude timeout                     [ OK ]
> TEST: IGMPv3 S,G port entry automatic add to a *,G port             [ OK ]
> root@defiant:#
> 
> However, I suggest setting tools/testing/selftest/net/forwarding/settings:timeout=150 at least,
> because default 45 is premature on my box and it leaves the networking system in an undefined
> state upon exit.

There is also a gotcha here: you do not delete all veths:

root@defiant:# ip link show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: enp16s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
     link/ether 9c:6b:00:01:fb:80 brd ff:ff:ff:ff:ff:ff
root@defiant:# ./bridge_igmp.sh
TEST: IGMPv2 report 239.10.10.10                                    [ OK ]
TEST: IGMPv2 leave 239.10.10.10                                     [ OK ]
TEST: IGMPv3 report 239.10.10.10 is_include                         [ OK ]
TEST: IGMPv3 report 239.10.10.10 include -> allow                   [ OK ]
TEST: IGMPv3 report 239.10.10.10 include -> is_include              [ OK ]
TEST: IGMPv3 report 239.10.10.10 include -> is_exclude              [ OK ]
TEST: IGMPv3 report 239.10.10.10 include -> to_exclude              [ OK ]
TEST: IGMPv3 report 239.10.10.10 exclude -> allow                   [ OK ]
TEST: IGMPv3 report 239.10.10.10 exclude -> is_include              [ OK ]
TEST: IGMPv3 report 239.10.10.10 exclude -> is_exclude              [ OK ]
TEST: IGMPv3 report 239.10.10.10 exclude -> to_exclude              [ OK ]
TEST: IGMPv3 report 239.10.10.10 include -> block                   [ OK ]
TEST: IGMPv3 report 239.10.10.10 exclude -> block                   [ OK ]
TEST: IGMPv3 group 239.10.10.10 exclude timeout                     [ OK ]
TEST: IGMPv3 S,G port entry automatic add to a *,G port             [ OK ]
root@defiant:# ip link show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: enp16s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
     link/ether 9c:6b:00:01:fb:80 brd ff:ff:ff:ff:ff:ff
3: veth1@veth0: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
     link/ether b6:46:e6:4c:e4:00 brd ff:ff:ff:ff:ff:ff
4: veth0@veth1: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
     link/ether 2e:ff:7f:8a:6b:d4 brd ff:ff:ff:ff:ff:ff
5: veth3@veth2: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
     link/ether ba:33:37:81:dc:5b brd ff:ff:ff:ff:ff:ff
6: veth2@veth3: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
     link/ether f2:fd:0a:9b:94:17 brd ff:ff:ff:ff:ff:ff
root@defiant:#

Also, I ran into problems with some other tests, but for documentation sake
I will address the issue in a separate thread.

Best regards,
Mirsad Todorovac

