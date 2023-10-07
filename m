Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2FC7BC597
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Oct 2023 09:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343686AbjJGH26 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Oct 2023 03:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343725AbjJGH2y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Oct 2023 03:28:54 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8C2C5;
        Sat,  7 Oct 2023 00:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1696663725;
        bh=gG9Hvh9GA1HUqwNKeMMjfy0tQ09efcDbsUFUUdSbOnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cGzDPCCvvGI1pgHbX/tmMcfUEx+FZD6DiJXn3h+6FQLk46o6/DbUVzqCG+kkG2ZjN
         csLzodffH9mLlH6Fi1L8MnEDElnYrF5iWqXwgHTBqxcJxMByxBzXAmh7dLj5PBGiMN
         ebtZvujlH6bNag1k2S9DhwmI1vPcoMq9MaIWKqVw=
Date:   Sat, 7 Oct 2023 09:28:45 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC] tools/nolibc: add support for constructors and
 destructors
Message-ID: <485b8b48-673a-4b1d-8651-2c0038d478cf@t-8ch.de>
References: <20231005-nolibc-constructors-v1-1-776d56bbe917@weissschuh.net>
 <20231007065025.GZ20998@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231007065025.GZ20998@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Willy,

On 2023-10-07 08:50:25+0200, Willy Tarreau wrote:
> On Thu, Oct 05, 2023 at 06:45:07PM +0200, Thomas Weißschuh wrote:
> > With the startup code moved to C, implementing support for
> > constructors and deconstructors is fairly easy to implement.

> [..]

> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > index a3ee4496bf0a..f166b425613a 100644
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > @@ -57,6 +57,9 @@ static int test_argc;
> >  /* will be used by some test cases as readable file, please don't write it */
> >  static const char *argv0;
> >  
> > +/* will be used by constructor tests */
> > +static int constructor_test_value;
> > +
> >  /* definition of a series of tests */
> >  struct test {
> >  	const char *name;              /* test name */
> > @@ -594,6 +597,18 @@ int expect_strne(const char *expr, int llen, const char *cmp)
> >  #define CASE_TEST(name) \
> >  	case __LINE__: llen += printf("%d %s", test, #name);
> >  
> > +__attribute__((constructor))
> > +static void constructor1(void)
> > +{
> > +	constructor_test_value = 1;
> > +}
> > +
> > +__attribute__((constructor))
> > +static void constructor2(void)
> > +{
> > +	constructor_test_value *= 2;
> > +}
> > +
> 
> In the past I learned the hard way that you can never trust the execution
> order of constructors, so if you're unlucky above you could very well end
> up with 1 and that would be correct. I suggest that instead you do something
> such as:
> 
>       constructor_test_value += 1;
> ...
>       constructor_test_value += 2;
> 
> and check for value 3 in the test to make sure they were both executed
> exactly once each.

Was this indeterminism for constructors from the same translation unit?
Or across different translation units/shared objects?


I'm not entirely sure, but the GCC [0] docs could be read that within a
given TU the execution order for constructors is the same as the
definition order, even for C.

    The priorities for constructor and destructor functions are the same
    as those specified for namespace-scope C++ objects

And linked from there:

    In Standard C++, objects defined at namespace scope are guaranteed
    to be initialized in an order in strict accordance with that of
    their definitions *in a given translation unit*. No guarantee is made
    for initializations across translation units.


[0] https://gcc.gnu.org/onlinedocs/gcc-4.7.0/gcc/Function-Attributes.html
(using an old version of the docs to make sure this didn't change recently)
