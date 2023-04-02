Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C7D6D37D8
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Apr 2023 14:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjDBMbS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Apr 2023 08:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjDBMbR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Apr 2023 08:31:17 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91F0CE1B6;
        Sun,  2 Apr 2023 05:31:14 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 332CV4lo019346;
        Sun, 2 Apr 2023 14:31:04 +0200
Date:   Sun, 2 Apr 2023 14:31:04 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/3] tools/nolibc: add testcases for vfprintf
Message-ID: <ZCl1iGL9WS1SOPd2@1wt.eu>
References: <20230328-nolibc-printf-test-v1-0-d7290ec893dd@weissschuh.net>
 <20230328-nolibc-printf-test-v1-3-d7290ec893dd@weissschuh.net>
 <ZCkz7lf9+EuBkSud@1wt.eu>
 <70fcb1ec-2946-4c49-a239-be2a26a921c7@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70fcb1ec-2946-4c49-a239-be2a26a921c7@t-8ch.de>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Apr 02, 2023 at 12:18:29PM +0000, Thomas Weißschuh wrote:
> On 2023-04-02 09:51:10+0200, Willy Tarreau wrote:
> > On Tue, Mar 28, 2023 at 09:01:31PM +0000, Thomas Weißschuh wrote:
> > > vfprintf() is complex and so far did not have proper tests.
> > 
> > This is an excellent idea, I totally agree, and I wouldn't be surprised
> > if there were still bugs there.
> 
> The first issue I experienced was that
> 
> printf("%*s", 1, "foo") would segfault because it ignored the '*' and
> just tried to interpret the number "1" as string.

Yes indeed, much like many older printf() implementations as well BTW,
that's a common issue when you try to write portable code ;-)

> When looking for the supported features of the printf implementation
> there were no examples.

Indeed!

> And before I try to add code to handle this case better I really want
> some testcases.
> 
> > > +		switch (test + __LINE__ + 1) {
> > > +		CASE_TEST(empty);        EXPECT_VFPRINTF(0, "", ""); break;
> > > +		CASE_TEST(simple);       EXPECT_VFPRINTF(3, "foo", "foo"); break;
> > > +		CASE_TEST(string);       EXPECT_VFPRINTF(3, "foo", "%s", "foo"); break;
> > > +		CASE_TEST(number);       EXPECT_VFPRINTF(4, "1234", "%d", 1234); break;
> > > +		CASE_TEST(negnumber);    EXPECT_VFPRINTF(5, "-1234", "%d", -1234); break;
> > > +		CASE_TEST(unsigned);     EXPECT_VFPRINTF(5, "12345", "%u", 12345); break;
> > > +		CASE_TEST(char);         EXPECT_VFPRINTF(1, "c", "%c", 'c'); break;
> > > +		CASE_TEST(hex);          EXPECT_VFPRINTF(1, "f", "%x", 0xf); break;
> > > +		CASE_TEST(pointer);      EXPECT_VFPRINTF(3, "0x0", "%p", NULL); break;
> > 
> > I don't see a reason why not to move them to the stdlib category, since
> > these tests are there to validate that the libc-provided functions do
> > work. Maybe you intended to further extend it ? In this case maybe we
> > could move that to an "stdio" category then but I'd rather avoid having
> > one category per function or it will quickly become annoying to select
> > groups of tests. So let's just prefix these test names with "printf_"
> > and either merge them with "stdlib" or name the category "stdio", as
> > you prefer.
> 
> The idea was that printf is its own very special beast that alone is
> more complex than many other things combined.
> When working on it, it would be useful to only run the relevant tests
> without having to manually count testcase numbers.
> 
> I don't expect other single functions getting their own category.
> 
> If you still prefer to put it somewhere else I can do that, too.

OK, I can understand, it makes sense to some extents. And I agree that
if we'd ever extend printf it would be needed to extend these tests.
Then let's leave it that way.

Thanks,
Willy
