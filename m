Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783C0528D5A
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 May 2022 20:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbiEPSpl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 May 2022 14:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344972AbiEPSpk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 May 2022 14:45:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728CE30C
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 11:45:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2ADBBB815D4
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 18:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6E7C385AA;
        Mon, 16 May 2022 18:45:35 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] kselftest/arm64: Explicitly build no BTI tests with BTI disabled
Date:   Mon, 16 May 2022 19:45:33 +0100
Message-Id: <165272667337.3711461.9449394169951019984.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220516182213.727589-1-broonie@kernel.org>
References: <20220516182213.727589-1-broonie@kernel.org>
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

On Mon, 16 May 2022 19:22:13 +0100, Mark Brown wrote:
> In case a distribution enables branch protection by default do as we do for
> the main kernel and explicitly disable branch protection when building the
> test case for having BTI disabled to ensure it doesn't get turned on by the
> toolchain defaults.
> 
> 

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: Explicitly build no BTI tests with BTI disabled
      https://git.kernel.org/arm64/c/9f93c2e0cda4

-- 
Catalin

