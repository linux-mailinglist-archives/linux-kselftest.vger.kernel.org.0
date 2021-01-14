Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104542F6E14
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Jan 2021 23:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbhANWUu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jan 2021 17:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbhANWUt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jan 2021 17:20:49 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F360C061575
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 14:20:09 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id b8so3658792plx.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 14:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Do79F0qCKpJd7LSoRqgLMEzb1pOqhgiMpv8fnU8/fbo=;
        b=k+NjQDLbgIimZJchpQ+b1b+Cg8mX1+7364ivdWf0Wzz2+9hTqem3XdAIqy5WJ4bf0G
         M2Xgzzknf604bcHhgbqDlYzaDcpd57s1s5KUb3TScPNNxv8pNynTRziXV12ptOYsZwiq
         NfX3/teSMazs7Hie41XrQ13PhbSUIazcxwXXZLHl5FyNtaNKnIbiXtDj1qOWLeCnjbWd
         7/3KSAI0cOw60iax4CIjcO/1FdKTJJkM6afhCOlz4PDe13+loSVdu8mmbfDtYrbdWvsc
         fvZwG+PUMvMUMCXnJ6+yfnuS7nmdY6TEfCS5siBo51+m4GcfQNdrVU3X2D4VQdhS59Eb
         JZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Do79F0qCKpJd7LSoRqgLMEzb1pOqhgiMpv8fnU8/fbo=;
        b=Wg+Zp+FRsuCL0C2lPF/VyBTf92iPy0F109X8DJWU/mfIH0Q3p9VtOj58tltc+onW59
         tvFx2kNVarTie+Um6JyflpNAdS0S3rzg0cee2W9S2qho2dk3eo9LbFhrrbvRtQ6GOgBe
         uUUHm0C5A7gxIqexRQ/M4H6dE5OY981UA9y0ak+6xgKT+lLkZaR9+eydZ+N22X3ALTtd
         onDcEDPXHEyrIM87IiLX+jrrpaz8UfVUR5aOmRWTjYL4jUdT/VWVqwVKiMZ2WENJw0cv
         IuPxV8DS0UdPI/vt082DBjAhuGsdjw9xkVxQCrr1vlKf1ATY6VmuIs0delAHvShV2ANx
         uelg==
X-Gm-Message-State: AOAM533VGgPs/l3sVG8+3VNiCCsePNftFJcXopsv1b25EhAVO65rWVyz
        1hL/pOwELSBMStlXYIczvkMwkXsom3OdKtVKwu+kXg==
X-Google-Smtp-Source: ABdhPJw9uBU9jQLLAQC6qlEuCIK+zjIemNgSj2UYEKyxihwOwbYeyc/8LFnpNCBLmQ/4u3+Vmsm3tgL1esZiv4hkRh4=
X-Received: by 2002:a17:902:fe87:b029:da:5d3b:4a84 with SMTP id
 x7-20020a170902fe87b02900da5d3b4a84mr9569152plm.51.1610662808494; Thu, 14 Jan
 2021 14:20:08 -0800 (PST)
MIME-Version: 1.0
References: <20201202190824.1309398-1-dlatypov@google.com> <20201202190824.1309398-3-dlatypov@google.com>
In-Reply-To: <20201202190824.1309398-3-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 14 Jan 2021 14:19:57 -0800
Message-ID: <CAFd5g47+1o4W4Dq_pH4eN5-qGgO5gBGj-6kpMkHQ4ESSXHCGSA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] kunit: tool: use `with open()` in unit test
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 2, 2020 at 11:09 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> The use of manual open() and .close() calls seems to be an attempt to
> keep the contents in scope.
> But Python doesn't restrict variables like that, so we can introduce new
> variables inside of a `with` and use them outside.
>
> Do so to make the code more Pythonic.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Tested-by: Brendan Higgins <brendanhiggins@google.com>
Acked-by: Brendan Higgins <brendanhiggins@google.com>
