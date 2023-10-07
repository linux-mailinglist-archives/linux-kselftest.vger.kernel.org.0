Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C72E7BC527
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Oct 2023 08:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343592AbjJGGug (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Oct 2023 02:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343577AbjJGGuf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Oct 2023 02:50:35 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18031B9;
        Fri,  6 Oct 2023 23:50:33 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3976oP6p021273;
        Sat, 7 Oct 2023 08:50:25 +0200
Date:   Sat, 7 Oct 2023 08:50:25 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC] tools/nolibc: add support for constructors and
 destructors
Message-ID: <20231007065025.GZ20998@1wt.eu>
References: <20231005-nolibc-constructors-v1-1-776d56bbe917@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231005-nolibc-constructors-v1-1-776d56bbe917@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Thomas,

On Thu, Oct 05, 2023 at 06:45:07PM +0200, Thomas Weiﬂschuh wrote:
> With the startup code moved to C, implementing support for
> constructors and deconstructors is fairly easy to implement.
> 
> Examples for code size impact:
> 
>    text	   data	    bss	    dec	    hex	filename
>   21837	    104	     88	  22029	   560d	nolibc-test.before
>   22135	    120	     88	  22343	   5747	nolibc-test.after
>   21970	    104	     88	  22162	   5692 nolibc-test.after-only-crt.h-changes
> 
> The sections are defined by [0].
> 
> [0] https://refspecs.linuxfoundation.org/elf/gabi4+/ch5.dynamic.html
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> Note:
> 
> This is only an RFC as I'm not 100% sure it belong into nolibc.
> But at least the code is visible as an example.

That's interesting, thanks for working on this! I thought about it in
the past but didn't see how to address it. I do think some users might
find it convenient with modular code that will require less ifdefs.
That may be particularly true with test programs that want to register
some test series for example. The code looks clean to me, and I suppose
you've tested it on multiple archs. However I'm having a comment below:
(...)

>  #endif /* _NOLIBC_CRT_H */
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index a3ee4496bf0a..f166b425613a 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -57,6 +57,9 @@ static int test_argc;
>  /* will be used by some test cases as readable file, please don't write it */
>  static const char *argv0;
>  
> +/* will be used by constructor tests */
> +static int constructor_test_value;
> +
>  /* definition of a series of tests */
>  struct test {
>  	const char *name;              /* test name */
> @@ -594,6 +597,18 @@ int expect_strne(const char *expr, int llen, const char *cmp)
>  #define CASE_TEST(name) \
>  	case __LINE__: llen += printf("%d %s", test, #name);
>  
> +__attribute__((constructor))
> +static void constructor1(void)
> +{
> +	constructor_test_value = 1;
> +}
> +
> +__attribute__((constructor))
> +static void constructor2(void)
> +{
> +	constructor_test_value *= 2;
> +}
> +

In the past I learned the hard way that you can never trust the execution
order of constructors, so if you're unlucky above you could very well end
up with 1 and that would be correct. I suggest that instead you do something
such as:

      constructor_test_value += 1;
...
      constructor_test_value += 2;

and check for value 3 in the test to make sure they were both executed
exactly once each.

Thanks!
Willy
