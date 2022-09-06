Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B57E5AF2FB
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 19:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiIFRph (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Sep 2022 13:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiIFRpg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Sep 2022 13:45:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254DC5C9CA
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Sep 2022 10:45:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 403DD615A4
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Sep 2022 17:45:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52974C433C1;
        Tue,  6 Sep 2022 17:45:30 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] kselftest/arm64: Add simple hwcap validation
Date:   Tue,  6 Sep 2022 18:45:28 +0100
Message-Id: <166248629287.3558870.14220341700427395787.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220829154602.827275-1-broonie@kernel.org>
References: <20220829154602.827275-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 29 Aug 2022 16:46:02 +0100, Mark Brown wrote:
> Add some trivial hwcap validation which checks that /proc/cpuinfo and
> AT_HWCAP agree with each other and can verify that for extensions that can
> generate a SIGILL due to adding new instructions one appears or doesn't
> appear as expected. I've added SVE and SME, other capabilities can be
> added later if this gets merged.
> 
> This isn't super exciting but on the other hand took very little time to
> write and should be handy when verifying that you wired up AT_HWCAP
> properly.
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: Add simple hwcap validation
      https://git.kernel.org/arm64/c/7a9bcaaad5f1

-- 
Catalin

