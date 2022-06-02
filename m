Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417D653BF12
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jun 2022 21:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238995AbiFBToS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Jun 2022 15:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238998AbiFBToI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Jun 2022 15:44:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D7111827
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Jun 2022 12:43:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A986617D8
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Jun 2022 19:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2FFC34114;
        Thu,  2 Jun 2022 19:43:35 +0000 (UTC)
Date:   Thu, 2 Jun 2022 20:43:32 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/arm64: Fix mismerge of Makefile for fp tests
Message-ID: <YpkS5NXLCxyhN5E9@arm.com>
References: <20220524151454.1487390-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524151454.1487390-1-broonie@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 24, 2022 at 04:14:54PM +0100, Mark Brown wrote:
> The FP Makefile defines two TEST_PROGS_EXTENDED instead of one of them and one
> one TEST_GEN_PROGS_EXTENDED for the programs that need compilation. Fix
> that.
> 
> Fixes: a59f7a7f76407da78 ("selftests/arm64: Use TEST_GEN_PROGS_EXTENDED in the FP Makefile")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/arm64/fp/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
> index a41fef2c9669..36db61358ed5 100644
> --- a/tools/testing/selftests/arm64/fp/Makefile
> +++ b/tools/testing/selftests/arm64/fp/Makefile
> @@ -9,7 +9,7 @@ TEST_GEN_PROGS := fp-stress \
>  	sve-ptrace sve-probe-vls \
>  	vec-syscfg \
>  	za-fork za-ptrace
> -TEST_PROGS_EXTENDED := fp-pidbench fpsimd-test \
> +TEST_GEN_PROGS_EXTENDED := fp-pidbench fpsimd-test \
>  	rdvl-sme rdvl-sve \
>  	sve-test \
>  	ssve-test \

Do we still need this? The fixed commit already uses
TEST_GEN_PROGS_EXTENDED and that's what it seems to be in current
mainline. Unless there was a mismerge in -next (I haven't checked).

-- 
Catalin
