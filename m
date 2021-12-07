Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292DA46C74E
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 23:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbhLGWVF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 17:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbhLGWVF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 17:21:05 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C24C061746
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Dec 2021 14:17:34 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id u11so225770plf.3
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Dec 2021 14:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kOpXkc9EXimdPGYt70xvcmH708qI3DPqksqt+BSsfRQ=;
        b=NX6n5x+djHsx9J6TTYMLLYcRFQhs5oC5zU0qPZucEN8U3/RjYWnOOH15rvRl4LMe/0
         fs4NSvh8WYBdT5RAnR2h9FMqV/s8G3prT3BcNYri+/7GmtlVNNJRBSbpDXmEbJ8ntmlr
         X9JIf87sScHB8MX1v9FaNAL9O7svaTx8SAlBFVA1WKENcbecGsz4yp1H4bsoF0tsN/J6
         8fnm/AzmKrp5/TvG300lAO3V6mjvvZJ+ljZZKrzmMp6au+hYW4JQW8GZI6NgY/Robf2+
         3834Rp78S+dQaeNWZfMrxjd2jYgeRzymZXYeYI5IQHSpCmJzVdCLF/TXr5KN0pfuq1vT
         R2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kOpXkc9EXimdPGYt70xvcmH708qI3DPqksqt+BSsfRQ=;
        b=eYqqUohBW0K+OuSCRbCmaOK7WJoQu30GgEkO13AXEkk/w44eXyXW4dYHTB5ZrKKOJX
         3tpNMY/5sohtO3J06hpBzQW7PD466qh+fp04DEqYWfpLFVLcnz8ms+BizWItu1YrXpXb
         OSJ45ecHnw1X0uz1p6sjVsVdFhb9U9Ib6szSyQ7TlO4nu9gVMg5wmzpbHII11bFvrLe/
         Ih6DSS7z8GRZFO5yEf8gMQS8+3F848Krie7o4ffoFuhUOv6+8eK9E5KxLQttY70ObrTZ
         i8WyfZ2pzTiBzKHwB9+YXv51IU73sHh4Ak7MxreIqhaqvUY0nE+Mv20Lcd2tMqnz+cbf
         64dQ==
X-Gm-Message-State: AOAM530zweBpm3lNwcWTHX+Qy28aUCWDMp2hzuvFPEjHlTWVZ9HdaAWk
        G336CEx7qswyb9reWwvigxaKKV6NK7uxZ3bUisP0YA==
X-Google-Smtp-Source: ABdhPJxh2wyWO2gv41Gh3us0oW0BzBpeqCeN6WzQ8/yTrYDnmsCvUCo1XGee3pIcO2G48wGVL+kDbh8wXqNXlBB/Pa4=
X-Received: by 2002:a17:902:cb8a:b0:141:f601:d5f1 with SMTP id
 d10-20020a170902cb8a00b00141f601d5f1mr55260210ply.77.1638915453486; Tue, 07
 Dec 2021 14:17:33 -0800 (PST)
MIME-Version: 1.0
References: <20211009015406.1311319-1-dlatypov@google.com>
In-Reply-To: <20211009015406.1311319-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 7 Dec 2021 17:17:22 -0500
Message-ID: <CAFd5g44+jfgdP47sQwENBXpb0Tf6LdwTJB-H72dNB5HUNZoTZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: tool: use dataclass instead of collections.namedtuple
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 8, 2021 at 9:54 PM Daniel Latypov <dlatypov@google.com> wrote:
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

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Sorry for taking so long to review this!
