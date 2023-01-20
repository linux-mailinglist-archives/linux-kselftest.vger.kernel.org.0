Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29516675A9B
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jan 2023 17:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjATQ7I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 11:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjATQ7I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 11:59:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AD8CA2C;
        Fri, 20 Jan 2023 08:59:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97DFDB82941;
        Fri, 20 Jan 2023 16:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E8FC433D2;
        Fri, 20 Jan 2023 16:59:01 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] kselftest/arm64: Minor SME signals test additions
Date:   Fri, 20 Jan 2023 16:58:59 +0000
Message-Id: <167423393397.2326323.2802825304933346792.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230117-arm64-test-ssve-za-v1-0-203c00150154@kernel.org>
References: <20230117-arm64-test-ssve-za-v1-0-203c00150154@kernel.org>
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

On Fri, 20 Jan 2023 12:04:08 +0000, Mark Brown wrote:
> While discussing the SME signal handling support I realised that
> we were not verifying that SVE_SIG_FLAG_SM is set for streaming
> SVE, and not explicitly covering the case where we are both in
> streaming mode and have ZA enabled.  Add coverage of these cases,
> I didn't find any problems running these new tests.
> 
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/2] kselftest/arm64: Verify that SSVE signal context has SVE_SIG_FLAG_SM set
      https://git.kernel.org/arm64/c/f76cb73a2d7c
[2/2] kselftest/arm64: Verify simultaneous SSVE and ZA context generation
      https://git.kernel.org/arm64/c/bc69da5ff087

-- 
Catalin

