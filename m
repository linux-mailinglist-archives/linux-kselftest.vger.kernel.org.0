Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855A25E6C93
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Sep 2022 22:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiIVUCM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Sep 2022 16:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiIVUBr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Sep 2022 16:01:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCDC2EF16
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Sep 2022 13:01:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1AB5637F4
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Sep 2022 20:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48DDC433C1;
        Thu, 22 Sep 2022 20:01:27 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] kselftest/arm64: Fix typo in hwcap check
Date:   Thu, 22 Sep 2022 21:01:25 +0100
Message-Id: <166387688046.428722.11597179972445429521.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220907113400.12982-1-broonie@kernel.org>
References: <20220907113400.12982-1-broonie@kernel.org>
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

On Wed, 7 Sep 2022 12:33:59 +0100, Mark Brown wrote:
> We use a local variable hwcap to refer to the element of the hwcaps array
> which we are currently checking. When checking for the relevant hwcap bit
> being set in testing we were dereferencing hwcaps rather than hwcap in
> fetching the AT_HWCAP to use, which is perfectly valid C but means we were
> always checking the bit was set in the hwcap for whichever feature is first
> in the array. Remove the stray s.
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: Fix typo in hwcap check
      https://git.kernel.org/arm64/c/33060a64901e

-- 
Catalin

