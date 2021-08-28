Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B553FA401
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Aug 2021 08:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbhH1G1M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 28 Aug 2021 02:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbhH1G1M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 28 Aug 2021 02:27:12 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521D0C061796
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Aug 2021 23:26:22 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 17so8081445pgp.4
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Aug 2021 23:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ocepw5MIgKbkJ5+rqX6FwxezeVzORVwOUOKuDBN56vw=;
        b=Eti7UOt9z/9+9aczhhg1I99bmTfukQ6VNqBOWSvLTrewuKrRU2dKnbRh+FTibAUNV3
         4W2l+qdc8Z+Fk4S04yPbo0VIb+hBmRmLfEoRQSMbAJ9cHa3csTwpmCdtnvh0sh+ynn1L
         YEhn2weu73nCoVyJHYi2GpxfTlauGhnz6kqg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ocepw5MIgKbkJ5+rqX6FwxezeVzORVwOUOKuDBN56vw=;
        b=G4Ly9E3OjbY1JuhZJDjfxm1bOgY1iTDFx23P6+GgKufqyQIGSuXaQTpiAFjE+rgf4H
         yRDpBoed+6MUDzIkeIBGmJCoG6A3SgRcMyNeOr36OCQ4LWzQAKM5wCdn3AfhPhCUQzJQ
         wmIzskfemoOrKbkDQv+DADv53dORKQO2D4Xq97UXlMr2oDUveqhbrQCruOSc7arszY0X
         Ip3c2pCFP6kpgRujDnExtolE0K4xBRzO05ilZP4kH5xLn16+p6N94IjSTO7aH0LhgxzI
         yPxPkHF+myQh3O9iSulG8YrXXKtgCMYSVvn6JlT0Dw8dxpgpVKFmfQziIdTQboduKlUz
         j7aA==
X-Gm-Message-State: AOAM533FpUGdLKXfgyRvKpw4+CIuEkWWhbRq68UIHVWYtKTGInp+uEeT
        MPX9Vckdrdib63RnlFROxPhXVw==
X-Google-Smtp-Source: ABdhPJydtxI5ls6lxDQqjPVlGkBHr/rhjjX+WD3NtQjQRgT6be0vPrIAHbG9cqZCpfFJk7OYLrrnEA==
X-Received: by 2002:aa7:9096:0:b0:3e1:72fd:a614 with SMTP id i22-20020aa79096000000b003e172fda614mr12493910pfa.56.1630131981675;
        Fri, 27 Aug 2021 23:26:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 192sm8424667pfz.140.2021.08.27.23.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 23:26:20 -0700 (PDT)
Date:   Fri, 27 Aug 2021 23:26:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        dlatypov@google.com, shuah@kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests: tool: Add subtest header line and change
 indentation format in TAP results
Message-ID: <202108272314.403830F980@keescook>
References: <20210827225812.3247919-1-rmoar@google.com>
 <20210827225812.3247919-2-rmoar@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827225812.3247919-2-rmoar@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 27, 2021 at 10:58:11PM +0000, Rae Moar wrote:
> This patch is part of a series to alter the format of kselftest TAP
> results to improve compatibility with proposed KTAP specification
> (https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com/).
> 
> Two changes:
> - Change from "# " to "  " for indentation of nested tests
> - Add subtest header line at start of tests with subtests. Line format
> is "# Subtest: [name of test]".
> 
> An example of the new format:
> 
> Old format:
> 
>  TAP version 13
>  1..1
>  # TAP version 13
>  # 1..1
>  # # Starting 1 tests from 1 test cases.
>  # #  RUN           global.get_syscall_info ...
>  # #            OK  global.get_syscall_info
>  # ok 1 global.get_syscall_info
>  # # PASSED: 1 / 1 tests passed.
>  # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
>  ok 1 selftests: ptrace: get_syscall_info
> 
> New format:
> 
> TAP version 13
> 1..1
>   # Subtest: selftests: ptrace: get_syscall_info
>   TAP version 13
>   1..1
>   # Starting 1 tests from 1 test cases.
>   #  RUN           global.get_syscall_info ...
>   #            OK  global.get_syscall_info
>   ok 1 global.get_syscall_info
>   # PASSED: 1 / 1 tests passed.
>   # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> ok 1 selftests: ptrace: get_syscall_info
> 
> Signed-off-by: Rae Moar <rmoar@google.com>
> Change-Id: I139774745310ad2cd6dc5d7740254e48d8226241
> ---
>  tools/testing/selftests/kselftest/prefix.pl | 2 +-
>  tools/testing/selftests/kselftest/runner.sh | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest/prefix.pl b/tools/testing/selftests/kselftest/prefix.pl
> index 12a7f4ca2684..e59374b62603 100755
> --- a/tools/testing/selftests/kselftest/prefix.pl
> +++ b/tools/testing/selftests/kselftest/prefix.pl
> @@ -16,7 +16,7 @@ while (1) {
>  	my $bytes = sysread(STDIN, $char, 1);
>  	exit 0 if ($bytes == 0);
>  	if ($needed) {
> -		print "# ";
> +		print "  ";
>  		$needed = 0;
>  	}
>  	print $char;
> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
> index cc9c846585f0..9b04aeb26d3a 100644
> --- a/tools/testing/selftests/kselftest/runner.sh
> +++ b/tools/testing/selftests/kselftest/runner.sh
> @@ -23,7 +23,7 @@ fi
>  tap_prefix()
>  {
>  	if [ ! -x /usr/bin/perl ]; then
> -		sed -e 's/^/# /'
> +		sed -e 's/^/  /'
>  	else
>  		"$BASE_DIR"/kselftest/prefix.pl
>  	fi

Some of the existing TAP parsers expect leading spaces to be parsed as
YAML (from the _preceeding_ test result). "#" is understood to be
diagnostics about the currently running test.

Since there's no "---" nor "..." here, and the other parsers were pretty
busted to try to parse YAML without those, I can be convinced that
diagnostics can be marked with a leading " ", but if that's true, why
not just drop all "#" usage? Then we'd have:

TAP version 13
1..1
  # Subtest: selftests: ptrace: get_syscall_info
  TAP version 13
  1..1
    Starting 1 tests from 1 test cases.
     RUN           global.get_syscall_info ...
               OK  global.get_syscall_info
  ok 1 global.get_syscall_info
    PASSED: 1 / 1 tests passed.
    Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: ptrace: get_syscall_info

> @@ -75,7 +75,8 @@ run_one()
>  		echo "not ok $test_num $TEST_HDR_MSG"
>  	else
>  		cd `dirname $TEST` > /dev/null
> -		((((( tap_timeout ./$BASENAME_TEST 2>&1; echo $? >&3) |
> +		(echo "  # Subtest: selftests: $DIR: $BASENAME_TEST" &&
> +		(((( tap_timeout ./$BASENAME_TEST 2>&1; echo $? >&3) |

What's the benefit here? All I see is that now the test and the runner
are once again mixing the responsibility of generating the test output.
The subtest should be able to run strictly independently.

>  			tap_prefix >&4) 3>&1) |
>  			(read xs; exit $xs)) 4>>"$logfile" &&
>  		echo "ok $test_num $TEST_HDR_MSG") ||
> @@ -83,7 +84,6 @@ run_one()
>  		if [ $rc -eq $skip_rc ]; then	\
>  			echo "ok $test_num $TEST_HDR_MSG # SKIP"
>  		elif [ $rc -eq $timeout_rc ]; then \
> -			echo "#"

NAK: this is ensuring a newline before the "not ok" line on a timeout,
where the test output may have been interrupted before printing a
newline. (i.e. unflushed progress report style output)

>  			echo "not ok $test_num $TEST_HDR_MSG # TIMEOUT $kselftest_timeout seconds"
>  		else
>  			echo "not ok $test_num $TEST_HDR_MSG # exit=$rc"

-Kees

-- 
Kees Cook
