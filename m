Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90421F0178
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jun 2020 23:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgFEVUs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Jun 2020 17:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbgFEVUr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Jun 2020 17:20:47 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CC2C08C5C3
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Jun 2020 14:20:47 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n2so4177985pld.13
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Jun 2020 14:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nHQW5BYXXwiXrCyLQHmDQmz1BrijG2qlo7eTGZ7BGTo=;
        b=l3wUV67SS8YzgG+J497FQhzIUlIstI8rWeqr96YqvC8EpoaFAHOoxFPBzJYizvw7av
         f0+7++GMnbuFj1b3iY/KSvMC4AuMstDWfRPIvwqEpuPL8l/LacTOCl88TcWVxmzayieP
         AlSQfaSMs8hdbfOEqqWIYS25AHvoxDxbIOgFN9oQkntkmUtuYol2rbAUcSoc65IJag8+
         ozAAsfAY2ydITmm15ZQ5HwBC8Lh63os6BRSsj7vMQmZlx6fMy1H6kJrx4e1QQSjKJZHZ
         Bxz31wHWAyme744qB5O2FwSXBfM0hJUopynJYIZe9osoD7en2pl30eSmfd6UxfSs/6Vl
         uhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nHQW5BYXXwiXrCyLQHmDQmz1BrijG2qlo7eTGZ7BGTo=;
        b=graMLFo4rdWCItIYvOH9KgCwhvleAyWL9I7S62ZPVEq2h5BX5yCRfV2RNNuHwNVc04
         r4F4g8P7OjVAgCQUpWXDDLPTA8Rv5ruMqtgzm6gkQOcWEymXtlRCvd8GQ4ebUUzCxUa9
         AMk0Dco9JnZjCY9dDvCqTm6Ax3BuOEptNhrfhi02NqHXWoVNLiNjaNRYbUrVPTTSxOPp
         1ltZvfn9RfeAhwkk/8VSsZRXBG43nAMsRFcp9dolkbo/uvg8dpnl/bL+sxkhmh//AehC
         SOsjUjvzsp4/TCdJGV22DIezhBqrnA3WzPOUXIyyVeTIes3+fHWwDuteFuXii3KWD3kj
         KQ5Q==
X-Gm-Message-State: AOAM532c0tOZgbQrCKOJblD7qtIMGkXAoDRDh4GiYYFjEv6d11fap4SY
        iMLtxEAbq93UBOzWBKpKs03ZduqZxtZfDam/5cUK0dhk
X-Google-Smtp-Source: ABdhPJxn2AdJDXSYLUY6qD3G2Tb2nEEMAWnsUakhn4HQ0naRzZal3cGyLMpcClBFVWS9fngFHKn1CZ/c9Y3RCIzFFJ4=
X-Received: by 2002:a17:90a:df82:: with SMTP id p2mr5173836pjv.217.1591392046747;
 Fri, 05 Jun 2020 14:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <1590788781-1895-1-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1590788781-1895-1-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 5 Jun 2020 14:20:35 -0700
Message-ID: <CAFd5g46Uu_5TG89uOm0Dj5CMq+11cwjBnsd-k_CVy6bQUeU4Jw@mail.gmail.com>
Subject: Re: [PATCH v4 kunit-next 0/2] kunit: extend kunit resources API
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     David Gow <davidgow@google.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 29, 2020 at 2:46 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> A recent RFC patch set [1] suggests some additional functionality
> may be needed around kunit resources.  It seems to require
>
> 1. support for resources without allocation
> 2. support for lookup of such resources
> 3. support for access to resources across multiple kernel threads
>
> The proposed changes here are designed to address these needs.
> The idea is we first generalize the API to support adding
> resources with static data; then from there we support named
> resources.  The latter support is needed because if we are
> in a different thread context and only have the "struct kunit *"
> to work with, we need a way to identify a resource in lookup.
>
> [1] https://lkml.org/lkml/2020/2/26/1286
>
> Changes since v3:
> - removed unused "init" field from "struct kunit_resources" (Brendan)

Shuah, it looks like you haven't sent a PR to Linus yet. Would you
mind picking this up for 5.8?
