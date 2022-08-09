Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C669158DC34
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Aug 2022 18:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238268AbiHIQgZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Aug 2022 12:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245168AbiHIQgT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Aug 2022 12:36:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0261D8;
        Tue,  9 Aug 2022 09:36:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DAA2B8111F;
        Tue,  9 Aug 2022 16:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EF4C433D7;
        Tue,  9 Aug 2022 16:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660062974;
        bh=KQIbq1M7KiQ601fejWiMxVueLyd23HzAj7uEElLFxgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PAs8/xzhrFvK6sqOrZ5ZPdRMnvP1npJqlA3BIMJ/KKViTn4+sMI39HwQNNWTKoiWT
         HHn37o1IM2dG3IABKuFEJTh8BhQOWyduIzisvHRr5fsmWBempzIBR8LOgpOvupdJra
         mpKVzj9U16VMhNSpzkkTlN9Y3MbNPtRX+/B2tv32g6EqqubtCxbWqmizKsfyO3czUB
         33hAk7NOEoB14XBzaEiTq9vnONrkB61Wpv0SkAJQWPr+pW9qcfMS9IKcYZTLQsID7P
         hs/hTaLCCt0e+nciY7VNCV5uacYAw7W5V7MvfW0cEHtBaiTwBgCMUhUBpL5mczezWi
         RKMDDywOXGrBQ==
Date:   Tue, 9 Aug 2022 09:36:12 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Mark Brown <broonie@kernel.org>,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] selftests: add missing ')' in lib.mk
Message-ID: <YvKM/J5xO8gKto+p@dev-arch.thelio-3990X>
References: <7de08f7f11551d6b8195c3e5d801db2fae3f49a9.1660048017.git.guillaume.tucker@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7de08f7f11551d6b8195c3e5d801db2fae3f49a9.1660048017.git.guillaume.tucker@collabora.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 09, 2022 at 03:20:46PM +0200, Guillaume Tucker wrote:
> Add missing closing ')' in lib.mk in a call to $error().  This only
> affects LLVM / Clang builds.
> 
> Fixes: 795285ef2425 ("selftests: Fix clang cross compilation")
> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  tools/testing/selftests/lib.mk | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 947fc72413e9..a87f60873e5b 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -20,7 +20,7 @@ CLANG_TARGET_FLAGS              := $(CLANG_TARGET_FLAGS_$(ARCH))
>  
>  ifeq ($(CROSS_COMPILE),)
>  ifeq ($(CLANG_TARGET_FLAGS),)
> -$(error Specify CROSS_COMPILE or add '--target=' option to lib.mk
> +$(error Specify CROSS_COMPILE or add '--target=' option to lib.mk)
>  else
>  CLANG_FLAGS     += --target=$(CLANG_TARGET_FLAGS)
>  endif # CLANG_TARGET_FLAGS
> -- 
> 2.30.2
> 
