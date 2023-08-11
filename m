Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC559778E18
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 13:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbjHKLpY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 07:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236277AbjHKLpX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 07:45:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04C12D70
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Aug 2023 04:45:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EC016359C
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Aug 2023 11:45:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04EDC433CB;
        Fri, 11 Aug 2023 11:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691754321;
        bh=ZlQGdMI5HhXQEhCEkfRCWF2duWx1bEooQYogmucSqYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B8kD6y+2Qg1Tu4SHjx1b8gVhZ4Gzns+8I6hPC9RBNVAWjiyYgQESqktmgtYIxnYdJ
         SY0NoucQHinb6lD9Ne2TP0SQjmLRQqmt6FClYVRaGlp6NkKragA7VvSEYR276m8wuE
         ij8+GiPwxAGlEMkGBJR/J4ajyjzBXmkIrtlsdwFiTkGR8ceXH0Q48aI6MZBbD/2SHi
         fEw2zj9zSs1j4LVmFpLQx1UTjTUqyVMhCWTnEDqlHtWhTsYY0YI/HA14em+kRuzYeS
         tKcqb1E1aRDV6OrieHQF80x+uJCsKEByr66AH15mHedh1Z4pZj6WP6HFfzIF6IdEyT
         UCo1S4UUlt6tA==
From:   Will Deacon <will@kernel.org>
To:     broonie@kernel.org, kristina.martsenko@arm.com,
        Zeng Heng <zengheng4@huawei.com>, catalin.marinas@arm.com,
        shuah@kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, xiexiuqi@huawei.com
Subject: Re: [PATCH v2 0/5] kselftest/arm64: add features check to hwcap test
Date:   Fri, 11 Aug 2023 12:44:57 +0100
Message-Id: <169175305750.3101595.13181051022303674649.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230808134036.668954-1-zengheng4@huawei.com>
References: <20230808134036.668954-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 8 Aug 2023 21:40:31 +0800, Zeng Heng wrote:
> Add new feature checks and provide testing item to support capturing
> SIGBUS exception signal.
> 
> The following is a log snippet from my local testing environment:
> ~~~
>  TAP version 13
>  1..90
>  # CRC32 present
>  ok 1 cpuinfo_match_CRC32
>  ok 2 sigill_CRC32
>  ok 3 # SKIP sigbus_CRC32
>  ok 4 cpuinfo_match_CSSC
>  # sigill_reported for CSSC
>  ok 5 # SKIP sigill_CSSC
>  ok 6 # SKIP sigbus_CSSC
>  # FP present
>  ok 7 cpuinfo_match_FP
>  ok 8 sigill_FP
>  ok 9 # SKIP sigbus_FP
>  # LRCPC present
>  ok 10 cpuinfo_match_LRCPC
>  ok 11 sigill_LRCPC
>  ok 12 # SKIP sigbus_LRCPC
>  # LRCPC2 present
>  ok 13 cpuinfo_match_LRCPC2
>  ok 14 sigill_LRCPC2
>  ok 15 # SKIP sigbus_LRCPC2
>  # LSE present
>  ok 16 cpuinfo_match_LSE
>  ok 17 sigill_LSE
>  ok 18 # SKIP sigbus_LSE
>  # LSE2 present
>  ok 19 cpuinfo_match_LSE2
>  ok 20 sigill_LSE2
>  ok 21 sigbus_LSE2
>  ok 22 cpuinfo_match_MOPS
>  ok 23 sigill_MOPS
>  ok 24 # SKIP sigbus_MOPS
>  # RNG present
>  ok 25 cpuinfo_match_RNG
>  ok 26 sigill_RNG
>  ok 27 # SKIP sigbus_RNG
>  ok 28 cpuinfo_match_RPRFM
>  ok 29 # SKIP sigill_RPRFM
>  ok 30 # SKIP sigbus_RPRFM
>  ok 31 cpuinfo_match_SME
>  ok 32 sigill_SME
>  ok 33 # SKIP sigbus_SME
>  ok 34 cpuinfo_match_SME2
>  ok 35 sigill_SME2
>  ok 36 # SKIP sigbus_SME2
>  ok 37 cpuinfo_match_SME 2.1
>  # sigill_reported for SME 2.1
>  ok 38 # SKIP sigill_SME 2.1
>  ok 39 # SKIP sigbus_SME 2.1
>  ok 40 cpuinfo_match_SME I16I32
>  # sigill_reported for SME I16I32
>  ok 41 # SKIP sigill_SME I16I32
>  ok 42 # SKIP sigbus_SME I16I32
>  ok 43 cpuinfo_match_SME BI32I32
>  # sigill_reported for SME BI32I32
>  ok 44 # SKIP sigill_SME BI32I32
>  ok 45 # SKIP sigbus_SME BI32I32
>  ok 46 cpuinfo_match_SME B16B16
>  # sigill_reported for SME B16B16
>  ok 47 # SKIP sigill_SME B16B16
>  ok 48 # SKIP sigbus_SME B16B16
>  ok 49 cpuinfo_match_SME F16F16
>  # sigill_reported for SME F16F16
>  ok 50 # SKIP sigill_SME F16F16
>  ok 51 # SKIP sigbus_SME F16F16
>  # SVE present
>  ok 52 cpuinfo_match_SVE
>  ok 53 sigill_SVE
>  ok 54 # SKIP sigbus_SVE
>  ok 55 cpuinfo_match_SVE 2
>  # sigill_reported for SVE 2
>  ok 56 # SKIP sigill_SVE 2
>  ok 57 # SKIP sigbus_SVE 2
>  ok 58 cpuinfo_match_SVE 2.1
>  # sigill_reported for SVE 2.1
>  ok 59 # SKIP sigill_SVE 2.1
>  ok 60 # SKIP sigbus_SVE 2.1
>  ok 61 cpuinfo_match_SVE AES
>  # sigill_reported for SVE AES
>  ok 62 # SKIP sigill_SVE AES
>  ok 63 # SKIP sigbus_SVE AES
>  ok 64 cpuinfo_match_SVE2 PMULL
>  # sigill_reported for SVE2 PMULL
>  ok 65 # SKIP sigill_SVE2 PMULL
>  ok 66 # SKIP sigbus_SVE2 PMULL
>  ok 67 cpuinfo_match_SVE2 BITPERM
>  # sigill_reported for SVE2 BITPERM
>  ok 68 # SKIP sigill_SVE2 BITPERM
>  ok 69 # SKIP sigbus_SVE2 BITPERM
>  ok 70 cpuinfo_match_SVE2 SHA3
>  # sigill_reported for SVE2 SHA3
>  ok 71 # SKIP sigill_SVE2 SHA3
>  ok 72 # SKIP sigbus_SVE2 SHA3
>  ok 73 cpuinfo_match_SVE2 SM4
>  # sigill_reported for SVE2 SM4
>  ok 74 # SKIP sigill_SVE2 SM4
>  ok 75 # SKIP sigbus_SVE2 SM4
>  # SVE2 I8MM present
>  ok 76 cpuinfo_match_SVE2 I8MM
>  ok 77 sigill_SVE2 I8MM
>  ok 78 # SKIP sigbus_SVE2 I8MM
>  # SVE2 F32MM present
>  ok 79 cpuinfo_match_SVE2 F32MM
>  ok 80 sigill_SVE2 F32MM
>  ok 81 # SKIP sigbus_SVE2 F32MM
>  # SVE2 F64MM present
>  ok 82 cpuinfo_match_SVE2 F64MM
>  ok 83 sigill_SVE2 F64MM
>  ok 84 # SKIP sigbus_SVE2 F64MM
>  # SVE2 BF16 present
>  ok 85 cpuinfo_match_SVE2 BF16
>  ok 86 sigill_SVE2 BF16
>  ok 87 # SKIP sigbus_SVE2 BF16
>  ok 88 cpuinfo_match_SVE2 EBF16
>  ok 89 # SKIP sigill_SVE2 EBF16
>  ok 90 # SKIP sigbus_SVE2 EBF16
>  # Totals: pass:46 fail:0 xfail:0 xpass:0 skip:44 error:0
> ~~~
> 
> [...]

Applied to arm64 (for-next/selftests), thanks!

[1/5] kselftest/arm64: add float-point feature to hwcap test
      https://git.kernel.org/arm64/c/eb27c76ac9e1
[2/5] kselftest/arm64: add crc32 feature to hwcap test
      https://git.kernel.org/arm64/c/09d2e95a04ad
[3/5] kselftest/arm64: add DEF_SIGHANDLER_FUNC() and DEF_INST_RAISE_SIG() helpers
      https://git.kernel.org/arm64/c/71b634aba362
[4/5] kselftest/arm64: add test item that support to capturing the SIGBUS signal
      https://git.kernel.org/arm64/c/fd49cf088867
[5/5] kselftest/arm64: add lse and lse2 features to hwcap test
      https://git.kernel.org/arm64/c/82e7882b141c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
