Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CE95C0532
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Sep 2022 19:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiIURTV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Sep 2022 13:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIURTU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Sep 2022 13:19:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEF19E6A1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Sep 2022 10:19:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 380846259B
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Sep 2022 17:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC225C433C1;
        Wed, 21 Sep 2022 17:19:16 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Luis Machado <luis.machado@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Alan Hayward <alan.hayward@arm.com>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 0/4] arm64/sme: ptrace support for TPIDR2_EL0
Date:   Wed, 21 Sep 2022 18:19:14 +0100
Message-Id: <166378074640.3946796.15081323710769114507.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220829154921.837871-1-broonie@kernel.org>
References: <20220829154921.837871-1-broonie@kernel.org>
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

On Mon, 29 Aug 2022 16:49:17 +0100, Mark Brown wrote:
> When SME was initially merged we did not add support for TPIDR2_EL0 to
> the ptrace interface, creating difficulties for debuggers in accessing
> lazy save state for ZA. This series implements that support, extending
> the existing NT_ARM_TLS regset to support the register when available,
> and adds kselftest coverage for the existing and new NT_ARM_TLS
> functionality.
> 
> [...]

Applied to arm64 (for-next/tpidr2_el0), thanks!

[1/4] kselftest/arm64: Add test coverage for NT_ARM_TLS
      https://git.kernel.org/arm64/c/ecaf4d3f734f
[2/4] arm64/ptrace: Document extension of NT_ARM_TLS to cover TPIDR2_EL0
      https://git.kernel.org/arm64/c/f285da05c62a
[3/4] arm64/ptrace: Support access to TPIDR2_EL0
      https://git.kernel.org/arm64/c/0027d9c6c7b5
[4/4] kselftest/arm64: Add coverage of TPIDR2_EL0 ptrace interface
      https://git.kernel.org/arm64/c/2ddadec2206c

-- 
Catalin

