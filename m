Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D6E513AA0
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Apr 2022 19:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiD1RJm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Apr 2022 13:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiD1RJm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Apr 2022 13:09:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94133EF10
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Apr 2022 10:06:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61B1662104
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Apr 2022 17:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6951CC385A9;
        Thu, 28 Apr 2022 17:06:24 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/4] selftests/arm64: Fix O= builds for the FP selftests
Date:   Thu, 28 Apr 2022 18:06:21 +0100
Message-Id: <165116557542.4055682.1820773973319963164.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220427181954.357975-1-broonie@kernel.org>
References: <20220427181954.357975-1-broonie@kernel.org>
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

On Wed, 27 Apr 2022 19:19:50 +0100, Mark Brown wrote:
> Currently the arm64 selftests don't support building with O=, this
> series fixes that, bringing them more into line with how the kselftest
> Makefiles want to work.
> 
> v3:
>  - Rebase onto arm64/for-next/core.
> v2:
>  - Rebase onto v5.18-rc3.
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/4] selftests/arm64: Use TEST_GEN_PROGS_EXTENDED in the FP Makefile
      https://git.kernel.org/arm64/c/a59f7a7f7640
[2/4] selftests/arm64: Define top_srcdir for the fp tests
      https://git.kernel.org/arm64/c/3a23a42d1a48
[3/4] selftests/arm64: Clean the fp helper libraries
      https://git.kernel.org/arm64/c/399cf0a3e8a1
[4/4] selftests/arm64: Fix O= builds for the floating point tests
      https://git.kernel.org/arm64/c/aca43ad51661

-- 
Catalin

