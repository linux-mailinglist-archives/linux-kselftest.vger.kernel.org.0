Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F5E545614
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jun 2022 22:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbiFIU7Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Jun 2022 16:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241493AbiFIU7X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Jun 2022 16:59:23 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC22D2462E0
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Jun 2022 13:59:21 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id v143so10561658oie.13
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Jun 2022 13:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3+W8tGcC+pYKwOyimQW4Mjg02XZiCd2VZj3H/A3rViQ=;
        b=a7J7N14OQC3/tTJdx5QUoxlM7zaz6PXBfbxwFxpp/Pd0kYPlfytRgSCQwZrI89k7R8
         D6ITvNOxFrbFFWR4rLv+pd7v7bpTPCmflSbLBd24bqkCu4yNtc+r9T0HZlPnVxeuPuLg
         smDjGR/1wkMuQi0fJ3q4sxs/nU/fyLCFXJaOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3+W8tGcC+pYKwOyimQW4Mjg02XZiCd2VZj3H/A3rViQ=;
        b=TiEHv3UYGvTw1l4opz4UTkab9c8LWMKNmZHos5RcRZWAMuPbQV3rM+wM5aOeFtV/Q5
         8CEFYyM6sK8aVVWes7C6OcADqVRpOsFC04yvKTQ8i5+GCaiz7LYUqYTWDCfBPkfznamN
         8trK5kayPFs1TnM+iiGhn/gmWmNAkD24GYeB76AM0oyaPD9GLrT6F3kpQvPIpz9fiRyC
         cOnScUI2blsF8+q14fnJDQzWvBvKo6eK3z3th7v6vfbpc7kxVtRbljkkqJ4WuYr/o9g4
         uKg7DnvgS5w9zPwFlgNbIEieJF1cmEpddlVIrO72V1if5hXFD/FkV/2PK/In/B9J4YRP
         D7SA==
X-Gm-Message-State: AOAM533zZdmEpYLDzNjNgW0M3Nf/7a9/0rLBTd5jBBGxpX3TIEkqaVtj
        cmVix7UOVhFp9yVjH2DUwl5ZEQ==
X-Google-Smtp-Source: ABdhPJzsInYp5fIRaOPYDYdzrND8dTKWknIaoIM2HoaBBtyL7OHDUH9zKr6qIU0OhOwyOZNn6CGvVQ==
X-Received: by 2002:a05:6808:1888:b0:32e:f64e:be1f with SMTP id bi8-20020a056808188800b0032ef64ebe1fmr1468956oib.212.1654808361102;
        Thu, 09 Jun 2022 13:59:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id g23-20020a4a9257000000b0035eb4e5a6bdsm4725645ooh.19.2022.06.09.13.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 13:59:20 -0700 (PDT)
Subject: Re: [PATCH] testing: kselftest_harness: add filtering and enumerating
 tests
To:     Jakub Kicinski <kuba@kernel.org>, shuah@kernel.org
Cc:     keescook@chromium.org, luto@amacapital.net, wad@chromium.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220609202458.1715942-1-kuba@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a360b5e0-4b56-6d90-4060-6760934f7dd8@linuxfoundation.org>
Date:   Thu, 9 Jun 2022 14:59:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220609202458.1715942-1-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/9/22 2:24 PM, Jakub Kicinski wrote:
> As the number of test cases and length of execution grows it's
> useful to select only a subset of tests. In TLS for instance we
> have a matrix of variants for different crypto protocols and
> during development mostly care about testing a handful.
> This is quicker and makes reading output easier.
> 
> This patch adds argument parsing to kselftest_harness.
> 
> It supports a couple of ways to filter things, I could not come
> up with one way which will cover all cases.
> 
> The first and simplest switch is -r which takes the name of
> a test to run (can be specified multiple times).
> 
> Then there is a handful of group filtering options. f/v/t for
> filtering by fixture/variant/test. They have both positive
> (match -> run) and negative versions (match -> skip).
> If user specifies any positive option we assume the default
> is not to run the tests. If only negative options are set
> we assume the tests are supposed to be run by default.
> 
>    Usage: ./tools/testing/selftests/net/tls [-h|-l] [-t|-T|-v|-V|-f|-F|-r name]
> 	-h       print help
> 	-l       list all tests
> 
> 	-t name  include test
> 	-T name  exclude test
> 	-v name  include variant
> 	-V name  exclude variant
> 	-f name  include fixture
> 	-F name  exclude fixture
> 	-r name  run specified test
> 
>    Test filter options can be specified multiple times. The filtering stops
>    at the first match. For example to include all tests from variant 'bla'
>    but not test 'foo' specify '-T foo -v bla'.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: keescook@chromium.org
> CC: luto@amacapital.net
> CC: wad@chromium.org
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> ---
>   tools/testing/selftests/kselftest_harness.h | 146 +++++++++++++++++++-
>   1 file changed, 142 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 25f4d54067c0..bcbad9fa0039 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -54,6 +54,7 @@
>   #define _GNU_SOURCE
>   #endif
>   #include <asm/types.h>
> +#include <ctype.h>
>   #include <errno.h>
>   #include <stdbool.h>
>   #include <stdint.h>
> @@ -985,6 +986,132 @@ void __wait_for_test(struct __test_metadata *t)
>   	}
>   }
>   
> +static int test_harness_argv_check(int argc, char **argv)
> +{
> +	const char *opts = "FfVvtTr";
> +	unsigned int i;
> +
> +	for (i = 0; i < argc; i++) {
> +		if (!strcmp(argv[i], "-l")) {
> +			struct __fixture_variant_metadata *v;
> +			struct __fixture_metadata *f;
> +			struct __test_metadata *t;
> +
> +			for (f = __fixture_list; f; f = f->next) {
> +				v = f->variant;
> +				t = f->tests;
> +
> +				if (f == __fixture_list)
> +					fprintf(stderr, "%-20s %-25s %s\n",
> +						"# FIXTURE", "VARIANT", "TEST");
> +				else
> +					fprintf(stderr, "--------------------------------------------------------------------------------\n");
> +
> +				do {
> +					fprintf(stderr, "%-20s %-25s %s\n",
> +						t == f->tests ? f->name : "",
> +						v ? v->name : "",
> +						t ? t->name : "");
> +
> +					v = v ? v->next : NULL;
> +					t = t ? t->next : NULL;
> +				} while (v || t);
> +			}
> +			return 1;
> +		}

Change this to use getopt() to simplify argument parsing and make
it easier to maintain.

> +		if (!strcmp(argv[i], "-h")) {
> +help_and_fail:
> +			argv--;
> +			fprintf(stderr,
> +				"Usage: %s [-h|-l] [-t|-T|-v|-V|-f|-F|-r name]\n"
> +				"\t-h       print help\n"
> +				"\t-l       list all tests\n"
> +				"\n"
> +				"\t-t name  include test\n"
> +				"\t-T name  exclude test\n"
> +				"\t-v name  include variant\n"
> +				"\t-V name  exclude variant\n"
> +				"\t-f name  include fixture\n"
> +				"\t-F name  exclude fixture\n"
> +				"\t-r name  run specified test\n"
> +				"\n"
> +				"Test filter options can be specified "
> +				"multiple times. The filtering stops\n"
> +				"at the first match. For example to "
> +				"include all tests from variant 'bla'\n"
> +				"but not test 'foo' specify '-T foo -v bla'.\n"
> +				"", argv[0]);
> +			return -1;
> +		}
> +	}
> +
> +	if (argc % 2) {
> +		ksft_print_msg("FATAL: Odd number of arguments\n");
> +		goto help_and_fail;
> +	}
> +
> +	for (i = 0; i < argc; i += 2) {
> +		if (strnlen(argv[i], 3) != 2 || argv[i][0] != '-') {
> +			ksft_print_msg("FATAL: invalid option '%s'\n", argv[i]);
> +			goto help_and_fail;
> +		}
> +
> +		if (!strchr(opts, argv[i][1])) {
> +			ksft_print_msg("FATAL: unknown option '%s'\n", argv[i]);
> +			goto help_and_fail;
> +		}
> +	}
> +
> +	return 1;
> +}
> +
> +static bool test_enabled(int argc, char **argv,
> +			 struct __fixture_metadata *f,
> +			 struct __fixture_variant_metadata *v,
> +			 struct __test_metadata *t)
> +{
> +	unsigned int flen, vlen, tlen = 0;
> +	bool has_positive = false;
> +	unsigned int i;
> +
> +	for (i = 0; i < argc; i += 2) {
> +		has_positive |= islower(argv[i][1]);
> +
> +		switch (tolower(argv[i][1])) {
> +		case 't':
> +			if (!strcmp(t->name, argv[i + 1]))
> +				return islower(argv[i][1]);
> +			break;
> +		case 'f':
> +			if (!strcmp(f->name, argv[i + 1]))
> +				return islower(argv[i][1]);
> +			break;
> +		case 'v':
> +			if (!strcmp(v->name, argv[i + 1]))
> +				return islower(argv[i][1]);
> +			break;
> +		case 'r':
> +			if (!tlen) {
> +				flen = strlen(f->name);
> +				vlen = strlen(v->name);
> +				tlen = strlen(t->name);
> +			}
> +			if (strlen(argv[i + 1]) == flen + 1 + vlen + !!vlen + tlen &&
> +			    !strncmp(f->name, &argv[i + 1][0], flen) &&
> +			    !strncmp(v->name, &argv[i + 1][flen + 1], vlen) &&
> +			    !strncmp(t->name, &argv[i + 1][flen + 1 + vlen + !!vlen], tlen))
> +				return true;
> +			break;
> +		}

Same here. Use getopt()

> +	}
> +
> +	/*
> +	 * If there are no positive tests then we assume user just wants
> +	 * exclusions and everything else is a pass.
> +	 */
> +	return !has_positive;
> +}
> +
>   void __run_test(struct __fixture_metadata *f,
>   		struct __fixture_variant_metadata *variant,
>   		struct __test_metadata *t)
> @@ -1032,8 +1159,7 @@ void __run_test(struct __fixture_metadata *f,
>   			f->name, variant->name[0] ? "." : "", variant->name, t->name);
>   }
>   
> -static int test_harness_run(int __attribute__((unused)) argc,
> -			    char __attribute__((unused)) **argv)
> +static int test_harness_run(int argc, char **argv)
>   {
>   	struct __fixture_variant_metadata no_variant = { .name = "", };
>   	struct __fixture_variant_metadata *v;
> @@ -1045,11 +1171,21 @@ static int test_harness_run(int __attribute__((unused)) argc,
>   	unsigned int count = 0;
>   	unsigned int pass_count = 0;
>   
> +	argc--; argv++; /* Skip the name of the binary */
> +	ret = test_harness_argv_check(argc, argv);
> +	if (ret < 0)
> +		return KSFT_FAIL;
> +
>   	for (f = __fixture_list; f; f = f->next) {
>   		for (v = f->variant ?: &no_variant; v; v = v->next) {
> -			case_count++;
> +			unsigned int old_tests = test_count;
> +
>   			for (t = f->tests; t; t = t->next)
> -				test_count++;
> +				if (test_enabled(argc, argv, f, v, t))
> +					test_count++;
> +
> +			if (old_tests != test_count)
> +				case_count++;
>   		}
>   	}
>   
> @@ -1063,6 +1199,8 @@ static int test_harness_run(int __attribute__((unused)) argc,
>   	for (f = __fixture_list; f; f = f->next) {
>   		for (v = f->variant ?: &no_variant; v; v = v->next) {
>   			for (t = f->tests; t; t = t->next) {
> +				if (!test_enabled(argc, argv, f, v, t))
> +					continue;
>   				count++;
>   				t->results = results;
>   				__run_test(f, v, t);
> 

thanks,
-- Shuah
