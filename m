Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530D7727766
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 08:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbjFHGjB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 02:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbjFHGjA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 02:39:00 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13022132;
        Wed,  7 Jun 2023 23:38:59 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 7C75C5C012D;
        Thu,  8 Jun 2023 02:38:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 08 Jun 2023 02:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686206337; x=1686292737; bh=DSZGDrWrsTT//
        beTEdXL+cHSbJdMNHw0R6FCpeyN+U0=; b=IdeZEne6gChC40rAWCq3TF8Hgt55q
        5djVrjJ3kKvS1qSN3kC3fdxWlGRLe04IwKWMAlDFBwWxRyv1PESSpltbf6y509LT
        x/gc9Bpt0Lahci2QN67bwc23NgbEvVr2RHQtDcD87yj6c3UNgyKwnxPZNmLMuJrg
        dc8Ul21uzHqWG397UMG+2Ji9NgpIquEUXlYLYst2IZw4QvuzHxCBTnkAcIzeSSgJ
        7AmA53fZY9yE4R4YFaK/fchw7MmoQjC3IUZh8VSoNIOKjvboHGwr2kvedlmi2Oao
        FGSyrlr1fnN3+AjF35BwCTgEoSDiy3zBh3vPfcrpfeX21urZSxUs9bxNg==
X-ME-Sender: <xms:gXeBZBObCPrgF5WXvXKR6NzUD1Nhu0w3y3aRzJdUe5yp23-Ap46kOg>
    <xme:gXeBZD81d-hyxJQxC27-V39kO2duCYBczQ708uA3QmIkHBt_ox3r8KYuoN8eImX9W
    kCnyJvi2XHVfQU>
X-ME-Received: <xmr:gXeBZASeDMSfi_XURLAwHk1ckHqxfSX27xyMGyyT3jTKsCUr10X8soFVFCiOrPR8byUryMMXp9a-C-CsfVf-CB6YNtc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedthedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdduhedmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredt
    tddtvdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughosh
    gthhdrohhrgheqnecuggftrfgrthhtvghrnhepleeffefhtdfhteeuiefgledvtdehhffg
    vdeikeevueeghedvveegffeijeffledunecuffhomhgrihhnpehmvghsshgrghgvrdhtoh
    holhhspdhtvghsthhvgihlrghnnhholhhotggrlhgshihprghsshdrshhhnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiug
    hoshgthhdrohhrgh
X-ME-Proxy: <xmx:gXeBZNtL6jcu4ttOcl2taXgz64JPZJtnAF98Os5BnAiQiYkprzUt6A>
    <xmx:gXeBZJfSEGNYIQQlf41tZtYKYLvaEJz-4aAzT-xRyGPBJJaeHu191Q>
    <xmx:gXeBZJ3wd-EZn8QxHrhy0Ty1ZEttu21CFsCFh2JNoE26Uv4wuz0Mgw>
    <xmx:gXeBZM9GL6qW9J_vLUN9HdJu1p7yWnjX2MjoeRkgF_WSDoFNTgkKQw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jun 2023 02:38:56 -0400 (EDT)
Date:   Thu, 8 Jun 2023 09:38:53 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Vladimir Nikishkin <vladimir@nikishkin.pw>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        eng.alaamohamedsoliman.am@gmail.com, gnault@redhat.com,
        razor@blackwall.org, idosch@nvidia.com, liuhangbin@gmail.com,
        eyal.birger@gmail.com, jtoppins@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stephen@networkplumber.org
Subject: Re: [PATCH net-next v1] selftests: net: vxlan: Fix selftest
 regression after changes in iproute2.
Message-ID: <ZIF3fVvDUESywBcp@shredder>
References: <20230608010400.30115-1-vladimir@nikishkin.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608010400.30115-1-vladimir@nikishkin.pw>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 08, 2023 at 09:04:00AM +0800, Vladimir Nikishkin wrote:
> The iproute2 output that eventually landed upstream is different than
> the one used in this test, resulting in failures. Fix by adjusting the
> test to use iproute2's JSON output, which is more stable than regular
> output.
> 
> Fixes: 305c04189997 ("selftests: net: vxlan: Add tests for vxlan nolocalbypass option.")
> Signed-off-by: Vladimir Nikishkin <vladimir@nikishkin.pw>
> ---
> v0=>v1: Fix spaces in indentation. Correct commit message.
> 
> tools/testing/selftests/net/test_vxlan_nolocalbypass.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/test_vxlan_nolocalbypass.sh b/tools/testing/selftests/net/test_vxlan_nolocalbypass.sh
> index 46067db53068..3ce630e4a18b 100755
> --- a/tools/testing/selftests/net/test_vxlan_nolocalbypass.sh
> +++ b/tools/testing/selftests/net/test_vxlan_nolocalbypass.sh
> @@ -130,7 +130,7 @@ nolocalbypass()
>  	run_cmd "tc -n ns1 qdisc add dev lo clsact"
>  	run_cmd "tc -n ns1 filter add dev lo ingress pref 1 handle 101 proto ip flower ip_proto udp dst_port 4790 action drop"
>  
> -	run_cmd "ip -n ns1 -d link show dev vx0 | grep ' localbypass'"
> +        run_cmd "ip -n ns1 -d -j link show dev vx0 | jq -e '.[][\"linkinfo\"][\"info_data\"][\"localbypass\"] == true'"

Still has spaces instead of tab. Visible in the diff

>  	log_test $? 0 "localbypass enabled"
>  
>  	run_cmd "ip netns exec ns1 mausezahn vx0 -a $smac -b $dmac -c 1 -p 100 -q"
> @@ -140,7 +140,7 @@ nolocalbypass()
>  
>  	run_cmd "ip -n ns1 link set dev vx0 type vxlan nolocalbypass"
>  
> -	run_cmd "ip -n ns1 -d link show dev vx0 | grep 'nolocalbypass'"
> +        run_cmd "ip -n ns1 -d -j link show dev vx0 | jq -e '.[][\"linkinfo\"][\"info_data\"][\"localbypass\"] == false'"

Likewise

>  	log_test $? 0 "localbypass disabled"
>  
>  	run_cmd "ip netns exec ns1 mausezahn vx0 -a $smac -b $dmac -c 1 -p 100 -q"
> @@ -150,7 +150,7 @@ nolocalbypass()
>  
>  	run_cmd "ip -n ns1 link set dev vx0 type vxlan localbypass"
>  
> -	run_cmd "ip -n ns1 -d link show dev vx0 | grep ' localbypass'"
> +	run_cmd "ip -n ns1 -d -j link show dev vx0 | jq -e '.[][\"linkinfo\"][\"info_data\"][\"localbypass\"] == true'"

This is OK

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
