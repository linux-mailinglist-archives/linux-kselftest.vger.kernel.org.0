Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79A5111C2EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2019 03:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfLLCGW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Dec 2019 21:06:22 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45641 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfLLCGW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Dec 2019 21:06:22 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so245465pfg.12
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2019 18:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z8uVJuk9Rij22sABZy2BWSypOjcfhaayG9+6fPbQbo4=;
        b=kJlWk2d8oy9p5Y0PRDaFDUDjrYDaNJqrDSBo/7NW3RUFN0wawvqDXTJf+eYArOA1KS
         L4U0DzZxi66nDk6Rqk8bZ2i8fLsH4TorrtqhtGiK83RQ8OJIPE4Igae1H82+RoBfHtxc
         KhPChDpzklLsHIWQtFhmd66zg8Vk6EYmbQNj2yHokXqXzgwkIPc2GX+irfLUGz6jV7kX
         ZM9IRXqS2A36l1VOeJjFWyEqcon+NEUR/IYh2ITZfvVrXExLSMMoyWNenGh4ebbZi0L0
         JUAP+U6BxU+R70W7ojw9TnGVnOzt7ODDIzjGV/AN/Y9rymQVRAoXYtslGduK7r2Nameh
         MwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z8uVJuk9Rij22sABZy2BWSypOjcfhaayG9+6fPbQbo4=;
        b=SGvVrXQbCeK75zMwOtNqbnbmxHAS8RYBtH3flhTqqgKlvbqbF+SmNFP5GQcisqUIwV
         opQkgIr6bdzyYpayzsrxQ+zVElUI16GowHZsM7bzGQZB+BoWNJjhdW2bMPX6QXbAt1TE
         8BGr1vQCogcB1mzDtjBQJsYR7r3Cnu7YVhPASBfGI/cUQVqC2SiUHu+QSVxSMRcubMVa
         R+vuX5axOOxsttqnOQuaVdcQUtuctQZ4l6afazf+ivkDB10yWfQ92rTqzyj5qV5eJiim
         A9wIKUgFpQtzqpdcbE6IBudFm3V3YWbYXOBcoByxXV+3V8rUjWz808Qz0njwO3hm/tk1
         1lkQ==
X-Gm-Message-State: APjAAAWOZkN+C3S2XLoQ+EJTxnhJQ6CbxEJ+3FI4X7V+aZKcf2f14XO/
        GLSfK+f21FYxvkksQ4aY5v6rn86mn4p2Kvww6YWXjg==
X-Google-Smtp-Source: APXvYqwMuQVtQeasph6V25QIqqP76VeDN8XIyJ4UupJQ3Egb1/mmDEEURWdiUS8rqAYz+CzRrEM4bFbeFjrv7MR5Aew=
X-Received: by 2002:a63:597:: with SMTP id 145mr7496590pgf.384.1576116381498;
 Wed, 11 Dec 2019 18:06:21 -0800 (PST)
MIME-Version: 1.0
References: <20191211163310.4788-1-sj38.park@gmail.com> <3dab421e-6aa5-90e4-791e-53482f5c1fe8@kernel.org>
 <CAEjAshqjjVgtf_JxNvi3WOvkrjOp_-YjK=rY7GE0Mt40Y1EMqQ@mail.gmail.com> <CAFd5g4649_C0tSy3W-KzN05Y8K5zZtGUGVYFA9iAKvaXsPentw@mail.gmail.com>
In-Reply-To: <CAFd5g4649_C0tSy3W-KzN05Y8K5zZtGUGVYFA9iAKvaXsPentw@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 11 Dec 2019 18:06:10 -0800
Message-ID: <CAFd5g46X4P7dfJWVw9hdvhVupanuZU-_KWGzostRy_e1Z=P1Og@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Fix nits in the kunit
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     shuah <shuah@kernel.org>, SeongJae Park <sjpark@amazon.com>,
        Jonathan Corbet <corbet@lwn.net>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 11, 2019 at 9:45 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Wed, Dec 11, 2019 at 9:40 AM SeongJae Park <sj38.park@gmail.com> wrote:
> >
> > On Wed, Dec 11, 2019 at 6:22 PM shuah <shuah@kernel.org> wrote:
> > >
> > > On 12/11/19 9:33 AM, SeongJae Park wrote:
> > > > May I ask some comments?

SeongJae,

I reviewed and tested all your patches. Everything looks good to me
with one minor caveat: I tried applying your patches on
kselftest/fixes[1] and got the following error:

error: patch failed: Documentation/dev-tools/kunit/start.rst:21
error: Documentation/dev-tools/kunit/start.rst: patch does not apply
Patch failed at 0005 kunit: Rename 'kunitconfig' to '.kunitconfig'

I think the merge conflict is fairly straightforward, but it would
still probably make Shuah's life easier if you rebased your patches.

Cheers!

P.S. Thanks for the patch adding the test case for test the build_dir
thing. I really appreciate that!

[1] https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=fixes
