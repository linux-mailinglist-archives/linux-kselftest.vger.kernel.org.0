Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF68474D55
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Dec 2021 22:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbhLNVoE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Dec 2021 16:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbhLNVoC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Dec 2021 16:44:02 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DDDC061574
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Dec 2021 13:44:02 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id g18so18928829pfk.5
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Dec 2021 13:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fVJAe3f0Z5eqNi3sM9iQGEnyhWGwhAY+u+A3rnH7GXU=;
        b=pSSYw2Pt8l4ROIISR28TG04nxI7zhkAD/cBk/9APNMduEGKA+8axmrbpoAxt7V5daE
         /3AMUDoA9eKDB79ikMHzoUnRwKveukZCpQLHV42mJFgdnASbWbx+GwaxFe9tsKvoun2U
         87xY7uAyqm1bHNKCKUMUajaHEIzl5Bz/ri+W5RTR22LXIeJLzSiT5uODLwObcEIcjzBV
         qvR8TbTgk12nRJFCgBcC8FaaAyLmbaMLvu5SF2rSOnpq8EplLkdXyDmfWi7RIJgFAE0s
         FMOlQfIwFdmpSohgXSgwGyKn2heFga/B5pUehQwVOLDf1JLMADgcy5T4w9vN3NPUtQL+
         G5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fVJAe3f0Z5eqNi3sM9iQGEnyhWGwhAY+u+A3rnH7GXU=;
        b=fQrOZhe1BfCwnnqbpvfsJajDqdauIXedzE82kQoAJ21GQIGuWjtUsdDe6zK0ej8V5O
         ku4sdYwZ2o4gtPZATcgzlBv0KAk2VbivJDYSHrgeAcv7GEiAF76SuSYFDADNTfmo56Uv
         Jus4nqkxOoRjceYfOezA1DgtuUJId+VgiGv7BI91mZFWqDYC4+3xf32pwhaOv9+dAgE1
         apqdOhE0Rs8WtEHfaWHCPqO/3Gqw2zJB0Y99S5FIXOv7Cm54VQSGxI7tbK3ikeaP7x/p
         LNgTTkbVbI49DJx2Fh9SWJd0nVKas09jBDj2gfABRVOZX6H8xbJmgvG5xMH6FQTsK4rr
         jkUA==
X-Gm-Message-State: AOAM532wf410RRtWKSwRdEGmYFgwXIHEXXH6h1yQxBRt1V5nV7gvvIxt
        bmbG7XENIpvnfe28NkIkI7++p8K9JJV8ul1DsTFAbw==
X-Google-Smtp-Source: ABdhPJz3ZyxeRv4cKrH8u0a9sC31mbfOEz6K+XC1VNxa2Wi3wVAQNlOXSo37bDu4pgooit0KOyrMZMPL3JeN0y59QtQ=
X-Received: by 2002:a65:590e:: with SMTP id f14mr5225001pgu.609.1639518241478;
 Tue, 14 Dec 2021 13:44:01 -0800 (PST)
MIME-Version: 1.0
References: <20211214192612.134306-1-dlatypov@google.com>
In-Reply-To: <20211214192612.134306-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 14 Dec 2021 16:43:50 -0500
Message-ID: <CAFd5g45fP3OuRh-uWeLMYU+YBOFKGBKmzSbXKuWu9QstAD3mRw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kunit: tool: use dataclass instead of collections.namedtuple
To:     Daniel Latypov <dlatypov@google.com>, skhan@linuxfoundation.org
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 14, 2021 at 2:26 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> namedtuple is a terse way of defining a collection of fields.
> However, it does not allow us to annotate the type of these fields.
> It also doesn't let us have any sort of inheritance between types.
>
> Since commit df4b0807ca1a ("kunit: tool: Assert the version
> requirement"), kunit.py has asserted that it's running on python >=3.7.
>
> So in that case use a 3.7 feature, dataclasses, to replace these.
>
> Changes in detail:
> * Make KunitExecRequest contain all the fields needed for exec_tests
> * Use inheritance to dedupe fields
>   * also allows us to e.g. pass a KUnitRequest in as a KUnitParseRequest
>   * this has changed around the order of some fields
> * Use named arguments when constructing all request objects in kunit.py
>   * This is to prevent accidentally mixing up fields, etc.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Looks good. Thanks for the rebase!
