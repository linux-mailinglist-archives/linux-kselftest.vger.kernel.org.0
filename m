Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77847B387C
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Sep 2023 19:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjI2RS5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Sep 2023 13:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjI2RS5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Sep 2023 13:18:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1666E1A7;
        Fri, 29 Sep 2023 10:18:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7692C433C8;
        Fri, 29 Sep 2023 17:18:52 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/2] Report FEAT_SVE_B16B16 to userspace
Date:   Fri, 29 Sep 2023 18:18:49 +0100
Message-Id: <169600792627.1559809.9041922106770709135.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230915-arm64-zfr-b16b16-el0-v1-0-f9aba807bdb5@kernel.org>
References: <20230915-arm64-zfr-b16b16-el0-v1-0-f9aba807bdb5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 15 Sep 2023 13:18:05 +0100, Mark Brown wrote:
> SVE 2.1 introduced a new feature FEAT_SVE_B16B16 which adds instructions
> supporting the BFloat16 floating point format. Report this to userspace
> through the ID registers and hwcap.
> 
> 

Applied to arm64 (for-next/feat_sve_b16b16), thanks!

[1/2] arm64/sve: Report FEAT_SVE_B16B16 to userspace
      https://git.kernel.org/arm64/c/5d5b4e8c2d9e
[2/2] kselftest/arm64: Verify HWCAP2_SVE_B16B16
      https://git.kernel.org/arm64/c/3accaef1f61e

-- 
Catalin

