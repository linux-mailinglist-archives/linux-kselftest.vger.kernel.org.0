Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08AD50BFF2
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Apr 2022 20:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiDVSsX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Apr 2022 14:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiDVSsW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Apr 2022 14:48:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA311E8A0B
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Apr 2022 11:42:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91AFAB8321B
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Apr 2022 18:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB80FC385A4;
        Fri, 22 Apr 2022 18:27:10 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] kselftest/arm64: Test ptrace writing via FPSIMD and reading via SVE
Date:   Fri, 22 Apr 2022 19:27:08 +0100
Message-Id: <165065199612.1610925.5736694366252202348.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404090613.181272-1-broonie@kernel.org>
References: <20220404090613.181272-1-broonie@kernel.org>
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

On Mon, 4 Apr 2022 10:06:10 +0100, Mark Brown wrote:
> This series has a couple of minor fixes and cleanups for sve-ptrace plus
> the addition of a new test which validates that we can write using the
> FPSIMD regset and then read matching data back using the SVE regset -
> previously we only validated writing SVE and reading FPSIMD data.
> 
> v2
>  - Rebase onto v5.18-rc1
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/3] kselftest/arm64: Fix comment for ptrace_sve_get_fpsimd_data()
      https://git.kernel.org/arm64/c/348b096850d9
[2/3] kselftest/arm64: Remove assumption that tasks start FPSIMD only
      https://git.kernel.org/arm64/c/9891f4edc90c
[3/3] kselftest/arm64: Validate setting via FPSIMD and read via SVE regsets
      https://git.kernel.org/arm64/c/88560c9c263a

-- 
Catalin

