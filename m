Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985CC675A9D
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jan 2023 17:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjATQ7P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 11:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjATQ7O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 11:59:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBCA80BB1
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 08:59:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A5276200E
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B24C4339B;
        Fri, 20 Jan 2023 16:59:09 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 0/6] kselftest/arm64: Build fixes for clang
Date:   Fri, 20 Jan 2023 16:59:07 +0000
Message-Id: <167423393396.2326323.15344511841886361523.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111-arm64-kselftest-clang-v1-0-89c69d377727@kernel.org>
References: <20230111-arm64-kselftest-clang-v1-0-89c69d377727@kernel.org>
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

On Thu, 12 Jan 2023 19:51:47 +0000, Mark Brown wrote:
> This series provides a few small build fixes and Makefile tweaks which
> allow us to build the arm64 selftests using clang as well as GCC.  I
> also fixed one minor issue I noticed in the MTE Makefile while doing the
> updates there.
> 
> 

Applied to arm64 (for-next/kselftest), thanks!

[1/6] kselftest/arm64: Fix .pushsection for strings in FP tests
      https://git.kernel.org/arm64/c/aa58ace3499a
[2/6] kselftest/arm64: Remove redundant _start labels from FP tests
      https://git.kernel.org/arm64/c/cd57a6584fe5
[3/6] kselftest/arm64: Don't pass headers to the compiler as source
      https://git.kernel.org/arm64/c/a884f7970e57
[4/6] kselftest/arm64: Initialise current at build time in signal tests
      https://git.kernel.org/arm64/c/6e4b4f0eca88
[5/6] kselftest/arm64: Support build of MTE tests with clang
      https://git.kernel.org/arm64/c/343d59119e77
[6/6] kselftest/arm64: Remove spurious comment from MTE test Makefile
      https://git.kernel.org/arm64/c/89d72c035f88

-- 
Catalin

