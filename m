Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD437A2244
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Sep 2023 17:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235725AbjIOPXY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 11:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236067AbjIOPXQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 11:23:16 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC5810C7
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Sep 2023 08:23:09 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68fc1bbc94eso1938620b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Sep 2023 08:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694791389; x=1695396189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JzUny5ZDY3B8dwGvMbx7t3ZOXwBY6DGZ8A+gn9ETcXA=;
        b=0BdMv/t2kSwIcKkYEe7jYMeCfjq1Wys4SU/VqXRf8qbeN5IUQMoPXdh4U/Fq9S1eeb
         GfZVVox/pywXV/ZWA0zOGbRkpWqRZvsMjiRGk8xbuBToQe+nlkw4Zhni2V6VfEK03+rw
         2qyXgbGZfiGXGzs6ADpgRasRS1rqM88EzCLxdV/fbAZUNZxqnf/b2PdQdq1MBzpjWfra
         5aJLuSa7NjhIeLKbD6ODkJeUs73PtT86mwSYaIJ3d597u6BabQDpnqBMh5N1096YRydc
         oOo0xg677ZfTTyRzmzASBfkYkSAIhii21ZOAOtDZvpLWZovm4fV0f4Jpt4cWncUOXokW
         x+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694791389; x=1695396189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzUny5ZDY3B8dwGvMbx7t3ZOXwBY6DGZ8A+gn9ETcXA=;
        b=wUctT17HSUj3WM98NN1ggd5akq9goRVmvl7S1KseALyvQYpekbs+h900n7uvxnqDLp
         z9JgFi35/F4QRku2ua7khMlUhqWUMFMHiOL/Q/JuKqGItIUg2CXCdaTN7xqGba81EnfG
         RL/vkFaF2Ajhua5s8xvnBfg19pBPNiqrZNpDVEcNxr1l6MBd15JzGeQNvVEhxP1IsQSO
         U3x4wPFV8E9R7Rx3jcCeDf8xg/AFBmXlU721ct/+eS37ZGHo3flwqednHtNe8r+truGS
         SB0dVXGPFKoXnb5zmIbQFDjPnUwwHt25e/aIhQbBR5lV2950W7cBkMm5EVvwh9aJMA9J
         W2Aw==
X-Gm-Message-State: AOJu0YxNNqo8NtqOgOKMs2+DP1Cn9enWWspplquKnQYxXv0GKPJTlN5a
        a8RO4FonpaE47vl0D+oidxKBHw==
X-Google-Smtp-Source: AGHT+IElDW4bTTqtNEHxEJSI2zqsGM7eb0Y6Wp/U3CPQiwi0iSahU1mcqFPPoZA/wBkxBNyUQ3xnlg==
X-Received: by 2002:a05:6a00:3186:b0:690:1857:3349 with SMTP id bj6-20020a056a00318600b0069018573349mr1453397pfb.25.1694791389091;
        Fri, 15 Sep 2023 08:23:09 -0700 (PDT)
Received: from ghost ([50.168.177.76])
        by smtp.gmail.com with ESMTPSA id c15-20020aa78c0f000000b0068fb5e44827sm3087719pfd.67.2023.09.15.08.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 08:23:08 -0700 (PDT)
Date:   Fri, 15 Sep 2023 11:23:05 -0400
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes] riscv: kselftests: Fix mm build by removing
 testcases subdirectory
Message-ID: <ZQR22QUisvS2CPQS@ghost>
References: <20230915100113.13131-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915100113.13131-1-alexghiti@rivosinc.com>
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 15, 2023 at 12:01:13PM +0200, Alexandre Ghiti wrote:
> kselftests fails to build because the mm/testcases subdirectory is not
> created and then the compiler fails to output the binary there.
> 
> So fix this by simply removing this subdirectory which is not very
> useful.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  tools/testing/selftests/riscv/mm/Makefile                   | 6 +++---
>  .../selftests/riscv/mm/{testcases => }/mmap_bottomup.c      | 2 +-
>  .../selftests/riscv/mm/{testcases => }/mmap_default.c       | 2 +-
>  .../testing/selftests/riscv/mm/{testcases => }/mmap_test.h  | 0
>  .../testing/selftests/riscv/mm/{testcases => }/run_mmap.sh  | 0
>  5 files changed, 5 insertions(+), 5 deletions(-)
>  rename tools/testing/selftests/riscv/mm/{testcases => }/mmap_bottomup.c (97%)
>  rename tools/testing/selftests/riscv/mm/{testcases => }/mmap_default.c (97%)
>  rename tools/testing/selftests/riscv/mm/{testcases => }/mmap_test.h (100%)
>  rename tools/testing/selftests/riscv/mm/{testcases => }/run_mmap.sh (100%)
> 
> diff --git a/tools/testing/selftests/riscv/mm/Makefile b/tools/testing/selftests/riscv/mm/Makefile
> index 11e0f0568923..c333263f2b27 100644
> --- a/tools/testing/selftests/riscv/mm/Makefile
> +++ b/tools/testing/selftests/riscv/mm/Makefile
> @@ -5,11 +5,11 @@
>  # Additional include paths needed by kselftest.h and local headers
>  CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
>  
> -TEST_GEN_FILES := testcases/mmap_default testcases/mmap_bottomup
> +TEST_GEN_FILES := mmap_default mmap_bottomup
>  
> -TEST_PROGS := testcases/run_mmap.sh
> +TEST_PROGS := run_mmap.sh
>  
>  include ../../lib.mk
>  
> -$(OUTPUT)/mm: testcases/mmap_default.c testcases/mmap_bottomup.c testcases/mmap_tests.h
> +$(OUTPUT)/mm: mmap_default.c mmap_bottomup.c mmap_tests.h
>  	$(CC) -o$@ $(CFLAGS) $(LDFLAGS) $^
> diff --git a/tools/testing/selftests/riscv/mm/testcases/mmap_bottomup.c b/tools/testing/selftests/riscv/mm/mmap_bottomup.c
> similarity index 97%
> rename from tools/testing/selftests/riscv/mm/testcases/mmap_bottomup.c
> rename to tools/testing/selftests/riscv/mm/mmap_bottomup.c
> index b29379f7e478..1757d19ca89b 100644
> --- a/tools/testing/selftests/riscv/mm/testcases/mmap_bottomup.c
> +++ b/tools/testing/selftests/riscv/mm/mmap_bottomup.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  #include <sys/mman.h>
> -#include <testcases/mmap_test.h>
> +#include <mmap_test.h>
>  
>  #include "../../kselftest_harness.h"
>  
> diff --git a/tools/testing/selftests/riscv/mm/testcases/mmap_default.c b/tools/testing/selftests/riscv/mm/mmap_default.c
> similarity index 97%
> rename from tools/testing/selftests/riscv/mm/testcases/mmap_default.c
> rename to tools/testing/selftests/riscv/mm/mmap_default.c
> index d1accb91b726..c63c60b9397e 100644
> --- a/tools/testing/selftests/riscv/mm/testcases/mmap_default.c
> +++ b/tools/testing/selftests/riscv/mm/mmap_default.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  #include <sys/mman.h>
> -#include <testcases/mmap_test.h>
> +#include <mmap_test.h>
>  
>  #include "../../kselftest_harness.h"
>  
> diff --git a/tools/testing/selftests/riscv/mm/testcases/mmap_test.h b/tools/testing/selftests/riscv/mm/mmap_test.h
> similarity index 100%
> rename from tools/testing/selftests/riscv/mm/testcases/mmap_test.h
> rename to tools/testing/selftests/riscv/mm/mmap_test.h
> diff --git a/tools/testing/selftests/riscv/mm/testcases/run_mmap.sh b/tools/testing/selftests/riscv/mm/run_mmap.sh
> similarity index 100%
> rename from tools/testing/selftests/riscv/mm/testcases/run_mmap.sh
> rename to tools/testing/selftests/riscv/mm/run_mmap.sh
> -- 
> 2.39.2
> 
Fixes the problem.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

- Charlie
