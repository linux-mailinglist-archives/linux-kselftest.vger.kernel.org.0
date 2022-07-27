Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFF958298C
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Jul 2022 17:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiG0PYQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Jul 2022 11:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiG0PYN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Jul 2022 11:24:13 -0400
X-Greylist: delayed 528 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Jul 2022 08:24:10 PDT
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F8547B95;
        Wed, 27 Jul 2022 08:24:09 -0700 (PDT)
Received: from [31.133.137.93] (dhcp-895d.meeting.ietf.org [31.133.137.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 76039200DF96;
        Wed, 27 Jul 2022 17:15:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 76039200DF96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
        s=ulg20190529; t=1658934916;
        bh=I848GIMG+rr1vSQNnER5ZP2Oz/37p0WtxAU9zeysw/I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kQ14gRdmvnxnQkRtSxXOGlkfGEkGd+/lwkS5LaE1/zcdeL5o9gJaxqmMh/gVTcY4U
         msClq4fhT2aOmVaFcjnQNNkpwNcfkH+K2zE93PkazIdEnzeWsDOdFfKNltlJRTDEe7
         jbfjoFIB2sZORqQUxpkDVP0Xb81zbBIY9Xlh3u0tQm8lsmGOUr0chyghO03PF1EXoN
         l0PDUQNZXezrQoKNV9AkJZNc0qXxs9EKhGkH3ri+wSFKLc4NKrfQx0LpUUJ4eWAtxT
         mc4Z4QShFTtAiq1lwPOzESKqVzlPWFIjzgMHikik5jLEqLXmsDr4ODjpvCsBMU5jdW
         IstyOlvhX7aOg==
Message-ID: <8810d090-3fcb-0e93-ce5d-e88abb421dba@uliege.be>
Date:   Wed, 27 Jul 2022 11:15:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] selftests: net: fix IOAM test skip return code
Content-Language: en-US
To:     Kleber Sacilotto de Souza <kleber.souza@canonical.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
References: <20220727093742.115882-1-kleber.souza@canonical.com>
From:   Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20220727093742.115882-1-kleber.souza@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/27/22 11:37, Kleber Sacilotto de Souza wrote:
> The ioam6.sh test script exits with an error code (1) when tests are
> skipped due to lack of support from userspace/kernel or not enough
> permissions. It should return the kselftests SKIP code instead.
> 
> Signed-off-by: Kleber Sacilotto de Souza <kleber.souza@canonical.com>
> ---
>   tools/testing/selftests/net/ioam6.sh | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/ioam6.sh b/tools/testing/selftests/net/ioam6.sh
> index a2b9fad5a9a6..4ceb401da1bf 100755
> --- a/tools/testing/selftests/net/ioam6.sh
> +++ b/tools/testing/selftests/net/ioam6.sh
> @@ -117,6 +117,8 @@
>   #        | Schema Data         |                                     |
>   #        +-----------------------------------------------------------+
>   
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
>   
>   ################################################################################
>   #                                                                              #
> @@ -211,7 +213,7 @@ check_kernel_compatibility()
>       echo "SKIP: kernel version probably too old, missing ioam support"
>       ip link del veth0 2>/dev/null || true
>       ip netns del ioam-tmp-node || true
> -    exit 1
> +    exit $ksft_skip
>     fi
>   
>     ip -netns ioam-tmp-node route add db02::/64 encap ioam6 mode inline \
> @@ -227,7 +229,7 @@ check_kernel_compatibility()
>            "without CONFIG_IPV6_IOAM6_LWTUNNEL?"
>       ip link del veth0 2>/dev/null || true
>       ip netns del ioam-tmp-node || true
> -    exit 1
> +    exit $ksft_skip
>     fi
>   
>     ip link del veth0 2>/dev/null || true
> @@ -752,20 +754,20 @@ nfailed=0
>   if [ "$(id -u)" -ne 0 ]
>   then
>     echo "SKIP: Need root privileges"
> -  exit 1
> +  exit $ksft_skip
>   fi
>   
>   if [ ! -x "$(command -v ip)" ]
>   then
>     echo "SKIP: Could not run test without ip tool"
> -  exit 1
> +  exit $ksft_skip
>   fi
>   
>   ip ioam &>/dev/null
>   if [ $? = 1 ]
>   then
>     echo "SKIP: iproute2 too old, missing ioam command"
> -  exit 1
> +  exit $ksft_skip
>   fi
>   
>   check_kernel_compatibility

LGTM, thanks.

Reviewed-by: Justin Iurman <justin.iurman@uliege.be>
