Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82787E0E0F
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2019 00:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfJVWNp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Oct 2019 18:13:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43837 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733141AbfJVWNn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Oct 2019 18:13:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so14531260wrr.10
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Oct 2019 15:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ku3pVReh2uTG0fjS/o0UF/A3EaftmBxds8FIWHFbut0=;
        b=PDEmlQDhCP653ij6dycpergXBe/VRKLRbFJtNZPxXa6zBuxs8d6zGPO4ENhj1gv4a5
         YSsPMpdwkJF8PfL3AKqr38fI7JVcWKmXHtQ8rZFbEpS90IUF0aohLZDdDgshMQspLu8D
         I1x061hTSno9s0TLsub87AwqEIaE89DgYIORuTwL6etOA7UJU8Rkv6hfvtg2+EJMjtCC
         jqOKFuVD7gSDbEOh1sy/sPkgZCpgQPovij771Tb0gCCH7g15GRLK0CnI3EXo/OWXTC3+
         AIyyeFXpTvEmAAqEENbZqpcaZr3TL7LJ6DovkhmtNsuoiWGI1hyiAEaN8xb1sz/CPWik
         G8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ku3pVReh2uTG0fjS/o0UF/A3EaftmBxds8FIWHFbut0=;
        b=RVcmUX664hipwfs6tjxw83LLnysLsFYT4WY2W1uJy8YYBZlJWXTqOS1IvJ2aLO6W1t
         ltgnA8oJbF+FwVrZy0qrG+1lX/hz5sv4lTYiLHChwyoWsZ32e8wt1y7Nn1X0IXtohixG
         7hlg2sGKsbRTAEp+RwzPnMWBSRfYJYNQYcq+TH/QHZJI5YXOj6ZH6HtbQYwZ9kJdSuy4
         TeWCtMKakDg3SpM4u+gDEJ/68T3fYFsYCN+qdN7Bho+/VREpCScoboF7JjRRjevopavl
         ZE7w++9XsryXDtmG0n03aioKf281nm6YwlvzeZgkCCOSyIpwKRe6twRCzYPBkjEo5YuE
         dbLQ==
X-Gm-Message-State: APjAAAUFCGCp6W+iSmJQG2/nusc9We+sjstC0UQHu6+lSRTiH/ZxznhJ
        PurGZLhVuS3xfU0UwDSmeWc4tzNSRaW+reR5ZaCLVw==
X-Google-Smtp-Source: APXvYqx06y6Dy+tcDSaYjqTEiIPp/DHJpG/C5qWlCA6tfumXIoOR/EVzHd8CrGUB2khATPQSOrvIaITrxXy+FBrNRKw=
X-Received: by 2002:a5d:404d:: with SMTP id w13mr2435470wrp.185.1571782420558;
 Tue, 22 Oct 2019 15:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191018215549.65000-1-davidgow@google.com> <20191019082731.GM21344@kadam>
In-Reply-To: <20191019082731.GM21344@kadam>
From:   David Gow <davidgow@google.com>
Date:   Tue, 22 Oct 2019 15:13:28 -0700
Message-ID: <CABVgOSkegmhmeRa=7Qcx3MnX88wLy9qZx97CMhk4NvWb-pgpYQ@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v4] lib/list-test: add a test for the
 'list' doubly linked list
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Oct 19, 2019 at 1:27 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Fri, Oct 18, 2019 at 02:55:49PM -0700, David Gow wrote:
> > +     list4 = kzalloc(sizeof(*list4), GFP_KERNEL);
> > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, list4);
>
> Why not just use GFP_KERNEL | GFP_NOFAIL and remove the check?

I've sent a new version of the patch out (v5) which uses __GFP_NOFAIL instead.

The idea had been to exercise KUnit's assertion functionality, in the
hope that it'd allow the test to fail (but potentially allow other
tests to still run) in the case of allocation failure. Given that
we're only allocating enough to store ~4 pointers in total, though,
that's probably of little use.

> kzalloc() can't return error pointers.  If this were an IS_ERR_OR_NULL()
> check then it would generate a static checker warning, but static
> checkers don't know about KUNIT_ASSERT_NOT_ERR_OR_NULL() yet so you're
> safe.

Alas, KUnit doesn't have a KUNIT_ASSERT_NOT_NULL() macro, and I'd
assumed it was not dangerous (even if not ideal) to check for error
pointers, even if kzalloc() can't return them.

Perhaps it'd make sense to add a convenient way of checking the
NULL-ness of pointers to KUnit (it's possible with the
KUNIT_ASSERT_PTR_EQ(), but requires a bit of casting to make the type
checker happy) in the future. Once KUnit is properly upstream, it may
be worth teaching the static analysis tools about these functions to
avoid having warnings in these sorts of tests.

For now, though, (and for this test in particular), I agree with the
suggestion of just using __GFP_NOFAIL.

Thanks a lot for the comments,
-- David
