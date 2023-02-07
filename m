Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5865168E0A4
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Feb 2023 19:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjBGSyf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Feb 2023 13:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBGSye (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Feb 2023 13:54:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEEF103
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Feb 2023 10:54:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A041DB81ABA
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Feb 2023 18:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA34C433EF;
        Tue,  7 Feb 2023 18:54:29 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Don't require FA64 for streaming SVE+ZA tests
Date:   Tue,  7 Feb 2023 18:54:27 +0000
Message-Id: <167579605776.3462867.15516911798611550805.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202-arm64-kselftest-sve-za-fa64-v1-1-5c5f3dabe441@kernel.org>
References: <20230202-arm64-kselftest-sve-za-fa64-v1-1-5c5f3dabe441@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 02 Feb 2023 17:31:25 +0000, Mark Brown wrote:
> During early development a dependedncy was added on having FA64
> available so we could use the full FPSIMD register set in the signal
> handler which got copied over into the SSVE+ZA registers test case.
> Subsequently the ABI was finialised so the handler is run with streaming
> mode disabled meaning this is redundant but the dependency was never
> removed, do so now.
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: Don't require FA64 for streaming SVE+ZA tests
      https://git.kernel.org/arm64/c/2c4192c0a7f2

-- 
Catalin

