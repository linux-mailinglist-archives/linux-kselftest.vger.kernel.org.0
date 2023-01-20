Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359CA675AAF
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jan 2023 18:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjATRC5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 12:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjATRC4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 12:02:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4A2A95A2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 09:02:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C0846200F
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 17:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B001CC4339B;
        Fri, 20 Jan 2023 17:02:53 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/4] arm64/signal: Support TPIDR2
Date:   Fri, 20 Jan 2023 17:02:51 +0000
Message-Id: <167423399654.2326835.13582265510509139111.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221208-arm64-tpidr2-sig-v3-0-c77c6c8775f4@kernel.org>
References: <20221208-arm64-tpidr2-sig-v3-0-c77c6c8775f4@kernel.org>
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

On Tue, 27 Dec 2022 14:20:40 +0000, Mark Brown wrote:
> When SME support was merged support for TPIDR2 in signal frames was
> omitted, meaning that it was not possible for signal handers to inspect
> or modify it. This will present an issue for programs using signals to
> implement lightweight threads so let's provide access to TPIDR2 in
> signal handlers.
> 
> Implement a new record type for TPIDR2 using the same format as we use
> for ESR and add coverage to make sure that this appears in the signal
> context as expected.  Due to TPIDR2 being reserved for libc we only
> validate that the value is unchanged, meaning we're likely to just be
> validating the default value of 0 on current systems. I have tested with
> a modified version that sets an explicit value.
> 
> [...]

Applied to arm64 (for-next/tpidr2), thanks!

[1/4] arm64/sme: Document ABI for TPIDR2 signal information
      https://git.kernel.org/arm64/c/17d0c4a27b2a
[2/4] arm64/signal: Include TPIDR2 in the signal context
      https://git.kernel.org/arm64/c/39e54499280f
[3/4] kselftest/arm64: Add TPIDR2 to the set of known signal context records
      https://git.kernel.org/arm64/c/bae393dabf35
[4/4] kselftest/arm64: Add test case for TPIDR2 signal frame records
      https://git.kernel.org/arm64/c/8ced92801935

I'll look at the signal handling clean-up patches as well but they
probably conflicts with this series and may need to be rebased on top.

-- 
Catalin

