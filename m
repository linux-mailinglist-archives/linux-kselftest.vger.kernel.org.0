Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39FBF2975E4
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Oct 2020 19:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753632AbgJWRjG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Oct 2020 13:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753629AbgJWRjF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Oct 2020 13:39:05 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4102EC0613D4
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Oct 2020 10:39:05 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id i26so1461570pgl.5
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Oct 2020 10:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BE28vr3ldFBEafoUhUhSftLJWHULe1EekcnhFGapYMM=;
        b=gXOgNeCk0DWPr02xsOcY0kJj7Eqyp8wWIlaUKo6ogWwWvs+trPWedAA18N2K0SZP+Y
         nG5wIUVGGTIs8+tjQoNkP/55c4Fjhb6wq+4mKwGGqzWCAsc/12vo9Qy9i9juM7FcyvJO
         mUCc99keb39LEFtPSBaRDKDpBWEQmepy5hwbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BE28vr3ldFBEafoUhUhSftLJWHULe1EekcnhFGapYMM=;
        b=n2p5hh5tj267cITOLOgBvPIJ/QsR+tMA5s+N8mC1+FDjTWLeGz26lmJB2Boo3b1/ru
         jKfa/UeANYiAwguoJORsK2lwEma7see9ZUwJ3gd+62Icpqz7FMUGbefgg+23OQXhy/kD
         EK6JREOjLMNIXcRQzofJHq3QS+t1besYkB9kLy2sUQdTOLVbeOPQx1X16bzXhDI0+/ul
         gYNBfPuxVxjuF7Ekf0F7LAONvGSGOE2bhOVTjCiOo/G5xlEw2Sa12lQdFXgZafExfT9+
         IOgcvPkdFzXRzbfbKn1/TJhkRV0aX+A9mqlXDlRsoLKn0qLsJgbXMlzi3Gzt2U2zSrrq
         iIrQ==
X-Gm-Message-State: AOAM533wZ6zrOfA5scH0j35kpw3ElVtes/BYhTjDBc3ARGXO/740H4HU
        PAAT+VjJZGctnoumAuiK/24Ttw==
X-Google-Smtp-Source: ABdhPJyvlxkx63O1tswxx1cMaE85Mr1rCO7WIXY51zywOmWeFJrJ6F9Yz4y5x645U04DGqInb0MGlg==
X-Received: by 2002:a17:90b:3649:: with SMTP id nh9mr3727436pjb.123.1603474744707;
        Fri, 23 Oct 2020 10:39:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g22sm2757066pfh.147.2020.10.23.10.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 10:39:03 -0700 (PDT)
Date:   Fri, 23 Oct 2020 10:39:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Shuah Khan <shuah@kernel.org>, Will Drewry <wad@chromium.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 55/56] selftests: kselftest_harness.h: partially fix
 kernel-doc markups
Message-ID: <202010231036.B41FB56D@keescook>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
 <8d816b5a5f31600176fd9ad5e58c0a74bf79f8dd.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d816b5a5f31600176fd9ad5e58c0a74bf79f8dd.1603469755.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 23, 2020 at 06:33:42PM +0200, Mauro Carvalho Chehab wrote:
> The kernel-doc markups on this file are weird: they don't
> follow what's specified at:
> 
> 	Documentation/doc-guide/kernel-doc.rst
> 
> In particular, markups should use this format:
>         identifier - description
> 
> and not this:
> 	identifier(args)
> 
> The way the definitions are inside this file cause the
> parser to completely miss the identifier name of each
> function.
> 
> This prevents improving the script to do some needed validation
> tests.
> 
> Address this part. Yet, furter changes are needed in order
> for it to fully follow the specs.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  tools/testing/selftests/kselftest_harness.h | 66 ++++++++++-----------
>  1 file changed, 33 insertions(+), 33 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index f19804df244c..665d04f3b802 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -79,7 +79,7 @@
>  #endif
>  
>  /**
> - * TH_LOG(fmt, ...)
> + * TH_LOG()
>   *
>   * @fmt: format string
>   * @...: optional arguments

Hmmm. Yeah, this does need fixing, but I don't want to lose the
"examples". Some have stuff like this before the description:

 * .. code-block:: c
 *
 *     TH_LOG(format, ...)

which retains it, but many don't. Can you add the code-block:: c
sections where they're missing so this doesn't lose the syntax hints
when just looking at the header file alone.

-Kees

> @@ -113,7 +113,7 @@
>  			__FILE__, __LINE__, _metadata->name, ##__VA_ARGS__)
>  
>  /**
> - * SKIP(statement, fmt, ...)
> + * SKIP()
>   *
>   * @statement: statement to run after reporting SKIP
>   * @fmt: format string
> @@ -136,7 +136,7 @@
>  } while (0)
>  
>  /**
> - * TEST(test_name) - Defines the test function and creates the registration
> + * TEST() - Defines the test function and creates the registration
>   * stub
>   *
>   * @test_name: test name
> @@ -155,7 +155,7 @@
>  #define TEST(test_name) __TEST_IMPL(test_name, -1)
>  
>  /**
> - * TEST_SIGNAL(test_name, signal)
> + * TEST_SIGNAL()
>   *
>   * @test_name: test name
>   * @signal: signal number
> @@ -195,7 +195,7 @@
>  		struct __test_metadata __attribute__((unused)) *_metadata)
>  
>  /**
> - * FIXTURE_DATA(datatype_name) - Wraps the struct name so we have one less
> + * FIXTURE_DATA() - Wraps the struct name so we have one less
>   * argument to pass around
>   *
>   * @datatype_name: datatype name
> @@ -212,7 +212,7 @@
>  #define FIXTURE_DATA(datatype_name) struct _test_data_##datatype_name
>  
>  /**
> - * FIXTURE(fixture_name) - Called once per fixture to setup the data and
> + * FIXTURE() - Called once per fixture to setup the data and
>   * register
>   *
>   * @fixture_name: fixture name
> @@ -239,7 +239,7 @@
>  	FIXTURE_DATA(fixture_name)
>  
>  /**
> - * FIXTURE_SETUP(fixture_name) - Prepares the setup function for the fixture.
> + * FIXTURE_SETUP() - Prepares the setup function for the fixture.
>   * *_metadata* is included so that EXPECT_* and ASSERT_* work correctly.
>   *
>   * @fixture_name: fixture name
> @@ -265,7 +265,7 @@
>  			__attribute__((unused)) *variant)
>  
>  /**
> - * FIXTURE_TEARDOWN(fixture_name)
> + * FIXTURE_TEARDOWN()
>   * *_metadata* is included so that EXPECT_* and ASSERT_* work correctly.
>   *
>   * @fixture_name: fixture name
> @@ -286,7 +286,7 @@
>  		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self)
>  
>  /**
> - * FIXTURE_VARIANT(fixture_name) - Optionally called once per fixture
> + * FIXTURE_VARIANT() - Optionally called once per fixture
>   * to declare fixture variant
>   *
>   * @fixture_name: fixture name
> @@ -305,7 +305,7 @@
>  #define FIXTURE_VARIANT(fixture_name) struct _fixture_variant_##fixture_name
>  
>  /**
> - * FIXTURE_VARIANT_ADD(fixture_name, variant_name) - Called once per fixture
> + * FIXTURE_VARIANT_ADD() - Called once per fixture
>   * variant to setup and register the data
>   *
>   * @fixture_name: fixture name
> @@ -339,7 +339,7 @@
>  		_##fixture_name##_##variant_name##_variant =
>  
>  /**
> - * TEST_F(fixture_name, test_name) - Emits test registration and helpers for
> + * TEST_F() - Emits test registration and helpers for
>   * fixture-based test cases
>   *
>   * @fixture_name: fixture name
> @@ -432,7 +432,7 @@
>   */
>  
>  /**
> - * ASSERT_EQ(expected, seen)
> + * ASSERT_EQ()
>   *
>   * @expected: expected value
>   * @seen: measured value
> @@ -443,7 +443,7 @@
>  	__EXPECT(expected, #expected, seen, #seen, ==, 1)
>  
>  /**
> - * ASSERT_NE(expected, seen)
> + * ASSERT_NE()
>   *
>   * @expected: expected value
>   * @seen: measured value
> @@ -454,7 +454,7 @@
>  	__EXPECT(expected, #expected, seen, #seen, !=, 1)
>  
>  /**
> - * ASSERT_LT(expected, seen)
> + * ASSERT_LT()
>   *
>   * @expected: expected value
>   * @seen: measured value
> @@ -465,7 +465,7 @@
>  	__EXPECT(expected, #expected, seen, #seen, <, 1)
>  
>  /**
> - * ASSERT_LE(expected, seen)
> + * ASSERT_LE()
>   *
>   * @expected: expected value
>   * @seen: measured value
> @@ -476,7 +476,7 @@
>  	__EXPECT(expected, #expected, seen, #seen, <=, 1)
>  
>  /**
> - * ASSERT_GT(expected, seen)
> + * ASSERT_GT()
>   *
>   * @expected: expected value
>   * @seen: measured value
> @@ -487,7 +487,7 @@
>  	__EXPECT(expected, #expected, seen, #seen, >, 1)
>  
>  /**
> - * ASSERT_GE(expected, seen)
> + * ASSERT_GE()
>   *
>   * @expected: expected value
>   * @seen: measured value
> @@ -498,7 +498,7 @@
>  	__EXPECT(expected, #expected, seen, #seen, >=, 1)
>  
>  /**
> - * ASSERT_NULL(seen)
> + * ASSERT_NULL()
>   *
>   * @seen: measured value
>   *
> @@ -508,7 +508,7 @@
>  	__EXPECT(NULL, "NULL", seen, #seen, ==, 1)
>  
>  /**
> - * ASSERT_TRUE(seen)
> + * ASSERT_TRUE()
>   *
>   * @seen: measured value
>   *
> @@ -518,7 +518,7 @@
>  	__EXPECT(0, "0", seen, #seen, !=, 1)
>  
>  /**
> - * ASSERT_FALSE(seen)
> + * ASSERT_FALSE()
>   *
>   * @seen: measured value
>   *
> @@ -528,7 +528,7 @@
>  	__EXPECT(0, "0", seen, #seen, ==, 1)
>  
>  /**
> - * ASSERT_STREQ(expected, seen)
> + * ASSERT_STREQ()
>   *
>   * @expected: expected value
>   * @seen: measured value
> @@ -539,7 +539,7 @@
>  	__EXPECT_STR(expected, seen, ==, 1)
>  
>  /**
> - * ASSERT_STRNE(expected, seen)
> + * ASSERT_STRNE()
>   *
>   * @expected: expected value
>   * @seen: measured value
> @@ -550,7 +550,7 @@
>  	__EXPECT_STR(expected, seen, !=, 1)
>  
>  /**
> - * EXPECT_EQ(expected, seen)
> + * EXPECT_EQ()
>   *
>   * @expected: expected value
>   * @seen: measured value
> @@ -561,7 +561,7 @@
>  	__EXPECT(expected, #expected, seen, #seen, ==, 0)
>  
>  /**
> - * EXPECT_NE(expected, seen)
> + * EXPECT_NE()
>   *
>   * @expected: expected value
>   * @seen: measured value
> @@ -572,7 +572,7 @@
>  	__EXPECT(expected, #expected, seen, #seen, !=, 0)
>  
>  /**
> - * EXPECT_LT(expected, seen)
> + * EXPECT_LT()
>   *
>   * @expected: expected value
>   * @seen: measured value
> @@ -583,7 +583,7 @@
>  	__EXPECT(expected, #expected, seen, #seen, <, 0)
>  
>  /**
> - * EXPECT_LE(expected, seen)
> + * EXPECT_LE()
>   *
>   * @expected: expected value
>   * @seen: measured value
> @@ -594,7 +594,7 @@
>  	__EXPECT(expected, #expected, seen, #seen, <=, 0)
>  
>  /**
> - * EXPECT_GT(expected, seen)
> + * EXPECT_GT()
>   *
>   * @expected: expected value
>   * @seen: measured value
> @@ -605,7 +605,7 @@
>  	__EXPECT(expected, #expected, seen, #seen, >, 0)
>  
>  /**
> - * EXPECT_GE(expected, seen)
> + * EXPECT_GE()
>   *
>   * @expected: expected value
>   * @seen: measured value
> @@ -616,7 +616,7 @@
>  	__EXPECT(expected, #expected, seen, #seen, >=, 0)
>  
>  /**
> - * EXPECT_NULL(seen)
> + * EXPECT_NULL()
>   *
>   * @seen: measured value
>   *
> @@ -626,7 +626,7 @@
>  	__EXPECT(NULL, "NULL", seen, #seen, ==, 0)
>  
>  /**
> - * EXPECT_TRUE(seen)
> + * EXPECT_TRUE()
>   *
>   * @seen: measured value
>   *
> @@ -636,7 +636,7 @@
>  	__EXPECT(0, "0", seen, #seen, !=, 0)
>  
>  /**
> - * EXPECT_FALSE(seen)
> + * EXPECT_FALSE()
>   *
>   * @seen: measured value
>   *
> @@ -646,7 +646,7 @@
>  	__EXPECT(0, "0", seen, #seen, ==, 0)
>  
>  /**
> - * EXPECT_STREQ(expected, seen)
> + * EXPECT_STREQ()
>   *
>   * @expected: expected value
>   * @seen: measured value
> @@ -657,7 +657,7 @@
>  	__EXPECT_STR(expected, seen, ==, 0)
>  
>  /**
> - * EXPECT_STRNE(expected, seen)
> + * EXPECT_STRNE()
>   *
>   * @expected: expected value
>   * @seen: measured value
> -- 
> 2.26.2
> 

-- 
Kees Cook
