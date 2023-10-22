Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6267D250B
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Oct 2023 19:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjJVRu6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 22 Oct 2023 13:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVRu4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 22 Oct 2023 13:50:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D883AE8;
        Sun, 22 Oct 2023 10:50:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC802C433C7;
        Sun, 22 Oct 2023 17:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697997054;
        bh=a7bhSUEACARdlq+uMxJTYxwH4vFhfS8krMiwwfiEKSE=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=uVZvQdXvjKYi6AzOm1BWXPZChWwTpjAO2Q98PUveYzLzJTehfW/4eSjrAY97EcIH8
         /rC4gT6u2sUK62SKS8PTy7TvYrQ+NReci0UwTlHQzNe5gir3J5WphZDYl5ICNvsYfg
         CvcxNV1xfZA1RG5OlbEGf9QxtaGB0s9jxqnYQgv/iiWge8em318oaRNncDK93jiORP
         kb7bYrbGJFbOljYZI2qm2ZaEY9S3a4pJ5PMD6MO99d7j0aWPghpOcsa1XyQ7H5jUql
         jyAby27BeHzkn9XRhfDNUvvwz/dQZYHJoUgOLmEhWZihxk8q5bcYcVY2Quc37ZpwNS
         ImoDGXT6vpHyw==
Message-ID: <fde654ce-e4b6-449c-94a9-eeaad1eed6b7@kernel.org>
Date:   Sun, 22 Oct 2023 11:50:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests:net change ifconfig with ip command
Content-Language: en-US
To:     Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20231022113148.2682-1-swarupkotikalapudi@gmail.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20231022113148.2682-1-swarupkotikalapudi@gmail.com>
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

On 10/22/23 5:31 AM, Swarup Laxman Kotiaklapudi wrote:
> diff --git a/tools/testing/selftests/net/route_localnet.sh b/tools/testing/selftests/net/route_localnet.sh
> index 116bfeab72fa..3ab9beb4462c 100755
> --- a/tools/testing/selftests/net/route_localnet.sh
> +++ b/tools/testing/selftests/net/route_localnet.sh
> @@ -18,8 +18,10 @@ setup() {
>      ip route del 127.0.0.0/8 dev lo table local
>      ip netns exec "${PEER_NS}" ip route del 127.0.0.0/8 dev lo table local
>  
> -    ifconfig veth0 127.25.3.4/24 up
> -    ip netns exec "${PEER_NS}" ifconfig veth1 127.25.3.14/24 up
> +    ip a add 127.25.3.4/24 dev veth0

ip addr add ...

> +    ip link set dev veth0 up
> +    ip netns exec "${PEER_NS}" ip a add 127.25.3.14/24 dev veth1

ip addr add ...

> +    ip netns exec "${PEER_NS}" ip link set dev veth1 up
>  
>      ip route flush cache
>      ip netns exec "${PEER_NS}" ip route flush cache

