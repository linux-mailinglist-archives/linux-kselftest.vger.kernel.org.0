Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C167C9887
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Oct 2023 12:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjJOKD2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Oct 2023 06:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjJOKD1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Oct 2023 06:03:27 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7B2DC
        for <linux-kselftest@vger.kernel.org>; Sun, 15 Oct 2023 03:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1697364203;
        bh=xcox8IJpU3oBHW+ZRMPq+Ub/HXTOJ7r/FHewXZozhkQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Om4CmqeD/lu9fi8PeIB8Y+Js5WkKoDyFOHXexP7u3+l5+fQv179MH9S0m8qVM8FK7
         7d+UpXUbrkzE/WLoN6DTAz0N//YK3ujIj1Q/EdFLHbWnX+vhUgsFFNZJOWf4CqnIJO
         YL1lu2Bn7qAPz8q0RUovEhE9Dxx1Qw0oNCJMcJ3KJAIKGYSCkEWa3YX+D5Y/Hl89Uw
         NzLvvyI3BVm4WfH8Z5gMvO2vinzq/XlHwBDzlWJOITgOtiBFCt8HquaVx0b7e9McyS
         g2vwfxVEMGBizIMdGpHEKGcs4OdRmi/B5n1MIPW39n7RblRxyOSqk2m4iiY/rzLykI
         wUZjhnDCKh03w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S7bRG6dtpz4wx5;
        Sun, 15 Oct 2023 21:03:22 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        keescook@chromium.org
In-Reply-To: <20230921072623.828772-1-mpe@ellerman.id.au>
References: <20230921072623.828772-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] selftests/powerpc: Fix emit_tests to work with run_kselftest.sh
Message-Id: <169736402373.957740.11597798236736150728.b4-ty@ellerman.id.au>
Date:   Sun, 15 Oct 2023 21:00:23 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 21 Sep 2023 17:26:10 +1000, Michael Ellerman wrote:
> In order to use run_kselftest.sh the list of tests must be emitted to
> populate kselftest-list.txt.
> 
> The powerpc Makefile is written to use EMIT_TESTS. But support for
> EMIT_TESTS was dropped in commit d4e59a536f50 ("selftests: Use runner.sh
> for emit targets"). Although prior to that commit a548de0fe8e1
> ("selftests: lib.mk: add test execute bit check to EMIT_TESTS") had
> already broken run_kselftest.sh for powerpc due to the executable check
> using the wrong path.
> 
> [...]

Applied to powerpc/fixes.

[1/1] selftests/powerpc: Fix emit_tests to work with run_kselftest.sh
      https://git.kernel.org/powerpc/c/58b33e78a31782ffe25d404d5eba9a45fe636e27

cheers
