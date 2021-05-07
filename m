Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19429376B03
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 May 2021 22:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhEGUG2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 May 2021 16:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhEGUG1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 May 2021 16:06:27 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0B7C061761
        for <linux-kselftest@vger.kernel.org>; Fri,  7 May 2021 13:05:24 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id q2so8598777pfh.13
        for <linux-kselftest@vger.kernel.org>; Fri, 07 May 2021 13:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c3juDObqVzsjpQ4zt+KRVnMaIqtk76tzs1eXGfnrfq0=;
        b=FqxuI7G4lXRX59JzUWXtHjI8iQkPShk8Z9b5qVLOOQTKRkJJVOSKDxSKCaiK5vMORh
         5E7bzyvNmy2OKHKKEpIVkjxi0I9yNEYuMvobYYLlvn1+EUmrmvOi45s7Otq2Wnjw2CFR
         lQ5ZUBZvYJPnGH1bvPaqEW5vOXIAAhArW5+S+oSH4603z+3lViWx1mgQWPdBtSv223uf
         3ProgKg0seuTL7ZpI0eRv1cEom3fx2mUQe2bWucvPpMTyJwqnBgVDchau2mnHWjQ1RU8
         3Q0774OP9a2CS103Y6+0MBQ02OXsUOjW/6qwkqXoDFNWZagNjp6UN1L9xOd2qGvx2pgF
         Hv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c3juDObqVzsjpQ4zt+KRVnMaIqtk76tzs1eXGfnrfq0=;
        b=sHfDfVze/hqjx95oVbEhcL5kpLcrca8gsDo1WTcbU9c67pt7FCSlQ4hnZaJADYGgen
         TwO3UCarCZngcWJEooy9rZzxZHDxwIXCiU7kL+Nj02Pfly4XocyByWvdhb4dBQck6kqJ
         PyKlLj5fL0ii+hDkupdSVFziYgYEDvFqJieW4vMvPmE2Cd4wSPtQFn92pms66Me+Z54G
         cY8p1AY6KkoH8YDV0a7CB6GndlCQwwG+aw+/WKyK3rRa8muyEKKBfsZjksFS/q4W3Tx3
         fZDSxRA/MEzaEnE04s58LaeKtkDLoER1xTPXX93/W8vSJwzlcFfkE88RV1yHq5OIw6s6
         h2tg==
X-Gm-Message-State: AOAM531DgW7Jt12fjHkvIYCkeMwflqsJZCb5ls4gzoZaZg52kwUtjNfv
        g+GCHBgHVTFMjPgDgrcKqA0JcpdmttE0THLnjBAFpQ==
X-Google-Smtp-Source: ABdhPJxbbTlEFkChr0nHAB3mp77sGw2yE5ONf0urDq7scY1p99hozFwPpv481/wBo3CN8/V3MuRITc5PKYMM00W7RIk=
X-Received: by 2002:a63:cc11:: with SMTP id x17mr11645132pgf.159.1620417923430;
 Fri, 07 May 2021 13:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210507050908.1008686-1-davidgow@google.com>
In-Reply-To: <20210507050908.1008686-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 7 May 2021 13:05:12 -0700
Message-ID: <CAFd5g44bot7S-Ya7s7QxnKfXHcy8WxUcNPsZuw_qWMaAQbqLCg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: Do not typecheck binary assertions
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 6, 2021 at 10:09 PM David Gow <davidgow@google.com> wrote:
>
> The use of typecheck() in KUNIT_EXPECT_EQ() and friends is causing more
> problems than I think it's worth. Things like enums need to have their
> values explicitly cast, and literals all need to be very precisely typed
> for the code to compile.

nit: I have not had the typecheck() call prevent any code from
compiling, just generating warnings. I guess you can have a build set
to cause any warning to be promoted to an error; still, I think this
statement is misleading.

> While typechecking does have its uses, the additional overhead of having
> lots of needless casts -- combined with the awkward error messages which
> don't mention which types are involved -- makes tests less readable and
> more difficult to write.
>
> By removing the typecheck() call, the two arguments still need to be of
> compatible types, but don't need to be of exactly the same time, which
> seems a less confusing and more useful compromise.
>
> Signed-off-by: David Gow <davidgow@google.com>

Looks good to me.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

> ---
>
> I appreciate that this is probably a bit controversial (and, indeed, I
> was a bit hesitant about sending it out myself), but after sitting on it
> for a few days, I still think this is probably an improvement overall.
>
> The second patch does fix what I think is an actual bug, though, so even
> if this isn't determined to be a good idea, it (or some equivalent)
> should probably go through.

I don't remember being a huge fan of the typecheck when it was asked
for either. I think I am a little bit more indifferent than you;
nevertheless, I support this change.
