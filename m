Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8F32111FAD
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2019 00:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbfLCXLC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 18:11:02 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37642 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbfLCWli (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 17:41:38 -0500
Received: by mail-pj1-f68.google.com with SMTP id ep17so2106338pjb.4
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2019 14:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wvcQSeD9fUy4K6hmpGadBFCY8hD8Kt15D7Xjws7LrzY=;
        b=WxTExWP/19lbIo0fY+5OW62d08F7PomNap1+0TY5sUtrtzPOGpdsJbNrv4BmOK+wo3
         3KpKKvycvKGQnbwQUD2Al8L7apeOOVmQ5/fDbHdSyIJ0SrUYLivf7IxloVayeomLb9D6
         i1CeS+8S8UPrr6e7YawLim1GC2BsdJnla/UxSDKmk6dcYWW0X4LnN+qSgOem6/q0JH3m
         zeqQ1V0aE3sE3jdkBQHuLBrEXZBzEx8xNJm/0PfIzcR13BAG4CeFZ9QSgIkcL+VUsKYO
         BitSJLid6c3cE7TDqygbrOv2IZvQU1R+Rvt8Vme7VGWaPlZfQFX56g8xRsw51zgMS6jT
         noaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wvcQSeD9fUy4K6hmpGadBFCY8hD8Kt15D7Xjws7LrzY=;
        b=PlgL2RiNtPiluFd9PKa/+vqUam/13g3/H6U9Vj15VAwbC1W2So1nMFLWNnCqPM1gWp
         lY8ekT94Y7B5ARt2/AFG74R6jwVWLFa7q7gmaM1vH5pTFcFgd9vgQOQcFnJZ3sHf1XiS
         ZjXar9RORQx5hGpZ6Q7+RqN7Y8ErFdGjYJhTyxZWL6fFbaBdfjkpvLICZq/UqNK2/3VY
         0yVfgC/prDOt/6AUWbtjR0SEnvmE5PWj2w1E4mZ4jqdzt4OzeYbOOH0ujEHdGqvw3027
         JyAhJxd/0pzNRvR8X4EfLFHMb7mpDCosAcOLy4Xi8CkVrT6Q/FhrziLk7Ktos4YTqhcz
         r5sw==
X-Gm-Message-State: APjAAAUzmoHGkuFBAv4rniqhEDLNlKl3FM87RW4doTMaijMN72CMb5hy
        HCM5Lx9ap/X1ZCUBVXCz9RtBPaxzqdOyIhoD55zgrQ==
X-Google-Smtp-Source: APXvYqwNBKITRg7JLfQdIfZ7Hq2in6sPhBtMwgNhkjM1eOSXrNFrRKWgmizNbNOpj7SVMke2uCVL05noCM3vd+KB1eQ=
X-Received: by 2002:a17:90a:d155:: with SMTP id t21mr7870642pjw.84.1575412897403;
 Tue, 03 Dec 2019 14:41:37 -0800 (PST)
MIME-Version: 1.0
References: <1575396508-21480-1-git-send-email-sj38.park@gmail.com>
In-Reply-To: <1575396508-21480-1-git-send-email-sj38.park@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 3 Dec 2019 14:41:26 -0800
Message-ID: <CAFd5g46X9WK-xKJFF5AVYXXmM4a2dYD3fy=oi1CGJM1gc9RzuA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Fix nits in the kunit
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, shuah <shuah@kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 3, 2019 at 10:08 AM SeongJae Park <sj38.park@gmail.com> wrote:
>
> This patchset contains trivial fixes for the kunit documentations and the
> wrapper python scripts.
>
> Changes from v2 (https://lore.kernel.org/linux-kselftest/1575361141-6806-1-git-send-email-sj38.park@gmail.com/T/#t):
>  - Make 'build_dir' if not exists (missed from v3 by mistake)
>
> SeongJae Park (5):
>   docs/kunit/start: Use in-tree 'kunit_defconfig'
>   kunit: Remove duplicated defconfig creation
>   kunit: Create default config in '--build_dir'
>   kunit: Place 'test.log' under the 'build_dir'
>   kunit: Rename 'kunitconfig' to '.kunitconfig'
>
>  Documentation/dev-tools/kunit/start.rst | 13 +++++--------
>  tools/testing/kunit/kunit.py            | 16 ++++++++++------
>  tools/testing/kunit/kunit_kernel.py     |  8 ++++----
>  3 files changed, 19 insertions(+), 18 deletions(-)

Tested-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
