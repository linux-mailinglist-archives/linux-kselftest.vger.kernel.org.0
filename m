Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1917B41FA49
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Oct 2021 09:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbhJBHbs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Oct 2021 03:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbhJBHbr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Oct 2021 03:31:47 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5DAC061775
        for <linux-kselftest@vger.kernel.org>; Sat,  2 Oct 2021 00:30:02 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v17so19020327wrv.9
        for <linux-kselftest@vger.kernel.org>; Sat, 02 Oct 2021 00:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SEyWrW3EkUXpbblyqwDbIe+TSvswhgnVquW9bvHGEDo=;
        b=XkoG0bFn0gX2zWP2nn1SI38wac2/wdfWpErZfHN1iWHA/jZ+Qe0o0xN2Kpp+6pS11R
         JMmHIsgPYAGyzh/MQbwbcOiFv0PYGXPAReniWhSXKOQm6ivxvcaNSRqekVd6/IPSvGY2
         AJNsBNLCl+VRLnhBdPkhJ30dWFlNkrO8EJj3E373Nn7XiKbelmhUjcyLXLdP9RplEViT
         Is/WCu1GhAqK1U267eLgxZKMDQMN36AFN1TXskCBrM9qG1FJL8eGynsWZyxiGRxy1n5o
         qXbfMekVfE2Pd9OijPwM9S8/hKDPcGeNiuv6etjY+NDTg8gv9hS0G1Jew7wF4JJkZ541
         cdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SEyWrW3EkUXpbblyqwDbIe+TSvswhgnVquW9bvHGEDo=;
        b=kUZysgUXjbhVJTX1cXh8eoxFGQgi9WWrJAnqgSdMXhwOaONvQY5P/yL+sK5M5rGMeU
         jSdsB41sBF0vps6+v9gS2fnIjWY8SEnwURlYJQJhfQOOhEtPfsEtnbasT9zeGmPLWGyR
         CmPy9X3KoQm5mCcLHRK1gILKeVFOHnx+hm2qXQeP0iUvJkq4X83XabDVzPoeIs4iUjDo
         Uv1Vnk73hT0I4Upxu38GnJDIp7Q5K18D2JK8sEO4/zNOiXyrpSchFyXgaiewgBVLiHC2
         zReWt4YRt2p6mNRN/eK4Cq1yCJMO3ghdITLTupefVKhiwQ0LziClvL90S+kp5jTGeBQN
         oPfg==
X-Gm-Message-State: AOAM531dbs2GZFAtiSaEw03QCY6t5ghy+krRXJee98sz6QMdXg5/xrth
        OhQLtQkUXuf1IbABdVHF2/WYZKLDehOH3QZR3hu6+g==
X-Google-Smtp-Source: ABdhPJz7xqi2hQQBzRXfizbH4DDpHOlIyLcYd/aubmyUfqhwzaukX+4F5MTsa7s6MuvSVBFAVcOe27EPyZxfXLHl75Y=
X-Received: by 2002:a5d:4882:: with SMTP id g2mr2007616wrq.399.1633159800517;
 Sat, 02 Oct 2021 00:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210926223322.848641-1-isabellabdoamaral@usp.br>
In-Reply-To: <20210926223322.848641-1-isabellabdoamaral@usp.br>
From:   David Gow <davidgow@google.com>
Date:   Sat, 2 Oct 2021 15:29:49 +0800
Message-ID: <CABVgOSkG=J7TpuzZMW_RbGA9f4NRZxGXRS8wd-cBmrWHD97pRQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] test_hash.c: refactor into KUnit
To:     Isabella Basso <isabellabdoamaral@usp.br>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>, ferreiraenzoa@gmail.com,
        augusto.duraes33@gmail.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        ~lkcamp/patches@lists.sr.ht, rodrigosiqueiramelo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 27, 2021 at 6:33 AM Isabella Basso <isabellabdoamaral@usp.br> wrote:
>
> We refactored the lib/test_hash.c file into KUnit as part of the student
> group LKCAMP [1] introductory hackathon for kernel development.
>
> This test was pointed to our group by Daniel Latypov [2], so its full
> conversion into a pure KUnit test was our goal in this patch series, but
> we ran into many problems relating to it not being split as unit tests,
> which complicated matters a bit, as the reasoning behind the original
> tests is quite cryptic for those unfamiliar with hash implementations.
>
> Some interesting developments we'd like to highlight are:
>
> - In patch 1/5 we noticed that there was an unused define directive that
>   could be removed.
> - In patch 4/5 we noticed how stringhash and hash tests are all under
>   the lib/test_hash.c file, which might cause some confusion, and we
>   also broke those kernel config entries up.
>
> Overall KUnit developments have been made in the other patches in this
> series:
>
> In patches 2/5, 3/5 and 5/5 we refactored the lib/test_hash.c
> file so as to make it more compatible with the KUnit style, whilst
> preserving the original idea of the maintainer who designed it (i.e.
> George Spelvin), which might be undesirable for unit tests, but we
> assume it is enough for a first patch.
>
> This is our first patch series so we hope our contributions are
> interesting and also hope to get some useful criticism from the
> community. :)
>
> Changes since V1:
> - Fixed compilation on parisc and m68k.
> - Fixed whitespace mistakes.
> - Renamed a few functions.
> - Refactored globals into struct for test function params, thus removing
>   a patch.
> - Reworded some commit messages.
>
> [1] - https://lkcamp.dev/
> [2] - https://lore.kernel.org/linux-kselftest/CAGS_qxojszgM19u=3HLwFgKX5bm5KhywvsSunuBAt5RtR+GyxQ@mail.gmail.com/
>

Thanks: I've gone through this new revision, and it still works fine,
and my prior comments have been addressed. The commit messages in
particular are much clearer, thank you! I've reviewed the various
patches and left a few comments here and there, but there's nothing
too drastic.

I'm pretty happy with this from the KUnit side, but it would be ideal
if someone with more knowledge of the hash functions looked over it.
Unfortunately, George's email is bouncing, and no-one else has made
any particularly major changes to this.

My only remaining comment on the tests themselves is that it'd be nice
to have them split up further into more, smaller tests. Given that
it's a port of an existing test, though, I understand the desire not
to change things too drastically.

We also need to work out how this is going to go upstream: does it go
through the kunit branch (via Shuah's kselftest repo), or directly to
Linus (who's handled most of the other recent-ish changes here.
Brendan, any thoughts?

Cheers,
-- David



> Isabella Basso (5):
>   hash.h: remove unused define directive
>   test_hash.c: split test_int_hash into arch-specific functions
>   test_hash.c: split test_hash_init
>   lib/Kconfig.debug: properly split hash test kernel entries
>   test_hash.c: refactor into kunit
>
>  include/linux/hash.h       |   5 +-
>  lib/Kconfig.debug          |  28 ++++-
>  lib/Makefile               |   3 +-
>  lib/test_hash.c            | 247 +++++++++++++++++--------------------
>  tools/include/linux/hash.h |   5 +-
>  5 files changed, 139 insertions(+), 149 deletions(-)
>
> --
> 2.33.0
>
