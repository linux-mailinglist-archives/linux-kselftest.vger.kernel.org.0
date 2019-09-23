Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0D18BBE0F
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2019 23:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502999AbfIWVls (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Sep 2019 17:41:48 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:44510 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390047AbfIWVlr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Sep 2019 17:41:47 -0400
Received: by mail-pg1-f172.google.com with SMTP id g3so7173624pgs.11
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2019 14:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zjHt44Fl+axePhJiYINVzQJUZJs/FYN4XgWoDnbz0aY=;
        b=RiGjTo7A6/cxzOXGzCP9RQ3aP5Xmq8R2cDwM6kTjgqpiOFQx63Ps0JxZM77Iu5ZJnW
         APunfGasMxkjelcyKjPj4sQirQRXaHIkySw7UhEfUeKTJQrKHGDhiNdRBxMHLID3zC+D
         tZBb2tENM+8NR/S/e6g8QfOHhl9ebOMYR5s8E7LqTwdZneLYncpeRV7M+ZjiHwmYGzbb
         mYPFtmoXeMtQJHkaVTSW7/FlwLkjDmGJKnJYqAgxjxlWx3TGPS/v08rzvMLwSVaY2Eq2
         g6aevj7YOvQfn4xrwYCOag04l4OVC593ljdI7hJ/hahsqby+WPmWRnUSuH5aGpyaJOde
         lZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zjHt44Fl+axePhJiYINVzQJUZJs/FYN4XgWoDnbz0aY=;
        b=Ekrf1GwQRXfFU7TP/vECnpqhTSLgZdPo2bbO9ygWaO5GgCXav1v+kHpL1dsTWq2CIo
         bHLo8uQCUU8XkSflC7/+KPAQpeUjYXp4PUBGPH7fcqZG2fPBhZFU9C73E9vhNvl4XuLZ
         6er3weCg29ylt9sQqNbjg9ZUH9tCSTg5idpJrJZshImNU1REBW1IvZAZyJRTPxNRt+7/
         qM+ins0IuJQn2h9/Kuzx9RJdb4QcyUzZTJtX4VD8hjMWf792ZdZk15lIpnay7jVYL8ph
         kFJXyVswFwhZ/KIWAe8920YZyHjJOQxgiErwDv/cKa8L7LKJwQh3QiOeetf9EScbBFSi
         oWHg==
X-Gm-Message-State: APjAAAV1C6NjS8ztHZ5CYnn+2d6uR+lc3fulmH4EL2ZfU2508NZwNuPf
        Gq5BZGsoAN1EBMuH3MdcLIg5seM0DtXq2dQ1SWbS0Q==
X-Google-Smtp-Source: APXvYqzFh0Vhn7AAG0a95U0LOxpaSwWFWl9vC3jMRlKXkTRcL9KGuOdARtjVONk6dYoyDCii7TCKr8aH+I53anoqQAQ=
X-Received: by 2002:a63:ba47:: with SMTP id l7mr1956155pgu.201.1569274905911;
 Mon, 23 Sep 2019 14:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <CABVgOSk79D0pmcWn-ynwGMfSxiD5AGrYWHmcQ5awre7QnQoKPg@mail.gmail.com>
In-Reply-To: <CABVgOSk79D0pmcWn-ynwGMfSxiD5AGrYWHmcQ5awre7QnQoKPg@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 23 Sep 2019 14:41:34 -0700
Message-ID: <CAFd5g4659KMmAtJshzs0n=rPZX5EGFBgYfNkH5RznZH=JnxeHQ@mail.gmail.com>
Subject: Re: kunit: what do we do with the 'kunit/alpha/master' branch?
To:     David Gow <davidgow@google.com>
Cc:     David Chiang <davidchiang@google.com>,
        David Siebert <David.Siebert@l3harris.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Salvatore <mike.salvatore@canonical.com>,
        Pei Huang <peihuang@google.com>,
        Sagi Shahar <sagis@google.com>,
        Sangsu Ha <sangsu.ha@samsung.com>,
        Shuah Khan <shuah@kernel.org>, kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 17, 2019 at 11:41 AM David Gow <davidgow@google.com> wrote:
>
> TL;DR: We expect KUnit to be accepted upstream into Linus' branch in
> the next week or two, and we now need to figure out what we are going
> to do with our non-upstream 'kunit/alpha/master' branch.

Given that it has been about a week and we haven't heard any comments,
complaints, or concerns about this. I assume that there are no strong
opinions against this, and people will be generally okay with this
strategy.

As mentioned previously, we are expecting to see KUnit make it into
torvalds/master this merge window (the next week or so), so we will
probably update/rename kunit/alpha/master shortly thereafter.

Cheers

> Hello everyone,
>
> We've put together a rough proposal of what we should do with our
> not-upstream branch, known to most people using it as
> 'kunit/alpha/master'[1], now that KUnit's acceptance into mainline
> appears to be imminent (the KUnit MVP patchset is now in linux-next,
> and the merge window just opened).
>
> ==========
> Background
> ==========
>
> KUnit development is currently split between two versions: the
> 'kunit/alpha/master'[1] git branch, and the version being submitted to
> the upstream Linux kernel. While there are some good reasons to
> continue to have two separate versions of KUnit, at present there is
> some uncertainty around the difference between these versions, and in
> which circumstances each version is useful.
>
> At present, the 'kunit/alpha/master' branch serves a few different
> purposes. It is a place for code not-yet-ready for upstream -- such as
> the mocking framework -- while being developed, while also acting as a
> stable version for customers who do not wish to follow along with the
> changes made during the upstreaming process. Adding to the confusion,
> the name 'kunit/alpha/master' refers to an early (alpha) version of
> KUnit, and the version of KUnit being upstreamed has now diverged
> significantly from this version, requiring significant differences in
> documentation, and requiring a number of changes to tests when porting
> from one version to the other. Finally, it is not clear how the
> 'kunit/alpha/master' version should evolve as features it contains are
> upstreamed.
>
> On the other hand, the version being upstreamed has its own
> complications. It contains significantly fewer features (as features
> such as the mocking frameworks will be upstreamed individually), and
> so is less useful for the average customer. Until each feature is
> upstreamed, it is iterated on rapidly to address comments from the
> kernel community, so in-progress features are not stable enough to
> reasonably build on. Finally, it exists only as a set of patches on
> mailing lists, rather than as a maintained git repository (due to the
> fact that the patches themselves are changing rapidly), making it
> difficult for early adopters to incorporate into their own trees.
>
> Whilst we believe there to be enough (at times conflicting) goals
> above to justify having multiple versions of KUnit, we want to ensure
> that they are meeting their goals, and that we have a process to
> ensure that code finds its way into the correct version, that we can
> deprecate and remove failed experiments or superseded versions, and
> that we can keep pace with upstream kernel releases.
>
> ============
> The Proposal
> ============
>
> We propose having two tracks of development: the upstream kernel
> (comprising both code that has been upstreamed, and code which is in
> the process of being upstreamed -- i.e. is being reviewed on the
> mailing lists), and an 'experimental' branch, which contains features
> which are yet to be submitted upstream.
>
> Periodically, the 'experimental' branch will be replaced with a new
> 'experimental' branch based on the latest upstream version. This will
> allow us to focus on code based on upstream versions by deprecating
> earlier, experimental versions of features. The older experimental
> branch will stay around, but receive no new features or support:
> customers will need to eventually migrate to either the upstream
> kernel (if all of the features they require have been upstreamed), or
> to the latest 'experimental' branch (if they still require
> non-upstreamed features).
>
> Where practical, 'experimental' branches will try to provide a stable
> interface (and/or compatibility layers/shims) such that users can
> write tests against an experimental version and expect our changes to
> break them infrequently. We don't intend to make any solid guarantee,
> however: so users will need to be able to deal with some breakage.
>
> We expect most changes to KUnit to be submitted directly upstream, and
> reserve the 'experimental' branch for features where:
> a) the design is yet to be proven by early adopters, and is likely to change;
> b) the feature is large enough that having a solid staging environment
> in which several developers can work is necessary; and/or
> c) it depends on existing features only available in the 'experimental' branch.
>
> An example of features suited to the 'experimental' branch are the
> mocking systems[2].
>
> =====================
> Lifetime of a feature
> =====================
>
> A new feature (that for one of the above reasons may require some
> experimentation before being sent upstream) would typically be
> developed as follows:
>
> 1. An initial version of the feature is developed against the latest
> 'experimental' branch.
> 2. The feature is tested by users of the 'experimental' branch.
> 3. It is revised as needed within the 'experimental' branch. If
> breaking changes are required, and supporting some form of
> compatibility layer is practical, such a layer is implemented to avoid
> breaking existing 'experimental' customers.
> 4. Once the feature is deemed ready, it is submitted to the mailing
> lists for the upstream kernel. Any compatibility layers for earlier
> experimental version are removed -- this is a 'clean' version of the
> change.
> 5. Development of the change continues on the kernel mailing lists:
> any particularly important changes or bugfixes are ported to the
> 'experimental' branch if feasible, but complete convergence is not
> expected at this stage.
> 6. When the feature is accepted upstream, a new 'experimental' branch
> is created based on the new upstream kernel. Development on the old
> 'experimental' branch ceases.
> 7. The upstream version of the feature has now superseded the
> experimental version. All future development is done based on the
> upstream version, either in the new 'experimental' branch, or directly
> against the upstream kernel.
> 8. Any customers still using the experimental version of the feature
> will need to update their code to work with the upstream version in
> order to update to the new (supported) 'experimental' branch, or to
> the upstream kernel.
>
> ===========================
> What does this mean for me?
> ===========================
>
> ...as a user?
> -------------
>
> If you're using the upstream version of KUnit, nothing! Features will
> continue to be pushed upstream when they're ready.
>
> If you're using the 'kunit/alpha/master' branch, then you'll need to
> switch to the new 'experimental-<version>' branches. Every so often,
> we'll create a new 'experimental-<version>' branch, and you'll need to
> rebase your code on top of that to keep receiving updated features and
> bugfixes. While we intend to make this as painless as possible, there
> may be breaking changes which require you to rework some of your
> tests.
>
> Once a feature exists in the upstream kernel, the version of that
> feature in the 'experimental' branches should stabilise somewhat.
>
> ...as a KUnit developer?
> ------------------------
>
> For most changes/bugfixes which apply cleanly to the upstream version,
> you should directly submit these upstream as before. If it is feasible
> and useful to backport them to the latest 'experimental' branch (e.g.,
> they are bugfixes to code that the experimental branch already has),
> please do so.
>
> For more major features (or anything which depends on
> yet-to-be-upstreamed code), you should develop them in the latest
> 'experimental' branch. For the most part, you can treat this the same
> way as the old 'kunit/alpha/master' branch, but note that changes will
> need to be rebased on top of a newer experimental branch periodically.
> It may make sense to use this as an opportunity to tidy the code up
> somewhat: by removing compatibility code for deprecated features, or
> to merge 'fixup' commits. Once the code has been upstreamed, the next
> rebase of the 'experimental' branch should only use the upstream
> version: there should not be a separate 'experimental' version of
> upstream code save for the development of a new 'experimental' feature
> or bugfix.
>
> For more details, see the 'Lifetime of a feature' section above.
>
> =============
> In Conclusion
> =============
>
> We'll continue to be working with upstream as before, but we intend to
> rename and more explicitly specify the purpose of the
> 'kunit/alpha/master' branch as above. This will require a bit more
> work from people using and developing against this 'experimental'
> branch, but allows us to continue to use it for features such as the
> mocking framework while limiting its divergence from upstream.
>
> Do let us know if this sounds reasonable to you, if it will affect
> your use case, or if you have any questions.
>
> Cheers,
> -- David & Brendan
>
>
> [1] https://kunit.googlesource.com/linux/+/refs/heads/kunit/alpha/master
> [2] https://kunit.googlesource.com/linux/+/kunit/alpha/master/Documentation/test/usage.rst#187
