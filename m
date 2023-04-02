Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A396D35FB
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Apr 2023 09:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjDBHvS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Apr 2023 03:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDBHvQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Apr 2023 03:51:16 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 792BCCC19;
        Sun,  2 Apr 2023 00:51:15 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3327pAp0018344;
        Sun, 2 Apr 2023 09:51:10 +0200
Date:   Sun, 2 Apr 2023 09:51:10 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/3] tools/nolibc: add testcases for vfprintf
Message-ID: <ZCkz7lf9+EuBkSud@1wt.eu>
References: <20230328-nolibc-printf-test-v1-0-d7290ec893dd@weissschuh.net>
 <20230328-nolibc-printf-test-v1-3-d7290ec893dd@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230328-nolibc-printf-test-v1-3-d7290ec893dd@weissschuh.net>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 28, 2023 at 09:01:31PM +0000, Thomas Weißschuh wrote:
> vfprintf() is complex and so far did not have proper tests.

This is an excellent idea, I totally agree, and I wouldn't be surprised
if there were still bugs there.

> +		switch (test + __LINE__ + 1) {
> +		CASE_TEST(empty);        EXPECT_VFPRINTF(0, "", ""); break;
> +		CASE_TEST(simple);       EXPECT_VFPRINTF(3, "foo", "foo"); break;
> +		CASE_TEST(string);       EXPECT_VFPRINTF(3, "foo", "%s", "foo"); break;
> +		CASE_TEST(number);       EXPECT_VFPRINTF(4, "1234", "%d", 1234); break;
> +		CASE_TEST(negnumber);    EXPECT_VFPRINTF(5, "-1234", "%d", -1234); break;
> +		CASE_TEST(unsigned);     EXPECT_VFPRINTF(5, "12345", "%u", 12345); break;
> +		CASE_TEST(char);         EXPECT_VFPRINTF(1, "c", "%c", 'c'); break;
> +		CASE_TEST(hex);          EXPECT_VFPRINTF(1, "f", "%x", 0xf); break;
> +		CASE_TEST(pointer);      EXPECT_VFPRINTF(3, "0x0", "%p", NULL); break;

I don't see a reason why not to move them to the stdlib category, since
these tests are there to validate that the libc-provided functions do
work. Maybe you intended to further extend it ? In this case maybe we
could move that to an "stdio" category then but I'd rather avoid having
one category per function or it will quickly become annoying to select
groups of tests. So let's just prefix these test names with "printf_"
and either merge them with "stdlib" or name the category "stdio", as
you prefer.

Thank you!
Willy
