Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24298228CE3
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jul 2020 01:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgGUXxE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jul 2020 19:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgGUXxD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jul 2020 19:53:03 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321C2C061794
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jul 2020 16:53:03 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d7so57629plq.13
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jul 2020 16:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9GAANOVEkg7Oss4DpDH0gr9ifNPUbhRTyDcGnsT2WTE=;
        b=p1xsv+JsYJXhYalj5ZZCc9wnW1uf56mVn0Gc1i+QWyJBhVm2oAo15ONIoGH5a++qc3
         nS8vtFYiWBbBZN/ZbGkIgOWNPX3q2HAp+ZRYAz0yz6yBgjgbaVNRv9jJYBy2nfqY++4s
         49RCXlqcN1Khtcr2FHPAlM6wIONJZ/uQkd34FX01Bue6DVy0I1d2B1vmNGTCO94yzDW+
         Fsd6zuBB7YB7X0nSbZNQjQSwkxI+h8rk5XJzp/8bgnBgal//1dKnFv7A0QGSbptnJ7tf
         1JcrpYnLejhIZ2RRFRpcz+Ki1fmJRs7nlyLeVDnnreujKpiOcnohfnZRviTLvcVEKJgB
         pezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9GAANOVEkg7Oss4DpDH0gr9ifNPUbhRTyDcGnsT2WTE=;
        b=U17CNPY2z5NM2ux40dVlF7kYDLa7vVstL9vE1NEM1LUGvFVR/wJuSl/0bkp7FR6z+F
         Qw8Y3oAJ72kRh5CiqjpZcGdCs9gn+lTMIPloYLluZUHow3ZkVUjvTaDRRGilnHCKd+i8
         /3MjAPah0oeDBRNufTzk5UCrE3Cfq7iLCuVXiuTAX6AxY+E7J46xLWTdqAsjDTj/Lga8
         ++8bxW9GlBi9tzfF88AYrSghxGQWESMvLTqtNDbxepTthfoxL1nNiW0GnZGMR9KVIQ3L
         fk9AFnBQM7sA0SSHDfVeX2Z7JLfjKFiJKKhoH1vdEFgRaryBZbCr1ebrzsL1TErKeLMW
         pRlQ==
X-Gm-Message-State: AOAM530K2zMLYLWg5rnLQt0Dljnl3LTvYM5hd6jTKy7RJEPcYh2/7agK
        x/wKfBIVryLdw3GVh7dZUkOiRAvQyJmP9os9rLXYNg==
X-Google-Smtp-Source: ABdhPJwlgYLxoZWZx8+svKNEBY0q6bxsav7DHLE6pxfIoOZcXdRkc72QEfSINPDlzRr5arUe6DKa0UAUjzPNjGbgJMA=
X-Received: by 2002:a17:902:10e:: with SMTP id 14mr23017886plb.297.1595375582338;
 Tue, 21 Jul 2020 16:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200721174036.71072-1-vitor@massaru.org>
In-Reply-To: <20200721174036.71072-1-vitor@massaru.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 21 Jul 2020 16:52:51 -0700
Message-ID: <CAFd5g45DrBCA2Oq0RCb5FDWybt9NnXj=tN7pZFqjMLhuWWQoew@mail.gmail.com>
Subject: Re: [PATCH v3] lib: kunit: Provides a userspace memory context when
 tests are compiled as module
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 21, 2020 at 10:40 AM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> KUnit test cases run on kthreads, and kthreads don't have an
> adddress space (current->mm is NULL), but processes have mm.
>
> The purpose of this patch is to allow to borrow mm to KUnit kthread
> after userspace is brought up, because we know that there are processes
> running, at least the process that loaded the module to borrow mm.
>
> This allows, for example, tests such as user_copy_kunit, which uses
> vm_mmap, which needs current->mm.
>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>

Isn't this a dependency for the test_user_copy? Also, don't we also
need the change that makes kunit_tool build modules? It seems like you
should put these together in a patchset like you did before. If not,
you should at least reference the dependencies in each patch.
