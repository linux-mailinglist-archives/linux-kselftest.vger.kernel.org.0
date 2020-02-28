Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEEA2172D72
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2020 01:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbgB1Agg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Feb 2020 19:36:36 -0500
Received: from mail-pj1-f54.google.com ([209.85.216.54]:37052 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730184AbgB1Agg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Feb 2020 19:36:36 -0500
Received: by mail-pj1-f54.google.com with SMTP id m13so518178pjb.2
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2020 16:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ecjs5n8zwN/9MsVfX6exqhP2XFiFuVu/JHGa+4oDJtc=;
        b=ES/p+9CII3zuPnEnjew7hIvK058/D5Rzlh3DNVA0W7HBD9ZoaCbcFvP9g95cwWv6Bd
         8QxT+AIkangkqK5XZwAJXNpUQ8mI84c0lrhZeadwaazQkTc6PKHt4XBUJ0LdDdcDvQDT
         2mcFoK7LyDN2R4uy/yj4vnU9TkBwapAEVDs4JFAoPuU+1LYWpNMr2xmfxhzz8zD/FgMc
         VtNjb5P2kOk4VDl2mP2/OXxGpEugB+8aSLWssJocVpT9p2xhmmTR/vgAe7i2B8BFobow
         LQ5GWz9trKkAHbyT0H8DJGOEH8OzaYYagd0N/aHFHKCy85+mBQEI7e1ynMtywIKwshSU
         JRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ecjs5n8zwN/9MsVfX6exqhP2XFiFuVu/JHGa+4oDJtc=;
        b=TCWXDyG0nYGTdauBa9+JHYGCCu3fIa1P+yFd/PP8GLciTXm4vYUswCd5Fi4Si0phGR
         eH/qAp5hUjXalP9tS3cj1mkFKwMBChYZzBqdMn9mtDhbpAIQi1j0LZ+fgdXzpHfkWDM9
         ZBTkr8gsVJJXXyD7f2C1TaLipr0RtTwTpnOE8qcRBN3OFNxVfEUMtvpgZt5PgWWIlZky
         Sz5qmSsphSDJ4LMNGoNOCCegdFKVo1rpbhwPeOVunYkfv7CO2CMWtWN5WedpkKa1PzZW
         KodpMGU+sPLsu4r/JWxt/WsiEOf0g5UoFsuu1QaW/i/xPDMl1AoOHKcLi3VsRGWEa0KS
         bzlw==
X-Gm-Message-State: APjAAAUs9tV5zR89cyxbIY50o75BskmgiatZAELZb2aNbtaPw7smOdiR
        NFmN8Dzap0/dHWHBZdPLgr0UjQajlFC0UgTi0DtPiQ==
X-Google-Smtp-Source: APXvYqzydJIXOtxTzekybI/ez2R/Ic2Dsh7bais/fao6j35qpckyCLsm/Za0Xaa6ECQoolTjS+XZA+G/7J7o8rH26E4=
X-Received: by 2002:a17:90a:6c26:: with SMTP id x35mr1629902pjj.84.1582850195008;
 Thu, 27 Feb 2020 16:36:35 -0800 (PST)
MIME-Version: 1.0
References: <20200225201130.211124-1-heidifahim@google.com>
 <20200225222221.GA144971@google.com> <CAMVcs3sUtx17C0SeE435Q5aehE_F2RkoQxJWzeJK5v47GgFjBg@mail.gmail.com>
In-Reply-To: <CAMVcs3sUtx17C0SeE435Q5aehE_F2RkoQxJWzeJK5v47GgFjBg@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 27 Feb 2020 16:36:22 -0800
Message-ID: <CAFd5g44ZMYigCbg4u7_Bfhgqt-hPJRbumoHNf3Buz50fkm_Y7g@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: kunit_parser: making parser more robust
To:     Heidi Fahim <heidifahim@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 27, 2020 at 4:09 PM Heidi Fahim <heidifahim@google.com> wrote:
>
> > >
> > > -TAP_ENTRIES = re.compile(r'^(TAP|\t?ok|\t?not ok|\t?[0-9]+\.\.[0-9]+|\t?#).*$')
> > > +TAP_ENTRIES = re.compile(r'(TAP|\t?ok|\t?not ok|\t?[0-9]+\.\.[0-9]+|\t# .*?:.*?).*$')
> >
> > Since you now strip off prefixes using length, does the old TAP regex no
> > longer work?
> >
>
> Using old regex (i.e. match instead of search) still works - do you
> prefer this be reverted where possible or be changed to search? Search
> is a little more relaxed when it comes to alignment of the TAP output
> (i.e. some lines could have extra leading whitespaces), but right now
> is not necessary.

I would prefer keeping the old regexes. It makes the change smaller. I
also would prefer to not relax the alignment if we don't need to.

> > >  def consume_non_diagnositic(lines: List[str]) -> None:
> > > -     while lines and not TAP_ENTRIES.match(lines[0]):
> > > +     while lines and not TAP_ENTRIES.search(lines[0]):
> > >               lines.pop(0)
> > >
> > >  def save_non_diagnositic(lines: List[str], test_case: TestCase) -> None:
> > > -     while lines and not TAP_ENTRIES.match(lines[0]):
> > > +     while lines and not TAP_ENTRIES.search(lines[0]):
> > >               test_case.log.append(lines[0])
> > >               lines.pop(0)
> > >
> > >  OkNotOkResult = namedtuple('OkNotOkResult', ['is_ok','description', 'text'])

[...]

> > > @@ -234,11 +234,11 @@ def parse_test_suite(lines: List[str]) -> TestSuite:
> > >       expected_test_case_num = parse_subtest_plan(lines)
> > >       if not expected_test_case_num:
> > >               return None
> > > -     test_case = parse_test_case(lines, expected_test_case_num > 0)
> > > -     expected_test_case_num -= 1
> > > -     while test_case:
> > > +     while expected_test_case_num > 0:
> > > +             test_case = parse_test_case(lines)
> > > +             if not test_case:
> > > +                     break
> > >               test_suite.cases.append(test_case)
> > > -             test_case = parse_test_case(lines, expected_test_case_num > 0)
> > >               expected_test_case_num -= 1
> >
> > Do we use this variable anymore?
>
> Yes, this decides whether we are expecting another test case or if
> we've completed the test suite

Ah gotcha. Sorry, I am not sure how I missed that.

> > >       if parse_ok_not_ok_test_suite(lines, test_suite):
> > >               test_suite.status = bubble_up_test_case_errors(test_suite)
> > > @@ -250,7 +250,7 @@ def parse_test_suite(lines: List[str]) -> TestSuite:
> > >               print('failed to parse end of suite' + lines[0])
> > >               return None
> > >
> > > -TAP_HEADER = re.compile(r'^TAP version 14$')
> > > +TAP_HEADER = re.compile(r'TAP version 14$')
> > >
> > >  def parse_tap_header(lines: List[str]) -> bool:
> > >       consume_non_diagnositic(lines)

Cheers!
