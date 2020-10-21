Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09ADC295395
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 22:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504444AbgJUUog (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Oct 2020 16:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440812AbgJUUog (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Oct 2020 16:44:36 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF95C0613CE
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Oct 2020 13:44:34 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o7so2204774pgv.6
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Oct 2020 13:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ToNH8GJuZ5rTdifevtZT8GFNBviH6s2F8SrsK2qyVY0=;
        b=eR/u85b/Zu/amsL8sCxSY2DnlP2Ehk3lIHJnhKz0Lo/gM0vBBdbixGiQlZ5J0xQZlv
         yODucoIDiS4Ab48gtTtCHB/X3vsuT6qGAxVE24qmG8mbpb6olpl5oVeertMysd1tJsGh
         AiYx01TeIjGW48ApOv7+VvBCHqaW4SXpJafYy+HNJhciEPo/XjPuL6fthVdBi039Qcyq
         PBxp/I+h/ujkmKG9JRqjH7UWvXIamXWIJhcfBYz7fdH/cv8hti7OXrGpzkcNYmmeRDK4
         N0nIw3DY+7L0dnJmCLkbJmOC4ie0iYQ0L2VxBD2aac7T10/NYiRhHhY8z5gujzDp6yS2
         srNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ToNH8GJuZ5rTdifevtZT8GFNBviH6s2F8SrsK2qyVY0=;
        b=rFFN1JoV3TIqpsPdFTkUGVTZmqA7GXajeB5/L20J8l9UEzXsduLpOc7GxyBgLHHgm8
         ZKZJn792bQtdQGYZ6nSp51Q6uJdgb9ozmGJO/jUmZtlCtTPXsV8xkEB8xFTmhbVHASJD
         dKOzzlQbOHc7fMqKdhu8QDH8ZcgWEguJihGAqNxxNkd9CNqFGMigpJyA0rm/07W6P+Ne
         g8i0HBKQBiabg6LqZ/sejjz4Kvif5BSwtXfEQ5WUSUJuF+OMjVHYnLlknlPiSWxZ4jfj
         YNts8OtQb4zLB+rE3FMVRK7PgmRr9i0H85JuKBmEYfgeLc3UKG5POyQRpqE3eee0O5b9
         vkkg==
X-Gm-Message-State: AOAM5314UnghFWP9IZqiRSW+Vzie90FV1soLWUAGWVbj6is3x7dDr+W6
        afVIUth7zHchP7Jb2exxOPXI1QMWwab7F8t12VzMWg==
X-Google-Smtp-Source: ABdhPJxCBzWvlDptnlUC4y/kkY4UVyb3az9b3ad04JiC78/1Nkpox0BI5W6rCZyYsH1x3/hNf+ty4ao55Bww36Fop0U=
X-Received: by 2002:a62:d44d:0:b029:152:ebc:77f8 with SMTP id
 u13-20020a62d44d0000b02901520ebc77f8mr5394843pfl.14.1603313073426; Wed, 21
 Oct 2020 13:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201021192518.31187-1-sjpark@amazon.com>
In-Reply-To: <20201021192518.31187-1-sjpark@amazon.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 21 Oct 2020 13:44:22 -0700
Message-ID: <CAFd5g45cz=8ytDt+xC_kkF19j0rU2TvkM2siiGCpG4nXxe6CEQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: Update Kconfig parts for KUNIT's
 module support
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, SeongJae Park <sjpark@amazon.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Gow <davidgow@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 21, 2020 at 12:32 PM SeongJae Park <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> If 'CONFIG_KUNIT=m', letting kunit tests that do not support loadable
> module build depends on 'KUNIT' instead of 'KUNIT=y' result in compile
> errors.  This commit updates the document for this.
>
> Fixes: 9fe124bf1b77 ("kunit: allow kunit to be loaded as a module")
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
