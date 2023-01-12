Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76607667DC4
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jan 2023 19:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjALSTD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Jan 2023 13:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240385AbjALSSD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Jan 2023 13:18:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341931C2
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jan 2023 09:49:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3208620DE
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jan 2023 17:49:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFFDC433D2;
        Thu, 12 Jan 2023 17:49:04 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Skip non-power of 2 SVE vector lengths in fp-stress
Date:   Thu, 12 Jan 2023 17:49:02 +0000
Message-Id: <167354570430.3643775.15979675081823392866.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221220-arm64-fp-stress-pow2-v1-1-d0ce756b57af@kernel.org>
References: <20221220-arm64-fp-stress-pow2-v1-1-d0ce756b57af@kernel.org>
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

On Tue, 27 Dec 2022 13:07:45 +0000, Mark Brown wrote:
> As documented in issue C215 in the known issues list for DDI0487I.a [1] Arm
> will be making a retroactive change to SVE to remove the possibility of
> selecting non power of two vector lengths. This has no impact on existing
> physical implementations but most virtual implementations have implemented
> the full range of permissible vector lengths. Given how demanding fp-stress
> is for these implementations update to only attempt to enumerate the power
> of two vector lengths, reducing the load created on existing virtual
> implementations and only exercising the functionality that will be seen in
> physical implementations.
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: Skip non-power of 2 SVE vector lengths in fp-stress
      https://git.kernel.org/arm64/c/67f49869106f

-- 
Catalin

