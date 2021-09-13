Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A913408A0D
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Sep 2021 13:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239168AbhIML0F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Sep 2021 07:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238684AbhIML0F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Sep 2021 07:26:05 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B884C061574;
        Mon, 13 Sep 2021 04:24:49 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id bk29so10016708qkb.8;
        Mon, 13 Sep 2021 04:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=5w2GYBAb4YPolyMIT1gaOrGT0ipIggCYYFAmbOuThOM=;
        b=hPNT7kICwXNN8T6DuCsPSHwUh/LrHyLu4ytgdfFeDoCTAstowc9hzGFphNBp7To4Ic
         lv0z8syPZkyIddA4rqskr+zCablc9GfZKccObC+bDbBBfqTpbYrpj8RhHpC/Y5wBYBQk
         C2ul9x4E9sV+DSwK/jInLJtrcmzBptVDVPPVuX0SbN5sMv84LrkKmZeDw9xtPiW0ST5Y
         vB4Nb6he64vAVPdP83VT6ubE7KEGJcrL93enEeUgBm7oXUOTvd8jCAmNN4Vv/YYemLL1
         7qxg8eusbAZej1xicOvsD+F5kdvPZWWI/TKkLn+BB2EQ+Clxu1sW3CnypAy99IBpnGgU
         x2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=5w2GYBAb4YPolyMIT1gaOrGT0ipIggCYYFAmbOuThOM=;
        b=nchXf9+P9om2ql8zaytE8dstmDmYfxCTF9In4hcuYxEzbCu0TdHRoC1aLOyqYDhCHd
         V9ioo3WeHrn6i+RRy1sHov3Cq67r2dOk0zUa5rcl7+PMCimJtLGtFB+mZyj4INlNLclH
         T6Q5EUBUXxlXdt4DMD4qVnCW4aDolqj2/tNfWeD1FQ2MMMe8aCCwvPGgTI9khFJgiees
         IdNYvzOxbAAbAfC7cmJodoipix8PeUZVZVNNoSIcikQdSPlyAVei0BNVFShJnmUCjMw1
         ytiW2vPoxH0ihrm6M5W4fTIG2Y8Yd1ehuRL/VHLbfRbx/UGtGXSPwq9nTARk66rR3pKS
         GzUg==
X-Gm-Message-State: AOAM533nhEnU6v0Xz55ds6lzJoNiOMXh0VHlk2t5cthaJLlk1hBykQ2R
        tcY3wJXX0eZGoC2YVAd6s4vBGA1FQiEXtQ==
X-Google-Smtp-Source: ABdhPJxQgdiBf9c0blSZ1mG6ZAACpeCgIP+8y1f300MBLg4TuXYzzcRCgEFb7O3DZHSHSXeG5xkOlg==
X-Received: by 2002:ae9:ea19:: with SMTP id f25mr9405378qkg.341.1631532288601;
        Mon, 13 Sep 2021 04:24:48 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id s16sm3906674qtq.31.2021.09.13.04.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 04:24:48 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     shuah@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH v2] selftests/kselftest/runner/run_one(): Allow running non-executable files
Date:   Mon, 13 Sep 2021 11:24:42 +0000
Message-Id: <20210913112442.1659-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210810164534.25902-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Hello Shuah,


Could you I ask your comment for this patch?


Thanks,
SJ

On Tue, 10 Aug 2021 16:45:34 +0000 SeongJae Park <sj38.park@gmail.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> When running a test program, 'run_one()' checks if the program has the
> execution permission and fails if it doesn't.  However, it's easy to
> mistakenly missing the permission, as some common tools like 'diff'
> don't support the permission change well[1].  Compared to that, making
> mistakes in the test program's path would only rare, as those are
> explicitly listed in 'TEST_PROGS'.  Therefore, it might make more sense
> to resolve the situation on our own and run the program.
> 
> For the reason, this commit makes the test program runner function to
> still print the warning message but try parsing the interpreter of the
> program and explicitly run it with the interpreter, in the case.
> 
> [1] https://lore.kernel.org/mm-commits/YRJisBs9AunccCD4@kroah.com/
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
> Changes from v1
> (https://lore.kernel.org/linux-kselftest/20210810140459.23990-1-sj38.park@gmail.com/)
> - Parse and use the interpreter instead of changing the file
> 
>  tools/testing/selftests/kselftest/runner.sh | 28 +++++++++++++--------
>  1 file changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
> index cc9c846585f0..a9ba782d8ca0 100644
> --- a/tools/testing/selftests/kselftest/runner.sh
> +++ b/tools/testing/selftests/kselftest/runner.sh
> @@ -33,9 +33,9 @@ tap_timeout()
>  {
>  	# Make sure tests will time out if utility is available.
>  	if [ -x /usr/bin/timeout ] ; then
> -		/usr/bin/timeout --foreground "$kselftest_timeout" "$1"
> +		/usr/bin/timeout --foreground "$kselftest_timeout" $1
>  	else
> -		"$1"
> +		$1
>  	fi
>  }
>  
> @@ -65,17 +65,25 @@ run_one()
>  
>  	TEST_HDR_MSG="selftests: $DIR: $BASENAME_TEST"
>  	echo "# $TEST_HDR_MSG"
> -	if [ ! -x "$TEST" ]; then
> -		echo -n "# Warning: file $TEST is "
> -		if [ ! -e "$TEST" ]; then
> -			echo "missing!"
> -		else
> -			echo "not executable, correct this."
> -		fi
> +	if [ ! -e "$TEST" ]; then
> +		echo "# Warning: file $TEST is missing!"
>  		echo "not ok $test_num $TEST_HDR_MSG"
>  	else
> +		cmd="./$BASENAME_TEST"
> +		if [ ! -x "$TEST" ]; then
> +			echo "# Warning: file $TEST is not executable"
> +
> +			if [ $(head -n 1 "$TEST" | cut -c -2) = "#!" ]
> +			then
> +				interpreter=$(head -n 1 "$TEST" | cut -c 3-)
> +				cmd="$interpreter ./$BASENAME_TEST"
> +			else
> +				echo "not ok $test_num $TEST_HDR_MSG"
> +				return
> +			fi
> +		fi
>  		cd `dirname $TEST` > /dev/null
> -		((((( tap_timeout ./$BASENAME_TEST 2>&1; echo $? >&3) |
> +		((((( tap_timeout "$cmd" 2>&1; echo $? >&3) |
>  			tap_prefix >&4) 3>&1) |
>  			(read xs; exit $xs)) 4>>"$logfile" &&
>  		echo "ok $test_num $TEST_HDR_MSG") ||
> -- 
> 2.17.1
> 
