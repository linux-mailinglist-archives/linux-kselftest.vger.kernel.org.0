Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBCD5839F1
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Jul 2022 10:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbiG1IAJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Jul 2022 04:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbiG1IAI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Jul 2022 04:00:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8574D1AA;
        Thu, 28 Jul 2022 01:00:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20BC061B76;
        Thu, 28 Jul 2022 08:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4E6C433B5;
        Thu, 28 Jul 2022 08:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658995205;
        bh=lFSo0dPChDzCA+CL3JRhP7qk+LmcyQGLwzN+RJydslE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aIESL2Ff9ikVd/LI/GV1EcwPfBzp/nBjn/08hdZAleADwx2KfC1cxm0x+NXTZBe8S
         6/yC/KDct4XyRX5cFZvp4bUorbjWep5bs95h8ZKifEQ9YIUpKTPrxT/Ig9fQ5H+22A
         beOGCTx7e1uN6fEwuTHSy6/JXVlIBBq6E8xB53l1r9VEORX5vamlfvrtsMR2pXueWp
         QT6vxRuhb2MWP0ShpUz9YALBtPQNSg2WFZFHoMEls0F5czf1dryIgZMfRiP8Lo//vO
         9GvA3LveK0vRNi5MX1toOba8RhEvPWWmoZqLw66aaFYrHcjX/1oSjRo6Kq50lkbL1x
         pIB4qDFN9cIpg==
Date:   Thu, 28 Jul 2022 11:00:02 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-sgx@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/sgx: Ignore OpenSSL 3.0 deprecated functions
 warning
Message-ID: <YuJCAhfQklzVQJGh@kernel.org>
References: <20220721194041.43970-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721194041.43970-1-kristen@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 21, 2022 at 12:40:40PM -0700, Kristen Carlson Accardi wrote:
> OpenSSL 3.0 deprecates some of the functions used in the SGX
> selftests, causing build errors on new distros. For now ignore
> the warnings until support for the functions is no longer
> available.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> ---
>  tools/testing/selftests/sgx/sigstruct.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
> index 50c5ab1aa6fa..bb191b70141a 100644
> --- a/tools/testing/selftests/sgx/sigstruct.c
> +++ b/tools/testing/selftests/sgx/sigstruct.c
> @@ -17,6 +17,9 @@
>  #include "defines.h"
>  #include "main.h"
>  
> +/* OpenSSL 3.0 has deprecated some functions. For now just ignore the warnings. */

Perhaps, even prefix with "FIXME:" prefix?

> +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> +
>  struct q1q2_ctx {
>  	BN_CTX *bn_ctx;
>  	BIGNUM *m;
> -- 
> 2.36.1
> 

BR, Jarkko
