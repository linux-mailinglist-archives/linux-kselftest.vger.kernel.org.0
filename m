Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D47656B37
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 14:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbiL0NHW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Dec 2022 08:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiL0NGy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Dec 2022 08:06:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6517D277;
        Tue, 27 Dec 2022 05:06:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 144AAB81018;
        Tue, 27 Dec 2022 13:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A846C433D2;
        Tue, 27 Dec 2022 13:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672146410;
        bh=3ILPi1ChGnvR1ETggv6KNQ4ch36Nx40vsMckHaMpbOM=;
        h=From:Subject:Date:To:Cc:From;
        b=idx29gCQxi2nBZTKMsgrNDZOcjG8UCqbtmcuRc9KVd7rIIyKX3ZkWzV/sz5lHiInr
         0JrK/D5NZ0imfdv63qgewWcZ8xCEOr4hJKWD3VRShJJGibrrQHkzyB1a95a7aiGWNq
         TrGM0+bDGrFQgzizgOH7NoHBRsokXaovtRm2kUZxSbdzOdGkoYPjvXPrJz6NJ6tild
         SDuGtIzoxp0cnyfZ3aHQq/SGsIEk+9yHVefajHdxAmbb9gH1eQnSCQCG1+aD+vfxlx
         pHbIysQ20bQccFxnEpjsIiTZ1C0zFV4Ln1Hy2mgjm94kD3dVeYulNO9ZGhsEjXyx2I
         ivWqnax2bZPxw==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/4] kselftest/arm64: syscall-abi fix and enhancements
Date:   Tue, 27 Dec 2022 13:06:35 +0000
Message-Id: <20221223-arm64-syscall-abi-sme-only-v1-0-4fabfbd62087@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANztqmMC/x2NQQrCQAwAv1JyNtBNVcSviIfsmtrgdisJVEvp3
 916nDnMrOBiKg7XZgWTWV2nUiEcGkgDl6egPioDtUSBqEO28XxEXzxxzshR0UfBqeQFUxcjpba/
 BDlBDUR2wWhc0rAnPpO9dv026fX7f97u2/YD9US2AYMAAAA=
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-7ab1d
X-Developer-Signature: v=1; a=openpgp-sha256; l=1283; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3ILPi1ChGnvR1ETggv6KNQ4ch36Nx40vsMckHaMpbOM=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhuRVb59czLoifuBdZr5Cpt6xg/FHpfbf/Vdw6MbM5Kh1WTNF
 xaNVOhmNWRgYuRhkxRRZ1j7LWJUeLrF1/qP5r2AGsTKBTGHg4hSAi+iy/xV3TImOV8sqzFD8lfqj/Z
 FZsY5Al/uOdlP+dNb2W20/vpXb6UbJ5ljEFeQVrIzuWhD+eiH/krW2T/TlNi1kCG3sZf1R6OE8VyRT
 I+Vz+ETljz3XspLl9shEvf8g/eqATk+QpNnJb2cTJ/pfSFnFU3ruw9WMR3Ms3NYIsLS2FgqoP63d3K
 Zxz7KYcX+m6YH7P/75X77pc+OmSYTUpom7r7ennf1f+krcPOLjg2CHz7uUd/jPT28UUP6fVCV8++GH
 qC9ZEg+ufdK09PgZXBr4kl1iYeKkrpQLAY7pUos+ib8L541WnWAif+xqcULTJ69ZUkdyDVpCRCTl9h
 fPOHGj/0zBf+OtDjE/Vppaiy0HAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The first patch here is a fix which should ideally be sent as such,
currently the program will hang on architecturally valid systems which
implement SME but not 128 bit vector lengths.  The remaining patches
are general enhancements, including coverage for the SME ABI on SME only
systems.

To: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

---
Mark Brown (4):
      kselftest/arm64: Fix syscall-abi for systems without 128 bit SME
      kselftest/arm64: Only enumerate VLs once in syscall-abi
      kselftest/arm64: Verify SME only ABI in syscall-abi
      kselftest/arm64: Only enumerate power of two VLs in syscall-abi

 .../testing/selftests/arm64/abi/syscall-abi-asm.S  |  14 ++-
 tools/testing/selftests/arm64/abi/syscall-abi.c    | 133 +++++++++++++--------
 2 files changed, 89 insertions(+), 58 deletions(-)
---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20221223-arm64-syscall-abi-sme-only-c3bb2c0f81e5

Best regards,
-- 
Mark Brown <broonie@kernel.org>
