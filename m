Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E0E49D2E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 20:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiAZTzy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 14:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244579AbiAZTzx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 14:55:53 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0ADEC06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 11:55:52 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id w14so649279edd.10
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 11:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VDOhpqDLAkmVNH0vSKJoGMou1SGqznw9FL9tts+vhro=;
        b=pk7kVJBIVlARurWljVTuYqW6e9/jhw0DpwpRvNzFAwwMjW7CJN9QYc5+ablTU8ExNw
         YnjgmMVS+c4tUnC+cGYGxu89gK/xkRz5f1irk8HUJdyF8JvPcdIplIbxX54exyKv+9hO
         IiAfL4Exm3Jy34fbBrKIK1fPhixkzPZFmCU9HPxs191eGw1V4AkEvxE+WJcz29D2nD11
         uoI9j3OkdZh/ptyRswPcP435zDLxYSrTxnrRVia4OgvMYuarlTNCxa6Rc6OHRSDfPtIS
         ab4nyCOgMr9QtUfptZuL6ZvK61bW6UtJcV1hSxWDHsMzgQAq2mMyRpoxO1aY8Ujb4rsv
         cqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VDOhpqDLAkmVNH0vSKJoGMou1SGqznw9FL9tts+vhro=;
        b=Gt+IjzqVbSsuTEa+FgMNRfmEq2zPqRGx5gMwdq6zr1SA3v6yKAEjxDeEcmdAkZz31i
         rSd/OEY3R6dIUaYda4Tshi+IEMy+2d2hMrEZd4PP5SzAkZbu6ZeTOQF7ZRcXQLDWuOFl
         1F2jmTqyA3aiHV+zV27J8/mlFmuNNZzAhjt5f4nmHEmQjQD9HZp/kBYdmS3QeOCS5uAg
         3i2rzdQdLYdWGJev3kdBJ65UHIjxubR3Mar8ZbmAAFVOIH68zMBWgIhzulxtukUzOfBP
         OjdEoevTe3OqEXsN1WYW7Mcu5ofSfAHhUwjeTY/86BK1FKpfpeWsqOZZGOXh8DDAX0O5
         IuiA==
X-Gm-Message-State: AOAM5312x+YfD7gUNfc0NScNBjlsKiMP6vqpwcPhaMleuZjOZWmhIWRm
        MEwocBy7R3KYp7kN5aPm/6CmG2v6bvvfAW4OHIL+Cw==
X-Google-Smtp-Source: ABdhPJx4K0Neb27vIAtnMj1Uwp4kN8pHfXJ2st4oEx9Np1EhPwv8cyi4bSuNBisch9FfiGH1BktGNVqU9yuOH6bHmEM=
X-Received: by 2002:a50:eb46:: with SMTP id z6mr520229edp.229.1643226951036;
 Wed, 26 Jan 2022 11:55:51 -0800 (PST)
MIME-Version: 1.0
References: <20220118190922.1557074-1-dlatypov@google.com> <CABVgOSnY8Ctc9vuVX+Fjmmd3L5kpXnzMXJQ0LPXAgmjCKsrYYw@mail.gmail.com>
 <CAGS_qxqx+wcruc7DAD9TQjk27OF+VDo1n9S6atRx+dDG5cr=6g@mail.gmail.com>
In-Reply-To: <CAGS_qxqx+wcruc7DAD9TQjk27OF+VDo1n9S6atRx+dDG5cr=6g@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 26 Jan 2022 11:55:39 -0800
Message-ID: <CAGS_qxpRqOAoBbkkFttZgB_Zm+KM=pwprgZ0wzDROh21mO0r8Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] kunit: tool: drop mostly unused KunitResult.result field
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 20, 2022 at 9:19 AM Daniel Latypov <dlatypov@google.com> wrote:
> > That being said, I can live with the current solution, but'd ideally
> > like a comment or something to make the return value Tuple a bit more
> > obvious.
>
> A comment to explain that Tuple == multiple return values from a func?
> Or something else?

Friendly ping.
Do we want a comment like this?

# Note: Python uses tuples internally for multiple return values
def foo() -> Tuple[int, int]
   return 0, 1

I can go ahead and add that and send a v2 out.

FYI,  if you do this in a REPL
>>> a = foo()
>>> type(a)
<class 'tuple'>

The syntax for `a, b = foo()` is just using Python's unpacking feature, i.e.
b, c = (1, 2)

So it's all just syntactic sugar around tuples.

>
> Also ah, I thought we had more instances of multiple return in kunit.py.
> Looks like the only other is get_source_tree_ops_from_qemu_config().
> isolate_ktap_output() technically shows this off as well, but via yields.
>
> >
> > Thoughts?
> >
> >
> > -- David
