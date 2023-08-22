Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C17783C57
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Aug 2023 10:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbjHVI6T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Aug 2023 04:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjHVI6R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Aug 2023 04:58:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD1CE50;
        Tue, 22 Aug 2023 01:57:53 -0700 (PDT)
Received: from [192.168.10.12] (unknown [39.45.215.81])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BED3E660723E;
        Tue, 22 Aug 2023 09:57:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692694666;
        bh=wntvJCRNZSJZfOWzq0DzF9xFq9O+r9VsQVLUqGarZ7A=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=VOpJVz4mrfYcTuC1jZo/XaMqhQO4hGE8mqTklaD9JK4WVjEfY53B/5eBZ+dBfQkOw
         UX9YXt2puhRwPWV4kTxVR3sLtBZupYjrSfRn7wXLOzPqfXsYPmY+PRPnt3irbbJOo9
         yPKbd/PvRYuoZIsxSdeHHWFdiGjKljMd73wafSk+pgDIory7RoQ3goCZphf1VedpUo
         2aSIdD3Ei+GMxw0OPYL+dBDE2q0STm4mnJLDGcHhjsT2P+NckLCODgBCscLnoFUnLo
         awPcfeTxXX/hyD9l4DYPHIcibYp9iTFXZXhCj7DWtNmv+Bn+Y1U/ylE/OLO257r2Hd
         mjpL8apaPfOdg==
Message-ID: <95fc0e92-79ed-4748-a565-a82469d087f6@collabora.com>
Date:   Tue, 22 Aug 2023 13:57:40 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] selftests: capabilities: remove duplicate unneeded
 defines
To:     Shuah Khan <shuah@kernel.org>
References: <20230805073809.1753462-1-usama.anjum@collabora.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230805073809.1753462-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

Christian Brauner had picked [PATCH 4/6]. Others are still not picked.
Please have a look.

Thanks,
Usama

On 8/5/23 12:37 PM, Muhammad Usama Anjum wrote:
> These duplicate defines should automatically be picked up from kernel
> headers. Use KHDR_INCLUDES to add kernel header files.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/capabilities/Makefile       | 2 +-
>  tools/testing/selftests/capabilities/test_execve.c  | 8 --------
>  tools/testing/selftests/capabilities/validate_cap.c | 8 --------
>  3 files changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/capabilities/Makefile b/tools/testing/selftests/capabilities/Makefile
> index 6e9d98d457d5b..411ac098308f1 100644
> --- a/tools/testing/selftests/capabilities/Makefile
> +++ b/tools/testing/selftests/capabilities/Makefile
> @@ -2,7 +2,7 @@
>  TEST_GEN_FILES := validate_cap
>  TEST_GEN_PROGS := test_execve
>  
> -CFLAGS += -O2 -g -std=gnu99 -Wall
> +CFLAGS += -O2 -g -std=gnu99 -Wall $(KHDR_INCLUDES)
>  LDLIBS += -lcap-ng -lrt -ldl
>  
>  include ../lib.mk
> diff --git a/tools/testing/selftests/capabilities/test_execve.c b/tools/testing/selftests/capabilities/test_execve.c
> index df0ef02b40367..e3a352b020a79 100644
> --- a/tools/testing/selftests/capabilities/test_execve.c
> +++ b/tools/testing/selftests/capabilities/test_execve.c
> @@ -20,14 +20,6 @@
>  
>  #include "../kselftest.h"
>  
> -#ifndef PR_CAP_AMBIENT
> -#define PR_CAP_AMBIENT			47
> -# define PR_CAP_AMBIENT_IS_SET		1
> -# define PR_CAP_AMBIENT_RAISE		2
> -# define PR_CAP_AMBIENT_LOWER		3
> -# define PR_CAP_AMBIENT_CLEAR_ALL	4
> -#endif
> -
>  static int nerrs;
>  static pid_t mpid;	/*  main() pid is used to avoid duplicate test counts */
>  
> diff --git a/tools/testing/selftests/capabilities/validate_cap.c b/tools/testing/selftests/capabilities/validate_cap.c
> index cdfc94268fe6e..60b4e7b716a75 100644
> --- a/tools/testing/selftests/capabilities/validate_cap.c
> +++ b/tools/testing/selftests/capabilities/validate_cap.c
> @@ -9,14 +9,6 @@
>  
>  #include "../kselftest.h"
>  
> -#ifndef PR_CAP_AMBIENT
> -#define PR_CAP_AMBIENT			47
> -# define PR_CAP_AMBIENT_IS_SET		1
> -# define PR_CAP_AMBIENT_RAISE		2
> -# define PR_CAP_AMBIENT_LOWER		3
> -# define PR_CAP_AMBIENT_CLEAR_ALL	4
> -#endif
> -
>  #if __GLIBC__ > 2 || (__GLIBC__ == 2 && __GLIBC_MINOR__ >= 19)
>  # define HAVE_GETAUXVAL
>  #endif

-- 
BR,
Muhammad Usama Anjum
