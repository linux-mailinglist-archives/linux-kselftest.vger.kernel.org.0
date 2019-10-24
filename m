Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37FCCE27BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2019 03:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392581AbfJXBal (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Oct 2019 21:30:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37535 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfJXBal (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Oct 2019 21:30:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id p1so13199232pgi.4
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Oct 2019 18:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kFL6MAKoUNxEuAIHN1PWFGFSUcj97yttSbxdUQL9jwE=;
        b=AMC+H86YQvtL1rSE0AZPDQTRtIBkO+AdyU5FKKBOtlHgf35sa7+lYz5xZyX7JHBKSG
         PxzS0l+X9QCchLrCzHUNt96nqXZJ5nHZD0XjD66pn9q1Z4d7NWkeHam5AflWuRycW+3c
         eBeqmw9SHypxkOaxms8FzID1gW5yc/A3grmcZQXliHx8yko2R36Qzp5ip70BQu02q9WX
         lheQ2/XFx7Re5Vdaaofugg8rjgfyfhPqGZjGT4AtSVLifzfKh86XiJoWv/TeHk/tiZn0
         0q7+1tjTIDOwbbyGTZZ2gxou+5ur29VLv0CCS5LJYd+1kTHUWniYnqKL262ZyjJc/EIA
         gcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFL6MAKoUNxEuAIHN1PWFGFSUcj97yttSbxdUQL9jwE=;
        b=UP1UC0giahz8uMpeaiRoDQgec6xJcWLrCBCyStsFhkU/ReAUTa6IilJSYQ0xRiSWEs
         n/HKE7JnUkJqSOrpSRIwlkmJ8h2Cz4f+GBoZYWWs6T3Kiw1ALPQcAblUGz5j9ntUMoaS
         Q+bK7F0a0IheEKMOY899AfcO3lcqZLL+6Fy4BM7O+KKVbyvUCdNPx0PzWOTg8fSvoPWx
         UzN1tK+cwWm92TgFREaHDk1YHYQnUEPkyCXrFXwalFflEr3JU2HoAQ/GCZMs25kSqOwc
         i7yi41OqICkcn5PyPI6I/z2/XijYkLUugiPmXbEEUL+Q2QW6lx2amW1TIGjKPAHMp2h6
         vs9w==
X-Gm-Message-State: APjAAAXcE8Mdo8XESQzhM6KI2X1K+iuw/+rvSERPAXxp5FWc0vwsHnSt
        K/GoPvztIV0oEh0N6AXQjA4HVHHKm7e4i0vH9GszGN/eYnqaaQ==
X-Google-Smtp-Source: APXvYqwKQsjE81m9s/ekxEiucVkShMtOIXh3zrjzoxSNMQXt10u9MECyS0K7zZx8LK3fVuArj6UIkStx4b+xKkua2Wc=
X-Received: by 2002:a62:3387:: with SMTP id z129mr14468237pfz.185.1571880638286;
 Wed, 23 Oct 2019 18:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAFd5g46RcFV0FACuoF=jCSLzf7UFmEYn4gddaijUZ+zR_CFZBQ@mail.gmail.com>
 <20191011131902.GC16225@mit.edu> <CAFd5g45s1-=Z4JwJn4A1VDGu4oEGBisQ_0RFp4otUU3rKf1XpQ@mail.gmail.com>
 <1e6611e6-2fa6-6f7d-bc7f-0bc2243d9342@linuxfoundation.org>
 <20191017120833.GA25548@mit.edu> <ECADFF3FD767C149AD96A924E7EA6EAF977D0023@USCULXMSG01.am.sony.com>
 <20191017225637.GB6371@mit.edu> <ECADFF3FD767C149AD96A924E7EA6EAF977D00A4@USCULXMSG01.am.sony.com>
 <20191018014027.GA21137@mit.edu> <ECADFF3FD767C149AD96A924E7EA6EAF977D01DC@USCULXMSG01.am.sony.com>
 <20191018152746.GF21137@mit.edu> <b433854d-3140-95cd-6847-003dcf3851bc@linuxfoundation.org>
In-Reply-To: <b433854d-3140-95cd-6847-003dcf3851bc@linuxfoundation.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 23 Oct 2019 18:30:26 -0700
Message-ID: <CAFd5g45qckg+sON9ErM_vWJSEy1+=jFyvXY0-zvdGfcK0wB1yg@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v2] ext4: add kunit test for decoding
 extended timestamps
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Iurii Zaikin <yzaikin@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 18, 2019 at 1:24 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 10/18/19 9:27 AM, Theodore Y. Ts'o wrote:
> > On Fri, Oct 18, 2019 at 02:40:50AM +0000, Tim.Bird@sony.com wrote:
> >> We're just talking past each other.  My original e-mail was a rebuttal
> >> to your assertion that any test that was data-driven or non-deterministic
> >> was a fuzzer.  I still believe that's just not the case.  This is independent
> >> of the mechanics or speed of how the data is input.
> >
> > Apologies, I was still focused on the original context of this thread,
> > which was about suggested improvements to Iurii's ext4 kunit test, or
> > perhaps adding new features to Kunit.
> >
> >> I also conceded (multiple times) that externally data-driven
> >> techniques are probably more aptly applied to non-unit tests. I've
> >> heard your pitch about speed, and I'm sympathetic.  My point is that
> >> I believe there is a place for data-driven tests.
> >
>
> As such what this current test does is data driven right. What we are
> discussing is how the data is supplied? In this case it is embedded.
>
> > I guess I would put it differently.  The key goal is it should be
> > really easy for developers to run, create, and extend tests.
> > Data-driven tests is certainly one technique to make it easier to
> > extend tests, and indeed fs/ext4/inode-test.c is data-driven with the
> > goal to make it easier to add additional tests.
> >
>
> Again I would make the distinction that "how the data supplied".
> Embedded in the test vs. having the flexibility to accept external
> test data. From what I can tell,  I didn't see anybody say that the
> embedded data is it and nothing more needed.
>
> Instead of adding the ability to read, the suggestion is for modifying
> the data. This gets real tedious and don't think anybody will take the
> time to do it. On the other hand, is there a few test data files to run
> with, it makes it easier to exercise different cases.
>
> > Having the data for the test be external is certainly one option, and
> > there will be cases where it will make sense.  However, the overhead
> > in creating the parser for the data, and additional complexity
> > required to get the test data to be fed to the test program means that
> > that benefits need to be pretty large in order to balance the
> > additional costs of having an external data file, especially for
> > Kunit.
> >
>
> Let's explore it further before deciding whether is useful or not.
>
> > In terms of the abstract question, is there a place for data-driven
> > tests, I'm in complete agreement with you.  I've used this many times
> > personally, especially when writing tests which are implemented in
> > terms of shell scripts.  Examples of this include e2fsprogs's
> > regression test suite and xfstests.  I don't consider that a terribly
> > interesting question though; I view that as on the same order as "is
> > the sky blue?" or "are apple pies yummy?"
> >
> > The more interesting, and more concrete question is whether there is a
> > place for external data-driven tests in Kunit, and there I am *much*
> > more skeptical.
>
> This is what I am interested in exploring. I do think it will add value.
> I can see some use-cases that could benefit from this.
>
> I am not suggesting that this should happen soon. This is something that
> can be looked into for the future. I have a few use-cases in mind that
> could benefit.
>
> btw. I am by no means suggesting to that this test going in is dependent
> on the external data. I already sent my Reviewed-by for the v6 and
> planning to pull it into linux-kselftest test for 5.5-rc1.

I am not opposed to exploring this further.

How about we make this a follow up task to making a generic mechanism
for parameterized tests? I seem to recall that Tim and Iurii both
thought that a generic mechanism for parameterized tests was a good
idea, and I am certainly not opposed.

An implementation like JUnit's[1] I think would lend itself to an
extension that allows loading additional test cases in a running
kernel. Does that sound like a good starting point?

Basically, I imagine having a mechanism not dissimilar to JUnit's
parameterized tests that allows test parameters to be specified in the
test suite, but in a way that is decoupled from the test case. It
should be relatively straightforward to allow the data structure
containing the test parameters to be overridden at runtime without
really affecting how the test is implemented in anyway. It should be
transparent to the test maintainer.

Thoughts?

[1] https://dzone.com/articles/junit-parameterized-test
