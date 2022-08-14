Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F58C592628
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Aug 2022 21:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiHNTWS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 14 Aug 2022 15:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiHNTWR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 14 Aug 2022 15:22:17 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162061EAC0;
        Sun, 14 Aug 2022 12:22:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 71866CE0BA6;
        Sun, 14 Aug 2022 19:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD19C433D7;
        Sun, 14 Aug 2022 19:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660504933;
        bh=aFRVBEFtCZwIn3E+x7e0Ags3ucFo/IaEPpiU/yvm4zs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qazkY43hMd7M+SOGBE6w1ZPms0vSCawXviPSGcvaRoTZiBLKWhvOxbeMWsbyqUEKW
         6sttSqsx7PYMYFBtPMC7g6Q7WrZmacoLyLqcWy6jRXgDtc3cHqpTdyqusmeumraVTV
         lyu1MrQRTOKsqVrKmxS6Ivf0WBYsiZhDMEQyVHy2cWgEBmOCFtQrFlPN5fU8WidvrF
         9eKq+m8XYi/f9LN9Fazn7t1/EFHxB4DnyMlWibbkcE5fycOQgGNVbvEOQUPE0AmwzR
         czqb1zRBQuyzUDv3ugjdMd1pmJxH5/WPQWdtUGRn9YBGYJpFcCRA/6x+ENyegsF7vl
         gLhmF7WTVwIKQ==
Date:   Sun, 14 Aug 2022 22:22:10 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-sgx@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] selftests/sgx: Ignore OpenSSL 3.0 deprecated
 functions warning
Message-ID: <YvlLYtbmAM2Hrtds@kernel.org>
References: <20220812180714.566257-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812180714.566257-1-kristen@linux.intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 12, 2022 at 11:07:13AM -0700, Kristen Carlson Accardi wrote:
> OpenSSL 3.0 deprecates some of the functions used in the SGX
> selftests, causing build errors on new distros. For now ignore
> the warnings until support for the functions is no longer
> available and mark FIXME so that it can be clear this should
> be removed at some point.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> ---
>  tools/testing/selftests/sgx/sigstruct.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
> index 50c5ab1aa6fa..a07896a46364 100644
> --- a/tools/testing/selftests/sgx/sigstruct.c
> +++ b/tools/testing/selftests/sgx/sigstruct.c
> @@ -17,6 +17,12 @@
>  #include "defines.h"
>  #include "main.h"
>  
> +/*
> + * FIXME: OpenSSL 3.0 has deprecated some functions. For now just ignore
> + * the warnings.
> + */
> +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> +
>  struct q1q2_ctx {
>  	BN_CTX *bn_ctx;
>  	BIGNUM *m;
> -- 
> 2.36.1
> 

Thank you.


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
