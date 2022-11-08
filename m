Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957E6621AE0
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 18:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbiKHRjN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 12:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbiKHRjJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 12:39:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4461B51C3C
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Nov 2022 09:39:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02BFCB81BE4
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Nov 2022 17:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E267C433D6;
        Tue,  8 Nov 2022 17:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667929145;
        bh=MrykR74GiOjtlPshJD7pCG1tFOTWnd1cDsN+HjWX9DY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQWScmLwj3NLams9iT6B4NDsA+5o+mpWYQRxYuZqrwFZ3HEK3bQywkyIrCOuD/Szb
         35jdcxNmJwiApfcMoFLkAO8E6fQWz5EkE5FVBEXZGb2o7ioF6rRCUsBKUHIb1+Dn4h
         xKUf6O/fGvV3kt7PH0yaYN6h6gCnIroPMQE5eEcqTkHLphXBB0zr6zplMC3A64pZHY
         gqGiC5U0UiDncV9yp770mWNxGySIvP0Jr6jNadGonvcHdO9FjNO1GrpsOkg6aHEoJo
         8NVOwYZmj7d4vCsHkAAYR9G8e5gheO/c13Ag7Yjo2/mGNA419+RJ61iIepvAZb8Z0O
         A7cwoFxAkZcuQ==
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1] kselftest/arm64: Print ASCII version of unknown signal frame magic values
Date:   Tue,  8 Nov 2022 17:38:42 +0000
Message-Id: <166792349135.1917799.16443261128174146129.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221102140543.98193-1-broonie@kernel.org>
References: <20221102140543.98193-1-broonie@kernel.org>
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

On Wed, 2 Nov 2022 14:05:43 +0000, Mark Brown wrote:
> The signal magic values are supposed to be allocated as somewhat meaningful
> ASCII so if we encounter a bad magic value print the any alphanumeric
> characters we find in it as well as the hex value to aid debuggability.
> 
> 

Applied to arm64 (for-next/selftests), thanks!

[1/1] kselftest/arm64: Print ASCII version of unknown signal frame magic values
      https://git.kernel.org/arm64/c/9b283888a6d5

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
