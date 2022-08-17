Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540A05969C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Aug 2022 08:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiHQGqT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Aug 2022 02:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiHQGqS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Aug 2022 02:46:18 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9DB5AA19
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Aug 2022 23:46:16 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id u3so17830694lfk.8
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Aug 2022 23:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=nAqyWnNuUpYvt906E68zKBY59gzdyctyb9Q1L2Fs+ck=;
        b=qUYkmfw9D1MbfHRbF8XIoYOMYeVeDuvZ8CgQM2Jk5g2hD1UdiXHGoknIRP2VGxKPnz
         RtgVtU/2RJhZDlIJBNbmORJL4chclOIj6OJ7WL2Z8Psf/Q9apuTcZPqCIogSc7GM9KYm
         v7LNGSg4K7zh8iz5Ipx2SCG8d7rvqDVZ2uYuEvR4LtfdL0y3UWfJCdj6WEgpz/4+MFAs
         ORcsyNu6PPVUrATkapJ/JSWjHKQGLA6IKiSMMBhbs1xsGdYP32xwxkxG8sCDY1OZabNL
         HO+2sHmQobKWiUPFhW5E8qfmVV92UgqlzV/b3MwIKYrnBDpSJNI0TPT62/qhlxfO47IX
         0NFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=nAqyWnNuUpYvt906E68zKBY59gzdyctyb9Q1L2Fs+ck=;
        b=QUhYbVuGtWkuZ8ITtsvr+sGQB54rd/2IqFFwrc7vu5x3Da4jSv+0MvplpIDeutaGtP
         xnLqWMH01tX4fnUHAl6m9wDInTJW7G4cWhU3wPVYLN+dN8RjnLwH81VpiLvOKElLyB6j
         x08oP53BQOynau/hj8YNvT6AU6KhfPtS8oaZDxh9yCpyn7eUcC5lKtm0VVqc+W1hXoBq
         YHBlKgyOJeEZ6JtrfEF1WShAK25Sd7Z8yADsnw7RAt9wsKtNRkE+/Lg3eOZSm5ADgvzg
         O8UjGveM8aRbkjttI18frFcAwj1uKZiPUtD4JOpI43sIBXjNwfvhwAY3FUQuYtdZDPoX
         Q2/Q==
X-Gm-Message-State: ACgBeo3vIBXuxd1FnGP4e+gvOQGwV6ZWv7a7J8yr+Ra8ZUlUXXTQ254Q
        notPC6oX4b1ooKUYZt+NAQ4hYDOFVzFjfzp2mx2E5/bbgPo3ng==
X-Google-Smtp-Source: AA6agR6BMY0UyExFx6N03MH0PaHsNCnoE3x2/qTyYfykvF0R2VGr+kIUvK6Ne9/vYBGCQmQVDIxJkYR6VXZEPeFGGy8=
X-Received: by 2002:ac2:5383:0:b0:48d:aa47:5c29 with SMTP id
 g3-20020ac25383000000b0048daa475c29mr7600984lfh.188.1660718775116; Tue, 16
 Aug 2022 23:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220813042055.136832-1-tales.aparecida@gmail.com> <20220813042055.136832-3-tales.aparecida@gmail.com>
In-Reply-To: <20220813042055.136832-3-tales.aparecida@gmail.com>
From:   Sadiya Kazi <sadiyakazi@google.com>
Date:   Wed, 17 Aug 2022 12:16:03 +0530
Message-ID: <CAO2JNKVu6rhWdLsbqaUBruEFWpSkaOc=h1QMFHUdr7zSGm=Bmw@mail.gmail.com>
Subject: Re: [PATCH 2/4] Documentation: Kunit: Fix inconsistent titles
To:     Tales Aparecida <tales.aparecida@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>, corbet@lwn.net,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net, mairacanal@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 13, 2022 at 9:51 AM Tales Aparecida
<tales.aparecida@gmail.com> wrote:
>
> Use the same wording when citing and describing Kunit parts.
>
> Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
> ---


This looks fine.
Reviewed-by: Sadiya Kazi <sadiyakazi@google.com>

Best Regards,
Sadiya

>  Documentation/dev-tools/kunit/architecture.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/architecture.rst b/Documentation/dev-tools/kunit/architecture.rst
> index cf9e6e3eeae4..8efe792bdcb9 100644
> --- a/Documentation/dev-tools/kunit/architecture.rst
> +++ b/Documentation/dev-tools/kunit/architecture.rst
> @@ -6,8 +6,8 @@ KUnit Architecture
>
>  The KUnit architecture can be divided into two parts:
>
> -- Kernel testing library
> -- kunit_tool (Command line test harness)
> +- `In-Kernel Testing Framework`_
> +- `kunit_tool (Command Line Test Harness)`_
>
>  In-Kernel Testing Framework
>  ===========================
> --
> 2.37.1
>
