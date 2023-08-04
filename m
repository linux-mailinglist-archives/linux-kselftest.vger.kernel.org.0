Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C8077079D
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 20:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjHDSLK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 14:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjHDSLG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 14:11:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9D8524B
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Aug 2023 11:10:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B7BD620F0
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Aug 2023 18:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B14FC433C8;
        Fri,  4 Aug 2023 18:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691172623;
        bh=LRfDGzlKqw9WloIyMQx9PfNIvHzqL+giWs8MmY+dgT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=diUTdc1C3DchzkeOc1ug8TZ/1FXRjErHRM11gbJ/UXtOuaDqPUxMxft6H9gR2davD
         OOvwtQ9m39nUozaNyTeIynxyjt1ofyTSRDHk5oomv5/eY4MweU9zw/mJJQvXWyNrqC
         WfIdCJWVqZFsribxpKSOCJE8dmgKqflmImu6YjOGY0T7rZ+l7Uka/boM9A1IFvDjzm
         YMqbzT2mRHEzdDsZdIxnXv/adM6N/JtvwP6PFsinYg0W2S47AqnofPTzTeZvgTeLKT
         N0cISqQbgaJFogguU9PB10tsKUGTv868tasOUAKqcEaBACTKfs4Zqb0qHWxqCH2idE
         rAj8VoNnM113Q==
From:   Will Deacon <will@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/6] kselfest/arm64: Fix a SVE memcpy() issue and use tools/include
Date:   Fri,  4 Aug 2023 19:10:12 +0100
Message-Id: <169116701323.148038.6695968230784644639.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230728-arm64-signal-memcpy-fix-v4-0-0c1290db5d46@kernel.org>
References: <20230728-arm64-signal-memcpy-fix-v4-0-0c1290db5d46@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 28 Jul 2023 00:26:11 +0100, Mark Brown wrote:
> Will noticed that with newer toolchains memcpy() ends up being
> implemented with SVE instructions, breaking the signals tests when in
> streaming mode.  We fixed this by using an open coded version of
> OPTIMZER_HIDE_VAR(), but in the process it was noticed that some of the
> selftests are using the tools/include headers and it might be nice to
> share things there.  We also have a custom compiler.h in the BTI tests.
> 
> [...]

Applied to arm64 (for-next/selftests), thanks!

[1/6] kselftest/arm64: Exit streaming mode after collecting signal context
      https://git.kernel.org/arm64/c/d6da04b6fbab
[2/6] tools compiler.h: Add OPTIMIZER_HIDE_VAR()
      https://git.kernel.org/arm64/c/e5d51a665021
[3/6] tools include: Add some common function attributes
      https://git.kernel.org/arm64/c/51e6ac1fa451
[4/6] kselftest/arm64: Make the tools/include headers available
      https://git.kernel.org/arm64/c/35d7bc983a74
[5/6] kselftest/arm64: Use shared OPTIMZER_HIDE_VAR() definiton
      https://git.kernel.org/arm64/c/db7a89f706d6
[6/6] kselftest/arm64: Use the tools/include compiler.h rather than our own
      https://git.kernel.org/arm64/c/672dbf97f612

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
