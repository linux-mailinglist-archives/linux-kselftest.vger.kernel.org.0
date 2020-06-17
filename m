Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754C81FC4F9
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jun 2020 06:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgFQEGO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Jun 2020 00:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgFQEGO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Jun 2020 00:06:14 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71353C06174E
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jun 2020 21:06:12 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t18so753347wru.6
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jun 2020 21:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5PuPiLXB+Zn09O0tzAIe764d7r3OYmp8OwnNdcrO+bA=;
        b=I7Uq/MjZ+H2xYtZZ4lA3ybOmOnECnv1eu4jmKgICIFg1a36hkRrBKNn6pAPwS4YOOj
         pTi8/SQv0GJSutNn6gIjqRYG0ulgepo/AWTgsqY7UggatblWIsgzcI9iKBJPxzJj9LCI
         KpdUWKIow4A/LejdoB21mNpx7LguFSeW0ht7ShdHmcu64lscjRejQgcGXcCQAJXbzfHV
         rnCSvWG1f89gwvLN2HoMic9sPr7nqASI77NOfJ9HFCpx8DDcnWAlOdOVBbF99OrEEU27
         /f1XXJdZ2LIUu+hGG5ktnbDJl7awX5pxuprv+heMCzxv5vqgMo+4zfYDhNK2GiTGS7JR
         Jy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5PuPiLXB+Zn09O0tzAIe764d7r3OYmp8OwnNdcrO+bA=;
        b=XsiqGsQ7tL7YVTewcttIt530Y3bYYOgEa+UA14BF1N6qCbepREf9RDvskdwpxyj7ys
         sFYzFJIupOS/o1GS9y2ASPSv9owAyNWqUPgN+C5WZSlev2aGlmxsmXnFl+ZwKQqKv1Yt
         8nTo4WqYnsnfTD8LEzgpI7G/jDELvtdr4P+Go/WK7QdjzcEOP+7UdrMXpDfjAByDVq/p
         AJGin0ayTXFJFi7wG79yDGzaNvdbV1iUJ55DfVIb/NbF3lKkUuRwMI6N0VOj3+DShH4T
         7l+CemwRVNpgjuBd16XgZxC5tF8TNrIU+AGwe+G0PqV54hqaK1MhyteR4tUkwPfTUyBZ
         Gg9A==
X-Gm-Message-State: AOAM530kuQfV04iFwJx6fkz/DwrDCVdULctrKDhgNibKCPTWrqvXfmyx
        BsDaQK9SWls8ZduxkT6o07yJ9CcW03/hcIoMDthUiA==
X-Google-Smtp-Source: ABdhPJxo7S4BNCm1hKAaH+x6SbN8seI34s31YejfTVkfl5aLhC7YykVSJY6L56UwCmIH6aI86ha+buwLc2koBjYu4k0=
X-Received: by 2002:adf:b60b:: with SMTP id f11mr6193172wre.7.1592366770496;
 Tue, 16 Jun 2020 21:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <20200616204817.GA212825@google.com> <CY4PR13MB1175A71AE3937C0786721ABFFD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006161703.B2E51605@keescook> <CY4PR13MB1175DCC4066FC0839A6B2E84FD9A0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006162032.9BF6F8F4E@keescook>
In-Reply-To: <202006162032.9BF6F8F4E@keescook>
From:   David Gow <davidgow@google.com>
Date:   Wed, 17 Jun 2020 12:05:59 +0800
Message-ID: <CABVgOSn48gw3pMSCccmF8FK=3UPF+Spe47AiDQcMiXkk3k4yqQ@mail.gmail.com>
Subject: Re: RFC - kernel selftest result documentation (KTAP)
To:     Kees Cook <keescook@chromium.org>
Cc:     "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 17, 2020 at 11:36 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Jun 17, 2020 at 02:30:45AM +0000, Bird, Tim wrote:
> > Agreed.  You only need machine-parsable data if you expect the CI
> > system to do something more with the data than just present it.
> > What that would be, that would be common for all tests (or at least
> > many test), is unclear.  Maybe there are patterns in the diagnostic
> > data that could lead to higher-level analysis, or even automated
> > fixes, that don't become apparent if the data is unstructured.  But
> > it's hard to know until you have lots of data.  I think just getting
> > the other things consistent is a good priority right now.
>
> Yeah. I think the main place for this is performance analysis, but I
> think that's a separate system entirely. TAP is really strictly yes/no,
> where as performance analysis a whole other thing. The only other thing
> I can think of is some kind of feature analysis, but that would be built
> out of the standard yes/no output. i.e. if I create a test that checks
> for specific security mitigation features (*cough*LKDTM*cough*), having
> a dashboard that shows features down one axis and architectures and/or
> kernel versions on other axes, then I get a pretty picture. But it's
> still being built out of the yes/no info.
>
> *shrug*
>
> I think diagnostic should be expressly non-machine-oriented.

So from the KUnit side, we sort-of have three kinds of diagnostic lines:
- Lines printed directly from tests (typically using kunit_info() or
similar functions): as I understand it, these are basically the
equivalent of what kselftest typically uses diagnostics for --
test-specific, human-readable messages. I don't think we need/want to
parse these much.
- Kernel messages during test execution. If we get the results from
scraping the kernel log (which is still the default for KUnit, though
there is also a debugfs info), other kernel logs can be interleaved
with the results. Sometimes these are irrelevant things happening on
another thread, sometimes they're something directly related to the
test which we'd like to capture (KASAN errors, for instance). I don't
think we want these to be machine oriented, but we may want to be able
to filter them out.
- Expectation failures: as Brendan mentioned, KUnit will print some
diagnostic messages for individual assertion/expectation failures,
including the expected and actual values. We'd ideally like to be able
to identify and parse these, but keeping them human-readable is
definitely also a goal.

Now, to be honest, I doubt that the distinction here would be of much
use to kselftest, but it could be nice to not go out of our way to
make parsing some diagnostic lines possible. That being said,
personally I'm all for avoiding the yaml for diagnostic messages stuff
and sticking to something simple and line-based, possibly
standardising a the format of a few common diagnostic measurements
(e.g., assertions/expected values/etc) in a way that's both
human-readable and parsable if possible.

I agree that there's a lot of analysis that is possible with just the
yes/no data. There's probably some fancy correlation one could do even
with unstructured diagnostic logs, so I don't think overstructuring
things is a necessity by any means. Where we have different tests
doing similar sorts of things, though, consistency in message
formatting could help even if things are not explicitly parsed.
Ensuring that helper functions that log and the like are spitting
things out in the same format is probably a good starting step down
that path.

Cheers,
-- David
