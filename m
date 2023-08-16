Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13ADB77E89E
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 20:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345495AbjHPSZ7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 14:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345567AbjHPSZx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 14:25:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E871FE9
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 11:25:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E35D063F66
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 18:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFA1C433C8;
        Wed, 16 Aug 2023 18:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692210351;
        bh=/hz7b3qU1mbwFDHTo+G5rJKLYxqxH12C29vOncowQ8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dLuxcU0dRSQA58rOaGSHfKr5wlfjEKojMZ+EylSQQnpUnfvBbw75taSoAiCoYIIfC
         royYv6kaxwEqvorgp1CyzOs4BVLA2D4FvUtTQrjVt4f+emoqvucLdQnWOovtFaR4xr
         IXL9KIt9ktMqVW7YDrWhc+xJaeLTZG67au8QQbhGFBWUwV6Fbk8vHE7WGwQJgBArNY
         dzRNwA1dtXumV0D51dD41VQA+FWTMA8LyEM3t8KaiH2KgIOzGBpmxJVBOejBUWNXwG
         dTyxdNMG2xa8ovXqugghNOPvIK++s6a4XMGK39OhUPO5Xc5pWaaC2EHwrWOciMCB1V
         3Lqgv+6K+c7Ug==
From:   Will Deacon <will@kernel.org>
To:     broonie@kernel.org, shuah@kernel.org,
        Zeng Heng <zengheng4@huawei.com>, catalin.marinas@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, xiexiuqi@huawei.com,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH -next v2 0/4] kselftest/arm64: Add crypto-related feature checks to hwcap test
Date:   Wed, 16 Aug 2023 19:25:30 +0100
Message-Id: <169219584224.1951869.3526205617101128102.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230815040915.3966955-1-zengheng4@huawei.com>
References: <20230815040915.3966955-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 15 Aug 2023 12:09:11 +0800, Zeng Heng wrote:
> Add new feature checks related to crypto to the hwcap test.
> 
> The following is a log snippet from my local testing environment
> based on for-next/selftests:
> ~~~
>  TAP version 13
>  1..111
>  # AES present
>  ok 1 cpuinfo_match_AES
>  ok 2 sigill_AES
>  ok 3 # SKIP sigbus_AES
>  # CRC32 present
>  ok 4 cpuinfo_match_CRC32
>  ok 5 sigill_CRC32
>  ok 6 # SKIP sigbus_CRC32
>  ok 7 cpuinfo_match_CSSC
>  # sigill_reported for CSSC
>  ok 8 # SKIP sigill_CSSC
>  ok 9 # SKIP sigbus_CSSC
>  # FP present
>  ok 10 cpuinfo_match_FP
>  ok 11 sigill_FP
>  ok 12 # SKIP sigbus_FP
>  # JSCVT present
>  ok 13 cpuinfo_match_JSCVT
>  ok 14 sigill_JSCVT
>  ok 15 # SKIP sigbus_JSCVT
>  # LRCPC present
>  ok 16 cpuinfo_match_LRCPC
>  ok 17 sigill_LRCPC
>  ok 18 # SKIP sigbus_LRCPC
>  # LRCPC2 present
>  ok 19 cpuinfo_match_LRCPC2
>  ok 20 sigill_LRCPC2
>  ok 21 # SKIP sigbus_LRCPC2
>  # LSE present
>  ok 22 cpuinfo_match_LSE
>  ok 23 sigill_LSE
>  ok 24 # SKIP sigbus_LSE
>  # LSE2 present
>  ok 25 cpuinfo_match_LSE2
>  ok 26 sigill_LSE2
>  ok 27 sigbus_LSE2
>  ok 28 cpuinfo_match_MOPS
>  ok 29 sigill_MOPS
>  ok 30 # SKIP sigbus_MOPS
>  # RNG present
>  ok 31 cpuinfo_match_RNG
>  ok 32 sigill_RNG
>  ok 33 # SKIP sigbus_RNG
>  # PMULL present
>  ok 34 cpuinfo_match_PMULL
>  ok 35 sigill_PMULL
>  ok 36 # SKIP sigbus_PMULL
>  ok 37 cpuinfo_match_RPRFM
>  ok 38 # SKIP sigill_RPRFM
>  ok 39 # SKIP sigbus_RPRFM
>  # SHA1 present
>  ok 40 cpuinfo_match_SHA1
>  ok 41 sigill_SHA1
>  ok 42 # SKIP sigbus_SHA1
>  # SHA2 present
>  ok 43 cpuinfo_match_SHA2
>  ok 44 sigill_SHA2
>  ok 45 # SKIP sigbus_SHA2
>  # SHA512 present
>  ok 46 cpuinfo_match_SHA512
>  ok 47 sigill_SHA512
>  ok 48 # SKIP sigbus_SHA512
>  ok 49 cpuinfo_match_SME
>  ok 50 sigill_SME
>  ok 51 # SKIP sigbus_SME
>  ok 52 cpuinfo_match_SME2
>  ok 53 sigill_SME2
>  ok 54 # SKIP sigbus_SME2
>  ok 55 cpuinfo_match_SME 2.1
>  # sigill_reported for SME 2.1
>  ok 56 # SKIP sigill_SME 2.1
>  ok 57 # SKIP sigbus_SME 2.1
>  ok 58 cpuinfo_match_SME I16I32
>  # sigill_reported for SME I16I32
>  ok 59 # SKIP sigill_SME I16I32
>  ok 60 # SKIP sigbus_SME I16I32
>  ok 61 cpuinfo_match_SME BI32I32
>  # sigill_reported for SME BI32I32
>  ok 62 # SKIP sigill_SME BI32I32
>  ok 63 # SKIP sigbus_SME BI32I32
>  ok 64 cpuinfo_match_SME B16B16
>  # sigill_reported for SME B16B16
>  ok 65 # SKIP sigill_SME B16B16
>  ok 66 # SKIP sigbus_SME B16B16
>  ok 67 cpuinfo_match_SME F16F16
>  # sigill_reported for SME F16F16
>  ok 68 # SKIP sigill_SME F16F16
>  ok 69 # SKIP sigbus_SME F16F16
>  # SVE present
>  ok 70 cpuinfo_match_SVE
>  ok 71 sigill_SVE
>  ok 72 # SKIP sigbus_SVE
>  ok 73 cpuinfo_match_SVE 2
>  # sigill_reported for SVE 2
>  ok 74 # SKIP sigill_SVE 2
>  ok 75 # SKIP sigbus_SVE 2
>  ok 76 cpuinfo_match_SVE 2.1
>  # sigill_reported for SVE 2.1
>  ok 77 # SKIP sigill_SVE 2.1
>  ok 78 # SKIP sigbus_SVE 2.1
>  ok 79 cpuinfo_match_SVE AES
>  # sigill_reported for SVE AES
>  ok 80 # SKIP sigill_SVE AES
>  ok 81 # SKIP sigbus_SVE AES
>  ok 82 cpuinfo_match_SVE2 PMULL
>  # sigill_reported for SVE2 PMULL
>  ok 83 # SKIP sigill_SVE2 PMULL
>  ok 84 # SKIP sigbus_SVE2 PMULL
>  ok 85 cpuinfo_match_SVE2 BITPERM
>  # sigill_reported for SVE2 BITPERM
>  ok 86 # SKIP sigill_SVE2 BITPERM
>  ok 87 # SKIP sigbus_SVE2 BITPERM
>  ok 88 cpuinfo_match_SVE2 SHA3
>  # sigill_reported for SVE2 SHA3
>  ok 89 # SKIP sigill_SVE2 SHA3
>  ok 90 # SKIP sigbus_SVE2 SHA3
>  ok 91 cpuinfo_match_SVE2 SM4
>  # sigill_reported for SVE2 SM4
>  ok 92 # SKIP sigill_SVE2 SM4
>  ok 93 # SKIP sigbus_SVE2 SM4
>  # SVE2 I8MM present
>  ok 94 cpuinfo_match_SVE2 I8MM
>  ok 95 sigill_SVE2 I8MM
>  ok 96 # SKIP sigbus_SVE2 I8MM
>  # SVE2 F32MM present
>  ok 97 cpuinfo_match_SVE2 F32MM
>  ok 98 sigill_SVE2 F32MM
>  ok 99 # SKIP sigbus_SVE2 F32MM
>  # SVE2 F64MM present
>  ok 100 cpuinfo_match_SVE2 F64MM
>  ok 101 sigill_SVE2 F64MM
>  ok 102 # SKIP sigbus_SVE2 F64MM
>  # SVE2 BF16 present
>  ok 103 cpuinfo_match_SVE2 BF16
>  ok 104 sigill_SVE2 BF16
>  ok 105 # SKIP sigbus_SVE2 BF16
>  ok 106 cpuinfo_match_SVE2 EBF16
>  ok 107 # SKIP sigill_SVE2 EBF16
>  ok 108 # SKIP sigbus_SVE2 EBF16
>  ok 109 cpuinfo_match_HBC
>  ok 110 sigill_HBC
>  ok 111 # SKIP sigbus_HBC
>  # Totals: pass:60 fail:0 xfail:0 xpass:0 skip:51 error:0
> ~~~
> 
> [...]

Applied to arm64 (for-next/selftests), thanks!

[1/4] kselftest/arm64: add SHA1 and related features to hwcap test
      https://git.kernel.org/arm64/c/7eb4ee66739e
[2/4] kselftest/arm64: add AES feature check to hwcap test
      https://git.kernel.org/arm64/c/3fc3c0d1246c
[3/4] kselftest/arm64: add pmull feature to hwcap test
      https://git.kernel.org/arm64/c/2c3ce0e7dd51
[4/4] kselftest/arm64: add jscvt feature to hwcap test
      https://git.kernel.org/arm64/c/fcb0b51a5dca

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
