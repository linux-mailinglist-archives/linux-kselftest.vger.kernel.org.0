Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2D54B19E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Feb 2022 00:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240464AbiBJXzv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 18:55:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345911AbiBJXzu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 18:55:50 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633D25F87
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 15:55:50 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id t4-20020a17090a510400b001b8c4a6cd5dso7161403pjh.5
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 15:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dlMqHYWmeFE9YutBKgR2EWRsK4ahNPNhY+dEU62idVs=;
        b=U+LPgDEPgoz09gCSOxee5fvC3VuxGKKndS6TlMMy9IQ7jRkw/xAxF6fQZK8UTkyltx
         whl7YNhPbjG1RVFkAnQIoF917YJGVWExCqY1t5u0AMOKku8nMOHB9T13oQDjrvqzFJ1X
         eIAzDSm9n97m5x8oa/2fIfW9UEeHpZSiv0G5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dlMqHYWmeFE9YutBKgR2EWRsK4ahNPNhY+dEU62idVs=;
        b=YdRhOyLHGbN/u1hW3XSQw2yKmM3wxCHnOQz9Q/etCLJxkulNpdsL1Uzr+ieHCWwJuH
         pBF5Y47eZ3N7fWw0DXvekmeD0ysCJxZXrSe7RoFf+W9tTYYokz2lG8q1wktqAbwNhlLn
         Y//fr2nasJVbuXIQdXXxodpNksJl04S9M8fZqIqQVvwE8tgyDz2+N4pFKxrbh6uVHbBT
         t1sTqboOOARplrYw/Zu4AQeh3q3GY1vF5Dt9pL2beJ6beAFKD1NEGtyD7TO3YZSH6nnh
         fyd+uewBT6d+RIXtvhFIsNhaijFD5gmjrZ3UweYQXtxMnKmxEuclRCxLpq20uPgbiNfm
         Mr7w==
X-Gm-Message-State: AOAM530D/dYNFI5/rypVHX69Yj+5JfWUKmcO8FRFCOWzdDchP85IIpz8
        H1WdKmTm2DZICF0YNC8ERO2URg==
X-Google-Smtp-Source: ABdhPJwWbQAdWi1tu+pJMuOU18Jq/YySWVk/7i1eFjfDT/ZHvGMexKGSOXjumML3yxu4jQLNtqBEZQ==
X-Received: by 2002:a17:90b:4f41:: with SMTP id pj1mr5347261pjb.209.1644537349836;
        Thu, 10 Feb 2022 15:55:49 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j4sm25018194pfc.217.2022.02.10.15.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:55:49 -0800 (PST)
Date:   Thu, 10 Feb 2022 15:55:48 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
        kernelci@groups.io, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] selftests/exec: Rename file binfmt_script to
 binfmt_script.py
Message-ID: <202202101555.EE737A35@keescook>
References: <20220210222319.1864680-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210222319.1864680-1-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 11, 2022 at 03:23:19AM +0500, Muhammad Usama Anjum wrote:
> Rename file for readability purpose. Update its usage and references.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> This path was suggested while review of the following patch. Please
> apply it after applying that one first:
> 	selftests/exec: Add non-regular to TEST_GEN_PROGS
> Changes in V2:
> 	Remove changes from binfmt_script.py, they were wrong

Thanks! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  tools/testing/selftests/exec/Makefile                           | 2 +-
>  .../testing/selftests/exec/{binfmt_script => binfmt_script.py}  | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename tools/testing/selftests/exec/{binfmt_script => binfmt_script.py} (100%)
> 
> diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
> index a89ba6de79870..a0b8688b08369 100644
> --- a/tools/testing/selftests/exec/Makefile
> +++ b/tools/testing/selftests/exec/Makefile
> @@ -3,7 +3,7 @@ CFLAGS = -Wall
>  CFLAGS += -Wno-nonnull
>  CFLAGS += -D_GNU_SOURCE
>  
> -TEST_PROGS := binfmt_script
> +TEST_PROGS := binfmt_script.py
>  TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216 non-regular
>  TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir
>  # Makefile is a run-time dependency, since it's accessed by the execveat test
> diff --git a/tools/testing/selftests/exec/binfmt_script b/tools/testing/selftests/exec/binfmt_script.py
> similarity index 100%
> rename from tools/testing/selftests/exec/binfmt_script
> rename to tools/testing/selftests/exec/binfmt_script.py
> -- 
> 2.30.2
> 

-- 
Kees Cook
