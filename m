Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633FB769AB7
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 17:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjGaPXo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 11:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGaPXn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 11:23:43 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C199610E3;
        Mon, 31 Jul 2023 08:23:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 8D6C96017F;
        Mon, 31 Jul 2023 17:23:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690817019; bh=ISG2jRu84O8tN50xDVnUgYYjLOV7WKIkKxcodfIlYEQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fv57DVGLvEzKk1Izt27ydCPEXF6Nuv/OV/xQUWoDiv3NvevfgD5aO2Hy0W7Q4tG7M
         Ttjj45mTWAcaCfhSWJFfjWrU/7orVtf+jR3UPn6HfCjSvZlCUbAQTyjcNlQobFF8fb
         xZiicfpv9IYWiKl/vZUIEEFTlKR2UvvCcUOtvKk1AmoyVMPOjoZm23PMMxSGz7PXKZ
         U4zCzxnvVDAiLTYQzlHXwGoCdAnyC3CrIj0WpgLR/YqpZ5rIsIXceCrLf5eoOeZkdQ
         Bm7Fj4LxCBgMXsslQmUZJ0Mgx1ZUFoqA+ht5lE11QxSvk/ZgCjliCKUSC5PZKNKbqF
         GtLmeAfP51aCQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7cjOiumQGmcF; Mon, 31 Jul 2023 17:23:37 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 3F9F560173;
        Mon, 31 Jul 2023 17:23:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690817017; bh=ISG2jRu84O8tN50xDVnUgYYjLOV7WKIkKxcodfIlYEQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LvP8vQ5XgRekhDcciWZXR/hj61jMzI3wku1bjiRW9kHavqUG5+hWdRaxm6y1wxupp
         h+9ybpFDqaYOjJDdgIwWMpOKM4cOU4885W3ueEdXYs3uRlAvGXDuL1oIJptppm7wDb
         qm/5PeYxS7HUaG9j4u9Ky70U7oKubIP/rT+6lFE/pVvaMLwmuOlq3KiACtsMPFFaWp
         +utPu3/rp0EyxKS04qzp8MSKiaGIiXGpCyWuETv1uHWDPcoRqvT9HqCB3IjxfNZSmV
         u25VD8ZcGLS47FPd5jbNO7e/wbrLx0jDqAcg/ZyGB8s+HSCQ/a4V4pqz/tZUldSbEC
         TCFlusaGUo1Aw==
Message-ID: <bdc5e82b-596d-d531-7685-0d1e52f2d125@alu.unizg.hr>
Date:   Mon, 31 Jul 2023 17:23:37 +0200
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
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/31/23 14:02, Ido Schimmel wrote:

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

It is your call, but consider that the majority of testers will use the default setup
and maybe grep "not ok" messages in the log, because the amount of logs is overwhelming.

Knowing that there is "forwarding.config.sample" probably requires in-depth knowledge
of the selftest net/forwarding bundle and maybe direct hint from the developers?

Kind regards,
Mirsad
