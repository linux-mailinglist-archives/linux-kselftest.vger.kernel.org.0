Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CBE3AA564
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jun 2021 22:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbhFPUjF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Jun 2021 16:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbhFPUjF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Jun 2021 16:39:05 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A13C06175F
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Jun 2021 13:36:58 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id k15so3160840pfp.6
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Jun 2021 13:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/iyaCYOVFTgGt+uLyKcOuwMWraHntMrfp9c4Wvuygsw=;
        b=ozk9b/x9ThmBWrjEaelNW21eP5a7iRJdlV2CCTgf37kQf96+3dtQlK8fT5gDAJUGD6
         DoqqU7iPY42js1IrnSrZAs51SNZuE4YSBqwhCxLJqI0SUQbSmx0EocnWZal25Y2uLaeX
         y8FlJ2epoAYw8VrTJ6c+mPu0L0TXgM6AbaiAlF3dUaO+oLja5SbAZ860YmGZ08ORSYW8
         /Yxsv4BONI8sHpeOSt+G/UHUfbJA2nGZYzZFtoxiGnj2N/jSJkYdrVPKaXKK6zPKlzFK
         nIKVKwGUESHVozEVHgVuoh0FX58K/8UmjfspgpbSLXKOzp3ETt7SlylUjuG+xWOLzVZR
         YmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/iyaCYOVFTgGt+uLyKcOuwMWraHntMrfp9c4Wvuygsw=;
        b=d7N/uHedoMoTFmImh5xq2JWsZtGPOOeJRG0urxmshb00Q4rwavQa9/SCn42TDqGwiK
         UOzaEOTvkYZEPuJ7VYiibqGRoC/EgooIItgi1qn+Zfg/zi/PPfGPQptfiKvPRst+rZ3n
         mV5Wmc9eGNedEzUL6e8NLH27RkJFmSMoADyxCsQjyP9BK4gLRd26b6KEmrpfTxy5vOT3
         3Dux04iXvpkcRoMsuW77GLXQChYOiXne3fNs+MLIyqYqtTlqDs0TRWAQl5LZfzUgdF3x
         Gr646eJmoAJb3XmHFUZMWydEu7aDYSIVj7fqp5pYM6g1RmJfIawES+wqeNjiBOuXckWb
         VWKg==
X-Gm-Message-State: AOAM531Su3U7LKs2S7jwGzxvoC0ih6u/zgzfwPJz0oLqC1iYi5djV+qq
        CPdA5QGyvtGhEZ8Ml1K99QFLoYNbqTxjEhbBBNrfIQ==
X-Google-Smtp-Source: ABdhPJxjnJLJ8Cv1ZHYaqWXR3wF9ISnILfK3oF+Xc3ZEJKCH7abCZfLs1EX3lq0+oyQVuxYpRaebxpvKs51I4p7cy18=
X-Received: by 2002:a63:485a:: with SMTP id x26mr1427134pgk.159.1623875817786;
 Wed, 16 Jun 2021 13:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210522044241.2763088-1-davidgow@google.com> <20210522044241.2763088-2-davidgow@google.com>
In-Reply-To: <20210522044241.2763088-2-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 16 Jun 2021 13:36:46 -0700
Message-ID: <CAFd5g44-zP7VWwBMxSMv=PNPQWNHB-y90kQ4E8WVqs2mWCE2dQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kunit: Move default config from arch/um -> tools/testing/kunit
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Jonathan Corbet <corbet@lwn.net>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 21, 2021 at 9:43 PM David Gow <davidgow@google.com> wrote:
>
> The default .kunitconfig file is currently kept in
> arch/um/configs/kunit_defconfig, but -- with the impending QEMU patch
> -- will no-longer be exclusively used for UML-based kernels.
>
> Move it alongside the other KUnit configs in
> tools/testing/kunit/configs, and give it a name which matches the
> existing all_tests.config and broken_on_uml.config files.
>
> Also update the Getting Started documentation to point to the new file.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
