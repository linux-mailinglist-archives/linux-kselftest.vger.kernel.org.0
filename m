Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20905AF2F8
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 19:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiIFRpX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Sep 2022 13:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIFRpT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Sep 2022 13:45:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3871A4CA1B
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Sep 2022 10:45:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5124B615CE
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Sep 2022 17:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E90C433D7;
        Tue,  6 Sep 2022 17:45:10 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/2] kselftest/arm64: Small improvements to ZA signal handling coverag
Date:   Tue,  6 Sep 2022 18:45:07 +0100
Message-Id: <166248629287.3558870.8336130926049465914.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220829155728.854947-1-broonie@kernel.org>
References: <20220829155728.854947-1-broonie@kernel.org>
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

On Mon, 29 Aug 2022 16:57:26 +0100, Mark Brown wrote:
> These patches improve the coverage of ZA signal contexts a bit, adding
> some validation that the actual data is correct and covering the case
> where ZA is not enabled.
> 
> v2:
>  - Rebase onto v6.0-rc3.
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/2] kselftest/arm64: Tighten up validation of ZA signal context
      https://git.kernel.org/arm64/c/f02b69a6e4d1
[2/2] kselftest/arm64: Add a test for signal frames with ZA disabled
      https://git.kernel.org/arm64/c/4bcfa65860b2

-- 
Catalin

