Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA50EF0AC7
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2019 01:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbfKFAAK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Nov 2019 19:00:10 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39222 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729711AbfKFAAJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Nov 2019 19:00:09 -0500
Received: by mail-pf1-f194.google.com with SMTP id x28so14139527pfo.6
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Nov 2019 16:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lhPGHL3YRrXYTue69wU9eU8V8Hx/b8hEqaEa6yTMnkc=;
        b=VlMCTkpT+whd9RxOskp1d0UAGHuA0h6fy1q55ME6v1BSRDECHdj3UWLD4/nl2kFi57
         QpRQjXkkG5d9C2XQorCh+PtySWXjM/1Ism68mr8kGSxX6kw1HJkesh4FOnHnGPZ9dsTD
         aamT7cM11W7vGaxrQIWXJJmkRttlHajiwihfjEq3uvKt5ZGOqMDiLRXukqUs6y4y/I+F
         ZcRpXOi/VnaKLTPk1GXl1k3S8OX8QuI+UWU+nJm83HCp9Fd9umODkJeL+YS99b/pyJVz
         +T2egQKbxqr6HH1esUB6oT76CdyQY8WAkKAuJWMpkQA1MU1q9jVYpcx+lmxI6UmsWCNh
         to6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lhPGHL3YRrXYTue69wU9eU8V8Hx/b8hEqaEa6yTMnkc=;
        b=nYNzwP/5FPDsNG2b+J2nHHIcJbD2Ctm5kVqu6o+QWECnqyBCminXjMFH34a2Aw2prV
         vg/usvSkJaZZPqOyY0jeXqWv0w1ROSd2/UZF4uNcfvHsQavX052axc5fT7pht9QQ3ND5
         N3BT/olU+/NkV4vGUtgpE8Rs/P0cnqg6OFy5RwETHedZGea3tDEt//MKD3disPhw1/Ce
         pzZJF7h2QcmMUdSiVSULkJAI4ue8MQ2T5jyKAnxPRMPnBHgT4z/rt78VJ9t8EtlGhguE
         5FdYBXbI/oXgLquBu+7j+jfbIZhIzOafyAMXVzY34oNtyUL05zTf4UhLhnyeOfRnzArC
         SKhQ==
X-Gm-Message-State: APjAAAWIOgN3zAQ34oHcDD8yWaA/+RkRR+tipDf0xzYO5S73Jno1/K2b
        0SlgNHlZh9xPWezQXL7xPUQsRU9UGCcPJDiZsYkdlA==
X-Google-Smtp-Source: APXvYqx2fYUU/NkVF71Am9HasgI3vwxMoHR3QiibGcvRUftbZnyu0R3anDH7NSvGotdiSWDPP3VbGLfdWXuUHeNFMvw=
X-Received: by 2002:a65:664e:: with SMTP id z14mr39064849pgv.201.1572998408009;
 Tue, 05 Nov 2019 16:00:08 -0800 (PST)
MIME-Version: 1.0
References: <20191018001816.94460-1-brendanhiggins@google.com>
 <20191018122949.GD11244@42.do-not-panic.com> <alpine.LRH.2.20.1910191348280.11804@dhcp-10-175-221-34.vpn.oracle.com>
 <CAFd5g46aO4jwyo32DSz4L8GdhP6t38+Qb9NB+3fev3u4G6sg4w@mail.gmail.com>
 <20191024101529.GK11244@42.do-not-panic.com> <201910301205.74EC2A226D@keescook>
 <CAAXuY3o31iCJwZ+WGHMaK1MgpC0qv=JkJWnzv8Lhym9TnZQvcQ@mail.gmail.com>
 <CAFd5g446cyijzgap9r8nm_202zkUsfdZXrn5E1_Mfe-R+eFb_g@mail.gmail.com> <205525ba-dc2f-34a9-b7dc-4421285535d7@canonical.com>
In-Reply-To: <205525ba-dc2f-34a9-b7dc-4421285535d7@canonical.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 5 Nov 2019 15:59:56 -0800
Message-ID: <CAFd5g47_H=JeC-esa_1H2jgwvW5kThWYzm6Wj_XonEsk-J6JDw@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
To:     Mike Salvatore <mike.salvatore@canonical.com>
Cc:     Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Matthias Maennich <maennich@google.com>,
        shuah <shuah@kernel.org>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, David Gow <davidgow@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 5, 2019 at 8:43 AM Mike Salvatore
<mike.salvatore@canonical.com> wrote:
>
> >> but such approach is not mainstream.
> >> I personally like the idea of testing the lowest level bits in isolation even if
> >> they are not a part of any interface. I think that specifying the
> >> interface using
> >> unit tests and ensuring implementation correctness are complementary but
> >> I haven't had much luck arguing this with our esteemed colleagues.
>
> In general, testing public interfaces is preferable, however, I think it's
> important to avoid becoming dogmatic. IMHO, it's more important to have tests
> that are clear in what they test than to not write tests (or write confusing
> tests) in order to adhere to a generalized principle.

That's a really good point.

> > So I think this is a very subtle point which is very widely
> > misunderstood. Most people write code and then write their tests,
> > following this practice along with only testing public interfaces
> > often causes people to just not test all of their code, which is
> > wrong.
>
> The very nature of this situation is that the code was written before the tests.
>
> > The idea of only testing public interfaces is supposed to make people
> > think more carefully about what the composite layers of the program
> > is. If you are having difficulty getting decent coverage by only
> > testing your public interfaces, then it likely tells you that you have
> > one of two problems:
> >
> > 1) You have code that you don't need, and you should remove it.
> >
> > 2) One of the layers in your program is too think, and you should
> > introduce a new layer with a new public interface that you can test
> > through.
> >
> > I think the second point here is problematic with how C is written in
> > the kernel. We don't really have any concept of public vs. private
> > inside the kernel outside of static vs. not static, which is much more
> > restricted.
>
> I don't think we can expect developers to refactor large portions of complex
> kernel code in order to improve its testability. I imagine this will happen
> naturally over time, but I think we need to allow for developers to test
> "private" code in the meanwhile.
>
> My opinion is that it's more important to have tests than not. As evidence, I
> submit the following commit:
> https://github.com/torvalds/linux/commit/156e42996bd84eccb6acf319f19ce0cb140d00e3.
>
> While not a major bug, this bug was discovered as a direct result of writing
> these unit tests. So, in summary, I see value in "testing the lowest level bits
> in isolation", even if it doesn't necessarily represent the Gold Standard in
> Unit Testing.

You're right.

I think, in summary, it seems that pretty much everyone agrees that we
need to provide a mechanism for testing low level bits of code in
isolation in such a way that the tests are easy to write, and don't
require the code under test to be massively refactored. Beyond that it
seems that we are mostly in between either including tests in the
source for the code under test or using the __visible_for_testing
mechanism. Between the two, it seems the preference is for including
the test in the source.

So I think I will still send out a patch to add in the
__visible_for_testing mechanism in case someone wants to use it in the
future.

Nevertheless, I will reformat this patch to include the tests in the
files that are under test. One question, do we have a preference
between putting all the tests in the same file as the code under test?
Or do we want to put them in a separate file that gets #included in
the file under test? I have a preference for the latter, but will
defer to what everyone else wants.

Thanks everyone!
