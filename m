Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8615EFC66
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Sep 2022 19:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbiI2Ryx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Sep 2022 13:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbiI2Rys (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Sep 2022 13:54:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BF013E23
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Sep 2022 10:54:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2912C61E8E
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Sep 2022 17:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6122DC433D6;
        Thu, 29 Sep 2022 17:54:36 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] kselftest/arm64: Don't enable v8.5 for MTE selftest builds
Date:   Thu, 29 Sep 2022 18:54:34 +0100
Message-Id: <166447406678.3004405.3029448965221717837.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220928154517.173108-1-broonie@kernel.org>
References: <20220928154517.173108-1-broonie@kernel.org>
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

On Wed, 28 Sep 2022 16:45:17 +0100, Mark Brown wrote:
> Currently we set -march=armv8.5+memtag when building the MTE selftests,
> allowing the compiler to emit v8.5 and MTE instructions for anything it
> generates. This means that we may get code that will generate SIGILLs when
> run on older systems rather than skipping on non-MTE systems as should be
> the case. Most toolchains don't select any incompatible instructions but
> I have seen some reports which suggest that some may be appearing which do
> so. This is also potentially problematic in that if the compiler chooses to
> emit any MTE instructions for the C code it may interfere with the MTE
> usage we are trying to test.
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: Don't enable v8.5 for MTE selftest builds
      https://git.kernel.org/arm64/c/55c8a987dd73

-- 
Catalin

