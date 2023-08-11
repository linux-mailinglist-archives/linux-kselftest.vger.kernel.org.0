Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC13B778E0E
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 13:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbjHKLpJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 07:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbjHKLpI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 07:45:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123CCFA;
        Fri, 11 Aug 2023 04:45:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CB2167064;
        Fri, 11 Aug 2023 11:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5BCC433D9;
        Fri, 11 Aug 2023 11:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691754307;
        bh=418faWU9VVOtzIX2nlLZNpYrRaUT/xniXjwpmQwga8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LYeNVu3JuQMDzVU8xiq4meoKzJzWJkjn7nqaZOuMamrZ/SwhQ+fa1Hx/a+LWB/J4L
         9eaVMWZOMt+XBokFR4GYnXqXzIr7bw0S5BBzB9o85krVXb60V/K2oRZ0vad1vnayMo
         jcJ8gJRCT9k1+DkSbd3/GwZDtkfH6hegYraaYVKCQq17CVs1LZWdqCLjjJPLTe/LHY
         /vSKnDm6DMvc4TAmeYR6Zbd91sFO+JewrYIVwcCqeLVIdpSOM2UIBood2h/VIxJoG2
         derFMCWeLa914ygFa7tua9kfB1qH00MYUAY1xiLaPmIVppwNdC/Gc3nOo8VfSV0BNH
         GZrXJ75maXN/w==
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] kselftest/arm64: Size sycall-abi buffers for the actual maximum VL
Date:   Fri, 11 Aug 2023 12:44:52 +0100
Message-Id: <169175309213.3101777.18103736933706442373.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230810-arm64-syscall-abi-perf-v1-1-6a0d7656359c@kernel.org>
References: <20230810-arm64-syscall-abi-perf-v1-1-6a0d7656359c@kernel.org>
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

On Thu, 10 Aug 2023 12:39:19 +0100, Mark Brown wrote:
> Our ABI opts to provide future proofing by defining a much larger
> SVE_VQ_MAX than the architecture actually supports.  Since we use
> this define to control the size of our vector data buffers this results
> in a lot of overhead when we initialise which can be a very noticable
> problem in emulation, we fill buffers that are orders of magnitude
> larger than we will ever actually use even with virtual platforms that
> provide the full range of architecturally supported vector lengths.
> 
> [...]

Applied to arm64 (for-next/selftests), thanks!

[1/1] kselftest/arm64: Size sycall-abi buffers for the actual maximum VL
      https://git.kernel.org/arm64/c/358b763ee64b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
