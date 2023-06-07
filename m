Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A2372660C
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 18:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjFGQcy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 12:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjFGQcx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 12:32:53 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C2311F;
        Wed,  7 Jun 2023 09:32:28 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id AEDC05C00C4;
        Wed,  7 Jun 2023 12:32:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 07 Jun 2023 12:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686155544; x=1686241944; bh=Qr/Gw0RZ06Pyq
        6A7s5pLn8myn4McikOyjbd6/dNG4wU=; b=IMnILY+CISLnMsTcq0PZ8TsWuV3y2
        GPCWuZuvMFGNw+p0JxP2+o9KrONAyJRET4ZszVsE/beyRuIJ9BTO/ZmI/ZCWwqB2
        avVVLxpIPBVVfOFDMYV3b01ag28saZqLOrNnFRYD8yQw1PEpA36WdCxcSvL1qEf6
        suY769EcRm08RwGi4E3E9ZaJyFZURlfLSD3X8BIxDJrOr8ZcAZLFLuvltUDi0+JX
        F+pHRCxJVfpQf6NXz/mdMh0U4Zc5jwnMuiS85duphzbbl0O2LtUb3YTnhmDIU8ZZ
        JqpKeyXYIYmkrRrSZTBdqnUlMVoRl/H8INapIBionPC1s9nN/whdj0UHA==
X-ME-Sender: <xms:GLGAZNT7aG3WXi9oTB4zoRv7baMhBHHIgzZNwvh5YqHPhQsdK9pcbw>
    <xme:GLGAZGzNWS9FFIRopISYgP4USDZccEjHXiNEg4c3cuAIhYlDFjVmCtAgRy2TYTwJs
    ZZnm4Ur6M5RhOc>
X-ME-Received: <xmr:GLGAZC3Xu9Z3V9BOGg6Ouqwj2J74omQl4dQoosFwT8BET493ZZMIgacOi28eY3DQ_KxNbHCxogpJ-5MKGeUl53MEOs8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtgedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdduhedmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredt
    tddtvdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughosh
    gthhdrohhrgheqnecuggftrfgrthhtvghrnhepgfevjedutdekheefieduiedutdffhffh
    keduhfffhffghfehvddtffefteeivefhnecuffhomhgrihhnpegrtggtvghpthgvugdrth
    hoohhlshdpthgvshhtvhiglhgrnhhnohhlohgtrghlsgihphgrshhsrdhshhenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesih
    guohhstghhrdhorhhg
X-ME-Proxy: <xmx:GLGAZFB4rNlRRGJBjHq6RzahslXON6VCtpJPCqGAIrHUhw7Yr39GeQ>
    <xmx:GLGAZGjeiiijJV52IjcPh-kCek8w3Hjeb5vLSM17eXDrtshye_PwTw>
    <xmx:GLGAZJq-uL8U4B4UO1sZcVGdzUu-rmSFuKtWkzoxAEcsp-iog49Pzw>
    <xmx:GLGAZNTgyC9Qer47btdllpnpj3r37YWJ0CyrpHfWD9e9PWBcQsTMog>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jun 2023 12:32:23 -0400 (EDT)
Date:   Wed, 7 Jun 2023 19:32:20 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Vladimir Nikishkin <vladimir@nikishkin.pw>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        eng.alaamohamedsoliman.am@gmail.com, gnault@redhat.com,
        razor@blackwall.org, idosch@nvidia.com, liuhangbin@gmail.com,
        eyal.birger@gmail.com, jtoppins@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stephen@networkplumber.org
Subject: Re: [PATCH net-next] selftests: net: vxlan: Fix selftest after
 changes in iproute2.
Message-ID: <ZICxFL8RXuUPp+at@shredder>
References: <20230607130620.32599-1-vladimir@nikishkin.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607130620.32599-1-vladimir@nikishkin.pw>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 07, 2023 at 09:06:21PM +0800, Vladimir Nikishkin wrote:
> 1. Make test_vxlan_nolocalbypass.sh uses ip -j JSON output.
> 2. Make sure that vxlan nolocalbypass tests pass with the upstream iproute2.

I would drop this numbering and just state:

"
The iproute2 output that eventually landed upstream is different than
the one used in this test, resulting in failures. Fix by adjusting the
test to use iproute2's JSON output, which is more stable than regular
output.

Fixes: 305c04189997 ("selftests: net: vxlan: Add tests for vxlan nolocalbypass option.")
"

> 
> Signed-off-by: Vladimir Nikishkin <vladimir@nikishkin.pw>
> ---
> 
> This is version 0. As suggested in the mailing list, fix tests
> after the change to iproute2 is accepted.
> 
>  tools/testing/selftests/net/test_vxlan_nolocalbypass.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/test_vxlan_nolocalbypass.sh b/tools/testing/selftests/net/test_vxlan_nolocalbypass.sh
> index 46067db53068..1189842c188b 100755
> --- a/tools/testing/selftests/net/test_vxlan_nolocalbypass.sh
> +++ b/tools/testing/selftests/net/test_vxlan_nolocalbypass.sh
> @@ -130,7 +130,7 @@ nolocalbypass()
>  	run_cmd "tc -n ns1 qdisc add dev lo clsact"
>  	run_cmd "tc -n ns1 filter add dev lo ingress pref 1 handle 101 proto ip flower ip_proto udp dst_port 4790 action drop"
>  
> -	run_cmd "ip -n ns1 -d link show dev vx0 | grep ' localbypass'"
> +        run_cmd "ip -n ns1 -d -j link show dev vx0 | jq -e '.[][\"linkinfo\"][\"info_data\"][\"localbypass\"] == true'"

Please replace the 8 spaces with a tab (like in the rest of the test).
Same in other places.

Thanks

>  	log_test $? 0 "localbypass enabled"
>  
>  	run_cmd "ip netns exec ns1 mausezahn vx0 -a $smac -b $dmac -c 1 -p 100 -q"
> @@ -140,7 +140,7 @@ nolocalbypass()
>  
>  	run_cmd "ip -n ns1 link set dev vx0 type vxlan nolocalbypass"
>  
> -	run_cmd "ip -n ns1 -d link show dev vx0 | grep 'nolocalbypass'"
> +        run_cmd "ip -n ns1 -d -j link show dev vx0 | jq -e '.[][\"linkinfo\"][\"info_data\"][\"localbypass\"] == false'"
>  	log_test $? 0 "localbypass disabled"
>  
>  	run_cmd "ip netns exec ns1 mausezahn vx0 -a $smac -b $dmac -c 1 -p 100 -q"
> @@ -150,7 +150,7 @@ nolocalbypass()
>  
>  	run_cmd "ip -n ns1 link set dev vx0 type vxlan localbypass"
>  
> -	run_cmd "ip -n ns1 -d link show dev vx0 | grep ' localbypass'"
> +        run_cmd "ip -n ns1 -d -j link show dev vx0 | jq -e '.[][\"linkinfo\"][\"info_data\"][\"localbypass\"] == true'"
>  	log_test $? 0 "localbypass enabled"
>  
>  	run_cmd "ip netns exec ns1 mausezahn vx0 -a $smac -b $dmac -c 1 -p 100 -q"
> -- 
> 2.35.8
> 
> --
> Fastmail.
> 
> 
