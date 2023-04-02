Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4004F6D37CC
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Apr 2023 14:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjDBMSe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Apr 2023 08:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDBMSe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Apr 2023 08:18:34 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1646A64;
        Sun,  2 Apr 2023 05:18:32 -0700 (PDT)
Date:   Sun, 2 Apr 2023 12:18:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680437911;
        bh=MvT5gngdbz2ehhD+1061DgmXNspxNsHwrK3lrIo+sWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hnSm151xGtqrLKRXxv1IurzSu0zYPdXzAUUqw5C6EIFDnHAza54Nl2ZEt9B9Kkmqk
         A4GCIn0Xm0wvYjlni3Fe/bcaDxX8qXxZHiPR0jgCz0w3dNUxAwk1AwMAhzyASB6aeF
         nQzgw0iQUaI4O9YPl0B+rya61CZZpOub79rqqYnY=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/3] tools/nolibc: add testcases for vfprintf
Message-ID: <70fcb1ec-2946-4c49-a239-be2a26a921c7@t-8ch.de>
References: <20230328-nolibc-printf-test-v1-0-d7290ec893dd@weissschuh.net>
 <20230328-nolibc-printf-test-v1-3-d7290ec893dd@weissschuh.net>
 <ZCkz7lf9+EuBkSud@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCkz7lf9+EuBkSud@1wt.eu>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-04-02 09:51:10+0200, Willy Tarreau wrote:
> On Tue, Mar 28, 2023 at 09:01:31PM +0000, Thomas Weißschuh wrote:
> > vfprintf() is complex and so far did not have proper tests.
> 
> This is an excellent idea, I totally agree, and I wouldn't be surprised
> if there were still bugs there.

The first issue I experienced was that

printf("%*s", 1, "foo") would segfault because it ignored the '*' and
just tried to interpret the number "1" as string.
When looking for the supported features of the printf implementation
there were no examples.

And before I try to add code to handle this case better I really want
some testcases.

> > +		switch (test + __LINE__ + 1) {
> > +		CASE_TEST(empty);        EXPECT_VFPRINTF(0, "", ""); break;
> > +		CASE_TEST(simple);       EXPECT_VFPRINTF(3, "foo", "foo"); break;
> > +		CASE_TEST(string);       EXPECT_VFPRINTF(3, "foo", "%s", "foo"); break;
> > +		CASE_TEST(number);       EXPECT_VFPRINTF(4, "1234", "%d", 1234); break;
> > +		CASE_TEST(negnumber);    EXPECT_VFPRINTF(5, "-1234", "%d", -1234); break;
> > +		CASE_TEST(unsigned);     EXPECT_VFPRINTF(5, "12345", "%u", 12345); break;
> > +		CASE_TEST(char);         EXPECT_VFPRINTF(1, "c", "%c", 'c'); break;
> > +		CASE_TEST(hex);          EXPECT_VFPRINTF(1, "f", "%x", 0xf); break;
> > +		CASE_TEST(pointer);      EXPECT_VFPRINTF(3, "0x0", "%p", NULL); break;
> 
> I don't see a reason why not to move them to the stdlib category, since
> these tests are there to validate that the libc-provided functions do
> work. Maybe you intended to further extend it ? In this case maybe we
> could move that to an "stdio" category then but I'd rather avoid having
> one category per function or it will quickly become annoying to select
> groups of tests. So let's just prefix these test names with "printf_"
> and either merge them with "stdlib" or name the category "stdio", as
> you prefer.

The idea was that printf is its own very special beast that alone is
more complex than many other things combined.
When working on it, it would be useful to only run the relevant tests
without having to manually count testcase numbers.

I don't expect other single functions getting their own category.

If you still prefer to put it somewhere else I can do that, too.
