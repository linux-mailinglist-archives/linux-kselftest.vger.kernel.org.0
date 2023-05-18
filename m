Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4264670789C
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 May 2023 05:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjERDve (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 23:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjERDve (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 23:51:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C27E4;
        Wed, 17 May 2023 20:51:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C550364CB2;
        Thu, 18 May 2023 03:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3688C433D2;
        Thu, 18 May 2023 03:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684381892;
        bh=wrOYoFVUCTznnjnQx5m1Gp3Gd0xrgAeH5n3WUfSj3Ao=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rlWi4gdl7GIemrPMf/Kr70CS2HWe2gLfkU58KHuwUssEnulSzJxiwblAlrFzFe4Y1
         Z7L61rACD5xqZQIEwt6O74YN8Qkz3smUqIRWVjPte+3oqUORFxnkWYadiGE9KwGS9a
         CwVr+wMNrVB0FzzN7SPUf0AVkH7gBOnrRe3nZgdZ34e1vgRDWA8rZ711+75xDhsIaU
         ZXGzWXdUvFlfH59UCJmq0kZgl738yCYq+B+S0rHR7j00iXdt0kjQCmdr/mbZQcFKPp
         vtINdkKMu7agZENMw17kuTkTX9dUnRGFnu3O1A2UI8Ir3glL7aTla0bMLXD3W6R8mQ
         c4mkE+wVkcZcg==
Date:   Wed, 17 May 2023 20:51:30 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        roxana.nicolescu@canonical.com, shuah@kernel.org,
        pabeni@redhat.com, edumazet@google.com, davem@davemloft.net
Subject: Re: [PATCHv2 net] selftests: fib_tests: mute cleanup error message
Message-ID: <20230517205130.0b44e3d0@kernel.org>
In-Reply-To: <20230518033310.19893-1-po-hsu.lin@canonical.com>
References: <20230518033310.19893-1-po-hsu.lin@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 18 May 2023 11:33:10 +0800 Po-Hsu Lin wrote:
> In the end of the test, there will be an error message induced by the
> `ip netns del ns1` command in cleanup()
> 
>   Tests passed: 201
>   Tests failed:   0
>   Cannot remove namespace file "/run/netns/ns1": No such file or directory
> 
> This can even be reproduced with just `./fib_tests.sh -h` as we're
> calling cleanup() on exit.
> 
> Redirect the error message to /dev/null to mute it.
> 
> V2: Update commit message and fixes tag.
> 
> Fixes: b60417a9f2b8 ("selftest: fib_tests: Always cleanup before exit")
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>

missing cc netdev
