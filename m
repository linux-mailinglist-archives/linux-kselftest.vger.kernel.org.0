Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C2977A178
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Aug 2023 19:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjHLRrl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Aug 2023 13:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjHLRrl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Aug 2023 13:47:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E3A10FE
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Aug 2023 10:47:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F25B96129B
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Aug 2023 17:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB3DC433C7;
        Sat, 12 Aug 2023 17:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691862463;
        bh=vdPr7Kd2KSwm7V82XjFtxBtkVUVxXjALdt/pa5tnOfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FbMPp9Il+NKZCMT04hrcAJmZS48vP70mvB6QLO0C2EyywKYPck3Ty1NrZiM4cUm0b
         5lXwuTR2pueQjEBJXDVRHrsq9Zm4TenfYiSVDO3fNORiai/YkmD3yrl50ll7V8bxtf
         yCL0oFAXYvvOCoTjQlN6cmGroi+Yey9nvSMlhnRkQSkHOihsvVOH04vHIwkZJXWIo8
         VsL807xabUrYD4VtnZM5J5rRqv3EFpVJdXyM3qRdMKCe8m9/t0RcX47S5RwgBN+0Sm
         FVsRRBNf6jyek82daGjPBThokmJowuqT+LXKfpbSru6NHBetSU0shLHLKTbi1TkfVX
         6FTh130EugZ2Q==
Date:   Sat, 12 Aug 2023 19:47:38 +0200
From:   Simon Horman <horms@kernel.org>
To:     Petr Machata <petrm@nvidia.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        mlxsw@nvidia.com, Ido Schimmel <idosch@nvidia.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: mirror_gre_changes: Tighten up the TTL
 test match
Message-ID: <ZNfFuoNXvwaB8jmX@vergenet.net>
References: <3ea00504d4fa00a4f3531044e3df20312d472a39.1691769262.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ea00504d4fa00a4f3531044e3df20312d472a39.1691769262.git.petrm@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 11, 2023 at 05:59:27PM +0200, Petr Machata wrote:

+ Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org

> This test verifies whether the encapsulated packets have the correct
> configured TTL. It does so by sending ICMP packets through the test
> topology and mirroring them to a gretap netdevice. On a busy host
> however, more than just the test ICMP packets may end up flowing
> through the topology, get mirrored, and counted. This leads to
> potential spurious failures as the test observes much more mirrored
> packets than the sent test packets, and assumes a bug.
> 
> Fix this by tightening up the mirror action match. Change it from
> matchall to a flower classifier matching on ICMP packets specifically.
> 
> Fixes: 45315673e0c5 ("selftests: forwarding: Test changes in mirror-to-gretap")
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  tools/testing/selftests/net/forwarding/mirror_gre_changes.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh b/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
> index aff88f78e339..5ea9d63915f7 100755
> --- a/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
> +++ b/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
> @@ -72,7 +72,8 @@ test_span_gre_ttl()
>  
>  	RET=0
>  
> -	mirror_install $swp1 ingress $tundev "matchall $tcflags"
> +	mirror_install $swp1 ingress $tundev \
> +		"prot ip flower $tcflags ip_prot icmp"
>  	tc filter add dev $h3 ingress pref 77 prot $prot \
>  		flower skip_hw ip_ttl 50 action pass
>  
> -- 
> 2.41.0
> 
> 
