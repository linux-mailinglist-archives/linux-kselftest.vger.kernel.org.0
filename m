Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9ED83A89FB
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jun 2021 22:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhFOUM2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Jun 2021 16:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhFOUM2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Jun 2021 16:12:28 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82F3C06175F
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Jun 2021 13:10:22 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id a127so301057pfa.10
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Jun 2021 13:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bYwjla9m+6Ar2RV6BgbgGMLWxpLDazGjqfkcGgZsTeQ=;
        b=bauH0URTsuFMw1G6hoLeMpKObq9DN+UXLvyYLkT/csnoYo6h2xCKOoxzvxk6L1nRiO
         CP8U7putdHjsUTJ9UNU5pEYVg7YxO68ILw0ti9iajBrnZcSjHWWgGiFRMpNhYlFhV7IL
         YgGIPzdd+N1ekWxkb76/kzzXgM8LXa+uEWXPDZzTtmolBQYH66eIq2P7tYyMsW1FktgI
         nZZ6QGPa+/olAV3QkNBYVHVBczaZmDQKMTFnnTuGjyThpgbsgBBCrh2z3hmqErQmyPM3
         HuymI0VOsbDWJcXKFpgizoyqee+F3g6tH2LMNLa9UcNmWNWVjEyiV3zMUcnlHw7/PEdf
         zKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bYwjla9m+6Ar2RV6BgbgGMLWxpLDazGjqfkcGgZsTeQ=;
        b=I/q4p63qqUDufo5+DbPAcbsyuFUkhMgZBxRHvvf9ja3KNT0NU1tFNjPv38Yt3w+7mb
         K0+57Da3x8se+kMcq8NU63/F1mEAdiParapsuHwPPQTixrBXazreYRmNmZDRafFPHqvB
         FbhG1quLFB+i2rOlmbRxQPJpkDfTJzfZGCa5JurblRSm6z1q39VRwoxcSsCsMR266Cm8
         xWLFw5oE90TmwPv0BbeX4qOoxq2CKr5u86DKq148BglbWsgt05rYRscvAxhEXjh6rH0y
         bO5E0b+4dymZI39rRiA2H59r5y9Np2bFg6CGGtO8WMYMNE3CEPTBTPLMQfG6Y5sYTe2Y
         dXqg==
X-Gm-Message-State: AOAM530y566B9tZqCkAXkci4HHnyM9A8qQCipEAg8UiyRg1TeQMgInU9
        DDZksrnPLU9HAU7uQSSwvPoEq+Nrjin8gUAggA8AYA==
X-Google-Smtp-Source: ABdhPJzm2wmW4hzJMY+HlbRfgKireJ6Hc7hXhe9CDv5rw+U+Gfo7j54X3WlieNqeuzZjwDNf3PcHkcRW0y/1K4Hxa+w=
X-Received: by 2002:a63:d0d:: with SMTP id c13mr1253894pgl.384.1623787822057;
 Tue, 15 Jun 2021 13:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210513193204.816681-1-davidgow@google.com> <20210513193204.816681-3-davidgow@google.com>
In-Reply-To: <20210513193204.816681-3-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 15 Jun 2021 13:10:11 -0700
Message-ID: <CAFd5g45NobSVOFAN8PJrWKDgqjJDJh15x5WByf+0FV+yFa2zEA@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] Documentation: kunit: Clean up some string casts
 in examples
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 13, 2021 at 12:36 PM David Gow <davidgow@google.com> wrote:
>
> As the type checking is no longer excessively strict, get rid of the
> unsightly (char*) casts -- and comment discussing them -- from the KUnit
> usage page.
>
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Brendan Higgins <brendanhiggins@google.com>
