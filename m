Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADEC6F1351
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Apr 2023 10:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345335AbjD1Id5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Apr 2023 04:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjD1Id4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Apr 2023 04:33:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39252137;
        Fri, 28 Apr 2023 01:33:54 -0700 (PDT)
Received: from [192.168.10.39] (unknown [39.37.187.173])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A80C366032C3;
        Fri, 28 Apr 2023 09:33:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682670833;
        bh=ir1Fq3uvoRAzkpEu3qzisZDRI+fbR3pp9k7e7t7Jnlg=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=eqQB6yF14qtI1nS1cgjNeuTEw87ASsYJrnf9+kAW9cRltgYK7YcgMsgW2nRBkfiSl
         UMDL9sHVzC7RjLR3rlt6ZwjlDqZlinuwEn5Sr4kRsSbBl7WgvytlmEhSVQXZOQZvdK
         bAiJOOTfQIzekGpqt1N3KGs9tEF5Pmg68iMhR8OpW550vIl1K58uMgs9Mp+SD1e8x6
         gbWzQ35n4MjHhYTwv/oQ0G4XEbeMunu7GHMNLNhiCey1zDw42gc3whDyb+SRyMfw91
         +SwXLZ+2GU8SbBQ5E+bw4MB0aDONYLMea2dAtSc2qUhMON0KeX1Wy29cK3hCkOyQVX
         5lL8TepI9y/ow==
Message-ID: <3f5c5c28-3814-3fea-dfbb-a3c7604e0edc@collabora.com>
Date:   Fri, 28 Apr 2023 13:33:45 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        gregkh@linuxfoundation.org, tiwai@suse.de, tianfei.zhang@intel.com,
        russell.h.weight@intel.com, keescook@chromium.org,
        tweek@google.com, a.manzanares@samsung.com, dave@stgolabs.net,
        vincenzopalazzodev@gmail.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] selftests: allow runners to override the timeout
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
References: <20230414193845.2494120-1-mcgrof@kernel.org>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230414193845.2494120-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/15/23 12:38 AM, Luis Chamberlain wrote:
> The default timeout for selftests tests is 45 seconds. Although
> we already have 13 settings for tests of about 96 sefltests which
> use a timeout greater than this, we want to try to avoid encouraging
> more tests to forcing a higher test timeout as selftests strives to
> run all tests quickly. Selftests also uses the timeout as a non-fatal
> error. Only tests runners which have control over a system would know
> if to treat a timeout as fatal or not.
> 
> To help with all this:
> 
>   o Enhance documentation to avoid future increases of insane timeouts
>   o Add the option to allow overriding the default timeout with test
>     runners with a command line option
> 
> Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Tested-by:Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  Documentation/dev-tools/kselftest.rst       | 22 +++++++++++++++++++++
>  tools/testing/selftests/kselftest/runner.sh | 11 ++++++++++-
>  tools/testing/selftests/run_kselftest.sh    |  5 +++++
>  3 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> index 12b575b76b20..dd214af7b7ff 100644
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -168,6 +168,28 @@ the `-t` option for specific single tests. Either can be used multiple times::
>  
>  For other features see the script usage output, seen with the `-h` option.
>  
> +Timeout for selftests
> +=====================
> +
> +Selftests are designed to be quick and so a default timeout is used of 45
> +seconds for each test. Tests can override the default timeout by adding
> +a settings file in their directory and set a timeout variable there to the
> +configured a desired upper timeout for the test. Only a few tests override
> +the timeout with a value higher than 45 seconds, selftests strives to keep
> +it that way. Timeouts in selftests are not considered fatal because the
> +system under which a test runs may change and this can also modify the
> +expected time it takes to run a test. If you have control over the systems
> +which will run the tests you can configure a test runner on those systems to
> +use a greater or lower timeout on the command line as with the `-o` or
> +the `--override-timeout` argument. For example to use 165 seconds instead
> +one would use:
> +
> +   $ ./run_kselftest.sh --override-timeout 165
> +
> +You can look at the TAP output to see if you ran into the timeout. Test
> +runners which know a test must run under a specific time can then optionally
> +treat these timeouts then as fatal.
> +
>  Packaging selftests
>  ===================
>  
> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
> index 294619ade49f..1c952d1401d4 100644
> --- a/tools/testing/selftests/kselftest/runner.sh
> +++ b/tools/testing/selftests/kselftest/runner.sh
> @@ -8,7 +8,8 @@ export logfile=/dev/stdout
>  export per_test_logging=
>  
>  # Defaults for "settings" file fields:
> -# "timeout" how many seconds to let each test run before failing.
> +# "timeout" how many seconds to let each test run before running
> +# over our soft timeout limit.
>  export kselftest_default_timeout=45
>  
>  # There isn't a shell-agnostic way to find the path of a sourced file,
> @@ -90,6 +91,14 @@ run_one()
>  		done < "$settings"
>  	fi
>  
> +	# Command line timeout overrides the settings file
> +	if [ -n "$kselftest_override_timeout" ]; then
> +		kselftest_timeout="$kselftest_override_timeout"
> +		echo "# overriding timeout to $kselftest_timeout" >> "$logfile"
> +	else
> +		echo "# timeout set to $kselftest_timeout" >> "$logfile"
> +	fi
> +
>  	TEST_HDR_MSG="selftests: $DIR: $BASENAME_TEST"
>  	echo "# $TEST_HDR_MSG"
>  	if [ ! -e "$TEST" ]; then
> diff --git a/tools/testing/selftests/run_kselftest.sh b/tools/testing/selftests/run_kselftest.sh
> index 97165a83df63..9a981b36bd7f 100755
> --- a/tools/testing/selftests/run_kselftest.sh
> +++ b/tools/testing/selftests/run_kselftest.sh
> @@ -26,6 +26,7 @@ Usage: $0 [OPTIONS]
>    -l | --list			List the available collection:test entries
>    -d | --dry-run		Don't actually run any tests
>    -h | --help			Show this usage info
> +  -o | --override-timeout	Number of seconds after which we timeout
>  EOF
>  	exit $1
>  }
> @@ -33,6 +34,7 @@ EOF
>  COLLECTIONS=""
>  TESTS=""
>  dryrun=""
> +kselftest_override_timeout=""
>  while true; do
>  	case "$1" in
>  		-s | --summary)
> @@ -51,6 +53,9 @@ while true; do
>  		-d | --dry-run)
>  			dryrun="echo"
>  			shift ;;
> +		-o | --override-timeout)
> +			kselftest_override_timeout="$2"
> +			shift 2 ;;
>  		-h | --help)
>  			usage 0 ;;
>  		"")

-- 
BR,
Muhammad Usama Anjum
