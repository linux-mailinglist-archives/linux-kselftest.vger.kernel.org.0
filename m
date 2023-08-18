Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6990E78128B
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 20:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352971AbjHRSEm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Aug 2023 14:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379360AbjHRSEV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Aug 2023 14:04:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193A33C34;
        Fri, 18 Aug 2023 11:04:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A034767EFC;
        Fri, 18 Aug 2023 18:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75602C433CA;
        Fri, 18 Aug 2023 18:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692381859;
        bh=lV9weDtawpBFblK3O3YAww/aivGVOw5dKNYj2DwYcMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sBWhE2P+Vucz1ES0qcQAA9BkRQ4dTXG9d0dK3bJacegfed/EJHZIMDe/7+mji3BBJ
         WwHpyueD9/tdjx519x9KArVMzyLLtVABEoMT1lsEOh863g7BK1qjuc2RzSIEUe9o0e
         wm4MAH5L9H+/8tnq46a4uX0Z28ewhQExY+dzjGdddJq6/b+6mZnvickeEbod69sFx4
         C1QBB7io+UzqDzMeMuAJznAcvkm/FBGbdB+vl5Xmw31maXM/Dwo7wi0wWpMNw/H/ia
         9hrIwkb57bW9CW5fivMSimB2ybvlmZHzKZWkvATZdJ3Z5x/C/FWYYRofmIi9Eyyt9L
         BHJDcqsN5Y81g==
From:   Will Deacon <will@kernel.org>
To:     Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] kselftest/arm64: Fix hwcaps selftest build
Date:   Fri, 18 Aug 2023 19:04:09 +0100
Message-Id: <169237486485.1401238.6184748208621707408.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230816-arm64-fix-crc32-build-v1-1-40165c1290f2@kernel.org>
References: <20230816-arm64-fix-crc32-build-v1-1-40165c1290f2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 16 Aug 2023 19:39:32 +0100, Mark Brown wrote:
> The hwcaps selftest currently relies on the assembler being able to
> assemble the crc32w instruction but this is not in the base v8.0 so is not
> accepted by the standard GCC configurations used by many distributions.
> Switch to manually encoding to fix the build.
> 
> 

Applied to arm64 (for-next/selftests), thanks!

[1/1] kselftest/arm64: Fix hwcaps selftest build
      https://git.kernel.org/arm64/c/94f23ac36f8b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
