Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E68527720
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 May 2022 12:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiEOKqM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 May 2022 06:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236427AbiEOKqA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 May 2022 06:46:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D54BF63
        for <linux-kselftest@vger.kernel.org>; Sun, 15 May 2022 03:45:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9055D60F2A
        for <linux-kselftest@vger.kernel.org>; Sun, 15 May 2022 10:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0B7C34113;
        Sun, 15 May 2022 10:45:56 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Joey Gouly <joey.gouly@arm.com>
Subject: Re: [PATCH v1 0/5] selftests/arm64: MTE check_tags_inclusion cleanups
Date:   Sun, 15 May 2022 11:45:53 +0100
Message-Id: <165261155090.2842438.13387082964795597572.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220510164520.768783-1-broonie@kernel.org>
References: <20220510164520.768783-1-broonie@kernel.org>
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

On Tue, 10 May 2022 17:45:15 +0100, Mark Brown wrote:
> This series contains some random cleanups and improvements that I came
> up with while looking at the check_tags_inclusion test.  There's nothing
> too exciting in here but the changes did seem like they might help the
> next person to look at this.
> 
> Mark Brown (5):
>   selftests/arm64: Log errors in verify_mte_pointer_validity()
>   selftests/arm64: Allow zero tags in mte_switch_mode()
>   selftests/arm64: Check failures to set tags in check_tags_inclusion
>   selftests/arm64: Remove casts to/from void in check_tags_inclusion
>   selftests/arm64: Use switch statements in mte_common_util.c
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/5] selftests/arm64: Log errors in verify_mte_pointer_validity()
      https://git.kernel.org/arm64/c/9a5681710740
[2/5] selftests/arm64: Allow zero tags in mte_switch_mode()
      https://git.kernel.org/arm64/c/ffc8274c2193
[3/5] selftests/arm64: Check failures to set tags in check_tags_inclusion
      https://git.kernel.org/arm64/c/72d6771cb173
[4/5] selftests/arm64: Remove casts to/from void in check_tags_inclusion
      https://git.kernel.org/arm64/c/541235dee011
[5/5] selftests/arm64: Use switch statements in mte_common_util.c
      https://git.kernel.org/arm64/c/0639e02254e6

-- 
Catalin

