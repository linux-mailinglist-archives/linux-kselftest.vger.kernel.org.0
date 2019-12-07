Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAD3115E09
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Dec 2019 19:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfLGSrq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Dec 2019 13:47:46 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:42969 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfLGSrq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Dec 2019 13:47:46 -0500
Received: by mail-pj1-f65.google.com with SMTP id o11so4106907pjp.9
        for <linux-kselftest@vger.kernel.org>; Sat, 07 Dec 2019 10:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g+o/W2tR+ah1gbz9xvaeab3ecUOZuYjDYmgHNmd5AdE=;
        b=QzCesKk5H/QnhxdZttmRJxvB/kk5/osU5f08u62cZbz6Sxjf3Af66LOC5a+oHqhwey
         3uIDSo1Fut3CXd3pqgvuUReoF2SLaLNOwW6RG5Tx62sPg57BPpJCWbspYo5ZgDDHa0O3
         DiqZlUMOdguYLOKoQ2o8Bscf+q/Rs7+ueQ7Po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g+o/W2tR+ah1gbz9xvaeab3ecUOZuYjDYmgHNmd5AdE=;
        b=jaEcZnyd+07DNU1oVsaUc46WA+ipopRMNUGN3emUJFQjuou0j9YCO5ICnRvXsBISNU
         P8PlIvJBQkwDo4gwBWxobFH8FiASlBjQWPdpGQkkNsWAEr/Vl/gekT9h36kKGFf/f7qv
         1RP+dXrh7Udk6g6JsZy7AFwKTlGnrdLiUE7ahguFEA8fbv7A/6GQydJ2EwAFeJn6kMN4
         CX7hz5INL4O17WHAaF9pn5OqG1e0us5mHvscZ7vQT/mKvTbbWWkF3a/7VbFHfelYbhAN
         zx5Kx7PSaXIS9vEdlWfcOxTg/bPVwH4NMhUlAc7qfT/khgbv+fFVS9LBWu+zTI7kfNcS
         D24A==
X-Gm-Message-State: APjAAAWK5IyFahP6rqFUbJK4h+7KoKWPr8Nl9YbjYMPOVv/OaFv4ETUb
        UpMP/OHkfqiAjEu5iEQWIryJGA==
X-Google-Smtp-Source: APXvYqwa3Dpc/KviQQujS/dXWsgQA88nMekSICflPCXO5hSENoJJVcES/7cGhMq4ddCjmdTCfeonoA==
X-Received: by 2002:a17:902:ba84:: with SMTP id k4mr20720961pls.141.1575744465750;
        Sat, 07 Dec 2019 10:47:45 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u190sm5112943pfb.60.2019.12.07.10.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2019 10:47:44 -0800 (PST)
Date:   Sat, 7 Dec 2019 10:47:44 -0800
From:   Kees Cook <keescook@chromium.org>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj38.park@gmail.com,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH 1/2] kselftest/runner: Print new line in print of timeout
 log
Message-ID: <201912071047.E373E19A97@keescook>
References: <20191202114221.827-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202114221.827-1-sjpark@amazon.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 02, 2019 at 12:42:20PM +0100, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> If a timeout failure occurs, kselftest kills the test process and prints
> the timeout log.  If the test process has killed while printing a log
> that ends with new line, the timeout log can be printed in middle of the
> test process output so that it can be seems like a comment, as below:
> 
>     # test_process_log	not ok 3 selftests: timers: nsleep-lat # TIMEOUT
> 
> This commit avoids such problem by printing one more line before the
> TIMEOUT failure log.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Acked-by: Kees Cook <keescook@chromium.org>

Cool, yeah, this looks fine to me. Nice idea!

-Kees

> ---
>  tools/testing/selftests/kselftest/runner.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
> index 84de7bc74f2c..a8d20cbb711c 100644
> --- a/tools/testing/selftests/kselftest/runner.sh
> +++ b/tools/testing/selftests/kselftest/runner.sh
> @@ -79,6 +79,7 @@ run_one()
>  		if [ $rc -eq $skip_rc ]; then	\
>  			echo "not ok $test_num $TEST_HDR_MSG # SKIP"
>  		elif [ $rc -eq $timeout_rc ]; then \
> +			echo "#"
>  			echo "not ok $test_num $TEST_HDR_MSG # TIMEOUT"
>  		else
>  			echo "not ok $test_num $TEST_HDR_MSG # exit=$rc"
> -- 
> 2.17.1
> 

-- 
Kees Cook
