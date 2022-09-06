Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0E05AF2F9
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 19:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiIFRp0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Sep 2022 13:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIFRpY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Sep 2022 13:45:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB9A51432
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Sep 2022 10:45:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E9C6615E0
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Sep 2022 17:45:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C8EC433D6;
        Tue,  6 Sep 2022 17:45:20 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/4] kselftest/arm64: Floating point stress test harness
Date:   Tue,  6 Sep 2022 18:45:18 +0100
Message-Id: <166248629287.3558870.9162998590250021356.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220829154452.824870-1-broonie@kernel.org>
References: <20220829154452.824870-1-broonie@kernel.org>
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

On Mon, 29 Aug 2022 16:44:48 +0100, Mark Brown wrote:
> This series has a few small enhancements for the existing standalone
> floating point stress tests and then builds on those with a kselftest
> integrated program which gives those a very quick spin from within
> kselftest, as well as having an option to set a custom timeout to allow
> for use with longer soak testing. This makes it much easier to get
> thorough testing of the floating point state management logic, rather
> than requiring custom setup for coverage of the various vector lengths
> in the system as is needed at present.
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/4] kselftest/arm64: Always encourage preemption for za-test
      https://git.kernel.org/arm64/c/9e40e6272353
[2/4] kselftest/arm64: Count SIGUSR2 deliveries in FP stress tests
      https://git.kernel.org/arm64/c/05a5980f7ff5
[3/4] kselftest/arm64: Install signal handlers before output in FP stress tests
      https://git.kernel.org/arm64/c/000aef672bf2
[4/4] kselftest/arm64: kselftest harness for FP stress tests
      https://git.kernel.org/arm64/c/bce4950aa05c

-- 
Catalin

