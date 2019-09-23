Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDD8BBEB3
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2019 01:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407758AbfIWXA3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Sep 2019 19:00:29 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:37478 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407756AbfIWXA3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Sep 2019 19:00:29 -0400
Received: by mail-wm1-f45.google.com with SMTP id f22so3820266wmc.2
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2019 16:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NheomKzPKW2HiO42k/aWhcbAiJ5l+K+7jDpvS/2UCew=;
        b=diG0EKL4X7i9gpqndKQQfBJ+p4XplSoqj9LONQgU7o6luErqK/Io9SIMD9+N4gQJQ0
         RGNefEtZFbtSQ3QWPrjmNS9pbV/pEpkvjrcUBlJwdN4s1A+MOZ2i94M+cs0EErPurI3A
         td5YUK4uZAUCPM7sIHQ17ojAuEX7gs1QvVggXsfw5WDwPgdPTU5PpsFwDLSO4HREq4Nn
         AnSXqNSQ6E3/CXT7cAexW06Azka9kZXOdVXeBu0AyLeSRYk1TCA0zIe7Jl/imMzHqOmK
         j1T9004+S+6dv0iBz9A6mZQi2zMcWOBOwXbSXcGVn9SrLurfgUYAZPSh/SmvEaiuo8z8
         Nunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NheomKzPKW2HiO42k/aWhcbAiJ5l+K+7jDpvS/2UCew=;
        b=q1HRAsOY98JIhir7WDrk1hnXswEUiiygzid5MKtir/ZNheuQiBoboYveA85YZLYnuH
         vD49TRxGRc8BJDlgqvm2lEmrrrRbtu4AcAqycBSqIYlCJMNEpg35XFXRQchOmav33s4b
         nXMGhhf0Py+mvPaYbh3Bwwhi1WpUf/mDu58b0grNQwoFlh0BR/Zw8pDkFILu1ijFDzS4
         rapy7/2/F0PWjal1vkX9q8C4DdVSJ0uehwHHqMScl2cPBWY1Th3JPSf5vZQb5/TjiICP
         UzQT/OivtpbjaNr8kKavhCwkx23j8xjlZIIdR3/oodWVyB8cWiDVSzTmTq94ea1MF5ra
         4bLA==
X-Gm-Message-State: APjAAAXL13PY96iUhJL5VOvzkq6rsvF0dJU9OrHza3rJKl2/WBgymd8p
        LGMft67KjaeuFGwNhSp25gOTCHfUUA57yiQXmYdx2g==
X-Google-Smtp-Source: APXvYqxYie1vyLom73q69eCdq3lAmMCjIbPlU9OfuFNfgsNopZ+EjvQWp/ZRtRa6d1VQyogenW/LcW9ibOFZPJi8A3U=
X-Received: by 2002:a7b:c84f:: with SMTP id c15mr14918wml.52.1569279626850;
 Mon, 23 Sep 2019 16:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <CABVgOSk79D0pmcWn-ynwGMfSxiD5AGrYWHmcQ5awre7QnQoKPg@mail.gmail.com>
 <CAFd5g4659KMmAtJshzs0n=rPZX5EGFBgYfNkH5RznZH=JnxeHQ@mail.gmail.com> <2e2441c8-eba7-e5c5-ae18-8d9141c0de98@kernel.org>
In-Reply-To: <2e2441c8-eba7-e5c5-ae18-8d9141c0de98@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Mon, 23 Sep 2019 16:00:14 -0700
Message-ID: <CABVgOS=tgjQ5J6kaQRHHi=Fxr_cWRJ+-3BgEqx2QkyTFfoYArw@mail.gmail.com>
Subject: Re: kunit: what do we do with the 'kunit/alpha/master' branch?
To:     shuah <shuah@kernel.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Chiang <davidchiang@google.com>,
        David Siebert <David.Siebert@l3harris.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Salvatore <mike.salvatore@canonical.com>,
        Pei Huang <peihuang@google.com>,
        Sagi Shahar <sagis@google.com>,
        Sangsu Ha <sangsu.ha@samsung.com>, kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 23, 2019 at 2:52 PM shuah <shuah@kernel.org> wrote:
>
> My concern with this approach is either one could outdated. is there a
> reason continue in parallel mode. I would rathet see development happen
> upstream so we don't have lot of code to be upstreamed sitting in an
> experimental branch while upstream keeps moving. It is given that they
> will diverge.

I definitely appreciate that, and the aim certainly is to have most
changes go straight upstream without passing through the
'experimental' branch first.

The real purpose of the 'experimental' branch is to have somewhere to
keep the mocking functionality before we're ready to upstream it.
Given that there are already people using the current version of the
mocking framework, we want to provide a smooth-ish path to upstream by
providing this branch which is at least closer to upstream than when
we are now (and that'll stay as close to upstream as possible through
regular rebasing, rather than staying 'stuck' on the older versions).

Ultimately, the 'experimental' branch should go away once all of the
pieces of the mocking framework have made it upstream, so this is
really outlining a transition plan. Now, if we thought that the
mocking changes were sufficiently ready, we could try to upstream them
soon and kill the old 'kunit/alpha/master' branch without having the
intermediate 'experimental' branch. As it is, though, I don't think we
feel the mocking framework will be ready for quite some time.

So, yes, they'll diverge a bit, but hopefully a bit less than with
what we're going now with our 'kunit/master/alpha' branch. Most
development that doesn't relate to the mocking system should go
directly upstream, and we'll try to minimise the divergence in the
'experimental' branch by rebasing it regularly on top of any upstream
changes.

When in doubt, though, KUnit changes should definitely be going
upstream rather than to this 'experimental' branch. Hopefully that
minimises the divergence and makes this more tolerable.

Cheers,
-- David
