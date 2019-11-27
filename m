Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E875210C0E2
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2019 00:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfK0X6m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Nov 2019 18:58:42 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35174 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfK0X6m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Nov 2019 18:58:42 -0500
Received: by mail-qk1-f193.google.com with SMTP id v23so13376007qkg.2
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Nov 2019 15:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a3WUEtOVqQkZFCkhjjxrIAxoTowOJXCq4QS2LfgvlaI=;
        b=Aah2cc2YM0jiYqAcIE90XoHLZdq3QXri37FqgF0EOP/1wTYW0fOKqBoH6Dg7Tn3vyc
         rWEhzubRlIOLm/FBQQYQzEtLXgDutfIIdqu9qRVDooFgUO/VBXsjovf2B2s5LTpM5lpq
         q27Hd52fANKgRR7OX7YQG+IMEvhfGQYx0bnLdHr+J7v79SHHvw+B7OxARdFOK+UBUcQt
         2+V9ZO3voPpLxGBxvm/ik5CHf2NNL6iOQsz8VVQjZtAXgv0/yiugtYawzJY/VcP0jF6z
         PoHpjGMr7fQO14OANPj/rf5nyjjvnDmD+adXc7+FBKaVp5dyDApcac/pb0hISkTdeKxy
         jKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a3WUEtOVqQkZFCkhjjxrIAxoTowOJXCq4QS2LfgvlaI=;
        b=D6VbCo01A2kNMj5jbmwz2lgJuMwAT+GoTbY2E8X8jFjnAXkQf2ASe9oTew4X1V5uBQ
         oLs5vLzmBxKxVILio/JGsKJ0djVMfhLEX698keYynfdnYl65y8ghvvf8I2BPY5D/jQZ7
         /WPcSvFOUgqv4II+VV0i/xS1ohVKibQ9Cr4Iua2eovzNNDX2F5Gx151H5iUcj6P1PnMZ
         cIcPUiRfV2hCkt+ylXmxEQJi3dOJmDh/XYp3NrMmni3gEAZB5Nvoq7y/VDzxu2oNHULW
         op+iJLsyxm2PCf1AWTD9cQpo/c8F0bvD0o7pUnyrOmxkVjXza+e8eLEzfLd2sgqKwYZV
         qOLQ==
X-Gm-Message-State: APjAAAW/qo7Nqxs7EerK7iT1fEQ43LnM6NUf64g19N2gnpZQdeOTKqYo
        kpwj4/IHrNH95cngRGoIdhDzSY4v4w5xUcQySQ0L7w==
X-Google-Smtp-Source: APXvYqxZ3fYPwmk4+mWdgkml/CxCD/cZA+hVrli74YtbeQMx676MyN3FZbkequj/3CcA5kCvGYoQMiNZX/pdiSyNC2w=
X-Received: by 2002:a37:a08d:: with SMTP id j135mr7499764qke.455.1574899120904;
 Wed, 27 Nov 2019 15:58:40 -0800 (PST)
MIME-Version: 1.0
References: <20191127231926.162437-1-heidifahim@google.com>
In-Reply-To: <20191127231926.162437-1-heidifahim@google.com>
From:   Heidi Fahim <heidifahim@google.com>
Date:   Wed, 27 Nov 2019 15:58:29 -0800
Message-ID: <CAMVcs3vKjd8XVku8VUq2R-OKKSq-X2L=h4niFxuoPBe_D63JAA@mail.gmail.com>
Subject: Re: [PATCH] kunit: testing kunit: Bug fix in test_run_timeout function
To:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, shuah@kernel.org
Cc:     sj38.park@gmail.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 27, 2019 at 3:19 PM Heidi Fahim <heidifahim@google.com> wrote:
>
> Assert in test_run_timeout was not updated with the build_dir argument
> and caused the following error:
> AssertionError: Expected call: run_kernel(timeout=3453)
> Actual call: run_kernel(build_dir=None, timeout=3453)
>
> Needed to update kunit_tool_test to reflect this fix
> https://lkml.org/lkml/2019/9/6/3

Wrong url, here is the correct link to the fix that caused this bug:
https://lkml.org/lkml/2019/9/6/351
