Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6983746C4A4
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 21:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbhLGUe1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 15:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236768AbhLGUe1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 15:34:27 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20FDC061574
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Dec 2021 12:30:56 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id u17so26263plg.9
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Dec 2021 12:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eUhZux/FhVxa8bQfBUMV5Yqp0tlRmZe6bq46DDByX6Y=;
        b=HWaJpMeQ8fwdlYyVjljiSY7EL7Q/2EHZkGf7u4Tt4PNXNARkWPux2aaZtvQnneTLnB
         zVVpa3q9IxHWSrD9mv8iUrPi0KxehKAPj6xZ4ibnWlk+C543E62ahymTGA/JhKEOCnPb
         b1rErkQCjGfnYOQkmulqMy9OtdRrKwsCPIybEQhyNQPPyVE/Do6u8+NiCjeVjVj21Gvh
         5YsvkzwFFoyQo2LskY4JoGgpVGqu/LHv29lPktolnf90/DQwZ6AhiomstACZNvzVj6LT
         WXUu7r2WbJPJ205lX//xGTttt2Mq92N1QJ0K+mZV9MLVcGzF7Xxq+qIoJEt+CgfcBdfB
         inJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eUhZux/FhVxa8bQfBUMV5Yqp0tlRmZe6bq46DDByX6Y=;
        b=W8eg/C4MJFlRGn9pToaaf6owEWTZe0hW9kQCRXQD/7MCPv9I3irZWjjPdE776L3ABR
         4+fqrr6Gt9csfi1Ty6aT8gRqkdKxEeZOTCOdnUmB6f/urUC10tchVf7yrN7mBa5BiXiK
         VfEkgRYgXVZHACSZ3ESTNpZ80GLU0H/d50XhEOEtyC0jMt2uHs5xn9oOqJ/nB0W5cKqJ
         BuROJGpRpTJYSX/1jTcBx9WXyKxtyiXE6mVcJv7Qc2kZixx6epLegHloKy14oBbHjks/
         B+gz6yYxcrmexxTeF9xfQhIkAiE7MRPAf6LWMmvwUiKaj5IxMyXTh3OBDL7YvoKJBIyC
         BeIA==
X-Gm-Message-State: AOAM531sV4xDQUcJUHO3TyOVja+VOVuPL8gUjjYWg0M3IAdKXEqFGe0e
        aqg57poT1B4YaCKU/uVi0VlwBnH/l/ceSHGLCckITEY+QhyU0w==
X-Google-Smtp-Source: ABdhPJxDsXL/IyGR3EP70fC5IjEJxqrZa3NoCs9axTjD7fPZPBwFW+LFy7/7SNQVYNX4Cqnstim8lWlynoQ+qZGyN1Y=
X-Received: by 2002:a17:90a:e016:: with SMTP id u22mr1606292pjy.95.1638909056148;
 Tue, 07 Dec 2021 12:30:56 -0800 (PST)
MIME-Version: 1.0
References: <20211102073014.2901870-1-davidgow@google.com> <20211102073014.2901870-4-davidgow@google.com>
In-Reply-To: <20211102073014.2901870-4-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 7 Dec 2021 15:30:45 -0500
Message-ID: <CAFd5g445hxT4koknsF_D68LsgytzoQo8_aAG6JPGcrcizOeiFg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] kunit: Report test parameter results as (K)TAP subtests
To:     David Gow <davidgow@google.com>
Cc:     Rae Moar <rmr167@gmail.com>, Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 2, 2021 at 3:30 AM David Gow <davidgow@google.com> wrote:
>
> Currently, the results for individial parameters in a parameterised test
> are simply output as (K)TAP diagnostic lines.
>
> As kunit_tool now supports nested subtests, report each parameter as its
> own subtest.
>
> For example, here's what the output now looks like:
>         # Subtest: inode_test_xtimestamp_decoding
>         ok 1 - 1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits
>         ok 2 - 1969-12-31 Upper bound of 32bit < 0 timestamp, no extra bits
>         ok 3 - 1970-01-01 Lower bound of 32bit >=0 timestamp, no extra bits
>         ok 4 - 2038-01-19 Upper bound of 32bit >=0 timestamp, no extra bits
>         ok 5 - 2038-01-19 Lower bound of 32bit <0 timestamp, lo extra sec bit on
>         ok 6 - 2106-02-07 Upper bound of 32bit <0 timestamp, lo extra sec bit on
>         ok 7 - 2106-02-07 Lower bound of 32bit >=0 timestamp, lo extra sec bit on
>         ok 8 - 2174-02-25 Upper bound of 32bit >=0 timestamp, lo extra sec bit on
>         ok 9 - 2174-02-25 Lower bound of 32bit <0 timestamp, hi extra sec bit on
>         ok 10 - 2242-03-16 Upper bound of 32bit <0 timestamp, hi extra sec bit on
>         ok 11 - 2242-03-16 Lower bound of 32bit >=0 timestamp, hi extra sec bit on
>         ok 12 - 2310-04-04 Upper bound of 32bit >=0 timestamp, hi extra sec bit on
>         ok 13 - 2310-04-04 Upper bound of 32bit>=0 timestamp, hi extra sec bit 1. 1 ns
>         ok 14 - 2378-04-22 Lower bound of 32bit>= timestamp. Extra sec bits 1. Max ns
>         ok 15 - 2378-04-22 Lower bound of 32bit >=0 timestamp. All extra sec bits on
>         ok 16 - 2446-05-10 Upper bound of 32bit >=0 timestamp. All extra sec bits on
>         # inode_test_xtimestamp_decoding: pass:16 fail:0 skip:0 total:16
>         ok 1 - inode_test_xtimestamp_decoding
>
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
