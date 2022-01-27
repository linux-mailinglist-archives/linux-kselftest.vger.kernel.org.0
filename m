Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABE849E98B
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jan 2022 18:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbiA0R7J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jan 2022 12:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239238AbiA0R6k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jan 2022 12:58:40 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F46C061747
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jan 2022 09:58:40 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id l5so4736993edv.3
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jan 2022 09:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D/WdrZt8APh+ImWs99heS/EAAslbj9KjZjoo2pBS7+c=;
        b=nFqidDLirWb5QmaEXBGreq9mA37G4EJ+Q2mpt9YciaCWN6z4xxhNtfYmkrxNHnaKLw
         OfEPBT0Xe0aXMGF9gnFX5fjFu/J4kr/Lf/pS+GlUlyM3xqTmw7ZYGmZT317MbXPPRQY+
         qPKCe9aXzTB3+Vqr98iv5i84h3v7XET37JW7wJtXNBgn47IcCqZpy9I6mrkDnLcWEuS2
         YT243GZrkCIBNdDUPyBjinEjmofSalSBeg6IIOZT43hnaxwNWKfUXfTgopMgEpG/DUiQ
         LnKVOY8QCobVPQN3ZJB5ATSLAYaMWJje/ltYhTTDai/TNx6UimZ1mw7fYow0lC8poKzv
         OTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D/WdrZt8APh+ImWs99heS/EAAslbj9KjZjoo2pBS7+c=;
        b=ve4J/kxI4FUL/eQSx7PUO1YzashLBdW9vocAqFjURQQI8TvphXeCQBJvi+SKM1xEsj
         ayz0hweBErg8ASifp/Nubxu4Sd+auakKqZC2ch3wB5erIvQ7OGU6l9FToXwPxiyLzXaC
         sxnkYRlRUiY9oXVL1yI5vSfQUbLXOSrI5zVWUkCj4TgUKS+jIjeEQMIKXQruTmq2ru5D
         BiBx+TSpu2DFtEkrou2EKsefge5w45wlrFDaLlEG1+3Jf0R05OWwnyST/1fl5hXcSqRL
         B4pjcfMxjxEt/DBP9YiMbLAtwHOtSkTqGJZFdlpbZczisqI6nsyfd+VMqkmHDXy3SfOe
         Ydxg==
X-Gm-Message-State: AOAM533PsxH41N7QFjQ+aLFSem0bYQzPMOj2wB3Cg5kkVWGXWfjtJUks
        dESTHawW3Z1RK7/OpcdPGY5NQtn7p+GuSs5RpkeaKA==
X-Google-Smtp-Source: ABdhPJxQ1qzfs/DIElroXwnoIK8WHBiVv9xpOvqnXnZkbObAnsCfkpP9Ea4KnHjLw+73Nz8PNhZRrABfYFFZ4R9A2Q4=
X-Received: by 2002:aa7:c312:: with SMTP id l18mr4729705edq.334.1643306318361;
 Thu, 27 Jan 2022 09:58:38 -0800 (PST)
MIME-Version: 1.0
References: <20220118190922.1557074-1-dlatypov@google.com> <CABVgOSnY8Ctc9vuVX+Fjmmd3L5kpXnzMXJQ0LPXAgmjCKsrYYw@mail.gmail.com>
 <CAGS_qxqx+wcruc7DAD9TQjk27OF+VDo1n9S6atRx+dDG5cr=6g@mail.gmail.com>
 <CAGS_qxpRqOAoBbkkFttZgB_Zm+KM=pwprgZ0wzDROh21mO0r8Q@mail.gmail.com> <CABVgOSnmfhPcMCy5yQEymyBnTWSqEFbmTnSbHYL7D1D=eJOk5A@mail.gmail.com>
In-Reply-To: <CABVgOSnmfhPcMCy5yQEymyBnTWSqEFbmTnSbHYL7D1D=eJOk5A@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 27 Jan 2022 09:58:27 -0800
Message-ID: <CAGS_qxrCRxEGUj_O+oZFkrDgE6PgvHNhfxMzF94Rez__CXbR4Q@mail.gmail.com>
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

On Wed, Jan 26, 2022 at 6:20 PM David Gow <davidgow@google.com> wrote:
>
> On Thu, Jan 27, 2022 at 3:55 AM 'Daniel Latypov' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> >
> > On Thu, Jan 20, 2022 at 9:19 AM Daniel Latypov <dlatypov@google.com> wrote:
> > > > That being said, I can live with the current solution, but'd ideally
> > > > like a comment or something to make the return value Tuple a bit more
> > > > obvious.
> > >
> > > A comment to explain that Tuple == multiple return values from a func?
> > > Or something else?
> >
> > Friendly ping.
> > Do we want a comment like this?
> >
> > # Note: Python uses tuples internally for multiple return values
> > def foo() -> Tuple[int, int]
> >    return 0, 1
> >
>
> Whoops -- forgot to send my response to this.
>
> I was less worried about explaining the concept of multiple return
> values, and more about naming what the return values were: that the
> first one is the result information, and the second is the parsed
> test.
>
> That being said, it's reasonably obvious from the types in this case,
> so I'm okay leaving this as-is, though in general I'm wary of tuples
> when the order doesn't matter, and a struct-style thing (with named
> members) fits that better.

Ack.
Yeah, in this case I don't think creating a new type to name each
value is worth it.
From what I've seen of python codebases, this info is usually captured
in docstrings, but yeah, this particular case seems straightforward
enough that it doesn't need it.

>
> I'm no Python expert though, so don't let my whinging get too much in the way.
>
> -- David
