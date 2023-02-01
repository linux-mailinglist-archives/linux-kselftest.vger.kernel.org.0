Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0BE686EF5
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Feb 2023 20:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjBATbB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Feb 2023 14:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjBATbB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Feb 2023 14:31:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1C77BBCA
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Feb 2023 11:31:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E47F561932
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Feb 2023 19:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4B6C433D2;
        Wed,  1 Feb 2023 19:30:57 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] kselftest/arm64: Fix enumeration of SME VLs on systems without VL 128
Date:   Wed,  1 Feb 2023 19:30:55 +0000
Message-Id: <167527985156.975086.8487124990316370380.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230131-arm64-kselftest-sig-sme-no-128-v1-0-d47c13dc8e1e@kernel.org>
References: <20230131-arm64-kselftest-sig-sme-no-128-v1-0-d47c13dc8e1e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 31 Jan 2023 22:56:33 +0000, Mark Brown wrote:
> These two patches fix a repeated error with the way we enumerate SME
> VLs, the code for which is cut'n'pasted into each test.  It's in two
> patches because the first applies to Linus' tree and the second covers a
> new test added in -next, even if they're both applied for -next now this
> should help with backporting.
> 
> It would be good to factor this code out but that's a separate issue,
> I'll tackle that for the next release (along with the general fun with
> the build system in these tests).
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/2] kselftest/arm64: Fix enumeration of systems without 128 bit SME
      https://git.kernel.org/arm64/c/5f389238534a
[2/2] kselftest/arm64: Fix enumeration of systems without 128 bit SME for SSVE+ZA
      https://git.kernel.org/arm64/c/a7db82f18cd3

-- 
Catalin

