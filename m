Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA61182535
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Mar 2020 23:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbgCKWx0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Mar 2020 18:53:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41344 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729739AbgCKWxY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Mar 2020 18:53:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id t14so1797178plr.8
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Mar 2020 15:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nl0EJrzWK+YJkV8HhMmcT9tiOsgoC3rUQBwiJfZfbmI=;
        b=mdQ1WL15H3HpBJQ9ftHgqBMXwEFISYk/sfK7fTi55FQDh0twBW0uzYAS0nZYOlg8qr
         T8RTLWDqnQRX7az06J/CUvqrN72icBlh7vISkIA6yvh7gbaCNrJNFJ85uTk/nBRXRuJh
         ULJtP4OSouiHhUgQHSOw6Un5Z9ZYk16lYG/qKyfhAWV0w5hS5BZKJBB9l8Oh6oKlJrFR
         aaUW/b+2TyZzHxXjScPQMAUcO6Msn1ujiKadmARBeakdC4Kb1OYEkkkM4AVM0VmsuwrW
         D+oluHn4qBKYjXvYCXjvTIfujJ+5146lCDk1HoDYNOxBFkJv4U2UNHEPTXzgVE0jjpRy
         +swA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nl0EJrzWK+YJkV8HhMmcT9tiOsgoC3rUQBwiJfZfbmI=;
        b=As1e2lkWKQn6cBXQi3O8qyXfx84HT6/HfUSOtD+MWGjqPyQEEL2S/NLpN33KuR5cJA
         PMVnooTN2QDvUD1DpZLXrAV7cw0DWlsUqXwYntJ+N+L4GnSCwY7pjZQa6XbWUglTm5a9
         WOGYW/sPQqU+Bcyc1sqx/hysnL1bPUr7CkaLixZJdeY3c1NqAUILDFSHgNeYZklkZQvU
         PDVfQLwvx+GCR7PYVNdIxcIGvvozrp8SbF1YHywEhhQObtD6yufaFLp4u5QavFWR5zOb
         o8lNwymyNrOimc8/kzv+pdRe11jA8V8qF4fEe4qE3eClhdgWzmM7f3wEnYepI3o9JZtV
         lM2A==
X-Gm-Message-State: ANhLgQ2mYR8KOvLuy0ctGaeYnTCNbsw+GuLfGAXyW6rW9WNi3AVEjlUR
        qyRPRE5tlc9Y/Nq0bp97UQT1SqkcZEb9hUNja96vLw==
X-Google-Smtp-Source: ADFU+vvagulKuellazVhh3XheT3knudCK7WIBbsqd7EZUzfcfz1tEE8u7grMDhDQ+9mv3x9w1tIN7Tt6p+akUMEdLoA=
X-Received: by 2002:a17:902:74cc:: with SMTP id f12mr5209789plt.232.1583967200859;
 Wed, 11 Mar 2020 15:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <1583320036-442-1-git-send-email-alan.maguire@oracle.com> <1583320036-442-4-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1583320036-442-4-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 11 Mar 2020 15:53:09 -0700
Message-ID: <CAFd5g45nFs2zoD2gCq6oQ-orDxe3VbK1FqCpoM9BL6-eHxsJaw@mail.gmail.com>
Subject: Re: [PATCH v6 kunit-next 3/4] kunit: subtests should be indented 4
 spaces according to TAP
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, shuah <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 4, 2020 at 3:07 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> Introduce KUNIT_INDENT macro which corresponds to 4-space indentation,
> and use it to modify indentation from tab to 4 spaces.
>
> Suggested-by: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Sorry for the late comment.

This change looks good except for one thing: kunit_tool
(tools/testing/kunit/kunit.py) expects the wrong indentation. Can you
fix it? I think it would be best to fix it in this change so that
there is point at which it is broken.

Currently, this change breaks it. For example, with
CONFIG_KUNIT_TEST=y and CONFIG_KUNIT_EXAMPLE_TEST=y. kunit_tool
reports the following:

Testing complete. 0 tests run. 0 failed. 0 crashed.

I am pretty sure the change needs to happen in
tools/testing/kunit/kunit_parser.py.

Cheers
