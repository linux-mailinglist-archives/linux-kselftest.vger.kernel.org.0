Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3AA6832A9
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 17:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjAaQaC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 11:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjAaQ3w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 11:29:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEB23AA5
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 08:29:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0058DB81DAE
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 16:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6151C433D2;
        Tue, 31 Jan 2023 16:29:46 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] kselftest/arm64: Remove redundant _start labels from zt-test
Date:   Tue, 31 Jan 2023 16:29:44 +0000
Message-Id: <167518258104.583521.13126662777725000752.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230130-arm64-fix-sme2-clang-v1-1-3ce81d99ea8f@kernel.org>
References: <20230130-arm64-fix-sme2-clang-v1-1-3ce81d99ea8f@kernel.org>
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

On Mon, 30 Jan 2023 23:45:57 +0000, Mark Brown wrote:
> The newly added zt-test program copied the pattern from the other FP
> stress test programs of having a redundant _start label which is
> rejected by clang, as we did in a parallel series for the other tests
> remove the label so we can build with clang.
> 
> No functional change.
> 
> [...]

Applied to arm64 (for-next/sme2), thanks!

[1/1] kselftest/arm64: Remove redundant _start labels from zt-test
      https://git.kernel.org/arm64/c/b2ab432bcf65

-- 
Catalin

