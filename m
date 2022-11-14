Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F2E628979
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Nov 2022 20:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiKNTe7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 14:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbiKNTe6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 14:34:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C376C768;
        Mon, 14 Nov 2022 11:34:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE0E66140C;
        Mon, 14 Nov 2022 19:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CCDC433D7;
        Mon, 14 Nov 2022 19:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668454493;
        bh=SpFYlH+o3QAnWwtLQrR764bDWTEAaa3hJerCGhBg1yg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fnwfTjVGGPS5fXOVa7MM1HsoJ4y+zXW8a+Q5ul1huYZdSvU2aqgz+uc6coSLLaOpo
         TrPjXqcp/chexttTgObNxcpH+OaSOvpJsh5oF+sNTLM3eSO76GAr8C+Oyw1L688HUa
         HpGLSQ6Za14dla9FNy/UJRlxS2Kd5bFDgs5v/crU4qf7lrwISpNQ1YsVs2UCJdH+ol
         aU1x5+iLJ4Jd+QTvQPTCU2bM6qsNg/KpWtOpijLeG9Kn1TV67oXfICpyXiAl0nGBOG
         3Zs75ixBMq42UMSZFQkZU/vlEGdBO/ZCw/rt/e5x+62sUntqukHjGNVfLko2+3N1MY
         NQgJ35Cbb6bjw==
From:   Will Deacon <will@kernel.org>
To:     catalin.marinas@arm.com, shuah@kernel.org, wangkailong@jari.cn
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] kselftest/arm64: fix array_size.cocci warning
Date:   Mon, 14 Nov 2022 19:34:34 +0000
Message-Id: <166843703000.2458937.746493234594841296.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <777ce8ba.12e.184705d4211.Coremail.wangkailong@jari.cn>
References: <777ce8ba.12e.184705d4211.Coremail.wangkailong@jari.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, 13 Nov 2022 17:41:10 +0800 (GMT+08:00), wangkailong@jari.cn wrote:
> Fix following coccicheck warning:
> 
> tools/testing/selftests/arm64/mte/check_mmap_options.c:64:24-25:
> WARNING: Use ARRAY_SIZE
> tools/testing/selftests/arm64/mte/check_mmap_options.c:66:20-21:
> WARNING: Use ARRAY_SIZE
> tools/testing/selftests/arm64/mte/check_mmap_options.c:135:25-26:
> WARNING: Use ARRAY_SIZE
> tools/testing/selftests/arm64/mte/check_mmap_options.c:96:25-26:
> WARNING: Use ARRAY_SIZE
> tools/testing/selftests/arm64/mte/check_mmap_options.c:190:24-25:
> WARNING: Use ARRAY_SIZE
> 
> [...]

Applied to arm64 (for-next/selftests), thanks!

[1/1] kselftest/arm64: fix array_size.cocci warning
      https://git.kernel.org/arm64/c/a75df5be8e7b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
