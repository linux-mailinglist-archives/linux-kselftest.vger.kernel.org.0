Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA1868E0A3
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Feb 2023 19:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjBGSy1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Feb 2023 13:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjBGSy0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Feb 2023 13:54:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC4819A
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Feb 2023 10:54:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A43860FB8
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Feb 2023 18:54:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972D5C4339B;
        Tue,  7 Feb 2023 18:54:22 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Copy whole EXTRA context
Date:   Tue,  7 Feb 2023 18:54:20 +0000
Message-Id: <167579605776.3462867.12167648868281737543.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201-arm64-kselftest-full-extra-v1-1-93741f32dd29@kernel.org>
References: <20230201-arm64-kselftest-full-extra-v1-1-93741f32dd29@kernel.org>
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

On Thu, 02 Feb 2023 17:30:44 +0000, Mark Brown wrote:
> When copying the EXTRA context our calculation of the amount of data we
> need to copy is incorrect, we only calculate the amount of data needed
> within uc_mcontext.__reserved, not taking account of the fixed portion
> of the context. Add in the offset of the reserved data so that we copy
> everything we should.
> 
> This will only cause test failures in cases where the last context in the
> EXTRA context is smaller than the missing data since we don't currently
> validate any of the register data and all the buffers we copy into are
> statically allocated so default to zero meaning that if we walk beyond the
> end of what we copied we'll encounter what looks like a context with magic
> and length both 0 which is a valid terminator record.
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: Copy whole EXTRA context
      https://git.kernel.org/arm64/c/6012b8202022

-- 
Catalin

