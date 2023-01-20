Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E6F675AA1
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jan 2023 17:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjATQ74 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 11:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjATQ74 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 11:59:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9574CA2C;
        Fri, 20 Jan 2023 08:59:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A6BCB82953;
        Fri, 20 Jan 2023 16:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63891C433EF;
        Fri, 20 Jan 2023 16:59:49 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 00/21] arm64/sme: Support SME 2 and SME 2.1
Date:   Fri, 20 Jan 2023 16:59:47 +0000
Message-Id: <167423398183.2326692.12557815651191750122.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
References: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
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

On Mon, 16 Jan 2023 16:04:36 +0000, Mark Brown wrote:
> Arm have recently released versions 2 and 2.1 of the SME extension.
> Among the features introduced by SME 2 is some new architectural state,
> the ZT0 register. This series adds support for this and all the other
> features of the new SME versions.
> 
> Since the architecture has been designed with the possibility of adding
> further ZTn registers in mind the interfaces added for ZT0 are done with
> this possibility in mind. As ZT0 is a simple fixed size register these
> interfaces are all fairly simple, the main complication is that ZT0 is
> only accessible when PSTATE.ZA is enabled. The memory allocation that we
> already do for PSTATE.ZA is extended to include space for ZT0.
> 
> [...]

Applied to arm64 (for-next/sme2), thanks!

[01/21] arm64/sme: Rename za_state to sme_state
        https://git.kernel.org/arm64/c/ce514000da4f
[02/21] arm64: Document boot requirements for SME 2
        https://git.kernel.org/arm64/c/6dabf1fac6b4
[03/21] arm64/sysreg: Update system registers for SME 2 and 2.1
        https://git.kernel.org/arm64/c/0f3bbe0edf78
[04/21] arm64/sme: Document SME 2 and SME 2.1 ABI
        https://git.kernel.org/arm64/c/4edc11744e8c
[05/21] arm64/esr: Document ISS for ZT0 being disabled
        https://git.kernel.org/arm64/c/8ef55603b8ea
[06/21] arm64/sme: Manually encode ZT0 load and store instructions
        https://git.kernel.org/arm64/c/2cdeecdb9513
[07/21] arm64/sme: Enable host kernel to access ZT0
        https://git.kernel.org/arm64/c/f122576f3533
[08/21] arm64/sme: Add basic enumeration for SME2
        https://git.kernel.org/arm64/c/d4913eee152d
[09/21] arm64/sme: Provide storage for ZT0
        https://git.kernel.org/arm64/c/d6138b4adc70
[10/21] arm64/sme: Implement context switching for ZT0
        https://git.kernel.org/arm64/c/95fcec713259
[11/21] arm64/sme: Implement signal handling for ZT
        https://git.kernel.org/arm64/c/ee072cf70804
[12/21] arm64/sme: Implement ZT0 ptrace support
        https://git.kernel.org/arm64/c/f90b529bcbe5
[13/21] arm64/sme: Add hwcaps for SME 2 and 2.1 features
        https://git.kernel.org/arm64/c/7d5d8601e457
[14/21] kselftest/arm64: Add a stress test program for ZT0
        https://git.kernel.org/arm64/c/1c07425e902c
[15/21] kselftest/arm64: Cover ZT in the FP stress test
        https://git.kernel.org/arm64/c/f63a9f15b2d4
[16/21] kselftest/arm64: Enumerate SME2 in the signal test utility code
        https://git.kernel.org/arm64/c/638293732608
[17/21] kselftest/arm64: Teach the generic signal context validation about ZT
        https://git.kernel.org/arm64/c/afe6f1827526
[18/21] kselftest/arm64: Add test coverage for ZT register signal frames
        https://git.kernel.org/arm64/c/18f8729ab3d5
[19/21] kselftest/arm64: Add SME2 coverage to syscall-abi
        https://git.kernel.org/arm64/c/49886aa9ab33
[20/21] kselftest/arm64: Add coverage of the ZT ptrace regset
        https://git.kernel.org/arm64/c/4e1aa1a18f1b
[21/21] kselftest/arm64: Add coverage of SME 2 and 2.1 hwcaps
        https://git.kernel.org/arm64/c/3eb1b41fba97

-- 
Catalin

