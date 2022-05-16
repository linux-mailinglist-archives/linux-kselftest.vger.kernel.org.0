Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D82D528C9A
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 May 2022 20:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344553AbiEPSJp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 May 2022 14:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344494AbiEPSJo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 May 2022 14:09:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21E73D4A9
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 11:09:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A6AFB815AE
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 18:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAAE2C385AA;
        Mon, 16 May 2022 18:09:39 +0000 (UTC)
Date:   Mon, 16 May 2022 19:09:36 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Explicitly build no BTI tests with BTI
 disabled
Message-ID: <YoKTYFtXMsZW/+Iq@arm.com>
References: <20220511161004.189348-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511161004.189348-1-broonie@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 11, 2022 at 05:10:04PM +0100, Mark Brown wrote:
> In case a distribution enables branch protection by default do as we do for
> the main kernel and explicitly disable branch protection when building the
> test case for having BTI disabled to ensure it doesn't get turned on by the
> toolchain defaults.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/arm64/bti/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/arm64/bti/Makefile b/tools/testing/selftests/arm64/bti/Makefile
> index 10a12c5e05e6..a3e59d7910b3 100644
> --- a/tools/testing/selftests/arm64/bti/Makefile
> +++ b/tools/testing/selftests/arm64/bti/Makefile
> @@ -14,7 +14,7 @@ CFLAGS += -I../../../../../usr/include/
>  
>  CFLAGS_STATIC = -ffreestanding
>  
> -CFLAGS_NOBTI = -DBTI=0
> +CFLAGS_NOBTI = -mbranch-protection=none -DBTI=0
>  CFLAGS_BTI = -mbranch-protection=standard -DBTI=1

Do I miss an patches? I can't see the CFLAGS_STATIC in the arm64
branches, nor in next.

-- 
Catalin
