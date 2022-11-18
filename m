Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DF062FE1A
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Nov 2022 20:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241828AbiKRTlL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Nov 2022 14:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241666AbiKRTlG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Nov 2022 14:41:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C420A49B5C
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Nov 2022 11:41:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A66AB82508
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Nov 2022 19:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC650C433B5;
        Fri, 18 Nov 2022 19:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668800462;
        bh=QbaSgan2tMQy00t2JfVpRXGNedjeX7qMi8nGcPxrGe4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gBE+KpryFjOQTF3ofN/BojIhxOuYcWQ+GNvgh+eHE6vwZdJXpzgotYpNJXa3UlSu3
         egndFJbDmqFa7vvp4H3XymUHeBtSRZ5c3++IsWy3ma4iKADU0U/HJ0dfMBVDU6o26I
         eo8g6wLMMFhaIvZgbGT+Hepho+SPwBZAJ+nlaoOuKobH2FqAQzMU1S1calHeVFREwy
         nqOjJcv+Q3Jq/RORD9WQyqbRofhr6NlZF0HuMa9uKwtN+ATMRXLwgmwHNRLVdJX2bs
         RMoTWhF9GxFAeQ2ZTJIra2X73e2QKC7zjwqCKY8nehPnpC6X8IYs/6RZCR9+FTCfWv
         Iq86I2yvqY2vA==
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1] kselftest/arm64: Use preferred form for predicate load/stores
Date:   Fri, 18 Nov 2022 19:40:41 +0000
Message-Id: <166878109068.1784220.8277580809796681261.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221117114130.687261-1-broonie@kernel.org>
References: <20221117114130.687261-1-broonie@kernel.org>
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

On Thu, 17 Nov 2022 11:41:30 +0000, Mark Brown wrote:
> The preferred form of the str/ldr for predicate registers with an immediate
> of zero is to omit the zero, and the clang built in assembler rejects the
> zero immediate. Drop the immediate.
> 
> 

Applied to arm64 (for-next/selftests), thanks!

[1/1] kselftest/arm64: Use preferred form for predicate load/stores
      https://git.kernel.org/arm64/c/284d2b44a8cc

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
