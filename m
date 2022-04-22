Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62D450BFEB
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Apr 2022 20:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiDVSqd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Apr 2022 14:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiDVSq1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Apr 2022 14:46:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E24127584
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Apr 2022 11:42:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA7D4B82D44
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Apr 2022 18:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58777C385A0;
        Fri, 22 Apr 2022 18:26:55 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kselftest@vger.kernel.org,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Alan Hayward <alan.hayward@arm.com>,
        Luca Salabrino <luca.scalabrino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: Re: (subset) [PATCH v14 00/39] arm64/sme: Initial support for the Scalable Matrix Extension
Date:   Fri, 22 Apr 2022 19:26:52 +0100
Message-Id: <165065199613.1610925.15958452310991530163.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419112247.711548-1-broonie@kernel.org>
References: <20220419112247.711548-1-broonie@kernel.org>
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

On Tue, 19 Apr 2022 12:22:08 +0100, Mark Brown wrote:
> This series provides initial support for the ARMv9 Scalable Matrix
> Extension (SME).  SME takes the approach used for vectors in SVE and
> extends this to provide architectural support for matrix operations.  A
> more detailed overview can be found in [1].
> 
> For the kernel SME can be thought of as a series of features which are
> intended to be used together by applications but operate mostly
> orthogonally:
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[28/39] kselftest/arm64: Add manual encodings for SME instructions
        https://git.kernel.org/arm64/c/b5d3f4daf4d3
[29/39] kselftest/arm64: sme: Add SME support to vlset
        https://git.kernel.org/arm64/c/0fea47609e48
[30/39] kselftest/arm64: Add tests for TPIDR2
        https://git.kernel.org/arm64/c/f442d9edcff0
[31/39] kselftest/arm64: Extend vector configuration API tests to cover SME
        https://git.kernel.org/arm64/c/7e387a00d640
[32/39] kselftest/arm64: sme: Provide streaming mode SVE stress test
        https://git.kernel.org/arm64/c/aee8a834e3f0
[33/39] kselftest/arm64: signal: Handle ZA signal context in core code
        https://git.kernel.org/arm64/c/f2608edbc17b
[34/39] kselftest/arm64: Add stress test for SME ZA context switching
        https://git.kernel.org/arm64/c/659689a61912
[35/39] kselftest/arm64: signal: Add SME signal handling tests
        https://git.kernel.org/arm64/c/8d41f50ade02
[36/39] kselftest/arm64: Add streaming SVE to SVE ptrace tests
        https://git.kernel.org/arm64/c/e4bbc3f2c589
[37/39] kselftest/arm64: Add coverage for the ZA ptrace interface
        https://git.kernel.org/arm64/c/8f6bb75334f4
[38/39] kselftest/arm64: Add SME support to syscall ABI test
        https://git.kernel.org/arm64/c/5bbfaf598476
[39/39] selftests/arm64: Add a testcase for handling of ZA on clone()
        https://git.kernel.org/arm64/c/fb146c8a0ad9

-- 
Catalin

