Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B3E58DC4E
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Aug 2022 18:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiHIQmG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Aug 2022 12:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiHIQmF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Aug 2022 12:42:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2FEFD0A;
        Tue,  9 Aug 2022 09:42:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 786A4B81625;
        Tue,  9 Aug 2022 16:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7C6C433D6;
        Tue,  9 Aug 2022 16:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660063322;
        bh=qT8jDmuiFc3HywToOTDU9Y76BLsYGRgW98tqTj1tplQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GVkaWOpXNUoUgOzIow1IXae7WD7ZKP+aZ6ZCwYT9KkpSb7JAd+Yr9XscF8m3Uy6mi
         d+MfT7LACepLGR7J3t1lDDXiFaTlzBBSFtTinMP50ffWBjSEWxP/46RN+wSvfDsSuC
         ZiG9OrcUbLtJrdXXNOUdQcHOS0C2UoxczZjumAoslLdsYhXT1LD1nAzf7TY9bWlPAn
         FbKbSycV7FXFXYT4XCN9HNZbzIH1e9cWC1qEWz0jMFqCZpTwSRbqBrJKvnaC6R4dMN
         1ISVLvfhhaR3ZcrnImE3xjy854t7+3cenxovO9kgqjNuUvkX93JeUFN+khSV0OgGot
         I7d65rATiOYaA==
Date:   Tue, 9 Aug 2022 09:41:59 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Mark Brown <broonie@kernel.org>,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] selftests: fix LLVM build for i386 and x86_64
Message-ID: <YvKOV1L73Mv/Dc6P@dev-arch.thelio-3990X>
References: <20220809142231.2419274-1-guillaume.tucker@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809142231.2419274-1-guillaume.tucker@collabora.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 09, 2022 at 04:22:31PM +0200, Guillaume Tucker wrote:
> Add missing cases for the i386 and x86_64 architectures when
> determining the LLVM target for building kselftest.
> 
> Fixes: 795285ef2425 ("selftests: Fix clang cross compilation")
> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>

Right, I think this is the correct thing to do for the selftests. For
the main kernel build, we use CLANG_TARGETS_FLAGS_x86 because ARCH=i386
and ARCH=x86_64 are covered by SUBARCH=x86, which is what we switch on,
rather than ARCH. I do see a couple of references to SUBARCH in the
tools directory but I am not sure if that is usable for this part so:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  tools/testing/selftests/lib.mk | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index b1c62914366b..cc4c443d5b14 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -10,12 +10,14 @@ endif
>  CLANG_TARGET_FLAGS_arm          := arm-linux-gnueabi
>  CLANG_TARGET_FLAGS_arm64        := aarch64-linux-gnu
>  CLANG_TARGET_FLAGS_hexagon      := hexagon-linux-musl
> +CLANG_TARGET_FLAGS_i386         := i386-linux-gnu
>  CLANG_TARGET_FLAGS_m68k         := m68k-linux-gnu
>  CLANG_TARGET_FLAGS_mips         := mipsel-linux-gnu
>  CLANG_TARGET_FLAGS_powerpc      := powerpc64le-linux-gnu
>  CLANG_TARGET_FLAGS_riscv        := riscv64-linux-gnu
>  CLANG_TARGET_FLAGS_s390         := s390x-linux-gnu
>  CLANG_TARGET_FLAGS_x86          := x86_64-linux-gnu
> +CLANG_TARGET_FLAGS_x86_64       := x86_64-linux-gnu
>  CLANG_TARGET_FLAGS              := $(CLANG_TARGET_FLAGS_$(ARCH))
>  
>  ifeq ($(CROSS_COMPILE),)
> -- 
> 2.30.2
> 
