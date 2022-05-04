Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BC1519B0D
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 May 2022 11:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236921AbiEDJFv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 May 2022 05:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiEDJFt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 May 2022 05:05:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7921705B
        for <linux-kselftest@vger.kernel.org>; Wed,  4 May 2022 02:02:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 269A86192E
        for <linux-kselftest@vger.kernel.org>; Wed,  4 May 2022 09:02:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F9EC385A4;
        Wed,  4 May 2022 09:02:11 +0000 (UTC)
Date:   Wed, 4 May 2022 10:02:07 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Fix ABI header directory location
Message-ID: <YnJBDyexzm4JWTK7@arm.com>
References: <20220503231655.211346-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503231655.211346-1-broonie@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 04, 2022 at 12:16:55AM +0100, Mark Brown wrote:
> Currently the arm64 kselftests attempt to locate the ABI headers using
> custom logic which doesn't work correctly in the case of out of tree builds
> if KBUILD_OUTPUT is not specified. Since lib.mk defines KHDR_INCLUDES with
> the appropriate flags we can simply remove the custom logic and use that
> instead.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> 
> This fix is required to get us able to run the arm64 kselftests
> in KernelCI, it does out of tree kselftest builds triggering the
> issue especially in conjunction with the addition of the new
> definitions for SME.
> 
>  tools/testing/selftests/arm64/Makefile | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
> index 1e8d9a8f59df..9460cbe81bcc 100644
> --- a/tools/testing/selftests/arm64/Makefile
> +++ b/tools/testing/selftests/arm64/Makefile
> @@ -17,16 +17,7 @@ top_srcdir = $(realpath ../../../../)
>  # Additional include paths needed by kselftest.h and local headers
>  CFLAGS += -I$(top_srcdir)/tools/testing/selftests/
>  
> -# Guessing where the Kernel headers could have been installed
> -# depending on ENV config
> -ifeq ($(KBUILD_OUTPUT),)
> -khdr_dir = $(top_srcdir)/usr/include
> -else
> -# the KSFT preferred location when KBUILD_OUTPUT is set
> -khdr_dir = $(KBUILD_OUTPUT)/kselftest/usr/include
> -endif
> -
> -CFLAGS += -I$(khdr_dir)
> +CFLAGS += $(KHDR_INCLUDES)

Great, thanks. I had exactly the same diff stashed last week when
testing the kselftest branch, just forgot about posting it. I'll apply
yours.

-- 
Catalin
