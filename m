Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1EA2AA262
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Nov 2020 05:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgKGEJa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Nov 2020 23:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgKGEJa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Nov 2020 23:09:30 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B34C0613D2
        for <linux-kselftest@vger.kernel.org>; Fri,  6 Nov 2020 20:09:30 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id l10so3680403lji.4
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Nov 2020 20:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BpAfVVjgmSK3TmddDXe5MIH+iN8xL47kEByfErGtVvs=;
        b=qqrX9/Q9kWM5Hap5VqxZRuBzpk+TCPCwB2DK0d7bCQJv9e2ODwHzqawgp4Z1/BME0E
         mc5bB22vycMiYxW6Lb3c3reutDclxHw7FfKhk4gijTycG+Rj3BJ/fpjvOlevLe7iPFXH
         90eUKN6JH86AH6eu7zCKI3aNK5Iik6jzaNjDliUG5eXokIinJ4WKVao73VTUvO6RHJRN
         Dh309SDDL4PyqEKGThRnB+qf/2HVMn6fCtYFOPRK5Oy9nbEhVTS5DQ4VGJ1D6vLvqmPn
         PA0jTqyXpYzh7sVOs+/wwedE6j25cOPvKfS5aQ2hqYp9ZgAHIZE5+YMsK/iWoDxZRZ80
         oclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BpAfVVjgmSK3TmddDXe5MIH+iN8xL47kEByfErGtVvs=;
        b=EnY8rJgjMaSTFBCLCHqDuHKPA5jp0zcjfiUiKMHBnUamRqGjQv+5y1X4N755KxE0+p
         cVAzKNh9nQiw2Og8+hzHtSNwr4ql6YMEYDf/UHvH3NlpBTJUmYgCvsF6FXhzbxLrSK7k
         4RmtEzYmXcwRdzCXOQn/c6pGVQPrD/+qMVRAlTuGKwFzDP9Jqur8oYZ3SZhqVjcLn1zF
         7Guw8Ov7eatLHfldVRBa8yaZrmnyeBZdCFjXCSvCj04UgJzpcK+JPbwudVM6VmISvCmt
         3IWhbARTJU6UI2L/m0r4zRe8h9YOrZfG0F9E4J8MP61mCjTrUmeEdJYH3XI4byr2+yMK
         zd1Q==
X-Gm-Message-State: AOAM533Vq9l6Du4XwKTTp7b443lHkAn0uBXgpp5sxmc/fzr9o0iiz0Bv
        A+eZf0hPzS+SO+5PuGsdsiMmqW71hA872+u25v/Baw==
X-Google-Smtp-Source: ABdhPJwquss92yG7I1ZRnnJ5suJ/Xcui705PIWdISDMrw0xVQ+ZekSp6zhR9hvvPcTCR4ttgp/64K3qiWWgZ8RMJlSk=
X-Received: by 2002:a2e:93cf:: with SMTP id p15mr2053113ljh.141.1604722168145;
 Fri, 06 Nov 2020 20:09:28 -0800 (PST)
MIME-Version: 1.0
References: <20201105232440.1049635-1-brendanhiggins@google.com>
In-Reply-To: <20201105232440.1049635-1-brendanhiggins@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 7 Nov 2020 12:09:16 +0800
Message-ID: <CABVgOSnVj+EXZ13vgx7pj3fFJ7yx9xPYU39nuCP_v_fNYpN12w@mail.gmail.com>
Subject: Re: [PATCH v1] kunit: tool: unmark test_data as binary blobs
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 6, 2020 at 7:24 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> The tools/testing/kunit/test_data/ directory was marked as binary
> because some of the test_data files cause checkpatch warnings. Fix this
> by dropping the .gitattributes file.
>
> Fixes: afc63da64f1e ("kunit: kunit_parser: make parser more robust")
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
Reviewed-by: David Gow <davidgow@google.com>

Thanks. I wasn't able to find any issues which required those files to
be binary.

For the record, a link to the original issue, which appeared to be
with whitespace (spaces before tabs) in git apply:
https://lkml.org/lkml/2020/3/13/920

Cheers,
-- David
