Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724D17D3923
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Oct 2023 16:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjJWOTC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Oct 2023 10:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjJWOTB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Oct 2023 10:19:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE60AB3;
        Mon, 23 Oct 2023 07:18:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AD9C433C7;
        Mon, 23 Oct 2023 14:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698070738;
        bh=XKHA+o3oAqp09heCyRAIPWkyf94HR5PsGQ+iB2G7+R4=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=SXqtsBl0acWkhV/sCPXQG+Utt7JaB3KYlIbEyxJC+W54DIqmBKHov+jQIjMU/UItE
         010fYFXToKgIPVNKJXUv2n0OEiBkHvLzMYGp23QH/MVdRaGyJOHDX4dCYJkwDJRF9t
         1O307y6lQQE+RArvnyI0aLLf7tGu5L4bA04vkiwnYAZamzJE9AeTiN45mexw0eavih
         PhUGyPbtMth/t6p6eLmDjDdvFaBPEIJZLOkIBYI4KKoDqV8QjGDWscPiEcDHqsOzF2
         H/UnTpi8unNmg2OUn0Vm3JIXIi+I9Zj/5ij+WrBli8OwrfGwACHmg/hpr4o4BZURKr
         T+05CXxngK04g==
Message-ID: <df63abf1-90cc-4f94-90e4-0ffb44c914f2@kernel.org>
Date:   Mon, 23 Oct 2023 08:18:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests:net change ifconfig with ip command
Content-Language: en-US
To:     Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>,
        davem@davemloft.net, jiri@resnulli.us, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <ZTYc04N9VK7EarHY@nanopsycho>
 <20231023123422.2895-1-swarupkotikalapudi@gmail.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20231023123422.2895-1-swarupkotikalapudi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/23/23 6:34 AM, Swarup Laxman Kotiaklapudi wrote:
> Change ifconfig with ip command,
> on a system where ifconfig is
> not used this script will not
> work correcly.
> 
> Test result with this patchset:
> 
> sudo make TARGETS="net" kselftest
> ....
> TAP version 13
> 1..1
>  timeout set to 1500
>  selftests: net: route_localnet.sh
>  run arp_announce test
>  net.ipv4.conf.veth0.route_localnet = 1
>  net.ipv4.conf.veth1.route_localnet = 1
>  net.ipv4.conf.veth0.arp_announce = 2
>  net.ipv4.conf.veth1.arp_announce = 2
>  PING 127.25.3.14 (127.25.3.14) from 127.25.3.4 veth0: 56(84)
>   bytes of data.
>  64 bytes from 127.25.3.14: icmp_seq=1 ttl=64 time=0.038 ms
>  64 bytes from 127.25.3.14: icmp_seq=2 ttl=64 time=0.068 ms
>  64 bytes from 127.25.3.14: icmp_seq=3 ttl=64 time=0.068 ms
>  64 bytes from 127.25.3.14: icmp_seq=4 ttl=64 time=0.068 ms
>  64 bytes from 127.25.3.14: icmp_seq=5 ttl=64 time=0.068 ms
> 
>  --- 127.25.3.14 ping statistics ---
>  5 packets transmitted, 5 received, 0% packet loss, time 4073ms
>  rtt min/avg/max/mdev = 0.038/0.062/0.068/0.012 ms
>  ok
>  run arp_ignore test
>  net.ipv4.conf.veth0.route_localnet = 1
>  net.ipv4.conf.veth1.route_localnet = 1
>  net.ipv4.conf.veth0.arp_ignore = 3
>  net.ipv4.conf.veth1.arp_ignore = 3
>  PING 127.25.3.14 (127.25.3.14) from 127.25.3.4 veth0: 56(84)
>   bytes of data.
>  64 bytes from 127.25.3.14: icmp_seq=1 ttl=64 time=0.032 ms
>  64 bytes from 127.25.3.14: icmp_seq=2 ttl=64 time=0.065 ms
>  64 bytes from 127.25.3.14: icmp_seq=3 ttl=64 time=0.066 ms
>  64 bytes from 127.25.3.14: icmp_seq=4 ttl=64 time=0.065 ms
>  64 bytes from 127.25.3.14: icmp_seq=5 ttl=64 time=0.065 ms
> 
>  --- 127.25.3.14 ping statistics ---
>  5 packets transmitted, 5 received, 0% packet loss, time 4092ms
>  rtt min/avg/max/mdev = 0.032/0.058/0.066/0.013 ms
>  ok
> ok 1 selftests: net: route_localnet.sh
> ...
> 
> Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
> ---
>  tools/testing/selftests/net/route_localnet.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/route_localnet.sh b/tools/testing/selftests/net/route_localnet.sh
> index 116bfeab72fa..e08701c750e3 100755
> --- a/tools/testing/selftests/net/route_localnet.sh
> +++ b/tools/testing/selftests/net/route_localnet.sh
> @@ -18,8 +18,10 @@ setup() {
>      ip route del 127.0.0.0/8 dev lo table local
>      ip netns exec "${PEER_NS}" ip route del 127.0.0.0/8 dev lo table local
>  
> -    ifconfig veth0 127.25.3.4/24 up
> -    ip netns exec "${PEER_NS}" ifconfig veth1 127.25.3.14/24 up
> +    ip address add 127.25.3.4/24 dev veth0
> +    ip link set dev veth0 up
> +    ip netns exec "${PEER_NS}" ip address add 127.25.3.14/24 dev veth1
> +    ip netns exec "${PEER_NS}" ip link set dev veth1 up
>  
>      ip route flush cache
>      ip netns exec "${PEER_NS}" ip route flush cache

Reviewed-by: David Ahern <dsahern@kernel.org>

