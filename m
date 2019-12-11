Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 131E411BA81
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2019 18:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbfLKRke (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Dec 2019 12:40:34 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35823 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729512AbfLKRke (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Dec 2019 12:40:34 -0500
Received: by mail-lj1-f194.google.com with SMTP id j6so25053238lja.2;
        Wed, 11 Dec 2019 09:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xHNe/Yqfgpy3S9fO7I4bSqFvrI1vIc8c/PjlGfBZDQY=;
        b=THkd5/sMvoWbf9UyKW0AbrpgZ9BE2d8hfLaEQB+I14Diub31RDnCRsU20R7KCaXjpN
         UAOjbsbXLS5vCddmaHoUJXrN2NXPFIOsu7sBYiXc5Ib3PcPxoq+eQ5IPSKL+zvygoQte
         mWKTxvhHznQClUeeCFwH7xslKJFHyMsjgun4OTRAbOwJzBOG/9KpZDARYsCr1UvAJup4
         QleZw4JLBqlyj0GQjnavq3BU5r+sY0l20p8NurV+r0kAiJ54MxkOxKf11viGT4N96R3n
         18BPyJ0wxWuoIi23dXYXExCYxqSRVoIbhxVxLM+9N3vUfNTiF0fFpGygn6qeJUHbvf79
         EzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xHNe/Yqfgpy3S9fO7I4bSqFvrI1vIc8c/PjlGfBZDQY=;
        b=MKRPwwt0Z6FaWdhealTGgLGpbWKnOQ8ZgtYtIOVrfC2H+IuY+pnmeSE/kCvGDNxuFe
         oisbiWQW6t8CIdaCXvUktZfdQH/yf9tOE0LYeWBYYkAEuHJKHt1woozebXTj2vhg1WcG
         MIqDudR6+qcQyBulX9lCwOP33oMBC+/0oBH9yDZBW7XnIh/7U6izx8imzOb7THkOh2VP
         6Sr4HinJxUlaTmbMhGqVSGBQ2sQG0Nj5EyAXAvnFcyrsIujTLKyeLH9YJ+o8+PIgyoPe
         XElbEZzeR4zEyavxNtvQMv+i0YPBuv5orlAZIlgIzhYYg0x7sDOv2eN2rlOf8wktb0X3
         aKyg==
X-Gm-Message-State: APjAAAXREzyCDw+POTaRZslkZAT5kjIFzehXUe9JgSuNC6MGQwEZ8lBg
        iRe8Z6nCqGiNf3XB1XYH6dzLlDcWfOff5LQekfNHsp3u
X-Google-Smtp-Source: APXvYqwXYcdWREeEGLWMl6g/WmqXcAKn/eRGAxh1th5CLy4FEjntZLJeZTgM4oiKx6bx8e6DUwt8aWT9Opg0rNNrWZk=
X-Received: by 2002:a05:651c:152:: with SMTP id c18mr2972027ljd.146.1576086031635;
 Wed, 11 Dec 2019 09:40:31 -0800 (PST)
MIME-Version: 1.0
References: <20191211163310.4788-1-sj38.park@gmail.com> <3dab421e-6aa5-90e4-791e-53482f5c1fe8@kernel.org>
In-Reply-To: <3dab421e-6aa5-90e4-791e-53482f5c1fe8@kernel.org>
From:   SeongJae Park <sj38.park@gmail.com>
Date:   Wed, 11 Dec 2019 18:40:05 +0100
Message-ID: <CAEjAshqjjVgtf_JxNvi3WOvkrjOp_-YjK=rY7GE0Mt40Y1EMqQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Fix nits in the kunit
To:     shuah <shuah@kernel.org>
Cc:     SeongJae Park <sjpark@amazon.com>,
        Brendan Higgins <brendanhiggins@google.com>,
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

On Wed, Dec 11, 2019 at 6:22 PM shuah <shuah@kernel.org> wrote:
>
> On 12/11/19 9:33 AM, SeongJae Park wrote:
> > May I ask some comments?
> >
> >
> > Thanks,
> > SeongJae Park
> >
>
> + Brendan
>
> > On Thu, 5 Dec 2019 10:34:34 +0100 SeongJae Park <sjpark@amazon.com> wrote:
> >
> >>
> >> This patchset contains trivial fixes for the kunit documentations and
> >> the wrapper python scripts.
> >>
> >> This patchset is based on 'kselftest/test' branch of linux-kselftest[1]
> >> and depends on Heidi's patch[2].  A complete tree is available at my repo:
> >> https://github.com/sjp38/linux/tree/kunit_fix/20191205_v5
> >>
> >> Changes from v4
> >> (https://lore.kernel.org/linux-doc/1575490683-13015-1-git-send-email-sj38.park@gmail.com/):
> >>   - Rebased on Heidi Fahim's patch[2]
> >>   - Fix failing kunit_tool_test test
> >>   - Add 'build_dir' option test in 'kunit_tool_test.py'
> >>
>
> Please include Brendana Higgins on kunit patches.

Not sure how I could forgot adding him.  I will never forget from next time.


Thanks,
SeongJae Park

>
> thanks,
> -- Shuah
