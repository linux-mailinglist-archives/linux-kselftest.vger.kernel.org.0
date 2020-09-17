Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F5526E7F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Sep 2020 00:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgIQWGm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Sep 2020 18:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgIQWGl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Sep 2020 18:06:41 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF56C061756
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Sep 2020 15:06:41 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id v14so1908477pjd.4
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Sep 2020 15:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KGNmIQxkdvUG3FJy4i5PBk+ji2PTypNkOa0bskKz16s=;
        b=EaqigPaJOr6zzGO1gy3rVaDoZkIxYX1OWLosQF+sjumKAYPELnTLFQ6bdp1H+yafVN
         HXWuwkjp9Zd4RV142Qe0R8wi6t+9dYOVRkwH0gGxAIL9j2GhMUlDd76IwzQZTGTCjyAT
         gGCBimh9PMJ72w2Oa2z4sAEFv0bybwKf8JJ04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KGNmIQxkdvUG3FJy4i5PBk+ji2PTypNkOa0bskKz16s=;
        b=hFMioPqyynjjUT2/nRZljTmURjw6J7xwKMnLJTd/FFTukUpHQO14j4lNJzA3YQHTMg
         K6q9OxQD3i2+Fc3URJ/nuw8fupTqHqRFxJt+qaCr38/Oll6dmRaBPIJb4qQiKZ3bhCG8
         7xkLYRREK/9TEsxKx84YqMYkU4OJHV1Agl4D8FLPySmeTkPS8HELocW9B6j5ajKioSsW
         3B69beMYlN5toIlJ0oCJfK8KoN2ZpAu46X6I+aAccfkHrx94X8mZ6U9PohJDw8UDgYhw
         Y1FRO5rShUSqikd3C2KRhLzcokk9Jn6V9C1UGi7ZzeBpgd7J+DBXkahw7kuSmeSJGcSF
         o9iQ==
X-Gm-Message-State: AOAM531g851RDxC+AIeYjoffLTApGAn9nqZ0lVxk0ilONYdSc53gPUoG
        GBXZO/9B49L1rzZ/LOaDETqXLA==
X-Google-Smtp-Source: ABdhPJxVxMDAVNtxxj0yGmkKjx8X6uSL8vN/TWKF3VyOltmqZVZ34+YdBYAC7vSM7w8gckWvKUnQVg==
X-Received: by 2002:a17:902:b10b:b029:d1:e5e7:bdf8 with SMTP id q11-20020a170902b10bb02900d1e5e7bdf8mr12609117plr.43.1600380401403;
        Thu, 17 Sep 2020 15:06:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d128sm661053pfc.8.2020.09.17.15.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 15:06:40 -0700 (PDT)
Date:   Thu, 17 Sep 2020 15:06:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/harness: Flush stdout before forking
Message-ID: <202009171506.535C5678@keescook>
References: <20200917041519.3284582-1-mpe@ellerman.id.au>
 <CAMo8BfJ5j4nG0z1Bk00J=3xPM++J68Hp2idJ-D5aHT84-vOzsQ@mail.gmail.com>
 <e24df908-c50d-59ef-563c-9db24c819248@linuxfoundation.org>
 <99f67c84-4dcd-278a-e7b8-e19054818ecf@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99f67c84-4dcd-278a-e7b8-e19054818ecf@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 17, 2020 at 10:51:32AM -0600, Shuah Khan wrote:
> On 9/17/20 6:58 AM, Shuah Khan wrote:
> > On 9/16/20 10:53 PM, Max Filippov wrote:
> > > On Wed, Sep 16, 2020 at 9:16 PM Michael Ellerman
> > > <mpe@ellerman.id.au> wrote:
> > > > 
> > > > The test harness forks() a child to run each test. Both the parent and
> > > > the child print to stdout using libc functions. That can lead to
> > > > duplicated (or more) output if the libc buffers are not flushed before
> > > > forking.
> > > > 
> > > > It's generally not seen when running programs directly, because stdout
> > > > will usually be line buffered when it's pointing to a terminal.
> > > > 
> > > > This was noticed when running the seccomp_bpf test, eg:
> > > > 
> > > >    $ ./seccomp_bpf | tee test.log
> > > >    $ grep -c "TAP version 13" test.log
> > > >    2
> > > > 
> > > > But we only expect the TAP header to appear once.
> > > > 
> > > > It can be exacerbated using stdbuf to increase the buffer size:
> > > > 
> > > >    $ stdbuf -o 1MB ./seccomp_bpf > test.log
> > > >    $ grep -c "TAP version 13" test.log
> > > >    13
> > > > 
> > > > The fix is simple, we just flush stdout & stderr before fork. Usually
> > > > stderr is unbuffered, but that can be changed, so flush it as well
> > > > just to be safe.
> > > > 
> > > > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > > > ---
> > > >   tools/testing/selftests/kselftest_harness.h | 5 +++++
> > > >   1 file changed, 5 insertions(+)
> > > 
> > > Tested-by: Max Filippov <jcmvbkbc@gmail.com>
> > > 
> > 
> > Thank you both. Applying to linux-kselftest fixes for 5.9-rc7
> > 
> 
> Kees,
> 
> I haven't pulled this in yet. If you want to take this through seccomp
> tree for dependencies:
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

You can have it -- it's a global fix and more than the seccomp selftest
is likely affected. :)

-- 
Kees Cook
