Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A7746C7EA
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 00:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbhLGXEd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 18:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhLGXEd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 18:04:33 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FBEC061746
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Dec 2021 15:01:02 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id f125so455738pgc.0
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Dec 2021 15:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=55rrWYDZKebf3dwxACmc3YdgzweWYJxj0Se0PreSxpE=;
        b=otePzmPR7kMmFRnzUxq9rbm0GLe6xTOHsWl14emXE524XmcrrmIQZP8EXLym+dUv+V
         TDbKkGrt/2ciza7qdpgZ2QVMInyCqNpoZ+cfhcO/oUxX660NzrPedTf3HiNyvoddnKNL
         cb1Sk8e2Lx827ReWZ191sJV4+GLefD7r+s2aKcPP4p70YJ1gQnvUUPfGEsMs+OaTSo2S
         smUY9Rp3I5XJkQQ2MPsyd03NdKfK7fFzgcaSNRQucBbgecbF7mmtjjJgcr5/yR5M1+h2
         seddlzF9ACX7KGe+cIeg+4KqR5Zopblbza2rXwGcYwSzmI6ejcVxcofe76iP1o87hiCP
         lQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=55rrWYDZKebf3dwxACmc3YdgzweWYJxj0Se0PreSxpE=;
        b=35T8hS/3fOLZ03xvKJaDKbMKBUCyxnv9uXKdr6bJVTZE1DZc9tN9Yy/bVdQiblNVGu
         4LH9tx23SEMO08bvPWlDxQMkxNfZRI4+ojk9Qk6fevEmST5I/b9Y+NCitjY9CkBPucew
         xwwptcwA+Gb4WIrVDGb8ZVesy06F656lSk/d9ancVjym2W5lXFayq80P5GpbuI53MyBx
         D7jcAHHDkpgCaTLdd2vXlO70BqG+OArapWIqme4NWMdMD/8WOgqzH9TGzGTCvBorDico
         f2Vtaoub2RvhosdiHvlA0H7ltipxx/5+ZdMCBXI64D2xQQdulOYccvmkjR8iYjrrp9wn
         OIJA==
X-Gm-Message-State: AOAM532RIZMHlOYVBdPPadkTU08/LAD4tkvSxuG+XfPu74g2xcM1sUKZ
        dbbmGlMnT8SxsxOW5Jzh7S4+f5RdGcgIZP8cMDEdTg==
X-Google-Smtp-Source: ABdhPJzFdZHmW+Yu/K3OlIPRoaUaZ6kqg260gGxxiLVZr3XvDMULeAlunwMdsbuPPqaoTJp2N5ZSQOgUCu40WAcOIhE=
X-Received: by 2002:a63:f91b:: with SMTP id h27mr25751296pgi.12.1638918061654;
 Tue, 07 Dec 2021 15:01:01 -0800 (PST)
MIME-Version: 1.0
References: <20211202203927.2004527-1-dlatypov@google.com>
In-Reply-To: <20211202203927.2004527-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 7 Dec 2021 18:00:50 -0500
Message-ID: <CAFd5g47JTNJbA65586gRTimBjSyvvO=UzT1f7_zPKpy2=93q7Q@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: make `build` subcommand also reconfigure if needed
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 2, 2021 at 3:39 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> If I created a kunitconfig file that was incomplete, then
> $ ./tools/testing/kunit/kunit.py build --kunitconfig=my_kunitconfig
> would silently drop all the options with unmet dependencies!
>
> This is because it doesn't do the config check that `kunit.py config`
> does.
>
> So if I want to safely build a kernel for testing, I have to do
> $ ./tools/testing/kunit/kunit.py config <flags>
> $ ./tools/testing/kunit/kunit.py build <flags, again>
>
> It seems unlikely that any user of kunit.py would want the current
> `build` semantics.
> So make it effectively do `kunit.py config` + `kunit.py build`.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
