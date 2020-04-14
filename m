Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A701A8EAF
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Apr 2020 00:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392028AbgDNWhn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Apr 2020 18:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387731AbgDNWhl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Apr 2020 18:37:41 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D93DC061A0C
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Apr 2020 15:37:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mn19so5853418pjb.0
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Apr 2020 15:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MnNBxphtYP6iBNHIxL+rPEouSOEM8pco9Al+VZqAUT8=;
        b=aKmrDk7utMsn9UWpKM1WYGpP6RkFEzqsv0Z0tev+b1oeb24rC8M1qxlQBlJ5YQ+7Zj
         YwjEtlBtL/gib3wV4i6fEvM+UCOA7kdMLSyYkHYigx4CoI7LGtEvC+IMTa5vWu5jIWPV
         8y3/Vw9YWjfJbdYjq/iZgZwJ+60VXzFEXj0My7qujdvMJB7v3mWHH+MScMvhvQWoJlod
         2MHtsqi3oSXpXNbED32tFgj9viVUEMMA0bI1LlXfQHF2HT+67GQ0D8lqeFJr0AJVUsCe
         KSgBs9v+DijqwIiLSaUNU8zX99KyTSqKtV7Lk05NxjlT0TgLiwI+faKwbtN4i6arE0no
         m7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MnNBxphtYP6iBNHIxL+rPEouSOEM8pco9Al+VZqAUT8=;
        b=bjFwEk1uHr7q5ttq5dPCUt9/yiZRy+xu2om2pbhz6PZRoiVaCaoXWgRub1pfnPqyc7
         cxGcMkRAX0A2EtfzHd1bS24Z/2W2j6UBaNWqmMDjCooTxyDV9AMQ7eE682U+nO9HjAkU
         RadXNkqdcFub6qIA44cgCCRoeAYPxFpdJzkhbyVA7uhAdV6zHuVrtKM2dEuEl+7Y/nX3
         gLbAFymnj5NXvnRYvmewWlR/GT0zf5yph+ZOl6CjSpaw3vvILQuxgcacHLCvlX0iqe/I
         /gKAnfJABAqGXJ+M7NreBRAUtrm60LfSwRFqoJwdPfj6zVrzHf0Qv8PMPN7Ot1aTqkIZ
         Jthw==
X-Gm-Message-State: AGi0Pub0DMCqdG3wM9dTtyojzwxx/b/84ZBFqWrZ5MznIRiISNa0dzQi
        xgvmZ1HqOPOIuKsHG/MVob9MYD9i+p6UGII7uO0wpQ==
X-Google-Smtp-Source: APiQypL6t00r1T4RqowCCFo4zF1S41i/BqScysKZVQx9z1tbhXKwupqyn3K4YvwIIXCQNEUUYuUNGHlPNyP+5fV5LHQ=
X-Received: by 2002:a17:902:cb97:: with SMTP id d23mr2126174ply.232.1586903859305;
 Tue, 14 Apr 2020 15:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200414221250.18726-1-l.rubusch@gmail.com>
In-Reply-To: <20200414221250.18726-1-l.rubusch@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 14 Apr 2020 15:37:28 -0700
Message-ID: <CAFd5g46tLzR0BEEaL=PEXuPRzzDY=b0y+0q9d4e7YfdxqgpFQA@mail.gmail.com>
Subject: Re: [PATCH v4] Documentation: test.h - fix warnings
To:     Lothar Rubusch <l.rubusch@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 14, 2020 at 3:13 PM Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> Fix warnings at 'make htmldocs', and formatting issues in the resulting
> documentation.
>
> - test.h: Fix annotation in kernel-doc parameter description.
>
> - Documentation/*.rst: Fixing formatting issues, and a duplicate label
>   issue due to usage of sphinx.ext.autosectionlabel and identical labels
>   within one document (sphinx warning)
>
> NB: checkpatch.pl will complain about flow control statements (i.e. usage
>     of "return") within the macro kunit_test_suites(suites_list...).
>
> v2: Several documentation fixes
>
> v3: Do not touch API documentation index
>
> v4: Replace macro argument in test.h by named variadic argument

nit: Sorry for not pointing this out before, but comments like this
(previous revisions, notes to reviewers but not future readers, etc)
should go below between the '---' and the list of changed files. I
called the comment area out below for your benefit.

> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

One minor nit, other than that:

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

> ---

<Comments go here>

>  Documentation/dev-tools/kunit/start.rst | 13 ++++++++-----
>  Documentation/dev-tools/kunit/usage.rst |  4 ++--
>  include/kunit/test.h                    | 12 ++++++------
>  3 files changed, 16 insertions(+), 13 deletions(-)
