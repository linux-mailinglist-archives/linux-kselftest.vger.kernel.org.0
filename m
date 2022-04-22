Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F25350C00D
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Apr 2022 20:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiDVSyU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Apr 2022 14:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiDVSyT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Apr 2022 14:54:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EB81FEC69
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Apr 2022 11:47:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 749BA60EBA
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Apr 2022 18:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75413C385A4;
        Fri, 22 Apr 2022 18:27:39 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/4] kselftest/arm64: Miscelaneous MTE test updates
Date:   Fri, 22 Apr 2022 19:27:37 +0100
Message-Id: <165065199613.1610925.5358882219916662365.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419103243.24774-1-broonie@kernel.org>
References: <20220419103243.24774-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 19 Apr 2022 11:32:39 +0100, Mark Brown wrote:
> This series is just a set of minor tweaks and improvements for the MTE
> tests that I did while working on the asymmetric mode support for
> userspace which seemed like they might be worth keeping even though the
> prctl() for asymmetric mode got removed.
> 
> v2:
>  - Rebase onto v5.18-rc3
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/4] kselftest/arm64: Handle more kselftest result codes in MTE helpers
      https://git.kernel.org/arm64/c/eb89cf6f913f
[2/4] kselftest/arm64: Log unexpected asynchronous MTE faults
      https://git.kernel.org/arm64/c/929e073bcbfb
[3/4] kselftest/arm64: Refactor parameter checking in mte_switch_mode()
      https://git.kernel.org/arm64/c/df0a991023e0
[4/4] kselftest/arm64: Add simple test for MTE prctl
      https://git.kernel.org/arm64/c/78387d9f017f

-- 
Catalin

