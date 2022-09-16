Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9A75BB1BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Sep 2022 19:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiIPRqx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Sep 2022 13:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiIPRqw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Sep 2022 13:46:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2231E90C72
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Sep 2022 10:46:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B353862D0D
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Sep 2022 17:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE466C433C1;
        Fri, 16 Sep 2022 17:46:49 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 0/3] kselftest/arm64: Updates to the hwcaps test
Date:   Fri, 16 Sep 2022 18:46:47 +0100
Message-Id: <166335040202.1744928.9920209718958629167.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220913141101.151400-1-broonie@kernel.org>
References: <20220913141101.151400-1-broonie@kernel.org>
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

On Tue, 13 Sep 2022 15:10:58 +0100, Mark Brown wrote:
> This series fixes an output formatting issue then adds a bunch
> more hwcaps to the hwcaps test.  This includes the recently added
> SVE EBF16 hwcap so this requires both for-next/kselftest and
> for-next/sve.
> 
> Mark Brown (3):
>   kselftest/arm64: Add missing newline in hwcap output
>   kselftest/arm64: Add SVE 2 to the tested hwcaps
>   kselftest/arm64: Add hwcap test for RNG
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/3] kselftest/arm64: Add missing newline in hwcap output
      https://git.kernel.org/arm64/c/78d2b1976b51
[2/3] kselftest/arm64: Add SVE 2 to the tested hwcaps
      https://git.kernel.org/arm64/c/859a9d51a268
[3/3] kselftest/arm64: Add hwcap test for RNG
      https://git.kernel.org/arm64/c/ef939f30510b

-- 
Catalin

