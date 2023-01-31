Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68092683291
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 17:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjAaQ25 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 11:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjAaQ2r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 11:28:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E26CD537;
        Tue, 31 Jan 2023 08:28:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27AA56136F;
        Tue, 31 Jan 2023 16:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F21C433EF;
        Tue, 31 Jan 2023 16:28:28 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Limit the maximum VL we try to set via ptrace
Date:   Tue, 31 Jan 2023 16:28:25 +0000
Message-Id: <167518250322.582901.15647652127648162465.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111-arm64-kselftest-ptrace-max-vl-v1-1-8167f41d1ad8@kernel.org>
References: <20230111-arm64-kselftest-ptrace-max-vl-v1-1-8167f41d1ad8@kernel.org>
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

On Wed, 11 Jan 2023 15:02:41 +0000, Mark Brown wrote:
> When SVE was initially merged we chose to export the maximum VQ in the ABI
> as being 512, rather more than the architecturally supported maximum of 16.
> For the ptrace tests this results in us generating a lot of test cases and
> hence log output which are redundant since a system couldn't possibly
> support them. Instead only check values up to the current architectural
> limit, plus one more so that we're covering the constraining of higher
> vector lengths.
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: Limit the maximum VL we try to set via ptrace
      https://git.kernel.org/arm64/c/89ff30b9b720

-- 
Catalin

