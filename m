Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A7575D5E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jul 2023 22:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjGUUmH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jul 2023 16:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGUUmG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jul 2023 16:42:06 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E9F1701;
        Fri, 21 Jul 2023 13:42:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id AF65B6016E;
        Fri, 21 Jul 2023 22:42:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689972121; bh=/pCD6r+uWcgcbJBvv+RMNGX/VP1LIRf/EeVfdY2/j1o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Vqu5UNXAfIwgm8ozV8tHlhsazqGY5uO6gEvoXlq/ul0j+JUBcXbNwwYcz6aJVCrbf
         0jsOTngqR8Snc0jE9FEXda9HgiivVDDUiSlqjtM+3KKtJsclJR8yuS6OQgAzmkNaqs
         KyJRasdre8cPvcaGFN7ZosriKhnVdMjzCZgcvxpvZEcvOKSWddrcZn0k56+FKWtPkg
         TfnIL173OwsTuSCNFhLaptXCWGHVCXouGqtdRcKHRzcCPQ+YALDrtGmI3JCI5POxJu
         BqwmGmy+zhpoDId1a9wE/fQcAiYA59waKd22gltZrFdbW+jJXVavNJ0NElzGw2zZfq
         sgSyqZgoIDkUw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Mdi3nLcEsURb; Fri, 21 Jul 2023 22:41:59 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 962106015F;
        Fri, 21 Jul 2023 22:41:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689972118; bh=/pCD6r+uWcgcbJBvv+RMNGX/VP1LIRf/EeVfdY2/j1o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Qb0LDjYU7y18cTc45hC9yGsaDmroUgyA0RyDOxkDDshIqABCO7ZCNQtq4eZ02t/Mn
         sl7zjOhMbSeKBnj+olDywfOatnzDruBOhh18pRw18PfXcxdpqRR/ReWdOCcczGSuV9
         zdrVqym5fU3qxJ+CYuTwfiEGsVxN5b1RI5aPSUqMPX8DdWh6P0Ub1CU4COm0soAog2
         yJZrm6vCNK2QK1DnQVSa2XHsGZsV4X3HYcQiZ304sVTC9+fJ9edEnmksLXDeLmEcts
         lKEPU3hMlPmMeeKrgkbMZQ3mOX/nDLsFwJh/6eRCI9IsnkvIByCHsg3VI+l140JO0P
         xtFCSoCOYN6Ig==
Message-ID: <486499a2-68ca-8327-0dec-c534ee1e65f3@alu.unizg.hr>
Date:   Fri, 21 Jul 2023 22:41:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PROBLEM] selftests: net/forwarding/*.sh: 'Command line is not
 complete. Try option "help"'
Content-Language: en-US
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
 <1c2a2d56-95a0-72f8-23a0-1e186e6443a2@alu.unizg.hr>
 <ZLfeJzFJ1HEeooZR@shredder>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZLfeJzFJ1HEeooZR@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/19/23 14:59, Ido Schimmel wrote:
> On Tue, Jul 18, 2023 at 08:39:33PM +0200, Mirsad Todorovac wrote:
>> There is also a gotcha here: you do not delete all veths:
>>
>> root@defiant:# ip link show
>> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
>>      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>> 2: enp16s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
>>      link/ether 9c:6b:00:01:fb:80 brd ff:ff:ff:ff:ff:ff
>> root@defiant:# ./bridge_igmp.sh
> 
> [...]
> 
>> root@defiant:# ip link show
>> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
>>      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>> 2: enp16s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
>>      link/ether 9c:6b:00:01:fb:80 brd ff:ff:ff:ff:ff:ff
>> 3: veth1@veth0: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>>      link/ether b6:46:e6:4c:e4:00 brd ff:ff:ff:ff:ff:ff
>> 4: veth0@veth1: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>>      link/ether 2e:ff:7f:8a:6b:d4 brd ff:ff:ff:ff:ff:ff
>> 5: veth3@veth2: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>>      link/ether ba:33:37:81:dc:5b brd ff:ff:ff:ff:ff:ff
>> 6: veth2@veth3: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>>      link/ether f2:fd:0a:9b:94:17 brd ff:ff:ff:ff:ff:ff
>> root@defiant:#
> 
> These tests can be run with veth pairs or with loop backed physical
> ports. We can't delete the latter and I don't see a clean way to delete
> the veth pairs.
> 
> The following patch [1] changes the default to not create interfaces so
> that by default these tests will be skipped [2]. Those who care about
> running the tests can create a forwarding.config file (using
> forwarding.config.sample as an example) and either create the veth pairs
> themselves or opt-in for the interfaces to be created automatically
> (setting NETIF_CREATE=yes), but not deleted.
> 
> [1]
> diff --git a/tools/testing/selftests/net/forwarding/forwarding.config.sample b/tools/testing/selftests/net/forwarding/forwarding.config.sample
> index 4a546509de90..b72f08dfd491 100644
> --- a/tools/testing/selftests/net/forwarding/forwarding.config.sample
> +++ b/tools/testing/selftests/net/forwarding/forwarding.config.sample
> @@ -36,8 +36,9 @@ PAUSE_ON_FAIL=no
>   PAUSE_ON_CLEANUP=no
>   # Type of network interface to create
>   NETIF_TYPE=veth
> -# Whether to create virtual interfaces (veth) or not
> -NETIF_CREATE=yes
> +# Whether to create virtual interfaces (veth) or not. Created interfaces are
> +# not automatically deleted
> +NETIF_CREATE=no
>   # Timeout (in seconds) before ping exits regardless of how many packets have
>   # been sent or received
>   PING_TIMEOUT=5
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 9ddb68dd6a08..1b1bc634c63e 100755
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -17,7 +17,7 @@ WAIT_TIME=${WAIT_TIME:=5}
>   PAUSE_ON_FAIL=${PAUSE_ON_FAIL:=no}
>   PAUSE_ON_CLEANUP=${PAUSE_ON_CLEANUP:=no}
>   NETIF_TYPE=${NETIF_TYPE:=veth}
> -NETIF_CREATE=${NETIF_CREATE:=yes}
> +NETIF_CREATE=${NETIF_CREATE:=no}
>   MCD=${MCD:=smcrouted}
>   MC_CLI=${MC_CLI:=smcroutectl}
>   PING_COUNT=${PING_COUNT:=10}
> 
> [2]
> # ./bridge_igmp.sh
> SKIP: could not find all required interfaces

Hi, Ido,

Please would you consider making a formal patch, so the vanilla 'make kselftest'
run would have some sensible defaults?

I am really interested in the network stack working right, though I really do
not have much opportunities testing like high speed links and bonded eth adapters :-(

Maybe that'll come :-/

Kind regards,
Mirsad
