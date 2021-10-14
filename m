Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7327642D03E
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Oct 2021 04:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhJNCSx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Oct 2021 22:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhJNCSw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Oct 2021 22:18:52 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67131C061746
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Oct 2021 19:16:48 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r18so14543458wrg.6
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Oct 2021 19:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XzIMZBii1B9/Pl5CKvtqcbQpf1sbazCTszvhVplMfsk=;
        b=eR5WWivXxsYD4AvfSq8h0MPr3xrg/pIxz6EkLM9R3ZlaygXidTDYqvFMGEKDXcVHdn
         Xd4u82ntGVpsMCHLydhmvxj+AHFjzhujBSICixBy+hrmf/H788RRwQ2bg8eBUsKq1EIg
         7pRJ43TwBQXHWVQRY2vHEOI3RVyEnJ5RBdUbN/Sjn2gi1aANV4hMe/OhbF1w3qyfnENt
         d2g9F+MlQQ9ly1vgYuzgaIq5ch2o8pnvpDWyPIhMHDSrYTJnJjCoV1g6xozasWAhIme6
         wBGaEvjg//bSjh6fBa40dUGytOP9mKpQq7Fe/toPWd27TUJFr6eSGyZe0bhfaCYWMccO
         Na5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XzIMZBii1B9/Pl5CKvtqcbQpf1sbazCTszvhVplMfsk=;
        b=m8zhyNcMk0smaPvgaGt8fVt8q3D87iLmRUPGh9PQD+CsiwnBvTgzVZpO4Cots869xs
         vG7tNIU5Qpk3PeH91HqJkk18M7cU0kl1Ohi6Kg2CmPXgPknxlIOAWqazK0CYgUrO7dUZ
         H6/d2VWIWm53H2kEJG/FBagNyI9tTN+8WkFnNVsaz07eJMIw6NBANDjtuk7tiKRL2BeW
         5N0SNEPWjy7DahxV2CmP1ufgqJ2bo1Usuhctfdp4UJ95k/MK3UCMdDZxNxKhuYPElzg2
         5sb8SSiB8FQQ4aXco9J1qN6lr/QKaSkfgxGg75QCvMY4MHGVg9z0Y+tMme6KVDpaWB+8
         /hnQ==
X-Gm-Message-State: AOAM532tpBe8HxPptTEn81EmEIpfd/oUqRlRdY3RnoZ2fA8IhH6dkdym
        M3XzkQQOXcIUX/pffLwvno5g1TeGQaV6Sp5RXIYdow==
X-Google-Smtp-Source: ABdhPJwkDoLgr5JDDTGybmZEvz3HGXt7aTI7Q0/tPY8g6vAgduFUCsO1I3YM77lKDTcvHoI0BmFNC+NOYRP0ncy4GZI=
X-Received: by 2002:adf:9c11:: with SMTP id f17mr3434551wrc.147.1634177806847;
 Wed, 13 Oct 2021 19:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211013191320.2490913-1-dlatypov@google.com>
In-Reply-To: <20211013191320.2490913-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 14 Oct 2021 10:16:35 +0800
Message-ID: <CABVgOS=bOLt_cRSQBejtKqBnc+aBOYYDv4Df9h-RtXTiHL-Sow@mail.gmail.com>
Subject: Re: [RFC PATCH] kunit: flatten kunit_suite*** to kunit_suite** in executor
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 14, 2021 at 3:13 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Per [1], we might not need the array-of-array of kunit_suite's.
>
> This RFC patch previews the changes we'd make to the executor to
> accommodate that by making the executor automatically flatten the
> kunit_suite*** into a kunit_suite**.
>
> The test filtering support [2] added the largest dependency on the
> current kunit_suite*** layout, so this patch is based on that.
>
> It actually drastically simplifies the code, so it might be useful to
> keep the auto-flattening step until we actually make the change.
>
> [1] https://lore.kernel.org/linux-kselftest/101d12fc9250b7a445ff50a9e7a25cd74d0e16eb.camel@codeconstruct.com.au/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit&id=3b29021ddd10cfb6b2565c623595bd3b02036f33
>
> Cc: Jeremy Kerr <jk@codeconstruct.com.au>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

I really like this. My only real concern is that it's a little unclear
exactly what the resulting layout is, particularly as to what the
"make_suite_set" function does. It'd be nice to have some more
documentation, either as a comment on the function or a more detailed
commit message, which explicitly describes the old format (an array
(with start and end pointers) of NULL-terminated arrays of suites),
and the new format (a single, NULL-terminated array with both start
and end pointers).

Re: NULL termination. If we're already using both start and end
pointers, the NULL terminator seems useless. (And if we've got a NULL
terminator, why are we passing the end pointer around.) It's not
super-clear why we'd want both, though the comments in this reply do
clarify things a bit:
https://lore.kernel.org/linux-kselftest/CAGS_qxoziNGNVpsUfvUfOReADY0PdriV2gJJ7+LUzzd+7BU-Ow@mail.gmail.com/

Finally, if we do want a runtime way of adding suites to the
executor's list at runtime (which was suggested as a way of working
around some suites which might need extra, global, initialisation),
this might change how that'd have to be implemented a bit. I'm not too
worried about that, though: it's something that's probably better
served with something like a linked list of suite_sets or the like,
anyway.

In any case, I've tested this in the non-module case, and it seems to work fine.
Tested-by: David Gow <davidgow@google.com>

Cheers,
-- David
