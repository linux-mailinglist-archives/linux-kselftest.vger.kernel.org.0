Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE72B552C9F
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jun 2022 10:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345851AbiFUIH1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jun 2022 04:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345440AbiFUIH0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jun 2022 04:07:26 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E9824BD5
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jun 2022 01:07:24 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ay16so6388391ejb.6
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jun 2022 01:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wowsignal-io.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RJBnJgLtX0JwpwRuCzYXTMM3g+mi6KZvAfgwyVPPYzs=;
        b=NUZH7GF2lNzVd3sE/+N6FkE8FnZcjlKqfbfmyvHxtu7nOVoQ/ITMGxYo6EP0Erf2yC
         S2QKLqRkkGbvBAYNftyz43sPe9Mg9D1cLUY8HHWEN6py5C2Movt+sSR6tKKE1yBaOW67
         AlIY3myt8zUdCU2/SrIvo3gP5R9RRqPqW3LT4Gqr9KMOn60d/BdIAET04azM+E3mWmEu
         neHluiGGuYNKxfOEkKU0lKP8Igvj0S8klPn9cmQZUzncRisqcUzUMXSIIR0ceWcQzeIz
         xZsi0xpBOrSMP5dWubN7ErqyxRrHomwbpmMy16lv2euLe3hD1piSWL7v9xMuJRJgmHtL
         0eDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RJBnJgLtX0JwpwRuCzYXTMM3g+mi6KZvAfgwyVPPYzs=;
        b=YUzEOuStlzKQx/qfCgDt6oNjkXw7dFZy1rb6RXDc3SbKFV9cfBebyi0Lac9XNOG613
         CcmpwQ8FBeXGHH9wIGxREyWnymjx07fgL2cbcxfG7xAlzxY9W8MCEvI21oGB5L/+YMdz
         pf7vR0kxmvgWM632PUxlx9At4s2+WGNEPqBbrNOw6rvvaNCrm5iq1OuWcxoIdo268okq
         jews9A4+n4DfmB+BBWj72ybDK1fjBwIEtitiPntz+pXqRripsqCQx9bYdK0Uawv4MXaF
         GE4uJTCW3mJ9pZj8xaPN8EzUQKQ9b1Qvnb4xMe6/nMWylp1/JGVXY6FW6jXYJ6zNUdAe
         Knzg==
X-Gm-Message-State: AJIora8p8MAS1bypInrkqHVHTwc3+zUFrTuHrhVLVdca3CoZ6DzkXBNa
        /NHNwTDrNWhWeuiC67XsjaiQ41kS+LcfCu2UKWtHHMtq
X-Google-Smtp-Source: AGRyM1tPQv7Rq5zeRImjmstJyNLf6NW9QBBCknMosNFsGEoQif3cosqC4d+FdYuVw+9SzFtQo/zPEA==
X-Received: by 2002:a17:906:c041:b0:718:c984:d9ee with SMTP id bm1-20020a170906c04100b00718c984d9eemr26003658ejb.722.1655798843238;
        Tue, 21 Jun 2022 01:07:23 -0700 (PDT)
Received: from devvm3537.lla0.facebook.com (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id ht16-20020a170907609000b00711c7cca428sm7167694ejc.155.2022.06.21.01.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 01:07:22 -0700 (PDT)
Date:   Tue, 21 Jun 2022 01:07:20 -0700
From:   Adam Sindelar <adam@wowsignal.io>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, David Vernet <void@manifault.com>
Subject: Re: [PATCH] selftests/vm: Only run the 128TB boundary test if
 5-level paging is enabled
Message-ID: <YrF8OEK7E4T20IW8@devvm3537.lla0.facebook.com>
References: <20220620143536.2767866-1-adam@wowsignal.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620143536.2767866-1-adam@wowsignal.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 20, 2022 at 07:35:36AM -0700, Adam Sindelar wrote:
> The test va_128TBswitch.c expects to be able to pass mmap an address hint
> and length that cross the address 1<<47. This is not possible without
> 5-level page tables, so the test fails.
> 
> The test is already only run on 64-bit powerpc and x86 archs, but this
> patch adds an additional check that skips the test if PG_TABLE_LEVELS < 5.
> There is precedent for checking /proc/config.gz in selftests, e.g. in
> selftests/firmware.
> 
> Signed-off-by: Adam Sindelar <adam@wowsignal.io>
> ---
>  tools/testing/selftests/vm/Makefile          |  1 +
>  tools/testing/selftests/vm/run_vmtests.sh    | 13 +++++++---
>  tools/testing/selftests/vm/va_128TBswitch.sh | 26 ++++++++++++++++++++
>  3 files changed, 36 insertions(+), 4 deletions(-)
>  create mode 100755 tools/testing/selftests/vm/va_128TBswitch.sh
> 
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index 68cacffc93ec..bc64ca1e0de3 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -80,6 +80,7 @@ endif
>  TEST_PROGS := run_vmtests.sh
>  
>  TEST_FILES := test_vmalloc.sh
> +TEST_FILEs += va_128TBswitch.sh
>  
>  KSFT_KHDR_INSTALL := 1
>  include ../lib.mk
> diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
> index e953f3cd9664..10cccbedaaa1 100755
> --- a/tools/testing/selftests/vm/run_vmtests.sh
> +++ b/tools/testing/selftests/vm/run_vmtests.sh
> @@ -290,12 +290,17 @@ fi
>  echo "-----------------------------"
>  echo "running virtual address 128TB switch test"
>  echo "-----------------------------"
> -./va_128TBswitch
> -if [ $? -ne 0 ]; then
> +./va_128TBswitch.sh
> +ret_val=$?
> +
> +if [ $ret_val -eq 0 ]; then
> +    echo "[PASS]"
> +elif [ $ret_val -eq $ksft_skip ]; then
> +	 echo "[SKIP]"
> +	 exitcode=$ksft_skip
> +else
>      echo "[FAIL]"
>      exitcode=1
> -else
> -    echo "[PASS]"
>  fi
>  fi # VADDR64
>  
> diff --git a/tools/testing/selftests/vm/va_128TBswitch.sh b/tools/testing/selftests/vm/va_128TBswitch.sh
> new file mode 100755
> index 000000000000..f7b9db0bfd33
> --- /dev/null
> +++ b/tools/testing/selftests/vm/va_128TBswitch.sh
> @@ -0,0 +1,26 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2022 Adam Sindelar (Meta) <adam@wowsignal.io>
> +#
> +# This is a test for mmap behavior with 5-level paging. This script wraps the
> +# real test to check that the kernel is configured to support at least 5
> +# pagetable levels.
> +
> +# 1 means the test failed
> +exitcode=1
> +
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
> +check_test_requirements()
> +{
> +    pg_table_levels=$(gzip -dcfq /proc/config.gz | grep PGTABLE_LEVELS | cut -d'=' -f 2)
> +    if [ $pg_table_levels -lt 5 ]; then
> +    echo "$0: PG_TABLE_LEVELS=${pg_table_levels}, must be >= 5 to run this test"
> +        exit $ksft_skip
> +    fi
> +}
> +
> +check_test_requirements
> +./va_128TBswitch
> -- 
> 2.30.2
> 

Actually, I think I sent this to the wrong list. My bad, please disregard -
I'll send it to mm, where I think it belongs.
